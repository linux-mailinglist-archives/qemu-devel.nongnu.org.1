Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 322B1748949
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 18:32:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH5Pt-0007DI-1u; Wed, 05 Jul 2023 12:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH5Pr-0007Cg-50
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:31:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH5Pp-00031f-8A
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688574700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RiGJvmAjJgDhh+5Hyb+zEN0NsPKDhwAESazt+bfQzMs=;
 b=RUxqolEeKCIJs4IBXlrY1cftMSbUIa0cruNKWa185iikK5CI6fkAYb17d7ea4LT9yKRGw/
 +lcUYSKJUuHpXBcCJKy4WMZaqPgsU0nogHs24rQsZtBY8Hw7+a/J8QxSudCqnJeAIWtyFW
 quAOI3MY7vOC1pJe4Q9dA0Huc4su5pU=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-Z5bnAFQfNveEcFjoaLfLWQ-1; Wed, 05 Jul 2023 12:31:38 -0400
X-MC-Unique: Z5bnAFQfNveEcFjoaLfLWQ-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-79499607027so141413241.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 09:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688574697; x=1691166697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RiGJvmAjJgDhh+5Hyb+zEN0NsPKDhwAESazt+bfQzMs=;
 b=VrFkNYV0qviTyIf89TVkqzbY/FE5bkWdjVlFugxD72J974yphbthNqZv8oIVbooPxs
 9cGI0sR963E55xMbsIUpAiHfuuHQhq+XSi60GPvCsII1iUcg+7cstnTvfI4lxLvchvxw
 SCoaBFem4EUeSMIhc7LgxWDUYSYzrQG9oyN0HPQlxlAFinz5b2UWQj4CmE3TvMmR/wl7
 lxovU4DXg1O99ebVsLiCo90ODEJPcugUP7kgqje5tXGKi+JOwiKg75YdfH4jNidbxHfq
 2O0xrWIVRN5wnveQoTadGrkjibMXZToWNLZYLcWQjDUM5MXYjsMLUzIMXkdtqfyIvL3R
 JGgg==
X-Gm-Message-State: ABy/qLYOGuRKEbFWUXtK3kBFYEgQuO6M+4GDLX8uXsobuS1aACKRlWOw
 rfdumEqD+wEpSZQrmN2WUXsdQ31+l4L++jTGmGVdeS/bNMGhlXD6ba6WPiGnJAkdCueB8ZVUZXC
 ibw09cxKTc0pdOfPV3uspDXHgpkBTCTr1sy5kfUEl58v4hQq4rOxLOOW4zpVJC3UsjMkDzRnp
X-Received: by 2002:a05:6102:3c95:b0:443:62fe:6f3b with SMTP id
 c21-20020a0561023c9500b0044362fe6f3bmr7179193vsv.0.1688574697555; 
 Wed, 05 Jul 2023 09:31:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFo5KznRzv/aD4yhIUk9gdYNwXWp+b05jaawIgHW/x88ZrHXgW+cWJjhaIAdvsc04L6nqsSrw==
X-Received: by 2002:a05:6102:3c95:b0:443:62fe:6f3b with SMTP id
 c21-20020a0561023c9500b0044362fe6f3bmr7179156vsv.0.1688574697120; 
 Wed, 05 Jul 2023 09:31:37 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 oj2-20020a056214440200b00631fc149a19sm3003159qvb.110.2023.07.05.09.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 09:31:36 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>,
 peterx@redhat.com, Avihai Horon <avihaih@nvidia.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 2/2] qtest/migration: Use switchover-hold to speedup
Date: Wed,  5 Jul 2023 12:31:32 -0400
Message-ID: <20230705163132.329501-3-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705163132.329501-1-peterx@redhat.com>
References: <20230705163132.329501-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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


