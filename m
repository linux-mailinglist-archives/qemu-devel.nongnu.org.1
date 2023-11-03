Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A62F47E038C
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 14:13:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qytyG-0002JZ-Oa; Fri, 03 Nov 2023 09:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qytyD-0002JA-LI; Fri, 03 Nov 2023 09:12:17 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qytyB-0006pi-SM; Fri, 03 Nov 2023 09:12:17 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A58F3442A6;
 Fri,  3 Nov 2023 14:12:05 +0100 (CET)
Message-ID: <ee6374dc-c644-449f-b5d1-788695e1a83e@proxmox.com>
Date: Fri, 3 Nov 2023 14:12:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 29/32] virtio-blk: implement BlockDevOps->drained_begin()
Content-Language: en-US
To: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Thomas Lamprecht <t.lamprecht@proxmox.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20230530163239.576632-1-kwolf@redhat.com>
 <20230530163239.576632-30-kwolf@redhat.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20230530163239.576632-30-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi,

Am 30.05.23 um 18:32 schrieb Kevin Wolf:
> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Detach ioeventfds during drained sections to stop I/O submission from
> the guest. virtio-blk is no longer reliant on aio_disable_external()
> after this patch. This will allow us to remove the
> aio_disable_external() API once all other code that relies on it is
> converted.
> 
> Take extra care to avoid attaching/detaching ioeventfds if the data
> plane is started/stopped during a drained section. This should be rare,
> but maybe the mirror block job can trigger it.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-Id: <20230516190238.8401-18-stefanha@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

I ran into a strange issue where guest IO would get completely stuck
during certain block jobs a while ago and finally managed to find a
small reproducer [0]. I'm using a VM with virtio-blk-pci (or
virtio-scsi-pci) with an iothread and running

fio --name=file --size=100M --direct=1 --rw=randwrite --bs=4k
--ioengine=psync --numjobs=5 --runtime=1200 --time_based

in the guest. Then I'm issuing the QMP command with the reproducer in a
loop. Usually, the guest IO will get stuck after about 1-3 minutes,
sometimes fio can manage to continue with a lower speed for a while (but
trying to Ctrl+C it or doing other IO in the guest will already be
broken), which I guess could be a hint that it's an issue with notifiers?

Bisecting (to declare a commit good, I waited 10 minutes) led me to this
patch, i.e. commit 1665d9326f ("virtio-blk: implement
BlockDevOps->drained_begin()") and for SCSI, I verified that the issue
similarly starts happening after 766aa2de0f ("virtio-scsi: implement
BlockDevOps->drained_begin()").

Both issues are still present on current master (i.e. 1c98a821a2
("tests/qtest: Introduce tests for AMD/Xilinx Versal TRNG device"))

Happy to provide more information and hints about how to debug the issue
further.

Best Regards,
Fiona

[0]:

> diff --git a/blockdev.c b/blockdev.c
> index db2725fe74..bf2e0fc22c 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2986,6 +2986,11 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>      bool zero_target;
>      int ret;
>  
> +    bdrv_drain_all_begin();
> +    bdrv_drain_all_end();
> +    return;
> +
> +
>      bs = qmp_get_root_bs(arg->device, errp);
>      if (!bs) {
>          return;


