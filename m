Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B85257B7AFE
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:03:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxY2-00035t-Gh; Wed, 04 Oct 2023 04:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxWo-0000X2-6z
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxWe-0002ZE-LS
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tctm3+uo+cxVRzR1eAsWLGEe5b6Azf26SVqS4Nhd8Io=;
 b=cbmvz5fXnoA7eKYhwfA64JaEH/g1RSvdfhUP3YNGpDuHX3tPOWe33K6XBPhuklgGoeWtj2
 vqxp5+DUijWmPS8XYU03wB5s7rSBQROw6RfGuqZIpqFC8OoNG4L7XZSL/a1G9/gIa8PVXM
 fnbh4RJgRm5GOummra8Clt0qrywm/AE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-Pybo4qLAPAufOnYgHbTKTQ-1; Wed, 04 Oct 2023 04:46:27 -0400
X-MC-Unique: Pybo4qLAPAufOnYgHbTKTQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4055ce1e8c4so2950045e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409186; x=1697013986;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tctm3+uo+cxVRzR1eAsWLGEe5b6Azf26SVqS4Nhd8Io=;
 b=Z/dfeZVWOjC5A0G/NGMxGXDyRGMTXcHGrVTvX1ex7yovvvLyXuAdI0zJrXxXTOi32J
 ZMn6FxLES3Bj3N/0CQqj5PQ++MSUnMx75xgkxelbkooFD2hunxHDpRp9R6gSfVyt9fOE
 XmO0wJus/bnbTFqkhxkgmREgmLki0GmIA+jLmm/q9Zi+yVUZmB2y9Z8xMuHFlZq/QgJ/
 y+y4WF6NxUR2g+ThBp26pn0k66d7P0LBBu8yyAv/IKZTG2ls+lYdIeaVI4Ub/0sHhkZw
 +JERDzQ04iTth3XSzSPLrm2o9ZTevAkTt80WB0rQEp/29Fu3tq5nz1mcfB2tlb7ZU719
 O+Bg==
X-Gm-Message-State: AOJu0YzVHLWcrXDMOG8k/SGBkaiBbjwig/WQJKRZk5j7ZPFXHGX/9Lr9
 bUE8Ln9mpNdhFvDs+sEp/VTS+25ilHqOqRDCRN+6z3xcc+zca0N84lscInH6yg1gZZV7lyHKjkn
 N2iwLRrXQbQXpw4ccg+znepFWAW4ZKm3/UjANhTLrIpM9Xd0OrZxEZ+RWO9Yu0V78SCzV
X-Received: by 2002:a5d:560c:0:b0:323:31a6:c1db with SMTP id
 l12-20020a5d560c000000b0032331a6c1dbmr4115315wrv.21.1696409185957; 
 Wed, 04 Oct 2023 01:46:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmYAW0aUka2pH0ONLZ7vMTS1ajrLyfNx19vfasnywaQ943UIV+9oiQr+2/YLYn0cN5y8QThg==
X-Received: by 2002:a5d:560c:0:b0:323:31a6:c1db with SMTP id
 l12-20020a5d560c000000b0032331a6c1dbmr4115295wrv.21.1696409185702; 
 Wed, 04 Oct 2023 01:46:25 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 m11-20020a7bce0b000000b004064741f855sm931239wmc.47.2023.10.04.01.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:46:25 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:46:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>
Subject: [PULL 60/63] util/uuid: add a hash function
Message-ID: <210b58ac9937b2c36a38ee8713348b82ce45b1ac.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Albert Esteve <aesteve@redhat.com>

Add hash function to uuid module using the
djb2 hash algorithm.

Add a couple simple unit tests for the hash
function, checking collisions for similar UUIDs.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
Message-Id: <20231002065706.94707-2-aesteve@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
index b1108dde78..d71aa79e5e 100644
--- a/util/uuid.c
+++ b/util/uuid.c
@@ -116,3 +116,17 @@ QemuUUID qemu_uuid_bswap(QemuUUID uuid)
     bswap16s(&uuid.fields.time_high_and_version);
     return uuid;
 }
+
+/* djb2 hash algorithm */
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
-- 
MST


