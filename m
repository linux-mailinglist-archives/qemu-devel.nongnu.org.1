Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 742EABCE207
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Oct 2025 19:43:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7H6Q-00087C-HZ; Fri, 10 Oct 2025 13:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7H6M-00083y-7g
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:40:22 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7H6B-0007Rr-C9
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:40:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9297:0:640:61e7:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 8C5BE80787;
 Fri, 10 Oct 2025 20:40:07 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a89::1:23])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id xdPFQ30FtmI0-NRxkOOZG; Fri, 10 Oct 2025 20:40:07 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760118007;
 bh=AqHqBScLVphRHYcYitihKjsg9x0DNw0fNX+yiK30WWI=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=BEF3J81FIMPxj4UPUw3Kcd2aIZfgSPYOmBIBk8/OMkiicS3OM/H2+pAM70zfag0YU
 H4YOfCV0UxJSP9zz9wAjSkUzE1kDvLtB5TdVgxxZG02+XtoeN9pFV3b0U6LwODe81H
 KVYuk75YuKEbIOSRR1nomMT1oruhqAq4nsrds/To=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: peterx@redhat.com, farosas@suse.de, sw@weilnetz.de, eblake@redhat.com,
 armbru@redhat.com, thuth@redhat.com, philmd@linaro.org,
 berrange@redhat.com, qemu-devel@nongnu.org, michael.roth@amd.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: [PATCH v7 06/19] net/tap: setup exit notifier only when needed
Date: Fri, 10 Oct 2025 20:39:44 +0300
Message-ID: <20251010173957.166759-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251010173957.166759-1-vsementsov@yandex-team.ru>
References: <20251010173957.166759-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

No reason to setup notifier on each queue of multique tap,
when we actually want to run downscript only once.
As well, let's not setup notifier, when downscript is
not enabled (downsciprt="no").

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 net/tap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 994e885c5f..17ad561f9c 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -326,11 +326,9 @@ static void tap_exit_notify(Notifier *notifier, void *data)
     TAPState *s = container_of(notifier, TAPState, exit);
     Error *err = NULL;
 
-    if (s->down_script[0]) {
-        launch_script(s->down_script, s->down_script_arg, s->fd, &err);
-        if (err) {
-            error_report_err(err);
-        }
+    launch_script(s->down_script, s->down_script_arg, s->fd, &err);
+    if (err) {
+        error_report_err(err);
     }
 }
 
@@ -346,8 +344,11 @@ static void tap_cleanup(NetClientState *nc)
 
     qemu_purge_queued_packets(nc);
 
-    tap_exit_notify(&s->exit, NULL);
-    qemu_remove_exit_notifier(&s->exit);
+    if (s->exit.notify) {
+        tap_exit_notify(&s->exit, NULL);
+        qemu_remove_exit_notifier(&s->exit);
+        s->exit.notify = NULL;
+    }
 
     tap_read_poll(s, false);
     tap_write_poll(s, false);
@@ -443,9 +444,6 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     tap_read_poll(s, true);
     s->vhost_net = NULL;
 
-    s->exit.notify = tap_exit_notify;
-    qemu_add_exit_notifier(&s->exit);
-
     return s;
 }
 
@@ -725,6 +723,8 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
             snprintf(s->down_script, sizeof(s->down_script), "%s", downscript);
             snprintf(s->down_script_arg, sizeof(s->down_script_arg),
                      "%s", ifname);
+            s->exit.notify = tap_exit_notify;
+            qemu_add_exit_notifier(&s->exit);
         }
     }
 
-- 
2.48.1


