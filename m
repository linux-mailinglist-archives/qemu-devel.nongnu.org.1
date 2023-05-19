Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2308709878
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 15:38:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q00IQ-0006F8-Jd; Fri, 19 May 2023 09:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q00IG-0006Er-A0
 for qemu-devel@nongnu.org; Fri, 19 May 2023 09:37:17 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q00ID-0006n0-Uc
 for qemu-devel@nongnu.org; Fri, 19 May 2023 09:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OsWicUEUjhuRbRtweBax8ZNdXRgBx+F+t/AMVdk+0Aw=; b=XavMtFJoz617t5uA5g0fZMqg9b
 jDcKl2Q6my5C2EGNo2C3e50wWAvoRBo3yx9cuSD9jyiWcJrbTucBcFvHB/K75JHi9b1YQ0y4Njvc7
 ZIWEfdMJSGDwVdsoFRuXLIRYv5VnqAIEDL8c9baOUHYcAYV56CY+6MGwHChH/bee3dK0=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH 1/6] tests/tcg/tricore: Move asm tests into 'asm' directory
Date: Fri, 19 May 2023 15:36:45 +0200
Message-Id: <20230519133650.575600-2-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519133650.575600-1-kbastian@mail.uni-paderborn.de>
References: <20230519133650.575600-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.5.19.132417, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.5.16.600001
X-Sophos-SenderHistory: ip=84.154.188.104, fs=5, da=172112490, mc=2, sc=0, hc=2,
 sp=0, fso=5, re=0, sd=0, hd=0
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

this seperates these tests from the upcoming tests written in C.
Also rename the compiled test to 'test_<foo>.asm.tst'.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 tests/tcg/tricore/Makefile.softmmu-target | 35 ++++++++++++-----------
 tests/tcg/tricore/{ => asm}/macros.h      |  0
 tests/tcg/tricore/{ => asm}/test_abs.S    |  0
 tests/tcg/tricore/{ => asm}/test_bmerge.S |  0
 tests/tcg/tricore/{ => asm}/test_clz.S    |  0
 tests/tcg/tricore/{ => asm}/test_dextr.S  |  0
 tests/tcg/tricore/{ => asm}/test_dvstep.S |  0
 tests/tcg/tricore/{ => asm}/test_fadd.S   |  0
 tests/tcg/tricore/{ => asm}/test_fmul.S   |  0
 tests/tcg/tricore/{ => asm}/test_ftoi.S   |  0
 tests/tcg/tricore/{ => asm}/test_imask.S  |  0
 tests/tcg/tricore/{ => asm}/test_insert.S |  0
 tests/tcg/tricore/{ => asm}/test_ld_bu.S  |  0
 tests/tcg/tricore/{ => asm}/test_ld_h.S   |  0
 tests/tcg/tricore/{ => asm}/test_madd.S   |  0
 tests/tcg/tricore/{ => asm}/test_msub.S   |  0
 tests/tcg/tricore/{ => asm}/test_muls.S   |  0
 17 files changed, 18 insertions(+), 17 deletions(-)
 rename tests/tcg/tricore/{ => asm}/macros.h (100%)
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
 rename tests/tcg/tricore/{ => asm}/test_ld_bu.S (100%)
 rename tests/tcg/tricore/{ => asm}/test_ld_h.S (100%)
 rename tests/tcg/tricore/{ => asm}/test_madd.S (100%)
 rename tests/tcg/tricore/{ => asm}/test_msub.S (100%)
 rename tests/tcg/tricore/{ => asm}/test_muls.S (100%)

diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
index b3cd56fffc..ad90a3b46f 100644
--- a/tests/tcg/tricore/Makefile.softmmu-target
+++ b/tests/tcg/tricore/Makefile.softmmu-target
@@ -1,31 +1,32 @@
 TESTS_PATH = $(SRC_PATH)/tests/tcg/tricore
+ASM_TESTS_PATH = $(TESTS_PATH)/asm
 
 LDFLAGS = -T$(TESTS_PATH)/link.ld --mcpu=tc162
 ASFLAGS = -mtc162
 
-TESTS += test_abs.tst
-TESTS += test_bmerge.tst
-TESTS += test_clz.tst
-TESTS += test_dextr.tst
-TESTS += test_dvstep.tst
-TESTS += test_fadd.tst
-TESTS += test_fmul.tst
-TESTS += test_ftoi.tst
-TESTS += test_imask.tst
-TESTS += test_insert.tst
-TESTS += test_ld_bu.tst
-TESTS += test_ld_h.tst
-TESTS += test_madd.tst
-TESTS += test_msub.tst
-TESTS += test_muls.tst
+TESTS += test_abs.asm.tst
+TESTS += test_bmerge.asm.tst
+TESTS += test_clz.asm.tst
+TESTS += test_dextr.asm.tst
+TESTS += test_dvstep.asm.tst
+TESTS += test_fadd.asm.tst
+TESTS += test_fmul.asm.tst
+TESTS += test_ftoi.asm.tst
+TESTS += test_imask.asm.tst
+TESTS += test_insert.asm.tst
+TESTS += test_ld_bu.asm.tst
+TESTS += test_ld_h.asm.tst
+TESTS += test_madd.asm.tst
+TESTS += test_msub.asm.tst
+TESTS += test_muls.asm.tst
 
 QEMU_OPTS += -M tricore_testboard -cpu tc27x -nographic -kernel
 
-%.pS: $(TESTS_PATH)/%.S
+%.pS: $(ASM_TESTS_PATH)/%.S
 	$(HOST_CC) -E -o $@ $<
 
 %.o: %.pS
 	$(AS) $(ASFLAGS) -o $@ $<
 
-%.tst: %.o
+%.asm.tst: %.o
 	$(LD) $(LDFLAGS) $< -o $@
diff --git a/tests/tcg/tricore/macros.h b/tests/tcg/tricore/asm/macros.h
similarity index 100%
rename from tests/tcg/tricore/macros.h
rename to tests/tcg/tricore/asm/macros.h
diff --git a/tests/tcg/tricore/test_abs.S b/tests/tcg/tricore/asm/test_abs.S
similarity index 100%
rename from tests/tcg/tricore/test_abs.S
rename to tests/tcg/tricore/asm/test_abs.S
diff --git a/tests/tcg/tricore/test_bmerge.S b/tests/tcg/tricore/asm/test_bmerge.S
similarity index 100%
rename from tests/tcg/tricore/test_bmerge.S
rename to tests/tcg/tricore/asm/test_bmerge.S
diff --git a/tests/tcg/tricore/test_clz.S b/tests/tcg/tricore/asm/test_clz.S
similarity index 100%
rename from tests/tcg/tricore/test_clz.S
rename to tests/tcg/tricore/asm/test_clz.S
diff --git a/tests/tcg/tricore/test_dextr.S b/tests/tcg/tricore/asm/test_dextr.S
similarity index 100%
rename from tests/tcg/tricore/test_dextr.S
rename to tests/tcg/tricore/asm/test_dextr.S
diff --git a/tests/tcg/tricore/test_dvstep.S b/tests/tcg/tricore/asm/test_dvstep.S
similarity index 100%
rename from tests/tcg/tricore/test_dvstep.S
rename to tests/tcg/tricore/asm/test_dvstep.S
diff --git a/tests/tcg/tricore/test_fadd.S b/tests/tcg/tricore/asm/test_fadd.S
similarity index 100%
rename from tests/tcg/tricore/test_fadd.S
rename to tests/tcg/tricore/asm/test_fadd.S
diff --git a/tests/tcg/tricore/test_fmul.S b/tests/tcg/tricore/asm/test_fmul.S
similarity index 100%
rename from tests/tcg/tricore/test_fmul.S
rename to tests/tcg/tricore/asm/test_fmul.S
diff --git a/tests/tcg/tricore/test_ftoi.S b/tests/tcg/tricore/asm/test_ftoi.S
similarity index 100%
rename from tests/tcg/tricore/test_ftoi.S
rename to tests/tcg/tricore/asm/test_ftoi.S
diff --git a/tests/tcg/tricore/test_imask.S b/tests/tcg/tricore/asm/test_imask.S
similarity index 100%
rename from tests/tcg/tricore/test_imask.S
rename to tests/tcg/tricore/asm/test_imask.S
diff --git a/tests/tcg/tricore/test_insert.S b/tests/tcg/tricore/asm/test_insert.S
similarity index 100%
rename from tests/tcg/tricore/test_insert.S
rename to tests/tcg/tricore/asm/test_insert.S
diff --git a/tests/tcg/tricore/test_ld_bu.S b/tests/tcg/tricore/asm/test_ld_bu.S
similarity index 100%
rename from tests/tcg/tricore/test_ld_bu.S
rename to tests/tcg/tricore/asm/test_ld_bu.S
diff --git a/tests/tcg/tricore/test_ld_h.S b/tests/tcg/tricore/asm/test_ld_h.S
similarity index 100%
rename from tests/tcg/tricore/test_ld_h.S
rename to tests/tcg/tricore/asm/test_ld_h.S
diff --git a/tests/tcg/tricore/test_madd.S b/tests/tcg/tricore/asm/test_madd.S
similarity index 100%
rename from tests/tcg/tricore/test_madd.S
rename to tests/tcg/tricore/asm/test_madd.S
diff --git a/tests/tcg/tricore/test_msub.S b/tests/tcg/tricore/asm/test_msub.S
similarity index 100%
rename from tests/tcg/tricore/test_msub.S
rename to tests/tcg/tricore/asm/test_msub.S
diff --git a/tests/tcg/tricore/test_muls.S b/tests/tcg/tricore/asm/test_muls.S
similarity index 100%
rename from tests/tcg/tricore/test_muls.S
rename to tests/tcg/tricore/asm/test_muls.S
-- 
2.40.1


