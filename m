Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D047AD410
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 11:03:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkhTG-0002F5-Fv; Mon, 25 Sep 2023 05:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qkhSo-000259-JJ
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 05:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qkhSm-0002a6-Fx
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 05:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695632467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f564zeEwTP2NCJ75yge0S7XrtEHt1dbx2+S/usTLRFA=;
 b=gyn5lizE/vC46KmzvFW2x3Sk0TqRg7EBcZBd/AzN7hGR5y+HFXtWpjYMPazEkiiB4SHmG2
 boIgZmNxYhIdst8Mu434I2omVQdpAo+HeZi7XEv0MB4E2tOmcZAZKUBqTh4fHp4+T93AYv
 k5hS+hgx2X2GKT1IccyZs7f2zPbIRkA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-OOukDnTNMx65NHjz9N9iOw-1; Mon, 25 Sep 2023 05:01:05 -0400
X-MC-Unique: OOukDnTNMx65NHjz9N9iOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16C55802C1A
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 09:01:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7768B140E953;
 Mon, 25 Sep 2023 09:01:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 3/7] tests/qtest/m48t59-test: Silence compiler warning with
 -Wshadow
Date: Mon, 25 Sep 2023 11:00:56 +0200
Message-ID: <20230925090100.45632-4-thuth@redhat.com>
In-Reply-To: <20230925090100.45632-1-thuth@redhat.com>
References: <20230925090100.45632-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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
Message-ID: <20230922163742.149444-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
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


