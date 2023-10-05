Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1051D7B9C2B
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 11:30:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoKgB-0007zI-UF; Thu, 05 Oct 2023 05:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoKg3-0007x5-VM
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 05:29:52 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoKg0-0005PY-3U
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 05:29:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id E9A3A63686;
 Thu,  5 Oct 2023 12:29:41 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b584::1:2f])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id RTUHmS4OouQ0-fEc7I1Vw; Thu, 05 Oct 2023 12:29:41 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696498181;
 bh=zpIP28cEqxYdagHQ8Cy7MX2T3ULympF8csjZDoMQXhw=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=paCwgKGkVgd+7W9SfBz0njL5iSh/CNHK1qO/7EuDWmZNIlltJzjuhmwoOYlODjsjV
 AqUi+BZ9vwMQLCMq9RxxR8yWjKCxm5H6zmJACLhFG64Zd/6hB2xznKThJ+RwQkW72z
 tnKgyoMsPVjCh1BiGqY1iojrAuqQiR6Q2zT9kzWk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, philmd@linaro.org, den-plotnikov@yandex-team.ru,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v8 1/4] qapi/qdev.json: unite DEVICE_* event data into single
 structure
Date: Thu,  5 Oct 2023 12:29:23 +0300
Message-Id: <20231005092926.56231-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005092926.56231-1-vsementsov@yandex-team.ru>
References: <20231005092926.56231-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

DEVICE_DELETED and DEVICE_UNPLUG_GUEST_ERROR has equal data, let's
refactor it to one structure. That also helps to add new events
consistently.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qapi/qdev.json | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/qapi/qdev.json b/qapi/qdev.json
index 6bc5a733b8..2899fac837 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -116,6 +116,35 @@
 ##
 { 'command': 'device_del', 'data': {'id': 'str'} }
 
+##
+# @DeviceAndPath:
+#
+# In events we designate devices by both their ID (if the device has
+# one) and QOM path.
+#
+# @device: the device's ID if it has one
+#
+# @path: the device's QOM path
+#
+# Since: 8.2
+##
+
+# Rationale
+#
+# Why we need ID?  User specify ID in device_add command and in
+# command line and expects same identifier in the event data.
+#
+# Why we need QOM path?  Some devices don't have ID and we still want
+# to emit events for them.
+#
+# So, we have a bit of redundancy, as QOM path for device that has
+# ID is always /machine/peripheral/ID.  But that's hard to change
+# keeping both simple interface for most users and universality for
+# the generic case.
+
+{ 'struct': 'DeviceAndPath',
+  'data': { '*device': 'str', 'path': 'str' } }
+
 ##
 # @DEVICE_DELETED:
 #
@@ -124,10 +153,6 @@
 # ID. Device removal can be initiated by the guest or by HMP/QMP
 # commands.
 #
-# @device: the device's ID if it has one
-#
-# @path: the device's QOM path
-#
 # Since: 1.5
 #
 # Example:
@@ -137,8 +162,7 @@
 #                "path": "/machine/peripheral/virtio-net-pci-0" },
 #      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
 ##
-{ 'event': 'DEVICE_DELETED',
-  'data': { '*device': 'str', 'path': 'str' } }
+{ 'event': 'DEVICE_DELETED', 'data': 'DeviceAndPath' }
 
 ##
 # @DEVICE_UNPLUG_GUEST_ERROR:
@@ -146,10 +170,6 @@
 # Emitted when a device hot unplug fails due to a guest reported
 # error.
 #
-# @device: the device's ID if it has one
-#
-# @path: the device's QOM path
-#
 # Since: 6.2
 #
 # Example:
@@ -159,5 +179,4 @@
 #                "path": "/machine/peripheral/core1" },
 #      "timestamp": { "seconds": 1615570772, "microseconds": 202844 } }
 ##
-{ 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
-  'data': { '*device': 'str', 'path': 'str' } }
+{ 'event': 'DEVICE_UNPLUG_GUEST_ERROR', 'data': 'DeviceAndPath' }
-- 
2.34.1


