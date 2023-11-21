Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4249C7F2353
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 02:51:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5FuH-0001tc-OW; Mon, 20 Nov 2023 20:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1r5FuF-0001t1-9p
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 20:50:27 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1r5Fu8-0000zd-2x
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 20:50:27 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Dxg_DSDFxl6mk7AA--.52194S3;
 Tue, 21 Nov 2023 09:50:10 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxeuTPDFxldANIAA--.29160S3; 
 Tue, 21 Nov 2023 09:50:10 +0800 (CST)
Subject: Re: [PATCH 1/1] tcg/loongarch64: Fix tcg_out_mov() Aborted
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, git@xen0n.name, c@jia.je, maobibo@loongson.cn
References: <20231120065916.374045-1-gaosong@loongson.cn>
 <e99f440c-6d95-4e7c-b08e-332897062997@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <52827a12-0d3f-3946-a204-747b10037055@loongson.cn>
Date: Tue, 21 Nov 2023 09:50:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e99f440c-6d95-4e7c-b08e-332897062997@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxeuTPDFxldANIAA--.29160S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF45Zw1fXw4fWrW7AF1fGrX_yoW5CF4xpr
 yrKF4rKrWrtrWkArsFva4DXFyxG3yY93W2q3Wrt3W8ArsrZr1jvr1xWr42gFyj9a1IgrW8
 ZFnIvr1avF4jyagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1EksDUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.009,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

在 2023/11/20 下午11:59, Richard Henderson 写道:
> On 11/19/23 22:59, Song Gao wrote:
>> On LoongArch host,  we got an Aborted from tcg_out_mov().
>>
>> qemu-x86_64 configure with '--enable-debug'.
>>
>>> (gdb) b /home1/gaosong/code/qemu/tcg/loongarch64/tcg-target.c.inc:312
>>> Breakpoint 1 at 0x2576f0: file 
>>> /home1/gaosong/code/qemu/tcg/loongarch64/tcg-target.c.inc, line 312.
>>> (gdb) run hello
>> [...]
>>> Thread 1 "qemu-x86_64" hit Breakpoint 1, tcg_out_mov (s=0xaaaae91760 
>>> <tcg_init_ctx>, type=TCG_TYPE_V128, ret=TCG_REG_V2,
>>>      arg=TCG_REG_V0) at 
>>> /home1/gaosong/code/qemu/tcg/loongarch64/tcg-target.c.inc:312
>>> 312           g_assert_not_reached();
>>> (gdb) bt
>>> #0  tcg_out_mov (s=0xaaaae91760 <tcg_init_ctx>, type=TCG_TYPE_V128, 
>>> ret=TCG_REG_V2, arg=TCG_REG_V0)
>>>      at /home1/gaosong/code/qemu/tcg/loongarch64/tcg-target.c.inc:312
>>> #1  0x000000aaaad0fee0 in tcg_reg_alloc_mov (s=0xaaaae91760 
>>> <tcg_init_ctx>, op=0xaaaaf67c20) at ../tcg/tcg.c:4632
>>> #2  0x000000aaaad142f4 in tcg_gen_code (s=0xaaaae91760 
>>> <tcg_init_ctx>, tb=0xffe8030340 <code_gen_buffer+197328>,
>>>      pc_start=4346094) at ../tcg/tcg.c:6135
>> [...]
>>> (gdb) c
>>> Continuing.
>>> **
>>> ERROR:/home1/gaosong/code/qemu/tcg/loongarch64/tcg-target.c.inc:312:tcg_out_mov: 
>>> code should not be reached
>>> Bail out! 
>>> ERROR:/home1/gaosong/code/qemu/tcg/loongarch64/tcg-target.c.inc:312:tcg_out_mov: 
>>> code should not be reached
>>>
>>> Thread 1 "qemu-x86_64" received signal SIGABRT, Aborted.
>>> 0x000000fff7b1c390 in raise () from /lib64/libc.so.6
>>> (gdb) q
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   tcg/loongarch64/tcg-target.c.inc | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/tcg/loongarch64/tcg-target.c.inc 
>> b/tcg/loongarch64/tcg-target.c.inc
>> index a588fb3085..5f68040230 100644
>> --- a/tcg/loongarch64/tcg-target.c.inc
>> +++ b/tcg/loongarch64/tcg-target.c.inc
>> @@ -308,6 +308,9 @@ static bool tcg_out_mov(TCGContext *s, TCGType 
>> type, TCGReg ret, TCGReg arg)
>>            */
>>           tcg_out_opc_or(s, ret, arg, TCG_REG_ZERO);
>>           break;
>> +    case TCG_TYPE_V128:
>> +        tcg_out_opc_vaddi_du(s, ret, arg, 0);
>> +        break;
>
> Is add with immediate zero really the canonical alias for "vector move"?
>
> There is often some form that is recommended by the architecture, so 
> that it may be recognized for register renaming.  Usually it is some 
> form of logic instruction, not arithmetic.  I see that LLVM emits 
> "vori.b dst, src, 0" for this case.
> adfadf
you are right,
I see  the insn  'mov '  opcode is '00150000'.  it is 'or dst, src, zero'.

Thanks.
Song Gao
> Regardless, this patch works to fix the assert so,
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~


