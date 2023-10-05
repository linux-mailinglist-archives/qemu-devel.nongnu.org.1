Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 176927B9FAB
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 16:27:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoPJB-000845-4T; Thu, 05 Oct 2023 10:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoPJ5-00081Y-VB
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 10:26:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoPJ4-0003DS-6J
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 10:26:27 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-405505b07dfso13399865e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696515984; x=1697120784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zoDxMZnxOXNMlxpSgRU+uUZryUDhePHfETK0uNtLkbw=;
 b=Fl72q2Z7X705vHxF67tn1+MMVVScm2jdv/O3pK47GDhyyLesgBYXGR9Rx7FzgID+JK
 NMkMnDgThMFf2yIrrZR6e7V4ud9SOKm7dZQtoqrCS5iIhsFHmCL8QwYjbKL8zKTipZfU
 FxM7/AXE7YyRgUWtA3luZ9eWrmpSRUd8t47WzbTVR1Ku43V/Mn/S5y+pfoHnlnHoQD3k
 DPrAuxKhcgMi8bCAnPnoIuj1/ue8NwvKpVoTwWTbjjDJvX9lykPqquav+juWN2G78qTK
 V4IwKSbXKwww8BRrw9fcDEvttnLbHQd5CU/i/c1U7MBL2XLFfTviGu5Dm97KdqBessJG
 BkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696515984; x=1697120784;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zoDxMZnxOXNMlxpSgRU+uUZryUDhePHfETK0uNtLkbw=;
 b=XRD320svWope+B6iAXy3q6ByxzOOBdT8Vu5b6p5WrCuNkO7TAipgVthhPbE9J8Qra3
 Cr99TqkQJAx3C1uYQN9B1oC6YiaP2yWxxLzxiPsM4DinBZYlaB6aw1l80cnlzoxo/orb
 omlrGdpRQ7tExrSNf5j3FyXrqC1auDK5zNBOPAPHrVWWzXZoIU7bGm6biGtA4VIP72t3
 sEJXSZ2Nhrf54hiduzo7DdXrvqB9xdXeVppCZ7eNv9SEWfCVGcSJNGdGP00z7lGFD4j5
 tTfxWJwX9Oyc0+moEJSVEVWI23+fPqFbJ9cZtP3ErQ7uR+LKK5TN1l7t9Hq4WpVAqtP3
 to3Q==
X-Gm-Message-State: AOJu0Yztja2m6daUUz+chTt7IIlHTweL5d9LO/CRYydHNTqBqyTU84YB
 X/VmxAFlvc3Ug8juwUuSJmn3Dw==
X-Google-Smtp-Source: AGHT+IFMYcDOR5bFZ2OaW8zw586TelsMQ8v9AXUrZZNctQ2qgPwaH7lZgPbH7Sy2q2g73UlruGRNMw==
X-Received: by 2002:a05:600c:224d:b0:406:80b4:efd5 with SMTP id
 a13-20020a05600c224d00b0040680b4efd5mr2636331wmm.14.1696515984465; 
 Thu, 05 Oct 2023 07:26:24 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a05600c221200b0040607da271asm3870747wml.31.2023.10.05.07.26.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 07:26:24 -0700 (PDT)
Message-ID: <0aaedb1e-2461-6ca5-0f6c-8f50f6eb0686@linaro.org>
Date: Thu, 5 Oct 2023 16:26:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3] hw/isa/vt82c686: Respect SCI interrupt assignment
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20231005115159.81202-1-shentey@gmail.com>
 <7f0a480e-3b30-36d8-daaf-cb817dcad3ca@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <7f0a480e-3b30-36d8-daaf-cb817dcad3ca@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/10/23 14:45, BALATON Zoltan wrote:
> On Thu, 5 Oct 2023, Bernhard Beschow wrote:
>> According to the datasheet, SCI interrupts of the power management 
>> function
>> aren't routed through the PCI pins but rather directly to the 
>> integrated PIC.
>> The routing is configurable through the ACPI interrupt select register 
>> at offset
>> 0x42 in the PCI configuration space of the power management function.
>>
>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> ---
>>
>> v3:
>> * Rename SCI irq attribute to sci_irq (Zoltan)
>> * Fix confusion about location of ACPI interrupt select register (Zoltan)
>> * Model SCI as named GPIO (Bernhard)
>> * Perform upcast via macro rather than sub structure selection (Bernhard)
>>
>> v2:
>> * Introduce named constants for the ACPI interrupt select register at 
>> offset
>>  0x42 (Phil)
>> ---
>> hw/isa/vt82c686.c | 48 +++++++++++++++++++++++++++++++++++------------
>> 1 file changed, 36 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
>> index 57bdfb4e78..aeb9434a46 100644
>> --- a/hw/isa/vt82c686.c
>> +++ b/hw/isa/vt82c686.c
>> @@ -40,12 +40,17 @@
>> #define TYPE_VIA_PM "via-pm"
>> OBJECT_DECLARE_SIMPLE_TYPE(ViaPMState, VIA_PM)
>>
>> +#define VIA_PM_SCI_SELECT_OFS 0x42
>> +#define VIA_PM_SCI_SELECT_MASK 0xf
>> +
>> struct ViaPMState {
>>     PCIDevice dev;
>>     MemoryRegion io;
>>     ACPIREGS ar;
>>     APMState apm;
>>     PMSMBus smb;
>> +
>> +    qemu_irq sci_irq;
>> };
>>
>> static void pm_io_space_update(ViaPMState *s)
>> @@ -148,18 +153,7 @@ static void pm_update_sci(ViaPMState *s)
>>                    ACPI_BITMASK_POWER_BUTTON_ENABLE |
>>                    ACPI_BITMASK_GLOBAL_LOCK_ENABLE |
>>                    ACPI_BITMASK_TIMER_ENABLE)) != 0);
>> -    if (pci_get_byte(s->dev.config + PCI_INTERRUPT_PIN)) {
>> -        /*
>> -         * FIXME:
>> -         * Fix device model that realizes this PM device and remove
>> -         * this work around.
>> -         * The device model should wire SCI and setup
>> -         * PCI_INTERRUPT_PIN properly.
>> -         * If PIN# = 0(interrupt pin isn't used), don't raise SCI as
>> -         * work around.
>> -         */
>> -        pci_set_irq(&s->dev, sci_level);
>> -    }
>> +    qemu_set_irq(s->sci_irq, sci_level);
> 
> I still think this it more complex that it should be and what's in 
> via_isa_set_pm_irq() below should be here instead and drop all the named 
> gpio wizardry that's just unneeded complication here.

Zoltan, I'm not sure I get what you mean. Do you mind respining a v4
of Bernhard's patch?

Regards,

Phil.

