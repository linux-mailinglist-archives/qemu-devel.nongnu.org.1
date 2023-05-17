Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DD7706571
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 12:39:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzEYR-00039y-Mt; Wed, 17 May 2023 06:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pzEYP-00039k-Pu
 for qemu-devel@nongnu.org; Wed, 17 May 2023 06:38:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pzEYO-0006Jz-1i
 for qemu-devel@nongnu.org; Wed, 17 May 2023 06:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684319922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pFXKfzsiTduVziJOiP9eai8Fa32b0eRADROmTGBzCN4=;
 b=aWf1EEbcB6Ll+nUpOgirwxg8tNK4CX6p273CK9nCxryWpyb7gblf6XvFYQq/9cCdRcIYaA
 twP1SFiLZc833aZpIxUBBdciGJ9bTyWlQmkM41+mCwsv2UJYeHyBuA0nCR6iqLIeUto0BM
 DeHNtBFUd02hfECdaSxv5TmHor7fPhs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-x_X2EaU9PAqTBsQJwfd5BQ-1; Wed, 17 May 2023 06:38:40 -0400
X-MC-Unique: x_X2EaU9PAqTBsQJwfd5BQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f509037a45so42286415e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 03:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684319919; x=1686911919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pFXKfzsiTduVziJOiP9eai8Fa32b0eRADROmTGBzCN4=;
 b=Vu9bzqmi2itJWe3o1HWXtIoG37MfRVg4Wf82Nii9eyBcWn6p73ZCNn7S04xTsmDyqM
 KLRj3FmVonLgsNoo75kI7hD3PCfYSqT2iNLfzbz76s0ZCyaVYErmlw+1QK7GXe0yZcyY
 ZL/8Bqfl3PveZR/1QUwKkiQ9s3HXGuSuFlDOisl8RUXaPRviEwn3m7pIYtULX+vIsYjQ
 tFtkLwwRhiaVqbobiR/NUgjB9sbz5iKqj2MaaiwkmryBM6ltyUDjlCdnaYN5QnuS7q+q
 ZQX5yKSmrMFJ9Pt7qrXeenjTpoFf0/Z23Za5Y4/oPgCwMdT0IR3ml45RKZ5ueiiiYiqJ
 VhZg==
X-Gm-Message-State: AC+VfDxzg6uxbpq3h9C2jRIRtpm/hoteO96kGhhaOba4ppaz92mnW+Uk
 Y46g16+lQPstgOTHjjVqzF9kDxazEXvhsDqZcc+Wlo/PFBO43hCXF3tgl39uIF9fImS+bPMDQDO
 vwENfruvpyR65KNc=
X-Received: by 2002:adf:d4c2:0:b0:307:9d14:eeee with SMTP id
 w2-20020adfd4c2000000b003079d14eeeemr363766wrk.3.1684319919653; 
 Wed, 17 May 2023 03:38:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ59Rr4AjFV1vltf8KjZ9g426ebD1cc2s+8DWqN3RG+1N+TzL4SOtXbzOrSlHs4ZDhsqV6Xinw==
X-Received: by 2002:adf:d4c2:0:b0:307:9d14:eeee with SMTP id
 w2-20020adfd4c2000000b003079d14eeeemr363756wrk.3.1684319919288; 
 Wed, 17 May 2023 03:38:39 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-218.web.vodafone.de.
 [109.43.177.218]) by smtp.gmail.com with ESMTPSA id
 h14-20020adffd4e000000b00304aba2cfcbsm2394367wrs.7.2023.05.17.03.38.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 03:38:38 -0700 (PDT)
Message-ID: <861e6dac-4ab3-0b8b-23a3-d73c37ebb440@redhat.com>
Date: Wed, 17 May 2023 12:38:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] include/exec: Make ld*_p and st*_p functions
 available for generic code, too
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>
References: <20230517074222.766683-1-thuth@redhat.com>
 <20230517074222.766683-2-thuth@redhat.com>
 <add7a0f7-92b4-c0ce-f237-366672df053b@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <add7a0f7-92b4-c0ce-f237-366672df053b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.412, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 17/05/2023 12.18, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 17/5/23 09:42, Thomas Huth wrote:
>> This will allow to move more code into the target independent source set.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   include/exec/cpu-all.h | 25 ----------------
>>   include/exec/tswap.h   | 66 ++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 66 insertions(+), 25 deletions(-)
>>
>> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
>> index ad824fee52..0daa4c06e5 100644
>> --- a/include/exec/cpu-all.h
>> +++ b/include/exec/cpu-all.h
>> @@ -55,31 +55,6 @@
>>   #define bswaptls(s) bswap64s(s)
>>   #endif
>> -/* Target-endianness CPU memory access functions. These fit into the
>> - * {ld,st}{type}{sign}{size}{endian}_p naming scheme described in bswap.h.
>> - */
>> -#if TARGET_BIG_ENDIAN
>> -#define lduw_p(p) lduw_be_p(p)
>> -#define ldsw_p(p) ldsw_be_p(p)
>> -#define ldl_p(p) ldl_be_p(p)
>> -#define ldq_p(p) ldq_be_p(p)
>> -#define stw_p(p, v) stw_be_p(p, v)
>> -#define stl_p(p, v) stl_be_p(p, v)
>> -#define stq_p(p, v) stq_be_p(p, v)
>> -#define ldn_p(p, sz) ldn_be_p(p, sz)
>> -#define stn_p(p, sz, v) stn_be_p(p, sz, v)
>> -#else
>> -#define lduw_p(p) lduw_le_p(p)
>> -#define ldsw_p(p) ldsw_le_p(p)
>> -#define ldl_p(p) ldl_le_p(p)
>> -#define ldq_p(p) ldq_le_p(p)
>> -#define stw_p(p, v) stw_le_p(p, v)
>> -#define stl_p(p, v) stl_le_p(p, v)
>> -#define stq_p(p, v) stq_le_p(p, v)
>> -#define ldn_p(p, sz) ldn_le_p(p, sz)
>> -#define stn_p(p, sz, v) stn_le_p(p, sz, v)
>> -#endif
>> -
>>   /* MMU memory access macros */
>>   #if defined(CONFIG_USER_ONLY)
>> diff --git a/include/exec/tswap.h b/include/exec/tswap.h
>> index 68944a880b..2774820bbe 100644
>> --- a/include/exec/tswap.h
>> +++ b/include/exec/tswap.h
>> @@ -69,4 +69,70 @@ static inline void tswap64s(uint64_t *s)
>>       }
>>   }
>> +/*
>> + * Target-endianness CPU memory access functions. These fit into the
>> + * {ld,st}{type}{sign}{size}{endian}_p naming scheme described in bswap.h.
>> + */
>> +
>> +static inline int lduw_p(const void *ptr)
>> +{
>> +    return (uint16_t)tswap16(lduw_he_p(ptr));
>> +}
>> +
>> +static inline int ldsw_p(const void *ptr)
>> +{
>> +    return (int16_t)tswap16(lduw_he_p(ptr));
>> +}
>> +
>> +static inline int ldl_p(const void *ptr)
>> +{
>> +    return tswap32(ldl_he_p(ptr));
>> +}
>> +
>> +static inline uint64_t ldq_p(const void *ptr)
>> +{
>> +    return tswap64(ldq_he_p(ptr));
>> +}
> 
> Hmm I am a bit confused, I was working on removing the tswapXX API
> from softmmu [*] (restricting it locally to gdbstub). Now I realize
> commit 24be3369ad ("include/exec: Provide the tswap() functions for target 
> independent code, too") exposes it furthermore. I thought the
> ld/st API was clearer and enough for all our uses, but maybe I am
> wrong and we need this API.

I think we need both. In some cases, you want to read/write values in a 
certain endianess, and in some cases you have some generic code that just 
wants to write some values in the endianess of the target (where the generic 
code does not know the endianess of the target by default, e.g. since it is 
one time linked with a big endian target and one time with a little endian 
target). In the latter case, we need these functions here from tswap.h.

  Thomas



