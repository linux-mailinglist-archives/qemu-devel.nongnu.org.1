Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5937A4B40
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:49:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFSx-0003Cg-Ig; Mon, 18 Sep 2023 10:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSR-00033y-GL
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS5-0002cd-Ch
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B/TC5Y2oxTiibwuc1GydJCqyd+rgVsD/zALBhavh4/M=;
 b=CvG+fhDRJbyTDpwaRGjwmTvwoKaeis8SQstEwVwIXXkg/+FILMs7dtQMO8/F/T0Mi6Hf74
 EJlf1wbYIy7i/+EbRFrlzjTL4DQ/wQ6n6kiWx9jjOB0mZ7Vp1pOcKz27u/ybwO4LltkNLR
 vnmjiVon8W/OCWqsVL1brrre6pkecS8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-IgAWWjvuNvKulofssAwSVw-1; Mon, 18 Sep 2023 10:42:12 -0400
X-MC-Unique: IgAWWjvuNvKulofssAwSVw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85A4F29AA2C6
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63DDDC15BB8
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 791F821E68A6; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 50/52] migration/rdma: Silence qemu_rdma_cleanup()
Date: Mon, 18 Sep 2023 16:42:04 +0200
Message-ID: <20230918144206.560120-51-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

qemu_rdma_source_init(), qemu_rdma_connect(),
rdma_start_incoming_migration(), and rdma_start_outgoing_migration()
violate this principle: they call error_report() via
qemu_rdma_cleanup().

Moreover, qemu_rdma_cleanup() can't fail.  It is called on error
paths, and QIOChannel close and finalization.  Are the conditions it
reports really errors?  I doubt it.

Clean this up: silence qemu_rdma_cleanup().  I believe that's fine for
all these callers.  If it isn't, we need to convert to Error instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index d9f80ef390..be2db7946d 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2330,7 +2330,6 @@ static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
 
 static void qemu_rdma_cleanup(RDMAContext *rdma)
 {
-    Error *err = NULL;
     int idx;
 
     if (rdma->cm_id && rdma->connected) {
@@ -2341,10 +2340,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
                                        .type = RDMA_CONTROL_ERROR,
                                        .repeat = 1,
                                      };
-            error_report("Early error. Sending error.");
-            if (qemu_rdma_post_send_control(rdma, NULL, &head, &err) < 0) {
-                error_report_err(err);
-            }
+            qemu_rdma_post_send_control(rdma, NULL, &head, NULL);
         }
 
         rdma_disconnect(rdma->cm_id);
-- 
2.41.0


