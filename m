Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 714CC749C3D
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 14:44:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHOKk-00031A-ED; Thu, 06 Jul 2023 08:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHOKi-00030l-M3
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 08:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHOKg-0004T7-Rd
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 08:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688647417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RiGJvmAjJgDhh+5Hyb+zEN0NsPKDhwAESazt+bfQzMs=;
 b=Ep28P1HRE68L/b9/pfP8gc/j2S7fqF2WcOouQTqgiMDIaCw+oCukTqCMwK5cgKx9b4MZQg
 VszGvBl7mmXbYd68yrIrw14+aI4YbuOVqHLtz2DnHJh6aA9kExkjfQkvuZJM9PQOvdFRqc
 vpj2jss43t7/qgqtZ0cUQK3E2hvx2dM=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-eq1I6gH5NMClJ-JO0C7dAw-1; Thu, 06 Jul 2023 08:43:36 -0400
X-MC-Unique: eq1I6gH5NMClJ-JO0C7dAw-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-78f229d2217so21858241.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 05:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688647416; x=1691239416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RiGJvmAjJgDhh+5Hyb+zEN0NsPKDhwAESazt+bfQzMs=;
 b=JgNoDgS1ESditItcabxQP/jwgstF69zTEaxAoljS48c8dPATiLb9IWaY72pmh1bUc8
 BkoVkc/NBXgBTNDRHtRT2rz5PgsxJI7ikq9pReDFXs6UPYfFPjHW4HQou3cZK0cIfSQb
 ZhIXOUPMQ098VXgJZ8Kd0rr0NuhWDMlV7YwN176hC/sBhs/nbetzuq0F185L/aTKBQr0
 Fy+QgZxEUqu3N3mhV5EXVoZ/oVsskIcdSoAvdUBiYmjEfWlR0o2gTJsNS5myISx35VSs
 Nt9kG9Ao02A+vaxtVl5DXORF3/rDT7Zmt+Aj7nkdTQJKdDCBJQGyzfC0yvPG0lf1fq4j
 qeCA==
X-Gm-Message-State: ABy/qLYFT1x06L9qKQAHT3hwpzOru0mFObVQv5ckLAhgwYOaU7hJ5OUG
 CZwsy3WzgOOFW5wbvV4szjFBlNV/VQfbxDwaEJM/fpYctcUXNOHlk9mrX/for3oLYFT8/wuA1+r
 cYWSj54gyp+sO71ehhtyJPi7V/fz4BgsuQ/zVi8RQcjedJqp43/WjcyFOYWUkn5orPB5o85e3
X-Received: by 2002:a05:6122:98c:b0:471:6e5c:dddd with SMTP id
 g12-20020a056122098c00b004716e5cddddmr943067vkd.0.1688647416246; 
 Thu, 06 Jul 2023 05:43:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlErclCTxpx246s4PPD78RMjctbejivSctqFmzThdLf35YyylyViefr8slTvdAx6GxS18PNxdQ==
X-Received: by 2002:a05:6122:98c:b0:471:6e5c:dddd with SMTP id
 g12-20020a056122098c00b004716e5cddddmr943044vkd.0.1688647415813; 
 Thu, 06 Jul 2023 05:43:35 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a0ce44d000000b006301d3cab9csm832816qvm.27.2023.07.06.05.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 05:43:35 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 peterx@redhat.com, Avihai Horon <avihaih@nvidia.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v5 2/2] qtest/migration: Use switchover-hold to speedup
Date: Thu,  6 Jul 2023 08:43:31 -0400
Message-ID: <20230706124331.377939-3-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706124331.377939-1-peterx@redhat.com>
References: <20230706124331.377939-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This solution is heavily based on Daniel's original approach here, but
hopefully a cleaner way to impl:

https://lore.kernel.org/r/20230601161347.1803440-11-berrange@redhat.com

The difference is we use the switchover-hold flag rather than tuning
bw+downtime to guide test convergence, comparing to use the magic offset.

This can achieve similar goal of previous patch "tests/qtest: massively
speed up migration-test" but without magic offset to write or monitoring.

With this flag, we can safely always run migration tests with full
speed (bw=0).

However for postcopy tests, when with above bw=0, it's easy to happen that
right after switching to postcopy there're merely no page left, so the
postcopy paths are not well tested.

To remedy that, don't wait for a full iteration but switch to postcopy in
the 1st iteration, adding a precopy bw limit (200MB/s for now, running
100ms) so it should guarantee enough pages left for postcopy.

One pity is that normally postcopy switchover happens after 1-2 rounds of
precopy, so qtest doesn't follow that anymore (while it was trying to).
However it also means previous postcopy tests never tested the case where
there're holes in pages (pages that never got migrated during precopy), now
we cover that too which is actually also a valid scenario for postcopy.

The initial solution can reduce migration-test time from 8min to 1min40s,
this patch can further reduce it from 1m40s to <1m per my local test.

While at it, add migrate_set_bandwidth_[pre|post]copy() and use them.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 39 +++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b9cc194100..d5584d07a9 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -433,16 +433,23 @@ static void migrate_set_parameter_bool(QTestState *who, const char *parameter,
 
 static void migrate_ensure_non_converge(QTestState *who)
 {
-    /* Can't converge with 1ms downtime + 3 mbs bandwidth limit */
-    migrate_set_parameter_int(who, "max-bandwidth", 3 * 1000 * 1000);
-    migrate_set_parameter_int(who, "downtime-limit", 1);
+    /* Hold off switchover for precopy only */
+    migrate_set_parameter_bool(who, "switchover-hold", true);
 }
 
 static void migrate_ensure_converge(QTestState *who)
 {
-    /* Should converge with 30s downtime + 1 gbs bandwidth limit */
-    migrate_set_parameter_int(who, "max-bandwidth", 1 * 1000 * 1000 * 1000);
-    migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
+    migrate_set_parameter_bool(who, "switchover-hold", false);
+}
+
+static void migrate_set_bandwidth_precopy(QTestState *who, int bw)
+{
+    migrate_set_parameter_int(who, "max-bandwidth", bw);
+}
+
+static void migrate_set_bandwidth_postcopy(QTestState *who, int bw)
+{
+    migrate_set_parameter_int(who, "max-postcopy-bandwidth", bw);
 }
 
 static void migrate_pause(QTestState *who)
@@ -736,6 +743,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         unlink(shmem_path);
     }
 
+    /*
+     * By default, use full speed for precopy in qtests as that will reduce
+     * the time of testing. The default bandwidth (128MB/s) may be too slow
+     * in this case.  Specific test can overwrite this value after the
+     * function returns but before starting migration.
+     */
+    migrate_set_bandwidth_precopy(*from, 0);
+
     return 0;
 }
 
@@ -1168,9 +1183,13 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
+    /*
+     * Limit precopy to 200MB/s for 0.1 sec, so we guarantee to leave
+     * enough pages (total-20MB) for remote page fault processes later.
+     */
+    migrate_set_bandwidth_precopy(from, 200 * 1024 * 1024);
     migrate_qmp(from, uri, "{}");
-
-    wait_for_migration_pass(from);
+    usleep(100000);
 
     *from_ptr = from;
     *to_ptr = to;
@@ -1270,7 +1289,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
     }
 
     /* Turn postcopy speed down, 4K/s is slow enough on any machines */
-    migrate_set_parameter_int(from, "max-postcopy-bandwidth", 4096);
+    migrate_set_bandwidth_postcopy(from, 4096);
 
     /* Now we start the postcopy */
     migrate_postcopy_start(from, to);
@@ -1314,7 +1333,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
     migrate_qmp(from, uri, "{'resume': true}");
 
     /* Restore the postcopy bandwidth to unlimited */
-    migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
+    migrate_set_bandwidth_postcopy(from, 0);
 
     migrate_postcopy_complete(from, to, args);
 }
-- 
2.41.0


