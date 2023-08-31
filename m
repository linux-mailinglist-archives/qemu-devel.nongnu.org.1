Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A0078E71A
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 09:18:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbbvq-0001Hd-NU; Thu, 31 Aug 2023 03:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qbbvl-0001HG-Oa
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 03:17:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qbbvf-0002SF-GW
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 03:17:29 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxV_F+PvBkbVodAA--.60558S3;
 Thu, 31 Aug 2023 15:17:18 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxF817PvBk9elnAA--.51620S3; 
 Thu, 31 Aug 2023 15:17:15 +0800 (CST)
Subject: Re: [PATCH v4 06/48] target/loongarch: Implement xvreplgr2vr
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-7-gaosong@loongson.cn>
 <34b735fd-0b90-8e3d-a0a8-3091adeccbf5@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <bf2ac0ea-dc9e-2212-e8ed-ac395f1ee26f@loongson.cn>
Date: Thu, 31 Aug 2023 15:17:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <34b735fd-0b90-8e3d-a0a8-3091adeccbf5@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF817PvBk9elnAA--.51620S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Xr45GF1kGryDGr18GF1kXrc_yoWxAw1Upr
 10grWUAFWUXF97Jr1Fvwn8Xry3Xr1xG3Wjkw1ft3WFyrWUXF1qqFWvqrWY9FWxXw4kZFyj
 yr18ZrWUurWYq3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
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

在 2023/8/31 上午12:09, Richard Henderson 写道:
> On 8/30/23 01:48, Song Gao wrote:
>> This patch includes:
>> - XVREPLGR2VR.{B/H/W/D}.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/loongarch/insns.decode                |  5 +++++
>>   target/loongarch/disas.c                     | 10 ++++++++++
>>   target/loongarch/insn_trans/trans_lasx.c.inc |  5 +++++
>>   target/loongarch/insn_trans/trans_lsx.c.inc  | 12 ++++++------
>>   4 files changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/loongarch/insns.decode 
>> b/target/loongarch/insns.decode
>> index bcc18fb6c5..04bd238995 100644
>> --- a/target/loongarch/insns.decode
>> +++ b/target/loongarch/insns.decode
>> @@ -1310,3 +1310,8 @@ xvsub_h          0111 01000000 11001 ..... ..... 
>> .....    @vvv
>>   xvsub_w          0111 01000000 11010 ..... ..... .....    @vvv
>>   xvsub_d          0111 01000000 11011 ..... ..... .....    @vvv
>>   xvsub_q          0111 01010010 11011 ..... ..... .....    @vvv
>> +
>> +xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
>> +xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
>> +xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
>> +xvreplgr2vr_d    0111 01101001 11110 00011 ..... .....    @vr
>> diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
>> index d8b62ba532..c47f455ed0 100644
>> --- a/target/loongarch/disas.c
>> +++ b/target/loongarch/disas.c
>> @@ -1708,6 +1708,11 @@ static void output_vvv_x(DisasContext *ctx, 
>> arg_vvv * a, const char *mnemonic)
>>       output(ctx, mnemonic, "x%d, x%d, x%d", a->vd, a->vj, a->vk);
>>   }
>> +static void output_vr_x(DisasContext *ctx, arg_vr *a, const char 
>> *mnemonic)
>> +{
>> +    output(ctx, mnemonic, "x%d, r%d", a->vd, a->rj);
>> +}
>> +
>>   INSN_LASX(xvadd_b,           vvv)
>>   INSN_LASX(xvadd_h,           vvv)
>>   INSN_LASX(xvadd_w,           vvv)
>> @@ -1718,3 +1723,8 @@ INSN_LASX(xvsub_h,           vvv)
>>   INSN_LASX(xvsub_w,           vvv)
>>   INSN_LASX(xvsub_d,           vvv)
>>   INSN_LASX(xvsub_q,           vvv)
>> +
>> +INSN_LASX(xvreplgr2vr_b,     vr)
>> +INSN_LASX(xvreplgr2vr_h,     vr)
>> +INSN_LASX(xvreplgr2vr_w,     vr)
>> +INSN_LASX(xvreplgr2vr_d,     vr)
>> diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc 
>> b/target/loongarch/insn_trans/trans_lasx.c.inc
>> index 218b8dc648..66b5abc790 100644
>> --- a/target/loongarch/insn_trans/trans_lasx.c.inc
>> +++ b/target/loongarch/insn_trans/trans_lasx.c.inc
>> @@ -50,3 +50,8 @@ TRANS(xvsub_b, LASX, gvec_vvv, 32, MO_8, 
>> tcg_gen_gvec_sub)
>>   TRANS(xvsub_h, LASX, gvec_vvv, 32, MO_16, tcg_gen_gvec_sub)
>>   TRANS(xvsub_w, LASX, gvec_vvv, 32, MO_32, tcg_gen_gvec_sub)
>>   TRANS(xvsub_d, LASX, gvec_vvv, 32, MO_64, tcg_gen_gvec_sub)
>> +
>> +TRANS(xvreplgr2vr_b, LASX, gvec_dup, 32, MO_8)
>> +TRANS(xvreplgr2vr_h, LASX, gvec_dup, 32, MO_16)
>> +TRANS(xvreplgr2vr_w, LASX, gvec_dup, 32, MO_32)
>> +TRANS(xvreplgr2vr_d, LASX, gvec_dup, 32, MO_64)
>> diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc 
>> b/target/loongarch/insn_trans/trans_lsx.c.inc
>> index 0e12213e8b..c0e7a9a372 100644
>> --- a/target/loongarch/insn_trans/trans_lsx.c.inc
>> +++ b/target/loongarch/insn_trans/trans_lsx.c.inc
>> @@ -4161,7 +4161,7 @@ static bool trans_vpickve2gr_du(DisasContext 
>> *ctx, arg_rv_i *a)
>>       return true;
>>   }
>> -static bool gvec_dup(DisasContext *ctx, arg_vr *a, MemOp mop)
>> +static bool gvec_dup(DisasContext *ctx, arg_vr *a, uint32_t oprsz, 
>> MemOp mop)
>>   {
>>       TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
>> @@ -4172,14 +4172,14 @@ static bool gvec_dup(DisasContext *ctx, arg_vr 
>> *a, MemOp mop)
>>       CHECK_VEC;
>>       tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd),
>> -                         16, ctx->vl/8, src);
>> +                         oprsz, ctx->vl / 8, src);
>>       return true;
>>   }
>> -TRANS(vreplgr2vr_b, LSX, gvec_dup, MO_8)
>> -TRANS(vreplgr2vr_h, LSX, gvec_dup, MO_16)
>> -TRANS(vreplgr2vr_w, LSX, gvec_dup, MO_32)
>> -TRANS(vreplgr2vr_d, LSX, gvec_dup, MO_64)
>> +TRANS(vreplgr2vr_b, LSX, gvec_dup, 16, MO_8)
>> +TRANS(vreplgr2vr_h, LSX, gvec_dup, 16, MO_16)
>> +TRANS(vreplgr2vr_w, LSX, gvec_dup, 16, MO_32)
>> +TRANS(vreplgr2vr_d, LSX, gvec_dup, 16, MO_64)
> 
> Hmm.
> 
> Ok, so revising the advice I gave versus the previous patch, I can see 
> how having a common CHECK_VEC is helpful.  But it still needs to use 
> oprsz not vl for the size check.
> 
> It would be better to replace with a function, like
> 
>      if (!check_vec(ctx, oprsz)) {
>          return true;
>      }
> 
> rather than a macro with a hidden return.  The replacement should be 
> done in a patch by itself, probably using check_vec(ctx, 16) for all of 
> the existing LSX code until, step by step, oprsz is plumbed into all of 
> the places required.
> 
> I still think having separate minimal gen_vvv and gen_xxx helpers will 
> help reduce the possibility of typos, when there are a lot of 
> instructions within an instruction format. But when there are just 8, 
> like here, just adding oprsz certainly looks simpler.
>
Thanks for you suggestions. I will correct them on v5.

> I wonder if it is really clearer having the LASX instructions in a 
> separate file?  Perhaps it be better to keep all of the similar patterns 
> together, e.g.
> 
OK.

I can merge LSX and LASX in a new file(trans_vec.c.inc or ..).
It seems need more time do this. I will send V5 a few days later.

Thanks.
Song Gao

> static bool gvec_dup(...)
> {
> ...
> }
> 
> TRANS(vreplgr2vr_b, LSX, gvec_dup, 16, MO_8)
> TRANS(vreplgr2vr_h, LSX, gvec_dup, 16, MO_16)
> TRANS(vreplgr2vr_w, LSX, gvec_dup, 16, MO_32)
> TRANS(vreplgr2vr_d, LSX, gvec_dup, 16, MO_64)
> 
> TRANS(xvreplgr2vr_b, LASX, gvec_dup, 32, MO_8)
> TRANS(xvreplgr2vr_h, LASX, gvec_dup, 32, MO_16)
> TRANS(xvreplgr2vr_w, LASX, gvec_dup, 32, MO_32)
> TRANS(xvreplgr2vr_d, LASX, gvec_dup, 32, MO_64)
> 
> 
> r~


