Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B23A78E71B
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 09:18:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbbvu-0001IN-8P; Thu, 31 Aug 2023 03:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qbbvq-0001Hh-3u
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 03:17:34 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qbbvm-0002T9-13
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 03:17:32 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxfeuCPvBkb1odAA--.57749S3;
 Thu, 31 Aug 2023 15:17:22 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxLCOBPvBk+OlnAA--.35975S3; 
 Thu, 31 Aug 2023 15:17:21 +0800 (CST)
Subject: Re: [PATCH v4 10/48] target/loongarch: rename lsx_helper.c to
 vec_helper.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-11-gaosong@loongson.cn>
 <74a0aeda-fc07-6e04-092b-772ef154e83a@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <a405de3d-deea-89af-ab0a-922d850c7331@loongson.cn>
Date: Thu, 31 Aug 2023 15:17:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <74a0aeda-fc07-6e04-092b-772ef154e83a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxLCOBPvBk+OlnAA--.35975S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kry3tF4xWrWkuFW7uF48uFX_yoW8ZF4fpr
 n5Jr4UtryUJr18Jr17Xw1Ut345Jr18J3WUXr1rXF1UAryUJr1qvr1UXr1vgr1UJr48Zr1j
 yr1jyr1UZF15JrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QV
 y3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.242,
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

在 2023/8/31 上午2:06, Richard Henderson 写道:
> On 8/30/23 01:48, Song Gao wrote:
>> Use gen_helper_gvec_* series function.
>> and rename lsx_helper.c to vec_helper.c.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   target/loongarch/helper.h                     |  642 ++++----
>>   .../loongarch/{lsx_helper.c => vec_helper.c}  | 1297 ++++++++---------
> 
> These changes are fine, but should be split.
> 
> The helper changes can be done with only minimal changes
> 
>>   target/loongarch/insn_trans/trans_lsx.c.inc   |  731 +++++-----
> 
> here, rather than to 700+ lines at once.
> 
OK, It seems that need more patches do this.
>> -static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a,
>> -                     void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32,
>> -                                  TCGv_i32, TCGv_i32))
>> +static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a, int oprsz,
>> +                     gen_helper_gvec_4 *fn)
> 
> If you omit the oprsz argument within this patch,
> 
>> +    tcg_gen_gvec_4_ool(vec_full_offset(a->vd),
>> +                       vec_full_offset(a->vj),
>> +                       vec_full_offset(a->vk),
>> +                       vec_full_offset(a->va),
>> +                       oprsz, ctx->vl / 8, oprsz, fn);
> 
> hard-coding 16 here instead,
> 
>> -TRANS(vhaddw_h_b, LSX, gen_vvv, gen_helper_vhaddw_h_b)
>> +TRANS(vhaddw_h_b, LSX, gen_vvv, 16, gen_helper_vhaddw_h_b)
> 
> then you do not need all of these changes.
> 
> At which point I'll refer you back to my comments vs patches 5 and 6, 
> wherein separate gen_vvv and gen_xxx helpers would avoid the need to 
> replicate 16 across all of these lines.
>
Got it

Thanks.
Song Gao


