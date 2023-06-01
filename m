Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC0471F648
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:51:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4r8k-0006HN-Re; Thu, 01 Jun 2023 18:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1q4r8d-0006Gu-Tb; Thu, 01 Jun 2023 18:51:24 -0400
Received: from mail-mw2nam12olkn20817.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::817]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1q4r8b-000608-Ve; Thu, 01 Jun 2023 18:51:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPmV5qmKwggbVH/qt6uMy0aLE8/ZO/kbZl9rPOYE7fo4UVHd9UrYD36xcnz7fiDRwZAyTvjNmjP+csIUuqOdmsIkEwcFmkvtzgjSb6FVO5tVWK3k8xG8JWr5IV06KrBHSeDbvYMwRvHI03UyA2emZuHIfB9Q9N37EdB8RobWeJSTNpW6JZoYnLKv60x+nRGVas7fa+WQM7kq24L78MsQou4PUg3okj1PlRZ+FOTYFCVxiBTCzFRST+Iuy0IdyFl+okdL1WIBhXJK84EK+5+Vh+VTucocDMsZMacFG7uo40cdWz7KFtH5JH+oQITNPhIpDN9FvzFz1ZHo//1hwmjf3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WpfqqcMe3SxZseMmTxrhV/8CImFyvjHKgsXN2o4rJ8=;
 b=X0sdE1AgBv5R/6gFP3Fq6e2kj/h9MiRgAxUm3P3T1TFVlTF4C3DXDhmF/FYiK0HQ0v+yj/pGTH12wEycXE5lODBX1NY3XJHFsITlXPUcOLb2dgonoPvo887SI07pZy9RE4qGyajD+yE8tDPYR6Jsl0u/UtsUXLb7+TFlj22PrC0tT1jM1g2XeCGc7X0GAkvIdq5MVx2ejtHvRXtaTUUfm4CI+ZiYRDF5gO1v39N9vtCfQuvclC8LQmMkJi5nfrzpOG4Y2HheeqW0GHg19bzm06UvE2U1ART9Sf/cP3/6gI8fhV/VQ2qCTyxypjUnw/l9E7jjPBxFTtfPMp4gsFIunQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WpfqqcMe3SxZseMmTxrhV/8CImFyvjHKgsXN2o4rJ8=;
 b=Ycy/W/lZ8rWqs1vmuRyIRIkg/1FFGCX69uSTyUHQWiwZfXdWMt01HDYg1jAJ70pFZf/FVpo8eNmCD+ATGLzf98aNhZgj5R8wBhNEWa/AMZUf7AR0iUl5pU4G+PvKoBb7HJHB2Ni3dL95ms7/lS8iR2yIWj4xjvSoBS4/aEBK2tTqJwQ0ui2F9RGBpbu2TlmE7g0B7bBrUibMFEc2/I5hSCCVohk77GsY0Thi8ncIRHJrQizZDys3TQ+lwK9eA8JAE9EXbn6iGu5ljDFfP9/VRFql2OSQzAHSYpL1sTYzBnf0EwQTWZo2BImJjvj6+S1ZyKWv6G0H62SAU5ZAwiru4w==
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 CYYPR12MB8854.namprd12.prod.outlook.com (2603:10b6:930:b8::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23; Thu, 1 Jun 2023 22:51:19 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::20b8:bc4d:e007:4fbf]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::20b8:bc4d:e007:4fbf%2]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 22:51:19 +0000
From: Zhuojia Shen <chaosdefinition@hotmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Zhuojia Shen <chaosdefinition@hotmail.com>
Subject: [PATCH v4 2/2] tests/tcg/aarch64: add DC CVA[D]P tests
Date: Thu,  1 Jun 2023 15:34:57 -0700
Message-ID: <DS7PR12MB6309B3A62B70F5E70480DBCCAC49A@DS7PR12MB6309.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <DS7PR12MB6309FD700EF00EF1EB541CA7AC49A@DS7PR12MB6309.namprd12.prod.outlook.com>
References: <DS7PR12MB6309FD700EF00EF1EB541CA7AC49A@DS7PR12MB6309.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [zufKtw0P69aO5lv9GkHpYOZn1lhy39wo]
X-ClientProxiedBy: SJ0PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:a03:338::11) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
X-Microsoft-Original-Message-ID: <20230601223457.48835-1-chaosdefinition@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9ddb78-afdc-4dd7-536e-08db62f2b66e
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmo7HDJh1DrTtBBfugGKTjxK494IF40v9ByDRUVnqemattQnessUPCQoxZOl06jkjQj6THGpwNIeoeU7yUBoxjNx63BwferS+MpiWCkr/XKBC9usV0zZetS6BhKM6DBjVzGGNbXx+l1z5g4WQsD3FaS/bgPu8TZGS0RuJ5/CGVAkY2GKYOWW2OnkBSvyg+B/ojQOmTNe25UOl7ahFhEdv8asJASNqxgA0MD8ea28ZANHhoEO+LUbVkQshSGBCad6jQU8oo75SxxDlhPkzSPs9KEfTKWTRRLICLjbQBruIaIxxItBD9nN/rpInHFcQVKxQ/C4OO/XQjK3vQ8Te3LUo/evgn3TG0TcFYl7rTjCEuWgkLPGqZED0T8DzkKxxJeoqN58oaeLE3zCVgAHLQypcRdcvyeKmKmdXxKDEn/1fI55bpKkLe//YUh5QDMXIe9cbXq/SV67CNJ4d0cxNKcEuBiiX09TVckcvwUzQIhkzadA3Vhb2YhpKut15M61BFdEtOTeZGWokdXIhvJ7KQZjaGsjOArrYPk13DTPcsj0tiqbccnwlsk2r1h8KPm+AiQ3/j2g1fAeM/OSqXJ4nQ6yT1n1xgy5j1HdtYxxKkyH9ejZ7i9n8gwW4vri93uIucJPoIbKRSpM4pNmmx0nQ9RIgt2qb3b64L1iYOtzoKtGqjbJnyAGE7SgZWxS+UpmEB1CN/Q1DLQEvgt/YEm88n0ZXBP6EC0eQK/hx276mudikISIzTCqKAjsRWXmoW+0KMEBbEc=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hfFgEtQbIWTwES8adyB9S7i50fTYBzlIzAQmtjb+9AdrzTPi0Hk01PDY0xpJ2ReWOtcP/pI/gVv2nQVMJGb6x4V0BWpJ7PUXcgXGYagklPNGZTWzFSjNyji4XiE7+qmNpPP6I3dNH7gQZnloZDLe1bxLXrZxSR6MfukixAZaLLYtlqI0pp/DMVT3ukAV28YsxYTSNEXL1jU0gQ4QZn30RpuezyHKW0wu5tfCEIBlXb0W/bAYh9/Cc//SF6uJ4sKDppWKZVFcBy+D3BzP53DkVpO+UNXcyTEi6wjDLyH2FTHW1cuILSCa6YrFU87/sW+TvcCcLNe/Xy1FsEELZA/bGWNvxFy5qiULAXEk4pZgXh5XM8dci9oKAGjanVZqS/Ja55CbxTphCd2MMbSknOWtU7jx5KS2jetWivf7E0D2hE3Hx7IgBodxmkuNG5H19tyj3Y4Fx2UWAb+xCXQx9sLlMKyEULjSXjxTNb3LK1oeY8xIY9DJcL/BqlXfOrBmgR97y2DbmQ6jLXwss4iZjSVLZNSpWn4YPTnGw4gNntmI8Znb0SBjTNXtIXOSe5U9yZdQP/gWBdj/1Rw93bjlqGOx+L5sVAK6z39U2GbR9KTt434s9QQj/we7Lk93lwZNpTcs
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FMujk0CJeMGXnJ9BeIQugx1bDXUcPtGuuzgPiz/jiBpLC6/jacr5EYYdMQuc?=
 =?us-ascii?Q?0qrY1HkqWdVvQJbQRsSFK8WO0VO18QAft+5JRNWDSdmnjhddq7s0wsI7yA0o?=
 =?us-ascii?Q?EfDAGHXPfzmHpHsG5eA45WAP5kykdP87hzHN7JLFQao2voZx04tnPR0qXOnQ?=
 =?us-ascii?Q?1/9usRQQg2yRdtO/Y3dD4vdpDsTvFfu11db7oniHcRHOdWA7Tvc39oC/nUDQ?=
 =?us-ascii?Q?f6gMD0ZzPq0blE3JJtmoTATYZyz2A6FfiH346RQN+CK4nP4wK7D8+g+pEcAx?=
 =?us-ascii?Q?lTkIiXc6kQELokYu5o4AXQ1vtfL1pdkK5PE5gIeXFLenElPj1qdbHxhR9jN8?=
 =?us-ascii?Q?GALnMW2MprpflGlO/B3fzCKDtaAAiZSMS+zjsUURBjdz6FHf1zM4JiGYcBPc?=
 =?us-ascii?Q?sj7oDPrVmCKUlub8JkI/6AC6QHnwrvlULGFipuOntwgqMQyXjSKRoB/Eki2Q?=
 =?us-ascii?Q?F6liS3vWgHpFeaLo26iRi3Q8c/fegcNLkQVo94hbgheFJuinjp41E9QBWkSs?=
 =?us-ascii?Q?AWwzQco2D+vlnWMVceu0sJTvtb7uS2i8lP6+LJxowtgcP8Lbis3FE37qt/gs?=
 =?us-ascii?Q?ofpOQ8mMOTcYtWjw+ouukbOYw0o1+qvp4UZCZ1JAqLofXJYBoHT/WGu264qI?=
 =?us-ascii?Q?lbgqSgdd/0hHcE4VpQ3jq7rEMu417PipZgduehEh11/2pwKch4+LU6wHEwcn?=
 =?us-ascii?Q?zToNHv0qnEVFiveDWE4wZIjPCC+5SxtQxbfSt7JP7Ljf664cSD3GW3M5SHpr?=
 =?us-ascii?Q?9GoE0c6joXod3zeD8H4bVgGiFu5hRxDbZRaDyiglgKZGG7DCJ9B2nHtGneLc?=
 =?us-ascii?Q?3vzTXOYc2IgXzal1NIU3Ln0Bfhu1APidFBGPWBrrD02P4fww6xS3N6IGcDau?=
 =?us-ascii?Q?1FylL6IqremXjotvqneSifQif9vjABaELTxtLk+LqYVRAozB7uuRhryaGNwp?=
 =?us-ascii?Q?f0ESoGzFziI1QqINch9Ss9Qy3DVS7KmmfTPoQCTX7Y3qKk1OBySahRtqeH+o?=
 =?us-ascii?Q?u3owxH0g6QxkukaKAi9hCR+N06PwYHQU+LSDyVjQrXOBgF4nZYAW3UF5t9ad?=
 =?us-ascii?Q?BTxz66a8Bvy6YxyLOo6UXuh1CWhqTQrEzuMPeQbChdZh5GHOzm+CbKtNkS7S?=
 =?us-ascii?Q?5cbYtf2v7beYcj7fW63DCvkWLkFnNteN7t0lQcaMa9b+m1xwDnQ5uM+gGjAe?=
 =?us-ascii?Q?yEXEvMPbp5zoPf/bh8zbkCMm+iRVCktL5aYEPDjK74kiIaE/jBU5X4wvMew?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9ddb78-afdc-4dd7-536e-08db62f2b66e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 22:51:19.0851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854
Received-SPF: pass client-ip=2a01:111:f400:fe5a::817;
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


