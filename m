Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E3AC25FC6
	for <lists+qemu-devel@lfdr.de>; Fri, 31 Oct 2025 17:05:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vErXX-00078O-TC; Fri, 31 Oct 2025 11:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vErXL-00075v-Ux
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:59:36 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vErXC-0005zh-Bu
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:59:34 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id AF81E80825;
 Fri, 31 Oct 2025 18:59:20 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:546::1:17])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Fxip9o0FqiE0-3NuanIde; Fri, 31 Oct 2025 18:59:20 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761926360;
 bh=hth7YYgv5oIa1kzM1USTJdXw0rOKTSihTZikQSyHH3w=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=nyZAZlJfkGT1ltOzJXEi0070ua6GvTp4IBBPTyNbFzRwfDbZv17OGhV7PCi8XC2Ys
 DzHu804SLMAJL36mCquZT1jh8wTuCzcZD3w2mYc6w6PhFOV15zan3wYpxuNoMtBgad
 1idq4G6VGI8HK5j+2MVpePu9y1cxFJ/owkImD+1A=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, raphael@enfabrica.net,
 armbru@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v5 2/7] chardev/char: split chardev_init_common() out of
 qemu_char_open()
Date: Fri, 31 Oct 2025 18:59:09 +0300
Message-ID: <20251031155914.189112-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251031155914.189112-1-vsementsov@yandex-team.ru>
References: <20251031155914.189112-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

We are going to share new chardev_init_logfd() with further
alternative initialization interface. Let qemu_char_open() be
a wrapper for .open(), and its artifacts (handle be_opened if
was not set to false by backend, and filename).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c | 50 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 3e432195a5..216c95c053 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -250,22 +250,6 @@ static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
                            bool *be_opened, Error **errp)
 {
     ChardevClass *cc = CHARDEV_GET_CLASS(chr);
-    /* Any ChardevCommon member would work */
-    ChardevCommon *common = backend ? backend->u.null.data : NULL;
-
-    if (common && common->logfile) {
-        int flags = O_WRONLY;
-        if (common->has_logappend &&
-            common->logappend) {
-            flags |= O_APPEND;
-        } else {
-            flags |= O_TRUNC;
-        }
-        chr->logfd = qemu_create(common->logfile, flags, 0666, errp);
-        if (chr->logfd < 0) {
-            return;
-        }
-    }
 
     if (cc->open) {
         cc->open(chr, backend, be_opened, errp);
@@ -1000,6 +984,29 @@ void qemu_chr_set_feature(Chardev *chr,
     return set_bit(feature, chr->features);
 }
 
+static bool chardev_init_common(Chardev *chr, ChardevBackend *backend,
+                                Error **errp)
+{
+    /* Any ChardevCommon member would work */
+    ChardevCommon *common = backend ? backend->u.null.data : NULL;
+
+    if (common && common->logfile) {
+        int flags = O_WRONLY;
+        if (common->has_logappend &&
+            common->logappend) {
+            flags |= O_APPEND;
+        } else {
+            flags |= O_TRUNC;
+        }
+        chr->logfd = qemu_create(common->logfile, flags, 0666, errp);
+        if (chr->logfd < 0) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static Chardev *chardev_new(const char *id, const char *typename,
                             ChardevBackend *backend,
                             GMainContext *gcontext,
@@ -1020,11 +1027,14 @@ static Chardev *chardev_new(const char *id, const char *typename,
     chr->label = g_strdup(id);
     chr->gcontext = gcontext;
 
+    if (!chardev_init_common(chr, backend, errp)) {
+        goto fail;
+    }
+
     qemu_char_open(chr, backend, &be_opened, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        object_unref(obj);
-        return NULL;
+        goto fail;
     }
 
     if (!chr->filename) {
@@ -1035,6 +1045,10 @@ static Chardev *chardev_new(const char *id, const char *typename,
     }
 
     return chr;
+
+fail:
+    object_unref(obj);
+    return NULL;
 }
 
 Chardev *qemu_chardev_new(const char *id, const char *typename,
-- 
2.48.1


