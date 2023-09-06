Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AB579437D
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 21:03:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdxmm-0006BB-EY; Wed, 06 Sep 2023 15:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qdxmh-00069x-Ax
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 15:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qdxme-00087M-JY
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 15:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694026907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tUCOewx5Uk4Y3QQOUxCFtRBKpEhPDosHOt7NC6SB8DA=;
 b=L9rW+8iY6jTXxpUmXzeULf4psPz/+BmkvG2bLd3W/py8y/Zd4NKrCCDmRNbK2RZbNMLEx7
 R0OvlUzM9vgY4kWKx7GbUG3lltNT487DJTnJAFfsa5mWUAWjlx8j7ydcOibfGZWQiK9iYQ
 +ZIfShPMa4FnNiEB0zEo6WKecZH88ho=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-g3qDoFB3O2G6eete1x3mkg-1; Wed, 06 Sep 2023 15:01:46 -0400
X-MC-Unique: g3qDoFB3O2G6eete1x3mkg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8746D88DF61;
 Wed,  6 Sep 2023 19:01:45 +0000 (UTC)
Received: from localhost (unknown [10.39.193.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14B88493110;
 Wed,  6 Sep 2023 19:01:44 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>, pbonzini@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 kwolf@redhat.com, Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC 1/3] hmp: avoid the nested event loop in handle_hmp_command()
Date: Wed,  6 Sep 2023 15:01:39 -0400
Message-ID: <20230906190141.1286893-2-stefanha@redhat.com>
In-Reply-To: <20230906190141.1286893-1-stefanha@redhat.com>
References: <20230906190141.1286893-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Coroutine HMP commands currently run to completion in a nested event
loop with the Big QEMU Lock (BQL) held. The call_rcu thread also uses
the BQL and cannot process work while the coroutine monitor command is
running. A deadlock occurs when monitor commands attempt to wait for
call_rcu work to finish.

This patch refactors the HMP monitor to use the existing event loop
instead of creating a nested event loop. This will allow the next
patches to rely on draining call_rcu work.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 monitor/hmp.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 69c1b7e98a..6cff2810aa 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1111,15 +1111,17 @@ typedef struct HandleHmpCommandCo {
     Monitor *mon;
     const HMPCommand *cmd;
     QDict *qdict;
-    bool done;
 } HandleHmpCommandCo;
 
-static void handle_hmp_command_co(void *opaque)
+static void coroutine_fn handle_hmp_command_co(void *opaque)
 {
     HandleHmpCommandCo *data = opaque;
+
     handle_hmp_command_exec(data->mon, data->cmd, data->qdict);
     monitor_set_cur(qemu_coroutine_self(), NULL);
-    data->done = true;
+    qobject_unref(data->qdict);
+    monitor_resume(data->mon);
+    g_free(data);
 }
 
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
@@ -1157,20 +1159,20 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
         Monitor *old_mon = monitor_set_cur(qemu_coroutine_self(), &mon->common);
         handle_hmp_command_exec(&mon->common, cmd, qdict);
         monitor_set_cur(qemu_coroutine_self(), old_mon);
+        qobject_unref(qdict);
     } else {
-        HandleHmpCommandCo data = {
-            .mon = &mon->common,
-            .cmd = cmd,
-            .qdict = qdict,
-            .done = false,
-        };
-        Coroutine *co = qemu_coroutine_create(handle_hmp_command_co, &data);
+        HandleHmpCommandCo *data; /* freed by handle_hmp_command_co() */
+
+        data = g_new(HandleHmpCommandCo, 1);
+        data->mon = &mon->common;
+        data->cmd = cmd;
+        data->qdict = qdict; /* freed by handle_hmp_command_co() */
+
+        Coroutine *co = qemu_coroutine_create(handle_hmp_command_co, data);
+        monitor_suspend(&mon->common); /* resumed by handle_hmp_command_co() */
         monitor_set_cur(co, &mon->common);
         aio_co_enter(qemu_get_aio_context(), co);
-        AIO_WAIT_WHILE_UNLOCKED(NULL, !data.done);
     }
-
-    qobject_unref(qdict);
 }
 
 static void cmd_completion(MonitorHMP *mon, const char *name, const char *list)
-- 
2.41.0


