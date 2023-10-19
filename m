Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E3A7CF177
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 09:40:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtNcl-0007YA-To; Thu, 19 Oct 2023 03:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNca-0007XI-9b
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:39:08 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNcY-00055D-Kq
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:39:08 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40839807e82so2578435e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 00:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697701145; x=1698305945; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D98dpbEjXlx8VQxuixtp9KOkljaHyL8GcDrrze+pWuo=;
 b=PlzAwXfQI5+OpP5IGkUVV8x3/hIAe8bNmQXb94V/S73Y7MNOAgtChBU6Klpmk/06L5
 Y5X37/KJGuglcRnU2yeHAJnanOLn/781Qxbs9YWIymhQ3eZ8HdFJzlSHg+cxB4qtptf5
 gq0uwYVdOaLitZ2EBSnVihEVrd7ddD9U8Dy9FDyLQJuOxdB3RwnzHZ+mMwFjhy8LyU83
 77b1cQ0wdpuVQ5c4qxdnze4mX10noRfa+8iOE7oHyrb0v4GSq4a4Zwsv0k4jx31FlAgU
 ldMEHoi8UympzaQMf/NaYhpZMcGnCQ4jeZpCapVOrh8BSXiJOnWXdijrIi1nRQCVMMKh
 jgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697701145; x=1698305945;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D98dpbEjXlx8VQxuixtp9KOkljaHyL8GcDrrze+pWuo=;
 b=A0tsx7XQN9WFUNyL8tqdZSBvOscEpFAOwukNKJRzBPCMH903oO+I5IkHkLw6k74CPI
 8oYbg4Da36dHOFLsx7P+WK2h/ae5X9uGvXee8MojvKMte8lz6sVBy/r43TiIAcEarVOA
 18UlxV/jcoPwRFdJZmSe6GErO0H7HFesualt+pm7ixs5tCa66T1cpCXKhS5X0+/0Frjs
 k94l3F5AMEUoVrFB63MdXaPvaI9fKQgiOGH8IEgLk5Wo7B5bxvbucTJKYwGKVd87vtB6
 LRAlxKtFg2t5zEHjy+R/R1kynAxCwalvt2XN/kRJHmEtRb900bby4TrC2ms07LEfTjOA
 VniA==
X-Gm-Message-State: AOJu0YykVrTzWha2OANtWcRDZsDdQVswQdWHdbkPFhG6dFICCvy2EB2u
 7BXvFfvDGCt47p1+5OyBfbrmgA==
X-Google-Smtp-Source: AGHT+IE+BPRHjyz3c4Im2p46uqQI/VxgObOv491MJT47ozOImVtt32y0uGxMwPhsRad22Q3VWyBw/g==
X-Received: by 2002:a05:600c:4f45:b0:3ff:516b:5c4c with SMTP id
 m5-20020a05600c4f4500b003ff516b5c4cmr1010580wmq.18.1697701144942; 
 Thu, 19 Oct 2023 00:39:04 -0700 (PDT)
Received: from [192.168.165.175] (92.red-88-28-12.dynamicip.rima-tde.net.
 [88.28.12.92]) by smtp.gmail.com with ESMTPSA id
 i18-20020a05600c481200b00407b93d8085sm3629324wmo.27.2023.10.19.00.39.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 00:39:04 -0700 (PDT)
Message-ID: <c386b03a-c59f-902a-7cb4-f5e54de577d5@linaro.org>
Date: Thu, 19 Oct 2023 09:38:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 05/12] hw/pci-host/bonito: Do not use SysBus API to map
 local MMIO region
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>, Beniamino Galvani
 <b.galvani@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eric Farman <farman@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20231019071611.98885-1-philmd@linaro.org>
 <20231019071611.98885-6-philmd@linaro.org>
 <a00df2c8-6108-45f9-ab35-722f989f2057@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <a00df2c8-6108-45f9-ab35-722f989f2057@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 19/10/23 09:26, Thomas Huth wrote:
> On 19/10/2023 09.16, Philippe Mathieu-Daudé wrote:
>> There is no point in exposing an internal MMIO region via
>> SysBus and directly mapping it in the very same device.
>>
>> Just map it without using the SysBus API.
>>
>> Transformation done using the following coccinelle script:
>>
>>    @@
>>    expression sbdev;
>>    expression index;
>>    expression addr;
>>    expression subregion;
>>    @@
>>    -    sysbus_init_mmio(sbdev, subregion);
>>         ... when != sbdev
>>    -    sysbus_mmio_map(sbdev, index, addr);
>>    +    memory_region_add_subregion(get_system_memory(), addr, 
>> subregion);
>>
>> and manually adding the local 'host_mem' variable to
>> avoid multiple calls to get_system_memory().
> 
> Thanks for updating it!
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/pci-host/bonito.c | 32 ++++++++++++++++----------------
>>   1 file changed, 16 insertions(+), 16 deletions(-)


>>       /* PCI copier */
>>       memory_region_init_io(&s->iomem_cop, OBJECT(s), &bonito_cop_ops, s,
>>                             "cop", 0x100);
>> -    sysbus_init_mmio(sysbus, &s->iomem_cop);
>> -    sysbus_mmio_map(sysbus, 4, 0x1fe00300);
>> +    memory_region_add_subregion(host_mem, 0x1fe00300,
>> +                                &s->iomem_cop);
> 
> At least the above two hunks look like they could now fit into one line?

This file will be heavily reworked soon, but meanwhile I did what you
suggested.

> Anyway:
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!


