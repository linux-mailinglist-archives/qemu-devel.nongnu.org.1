Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBA67B1E52
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:27:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqwx-0003nN-I5; Thu, 28 Sep 2023 09:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwb-0003bC-9C
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwP-0008G2-8x
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6nItDBQipWI1KVfWI0FM3U4wxGX1WMpMYJQFIraiH60=;
 b=VnHIZFRjrCrr3ZgypZIaaXs47ODacngVXL+Min/MBPQR30zTA2vA2C4FCRaecHmhOWUN11
 dSWMX53jubkF6NJ/qrTe3u0tUdafHuX0itSoJlz3epwNVl8TF3ZggWT2JghmzPB6rrrXzy
 FoCvh8823KjXnvBK34LWDvdItq2wtnU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-wzx2lZlHNfanOHaDYY7qkA-1; Thu, 28 Sep 2023 09:20:23 -0400
X-MC-Unique: wzx2lZlHNfanOHaDYY7qkA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37F7D18175A3;
 Thu, 28 Sep 2023 13:20:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15D83492B16;
 Thu, 28 Sep 2023 13:20:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0CED421E6885; Thu, 28 Sep 2023 15:20:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 22/53] migration/rdma: Drop dead qemu_rdma_data_init() code
 for !@host_port
Date: Thu, 28 Sep 2023 15:19:48 +0200
Message-ID: <20230928132019.2544702-23-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

qemu_rdma_data_init() neglects to set an Error when it fails because
@host_port is null.  Fortunately, no caller passes null, so this is
merely a latent bug.  Drop the flawed code handling null argument.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 1a0ad44411..1ae2f87906 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2747,25 +2747,22 @@ static RDMAContext *qemu_rdma_data_init(const char *host_port, Error **errp)
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


