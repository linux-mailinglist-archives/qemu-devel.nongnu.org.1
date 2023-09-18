Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F7D7A4B33
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:47:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFSO-0002yo-Dm; Mon, 18 Sep 2023 10:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSE-0002v0-A9
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002ar-Iw
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mkPGhjLhvKknGBeX6UOrQzLJAqexuQGYBb4RhgGzqoQ=;
 b=gpdqjsdoTLN1GIVTkRwJlk97TarfqGtcOc1pTuZI7xU0voi2Z9wQ6cRkDFoP9IeXwctSBk
 pOVlGpMvhWGWtpTLwK20AmuGV1s5+pyIgdJ59/0DVGQROJKVyQ+R6NpYpb+r+PPKCY1x//
 M+QSQTvqn4tKlke/ABkJ5xGwc24hZao=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-1-S9yRZOO6qbKmBko38-xg-1; Mon, 18 Sep 2023 10:42:10 -0400
X-MC-Unique: 1-S9yRZOO6qbKmBko38-xg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 324BB29AA2C6
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10BCB20268CC
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 22F1321E6882; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 20/52] migration/rdma: Drop dead qemu_rdma_data_init() code
 for !@host_port
Date: Mon, 18 Sep 2023 16:41:34 +0200
Message-ID: <20230918144206.560120-21-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

qemu_rdma_data_init() neglects to set an Error when it fails because
@host_port is null.  Fortunately, no caller passes null, so this is
merely a latent bug.  Drop the flawed code handling null argument.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index d3dc162363..cc59155a50 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2716,25 +2716,22 @@ static RDMAContext *qemu_rdma_data_init(const char *host_port, Error **errp)
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


