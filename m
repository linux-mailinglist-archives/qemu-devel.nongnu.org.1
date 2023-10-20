Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2AE7D0900
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 09:00:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtjTS-00039P-Fu; Fri, 20 Oct 2023 02:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtjTF-0002uo-KT
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 02:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtjTD-0003Zt-Gr
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 02:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697785135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTn9veGAxLAYJslyZIyZzW0sClB0zJRQrXIWfbzdZi4=;
 b=Wur4wpqeSEfsSfKYr1RlE83z29icBXTJku9AdqVYjprrmvwJudD8n57bLp+1ZjJC4yNhEU
 jRiph8R8suAn2jVB9S5xE7Qfh613GrYf1aFZ8lSyab69KWSl4S6V86rp1rlzBEz26LzhpB
 NvU1YMFsVAt2zwubZaIEPSWw0l2mxYI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-a7AaMWqrOZumdOKVwB96Vw-1; Fri, 20 Oct 2023 02:58:51 -0400
X-MC-Unique: a7AaMWqrOZumdOKVwB96Vw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5580010201E3;
 Fri, 20 Oct 2023 06:58:50 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9A5625C0;
 Fri, 20 Oct 2023 06:58:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, "Denis V. Lunev" <den@openvz.org>,
 Juan Quintela <quintela@redhat.com>, Fam Zheng <fam@euphon.net>,
 kvm@vger.kernel.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Kevin Wolf <kwolf@redhat.com>,
 David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>, qemu-arm@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jeff Cody <codyprime@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, qemu-block@nongnu.org
Subject: [PULL 07/17] tests/qtest: Introduce qtest_init_with_env
Date: Fri, 20 Oct 2023 08:57:41 +0200
Message-ID: <20231020065751.26047-8-quintela@redhat.com>
In-Reply-To: <20231020065751.26047-1-quintela@redhat.com>
References: <20231020065751.26047-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

From: Fabiano Rosas <farosas@suse.de>

Add a version of qtest_init() that takes an environment variable
containing the path of the QEMU binary. This allows tests to use more
than one QEMU binary.

If no variable is provided or the environment variable does not exist,
that is not an error. Fallback to using QTEST_QEMU_BINARY.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231018192741.25885-3-farosas@suse.de>
---
 tests/qtest/libqtest.h | 13 +++++++++++++
 tests/qtest/libqtest.c | 26 +++++++++++++++++++-------
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 5fe3d13466..76fc195f1c 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -55,6 +55,19 @@ QTestState *qtest_vinitf(const char *fmt, va_list ap) G_GNUC_PRINTF(1, 0);
  */
 QTestState *qtest_init(const char *extra_args);
 
+/**
+ * qtest_init_with_env:
+ * @var: Environment variable from where to take the QEMU binary
+ * @extra_args: Other arguments to pass to QEMU.  CAUTION: these
+ * arguments are subject to word splitting and shell evaluation.
+ *
+ * Like qtest_init(), but use a different environment variable for the
+ * QEMU binary.
+ *
+ * Returns: #QTestState instance.
+ */
+QTestState *qtest_init_with_env(const char *var, const char *extra_args);
+
 /**
  * qtest_init_without_qmp_handshake:
  * @extra_args: other arguments to pass to QEMU.  CAUTION: these
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 03fa644663..9eebba8767 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -388,7 +388,8 @@ static pid_t qtest_create_process(char *cmd)
 }
 #endif /* _WIN32 */
 
-static QTestState *G_GNUC_PRINTF(1, 2) qtest_spawn_qemu(const char *fmt, ...)
+static QTestState *G_GNUC_PRINTF(2, 3) qtest_spawn_qemu(const char *qemu_bin,
+                                                        const char *fmt, ...)
 {
     va_list ap;
     QTestState *s = g_new0(QTestState, 1);
@@ -398,8 +399,7 @@ static QTestState *G_GNUC_PRINTF(1, 2) qtest_spawn_qemu(const char *fmt, ...)
     g_autoptr(GString) command = g_string_new("");
 
     va_start(ap, fmt);
-    g_string_append_printf(command, CMD_EXEC "%s %s",
-                           qtest_qemu_binary(NULL), tracearg);
+    g_string_append_printf(command, CMD_EXEC "%s %s", qemu_bin, tracearg);
     g_string_append_vprintf(command, fmt, ap);
     va_end(ap);
 
@@ -438,7 +438,8 @@ static QTestState *G_GNUC_PRINTF(1, 2) qtest_spawn_qemu(const char *fmt, ...)
     return s;
 }
 
-QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
+static QTestState *qtest_init_internal(const char *qemu_bin,
+                                       const char *extra_args)
 {
     QTestState *s;
     int sock, qmpsock, i;
@@ -463,7 +464,8 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
     sock = init_socket(socket_path);
     qmpsock = init_socket(qmp_socket_path);
 
-    s = qtest_spawn_qemu("-qtest unix:%s "
+    s = qtest_spawn_qemu(qemu_bin,
+                         "-qtest unix:%s "
                          "-qtest-log %s "
                          "-chardev socket,path=%s,id=char0 "
                          "-mon chardev=char0,mode=control "
@@ -516,9 +518,14 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
     return s;
 }
 
-QTestState *qtest_init(const char *extra_args)
+QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
 {
-    QTestState *s = qtest_init_without_qmp_handshake(extra_args);
+    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args);
+}
+
+QTestState *qtest_init_with_env(const char *var, const char *extra_args)
+{
+    QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args);
     QDict *greeting;
 
     /* Read the QMP greeting and then do the handshake */
@@ -529,6 +536,11 @@ QTestState *qtest_init(const char *extra_args)
     return s;
 }
 
+QTestState *qtest_init(const char *extra_args)
+{
+    return qtest_init_with_env(NULL, extra_args);
+}
+
 QTestState *qtest_vinitf(const char *fmt, va_list ap)
 {
     char *args = g_strdup_vprintf(fmt, ap);
-- 
2.41.0


