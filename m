Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AA271F5F0
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:30:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4qnK-0002km-HJ; Thu, 01 Jun 2023 18:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1q4qnI-0002fJ-Eq; Thu, 01 Jun 2023 18:29:20 -0400
Received: from mail-bn8nam11olkn20800.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::800]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1q4qnG-0004t8-MG; Thu, 01 Jun 2023 18:29:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhvXa4rFk66HDDE/BpK3/TItgJAk4vjydJyJeizRYrKhlOuZuvy49rLlfOn3YLnNFmGwF5lbw5ybwOFNbMig0QgDIb9oxKOfZl5R/fuP8a5r1RSXqCcCKz/Wm5M7IGhx3rmH6xADx1fvRsEuQcUij8JjMQHGn03R6TOpUM8UDX5SRShxxcESrqqiPLNadXgPmc2SsZWlPqHHXO9hB09QdG1OCD2hg5F9ZvJxg/awgiby1P4ppoFHvkBW3z+BZRiBM2hNHswUChG7Av6tCEdCvesPvC0bakuLkDwPxKDq+NB1EQLPCMdHNheiLj0e+ft+ZlBqZ6V+34ohGhiS2t1fSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WpfqqcMe3SxZseMmTxrhV/8CImFyvjHKgsXN2o4rJ8=;
 b=HRLJ4xuQNgM65kqzda2taVhTreEEokpNZltzBijtdhKv8/A3iZz0o4uNLY90EjVW7H9u9t53vpPjSbC13+/3G++QGK1FYMZIwQTp4wRQwIDKP/2jbOpIEPjs8riDP5ku+IaJ9QCz3Tst0/6HSH4Qh9lE6C9U2xL7ghjAiGxP23K77x0SQnSVPLr8TEdV8bTEO4IxKuvoNf6dHHzSN/2x7PGjBwL+g4pyGf52Ft6m8xGlz0bQfBS8tKzYBB2MbYDt14bg86M5LC91WZgq7I534GrFGAAPLh/4/lTp4edDFYryQKic4Kf+SzzDKDFJJb8FIfK57A514N98mVkPIM2e+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WpfqqcMe3SxZseMmTxrhV/8CImFyvjHKgsXN2o4rJ8=;
 b=iXZfrnMkYnWCz/VxaS1uqbwOfb17rmY5XNCH7cHzPo79K8NLPbaKN2TwAarhSljZqwZ843pdZDvIyxdgTqfzhHSNOxzIJmYdsGF8RTDkF6tfsrKo7XQYb2iQY8S3uV1Odt98qIaIV0x65pcZ5HsZiyq9zdxqiW4KJmTeUdIZsDcBffNTYdHXE4XPiY6b4ArT5YUNkUjJi13lNR0rS0APUzIcmhza1VyEU0tzzGvMkljq3LFhHVgV5WMwmYSffY+Z4S0YUfbDJM63PyhROZu1tRAWekdDxWgB00BMXuN6tjaWjtIGG+FARPMKHWJEyWA9t3eekVa9A0Oophrqik+Nng==
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24; Thu, 1 Jun 2023 22:29:15 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::20b8:bc4d:e007:4fbf]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::20b8:bc4d:e007:4fbf%2]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 22:29:15 +0000
From: Zhuojia Shen <chaosdefinition@hotmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Zhuojia Shen <chaosdefinition@hotmail.com>
Subject: [PATCH v4 2/2] tests/tcg/aarch64: add DC CVA[D]P tests
Date: Thu,  1 Jun 2023 15:11:58 -0700
Message-ID: <DS7PR12MB63099AE846499E59E2181A65AC49A@DS7PR12MB6309.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601221158.48705-1-chaosdefinition@hotmail.com>
References: <DS7PR12MB6309FD700EF00EF1EB541CA7AC49A@DS7PR12MB6309.namprd12.prod.outlook.com>
 <20230601221158.48705-1-chaosdefinition@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [w/DinAHxeHoxUpBRVZxZn315Jf4guPm/]
X-ClientProxiedBy: SJ0PR13CA0126.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::11) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
X-Microsoft-Original-Message-ID: <20230601221158.48705-2-chaosdefinition@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d92495-c3c2-4db3-f205-08db62efa1d4
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmo7HDJh1DrTtBBfugGKTjxK494IF40v9ByDRUVnqemattQnessUPCQoxZOl06jkjQj6THGpwNIeoeU7yUBoxjNx63BwferS+MpiWCkr/XKBC9usV0zZetS6BhKM6DBjVzGGNbXx+l1z5g4WQsD3FaS/bgPu8TZGS0RuJ5/CGVAkY2GKYOWW2OnkBSvyg+B/ojQOmTNe25UOl7ahFhEdv8asJASNqxgA0MD8ea28ZANHhoEO+LUbVkQshSGBCad6jQU8oo75SxxDlhPkzSPs9KEfTKWTRRLICLjbQBruIaIxxItBD9nN/rpInHFcQVKxQ/C4OO/XQjK3vQ8Te3LUo/evgn3TG0TcFYl7rTjCEuWgkLPGqZED0T8DzkKxxJeoqN58oaeLE3zCVgAHLQypcRdcvyeKmKmdXxKDEn/1fI55bpKkLe//YUh5QDMXIe9cbXqNduWrNIDHU2Yg8xcv66mmu4SPRP2nBFzbNnMUtdgHJaLxDeueerdju7FYYcwmNJTca7SUxa6xLd5oBzP7inap34o6kvqEAdirqgWHT2zwJcfZ2lK91ApLNTYCzMFZSG66eeenORZaI9phO6EZwSbBNinRekkI751pATG/0n4XiXqjMdQu/CiL6quAOFYPbbCqnpeMM85eBB8Srg1c8olkAZnp0zkxFAwts1JWvGliABaikFrQOmm5SQRBkqWy8tnQ6MVDTrHH62QIHeScLfRYq4QP8oM0r2q5Fk99KtNNgpf3ojVjLQM/VApmmjLOsCQ=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 43ol7WppL/GBG0b5kJN8BYE02zRJBzWCVho5/3qGBLteTIJTvydtupv+YFr/6Yz6Y1enB+YfislL3sJMvM/4fNBfbqttBb5/ioJUpt5q4YxMu7GePFNFuxXJN10Y+0w7KI2A7nWh06vDBjuK0KypHdp9e+LnLIy3o3mhbBFZvDClcJt7xrsvljUJTIrjvhrWMwadCefwk0g4fVKHlgddqRei6P0Kp0EWC9jLqeNEcSIcZAqSNn47LeC1shgfyB/vJCoGNM673HUrGwWsO5lcNCiBJ7DgWW8Ev/nc7b3mz3eY3cYn6S5FDzccidB9pgAobnM2clU6OsDgNQbh/3VeCU4JqoZKLEamH2VNuunaKogdNO44c9viE/La3R+jYF27rGgjFW7VH0Lp3S1JDclCMeBpPXFKO9Tr3NWc83sTWytRurA+RcTyw4BkXTcHvu43me7DRSaeTEZKDoo3uvHckHDwgB3+L2mmzTKFSFQGJ8W2FBo2ee1VLvPiCGrIqgiAvHRBfIigxUhRBR4bIHFvLO9keoVjDC0kLa5zZYaRTbQinn0zI8Xlv8Feh1+EuuA2y+gncjXvzBdFD05DDznhO12Z9Q+8lEscA+isdznie3GKxRzHRrYsS4FJq6UUdCOa
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?shhv7uk6ZZxE5yEe0YXD7CHiIEdphLP5uA33G4FfXzYvk7JnJiqqT1WW2TSK?=
 =?us-ascii?Q?83Qv4gbxXZcHFNTe+3Kxh8KS1xkCtd1Dv0xjaJx1MaULcKEGq1ZklTe32F/p?=
 =?us-ascii?Q?8G9bdNZtxo5taZnOaUlWiCZjsLfZ/W0/jUgnX64AJVcBF2rJyh9hD+8ZiYWx?=
 =?us-ascii?Q?elV0hf8BJNMlABOUbz/lLWzn8/Aqd5J1mzmRI++PsrplAnfCX/BpCQ4xVfow?=
 =?us-ascii?Q?FrbSgiZCzGZM8WsO/cJkJfyswMunapDBvO666pny1mN4ZP1ZtPYfbO61FsXr?=
 =?us-ascii?Q?9CMHYMNmJwZ4Tko2odGZveGOoIxhvBxBNyk1Mohzf+l8Xa4fVtlohQlQWepq?=
 =?us-ascii?Q?FhNZ7m2XNSycLpfzZtPVVarxqnb/VuL9pSR4IQn8okAcmwSuHnwOCTTgXa6A?=
 =?us-ascii?Q?uk8aiffFR1M8GoqRE9WAOEU8ZDrOLFv7EDNw36cs6XiFNqdCGSfBEeHXU4FD?=
 =?us-ascii?Q?HFkjMNCAjJSEZkPHl4FTaEw2zkx5BT3Gy5EUah5sZ7dNJTear6zUrkHEAMRg?=
 =?us-ascii?Q?i/6cjLIinE7AQ50Hxf5DIvX/Xn3l7gDKkXolgUU6fdLBDooclFvYSM9ohXlQ?=
 =?us-ascii?Q?EfGUgpmdzS0jcnPMyNGvTN/QYEPJkDK/tO6TA80RzIKNhjrBAUt98hK/AANQ?=
 =?us-ascii?Q?4crUQPk/Fji1o7FEF+OU53FjAh4Q1y7x4HQtWCWxqnjBKXJYActk6xDwFLp3?=
 =?us-ascii?Q?NlbtiuEqg4C3XI7QZ64/QOOJG3KdgdpjHDPR0uO6gOR1UaCwf55W8Cw1QiGz?=
 =?us-ascii?Q?HsPmxruYhWTM0Kq5cUGWmfretsdZde/H2ODOwXuGTPMRVragFMNcVOoL8fSr?=
 =?us-ascii?Q?Hid9dbilH6zeNKN1dZFKYi7o1a8BBDWHK8+efJiW41cjtrAaYBmhtWYy6sTe?=
 =?us-ascii?Q?PR92i/QVUCceHznWWzIfIOc2EsP1i6LDGzS4AAI+dXEAoKFL5yHj2kMBPEZK?=
 =?us-ascii?Q?oLcVHkPy9zvmD53/pj24DPQkd+Hts2wBrc9nlE8miWk/CWFYXunORPlDkS2k?=
 =?us-ascii?Q?9ZGUJp7O4bEwsTE8AOwXNlYZnFm+DqDFLE0TRZxBqOpdH+u6729PIH0w8dFj?=
 =?us-ascii?Q?jJsGWSyGqo4GF/jHmYYY6hCfgxfGwno2EsyBRYxC01BKrOCkUOiokfOvRnvz?=
 =?us-ascii?Q?6Z3PHNNzkd/vZzXzcbhXDDhNK5wniZpFmFE3KlMYZdF73Tz+Cyqbrs/zS7eJ?=
 =?us-ascii?Q?eAwXgqouDMFx/4GfFJDj6cSMeQjGXz2OTKIB3ivFwtaIhpQQKdvOqjxQ7pU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d92495-c3c2-4db3-f205-08db62efa1d4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 22:29:15.8007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748
Received-SPF: pass client-ip=2a01:111:f400:7eae::800;
 envelope-from=chaosdefinition@hotmail.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/Makefile.target | 11 ++++++
 tests/tcg/aarch64/dcpodp.c        | 63 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/dcpop.c         | 63 +++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)
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
index 0000000000..2cf7df2e07
--- /dev/null
+++ b/tests/tcg/aarch64/dcpodp.c
@@ -0,0 +1,63 @@
+/*
+ * Test execution of DC CVADP instruction.
+ *
+ * Copyright (c) 2023 Zhuojia Shen <chaosdefinition@hotmail.com>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
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
index 0000000000..a332a804a4
--- /dev/null
+++ b/tests/tcg/aarch64/dcpop.c
@@ -0,0 +1,63 @@
+/*
+ * Test execution of DC CVAP instruction.
+ *
+ * Copyright (c) 2023 Zhuojia Shen <chaosdefinition@hotmail.com>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
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


