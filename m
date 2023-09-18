Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B513F7A4B2A
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:45:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFSS-00034B-TX; Mon, 18 Sep 2023 10:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSJ-0002wr-Qx
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002bh-Lt
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vMM5P4bD7tAkGhNWVfycrZuYg29wkQEKEmlaj/k2jkA=;
 b=gUpL4DgKPpVGY8rrsPIYXeYaT+xYyePYQSECpTyr63wVraKDWiqirON9TRsZAYU8SE/XXf
 l4kRkwQigjQpyT6suoXKs5LItE8Lr/qG8PVqdMmmhdSOlSOMWoKp9Ds7SoZ/gNip6O4zqW
 PhlYIa62jShsVIl//Qrt3pJKuqb3PMU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-qmi8fE6XMhqeBMC0qcA9JQ-1; Mon, 18 Sep 2023 10:42:11 -0400
X-MC-Unique: qmi8fE6XMhqeBMC0qcA9JQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B9A83C025C5
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E1AF2156702
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4596121E6894; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 32/52] migration/rdma: Fix error handling around
 rdma_getaddrinfo()
Date: Mon, 18 Sep 2023 16:41:46 +0200
Message-ID: <20230918144206.560120-33-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
---
 migration/rdma.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index df5b3a8e2c..d29affe410 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -926,6 +926,7 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
  */
 static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
 {
+    Error *err = NULL;
     int ret;
     struct rdma_addrinfo *res;
     char port_str[16];
@@ -970,7 +971,10 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
         goto err_resolve_get_addr;
     }
 
+    /* Try all addresses, saving the first error in @err */
     for (e = res; e != NULL; e = e->ai_next) {
+        Error **local_errp = err ? NULL : &err;
+
         inet_ntop(e->ai_family,
             &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, sizeof ip);
         trace_qemu_rdma_resolve_host_trying(rdma->host, ip);
@@ -979,17 +983,21 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
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
@@ -2656,6 +2664,7 @@ err_rdma_source_connect:
 
 static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 {
+    Error *err = NULL;
     int ret, idx;
     struct rdma_cm_id *listen_id;
     char ip[40] = "unknown";
@@ -2714,7 +2723,11 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
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
@@ -2723,17 +2736,21 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
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


