Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD6383888E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 09:11:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSBqn-0001QY-J5; Tue, 23 Jan 2024 03:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSBqk-0001QL-Q1
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 03:09:38 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSBqh-0006oE-Gm
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 03:09:37 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40eb033c1b0so16419365e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 00:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705997374; x=1706602174; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HTpOr9bWP+WOfbDkoEe4Zizbi0WuDHZ9gtbs03jHZvQ=;
 b=B1RvuPiy0A49EFP7KkX8u0txY/9Cv7i9mIbqYuei47RhGZROmjp1et7EgFB/CX9WYt
 MYn3u5z2jQtdstlDQEHPXqFsdxTGZ+QyC8f7q0jB2YaJR2q2o/pdYwA5HrHP+NYnQ7Dk
 9R0XpZCe4/olpbi8hXb9y3TQxoXP26+T2yQSSDEZDtDf/7H9yrUzL1ns5ju71KVB7tSx
 3G+8ujrv87gqj8yBQCl4if5Qhvyu/cHBB7pxzYaP7AxhbH20Yv9qVF+n3APcUwIHuxWr
 VxYtUpxgRJQXZizvxINkuHmlQKDxyD/MURYlrdBj/8Nf1oMlPgw+AdKulSdR0y3IvkA9
 fzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705997374; x=1706602174;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HTpOr9bWP+WOfbDkoEe4Zizbi0WuDHZ9gtbs03jHZvQ=;
 b=KqJ/IiFYtL+1hRMIDS1p2PSgnV5mL999z8+VaQzuBAksJjs0Pp0e52F/rW6O3pLl83
 UdOBpHNmo2S1JF+8S76xzcYnU7RNUyCg7j2+PvhNHL+Ebyep9t2ZCDxm8r96zzO/UrCj
 znSUmarstXyPyfSAuoZXJpB3K4kCOWQUh/RrgXkTtBZ/P0t+wGwHIkqzHwPSZhWLj97C
 hiR11XpC2GF66Ry4Ab/WOHJa9Mt3z7DHT8dzzpzq6Qh4kLXz/0w1JgXG2ItHin+IKyar
 w40pBjyEEt9x+2+nN/GxZMe15GFYveI1cZdlTbqxC1n2EOWjEHZNVGAeuOIeS7NIDzv2
 a7vA==
X-Gm-Message-State: AOJu0YydntBWqiBBUPLIf5M9Zjfw3zHpEHCv0iO0AM7gOGmKaVPomi/S
 UDaJchifmf5J2bQpzQCpmP1wy+H6SSV/ZDHhcG95mRvhZAYYuBQ6+77C1MIPcxE=
X-Google-Smtp-Source: AGHT+IE0cJXztiRmjKyyh1n3QNUl6xMzdTKKUZdBr2rz581pE6zUW1+8B8VrFANKlLCll4wycxdaAw==
X-Received: by 2002:a05:600c:cd:b0:40e:8fc6:763 with SMTP id
 u13-20020a05600c00cd00b0040e8fc60763mr316849wmm.77.1705997373922; 
 Tue, 23 Jan 2024 00:09:33 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 bl1-20020adfe241000000b0033935779a23sm5114372wrb.89.2024.01.23.00.09.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 00:09:33 -0800 (PST)
Message-ID: <d62f9bce-f86b-42db-8c27-6565cf1b8159@linaro.org>
Date: Tue, 23 Jan 2024 09:09:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] hw/arm: Connect STM32L4x5 GPIO to STM32L4x5 SoC
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
References: <20240122210829.127691-1-ines.varhol@telecom-paris.fr>
 <20240122210829.127691-3-ines.varhol@telecom-paris.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240122210829.127691-3-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi Inès,

On 22/1/24 22:02, Inès Varhol wrote:
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   hw/arm/Kconfig                 |  3 +-
>   hw/arm/stm32l4x5_soc.c         | 79 ++++++++++++++++++++++++++++------
>   include/hw/arm/stm32l4x5_soc.h |  2 +
>   3 files changed, 69 insertions(+), 15 deletions(-)


>   static void stm32l4x5_soc_initfn(Object *obj)
>   {
>       Stm32l4x5SocState *s = STM32L4X5_SOC(obj);
> +    g_autofree char *name = NULL;

        [1]
>   
>       object_initialize_child(obj, "exti", &s->exti, TYPE_STM32L4X5_EXTI);
>       object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32L4X5_SYSCFG);
>       object_initialize_child(obj, "rcc", &s->rcc, TYPE_STM32L4X5_RCC);
> +
> +    for (unsigned i = 0; i < NUM_GPIOS; i++) {
> +        name = g_strdup_printf("gpio%c", 'a' + i);

           [2] // alloc

> +        object_initialize_child(obj, name, &s->gpio[i], TYPE_STM32L4X5_GPIO);

           [3] // expected free

> +    }

       [4] // current autofree

>   }
If you declare the variable to be automatically free'd in the
main body scope [1], it will be free'd when the scope is leaved,
so in [4], meaning only the *last* allocation ("GPIOH") from [2]
will be free'd, all other are leaked. We want to release in [3].

Similar comment applies to stm32l4x5_soc_realize() in this
patch.

See https://docs.gtk.org/glib/auto-cleanup.html for context.

Regards,

Phil.


