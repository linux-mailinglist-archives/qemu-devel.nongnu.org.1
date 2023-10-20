Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E21157D0AFC
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 10:57:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtlJX-00019y-CJ; Fri, 20 Oct 2023 04:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qtlJV-00019q-1k
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 04:57:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qtlJR-0001TZ-Bl
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 04:57:00 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxV_HUQDJlWG8zAA--.35145S3;
 Fri, 20 Oct 2023 16:56:52 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx3y_RQDJlCyMsAA--.28075S3; 
 Fri, 20 Oct 2023 16:56:51 +0800 (CST)
Subject: Re: [PATCH v2 2/4] target/loongarch: Add cpu feature flags
To: maobibo <maobibo@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@redhat.com,
 peter.maydell@linaro.org, eblake@redhat.com, armbru@redhat.com
References: <20231019125853.3436531-1-gaosong@loongson.cn>
 <20231019125853.3436531-3-gaosong@loongson.cn>
 <a3448f95-bcb5-f4ba-2cb0-65a80501ef5a@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <65ff7e24-2835-6b6b-cf72-60262ba0b601@loongson.cn>
Date: Fri, 20 Oct 2023 16:56:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a3448f95-bcb5-f4ba-2cb0-65a80501ef5a@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bx3y_RQDJlCyMsAA--.28075S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ArW3WrWxJFWUZw18tw1xXrc_yoW8Wr17p3
 97AF90kFW8WrZ7C3WfX3y5Xr98Xr1xGa12qF1xKa48CF45XryI9F10qanFgF1DJ3yrWr1I
 gr1Fkry5uF47Z3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU8j-e5UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.339,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

在 2023/10/20 下午4:05, maobibo 写道:
>
>
> 在 2023/10/19 下午8:58, Song Gao 写道:
>> CPULoongArchState adds cpu feature flags features.
>> Intrduce loongarch_feature() to check feature and
>> set_feature() to set feature.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   target/loongarch/cpu.c |  4 ++++
>>   target/loongarch/cpu.h | 32 ++++++++++++++++++++++++++++++++
>>   2 files changed, 36 insertions(+)
>>
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index ef6922e812..87fcd08110 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -366,6 +366,10 @@ static void loongarch_la464_initfn(Object *obj)
>>       CPULoongArchState *env = &cpu->env;
>>       int i;
>>   +    env->features = 0;
>> +    set_feature(env, CPU_FEATURE_LSX);
>> +    set_feature(env, CPU_FEATURE_LASX);
>> +
>>       for (i = 0; i < 21; i++) {
>>           env->cpucfg[i] = 0x0;
>>       }
>> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
>> index 8b54cf109c..b98064945a 100644
>> --- a/target/loongarch/cpu.h
>> +++ b/target/loongarch/cpu.h
>> @@ -295,6 +295,8 @@ typedef struct CPUArchState {
>>       uint64_t lladdr; /* LL virtual address compared against SC */
>>       uint64_t llval;
>>   +    uint64_t features;
> Like what Richard says, it is not necessary to use features here,
> cpucfg2 can be used directly.
>
Agreed,  I dropped this patch on v3.

Thanks.
Song Gao


