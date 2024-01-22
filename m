Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A92D8837256
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 20:19:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRzoA-0007nq-Sp; Mon, 22 Jan 2024 14:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rRzo6-0007n3-LF
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 14:18:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rRzo4-0004ac-Bk
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 14:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705951083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jIkSqNRMyuKznBhUMTiNPQqqf4+AI4N11CZ5a/o0D14=;
 b=IHhyWQ8fnxTdO8oBn/WSnNyBMotj09dp6JYIg0qRcAsIlZnUFxmT+4R74cZnI7Fzqu6Klh
 uQhBPl/a8tXPa8iXNBXQF6fbhKdEESOa8WA2AsArct5Mec5gbhKOB9FY7aypcD7Piq1imr
 QSlLPkh0/HXZPB2UlkN7AcxYY4peSds=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-8RuuiGEDPdOJeSeRMyXiag-1; Mon, 22 Jan 2024 14:18:00 -0500
X-MC-Unique: 8RuuiGEDPdOJeSeRMyXiag-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCF23185A781;
 Mon, 22 Jan 2024 19:17:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86272492BC6;
 Mon, 22 Jan 2024 19:17:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>,
	qemu-trivial@nongnu.org
Subject: [PATCH 2/5] util/uri: Simplify uri_string_unescape()
Date: Mon, 22 Jan 2024 20:17:50 +0100
Message-ID: <20240122191753.103118-3-thuth@redhat.com>
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

uri_string_unescape() basically does the same as the glib function
g_uri_unescape_string(), with just an additional length parameter.
So we can simplify this function a lot by limiting the length with
g_strndup() first and then by calling g_uri_unescape_string() instead
of walking through the string manually.

Suggested-by: Stefan Weil <stefan.weil@weilnetz.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 util/uri.c | 49 +++----------------------------------------------
 1 file changed, 3 insertions(+), 46 deletions(-)

diff --git a/util/uri.c b/util/uri.c
index 33b6c7214e..2a75f535ba 100644
--- a/util/uri.c
+++ b/util/uri.c
@@ -1561,15 +1561,6 @@ done_cd:
     return 0;
 }
 
-static int is_hex(char c)
-{
-    if (((c >= '0') && (c <= '9')) || ((c >= 'a') && (c <= 'f')) ||
-        ((c >= 'A') && (c <= 'F'))) {
-        return 1;
-    }
-    return 0;
-}
-
 /**
  * uri_string_unescape:
  * @str:  the string to unescape
@@ -1585,8 +1576,7 @@ static int is_hex(char c)
  */
 char *uri_string_unescape(const char *str, int len)
 {
-    char *ret, *out;
-    const char *in;
+    g_autofree char *lstr = NULL;
 
     if (str == NULL) {
         return NULL;
@@ -1594,42 +1584,9 @@ char *uri_string_unescape(const char *str, int len)
     if (len <= 0) {
         len = strlen(str);
     }
-    if (len < 0) {
-        return NULL;
-    }
-
-    ret = g_malloc(len + 1);
+    lstr = g_strndup(str, len);
 
-    in = str;
-    out = ret;
-    while (len > 0) {
-        if ((len > 2) && (*in == '%') && (is_hex(in[1])) && (is_hex(in[2]))) {
-            in++;
-            if ((*in >= '0') && (*in <= '9')) {
-                *out = (*in - '0');
-            } else if ((*in >= 'a') && (*in <= 'f')) {
-                *out = (*in - 'a') + 10;
-            } else if ((*in >= 'A') && (*in <= 'F')) {
-                *out = (*in - 'A') + 10;
-            }
-            in++;
-            if ((*in >= '0') && (*in <= '9')) {
-                *out = *out * 16 + (*in - '0');
-            } else if ((*in >= 'a') && (*in <= 'f')) {
-                *out = *out * 16 + (*in - 'a') + 10;
-            } else if ((*in >= 'A') && (*in <= 'F')) {
-                *out = *out * 16 + (*in - 'A') + 10;
-            }
-            in++;
-            len -= 3;
-            out++;
-        } else {
-            *out++ = *in++;
-            len--;
-        }
-    }
-    *out = 0;
-    return ret;
+    return g_uri_unescape_string(lstr, NULL);
 }
 
 /**
-- 
2.43.0


