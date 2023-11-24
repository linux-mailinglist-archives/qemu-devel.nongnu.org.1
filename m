Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF787F6E1B
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 09:28:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6RWe-0005nX-5L; Fri, 24 Nov 2023 03:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1r6RWa-0005lK-9q
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 03:26:56 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1r6RWE-0006i6-7v
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 03:26:49 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxIvAwXmBlH4Y8AA--.53751S3;
 Fri, 24 Nov 2023 16:26:24 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cxjd4pXmBloHlLAA--.38273S3; 
 Fri, 24 Nov 2023 16:26:19 +0800 (CST)
Subject: Re: [risu PATCH 0/5] Add LoongArch LSX/LASX instructions
From: gaosong <gaosong@loongson.cn>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org,
 alex.bennee@linaro.org, maobibo@loongson.cn
References: <20231025092915.902814-1-gaosong@loongson.cn>
 <07f56184-5b40-fb9f-ee96-6d963d362b4c@loongson.cn>
Message-ID: <806a3237-ee1c-9604-7fc5-430671661928@loongson.cn>
Date: Fri, 24 Nov 2023 16:26:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <07f56184-5b40-fb9f-ee96-6d963d362b4c@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cxjd4pXmBloHlLAA--.38273S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw15XF17ur48Cw43tF4kKrX_yoW8JFyUp3
 93Za15GrW8Wwn7Ww13t3yUArySgr1xJw17XF1fta4xGr90yryvqF18XrWqgF9rXw4xGr1j
 qr1UKw17uF15ArbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.672,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Ping !!

Since [1]  series had merged into master three weeks ago,

I ping this series again.

[1]:

https://lore.kernel.org/all/20231103062332.2413724-1-gaosong@loongson.cn/


Thanks.
Song Gao

在 2023/11/13 下午4:06, gaosong 写道:
> Ping !
>
> 在 2023/10/25 下午5:29, Song Gao 写道:
>> Hi, Peter!
>>
>> This series adds LSX/LASX instructions.
>>
>> We tested 10 million instructions without any problems.
>>
>> client:
>> x86 host  QEMU + patches [1].
>>
>> server:
>> 3A5000 host.
>>
>>
>> [1] https://patchwork.kernel.org/project/qemu-devel/list/?series=791633
>>
>>
>> Please review!
>>
>> Thanks.
>> Song Gao
>>
>> Song Gao (5):
>>    loongarch: Add LSX instructions
>>    loongarch: Add LASX instructions
>>    loongarch: reginfo suport LSX/LASX
>>    loongarch: init LASX registers
>>    loongarch: Add block 'clean' and clean_lsx_result()
>>
>>   loongarch64.risu           | 2309 +++++++++++++++++++++++++++++++++++-
>>   risu_reginfo_loongarch64.c |  107 +-
>>   risu_reginfo_loongarch64.h |    3 +-
>>   risugen                    |    2 +-
>>   risugen_loongarch64.pm     |   30 +
>>   5 files changed, 2418 insertions(+), 33 deletions(-)
>>
>


