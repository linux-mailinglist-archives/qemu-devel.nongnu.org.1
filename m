Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C83683FC8A
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Jan 2024 04:06:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUHwo-00043L-Qe; Sun, 28 Jan 2024 22:04:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHwm-0003zS-G4
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 22:04:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHwk-0002bo-VD
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 22:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706497470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yOIHVYyv54egdlVoMdUVLVFk4lzZ/xlT1WvDt+htyXc=;
 b=G9W9cJcSUS7ydxnAbPhQI5P0YEFETCHCGhetaGqZxc4dBT40Sym3T1pklZnj67Q3KE175/
 D23jYflk4Yf2Ij8wvtc9eHD6lcKJ8LPU3lw/AoL+ZZJ+xEoJUaSdweXkVdnZd3IDE4cZi3
 eIX+Rm6wOWl9S2knNdkSAhkM63irXYU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-ZTD3sIyWPJCtcTfhIz3bmg-1; Sun,
 28 Jan 2024 22:04:25 -0500
X-MC-Unique: ZTD3sIyWPJCtcTfhIz3bmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B2A83804507;
 Mon, 29 Jan 2024 03:04:25 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C47041121306;
 Mon, 29 Jan 2024 03:04:22 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	peterx@redhat.com
Subject: [PULL 04/14] migration: Drop unnecessary check in ram's
 pending_exact()
Date: Mon, 29 Jan 2024 11:03:55 +0800
Message-ID: <20240129030405.177100-5-peterx@redhat.com>
In-Reply-To: <20240129030405.177100-1-peterx@redhat.com>
References: <20240129030405.177100-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Peter Xu <peterx@redhat.com>

When the migration frameworks fetches the exact pending sizes, it means
this check:

  remaining_size < s->threshold_size

Must have been done already, actually at migration_iteration_run():

    if (must_precopy <= s->threshold_size) {
        qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);

That should be after one round of ram_state_pending_estimate().  It makes
the 2nd check meaningless and can be dropped.

To say it in another way, when reaching ->state_pending_exact(), we
unconditionally sync dirty bits for precopy.

Then we can drop migrate_get_current() there too.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240117075848.139045-3-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index c0cdcccb75..d5b7cd5ac2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3213,21 +3213,20 @@ static void ram_state_pending_estimate(void *opaque, uint64_t *must_precopy,
 static void ram_state_pending_exact(void *opaque, uint64_t *must_precopy,
                                     uint64_t *can_postcopy)
 {
-    MigrationState *s = migrate_get_current();
     RAMState **temp = opaque;
     RAMState *rs = *temp;
+    uint64_t remaining_size;
 
-    uint64_t remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
-
-    if (!migration_in_postcopy() && remaining_size < s->threshold_size) {
+    if (!migration_in_postcopy()) {
         bql_lock();
         WITH_RCU_READ_LOCK_GUARD() {
             migration_bitmap_sync_precopy(rs, false);
         }
         bql_unlock();
-        remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
     }
 
+    remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
+
     if (migrate_postcopy_ram()) {
         /* We can do postcopy, and all the data is postcopiable */
         *can_postcopy += remaining_size;
-- 
2.43.0


