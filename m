Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC06782148
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 04:02:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXuDi-0000Bw-Vd; Sun, 20 Aug 2023 22:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1qXuDg-0000Bh-1v
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 22:00:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1qXuDa-0007IF-VH
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 22:00:37 -0400
Received: from loongson.cn (unknown [10.20.42.170])
 by gateway (Coremail) with SMTP id _____8CxRug8xeJkOXMaAA--.768S3;
 Mon, 21 Aug 2023 10:00:28 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxX887xeJk9iNfAA--.35306S3; 
 Mon, 21 Aug 2023 10:00:27 +0800 (CST)
Message-ID: <3a88d99c-62f5-ff47-81c9-07b687c3a800@loongson.cn>
Date: Mon, 21 Aug 2023 10:00:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/loongarch: Fix ACPI processor id off-by-one error
Content-Language: en-US
To: Jiajie Chen <c@jia.je>
Cc: richard.henderson@linaro.org, gaosong@loongson.cn,
 zhaotianrui@loongson.cn, qemu-devel@nongnu.org, =?UTF-8?B?5p2O6aaZ5p2l?=
 <lixianglai@loongson.cn>
References: <20230820105658.99123-2-c@jia.je>
 <5b4b93c2-bfe2-09b0-facd-42f899767451@loongson.cn>
 <df896eaa-599d-26f1-1efa-36e57cd8bc71@jia.je>
From: bibo mao <maobibo@loongson.cn>
In-Reply-To: <df896eaa-599d-26f1-1efa-36e57cd8bc71@jia.je>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxX887xeJk9iNfAA--.35306S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWr1rWr1UXr1rurykuFW5CFX_yoW5KFyxpF
 W0yF48Kr1kW3WSk3s2yw4SgFyrtr18Jw47u3W8KryDAa4vgry8tFyIkrWa9FZrJr1rC3Z2
 vw4Utw17uF47ZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
 xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
 AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
 42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
 IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
 KfnxnUUI43ZEXa7IU8czVUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.279,
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



在 2023/8/21 09:29, Jiajie Chen 写道:
> 
> On 2023/8/21 09:24, bibo mao wrote:
>> + Add xianglai
>>
>> Good catch.
>>
>> In theory, it is logical id, and it can be not equal to physical id.
>> However it must be equal to _UID in cpu dsdt table which is missing
>> now.
> 
> Yes, the logical id can be different from index. The spec says:
> 
> If the processor structure represents an actual processor, this field must match the value of ACPI processor ID field in the processor’s entry in the MADT. If the processor structure represents a group of associated processors, the structure might match a processor container in the name space. In that case this entry will match the value of the _UID method of the associated processor container. Where there is a match it must be represented. The flags field, described in /Processor Structure Flags/, includes a bit to describe whether the ACPI processor ID is valid.
> 
> I believe PPTT, MADT and DSDT should all adhere to the same logical id mapping.
yes, if logical id is set the same with physical id, it can solve the problem
and also it may hide the potential problem about qemu/kernel etc. So I prefer
to different methods only if it comply the spec, so that we can find the issue
and solve it in early stage.

Regards
Bibo Mao

> 
>> Can pptt table parse error be fixed if cpu dsdt table is added?
>>
>> Regards
>> Bibo Mao
>>
>>
>> 在 2023/8/20 18:56, Jiajie Chen 写道:
>>> In hw/acpi/aml-build.c:build_pptt() function, the code assumes that the
>>> ACPI processor id equals to the cpu index, for example if we have 8
>>> cpus, then the ACPI processor id should be in range 0-7.
>>>
>>> However, in hw/loongarch/acpi-build.c:build_madt() function we broke the
>>> assumption. If we have 8 cpus again, the ACPI processor id in MADT table
>>> would be in range 1-8. It violates the following description taken from
>>> ACPI spec 6.4 table 5.138:
>>>
>>> If the processor structure represents an actual processor, this field
>>> must match the value of ACPI processor ID field in the processor’s entry
>>> in the MADT.
>>>
>>> It will break the latest Linux 6.5-rc6 with the
>>> following error message:
>>>
>>> ACPI PPTT: PPTT table found, but unable to locate core 7 (8)
>>> Invalid BIOS PPTT
>>>
>>> Here 7 is the last cpu index, 8 is the ACPI processor id learned from
>>> MADT.
>>>
>>> With this patch, Linux can properly detect SMT threads when "-smp
>>> 8,sockets=1,cores=4,threads=2" is passed:
>>>
>>> Thread(s) per core:  2
>>> Core(s) per socket:  2
>>> Socket(s):           2
>>>
>>> The detection of number of sockets is still wrong, but that is out of
>>> scope of the commit.
>>>
>>> Signed-off-by: Jiajie Chen <c@jia.je>
>>> ---
>>>  hw/loongarch/acpi-build.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
>>> index 0b62c3a2f7..ae292fc543 100644
>>> --- a/hw/loongarch/acpi-build.c
>>> +++ b/hw/loongarch/acpi-build.c
>>> @@ -127,7 +127,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, LoongArchMachineState *lams)
>>>          build_append_int_noprefix(table_data, 17, 1);    /* Type */
>>>          build_append_int_noprefix(table_data, 15, 1);    /* Length */
>>>          build_append_int_noprefix(table_data, 1, 1);     /* Version */
>>> -        build_append_int_noprefix(table_data, i + 1, 4); /* ACPI Processor ID */
>>> +        build_append_int_noprefix(table_data, i, 4);     /* ACPI Processor ID */
>>>          build_append_int_noprefix(table_data, arch_id, 4); /* Core ID */
>>>          build_append_int_noprefix(table_data, 1, 4);     /* Flags */
>>>      }


