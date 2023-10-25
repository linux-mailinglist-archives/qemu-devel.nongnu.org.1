Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BFB7D6674
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:14:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvZw0-0003rG-Dc; Wed, 25 Oct 2023 05:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvZvZ-0002Cu-KW
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvZvY-0006z9-5c
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698225107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M/tIWNBaY9Ee7ExQTmfiSPxxxciJyJJWmlcDvxhAYcY=;
 b=LB9BTfn9I5onOqOiqm8tyeRvxU2z1FDhmqzdHTi/NFDq3iUz9QVI46ibEPX3EtlxJw+GHc
 wVt3WwiptMJdWakM/xNHGnnpsrXaB61Xl++XE4cbVeHlSrLJyWyCV94fA0bkrQHgQERDhu
 UgDxBi0HsUW6YIgSj4otX8JAQFkkvsI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-SkBWkxi3O5OgcD1vZTicag-1; Wed, 25 Oct 2023 05:11:42 -0400
X-MC-Unique: SkBWkxi3O5OgcD1vZTicag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0526101AA42;
 Wed, 25 Oct 2023 09:11:41 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B36B1120F;
 Wed, 25 Oct 2023 09:11:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fabiano Rosas <farosas@suse.de>, Li Zhijian <lizhijian@fujitsu.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v2 11/12] migration: Remove transferred atomic counter
Date: Wed, 25 Oct 2023 11:11:16 +0200
Message-ID: <20231025091117.6342-12-quintela@redhat.com>
In-Reply-To: <20231025091117.6342-1-quintela@redhat.com>
References: <20231025091117.6342-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

After last commit, it is a write only variable.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration-stats.h | 4 ----
 migration/multifd.c         | 3 ---
 migration/ram.c             | 1 -
 3 files changed, 8 deletions(-)

diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index 68f3939188..05290ade76 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -97,10 +97,6 @@ typedef struct {
      * Number of bytes sent through RDMA.
      */
     Stat64 rdma_bytes;
-    /*
-     * Total number of bytes transferred.
-     */
-    Stat64 transferred;
     /*
      * Number of pages transferred that were full of zeros.
      */
diff --git a/migration/multifd.c b/migration/multifd.c
index e2a45c667a..ec58c58082 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -188,7 +188,6 @@ static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
         return -1;
     }
     stat64_add(&mig_stats.multifd_bytes, size);
-    stat64_add(&mig_stats.transferred, size);
     return 0;
 }
 
@@ -733,8 +732,6 @@ static void *multifd_send_thread(void *opaque)
 
             stat64_add(&mig_stats.multifd_bytes,
                        p->next_packet_size + p->packet_len);
-            stat64_add(&mig_stats.transferred,
-                       p->next_packet_size + p->packet_len);
             p->next_packet_size = 0;
             qemu_mutex_lock(&p->mutex);
             p->pending_job--;
diff --git a/migration/ram.c b/migration/ram.c
index 5ccf70333a..6d2bf50614 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -455,7 +455,6 @@ void ram_transferred_add(uint64_t bytes)
     } else {
         stat64_add(&mig_stats.downtime_bytes, bytes);
     }
-    stat64_add(&mig_stats.transferred, bytes);
 }
 
 struct MigrationOps {
-- 
2.41.0


