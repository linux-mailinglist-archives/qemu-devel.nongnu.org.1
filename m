Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 386BE916238
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jun 2024 11:20:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM2Kf-0006bj-AJ; Tue, 25 Jun 2024 05:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sM2Kb-0006Z5-UB
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 05:19:17 -0400
Received: from mx2.zhaoxin.com ([203.110.167.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sM2KY-0006IF-2u
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 05:19:17 -0400
X-ASG-Debug-ID: 1719307147-1eb14e2e5fbade0002-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx2.zhaoxin.com with ESMTP id oSVjF3VI6MrLfn5P (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 25 Jun 2024 17:19:07 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 17:19:07 +0800
Received: from ewan-server.zhaoxin.com (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 17:19:06 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From: EwanHai <ewanhai-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To: <pbonzini@redhat.com>
CC: <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>,
 <rockcui@zhaoxin.com>, <louisqi@zhaoxin.com>
Subject: [PATCH 1/4] target/i386: Add support for Zhaoxin/VIA CPU vendor
 identification
Date: Tue, 25 Jun 2024 05:19:02 -0400
X-ASG-Orig-Subj: [PATCH 1/4] target/i386: Add support for Zhaoxin/VIA CPU
 vendor identification
Message-ID: <20240625091905.1325205-2-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625091905.1325205-1-ewanhai-oc@zhaoxin.com>
References: <20240625091905.1325205-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1719307147
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2239
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.126733
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=203.110.167.99;
 envelope-from=EwanHai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This patch adds CPUID vendor strings and macros to identify Zhaoxin/VIA CPUs.

Changes:
- Added Zhaoxin/VIA CPUID vendor strings.
- Defined CPUID_VENDOR_ZHAOXIN.
- Added IS_ZHAOXIN_CPU/IS_VIA_CPU macro.

Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
---
 target/i386/cpu.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c64ef0c1a2..3653736525 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1001,16 +1001,33 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_VENDOR_AMD_3   0x444d4163 /* "cAMD" */
 #define CPUID_VENDOR_AMD   "AuthenticAMD"
 
+#define CPUID_VENDOR_VIA_1 0x746E6543 /* "Cent" */
+#define CPUID_VENDOR_VIA_2 0x48727561 /* "aurH" */
+#define CPUID_VENDOR_VIA_3 0x736C7561 /* "auls" */
+
+#define CPUID_VENDOR_ZHAOXIN_1 0x68532020 /* "  Sh" */
+#define CPUID_VENDOR_ZHAOXIN_2 0x68676E61 /* "angh" */
+#define CPUID_VENDOR_ZHAOXIN_3 0x20206961 /* "ai  " */
+
 #define CPUID_VENDOR_VIA   "CentaurHauls"
 
 #define CPUID_VENDOR_HYGON    "HygonGenuine"
 
+#define CPUID_VENDOR_ZHAOXIN  "  Shanghai  "
+
 #define IS_INTEL_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 && \
                            (env)->cpuid_vendor2 == CPUID_VENDOR_INTEL_2 && \
                            (env)->cpuid_vendor3 == CPUID_VENDOR_INTEL_3)
 #define IS_AMD_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_AMD_1 && \
                          (env)->cpuid_vendor2 == CPUID_VENDOR_AMD_2 && \
                          (env)->cpuid_vendor3 == CPUID_VENDOR_AMD_3)
+#define IS_VIA_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_VIA_1 && \
+                         (env)->cpuid_vendor2 == CPUID_VENDOR_VIA_2 && \
+                         (env)->cpuid_vendor3 == CPUID_VENDOR_VIA_3)
+#define IS_ZHAOXIN_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_ZHAOXIN_1 && \
+                             (env)->cpuid_vendor2 == CPUID_VENDOR_ZHAOXIN_2 && \
+                             (env)->cpuid_vendor3 == CPUID_VENDOR_ZHAOXIN_3)
+
 
 #define CPUID_MWAIT_IBE     (1U << 1) /* Interrupts can exit capability */
 #define CPUID_MWAIT_EMX     (1U << 0) /* enumeration supported */
-- 
2.34.1


