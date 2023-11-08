Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C38567E4EAE
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 02:43:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0XZz-0008EB-5N; Tue, 07 Nov 2023 20:42:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1r0XZv-0008Bu-AZ
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 20:41:59 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1r0XZq-0005ob-VP
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 20:41:59 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxpPBV50plSOM3AA--.44548S3;
 Wed, 08 Nov 2023 09:41:41 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxS9xR50pl9qo7AA--.63823S2; 
 Wed, 08 Nov 2023 09:41:37 +0800 (CST)
From: xianglai li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, maobibo@loongson.cn, zhaotianrui@loongson.cn,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, richard.henderson@linaro.org, peter.maydell@linaro.org,
 yangxiaojuan@loongson.cn
Subject: [PATCH v1 0/9] Add loongarch kvm accel support
Date: Wed,  8 Nov 2023 09:41:32 +0800
Message-Id: <20231108014141.2590657-1-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxS9xR50pl9qo7AA--.63823S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
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

The LoongArch KVM patch series have been merged in Linux kernel,
so we remove the RFC flag in this patch series.

This series add loongarch kvm support, mainly implement
some interfaces used by kvm such as kvm_arch_get/set_regs,
kvm_arch_handle_exit, kvm_loongarch_set_interrupt, etc.

Currently, we are able to boot LoongArch KVM Linux Guests.
In loongarch VM, mmio devices and iocsr devices are emulated
in user space such as APIC, IPI, pci devices, etc, other
hardwares such as MMU, timer and csr are emulated in kernel.

The running environment of LoongArch virt machine:
1. Get the Linux KVM environment of LoongArch in Liunx mainline.
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

Changes for v1:
1. Synchronous KVM headers about LoongArch KVM form linux kernel,
as the LoongArch KVM patch series have been accepted by linux kernel. 
2. Remove the KVM_GET/SET_ONE_UREG64 macro in target/loongarch, and
use the common interface kvm_get/set_one_reg to replace it.
3. Resolve the compiling errors when LoongArch is built by other archs.

The previous RFC change log:
Changes for RFC v3:
1. Move the init mp_state to KVM_MP_STATE_RUNNABLE function into kvm.c.
2. Fix some unstandard code problems in kvm_get/set_regs_ioctl, such as
sort loongarch to keep alphabetic ordering in meson.build, gpr[0] should
be always 0, remove unnecessary inline statement, etc.
3. Rename the counter_value variable to kvm_state_counter in cpu_env,
and add comments for it to explain the meaning.

Changes for RFC v2:
1. Mark the "Add KVM headers for loongarch" patch as a placeholder,
as we will use the update-linux-headers.sh to generate the kvm headers
when the linux loongarch KVM patch series are accepted.
2. Remove the DPRINTF macro in kvm.c and use trace events to replace
it, we add some trace functions such as trace_kvm_handle_exit,
trace_kvm_set_intr, trace_kvm_failed_get_csr, etc.
3. Remove the unused functions in kvm_stub.c and move stub function into
the suitable patch.

Tianrui Zhao (8):
  target/loongarch: Define some kvm_arch interfaces
  target/loongarch: Supplement vcpu env initial when vcpu reset
  target/loongarch: Implement kvm get/set registers
  target/loongarch: Implement kvm_arch_init function
  target/loongarch: Implement kvm_arch_init_vcpu
  target/loongarch: Implement kvm_arch_handle_exit
  target/loongarch: Implement set vcpu intr for kvm
  target/loongarch: Add loongarch kvm into meson build

zhaotianrui (1):
  linux-headers: Add KVM headers for loongarch

 linux-headers/asm-loongarch/kvm.h | 108 +++++
 linux-headers/linux/kvm.h         |   9 +
 meson.build                       |   3 +
 target/loongarch/cpu.c            |  23 +-
 target/loongarch/cpu.h            |   6 +-
 target/loongarch/kvm-stub.c       |  13 +
 target/loongarch/kvm.c            | 768 ++++++++++++++++++++++++++++++
 target/loongarch/kvm_loongarch.h  |  13 +
 target/loongarch/meson.build      |   1 +
 target/loongarch/trace-events     |  15 +
 target/loongarch/trace.h          |   1 +
 11 files changed, 954 insertions(+), 6 deletions(-)
 create mode 100644 linux-headers/asm-loongarch/kvm.h
 create mode 100644 target/loongarch/kvm-stub.c
 create mode 100644 target/loongarch/kvm.c
 create mode 100644 target/loongarch/kvm_loongarch.h
 create mode 100644 target/loongarch/trace-events
 create mode 100644 target/loongarch/trace.h

-- 
2.39.1


