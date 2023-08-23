Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7E9785C40
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 17:37:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYpu6-0004VZ-5y; Wed, 23 Aug 2023 11:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYpsY-0001xS-DL
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 11:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYpsW-000822-Ur
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 11:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692804879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TwJjkgHsvXEBoKNEpyqvsbIlhmZVjsh0HgCHFDNzu50=;
 b=O+koEOwqsAnHLlL33cIOnTFYfc/8NyZFc7e3JI1RtKL8ExDzP7YzxB2Xd+EJP2V3T0+xmE
 sqSsjksigYLlrorx3HTnT4yleyrM5flC/TWnTLWgYYCehvsWakun/tGAV9UG3UMrP1+IrJ
 kESNMH642f89L3NW030Ci4R1epjD2Tk=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-EftSaAWGO7ueTBRapkvIIw-1; Wed, 23 Aug 2023 11:34:34 -0400
X-MC-Unique: EftSaAWGO7ueTBRapkvIIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E690928040A7;
 Wed, 23 Aug 2023 15:34:33 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F1FA1121314;
 Wed, 23 Aug 2023 15:34:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v3 06/11] softmmu/physmem: Fail creation of new files in
 file_ram_open() with readonly=true
Date: Wed, 23 Aug 2023 17:34:06 +0200
Message-ID: <20230823153412.832081-7-david@redhat.com>
In-Reply-To: <20230823153412.832081-1-david@redhat.com>
References: <20230823153412.832081-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 softmmu/physmem.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 32d641754b..f8c47ecb85 100644
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
@@ -1305,6 +1304,10 @@ static int file_ram_open(const char *path,
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
@@ -1334,10 +1337,7 @@ static int file_ram_open(const char *path,
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
@@ -1947,8 +1947,10 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
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


