Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F64875FD3
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Mar 2024 09:41:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVnD-0006J1-8M; Fri, 08 Mar 2024 03:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1riVn4-0006A1-0p
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:41:18 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1riVmw-0004ka-Ks
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:41:14 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8AxOOgiz+plZzoWAA--.35347S3;
 Fri, 08 Mar 2024 16:41:06 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxPBMhz+pliCxRAA--.19074S3; 
 Fri, 08 Mar 2024 16:41:05 +0800 (CST)
Subject: Re: [PATCH v6 12/17] hw/loongarch: fdt adds pch_pic Controller
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240307164835.300412-1-gaosong@loongson.cn>
 <20240307164835.300412-13-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <9c77f34d-8dd4-7a7b-c26a-f98b89c82a1b@loongson.cn>
Date: Fri, 8 Mar 2024 16:41:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240307164835.300412-13-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxPBMhz+pliCxRAA--.19074S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF4fKF48Jw48JFWDGry5Jrc_yoW5uFyUpF
 WUAFs3CF4xGF1UWrsava4UCr1fAr1fu34jgr17urW0kF98W3s7Xr18A393Jry8Aw4kX3WY
 qFsYgr9Fg3WkGwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
 db8UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.08,
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



On 2024/3/8 上午12:48, Song Gao wrote:
> fdt adds pch pic controller, we use 'loongson,pch-pic-1.0'
> 
> See:
> https://github.com/torvalds/linux/blob/v6.7/drivers/irqchip/irq-loongson-pch-pic.c
> https://lore.kernel.org/r/20200528152757.1028711-4-jiaxun.yang@flygoat.com
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <20240301093839.663947-13-gaosong@loongson.cn>
> ---
>   hw/loongarch/virt.c        | 30 +++++++++++++++++++++++++++++-
>   include/hw/pci-host/ls7a.h |  1 +
>   2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 822f070c45..2b7b653fc1 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -148,6 +148,31 @@ static void fdt_add_eiointc_node(LoongArchMachineState *lams,
>       g_free(nodename);
>   }
>   
> +static void fdt_add_pch_pic_node(LoongArchMachineState *lams,
> +                                 uint32_t *eiointc_phandle,
> +                                 uint32_t *pch_pic_phandle)
> +{
> +    MachineState *ms = MACHINE(lams);
> +    char *nodename;
> +    hwaddr pch_pic_base = VIRT_PCH_REG_BASE;
> +    hwaddr pch_pic_size = VIRT_PCH_REG_SIZE;
> +
> +    *pch_pic_phandle = qemu_fdt_alloc_phandle(ms->fdt);
> +    nodename = g_strdup_printf("/platic@%" PRIx64, pch_pic_base);
> +    qemu_fdt_add_subnode(ms->fdt, nodename);
> +    qemu_fdt_setprop_cell(ms->fdt,  nodename, "phandle", *pch_pic_phandle);
> +    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
> +                            "loongson,pch-pic-1.0");
> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0,
> +                           pch_pic_base, 0, pch_pic_size);
> +    qemu_fdt_setprop(ms->fdt, nodename, "interrupt-controller", NULL, 0);
> +    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 2);
> +    qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
> +                          *eiointc_phandle);
> +    qemu_fdt_setprop_cell(ms->fdt, nodename, "loongson,pic-base-vec", 0);
> +    g_free(nodename);
> +}
> +
>   static void fdt_add_flash_node(LoongArchMachineState *lams)
>   {
>       MachineState *ms = MACHINE(lams);
> @@ -569,7 +594,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
>       CPULoongArchState *env;
>       CPUState *cpu_state;
>       int cpu, pin, i, start, num;
> -    uint32_t cpuintc_phandle, eiointc_phandle;
> +    uint32_t cpuintc_phandle, eiointc_phandle, pch_pic_phandle;
>   
>       /*
>        * The connection of interrupts:
> @@ -660,6 +685,9 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
>           qdev_connect_gpio_out(DEVICE(d), i, qdev_get_gpio_in(extioi, i));
>       }
>   
> +    /* Add PCH PIC node */
> +    fdt_add_pch_pic_node(lams, &eiointc_phandle, &pch_pic_phandle);
> +
>       pch_msi = qdev_new(TYPE_LOONGARCH_PCH_MSI);
>       start   =  num;
>       num = EXTIOI_IRQS - start;
> diff --git a/include/hw/pci-host/ls7a.h b/include/hw/pci-host/ls7a.h
> index e753449593..fe260f0183 100644
> --- a/include/hw/pci-host/ls7a.h
> +++ b/include/hw/pci-host/ls7a.h
> @@ -24,6 +24,7 @@
>   #define VIRT_PCH_REG_BASE        0x10000000UL
>   #define VIRT_IOAPIC_REG_BASE     (VIRT_PCH_REG_BASE)
>   #define VIRT_PCH_MSI_ADDR_LOW    0x2FF00000UL
> +#define VIRT_PCH_REG_SIZE        0x400
>   
>   /*
>    * GSI_BASE is hard-coded with 64 in linux kernel, else kernel fails to boot
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


