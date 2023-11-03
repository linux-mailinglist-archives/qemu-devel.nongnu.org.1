Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D167E030E
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 13:37:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qytPr-0001gW-73; Fri, 03 Nov 2023 08:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ds-gavr@yandex-team.ru>)
 id 1qyrqf-0008Jq-0S
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 06:56:21 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ds-gavr@yandex-team.ru>)
 id 1qyrqc-0004uX-1G
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 06:56:20 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:ba1:0:640:375a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 1ACA8624F1;
 Fri,  3 Nov 2023 13:56:11 +0300 (MSK)
Received: from i109893567.yandex.net (unknown
 [2a02:6b8:81:0:f151:bc79:d059:2ded])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 4uVYU32OlOs0-KxTlHspJ; Fri, 03 Nov 2023 13:56:10 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1699008970;
 bh=qCavihW7LdQKWh9n4gH9af7kH/YS0RNrqa/KbS1z+PQ=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=G9mZDiGJTTKQ1qIWhx2zpGiAxu7iuCIhUxWDtojn0ajEZxlEnc8TDWB0zHCvu8/KH
 XwQOn5lvxCO5uvyNkgSqGXFxBvKJRkLveOVddfWCqNECn8crUQpDJmC51P9gjHiGtB
 p2hFcniVjLZ7iKqPb6AMR73U9jINs+zrX1jGkShk=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 mlevitsk@redhat.com, vsementsov@yandex-team.ru, ds-gavr@yandex-team.ru,
 yc-core@yandex-team.ru
Subject: [PATCH] system/qdev-monitor: move drain_call_rcu call under if (!dev)
 in qmp_device_add()
Date: Fri,  3 Nov 2023 13:56:02 +0300
Message-Id: <20231103105602.90475-1-ds-gavr@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=ds-gavr@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 03 Nov 2023 08:36:44 -0400
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

Original goal of addition of drain_call_rcu to qmp_device_add was to cover
the failure case of qdev_device_add. It seems call of drain_call_rcu was
misplaced in 7bed89958bfbf40df what led to waiting for pending RCU callbacks
under happy path too. What led to overall performance degradation of
qmp_device_add.

In this patch call of drain_call_rcu moved under handling of failure of
qdev_device_add.

Signed-off-by: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>
---
 system/qdev-monitor.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 1b8005a..dc7b02d 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -856,19 +856,18 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
         return;
     }
     dev = qdev_device_add(opts, errp);
-
-    /*
-     * Drain all pending RCU callbacks. This is done because
-     * some bus related operations can delay a device removal
-     * (in this case this can happen if device is added and then
-     * removed due to a configuration error)
-     * to a RCU callback, but user might expect that this interface
-     * will finish its job completely once qmp command returns result
-     * to the user
-     */
-    drain_call_rcu();
-
     if (!dev) {
+        /*
+         * Drain all pending RCU callbacks. This is done because
+         * some bus related operations can delay a device removal
+         * (in this case this can happen if device is added and then
+         * removed due to a configuration error)
+         * to a RCU callback, but user might expect that this interface
+         * will finish its job completely once qmp command returns result
+         * to the user
+         */
+        drain_call_rcu();
+
         qemu_opts_del(opts);
         return;
     }
-- 
2.34.1


