Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59661AC397E
	for <lists+qemu-devel@lfdr.de>; Mon, 26 May 2025 08:00:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQsH-0006Zk-Pc; Mon, 26 May 2025 01:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uJQsB-0006ZW-9F
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:59:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uJQs9-000570-JO
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748239179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ToFHkBt9kbFSsh9l9SdOanOWmOjdWEb8xK1qIAirQFc=;
 b=S7fqeFvlo2jmRBZsRVYOXJwde6OcMCdb5L+9QYSAfC93FD/oJJw2ovp7JQqtxJuw37AE1r
 +kn6mZU5Zg1djG2dZ/ui5uW/5NQ1t53+vtyyXRn8KZ5/p/Q4KFD6bWL9rUKoV+Uo8iuzcV
 ZB5W+pF2WwnhIawX/pibGrKiNM265sM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-4P5J_NSdOiyKDtXVKdnjTw-1; Mon, 26 May 2025 01:59:38 -0400
X-MC-Unique: 4P5J_NSdOiyKDtXVKdnjTw-1
X-Mimecast-MFC-AGG-ID: 4P5J_NSdOiyKDtXVKdnjTw_1748239177
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-604639a2715so678001a12.0
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748239177; x=1748843977;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ToFHkBt9kbFSsh9l9SdOanOWmOjdWEb8xK1qIAirQFc=;
 b=rZEEoSIzD8iNbN2j7LILqhfCn9MRCTN3bzCL80G0neXexAZFS+DpTy9IKVSWJPC/52
 5o9O42EDhANiTyXXCgQpojtUC6vMr/JndL/3LAoiK0mgRzxs4pvU6mX33uvS+XCTlAA0
 x50qTnUZbUrRJ8hyB8x8uFTOhmYOBSrZEk0O4TosPkjRPuH2U/IcjcoHZICF6K7S+pbJ
 HxkDr/E8dBIC7rsxxTVtVQ2Zu8GCUUcZ1WTxt9D0TbzAO5tL69L8ZtkrRSMUiXcB4wT1
 /vu0s3YldiOecPR+bXHBmncDQV+zHgiIrmWiy2iLHTsAa+0V5awM03R54NcoDc+AECIA
 a7YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMV6DeSHvIAPYvmpPZkbn/W+OH5pbZodjB3I3EwDnwMaY/jV6R4bc84X43f976uCuf69d6LW0RXgd7@nongnu.org
X-Gm-Message-State: AOJu0Yw7L0QTd6v8bF7gwuO0vqa0DL4WhQJr43yd+5ZknEQ1IIcSt1tx
 dRBXPOUkCl5+pfFDsksCgjKaP5CDJYHvv3C9sNwQImzqUpJDwADpSLbNMqaKtkhKPMtizHqdw4U
 TxZSo0n4E6ZIg71VOFD94ogMhDkYhX204VKEebqnpy877VIsnL6d9ncBmiVKOKTrzlns=
X-Gm-Gg: ASbGncszvKfkKjvdWvF6PT+oXix5dgvc3cXQCfKotwq1+I0YxHDLAP+kGxJ38nZwgUO
 vhRIghU/eezy8+PgyaLK2QzuGdBJysrmxlP+uZmiyctN9pGKLfRfsPTT3+XHAS+eHqsWsctMcQa
 1OK/blAruMpy1WJDmGSkYB97iHg87vou0ZAPhbzSUMhN/M3qD2D19Buna7Zagm32NZEd9zHrlJw
 5R1y4/2YBnYvFGylB8SnIviUnQYou0wl5+9uexhAFIJx6NE5i4Aq+vp+8mzBiuLmGQAbcPQvf7Z
 Tks2nj/a3T9JDzJqiXBA4Ly6py9prKUm2hFa0aBW3tI=
X-Received: by 2002:a17:907:7f8a:b0:ad1:a87d:3cd0 with SMTP id
 a640c23a62f3a-ad85b0ad5bamr692209466b.17.1748239176859; 
 Sun, 25 May 2025 22:59:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEESr9mX+WCF5HwsCKvx5WHhjpZ7J9588HGaPl/r/k8hkSEmkqL7iU0UBHBABH+X6isTAX3ww==
X-Received: by 2002:a17:907:7f8a:b0:ad1:a87d:3cd0 with SMTP id
 a640c23a62f3a-ad85b0ad5bamr692207466b.17.1748239176484; 
 Sun, 25 May 2025 22:59:36 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de.
 [109.42.49.201]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4f8e40sm1599085866b.183.2025.05.25.22.59.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 22:59:35 -0700 (PDT)
Message-ID: <b57d75b7-5236-4a09-98a9-9036067d26af@redhat.com>
Date: Mon, 26 May 2025 07:59:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/microblaze: Remove the big-endian variants of
 ml605 and xlnx-zynqmp-pmu
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250515132019.569365-1-thuth@redhat.com>
 <20250515132019.569365-4-thuth@redhat.com>
 <d5dbb421-83bc-4ac9-9a88-953ec0f97735@linaro.org>
 <9b75c7a1-b9c1-47cf-b421-0779fad23e5a@redhat.com>
 <d03581a8-412d-4e3c-adc8-68a94aefd189@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <d03581a8-412d-4e3c-adc8-68a94aefd189@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25/05/2025 21.19, Philippe Mathieu-Daudé wrote:
> On 16/5/25 16:06, Thomas Huth wrote:
>> On 16/05/2025 17.00, Philippe Mathieu-Daudé wrote:
>>> On 15/5/25 15:20, Thomas Huth wrote:
>>>> From: Thomas Huth <thuth@redhat.com>
>>>>
>>>> Both machines were added with little-endian in mind only (the
>>>> "endianness" CPU property was hard-wired to "true", see commits
>>>> 133d23b3ad1 and a88bbb006a52), so the variants that showed up
>>>> on the big endian target likely never worked. We deprecated these
>>>> non-working machine variants two releases ago, and so far nobody
>>>> complained, so it should be fine now to disable them. Hard-wire
>>>> the machines to little endian now.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>   docs/about/deprecated.rst           |  6 ------
>>>>   docs/about/removed-features.rst     |  9 +++++++++
>>>>   hw/microblaze/petalogix_ml605_mmu.c | 15 ++++-----------
>>>>   hw/microblaze/xlnx-zynqmp-pmu.c     |  7 +------
>>>>   4 files changed, 14 insertions(+), 23 deletions(-)
>>>
>>> \o/
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> Thanks!
>>
>>> I won't be able to look at the rest of this series until in 10 days,
>>> feel free to merge if necessary.
>>
>> Maybe you could at least provide a quick comment on the idea of 
>> controlling the endianness of the s3adsp1800 machine via a machine 
>> property? (since your original idea was to do it via different machine 
>> names instead ... does the property sound acceptable to you?)
> 
> IIRC my goal was to remove TARGET_BIG_ENDIAN from hw/, but I was
> aiming for heterogeneous binary, trying to not introduce any changes
> for users. Now we are only considering "single binary" and we have
> the TargetInfo API, so things are simpler.
> 
> Using the TargetInfo API, that would be:
> 
> -- >8 --
> @@ -26,7 +26,8 @@
>   #include "qemu/osdep.h"
>   #include "qemu/units.h"
>   #include "qapi/error.h"
> +#include "qemu/target-info.h"
>   #include "hw/sysbus.h"
>   #include "net/net.h"
>   #include "hw/block/flash.h"
> @@ -71,13 +83,16 @@ petalogix_s3adsp1800_init(MachineState *machine)
>       MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
>       qemu_irq irq[32];
>       MemoryRegion *sysmem = get_system_memory();
> -    EndianMode endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG
> -                                              : ENDIAN_MODE_LITTLE;
> +    EndianMode endianness = psms->endianness;
> +
> +    if (endianness == ENDIAN_MODE_UNSPECIFIED) {
> +        endianness = target_endian_mode();
> +    }

But one of the ideas of this series here is to finally deprecate 
qemu-system-microblazeel, so we need a way that the user can use to 
configure the endianness of the machine. Does the property look like an 
acceptable way for this to you?

  Thomas


