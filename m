Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB1C705BE8
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 02:20:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz4tL-0003s7-Lh; Tue, 16 May 2023 20:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz4tJ-0003rk-OX
 for qemu-devel@nongnu.org; Tue, 16 May 2023 20:19:41 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz4tH-0003cx-QK
 for qemu-devel@nongnu.org; Tue, 16 May 2023 20:19:41 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-452f92680ecso94245e0c.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 17:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684282779; x=1686874779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KVn6pVAD2C0edi5pMtPG+uGKZTBDcF68hA3CrIeX8UU=;
 b=oryuohP3bnj9SiPnrYh8q5MJRWnLZ25mn/vdUT2hlR2DZX1sFKTW96LGj9sJWrxR/I
 R2bOvKFsv0rWZ21NJ3VcpNvR5dMyxHO1Q8XK45zPpSA/mFc8JQhz79C5itB0WlrJiXMf
 UPanVWpi/EeowbDASblfIlHdfYR+9Wn3m/yYI0oYdkYMOcxiWm4C0UKfddmQhDefUOQx
 FMTSDwGmVJyCLr4adkkz2+VbTm6lfjXZ1D6R8hQcjuCBwnK/0bRT+3/6k1kNmTpjQDLd
 X8IM6SgkwBDKl3lG907KtW2OguR8bDjLJ56hHZz2ZioghvQgozT9VBQyHxV/ERRZa9el
 71XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684282779; x=1686874779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KVn6pVAD2C0edi5pMtPG+uGKZTBDcF68hA3CrIeX8UU=;
 b=OFGfFB+UX9g5GFpzBTTnr9GSOGTEQUW1X/+Yvqv5AEaqR+R1K/tuBgV8Owk4pESOYf
 d+XLnbX/J/VlkcRRrLr2/tDgNerTB2sLa3mfEg//cZzMyKUabGNsPi4qA7h5Gr/xDBU6
 qiGANVlmL2ixiqDIgs1thYdECEl8xa+7xaxwtaI1iPA1LsB/1gCD5546eAx++FgUupyi
 9kfDw+F/iQs9PwX39M2Ius+PaEsOXvDrJap9KNfpe7YLSExTf/9SleoB6e+zmyut1+T+
 QdBd48OykNjkVi3nKubmy7ZT2H/IxGzUult9QmX7PMXBVPldQuWLHHc29Fz/7mjduZM7
 wShQ==
X-Gm-Message-State: AC+VfDwFvoowmB+nCdXi3KLajCDC7MNPEYVOQk0RwDNHbtjtLlu/8lgA
 G1v82oifCyPaegooo+vDXOVA26x6Z8XIKDEK9K8=
X-Google-Smtp-Source: ACHHUZ6dqQuKub0o1AJ8Wx1awFiwd71w4uWKWBol4IYZYzQqokQ6Kdhx+jqUZK+FSJjWAZhixcndWv6TCldyEJuDbmI=
X-Received: by 2002:a1f:bd0d:0:b0:43f:ea0c:6ded with SMTP id
 n13-20020a1fbd0d000000b0043fea0c6dedmr14732681vkf.4.1684282778696; Tue, 16
 May 2023 17:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230503085657.1814850-1-richard.henderson@linaro.org>
 <20230503085657.1814850-11-richard.henderson@linaro.org>
In-Reply-To: <20230503085657.1814850-11-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 17 May 2023 10:19:12 +1000
Message-ID: <CAKmqyKPw1MMPzTSxfQWcADUT6AoVJJw1790VmvPOjhHKx66+dQ@mail.gmail.com>
Subject: Re: [PATCH 10/11] tcg/riscv: Implement movcond
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
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
> Implement with and without Zicond.  Without Zicond, we were letting
> the middle-end expand to a 5 insn sequence; better to use a branch
> over a single insn.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tcg/riscv/tcg-target-con-set.h |   1 +
>  tcg/riscv/tcg-target.h         |   4 +-
>  tcg/riscv/tcg-target.c.inc     | 139 ++++++++++++++++++++++++++++++++-
>  3 files changed, 141 insertions(+), 3 deletions(-)
>
> diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-se=
t.h
> index 1a33ece98f..a5cadd303f 100644
> --- a/tcg/riscv/tcg-target-con-set.h
> +++ b/tcg/riscv/tcg-target-con-set.h
> @@ -18,4 +18,5 @@ C_O1_I2(r, r, rI)
>  C_O1_I2(r, r, rJ)
>  C_O1_I2(r, rZ, rN)
>  C_O1_I2(r, rZ, rZ)
> +C_O1_I4(r, r, rI, rM, rM)
>  C_O2_I4(r, r, rZ, rZ, rM, rM)
> diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
> index e0b23006c4..e9e84be9a5 100644
> --- a/tcg/riscv/tcg-target.h
> +++ b/tcg/riscv/tcg-target.h
> @@ -97,7 +97,7 @@ extern bool have_zbb;
>  #endif
>
>  /* optional instructions */
> -#define TCG_TARGET_HAS_movcond_i32      0
> +#define TCG_TARGET_HAS_movcond_i32      1
>  #define TCG_TARGET_HAS_div_i32          1
>  #define TCG_TARGET_HAS_rem_i32          1
>  #define TCG_TARGET_HAS_div2_i32         0
> @@ -132,7 +132,7 @@ extern bool have_zbb;
>  #define TCG_TARGET_HAS_setcond2         1
>  #define TCG_TARGET_HAS_qemu_st8_i32     0
>
> -#define TCG_TARGET_HAS_movcond_i64      0
> +#define TCG_TARGET_HAS_movcond_i64      1
>  #define TCG_TARGET_HAS_div_i64          1
>  #define TCG_TARGET_HAS_rem_i64          1
>  #define TCG_TARGET_HAS_div2_i64         0
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 84b646105c..1c57b64182 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -169,7 +169,7 @@ static bool tcg_target_const_match(int64_t val, TCGTy=
pe type, int ct)
>      }
>      /*
>       * Sign extended from 12 bits, +/- matching: [-0x7ff, 0x7ff].
> -     * Used by addsub2, which may need the negative operation,
> +     * Used by addsub2 and movcond, which may need the negative value,
>       * and requires the modified constant to be representable.
>       */
>      if ((ct & TCG_CT_CONST_M12) && val >=3D -0x7ff && val <=3D 0x7ff) {
> @@ -936,6 +936,133 @@ static void tcg_out_setcond(TCGContext *s, TCGCond =
cond, TCGReg ret,
>      }
>  }
>
> +static void tcg_out_movcond_zicond(TCGContext *s, TCGReg ret, TCGReg tes=
t_ne,
> +                                   int val1, bool c_val1,
> +                                   int val2, bool c_val2)
> +{
> +    if (val1 =3D=3D 0) {
> +        if (c_val2) {
> +            tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_TMP1, val2);
> +            val2 =3D TCG_REG_TMP1;
> +        }
> +        tcg_out_opc_reg(s, OPC_CZERO_NEZ, ret, val2, test_ne);
> +        return;
> +    }
> +
> +    if (val2 =3D=3D 0) {
> +        if (c_val1) {
> +            tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_TMP1, val1);
> +            val1 =3D TCG_REG_TMP1;
> +        }
> +        tcg_out_opc_reg(s, OPC_CZERO_EQZ, ret, val1, test_ne);
> +        return;
> +    }
> +
> +    if (c_val2) {
> +        if (c_val1) {
> +            tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_TMP1, val1 - val2);
> +        } else {
> +            tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP1, val1, -val2);
> +        }
> +        tcg_out_opc_reg(s, OPC_CZERO_EQZ, ret, TCG_REG_TMP1, test_ne);
> +        tcg_out_opc_imm(s, OPC_ADDI, ret, ret, val2);
> +        return;
> +    }
> +
> +    if (c_val1) {
> +        tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP1, val2, -val1);
> +        tcg_out_opc_reg(s, OPC_CZERO_NEZ, ret, TCG_REG_TMP1, test_ne);
> +        tcg_out_opc_imm(s, OPC_ADDI, ret, ret, val1);
> +        return;
> +    }
> +
> +    tcg_out_opc_reg(s, OPC_CZERO_NEZ, TCG_REG_TMP1, val2, test_ne);
> +    tcg_out_opc_reg(s, OPC_CZERO_EQZ, TCG_REG_TMP0, val1, test_ne);
> +    tcg_out_opc_reg(s, OPC_OR, ret, TCG_REG_TMP0, TCG_REG_TMP1);
> +}
> +
> +static void tcg_out_movcond_br1(TCGContext *s, TCGCond cond, TCGReg ret,
> +                                TCGReg cmp1, TCGReg cmp2,
> +                                int val, bool c_val)
> +{
> +    RISCVInsn op;
> +    int disp =3D 8;
> +
> +    tcg_debug_assert((unsigned)cond < ARRAY_SIZE(tcg_brcond_to_riscv));
> +    op =3D tcg_brcond_to_riscv[cond].op;
> +    tcg_debug_assert(op !=3D 0);
> +
> +    if (tcg_brcond_to_riscv[cond].swap) {
> +        tcg_out_opc_branch(s, op, cmp2, cmp1, disp);
> +    } else {
> +        tcg_out_opc_branch(s, op, cmp1, cmp2, disp);
> +    }
> +    if (c_val) {
> +        tcg_out_opc_imm(s, OPC_ADDI, ret, TCG_REG_ZERO, val);
> +    } else {
> +        tcg_out_opc_imm(s, OPC_ADDI, ret, val, 0);
> +    }
> +}
> +
> +static void tcg_out_movcond_br2(TCGContext *s, TCGCond cond, TCGReg ret,
> +                                TCGReg cmp1, TCGReg cmp2,
> +                                int val1, bool c_val1,
> +                                int val2, bool c_val2)
> +{
> +    TCGReg tmp;
> +
> +    /* TCG optimizer reorders to prefer ret matching val2. */
> +    if (!c_val2 && ret =3D=3D val2) {
> +        cond =3D tcg_invert_cond(cond);
> +        tcg_out_movcond_br1(s, cond, ret, cmp1, cmp2, val1, c_val1);
> +        return;
> +    }
> +
> +    if (!c_val1 && ret =3D=3D val1) {
> +        tcg_out_movcond_br1(s, cond, ret, cmp1, cmp2, val2, c_val2);
> +        return;
> +    }
> +
> +    tmp =3D (ret =3D=3D cmp1 || ret =3D=3D cmp2 ? TCG_REG_TMP1 : ret);
> +    if (c_val1) {
> +        tcg_out_movi(s, TCG_TYPE_REG, tmp, val1);
> +    } else {
> +        tcg_out_mov(s, TCG_TYPE_REG, tmp, val1);
> +    }
> +    tcg_out_movcond_br1(s, cond, tmp, cmp1, cmp2, val2, c_val2);
> +    tcg_out_mov(s, TCG_TYPE_REG, ret, tmp);
> +}
> +
> +static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
> +                            TCGReg cmp1, int cmp2, bool c_cmp2,
> +                            TCGReg val1, bool c_val1,
> +                            TCGReg val2, bool c_val2)
> +{
> +    int tmpflags;
> +    TCGReg t;
> +
> +    if (!have_zicond && (!c_cmp2 || cmp2 =3D=3D 0)) {
> +        tcg_out_movcond_br2(s, cond, ret, cmp1, cmp2,
> +                            val1, c_val1, val2, c_val2);
> +        return;
> +    }
> +
> +    tmpflags =3D tcg_out_setcond_int(s, cond, TCG_REG_TMP0, cmp1, cmp2, =
c_cmp2);
> +    t =3D tmpflags & ~SETCOND_FLAGS;
> +
> +    if (have_zicond) {
> +        if (tmpflags & SETCOND_INV) {
> +            tcg_out_movcond_zicond(s, ret, t, val2, c_val2, val1, c_val1=
);
> +        } else {
> +            tcg_out_movcond_zicond(s, ret, t, val1, c_val1, val2, c_val2=
);
> +        }
> +    } else {
> +        cond =3D tmpflags & SETCOND_INV ? TCG_COND_EQ : TCG_COND_NE;
> +        tcg_out_movcond_br2(s, cond, ret, t, TCG_REG_ZERO,
> +                            val1, c_val1, val2, c_val2);
> +    }
> +}
> +
>  static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bo=
ol tail)
>  {
>      TCGReg link =3D tail ? TCG_REG_ZERO : TCG_REG_RA;
> @@ -1624,6 +1751,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode op=
c,
>          tcg_out_setcond(s, args[3], a0, a1, a2, c2);
>          break;
>
> +    case INDEX_op_movcond_i32:
> +    case INDEX_op_movcond_i64:
> +        tcg_out_movcond(s, args[5], a0, a1, a2, c2,
> +                        args[3], const_args[3], args[4], const_args[4]);
> +        break;
> +
>      case INDEX_op_qemu_ld_i32:
>          tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I32);
>          break;
> @@ -1788,6 +1921,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCG=
Opcode op)
>      case INDEX_op_brcond_i64:
>          return C_O0_I2(rZ, rZ);
>
> +    case INDEX_op_movcond_i32:
> +    case INDEX_op_movcond_i64:
> +        return C_O1_I4(r, r, rI, rM, rM);
> +
>      case INDEX_op_add2_i32:
>      case INDEX_op_add2_i64:
>      case INDEX_op_sub2_i32:
> --
> 2.34.1
>
>

