Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B98720579
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:09:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q56Og-00040t-Us; Fri, 02 Jun 2023 11:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liweiwei@iscas.ac.cn>)
 id 1q56Ob-00040f-IP; Fri, 02 Jun 2023 11:08:53 -0400
Received: from smtp80.cstnet.cn ([159.226.251.80] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <liweiwei@iscas.ac.cn>)
 id 1q56OX-0000Zk-LF; Fri, 02 Jun 2023 11:08:53 -0400
Received: from [192.168.114.181] (unknown [61.242.135.4])
 by APP-01 (Coremail) with SMTP id qwCowABXXAz0BXpkQawkCg--.39817S2;
 Fri, 02 Jun 2023 23:08:37 +0800 (CST)
Message-ID: <b703e507-b00b-cdf7-067a-96954b80ce85@iscas.ac.cn>
Date: Fri, 2 Jun 2023 23:08:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] target/riscv: Add Zacas ISA extension support
Content-Language: en-US
To: Rob Bradford <rbradford@rivosinc.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20230602121638.36342-1-rbradford@rivosinc.com>
 <20230602121638.36342-2-rbradford@rivosinc.com>
From: Weiwei Li <liweiwei@iscas.ac.cn>
In-Reply-To: <20230602121638.36342-2-rbradford@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: qwCowABXXAz0BXpkQawkCg--.39817S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKr47CFyUXF17ZF1rXFW7XFb_yoW3CFW5pF
 W8GFy7WFWUJryFyasaqF45Cr1UAr4SkrW2g3sagwn2vFZ8GFW7Gr1qk3yakrW8Ja95XrWF
 9a15CFyUArZ5ta7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
 Y487MxkIecxEwVAFwVW5WwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
 C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
 wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
 v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
 jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
 ZFpf9x0JUgmRUUUUUU=
X-Originating-IP: [61.242.135.4]
X-CM-SenderInfo: 5olzvxxzhlqxpvfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.80; envelope-from=liweiwei@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.095,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 2023/6/2 20:16, Rob Bradford wrote:
> This commit adds support for the the amocas.{w,d,q} instructions behind
> a new property to enable that instruction.
>
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> ---
>   target/riscv/cpu.c                          |   4 +
>   target/riscv/cpu.h                          |   1 +
>   target/riscv/insn32.decode                  |   5 +
>   target/riscv/insn_trans/trans_rvzacas.c.inc | 146 ++++++++++++++++++++
>   target/riscv/translate.c                    |   1 +
>   5 files changed, 157 insertions(+)
>   create mode 100644 target/riscv/insn_trans/trans_rvzacas.c.inc
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index db0875fb43..e99833eb4a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -82,6 +82,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_icsr),
>       ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_ifencei),
>       ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
> +    ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
>       ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
>       ISA_EXT_DATA_ENTRY(zfh, PRIV_VERSION_1_11_0, ext_zfh),
>       ISA_EXT_DATA_ENTRY(zfhmin, PRIV_VERSION_1_11_0, ext_zfhmin),
> @@ -1604,6 +1605,9 @@ static Property riscv_cpu_extensions[] = {
>       DEFINE_PROP_BOOL("x-zvfh", RISCVCPU, cfg.ext_zvfh, false),
>       DEFINE_PROP_BOOL("x-zvfhmin", RISCVCPU, cfg.ext_zvfhmin, false),
>   
> +    /* Atomic CAS (Zacas) */
> +    DEFINE_PROP_BOOL("x-zacas", RISCVCPU, cfg.ext_zacas, false),
> +
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index de7e43126a..ac4d9e8e9c 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -436,6 +436,7 @@ struct RISCVCPUConfig {
>       bool ext_smaia;
>       bool ext_ssaia;
>       bool ext_sscofpmf;
> +    bool ext_zacas;
>       bool rvv_ta_all_1s;
>       bool rvv_ma_all_1s;
>   
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 73d5d1b045..97d17ee520 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -255,6 +255,11 @@ amomax_d   10100 . . ..... ..... 011 ..... 0101111 @atom_st
>   amominu_d  11000 . . ..... ..... 011 ..... 0101111 @atom_st
>   amomaxu_d  11100 . . ..... ..... 011 ..... 0101111 @atom_st
>   
> +# *** Zacas Extension
> +amocas_w   00101 . . ..... ..... 010 ..... 0101111 @atom_st
> +amocas_d   00101 . . ..... ..... 011 ..... 0101111 @atom_st
> +amocas_q   00101 . . ..... ..... 100 ..... 0101111 @atom_st
> +
>   # *** RV32F Standard Extension ***
>   flw        ............   ..... 010 ..... 0000111 @i
>   fsw        .......  ..... ..... 010 ..... 0100111 @s
> diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/insn_trans/trans_rvzacas.c.inc
> new file mode 100644
> index 0000000000..3f1b58ee8a
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
> @@ -0,0 +1,146 @@
> +/*
> + * RISC-V translation routines for Zacas extension
> + *
> + * Copyright (c) 2023 Rivos Inc
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#define REQUIRE_ZACAS(ctx) do {                 \
> +    if (!ctx->cfg_ptr->ext_zacas) {             \
> +        return false;                           \
> +    }                                           \
> +} while (0)
> +
> +static bool amocas_tl(DisasContext *ctx, arg_atomic *a, MemOp mop)
> +{
> +    TCGv retv = dest_gpr(ctx, a->rd);
> +    TCGv addr = get_address(ctx, a->rs1, 0);
> +    TCGv newv = get_gpr(ctx, a->rs2, EXT_ZERO);
> +    TCGv cmpv = get_gpr(ctx, a->rd, EXT_ZERO);
> +
> +    decode_save_opc(ctx);
> +    tcg_gen_atomic_cmpxchg_tl(retv, addr, cmpv, newv, ctx->mem_idx, mop);
> +    gen_set_gpr(ctx, a->rd, retv);
> +
> +    return true;
> +}
> +
> +#if TARGET_LONG_BITS == 32
> +static bool trans_amocas_w(DisasContext *ctx, arg_amocas_w *a)
> +{
> +    REQUIRE_ZACAS(ctx);
> +    return amocas_tl(ctx, a, MO_TESL | MO_ALIGN);
> +}
> +#else
> +static bool trans_amocas_w(DisasContext *ctx, arg_amocas_w *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +    REQUIRE_ZACAS(ctx);
> +    ctx->ol = MXL_RV32;
> +    return amocas_tl(ctx, a, MO_TESL | MO_ALIGN);
> +}
> +#endif
> +
> +#if TARGET_LONG_BITS == 32
> +static bool trans_amocas_d(DisasContext *ctx, arg_amocas_w *a)
> +{
> +    TCGv_i64 retv, newv, cmpv;
> +    TCGv_i32 cmpv_l, cmpv_h, newv_l, newv_h;
> +    TCGv addr;
> +
> +    REQUIRE_ZACAS(ctx);
> +
> +    if (a->rd % 2 == 1 || a->rs2 % 2 == 1) {
> +        return false;
> +    }
> +
> +    addr = get_address(ctx, a->rs1, 0);
> +    cmpv_l = get_gpr(ctx, a->rd, 0);
> +    cmpv_h = a->rd == 0 ? get_gpr(ctx, 0, 0) : get_gpr(ctx, a->rd + 1, 0);
> +    cmpv = tcg_temp_new_i64();
> +    tcg_gen_concat_i32_i64(cmpv, cmpv_l, cmpv_h);
> +    newv_l = get_gpr(ctx, a->rs2, 0);
> +    newv_h = a->rs2 == 0 ? get_gpr(ctx, 0, 0) : get_gpr(ctx, a->rs2 + 1, 0);
> +    newv = tcg_temp_new_i64();
> +    tcg_gen_concat_i32_i64(newv, newv_l, newv_h);
> +    retv = tcg_temp_new_i64();
> +
> +    decode_save_opc(ctx);
> +    tcg_gen_atomic_cmpxchg_i64(retv, addr, cmpv, newv, ctx->mem_idx,
> +                               MO_TESQ | MO_ALIGN);
> +
> +    if (a->rd != 0) {
> +        TCGv_i32 retv_l = tcg_temp_new_i32();
> +        TCGv_i32 retv_h = tcg_temp_new_i32();
> +        tcg_gen_extr_i64_i32(retv_l, retv_h, retv);
> +        gen_set_gpr(ctx, a->rd, retv_l);
> +        gen_set_gpr(ctx, a->rd + 1, retv_h);
> +    }
> +
> +    return true;
> +}
> +#else
> +static bool trans_amocas_d(DisasContext *ctx, arg_amocas_w *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +    REQUIRE_ZACAS(ctx);
> +    return amocas_tl(ctx, a, MO_TESQ | MO_ALIGN);
> +}
> +#endif
> +
> +#if TARGET_LONG_BITS == 32
> +static bool trans_amocas_q(DisasContext *ctx, arg_amocas_w *a)
> +{
> +    return false;
> +}
> +#else
> +static bool trans_amocas_q(DisasContext *ctx, arg_amocas_w *a)
> +{
> +    TCGv_i128 retv, newv, cmpv;
> +    TCGv_i64 cmpv_l, cmpv_h, newv_l, newv_h;
> +    TCGv addr;
> +
> +    REQUIRE_64BIT(ctx);
> +    REQUIRE_ZACAS(ctx);
> +
> +    if (a->rd % 2 == 1 || a->rs2 % 2 == 1) {
> +        return false;
> +    }
> +
> +    addr = get_address(ctx, a->rs1, 0);
> +    cmpv_l = get_gpr(ctx, a->rd, 0);
> +    cmpv_h = a->rd == 0 ? get_gpr(ctx, 0, 0) : get_gpr(ctx, a->rd + 1, 0);
> +    cmpv = tcg_temp_new_i128();
> +    tcg_gen_concat_i64_i128(cmpv, cmpv_l, cmpv_h);
> +    newv_l = get_gpr(ctx, a->rs2, 0);
> +    newv_h = a->rs2 == 0 ? get_gpr(ctx, 0, 0) : get_gpr(ctx, a->rs2 + 1, 0);
> +    newv = tcg_temp_new_i128();
> +    tcg_gen_concat_i64_i128(newv, newv_l, newv_h);
> +    retv = tcg_temp_new_i128();
> +
> +    decode_save_opc(ctx);
> +    tcg_gen_atomic_cmpxchg_i128(retv, addr, cmpv, newv, ctx->mem_idx,
> +                                MO_TEUO | MO_ALIGN);
> +
> +    if (a->rd != 0) {
> +        TCGv_i64 retv_l = tcg_temp_new_i64();
> +        TCGv_i64 retv_h = tcg_temp_new_i64();
> +        tcg_gen_extr_i128_i64(retv_l, retv_h, retv);
> +        gen_set_gpr(ctx, a->rd, retv_l);
> +        gen_set_gpr(ctx, a->rd + 1, retv_h);
> +    }
> +
> +    return true;
> +}
> +#endif
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 928da0d3f0..55438f5ebf 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1074,6 +1074,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
>   #include "insn_trans/trans_rvv.c.inc"
>   #include "insn_trans/trans_rvb.c.inc"
>   #include "insn_trans/trans_rvzicond.c.inc"
> +#include "insn_trans/trans_rvzacas.c.inc"
>   #include "insn_trans/trans_rvzawrs.c.inc"
>   #include "insn_trans/trans_rvzicbo.c.inc"
>   #include "insn_trans/trans_rvzfh.c.inc"

It seems lack check on "Zacas requires A"

Regards,

Weiwei Li


