Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B226B777A6D
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 16:21:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU6W6-0000py-4F; Thu, 10 Aug 2023 10:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qU6W2-0000o5-KO
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 10:19:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qU6Vz-00058i-Et
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 10:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691677189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/TynlECZjqQUFTE93/dvjgTUJxVIXdZLycGnyH3T+64=;
 b=LCOiPoAFujiZs1ziQv+Y/BUTDBM5KqyET6Hvau9MXsNTOTi/qTsjiM/le9eOIyW6+ukcmc
 5g20233nBAKFNysi910Vo4opn95yh7cBPdDJ6JzJph95tUbh5psrmR6DiC0vsCqs6dnECA
 IhhH5XJf5hqXOL3oWVwFpJm2EiOqWXc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-59qQWkVuMOyXKoDJRhV68g-1; Thu, 10 Aug 2023 10:19:48 -0400
X-MC-Unique: 59qQWkVuMOyXKoDJRhV68g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-317dff409dfso397593f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 07:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691677187; x=1692281987;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :content-language:references:cc:to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/TynlECZjqQUFTE93/dvjgTUJxVIXdZLycGnyH3T+64=;
 b=YTIaPHD4zkjQMWKmsESvW0YeFAo7eXL90edye0vDztajb2dIa4K7RVP6C5gESpRyJf
 rSzjBG02jK+ukI8sde6peMsGlld+L87snAqSpCb1oZ2sNBP8qorHrSXyBHvUyVPJaqUz
 XuUyNk5FiT19jOJPvkhraV6ugZsYxT0ewask9NpU8TTrx+044XWV1t5YZ7uMgvITn8W1
 /+rDVQo+myIC+w2haViGwaZlueASClErvB90JZQzXf24oAW82/J7OqPIoEH/2AjyX4YV
 6s3f2A2CdcK/p0K1PsBD4SkfamFXMoJXKowQrHtQLNjJZzN+I/KFRocUR9pZ6FhD6Ukd
 s7Aw==
X-Gm-Message-State: AOJu0YxcpzLb+yhw5zh1B2HCi9cLi9x0PSA2rpZ8Tq3ltvAm2NeyoFth
 rqWenLN3n3SdmQqrvAq6rA/sDAlhN1MJGfqGw4g4rh3ID9mu5qF+y0Z0kqn+ogJV6tRUtcE19xG
 dlhqqf6hMc+yq6TI=
X-Received: by 2002:adf:e342:0:b0:311:b18:9ca4 with SMTP id
 n2-20020adfe342000000b003110b189ca4mr1714238wrj.17.1691677187281; 
 Thu, 10 Aug 2023 07:19:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaJ1BVX/zwIwreeOa+QBHsbRgSDGyt4wowLX9257QvQ03B9FBLS9x8ciEMrjdTf5EivZeppg==
X-Received: by 2002:adf:e342:0:b0:311:b18:9ca4 with SMTP id
 n2-20020adfe342000000b003110b189ca4mr1714210wrj.17.1691677186761; 
 Thu, 10 Aug 2023 07:19:46 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 k19-20020a05600c479300b003fe1afb99b5sm2997810wmo.0.2023.08.10.07.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 07:19:46 -0700 (PDT)
Message-ID: <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
Date: Thu, 10 Aug 2023 16:19:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com> <ZNOti1OKN79t68jP@x1n>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
In-Reply-To: <ZNOti1OKN79t68jP@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.156, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

>> Most importantly, we won't be corrupting/touching the original file in any
>> case, because it is R/O.
>>
>> If we really want to be careful, we could clue that behavior to compat
>> machines. I'm not really sure yet if we really have to go down that path.
>>
>> Any other alternatives? I'd like to avoid new flags where not really
>> required.
> 
> I was just thinking of a new flag. :) So have you already discussed that
> possibility and decided that not a good idea?

Not really. I was briefly playing with that idea but already struggled 
to come up with a reasonable name :)

Less toggles and just have it working nice, if possible.

> 
> The root issue to me here is we actually have two resources (memory map of
> the process, and the file) but we only have one way to describe the
> permissions upon the two objects.  I'd think it makes a lot more sense if a
> new flag is added, when there's a need to differentiate the two.
> 
> Consider if you see a bunch of qemu instances with:
> 
>    -mem-path $RAM_FILE
> 
> On the same host, which can be as weird as it could be to me.. At least
> '-mem-path' looks still like a way to exclusively own a ram file for an
> instance. I hesitate the new fallback can confuse people too, while that's
> so far not the major use case.

Once I learned that this is not a MAP_SHARED mapping, I was extremely 
confused. For example, vhost-user with "-mem-path" will absolutely not 
work with "-mem-path", even though the documentation explicitly spells 
that out (I still have to send a patch to fix that).

I guess "-mem-path" was primarily only used to consume hugetlb. Even for 
tmpfs it will already result in a double memory consumption, just like 
when using -memory-backend-memfd,share=no.

I guess deprecating it was the right decision.

But memory-backend-file also defaults to "share=no" ... so the same 
default behavior unfortunately.

> 
> Nobody may really rely on any existing behavior of the failure, but
> changing existing behavior is just always not wanted.  The guideline here
> to me is: whether we want existing "-mem-path XXX" users to start using the
> fallback in general?  If it's "no", then maybe it implies a new flag is
> better?

I think we have the following options (there might be more)

1) This patch.

2) New flag for memory-backend-file. We already have "readonly" and 
"share=". I'm having a hard time coming up with a good name that really 
describes the subtle difference.

3) Glue behavior to the QEMU machine


For 3), one option would be to always open a COW file readonly (as 
Thiner originally proposed). We could leave "-mem-path" behavior alone 
and only change memory-backend-file semantics. If the COW file does 
*not* exist yet, we would refuse to create the file like patch 2+3 do. 
Therefore, no ftruncate() errors, and fallocate() errors would always 
happen.


What are your thoughts?

[...]

>>
>> [I'm curious at what point a filesystem will actually break COW. if it's
>> wired up to the writenotify infrastructure, it would happen when actually
>> writing to a page, not at mmap time. I know that filesystems use writenotify
>> for lazy allocation of disk blocks on file holes, maybe they also do that
>> for lazy allocation of disk blocks on COW]
> 
> I don't know either, but it definitely looks more promising and reasonable
> if the CoW only happens until being written, rather than being mapped RW.

That would be my best guess. But then, we have multiple pagecache pages 
point at the same disk block until COW happens ... maybe that's how it 
already works. Once I have some spare time, I might play with that.

-- 
Cheers,

David / dhildenb


