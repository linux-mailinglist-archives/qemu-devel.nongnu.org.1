Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63446821622
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 02:26:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKTX7-0000tm-Ue; Mon, 01 Jan 2024 20:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rKTX5-0000rJ-3K
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:25:27 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rKTX2-0003XB-0R
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:25:26 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxoOn4ZZNlsgMBAA--.76S3;
 Tue, 02 Jan 2024 09:25:13 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzuT1ZZNlwRYVAA--.65059S3; 
 Tue, 02 Jan 2024 09:25:11 +0800 (CST)
Subject: Re: [PATCH 1/1] target/loongarch: move translate modules to tcg/
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, maobibo@loongson.cn, zhaotianrui@loongson.cn
References: <20231229092435.3416025-1-gaosong@loongson.cn>
 <bf627980-1edd-4743-889c-c27bbae971aa@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <f538cd46-2d33-8dc5-fdbd-27921c81d27f@loongson.cn>
Date: Tue, 2 Jan 2024 09:25:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bf627980-1edd-4743-889c-c27bbae971aa@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxzuT1ZZNlwRYVAA--.65059S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr45Xw1xCFWrZw4kAF4kZrc_yoWxWr1fpr
 1xCrW7KrW8CrWkAwn7XayUXFyUXwnxGwnFq3Z3tF93AwsrXry2vF40g3sFgF1UJw4rWa40
 qF18Zw17ZFWUJ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.014,
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

在 2023/12/29 下午6:08, Philippe Mathieu-Daudé 写道:
> Hi,
>
> On 29/12/23 10:24, Song Gao wrote:
>> Introduce the target/loongarch/tcg directory. Its purpose is to hold 
>> the TCG
>> code that is selected by CONFIG_TCG
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   target/loongarch/{ => tcg}/constant_timer.c     |  0
>>   target/loongarch/{ => tcg}/csr_helper.c         |  0
>>   target/loongarch/{ => tcg}/fpu_helper.c         |  0
>>   target/loongarch/{ => tcg}/iocsr_helper.c       |  0
>>   target/loongarch/{ => tcg}/op_helper.c          |  0
>>   target/loongarch/{ => tcg}/tlb_helper.c         |  0
>>   target/loongarch/{ => tcg}/translate.c          |  0
>>   target/loongarch/{ => tcg}/vec_helper.c         |  0
>>   .../{ => tcg}/insn_trans/trans_arith.c.inc      |  0
>>   .../{ => tcg}/insn_trans/trans_atomic.c.inc     |  0
>>   .../{ => tcg}/insn_trans/trans_bit.c.inc        |  0
>>   .../{ => tcg}/insn_trans/trans_branch.c.inc     |  0
>>   .../{ => tcg}/insn_trans/trans_extra.c.inc      |  0
>>   .../{ => tcg}/insn_trans/trans_farith.c.inc     |  0
>>   .../{ => tcg}/insn_trans/trans_fcmp.c.inc       |  0
>>   .../{ => tcg}/insn_trans/trans_fcnv.c.inc       |  0
>>   .../{ => tcg}/insn_trans/trans_fmemory.c.inc    |  0
>>   .../{ => tcg}/insn_trans/trans_fmov.c.inc       |  0
>>   .../{ => tcg}/insn_trans/trans_memory.c.inc     |  0
>>   .../{ => tcg}/insn_trans/trans_privileged.c.inc |  0
>>   .../{ => tcg}/insn_trans/trans_shift.c.inc      |  0
>>   .../{ => tcg}/insn_trans/trans_vec.c.inc        |  0
>>   target/loongarch/meson.build                    | 17 ++---------------
>>   target/loongarch/tcg/meson.build                | 15 +++++++++++++++
>>   24 files changed, 17 insertions(+), 15 deletions(-)
>>   rename target/loongarch/{ => tcg}/constant_timer.c (100%)
>>   rename target/loongarch/{ => tcg}/csr_helper.c (100%)
>>   rename target/loongarch/{ => tcg}/fpu_helper.c (100%)
>>   rename target/loongarch/{ => tcg}/iocsr_helper.c (100%)
>>   rename target/loongarch/{ => tcg}/op_helper.c (100%)
>>   rename target/loongarch/{ => tcg}/tlb_helper.c (100%)
>>   rename target/loongarch/{ => tcg}/translate.c (100%)
>>   rename target/loongarch/{ => tcg}/vec_helper.c (100%)
>>   rename target/loongarch/{ => tcg}/insn_trans/trans_arith.c.inc (100%)
>>   rename target/loongarch/{ => tcg}/insn_trans/trans_atomic.c.inc (100%)
>>   rename target/loongarch/{ => tcg}/insn_trans/trans_bit.c.inc (100%)
>>   rename target/loongarch/{ => tcg}/insn_trans/trans_branch.c.inc (100%)
>>   rename target/loongarch/{ => tcg}/insn_trans/trans_extra.c.inc (100%)
>>   rename target/loongarch/{ => tcg}/insn_trans/trans_farith.c.inc (100%)
>>   rename target/loongarch/{ => tcg}/insn_trans/trans_fcmp.c.inc (100%)
>>   rename target/loongarch/{ => tcg}/insn_trans/trans_fcnv.c.inc (100%)
>>   rename target/loongarch/{ => tcg}/insn_trans/trans_fmemory.c.inc 
>> (100%)
>>   rename target/loongarch/{ => tcg}/insn_trans/trans_fmov.c.inc (100%)
>>   rename target/loongarch/{ => tcg}/insn_trans/trans_memory.c.inc (100%)
>>   rename target/loongarch/{ => tcg}/insn_trans/trans_privileged.c.inc 
>> (100%)
>>   rename target/loongarch/{ => tcg}/insn_trans/trans_shift.c.inc (100%)
>>   rename target/loongarch/{ => tcg}/insn_trans/trans_vec.c.inc (100%)
>>   create mode 100644 target/loongarch/tcg/meson.build
>
>
>> diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
>> index 18e8191e2b..a004523439 100644
>> --- a/target/loongarch/meson.build
>> +++ b/target/loongarch/meson.build
>> @@ -3,31 +3,18 @@ gen = decodetree.process('insns.decode')
>>   loongarch_ss = ss.source_set()
>>   loongarch_ss.add(files(
>>     'cpu.c',
>> +  'gdbstub.c'
>
> Preferably a preliminary commit "gdbstub.c is not specific to TCG and
> can be used by other accelerators ...". Otherwise just mention it in
> this patch description.
>
I will split it to a new patch.
>>   ))
>> -loongarch_tcg_ss = ss.source_set()
>> -loongarch_tcg_ss.add(gen)
>> -loongarch_tcg_ss.add(files(
>> -  'fpu_helper.c',
>> -  'op_helper.c',
>> -  'translate.c',
>> -  'gdbstub.c',
>> -  'vec_helper.c',
>> -))
>> -loongarch_tcg_ss.add(zlib)
>>     loongarch_system_ss = ss.source_set()
>>   loongarch_system_ss.add(files(
>>     'loongarch-qmp-cmds.c',
>>     'machine.c',
>> -  'tlb_helper.c',
>> -  'constant_timer.c',
>> -  'csr_helper.c',
>> -  'iocsr_helper.c',
>>   ))
>>     common_ss.add(when: 'CONFIG_LOONGARCH_DIS', if_true: 
>> [files('disas.c'), gen])
>>   -loongarch_ss.add_all(when: 'CONFIG_TCG', if_true: [loongarch_tcg_ss])
>> +subdir('tcg')
>>     target_arch += {'loongarch': loongarch_ss}
>>   target_system_arch += {'loongarch': loongarch_system_ss}
>> diff --git a/target/loongarch/tcg/meson.build 
>> b/target/loongarch/tcg/meson.build
>> new file mode 100644
>> index 0000000000..bb7411e5e5
>> --- /dev/null
>> +++ b/target/loongarch/tcg/meson.build
>> @@ -0,0 +1,15 @@
>
> You missed the CONFIG_TCG check, you can use either:
>
>   if 'CONFIG_TCG' in config_all
>      subdir('tcg')
>   endif
>
> in target/loongarch/meson.build, but since your target seems well
> designed and doesn't require TCG stub, you can do directly here:
>
>   if 'CONFIG_TCG' not in config_all
>     subdir_done()
>   endif
>
> so the rest of this file isn't processed.
>
Got it
>> +loongarch_ss.add([zlib, gen])
>> +
>> +loongarch_ss.add(files(
>> +  'fpu_helper.c',
>> +  'op_helper.c',
>> +  'vec_helper.c',
>> +  'translate.c',
>
> (since moved/new, let's sort these files alphabetically).
>
I will corret it .

Thanks.
Song Gao
>> +))
>> +
>> +loongarch_system_ss.add(files(
>> +  'constant_timer.c',
>> +  'iocsr_helper.c',
>> +  'tlb_helper.c',
>> +  'csr_helper.c',
>
> (Ditto)
>
>> +))


