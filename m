Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F16877DB26E
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 05:06:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxJXL-0006Ao-5y; Mon, 30 Oct 2023 00:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxJXJ-0006AH-3D
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 00:05:57 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxJXH-00051K-Fm
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 00:05:56 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so827067966b.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 21:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698638753; x=1699243553; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A7APuptIGZX78JkQdPrGoF81T5Zdl2lXayndoUDz/wg=;
 b=o5llU9AZEgJorNKzm4BaseLiBNKQcrmlRWwuoBtJL80Ac40Mvm4NGH9MmDOWuyW2Lx
 2JmlGncjRW8Su0qGkz1tt4vftgYLJGTmmElVf6YYU+4YP7gS10Ui/yV+fImeM9GzJz1Q
 XYOFHUWAXXObsE5pEy1R9wdbkVyiSdrvTQKGDPb/raOSwPd9FCkT9/jSd+BZ7p/gRaMo
 nLjOXG+CjRuNHkyouYIy59dIqsXVwWoNu67XFBHDQLBPPxROMzaesZYa6JpbHXn+2h+V
 1FmXJyvxnHNVj1GpmE4W1XEmhnAmWo3w3iibyLnyqRwUWubthXkJG0O/qFJTLm7Qqs52
 oLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698638753; x=1699243553;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A7APuptIGZX78JkQdPrGoF81T5Zdl2lXayndoUDz/wg=;
 b=cz3eb4q/93ZeKcmIlePBTuSnFP6OwlVrNNPiA4g5pJ4PuR6L5WE1sqDjPMxTBqDF9R
 YSAl34OBssjSHPwUvoUoGeUXMPV3Jc3DHaneyiyLgku2yKpUY15bea1Hkq2XSM3XDyf5
 1zlbFi2gYP729lpvKof+XiNL5YypJMhABod/QZ7n8qpLmP4SmsAl5+Ajou7Km2LlZyTr
 yzP0WmGa3Ft4UgqUKGy5wgjHw78oartkEPEwb5erEGfzCbLxZ/zaChzXC/zeGbIi/yOY
 68J/GQ/WXOrjgg5Jdsc6lFOvmSaxGg6FrPu1q6cAMxwAmbyPw7RhofFJLg+I9wXdTn7u
 ZzPA==
X-Gm-Message-State: AOJu0YyHMAzGEtliy3PNHVeJE+uKvoWHk4zPBa6Fx45s9gQileRdIlcS
 WhsMMdSoh8ndNXmgFuTqhT7mHg==
X-Google-Smtp-Source: AGHT+IE5EEIi1OGQSmNwdwkEYK597osYWq4UCmra6FziRq3JSxtG/gW+5lkdMrHjl1ELp7G6rLAiBw==
X-Received: by 2002:a17:907:9622:b0:9bd:a029:1a10 with SMTP id
 gb34-20020a170907962200b009bda0291a10mr9747257ejc.32.1698638753570; 
 Sun, 29 Oct 2023 21:05:53 -0700 (PDT)
Received: from [192.168.69.115] ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a1709063b4a00b009ae587ce133sm5250310ejf.188.2023.10.29.21.05.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 21:05:53 -0700 (PDT)
Message-ID: <cf4b1c2f-dde1-738e-1e5d-329b9074e58d@linaro.org>
Date: Mon, 30 Oct 2023 05:05:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v9 4/7] hw/isa/vt82c686: Implement PCI IRQ routing
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, ReneEngel80@emailn.de
References: <cover.1678188711.git.balaton@eik.bme.hu>
 <fbb016c7d0e19093335c237e15f5f6c62c4393b4.1678188711.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <fbb016c7d0e19093335c237e15f5f6c62c4393b4.1678188711.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.972,
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

Hi Zoltan,

On 7/3/23 12:42, BALATON Zoltan wrote:
> The real VIA south bridges implement a PCI IRQ router which is configured
> by the BIOS or the OS. In order to respect these configurations, QEMU
> needs to implement it as well. The real chip may allow routing IRQs from
> internal functions independently of PCI interrupts but since guests
> usually configute it to a single shared interrupt we don't model that
> here for simplicity.
> 
> Note: The implementation was taken from piix4_set_irq() in hw/isa/piix4.
> 
> Suggested-by: Bernhard Beschow <shentey@gmail.com>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Bernhard Beschow <shentey@gmail.com>
> Tested-by: Rene Engel <ReneEngel80@emailn.de>
> ---
>   hw/isa/vt82c686.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)


> +static int via_isa_get_pci_irq(const ViaISAState *s, int irq_num)
> +{
> +    switch (irq_num) {
> +    case 0:
> +        return s->dev.config[0x55] >> 4;
> +    case 1:
> +        return s->dev.config[0x56] & 0xf;
> +    case 2:
> +        return s->dev.config[0x56] >> 4;
> +    case 3:
> +        return s->dev.config[0x57] >> 4;

Shouldn't this be & 0xf?

(This is why I prefer extract8() over manual bits extraction)

> +    }
> +    return 0;
> +}


