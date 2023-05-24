Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 683FA70F1F2
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:14:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kZ5-0004LF-LX; Wed, 24 May 2023 05:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1q1kYz-0004JN-Lk
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:13:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1q1kYy-0001GJ-54
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684919623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qHlZw09p+JUrVPXp/EvbgsdT06790mVZ8jB28AHeJmg=;
 b=afrDjmtseWB7Rf1o6tSVeDUAA4g/vSQZiNgJF/CadwztUIh6VWXM8TZW2Gdzz2e2IhwiBb
 JOs4WCIA8itEEH1zPgRRCo7qBBsZmGk1/3CofaFGgEkETN53ORYAdWD7v5uUEoLNuiWsr9
 h+iId9L9+HsWcvANtI00AiU0Glna820=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-84HrIvKYPuapF0iqa4jFew-1; Wed, 24 May 2023 05:13:38 -0400
X-MC-Unique: 84HrIvKYPuapF0iqa4jFew-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E093800141;
 Wed, 24 May 2023 09:13:38 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F440400F17;
 Wed, 24 May 2023 09:13:36 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Albert Esteve <aesteve@redhat.com>,
 marcandre.lureau@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>,
 cohuck@redhat.com, Fam Zheng <fam@euphon.net>
Subject: [PATCH v3 1/4] uuid: add hash_func and equal_func
Date: Wed, 24 May 2023 11:13:30 +0200
Message-Id: <20230524091333.201767-2-aesteve@redhat.com>
In-Reply-To: <20230524091333.201767-1-aesteve@redhat.com>
References: <20230524091333.201767-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
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
 include/qemu/uuid.h    |  2 ++
 tests/unit/test-uuid.c | 27 +++++++++++++++++++++++++++
 util/uuid.c            | 14 ++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
index dc40ee1fc9..e24a1099e4 100644
--- a/include/qemu/uuid.h
+++ b/include/qemu/uuid.h
@@ -96,4 +96,6 @@ int qemu_uuid_parse(const char *str, QemuUUID *uuid);
 
 QemuUUID qemu_uuid_bswap(QemuUUID uuid);
 
+uint32_t qemu_uuid_hash(const void *uuid);
+
 #endif
diff --git a/tests/unit/test-uuid.c b/tests/unit/test-uuid.c
index c111de5fc1..aedc125ae9 100644
--- a/tests/unit/test-uuid.c
+++ b/tests/unit/test-uuid.c
@@ -171,6 +171,32 @@ static void test_uuid_unparse_strdup(void)
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
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -179,6 +205,7 @@ int main(int argc, char **argv)
     g_test_add_func("/uuid/parse", test_uuid_parse);
     g_test_add_func("/uuid/unparse", test_uuid_unparse);
     g_test_add_func("/uuid/unparse_strdup", test_uuid_unparse_strdup);
+    g_test_add_func("/uuid/hash", test_uuid_hash);
 
     return g_test_run();
 }
diff --git a/util/uuid.c b/util/uuid.c
index b1108dde78..64eaf2e208 100644
--- a/util/uuid.c
+++ b/util/uuid.c
@@ -116,3 +116,17 @@ QemuUUID qemu_uuid_bswap(QemuUUID uuid)
     bswap16s(&uuid.fields.time_high_and_version);
     return uuid;
 }
+
+uint32_t qemu_uuid_hash(const void *uuid)
+{
+    QemuUUID *qid = (QemuUUID *) uuid;
+    uint32_t h = 5381;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(qid->data); i++) {
+        h = (h << 5) + h + qid->data[i];
+    }
+
+    return h;
+}
+
-- 
2.40.0


