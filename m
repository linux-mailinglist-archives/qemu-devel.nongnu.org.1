Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B58A379FCF2
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 09:13:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qggVm-0002ol-BY; Thu, 14 Sep 2023 03:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qggVe-0002oH-Vf
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:11:32 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qggVb-00066N-Ut
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694675487; x=1726211487;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ge7Ux0L98nZAT4BdO1zTFkQrOwTQXrhDDcBB51V5G1k=;
 b=GC27XUtaE66WOtsjJ16pD41AUmT426qbLvLW7iox5wzCbp5LmJ5AY61z
 tTL9mQPWYhZOM0yO+uEK681H8RXL9GYIKeANP9PidW5fXkaZMKNjC4hhN
 mRSepjKzmfMH0Rqkvi5N50p/nFq2z1o6c+7aykq/HPuqHT/JoOpC4Q/o8
 Ytucy1DGSw3YnvxImA7QQU9S09Vb2Jc7LF419Ck3YspofuD6xkRQyKHt5
 0FDYNEOw3Pyzd1ID0QByRhQrlPkqJhwn0YeHg1pYHXmxd4o0TSDeVT0bv
 LHuQIE3UiNKN4bkCWS/Qo1BQrHbqlYs2yVVWAhGUqbfwHHjQioOpnGwgQ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="359135843"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="359135843"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2023 00:11:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="779526084"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="779526084"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 14 Sep 2023 00:11:21 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Babu Moger <babu.moger@amd.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>
Subject: [PATCH v4 02/21] tests: Rename test-x86-cpuid.c to test-x86-topo.c
Date: Thu, 14 Sep 2023 15:21:40 +0800
Message-Id: <20230914072159.1177582-3-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
References: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.151;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

The tests in this file actually test the APIC ID combinations.
Rename to test-x86-topo.c to make its name more in line with its
actual content.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
Changes since v3:
 * Modify the description in commit message to emphasize this file tests
   APIC ID combinations. (Babu)

Changes since v1:
 * Rename test-x86-apicid.c to test-x86-topo.c. (Yanan)
---
 MAINTAINERS                                      | 2 +-
 tests/unit/meson.build                           | 4 ++--
 tests/unit/{test-x86-cpuid.c => test-x86-topo.c} | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename tests/unit/{test-x86-cpuid.c => test-x86-topo.c} (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 00562f924f7a..eaaa041804b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1721,7 +1721,7 @@ F: include/hw/southbridge/ich9.h
 F: include/hw/southbridge/piix.h
 F: hw/isa/apm.c
 F: include/hw/isa/apm.h
-F: tests/unit/test-x86-cpuid.c
+F: tests/unit/test-x86-topo.c
 F: tests/qtest/test-x86-cpuid-compat.c
 
 PC Chipset
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 0299ef6906cc..bb6f8177341d 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -21,8 +21,8 @@ tests = {
   'test-opts-visitor': [testqapi],
   'test-visitor-serialization': [testqapi],
   'test-bitmap': [],
-  # all code tested by test-x86-cpuid is inside topology.h
-  'test-x86-cpuid': [],
+  # all code tested by test-x86-topo is inside topology.h
+  'test-x86-topo': [],
   'test-cutils': [],
   'test-div128': [],
   'test-shift128': [],
diff --git a/tests/unit/test-x86-cpuid.c b/tests/unit/test-x86-topo.c
similarity index 99%
rename from tests/unit/test-x86-cpuid.c
rename to tests/unit/test-x86-topo.c
index bfabc0403a1a..2b104f86d7c2 100644
--- a/tests/unit/test-x86-cpuid.c
+++ b/tests/unit/test-x86-topo.c
@@ -1,5 +1,5 @@
 /*
- *  Test code for x86 CPUID and Topology functions
+ *  Test code for x86 APIC ID and Topology functions
  *
  *  Copyright (c) 2012 Red Hat Inc.
  *
-- 
2.34.1


