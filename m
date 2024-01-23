Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C10C838D17
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 12:13:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSEiL-0007N1-T6; Tue, 23 Jan 2024 06:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rSEiG-0007K2-6f; Tue, 23 Jan 2024 06:13:05 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rSEiC-0004ic-F8; Tue, 23 Jan 2024 06:13:03 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 7348349253;
 Tue, 23 Jan 2024 12:12:48 +0100 (CET)
Message-ID: <8a32f350-e69a-458a-be4e-1d3335e696c6@proxmox.com>
Date: Tue, 23 Jan 2024 12:12:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
References: <20231213211544.1601971-1-stefanha@redhat.com>
 <142d6078-1bb9-4116-ac87-7daac16f12d8@redhat.com>
 <016ac3d1-f6c1-48eb-a714-fb777dff7012@proxmox.com>
 <94db88e7-1f02-44dd-bc2c-3d9ccf1cce72@redhat.com>
 <bfc7b20c-2144-46e9-acbc-e726276c5a31@proxmox.com>
 <67a36617-9e61-4778-aebf-1e667cb51120@proxmox.com>
 <3bb5aa0e-ae0a-4fda-a5b5-1bfac86651ac@redhat.com>
 <e281e717-f416-47d2-aef4-d08b327122ef@redhat.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <e281e717-f416-47d2-aef4-d08b327122ef@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Am 22.01.24 um 18:52 schrieb Hanna Czenczek:
> On 22.01.24 18:41, Hanna Czenczek wrote:
>> On 05.01.24 15:30, Fiona Ebner wrote:
>>> Am 05.01.24 um 14:43 schrieb Fiona Ebner:
>>>> Am 03.01.24 um 14:35 schrieb Paolo Bonzini:
>>>>> On 1/3/24 12:40, Fiona Ebner wrote:
>>>>>> I'm happy to report that I cannot reproduce the CPU-usage-spike issue
>>>>>> with the patch, but I did run into an assertion failure when
>>>>>> trying to
>>>>>> verify that it fixes my original stuck-guest-IO issue. See below
>>>>>> for the
>>>>>> backtrace [0]. Hanna wrote in
>>>>>> https://issues.redhat.com/browse/RHEL-3934
>>>>>>
>>>>>>> I think it’s sufficient to simply call virtio_queue_notify_vq(vq)
>>>>>>> after the virtio_queue_aio_attach_host_notifier(vq, ctx) call,
>>>>>>> because
>>>>>>> both virtio-scsi’s and virtio-blk’s .handle_output() implementations
>>>>>>> acquire the device’s context, so this should be directly callable
>>>>>>> from
>>>>>>> any context.
>>>>>> I guess this is not true anymore now that the AioContext locking was
>>>>>> removed?
>>>>> Good point and, in fact, even before it was much safer to use
>>>>> virtio_queue_notify() instead.  Not only does it use the event
>>>>> notifier
>>>>> handler, but it also calls it in the right thread/AioContext just by
>>>>> doing event_notifier_set().
>>>>>
>>>> But with virtio_queue_notify() using the event notifier, the
>>>> CPU-usage-spike issue is present:
>>>>
>>>>>> Back to the CPU-usage-spike issue: I experimented around and it
>>>>>> doesn't
>>>>>> seem to matter whether I notify the virt queue before or after
>>>>>> attaching
>>>>>> the notifiers. But there's another functional difference. My patch
>>>>>> called virtio_queue_notify() which contains this block:
>>>>>>
>>>>>>>      if (vq->host_notifier_enabled) {
>>>>>>>          event_notifier_set(&vq->host_notifier);
>>>>>>>      } else if (vq->handle_output) {
>>>>>>>          vq->handle_output(vdev, vq);
>>>>>> In my testing, the first branch was taken, calling
>>>>>> event_notifier_set().
>>>>>> Hanna's patch uses virtio_queue_notify_vq() and there,
>>>>>> vq->handle_output() will be called. That seems to be the relevant
>>>>>> difference regarding the CPU-usage-spike issue.
>>>> I should mention that this is with a VirtIO SCSI disk. I also attempted
>>>> to reproduce the CPU-usage-spike issue with a VirtIO block disk, but
>>>> didn't manage yet.
>>>>
>>>> What I noticed is that in virtio_queue_host_notifier_aio_poll(), one of
>>>> the queues (but only one) will always show as nonempty. And then,
>>>> run_poll_handlers_once() will always detect progress which explains the
>>>> CPU usage.
>>>>
>>>> The following shows
>>>> 1. vq address
>>>> 2. number of times vq was passed to
>>>> virtio_queue_host_notifier_aio_poll()
>>>> 3. number of times the result of virtio_queue_host_notifier_aio_poll()
>>>> was true for the vq
>>>>
>>>>> 0x555fd93f9c80 17162000 0
>>>>> 0x555fd93f9e48 17162000 6
>>>>> 0x555fd93f9ee0 17162000 0
>>>>> 0x555fd93f9d18 17162000 17162000
>>>>> 0x555fd93f9db0 17162000 0
>>>>> 0x555fd93f9f78 17162000 0
>>>> And for the problematic one, the reason it is seen as nonempty is:
>>>>
>>>>> 0x555fd93f9d18 shadow_avail_idx 8 last_avail_idx 0
>>> vring_avail_idx(vq) also gives 8 here. This is the vs->event_vq and
>>> s->events_dropped is false in my testing, so
>>> virtio_scsi_handle_event_vq() doesn't do anything.
>>>
>>>> Those values stay like this while the call counts above increase.
>>>>
>>>> So something going wrong with the indices when the event notifier is
>>>> set
>>>> from QEMU side (in the main thread)?
>>>>
>>>> The guest is Debian 12 with a 6.1 kernel.
>>
>> So, trying to figure out a new RFC version:
>>
>> About the stack trace you, Fiona, posted:  As far as I understand,
>> that happens because virtio_blk_drained_end() calling
>> virtio_queue_notify_vq() wasn’t safe after all, and instead we need to
>> use virtio_queue_notify().  Right?
>>

AFAICT, yes. In particular, after 4f36b13847 ("scsi: remove AioContext
locking"), the AioContext is not acquired by
virtio_scsi_handle_{cmd,ctrl,event} anymore.

>> However, you say using virtio_queue_notify() instead causes busy loops
>> of doing nothing in virtio-scsi (what you describe above). I mean,
>> better than a crash, but, you know. :)

Yes, that happens for me when using virtio_queue_notify(), i.e.

> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 690aceec45..8cdf04ac2d 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -1166,7 +1166,11 @@ static void virtio_scsi_drained_end(SCSIBus *bus)
>  
>      for (uint32_t i = 0; i < total_queues; i++) {
>          VirtQueue *vq = virtio_get_queue(vdev, i);
> +        if (!virtio_queue_get_notification(vq)) {
> +            virtio_queue_set_notification(vq, true);
> +        }
>          virtio_queue_aio_attach_host_notifier(vq, s->ctx);
> +        virtio_queue_notify(vdev, i);
>      }
>  }
>  


>>
>> I don’t know have any prior knowledge about the event handling,
>> unfortunately.  The fact that 8 buffers are available but we don’t use
>> any sounds OK to me; as far as I understand, we only use those buffers
>> if we have any events to push into them, so as long as we don’t, we
>> won’t.  Question is, should we not have its poll handler return false
>> if we don’t have any events (i.e. events_dropped is false)?  Would
>> that solve it?
> 
> Or actually, maybe we could just skip the virtio_queue_notify() call for
> the event vq?  I.e. have it be `if (vq !=
> VIRTIO_SCSI_COMMON(s)->event_vq) { virtio_queue_notify(vdev, i); }`?

That seems to avoid the CPU-usage-spike issue :)

> I wouldn’t like that very much, (a) because this would make it slightly
> cumbersome to put that into virtio_queue_aio_attach_host_notifier*(),
> and (b) in case that does fix it, I do kind of feel like the real
> problem is that we use virtio_queue_host_notifier_aio_poll() for the
> event vq, which tells the polling code to poll whenever the vq is
> non-empty, but we (AFAIU) expect the event vq to be non-empty all the time.
> 

AFAIU, (at least in my testing) it's only non-empty after it was
notified via virtio_scsi_drained_end() once. But it's hard to tell,
because it seems that the poll callback is only called after the first
drain. I noticed poll_set_started() is not called, because
ctx->fdmon_ops->need_wait(ctx) was true, i.e. ctx->poll_disable_cnt was
positive (I'm using fdmon_poll). I then found this is because of the
notifier for the event vq, being attached with

> virtio_queue_aio_attach_host_notifier_no_poll(vs->event_vq, s->ctx);

in virtio_scsi_dataplane_start(). But in virtio_scsi_drained_end() it is
attached with virtio_queue_aio_attach_host_notifier() instead of the
_no_poll() variant. So that might be the actual issue here?

From a quick test, I cannot see the CPU-usage-spike issue with the
following either:

> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 690aceec45..ba1ab8e410 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -1166,7 +1166,15 @@ static void virtio_scsi_drained_end(SCSIBus *bus)
>  
>      for (uint32_t i = 0; i < total_queues; i++) {
>          VirtQueue *vq = virtio_get_queue(vdev, i);
> -        virtio_queue_aio_attach_host_notifier(vq, s->ctx);
> +        if (!virtio_queue_get_notification(vq)) {
> +            virtio_queue_set_notification(vq, true);
> +        }
> +        if (vq == VIRTIO_SCSI_COMMON(s)->event_vq) {
> +            virtio_queue_aio_attach_host_notifier_no_poll(vq, s->ctx);
> +        } else {
> +            virtio_queue_aio_attach_host_notifier(vq, s->ctx);
> +        }
> +        virtio_queue_notify(vdev, i);
>      }
>  }

Best Regards,
Fiona


