Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C91D82646A
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 15:06:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMTmI-0005wl-GY; Sun, 07 Jan 2024 09:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rMTm8-0005Tp-2N
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 09:05:17 -0500
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rMTm4-0006uc-OZ
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 09:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1704636309; bh=9HEUZB4YLIjFh2FXUpg54N2bIMYb4uxqTetJTzfGjzs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=g/i80O/x7O7McWz1TkmkfOdyyN9pEu/Wj2aV5nvU/Xh3s14rJTjZeP2QtCPKmG28T
 aOAeTGqdnnIMekz/dMGRNw3iTd11MOMxQq/rtzkK5/6WT/IV6FvArDblbS4Om+zHZx
 ayqlOqoAA0gWwRdA3u5Z3wjlpVIuIltaehwMSPJw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Sun, 07 Jan 2024 15:05:08 +0100
Subject: [PATCH v4 1/4] linux-headers: drop pvpanic.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240107-pvpanic-shutdown-v4-1-81500a7e4081@t-8ch.de>
References: <20240107-pvpanic-shutdown-v4-0-81500a7e4081@t-8ch.de>
In-Reply-To: <20240107-pvpanic-shutdown-v4-0-81500a7e4081@t-8ch.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704636308; l=3680;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=9HEUZB4YLIjFh2FXUpg54N2bIMYb4uxqTetJTzfGjzs=;
 b=zjduTTumFsBFQEOrQvdTPtY+o9G2ctxsPV6JNmx+lAY4ERon0BAsAC2Ucv9SzRU+xGqBf8UC3
 iHPIpphDYUWDthHqNpd203mls5I+Lb7gNriH7yJEpbAhcHtDUSjlxGG
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

misc/pvpanic.h from the Linux UAPI does not define a Linux UAPI but a
qemu device API.

This leads to a weird process when updates to the interface are needed:
1) Change to the specification in the qemu tree
2) Change to the header in the Linux tree
3) Re-import of the header into Qemu.

The kernel prefers to drop the header anyways.

Prepare for the removal from the Linux UAPI headers by moving the
contents to the existing pvpanic.h header.

Link: https://lore.kernel.org/lkml/2023110431-pacemaker-pruning-0e4c@gregkh/
Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 hw/misc/pvpanic-isa.c                    | 1 -
 hw/misc/pvpanic-pci.c                    | 1 -
 hw/misc/pvpanic.c                        | 1 -
 include/hw/misc/pvpanic.h                | 3 +++
 include/standard-headers/linux/pvpanic.h | 9 ---------
 scripts/update-linux-headers.sh          | 3 +--
 6 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/hw/misc/pvpanic-isa.c b/hw/misc/pvpanic-isa.c
index ccec50f61bbd..ef438a31fbe9 100644
--- a/hw/misc/pvpanic-isa.c
+++ b/hw/misc/pvpanic-isa.c
@@ -21,7 +21,6 @@
 #include "hw/misc/pvpanic.h"
 #include "qom/object.h"
 #include "hw/isa/isa.h"
-#include "standard-headers/linux/pvpanic.h"
 #include "hw/acpi/acpi_aml_interface.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(PVPanicISAState, PVPANIC_ISA_DEVICE)
diff --git a/hw/misc/pvpanic-pci.c b/hw/misc/pvpanic-pci.c
index c01e4ce8646a..01e269b55284 100644
--- a/hw/misc/pvpanic-pci.c
+++ b/hw/misc/pvpanic-pci.c
@@ -21,7 +21,6 @@
 #include "hw/misc/pvpanic.h"
 #include "qom/object.h"
 #include "hw/pci/pci_device.h"
-#include "standard-headers/linux/pvpanic.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(PVPanicPCIState, PVPANIC_PCI_DEVICE)
 
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 1540e9091a45..4915ef256e74 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -21,7 +21,6 @@
 #include "hw/qdev-properties.h"
 #include "hw/misc/pvpanic.h"
 #include "qom/object.h"
-#include "standard-headers/linux/pvpanic.h"
 
 static void handle_event(int event)
 {
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index fab94165d03d..dffca827f77a 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -18,6 +18,9 @@
 #include "exec/memory.h"
 #include "qom/object.h"
 
+#define PVPANIC_PANICKED	(1 << 0)
+#define PVPANIC_CRASH_LOADED	(1 << 1)
+
 #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
 #define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"
 
diff --git a/include/standard-headers/linux/pvpanic.h b/include/standard-headers/linux/pvpanic.h
deleted file mode 100644
index 54b7485390d3..000000000000
--- a/include/standard-headers/linux/pvpanic.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-
-#ifndef __PVPANIC_H__
-#define __PVPANIC_H__
-
-#define PVPANIC_PANICKED	(1 << 0)
-#define PVPANIC_CRASH_LOADED	(1 << 1)
-
-#endif /* __PVPANIC_H__ */
diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 34295c0fe55b..555bdc8af2eb 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -215,8 +215,7 @@ for i in "$tmpdir"/include/linux/*virtio*.h \
          "$tmpdir/include/linux/const.h" \
          "$tmpdir/include/linux/kernel.h" \
          "$tmpdir/include/linux/vhost_types.h" \
-         "$tmpdir/include/linux/sysinfo.h" \
-         "$tmpdir/include/misc/pvpanic.h"; do
+         "$tmpdir/include/linux/sysinfo.h"; do
     cp_portable "$i" "$output/include/standard-headers/linux"
 done
 mkdir -p "$output/include/standard-headers/drm"

-- 
2.43.0


