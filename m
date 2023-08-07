Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B32F5771D9E
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 11:56:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSwyF-0001Sc-ND; Mon, 07 Aug 2023 05:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSwyD-0001S8-KE
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:56:13 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSwyB-00058o-Si
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:56:13 -0400
Received: from [172.20.10.3] (unknown [112.97.80.95])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id C6391418FE;
 Mon,  7 Aug 2023 09:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691402169; bh=rhUjfBKElMTxoIdAWi+UoXGfHxcK2eHgkrlUfg2TqdE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=RQ3gckp+91/Suj5r5OQLeF26MGyzkFJLsNDdxF1Kw+kcNTeUnFTsylRlL71Xfw+HG
 0hry5D16sVdxGrnMpJowazkm03f0OZLVUWVgkys+tgk8aQU+eHGZl0DOPKdS95EGzx
 pgCG7Lwo5CItPZolT1cUZzBlAh4a/WkBRY53IShE=
Message-ID: <454fd6c8-bd01-97f7-b171-bb85fbf63adb@jia.je>
Date: Mon, 7 Aug 2023 17:55:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/6] target/loongarch: Add loongarch32 cpu la132
Content-Language: en-US
To: WANG Xuerui <i.qemu@xen0n.name>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn, 
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>
References: <20230807094505.2030603-1-c@jia.je>
 <20230807094505.2030603-3-c@jia.je>
 <c9f44271-0f17-037d-9e8b-d598a78a5e27@xen0n.name>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <c9f44271-0f17-037d-9e8b-d598a78a5e27@xen0n.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.139,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2023/8/7 17:54, WANG Xuerui wrote:
> Hi,
>
> On 2023/8/7 17:45, Jiajie Chen wrote:
>> Add la132 as a loongarch32 cpu type and allow virt machine to be used
>> with la132 instead of la464.
>>
>> Signed-off-by: Jiajie Chen <c@jia.je>
>> ---
>>   hw/loongarch/virt.c    |  5 -----
>>   target/loongarch/cpu.c | 41 +++++++++++++++++++++++++++++++++++++++++
>>   target/loongarch/cpu.h | 11 +++++++++++
>>   3 files changed, 52 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index e19b042ce8..af15bf5aaa 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -798,11 +798,6 @@ static void loongarch_init(MachineState *machine)
>>           cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
>>       }
>>   -    if (!strstr(cpu_model, "la464")) {
>> -        error_report("LoongArch/TCG needs cpu type la464");
>> -        exit(1);
>> -    }
>> -
>>       if (ram_size < 1 * GiB) {
>>           error_report("ram_size must be greater than 1G.");
>>           exit(1);
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index ad93ecac92..d31efe86da 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -362,6 +362,8 @@ static void loongarch_la464_initfn(Object *obj)
>>       CPULoongArchState *env = &cpu->env;
>>       int i;
>>   +    env->mode = LA64;
>> +
>>       for (i = 0; i < 21; i++) {
>>           env->cpucfg[i] = 0x0;
>>       }
>> @@ -439,6 +441,20 @@ static void loongarch_la464_initfn(Object *obj)
>>       env->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
>>   }
>>   +static void loongarch_la132_initfn(Object *obj)
>> +{
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>> +    CPULoongArchState *env = &cpu->env;
>> +
>> +    env->mode = LA32;
>> +
>> +    cpu->dtb_compatible = "loongarch,Loongson-3C103";
>
> "3C103"? I assume you want something like "1C300" or "1Axxx", at least 
> something prefixed with "1"...

You are right, I was meant to write "1C103"..


