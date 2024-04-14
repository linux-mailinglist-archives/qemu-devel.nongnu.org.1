Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9D489EBF1
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Apr 2024 09:30:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSJR-000083-LX; Wed, 10 Apr 2024 03:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSJA-0008Lg-ME; Wed, 10 Apr 2024 03:23:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSJ9-0003x3-3U; Wed, 10 Apr 2024 03:23:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 457605D67C;
 Wed, 10 Apr 2024 10:25:03 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id DCF3EB02BD;
 Wed, 10 Apr 2024 10:23:04 +0300 (MSK)
Received: (nullmailer pid 4191684 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yu Zhang <yu.zhang@ionos.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Peter Xu <peterx@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 13/87] migration/rdma: Fix a memory issue for migration
Date: Wed, 10 Apr 2024 10:21:46 +0300
Message-Id: <20240410072303.4191455-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Yu Zhang <yu.zhang@ionos.com>

In commit 3fa9642ff7 change was made to convert the RDMA backend to
accept MigrateAddress struct. However, the assignment of "host" leads
to data corruption on the target host and the failure of migration.

    isock->host = rdma->host;

By allocating the memory explicitly for it with g_strdup_printf(), the
issue is fixed and the migration doesn't fail any more.

Fixes: 3fa9642ff7 ("migration: convert rdma backend to accept MigrateAddress")
Cc: qemu-stable <qemu-stable@nongnu.org>
Cc: Li Zhijian <lizhijian@fujitsu.com>
Link: https://lore.kernel.org/r/CAHEcVy4L_D6tuhJ8h=xLR4WaPaprJE3nnxZAEyUnoTrxQ6CF5w@mail.gmail.com
Signed-off-by: Yu Zhang <yu.zhang@ionos.com>
[peterx: use g_strdup() instead of g_strdup_printf(), per Zhijian]
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 69f7b00d057f8832a841a53d5ee31eb303157398)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/rdma.c b/migration/rdma.c
index 4141c0bd25..143008a28a 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3357,7 +3357,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         goto err_rdma_dest_wait;
     }
 
-    isock->host = rdma->host;
+    isock->host = g_strdup(rdma->host);
     isock->port = g_strdup_printf("%d", rdma->port);
 
     /*
-- 
2.39.2


