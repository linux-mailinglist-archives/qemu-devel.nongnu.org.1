Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C40B737ED2
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 11:19:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtzo-00007K-S6; Wed, 21 Jun 2023 05:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBtzm-00006t-TM
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:19:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBtzk-0008K1-66
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:19:22 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8CxpMSUwJJkUxQAAA--.151S3;
 Wed, 21 Jun 2023 17:19:16 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Ax8uSTwJJkol4AAA--.2353S3; 
 Wed, 21 Jun 2023 17:19:15 +0800 (CST)
Subject: Re: [PATCH v1 04/46] target/loongarch: Implement xvadd/xvsub
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230620093814.123650-1-gaosong@loongson.cn>
 <20230620093814.123650-5-gaosong@loongson.cn>
 <47d12e8b-493a-e58c-54a1-47bd919c7e20@linaro.org>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <cbe08731-718e-23d9-d834-1c34565902ad@loongson.cn>
Date: Wed, 21 Jun 2023 17:19:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <47d12e8b-493a-e58c-54a1-47bd919c7e20@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Ax8uSTwJJkol4AAA--.2353S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFW3ZFWrJw17GFyfJw1fGrX_yoW8Ary5pr
 1ktFW8tFZrJa18tr12yF1UGFy5Aw1rtw1Ygry8WFy8KayUXr1Igr17WrsF9Fy8Jr4rA34U
 AF4Yvrn7Zr1DJrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
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
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
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



在 2023/6/20 下午8:25, Richard Henderson 写道:
> On 6/20/23 11:37, Song Gao wrote:
>> +static bool gvec_xxx(DisasContext *ctx, arg_xxx *a, MemOp mop,
>> +                     void (*func)(unsigned, uint32_t, uint32_t,
>> +                                  uint32_t, uint32_t, uint32_t))
>> +{
>> +    uint32_t xd_ofs, xj_ofs, xk_ofs;
>> +
>> +    CHECK_ASXE;
>> +
>> +    xd_ofs = vec_full_offset(a->xd);
>> +    xj_ofs = vec_full_offset(a->xj);
>> +    xk_ofs = vec_full_offset(a->xk);
>> +
>> +    func(mop, xd_ofs, xj_ofs, xk_ofs, 32, ctx->vl / 8);
>> +    return true;
>> +}
>
> Comparing gvec_xxx vs gvec_vvv for LSX,
>
>>     func(mop, vd_ofs, vj_ofs, vk_ofs, 16, ctx->vl/8);
>
> gvec_vvv will write 16 bytes of output, followed by 16 bytes of zero 
> to satisfy vl / 8.
>
>
> I presume this is the intended behaviour of mixing LSX with LASX, that 
> the high 128-bits that are not considered by the LSX instruction are 
> zeroed on write?
>
Yes,  the LSX instruction  can ignore the high 128-bits.

> Which means that your macros from patch 1,
>
>> +#if HOST_BIG_ENDIAN
> ...
>> +#define XB(x)  XB[31 - (x)]
>> +#define XH(x)  XH[15 - (x)]
>
> are incorrect.  We need big-endian within the Int128, but 
> little-endian ordering of the two Int128. This can be done with
>
> #define XB(x)  XB[(x) ^ 15]
> #define XH(x)  XH[(x) ^ 7]
>
> etc.
>
Ok, I will correct it.
> It would be nice to share more code with trans_lsx.c, if possible.
>
Some functions can be merged,  e.g   gvec_vvv and  gvec_xxx.

Many of the latter patches are similar to LSX.   Maybe more code can be 
merged.

Thanks.
Song Gao


