Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8343181F61A
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 09:54:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIm9T-0002zt-G3; Thu, 28 Dec 2023 03:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaotianrui@loongson.cn>)
 id 1rIm9N-0002yX-BJ
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 03:53:57 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhaotianrui@loongson.cn>) id 1rIm9K-0007A5-Fm
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 03:53:57 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxJ_CaN41lAAIAAA--.76S3;
 Thu, 28 Dec 2023 16:53:46 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxD+WYN41lQvENAA--.48131S2; 
 Thu, 28 Dec 2023 16:53:44 +0800 (CST)
From: Tianrui Zhao <zhaotianrui@loongson.cn>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, maobibo@loongson.cn, zhaotianrui@loongson.cn,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, richard.henderson@linaro.org, peter.maydell@linaro.org,
 yangxiaojuan@loongson.cn
Subject: [PATCH v3 0/9] Add loongarch kvm accel support
Date: Thu, 28 Dec 2023 16:40:42 +0800
Message-Id: <20231228084051.3235354-1-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxD+WYN41lQvENAA--.48131S2
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=zhaotianrui@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The linux headers in this patch synchronized from linux kernel
v6.7.0-rc7, and the loongarch kvm part of this patch series
based on the header files. And the linux kernel has added the
loongarch kvm support in master branch.

This series add loongarch kvm support, mainly implement
some interfaces used by kvm, such as kvm_arch_get/set_regs,
kvm_arch_handle_exit, kvm_loongarch_set_interrupt, etc.

Currently, we are able to boot LoongArch KVM Linux Guests.
In loongarch VM, mmio devices and iocsr devices are emulated
in user space such as APIC, IPI, pci devices, etc, other
hardwares such as MMU, timer and csr are emulated in kernel.

The running environment of LoongArch virt machine:
1. Get the Linux KVM environment of LoongArch in Linux mainline.
   make ARCH=loongarch CROSS_COMPILE=loongarch64-unknown-linux-gnu- loongson3_defconfig
   make ARCH=loongarch CROSS_COMPILE=loongarch64-unknown-linux-gnu-
2. Get the qemu source: https://github.com/loongson/qemu
   git checkout kvm-loongarch
   ./configure --target-list="loongarch64-softmmu"  --enable-kvm
   make
3. Get uefi bios of LoongArch virt machine:
   Link: https://github.com/tianocore/edk2-platforms/tree/master/Platform/Loongson/LoongArchQemuPkg#readme
4. Also you can access the binary files we have already built:
   https://github.com/yangxiaojuan-loongson/qemu-binary

The command to boot loongarch virt machine:
   $ qemu-system-loongarch64 -machine virt -m 4G -cpu la464 \
   -smp 1 -bios QEMU_EFI.fd -kernel vmlinuz.efi -initrd ramdisk \
   -serial stdio   -monitor telnet:localhost:4495,server,nowait \
   -append "root=/dev/ram rdinit=/sbin/init console=ttyS0,115200" \
   --nographic

Changes for v3:
1. Synchronize linux headers from linux v6.7.0-rc7.
2. Fix compiling error when config enable-kvm and disable-tcg
at one time.

Changes for v2:
1. Synchronize linux headers from linux v6.7.0-rc6.
2. Remove the stub function: kvm_loongarch_set_interrupt, as kvm_enabled
has been checked before it is called.
3. Move the kvm function such as kvm_arch_reset_vcpu from cpu.h to
loongarch_kvm.h, and supplement "#include <cpu.h>" in loongarch_kvm.h.

Changes for v1:
1. Synchronous KVM headers about LoongArch KVM form linux kernel,
as the LoongArch KVM patch series have been accepted by linux kernel.
2. Remove the KVM_GET/SET_ONE_UREG64 macro in target/loongarch, and
use the common interface kvm_get/set_one_reg to replace it.
3. Resolve the compiling errors when LoongArch is built by other archs.

Tianrui Zhao (9):
  linux-headers: Synchronize linux headers from linux v6.7.0-rc7
  target/loongarch: Define some kvm_arch interfaces
  target/loongarch: Supplement vcpu env initial when vcpu reset
  target/loongarch: Implement kvm get/set registers
  target/loongarch: Implement kvm_arch_init function
  target/loongarch: Implement kvm_arch_init_vcpu
  target/loongarch: Implement kvm_arch_handle_exit
  target/loongarch: Implement set vcpu intr for kvm
  target/loongarch: Add loongarch kvm into meson build

 include/standard-headers/drm/drm_fourcc.h     |   2 +
 include/standard-headers/linux/fuse.h         |  10 +-
 include/standard-headers/linux/pci_regs.h     |  24 +-
 include/standard-headers/linux/vhost_types.h  |   7 +
 .../standard-headers/linux/virtio_config.h    |   5 +
 include/standard-headers/linux/virtio_pci.h   |  11 +
 linux-headers/asm-arm64/kvm.h                 |  32 +
 linux-headers/asm-generic/unistd.h            |  14 +-
 linux-headers/asm-loongarch/bitsperlong.h     |   1 +
 linux-headers/asm-loongarch/kvm.h             | 108 +++
 linux-headers/asm-loongarch/mman.h            |   1 +
 linux-headers/asm-loongarch/unistd.h          |   5 +
 linux-headers/asm-mips/unistd_n32.h           |   4 +
 linux-headers/asm-mips/unistd_n64.h           |   4 +
 linux-headers/asm-mips/unistd_o32.h           |   4 +
 linux-headers/asm-powerpc/unistd_32.h         |   4 +
 linux-headers/asm-powerpc/unistd_64.h         |   4 +
 linux-headers/asm-riscv/kvm.h                 |  12 +
 linux-headers/asm-s390/unistd_32.h            |   4 +
 linux-headers/asm-s390/unistd_64.h            |   4 +
 linux-headers/asm-x86/unistd_32.h             |   4 +
 linux-headers/asm-x86/unistd_64.h             |   3 +
 linux-headers/asm-x86/unistd_x32.h            |   3 +
 linux-headers/linux/iommufd.h                 | 180 +++-
 linux-headers/linux/kvm.h                     |  11 +
 linux-headers/linux/psp-sev.h                 |   1 +
 linux-headers/linux/stddef.h                  |   9 +-
 linux-headers/linux/userfaultfd.h             |   9 +-
 linux-headers/linux/vfio.h                    |  47 +-
 linux-headers/linux/vhost.h                   |   8 +
 meson.build                                   |   3 +
 target/loongarch/cpu.c                        |  37 +-
 target/loongarch/cpu.h                        |   5 +-
 target/loongarch/fpu_helper.c                 |   2 +
 target/loongarch/internals.h                  |   5 +-
 target/loongarch/kvm.c                        | 768 ++++++++++++++++++
 target/loongarch/kvm_loongarch.h              |  16 +
 target/loongarch/meson.build                  |   9 +-
 target/loongarch/trace-events                 |  15 +
 target/loongarch/trace.h                      |   1 +
 40 files changed, 1350 insertions(+), 46 deletions(-)
 create mode 100644 linux-headers/asm-loongarch/bitsperlong.h
 create mode 100644 linux-headers/asm-loongarch/kvm.h
 create mode 100644 linux-headers/asm-loongarch/mman.h
 create mode 100644 linux-headers/asm-loongarch/unistd.h
 create mode 100644 target/loongarch/kvm.c
 create mode 100644 target/loongarch/kvm_loongarch.h
 create mode 100644 target/loongarch/trace-events
 create mode 100644 target/loongarch/trace.h

-- 
2.39.1


