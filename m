Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A85E7DC517
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 05:02:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxfvq-0001KE-Uc; Tue, 31 Oct 2023 00:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxfvY-0001Jp-Dj
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 00:00:28 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxfvW-0005BT-5x
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 00:00:28 -0400
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-1cc3542e328so15604545ad.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 21:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698724824; x=1699329624;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a/9aowT69FfdZz93lnnXZAO7y3W05g4DntSJzvKxMeI=;
 b=Glz+TnatnKtC9OswbIYdSXKPSddTitOUoRhbyMswkWnMlw9aon50ww4yEquIR5MaKn
 3lCzkqpAB96ZkYW5+MiZd0l74Vbxti6dGSp9Gv7/ULEpGMMd195VhGDHjxHLjaYDVvrI
 r7qWV2W8Yg1i7Ak+2DjKsyGuNnL4TczgLreW9egD3bZnPxFWZbQAobeGqjgbw17nPf6X
 nrafaKQ8LuiUGIf3kmniYVQ9Z+rchKmROkF+jK22FaCKxxLBdB7XglDOZEfecXaPYQj6
 sHBaHKc8gizmDAbgMw9b2wyniM27trT6CAR/GnpKDdvoCZkjxOlnFKor1KSUIO2i/3DC
 IU3A==
X-Gm-Message-State: AOJu0Ywu9s2+lNQT0CzLbC3yWnwweZT3O22wjpTT4NSRLyEtWuMP0QFz
 oEM02pXnnk2uuDiz7I49xIfrAfPW1OI=
X-Google-Smtp-Source: AGHT+IFhSn0PB87faXYqlna5O8EjmmMcVIMPHWiZcbjZZv+E5l2qYgaZPjsQZRwbAH+bOVwwdaWVhA==
X-Received: by 2002:a17:903:2905:b0:1cc:32b7:e5b9 with SMTP id
 lh5-20020a170903290500b001cc32b7e5b9mr4409623plb.67.1698724824058; 
 Mon, 30 Oct 2023 21:00:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:642:4c02:7b37:49a8:6e6e:cee6:cee7])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a170902f54400b001bbfa86ca3bsm257975plf.78.2023.10.30.21.00.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Oct 2023 21:00:23 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/14] tpm: introduce TPM CRB SysBus device
Date: Mon, 30 Oct 2023 21:00:03 -0700
Message-ID: <20231031040021.65582-1-j@getutm.app>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.173; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f173.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The impetus for this patch set is to get TPM 2.0 working on Windows 11 ARM64.
Windows' tpm.sys does not seem to work on a TPM TIS device (as verified with
VMWare's implementation). However, the current TPM CRB device uses a fixed
system bus address that is reserved for RAM in ARM64 Virt machines.

In the process of adding the TPM CRB SysBus device, we also went ahead and
cleaned up some of the existing TPM hardware code and fixed some bugs. We used
the TPM TIS devices as a template for the TPM CRB devices and refactored out
common code. We moved the ACPI DSDT generation to the device in order to handle
dynamic base address requirements as well as reduce redundent code in different
machine ACPI generation. We also changed the tpm_crb device to use the ISA bus
instead of depending on the default system bus as the device only was built for
the PC configuration.

Another change is that the TPM CRB registers are now mapped in the same way that
the pflash ROM devices are mapped. It is a memory region whose writes are
trapped as MMIO accesses. This was needed because Apple Silicon does not decode
LDP (AARCH64 load pair of registers) caused page faults. @agraf suggested that
we do this to avoid having to do AARCH64 decoding in the HVF backend's fault
handler.

Unfortunately, it seems like the LDP fault still happens on HVF but the issue
seems to be in the HVF backend which needs to be fixed in a separate patch.

One last thing that's needed to get Windows 11 to recognize the TPM 2.0 device
is for the OVMF firmware to setup the TPM device. Currently, OVMF for ARM64 Virt
only recognizes the TPM TIS device through a FDT entry. A workaround is to
falsely identify the TPM CRB device as a TPM TIS device in the FDT node but this
causes issues for Linux. A proper fix would involve adding an ACPI device driver
in OVMF.

This has been tested on ARM64 with `tpm-crb-device` and on x86_64 with
`tpm-crb`. Additional testing should be performed on other architectures (RISCV
and Loongarch for example) as well as migration cases.

v4:
- Fixed broken test blobs

v3:
- Support backwards and forwards migration of existing tpm-crb device
- Dropped patch which moved tpm-crb to ISA bus due to migration concerns
- Unified `tpm_sysbus_plug` handler for ARM and Loongarch
- Added ACPI table tests for tpm-crb-device
- Refactored TPM CRB tests to run on tpm-crb-device for ARM Virt

v2:
- Fixed an issue where VMstate restore from an older version failed due to name
  collision of the memory block.
- In the ACPI table generation for CRB devices, the check for TPM 2.0 backend is
  moved to the device realize as CRB does not support TPM 1.0. It will error in
  that case.
- Dropped the patch to fix crash when PPI is enabled on TIS SysBus device since
  a separate patch submitted by Stefan Berger disables such an option.
- Fixed an issue where we default tpmEstablished=0 when it should be 1.
- In TPM CRB SysBus's ACPI entry, we accidently changed _UID from 0 to 1. This
  shouldn't be an issue but we changed it back just in case.
- Added a patch to migrate saved VMstate from an older version with the regs
  saved separately instead of as a RAM block.

Joelle van Dyne (14):
  tpm_crb: refactor common code
  tpm_crb: CTRL_RSP_ADDR is 64-bits wide
  tpm_ppi: refactor memory space initialization
  tpm_crb: use a single read-as-mem/write-as-mmio mapping
  tpm_crb: move ACPI table building to device interface
  tpm-sysbus: add plug handler for TPM on SysBus
  hw/arm/virt: connect TPM to platform bus
  hw/loongarch/virt: connect TPM to platform bus
  tpm_tis_sysbus: move DSDT AML generation to device
  tests: acpi: prepare for TPM CRB tests
  tpm_crb_sysbus: introduce TPM CRB SysBus device
  tests: acpi: implement TPM CRB tests for ARM virt
  tests: acpi: updated expected blobs for TPM CRB
  tests: add TPM-CRB sysbus tests for aarch64

 docs/specs/tpm.rst                        |   2 +
 hw/tpm/tpm_crb.h                          |  79 ++++++
 hw/tpm/tpm_ppi.h                          |  10 +-
 include/hw/acpi/tpm.h                     |   3 +-
 include/sysemu/tpm.h                      |   7 +
 tests/qtest/tpm-tests.h                   |   2 +
 tests/qtest/tpm-util.h                    |   4 +-
 hw/acpi/aml-build.c                       |   7 +-
 hw/arm/virt-acpi-build.c                  |  38 +--
 hw/arm/virt.c                             |   8 +
 hw/core/sysbus-fdt.c                      |   1 +
 hw/i386/acpi-build.c                      |  23 --
 hw/loongarch/acpi-build.c                 |  38 +--
 hw/loongarch/virt.c                       |   8 +
 hw/riscv/virt.c                           |   1 +
 hw/tpm/tpm-sysbus.c                       |  47 ++++
 hw/tpm/tpm_crb.c                          | 302 ++++++----------------
 hw/tpm/tpm_crb_common.c                   | 260 +++++++++++++++++++
 hw/tpm/tpm_crb_sysbus.c                   | 162 ++++++++++++
 hw/tpm/tpm_ppi.c                          |   5 +-
 hw/tpm/tpm_tis_isa.c                      |   5 +-
 hw/tpm/tpm_tis_sysbus.c                   |  37 +++
 tests/qtest/bios-tables-test.c            |  47 +++-
 tests/qtest/tpm-crb-device-swtpm-test.c   |  72 ++++++
 tests/qtest/tpm-crb-device-test.c         |  71 +++++
 tests/qtest/tpm-crb-swtpm-test.c          |   2 +
 tests/qtest/tpm-crb-test.c                | 121 +--------
 tests/qtest/tpm-tests.c                   | 121 +++++++++
 tests/qtest/tpm-tis-device-swtpm-test.c   |   2 +-
 tests/qtest/tpm-tis-device-test.c         |   2 +-
 tests/qtest/tpm-tis-i2c-test.c            |   3 +
 tests/qtest/tpm-tis-swtpm-test.c          |   2 +-
 tests/qtest/tpm-tis-test.c                |   2 +-
 tests/qtest/tpm-util.c                    |  16 +-
 hw/arm/Kconfig                            |   1 +
 hw/loongarch/Kconfig                      |   2 +
 hw/riscv/Kconfig                          |   1 +
 hw/tpm/Kconfig                            |   5 +
 hw/tpm/meson.build                        |   5 +
 hw/tpm/trace-events                       |   2 +-
 tests/data/acpi/q35/DSDT.crb.tpm2         | Bin 0 -> 8355 bytes
 tests/data/acpi/q35/TPM2.crb.tpm2         | Bin 0 -> 76 bytes
 tests/data/acpi/virt/DSDT.crb-device.tpm2 | Bin 0 -> 5276 bytes
 tests/data/acpi/virt/TPM2.crb-device.tpm2 | Bin 0 -> 76 bytes
 tests/qtest/meson.build                   |   4 +
 45 files changed, 1054 insertions(+), 476 deletions(-)
 create mode 100644 hw/tpm/tpm_crb.h
 create mode 100644 hw/tpm/tpm-sysbus.c
 create mode 100644 hw/tpm/tpm_crb_common.c
 create mode 100644 hw/tpm/tpm_crb_sysbus.c
 create mode 100644 tests/qtest/tpm-crb-device-swtpm-test.c
 create mode 100644 tests/qtest/tpm-crb-device-test.c
 create mode 100644 tests/data/acpi/q35/DSDT.crb.tpm2
 create mode 100644 tests/data/acpi/q35/TPM2.crb.tpm2
 create mode 100644 tests/data/acpi/virt/DSDT.crb-device.tpm2
 create mode 100644 tests/data/acpi/virt/TPM2.crb-device.tpm2

-- 
2.41.0


