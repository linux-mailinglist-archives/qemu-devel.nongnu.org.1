Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8540C94EAA0
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Aug 2024 12:21:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdSAt-0005Sq-JD; Mon, 12 Aug 2024 06:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sdSAq-0005PS-GO
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 06:21:12 -0400
Received: from mx2.zhaoxin.com ([203.110.167.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sdSAo-0002F3-Pl
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 06:21:12 -0400
X-ASG-Debug-ID: 1723458064-1eb14e31a730430001-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx2.zhaoxin.com with ESMTP id OQAetbyA5AniMyGz (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 12 Aug 2024 18:21:04 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 12 Aug
 2024 18:21:03 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::dcd1:d46d:263:77e]) by
 ZXSHMBX1.zhaoxin.com ([fe80::dcd1:d46d:263:77e%7]) with mapi id
 15.01.2507.039; Mon, 12 Aug 2024 18:21:03 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ewan-server.zhaoxin.com (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 Aug
 2024 18:14:35 +0800
From: EwanHai <ewanhai-oc@zhaoxin.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <xiaoyao.li@intel.com>
CC: <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>,
 <rockcui@zhaoxin.com>, <louisqi@zhaoxin.com>, <liamni@zhaoxin.com>,
 <frankzhu@zhaoxin.com>
Subject: [PATCH v4 1/4] target/i386: Add support for Zhaoxin CPU vendor
 identification
Date: Mon, 12 Aug 2024 06:14:31 -0400
X-ASG-Orig-Subj: [PATCH v4 1/4] target/i386: Add support for Zhaoxin CPU
 vendor identification
Message-ID: <20240812101434.3804790-2-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812101434.3804790-1-ewanhai-oc@zhaoxin.com>
References: <20240812101434.3804790-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 8/12/2024 6:21:02 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1723458064
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2488
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.128930
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=203.110.167.99;
 envelope-from=EwanHai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
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
index c6cc035df3..29d554766f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1044,7 +1044,16 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *=
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
@@ -1054,6 +1063,15 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *=
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


