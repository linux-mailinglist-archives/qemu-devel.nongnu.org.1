Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACF57C4E73
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:23:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVQV-0007HJ-Aq; Wed, 11 Oct 2023 05:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQT-0007GG-3M
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQR-0004ux-J7
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSBd/kVf9Dpk1oOOMPt51L1JG8VZGX5q4c/+RKswxBo=;
 b=Qdq/jra3qqpfDGEhTzXia1cyIZ9HhRkz58KLwv3GSCOta6ot1rsd/SLCL1Cs4B/JpWf7LS
 ZwudeMkL0OX1jL3Jxvyq/yNIqnwWuaznwdrR4VWVtZwARpjxNnyycsm0vFnnXXkY9/vZjF
 gQCUZ0Wl0lJzkJypYZlyloHOyKpKjsY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-qj_VTd5iOrG91o1NYZggTw-1; Wed, 11 Oct 2023 05:22:41 -0400
X-MC-Unique: qj_VTd5iOrG91o1NYZggTw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CC4F3C0DF8B;
 Wed, 11 Oct 2023 09:22:41 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 802FC1C060AE;
 Wed, 11 Oct 2023 09:22:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 17/65] migration/rdma: Put @errp parameter last
Date: Wed, 11 Oct 2023 11:21:15 +0200
Message-ID: <20231011092203.1266-18-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

From: Markus Armbruster <armbru@redhat.com>

include/qapi/error.h demands:

 * - Functions that use Error to report errors have an Error **errp
 *   parameter.  It should be the last parameter, except for functions
 *   taking variable arguments.

qemu_rdma_connect() does not conform.  Clean it up.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-11-armbru@redhat.com>
---
 migration/rdma.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 8fd1b314b5..bc6d8248f2 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2552,7 +2552,8 @@ static int qemu_get_cm_event_timeout(RDMAContext *rdma,
     }
 }
 
-static int qemu_rdma_connect(RDMAContext *rdma, Error **errp, bool return_path)
+static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
+                             Error **errp)
 {
     RDMACapabilities cap = {
                                 .version = RDMA_CONTROL_VERSION_CURRENT,
@@ -4183,7 +4184,7 @@ void rdma_start_outgoing_migration(void *opaque,
     }
 
     trace_rdma_start_outgoing_migration_after_rdma_source_init();
-    ret = qemu_rdma_connect(rdma, errp, false);
+    ret = qemu_rdma_connect(rdma, false, errp);
 
     if (ret) {
         goto err;
@@ -4204,7 +4205,7 @@ void rdma_start_outgoing_migration(void *opaque,
             goto return_path_err;
         }
 
-        ret = qemu_rdma_connect(rdma_return_path, errp, true);
+        ret = qemu_rdma_connect(rdma_return_path, true, errp);
 
         if (ret) {
             goto return_path_err;
-- 
2.41.0


