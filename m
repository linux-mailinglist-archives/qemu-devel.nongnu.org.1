Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D51DB82FC93
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 23:23:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPrpq-0003WF-0M; Tue, 16 Jan 2024 17:23:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrpo-0003Vt-Fu
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 17:23:04 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrpm-0005lT-VH
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 17:23:04 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33761e291c1so5909039f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 14:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705443781; x=1706048581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LWxwMMOe0ZoPwTZLrBGoYKhjt1Lr6H4tHbI0AIa6NoA=;
 b=k2WUU0SL40+df5M+/cONwdX5CeZHehy20u7q/L3f1ut42bJi7R7WLe0MN7FQGjrxFq
 TecYltHHRBjfTrIlrbZ7M5hM4oedSQp1rvWAgDb6CfaZXYGw4c81to2gx+TBDMVlOMYI
 Ud0/fXI5fPdCnQ4md/IrCNKxBC13xsb2UOJaZYvlTx17oWm8cXgohfWwMa9BWBRblB/0
 jzFs10s6kdJC2YNOUFDYEyG4NyKqWaleDLL46Q1axzmLkt7vg3ih/AKNNIOOtvDu5i7R
 ohjVQFyeIU4jX+iwlYdJ/guFikWe20M+tMtQDeaEWbttRU+tkfndKmYHK0TPY9Y7XxI0
 1nLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705443781; x=1706048581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LWxwMMOe0ZoPwTZLrBGoYKhjt1Lr6H4tHbI0AIa6NoA=;
 b=rPKU8vDIU8AtmJkW/EtGZr0BtM3UvoCC8ly8p7LFXwhcbcrXARnOuUOuaiyG7HTWPd
 qabUQv7DfmbzTrRyxm3x0gwR6toJejzaGrU2xMIK2Q2qhz0aTZcRCvIdTFWeduUG1xk3
 92Zg8HsW20naZ2gKNm28vFbOjXfAHsoYLConPM8Yt0/YfUudZSv1EOBzmfB0bIiVKXm8
 gJGffcWsImPwR40OcM0jzrWvO6NbzUkwI3gXF55n+NU7BQQsQ9x7t1oYQY7fDptDiaPX
 NGsfNkIVE3RK2BS6BvIqePF6dtJRBWHQOwBO3Op3VFcqsN62yOT6f1opzWIZxa14K5Bp
 v8Gg==
X-Gm-Message-State: AOJu0YxXl/oq/1dopczSPWuhRQcxuQy+fcwd3zgmixFnBr/3C2gETt+f
 pcqbTy+DOJajndfuAteHLJ8wrB2Nn97qkw==
X-Google-Smtp-Source: AGHT+IET9RAoD63qkVNApYltZdJoQNq+re9u1V+t9FymivcTV+M0EAIE/4M8RqMAlCLsF8SMix6ZJw==
X-Received: by 2002:a7b:cc8f:0:b0:40e:796e:6674 with SMTP id
 p15-20020a7bcc8f000000b0040e796e6674mr1900551wma.32.1705443781251; 
 Tue, 16 Jan 2024 14:23:01 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a05600c0a0a00b0040e4bcfd826sm20908883wmp.47.2024.01.16.14.23.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 14:23:00 -0800 (PST)
Message-ID: <e3b0b230-c7e4-4420-b558-06b66f8b7324@linaro.org>
Date: Tue, 16 Jan 2024 23:22:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/38] tcg/arm: Factor tcg_out_cmp() out
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240110224408.10444-1-richard.henderson@linaro.org>
 <20240110224408.10444-21-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240110224408.10444-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 10/1/24 23:43, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20231028194522.245170-12-richard.henderson@linaro.org>
> [PMD: Split from bigger patch, part 1/2]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-Id: <20231108145244.72421-1-philmd@linaro.org>
> ---
>   tcg/arm/tcg-target.c.inc | 32 +++++++++++++++++---------------
>   1 file changed, 17 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


