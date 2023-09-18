Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 723DC7A4B35
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:47:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFTL-0003xg-Qj; Mon, 18 Sep 2023 10:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSw-0003Ca-9r
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSr-0002uY-4n
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eAje1BXP335t8Hh1NicKNHmRtT7M/Hvb5QECq0HzuKM=;
 b=PeP80dsAl7QxQ6AzXYZzsbAJcQODrtd8sqv04FBe7RarPUOVsbe7VCU2ssl6Kdk7/L5d82
 6lpKt35OdsiNDaTXoYoS2j9R9pTAJ+wd9yXT6jUyXkJpc+hId4lOC5QjuPUxLJ8h18tEOo
 jGcpm5RGPcG0+vDhtNzHYdlmhaD2nAE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-PJT_eUhoOraED6AbNRLHBg-1; Mon, 18 Sep 2023 10:42:18 -0400
X-MC-Unique: PJT_eUhoOraED6AbNRLHBg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B81A8001EA
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A4E61005E27
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 288E321E6884; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 22/52] migration/rdma: Fix rdma_getaddrinfo() error checking
Date: Mon, 18 Sep 2023 16:41:36 +0200
Message-ID: <20230918144206.560120-23-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
---
 migration/rdma.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 46b5859268..3421ae0796 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -935,14 +935,14 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
 
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
@@ -956,7 +956,7 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
     port_str[15] = '\0';
 
     ret = rdma_getaddrinfo(rdma->host, port_str, NULL, &res);
-    if (ret < 0) {
+    if (ret) {
         ERROR(errp, "could not rdma_getaddrinfo address %s", rdma->host);
         goto err_resolve_get_addr;
     }
@@ -998,7 +998,6 @@ route:
                 rdma_event_str(cm_event->event));
         error_report("rdma_resolve_addr");
         rdma_ack_cm_event(cm_event);
-        ret = -EINVAL;
         goto err_resolve_get_addr;
     }
     rdma_ack_cm_event(cm_event);
@@ -1019,7 +1018,6 @@ route:
         ERROR(errp, "result not equal to event_route_resolved: %s",
                         rdma_event_str(cm_event->event));
         rdma_ack_cm_event(cm_event);
-        ret = -EINVAL;
         goto err_resolve_get_addr;
     }
     rdma_ack_cm_event(cm_event);
@@ -1034,7 +1032,7 @@ err_resolve_get_addr:
 err_resolve_create_id:
     rdma_destroy_event_channel(rdma->channel);
     rdma->channel = NULL;
-    return ret;
+    return -1;
 }
 
 /*
@@ -2644,7 +2642,7 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
     port_str[15] = '\0';
 
     ret = rdma_getaddrinfo(rdma->host, port_str, NULL, &res);
-    if (ret < 0) {
+    if (ret) {
         ERROR(errp, "could not rdma_getaddrinfo address %s", rdma->host);
         goto err_dest_init_bind_addr;
     }
@@ -2688,7 +2686,7 @@ err_dest_init_create_listen_id:
     rdma_destroy_event_channel(rdma->channel);
     rdma->channel = NULL;
     rdma->error_state = ret;
-    return ret;
+    return -1;
 
 }
 
-- 
2.41.0


