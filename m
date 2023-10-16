Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B927C9D3C
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 03:53:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsCmc-0004o9-JJ; Sun, 15 Oct 2023 21:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qsCma-0004nR-Nm; Sun, 15 Oct 2023 21:52:36 -0400
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qsCmZ-00044b-2t; Sun, 15 Oct 2023 21:52:36 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-457c19ebb3aso1071108137.1; 
 Sun, 15 Oct 2023 18:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697421154; x=1698025954; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXT2AYkw2IlOS8KAPm8gmVahQZLt1Ma3OjNk5s7FYJA=;
 b=SGGQ26GzVQgYOIjJuBaChiIXmw+rZaJIxN80bZj5Q9BChyCNO+SyJnGTmMPBXd8jXB
 6vfG805BFygIB7BOXFAa3/Z2UGg4L4wtCJly9CcuYXXq/4YpC8yIKHWmH5uDwWshmAFb
 dpm0Iurt0KG0YD9WNBmC7cOtLCEtLIw6dFcsALSikqZzrp0nXLhP8QeW14K8cb6BbX6J
 mdHHraJXWjNoW+2hLJfg4kdq5MwH3VPD01iPTtOIN9O8fFv4zyyq0lYtK1d9t/ihGftX
 NU4Wde6gvxTp2CSG6UIOYVbs9olSB6qO4AFg0tRQyIAqPdkkmcO+VtLCsN1PT94yL+C0
 HZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697421154; x=1698025954;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wXT2AYkw2IlOS8KAPm8gmVahQZLt1Ma3OjNk5s7FYJA=;
 b=BCji8QAmdFQxuA7zpAs4a5k8FQkFoc55Po7o32al0+bOhACQglyrs1ZTdNbPVU6Qe3
 3y/fY6oU7G8AvM4vD95UbrEs7p52golEBPpIztGbGuTKGyi/IynSIL4j0khF8Ao2CVSB
 v+WzdnVOxeMvueaByFwcXgS/wYFcy0sGbQ8ySBot+4c8k0ZAtn2itfraFLJBmp5mrwPD
 EIfstGeG6927GsslDJ62RoL48cjv+m0q9sj+gDcF8wWj3MQB1jRlpr1VSdpaisAXR6H9
 VFLts2JHpNqONlcqML8EBzZ9lEKvKmQxEvycodkjj1+30BJLywa433Ws2D9SknLQKGA9
 wqww==
X-Gm-Message-State: AOJu0Yy6qN7H/c0buwGQ0KTRzF7mw/J2zqE4uxaChijlfWNMcAQ+rztJ
 avS5KZol9OVRGhHPkE3F0WPpM9ir0EtRcTEmFaI=
X-Google-Smtp-Source: AGHT+IGeXovy7QL87QUHyYVTnrtSb/IHIaT9fH8uiJGrMJuZAl1XhrLY4tzlDEG5AUalsTXBIIRVj4/lATdvFm/kWJk=
X-Received: by 2002:a05:6102:2f6:b0:451:124:2bb2 with SMTP id
 j22-20020a05610202f600b0045101242bb2mr22418237vsj.1.1697421153830; Sun, 15
 Oct 2023 18:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
 <b387a1f2114c71be3c88c5bc9d8acb7f53c3b441.1697186560.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <b387a1f2114c71be3c88c5bc9d8acb7f53c3b441.1697186560.git.manos.pitsidianakis@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Oct 2023 11:52:07 +1000
Message-ID: <CAKmqyKPwwiVuH6YMDStptXzn1d0m8fPhbT=g7d4+hr7n3OpVsg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 27/78] target/riscv: add fallthrough pseudo-keyword
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
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

On Fri, Oct 13, 2023 at 6:52=E2=80=AFPM Emmanouil Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvi.c.inc   |  2 +-
>  target/riscv/insn_trans/trans_rvzce.c.inc | 22 +++++++++++-----------
>  target/riscv/translate.c                  |  4 ++--
>  3 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_=
trans/trans_rvi.c.inc
> index 25cb60558a..98dd2e3cf6 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -122,7 +122,7 @@ static TCGCond gen_compare_i128(bool bz, TCGv rl,
>
>      case TCG_COND_LTU:
>          invert =3D true;
> -        /* fallthrough */
> +        fallthrough;
>      case TCG_COND_GEU:
>          {
>              TCGv tmp =3D tcg_temp_new();
> diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/ins=
n_trans/trans_rvzce.c.inc
> index 2d992e14c4..f0bcbb4f72 100644
> --- a/target/riscv/insn_trans/trans_rvzce.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzce.c.inc
> @@ -125,37 +125,37 @@ static uint32_t decode_push_pop_list(DisasContext *=
ctx, target_ulong rlist)
>      case 15:
>          reg_bitmap |=3D  1 << (X_Sn + 11) ;
>          reg_bitmap |=3D  1 << (X_Sn + 10) ;
> -        /* FALL THROUGH */
> +        fallthrough;
>      case 14:
>          reg_bitmap |=3D  1 << (X_Sn + 9) ;
> -        /* FALL THROUGH */
> +        fallthrough;
>      case 13:
>          reg_bitmap |=3D  1 << (X_Sn + 8) ;
> -        /* FALL THROUGH */
> +        fallthrough;
>      case 12:
>          reg_bitmap |=3D  1 << (X_Sn + 7) ;
> -        /* FALL THROUGH */
> +        fallthrough;
>      case 11:
>          reg_bitmap |=3D  1 << (X_Sn + 6) ;
> -        /* FALL THROUGH */
> +        fallthrough;
>      case 10:
>          reg_bitmap |=3D  1 << (X_Sn + 5) ;
> -        /* FALL THROUGH */
> +        fallthrough;
>      case 9:
>          reg_bitmap |=3D  1 << (X_Sn + 4) ;
> -        /* FALL THROUGH */
> +        fallthrough;
>      case 8:
>          reg_bitmap |=3D  1 << (X_Sn + 3) ;
> -        /* FALL THROUGH */
> +        fallthrough;
>      case 7:
>          reg_bitmap |=3D  1 << (X_Sn + 2) ;
> -        /* FALL THROUGH */
> +        fallthrough;
>      case 6:
>          reg_bitmap |=3D  1 << X_S1 ;
> -        /* FALL THROUGH */
> +        fallthrough;
>      case 5:
>          reg_bitmap |=3D 1 << X_S0;
> -        /* FALL THROUGH */
> +        fallthrough;
>      case 4:
>          reg_bitmap |=3D 1 << xRA;
>          break;
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index f0be79bb16..c99e513221 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -446,7 +446,7 @@ static TCGv_i64 get_fpr_hs(DisasContext *ctx, int reg=
_num)
>          return t;
>      }
>  #else
> -    /* fall through */
> +    fallthrough;
>      case MXL_RV64:
>          return cpu_gpr[reg_num];
>  #endif
> @@ -516,7 +516,7 @@ static void gen_set_fpr_hs(DisasContext *ctx, int reg=
_num, TCGv_i64 t)
>              tcg_gen_extrl_i64_i32(cpu_gpr[reg_num], t);
>              break;
>  #else
> -        /* fall through */
> +        fallthrough;
>          case MXL_RV64:
>              tcg_gen_mov_i64(cpu_gpr[reg_num], t);
>              break;
> --
> 2.39.2
>
>

