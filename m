Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 102C77F3EDC
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 08:26:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5hbh-0002qc-RD; Wed, 22 Nov 2023 02:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5hbe-0002pi-Hy
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:25:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5hbc-0000pR-NZ
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700637901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G6TnX9Kxvfwwi76JemoBX3SqpT8cHEynqAZXqVh+SQc=;
 b=amXkiQxXM5b4isIhwhHq76tnlS6RKcT6QXUYA6oop8Kus2ia0uEcl+oKcgfJrejYy+0UBo
 C2GCYnRGd89iRw239TbFxhPEfmmuOiWhdzW+qMGZkmuDX4C8n5ewEkPu3i0/P/jeUxrhmo
 xFmq4FeIN/NGeiy51NwWeg4SFqjpf7Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-R57YFIk9NxKxUkJQyWMP_A-1; Wed,
 22 Nov 2023 02:24:57 -0500
X-MC-Unique: R57YFIk9NxKxUkJQyWMP_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A26A51C0514C;
 Wed, 22 Nov 2023 07:24:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F9471121306;
 Wed, 22 Nov 2023 07:24:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 655D221E6A21; Wed, 22 Nov 2023 08:24:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com
Subject: [PATCH 1/3] tests/unit/test-qmp-event: Drop superfluous mutex
Date: Wed, 22 Nov 2023 08:24:54 +0100
Message-ID: <20231122072456.2518816-2-armbru@redhat.com>
In-Reply-To: <20231122072456.2518816-1-armbru@redhat.com>
References: <20231122072456.2518816-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Mutex @test_event_lock is held from fixture setup to teardown,
protecting global variable @test_event_data.  But tests always run one
after the other, so this is superfluous.  It also confuses Coverity.
Drop the mutex.

Fixes: CID 1527425
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
2.41.0


