Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 611F779FE39
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 10:24:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qghdL-0002L8-6M; Thu, 14 Sep 2023 04:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qghdI-0002KR-96
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 04:23:28 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qghdF-0001uH-5o
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 04:23:28 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxRvH1wgJl2TsnAA--.10406S3;
 Thu, 14 Sep 2023 16:23:17 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Ax3tz1wgJlCYYEAA--.8491S3; 
 Thu, 14 Sep 2023 16:23:17 +0800 (CST)
Subject: Re: [PATCH v3] hw/loongarch: Add virtio-mmio bus support
To: Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn
References: <20230911085903.664996-1-zhaotianrui@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <51d4859d-cc32-f359-4bf2-fabe5ac6923c@loongson.cn>
Date: Thu, 14 Sep 2023 16:23:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230911085903.664996-1-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax3tz1wgJlCYYEAA--.8491S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxArykAF45Ar45uFWrZw17XFc_yoW7JrWUpF
 WUCFnavr4UWF1xX34Sqa45urn5Arn7G3y29r1SgrW0kFykWr1kJ348C398tFyUA34vqF40
 vF1v93s2g3WqyFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.473, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ÔÚ 2023/9/11 ÏÂÎç4:59, Tianrui Zhao Ð´µÀ:
> Add virtio-mmio bus support for LoongArch, so that devices
> could be added in the virtio-mmio bus.
> 
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> Change-Id: Ib882005106562e0dfe74122a7fa2430fa081bfb2
> ---
>   hw/loongarch/Kconfig       |  1 +
>   hw/loongarch/acpi-build.c  | 25 +++++++++++++++++++++++++
>   hw/loongarch/virt.c        | 28 ++++++++++++++++++++++++++++
>   include/hw/pci-host/ls7a.h |  4 ++++
>   4 files changed, 58 insertions(+)
> 
Drop Change-Id, and update virt.rst ('- 4 virtio-mmio transport devices')

Reviewed-by: Song Gao <gaosong@loongson.cn>

> diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
> index 1e7c5b43c5..01ab8ce8e7 100644
> --- a/hw/loongarch/Kconfig
> +++ b/hw/loongarch/Kconfig
> @@ -22,3 +22,4 @@ config LOONGARCH_VIRT
>       select DIMM
>       select PFLASH_CFI01
>       select ACPI_HMAT
> +    select VIRTIO_MMIO
> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
> index ae292fc543..d033fc2271 100644
> --- a/hw/loongarch/acpi-build.c
> +++ b/hw/loongarch/acpi-build.c
> @@ -363,6 +363,30 @@ static void acpi_dsdt_add_tpm(Aml *scope, LoongArchMachineState *vms)
>   }
>   #endif
>   
> +static void acpi_dsdt_add_virtio(Aml *scope)
> +{
> +    int i;
> +    hwaddr base = VIRT_VIRTIO_MMIO_BASE;
> +    hwaddr size = VIRT_VIRTIO_MMIO_SIZE;
> +
> +    for (i = 0; i < VIRT_VIRTIO_MMIO_NUM; i++) {
> +        uint32_t irq = VIRT_VIRTIO_MMIO_IRQ + i;
> +        Aml *dev = aml_device("VR%02u", i);
> +
> +        aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")));
> +        aml_append(dev, aml_name_decl("_UID", aml_int(i)));
> +        aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> +
> +        Aml *crs = aml_resource_template();
> +        aml_append(crs, aml_memory32_fixed(base, size, AML_READ_WRITE));
> +        aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
> +                   AML_EXCLUSIVE, &irq, 1));
> +        aml_append(dev, aml_name_decl("_CRS", crs));
> +        aml_append(scope, dev);
> +        base += size;
> +    }
> +}
> +
>   /* build DSDT */
>   static void
>   build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
> @@ -381,6 +405,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>   #ifdef CONFIG_TPM
>       acpi_dsdt_add_tpm(dsdt, lams);
>   #endif
> +    acpi_dsdt_add_virtio(dsdt);
>       /* System State Package */
>       scope = aml_scope("\\");
>       pkg = aml_package(4);
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 2629128aed..ffef3222da 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -116,6 +116,25 @@ static void fdt_add_rtc_node(LoongArchMachineState *lams)
>       g_free(nodename);
>   }
>   
> +static void fdt_add_virtio_mmio_node(LoongArchMachineState *lams)
> +{
> +    int i;
> +    MachineState *ms = MACHINE(lams);
> +
> +    for (i = VIRT_VIRTIO_MMIO_NUM - 1; i >= 0; i--) {
> +        char *nodename;
> +        hwaddr base = VIRT_VIRTIO_MMIO_BASE + i * VIRT_VIRTIO_MMIO_SIZE;
> +
> +        nodename = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
> +        qemu_fdt_add_subnode(ms->fdt, nodename);
> +        qemu_fdt_setprop_string(ms->fdt, nodename,
> +                                "compatible", "virtio,mmio");
> +        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
> +                                     2, base, 2, VIRT_VIRTIO_MMIO_SIZE);
> +        g_free(nodename);
> +    }
> +}
> +
>   static void fdt_add_uart_node(LoongArchMachineState *lams)
>   {
>       char *nodename;
> @@ -560,6 +579,15 @@ static void loongarch_devices_init(DeviceState *pch_pic, LoongArchMachineState *
>                            VIRT_RTC_IRQ - VIRT_GSI_BASE));
>       fdt_add_rtc_node(lams);
>   
> +    /* virtio-mmio device */
> +    for (i = 0; i < VIRT_VIRTIO_MMIO_NUM; i++) {
> +        hwaddr virtio_base = VIRT_VIRTIO_MMIO_BASE + i * VIRT_VIRTIO_MMIO_SIZE;
> +        int virtio_irq = VIRT_VIRTIO_MMIO_IRQ - VIRT_GSI_BASE + i;
> +        sysbus_create_simple("virtio-mmio", virtio_base,
> +                              qdev_get_gpio_in(pch_pic, virtio_irq));
> +    }
> +    fdt_add_virtio_mmio_node(lams);
> +
>       pm_mem = g_new(MemoryRegion, 1);
>       memory_region_init_io(pm_mem, NULL, &loongarch_virt_pm_ops,
>                             NULL, "loongarch_virt_pm", PM_SIZE);
> diff --git a/include/hw/pci-host/ls7a.h b/include/hw/pci-host/ls7a.h
> index e753449593..96506b9a4c 100644
> --- a/include/hw/pci-host/ls7a.h
> +++ b/include/hw/pci-host/ls7a.h
> @@ -42,6 +42,10 @@
>   #define VIRT_RTC_REG_BASE        (VIRT_MISC_REG_BASE + 0x00050100)
>   #define VIRT_RTC_LEN             0x100
>   #define VIRT_SCI_IRQ             (VIRT_GSI_BASE + 4)
> +#define VIRT_VIRTIO_MMIO_IRQ     (VIRT_GSI_BASE + 7)
> +#define VIRT_VIRTIO_MMIO_BASE    0x1e200000
> +#define VIRT_VIRTIO_MMIO_SIZE    0x200
> +#define VIRT_VIRTIO_MMIO_NUM     4
> 

how about set num is 8 or larger?

virt machine

arm  : 32
openrisc : 8
riscv: 8



>   #define VIRT_PLATFORM_BUS_BASEADDRESS   0x16000000
>   #define VIRT_PLATFORM_BUS_SIZE          0x2000000
> 


