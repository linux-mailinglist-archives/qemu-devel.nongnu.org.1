Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEB37A5FA4
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:33:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiY1A-0003vp-0n; Tue, 19 Sep 2023 06:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiY0C-00036N-NS
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:30:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiY0A-0001ud-JR
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695119441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yjkyeiLgHr2FDMto4R9a5D6A0D6S73stYv+FtlKwUfY=;
 b=V0Qb8nENP38jhYVrzFNGeeWQH7EKCn5GdBF9ACotd2KBpadkgWKS3OKbuIGnuwg3Smk3fz
 vJvFwzBAZIrcwcpscKBZhPwalcdOOei/8s+gGlGScXVfiuZ8/z8Wd+sy1G35/XJSOikP3y
 ppzxSTSuO4lx0651xaXeCMmy9gu0SOc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-tvckNiX2P-i9Qv9WKElDrA-1; Tue, 19 Sep 2023 06:30:40 -0400
X-MC-Unique: tvckNiX2P-i9Qv9WKElDrA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14EAA1C05EAE;
 Tue, 19 Sep 2023 10:30:40 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A7B640C6EBF;
 Tue, 19 Sep 2023 10:30:39 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, ThinerLogoer <logoerthiner1@163.com>
Subject: [GIT PULL 10/12] softmmu/physmem: Hint that "readonly=on,
 rom=off" exists when opening file R/W for private mapping fails
Date: Tue, 19 Sep 2023 12:30:27 +0200
Message-ID: <20230919103029.235736-11-david@redhat.com>
In-Reply-To: <20230919103029.235736-1-david@redhat.com>
References: <20230919103029.235736-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It's easy to miss that memory-backend-file with "share=off" (default)
will always try opening the file R/W as default, and fail if we don't
have write permissions to the file.

In that case, the user has to explicit specify "readonly=on,rom=off" to
get usable RAM, for example, for VM templating.

Let's hint that '-object memory-backend-file,readonly=on,rom=off,...'
exists to consume R/O files in a private mapping to create writable RAM,
but only if we have permissions to open the file read-only.

Message-ID: <20230906120503.359863-11-david@redhat.com>
Suggested-by: ThinerLogoer <logoerthiner1@163.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 softmmu/physmem.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index f1cd3ec28a..4f6ca653b3 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1969,6 +1969,25 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
     if (fd < 0) {
         error_setg_errno(errp, -fd, "can't open backing store %s for guest RAM",
                          mem_path);
+        if (!(ram_flags & RAM_READONLY_FD) && !(ram_flags & RAM_SHARED) &&
+            fd == -EACCES) {
+            /*
+             * If we can open the file R/O (note: will never create a new file)
+             * and we are dealing with a private mapping, there are still ways
+             * to consume such files and get RAM instead of ROM.
+             */
+            fd = file_ram_open(mem_path, memory_region_name(mr), true,
+                               &created);
+            if (fd < 0) {
+                return NULL;
+            }
+            assert(!created);
+            close(fd);
+            error_append_hint(errp, "Consider opening the backing store"
+                " read-only but still creating writable RAM using"
+                " '-object memory-backend-file,readonly=on,rom=off...'"
+                " (see \"VM templating\" documentation)\n");
+        }
         return NULL;
     }
 
-- 
2.41.0


