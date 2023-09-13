Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F4C79E560
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 12:55:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgNVL-0007dk-1b; Wed, 13 Sep 2023 06:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qgNVH-0007cV-DU
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:53:51 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qgNVD-0006OC-C2
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0Vq74qweT+DLop13PNdj8FwF80DlNR+dgWaQL1eI4uw=; b=ARKhkILYLJIlO8x1I0oxDA0eGR
 z8QuyJRqVtPdn3Vn3D71HczeBq/9vQoSWo5NNp6Q9S71TMbv9pFSwaCYuu4zpDIzvVA/JNTQHPHss
 l2kdg+Qs8Fy8Hnxkecg5vJt8Sh3VY5TAfHXtB33eKTr2TlJkfM3paVKXEDuY+jmVq1aU=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH 00/10] TriCore tests and cleanups
Date: Wed, 13 Sep 2023 12:53:16 +0200
Message-ID: <20230913105326.40832-1-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.13.104216, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.13.602000
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

this series adds a test for many of the arithmetic instructions of the TriCore.
The goal here is that each TriCore instruction is eventually at least run once in CI.

While at this, I also cleaned up cpu.h, which contained a copy of the core special
function registers (CSFR). These are already defined in csfr.h.inc, so I use
this definition.

I also changed the types of the effective address (ea) in op_helper.c to
target_ulong, as it cannot be sign extened.

Cheers,
Bastian

Bastian Koppelmann (10):
  tests/tcg/tricore: Extended and non-extened regs now match
  hw/tricore: Log failing test in testdevice
  tests/tcg: Reset result register after each test
  tests/tcg/tricore: Add test for all arith insns up to addx
  tests/tcg/tricore: Add test for and to csub
  tests/tcg/tricore: Add from dextr to lt
  tests/tcg/tricore: Add test from 'max' to 'shas'
  tests/tcg/tricore: Add test from 'shuffle' to 'xor.t'
  target/tricore: Remove CSFRs from cpu.h
  target/tricore: Change effective address (ea) to target_ulong

 hw/tricore/tricore_testdevice.c           |   4 +
 target/tricore/cpu.h                      | 143 +----------
 target/tricore/op_helper.c                |  16 +-
 tests/tcg/tricore/Makefile.softmmu-target |   3 +-
 tests/tcg/tricore/asm/macros.h            | 166 +++++++++++--
 tests/tcg/tricore/asm/test_arith.S        | 280 ++++++++++++++++++++++
 6 files changed, 447 insertions(+), 165 deletions(-)
 create mode 100644 tests/tcg/tricore/asm/test_arith.S

-- 
2.42.0


