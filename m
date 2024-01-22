Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AB4837251
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 20:19:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRzo8-0007mt-LT; Mon, 22 Jan 2024 14:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rRzo5-0007mC-Ae
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 14:18:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rRzo3-0004aX-Iy
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 14:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705951082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t9fP3udE/oO9hrVEqgrqd+KM9rljgAhtgpCS+D2GXSE=;
 b=iOUzvFPzSENViJXNr1MwFVws15OhQx8OFTsJhpIFlCLPxzZohaSyorbMTTObLi/7v1SJ9X
 2bGLH2AXNcnHC/5cotUHtbnYqrPPJdxsCJlr2NtBzSU8wCGFYsGKRa07Z2JLQbMPYz0zFh
 XAZZ0ZgqQP9EeCgIBHPL8MU/e2Fdsmw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-3C_eGwsdOA2BkWUUox0Kbw-1; Mon, 22 Jan 2024 14:17:59 -0500
X-MC-Unique: 3C_eGwsdOA2BkWUUox0Kbw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07D1385A589;
 Mon, 22 Jan 2024 19:17:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3929A492BC6;
 Mon, 22 Jan 2024 19:17:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>,
	qemu-trivial@nongnu.org
Subject: [PATCH 1/5] util/uri: Remove the unused "target" argument from
 uri_string_unescape()
Date: Mon, 22 Jan 2024 20:17:49 +0100
Message-ID: <20240122191753.103118-2-thuth@redhat.com>
In-Reply-To: <20240122191753.103118-1-thuth@redhat.com>
References: <20240122191753.103118-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
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

All callers pass NULL as target, so we can simplify the code by
dropping this parameter.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/qemu/uri.h |  2 +-
 util/uri.c         | 32 ++++++++++++++------------------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/include/qemu/uri.h b/include/qemu/uri.h
index 1855b764f2..aa54b6f251 100644
--- a/include/qemu/uri.h
+++ b/include/qemu/uri.h
@@ -79,7 +79,7 @@ URI *uri_parse_raw(const char *str, int raw);
 int uri_parse_into(URI *uri, const char *str);
 char *uri_to_string(URI *uri);
 char *uri_string_escape(const char *str, const char *list);
-char *uri_string_unescape(const char *str, int len, char *target);
+char *uri_string_unescape(const char *str, int len);
 void uri_free(URI *uri);
 
 /* Single web service query parameter 'name=value'. */
diff --git a/util/uri.c b/util/uri.c
index dcb3305236..33b6c7214e 100644
--- a/util/uri.c
+++ b/util/uri.c
@@ -267,7 +267,7 @@ static int rfc3986_parse_fragment(URI *uri, const char **str)
         if (uri->cleanup & 2) {
             uri->fragment = g_strndup(*str, cur - *str);
         } else {
-            uri->fragment = uri_string_unescape(*str, cur - *str, NULL);
+            uri->fragment = uri_string_unescape(*str, cur - *str);
         }
     }
     *str = cur;
@@ -368,7 +368,7 @@ static int rfc3986_parse_user_info(URI *uri, const char **str)
             if (uri->cleanup & 2) {
                 uri->user = g_strndup(*str, cur - *str);
             } else {
-                uri->user = uri_string_unescape(*str, cur - *str, NULL);
+                uri->user = uri_string_unescape(*str, cur - *str);
             }
         }
         *str = cur;
@@ -496,7 +496,7 @@ found:
             if (uri->cleanup & 2) {
                 uri->server = g_strndup(host, cur - host);
             } else {
-                uri->server = uri_string_unescape(host, cur - host, NULL);
+                uri->server = uri_string_unescape(host, cur - host);
             }
         } else {
             uri->server = NULL;
@@ -614,7 +614,7 @@ static int rfc3986_parse_path_ab_empty(URI *uri, const char **str)
             if (uri->cleanup & 2) {
                 uri->path = g_strndup(*str, cur - *str);
             } else {
-                uri->path = uri_string_unescape(*str, cur - *str, NULL);
+                uri->path = uri_string_unescape(*str, cur - *str);
             }
         } else {
             uri->path = NULL;
@@ -663,7 +663,7 @@ static int rfc3986_parse_path_absolute(URI *uri, const char **str)
             if (uri->cleanup & 2) {
                 uri->path = g_strndup(*str, cur - *str);
             } else {
-                uri->path = uri_string_unescape(*str, cur - *str, NULL);
+                uri->path = uri_string_unescape(*str, cur - *str);
             }
         } else {
             uri->path = NULL;
@@ -709,7 +709,7 @@ static int rfc3986_parse_path_rootless(URI *uri, const char **str)
             if (uri->cleanup & 2) {
                 uri->path = g_strndup(*str, cur - *str);
             } else {
-                uri->path = uri_string_unescape(*str, cur - *str, NULL);
+                uri->path = uri_string_unescape(*str, cur - *str);
             }
         } else {
             uri->path = NULL;
@@ -755,7 +755,7 @@ static int rfc3986_parse_path_no_scheme(URI *uri, const char **str)
             if (uri->cleanup & 2) {
                 uri->path = g_strndup(*str, cur - *str);
             } else {
-                uri->path = uri_string_unescape(*str, cur - *str, NULL);
+                uri->path = uri_string_unescape(*str, cur - *str);
             }
         } else {
             uri->path = NULL;
@@ -1574,7 +1574,6 @@ static int is_hex(char c)
  * uri_string_unescape:
  * @str:  the string to unescape
  * @len:   the length in bytes to unescape (or <= 0 to indicate full string)
- * @target:  optional destination buffer
  *
  * Unescaping routine, but does not check that the string is an URI. The
  * output is a direct unsigned char translation of %XX values (no encoding)
@@ -1584,7 +1583,7 @@ static int is_hex(char c)
  * Returns a copy of the string, but unescaped, will return NULL only in case
  * of error
  */
-char *uri_string_unescape(const char *str, int len, char *target)
+char *uri_string_unescape(const char *str, int len)
 {
     char *ret, *out;
     const char *in;
@@ -1599,11 +1598,8 @@ char *uri_string_unescape(const char *str, int len, char *target)
         return NULL;
     }
 
-    if (target == NULL) {
-        ret = g_malloc(len + 1);
-    } else {
-        ret = target;
-    }
+    ret = g_malloc(len + 1);
+
     in = str;
     out = ret;
     while (len > 0) {
@@ -2274,14 +2270,14 @@ struct QueryParams *query_params_parse(const char *query)
          * and consistent with CGI.pm we assume value is "".
          */
         else if (!eq) {
-            name = uri_string_unescape(query, end - query, NULL);
+            name = uri_string_unescape(query, end - query);
             value = NULL;
         }
         /* Or if we have "name=" here (works around annoying
          * problem when calling uri_string_unescape with len = 0).
          */
         else if (eq + 1 == end) {
-            name = uri_string_unescape(query, eq - query, NULL);
+            name = uri_string_unescape(query, eq - query);
             value = g_new0(char, 1);
         }
         /* If the '=' character is at the beginning then we have
@@ -2293,8 +2289,8 @@ struct QueryParams *query_params_parse(const char *query)
 
         /* Otherwise it's "name=value". */
         else {
-            name = uri_string_unescape(query, eq - query, NULL);
-            value = uri_string_unescape(eq + 1, end - (eq + 1), NULL);
+            name = uri_string_unescape(query, eq - query);
+            value = uri_string_unescape(eq + 1, end - (eq + 1));
         }
 
         /* Append to the parameter set. */
-- 
2.43.0


