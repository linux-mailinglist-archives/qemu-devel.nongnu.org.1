Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B4572F87F
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 10:59:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9MLR-0000EG-Hq; Wed, 14 Jun 2023 04:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q9MLL-0000Ck-DE
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 04:59:07 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q9MLJ-0004xd-69
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 04:59:06 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-555508fd7f9so298553eaf.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 01:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686733143; x=1689325143;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mp6qKwnHe+KsjV34LVJ9sRj3p8qxH2ZQ4O0PgFUZ0Sc=;
 b=oR3fEwFIc3Py5ZGFxzJycZ5V+6fGp9X5W1AlbXgZpy7fETYhX3f8xMNMaDr/T8mzps
 74wDkTKgec51/vUGwE6FgfhBPhwUe5XPXwZBKX4fufox2elXFcQkIR4TCvCOeNqOfLRa
 Cqw2gHnsCi94g8iC67Nimr55aditd0iGxHAU+gp6wIJdHmba1Vf3AxB5YIjnWQ2EmIRg
 la5CHI61MKXYPdyFIcznwP//ECTJQw9y2Re0/7d7l2CqJDNZ5AbE/DgqAxoAP37HsslV
 /Ly9zJzCyRqkFJuotR/LgrvMcv/6/puyw40aEcNhHRfWUOuFWWFPG+SPT04Rp8lhEAWK
 N8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686733143; x=1689325143;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mp6qKwnHe+KsjV34LVJ9sRj3p8qxH2ZQ4O0PgFUZ0Sc=;
 b=Tcat0W/yE/M8w48MzixZ9zARqgHQkTA5rSOeCXoFn45OOEo4Fs1nVWRejpnMh17qs8
 UHz6Lr+fRPulDlcRuZaBlolIeS9S5/PQEMb3yBbNnZgbWo0QPP4Iuz1qkvEkIxjUHXv1
 7YUoH+NG5oh21cGmtHdV5fRZhhu/hRV4DsDHZBcfBbKpOgDhIONe/DX7hTJ2kPbvXiU2
 B9zyJpz08Zy0RRQC3nszR9TJHsHAX0Qpy4U6oeyG0PO4JWKU0ErVMZ6ZU6VUVSXCmRBs
 o+I7Z5wK/HbQSuRnMXO+LbmgvOd4JQtBfUGsMb7kiEBu57PgqVBtR0dJJmjKDBYiyn5x
 VQKg==
X-Gm-Message-State: AC+VfDyENNrZ5anoDMtZEznXMdAejuDcSt11uwzN8MGy8WXu+aaj3p+1
 I34zDOusbiDlfrBg+adxfzY05g==
X-Google-Smtp-Source: ACHHUZ41vggVzS1xlR0cL6acMaYu/0T1OvHbnCGSlRWuq01aZViXoavu0LXvHqoH1BuZWfnTlCOgPA==
X-Received: by 2002:a4a:c90b:0:b0:552:4bca:a9df with SMTP id
 v11-20020a4ac90b000000b005524bcaa9dfmr7765501ooq.3.1686733143200; 
 Wed, 14 Jun 2023 01:59:03 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.210])
 by smtp.gmail.com with ESMTPSA id
 bf14-20020a056820174e00b0051134f333d3sm4831348oob.16.2023.06.14.01.58.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 01:59:02 -0700 (PDT)
Message-ID: <f22d710e-d1bb-d33a-78c1-c86a6740dbe1@ventanamicro.com>
Date: Wed, 14 Jun 2023 05:58:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/8] target/riscv: Factor out extension tests to
 cpu_cfg.h
Content-Language: en-US
To: Christoph Muellner <christoph.muellner@vrull.eu>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhiwei Liu <zhiwei_liu@linux.alibaba.com>
Cc: Weiwei Li <liweiwei@iscas.ac.cn>
References: <20230612111034.3955227-1-christoph.muellner@vrull.eu>
 <20230612111034.3955227-3-christoph.muellner@vrull.eu>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230612111034.3955227-3-christoph.muellner@vrull.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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



On 6/12/23 08:10, Christoph Muellner wrote:
> From: Christoph Müllner <christoph.muellner@vrull.eu>
> 
> This patch moves the extension test functions that are used
> to gate vendor extension decoders, into cpu_cfg.h.
> This allows to reuse them in the disassembler.
> 
> This patch does not introduce new functionality.
> However, the patch includes a small change:
> The parameter for the extension test functions has been changed
> from 'DisasContext*' to 'const RISCVCPUConfig*' to keep
> the code in cpu_cfg.h self-contained.
> 
> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu_cfg.h   | 26 ++++++++++++++++++++++++++
>   target/riscv/translate.c | 27 ++-------------------------
>   2 files changed, 28 insertions(+), 25 deletions(-)
> 
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index c4a627d335..0b4fe4b540 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -133,4 +133,30 @@ struct RISCVCPUConfig {
>   };
>   
>   typedef struct RISCVCPUConfig RISCVCPUConfig;
> +
> +/* Helper functions to test for extensions.  */
> +
> +static inline bool always_true_p(const RISCVCPUConfig *cfg __attribute__((__unused__)))
> +{
> +    return true;
> +}
> +
> +static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
> +{
> +    return cfg->ext_xtheadba || cfg->ext_xtheadbb ||
> +           cfg->ext_xtheadbs || cfg->ext_xtheadcmo ||
> +           cfg->ext_xtheadcondmov ||
> +           cfg->ext_xtheadfmemidx || cfg->ext_xtheadfmv ||
> +           cfg->ext_xtheadmac || cfg->ext_xtheadmemidx ||
> +           cfg->ext_xtheadmempair || cfg->ext_xtheadsync;
> +}
> +
> +#define MATERIALISE_EXT_PREDICATE(ext) \
> +    static inline bool has_ ## ext ## _p(const RISCVCPUConfig *cfg) \
> +    { \
> +        return cfg->ext_ ## ext ; \
> +    }
> +
> +MATERIALISE_EXT_PREDICATE(XVentanaCondOps)
> +
>   #endif
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 859d5b2dcf..275b922811 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -119,29 +119,6 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
>       return ctx->misa_ext & ext;
>   }
>   
> -static bool always_true_p(DisasContext *ctx  __attribute__((__unused__)))
> -{
> -    return true;
> -}
> -
> -static bool has_xthead_p(DisasContext *ctx  __attribute__((__unused__)))
> -{
> -    return ctx->cfg_ptr->ext_xtheadba || ctx->cfg_ptr->ext_xtheadbb ||
> -           ctx->cfg_ptr->ext_xtheadbs || ctx->cfg_ptr->ext_xtheadcmo ||
> -           ctx->cfg_ptr->ext_xtheadcondmov ||
> -           ctx->cfg_ptr->ext_xtheadfmemidx || ctx->cfg_ptr->ext_xtheadfmv ||
> -           ctx->cfg_ptr->ext_xtheadmac || ctx->cfg_ptr->ext_xtheadmemidx ||
> -           ctx->cfg_ptr->ext_xtheadmempair || ctx->cfg_ptr->ext_xtheadsync;
> -}
> -
> -#define MATERIALISE_EXT_PREDICATE(ext)  \
> -    static bool has_ ## ext ## _p(DisasContext *ctx)    \
> -    { \
> -        return ctx->cfg_ptr->ext_ ## ext ; \
> -    }
> -
> -MATERIALISE_EXT_PREDICATE(XVentanaCondOps);
> -
>   #ifdef TARGET_RISCV32
>   #define get_xl(ctx)    MXL_RV32
>   #elif defined(CONFIG_USER_ONLY)
> @@ -1132,7 +1109,7 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
>        * that are tested in-order until a decoder matches onto the opcode.
>        */
>       static const struct {
> -        bool (*guard_func)(DisasContext *);
> +        bool (*guard_func)(const RISCVCPUConfig *);
>           bool (*decode_func)(DisasContext *, uint32_t);
>       } decoders[] = {
>           { always_true_p,  decode_insn32 },
> @@ -1161,7 +1138,7 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
>           ctx->opcode = opcode32;
>   
>           for (size_t i = 0; i < ARRAY_SIZE(decoders); ++i) {
> -            if (decoders[i].guard_func(ctx) &&
> +            if (decoders[i].guard_func(ctx->cfg_ptr) &&
>                   decoders[i].decode_func(ctx, opcode32)) {
>                   return;
>               }

