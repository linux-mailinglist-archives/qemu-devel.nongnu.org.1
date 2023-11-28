Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC1A7FC3DC
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 19:59:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r83Hr-0004gT-5G; Tue, 28 Nov 2023 13:58:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1r83Hn-0004dG-Ub
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 13:58:19 -0500
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1r83Hj-0002AV-Vb
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 13:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1701197890; bh=sMoVu7uQ8dHbztb7wdw3lpYIlILqgOLBOsviKbK4IzE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=EHPa4McEjPkquqwH+ZxD3nTj1Ry+/hW4WdzT75q6NglYSrW/+MnnR8pWxrImciZrR
 49+XdlKEnbKOW1niZX/ruEmwfwPaNYr/SOr6YTrc07a43BiwwEV2O1eUfir9JZp83N
 EYfGu5SyDeHZYrz8o+/CHkCTZqZOrvLh15851xq8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Tue, 28 Nov 2023 19:58:04 +0100
Subject: [PATCH v2 1/3] hw/misc/pvpanic: centralize definition of supported
 events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231128-pvpanic-shutdown-v2-1-830393b45cb6@t-8ch.de>
References: <20231128-pvpanic-shutdown-v2-0-830393b45cb6@t-8ch.de>
In-Reply-To: <20231128-pvpanic-shutdown-v2-0-830393b45cb6@t-8ch.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701197889; l=3171;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=sMoVu7uQ8dHbztb7wdw3lpYIlILqgOLBOsviKbK4IzE=;
 b=rJod/pMsJ1Vi0abx0EOoFn6LQGBSgRwROWxjjcR1dpwFzvA1kRQXJaa5bQ9z9h9SWMjG51LbY
 eRwrFQso94iCUAq9gi+Q6Cr6o2Itk8ukhNtlscD6584GSeH7nd8vTVu
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=2a01:4f8:c010:41de::1;
 envelope-from=thomas@t-8ch.de; helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The different components of pvpanic duplicate the list of supported
events. Move it to the shared header file to minimize changes when new
events are added.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 hw/misc/pvpanic-isa.c     | 3 +--
 hw/misc/pvpanic-pci.c     | 3 +--
 hw/misc/pvpanic.c         | 3 +--
 include/hw/misc/pvpanic.h | 2 ++
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/misc/pvpanic-isa.c b/hw/misc/pvpanic-isa.c
index ccec50f61bbd..9a923b786907 100644
--- a/hw/misc/pvpanic-isa.c
+++ b/hw/misc/pvpanic-isa.c
@@ -21,7 +21,6 @@
 #include "hw/misc/pvpanic.h"
 #include "qom/object.h"
 #include "hw/isa/isa.h"
-#include "standard-headers/linux/pvpanic.h"
 #include "hw/acpi/acpi_aml_interface.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(PVPanicISAState, PVPANIC_ISA_DEVICE)
@@ -102,7 +101,7 @@ static void build_pvpanic_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
 static Property pvpanic_isa_properties[] = {
     DEFINE_PROP_UINT16(PVPANIC_IOPORT_PROP, PVPanicISAState, ioport, 0x505),
     DEFINE_PROP_UINT8("events", PVPanicISAState, pvpanic.events,
-                      PVPANIC_PANICKED | PVPANIC_CRASH_LOADED),
+                      PVPANIC_EVENTS),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/misc/pvpanic-pci.c b/hw/misc/pvpanic-pci.c
index fbcaa50731b3..8898d280d2ef 100644
--- a/hw/misc/pvpanic-pci.c
+++ b/hw/misc/pvpanic-pci.c
@@ -21,7 +21,6 @@
 #include "hw/misc/pvpanic.h"
 #include "qom/object.h"
 #include "hw/pci/pci_device.h"
-#include "standard-headers/linux/pvpanic.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(PVPanicPCIState, PVPANIC_PCI_DEVICE)
 
@@ -55,7 +54,7 @@ static void pvpanic_pci_realizefn(PCIDevice *dev, Error **errp)
 
 static Property pvpanic_pci_properties[] = {
     DEFINE_PROP_UINT8("events", PVPanicPCIState, pvpanic.events,
-                      PVPANIC_PANICKED | PVPANIC_CRASH_LOADED),
+                      PVPANIC_EVENTS),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 1540e9091a45..a4982cc5928e 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -21,13 +21,12 @@
 #include "hw/qdev-properties.h"
 #include "hw/misc/pvpanic.h"
 #include "qom/object.h"
-#include "standard-headers/linux/pvpanic.h"
 
 static void handle_event(int event)
 {
     static bool logged;
 
-    if (event & ~(PVPANIC_PANICKED | PVPANIC_CRASH_LOADED) && !logged) {
+    if (event & ~PVPANIC_EVENTS && !logged) {
         qemu_log_mask(LOG_GUEST_ERROR, "pvpanic: unknown event %#x.\n", event);
         logged = true;
     }
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index fab94165d03d..198047dc86ff 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -17,11 +17,13 @@
 
 #include "exec/memory.h"
 #include "qom/object.h"
+#include "standard-headers/linux/pvpanic.h"
 
 #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
 #define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"
 
 #define PVPANIC_IOPORT_PROP "ioport"
+#define PVPANIC_EVENTS (PVPANIC_PANICKED | PVPANIC_CRASH_LOADED)
 
 /*
  * PVPanicState for any device type

-- 
2.43.0


