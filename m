Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A08E8FA8AF
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jun 2024 05:11:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEKZ3-0007H6-8h; Mon, 03 Jun 2024 23:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEKZ1-0007Gf-9f; Mon, 03 Jun 2024 23:10:19 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEKYz-0004dV-2v; Mon, 03 Jun 2024 23:10:19 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4eb270d92eeso452975e0c.1; 
 Mon, 03 Jun 2024 20:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717470615; x=1718075415; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phxOgEhIvFafXP9D4K8fApCkyVK8rdLJ9u0IJP/kP4M=;
 b=OSlvx0k88tNx452gvYIl2z2oK7z5OK3IPG6MMAuow2oBoDeKqKGmNKWdV1wxY38K4m
 SCiwTQG9EHsNH0mUwiCQy3skb/f5Ed0z4MgXvAq/Ec+CA/Zv0golUPLgE75Uuoxbt/WU
 OLcjolkTFMVPNm097o29VDVXHuOfCREvgWfcKtVZJ2bGGX8nXTGH+xYF2OEY3v4SbuXo
 /drTWS187DmbSCgPG16DgX+lV8gMEfhbyUzsMr3aMRwCbawK5RhR6Dh8X1H16/0qUzUf
 L0v8nmYc4xeYwCIYP87LwGMFAQipOERG574X/AU4l2pgI+2J4qGaFF1KSUzMO0kOGSa3
 EftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717470615; x=1718075415;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phxOgEhIvFafXP9D4K8fApCkyVK8rdLJ9u0IJP/kP4M=;
 b=Oe2fD8oVf/jhLN3i7zTk6FVJm544BuWJNEdPiAUQQHsDM59ctPrdurCG7+m3Va2Jw1
 Ok8dAbwUnv5EUFtaahOwzVf38/rBuqh86NGUOnKvadvKwNCymyBB4yahBiV3llRtQ+L+
 Xy77A78+HJF08Vvc12QhKs2oMKLRb5Fxd4Cdblm9/amII3sFYfMLy1M6cWHdsGJFgpnX
 NuTAHEvqSFDTatq0YR2b4E9qzzoiBhHJ96IWenpAkRX6B8lMmhhwrAdUvaw9BUbPowaQ
 scnObQ2Uhn8zL6JTJfnWmp7pB8sJYg0od707Mf8T3ASU8Zz/Il1euADagCp07ICnP/ne
 4Bgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu2z5eF4kMtiLw6p6sEEXXPNY/20KJUHIzZEhfehK4S3p2h7cohjLw23AqbtWOo+Q9Q4MqIDqV558X8cn/KF2OW5+vOiE=
X-Gm-Message-State: AOJu0YzUp9mCscql7AJmNIO3zffFq30iKaTgt5DO93hFZVqMGahpGCz+
 deRlDj9akpgYcPKKs2Q++HEj++X7xIWu0kWHW+aoY+K3kJWpqT26eKF6TTlkoa/u/RxmJony+4U
 RUe3YlJsk3Pcuj+PXcllfXbjtsTA=
X-Google-Smtp-Source: AGHT+IE1uxXIa8NcXIQ9WZQDWABtYbkm5672RIF6k87qlFJ+36k+jyM8BMotoHGoLHVliMgO4riDQHnrBgd8XI1/X2I=
X-Received: by 2002:ac5:cbc6:0:b0:4d3:39c3:717c with SMTP id
 71dfb90a1353d-4eb02d7623dmr9831589e0c.1.1717470613878; Mon, 03 Jun 2024
 20:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240523124045.1964-1-zhiwei_liu@linux.alibaba.com>
 <20240523124045.1964-3-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240523124045.1964-3-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 13:09:47 +1000
Message-ID: <CAKmqyKOe5GdCy4eDxP4v+uGoOQU19pYF2dOGQyCX97ByV4dEkA@mail.gmail.com>
Subject: Re: [PATCH 2/6] target/riscv: Add AMO instructions for Zabha
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, dbarboza@ventanamicro.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, May 23, 2024 at 10:44=E2=80=AFPM LIU Zhiwei
<zhiwei_liu@linux.alibaba.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_cfg.h                      |   1 +
>  target/riscv/insn32.decode                  |  20 +++
>  target/riscv/insn_trans/trans_rvzabha.c.inc | 131 ++++++++++++++++++++
>  target/riscv/translate.c                    |   4 +-
>  4 files changed, 155 insertions(+), 1 deletion(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvzabha.c.inc
>
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index b327b144d7..f241b0b173 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -84,6 +84,7 @@ struct RISCVCPUConfig {
>      bool ext_zaamo;
>      bool ext_zacas;
>      bool ext_zama16b;
> +    bool ext_zabha;
>      bool ext_zalrsc;
>      bool ext_zawrs;
>      bool ext_zfa;
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 972a1e8fd1..8a4801d442 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1021,3 +1021,23 @@ amocas_q    00101 . . ..... ..... 100 ..... 010111=
1 @atom_st
>  # *** Zimop may-be-operation extension ***
>  mop_r_n     1 . 00 .. 0111 .. ..... 100 ..... 0111011 @mop5
>  mop_rr_n    1 . 00 .. 1 ..... ..... 100 ..... 0111011 @mop3
> +
> +# *** Zabhb Standard Extension ***
> +amoswap_b  00001 . . ..... ..... 000 ..... 0101111 @atom_st
> +amoadd_b   00000 . . ..... ..... 000 ..... 0101111 @atom_st
> +amoxor_b   00100 . . ..... ..... 000 ..... 0101111 @atom_st
> +amoand_b   01100 . . ..... ..... 000 ..... 0101111 @atom_st
> +amoor_b    01000 . . ..... ..... 000 ..... 0101111 @atom_st
> +amomin_b   10000 . . ..... ..... 000 ..... 0101111 @atom_st
> +amomax_b   10100 . . ..... ..... 000 ..... 0101111 @atom_st
> +amominu_b  11000 . . ..... ..... 000 ..... 0101111 @atom_st
> +amomaxu_b  11100 . . ..... ..... 000 ..... 0101111 @atom_st
> +amoswap_h  00001 . . ..... ..... 001 ..... 0101111 @atom_st
> +amoadd_h   00000 . . ..... ..... 001 ..... 0101111 @atom_st
> +amoxor_h   00100 . . ..... ..... 001 ..... 0101111 @atom_st
> +amoand_h   01100 . . ..... ..... 001 ..... 0101111 @atom_st
> +amoor_h    01000 . . ..... ..... 001 ..... 0101111 @atom_st
> +amomin_h   10000 . . ..... ..... 001 ..... 0101111 @atom_st
> +amomax_h   10100 . . ..... ..... 001 ..... 0101111 @atom_st
> +amominu_h  11000 . . ..... ..... 001 ..... 0101111 @atom_st
> +amomaxu_h  11100 . . ..... ..... 001 ..... 0101111 @atom_st
> diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/i=
nsn_trans/trans_rvzabha.c.inc
> new file mode 100644
> index 0000000000..9093a1cfc1
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvzabha.c.inc
> @@ -0,0 +1,131 @@
> +/*
> + * RISC-V translation routines for the Zabha Standard Extension.
> + *
> + * Copyright (c) 2024 Alibaba Group
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#define REQUIRE_ZABHA(ctx) do {           \
> +    if (!ctx->cfg_ptr->ext_zabha) {       \
> +        return false;                     \
> +    }                                     \
> +} while (0)
> +
> +static bool trans_amoswap_b(DisasContext *ctx, arg_amoswap_b *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_SB);
> +}
> +
> +static bool trans_amoadd_b(DisasContext *ctx, arg_amoadd_b *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_SB);
> +}
> +
> +static bool trans_amoxor_b(DisasContext *ctx, arg_amoxor_b *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_SB);
> +}
> +
> +static bool trans_amoand_b(DisasContext *ctx, arg_amoand_b *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_SB);
> +}
> +
> +static bool trans_amoor_b(DisasContext *ctx, arg_amoor_b *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_SB);
> +}
> +
> +static bool trans_amomin_b(DisasContext *ctx, arg_amomin_b *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_SB);
> +}
> +
> +static bool trans_amomax_b(DisasContext *ctx, arg_amomax_b *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_SB);
> +}
> +
> +static bool trans_amominu_b(DisasContext *ctx, arg_amominu_b *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_SB);
> +}
> +
> +static bool trans_amomaxu_b(DisasContext *ctx, arg_amomaxu_b *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_SB);
> +}
> +
> +static bool trans_amoswap_h(DisasContext *ctx, arg_amoswap_h *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESW);
> +}
> +
> +static bool trans_amoadd_h(DisasContext *ctx, arg_amoadd_h *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TESW);
> +}
> +
> +static bool trans_amoxor_h(DisasContext *ctx, arg_amoxor_h *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TESW);
> +}
> +
> +static bool trans_amoand_h(DisasContext *ctx, arg_amoand_h *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TESW);
> +}
> +
> +static bool trans_amoor_h(DisasContext *ctx, arg_amoor_h *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TESW);
> +}
> +
> +static bool trans_amomin_h(DisasContext *ctx, arg_amomin_h *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TESW);
> +}
> +
> +static bool trans_amomax_h(DisasContext *ctx, arg_amomax_h *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TESW);
> +}
> +
> +static bool trans_amominu_h(DisasContext *ctx, arg_amominu_h *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TESW);
> +}
> +
> +static bool trans_amomaxu_h(DisasContext *ctx, arg_amomaxu_h *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TESW);
> +}
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index b160bcbfe0..f597542f1c 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1081,8 +1081,9 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *=
a,
>  {
>      TCGv dest =3D dest_gpr(ctx, a->rd);
>      TCGv src1, src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
> +    MemOp size =3D mop & MO_SIZE;
>
> -    if (ctx->cfg_ptr->ext_zama16b) {
> +    if (ctx->cfg_ptr->ext_zama16b && size >=3D MO_32) {
>          mop |=3D MO_ATOM_WITHIN16;
>      } else {
>          mop |=3D MO_ALIGN;
> @@ -1116,6 +1117,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase,=
 target_ulong pc)
>  #include "insn_trans/trans_rvb.c.inc"
>  #include "insn_trans/trans_rvzicond.c.inc"
>  #include "insn_trans/trans_rvzacas.c.inc"
> +#include "insn_trans/trans_rvzabha.c.inc"
>  #include "insn_trans/trans_rvzawrs.c.inc"
>  #include "insn_trans/trans_rvzicbo.c.inc"
>  #include "insn_trans/trans_rvzimop.c.inc"
> --
> 2.25.1
>
>

