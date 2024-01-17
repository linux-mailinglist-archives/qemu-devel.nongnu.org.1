Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22731830D74
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 20:49:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQBtb-0004L1-7j; Wed, 17 Jan 2024 14:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQBtZ-0004Kq-S3
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 14:48:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQBtY-0005hj-Dx
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 14:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705520895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id; bh=4xKuW9HDh8EJpyLUCMIPJPg70XmDgQUFJtYTxMEdEyw=;
 b=X+gBUa1JfjEdV+sx7DotyS40FqH8YG/GCYO18uZgqcRlQegjoEBJK+7Bw7GN++14FSYaJ8
 hWAz6yNxRhA6y1/rOQmI6BTvaaT9JkhmI5Lu+iKV+zEsqRf2ag6dCHlU+196iXk25xzhfl
 IR50g+BLP1SDgGVK6gvWy9P3bboE14c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-VjWjTuZWOmGre9vtaMuz8A-1; Wed, 17 Jan 2024 14:48:11 -0500
X-MC-Unique: VjWjTuZWOmGre9vtaMuz8A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F41C185A786;
 Wed, 17 Jan 2024 19:48:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A8CE3C25;
 Wed, 17 Jan 2024 19:48:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E203921E6806; Wed, 17 Jan 2024 20:48:08 +0100 (CET)
Resent-To: qemu-devel@nongnu.org, het.gala@nutanix.com, farosas@suse.de
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Wed, 17 Jan 2024 20:48:08 +0100
Resent-Message-ID: <87le8ng2rr.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Wed Jan 17 15:07:22 2024
X-Original-To: armbru
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8B66021E6806; Wed, 17 Jan 2024 15:07:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de,
	het.gala@nutanix.com
Subject: [PATCH] migration: Plug memory leak on HMP migrate error path
Date: Wed, 17 Jan 2024 15:07:22 +0100
Message-ID: <20240117140722.3979657-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Lines: 36
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

hmp_migrate() leaks @caps when qmp_migrate() fails.  Plug the leak
with g_autoptr().

Fixes: 967f2de5c9ec (migration: Implement MigrateChannelList to hmp migration flow.) v8.2.0-rc0
Fixes: CID 1533124
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/migration-hmp-cmds.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 740a219aa4..99b49df5dd 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -764,7 +764,7 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     bool resume = qdict_get_try_bool(qdict, "resume", false);
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
-    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannelList) caps = NULL;
     g_autoptr(MigrationChannel) channel = NULL;
 
     if (inc) {
@@ -789,8 +789,6 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    qapi_free_MigrationChannelList(caps);
-
     if (!detach) {
         HMPMigrationStatus *status;
 
-- 
2.43.0



