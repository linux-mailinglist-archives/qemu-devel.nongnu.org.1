Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 388DA7CF34A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 10:54:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtOmD-0004MS-4M; Thu, 19 Oct 2023 04:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtOmB-0004ME-Rz
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 04:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtOmA-0001iU-D9
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 04:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697705585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KJeNsiMKZaOViLZzkQUGImwu28+YIJJcGCN+fE+VaCI=;
 b=SFkvvP0IO6CK2Nmt+aCAgk+woTXIwMtdhjDr7fJogHiCpkNvyPAjhqgZ21NlLp+ZCSlOdE
 HRfbaZ508dOHmoe0ENxcN48HWK4e1Go5OGZeEcMcSMno32BAGtmybVYKHG5AUOfTLZk9Sa
 i9n96sY/gJgatskaNRE6iCG2aW9hIXg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-llupVRGTOPqXQduUh_oiQQ-1; Thu, 19 Oct 2023 04:53:03 -0400
X-MC-Unique: llupVRGTOPqXQduUh_oiQQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5A1228237D0;
 Thu, 19 Oct 2023 08:53:02 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1D1A10828;
 Thu, 19 Oct 2023 08:53:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 1/2] migration: Receiving a zero page non zero is an error
Date: Thu, 19 Oct 2023 10:52:58 +0200
Message-ID: <20231019085259.13307-2-quintela@redhat.com>
In-Reply-To: <20231019085259.13307-1-quintela@redhat.com>
References: <20231019085259.13307-1-quintela@redhat.com>
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

We don't allow non zero compressed pages since:

commit 3edcd7e6ebae3ef0ac178eed5f4225803159562d
Author: Peter Lieven <pl@kamp.de>
Date:   Tue Mar 26 10:58:35 2013 +0100

    migration: search for zero instead of dup pages

RDMA case is a bit more complicated, but they don't handle it since:

commit a1febc4950f2c6232c002f401d7cd409f6fa6a88
Author: Richard Henderson <rth@twiddle.net>
Date:   Mon Aug 29 11:46:14 2016 -0700

    cutils: Export only buffer_is_zero

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c  | 15 +++++++++++----
 migration/rdma.c |  6 +++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index c844151ee9..0dd8bbb339 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3730,16 +3730,18 @@ int ram_load_postcopy(QEMUFile *f, int channel)
         switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
         case RAM_SAVE_FLAG_ZERO:
             ch = qemu_get_byte(f);
+            if (ch != 0) {
+                error_report("Found a zero page with value %d", ch);
+                ret = -EINVAL;
+                break;
+            }
             /*
              * Can skip to set page_buffer when
              * this is a zero page and (block->page_size == TARGET_PAGE_SIZE).
              */
-            if (ch || !matches_target_page_size) {
+            if (!matches_target_page_size) {
                 memset(page_buffer, ch, TARGET_PAGE_SIZE);
             }
-            if (ch) {
-                tmp_page->all_zero = false;
-            }
             break;
 
         case RAM_SAVE_FLAG_PAGE:
@@ -4044,6 +4046,11 @@ static int ram_load_precopy(QEMUFile *f)
 
         case RAM_SAVE_FLAG_ZERO:
             ch = qemu_get_byte(f);
+            if (ch != 0) {
+                error_report("Found a zero page with value %d", ch);
+                ret = -EINVAL;
+                break;
+            }
             ram_handle_compressed(host, ch, TARGET_PAGE_SIZE);
             break;
 
diff --git a/migration/rdma.c b/migration/rdma.c
index 2a1852ec7f..2d963fd147 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3592,7 +3592,11 @@ int rdma_registration_handle(QEMUFile *f)
 
             host_addr = block->local_host_addr +
                             (comp->offset - block->offset);
-
+            if (comp->value) {
+                error_report("rdma: Zero page with non-zero (%d) value",
+                             comp->value);
+                goto err;
+            }
             ram_handle_compressed(host_addr, comp->value, comp->length);
             break;
 
-- 
2.41.0


