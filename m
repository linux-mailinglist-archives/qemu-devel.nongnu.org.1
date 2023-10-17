Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCDA7CC4B1
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:21:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjg9-0005od-Sv; Tue, 17 Oct 2023 09:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsjg4-0005nl-BL
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:00:04 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsjfx-0003W6-9j
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:00:04 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id C6C8F62127;
 Tue, 17 Oct 2023 15:59:54 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8006::1:24])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id gxjRqEIOdGk0-VDpoOspz; Tue, 17 Oct 2023 15:59:54 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1697547594;
 bh=bRLyidxkORoXj5gdDK1ngLt2TqnLpNaBk1OXzDr4P0Q=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=HpL1sJLY95Pzl0eSQ/dKkvbx92MTeLWBWiH/3hGYTWyhZ0nxVM4slS2sPSe7SEzhn
 gdW2tXnTnkh9RR7nywqjtyWt15e0QIo8wXlsYfCoNjtg6hkCK9bepWAWvqLnGQJBB1
 P0Yvr37HpTEdWvvxVkBFvlKXhrFxFzOR1nrTHpyk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru, davydov-max@yandex-team.ru,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 2/6] util/filemonitor-inotify: qemu_file_monitor_watch():
 assert no overflow
Date: Tue, 17 Oct 2023 15:59:37 +0300
Message-Id: <20231017125941.810461-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017125941.810461-1-vsementsov@yandex-team.ru>
References: <20231017125941.810461-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Prefer clear assertions instead of [im]possible array overflow.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 util/filemonitor-inotify.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/util/filemonitor-inotify.c b/util/filemonitor-inotify.c
index 2c45f7f176..2121111f38 100644
--- a/util/filemonitor-inotify.c
+++ b/util/filemonitor-inotify.c
@@ -81,16 +81,25 @@ static void qemu_file_monitor_watch(void *arg)
 
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
+        /*
+         * We trust the kenel to provide valid buffer with complete event
+         * records.
+         */
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


