Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC78C79137C
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 10:33:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd500-0005dK-LV; Mon, 04 Sep 2023 04:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1qd4zn-0005bK-R9; Mon, 04 Sep 2023 04:31:44 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1qd4zh-0003nc-2i; Mon, 04 Sep 2023 04:31:43 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=debian.fritz.box)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1qd4wZ-00DKZj-0V; Mon, 04 Sep 2023 10:31:22 +0200
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, den@virtuozzo.com
Subject: [PATCH 2/2] blockdev: qmp_transaction: remove bdrv_drain_all from
 transaction
Date: Mon,  4 Sep 2023 10:31:16 +0200
Message-Id: <20230904083116.568912-2-andrey.zhadchenko@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230904083116.568912-1-andrey.zhadchenko@virtuozzo.com>
References: <20230904083116.568912-1-andrey.zhadchenko@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.zhadchenko@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Reply-to:  Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
From:  Andrey Zhadchenko via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Now all transaction actions drain their respective bds
Also, bdrv_drain_all() did not protect anything in case of IOThreads

Signed-off-by: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
---
 blockdev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 7a376fce90..65932f9afb 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2303,9 +2303,6 @@ void qmp_transaction(TransactionActionList *actions,
         block_job_txn = job_txn_new();
     }
 
-    /* drain all i/o before any operations */
-    bdrv_drain_all();
-
     tran = tran_new();
 
     /* We don't do anything in this loop that commits us to the operations */
-- 
2.39.2


