Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FA371F0CB
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 19:31:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4m7M-0007nt-1H; Thu, 01 Jun 2023 13:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4m7K-0007nf-5M
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 13:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4m7I-0000MD-JP
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 13:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685640580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IbVJADEN9aDU1N3KsMsI4qW8gvcFLQj55XrO9OXbanc=;
 b=drb1L8H6UIA38jjaDCDWBDs1vIu4D8ghXk/c0X8iyXNmqkEzL5B1q2k23tcSIrB/sG3/rL
 ujcviRbSiznP1uyDpmHGclJ3ZFIKaV4+ombM9PupTepickKfqeJGXtyjrkNsIybIKQa0U8
 ahpKwrUge4yURIhfEZZW5LdzYC0cZfk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-t9T-vMGCNHKqk246LqmJ3A-1; Thu, 01 Jun 2023 13:29:39 -0400
X-MC-Unique: t9T-vMGCNHKqk246LqmJ3A-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-3f6c58d57adso198181cf.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 10:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685640578; x=1688232578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IbVJADEN9aDU1N3KsMsI4qW8gvcFLQj55XrO9OXbanc=;
 b=WNIQnuh1k0llw1ocFKqpwcqTzRuLW2150KURhVyfksaT9eE95LJS6oPZOqJ93DE7fH
 pt5LYZTrVy8CqdNtuGZAKfMqUfJjxIP0wJo29wLKUGEoHU62W1uA5T2A9mLCTXjsaYOo
 wnSY2xUUP646wRY06J0j19AnV058D+ohfkW+pWiuYmp8Ulbgv98I5P01Zv1JBoYbs7I5
 l1Vot/RpMNz3qQFvn4mFnsVX7ekCtwLTp8wmk6dCbCpGg+mYY/4wYdy4ZJ9E/SCkvN7R
 EAMOT1ZNVNeXuqMXOL+FV+N7vB3HiaRSK2cj7mySqeVNq9jMN6OHIVlunTZ96FycpT8R
 Qjaw==
X-Gm-Message-State: AC+VfDx6J78OTQq3HUDe4h/W6DkxrfOlkBD7y+FnMREfIs46POMjCApM
 7b3847QIiPeOx3qdUk8wbcmtnAnmdXNxFwJB7PZoa6U2/GgKsxapQ4lup/GVd6M5gkZ4bEbpsEu
 Ov0en7FSNBRwgPSIkLuyzQYC6EkM5y5cRap8MRkhDy+dQMp6Qm1sBx/vfcQs6G2ZMNz5wTLbH
X-Received: by 2002:a05:622a:19a9:b0:3f5:16af:17d6 with SMTP id
 u41-20020a05622a19a900b003f516af17d6mr12295032qtc.3.1685640578123; 
 Thu, 01 Jun 2023 10:29:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5FiOo+W5maaGWN/gNK8nDa+FS0IPC1q9nWWXfVCBzBGyWWfYJwgBoXu1vRtlqEosMkYx2O/Q==
X-Received: by 2002:a05:622a:19a9:b0:3f5:16af:17d6 with SMTP id
 u41-20020a05622a19a900b003f516af17d6mr12295005qtc.3.1685640577802; 
 Thu, 01 Jun 2023 10:29:37 -0700 (PDT)
Received: from x1n.redhat.com
 (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
 by smtp.gmail.com with ESMTPSA id
 b22-20020ac844d6000000b003e3918f350dsm7819728qto.25.2023.06.01.10.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 10:29:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] qtest/migration: Document live=true cases
Date: Thu,  1 Jun 2023 13:29:35 -0400
Message-Id: <20230601172935.175726-1-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601161347.1803440-1-berrange@redhat.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Document every single live=true use cases on why it should be done in the
live manner.  Also document on the parameter so new precopy cases should
always use live=off unless with explicit reasonings.

Cc: Thomas Huth <thuth@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 37 ++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 298291f01c..d2cd71e6cf 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -682,7 +682,14 @@ typedef struct {
      */
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
@@ -1592,7 +1599,10 @@ static void test_precopy_unix_plain(void)
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
 
@@ -1609,7 +1619,10 @@ static void test_precopy_unix_dirty_ring(void)
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
 
@@ -1721,10 +1734,12 @@ static void test_precopy_unix_xbzrle(void)
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
 
@@ -1743,6 +1758,11 @@ static void test_precopy_unix_compress(void)
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
 
@@ -1761,6 +1781,7 @@ static void test_precopy_unix_compress_nowait(void)
          * the previous iteration.
          */
         .iterations = 2,
+        /* Same reason for the wait version of precopy compress test */
         .live = true,
     };
 
@@ -2170,7 +2191,11 @@ static void test_multifd_tcp_none(void)
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


