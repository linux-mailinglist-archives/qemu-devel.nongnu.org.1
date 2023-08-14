Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABFF77B421
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 10:29:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVSwp-0006pP-V0; Mon, 14 Aug 2023 04:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qVSwn-0006no-GC
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 04:29:09 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qVSwg-0000Jy-3H
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 04:29:09 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Cxc_DJ5dlkGA0YAA--.49709S3;
 Mon, 14 Aug 2023 16:28:57 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxLCPG5dlkpaZZAA--.5292S3; 
 Mon, 14 Aug 2023 16:28:54 +0800 (CST)
Subject: Re: [PATCH v2 3/8] target/loongarch: Add avail_64 to check la64-only
 instructions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn,
 yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230811100208.271649-1-gaosong@loongson.cn>
 <20230811100208.271649-4-gaosong@loongson.cn>
 <3d151e82-f431-37b3-dae2-e111ee3946eb@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <44ac9338-e4a5-92b1-fc81-7c2b051a1854@loongson.cn>
Date: Mon, 14 Aug 2023 16:28:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3d151e82-f431-37b3-dae2-e111ee3946eb@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxLCPG5dlkpaZZAA--.5292S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr18Zr1fJry5KFyfXr15WrX_yoW5XF4fpF
 Z5GanFgw4qy3WxZr18J34qqr13ZFnYgwnxGFyDZw1UAFW7ZF92grySyr4a9Fyxur4Igr1a
 y34a9r1UZFZ8AFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
 db8UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.359,
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

Hi, Richard

在 2023/8/12 上午12:00, Richard Henderson 写道:
> On 8/11/23 03:02, Song Gao wrote:
>> The la32 manual from [1], and it is not the final version.
>>
>> [1]: 
>> https://www.loongson.cn/uploads/images/2023041918122813624.%E9%BE%99%E8%8A%AF%E6%9E%B6%E6%9E%8432%E4%BD%8D%E7%B2%BE%E7%AE%80%E7%89%88%E5%8F%82%E8%80%83%E6%89%8B%E5%86%8C_r1p03.pdf 
>>
> 
> I really hope this manual will be changed before final.
>  >
>> -TRANS(pcaddi, ALL, gen_pc, gen_pcaddi)
>> -TRANS(pcalau12i, ALL, gen_pc, gen_pcalau12i)
>> +TRANS(pcaddi, 64, gen_pc, gen_pcaddi)
>> +TRANS(pcalau12i, 64, gen_pc, gen_pcalau12i)
>>   TRANS(pcaddu12i, ALL, gen_pc, gen_pcaddu12i)
>> -TRANS(pcaddu18i, ALL, gen_pc, gen_pcaddu18i)
>> +TRANS(pcaddu18i, 64, gen_pc, gen_pcaddu18i)
> 
> For the compiler, PCALAU12I is much more useful than PCADDU12I.
> 
> Because PCALAU12I produces zeros in the lower 12 bits, the high-part 
> pc-relative relocation does not need to be paired with a corresponding 
> low-part pc-relative relocation.
> 
> Whereas PCADDU12I produces a full 32-bit result, and the low-part 
> pc-relative relocation needs to know where the high-part was produced in 
> order to compensate.  This fundamental error was made by the RISC-V ISA, 
> and their toolchain is still paying the price.
> 
> 
>> @@ -69,6 +77,10 @@ static bool trans_cpucfg(DisasContext *ctx, 
>> arg_cpucfg *a)
>>       TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
>>       TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
>> +    if (!avail_64(ctx)) {
>> +        return false;
>> +    }
> 
> For the operating system running on LA32, lack of CPUCFG means that you 
> now have to provide the cpu configuration in another way:
> 
> (1) Via compilation options, such that one operating system build will 
> only run on a single cpu.
> 
> (2) Via external data, like device tree.
> 
> Either option complicates the usage of LA32.
> 
> I would hope that a few words of rom for CPUCFG to read is not too 
> expensive to incorporate in even the smallest cpu implementation.
> 
> 
Thank you for pointing out the problems.

Cc: yijun@loongson.cn
Cc: shenjinyang@loongson.cn

Hi, yijun and shenjingyang. You are more familiar with LA32, How about 
Richard's points?  Could you review this patch?

And I realized that [1] is the LA32 Lite Edition Manual, not the LA32 
Manual.

Could you list more differences between the LA32 and the LA32 Lite 
Edition? Especially instructions.

[1]:
https://www.loongson.cn/uploads/images/2023041918122813624.%E9%BE%99%E8%8A%AF%E6%9E%B6%E6%9E%8432%E4%BD%8D%E7%B2%BE%E7%AE%80%E7%89%88%E5%8F%82%E8%80%83%E6%89%8B%E5%86%8C_r1p03.pdf

Thanks,
Song Gao


