Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6295377EB6F
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 23:09:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWNlH-0004GR-Hw; Wed, 16 Aug 2023 17:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <efim.shevrin@virtuozzo.com>)
 id 1qWMlK-0000wl-WF
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 16:05:03 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <efim.shevrin@virtuozzo.com>)
 id 1qWMlH-00018o-3N
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 16:05:02 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6]
 helo=localhost.localdomain)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <efim.shevrin@virtuozzo.com>) id 1qWMif-00EdjA-2V;
 Wed, 16 Aug 2023 22:04:38 +0200
To: qemu-devel@nongnu.org
Cc: efim.shevrin@virtuozzo.com, kkostiuk@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, den@openvz.org
Subject: [PATCH] qga: Start qemu-ga service after NetworkManager start
Date: Thu, 17 Aug 2023 04:04:46 +0800
Message-Id: <20230816200446.1408797-1-efim.shevrin@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=efim.shevrin@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 16 Aug 2023 17:09:00 -0400
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
Reply-to:  Efim Shevrin <efim.shevrin@virtuozzo.com>
From:  Efim Shevrin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Fima Shevrin <efim.shevrin@virtuozzo.com>

When the guest OS starts, qemu-ga sends an event to the host.
This event allows services on the host to start configuring
the already running guest OS. When configuring network settings,
it is possible that an external service will receive a signal
from qemu-ga about the start of guest OS, while NetworkManager
may not be running yet. Therefore, network setting may not
be available. With the current patch, we eliminate the described
race condition between qemu-ga and NetworkManager for guest OS
network setting cases.

Signed-off-by: Fima Shevrin <efim.shevrin@virtuozzo.com>
---
 contrib/systemd/qemu-guest-agent.service | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/systemd/qemu-guest-agent.service b/contrib/systemd/qemu-guest-agent.service
index 51cd7b37ff..6e2d059356 100644
--- a/contrib/systemd/qemu-guest-agent.service
+++ b/contrib/systemd/qemu-guest-agent.service
@@ -2,6 +2,7 @@
 Description=QEMU Guest Agent
 BindTo=dev-virtio\x2dports-org.qemu.guest_agent.0.device
 After=dev-virtio\x2dports-org.qemu.guest_agent.0.device
+After=NetworkManager.service
 
 [Service]
 ExecStart=-/usr/bin/qemu-ga
-- 
2.34.1


