Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 912BD7080A8
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:04:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzcLv-0000xV-0A; Thu, 18 May 2023 08:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1pzcLk-0000ww-V2
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:03:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1pzcLd-0007De-FT
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684411387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VxYe6LEMdmAR4YczXo8N6Nk4IE8l+1cya1Ruh95zB9E=;
 b=c3dRVYwGtUvuQMtEmF1rScvxMOwI1VGKh9esGZRe4Y+bsbAKiy8+5RRLgbF68fvfgK7HVh
 HF0L/87RYj8m+364vBwk9shJMR/iRcoWVsVJMsrrUSKWjYyteikXv1NbYuzNR+ZYWxxt8Z
 I+cYoTna2QpI+oZuzDkJWu4C9N5q/bk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-aVgjHvMUN6u1EvyNck1ZcA-1; Thu, 18 May 2023 08:03:04 -0400
X-MC-Unique: aVgjHvMUN6u1EvyNck1ZcA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C9A6101A551;
 Thu, 18 May 2023 12:03:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B1731121314;
 Thu, 18 May 2023 12:03:02 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>,
 kraxel@redhat.com, Fam Zheng <fam@euphon.net>,
 Albert Esteve <aesteve@redhat.com>, cohuck@redhat.com
Subject: [PATCH v2 1/4] uuid: add hash_func and equal_func
Date: Thu, 18 May 2023 14:02:55 +0200
Message-Id: <20230518120258.1394135-2-aesteve@redhat.com>
In-Reply-To: <20230518120258.1394135-1-aesteve@redhat.com>
References: <20230518120258.1394135-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Add hash and an equal function to uuid module.

Add a couple simple unit tests for new functions,
checking collisions for similar UUIDs in the case
of the hash function, and comparing generated UUIDs
for the equal function.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 include/qemu/uuid.h    |  4 ++++
 tests/unit/test-uuid.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 util/uuid.c            | 38 ++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
index dc40ee1fc9..136df682c9 100644
--- a/include/qemu/uuid.h
+++ b/include/qemu/uuid.h
@@ -96,4 +96,8 @@ int qemu_uuid_parse(const char *str, QemuUUID *uuid);
 
 QemuUUID qemu_uuid_bswap(QemuUUID uuid);
 
+uint32_t qemu_uuid_hash(const void *uuid);
+
+int qemu_uuid_equal(const void *lhv, const void *rhv);
+
 #endif
diff --git a/tests/unit/test-uuid.c b/tests/unit/test-uuid.c
index c111de5fc1..8c865869d5 100644
--- a/tests/unit/test-uuid.c
+++ b/tests/unit/test-uuid.c
@@ -171,6 +171,50 @@ static void test_uuid_unparse_strdup(void)
     }
 }
 
+static void test_uuid_hash(void)
+{
+    QemuUUID uuid;
+    int i;
+
+    for (i = 0; i < 100; i++) {
+        qemu_uuid_generate(&uuid);
+        /* Obtain the UUID hash */
+        uint32_t hash_a = qemu_uuid_hash(&uuid);
+        int data_idx = g_random_int_range(0, 15);
+        /* Change a single random byte of the UUID */
+        if (uuid.data[data_idx] < 0xFF) {
+            uuid.data[data_idx]++;
+        } else {
+            uuid.data[data_idx]--;
+        }
+        /* Obtain the UUID hash again */
+        uint32_t hash_b = qemu_uuid_hash(&uuid);
+        /*
+         * Both hashes shall be different (avoid collision)
+         * for any change in the UUID fields
+         */
+        g_assert_cmpint(hash_a, !=, hash_b);
+    }
+}
+
+static void test_uuid_equal(void)
+{
+    QemuUUID uuid_a, uuid_b, uuid_c;
+    int i;
+
+    for (i = 0; i < 100; i++) {
+        qemu_uuid_generate(&uuid_a);
+        qemu_uuid_generate(&uuid_b);
+        memcpy(&uuid_c, &uuid_a, sizeof(uuid_a));
+
+        g_assert(qemu_uuid_equal(&uuid_a, &uuid_a));
+        g_assert(qemu_uuid_equal(&uuid_b, &uuid_b));
+        g_assert(qemu_uuid_equal(&uuid_a, &uuid_c));
+        g_assert_false(qemu_uuid_equal(&uuid_a, &uuid_b));
+        g_assert_false(qemu_uuid_equal(NULL, NULL));
+    }
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -179,6 +223,8 @@ int main(int argc, char **argv)
     g_test_add_func("/uuid/parse", test_uuid_parse);
     g_test_add_func("/uuid/unparse", test_uuid_unparse);
     g_test_add_func("/uuid/unparse_strdup", test_uuid_unparse_strdup);
+    g_test_add_func("/uuid/hash", test_uuid_hash);
+    g_test_add_func("/uuid/equal", test_uuid_equal);
 
     return g_test_run();
 }
diff --git a/util/uuid.c b/util/uuid.c
index b1108dde78..efa9b0a0e4 100644
--- a/util/uuid.c
+++ b/util/uuid.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu/uuid.h"
 #include "qemu/bswap.h"
+#include "qemu/xxhash.h"
 
 void qemu_uuid_generate(QemuUUID *uuid)
 {
@@ -116,3 +117,40 @@ QemuUUID qemu_uuid_bswap(QemuUUID uuid)
     bswap16s(&uuid.fields.time_high_and_version);
     return uuid;
 }
+
+uint32_t qemu_uuid_hash(const void *uuid)
+{
+    QemuUUID *id = (QemuUUID *) uuid;
+    uint64_t ab = (id->fields.time_low) |
+                  (((uint64_t) id->fields.time_mid) << 32) |
+                  (((uint64_t) id->fields.time_high_and_version) << 48);
+    uint64_t cd = (id->fields.clock_seq_and_reserved) |
+                  (id->fields.clock_seq_low << 8);
+    int i = 0, shift = 8;
+
+    for (; i < 6; i++) {
+        shift += 8;
+        cd |= ((uint64_t) id->fields.node[i]) << shift;
+    }
+
+    return qemu_xxhash4(ab, cd);
+}
+
+int qemu_uuid_equal(const void *lhv, const void *rhv)
+{
+    int i;
+    QemuUUID *lid = (QemuUUID *) lhv;
+    QemuUUID *rid = (QemuUUID *) rhv;
+    if (lid == NULL || rid == NULL) {
+        return 0;
+    }
+    if (lid == rid) {
+        return 1;
+    }
+    for (i = 0; i < 16; i++) {
+        if (lid->data[i] != rid->data[i]) {
+            return 0;
+        }
+    }
+    return 1;
+}
-- 
2.40.0


