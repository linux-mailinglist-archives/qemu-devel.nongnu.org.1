Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B247D6CE1
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 15:16:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvdim-0000L5-3i; Wed, 25 Oct 2023 09:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qvdiS-0000JA-Um
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:14:32 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qvdiQ-0004Ox-1f
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:14:32 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1caad0bcc95so38563755ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 06:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698239667; x=1698844467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mUqZcaq302DTOHZHYRwEi52LRP3JYvWiSSo56cvZs5g=;
 b=XcBLEj3YFY0I+PZghB2pmarqcHs7Fz6nuT3NDehGeNPBDHvXYGIivH3u3JgG6JBB9y
 aGF0tO8R2CtrZhn/JkXQzGUvnFVgOEQVvLbWXPGiYmXKKLhnHF0ivA9HMx+4AHRKSdoO
 UPY/mXplVwW2rY5TSP5UbAZD7oyHqChMCzP5V6h4bjlRswFD9lXyhtu7ZehMi+MJuCRx
 /wi+dv+BdCugm+WasxQ6rFE8WzZy9+oiuaOMa/qZENZ6vaUWAHz2FlQ+IUrxoh1mhcfc
 8rT1v9B3bLSXMfqGaWb8H6SZC90pHXcWUdXiIGuflEb0BY4j3s1Y5MTQnVb8t/DNnKu/
 mQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698239667; x=1698844467;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mUqZcaq302DTOHZHYRwEi52LRP3JYvWiSSo56cvZs5g=;
 b=RuLCRLOb5YD0T/e2S3usjgVtkWhNOBrWDgOF+HF6VEjGyhf9seSCweasqEhr8WFV6s
 WvyqFgzWZQlg4T+kGv0psCaGw/5CPpHcm/Bsnrlu/w8Z6Udpm2SakYtrZsC4EdRDpQLD
 kHSyeysk0w9DBAm5c4YheBkdolQMeJvSSwCkbG8XzFwFopzhjEX126I+JSoIT0Mv0u0B
 lC9To4l2OwkJkaeeDmGpFJ1TXD4Z1hQ7Up9+opgmZdAJOq7nPs1a+druIsA0DTfXN93Y
 SIRqKZ4nda4ExOqa5hBmkLjEcIAx5opiVuIx2HqmKtEf2I7NXofzxUGQkYUR6ovApVZy
 hwtA==
X-Gm-Message-State: AOJu0Yxg/qOE/3NElRmdkKWx38kDgnUC8C24m9QQ+tKpQhAxCGq9JDeU
 Rd06Yb1Pr96tHvx7zWCJZzrkow==
X-Google-Smtp-Source: AGHT+IE0Dg173lnZhLETdeHCl4puJVKHVoyC+nao8+50ftCFr5szsq4+tYxOHTcuJZXpS7XdyrHoug==
X-Received: by 2002:a17:903:244a:b0:1c7:74a2:5b56 with SMTP id
 l10-20020a170903244a00b001c774a25b56mr14700372pls.43.1698239667328; 
 Wed, 25 Oct 2023 06:14:27 -0700 (PDT)
Received: from [192.168.68.107] ([191.255.2.33])
 by smtp.gmail.com with ESMTPSA id
 iy20-20020a170903131400b001c5fc11c085sm9181994plb.264.2023.10.25.06.14.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 06:14:26 -0700 (PDT)
Message-ID: <efc65647-b394-4fb8-a2a8-7f7128046302@ventanamicro.com>
Date: Wed, 25 Oct 2023 10:14:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] target/riscv: add rva22u64 profile definition
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, palmer@rivosinc.com
References: <20231020223951.357513-1-dbarboza@ventanamicro.com>
 <20231020223951.357513-2-dbarboza@ventanamicro.com>
 <5b3078bd-9805-43cc-a7e7-660041477913@linux.alibaba.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <5b3078bd-9805-43cc-a7e7-660041477913@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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



On 10/25/23 03:22, LIU Zhiwei wrote:
> 
> On 2023/10/21 6:39, Daniel Henrique Barboza wrote:
>> The rva22U64 profile, described in:
>>
>> https://github.com/riscv/riscv-profiles/blob/main/profiles.adoc#rva22-profiles
>>
>> Contains a set of CPU extensions aimed for 64-bit userspace
>> applications. Enabling this set to be enabled via a single user flag
>> makes it convenient to enable a predictable set of features for the CPU,
>> giving users more predicability when running/testing their workloads.
>>
>> QEMU implements all possible extensions of this profile. The exception
>> is Zicbop (Cache-Block Prefetch Operations) that is not available since
>> QEMU RISC-V does not implement a cache model. For this same reason all
>> the so called 'synthetic extensions' described in the profile that are
>> cache related are ignored (Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa,
>> Zicclsm).
>>
>> An abstraction called RISCVCPUProfile is created to store the profile.
>> 'ext_offsets' contains mandatory extensions that QEMU supports. Same
>> thing with the 'misa_ext' mask. Optional extensions must be enabled
>> manually in the command line if desired.
>>
>> The design here is to use the common target/riscv/cpu.c file to store
>> the profile declaration and export it to the accelerator files. Each
>> accelerator is then responsible to expose it (or not) to users and how
>> to enable the extensions.
>>
>> Next patches will implement the profile for TCG and KVM.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> Acked-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>   target/riscv/cpu.c | 20 ++++++++++++++++++++
>>   target/riscv/cpu.h | 12 ++++++++++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index c64cd726f4..1b75b506c4 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -1397,6 +1397,26 @@ Property riscv_cpu_options[] = {
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>> +/* Optional extensions left out: RVV, zfh, zkn, zks */
>> +static RISCVCPUProfile RVA22U64 = {
>> +    .name = "rva22u64",
>> +    .misa_ext = RVM | RVA | RVF | RVD | RVC,
> 
> Why not include RVI?

Because I forgot :D

I'll fix it in v4. Thanks,

Daniel

> 
> Zhiwei
> 
>> +    .ext_offsets = {
>> +        CPU_CFG_OFFSET(ext_zicsr), CPU_CFG_OFFSET(ext_zihintpause),
>> +        CPU_CFG_OFFSET(ext_zba), CPU_CFG_OFFSET(ext_zbb),
>> +        CPU_CFG_OFFSET(ext_zbs), CPU_CFG_OFFSET(ext_zfhmin),
>> +        CPU_CFG_OFFSET(ext_zkt), CPU_CFG_OFFSET(ext_zicntr),
>> +        CPU_CFG_OFFSET(ext_zihpm), CPU_CFG_OFFSET(ext_zicbom),
>> +        CPU_CFG_OFFSET(ext_zicboz),
>> +
>> +        RISCV_PROFILE_EXT_LIST_END
>> +    }
>> +};
>> +
>> +RISCVCPUProfile *riscv_profiles[] = {
>> +    &RVA22U64, NULL,
>> +};
>> +
>>   static Property riscv_cpu_properties[] = {
>>       DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index 7f61e17202..53c1970e0a 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -66,6 +66,18 @@ const char *riscv_get_misa_ext_description(uint32_t bit);
>>   #define CPU_CFG_OFFSET(_prop) offsetof(struct RISCVCPUConfig, _prop)
>> +typedef struct riscv_cpu_profile {
>> +    const char *name;
>> +    uint32_t misa_ext;
>> +    bool enabled;
>> +    bool user_set;
>> +    const int32_t ext_offsets[];
>> +} RISCVCPUProfile;
>> +
>> +#define RISCV_PROFILE_EXT_LIST_END -1
>> +
>> +extern RISCVCPUProfile *riscv_profiles[];
>> +
>>   /* Privileged specification version */
>>   enum {
>>       PRIV_VERSION_1_10_0 = 0,

