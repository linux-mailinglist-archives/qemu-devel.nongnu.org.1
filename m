Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A16F82C761
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:42:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOQDB-00073R-LJ; Fri, 12 Jan 2024 17:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOQD9-00071W-1a
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:41:11 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOQD6-000229-HU
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:41:10 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-28c7c9b19f1so4425733a91.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 14:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705099267; x=1705704067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hYjXtUHSyVy74WWwvvSngKil6srMZaeX/nr1xR2tuek=;
 b=dYMubrCb3cYPwOndX0F/ICBFQD2Sn+WLa9nxb7PpExJEeLNno/vTuHvFBopnKIzlf1
 cpiYZIiMFCk65WdrKM9v+DKlSCZt8AuUDlNFlQ9w0BMe44t5WpTD1gzp7Q7tsBBEmzhb
 v6hhDjaMMTC4nycc2ms+hKyl+E/EGkfozlWytbk81TVeP5asLJdDgQFgoi0dY9Tr0KZh
 j6bSWfY+U4EeDFZqw6754anZN6CSBKZEn2e2iIIGfQcW8QKCaeMxa2cUEuFZfCe7X6z5
 LuevYy6LjKZp2t6kN62/McRkegpopaRg4xe55WIYYBmWwO2cfLj6IbiYvqWe9SaJ0cl3
 EjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705099267; x=1705704067;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hYjXtUHSyVy74WWwvvSngKil6srMZaeX/nr1xR2tuek=;
 b=M4B1uhHFZOSzV9pzZRASBs+vWIlok0nSJUR4tNi4eTmwbwyqpD1H/w//n2/hfdplVg
 q5fY7fLtPY0C6q9Jp4VhnRgq/+v/NbWFlkyDUAvuEYtQlJVRkTg6zXkDc+uQaOYq47pN
 m6jd+IsIYzP9YR70IFAaKLRxrtQW/1WOjBN7a5UajGvGppFdY2zkPcXq16Lp0Ms+TUZB
 1E3Lisiwi9jbRq5hUDfnE6dV5NzoMDshy38V72gRafLZhrqQwGFVsAFn+oBpyjjZ3CJL
 hInEH8dN9IMWL1tUj48sGDU+GFtrH/J9LN9pQkYg7/tAeDxrkha6s8L9MVVM/UkG4Frt
 CxUg==
X-Gm-Message-State: AOJu0YwKiEZfYBF15rVB73IypuullCCE9oFMlii+tJM4gGdaz3brM/dY
 XOY6UGj5eXtcPlGHq0irhaCUZxw/opiNcw==
X-Google-Smtp-Source: AGHT+IEHyELds/gVZN6n+xwvV2muWAUtllN+Y8hM+g4tewlb0DtE8GYF+PlQt9EphNm9Z1/LCGGLcw==
X-Received: by 2002:a17:90a:c004:b0:28c:e9ed:f724 with SMTP id
 p4-20020a17090ac00400b0028ce9edf724mr1776955pjt.98.1705099266979; 
 Fri, 12 Jan 2024 14:41:06 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:2ad6:e985:c1c8:a4fc:508?
 ([2001:8004:2728:2ad6:e985:c1c8:a4fc:508])
 by smtp.gmail.com with ESMTPSA id
 jj7-20020a170903048700b001d472670a30sm3695512plb.162.2024.01.12.14.41.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 14:41:06 -0800 (PST)
Message-ID: <4b0847ec-467f-4fcb-8deb-01ec435d82ad@linaro.org>
Date: Sat, 13 Jan 2024 09:40:59 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] target/riscv/vector_helper.c: use vlenb in
 HELPER(vsetvl)
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240112213812.173521-1-dbarboza@ventanamicro.com>
 <20240112213812.173521-9-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240112213812.173521-9-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/13/24 08:38, Daniel Henrique Barboza wrote:
> Use the new 'vlenb' CPU config to validate fractional LMUL. The original
> comparison is done with 'vlen' and 'sew', both in bits. Use sew/8, or
> sew in bytes, to do a direct comparison with vlenb.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/vector_helper.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index cb944229b0..0c1a485d1e 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -45,9 +45,12 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>                                               xlen - 1 - R_VTYPE_RESERVED_SHIFT);
>   
>       if (lmul & 4) {
> -        /* Fractional LMUL - check LMUL * VLEN >= SEW */
> -        if (lmul == 4 ||
> -            cpu->cfg.vlen >> (8 - lmul) < sew) {
> +        /*
> +         * Fractional LMUL - check LMUL * VLEN >= SEW, or
> +         * vlen >> (8 - lmul) < sew. We have 'vlenb', so
> +         * compare it with sew in bytes.
> +         */
> +        if (lmul == 4 || cpu->cfg.vlenb >> (8 - lmul) < (sew << 3)) {

You're shifting sew the wrong direction.  But better to simply adjust the vlenb shift:

- cpu->cfg.vlen >> (8 - lmul) < sew
+ cpu->cfg.vlenb >> (8 - 3 - lmul) < sew


r~

