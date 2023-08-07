Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D37A3772E83
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 21:08:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT5a3-0003j8-04; Mon, 07 Aug 2023 15:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qT5Zz-0003i8-JN
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 15:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qT5Zy-0005oG-26
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 15:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691435265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ahHtgE5Le4Ql7CB4JIAfDzkB520q7jcsgBSrxoiy7SM=;
 b=KIheJiKNoYzET/hPlBpbNteSVdRjBJ9AIMkNThXFokNolLLFNPr68LMoDSlUAXcuu0Aqn0
 ziiUlcS+hMLAi0I2WNtDJRMH4/3DiQBYw+t6TNZNHEByHS/N1iiZYwBl22Q9AorjcG5U1Y
 TSb/NariquM6/glVlOpL3xcXmOO9mOQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-kZM7mED7NPGphC6nxgIQpg-1; Mon, 07 Aug 2023 15:07:41 -0400
X-MC-Unique: kZM7mED7NPGphC6nxgIQpg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4C6385CCE5;
 Mon,  7 Aug 2023 19:07:40 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AD994021B9;
 Mon,  7 Aug 2023 19:07:39 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM file as
 readonly in a MAP_PRIVATE mapping
Date: Mon,  7 Aug 2023 21:07:32 +0200
Message-ID: <20230807190736.572665-2-david@redhat.com>
In-Reply-To: <20230807190736.572665-1-david@redhat.com>
References: <20230807190736.572665-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

From: Thiner Logoer <logoerthiner1@163.com>

Users may specify
* "-mem-path" or
* "-object memory-backend-file,share=off,readonly=off"
and expect such COW (MAP_PRIVATE) mappings to work, even if the user
does not have write permissions to open the file.

For now, we would always fail in that case, always requiring file write
permissions. Let's detect when that failure happens and fallback to opening
the file readonly.

Warn the user, since there are other use cases where we want the file to
be mapped writable: ftruncate() and fallocate() will fail if the file
was not opened with write permissions.

Signed-off-by: Thiner Logoer <logoerthiner1@163.com>
Co-developed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 softmmu/physmem.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 3df73542e1..d1ae694b20 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1289,8 +1289,7 @@ static int64_t get_file_align(int fd)
 static int file_ram_open(const char *path,
                          const char *region_name,
                          bool readonly,
-                         bool *created,
-                         Error **errp)
+                         bool *created)
 {
     char *filename;
     char *sanitized_name;
@@ -1334,10 +1333,7 @@ static int file_ram_open(const char *path,
             g_free(filename);
         }
         if (errno != EEXIST && errno != EINTR) {
-            error_setg_errno(errp, errno,
-                             "can't open backing store %s for guest RAM",
-                             path);
-            return -1;
+            return -errno;
         }
         /*
          * Try again on EINTR and EEXIST.  The latter happens when
@@ -1946,9 +1942,23 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
     bool created;
     RAMBlock *block;
 
-    fd = file_ram_open(mem_path, memory_region_name(mr), readonly, &created,
-                       errp);
+    fd = file_ram_open(mem_path, memory_region_name(mr), readonly, &created);
+    if (fd == -EACCES && !(ram_flags & RAM_SHARED) && !readonly) {
+        /*
+         * We can have a writable MAP_PRIVATE mapping of a readonly file.
+         * However, some operations like ftruncate() or fallocate() might fail
+         * later, let's warn the user.
+         */
+        fd = file_ram_open(mem_path, memory_region_name(mr), true, &created);
+        if (fd >= 0) {
+            warn_report("backing store %s for guest RAM (MAP_PRIVATE) opened"
+                        " readonly because the file is not writable", mem_path);
+        }
+    }
     if (fd < 0) {
+        error_setg_errno(errp, -fd,
+                         "can't open backing store %s for guest RAM",
+                         mem_path);
         return NULL;
     }
 
-- 
2.41.0


