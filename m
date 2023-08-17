Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA85177F93C
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 16:38:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWe8V-0006to-Gs; Thu, 17 Aug 2023 10:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWe8T-0006rw-Nv
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:38:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWe8R-0002mf-5p
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692283081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmO1KncsMdc/5iq8V5QeJ+HOEkOdMMFlZSAxP8GwFzA=;
 b=RsHcN6t/XQx3jsaYiRkMatdTvr0DsPWc5mHontnOO3Czjp1ZkRGEZnWqC0A1supstBXngZ
 r7zJXgKo2eA+7LPVAyixG4H/ozp3k+NXV47IY8H278hMJd3oxgZaTxqCXfFoMa6Hom6g/x
 MK6T9KUDO/+yCdZGUznbIbp2mezxliQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-slsxBjw_PTqIKN3u2lXRbw-1; Thu, 17 Aug 2023 10:37:58 -0400
X-MC-Unique: slsxBjw_PTqIKN3u2lXRbw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fe1d5e2982so51247905e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 07:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692283074; x=1692887874;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cmO1KncsMdc/5iq8V5QeJ+HOEkOdMMFlZSAxP8GwFzA=;
 b=SOaSIYUO9HnLs3d6lxBDtNT3ENAK768J+894ERFtR8QOQCw/mOWbEyUFuiKrcyQL4W
 T7VD8GR9WVSVzFlLZZSkKoG77vUsaAwdggxmHS11dYE0Ubp/cUM4pEyZSR9CbtHpRImD
 7KmQn/G1jBtr3rYabXsS9QdRmgY3ia0bhHOVTCybuQFy8iLQ1efBPrKpN3l1yhG5/Mln
 E4seQC6SEZtuRgR/fHw5xbXGb6ZKSQlJKDReQSasKMNNmppt94s/B0dZaV3fHNRjdYWi
 vIiGFk/Lp/eUWV/N/gLUx+IdQ4gzagSQKhwJUGDFgPMl+AzRwUoRR9q79uB5Wzewj97/
 Zkvg==
X-Gm-Message-State: AOJu0Yy3NZ0viGOojpAEcoB7Pst0GTSdPxzXY4XA0clOk3Rk42y7yl2t
 llNIc0JhWNPvV+gWQhixQQHo5tuHLfM9nFCBY+IqWg+us7ikVngmQxVbm5BruynS0h5Qdu7oeCs
 U5IhAl6mWUPV2RGE=
X-Received: by 2002:a05:600c:220c:b0:3fb:ef86:e30 with SMTP id
 z12-20020a05600c220c00b003fbef860e30mr3799817wml.10.1692283074232; 
 Thu, 17 Aug 2023 07:37:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9GJcZSrgMN+dtSpPTuYn+UbpIenERSjh7/DY5RIeRYGYuir6jHlmXWlfPuPXeUXrd0mcBoA==
X-Received: by 2002:a05:600c:220c:b0:3fb:ef86:e30 with SMTP id
 z12-20020a05600c220c00b003fbef860e30mr3799791wml.10.1692283073836; 
 Thu, 17 Aug 2023 07:37:53 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a05600c108b00b003fe557829ccsm3210148wmd.28.2023.08.17.07.37.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 07:37:53 -0700 (PDT)
Message-ID: <5ee05caf-e149-9545-c6c5-abf0fc74097f@redhat.com>
Date: Thu, 17 Aug 2023 16:37:52 +0200
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
References: <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com>
 <ZNOti1OKN79t68jP@x1n> <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <1b4168d2.4182.189e324e0ef.Coremail.logoerthiner1@163.com>
 <08cc9db9-b774-b027-58f5-dd7e6c374657@redhat.com>
 <2b967b3.13b7.189e82ee694.Coremail.logoerthiner1@163.com>
 <06f9a805-8150-8106-7d0a-05d0d2465cd0@redhat.com>
 <c92648e5-e974-48ac-2213-b5926a16ed4d@redhat.com>
 <ZN4wkI679/6j6+b+@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZN4wkI679/6j6+b+@redhat.com>
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

On 17.08.23 16:37, Daniel P. Berrangé wrote:
> On Thu, Aug 17, 2023 at 04:30:16PM +0200, David Hildenbrand wrote:
>>
>>> @Stefan, do you have any concern when we would do 1) ?
>>>
>>> As far as I can tell, we have to set the nvdimm to "unarmed=on" either way:
>>>
>>> +   "unarmed" controls the ACPI NFIT NVDIMM Region Mapping Structure "NVDIMM
>>> +   State Flags" Bit 3 indicating that the device is "unarmed" and cannot accept
>>> +   persistent writes. Linux guest drivers set the device to read-only when this
>>> +   bit is present. Set unarmed to on when the memdev has readonly=on.
>>>
>>> So changing the behavior would not really break the nvdimm use case.
>>
>> Looking into the details, this seems to be the right thing to do.
>>
>> This is what I have now as patch description, that also highlights how libvirt
>> doesn't even make use of readonly=true.
>>
>>
>>  From 42f272ace68e0cd660a8448adb5aefb3b9dd7005 Mon Sep 17 00:00:00 2001
>> From: David Hildenbrand <david@redhat.com>
>> Date: Thu, 17 Aug 2023 12:09:07 +0200
>> Subject: [PATCH v2 2/4] backends/hostmem-file: Make share=off,readonly=on
>>   result in RAM instead of ROM
>>
>> For now, "share=off,readonly=on" would always result in us opening the
>> file R/O and mmap'ing the opened file MAP_PRIVATE R/O -- effectively
>> turning it into ROM.
>>
>> As documented, readonly only specifies that we want to open the file R/O:
>>
>>      @readonly: if true, the backing file is opened read-only; if false,
>>          it is opened read-write.  (default: false)
>>
>> Especially for VM templating, "share=off" is a common use case. However,
>> that use case is impossible with files that lack write permissions,
>> because "share=off,readonly=off" will fail opening the file, and
>> "share=off,readonly=on" will give us ROM instead of RAM.
>>
>> With MAP_PRIVATE we can easily open the file R/O and mmap it R/W, to
>> turn it into COW RAM: private changes don't affect the file after all and
>> don't require write permissions.
>>
>> This implies that we only get ROM now via "share=on,readonly=on".
>> "share=off,readonly=on" will give us RAM.
>>
>> The sole user of ROM via memory-backend-file are R/O NVDIMMs. They
>> also require "unarmed=on" to be set for the nvdimm device.
>>
>> With this change, R/O NVDIMMs will continue working even if
>> "share=off,readonly=on" was specified similar to when simply
>> providing ordinary RAM to the nvdimm device and setting "unarmed=on".
>>
>> Note that libvirt seems to default for a "readonly" nvdimm to
>> * -object memory-backend-file,share=off (implying readonly=off)
>> * -device nvdimm,unarmed=on
>> And never seems to even set "readonly=on" for memory-backend-file. So
>> this change won't affect libvirt, they already always get COW RAM -- not
>> modifying the underlying file but opening it R/O.
>>
>> If someone really wants ROM, they can just use "share=on,readonly=on".
>> After all, there is not relevant difference between a R/O MAP_SHARED
>> file mapping and a R/O MAP_PRIVATE file mapping.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> This still leaves the patch having a warn_report() which I think is
> undesirable to emit in a valid / supported use case.

No warning.

Please elaborate on "valid/supported use case".

-- 
Cheers,

David / dhildenb


