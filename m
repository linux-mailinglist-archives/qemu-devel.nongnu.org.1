Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFD27B1E69
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:30:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlr67-0000A3-Pd; Thu, 28 Sep 2023 09:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlr60-0008VD-Mq
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlr5x-0002A5-3r
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QbbKuX2C0YajtpZusWsKJXC+ho+rE+txMpKidZr5q5E=;
 b=HaAvMFHdB89ufxAz//bfuRJckcCQH2AiotAcyebLcSrXC7yN2r3QlIkc0urbyweCtel2sC
 5Hw3kwFUqb4WRDx+eCAtwiYwaVO5JrqgroWQs7iIQkJ8qPFq/rYBW1wjKuiKQZP4hF+XJa
 98fewytRrbkGnc1dRhRpfSLGPalzy3U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-cn0zZ7JSPMmyKN7Mhq1MxA-1; Thu, 28 Sep 2023 09:30:18 -0400
X-MC-Unique: cn0zZ7JSPMmyKN7Mhq1MxA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 414853C1F12F;
 Thu, 28 Sep 2023 13:30:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DD6E492B16;
 Thu, 28 Sep 2023 13:30:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 60CEC21E68A7; Thu, 28 Sep 2023 15:20:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 51/53] migration/rdma: Downgrade qemu_rdma_cleanup() errors
 to warnings
Date: Thu, 28 Sep 2023 15:20:17 +0200
Message-ID: <20230928132019.2544702-52-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Downgrade qemu_rdma_cleanup()'s errors to warnings.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 4e4d818460..54b59d12b1 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2358,9 +2358,9 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
                                        .type = RDMA_CONTROL_ERROR,
                                        .repeat = 1,
                                      };
-            error_report("Early error. Sending error.");
+            warn_report("Early error. Sending error.");
             if (qemu_rdma_post_send_control(rdma, NULL, &head, &err) < 0) {
-                error_report_err(err);
+                warn_report_err(err);
             }
         }
 
-- 
2.41.0


