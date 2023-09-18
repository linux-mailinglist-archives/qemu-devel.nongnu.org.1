Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 851E37A4B5E
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 17:01:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFjE-0000TS-Um; Mon, 18 Sep 2023 11:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=KtGU=FC=kaod.org=clg@ozlabs.org>)
 id 1qiFj1-0000H8-Au; Mon, 18 Sep 2023 10:59:49 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=KtGU=FC=kaod.org=clg@ozlabs.org>)
 id 1qiFiv-00062b-5J; Mon, 18 Sep 2023 10:59:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rq7HV1hGTz4xPN;
 Tue, 19 Sep 2023 00:59:34 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rq7HR54bCz4xPQ;
 Tue, 19 Sep 2023 00:59:31 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 7/8] spapr/pci: Clean up local variable shadowing in
 spapr_phb_realize()
Date: Mon, 18 Sep 2023 16:58:49 +0200
Message-ID: <20230918145850.241074-8-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918145850.241074-1-clg@kaod.org>
References: <20230918145850.241074-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=KtGU=FC=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Rename SysBusDevice variable to avoid this warning :

  ../hw/ppc/spapr_pci.c: In function ‘spapr_phb_realize’:
  ../hw/ppc/spapr_pci.c:1872:24: warning: declaration of ‘s’ shadows a previous local [-Wshadow=local]
   1872 |         SpaprPhbState *s;
        |                        ^
  ../hw/ppc/spapr_pci.c:1829:19: note: shadowed declaration is here
   1829 |     SysBusDevice *s = SYS_BUS_DEVICE(dev);
        |                   ^

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index ce1495931744..370c5a90f218 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1826,9 +1826,9 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
         (SpaprMachineState *) object_dynamic_cast(qdev_get_machine(),
                                                   TYPE_SPAPR_MACHINE);
     SpaprMachineClass *smc = spapr ? SPAPR_MACHINE_GET_CLASS(spapr) : NULL;
-    SysBusDevice *s = SYS_BUS_DEVICE(dev);
-    SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(s);
-    PCIHostState *phb = PCI_HOST_BRIDGE(s);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(sbd);
+    PCIHostState *phb = PCI_HOST_BRIDGE(sbd);
     MachineState *ms = MACHINE(spapr);
     char *namebuf;
     int i;
-- 
2.41.0


