Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF03A7D514B
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 15:19:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvHEU-0004Fn-0c; Tue, 24 Oct 2023 09:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvHEQ-0004AM-6L
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:14:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvHEO-00014r-Mr
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698153240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l9wUW2OQfxfDQsGzuQG2LFoAYA/fNyU0RqVbl7N/h3E=;
 b=KTXq63eqav1UqGZMGC5t2/EnJ+Nzq2RrQzh7gZ1Wmleo53sJczc6/2L3XltiLUKBpS0NY4
 +iuLza9TRDCgoTeUF06KtnnqSNProSMgnHRgOlwZEzbeetPpxMvoU8190oUvRfG5iDU89S
 W8ZhXHfrDFvsubIQdReiGv9SMfE0j2A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-tsFkJ0nwNl-9O3EU9lhotg-1; Tue, 24 Oct 2023 09:13:56 -0400
X-MC-Unique: tsFkJ0nwNl-9O3EU9lhotg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5998C185A795;
 Tue, 24 Oct 2023 13:13:54 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB3BA1C060AE;
 Tue, 24 Oct 2023 13:13:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Corey Minyard <minyard@acm.org>, Li Zhijian <lizhijian@fujitsu.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 libvir-list@redhat.com, Stefan Weil <sw@weilnetz.de>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Eric Farman <farman@linux.ibm.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org
Subject: [PULL 06/39] migration: Rename ram_handle_compressed() to
 ram_handle_zero()
Date: Tue, 24 Oct 2023 15:12:32 +0200
Message-ID: <20231024131305.87468-7-quintela@redhat.com>
In-Reply-To: <20231024131305.87468-1-quintela@redhat.com>
References: <20231024131305.87468-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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


