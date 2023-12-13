Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD776811DE4
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 20:02:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDUTJ-0002b2-Fc; Wed, 13 Dec 2023 14:00:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDUTH-0002ac-Vg
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 14:00:39 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDUTG-0002Wf-D6
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 14:00:39 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a22f59c6aeaso163745666b.2
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 11:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702494036; x=1703098836; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uju6HCro1RYQ8eo4/sl2eeTL4CgER9vxKG2dc3buWcI=;
 b=K65edvol/ANl8HPV7Pb+96FtxX1m6Or6ug71sdY+LfzVv0Z3OKUSLtkOPN1ehfmCH5
 pgptzj0wSO/v+BEqchr2el+pa73ja5BzFAF6sTrJj29+mpDEhCV8By8InwhBRN2uQ9yC
 gid+bxtLdkWJGNhQOA3ZmIV3fN50s+JzaSYWNw3FU2gaTHte1RnJGv1/5q9l+Dz5qjWo
 HlK9MXk9qZvfXq7+GrSv2QNz5ofehdTy+dvOlzdnU9xb+fhH4OuBC9iV7NsKuSET0iLV
 +Zyv7fTxaGRwEUfomvMmSt0QVwDhzzPsCMWCc2Rtc38BxvKKC2jv2LVi0bUP9KO+Vqwy
 JnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702494036; x=1703098836;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uju6HCro1RYQ8eo4/sl2eeTL4CgER9vxKG2dc3buWcI=;
 b=ksRrdsnGmyPbZq6f5Lso+bwpeo+ET10Sp0A7S4acHC08hm5sllzCGghRKO90CM0iQe
 qVoo/pDbFragmPlxDYaYw42NcDzIIdR1RdfgMx1bpvLm3Un6NwQJqWx7XEc5ZRZ9b5iX
 0A1g7ec/CT974jNreZiqaRbelPxtXypcdrGXA/N9Sj59+6zG7O/rx2utIFdR0AuLciWF
 l3fw4XfmDbl+Si2NYHUIV8Q2g+0tQdrpoUaaBC6MgpEhrdDJe2GXnuxIUH0HKJLBZmEh
 VJ5KQ0c6/t8ApDin1bIrpD57Nkw0jSMeEou0U4ZqaLdiBdMywuBVuB0/viT+hXYZRWF1
 VTdA==
X-Gm-Message-State: AOJu0Yzjn2+mCdHsmWCzexNjqdJtcouitaf2bzUE8OM2ohJiuqm3r9sE
 BWulHK201L3Mj/XnDaQ2Q0Qyww==
X-Google-Smtp-Source: AGHT+IHI0biE1P2PiF9LjGUe5KxS7Kb4TIBenzjQo2KCP/HqMtqyWVZXPUpmh29Wn6JhAeAmrCpudA==
X-Received: by 2002:a17:906:c14e:b0:a19:a19b:5603 with SMTP id
 dp14-20020a170906c14e00b00a19a19b5603mr5482995ejc.147.1702494036695; 
 Wed, 13 Dec 2023 11:00:36 -0800 (PST)
Received: from [192.168.1.120] (tmo-066-178.customers.d1-online.com.
 [80.187.66.178]) by smtp.gmail.com with ESMTPSA id
 cx11-20020a170907168b00b00a1d5ebe8871sm8155535ejd.28.2023.12.13.11.00.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 11:00:35 -0800 (PST)
Message-ID: <96306f5d-db3d-466a-a9f7-800410d4b903@linaro.org>
Date: Wed, 13 Dec 2023 20:00:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/pxa2xx_mmci: Disable reentrancy detection
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20231213014932.1748323-1-linux@roeck-us.net>
 <CAFEAcA9KU855jn8xDQtbf58Byg0NCq-aB3tPcf8sB6YLyLkvWQ@mail.gmail.com>
 <9acdbf95-492d-4cce-98f5-d774a277d214@linaro.org>
 <77e4b77e-ce9f-41a2-b11a-f44ea6bb7412@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <77e4b77e-ce9f-41a2-b11a-f44ea6bb7412@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 13/12/23 19:04, Guenter Roeck wrote:
> On 12/13/23 09:19, Philippe Mathieu-Daudé wrote:
>> Hi Guenter,
>>
>> On 13/12/23 18:12, Peter Maydell wrote:
>>> On Wed, 13 Dec 2023 at 01:49, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> All tests using pxa2xx_mmc to access mmc cards on pxa2xx platforms
>>>> such as borzoi fail starting with commit a2e1753b80 ("memory: prevent
>>>> dma-reentracy issues"). Disable reentrancy guard to fix the problem.
>>>>
>>>> Fixes: a2e1753b80 ("memory: prevent dma-reentracy issues")
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> ---
>>>>   hw/sd/pxa2xx_mmci.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
>>>> index 5e8ea69188..27ae8f2888 100644
>>>> --- a/hw/sd/pxa2xx_mmci.c
>>>> +++ b/hw/sd/pxa2xx_mmci.c
>>>> @@ -555,6 +555,8 @@ static void pxa2xx_mmci_instance_init(Object *obj)
>>>>       qdev_init_gpio_out_named(dev, &s->rx_dma, "rx-dma", 1);
>>>>       qdev_init_gpio_out_named(dev, &s->tx_dma, "tx-dma", 1);
>>>>
>>>> +    s->iomem.disable_reentrancy_guard = true;
>>>> +
>>>
>>> All patches that set this flag should include a comment which
>>> explains what the device access path that triggers the reentrancy
>>> is, please.
>>
>> Can we get a reproducer or backtrace please?
> 
> qemu-system-arm: warning: Blocked re-entrant IO on MemoryRegion: 
> pxa2xx-mmci at addr: 0x40
> [    0.770246] mmc0: invalid bus width
> [    0.770962] mmc0: error -22 whilst initialising SD card
> [    0.828179] mmc0: invalid bus width
> [    0.828445] mmc0: error -22 whilst initialising SD card
> 
> with:
> 
> qemu-system-arm -M borzoi -kernel arch/arm/boot/zImage -no-reboot 
> -snapshot \
>      -device sd-card,drive=d0 -drive 
> file=/tmp/flash,format=raw,if=none,id=d0 \
>      -usb -device usb-net,netdev=net0 -netdev user,id=net0 \
>      --append "root=/dev/mmcblk0 rootwait console=ttyS0"

Thank you, I'll have a look after Christmas.

Regards,

Phil.

