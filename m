Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D83AD82DA8F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 14:52:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPNN7-0001R1-0D; Mon, 15 Jan 2024 08:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPNN5-0001Qh-2K
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 08:51:23 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPNN3-0004Ln-A2
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 08:51:22 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d542701796so44489145ad.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 05:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705326679; x=1705931479; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e47Fu5ywruR4ZSqWpk1+f3zWbQAx8wY2UlVJ5JiAUMg=;
 b=QvW1+fAcwEIiH20oMH4fOo6B9wbt1H4HGu6K+twqVB4PWNfTPFer9YQLr8bDU8L2L1
 ET1LHq/fWAcWk7Tsel3izYwTSu4Bv1r2RIS09idVn7Q/736SSewAwbgwVx4MGqDIUHk/
 HDu6PzzOeOa7Cri4ssPWGeM/K8zQjqA1vVSlrKc9sWzcZYM6NeW+uwHvmj4Z3ky96htC
 jBX+uM7J1BywfsRGmbEwKZdAaP+m44XkhK9ha8TbvyXFeIez2+CumISeVR6FcXZn9VRZ
 a6GXn1Uq1daPpMUyxHl4Be7kz6+pOXTqYBBL6Ust46yD7/SaEY2F3XA5tpdGpNn5N0oz
 b2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705326679; x=1705931479;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e47Fu5ywruR4ZSqWpk1+f3zWbQAx8wY2UlVJ5JiAUMg=;
 b=e5FZmWMGepgoP+oDacrQIZBMURNeqN+Y2hR8VTDrzmoKMQHiDaFZL0bNYT7uV0gNYf
 JpG6uRSsqjrKt4qU4IBiLLDJX6TBv2y5qijtdtcKRpVG55e1+cot77so0a9zhwr4U80n
 JMXwARlxFTBIsjmnJ7tn/hcp5NYZk3BC5HP6oLqZm8KHfXu66Fj7Rru4fuwEt7M4iWbJ
 GQQZTmkRi+gTA9w1MtYyfxRO/hS4RxTm1en5yEewHeedUcEXVB0KjjdL5hxh+m+hpXoT
 eWjO3gE6xXcHsYTfCv43CsW0LxmJyWlB6ZBm1yezazDboCo96fen/kqHV6dNRB/B1Wvn
 hOyQ==
X-Gm-Message-State: AOJu0Ywj+graTY3mACBX2R7Tb7pm0U+2CqHyaQbq4u24xGDLwbmK98Ya
 2QvWEJ/pxKl2FqV1tjJo7Sy7lmTJ0cxYyw==
X-Google-Smtp-Source: AGHT+IF8LvwC1ytklC4KrjVWcrAUMFIaFTr5Uq/ESNjN2ffdh/UOAbBjA1Q75MRD3/XFBPIrnR05EA==
X-Received: by 2002:a17:90a:cf04:b0:28e:2060:6f72 with SMTP id
 h4-20020a17090acf0400b0028e20606f72mr1477979pju.80.1705326679433; 
 Mon, 15 Jan 2024 05:51:19 -0800 (PST)
Received: from [192.168.68.110] ([152.234.123.64])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a170903009300b001d5d6db7bcdsm737930pld.194.2024.01.15.05.51.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 05:51:18 -0800 (PST)
Message-ID: <0e05fc12-c035-4e87-89fb-2fa35173e38e@ventanamicro.com>
Date: Mon, 15 Jan 2024 10:51:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] target/riscv/insn_trans/trans_rvv.c.inc: use
 'vlenb' in MAXSZ()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240112213812.173521-1-dbarboza@ventanamicro.com>
 <20240112213812.173521-11-dbarboza@ventanamicro.com>
 <fd99b822-16e5-44be-b314-ed986291e877@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <fd99b822-16e5-44be-b314-ed986291e877@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 1/12/24 19:45, Richard Henderson wrote:
> On 1/13/24 08:38, Daniel Henrique Barboza wrote:
>> MAXSZ() returns the value in bytes. Now that we have access to vlenb
>> we don't need to compensate with a '-3' in the scale to use 'vlen'.
>>
>> MAXSZ() now works as follows:
>>
>> LMUL  lmul=scale  MAXSZ (vlenb >> -scale)
>>    1       0       vlenb
>>    2       1       vlenb << 1
>>    4       2       vlenb << 2
>>    8       3       vlenb << 3
> 
> Um, what?
> 
>>   static inline uint32_t MAXSZ(DisasContext *s)
>>   {
>> -    int scale = s->lmul - 3;
>> -    return s->cfg_ptr->vlen >> -scale;
>> +    return s->cfg_ptr->vlenb >> -s->lmul;
> 
> There's no left-shift here, either before or after.
> Bug?

Yeah, I got lost in that explanation. I'll simplify it to be just a simple case of
adjusting the right shift to use vlenb like in patches 8 and 9.


Thanks,


Daniel



> 
> 
> r~

