Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A01F748828
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:36:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4YK-0004oP-Dw; Wed, 05 Jul 2023 11:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4YJ-0004nL-0K
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:36:23 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4YH-0007st-Dd
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:36:22 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2b70224ec56so8986991fa.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688571380; x=1691163380;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tFRLzBS2ReiPiMRAEkeepTSikaXSF8FxrPu6h9rhwEA=;
 b=KrH7b8BMaAUBkKp8Ay60DmgPqABbrJw7BUHn85/gmqyOx+mV3nJkirhQz3O5PBdGCB
 NSq7RnL9fqVbH1ZpGLRpkYOUHg0ZQjHQRnB2qFeEB3wo0zTllvcCINU77g8jjnHMVZ0b
 2K5AE46I5wdipNit8OXBrmuAoZUf0/bL9JLt32CBEaBQ/HwyE9QMNjCVc2jVYHzNurT1
 Nv6CSb7A/C5Hw0GZc/iaF+OAA6JFo9hjQZ5ozgQW8K2HzsjOvi4M9v5NV8WaHhND+/2f
 Mgp9R/1N6iouzeIBitXF/NDaHKxdRnt4BUeT7Gj17QySGC2d938yhyf+4Rxb1CZB3r/b
 HLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688571380; x=1691163380;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tFRLzBS2ReiPiMRAEkeepTSikaXSF8FxrPu6h9rhwEA=;
 b=ARW/nxprmXxX3bguDV5FQdSHJcMGfOx+1UOzzQ2AV7uRr+7mzKvdRYAL3xYRLESHFR
 3Ge3p0b8YzB/JqIkI4qYNP2cjM/o99uXR3540wGbf/7OITK22sdn7RbsYS2xwOo9FRet
 CyANJzEX5XjSH5JQ3m3HxNM3yZqJkbwjyO3VKQWhzRzR1p/DialU2sulPK3Bik6hMSiJ
 VleIcy6wH9upbrW6uUf7eOaPhTK51PUKjUFAH/e9Lpu6HbABXFjDhDHzKSRgS0hc4Y+g
 P/t4PQpS4vuCEcZ1tTfUR2VQAaZvmmloHS24gqD8fnTeReb/3b4hvZOr1ZWWB7tn/eHo
 viGw==
X-Gm-Message-State: ABy/qLb+Ei1MuP3fX7ZKrfFInfSxQCvpBGeAzsjFIdCEXjlBqrteXJ1T
 zrOvMXXwu0rNxGWS2aftGTJZfw==
X-Google-Smtp-Source: APBJJlFNwxGZ8247KoVKtapoqpczFT97ENwtlo+NYxLC7EClnh5rV5vOB8QlwdJDb85k+A+xJS9Wzg==
X-Received: by 2002:a2e:889a:0:b0:2b5:1b80:264b with SMTP id
 k26-20020a2e889a000000b002b51b80264bmr12449284lji.12.1688571379698; 
 Wed, 05 Jul 2023 08:36:19 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a2e8905000000b002b6e9b1e4aesm1792714lji.78.2023.07.05.08.36.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 08:36:19 -0700 (PDT)
Message-ID: <5ae46380-4016-fc17-bcb5-dd96c022bebd@linaro.org>
Date: Wed, 5 Jul 2023 17:36:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 12/19] hw/timer/arm_timer: Use array of frequency in
 SP804Timer
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>
References: <20230704145012.49870-1-philmd@linaro.org>
 <20230704145012.49870-13-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704145012.49870-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/4/23 16:50, Philippe Mathieu-Daudé wrote:
> SP804Timer use arrays for timers and IRQ levels. Be consistent
> and use another one for the frequencies. This will allow to
> simplify using for() loop statement in the next commit.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/timer/arm_timer.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

