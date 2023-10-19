Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F197CEDD4
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 04:00:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtIJw-0007D0-9l; Wed, 18 Oct 2023 21:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtIJi-0007Ch-Pe
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 21:59:19 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtIJh-0002Ef-1T
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 21:59:18 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1e9c42fc0c9so3343427fac.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 18:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697680754; x=1698285554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cX3/bud83WjdvKjRkYAfLVLyRnxTDGtKBQtdYoTA9R0=;
 b=eu83pPBSxgL5iJg/Il/Qq+v0IeIUy8XAEa0SRcjTljiPzSc9z1BY6sJsByEj8nUzWY
 zVwOKS1UYAJOf8qlv/w14M0v2XawnVl2SiVGjxLxigDsdKJgEtFH2STrPVxiVDVuitIM
 9gNHi3G7+R7o9P9qAtPZvzoI3cLjm9aa7dl0vfevVuBD4tRUYEwA0cW8q5knN7hiy219
 /jhdwvZws5BLRlqDah1fjY6+LAqh+/1RzciH+YIHgyFoymxEPBzwDivH6+w0T7F1jCM1
 HkdffSrfDOLu+LsQ/ttrqJF+1T5jQTCUMpVUFVfAFQkW3DFWchbT3LInBCZNx6IVGXFy
 A2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697680754; x=1698285554;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cX3/bud83WjdvKjRkYAfLVLyRnxTDGtKBQtdYoTA9R0=;
 b=v6s7GHSv6ZfLXfQsNPIWw8G9P3KbN5g7E/ZJBiFczzqDIgn/oRa93xrMocM5lgzno5
 0V9tP2DZyuzLvNQVsyPmYD+MTRv9ZqqiPux7rfFitTouVE2sQfl+DmN3X1mCk2QP7yUp
 FFMbDXgBrmPDMLL3Sas/QBEVn2Z9jZbVuNsX1CA3xQ6joquD/DhJzQvmq1enL8WYKp6N
 zDSpsciPkTXPayOEPE3FFyIXS6A5x5DhqLcb5PEzCLI+mJy+YsoTMXyYJlMW0SOlnxWJ
 jcMS07zfklzYGqsXwiUeVxRE+EeA8LWyixYl7z83Mas3qBcN+r3hURNvzzAsJqggjl+o
 831g==
X-Gm-Message-State: AOJu0YzxbCLlg+X7vpd13jrRrkvJ4LgaIJdH2XY0NvI6JzdkyvJdI2X1
 oe2Hxps+Vb5pl3TZOdlWFodCRg==
X-Google-Smtp-Source: AGHT+IGQuRReaJBpwxyYkWP2CNHbkrWTUuSkSpTL81WRCF3CXuRHMGKodjMZeGQSPVEU1oZnM/Pirw==
X-Received: by 2002:a05:6871:10e:b0:1e9:bc79:9fa6 with SMTP id
 y14-20020a056871010e00b001e9bc799fa6mr1124892oab.50.1697680754524; 
 Wed, 18 Oct 2023 18:59:14 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a6562d2000000b005657495b03bsm2057534pgv.38.2023.10.18.18.59.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 18:59:14 -0700 (PDT)
Message-ID: <c348db12-71b3-4acd-8baf-98f2ddaf8021@linaro.org>
Date: Wed, 18 Oct 2023 18:59:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] target/i386: implement CMPccXADD
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231014100121.109817-1-pbonzini@redhat.com>
 <20231014100121.109817-9-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231014100121.109817-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/14/23 03:01, Paolo Bonzini wrote:
> +static void gen_CMPccXADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
> +{
> +    TCGv z_tl = tcg_constant_tl(0);
> +    TCGLabel *label_top = gen_new_label();
> +    TCGLabel *label_bottom = gen_new_label();
> +    TCGv oldv = tcg_temp_new();
> +    TCGv memv = tcg_temp_new();
> +    TCGv newv = tcg_temp_new();
> +    TCGv cmpv = tcg_temp_new();
> +    TCGv tmp_cc = tcg_temp_new();
> +
> +    TCGv cmp_lhs, cmp_rhs;
> +    MemOp ot, ot_full;
> +
> +    int jcc_op = (decode->b >> 1) & 7;
> +    static const uint8_t cond[16] = {

TCGCond.

> +        TCG_COND_NE,  /* o, just test OF=1 */
> +        TCG_COND_EQ,  /* no, just test OF=0 */
> +        TCG_COND_LTU, /* b */
> +        TCG_COND_GEU, /* ae (nb) */
> +        TCG_COND_EQ,  /* z */
> +        TCG_COND_NE,  /* nz */
> +        TCG_COND_LEU, /* be */
> +        TCG_COND_GTU, /* a (nbe) */
> +        TCG_COND_LT,  /* s, compares result against 0 */
> +        TCG_COND_GE,  /* ns, compares result against 0 */
> +        TCG_COND_NE,  /* p, just test PF=1 */
> +        TCG_COND_EQ,  /* np, just test PF=0 */
> +        TCG_COND_LT,  /* l */
> +        TCG_COND_GE,  /* ge (nl) */
> +        TCG_COND_LE,  /* le */
> +        TCG_COND_GT,  /* g (nle) */
> +    };

You don't need the full table here:

     cond = cond_table[jcc_op];
     if (decode->b & 1)
         cond = tcg_invert_cond(cond)


> +    /* Compute comparison result but do not clobber cc_* yet.  */
> +    switch (jcc_op) {
> +    case JCC_O:
> +    case JCC_P:
> +        tcg_gen_sub_tl(s->T0, memv, cmpv);
> +        gen_helper_cc_compute_all(tmp_cc, s->T0, cmpv, z_tl,
> +                                  tcg_constant_i32(CC_OP_SUBB + ot));
> +        decode->cc_src = tmp_cc;
> +        set_cc_op(s, CC_OP_EFLAGS);
> +
> +        tcg_gen_andi_tl(s->T0, tmp_cc, (jcc_op == JCC_O ? CC_O : CC_P));
> +        cmp_lhs = s->T0, cmp_rhs = z_tl;

I'm not keen on the weight of the helper function within a cmpxchg loop.
I think you should compute these two cases explicitly:

     JCC_O:
         // Need operands sign-extended.
         // cond_table[JCC_O] = TCG_COND_LT -- sign bit set.
         tcg_gen_xor_tl(tmp, cmpv, memv);
         tcg_gen_xor_tl(cmp_lhs, cmpv, s->T0);
         tcg_gen_and_tl(cmp_lhs, cmp_lhs, tmp);
         cmp_rhs = z_tl;
         break;

     JCC_P:
         // cond_table[JCC_P] = TCG_COND_EQ -- even parity.
         tcg_gen_ext8u_tl(cmp_lhs, s->T0);
         tcg_gen_ctpop_tl(cmp_lhs, cmp_lhs);
         tcg_gen_andi_tl(cmp_lhs, cmp_lhs, 1);
         cmp_rhs = z_tl;
         break;

> +    cc_sub:
> +        decode->cc_dst = s->T0;
> +        decode->cc_src = cmpv;
> +        decode->cc_srcT = memv;
> +        set_cc_op(s, CC_OP_SUBB + ot);
> +        break;

At which point this is common to all cases.

> +    }
> +
> +    /* Compute new value: if condition does not hold, just store back memv */
> +    tcg_gen_add_tl(newv, memv, s->T1);
> +    tcg_gen_movcond_tl(cond[decode->b & 15], newv, cmp_lhs, cmp_rhs, newv, memv);
> +    tcg_gen_atomic_cmpxchg_tl(oldv, s->A0, memv, newv, s->mem_index, ot_full);
> +
> +    /* Exit unconditionally if cmpxchg succeeded.  */
> +    tcg_gen_brcond_tl(TCG_COND_EQ, oldv, memv, label_bottom);
> +
> +    /* Try again if there was actually a store to make.  */
> +    tcg_gen_brcond_tl(cond[decode->b & 15], cmp_lhs, cmp_rhs, label_top);

I'm tempted to have this unlikely case sync the pc and exit the tb.
This would restart the current instruction after testing for exit request.

But I suppose we have plenty of other places with unbounded cmpxchg loops...


r~

