Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFD977B420
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 10:29:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVSwi-0006nH-Ow; Mon, 14 Aug 2023 04:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qVSwe-0006n4-44
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 04:29:00 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qVSwW-0000Jh-9V
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 04:28:59 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Dx6erC5dlkCw0YAA--.44013S3;
 Mon, 14 Aug 2023 16:28:50 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dx4eS_5dlklaZZAA--.24353S3; 
 Mon, 14 Aug 2023 16:28:49 +0800 (CST)
Subject: Re: [PATCH v2 2/8] target/loongarch: Add a check parameter to the
 TRANS macro
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn, c@jia.je
References: <20230811100208.271649-1-gaosong@loongson.cn>
 <20230811100208.271649-3-gaosong@loongson.cn>
 <af285335-f2c5-bcb8-63e4-d3a47634dc5d@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <d3ba0cc9-51e7-36fb-c882-bbaf11669736@loongson.cn>
Date: Mon, 14 Aug 2023 16:28:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <af285335-f2c5-bcb8-63e4-d3a47634dc5d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx4eS_5dlklaZZAA--.24353S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWruw4Duw1kWw47KrWrJF4fJFc_yoWxKFc_Ca
 yIyrZ7C3Wvqr47Ca1Svwn8Xa4DKw4DAry0qay0gw1Ig34ayFs3XF1vyws7X3Z3tFZ5Z3W7
 GFyjqay7u3srZosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xO
 z3UUUUU==
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

在 2023/8/11 下午11:23, Richard Henderson 写道:
> On 8/11/23 03:02, Song Gao wrote:
>> The default check parmeter is ALL, remove TRANS_64 marco.
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
> 
> If you're going to remove TRANS_64, you should simply drop the patch 
> that added it, and be careful about the final patch ordering such that 
> the LA32 cpu is created after your patch 3 (which adds avail_64()).
> 
> Otherwise there will be a bisection point at which LA32 is enabled, but 
> avail_64 is not enforced.
> 
> 
Thanks for you suggestions.

I will add Jiajie' patches together. and adjust patches order.

Thanks.
Song Gao


