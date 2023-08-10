Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 436C7776E27
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 04:39:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTvZj-0005TB-8z; Wed, 09 Aug 2023 22:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qTvZh-0005T3-3J
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 22:38:57 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qTvZe-0005Lv-Iv
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 22:38:56 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxIvC2TdRkvk0UAA--.43259S3;
 Thu, 10 Aug 2023 10:38:46 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxviO1TdRkRk1SAA--.33921S3; 
 Thu, 10 Aug 2023 10:38:45 +0800 (CST)
Subject: Re: [PATCH v5 08/11] target/loongarch: Reject la64-only instructions
 in la32 mode
To: Richard Henderson <richard.henderson@linaro.org>, Jiajie Chen <c@jia.je>, 
 qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, i.qemu@xen0n.name,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, maobibo@loongson.cn
References: <20230809083258.1787464-1-c@jia.je>
 <20230809083258.1787464-9-c@jia.je>
 <8e84ef00-7272-c26a-9e97-c135d577cf08@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <44bcb982-f086-94d8-d281-36707bdaa00c@loongson.cn>
Date: Thu, 10 Aug 2023 10:38:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8e84ef00-7272-c26a-9e97-c135d577cf08@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxviO1TdRkRk1SAA--.33921S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKr4xJFW8tw4DGr1fGw4xKrX_yoWkJFXE9w
 4fXFWkCw48CF4I9F1agr1xJFyDKrWUCFyYvw47A39FqrnxA3ZIyw4kZFn5Zw1UKa4ftFs8
 CrWaq3Z0yw17ZosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.14,
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

在 2023/8/9 下午11:03, Richard Henderson 写道:
> On 8/9/23 01:26, Jiajie Chen wrote:
>> LoongArch64-only instructions are marked with regard to the instruction
>> manual Table 2. LSX instructions are not marked for now for lack of
>> public manual.
> 
> I would expect LSX not to be affected by CPUCFG.1.ARCH, but only by 
> CPUCFG.2.LSX.
> 
> Note that there appears to be a bug with respect to LSX, in that 
> CPUCFG.2.LSX is not checked.  The manual is not clear, but I would 
> expect CPUCFG.2.LSX == 0 to trigger an illegal instruction exception 
> before the check for EUEN.SXE == 0 to trigger an instruction disabl > exception.  Also, are bit in EUEN allowed to be set to non-zero values
> when the corresponding expansion is not present?
> 
No, the kernel always checks for corresponding extensions when setting EUEN.

See enable_fpu/lsx/lasx at
 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/loongarch/include/asm/fpu.h?h=v6.5-rc5

And, I will send a patch to Check CPUCFG.2.LSX, Thanks for you suggestion.

Thanks.
Song Gao.


