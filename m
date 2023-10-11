Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E87537C4EEB
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:29:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVR6-0007sv-9B; Wed, 11 Oct 2023 05:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQz-0007TF-FL
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQx-00050V-M7
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9p3gg8OqHQcAs73V2BsqWHaLt9YHWj2QTRCTTafgenQ=;
 b=jIGtkahgCq+ypFFlWAcQWJw45meuW7dPc8ZMbj/+ocRwNdbj4skCrl4Ubl0n+YJQ21kD1Z
 +a+Xv5ZCrkvix2bTn7Lnzkr6vwVUi3JzOH/uWIfkRkKqcXmVLpt56MwNXNB59/ooIe6CXt
 6FLHb0OcT/zprtTuEAFtJ+/exJrLCpQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-gJOAMQgaNLuKw8vizYRz-w-1; Wed, 11 Oct 2023 05:23:09 -0400
X-MC-Unique: gJOAMQgaNLuKw8vizYRz-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C058858295;
 Wed, 11 Oct 2023 09:23:09 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7FEBF1C060AE;
 Wed, 11 Oct 2023 09:23:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 31/65] migration/rdma: Fix rdma_getaddrinfo() error checking
Date: Wed, 11 Oct 2023 11:21:29 +0200
Message-ID: <20231011092203.1266-32-quintela@redhat.com>
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

rdma_getaddrinfo() returns 0 on success.  On error, it returns one of
the EAI_ error codes like getaddrinfo() does, or -1 with errno set.
This is broken by design: POSIX implicitly specifies the EAI_ error
codes to be non-zero, no more.  They could clash with -1.  Nothing we
can do about this design flaw.

Both callers of rdma_getaddrinfo() only recognize negative values as
error.  Works only because systems elect to make the EAI_ error codes
negative.

Best not to rely on that: change the callers to treat any non-zero
value as failure.  Also change them to return -1 instead of the value
received from getaddrinfo() on failure, to avoid positive error
values.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-25-armbru@redhat.com>
---
 migration/rdma.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 974edde6a3..dd0b073792 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -941,14 +941,14 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
 
     if (rdma->host == NULL || !strcmp(rdma->host, "")) {
         ERROR(errp, "RDMA hostname has not been set");
-        return -EINVAL;
+        return -1;
     }
 
     /* create CM channel */
     rdma->channel = rdma_create_event_channel();
     if (!rdma->channel) {
         ERROR(errp, "could not create CM channel");
-        return -EINVAL;
+        return -1;
     }
 
     /* create CM id */
@@ -962,7 +962,7 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
     port_str[15] = '\0';
 
     ret = rdma_getaddrinfo(rdma->host, port_str, NULL, &res);
-    if (ret < 0) {
+    if (ret) {
         ERROR(errp, "could not rdma_getaddrinfo address %s", rdma->host);
         goto err_resolve_get_addr;
     }
@@ -1004,7 +1004,6 @@ route:
                 rdma_event_str(cm_event->event));
         error_report("rdma_resolve_addr");
         rdma_ack_cm_event(cm_event);
-        ret = -EINVAL;
         goto err_resolve_get_addr;
     }
     rdma_ack_cm_event(cm_event);
@@ -1025,7 +1024,6 @@ route:
         ERROR(errp, "result not equal to event_route_resolved: %s",
                         rdma_event_str(cm_event->event));
         rdma_ack_cm_event(cm_event);
-        ret = -EINVAL;
         goto err_resolve_get_addr;
     }
     rdma_ack_cm_event(cm_event);
@@ -1040,7 +1038,7 @@ err_resolve_get_addr:
 err_resolve_create_id:
     rdma_destroy_event_channel(rdma->channel);
     rdma->channel = NULL;
-    return ret;
+    return -1;
 }
 
 /*
@@ -2695,7 +2693,7 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
     port_str[15] = '\0';
 
     ret = rdma_getaddrinfo(rdma->host, port_str, NULL, &res);
-    if (ret < 0) {
+    if (ret) {
         ERROR(errp, "could not rdma_getaddrinfo address %s", rdma->host);
         goto err_dest_init_bind_addr;
     }
@@ -2739,7 +2737,7 @@ err_dest_init_create_listen_id:
     rdma_destroy_event_channel(rdma->channel);
     rdma->channel = NULL;
     rdma->error_state = ret;
-    return ret;
+    return -1;
 
 }
 
-- 
2.41.0


