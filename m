Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CD1705CA1
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 03:49:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz6H2-0007ft-VP; Tue, 16 May 2023 21:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz6Gy-0007fi-DK
 for qemu-devel@nongnu.org; Tue, 16 May 2023 21:48:12 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz6Gw-0001zo-RR
 for qemu-devel@nongnu.org; Tue, 16 May 2023 21:48:12 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-76d846a4b85so110865241.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 18:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684288089; x=1686880089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5zmhLBCkfn5WSA84aqCrJoE9OqK1vqICkCWRt5QOUkA=;
 b=RCHZFLhP+uiNxdB8jmf41EzSI1S5Zfy926Kgj2OYEOSsGfrYwddYgVgBV4rq/rhDQn
 G1+fE27llBHmFa5jR/JeyRep1DB2I3W1kpT5VenQMjbbGKcVP3RTINQFrCOeEId93RqZ
 sU7F3dwZCa3bUBkncs8Spfn/nTrFrAUfG4JlgA50AZhVLc1wSgyvuC3jDXG5u7iPw67L
 eECdmjsUlHWoyUDczpMrSF9PVOt1rv7NqkP0vE4s77vjRcmkAlQF8eCkJCfEaV+P+HTP
 7Znnw4cY5oJZA0ZKJwjAnRZbsHIexxtE+MEyLC4VoZrrqTTv/FEIdSAOv/WHUYmkRLjk
 J0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684288089; x=1686880089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5zmhLBCkfn5WSA84aqCrJoE9OqK1vqICkCWRt5QOUkA=;
 b=UgaK/9ST4bhiqHL2WKCkk/23ZqW1F0eAjcPfa36gE/lElXHtv8WhExS+pYjGIC03wy
 Hxj93Q2ugu0dLJIo8jse4LJ4vuAb/pqXr8MXyJIRkdNpDWcyBK6amXdUEeklZu6Kik4H
 h4zeoZs6ww6V+Xaqve7sU5R1AlLtGyN0eYtp0DTuxqn9dYL6y/W+KdOTrwEMG1urXUUE
 KBrE6Ic6+/fXOItypS1tYLhfUQgUaspacAYgUvIaj+uYBVHHmChG5T1DA7utDLjqda8l
 z/MhDB9g7420YLfLNCe3cxaeEaeDehh6Wy5Q50+N+iyEXEvcsVICi2LW+YPiWbJguTau
 CiCw==
X-Gm-Message-State: AC+VfDwCWhwQ6hz4TvSdZv0pepUSyO+nN/RoxfdihPS91wnwz6yP0oXi
 pnFFQ7oGXvTHfZux+Zfs38LgSUe6owFNgX/go2M=
X-Google-Smtp-Source: ACHHUZ5YOxLTv2TGwjTTfsBg4hIC7Vqbu5U1UrNamLeYmeOJYKaVA8ae0nzmTZ+6byj13ZENRlVu5WAth9sgloesTOg=
X-Received: by 2002:a67:fd8b:0:b0:42e:6689:d762 with SMTP id
 k11-20020a67fd8b000000b0042e6689d762mr14993338vsq.8.1684288088964; Tue, 16
 May 2023 18:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230503085657.1814850-1-richard.henderson@linaro.org>
 <20230503085657.1814850-12-richard.henderson@linaro.org>
In-Reply-To: <20230503085657.1814850-12-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 17 May 2023 11:47:42 +1000
Message-ID: <CAKmqyKMRa6ygcWTWG_J_=cKmUDG5n8VuL-caVuNk8ud+C6+pcA@mail.gmail.com>
Subject: Re: [PATCH 11/11] tcg/riscv: Support CTZ, CLZ from Zbb
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Wed, May 3, 2023 at 6:57=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tcg/riscv/tcg-target-con-set.h |  1 +
>  tcg/riscv/tcg-target.h         |  8 ++++----
>  tcg/riscv/tcg-target.c.inc     | 35 ++++++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-se=
t.h
> index a5cadd303f..aac5ceee2b 100644
> --- a/tcg/riscv/tcg-target-con-set.h
> +++ b/tcg/riscv/tcg-target-con-set.h
> @@ -18,5 +18,6 @@ C_O1_I2(r, r, rI)
>  C_O1_I2(r, r, rJ)
>  C_O1_I2(r, rZ, rN)
>  C_O1_I2(r, rZ, rZ)
> +C_N1_I2(r, r, rM)
>  C_O1_I4(r, r, rI, rM, rM)
>  C_O2_I4(r, r, rZ, rZ, rM, rM)
> diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
> index e9e84be9a5..cff5de5c9e 100644
> --- a/tcg/riscv/tcg-target.h
> +++ b/tcg/riscv/tcg-target.h
> @@ -125,8 +125,8 @@ extern bool have_zbb;
>  #define TCG_TARGET_HAS_eqv_i32          have_zbb
>  #define TCG_TARGET_HAS_nand_i32         0
>  #define TCG_TARGET_HAS_nor_i32          0
> -#define TCG_TARGET_HAS_clz_i32          0
> -#define TCG_TARGET_HAS_ctz_i32          0
> +#define TCG_TARGET_HAS_clz_i32          1
> +#define TCG_TARGET_HAS_ctz_i32          1
>  #define TCG_TARGET_HAS_ctpop_i32        have_zbb
>  #define TCG_TARGET_HAS_brcond2          1
>  #define TCG_TARGET_HAS_setcond2         1
> @@ -159,8 +159,8 @@ extern bool have_zbb;
>  #define TCG_TARGET_HAS_eqv_i64          have_zbb
>  #define TCG_TARGET_HAS_nand_i64         0
>  #define TCG_TARGET_HAS_nor_i64          0
> -#define TCG_TARGET_HAS_clz_i64          0
> -#define TCG_TARGET_HAS_ctz_i64          0
> +#define TCG_TARGET_HAS_clz_i64          1
> +#define TCG_TARGET_HAS_ctz_i64          1
>  #define TCG_TARGET_HAS_ctpop_i64        have_zbb
>  #define TCG_TARGET_HAS_add2_i64         1
>  #define TCG_TARGET_HAS_sub2_i64         1
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 1c57b64182..a1c92b0603 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -1063,6 +1063,22 @@ static void tcg_out_movcond(TCGContext *s, TCGCond=
 cond, TCGReg ret,
>      }
>  }
>
> +static void tcg_out_cltz(TCGContext *s, TCGType type, RISCVInsn insn,
> +                         TCGReg ret, TCGReg src1, int src2, bool c_src2)
> +{
> +    tcg_out_opc_imm(s, insn, ret, src1, 0);
> +
> +    if (!c_src2 || src2 !=3D (type =3D=3D TCG_TYPE_I32 ? 32 : 64)) {
> +        /*
> +         * The requested zero result does not match the insn, so adjust.
> +         * Note that constraints put 'ret' in a new register, so the
> +         * computation above did not clobber either 'src1' or 'src2'.
> +         */
> +        tcg_out_movcond(s, TCG_COND_EQ, ret, src1, 0, true,
> +                        src2, c_src2, ret, false);
> +    }
> +}
> +
>  static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bo=
ol tail)
>  {
>      TCGReg link =3D tail ? TCG_REG_ZERO : TCG_REG_RA;
> @@ -1724,6 +1740,19 @@ static void tcg_out_op(TCGContext *s, TCGOpcode op=
c,
>          tcg_out_opc_imm(s, OPC_CPOP, a0, a1, 0);
>          break;
>
> +    case INDEX_op_clz_i32:
> +        tcg_out_cltz(s, TCG_TYPE_I32, OPC_CLZW, a0, a1, a2, c2);
> +        break;
> +    case INDEX_op_clz_i64:
> +        tcg_out_cltz(s, TCG_TYPE_I64, OPC_CLZ, a0, a1, a2, c2);
> +        break;
> +    case INDEX_op_ctz_i32:
> +        tcg_out_cltz(s, TCG_TYPE_I32, OPC_CTZW, a0, a1, a2, c2);
> +        break;
> +    case INDEX_op_ctz_i64:
> +        tcg_out_cltz(s, TCG_TYPE_I64, OPC_CTZ, a0, a1, a2, c2);
> +        break;
> +
>      case INDEX_op_add2_i32:
>          tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
>                          const_args[4], const_args[5], false, true);
> @@ -1917,6 +1946,12 @@ static TCGConstraintSetIndex tcg_target_op_def(TCG=
Opcode op)
>      case INDEX_op_rotr_i64:
>          return C_O1_I2(r, r, ri);
>
> +    case INDEX_op_clz_i32:
> +    case INDEX_op_clz_i64:
> +    case INDEX_op_ctz_i32:
> +    case INDEX_op_ctz_i64:
> +        return C_N1_I2(r, r, rM);
> +
>      case INDEX_op_brcond_i32:
>      case INDEX_op_brcond_i64:
>          return C_O0_I2(rZ, rZ);
> --
> 2.34.1
>
>

