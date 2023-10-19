Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B2A7CEE69
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 05:26:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtJea-0003au-IV; Wed, 18 Oct 2023 23:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtJeY-0003ai-8V
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 23:24:54 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtJeV-0003DT-15
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 23:24:52 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68fb85afef4so6224353b3a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 20:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697685888; x=1698290688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CHt4ISBhiMSz+C7HCZi0CqPzwnOAsGqnGvkFd9wHQFQ=;
 b=d5LmW3vGjg3csiU1kxeTl1Ykb2vMj3aBQwrQoMGSWhfPB/qTx7OD1GKVmGDljZ51dn
 S48TmCVSTpemEQHPWwDk6IKlhdlpejjas0IpfqTl8MlH4N3D2khrMg2Rmo9nmsvzWlxq
 zTEkAsnEhLeTjrVbUVqMx4nHwbRTtgAGDiReRXnS6jU6pxpMjaCmBIxcp++2bSySQLod
 7JfOgz49FqKRVy4MUxNkbbc4g3M8R0uHT2rWt83/z/OXdo4yKCVwfmCSbo9jIVj2Sraa
 +4jVEUiNjraR4qpfQXQzEQF36XSRBMtnGTgNXeMZ0kzA0KzYKeb3gLdUwWuo6UOqpzqa
 aYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697685888; x=1698290688;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CHt4ISBhiMSz+C7HCZi0CqPzwnOAsGqnGvkFd9wHQFQ=;
 b=U1OB+5rN4kxRNFBAIZv6x+lFTYkuuqnOkvXpP3+BKBXukhg1qNTyA9Xdw0rdKRuOQ9
 0KYc4e+l6jFzdvmDCggatBKe7WR9L4stP5bELFXeRpunwZJ2hslHFy3JTbq4XVPXvzTp
 Dgq37q6OhmVAr/Yut+Xm5VQW437OsRxK827UkeRZi0WT+o0ibkx/u8VnQiL05RlgOibh
 D9wFLQMA4XNbwLmrCwr8PiNj+Ku5L4bHLloeWRGK12lv94lCooZotAiZY+CeFlevntij
 tDKyff6+TFwS1tIWvhIwnKL28qMBWPLY/TDkIxSRoUqJgDThwnj/S4UNZ+4Dt9Ejnc7F
 nmFQ==
X-Gm-Message-State: AOJu0Yxh25mlZFxxQFgBDqg4VZ82jIGRgnA5Xx1tJT1fT4w2BkOWxyhK
 rXwd+a3cHQRbbQ4c+G0bc82XUg==
X-Google-Smtp-Source: AGHT+IEaNzgzum7vs9Q9nKFMicoiuGWNwb1re4XbSdCpmuCwT1uBUluGr8hNIfU7xsQlVhMF8JxKcA==
X-Received: by 2002:a05:6a00:230c:b0:6bc:c242:7915 with SMTP id
 h12-20020a056a00230c00b006bcc2427915mr971316pfh.28.1697685888329; 
 Wed, 18 Oct 2023 20:24:48 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a056a0000c600b00690c0cf97c9sm4054612pfj.73.2023.10.18.20.24.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 20:24:47 -0700 (PDT)
Message-ID: <81bf8e5a-5d94-4037-b5e5-468d94823369@linaro.org>
Date: Wed, 18 Oct 2023 20:24:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] target/i386: move 00-5F opcodes to new decoder
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231014100121.109817-1-pbonzini@redhat.com>
 <20231014100121.109817-12-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231014100121.109817-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
> +    [0x28] = X86_OP_ENTRY2(SUB, E,b, G,b),
> +    [0x29] = X86_OP_ENTRY2(SUB, E,v, G,v),
> +    [0x2A] = X86_OP_ENTRY2(SUB, G,b, E,b),
> +    [0x2B] = X86_OP_ENTRY2(SUB, G,v, E,v),
> +    [0x2C] = X86_OP_ENTRY2(SUB, 0,b, I,b),   /* AL, Ib */
> +    [0x2D] = X86_OP_ENTRY2(SUB, 0,v, I,z),   /* rAX, Iz */
> +    [0x2E] = {},
> +    [0x2F] = X86_OP_ENTRY0(DAS, chk(i64)),
> +
> +    [0x38] = X86_OP_ENTRY2(SUB, E,b, G,b, nowb),
> +    [0x39] = X86_OP_ENTRY2(SUB, E,v, G,v, nowb),
> +    [0x3A] = X86_OP_ENTRY2(SUB, G,b, E,b, nowb),
> +    [0x3B] = X86_OP_ENTRY2(SUB, G,v, E,v, nowb),
> +    [0x3C] = X86_OP_ENTRY2(SUB, 0,b, I,b, nowb),   /* AL, Ib */
> +    [0x3D] = X86_OP_ENTRY2(SUB, 0,v, I,z, nowb),   /* rAX, Iz */
> +    [0x3E] = {},
> +    [0x3F] = X86_OP_ENTRY0(AAS, chk(i64)),
...
> +    case X86_SPECIAL_NoWriteback:
> +        decode.op[0].unit = X86_OP_SKIP;
> +        break;
...
> +static void gen_SUB(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
> +{
> +    MemOp ot = decode->op[0].ot;
> +
> +    if (s->prefix & PREFIX_LOCK) {
> +        tcg_gen_neg_tl(s->T0, s->T1);
> +        tcg_gen_atomic_fetch_add_tl(s->cc_srcT, s->A0, s->T0,
> +                                    s->mem_index, ot | MO_LE);
> +        tcg_gen_sub_tl(s->T0, s->cc_srcT, s->T1);
> +    } else {
> +        tcg_gen_mov_tl(s->cc_srcT, s->T0);
> +        tcg_gen_sub_tl(s->T0, s->T0, s->T1);
> +    }
> +    prepare_update2_cc(decode, s, CC_OP_SUBB + ot);
> +}

Missing a check for CMP vs PREFIX_LOCK.
I'm not sure where the best place to put that.
Whether you use a chk bit or simply hard-code a check for (!lock || !skip).


r~

