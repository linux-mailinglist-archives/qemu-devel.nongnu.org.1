Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C967D9D78
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:52:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwP89-0001nn-9k; Fri, 27 Oct 2023 11:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1qwP83-0001nL-Ao
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:52:07 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1qwP80-0002EZ-8q
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:52:06 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso2201705b3a.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 08:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1698421921; x=1699026721;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to; bh=XOeL7vNB8wmCwmKms4FiVCOpJWT5NGw9nhxZFn+ddns=;
 b=i31tuehIfP1I7CoYlyuLq7WcyC65gf3Ub/60095IDMnI6b+5AiD9nj2LmvK4xbZyiQ
 rQ3M2w2NTuFx+VcdR3jSXXwxc9wz92w5g6vIDd5oJpoBb9gR7aNIz0ZxyjnRPyIvps6a
 N1q85V4/RTN0GAcYgkZhPF0I/2TYgAFTKFOoH5So2G9Pphki2lBq1HyeUfF6kSeUP5Mj
 TuUFx7vcwM4yIC5K3VgBqJTMLgyq/lCp447HuqAJBsAl3oDKFmbsdfRBLkaXJHMycIBF
 ntY2rgGzgmWY2AExfIM0YcOjyl0d0sYf+oxTHs7xjYs+FxYnL+85CV5Af+OsnETr0utP
 xRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698421921; x=1699026721;
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XOeL7vNB8wmCwmKms4FiVCOpJWT5NGw9nhxZFn+ddns=;
 b=oPt9xm9E/hmwFM/WPr1t5MArOHePsWMbkyEG1S5PHkyhxrvlTL31G3FRfqyeeljWRv
 NOUXIGPrAWEOmsukZ/YsedhpCQKC2FmbN4ya9+ddz7NENxQ853tGV/RZ9q65rKpFjiki
 R3hLee1TGMjIRjT2yfQlr6iFcXej3bB2v0ljcp8SZ1Cuq/na0UB7o/tmuxSJPJibiwir
 EKGo6cixTUDcO5dWdo9JYbZTGNPpGIwcoSf7IidJD36QKkexWSsHsNQMirFWK2PMsTRx
 m5sI9biO20D7cr35On2WAOHhUjFI1y71J319eOA+Eoqo6nLsvBCGlozrKwXtrBPjGNfg
 j9TA==
X-Gm-Message-State: AOJu0YyKe9z9TwNegcJCu9hUkGvjliO/fbYH/5MO9ApBxeSvGfmjhHVY
 N8CUQtgSB1iETwo6yjefVMxV9MD+41Ne3ZM52yA=
X-Google-Smtp-Source: AGHT+IHsvgyfY3ALS2fG6UkXcIDVKRh19QpaQb5wh/ZOQJJPOS0439/NOyhd6Lj5EBIfXRmgdI/bhw==
X-Received: by 2002:a05:6a20:938c:b0:14c:d494:77c5 with SMTP id
 x12-20020a056a20938c00b0014cd49477c5mr4177622pzh.13.1698421921498; 
 Fri, 27 Oct 2023 08:52:01 -0700 (PDT)
Received: from localhost ([192.184.165.199]) by smtp.gmail.com with ESMTPSA id
 i16-20020aa787d0000000b0068a13b0b300sm1598505pfo.11.2023.10.27.08.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 08:52:01 -0700 (PDT)
Date: Fri, 27 Oct 2023 08:52:01 -0700 (PDT)
X-Google-Original-Date: Fri, 27 Oct 2023 08:51:58 PDT (-0700)
Subject: Re: [PATCH] Support for the RISCV Zalasr extension
In-Reply-To: <CAGPSXwJEdtqW=nx71oufZp64nK6tK=0rytVEcz4F-gfvCOXk2w@mail.gmail.com>
CC: qemu-devel@nongnu.org, liweiwei@iscas.ac.cn
From: Palmer Dabbelt <palmer@dabbelt.com>
To: turtwig@utexas.edu
Message-ID: <mhng-a654d975-7f2b-4162-9c81-87a462fe72a0@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=palmer@dabbelt.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, 26 Oct 2023 16:03:28 PDT (-0700), turtwig@utexas.edu wrote:
>>From 4af1fca6e5c99578a5b80b834c22b70f6419639f Mon Sep 17 00:00:00 2001
> From: Brendan Sweeney <turtwig@utexas.edu>
> Date: Thu, 26 Oct 2023 17:01:29 -0500
> Subject: [PATCH] Support for the RISCV Zalasr extension

This doesn't have a commit body.  At least pointing to the extension doc 
over at https://github.com/mehnadnerd/riscv-zalasr would be super 
helpful, there's so many extensions these days even Google is having 
trouble finding them.

> Signed-off-by: Brendan Sweeney <turtwig@utexas.edu>
> ---
> target/riscv/cpu.c | 2 +
> target/riscv/cpu_cfg.h | 1 +
> target/riscv/insn32.decode | 15 +++
> target/riscv/insn_trans/trans_rvzalasr.c.inc | 112 +++++++++++++++++++
> target/riscv/translate.c | 1 +
> 5 files changed, 131 insertions(+)
> create mode 100644 target/riscv/insn_trans/trans_rvzalasr.c.inc
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ac4a6c7eec..a0414bd956 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -85,6 +85,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
> ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
> ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
> ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
> + ISA_EXT_DATA_ENTRY(zalasr, PRIV_VERSION_1_12_0, ext_zalasr),
> ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
> ISA_EXT_DATA_ENTRY(zfbfmin, PRIV_VERSION_1_12_0, ext_zfbfmin),
> ISA_EXT_DATA_ENTRY(zfh, PRIV_VERSION_1_11_0, ext_zfh),
> @@ -1248,6 +1249,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] =
> {
> MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
> MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
> MULTI_EXT_CFG_BOOL("zfa", ext_zfa, true),
> + MULTI_EXT_CFG_BOOL("zalasr", ext_zalasr, true),
> MULTI_EXT_CFG_BOOL("zfh", ext_zfh, false),
> MULTI_EXT_CFG_BOOL("zfhmin", ext_zfhmin, false),
> MULTI_EXT_CFG_BOOL("zve32f", ext_zve32f, false),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 0e6a0f245c..8e4f9282fd 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -76,6 +76,7 @@ struct RISCVCPUConfig {
> bool ext_svpbmt;
> bool ext_zdinx;
> bool ext_zawrs;
> + bool ext_zalasr;
> bool ext_zfa;
> bool ext_zfbfmin;
> bool ext_zfh;
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 33597fe2bb..ba95cdf964 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -70,6 +70,9 @@
> @atom_ld ..... aq:1 rl:1 ..... ........ ..... ....... &atomic rs2=0 %rs1 %rd
> @atom_st ..... aq:1 rl:1 ..... ........ ..... ....... &atomic %rs2 %rs1 %rd
> +@l_aq ..... . rl:1 ..... ........ ..... ....... &atomic rs2=0 %rs1 %rd aq=1
> +@s_rl ..... aq:1 . ..... ........ ..... ....... &atomic %rs2 %rs1 rd=0 rl=1
> +
> @r4_rm ..... .. ..... ..... ... ..... ....... %rs3 %rs2 %rs1 %rm %rd
> @r_rm ....... ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
> @@ -739,6 +742,18 @@ vsetvl 1000000 ..... ..... 111 ..... 1010111 @r
> wrs_nto 000000001101 00000 000 00000 1110011
> wrs_sto 000000011101 00000 000 00000 1110011
> +# *** RV32 Zalasr Standard Extension ***
> +lb_aq 00110 1 . 00000 ..... 000 ..... 0101111 @l_aq
> +lh_aq 00110 1 . 00000 ..... 001 ..... 0101111 @l_aq
> +lw_aq 00110 1 . 00000 ..... 010 ..... 0101111 @l_aq
> +sb_rl 00111 . 1 ..... ..... 000 00000 0101111 @s_rl
> +sh_rl 00111 . 1 ..... ..... 001 00000 0101111 @s_rl
> +sw_rl 00111 . 1 ..... ..... 010 00000 0101111 @s_rl
> +
> +# *** RV64 Zalasr Standard Extension (in addition to RV32 Zalasr) ***
> +ld_aq 00110 1 . 00000 ..... 011 ..... 0101111 @l_aq
> +sd_rl 00111 . 1 ..... ..... 011 00000 0101111 @s_rl
> +
> # *** RV32 Zba Standard Extension ***
> sh1add 0010000 .......... 010 ..... 0110011 @r
> sh2add 0010000 .......... 100 ..... 0110011 @r
> diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc
> b/target/riscv/insn_trans/trans_rvzalasr.c.inc
> new file mode 100644
> index 0000000000..cee81ce8b8
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
> @@ -0,0 +1,112 @@
> +/*
> + * RISC-V translation routines for the Zzlasr Standard Extension.
> + *
> + * Copyright (c) 2023 Brendan Sweeney, brs@berkeley.edu
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> with
> + * this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#define REQUIRE_ZALASR(ctx) do { \
> + if (!ctx->cfg_ptr->ext_zalasr) { \
> + return false; \
> + } \
> +} while (0)
> +
> +static bool gen_l_aq(DisasContext *ctx, arg_atomic *a, MemOp mop)
> +{
> + TCGv src1;
> +
> + decode_save_opc(ctx);
> + src1 = get_address(ctx, a->rs1, 0);
> + if (a->rl) {
> + tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
> + }
> + tcg_gen_qemu_ld_tl(load_val, src1, ctx->mem_idx, mop);
> + if (a->aq) {
> + tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
> + }
> + /* Put data in load_val. */
> + gen_set_gpr(ctx, a->rd, load_val);
> +
> + return true;
> +}
> +
> +static bool trans_lb_aq(DisasContext *ctx, arg_lb_aq *a)
> +{
> + REQUIRE_ZALASR(ctx);
> + return gen_l_aq(ctx, a, (MO_ALIGN | MO_SB));
> +}
> +
> +static bool trans_lh_aq(DisasContext *ctx, arg_lh_aq *a)
> +{
> + REQUIRE_ZALASR(ctx);
> + return gen_l_aq(ctx, a, (MO_ALIGN | MO_TESW));
> +}
> +
> +static bool trans_lw_aq(DisasContext *ctx, arg_lw_aq *a)
> +{
> + REQUIRE_ZALASR(ctx);
> + return gen_l_aq(ctx, a, (MO_ALIGN | MO_TESL));
> +}
> +
> +static bool trans_ld_aq(DisasContext *ctx, arg_lw_aq *a)
> +{
> + REQUIRE_ZALASR(ctx);
> + REQUIRE_64_OR_128BIT(ctx);
> + return gen_l_aq(ctx, a, (MO_ALIGN | MO_TESQ));
> +}
> +
> +static bool gen_s_rl(DisasContext *ctx, arg_atomic *a, MemOp mop)
> +{
> + TCGv src1, src2;
> +
> + decode_save_opc(ctx);
> + src1 = get_address(ctx, a->rs1, 0);
> +
> + src2 = get_gpr(ctx, a->rs2, EXT_NONE);
> +
> + if (a->rl) {
> + tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);

Might just be the email, but the indentation is off here.  
scripts/checkpatch.pl should tell you for sure.

> + }
> + tcg_gen_qemu_st_i64(src2, src1, ctx->mem_idx, mop);
> + if (a->aq) {
> + tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
> + }

These are somewhat similar to some of the routines in trans_rva.c so I 
guess we could do some sorto of shared helper, but I'm not sure if 
that's actually cleaner.

> +
> + return true;
> +}
> +
> +static bool trans_sb_rl(DisasContext *ctx, arg_sb_rl *a)
> +{
> + REQUIRE_ZALASR(ctx);
> + return gen_s_rl(ctx, a, (MO_ALIGN | MO_SB));
> +}
> +
> +static bool trans_sh_rl(DisasContext *ctx, arg_sh_rl *a)
> +{
> + REQUIRE_ZALASR(ctx);
> + return gen_s_rl(ctx, a, (MO_ALIGN | MO_TESW));
> +}
> +
> +static bool trans_sw_rl(DisasContext *ctx, arg_sw_rl *a)
> +{
> + REQUIRE_ZALASR(ctx);
> + return gen_s_rl(ctx, a, (MO_ALIGN | MO_TESL));
> +}
> +
> +static bool trans_sd_rl(DisasContext *ctx, arg_sd_rl *a)
> +{
> + REQUIRE_ZALASR(ctx);
> + REQUIRE_64_OR_128BIT(ctx);
> + return gen_s_rl(ctx, a, (MO_ALIGN | MO_TEUQ));
> +}
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index f0be79bb16..bfcf1ff1d8 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1091,6 +1091,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase,
> target_ulong pc)
> #include "insn_trans/trans_rvzicond.c.inc"
> #include "insn_trans/trans_rvzawrs.c.inc"
> #include "insn_trans/trans_rvzicbo.c.inc"
> +#include "insn_trans/trans_rvzalasr.c.inc"
> #include "insn_trans/trans_rvzfa.c.inc"
> #include "insn_trans/trans_rvzfh.c.inc"
> #include "insn_trans/trans_rvk.c.inc"

Aside from those fairly minor issues this LGTM, thanks!

