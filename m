Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1628CF918
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 08:29:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBTqU-0002PM-Hw; Mon, 27 May 2024 02:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1sBTq9-0002Ei-OP
 for qemu-devel@nongnu.org; Mon, 27 May 2024 02:28:13 -0400
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1sBTq7-0004qD-Hl
 for qemu-devel@nongnu.org; Mon, 27 May 2024 02:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1716791283; bh=s5VaI29lwZj1ic4YhfNoQySSm+8g+nzVFlmlxZMx79I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=GG6Gk6EL54vJcshYSoUXOFF/d9332hutWk2dWDyLmitmoPBEH0hybxmTzWmpz/q+T
 2AbVTA0dUsmhPss994RjENrEGbmDBgDoO5boV4dz6rqoKCokyjdRGal+XRbNFms9Mq
 3yIbFVZbu13hINuXL577NvQ9l2FFj+uC6u2b0TaU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Mon, 27 May 2024 08:27:51 +0200
Subject: [PATCH v8 5/8] hw/misc/pvpanic: add support for normal shutdowns
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240527-pvpanic-shutdown-v8-5-5a28ec02558b@t-8ch.de>
References: <20240527-pvpanic-shutdown-v8-0-5a28ec02558b@t-8ch.de>
In-Reply-To: <20240527-pvpanic-shutdown-v8-0-5a28ec02558b@t-8ch.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, kvm@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716791282; l=2474;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=s5VaI29lwZj1ic4YhfNoQySSm+8g+nzVFlmlxZMx79I=;
 b=eFGqUTzQJobqUIXaRVRjnXdRt672/izm7hsoRvVKqM2uiQXXKoPkEA8RyjnGlWkZMwN6un8u+
 kNpbRtoMzmFB7kPmcu99bp2Cmr4kbzWQ4v1miX/rt4vIzv+l4snBlJk
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=159.69.126.157; envelope-from=thomas@t-8ch.de;
 helo=todd.t-8ch.de
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

Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 hw/misc/pvpanic.c         | 5 +++++
 include/hw/misc/pvpanic.h | 2 +-
 include/sysemu/runstate.h | 1 +
 system/runstate.c         | 5 +++++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index a4982cc5928e..0e9505451a7a 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -40,6 +40,11 @@ static void handle_event(int event)
         qemu_system_guest_crashloaded(NULL);
         return;
     }
+
+    if (event & PVPANIC_SHUTDOWN) {
+        qemu_system_guest_pvshutdown();
+        return;
+    }
 }
 
 /* return supported events on read */
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 947468b81b1a..fbbf2bbf5dbb 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -20,7 +20,7 @@
 
 #include "standard-headers/linux/pvpanic.h"
 
-#define PVPANIC_EVENTS (PVPANIC_PANICKED | PVPANIC_CRASH_LOADED)
+#define PVPANIC_EVENTS (PVPANIC_PANICKED | PVPANIC_CRASH_LOADED | PVPANIC_SHUTDOWN)
 
 #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
 #define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"
diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 0117d243c4ed..e210a37abf0f 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -104,6 +104,7 @@ void qemu_system_killed(int signal, pid_t pid);
 void qemu_system_reset(ShutdownCause reason);
 void qemu_system_guest_panicked(GuestPanicInformation *info);
 void qemu_system_guest_crashloaded(GuestPanicInformation *info);
+void qemu_system_guest_pvshutdown(void);
 bool qemu_system_dump_in_progress(void);
 
 #endif
diff --git a/system/runstate.c b/system/runstate.c
index cb4905a40fce..83055f327831 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -585,6 +585,11 @@ void qemu_system_guest_crashloaded(GuestPanicInformation *info)
     qapi_free_GuestPanicInformation(info);
 }
 
+void qemu_system_guest_pvshutdown(void)
+{
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+}
+
 void qemu_system_reset_request(ShutdownCause reason)
 {
     if (reboot_action == REBOOT_ACTION_SHUTDOWN &&

-- 
2.45.1


