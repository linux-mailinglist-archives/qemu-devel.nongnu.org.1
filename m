Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 287B87933F6
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 05:11:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdivy-0005Uo-Gj; Tue, 05 Sep 2023 23:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1qdivs-0005Rs-M3
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 23:10:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1qdivd-0005Pc-0d
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 23:10:20 -0400
Received: from loongson.cn (unknown [10.20.42.170])
 by gateway (Coremail) with SMTP id _____8AxXOqE7fdkpAsgAA--.37337S3;
 Wed, 06 Sep 2023 11:09:56 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxriOB7fdkQ+9tAA--.27310S3; 
 Wed, 06 Sep 2023 11:09:54 +0800 (CST)
Message-ID: <8282d576-5370-0547-9065-1e76f09e9526@loongson.cn>
Date: Wed, 6 Sep 2023 11:09:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/loongarch: Add virtio-mmio bus support
To: Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, yangxiaojuan@loongson.cn
References: <20230906025000.3101766-1-zhaotianrui@loongson.cn>
Content-Language: en-US
From: bibo mao <maobibo@loongson.cn>
In-Reply-To: <20230906025000.3101766-1-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxriOB7fdkQ+9tAA--.27310S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AF4xCF18XFy5Xw1xAr4xAFc_yoW8Xr43pr
 ZruF1kGws5GF9rWa9av34UWr1DZrs7Kry2gF4avrWIkrW3Cr1DuryrArnxZFy7t395GFs2
 qF9Yka4jqa1UZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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



在 2023/9/6 10:50, Tianrui Zhao 写道:
> Add virtio-mmio bus support for LoongArch, so that devices
> could be added in the virtio-mmio bus.
> 
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> ---
>  hw/loongarch/Kconfig | 1 +
>  hw/loongarch/virt.c  | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
> index 1e7c5b43c5..01ab8ce8e7 100644
> --- a/hw/loongarch/Kconfig
> +++ b/hw/loongarch/Kconfig
> @@ -22,3 +22,4 @@ config LOONGARCH_VIRT
>      select DIMM
>      select PFLASH_CFI01
>      select ACPI_HMAT
> +    select VIRTIO_MMIO
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 2629128aed..06f4bc3a5e 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -560,6 +560,9 @@ static void loongarch_devices_init(DeviceState *pch_pic, LoongArchMachineState *
>                           VIRT_RTC_IRQ - VIRT_GSI_BASE));
>      fdt_add_rtc_node(lams);
>  
> +    /* virtio-mmio device */
> +    sysbus_create_simple("virtio-mmio", 0x1e200000, qdev_get_gpio_in(pch_pic, 7));
It had better use macro rather than hardcoded value like 0x1e200000/7.

Another way multiple virtio-mmio devices should be added like other arches.
And there should be fdt/acpi table added for the device so that users can use it.

Regards
Bibo Mao
> +
>      pm_mem = g_new(MemoryRegion, 1);
>      memory_region_init_io(pm_mem, NULL, &loongarch_virt_pm_ops,
>                            NULL, "loongarch_virt_pm", PM_SIZE);


