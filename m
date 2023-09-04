Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7FF791484
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:12:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5YQ-0002Vo-5g; Mon, 04 Sep 2023 05:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5YN-0002K7-FF; Mon, 04 Sep 2023 05:07:28 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5YL-0003pd-1g; Mon, 04 Sep 2023 05:07:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN7Z5PvDz4wxN;
 Mon,  4 Sep 2023 19:07:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN7X6ZL4z4wy1;
 Mon,  4 Sep 2023 19:07:20 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 18/35] target/ppc: Migrate DECR SPR
Date: Mon,  4 Sep 2023 11:06:13 +0200
Message-ID: <20230904090630.725952-19-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904090630.725952-1-clg@kaod.org>
References: <20230904090630.725952-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=kZzc=EU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

TCG does not maintain the DEC reigster in the SPR array, so it does get
migrated. TCG also needs to re-start the decrementer timer on the
destination machine.

Load and store the decrementer into the SPR when migrating. This works
for the level-triggered (book3s) decrementer, and should be compatible
with existing KVM machines that do keep the DEC value there.

This fixes lost decrementer interrupt on migration that can cause
hangs, as well as other problems including record-replay bugs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 target/ppc/machine.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 8234e35d69f8..8a190c485363 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -209,6 +209,14 @@ static int cpu_pre_save(void *opaque)
     /* Used to retain migration compatibility for pre 6.0 for 601 machines. */
     env->hflags_compat_nmsr = 0;
 
+    if (tcg_enabled()) {
+        /*
+         * TCG does not maintain the DECR spr (unlike KVM) so have to save
+         * it here.
+         */
+        env->spr[SPR_DECR] = cpu_ppc_load_decr(env);
+    }
+
     return 0;
 }
 
@@ -319,6 +327,12 @@ static int cpu_post_load(void *opaque, int version_id)
         ppc_update_ciabr(env);
         ppc_update_daw0(env);
 #endif
+        /*
+         * TCG needs to re-start the decrementer timer and/or raise the
+         * interrupt. This works for level-triggered decrementer. Edge
+         * triggered types (including HDEC) would need to carry more state.
+         */
+        cpu_ppc_store_decr(env, env->spr[SPR_DECR]);
         pmu_mmcr01_updated(env);
     }
 
-- 
2.41.0


