Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5639979FE40
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 10:25:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgheY-00037A-72; Thu, 14 Sep 2023 04:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qgheW-000356-Cs
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 04:24:44 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qgheU-00022K-Gy
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 04:24:44 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxNuhFwwJl5TsnAA--.22128S3;
 Thu, 14 Sep 2023 16:24:37 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxjNxFwwJlk4YEAA--.8551S3; 
 Thu, 14 Sep 2023 16:24:37 +0800 (CST)
Subject: Re: [PATCH v6 52/57] target/loongarch: Implement xvreplve xvinsve0
 xvpickve
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230914022645.1151356-1-gaosong@loongson.cn>
 <20230914022645.1151356-53-gaosong@loongson.cn>
 <1e287c3c-0507-a176-5eb2-7ab43ae6b563@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <ed3da1fb-13b3-f5a1-6b76-d60b721f58da@loongson.cn>
Date: Thu, 14 Sep 2023 16:24:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1e287c3c-0507-a176-5eb2-7ab43ae6b563@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxjNxFwwJlk4YEAA--.8551S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw15uw13Ww45tF1ruFWkZrc_yoW8XFykpr
 n5trW0qryUJrn3Jr17Cr1UKryUA348Cw15Jw1rXFy7Jr47Jr10qF10qr1qgr17Ar4rZr15
 Jr15Jr9xZF1UJacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9
 N3UUUUU==
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

在 2023/9/14 上午11:16, Richard Henderson 写道:
> On 9/13/23 19:26, Song Gao wrote:
>> +static bool gen_xvrepl128(DisasContext *ctx, arg_vv_i *a, MemOp mop)
>>   {
>> -    int ofs;
>> -    TCGv_i64 desthigh, destlow, high, low;
>> +    int index = LSX_LEN / (8 * (1 << mop));
>> -    if (!avail_LSX(ctx)) {
>> -        return false;
>> -    }
>> -
>> -    if (!check_vec(ctx, 16)) {
>> +    if (!check_vec(ctx, 32)) {
>>           return true;
>>       }
>> -    desthigh = tcg_temp_new_i64();
>> -    destlow = tcg_temp_new_i64();
>> -    high = tcg_temp_new_i64();
>> -    low = tcg_temp_new_i64();
>> +    tcg_gen_gvec_dup_mem(mop, vec_reg_offset(a->vd, 0, mop),
>> +                         vec_reg_offset(a->vj, a->imm, mop), 16, 16);
>> +    tcg_gen_gvec_dup_mem(mop, vec_reg_offset(a->vd, index, mop),
>> +                         vec_reg_offset(a->vj, a->imm + index , mop), 
>> 16, 16);
> 
> I think this isn't right, because vec_reg_offset(a->vd, 0, mop) is not 
> the beginning of the vector for a big-endian host -- remember the xor in 
> vec_reg_offset.
> 
You are right.

> Better as
> 
>      for (i = 0; i < 32; i += 16) {
>          tcg_gen_gvec_dup_mem(mop, vec_full_offset(a->vd) + i,
>                               vec_reg_offset(a->vj, a->imm, mop) + i, 
> 16, 16);
>      }
> 
Got it.

Thanks.
Song Gao


