Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D39B7C650C
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 08:02:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqoll-0007pQ-Kx; Thu, 12 Oct 2023 02:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqole-0007ow-4f
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 02:01:55 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqolb-0001b3-N7
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 02:01:53 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-690ba63891dso469399b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 23:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697090510; x=1697695310;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E4n8ZTwsAgIR4hEtjwFBTVOmb16J518toUCm0cFT9pg=;
 b=LIGSt9iCv9gvE+Xgp7T+QQ/eIbCxGWIIfA3XJlUZdBBV0EL/Bw70t9xXHBzmD1Xnhz
 BhSlsYK78h0r4xw9F9ldXZ/e8WYH93+QmXVWUsGPIB2cUYHYnZYPGCzESOLG/BXrow7q
 s4V5MFqfUb9uxsFOeO3zK44AIY7aU/+lLyqLIh7fXjzsl0A/WU541QosfhIqwagq7nxH
 7eOQzhyEG6kXZqQVIU1gcdkeQhDktfpRuLCRjgBe8OfyYXmrta5n4jUgzqkIvlH970B0
 rAizXVRrkILJhm0mpM9mhfluxMzPAnD2lEDzbB7+ZSJuzuaE+yK3tMw3UgtQdaEsKVEC
 X8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697090510; x=1697695310;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E4n8ZTwsAgIR4hEtjwFBTVOmb16J518toUCm0cFT9pg=;
 b=uf79+NLkALZJ1LEva/jjgKF7RrRzZFCHGcWJudCbkN91ntfFaRu53ZLw7mshqXStj6
 nvtVsK7v17niLRvnumLTEV+AUCWmqbMUScyyi8eLEU/ITt5cNYGCnXW+KYlNBUOsKqYs
 JBBasR6bTsd5eMQ6WPv2x3IAwQgiXzl77aVhxWJNywb4iWr7gKrld6+wkgD+mJ35ddbA
 0GvMPkx9FvBTEC+RhBhDpAU9i1AXOMOLUtcMzEBuNM6LXNKrNCRXIvRz6vJTt/SMCVvh
 g7q9JtgjYLrltfQgXBvP2nJGCvep6LEORpZyNEzQi9XeG2vCH7lnhb9mcqSH4QQMgiYs
 Wj7A==
X-Gm-Message-State: AOJu0YzDxC6kRfVtJTI9Zk7oPKwdDCL+g18ukFiyXeJF6CCS0omT0oRO
 5+DOIRpTZINZtVXFPU4NAfUSRRsqIUnXDpHi8/U=
X-Google-Smtp-Source: AGHT+IFajs7ZmP1Surm0oXUgMsmVuRlZY85qraSQ/17z4bGVsRjsJg/PBJaQubw8GH0xyGHUBslSLA==
X-Received: by 2002:a05:6a00:2314:b0:68f:cb69:8e7f with SMTP id
 h20-20020a056a00231400b0068fcb698e7fmr25424091pfh.7.1697090510352; 
 Wed, 11 Oct 2023 23:01:50 -0700 (PDT)
Received: from [192.168.96.140] ([157.82.206.1])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a63aa0b000000b0057ab7d42a4dsm848290pgf.86.2023.10.11.23.01.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 23:01:50 -0700 (PDT)
Message-ID: <18548baf-b0ef-4a1a-9929-7a4ed117a2f5@daynix.com>
Date: Thu, 12 Oct 2023 15:01:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/23] target/riscv: Move MISA limits to class
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20231011070335.14398-1-akihiko.odaki@daynix.com>
 <20231011070335.14398-2-akihiko.odaki@daynix.com> <871qe1p40c.fsf@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <871qe1p40c.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2023/10/12 0:23, Alex Bennée wrote:
> 
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> MISA limits are common for all instances of a RISC-V CPU class so they
>> are better put into class.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   target/riscv/cpu-qom.h   |   2 +
>>   target/riscv/cpu.h       |   2 -
>>   hw/riscv/boot.c          |   2 +-
>>   target/riscv/cpu.c       | 212 +++++++++++++++++++++++++++------------
>>   target/riscv/csr.c       |   3 +-
>>   target/riscv/gdbstub.c   |  12 ++-
>>   target/riscv/machine.c   |  11 +-
>>   target/riscv/translate.c |   3 +-
>>   8 files changed, 167 insertions(+), 80 deletions(-)
>>
>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>> index 04af50983e..266a07f5be 100644
>> --- a/target/riscv/cpu-qom.h
>> +++ b/target/riscv/cpu-qom.h
>> @@ -67,5 +67,7 @@ struct RISCVCPUClass {
>>       /*< public >*/
>>       DeviceRealize parent_realize;
>>       ResettablePhases parent_phases;
>> +    uint32_t misa_mxl_max;  /* max mxl for this cpu */
>> +    uint32_t misa_ext_mask; /* max ext for this cpu */
>>   };
>>   #endif /* RISCV_CPU_QOM_H */
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index ef9cf21c0c..9f9cb6cd2a 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -155,9 +155,7 @@ struct CPUArchState {
>>   
>>       /* RISCVMXL, but uint32_t for vmstate migration */
>>       uint32_t misa_mxl;      /* current mxl */
>> -    uint32_t misa_mxl_max;  /* max mxl for this cpu */
>>       uint32_t misa_ext;      /* current extensions */
>> -    uint32_t misa_ext_mask; /* max ext for this cpu */
>>       uint32_t xl;            /* current xlen */
>>   
>>       /* 128-bit helpers upper part return value */
>> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
>> index 52bf8e67de..b7cf08f479 100644
>> --- a/hw/riscv/boot.c
>> +++ b/hw/riscv/boot.c
>> @@ -36,7 +36,7 @@
>>   
>>   bool riscv_is_32bit(RISCVHartArrayState *harts)
>>   {
>> -    return harts->harts[0].env.misa_mxl_max == MXL_RV32;
>> +    return RISCV_CPU_GET_CLASS(&harts->harts[0])->misa_mxl_max ==
>>   MXL_RV32;
> 
> I'm going to defer to the RISCV maintainers here. While I agree the
> class is a good place for these parameters that are shared across
> multiple vCPUS there is a cost to RISCV_CPU_GET_CLASS() casting.
> 
> You might notice we have this comment in include/hw/core/cpu.h:
> 
>    /*
>     * The class checkers bring in CPU_GET_CLASS() which is potentially
>     * expensive given the eventual call to
>     * object_class_dynamic_cast_assert(). Because of this the CPUState
>     * has a cached value for the class in cs->cc which is set up in
>     * cpu_exec_realizefn() for use in hot code paths.
>     */
>    typedef struct CPUClass CPUClass;
>    DECLARE_CLASS_CHECKERS(CPUClass, CPU,
>                           TYPE_CPU)

It is fine since these variables are cached into DisasContext during TCG 
translation as far as I can tell.

> 
> However I think you need to check the assumption that you will never see
> multiple cores with different RISCV properties.

I missed misa_ext_mask can be different so I changed to only convert 
misa_mxl_max into a class member in "[PATCH 0/4] gdbstub and TCG plugin 
improvements".

