Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AC170618A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 09:43:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzBnt-0005lU-JD; Wed, 17 May 2023 03:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pzBnr-0005lM-Pb
 for qemu-devel@nongnu.org; Wed, 17 May 2023 03:42:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pzBnq-0005ZU-0w
 for qemu-devel@nongnu.org; Wed, 17 May 2023 03:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684309349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0rwCbODQhlolH+DuUamkdk3WLjSdNqIQfdIQCvz/fE=;
 b=LDx0Mc1FEdfqJX7uG74CYOsHXQEJAheedNhQ1oqI3/eOOSQZrMdHMcvSG/MJxmYcpflhjC
 JOHOufv5Z4RcVLBNlRTJu0CD1RIPmSrUTTfiXxAab2ZkIJc7MJ1rHkZpTnwN+3zoOc/w8G
 GClBM7+escyTcfvq2MBj1GXo6f/32N4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-cVU3UXRUPTiHbEF1fQirnQ-1; Wed, 17 May 2023 03:42:27 -0400
X-MC-Unique: cVU3UXRUPTiHbEF1fQirnQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F08A8026E8;
 Wed, 17 May 2023 07:42:27 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F176B492B00;
 Wed, 17 May 2023 07:42:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>
Subject: [PATCH 1/2] include/exec: Make ld*_p and st*_p functions available
 for generic code, too
Date: Wed, 17 May 2023 09:42:21 +0200
Message-Id: <20230517074222.766683-2-thuth@redhat.com>
In-Reply-To: <20230517074222.766683-1-thuth@redhat.com>
References: <20230517074222.766683-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This will allow to move more code into the target independent source set.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/exec/cpu-all.h | 25 ----------------
 include/exec/tswap.h   | 66 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 25 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index ad824fee52..0daa4c06e5 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -55,31 +55,6 @@
 #define bswaptls(s) bswap64s(s)
 #endif
 
-/* Target-endianness CPU memory access functions. These fit into the
- * {ld,st}{type}{sign}{size}{endian}_p naming scheme described in bswap.h.
- */
-#if TARGET_BIG_ENDIAN
-#define lduw_p(p) lduw_be_p(p)
-#define ldsw_p(p) ldsw_be_p(p)
-#define ldl_p(p) ldl_be_p(p)
-#define ldq_p(p) ldq_be_p(p)
-#define stw_p(p, v) stw_be_p(p, v)
-#define stl_p(p, v) stl_be_p(p, v)
-#define stq_p(p, v) stq_be_p(p, v)
-#define ldn_p(p, sz) ldn_be_p(p, sz)
-#define stn_p(p, sz, v) stn_be_p(p, sz, v)
-#else
-#define lduw_p(p) lduw_le_p(p)
-#define ldsw_p(p) ldsw_le_p(p)
-#define ldl_p(p) ldl_le_p(p)
-#define ldq_p(p) ldq_le_p(p)
-#define stw_p(p, v) stw_le_p(p, v)
-#define stl_p(p, v) stl_le_p(p, v)
-#define stq_p(p, v) stq_le_p(p, v)
-#define ldn_p(p, sz) ldn_le_p(p, sz)
-#define stn_p(p, sz, v) stn_le_p(p, sz, v)
-#endif
-
 /* MMU memory access macros */
 
 #if defined(CONFIG_USER_ONLY)
diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 68944a880b..2774820bbe 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -69,4 +69,70 @@ static inline void tswap64s(uint64_t *s)
     }
 }
 
+/*
+ * Target-endianness CPU memory access functions. These fit into the
+ * {ld,st}{type}{sign}{size}{endian}_p naming scheme described in bswap.h.
+ */
+
+static inline int lduw_p(const void *ptr)
+{
+    return (uint16_t)tswap16(lduw_he_p(ptr));
+}
+
+static inline int ldsw_p(const void *ptr)
+{
+    return (int16_t)tswap16(lduw_he_p(ptr));
+}
+
+static inline int ldl_p(const void *ptr)
+{
+    return tswap32(ldl_he_p(ptr));
+}
+
+static inline uint64_t ldq_p(const void *ptr)
+{
+    return tswap64(ldq_he_p(ptr));
+}
+
+static inline uint64_t ldn_p(const void *ptr, int sz)
+{
+    if (target_needs_bswap()) {
+#if HOST_BIG_ENDIAN
+        return ldn_le_p(ptr, sz);
+#else
+        return ldn_be_p(ptr, sz);
+#endif
+    } else {
+        return ldn_he_p(ptr, sz);
+    }
+}
+
+static inline void stw_p(void *ptr, uint16_t v)
+{
+    stw_he_p(ptr, tswap16(v));
+}
+
+static inline void stl_p(void *ptr, uint32_t v)
+{
+    stl_he_p(ptr, tswap32(v));
+}
+
+static inline void stq_p(void *ptr, uint64_t v)
+{
+    stq_he_p(ptr, tswap64(v));
+}
+
+static inline void stn_p(void *ptr, int sz, uint64_t v)
+{
+    if (target_needs_bswap()) {
+#if HOST_BIG_ENDIAN
+        stn_le_p(ptr, sz, v);
+#else
+        stn_be_p(ptr, sz, v);
+#endif
+    } else {
+        stn_he_p(ptr, sz, v);
+    }
+}
+
 #endif  /* TSWAP_H */
-- 
2.31.1


