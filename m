Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F42B711FBD
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 08:20:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Qo3-0007v5-Lw; Fri, 26 May 2023 02:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q2Qo0-0007uO-Bj
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:20:04 -0400
Received: from hoth.uni-paderborn.de ([2001:638:502:c003::19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q2Qny-00088Z-86
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pDKz4wAh3YBiNbwIxDF/HDSDwTWanUYvH99JeEwqofs=; b=ZU61iZPf3R1xmzfCuHio+EkNfZ
 TADgY+40JpEPo5YhwF1/ovGJnqZSUxjKQuZvEjNiZKF32R59ecKWKpjaRXdIqVX/pR85+2nOfGMek
 0EpcxBr0S7zsFfmEH72kJuc4A+kvlLNBf+jt1oodyyf+sc5cVw1dcFDu4fIqWU1zQSug=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH v2 0/6] TriCore PCXI/ICR register fixes
Date: Fri, 26 May 2023 08:19:40 +0200
Message-Id: <20230526061946.54514-1-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.5.26.61217, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.5.16.600001
X-Sophos-SenderHistory: ip=84.184.48.71, fs=405220, da=172691060, mc=1, sc=0,
 hc=1, sp=0, fso=405220, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::19;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=hoth.uni-paderborn.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi,

the main motivator for this series was
https://gitlab.com/qemu-project/qemu/-/issues/1453. To test that I'm not
screwing up this refactor I also extended the tests by C programs so we can test
the PCXI/ICR registers by recursive function call. Through these tests I also
found a problem, where we were not correctly updating PSW when we did a context
save.

Cheers,
Bastian

v1 -> v2:
    - Created icr_ie_mask for DisasCtx to simplify SYS_ENABLE and SYS_DISABLE
      insns translation.

Bastian Koppelmann (6):
  tests/tcg/tricore: Move asm tests into 'asm' directory
  tests/tcg/tricore: Uses label for memory addresses
  tests/tcg/tricore: Add first C program
  target/tricore: Refactor PCXI/ICR register fields
  target/tricore: Fix wrong PSW for call insns
  tests/tcg/tricore: Add recursion test for CSAs

 configure                                     |   1 +
 target/tricore/cpu.h                          |  39 +-
 target/tricore/helper.c                       |  45 +++
 target/tricore/op_helper.c                    |  87 ++---
 target/tricore/translate.c                    |  10 +-
 tests/tcg/tricore/Makefile.softmmu-target     |  49 ++-
 tests/tcg/tricore/{ => asm}/macros.h          |   1 -
 tests/tcg/tricore/{ => asm}/test_abs.S        |   0
 tests/tcg/tricore/{ => asm}/test_bmerge.S     |   0
 tests/tcg/tricore/{ => asm}/test_clz.S        |   0
 tests/tcg/tricore/{ => asm}/test_dextr.S      |   0
 tests/tcg/tricore/{ => asm}/test_dvstep.S     |   0
 tests/tcg/tricore/{ => asm}/test_fadd.S       |   0
 tests/tcg/tricore/{ => asm}/test_fmul.S       |   0
 tests/tcg/tricore/{ => asm}/test_ftoi.S       |   0
 tests/tcg/tricore/{ => asm}/test_imask.S      |   0
 tests/tcg/tricore/{ => asm}/test_insert.S     |   0
 tests/tcg/tricore/{ => asm}/test_ld_bu.S      |   4 +-
 tests/tcg/tricore/asm/test_ld_h.S             |  15 +
 tests/tcg/tricore/{ => asm}/test_madd.S       |   0
 tests/tcg/tricore/{ => asm}/test_msub.S       |   0
 tests/tcg/tricore/{ => asm}/test_muls.S       |   0
 tests/tcg/tricore/c/crt0-tc2x.S               | 335 ++++++++++++++++++
 tests/tcg/tricore/c/test_boot_to_main.c       |  13 +
 tests/tcg/tricore/c/test_context_save_areas.c |  15 +
 tests/tcg/tricore/c/testdev_assert.h          |  18 +
 tests/tcg/tricore/link.ld                     |  16 +
 tests/tcg/tricore/test_ld_h.S                 |  15 -
 28 files changed, 572 insertions(+), 91 deletions(-)
 rename tests/tcg/tricore/{ => asm}/macros.h (99%)
 rename tests/tcg/tricore/{ => asm}/test_abs.S (100%)
 rename tests/tcg/tricore/{ => asm}/test_bmerge.S (100%)
 rename tests/tcg/tricore/{ => asm}/test_clz.S (100%)
 rename tests/tcg/tricore/{ => asm}/test_dextr.S (100%)
 rename tests/tcg/tricore/{ => asm}/test_dvstep.S (100%)
 rename tests/tcg/tricore/{ => asm}/test_fadd.S (100%)
 rename tests/tcg/tricore/{ => asm}/test_fmul.S (100%)
 rename tests/tcg/tricore/{ => asm}/test_ftoi.S (100%)
 rename tests/tcg/tricore/{ => asm}/test_imask.S (100%)
 rename tests/tcg/tricore/{ => asm}/test_insert.S (100%)
 rename tests/tcg/tricore/{ => asm}/test_ld_bu.S (68%)
 create mode 100644 tests/tcg/tricore/asm/test_ld_h.S
 rename tests/tcg/tricore/{ => asm}/test_madd.S (100%)
 rename tests/tcg/tricore/{ => asm}/test_msub.S (100%)
 rename tests/tcg/tricore/{ => asm}/test_muls.S (100%)
 create mode 100644 tests/tcg/tricore/c/crt0-tc2x.S
 create mode 100644 tests/tcg/tricore/c/test_boot_to_main.c
 create mode 100644 tests/tcg/tricore/c/test_context_save_areas.c
 create mode 100644 tests/tcg/tricore/c/testdev_assert.h
 delete mode 100644 tests/tcg/tricore/test_ld_h.S

--
2.40.1


