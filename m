Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0477071F6CF
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 01:45:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ryJ-0006A6-UJ; Thu, 01 Jun 2023 19:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4ryH-00069T-Bb
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 19:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4ryA-0000wi-Us
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 19:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685663078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=91p2ckiGRqO94BU5adKr4Xtfpf3nukraIVriIitpigg=;
 b=HdKmt4HbVGgY2bzkp0Qs6iJMGgW+P5czzINBue9JDU7M4vdhHD/9yPHPqX+sVqEccY8hHg
 zRCIUeWhcbuBWIM4WsYz+NkQRFwtzBfmwnm+It9F5QFGnp3pbnHVFMP/csJJ11EweDRgpA
 BPb6xZ6gRN0O9HejEvzwOOwA9fZL7Q4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-Dr3206cbOju2cLHNovYPbQ-1; Thu, 01 Jun 2023 19:44:37 -0400
X-MC-Unique: Dr3206cbOju2cLHNovYPbQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED04E1C08DB0;
 Thu,  1 Jun 2023 23:44:36 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4575492B00;
 Thu,  1 Jun 2023 23:44:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: [PULL 6/6] migration: stop tracking ram writes when cancelling
 background migration
Date: Fri,  2 Jun 2023 01:44:26 +0200
Message-Id: <20230601234426.29984-7-quintela@redhat.com>
In-Reply-To: <20230601234426.29984-1-quintela@redhat.com>
References: <20230601234426.29984-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

Currently, it is only done when the iteration finishes successfully.
Not cleaning up the userfaultfd write protection can lead to
symptoms/issues such as the process hanging in memmove or GDB not
being able to attach.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20230526115908.196171-1-f.ebner@proxmox.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 7c3425c6fe..dc05c6f6ea 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2400,13 +2400,6 @@ static void bg_migration_completion(MigrationState *s)
 {
     int current_active_state = s->state;
 
-    /*
-     * Stop tracking RAM writes - un-protect memory, un-register UFFD
-     * memory ranges, flush kernel wait queues and wake up threads
-     * waiting for write fault to be resolved.
-     */
-    ram_write_tracking_stop();
-
     if (s->state == MIGRATION_STATUS_ACTIVE) {
         /*
          * By this moment we have RAM content saved into the migration stream.
@@ -2788,6 +2781,13 @@ static void migration_iteration_finish(MigrationState *s)
 
 static void bg_migration_iteration_finish(MigrationState *s)
 {
+    /*
+     * Stop tracking RAM writes - un-protect memory, un-register UFFD
+     * memory ranges, flush kernel wait queues and wake up threads
+     * waiting for write fault to be resolved.
+     */
+    ram_write_tracking_stop();
+
     qemu_mutex_lock_iothread();
     switch (s->state) {
     case MIGRATION_STATUS_COMPLETED:
-- 
2.40.1


