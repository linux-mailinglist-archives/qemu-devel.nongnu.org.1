Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D315274877F
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:09:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH47X-0004CW-Is; Wed, 05 Jul 2023 11:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH47V-0004CN-8X
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:08:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH47S-00009w-Di
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688569716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RiGJvmAjJgDhh+5Hyb+zEN0NsPKDhwAESazt+bfQzMs=;
 b=aq8/LAjrvtR3f8YH2k0poAWTqzwWhIxuIVx5xDjwG4lhuO9oWt4sC7EzsHF2+nkJ5hI1hG
 zISpyw7ez/DEkAQO02W47jvu7G7QCR86/91FtpK8U0dPgJotPpULwi6CeiTPgCXADL9oZ+
 fN97Ww/jvfMGGsdWMplrHJi0dLF0IOw=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-g8LIyIaPM3mNWCsOW4PYDw-1; Wed, 05 Jul 2023 11:08:35 -0400
X-MC-Unique: g8LIyIaPM3mNWCsOW4PYDw-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3a1ed0e9b5dso814077b6e.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688569710; x=1691161710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RiGJvmAjJgDhh+5Hyb+zEN0NsPKDhwAESazt+bfQzMs=;
 b=E8R3RlMTqk/lrek+XSwQjM9r6j3gbCBjwLmRMUCmVdS/juh3kFecQxQfwZyLImyDcS
 NkWe1Lr0SBYFkwrDQUZQS57HfQcGY7anZcacOWYRpzKFNTEpSG9KXjpS1Lg4zc8LtDLz
 e+9xPU0RVwBZzXrymxCEPWXoWK2n5MGx7jzzwM0ntp7ziahBQ1q/Q7S3m9DJFdiPfgC9
 wUf9ZA2UEGOUUKvSF+GMVS/a8XM9kA9VFY0hf4U3RXuKb7jQwW7F8Ki0O1TuaHozsr8p
 o+xAkOjQYUx+UN9oJGRahb2Wdld5hgee+c9Uej36/UnCFtYaS0jU80PfXpH1j31TG2Aq
 +i+w==
X-Gm-Message-State: ABy/qLY5eGtCJnqKzW0inlBbqsVVvXxLO1sQeqXimnu4FaY+hhcv46/e
 xKsELAdyEWMku/MwHESOXuqVpk53PQZ60t83aDmPwMd7Loena19A/WMQrFSzicIggdrTUqmGKES
 mHFTR2Fd4Ho8b2OwKGTOFo9FYg+5dqEyiU6HF8RWR07ji+6xV+wnqpJ1VK57Xqr+DLHJulcft
X-Received: by 2002:a05:6358:9f99:b0:132:fd8a:6b with SMTP id
 fy25-20020a0563589f9900b00132fd8a006bmr6490465rwb.1.1688569710125; 
 Wed, 05 Jul 2023 08:08:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEbWSIqY0YbDGxZ7sGJeCeIHw2i5tVTJs41ClVVJjL5OR44EH+fpSiGPZUS3SdkKCUnQSxvPw==
X-Received: by 2002:a05:6358:9f99:b0:132:fd8a:6b with SMTP id
 fy25-20020a0563589f9900b00132fd8a006bmr6490427rwb.1.1688569709643; 
 Wed, 05 Jul 2023 08:08:29 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 bs9-20020ac86f09000000b00400c5f5e713sm11826952qtb.97.2023.07.05.08.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 08:08:29 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v3 2/2] qtest/migration: Use switchover-hold to speedup
Date: Wed,  5 Jul 2023 11:08:24 -0400
Message-ID: <20230705150825.305076-3-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705150825.305076-1-peterx@redhat.com>
References: <20230705150825.305076-1-peterx@redhat.com>
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


