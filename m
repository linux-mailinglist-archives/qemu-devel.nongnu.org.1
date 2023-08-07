Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C457718E0
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 05:53:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSrHM-00086I-Qe; Sun, 06 Aug 2023 23:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qSrHC-00085j-6B; Sun, 06 Aug 2023 23:51:28 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qSrH6-00006d-OI; Sun, 06 Aug 2023 23:51:23 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-99c3c8adb27so592721666b.1; 
 Sun, 06 Aug 2023 20:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691380275; x=1691985075;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=68jrWU+aHnXsAmZxRab/iiQRo7M5MHzhGLdtQ5ULTkI=;
 b=J3g41fN/t2ydJi+4jcg0F6wMxXWDjeI6wJyB1srOWotSG16s1fKpkoubbowCG04bUl
 txIHAyoVdh4YoCry9AV3PbLJ13lWqHp1Hqk9zkGt/H2miUnzJv8oFRTyNkQcN41HQSR+
 K8Zms1+0xqFvZojh+8Mic9fBwDzZvBjarBJ/2nUTevcburF5JMsXU1/bG4bdIiWVYCaY
 6V8FpBIoQ9gkVBBoA9U473AyJH68Ip5/CLC6LbfwLK+IwmVs30EWvkm5oMGv/Tzpt6hL
 MkdfXv/kdpmpckXWrSIzTXiph5Ryd2GWhmNi8FPCIVKQm4mJN9Gt7iDG8h4C+IuDicLL
 eAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691380275; x=1691985075;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=68jrWU+aHnXsAmZxRab/iiQRo7M5MHzhGLdtQ5ULTkI=;
 b=DQTq9LqnFmh0Z40RSAq17x3xxKehcF1FbJWi+Zb316Q3I6ye97NPsB6/ark4CcFm9U
 nDkyhMRfdZbYaOPY2ulobzcUsoOvH2E+3sNxIHNMMpzgZI5Wi9n5fcHnXCH440/CrWn4
 8hWbgqjnFmPfY+n3Vy7m2allXM1YrdMRguwV5o+iNdYqKHGKfmaf43oX1evw8Rpj+tB2
 untXOalumKZCFAro9TzyklAaTHvqPYlbKjuA29aaDCPqFPXRizHkoYeBmI6YNYM4llWA
 HosC/nDEBklRFtZ1EE6Zi+9Mxrwullsy7sBTqpcUS8rBJQJebO04Kk6CKN4X+yNTWQCX
 Kodg==
X-Gm-Message-State: AOJu0YwtGnTLuQSzc983c7SvWbEW02NQAUDV0Cz6/PnXlL8+DVBBr62k
 bw6M+9iTmKkyDTuCYPJAmYhY3ifmYi3EEiaxW/c=
X-Google-Smtp-Source: AGHT+IHEuwIfOUN2Zp4USjSaxgXIm9SJEbOEfcKgi5Ss8F8JjxBy4U+3ldJqJwMpIkrjBtpMKvgNFDE1rpoyr3NhGKM=
X-Received: by 2002:a17:906:d8:b0:99b:ca5d:1466 with SMTP id
 24-20020a17090600d800b0099bca5d1466mr8432180eji.66.1691380275180; Sun, 06 Aug
 2023 20:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230804213355.294443-1-richard.henderson@linaro.org>
 <20230804213355.294443-4-richard.henderson@linaro.org>
In-Reply-To: <20230804213355.294443-4-richard.henderson@linaro.org>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Mon, 7 Aug 2023 13:51:03 +1000
Message-ID: <CACzsE9pwF2p6y+4BWhPQdq7aD9yV2YsEfeqUROtWPbUnmQ=J8g@mail.gmail.com>
Subject: Re: [PATCH 3/7] tcg/ppc: Use prefixed instructions in tcg_out_mem_long
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, bgray@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=jniethe5@gmail.com; helo=mail-ej1-x634.google.com
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

On Sat, Aug 5, 2023 at 7:33=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> When the offset is out of range of the non-prefixed insn, but
> fits the 34-bit immediate of the prefixed insn, use that.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/ppc/tcg-target.c.inc | 66 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 7fa2a2500b..d41c499b7d 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -323,6 +323,15 @@ static bool tcg_target_const_match(int64_t val, TCGT=
ype type, int ct)
>  #define STDX   XO31(149)
>  #define STQ    XO62(  2)
>
> +#define PLWA   OPCD( 41)
> +#define PLD    OPCD( 57)
> +#define PLXSD  OPCD( 42)
> +#define PLXV   OPCD(25 * 2 + 1)  /* force tx=3D1 */
> +
> +#define PSTD   OPCD( 61)
> +#define PSTXSD OPCD( 46)
> +#define PSTXV  OPCD(27 * 2 + 1)  /* force tx=3D1 */

PSTXV calls it sx not tx


> +
>  #define ADDIC  OPCD( 12)
>  #define ADDI   OPCD( 14)
>  #define ADDIS  OPCD( 15)
> @@ -720,6 +729,20 @@ static void tcg_out_prefix_align(TCGContext *s)
>      }
>  }
>
> +/* Output Type 00 Prefix - 8-Byte Load/Store Form (8LS:D) */
> +static void tcg_out_8ls_d(TCGContext *s, tcg_insn_unit opc, unsigned rt,
> +                          unsigned ra, tcg_target_long imm, bool r)
> +{
> +    tcg_insn_unit p, i;
> +
> +    p =3D OPCD(1) | (r << 20) | ((imm >> 16) & 0x3ffff);
> +    i =3D opc | TAI(rt, ra, imm);
> +
> +    tcg_out_prefix_align(s);
> +    tcg_out32(s, p);
> +    tcg_out32(s, i);
> +}
> +
>  /* Output Type 10 Prefix - Modified Load/Store Form (MLS:D) */
>  static void tcg_out_mls_d(TCGContext *s, tcg_insn_unit opc, unsigned rt,
>                            unsigned ra, tcg_target_long imm, bool r)
> @@ -1364,6 +1387,49 @@ static void tcg_out_mem_long(TCGContext *s, int op=
i, int opx, TCGReg rt,
>          break;
>      }
>
> +    /* For unaligned or large offsets, use the prefixed form. */
> +    if (have_isa_3_10
> +        && (offset !=3D (int16_t)offset || (offset & align))
> +        && offset =3D=3D sextract64(offset, 0, 34)) {
> +        /*
> +         * Note that the MLS:D insns retain their un-prefixed opcode,
> +         * while the 8LS:D insns use a different opcode space.
> +         */
> +        switch (opi) {
> +        case LBZ:
> +        case LHZ:
> +        case LHA:
> +        case LWZ:
> +        case STB:
> +        case STH:
> +        case STW:
> +        case ADDI:
> +            tcg_out_mls_d(s, opi, rt, base, offset, 0);
> +            return;
> +        case LWA:
> +            tcg_out_8ls_d(s, PLWA, rt, base, offset, 0);
> +            return;
> +        case LD:
> +            tcg_out_8ls_d(s, PLD, rt, base, offset, 0);
> +            return;
> +        case STD:
> +            tcg_out_8ls_d(s, PSTD, rt, base, offset, 0);
> +            return;
> +        case LXSD:
> +            tcg_out_8ls_d(s, PLXSD, rt & 31, base, offset, 0);
> +            return;
> +        case STXSD:
> +            tcg_out_8ls_d(s, PSTXSD, rt & 31, base, offset, 0);
> +            return;
> +        case LXV:
> +            tcg_out_8ls_d(s, PLXV, rt & 31, base, offset, 0);
> +            return;
> +        case STXV:
> +            tcg_out_8ls_d(s, PSTXV, rt & 31, base, offset, 0);
> +            return;
> +        }
> +    }
> +
>      /* For unaligned, or very large offsets, use the indexed form.  */
>      if (offset & align || offset !=3D (int32_t)offset || opi =3D=3D 0) {
>          if (rs =3D=3D base) {
> --
> 2.34.1
>

Reviewed-by: Jordan Niethe <jniethe5@gmail.com>

