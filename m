Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF47974B02F
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:46:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjgR-0001me-Pr; Fri, 07 Jul 2023 07:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgM-0001kU-Jz; Fri, 07 Jul 2023 07:31:29 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgK-0006Si-Js; Fri, 07 Jul 2023 07:31:26 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6b708b97418so1657584a34.3; 
 Fri, 07 Jul 2023 04:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729483; x=1691321483;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qh6BMV8TeKYl9RWTA8iKGz+S/YN80L9APtWqv8Po7tM=;
 b=GkaZcOg7djHhR0BrivyFpCYj4YQTReucngLYvo60FcJCEhGKwtDtZXzlNJDwqHtw1G
 1kIV9fmikqe3BTeeaqe8ye4R33F5MqpSlGrIGyOhDEPfdP6g6xwpcuG+6+TpQbe9b17N
 jk5fA2ag62SQBuFcWBPIBwJuKaGXXietRqXAsiBDfe+A7X77tJqOEM7vGnKffoTYFmlj
 k1atAEy+v7T/yZN686YdiFXq2UpxjixacC0ynWW1aYJ4VveumH3K2oZpZ3gSOnKyxrma
 /kPC6XtfjMkn4oOsWozUYcZviW5c5vK8GeDcUlvE7Qu8RxlrjMSnaxSawJqeTtTjyvNY
 N6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729483; x=1691321483;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qh6BMV8TeKYl9RWTA8iKGz+S/YN80L9APtWqv8Po7tM=;
 b=FCtOKteOinmnIYs0O71ziQMAbxzWCTyS0XAi0djl8ziSrCfSzZtE/Z5CCGpkR29BZp
 xfrNzTg2cp/O5ElqtHtpPsetQEYgnRylo5mNv97EEiT3ZY+6m7YmaqdDayQaYktLXT/l
 99iGpG8BbaJxXF+pi3zlM15n62HL2O1DSkSUHEtxSd2uaWUoCT6XDXJh9NONuvhAVMgJ
 31FkrZr46kh9oakRVLiQr/ajjVDlrPVYyLfiSACNqre3SMF0kBclUp3FwdD05r93FFbL
 jij6oT9tS/mkr3bA3qWsaexNsX2+XZa5JHHMHBIcsP4ZSLgfG+inpCVaMqr5O3daajRv
 JGww==
X-Gm-Message-State: ABy/qLYEb4HzTSWjH/mI24MaWC3ToDYRT5FMqVIyo5PjprL5qJGxyzv8
 RJg8IVIHQGyFGphZKHiFfZ7vmpPK2cM=
X-Google-Smtp-Source: APBJJlHHTtf1HHd7uUekgZFIXs+0yXirnaBRNc4jXdrcw9DaPxQp1zPFWXce8lo4ATLZogzfKPimRQ==
X-Received: by 2002:a9d:7483:0:b0:6b9:247d:755 with SMTP id
 t3-20020a9d7483000000b006b9247d0755mr56705otk.3.1688729482912; 
 Fri, 07 Jul 2023 04:31:22 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:31:22 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: [PULL 00/60] ppc queue
Date: Fri,  7 Jul 2023 08:30:08 -0300
Message-ID: <20230707113108.7145-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32a.google.com
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

The following changes since commit 97c81ef4b8e203d9620fd46e7eb77004563e3675:

  Merge tag 'pull-9p-20230706' of https://github.com/cschoenebeck/qemu into staging (2023-07-06 18:19:42 +0100)

are available in the Git repository at:

  https://gitlab.com/danielhb/qemu.git tags/pull-ppc-20230707

for you to fetch changes up to 2f8ebb98ef8c7e85b23678812d8a7a95c9479673:

  ppc: Enable 2nd DAWR support on p10 (2023-07-07 06:33:04 -0300)

----------------------------------------------------------------
ppc patch queue for 2023-07-07:

In this last queue for 8.1 we have a lot of fixes and improvements all
around: SMT support for powerNV, XIVE fixes, PPC440 cleanups, exception
handling cleanups and kvm_pph.h cleanups just to name a few.

Thanks everyone in the qemu-ppc community for all the contributions for
the next QEMU release.

----------------------------------------------------------------
BALATON Zoltan (22):
      mv64361: Add dummy gigabit ethernet PHY access registers
      target/ppc: Remove some superfluous parentheses
      target/ppc: Remove unneeded parameter from powerpc_reset_wakeup()
      target/ppc: Move common check in exception handlers to a function
      target/ppc: Remove some more local CPUState variables only used once
      target/ppd: Remove unused define
      target/ppc: Get CPUState in one step
      ppc/pegasos2: Add support for -initrd command line option
      ppc440: Change ppc460ex_pcie_init() parameter type
      ppc440: Add cpu link property to PCIe controller model
      ppc440: Add a macro to shorten PCIe controller DCR registration
      ppc440: Rename parent field of PPC460EXPCIEState to match code style
      ppc440: Rename local variable in dcr_read_pcie()
      ppc440: Stop using system io region for PCIe buses
      ppc440: Add busnum property to PCIe controller model
      ppc440: Remove ppc460ex_pcie_init legacy init function
      ppc/sam460ex: Remove address_space_mem local variable
      ppc440_pcix: Don't use iomem for regs
      ppc440_pcix: Stop using system io region for PCI bus
      ppc4xx_pci: Rename QOM type name define
      ppc4xx_pci: Add define for ppc4xx-host-bridge type name
      ppc440_pcix: Rename QOM type define abd move it to common header

Frederic Barrat (8):
      pnv/psi: Allow access to PSI registers through xscom
      pnv/xive2: Allow indirect TIMA accesses of all sizes
      pnv/xive2: Fix TIMA offset for indirect access
      pnv/xive: Add property on xive sources to define PQ state on reset
      pnv/psi: Initialize the PSIHB interrupts to match hardware
      pnv/xive: Allow mmio operations of any size on the ESB CI pages
      pnv/xive: Print CPU target in all TIMA traces
      pnv/xive2: Always pass a presenter object when accessing the TIMA

Joel Stanley (7):
      ppc/pnv: quad xscom callbacks are P9 specific
      ppc/pnv: Subclass quad xscom callbacks
      ppc/pnv: Add P10 quad xscom model
      ppc/pnv: Add P10 core xscom model
      ppc/pnv: Return zero for core thread state xscom
      ppc/pnv: Log all unimp warnings with similar message
      ppc/pnv: Add QME region for P10

Narayana Murty N (1):
      target: ppc: Use MSR_HVB bit to get the target endianness for memory dump

Nicholas Piggin (14):
      target/ppc: Make HDECR underflow edge triggered
      hw/ppc: Fix clock update drift
      target/ppc: Tidy POWER book4 SPR registration
      target/ppc: Add TFMR SPR implementation with read and write helpers
      sungem: Add WOL MMIO
      target/ppc: Fix icount access for some hypervisor instructions
      tests/avocado: record_replay test for ppc powernv machine
      target/ppc: Add LPAR-per-core vs per-thread mode flag
      target/ppc: SMT support for the HID SPR
      ppc/pnv: SMT support for powernv
      tests/avocado: Add powernv machine test script
      ppc/pnv: Set P10 core xscom region size to match hardware
      tests/qtest: Add xscom tests for powernv10 machine
      target/ppc: Machine check on invalid real address access on POWER9/10

Philippe Mathieu-Daudé (7):
      target/ppc: Only generate decodetree files when TCG is enabled
      target/ppc: Have 'kvm_ppc.h' include 'sysemu/kvm.h'
      target/ppc: Reorder #ifdef'ry in kvm_ppc.h
      target/ppc: Move CPU QOM definitions to cpu-qom.h
      target/ppc: Define TYPE_HOST_POWERPC_CPU in cpu-qom.h
      target/ppc: Restrict 'kvm_ppc.h' to sysemu in cpu_init.c
      target/ppc: Remove pointless checks of CONFIG_USER_ONLY in 'kvm_ppc.h'

Ravi Bangoria (1):
      ppc: Enable 2nd DAWR support on p10

 docs/system/ppc/powernv.rst    |   5 -
 hw/intc/pnv_xive2.c            |  26 +++-
 hw/intc/trace-events           |   4 +-
 hw/intc/xive.c                 |  20 +--
 hw/intc/xive2.c                |   4 +-
 hw/net/sungem.c                |  52 ++++++++
 hw/net/trace-events            |   2 +
 hw/pci-host/mv64361.c          |   6 +
 hw/pci-host/mv643xx.h          |   3 +
 hw/ppc/pegasos2.c              |  32 ++++-
 hw/ppc/pnv.c                   |  26 +++-
 hw/ppc/pnv_core.c              | 282 ++++++++++++++++++++++++++++++++++-------
 hw/ppc/pnv_psi.c               |  33 +++--
 hw/ppc/ppc.c                   |  49 +++----
 hw/ppc/ppc440.h                |   1 -
 hw/ppc/ppc440_bamboo.c         |   3 +-
 hw/ppc/ppc440_pcix.c           |  28 ++--
 hw/ppc/ppc440_uc.c             | 192 ++++++++++++----------------
 hw/ppc/ppc4xx_pci.c            |  10 +-
 hw/ppc/sam460ex.c              |  33 +++--
 hw/ppc/spapr.c                 |   7 +-
 hw/ppc/spapr_caps.c            |  32 +++++
 hw/ppc/spapr_cpu_core.c        |   2 +
 include/hw/ppc/pnv_core.h      |  18 ++-
 include/hw/ppc/pnv_xscom.h     |  15 ++-
 include/hw/ppc/ppc4xx.h        |   5 +-
 include/hw/ppc/spapr.h         |   6 +-
 include/hw/ppc/xive.h          |   1 +
 target/ppc/arch_dump.c         |   2 +-
 target/ppc/cpu-qom.h           |   6 +
 target/ppc/cpu.h               |   9 +-
 target/ppc/cpu_init.c          | 112 ++++++++++++----
 target/ppc/excp_helper.c       | 206 ++++++++++++++----------------
 target/ppc/helper.h            |   3 +
 target/ppc/internal.h          |   5 +
 target/ppc/kvm.c               |  12 ++
 target/ppc/kvm_ppc.h           |  82 ++++++------
 target/ppc/meson.build         |   2 +-
 target/ppc/misc_helper.c       |  29 +++++
 target/ppc/spr_common.h        |   3 +
 target/ppc/timebase_helper.c   |  13 ++
 target/ppc/translate.c         |  45 ++++++-
 tests/avocado/ppc_powernv.py   |  87 +++++++++++++
 tests/avocado/replay_kernel.py |  17 +++
 tests/qtest/pnv-xscom-test.c   |  45 +++++--
 45 files changed, 1123 insertions(+), 452 deletions(-)
 create mode 100644 tests/avocado/ppc_powernv.py

