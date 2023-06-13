Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0917472E66C
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 16:59:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q95TW-0006ED-Ij; Tue, 13 Jun 2023 10:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TO-0006AJ-HW
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TN-0007Yl-56
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686668296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5u+tuTyHdYcoPsVBpk4oMKPHwy05vocsbj2T88lAuiY=;
 b=c0PLtvWaazd7ZZEKvYhhSG9Ep7Pn/bVKIHIfpIUZ1A7EoScrUYPDejE0epivLeTDpdOKlc
 r25zx2lgS1/icbffVVO0f66c2quQZGvXvKG0EszMrYGsrMteyF5d0SeJdizUS5eC0/nXZo
 WHxI2Xvtc5dTEnxw1A11IFNOFeZqrkg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-EFz01cNIOV-HsKcgN3jJEw-1; Tue, 13 Jun 2023 10:58:14 -0400
X-MC-Unique: EFz01cNIOV-HsKcgN3jJEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47F4F3C11CC0;
 Tue, 13 Jun 2023 14:58:13 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A08240C6F5C;
 Tue, 13 Jun 2023 14:58:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH 11/18] migration: Move busy++ to migrate_with_multithread
Date: Tue, 13 Jun 2023 16:57:50 +0200
Message-Id: <20230613145757.10131-12-quintela@redhat.com>
In-Reply-To: <20230613145757.10131-1-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

And now we can simplify save_compress_page().

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram-compress.c | 1 +
 migration/ram.c          | 7 +------
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index 3c44803132..2652cdee8b 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -293,6 +293,7 @@ bool compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
         }
         if (!wait) {
             qemu_mutex_unlock(&comp_done_lock);
+            compression_counters.busy++;
             return false;
         }
         /*
diff --git a/migration/ram.c b/migration/ram.c
index 2a3ff2c36e..60f24006bc 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2034,12 +2034,7 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
         return false;
     }
 
-    if (compress_page_with_multi_thread(block, offset, send_queued_data)) {
-        return true;
-    }
-
-    compression_counters.busy++;
-    return false;
+    return compress_page_with_multi_thread(block, offset, send_queued_data);
 }
 
 /**
-- 
2.40.1


