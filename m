Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2266B737F3A
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 11:57:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBuaJ-0001Iw-5i; Wed, 21 Jun 2023 05:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBuaG-0001IF-LF
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:57:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBuaD-0000e2-Vv
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:57:04 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8Dxc8RlyZJkehYAAA--.177S3;
 Wed, 21 Jun 2023 17:56:54 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dx4eRjyZJkrmsAAA--.2702S3; 
 Wed, 21 Jun 2023 17:56:51 +0800 (CST)
Subject: Re: [PATCH v1 04/46] target/loongarch: Implement xvadd/xvsub
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230620093814.123650-1-gaosong@loongson.cn>
 <20230620093814.123650-5-gaosong@loongson.cn>
 <47d12e8b-493a-e58c-54a1-47bd919c7e20@linaro.org>
 <cbe08731-718e-23d9-d834-1c34565902ad@loongson.cn>
 <49783ad9-cb1f-28d4-703f-6c0a99722935@linaro.org>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <49588b69-de95-a065-a7d5-58553857fc62@loongson.cn>
Date: Wed, 21 Jun 2023 17:56:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <49783ad9-cb1f-28d4-703f-6c0a99722935@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Dx4eRjyZJkrmsAAA--.2702S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFyUWrW7Xw1xJw47XF4UJrc_yoW8AF47pr
 4kJFW8JFWrtr4ktw1j93WUXF90yr13tw15Wwn5Xas5t34qvr12gF17XFWq9Fn7Gr4xCr1U
 XF4j9rsruFW3JrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU1wL05UUUUU==
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



在 2023/6/21 下午5:27, Richard Henderson 写道:
> On 6/21/23 11:19, Song Gao wrote:
>>
>>
>> 在 2023/6/20 下午8:25, Richard Henderson 写道:
>>> On 6/20/23 11:37, Song Gao wrote:
>>>> +static bool gvec_xxx(DisasContext *ctx, arg_xxx *a, MemOp mop,
>>>> +                     void (*func)(unsigned, uint32_t, uint32_t,
>>>> +                                  uint32_t, uint32_t, uint32_t))
>>>> +{
>>>> +    uint32_t xd_ofs, xj_ofs, xk_ofs;
>>>> +
>>>> +    CHECK_ASXE;
>>>> +
>>>> +    xd_ofs = vec_full_offset(a->xd);
>>>> +    xj_ofs = vec_full_offset(a->xj);
>>>> +    xk_ofs = vec_full_offset(a->xk);
>>>> +
>>>> +    func(mop, xd_ofs, xj_ofs, xk_ofs, 32, ctx->vl / 8);
>>>> +    return true;
>>>> +}
>>>
>>> Comparing gvec_xxx vs gvec_vvv for LSX,
>>>
>>>>     func(mop, vd_ofs, vj_ofs, vk_ofs, 16, ctx->vl/8);
>>>
>>> gvec_vvv will write 16 bytes of output, followed by 16 bytes of zero 
>>> to satisfy vl / 8.
>>>
>>>
>>> I presume this is the intended behaviour of mixing LSX with LASX, 
>>> that the high 128-bits that are not considered by the LSX 
>>> instruction are zeroed on write?
>>>
>> Yes,  the LSX instruction  can ignore the high 128-bits.
>
> Ignore != write zeros on output.  What is the behaviour?
>
Unpredictable,

For more,
LSX:
LA64 fp instructiosn change fp registers value,    the same num LSX 
registers [127: 64]  is  unpredictable.

LASX:
LA64 fp instructions change fp_registers value,  the same num LASX 
registers[255: 64] is unpredictable.
LSX instructions change LSX registers value,    the same num  LASX 
registers[255: 128] is Unpredictable.

Thanks.
Song Gao.


