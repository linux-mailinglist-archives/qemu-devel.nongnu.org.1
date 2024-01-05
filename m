Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15300825557
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 15:32:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLlDw-00029N-Ci; Fri, 05 Jan 2024 09:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rLlDr-00028i-Sk; Fri, 05 Jan 2024 09:30:55 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rLlDp-0001gP-Lr; Fri, 05 Jan 2024 09:30:55 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id E66AE48FDD;
 Fri,  5 Jan 2024 15:30:49 +0100 (CET)
Message-ID: <67a36617-9e61-4778-aebf-1e667cb51120@proxmox.com>
Date: Fri, 5 Jan 2024 15:30:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
References: <20231213211544.1601971-1-stefanha@redhat.com>
 <142d6078-1bb9-4116-ac87-7daac16f12d8@redhat.com>
 <016ac3d1-f6c1-48eb-a714-fb777dff7012@proxmox.com>
 <94db88e7-1f02-44dd-bc2c-3d9ccf1cce72@redhat.com>
 <bfc7b20c-2144-46e9-acbc-e726276c5a31@proxmox.com>
In-Reply-To: <bfc7b20c-2144-46e9-acbc-e726276c5a31@proxmox.com>
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

Am 05.01.24 um 14:43 schrieb Fiona Ebner:
> Am 03.01.24 um 14:35 schrieb Paolo Bonzini:
>> On 1/3/24 12:40, Fiona Ebner wrote:
>>> I'm happy to report that I cannot reproduce the CPU-usage-spike issue
>>> with the patch, but I did run into an assertion failure when trying to
>>> verify that it fixes my original stuck-guest-IO issue. See below for the
>>> backtrace [0]. Hanna wrote in https://issues.redhat.com/browse/RHEL-3934
>>>
>>>> I think it’s sufficient to simply call virtio_queue_notify_vq(vq)
>>>> after the virtio_queue_aio_attach_host_notifier(vq, ctx) call, because
>>>> both virtio-scsi’s and virtio-blk’s .handle_output() implementations
>>>> acquire the device’s context, so this should be directly callable from
>>>> any context.
>>>
>>> I guess this is not true anymore now that the AioContext locking was
>>> removed?
>>
>> Good point and, in fact, even before it was much safer to use
>> virtio_queue_notify() instead.  Not only does it use the event notifier
>> handler, but it also calls it in the right thread/AioContext just by
>> doing event_notifier_set().
>>
> 
> But with virtio_queue_notify() using the event notifier, the
> CPU-usage-spike issue is present:
> 
>>> Back to the CPU-usage-spike issue: I experimented around and it doesn't
>>> seem to matter whether I notify the virt queue before or after attaching
>>> the notifiers. But there's another functional difference. My patch
>>> called virtio_queue_notify() which contains this block:
>>>
>>>>     if (vq->host_notifier_enabled) {
>>>>         event_notifier_set(&vq->host_notifier);
>>>>     } else if (vq->handle_output) {
>>>>         vq->handle_output(vdev, vq);
>>>
>>> In my testing, the first branch was taken, calling event_notifier_set().
>>> Hanna's patch uses virtio_queue_notify_vq() and there,
>>> vq->handle_output() will be called. That seems to be the relevant
>>> difference regarding the CPU-usage-spike issue.
> 
> I should mention that this is with a VirtIO SCSI disk. I also attempted
> to reproduce the CPU-usage-spike issue with a VirtIO block disk, but
> didn't manage yet.
> 
> What I noticed is that in virtio_queue_host_notifier_aio_poll(), one of
> the queues (but only one) will always show as nonempty. And then,
> run_poll_handlers_once() will always detect progress which explains the
> CPU usage.
> 
> The following shows
> 1. vq address
> 2. number of times vq was passed to virtio_queue_host_notifier_aio_poll()
> 3. number of times the result of virtio_queue_host_notifier_aio_poll()
> was true for the vq
> 
>> 0x555fd93f9c80 17162000 0
>> 0x555fd93f9e48 17162000 6
>> 0x555fd93f9ee0 17162000 0
>> 0x555fd93f9d18 17162000 17162000
>> 0x555fd93f9db0 17162000 0
>> 0x555fd93f9f78 17162000 0
> 
> And for the problematic one, the reason it is seen as nonempty is:
> 
>> 0x555fd93f9d18 shadow_avail_idx 8 last_avail_idx 0
> 

vring_avail_idx(vq) also gives 8 here. This is the vs->event_vq and
s->events_dropped is false in my testing, so
virtio_scsi_handle_event_vq() doesn't do anything.

> Those values stay like this while the call counts above increase.
> 
> So something going wrong with the indices when the event notifier is set
> from QEMU side (in the main thread)?
> 
> The guest is Debian 12 with a 6.1 kernel.

Best Regards,
Fiona


