Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 552497C8CFB
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 20:18:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrMjJ-0005QD-ME; Fri, 13 Oct 2023 14:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qrMjH-0005Ps-TA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 14:17:43 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qrMjG-0000pH-5d
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 14:17:43 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c9fa869a63so6937845ad.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 11:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697221060; x=1697825860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VXuBaEeRwtFVjfdb5KvHlv7WTb+Byp+r+THMjJRzfXc=;
 b=WHUcWSD1Ukt9GHul8fT6cc7Ft0IuSK/wOXN53abWA1Z4O17MN3rlDBmIIPhOnhY9qq
 ZhyyPtG5JBwL/y1KpxrLu1PVKTNnwJOVxeQJsBSB0aP1CoKEiZJaVa+MzEW9ceBrBnFB
 Zv0ncVuwPWU4pF0k190fBy7nM74MIUr6CD00kNq5U+XdHjOkF8kXUqUZZ7Tt1pvkzbRJ
 QQskk2YrcHIHj72vOebVntGwwfGtSeYXvETjkONVhi/ndtBB5gatHgGCo9ue//HNKaf7
 1L37hEkqf9kGF1ce6OgDSNOWBjtYoGbf6Uad+oPPhTfUPpuR0JzFXtFQLDf2cTztRkyY
 wHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697221060; x=1697825860;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VXuBaEeRwtFVjfdb5KvHlv7WTb+Byp+r+THMjJRzfXc=;
 b=V8IzRLP1P6ntax4h+NWOeeZ8q/sjTYU24TpOw0qv0EF8v0Xn+9SrIUaUNRSryx8eLn
 OCx2T82zmJFi2kVy/dWxETLH8oIfKakQbJCE9CBf3gOvM/s02coStu1gwelwtF+6ijPW
 kAfuT5fYQR7eQYD+Sbrs19XaGDiw7+mkKNhDuRyvBW5mt7xubi17XioVkvSi5PMMpFJD
 th0qNlsCvmqb5YjK7AQeaM33X3STE/57iDFpd1z7+BB7RqiAYxBm/AYWmYZBpljEGdOJ
 bY4gh/STw3GojDljy/JfqqP2YJxTUTO9ZZNmYdpsk/fVL1lF8Szz4mIhsrJbK+MZkz7g
 X7WQ==
X-Gm-Message-State: AOJu0YxHcI4Y3ADxHnz4XkLpey+1Y/Gsnc50ihG1orOT3htn2Z0y9A+d
 AcPPJX0CwRC9jY9EMkPfcUritg==
X-Google-Smtp-Source: AGHT+IELo4c5ntAB8DwxfmnePY7Hu9RRPzL3QQ/JcT7UNRWrAuR8tYcW9zFYWxdxWtMXjMGR0UffTw==
X-Received: by 2002:a17:902:d4c9:b0:1c7:8345:f377 with SMTP id
 o9-20020a170902d4c900b001c78345f377mr28909117plg.29.1697221060487; 
 Fri, 13 Oct 2023 11:17:40 -0700 (PDT)
Received: from [192.168.68.107] ([177.94.42.196])
 by smtp.gmail.com with ESMTPSA id
 jf9-20020a170903268900b001c898328289sm4181803plb.158.2023.10.13.11.17.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 11:17:40 -0700 (PDT)
Message-ID: <42f5734d-02b2-4786-a193-cacdc7a8c7c9@ventanamicro.com>
Date: Fri, 13 Oct 2023 15:17:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 27/78] target/riscv: add fallthrough pseudo-keyword
Content-Language: en-US
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
 <b387a1f2114c71be3c88c5bc9d8acb7f53c3b441.1697186560.git.manos.pitsidianakis@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <b387a1f2114c71be3c88c5bc9d8acb7f53c3b441.1697186560.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 10/13/23 05:45, Emmanouil Pitsidianakis wrote:
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
> 
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/insn_trans/trans_rvi.c.inc   |  2 +-
>   target/riscv/insn_trans/trans_rvzce.c.inc | 22 +++++++++++-----------
>   target/riscv/translate.c                  |  4 ++--
>   3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
> index 25cb60558a..98dd2e3cf6 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -122,7 +122,7 @@ static TCGCond gen_compare_i128(bool bz, TCGv rl,
>   
>       case TCG_COND_LTU:
>           invert = true;
> -        /* fallthrough */
> +        fallthrough;
>       case TCG_COND_GEU:
>           {
>               TCGv tmp = tcg_temp_new();
> diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
> index 2d992e14c4..f0bcbb4f72 100644
> --- a/target/riscv/insn_trans/trans_rvzce.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzce.c.inc
> @@ -125,37 +125,37 @@ static uint32_t decode_push_pop_list(DisasContext *ctx, target_ulong rlist)
>       case 15:
>           reg_bitmap |=  1 << (X_Sn + 11) ;
>           reg_bitmap |=  1 << (X_Sn + 10) ;
> -        /* FALL THROUGH */
> +        fallthrough;
>       case 14:
>           reg_bitmap |=  1 << (X_Sn + 9) ;
> -        /* FALL THROUGH */
> +        fallthrough;
>       case 13:
>           reg_bitmap |=  1 << (X_Sn + 8) ;
> -        /* FALL THROUGH */
> +        fallthrough;
>       case 12:
>           reg_bitmap |=  1 << (X_Sn + 7) ;
> -        /* FALL THROUGH */
> +        fallthrough;
>       case 11:
>           reg_bitmap |=  1 << (X_Sn + 6) ;
> -        /* FALL THROUGH */
> +        fallthrough;
>       case 10:
>           reg_bitmap |=  1 << (X_Sn + 5) ;
> -        /* FALL THROUGH */
> +        fallthrough;
>       case 9:
>           reg_bitmap |=  1 << (X_Sn + 4) ;
> -        /* FALL THROUGH */
> +        fallthrough;
>       case 8:
>           reg_bitmap |=  1 << (X_Sn + 3) ;
> -        /* FALL THROUGH */
> +        fallthrough;
>       case 7:
>           reg_bitmap |=  1 << (X_Sn + 2) ;
> -        /* FALL THROUGH */
> +        fallthrough;
>       case 6:
>           reg_bitmap |=  1 << X_S1 ;
> -        /* FALL THROUGH */
> +        fallthrough;
>       case 5:
>           reg_bitmap |= 1 << X_S0;
> -        /* FALL THROUGH */
> +        fallthrough;
>       case 4:
>           reg_bitmap |= 1 << xRA;
>           break;
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index f0be79bb16..c99e513221 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -446,7 +446,7 @@ static TCGv_i64 get_fpr_hs(DisasContext *ctx, int reg_num)
>           return t;
>       }
>   #else
> -    /* fall through */
> +    fallthrough;
>       case MXL_RV64:
>           return cpu_gpr[reg_num];
>   #endif
> @@ -516,7 +516,7 @@ static void gen_set_fpr_hs(DisasContext *ctx, int reg_num, TCGv_i64 t)
>               tcg_gen_extrl_i64_i32(cpu_gpr[reg_num], t);
>               break;
>   #else
> -        /* fall through */
> +        fallthrough;
>           case MXL_RV64:
>               tcg_gen_mov_i64(cpu_gpr[reg_num], t);
>               break;

