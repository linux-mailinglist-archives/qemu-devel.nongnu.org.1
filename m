Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC058823B82
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 05:36:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLFRL-0005Cz-PF; Wed, 03 Jan 2024 23:34:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFRC-0004oE-9X
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:34:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFRA-0006lY-K8
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704342871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PG5OczbzhFEeu/f0fXXcZOAN8vl5nmE+f4X8lWso424=;
 b=h+IayVAk/J+ox+J+r91oJ4OjJMnhJREvkdcEKzaN9wenwLTPRqhX8JCv0KLjlU9GAgVAYQ
 UiQ/y7+Hfz4cIW90S7WoIXlVaZdD7nNsB5pQ2bN9NzLEWU01UAuZMtFjaP4i4UZrEVlUAh
 mDJ27Ov0c8AW4twu3Rt4EUxS72Ya9s0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-xJuENRcjN3mjI5zDkp-PbA-1; Wed,
 03 Jan 2024 23:34:28 -0500
X-MC-Unique: xJuENRcjN3mjI5zDkp-PbA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DD5F380673B;
 Thu,  4 Jan 2024 04:34:28 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1451C1596E;
 Thu,  4 Jan 2024 04:34:23 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>,
 Juan Quintela <quintela@trasno.org>, peterx@redhat.com,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 26/26] migration: fix coverity migrate_mode finding
Date: Thu,  4 Jan 2024 12:32:11 +0800
Message-ID: <20240104043213.431566-27-peterx@redhat.com>
In-Reply-To: <20240104043213.431566-1-peterx@redhat.com>
References: <20240104043213.431566-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Coverity diagnoses a possible out-of-range array index here ...

    static GSList *migration_blockers[MIG_MODE__MAX];

    fill_source_migration_info() {
        GSList *cur_blocker = migration_blockers[migrate_mode()];

... because it does not know that MIG_MODE__MAX will never be returned as
a migration mode.  To fix, assert so in migrate_mode().

Fixes: fa3673e497a1 ("migration: per-mode blockers")

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/1699907025-215450-1-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/options.c b/migration/options.c
index 8d8ec73ad9..3e3e0b93b4 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -833,8 +833,10 @@ uint64_t migrate_max_postcopy_bandwidth(void)
 MigMode migrate_mode(void)
 {
     MigrationState *s = migrate_get_current();
+    MigMode mode = s->parameters.mode;
 
-    return s->parameters.mode;
+    assert(mode >= 0 && mode < MIG_MODE__MAX);
+    return mode;
 }
 
 int migrate_multifd_channels(void)
-- 
2.41.0


