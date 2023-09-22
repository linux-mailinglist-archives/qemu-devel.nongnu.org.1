Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 129017AB627
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 18:38:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjjAJ-0003fi-NP; Fri, 22 Sep 2023 12:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qjjA5-0003ee-6Y
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:37:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qjjA3-0005Yw-KQ
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695400666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8gd4cFIAWYh1CW4d+sE2sq/Yo8GMCugx0KOzDYlYGDg=;
 b=cyn6xbgyhvdQbRY2t19IW/kTWUCBSq+HBpOMB/5j/6u8df9sIIU8FPvk6UPVhKERRD+JAN
 Pn2lrfZqDvPqYjo4QA+Amk0B587siWzaD4D+Llm8f1oD6miaN5Zjt0e5cVw/tQX2y9Imlq
 RwXYUPKF1A5j4tem2KF5YJ2EqYVB56M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-dFbKnOuqPc-hFJpCPp55mg-1; Fri, 22 Sep 2023 12:37:44 -0400
X-MC-Unique: dFbKnOuqPc-hFJpCPp55mg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F140D3C13928;
 Fri, 22 Sep 2023 16:37:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D87822904;
 Fri, 22 Sep 2023 16:37:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/qtest/m48t59-test: Silence compiler warning with
 -Wshadow
Date: Fri, 22 Sep 2023 18:37:42 +0200
Message-ID: <20230922163742.149444-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When compiling this file with -Wshadow=local , we get:

../tests/qtest/m48t59-test.c: In function ‘bcd_check_time’:
../tests/qtest/m48t59-test.c:195:17: warning: declaration of ‘s’
 shadows a previous local [-Wshadow=local]
  195 |         long t, s;
      |                 ^
../tests/qtest/m48t59-test.c:158:17: note: shadowed declaration is here
  158 |     QTestState *s = m48t59_qtest_start();
      |                 ^

Rename the QTestState variable to "qts" which is the common
naming for such a variable in other tests.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/m48t59-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/m48t59-test.c b/tests/qtest/m48t59-test.c
index 843d2ced8e..9487faff1a 100644
--- a/tests/qtest/m48t59-test.c
+++ b/tests/qtest/m48t59-test.c
@@ -155,7 +155,7 @@ static void bcd_check_time(void)
     struct tm *datep;
     time_t ts;
     const int wiggle = 2;
-    QTestState *s = m48t59_qtest_start();
+    QTestState *qts = m48t59_qtest_start();
 
     /*
      * This check assumes a few things.  First, we cannot guarantee that we get
@@ -173,10 +173,10 @@ static void bcd_check_time(void)
     ts = time(NULL);
     gmtime_r(&ts, &start);
 
-    cmos_get_date_time(s, &date[0]);
-    cmos_get_date_time(s, &date[1]);
-    cmos_get_date_time(s, &date[2]);
-    cmos_get_date_time(s, &date[3]);
+    cmos_get_date_time(qts, &date[0]);
+    cmos_get_date_time(qts, &date[1]);
+    cmos_get_date_time(qts, &date[2]);
+    cmos_get_date_time(qts, &date[3]);
 
     ts = time(NULL);
     gmtime_r(&ts, &end);
@@ -207,7 +207,7 @@ static void bcd_check_time(void)
         g_assert_cmpint(ABS(t - s), <=, wiggle);
     }
 
-    qtest_quit(s);
+    qtest_quit(qts);
 }
 
 /* success if no crash or abort */
-- 
2.41.0


