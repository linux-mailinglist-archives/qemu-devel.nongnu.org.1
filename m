Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F7B7B2C7F
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 08:42:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm7B7-0005g9-Kw; Fri, 29 Sep 2023 02:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qm7Am-0005bx-G7
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:40:25 -0400
Received: from hoth.uni-paderborn.de ([2001:638:502:c003::19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qm7Aj-0007Kc-US
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XyxSUsJrxV5annraaRQO8oJh+M2om8usuYRoTbxO/98=; b=hIxbpvbP6ye1DgAvLk/CWEUqXA
 CP7ZJtEyLhOHOuPAvJ8YKzYzw3GlblJxzsWhN5tEwM9ppQy66QMllQE+mYhRbSQvhgqCpX1DDUe3J
 zf/s7pcku8BO45xtxNsPOFRZrH7ak7Bnvz/MxeO+XCy5VBz91xhk8NidP1C2efQOom9I=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PULL v3 00/16] tricore queue
Date: Fri, 29 Sep 2023 08:39:44 +0200
Message-ID: <20230929064000.536923-1-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.29.62717, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.28.602002
X-Sophos-SenderHistory: ip=79.202.213.239, fs=162250, da=183578679, mc=44, sc=0,
 hc=44, sp=0, fso=162250, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::19;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=hoth.uni-paderborn.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  https://github.com/bkoppelmann/qemu.git tags/pull-tricore-20230929

for you to fetch changes up to ceada000846b0cd81c578b1da9f76d0c59536654:

  target/tricore: Change effective address (ea) to target_ulong (2023-09-29 08:28:09 +0200)

----------------------------------------------------------------
- Add FTOU, CRCN, FTOHP, and HPTOF insns

----------------------------------------------------------------
Changes from v2:
- Replaced %ld with PRIu64 for patch 13
- Dropped patches 15 - 19, as they require an updated patch series
----------------------------------------------------------------

Bastian Koppelmann (16):
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
      target/tricore: Remove CSFRs from cpu.h
      target/tricore: Change effective address (ea) to target_ulong

 hw/tricore/tricore_testdevice.c           |   4 +
 target/tricore/cpu.h                      | 143 ++----------------------------
 target/tricore/fpu_helper.c               | 111 +++++++++++++++++++++++
 target/tricore/helper.c                   |  19 +++-
 target/tricore/helper.h                   |   4 +
 target/tricore/op_helper.c                |  79 +++++++++++++++--
 target/tricore/translate.c                |  56 +++++++++---
 target/tricore/tricore-opcodes.h          |   3 +
 tests/tcg/tricore/Makefile.softmmu-target |   6 +-
 tests/tcg/tricore/asm/macros.h            |  65 +++++++++-----
 tests/tcg/tricore/asm/test_crcn.S         |   9 ++
 tests/tcg/tricore/asm/test_ftohp.S        |  14 +++
 tests/tcg/tricore/asm/test_ftou.S         |  12 +++
 tests/tcg/tricore/asm/test_hptof.S        |  12 +++
 tests/tcg/tricore/asm/test_insert.S       |  14 +++
 15 files changed, 376 insertions(+), 175 deletions(-)
 create mode 100644 tests/tcg/tricore/asm/test_crcn.S
 create mode 100644 tests/tcg/tricore/asm/test_ftohp.S
 create mode 100644 tests/tcg/tricore/asm/test_ftou.S
 create mode 100644 tests/tcg/tricore/asm/test_hptof.S

