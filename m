Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C51BD33C7
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Oct 2025 15:39:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8IlM-0006eV-5S; Mon, 13 Oct 2025 09:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8IlK-0006eF-O1
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:38:55 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8IlB-0006aJ-Ld
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:38:54 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 941D780862;
 Mon, 13 Oct 2025 16:38:41 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a50::1:2a])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ccOm1D2F0Cg0-omRLFyys; Mon, 13 Oct 2025 16:38:41 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760362721;
 bh=bGbnp9mXGOdgJmDhBTMUTaoPxcAKbnS4yrcT4xk87bQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=XwVxjpzke0Kiy7ktMiHWfHbz/5C1E5sti3e7Qo9WV3ofqvlXNESScHA2saUK1eWp5
 Mu0VIgZ2hVLY5M8x/7mdbZjbwMQZRZYOJj/tRMaaHNlkLwrwH4XVHfobhYsrSsrm1J
 FZGrboKtYCcqYDYdRf1U0nOYOC5tibjrzVWS/8uU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, raphael@enfabrica.net,
 armbru@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v2 2/7] chardev/char: split chardev_init_logfd() out of
 qemu_char_open()
Date: Mon, 13 Oct 2025 16:38:31 +0300
Message-ID: <20251013133836.852018-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251013133836.852018-1-vsementsov@yandex-team.ru>
References: <20251013133836.852018-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 chardev/char.c | 49 +++++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index a43b7e5481..d5a2533e8e 100644
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
@@ -1000,6 +984,28 @@ void qemu_chr_set_feature(Chardev *chr,
     return set_bit(feature, chr->features);
 }
 
+static bool chardev_init_logfd(Chardev *chr, ChardevBackend *backend,
+                                Error **errp)
+{
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
@@ -1020,11 +1026,14 @@ static Chardev *chardev_new(const char *id, const char *typename,
     chr->label = g_strdup(id);
     chr->gcontext = gcontext;
 
+    if (!chardev_init_logfd(chr, backend, errp)) {
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
@@ -1035,6 +1044,10 @@ static Chardev *chardev_new(const char *id, const char *typename,
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


