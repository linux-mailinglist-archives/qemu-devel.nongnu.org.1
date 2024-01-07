Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA67F826470
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 15:06:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMTmG-0005hD-EI; Sun, 07 Jan 2024 09:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rMTm6-0005QL-8q
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 09:05:14 -0500
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rMTm3-0006uV-Dv
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 09:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1704636309; bh=hkWFoazCStKhexD0vSbfqqc3avb43oj4ZmJz8Qsbpmc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=in5IO91Zde07yfNjAgg/9ix32WBobUAM1pE6N2Dz+1ackBzR7mUBVwZ3a3TQ9wmOo
 NOk5w/76vgX4QODpFwADp4gyHgq7Kx6TLATSy2kUBv8MeLcUUE2XGD514rwO5oF3yG
 wpeNpWZ6GSm5qCfimWJmUxLg6SeebbKIFlPoxgfM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Sun, 07 Jan 2024 15:05:11 +0100
Subject: [PATCH v4 4/4] hw/misc/pvpanic: add support for normal shutdowns
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240107-pvpanic-shutdown-v4-4-81500a7e4081@t-8ch.de>
References: <20240107-pvpanic-shutdown-v4-0-81500a7e4081@t-8ch.de>
In-Reply-To: <20240107-pvpanic-shutdown-v4-0-81500a7e4081@t-8ch.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704636309; l=1914;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=hkWFoazCStKhexD0vSbfqqc3avb43oj4ZmJz8Qsbpmc=;
 b=Hbzu59PVW0GgM9+ULmo/QwyJ/JlzS9xcazckbEfpjYHkhIC/6tTahBnJYFlIQ6ftjtRMeFpq+
 TucI3sL/VH1CKDXQYrhCk9AhMyhvVNznX1B3dEC878nnFvwebOUUVrt
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

Shutdown requests are normally hardware dependent.
By extending pvpanic to also handle shutdown requests, guests can
submit such requests with an easily implementable and cross-platform
mechanism.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 docs/specs/pvpanic.rst    | 2 ++
 hw/misc/pvpanic.c         | 5 +++++
 include/hw/misc/pvpanic.h | 3 ++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/docs/specs/pvpanic.rst b/docs/specs/pvpanic.rst
index f894bc19555f..796cc0348a38 100644
--- a/docs/specs/pvpanic.rst
+++ b/docs/specs/pvpanic.rst
@@ -29,6 +29,8 @@ bit 1
   a guest panic has happened and will be handled by the guest;
   the host should record it or report it, but should not affect
   the execution of the guest.
+bit 2
+  a guest shutdown has happened and should be processed by the host
 
 PCI Interface
 -------------
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index a4982cc5928e..246f9ae4e992 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -40,6 +40,11 @@ static void handle_event(int event)
         qemu_system_guest_crashloaded(NULL);
         return;
     }
+
+    if (event & PVPANIC_SHUTDOWN) {
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+        return;
+    }
 }
 
 /* return supported events on read */
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 48f2ec4c86a1..9e36a02d5a4f 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -20,7 +20,8 @@
 
 #define PVPANIC_PANICKED	(1 << 0)
 #define PVPANIC_CRASH_LOADED	(1 << 1)
-#define PVPANIC_EVENTS (PVPANIC_PANICKED | PVPANIC_CRASH_LOADED)
+#define PVPANIC_SHUTDOWN	(1 << 2)
+#define PVPANIC_EVENTS (PVPANIC_PANICKED | PVPANIC_CRASH_LOADED | PVPANIC_SHUTDOWN)
 
 #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
 #define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"

-- 
2.43.0


