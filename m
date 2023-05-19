Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F4570A2B5
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 00:14:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q08LK-0003I4-G3; Fri, 19 May 2023 18:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1q08LF-0003Gs-By; Fri, 19 May 2023 18:12:54 -0400
Received: from mail-mw2nam12acsn20808.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::808]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1q08LD-0007c0-LE; Fri, 19 May 2023 18:12:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsWURHX3AaqM+l1UmVzQuHR6SyINeQd/PuWqGUWNzclxzWbmIFX9gsT8jGai8oSEWLYYvnG0V/UZ8FYY2pss4urs1j9wYQHU+4E4rqDUxYWGfDVdZKCy7822BGixdDDvqb0SQ+oKuaM32frmjTMaufoImlseE/pdRMMxbMojmx5K4U2frsFRl68z5uNrLqicDrfpDCMK9RsieW4byhEHp8Mj2v4XPnGcfkIv19zm3nh2cNynMeQ1IMBJYV4+rEbI8Z3QjxTsHu7EDclH+OCuCBUqtaXdJsEifQgou6PFp42kFRQ2SboQA5XZ3gmDCTdktadkCysEsuVyTEUiZLDTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4cpWkpMAOUupRGcXH2m+HZJHqWYl+KQBW/iqmATjOU=;
 b=g9s+VzYDnqXKC47RKV4ReDIo+03oGSkYorpEB+kL5k4r6jgjRT008VrLeN35Zna9CAuWRyzRiONy/wLN8AmRJr+R/akdSH4R4mHcS/APip3Ud50i7yj48NGiKOMbFQMyJNApQ8lf9NSoPsdgPJSr8NGFHKaxao90msawwqyLQRX38QWwqmBhIoIwqx914Uh9RMUO4hvxedHMgqkkjV5FGE8zgwXsovDtcAKFaBAgfsGcib9DCgl8w4wk21iJNpg96NOKVqwJnJ+DOxQVyl2AYectweV6xlqBDkal+cqxTTW0iuyeC7itwT04ySXAHVZC1w3KXtH7oDJUkXhXcRxIjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4cpWkpMAOUupRGcXH2m+HZJHqWYl+KQBW/iqmATjOU=;
 b=dWGgTY4WnDrba4Cyjj1F6YgIOgh50bMrccxQ5F9BypK/lsoLdL2o+Oo/Hi/ZaLZxP78z83JBdW8ex/1CZ1AXONgvGYQMh7n8O32dpGiqNL9MeHoYitAnOnYcpwFo1dHSBJPUfu/LQA6NFCUGAGHAECmpmjAOzgnXkgT507TvhGEpNTUIySLmmmxbCSPoxuBhcFkXEnf+WP5Tty159ioyRQoFNE92rxSyOyJejMvTBgVcnmGRJBhwgiiqt+JBr7/0rfL8DMGNy9rgNU9pGcvB869b2m77J7YMmy9VYbQPp7tBbYnZGCDeQfayikfzrlzKsw/ocAbccACMqjWVKxj55A==
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.24; Fri, 19 May 2023 22:12:46 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04%3]) with mapi id 15.20.6387.033; Fri, 19 May 2023
 22:12:46 +0000
From: Zhuojia Shen <chaosdefinition@hotmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Zhuojia Shen <chaosdefinition@hotmail.com>
Subject: [PATCH v3 2/2] tests/tcg/aarch64: add DC CVA[D]P tests
Date: Fri, 19 May 2023 14:56:23 -0700
Message-ID: <DS7PR12MB6309A170F8BC7D7C956D6C97AC7C9@DS7PR12MB6309.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <DS7PR12MB63096EDD683DE70EBC472E97AC7C9@DS7PR12MB6309.namprd12.prod.outlook.com>
References: <DS7PR12MB63096EDD683DE70EBC472E97AC7C9@DS7PR12MB6309.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [w1wkcrrvUE5FB+1Prpq3fzIDLdsUAUhw]
X-ClientProxiedBy: BY5PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::21) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
X-Microsoft-Original-Message-ID: <20230519215623.283899-1-chaosdefinition@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: ddfdd4ea-dbfe-4c6d-15d7-08db58b62cf7
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3nvAoS/oQTVQZ1S7Y8lGJvUWSC1Z4WfQFRwDUWz7rXlWQckZQbP4iDgCDt1is1V71A1/hL720/2e2ntFk9hg2/jCTgyiSCjq6phg0+IKw85YJwFaeL6t/nTx8RilFAknG7X61X/mg4JNyFhu+mhNldWxpOe1O76P65p04Hh/nOln0m6SpLTdC144+K5Vqt7wBZFiPq1KqOumAk7NoSTIzspFkQbprvPMb9nKjt6QAIMfzaMv1lwuqwwkEjisUXtzOprfv6Qy0B38HwhgSX1jUfZ+PVnkaVRo7dGh0iNPmM69BDZbimzGe0ydjy4kcGHrMW5mAhGow3/IdqqbvHqGIeofwnsPRbX63t2Qp0U//sH5CVEq1L4xkokeMm03CIKzCrymu/IiXNtCDKdOYOvpsH01VHCRrkVGBoSHfU/JjAJaSJO91SB/45hqp3F8XWBYExsQRHYNt1ISBQtVgxPTtoebdicKPh//OU/4vbEogjnnFlKKe0N1yk5xU61n/nKDb6nxyzjTwyRzDKm1//+cLO1P5SCdVUYq98Acv6cRAISyIExfSMJDSvIFpmyZdc/RJo8RZi2c2tfi6htyj/Ghtw4chb7tztjcNuKQY4Ua5jVraa8j7pFBIV5N8NnFAA/oqznSbVDxq+EuCU2jnXm5TiJXmzszWMbYI7KfodjuVRg7+RVhoDCwuTeRGTvHOPeXpkg7BefJ8scz2vZTf4nutkgPxft6o5j0XU5ckbhWB8AsILKO00x2mZ1/fOn7mzhmnibnkOFikm+lSQEoRF8/qqL
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/L/G5UGhPuKc3xd+RFNVzSJsE9x5u0Z1qdm2YokYAAZUIPq8QkvHOcCuUa+nLcYXplR+bz5vZ5JiGLIhyVHGn2zM2KDLUQ5oZzPtdnhGbNTfwycLyNriCBI4wrz8+Eq2JnDKXt3RWj9POx8muBSvf/YXFGRcA5tUq1WO7k1iYl6Ygkr8NDP+er9epMq4uz6+Y4W9hfia7L79uGBpkAEWbZc7A6gIRwdzd3LZVK9jOM20etsdWbnzHI5Jsnw5dwkgxAMbp56xMRzlIshAAdEfCYkSkjMD3mWNocYnOA6E498kItj21sF8Hy4BFEzV7HBSeIJX/6kmI0dleKg5ynzTBtR7WvLTEftgmvLF9IRwqhl95t2FlCMv4wv37eltEKD6IvAP/CvQgd10MDbjB0x3EQXEF6laqWqxdDkY4AkhVOSr1/m/esjZn830lLJc0EDNrWy2U18MnLVUBgdabohP8lGe7nBkbOP8cSMVDLhrbtvtqsNiewf5eoFwnteOvKvYQw59UiQETe/Lg/dnkJupfkbUCkte0XywejQYlWGaKNFETjNVxgJfWbNkOCRNh08dwZq2sDMF8Xmom+Oo/cjnP5POlH149Y1jr9sdwe5kjB/qq+CxHbz8eMaEbMmTbow
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JStSlVIbnwe8XEs+jUTm1mdxJF6GfT8wWEXzjYZmPgunahjiu1aQJL/mej0P?=
 =?us-ascii?Q?6OwGw/GiDwKGoSI2kCQAdzCcHCoGN48sPTFhyAxGRO4fvxxLtFd4RdfjuhwJ?=
 =?us-ascii?Q?6Ep9AInMggKP9HUYDC19TfZl6U2w6B0NIs30hZakA1hUFJywpb9+i/9+Sllk?=
 =?us-ascii?Q?E9a57AFhJooX3M3YtkGTsHCnVO/K+mI2/Focy5jPXyKFuXneZZH+h28bN8hf?=
 =?us-ascii?Q?3enzAXiVFk6dYl9Hw/Cj4OQhZLNGnAizr+UEbYEPFOjZmQwkPAX2++DMBwE+?=
 =?us-ascii?Q?opZhsJFA5wyrRdKoNfxkl/RzaPvypP9nATRz9a5upnWSSrq7tF3H9syQyBd1?=
 =?us-ascii?Q?CrUTyDsD7eR3uIbK+73wnsANjL3hxgsi1BpN+JbXzpP/G/2zip+L5KCKmKuN?=
 =?us-ascii?Q?hMzlg22WmnIXXDPj5VExUG6fRW/o01EySsKl30vMH2pQw0cVtYih52IIKexg?=
 =?us-ascii?Q?gs1sbp5ALi4VreqTknO2NczOy+perWlWgPZfbDtEbNKvRI9pHoE9dS4olqRp?=
 =?us-ascii?Q?ZebynVxB5wAvbfpQUoAxPCGiGmASO/rksru09qv2Sbbw465cxHLr/35LeHhd?=
 =?us-ascii?Q?Ub7/zcwoR/JuBN8ochIEpUl2NrjMG0BbfnRVnDtjyPXMZIAlByPio6wsG5L0?=
 =?us-ascii?Q?nh5aFvrmGTvkxXA2shEtElI0ZfzbA/3MK+4cZwoWD1/KeVYsETH9hj6HqPPv?=
 =?us-ascii?Q?0tVqmkqlO+9cX4KRdEr6f4FnrjyOWAn2SxedBNB6N76NE7ztEX7A+oCKFCb/?=
 =?us-ascii?Q?CpiVcpMP+CTnR8q74WRftKZ0odTEgfbWkt2CPL1tfRA7Jn4tdVNktN2uvvJN?=
 =?us-ascii?Q?VTR6VikUuR3Y3t4QbxpydJM7FsnKH6XaYiTe9gFrvNwJBVBexNFwlrAY2Sp4?=
 =?us-ascii?Q?tW2G/nhqU08d0KA5ly68QajUJjJtr4CHRfOV0FodbYvAJxKbY1RXUETLWLMt?=
 =?us-ascii?Q?pBnudJDFSH4YQpkXclg3kAU0GzXWOa4y4w4iN6rcX4CTd3NgX7DUP1JEEv8L?=
 =?us-ascii?Q?ASf2j5Y1SrYtYncHOUewC38QfQjdb0DEkrE3HaFGL2zJO77BzpEgQVqdsXHe?=
 =?us-ascii?Q?TS/l/5wUF09xqJyEk6VXoOcJQwpmsgvOmO4Rq8DkbZwNvtiu6pWoOE8KqI+2?=
 =?us-ascii?Q?teEjnz4smBAGYlA8lD6m5j3ZS+xaCYlzdzgEa09a30yoIveniU4Acjp3C8Bl?=
 =?us-ascii?Q?EMDi5CFW/RtflK2I+dzsjy5oIkq9J4MxjifzrQYGF/0JzleMZH2tuY2fh+I?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfdd4ea-dbfe-4c6d-15d7-08db58b62cf7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 22:12:46.8459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756
Received-SPF: pass client-ip=2a01:111:f400:fe5a::808;
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


