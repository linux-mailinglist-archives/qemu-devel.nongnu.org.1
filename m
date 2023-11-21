Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 120527F2AD4
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:41:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5OBS-0007dj-9k; Tue, 21 Nov 2023 05:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r5OBQ-0007dS-U3
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:40:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r5OBM-0003Fu-6D
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700563239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9JT5zFuC7oqj6UW3VAGVzElRtLR9xFuKN2cEei4sh+I=;
 b=hHjES5qzVZUAv4e7F544kZ+E7dEETiLzaomWF95QSLIq8PxudQj+B1RzBjwMIE0R1+k1QW
 A0MhvEa1SguCMRMMWFmDPpjyiSCUgVUJO9fOtldJ61YRYcYiYcpEbLj6sAji8iDCW72w6z
 m4olHhZTUq6QKqd7t0pv19lxx4t8/rU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-ZV52MlFiMS6wHSVXeQgMEQ-1; Tue, 21 Nov 2023 05:40:35 -0500
X-MC-Unique: ZV52MlFiMS6wHSVXeQgMEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88F1A85C1A0;
 Tue, 21 Nov 2023 10:40:35 +0000 (UTC)
Received: from localhost (unknown [10.39.208.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD2A920268D0;
 Tue, 21 Nov 2023 10:40:34 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 peter.maydell@linaro.org, dwmw@amazon.co.uk
Subject: [PULL 3/5] ui/console: fix default VC when there are no display
Date: Tue, 21 Nov 2023 14:40:18 +0400
Message-ID: <20231121104020.2209345-4-marcandre.lureau@redhat.com>
In-Reply-To: <20231121104020.2209345-1-marcandre.lureau@redhat.com>
References: <20231121104020.2209345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When display is "none", we may still have remote displays (I think it
would be simpler if VNC/Spice were regular display btw). Return the
default VC then, and set them up to fix a regression when using remote
display and it used the TTY instead.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1989
Fixes: commit 1bec1cc0d ("ui/console: allow to override the default VC")
Reported-by: German Maglione <gmaglione@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 ui/console.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 8e688d3569..7db921e3b7 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1679,19 +1679,17 @@ void qemu_display_init(DisplayState *ds, DisplayOptions *opts)
 
 const char *qemu_display_get_vc(DisplayOptions *opts)
 {
-    assert(opts->type < DISPLAY_TYPE__MAX);
-    if (opts->type == DISPLAY_TYPE_NONE) {
-        return NULL;
-    }
-    assert(dpys[opts->type] != NULL);
-    if (dpys[opts->type]->vc) {
-        return dpys[opts->type]->vc;
-    } else {
 #ifdef CONFIG_PIXMAN
-        return "vc:80Cx24C";
+    const char *vc = "vc:80Cx24C";
+#else
+    const char *vc = NULL;
 #endif
+
+    assert(opts->type < DISPLAY_TYPE__MAX);
+    if (dpys[opts->type] && dpys[opts->type]->vc) {
+        vc = dpys[opts->type]->vc;
     }
-    return NULL;
+    return vc;
 }
 
 void qemu_display_help(void)
-- 
2.42.0


