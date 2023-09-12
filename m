Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F098F79CB38
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 11:10:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfzPA-0008IQ-8O; Tue, 12 Sep 2023 05:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qfzP7-0008I3-PA
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 05:09:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qfzP3-0000dW-2r
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 05:09:53 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxqOjWKgBlQXQlAA--.36720S3;
 Tue, 12 Sep 2023 17:09:43 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxS9zVKgBldoYAAA--.357S3; 
 Tue, 12 Sep 2023 17:09:41 +0800 (CST)
Subject: Re: [PATCH RESEND v5 51/57] target/loongarch: Implement xvinsgr2vr
 xvpickve2gr
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-52-gaosong@loongson.cn>
 <2b3210ad-a8ca-5efd-d6a2-7639e6e5ad7a@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <1eabb2c6-510e-76c9-62b2-7bac8213f693@loongson.cn>
Date: Tue, 12 Sep 2023 17:09:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2b3210ad-a8ca-5efd-d6a2-7639e6e5ad7a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxS9zVKgBldoYAAA--.357S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ArWkKF1UAw1Utr1rKr1fZrc_yoW8Zw1fp3
 ZYgryrZFWYgFyrJFyqqw1jqr9ayF40k3Wjvwn5K3W8JrZxJrs0vry2q3ya934UZrs7ur15
 tFWrZay3ua1UtwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PU
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

在 2023/9/12 上午6:27, Richard Henderson 写道:
> On 9/7/23 01:31, Song Gao wrote:
>> +static bool trans_xvinsgr2vr_w(DisasContext *ctx, arg_vr_i *a)
>> +{
>> +    if (!avail_LASX(ctx)) {
>> +        return false;
>> +    }
>> +    return trans_vinsgr2vr_w(ctx, a);
>> +}
> 
> Using the other translator doesn't help.
> 
>> static bool trans_vinsgr2vr_w(DisasContext *ctx, arg_vr_i *a)
>> {
>>     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
>>
>>     if (!avail_LSX(ctx)) {
>>         return false;
>>     }
>>
>>     CHECK_SXE;
> 
> This portion doesn't apply, and you miss the check_vec for the larger LASX.
> 
>>     tcg_gen_st32_i64(src, cpu_env,
>>                      offsetof(CPULoongArchState, 
>> fpr[a->vd].vreg.W(a->imm)));
>>     return true;
>> }
> 
> The only thing that is left is this one line, so I'm not sure it's worth 
> splitting out a common helper function.
> 
> I think we need, like this:

static bool gen_g2v_vl(DisasContext *ctx, arg_vr_i *a, uint32_t oprsz, 
MemOp mop,
                        void (*func)(TCGv, TCGv_ptr, tcg_target_long))
{
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);

     if (!check_vec(ctx, oprsz)) {
         return true;
     }

     func(src, cpu_env, vec_reg_offset(a->vd, a->imm, mop));

     return true;
}

static bool gen_g2v(DisasContext *ctx, arg_vr_i *a, MemOp mop,
                     void (*func)(TCGv, TCGv_ptr, tcg_target_long))
{
     return gen_g2v_vl(ctx, a, 16, mop, func);
}

static bool gen_g2x(DisasContext *ctx, arg_vr_i *a, MemOp mop,
                     void (*func)(TCGv, TCGv_ptr, tcg_target_long))
{
     return gen_g2v_vl(ctx, a, 32, mop, func);
}

TRANS(vinsgr2vr_b, LSX, gen_g2v, MO_8, tcg_gen_st8_i64)
TRANS(vinsgr2vr_h, LSX, gen_g2v, MO_16, tcg_gen_st16_i64)
TRANS(vinsgr2vr_w, LSX, gen_g2v, MO_32, tcg_gen_st32_i64)
TRANS(vinsgr2vr_d, LSX, gen_g2v, MO_64, tcg_gen_st_i64)
TRANS(xvinsgr2vr_w, LASX, gen_g2x, MO_32, tcg_gen_st32_i64)
TRANS(xvinsgr2vr_d, LASX, gen_g2x, MO_64, tcg_gen_st_i64)

Thanks.
Song Gao


