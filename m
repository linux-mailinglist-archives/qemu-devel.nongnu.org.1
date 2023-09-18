Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD3D7A4B31
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:47:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFSS-000348-AO; Mon, 18 Sep 2023 10:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSK-0002x3-P3
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002b2-Mn
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jSr+anHdxk2uJGfweDbjBtw6bdH7EJatp1kCgdQaJcA=;
 b=I9ixiQnu3lFmM6hRzHlDoiVfscUQwgiBljUEUy+3p/OFbdbQOEtxjiq+Y4HQ7ZnDB/QRSr
 Z8k3zFS/KheY5vsjd+keVJmDOSh+OpjLZd73o63NFEL0DZiz6FmorfqK16is67jDCvw21U
 K0V4mCHN8Y4IGLLipaiyeILMVx7TRCM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-GkmEk1q_NByvy6793O7hRA-1; Mon, 18 Sep 2023 10:42:10 -0400
X-MC-Unique: GkmEk1q_NByvy6793O7hRA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 310EF101B041
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F77910EE859
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2022621E6880; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 19/52] migration/rdma: Fix qemu_get_cm_event_timeout() to
 always set error
Date: Mon, 18 Sep 2023 16:41:33 +0200
Message-ID: <20230918144206.560120-20-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

qemu_get_cm_event_timeout() neglects to set an error when it fails
because rdma_get_cm_event() fails.  Harmless, as its caller
qemu_rdma_connect() substitutes a generic error then.  Fix it anyway.

qemu_rdma_connect() also sets the generic error when its own call of
rdma_get_cm_event() fails.  Make the error handling more obvious: set
a specific error right after rdma_get_cm_event() fails.  Delete the
generic error.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 08cd186385..d3dc162363 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2509,7 +2509,11 @@ static int qemu_get_cm_event_timeout(RDMAContext *rdma,
         ERROR(errp, "failed to poll cm event, errno=%i", errno);
         return -1;
     } else if (poll_fd.revents & POLLIN) {
-        return rdma_get_cm_event(rdma->channel, cm_event);
+        if (rdma_get_cm_event(rdma->channel, cm_event) < 0) {
+            ERROR(errp, "failed to get cm event");
+            return -1;
+        }
+        return 0;
     } else {
         ERROR(errp, "no POLLIN event, revent=%x", poll_fd.revents);
         return -1;
@@ -2559,10 +2563,12 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
         ret = qemu_get_cm_event_timeout(rdma, &cm_event, 5000, errp);
     } else {
         ret = rdma_get_cm_event(rdma->channel, &cm_event);
+        if (ret < 0) {
+            ERROR(errp, "failed to get cm event");
+        }
     }
     if (ret) {
         perror("rdma_get_cm_event after rdma_connect");
-        ERROR(errp, "connecting to destination!");
         goto err_rdma_source_connect;
     }
 
-- 
2.41.0


