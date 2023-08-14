Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E2A77B423
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 10:29:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVSwc-0006mn-T1; Mon, 14 Aug 2023 04:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qVSwU-0006ly-Du
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 04:28:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qVSwN-0000Gs-Rk
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 04:28:50 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxEvC45dlk9wwYAA--.48764S3;
 Mon, 14 Aug 2023 16:28:40 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxHCO15dlkiqZZAA--.5190S3; 
 Mon, 14 Aug 2023 16:28:40 +0800 (CST)
Subject: Re: [PATCH v2 4/8] target/loongarch: Add avail_FP/FP_SP/FP_DP to
 check fpu instructions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn,
 c@jia.je, yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230811100208.271649-1-gaosong@loongson.cn>
 <20230811100208.271649-5-gaosong@loongson.cn>
 <64439183-7776-c8ad-59fe-28145a69a5e4@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <cc45ed7c-a864-8992-7f44-d2bb10b91536@loongson.cn>
Date: Mon, 14 Aug 2023 16:28:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <64439183-7776-c8ad-59fe-28145a69a5e4@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxHCO15dlkiqZZAA--.5190S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWruw4Duw1kJF48WrW7KF13WrX_yoWDWrc_Ja
 yxCrykWr48XayxGFWY9w1rXa45CF40yFn8AasFv3y7C345Jrn8Crn0qan5X3WagFs8Xrnx
 Cryagr1S9r95tosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7Mmh
 UUUUU
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

在 2023/8/12 上午12:09, Richard Henderson 写道:
> On 8/11/23 03:02, Song Gao wrote:
>> Signed-off-by: Song Gao<gaosong@loongson.cn>
>> ---
>>   .../loongarch/insn_trans/trans_farith.c.inc   | 96 ++++++++++++-------
>>   target/loongarch/insn_trans/trans_fcmp.c.inc  |  8 ++
>>   target/loongarch/insn_trans/trans_fcnv.c.inc  | 56 +++++------
>>   .../loongarch/insn_trans/trans_fmemory.c.inc  | 32 +++----
>>   target/loongarch/insn_trans/trans_fmov.c.inc  | 48 ++++++++--
>>   target/loongarch/translate.h                  |  3 +
>>   6 files changed, 157 insertions(+), 86 deletions(-)
> 
> Since the manual does not explicitly list "basic floating point" vs 
> single vs double, I can only give you an
> 

I have the same doubts.

Hi,  yijuan and shenjingyang,

Could you list more detail about CPUCFG.FP/FP_SP/FP_DP?

Thanks.
Song Gao

> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~


