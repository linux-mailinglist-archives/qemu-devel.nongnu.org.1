Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FDD819BA1
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 10:45:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFt5L-0002dU-LF; Wed, 20 Dec 2023 04:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt5I-0002cD-PA
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt5G-0005ma-QD
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703065305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fOezic+4a4G8/jLzzBID0XtNuQEaVSe3eEqMwsMTevk=;
 b=hiVWmcrDoXguVrQeI/6QDP3F7iyjxWhxNfMI4rriSGPw2vgiy5HeNt3pCayxCrnGikejjY
 Gmpgrn4RbX0+mDg6JmLbi4p6jDXXhrtGODaEGw0KzEn66bGY4uvJjho+fAdvRXSivO/ZSL
 BUf5TRD1TRnlGOqlfvf3N0WejwHdKt8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-ditq4pkIOgag_C9NYxOI4Q-1; Wed,
 20 Dec 2023 04:41:41 -0500
X-MC-Unique: ditq4pkIOgag_C9NYxOI4Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8BF72825E8B;
 Wed, 20 Dec 2023 09:41:41 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B1362166B31;
 Wed, 20 Dec 2023 09:41:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 17/19] tests/unit/test-qmp-event: Drop superfluous mutex
Date: Wed, 20 Dec 2023 10:41:03 +0100
Message-ID: <20231220094105.6588-18-thuth@redhat.com>
In-Reply-To: <20231220094105.6588-1-thuth@redhat.com>
References: <20231220094105.6588-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Markus Armbruster <armbru@redhat.com>

Mutex @test_event_lock is held from fixture setup to teardown,
protecting global variable @test_event_data.  But tests always run one
after the other, so this is superfluous.  It also confuses Coverity.
Drop the mutex.

Fixes: CID 1527425
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20231122072456.2518816-2-armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-qmp-event.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/unit/test-qmp-event.c b/tests/unit/test-qmp-event.c
index 3626d2372f..c2c44687d5 100644
--- a/tests/unit/test-qmp-event.c
+++ b/tests/unit/test-qmp-event.c
@@ -30,7 +30,6 @@ typedef struct TestEventData {
 } TestEventData;
 
 TestEventData *test_event_data;
-static GMutex test_event_lock;
 
 void test_qapi_event_emit(test_QAPIEvent event, QDict *d)
 {
@@ -59,9 +58,6 @@ void test_qapi_event_emit(test_QAPIEvent event, QDict *d)
 static void event_prepare(TestEventData *data,
                           const void *unused)
 {
-    /* Global variable test_event_data was used to pass the expectation, so
-       test cases can't be executed at same time. */
-    g_mutex_lock(&test_event_lock);
     test_event_data = data;
 }
 
@@ -69,7 +65,6 @@ static void event_teardown(TestEventData *data,
                            const void *unused)
 {
     test_event_data = NULL;
-    g_mutex_unlock(&test_event_lock);
 }
 
 static void event_test_add(const char *testpath,
-- 
2.43.0


