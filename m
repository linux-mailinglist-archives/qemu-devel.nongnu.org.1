Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 333B47D7D59
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 09:08:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvuSO-0002tw-QW; Thu, 26 Oct 2023 03:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=sG9D=GI=redhat.com=clg@ozlabs.org>)
 id 1qvuSL-0002tJ-HB
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 03:07:01 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=sG9D=GI=redhat.com=clg@ozlabs.org>)
 id 1qvuSI-0001IE-Rn
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 03:07:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SGH0X6zCgz4wp0;
 Thu, 26 Oct 2023 18:06:52 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGH0S0KWkz4wcd;
 Thu, 26 Oct 2023 18:06:47 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/3] util/uuid: Add UUID_STR_LEN definition
Date: Thu, 26 Oct 2023 09:06:34 +0200
Message-ID: <20231026070636.1165037-2-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231026070636.1165037-1-clg@redhat.com>
References: <20231026070636.1165037-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=sG9D=GI=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qemu_uuid_unparse() includes a trailing NUL when writing the uuid
string and the buffer size should be UUID_FMT_LEN + 1 bytes. Add a
define for this size and use it where required.

Cc: Fam Zheng <fam@euphon.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/qemu/uuid.h              | 1 +
 block/parallels-ext.c            | 2 +-
 block/vdi.c                      | 2 +-
 hw/core/qdev-properties-system.c | 2 +-
 hw/hyperv/vmbus.c                | 4 ++--
 migration/savevm.c               | 4 ++--
 tests/unit/test-uuid.c           | 2 +-
 util/uuid.c                      | 2 +-
 8 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
index e24a1099e45f2dfc330a578d3ccbe74f3e52e6c1..4e7afaf1d5bd5d382fefbd6f6275d69cf25e7483 100644
--- a/include/qemu/uuid.h
+++ b/include/qemu/uuid.h
@@ -79,6 +79,7 @@ typedef struct {
                  "%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx"
 
 #define UUID_FMT_LEN 36
+#define UUID_STR_LEN (UUID_FMT_LEN + 1)
 
 #define UUID_NONE "00000000-0000-0000-0000-000000000000"
 
diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 8a109f005ae73e848658e3f044968307a0bfd99d..4d8ecf5047abfe4ba0e7273139638649f5d101a0 100644
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
index fd7e3653832f890776e03a845a157fede10655b3..fa6e5e198c5d8f4047f0ecddece2493158fe6bc2 100644
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
index 8e0acf50d6ca045938a44d6d72547607f919ca79..e2130c7d989ebcdb3195cc6040025c732acf4338 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -1100,7 +1100,7 @@ static void get_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
 {
     Property *prop = opaque;
     QemuUUID *uuid = object_field_prop_ptr(obj, prop);
-    char buffer[UUID_FMT_LEN + 1];
+    char buffer[UUID_STR_LEN];
     char *p = buffer;
 
     qemu_uuid_unparse(uuid, buffer);
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 271289f902f812ad1aeac3ee426249bba02a9d41..c64eaa5a46a04433dfc33313bbd4fdda8c619868 100644
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
diff --git a/migration/savevm.c b/migration/savevm.c
index 8622f229e517f2ad8af80d3654146c16827be2e1..d5f3eafe3b15e289fd64ef5b6ded8bb3b1670596 100644
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
index aedc125ae98fb3a0b343603f2f0d022f4b8161c4..739b91583cfd97bb4d18256408338695fe87ef15 100644
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
index d71aa79e5ea433a9f3216b0b24d6276086607604..234619dd5e69a694d47bb299eb2536e5790b9863 100644
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
2.41.0


