Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C24A7495E2
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 08:46:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHIj4-0000hQ-Jj; Thu, 06 Jul 2023 02:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHIim-0000aE-Ru
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 02:44:09 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHIik-0005GD-Mm
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 02:44:08 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbdfda88f4so3249095e9.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 23:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688625845; x=1691217845;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F0TXbtyHYauJjVik7ELD3Ay82VW0bFX3UF/oYy0tgBA=;
 b=HM7dCFZIWErVKvmvtw4SYe3Jj6CC/kSlOIyHZf0qNjvGvx+tvK3ivCJ1ksD0lEfQJV
 Yz0VAYyr1b7fKzSnqOhL9mGaYOvMn1LpQupbzybv5srgtzLfuWRUd25pIr4Qajpj7gEO
 t2GIh3tdXHxGXG/WfQe+QtwZLXTJwjMyTNkN1DnDA/A0anVlBEvoPxKBOqOLu/SUr5xx
 vQCxvMoA8BPmgsMQN33dDsIL1c59vQLH9fEl9mGEdTKAuqi/LrVBmyNo4DHC0Gt17LAq
 2IgLF59zp5G+q2N5FUTetAnsXHvA81S93c6VCD1TxO7sYWHHE02HysaGI5S3wLQP80Ue
 J5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688625845; x=1691217845;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F0TXbtyHYauJjVik7ELD3Ay82VW0bFX3UF/oYy0tgBA=;
 b=P2zzPpWRazRBwmLdZDmVRX1HpI2NkHBzNSOHntAEqgo3c8Yx7XrktSCMnB1B3P8box
 K2Eq1ldUiTXHQY15KqzUTk+vRJy8xBVmLdunTir0w1sYMMUwGjcRaC4aviT2bnKpdngY
 TQFhUZSX2XKlwbZjgzKGj3fCtIxhQtNQZlPhqw4jEOtazykHLc2R548/zJh9VHEcxGm3
 xxzixE9jYKW1NcjcDSFiqPR/SSl/nPQH6DKtF4+b3IizmHqXL0E1MuBO+ydT6gUccFge
 Lii9bwKh2eC1lRoZsTT5lE+z2CJ9ZeLLcXWClmJAvNmpHelXuVFqQPYKaTtZ9QaA0ebf
 gttg==
X-Gm-Message-State: ABy/qLa28MWssroDzZISTaP1czfnQHJGDi8QEHy+Xa4D0hqcOjwyJKKJ
 hIdfkKVywfxBnbKXQA0/5ug0oA==
X-Google-Smtp-Source: APBJJlGRYdcg4IhomWbLfSRtBpHy5ICve4AuDIgO6nSued7Yfw9AUXCWwQvGCA8e096ia/KQwUyI+Q==
X-Received: by 2002:a05:600c:d6:b0:3fb:b1bf:7df3 with SMTP id
 u22-20020a05600c00d600b003fbb1bf7df3mr557121wmm.16.1688625844728; 
 Wed, 05 Jul 2023 23:44:04 -0700 (PDT)
Received: from [192.168.45.155] ([95.152.217.99])
 by smtp.gmail.com with ESMTPSA id
 r18-20020a5d4e52000000b0031417b0d338sm947728wrt.87.2023.07.05.23.44.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 23:44:04 -0700 (PDT)
Message-ID: <ed3d829a-b592-909c-c358-acdeab65df17@linaro.org>
Date: Thu, 6 Jul 2023 07:44:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] Hexagon: move GETPC() calls to top level helpers
Content-Language: en-US
To: ltaylorsimpson@gmail.com,
 'Matheus Tavares Bernardino' <quic_mathbern@quicinc.com>,
 qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mliebel@quicinc.com
References: <93a2ca786530cbc8a94f7c7a6451f4f1f47c8a9b.1688581908.git.quic_mathbern@quicinc.com>
 <00a701d9af8e$7de644c0$79b2ce40$@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <00a701d9af8e$7de644c0$79b2ce40$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/5/23 23:17, ltaylorsimpson@gmail.com wrote:
> 
> 
>> -----Original Message-----
>> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
>> Sent: Wednesday, July 5, 2023 12:35 PM
>> To: qemu-devel@nongnu.org
>> Cc: quic_mathbern@quicinc.com; bcain@quicinc.com;
>> ltaylorsimpson@gmail.com; quic_mliebel@quicinc.com;
>> richard.henderson@linaro.org
>> Subject: [PATCH v2] Hexagon: move GETPC() calls to top level helpers
>>
>> As docs/devel/loads-stores.rst states:
>>
>>    ``GETPC()`` should be used with great care: calling
>>    it in other functions that are *not* the top level
>>    ``HELPER(foo)`` will cause unexpected behavior. Instead, the
>>    value of ``GETPC()`` should be read from the helper and passed
>>    if needed to the functions that the helper calls.
>>
>> Let's fix the GETPC() usage in Hexagon, making sure it's always called
> from
>> top level helpers and passed down to the places where it's needed. There
>> are two snippets where that is not currently the case:
>>
>> - probe_store(), which is only called from two helpers, so it's easy to
>>    move GETPC() up.
>>
>> - mem_load*() functions, which are also called directly from helpers,
>>    but through the MEM_LOAD*() set of macros. Note that this are only
>>    used when compiling with --disable-hexagon-idef-parser.
>>
>>    In this case, we also take this opportunity to simplify the code,
>>    unifying the mem_load*() functions.
>>
>> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
>> ---
>> v1:
>> d40fabcf9d6e92e4cd8d6a144e9b2a9acf4580dc.1688420966.git.quic_mathber
>> n@quicinc.com
>>
>> Changes in v2:
>> - Fixed wrong cpu_ld* unification from previous version.
>> - Passed retaddr down to check_noshuf() and further, as Taylor
>>    suggested.
>> - Reorganized macros for simplification.
>>
>>   target/hexagon/macros.h    | 19 ++++++------
>>   target/hexagon/op_helper.h | 11 ++-----  target/hexagon/op_helper.c | 62
>> +++++++++++---------------------------
>>   3 files changed, 29 insertions(+), 63 deletions(-)
>>
>> diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h index
>> 5451b061ee..e44a932434 100644
>> --- a/target/hexagon/macros.h
>> +++ b/target/hexagon/macros.h
>> @@ -173,15 +173,6 @@
>>   #define fLOAD(NUM, SIZE, SIGN, EA, DST) \
>> -    DST = (size##SIZE##SIGN##_t)MEM_LOAD##SIZE##SIGN(EA)
>> +    DST =  (size##SIZE##SIGN##_t)({ \
>> +        check_noshuf(env, pkt_has_store_s1, slot, EA, SIZE, GETPC()); \
>> +        MEM_LOAD##SIZE(env, EA, GETPC()); \
>> +    })
>>   #endif
> 
> This should be formatted as
> #define fLOAD(...) \
>      do { \
>          check_noshuf(...); \
>          DST = ...; \
>      } while (0)

Alternately,

     DST = (size##SIZE##SIGN##_t)mem_load##SIZE(env, pkt_has_store_s1, slot, EA, GETPC())

and retain the mem_loadN functions with an extra argument.

>> +void check_noshuf(CPUHexagonState *env, bool pkt_has_store_s1,
>> +                  uint32_t slot, target_ulong vaddr, int size,
>> +uintptr_t ra);
> 
> Are you sure this needs to be non-static?

I think only if the mem_loadN functions are retained may it be static.
But perhaps the macro magic is actually limited to the same compilation unit?


r~


