Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FC2B51FBD
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Sep 2025 20:07:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwPBr-0008LM-Hu; Wed, 10 Sep 2025 14:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwPBm-0008I1-PV
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwPBk-0004kn-A9
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757527499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6KBbFO7LRmS7uXQcAahtGaA/mkmtl6dsOkZZBLrYkYc=;
 b=R5+OGUaLkBSFa/gMpVZqQ3EAmbkqZXTqWfXZywKdJmh1phVIx3e4ndI+CB/lymNOEXi/Gi
 F3oGUfBLp/+qZO+vLCImsXMKFTXxYZtaqEWB7FGAJF9/HHdyymSqOxw6elTwomwrq3kptX
 YBXaQmZ0xVP0ZuPISG3dlzyN5i4J3RU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-gjT0pskJP12qgr_I9j3aRg-1; Wed,
 10 Sep 2025 14:04:56 -0400
X-MC-Unique: gjT0pskJP12qgr_I9j3aRg-1
X-Mimecast-MFC-AGG-ID: gjT0pskJP12qgr_I9j3aRg_1757527494
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4B041956094; Wed, 10 Sep 2025 18:04:54 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF5E61800447; Wed, 10 Sep 2025 18:04:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 12/20] monitor: introduce monitor_cur_hmp() function
Date: Wed, 10 Sep 2025 19:03:49 +0100
Message-ID: <20250910180357.320297-13-berrange@redhat.com>
In-Reply-To: <20250910180357.320297-1-berrange@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A number of callers use monitor_cur() followed by !monitor_cur_is_qmp().

This is undesirable because monitor_cur_is_qmp() will itself call
monitor_cur() again, and monitor_cur() must acquire locks and do
hash table lookups. Introducing a monitor_cur_hmp() helper will
combine the two operations into one reducing cost.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/monitor/monitor.h      |  1 +
 monitor/monitor.c              | 14 ++++++++++++++
 stubs/monitor-core.c           |  5 +++++
 tests/unit/test-util-sockets.c |  1 +
 4 files changed, 21 insertions(+)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 296690e1f1..c3b79b960a 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -14,6 +14,7 @@ typedef struct MonitorOptions MonitorOptions;
 extern QemuOptsList qemu_mon_opts;
 
 Monitor *monitor_cur(void);
+Monitor *monitor_cur_hmp(void);
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon);
 bool monitor_cur_is_qmp(void);
 
diff --git a/monitor/monitor.c b/monitor/monitor.c
index e1e5dbfcbe..cff502c53e 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -84,6 +84,20 @@ Monitor *monitor_cur(void)
     return mon;
 }
 
+Monitor *monitor_cur_hmp(void)
+{
+    Monitor *mon;
+
+    qemu_mutex_lock(&monitor_lock);
+    mon = g_hash_table_lookup(coroutine_mon, qemu_coroutine_self());
+    if (mon && monitor_is_qmp(mon)) {
+        mon = NULL;
+    }
+    qemu_mutex_unlock(&monitor_lock);
+
+    return mon;
+}
+
 /**
  * Sets a new current monitor and returns the old one.
  *
diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
index b498a0f1af..1e0b11ec29 100644
--- a/stubs/monitor-core.c
+++ b/stubs/monitor-core.c
@@ -7,6 +7,11 @@ Monitor *monitor_cur(void)
     return NULL;
 }
 
+Monitor *monitor_cur_hmp(void)
+{
+    return NULL;
+}
+
 bool monitor_cur_is_qmp(void)
 {
     return false;
diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index bd48731ea2..d40813c682 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -72,6 +72,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
  * otherwise we get duplicate syms at link time.
  */
 Monitor *monitor_cur(void) { return cur_mon; }
+Monitor *monitor_cur_hmp(void) { return cur_mon; }
 bool monitor_cur_is_qmp(void) { return false; }
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }
-- 
2.50.1


