Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 902798139CA
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 19:18:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDqHL-0001cX-MB; Thu, 14 Dec 2023 13:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=iKBM=HZ=kaod.org=clg@ozlabs.org>)
 id 1rDqHG-0001bp-TJ; Thu, 14 Dec 2023 13:17:42 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=iKBM=HZ=kaod.org=clg@ozlabs.org>)
 id 1rDqHE-0000p9-E9; Thu, 14 Dec 2023 13:17:41 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SrgYq1LdCz4xGC;
 Fri, 15 Dec 2023 05:17:35 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SrgYl0BCbz4wdB;
 Fri, 15 Dec 2023 05:17:30 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2] spapr: Tag pseries-2.1 - 2.11 machines as deprecated
Date: Thu, 14 Dec 2023 19:17:23 +0100
Message-ID: <20231214181723.1520854-1-clg@kaod.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=iKBM=HZ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

pseries machines before version 2.11 have undergone many changes to
correct issues, mostly regarding migration compatibility. This is
obfuscating the code uselessly and makes maintenance more difficult.
Remove them and only keep the last version of the 2.x series, 2.12,
still in use by old distros.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 docs/about/deprecated.rst | 7 +++++++
 hw/ppc/spapr.c            | 1 +
 2 files changed, 8 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 2e1504024658..c0e22b2b568f 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -269,6 +269,13 @@ Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (since 8.2)
 
 The Nios II architecture is orphan.
 
+``pseries-2.1`` up to ``pseries-2.11`` (since 9.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Older pseries machines before version 2.12 have undergone many changes
+to correct issues, mostly regarding migration compatibility. These are
+no longer maintained and removing them will make the code easier to
+read and maintain. Use versions 2.12 and above as a replacement.
 
 Backend options
 ---------------
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index df09aa9d6a00..5034461399d2 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5083,6 +5083,7 @@ static void spapr_machine_2_11_class_options(MachineClass *mc)
     spapr_machine_2_12_class_options(mc);
     smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_ON;
     compat_props_add(mc->compat_props, hw_compat_2_11, hw_compat_2_11_len);
+    mc->deprecation_reason = "old and not maintained - use a 2.12+ version";
 }
 
 DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
-- 
2.43.0


