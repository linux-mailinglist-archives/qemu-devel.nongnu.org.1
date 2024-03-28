Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D3489013F
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Mar 2024 15:09:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpqPI-0004QE-Gt; Thu, 28 Mar 2024 10:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpqPG-0004PG-TT
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:07:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpqPF-0004Ux-3g
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711634820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cCwYOxuAMURGRsU5bRxLMi3E7NhrtJUM6uZAb1E4Gl8=;
 b=XIQgAiZJ1OvAAD/5UM/nnMMHyw3JjEvdeh4JHzS7jN+qvYEhMyLgu6AbkjtNjhBS61F/c+
 GY10Qoy3c+IC33neyCLHRVnavOOuIsfRYIZl2h9NbF51mxRBh3sb0yZONn+SCkNFJDUXrZ
 79+rrpyqgb5QCFkHlzb3Be0rMwkRul8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-LYJl8jhLMVKmfm5-baMsTw-1; Thu,
 28 Mar 2024 10:06:54 -0400
X-MC-Unique: LYJl8jhLMVKmfm5-baMsTw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7814428B6BAD;
 Thu, 28 Mar 2024 14:06:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3623040C6CB8;
 Thu, 28 Mar 2024 14:06:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH for-9.1 6/9] block/nbd: Use URI parsing code from glib
Date: Thu, 28 Mar 2024 15:06:03 +0100
Message-ID: <20240328140607.2433889-7-thuth@redhat.com>
In-Reply-To: <20240328140607.2433889-1-thuth@redhat.com>
References: <20240328140607.2433889-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since version 2.66, glib has useful URI parsing functions, too.
Use those instead of the QEMU-internal ones to be finally able
to get rid of the latter. The g_uri_get_host() also takes care
of removing the square brackets from IPv6 addresses, so we can
drop that part of the QEMU code now, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 block/nbd.c | 66 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index ef05f7cdfd..95b507f872 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -31,7 +31,6 @@
 #include "qemu/osdep.h"
 
 #include "trace.h"
-#include "qemu/uri.h"
 #include "qemu/option.h"
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
@@ -1514,30 +1513,34 @@ static void nbd_client_close(BlockDriverState *bs)
 
 static int nbd_parse_uri(const char *filename, QDict *options)
 {
-    URI *uri;
+    GUri *uri;
     const char *p;
-    QueryParams *qp = NULL;
+    GHashTable *qp = NULL;
+    int qp_n;
     int ret = 0;
     bool is_unix;
+    const char *uri_scheme, *uri_query, *uri_server;
+    int uri_port;
 
-    uri = uri_parse(filename);
+    uri = g_uri_parse(filename, G_URI_FLAGS_NONE, NULL);
     if (!uri) {
         return -EINVAL;
     }
 
     /* transport */
-    if (!g_strcmp0(uri->scheme, "nbd")) {
+    uri_scheme = g_uri_get_scheme(uri);
+    if (!g_strcmp0(uri_scheme, "nbd")) {
         is_unix = false;
-    } else if (!g_strcmp0(uri->scheme, "nbd+tcp")) {
+    } else if (!g_strcmp0(uri_scheme, "nbd+tcp")) {
         is_unix = false;
-    } else if (!g_strcmp0(uri->scheme, "nbd+unix")) {
+    } else if (!g_strcmp0(uri_scheme, "nbd+unix")) {
         is_unix = true;
     } else {
         ret = -EINVAL;
         goto out;
     }
 
-    p = uri->path ? uri->path : "";
+    p = g_uri_get_path(uri) ?: "";
     if (p[0] == '/') {
         p++;
     }
@@ -1545,51 +1548,58 @@ static int nbd_parse_uri(const char *filename, QDict *options)
         qdict_put_str(options, "export", p);
     }
 
-    qp = query_params_parse(uri->query);
-    if (qp->n > 1 || (is_unix && !qp->n) || (!is_unix && qp->n)) {
-        ret = -EINVAL;
-        goto out;
+    uri_query = g_uri_get_query(uri);
+    if (uri_query) {
+        qp = g_uri_parse_params(uri_query, -1, "&", G_URI_PARAMS_NONE, NULL);
+        if (!qp) {
+            ret = -EINVAL;
+            goto out;
+        }
+        qp_n = g_hash_table_size(qp);
+        if (qp_n > 1 || (is_unix && !qp_n) || (!is_unix && qp_n)) {
+            ret = -EINVAL;
+            goto out;
+        }
+     }
+
+    uri_server = g_uri_get_host(uri);
+    if (uri_server && !uri_server[0]) {
+        uri_server = NULL;
     }
+    uri_port = g_uri_get_port(uri);
 
     if (is_unix) {
         /* nbd+unix:///export?socket=path */
-        if (uri->server || uri->port || strcmp(qp->p[0].name, "socket")) {
+        const char *uri_socket = g_hash_table_lookup(qp, "socket");
+        if (uri_server || uri_port != -1 || !uri_socket) {
             ret = -EINVAL;
             goto out;
         }
         qdict_put_str(options, "server.type", "unix");
-        qdict_put_str(options, "server.path", qp->p[0].value);
+        qdict_put_str(options, "server.path", uri_socket);
     } else {
-        QString *host;
         char *port_str;
 
         /* nbd[+tcp]://host[:port]/export */
-        if (!uri->server) {
+        if (!uri_server) {
             ret = -EINVAL;
             goto out;
         }
 
-        /* strip braces from literal IPv6 address */
-        if (uri->server[0] == '[') {
-            host = qstring_from_substr(uri->server, 1,
-                                       strlen(uri->server) - 1);
-        } else {
-            host = qstring_from_str(uri->server);
-        }
-
         qdict_put_str(options, "server.type", "inet");
-        qdict_put(options, "server.host", host);
+        qdict_put_str(options, "server.host", uri_server);
 
-        port_str = g_strdup_printf("%d", uri->port ?: NBD_DEFAULT_PORT);
+        port_str = g_strdup_printf("%d", uri_port != -1 ? uri_port
+                                                        : NBD_DEFAULT_PORT);
         qdict_put_str(options, "server.port", port_str);
         g_free(port_str);
     }
 
 out:
     if (qp) {
-        query_params_free(qp);
+        g_hash_table_destroy(qp);
     }
-    uri_free(uri);
+    g_uri_unref(uri);
     return ret;
 }
 
-- 
2.44.0


