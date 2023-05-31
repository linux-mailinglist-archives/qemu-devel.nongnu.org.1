Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B171B718184
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:24:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LoO-0005w4-BQ; Wed, 31 May 2023 09:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4LoF-0005jt-7f
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4LoC-0004MG-9t
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685539451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=76mbrlJFbOf3a8izJ/pMLGPkL6i/wfEhVypqWzlKs4s=;
 b=BaNnyNzCC9xPuKMvuMEWI1Lb4u6I9Ti37SQFeGGNrd1CkfJuJnHyOCYGVYnn4W6uFJmMIW
 1XoBiN11Z+eJCX6jVlrHPcaOHUpFzmBAppbMVNzG/kXFe1T+gCEahq8NwMjszLLmk0WdMX
 oO5lj/IE7ln6ynVMl+cGyuf8A9kwXuM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-7UvaUmidOSOPdY3j0wgP9Q-1; Wed, 31 May 2023 09:24:08 -0400
X-MC-Unique: 7UvaUmidOSOPdY3j0wgP9Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7C8E811761
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:24:07 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC85B170ED;
 Wed, 31 May 2023 13:24:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 2/9] tests/qtest: add support for callback to receive QMP
 events
Date: Wed, 31 May 2023 14:23:53 +0100
Message-Id: <20230531132400.1129576-3-berrange@redhat.com>
In-Reply-To: <20230531132400.1129576-1-berrange@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

Currently code must call one of the qtest_qmp_event* functions to
fetch events. These are only usable if the immediate caller knows
the particular event they want to capture, and are only interested
in one specific event type. Adding ability to register an event
callback lets the caller capture a range of events over any period
of time.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/libqtest.c | 20 ++++++++++++++++++--
 tests/qtest/libqtest.h | 37 +++++++++++++++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 603c26d955..1534177fc1 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -82,6 +82,8 @@ struct QTestState
     GString *rx;
     QTestTransportOps ops;
     GList *pending_events;
+    QTestQMPEventCallback eventCB;
+    void *eventData;
 };
 
 static GHookList abrt_hooks;
@@ -703,8 +705,14 @@ QDict *qtest_qmp_receive(QTestState *s)
         if (!qdict_get_try_str(response, "event")) {
             return response;
         }
-        /* Stash the event for a later consumption */
-        s->pending_events = g_list_append(s->pending_events, response);
+
+        if (s->eventCB) {
+            s->eventCB(s, qdict_get_str(response, "event"),
+                       response, s->eventData);
+        } else {
+            /* Stash the event for a later consumption */
+            s->pending_events = g_list_append(s->pending_events, response);
+        }
     }
 }
 
@@ -808,6 +816,14 @@ void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
     va_end(ap);
 }
 
+void qtest_qmp_set_event_callback(QTestState *s,
+                                  QTestQMPEventCallback cb, void *opaque)
+{
+    s->eventCB = cb;
+    s->eventData = opaque;
+}
+
+
 QDict *qtest_qmp_event_ref(QTestState *s, const char *event)
 {
     while (s->pending_events) {
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 41bc6633bd..67ec4db43e 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -238,17 +238,46 @@ QDict *qtest_qmp_receive_dict(QTestState *s);
  * @s: #QTestState instance to operate on.
  *
  * Reads a QMP message from QEMU and returns the response.
- * Buffers all the events received meanwhile, until a
- * call to qtest_qmp_eventwait
+ *
+ * If a callback is registered with qtest_qmp_set_event_callback,
+ * it will be invoked for every event seen, otherwise events
+ * will be buffered until a call to one of the qtest_qmp_eventwait
+ * family of functions.
  */
 QDict *qtest_qmp_receive(QTestState *s);
 
+/*
+ * QTestQMPEventCallback:
+ * @s: #QTestState instance event was received on
+ * @name: name of the event type
+ * @event: #QDict for the event details
+ * @opaque: opaque data from time of callback registration
+ *
+ * This callback will be invoked whenever an event is received
+ */
+typedef bool (*QTestQMPEventCallback)(QTestState *s, const char *name,
+                                      QDict *event, void *opaque);
+
+/**
+ * qtest_qmp_set_event_callback:
+ * @s: #QTestSTate instance to operate on
+ * @cb: callback to invoke for events
+ * @opaque: data to pass to @cb
+ *
+ * Register a callback to be invoked whenever an event arrives
+ */
+void qtest_qmp_set_event_callback(QTestState *s,
+                                  QTestQMPEventCallback cb, void *opaque);
+
 /**
  * qtest_qmp_eventwait:
  * @s: #QTestState instance to operate on.
  * @event: event to wait for.
  *
  * Continuously polls for QMP responses until it receives the desired event.
+ *
+ * Any callback registered with qtest_qmp_set_event_callback will
+ * be invoked for every event seen.
  */
 void qtest_qmp_eventwait(QTestState *s, const char *event);
 
@@ -258,6 +287,10 @@ void qtest_qmp_eventwait(QTestState *s, const char *event);
  * @event: event to wait for.
  *
  * Continuously polls for QMP responses until it receives the desired event.
+ *
+ * Any callback registered with qtest_qmp_set_event_callback will
+ * be invoked for every event seen.
+ *
  * Returns a copy of the event for further investigation.
  */
 QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event);
-- 
2.40.1


