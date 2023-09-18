Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D55CD7A4B4D
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:50:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFST-00035B-84; Mon, 18 Sep 2023 10:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSN-0002yE-Gm
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002bs-PL
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0V8ad4bZ0AfvBGwm9pLsga4NfMnC2GHO7+bozWeQjk=;
 b=BsinaZ5dyE8q8tHM7CETy+pEzn5RbsuTEG1Y5wKaMhrdnFh/6JiMOKwOPjKbZG6tXx0qAs
 lNWondgXlS2Y17DbH5Q++cGyzwgtmfHmUIi7arIBY9QseZ2LSfiXAJMS2ZIswTJB182hkB
 1kTz3pr29zoum6aeu3S51dkwKtgJXf4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-O8nPUsccMYGoGmb7JBzSLA-1; Mon, 18 Sep 2023 10:42:11 -0400
X-MC-Unique: O8nPUsccMYGoGmb7JBzSLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FDEA3800BAD
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E68C2156702
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 680F721E68A0; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 44/52] migration/rdma: Silence qemu_rdma_resolve_host()
Date: Mon, 18 Sep 2023 16:41:58 +0200
Message-ID: <20230918144206.560120-45-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

qemu_rdma_resolve_host() violates this principle: it calls
error_report().

Clean this up: drop error_report().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 41f0ae4ddb..0e365db06a 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1003,7 +1003,6 @@ route:
         error_setg(errp,
                    "RDMA ERROR: result not equal to event_addr_resolved %s",
                    rdma_event_str(cm_event->event));
-        error_report("rdma_resolve_addr");
         rdma_ack_cm_event(cm_event);
         goto err_resolve_get_addr;
     }
-- 
2.41.0


