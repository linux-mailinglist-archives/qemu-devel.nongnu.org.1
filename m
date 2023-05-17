Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEBE705BE0
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 02:18:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz4qM-0002Lf-EV; Tue, 16 May 2023 20:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz4qK-0002LW-Iq
 for qemu-devel@nongnu.org; Tue, 16 May 2023 20:16:36 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz4qI-00034V-QF
 for qemu-devel@nongnu.org; Tue, 16 May 2023 20:16:36 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-435f36ad948so17442137.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 17:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684282593; x=1686874593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OooVG41b5BhoBPAp1ZG02e9jInYlDujfsyzsgkRedUQ=;
 b=H7MEX5L4/difwtJf2fiizvH6SdeeS1l7PTK/4+t2PuSQBhu/7t84a0jNGJYm9dtWL1
 gYQsqeCYSsD96/IKEMfF6HqKb+VbmPxZBeP8l6jUxPHHCsy7Pgsv/QLF2rq3luJlHjlL
 GI092GK26c0rUUX7Z7f4s7o93Q8wdYPAK5trIgivBTNiG90wWjBjcYUW0inZTAjvHeU4
 IM9yYiWWr/URgnGsQoK7oeq6m02r3d9upww61nNS7dpXLWuOzxgkw5yWyF+E04YOgznO
 E1/zW+mb0eG3MaQ+zp2sZUZWpr2P1gUfnUneu+lVqOEWVXyMebt960Kt5RrCEKlvnlWb
 D2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684282593; x=1686874593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OooVG41b5BhoBPAp1ZG02e9jInYlDujfsyzsgkRedUQ=;
 b=HYZ8+L8WwLWaZsHhZV62XBWs0Kg0F2Umk9bgIONJxFLAVY+RAMRxcMFzXt12u6d6fW
 gZHE1kFDj0IcJmnP30f6q1S/Kkxjw45xoPSEm//2KvQe4hBsfHhNPQ4RE1/61aflh91N
 hWmnNlG2DUCNCPMYv6Z6dc5Aa0119cEcVNDmBr/OK/2Vn0lUSMlWSMrW1uEELDM2oiZs
 H3aetfUV9B2r31MIrScYwWYMDEEbjbiTmi5ByTPCYLNWKSqlhvyGuY3lMZ+iKTGTh31j
 zSEqHIbqFKsGF2NO2DWwdhxt/EaDMddt5unJ2KKC42XN/sqppMut327QpkojEdPuqzC4
 /BTw==
X-Gm-Message-State: AC+VfDykZ7zZ48vESTe+x8CLJIH9+Ep5l6zXUrclToI2C8mdhg3Utn76
 HOIGEvFhHtWhDm8nUxzSaYJQ9MDI7vqgfhg63hc=
X-Google-Smtp-Source: ACHHUZ7yEcrqAOy5VnezsVyv1jhE8kVcTS6vS0KnKL9FXwYpdLPULE1hLDkRznU9Ppl0veClyR47gtP6k/rtE0h3qBU=
X-Received: by 2002:a67:fc47:0:b0:436:c33:a96e with SMTP id
 p7-20020a67fc47000000b004360c33a96emr12824844vsq.24.1684282593447; Tue, 16
 May 2023 17:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230503085657.1814850-1-richard.henderson@linaro.org>
 <20230503085657.1814850-10-richard.henderson@linaro.org>
In-Reply-To: <20230503085657.1814850-10-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 17 May 2023 10:16:07 +1000
Message-ID: <CAKmqyKOcBg_tSdfMu7eoMy6i2GOifq7ZuH1e_P5G+WHUDq1xBw@mail.gmail.com>
Subject: Re: [PATCH 09/11] tcg/riscv: Improve setcond expansion
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe31.google.com
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

On Wed, May 3, 2023 at 6:59=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Split out a helper function, tcg_out_setcond_int, which does not
> always produce the complete boolean result, but returns a set of
> flags to do so.
>
> Based on 21af16198425, the same improvement for loongarch64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tcg/riscv/tcg-target.c.inc | 164 +++++++++++++++++++++++++++----------
>  1 file changed, 121 insertions(+), 43 deletions(-)
>
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 044ddfb160..84b646105c 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -812,50 +812,128 @@ static void tcg_out_brcond(TCGContext *s, TCGCond =
cond, TCGReg arg1,
>      tcg_out_opc_branch(s, op, arg1, arg2, 0);
>  }
>
> -static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
> -                            TCGReg arg1, TCGReg arg2)
> +#define SETCOND_INV    TCG_TARGET_NB_REGS
> +#define SETCOND_NEZ    (SETCOND_INV << 1)
> +#define SETCOND_FLAGS  (SETCOND_INV | SETCOND_NEZ)
> +
> +static int tcg_out_setcond_int(TCGContext *s, TCGCond cond, TCGReg ret,
> +                               TCGReg arg1, tcg_target_long arg2, bool c=
2)
>  {
> +    int flags =3D 0;
> +
>      switch (cond) {
> -    case TCG_COND_EQ:
> -        tcg_out_opc_reg(s, OPC_SUB, ret, arg1, arg2);
> -        tcg_out_opc_imm(s, OPC_SLTIU, ret, ret, 1);
> -        break;
> -    case TCG_COND_NE:
> -        tcg_out_opc_reg(s, OPC_SUB, ret, arg1, arg2);
> -        tcg_out_opc_reg(s, OPC_SLTU, ret, TCG_REG_ZERO, ret);
> -        break;
> -    case TCG_COND_LT:
> -        tcg_out_opc_reg(s, OPC_SLT, ret, arg1, arg2);
> -        break;
> -    case TCG_COND_GE:
> -        tcg_out_opc_reg(s, OPC_SLT, ret, arg1, arg2);
> -        tcg_out_opc_imm(s, OPC_XORI, ret, ret, 1);
> -        break;
> -    case TCG_COND_LE:
> -        tcg_out_opc_reg(s, OPC_SLT, ret, arg2, arg1);
> -        tcg_out_opc_imm(s, OPC_XORI, ret, ret, 1);
> -        break;
> -    case TCG_COND_GT:
> -        tcg_out_opc_reg(s, OPC_SLT, ret, arg2, arg1);
> -        break;
> -    case TCG_COND_LTU:
> -        tcg_out_opc_reg(s, OPC_SLTU, ret, arg1, arg2);
> -        break;
> -    case TCG_COND_GEU:
> -        tcg_out_opc_reg(s, OPC_SLTU, ret, arg1, arg2);
> -        tcg_out_opc_imm(s, OPC_XORI, ret, ret, 1);
> -        break;
> -    case TCG_COND_LEU:
> -        tcg_out_opc_reg(s, OPC_SLTU, ret, arg2, arg1);
> -        tcg_out_opc_imm(s, OPC_XORI, ret, ret, 1);
> -        break;
> -    case TCG_COND_GTU:
> -        tcg_out_opc_reg(s, OPC_SLTU, ret, arg2, arg1);
> +    case TCG_COND_EQ:    /* -> NE  */
> +    case TCG_COND_GE:    /* -> LT  */
> +    case TCG_COND_GEU:   /* -> LTU */
> +    case TCG_COND_GT:    /* -> LE  */
> +    case TCG_COND_GTU:   /* -> LEU */
> +        cond =3D tcg_invert_cond(cond);
> +        flags ^=3D SETCOND_INV;
>          break;
>      default:
> -         g_assert_not_reached();
> -         break;
> -     }
> +        break;
> +    }
> +
> +    switch (cond) {
> +    case TCG_COND_LE:
> +    case TCG_COND_LEU:
> +        /*
> +         * If we have a constant input, the most efficient way to implem=
ent
> +         * LE is by adding 1 and using LT.  Watch out for wrap around fo=
r LEU.
> +         * We don't need to care for this for LE because the constant in=
put
> +         * is constrained to signed 12-bit, and 0x800 is representable i=
n the
> +         * temporary register.
> +         */
> +        if (c2) {
> +            if (cond =3D=3D TCG_COND_LEU) {
> +                /* unsigned <=3D -1 is true */
> +                if (arg2 =3D=3D -1) {
> +                    tcg_out_movi(s, TCG_TYPE_REG, ret, !(flags & SETCOND=
_INV));
> +                    return ret;
> +                }
> +                cond =3D TCG_COND_LTU;
> +            } else {
> +                cond =3D TCG_COND_LT;
> +            }
> +            tcg_debug_assert(arg2 <=3D 0x7ff);
> +            if (++arg2 =3D=3D 0x800) {
> +                tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_TMP0, arg2);
> +                arg2 =3D TCG_REG_TMP0;
> +                c2 =3D false;
> +            }
> +        } else {
> +            TCGReg tmp =3D arg2;
> +            arg2 =3D arg1;
> +            arg1 =3D tmp;
> +            cond =3D tcg_swap_cond(cond);    /* LE -> GE */
> +            cond =3D tcg_invert_cond(cond);  /* GE -> LT */
> +            flags ^=3D SETCOND_INV;
> +        }
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    switch (cond) {
> +    case TCG_COND_NE:
> +        flags |=3D SETCOND_NEZ;
> +        if (!c2) {
> +            tcg_out_opc_reg(s, OPC_XOR, ret, arg1, arg2);
> +        } else if (arg2 =3D=3D 0) {
> +            ret =3D arg1;
> +        } else {
> +            tcg_out_opc_reg(s, OPC_XORI, ret, arg1, arg2);
> +        }
> +        break;
> +
> +    case TCG_COND_LT:
> +        if (c2) {
> +            tcg_out_opc_imm(s, OPC_SLTI, ret, arg1, arg2);
> +        } else {
> +            tcg_out_opc_reg(s, OPC_SLT, ret, arg1, arg2);
> +        }
> +        break;
> +
> +    case TCG_COND_LTU:
> +        if (c2) {
> +            tcg_out_opc_imm(s, OPC_SLTIU, ret, arg1, arg2);
> +        } else {
> +            tcg_out_opc_reg(s, OPC_SLTU, ret, arg1, arg2);
> +        }
> +        break;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    return ret | flags;
> +}
> +
> +static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
> +                            TCGReg arg1, tcg_target_long arg2, bool c2)
> +{
> +    int tmpflags =3D tcg_out_setcond_int(s, cond, ret, arg1, arg2, c2);
> +
> +    if (tmpflags !=3D ret) {
> +        TCGReg tmp =3D tmpflags & ~SETCOND_FLAGS;
> +
> +        switch (tmpflags & SETCOND_FLAGS) {
> +        case SETCOND_INV:
> +            /* Intermediate result is boolean: simply invert. */
> +            tcg_out_opc_imm(s, OPC_XORI, ret, tmp, 1);
> +            break;
> +        case SETCOND_NEZ:
> +            /* Intermediate result is zero/non-zero: test !=3D 0. */
> +            tcg_out_opc_reg(s, OPC_SLTU, ret, TCG_REG_ZERO, tmp);
> +            break;
> +        case SETCOND_NEZ | SETCOND_INV:
> +            /* Intermediate result is zero/non-zero: test =3D=3D 0. */
> +            tcg_out_opc_imm(s, OPC_SLTIU, ret, tmp, 1);
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +    }
>  }
>
>  static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bo=
ol tail)
> @@ -1543,7 +1621,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc=
,
>
>      case INDEX_op_setcond_i32:
>      case INDEX_op_setcond_i64:
> -        tcg_out_setcond(s, args[3], a0, a1, a2);
> +        tcg_out_setcond(s, args[3], a0, a1, a2, c2);
>          break;
>
>      case INDEX_op_qemu_ld_i32:
> @@ -1662,6 +1740,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGO=
pcode op)
>      case INDEX_op_and_i64:
>      case INDEX_op_or_i64:
>      case INDEX_op_xor_i64:
> +    case INDEX_op_setcond_i32:
> +    case INDEX_op_setcond_i64:
>          return C_O1_I2(r, r, rI);
>
>      case INDEX_op_andc_i32:
> @@ -1683,7 +1763,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGO=
pcode op)
>      case INDEX_op_divu_i32:
>      case INDEX_op_rem_i32:
>      case INDEX_op_remu_i32:
> -    case INDEX_op_setcond_i32:
>      case INDEX_op_mul_i64:
>      case INDEX_op_mulsh_i64:
>      case INDEX_op_muluh_i64:
> @@ -1691,7 +1770,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGO=
pcode op)
>      case INDEX_op_divu_i64:
>      case INDEX_op_rem_i64:
>      case INDEX_op_remu_i64:
> -    case INDEX_op_setcond_i64:
>          return C_O1_I2(r, rZ, rZ);
>
>      case INDEX_op_shl_i32:
> --
> 2.34.1
>
>

