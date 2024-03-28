Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B2088A5A9
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Mar 2024 16:02:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rolq3-0003Cs-S2; Mon, 25 Mar 2024 11:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rolpl-00038F-GY
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:02:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rolpi-00052K-J3
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711378913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Np8x02mslydTv544dMKcBUtfJb5rzw/F0i7sjBgw0xw=;
 b=bGZ8U29bEVQ6p1yadz2shsH6UHq1f8wtxP8GhsN1P/wfkUhigcCWvdc/1UR1/8NSe/Vur5
 DKBIyVGXbf1Jw2tzStkvbZhWsilm7vzOhNEM7MhnfK8zHvRO96dNX1qI7vul3/kHwu1ap4
 8trXO5LR3pQwhDMt9UsiSdWdUg42XMQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-7Hs1B1RZNDitXO_767ezBg-1; Mon, 25 Mar 2024 11:01:49 -0400
X-MC-Unique: 7Hs1B1RZNDitXO_767ezBg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 329FE868677;
 Mon, 25 Mar 2024 15:01:49 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64695492BC4;
 Mon, 25 Mar 2024 15:01:46 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v1] qapi: document parameters of query-cpu-model-* QAPI
 commands
Date: Mon, 25 Mar 2024 16:01:41 +0100
Message-ID: <20240325150141.342720-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Let's document the parameters of these commands, so we can remove them
from the "documentation-exceptions" list.

While at it, extend the "Returns:" documentation as well, fixing a wrong
use of CpuModelBaselineInfo vs. CpuModelCompareInfo for
query-cpu-model-comparison.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
Cc: Yanan Wang <wangyanan55@huawei.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 qapi/machine-target.json | 46 +++++++++++++++++++++++++++-------------
 qapi/pragma.json         |  3 ---
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 519adf3220..7883616cce 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -124,11 +124,12 @@
 ##
 # @query-cpu-model-comparison:
 #
-# Compares two CPU models, returning how they compare in a specific
-# configuration.  The results indicates how both models compare
-# regarding runnability.  This result can be used by tooling to make
-# decisions if a certain CPU model will run in a certain configuration
-# or if a compatible CPU model has to be created by baselining.
+# Compares two CPU models, @modela and @modelb, returning how they
+# compare in a specific configuration.  The results indicates how
+# both models compare regarding runnability.  This result can be
+# used by tooling to make decisions if a certain CPU model will
+# run in a certain configuration or if a compatible CPU model has
+# to be created by baselining.
 #
 # Usually, a CPU model is compared against the maximum possible CPU
 # model of a certain configuration (e.g. the "host" model for KVM).
@@ -154,7 +155,14 @@
 # Some architectures may not support comparing CPU models.  s390x
 # supports comparing CPU models.
 #
-# Returns: a CpuModelBaselineInfo
+# @modela: description of the first CPU model to compare, referred to as
+#     "model A" in CpuModelCompareResult
+#
+# @modelb: description of the second CPU model to compare, referred to as
+#     "model B" in CpuModelCompareResult
+#
+# Returns: a CpuModelCompareInfo, describing how both CPU models
+#     compare
 #
 # Errors:
 #     - if comparing CPU models is not supported
@@ -175,9 +183,9 @@
 ##
 # @query-cpu-model-baseline:
 #
-# Baseline two CPU models, creating a compatible third model.  The
-# created model will always be a static, migration-safe CPU model (see
-# "static" CPU model expansion for details).
+# Baseline two CPU models, @modela and @modelb, creating a compatible
+# third model.  The created model will always be a static,
+# migration-safe CPU model (see "static" CPU model expansion for details).
 #
 # This interface can be used by tooling to create a compatible CPU
 # model out two CPU models.  The created CPU model will be identical
@@ -204,7 +212,11 @@
 # Some architectures may not support baselining CPU models.  s390x
 # supports baselining CPU models.
 #
-# Returns: a CpuModelBaselineInfo
+# @modela: description of the first CPU model to baseline
+#
+# @modelb: description of the second CPU model to baseline
+#
+# Returns: a CpuModelBaselineInfo, describing the baselined CPU model
 #
 # Errors:
 #     - if baselining CPU models is not supported
@@ -243,10 +255,10 @@
 ##
 # @query-cpu-model-expansion:
 #
-# Expands a given CPU model (or a combination of CPU model +
-# additional options) to different granularities, allowing tooling to
-# get an understanding what a specific CPU model looks like in QEMU
-# under a certain configuration.
+# Expands a given CPU model, @model, (or a combination of CPU model +
+# additional options) to different granularities, specified by
+# @type, allowing tooling to get an understanding what a specific
+# CPU model looks like in QEMU under a certain configuration.
 #
 # This interface can be used to query the "host" CPU model.
 #
@@ -269,7 +281,11 @@
 # Some architectures may not support all expansion types.  s390x
 # supports "full" and "static". Arm only supports "full".
 #
-# Returns: a CpuModelExpansionInfo
+# @model: description of the CPU model to expand
+#
+# @type: expansion type, specifying how to expand the CPU model
+#
+# Returns: a CpuModelExpansionInfo, describing the expanded CPU model
 #
 # Errors:
 #     - if expanding CPU models is not supported
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 6929ab776e..0d82bc1a03 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -90,9 +90,6 @@
         'XDbgBlockGraph',
         'YankInstanceType',
         'blockdev-reopen',
-        'query-cpu-model-baseline',
-        'query-cpu-model-comparison',
-        'query-cpu-model-expansion',
         'query-rocker',
         'query-rocker-ports',
         'query-stats-schemas',
-- 
2.43.2


