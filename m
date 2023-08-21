Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE23F78212C
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 03:25:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXtfK-0002Yk-Qf; Sun, 20 Aug 2023 21:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1qXtfH-0002Y5-Ek
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 21:25:07 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1qXtfD-0000xA-P5
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 21:25:07 -0400
Received: from loongson.cn (unknown [10.20.42.170])
 by gateway (Coremail) with SMTP id _____8Dx_+vlvOJk2HEaAA--.53108S3;
 Mon, 21 Aug 2023 09:24:53 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxXSPkvOJkOB5fAA--.16960S3; 
 Mon, 21 Aug 2023 09:24:52 +0800 (CST)
Message-ID: <5b4b93c2-bfe2-09b0-facd-42f899767451@loongson.cn>
Date: Mon, 21 Aug 2023 09:24:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/loongarch: Fix ACPI processor id off-by-one error
Content-Language: en-US
To: Jiajie Chen <c@jia.je>
Cc: richard.henderson@linaro.org, gaosong@loongson.cn,
 zhaotianrui@loongson.cn, qemu-devel@nongnu.org, =?UTF-8?B?5p2O6aaZ5p2l?=
 <lixianglai@loongson.cn>
References: <20230820105658.99123-2-c@jia.je>
From: bibo mao <maobibo@loongson.cn>
In-Reply-To: <20230820105658.99123-2-c@jia.je>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxXSPkvOJkOB5fAA--.16960S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF18AF4rJr1fZF4fWF4ftFc_yoW8KrWkpF
 Wjv3ykKr1kGr4fC3s7Aas2gFyrJr4kGw47ZF4xKrykAa4xWry0qF10krZIvFZrCw1rC3Z2
 vr4Utw1UWF43AFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1EksDUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.279,
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

+ Add xianglai

Good catch.

In theory, it is logical id, and it can be not equal to physical id.
However it must be equal to _UID in cpu dsdt table which is missing
now.

Can pptt table parse error be fixed if cpu dsdt table is added?

Regards
Bibo Mao


在 2023/8/20 18:56, Jiajie Chen 写道:
> In hw/acpi/aml-build.c:build_pptt() function, the code assumes that the
> ACPI processor id equals to the cpu index, for example if we have 8
> cpus, then the ACPI processor id should be in range 0-7.
> 
> However, in hw/loongarch/acpi-build.c:build_madt() function we broke the
> assumption. If we have 8 cpus again, the ACPI processor id in MADT table
> would be in range 1-8. It violates the following description taken from
> ACPI spec 6.4 table 5.138:
> 
> If the processor structure represents an actual processor, this field
> must match the value of ACPI processor ID field in the processor’s entry
> in the MADT.
> 
> It will break the latest Linux 6.5-rc6 with the
> following error message:
> 
> ACPI PPTT: PPTT table found, but unable to locate core 7 (8)
> Invalid BIOS PPTT
> 
> Here 7 is the last cpu index, 8 is the ACPI processor id learned from
> MADT.
> 
> With this patch, Linux can properly detect SMT threads when "-smp
> 8,sockets=1,cores=4,threads=2" is passed:
> 
> Thread(s) per core:  2
> Core(s) per socket:  2
> Socket(s):           2
> 
> The detection of number of sockets is still wrong, but that is out of
> scope of the commit.
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>  hw/loongarch/acpi-build.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
> index 0b62c3a2f7..ae292fc543 100644
> --- a/hw/loongarch/acpi-build.c
> +++ b/hw/loongarch/acpi-build.c
> @@ -127,7 +127,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, LoongArchMachineState *lams)
>          build_append_int_noprefix(table_data, 17, 1);    /* Type */
>          build_append_int_noprefix(table_data, 15, 1);    /* Length */
>          build_append_int_noprefix(table_data, 1, 1);     /* Version */
> -        build_append_int_noprefix(table_data, i + 1, 4); /* ACPI Processor ID */
> +        build_append_int_noprefix(table_data, i, 4);     /* ACPI Processor ID */
>          build_append_int_noprefix(table_data, arch_id, 4); /* Core ID */
>          build_append_int_noprefix(table_data, 1, 4);     /* Flags */
>      }


