Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CCA808BB7
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 16:24:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBGCo-0001NQ-Fq; Thu, 07 Dec 2023 10:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rBGCh-0001LA-EF; Thu, 07 Dec 2023 10:22:19 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rBGCd-0001AS-O8; Thu, 07 Dec 2023 10:22:18 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 912B94318B;
 Thu,  7 Dec 2023 16:22:12 +0100 (CET)
Message-ID: <c3e115ff-c143-4d1b-901c-6b386d012eac@proxmox.com>
Date: Thu, 7 Dec 2023 16:22:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 29/32] virtio-blk: implement BlockDevOps->drained_begin()
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Thomas Lamprecht <t.lamprecht@proxmox.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20230530163239.576632-1-kwolf@redhat.com>
 <20230530163239.576632-30-kwolf@redhat.com>
 <ee6374dc-c644-449f-b5d1-788695e1a83e@proxmox.com>
In-Reply-To: <ee6374dc-c644-449f-b5d1-788695e1a83e@proxmox.com>
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

Am 03.11.23 um 14:12 schrieb Fiona Ebner:
> Hi,
> 
> I ran into a strange issue where guest IO would get completely stuck
> during certain block jobs a while ago and finally managed to find a
> small reproducer [0]. I'm using a VM with virtio-blk-pci (or
> virtio-scsi-pci) with an iothread and running
> 
> fio --name=file --size=100M --direct=1 --rw=randwrite --bs=4k
> --ioengine=psync --numjobs=5 --runtime=1200 --time_based
> 
> in the guest. Then I'm issuing the QMP command with the reproducer in a
> loop. Usually, the guest IO will get stuck after about 1-3 minutes,
> sometimes fio can manage to continue with a lower speed for a while (but
> trying to Ctrl+C it or doing other IO in the guest will already be
> broken), which I guess could be a hint that it's an issue with notifiers?
> 
> Bisecting (to declare a commit good, I waited 10 minutes) led me to this
> patch, i.e. commit 1665d9326f ("virtio-blk: implement
> BlockDevOps->drained_begin()") and for SCSI, I verified that the issue
> similarly starts happening after 766aa2de0f ("virtio-scsi: implement
> BlockDevOps->drained_begin()").
> 
> Both issues are still present on current master (i.e. 1c98a821a2
> ("tests/qtest: Introduce tests for AMD/Xilinx Versal TRNG device"))
> 
> Happy to provide more information and hints about how to debug the issue
> further.
> 

I think I was finally able to get to the bottom of this and have a
plausible-sounding pet theory now. It involves the VirtIO notifier
optimization during poll mode.

Let's step through some debug prints I added. First number is always the
thread ID (I'm sorry that I used warn_report rather than proper tracing):

> 247050 nodefd 29 poll_set_started 1

The iothread starts poll mode for the node with fd 29 which is the
virtio host notifier.

> 247050 0x55e515185270 poll begin for vq
> 247050 0x55e515185270 setting notification for vq 0

virtio_queue_set_notification is called to disable notification.

> 247050 nodefd 29 poll_set_started 1 done
> 247050 0x55e515185270 handle vq suppress_notifications 0 num_reqs 1
> 247050 0x55e515185270 handle vq suppress_notifications 0 num_reqs 4

virtio-blk handling some requests, note that suppress_notifications is 0
because we are in poll mode.

> 247048 nodefd 29 addr 0x55e51496ed70 marking as deleted

Main thread marks the node for deletion when beginning drain, i.e.
detaches the host notifier.

> 247048 nodefd 29 addr 0x55e513cdcd20 is_new 1 adding node

Main thread adds a new node when ending drain, i.e. attaches the host
notifier.

> 247050 nodefd 29 addr 0x55e51496ed70 remove deleted handler

The iothread removes the handler marked for removal. In particular from
the node_poll list: QLIST_SAFE_REMOVE(node, node_poll);

> 247050 disabling poll mode before fdmon_ops->wait

This is just before the call to
poll_set_started(ctx, &ready_list, false)

Whoops!! Nobody ends poll mode for the node with fd 29, because the old
node was deleted from the node_poll list already and new node is not
part of it, i.e. nobody has started poll mode for the new node.

> 247050 0x55e515185270 handle vq suppress_notifications 0 num_reqs 0

fdmon_ops->wait() returns one last time (not sure why) but no actual
requests.

> 247050 disabling poll mode before fdmon_ops->wait

After this, the fdmon_ops->wait() (it's fdmon_poll_wait in my case) will
just wait forever (or until triggering QMP 'stop' and 'cont' which
restarts the dataplane).


A minimal workaround seems to be either calling
event_notifier_set(virtio_queue_get_host_notifier(vq));
or
virtio_queue_set_notification(vq, true);
in drainded_end (for both VirtIO SCSI/block).

But is this an actual issue with the AIO interface/implementation? Or
should it rather be considered a bug in the VirtIO SCSI/block drain
implementation, because of the notification optimization?

Best Regards,
Fiona

> 
> [0]:
> 
>> diff --git a/blockdev.c b/blockdev.c
>> index db2725fe74..bf2e0fc22c 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -2986,6 +2986,11 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>>      bool zero_target;
>>      int ret;
>>  
>> +    bdrv_drain_all_begin();
>> +    bdrv_drain_all_end();
>> +    return;
>> +
>> +
>>      bs = qmp_get_root_bs(arg->device, errp);
>>      if (!bs) {
>>          return;
> 
> 
> 


