Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4763C705B6B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 01:39:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz4G7-0001Sm-Cc; Tue, 16 May 2023 19:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz4G5-0001Sb-PE
 for qemu-devel@nongnu.org; Tue, 16 May 2023 19:39:09 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz4G4-0005AL-4c
 for qemu-devel@nongnu.org; Tue, 16 May 2023 19:39:09 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4501ca552a3so157669e0c.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 16:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684280347; x=1686872347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8miSbTEUsIgG9EvepNdiz8BW7HD//1+VUOXJvHxwGHo=;
 b=qXrjhHzULNPPo8Pk7UyOUgr9AX7tglhjESnIlJsegDuiSP22JHTLeIp4Pjq4IllG18
 zLUj4MUB/rZfVteYRUEgc6ROk8ExZL9iLfNwxMSAF4qtyb7XFvIw5IqED/VOenQLCLeF
 f0HgeTY/wkzauc0S4gpF35lkZC6xxL5CLN1rerqT1gNNZ2Tuud2W6XFyNqyQyDVpFuT8
 GFrWqFaCwJNPvwVSq8J63c4A/B6AQA5rBVEjy2yBJXgszjZcLEAC3A8kjdYrSBPRahM6
 ri7S+b/OIXVlaVc2Ivtj/KjYgaK8Yh85Jtk8XRYVsStHqhyBI8h4OzvH5eFqg6z66jkj
 CWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684280347; x=1686872347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8miSbTEUsIgG9EvepNdiz8BW7HD//1+VUOXJvHxwGHo=;
 b=YHnOE26bRfxiAYov9n2Suq2v/+jyVEIArOprprH1KNGAERfiV+SZQD31GDB2q4XBc7
 jBLDDhRdCEHM7x4y2NiGNxmPBJHHcJhstVWcY0KKcEZd9KFILi78uYXObXT+wu/bFkET
 ot0rLDPWtb4wwd0l7AmuBJFTuHL0JjPL5od8y44N8z6lJNT8cy7pLvv+nT2DFGaWECvn
 n8or61Lde4SF88mf6G5TuwTmxfuP/2nMUNQVSkk2SuLv4WUdF8K13c43Mct8tyFzKOFS
 Z96S6vryBLHoSxEPrBfLY2iu7BKn07oOGGV+7xV0jey1V9oPFjClVjzJtqjQr4RLb0QX
 ygOw==
X-Gm-Message-State: AC+VfDxIf/TwXusZ6XbHuKRXu06zjZ4AOw6VBCYkNANX4KIP3O837mwG
 7W9BuEIV9I/pKLtDFNC0fW80FrkTKahkMvzQazEosndgzp4=
X-Google-Smtp-Source: ACHHUZ7jYPZ5JQ6vtWpW2GoLdoJ6k6Os1KM20hM2c/1upooiFgKgCwY6Vi9y6Pv2LY/oBoXsH2EojOJa9amrpZwhG6Y=
X-Received: by 2002:a1f:5e0f:0:b0:450:81af:7e59 with SMTP id
 s15-20020a1f5e0f000000b0045081af7e59mr14763615vkb.1.1684280347156; Tue, 16
 May 2023 16:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230503085657.1814850-1-richard.henderson@linaro.org>
 <20230503085657.1814850-4-richard.henderson@linaro.org>
In-Reply-To: <20230503085657.1814850-4-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 17 May 2023 09:38:41 +1000
Message-ID: <CAKmqyKM-suczohr_W25fjV=hb6uXxPt+Q8hAVd3OQxYs0kwfqQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] tcg/riscv: Support ANDN, ORN, XNOR from Zbb
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Wed, May 3, 2023 at 6:58=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tcg/riscv/tcg-target-con-set.h |  1 +
>  tcg/riscv/tcg-target-con-str.h |  1 +
>  tcg/riscv/tcg-target.h         | 12 +++++-----
>  tcg/riscv/tcg-target.c.inc     | 41 ++++++++++++++++++++++++++++++++++
>  4 files changed, 49 insertions(+), 6 deletions(-)
>
> diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-se=
t.h
> index d88888d3ac..1a33ece98f 100644
> --- a/tcg/riscv/tcg-target-con-set.h
> +++ b/tcg/riscv/tcg-target-con-set.h
> @@ -15,6 +15,7 @@ C_O0_I2(rZ, rZ)
>  C_O1_I1(r, r)
>  C_O1_I2(r, r, ri)
>  C_O1_I2(r, r, rI)
> +C_O1_I2(r, r, rJ)
>  C_O1_I2(r, rZ, rN)
>  C_O1_I2(r, rZ, rZ)
>  C_O2_I4(r, r, rZ, rZ, rM, rM)
> diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-st=
r.h
> index 6f1cfb976c..d5c419dff1 100644
> --- a/tcg/riscv/tcg-target-con-str.h
> +++ b/tcg/riscv/tcg-target-con-str.h
> @@ -15,6 +15,7 @@ REGS('r', ALL_GENERAL_REGS)
>   * CONST(letter, TCG_CT_CONST_* bit set)
>   */
>  CONST('I', TCG_CT_CONST_S12)
> +CONST('J', TCG_CT_CONST_J12)
>  CONST('N', TCG_CT_CONST_N12)
>  CONST('M', TCG_CT_CONST_M12)
>  CONST('Z', TCG_CT_CONST_ZERO)
> diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
> index 863ac8ba2f..9f58d46208 100644
> --- a/tcg/riscv/tcg-target.h
> +++ b/tcg/riscv/tcg-target.h
> @@ -120,9 +120,9 @@ extern bool have_zbb;
>  #define TCG_TARGET_HAS_bswap32_i32      0
>  #define TCG_TARGET_HAS_not_i32          1
>  #define TCG_TARGET_HAS_neg_i32          1
> -#define TCG_TARGET_HAS_andc_i32         0
> -#define TCG_TARGET_HAS_orc_i32          0
> -#define TCG_TARGET_HAS_eqv_i32          0
> +#define TCG_TARGET_HAS_andc_i32         have_zbb
> +#define TCG_TARGET_HAS_orc_i32          have_zbb
> +#define TCG_TARGET_HAS_eqv_i32          have_zbb
>  #define TCG_TARGET_HAS_nand_i32         0
>  #define TCG_TARGET_HAS_nor_i32          0
>  #define TCG_TARGET_HAS_clz_i32          0
> @@ -154,9 +154,9 @@ extern bool have_zbb;
>  #define TCG_TARGET_HAS_bswap64_i64      0
>  #define TCG_TARGET_HAS_not_i64          1
>  #define TCG_TARGET_HAS_neg_i64          1
> -#define TCG_TARGET_HAS_andc_i64         0
> -#define TCG_TARGET_HAS_orc_i64          0
> -#define TCG_TARGET_HAS_eqv_i64          0
> +#define TCG_TARGET_HAS_andc_i64         have_zbb
> +#define TCG_TARGET_HAS_orc_i64          have_zbb
> +#define TCG_TARGET_HAS_eqv_i64          have_zbb
>  #define TCG_TARGET_HAS_nand_i64         0
>  #define TCG_TARGET_HAS_nor_i64          0
>  #define TCG_TARGET_HAS_clz_i64          0
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 49ff9c8b9d..c5b060023f 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -138,6 +138,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnK=
ind kind, int slot)
>  #define TCG_CT_CONST_S12   0x200
>  #define TCG_CT_CONST_N12   0x400
>  #define TCG_CT_CONST_M12   0x800
> +#define TCG_CT_CONST_J12  0x1000
>
>  #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
>
> @@ -174,6 +175,13 @@ static bool tcg_target_const_match(int64_t val, TCGT=
ype type, int ct)
>      if ((ct & TCG_CT_CONST_M12) && val >=3D -0x7ff && val <=3D 0x7ff) {
>          return 1;
>      }
> +    /*
> +     * Inverse of sign extended from 12 bits: ~[-0x800, 0x7ff].
> +     * Used to map ANDN back to ANDI, etc.
> +     */
> +    if ((ct & TCG_CT_CONST_J12) && ~val >=3D -0x800 && ~val <=3D 0x7ff) =
{
> +        return 1;
> +    }
>      return 0;
>  }
>
> @@ -1306,6 +1314,31 @@ static void tcg_out_op(TCGContext *s, TCGOpcode op=
c,
>          }
>          break;
>
> +    case INDEX_op_andc_i32:
> +    case INDEX_op_andc_i64:
> +        if (c2) {
> +            tcg_out_opc_imm(s, OPC_ANDI, a0, a1, ~a2);
> +        } else {
> +            tcg_out_opc_reg(s, OPC_ANDN, a0, a1, a2);
> +        }
> +        break;
> +    case INDEX_op_orc_i32:
> +    case INDEX_op_orc_i64:
> +        if (c2) {
> +            tcg_out_opc_imm(s, OPC_ORI, a0, a1, ~a2);
> +        } else {
> +            tcg_out_opc_reg(s, OPC_ORN, a0, a1, a2);
> +        }
> +        break;
> +    case INDEX_op_eqv_i32:
> +    case INDEX_op_eqv_i64:
> +        if (c2) {
> +            tcg_out_opc_imm(s, OPC_XORI, a0, a1, ~a2);
> +        } else {
> +            tcg_out_opc_reg(s, OPC_XNOR, a0, a1, a2);
> +        }
> +        break;
> +
>      case INDEX_op_not_i32:
>      case INDEX_op_not_i64:
>          tcg_out_opc_imm(s, OPC_XORI, a0, a1, -1);
> @@ -1536,6 +1569,14 @@ static TCGConstraintSetIndex tcg_target_op_def(TCG=
Opcode op)
>      case INDEX_op_xor_i64:
>          return C_O1_I2(r, r, rI);
>
> +    case INDEX_op_andc_i32:
> +    case INDEX_op_andc_i64:
> +    case INDEX_op_orc_i32:
> +    case INDEX_op_orc_i64:
> +    case INDEX_op_eqv_i32:
> +    case INDEX_op_eqv_i64:
> +        return C_O1_I2(r, r, rJ);
> +
>      case INDEX_op_sub_i32:
>      case INDEX_op_sub_i64:
>          return C_O1_I2(r, rZ, rN);
> --
> 2.34.1
>
>

