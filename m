Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DC77845F0
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 17:43:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYTX1-0003yO-Af; Tue, 22 Aug 2023 11:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYTWi-0003vs-Kz
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:42:41 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYTWe-0000LR-Px
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:42:38 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68a3b66f350so2524237b3a.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 08:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692718955; x=1693323755;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X8oI/sfB3xzwMDeoK1rUGu1cCgR4nN2FyDj9AKzjc+Q=;
 b=UdbQ0PNZ0ua0Fa+dxA2HzjlEMBMPlMi/T3orjr+I8xYsUr9JGf8RgGHiY9qyMYF1Da
 XvaU6TGrXChNX60PsoBt8Qqmq1V3jzcXFMlQeIdjTxMVBol4MWjAsPZJ1WIGB6+WmKrz
 IG6sF8URXp52/GUNTgwrkwgdyk9VLjq2QRzx1QtLnT9OlFM6vJUMqe6SFmryFbTuH2KU
 eLBa2q2lUdTa/feX5a7Qa3DQxM/BICG2iyngixOoEGpCESLmjG1foURDx/y2xSy0JguY
 +BF9RZ/azBbUdnvoH2N8+ecamAV9ivYcBIRwdu65pQYoJCibDXB25N3TP/STcwkItVA2
 OVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692718955; x=1693323755;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X8oI/sfB3xzwMDeoK1rUGu1cCgR4nN2FyDj9AKzjc+Q=;
 b=f7SzGwX/mE66d5SrKD9Ivbm8teEr1HY64bZUOkB9pZt1Ox/3E1UgMQ8rJGnJrmJ9GF
 Q3fDf86kHX9QbcrZzrBb4pv27KfeIT8UxkNRgkOC016NQEwNdRhbnN7HpJIzaGuo1GRJ
 N8URZamxywY4BUMX5nJ9/5FhiG2Ox70vHzseEtUQR4+Rwn/jzuOs71baGAY32DEJD7vT
 RDFFEwyEhD/832DZK5DfHpt6rtSvLAlZgjnM6zX+cPDr1Bi+KVErNfzlzUwRk+9xfchD
 SULrBRP70R0bQYzQiYOGY0lRzcCV0FDfZdva1nljzmYaJds5s9xbdlvnHE6M3tMbm8su
 cvfA==
X-Gm-Message-State: AOJu0YyUKa6j1lnF+MN03COjZerKj41ZPi6Pit947K88ss8rEdm3qvzC
 oGD3ih3xPJvp+J+V4UVSerbqmA==
X-Google-Smtp-Source: AGHT+IEtJElixLZXXnNitkhZjkGt0kYM3zM8HCg7v7yh3KSjk8MziQlfsFyQrsR9Ws1ASerG6PtO2g==
X-Received: by 2002:a05:6a00:805:b0:68b:bd56:c78b with SMTP id
 m5-20020a056a00080500b0068bbd56c78bmr1198455pfk.10.1692718954599; 
 Tue, 22 Aug 2023 08:42:34 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 h11-20020aa786cb000000b00687790191a2sm7920222pfo.58.2023.08.22.08.42.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 08:42:34 -0700 (PDT)
Message-ID: <14386aa6-8e00-8792-ba7d-9d93c3c35baf@linaro.org>
Date: Tue, 22 Aug 2023 08:42:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/12] target/mips: Use generic hrev32_tl() in WSBH opcode
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Greg Kurz <groug@kaod.org>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, qemu-arm@nongnu.org
References: <20230822124042.54739-1-philmd@linaro.org>
 <20230822125752.55328-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230822125752.55328-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/22/23 05:57, Philippe Mathieu-Daudé wrote:
> -        {
> -            TCGv t1 = tcg_temp_new();
> -            TCGv t2 = tcg_constant_tl(0x00FF00FF);
> -
> -            tcg_gen_shri_tl(t1, t0, 8);
> -            tcg_gen_and_tl(t1, t1, t2);
> -            tcg_gen_and_tl(t0, t0, t2);
> -            tcg_gen_shli_tl(t0, t0, 8);
> -            tcg_gen_or_tl(t0, t0, t1);
> -            tcg_gen_ext32s_tl(cpu_gpr[rd], t0);
> -        }
> +        tcg_gen_hrev32_tl(t0, t0);
> +        tcg_gen_ext32s_tl(cpu_gpr[rd], t0);

Ah, you did want tcg_gen_bswap16x2_tl(dst, src, TCG_BSWAP_OS).


r~

