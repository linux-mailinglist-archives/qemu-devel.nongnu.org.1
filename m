Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A557B9A78
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:49:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFJR-0000fV-7r; Wed, 04 Oct 2023 23:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFJH-0000HC-AT
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFJC-0000or-I7
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tctm3+uo+cxVRzR1eAsWLGEe5b6Azf26SVqS4Nhd8Io=;
 b=eXVih8fhFKFv+6x3fsXbHOGZVWnD9WkPOWruEP8Jk/bOtdXkElVihascwlEv3qAifMEc0a
 HqqJyCME3ydvhEwvH7/TVG2cbutfVTd5L3t65umCA/rf4dcRJNHTSYZlIJS1NSX14QBT5G
 x4eUjfJTVhRlIH5uRqeyGjO8AXlughI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-zqNP7IyiP-m9xH60L4u8NA-1; Wed, 04 Oct 2023 23:45:52 -0400
X-MC-Unique: zqNP7IyiP-m9xH60L4u8NA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-405535740d2so3377745e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477551; x=1697082351;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tctm3+uo+cxVRzR1eAsWLGEe5b6Azf26SVqS4Nhd8Io=;
 b=JaUx4hq1fgm2WGZCdKx9PVELENAs+1MPICJ7pKsTXbldR3ai/9HjpLJ9XJpLjCMUyf
 MFjcamTjMQ8NqVesmzUiD3vvYXTDdouZQXqQ9ljZOWQCHV4MhB+ubF0pNDFn7fyTFkL3
 NqTMWfN+iDYRoUjaYgset0dOqo9QrbXThEM1V4DIMu/NWf+GJdOYig317bGAAC6x9fOU
 Mtgv2J9ogrBgr5EeJcEBpJzXXzeYWsvw7+SGnSSaM6Nvs+9KjBwgzVQNcsF2upSYCeTA
 MEtZiY8+Jyq6FflpWeF2PR8BZtdy9+1NTlj2sn5sGm3ordAAbrByjH1RM72cGWUkRfkd
 MheA==
X-Gm-Message-State: AOJu0Yzar0VJbwXoaIPL2n6RrIXPHGuDqJvhXZrJylMnr7dpbYlhVCEJ
 rIA/ngKklqXv5CVjVxJCIMdWtBRUKcusqVdExIbSlDwXsClDuykEDBBOPZrXCs0zpRHkdaLo90t
 AsC5dTiR2q9KYYopwhNtE+4AxxNVhOCq/kMYKp8jdomIgwUN2D2GQty/OZQCQO0w9TOZr
X-Received: by 2002:a1c:4c10:0:b0:402:f8eb:28d8 with SMTP id
 z16-20020a1c4c10000000b00402f8eb28d8mr3834728wmf.6.1696477550944; 
 Wed, 04 Oct 2023 20:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCiT7PtRntGlHemVVDYg9MPUiIu4p7LcVIDr9vdB/qWNLG2gAWobKBYKzCwcSf9Ma3TGIYdA==
X-Received: by 2002:a1c:4c10:0:b0:402:f8eb:28d8 with SMTP id
 z16-20020a1c4c10000000b00402f8eb28d8mr3834714wmf.6.1696477550500; 
 Wed, 04 Oct 2023 20:45:50 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c378400b003fc0505be19sm526383wmr.37.2023.10.04.20.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:45:49 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:45:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>
Subject: [PULL v2 50/53] util/uuid: add a hash function
Message-ID: <a6ceee591acdb9c9c772bf59544a57891308222e.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
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


