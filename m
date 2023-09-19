Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4247A5FA9
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:33:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiY16-0003bq-6D; Tue, 19 Sep 2023 06:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiY0B-00035e-Br
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:30:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiY08-0001tk-RP
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695119438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6HgdQH47DM9/NzGcGmXTYLC6e/C4wULYSQJK2pILQe8=;
 b=YRHpe3lOiZyCcWdDI8elqk3Y4TVSe/iqFa4spJIqGnkqKTC2bSJP0RydZiCj/M6ActDqfL
 x/0rbyxVziEwtVEwz8SFfFj7I719XDYeEA+nIXivpEOs7rOW7GyA5ocG+Q9Tv8SSMbhz4L
 jIwgfCyI2euJg3uAUzADAxRgs7pvx0A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-EQcKJpNEPA-Bo9rs9xAvRA-1; Tue, 19 Sep 2023 06:30:36 -0400
X-MC-Unique: EQcKJpNEPA-Bo9rs9xAvRA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 676D8805B32
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 10:30:36 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8D1540C6EBF;
 Tue, 19 Sep 2023 10:30:35 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: [GIT PULL 06/12] softmmu/physmem: Fail creation of new files in
 file_ram_open() with readonly=true
Date: Tue, 19 Sep 2023 12:30:23 +0200
Message-ID: <20230919103029.235736-7-david@redhat.com>
In-Reply-To: <20230919103029.235736-1-david@redhat.com>
References: <20230919103029.235736-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Currently, if a file does not exist yet, file_ram_open() will create new
empty file and open it writable. However, it even does that when
readonly=true was specified.

Specifying O_RDONLY instead to create a new readonly file would
theoretically work, however, ftruncate() will refuse to resize the new
empty file and we'll get a warning:
    ftruncate: Invalid argument
And later eventually more problems when actually mmap'ing that file and
accessing it.

If someone intends to let QEMU open+mmap a file read-only, better
create+resize+fill that file ahead of time outside of QEMU context.

We'll now fail with:
./qemu-system-x86_64 \
    -object memory-backend-file,id=ram0,mem-path=tmp,readonly=true,size=1g
qemu-system-x86_64: can't open backing store tmp for guest RAM: No such file or directory

All use cases of readonly files (R/O NVDIMMs, VM templating) work on
existing files, so silently creating new files might just hide user
errors when accidentally specifying a non-existent file.

Note that the only memory-backend-file will end up calling
memory_region_init_ram_from_file() -> qemu_ram_alloc_from_file() ->
file_ram_open().

Move error reporting to the single caller.

Message-ID: <20230906120503.359863-7-david@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 softmmu/physmem.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index c520c2ac55..138402b6cf 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1288,8 +1288,7 @@ static int64_t get_file_align(int fd)
 static int file_ram_open(const char *path,
                          const char *region_name,
                          bool readonly,
-                         bool *created,
-                         Error **errp)
+                         bool *created)
 {
     char *filename;
     char *sanitized_name;
@@ -1304,6 +1303,10 @@ static int file_ram_open(const char *path,
             break;
         }
         if (errno == ENOENT) {
+            if (readonly) {
+                /* Refuse to create new, readonly files. */
+                return -ENOENT;
+            }
             /* @path names a file that doesn't exist, create it */
             fd = open(path, O_RDWR | O_CREAT | O_EXCL, 0644);
             if (fd >= 0) {
@@ -1333,10 +1336,7 @@ static int file_ram_open(const char *path,
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
@@ -1946,8 +1946,10 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
     RAMBlock *block;
 
     fd = file_ram_open(mem_path, memory_region_name(mr),
-                       !!(ram_flags & RAM_READONLY_FD), &created, errp);
+                       !!(ram_flags & RAM_READONLY_FD), &created);
     if (fd < 0) {
+        error_setg_errno(errp, -fd, "can't open backing store %s for guest RAM",
+                         mem_path);
         return NULL;
     }
 
-- 
2.41.0


