Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7897A46F51
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Feb 2025 00:21:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnQh4-0001Ib-Lf; Wed, 26 Feb 2025 18:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tnQh1-0001ID-AT; Wed, 26 Feb 2025 18:19:55 -0500
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tnQgw-0000oJ-PS; Wed, 26 Feb 2025 18:19:54 -0500
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-8671d8a9c3eso219386241.3; 
 Wed, 26 Feb 2025 15:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740611988; x=1741216788; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwFO6EYO8LkvPJyZQ8iUJ1ZvrZlfserOnI1dgDkRP7E=;
 b=dUKLSxXAwHeD7FbiGbv63jrkVggsHTEWloI8+8khUlV84QJHvLGLiEa4xeWzjycFM+
 KArYBgXaj1z/zLJO1YpIWZuVFLw7BrDRiBAiTNeS9hBa/G9N+Fs01a7HFV8jvXi58a3k
 XPkl2AOgQ2UHq9BFGrr58R/U7c11sImqMBP7s1Yp0NSWas92F2nO7CUb/xDnIJ/A9Cd0
 1FOSqDveCvoXew0vKJND+jPg9U1/59WTYFsgRcw4yPoh0kD5nHtbQ+qu44vFW/cxz//O
 VuLEkSdqT4icDtArB673lzKFeQA62L/SxdesuIa5oRNvR2fbIHp4xQXsSh6SwOLO4BZl
 pH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740611988; x=1741216788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uwFO6EYO8LkvPJyZQ8iUJ1ZvrZlfserOnI1dgDkRP7E=;
 b=OFIs6UGkEIunV5N+gmjfD5nIyKm9LpLZ7huQ386d98GknuhGOSv5iklt25JbEAXu3D
 KEFmRJJ5PeM3qyakacir9pQoZSOURLjmKABkLBrgCOaGcMQB/sZzBordFDZ1UuFWmCLb
 tVY1gCr5dncIme+lqlUmXLvfWup+Rg3psuokL9ovWb9y3teJ0HtmTeSVZnU0DLVVzY46
 romDC1SuWt3RHt12RzD1ll+WmpqSW25tMlmjBTc1fG+dISxJV5rK5+zz2jGinr18+WGY
 H6tDa7ORM5Cw51wYf1DjKiT4fKMk3PPHnRV7D3Q+88rDmHfSJgGRyog1c9wwuTZh/Ems
 NEFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2JNw/reiuWene+s4186N8EhY+V5z9KuCfetAT92oQrGXeAaP7sUoUNEslhALo/l3+HVQF+PLUDrvO@nongnu.org
X-Gm-Message-State: AOJu0YyMSLb9eTcotOA9HR7o5X+i/4QxQVMAO3oRGac4gIHzeRkTBwcF
 81YAinAZDNZZ2QHT4EBeGHRZslg2cTFpDsuS4qh/X3hNfoYzIuUJeftgI2akgas2iTPeC2vJ4Us
 0EyTGPR87vEIglTHE0HjUstM8Qe0=
X-Gm-Gg: ASbGncsfOXJH3eQQfovPDSoGmdLp3f+jHxzX4oHKhjihqIvGbvgMhtUFS+oJbXZZOka
 4Wbwt+m3l7MLoUDn2tMEB6jJv+W0FjVL7atMuGHzOtQGvb2woPyJhfAPzZAu8BVA4qyzmAFgtao
 89shedNp5cQdWUpSBVmAbRy5mCYSsuRhmGMnSssA==
X-Google-Smtp-Source: AGHT+IHOtxRy/D97jKM9M869jhS5xw6OxzjmxGWCcKE/34ZRcrBP1gL6yFjpy5jNFEDaQOIaqvMeuNgqt9z0OT6udHg=
X-Received: by 2002:a05:6102:dcb:b0:4bb:c24b:b61a with SMTP id
 ada2fe7eead31-4c01e2d6493mr3954972137.19.1740611988708; Wed, 26 Feb 2025
 15:19:48 -0800 (PST)
MIME-Version: 1.0
References: <174044811783.27139.4910941776283875756-0@git.sr.ht>
In-Reply-To: <174044811783.27139.4910941776283875756-0@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 27 Feb 2025 09:19:22 +1000
X-Gm-Features: AQ5f1Jq57Ir1GtdxT8qwthaBZ3jpFBkuZ6hvtPrzrLdAIDbrAUa_WMgiJqgKEvw
Message-ID: <CAKmqyKO85YNhWSYVS7vUqTxi-ZnT4=rPAsGoj+8EPMh334bfTg@mail.gmail.com>
Subject: Re: [PATCH qemu] target/riscv: Only check ext_zca for 16-bit aligned
 PC.
To: "~yuming" <yumin686@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Feb 25, 2025 at 11:49=E2=80=AFAM ~yuming <yuming@git.sr.ht> wrote:
>
> From: Yu-Ming Chang <yumin686@andestech.com>
>
> Since C always implies Zca, Zca is always enabled when 16-bit
> insructions are supported. we can only check ext_zca to allow
> 16-bit aligned PC addresses.
>
> Signed-off-by: Yu-Ming Chang <yumin686@andestech.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvi.c.inc | 5 ++---
>  target/riscv/op_helper.c                | 4 ++--
>  target/riscv/translate.c                | 2 +-
>  3 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_=
trans/trans_rvi.c.inc
> index 96c218a9d7..e5965201a7 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -106,7 +106,7 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a=
)
>          tcg_gen_ext32s_tl(target_pc, target_pc);
>      }
>
> -    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca) {
> +    if (!ctx->cfg_ptr->ext_zca) {
>          TCGv t0 =3D tcg_temp_new();
>
>          misaligned =3D gen_new_label();
> @@ -236,8 +236,7 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, T=
CGCond cond)
>
>      gen_set_label(l); /* branch taken */
>
> -    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca &&
> -        (a->imm & 0x3)) {
> +    if (!ctx->cfg_ptr->ext_zca && (a->imm & 0x3)) {
>          /* misaligned */
>          TCGv target_pc =3D tcg_temp_new();
>          gen_pc_plus_diff(target_pc, ctx, a->imm);
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index ce1256f439..68882136d7 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -276,7 +276,7 @@ target_ulong helper_sret(CPURISCVState *env)
>      }
>
>      target_ulong retpc =3D env->sepc;
> -    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
> +    if (!env_archcpu(env)->cfg.ext_zca && (retpc & 0x3)) {
>          riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
>      }
>
> @@ -349,7 +349,7 @@ static void check_ret_from_m_mode(CPURISCVState *env,=
 target_ulong retpc,
>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      }
>
> -    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
> +    if (!env_archcpu(env)->cfg.ext_zca && (retpc & 0x3)) {
>          riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
>      }
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 698b74f7a8..34eeed50be 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -566,7 +566,7 @@ static void gen_jal(DisasContext *ctx, int rd, target=
_ulong imm)
>      TCGv succ_pc =3D dest_gpr(ctx, rd);
>
>      /* check misaligned: */
> -    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca) {
> +    if (!ctx->cfg_ptr->ext_zca) {
>          if ((imm & 0x3) !=3D 0) {
>              TCGv target_pc =3D tcg_temp_new();
>              gen_pc_plus_diff(target_pc, ctx, imm);
> --
> 2.45.3
>

