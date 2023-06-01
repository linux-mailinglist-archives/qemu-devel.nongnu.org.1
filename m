Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 708317190EB
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 05:05:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4YcJ-0006yD-9f; Wed, 31 May 2023 23:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4YcH-0006rO-4s
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:04:45 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Yc7-0000Uz-GC
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:04:44 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64d426e63baso511221b3a.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 20:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685588674; x=1688180674;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7szh9ZkK/SuBJMEe86phz7KAJaLuOJSwuSDGWVladXo=;
 b=i951p6AgMhxtHRF0nEamN7vKKL7UXSRFHQvmzL6mCmGdXowUOtSGRb8zneLkF6xns7
 4EDCCp0RFyzJu24BUlB278SVL7/vPBRp0vwsrm7ED+49i59Pt6QcK3G/MFRa6TY5BvhY
 Wn3sx2pzPy7yZH2JAeRWitIH+gQH0vEaKS2wUz5HTAHjzIcrpVML8D4S+7FrDQzem9G+
 XOc6h+eENlNNxvHbWQ3soVJdlUWXraOsR++Yp2MGSy4GOB4Nbacij/IgPEQ15OCi94rZ
 QptkZksRllUUM1hi506x13fGU2j4UGClrdTtyqhTx3AJqbb3ovS9fQMk1hAp4cAJZtqS
 q2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685588674; x=1688180674;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7szh9ZkK/SuBJMEe86phz7KAJaLuOJSwuSDGWVladXo=;
 b=J8I8FQSPZ1CscYRQYVHU+oafeoHAPyPhdCkARO7rawAJdl+p+Zxc2gxf5hGK9af9Vw
 UUqjmb0DnG42eVZjYfZ0hsOYo/08fnxbm64Qe6xACt8ydjoq4qAcy+ltQVmM2CJpDIGN
 KtPFsqVU4vDkukviGT0ZG6PaMkojxGFj5wypZHZz3JpfNYADh2xDg7Uyvium3IwYUp/2
 fZlGwhlB67ryuVUzVgdlTMcqChUjt5JJKqYxCZjAhq4fnVhCxspvqj9VYwmuTTFJrnK1
 jrttPANpo21fZVXoti+bFRx1wdr+SKoqnjTUWijZs4oI5bSXEs1aqSFFhqv4IHwM3abg
 6q2g==
X-Gm-Message-State: AC+VfDyOIfRAjUFwhmmQarafOQ4lJBO8L2GuV6CZark+H9Bx4pXRtdeg
 Syn2KplLs4hug2oWhqjHvk+XAg==
X-Google-Smtp-Source: ACHHUZ7eqH7BK4wNQxsRUH5Sj4+L1WEGoyAuwyjxpUAu4C0LfNaasHwDKJAy+4UpABQOietjEUKwVw==
X-Received: by 2002:a05:6a00:23c8:b0:64c:c5f9:152a with SMTP id
 g8-20020a056a0023c800b0064cc5f9152amr9529035pfc.23.1685588673973; 
 Wed, 31 May 2023 20:04:33 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 s26-20020aa78d5a000000b0063b5776b073sm3971905pfe.117.2023.05.31.20.04.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 20:04:33 -0700 (PDT)
Message-ID: <69c37e57-dcca-3d35-a538-7fdf674ff000@linaro.org>
Date: Wed, 31 May 2023 20:04:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/7] hw/usb/xlnx: Do not open-code sysbus_pass_irq()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20230531223341.34827-1-philmd@linaro.org>
 <20230531223341.34827-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230531223341.34827-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/31/23 15:33, Philippe Mathieu-Daudé wrote:
> The SYSBUS_DEVICE_GPIO_IRQ definition should be internal to
> the SysBus API. Here we simply open-coded sysbus_pass_irq().
> Replace to use the proper API.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/usb/xlnx-usb-subsystem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

