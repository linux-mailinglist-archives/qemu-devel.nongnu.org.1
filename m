Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A63A7204D5
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 16:49:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q564f-0001U5-Ot; Fri, 02 Jun 2023 10:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q564B-0001SK-3c
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q563w-0007DK-0U
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685717244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kMdkM8DlJxB5gVSR4oLUsTL3Q1tgfUeDUK8gLFfMf88=;
 b=KNGxuJDLuhYn2F8oGlELydUHgRXvOqF1Hm3Qcb51U8SRcLg7cW7eZaXDjUJ2nAzjPEHTp/
 sjulYmWdy/kqmldMTqnp28aZoyHWPcS8jAcQca9A1zkpNaMuzS//aDRl4zn8piNsq/B6fk
 kXMT3BiXFh1KiogkutemFAe85dmSV+4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-gaJnqRjjMGqp4KCo8XgnBA-1; Fri, 02 Jun 2023 10:47:23 -0400
X-MC-Unique: gaJnqRjjMGqp4KCo8XgnBA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-75b1224f63aso24471485a.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 07:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685717242; x=1688309242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kMdkM8DlJxB5gVSR4oLUsTL3Q1tgfUeDUK8gLFfMf88=;
 b=OdMH2gVGd9rV5Z3PcwvS4RKgiK36dVRvPrDI+44P4a+c/dkj+gk1osaZSmtNRioZQG
 7hFeatDnj3/SfkK3VE2693YN02ME/WcLoRJ+B02Hz69C6K5S8NUBsbinu7O2mlrxzVM6
 k02pdsmAvWuOMZkl8LHkpbKBAFTuHU2wa5ZctIjiWZepH8ISu2O00nS+otff/09nTlWP
 V5rpUNHOJ5/lEBylaEp6Z3j0OHcSDHjDIIIvpyl+o3F6DEnWsm4GDBG3T8DQWEas2qP1
 L1LcT9cLtl6FyJ5t+DyTWr1v0oCUN3YzZHGS7PD/REeGTsg85oslI0G8rkum1jYHkVX1
 lSTA==
X-Gm-Message-State: AC+VfDxgddWlT1OnLCVnljykdtI8d7iBi65DDPjrCGOISWtigWe/0Z+M
 t9dWz0lFO1Yzz7eF85qTeoE8qfR8PcsGoM4sFfhpziDCZlW2rqAk3l3bFdtWgpLpk5YheUhGmWw
 jTMSkHa6TrZBqtkrSKyJfT6UNeb2Xbx+2053xuPZtLNd8uQ3sE47VFIc3YKIkAGpULWzU2W6e
X-Received: by 2002:a05:620a:4395:b0:75b:23a1:1de3 with SMTP id
 a21-20020a05620a439500b0075b23a11de3mr12046378qkp.0.1685717242338; 
 Fri, 02 Jun 2023 07:47:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5EYEtXcJu+xGAGgMA4QGDbEQ2mSujj7HxobFuN4aEprRko70WmVMxfQdLMRruYKRtLN5taFA==
X-Received: by 2002:a05:620a:4395:b0:75b:23a1:1de3 with SMTP id
 a21-20020a05620a439500b0075b23a11de3mr12046348qkp.0.1685717241976; 
 Fri, 02 Jun 2023 07:47:21 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 l8-20020ae9f008000000b0075b00e52e3asm698419qkg.70.2023.06.02.07.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 07:47:20 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>
Subject: [PATCH 2/2] qtest/migration: Use switchover-hold to speedup
Date: Fri,  2 Jun 2023 10:47:15 -0400
Message-Id: <20230602144715.249002-3-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602144715.249002-1-peterx@redhat.com>
References: <20230602144715.249002-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
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

This solution is heavily based on Daniel's original approach here, but
hopefully a cleaner way to impl:

https://lore.kernel.org/r/20230601161347.1803440-11-berrange@redhat.com

The difference is we use the switchover-hold flag rather than tuning
bw+downtime to guide test convergence, comparing to use the magic offset.

One thing needs caution is the postcopy test - we used to only make it
non-converge for precopy.  Now we need the paired migrate_ensure_converge()
to make sure postcopy can still complete or otherwise the flag will stops
the final switchover from postcopy->finish.

This can achieve similar goal of previous patch "tests/qtest: massively
speed up migration-test" but without magic offset to write or monitoring.

With this flag, we can safely always run migration tests with full
speed (bw=0).

The initial solution can reduce migration-test time from 8min to 1min40s,
this patch can further reduce it from 1m40s to ~1m per my local test.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b0c355bbd9..3a583238e1 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -433,16 +433,13 @@ static void migrate_set_parameter_bool(QTestState *who, const char *parameter,
 
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
 }
 
 static void migrate_pause(QTestState *who)
@@ -492,6 +489,13 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
     }
 
     qtest_qmp_eventwait(to, "RESUME");
+
+    /*
+     * Now allow precopy switchover (which will allow completion).  This
+     * needs to be done after migrate-start-postcopy to make sure we switch
+     * to postcopy first.
+     */
+    migrate_ensure_converge(from);
 }
 
 typedef struct {
@@ -736,6 +740,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         unlink(shmem_path);
     }
 
+    /*
+     * By default, use full speed for precopy in qtests as that will reduce
+     * the time of testing. The default bandwidth (128MB/s) may be too slow
+     * in this case.  Specific test can overwrite this value after the
+     * function returns but before starting migration.
+     */
+    migrate_set_parameter_int(*from, "max-bandwidth", 0);
+
     return 0;
 }
 
-- 
2.40.1


