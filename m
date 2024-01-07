Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D299B82646B
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 15:06:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMTmH-0005tH-N3; Sun, 07 Jan 2024 09:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rMTm6-0005QK-8d
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 09:05:14 -0500
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rMTm3-0006uf-Ag
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 09:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1704636309; bh=ICmVck66OBSbszjlau4823eQU4dpI6J80LRnAzSkS5g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=f46jWA1sl+hnTtR4VRsKcVMoviCA+1/hV2JLZAaPWkpSw/vb/LThpyxHY2PZbSGRO
 fbyKuRlMkv+vefut/LGhTyzDeJKo0qSJe7DD0Gfr+D4hZSJPJPhwIxHJEw7vkYpeNz
 6/vYdGRQYXPlWgNg8Ju2jR7o1GtKdH0tyuQZ/YmY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Sun, 07 Jan 2024 15:05:09 +0100
Subject: [PATCH v4 2/4] hw/misc/pvpanic: centralize definition of supported
 events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240107-pvpanic-shutdown-v4-2-81500a7e4081@t-8ch.de>
References: <20240107-pvpanic-shutdown-v4-0-81500a7e4081@t-8ch.de>
In-Reply-To: <20240107-pvpanic-shutdown-v4-0-81500a7e4081@t-8ch.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704636308; l=2424;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=ICmVck66OBSbszjlau4823eQU4dpI6J80LRnAzSkS5g=;
 b=0LbJ69wlJLgjJ8shHEVOwrASAeHpQMG5tFIrWgQxahP2FKHoiHdl7P9pxNeJ8Qun5rps0o3QO
 7k/j/zI5aZ1C/qVx8taei8wOAbKup11iNPvQpIuhCArVOriF9tGt4LU
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
 hw/misc/pvpanic-isa.c     | 2 +-
 hw/misc/pvpanic-pci.c     | 2 +-
 hw/misc/pvpanic.c         | 2 +-
 include/hw/misc/pvpanic.h | 1 +
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/misc/pvpanic-isa.c b/hw/misc/pvpanic-isa.c
index ef438a31fbe9..9a923b786907 100644
--- a/hw/misc/pvpanic-isa.c
+++ b/hw/misc/pvpanic-isa.c
@@ -101,7 +101,7 @@ static void build_pvpanic_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
 static Property pvpanic_isa_properties[] = {
     DEFINE_PROP_UINT16(PVPANIC_IOPORT_PROP, PVPanicISAState, ioport, 0x505),
     DEFINE_PROP_UINT8("events", PVPanicISAState, pvpanic.events,
-                      PVPANIC_PANICKED | PVPANIC_CRASH_LOADED),
+                      PVPANIC_EVENTS),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/misc/pvpanic-pci.c b/hw/misc/pvpanic-pci.c
index 01e269b55284..be4063121e1d 100644
--- a/hw/misc/pvpanic-pci.c
+++ b/hw/misc/pvpanic-pci.c
@@ -54,7 +54,7 @@ static void pvpanic_pci_realizefn(PCIDevice *dev, Error **errp)
 
 static Property pvpanic_pci_properties[] = {
     DEFINE_PROP_UINT8("events", PVPanicPCIState, pvpanic.events,
-                      PVPANIC_PANICKED | PVPANIC_CRASH_LOADED),
+                      PVPANIC_EVENTS),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 4915ef256e74..a4982cc5928e 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -26,7 +26,7 @@ static void handle_event(int event)
 {
     static bool logged;
 
-    if (event & ~(PVPANIC_PANICKED | PVPANIC_CRASH_LOADED) && !logged) {
+    if (event & ~PVPANIC_EVENTS && !logged) {
         qemu_log_mask(LOG_GUEST_ERROR, "pvpanic: unknown event %#x.\n", event);
         logged = true;
     }
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index dffca827f77a..48f2ec4c86a1 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -20,6 +20,7 @@
 
 #define PVPANIC_PANICKED	(1 << 0)
 #define PVPANIC_CRASH_LOADED	(1 << 1)
+#define PVPANIC_EVENTS (PVPANIC_PANICKED | PVPANIC_CRASH_LOADED)
 
 #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
 #define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"

-- 
2.43.0


