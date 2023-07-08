Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F01E74BC86
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 09:27:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI2K4-00059J-Ge; Sat, 08 Jul 2023 03:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qI2K0-00058w-Gf
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 03:25:36 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qI2Jx-00041B-GG
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 03:25:36 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8Cx7+tfD6lktvABAA--.5422S3;
 Sat, 08 Jul 2023 15:25:20 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx_c5GD6lkxtkiAA--.35926S3; 
 Sat, 08 Jul 2023 15:25:19 +0800 (CST)
Subject: Re: [PATCH v2 20/46] target/loongarch: Implement vext2xv
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-21-gaosong@loongson.cn>
 <c0bcf176-956f-f8e4-8169-47d797b234c0@linaro.org>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <e0644ec3-0680-75f3-a850-693f7d21d0dc@loongson.cn>
Date: Sat, 8 Jul 2023 15:24:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c0bcf176-956f-f8e4-8169-47d797b234c0@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cx_c5GD6lkxtkiAA--.35926S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ArWDZFy5Cw4kXr18Jw1kJFc_yoW8Cr18pr
 18Jr1UJryUJr18Jr1UJr1UJryUJr1UJw1UJr18JF1UJr1UJr1jqr1UXr1jgr1UJr48Jr1U
 Jr1UJr1UZr1UJrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1EksDUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.092,
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

Hi, Richard

在 2023/7/8 上午5:19, Richard Henderson 写道:
> On 6/30/23 08:58, Song Gao wrote:
>> +#define VEXT2XV(NAME, BIT, E1, E2)                        \
>> +void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz, \
>> +                  uint32_t vd, uint32_t vj)               \
>> +{                                                         \
>> +    int i;                                                \
>> +    VReg *Vd = &(env->fpr[vd].vreg);                      \
>> +    VReg *Vj = &(env->fpr[vj].vreg);                      \
>> +    VReg temp;                                            \
>> +                                                          \
>> +    for (i = 0; i < LASX_LEN / BIT; i++) {                \
>> +        temp.E1(i) = Vj->E2(i);                           \
>> +    }                                                     \
>> +    *Vd = temp;                                           \
>> +}
>
> So unlike VEXT(H), this does compress in order?
Yes.
>
> Anyway, function signature and iteration without LASX_LEN.
> Isn't there a 128-bit helper to merge this with?
>
There is no similar 128 bit instructions.

Thanks.
Song Gao


