Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDB4708588
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 18:03:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzg3X-00061T-Sv; Thu, 18 May 2023 12:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1pzg3S-0005z5-9z
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:00:38 -0400
Received: from mga09.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1pzg3P-0002cB-Iq
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684425635; x=1715961635;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eCBYIrtOQLwqVAF3o7BB/oV4WWvikQ/qhwOCWawi+aU=;
 b=bxq6OtdbdCTBRatYK0UId1QJ5MbWSOQCXYebVeP7d6ywEDShesewdHpS
 pwXFKYxrlxyJUP1qUCcSSzDLpZYPGnO2QqC/Jc7dFm3YGnvlbftYC51Y9
 KJRXIgFY3fMMwkl25x+5JP/gZTUPIkKR0sbOofF5j2bJ8qt9ScMtfEku3
 oiSyfueFIhYBfU9q388tbVS8JCXZZ4gcO4MBHiLAXzmBlRRd8CqsI0Vgo
 OnR7DQwZZatQoON4B9mTakE6zHT7rwj5D698pav+gr4WUhJfOXFe2llH4
 N9YtZNhitTunwan+/wvjoGkdt8FCS/+CYba10n8HUJjX4ZG1sPXdIJxsT g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="354439529"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="354439529"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 09:00:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="652699403"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="652699403"
Received: from tdx-lm.sh.intel.com ([10.239.53.27])
 by orsmga003.jf.intel.com with ESMTP; 18 May 2023 09:00:28 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: quintela@redhat.com, lei4.wang@intel.com, peterx@redhat.com,
 berrange@redhat.com, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1] migration: fail the cap check if it requires the use of
 deferred incoming
Date: Fri, 19 May 2023 00:00:26 +0800
Message-Id: <20230518160026.57414-1-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.24; envelope-from=wei.w.wang@intel.com;
 helo=mga09.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

qemu_start_incoming_migration needs to check the number of multifd
channels or postcopy ram channels to configure the backlog parameter (i.e.
the maximum length to which the queue of pending connections for sockfd
may grow) of listen(). So multifd and postcopy-preempt caps require the
use of deferred incoming, that is, calling qemu_start_incoming_migration
should be deferred via qmp or hmp commands after the cap of multifd and
postcopy-preempt are configured.

Check if deferred incoming is used when enabling multifd or
postcopy-preempt, and fail the check with error messages if not.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 migration/options.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index c2a278ee2d..25b333b3f4 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -537,6 +537,11 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             error_setg(errp, "Postcopy preempt not compatible with compress");
             return false;
         }
+
+        if (mis->transport_data) {
+            error_setg(errp, "Postcopy preempt should use deferred incoming");
+            return false;
+        }
     }
 
     if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
@@ -544,6 +549,10 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             error_setg(errp, "Multifd is not compatible with compress");
             return false;
         }
+        if (mis->transport_data) {
+            error_setg(errp, "Multifd should use deferred incoming");
+            return false;
+        }
     }
 
     return true;
-- 
2.27.0


