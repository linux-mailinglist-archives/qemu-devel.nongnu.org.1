Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B4A72F20E
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:36:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FQZ-0004HF-2k; Tue, 13 Jun 2023 21:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaotianrui@loongson.cn>)
 id 1q9FPv-0004CF-BN
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:35:24 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhaotianrui@loongson.cn>) id 1q9FPs-0007Qu-L9
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:35:23 -0400
Received: from loongson.cn (unknown [10.40.46.158])
 by gateway (Coremail) with SMTP id _____8AxnOpRGYlkheYEAA--.10437S3;
 Wed, 14 Jun 2023 09:35:14 +0800 (CST)
Received: from [192.168.124.126] (unknown [10.40.46.158])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxKeVPGYlkXP0ZAA--.8391S3; 
 Wed, 14 Jun 2023 09:35:12 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch: Supplement cpu topology arguments
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 alex.bennee@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn,
 gaosong@loongson.cn
References: <20230613123251.2471878-1-zhaotianrui@loongson.cn>
 <7565da8d-a7ad-ba02-9a59-9a441da2d988@linaro.org>
From: zhaotianrui <zhaotianrui@loongson.cn>
Message-ID: <ae679a39-aec8-a38c-9409-fc2d77802017@loongson.cn>
Date: Wed, 14 Jun 2023 09:35:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7565da8d-a7ad-ba02-9a59-9a441da2d988@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxKeVPGYlkXP0ZAA--.8391S3
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Gw18uw1Dtr1DZw4rJF13trc_yoWDXFg_GF
 WIk3ykuw4rWr1Ika4UZFs8ZFyDJ3yUua1Yvr98Zr1rW34Fyrs3JF4UW3s3u34Fvay0vrZ3
 Xa1kG393Cry7ZosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUba8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
 bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
 AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
 42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
 IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
 KfnxnUUI43ZEXa7IU1RBT5UUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=zhaotianrui@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.098,
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


在 2023/6/13 下午8:55, Philippe Mathieu-Daudé 写道:
> On 13/6/23 14:32, Tianrui Zhao wrote:
>> Supplement LoongArch cpu topology arguments, including support socket
>> and threads per core.
>>
>> Base-on:
>> https://patchew.org/QEMU/20230613122613.2471743-1-zhaotianrui@loongson.cn/ 
>>
>
> ^ FYI this tag ...
>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
>> ---
>
> ... goes here after the '---' separator, because it is only helpful when
> testing/merging the patch. Once it is committed, this become irrelevant.
> (Everything after the '---' separator is normally stripped when applying
> patches).
>
Thanks, I will move the 'Base-on' flag after the '---'.

Tianrui Zhao

>>   hw/loongarch/acpi-build.c | 4 ++++
>>   hw/loongarch/virt.c       | 9 ++++++++-
>>   2 files changed, 12 insertions(+), 1 deletion(-)
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


