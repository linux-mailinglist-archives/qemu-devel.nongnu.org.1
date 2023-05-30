Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9625E715F51
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:29:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yT0-0001Uj-Km; Tue, 30 May 2023 08:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3ySv-0001Qq-LY
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3ySn-0000h4-PW
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685449711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZDTNI6jMSmjUnA1ZJis8o+rXfT66go9E6XExEz/hVZg=;
 b=cqJXw1y+eqXsbQAYbw7Nat5gA3r9Z54AMReIYeeG7RnPL4nH7pT4RWQuPOhNOdyQI/u1Ea
 jeeIDpi1/NeLcsqhHyqCjGn23ZwDomj8MXfdpBqAmo3th+522OWdCyy4FzNZl4kGgaM2VJ
 D1dyVbzBKAPFizK/AnoHl8kKaHZf1Hw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-I-2gFNppO2aKHow7ynQwBA-1; Tue, 30 May 2023 08:28:30 -0400
X-MC-Unique: I-2gFNppO2aKHow7ynQwBA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D92A58007D9;
 Tue, 30 May 2023 12:28:29 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 794B340CFD45;
 Tue, 30 May 2023 12:28:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 08/16] migration: Use the number of transferred bytes directly
Date: Tue, 30 May 2023 14:28:05 +0200
Message-Id: <20230530122813.2674-9-quintela@redhat.com>
In-Reply-To: <20230530122813.2674-1-quintela@redhat.com>
References: <20230530122813.2674-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We only use migration_transferred_bytes() to calculate the rate_limit,
for that we don't need to flush whatever is on the qemu_file buffer.
Remember that the buffer is really small (normal case is 32K if we use
iov's can be 64 * TARGET_PAGE_SIZE), so this is not relevant to
calculations.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration-stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration-stats.c b/migration/migration-stats.c
index 79eea8d865..1696185694 100644
--- a/migration/migration-stats.c
+++ b/migration/migration-stats.c
@@ -62,7 +62,7 @@ uint64_t migration_transferred_bytes(QEMUFile *f)
 {
     uint64_t multifd = stat64_get(&mig_stats.multifd_bytes);
     uint64_t rdma = stat64_get(&mig_stats.rdma_bytes);
-    uint64_t qemu_file = qemu_file_transferred(f);
+    uint64_t qemu_file = stat64_get(&mig_stats.qemu_file_transferred);
 
     trace_migration_transferred_bytes(qemu_file, multifd, rdma);
     return qemu_file + multifd + rdma;
-- 
2.40.1


