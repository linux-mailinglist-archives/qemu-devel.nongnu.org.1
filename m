Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 742727EE573
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 17:48:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3fWA-0001V2-20; Thu, 16 Nov 2023 11:47:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r3fW8-0001Up-AD
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 11:47:00 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r3fW6-0000wc-LP
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 11:47:00 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1ce1603f5cdso9155745ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 08:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700153217; x=1700758017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kTiZNYplhl/041QKuSxEZ4FOJuMBBI7du6CQrObG5lw=;
 b=dTJFyclo+vg2IGenThKJerdYXdmeNxvc6+hxiLOtIFxY9PWMbZVNj1V4ctGaq9yEZb
 /2sdleREPrCQoAf0HiFJpzc3Pk0IupVjzJ7BcLzT9pte8RsOInGY0VuLwH7gtu3AoxLb
 HfLghsb0urLtvqUCD+xrVJEqCXYeAS6gQTMcaBjokKZutVyyrKCA1S7hJTvt7JyRz1oh
 KehdRljMQ7jVFG8T4nU4QxJgvHYPVPgdBoH6EW1B1DzY65oAF9/OuWvxCOPlj/PijNvB
 bDOMuqpqhJ7XX54QN5C/jes/MU6MTJb2Ijb85FQbkJDasjNFTqYbdMdxNuFJslI+eztT
 7MUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700153217; x=1700758017;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kTiZNYplhl/041QKuSxEZ4FOJuMBBI7du6CQrObG5lw=;
 b=Wk0j+FcEVneUjVgCxq48daKDPWvJ7X3IY4uDX3bHDYlN66yT1UvDZQvPWPji/Vvb93
 PJ1V6/+CaXpH6D/xqXOEubPMpCwo0H9q8Nw5pbJ1cMdB7upKUGKadPXW4Ba+yTTUpdOz
 62Y1D+MFv78/q1HTBY2XZE6hpAe/i3Ko87xMmWL5s5i95Y9UsXkGv1dEJWZw9zfw2NSu
 gwSQhundUkhHSmIq+iJwiOYFRinHoKaP7nm9W1YUi2U25sriHiiaCQRMMAv/RHCBit08
 fQkRqCnsp5pdhBePvBH6vyaR0aCyJ9/X2oroQubzlcxj0zWB99YJkXJ/P52xf1oCLrcr
 aRJg==
X-Gm-Message-State: AOJu0YxcEk+SHkrzgYK55YTXFk6pSC7M7cJoX3vVzleM18yYyb8167YJ
 FRHiV4HA4bmB9bEnt2jFCSPICw==
X-Google-Smtp-Source: AGHT+IE0XSYmaqfDfSP6nMrdpEN21HNkX/QIPd8JosW7mNzUP5aySrtFscSOctHrG90AXaFUTvwExg==
X-Received: by 2002:a17:902:e843:b0:1cc:6308:9262 with SMTP id
 t3-20020a170902e84300b001cc63089262mr9524664plg.15.1700153217098; 
 Thu, 16 Nov 2023 08:46:57 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 q18-20020a170902dad200b001ca82a4a9c0sm9367019plx.309.2023.11.16.08.46.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 08:46:56 -0800 (PST)
Message-ID: <e7a07f41-1c0f-4f4d-b740-7d06d0ec6b92@linaro.org>
Date: Thu, 16 Nov 2023 08:46:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2? 0/6] hw/arm/stm32xxx: Report error when incorrect
 CPU is used
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231115232154.4515-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231115232154.4515-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 11/15/23 15:21, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (6):
>    hw/arm/stm32f405: Report error when incorrect CPU is used
>    hw/arm/stm32f205: Report error when incorrect CPU is used
>    hw/arm/stm32f100: Report error when incorrect CPU is used
>    hw/arm/msf2: Simplify setting MachineClass::valid_cpu_types[]
>    hw/arm/npcm7xx_boards: Simplify setting
>      MachineClass::valid_cpu_types[]
>    hw/arm/musca: Simplify setting MachineClass::valid_cpu_types[]

With the const fix,

Series
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

