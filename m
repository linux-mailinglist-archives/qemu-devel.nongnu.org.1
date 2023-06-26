Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C66CA73D78F
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:08:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDfDr-0003HY-AX; Mon, 26 Jun 2023 01:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfDo-0003GW-9I; Mon, 26 Jun 2023 01:57:08 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfDm-0007BX-2B; Mon, 26 Jun 2023 01:57:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QqHDB26hzz4wb3;
 Mon, 26 Jun 2023 15:56:58 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqHD75LPFz4wZy;
 Mon, 26 Jun 2023 15:56:55 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 01/30] target/ppc: gdbstub init spr gdb_id for all CPUs
Date: Mon, 26 Jun 2023 07:56:18 +0200
Message-ID: <20230626055647.1147743-2-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626055647.1147743-1-clg@kaod.org>
References: <20230626055647.1147743-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

Make sure each CPU gets its state set up for gdb, not just the ones
before PowerPCCPUClass has had its gdb state set up.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 target/ppc/gdbstub.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 63c9abe4f1b7..ca39efdc357a 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -327,6 +327,25 @@ void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu)
     unsigned int num_regs = 0;
     int i;
 
+    for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
+        ppc_spr_t *spr = &env->spr_cb[i];
+
+        if (!spr->name) {
+            continue;
+        }
+
+        /*
+         * GDB identifies registers based on the order they are
+         * presented in the XML. These ids will not match QEMU's
+         * representation (which follows the PowerISA).
+         *
+         * Store the position of the current register description so
+         * we can make the correspondence later.
+         */
+        spr->gdb_id = num_regs;
+        num_regs++;
+    }
+
     if (pcc->gdb_spr_xml) {
         return;
     }
@@ -348,17 +367,6 @@ void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu)
 
         g_string_append_printf(xml, " bitsize=\"%d\"", TARGET_LONG_BITS);
         g_string_append(xml, " group=\"spr\"/>");
-
-        /*
-         * GDB identifies registers based on the order they are
-         * presented in the XML. These ids will not match QEMU's
-         * representation (which follows the PowerISA).
-         *
-         * Store the position of the current register description so
-         * we can make the correspondence later.
-         */
-        spr->gdb_id = num_regs;
-        num_regs++;
     }
 
     g_string_append(xml, "</feature>");
-- 
2.41.0


