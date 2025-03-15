Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3587A62773
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Mar 2025 07:33:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKwX-0005Jl-8g; Sat, 15 Mar 2025 02:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKuU-0001Ud-FC; Sat, 15 Mar 2025 02:22:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKuS-0003oN-G6; Sat, 15 Mar 2025 02:22:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 18533FF9F6;
 Sat, 15 Mar 2025 09:17:08 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E2AF21CAC5F;
 Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9035555903; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>, Jason Wang <jasowang@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 42/51] net: parameterize the removing client from nc
 list
Date: Sat, 15 Mar 2025 09:17:48 +0300
Message-Id: <20250315061801.622606-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Eugenio Pérez <eperezma@redhat.com>

This change is used in later commits so we can avoid the removal of the
netclient if it is delayed.

No functional change intended.

Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit db0d4017f9b9e87f962b35dd19a4912bbfcd3cbc)
(Mjt: pick this one up for the following change,
 "net: move backend cleanup to NIC cleanup")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/net.c b/net/net.c
index fefa701bb2..1360ca4321 100644
--- a/net/net.c
+++ b/net/net.c
@@ -381,9 +381,12 @@ NetClientState *qemu_get_peer(NetClientState *nc, int queue_index)
     return ncs->peer;
 }
 
-static void qemu_cleanup_net_client(NetClientState *nc)
+static void qemu_cleanup_net_client(NetClientState *nc,
+                                    bool remove_from_net_clients)
 {
-    QTAILQ_REMOVE(&net_clients, nc, next);
+    if (remove_from_net_clients) {
+        QTAILQ_REMOVE(&net_clients, nc, next);
+    }
 
     if (nc->info->cleanup) {
         nc->info->cleanup(nc);
@@ -442,14 +445,14 @@ void qemu_del_net_client(NetClientState *nc)
         }
 
         for (i = 0; i < queues; i++) {
-            qemu_cleanup_net_client(ncs[i]);
+            qemu_cleanup_net_client(ncs[i], true);
         }
 
         return;
     }
 
     for (i = 0; i < queues; i++) {
-        qemu_cleanup_net_client(ncs[i]);
+        qemu_cleanup_net_client(ncs[i], true);
         qemu_free_net_client(ncs[i]);
     }
 }
@@ -474,7 +477,7 @@ void qemu_del_nic(NICState *nic)
     for (i = queues - 1; i >= 0; i--) {
         NetClientState *nc = qemu_get_subqueue(nic, i);
 
-        qemu_cleanup_net_client(nc);
+        qemu_cleanup_net_client(nc, true);
         qemu_free_net_client(nc);
     }
 
-- 
2.39.5


