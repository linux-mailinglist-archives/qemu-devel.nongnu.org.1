Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3CA7DBC9D
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 16:31:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxUDw-0002hl-2M; Mon, 30 Oct 2023 11:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxUDr-0002gO-Rn
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 11:30:36 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxUDp-00069r-Of
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 11:30:35 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6bee11456baso3888398b3a.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 08:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698679830; x=1699284630; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8DhNTIjIgRqyh4EIsou1Im9R8QAMhxUaERk8pbryK04=;
 b=Jhca49tFVQw3sEymlDhXXzZAiipHcN+gNktvxeyJztR0DBw3ts4LioFH4GB6vMlwBk
 mytoXB6ChyaAWUObr75528SG0yTRzjyEZnXeS2JP8pQltdMlUDFC4COxZaWu27Rj3a4V
 LDa0vfAJcuTPgZYZ70/lwEd2AF4RbqO+NfdOKCD4tn+3qZQ/rh+Ex8lYPE3/7ARdxMiF
 PR/T0/y+pI1GNBwFK00TeG4R1RAwfrKtkm/Fqgaoavcbvdu4Cz2Na4Q/7WxsjFAeYaXw
 szy77QpawlRj09bbzmlv8SpSHzlprE/bvstyqrWtWh8Uc5MS2sOKHMBm+lHapBYDblEU
 rHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698679830; x=1699284630;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8DhNTIjIgRqyh4EIsou1Im9R8QAMhxUaERk8pbryK04=;
 b=Q0/O/YhOFlesDzpAJqe87/1qmFsPN59AsxSvqd8P9nBc1whG5hDkdw1GAIXyFeiS+D
 yoPAqkkf9qpEtT873LrOLx1nj3L+QIlu5xnke9nZT+Nlfa8OtOCiX9Z60XXAq6LjTEru
 kwFMiJYp+BpX5kx9HfELoDHp4u584aDtDH4HduWdaKbrLxe896kPKQ6AtqMghrDh6iEv
 Jkvfw0qvMoJtj2T7sjqizHEFGXJPIytWgSxhEHTBMl/qKN7S8UgaPl1D8L1hswnYVhB6
 2ljNHq4dQMeaVdYw85d2G4Ianq6wTCGZGQ1qoxM28LaGD1P/b/gDz9XTibui+jl5Yf5c
 6aPw==
X-Gm-Message-State: AOJu0Ywa5Lh5uu+O01VkjlVwLw78nZg8p/nsJQgMHUdHifWvXW0qgPZB
 Eozurkg2htUF9ciKvS45SeSCUg==
X-Google-Smtp-Source: AGHT+IHOOlCPTLdhWK42MF+xEP1UAK/d64fz0h0TwT/jgaonoRl9rslnuU2ul5FnZ9HKakJjAY/PaQ==
X-Received: by 2002:a05:6a20:12d5:b0:14b:8b82:867f with SMTP id
 v21-20020a056a2012d500b0014b8b82867fmr8570072pzg.50.1698679830462; 
 Mon, 30 Oct 2023 08:30:30 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 s25-20020aa78299000000b006933f85bc29sm5983268pfm.111.2023.10.30.08.30.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 08:30:30 -0700 (PDT)
Message-ID: <c43b9404-fd99-4f8a-9e35-62f5a4e50b5b@linaro.org>
Date: Mon, 30 Oct 2023 08:30:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] target/loongarch: Add set_vec_extctx to set
 LSX/LASX instructions extctx_flags
To: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, laurent@vivier.e, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, laurent@vivier.eu
References: <20231010033701.385725-1-gaosong@loongson.cn>
 <20231010033701.385725-3-gaosong@loongson.cn>
 <1c4c0856-337e-4c5e-b2af-6caf35060b0a@linaro.org>
 <24981f5e-3397-427e-a552-635887d581cd@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <24981f5e-3397-427e-a552-635887d581cd@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 10/29/23 20:28, gaosong wrote:
> 在 2023/10/29 上午5:40, Richard Henderson 写道:
>> On 10/9/23 20:36, Song Gao wrote:
>>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>>> ---
>>>   target/loongarch/insn_trans/trans_vec.c.inc | 12 ++++++++++++
>>>   target/loongarch/internals.h                |  2 ++
>>>   2 files changed, 14 insertions(+)
>>>
>>> diff --git a/target/loongarch/insn_trans/trans_vec.c.inc 
>>> b/target/loongarch/insn_trans/trans_vec.c.inc
>>> index 98f856bb29..aef16ef44a 100644
>>> --- a/target/loongarch/insn_trans/trans_vec.c.inc
>>> +++ b/target/loongarch/insn_trans/trans_vec.c.inc
>>> @@ -23,8 +23,20 @@ static bool check_vec(DisasContext *ctx, uint32_t oprsz)
>>>     #else
>>>   +static void set_vec_extctx(DisasContext *ctx, uint32_t oprsz)
>>> +{
>>> +    if (oprsz == 16) {
>>> +        ctx->extctx_flags |= EXTCTX_FLAGS_LSX;
>>> +    }
>>> +
>>> +    if (oprsz == 32) {
>>> +        ctx->extctx_flags |= EXTCTX_FLAGS_LASX;
>>> +    }
>>> +}
>>> +
>>>   static bool check_vec(DisasContext *ctx, uint32_t oprsz)
>>>   {
>>> +    set_vec_extctx(ctx, oprsz);
>>>       return true;
>>>   }
>>
>> This doesn't do anything.  Nothing copies the changed value back to env.
>> Anyway, I think this is the wrong way to go about it.
>>
> Oh, It is on patch1.
> 
> @@ -294,6 +296,7 @@ static void loongarch_tr_translate_insn(DisasContextBase *dcbase, 
> CPUState *cs)
>           generate_exception(ctx, EXCCODE_INE);
>       }
> 
> +    env->extctx_flags |= ctx->extctx_flags;

Ah, well, this is also incorrect.

This copy only happens at translation time, not at execution time.

Anyway, I think my previous suggestion is better:

>> If you want to track what the program is using, you should do it exactly like the real 
>> kernel: disable the execution unit, have the program trap, and the enable the execution 
>> unit when the trap occurs. At this point, CSR_EUEN enable bits contain exactly which 
>> units have been used by the program.


r~


