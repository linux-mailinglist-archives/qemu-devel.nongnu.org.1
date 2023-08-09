Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B00477598F
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 13:01:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTgw7-0000L5-V5; Wed, 09 Aug 2023 07:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTgvo-0000F6-Nz; Wed, 09 Aug 2023 07:00:48 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTgvm-0004Z6-5m; Wed, 09 Aug 2023 07:00:47 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bbc06f830aso5957035ad.0; 
 Wed, 09 Aug 2023 04:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691578844; x=1692183644;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xlUfGFbwLSQv7XY08XTUEgOIXxo32feQQQgOuigBAaY=;
 b=pniQGJr/yILkp2qG6B4NGp5rAJPnWSBXM4SZQ7vw0/w61qH9sbLzY87jN6Ls0Yzv9Q
 cWTkT8qAA/ZLrvEWaZgv9c0FOpbhdVgVNzdCwZsUNH/kWFPGzgSxw5rwJx0zN1KkWbRe
 MlWsitXSdKCGneSLb1LaNUdiLveFKxPod9SCrArgxTWcOsNjv9DUdroMWgY0mGgc0Q5b
 fVwTleDlMkL3lLk0P/tUU5GVw6Qb6Y9wpbfzi9NnkNTqOeo3s62kOHoXbSz4U7aorLib
 Rt4CRQogTJZcME00a8VqzNsxYpcYBsgazoHpO7ZGv6eKcbIjmLFJzHBEK03NeCiWv+7a
 hqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691578844; x=1692183644;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xlUfGFbwLSQv7XY08XTUEgOIXxo32feQQQgOuigBAaY=;
 b=Z71SAAnxdMOsAmto0JZQ8VOuu9EMpVq9EiYgPihICUa3ln3guU+xk8jfcJAsx+exJ5
 2GzMtxCV25X/ge/90t/rdsZYCjrzdl5VgAMfkrWDBg0/TaTcJTAZVIoKJPSHLgLUaRyx
 V9HFyjJqmzatINIjLUaXgwCKq6x6tI1Lu0s7+sBuwzKB2vfIideOPKQ795UyTPEvu47a
 ap3RdoT9CNH2eXoAal6UFcbxH7bBy/eS2Dh3GmMcGpQlvJEk9/bboFvKmCbJgo/Ogyuh
 O1XLK3GtDqLRk7J+M/x/TdrP9a073/PgQm/ICxYeu0w5IYWGGAj8xEEZjszZcBJnlbQt
 EfmA==
X-Gm-Message-State: AOJu0YxK3JUkMfwhrsQvSigI3FSHbLIytwkvNjVRidsTMEJoBO2JR5PL
 8Cu68ngaIevvxbrKPhDqwNw=
X-Google-Smtp-Source: AGHT+IGtUk7EutSw6oagFGIawcxinKjjSn9uaAFFRJPdOS3H8vyroNSdycodMVPEW6GZ73sMg+TieQ==
X-Received: by 2002:a17:902:d491:b0:1b0:3ab6:5140 with SMTP id
 c17-20020a170902d49100b001b03ab65140mr3366840plg.4.1691578844081; 
 Wed, 09 Aug 2023 04:00:44 -0700 (PDT)
Received: from localhost (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 l7-20020a170902f68700b001b89f6550d1sm10849789plg.16.2023.08.09.04.00.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 04:00:43 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Aug 2023 21:00:39 +1000
Message-Id: <CUNYNIVKCB1U.2Q6WCY073ER5L@wheely>
Cc: <jniethe5@gmail.com>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v2 3/7] tcg/ppc: Use prefixed instructions in
 tcg_out_mem_long
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230808030250.50602-1-richard.henderson@linaro.org>
 <20230808030250.50602-4-richard.henderson@linaro.org>
In-Reply-To: <20230808030250.50602-4-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Aug 8, 2023 at 1:02 PM AEST, Richard Henderson wrote:
> When the offset is out of range of the non-prefixed insn, but
> fits the 34-bit immediate of the prefixed insn, use that.
>

The switch will fall through in some cases (at least opi =3D=3D 0).
Should it have a default: break; to make that obvious?

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Reviewed-by: Jordan Niethe <jniethe5@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/ppc/tcg-target.c.inc | 66 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 2141c0bc78..61ae9d8ab7 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -323,6 +323,15 @@ static bool tcg_target_const_match(int64_t val, TCGT=
ype type, int ct)
>  #define STDX   XO31(149)
>  #define STQ    XO62(  2)
> =20
> +#define PLWA   OPCD( 41)
> +#define PLD    OPCD( 57)
> +#define PLXSD  OPCD( 42)
> +#define PLXV   OPCD(25 * 2 + 1)  /* force tx=3D1 */
> +
> +#define PSTD   OPCD( 61)
> +#define PSTXSD OPCD( 46)
> +#define PSTXV  OPCD(27 * 2 + 1)  /* force sx=3D1 */
> +
>  #define ADDIC  OPCD( 12)
>  #define ADDI   OPCD( 14)
>  #define ADDIS  OPCD( 15)
> @@ -725,6 +734,20 @@ static ptrdiff_t tcg_pcrel_diff_for_prefix(TCGContex=
t *s, const void *target)
>      return tcg_pcrel_diff(s, target) - (tcg_out_need_prefix_align(s) ? 4=
 : 0);
>  }
> =20
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
> @@ -1368,6 +1391,49 @@ static void tcg_out_mem_long(TCGContext *s, int op=
i, int opx, TCGReg rt,
>          break;
>      }
> =20
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


