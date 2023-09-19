Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 382B07A5FA0
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:32:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiY1Z-0004qG-Qn; Tue, 19 Sep 2023 06:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiY0D-00036U-Bb
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiY0B-0001v1-Fr
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695119442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pu2YDx5aiS5CvUaCOfL0u8qxACu7nY4VGE1cPIwI+mE=;
 b=Vug24Kqx3u+wHI+OQrI1Rz1xMEMIYZJqCdULbxq8IFGxe5jCY+YXuwiWAJXBctGbNsfI9j
 V55XPZmjc0wMK58b10EdVR/4PbeKN2kne0vMUM4MTuWlsa95ghKsgpqK32wXDOtI8Dnvvp
 LBMHgkapW4LMa3NmZYfMVx8/f0I5bXM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-jYh8I5fcOsuLzvNHaQ2lUA-1; Tue, 19 Sep 2023 06:30:37 -0400
X-MC-Unique: jYh8I5fcOsuLzvNHaQ2lUA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A764803470;
 Tue, 19 Sep 2023 10:30:37 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F6D240C6EBF;
 Tue, 19 Sep 2023 10:30:36 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Thiner Logoer <logoerthiner1@163.com>, Peter Xu <peterx@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [GIT PULL 07/12] softmmu/physmem: Never return directories from
 file_ram_open()
Date: Tue, 19 Sep 2023 12:30:24 +0200
Message-ID: <20230919103029.235736-8-david@redhat.com>
In-Reply-To: <20230919103029.235736-1-david@redhat.com>
References: <20230919103029.235736-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

open() does not fail on directories when opening them readonly (O_RDONLY).

Currently, we succeed opening such directories and fail later during
mmap(), resulting in a misleading error message.

$ ./qemu-system-x86_64 \
    -object memory-backend-file,id=ram0,mem-path=tmp,readonly=true,size=1g
 qemu-system-x86_64: unable to map backing store for guest RAM: No such device

To identify directories and handle them accordingly in file_ram_open()
also when readonly=true was specified, detect if we just opened a directory
using fstat() instead. Then, fail file_ram_open() right away, similarly
to how we now fail if the file does not exist and we want to open the
file readonly.

With this change, we get a nicer error message:
 qemu-system-x86_64: can't open backing store tmp for guest RAM: Is a directory

Note that the only memory-backend-file will end up calling
memory_region_init_ram_from_file() -> qemu_ram_alloc_from_file() ->
file_ram_open().

Message-ID: <20230906120503.359863-8-david@redhat.com>
Reported-by: Thiner Logoer <logoerthiner1@163.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 softmmu/physmem.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 138402b6cf..f1cd3ec28a 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1299,6 +1299,25 @@ static int file_ram_open(const char *path,
     for (;;) {
         fd = open(path, readonly ? O_RDONLY : O_RDWR);
         if (fd >= 0) {
+            /*
+             * open(O_RDONLY) won't fail with EISDIR. Check manually if we
+             * opened a directory and fail similarly to how we fail ENOENT
+             * in readonly mode. Note that mkstemp() would imply O_RDWR.
+             */
+            if (readonly) {
+                struct stat file_stat;
+
+                if (fstat(fd, &file_stat)) {
+                    close(fd);
+                    if (errno == EINTR) {
+                        continue;
+                    }
+                    return -errno;
+                } else if (S_ISDIR(file_stat.st_mode)) {
+                    close(fd);
+                    return -EISDIR;
+                }
+            }
             /* @path names an existing file, use it */
             break;
         }
-- 
2.41.0


