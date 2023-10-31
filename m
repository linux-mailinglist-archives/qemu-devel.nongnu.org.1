Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDECA7DC8F5
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:04:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkdf-00089S-M7; Tue, 31 Oct 2023 05:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkdX-00082n-Qi
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkdW-0006q7-5U
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698742929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l9wUW2OQfxfDQsGzuQG2LFoAYA/fNyU0RqVbl7N/h3E=;
 b=OSmSRpOyUHVYUnX04DwSuIGqAY6YmyNgaP37i7kQMrwPEpf54nuw0y/WgOY8G7DqIzhJnL
 WocyJqqDfKPG4TfKtIATaAbOA6UAwR0CttfazMYA9vaaAR3PdQ6H8ev7IlWhIYzMdeopMy
 4Y7jpMJg8Ex/1uR72DpRwXMROb0YaFc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-U_m1cco0OYip-IxPD_qqgw-1; Tue, 31 Oct 2023 05:02:04 -0400
X-MC-Unique: U_m1cco0OYip-IxPD_qqgw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97816811E7B;
 Tue, 31 Oct 2023 09:02:03 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3004A1C060AE;
 Tue, 31 Oct 2023 09:02:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 06/38] migration: Rename ram_handle_compressed() to
 ram_handle_zero()
Date: Tue, 31 Oct 2023 10:01:10 +0100
Message-ID: <20231031090142.13122-7-quintela@redhat.com>
In-Reply-To: <20231031090142.13122-1-quintela@redhat.com>
References: <20231031090142.13122-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Now that we know it only handles zero, we can remove the ch parameter.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231019085259.13307-3-quintela@redhat.com>
---
 migration/ram.h  |  2 +-
 migration/ram.c  | 10 +++++-----
 migration/rdma.c |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/migration/ram.h b/migration/ram.h
index 145c915ca7..3f724b2f02 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -60,7 +60,7 @@ int ram_discard_range(const char *block_name, uint64_t start, size_t length);
 int ram_postcopy_incoming_init(MigrationIncomingState *mis);
 int ram_load_postcopy(QEMUFile *f, int channel);
 
-void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
+void ram_handle_zero(void *host, uint64_t size);
 
 void ram_transferred_add(uint64_t bytes);
 void ram_release_page(const char *rbname, uint64_t offset);
diff --git a/migration/ram.c b/migration/ram.c
index 4bfb20c94a..e0ad732ee8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3446,7 +3446,7 @@ static inline void *colo_cache_from_block_offset(RAMBlock *block,
 }
 
 /**
- * ram_handle_compressed: handle the zero page case
+ * ram_handle_zero: handle the zero page case
  *
  * If a page (or a whole RDMA chunk) has been
  * determined to be zero, then zap it.
@@ -3455,10 +3455,10 @@ static inline void *colo_cache_from_block_offset(RAMBlock *block,
  * @ch: what the page is filled from.  We only support zero
  * @size: size of the zero page
  */
-void ram_handle_compressed(void *host, uint8_t ch, uint64_t size)
+void ram_handle_zero(void *host, uint64_t size)
 {
-    if (ch != 0 || !buffer_is_zero(host, size)) {
-        memset(host, ch, size);
+    if (!buffer_is_zero(host, size)) {
+        memset(host, 0, size);
     }
 }
 
@@ -4037,7 +4037,7 @@ static int ram_load_precopy(QEMUFile *f)
                 ret = -EINVAL;
                 break;
             }
-            ram_handle_compressed(host, ch, TARGET_PAGE_SIZE);
+            ram_handle_zero(host, TARGET_PAGE_SIZE);
             break;
 
         case RAM_SAVE_FLAG_PAGE:
diff --git a/migration/rdma.c b/migration/rdma.c
index 2d963fd147..e3493e3b3e 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3597,7 +3597,7 @@ int rdma_registration_handle(QEMUFile *f)
                              comp->value);
                 goto err;
             }
-            ram_handle_compressed(host_addr, comp->value, comp->length);
+            ram_handle_zero(host_addr, comp->length);
             break;
 
         case RDMA_CONTROL_REGISTER_FINISHED:
-- 
2.41.0


