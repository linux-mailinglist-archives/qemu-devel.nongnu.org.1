Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E06897190B4
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 04:51:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4YOf-000838-Gx; Wed, 31 May 2023 22:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1q4YOb-00082g-Ke
 for qemu-devel@nongnu.org; Wed, 31 May 2023 22:50:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1q4YOW-0006Nf-M1
 for qemu-devel@nongnu.org; Wed, 31 May 2023 22:50:36 -0400
Received: from loongson.cn (unknown [10.20.42.170])
 by gateway (Coremail) with SMTP id _____8AxR_F0B3hk8SkDAA--.7113S3;
 Thu, 01 Jun 2023 10:50:28 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxab1xB3hkz3KDAA--.15406S3; 
 Thu, 01 Jun 2023 10:50:25 +0800 (CST)
Message-ID: <c1f996bc-4b20-7f90-114a-620b6e09ee71@loongson.cn>
Date: Thu, 1 Jun 2023 10:50:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] hw/smbios: fix thead count field in type 4 table
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 gaosong@loongson.cn, Zhenyu Wang <zhenyu.z.wang@intel.com>
References: <20230530122034.547109-1-zhaotianrui@loongson.cn>
 <ZHcIcaQIlnQVsmbP@liuzhao-OptiPlex-7080>
 <9d514025-2b95-03c2-5391-662c392fe185@loongson.cn>
 <ZHgB4DVk0pIEzuIS@liuzhao-OptiPlex-7080>
From: "bibo, mao" <maobibo@loongson.cn>
In-Reply-To: <ZHgB4DVk0pIEzuIS@liuzhao-OptiPlex-7080>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxab1xB3hkz3KDAA--.15406S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxJFWUWw4xCryDZF45Wr1DAwb_yoWrXFWxpr
 yDJF4qgr4rGr10gws2v3WYgry0yrsYqa1UXw42q34Fy34DK3WFqa48tr4YkFn2yF1kK3W0
 qr4UuF4akF1vvr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
 bI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
 1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
 wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
 x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
 e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
 IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4U
 McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
 C2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



在 2023/6/1 10:26, Zhao Liu 写道:
> On Thu, Jun 01, 2023 at 09:09:13AM +0800, bibo, mao wrote:
>> Date: Thu, 1 Jun 2023 09:09:13 +0800
>> From: "bibo, mao" <maobibo@loongson.cn>
>> Subject: Re: [PATCH] hw/smbios: fix thead count field in type 4 table
>>
>>
>>
>> 在 2023/5/31 16:42, Zhao Liu 写道:
>>> On Tue, May 30, 2023 at 08:20:34PM +0800, Tianrui Zhao wrote:
>>>> Date: Tue, 30 May 2023 20:20:34 +0800
>>>> From: Tianrui Zhao <zhaotianrui@loongson.cn>
>>>> Subject: [PATCH] hw/smbios: fix thead count field in type 4 table
>>>> X-Mailer: git-send-email 2.39.1
>>>>
>>>> The thread_count value in smbios type_4 table should be
>>>> (ms->smp.cores * ms->smp.threads). As according to smbios spec 7.5
>>>> Processor Information (Type 4), the field "Thread Count" means the
>>>> "Number of threads per processor socket" rather than number of
>>>> threads per core.
>>>>
>>>> When apply this patch, use "-smp 4,sockets=1,cores=2,threads=2" to
>>>> boot VM, the dmidecode -t 4 shows like:
>>>>
>>>> Handle 0x0400, DMI type 4, 48 bytes
>>>> Processor Information
>>>>           Socket Designation: CPU 0
>>>>           ...
>>>>           Core Count: 2
>>>>           Core Enabled: 2
>>>>           Thread Count: 4
>>>>           Characteristics: None
>>>>
>>>> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
>>>> ---
>>>>    hw/smbios/smbios.c | 7 ++++---
>>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
>>>> index d2007e70fb..56aeaa069d 100644
>>>> --- a/hw/smbios/smbios.c
>>>> +++ b/hw/smbios/smbios.c
>>>> @@ -713,6 +713,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
>>>>    {
>>>>        char sock_str[128];
>>>>        size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
>>>> +    int count;
>>>>        if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
>>>>            tbl_len = SMBIOS_TYPE_4_LEN_V30;
>>>> @@ -749,15 +750,15 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
>>>>        t->core_count = (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
>>>>        t->core_enabled = t->core_count;
>>>> -
>>>> -    t->thread_count = (ms->smp.threads > 255) ? 0xFF : ms->smp.threads;
>>>> +    count = ms->smp.cores * ms->smp.threads;
>>>
>>> Hi Ani & Tianrui,
>>>
>>>   From the comment of CpuTopology (include/hw/boards.h):
>>>
>>> ms->cores means the "the number of cores in one cluster".
>>> ms->threads means the "the number of threads in one core".
>>>
>>> So ms->cores * ms->threads means the number of threads in one cluster
>>> not one socket.
>>>
>>> That's why I count the number of threads in a socket by "ms->smp.max_cpus
>>> / ms->smp.sockets" in [1].
>>>
>>> The other correct way is:
>>> ms->smp.cluster * ms->smp.cores * ms->smp.threads.
>>>
>>> [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg07229.html
>> ohh, we do not notice your patch. Your patch is better than us. one small
>> nit about core_count calcuation if cluster/die is support. core count should
>> be core number
>>   per package rather than per cluster or per die.
>>
>> so it should be something like this?
>>      t->core_count = cpus_per_socket / ms->smp.threads
>> rather than ms->smp.cores
> 
> Yes, I also fixed this in the third patch of my patch series [2].
> 
> [2]: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg07231.html

Great, that sounds good to me.

Regards
Bibo, Mao

> 
> Regards,
> Zhao
> 
>>
>>
>> Regards
>> Bibo, mao
>>>
>>> Thanks,
>>> Zhao
>>>
>>>> +    t->thread_count = (count > 255) ? 0xFF : count;
>>>>        t->processor_characteristics = cpu_to_le16(0x02); /* Unknown */
>>>>        t->processor_family2 = cpu_to_le16(0x01); /* Other */
>>>>        if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
>>>>            t->core_count2 = t->core_enabled2 = cpu_to_le16(ms->smp.cores);
>>>> -        t->thread_count2 = cpu_to_le16(ms->smp.threads);
>>>> +        t->thread_count2 = cpu_to_le16(count);
>>>>        }
>>>>        SMBIOS_BUILD_TABLE_POST;
>>>> -- 
>>>> 2.39.1
>>>>
>>>>
>>
>>


