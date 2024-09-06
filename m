Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD6C96EE41
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Sep 2024 10:36:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smUR5-0000xJ-4m; Fri, 06 Sep 2024 04:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1smUQp-0000oa-JZ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 04:35:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1smUQm-0006cg-3h
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 04:35:02 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxruquvtpmvioAAA--.1159S3;
 Fri, 06 Sep 2024 16:34:54 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front2 (Coremail) with SMTP id qciowMDxWsatvtpmFRkAAA--.515S3;
 Fri, 06 Sep 2024 16:34:54 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch: virt: support up to 4 serial ports
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, qemu-devel@nongnu.org, thomas@t-8ch.de,
 xry111@xry111.site
References: <ZtqJuTTR0wdcVXdz@zx2c4.com>
 <20240906044944.2427297-1-Jason@zx2c4.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <1718b6db-0535-ea6d-76ae-268fde30384b@loongson.cn>
Date: Fri, 6 Sep 2024 16:34:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240906044944.2427297-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qciowMDxWsatvtpmFRkAAA--.515S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtw15Aw43Ww13ZFyDJFy8Xrc_yoWxXF1rpF
 WqkFn0qrWUWr13W34Sv3W5Gr47JrsrCay2gw4xWrySyFykWr10qrW0y39xtryUX395JFyY
 vFZ0q3sF93WjqrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25Ef
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.9,
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



On 2024/9/6 下午12:49, Jason A. Donenfeld wrote:
> In order to support additional channels of communication using
> `-serial`, add several serial ports, up to the standard 4 generally
> supported by the 8250 driver.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>   hw/loongarch/virt.c        | 24 ++++++++++++++----------
>   include/hw/pci-host/ls7a.h |  9 +++++----
>   2 files changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 4151fc5e0c..155678b684 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -319,10 +319,10 @@ static void fdt_add_ged_reset(LoongArchVirtMachineState *lvms)
>   }
>   
>   static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
> -                              uint32_t *pch_pic_phandle)
> +                              uint32_t *pch_pic_phandle, hwaddr base,
> +                              int irq, bool chosen)
>   {
>       char *nodename;
> -    hwaddr base = VIRT_UART_BASE;
>       hwaddr size = VIRT_UART_SIZE;
>       MachineState *ms = MACHINE(lvms);
>   
> @@ -331,9 +331,9 @@ static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
>       qemu_fdt_setprop_string(ms->fdt, nodename, "compatible", "ns16550a");
>       qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0x0, base, 0x0, size);
>       qemu_fdt_setprop_cell(ms->fdt, nodename, "clock-frequency", 100000000);
> -    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
> -    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
> -                           VIRT_UART_IRQ - VIRT_GSI_BASE, 0x4);
> +    if (chosen)
> +        qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq, 0x4);
>       qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
>                             *pch_pic_phandle);
>       g_free(nodename);
> @@ -750,11 +750,15 @@ static void virt_devices_init(DeviceState *pch_pic,
>       /* Add pcie node */
>       fdt_add_pcie_node(lvms, pch_pic_phandle, pch_msi_phandle);
>   
> -    serial_mm_init(get_system_memory(), VIRT_UART_BASE, 0,
> -                   qdev_get_gpio_in(pch_pic,
> -                                    VIRT_UART_IRQ - VIRT_GSI_BASE),
> -                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
> -    fdt_add_uart_node(lvms, pch_pic_phandle);
> +    for (i = 0; i < VIRT_UART_COUNT; ++i) {
How about adding serial_hd(i) checking here, such as
   for (i = 0; (i < VIRT_UART_COUNT) && serial_hd(i); ++i) {

> +        hwaddr base = VIRT_UART_BASE + i * VIRT_UART_SIZE;
> +        int irq = VIRT_UART_IRQ + i - VIRT_GSI_BASE;
> +        serial_mm_init(get_system_memory(), base, 0,
> +                       qdev_get_gpio_in(pch_pic, irq),
> +                       115200, serial_hd(VIRT_UART_COUNT - 1 - i),
is it serial_hd(i) here rather than serial_hd(VIRT_UART_COUNT - 1 - i)? 
In general serial_hd(0) is default serial.

> +                       DEVICE_LITTLE_ENDIAN);
> +        fdt_add_uart_node(lvms, pch_pic_phandle, base, irq, i == 0);
> +    }
>   
>       /* Network init */
>       pci_init_nic_devices(pci_bus, mc->default_nic);
> diff --git a/include/hw/pci-host/ls7a.h b/include/hw/pci-host/ls7a.h
> index cd7c9ec7bc..79d4ea8501 100644
> --- a/include/hw/pci-host/ls7a.h
> +++ b/include/hw/pci-host/ls7a.h
> @@ -36,17 +36,18 @@
>   #define VIRT_PCH_PIC_IRQ_NUM     32
>   #define VIRT_GSI_BASE            64
>   #define VIRT_DEVICE_IRQS         16
> +#define VIRT_UART_COUNT          4
>   #define VIRT_UART_IRQ            (VIRT_GSI_BASE + 2)
>   #define VIRT_UART_BASE           0x1fe001e0
> -#define VIRT_UART_SIZE           0X100
> -#define VIRT_RTC_IRQ             (VIRT_GSI_BASE + 3)
> +#define VIRT_UART_SIZE           0x100
> +#define VIRT_RTC_IRQ             (VIRT_GSI_BASE + 6)
>   #define VIRT_MISC_REG_BASE       (VIRT_PCH_REG_BASE + 0x00080000)
>   #define VIRT_RTC_REG_BASE        (VIRT_MISC_REG_BASE + 0x00050100)
>   #define VIRT_RTC_LEN             0x100
> -#define VIRT_SCI_IRQ             (VIRT_GSI_BASE + 4)
> +#define VIRT_SCI_IRQ             (VIRT_GSI_BASE + 7)
>   
>   #define VIRT_PLATFORM_BUS_BASEADDRESS   0x16000000
>   #define VIRT_PLATFORM_BUS_SIZE          0x2000000
>   #define VIRT_PLATFORM_BUS_NUM_IRQS      2
> -#define VIRT_PLATFORM_BUS_IRQ           (VIRT_GSI_BASE + 5)
> +#define VIRT_PLATFORM_BUS_IRQ           (VIRT_GSI_BASE + 8)
>   #endif
> 
By the way, serial port for acpi table should be refreshed also, such as
diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index 2638f87434..5bd2a9beaa 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -31,6 +31,7 @@

  #include "hw/acpi/generic_event_device.h"
  #include "hw/pci-host/gpex.h"
+#include "sysemu/sysemu.h"
  #include "sysemu/tpm.h"
  #include "hw/platform-bus.h"
  #include "hw/acpi/aml-build.h"
@@ -252,23 +253,26 @@ struct AcpiBuildState {
      MemoryRegion *linker_mr;
  } AcpiBuildState;

-static void build_uart_device_aml(Aml *table)
+static void build_uart_device_aml(Aml *table, int index)
  {
      Aml *dev;
      Aml *crs;
      Aml *pkg0, *pkg1, *pkg2;
-    uint32_t uart_irq = VIRT_UART_IRQ;
+    uint32_t uart_irq;
+    uint64_t base;

+    uart_irq = VIRT_UART_IRQ + index;
+    base = VIRT_UART_BASE + index * VIRT_UART_SIZE;
      Aml *scope = aml_scope("_SB");
-    dev = aml_device("COMA");
+    dev = aml_device("COM%d", index);
      aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
-    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+    aml_append(dev, aml_name_decl("_UID", aml_int(index)));
      aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
      crs = aml_resource_template();
      aml_append(crs,
          aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
                           AML_NON_CACHEABLE, AML_READ_WRITE,
-                         0, VIRT_UART_BASE, VIRT_UART_BASE + 
VIRT_UART_SIZE - 1,
+                         0, base, base + VIRT_UART_SIZE - 1,
                           0, VIRT_UART_SIZE));
      aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, 
AML_ACTIVE_HIGH,
                                    AML_SHARED, &uart_irq, 1));
@@ -405,10 +409,13 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, 
MachineState *machine)
      LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
      AcpiTable table = { .sig = "DSDT", .rev = 1, .oem_id = lvms->oem_id,
                          .oem_table_id = lvms->oem_table_id };
+    int i;

      acpi_table_begin(&table, table_data);
      dsdt = init_aml_allocator();
-    build_uart_device_aml(dsdt);
+    for (i = 0; (i < VIRT_UART_COUNT) && serial_hd(i); i++) {
+        build_uart_device_aml(dsdt, i);
+    }
      build_pci_device_aml(dsdt, lvms);
      build_la_ged_aml(dsdt, machine);
      build_flash_aml(dsdt, lvms);


Regards
Bibo Mao


