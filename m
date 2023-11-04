Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A741B7E0F0F
	for <lists+qemu-devel@lfdr.de>; Sat,  4 Nov 2023 12:27:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzEmi-0003wk-Dz; Sat, 04 Nov 2023 07:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1qzEmc-0003wM-0p
 for qemu-devel@nongnu.org; Sat, 04 Nov 2023 07:25:42 -0400
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1qzEmY-0004MR-Us
 for qemu-devel@nongnu.org; Sat, 04 Nov 2023 07:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1699097130; bh=cROi1E4eq1ZsYUkmqRjGFWSOnESyNSIhF4wVgU9TS9I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=OYXdy48t7cX/XMhmaKNSg0x3quM7zMlKnq/NzBcLGnGz+gpKEu/NEXwPxzHWTl1EA
 6kaGOFVEYNRudnzuSbJ50g+EUsmsOUX7gEn2vYf1dGZ9OwCyONQpkoMN5v6ffsgFqz
 o3YH7I562hQ2/rWZkSQ948+Unpdb2BQ3/VP/cVA4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Sat, 04 Nov 2023 12:25:24 +0100
Subject: [PATCH RFC 3/3] hw/misc/pvpanic: add support for normal shutdowns
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231104-pvpanic-shutdown-v1-3-02353157891b@t-8ch.de>
References: <20231104-pvpanic-shutdown-v1-0-02353157891b@t-8ch.de>
In-Reply-To: <20231104-pvpanic-shutdown-v1-0-02353157891b@t-8ch.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699097130; l=2339;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=cROi1E4eq1ZsYUkmqRjGFWSOnESyNSIhF4wVgU9TS9I=;
 b=BVeHHAz14/hVSDIm3DHzP6eH0w1kWmvCXpXvHKoMrovySwskl9m8sluymiZ7JlFt+NaNEAU0k
 B5fAGX+imo9CLxJT14o5ksciBySZD0OFtD3BdHEEn1EJ8cMgeKl4TY5
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

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 docs/specs/pvpanic.rst                   | 2 ++
 hw/misc/pvpanic.c                        | 5 +++++
 include/hw/misc/pvpanic.h                | 2 +-
 include/standard-headers/linux/pvpanic.h | 1 +
 4 files changed, 9 insertions(+), 1 deletion(-)

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
index 198047dc86ff..fa76ad93d998 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -23,7 +23,7 @@
 #define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"
 
 #define PVPANIC_IOPORT_PROP "ioport"
-#define PVPANIC_EVENTS (PVPANIC_PANICKED | PVPANIC_CRASH_LOADED)
+#define PVPANIC_EVENTS (PVPANIC_PANICKED | PVPANIC_CRASH_LOADED | PVPANIC_SHUTDOWN)
 
 /*
  * PVPanicState for any device type
diff --git a/include/standard-headers/linux/pvpanic.h b/include/standard-headers/linux/pvpanic.h
index 54b7485390d3..38e53ad45929 100644
--- a/include/standard-headers/linux/pvpanic.h
+++ b/include/standard-headers/linux/pvpanic.h
@@ -5,5 +5,6 @@
 
 #define PVPANIC_PANICKED	(1 << 0)
 #define PVPANIC_CRASH_LOADED	(1 << 1)
+#define PVPANIC_SHUTDOWN       	(1 << 2)
 
 #endif /* __PVPANIC_H__ */

-- 
2.42.0


