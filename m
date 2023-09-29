Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1615C7B2E9E
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:57:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Dl-0005J2-SL; Fri, 29 Sep 2023 04:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9Dc-0005Bp-FF
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DE-0005cP-T2
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7UV48sbdVMGeVoWJq1kENky0JQ2CPBfQXeo/C7cSXh8=;
 b=XY3aWqCY+N71Qt32+G/w+aL7ldDcN60kahxEYPGj4fxsqxaf/Sn5Tt0Nosamdyi8olRWyq
 vJcakSBmCMz0hBVxdwxXuRjqO7iPXRAdaQFW88l80TBjt0fW6nTAJca3j0MnjT9HoiSwdV
 VKAbH5znI87tFInOmz+V5NEvqtAoqbY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-ciDaImPKPEi6iFP2pYk-5Q-1; Fri, 29 Sep 2023 04:50:57 -0400
X-MC-Unique: ciDaImPKPEi6iFP2pYk-5Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B66C4811E86;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93827492B16;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9A4F021E688B; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 26/56] softmmu/physmem: Clean up local variable shadowing
Date: Fri, 29 Sep 2023 10:50:23 +0200
Message-ID: <20230929085053.2789105-27-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Fix:

  softmmu/physmem.c: In function ‘cpu_physical_memory_snapshot_and_clear_dirty’:
  softmmu/physmem.c:916:27: warning: declaration of ‘offset’ shadows a parameter [-Wshadow=compatible-local]
    916 |             unsigned long offset = page % DIRTY_MEMORY_BLOCK_SIZE;
        |                           ^~~~~~
  softmmu/physmem.c:892:31: note: shadowed declaration is here
    892 |     (MemoryRegion *mr, hwaddr offset, hwaddr length, unsigned client)
        |                        ~~~~~~~^~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904161235.84651-23-philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 softmmu/physmem.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 4f6ca653b3..309653c722 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -913,16 +913,16 @@ DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
 
         while (page < end) {
             unsigned long idx = page / DIRTY_MEMORY_BLOCK_SIZE;
-            unsigned long offset = page % DIRTY_MEMORY_BLOCK_SIZE;
+            unsigned long ofs = page % DIRTY_MEMORY_BLOCK_SIZE;
             unsigned long num = MIN(end - page,
-                                    DIRTY_MEMORY_BLOCK_SIZE - offset);
+                                    DIRTY_MEMORY_BLOCK_SIZE - ofs);
 
-            assert(QEMU_IS_ALIGNED(offset, (1 << BITS_PER_LEVEL)));
+            assert(QEMU_IS_ALIGNED(ofs, (1 << BITS_PER_LEVEL)));
             assert(QEMU_IS_ALIGNED(num,    (1 << BITS_PER_LEVEL)));
-            offset >>= BITS_PER_LEVEL;
+            ofs >>= BITS_PER_LEVEL;
 
             bitmap_copy_and_clear_atomic(snap->dirty + dest,
-                                         blocks->blocks[idx] + offset,
+                                         blocks->blocks[idx] + ofs,
                                          num);
             page += num;
             dest += num >> BITS_PER_LEVEL;
-- 
2.41.0


