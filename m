Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4592B7DC90A
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:08:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkdv-0000KG-9x; Tue, 31 Oct 2023 05:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkdo-00006V-Vq
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkdm-0006sd-Fx
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698742945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MAvCgT0ohAvu13qO9O2qXDeVppbBAyGNHtVWe+19H/o=;
 b=h9FBB7yb+7Vy9uzj5Gd0Tusj9pwpYVhwrJfHaj5oAEU/GlOSaFfZWVqPTMFcWgGhvzG8SB
 U5T4k2f04zdd++5o2iLyZRV6vQIXC94HIcI1MU3y3IgYOWBVFuhBA7rjotRFhOOV7rqamy
 LP9+cdOnMX2lRfPK8kS+4f5/IOJk+ZU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-rWmXFxJUOGyfWschV86yfg-1; Tue,
 31 Oct 2023 05:02:20 -0400
X-MC-Unique: rWmXFxJUOGyfWschV86yfg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3891B1C060CB;
 Tue, 31 Oct 2023 09:02:20 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A758F1C060AE;
 Tue, 31 Oct 2023 09:02:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 12/38] migration: Move busy++ to migrate_with_multithread
Date: Tue, 31 Oct 2023 10:01:16 +0100
Message-ID: <20231031090142.13122-13-quintela@redhat.com>
In-Reply-To: <20231031090142.13122-1-quintela@redhat.com>
References: <20231031090142.13122-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

And now we can simplify save_compress_page().

Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231019110724.15324-7-quintela@redhat.com>
---
 migration/ram-compress.c | 1 +
 migration/ram.c          | 8 ++------
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index a991b15b7a..f56e1f8e69 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -291,6 +291,7 @@ bool compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
         }
         if (!wait) {
             qemu_mutex_unlock(&comp_done_lock);
+            compression_counters.busy++;
             return false;
         }
         /*
diff --git a/migration/ram.c b/migration/ram.c
index 63a575ae90..46209388ec 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2067,12 +2067,8 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
         return false;
     }
 
-    if (compress_page_with_multi_thread(pss->block, offset, send_queued_data)) {
-        return true;
-    }
-
-    compression_counters.busy++;
-    return false;
+    return compress_page_with_multi_thread(pss->block, offset,
+                                           send_queued_data);
 }
 
 /**
-- 
2.41.0


