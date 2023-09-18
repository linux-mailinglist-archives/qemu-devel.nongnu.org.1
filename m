Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C997D7A4B5B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 17:01:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFjB-0000Om-DW; Mon, 18 Sep 2023 10:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=KtGU=FC=kaod.org=clg@ozlabs.org>)
 id 1qiFir-0000Er-Tj; Mon, 18 Sep 2023 10:59:38 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=KtGU=FC=kaod.org=clg@ozlabs.org>)
 id 1qiFiY-0005zX-Cc; Mon, 18 Sep 2023 10:59:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rq7H80RMJz4xM1;
 Tue, 19 Sep 2023 00:59:16 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rq7H53WXFz4xM6;
 Tue, 19 Sep 2023 00:59:13 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 1/8] hw/ppc: Clean up local variable shadowing in _FDT helper
 routine
Date: Mon, 18 Sep 2023 16:58:43 +0200
Message-ID: <20230918145850.241074-2-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918145850.241074-1-clg@kaod.org>
References: <20230918145850.241074-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=KtGU=FC=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

this fixes numerous warnings of this type :

  In file included from ../hw/ppc/spapr_pci.c:43:
  ../hw/ppc/spapr_pci.c: In function ‘spapr_dt_phb’:
  ../include/hw/ppc/fdt.h:18:13: warning: declaration of ‘ret’ shadows a previous local [-Wshadow=compatible-local]
     18 |         int ret = (exp);                                           \
        |             ^~~
  ../hw/ppc/spapr_pci.c:2355:5: note: in expansion of macro ‘_FDT’
   2355 |     _FDT(bus_off = fdt_add_subnode(fdt, 0, phb->dtbusname));
        |     ^~~~
  ../hw/ppc/spapr_pci.c:2311:24: note: shadowed declaration is here
   2311 |     int bus_off, i, j, ret;
        |                        ^~~

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ppc/fdt.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/fdt.h b/include/hw/ppc/fdt.h
index a8cd85069fe0..b56ac2a8cbb5 100644
--- a/include/hw/ppc/fdt.h
+++ b/include/hw/ppc/fdt.h
@@ -15,10 +15,10 @@
 
 #define _FDT(exp)                                                  \
     do {                                                           \
-        int ret = (exp);                                           \
-        if (ret < 0) {                                             \
-            error_report("error creating device tree: %s: %s",   \
-                    #exp, fdt_strerror(ret));                      \
+        int _ret = (exp);                                          \
+        if (_ret < 0) {                                            \
+            error_report("error creating device tree: %s: %s",     \
+                    #exp, fdt_strerror(_ret));                     \
             exit(1);                                               \
         }                                                          \
     } while (0)
-- 
2.41.0


