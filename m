Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77ECF83724F
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 20:19:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRzoD-0007om-3i; Mon, 22 Jan 2024 14:18:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rRzo9-0007ni-Gl
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 14:18:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rRzo8-0004bQ-3i
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 14:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705951087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZVLlyvvK0pnrEV3DqxPychZcONHvpW8sC6DVHW2XoiA=;
 b=EdTl4UOaDrHEbuUKQWPo2UnbZI84ibW/I+18CzHLjFTM8WMXyMSK+DfGFoYUthO5FjOaAa
 9yN63A4hbUccYfox+AjyniQdx59BqYC+kMH8cPtQsSnO6Z1N9JrHCJI5iEj7yWWT5BUpir
 Pnx8kUor3vyttyb5fyIuFdEBBK4K20A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-JbKouV-_Puedcbx8qKh2JQ-1; Mon,
 22 Jan 2024 14:18:01 -0500
X-MC-Unique: JbKouV-_Puedcbx8qKh2JQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9786F3869141;
 Mon, 22 Jan 2024 19:18:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19D6D492BC6;
 Mon, 22 Jan 2024 19:17:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>,
	qemu-trivial@nongnu.org
Subject: [PATCH 3/5] util/uri: Remove the uri_string_escape() function
Date: Mon, 22 Jan 2024 20:17:51 +0100
Message-ID: <20240122191753.103118-4-thuth@redhat.com>
In-Reply-To: <20240122191753.103118-1-thuth@redhat.com>
References: <20240122191753.103118-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

It is not used in QEMU - and if somebody needs this functionality,
they can simply use g_uri_escape_string() from the glib instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/qemu/uri.h |  1 -
 util/uri.c         | 64 ----------------------------------------------
 2 files changed, 65 deletions(-)

diff --git a/include/qemu/uri.h b/include/qemu/uri.h
index aa54b6f251..c1734d28c3 100644
--- a/include/qemu/uri.h
+++ b/include/qemu/uri.h
@@ -78,7 +78,6 @@ URI *uri_parse(const char *str);
 URI *uri_parse_raw(const char *str, int raw);
 int uri_parse_into(URI *uri, const char *str);
 char *uri_to_string(URI *uri);
-char *uri_string_escape(const char *str, const char *list);
 char *uri_string_unescape(const char *str, int len);
 void uri_free(URI *uri);
 
diff --git a/util/uri.c b/util/uri.c
index 2a75f535ba..912e406523 100644
--- a/util/uri.c
+++ b/util/uri.c
@@ -1589,70 +1589,6 @@ char *uri_string_unescape(const char *str, int len)
     return g_uri_unescape_string(lstr, NULL);
 }
 
-/**
- * uri_string_escape:
- * @str:  string to escape
- * @list: exception list string of chars not to escape
- *
- * This routine escapes a string to hex, ignoring reserved characters (a-z)
- * and the characters in the exception list.
- *
- * Returns a new escaped string or NULL in case of error.
- */
-char *uri_string_escape(const char *str, const char *list)
-{
-    char *ret, ch;
-    char *temp;
-    const char *in;
-    int len, out;
-
-    if (str == NULL) {
-        return NULL;
-    }
-    if (str[0] == 0) {
-        return g_strdup(str);
-    }
-    len = strlen(str);
-    if (!(len > 0)) {
-        return NULL;
-    }
-
-    len += 20;
-    ret = g_malloc(len);
-    in = str;
-    out = 0;
-    while (*in != 0) {
-        if (len - out <= 3) {
-            temp = realloc2n(ret, &len);
-            ret = temp;
-        }
-
-        ch = *in;
-
-        if ((ch != '@') && (!IS_UNRESERVED(ch)) && (!strchr(list, ch))) {
-            unsigned char val;
-            ret[out++] = '%';
-            val = ch >> 4;
-            if (val <= 9) {
-                ret[out++] = '0' + val;
-            } else {
-                ret[out++] = 'A' + val - 0xA;
-            }
-            val = ch & 0xF;
-            if (val <= 9) {
-                ret[out++] = '0' + val;
-            } else {
-                ret[out++] = 'A' + val - 0xA;
-            }
-            in++;
-        } else {
-            ret[out++] = *in++;
-        }
-    }
-    ret[out] = 0;
-    return ret;
-}
-
 /************************************************************************
  *                                                                      *
  *                           Public functions                           *
-- 
2.43.0


