Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7FC7C4E8D
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:26:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVR9-0008Cd-0y; Wed, 11 Oct 2023 05:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQw-0007Rw-7Y
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQu-00050J-Kw
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UqcvKeFUa6lSi/axeer8btzgtodHnD4DkiLV/53MJ18=;
 b=PuZFl7mFSk3ki7fIdtS6lFAAk339L2Azj0IKQmFbdUsAIZ1bBtGhgVwLy+hoV4RcNL0Vbx
 78lv2NNpxwuPnercV9GI+BPdqxj2SagZy8+6sAsMbTJ0p6mzczKC71KaG80uQgdusvIX1+
 OLu8nO1eC0XCaNf8b0mJtVQwwNsTACg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-0JvKHfzSPGyzYYSlBnPgkw-1; Wed, 11 Oct 2023 05:22:57 -0400
X-MC-Unique: 0JvKHfzSPGyzYYSlBnPgkw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A68F29AA2DE;
 Wed, 11 Oct 2023 09:22:57 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81EEF1C060AE;
 Wed, 11 Oct 2023 09:22:55 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 25/65] migration/rdma: Fix io_writev(),
 io_readv() methods to obey contract
Date: Wed, 11 Oct 2023 11:21:23 +0200
Message-ID: <20231011092203.1266-26-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

From: Markus Armbruster <armbru@redhat.com>

QIOChannelClass methods qio_channel_rdma_readv() and
qio_channel_rdma_writev() violate their method contract when
rdma->error_state is non-zero:

1. They return whatever is in rdma->error_state then.  Only -1 will be
   fine.  -2 will be misinterpreted as "would block".  Anything less
   than -2 isn't defined in the contract.  A positive value would be
   misinterpreted as success, but I believe that's not actually
   possible.

2. They neglect to set an error then.  If something up the call stack
   dereferences the error when failure is returned, it will crash.  If
   it ignores the return value and checks the error instead, it will
   miss the error.

Crap like this happens when return statements hide in macros,
especially when their uses are far away from the definition.

I elected not to investigate how callers are impacted.

Expand the two bad macro uses, so we can set an error and return -1.
The next commit will then get rid of the macro altogether.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-19-armbru@redhat.com>
---
 migration/rdma.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index c4197c6437..18be228e3b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2810,7 +2810,11 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
         return -1;
     }
 
-    CHECK_ERROR_STATE();
+    if (rdma->error_state) {
+        error_setg(errp,
+                   "RDMA is in an error state waiting migration to abort!");
+        return -1;
+    }
 
     /*
      * Push out any writes that
@@ -2896,7 +2900,11 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
         return -1;
     }
 
-    CHECK_ERROR_STATE();
+    if (rdma->error_state) {
+        error_setg(errp,
+                   "RDMA is in an error state waiting migration to abort!");
+        return -1;
+    }
 
     for (i = 0; i < niov; i++) {
         size_t want = iov[i].iov_len;
-- 
2.41.0


