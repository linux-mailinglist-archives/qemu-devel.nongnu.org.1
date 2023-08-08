Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 639B977412A
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:15:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQHf-00036G-P5; Tue, 08 Aug 2023 13:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTQHR-0002yF-4e
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:14:03 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTQHP-0004aO-B1
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:14:00 -0400
Received: from [172.20.10.3] (unknown [112.97.80.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id E794143F30;
 Tue,  8 Aug 2023 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691514828; bh=c7Y9kr3QRwBMIQ68FTmg11oEsWUdMGGstLnB4XvpxxQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=oiy0Fr8djnoXTZoOH2k/OFBS7GdzMmUPI2bi50inP6SXssu0LMfp/ilijCXun2Lbs
 kvQcYO7Y6SZ8zgsj9bd/xtkwRcPhX94IBhVAcVeDumaeel8nGdj4oIf4P5XxxYvhFV
 ZDCxrjcuvlKG0wDs2An4w96a8lyz3ahRazRWLNWs=
Message-ID: <6783fb78-b346-1395-da8e-648792557909@jia.je>
Date: Wed, 9 Aug 2023 01:13:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 01/11] target/loongarch: Add macro to check current arch
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, gaosong@loongson.cn,
 i.qemu@xen0n.name
References: <20230808015506.1705140-1-c@jia.je>
 <20230808015506.1705140-2-c@jia.je>
 <68c43230-1198-5d46-5450-26b8f61bd09b@linaro.org>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <68c43230-1198-5d46-5450-26b8f61bd09b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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


On 2023/8/9 01:01, Richard Henderson wrote:
> On 8/7/23 18:54, Jiajie Chen wrote:
>> Add macro to check if the current cpucfg[1].arch equals to 1(LA32) or
>> 2(LA64).
>>
>> Signed-off-by: Jiajie Chen <c@jia.je>
>> ---
>>   target/loongarch/cpu.h | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
>> index fa371ca8ba..bf0da8d5b4 100644
>> --- a/target/loongarch/cpu.h
>> +++ b/target/loongarch/cpu.h
>> @@ -132,6 +132,13 @@ FIELD(CPUCFG1, HP, 24, 1)
>>   FIELD(CPUCFG1, IOCSR_BRD, 25, 1)
>>   FIELD(CPUCFG1, MSG_INT, 26, 1)
>>   +/* cpucfg[1].arch */
>> +#define CPUCFG1_ARCH_LA32        1
>> +#define CPUCFG1_ARCH_LA64        2
>> +
>> +#define LOONGARCH_CPUCFG_ARCH(env, mode) \
>> +  (FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_##mode)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> But in using this recall that 0 is a defined value for "simplified 
> la32", so
>
>    !LOONGARCH_CPUCFG_ARCH(env, LA64)
>
> may not in future equal
>
>    LOONGARCH_CPUCFG_ARCH(env, LA32)
>
> it someone ever decides to implement this simplified version. (We 
> emulate very small embedded Arm cpus, so it's not out of the question 
> that you may want to emulate the very smallest LoongArch cpus.)


Yes, actually the LoongArch 32 Reduced (or "simplified la32") version is 
my final aim because we are making embedded LoongArch32 Reduced CPUs on 
FPGA for a competition, and supporting LoongArch 32 is the first step ahead.


>
> It might be easier to just define
>
> static inline bool is_la64(CPULoongArch64 *env)
> {
>     return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == 
> CPUCFG1_ARCH_LA64;
> }


Sure, I will use this way.


>
>
> r~

