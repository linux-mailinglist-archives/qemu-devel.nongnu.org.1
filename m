Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 034C3BDA5E0
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Oct 2025 17:29:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gvq-00070V-2O; Tue, 14 Oct 2025 11:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8gvm-0006yv-1Y
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:27:18 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8gvj-0007gt-Sw
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:27:17 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 0B198807DB;
 Tue, 14 Oct 2025 18:27:13 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8a::1:35])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 7RRbiX2F1mI0-jNHSANgp; Tue, 14 Oct 2025 18:27:12 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760455632;
 bh=e7yXNIFXohwZf1oeg5G5audWTehOW7zR4XPHuWfXKaU=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=WV5e/Sb9Wp9A5HD5tPfeNne2HzEblegOj4LnA9dL5+bZLoHEBjk54/RrpbXdDqSKX
 ESfW5LT6h/0Y4hFhLYw6hAoM06lHJimu2GOwPJiZ2XAI8MsQx1ognQ7g7gqSllwajk
 hV5fD3JAa6ZAWezm3CDAav1GptMwDD1FV8+hBDC8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, raphael@enfabrica.net,
 armbru@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v3 5/7] chardev/char: introduce .init() + .connect()
 initialization interface
Date: Tue, 14 Oct 2025 18:26:42 +0300
Message-ID: <20251014152644.954762-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251014152644.954762-1-vsementsov@yandex-team.ru>
References: <20251014152644.954762-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

We'll need a possibility to postpone connect step to later point in
time to implement backend-transfer migration feature for vhost-user-blk
in further commits. Let's start with new char interface for backends.

.init() takes QAPI parameters and should parse them, called early

.connect() should actually establish a connection, and postponed to
the point of attaching to frontend. Called at later point, either
at time of attaching frontend, either from qemu_chr_wait_connected().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-fe.c      |  4 ++++
 chardev/char.c         | 39 +++++++++++++++++++++++++++++++++++++--
 include/chardev/char.h | 22 +++++++++++++++++++++-
 3 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 158a5f4f55..973fed5bea 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -193,6 +193,10 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
 {
     unsigned int tag = 0;
 
+    if (!qemu_chr_connect(s, errp)) {
+        return false;
+    }
+
     if (s) {
         if (CHARDEV_IS_MUX(s)) {
             MuxChardev *d = MUX_CHARDEV(s);
diff --git a/chardev/char.c b/chardev/char.c
index 27290e26fb..409f3aac1c 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -33,6 +33,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-char.h"
 #include "qapi/qmp/qerror.h"
+#include "qom/object.h"
 #include "system/replay.h"
 #include "qemu/help_option.h"
 #include "qemu/module.h"
@@ -338,10 +339,29 @@ static bool qemu_chr_is_busy(Chardev *s)
     }
 }
 
+bool qemu_chr_connect(Chardev *chr, Error **errp)
+{
+    ChardevClass *cc = CHARDEV_GET_CLASS(chr);
+
+    if (chr->connect_postponed) {
+        assert(cc->connect);
+        chr->connect_postponed = false;
+        if (!cc->connect(chr, errp)) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
 int qemu_chr_wait_connected(Chardev *chr, Error **errp)
 {
     ChardevClass *cc = CHARDEV_GET_CLASS(chr);
 
+    if (!qemu_chr_connect(chr, errp)) {
+        return -1;
+    }
+
     if (cc->chr_wait_connected) {
         return cc->chr_wait_connected(chr, errp);
     }
@@ -1030,6 +1050,7 @@ static Chardev *chardev_new(const char *id, const char *typename,
 {
     Object *obj;
     Chardev *chr = NULL;
+    ChardevClass *cc;
 
     assert(g_str_has_prefix(typename, "chardev-"));
     assert(id);
@@ -1044,8 +1065,22 @@ static Chardev *chardev_new(const char *id, const char *typename,
         goto fail;
     }
 
-    if (!qemu_char_open(chr, backend, typename + 8, errp)) {
-        goto fail;
+    cc = CHARDEV_GET_CLASS(chr);
+
+    if (cc->init) {
+        assert(!cc->open);
+        assert(cc->connect);
+
+        if (!cc->init(chr, backend, errp)) {
+            goto fail;
+        }
+        assert(chr->filename);
+
+        chr->connect_postponed = true;
+    } else {
+        if (!qemu_char_open(chr, backend, typename + 8, errp)) {
+            goto fail;
+        }
     }
 
     return chr;
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 429852f8d9..ebadaf3482 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -63,6 +63,7 @@ struct Chardev {
     CharBackend *be;
     char *label;
     char *filename;
+    bool connect_postponed;
     int logfd;
     int be_open;
     /* used to coordinate the chardev-change special-case: */
@@ -225,6 +226,7 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
                                 bool permit_mux_mon);
 int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all);
 #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true)
+bool qemu_chr_connect(Chardev *chr, Error **errp);
 int qemu_chr_wait_connected(Chardev *chr, Error **errp);
 
 #define TYPE_CHARDEV "chardev"
@@ -259,10 +261,28 @@ struct ChardevClass {
     /* parse command line options and populate QAPI @backend */
     void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp);
 
-    /* called after construction, open/starts the backend */
+    /*
+     * Called after construction, create and open/starts the backend,
+     * mutual exclusive with .init. .connect must not be defined when
+     * .open is defined.
+     */
     void (*open)(Chardev *chr, ChardevBackend *backend,
                  bool *be_opened, Error **errp);
 
+    /*
+     * Called after construction, create the backend, mutual exclusive
+     * with .open, and must be accompanied by .connect.
+     * Must set chr-filename.
+     */
+    bool (*init)(Chardev *chr, ChardevBackend *backend,
+                 Error **errp);
+
+    /*
+     * Called after .init(), open/starts the backend, mutual exclusive
+     * with .open. Must send CHR_EVENT_OPENED.
+     */
+    bool (*connect)(Chardev *chr, Error **errp);
+
     /* write buf to the backend */
     int (*chr_write)(Chardev *s, const uint8_t *buf, int len);
 
-- 
2.48.1


