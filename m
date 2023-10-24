Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 037637D447C
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 03:05:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv5q6-0003mb-8E; Mon, 23 Oct 2023 21:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv5q3-0003lx-VR
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 21:04:07 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv5q1-0002IX-AS
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 21:04:07 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c9e06f058bso36386655ad.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 18:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698109444; x=1698714244; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VFJDMTgjexdEB14EvZqxzka0P1BGzllvXiT7XL4aph4=;
 b=D28bV8cIqM7QRMUXWKo+kstM1T5gOmzbrvLIKuun0UXeTshw75OJreSR+1B3U0x0JV
 dxgT5AdH9q+QjnUsI9wzy3o/wsi7S1qH34DoloxOZqMXwL+bj7RDKvxRF1T2hDrQat4K
 X7mZI6prb3kab88NzMNunPQbx5xtzRpoRKk6TR4+JXD0PKVp8+6vNg6v8ITAZ6Rqcms3
 WyWnHOMD6xjgGqzdWJ+1Zj8pfzjBG8DZe2tTp8qaCZmgv90DUKzofSoaKDlb8ghXaQQv
 eyGZIWF05m3MUjjDtq+AL9YfxA/MbbHEOGzzlphdPfX6a7cnxu4LS992QNNYzyV3wh7x
 5+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698109444; x=1698714244;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VFJDMTgjexdEB14EvZqxzka0P1BGzllvXiT7XL4aph4=;
 b=XryivO0Wp+iH89mUGR6KqsthwrCwq/iFQOlCJnngQiXdoAZezmYgENWx6GMyt/QSog
 bI8DKSn+h+XIsF/IG2i2tQPf8aA+68q93iZMteimTtOAcqu2Osdq/OpfH3nhkykgkokX
 GmUJ0Pm+kZjcq6oYlEsIgFlv4pmnCH59gyskxt0rzkOo5Jw/7L5aGJavhdWhRJY5vdjX
 FF3FlDfxnGqkRoAkPuC7NRt7hkbIXEqY+1jo7WTXr2lVGS9esbwR1d1URtJ5hJwbg1bL
 IniYct5bSO1st8mBuWNDVXnSWBCwt/5cj6R/31DplGgLSZ14MTgjCk/LFpuOorBIuQlX
 PGPg==
X-Gm-Message-State: AOJu0Ywe87Tt+hO/VeJDJyzTs13LDjxh+evJLhawIxT9yuugL5jOSOW+
 IjZ3qMmhzRunMMRqDGiMEoCZBA==
X-Google-Smtp-Source: AGHT+IEkPehKvbhuEFia3m6nDe7hQi63slsBgSCdozrUuJhMbKV+aAaX3XyxjZX1pFUQwrWYCgEBDw==
X-Received: by 2002:a17:903:1c9:b0:1c9:dece:4c4c with SMTP id
 e9-20020a17090301c900b001c9dece4c4cmr14559435plh.15.1698109443793; 
 Mon, 23 Oct 2023 18:04:03 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm6589214plb.6.2023.10.23.18.04.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 18:04:03 -0700 (PDT)
Message-ID: <b9d9c1a0-5b20-4d33-aaf2-f12097122004@linaro.org>
Date: Mon, 23 Oct 2023 18:04:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 9/9] target/ppc: Use tcg_gen_sextract_tl
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20231023160944.10692-1-philmd@linaro.org>
 <20231023160944.10692-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231023160944.10692-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/23/23 09:09, Philippe Mathieu-Daudé wrote:
> Inspired-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> RFC: Please double-check 32/64 & bits
> ---
>   target/ppc/translate.c | 22 ++++------------------
>   1 file changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index c6e1f7c2ca..1370db9bd5 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2892,13 +2892,7 @@ static void gen_slw(DisasContext *ctx)
>   
>       t0 = tcg_temp_new();
>       /* AND rS with a mask that is 0 when rB >= 0x20 */
> -#if defined(TARGET_PPC64)
> -    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x3a);
> -    tcg_gen_sari_tl(t0, t0, 0x3f);
> -#else
> -    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x1a);
> -    tcg_gen_sari_tl(t0, t0, 0x1f);
> -#endif
> +    tcg_gen_sextract_tl(t0, cpu_gpr[rB(ctx->opcode)], 5, 1);
>       tcg_gen_andc_tl(t0, cpu_gpr[rS(ctx->opcode)], t0);

Patch looks correct as is, so
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


However:
I'd be tempted to use and+movcond instead of sext+andc.
Also there is a special case of 32-bit shifts with 64-bit shift count on ppc64.

#ifdef TARGET_PPC64
     tcg_gen_andi_tl(t0, rb, 0x3f);
#else
     tcg_gen_andi_tl(t0, rb, 0x1f);
     tcg_gen_andi_tl(t1, rb, 0x20);
     tcg_gen_movcond_tl(TCG_COND_NE, t1, t1, zero, zero, rs);
     rs = t1;
#endif
     tcg_gen_shl_tl(ra, rs, t0);
     tcg_gen_ext32u_tl(ra, ra);


It also makes me wonder about adding some TCGCond for bit-test so that this could be

     tcg_gen_movcond_tl(TCG_COND_TSTNE, t1, rb, 0x20, 0, 0, rs);

and make use of the "test" vs "cmp" instructions on most hosts, but especially x86.


r~

