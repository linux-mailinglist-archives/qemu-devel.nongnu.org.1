Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AAA831896
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 12:43:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQQmu-0003ak-Sl; Thu, 18 Jan 2024 06:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rQQmo-0003aW-F4
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 06:42:18 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rQQml-00037V-KA
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 06:42:18 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxefCSDqllHp4BAA--.8234S3;
 Thu, 18 Jan 2024 19:42:11 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx8OSQDqllnG0IAA--.43190S3; 
 Thu, 18 Jan 2024 19:42:09 +0800 (CST)
Subject: Re: [PATCH v4 00/17] Add boot LoongArch elf kernel with FDT
From: gaosong <gaosong@loongson.cn>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org,
 maobibo@loongson.cn, zhaotianrui@loongson.cn, lixianglai@loongson.cn
References: <20240118111900.1672536-1-gaosong@loongson.cn>
Message-ID: <ffe7907a-8cb3-f36c-6f6c-7687a820ff47@loongson.cn>
Date: Thu, 18 Jan 2024 19:42:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240118111900.1672536-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bx8OSQDqllnG0IAA--.43190S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxury7AFW3WrW3Wr17Gw1UXFc_yoW5XF4fpF
 W7Zr13Wrs5JrZ7A3sav34aqr90vwn7Gr12v3W3Kry8CrZFvFy7Z3WxAr9rXFyUt3yIgryq
 vr1Fkw1jgF4UJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzZ2-
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.748,
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


Please ignore this,  I will  resend it.

在 2024/1/18 下午7:18, Song Gao 写道:
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
> V4:
>    - patch 3 change slave_boot_code[] to const, and 'static void *p ' to
>      'void *p';
>    - patch 4 fixes build error;
>    - patch 10-13, add project and commit link.
>
> V3:
>    - Load initrd at  kernel_high + 4 * kernel_size;
>    - Load 'boot_rom' at [0 - 1M], the 'boot_rom' includes
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


