Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 506B179A7E9
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 14:28:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfg1D-0007X5-Sq; Mon, 11 Sep 2023 08:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qfg19-0007Vh-Lh
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 08:27:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qfg13-0001zg-Oh
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 08:27:51 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxJvG4B_9klKYkAA--.6383S3;
 Mon, 11 Sep 2023 20:27:36 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxLCO2B_9kG1d3AA--.2317S3; 
 Mon, 11 Sep 2023 20:27:34 +0800 (CST)
Subject: Re: [PATCH RESEND v5 14/57] target/loongarch: Implement xvadd/xvsub
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-15-gaosong@loongson.cn>
 <24a9ba29-e6a0-2f97-0b5a-de0adf5680cf@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <6bb654bb-1f7c-8e75-a530-3c10644474f4@loongson.cn>
Date: Mon, 11 Sep 2023 20:27:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <24a9ba29-e6a0-2f97-0b5a-de0adf5680cf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxLCO2B_9kG1d3AA--.2317S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFyUWw15GFyrJw1UXr1xtFc_yoW8KF1rpr
 18JrWUAFWUJr1fJr1Utr1UAry5Ar18Jw1UJr1rXF18Ar4UJr1jgF15Xw1qgr1UJr4kCr1U
 Ar17Zr17Zr17JrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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

在 2023/9/10 上午9:44, Richard Henderson 写道:
> On 9/7/23 01:31, Song Gao wrote:
>> --- a/target/loongarch/insn_trans/trans_vec.c.inc
>> +++ b/target/loongarch/insn_trans/trans_vec.c.inc
>> @@ -208,6 +208,16 @@ static bool gvec_vvv(DisasContext *ctx, arg_vvv 
>> *a, MemOp mop,
>>       return gvec_vvv_vl(ctx, a, 16, mop, func);
>>   }
>> +static bool gvec_xxx(DisasContext *ctx, arg_vvv *a, MemOp mop,
>> +                     void (*func)(unsigned, uint32_t, uint32_t,
>> +                                  uint32_t, uint32_t, uint32_t))
>> +{
>> +    if (!check_vec(ctx, 32)) {
>> +        return true;
>> +    }
>> +
>> +    return gvec_vvv_vl(ctx, a, 32, mop, func);
>> +}
> 
> You can move check_vec into gvec_vvv_vl, removing it from gvec_vvv.
> 
>> +static bool gen_vaddsub_q_vl(DisasContext *ctx, arg_vvv *a, uint32_t 
>> oprsz,
>> +                             void (*func)(TCGv_i64, TCGv_i64, TCGv_i64,
>> +                                          TCGv_i64, TCGv_i64, TCGv_i64))
>> +{
>> +    int i;
>> +    TCGv_i64 rh, rl, ah, al, bh, bl;
> 
> Have check_vec here ...
> 
>> +static bool gen_vaddsub_q(DisasContext *ctx, arg_vvv *a,
>> +                          void (*func)(TCGv_i64, TCGv_i64, TCGv_i64,
>> +                                       TCGv_i64, TCGv_i64, TCGv_i64))
>> +{
>> +    if (!check_vec(ctx, 16)) {
>> +        return true;
>> +    }
>> +
>> +    return gen_vaddsub_q_vl(ctx, a, 16, func);
>> +}
>> +
>> +static bool gen_xvaddsub_q(DisasContext *ctx, arg_vvv *a,
>> +                           void (*func)(TCGv_i64, TCGv_i64, TCGv_i64,
>> +                                        TCGv_i64, TCGv_i64, TCGv_i64))
>> +{
>> +    if (!check_vec(ctx, 32)) {
>> +        return true;
>> +    }
>> +    return gen_vaddsub_q_vl(ctx, a, 16, func);
>> +}
> 
> ... instead of these two places.
> 
> 
Ok, I will correct all similar patches.

Thanks.
Song Gao


