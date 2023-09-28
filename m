Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 958267B1E0E
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:23:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqws-0003jE-DX; Thu, 28 Sep 2023 09:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwV-0003UJ-2d
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwN-0008E2-F6
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dSbbh7b3IM8bH80t3W/RtJ9cNch0EcMObMQfYNRheuY=;
 b=UprUS4v20tI8VPzBdQ59MD/4Kxht5EjjUR8LUntSRt6PI9u3teqNjqx5oQYcxGmRmK+i9J
 nAsV4ilu0teirudqh1Ua1POlrOcRk8wluzFwUbD/uE4tG+oPOy698RyjgRQGsW1cHb1x8P
 pknQQ9+V9ByD2zeN8n+jbyveWoD8CrQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-7qLXGBcXO9OpueMGYErWCg-1; Thu, 28 Sep 2023 09:20:24 -0400
X-MC-Unique: 7qLXGBcXO9OpueMGYErWCg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E96B18175A5;
 Thu, 28 Sep 2023 13:20:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C353167F8;
 Thu, 28 Sep 2023 13:20:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 52AC921E68A2; Thu, 28 Sep 2023 15:20:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 46/53] migration/rdma: Silence qemu_rdma_connect()
Date: Thu, 28 Sep 2023 15:20:12 +0200
Message-ID: <20230928132019.2544702-47-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

Functions that use an Error **errp parameter to return errors should
not also report them to the user, because reporting is the caller's
job.  When the caller does, the error is reported twice.  When it
doesn't (because it recovered from the error), there is no error to
report, i.e. the report is bogus.

qemu_rdma_connect() violates this principle: it calls error_report()
and perror().  I elected not to investigate how callers handle the
error, i.e. precise impact is not known.

Clean this up: replace perror() by changing error_setg() to
error_setg_errno(), and drop error_report().  I believe the callers'
error reports suffice then.  If they don't, we need to convert to
Error instead.

Bonus: resolves a FIXME about problematic use of errno.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/rdma.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 5e21dfca53..b85d5e60cb 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2591,8 +2591,8 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
 
     ret = rdma_connect(rdma->cm_id, &conn_param);
     if (ret < 0) {
-        perror("rdma_connect");
-        error_setg(errp, "RDMA ERROR: connecting to destination!");
+        error_setg_errno(errp, errno,
+                         "RDMA ERROR: connecting to destination!");
         goto err_rdma_source_connect;
     }
 
@@ -2601,21 +2601,15 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
     } else {
         ret = rdma_get_cm_event(rdma->channel, &cm_event);
         if (ret < 0) {
-            error_setg(errp, "RDMA ERROR: failed to get cm event");
+            error_setg_errno(errp, errno,
+                             "RDMA ERROR: failed to get cm event");
         }
     }
     if (ret < 0) {
-        /*
-         * FIXME perror() is wrong, because
-         * qemu_get_cm_event_timeout() can fail without setting errno.
-         * Will go away later in this series.
-         */
-        perror("rdma_get_cm_event after rdma_connect");
         goto err_rdma_source_connect;
     }
 
     if (cm_event->event != RDMA_CM_EVENT_ESTABLISHED) {
-        error_report("rdma_get_cm_event != EVENT_ESTABLISHED after rdma_connect");
         error_setg(errp, "RDMA ERROR: connecting to destination!");
         rdma_ack_cm_event(cm_event);
         goto err_rdma_source_connect;
-- 
2.41.0


