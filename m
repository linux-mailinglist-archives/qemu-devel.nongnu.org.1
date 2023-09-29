Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 072D57B2C7B
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 08:41:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm7BB-0005hM-ON; Fri, 29 Sep 2023 02:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qm7Az-0005ey-TU
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:40:39 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qm7Aj-0007Ku-Vi
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b5I1dbiEujj3bnPrvclDUc5hYSsrMePBI6m5GKX/TCs=; b=YI3gPj0iUzVSV1i76n1+xsGh1C
 GYWVbsIx0DCx3p6CffgKyWP2IKuTVd79nUkfYDDGUChdZS83B8PAxdMcvNgz7+JDxhKpvgUt3Dmtr
 xMe0wkk+lbfltO+qmlOwb3T5CIU5smEYNProVOCS6iIVWIJGgmrxE/g0E61jNZsVEEE4=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v3 01/16] tests/tcg/tricore: Bump cpu to tc37x
Date: Fri, 29 Sep 2023 08:39:45 +0200
Message-ID: <20230929064000.536923-2-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929064000.536923-1-kbastian@mail.uni-paderborn.de>
References: <20230929064000.536923-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.29.63017, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.26.602000
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::17;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=zuban.uni-paderborn.de
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

we don't want to exclude ISA v1.6.2 insns from our tests.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-Id: <20230828112651.522058-2-kbastian@mail.uni-paderborn.de>
---
 tests/tcg/tricore/Makefile.softmmu-target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
index 2ec0bd3622..d556201b07 100644
--- a/tests/tcg/tricore/Makefile.softmmu-target
+++ b/tests/tcg/tricore/Makefile.softmmu-target
@@ -25,7 +25,7 @@ TESTS += test_muls.asm.tst
 TESTS += test_boot_to_main.c.tst
 TESTS += test_context_save_areas.c.tst
 
-QEMU_OPTS += -M tricore_testboard -cpu tc27x -nographic -kernel
+QEMU_OPTS += -M tricore_testboard -cpu tc37x -nographic -kernel
 
 %.pS: $(ASM_TESTS_PATH)/%.S
 	$(CC) -E -o $@ $<
-- 
2.42.0


