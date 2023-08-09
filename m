Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B01775616
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 11:04:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTf6f-0003gh-De; Wed, 09 Aug 2023 05:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTf6d-0003gJ-HY; Wed, 09 Aug 2023 05:03:51 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTf6b-0006zf-PB; Wed, 09 Aug 2023 05:03:51 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bbc87ded50so42780545ad.1; 
 Wed, 09 Aug 2023 02:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691571828; x=1692176628;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFMIESJghnjF1y0UXa6qHG7uij1ZxpDKI7QxOD2x2RY=;
 b=D1dstaCTTSHCcXr3E6OmtKWHXacc1QHHOiUbRW5E90b4rWi+qjPWXDpUEah0OaqChk
 n9VBF+OTuXmzOEB9UBJhOCsHnivDv/htYghLfqJat3b4qXDUL4cO5KaxzTwr8LVsPsgE
 6g6ukipaQTNCM7TzLjD+OD5O+vM4gIcaHY6DP5nr+7e36Q0Y/qA9SyCn/l3PcpbeOnpw
 +FDbWN22sNB7FL4rSddMWsOO2rtXc9m/fPcRc3dHp1qhiJCGfVpWi+/jxmLK0+VqVj/e
 yV2t4OsUBEyBS4lyL507pDVOqZgp9Ez3zoXdFeE+N8Ag8YX7q1y1/qiroGb2yO9xeb1a
 tUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691571828; x=1692176628;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lFMIESJghnjF1y0UXa6qHG7uij1ZxpDKI7QxOD2x2RY=;
 b=LFl88NUXWHv1Un92nQ/TmRqNIE+rOtWHtxBXRdi/RIDp4KmMfv8BupdwbCqI34+UdW
 pNAPOuMg3GDC7Bs9UrpvdEwOVJludXb+QwQ3vHvRbp1hlkwKfrCVcn2aC3tt9k0uB+Y8
 YF5uJlmXEhRliak4ob7mx4rMI9XlyZ3iZeDbaKc6zlFXVErYC6lFZNLFPIHnwjbIwkr/
 J44r15j1/qyndWouz4D7P3qmrH69/DRRqn8/wxhbtxV4aYsrd0MKoApLuztHavFv8VZ+
 4vc+WA+1TKlQ3yz+FG08gNRR6epxdMayb79v1k/pYl+1+5LU6jVJiyBhwlY/SVGqR9Vt
 RQ5g==
X-Gm-Message-State: AOJu0YzYzdZDPW7BkWQIcJcrQGifEnIzDIcv6YcY2SnSA/uJ/xrDmNmL
 9hH4UmGy5p0pXauyaIrKSPE=
X-Google-Smtp-Source: AGHT+IF0AnDuFI9BnC9zYEKv2cU+cqk9S025iqC8Gm2/NFocXG9aeDhRBSpnCnYoRvnz3WFssLEROA==
X-Received: by 2002:a17:903:228b:b0:1b1:9218:6bf9 with SMTP id
 b11-20020a170903228b00b001b192186bf9mr2084193plh.43.1691571827979; 
 Wed, 09 Aug 2023 02:03:47 -0700 (PDT)
Received: from localhost (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a170902a38f00b001bbdf32f011sm8489025pla.269.2023.08.09.02.03.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 02:03:47 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Aug 2023 19:03:43 +1000
Message-Id: <CUNW5ZQWZ32V.3MXWUU3X0QI8O@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
Cc: <jniethe5@gmail.com>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v2 2/7] tcg/ppc: Use PADDI in tcg_out_movi
X-Mailer: aerc 0.15.2
References: <20230808030250.50602-1-richard.henderson@linaro.org>
 <20230808030250.50602-3-richard.henderson@linaro.org>
In-Reply-To: <20230808030250.50602-3-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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
> PADDI can load 34-bit immediates and 34-bit pc-relative addresses.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Reviewed-by: Jordan Niethe <jniethe5@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/ppc/tcg-target.c.inc | 51 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 642d0fd128..2141c0bc78 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -707,6 +707,38 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int=
 type,
>      return true;
>  }
> =20
> +/* Ensure that the prefixed instruction does not cross a 64-byte boundar=
y. */
> +static bool tcg_out_need_prefix_align(TCGContext *s)
> +{
> +    return ((uintptr_t)s->code_ptr & 0x3f) =3D=3D 0x3c;
> +}
> +
> +static void tcg_out_prefix_align(TCGContext *s)
> +{
> +    if (tcg_out_need_prefix_align(s)) {
> +        tcg_out32(s, NOP);
> +    }
> +}
> +
> +static ptrdiff_t tcg_pcrel_diff_for_prefix(TCGContext *s, const void *ta=
rget)
> +{
> +    return tcg_pcrel_diff(s, target) - (tcg_out_need_prefix_align(s) ? 4=
 : 0);
> +}
> +
> +/* Output Type 10 Prefix - Modified Load/Store Form (MLS:D) */
> +static void tcg_out_mls_d(TCGContext *s, tcg_insn_unit opc, unsigned rt,
> +                          unsigned ra, tcg_target_long imm, bool r)
> +{
> +    tcg_insn_unit p, i;
> +
> +    p =3D OPCD(1) | (2 << 24) | (r << 20) | ((imm >> 16) & 0x3ffff);
> +    i =3D opc | TAI(rt, ra, imm);
> +
> +    tcg_out_prefix_align(s);
> +    tcg_out32(s, p);
> +    tcg_out32(s, i);
> +}
> +
>  static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
>                               TCGReg base, tcg_target_long offset);
> =20
> @@ -992,6 +1024,25 @@ static void tcg_out_movi_int(TCGContext *s, TCGType=
 type, TCGReg ret,
>          return;
>      }
> =20
> +    /*
> +     * Load values up to 34 bits, and pc-relative addresses,
> +     * with one prefixed insn.
> +     */
> +    if (have_isa_3_10) {
> +        if (arg =3D=3D sextract64(arg, 0, 34)) {
> +            /* pli ret,value =3D paddi ret,0,value,0 */
> +            tcg_out_mls_d(s, ADDI, ret, 0, arg, 0);
> +            return;
> +        }
> +
> +        tmp =3D tcg_pcrel_diff_for_prefix(s, (void *)arg);
> +        if (tmp =3D=3D sextract64(tmp, 0, 34)) {
> +            /* pla ret,value =3D paddi ret,0,value,1 */
> +            tcg_out_mls_d(s, ADDI, ret, 0, tmp, 1);
> +            return;
> +        }
> +    }
> +
>      /* Load 32-bit immediates with two insns.  Note that we've already
>         eliminated bare ADDIS, so we know both insns are required.  */
>      if (TCG_TARGET_REG_BITS =3D=3D 32 || arg =3D=3D (int32_t)arg) {


