Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8F0AD4FF6
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Jun 2025 11:35:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPHq5-00080F-ES; Wed, 11 Jun 2025 05:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roan.richmond@codethink.co.uk>)
 id 1uPHq2-0007yt-GY; Wed, 11 Jun 2025 05:33:42 -0400
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roan.richmond@codethink.co.uk>)
 id 1uPHpz-00021R-A4; Wed, 11 Jun 2025 05:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cFQy2W40EyvS2+VvC0lkkXo04Uagl7gI6EvP6jsnenI=; b=yqLFKBA7Wn3ErDOqL49LsZGCEv
 4sMURb8Q4YhTAF4ztO85tnd8L18gD4dzTJaVGRybmCW6eNyrSkjQgaPH/D8w9n472C2vB7/uLiRjN
 SV7ni0d6wkbPH47/pz2kZajf+1MmnPU4fhN0F7sA4IctBuCpQsFEzqanaBtqO1buLASzLL95myMuw
 LLbpaOHXTyT7Rayra+zifXUMqUgLHBKE5zruv2uGpS6zNbncAPCw9GzNG6NT9HNmuMC50UWLdWk3R
 86GnDXoMjMmXz7XtkMrXZ3GTziL/lmEh/bxryXERyexY7YJjfk2q5jkl/prEtms+oJv29GZ4sEkW4
 BBnMQzsw==;
Received: from [167.98.27.226] (helo=[10.35.4.30])
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uPHpq-00CSo8-Bq; Wed, 11 Jun 2025 10:33:30 +0100
Message-ID: <786197e2-360b-4723-99d6-445b8a2076ae@codethink.co.uk>
Date: Wed, 11 Jun 2025 10:33:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Add RISCV ZALASR extension
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org
References: <20250610083309.992724-1-roan.richmond@codethink.co.uk>
 <20250610083309.992724-2-roan.richmond@codethink.co.uk>
 <CAKmqyKMG_wNPNdAYhsUFJ4K7o4g+LNYwUDUAO_8V14=GezDKPg@mail.gmail.com>
Content-Language: en-US
From: Roan Richmond <roan.richmond@codethink.co.uk>
In-Reply-To: <CAKmqyKMG_wNPNdAYhsUFJ4K7o4g+LNYwUDUAO_8V14=GezDKPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=roan.richmond@codethink.co.uk; helo=imap4.hz.codethink.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 11/06/2025 05:29, Alistair Francis wrote:
> On Tue, Jun 10, 2025 at 6:33 PM Roan Richmond
> <roan.richmond@codethink.co.uk> wrote:
>> This is based on version v0.8.3 of the ZALASR specification [1].
>> The specification is listed as in Frozen state [2].
>>
>> [1]: https://github.com/riscv/riscv-zalasr/tree/v0.8.3
>> [2]: https://lf-riscv.atlassian.net/wiki/spaces/HOME/pages/16154882/All+RISC-V+Specifications+Under+Active+Development
>>
>> Signed-off-by: Roan Richmond <roan.richmond@codethink.co.uk>
>> ---
>>   target/riscv/cpu.c                           |   1 +
>>   target/riscv/insn32.decode                   |  10 ++
>>   target/riscv/insn_trans/trans_rvzalasr.c.inc | 110 +++++++++++++++++++
>>   target/riscv/translate.c                     |   1 +
>>   4 files changed, 122 insertions(+)
>>   create mode 100644 target/riscv/insn_trans/trans_rvzalasr.c.inc
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 629ac37501..b52bbf0936 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -128,6 +128,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>       ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
>>       ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
>>       ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_13_0, ext_zama16b),
>> +    ISA_EXT_DATA_ENTRY(zalasr, PRIV_VERSION_1_12_0, ext_zalasr),
>>       ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
>>       ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
>>       ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
>> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
>> index cd23b1f3a9..c848c0c1c5 100644
>> --- a/target/riscv/insn32.decode
>> +++ b/target/riscv/insn32.decode
>> @@ -1066,3 +1066,13 @@ amominu_h  11000 . . ..... ..... 001 ..... 0101111 @atom_st
>>   amomaxu_h  11100 . . ..... ..... 001 ..... 0101111 @atom_st
>>   amocas_b    00101 . . ..... ..... 000 ..... 0101111 @atom_st
>>   amocas_h    00101 . . ..... ..... 001 ..... 0101111 @atom_st
>> +
>> +# *** Zalasr Standard Extension ***
>> +lb_aqrl  00110 . . ..... ..... 000 ..... 0101111 @atom_st
>> +lh_aqrl  00110 . . ..... ..... 001 ..... 0101111 @atom_st
>> +lw_aqrl  00110 . . ..... ..... 010 ..... 0101111 @atom_st
>> +ld_aqrl  00110 . . ..... ..... 011 ..... 0101111 @atom_st
>> +sb_aqrl  00111 . . ..... ..... 000 ..... 0101111 @atom_st
>> +sh_aqrl  00111 . . ..... ..... 001 ..... 0101111 @atom_st
>> +sw_aqrl  00111 . . ..... ..... 010 ..... 0101111 @atom_st
>> +sd_aqrl  00111 . . ..... ..... 011 ..... 0101111 @atom_st
>> diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/insn_trans/trans_rvzalasr.c.inc
>> new file mode 100644
>> index 0000000000..2f2934e731
>> --- /dev/null
>> +++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
>> @@ -0,0 +1,110 @@
>> +/*
>> + * RISC-V translation routines for the ZALASR (Load-Aquire and Store-Release)
>> + * Extension.
>> + *
>> + * Copyright (c) 2025 Roan Richmond, roan.richmond@codethink.co.uk
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2 or later, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along with
>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#define REQUIRE_ZALASR(ctx) do {     \
>> +    if (!ctx->cfg_ptr->ext_zalasr) { \
>> +        return false;                \
>> +    }                                \
>> +} while (0)
>> +
>> +static bool gen_load_acquire(DisasContext *ctx, arg_lb_aqrl *a, MemOp memop)
>> +{
>> +    decode_save_opc(ctx, 0);
>> +
>> +    TCGv addr = get_address(ctx, a->rs1, 0);
>> +    TCGv dest = get_gpr(ctx, a->rd, EXT_NONE);
>> +    TCGBar bar = (a->rl) ? TCG_BAR_STRL : 0;
> I think we should check that aq isn't set
According to the spec, it is valid for both of `rl` and `aq` to be set.
For the Load Acquire instruction it just states that `aq` must be set, 
and `rl` is optionally set.
Therefore, I don't think we should check that `aq` isn't set here.
>> +
>> +    memop |= (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
>> +
>> +    tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, memop);
>> +    gen_set_gpr(ctx, a->rd, dest);
>> +
>> +    /* Add a memory barrier implied by AQ (mandatory) and RL (optional) */
>> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ | bar);
>> +
>> +    return true;
>> +}
>> +
>> +static bool trans_lb_aqrl(DisasContext *ctx, arg_lb_aqrl *a)
>> +{
>> +    REQUIRE_ZALASR(ctx);
>> +    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_SB));
>> +}
>> +
>> +static bool trans_lh_aqrl(DisasContext *ctx, arg_lh_aqrl *a)
>> +{
>> +    REQUIRE_ZALASR(ctx);
>> +    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TESW));
>> +}
>> +
>> +static bool trans_lw_aqrl(DisasContext *ctx, arg_lw_aqrl *a)
>> +{
>> +    REQUIRE_ZALASR(ctx);
>> +    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TESL));
>> +}
>> +
>> +static bool trans_ld_aqrl(DisasContext *ctx, arg_ld_aqrl *a)
>> +{
>> +    REQUIRE_64BIT(ctx);
>> +    REQUIRE_ZALASR(ctx);
>> +    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TEUQ));
>> +}
>> +
>> +static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp memop)
>> +{
>> +    decode_save_opc(ctx, 0);
>> +
>> +    TCGv addr = get_address(ctx, a->rs1, 0);
>> +    TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
>> +    TCGBar bar = (a->aq) ? TCG_BAR_LDAQ : 0;
> and check here that rq isn't set either
>
> Alistair
For the Store Release instruction it the spec just states that `rl` must 
be set, and `aq` is optionally set.
Therefore, I don't think we should check that `rl` isn't set here.
>> +
>> +    memop |= (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
>> +
>> +    /* Add a memory barrier implied by RL (mandatory) and AQ (optional) */
>> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL | bar);
>> +
>> +    tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
>> +    return true;
>> +}
>> +
>> +static bool trans_sb_aqrl(DisasContext *ctx, arg_sb_aqrl *a)
>> +{
>> +    REQUIRE_ZALASR(ctx);
>> +    return gen_store_release(ctx, a, (MO_ALIGN | MO_SB));
>> +}
>> +
>> +static bool trans_sh_aqrl(DisasContext *ctx, arg_sh_aqrl *a)
>> +{
>> +    REQUIRE_ZALASR(ctx);
>> +    return gen_store_release(ctx, a, (MO_ALIGN | MO_TESW));
>> +}
>> +
>> +static bool trans_sw_aqrl(DisasContext *ctx, arg_sw_aqrl *a)
>> +{
>> +    REQUIRE_ZALASR(ctx);
>> +    return gen_store_release(ctx, a, (MO_ALIGN | MO_TESL));
>> +}
>> +
>> +static bool trans_sd_aqrl(DisasContext *ctx, arg_sd_aqrl *a)
>> +{
>> +    REQUIRE_64BIT(ctx);
>> +    REQUIRE_ZALASR(ctx);
>> +    return gen_store_release(ctx, a, (MO_ALIGN | MO_TEUQ));
>> +}
>> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
>> index d7a6de02df..4cd2d68e46 100644
>> --- a/target/riscv/translate.c
>> +++ b/target/riscv/translate.c
>> @@ -1183,6 +1183,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
>>   #include "insn_trans/trans_rvzicond.c.inc"
>>   #include "insn_trans/trans_rvzacas.c.inc"
>>   #include "insn_trans/trans_rvzabha.c.inc"
>> +#include "insn_trans/trans_rvzalasr.c.inc"
>>   #include "insn_trans/trans_rvzawrs.c.inc"
>>   #include "insn_trans/trans_rvzicbo.c.inc"
>>   #include "insn_trans/trans_rvzimop.c.inc"
>> --
>> 2.43.0
>>
Thanks,
Roan

-- 
Roan Richmond (he/him)
Software Engineer
Codethink Ltd


