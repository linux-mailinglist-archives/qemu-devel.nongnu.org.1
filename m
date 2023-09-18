Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0A47A4B5A
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 17:01:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFjC-0000Re-Hy; Mon, 18 Sep 2023 10:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=KtGU=FC=kaod.org=clg@ozlabs.org>)
 id 1qiFis-0000Ev-A7; Mon, 18 Sep 2023 10:59:38 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=KtGU=FC=kaod.org=clg@ozlabs.org>)
 id 1qiFid-000618-0O; Mon, 18 Sep 2023 10:59:25 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rq7HC0n3Fz4xM6;
 Tue, 19 Sep 2023 00:59:19 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rq7H841WHz4xM7;
 Tue, 19 Sep 2023 00:59:16 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 2/8] pnv/psi: Clean up local variable shadowing
Date: Mon, 18 Sep 2023 16:58:44 +0200
Message-ID: <20230918145850.241074-3-clg@kaod.org>
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

to fix :

  ../hw/ppc/pnv_psi.c: In function ‘pnv_psi_p9_mmio_write’:
  ../hw/ppc/pnv_psi.c:741:24: warning: declaration of ‘addr’ shadows a parameter [-Wshadow=compatible-local]
    741 |                 hwaddr addr = val & ~(PSIHB9_ESB_CI_VALID | PSIHB10_ESB_CI_64K);
        |                        ^~~~
  ../hw/ppc/pnv_psi.c:702:56: note: shadowed declaration is here
    702 | static void pnv_psi_p9_mmio_write(void *opaque, hwaddr addr,
        |                                                 ~~~~~~~^~~~

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv_psi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index daaa2f0575fd..26460d210deb 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -738,8 +738,9 @@ static void pnv_psi_p9_mmio_write(void *opaque, hwaddr addr,
             }
         } else {
             if (!(psi->regs[reg] & PSIHB9_ESB_CI_VALID)) {
-                hwaddr addr = val & ~(PSIHB9_ESB_CI_VALID | PSIHB10_ESB_CI_64K);
-                memory_region_add_subregion(sysmem, addr,
+                hwaddr esb_addr =
+                    val & ~(PSIHB9_ESB_CI_VALID | PSIHB10_ESB_CI_64K);
+                memory_region_add_subregion(sysmem, esb_addr,
                                             &psi9->source.esb_mmio);
             }
         }
-- 
2.41.0


