Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B19679437E
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 21:03:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdxmq-0006C1-6n; Wed, 06 Sep 2023 15:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qdxmm-0006BM-5A
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 15:01:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qdxmj-0008A4-Gf
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 15:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694026913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/5Q+q6yNqAxBk6g6i9jyTzPE/hWWcqQrxs+KLHIhU8E=;
 b=ax5EJdDe1MPsmkCD7YpiXYnFm3vVOQIA0nWgFGCGy149f6U2vVNte6LYFd86hSaBX+gSBA
 gpjwlFOm7dxfRetqiJJt8HxRQ9ZECHk6rkasXmP1FngqmsJm7Q4GDxG3hCdCB0TtrdWNlt
 2gcWik6rn13rgK59GPimlwgrBdMcXks=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-iwzTqUN_NG2GJF4aKSkC1g-1; Wed, 06 Sep 2023 15:01:49 -0400
X-MC-Unique: iwzTqUN_NG2GJF4aKSkC1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3296A1C07557;
 Wed,  6 Sep 2023 19:01:49 +0000 (UTC)
Received: from localhost (unknown [10.39.193.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF352202869C;
 Wed,  6 Sep 2023 19:01:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>, pbonzini@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 kwolf@redhat.com, Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC 3/3] qmp: make qmp_device_add() a coroutine
Date: Wed,  6 Sep 2023 15:01:41 -0400
Message-ID: <20230906190141.1286893-4-stefanha@redhat.com>
In-Reply-To: <20230906190141.1286893-1-stefanha@redhat.com>
References: <20230906190141.1286893-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

It is not safe to call drain_call_rcu() from qmp_device_add() because
some call stacks are not prepared for drain_call_rcu() to drop the Big
QEMU Lock (BQL).

For example, device emulation code is protected by the BQL but when it
calls aio_poll() -> ... -> qmp_device_add() -> drain_call_rcu() then the
BQL is dropped. See bz#2215192 below for a concrete bug of this type.

Another limitation of drain_call_rcu() is that it cannot be invoked
within an RCU read-side critical section since the reclamation phase
cannot complete until the end of the critical section. Unfortunately,
call stacks have been seen where this happens (see bz#2214985 below).

Switch to call_drain_rcu_co() to avoid these problems. This requires
making qmp_device_add() a coroutine. qdev_device_add() is not designed
to be called from coroutines, so it must be invoked from a BH and then
switch back to the coroutine.

Fixes: 7bed89958bfbf40df9ca681cefbdca63abdde39d ("device_core: use drain_call_rcu in in qmp_device_add")
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2215192
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2214985
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qapi/qdev.json         |  1 +
 include/monitor/qdev.h |  3 ++-
 monitor/qmp-cmds.c     |  2 +-
 softmmu/qdev-monitor.c | 34 ++++++++++++++++++++++++++++++----
 hmp-commands.hx        |  1 +
 5 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/qapi/qdev.json b/qapi/qdev.json
index 6bc5a733b8..78e9d7f7b8 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -79,6 +79,7 @@
 ##
 { 'command': 'device_add',
   'data': {'driver': 'str', '*bus': 'str', '*id': 'str'},
+  'coroutine': true,
   'gen': false, # so we can get the additional arguments
   'features': ['json-cli', 'json-cli-hotplug'] }
 
diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
index 1d57bf6577..1fed9eb9ea 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -5,7 +5,8 @@
 
 void hmp_info_qtree(Monitor *mon, const QDict *qdict);
 void hmp_info_qdm(Monitor *mon, const QDict *qdict);
-void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp);
+void coroutine_fn
+qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp);
 
 int qdev_device_help(QemuOpts *opts);
 DeviceState *qdev_device_add(QemuOpts *opts, Error **errp);
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index b0f948d337..a7419226fe 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -202,7 +202,7 @@ static void __attribute__((__constructor__)) monitor_init_qmp_commands(void)
     qmp_init_marshal(&qmp_commands);
 
     qmp_register_command(&qmp_commands, "device_add",
-                         qmp_device_add, 0, 0);
+                         qmp_device_add, QCO_COROUTINE, 0);
 
     QTAILQ_INIT(&qmp_cap_negotiation_commands);
     qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilities",
diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
index 74f4e41338..85ae62f7cf 100644
--- a/softmmu/qdev-monitor.c
+++ b/softmmu/qdev-monitor.c
@@ -839,8 +839,28 @@ void hmp_info_qdm(Monitor *mon, const QDict *qdict)
     qdev_print_devinfos(true);
 }
 
-void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
+typedef struct {
+    Coroutine *co;
+    QemuOpts *opts;
+    Error **errp;
+    DeviceState *dev;
+} QmpDeviceAdd;
+
+static void qmp_device_add_bh(void *opaque)
 {
+    QmpDeviceAdd *data = opaque;
+
+    data->dev = qdev_device_add(data->opts, data->errp);
+    aio_co_wake(data->co);
+}
+
+void coroutine_fn
+qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
+{
+    QmpDeviceAdd data = {
+        .co = qemu_coroutine_self(),
+        .errp = errp,
+    };
     QemuOpts *opts;
     DeviceState *dev;
 
@@ -852,7 +872,13 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
         qemu_opts_del(opts);
         return;
     }
-    dev = qdev_device_add(opts, errp);
+
+    /* Perform qdev_device_add() call outside coroutine context */
+    data.opts = opts;
+    aio_bh_schedule_oneshot(qemu_coroutine_get_aio_context(data.co),
+                            qmp_device_add_bh, &data);
+    qemu_coroutine_yield();
+    dev = data.dev;
 
     /*
      * Drain all pending RCU callbacks. This is done because
@@ -863,7 +889,7 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
      * will finish its job completely once qmp command returns result
      * to the user
      */
-    drain_call_rcu();
+    drain_call_rcu_co();
 
     if (!dev) {
         qemu_opts_del(opts);
@@ -956,7 +982,7 @@ void qmp_device_del(const char *id, Error **errp)
     }
 }
 
-void hmp_device_add(Monitor *mon, const QDict *qdict)
+void coroutine_fn hmp_device_add(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
 
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 2cbd0f77a0..c737d1fd64 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -695,6 +695,7 @@ ERST
         .params     = "driver[,prop=value][,...]",
         .help       = "add device, like -device on the command line",
         .cmd        = hmp_device_add,
+        .coroutine  = true,
         .command_completion = device_add_completion,
     },
 
-- 
2.41.0


