Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 410F77359F1
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:45:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBG7c-0001OI-3A; Mon, 19 Jun 2023 10:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBG7a-0001O1-Cl
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:44:46 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBG7Y-00079y-LT
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:44:46 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f87592ecaeso803588e87.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687185881; x=1689777881;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OGdtDTFYiQTDBFYfZ4oBFyIXPm72bZOjt2mRUQqE67k=;
 b=p44dEAVpdmMaSE0FUIU8AqOaEN3P6W27jonTLs8KZVTgtdnXFgDlZkRV1B0rdujwxM
 j679mlYtKoy3VPb6Qz/GQMhJWpEuq8U3qy7bBUiys9INPbfjNTFCy2RRqQ7Jm5twdsYT
 EOGQz1jHBtUgLJNC2rwb8LZ5DHDguSuOCKj7mgwnM1znPALQH/pCKQuYTNRXY/yROHj/
 SiztD3d2UbaZD3XcIS4zO0RRQLoCT69Tl3EaNhcc0g72yyKRKdk3uNDOcTxZt2u9TXi9
 dIY4uyDAJ9XHqZpwTZQiCGsrqVHpSO2Te2TcI2y5UDKahSnBaQ3ZzFHblmyjqeG/kjNX
 uWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687185881; x=1689777881;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OGdtDTFYiQTDBFYfZ4oBFyIXPm72bZOjt2mRUQqE67k=;
 b=BS07tDGAMyEwiAn7qGnY3RKh+9CmvlgGOxz28L2CLA5J3E3zpIxBXBu0LGbmDD+Peg
 VYcQndZw30UOw0qFXEiia3gUHW3oHBzVj8hdzRhs3zcMPP75u6NRmgrFn0YPpVuSORIP
 BqI/WxFgV3MIA7+dTogHGIqx54sOxjYDkTXV9xII0zcAHONPRBQswx4dpNfD4AiWkfG4
 c5bkMzQCth/16hXXAsyeB8/FRLvT0VEfLDDyu39QDzE5CmhSytvvhr2tf13ZNAetbHPn
 dKh21jtl8Ce6XAdnohPtYJz2wcHOGtZIX4+5CJKjUDArUD3ijSQ13tFK9mHB73plrMY4
 j3BA==
X-Gm-Message-State: AC+VfDyvEIakaURlfAA/z6fKkTAL8CgOqXHdgNJ0Ojk3I9mk4U4+J+Hb
 4tN57/wkzlKUblKL35zs7EzMdg==
X-Google-Smtp-Source: ACHHUZ6IhUIptRJFKrrxWOACHIgAZJuaTb9OWNO/FEVSRACuTDiv9XQzVo/urEC6LCGjwdd6ckDv1g==
X-Received: by 2002:a05:6512:1319:b0:4f8:6625:f2ca with SMTP id
 x25-20020a056512131900b004f86625f2camr2902268lfu.61.1687185881121; 
 Mon, 19 Jun 2023 07:44:41 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 c6-20020a7bc846000000b003f8fb02c413sm9538346wml.8.2023.06.19.07.44.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 07:44:40 -0700 (PDT)
Message-ID: <b46c3dc4-5017-97a3-3935-f8e1c6a7e72d@linaro.org>
Date: Mon, 19 Jun 2023 16:44:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 02/38] util: Add cpuinfo-ppc.c
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
References: <20230609022401.684157-1-richard.henderson@linaro.org>
 <20230609022401.684157-3-richard.henderson@linaro.org>
 <ed63d01a-4903-a233-ac80-6e8d10411a02@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ed63d01a-4903-a233-ac80-6e8d10411a02@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/19/23 12:37, Philippe Mathieu-Daudé wrote:
> On 9/6/23 04:23, Richard Henderson wrote:
>> Move the code from tcg/.  Fix a bug in that PPC_FEATURE2_ARCH_3_10
>> is actually spelled PPC_FEATURE2_ARCH_3_1.
> 
> This is rather confusing.
> 
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   host/include/ppc/host/cpuinfo.h   | 29 ++++++++++++++++
>>   host/include/ppc64/host/cpuinfo.h |  1 +
>>   tcg/ppc/tcg-target.h              | 16 ++++-----
>>   util/cpuinfo-ppc.c                | 57 +++++++++++++++++++++++++++++++
>>   tcg/ppc/tcg-target.c.inc          | 44 +-----------------------
>>   util/meson.build                  |  2 ++
>>   6 files changed, 98 insertions(+), 51 deletions(-)
>>   create mode 100644 host/include/ppc/host/cpuinfo.h
>>   create mode 100644 host/include/ppc64/host/cpuinfo.h
>>   create mode 100644 util/cpuinfo-ppc.c
>>
>> diff --git a/host/include/ppc/host/cpuinfo.h b/host/include/ppc/host/cpuinfo.h
>> new file mode 100644
>> index 0000000000..7ec252ef52
>> --- /dev/null
>> +++ b/host/include/ppc/host/cpuinfo.h
>> @@ -0,0 +1,29 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Host specific cpu indentification for ppc.
>> + */
>> +
>> +#ifndef HOST_CPUINFO_H
>> +#define HOST_CPUINFO_H
>> +
>> +/* Digested version of <cpuid.h> */
>> +
>> +#define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
>> +#define CPUINFO_V2_06           (1u << 1)
>> +#define CPUINFO_V2_07           (1u << 2)
>> +#define CPUINFO_V3_00           (1u << 3)
>> +#define CPUINFO_V3_10           (1u << 4)
> 
> Could we define as CPUINFO_V3_1 ...
> 
>> +#define CPUINFO_ISEL            (1u << 5)
>> +#define CPUINFO_ALTIVEC         (1u << 6)
>> +#define CPUINFO_VSX             (1u << 7)
> 
> 
>> -#define have_isa_2_06  (have_isa >= tcg_isa_2_06)
>> -#define have_isa_2_07  (have_isa >= tcg_isa_2_07)
>> -#define have_isa_3_00  (have_isa >= tcg_isa_3_00)
>> -#define have_isa_3_10  (have_isa >= tcg_isa_3_10)
>> +#define have_isa_2_06  (cpuinfo & CPUINFO_V2_06)
>> +#define have_isa_2_07  (cpuinfo & CPUINFO_V2_07)
>> +#define have_isa_3_00  (cpuinfo & CPUINFO_V3_00)
>> +#define have_isa_3_10  (cpuinfo & CPUINFO_V3_10)
> 
> ... and have_isa_3_1 instead?

I suppose we could, but they all line up this way.  :-)

r~

> 
> Otherwise,
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


