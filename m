Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9767CBDA4
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:35:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfUd-0007Iv-2m; Tue, 17 Oct 2023 04:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfUT-0006sQ-6g
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:31:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfUQ-0005UK-Pn
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697531506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/sUvTnfMeZLcWZcSuGDvtJjwzCgAkOgAh8rm42wOkO0=;
 b=RQFzB68sjj4owxOFlFfuys8wfp8y9t+sw0t+T3Ly6wdxta6jx/gUSjz3sXg/HUYIYbVkKg
 6pdcjuHJhp2fxYEony6ts5nOZlM+wYtV3M1RT3kuATmmnJ9GfgsySGIcGkyoUS3QW9RU5K
 SXgYGw0BL7wyBVyAp6ApZM9h3afUYjY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-WDr0i9M-On6zlKF9iMYJRQ-1; Tue, 17 Oct 2023 04:31:34 -0400
X-MC-Unique: WDr0i9M-On6zlKF9iMYJRQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4636685829A;
 Tue, 17 Oct 2023 08:31:34 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EA661C060AE;
 Tue, 17 Oct 2023 08:31:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PULL 29/38] multifd: fix counters in multifd_send_thread
Date: Tue, 17 Oct 2023 10:29:54 +0200
Message-ID: <20231017083003.15951-30-quintela@redhat.com>
In-Reply-To: <20231017083003.15951-1-quintela@redhat.com>
References: <20231017083003.15951-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Previous commit cbec7eb76879d419e7dbf531ee2506ec0722e825
"migration/multifd: Compute transferred bytes correctly"
removed accounting for packet_len in non-rdma
case, but the next_packet_size only accounts for pages, not for
the header packet (normal_pages * PAGE_SIZE) that is being sent
as iov[0]. The packet_len part should be added to account for
the size of MultiFDPacket and the array of the offsets.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231011184358.97349-4-elena.ufimtseva@oracle.com>
---
 migration/multifd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 0f6b203877..e6e0013c16 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -714,8 +714,6 @@ static void *multifd_send_thread(void *opaque)
                 if (ret != 0) {
                     break;
                 }
-                stat64_add(&mig_stats.multifd_bytes, p->packet_len);
-                stat64_add(&mig_stats.transferred, p->packet_len);
             } else {
                 /* Send header using the same writev call */
                 p->iov[0].iov_len = p->packet_len;
@@ -728,8 +726,10 @@ static void *multifd_send_thread(void *opaque)
                 break;
             }
 
-            stat64_add(&mig_stats.multifd_bytes, p->next_packet_size);
-            stat64_add(&mig_stats.transferred, p->next_packet_size);
+            stat64_add(&mig_stats.multifd_bytes,
+                       p->next_packet_size + p->packet_len);
+            stat64_add(&mig_stats.transferred,
+                       p->next_packet_size + p->packet_len);
             qemu_mutex_lock(&p->mutex);
             p->pending_job--;
             qemu_mutex_unlock(&p->mutex);
-- 
2.41.0


