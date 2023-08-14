Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D3D77B4EF
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 10:59:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVTQ8-0002cq-VD; Mon, 14 Aug 2023 04:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qVTQ5-0002c1-IZ
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 04:59:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qVTQ2-0007IR-JS
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 04:59:25 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxLOvj7NlkixAYAA--.44379S3;
 Mon, 14 Aug 2023 16:59:16 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxF83h7NlkmLFZAA--.21720S3; 
 Mon, 14 Aug 2023 16:59:13 +0800 (CST)
Subject: Re: [PATCH v5 08/11] target/loongarch: Reject la64-only instructions
 in la32 mode
To: Richard Henderson <richard.henderson@linaro.org>, Jiajie Chen <c@jia.je>, 
 qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, i.qemu@xen0n.name,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230809083258.1787464-1-c@jia.je>
 <20230809083258.1787464-9-c@jia.je>
 <b87f51eb-6e82-5ecd-5412-5a892c9510d1@loongson.cn>
 <ea9dbc59-b1af-5abc-55d0-f4e4e85f99c9@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <f0286358-7363-0a86-a526-44119ec146f8@loongson.cn>
Date: Mon, 14 Aug 2023 16:59:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ea9dbc59-b1af-5abc-55d0-f4e4e85f99c9@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF83h7NlkmLFZAA--.21720S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZrW5JFW7uF18tF17JFW8AFc_yoWDKrb_Zr
 1fZF1DCan0v3W3G3yaqwn8AFy3CF1kK3Wrtr4fJrWIg3WYqw4DZan7Ga4DG3s3G3s5Grsr
 Z3yvg34ay34IvosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
 xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
 6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
 1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
 JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
 vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
 x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
 xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
 wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jntxDUUUUU=
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

在 2023/8/11 下午11:18, Richard Henderson 写道:
> On 8/11/23 01:12, gaosong wrote:
>>> +TRANS_64(sra_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sra_d)
>>>   TRANS(rotr_w, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
>> TRANS_64(rotr_w, ...)
> ...
>>>   TRANS(rotri_w, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
>> TRANS_64(rotri_w, ...)
>>
>> I see the manual from https://www.loongson.cn/download/index
>>
>> insn cpucfg also not support on la32.
> 
> 
> I see all 3 of these, ROTR.W, ROTRI.W and CPUCFG listed in Table 2 at
> 
> https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#overview-of-basic-integer-instructions 
> 
> 

I see. These are not listed in [1] (the LA32 Lite Edition Manual),  It 
seems that the LA32 Lite Edition drops some instructions.


[1]:
https://www.loongson.cn/uploads/images/2023041918122813624.%E9%BE%99%E8%8A%AF%E6%9E%B6%E6%9E%8432%E4%BD%8D%E7%B2%BE%E7%AE%80%E7%89%88%E5%8F%82%E8%80%83%E6%89%8B%E5%86%8C_r1p03.pdf

Thanks.
Song Gao


