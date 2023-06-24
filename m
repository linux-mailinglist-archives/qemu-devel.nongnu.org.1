Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EBB73CB60
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 16:24:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD4BH-00043O-CU; Sat, 24 Jun 2023 10:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1qD4BE-00042q-CI; Sat, 24 Jun 2023 10:24:00 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1qD4BC-0007dB-CM; Sat, 24 Jun 2023 10:24:00 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-34207e81c98so7228405ab.2; 
 Sat, 24 Jun 2023 07:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687616637; x=1690208637;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S5n05OkfMZf6j1L/CxXJ2T6JtNiTIbFdXOeJPgW6KxA=;
 b=VDQzXyybNCrJDpe/zdjHmHLGQS8SuCAufDxFpHkxsuyCv9LsFWZZqoCMyZVCVQVh0R
 /O8nKLiaBgpUvCvnmo+PvW1ZipCuC9Ob5YWvS92dZ+iFvssDT7aSLQIX/9p5RLVOna/q
 5gA4+7yimUuOskbZQW6DBdrEdgKg423c9/k+uD9ZRNLZO7CMVkGJGKr9Wse7j6uzazAh
 99Djs0eHcFIPpEa0h+O57hIJubYBKjjFBpMaXTaj1+dLoMosjlNQWU8mNpx4+J0qCTni
 et4XhXhBGzzstgFxuBFfxZ0xpvMGJpGf1BITWP3yrWdRuReXhjWT69hD8vD73AGvm00P
 Q++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687616637; x=1690208637;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S5n05OkfMZf6j1L/CxXJ2T6JtNiTIbFdXOeJPgW6KxA=;
 b=K30DgBoeEfP9GlqwG0YcFebjvRuFGmql8gygbFRX0gFGKs+XAsulgCFPxoszzeK6a4
 daJ9WAH7ek7r/R3I5mtcHy6L5wSM5m5b1QiJm1qIsVToIgIjc3pkvf87UqnyNlH/YPR4
 Lbz+g7STPyxOXBVWKx1/qgPrnNppW8wgJoJuYGeH8RpdGJ/9ExIwMU4wT2sZAprJ8597
 2MUUR9y2Q13UfezThMgQli7Zxu8FseakrteIUzy9QJPojiW5V+ghPNcCVo0bM20GRGMC
 TFhPsH/ZJL/thjCJEv7n7p+NnnUq3JG0Co4uuBeI1j0qxUhbq19LGbkTFLv+38TG3Uni
 7Fkg==
X-Gm-Message-State: AC+VfDwqiBJf0Eyg4VN1l5bJR95nkRJRiWoio0pRglJ7czslu5N2qj49
 5sPzoHotfHAQ0cOew0lg8ng=
X-Google-Smtp-Source: ACHHUZ6pc6+6HXolk3NbNDgYLbk0lcFz6vTn65kxjBfMBGgRyz5onDPm23w1/4ZDaqiUpDbC6kaxuA==
X-Received: by 2002:a6b:d607:0:b0:780:ce12:6c50 with SMTP id
 w7-20020a6bd607000000b00780ce126c50mr10607182ioa.18.1687616636529; 
 Sat, 24 Jun 2023 07:23:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 bw9-20020a17090af60900b0024e49b53c24sm1392579pjb.10.2023.06.24.07.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Jun 2023 07:23:55 -0700 (PDT)
Message-ID: <a51c71c5-4c5e-8723-76f1-2cc9410f601b@roeck-us.net>
Date: Sat, 24 Jun 2023 07:23:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qianfanguijin@163.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20230523100508.32564-1-qianfanguijin@163.com>
 <20230523100508.32564-2-qianfanguijin@163.com>
 <41e71eae-72ad-410d-9cd8-cc495c06dac4@roeck-us.net>
 <CAFEAcA8aEQWAap36CtHMrEkFQUPnDCH7=-X5+TE2GJ-qzm3Y9w@mail.gmail.com>
 <2044dc69-93de-d855-fe44-ee6f3ab3576b@roeck-us.net>
 <CAFEAcA8vtJNwbxBreDMFB6q-Z=G5FiOcWzAAz+F69A4-Er_4EA@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 01/11] hw: arm: Add bananapi M2-Ultra and allwinner-r40
 support
In-Reply-To: <CAFEAcA8vtJNwbxBreDMFB6q-Z=G5FiOcWzAAz+F69A4-Er_4EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=groeck7@gmail.com; helo=mail-il1-x12e.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/24/23 03:40, Peter Maydell wrote:
> On Fri, 23 Jun 2023 at 20:33, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 6/23/23 10:44, Peter Maydell wrote:
>>> On Sat, 17 Jun 2023 at 17:29, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Tue, May 23, 2023 at 06:04:58PM +0800, qianfanguijin@163.com wrote:
>>>>> From: qianfan Zhao <qianfanguijin@163.com>
>>>>>
>>>>> Allwinner R40 (sun8i) SoC features a Quad-Core Cortex-A7 ARM CPU,
>>>>> and a Mali400 MP2 GPU from ARM. It's also known as the Allwinner T3
>>>>> for In-Car Entertainment usage, A40i and A40pro are variants that
>>>>> differ in applicable temperatures range (industrial and military).
>>>>>
>>>>> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
>>>>> Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>>>>
>>>> I tried this in mainline linux with the following command.
>>>>
>>>> qemu-system-arm -M bpim2u \
>>>>           -kernel arch/arm/boot/zImage -no-reboot \
>>>>           -snapshot -drive file=rootfs-armv7a.ext2,format=raw,if=sd \
>>>>           -nic user \
>>>>           --append "root=/dev/mmcblk0 rootwait console=ttyS0,115200" \
>>>>           -dtb arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dtb \
>>>>           -nographic -monitor null -serial stdio
>>>>
>>>> Main problem is that the SD card gets instantiated randomly to
>>>> mmc0, mmc1, or mmc2, making it all but impossible to specify a
>>>> root file system device. The non-instantiated cards are always
>>>> reported as non-removable, including mmc0. Example:
>>>>
>>>> mmc0: Failed to initialize a non-removable card
>>>
>>> Do you mean that QEMU randomly connects the SD card to
>>> a different MMC controller each time, or that Linux is
>>> randomly assigning mmc0 to a different MMC controller each
>>> time ?
>>>
>>
>> Good question. Given the workaround (fix ?) I suggested is
>> in the devicetree file, I would assume it is the latter. I suspect
>> that Linux assigns drive names based on hardware detection order,
>> and that this is not deterministic for some reason. It is odd
>> because I have never experienced that with any other emulation.
> 
> Yeah, I don't really understand why it would be non-deterministic.
> But it does make it sound like the right thing is for the
> device tree file to explicitly say which MMC controller is
> which -- presumably you might get unlucky with the timing
> on real hardware too.
> 

Agreed, only someone with real hardware would have to confirm
that this is the case.

>> A secondary problem may be that Linux thinks that the first
>> drive is not removable, even though it is a SD drive. I  think
>> that is a problem with qemu, but I don't understand the qemu
>> code well enough to understand why. It seems that the mmc
>> capability register always has bit 8 set, even for the first
>> drive, but I don't know where/how that is set and how to
>> change it. SDHCI has the capareg property, but that isn't
>> used here (or I don't know how to use/set it).
> 
> Yeah, this seems likely to be something we're getting wrong.
> I assume on other QEMU boards the SD card appears as
> removeable ?
> 

Yes. With some added debugging, sabrelite, and no drive provided
in the qemu command:

mmc0: SDHCI controller on 2198000.mmc [2198000.mmc] using ADMA
############# mmc0: No card inserted, removable=1
mmc1: SDHCI controller on 219c000.mmc [219c000.mmc] using ADMA
############# mmc1: No card inserted, removable=1

Thanks,
Guenter


