Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D558D7D81C9
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 13:30:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvyYV-0002KH-SF; Thu, 26 Oct 2023 07:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvyYS-0002Jx-RI
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 07:29:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvyYP-0003kv-Gq
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 07:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698319772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WAaJui/CXphMyWvZaot8sjnwdWrr9Dgagj4jF6uP0Ic=;
 b=VIrJ4saix7Z0CBaWaZeTEyW229ODnS5zd7Rkt4PcTdvpGBGtk7cJ1ogpywa14GSxXuB3pn
 aw+7OJKVtfoZd/N/ROjsIiMBeBRlIDGaD8JkUOlrRD5SL77zfT7QANgcnhyG3WxVRMIv3H
 u869nx9Jxa6dOrF2pWzk379KIhQbAJw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-SOEgtjwOMoCf453P155RJQ-1; Thu, 26 Oct 2023 07:29:31 -0400
X-MC-Unique: SOEgtjwOMoCf453P155RJQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41cd638a4beso11168591cf.3
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 04:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698319770; x=1698924570;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WAaJui/CXphMyWvZaot8sjnwdWrr9Dgagj4jF6uP0Ic=;
 b=INlyygwYhxBdnsLmuCEmVtEca0p4FfOztcGEacOginNRnuRKac0Ti9av6fcuEH68f0
 ajxIxugcbLANj3VfWnUNuLT9qcY4h01SVq8c8LmYhM1syiK6DCL86Rz974IEBmMs4C11
 1MhSqWqUdtWDiLQFOLh+rBiBAKPTv0ZwoUPO4dN0U7IVQ+qGC61ITOC66q6AEhCPMS/2
 NBaAdVUhSlZtGGAMHFZFEELQyBaN4f1yMrWWUkJPH8+ZqZ53Dv1Hyq5mBip4PHIitC2B
 rNbQZZzppPXgbrirzigGgG4psdHHcwyYR+IRfJWCASptYnac6k1w3a5j7HNehEFzbN9Y
 CncQ==
X-Gm-Message-State: AOJu0Yw4V83aACryHY+Q3DVpIiMk5iWEg++YKAFg0wnQY/njKG9X2k41
 LsBP8fKb8e1LofL/NAFueL3VZPFg+iiBmTAKJQZsCHQFl9KcXM/oRWZ0Oy1vMJyveZSWEdfhrob
 I4SLXDbEFamMjPho=
X-Received: by 2002:ac8:4b73:0:b0:41b:7737:d70f with SMTP id
 g19-20020ac84b73000000b0041b7737d70fmr15790675qts.0.1698319770656; 
 Thu, 26 Oct 2023 04:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS86kUx2vItUYb96PGoltFneDcMOR+dPbaljagKyKlJn5PAPkSWTj7LbCqjL1Zl+/p90CEiA==
X-Received: by 2002:ac8:4b73:0:b0:41b:7737:d70f with SMTP id
 g19-20020ac84b73000000b0041b7737d70fmr15790661qts.0.1698319770258; 
 Thu, 26 Oct 2023 04:29:30 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.googlemail.com with ESMTPSA id
 cm26-20020a05622a251a00b0041519614354sm4980097qtb.7.2023.10.26.04.29.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Oct 2023 04:29:29 -0700 (PDT)
Message-ID: <1189a017-7cad-45c8-9eb6-5ed6eb8425d2@redhat.com>
Date: Thu, 26 Oct 2023 13:29:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/29] tcg/i386: Support TCG_COND_TST{EQ,NE}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
 <20231026001542.1141412-27-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20231026001542.1141412-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/26/23 02:14, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Also, a TST{EQ,NE} with a one-bit immediate argument can be changed to:

- a TEST reg, reg + js/jns (or sets/setns, or cmovs/cmovns) when testing 
bits 7, 15 or 31

- a BT reg, imm + jc/jnc (or setc/setnc, or cmovc/cmovnc) when testing 
other bits in the 8..63 range.

I will take a look at using this to get rid of the mask field in 
CCPrepare, but I would not mind if someone else took a look at these 
code generation optimizations in tcg/i386.

Paolo

>   tcg/i386/tcg-target.c.inc | 43 +++++++++++++++++++++++++++------------
>   1 file changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index f4f456a2c0..0d97864174 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -504,6 +504,8 @@ static const uint8_t tcg_cond_to_jcc[] = {
>       [TCG_COND_GEU] = JCC_JAE,
>       [TCG_COND_LEU] = JCC_JBE,
>       [TCG_COND_GTU] = JCC_JA,
> +    [TCG_COND_TSTEQ] = JCC_JE,
> +    [TCG_COND_TSTNE] = JCC_JNE,
>   };
>   
>   #if TCG_TARGET_REG_BITS == 64
> @@ -1419,12 +1421,14 @@ static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, bool small)
>   }
>   
>   /* Test register R vs immediate bits I, setting Z flag for EQ/NE. */
> -static void __attribute__((unused))
> -tcg_out_testi(TCGContext *s, TCGReg r, uint32_t i, int rexw)
> +static void tcg_out_testi(TCGContext *s, TCGReg r, uint32_t i, int rexw)
>   {
>       if (i <= 0xff && (TCG_TARGET_REG_BITS == 64 || r < 4)) {
>           tcg_out_modrm(s, OPC_GRP3_Eb | P_REXB_RM, EXT3_TESTi, r);
>           tcg_out8(s, i);
> +    } else if ((i & ~0xff00) == 0 && r < 4) {
> +        tcg_out_modrm(s, OPC_GRP3_Eb, EXT3_TESTi, r);
> +        tcg_out8(s, i >> 8);
>       } else {
>           tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_TESTi, r);
>           tcg_out32(s, i);
> @@ -1434,15 +1438,25 @@ tcg_out_testi(TCGContext *s, TCGReg r, uint32_t i, int rexw)
>   static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
>                          TCGArg arg2, int const_arg2, int rexw)
>   {
> -    if (const_arg2) {
> -        if (arg2 == 0) {
> -            /* test r, r */
> +    if (is_tst_cond(cond)) {
> +        if (!const_arg2) {
> +            tcg_out_modrm(s, OPC_TESTL + rexw, arg1, arg2);
> +        } else {
> +            if (!rexw) {
> +                arg2 = (uint32_t)arg2;
> +            } else if ((arg2 >> 31 >> 1) == 0) {
> +                rexw = 0;
> +            }
> +            tcg_out_testi(s, arg1, arg2, rexw);
> +        }
> +    } else {
> +        if (!const_arg2) {
> +            tgen_arithr(s, ARITH_CMP + rexw, arg1, arg2);
> +        } else if (arg2 == 0) {
>               tcg_out_modrm(s, OPC_TESTL + rexw, arg1, arg1);
>           } else {
>               tgen_arithi(s, ARITH_CMP + rexw, arg1, arg2, 0);
>           }
> -    } else {
> -        tgen_arithr(s, ARITH_CMP + rexw, arg1, arg2);
>       }
>       return tcg_cond_to_jcc[cond];
>   }
> @@ -1461,18 +1475,21 @@ static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
>   {
>       TCGLabel *label_next = gen_new_label();
>       TCGLabel *label_this = arg_label(args[5]);
> +    TCGCond cond = args[4];
>   
> -    switch(args[4]) {
> +    switch (cond) {
>       case TCG_COND_EQ:
> -        tcg_out_brcond(s, 0, TCG_COND_NE, args[0], args[2], const_args[2],
> -                       label_next, 1);
> -        tcg_out_brcond(s, 0, TCG_COND_EQ, args[1], args[3], const_args[3],
> +    case TCG_COND_TSTEQ:
> +        tcg_out_brcond(s, 0, tcg_invert_cond(cond),
> +                       args[0], args[2], const_args[2], label_next, 1);
> +        tcg_out_brcond(s, 0, cond, args[1], args[3], const_args[3],
>                          label_this, small);
>           break;
>       case TCG_COND_NE:
> -        tcg_out_brcond(s, 0, TCG_COND_NE, args[0], args[2], const_args[2],
> +    case TCG_COND_TSTNE:
> +        tcg_out_brcond(s, 0, cond, args[0], args[2], const_args[2],
>                          label_this, small);
> -        tcg_out_brcond(s, 0, TCG_COND_NE, args[1], args[3], const_args[3],
> +        tcg_out_brcond(s, 0, cond, args[1], args[3], const_args[3],
>                          label_this, small);
>           break;
>       case TCG_COND_LT:


