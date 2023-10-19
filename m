Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 029217CEED6
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 06:53:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtL0h-0005XI-P1; Thu, 19 Oct 2023 00:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtL0f-0005X8-DV
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 00:51:49 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtL0d-0001eU-K1
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 00:51:49 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-581ed744114so985824eaf.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 21:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697691105; x=1698295905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jSb3yksZTOf3f7VTW9N+in5yUgegXDeeO49aeAA6ay4=;
 b=PAx1X9NRMJzJdryw8yDdDG+5kIwOteCwM/fHH8gGqE4MHPU+1SFT8xd6QW3ITdFmn8
 orK/Be3UKauSXhz7LEdrr4FEh/oBN8kThzkBNSkGL/yh7g+AfKwqC6x1HXmnguUwlVA4
 a8yUqOM1uMvZ/6kQUf2xBKXY+8SdbTt4kUTji9DhvF/1fHAw9MgTQxfJvBXLENH07J3W
 u13hRPkgXf1X/+5geghiojk7T83Dkhq0ds//zFoyOr/t7QfxUoBvT/YoXzB8ecJ8IAYB
 CK0bn9TgiCrgw1do4OCNoqxYis6QLqXm8en7wuMr8H1WSsKuByRWCNJq6oME6APH7Nn+
 Y5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697691105; x=1698295905;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jSb3yksZTOf3f7VTW9N+in5yUgegXDeeO49aeAA6ay4=;
 b=aCffpBdIYKoAh3KazXbnHeZRwRobBBotDrAIVzeF1Av+GWeyJvoZizJEgP2dJ+w09O
 g1W8KCj8eCpLgyCRKbnqRPKejhxR/3MurGVj2rldzTU7k//X6Mbg5ykf3tYb1+/0C3q6
 WgArvxrxcBkusE9ioLtGkrDBKPH9i546047MteVlhAMPmMBBmXxhDosRpZvz9NqsP7tJ
 SG/uda+BNP6ttCOrZGlMsWFvTKZ/UBOZNgUshOEgjlFx2NpK4jk3sCWWHjdsbR7njS+i
 phZ5f6JVuN6Nq87iIHapAjl/H1NIVNQ4miN1EQIb3MZSF/vU4NTTqsmcf+66yhYcHxS5
 xLHA==
X-Gm-Message-State: AOJu0YyyXRn4dY7KmueyaEkNVO5rJ8dqI9T3nc3VzTuCewYP+w4OWpRV
 af8Gz/zcz6JKSvy5Eh0nm3G4Ng==
X-Google-Smtp-Source: AGHT+IGgqps6XIzB63PtuYDMqdr3nM8hTfuIQt6tRMbOiLTyHeGFkM/KCW6l/Y4mvPTXk0IksEc33w==
X-Received: by 2002:a05:6359:6291:b0:132:dc58:b372 with SMTP id
 se17-20020a056359629100b00132dc58b372mr720737rwb.19.1697691105201; 
 Wed, 18 Oct 2023 21:51:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 y11-20020aa7942b000000b006b84ed9371esm4305660pfo.177.2023.10.18.21.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 21:51:44 -0700 (PDT)
Message-ID: <cee7b317-9ffd-4278-bf6d-66789cb93bd4@linaro.org>
Date: Wed, 18 Oct 2023 21:51:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/18] target/i386: move 60-BF opcodes to new decoder
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231014100121.109817-1-pbonzini@redhat.com>
 <20231014100121.109817-15-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231014100121.109817-15-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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
> @@ -179,6 +180,9 @@
>  #define p_66_f3_f2    .valid_prefix = P_66 | P_F3 | P_F2,
>  #define p_00_66_f3_f2 .valid_prefix = P_00 | P_66 | P_F3 | P_F2,
>  
> +static X86OpEntry illegal_opcode =
> +    X86_OP_ENTRY0(illegal);

const.

> +static void gen_ARPL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
> +{
> +    TCGLabel *label1 = gen_new_label();
> +    TCGv rpl_adj = tcg_temp_new();
> +
> +    gen_mov_eflags(s, s->tmp4);
> +    tcg_gen_andi_tl(s->tmp4, s->tmp4, ~CC_Z);
> +
> +    /* Compute dest[rpl] - src[rpl], adjust if result <0.  */
> +    tcg_gen_andi_tl(rpl_adj, s->T0, 3);
> +    tcg_gen_andi_tl(s->T1, s->T1, 3);
> +    tcg_gen_sub_tl(rpl_adj, rpl_adj, s->T1);
> +
> +    tcg_gen_brcondi_tl(TCG_COND_LT, rpl_adj, 0, label1);
> +
> +    /* Subtract dest[rpl] - src[rpl] to set dest[rpl] = src[rpl].  */
> +    tcg_gen_sub_tl(s->T0, s->T0, rpl_adj);
> +    tcg_gen_ori_tl(s->tmp4, s->tmp4, CC_Z);
> +    gen_set_label(label1);
> +
> +    decode->cc_src = s->tmp4;
> +    set_cc_op(s, CC_OP_EFLAGS);
> +}

If you're going to adjust the algorithm here,
you might as well make it branchless:

     tcg_gen_negsetcond_tl(TCG_COND_GE, mask, rpl_adj, tcg_constant_tl(0));
     tcg_gen_and_tl(rpl_adj, rpl_adj, mask);
     tcg_gen_sub_tl(t0, t0, rpl_adj);
     tcg_gen_andi_tl(mask, mask, CC_Z);
     tcg_gen_or_tl(tmp4, tmp4, mask);

> +static void gen_CBW(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
> +{
> +    switch(decode->op[0].ot) {
> +#ifdef TARGET_X86_64
> +        case MO_64:
> +            tcg_gen_ext32s_tl(s->T0, s->T0);
> +            break;
> +#endif
> +        case MO_32:
> +            tcg_gen_ext16s_tl(s->T0, s->T0);
> +            break;
> +        case MO_16:
> +            tcg_gen_ext8s_tl(s->T0, s->T0);
> +            break;
> +        default:
> +            abort();
> +    }
> +}

Reuse gen_ext_tl(t0, t0, (ot - 1) | MO_SIGN)?

> +static void gen_CWD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
> +{
> +    int shift = 8 << decode->op[0].ot;
> +    switch (shift) {
> +    case 64:
> +        break;
> +    case 32:
> +        tcg_gen_ext32s_tl(s->T0, s->T0);
> +        break;
> +    case 16:
> +        tcg_gen_ext16s_tl(s->T0, s->T0);
> +        break;
> +    default:
> +        abort();
> +    }
> +    tcg_gen_sari_tl(s->T0, s->T0, shift - 1);

Better as

   tcg_gen_sextract_tl(t0, t0, shift - 1, 1)

to just extract and replicate the one bit you wanted.


r~

