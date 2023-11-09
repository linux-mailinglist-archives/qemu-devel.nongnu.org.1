Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B20FF7E6BBA
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:55:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15MR-0006Sg-FK; Thu, 09 Nov 2023 08:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15M5-0006DK-1t; Thu, 09 Nov 2023 08:45:58 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15M2-0001hJ-Pi; Thu, 09 Nov 2023 08:45:56 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5BB0431B13;
 Thu,  9 Nov 2023 16:43:13 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6004F344B9;
 Thu,  9 Nov 2023 16:43:05 +0300 (MSK)
Received: (nullmailer pid 1461842 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 27/55] util/uuid: Add UUID_STR_LEN definition
Date: Thu,  9 Nov 2023 16:42:31 +0300
Message-Id: <20231109134300.1461632-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Cédric Le Goater <clg@redhat.com>

qemu_uuid_unparse() includes a trailing NUL when writing the uuid
string and the buffer size should be UUID_FMT_LEN + 1 bytes. Add a
define for this size and use it where required.

Cc: Fam Zheng <fam@euphon.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: "Denis V. Lunev" <den@openvz.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 721da0396cfa0a4859cefb57e32cc79d19d80f54)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 8a109f005a..4d8ecf5047 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -130,7 +130,7 @@ static BdrvDirtyBitmap *parallels_load_bitmap(BlockDriverState *bs,
     g_autofree uint64_t *l1_table = NULL;
     BdrvDirtyBitmap *bitmap;
     QemuUUID uuid;
-    char uuidstr[UUID_FMT_LEN + 1];
+    char uuidstr[UUID_STR_LEN];
     int i;
 
     if (data_size < sizeof(bf)) {
diff --git a/block/vdi.c b/block/vdi.c
index 6c35309e04..af2feaa129 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -239,7 +239,7 @@ static void vdi_header_to_le(VdiHeader *header)
 
 static void vdi_header_print(VdiHeader *header)
 {
-    char uuidstr[37];
+    char uuidstr[UUID_STR_LEN];
     QemuUUID uuid;
     logout("text        %s", header->text);
     logout("signature   0x%08x\n", header->signature);
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 6d5d43eda2..d54f527728 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -1105,7 +1105,7 @@ static void get_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
 {
     Property *prop = opaque;
     QemuUUID *uuid = object_field_prop_ptr(obj, prop);
-    char buffer[UUID_FMT_LEN + 1];
+    char buffer[UUID_STR_LEN];
     char *p = buffer;
 
     qemu_uuid_unparse(uuid, buffer);
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 271289f902..c64eaa5a46 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -2271,7 +2271,7 @@ static void vmbus_dev_realize(DeviceState *dev, Error **errp)
     VMBus *vmbus = VMBUS(qdev_get_parent_bus(dev));
     BusChild *child;
     Error *err = NULL;
-    char idstr[UUID_FMT_LEN + 1];
+    char idstr[UUID_STR_LEN];
 
     assert(!qemu_uuid_is_null(&vdev->instanceid));
 
@@ -2467,7 +2467,7 @@ static char *vmbus_get_dev_path(DeviceState *dev)
 static char *vmbus_get_fw_dev_path(DeviceState *dev)
 {
     VMBusDevice *vdev = VMBUS_DEVICE(dev);
-    char uuid[UUID_FMT_LEN + 1];
+    char uuid[UUID_STR_LEN];
 
     qemu_uuid_unparse(&vdev->instanceid, uuid);
     return g_strdup_printf("%s@%s", qdev_fw_name(dev), uuid);
diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
index dc40ee1fc9..9e160d65aa 100644
--- a/include/qemu/uuid.h
+++ b/include/qemu/uuid.h
@@ -79,6 +79,7 @@ typedef struct {
                  "%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx"
 
 #define UUID_FMT_LEN 36
+#define UUID_STR_LEN (UUID_FMT_LEN + 1)
 
 #define UUID_NONE "00000000-0000-0000-0000-000000000000"
 
diff --git a/migration/savevm.c b/migration/savevm.c
index a2cb8855e2..d60c4f487a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -469,8 +469,8 @@ static bool vmstate_uuid_needed(void *opaque)
 static int vmstate_uuid_post_load(void *opaque, int version_id)
 {
     SaveState *state = opaque;
-    char uuid_src[UUID_FMT_LEN + 1];
-    char uuid_dst[UUID_FMT_LEN + 1];
+    char uuid_src[UUID_STR_LEN];
+    char uuid_dst[UUID_STR_LEN];
 
     if (!qemu_uuid_set) {
         /*
diff --git a/tests/unit/test-uuid.c b/tests/unit/test-uuid.c
index c111de5fc1..224c6d9936 100644
--- a/tests/unit/test-uuid.c
+++ b/tests/unit/test-uuid.c
@@ -145,7 +145,7 @@ static void test_uuid_unparse(void)
     int i;
 
     for (i = 0; i < ARRAY_SIZE(uuid_test_data); i++) {
-        char out[37];
+        char out[UUID_STR_LEN];
 
         if (!uuid_test_data[i].check_unparse) {
             continue;
diff --git a/util/uuid.c b/util/uuid.c
index b1108dde78..cedabea155 100644
--- a/util/uuid.c
+++ b/util/uuid.c
@@ -51,7 +51,7 @@ int qemu_uuid_is_equal(const QemuUUID *lhv, const QemuUUID *rhv)
 void qemu_uuid_unparse(const QemuUUID *uuid, char *out)
 {
     const unsigned char *uu = &uuid->data[0];
-    snprintf(out, UUID_FMT_LEN + 1, UUID_FMT,
+    snprintf(out, UUID_STR_LEN, UUID_FMT,
              uu[0], uu[1], uu[2], uu[3], uu[4], uu[5], uu[6], uu[7],
              uu[8], uu[9], uu[10], uu[11], uu[12], uu[13], uu[14], uu[15]);
 }
-- 
2.39.2


