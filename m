Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B287D4CF2
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 11:52:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvE40-0005u4-Pt; Tue, 24 Oct 2023 05:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qvE3x-0005tp-TR
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 05:51:02 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qvE3v-0003BN-Va
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 05:51:01 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5ac87af634aso2518860a12.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 02:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1698141058; x=1698745858; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1LAuXFe1tRi+LN1r6Q1a6QqPR3IqUF9MPy5wr7CPACQ=;
 b=Wl7nMAHgF9pCFxUmEOJFwjPnRDyl2iUsxI1ZsI/fNedf3/jVA6Bw6zBTfr2Hpna7F2
 nIWSqWyazlrg9mH99xpVAiKsnAO41Ph7Q+ZWLHt1ZPF5fV5xNMffXsICFJqTvmhmVcxN
 Ot7Iknw/8eV4TU7QkrSX6+IWvSEY7GBvJv3ErOV2XYC5Oowq7f1E+FRfZy2YJPI+OV1Z
 E9Gn1J1wZiqURgAVSSKt8tAWIDKTsMjQNVFGfSBlEORtGeEbr0DNNoLLGteZcdfSL0Yk
 q7K3Jm79NZ1fARWyNh14Q6QTwi3TO2mVlOqVjVitSS3vVMLPscUiCm46jvX3gPWB/8pg
 55yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698141058; x=1698745858;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1LAuXFe1tRi+LN1r6Q1a6QqPR3IqUF9MPy5wr7CPACQ=;
 b=tdQ+s4Z4tZSpk6/nLiBsFyoFCaLnR+F2NDZtQtC+/nnbuXTNBUZG4Dz2dAp4F3XjwB
 rHkRiZsp3zAC/xk5PX+SmX5vTC38hw0PL1/Pexm3aiOUnokEYFpdBxtQiCVjGjhbGtyu
 2MLjMnv6n8z0z1aYq3Yv4YB2JQKM316xqGpyZ37J85hvM2C5lpjyRMoUznFQ8XW6S34L
 I0bMD5mZzGZ41DBT21zVyoWeaM1RC8z/RwhOJ9Z4SFUBVvWqB5WZL7lx/4RE1iMvkVMS
 K6VX0q/KhsWBUWf7NxrxQCJ/7NRmgVAfjCUwFLLrfUZXBPNwhmztxFHtXblO2bx0ZnU4
 ugRA==
X-Gm-Message-State: AOJu0YwZrytE3zeYDwwPynQP3b1m3HWVGOSnxPs1oJcEWytbkMCH+608
 EBDezWYqNSK4EkPNBRBfqXObBGsuGsi115H00DKnTQ==
X-Google-Smtp-Source: AGHT+IFTzxkF11Otyg0NVG+aM6iN8t4EtFcQjru1a4mSwii+gNZh6COU9SM+FgsD/JRUSnIXDYnpJDjlM4WCbXBMa1w=
X-Received: by 2002:a17:90b:2d8a:b0:27c:ef4b:6dcf with SMTP id
 sj10-20020a17090b2d8a00b0027cef4b6dcfmr9584624pjb.21.1698141058054; Tue, 24
 Oct 2023 02:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230914174436.1597356-1-richard.henderson@linaro.org>
 <20230914174436.1597356-7-richard.henderson@linaro.org>
In-Reply-To: <20230914174436.1597356-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Tue, 24 Oct 2023 11:50:46 +0200
Message-ID: <CAJ307EjR0oKs6W=7ZgsqeM1XrHbTYF4sXN2vV9jn1eiRsMewVA@mail.gmail.com>
Subject: Re: [PATCH 6/6] accel/tcg: Always require can_do_io
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=chigot@adacore.com; helo=mail-pg1-x52c.google.com
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

Hi Richard,

This commit has broken some of our internal bareboard testing on
Risc-V 64. At some point in our programs, there is an AMOSWAP (=3D
atomic swap) instruction on I/O. But since this commit, can_do_io is
set to false triggering an infinite loop.
IIUC the doc (cf [1]), atomic operations on I/O are allowed.

I think there is a CF_LAST_IO flag missing somewhere to allow it, but
I'm not sure where this should be. Do you have any ideas ?

Sadly I cannot provide a reproducer that easily, mainly because our
microchip has a few patches not yet merged making our binaries not
running on the upstream master.
But here is a bit of the in_asm backtrace:

  | IN: system__bb__riscv_plic__initialize
  | Priv: 3; Virt: 0
  | 0x80000eb4:  1141              addi                    sp,sp,-16
  | 0x80000eb6:  0c0027b7          lui                     a5,49154
  | 0x80000eba:  e406              sd                      ra,8(sp)
  | 0x80000ebc:  00010597          auipc                   a1,16
            # 0x80010ebc
  | 0x80000ec0:  47458593          addi                    a1,a1,1140
  | 0x80000ec4:  f3ffe637          lui                     a2,-49154
  | 0x80000ec8:  01878693          addi                    a3,a5,24
  | 0x80000ecc:  00f58733          add                     a4,a1,a5
  | 0x80000ed0:  9732              add                     a4,a4,a2
  | 0x80000ed2:  4318              lw                      a4,0(a4)
  | 0x80000ed4:  2701              sext.w                  a4,a4
  | 0x80000ed6:  08e7a02f          amoswap.w               zero,a4,(a5)
  | 0x80000eda:  0791              addi                    a5,a5,4
  | 0x80000edc:  fed798e3          bne                     a5,a3,-16
            # 0x80000ecc
  |
  | ----------------
  | IN: system__bb__riscv_plic__initialize
  | Priv: 3; Virt: 0
  | 0x80000ed6:  08e7a02f          amoswap.w               zero,a4,(a5)
  |
  | ----------------
  | IN: system__bb__riscv_plic__initialize
  | Priv: 3; Virt: 0
  | 0x80000ed6:  08e7a02f          amoswap.w               zero,a4,(a5)
  | * Freeze *

a5 (=3D 0xc002000) above is targeting an address inside sifive_plic HW.


Note IIUC the doc (cf [1]), atomic operations on I/O are allowed.
[1] https://github.com/riscv/riscv-isa-manual/blob/main/src/a-st-ext.adoc#a=
tomic-memory-operations

Thanks in advance.

On Thu, Sep 14, 2023 at 7:45=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Require i/o as the last insn of a TranslationBlock always,
> not only with icount.  This is required for i/o that alters
> the address space, such as a pci config space write.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1866
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/translator.c      | 20 +++++++-------------
>  target/mips/tcg/translate.c |  1 -
>  2 files changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index dd507cd471..358214d526 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -28,12 +28,6 @@ static void set_can_do_io(DisasContextBase *db, bool v=
al)
>
>  bool translator_io_start(DisasContextBase *db)
>  {
> -    uint32_t cflags =3D tb_cflags(db->tb);
> -
> -    if (!(cflags & CF_USE_ICOUNT)) {
> -        return false;
> -    }
> -
>      set_can_do_io(db, true);
>
>      /*
> @@ -86,15 +80,15 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint=
32_t cflags)
>          tcg_gen_st16_i32(count, cpu_env,
>                           offsetof(ArchCPU, neg.icount_decr.u16.low) -
>                           offsetof(ArchCPU, env));
> -        /*
> -         * cpu->can_do_io is set automatically here at the beginning of
> -         * each translation block.  The cost is minimal and only paid fo=
r
> -         * -icount, plus it would be very easy to forget doing it in the
> -         * translator.
> -         */
> -        set_can_do_io(db, db->max_insns =3D=3D 1 && (cflags & CF_LAST_IO=
));
>      }
>
> +    /*
> +     * cpu->can_do_io is set automatically here at the beginning of
> +     * each translation block.  The cost is minimal, plus it would be
> +     * very easy to forget doing it in the translator.
> +     */
> +    set_can_do_io(db, db->max_insns =3D=3D 1 && (cflags & CF_LAST_IO));
> +
>      return icount_start_insn;
>  }
>
> diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
> index 9bb40f1849..593fc80458 100644
> --- a/target/mips/tcg/translate.c
> +++ b/target/mips/tcg/translate.c
> @@ -11212,7 +11212,6 @@ static void gen_branch(DisasContext *ctx, int ins=
n_bytes)
>          /* Branches completion */
>          clear_branch_hflags(ctx);
>          ctx->base.is_jmp =3D DISAS_NORETURN;
> -        /* FIXME: Need to clear can_do_io.  */
>          switch (proc_hflags & MIPS_HFLAG_BMASK_BASE) {
>          case MIPS_HFLAG_FBNSLOT:
>              gen_goto_tb(ctx, 0, ctx->base.pc_next + insn_bytes);
> --
> 2.34.1
>
>

