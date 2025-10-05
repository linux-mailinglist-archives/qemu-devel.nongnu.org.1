Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBF6BB944B
	for <lists+qemu-devel@lfdr.de>; Sun, 05 Oct 2025 08:57:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5IfJ-0004yM-Ec; Sun, 05 Oct 2025 02:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5IfC-0004qX-Eo; Sun, 05 Oct 2025 02:56:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5IfA-0007yA-JR; Sun, 05 Oct 2025 02:56:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5846115A8ED;
 Sun, 05 Oct 2025 09:55:44 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A75AB299482;
 Sun,  5 Oct 2025 09:55:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Marco Cavenati <Marco.Cavenati@eurecom.fr>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 8/8] system/runstate: remove duplicate in runstate transitions
Date: Sun,  5 Oct 2025 09:55:36 +0300
Message-ID: <20251005065538.436862-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251005065538.436862-1-mjt@tls.msk.ru>
References: <20251005065538.436862-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Marco Cavenati <Marco.Cavenati@eurecom.fr>

Remove duplicate entry PRELAUNCH->INMIGRATE from runstate_transitions_def.
Move PRELAUNCH->SUSPENDED entry with all the other PRELAUNCH->XXX entries.

Signed-off-by: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 system/runstate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/system/runstate.c b/system/runstate.c
index 6178b0091a..32467aa882 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -76,9 +76,6 @@ typedef struct {
 } RunStateTransition;
 
 static const RunStateTransition runstate_transitions_def[] = {
-    { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
-    { RUN_STATE_PRELAUNCH, RUN_STATE_SUSPENDED },
-
     { RUN_STATE_DEBUG, RUN_STATE_RUNNING },
     { RUN_STATE_DEBUG, RUN_STATE_FINISH_MIGRATE },
     { RUN_STATE_DEBUG, RUN_STATE_PRELAUNCH },
@@ -118,6 +115,7 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_PRELAUNCH, RUN_STATE_RUNNING },
     { RUN_STATE_PRELAUNCH, RUN_STATE_FINISH_MIGRATE },
     { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
+    { RUN_STATE_PRELAUNCH, RUN_STATE_SUSPENDED },
 
     { RUN_STATE_FINISH_MIGRATE, RUN_STATE_RUNNING },
     { RUN_STATE_FINISH_MIGRATE, RUN_STATE_PAUSED },
-- 
2.47.3


