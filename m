Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F78C81F387
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 02:07:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIerA-0003lN-Ar; Wed, 27 Dec 2023 20:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rIer6-0003kv-U5
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 20:06:36 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rIer4-00055B-Ti
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 20:06:36 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Bx34cWyoxlNyQFAA--.1435S3;
 Thu, 28 Dec 2023 09:06:30 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzuQUyoxlUGgNAA--.47003S3; 
 Thu, 28 Dec 2023 09:06:28 +0800 (CST)
Subject: Re: [PATCH v3 04/17] hw/loongarch: Add init_cmdline
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, maobibo@loongson.cn
References: <20231227080821.3216113-1-gaosong@loongson.cn>
 <20231227080821.3216113-5-gaosong@loongson.cn>
 <e420ed19-c7a1-4f1e-a625-f5caef8492ea@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <a3a006d7-22b4-92fb-6613-150ae97c16b9@loongson.cn>
Date: Thu, 28 Dec 2023 09:06:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e420ed19-c7a1-4f1e-a625-f5caef8492ea@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxzuQUyoxlUGgNAA--.47003S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWrur1xZr1UGr4xXw1fJFW8uFX_yoW8Jr17pF
 n7CF15ArWkGrn7Xr9Iy34fXr98Jr4xKw4293W3ta48Cr47J34jqr48Zryq9FyUXw4rtryF
 9ryDGa4j9Fs0qabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QVy3UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.291,
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

在 2023/12/27 下午4:49, Philippe Mathieu-Daudé 写道:
> Hi,
>
> On 27/12/23 09:08, Song Gao wrote:
>> Add init_cmline and set boot_info->a0, a1
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   hw/loongarch/boot.c    | 20 ++++++++++++++++++++
>>   target/loongarch/cpu.h |  2 ++
>>   2 files changed, 22 insertions(+)
>>
>> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
>> index faff880153..27eae6f0cb 100644
>> --- a/hw/loongarch/boot.c
>> +++ b/hw/loongarch/boot.c
>> @@ -13,6 +13,7 @@
>>   #include "elf.h"
>>   #include "qemu/error-report.h"
>>   #include "sysemu/reset.h"
>> +#include <asm-generic/setup.h>
>
> Build failure on Darwin host:
>
> [1135/1207] Compiling C object 
> libqemu-loongarch64-softmmu.fa.p/hw_loongarch_boot.c.o
> FAILED: libqemu-loongarch64-softmmu.fa.p/hw_loongarch_boot.c.o
> ../../hw/loongarch/boot.c:16:10: fatal error: 'asm-generic/setup.h' 
> file not found
> #include <asm-generic/setup.h>
>          ^~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
> ninja: build stopped: subcommand failed.
I will drop it , use #define COMAND_LINE_SIZE  512.

Thanks.
Song Gao


