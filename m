Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ADBA0B04B
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Jan 2025 08:51:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXFDX-0005lT-3X; Mon, 13 Jan 2025 02:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1tXFCw-0005bw-BP
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 02:49:59 -0500
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1tXFCu-0003XH-D0
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 02:49:58 -0500
X-ASG-Debug-ID: 1736754592-086e2312d5ae3d0001-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx1.zhaoxin.com with ESMTP id aTtYNNpfSkhe5gLx (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 13 Jan 2025 15:49:52 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 13 Jan
 2025 15:49:52 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::1f6:1739:ec6a:3d64]) by
 ZXSHMBX1.zhaoxin.com ([fe80::1f6:1739:ec6a:3d64%7]) with mapi id
 15.01.2507.039; Mon, 13 Jan 2025 15:49:52 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ewan-server.zhaoxin.com (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 15:44:15 +0800
From: EwanHai <ewanhai-oc@zhaoxin.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>,
 <rockcui@zhaoxin.com>, <louisqi@zhaoxin.com>, <liamni@zhaoxin.com>,
 <frankzhu@zhaoxin.com>
Subject: [PATCH v5 4/4] target/i386: Mask CMPLegacy bit in
 CPUID[0x80000001].ECX for Zhaoxin CPUs
Date: Mon, 13 Jan 2025 02:44:13 -0500
X-ASG-Orig-Subj: [PATCH v5 4/4] target/i386: Mask CMPLegacy bit in
 CPUID[0x80000001].ECX for Zhaoxin CPUs
Message-ID: <20250113074413.297793-5-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113074413.297793-1-ewanhai-oc@zhaoxin.com>
References: <20250113074413.297793-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 1/13/2025 3:49:51 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1736754592
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2287
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

Zhaoxin CPUs (including vendors "Shanghai" and "Centaurhauls") handle the
CMPLegacy bit similarly to Intel CPUs. Therefore, this commit masks the
CMPLegacy bit in CPUID[0x80000001].ECX for Zhaoxin CPUs, just as it is done
for Intel CPUs.

AMD uses the CMPLegacy bit (CPUID[0x80000001].ECX.bit1) along with other CP=
UID
information to enumerate platform topology (e.g., the number of logical
processors per package). However, for Intel and other CPUs that follow Inte=
l's
behavior, CPUID[0x80000001].ECX.bit1 is reserved.

- Impact on Intel and similar CPUs:
This change has no effect on Intel and similar CPUs, as the goal is to
accurately emulate CPU CPUID information.

- Impact on Linux Guests running on Intel (and similar) vCPUs:
During boot, Linux checks if the CPU supports Hyper-Threading. For the Linu=
x
kernel before v6.9, if it detects X86_FEATURE_CMP_LEGACY, it assumes
Hyper-Threading is not supported. For Intel and similar vCPUs, if the
CMPLegacy bit is not masked in CPUID[0x80000001].ECX, Linux will incorrectl=
y
assume that Hyper-Threading is not supported, even if the vCPU does support=
 it.

Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6b20e7c64a..3e78ca28cc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7090,12 +7090,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index=
, uint32_t count,
=20
         /* The Linux kernel checks for the CMPLegacy bit and
          * discards multiple thread information if it is set.
-         * So don't set it here for Intel to make Linux guests happy.
+         * So don't set it here for Intel(and other processors
+         * following Intel's behavior) to make Linux guests happy.
          */
         if (threads_per_pkg > 1) {
-            if (env->cpuid_vendor1 !=3D CPUID_VENDOR_INTEL_1 ||
-                env->cpuid_vendor2 !=3D CPUID_VENDOR_INTEL_2 ||
-                env->cpuid_vendor3 !=3D CPUID_VENDOR_INTEL_3) {
+            if (!IS_INTEL_CPU(env) && !IS_ZHAOXIN_CPU(env)) {
                 *ecx |=3D 1 << 1;    /* CmpLegacy bit */
             }
         }
--=20
2.34.1


