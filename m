Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D82A0B04E
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Jan 2025 08:51:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXFDT-0005jy-QB; Mon, 13 Jan 2025 02:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1tXFCw-0005bv-2W
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 02:49:58 -0500
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1tXFCs-0003Wr-MH
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 02:49:57 -0500
X-ASG-Debug-ID: 1736754583-086e2312d7ae3c0001-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx1.zhaoxin.com with ESMTP id sMJmHG6wi8ANjtb2 (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 13 Jan 2025 15:49:43 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 13 Jan
 2025 15:49:43 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::1f6:1739:ec6a:3d64]) by
 ZXSHMBX1.zhaoxin.com ([fe80::1f6:1739:ec6a:3d64%7]) with mapi id
 15.01.2507.039; Mon, 13 Jan 2025 15:49:43 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ewan-server.zhaoxin.com (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 15:44:14 +0800
From: EwanHai <ewanhai-oc@zhaoxin.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>,
 <rockcui@zhaoxin.com>, <louisqi@zhaoxin.com>, <liamni@zhaoxin.com>,
 <frankzhu@zhaoxin.com>
Subject: [PATCH v5 1/4] target/i386: Add support for Zhaoxin CPU vendor
 identification
Date: Mon, 13 Jan 2025 02:44:10 -0500
X-ASG-Orig-Subj: [PATCH v5 1/4] target/i386: Add support for Zhaoxin CPU
 vendor identification
Message-ID: <20250113074413.297793-2-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113074413.297793-1-ewanhai-oc@zhaoxin.com>
References: <20250113074413.297793-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 1/13/2025 3:49:41 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1736754583
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2488
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.135768
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Zhaoxin currently uses two vendors: "Shanghai" and "Centaurhauls".
It is important to note that the latter now belongs to Zhaoxin. Therefore,
this patch replaces CPUID_VENDOR_VIA with CPUID_VENDOR_ZHAOXIN1.

The previous CPUID_VENDOR_VIA macro was only defined but never used in
QEMU, making this change straightforward.

Additionally, the IS_ZHAOXIN_CPU macro has been added to simplify the
checks for Zhaoxin CPUs.

Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index dbd8f1ffc7..2192e1454e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1081,7 +1081,16 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *=
cpu, FeatureWord w);
 #define CPUID_VENDOR_AMD_3   0x444d4163 /* "cAMD" */
 #define CPUID_VENDOR_AMD   "AuthenticAMD"
=20
-#define CPUID_VENDOR_VIA   "CentaurHauls"
+#define CPUID_VENDOR_ZHAOXIN1_1 0x746E6543 /* "Cent" */
+#define CPUID_VENDOR_ZHAOXIN1_2 0x48727561 /* "aurH" */
+#define CPUID_VENDOR_ZHAOXIN1_3 0x736C7561 /* "auls" */
+
+#define CPUID_VENDOR_ZHAOXIN2_1 0x68532020 /* "  Sh" */
+#define CPUID_VENDOR_ZHAOXIN2_2 0x68676E61 /* "angh" */
+#define CPUID_VENDOR_ZHAOXIN2_3 0x20206961 /* "ai  " */
+
+#define CPUID_VENDOR_ZHAOXIN1   "CentaurHauls"
+#define CPUID_VENDOR_ZHAOXIN2   "  Shanghai  "
=20
 #define CPUID_VENDOR_HYGON    "HygonGenuine"
=20
@@ -1091,6 +1100,15 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *=
cpu, FeatureWord w);
 #define IS_AMD_CPU(env) ((env)->cpuid_vendor1 =3D=3D CPUID_VENDOR_AMD_1 &&=
 \
                          (env)->cpuid_vendor2 =3D=3D CPUID_VENDOR_AMD_2 &&=
 \
                          (env)->cpuid_vendor3 =3D=3D CPUID_VENDOR_AMD_3)
+#define IS_ZHAOXIN1_CPU(env) \
+    ((env)->cpuid_vendor1 =3D=3D CPUID_VENDOR_ZHAOXIN1_1 && \
+     (env)->cpuid_vendor2 =3D=3D CPUID_VENDOR_ZHAOXIN1_2 && \
+     (env)->cpuid_vendor3 =3D=3D CPUID_VENDOR_ZHAOXIN1_3)
+#define IS_ZHAOXIN2_CPU(env) \
+    ((env)->cpuid_vendor1 =3D=3D CPUID_VENDOR_ZHAOXIN2_1 && \
+     (env)->cpuid_vendor2 =3D=3D CPUID_VENDOR_ZHAOXIN2_2 && \
+     (env)->cpuid_vendor3 =3D=3D CPUID_VENDOR_ZHAOXIN2_3)
+#define IS_ZHAOXIN_CPU(env) (IS_ZHAOXIN1_CPU(env) || IS_ZHAOXIN2_CPU(env))
=20
 #define CPUID_MWAIT_IBE     (1U << 1) /* Interrupts can exit capability */
 #define CPUID_MWAIT_EMX     (1U << 0) /* enumeration supported */
--=20
2.34.1


