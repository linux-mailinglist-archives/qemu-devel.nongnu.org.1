Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B93E673D774
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:02:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDfDr-0003Hz-EA; Mon, 26 Jun 2023 01:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfDo-0003Gd-OU; Mon, 26 Jun 2023 01:57:08 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfDm-0007BD-19; Mon, 26 Jun 2023 01:57:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QqHD71MQsz4wb1;
 Mon, 26 Jun 2023 15:56:55 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqHD45ccfz4wZy;
 Mon, 26 Jun 2023 15:56:52 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 00/30] ppc queue
Date: Mon, 26 Jun 2023 07:56:17 +0200
Message-ID: <20230626055647.1147743-1-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The following changes since commit 79dbd910c9ea6ca38f8e1b2616b1e5e885b85bd3:

  Merge tag 'hppa-boot-reboot-fixes-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2023-06-25 08:58:49 +0200)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-ppc-20230626

for you to fetch changes up to 5eb63b88d0ac259c2f49e62b6dcc6527a5caf255:

  tests/avocado: ppc test VOF bios Linux boot (2023-06-25 22:41:31 +0200)

----------------------------------------------------------------
ppc queue:

* New maintainers
* Nested implementation cleanups
* Various cleanups of the CPU implementation
* SMT support for pseries
* Improvements of the XIVE2 TIMA modeling
* Extra avocado tests for pseries

----------------------------------------------------------------
Cédric Le Goater (7):
      MAINTAINERS: Add reviewers for PowerNV baremetal emulation
      MAINTAINERS: Add reviewer for PowerPC TCG CPUs
      MAINTAINERS: Add reviewer for XIVE
      ppc/prep: Report an error when run with KVM
      ppc/bamboo: Report an error when run with KVM
      ppc/pnv: Rephrase error when run with KVM
      target/ppc: Fix timer register accessors when !KVM

Frederic Barrat (2):
      pnv/xive2: Add a get_config() method on the presenter class
      pnv/xive2: Check TIMA special ops against a dedicated array for P10

Joel Stanley (1):
      ppc/pnv/pci: Clean up error messages

Nicholas Piggin (19):
      target/ppc: gdbstub init spr gdb_id for all CPUs
      ppc/spapr: H_ENTER_NESTED should restore host XER ca field
      ppc/spapr: Add a nested state struct
      ppc/spapr: load and store l2 state with helper functions
      ppc/spapr: Move spapr nested HV to a new file
      target/ppc: Fix instruction loading endianness in alignment interrupt
      target/ppc: Change partition-scope translate interface
      target/ppc: Add SRR1 prefix indication to interrupt handlers
      target/ppc: Implement HEIR SPR
      target/ppc: Add ISA v3.1 LEV indication in SRR1 for system call interrupts
      target/ppc: Better CTRL SPR implementation
      target/ppc: Fix sc instruction handling of LEV field
      target/ppc: Add initial flags and helpers for SMT support
      target/ppc: Add support for SMT CTRL register
      target/ppc: Add msgsnd/p and DPDES SMT support
      spapr: TCG allow up to 8-thread SMT on POWER8 and newer CPUs
      tests/avocado: boot ppc64 pseries to Linux VFS mount
      tests/avocado: Add ppc64 pseries multiprocessor boot tests
      tests/avocado: ppc test VOF bios Linux boot

Philippe Mathieu-Daudé (1):
      hw/ppc/spapr: Test whether TCG is enabled with tcg_enabled()

 MAINTAINERS                     |   4 +
 include/hw/ppc/ppc.h            |   1 +
 include/hw/ppc/spapr.h          |  62 -------
 include/hw/ppc/spapr_cpu_core.h |   5 +-
 include/hw/ppc/spapr_nested.h   | 102 +++++++++++
 include/hw/ppc/xive.h           |   3 +
 target/ppc/cpu.h                |  10 +
 target/ppc/helper.h             |   2 +
 hw/intc/pnv_xive.c              |  11 ++
 hw/intc/pnv_xive2.c             |  44 ++---
 hw/intc/spapr_xive.c            |  16 ++
 hw/intc/xive.c                  |  57 +++++-
 hw/pci-host/pnv_phb4.c          |  14 +-
 hw/ppc/pnv.c                    |   3 +-
 hw/ppc/ppc.c                    |   6 +
 hw/ppc/ppc440_bamboo.c          |  17 +-
 hw/ppc/prep.c                   |  20 +-
 hw/ppc/spapr.c                  |  18 +-
 hw/ppc/spapr_caps.c             |  14 ++
 hw/ppc/spapr_cpu_core.c         |   7 +-
 hw/ppc/spapr_hcall.c            | 335 +---------------------------------
 hw/ppc/spapr_nested.c           | 395 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/cpu_init.c           |  28 +++
 target/ppc/excp_helper.c        | 144 ++++++++++++++-
 target/ppc/gdbstub.c            |  30 +--
 target/ppc/kvm.c                |  12 ++
 target/ppc/misc_helper.c        |  69 ++++++-
 target/ppc/mmu-radix64.c        |  38 ++--
 target/ppc/translate.c          |  62 ++++++-
 hw/ppc/meson.build              |   1 +
 tests/avocado/ppc_pseries.py    |  73 +++++++-
 31 files changed, 1085 insertions(+), 518 deletions(-)
 create mode 100644 include/hw/ppc/spapr_nested.h
 create mode 100644 hw/ppc/spapr_nested.c

