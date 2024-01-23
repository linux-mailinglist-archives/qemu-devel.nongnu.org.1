Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5F4838D29
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 12:16:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSElF-0000vz-6o; Tue, 23 Jan 2024 06:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rSEl3-0000v5-4y
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:16:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rSEl0-0005HH-Sh
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706008554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+tdW5IQnyDOdCUVJs564/bKEX/jOv2MUB3st81uqO9E=;
 b=YnAD0fuTg5BUZ6yLsqdyp95KO51yPvWS1EojoQH2oe5uRA10ZYdq8gl2+BnIk2/0FPcJVx
 mR3Y3CD15JOnQCqEqtEy4KNE3ZGqglesa65MPvegHg/zkdTHFjw2C+6TKuix7ufXGE6Uoa
 xmCFm2eegQytRPQVepTfVh8F2z5tnag=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-rT0IyfDQNZS5DjkQ4i-lTA-1; Tue, 23 Jan 2024 06:15:52 -0500
X-MC-Unique: rT0IyfDQNZS5DjkQ4i-lTA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33927b1fac7so1645794f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 03:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706008552; x=1706613352;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+tdW5IQnyDOdCUVJs564/bKEX/jOv2MUB3st81uqO9E=;
 b=EnfUqR2614JhyrvRLFZ0XDvcKH5ZJCaZoGf7WzS73yevC0HbqwQHS6dUnQLaQdU39t
 uv434+Znj208CO6SHGqAYRKkJz3GxpZ5fKIPqZ0tVYdW/SgUOTBVZ86FQJAvGl4RZkxR
 xYemhwc+9HB8wB7ZKjWHYiWGO85xTHh9nOcLWDwYjeVEMf7U0pZHbdeuDaLM0kLkZtaU
 kmodUbIip0Emyy0DZbdhiez97nHjZhVziOAm/BFxyzJrA6EZ8B0V1njUtzMBn7jcheQZ
 QyvY3BFRO9d6O9DaVHLGRWS9+U+bjtYMqiO8WCK5tdQ5SjgPTZWACgRaHtYWXToUeerY
 zXvg==
X-Gm-Message-State: AOJu0YwfjFpCaTJUluOY9vheBrnywQseLgvKRDokb+W7+eXPvoyUwV3n
 xm9SfC2LO4hXzyV6sw6+Sc4UVWKP/6xgRBvNkDsYwYOvmXgHaxB1fUg+Tn1CB1JU32h6NjhIDFP
 0nWK1KKRsFrnJmXNAatbM3mKQX8+Q9ROjMZa6NHKNsb4wgPlh8k6W
X-Received: by 2002:a05:6000:1542:b0:339:2bbe:eed6 with SMTP id
 2-20020a056000154200b003392bbeeed6mr3221635wry.2.1706008551580; 
 Tue, 23 Jan 2024 03:15:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn64RpF9bhHBAcBn+X0tBNFq4X0hje05yZR9vChnPcxHdzbWnfrbhySd/S4XvO/GUIE4WHoQ==
X-Received: by 2002:a05:6000:1542:b0:339:2bbe:eed6 with SMTP id
 2-20020a056000154200b003392bbeeed6mr3221621wry.2.1706008551128; 
 Tue, 23 Jan 2024 03:15:51 -0800 (PST)
Received: from ?IPV6:2003:cf:d73b:4143:2bf6:228a:1b7a:e384?
 (p200300cfd73b41432bf6228a1b7ae384.dip0.t-ipconnect.de.
 [2003:cf:d73b:4143:2bf6:228a:1b7a:e384])
 by smtp.gmail.com with ESMTPSA id
 e30-20020a5d595e000000b00339237a2752sm9866809wri.33.2024.01.23.03.15.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 03:15:50 -0800 (PST)
Message-ID: <d863ff99-3bcc-4b36-8058-395883caf34d@redhat.com>
Date: Tue, 23 Jan 2024 12:15:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
From: Hanna Czenczek <hreitz@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
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
Content-Language: en-US
In-Reply-To: <e281e717-f416-47d2-aef4-d08b327122ef@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 22.01.24 18:52, Hanna Czenczek wrote:
> On 22.01.24 18:41, Hanna Czenczek wrote:
>> On 05.01.24 15:30, Fiona Ebner wrote:
>>> Am 05.01.24 um 14:43 schrieb Fiona Ebner:
>>>> Am 03.01.24 um 14:35 schrieb Paolo Bonzini:
>>>>> On 1/3/24 12:40, Fiona Ebner wrote:
>>>>>> I'm happy to report that I cannot reproduce the CPU-usage-spike 
>>>>>> issue
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
>>>>>>> both virtio-scsi’s and virtio-blk’s .handle_output() 
>>>>>>> implementations
>>>>>>> acquire the device’s context, so this should be directly 
>>>>>>> callable from
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
>>>>>>> event_notifier_set(&vq->host_notifier);
>>>>>>>      } else if (vq->handle_output) {
>>>>>>>          vq->handle_output(vdev, vq);
>>>>>> In my testing, the first branch was taken, calling 
>>>>>> event_notifier_set().
>>>>>> Hanna's patch uses virtio_queue_notify_vq() and there,
>>>>>> vq->handle_output() will be called. That seems to be the relevant
>>>>>> difference regarding the CPU-usage-spike issue.
>>>> I should mention that this is with a VirtIO SCSI disk. I also 
>>>> attempted
>>>> to reproduce the CPU-usage-spike issue with a VirtIO block disk, but
>>>> didn't manage yet.
>>>>
>>>> What I noticed is that in virtio_queue_host_notifier_aio_poll(), 
>>>> one of
>>>> the queues (but only one) will always show as nonempty. And then,
>>>> run_poll_handlers_once() will always detect progress which explains 
>>>> the
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
>>>> So something going wrong with the indices when the event notifier 
>>>> is set
>>>> from QEMU side (in the main thread)?
>>>>
>>>> The guest is Debian 12 with a 6.1 kernel.
>>
>> So, trying to figure out a new RFC version:
>>
>> About the stack trace you, Fiona, posted:  As far as I understand, 
>> that happens because virtio_blk_drained_end() calling 
>> virtio_queue_notify_vq() wasn’t safe after all, and instead we need 
>> to use virtio_queue_notify().  Right?
>>
>> However, you say using virtio_queue_notify() instead causes busy 
>> loops of doing nothing in virtio-scsi (what you describe above). I 
>> mean, better than a crash, but, you know. :)
>>
>> I don’t know have any prior knowledge about the event handling, 
>> unfortunately.  The fact that 8 buffers are available but we don’t 
>> use any sounds OK to me; as far as I understand, we only use those 
>> buffers if we have any events to push into them, so as long as we 
>> don’t, we won’t.  Question is, should we not have its poll handler 
>> return false if we don’t have any events (i.e. events_dropped is 
>> false)?  Would that solve it?
>
> Or actually, maybe we could just skip the virtio_queue_notify() call 
> for the event vq?  I.e. have it be `if (vq != 
> VIRTIO_SCSI_COMMON(s)->event_vq) { virtio_queue_notify(vdev, i); }`?  
> I wouldn’t like that very much, (a) because this would make it 
> slightly cumbersome to put that into 
> virtio_queue_aio_attach_host_notifier*(), and (b) in case that does 
> fix it, I do kind of feel like the real problem is that we use 
> virtio_queue_host_notifier_aio_poll() for the event vq, which tells 
> the polling code to poll whenever the vq is non-empty, but we (AFAIU) 
> expect the event vq to be non-empty all the time.

Turns out there was commit 38738f7dbbda90fbc161757b7f4be35b52205552 
(“virtio-scsi: don't waste CPU polling the event virtqueue”) by Stefan, 
which specifically intended to not use 
virtio_queue_host_notifier_aio_poll() for the event vq.  I think the 
problem is that virtio_scsi_drained_end() should have taken care to use 
virtio_queue_aio_attach_host_notifier_no_poll() for the event vq.

If we do that, I think running virtio_queue_notify() on the event vq too 
should be reasonable.  We still want to check whether there are new 
buffers available in case we have events_dropped.  I don’t know whether 
it’s really necessary, but without virtio_queue_host_notifier_aio_poll() 
installed, it shouldn’t hurt.

Hanna


