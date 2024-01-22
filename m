Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A506836DF2
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 18:41:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRyIq-000107-M1; Mon, 22 Jan 2024 12:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rRyIo-0000yU-LO
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:41:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rRyIm-0004VW-Ln
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705945299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bhzcNusFhE3ZbWvRuVLZG9DrxNB0DtMuGCg7FqA16K8=;
 b=d5f+L8ZAtQjNpRr7hPY3mSAsEnMIgMmFYrvsaTnfWhdSTmAEkZGRlnvL8xYGQMqnYP03YE
 ybw7wwPnETcv9evbSm8Q6Dor72xpGpHLVz5p5/DsIvYx6Rk0Y62koakeESydybRN6DiS0k
 L8tg4fMDNeDUiaw+KyPHTPrhDiF21TM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-mcVRedAFO1C782DFworukg-1; Mon, 22 Jan 2024 12:41:37 -0500
X-MC-Unique: mcVRedAFO1C782DFworukg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33932e8b3e6so945692f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 09:41:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705945297; x=1706550097;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bhzcNusFhE3ZbWvRuVLZG9DrxNB0DtMuGCg7FqA16K8=;
 b=djiknkMIULeLtZpAQZ1z+DG/rKi+OYTrS6dfIQdky9WwKN5ZLSwWjb+0KdCWOKezLf
 eUSNH4kjDvFyrvOl5A3qScWALjmiogxNI+Cgo1Kua0ZiljbGFS7ArnDlGMZXax9SOu4Q
 MZlER35rj3GP+bO8/5++ZVQUA0+Cik0rfaPsZxjdYv++kMD7k4Gvig/9lKZz3bpPGzLK
 /ESA32oylTiO1eQ+OjZQkxCvhVtUjTcB3udMsz+v0b/FxemGZvitiVbiE23b8PX2Bn1w
 RkVcc0ZbAmZlzFQaBvdY5iqw5CAjJSJ+t4CwEnHtW+8Vz98Eq5cjQVJZMvTkFEC74VWu
 oGsA==
X-Gm-Message-State: AOJu0YwHN2anCcpO2znZmGkZu5eyTXzLv+mizY9llMSH4gP2JlHf7ci5
 n06elX3EoGNDBFAMkZcCG4S8K9EUiuQF2UldKaAV0GRr2Q/XZY4qTri7qKEJDBXEhqXyMHhKWyE
 55F2L4BfgDsEYYF0GBE71QTvPQubR/YuROlbA55VOzUs09rYb6Lat
X-Received: by 2002:a05:6000:cb:b0:339:3f40:ffc9 with SMTP id
 q11-20020a05600000cb00b003393f40ffc9mr466070wrx.134.1705945296823; 
 Mon, 22 Jan 2024 09:41:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAvwyl3kk/GjfzCBfuwCaPqbaoePxcs90Qd0D3m/6KehElFmBENsRx2F2kwiEHm2w+f7fqlg==
X-Received: by 2002:a05:6000:cb:b0:339:3f40:ffc9 with SMTP id
 q11-20020a05600000cb00b003393f40ffc9mr466062wrx.134.1705945296515; 
 Mon, 22 Jan 2024 09:41:36 -0800 (PST)
Received: from ?IPV6:2003:cf:d73b:4117:ba1b:6e10:5c4e:878?
 (p200300cfd73b4117ba1b6e105c4e0878.dip0.t-ipconnect.de.
 [2003:cf:d73b:4117:ba1b:6e10:5c4e:878])
 by smtp.gmail.com with ESMTPSA id
 cp9-20020a056000400900b003392ded41c7sm4960923wrb.39.2024.01.22.09.41.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 09:41:35 -0800 (PST)
Message-ID: <3bb5aa0e-ae0a-4fda-a5b5-1bfac86651ac@redhat.com>
Date: Mon, 22 Jan 2024 18:41:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
Content-Language: en-US
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
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <67a36617-9e61-4778-aebf-1e667cb51120@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 05.01.24 15:30, Fiona Ebner wrote:
> Am 05.01.24 um 14:43 schrieb Fiona Ebner:
>> Am 03.01.24 um 14:35 schrieb Paolo Bonzini:
>>> On 1/3/24 12:40, Fiona Ebner wrote:
>>>> I'm happy to report that I cannot reproduce the CPU-usage-spike issue
>>>> with the patch, but I did run into an assertion failure when trying to
>>>> verify that it fixes my original stuck-guest-IO issue. See below for the
>>>> backtrace [0]. Hanna wrote in https://issues.redhat.com/browse/RHEL-3934
>>>>
>>>>> I think it’s sufficient to simply call virtio_queue_notify_vq(vq)
>>>>> after the virtio_queue_aio_attach_host_notifier(vq, ctx) call, because
>>>>> both virtio-scsi’s and virtio-blk’s .handle_output() implementations
>>>>> acquire the device’s context, so this should be directly callable from
>>>>> any context.
>>>> I guess this is not true anymore now that the AioContext locking was
>>>> removed?
>>> Good point and, in fact, even before it was much safer to use
>>> virtio_queue_notify() instead.  Not only does it use the event notifier
>>> handler, but it also calls it in the right thread/AioContext just by
>>> doing event_notifier_set().
>>>
>> But with virtio_queue_notify() using the event notifier, the
>> CPU-usage-spike issue is present:
>>
>>>> Back to the CPU-usage-spike issue: I experimented around and it doesn't
>>>> seem to matter whether I notify the virt queue before or after attaching
>>>> the notifiers. But there's another functional difference. My patch
>>>> called virtio_queue_notify() which contains this block:
>>>>
>>>>>      if (vq->host_notifier_enabled) {
>>>>>          event_notifier_set(&vq->host_notifier);
>>>>>      } else if (vq->handle_output) {
>>>>>          vq->handle_output(vdev, vq);
>>>> In my testing, the first branch was taken, calling event_notifier_set().
>>>> Hanna's patch uses virtio_queue_notify_vq() and there,
>>>> vq->handle_output() will be called. That seems to be the relevant
>>>> difference regarding the CPU-usage-spike issue.
>> I should mention that this is with a VirtIO SCSI disk. I also attempted
>> to reproduce the CPU-usage-spike issue with a VirtIO block disk, but
>> didn't manage yet.
>>
>> What I noticed is that in virtio_queue_host_notifier_aio_poll(), one of
>> the queues (but only one) will always show as nonempty. And then,
>> run_poll_handlers_once() will always detect progress which explains the
>> CPU usage.
>>
>> The following shows
>> 1. vq address
>> 2. number of times vq was passed to virtio_queue_host_notifier_aio_poll()
>> 3. number of times the result of virtio_queue_host_notifier_aio_poll()
>> was true for the vq
>>
>>> 0x555fd93f9c80 17162000 0
>>> 0x555fd93f9e48 17162000 6
>>> 0x555fd93f9ee0 17162000 0
>>> 0x555fd93f9d18 17162000 17162000
>>> 0x555fd93f9db0 17162000 0
>>> 0x555fd93f9f78 17162000 0
>> And for the problematic one, the reason it is seen as nonempty is:
>>
>>> 0x555fd93f9d18 shadow_avail_idx 8 last_avail_idx 0
> vring_avail_idx(vq) also gives 8 here. This is the vs->event_vq and
> s->events_dropped is false in my testing, so
> virtio_scsi_handle_event_vq() doesn't do anything.
>
>> Those values stay like this while the call counts above increase.
>>
>> So something going wrong with the indices when the event notifier is set
>> from QEMU side (in the main thread)?
>>
>> The guest is Debian 12 with a 6.1 kernel.

So, trying to figure out a new RFC version:

About the stack trace you, Fiona, posted:  As far as I understand, that 
happens because virtio_blk_drained_end() calling 
virtio_queue_notify_vq() wasn’t safe after all, and instead we need to 
use virtio_queue_notify().  Right?

However, you say using virtio_queue_notify() instead causes busy loops 
of doing nothing in virtio-scsi (what you describe above).  I mean, 
better than a crash, but, you know. :)

I don’t know have any prior knowledge about the event handling, 
unfortunately.  The fact that 8 buffers are available but we don’t use 
any sounds OK to me; as far as I understand, we only use those buffers 
if we have any events to push into them, so as long as we don’t, we 
won’t.  Question is, should we not have its poll handler return false if 
we don’t have any events (i.e. events_dropped is false)?  Would that 
solve it?

Hanna


