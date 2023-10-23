Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DE17D42FF
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:01:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv3uj-0007oX-Ck; Mon, 23 Oct 2023 19:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv3ud-0007l6-OP
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:00:44 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv3ua-0003e1-TR
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:00:42 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-27e4e41a4fcso1081119a91.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 16:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698102039; x=1698706839; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6lF2zVGGVVXxGb/dqq43G/9S4rqg8zYmDyOHgB2uaOE=;
 b=VEs0mgsWi4VvZGSDz8WoowoL+wleuhRmQK1baAbRVipYifkfMU4XmueTMZyqILSIe7
 rPEcdNG7QlCoqi3b2bG8BARTLP1zP4iUAPhWAdlAiG2KYROs2tMCvde5j3ifRTVTjSmT
 qcIzHtkb+yGoyb1ciNamA+XTqhTd/JsTNsp5cvz5g4z+qO1kJe9AyEltAiyJwxkCXaNm
 nmCKI+7t9snEXWuMy3y+6DRV85LAK4j0LSsNPLW8nmtQqNX9RhxF00Z86dRHuimXhsUs
 YNJ/gkVyelynFSZZdJsM0Zxbb4vFLuPjWnZJt+UTi7xZBVpwlfDxQ3eoniRFqUl5enWv
 qmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698102039; x=1698706839;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6lF2zVGGVVXxGb/dqq43G/9S4rqg8zYmDyOHgB2uaOE=;
 b=wnnUwYgsEZXWf9dTng7eZzXjH8zp2RYvg6+vHxqs8a9FozWnUz84YqFJwsZKL5poGY
 Ru4onxEnTceywUODMRfPEhEZJmt4C1mE9nrBAT1jnZVPhswTZBRpD1BO/YKFbqgqyfQ5
 P6sCXM1rVDaOS7ZHfvhWIrlP2Q90LBlQWi6OCUEjvuqJbmE0OkdfytAZKS4Tr6gmuiT/
 n9tGa9Chi/umAYb+aFMdIAcuy/WJeHMzE3SJb9XVSYqKlxAgL+dqpI7l8FZRCYJ5HKZ1
 S5Ks6GoStsY7UnoZbQTU26dlmn8dkycYIWp8jFQLA0BYXjOzFo7VKOkg+nzhNwa8v1GK
 QQ5g==
X-Gm-Message-State: AOJu0YwGxnR6KjeSp+4zPGvZosUE93xuDtqDAqQFov6JbG1XScvYB/H1
 d6uIZrY4jdNqW9iQV1cMwWRFiA==
X-Google-Smtp-Source: AGHT+IF7PXMim8/DxlQ3f+tlMRxLsoYHE4TWHVuT8s4opitWQU2cr4InqS9J2iiH2SG3p//YY2Nm3A==
X-Received: by 2002:a17:90a:8997:b0:27d:66a9:3462 with SMTP id
 v23-20020a17090a899700b0027d66a93462mr7298263pjn.3.1698102039137; 
 Mon, 23 Oct 2023 16:00:39 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ga8-20020a17090b038800b0027d0af2e9c3sm8106910pjb.40.2023.10.23.16.00.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 16:00:38 -0700 (PDT)
Message-ID: <465c4c5e-2999-48aa-9d9e-4cd191630532@linaro.org>
Date: Mon, 23 Oct 2023 16:00:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/loongarch: Add amcas[_db].{b/h/w/d}
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20231023153029.269211-2-c@jia.je>
 <20231023153029.269211-5-c@jia.je>
 <20d3fb6b-421c-4259-aca4-d881a48152f0@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20d3fb6b-421c-4259-aca4-d881a48152f0@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 10/23/23 08:35, Jiajie Chen wrote:
>> +static bool gen_cas(DisasContext *ctx, arg_rrr *a,
>> +                    void (*func)(TCGv, TCGv, TCGv, TCGv, TCGArg, MemOp),
>> +                    MemOp mop)
>> +{
>> +    TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
>> +    TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
>> +    TCGv val = gpr_src(ctx, a->rk, EXT_NONE);
>> +
>> +    addr = make_address_i(ctx, addr, 0);
>> +
> 
> I'm unsure if I can use the same TCGv for the first and the third argument here. If it 
> violates with the assumption, a temporary register can be used.
> 
>> +    func(dest, addr, dest, val, ctx->mem_idx, mop);

Correct, you cannot use dest in both places.
I just replied to the patch itself with that.  :-)


r~

