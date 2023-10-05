Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 729B87BA725
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:55:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoRbe-0006dx-Sk; Thu, 05 Oct 2023 12:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoRbc-0006aD-Ll
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:53:44 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoRba-0007KR-CR
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:53:44 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32003aae100so1490398f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 09:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696524819; x=1697129619; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+2z8zW7FLjlBhbIuaN6w4dqycw3liIiF35v1DejqvJE=;
 b=QWHYLmyQCWRPYd1SpscoY+kUIevO1bCqkwMTYUdwlgVS6XTtzIkQ678W79STB6QmmB
 QrQHo9mkWGDNfAeg9C3L+Jh3NuQ0hp8ViXlaVHslpKWNo3haUdp1IPcR65RYTTIxANu/
 /RlsUyBNMEpQXce69G4EmEeuz8468CjsoMhxhr1fvjCeRu0zTkjSML5vFJBeIGbyexnS
 2ZXHi5Nzg87rj0XPVHGB6ZgOi1BRG3ZnwPSlO3Ollg00Kxng5aMCQia0oG1DHUSd6Fsj
 p1hvtH8kSxkOB91YbsfuG0Goc3ZuOcizm1BTeFOWdyhQpTuBDTqmoOBh1GZI8dnFY+dA
 YS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696524819; x=1697129619;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+2z8zW7FLjlBhbIuaN6w4dqycw3liIiF35v1DejqvJE=;
 b=xT/icVTDDuTMZQpwfNY70JneBZVpqi9OgUw/LRXMOtC06HQJZosTFnWDTts/jax8Z6
 FYBK+u/TTPxZITu0PGrrpRCW0Mog72EEo2Jpbsy7RXIVqcGzYR0iClT7OR48ebfPJ9Kv
 vf3IshmCDf2rwA4PX9xAFbYxLnDE0YO28JUfMg9lNPeQt/Urm7ucuGm7aBUxEN6zSC9D
 KwPcx0pyJ7uHxyfNhn0K73g3ajoYLqjFgZA+JPPf8olsvv9uX09rvTx3aWD1VnBTwJek
 z060S9PgYh9J3W6mOCgBCkuAgDiMv0ZHInPDP7TVmnu9MafZzsWmzHUv4X8vB4dCmSwr
 Uqfg==
X-Gm-Message-State: AOJu0Yzh2njQ2XKs0A51ezs+/qcoK3buzpQwn3/v5lNQYDhOXwkTo7v8
 U8YsGwN3ZZZ3/h9Ii8UDrZ2+vg==
X-Google-Smtp-Source: AGHT+IFNxvRv7e15WeUi6ybmacH7fQT/XyHd8WjP+CBIzHn9gRLFDotFOS/5UXUpUhsgaV7p70oM4A==
X-Received: by 2002:adf:cd09:0:b0:323:1e69:7b4 with SMTP id
 w9-20020adfcd09000000b003231e6907b4mr1837844wrm.31.1696524819390; 
 Thu, 05 Oct 2023 09:53:39 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a7bc84b000000b0040648217f4fsm4162160wml.39.2023.10.05.09.53.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 09:53:38 -0700 (PDT)
Message-ID: <ef866c49-63aa-c062-481f-e77a26e4caa7@linaro.org>
Date: Thu, 5 Oct 2023 18:53:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 03/10] tcg/arm: Use tcg_use_softmmu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231003174356.1602279-1-richard.henderson@linaro.org>
 <20231003174356.1602279-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003174356.1602279-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
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

On 3/10/23 19:43, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/arm/tcg-target.c.inc | 203 +++++++++++++++++++--------------------
>   1 file changed, 97 insertions(+), 106 deletions(-)


> @@ -356,14 +354,8 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>    * r0-r3 will be overwritten when reading the tlb entry (softmmu only);
>    * r14 will be overwritten by the BLNE branching to the slow path.
>    */
> -#ifdef CONFIG_SOFTMMU
>   #define ALL_QLDST_REGS \
> -    (ALL_GENERAL_REGS & ~((1 << TCG_REG_R0) | (1 << TCG_REG_R1) | \
> -                          (1 << TCG_REG_R2) | (1 << TCG_REG_R3) | \
> -                          (1 << TCG_REG_R14)))
> -#else
> -#define ALL_QLDST_REGS   (ALL_GENERAL_REGS & ~(1 << TCG_REG_R14))
> -#endif
> +    (ALL_GENERAL_REGS & ~((tcg_use_softmmu ? 0xf : 0) | (1 << TCG_REG_R14)))

Maybe add a comment?

(ALL_GENERAL_REGS & ~((tcg_use_softmmu ? 0xf /* R0 to R3 */ : 0) | (1 << 
TCG_REG_R14)))

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


