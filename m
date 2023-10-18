Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D6E7CD355
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 07:03:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsyh8-00064o-D3; Wed, 18 Oct 2023 01:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsyh6-00064T-Ge
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 01:02:08 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsyh4-0003Le-0o
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 01:02:08 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32dc9ff4a8fso684694f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 22:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697605324; x=1698210124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Oc92GoeGGgDiGM6b7TLy9ZYTnGxOXyDkXoDi/Eje0lA=;
 b=eFCu0F6nlNCI9lnHn64yKutpfbpbtjH/wD7vcGcjx6fkkJEtA780uU1jAXXLI26vk8
 9ehOxsbnRKWD8tB3RvPTxpRT3sOhA3IZq/M0LHvmExGpRYT6dLhUywWBrCFwEG0YcxPW
 07N8SnzfvpllZ+QTP2LF6VhPww4M+IJ+X4ACk8q+t30gUr1+/rPxj/0yZVMDbiOXsJ4z
 pMRrC8jXX8MHH8fVfuxtVP8nrBm5KEgN4Ogell0FwF+t7vmkwlP43xDO7+i+kOT4q1qG
 yj8BBoiyDS7uxSVZmmX83/zuNISr8hDhAgTpVOg5gBuqiY+ObeNN8Af2nBKApoWtgkYt
 2Fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697605324; x=1698210124;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Oc92GoeGGgDiGM6b7TLy9ZYTnGxOXyDkXoDi/Eje0lA=;
 b=Wa14nslD0YRPm5f9+GZ7hTJ0vCs+fpo0XONiuVKbZRBX3A8lAZwHNdMAwTZnby6HSn
 mi0I8fqioA52Zcvz7KMvBVJmMnWr3X+DJK8lLYyq+WYxcxgrW+HJ2JdBz6ax14lwdF/7
 B9BfJ0/jry3B6SgeFcTDELrXivlgdhEnsL91Yl4vWcTLm2zfA0hW5KoaFvehVjyt1cA3
 DBXNpPLFZSXsMDrX4ydHM83gbZogSwcamVywAfys4f1Gjdy3KE55VBnsW2lsXbh7QVMN
 UsCaRAv/VnaEzMKVe40L8VGBGTqPwuG6044edDkRvLO6uySYbqCb9LCYtB3k1ARtGQkF
 mu8w==
X-Gm-Message-State: AOJu0YxXz+WMmhzaOeh/aWKeK0KqwLdWJinby1bKrttjiDRH+xdOXS5G
 06AANnFeM4NKtgHD2jA0jDWzrw==
X-Google-Smtp-Source: AGHT+IEb3H9bBM4klmRenRYRbhpM/YFPfLA4/QtNOK6aO/kGX779kNlbfrrfL5EucW6M+sXSpk0RzQ==
X-Received: by 2002:adf:f4cf:0:b0:317:50b7:2ce3 with SMTP id
 h15-20020adff4cf000000b0031750b72ce3mr3420595wrp.51.1697605323682; 
 Tue, 17 Oct 2023 22:02:03 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 j14-20020adfea4e000000b0032d81837433sm1205551wrn.30.2023.10.17.22.02.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 22:02:03 -0700 (PDT)
Message-ID: <86b583f9-f03c-ca5c-95cd-65b5b679a56e@linaro.org>
Date: Wed, 18 Oct 2023 07:02:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] hw/audio/pcspk: Inline pcspk_init()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20231017135058.44247-1-philmd@linaro.org>
 <72ab4b46-2152-4de3-b971-b31ea9d89bf1@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <72ab4b46-2152-4de3-b971-b31ea9d89bf1@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 17/10/23 22:08, Mark Cave-Ayland wrote:
> On 17/10/2023 14:50, Philippe Mathieu-Daudé wrote:
> 
>> pcspk_init() is a legacy init function, inline and remove it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/audio/pcspk.h | 10 ----------
>>   hw/i386/pc.c             |  3 ++-
>>   hw/isa/i82378.c          |  5 ++++-
>>   hw/mips/jazz.c           |  5 ++++-
>>   4 files changed, 10 insertions(+), 13 deletions(-)


>> diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
>> index c32d2b0b0a..aac851747c 100644
>> --- a/hw/mips/jazz.c
>> +++ b/hw/mips/jazz.c
>> @@ -177,6 +177,7 @@ static void mips_jazz_init(MachineState *machine,
>>       SysBusDevice *sysbus;
>>       ISABus *isa_bus;
>>       ISADevice *pit;
>> +    ISADevice *pcspk;
>>       DriveInfo *fds[MAX_FD];
>>       MemoryRegion *bios = g_new(MemoryRegion, 1);
>>       MemoryRegion *bios2 = g_new(MemoryRegion, 1);
>> @@ -279,7 +280,9 @@ static void mips_jazz_init(MachineState *machine,
>>       isa_bus_register_input_irqs(isa_bus, i8259);
>>       i8257_dma_init(isa_bus, 0);
>>       pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
>> -    pcspk_init(isa_new(TYPE_PC_SPEAKER), isa_bus, pit);
>> +    pcspk = isa_new(TYPE_PC_SPEAKER);
>> +    object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), NULL);
>> +    isa_realize_and_unref(pcspk, isa_bus, &error_fatal);
>>       /* Video card */
>>       switch (jazz_model) {
> 
> Possibly you might want to pass errp instead of NULL for the last 
> parameter of object_property_set_link() in i82378_realize()?

Oops you are right. I'll use &error_fatal.

> But 
> regardless:
> 
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Thanks!


