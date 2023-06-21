Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9089973836C
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 14:14:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBwik-0004Wr-M5; Wed, 21 Jun 2023 08:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjianguo18@huawei.com>)
 id 1qBtb8-0001r7-Oi
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:53:54 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjianguo18@huawei.com>)
 id 1qBtb6-0002fm-Cw
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:53:54 -0400
Received: from dggpemm500018.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QmHJv3pwHzMpWS
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 16:50:39 +0800 (CST)
Received: from localhost.localdomain (10.175.124.27) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 21 Jun 2023 16:53:47 +0800
To: <qemu-devel@nongnu.org>
CC: <chenyuhui5@huawei.com>, <xuyinghua3@huawei.com>,
 <liheng.liheng@huawei.com>, <renxuming@huawei.com>,
 <pengyi.pengyi@huawei.com>, <yubihong@huawei.com>, <zhengchuan@huawei.com>,
 <huhao33@huawei.com>, <zhangjianguo18@huawei.com>
Subject: [RESEND][PATCH] migrate/multifd: fix coredump when the multifd thread
 cleanup
Date: Wed, 21 Jun 2023 16:53:39 +0800
Message-ID: <20230621085339.3530621-1-zhangjianguo18@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=zhangjianguo18@huawei.com; helo=szxga02-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 21 Jun 2023 08:13:46 -0400
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
Reply-to:  z00619469 <zhangjianguo18@huawei.com>
From:  z00619469 via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Yuhui Chen <chenyuhui5@huawei.com>

There is a coredump while trying to destroy mutex when
p->running is false but p->mutex is not unlock.
Make sure all mutexes has been released before destroy them.

Signed-off-by: Yuhui Chen <chenyuhui5@huawei.com>
---
 migration/multifd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index b7ad7002e0..7dcdb2d3a0 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -523,9 +523,7 @@ void multifd_save_cleanup(void)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
-        if (p->running) {
-            qemu_thread_join(&p->thread);
-        }
+        qemu_thread_join(&p->thread);
     }
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
@@ -1040,8 +1038,8 @@ int multifd_load_cleanup(Error **errp)
              * however try to wakeup it without harm in cleanup phase.
              */
             qemu_sem_post(&p->sem_sync);
-            qemu_thread_join(&p->thread);
         }
+        qemu_thread_join(&p->thread);
     }
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
-- 
2.21.0.windows.1


