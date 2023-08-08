Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E3D77382F
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 08:29:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTGCo-0004tk-Ix; Tue, 08 Aug 2023 02:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1qTGCl-0004tD-S3
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 02:28:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1qTGCi-0007DO-WC
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 02:28:31 -0400
Received: from loongson.cn (unknown [10.20.42.170])
 by gateway (Coremail) with SMTP id _____8AxV_GH4NFkTqESAA--.41883S3;
 Tue, 08 Aug 2023 14:28:24 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTSOF4NFkXoROAA--.49049S3; 
 Tue, 08 Aug 2023 14:28:21 +0800 (CST)
Message-ID: <ff531ad1-fdc6-8c5f-7777-df36604f62fe@loongson.cn>
Date: Tue, 8 Aug 2023 14:28:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/loongarch: Split fcc register to fcc0-7 in gdbstub
Content-Language: en-US
From: bibo mao <maobibo@loongson.cn>
To: Jiajie Chen <c@jia.je>, Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
References: <20230808054315.3391465-1-c@jia.je>
 <70c07fd1-51c6-56cd-af40-04a8323b06c5@loongson.cn>
In-Reply-To: <70c07fd1-51c6-56cd-af40-04a8323b06c5@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTSOF4NFkXoROAA--.49049S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGrW8Jw4UuF18XFW7XF48Xwc_yoW5CF4kp3
 s3Aan8GF4Ig39rtrnrX3s0g3Z8ArnrCF1F93WfW340kayDXFWagas8G39xuFW7Cayxtr1F
 grZYyw1xu3W5JrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU1QVy3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.809,
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

add loongarch gdb maintainer.

在 2023/8/8 14:10, bibo mao 写道:
> 
> I am not familiar with gdb, is there  abi breakage?
> I do not know how gdb client works with gdb server with different versions.
> 
> Regards
> Bibo Mao
> 
> 
> 在 2023/8/8 13:42, Jiajie Chen 写道:
>> Since GDB 13.1(GDB commit ea3352172), GDB LoongArch changed to use
>> fcc0-7 instead of fcc register. This commit partially reverts commit
>> 2f149c759 (`target/loongarch: Update gdb_set_fpu() and gdb_get_fpu()`)
>> to match the behavior of GDB.
>>
>> Note that it is a breaking change for GDB 13.0 or earlier, but it is
>> also required for GDB 13.1 or later to work.
>>
>> Signed-off-by: Jiajie Chen <c@jia.je>
>> ---
>>  gdb-xml/loongarch-fpu.xml  |  9 ++++++++-
>>  target/loongarch/gdbstub.c | 16 +++++++---------
>>  2 files changed, 15 insertions(+), 10 deletions(-)
>>
>> diff --git a/gdb-xml/loongarch-fpu.xml b/gdb-xml/loongarch-fpu.xml
>> index 78e42cf5dd..e81e3382e7 100644
>> --- a/gdb-xml/loongarch-fpu.xml
>> +++ b/gdb-xml/loongarch-fpu.xml
>> @@ -45,6 +45,13 @@
>>    <reg name="f29" bitsize="64" type="fputype" group="float"/>
>>    <reg name="f30" bitsize="64" type="fputype" group="float"/>
>>    <reg name="f31" bitsize="64" type="fputype" group="float"/>
>> -  <reg name="fcc" bitsize="64" type="uint64" group="float"/>
>> +  <reg name="fcc0" bitsize="8" type="uint8" group="float"/>
>> +  <reg name="fcc1" bitsize="8" type="uint8" group="float"/>
>> +  <reg name="fcc2" bitsize="8" type="uint8" group="float"/>
>> +  <reg name="fcc3" bitsize="8" type="uint8" group="float"/>
>> +  <reg name="fcc4" bitsize="8" type="uint8" group="float"/>
>> +  <reg name="fcc5" bitsize="8" type="uint8" group="float"/>
>> +  <reg name="fcc6" bitsize="8" type="uint8" group="float"/>
>> +  <reg name="fcc7" bitsize="8" type="uint8" group="float"/>
>>    <reg name="fcsr" bitsize="32" type="uint32" group="float"/>
>>  </feature>
>> diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
>> index 0752fff924..15ad6778f1 100644
>> --- a/target/loongarch/gdbstub.c
>> +++ b/target/loongarch/gdbstub.c
>> @@ -70,10 +70,9 @@ static int loongarch_gdb_get_fpu(CPULoongArchState *env,
>>  {
>>      if (0 <= n && n < 32) {
>>          return gdb_get_reg64(mem_buf, env->fpr[n].vreg.D(0));
>> -    } else if (n == 32) {
>> -        uint64_t val = read_fcc(env);
>> -        return gdb_get_reg64(mem_buf, val);
>> -    } else if (n == 33) {
>> +    } else if (32 <= n && n < 40) {
>> +        return gdb_get_reg8(mem_buf, env->cf[n - 32]);
>> +    } else if (n == 40) {
>>          return gdb_get_reg32(mem_buf, env->fcsr0);
>>      }
>>      return 0;
>> @@ -87,11 +86,10 @@ static int loongarch_gdb_set_fpu(CPULoongArchState *env,
>>      if (0 <= n && n < 32) {
>>          env->fpr[n].vreg.D(0) = ldq_p(mem_buf);
>>          length = 8;
>> -    } else if (n == 32) {
>> -        uint64_t val = ldq_p(mem_buf);
>> -        write_fcc(env, val);
>> -        length = 8;
>> -    } else if (n == 33) {
>> +    } else if (32 <= n && n < 40) {
>> +        env->cf[n - 32] = ldub_p(mem_buf);
>> +        length = 1;
>> +    } else if (n == 40) {
>>          env->fcsr0 = ldl_p(mem_buf);
>>          length = 4;
>>      }
> 


