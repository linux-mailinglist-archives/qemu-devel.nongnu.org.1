Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9EE737ED0
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 11:19:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtzd-00006B-FX; Wed, 21 Jun 2023 05:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBtza-00005n-D9
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:19:10 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBtzX-0007oW-SK
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:19:10 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8AxjseGwJJkTBQAAA--.168S3;
 Wed, 21 Jun 2023 17:19:02 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Ax8uSFwJJkj14AAA--.2350S3; 
 Wed, 21 Jun 2023 17:19:02 +0800 (CST)
Subject: Re: [PATCH v1 01/46] target/loongarch: Add LASX data type XReg
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230620093814.123650-1-gaosong@loongson.cn>
 <20230620093814.123650-2-gaosong@loongson.cn>
 <e77f9fde-7a9b-689a-1410-84dedfcb67fe@linaro.org>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <5f442aaa-fc5f-3e0a-c645-e9260d715c73@loongson.cn>
Date: Wed, 21 Jun 2023 17:19:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e77f9fde-7a9b-689a-1410-84dedfcb67fe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Ax8uSFwJJkj14AAA--.2350S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZr1xZFW8CF4kWFyxWFykWFX_yoWkArc_Ga
 17WFnxWrWv9ay2yr48trZ8Cw17JF48JFyFgrW5ur1kCFy3Jws5ArWaqwn3Zw45KrW8A3yY
 yr9xXr13Kr4YvosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25Ef
 UUUUU
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

Hi, Richard

在 2023/6/20 下午8:09, Richard Henderson 写道:
> On 6/20/23 11:37, Song Gao wrote:
>> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
>> index b23f38c3d5..347950b4d0 100644
>> --- a/target/loongarch/cpu.h
>> +++ b/target/loongarch/cpu.h
>> @@ -259,9 +259,23 @@ typedef union VReg {
>>       Int128   Q[LSX_LEN / 128];
>>   }VReg;
>>   +#define LASX_LEN   (256)
>> +typedef union XReg {
>> +    int8_t   XB[LASX_LEN / 8];
>> +    int16_t  XH[LASX_LEN / 16];
>> +    int32_t  XW[LASX_LEN / 32];
>> +    int64_t  XD[LASX_LEN / 64];
>> +    uint8_t  UXB[LASX_LEN / 8];
>> +    uint16_t UXH[LASX_LEN / 16];
>> +    uint32_t UXW[LASX_LEN / 32];
>> +    uint64_t UXD[LASX_LEN / 64];
>> +    Int128   XQ[LASX_LEN / 128];
>> +} XReg;
>
> This is following the example of target/i386, and I think it is a bad 
> example.
>
[....]
> For Arm, we have one ARMVectorReg which covers AdvSIMD (128-bit) and 
> SVE (2048-bit).
> I would prefer if you just expand the definition of VReg to be 256 bits.
>
Ok,  I will correct it on v2.

Thanks.
Song Gao


