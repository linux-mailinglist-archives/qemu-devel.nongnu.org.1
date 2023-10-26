Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5BD7D79EE
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 03:05:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvonF-00068u-RO; Wed, 25 Oct 2023 21:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvon9-00067e-Fw
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:04:07 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvon7-0000Ib-OE
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:04:07 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1caa371dcd8so2718515ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 18:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698282243; x=1698887043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AhDkvgr9e/+Rp9G3u/UCOQjNTGDzs8CK8bjKHy+ukI4=;
 b=wHwzubzHJXxDkHcw06AoEFR8EtsgkHyPmLrzzVTAENDGNmTpzNOOOjNu7wMT2KGwvD
 RKDHwhaHmHxaonPDdyxGrddXfVGGDjvJSmGHBIkoR4BmZuX7wlPTbv/DrGY3ZhtqmkeV
 9u+QeybzJP611HMFrRU77U7I545k22wwgFwXNyxJTA+RUKIjgUzhvDWcK13Yaa79OD+D
 5BGJMtRvBGX43b9BNO8l67WMUSg6GvzAxWOYK4o6Lr2oa3W19mbWXjW+k3xtd66tUHhE
 XACEWXnASfXS6QLxhJv+TPn1eiw+EFNWblMZrUvySLcgiZQhOkIRIAvYpGOCy7KJ4uPL
 ksEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698282243; x=1698887043;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AhDkvgr9e/+Rp9G3u/UCOQjNTGDzs8CK8bjKHy+ukI4=;
 b=tiRtWVleNGpspL9KYHAy/QiDzymCNyAdIjP457A9GtmuY7LaL0fCY9GEqWtk1bGSOA
 IwXDkv5Xao40aPrkEHE3OS25NggnBVsH9RIQ5bkaC4rzv7KkYc/JQONCf3WPJE8/GraH
 R+BMHL7lAWP0bPzFQPdvczQSQFVE8/H9BLw9ppmncZKsIKOK4+gpTYahNjlbH5VxZm7x
 3hepIPg8GXh1NHKJ6j0EOIrc1DKIYYdlvVBiBNZOUn+TeQy1wrZNLGocu5ihbep2EDUD
 arHemMSmhIP0qR8dscHxrklGTkNvE7L1F/w2hg0kCL0qt9OcfAxQNjjQjT17P37p4yH8
 DRDg==
X-Gm-Message-State: AOJu0YzNIeo4qnJL5rArtvVVHFNPJ08Lw46JK23zmkNc7D7BZ6vqgTPB
 b9WyP/16jPm+ZnrxF7NKk5OI0YCvzZzApwfMYXc=
X-Google-Smtp-Source: AGHT+IGqzsC2RRd7mDfn3jB22tBpmdtZtoufRYy2tfh2UkvBm2rxzNlyIa2dDL7Qbo41id6QuXFBGg==
X-Received: by 2002:a17:902:ed01:b0:1ca:3d9c:a752 with SMTP id
 b1-20020a170902ed0100b001ca3d9ca752mr13695680pld.12.1698282242944; 
 Wed, 25 Oct 2023 18:04:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a170902d48f00b001c5eb2c4d8csm9701660plg.160.2023.10.25.18.04.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 18:04:02 -0700 (PDT)
Message-ID: <e41fad0d-548a-4a53-a698-27c5f22fbc4a@linaro.org>
Date: Wed, 25 Oct 2023 18:04:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] target/sparc: Introduce cpu_put_psr_icc
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20231017064109.681935-1-richard.henderson@linaro.org>
 <20231017064109.681935-2-richard.henderson@linaro.org>
 <0be5ec0b-d4dc-9c14-4c2f-07e2cc79aec5@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <0be5ec0b-d4dc-9c14-4c2f-07e2cc79aec5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 10/19/23 07:11, Philippe Mathieu-Daudé wrote:
>>       uint32_t psr;
>>       __get_user(psr, &regs->psr);
>> -    env->psr = (psr & PSR_ICC) | (env->psr & ~PSR_ICC);
> 
> This keeps the non-PSR_ICC fields from env->psr, ...
> 
>> +    cpu_put_psr_icc(env, psr);
>>   #endif
>>       /* Note that pc and npc are handled in the caller. */
>> diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
>> index 3a7c0ff943..bf2c90c780 100644
>> --- a/target/sparc/win_helper.c
>> +++ b/target/sparc/win_helper.c
>> @@ -67,9 +67,14 @@ target_ulong cpu_get_psr(CPUSPARCState *env)
>>   #endif
>>   }
>> -void cpu_put_psr_raw(CPUSPARCState *env, target_ulong val)
>> +void cpu_put_psr_icc(CPUSPARCState *env, target_ulong val)
>>   {
>>       env->psr = val & PSR_ICC;
> 
> ... while this zeroes the non-PSR_ICC fields. Is that expected?

The only field in env->psr is ICC.
The other fields are in env->psr{s,ps,et,pil,ef}.

This is a bit of old linux-user confusion, which apparently presumed more.
Anyway, the situation is improved with this patch, and further in the next by removing 
"env->psr" entirely.


r~


PS: The handling of PSR could probably be cleaned up.  I don't think there is a real need 
for the fields to be split apart like this.  A test of e.g. (env->psr & PSR_S) should be 
more or less identical in performance to (env->psrs != 0).  It's only the PSR_ICC 
subfields that get heavy use within translation.

