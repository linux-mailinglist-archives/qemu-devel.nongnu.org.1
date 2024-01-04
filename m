Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7848242FE
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 14:48:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLO4p-0004J7-RE; Thu, 04 Jan 2024 08:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLO4l-000480-BM
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:48:00 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLO4j-0003gG-C6
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:47:59 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40d76923ec4so4652535e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 05:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704376075; x=1704980875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DliT4hOlGihAIrNhSmS13X+aX8dNM5Idvh0MCUHG4AQ=;
 b=U/7x7ekD4IYlwAimzMJdTnRlpbnjCDKl0RrsNE1lZJlJ3usKmC6jZQBdRmB+rTlQN3
 3lkW0zgdkis/xUt8hdorVnhkOw912MQ0vKRBRxv7/oI28EctXoEneoxqq9GSIJYajatV
 WKBy8s1GspD/F4yDDxPxUfB4Vi14oLar8e7duL646JTTzuahpcL4Kt8JkipEZioK1tW4
 3zrRmadKja/UCWWzf/kaAMLjfHJVKw9yvU2Rpag0qDcv+VrLrebNMogYVcnFtm6UjQzE
 eXmPfc/ZemP/EnejhCVdggqMpfA6/OG8nJSRuEhPJQqcOxV1hYD3GKPWYrttKIAOuTvx
 lhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704376075; x=1704980875;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DliT4hOlGihAIrNhSmS13X+aX8dNM5Idvh0MCUHG4AQ=;
 b=MLR+Bx4+CBaHEwDcPth1j7IuOqYaB4uGeG7M7wjr8EiRILUN/cAtYUHO6u5pcyDWBE
 FBQJkc+zjGiGFvJRebOLYPa8RjxaNgI68DT4zVrYydJYTtjkLZQPsjSnj09/rQHm8QAA
 WZxPe/nv8Vd/8qJZJtSVRR1C3sOJ4PFRrX7ZyUTKnU645zYqGAZWNCMkEGG6cYIcUTN1
 FB0DXsLmgvvUZzyx7lb02h0RAz+8MhJ+RQSmF1o58dJ2PLfpQXYiZhSNl221gp1Q6/zN
 2qgnkNxrlr3XHP18WBaM/deCesGLYJ8RKr7GtxmP05ayO0pLQlbKPnHbRh+wSVzfU1ES
 I//A==
X-Gm-Message-State: AOJu0YwVq4qgc3ODZa1wXRHyEQwOvzHyOd0IC2somMhzH14EjToMmfCQ
 xMJMFahlp8JQRMNk+1xF3BFFydd281uYwg==
X-Google-Smtp-Source: AGHT+IE3TraElgBjSPk5YaoVf0r713HF9vtwOvPnWM7vqWGB+g9oTPngnKnR569F08nwqXUccS50SQ==
X-Received: by 2002:a05:600c:6b17:b0:40d:8587:a77f with SMTP id
 jn23-20020a05600c6b1700b0040d8587a77fmr384305wmb.90.1704376075348; 
 Thu, 04 Jan 2024 05:47:55 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a05600c359000b0040d5a5c523csm5820118wmq.1.2024.01.04.05.47.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 05:47:55 -0800 (PST)
Message-ID: <05df4322-0f91-4423-a065-9636fac7a005@linaro.org>
Date: Thu, 4 Jan 2024 14:47:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Add device STM32L4x5 SYSCFG
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
References: <20231229164915.133199-1-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231229164915.133199-1-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 29/12/23 17:47, Inès Varhol wrote:

> Based-on: <20231228161944.303768-1-ines.varhol@telecom-paris.fr>
> ([PATCH v5 0/3] Add device STM32L4x5 EXTI)
> 
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> 
> Inès Varhol (3):
>    hw/misc: Implement STM32L4x5 SYSCFG
>    tests/qtest: Add STM32L4x5 SYSCFG QTest testcase
>    hw/arm: Connect STM32L4x5 SYSCFG to STM32L4x5 SoC

Very good work!

In case that helps, I pushed my reviewed branch of your
series here:
https://gitlab.com/philmd/qemu/-/commits/review/stm32l4x5-v5/

Regards,

Phil.

