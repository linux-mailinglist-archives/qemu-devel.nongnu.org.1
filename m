Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 558EBBCF64C
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Oct 2025 16:06:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7aE9-0005Bg-Ff; Sat, 11 Oct 2025 10:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDi-0004Y8-SF
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:05:19 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDZ-0005Q5-OA
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:05:14 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 1A4FEC0195;
 Sat, 11 Oct 2025 17:04:52 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id h4NOTl1FrqM0-xpNNeoJj; Sat, 11 Oct 2025 17:04:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191491;
 bh=h6Ea4/j5Ei56p6QrRogXcVDfqdofZLzefU6CuONpdcs=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=tk00PEbBknzE33Gkq5AKeq0QKmBYiigobN6zwGQ5Gr8QrVx2GJtPLDT/jQzlZpqaP
 EAxcHvRPMZRT7huYw272r99YV3QPv1/vtKgNYhTP7XduzlbhKrzxPuRyNk/sBWKR9S
 aA8O4nbvZNKDrkKeeGHcAnBJ/R55dDwZ+nqd9vkE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 13/33] qapi/machine.json: docs: width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 17:04:19 +0300
Message-ID: <20251011140441.297246-14-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011140441.297246-1-vsementsov@yandex-team.ru>
References: <20251011140441.297246-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qapi/machine.json | 59 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 038eab281c..4d36cd35c3 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -225,7 +225,8 @@
 #
 # .. qmp-example::
 #
-#     -> { "execute": "query-machines", "arguments": { "compat-props": true } }
+#     -> { "execute": "query-machines", "arguments": { "compat-props":
+#     true } }
 #     <- { "return": [
 #               {
 #                  "hotpluggable-cpus": true,
@@ -318,7 +319,8 @@
 # .. qmp-example::
 #
 #     -> { "execute": "query-uuid" }
-#     <- { "return": { "UUID": "550e8400-e29b-41d4-a716-446655440000" } }
+#     <- { "return": { "UUID": "550e8400-e29b-41d4-a716-
+#     446655440000" } }
 ##
 { 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': true }
 
@@ -620,7 +622,8 @@
 ##
 # @NumaCpuOptions:
 #
-# Option "-numa cpu" overrides default cpu to node mapping.  It accepts
+# Option "-numa cpu" overrides default cpu to node mapping.  It
+#     accepts
 # the same set of cpu properties as returned by
 # `query-hotpluggable-cpus[].props <query-hotpluggable-cpus>`, where
 # node-id could be used to override default node mapping.
@@ -686,7 +689,8 @@
 # Set the system locality latency and bandwidth information between
 # Initiator and Target proximity Domains.
 #
-# For more information about `NumaHmatLBOptions`, see chapter 5.2.27.4:
+# For more information about `NumaHmatLBOptions`, see chapter
+#     5.2.27.4:
 # Table 5-146 of ACPI 6.3 spec.
 #
 # @initiator: the Initiator Proximity Domain.
@@ -743,7 +747,8 @@
 # Cache write policy in the Memory Side Cache Information Structure of
 # HMAT
 #
-# For more information of `HmatCacheWritePolicy`, see chapter 5.2.27.5:
+# For more information of `HmatCacheWritePolicy`, see chapter
+#     5.2.27.5:
 # Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
 #
 # @none: None (no memory side cache in this proximity domain, or cache
@@ -763,8 +768,8 @@
 #
 # Set the memory side cache information for a given memory domain.
 #
-# For more information of `NumaHmatCacheOptions`, see chapter 5.2.27.5:
-# Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
+# For more information of `NumaHmatCacheOptions`, see chapter
+# 5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
 #
 # @node-id: the memory proximity domain to which the memory belongs.
 #
@@ -1023,10 +1028,13 @@
 #
 #     -> { "execute": "query-hotpluggable-cpus" }
 #     <- {"return": [
-#          { "props": { "core-id": 8 }, "type": "POWER8-spapr-cpu-core",
+#          { "props": { "core-id": 8 },
+#            "type": "POWER8-spapr-cpu-core",
 #            "vcpus-count": 1 },
-#          { "props": { "core-id": 0 }, "type": "POWER8-spapr-cpu-core",
-#            "vcpus-count": 1, "qom-path": "/machine/unattached/device[0]"}
+#          { "props": { "core-id": 0 },
+#            "type": "POWER8-spapr-cpu-core",
+#            "vcpus-count": 1,
+#            "qom-path": "/machine/unattached/device[0]"}
 #        ]}
 #
 # .. qmp-example::
@@ -1110,7 +1118,8 @@
 #
 #    ::
 #
-#      -> { "execute": "balloon", "arguments": { "value": 536870912 } }
+#      -> { "execute": "balloon",
+#           "arguments": { "value": 536870912 } }
 #      <- { "return": {} }
 #
 #    With a 2.5GiB guest this command inflated the ballon to 3GiB.
@@ -1169,7 +1178,8 @@
 #
 #     <- { "event": "BALLOON_CHANGE",
 #          "data": { "actual": 944766976 },
-#          "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
+#          "timestamp": { "seconds": 1267020223,
+#                         "microseconds": 435656 } }
 ##
 { 'event': 'BALLOON_CHANGE',
   'data': { 'actual': 'int' } }
@@ -1228,8 +1238,10 @@
 # .. qmp-example::
 #
 #     <- { "event": "HV_BALLOON_STATUS_REPORT",
-#          "data": { "committed": 816640000, "available": 3333054464 },
-#          "timestamp": { "seconds": 1600295492, "microseconds": 661044 } }
+#          "data": { "committed": 816640000,
+#                    "available": 3333054464 },
+#          "timestamp": { "seconds": 1600295492,
+#                         "microseconds": 661044 } }
 ##
 { 'event': 'HV_BALLOON_STATUS_REPORT',
   'data': 'HvBalloonInfo' }
@@ -1262,7 +1274,8 @@
 # .. qmp-example::
 #
 #     -> { "execute": "query-memory-size-summary" }
-#     <- { "return": { "base-memory": 4294967296, "plugged-memory": 0 } }
+#     <- { "return": { "base-memory": 4294967296,
+#                      "plugged-memory": 0 } }
 #
 # Since: 2.11
 ##
@@ -1577,7 +1590,8 @@
 #     <- { "event": "MEMORY_DEVICE_SIZE_CHANGE",
 #          "data": { "id": "vm0", "size": 1073741824,
 #                    "qom-path": "/machine/unattached/device[2]" },
-#          "timestamp": { "seconds": 1588168529, "microseconds": 201316 } }
+#          "timestamp": { "seconds": 1588168529,
+#                         "microseconds": 201316 } }
 ##
 { 'event': 'MEMORY_DEVICE_SIZE_CHANGE',
   'data': { '*id': 'str', 'size': 'size', 'qom-path' : 'str'} }
@@ -2000,7 +2014,8 @@
 #   `query-cpu-definitions`.)
 # * "-cpu" arguments and global properties: arguments to the -cpu
 #   option and global properties may affect expansion of CPU models.
-#   Using `query-cpu-model-expansion` while using these is not advised.
+#   Using `query-cpu-model-expansion` while using these is not
+#   advised.
 #
 # Some architectures may not support comparing CPU models.  s390x
 # supports comparing CPU models.
@@ -2054,7 +2069,8 @@
 #   `query-cpu-definitions`.)
 # * "-cpu" arguments and global properties: arguments to the -cpu
 #   option and global properties may affect expansion of CPU models.
-#   Using `query-cpu-model-expansion` while using these is not advised.
+#   Using `query-cpu-model-expansion` while using these is not
+#   advised.
 #
 # Some architectures may not support baselining CPU models.  s390x
 # supports baselining CPU models.
@@ -2085,8 +2101,8 @@
 #
 # @model: the expanded `CpuModelInfo`.
 #
-# @deprecated-props: an optional list of properties that are flagged as
-#     deprecated by the CPU vendor.  The list depends on the
+# @deprecated-props: an optional list of properties that are flagged
+#     as deprecated by the CPU vendor.  The list depends on the
 #     `CpuModelExpansionType`: "static" properties are a subset of the
 #     enabled-properties for the expanded model; "full" properties are
 #     a set of properties that are deprecated across all models for
@@ -2122,7 +2138,8 @@
 #   `query-cpu-definitions`.)
 # * "-cpu" arguments and global properties: arguments to the -cpu
 #   option and global properties may affect expansion of CPU models.
-#   Using `query-cpu-model-expansion` while using these is not advised.
+#   Using `query-cpu-model-expansion` while using these is not
+#   advised.
 #
 # Some architectures may not support all expansion types.  s390x
 # supports "full" and "static".  Arm only supports "full".
-- 
2.48.1


