Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F2774D580
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:32:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq42-0007dp-JP; Mon, 10 Jul 2023 08:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq40-0007db-OO
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:32:24 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq3x-0002VS-B6
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:32:24 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6687096c6ddso2297467b3a.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992339; x=1691584339;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TdtHsOJcF+D5xyXCqcabhwjiyRghNgTmTzEoYZIpTpc=;
 b=f776sEXGnaim/OusM4SIBCHxKQFaB1CDA2KHHH5OPmUYHf4ZG1GDI7CAlei+VfUgiQ
 OZQ5IDIPYgLGyr6AlbLe2OGr/4qu+zOFZngBTjEAeA3xxi8UDMER+6y6v3QmSvq2tUFm
 UXWCXzwgM0NousRYN3SV+VWdARl6617ioC6m8LPZk1v0KFzZts6qladi6sE/MP309DOb
 vEypQDOing/FPEHRMxlh+1D9BbnjduE+Elqx6l+aTE1Jl+9MBei6gUNIkA5jQSbem9ou
 MRxjNYzZwSNU6/kH8/JGq1y+EZ8nAA+14IIdmBr6dyKnD/UWHEYFAEzqlJvzE1eupHSP
 80fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992339; x=1691584339;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TdtHsOJcF+D5xyXCqcabhwjiyRghNgTmTzEoYZIpTpc=;
 b=kbM62vQQ/BnRHwpCSFvKdYn+o0OlEZrL4mO/MOBJn3ESX25poc/EaRIcappuWw1K9a
 QM0rOJwwNppg/UIgNGsoM+wfjlLR1QrYUjnlqt7/GIYSde5yeMdZe9MHK2waKzgRZE09
 G7RFnoD+dKh/cMzJUtG5JidXstqiTM3rtQ2MT2m8TVVpnDl2qUwy5Sl9NkBNtEQl4poa
 TJa3ktz8u4yKa48waDUwWwJuRixe58grhvJxRn6Et4x8iBLc4+cx8e2oko8slQe2dEP9
 IZ/luSOar7RA5Wc0uGBQ8FnEIGVqj67B/FvvOPYEZHYkpT+0qUaHfJahvi5XqZixuOda
 neKA==
X-Gm-Message-State: ABy/qLbXW2+b+D2qtkw/R0P8zQ8VuUBR+pi+4+KFuKuiLe/CMB1mKeBN
 JKyNHP4U3tPoM5Faohcje8A0eog3rcJnIg==
X-Google-Smtp-Source: APBJJlHHTxABWd9j7pqZmGllP1BiMJ6f3lQ/8wAVN8GOKVUHq5xmIphp4GFbt0UlMgQk9fKcinE5WQ==
X-Received: by 2002:a05:6a00:2e04:b0:682:140c:245b with SMTP id
 fc4-20020a056a002e0400b00682140c245bmr12310016pfb.5.1688992339489; 
 Mon, 10 Jul 2023 05:32:19 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:32:18 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/54] riscv-to-apply queue
Date: Mon, 10 Jul 2023 22:31:11 +1000
Message-Id: <20230710123205.2441106-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
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

The following changes since commit fcb237e64f9d026c03d635579c7b288d0008a6e5:

  Merge tag 'pull-vfio-20230710' of https://github.com/legoater/qemu into staging (2023-07-10 09:17:06 +0100)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20230710-1

for you to fetch changes up to a47842d16653b4f73b5d56ff0c252dd8a329481b:

  riscv: Add support for the Zfa extension (2023-07-10 22:29:20 +1000)

----------------------------------------------------------------
Third RISC-V PR for 8.1

* Use xl instead of mxl for disassemble
* Factor out extension tests to cpu_cfg.h
* disas/riscv: Add vendor extension support
* disas/riscv: Add support for XVentanaCondOps
* disas/riscv: Add support for XThead* instructions
* Fix mstatus related problems
* Fix veyron-v1 CPU properties
* Fix the xlen for data address when MPRV=1
* opensbi: Upgrade from v1.2 to v1.3
* Enable 32-bit Spike OpenSBI boot testing
* Support the watchdog timer of HiFive 1 rev b
* Only build qemu-system-riscv$$ on rv$$ host
* Add RVV registers to log
* Restrict ACLINT to TCG
* Add syscall riscv_hwprobe
* Add support for BF16 extensions
* KVM_RISCV_SET_TIMER macro is not configured correctly
* Generate devicetree only after machine initialization is complete
* virt: Convert fdt_load_addr to uint64_t
* KVM: fixes and enhancements
* Add support for the Zfa extension

----------------------------------------------------------------
Bin Meng (2):
      roms/opensbi: Upgrade from v1.2 to v1.3
      tests/avocado: riscv: Enable 32-bit Spike OpenSBI boot testing

Christoph Müllner (8):
      target/riscv: Factor out extension tests to cpu_cfg.h
      disas/riscv: Move types/constants to new header file
      disas/riscv: Make rv_op_illegal a shared enum value
      disas/riscv: Encapsulate opcode_data into decode
      disas/riscv: Provide infrastructure for vendor extensions
      disas/riscv: Add support for XVentanaCondOps
      disas/riscv: Add support for XThead* instructions
      riscv: Add support for the Zfa extension

Daniel Henrique Barboza (20):
      target/riscv/cpu.c: fix veyron-v1 CPU properties
      target/riscv: skip features setup for KVM CPUs
      hw/riscv/virt.c: skip 'mmu-type' FDT if satp mode not set
      target/riscv/cpu.c: restrict 'mvendorid' value
      target/riscv/cpu.c: restrict 'mimpid' value
      target/riscv/cpu.c: restrict 'marchid' value
      target/riscv: use KVM scratch CPUs to init KVM properties
      target/riscv: read marchid/mimpid in kvm_riscv_init_machine_ids()
      target/riscv: handle mvendorid/marchid/mimpid for KVM CPUs
      target/riscv/kvm.c: init 'misa_ext_mask' with scratch CPU
      target/riscv/cpu: add misa_ext_info_arr[]
      target/riscv: add KVM specific MISA properties
      target/riscv/kvm.c: update KVM MISA bits
      target/riscv/kvm.c: add multi-letter extension KVM properties
      target/riscv/cpu.c: add satp_mode properties earlier
      target/riscv/cpu.c: remove priv_ver check from riscv_isa_string_ext()
      target/riscv/cpu.c: create KVM mock properties
      target/riscv: update multi-letter extension KVM properties
      target/riscv/kvm.c: add kvmconfig_get_cfg_addr() helper
      target/riscv/kvm.c: read/write (cbom|cboz)_blocksize in KVM

Guenter Roeck (1):
      riscv: Generate devicetree only after machine initialization is complete

Ivan Klokov (1):
      target/riscv: Add RVV registers to log

Jason Chien (1):
      target/riscv: Set the correct exception for implict G-stage translation fail

LIU Zhiwei (1):
      target/riscv: Use xl instead of mxl for disassemble

Lakshmi Bai Raja Subramanian (1):
      hw/riscv: virt: Convert fdt_load_addr to uint64_t

Philippe Mathieu-Daudé (3):
      target/riscv: Only unify 'riscv32/64' -> 'riscv' for host cpu in meson
      target/riscv: Only build KVM guest with same wordsize as host
      hw/riscv/virt: Restrict ACLINT to TCG

Robbin Ehn (1):
      linux-user/riscv: Add syscall riscv_hwprobe

Tommy Wu (3):
      hw/misc: sifive_e_aon: Support the watchdog timer of HiFive 1 rev b.
      hw/riscv: sifive_e: Support the watchdog timer of HiFive 1 rev b.
      tests/qtest: sifive-e-aon-watchdog-test.c: Add QTest of watchdog of sifive_e

Weiwei Li (11):
      target/riscv: Make MPV only work when MPP != PRV_M
      target/riscv: Support MSTATUS.MPV/GVA only when RVH is enabled
      target/riscv: Remove redundant assignment to SXL
      target/riscv: Add additional xlen for address when MPRV=1
      target/riscv: update cur_pmbase/pmmask based on mode affected by MPRV
      target/riscv: Add properties for BF16 extensions
      target/riscv: Add support for Zfbfmin extension
      target/riscv: Add support for Zvfbfmin extension
      target/riscv: Add support for Zvfbfwma extension
      target/riscv: Expose properties for BF16 extensions
      target/riscv: Add disas support for BF16 extensions

yang.zhang (1):
      target/riscv KVM_RISCV_SET_TIMER macro is not configured correctly

 docs/system/riscv/virt.rst                     |   1 +
 meson.build                                    |  15 +-
 disas/riscv-xthead.h                           |  28 +
 disas/riscv-xventana.h                         |  18 +
 disas/riscv.h                                  | 302 +++++++++++
 include/hw/misc/sifive_e_aon.h                 |  60 +++
 include/hw/riscv/sifive_e.h                    |   9 +-
 linux-user/riscv/syscall32_nr.h                |   1 +
 linux-user/riscv/syscall64_nr.h                |   1 +
 target/riscv/cpu.h                             |  56 +-
 target/riscv/cpu_cfg.h                         |  41 ++
 target/riscv/helper.h                          |  29 +
 target/riscv/kvm_riscv.h                       |   1 +
 target/riscv/insn32.decode                     |  38 ++
 disas/riscv-xthead.c                           | 707 +++++++++++++++++++++++++
 disas/riscv-xventana.c                         |  41 ++
 disas/riscv.c                                  | 559 +++++++++----------
 hw/misc/sifive_e_aon.c                         | 319 +++++++++++
 hw/riscv/sifive_e.c                            |  17 +-
 hw/riscv/virt.c                                |  56 +-
 linux-user/syscall.c                           | 146 +++++
 target/riscv/cpu.c                             | 439 +++++++++++++--
 target/riscv/cpu_helper.c                      |  12 +-
 target/riscv/csr.c                             |  41 +-
 target/riscv/fpu_helper.c                      | 166 ++++++
 target/riscv/kvm.c                             | 501 +++++++++++++++++-
 target/riscv/op_helper.c                       |   3 +-
 target/riscv/translate.c                       |  42 +-
 target/riscv/vector_helper.c                   |  17 +
 tests/qtest/sifive-e-aon-watchdog-test.c       | 450 ++++++++++++++++
 tests/tcg/riscv64/test-fcvtmod.c               | 345 ++++++++++++
 target/riscv/insn_trans/trans_rvbf16.c.inc     | 175 ++++++
 target/riscv/insn_trans/trans_rvzfa.c.inc      | 521 ++++++++++++++++++
 target/riscv/insn_trans/trans_rvzfh.c.inc      |  12 +-
 disas/meson.build                              |   6 +-
 hw/misc/Kconfig                                |   3 +
 hw/misc/meson.build                            |   1 +
 hw/riscv/Kconfig                               |   1 +
 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin | Bin 123072 -> 135344 bytes
 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin | Bin 121800 -> 138304 bytes
 roms/opensbi                                   |   2 +-
 tests/avocado/riscv_opensbi.py                 |   2 -
 tests/qtest/meson.build                        |   3 +
 tests/tcg/riscv64/Makefile.target              |   6 +
 44 files changed, 4751 insertions(+), 442 deletions(-)
 create mode 100644 disas/riscv-xthead.h
 create mode 100644 disas/riscv-xventana.h
 create mode 100644 disas/riscv.h
 create mode 100644 include/hw/misc/sifive_e_aon.h
 create mode 100644 disas/riscv-xthead.c
 create mode 100644 disas/riscv-xventana.c
 create mode 100644 hw/misc/sifive_e_aon.c
 create mode 100644 tests/qtest/sifive-e-aon-watchdog-test.c
 create mode 100644 tests/tcg/riscv64/test-fcvtmod.c
 create mode 100644 target/riscv/insn_trans/trans_rvbf16.c.inc
 create mode 100644 target/riscv/insn_trans/trans_rvzfa.c.inc

