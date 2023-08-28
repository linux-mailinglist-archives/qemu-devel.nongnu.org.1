Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 341A578AECC
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 13:28:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaaOq-0008CF-R4; Mon, 28 Aug 2023 07:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qaaOg-00086D-3z
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 07:27:06 -0400
Received: from collins.uni-paderborn.de ([2001:638:502:c003::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qaaOd-0002eS-Ck
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 07:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dGE9TeJOX796Bu006/g7Lvog0itUkw50AXldm4OHUTY=; b=N7col7WVbBwxVdN16+/LEJ7T9L
 J/xczFjZH0teJdGWja+PHNhL4RCt+j3qqKNzxv33n60FHhNPLXEHgP62zc0/m0UHg5AZCV8b5Q6Ry
 wYEBWWBtbleoKjcVok/hpe2wYi6kzqpKekYtdA+ExrncAoXy9Y/GrCzt3GbZd2jYAviU=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me, richard.henderson@linaro.org,
 kbastian@mail.uni-paderborn.de
Subject: [PATCH v2 01/11] tests/tcg/tricore: Bump cpu to tc37x
Date: Mon, 28 Aug 2023 13:26:41 +0200
Message-ID: <20230828112651.522058-2-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828112651.522058-1-kbastian@mail.uni-paderborn.de>
References: <20230828112651.522058-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.8.28.111817, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.8.20.602000
X-Sophos-SenderHistory: ip=84.184.52.128, fs=17265232, da=180831084, mc=24,
 sc=0, hc=24, sp=0, fso=17265232, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::14;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=collins.uni-paderborn.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

we don't want to exclude ISA v1.6.2 insns from our tests.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 tests/tcg/tricore/Makefile.softmmu-target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
index aff7c1b580..f8fd207921 100644
--- a/tests/tcg/tricore/Makefile.softmmu-target
+++ b/tests/tcg/tricore/Makefile.softmmu-target
@@ -25,7 +25,7 @@ TESTS += test_muls.asm.tst
 TESTS += test_boot_to_main.c.tst
 TESTS += test_context_save_areas.c.tst
 
-QEMU_OPTS += -M tricore_testboard -cpu tc27x -nographic -kernel
+QEMU_OPTS += -M tricore_testboard -cpu tc37x -nographic -kernel
 
 %.pS: $(ASM_TESTS_PATH)/%.S
 	$(HOST_CC) -E -o $@ $<
-- 
2.41.0


