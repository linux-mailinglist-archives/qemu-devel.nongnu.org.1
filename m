Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E017F18AD
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 17:34:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r57CV-0007SI-Rn; Mon, 20 Nov 2023 11:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r57CU-0007S4-5B
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 11:32:42 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r57CS-0006HM-Lm
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 11:32:41 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c50fbc218bso57839271fa.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 08:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700497958; x=1701102758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=07SMG8jzc6o3QvutEmPIAP+JtYeK2mfQ8RGHEun0QSw=;
 b=HLS3RWRvwvvHEKn/9admPSxu1ogpuYZBcRnhC1nzWh5IQqpzYoprH1mOB61CRchnkd
 TilCoQ/4z9fXz3b6ourrtmJZLqs7k7BP1J/wQQJypHDRC6Pyd/CQWbKIqXA7CSIQsMZ0
 BYU9P+0ivmEwFDm5jKefJo2MVOWYlucq2JiOrN7ODuqzAK2L896FZ8NYVtREFdmQLA/W
 sQBfr/s9u6vVUdh3ltatUhwappQFq3Oh9kYV65uktsV261N1nHPBYnXBMQ4WUnysRf8o
 2MtrelkNKeIfZEu4XMQcBiwftaHjwG/A+xKw1F4qBGrZBqaFzqCGYWS36jHTpsyZw+1H
 MiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700497958; x=1701102758;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=07SMG8jzc6o3QvutEmPIAP+JtYeK2mfQ8RGHEun0QSw=;
 b=Zej3Od1GyaAjAeRmulPKuNefIyi/pbgK1w/g6AB2FnBe2NqR9irVEGDDImImZVV3bj
 EiXMJ3ye4yCu7eTw9wupFWXjpyBkziTU3UmzzzfoHAVRC2sOvm+EYZRZzts6i2zuEp+5
 UzXshIKch1egHaYyUUe7OPOS25bCF7YiTamsiYH30wZH80TG5twfo1hRFAJMucXycKhH
 A9GJ58V9WWyAZe00vY0kvI/89WBAGZA5SaH0YU2A1f43/Thu4Co+szS1NQZEeRxFad9W
 OUGEMKoiFo8W1kfYL0ci8ItweXw40DwxIVzi5Hn45EKz9iLgaMPJY8yM90fMxWRaTEWS
 OtNw==
X-Gm-Message-State: AOJu0Yw0mY6muyE+UfiitmfqhYyildX4RbHB9QRRVK2yoZhKRsyH659/
 B8nTikS9/4RKXH6htpwik99iww==
X-Google-Smtp-Source: AGHT+IG0C+zCJ0fALCT8CsjrIabtoJ/dONANEAhyf/YtWCTm1/ztbbAfRRN1T+/8ZWzFhEjolgHDIQ==
X-Received: by 2002:a2e:5007:0:b0:2c8:7962:cdc2 with SMTP id
 e7-20020a2e5007000000b002c87962cdc2mr4222143ljb.3.1700497958542; 
 Mon, 20 Nov 2023 08:32:38 -0800 (PST)
Received: from [192.168.174.227] ([91.223.100.4])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a05651c105300b002c834afc316sm1040786ljm.30.2023.11.20.08.32.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 08:32:38 -0800 (PST)
Message-ID: <87ac4dc5-af42-4afa-9d90-0fb46b9bbf28@linaro.org>
Date: Mon, 20 Nov 2023 08:32:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] tests/tcg: enable arm softmmu tests
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231120150833.2552739-1-alex.bennee@linaro.org>
 <20231120150833.2552739-12-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231120150833.2552739-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/20/23 07:08, Alex Bennée wrote:
> +/*
> + * Helper macro for the linker calling subroutines from the C code.
> + */

That's not all it's for.  Better "annotating functions with elf type and size".

> +vector_table:
> +	b   reset		/* reset vector */
> +	b   undef_instr        /* undefined instruction vector */
> +	b   software_intr    	/* software interrupt vector */
> +	b   prefetch_abort		/* prefetch abort vector */
> +	b   data_abort	        /* data abort vector */
> +	nop			            /* reserved */
> +	b   IRQ_handler        	/* IRQ vector */
> +	b   FIQ_handler        	/* FIQ vector */

Missing endf, for the purpose of qemu load_symbols().

> +mmu_setup:
> +reset:
> +undef_instr:
> +software_intr:
> +prefetch_abort:
> +data_abort:
> +IRQ_handler:
> +FIQ_handler:

Also missing.

With those fixed,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

