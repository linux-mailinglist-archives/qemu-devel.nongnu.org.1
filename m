Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E7773BEEA
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 21:35:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCmXb-0005MX-O6; Fri, 23 Jun 2023 15:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1qCmXY-0005Ls-Rb; Fri, 23 Jun 2023 15:33:52 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1qCmXT-0003SS-4R; Fri, 23 Jun 2023 15:33:52 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-666eba6f3d6so640765b3a.3; 
 Fri, 23 Jun 2023 12:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687548825; x=1690140825;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bXZHjR/v72gPP+RwjpKfh3hgVQFSDYbtLcZ/Dut1sUE=;
 b=ZRnRZdCD9Zc8LI2SQevKrTfS27Gu2DBRuZIXaXHvOr4bVUCsQ9+5TutM+vZS9+QZkU
 Q6k3UsRyV9FvRr7hDnw7rEU9BL82es34bKkoGDe+Hsat/IJ3WzJXUOaCZM7M3P0kl+z/
 KiAkZfmulUVo/3fnCoNW5pke8zFNRdJPyvU7U559D3zWqZn78MT4lPQEqm0RNptH7/Il
 2dBCYd02ap9LzdUHSOgGY9kbnRGY8IteR/quWDIRFgUzG0o7ws1xpZVzc39W2LWWt8Nu
 myTCuSW1VdfwDcVgL4IUBrKX1kMgEFS6nRP2t99bqqP1BqdpLVbhwlKsUlGJ6rBXRK+G
 mtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687548825; x=1690140825;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bXZHjR/v72gPP+RwjpKfh3hgVQFSDYbtLcZ/Dut1sUE=;
 b=NBS8NzXZlxr6K/hiysBsQor7XnsCjVUyCmTnmUIkNvFxC2zAGE8RAiSGB2c9RoHSt0
 4kpbE2Gwzz79nX7omnwYJJO064VsgnIKsKFf1re6SL6cRYQry7A7dOwtdVKeq7o92So8
 Hc1pW++SZ/iX75yKwRocYhWwHjQRMHWK/4SHivYtg1fDKtfdFXGa3AGZ2tv2wCmPGGqR
 kKvv7kwaq0iLg3yCUs9xglHnT/HUVRPimLNjQDooRVI592jxK1Z7v/L48UKJZWAhbNEO
 b/vxKKQLYMcsg5nLdBerTtBjQZHbIPM/tD0ra0VFSmm636fVt9cJ1ZjHHYPSHeo6mKxV
 OPfA==
X-Gm-Message-State: AC+VfDz+lJYq6BQvCvxGv7VC0TGvQAbb0AjSXxKCzVQmKgj6+yvESLGv
 I40igCEi39/BraR75nysDsI=
X-Google-Smtp-Source: ACHHUZ5EYt4DiHawNMwz8EzYMy/n5DR37FkVT33dTD4Mz+SgLNulVZAauOoZVz0CAT2RIVRnQZcpVg==
X-Received: by 2002:a05:6a20:7295:b0:115:a2f4:6284 with SMTP id
 o21-20020a056a20729500b00115a2f46284mr11524912pzk.16.1687548825308; 
 Fri, 23 Jun 2023 12:33:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 j22-20020aa78d16000000b0066a67637cfasm1837293pfe.26.2023.06.23.12.33.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 12:33:44 -0700 (PDT)
Message-ID: <2044dc69-93de-d855-fe44-ee6f3ab3576b@roeck-us.net>
Date: Fri, 23 Jun 2023 12:33:42 -0700
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
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 01/11] hw: arm: Add bananapi M2-Ultra and allwinner-r40
 support
In-Reply-To: <CAFEAcA8aEQWAap36CtHMrEkFQUPnDCH7=-X5+TE2GJ-qzm3Y9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x435.google.com
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

On 6/23/23 10:44, Peter Maydell wrote:
> On Sat, 17 Jun 2023 at 17:29, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi,
>>
>> On Tue, May 23, 2023 at 06:04:58PM +0800, qianfanguijin@163.com wrote:
>>> From: qianfan Zhao <qianfanguijin@163.com>
>>>
>>> Allwinner R40 (sun8i) SoC features a Quad-Core Cortex-A7 ARM CPU,
>>> and a Mali400 MP2 GPU from ARM. It's also known as the Allwinner T3
>>> for In-Car Entertainment usage, A40i and A40pro are variants that
>>> differ in applicable temperatures range (industrial and military).
>>>
>>> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
>>> Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>>
>> I tried this in mainline linux with the following command.
>>
>> qemu-system-arm -M bpim2u \
>>          -kernel arch/arm/boot/zImage -no-reboot \
>>          -snapshot -drive file=rootfs-armv7a.ext2,format=raw,if=sd \
>>          -nic user \
>>          --append "root=/dev/mmcblk0 rootwait console=ttyS0,115200" \
>>          -dtb arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dtb \
>>          -nographic -monitor null -serial stdio
>>
>> Main problem is that the SD card gets instantiated randomly to
>> mmc0, mmc1, or mmc2, making it all but impossible to specify a
>> root file system device. The non-instantiated cards are always
>> reported as non-removable, including mmc0. Example:
>>
>> mmc0: Failed to initialize a non-removable card
> 
> Do you mean that QEMU randomly connects the SD card to
> a different MMC controller each time, or that Linux is
> randomly assigning mmc0 to a different MMC controller each
> time ?
> 

Good question. Given the workaround (fix ?) I suggested is
in the devicetree file, I would assume it is the latter. I suspect
that Linux assigns drive names based on hardware detection order,
and that this is not deterministic for some reason. It is odd
because I have never experienced that with any other emulation.

A secondary problem may be that Linux thinks that the first
drive is not removable, even though it is a SD drive. I  think
that is a problem with qemu, but I don't understand the qemu
code well enough to understand why. It seems that the mmc
capability register always has bit 8 set, even for the first
drive, but I don't know where/how that is set and how to
change it. SDHCI has the capareg property, but that isn't
used here (or I don't know how to use/set it).

Guenter


