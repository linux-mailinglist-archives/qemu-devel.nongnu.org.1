Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B16D87B2DDE
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:32:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm8ur-0006rr-Ha; Fri, 29 Sep 2023 04:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Yu9m=FN=kaod.org=clg@ozlabs.org>)
 id 1qm8um-0006rX-Cf; Fri, 29 Sep 2023 04:32:00 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Yu9m=FN=kaod.org=clg@ozlabs.org>)
 id 1qm8uk-0000lG-K6; Fri, 29 Sep 2023 04:32:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rxk9043Yfz4x3H;
 Fri, 29 Sep 2023 18:31:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rxk8y1PQ0z4x5J;
 Fri, 29 Sep 2023 18:31:45 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2] target/ppc: Rename variables to avoid local variable
 shadowing in VUPKPX
Date: Fri, 29 Sep 2023 10:31:43 +0200
Message-ID: <20230929083143.234553-1-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Yu9m=FN=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

and fix such warnings :

  ../target/ppc/int_helper.c: In function ‘helper_vupklpx’:
  ../target/ppc/int_helper.c:2025:21: warning: declaration of ‘r’ shadows a parameter [-Wshadow=local]
   2025 |             uint8_t r = (e >> 10) & 0x1f;                               \
        |                     ^
  ../target/ppc/int_helper.c:2033:1: note: in expansion of macro ‘VUPKPX’
   2033 | VUPKPX(lpx, UPKLO)
        | ^~~~~~
  ../target/ppc/int_helper.c:2017:41: note: shadowed declaration is here
   2017 |     void helper_vupk##suffix(ppc_avr_t *r, ppc_avr_t *b)                \
        |                              ~~~~~~~~~~~^
  ../target/ppc/int_helper.c:2033:1: note: in expansion of macro ‘VUPKPX’
   2033 | VUPKPX(lpx, UPKLO)
        | ^~~~~~

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---

 v2: changed all locals to start with '_' (Michael)

 target/ppc/int_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 6fd00684a5b9..0a5c3e78a413 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2020,13 +2020,13 @@ void helper_vsum4ubs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
         ppc_avr_t result;                                               \
                                                                         \
         for (i = 0; i < ARRAY_SIZE(r->u32); i++) {                      \
-            uint16_t e = b->u16[hi ? i : i + 4];                        \
-            uint8_t a = (e >> 15) ? 0xff : 0;                           \
-            uint8_t r = (e >> 10) & 0x1f;                               \
-            uint8_t g = (e >> 5) & 0x1f;                                \
-            uint8_t b = e & 0x1f;                                       \
+            uint16_t _e = b->u16[hi ? i : i + 4];                       \
+            uint8_t _a = (_e >> 15) ? 0xff : 0;                         \
+            uint8_t _r = (_e >> 10) & 0x1f;                             \
+            uint8_t _g = (_e >> 5) & 0x1f;                              \
+            uint8_t _b = _e & 0x1f;                                     \
                                                                         \
-            result.u32[i] = (a << 24) | (r << 16) | (g << 8) | b;       \
+            result.u32[i] = (_a << 24) | (_r << 16) | (_g << 8) | _b;   \
         }                                                               \
         *r = result;                                                    \
     }
-- 
2.41.0


