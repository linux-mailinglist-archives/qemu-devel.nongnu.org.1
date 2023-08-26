Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0277897F3
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Aug 2023 18:05:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZvkm-0006WG-PC; Sat, 26 Aug 2023 12:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qZvkk-0006Ux-6t
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 12:03:10 -0400
Received: from hoth.uni-paderborn.de ([2001:638:502:c003::19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qZvkf-0007rD-EL
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 12:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6I4T7waPEo9Cc64H5v1nJ/gxJwF9LyKlrSPxpzxVqg0=; b=uAXyelHltDmoXUga7KEt4tQU/D
 cYwvlnuPi5fEmyzJ2LejKgfBERAe4M6zzvOUYQljw6nUy/tJycntoMyNHe32/6ASaQZfbvzm4Iorg
 ktARqYUAx6Jz8c8lD9/DFmhDfw80teu96KU6+RgOA1bUQBfqB5c+1/Hn7TjDdP/fTdac=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me,
	kbastian@mail.uni-paderborn.de
Subject: [PATCH 01/10] tests/tcg/tricore: Bump cpu to tc37x
Date: Sat, 26 Aug 2023 18:02:33 +0200
Message-ID: <20230826160242.312052-2-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.8.26.155417, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.8.20.602000
X-Sophos-SenderHistory: ip=84.184.52.128, fs=17108991, da=180674843, mc=9, sc=0,
 hc=9, sp=0, fso=17108991, re=0, sd=0, hd=0
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

we don't want to exclude ISA v1.6.2 insns from our tests.

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


