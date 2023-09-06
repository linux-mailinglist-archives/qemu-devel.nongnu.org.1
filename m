Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF452793F0D
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:37:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtee-0006Iq-Bv; Wed, 06 Sep 2023 10:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=4aKV=EW=kaod.org=clg@ozlabs.org>)
 id 1qdteY-0006Ib-Kn; Wed, 06 Sep 2023 10:37:10 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=4aKV=EW=kaod.org=clg@ozlabs.org>)
 id 1qdteT-0006En-Fw; Wed, 06 Sep 2023 10:37:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RglM01v6jz4x2n;
 Thu,  7 Sep 2023 00:37:00 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RglLy2Z9cz4x09;
 Thu,  7 Sep 2023 00:36:58 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL v2 00/35] ppc queue
Date: Wed,  6 Sep 2023 16:36:52 +0200
Message-ID: <20230906143653.54709-1-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=4aKV=EW=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 2d8fbcb1eecd8d39171f457e583428758321d69d:

  Merge tag 'pull-request-2023-08-31' of https://gitlab.com/thuth/qemu into staging (2023-09-05 09:22:13 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-ppc-20230906

for you to fetch changes up to b68147b7a5bf6ea2c2b8a8830465e7e90bb2a77c:

  ppc/xive: Add support for the PC MMIOs (2023-09-06 11:19:33 +0200)

----------------------------------------------------------------
ppc queue :

* debug facility improvements
* timebase and decrementer fixes
* record-replay fixes
* TCG fixes
* XIVE model improvements for multichip


Changes since v1:

* renamed __muldiv64() to muldiv64_rounding()
* removed extra cpu and pcc variables shadowing local variables
* checkpatch.pl fixes

----------------------------------------------------------------
Cédric Le Goater (4):
      ppc/xive: Use address_space routines to access the machine RAM
      ppc/xive: Introduce a new XiveRouter end_notify() handler
      ppc/xive: Handle END triggers between chips with MMIOs
      ppc/xive: Add support for the PC MMIOs

Joel Stanley (1):
      ppc: Add stub implementation of TRIG SPRs

Maksim Kostin (1):
      hw/ppc/e500: fix broken snapshot replay

Nicholas Piggin (26):
      target/ppc: Remove single-step suppression inside 0x100-0xf00
      target/ppc: Improve book3s branch trace interrupt for v2.07S
      target/ppc: Suppress single step interrupts on rfi-type instructions
      target/ppc: Implement breakpoint debug facility for v2.07S
      target/ppc: Implement watchpoint debug facility for v2.07S
      spapr: implement H_SET_MODE debug facilities
      ppc/vhyp: reset exception state when handling vhyp hcall
      ppc/vof: Fix missed fields in VOF cleanup
      hw/ppc/ppc.c: Tidy over-long lines
      hw/ppc: Introduce functions for conversion between timebase and nanoseconds
      host-utils: Add muldiv64_round_up
      hw/ppc: Round up the decrementer interval when converting to ns
      hw/ppc: Avoid decrementer rounding errors
      target/ppc: Sign-extend large decrementer to 64-bits
      hw/ppc: Always store the decrementer value
      target/ppc: Migrate DECR SPR
      hw/ppc: Reset timebase facilities on machine reset
      hw/ppc: Read time only once to perform decrementer write
      target/ppc: Fix CPU reservation migration for record-replay
      target/ppc: Fix timebase reset with record-replay
      spapr: Fix machine reset deadlock from replay-record
      spapr: Fix record-replay machine reset consuming too many events
      tests/avocado: boot ppc64 pseries replay-record test to Linux VFS mount
      tests/avocado: reverse-debugging cope with re-executing breakpoints
      tests/avocado: ppc64 reverse debugging tests for pseries and powernv
      target/ppc: Fix LQ, STQ register-pair order for big-endian

Richard Henderson (1):
      target/ppc: Flush inputs to zero with NJ in ppc_store_vscr

Shawn Anastasio (1):
      target/ppc: Generate storage interrupts for radix RC changes

jianchunfu (1):
      target/ppc: Fix the order of kvm_enable judgment about kvmppc_set_interrupt()

 hw/intc/pnv_xive_regs.h                    |   1 +
 include/hw/ppc/ppc.h                       |   3 +-
 include/hw/ppc/spapr.h                     |   2 +
 include/hw/ppc/xive.h                      |   2 +
 include/qemu/host-utils.h                  |  21 ++-
 target/ppc/cpu.h                           |  12 ++
 target/ppc/helper.h                        |   4 +
 target/ppc/internal.h                      |   3 +
 target/ppc/spr_common.h                    |   3 +
 hw/intc/pnv_xive.c                         | 170 +++++++++++++++-----
 hw/intc/pnv_xive2.c                        |  27 +++-
 hw/intc/xive.c                             |  28 ++--
 hw/ppc/e500.c                              |   2 +-
 hw/ppc/mac_oldworld.c                      |   1 +
 hw/ppc/pegasos2.c                          |   1 +
 hw/ppc/pnv_core.c                          |   2 +
 hw/ppc/ppc.c                               | 243 +++++++++++++++++++----------
 hw/ppc/prep.c                              |   1 +
 hw/ppc/spapr.c                             |  32 +++-
 hw/ppc/spapr_cpu_core.c                    |   2 +
 hw/ppc/spapr_hcall.c                       |  57 +++++++
 hw/ppc/vof.c                               |   2 +
 target/ppc/compat.c                        |  19 +++
 target/ppc/cpu.c                           |  87 +++++++++++
 target/ppc/cpu_init.c                      |  21 ++-
 target/ppc/excp_helper.c                   | 111 ++++++++++++-
 target/ppc/kvm.c                           |   2 +-
 target/ppc/machine.c                       |  45 +++++-
 target/ppc/misc_helper.c                   |  15 ++
 target/ppc/mmu-radix64.c                   |  74 ++++++---
 target/ppc/translate.c                     |  64 ++++++--
 target/ppc/translate/fixedpoint-impl.c.inc |  16 +-
 tests/avocado/replay_kernel.py             |   3 +-
 tests/avocado/reverse_debugging.py         |  54 ++++++-
 34 files changed, 925 insertions(+), 205 deletions(-)

