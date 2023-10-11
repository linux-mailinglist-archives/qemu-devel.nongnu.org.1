Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AB77C4EE4
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:28:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVR3-0007R9-6n; Wed, 11 Oct 2023 05:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQr-0007KF-1P
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQp-0004yn-CL
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=szkfZFal3gRV6YMln02f04O1VbuVOGrG3KyiudA4Niw=;
 b=haV7APoPAfmwhtFo4meKFm6jmaaYh8OL0D3CO9mo0+U4r9zACO1wMwHtDoBBtWmBqQp/aT
 8euemXiwuK+2GYZ2njHHzSDPAR/7w/B+YfnI6GfowAuv6+Z4nr+w0R2juCkhSB4t5FCKTQ
 nBV7aUm/f/qd6PgsFQ5be/gC4tbXFbw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-IM4KZtaJMsy0F_EqnmC8jQ-1; Wed, 11 Oct 2023 05:23:03 -0400
X-MC-Unique: IM4KZtaJMsy0F_EqnmC8jQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C968811E7B;
 Wed, 11 Oct 2023 09:23:03 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82F801C060B0;
 Wed, 11 Oct 2023 09:23:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 28/65] migration/rdma: Fix qemu_get_cm_event_timeout() to
 always set error
Date: Wed, 11 Oct 2023 11:21:26 +0200
Message-ID: <20231011092203.1266-29-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

From: Markus Armbruster <armbru@redhat.com>

qemu_get_cm_event_timeout() neglects to set an error when it fails
because rdma_get_cm_event() fails.  Harmless, as its caller
qemu_rdma_connect() substitutes a generic error then.  Fix it anyway.

qemu_rdma_connect() also sets the generic error when its own call of
rdma_get_cm_event() fails.  Make the error handling more obvious: set
a specific error right after rdma_get_cm_event() fails.  Delete the
generic error.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-22-armbru@redhat.com>
---
 migration/rdma.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 9c576bdcba..0039295a15 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2555,7 +2555,11 @@ static int qemu_get_cm_event_timeout(RDMAContext *rdma,
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
@@ -2605,6 +2609,9 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
         ret = qemu_get_cm_event_timeout(rdma, &cm_event, 5000, errp);
     } else {
         ret = rdma_get_cm_event(rdma->channel, &cm_event);
+        if (ret < 0) {
+            ERROR(errp, "failed to get cm event");
+        }
     }
     if (ret) {
         /*
@@ -2613,7 +2620,6 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
          * Will go away later in this series.
          */
         perror("rdma_get_cm_event after rdma_connect");
-        ERROR(errp, "connecting to destination!");
         goto err_rdma_source_connect;
     }
 
-- 
2.41.0


