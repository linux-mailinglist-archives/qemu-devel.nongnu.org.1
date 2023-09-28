Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 346AF7B16B6
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 10:57:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlmm2-0006XB-2h; Thu, 28 Sep 2023 04:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qlmlx-0006Vx-NF
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 04:53:27 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qlmlr-0004uw-Cz
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 04:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7QFF7YcXTHTaclWeA2gymHIZBwWYiN5Ql11MfxhyH3U=; b=e1wsWQ7aFfvb9+NGvyL4bqtg9A
 kg3WBHLIV1Lf818D1R+/PgTgy3He6+iY0RhBcXWQ06qSHQEk5ZfLg7YydUSsqavklmBvGKdELLii+
 IfqS05ars3DL+eM+heNW2ZeQ3XRNgvypQy5AvX2F7k81BuWU41rI3q+Qml9UaY15NLwk=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PULL v2 00/21] tricore queue
Date: Thu, 28 Sep 2023 10:52:42 +0200
Message-ID: <20230928085303.511518-1-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.28.84518, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.26.602000
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::17;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=zuban.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 36e9aab3c569d4c9ad780473596e18479838d1aa:

  migration: Move return path cleanup to main migration thread (2023-09-27 13:58:02 -0400)

are available in the Git repository at:

  https://github.com/bkoppelmann/qemu.git tags/pull-tricore-20230928

for you to fetch changes up to 080ca1baa84316a58790b6507de89fabf4c40ec0:

  target/tricore: Change effective address (ea) to target_ulong (2023-09-28 10:45:22 +0200)

----------------------------------------------------------------
- Add FTOU, CRCN, FTOHP, and HPTOF insns
- Add test for arithmetic TriCore insns

----------------------------------------------------------------
Changes from v1:
- Removed sas.py file that slipped in patch 15
----------------------------------------------------------------

Bastian Koppelmann (21):
      tests/tcg/tricore: Bump cpu to tc37x
      target/tricore: Implement CRCN insn
      target/tricore: Correctly handle FPU RM from PSW
      target/tricore: Implement FTOU insn
      target/tricore: Clarify special case for FTOUZ insn
      target/tricore: Implement ftohp insn
      target/tricore: Implement hptof insn
      target/tricore: Fix RCPW/RRPW_INSERT insns for width = 0
      target/tricore: Swap src and dst reg for RCRR_INSERT
      target/tricore: Replace cpu_*_code with translator_*
      target/tricore: Fix FTOUZ being ISA v1.3.1 up
      tests/tcg/tricore: Extended and non-extened regs now match
      hw/tricore: Log failing test in testdevice
      tests/tcg: Reset result register after each test
      tests/tcg/tricore: Add test for all arith insns up to addx
      tests/tcg/tricore: Add test from 'and' to 'csub'
      tests/tcg/tricore: Add test from 'dextr' to 'lt'
      tests/tcg/tricore: Add test from 'max' to 'shas'
      tests/tcg/tricore: Add test from 'shuffle' to 'xor.t'
      target/tricore: Remove CSFRs from cpu.h
      target/tricore: Change effective address (ea) to target_ulong

 hw/tricore/tricore_testdevice.c           |   4 +
 target/tricore/cpu.h                      | 143 +--------------
 target/tricore/fpu_helper.c               | 111 ++++++++++++
 target/tricore/helper.c                   |  19 +-
 target/tricore/helper.h                   |   4 +
 target/tricore/op_helper.c                |  79 ++++++++-
 target/tricore/translate.c                |  56 ++++--
 target/tricore/tricore-opcodes.h          |   3 +
 tests/tcg/tricore/Makefile.softmmu-target |   7 +-
 tests/tcg/tricore/asm/macros.h            | 190 +++++++++++++++++---
 tests/tcg/tricore/asm/test_arith.S        | 280 ++++++++++++++++++++++++++++++
 tests/tcg/tricore/asm/test_crcn.S         |   9 +
 tests/tcg/tricore/asm/test_ftohp.S        |  14 ++
 tests/tcg/tricore/asm/test_ftou.S         |  12 ++
 tests/tcg/tricore/asm/test_hptof.S        |  12 ++
 tests/tcg/tricore/asm/test_insert.S       |  14 ++
 16 files changed, 780 insertions(+), 177 deletions(-)
 create mode 100644 tests/tcg/tricore/asm/test_arith.S
 create mode 100644 tests/tcg/tricore/asm/test_crcn.S
 create mode 100644 tests/tcg/tricore/asm/test_ftohp.S
 create mode 100644 tests/tcg/tricore/asm/test_ftou.S
 create mode 100644 tests/tcg/tricore/asm/test_hptof.S

