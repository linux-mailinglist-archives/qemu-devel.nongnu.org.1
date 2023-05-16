Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB27705B7C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 01:51:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz4Ry-0005il-D5; Tue, 16 May 2023 19:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz4Rv-0005iB-Pz
 for qemu-devel@nongnu.org; Tue, 16 May 2023 19:51:23 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz4Ru-0007PP-8k
 for qemu-devel@nongnu.org; Tue, 16 May 2023 19:51:23 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-44fa585ad7aso174443e0c.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 16:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684281081; x=1686873081;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J4pqTZTNEFXKSm2zrjAO8/dtAOSli3TDLNgI1m/iJzw=;
 b=AM4zARFpgOEUTS0B+Lak4vjM3KmA98r8KjczYcgt5htNMFsrUn54FMGuDJB6yQf+2z
 KSkqbPSeUVOA7LFyl9WJhKg2B7JFo6rfWco604EmKkIg9GLsRRds3txnI/T7Gd1mPXRn
 YrIUT49dtLipLlJ0duf3xE/1GpeqqK66FmvHi1MOnaoOpGV/9pAY5y7HrZEFNQ30+Jgu
 QQ0J6Z2KlTNZrAsGC6PIHaJI/hRodJ11GeAQekPDzpZDP2fZpBzXbuUVQfAm5wE0B2PI
 YMVBar0h1TWMP5mmucANLBrg00io45hBDbnT0RFOiEhQYby+9H0ep1GT8MZHnU0Yo/6D
 El+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684281081; x=1686873081;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J4pqTZTNEFXKSm2zrjAO8/dtAOSli3TDLNgI1m/iJzw=;
 b=PpPHvKgRitsxlzJZ6QuC5mHp92uCw/UA3oU517UweesM6gdWYvbKUaOq9aLsM9jLAZ
 8+3fj8140bpgl8PebJqI4daGJlGr76XLeG6LLn1nANjsRvCbP7asVDbsyj5jaKFMUo0Z
 2XEUQbFS6FGVJBksgT+ZqopBTU1KSlSlIGCXU1bUrChEgwiksfPXsM8bGAEQ737/O+oR
 kLdSpHDVVvZJqbUIvB9DO/xu0cetkUFAM755QWYAndwM5zcXFL8N/nFe3oQb9UhYvt0x
 gOF0TGXvnLRkWbw6RXpglh0ZP6swizrq2u1crBNWr4Hy2+7PE16RLDE56pyEnwBAkrBC
 eRHw==
X-Gm-Message-State: AC+VfDywuzpfkKSLoWDuvxC7YYqGTiKZvyFBDXHHU6nPmOwfnK/FomvQ
 fOqzx14zTq3bvZK/jmipPnq1HZEKKXzNB/jkbBc8rb2VGLs=
X-Google-Smtp-Source: ACHHUZ6c76qslT5EVraW5zQWJ89kJ3bcgkKo4VWZkfcFpQibY4tDXzt7/AMsi6NzlZ0JC7SrPwmpIbPT1QRiFN1RWTs=
X-Received: by 2002:a1f:5f46:0:b0:440:8b67:dba6 with SMTP id
 t67-20020a1f5f46000000b004408b67dba6mr17125028vkb.4.1684281081357; Tue, 16
 May 2023 16:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230503085657.1814850-1-richard.henderson@linaro.org>
 <20230503085657.1814850-9-richard.henderson@linaro.org>
In-Reply-To: <20230503085657.1814850-9-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 17 May 2023 09:50:55 +1000
Message-ID: <CAKmqyKOgP6yAZHZ6ThGJ18ShNtX4WQxj5rzN=kE2-Ye0ORMWtQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] tcg/riscv: Support CPOP from Zbb
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

On Wed, May 3, 2023 at 6:58=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tcg/riscv/tcg-target.h     | 4 ++--
>  tcg/riscv/tcg-target.c.inc | 9 +++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
> index 8e327afc3a..e0b23006c4 100644
> --- a/tcg/riscv/tcg-target.h
> +++ b/tcg/riscv/tcg-target.h
> @@ -127,7 +127,7 @@ extern bool have_zbb;
>  #define TCG_TARGET_HAS_nor_i32          0
>  #define TCG_TARGET_HAS_clz_i32          0
>  #define TCG_TARGET_HAS_ctz_i32          0
> -#define TCG_TARGET_HAS_ctpop_i32        0
> +#define TCG_TARGET_HAS_ctpop_i32        have_zbb
>  #define TCG_TARGET_HAS_brcond2          1
>  #define TCG_TARGET_HAS_setcond2         1
>  #define TCG_TARGET_HAS_qemu_st8_i32     0
> @@ -161,7 +161,7 @@ extern bool have_zbb;
>  #define TCG_TARGET_HAS_nor_i64          0
>  #define TCG_TARGET_HAS_clz_i64          0
>  #define TCG_TARGET_HAS_ctz_i64          0
> -#define TCG_TARGET_HAS_ctpop_i64        0
> +#define TCG_TARGET_HAS_ctpop_i64        have_zbb
>  #define TCG_TARGET_HAS_add2_i64         1
>  #define TCG_TARGET_HAS_sub2_i64         1
>  #define TCG_TARGET_HAS_mulu2_i64        0
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 9cbefb2833..044ddfb160 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -1512,6 +1512,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode op=
c,
>          }
>          break;
>
> +    case INDEX_op_ctpop_i32:
> +        tcg_out_opc_imm(s, OPC_CPOPW, a0, a1, 0);
> +        break;
> +    case INDEX_op_ctpop_i64:
> +        tcg_out_opc_imm(s, OPC_CPOP, a0, a1, 0);
> +        break;
> +
>      case INDEX_op_add2_i32:
>          tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
>                          const_args[4], const_args[5], false, true);
> @@ -1634,6 +1641,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGO=
pcode op)
>      case INDEX_op_bswap16_i64:
>      case INDEX_op_bswap32_i64:
>      case INDEX_op_bswap64_i64:
> +    case INDEX_op_ctpop_i32:
> +    case INDEX_op_ctpop_i64:
>          return C_O1_I1(r, r);
>
>      case INDEX_op_st8_i32:
> --
> 2.34.1
>
>

