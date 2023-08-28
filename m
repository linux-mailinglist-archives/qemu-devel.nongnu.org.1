Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A2578A511
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 07:03:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaUNg-0004hH-Li; Mon, 28 Aug 2023 01:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qaUN4-0004cl-Bh
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 01:01:04 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qaUMx-0002dp-CT
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 01:01:01 -0400
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-44d4d997dcfso1069080137.0
 for <qemu-devel@nongnu.org>; Sun, 27 Aug 2023 22:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693198845; x=1693803645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bb6t0YnqA6ZhKchh0ZWBaD60+JVBPa1aTyKn+jAvaLQ=;
 b=OzpUPYbUUOUtI0vyF/n7fPF9QmwRFu5w05K13/tYEpFbmBWoAHd/QF8h9zhO9LSO8a
 bCrlT0e9Ov2gqYWookIcNb4zoje1OufyvaDtf2j4vIwoy/Hqgob85dN9fT3CfStMmrRZ
 PPQm+2Y8mWRXOXKdXATXYoeevjfYH3BgCAZYagk7NsB4E3ZvpfNGI+AgnJ9YIPUnl3u3
 nS9sGOimprZ+oXhjEGgxcF/CrQ1TkFI//s3BRbbv8L2i+zGDRbyUdynG8G8t0uYhhuNe
 eooCOe8Bff18oNOk6bCmTdu00wiOoreS6dxgxLom8CujI0VowHXHfkby7Doa2gQjfFAL
 pxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693198845; x=1693803645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bb6t0YnqA6ZhKchh0ZWBaD60+JVBPa1aTyKn+jAvaLQ=;
 b=lITYcCDZGPrsIwSwBW3HfagQl+Lp2MUiQ6kK26Pexk2M1f5oONvFebd3NlyxzrKfTq
 8fWiOpVi3tqwMYjY1kbM9skUY7iJalGcChBCgoXbW6FI/a4xSpo7bPS5IOAj8gqIA5yh
 Bl1kzmMowBkz2D94I+cQNQjBFJSb8b1JySsZ18B3h6hiNlUeOeYgW0/d+PLdhfqT2KBv
 TjV5MRew6jr6OfqNb3K4dTXRcyeS1J3mDa21OdIky71/Psx6vAowX3htFoBt4kqy9kWR
 uhbITUjFyz9PUN+/2Tmuc9zBUiJyy4zTAg/Yz1Qy5IllNg2QfwzsxX6q5SVYDPMi67Fo
 jwCg==
X-Gm-Message-State: AOJu0YxWMGc9EgsBMKGzHJCHdPLpMH5axJqcyMp6wBwVv78otVW91tc7
 Gfn4U5Id1/CXZq0ct02nWF1dBYZsgdwTRoZvbUE8sGnW7ygHNA==
X-Google-Smtp-Source: AGHT+IF8ag9GPVVTU4mTreGyM1CUqvUGZfGlyNNmmyEnNHV2SRtzHaN7Mkms1sOLkcvpitsKDa5fPErD6govqO9aw00=
X-Received: by 2002:a05:6102:497:b0:44d:634c:1125 with SMTP id
 n23-20020a056102049700b0044d634c1125mr14001950vsa.13.1693198844991; Sun, 27
 Aug 2023 22:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1691405748.git.mjt@tls.msk.ru>
 <20230823055155.1917375-11-mjt@tls.msk.ru>
In-Reply-To: <20230823055155.1917375-11-mjt@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 28 Aug 2023 15:00:18 +1000
Message-ID: <CAKmqyKPd_FkdPy84GWWOOSMdrk3c-Fawe7y=+ccw4hwbZuydVA@mail.gmail.com>
Subject: Re: [PATCH 10/24] riscv: spelling fixes
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe29.google.com
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

On Wed, Aug 23, 2023 at 3:54=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/microchip_pfsoc.c                |  2 +-
>  hw/riscv/virt.c                           |  4 ++--
>  include/hw/riscv/riscv_hart.h             |  2 +-
>  target/riscv/cpu.h                        |  2 +-
>  target/riscv/cpu_bits.h                   |  4 ++--
>  target/riscv/csr.c                        |  4 ++--
>  target/riscv/debug.c                      | 10 +++++-----
>  target/riscv/insn_trans/trans_rvf.c.inc   |  4 ++--
>  target/riscv/insn_trans/trans_rvv.c.inc   |  4 ++--
>  target/riscv/insn_trans/trans_rvzfh.c.inc |  4 ++--
>  target/riscv/monitor.c                    |  2 +-
>  11 files changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index e81bbd12df..b775aa8946 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -660,5 +660,5 @@ static void microchip_icicle_kit_machine_class_init(O=
bjectClass *oc, void *data)
>
>      /*
> -     * Map 513 MiB high memory, the mimimum required high memory size, b=
ecause
> +     * Map 513 MiB high memory, the minimum required high memory size, b=
ecause
>       * HSS will do memory test against the high memory address range reg=
ardless
>       * of physical memory installed.
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 99c4e6314b..a5ac3ab777 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -67,5 +67,5 @@
>  #if VIRT_IMSIC_GROUP_MAX_SIZE < \
>      IMSIC_GROUP_SIZE(VIRT_CPUS_MAX_BITS, VIRT_IRQCHIP_MAX_GUESTS_BITS)
> -#error "Can't accomodate single IMSIC group in address space"
> +#error "Can't accommodate single IMSIC group in address space"
>  #endif
>
> @@ -73,5 +73,5 @@
>                                          VIRT_IMSIC_GROUP_MAX_SIZE)
>  #if 0x4000000 < VIRT_IMSIC_MAX_SIZE
> -#error "Can't accomodate all IMSIC groups in address space"
> +#error "Can't accommodate all IMSIC groups in address space"
>  #endif
>
> diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.=
h
> index bbc21cdc9a..912b4a2682 100644
> --- a/include/hw/riscv/riscv_hart.h
> +++ b/include/hw/riscv/riscv_hart.h
> @@ -4,5 +4,5 @@
>   * Copyright (c) 2017 SiFive, Inc.
>   *
> - * Holds the state of a heterogenous array of RISC-V harts
> + * Holds the state of a heterogeneous array of RISC-V harts
>   *
>   * This program is free software; you can redistribute it and/or modify =
it
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 6ea22e0eea..6316cbcc23 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -350,5 +350,5 @@ struct CPUArchState {
>      target_ulong upmbase;
>
> -    /* CSRs for execution enviornment configuration */
> +    /* CSRs for execution environment configuration */
>      uint64_t menvcfg;
>      uint64_t mstateen[SMSTATEEN_MAX_COUNT];
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 59f0ffd9e1..31a8d80990 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -657,5 +657,5 @@ typedef enum {
>  #define PGSHIFT             12
>
> -/* Default Reset Vector adress */
> +/* Default Reset Vector address */
>  #define DEFAULT_RSTVEC      0x1000
>
> @@ -741,5 +741,5 @@ typedef enum RISCVException {
>  #define PM_INSN         0x00000004ULL
>
> -/* Execution enviornment configuration bits */
> +/* Execution environment configuration bits */
>  #define MENVCFG_FIOM                       BIT(0)
>  #define MENVCFG_CBIE                       (3UL << 4)
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index ea7585329e..26bc1f0ff1 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3217,5 +3217,5 @@ static int write_hvipriox(CPURISCVState *env, int f=
irst_index,
>      }
>
> -    /* Fill-up priority arrary */
> +    /* Fill-up priority array */
>      for (i =3D 0; i < num_irqs; i++) {
>          if (riscv_cpu_hviprio_index2irq(first_index + i, &irq, &rdzero))=
 {
> @@ -3886,5 +3886,5 @@ static inline RISCVException riscv_csrrw_check(CPUR=
ISCVState *env,
>          !env->virt_enabled) {
>          /*
> -         * We are in HS mode. Add 1 to the effective privledge level to
> +         * We are in HS mode. Add 1 to the effective privilege level to
>           * allow us to access the Hypervisor CSRs.
>           */
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 75ee1c4971..211f5921b6 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -575,5 +575,5 @@ static void riscv_itrigger_update_count(CPURISCVState=
 *env)
>      /*
>       * Record last icount, so that we can evaluate the executed instruct=
ions
> -     * since last priviledge mode change or timer expire.
> +     * since last privilege mode change or timer expire.
>       */
>      int64_t last_icount =3D env->last_icount, current_icount;
> @@ -589,5 +589,5 @@ static void riscv_itrigger_update_count(CPURISCVState=
 *env)
>          }
>          /*
> -         * Only when priviledge is changed or itrigger timer expires,
> +         * Only when privilege is changed or itrigger timer expires,
>           * the count field in itrigger tdata1 register is updated.
>           * And the count field in itrigger only contains remaining value=
.
> @@ -595,6 +595,6 @@ static void riscv_itrigger_update_count(CPURISCVState=
 *env)
>          if (check_itrigger_priv(env, i)) {
>              /*
> -             * If itrigger enabled in this priviledge mode, the number o=
f
> -             * executed instructions since last priviledge change
> +             * If itrigger enabled in this privilege mode, the number of
> +             * executed instructions since last privilege change
>               * should be reduced from current itrigger count.
>               */
> @@ -606,5 +606,5 @@ static void riscv_itrigger_update_count(CPURISCVState=
 *env)
>          } else {
>              /*
> -             * If itrigger is not enabled in this priviledge mode,
> +             * If itrigger is not enabled in this privilege mode,
>               * the number of executed instructions will be discard and
>               * the count field in itrigger will not change.
> diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_=
trans/trans_rvf.c.inc
> index a0da7391c7..e7ab84cd9a 100644
> --- a/target/riscv/insn_trans/trans_rvf.c.inc
> +++ b/target/riscv/insn_trans/trans_rvf.c.inc
> @@ -301,5 +301,5 @@ static bool trans_fsgnjn_s(DisasContext *ctx, arg_fsg=
njn_s *a)
>          tcg_gen_or_i64(dest, dest, rs2);
>      }
> -    /* signed-extended intead of nanboxing for result if enable zfinx */
> +    /* signed-extended instead of nanboxing for result if enable zfinx *=
/
>      if (ctx->cfg_ptr->ext_zfinx) {
>          tcg_gen_ext32s_i64(dest, dest);
> @@ -346,5 +346,5 @@ static bool trans_fsgnjx_s(DisasContext *ctx, arg_fsg=
njx_s *a)
>          tcg_gen_xor_i64(dest, rs1, dest);
>      }
> -    /* signed-extended intead of nanboxing for result if enable zfinx */
> +    /* signed-extended instead of nanboxing for result if enable zfinx *=
/
>      if (ctx->cfg_ptr->ext_zfinx) {
>          tcg_gen_ext32s_i64(dest, dest);
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index c2f7527f53..6ab63f4442 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -2241,5 +2241,5 @@ GEN_OPIWI_NARROW_TRANS(vnclip_wi, IMM_ZX, vnclip_wx=
)
>   * If SEW < FLEN, check whether input fp register is a valid
>   * NaN-boxed value, in which case the least-significant SEW bits
> - * of the f regsiter are used, else the canonical NaN value is used.
> + * of the f register are used, else the canonical NaN value is used.
>   */
>  static void do_nanbox(DisasContext *s, TCGv_i64 out, TCGv_i64 in)
> @@ -3283,5 +3283,5 @@ static void load_element(TCGv_i64 dest, TCGv_ptr ba=
se,
>  }
>
> -/* offset of the idx element with base regsiter r */
> +/* offset of the idx element with base register r */
>  static uint32_t endian_ofs(DisasContext *s, int r, int idx)
>  {
> diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/ins=
n_trans/trans_rvzfh.c.inc
> index 8b1e2519bb..4b01812fd8 100644
> --- a/target/riscv/insn_trans/trans_rvzfh.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
> @@ -306,5 +306,5 @@ static bool trans_fsgnjn_h(DisasContext *ctx, arg_fsg=
njn_h *a)
>          tcg_gen_or_i64(dest, dest, rs2);
>      }
> -    /* signed-extended intead of nanboxing for result if enable zfinx */
> +    /* signed-extended instead of nanboxing for result if enable zfinx *=
/
>      if (ctx->cfg_ptr->ext_zfinx) {
>          tcg_gen_ext16s_i64(dest, dest);
> @@ -350,5 +350,5 @@ static bool trans_fsgnjx_h(DisasContext *ctx, arg_fsg=
njx_h *a)
>          tcg_gen_xor_i64(dest, rs1, dest);
>      }
> -    /* signed-extended intead of nanboxing for result if enable zfinx */
> +    /* signed-extended instead of nanboxing for result if enable zfinx *=
/
>      if (ctx->cfg_ptr->ext_zfinx) {
>          tcg_gen_ext16s_i64(dest, dest);
> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> index f36ddfa967..f5b1ffe6c3 100644
> --- a/target/riscv/monitor.c
> +++ b/target/riscv/monitor.c
> @@ -56,5 +56,5 @@ static void print_pte(Monitor *mon, int va_bits, target=
_ulong vaddr,
>                        hwaddr paddr, target_ulong size, int attr)
>  {
> -    /* santity check on vaddr */
> +    /* sanity check on vaddr */
>      if (vaddr >=3D (1UL << va_bits)) {
>          return;
> --
> 2.39.2
>
>

