Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0807A4B46
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:49:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFYF-0001Km-Kg; Mon, 18 Sep 2023 10:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFYA-00013F-K7
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:48:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFY9-0003ti-0t
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PkB838LQ80iGjBq0Z1G6oMwvf09DZSThxOjEipkPMjY=;
 b=aHIKoblwpRf5iyH6uWHARQjKIHGErm2XYaY0TcEzchcuzA59tqmz10IIEEEI/MGNvZdEiu
 1eaEeZWAaaxPWDAeRUZKdr/1SHBdbkHmDQSHQviHPrwoATlVfkoJIUaL2W/MbubPsymlu6
 VuPIofAtfg095+LA+pvf/p55fL0KwLk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-fPVssOxcPie3VH7rVuNWzg-1; Mon, 18 Sep 2023 10:48:28 -0400
X-MC-Unique: fPVssOxcPie3VH7rVuNWzg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1288A858F1D
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:48:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2AA740C2070
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:48:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6ACE421E68A1; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 45/52] migration/rdma: Silence qemu_rdma_connect()
Date: Mon, 18 Sep 2023 16:41:59 +0200
Message-ID: <20230918144206.560120-46-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 0e365db06a..bf4e67d68d 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2574,8 +2574,8 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
 
     ret = rdma_connect(rdma->cm_id, &conn_param);
     if (ret < 0) {
-        perror("rdma_connect");
-        error_setg(errp, "RDMA ERROR: connecting to destination!");
+        error_setg_errno(errp, errno,
+                         "RDMA ERROR: connecting to destination!");
         goto err_rdma_source_connect;
     }
 
@@ -2584,16 +2584,15 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
     } else {
         ret = rdma_get_cm_event(rdma->channel, &cm_event);
         if (ret < 0) {
-            error_setg(errp, "RDMA ERROR: failed to get cm event");
+            error_setg_errno(errp, errno,
+                             "RDMA ERROR: failed to get cm event");
         }
     }
     if (ret < 0) {
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


