Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB16811BEB
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 19:06:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDTaw-0006JQ-9Z; Wed, 13 Dec 2023 13:04:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rDTam-0006Gz-6p; Wed, 13 Dec 2023 13:04:21 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rDTai-0000Id-93; Wed, 13 Dec 2023 13:04:19 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5ca0b968d8dso1641908a12.1; 
 Wed, 13 Dec 2023 10:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702490653; x=1703095453; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=9NCcGbwXfN+o9Uudz1Xx4Lrwa/mXkdncPsFm6ZKjOnk=;
 b=gOX614IqbaJZl/sJzqxQ6/h0DXFrRDhc6x8cqB2SUB+Bx6ym3wxAtfw6uMQnuBVIRi
 doZMdSQdt8Oyd71KVlIU1Izbnn9KQeFcyO0mlAjhLHkKODNOucDuPc4qV7RCcN72zrVF
 YOVhXFJRYHsLh8LmvUkIa1JIZfnAmxCUE+s4QYDis6ofs0iKOrF0U3FVgZQDPCDjIk9E
 X5YzyE/EANennEN4NljZbSRwxF4GB2RLT/0UMi2wIj0Da/eBe9mlp3P0RO4qJnUBxOwA
 amMgOYumal2qk33/MRiNrd6qqVfXAb6BVy4CdzP+PG99vuvInim59nlpEOfuFtaA5TnP
 vS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702490653; x=1703095453;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9NCcGbwXfN+o9Uudz1Xx4Lrwa/mXkdncPsFm6ZKjOnk=;
 b=H0WdXGOkYryARFNZLIvBPxMcdZfFAQEgYMHn/N+B3CBjTL80ZCgYDWhBOqx3r3zCDY
 S4GzC5YMEBVoPX5FedkgileupAC/CO3YXTjMdzr6yr5JSSmpg0nQZAwnBF8pstMqLnPl
 YiWMCNubLsFpE5sKRkPzHmZkP7RsU/CFrwWf2iE8ZIf5SlE9EtLeMRAFow6A5hvNRwMO
 K5a8mjXW98A4/JX4DN4pEYT56Dd2cc4h1wFvFhv4KwEBAyykPt2CGFMrav5e15Gss12E
 ZhFeaDeyiFLxHEdhMNek1tJRe+rWALi/ut2yxRv0QQjtQJvEEJscxANet+Xr3FdF69+H
 BV0g==
X-Gm-Message-State: AOJu0Yws9UUhWUDT20/4Ni3o+082oc8J2JEuQ7rrL+dkhQGrbyMLChOs
 NRMdEoTjf2Jhjb8dc3EJlvt3PUn/aiM=
X-Google-Smtp-Source: AGHT+IF2g+exS/21cYK7JRPLbV8f4ItDU9MQ/9yzVcIsAQ1TCNmdI8rvrJClRPc7DIFO8JIOo0LYzw==
X-Received: by 2002:a05:6a20:938e:b0:190:9d87:f9f7 with SMTP id
 x14-20020a056a20938e00b001909d87f9f7mr3684007pzh.43.1702490653049; 
 Wed, 13 Dec 2023 10:04:13 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 x6-20020aa784c6000000b006c8b14f3f0asm10224214pfn.117.2023.12.13.10.04.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 10:04:12 -0800 (PST)
Message-ID: <77e4b77e-ce9f-41a2-b11a-f44ea6bb7412@roeck-us.net>
Date: Wed, 13 Dec 2023 10:04:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/pxa2xx_mmci: Disable reentrancy detection
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20231213014932.1748323-1-linux@roeck-us.net>
 <CAFEAcA9KU855jn8xDQtbf58Byg0NCq-aB3tPcf8sB6YLyLkvWQ@mail.gmail.com>
 <9acdbf95-492d-4cce-98f5-d774a277d214@linaro.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <9acdbf95-492d-4cce-98f5-d774a277d214@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12/13/23 09:19, Philippe Mathieu-Daudé wrote:
> Hi Guenter,
> 
> On 13/12/23 18:12, Peter Maydell wrote:
>> On Wed, 13 Dec 2023 at 01:49, Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> All tests using pxa2xx_mmc to access mmc cards on pxa2xx platforms
>>> such as borzoi fail starting with commit a2e1753b80 ("memory: prevent
>>> dma-reentracy issues"). Disable reentrancy guard to fix the problem.
>>>
>>> Fixes: a2e1753b80 ("memory: prevent dma-reentracy issues")
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>>   hw/sd/pxa2xx_mmci.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
>>> index 5e8ea69188..27ae8f2888 100644
>>> --- a/hw/sd/pxa2xx_mmci.c
>>> +++ b/hw/sd/pxa2xx_mmci.c
>>> @@ -555,6 +555,8 @@ static void pxa2xx_mmci_instance_init(Object *obj)
>>>       qdev_init_gpio_out_named(dev, &s->rx_dma, "rx-dma", 1);
>>>       qdev_init_gpio_out_named(dev, &s->tx_dma, "tx-dma", 1);
>>>
>>> +    s->iomem.disable_reentrancy_guard = true;
>>> +
>>
>> All patches that set this flag should include a comment which
>> explains what the device access path that triggers the reentrancy
>> is, please.
> 
> Can we get a reproducer or backtrace please?

qemu-system-arm: warning: Blocked re-entrant IO on MemoryRegion: pxa2xx-mmci at addr: 0x40
[    0.770246] mmc0: invalid bus width
[    0.770962] mmc0: error -22 whilst initialising SD card
[    0.828179] mmc0: invalid bus width
[    0.828445] mmc0: error -22 whilst initialising SD card

with:

qemu-system-arm -M borzoi -kernel arch/arm/boot/zImage -no-reboot -snapshot \
	-device sd-card,drive=d0 -drive file=/tmp/flash,format=raw,if=none,id=d0 \
	-usb -device usb-net,netdev=net0 -netdev user,id=net0 \
	--append "root=/dev/mmcblk0 rootwait console=ttyS0"

Guenter


