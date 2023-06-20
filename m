Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E68736363
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 08:03:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBUQl-0005TD-By; Tue, 20 Jun 2023 02:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rj0j=CI=kaod.org=clg@ozlabs.org>)
 id 1qBUP7-0004dG-Nw; Tue, 20 Jun 2023 01:59:52 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rj0j=CI=kaod.org=clg@ozlabs.org>)
 id 1qBUP1-0004Xq-Jw; Tue, 20 Jun 2023 01:59:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QlbZ22ZtKz4x09;
 Tue, 20 Jun 2023 15:59:38 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QlbYz2lJjz4x47;
 Tue, 20 Jun 2023 15:59:35 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 5/9] ppc/pegasos2: Report an error when run with KVM
Date: Tue, 20 Jun 2023 07:59:07 +0200
Message-ID: <20230620055911.187065-6-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620055911.187065-1-clg@kaod.org>
References: <20230620055911.187065-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=rj0j=CI=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

The 'pegasos2' machine never supported KVM. This piece of code was
inherited from another model.

Cc: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/pegasos2.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index af5489de26ed..830323cc7849 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -29,7 +29,6 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
-#include "kvm_ppc.h"
 #include "exec/address-spaces.h"
 #include "qom/qom-qobject.h"
 #include "qapi/qmp/qdict.h"
@@ -120,6 +119,12 @@ static void pegasos2_init(MachineState *machine)
     int i, sz;
     uint8_t *spd_data;
 
+    if (kvm_enabled()) {
+        error_report("machine %s does not support the KVM accelerator",
+                     MACHINE_GET_CLASS(machine)->name);
+        exit(EXIT_FAILURE);
+    }
+
     /* init CPU */
     pm->cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
     env = &pm->cpu->env;
-- 
2.41.0


