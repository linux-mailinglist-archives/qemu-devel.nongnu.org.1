Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 271A3705B7D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 01:51:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz4Rh-0005L3-IM; Tue, 16 May 2023 19:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz4RY-0005Kn-4x
 for qemu-devel@nongnu.org; Tue, 16 May 2023 19:51:00 -0400
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz4RW-0007Kl-Jz
 for qemu-devel@nongnu.org; Tue, 16 May 2023 19:50:59 -0400
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-77d049b9040so6070251241.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 16:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684281057; x=1686873057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h6EUOjDO5bZjwrqBTW4mayX+h244WQjbzUMx+tCbh4g=;
 b=lQnINicdYhxn7yJv6PhbdOCFU79BaAsaN7EFZoUPfsOzM6x3balJPXS12wg7lJH6nz
 kpFTDf9d1nNQR68E0AgXmJ4zyaNorLdksqkWF/9vIgQ2IuNQ5qfdJDE3z4drES1uTYK7
 EVMZ47IfoefphzZpa0zjzkpANs7V5akcw6BU+vCIqrTnS/bTbMRlGrIk7IAbUNW6rFSZ
 h1LeVeIQR9uNZZJV4odUHtpEXlIejvNewmyVUh//XKEFDut9p5Zr1HdUwBP8YoVsPapk
 F3OciXB12ojQOkr20t6pX6piT4IRQcC80JdgBG7FEkRjhE8SpIljZIK6BG4ivycp0Bb4
 qhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684281057; x=1686873057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h6EUOjDO5bZjwrqBTW4mayX+h244WQjbzUMx+tCbh4g=;
 b=dlAw/r63ADD+KghJAZF5OW8KIvds0PAClRF4CpTGhKXVJXZdGiavwcIpuwLdk0GUaL
 35QoSg0Ik3cpvdjC0bCFg6y6Lm4yWt5QttEp8bAatEc5jWja9WdG70D6PYwDgDUbCPm1
 Y8/6cpoR7tQdfhbgWKGaC84sTF8yKcZM1lkQqLyJ79GzLWolSBKwDhaVTLKxLzXV+PEl
 MInik11wnUmTUMberkV04W6ytAP94W52Fdd/9wKWBWn5hJrp09EqYiMWWdW8LXkWdEEb
 X2PEBn388Elu6Tjsckj0x8/8AgdzU/zhCq5LgV5TRppVJetkm096jBojqDh2VkMB93+4
 OIhw==
X-Gm-Message-State: AC+VfDzQMM62AkfepIgQlg+tKxr9Hps5LG9VHovuGnIkyLG7aK3KytzZ
 LpJq5oLtI9NrnRGFFiqVtBJ+OwSEgxdTlJNLvoc=
X-Google-Smtp-Source: ACHHUZ44zfv+K/8ebSzq+iATnPGd9VYLP2EIC0A7aUpjyLSFTaVP5UaZnNy9vEQwPkcodZcZY4A+VdFDo1RotISSq60=
X-Received: by 2002:a1f:7885:0:b0:452:9ac1:551a with SMTP id
 t127-20020a1f7885000000b004529ac1551amr158097vkc.0.1684281057519; Tue, 16 May
 2023 16:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230503085657.1814850-1-richard.henderson@linaro.org>
 <20230503085657.1814850-8-richard.henderson@linaro.org>
In-Reply-To: <20230503085657.1814850-8-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 17 May 2023 09:50:31 +1000
Message-ID: <CAKmqyKMQETHCjF-U_2D2f2HAioq-_pmC7xXbPMhpap3dCqANjQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] tcg/riscv: Support REV8 from Zbb
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
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
>  tcg/riscv/tcg-target.h     | 10 +++++-----
>  tcg/riscv/tcg-target.c.inc | 29 +++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
> index 317d385924..8e327afc3a 100644
> --- a/tcg/riscv/tcg-target.h
> +++ b/tcg/riscv/tcg-target.h
> @@ -116,8 +116,8 @@ extern bool have_zbb;
>  #define TCG_TARGET_HAS_ext16s_i32       1
>  #define TCG_TARGET_HAS_ext8u_i32        1
>  #define TCG_TARGET_HAS_ext16u_i32       1
> -#define TCG_TARGET_HAS_bswap16_i32      0
> -#define TCG_TARGET_HAS_bswap32_i32      0
> +#define TCG_TARGET_HAS_bswap16_i32      have_zbb
> +#define TCG_TARGET_HAS_bswap32_i32      have_zbb
>  #define TCG_TARGET_HAS_not_i32          1
>  #define TCG_TARGET_HAS_neg_i32          1
>  #define TCG_TARGET_HAS_andc_i32         have_zbb
> @@ -149,9 +149,9 @@ extern bool have_zbb;
>  #define TCG_TARGET_HAS_ext8u_i64        1
>  #define TCG_TARGET_HAS_ext16u_i64       1
>  #define TCG_TARGET_HAS_ext32u_i64       1
> -#define TCG_TARGET_HAS_bswap16_i64      0
> -#define TCG_TARGET_HAS_bswap32_i64      0
> -#define TCG_TARGET_HAS_bswap64_i64      0
> +#define TCG_TARGET_HAS_bswap16_i64      have_zbb
> +#define TCG_TARGET_HAS_bswap32_i64      have_zbb
> +#define TCG_TARGET_HAS_bswap64_i64      have_zbb
>  #define TCG_TARGET_HAS_not_i64          1
>  #define TCG_TARGET_HAS_neg_i64          1
>  #define TCG_TARGET_HAS_andc_i64         have_zbb
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 58f969b4fe..9cbefb2833 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -1488,6 +1488,30 @@ static void tcg_out_op(TCGContext *s, TCGOpcode op=
c,
>          }
>          break;
>
> +    case INDEX_op_bswap64_i64:
> +        tcg_out_opc_imm(s, OPC_REV8, a0, a1, 0);
> +        break;
> +    case INDEX_op_bswap32_i32:
> +        a2 =3D 0;
> +        /* fall through */
> +    case INDEX_op_bswap32_i64:
> +        tcg_out_opc_imm(s, OPC_REV8, a0, a1, 0);
> +        if (a2 & TCG_BSWAP_OZ) {
> +            tcg_out_opc_imm(s, OPC_SRLI, a0, a0, 32);
> +        } else {
> +            tcg_out_opc_imm(s, OPC_SRAI, a0, a0, 32);
> +        }
> +        break;
> +    case INDEX_op_bswap16_i64:
> +    case INDEX_op_bswap16_i32:
> +        tcg_out_opc_imm(s, OPC_REV8, a0, a1, 0);
> +        if (a2 & TCG_BSWAP_OZ) {
> +            tcg_out_opc_imm(s, OPC_SRLI, a0, a0, 48);
> +        } else {
> +            tcg_out_opc_imm(s, OPC_SRAI, a0, a0, 48);
> +        }
> +        break;
> +
>      case INDEX_op_add2_i32:
>          tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
>                          const_args[4], const_args[5], false, true);
> @@ -1605,6 +1629,11 @@ static TCGConstraintSetIndex tcg_target_op_def(TCG=
Opcode op)
>      case INDEX_op_extrl_i64_i32:
>      case INDEX_op_extrh_i64_i32:
>      case INDEX_op_ext_i32_i64:
> +    case INDEX_op_bswap16_i32:
> +    case INDEX_op_bswap32_i32:
> +    case INDEX_op_bswap16_i64:
> +    case INDEX_op_bswap32_i64:
> +    case INDEX_op_bswap64_i64:
>          return C_O1_I1(r, r);
>
>      case INDEX_op_st8_i32:
> --
> 2.34.1
>
>

