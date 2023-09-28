Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB44F7B1DEF
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:22:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqwm-0003g2-Ds; Thu, 28 Sep 2023 09:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwb-0003bF-Az
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwP-0008GE-Cb
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ez+XIiDjpsRBFgIlZjSn7S6XQQAuaYrDK2LrA6qGyYY=;
 b=FveqWI+tVNGYaVs/vbGN6q0tBRc7PUzDfE60sm8reODyii86DBLgG1uPO2WL/o/H0WJVyJ
 fRrWgJqqZpWEurYO/DJx+21dEJNmXEpp7Nj/C4ssOAu48/bwbcveoUCdL18cRr1kNUjJaN
 1zF95t+KGe2u1u722MzVPY8dZmxLpZE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-qpwxzt3mPia43twKrqpm0g-1; Thu, 28 Sep 2023 09:20:23 -0400
X-MC-Unique: qpwxzt3mPia43twKrqpm0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44DC91C00BAB;
 Thu, 28 Sep 2023 13:20:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 20F8C2156711;
 Thu, 28 Sep 2023 13:20:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 12AC221E6887; Thu, 28 Sep 2023 15:20:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 24/53] migration/rdma: Fix rdma_getaddrinfo() error checking
Date: Thu, 28 Sep 2023 15:19:50 +0200
Message-ID: <20230928132019.2544702-25-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/rdma.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index a58c2734e3..37399d31d2 100644
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
@@ -2675,7 +2673,7 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
     port_str[15] = '\0';
 
     ret = rdma_getaddrinfo(rdma->host, port_str, NULL, &res);
-    if (ret < 0) {
+    if (ret) {
         ERROR(errp, "could not rdma_getaddrinfo address %s", rdma->host);
         goto err_dest_init_bind_addr;
     }
@@ -2719,7 +2717,7 @@ err_dest_init_create_listen_id:
     rdma_destroy_event_channel(rdma->channel);
     rdma->channel = NULL;
     rdma->error_state = ret;
-    return ret;
+    return -1;
 
 }
 
-- 
2.41.0


