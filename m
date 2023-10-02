Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB0A7B52E9
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 14:23:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnHul-0007Jf-Ra; Mon, 02 Oct 2023 08:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnHui-0007Ij-Vj
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnHug-0007SN-JY
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696249238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1RobKDhYZxL1oy4jJItXEsMcRAc5IglHj6SZvYn0WWM=;
 b=WAFlvowyhznmvBvZRCxYQLrPwwxad1SE4bKD5kvR0ZongZrTYOayPqvBp5Upsas4nNvO0y
 fBI6pvYJKvM51lAK9J1ZfLc8U926xwqv0NX5jf3rRAyqZ5EAl4dJkbnpA7O2IqkVWp4NMc
 2inQNdkBruwGyEBFWe/VwEaWNk25jio=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-L52tefoDPaSxjsIcGQgx0A-1; Mon, 02 Oct 2023 08:20:36 -0400
X-MC-Unique: L52tefoDPaSxjsIcGQgx0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16BCC3C19925;
 Mon,  2 Oct 2023 12:20:36 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 249002156701;
 Mon,  2 Oct 2023 12:20:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Tejus GK <tejus.gk@nutanix.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 06/13] migration: Refactor repeated call of
 yank_unregister_instance
Date: Mon,  2 Oct 2023 14:20:14 +0200
Message-ID: <20231002122021.231959-7-quintela@redhat.com>
In-Reply-To: <20231002122021.231959-1-quintela@redhat.com>
References: <20231002122021.231959-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

From: Tejus GK <tejus.gk@nutanix.com>

In the function qmp_migrate(), yank_unregister_instance() gets called
twice which isn't required. Hence, refactoring it so that it gets called
during the local_error cleanup.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
Message-ID: <20230621130940.178659-3-tejus.gk@nutanix.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index e2ed85b5be..6d3cf5d5cd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1703,15 +1703,11 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_outgoing_migration(s, p, &local_err);
     } else {
-        if (!resume_requested) {
-            yank_unregister_instance(MIGRATION_YANK_INSTANCE);
-        }
         error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
         block_cleanup_parameters();
-        return;
     }
 
     if (local_err) {
-- 
2.41.0


