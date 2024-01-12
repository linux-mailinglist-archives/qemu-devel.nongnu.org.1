Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF8A82BAC1
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 06:18:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO9vg-0004Qh-3B; Fri, 12 Jan 2024 00:18:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rO9va-0004QF-Ip
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 00:17:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rO9vY-0003Eb-G5
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 00:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705036675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yhEpTAOIOGxwApEuyOerzPJ+/tZaLW87qz6BfwQ4wJ0=;
 b=JJOrGyZZqq4rojAgCCACapq35ZJjbi7FxWE07PMvDUixeWGPupa3aqgP1xVUIRLWJGExBl
 nMlptl0fSD1KlbbKW6pHBNKrLE19p7fZGdECd+FlzgVUl79M9VcgRia9BfF5lzag5SUD77
 6r3wzvuY4FbmnzYf6wgLgrBFu3UgVkk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-xjrp215uNAeX2zj9vAuhiw-1; Fri, 12 Jan 2024 00:17:51 -0500
X-MC-Unique: xjrp215uNAeX2zj9vAuhiw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F7C5830E5C;
 Fri, 12 Jan 2024 05:17:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C79C492BC6;
 Fri, 12 Jan 2024 05:17:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] util/uri: Remove is_hex() function
Date: Fri, 12 Jan 2024 06:17:40 +0100
Message-ID: <20240112051740.926658-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
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

We can simply use the g_ascii_isxdigit() from the glib instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 util/uri.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/util/uri.c b/util/uri.c
index dcb3305236..7411c5ba14 100644
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
@@ -1607,7 +1598,7 @@ char *uri_string_unescape(const char *str, int len, char *target)
     in = str;
     out = ret;
     while (len > 0) {
-        if ((len > 2) && (*in == '%') && (is_hex(in[1])) && (is_hex(in[2]))) {
+        if (len > 2 && *in == '%' && g_ascii_isxdigit(in[1]) && g_ascii_isxdigit(in[2])) {
             in++;
             if ((*in >= '0') && (*in <= '9')) {
                 *out = (*in - '0');
-- 
2.43.0


