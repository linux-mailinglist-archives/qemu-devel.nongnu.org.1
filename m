Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A8F7DB943
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 12:50:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxQmp-0003Mm-Jz; Mon, 30 Oct 2023 07:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxQmP-0002uE-4e
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:50:01 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxQmJ-0007UC-RZ
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:50:00 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5a7e5dc8573so39157617b3.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 04:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698666594; x=1699271394; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RubRBpkDYN+zgt1HhJWUW3+Y5mAhtpEvoOUadZhhyf8=;
 b=F9u454B3pHbF0noe0gVO640JKkCKCKaYTVI8Y/v66ITf//SMr/IYv/ZDD4h7Q/mhj5
 TTdgEHXO+2PncKFpkQg/Ml72DtGAANhCpw91gcXhna6mSg9arrSES/VMOqNLt0tSmNQA
 HNTtBecUeB3cI0Bo6xl2W60KNOmmoSAxLc7pJ+Ha0cIBmmeWac+TFbVMDFJym7wMejuZ
 jYPP4QtxrsHVcFqhHgwAPgDsCriuDy979NCLm8QxZ/4V+UJi5iQLitRwWoQ0ElzJBr2o
 Sk3Fp0PlF6ZQkcqCJ7VFJS1iO4zfSuzUOqj2llT5ocojvKXXE3lZroo3QqYyCgaHuV5c
 DkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698666594; x=1699271394;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RubRBpkDYN+zgt1HhJWUW3+Y5mAhtpEvoOUadZhhyf8=;
 b=c670NhiWzJtxrNC70o8yQVvlR/e3sAnqkpHhNJG2NDeFFcU7lm5peDjCinUNvgJa7/
 XkqTCEh6/PNDbMSINKRc+t2cd2FJQ+I/m4ssv8olGL91RAbM1L75r1pmNOihdREK75dy
 wskv0Qw6dgM1pyAlOjdeajR6YfK0tk7kuqMmFKlRgcRnymzITS++D9rgLBqssI5IIklX
 R5zYn5IWstv5AxsnMzFnKCqrsmQ64QM8Xr+ygouT8Ovtf4SRBj+/pdLcZEfBYeZLCH3F
 0nGiZu6KNfYhwhM3SfmAFi8h4kzUkeL3sJ1xSqMta/2L1KXxv2eguzYJ49id1J79mwmg
 tO3g==
X-Gm-Message-State: AOJu0Ywcslfb7nrKtxmTGynCibKq+9Z01WLsYT73RvAvPgrWRV0oEn0h
 f76KPqsYyxDRlZYUMaM2hBa/wn/X9NtgkLJopUk=
X-Google-Smtp-Source: AGHT+IHfkZA299R5UO6LjBw0RPNGyeuyX62tLCq11FB0E5nEJgYiKg522a9Ppk+n0AecxDY0tf/blw==
X-Received: by 2002:a05:690c:fd5:b0:5a8:7ce7:a35e with SMTP id
 dg21-20020a05690c0fd500b005a87ce7a35emr10270487ywb.40.1698666594139; 
 Mon, 30 Oct 2023 04:49:54 -0700 (PDT)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 j205-20020a8192d6000000b005afa4b9b049sm4210929ywg.42.2023.10.30.04.49.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 04:49:53 -0700 (PDT)
Message-ID: <865593f0-03a1-48db-b634-bf9aca12c445@ventanamicro.com>
Date: Mon, 30 Oct 2023 08:49:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/12] target/riscv: add zicbop extension flag
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20231028085427.707060-1-dbarboza@ventanamicro.com>
 <20231028085427.707060-2-dbarboza@ventanamicro.com>
 <20231028-2d6bf00dddc7bc4a25b32663@orel>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231028-2d6bf00dddc7bc4a25b32663@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 10/28/23 06:49, Andrew Jones wrote:
> On Sat, Oct 28, 2023 at 05:54:16AM -0300, Daniel Henrique Barboza wrote:
>> QEMU already implements zicbom (Cache Block Management Operations) and
>> zicboz (Cache Block Zero Operations). Commit 59cb29d6a5 ("target/riscv:
>> add Zicbop cbo.prefetch{i, r, m} placeholder") added placeholders for
>> what would be the instructions for zicbop (Cache Block Prefetch
>> Operations), which are now no-ops.
>>
>> The RVA22U64 profile mandates zicbop, which means that applications that
>> run with this profile might expect zicbop to be present in the riscv,isa
>> DT and might behave badly if it's absent.
>>
>> Adding zicbop as an extension will make our future RVA22U64
>> implementation more in line with what userspace expects and, if/when
>> cache block prefetch operations became relevant to QEMU, we already have
>> the extension flag to turn then on/off as needed.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   hw/riscv/virt.c        | 5 +++++
>>   target/riscv/cpu.c     | 3 +++
>>   target/riscv/cpu_cfg.h | 2 ++
>>   3 files changed, 10 insertions(+)
>>
>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index 1732c42915..99c087240f 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -273,6 +273,11 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
>>                                     cpu_ptr->cfg.cboz_blocksize);
>>           }
>>   
>> +        if (cpu_ptr->cfg.ext_zicbop) {
>> +            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbop-block-size",
> 
> I think we need to get this node approved by devicetree@vger.kernel.org
> and merged into [1] first.
> 
> [1] Linux repo: Documentation/devicetree/bindings/riscv/cpus.yaml

We got an ack from the devicetree folks to add the "riscv,cbop-block-size"
DT node:

https://lore.kernel.org/linux-devicetree/20231030-attest-unchain-ab99981a5738@spud/


I believe we don't have blockers to proceed with this change then. Thanks,


Daniel

> 
>> +                                  cpu_ptr->cfg.cbop_blocksize);
>> +        }
>> +
>>           qemu_fdt_setprop_string(ms->fdt, cpu_name, "compatible", "riscv");
>>           qemu_fdt_setprop_string(ms->fdt, cpu_name, "status", "okay");
>>           qemu_fdt_setprop_cell(ms->fdt, cpu_name, "reg",
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index f40da4c661..6c0050988f 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -78,6 +78,7 @@ const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
>>    */
>>   const RISCVIsaExtData isa_edata_arr[] = {
>>       ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
>> +    ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
>>       ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
>>       ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
>>       ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
>> @@ -1336,6 +1337,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>>       MULTI_EXT_CFG_BOOL("zhinxmin", ext_zhinxmin, false),
>>   
>>       MULTI_EXT_CFG_BOOL("zicbom", ext_zicbom, true),
>> +    MULTI_EXT_CFG_BOOL("zicbop", ext_zicbop, true),
>>       MULTI_EXT_CFG_BOOL("zicboz", ext_zicboz, true),
>>   
>>       MULTI_EXT_CFG_BOOL("zmmul", ext_zmmul, false),
>> @@ -1424,6 +1426,7 @@ Property riscv_cpu_options[] = {
>>       DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
>>   
>>       DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
>> +    DEFINE_PROP_UINT16("cbop_blocksize", RISCVCPU, cfg.cbop_blocksize, 64),
>>       DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
>>   
>>       DEFINE_PROP_END_OF_LIST(),
>> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
>> index 6eef4a51ea..2203b4c45b 100644
>> --- a/target/riscv/cpu_cfg.h
>> +++ b/target/riscv/cpu_cfg.h
>> @@ -65,6 +65,7 @@ struct RISCVCPUConfig {
>>       bool ext_zicntr;
>>       bool ext_zicsr;
>>       bool ext_zicbom;
>> +    bool ext_zicbop;
>>       bool ext_zicboz;
>>       bool ext_zicond;
>>       bool ext_zihintntl;
>> @@ -134,6 +135,7 @@ struct RISCVCPUConfig {
>>       uint16_t vlen;
>>       uint16_t elen;
>>       uint16_t cbom_blocksize;
>> +    uint16_t cbop_blocksize;
>>       uint16_t cboz_blocksize;
>>       bool mmu;
>>       bool pmp;
>> -- 
>> 2.41.0
>>
> 
> Otherwise,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> Thanks,
> drew

