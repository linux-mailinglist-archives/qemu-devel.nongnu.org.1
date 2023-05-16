Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A09C0705B73
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 01:44:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz4Kh-0003aZ-Tm; Tue, 16 May 2023 19:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz4Kf-0003a4-OM
 for qemu-devel@nongnu.org; Tue, 16 May 2023 19:43:53 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz4Kd-00060c-6q
 for qemu-devel@nongnu.org; Tue, 16 May 2023 19:43:52 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-44ffef66dabso154251e0c.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 16:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684280630; x=1686872630;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GqwbtlirN2QDP8ROIthD8b7X2XSBA1E7Xw0HLj5XXVw=;
 b=CUZgdd5F3yGwJvB2b+PLElA0Fqrz1STBrkCWwdOYripSbDzsNO+rsszyL3wca2AjaO
 sQDz8VGwi5ZuE8oSQZpe3+Z+RDDMxdisrhyBKY2VEKBlwQIVUEYWQil1L0Xh2vm9FqbY
 MHFI4NY4ZRRGO5iQT7TslIj9WZIvOoJDyhrIlhPScmWg1d6xSxZTlrDknmu70b2neVK8
 KiLIipko486HYy840tv7Qnf2GP4ZY3ahs7rYvSNh56sPlpmfoo1itGY8h5QPuSgQ4dsW
 jV4BNn7drKZuD8kJz0zqZXT6puGhfHREkSNyQPN1BtIELTt4PkmsiuHnaSIqX3vJxBpe
 RLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684280630; x=1686872630;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GqwbtlirN2QDP8ROIthD8b7X2XSBA1E7Xw0HLj5XXVw=;
 b=FRUt4ikyUNYUfAHXdBGLuPEqsaQeiClyGNrO7X+08zb0jnvGMnkPIReBpxE/ZhdJyK
 7O+XMGsiMKRnKKlk3iwc4DQj0O2cnOeTOXKCJJX6wh4Qv7jox4eD+JIds5/Zxutrpvxe
 jNQqUQcBLH+Vl4QNfPiWbMdXQOgBNxtsNTtrSAo0PD5xb9UEU1+YLkrXSOHtMxYlQjji
 EFuMjBOonZg4EeVnBWoE02x9X3IpC1PyxCmksQmACUffhxYbbF4RYufWN09+PWw1fEr2
 zy1z3gTRggstkt4/ymtEbBuhVcZkMFx8RKCq/80ublcmrGN/K28atoFpSld1WtuMnshP
 ijnQ==
X-Gm-Message-State: AC+VfDyFh/MhFEQp7hTWVDGDEtnv/ZdjpQTxVgpjNBJz0G5rAUD6zVY7
 mxM0tVCbhMKnuPMQtRclul7RWzVgUgwH27fzPEiZ8NUG30A=
X-Google-Smtp-Source: ACHHUZ5yc7VlMZ7Pv+6JUTe8bo3zzkiW6f9+C6qV0BT/vKgTiXHHpxQd+lScDBrisjcLk+N/VvGzTaGvGWN66tdsmcw=
X-Received: by 2002:a1f:4381:0:b0:44f:c794:42b with SMTP id
 q123-20020a1f4381000000b0044fc794042bmr15062558vka.12.1684280630098; Tue, 16
 May 2023 16:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230503085657.1814850-1-richard.henderson@linaro.org>
 <20230503085657.1814850-6-richard.henderson@linaro.org>
In-Reply-To: <20230503085657.1814850-6-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 17 May 2023 09:43:24 +1000
Message-ID: <CAKmqyKOWmH0oPzELTsyyB=25b+7khRusw5dLQpB_yJoSOYUzSA@mail.gmail.com>
Subject: Re: [PATCH 05/11] tcg/riscv: Use ADD.UW for guest address generation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
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
> The instruction is a combined zero-extend and add.
> Use it for exactly that.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tcg/riscv/tcg-target.c.inc | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 53a7f97b29..f64eaa8515 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -1039,14 +1039,18 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGCon=
text *s, TCGReg *pbase,
>      tcg_out_opc_branch(s, OPC_BNE, TCG_REG_TMP0, TCG_REG_TMP1, 0);
>
>      /* TLB Hit - translate address using addend.  */
> -    addr_adj =3D addr_reg;
> -    if (TARGET_LONG_BITS =3D=3D 32) {
> -        addr_adj =3D TCG_REG_TMP0;
> -        tcg_out_ext32u(s, addr_adj, addr_reg);
> +    if (TARGET_LONG_BITS =3D=3D 64) {
> +        tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, addr_reg, TCG_REG_TMP2=
);
> +    } else if (have_zba) {
> +        tcg_out_opc_reg(s, OPC_ADD_UW, TCG_REG_TMP0, addr_reg, TCG_REG_T=
MP2);
> +    } else {
> +        tcg_out_ext32u(s, TCG_REG_TMP0, addr_reg);
> +        tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, TCG_REG_TMP0, TCG_REG_=
TMP2);
>      }
> -    tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, TCG_REG_TMP2, addr_adj);
>      *pbase =3D TCG_REG_TMP0;
>  #else
> +    TCGReg base;
> +
>      if (a_mask) {
>          ldst =3D new_ldst_label(s);
>          ldst->is_ld =3D is_ld;
> @@ -1061,14 +1065,21 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGCon=
text *s, TCGReg *pbase,
>          tcg_out_opc_branch(s, OPC_BNE, TCG_REG_TMP1, TCG_REG_ZERO, 0);
>      }
>
> -    TCGReg base =3D addr_reg;
> -    if (TARGET_LONG_BITS =3D=3D 32) {
> -        tcg_out_ext32u(s, TCG_REG_TMP0, base);
> -        base =3D TCG_REG_TMP0;
> -    }
>      if (guest_base !=3D 0) {
> -        tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, TCG_GUEST_BASE_REG, ba=
se);
>          base =3D TCG_REG_TMP0;
> +        if (TARGET_LONG_BITS =3D=3D 64) {
> +            tcg_out_opc_reg(s, OPC_ADD, base, addr_reg, TCG_GUEST_BASE_R=
EG);
> +        } else if (have_zba) {
> +            tcg_out_opc_reg(s, OPC_ADD_UW, base, addr_reg, TCG_GUEST_BAS=
E_REG);
> +        } else {
> +            tcg_out_ext32u(s, base, addr_reg);
> +            tcg_out_opc_reg(s, OPC_ADD, base, base, TCG_GUEST_BASE_REG);
> +        }
> +    } else if (TARGET_LONG_BITS =3D=3D 64) {
> +        base =3D addr_reg;
> +    } else {
> +        base =3D TCG_REG_TMP0;
> +        tcg_out_ext32u(s, base, addr_reg);
>      }
>      *pbase =3D base;
>  #endif
> --
> 2.34.1
>
>

