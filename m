Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A48A70F03E
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:09:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1jYf-00007u-6u; Wed, 24 May 2023 04:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q1jYd-00006f-5K
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:09:19 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q1jYb-00023T-96
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684915757; x=1716451757;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zG0n7UrRx9dIH5XFgkXb7KK+/2t0Ws03tRPFJqIUt5Q=;
 b=OG1ZNEHOJi2NFdlqXY+NRjzxeYWxrYZiFPZSIm64gQhoLOoq1iXpvKSP
 jRGqDV0/QAYm6+w2jIjGHsWRDXkC/nE1SkEtZ/Q+3CHyNXCxK4NFQThMm
 MElwJ0/za+4SVQrjOD6eRJ/o6QVexqqKf9yAyRLNs2Opu5ZUbdCR2awXg
 sLhaMxTG+pPbIQCU4eNOUKYR9AOBny5boce9hBSL6ocuGtwc8+wJ4aBxS
 fF+m59qMGQJD+deF70WnbwkMWXSKYCHIBNAOCi+27cdQeCU7oe9zZ2ZlH
 fa/EiBJNiTDfEB+q0+9UgdldIVLqXMq5yB+UwHOF0pDTEhuUAW9eWvz1u A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="351003973"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; d="scan'208";a="351003973"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2023 01:09:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="1034433492"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; d="scan'208";a="1034433492"
Received: from tdx-lm.sh.intel.com ([10.239.53.27])
 by fmsmga005.fm.intel.com with ESMTP; 24 May 2023 01:09:08 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: quintela@redhat.com,
	peterx@redhat.com,
	qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1] migration/multifd: always post the sync semaphores when
 sendesr exit
Date: Wed, 24 May 2023 16:09:06 +0800
Message-Id: <20230524080906.531440-1-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93; envelope-from=wei.w.wang@intel.com;
 helo=mga11.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The sem_sync and channels_ready semaphores are used by the multifd
sender threads to synchronize with the migration thread. It is possible
that one of the sender threads exits due to an error (e.g. occured when
writing to the socket). The error thread sets multifd_send_state->exiting
to force other sender threads to exit. Those threads exit (due to the
setting of multifd_send_state->exiting) won't post the sem_sync and
channels_ready semaphores, as they didn't encounter any error (i.e. ret
will be 0 when exits). In this case, if the migration thread is waiting on
the sem_sync semaphores from all the sender threads, it will wait there
forever, which is not expected.

Change the sender threads to always post the sem_sync and channels_ready
semaphores when exit. This will unblock the migration thread in the
above case to exit. If the main thread isn't waiting on the semaphores
when the sender threads exits, posting on the semaphores will just be
like a noop.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 migration/multifd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 0bf5958a9c..1ff461675e 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -757,10 +757,8 @@ out:
      * Error happen, I will exit, but I can't just leave, tell
      * who pay attention to me.
      */
-    if (ret != 0) {
-        qemu_sem_post(&p->sem_sync);
-        qemu_sem_post(&multifd_send_state->channels_ready);
-    }
+    qemu_sem_post(&p->sem_sync);
+    qemu_sem_post(&multifd_send_state->channels_ready);
 
     qemu_mutex_lock(&p->mutex);
     p->running = false;
-- 
2.27.0


