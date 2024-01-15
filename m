Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD8D82E2CB
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 23:58:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPVth-00021K-0n; Mon, 15 Jan 2024 17:57:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPVte-0001zo-88
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:57:34 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPVtb-0004JL-4P
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:57:33 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d5c1c1cf58so12358595ad.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 14:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705359449; x=1705964249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qhXlCA99dGO3AmZ9xzW/2tnh08y0N1VgP+8WQWm1A7c=;
 b=TKc8+kfWUkdororOEFUXTPJWxjaLhjkb2rDDHmPFI0d1c53GU513WTiPnjSCW+ISWL
 c9Kb+YjPIo/Nw5QzxLS67deA4jT1RnVWoYViEPtTfCGq88aGQSPEIkyCAH3Ef56LQNhy
 d1YNpCIa5cBiVBTavw9erbo2aRsMEKVqxgKlUKlA4hYPMFy6J+JKQJaQgiKSYnecyiVx
 0pUc4FPdwgFe3nq/rsZy/GLgBOMuKXk2mmTE7HyjwKHly2kvy01+QKwg7znHpfNpFpuK
 oWxp0QLIwI0qDmvigTnNAm9Fmu1Vj2lpV1hLFfhTCgFerUVvLI6Ki15khcQgzsWhBiBZ
 2JlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705359449; x=1705964249;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qhXlCA99dGO3AmZ9xzW/2tnh08y0N1VgP+8WQWm1A7c=;
 b=NGMxOY0u5LbS2iTjMtDKanUCe9goP562Ix0zThIgqpM/uhCrnTUaFnfNUK+Z8TiU+2
 a0lTqSFGBRY3ZDrJ+rcI5TSX3u5Dyz8d6g1UPN7VGy05N4E/Mtw0F12LC7joZkNZt9wj
 ZtmUb/qb1m6on00mRAmQGknWrgB5fij5qNBAvcZw/w92R7Yi3ynpKLNpPJ+znRq5ItCt
 qBLV3EP/rgTsM8dzrtL2PPOZVqIWu9BGdVIMM16RWKCHYsMRrS0v1ry9bhqua3r0jIyf
 akgswDOIT3c63IKwtqmYu/7EBFJXGyx3lM7o1OZg+mdE03Gs0vL+Di/S02PPoM6gtXbf
 njeA==
X-Gm-Message-State: AOJu0YwFCJx/wOUb5dMcW2P26wOQCG5LljIwuaOUli6J/4ts8HBiVCsc
 xcHsKg0RQLAUlHD6VkmpoeLm9G7UbUZSKg==
X-Google-Smtp-Source: AGHT+IEJZN4QXazWqCbVsqVWWBxzQ9UIy5D9G7l9fzDuEq7u6708EAdZqrve/NKdOt7zP6Co+MyKww==
X-Received: by 2002:a17:902:c412:b0:1d5:8bf4:a530 with SMTP id
 k18-20020a170902c41200b001d58bf4a530mr9541344plk.53.1705359449434; 
 Mon, 15 Jan 2024 14:57:29 -0800 (PST)
Received: from ?IPV6:2001:8004:2738:1dd9:85fe:4dd3:358e:ec4?
 ([2001:8004:2738:1dd9:85fe:4dd3:358e:ec4])
 by smtp.gmail.com with ESMTPSA id
 i11-20020a170902c94b00b001d3cb4e3302sm8055360pla.214.2024.01.15.14.57.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 14:57:28 -0800 (PST)
Message-ID: <3920915d-3ee8-4dbb-9d39-820b7abf273d@linaro.org>
Date: Tue, 16 Jan 2024 09:57:21 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] target/riscv/vector_helper.c: use vlenb in
 HELPER(vsetvl)
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240115222528.257342-1-dbarboza@ventanamicro.com>
 <20240115222528.257342-9-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240115222528.257342-9-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 1/16/24 09:25, Daniel Henrique Barboza wrote:
> Use the new 'vlenb' CPU config to validate fractional LMUL. The original
> comparison is done with 'vlen' and 'sew', both in bits. Adjust the shift
> to use vlenb.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/vector_helper.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index cb944229b0..9e3ae4b5d3 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -45,9 +45,13 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>                                               xlen - 1 - R_VTYPE_RESERVED_SHIFT);
>   
>       if (lmul & 4) {
> -        /* Fractional LMUL - check LMUL * VLEN >= SEW */
> +        /*
> +         * Fractional LMUL: check VLEN * LMUL >= SEW,
> +         * or VLEN * (8 - lmul) >= SEW. Using VLENB we
> +         * need 3 less shifts rights.

The last sentence is structured oddly.  Perhaps

   Using VLENB, we decrease the right shift by 3

or perhaps just show the expansion:

/*
  * Fractional LMUL, check
  *
  *    VLEN * LMUL >= SEW
  *    VLEN >> (8 - lmul) >= sew
  *    (vlenb << 3) >> (8 - lmul) >= sew
  *    vlenb >> (8 - 3 - lmul) >= sew
  */

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


> +         */
>           if (lmul == 4 ||
> -            cpu->cfg.vlen >> (8 - lmul) < sew) {
> +            cpu->cfg.vlenb >> (8 - 3 - lmul) < sew) {
>               vill = true;
>           }
>       }


