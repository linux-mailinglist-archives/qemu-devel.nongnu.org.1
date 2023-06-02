Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE64371F7A1
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 03:17:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4tPY-0004wC-3U; Thu, 01 Jun 2023 21:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4tPS-0004t0-Sy
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 21:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4tPE-0004aV-CL
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 21:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685668598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIo5OtYDpneOq4iOVikPjWn4PZGIfasZYoWfPJ3RI3Q=;
 b=CAz5ndbYpkNBi5ZyLOdZF3r3NgqrXKSc21nUxlN2Sr/32rwh+8p4Av//xL51xRy90jY15T
 SXQ45CdWgaxk6TY+LMs5GdUsdwewIqKAaThQBOXi6Itk9X+LlZWkjV5NP5YUbhyz2QJbpX
 rMAVJ7HEPrBzgs4em04vKPffWM8IJhc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-AX5DFAmGMsaHMVvKN4EGWQ-1; Thu, 01 Jun 2023 21:16:37 -0400
X-MC-Unique: AX5DFAmGMsaHMVvKN4EGWQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-62849c5e9f0so901716d6.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 18:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685668596; x=1688260596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TIo5OtYDpneOq4iOVikPjWn4PZGIfasZYoWfPJ3RI3Q=;
 b=GpmRCrXBsmEyKaMsCwJ7Aj8thY48IKRUbDMHMRbxIfvYoZ2uWhKXCaCHTJhFqgQAZE
 tU33ctJKrXRTgrsiq5lpfzGh+gDnABQ38a/MMvk3C2XoNd8E7TkXB0CKPjsxlwyAUVX0
 Em4RgGpRDVxyj9IL0nucIUuhoZIgSyrieUK3+XNfHIPEsbYeTOksLwhV9fATIfW108NR
 x9vR754pz7TTgwrbgmEuATiK/GA90tSZMFywMkpWziUkkb/Hroa60i2XDlTxBFZfImSn
 ddB9jfVktsXixhCf903r11zR29Tj93tvUtZZJ2tf5/2sf+KKV5nN8hJOKHLEP5b8hWlB
 OVoA==
X-Gm-Message-State: AC+VfDzeCILvLkYj7cZmEqu+GPCw11HUEPeCvADyEwXKOTvCOUYElMWN
 ZeJkQZHd/LKtNWyFenZHFwAvPlRyQie+zPwcyYnamdmsCzfGQb3aJAoSba0m4u5ARwXRfegBwH1
 s5B4zHMFNXQDrZ/56eVukBQXRGmWAivp1bkfBURgR5j3dBo2JOzXyqdVCyUQ+9Eo8za6S46bo
X-Received: by 2002:a05:6214:2aa1:b0:628:7923:b3e1 with SMTP id
 js1-20020a0562142aa100b006287923b3e1mr1408492qvb.2.1685668596599; 
 Thu, 01 Jun 2023 18:16:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6pWYfPULq+IGgsXOT0w1hcb6nr+JAsjz2qvokKcgmY1tLIOGzUwpoBNo/9SSuUmXTuFap2sQ==
X-Received: by 2002:a05:6214:2aa1:b0:628:7923:b3e1 with SMTP id
 js1-20020a0562142aa100b006287923b3e1mr1408461qvb.2.1685668596254; 
 Thu, 01 Jun 2023 18:16:36 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 l20-20020ad44454000000b006261e6a88c7sm170462qvt.36.2023.06.01.18.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 18:16:35 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>, peterx@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH RFC 3/3] qtest/migration: Use switchover-hold to speedup
Date: Thu,  1 Jun 2023 21:16:26 -0400
Message-Id: <20230602011626.226640-4-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602011626.226640-1-peterx@redhat.com>
References: <20230602011626.226640-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Use the switchover-hold flag rather than tuning bw+downtime to guide test
convergence.

This can achieve similar goal of previous patch "tests/qtest: massively
speed up migration-test" but without magic offset to write or monitoring.

The initial solution can reduce migration-test time from 8min to 1min40s,
this patch can further reduce it from 1m40s to 1m1s per my local test.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b0c355bbd9..62bdd67fd9 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -433,16 +433,15 @@ static void migrate_set_parameter_bool(QTestState *who, const char *parameter,
 
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
+    /* No limitation on bandwidth so converge faster */
+    migrate_set_parameter_int(who, "max-bandwidth", 0);
+    migrate_set_parameter_bool(who, "switchover-hold", false);
 }
 
 static void migrate_pause(QTestState *who)
@@ -492,6 +491,13 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
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
@@ -1164,6 +1170,8 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     }
 
     migrate_ensure_non_converge(from);
+    /* Still use unlimited precopy speed to finish 1st iteration fast */
+    migrate_set_parameter_int(from, "max-bandwidth", 0);
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
-- 
2.40.1


