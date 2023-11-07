Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E61527E3712
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:00:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Hvf-0001Of-L9; Tue, 07 Nov 2023 03:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r0HvU-0001Eh-PU; Tue, 07 Nov 2023 03:59:13 -0500
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r0HvS-0004mZ-OQ; Tue, 07 Nov 2023 03:59:12 -0500
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1bac:0:640:75a2:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 3E40F6269C;
 Tue,  7 Nov 2023 11:59:03 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b676::1:19])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jwXmps4OkmI0-OLoDqTK4; Tue, 07 Nov 2023 11:59:02 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1699347542;
 bh=RbU2AhEIYoSsIpzzSHTfw0S8X3Bh//VFQqxawl/4l4k=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=fO2lUEM4EqxG6yPy3BRVSdlIJW5cbGGEwqQoeZKm8zpbqRhbqN8Ig+NbbsQ41PHfK
 cNWYYx96OUfCUGPzGj4MG2IrKjTj+fKpE7BzBYu3lv6Ho3tYFMeC9zmkNQWPqEcfK1
 mQ7YasXU803yyCfFEiNncUQCCw5RCpKG6lR1Jg4s=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, armbru@redhat.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru, zeil@yandex-team.ru, xeor@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org
Subject: [PATCH] block-backend: per-device throttling of BLOCK_IO_ERROR reports
Date: Tue,  7 Nov 2023 11:58:42 +0300
Message-Id: <20231107085842.602188-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Leonid Kaplan <xeor@yandex-team.ru>

BLOCK_IO_ERROR events comes from guest, so we must throttle them.
We still want per-device throttling, so let's use device id as a key.

Signed-off-by: Leonid Kaplan <xeor@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 monitor/monitor.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 01ede1babd..ad0243e9d7 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -309,6 +309,7 @@ int error_printf_unless_qmp(const char *fmt, ...)
 static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
     /* Limit guest-triggerable events to 1 per second */
     [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
+    [QAPI_EVENT_BLOCK_IO_ERROR]    = { 1000 * SCALE_MS },
     [QAPI_EVENT_WATCHDOG]          = { 1000 * SCALE_MS },
     [QAPI_EVENT_BALLOON_CHANGE]    = { 1000 * SCALE_MS },
     [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
@@ -498,6 +499,10 @@ static unsigned int qapi_event_throttle_hash(const void *key)
         hash += g_str_hash(qdict_get_str(evstate->data, "qom-path"));
     }
 
+    if (evstate->event == QAPI_EVENT_BLOCK_IO_ERROR) {
+        hash += g_str_hash(qdict_get_str(evstate->data, "device"));
+    }
+
     return hash;
 }
 
@@ -525,6 +530,11 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
                        qdict_get_str(evb->data, "qom-path"));
     }
 
+    if (eva->event == QAPI_EVENT_BLOCK_IO_ERROR) {
+        return !strcmp(qdict_get_str(eva->data, "device"),
+                       qdict_get_str(evb->data, "device"));
+    }
+
     return TRUE;
 }
 
-- 
2.34.1


