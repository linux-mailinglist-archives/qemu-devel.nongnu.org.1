Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E51EB82ADB8
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:42:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNtRS-00075l-Ll; Thu, 11 Jan 2024 06:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rNtRO-00075U-N7
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:41:42 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rNtRL-0004TI-Lj
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:41:42 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Cx6ent059lhkAEAA--.8467S3;
 Thu, 11 Jan 2024 19:41:34 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxbNzr059lo_kPAA--.42054S3; 
 Thu, 11 Jan 2024 19:41:33 +0800 (CST)
Subject: Re: [NOTFORMERGE PATCH 2/2] gitlab: Add Loongarch64 KVM-only build
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Zhiguo Wu <wuzhiguo@loongson.cn>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Beraldo Leal <bleal@redhat.com>, WANG Xuerui <git@xen0n.name>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>
References: <20240102172239.69452-1-philmd@linaro.org>
 <20240102172239.69452-3-philmd@linaro.org>
 <dbc7f2c6-15c0-4d5a-abf7-8946ff2d03cb@redhat.com>
 <4cc9ab90-c1bc-03d3-d82e-a763199fa029@loongson.cn>
 <96bdddb5-e15c-469f-b74b-7e82049888f1@redhat.com>
 <3766d853-8dc5-f455-e0ea-dd970c65a6c5@loongson.cn>
 <6f17d2f1-6876-4f1c-beb5-c6a4e89340d8@redhat.com>
 <94b84fa3-4a10-3fef-0415-6b87f2aa255b@loongson.cn>
 <0964ddb6-f403-4bec-8f90-23f8b9b0dfd6@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <41993aec-6bf3-c3c1-23f4-ac04a2c765b3@loongson.cn>
Date: Thu, 11 Jan 2024 19:41:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0964ddb6-f403-4bec-8f90-23f8b9b0dfd6@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxbNzr059lo_kPAA--.42054S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrurWxCFWDWF15ur13tw1DurX_yoWDWFb_ZF
 47urn5Ga1jkwsYya95trn3AFnrZFZIvr4rK3yjvrW0qwnrX398Jr45K3savan8Ka1FqFnI
 kF90vay5ZryUJosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
 xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
 6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
 1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
 rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14
 v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
 c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jza0PUUU
 UU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.982,
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

在 2024/1/11 下午7:26, Philippe Mathieu-Daudé 写道:
> On 11/1/24 10:51, gaosong wrote:
>> 在 2024/1/11 下午5:04, Thomas Huth 写道:
>>> On 11/01/2024 09.50, gaosong wrote:
>>>> 在 2024/1/11 下午4:20, Thomas Huth 写道:
>>>>> On 11/01/2024 08.37, gaosong wrote:
>
>>>> LoongArch no support these cmds  or some problems .
>>>> -    "gva2gpa 0",
>>>> -    "memsave 0 4096 \"/dev/null\"",
>>>> -    "x /8i 0x100",
>>>> -    "xp /16x 0",
>>>>
>>>> Could we disable these 4 cmds or the test_temp check?
>>>> After we fix the cmds problems, we can enable them.
>>>
>>> Even if loongarch does not support one of these commands, it should 
>>> not crash QEMU. So please fix the crashes first before considering 
>>> to enable the KVM-only test in the CI.
>>>
>>
>> Sure,  we will fix the cmds problems first.
>
> The issue might be missing get_phys_page_attrs_debug() implementation.

yes, I see,  from  hmp_gva2gpa().  I think we need implement it.

Thanks.
Song Gao


