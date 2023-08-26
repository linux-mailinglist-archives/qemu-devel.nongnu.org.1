Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 019547897EE
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Aug 2023 18:04:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZvkl-0006Uw-Qu; Sat, 26 Aug 2023 12:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qZvki-0006Uo-Ud
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 12:03:09 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qZvkf-0007r5-EI
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 12:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=890dBUwkKMxC77bHsLbom+1i3eOLPNpV8Wzj+OwRc40=; b=W+aVBC0MH10WHxIzwLeNG//stv
 ROBreRgxSS4EjLa66mwduq9F0a0LQfwVGlmyoPCE9j9bQui1lksUzhYvQF8X1zrsGSrbyQ8wTEOGX
 9HENjab6DOZc0EKLDO8tnjjQzsGh193Iaa0hRPKWVTla7k8jaKIgpOgfvnaUYVRM765Y=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me,
	kbastian@mail.uni-paderborn.de
Subject: [PATCH 00/10] TriCore 1.6.2 insn and bugfixes
Date: Sat, 26 Aug 2023 18:02:32 +0200
Message-ID: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.8.26.155417, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.8.20.602000
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::16;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=doohan.uni-paderborn.de
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

Hi,

this series implements the insns reported in [1], as well as ftou. Also I fixed
two bugs in the insert insn which I came across during testing.

Cheers,
Bastian


[1] https://gitlab.com/qemu-project/qemu/-/issues/1667

Bastian Koppelmann (10):
  tests/tcg/tricore: Bump cpu to tc37x
  target/tricore: Implement CRCN insn
  target/tricore: Correctly handle FPU RM from PSW
  target/tricore: Implement FTOU insn
  target/tricore: Implement ftohp insn
  target/tricore: Implement hptof insn
  target/tricore: Fix RCPW/RRPW_INSERT insns for width = 0
  target/tricore: Swap src and dst reg for RCRR_INSERT
  target/tricore: Replace cpu_*_code with translator_*
  target/tricore: Fix FTOUZ being ISA v1.3.1 up

 target/tricore/fpu_helper.c               | 105 ++++++++++++++++++++++
 target/tricore/helper.c                   |  19 +++-
 target/tricore/helper.h                   |   4 +
 target/tricore/op_helper.c                |  66 ++++++++++++++
 target/tricore/translate.c                |  54 ++++++++---
 target/tricore/tricore-opcodes.h          |   3 +
 tests/tcg/tricore/Makefile.softmmu-target |   6 +-
 tests/tcg/tricore/asm/macros.h            |  24 +++++
 tests/tcg/tricore/asm/test_crcn.S         |   9 ++
 tests/tcg/tricore/asm/test_ftohp.S        |  14 +++
 tests/tcg/tricore/asm/test_ftou.S         |  12 +++
 tests/tcg/tricore/asm/test_hptof.S        |  12 +++
 tests/tcg/tricore/asm/test_insert.S       |  14 +++
 13 files changed, 329 insertions(+), 13 deletions(-)
 create mode 100644 tests/tcg/tricore/asm/test_crcn.S
 create mode 100644 tests/tcg/tricore/asm/test_ftohp.S
 create mode 100644 tests/tcg/tricore/asm/test_ftou.S
 create mode 100644 tests/tcg/tricore/asm/test_hptof.S

-- 
2.41.0


