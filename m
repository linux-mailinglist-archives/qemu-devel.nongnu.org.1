Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC32977F811
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 15:49:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWdMk-0003hL-0E; Thu, 17 Aug 2023 09:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWdMb-0003cF-Ec
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:48:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWdMZ-0003d8-79
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692280113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJJIL+Vx+SxrgV8j/tgfzVPDZiaqx02xYC5ApwfsI50=;
 b=aW9VUxPeelJHD6SXZaWb0/3lipzN0BTj+Qpv+J+z9TfH4nT0Lo6dAy9tyQ3W0GDyVCc6fH
 yIJUJ+Plv9ZjRdgDi5Q4tme7GJ+2eAUCTdqC4w1KYnAH5oohH46KpwppsB7xrJA4XOHP5U
 G7gfNJ3n646RrHffeU0UxCC2wXymfjE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-xnejoEoVN8OEmIjpHVFGpg-1; Thu, 17 Aug 2023 09:48:32 -0400
X-MC-Unique: xnejoEoVN8OEmIjpHVFGpg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe2477947eso48649595e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 06:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692280111; x=1692884911;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uJJIL+Vx+SxrgV8j/tgfzVPDZiaqx02xYC5ApwfsI50=;
 b=YyN7mkHMuEyl7jdrUyTK7vriNKExG7fEIQjYRq1RhS7lkH0w6/zK6LHCZHAPI06XnW
 S5CAQpjhdJQTN6d7CuEJr3l1vMMtTBO9O/o119SidJQoh5qxgGW2+CN3SuLpWmDG39fZ
 fe3Ui93sxgQ4wrhBsmnijyxwQGPpg2HBDTzfVYPG0Y9MGIxyuj2xnfPvCaxDSeO9K4DW
 3sffptpqCBUzQlLHnWLE3DI8BXIigOLOj/kk5b7vk21w4V1EnBoxBbyh99nMLrPGFN6Z
 vxLMLNaCap2qUa3ZL4S2syfXOEv4z2A2oxlvHrfGh5Y+VjVibsB+i//knCK8wjKBrHYT
 Ndtg==
X-Gm-Message-State: AOJu0Yxdm/TBY2+a0dz25Y0q34wtvJsZi9oZ4501P/bZtTjuLYIfRKt5
 lv2layUA+79iah1DYtXWs46WCgT/Mqf3KdiN0UdOtJTPTvNoIsmRQzIBkwq1NTP2eCGj/7fcFn0
 IWetQgn8t8ewHXys=
X-Received: by 2002:a05:600c:228c:b0:3fe:16c8:65fa with SMTP id
 12-20020a05600c228c00b003fe16c865famr3994321wmf.4.1692280111414; 
 Thu, 17 Aug 2023 06:48:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs0Han1gMJUS/g9OcjVjdMBCnM59kriMu07ga/38PBwC0s6hustZwMSZEuW1fCfbk5proSDw==
X-Received: by 2002:a05:600c:228c:b0:3fe:16c8:65fa with SMTP id
 12-20020a05600c228c00b003fe16c865famr3994300wmf.4.1692280111050; 
 Thu, 17 Aug 2023 06:48:31 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a1cf711000000b003fe23b10fdfsm3119022wmh.36.2023.08.17.06.48.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 06:48:30 -0700 (PDT)
Message-ID: <707edb63-66e6-51bc-74b0-aeb04a1a320f@redhat.com>
Date: Thu, 17 Aug 2023 15:48:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: ThinerLogoer <logoerthiner1@163.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com> <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <1b4168d2.4182.189e324e0ef.Coremail.logoerthiner1@163.com>
 <08cc9db9-b774-b027-58f5-dd7e6c374657@redhat.com>
 <ZN4k0GzWXo+ufSMW@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZN4k0GzWXo+ufSMW@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.01, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 17.08.23 15:46, Daniel P. Berrangé wrote:
> On Fri, Aug 11, 2023 at 09:00:54PM +0200, David Hildenbrand wrote:
>> On 11.08.23 07:49, ThinerLogoer wrote:
>>> At 2023-08-11 05:24:43, "Peter Xu" <peterx@redhat.com> wrote:
>>>> On Fri, Aug 11, 2023 at 01:06:12AM +0800, ThinerLogoer wrote:
>>>>>> I think we have the following options (there might be more)
>>>>>>
>>>>>> 1) This patch.
>>>>>>
>>>>>> 2) New flag for memory-backend-file. We already have "readonly" and
>>>>>> "share=". I'm having a hard time coming up with a good name that really
>>>>>> describes the subtle difference.
>>>>>>
>>>>>> 3) Glue behavior to the QEMU machine
>>>>>>
>>>>>
>>>>> 4) '-deny-private-discard' argv, or environment variable, or both
>>>>
>>>> I'd personally vote for (2).  How about "fdperm"?  To describe when we want
>>>> to use different rw permissions on the file (besides the access permission
>>>> of the memory we already provided with "readonly"=XXX).  IIUC the only sane
>>>> value will be ro/rw/default, where "default" should just use the same rw
>>>> permission as the memory ("readonly"=XXX).
>>>>
>>>> Would that be relatively clean and also work in this use case?
>>>>
>>>> (the other thing I'd wish we don't have that fallback is, as long as we
>>>> have any of that "fallback" we'll need to be compatible with it since
>>>> then, and for ever...)
>>>
>>> If it must be (2), I would vote (2) + (4), with (4) adjust the default behavior of said `fdperm`.
>>> Mainly because (private+discard) is itself not a good practice and (4) serves
>>> as a good tool to help catch existing (private+discard) problems.
>>
>> Instead of fdperm, maybe we could find a better name.
>>
>> The man page of "open" says: The argument flags must include one of the
>> following access modes: O_RDONLY, O_WRONLY, or O_RDWR.  These request
>> opening the file read-only, write-only, or read/write, respectively.
>>
>> So maybe something a bit more mouthful like "file-access-mode" would be
>> better.
> 
> I don't think we should directly express the config in terms
> of file-access-mode, as that's a low level impl detail. The
> required file access mode is an artifact of the higher level
> goal, or whether the RAM should be process private vs shared,
> and whether we want QEMU to be able to create the backing
> file or use pre-create one.

See my other mails "readonly" already expresses exactly that. So no need 
for "file-access-mode".

(and as far as I can see, no need for any other flags)

-- 
Cheers,

David / dhildenb


