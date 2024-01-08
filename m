Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C34C82776B
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:26:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuIr-00033w-G7; Mon, 08 Jan 2024 13:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIp-00033M-Gr
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIl-0002y6-0l
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ITk3ezfR11ldyPuR86UDkrTaFVQGJKAO3KLVmjXpUU=;
 b=aR/86C3fPbU97Lg67TzNWxoGg7Ew8G5ykdrEic2rwayHI93LxbOuwvOe1729bacMpDaro+
 J5KRBVvnqE/cPSnargSLVVBngwGqGsGsqO/5qm3o6KeMNSjOvvypXpmZLU29nEpXiPFmBL
 gcbylGmZbnYknKdljf0GirwxlcR3Ht4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-HDU-jdE3Md6zexPaXB86pQ-1; Mon, 08 Jan 2024 13:24:40 -0500
X-MC-Unique: HDU-jdE3Md6zexPaXB86pQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6445383DE2C;
 Mon,  8 Jan 2024 18:24:40 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A71E3C2E;
 Mon,  8 Jan 2024 18:24:39 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 25/29] tests: adapt to new import path for qobject data type
 headers
Date: Mon,  8 Jan 2024 18:24:01 +0000
Message-ID: <20240108182405.1135436-26-berrange@redhat.com>
In-Reply-To: <20240108182405.1135436-1-berrange@redhat.com>
References: <20240108182405.1135436-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The qobject data type headers have moved from qapi/qmp/ to
qobject/.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/adm1266-test.c                |  4 ++--
 tests/qtest/adm1272-test.c                |  4 ++--
 tests/qtest/ahci-test.c                   |  2 +-
 tests/qtest/arm-cpu-features.c            |  4 ++--
 tests/qtest/aspeed_gpio-test.c            |  2 +-
 tests/qtest/boot-order-test.c             |  2 +-
 tests/qtest/cdrom-test.c                  |  2 +-
 tests/qtest/cpu-plug-test.c               |  4 ++--
 tests/qtest/device-introspect-test.c      |  6 +++---
 tests/qtest/device-plug-test.c            |  4 ++--
 tests/qtest/drive_del-test.c              |  4 ++--
 tests/qtest/emc141x-test.c                |  2 +-
 tests/qtest/fdc-test.c                    |  2 +-
 tests/qtest/hd-geo-test.c                 |  2 +-
 tests/qtest/ide-test.c                    |  2 +-
 tests/qtest/isl_pmbus_vr-test.c           |  4 ++--
 tests/qtest/libqmp.c                      |  4 ++--
 tests/qtest/libqmp.h                      |  2 +-
 tests/qtest/libqos/generic-pcihost.c      |  2 +-
 tests/qtest/libqos/libqos.c               |  2 +-
 tests/qtest/libqos/pci-pc.c               |  2 +-
 tests/qtest/libqos/qos_external.c         |  8 ++++----
 tests/qtest/libqtest.c                    |  8 ++++----
 tests/qtest/libqtest.h                    |  4 ++--
 tests/qtest/lsm303dlhc-mag-test.c         |  2 +-
 tests/qtest/machine-none-test.c           |  2 +-
 tests/qtest/max34451-test.c               |  4 ++--
 tests/qtest/migration-helpers.c           |  2 +-
 tests/qtest/migration-test.c              |  4 ++--
 tests/qtest/netdev-socket.c               |  2 +-
 tests/qtest/npcm7xx_adc-test.c            |  2 +-
 tests/qtest/npcm7xx_emc-test.c            |  4 ++--
 tests/qtest/npcm7xx_pwm-test.c            |  4 ++--
 tests/qtest/npcm7xx_watchdog_timer-test.c |  2 +-
 tests/qtest/numa-test.c                   |  4 ++--
 tests/qtest/pvpanic-pci-test.c            |  2 +-
 tests/qtest/pvpanic-test.c                |  2 +-
 tests/qtest/q35-test.c                    |  2 +-
 tests/qtest/qmp-cmd-test.c                |  2 +-
 tests/qtest/qmp-test.c                    |  6 +++---
 tests/qtest/qom-test.c                    |  4 ++--
 tests/qtest/qos-test.c                    |  2 +-
 tests/qtest/readconfig-test.c             |  6 +++---
 tests/qtest/tco-test.c                    |  2 +-
 tests/qtest/test-filter-mirror.c          |  2 +-
 tests/qtest/test-filter-redirector.c      |  2 +-
 tests/qtest/test-netfilter.c              |  2 +-
 tests/qtest/test-x86-cpuid-compat.c       |  8 ++++----
 tests/qtest/tmp105-test.c                 |  2 +-
 tests/qtest/tpm-emu.c                     |  4 ++--
 tests/qtest/tpm-util.c                    |  2 +-
 tests/qtest/vhost-user-test.c             |  2 +-
 tests/qtest/virtio-net-failover.c         |  6 +++---
 tests/qtest/virtio-net-test.c             |  2 +-
 tests/qtest/vmgenid-test.c                |  2 +-
 tests/qtest/wdt_ib700-test.c              |  2 +-
 tests/unit/check-block-qdict.c            |  4 ++--
 tests/unit/check-qdict.c                  |  6 +++---
 tests/unit/check-qjson.c                  | 12 ++++++------
 tests/unit/check-qlist.c                  |  4 ++--
 tests/unit/check-qlit.c                   | 12 ++++++------
 tests/unit/check-qnull.c                  |  2 +-
 tests/unit/check-qnum.c                   |  2 +-
 tests/unit/check-qobject.c                | 12 ++++++------
 tests/unit/check-qom-proplist.c           |  4 ++--
 tests/unit/check-qstring.c                |  2 +-
 tests/unit/test-block-iothread.c          |  2 +-
 tests/unit/test-blockjob-txn.c            |  2 +-
 tests/unit/test-blockjob.c                |  2 +-
 tests/unit/test-char.c                    |  2 +-
 tests/unit/test-forward-visitor.c         |  4 ++--
 tests/unit/test-image-locking.c           |  2 +-
 tests/unit/test-keyval.c                  |  6 +++---
 tests/unit/test-qemu-opts.c               |  4 ++--
 tests/unit/test-qga.c                     |  4 ++--
 tests/unit/test-qmp-cmds.c                |  8 ++++----
 tests/unit/test-qmp-event.c               | 10 +++++-----
 tests/unit/test-qobject-input-visitor.c   | 12 ++++++------
 tests/unit/test-qobject-output-visitor.c  | 12 ++++++------
 tests/unit/test-replication.c             |  2 +-
 tests/unit/test-visitor-serialization.c   |  4 ++--
 81 files changed, 157 insertions(+), 157 deletions(-)

diff --git a/tests/qtest/adm1266-test.c b/tests/qtest/adm1266-test.c
index 6c312c499f..5ae8206234 100644
--- a/tests/qtest/adm1266-test.c
+++ b/tests/qtest/adm1266-test.c
@@ -13,8 +13,8 @@
 #include "libqtest-single.h"
 #include "libqos/qgraph.h"
 #include "libqos/i2c.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
 #include "qemu/bitops.h"
 
 #define TEST_ID "adm1266-test"
diff --git a/tests/qtest/adm1272-test.c b/tests/qtest/adm1272-test.c
index 63f8514801..2abda8d5be 100644
--- a/tests/qtest/adm1272-test.c
+++ b/tests/qtest/adm1272-test.c
@@ -12,8 +12,8 @@
 #include "libqtest-single.h"
 #include "libqos/qgraph.h"
 #include "libqos/i2c.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
 #include "qemu/bitops.h"
 
 #define TEST_ID "adm1272-test"
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 5a1923f721..88ac6c66ce 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -30,7 +30,7 @@
 #include "libqos/ahci.h"
 #include "libqos/pci-pc.h"
 
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/host-utils.h"
 
 #include "hw/pci/pci_ids.h"
diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index a8a4c668ad..0dd96b8dbe 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -11,8 +11,8 @@
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
 
 /*
  * We expect the SVE max-vq to be 16. Also it must be <= 64
diff --git a/tests/qtest/aspeed_gpio-test.c b/tests/qtest/aspeed_gpio-test.c
index d38f51d719..12675d4cbb 100644
--- a/tests/qtest/aspeed_gpio-test.c
+++ b/tests/qtest/aspeed_gpio-test.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "qemu/timer.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "libqtest-single.h"
 
 #define AST2600_GPIO_BASE 0x1E780000
diff --git a/tests/qtest/boot-order-test.c b/tests/qtest/boot-order-test.c
index 8f2b6ef05a..68169bcac4 100644
--- a/tests/qtest/boot-order-test.c
+++ b/tests/qtest/boot-order-test.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "libqos/fw_cfg.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "standard-headers/linux/qemu_fw_cfg.h"
 
 typedef struct {
diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
index 0945383789..23441a6a7b 100644
--- a/tests/qtest/cdrom-test.c
+++ b/tests/qtest/cdrom-test.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "boot-sector.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 static char isoimage[] = "cdrom-boot-iso-XXXXXX";
 
diff --git a/tests/qtest/cpu-plug-test.c b/tests/qtest/cpu-plug-test.c
index 7f5dd5f85a..6633abfc10 100644
--- a/tests/qtest/cpu-plug-test.c
+++ b/tests/qtest/cpu-plug-test.c
@@ -10,8 +10,8 @@
 #include "qemu/osdep.h"
 
 #include "libqtest-single.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
 
 struct PlugTestData {
     char *machine;
diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device-introspect-test.c
index 5b0ffe43f5..999b8da149 100644
--- a/tests/qtest/device-introspect-test.c
+++ b/tests/qtest/device-introspect-test.c
@@ -18,9 +18,9 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
 #include "libqtest.h"
 
 const char common_args[] = "-nodefaults -machine none";
diff --git a/tests/qtest/device-plug-test.c b/tests/qtest/device-plug-test.c
index c6f33153eb..7124f17a0f 100644
--- a/tests/qtest/device-plug-test.c
+++ b/tests/qtest/device-plug-test.c
@@ -12,8 +12,8 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 
 static void system_reset(QTestState *qtest)
 {
diff --git a/tests/qtest/drive_del-test.c b/tests/qtest/drive_del-test.c
index 8a6f3ac963..da7b348ace 100644
--- a/tests/qtest/drive_del-test.c
+++ b/tests/qtest/drive_del-test.c
@@ -13,8 +13,8 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "libqos/virtio.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
 
 static const char *qvirtio_get_dev_type(void);
 
diff --git a/tests/qtest/emc141x-test.c b/tests/qtest/emc141x-test.c
index 8c86694091..a24103e2cd 100644
--- a/tests/qtest/emc141x-test.c
+++ b/tests/qtest/emc141x-test.c
@@ -10,7 +10,7 @@
 #include "libqtest-single.h"
 #include "libqos/qgraph.h"
 #include "libqos/i2c.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "hw/sensor/emc141x_regs.h"
 
 #define EMC1414_TEST_ID   "emc1414-test"
diff --git a/tests/qtest/fdc-test.c b/tests/qtest/fdc-test.c
index 5e8fbda9df..f8a98a9f4b 100644
--- a/tests/qtest/fdc-test.c
+++ b/tests/qtest/fdc-test.c
@@ -26,7 +26,7 @@
 
 
 #include "libqtest-single.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 #define DRIVE_FLOPPY_BLANK \
     "-drive if=floppy,file=null-co://,file.read-zeroes=on,format=raw,size=1440k"
diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c
index d08bffad91..037e43f9f8 100644
--- a/tests/qtest/hd-geo-test.c
+++ b/tests/qtest/hd-geo-test.c
@@ -17,7 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/bswap.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "libqtest.h"
 #include "libqos/fw_cfg.h"
 #include "libqos/libqos.h"
diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index d6b4f6e36a..a0ff4fe327 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -29,7 +29,7 @@
 #include "libqos/libqos.h"
 #include "libqos/pci-pc.h"
 #include "libqos/malloc-pc.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/bswap.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/pci/pci_regs.h"
diff --git a/tests/qtest/isl_pmbus_vr-test.c b/tests/qtest/isl_pmbus_vr-test.c
index 5553ea410a..1ff840c6b7 100644
--- a/tests/qtest/isl_pmbus_vr-test.c
+++ b/tests/qtest/isl_pmbus_vr-test.c
@@ -21,8 +21,8 @@
 #include "libqtest-single.h"
 #include "libqos/qgraph.h"
 #include "libqos/i2c.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
 #include "qemu/bitops.h"
 
 #define TEST_ID "isl_pmbus_vr-test"
diff --git a/tests/qtest/libqmp.c b/tests/qtest/libqmp.c
index a89cab03c3..16fe546885 100644
--- a/tests/qtest/libqmp.c
+++ b/tests/qtest/libqmp.c
@@ -25,8 +25,8 @@
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
-#include "qapi/qmp/json-parser.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/json-parser.h"
+#include "qobject/qjson.h"
 
 #define SOCKET_MAX_FDS 16
 
diff --git a/tests/qtest/libqmp.h b/tests/qtest/libqmp.h
index 3445b753ff..4a931c93ab 100644
--- a/tests/qtest/libqmp.h
+++ b/tests/qtest/libqmp.h
@@ -18,7 +18,7 @@
 #ifndef LIBQMP_H
 #define LIBQMP_H
 
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 QDict *qmp_fd_receive(int fd);
 #ifndef _WIN32
diff --git a/tests/qtest/libqos/generic-pcihost.c b/tests/qtest/libqos/generic-pcihost.c
index 3124b0e46b..4bbeb5ff50 100644
--- a/tests/qtest/libqos/generic-pcihost.c
+++ b/tests/qtest/libqos/generic-pcihost.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "../libqtest.h"
 #include "generic-pcihost.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "hw/pci/pci_regs.h"
 #include "qemu/host-utils.h"
 
diff --git a/tests/qtest/libqos/libqos.c b/tests/qtest/libqos/libqos.c
index 5c0fa1f7c5..0cc8c511f0 100644
--- a/tests/qtest/libqos/libqos.c
+++ b/tests/qtest/libqos/libqos.c
@@ -2,7 +2,7 @@
 #include "../libqtest.h"
 #include "libqos.h"
 #include "pci.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 /*** Test Setup & Teardown ***/
 
diff --git a/tests/qtest/libqos/pci-pc.c b/tests/qtest/libqos/pci-pc.c
index 96046287ac..147009f4f4 100644
--- a/tests/qtest/libqos/pci-pc.c
+++ b/tests/qtest/libqos/pci-pc.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "../libqtest.h"
 #include "pci-pc.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "hw/pci/pci_regs.h"
 
 #include "qemu/module.h"
diff --git a/tests/qtest/libqos/qos_external.c b/tests/qtest/libqos/qos_external.c
index c6bb8bff09..493ab747de 100644
--- a/tests/qtest/libqos/qos_external.c
+++ b/tests/qtest/libqos/qos_external.c
@@ -19,11 +19,11 @@
 #include "qemu/osdep.h"
 #include <getopt.h>
 #include "../libqtest.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qbool.h"
+#include "qobject/qstring.h"
 #include "qemu/module.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "libqos-malloc.h"
 #include "qgraph.h"
 #include "qgraph_internal.h"
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index f33a210861..ede3ea68ed 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -33,10 +33,10 @@
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qlist.h"
+#include "qobject/qstring.h"
 
 #define MAX_IRQ 256
 
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 6e3d3525bf..b8508a43c0 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -17,8 +17,8 @@
 #ifndef LIBQTEST_H
 #define LIBQTEST_H
 
-#include "qapi/qmp/qobject.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qobject.h"
+#include "qobject/qdict.h"
 #include "libqmp.h"
 
 typedef struct QTestState QTestState;
diff --git a/tests/qtest/lsm303dlhc-mag-test.c b/tests/qtest/lsm303dlhc-mag-test.c
index 0f64e7fc67..55ef4594f9 100644
--- a/tests/qtest/lsm303dlhc-mag-test.c
+++ b/tests/qtest/lsm303dlhc-mag-test.c
@@ -13,7 +13,7 @@
 #include "libqtest-single.h"
 #include "libqos/qgraph.h"
 #include "libqos/i2c.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 #define LSM303DLHC_MAG_TEST_ID        "lsm303dlhc_mag-test"
 #define LSM303DLHC_MAG_REG_CRA        0x00
diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index 31cc0bfb01..897b36c94b 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -14,7 +14,7 @@
 
 #include "qemu/cutils.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 
 struct arch2cpu {
diff --git a/tests/qtest/max34451-test.c b/tests/qtest/max34451-test.c
index dbf6ddc829..5e0878c923 100644
--- a/tests/qtest/max34451-test.c
+++ b/tests/qtest/max34451-test.c
@@ -11,8 +11,8 @@
 #include "libqtest-single.h"
 #include "libqos/qgraph.h"
 #include "libqos/i2c.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
 #include "qemu/bitops.h"
 
 #define TEST_ID "max34451-test"
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 24fb7b3525..55b9e2c429 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/ctype.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qjson.h"
 
 #include "migration-helpers.h"
 
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index d520c587f7..c61817285b 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -14,7 +14,7 @@
 
 #include "libqtest.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
@@ -24,7 +24,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "crypto/tlscredspsk.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 
 #include "migration-helpers.h"
 #include "tests/migration/migration-test.h"
diff --git a/tests/qtest/netdev-socket.c b/tests/qtest/netdev-socket.c
index bb99d08b5e..85a538f50c 100644
--- a/tests/qtest/netdev-socket.c
+++ b/tests/qtest/netdev-socket.c
@@ -11,7 +11,7 @@
 #include <glib/gstdio.h>
 #include "../unit/socket-helpers.h"
 #include "libqtest.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qstring.h"
 #include "qemu/sockets.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-sockets.h"
diff --git a/tests/qtest/npcm7xx_adc-test.c b/tests/qtest/npcm7xx_adc-test.c
index e751a72e36..8bc89b8a8b 100644
--- a/tests/qtest/npcm7xx_adc-test.c
+++ b/tests/qtest/npcm7xx_adc-test.c
@@ -18,7 +18,7 @@
 #include "qemu/bitops.h"
 #include "qemu/timer.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 #define REF_HZ          (25000000)
 
diff --git a/tests/qtest/npcm7xx_emc-test.c b/tests/qtest/npcm7xx_emc-test.c
index b046f1d76a..706c801d47 100644
--- a/tests/qtest/npcm7xx_emc-test.c
+++ b/tests/qtest/npcm7xx_emc-test.c
@@ -16,8 +16,8 @@
 
 #include "qemu/osdep.h"
 #include "libqos/libqos.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
 #include "qemu/bitops.h"
 #include "qemu/iov.h"
 
diff --git a/tests/qtest/npcm7xx_pwm-test.c b/tests/qtest/npcm7xx_pwm-test.c
index b53a43c417..052ea87662 100644
--- a/tests/qtest/npcm7xx_pwm-test.c
+++ b/tests/qtest/npcm7xx_pwm-test.c
@@ -17,8 +17,8 @@
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
 
 static int verbosity_level;
 
diff --git a/tests/qtest/npcm7xx_watchdog_timer-test.c b/tests/qtest/npcm7xx_watchdog_timer-test.c
index 4773a673b2..f69cd73ac3 100644
--- a/tests/qtest/npcm7xx_watchdog_timer-test.c
+++ b/tests/qtest/npcm7xx_watchdog_timer-test.c
@@ -18,7 +18,7 @@
 #include "qemu/timer.h"
 
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 #define WTCR_OFFSET     0x1c
 #define REF_HZ          (25000000)
diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
index 4f4404a4b1..d6179f280a 100644
--- a/tests/qtest/numa-test.c
+++ b/tests/qtest/numa-test.c
@@ -11,8 +11,8 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
 
 static char *make_cli(const GString *generic_cli, const char *test_cli)
 {
diff --git a/tests/qtest/pvpanic-pci-test.c b/tests/qtest/pvpanic-pci-test.c
index 2c05b376ba..7ee8aa2069 100644
--- a/tests/qtest/pvpanic-pci-test.c
+++ b/tests/qtest/pvpanic-pci-test.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "libqos/pci.h"
 #include "libqos/pci-pc.h"
 #include "hw/pci/pci_regs.h"
diff --git a/tests/qtest/pvpanic-test.c b/tests/qtest/pvpanic-test.c
index 78f1cf8186..f6a4deafb9 100644
--- a/tests/qtest/pvpanic-test.c
+++ b/tests/qtest/pvpanic-test.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 static void test_panic_nopause(void)
 {
diff --git a/tests/qtest/q35-test.c b/tests/qtest/q35-test.c
index c922d81bc0..4636a40e99 100644
--- a/tests/qtest/q35-test.c
+++ b/tests/qtest/q35-test.c
@@ -14,7 +14,7 @@
 #include "libqos/pci.h"
 #include "libqos/pci-pc.h"
 #include "hw/pci-host/q35.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 #define TSEG_SIZE_TEST_GUEST_RAM_MBYTES 128
 
diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index 2c15f60958..15c88248b7 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -14,7 +14,7 @@
 #include "libqtest.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-introspect.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 
 const char common_args[] = "-nodefaults -machine none";
diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
index 22957fa49c..edf0886787 100644
--- a/tests/qtest/qmp-test.c
+++ b/tests/qtest/qmp-test.c
@@ -14,10 +14,10 @@
 #include "libqtest.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-control.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
 #include "qapi/qobject-input-visitor.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qstring.h"
 
 const char common_args[] = "-nodefaults -machine none";
 
diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index d677f87c8e..1e30a5bfe8 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -9,8 +9,8 @@
 
 #include "qemu/osdep.h"
 
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
 #include "qemu/cutils.h"
 #include "libqtest.h"
 
diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
index 5da4091ec3..43e01113f7 100644
--- a/tests/qtest/qos-test.c
+++ b/tests/qtest/qos-test.c
@@ -20,7 +20,7 @@
 #include <getopt.h>
 #include "libqtest-single.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/module.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-machine.h"
diff --git a/tests/qtest/readconfig-test.c b/tests/qtest/readconfig-test.c
index 760f974e63..c6f32a4e14 100644
--- a/tests/qtest/readconfig-test.c
+++ b/tests/qtest/readconfig-test.c
@@ -13,10 +13,10 @@
 #include "qapi/qapi-visit-machine.h"
 #include "qapi/qapi-visit-qom.h"
 #include "qapi/qapi-visit-ui.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
 #include "qapi/qobject-input-visitor.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qstring.h"
 #include "qemu/units.h"
 
 static QTestState *qtest_init_with_config(const char *cfgdata)
diff --git a/tests/qtest/tco-test.c b/tests/qtest/tco-test.c
index 0547d41173..20ccefabcb 100644
--- a/tests/qtest/tco-test.c
+++ b/tests/qtest/tco-test.c
@@ -12,7 +12,7 @@
 #include "libqtest.h"
 #include "libqos/pci.h"
 #include "libqos/pci-pc.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "hw/pci/pci_regs.h"
 #include "hw/southbridge/ich9.h"
 #include "hw/acpi/ich9.h"
diff --git a/tests/qtest/test-filter-mirror.c b/tests/qtest/test-filter-mirror.c
index f3865f7519..723d2c2f29 100644
--- a/tests/qtest/test-filter-mirror.c
+++ b/tests/qtest/test-filter-mirror.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
diff --git a/tests/qtest/test-filter-redirector.c b/tests/qtest/test-filter-redirector.c
index a77d5fd8ec..a996a80c1c 100644
--- a/tests/qtest/test-filter-redirector.c
+++ b/tests/qtest/test-filter-redirector.c
@@ -52,7 +52,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
diff --git a/tests/qtest/test-netfilter.c b/tests/qtest/test-netfilter.c
index b09ef7fae9..326d4bd85f 100644
--- a/tests/qtest/test-netfilter.c
+++ b/tests/qtest/test-netfilter.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest-single.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 /* add a netfilter to a netdev and then remove it */
 static void add_one_netfilter(void)
diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index 6a39454fce..2990e8fa22 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -1,8 +1,8 @@
 #include "qemu/osdep.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qnum.h"
+#include "qobject/qbool.h"
 #include "libqtest-single.h"
 
 static char *get_cpu0_qom_path(void)
diff --git a/tests/qtest/tmp105-test.c b/tests/qtest/tmp105-test.c
index 3678646df5..eaf059705d 100644
--- a/tests/qtest/tmp105-test.c
+++ b/tests/qtest/tmp105-test.c
@@ -12,7 +12,7 @@
 #include "libqtest-single.h"
 #include "libqos/qgraph.h"
 #include "libqos/i2c.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "hw/sensor/tmp105_regs.h"
 
 #define TMP105_TEST_ID   "tmp105-test"
diff --git a/tests/qtest/tpm-emu.c b/tests/qtest/tpm-emu.c
index 2bf8ff4c86..9e4c2005d0 100644
--- a/tests/qtest/tpm-emu.c
+++ b/tests/qtest/tpm-emu.c
@@ -16,8 +16,8 @@
 #include "backends/tpm/tpm_ioctl.h"
 #include "io/channel-socket.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qlist.h"
+#include "qobject/qstring.h"
 #include "tpm-emu.h"
 
 void tpm_emu_test_wait_cond(TPMTestState *s)
diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index 1c0319e6e7..2cb2dd4796 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -18,7 +18,7 @@
 #include "hw/acpi/tpm.h"
 #include "libqtest.h"
 #include "tpm-util.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 void tpm_util_crb_transfer(QTestState *s,
                            const unsigned char *req, size_t req_size,
diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index d4e437265f..85a7275d3b 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -12,7 +12,7 @@
 
 #include "libqtest-single.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
diff --git a/tests/qtest/virtio-net-failover.c b/tests/qtest/virtio-net-failover.c
index 0d40bc1f2d..7695f2d09f 100644
--- a/tests/qtest/virtio-net-failover.c
+++ b/tests/qtest/virtio-net-failover.c
@@ -12,9 +12,9 @@
 #include "libqos/pci.h"
 #include "libqos/pci-pc.h"
 #include "migration-helpers.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qjson.h"
 #include "libqos/malloc-pc.h"
 #include "libqos/virtio-pci.h"
 #include "hw/pci/pci.h"
diff --git a/tests/qtest/virtio-net-test.c b/tests/qtest/virtio-net-test.c
index 2df75c9780..60e5229a3d 100644
--- a/tests/qtest/virtio-net-test.c
+++ b/tests/qtest/virtio-net-test.c
@@ -11,7 +11,7 @@
 #include "libqtest-single.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "hw/virtio/virtio-net.h"
 #include "libqos/qgraph.h"
 #include "libqos/virtio-net.h"
diff --git a/tests/qtest/vmgenid-test.c b/tests/qtest/vmgenid-test.c
index 29fee9e7c0..e613374665 100644
--- a/tests/qtest/vmgenid-test.c
+++ b/tests/qtest/vmgenid-test.c
@@ -15,7 +15,7 @@
 #include "boot-sector.h"
 #include "acpi-utils.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 #define VGID_GUID "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
 #define VMGENID_GUID_OFFSET 40   /* allow space for
diff --git a/tests/qtest/wdt_ib700-test.c b/tests/qtest/wdt_ib700-test.c
index 797288d939..1754757162 100644
--- a/tests/qtest/wdt_ib700-test.c
+++ b/tests/qtest/wdt_ib700-test.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/timer.h"
 
 static void qmp_check_no_event(QTestState *s)
diff --git a/tests/unit/check-block-qdict.c b/tests/unit/check-block-qdict.c
index 751c58e737..0036d85cfa 100644
--- a/tests/unit/check-block-qdict.c
+++ b/tests/unit/check-block-qdict.c
@@ -9,8 +9,8 @@
 
 #include "qemu/osdep.h"
 #include "block/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qlist.h"
+#include "qobject/qnum.h"
 #include "qapi/error.h"
 
 static void qdict_defaults_test(void)
diff --git a/tests/unit/check-qdict.c b/tests/unit/check-qdict.c
index b5efa859b0..a1312be30a 100644
--- a/tests/unit/check-qdict.c
+++ b/tests/unit/check-qdict.c
@@ -11,9 +11,9 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 
 /*
  * Public Interface test-cases
diff --git a/tests/unit/check-qjson.c b/tests/unit/check-qjson.c
index a89293ce51..780a3654d0 100644
--- a/tests/unit/check-qjson.c
+++ b/tests/unit/check-qjson.c
@@ -14,12 +14,12 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qlit.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qjson.h"
+#include "qobject/qlit.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qemu/unicode.h"
 
 static QString *from_json_str(const char *jstr, bool single, Error **errp)
diff --git a/tests/unit/check-qlist.c b/tests/unit/check-qlist.c
index 3cd0ccbf19..1388aeede3 100644
--- a/tests/unit/check-qlist.c
+++ b/tests/unit/check-qlist.c
@@ -11,8 +11,8 @@
  */
 #include "qemu/osdep.h"
 
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qnum.h"
+#include "qobject/qlist.h"
 
 /*
  * Public Interface test-cases
diff --git a/tests/unit/check-qlit.c b/tests/unit/check-qlit.c
index bd6798d912..ea7a0d9119 100644
--- a/tests/unit/check-qlit.c
+++ b/tests/unit/check-qlit.c
@@ -9,12 +9,12 @@
 
 #include "qemu/osdep.h"
 
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qlit.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qlit.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 
 static QLitObject qlit = QLIT_QDICT(((QLitDictEntry[]) {
     { "foo", QLIT_QNUM(42) },
diff --git a/tests/unit/check-qnull.c b/tests/unit/check-qnull.c
index 5ceacc65d7..724a66d0bd 100644
--- a/tests/unit/check-qnull.c
+++ b/tests/unit/check-qnull.c
@@ -8,7 +8,7 @@
  */
 #include "qemu/osdep.h"
 
-#include "qapi/qmp/qnull.h"
+#include "qobject/qnull.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/error.h"
diff --git a/tests/unit/check-qnum.c b/tests/unit/check-qnum.c
index bf7fe45bac..a40120e8d3 100644
--- a/tests/unit/check-qnum.c
+++ b/tests/unit/check-qnum.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 
-#include "qapi/qmp/qnum.h"
+#include "qobject/qnum.h"
 
 /*
  * Public Interface test-cases
diff --git a/tests/unit/check-qobject.c b/tests/unit/check-qobject.c
index 022b7c74fe..ccb25660f2 100644
--- a/tests/unit/check-qobject.c
+++ b/tests/unit/check-qobject.c
@@ -9,12 +9,12 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 
 #include <math.h>
 
diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index 79d4a8b89d..b814ded957 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -22,8 +22,8 @@
 
 #include "qapi/error.h"
 #include "qapi/qobject-input-visitor.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qobject.h"
+#include "qobject/qdict.h"
+#include "qobject/qobject.h"
 #include "qom/object.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
diff --git a/tests/unit/check-qstring.c b/tests/unit/check-qstring.c
index bd861f4f8b..2e6a00570f 100644
--- a/tests/unit/check-qstring.c
+++ b/tests/unit/check-qstring.c
@@ -11,7 +11,7 @@
  */
 #include "qemu/osdep.h"
 
-#include "qapi/qmp/qstring.h"
+#include "qobject/qstring.h"
 
 /*
  * Public Interface test-cases
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 3766d5de6b..5c227b2e3f 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -28,7 +28,7 @@
 #include "block/blockjob_int.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/main-loop.h"
 #include "iothread.h"
 
diff --git a/tests/unit/test-blockjob-txn.c b/tests/unit/test-blockjob-txn.c
index d3b0bb24be..199f6f5291 100644
--- a/tests/unit/test-blockjob-txn.c
+++ b/tests/unit/test-blockjob-txn.c
@@ -15,7 +15,7 @@
 #include "qemu/main-loop.h"
 #include "block/blockjob_int.h"
 #include "sysemu/block-backend.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 typedef struct {
     BlockJob common;
diff --git a/tests/unit/test-blockjob.c b/tests/unit/test-blockjob.c
index fe3e0d2d38..918d212661 100644
--- a/tests/unit/test-blockjob.c
+++ b/tests/unit/test-blockjob.c
@@ -15,7 +15,7 @@
 #include "qemu/main-loop.h"
 #include "block/blockjob_int.h"
 #include "sysemu/block-backend.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "iothread.h"
 
 static const BlockJobDriver test_block_job_driver = {
diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index 649fdf64e1..d3b20cc2ea 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -9,7 +9,7 @@
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-char.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qom/qom-qobject.h"
 #include "io/channel-socket.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/tests/unit/test-forward-visitor.c b/tests/unit/test-forward-visitor.c
index eea8ffc072..aad1c89f13 100644
--- a/tests/unit/test-forward-visitor.c
+++ b/tests/unit/test-forward-visitor.c
@@ -12,8 +12,8 @@
 #include "qapi/forward-visitor.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qobject.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qobject.h"
+#include "qobject/qdict.h"
 #include "test-qapi-visit.h"
 #include "qemu/keyval.h"
 
diff --git a/tests/unit/test-image-locking.c b/tests/unit/test-image-locking.c
index 2624cec6a0..7801876a01 100644
--- a/tests/unit/test-image-locking.c
+++ b/tests/unit/test-image-locking.c
@@ -28,7 +28,7 @@
 #include "block/block.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/main-loop.h"
 
 static BlockBackend *open_image(const char *path,
diff --git a/tests/unit/test-keyval.c b/tests/unit/test-keyval.c
index 4dc52c7a1a..c6e8f4fe37 100644
--- a/tests/unit/test-keyval.c
+++ b/tests/unit/test-keyval.c
@@ -13,9 +13,9 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "test-qapi-visit.h"
 #include "qemu/cutils.h"
diff --git a/tests/unit/test-qemu-opts.c b/tests/unit/test-qemu-opts.c
index 828d40e928..8d03a69f7c 100644
--- a/tests/unit/test-qemu-opts.c
+++ b/tests/unit/test-qemu-opts.c
@@ -12,8 +12,8 @@
 #include "qemu/option.h"
 #include "qemu/option_int.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qemu/config-file.h"
 
 
diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
index 671e83cb86..1cd3fa8673 100644
--- a/tests/unit/test-qga.c
+++ b/tests/unit/test-qga.c
@@ -5,8 +5,8 @@
 #include <sys/un.h>
 
 #include "../qtest/libqtest.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
 
 typedef struct {
     char *test_dir;
diff --git a/tests/unit/test-qmp-cmds.c b/tests/unit/test-qmp-cmds.c
index 6d52b4e5d8..ad53886886 100644
--- a/tests/unit/test-qmp-cmds.c
+++ b/tests/unit/test-qmp-cmds.c
@@ -1,9 +1,9 @@
 #include "qemu/osdep.h"
 #include "qapi/compat-policy.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qapi/error.h"
 #include "qapi/qobject-input-visitor.h"
 #include "tests/test-qapi-types.h"
diff --git a/tests/unit/test-qmp-event.c b/tests/unit/test-qmp-event.c
index 08e95a382b..2aac27163d 100644
--- a/tests/unit/test-qmp-event.c
+++ b/tests/unit/test-qmp-event.c
@@ -15,11 +15,11 @@
 
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qapi/qmp-event.h"
 #include "test-qapi-events.h"
 #include "test-qapi-emit-events.h"
diff --git a/tests/unit/test-qobject-input-visitor.c b/tests/unit/test-qobject-input-visitor.c
index 024e26c49e..559e9bfc02 100644
--- a/tests/unit/test-qobject-input-visitor.c
+++ b/tests/unit/test-qobject-input-visitor.c
@@ -17,12 +17,12 @@
 #include "qapi/qapi-visit-introspect.h"
 #include "qapi/qobject-input-visitor.h"
 #include "test-qapi-visit.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
+#include "qobject/qjson.h"
 #include "test-qapi-introspect.h"
 #include "qapi/qapi-introspect.h"
 
diff --git a/tests/unit/test-qobject-output-visitor.c b/tests/unit/test-qobject-output-visitor.c
index 1535b3ad17..513a24d113 100644
--- a/tests/unit/test-qobject-output-visitor.c
+++ b/tests/unit/test-qobject-output-visitor.c
@@ -15,12 +15,12 @@
 #include "qapi/error.h"
 #include "qapi/qobject-output-visitor.h"
 #include "test-qapi-visit.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 
 typedef struct TestOutputVisitorData {
     Visitor *ov;
diff --git a/tests/unit/test-replication.c b/tests/unit/test-replication.c
index 5d2003b8ce..32f2fbff6a 100644
--- a/tests/unit/test-replication.c
+++ b/tests/unit/test-replication.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/option.h"
 #include "qemu/main-loop.h"
 #include "block/replication.h"
diff --git a/tests/unit/test-visitor-serialization.c b/tests/unit/test-visitor-serialization.c
index c2056c3eaa..2d365999fc 100644
--- a/tests/unit/test-visitor-serialization.c
+++ b/tests/unit/test-visitor-serialization.c
@@ -16,8 +16,8 @@
 
 #include "test-qapi-visit.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qjson.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/string-input-visitor.h"
-- 
2.43.0


