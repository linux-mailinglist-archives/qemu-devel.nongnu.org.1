Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ABB82957A
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 09:59:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUPO-0001Kl-BQ; Wed, 10 Jan 2024 03:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPK-0001KD-M5
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:57:54 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPB-0003Na-2N
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:57:48 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3bbd6e3795eso3323936b6e.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877063; x=1705481863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vBelU8jCUh9cQ9ENgZWx/KbpAFMr9lO9AQi8G9EtZ1Y=;
 b=Ef/q2F77ZI0zllLo6pAAA8UZpNAc8Wq2FNASLx+mW0rWT4nWmHsgKEydnbQAORq4C4
 tYxxVl2bRhOX4Jx0TkLP6HtUHz/x9yAgrmpac3EA7ks45WL9oY8COJboahZWCoYYd83N
 wsqBqVx5qrUwx6MP9Rh89rtwE63qTTbkCEMgW65/7VGD5BionWI26OJnTq8ZfOA5fvKO
 pc1DFuTrUvP3VK4NlwN0voIWJPk1vn48vNdpxg3zDygRpIrM3Qr0aL9w0dGWKde2nA5A
 F4mlKB9x2SehgOR90tYHINFoydu20M2ObU1XL1WKxvzSU5eYMANRVh3JaVAmytyvqZlF
 1roA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877063; x=1705481863;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vBelU8jCUh9cQ9ENgZWx/KbpAFMr9lO9AQi8G9EtZ1Y=;
 b=BwQM2tHih9uXiGNOLs6OG0ZQmTZkOoCawW0LIoBCoHcCdnEUOdU9uM+Yb9/L6oQIrY
 IcTMiIBXWJ/VisqXjCF3G0B8PMefeLVCu1E3yo6/g90LB3ZwVuo40Cik0WcVBMYRl1tJ
 fPgBjdp/dYWlsd+UJRzDAHD2d7qD7hqwHyX9uO0WazTLZcJ04KbtMD/aGmTQ3US2viwI
 tcTrFqCvup/HIZa59qFFXvchjSc+Xw8xCPBFFPUQTYdmpZcdKr6IIQ4UuzDFxa7GiSpc
 tbRECIMDny52SPdyZASK8hJjJDb4P4AEq8QM3QOeX/fvZl17LtaCYzcZD8YkpDy87tYo
 UzUA==
X-Gm-Message-State: AOJu0Yx5cc+xw9EPRlhcUoA2Hi7B4fFOVbEWh2mT2vCf5JprRQ0sO0ZA
 VQRlmxGp90ZgZLTaQpNgLMYlXiQ2CM1cerQZ
X-Google-Smtp-Source: AGHT+IGhp6Q/e5nWGkV5GM69GAkH0OKs7TgllCAtFnjxBdC5/nQ7em6CJcukLOSFLpYw8a96IMt5zg==
X-Received: by 2002:a05:6808:17a9:b0:3bd:3b39:c400 with SMTP id
 bg41-20020a05680817a900b003bd3b39c400mr853117oib.48.1704877063211; 
 Wed, 10 Jan 2024 00:57:43 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:57:42 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/65] riscv-to-apply queue
Date: Wed, 10 Jan 2024 18:56:28 +1000
Message-ID: <20240110085733.1607526-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit 9468484fe904ab4691de6d9c34616667f377ceac:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2024-01-09 10:32:23 +0000)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240110

for you to fetch changes up to 71b76da33a1558bcd59100188f5753737ef6fa21:

  target/riscv: Ensure mideleg is set correctly on reset (2024-01-10 18:47:47 +1000)

----------------------------------------------------------------
RISC-V PR for 9.0

* Make vector whole-register move (vmv) depend on vtype register
* Fix th.dcache.cval1 priviledge check
* Don't allow write mstatus_vs without RVV
* Use hwaddr instead of target_ulong for RV32
* Fix machine IDs QOM getters\
* Fix KVM reg id sizes
* ACPI: Enable AIA, PLIC and update RHCT
* Fix the interrupts-extended property format of PLIC
* Add support for Zacas extension
* Add amocas.[w,d,q] instructions
* Document acpi parameter of virt machine
* RVA22 profiles support
* Remove group setting of KVM AIA if the machine only has 1 socket
* Add RVV CSRs to KVM
* sifive_u: Update S-mode U-Boot image build instructions
* Upgrade OpenSBI from v1.3.1 to v1.4
* pmp: Ignore writes when RW=01 and MML=0
* Assert that the CSR numbers will be correct
* Don't adjust vscause for exceptions
* Ensure mideleg is set correctly on reset

----------------------------------------------------------------
Alistair Francis (3):
      target/riscv: Assert that the CSR numbers will be correct
      target/riscv: Don't adjust vscause for exceptions
      target/riscv: Ensure mideleg is set correctly on reset

Bin Meng (2):
      docs/system/riscv: sifive_u: Update S-mode U-Boot image build instructions
      roms/opensbi: Upgrade from v1.3.1 to v1.4

Daniel Henrique Barboza (36):
      target/riscv/cpu.c: fix machine IDs getters
      target/riscv/kvm: change KVM_REG_RISCV_FP_F to u32
      target/riscv/kvm: change KVM_REG_RISCV_FP_D to u64
      target/riscv/kvm: change timer regs size to u64
      target/riscv/kvm: add RISCV_CONFIG_REG()
      target/riscv/kvm: rename riscv_reg_id() to riscv_reg_id_ulong()
      target/riscv: create TYPE_RISCV_VENDOR_CPU
      target/riscv/tcg: do not use "!generic" CPU checks
      target/riscv/tcg: update priv_ver on user_set extensions
      target/riscv: add rv64i CPU
      target/riscv: add zicbop extension flag
      target/riscv/tcg: add 'zic64b' support
      riscv-qmp-cmds.c: expose named features in cpu_model_expansion
      target/riscv: add rva22u64 profile definition
      target/riscv/kvm: add 'rva22u64' flag as unavailable
      target/riscv/tcg: add user flag for profile support
      target/riscv/tcg: add MISA user options hash
      target/riscv/tcg: add riscv_cpu_write_misa_bit()
      target/riscv/tcg: handle profile MISA bits
      target/riscv/tcg: add hash table insert helpers
      target/riscv/tcg: honor user choice for G MISA bits
      target/riscv/tcg: validate profiles during finalize
      riscv-qmp-cmds.c: add profile flags in cpu-model-expansion
      target/riscv: add 'rva22u64' CPU
      target/riscv: implement svade
      target/riscv: add priv ver restriction to profiles
      target/riscv/cpu.c: finalize satp_mode earlier
      target/riscv/cpu.c: add riscv_cpu_is_32bit()
      target/riscv: add satp_mode profile support
      target/riscv: add 'parent' in profile description
      target/riscv: add RVA22S64 profile
      target/riscv: add rva22s64 cpu
      linux-headers: Update to Linux v6.7-rc5
      linux-headers: riscv: add ptrace.h
      target/riscv/kvm: do PR_RISCV_V_SET_CONTROL during realize()
      target/riscv/kvm: add RVV and Vector CSR regs

Heinrich Schuchardt (1):
      docs/system/riscv: document acpi parameter of virt machine

Ivan Klokov (2):
      target/riscv/pmp: Use hwaddr instead of target_ulong for RV32
      target/riscv: pmp: Ignore writes when RW=01 and MML=0

LIU Zhiwei (2):
      target/riscv: Fix th.dcache.cval1 priviledge check
      target/riscv: Not allow write mstatus_vs without RVV

Max Chou (2):
      target/riscv: Add vill check for whole vector register move instructions
      target/riscv: The whole vector register move instructions depend on vsew

Rob Bradford (1):
      disas/riscv: Add amocas.[w,d,q] instructions

Sunil V L (13):
      hw/arm/virt-acpi-build.c: Migrate fw_cfg creation to common location
      hw/arm/virt-acpi-build.c: Migrate virtio creation to common location
      hw/i386/acpi-microvm.c: Use common function to add virtio in DSDT
      hw/riscv: virt: Make few IMSIC macros and functions public
      hw/riscv/virt-acpi-build.c: Add AIA support in RINTC
      hw/riscv/virt-acpi-build.c: Add IMSIC in the MADT
      hw/riscv/virt-acpi-build.c: Add APLIC in the MADT
      hw/riscv/virt-acpi-build.c: Add CMO information in RHCT
      hw/riscv/virt-acpi-build.c: Add MMU node in RHCT
      hw/pci-host/gpex: Define properties for MMIO ranges
      hw/riscv/virt: Update GPEX MMIO related properties
      hw/riscv/virt-acpi-build.c: Add IO controllers and devices
      hw/riscv/virt-acpi-build.c: Add PLIC in MADT

Weiwei Li (1):
      target/riscv: Add support for Zacas extension

Yong-Xuan Wang (2):
      hw/riscv/virt.c: fix the interrupts-extended property format of PLIC
      target/riscv/kvm.c: remove group setting of KVM AIA if the machine only has 1 socket

 docs/system/riscv/sifive_u.rst                 |  33 +-
 docs/system/riscv/virt.rst                     |   5 +
 include/hw/nvram/fw_cfg_acpi.h                 |  15 +
 include/hw/pci-host/gpex.h                     |  28 +-
 include/hw/riscv/virt.h                        |  26 ++
 include/hw/virtio/virtio-acpi.h                |  16 +
 include/standard-headers/drm/drm_fourcc.h      |   2 +
 include/standard-headers/linux/pci_regs.h      |  24 +-
 include/standard-headers/linux/vhost_types.h   |   7 +
 include/standard-headers/linux/virtio_config.h |   5 +
 include/standard-headers/linux/virtio_pci.h    |  11 +
 linux-headers/asm-arm64/kvm.h                  |  32 ++
 linux-headers/asm-generic/unistd.h             |  14 +-
 linux-headers/asm-loongarch/bitsperlong.h      |   1 +
 linux-headers/asm-loongarch/kvm.h              | 108 ++++++
 linux-headers/asm-loongarch/mman.h             |   1 +
 linux-headers/asm-loongarch/unistd.h           |   5 +
 linux-headers/asm-mips/unistd_n32.h            |   4 +
 linux-headers/asm-mips/unistd_n64.h            |   4 +
 linux-headers/asm-mips/unistd_o32.h            |   4 +
 linux-headers/asm-powerpc/unistd_32.h          |   4 +
 linux-headers/asm-powerpc/unistd_64.h          |   4 +
 linux-headers/asm-riscv/kvm.h                  |  12 +
 linux-headers/asm-riscv/ptrace.h               | 132 +++++++
 linux-headers/asm-s390/unistd_32.h             |   4 +
 linux-headers/asm-s390/unistd_64.h             |   4 +
 linux-headers/asm-x86/unistd_32.h              |   4 +
 linux-headers/asm-x86/unistd_64.h              |   3 +
 linux-headers/asm-x86/unistd_x32.h             |   3 +
 linux-headers/linux/iommufd.h                  | 180 +++++++++-
 linux-headers/linux/kvm.h                      |  11 +
 linux-headers/linux/psp-sev.h                  |   1 +
 linux-headers/linux/stddef.h                   |   9 +-
 linux-headers/linux/userfaultfd.h              |   9 +-
 linux-headers/linux/vfio.h                     |  47 ++-
 linux-headers/linux/vhost.h                    |   8 +
 target/riscv/cpu-qom.h                         |   5 +
 target/riscv/cpu.h                             |  18 +
 target/riscv/cpu_cfg.h                         |   5 +
 target/riscv/pmp.h                             |   8 +-
 target/riscv/insn32.decode                     |   6 +
 disas/riscv.c                                  |   9 +
 hw/arm/virt-acpi-build.c                       |  51 +--
 hw/i386/acpi-microvm.c                         |  15 +-
 hw/nvram/fw_cfg-acpi.c                         |  23 ++
 hw/pci-host/gpex-acpi.c                        |  13 +
 hw/pci-host/gpex.c                             |  12 +
 hw/riscv/virt-acpi-build.c                     | 323 ++++++++++++++++--
 hw/riscv/virt.c                                | 124 +++----
 hw/virtio/virtio-acpi.c                        |  33 ++
 target/riscv/cpu.c                             | 223 ++++++++++--
 target/riscv/cpu_helper.c                      |   4 +-
 target/riscv/csr.c                             |  10 +-
 target/riscv/kvm/kvm-cpu.c                     | 250 ++++++++++----
 target/riscv/pmp.c                             |  28 +-
 target/riscv/riscv-qmp-cmds.c                  |  44 ++-
 target/riscv/tcg/tcg-cpu.c                     | 455 ++++++++++++++++++++++---
 target/riscv/translate.c                       |   1 +
 target/riscv/insn_trans/trans_rvv.c.inc        |   8 +-
 target/riscv/insn_trans/trans_rvzacas.c.inc    | 150 ++++++++
 target/riscv/insn_trans/trans_xthead.c.inc     |   2 +-
 hw/nvram/meson.build                           |   1 +
 hw/riscv/Kconfig                               |   1 +
 hw/virtio/meson.build                          |   1 +
 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin | Bin 135376 -> 267416 bytes
 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin | Bin 138368 -> 270808 bytes
 roms/opensbi                                   |   2 +-
 scripts/update-linux-headers.sh                |   3 +
 68 files changed, 2248 insertions(+), 360 deletions(-)
 create mode 100644 include/hw/nvram/fw_cfg_acpi.h
 create mode 100644 include/hw/virtio/virtio-acpi.h
 create mode 100644 linux-headers/asm-loongarch/bitsperlong.h
 create mode 100644 linux-headers/asm-loongarch/kvm.h
 create mode 100644 linux-headers/asm-loongarch/mman.h
 create mode 100644 linux-headers/asm-loongarch/unistd.h
 create mode 100644 linux-headers/asm-riscv/ptrace.h
 create mode 100644 hw/nvram/fw_cfg-acpi.c
 create mode 100644 hw/virtio/virtio-acpi.c
 create mode 100644 target/riscv/insn_trans/trans_rvzacas.c.inc

