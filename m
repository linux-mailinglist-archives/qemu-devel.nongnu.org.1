Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7B786DE8B
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Mar 2024 10:45:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfzRV-0003LV-0B; Fri, 01 Mar 2024 04:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rfzRS-0003Kz-E1
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 04:44:34 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rfzRQ-0007HJ-58
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 04:44:34 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Axuuh7o+Fl4T0TAA--.29011S3;
 Fri, 01 Mar 2024 17:44:27 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxXRN3o+Fl0p1LAA--.4895S3; 
 Fri, 01 Mar 2024 17:44:25 +0800 (CST)
Subject: Re: [PATCH v5 00/17] Add boot LoongArch elf kernel with FDT
From: gaosong <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org, maobibo@loongson.cn, zhaotianrui@loongson.cn,
 lixianglai@loongson.cn, imammedo@redhat.com, anisinha@redhat.com,
 mst@redhat.com
References: <20240301093839.663947-1-gaosong@loongson.cn>
Message-ID: <b97acf96-6bb7-be47-0f27-34dee5820523@loongson.cn>
Date: Fri, 1 Mar 2024 17:44:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240301093839.663947-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxXRN3o+Fl0p1LAA--.4895S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGry8ur1UAw15AryxJr4kKrX_yoW5XrWfpF
 W7Zr13Grs5JrZ7Ar9av343Xr90yrn7Gr12v3W3Kry8CrZFvF17Z3WxAr9rZFy7t3y0gryq
 vr1Fkw1jga15J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xu
 ctUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-4.176, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi,

If there are no new comments, I'll add this series to the loongarch-next 
branch next week.

Thanks.
Song Gao

�� 2024/3/1 ����5:38, Song Gao д��:
> Hi, All
>
> We already support boot efi kernel with bios, but not support boot elf kernel.
> This series adds boot elf kernel with FDT.
>
> 'LoongArch supports ACPI and FDT. The information that needs to be passed
>   to the kernel includes the memmap, the initrd, the command line, optionally
>   the ACPI/FDT tables, and so on'  see [1].
>
> Patch 2-8 : Create efi system table, and three efi configuration table
>              boot_memmap, initd, FDT.
> Patch 9-17 : Fixes FDT problems.
>
> Test:
>    - Start kernel
>      See [2] start_kernel.sh
>    - Start qcow2
>      See [2] start_qcow2.sh
>
> V5:
>    - Rebase;
>
> V4:
>    - patch 3 change slave_boot_code[] to const, and 'static void *p ' to
>      'void *p';
>    - patch 4 fixes build error;
>    - patch 10-13, add project and commit link.
>
> V3:
>    - Load initrd at  kernel_high + 4 * kernel_size;
>    - Load 'boot_rom' at [0 - 1M], the 'boot_rom' includes
>      slave_boot_code, cmdline_buf and systab_tables;
>    - R-b and rebase.
>
> V2:
>    - FDT pcie node adds cells 'msi-map';
>
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/arch/loongarch/booting.rst?h=v6.7-rc4
>
> [2]: https://github.com/gaosong-loongson/loongarch-binary/releases
>
> Please review!
>
> Thanks.
> Song Gao
>
> Song Gao (17):
>    hw/loongarch: Move boot fucntions to boot.c
>    hw/loongarch: Add load initrd
>    hw/loongarch: Add slave cpu boot_code
>    hw/loongarch: Add init_cmdline
>    hw/loongarch: Init efi_system_table
>    hw/loongarch: Init efi_boot_memmap table
>    hw/loongarch: Init efi_initrd table
>    hw/loongarch: Init efi_fdt table
>    hw/loongarch: Fix fdt memory node wrong 'reg'
>    hw/loongarch: fdt adds cpu interrupt controller node
>    hw/loongarch: fdt adds Extend I/O Interrupt Controller
>    hw/loongarch: fdt adds pch_pic Controller
>    hw/loongarch: fdt adds pch_msi Controller
>    hw/loongarch: fdt adds pcie irq_map node
>    hw/loongarch: fdt remove unused irqchip node
>    hw/loongarch: Add cells missing from uart node
>    hw/loongarch: Add cells missing from rtc node
>
>   include/hw/intc/loongarch_extioi.h |   1 +
>   include/hw/loongarch/boot.h        | 109 +++++++++
>   include/hw/loongarch/virt.h        |  14 ++
>   include/hw/pci-host/ls7a.h         |   2 +
>   target/loongarch/cpu.h             |   2 +
>   hw/loongarch/boot.c                | 330 ++++++++++++++++++++++++++
>   hw/loongarch/virt.c                | 364 ++++++++++++++++-------------
>   hw/loongarch/meson.build           |   1 +
>   8 files changed, 661 insertions(+), 162 deletions(-)
>   create mode 100644 include/hw/loongarch/boot.h
>   create mode 100644 hw/loongarch/boot.c
>


