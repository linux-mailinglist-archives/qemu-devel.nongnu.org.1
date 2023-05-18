Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3AA707C5F
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 10:54:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzZNO-0005ex-Gc; Thu, 18 May 2023 04:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1pzZNM-0005dO-Kb
 for qemu-devel@nongnu.org; Thu, 18 May 2023 04:52:44 -0400
Received: from mga18.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1pzZNK-0007RP-FO
 for qemu-devel@nongnu.org; Thu, 18 May 2023 04:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684399962; x=1715935962;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JD+bi8xYE517D81moS0Q+NxZ5p1k4th2MN3ZBXrJLcY=;
 b=RSikeaG7piIomrPgD/r+mmwT4QIeSF66KJtZR5NXiDRDPP0F6KG7z0Iw
 O5DwkBWancEXD1hbgaHr8mYb9flVf8SdpCvhcQYwoavN5tEOzK/cc4FSH
 uEVC9kQcSbwcIoz5oIKouE6UB4TXxBONkkyYjWRJa/TWKoq4YTeW2MDaS
 fv8b23BXDywlcFnqL9GGbje3W5RpxKwm0EYgBaLE0gRbgHe0AnKddZq3p
 ukMu87NM24Q+mJf7dVIf/jTrxODMB9YKE+lZV0snA+D/Kj1+FkzoMWM3/
 W0cG2uexVZAtA22dVf9NQwZM952uLKHNpStnES/SXT4GHQgFri/I6M3Cw w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="336577165"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; d="scan'208";a="336577165"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 01:52:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="826287510"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; d="scan'208";a="826287510"
Received: from sqa-gate.sh.intel.com (HELO emr-bkc.tsp.org) ([10.239.48.212])
 by orsmga004-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 01:52:30 -0700
From: Lei Wang <lei4.wang@intel.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 wei.w.wang@intel.com, lei4.wang@intel.com
Subject: [PATCH] multifd: Set a higher "backlog" default value for listen()
Date: Thu, 18 May 2023 04:52:28 -0400
Message-Id: <20230518085228.172816-1-lei4.wang@intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126; envelope-from=lei4.wang@intel.com;
 helo=mga18.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

When destination VM is launched, the "backlog" parameter for listen() is set
to 1 as default in socket_start_incoming_migration_internal(), which will
lead to socket connection error (the queue of pending connections is full)
when "multifd" and "multifd-channels" are set later on and a high number of
channels are used. Set it to a hard-coded higher default value 512 to fix
this issue.

Reported-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Lei Wang <lei4.wang@intel.com>
---
 migration/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/socket.c b/migration/socket.c
index 1b6f5baefb..b43a66ef7e 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -179,7 +179,7 @@ socket_start_incoming_migration_internal(SocketAddress *saddr,
     QIONetListener *listener = qio_net_listener_new();
     MigrationIncomingState *mis = migration_incoming_get_current();
     size_t i;
-    int num = 1;
+    int num = 512;
 
     qio_net_listener_set_name(listener, "migration-socket-listener");
 
-- 
2.39.1


