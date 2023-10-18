Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC257CDB7B
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 14:23:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt5Zu-0005ZW-QY; Wed, 18 Oct 2023 08:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qt5Zr-0005ZD-72
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 08:23:07 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qt5Zp-0007Wj-M1
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 08:23:06 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6cd0155de52so831408a34.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 05:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697631784; x=1698236584;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8dvKIBtbuqFbjz2tpsjpo3iSOws3w9vRD80witqbyhg=;
 b=FnlRZNsWXnFyfD3nRPkWPH6NJ+aMIgVhHHG1KTFDS3msZYmoyrBrh+9z6IOMT3MavS
 K01qJFvz7rJYntKq7tm/Gu1vLCnB/jppJhymZarYUhsTQIUTswFeaTsWzWxjUAy4KGuo
 kxtb+Iyy9CtuuOvhAUeMEJ7ecdSNXyKjr8S4pPK+8u98AKVE9j7LqiAF9Wvk8wEPY7ZL
 U3xNsJOnySgFt6iONFsD0zjHBcviRyIiahywrFLaneSh9Kglblyn8fjRtMENVHzpBqxO
 2hdhNkl80S5DS+E+l5NQHatDD4Upji9/jAKNbXNyKHTAN+uR3nXV2/VnZ3zJoDUpyiRi
 z21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697631784; x=1698236584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8dvKIBtbuqFbjz2tpsjpo3iSOws3w9vRD80witqbyhg=;
 b=YlLHXIH8TlRDk5VDv8Hkwfqzcn/+sfefBPAU3MPQXVvxV92sr0410ZwSUX4oJ1jfNW
 8d1bySex3YAjN85Yb6Nq762Mlxu4nGPmokVEqzsF4yHUeBh1QcQ10xkHHskA204X/f5h
 aHVSy0Dw2TkNFHqJ+OqqyoU2CSabwO0//BAJ7s3OhYKY9TzTRRYh9ax2DcDxswuzC8vj
 98XWDmkPQm3SUwCNBcbQOt2iEuY7CfilqXZIcL7NCst4nZyI1eOeJgbmxmv3PtzFkmsl
 X/u9IbgYYouj891yyqCJF48Os5dWnMPD4A+0suITGZDWA7UjSjaB1MPtjD1i2Wn10Drk
 1zOw==
X-Gm-Message-State: AOJu0Yy6+cPz0ATUbXlRVFTLAvN5OlhLtm1qs+wjWQztlrg3ELQciRwz
 uoIx4eYQVp/oL6gu5tL5TJA2lw==
X-Google-Smtp-Source: AGHT+IHRG6dw8TTOysALXeJjnSkC/gBMDyMKqYP+s39J+c/nYy+foGHduF45K4DkYg9tGr/aV7PJMQ==
X-Received: by 2002:a05:6830:450:b0:6bc:e049:b28f with SMTP id
 d16-20020a056830045000b006bce049b28fmr5485279otc.34.1697631784538; 
 Wed, 18 Oct 2023 05:23:04 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 ei47-20020a056a0080ef00b0068ffb8da107sm3216550pfb.212.2023.10.18.05.23.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 05:23:04 -0700 (PDT)
Message-ID: <06d5e859-02db-4f4b-a31c-e9fb986e97dd@daynix.com>
Date: Wed, 18 Oct 2023 21:23:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] target/riscv: Move misa_mxl_max to class
Content-Language: en-US
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org
References: <20231017185406.13381-1-akihiko.odaki@daynix.com>
 <20231017185406.13381-4-akihiko.odaki@daynix.com>
 <cc32b55b-adc9-440d-814e-5a124a9ec8af@linux.alibaba.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <cc32b55b-adc9-440d-814e-5a124a9ec8af@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/18 15:50, LIU Zhiwei wrote:
> 
> On 2023/10/18 2:53, Akihiko Odaki wrote:
>> misa_mxl_max is common for all instances of a RISC-V CPU class so they
>> are better put into class.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   target/riscv/cpu-qom.h     |   1 +
>>   target/riscv/cpu.h         |   3 +-
>>   hw/riscv/boot.c            |   2 +-
>>   target/riscv/cpu.c         | 118 +++++++++++++++++++------------------
>>   target/riscv/gdbstub.c     |  12 ++--
>>   target/riscv/kvm/kvm-cpu.c |  10 ++--
>>   target/riscv/machine.c     |   7 +--
>>   target/riscv/tcg/tcg-cpu.c |  12 ++--
>>   target/riscv/translate.c   |   3 +-
>>   9 files changed, 88 insertions(+), 80 deletions(-)
>>
>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>> index f3fbe37a2c..33b6d52c90 100644
>> --- a/target/riscv/cpu-qom.h
>> +++ b/target/riscv/cpu-qom.h
>> @@ -68,5 +68,6 @@ struct RISCVCPUClass {
>>       /*< public >*/
>>       DeviceRealize parent_realize;
>>       ResettablePhases parent_phases;
>> +    uint32_t misa_mxl_max;  /* max mxl for this cpu */
>>   };
>>   #endif /* RISCV_CPU_QOM_H */
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index f8ffa5ee38..ef10efd1e7 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -159,7 +159,6 @@ struct CPUArchState {
>>       /* RISCVMXL, but uint32_t for vmstate migration */
>>       uint32_t misa_mxl;      /* current mxl */
>> -    uint32_t misa_mxl_max;  /* max mxl for this cpu */
>>       uint32_t misa_ext;      /* current extensions */
>>       uint32_t misa_ext_mask; /* max ext for this cpu */
>>       uint32_t xl;            /* current xlen */
>> @@ -711,7 +710,7 @@ enum riscv_pmu_event_idx {
>>   /* used by tcg/tcg-cpu.c*/
>>   void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool 
>> en);
>>   bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset);
>> -void riscv_cpu_set_misa(CPURISCVState *env, RISCVMXL mxl, uint32_t ext);
>> +void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext);
>>   typedef struct RISCVCPUMultiExtConfig {
>>       const char *name;
>> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
>> index 52bf8e67de..b7cf08f479 100644
>> --- a/hw/riscv/boot.c
>> +++ b/hw/riscv/boot.c
>> @@ -36,7 +36,7 @@
>>   bool riscv_is_32bit(RISCVHartArrayState *harts)
>>   {
>> -    return harts->harts[0].env.misa_mxl_max == MXL_RV32;
>> +    return RISCV_CPU_GET_CLASS(&harts->harts[0])->misa_mxl_max == 
>> MXL_RV32;
> 
> Hi Akihiko,
> 
> Can we use the cached CPUClass  in CPUState?  Like
> 
> (RISCVCPUClass *)((CPUState *)(&harts->harts[0])->cc)

If just casting, you can do:
(RISCVCPUClass *)((Object *)&harts->harts[0])->class

But it removes type safety checks RISCV_CPU_GET_CLASS() provides. This 
is not a hot path so it's better to keep the checks.

