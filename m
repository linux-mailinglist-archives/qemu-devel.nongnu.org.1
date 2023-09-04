Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6225D791450
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:07:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5Xu-0001G3-OH; Mon, 04 Sep 2023 05:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Xp-000187-44; Mon, 04 Sep 2023 05:06:53 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Xk-0003cB-LT; Mon, 04 Sep 2023 05:06:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN6q5sQDz4x09;
 Mon,  4 Sep 2023 19:06:43 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN6n5BHPz4wy1;
 Mon,  4 Sep 2023 19:06:41 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 02/35] ppc: Add stub implementation of TRIG SPRs
Date: Mon,  4 Sep 2023 11:05:57 +0200
Message-ID: <20230904090630.725952-3-clg@kaod.org>
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

From: Joel Stanley <joel@jms.id.au>

Linux sets these to control cache flush behaviour on Power9. Supervisor
and hypervisor are allowed to write, and reads are noops.

Add implementations to avoid noisy messages when booting Linux under the
pseries machine with guest_errors enabled.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h      |  2 ++
 target/ppc/cpu_init.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 25fac9577aa4..6826702ea658 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1897,7 +1897,9 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_PSSCR             (0x357)
 #define SPR_440_INV0          (0x370)
 #define SPR_440_INV1          (0x371)
+#define SPR_TRIG1             (0x371)
 #define SPR_440_INV2          (0x372)
+#define SPR_TRIG2             (0x372)
 #define SPR_440_INV3          (0x373)
 #define SPR_440_ITV0          (0x374)
 #define SPR_440_ITV1          (0x375)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 02b7aad9b0e3..3b6ccb5ea4e6 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5660,6 +5660,16 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_tfmr, &spr_write_tfmr,
                  0x00000000);
+    spr_register_hv(env, SPR_TRIG1, "TRIG1",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_access_nop, &spr_write_generic,
+                 &spr_access_nop, &spr_write_generic,
+                 0x00000000);
+    spr_register_hv(env, SPR_TRIG2, "TRIG2",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_access_nop, &spr_write_generic,
+                 &spr_access_nop, &spr_write_generic,
+                 0x00000000);
 #endif
 }
 
-- 
2.41.0


