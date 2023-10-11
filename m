Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEE17C4F09
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:33:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVR8-00088w-GC; Wed, 11 Oct 2023 05:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQy-0007T1-1R
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQu-00050M-Tv
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wad4hyZ+weuOtjF3NrA/udGGvsXByqLN3/C2EpzaMUs=;
 b=DuIKWosJlUWEm5c3oXtsYtVgaV3+uo8rfsuAhGcdeIhVe/WIZiwI+X7/ZPRSy68FOn3V+c
 tcyzrsYGF1QmEyUBkZRjG+b5av4SXk2XhbAkF8k7ZzYcRt++gQgBFf7T1yuJ3C+iWE7Jrr
 9UJlv6QBhXeBZXQ/lpZjzoxOocW1/K0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-xJk-yAXxNJaR6MwoAY9uRQ-1; Wed, 11 Oct 2023 05:23:05 -0400
X-MC-Unique: xJk-yAXxNJaR6MwoAY9uRQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 394C5185A79B;
 Wed, 11 Oct 2023 09:23:05 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E8F61C060B0;
 Wed, 11 Oct 2023 09:23:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 29/65] migration/rdma: Drop dead qemu_rdma_data_init() code for
 !@host_port
Date: Wed, 11 Oct 2023 11:21:27 +0200
Message-ID: <20231011092203.1266-30-quintela@redhat.com>
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

qemu_rdma_data_init() neglects to set an Error when it fails because
@host_port is null.  Fortunately, no caller passes null, so this is
merely a latent bug.  Drop the flawed code handling null argument.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-23-armbru@redhat.com>
---
 migration/rdma.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 0039295a15..55eb8222ea 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2767,25 +2767,22 @@ static RDMAContext *qemu_rdma_data_init(const char *host_port, Error **errp)
     RDMAContext *rdma = NULL;
     InetSocketAddress *addr;
 
-    if (host_port) {
-        rdma = g_new0(RDMAContext, 1);
-        rdma->current_index = -1;
-        rdma->current_chunk = -1;
+    rdma = g_new0(RDMAContext, 1);
+    rdma->current_index = -1;
+    rdma->current_chunk = -1;
 
-        addr = g_new(InetSocketAddress, 1);
-        if (!inet_parse(addr, host_port, NULL)) {
-            rdma->port = atoi(addr->port);
-            rdma->host = g_strdup(addr->host);
-            rdma->host_port = g_strdup(host_port);
-        } else {
-            ERROR(errp, "bad RDMA migration address '%s'", host_port);
-            g_free(rdma);
-            rdma = NULL;
-        }
-
-        qapi_free_InetSocketAddress(addr);
+    addr = g_new(InetSocketAddress, 1);
+    if (!inet_parse(addr, host_port, NULL)) {
+        rdma->port = atoi(addr->port);
+        rdma->host = g_strdup(addr->host);
+        rdma->host_port = g_strdup(host_port);
+    } else {
+        ERROR(errp, "bad RDMA migration address '%s'", host_port);
+        g_free(rdma);
+        rdma = NULL;
     }
 
+    qapi_free_InetSocketAddress(addr);
     return rdma;
 }
 
-- 
2.41.0


