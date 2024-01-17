Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D168300E5
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 08:59:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ0pE-00074p-Q7; Wed, 17 Jan 2024 02:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ0pC-000743-Uq
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:59:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ0pB-000275-Fn
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705478340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SkLCeIrbMoZQbvJLLKjgqsorGDJr9Xlgo9gWw+cIrD8=;
 b=ejiOnWWkHULCcOUE3MyfVzkCsE4qPIColqHp/atO3jx/YIw0qA8YFCQMu7wbKoUDX5CEVi
 Icmz7fHB1t2MyVuYI3DeV65phvpH6SC8Ed7Mr3bibN8cviIFsctha3P/XMKsHg6hlwC+Su
 7HbqdvkBLlRHNQoMt/0ovyLSl6KbEao=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-b9B7bS71MPmDo0IDxwdltA-1; Wed, 17 Jan 2024 02:58:58 -0500
X-MC-Unique: b9B7bS71MPmDo0IDxwdltA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3198283FC23;
 Wed, 17 Jan 2024 07:58:58 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDB9FC15A0C;
 Wed, 17 Jan 2024 07:58:54 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Bandan Das <bdas@redhat.com>,
 Julia Suvorova <jusual@redhat.com>
Subject: [PATCH 1/3] migration: Make threshold_size an uint64_t
Date: Wed, 17 Jan 2024 15:58:46 +0800
Message-ID: <20240117075848.139045-2-peterx@redhat.com>
In-Reply-To: <20240117075848.139045-1-peterx@redhat.com>
References: <20240117075848.139045-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

From: Peter Xu <peterx@redhat.com>

It's always used to compare against another uint64_t.  Make it always clear
that it's never a negative.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.h b/migration/migration.h
index 17972dac34..a589ae8650 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -296,7 +296,7 @@ struct MigrationState {
      * this threshold; it's calculated from the requested downtime and
      * measured bandwidth, or avail-switchover-bandwidth if specified.
      */
-    int64_t threshold_size;
+    uint64_t threshold_size;
 
     /* params from 'migrate-set-parameters' */
     MigrationParameters parameters;
-- 
2.43.0


