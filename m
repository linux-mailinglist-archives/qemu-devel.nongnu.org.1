Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9E0927502
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jul 2024 13:26:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPKan-0007kU-0N; Thu, 04 Jul 2024 07:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sPKaj-0007ed-9H
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:25:33 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sPKab-0002tT-6U
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:25:32 -0400
X-ASG-Debug-ID: 1720092313-086e2311071449f0002-jgbH7p
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by
 mx1.zhaoxin.com with ESMTP id zJBJ806LXnzdugDx (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Thu, 04 Jul 2024 19:25:14 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 19:25:13 +0800
Received: from ewan-server.zhaoxin.com (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 19:25:13 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
From: EwanHai <ewanhai-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <xiaoyao.li@intel.com>
CC: <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>,
 <rockcui@zhaoxin.com>, <louisqi@zhaoxin.com>, <liamni@zhaoxin.com>,
 <frankzhu@zhaoxin.com>
Subject: [PATCH v2 2/4] target/i386: Add CPUID leaf 0xC000_0001 EDX definitions
Date: Thu, 4 Jul 2024 07:25:09 -0400
X-ASG-Orig-Subj: [PATCH v2 2/4] target/i386: Add CPUID leaf 0xC000_0001 EDX
 definitions
Message-ID: <20240704112511.184257-3-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704112511.184257-1-ewanhai-oc@zhaoxin.com>
References: <20240704112511.184257-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1720092313
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1581
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.127153
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add new CPUID feature flags for various Zhaoxin PadLock extensions.
These definitions will be used for Zhaoxin CPU models.

Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
---
 target/i386/cpu.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 07e8353f36..935bf96451 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -989,6 +989,27 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 /* CPUID[0x80000007].EDX flags: */
 #define CPUID_APM_INVTSC       (1U << 8)
 
+/* "rng" RNG present (xstore) */
+#define CPUID_C000_0001_EDX_XSTORE             (1U << 2)
+/* "rng_en" RNG enabled */
+#define CPUID_C000_0001_EDX_XSTORE_EN          (1U << 3)
+/* "ace" on-CPU crypto (xcrypt) */
+#define CPUID_C000_0001_EDX_XCRYPT             (1U << 6)
+/* "ace_en" on-CPU crypto enabled */
+#define CPUID_C000_0001_EDX_XCRYPT_EN          (1U << 7)
+/* Advanced Cryptography Engine v2 */
+#define CPUID_C000_0001_EDX_ACE2               (1U << 8)
+/* ACE v2 enabled */
+#define CPUID_C000_0001_EDX_ACE2_EN            (1U << 9)
+/* PadLock Hash Engine */
+#define CPUID_C000_0001_EDX_PHE                (1U << 10)
+/* PHE enabled */
+#define CPUID_C000_0001_EDX_PHE_EN             (1U << 11)
+/* PadLock Montgomery Multiplier */
+#define CPUID_C000_0001_EDX_PMM                (1U << 12)
+/* PMM enabled */
+#define CPUID_C000_0001_EDX_PMM_EN             (1U << 13)
+
 #define CPUID_VENDOR_SZ      12
 
 #define CPUID_VENDOR_INTEL_1 0x756e6547 /* "Genu" */
-- 
2.34.1


