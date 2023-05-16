Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FF0705B78
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 01:49:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz4Q5-0004Wn-Ui; Tue, 16 May 2023 19:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz4Q2-0004We-U5
 for qemu-devel@nongnu.org; Tue, 16 May 2023 19:49:27 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz4Q0-0006zF-7P
 for qemu-devel@nongnu.org; Tue, 16 May 2023 19:49:25 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-452f92680ecso86442e0c.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 16:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684280963; x=1686872963;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RS53Q/+LH5MXRI80CFTkRjQu+T6Mt4xbiMcEjqB7Emc=;
 b=DqfMvzFIpmpwBkAQE3mKF4jQ+ChPhgHMIiiBmCoWToaarYDV77ndvua2jwb4uRm1zo
 cDiw2bf5GUlo6Mz8SprfU1iNB/h8DUD689tH1rKITcs67LIEAEWmN8YRDFRI1IkYYXsH
 5/jZCJ9wZAdgUYbxpS4W2K+HzByFW/rTn7mL/m4MLzJhukJaAvSR2IOKTuCPxgKSkd6b
 hacU4PmjcPj97gy4J941NUyt5DNTZZnc/0OLc88BRRsxrUfNFgSgcXrbnFTNE7SRbl7z
 9i2ohfZlAFPCf73n7a/EWlE8jj9lquEgqYnRwkWxfotLvCj5IdYxIPCV3h9AB3nI0q9j
 qjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684280963; x=1686872963;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RS53Q/+LH5MXRI80CFTkRjQu+T6Mt4xbiMcEjqB7Emc=;
 b=bNIXsuYCccYIH8Uv5yxuMIm4ZkIR+RSsEYREFi/uuJyrrBcJHEno0crNyeM0TW9HUD
 0R0Og0kWmeS2ZqLAlKmWTNMcj3MXnl8DuCosdb5gXz7+CRr0dULBOOHcAtBuzbjXqT/G
 mSWUebr274W/Nt8rTa0N5pdmhFiEO48mjThTzIAiZXpx0tCcGqOuaD46Wgx04yIQFkcu
 6nxgtpX2sSJJIILD5ycHzkZDWXDfoV5s3RLoYOzCD5NfOyV0YTVLOOtL8cxNfXTSBTf1
 RAeTmrDmUQLYbHsVl9rcIcAaPwjoEqpN4PKEe1JKMA0zddZrnx0KAX701RZjL6mSwznM
 +ZSQ==
X-Gm-Message-State: AC+VfDxXhdkhuFJIqdL8PzoT4wh+7e8AgNR+FIGORMZSxbZ1dqft6U3c
 RgDRxYIo9PdT7bo713UoxKbYXlCENyEeFC4kiK8=
X-Google-Smtp-Source: ACHHUZ6/Xj/YccMAsITc1gHHKHB55jbVp2jyP7TyFKK3ThMWwm7a0myvgdtGTV7mhbqgaoB9ddWmCqN2fyEna1W3ftI=
X-Received: by 2002:a1f:c113:0:b0:44f:d615:8dcb with SMTP id
 r19-20020a1fc113000000b0044fd6158dcbmr13174243vkf.8.1684280962673; Tue, 16
 May 2023 16:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230503085657.1814850-1-richard.henderson@linaro.org>
 <20230503085657.1814850-7-richard.henderson@linaro.org>
In-Reply-To: <20230503085657.1814850-7-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 17 May 2023 09:48:56 +1000
Message-ID: <CAKmqyKN7NjeWuf9kVBrM15X9VR+ZabGdrkrLMkXgjFC77Xw+YQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] tcg/riscv: Support rotates from Zbb
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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
>  tcg/riscv/tcg-target.h     |  4 ++--
>  tcg/riscv/tcg-target.c.inc | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
> index 9f58d46208..317d385924 100644
> --- a/tcg/riscv/tcg-target.h
> +++ b/tcg/riscv/tcg-target.h
> @@ -101,7 +101,7 @@ extern bool have_zbb;
>  #define TCG_TARGET_HAS_div_i32          1
>  #define TCG_TARGET_HAS_rem_i32          1
>  #define TCG_TARGET_HAS_div2_i32         0
> -#define TCG_TARGET_HAS_rot_i32          0
> +#define TCG_TARGET_HAS_rot_i32          have_zbb
>  #define TCG_TARGET_HAS_deposit_i32      0
>  #define TCG_TARGET_HAS_extract_i32      0
>  #define TCG_TARGET_HAS_sextract_i32     0
> @@ -136,7 +136,7 @@ extern bool have_zbb;
>  #define TCG_TARGET_HAS_div_i64          1
>  #define TCG_TARGET_HAS_rem_i64          1
>  #define TCG_TARGET_HAS_div2_i64         0
> -#define TCG_TARGET_HAS_rot_i64          0
> +#define TCG_TARGET_HAS_rot_i64          have_zbb
>  #define TCG_TARGET_HAS_deposit_i64      0
>  #define TCG_TARGET_HAS_extract_i64      0
>  #define TCG_TARGET_HAS_sextract_i64     0
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index f64eaa8515..58f969b4fe 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -1458,6 +1458,36 @@ static void tcg_out_op(TCGContext *s, TCGOpcode op=
c,
>          }
>          break;
>
> +    case INDEX_op_rotl_i32:
> +        if (c2) {
> +            tcg_out_opc_imm(s, OPC_RORIW, a0, a1, -a2 & 0x1f);
> +        } else {
> +            tcg_out_opc_reg(s, OPC_ROLW, a0, a1, a2);
> +        }
> +        break;
> +    case INDEX_op_rotl_i64:
> +        if (c2) {
> +            tcg_out_opc_imm(s, OPC_RORI, a0, a1, -a2 & 0x3f);
> +        } else {
> +            tcg_out_opc_reg(s, OPC_ROL, a0, a1, a2);
> +        }
> +        break;
> +
> +    case INDEX_op_rotr_i32:
> +        if (c2) {
> +            tcg_out_opc_imm(s, OPC_RORIW, a0, a1, a2 & 0x1f);
> +        } else {
> +            tcg_out_opc_reg(s, OPC_RORW, a0, a1, a2);
> +        }
> +        break;
> +    case INDEX_op_rotr_i64:
> +        if (c2) {
> +            tcg_out_opc_imm(s, OPC_RORI, a0, a1, a2 & 0x3f);
> +        } else {
> +            tcg_out_opc_reg(s, OPC_ROR, a0, a1, a2);
> +        }
> +        break;
> +
>      case INDEX_op_add2_i32:
>          tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
>                          const_args[4], const_args[5], false, true);
> @@ -1629,9 +1659,13 @@ static TCGConstraintSetIndex tcg_target_op_def(TCG=
Opcode op)
>      case INDEX_op_shl_i32:
>      case INDEX_op_shr_i32:
>      case INDEX_op_sar_i32:
> +    case INDEX_op_rotl_i32:
> +    case INDEX_op_rotr_i32:
>      case INDEX_op_shl_i64:
>      case INDEX_op_shr_i64:
>      case INDEX_op_sar_i64:
> +    case INDEX_op_rotl_i64:
> +    case INDEX_op_rotr_i64:
>          return C_O1_I2(r, r, ri);
>
>      case INDEX_op_brcond_i32:
> --
> 2.34.1
>
>

