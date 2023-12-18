Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6695816E23
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 13:43:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFCwT-0004kP-Sx; Mon, 18 Dec 2023 07:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rFCwP-0004js-0q; Mon, 18 Dec 2023 07:41:49 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rFCwM-0001FF-LT; Mon, 18 Dec 2023 07:41:48 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 55C8D480B4;
 Mon, 18 Dec 2023 13:41:43 +0100 (CET)
Message-ID: <61c149da-ee22-418b-8575-b128b6836e38@proxmox.com>
Date: Mon, 18 Dec 2023 13:41:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, pbonzini@redhat.com, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>
References: <20231213211544.1601971-1-stefanha@redhat.com>
 <ba257408-5fb2-41d3-8b43-297ebcd312ea@proxmox.com>
 <20231214195352.GB1645604@fedora>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20231214195352.GB1645604@fedora>
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

Am 14.12.23 um 20:53 schrieb Stefan Hajnoczi:
> 
> I will still try the other approach that Hanna and Paolo have suggested.
> It seems more palatable. I will send a v2.
> 

FYI, what I already tried downstream (for VirtIO SCSI):

> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 9c751bf296..a6449b04d0 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -1166,6 +1166,8 @@ static void virtio_scsi_drained_end(SCSIBus *bus)
>  
>      for (uint32_t i = 0; i < total_queues; i++) {
>          VirtQueue *vq = virtio_get_queue(vdev, i);
> +        virtio_queue_set_notification(vq, 1);
> +        virtio_queue_notify(vdev, i);
>          virtio_queue_aio_attach_host_notifier(vq, s->ctx);
>      }
>  }

But this introduces an issue where e.g. a 'backup' QMP command would put
the iothread into a bad state. After the command, whenever the guest
issues IO, the thread will temporarily spike to using 100% CPU. Using
QMP stop+cont is a way to make it go back to normal.

I think it's because of nested drains, because when additionally
checking that the drain count is zero and only executing the loop then,
that issue doesn't seem to manifest, i.e.:

> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 9c751bf296..d22c586b38 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -1164,9 +1164,13 @@ static void virtio_scsi_drained_end(SCSIBus *bus)
>          return;
>      }
>  
> -    for (uint32_t i = 0; i < total_queues; i++) {
> -        VirtQueue *vq = virtio_get_queue(vdev, i);
> -        virtio_queue_aio_attach_host_notifier(vq, s->ctx);
> +    if (s->bus.drain_count == 0) {
> +        for (uint32_t i = 0; i < total_queues; i++) {
> +            VirtQueue *vq = virtio_get_queue(vdev, i);
> +            virtio_queue_set_notification(vq, 1);
> +            virtio_queue_notify(vdev, i);
> +            virtio_queue_aio_attach_host_notifier(vq, s->ctx);
> +        }
>      }
>  }
>  

Best Regards,
Fiona


