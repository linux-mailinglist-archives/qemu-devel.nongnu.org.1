Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D5375F8C2
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:46:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvs4-0004KF-Hm; Mon, 24 Jul 2023 09:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1qNvrq-0004FT-9I; Mon, 24 Jul 2023 09:44:54 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1qNvrn-0003D9-3k; Mon, 24 Jul 2023 09:44:53 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3464c774f23so20897045ab.1; 
 Mon, 24 Jul 2023 06:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690206287; x=1690811087;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=Jue9PH9WPlWXTylwlfsq4HSRphdKmYXJDoBNdBr9Rr0=;
 b=el2vhZqUZBLRJYfI1lTZkY+PBMwNQI5fbDhOFW6MIfJtgCs7LGP9EVF20Hn2fXUvab
 tMXk7whmRRuRx3UV/nG35fGtLtXqCUd75PoKWXqspPm7KjhuCJOVMjQHK4l37VlysnX6
 YnFl5whHILzFH7mjK6SXQd3g49EYVp9EKGHMCcvU2LIKLGGJF5lYPsST1VoJoiSs6UKb
 NDzui+Nu1Nmi9zLCABMh66VjHJPUgprGP1zKnVDPyWB6ge09zrLMMLB8DGMxatAZhOPs
 bHGB28Z7d6c5Pb3jE3LEhukxiVN6ZupP3BYhE1wbT025Y8sIwqtLgSl7KSTW2N/kiEdg
 0+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690206287; x=1690811087;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jue9PH9WPlWXTylwlfsq4HSRphdKmYXJDoBNdBr9Rr0=;
 b=cwZNEdJeQRqBkrbiZnqo2Xx4xylFUcEvf4yIdEIFF16Dg+wqBZfPkb9t8/SlS9vbgf
 dLImG30la69rCd2Q+lIUTbGDMipzhZwH32CKERgqS62PRYjMjyyk4rJSi5wn5EuZmpr4
 464YLdWQjM7MdiVRFYU5aTRGH6B7eJYPoGa/JFDodfwl9zaHSxNRX4yLmK2vuMXY1P7F
 4qjbsdL1mRonx7EE03szo3gtrBP9s3KKWK/9Ipxs5ej1YnZJkufxrjUs/AIGZkHMr152
 0ZPEGQDd0jl9YUb23QSPsQW/EhTIiF6amCwbM7dSsM2VXt9sawytch7JU1OlOZVsb0lu
 tU7g==
X-Gm-Message-State: ABy/qLY8L5TicL9cuTFzdA4UUCMhZPc4WsZSZR0G9U3c/NU9ll7eY8gs
 LU04tE3kUjq8FbMZB1U/wTY=
X-Google-Smtp-Source: APBJJlEBkA7YOVOD/qPveN7N9t6y6cnhe5aXPBGmfSxYk+8SctxTNvMdBY4Paem318On6mXSIGvkbg==
X-Received: by 2002:a92:c546:0:b0:346:4f31:f0db with SMTP id
 a6-20020a92c546000000b003464f31f0dbmr9079244ilj.26.1690206287090; 
 Mon, 24 Jul 2023 06:44:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 i70-20020a636d49000000b005579c73d209sm8562625pgc.1.2023.07.24.06.44.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jul 2023 06:44:46 -0700 (PDT)
Message-ID: <61dc5162-e125-326f-b6ca-020cfd825f44@roeck-us.net>
Date: Mon, 24 Jul 2023 06:44:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/sd/sdhci: Do not force sdhci_mmio_*_ops onto all SD
 controllers
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 qemu-stable@nongnu.org
References: <20230709080950.92489-1-shentey@gmail.com>
 <52b5a36a-5744-0ac9-a3f5-0dbd247410ed@linaro.org>
 <3F4FCDD8-91B3-4331-A336-EB31E0237625@gmail.com>
 <B5DFB2DD-E01B-42A5-9907-B2988D683F9B@gmail.com>
 <13C66458-1744-4747-BF2D-72371BC00755@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <13C66458-1744-4747-BF2D-72371BC00755@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=groeck7@gmail.com; helo=mail-il1-x136.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.091,
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

On 7/24/23 00:18, Bernhard Beschow wrote:
> 
> 
> Am 16. Juli 2023 19:53:37 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
>>
>>
>> Am 10. Juli 2023 16:01:46 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
>>>
>>>
>>> Am 10. Juli 2023 10:16:35 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>>>> On 9/7/23 10:09, Bernhard Beschow wrote:
>>>>> Since commit c0a55a0c9da2 "hw/sd/sdhci: Support big endian SD host controller
>>>>> interfaces" sdhci_common_realize() forces all SD card controllers to use either
>>>>> sdhci_mmio_le_ops or sdhci_mmio_be_ops, depending on the "endianness" property.
>>>>> However, there are device models which use different MMIO ops: TYPE_IMX_USDHC
>>>>> uses usdhc_mmio_ops and TYPE_S3C_SDHCI uses sdhci_s3c_mmio_ops.
>>>>>
>>>>> Forcing sdhci_mmio_le_ops breaks SD card handling on the "sabrelite" board, for
>>>>> example. Fix this by defaulting the io_ops to little endian and switch to big
>>>>> endian in sdhci_common_realize() only if there is a matchig big endian variant
>>>>> available.
>>>>>
>>>>> Fixes: c0a55a0c9da2 ("hw/sd/sdhci: Support big endian SD host controller
>>>>> interfaces")
>>>>>
>>>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>>>> ---
>>>>>    hw/sd/sdhci.c | 8 +++++++-
>>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>>>>> index 6811f0f1a8..362c2c86aa 100644
>>>>> --- a/hw/sd/sdhci.c
>>>>> +++ b/hw/sd/sdhci.c
>>>>> @@ -1382,6 +1382,8 @@ void sdhci_initfn(SDHCIState *s)
>>>>>          s->insert_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_raise_insertion_irq, s);
>>>>>        s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_data_transfer, s);
>>>>> +
>>>>> +    s->io_ops = &sdhci_mmio_le_ops;
>>>>>    }
>>>>>      void sdhci_uninitfn(SDHCIState *s)
>>>>> @@ -1399,9 +1401,13 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
>>>>>    
>>>>
>>>> What about simply keeping the same code guarded with 'if (!s->io_ops)'?
>>>
>>> I chose below approach since it provides an error message when one attempts to set one of the other device models to BE rather than just silently ignoring it.
>>>
>>> Also, I didn't want to make the assumption that `s->io_ops == NULL` implied that sdhci_mmio_*_ops is needed. That's similar material the bug fixed is made of, so I wanted to prevent that in the first place by being more explicit.
>>>
>>> In combination with the new error message the limitations of the current code become hopefully very apparent now, and at the same time should provide enough hints for adding BE support to the other device models if ever needed.
>>>
>>> Best regards,
>>> Bernhard
>>
>> Ping
> 
> Ping^2
> 
> I would like to have the bug fixed in 8.1.
> 

+1

Not that I care too much - I build qemu myself anyway and carry the patch locally -
but this really should get fixed.

Guenter


