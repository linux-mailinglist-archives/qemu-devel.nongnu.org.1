Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D07EF82927E
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 03:48:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNOc6-0000Qp-Sf; Tue, 09 Jan 2024 21:46:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rNOc3-0000Ne-Fq
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 21:46:39 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rNObv-0007bE-P0
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 21:46:39 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxbbsBBZ5lCbUDAA--.3229S3;
 Wed, 10 Jan 2024 10:46:25 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cxid3+BJ5lDg4KAA--.26792S3; 
 Wed, 10 Jan 2024 10:46:24 +0800 (CST)
Subject: Re: [PATCH v4 0/9] Add loongarch kvm accel support
To: Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org, yangxiaojuan@loongson.cn
References: <20240105075804.1228596-1-zhaotianrui@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <a51860ec-26f7-6567-bee5-86b03afb9dad@loongson.cn>
Date: Wed, 10 Jan 2024 10:46:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240105075804.1228596-1-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cxid3+BJ5lDg4KAA--.26792S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Wr45Ww1ruF1rWF4rtw4UWrX_yoW7Kw17p3
 47Zr1DGrs8JrZrJF1kZasxXr1DXF4xGFsF9a4Sq3s2k3yavry8Z3s293srWFWqy347GFy0
 qF1fAw1UuF1UZ3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UN
 vtZUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-3.045, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

ÔÚ 2024/1/5 ÏÂÎç3:57, Tianrui Zhao Ð´µÀ:
> The linux headers in this patch synchronized from linux kernel
> v6.7.0-rc8, and the loongarch kvm part of this patch series
> based on the header files. And the linux kernel has added the
> loongarch kvm support in master branch.
>
> This series add loongarch kvm support, mainly implement
> some interfaces used by kvm, such as kvm_arch_get/set_regs,
> kvm_arch_handle_exit, kvm_loongarch_set_interrupt, etc.
>
> Currently, we are able to boot LoongArch KVM Linux Guests.
> In loongarch VM, mmio devices and iocsr devices are emulated
> in user space such as APIC, IPI, pci devices, etc, other
> hardwares such as MMU, timer and csr are emulated in kernel.
>
> The running environment of LoongArch virt machine:
> 1. Get the Linux KVM environment of LoongArch in Linux mainline.
>     make ARCH=loongarch CROSS_COMPILE=loongarch64-unknown-linux-gnu- loongson3_defconfig
>     make ARCH=loongarch CROSS_COMPILE=loongarch64-unknown-linux-gnu-
> 2. Get the qemu source: https://github.com/loongson/qemu
>     git checkout kvm-loongarch
>     ./configure --target-list="loongarch64-softmmu"  --enable-kvm
>     make
> 3. Get uefi bios of LoongArch virt machine:
>     Link: https://github.com/tianocore/edk2-platforms/tree/master/Platform/Loongson/LoongArchQemuPkg#readme
> 4. Also you can access the binary files we have already built:
>     https://github.com/yangxiaojuan-loongson/qemu-binary
>
> The command to boot loongarch virt machine:
>     $ qemu-system-loongarch64 -machine virt -m 4G -cpu la464 \
>     -smp 1 -bios QEMU_EFI.fd -kernel vmlinuz.efi -initrd ramdisk \
>     -serial stdio   -monitor telnet:localhost:4495,server,nowait \
>     -append "root=/dev/ram rdinit=/sbin/init console=ttyS0,115200" \
>     --nographic
>
> Changes for v4:
> 1. Synchronize linux headers from linux v6.7.0-rc8.
> 2. Move kvm.c and kvm_loongarch.h into target/loongarch/kvm/
>     directory.
> 3. Add "#ifndef CONFIG_USER_ONLY" before loongarch_cpu_do_interrupt
>     to fix compiling issue.
> 4. Remove "#ifdef CONFIG_TCG" before "#include "exec/cpu_ldst.h""
>     in fpu_helper.c, As it has been changed in other patches.
>
> Changes for v3:
> 1. Synchronize linux headers from linux v6.7.0-rc7.
> 2. Fix compiling error when config enable-kvm and disable-tcg
> at one time.
>
> Changes for v2:
> 1. Synchronize linux headers from linux v6.7.0-rc6.
> 2. Remove the stub function: kvm_loongarch_set_interrupt, as kvm_enabled
> 3. Move the kvm function such as kvm_arch_reset_vcpu from cpu.h to
> loongarch_kvm.h, and supplement "#include <cpu.h>" in loongarch_kvm.h.
>
> Changes for v1:
> 1. Synchronous KVM headers about LoongArch KVM form linux kernel,
> as the LoongArch KVM patch series have been accepted by linux kernel.
> 2. Remove the KVM_GET/SET_ONE_UREG64 macro in target/loongarch, and
> use the common interface kvm_get/set_one_reg to replace it.
> 3. Resolve the compiling errors when LoongArch is built by other archs.
>
> Tianrui Zhao (9):
>    linux-headers: Synchronize linux headers from linux v6.7.0-rc8
>    target/loongarch: Define some kvm_arch interfaces
>    target/loongarch: Supplement vcpu env initial when vcpu reset
>    target/loongarch: Implement kvm get/set registers
>    target/loongarch: Implement kvm_arch_init function
>    target/loongarch: Implement kvm_arch_init_vcpu
>    target/loongarch: Implement kvm_arch_handle_exit
>    target/loongarch: Implement set vcpu intr for kvm
>    target/loongarch: Add loongarch kvm into meson build
>
>   include/standard-headers/drm/drm_fourcc.h     |   2 +
>   include/standard-headers/linux/fuse.h         |  10 +-
>   include/standard-headers/linux/pci_regs.h     |  24 +-
>   include/standard-headers/linux/vhost_types.h  |   7 +
>   .../standard-headers/linux/virtio_config.h    |   5 +
>   include/standard-headers/linux/virtio_pci.h   |  11 +
>   linux-headers/asm-arm64/kvm.h                 |  32 +
>   linux-headers/asm-generic/unistd.h            |  14 +-
>   linux-headers/asm-loongarch/bitsperlong.h     |   1 +
>   linux-headers/asm-loongarch/kvm.h             | 108 +++
>   linux-headers/asm-loongarch/mman.h            |   1 +
>   linux-headers/asm-loongarch/unistd.h          |   5 +
>   linux-headers/asm-mips/unistd_n32.h           |   4 +
>   linux-headers/asm-mips/unistd_n64.h           |   4 +
>   linux-headers/asm-mips/unistd_o32.h           |   4 +
>   linux-headers/asm-powerpc/unistd_32.h         |   4 +
>   linux-headers/asm-powerpc/unistd_64.h         |   4 +
>   linux-headers/asm-riscv/kvm.h                 |  12 +
>   linux-headers/asm-s390/unistd_32.h            |   4 +
>   linux-headers/asm-s390/unistd_64.h            |   4 +
>   linux-headers/asm-x86/unistd_32.h             |   4 +
>   linux-headers/asm-x86/unistd_64.h             |   3 +
>   linux-headers/asm-x86/unistd_x32.h            |   3 +
>   linux-headers/linux/iommufd.h                 | 180 +++-
>   linux-headers/linux/kvm.h                     |  11 +
>   linux-headers/linux/psp-sev.h                 |   1 +
>   linux-headers/linux/stddef.h                  |   9 +-
>   linux-headers/linux/userfaultfd.h             |   9 +-
>   linux-headers/linux/vfio.h                    |  47 +-
>   linux-headers/linux/vhost.h                   |   8 +
>   meson.build                                   |   3 +
>   target/loongarch/cpu.c                        |  39 +-
>   target/loongarch/cpu.h                        |   5 +-
>   target/loongarch/internals.h                  |   5 +-
>   target/loongarch/kvm/kvm.c                    | 768 ++++++++++++++++++
>   target/loongarch/kvm/kvm_loongarch.h          |  16 +
>   target/loongarch/kvm/meson.build              |   1 +
>   target/loongarch/meson.build                  |   1 +
>   target/loongarch/trace-events                 |  15 +
>   target/loongarch/trace.h                      |   1 +
>   40 files changed, 1348 insertions(+), 41 deletions(-)
>   create mode 100644 linux-headers/asm-loongarch/bitsperlong.h
>   create mode 100644 linux-headers/asm-loongarch/kvm.h
>   create mode 100644 linux-headers/asm-loongarch/mman.h
>   create mode 100644 linux-headers/asm-loongarch/unistd.h
>   create mode 100644 target/loongarch/kvm/kvm.c
>   create mode 100644 target/loongarch/kvm/kvm_loongarch.h
>   create mode 100644 target/loongarch/kvm/meson.build
>   create mode 100644 target/loongarch/trace-events
>   create mode 100644 target/loongarch/trace.h
>
Applied to loongarch-next.

Thanks.
Song Gao


