Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3350B7E5FF1
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 22:28:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0q5T-0000ke-Fq; Wed, 08 Nov 2023 16:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0q5Q-0000kV-LG
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 16:27:44 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0q5N-000467-PQ
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 16:27:44 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc5b705769so1159535ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 13:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699478860; x=1700083660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WT0wU+vt3U5ZyynVi1Z2W5B1gepy1UvcUIylTrXjxWY=;
 b=uduUMxOCZSSELraWuBB6lQyz8R5SzIXfPnEa8ME31gk907XAINvcPOhmxet05ZK3Fk
 7tdgQSQNh54qo4E2Sm3AyHm+GKwD/6gqo7NlMZLtAAfZ1pRSEjutnFiA0Xdh24SDPW25
 yB1rgC4ZufNFM88Fic9VT0v9zhXchajXBEZi5CxFYAlJERbELT/BxDjizBg3l+ZotS1O
 Xnwfj0Cmti/vQkMYMIL4VXWk73y/aisAQJQyUsc1Zmbq+DM51ftFWAUaT/IyHN4BJZr1
 Wu0mCPUp18h2w/Wd126RtSKfE63msy2Srx9Pz4+56pUJeOc5pmvZBld4Lr6JYrbF5wk1
 4eHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699478860; x=1700083660;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WT0wU+vt3U5ZyynVi1Z2W5B1gepy1UvcUIylTrXjxWY=;
 b=lDsOynTTLlFR71ScMaxCNujmfmxae3RoxZOyZXnlRYIY4N+G3RZ4TJ/P00+Hx6evoq
 rEpfkQ4BUzHcrtxm+sAayFVO02MSU4OWALN1zVPNIwLpAVdxQjwc3TidCZibJCrgT76d
 ZpN9n/KDULOMaEFKILpMHd4HfNM2wWK5fqHhGO1qX8AaZEH79e2hjGqVWYGDu9ul5jN0
 FhfpQf0F9mAo6IG99cxb4zXE7MBIOu+FtxRA0k89QO7p/guPGJH902dBiplLjqp0RcQz
 cn+EJjiRRu/bFEhEbDnrW88Ix/jPHSD4vJ8w8cwHhawq9qTRSLFaKAFB/DOfa/RoW5Eh
 0Ylg==
X-Gm-Message-State: AOJu0Yxs3DS4ZKOSpxOG8KjOPW/Tw0yZW65Pg6Z2y5AjpKqpaVyEXxWw
 KHwHKFgxyg+vt1sMLr6jq4buXA==
X-Google-Smtp-Source: AGHT+IFZxS4kGcHhPjrP5o5bSpgQV67NGNd21PmECZbFlFjq+SckIQoMksMS/ftTwFIczfNhIDCGtA==
X-Received: by 2002:a17:902:f54a:b0:1c6:117b:7086 with SMTP id
 h10-20020a170902f54a00b001c6117b7086mr4043889plf.5.1699478860013; 
 Wed, 08 Nov 2023 13:27:40 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a170902b7c900b001ca4cc783b6sm2155045plz.36.2023.11.08.13.27.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 13:27:39 -0800 (PST)
Message-ID: <98c4f705-9b61-4247-ab45-8decb258afd7@linaro.org>
Date: Wed, 8 Nov 2023 13:27:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/35] tcg/ppc: Support TCG_COND_TST{EQ,NE}
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-28-richard.henderson@linaro.org>
 <6a4a2205-9abc-45d6-9c6b-f8d94d838e77@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6a4a2205-9abc-45d6-9c6b-f8d94d838e77@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/8/23 12:40, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 28/10/23 21:45, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/ppc/tcg-target.c.inc | 105 ++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 98 insertions(+), 7 deletions(-)
> 
> 
>> -static inline void tcg_out_rld(TCGContext *s, int op, TCGReg ra, TCGReg rs,
>> -                               int sh, int mb)
>> +static void tcg_out_rld_rc(TCGContext *s, int op, TCGReg ra, TCGReg rs,
>> +                           int sh, int mb, bool rc)
>>   {
>>       tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
>>       sh = SH(sh & 0x1f) | (((sh >> 5) & 1) << 1);
>>       mb = MB64((mb >> 5) | ((mb << 1) & 0x3f));
>> -    tcg_out32(s, op | RA(ra) | RS(rs) | sh | mb);
>> +    tcg_out32(s, op | RA(ra) | RS(rs) | sh | mb | rc);
>>   }
>> -static inline void tcg_out_rlw(TCGContext *s, int op, TCGReg ra, TCGReg rs,
>> -                               int sh, int mb, int me)
>> +static void tcg_out_rld(TCGContext *s, int op, TCGReg ra, TCGReg rs,
>> +                        int sh, int mb)
>> +{
>> +    tcg_out_rld_rc(s, op, ra, rs, sh, mb, false);
>> +}
>> +
>> +static void tcg_out_rlw_rc(TCGContext *s, int op, TCGReg ra, TCGReg rs,
>> +                           int sh, int mb, int me, bool rc)
>>   {
>>       tcg_out32(s, op | RA(ra) | RS(rs) | SH(sh) | MB(mb) | ME(me));
> 
> Here I'm a bit confused because 'rc' is not used. Shouldn't we OR it
> to tcg_out32()' second argument?

Yep, should be just like rld_rc above.


r~

