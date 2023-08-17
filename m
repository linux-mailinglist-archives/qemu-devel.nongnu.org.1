Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B51677F995
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 16:47:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWeHS-0003y7-Sn; Thu, 17 Aug 2023 10:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWeHP-0003xx-PW
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWeHN-0007TH-GL
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692283636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iJPEmOXdB6zaGbyVlLFE1c9w29qGC4XMPnpGFSd3oi8=;
 b=cIhNWUECG7G9kDHc+xcWDrDBi9stMjZ2gQuec7DnYgKGw+XjOHo9YWTj8z56PKBq5LgA+3
 2/wYIRWr1B5YO+UiQMigGmLT+UFuI3L26lrUoVyFvcrzaMEw/XtA3Ii1patuoLksPWAAKS
 TtrewUbxTQED6ANX8UYDfzfG+KtpldU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-BlESTmnFP26bzVSFHprsaA-1; Thu, 17 Aug 2023 10:47:14 -0400
X-MC-Unique: BlESTmnFP26bzVSFHprsaA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe517ca810so51411545e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 07:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692283633; x=1692888433;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iJPEmOXdB6zaGbyVlLFE1c9w29qGC4XMPnpGFSd3oi8=;
 b=dG4aSGHh4l98hnAQN9XZn0/7POwOnSbzM3qHwxFOnfmUW3NOqZY8kQxERiTsAA/wTn
 cyuT5Wxulff03pGToNpHbdf/2iSbm/KrCb1SyXGmvyNCHwyRATSI1l4c2qxExQuwXsr3
 hppULA2OiKwDA6wTs1iao+t6Rk+TEu8pr5Na5qX21z1JpzsW74P76IcpJ0uX6k1gHDxZ
 TBmomzIJVml+tUz+fB3fbKMzslyUGLmR7Vl4l5IpABpkDn6LG0EaEUCHf5V6IG+XKAsR
 Pso9QrMxVR3Y6jY7CbVNP42N/Bl09exF9gMz5hce6fggskEQOcsAOlA9WJk8TZaMvRmd
 kIRw==
X-Gm-Message-State: AOJu0YwLqOBzjm2pDaYEQRPwokGDY+e6y4Za1JQfjBeMMYl4yQYU7y10
 9jJ7ktUFrW0BL1VUS1yCtx9TyoqH//wwQnAns3RHyM2Jl+FZm1ecs0V1ydIjxRu1qDjm4HDqv7Q
 1gbik1pXCE/S0cfo=
X-Received: by 2002:a05:6000:1b91:b0:311:3fdc:109d with SMTP id
 r17-20020a0560001b9100b003113fdc109dmr3738248wru.1.1692283633171; 
 Thu, 17 Aug 2023 07:47:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoNz8VH9t34xMRfZK9vaGFkH8hck5bUpf4iucWmn7u0TJACg/P+x+aipWfpnr/88UQQur0IQ==
X-Received: by 2002:a05:6000:1b91:b0:311:3fdc:109d with SMTP id
 r17-20020a0560001b9100b003113fdc109dmr3738221wru.1.1692283632693; 
 Thu, 17 Aug 2023 07:47:12 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a5d45c8000000b0030ae53550f5sm25175825wrs.51.2023.08.17.07.47.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 07:47:12 -0700 (PDT)
Message-ID: <57ddf223-c47e-1b4b-d2f8-fed792b42838@redhat.com>
Date: Thu, 17 Aug 2023 16:47:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: ThinerLogoer <logoerthiner1@163.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <1b4168d2.4182.189e324e0ef.Coremail.logoerthiner1@163.com>
 <08cc9db9-b774-b027-58f5-dd7e6c374657@redhat.com>
 <2b967b3.13b7.189e82ee694.Coremail.logoerthiner1@163.com>
 <06f9a805-8150-8106-7d0a-05d0d2465cd0@redhat.com>
 <c92648e5-e974-48ac-2213-b5926a16ed4d@redhat.com>
 <ZN4wkI679/6j6+b+@redhat.com>
 <5ee05caf-e149-9545-c6c5-abf0fc74097f@redhat.com>
 <ZN4ymrGbwBbLuiq7@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZN4ymrGbwBbLuiq7@redhat.com>
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

On 17.08.23 16:45, Daniel P. Berrangé wrote:
> On Thu, Aug 17, 2023 at 04:37:52PM +0200, David Hildenbrand wrote:
>> On 17.08.23 16:37, Daniel P. Berrangé wrote:
>>> On Thu, Aug 17, 2023 at 04:30:16PM +0200, David Hildenbrand wrote:
>>>>
>>>>> @Stefan, do you have any concern when we would do 1) ?
>>>>>
>>>>> As far as I can tell, we have to set the nvdimm to "unarmed=on" either way:
>>>>>
>>>>> +   "unarmed" controls the ACPI NFIT NVDIMM Region Mapping Structure "NVDIMM
>>>>> +   State Flags" Bit 3 indicating that the device is "unarmed" and cannot accept
>>>>> +   persistent writes. Linux guest drivers set the device to read-only when this
>>>>> +   bit is present. Set unarmed to on when the memdev has readonly=on.
>>>>>
>>>>> So changing the behavior would not really break the nvdimm use case.
>>>>
>>>> Looking into the details, this seems to be the right thing to do.
>>>>
>>>> This is what I have now as patch description, that also highlights how libvirt
>>>> doesn't even make use of readonly=true.
>>>>
>>>>
>>>>   From 42f272ace68e0cd660a8448adb5aefb3b9dd7005 Mon Sep 17 00:00:00 2001
>>>> From: David Hildenbrand <david@redhat.com>
>>>> Date: Thu, 17 Aug 2023 12:09:07 +0200
>>>> Subject: [PATCH v2 2/4] backends/hostmem-file: Make share=off,readonly=on
>>>>    result in RAM instead of ROM
>>>>
>>>> For now, "share=off,readonly=on" would always result in us opening the
>>>> file R/O and mmap'ing the opened file MAP_PRIVATE R/O -- effectively
>>>> turning it into ROM.
>>>>
>>>> As documented, readonly only specifies that we want to open the file R/O:
>>>>
>>>>       @readonly: if true, the backing file is opened read-only; if false,
>>>>           it is opened read-write.  (default: false)
>>>>
>>>> Especially for VM templating, "share=off" is a common use case. However,
>>>> that use case is impossible with files that lack write permissions,
>>>> because "share=off,readonly=off" will fail opening the file, and
>>>> "share=off,readonly=on" will give us ROM instead of RAM.
>>>>
>>>> With MAP_PRIVATE we can easily open the file R/O and mmap it R/W, to
>>>> turn it into COW RAM: private changes don't affect the file after all and
>>>> don't require write permissions.
>>>>
>>>> This implies that we only get ROM now via "share=on,readonly=on".
>>>> "share=off,readonly=on" will give us RAM.
>>>>
>>>> The sole user of ROM via memory-backend-file are R/O NVDIMMs. They
>>>> also require "unarmed=on" to be set for the nvdimm device.
>>>>
>>>> With this change, R/O NVDIMMs will continue working even if
>>>> "share=off,readonly=on" was specified similar to when simply
>>>> providing ordinary RAM to the nvdimm device and setting "unarmed=on".
>>>>
>>>> Note that libvirt seems to default for a "readonly" nvdimm to
>>>> * -object memory-backend-file,share=off (implying readonly=off)
>>>> * -device nvdimm,unarmed=on
>>>> And never seems to even set "readonly=on" for memory-backend-file. So
>>>> this change won't affect libvirt, they already always get COW RAM -- not
>>>> modifying the underlying file but opening it R/O.
>>>>
>>>> If someone really wants ROM, they can just use "share=on,readonly=on".
>>>> After all, there is not relevant difference between a R/O MAP_SHARED
>>>> file mapping and a R/O MAP_PRIVATE file mapping.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>
>>> This still leaves the patch having a warn_report() which I think is
>>> undesirable to emit in a valid / supported use case.
>>
>> No warning.
>>
>> Please elaborate on "valid/supported use case".
> 
> The usage scenario that this patch aims to enable. IIUC, it will follow
> the codepath that leads to the warn_report() call in this patch.

It shouldn't but I will double check!

-- 
Cheers,

David / dhildenb


