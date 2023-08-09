Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 758CD775434
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 09:33:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTdgJ-0003cb-HJ; Wed, 09 Aug 2023 03:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTdg2-0003c9-Hc
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 03:32:18 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTdg0-0006jG-Lb
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 03:32:18 -0400
Received: from [192.168.0.109] (unknown [120.229.30.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id DC36543C6D;
 Wed,  9 Aug 2023 07:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691566334; bh=G03jgLA5SAb6Nxs6YSORiqsQhaqEOWkFZF7a7tgFsoA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=vQxkqp1PQs+dTKbwLxGZFS5MjSsLk8Z4wsAxPZfbAoTw6WfRemwsdHDQG2aOoRp/T
 7nL9qUUflqr8Lj4p/pSqyPWBqsBpogXUoemoyRz2IN0BaCpNC/W/bSfV/DgE9RSEuZ
 oGMdIxSSBvcBri+rryHKl5COnpd+wQYcxOLU8qOM=
Message-ID: <284e0f37-97ae-294d-9cc5-6b36c4946aa5@jia.je>
Date: Wed, 9 Aug 2023 15:31:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 11/11] target/loongarch: Add loongarch32 cpu la132
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, gaosong@loongson.cn,
 i.qemu@xen0n.name
References: <20230808015506.1705140-1-c@jia.je>
 <20230808015506.1705140-12-c@jia.je>
 <cc87d409-861a-a3dc-eb3b-57e58c88619a@linaro.org>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <cc87d409-861a-a3dc-eb3b-57e58c88619a@linaro.org>
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


On 2023/8/9 03:26, Richard Henderson wrote:
> On 8/7/23 18:54, Jiajie Chen wrote:
>> +static void loongarch_la464_initfn(Object *obj)
>> +{
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>> +    CPULoongArchState *env = &cpu->env;
>> +
>> +    loongarch_cpu_initfn_common(env);
>> +
>> +    cpu->dtb_compatible = "loongarch,Loongson-3A5000";
>> +    env->cpucfg[0] = 0x14c010;  /* PRID */
>> +
>> +    uint32_t data = env->cpucfg[1];
>> +    data = FIELD_DP32(data, CPUCFG1, ARCH, 2); /* LA64 */
>> +    data = FIELD_DP32(data, CPUCFG1, PALEN, 0x2f); /* 48 bits */
>> +    data = FIELD_DP32(data, CPUCFG1, VALEN, 0x2f); /* 48 bits */
>> +    data = FIELD_DP32(data, CPUCFG1, RI, 1);
>> +    data = FIELD_DP32(data, CPUCFG1, EP, 1);
>> +    data = FIELD_DP32(data, CPUCFG1, RPLV, 1);
>> +    env->cpucfg[1] = data;
>> +}
>> +
>> +static void loongarch_la132_initfn(Object *obj)
>> +{
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>> +    CPULoongArchState *env = &cpu->env;
>> +
>> +    loongarch_cpu_initfn_common(env);
>> +
>> +    cpu->dtb_compatible = "loongarch,Loongson-1C103";
>> +
>> +    uint32_t data = env->cpucfg[1];
>> +    data = FIELD_DP32(data, CPUCFG1, ARCH, 1); /* LA32 */
>> +    data = FIELD_DP32(data, CPUCFG1, PALEN, 0x1f); /* 32 bits */
>> +    data = FIELD_DP32(data, CPUCFG1, VALEN, 0x1f); /* 32 bits */
>> +    data = FIELD_DP32(data, CPUCFG1, RI, 0);
>> +    data = FIELD_DP32(data, CPUCFG1, EP, 0);
>> +    data = FIELD_DP32(data, CPUCFG1, RPLV, 0);
>> +    env->cpucfg[1] = data;
>> +}
>
> The use of the loongarch_cpu_initfn_common function is not going to 
> scale.
> Compare the set of *_initfn in target/arm/tcg/cpu32.c
>
> In general, you want to copy data in bulk from the processor manual, 
> so that the reviewer can simply read through the table and see that 
> the code is correct, without having to check between multiple 
> functions to see that the combination is correct.
>
> For our existing la464, that table is Table 54 in the 3A5000 manual.
>
> Is there a public specification for the la132?  I could not find one 
> in https://www.loongson.cn/EN/product/, but perhaps that's just the 
> english view.


There seems no, even from the chinese view.


>
>
> r~

