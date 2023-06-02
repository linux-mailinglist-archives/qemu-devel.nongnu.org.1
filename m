Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F20E271FFB9
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 12:51:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q52Ll-0007Bt-A1; Fri, 02 Jun 2023 06:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q52Ld-0007AT-AP
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 06:49:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q52Lb-0002LA-Qc
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 06:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685702971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7rXct9ZNHaBf2cKArt69BLunHQKbSQakIi+0cGHoEes=;
 b=imJQhDodJ48Yyx255AAFJBEJegtestXREQJa5E/n2FIreW/TDE6i8bkvIJbkXeSr7oW+MN
 abDulGvsfJGKEYCQ16UGyZ4hLQG/usj+J+MgA62qfiMbOXgPzEiGmtuDpSnk13FTKCG6ts
 f84zi/IwTLE64CkowkcIuhwZzFeFZtM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-9qiSQ8PfPXGfSLBFjerwNQ-1; Fri, 02 Jun 2023 06:49:29 -0400
X-MC-Unique: 9qiSQ8PfPXGfSLBFjerwNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 876C58032F5
 for <qemu-devel@nongnu.org>; Fri,  2 Jun 2023 10:49:29 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BA0E40CFD01;
 Fri,  2 Jun 2023 10:49:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 10/10] qtest/migration: Document live=true cases
Date: Fri,  2 Jun 2023 12:49:10 +0200
Message-Id: <20230602104910.35157-11-quintela@redhat.com>
In-Reply-To: <20230602104910.35157-1-quintela@redhat.com>
References: <20230602104910.35157-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

From: Peter Xu <peterx@redhat.com>

Document every single live=true use cases on why it should be done in the
live manner.  Also document on the parameter so new precopy cases should
always use live=off unless with explicit reasonings.

Cc: Thomas Huth <thuth@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20230601172935.175726-1-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 37 ++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 0b9d045152..b0c355bbd9 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -580,7 +580,14 @@ typedef struct {
     /* Optional: set number of migration passes to wait for, if live==true */
     unsigned int iterations;
 
-    /* Optional: whether the guest CPUs should be running during migration */
+    /*
+     * Optional: whether the guest CPUs should be running during a precopy
+     * migration test.  We used to always run with live but it took much
+     * longer so we reduced live tests to only the ones that have solid
+     * reason to be tested live-only.  For each of the new test cases for
+     * precopy please provide justifications to use live explicitly (please
+     * refer to existing ones with live=true), or use live=off by default.
+     */
     bool live;
 
     /* Postcopy specific fields */
@@ -1491,7 +1498,10 @@ static void test_precopy_unix_plain(void)
     MigrateCommon args = {
         .listen_uri = uri,
         .connect_uri = uri,
-
+        /*
+         * The simplest use case of precopy, covering smoke tests of
+         * get-dirty-log dirty tracking.
+         */
         .live = true,
     };
 
@@ -1508,7 +1518,10 @@ static void test_precopy_unix_dirty_ring(void)
         },
         .listen_uri = uri,
         .connect_uri = uri,
-
+        /*
+         * Besides the precopy/unix basic test, cover dirty ring interface
+         * rather than get-dirty-log.
+         */
         .live = true,
     };
 
@@ -1617,10 +1630,12 @@ static void test_precopy_unix_xbzrle(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = uri,
-
         .start_hook = test_migrate_xbzrle_start,
-
         .iterations = 2,
+        /*
+         * XBZRLE needs pages to be modified when doing the 2nd+ round
+         * iteration to have real data pushed to the stream.
+         */
         .live = true,
     };
 
@@ -1639,6 +1654,11 @@ static void test_precopy_unix_compress(void)
          * the previous iteration.
          */
         .iterations = 2,
+        /*
+         * We make sure the compressor can always work well even if guest
+         * memory is changing.  See commit 34ab9e9743 where we used to fix
+         * a bug when only trigger-able with guest memory changing.
+         */
         .live = true,
     };
 
@@ -1657,6 +1677,7 @@ static void test_precopy_unix_compress_nowait(void)
          * the previous iteration.
          */
         .iterations = 2,
+        /* Same reason for the wait version of precopy compress test */
         .live = true,
     };
 
@@ -2066,7 +2087,11 @@ static void test_multifd_tcp_none(void)
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = test_migrate_precopy_tcp_multifd_start,
-
+        /*
+         * Multifd is more complicated than most of the features, it
+         * directly takes guest page buffers when sending, make sure
+         * everything will work alright even if guest page is changing.
+         */
         .live = true,
     };
     test_precopy_common(&args);
-- 
2.40.1


