Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4107817B6
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 08:46:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXFiG-00065X-Ag; Sat, 19 Aug 2023 02:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qXFi6-00063c-9s
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 02:45:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qXFhv-0004Ac-5s
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 02:45:19 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxruvpZOBkxBYaAA--.50922S3;
 Sat, 19 Aug 2023 14:44:58 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxviPoZOBkxi9eAA--.58180S3; 
 Sat, 19 Aug 2023 14:44:56 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Split fcc register to fcc0-7 in gdbstub
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 bibo mao <maobibo@loongson.cn>
Cc: Jiajie Chen <c@jia.je>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230808054315.3391465-1-c@jia.je>
 <70c07fd1-51c6-56cd-af40-04a8323b06c5@loongson.cn>
 <df8ba12d-684b-b379-6991-8e958b8bc311@jia.je>
 <dd5eb4b9-e274-7b7f-e988-9181df271189@jia.je>
 <3615d9c9-3a26-d80c-4964-01411c668be2@loongson.cn>
 <87v8dp5qc7.fsf@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <2d957a73-1ff8-77f6-a72e-dc94e2bad4b7@loongson.cn>
Date: Sat, 19 Aug 2023 14:44:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87v8dp5qc7.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxviPoZOBkxi9eAA--.58180S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuw47Aw4ktF4Utw4rZFy3WrX_yoWxGF1Dpr
 95Aa4DGrW5X34ktr12qw1qqF90yr17G3WqqF1xXa48Cr4qqF12gr4UXr909FyUAa18Jr1j
 qryjyw17uF15ArgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UNvtZU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.454,
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

Hi, Alex

在 2023/8/9 上午2:40, Alex Bennée 写道:
> 
> bibo mao <maobibo@loongson.cn> writes:
> 
>> I think that it is problem of loongarch gdb, rather qemu.
>> If so, everytime when gdb changes register layout, qemu need modify.
>> There should be compatible requirements between gdb client and gdb server.
>>
>> Tiezhu,
>>
>> what is your opition?
> 
> You can always register additional custom regsets which is what we do
> for the extended Aarch64 regs. See ->gdb_get_dynamic_xml
> 
Thanks for you suggestions. we will use this method for vector extented.

For this patch:
Acked-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao

>>
>> Regards
>> Bibo Mao
>>
>> 在 2023/8/8 18:03, Jiajie Chen 写道:
>>>
>>> On 2023/8/8 17:55, Jiajie Chen wrote:
>>>>
>>>> On 2023/8/8 14:10, bibo mao wrote:
>>>>> I am not familiar with gdb, is there  abi breakage?
>>>>> I do not know how gdb client works with gdb server with different versions.
>>> There seemed no versioning in the process, but rather in-code xml
>>> validation. In gdb, the code only allows new xml (fcc0-7) and
>>> rejects old one (fcc), so gdb breaks qemu first and do not consider
>>> backward compatibility with qemu.
>>>>
>>>> Not abi breakage, but gdb will complain:
>>>>
>>>> warning: while parsing target description (at line 1): Target
>>>> description specified unknown architecture "loongarch64"
>>>> warning: Could not load XML target description; ignoring
>>>> warning: No executable has been specified and target does not support
>>>> determining executable automatically.  Try using the "file" command.
>>>> Truncated register 38 in remote 'g' packet
>>>
>>> Sorry, to be clear, the actual error message is:
>>>
>>> (gdb) target extended-remote localhost:1234
>>> Remote debugging using localhost:1234
>>> warning: Architecture rejected target-supplied description
>>> warning: No executable has been specified and target does not support
>>>
>>> It rejects the target description xml given by qemu, thus using the
>>> builtin one. However, there is a mismatch in fcc registers, so it
>>> will not work if we list floating point registers.
>>>
>>> At the same time, if we are using loongarch32 target(I recently
>>> posted patches to support this), it will reject the target
>>> description and fallback to loongarch64, making gcc not usable.
>>>
>>>>
>>>> And gdb can no longer debug kernel running in qemu. You can
>>>> reproduce this error using latest qemu(without this patch) and
>>>> gdb(13.1 or later).
>>>>
>>>>>
>>>>> Regards
>>>>> Bibo Mao
>>>>>
>>>>>
>>>>> 在 2023/8/8 13:42, Jiajie Chen 写道:
>>>>>> Since GDB 13.1(GDB commit ea3352172), GDB LoongArch changed to use
>>>>>> fcc0-7 instead of fcc register. This commit partially reverts commit
>>>>>> 2f149c759 (`target/loongarch: Update gdb_set_fpu() and gdb_get_fpu()`)
>>>>>> to match the behavior of GDB.
>>>>>>
>>>>>> Note that it is a breaking change for GDB 13.0 or earlier, but it is
>>>>>> also required for GDB 13.1 or later to work.
>>>>>>
>>>>>> Signed-off-by: Jiajie Chen <c@jia.je>
>>>>>> ---
>>>>>>    gdb-xml/loongarch-fpu.xml  |  9 ++++++++-
>>>>>>    target/loongarch/gdbstub.c | 16 +++++++---------
>>>>>>    2 files changed, 15 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/gdb-xml/loongarch-fpu.xml b/gdb-xml/loongarch-fpu.xml
>>>>>> index 78e42cf5dd..e81e3382e7 100644
>>>>>> --- a/gdb-xml/loongarch-fpu.xml
>>>>>> +++ b/gdb-xml/loongarch-fpu.xml
>>>>>> @@ -45,6 +45,13 @@
>>>>>>      <reg name="f29" bitsize="64" type="fputype" group="float"/>
>>>>>>      <reg name="f30" bitsize="64" type="fputype" group="float"/>
>>>>>>      <reg name="f31" bitsize="64" type="fputype" group="float"/>
>>>>>> -  <reg name="fcc" bitsize="64" type="uint64" group="float"/>
>>>>>> +  <reg name="fcc0" bitsize="8" type="uint8" group="float"/>
>>>>>> +  <reg name="fcc1" bitsize="8" type="uint8" group="float"/>
>>>>>> +  <reg name="fcc2" bitsize="8" type="uint8" group="float"/>
>>>>>> +  <reg name="fcc3" bitsize="8" type="uint8" group="float"/>
>>>>>> +  <reg name="fcc4" bitsize="8" type="uint8" group="float"/>
>>>>>> +  <reg name="fcc5" bitsize="8" type="uint8" group="float"/>
>>>>>> +  <reg name="fcc6" bitsize="8" type="uint8" group="float"/>
>>>>>> +  <reg name="fcc7" bitsize="8" type="uint8" group="float"/>
>>>>>>      <reg name="fcsr" bitsize="32" type="uint32" group="float"/>
>>>>>>    </feature>
>>>>>> diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
>>>>>> index 0752fff924..15ad6778f1 100644
>>>>>> --- a/target/loongarch/gdbstub.c
>>>>>> +++ b/target/loongarch/gdbstub.c
>>>>>> @@ -70,10 +70,9 @@ static int loongarch_gdb_get_fpu(CPULoongArchState *env,
>>>>>>    {
>>>>>>        if (0 <= n && n < 32) {
>>>>>>            return gdb_get_reg64(mem_buf, env->fpr[n].vreg.D(0));
>>>>>> -    } else if (n == 32) {
>>>>>> -        uint64_t val = read_fcc(env);
>>>>>> -        return gdb_get_reg64(mem_buf, val);
>>>>>> -    } else if (n == 33) {
>>>>>> +    } else if (32 <= n && n < 40) {
>>>>>> +        return gdb_get_reg8(mem_buf, env->cf[n - 32]);
>>>>>> +    } else if (n == 40) {
>>>>>>            return gdb_get_reg32(mem_buf, env->fcsr0);
>>>>>>        }
>>>>>>        return 0;
>>>>>> @@ -87,11 +86,10 @@ static int loongarch_gdb_set_fpu(CPULoongArchState *env,
>>>>>>        if (0 <= n && n < 32) {
>>>>>>            env->fpr[n].vreg.D(0) = ldq_p(mem_buf);
>>>>>>            length = 8;
>>>>>> -    } else if (n == 32) {
>>>>>> -        uint64_t val = ldq_p(mem_buf);
>>>>>> -        write_fcc(env, val);
>>>>>> -        length = 8;
>>>>>> -    } else if (n == 33) {
>>>>>> +    } else if (32 <= n && n < 40) {
>>>>>> +        env->cf[n - 32] = ldub_p(mem_buf);
>>>>>> +        length = 1;
>>>>>> +    } else if (n == 40) {
>>>>>>            env->fcsr0 = ldl_p(mem_buf);
>>>>>>            length = 4;
>>>>>>        }
> 
> 


