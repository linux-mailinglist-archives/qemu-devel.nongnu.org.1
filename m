Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 059267DAB03
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 07:05:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwyuF-0002Ac-B9; Sun, 29 Oct 2023 02:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qwyuC-0002AU-Nd
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 02:04:12 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qwyuA-0001li-Ek
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 02:04:12 -0400
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-1cc30bf9e22so6858945ad.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 23:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698559447; x=1699164247;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4V9U/m3lTzo0HZ7W9R8ifr/UNvUwNh+TfU5gUB6CSmI=;
 b=eKLjpMpiybeq5IC2oHq6Y8gc5bFlQYQocPuKBn8meES3iTtG6tTzd3Wc8454wQSPrn
 q7HCb9IpkSKgjZXFJkdyhLt90BWODTHy4Spx0ccImtZ0yxbyB3eQoqbOjcewg3gCyg73
 VFl2rR5ZwqQoPq73BJBxocxJGTOpqO3KbZwtUvVeH4nTgw7JU8ghgV1v66TI19i5xnP2
 fqfL9kfkSqqI/trpwx2E+MdDjXu/bKP6tMfkKg4R9NWL92zmNBPLy/T3X9Nm210GY6ax
 ebTwaf4f8aEM7e9ep0VxTJ4gH5hpI06sckh2Mjga3PjMnTPp7W9RpRL7YfDQmfEhY5RW
 nScw==
X-Gm-Message-State: AOJu0YwAb8OFEovPqG91BeJRXe9r8D+L35JCfS2izh68RiqZdbH0MTSS
 aBdCH8yIQAdSOg0kKMm8b91rdPx+tfHYcg==
X-Google-Smtp-Source: AGHT+IGtt/jGsazCA/9Muwm2VuZKhAz58rOXy4GGWAWki+SqaSvyWcHvbp5Swer4gjooP5cXoqAelA==
X-Received: by 2002:a17:902:dac4:b0:1cc:2be7:c0f2 with SMTP id
 q4-20020a170902dac400b001cc2be7c0f2mr4878178plx.13.1698559447258; 
 Sat, 28 Oct 2023 23:04:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:642:4c02:6ead:344e:2b1:f5a5:58c6])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a17090341cc00b001b8943b37a5sm4019518ple.24.2023.10.28.23.04.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 28 Oct 2023 23:04:06 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/14] tpm: introduce TPM CRB SysBus device
Date: Sat, 28 Oct 2023 23:03:13 -0700
Message-ID: <20231029060404.71196-1-j@getutm.app>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.179; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f179.google.com
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
 hw/tpm/tpm-sysbus.c                       |  33 +++
 hw/tpm/tpm_crb.c                          | 302 ++++++----------------
 hw/tpm/tpm_crb_common.c                   | 260 +++++++++++++++++++
 hw/tpm/tpm_crb_sysbus.c                   | 161 ++++++++++++
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
 tests/data/acpi/q35/DSDT.crb.tpm2         | Bin 0 -> 8981 bytes
 tests/data/acpi/q35/TPM2.crb.tpm2         | Bin 0 -> 76 bytes
 tests/data/acpi/virt/DSDT.crb-device.tpm2 | Bin 0 -> 5276 bytes
 tests/data/acpi/virt/TPM2.crb-device.tpm2 | Bin 0 -> 76 bytes
 tests/qtest/meson.build                   |   4 +
 45 files changed, 1039 insertions(+), 476 deletions(-)
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


