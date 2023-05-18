Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 729CA708C98
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 02:03:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pznaC-00033l-8Z; Thu, 18 May 2023 20:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1pzna9-00033H-VC; Thu, 18 May 2023 20:02:53 -0400
Received: from mail-mw2nam12olkn2081e.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::81e]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1pzna8-0007Vz-9d; Thu, 18 May 2023 20:02:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8yLM4b8oL7VE3hZjkCVZqTXjpxS0RQxvn33yBZu6czl85LwDV+WzledPfRtelJqqNP1+1MWsNJddgY/ybo/X8RQSG/mvH0xYa7+X7IPJBBrKvrDoVADurHj+E+KVmuLxpFT8zJsgU73g5SqPx8myutk098kfl1E3csUNQvxrHN2MoNDI+UmziYNOQoM/+xpbUmVuDTZx2OWIwzcBbKIFqGsp/xaYGMcRBb93cVhaOTQNosVrNLJIeaJhGvp8UtBL1dVTFN6oPPMAHISA1KDcOELVMs7pNN+Zd5OndWrrlM0XB6ZOOPNqcL9xgOSio2W6qyWMnqHIlE/JOKHoWzw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4cpWkpMAOUupRGcXH2m+HZJHqWYl+KQBW/iqmATjOU=;
 b=RFA7ZClJnQnmwLH8jw9B6UKq8SJPCpu+iLM+3ckyoNINjPkoR3eBu1RkXhRsCC0/Pcpy8Yd9D3ClQC3OvcytPky5IG/x+jePZhGUt4tigkNr6/4zDVIOfFcJMUZjPYQht2sMh+crgXk9RD6ltV8NfpNhTYUkV17DcXz9W+p50mE4GDNI/F3bcU4BHiovirWnap/SklkL6T3WJGWNw+SiIklIJQGaCzv6V+6JFtb03pV9w6w9jb4+N8PGz31AR3TI11NpqSiWo6uqAPcek8ji/eDyJRvmml/uLriT3b9aAC7a980JM/XGg/5uDg6tlXLQXXVb6zfOUqhvQ4O2PusDqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4cpWkpMAOUupRGcXH2m+HZJHqWYl+KQBW/iqmATjOU=;
 b=JKTFHz4t/e3w3YxkqKmqRFFMSNIv7FHvZo02rpkPdKSpcWUd8XasX2ZdjAt1AA2qhtmwDe9g877NZi7lAcEJdpbuU89jEULgaJjbSBs5vx9cO6BKi+EQhHZMPhB1WKiFZm+uJe0T90TaKBE78dQcTF9nbPssW3z+/G5fL3bNix5HweTq0uZYbUXkZwDLmGwXjjAKseaJocz7gnLq2vNtdVRBvO17yTS/48EQB2WJRMkQnzJHhSGhUcJTKges6xTR9FvLCSj7rqBlMs/p9NUJ0lQ8iyEQiAVHpcGPkaeMoR4eNMX5RWkXX0MoNTTzCtOeP9Ft2Z57I5bkQSpTyKPA+Q==
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 BL0PR12MB5009.namprd12.prod.outlook.com (2603:10b6:208:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 00:02:49 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04%3]) with mapi id 15.20.6387.033; Fri, 19 May 2023
 00:02:49 +0000
From: Zhuojia Shen <chaosdefinition@hotmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-arm@nongnu.org,
 Zhuojia Shen <chaosdefinition@hotmail.com>
Subject: [PATCH v3 2/2] tests/tcg/aarch64: add DC CVA[D]P tests
Date: Thu, 18 May 2023 16:46:05 -0700
Message-ID: <DS7PR12MB6309EABDC2AE015967A4BE22AC7C9@DS7PR12MB6309.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518234605.276443-1-chaosdefinition@hotmail.com>
References: <20230518234605.276443-1-chaosdefinition@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Mc38/vt1sPw03lKzK68tHR8U94R5xi5r]
X-ClientProxiedBy: BYAPR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::19) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
X-Microsoft-Original-Message-ID: <20230518234605.276443-2-chaosdefinition@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|BL0PR12MB5009:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5909ed-748f-4ef2-06be-08db57fc61c5
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3nvAoS/oQTVQZ1S7Y8lGJvUWSC1Z4WfQFRVGgEs0pgIa2fyN1yW0L/4iNnOTklycN3HBnhARBmtJg2y07GLEjS/b/Am3zXwlRZyFeczhL/OwoE+NREcPsTzhVm6T41931eBzjj73wW42QbrlGULFcQS9onzJs1K/4OD5+EfPjMsuz09U6aiDFtKuoXMNl/Qa8/ugcqh3d+e75zOhuoxx2GpiOr+OSYZiXtHPcwLg60BjA6n3aGYI9OOdsXtILrtQ0HXSJD1+adMe7L6vn85pQ9QnFhfeUyahbl0jxDVYtD9rPdqIztY2BU1noNHMukJwAj0yTWpCjxFVMp3FUMHl6j63Q6XZD8s7rVBd5NlViRQyFOWve8dvF9dft7DLBeTpyiEbY8n+/8aS4bq8g/Nx0NJ+mfFPTEjLJFh154eqyFxdMppZk62kiy5UfNlT84LfjyCUGyOEo1a9mBRg9A3wSwAvuuIfr99udGuTxtpwlEHEcn4a+WZFe4Meuw0/nX/QaFGpYdxJmKEtE1llkkdNTq7Ih33t3E+tVn35qknSlKHAiZGM3Ioo12CgM7GozWudyaOneoE4FKuXtcHrnj1lMul7PDxaZmcEtaPLiHZEspotYZVa4zLb5CMpu5QePbr9R5AA7sMuEEedtZz8Nj6aBS2NxUbFJ9v1gaMZ0vE1dvb/KUYWyRRss4T/JH04EaXpq6Hw0uizJJgox9fsrUmTozbVpWUHg/It3dFnM6Eg8XhFP8hmpNHyAPdyXSP9zD9IvD1TBNyhNXDLZKjdI3PC0sX
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6qGt+MrR+qkrBh8UPjqqwOd8uxQwE6TZ9P4REAeyJNGp7aKYk+378eGkpbwELXfhei2rdPcnY2StPlCZ6oYEgU7WDUkZb+Co14L0NOw7+zGGThpNfT8i5e/iKCAhkDrfd1wCkMBzDJYMzYTpPmH8I4XB11+tnpI8OziAmq50+TZbGq9Mz1B918srmnhXaByGaISsDeRxn0/zND1srcowi6uxtY7IAa9y/cv5EM1wlywJyVCkk2+Qhz+blsp1RcfbYL1xc1tygVpU9zMWdQqrmTntehJYq+AtzYtgnn4v5c7DHQgNI0+TUeKYmGlOF3DbJ2+JgLWapATjVT53k87rllu6CXR42sfEvlY5Su01cRb1tcQ+wnTuCnAg2glA3omOIAZpoIwtnZykUxitLV5lJC0QQiS/CHr+eUsEIlrHcENJhx0qlddg2PR/2A1RmGPmaOm4Bgd375IKJIrt2yR5F9g4QdiZZ3ax1KoaNb8CLEEZmiMq1Ur2RrePcC+UJJ/m2QmzUnv4lC6HBY5hvawx5WT2ywUM5YJJNzYTW59Hi9jbc6mZ2V7dnYrG2MDzXSssXhmXejRMBWEtqAVxVCPnqNyTnxvmMq3OShHMBRg5T+SZ1VHh3QGRTDMrY2+Qb/tV
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bW+IQaxjN7p1nlK+1jb/sE0iT28lohfOBwpQyoarCBWNMz4f/5L0WprApnRU?=
 =?us-ascii?Q?jt1pTcYRYp7TTTGNtSvICHOTCVX5mEDVvq2HkeM8xr1tod4HDukWZGIYe9n/?=
 =?us-ascii?Q?GVwCGL+up0QyVUSMRZhgU8MbABNES8Hqa8vcnM3S0Iy7Y/9m87iNncVRdfjC?=
 =?us-ascii?Q?VtCDq1u31LgLpApH/A8pH1ZwMBvpwbAg50WPZ7RqRPYQfdxB2iggKXS/nzhU?=
 =?us-ascii?Q?KU86TcKjQUmTkYy603yCwSnK86QJADp1N8Mkc3SG25rN3ns2sSw9X9Lnx1qr?=
 =?us-ascii?Q?xTWON8BwWVDSIMlJkT9IkJG4TmVXRM5fnWl94D1FCR/r5Pw7y6/S020mIxMH?=
 =?us-ascii?Q?PFKaroocdyWOKgkkm2tEkxH34uI6TXCeXDZ/64BWPmINBTiQEJujAZfu30lm?=
 =?us-ascii?Q?CnfRjbXFxw1sTCwKYBxlOJ90RaVwXUcBrEWere9BPw8RztSoKYQCofMe7htW?=
 =?us-ascii?Q?xsykpKNLsRKZeSpgXuda2pAm2kfYFSEz9y70SfPO0aqLDFSlRSSYzeXyG3zS?=
 =?us-ascii?Q?mIpk5b2BtEGP4ssa18sl6krN2VqKDj3cIH1yb4g5u1n+S9gSWdqQH6uyJ2k4?=
 =?us-ascii?Q?qhBjwEkfLRjVSI0tpqJnTP9YGIzWw2mtaKcoG4AtCojB/W+TH42fu+01tyBA?=
 =?us-ascii?Q?KakuJ3CWLFpxMmXpB3N23jyjmufQwUrgUNfwr3UhUvPvia1UXeEMuamrPy6J?=
 =?us-ascii?Q?EY5M3krqIn7GYkRmj/qz9pdl+vrpM3Bl6HUyXjN8ufuRyU0W30TJoN1MaNzm?=
 =?us-ascii?Q?wf2qw2sFZQMt5HQxZAYi10RnZnUu3bFuKVLX6LPR7sEOFfy9GxR2LcCKh0Gh?=
 =?us-ascii?Q?2cXCJtPIWS9HxuVXnBJKUy4caLxTET1BZwZlRr2Vk23s9Xcq9i6Y34gQe4A0?=
 =?us-ascii?Q?Zx0emUDx0tE5TaCGwrDoylvfZShxdboyLhLqU12kWQoqRFz5GUsXVJKFaGq6?=
 =?us-ascii?Q?LtWCw1mPOoYfzz1M+3PAsVOJByMXnRR9660TaDnzOCDXXAxIseW+QXhlPKQu?=
 =?us-ascii?Q?jMMSSZGEas8OmN2RyCiff8RlgPbkM0Nji2VwalkoYDvwbCaXoWPoVpgviJHh?=
 =?us-ascii?Q?hXf4yuAy23AkOk6zCX4pRn6eUsiRGrX1BcsJwPgO8+DLK2JTVfZZwh9gnaMY?=
 =?us-ascii?Q?tu4KbHCgwzLKKwDQqlK3IRw29z+7K/oIQzb1mAdz2eqxvv/DVc5XcRIXVuQM?=
 =?us-ascii?Q?oWYNNq4eWJ5CvO7KiQPlWVrzGm5WL0MrlF19U21iLRuUhs43E18ketuS/08?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5909ed-748f-4ef2-06be-08db57fc61c5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 00:02:49.0670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5009
Received-SPF: pass client-ip=2a01:111:f400:fe5a::81e;
 envelope-from=chaosdefinition@hotmail.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Test execution of DC CVAP and DC CVADP instructions under user mode
emulation.

Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>
---
 tests/tcg/aarch64/Makefile.target | 11 ++++++
 tests/tcg/aarch64/dcpodp.c        | 58 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/dcpop.c         | 58 +++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+)
 create mode 100644 tests/tcg/aarch64/dcpodp.c
 create mode 100644 tests/tcg/aarch64/dcpop.c

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 0315795487..3430fd3cd8 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -21,12 +21,23 @@ config-cc.mak: Makefile
 	$(quiet-@)( \
 	    $(call cc-option,-march=armv8.1-a+sve,          CROSS_CC_HAS_SVE); \
 	    $(call cc-option,-march=armv8.1-a+sve2,         CROSS_CC_HAS_SVE2); \
+	    $(call cc-option,-march=armv8.2-a,              CROSS_CC_HAS_ARMV8_2); \
 	    $(call cc-option,-march=armv8.3-a,              CROSS_CC_HAS_ARMV8_3); \
+	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
 	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
 	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
 	    $(call cc-option,-march=armv9-a+sme,            CROSS_CC_HAS_ARMV9_SME)) 3> config-cc.mak
 -include config-cc.mak
 
+ifneq ($(CROSS_CC_HAS_ARMV8_2),)
+AARCH64_TESTS += dcpop
+dcpop: CFLAGS += -march=armv8.2-a
+endif
+ifneq ($(CROSS_CC_HAS_ARMV8_5),)
+AARCH64_TESTS += dcpodp
+dcpodp: CFLAGS += -march=armv8.5-a
+endif
+
 # Pauth Tests
 ifneq ($(CROSS_CC_HAS_ARMV8_3),)
 AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5
diff --git a/tests/tcg/aarch64/dcpodp.c b/tests/tcg/aarch64/dcpodp.c
new file mode 100644
index 0000000000..6f6301ac86
--- /dev/null
+++ b/tests/tcg/aarch64/dcpodp.c
@@ -0,0 +1,58 @@
+/* Test execution of DC CVADP instruction */
+
+#include <asm/hwcap.h>
+#include <sys/auxv.h>
+
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#ifndef HWCAP2_DCPODP
+#define HWCAP2_DCPODP (1 << 0)
+#endif
+
+bool should_fail = false;
+
+static void signal_handler(int sig, siginfo_t *si, void *data)
+{
+    ucontext_t *uc = (ucontext_t *)data;
+
+    if (should_fail) {
+        uc->uc_mcontext.pc += 4;
+    } else {
+        exit(EXIT_FAILURE);
+    }
+}
+
+static int do_dc_cvadp(void)
+{
+    struct sigaction sa = {
+        .sa_flags = SA_SIGINFO,
+        .sa_sigaction = signal_handler,
+    };
+
+    sigemptyset(&sa.sa_mask);
+    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
+        perror("sigaction");
+        return EXIT_FAILURE;
+    }
+
+    asm volatile("dc cvadp, %0\n\t" :: "r"(&sa));
+
+    should_fail = true;
+    asm volatile("dc cvadp, %0\n\t" :: "r"(NULL));
+    should_fail = false;
+
+    return EXIT_SUCCESS;
+}
+
+int main(void)
+{
+    if (getauxval(AT_HWCAP2) & HWCAP2_DCPODP) {
+        return do_dc_cvadp();
+    } else {
+        printf("SKIP: no HWCAP2_DCPODP on this system\n");
+        return EXIT_SUCCESS;
+    }
+}
diff --git a/tests/tcg/aarch64/dcpop.c b/tests/tcg/aarch64/dcpop.c
new file mode 100644
index 0000000000..0c4d32cfe7
--- /dev/null
+++ b/tests/tcg/aarch64/dcpop.c
@@ -0,0 +1,58 @@
+/* Test execution of DC CVAP instruction */
+
+#include <asm/hwcap.h>
+#include <sys/auxv.h>
+
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#ifndef HWCAP_DCPOP
+#define HWCAP_DCPOP (1 << 16)
+#endif
+
+bool should_fail = false;
+
+static void signal_handler(int sig, siginfo_t *si, void *data)
+{
+    ucontext_t *uc = (ucontext_t *)data;
+
+    if (should_fail) {
+        uc->uc_mcontext.pc += 4;
+    } else {
+        exit(EXIT_FAILURE);
+    }
+}
+
+static int do_dc_cvap(void)
+{
+    struct sigaction sa = {
+        .sa_flags = SA_SIGINFO,
+        .sa_sigaction = signal_handler,
+    };
+
+    sigemptyset(&sa.sa_mask);
+    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
+        perror("sigaction");
+        return EXIT_FAILURE;
+    }
+
+    asm volatile("dc cvap, %0\n\t" :: "r"(&sa));
+
+    should_fail = true;
+    asm volatile("dc cvap, %0\n\t" :: "r"(NULL));
+    should_fail = false;
+
+    return EXIT_SUCCESS;
+}
+
+int main(void)
+{
+    if (getauxval(AT_HWCAP) & HWCAP_DCPOP) {
+        return do_dc_cvap();
+    } else {
+        printf("SKIP: no HWCAP_DCPOP on this system\n");
+        return EXIT_SUCCESS;
+    }
+}
-- 
2.40.1


