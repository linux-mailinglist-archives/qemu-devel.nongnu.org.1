Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5FF7C4F14
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:35:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVRP-0001j9-SC; Wed, 11 Oct 2023 05:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRN-0001hD-GI
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRL-00054u-TC
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nzf9h501CnrBsSraqlerv5Ta99Pfe8Cmh4XFxpF8UE=;
 b=TwUsC14jn5VyFpJCr98navvwtXK3tBymRd1c0ZAXGktdnE9OOUjIItB+tCpmFZG4xRGbVZ
 iEbK7rbktqd7XDbE8Ns588beJdYQlpqjnx02u9271t/l9kseqNp5T3MY9sXT7WoBp0ugxp
 6sJJHewpnQWCTLk5z0a0BJhCPFzmqsA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-k3TC6G4XNn-jub_Hdn9Egw-1; Wed, 11 Oct 2023 05:23:27 -0400
X-MC-Unique: k3TC6G4XNn-jub_Hdn9Egw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75F401C0896C;
 Wed, 11 Oct 2023 09:23:27 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B29E41C060B0;
 Wed, 11 Oct 2023 09:23:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 40/65] migration/rdma: Fix error handling around
 rdma_getaddrinfo()
Date: Wed, 11 Oct 2023 11:21:38 +0200
Message-ID: <20231011092203.1266-41-quintela@redhat.com>
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

qemu_rdma_resolve_host() and qemu_rdma_dest_init() iterate over
addresses to find one that works, holding onto the first Error from
qemu_rdma_broken_ipv6_kernel() for use when no address works.  Issues:

1. If @errp was &error_abort or &error_fatal, we'd terminate instead
   of trying the next address.  Can't actually happen, since no caller
   passes these arguments.

2. When @errp is a pointer to a variable containing NULL, and
   qemu_rdma_broken_ipv6_kernel() fails, the variable no longer
   contains NULL.  Subsequent iterations pass it again, violating
   Error usage rules.  Dangerous, as setting an error would then trip
   error_setv()'s assertion.  Works only because
   qemu_rdma_broken_ipv6_kernel() and the code following the loops
   carefully avoids setting a second error.

3. If qemu_rdma_broken_ipv6_kernel() fails, and then a later iteration
   finds a working address, @errp still holds the first error from
   qemu_rdma_broken_ipv6_kernel().  If we then run into another error,
   we report the qemu_rdma_broken_ipv6_kernel() failure instead.

4. If we don't run into another error, we leak the Error object.

Use a local error variable, and propagate to @errp.  This fixes 3. and
also cleans up 1 and partly 2.

Free this error when we have a working address.  This fixes 4.

Pass the local error variable to qemu_rdma_broken_ipv6_kernel() only
until it fails.  Pass null on any later iterations.  This cleans up
the remainder of 2.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-34-armbru@redhat.com>
---
 migration/rdma.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 4074509f06..3fb899f963 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -932,6 +932,7 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
  */
 static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
 {
+    Error *err = NULL;
     int ret;
     struct rdma_addrinfo *res;
     char port_str[16];
@@ -976,7 +977,10 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
         goto err_resolve_get_addr;
     }
 
+    /* Try all addresses, saving the first error in @err */
     for (e = res; e != NULL; e = e->ai_next) {
+        Error **local_errp = err ? NULL : &err;
+
         inet_ntop(e->ai_family,
             &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, sizeof ip);
         trace_qemu_rdma_resolve_host_trying(rdma->host, ip);
@@ -985,17 +989,21 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
                 RDMA_RESOLVE_TIMEOUT_MS);
         if (ret >= 0) {
             if (e->ai_family == AF_INET6) {
-                ret = qemu_rdma_broken_ipv6_kernel(rdma->cm_id->verbs, errp);
+                ret = qemu_rdma_broken_ipv6_kernel(rdma->cm_id->verbs,
+                                                   local_errp);
                 if (ret < 0) {
                     continue;
                 }
             }
+            error_free(err);
             goto route;
         }
     }
 
     rdma_freeaddrinfo(res);
-    if (errp && !*errp) {
+    if (err) {
+        error_propagate(errp, err);
+    } else {
         error_setg(errp, "RDMA ERROR: could not resolve address %s",
                    rdma->host);
     }
@@ -2707,6 +2715,7 @@ err_rdma_source_connect:
 
 static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 {
+    Error *err = NULL;
     int ret, idx;
     struct rdma_cm_id *listen_id;
     char ip[40] = "unknown";
@@ -2765,7 +2774,11 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
         }
         goto err_dest_init_bind_addr;
     }
+
+    /* Try all addresses, saving the first error in @err */
     for (e = res; e != NULL; e = e->ai_next) {
+        Error **local_errp = err ? NULL : &err;
+
         inet_ntop(e->ai_family,
             &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, sizeof ip);
         trace_qemu_rdma_dest_init_trying(rdma->host, ip);
@@ -2774,17 +2787,21 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
             continue;
         }
         if (e->ai_family == AF_INET6) {
-            ret = qemu_rdma_broken_ipv6_kernel(listen_id->verbs, errp);
+            ret = qemu_rdma_broken_ipv6_kernel(listen_id->verbs,
+                                               local_errp);
             if (ret < 0) {
                 continue;
             }
         }
+        error_free(err);
         break;
     }
 
     rdma_freeaddrinfo(res);
     if (!e) {
-        if (errp && !*errp) {
+        if (err) {
+            error_propagate(errp, err);
+        } else {
             error_setg(errp, "RDMA ERROR: Error: could not rdma_bind_addr!");
         }
         goto err_dest_init_bind_addr;
-- 
2.41.0


