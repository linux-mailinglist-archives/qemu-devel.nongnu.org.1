Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DCF75ABBE
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 12:14:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMQfW-0006ka-S6; Thu, 20 Jul 2023 06:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qMQfN-0006fl-Vz
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 06:13:50 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qMQfM-0003Xn-Fu
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 06:13:49 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1qMQfF-0003bl-KL; Thu, 20 Jul 2023 12:13:41 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v6 5/6] qapi: Add HV_BALLOON_STATUS_REPORT event
Date: Thu, 20 Jul 2023 12:13:02 +0200
Message-ID: <22d53a9cc8756bc39b5d951436dc276fa2c665cc.1689786474.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689786474.git.maciej.szmigiero@oracle.com>
References: <cover.1689786474.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Used by the hv-balloon driver for (optional) guest memory status reports.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 qapi/machine.json | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/qapi/machine.json b/qapi/machine.json
index 5ede977cf2bc..9649616b9ed2 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1113,6 +1113,31 @@
 { 'event': 'BALLOON_CHANGE',
   'data': { 'actual': 'int' } }
 
+##
+# @HV_BALLOON_STATUS_REPORT:
+#
+# Emitted when the hv-balloon driver receives a "STATUS" message from
+# the guest.
+#
+# @commited: the amount of memory in use inside the guest plus the amount
+#            of the memory unusable inside the guest (ballooned out,
+#            offline, etc.)
+#
+# @available: the amount of the memory inside the guest available for new
+#             allocations ("free")
+#
+# Since: TBD
+#
+# Example:
+#
+# <- { "event": "HV_BALLOON_STATUS_REPORT",
+#      "data": { "commited": 816640000, "available": 3333054464 },
+#      "timestamp": { "seconds": 1600295492, "microseconds": 661044 } }
+#
+##
+{ 'event': 'HV_BALLOON_STATUS_REPORT',
+  'data': { 'commited': 'size', 'available': 'size' } }
+
 ##
 # @MemoryInfo:
 #

