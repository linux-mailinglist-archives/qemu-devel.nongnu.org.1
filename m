Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D84C7739FA
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 13:58:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTLLv-0002iO-EK; Tue, 08 Aug 2023 07:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qTLLt-0002cd-Q7
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:58:17 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qTLLr-0001XR-VI
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:58:17 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RKs6p024nz67bhy;
 Tue,  8 Aug 2023 19:54:25 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 12:58:13 +0100
To: <qemu-devel@nongnu.org>
CC: Gavin Shan <gshan@redhat.com>, <linuxarm@huawei.com>, James Morse
 <james.morse@arm.com>, "peter . maydell @ linaro . org"
 <peter.maydell@linaro.org>, <zhao1.liu@linux.intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Shameerali Kolothum
 Thodi <shameerali.kolothum.thodi@huawei.com>, Yicong Yang
 <yangyicong@huawei.com>
Subject: [RFC PATCH 2/5] HACK: target/arm/tcg: Add some more caches to cpu=max
Date: Tue, 8 Aug 2023 12:57:10 +0100
Message-ID: <20230808115713.2613-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808115713.2613-1-Jonathan.Cameron@huawei.com>
References: <20230808115713.2613-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Used to drive the MPAM cache intialization and to exercise more
of the PPTT cache entry generation code. Perhaps a default
L3 cache is acceptable for max?

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 target/arm/tcg/cpu64.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 8019f00bc3..2af67739f6 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -711,6 +711,17 @@ void aarch64_max_tcg_initfn(Object *obj)
     uint64_t t;
     uint32_t u;
 
+    /*
+     * Expanded cache set
+     */
+    cpu->clidr = 0x8204923; /* 4 4 4 4 3 in 3 bit fields */
+    cpu->ccsidr[0] = 0x000000ff0000001aull; /* 64KB L1 dcache */
+    cpu->ccsidr[1] = 0x000000ff0000001aull; /* 64KB L1 icache */
+    cpu->ccsidr[2] = 0x000007ff0000003aull; /* 1MB L2 unified cache */
+    cpu->ccsidr[4] = 0x000007ff0000007cull; /* 2MB L3 cache 128B line */
+    cpu->ccsidr[6] = 0x00007fff0000007cull; /* 16MB L4 cache 128B line */
+    cpu->ccsidr[8] = 0x0007ffff0000007cull; /* 2048MB L5 cache 128B line */
+
     /*
      * Reset MIDR so the guest doesn't mistake our 'max' CPU type for a real
      * one and try to apply errata workarounds or use impdef features we
@@ -828,6 +839,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR2, BBM, 2);      /* FEAT_BBM at level 2 */
     t = FIELD_DP64(t, ID_AA64MMFR2, EVT, 2);      /* FEAT_EVT */
     t = FIELD_DP64(t, ID_AA64MMFR2, E0PD, 1);     /* FEAT_E0PD */
+    t = FIELD_DP64(t, ID_AA64MMFR2, CCIDX, 1);      /* FEAT_TTCNP */
     cpu->isar.id_aa64mmfr2 = t;
 
     t = cpu->isar.id_aa64zfr0;
-- 
2.39.2


