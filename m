Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C30A57ADFB3
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:42:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkrSJ-0002h6-76; Mon, 25 Sep 2023 15:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qkrSG-0002fL-Jo
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:41:16 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qkrSD-0004lQ-Mz
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:41:16 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 506596373A;
 Mon, 25 Sep 2023 22:41:09 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:6422::1:2a])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id geUBjG0OhCg0-7VSD6wMv; Mon, 25 Sep 2023 22:41:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695670868;
 bh=udxd0/JSFufe9JLT7bXz/dMVFUwqQDx8UQQ6D+xT8K4=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ddn8458BPJ2phxLkF+bsbzhILVpLH5tYypZUG5UTc8pgVlq74+2ztNqWOPFTdQJQd
 SVgdfYSHyUlUlVkTJhr26hdI7P0mVAMbtHj6c/7mHOPaFfRnLOqmSDWf7I7XfDpse5
 7FlZnovyW7lgxBpx0G8/trx/WVSBlGYhTh55nfxw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@yandex-team.ru,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 03/12] util/filemonitor-inotify: qemu_file_monitor_watch():
 avoid overflow
Date: Mon, 25 Sep 2023 22:40:31 +0300
Message-Id: <20230925194040.68592-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925194040.68592-1-vsementsov@yandex-team.ru>
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Prefer clear assertions instead of possible array overflow.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 util/filemonitor-inotify.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/util/filemonitor-inotify.c b/util/filemonitor-inotify.c
index 2c45f7f176..09ef240174 100644
--- a/util/filemonitor-inotify.c
+++ b/util/filemonitor-inotify.c
@@ -81,16 +81,21 @@ static void qemu_file_monitor_watch(void *arg)
 
     /* Loop over all events in the buffer */
     while (used < len) {
-        struct inotify_event *ev =
-            (struct inotify_event *)(buf + used);
-        const char *name = ev->len ? ev->name : "";
-        QFileMonitorDir *dir = g_hash_table_lookup(mon->idmap,
-                                                   GINT_TO_POINTER(ev->wd));
-        uint32_t iev = ev->mask &
-            (IN_CREATE | IN_MODIFY | IN_DELETE | IN_IGNORED |
-             IN_MOVED_TO | IN_MOVED_FROM | IN_ATTRIB);
+        const char *name;
+        QFileMonitorDir *dir;
+        uint32_t iev;
         int qev;
         gsize i;
+        struct inotify_event *ev = (struct inotify_event *)(buf + used);
+
+        assert(len - used >= sizeof(struct inotify_event));
+        assert(len - used - sizeof(struct inotify_event) >= ev->len);
+
+        name = ev->len ? ev->name : "";
+        dir = g_hash_table_lookup(mon->idmap, GINT_TO_POINTER(ev->wd));
+        iev = ev->mask &
+            (IN_CREATE | IN_MODIFY | IN_DELETE | IN_IGNORED |
+             IN_MOVED_TO | IN_MOVED_FROM | IN_ATTRIB);
 
         used += sizeof(struct inotify_event) + ev->len;
 
-- 
2.34.1


