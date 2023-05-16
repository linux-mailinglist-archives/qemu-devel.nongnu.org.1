Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 234DC705B70
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 01:40:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz4HW-0002hE-U0; Tue, 16 May 2023 19:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz4HR-0002e7-Hj
 for qemu-devel@nongnu.org; Tue, 16 May 2023 19:40:35 -0400
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz4HO-0005ZU-UA
 for qemu-devel@nongnu.org; Tue, 16 May 2023 19:40:33 -0400
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-43483fd0393so8683137.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 16:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684280427; x=1686872427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YNbr2nB8Qzvgcq8cgEpSaDR2aNXWrgDQ9SBBxyTg0eQ=;
 b=YSmMdhOpLzpfJi1Q0SIXWjPYBd8mKB19hxaTkrLOLhUshzqzk9F0OLpMk6Ob5NbWC7
 LbtkYtsfkmZ5oqQfCuly8t7AsCtFlGR0+i65zMGtHswb2fFMkWM8grSkEpn72cH52/Tu
 neuOHTOqAz2AVZ5fjPMFxasadYTRcl+4rjXzfXHV9sSy/y1TVeHdVW82YP+yV4pEN+Jg
 /osQzo0xPkI1m/9+PTVzE1TM9OOwmXG1qOa3E+ehk2m0ach9/5DutJCqFZQHYzsNqqHp
 K8V9/VOO0ehJ95f229RL83iCsO2ThtM5IaHe5VAKa2wFxdlgej8NB9M0ud0VVQTe4Ye5
 wu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684280427; x=1686872427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YNbr2nB8Qzvgcq8cgEpSaDR2aNXWrgDQ9SBBxyTg0eQ=;
 b=iXpEvjvCt6pZecTrWXj4EO3fISiNztN3o70jI5CEi8+dakOsKmehosA1h6KayYXU4L
 PRqdz2ZbUeAF8czRBiqNL3NPEgkVASD1Ao2JvDf6Q2f/bYG+bL3Pb+z8NpaaTUMMQ32Z
 WoRts0dI79t31sIdczJqkpXQE+4UUCvo9xo2UR/Cve3yhn2dReDRRSNOsNV7qpDtZ6Uy
 iGy6ETawP+zt+FY7kKsGMuFN8T5CodwUlCITjYTI6uJ80rgsIGyakbijsDB5EIXMkPfm
 saOCe+Ld5idqDeG74aNG36cl0aMqa/0NNurrKtW02Waavde04GuPMaY7iLpuytwomLv8
 xo5g==
X-Gm-Message-State: AC+VfDxZgsLEuUsYnChHsXzou6kAfSbFf5KQMnerp9bgqiqyhDGnlyrE
 TDK34zScccgbOhUXEejxzrpVhmkz+h+yCar39AEG/6cmVKY=
X-Google-Smtp-Source: ACHHUZ5UaVT3Ha833kvBHffbV9AOdIG+eRA9HJbC7vSv22Q2W6WCvH1KFyDMhHHorZDgr+3epHATAmIxvxO0wOR+rWo=
X-Received: by 2002:a67:ad04:0:b0:42f:efb0:ae5 with SMTP id
 t4-20020a67ad04000000b0042fefb00ae5mr15879800vsl.24.1684280426647; Tue, 16
 May 2023 16:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230503085657.1814850-1-richard.henderson@linaro.org>
 <20230503085657.1814850-5-richard.henderson@linaro.org>
In-Reply-To: <20230503085657.1814850-5-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 17 May 2023 09:40:00 +1000
Message-ID: <CAKmqyKONtmAh8sWFJQ=aOzv_V7cDxWUe89phVY3f1U23XntZKw@mail.gmail.com>
Subject: Re: [PATCH 04/11] tcg/riscv: Support ADD.UW, SEXT.B, SEXT.H, ZEXT.H
 from Zba+Zbb
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tcg/riscv/tcg-target.c.inc | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index c5b060023f..53a7f97b29 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -593,26 +593,42 @@ static void tcg_out_ext8u(TCGContext *s, TCGReg ret=
, TCGReg arg)
>
>  static void tcg_out_ext16u(TCGContext *s, TCGReg ret, TCGReg arg)
>  {
> -    tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 16);
> -    tcg_out_opc_imm(s, OPC_SRLIW, ret, ret, 16);
> +    if (have_zbb) {
> +        tcg_out_opc_reg(s, OPC_ZEXT_H, ret, arg, TCG_REG_ZERO);
> +    } else {
> +        tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 16);
> +        tcg_out_opc_imm(s, OPC_SRLIW, ret, ret, 16);
> +    }
>  }
>
>  static void tcg_out_ext32u(TCGContext *s, TCGReg ret, TCGReg arg)
>  {
> -    tcg_out_opc_imm(s, OPC_SLLI, ret, arg, 32);
> -    tcg_out_opc_imm(s, OPC_SRLI, ret, ret, 32);
> +    if (have_zba) {
> +        tcg_out_opc_reg(s, OPC_ADD_UW, ret, arg, TCG_REG_ZERO);
> +    } else {
> +        tcg_out_opc_imm(s, OPC_SLLI, ret, arg, 32);
> +        tcg_out_opc_imm(s, OPC_SRLI, ret, ret, 32);
> +    }
>  }
>
>  static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg ret, TCGRe=
g arg)
>  {
> -    tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 24);
> -    tcg_out_opc_imm(s, OPC_SRAIW, ret, ret, 24);
> +    if (have_zbb) {
> +        tcg_out_opc_imm(s, OPC_SEXT_B, ret, arg, 0);
> +    } else {
> +        tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 24);
> +        tcg_out_opc_imm(s, OPC_SRAIW, ret, ret, 24);
> +    }
>  }
>
>  static void tcg_out_ext16s(TCGContext *s, TCGType type, TCGReg ret, TCGR=
eg arg)
>  {
> -    tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 16);
> -    tcg_out_opc_imm(s, OPC_SRAIW, ret, ret, 16);
> +    if (have_zbb) {
> +        tcg_out_opc_imm(s, OPC_SEXT_H, ret, arg, 0);
> +    } else {
> +        tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 16);
> +        tcg_out_opc_imm(s, OPC_SRAIW, ret, ret, 16);
> +    }
>  }
>
>  static void tcg_out_ext32s(TCGContext *s, TCGReg ret, TCGReg arg)
> --
> 2.34.1
>
>

