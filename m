Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 663677718E1
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 05:54:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSrJB-0000XW-SC; Sun, 06 Aug 2023 23:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qSrJ7-0000Wl-JW; Sun, 06 Aug 2023 23:53:25 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qSrJ4-0000ew-Bx; Sun, 06 Aug 2023 23:53:24 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-99c10ba30afso1092929166b.1; 
 Sun, 06 Aug 2023 20:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691380400; x=1691985200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6mB+gGctjVx336ubslyWLT6GSJEW4XW9GhpUCyShDlM=;
 b=KlBqZOIidNsgbxMVv9BgTqjT1gYcq0FBIpLV7Aood7UWclJMSzR9RixfB5ICNEKPQo
 Xw7IvE46EE0XueBVWNfLvX0YKzC2mTr6i1+4czGTI28JgguJrKiIHf866A8tDH4GRKDp
 hVN756ypQxg1+zWH8TitSt0TXZiwIbs2P2LbWYrjkRYlyvj8XNxcVVqPdqub2zEd4JEh
 lLMKQcgMIb8ZvqAdHyusYnudSisM/vbplWpDszvUnUHKjAK1A/hdqsXVombhgO+MRJ7S
 PKU7jL7FBflNfwQn07nrAUKew8JQIMDic6SfDeXlgEUfv02f7hQrPEVXWanSjoo7Vliu
 jddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691380400; x=1691985200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6mB+gGctjVx336ubslyWLT6GSJEW4XW9GhpUCyShDlM=;
 b=MQpZQEIrNvQ+x0QpB8O67dhQuUBwi95mBMetNY6SdrFK5x9S90OAxGBclQz0Bl16MQ
 iSw0sqelTmYx9sOQu1ySdsV0LM8/79JP3pXfQmpxKAfSir3nr1tnXApky+5KAh+TmhyT
 0RfHrnbr8WD0b7KWdA3l5dLeVba2tmYIc1nNzCgw19sgrA9CQ3acd2PdyWadZ7Y9pufI
 4LXdJkRql2DOz05l+p68gwWiKtX91F0nEYEkkQZhCU6gmdQaod7l0RAH+yifSVV4aAgl
 tigxXgb6LhbqXeB5SuDNe76YW2h8gYDZhsEwRNI58XR8JVH+HI61ur8SpjqYukZsZlw3
 L/kw==
X-Gm-Message-State: AOJu0YxjYaaAQBrWss3p4fqvdmFCMECJBdGSiNbc3flkuxVk8TW9Rkxl
 zIZLAcY7XgC57X8ClNzNcj+GapUcaF0f5e08rdqE/SbtZZk=
X-Google-Smtp-Source: AGHT+IFGO9NtiJS0XdiCMivGEGieya2bWif6NSF+/ib02HxZx9n7484Uv1UholQ50Bk5t+2rJGA+tt0vVdOulruZ8FQ=
X-Received: by 2002:a17:907:7638:b0:997:e9a3:9c4f with SMTP id
 jy24-20020a170907763800b00997e9a39c4fmr6226756ejc.30.1691380400307; Sun, 06
 Aug 2023 20:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230804213355.294443-1-richard.henderson@linaro.org>
 <20230804213355.294443-3-richard.henderson@linaro.org>
In-Reply-To: <20230804213355.294443-3-richard.henderson@linaro.org>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Mon, 7 Aug 2023 13:53:09 +1000
Message-ID: <CACzsE9r1w2TQ9-587g7CCZOzjE2bsnQch6Xe3LC6binDEkB1jQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] tcg/ppc: Use PADDI in tcg_out_movi
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, bgray@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=jniethe5@gmail.com; helo=mail-ej1-x62c.google.com
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
> PADDI can load 34-bit immediates and 34-bit pc-relative addresses.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/ppc/tcg-target.c.inc | 47 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 642d0fd128..7fa2a2500b 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -707,6 +707,33 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int=
 type,
>      return true;
>  }
>
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
>
> @@ -992,6 +1019,26 @@ static void tcg_out_movi_int(TCGContext *s, TCGType=
 type, TCGReg ret,
>          return;
>      }
>
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
> +        tmp =3D tcg_out_need_prefix_align(s) * 4;

tcg_out_need_prefix_align() returns a bool, optionally might prefer

tmp =3D tcg_out_need_prefix_align(s) ? 4 : 0;


> +        tmp =3D tcg_pcrel_diff(s, (void *)arg) - tmp;
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
> --
> 2.34.1
>

Reviewed-by: Jordan Niethe <jniethe5@gmail.com>

