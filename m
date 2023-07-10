Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B5774DEA3
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 21:55:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIwy7-0003Ea-Jh; Mon, 10 Jul 2023 15:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIwy5-0003E6-7V
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:54:45 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIwy3-0007Pn-F4
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:54:44 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so62603465e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 12:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689018881; x=1691610881;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4uenKRb8epFP9SZcF4EIdVm25VAcCqokO4QTfgenYEQ=;
 b=WZ7mN5oC6Kj6CSPsx+6qD/yU/JMKEnOzUkra5cC1ohv8Ys7HRaFTb9n36ECezgWhbL
 x6Ht78Wl+bMnkssSU15TjwLoG4wWWNvb39/q4M5h/t0zE3PwbgIiKx1az9qbmFAZcR/5
 8Sd4R3JUibJ1522y5fUpzDdxq3YByiINuwR0NkHAqTb964uyxGa4fX0YJH5cWWx6C08R
 xbxS4eMf6a4hzfasU2tg/nD51I3U9ZBLPuVLTafHwbuxSBYmlhW6W1KqJY8/Z4yMz9aL
 G1gfLo9ZjeTlFcfa6LJxDGQAAdcNIKgddMfcjxclFI1YabDB2xBGVUQXMkPqb453mwAx
 Y9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689018881; x=1691610881;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4uenKRb8epFP9SZcF4EIdVm25VAcCqokO4QTfgenYEQ=;
 b=eakNSGmrXz2cX6RhLdX+Zu1tGH1JWqR7iqVPaVDCo7q8RwSL/8bfZ8r9HJsMfKBd/e
 soVmF31g11eqxYz95CTDRAwLQUdF1qCiVu17xQerTU/6erOwW8Sjvq/rd/ilEAf7Ath3
 c0rOjoLgyL6CCPPjeU2vEipvnqL3hIktwoV7f5dkPLxIGca7WHnyZbnTwOfR918jX95/
 iKHt1lcUa0YqVU8QrPbrpgc1x07+RLjHhxayF8NJua+Mblk/4s5OSISG9Pp2Gc4llsKr
 /EbnYjPukbgAHT6b8k6RidBaT8ZtCrn7nZOVSJmhKlgIC32XZJ7y4dfNBgyNl6lK9fPg
 JT+Q==
X-Gm-Message-State: ABy/qLYZUi9RtS0cpLCCdSx6rpfQ7bjl9DUwK8k/l3ygD2i4QvrrOZe0
 Km+HKNMIi3ZFLlZN5gHTRiQ4WA==
X-Google-Smtp-Source: APBJJlFh3eImxUvPQXoEG0ME5nDfZ7M6oJ1VgxaClG9y/Zda1Sq2wxZ6DoXGK27FmbkcigQ1Oued9g==
X-Received: by 2002:adf:e34b:0:b0:314:3344:326b with SMTP id
 n11-20020adfe34b000000b003143344326bmr14683827wrj.71.1689018881518; 
 Mon, 10 Jul 2023 12:54:41 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 f14-20020a5d58ee000000b003143c532431sm275036wrd.27.2023.07.10.12.54.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 12:54:41 -0700 (PDT)
Message-ID: <49822ce6-e84b-7f49-d343-873fb8f540bb@linaro.org>
Date: Mon, 10 Jul 2023 21:54:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] MIPS: Enable Loongson-3A4000 TCG for system emulation
Content-Language: en-US
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: yangxiaojuan@loongson.cn, gaosong@loongson.cn, chenhuacai@kernel.org
References: <20230521214832.20145-1-jiaxun.yang@flygoat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230521214832.20145-1-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 21/5/23 23:48, Jiaxun Yang wrote:
> Hi there,
> 
> This series enables Loongson-3A4000 TCG for system emulation.
> It Implemented Loongson CSR insertions which is required for
> Linux Kernel to probe CPU features and removed CPU type restrictions
> for loongson3_virt board.
> 
> This series is based on two of my previous series[1] [2]. However it's
> just a soft dependency for me to do boot test, feel free to apply this
> series without them.
> 
> Note that loongarch_ipi is still not hooked up in IOCSR. I've sucessfully
> done it locally but I just want to confirm some details on hardware.
> 
> Thanks
> - Jiaxun
> 
> [1]: https://lore.kernel.org/qemu-devel/20230521102307.87081-1-jiaxun.yang@flygoat.com/T/#t
> [2]: https://lore.kernel.org/qemu-devel/0bb0cded-8450-536e-b90f-1a9d33311c2a@linaro.org/T/#t
> 
> Jiaxun Yang (2):
>    target/mips: Implement Loongson CSR instructions
>    hw/mips/loongson3_virt: Remove CPU restrictions for TCG

Thanks, queued to mips-next addressing the review comments.

