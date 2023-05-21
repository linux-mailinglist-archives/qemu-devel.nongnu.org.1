Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 213F970AE65
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 17:02:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0kZ6-0002xR-5o; Sun, 21 May 2023 11:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0kZ2-0002wW-CW
 for qemu-devel@nongnu.org; Sun, 21 May 2023 11:01:40 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0kZ0-0006AH-Rt
 for qemu-devel@nongnu.org; Sun, 21 May 2023 11:01:40 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-64d2c865e4eso2146324b3a.0
 for <qemu-devel@nongnu.org>; Sun, 21 May 2023 08:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684681297; x=1687273297;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4YEc+QUwDN6om9t03jT9ecIttjXYI2GN3RYTmHjitcc=;
 b=rcy+gC3i4UeGieY3p1RjXc9fllK5ksA0RjYXn6TGUEAsjPZs1wz/6d+56nUXUEJtvD
 9hagoen+Mugp1SFkdb0Z8fFPIptoGjziipBVzVwcAkWba83EyiCXsLRVN+NyXYYb85e0
 xDktizS7bZ2ufOECYbfKJ+TtQWf0ixgSWCn9+yRgwbVB+NX1QuuL84Gz16ebxlZDaCQP
 i1fPw5tWHsZQ4TS1xkY3rBavY7kJT/OnJFWTOussY3EZasWH+JUEa5oglsTDpTHQbVd5
 MOnkAfcL8k7XMObopZiB4EcqBcMckzuYs+RKd8JYRty66lt1okTNQxuu/I8+GVLRTd6d
 epJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684681297; x=1687273297;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4YEc+QUwDN6om9t03jT9ecIttjXYI2GN3RYTmHjitcc=;
 b=GTrixPH6F9HzPO+p3pj32fcOv3yYSnpQRSvF1v7gpoeBYovYLOqv3on25SVB3PJLTa
 mT1I428nSqtA9Z/C7rK7nQCZTLwG9jz0yXyahyk0LdW6GuxWKCyaq2hwGccQ3BDD0sI1
 CLv5KJ4NQt0fHLPtZgZ1pFf4DQ7L2WVmX7Nz+l6fFSvY7GkzBYnwaF3tnvAl+gjpK3UF
 qKT8CpFwooG5GUpyJz0TFp422GQ/b8Fo6f7IAcdhGFIks9DmhoYj60ASXQTsn6k9E9GH
 VE4A7xsiftHOGxD3jqrVNkHQbDJTDjPiRKLTs9M8H2GYIymOIgVXO6fQLD+6RyW+idhl
 KpWg==
X-Gm-Message-State: AC+VfDz9yfQPuDTxr+BZ0Edhq1n0JeFtpPYVuWaeS6fweg1UpQV8/cck
 MP1ogQmYzowklgJ6MhY396tZOg==
X-Google-Smtp-Source: ACHHUZ6S+ks65d9s5H7Md6SiojAiD1tFPTYZOh45hyRSZZvsQwAce4AXv0iGaW5bHfP240G3LLbmQQ==
X-Received: by 2002:a05:6a20:748e:b0:10b:e0a:1319 with SMTP id
 p14-20020a056a20748e00b0010b0e0a1319mr3549226pzd.13.1684681297191; 
 Sun, 21 May 2023 08:01:37 -0700 (PDT)
Received: from [10.40.30.162] ([66.172.120.86])
 by smtp.gmail.com with ESMTPSA id
 b5-20020aa78705000000b006437c0edf9csm2744487pfo.16.2023.05.21.08.01.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 May 2023 08:01:36 -0700 (PDT)
Message-ID: <37df70b4-5ae4-f36b-a349-303828545262@linaro.org>
Date: Sun, 21 May 2023 08:01:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 17/27] target/s390x: Use cpu_{ld,st}*_mmu in do_csst
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
 <20230520162634.3991009-18-richard.henderson@linaro.org>
 <a56f5acc-5716-8598-e49c-d1f6c19e144f@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a56f5acc-5716-8598-e49c-d1f6c19e144f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 5/21/23 04:21, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 20/5/23 18:26, Richard Henderson wrote:
>> Use cpu_ld16_mmu and cpu_st16_mmu to eliminate the special case,
>> and change all of the *_data_ra functions to match.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> Cc: qemu-s390x@nongnu.org
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
>> ---
>>   target/s390x/tcg/mem_helper.c | 65 ++++++++++++++---------------------
>>   1 file changed, 26 insertions(+), 39 deletions(-)
>>
>> diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
>> index 0e0d66b3b6..b6cf24403c 100644
>> --- a/target/s390x/tcg/mem_helper.c
>> +++ b/target/s390x/tcg/mem_helper.c
>> @@ -1737,6 +1737,9 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
>>                           uint64_t a2, bool parallel)
>>   {
>>       uint32_t mem_idx = cpu_mmu_index(env, false);
>> +    MemOpIdx oi16 = make_memop_idx(MO_TE | MO_128, mem_idx);
>> +    MemOpIdx oi8 = make_memop_idx(MO_TE | MO_64, mem_idx);
> 
> 
>>               if (parallel) {
>>   #ifdef CONFIG_ATOMIC64
>> -                MemOpIdx oi = make_memop_idx(MO_TEUQ | MO_ALIGN, mem_idx);
>> -                ov = cpu_atomic_cmpxchgq_be_mmu(env, a1, cv, nv, oi, ra);
>> +                ov = cpu_atomic_cmpxchgq_be_mmu(env, a1, cv, nv, oi8, ra);
> 
> Why is it safe to remove MO_ALIGN here?

Alignment check already done at the start of the function:

     /* Sanity check the alignments.  */
     if (extract32(a1, 0, fc + 2) || extract32(a2, 0, sc)) {
         goto spec_exception;
     }


r~

