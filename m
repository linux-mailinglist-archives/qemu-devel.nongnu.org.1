Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B99860AD0
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Feb 2024 07:30:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdP3i-0005yI-6i; Fri, 23 Feb 2024 01:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdP3f-0005xm-QF
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 01:29:19 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdP3R-0001Bc-Ix
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 01:29:17 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a3d5e77cfbeso95535366b.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 22:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708669743; x=1709274543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cw/A/P1yk9clR7XU1zO45ALsyOeTZOKcg37yUmDe984=;
 b=GDSnPQGeyruDt+VoPq30YsH3FkKgsP8F/Vi6vAvPdeKeicLXJfdhPxJCmuEiPCS9rA
 o9xADI7TqT/Gb0jvyoPL9qoMwFc5oi24kBJYlRwQL46xMXK16Df21SW8QtyAyMRZwyqq
 js/UpZGrYgTUYdPxoo5Go397fIRT+wDw+M2uK9u5n7c96vI2PWe7atmsZwF9INxN9qJG
 N12nu070G8VB0wzp8EZ2TZWt/2OcRB/LUxhqnGR8KSn5rJQaLgdEAJm2OiSf7n/8R8kL
 p5En96VKdP6vdCikfF7ZwHoSsORqAJVpqbZWCkZ7r084et5Hzg0jNnvjabRaaISYnx4S
 wBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708669743; x=1709274543;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cw/A/P1yk9clR7XU1zO45ALsyOeTZOKcg37yUmDe984=;
 b=oQobLffYnsjVrWBgk5aBmP6tNM2nYVMWuDkojaZlDR//L1mnwKj5iorCr+cyTD/lpZ
 7SbQKxGCy9P+8pT+7ZuC2PWEn4+o9x1uhOcOE+pPEti92cP1hu9IVSDdXt0muGGzOlz7
 U52KuhxHYVvokGIxl+l7EZzTY5C2L+1grGN3VCqGjZWLpLZpHbO/Kg+8LppiWhaMUuml
 TSAg+o2Nw1mjFOGMmrvyP99V6aQsAVq7m9NltrDLyDtwh1IkcmYleejH4fqrh4PNw9lF
 IY6KCHMAicdw9JbOCJgttutBXyn15nK1ch6x5JNvV69lN/BX+ccbGhe1c4ikNoe+CBnP
 ZU9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbbjS/7CCbgRW000aIi4L3+KF17HIMRFmg4AXIzLQNXa5T9SvGjhh/fvfDVk9kAjDjEur5DdKKQf2OwR2pB0sdYz3ZRlc=
X-Gm-Message-State: AOJu0YxC1ku0+UAqrt5Oyof8ieps2Hhfm+6VpQXUmc4TmA30vfHh29B7
 wKzTA5M21a0ROplkcooqMuwvAs2CVjRRxwc96myh3L7nJWAyHgHSF5CyM3EKjp8=
X-Google-Smtp-Source: AGHT+IEUdjJ3WIL9hEKhVktFh9bCwYQp3lR/1zjVAwjV6icEpMOt9A2+xzGmP1AmhBIOm/d0t2rD7g==
X-Received: by 2002:a17:906:f14d:b0:a3f:421:26a5 with SMTP id
 gw13-20020a170906f14d00b00a3f042126a5mr939237ejb.12.1708669743519; 
 Thu, 22 Feb 2024 22:29:03 -0800 (PST)
Received: from [192.168.69.100] (sto95-h01-176-184-18-96.dsl.sta.abo.bbox.fr.
 [176.184.18.96]) by smtp.gmail.com with ESMTPSA id
 x19-20020a1709064bd300b00a3cf168d084sm6600978ejv.165.2024.02.22.22.29.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 22:29:03 -0800 (PST)
Message-ID: <685d336b-2366-46c0-8d0d-088ef47a952c@linaro.org>
Date: Fri, 23 Feb 2024 07:29:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/arm: Use TYPE_OR_IRQ when connecting STM32L4x5
 EXTI fan-in IRQs
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240220184145.106107-1-ines.varhol@telecom-paris.fr>
 <20240220184145.106107-2-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240220184145.106107-2-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 20/2/24 19:34, Inès Varhol wrote:
> Fixes: 52671f69f7a4 ("[PATCH v8 0/3] Add device STM32L4x5 EXTI")
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   include/hw/arm/stm32l4x5_soc.h |  4 ++
>   hw/arm/stm32l4x5_soc.c         | 80 +++++++++++++++++++++++++++++-----
>   2 files changed, 74 insertions(+), 10 deletions(-)

Thanks for cleaning that!
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


