Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30124BDA5E1
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Oct 2025 17:29:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gvp-00070C-Tj; Tue, 14 Oct 2025 11:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8gvm-0006z6-TQ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:27:18 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8gvk-0007gf-2o
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:27:18 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 8C7B9807F8;
 Tue, 14 Oct 2025 18:27:11 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8a::1:35])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 7RRbiX2F1mI0-X0gO0Ur1; Tue, 14 Oct 2025 18:27:11 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760455631;
 bh=vusX7oQS6Rb/UOLs/e5Ea6mc9zWDZ4KZAFEbrB85u9Q=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=e14FhsBVss3hVUBDcvxD8Op9X6ohNgahC8RInTbdS+0W/KFt8/br4HgIZcFgNqJe2
 MBVS0lOBNC4gfXsY0qrhF0qYPoOhnet9aDUPOVUEkx2qOYsE/lXnoezdhvOyHHGshZ
 X50msJYW4uEBWDRMJ6KEqhXaN4e79cet9UAvrUwc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, raphael@enfabrica.net,
 armbru@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v3 3/7] chardev/char: qemu_char_open(): add return value
Date: Tue, 14 Oct 2025 18:26:40 +0300
Message-ID: <20251014152644.954762-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251014152644.954762-1-vsementsov@yandex-team.ru>
References: <20251014152644.954762-1-vsementsov@yandex-team.ru>
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

Accordingly with recommendations in include/qapi/error.h accompany
errp by boolean return value and get rid of error propagation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 chardev/char.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 4a531265c1..c874a2d31e 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -246,14 +246,20 @@ int qemu_chr_add_client(Chardev *s, int fd)
         CHARDEV_GET_CLASS(s)->chr_add_client(s, fd) : -1;
 }
 
-static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
+static bool qemu_char_open(Chardev *chr, ChardevBackend *backend,
                            bool *be_opened, Error **errp)
 {
+    ERRP_GUARD();
     ChardevClass *cc = CHARDEV_GET_CLASS(chr);
 
     if (cc->open) {
         cc->open(chr, backend, be_opened, errp);
+        if (*errp) {
+            return false;
+        }
     }
+
+    return true;
 }
 
 static void char_init(Object *obj)
@@ -1015,7 +1021,6 @@ static Chardev *chardev_new(const char *id, const char *typename,
 {
     Object *obj;
     Chardev *chr = NULL;
-    Error *local_err = NULL;
     bool be_opened = true;
 
     assert(g_str_has_prefix(typename, "chardev-"));
@@ -1031,9 +1036,7 @@ static Chardev *chardev_new(const char *id, const char *typename,
         goto fail;
     }
 
-    qemu_char_open(chr, backend, &be_opened, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qemu_char_open(chr, backend, &be_opened, errp)) {
         goto fail;
     }
 
-- 
2.48.1


