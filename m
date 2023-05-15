Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 239A7703DFD
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:58:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeKe-0000MB-L8; Mon, 15 May 2023 15:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeKc-0000FJ-K1
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeKb-0005RZ-05
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G8IHujxuK+JumnUX8kPzIabXCwUMnOMo9sIpXhKBr0Q=;
 b=HkupFu9qNemCdMrf8gzgdJpa/D1lk4xCX0reHHSm7OHTZCXbTbDI/tffPpuuLKm8++LDIu
 /vYuRnNvJhiyHdpyse8ZeVD6voVEG5BUJbuux86YP/BXTmXjjjZFEVPfLHXLTFCKFEBSWz
 1/EIVygVhHd9N0aTNx6IsrZ2GQj6tnI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-23N1y86DMuGYye-uWnCWbA-1; Mon, 15 May 2023 15:57:59 -0400
X-MC-Unique: 23N1y86DMuGYye-uWnCWbA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 755D8101A54F;
 Mon, 15 May 2023 19:57:58 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEF38492B00;
 Mon, 15 May 2023 19:57:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Blake <eblake@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 09/16] migration: We don't need the field rate_limit_used
 anymore
Date: Mon, 15 May 2023 21:57:02 +0200
Message-Id: <20230515195709.63843-10-quintela@redhat.com>
In-Reply-To: <20230515195709.63843-1-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since previous commit, we calculate how much data we have send with
migration_transferred_bytes() so no need to maintain this counter and
remember to always update it.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 migration/migration-stats.h | 14 --------------
 migration/migration-stats.c |  6 ------
 migration/multifd.c         |  1 -
 migration/qemu-file.c       |  4 ----
 4 files changed, 25 deletions(-)

diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index f1465c2ebe..9568b5b473 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -89,10 +89,6 @@ typedef struct {
      * Maximum amount of data we can send in a cycle.
      */
     Stat64 rate_limit_max;
-    /*
-     * Amount of data we have sent in the current cycle.
-     */
-    Stat64 rate_limit_used;
     /*
      * How long has the setup stage took.
      */
@@ -119,16 +115,6 @@ extern MigrationAtomicStats mig_stats;
  */
 void migration_time_since(MigrationAtomicStats *stats, int64_t since);
 
-/**
- * migration_rate_account: Increase the number of bytes transferred.
- *
- * Report on a number of bytes the have been transferred that need to
- * be applied to the rate limiting calcuations.
- *
- * @len: amount of bytes transferred
- */
-void migration_rate_account(uint64_t len);
-
 /**
  * migration_rate_get: Get the maximum amount that can be transferred.
  *
diff --git a/migration/migration-stats.c b/migration/migration-stats.c
index da2bb69a15..abf2d38b18 100644
--- a/migration/migration-stats.c
+++ b/migration/migration-stats.c
@@ -62,15 +62,9 @@ void migration_rate_set(uint64_t limit)
 
 void migration_rate_reset(QEMUFile *f)
 {
-    stat64_set(&mig_stats.rate_limit_used, 0);
     stat64_set(&mig_stats.rate_limit_start, migration_transferred_bytes(f));
 }
 
-void migration_rate_account(uint64_t len)
-{
-    stat64_add(&mig_stats.rate_limit_used, len);
-}
-
 uint64_t migration_transferred_bytes(QEMUFile *f)
 {
     uint64_t multifd = stat64_get(&mig_stats.multifd_bytes);
diff --git a/migration/multifd.c b/migration/multifd.c
index 5052091ce2..aabf9b6d98 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -431,7 +431,6 @@ static int multifd_send_pages(QEMUFile *f)
     multifd_send_state->pages = p->pages;
     p->pages = pages;
     transferred = ((uint64_t) pages->num) * p->page_size + p->packet_len;
-    migration_rate_account(transferred);
     qemu_mutex_unlock(&p->mutex);
     stat64_add(&mig_stats.transferred, transferred);
     stat64_add(&mig_stats.multifd_bytes, transferred);
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 9c67b52fe0..acc282654a 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -292,7 +292,6 @@ void qemu_fflush(QEMUFile *f)
             qemu_file_set_error_obj(f, -EIO, local_error);
         } else {
             uint64_t size = iov_size(f->iov, f->iovcnt);
-            migration_rate_account(size);
             f->total_transferred += size;
         }
 
@@ -344,9 +343,6 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
     if (f->hooks && f->hooks->save_page) {
         int ret = f->hooks->save_page(f, block_offset,
                                       offset, size, bytes_sent);
-        if (ret != RAM_SAVE_CONTROL_NOT_SUPP) {
-            migration_rate_account(size);
-        }
 
         if (ret != RAM_SAVE_CONTROL_DELAYED &&
             ret != RAM_SAVE_CONTROL_NOT_SUPP) {
-- 
2.40.1


