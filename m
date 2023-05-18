Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B87B7081A4
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:46:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd0j-0007eA-FX; Thu, 18 May 2023 08:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzd0g-0007du-Fn
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:45:34 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzd0d-0006sH-Rk
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:45:33 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64d247a023aso278562b3a.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684413930; x=1687005930;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HlrW9CFIhIfs2YCG0Ho+Us9e7tNkAMS+Z0PrQ2W+hc8=;
 b=KSl8b4GtaA+MaZYapYLKoSTtqBWYooboRvvHhVVyCML9HWk8tdVFUH5A3M20rUUmw8
 Jww+hUi5JHh05M/WuIY8QfM8c2KFSi3mHNS5f8lc+Ma/lnkPP/8Q3HocdL5BjtpU23KJ
 DYdDH9Ff6OnPZ48s2g/qZYo2EeD8XSDrfDyEvrjF3dekLO0MWtM/3ELVxkmMajdBXBgN
 lhaokOa1IwcKppl2TlCACwvdsjfD3ZUdz5gFJ6Wt8jXx6lQUFdkwxaeHaq41mx3KxBzj
 q9JoUk8yh6EStl77QLxTLCoxnQvH4grPDUIkG13iSpuD+R3dwdOE/6z1dKQ8Twj7WPSN
 ytew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684413930; x=1687005930;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HlrW9CFIhIfs2YCG0Ho+Us9e7tNkAMS+Z0PrQ2W+hc8=;
 b=VzjEFP25l+hYCjw4l0pz0TNjQaPd7/r1FWSuAHGDWfnvoi0h7/5YnqsbvINpWoqBJN
 FH7VVtaOlSN7ehfBDNagQSFon/ta3WboW7eVoLG8HlmlZSu3Sav7+xET6zh/Ch3B64Cw
 KZ/KL5oaojqnoPaKeRuzXLCuSVIANza3+FfNGqxLlzKW5iqOz/xCL7Rkw+Uy1P5RVNZi
 j7izV1rKEEV/aofaGadK816o/eeQDNmzn+GED0WNIWBxeZxVVEnf2k+Z+JIwdySpaWoQ
 62OjbOyEazpiTb478Oj/zxRCuin7lVoxZS9GDEXnzetPpHL3xa2Owi+5zCPLVlLAhas2
 WR9w==
X-Gm-Message-State: AC+VfDzrgO60ZBc8dfp1YTz6Lp86mpLyhharVc0kdKKfqxDtfsPN3/bJ
 AF/nv6EmTrDvou2+AUr/LJXe0A==
X-Google-Smtp-Source: ACHHUZ6LzdYbgSoVg3i9ERuwBggXN0mi+vmNJFehJ4JNpTdPD+nIMsBGAyqPmx0ytvOebRSC7zadgg==
X-Received: by 2002:a05:6a20:8403:b0:ec:d7cf:bcf7 with SMTP id
 c3-20020a056a20840300b000ecd7cfbcf7mr2051951pzd.17.1684413930220; 
 Thu, 18 May 2023 05:45:30 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:5dd2:c230:399b:cdc1?
 ([2602:ae:1598:4c01:5dd2:c230:399b:cdc1])
 by smtp.gmail.com with ESMTPSA id
 f19-20020a635113000000b0051b5d0fe708sm1179140pgb.43.2023.05.18.05.45.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 05:45:29 -0700 (PDT)
Message-ID: <57ba35be-88dc-9df4-8a34-0202e57e29d7@linaro.org>
Date: Thu, 18 May 2023 05:45:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/9] util: Add cpuinfo-i386.c
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <20230518044058.2777467-1-richard.henderson@linaro.org>
 <20230518044058.2777467-3-richard.henderson@linaro.org>
 <87wn16dlsl.fsf@secure.mitica>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87wn16dlsl.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.544,
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

On 5/18/23 02:35, Juan Quintela wrote:
> Richard Henderson <richard.henderson@linaro.org> wrote:
>> Add cpuinfo.h for i386 and x86_64, and the initialization
>> for that in util/.  Populate that with a slightly altered
>> copy of the tcg host probing code.  Other uses of cpuid.h
>> will be adjusted one patch at a time.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> For what is worth my vote O:-)
> 
>> +#define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
>> +#define CPUINFO_CMOV            (1u << 1)
>> +#define CPUINFO_MOVBE           (1u << 2)
>> +#define CPUINFO_LZCNT           (1u << 3)
>> +#define CPUINFO_POPCNT          (1u << 4)
>> +#define CPUINFO_BMI1            (1u << 5)
>> +#define CPUINFO_BMI2            (1u << 6)
>> +#define CPUINFO_SSE2            (1u << 7)
>> +#define CPUINFO_SSE4            (1u << 8)
>> +#define CPUINFO_AVX1            (1u << 9)
>> +#define CPUINFO_AVX2            (1u << 10)
>> +#define CPUINFO_AVX512F         (1u << 11)
>> +#define CPUINFO_AVX512VL        (1u << 12)
>> +#define CPUINFO_AVX512BW        (1u << 13)
>> +#define CPUINFO_AVX512DQ        (1u << 14)
>> +#define CPUINFO_AVX512VBMI2     (1u << 15)
>> +#define CPUINFO_ATOMIC_VMOVDQA  (1u << 16)
>> +
>> +/* Initialized with a constructor. */
>> +extern unsigned cpuinfo;
> 
> On one hand, it is weird having a flags variable that is only 32bit.  I
> am so user to put 64 bit flags. Future proof, blah, blah, ...
> 
> On the other hand, if tcg has survived for so long with only 16 bits, it
> is inside posibility that 32bits are more than enough.

Indeed.  Nor is this an public abi that needs future-proofing -- in the event we need more 
bits, we change it.

>> +/* Called both as constructor and (possibly) via other constructors. */
>> +unsigned __attribute__((constructor)) cpuinfo_init(void)
>> +{
>> +    unsigned info = cpuinfo;
>> +
>> +    if (info) {
>> +        return info;
>> +    }
> 
> Have to look several times to this, because info "needed to be"" a
> static variable, right? O:-)

:-)


r~

