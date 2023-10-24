Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EBA7D4BE2
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 11:23:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvDcO-0002PV-Qg; Tue, 24 Oct 2023 05:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qvDcN-0002Oz-3b
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 05:22:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qvDcK-0004xQ-UC
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 05:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698139347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zwuHTMKW3wjarxhyvY4spHMbOfYxPVOZQmk0Cn8RX0s=;
 b=Q+7fzH/A/6oIYtPZJLmT0jO1qcLtGOHKkU2619DTbNnY9bdhk4Ac9YI0E0Tp5MmFqjhLiu
 k+CrmQ9fJjt72p8AFEz1CeWmndIQOO0CBFvujxtVuOvTsArqIJlTtbCud0ft0IIa4ZpAed
 sD35WZicalSiZ827Camh5H4ZBr9ClSs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-QpAlJTeLNIax2ws9BdvN0Q-1; Tue, 24 Oct 2023 05:22:24 -0400
X-MC-Unique: QpAlJTeLNIax2ws9BdvN0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB05D88D78B;
 Tue, 24 Oct 2023 09:22:23 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-205.str.redhat.com
 [10.33.192.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 055F32026D4C;
 Tue, 24 Oct 2023 09:22:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v2] migration/ram: Fix compilation with -Wshadow=local
Date: Tue, 24 Oct 2023 11:22:20 +0200
Message-ID: <20231024092220.55305-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

Rename the variable here to avoid that it shadows a variable from
the beginning of the function scope. With this change the code now
successfully compiles with -Wshadow=local.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Need the value for the qemu_file_set_error() line, too

 migration/ram.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 92769902bb..212add4481 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3208,6 +3208,8 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     rs->last_stage = !migration_in_colo_state();
 
     WITH_RCU_READ_LOCK_GUARD() {
+        int rdma_reg_ret;
+
         if (!migration_in_postcopy()) {
             migration_bitmap_sync_precopy(rs, true);
         }
@@ -3238,9 +3240,9 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 
         ram_flush_compressed_data(rs);
 
-        int ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
-        if (ret < 0) {
-            qemu_file_set_error(f, ret);
+        rdma_reg_ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
+        if (rdma_reg_ret < 0) {
+            qemu_file_set_error(f, rdma_reg_ret);
         }
     }
 
-- 
2.41.0


