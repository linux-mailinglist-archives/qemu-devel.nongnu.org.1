Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FACF7AF4E8
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:18:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlETa-0000Xn-G8; Tue, 26 Sep 2023 16:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlETX-0000Wh-8l
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:16:07 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlETR-0002h2-Pd
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:16:07 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 956E56079A;
 Tue, 26 Sep 2023 23:15:56 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b41d::1:39])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ZFWwvr0Oc0U0-DGo0cj3F; Tue, 26 Sep 2023 23:15:56 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695759356;
 bh=wvUasXlWa6y9/1/CgE5+CmyIWRY2KP5PRQL2MGutOgg=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=y0gXSfiKetMq0xgii1aqk35pMW9rV2weQ2Qo1vtYVyRLkmtK52Y163nClBW0EVKZ7
 IPTmRTqULjYyLHpeE0lNdE6KKrtp5POS3mBsqgrEfGCDgtuX97vy2jk/kB/EJV4p0N
 BBvEPYohzRbRInUTs4reo8ygIISDtj6XD7LStQg4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@yandex-team.ru, peter.maydell@linaro.org,
 yc-core@yandex-team.ru, davydov-max@yandex-team.ru,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 2/8] util/filemonitor-inotify: qemu_file_monitor_watch():
 assert no overflow
Date: Tue, 26 Sep 2023 23:15:26 +0300
Message-Id: <20230926201532.221152-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926201532.221152-1-vsementsov@yandex-team.ru>
References: <20230926201532.221152-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
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


