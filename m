Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B3B707035
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:57:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLHG-0005w2-DN; Wed, 17 May 2023 13:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1pzLFi-0003BD-7u; Wed, 17 May 2023 13:47:54 -0400
Received: from mail-bn8nam12olkn20813.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::813]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1pzLFY-0004jB-FG; Wed, 17 May 2023 13:47:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJDAm7kNZa004Tj7YBn3o5BA28ax3qyFyn3IqcAAqC/AfOH7bOuiiw5lWf53176+CkYUm4eHvsvsP98wmAlLZ6f7NhpD37d6KCv4OPwHqnXaTzw+fTxBSCjbktMXSRu5O1/To2E6nQEw6xr3uAWBLJYTo1JzyOU4E78ZIEjUC2usTm0T0lBUnnTSmoXRRwH+vf6ep3JaUz+fY0OWqgqeK8NjTiXTiO6jSn+5/eS2y22k7vTLzVQQI8XA5t8zi3qYhTIGdQIOx8Ju96vb0qUHozp4wduh1tnAqbwhhWDjQX1HF0XOvRqlHvBXp6+H/oZEMJ08V9I+h5Q2QSBF1dE3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJdrIGUsz7xeLBGKe6oRhBqBOiNS7cAAc7JckcmdAns=;
 b=LYZDgRb+O3XJcqftYVBm7aIyfcMxbVceflvEq8VbQqP4dnYyKluXJewN+/yV8kNfndCRUxKVA+W31CLJ0wkPDKXlxZsMFKIl8Zbg/TD/NEalOasmItJFIhKwpdV9TXgEUWyo4VqYjnlbJhbEUdxf1rnkrgkJjJ3kVffhvyeX7Jqaw0WsspDT0zKPRYKq4AH93uU6bqO8SY3KOh/szNgwoqApbnqv+lVSBpRz3P95MDRkc6szyHZlYVr4TTKfpB3R4s/r5u8WeQpii2nktI0kZR9mdkfvtwRvZGSyDN/ReXq3klZQTC5OxIwcI8qdAo7FvXmEh818Uggg6giL69EuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJdrIGUsz7xeLBGKe6oRhBqBOiNS7cAAc7JckcmdAns=;
 b=LsLH+h1bXxpb5G/TkB5ji7vI2882Zy9HD/8qvqxDC6rS8AhseQbFTj8oZSIyIhb3JbsjfVt9UYGglaMmv+DduIbkZMt24HRvQzVtJNQCi8U0GnHCXR2dQm2hhhu2APplq/R/T+yB2NuUY5Zwm5xKzPaRgLayxL8X1osb0KjKlg97niGgj789cUyC2vz63pgVzyFiG126+pqkPECUVOuRmnYTkBEQPUTcIjzmqIdjrcmhYWIu989OXsWaNN1tgva8iO85zbwSeZzv3UufAYXuGh5EZ3q7EVteLkrbbfVZC6Z9vUy9Uju5HCJQD+fLStmpqW2PH6hPORseFWMLvLZxdQ==
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 17:47:35 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04%3]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 17:47:35 +0000
From: Zhuojia Shen <chaosdefinition@hotmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-arm@nongnu.org,
 Zhuojia Shen <chaosdefinition@hotmail.com>
Subject: [PATCH v2] target/arm: allow DC CVA[D]P in user mode emulation
Date: Wed, 17 May 2023 10:31:06 -0700
Message-ID: <DS7PR12MB6309A0F097FA4FB9D7CACB5BAC7E9@DS7PR12MB6309.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [R15Mi9pr+3raxQX/bCsGfslvJ6xroVZJ]
X-ClientProxiedBy: BY5PR17CA0043.namprd17.prod.outlook.com
 (2603:10b6:a03:167::20) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
X-Microsoft-Original-Message-ID: <20230517173106.190099-1-chaosdefinition@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|BY5PR12MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: 44336afd-7347-4edf-0bca-08db56fecc40
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3nvAoS/oQTVQbRJURG4O0+HHAaFajDIEf9pSUQr8Bn9/tP7YVqhDzi2HCHchrBZX0Xc7qwhrnpRFlLJpfudOCxpwXErzKd4m5SoTGei9a8DXAP2XKIEvYD++ni6MB6fF4dwc7i9TJXGqriA4CKghGtXAX3K4cPAWOdFVNly/BL8qA5r0w0Ixk5Uxr3GjYymoY+YpGPMDX53lQ5lgeQ3xQEFsKMxCrYmtmCeK5JEgmB9jcf9L+8y/yc5ad9xLSCKkGOXoVrS0KgbYPVXJRI97IP5kEI8f8HK7/UE0KwvMODlDOrcxjjK4jsAGcRnGa8C0usstB194sC+2uj922dYQmiVNXGHJcpe9atk+psK/+OyQ4Pw1Wbp4sSVMYUbXBctTmvTAhWduD8T25s6d8RdbYMTo+Mur+jWva+3/4UyugVTn7Rk+8r7HPIWWtw34Wr872UVtoAu72dG5RxeZEj6O2NaMk1To1JFEShmNcALzuKtHf0oG4S96G09I/f01W7rFWLYbAr5rP3uA3gHdU4vlZ+Vqq1NrobOyCVsBd/Dw27ru2Cy5yIpf1Ha67trXJa90rtxvQtfT97Hs5EAGDEOP1OxP9d8Cd9duIgMtPYQrE591yY1pX6/xCkbCgk9abA9wJuyCIaKbwDLa2xXQctfWVp3sL/MrfPpU5MaUIRatqUjCH/yi4djXEOurmE1KkFcu+dVWkJzJEAST7ykxxZax2GXyy2jQ+HWF17Q3hp6GkHt7wOWz7OuKCwb/Pq8Y0jDfNtTX/u5TuyEE23EHXp1iS9e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aPKxfDVSQJc4t9gXANVGJ/9Blrn3AsQmuxmchi8H/NLrdHpog5N8ODVqpvtxcvJL3RiJfwalT10Wv6I7NETHwjizPFCdQufRmdYnlL456Qo2zpvIp0c2QvEfx2CIjt++QRFWThkhYShzbjN8NXmtDCk/XKma2lsdYftgIesehyZEv5YQl5OJccyyuu2U9Vohdya/l6rV5p4JBhLb4BfAm//QmbpfkDGlPiCbgKebZfOTFdHMXC/TPZGNPx9N/zYNTKr+Y0E9bk3Mq/xLwMxjphxK3J82NbJImxf6Q4V/us/+NIgHBVKuE/3mvGkO/lm48WmDdK9kaOWvq5lyE1b9ffgxPCeQqBLoA7zf/ofGSwd161ixT2rXOaBoRJIMCSze4VGaxpHSV0msMWkgKVZWS/FfV2JE0eliv1Yk9ns4kj/jZWF8N30EKld0NQqhTM0OY9Io6tHEuB4izRv5YSfH/ro9R8RIGcd9Bi2fdcso9sxoEJoP1rfspgY6vnzd75wsH8K4PGhTQbIaTkKKWp1lIzNWS9sTvP0X5ABPvubDoiS7kDeG2GC1DflKz+NQTPNYq8EcRRBcEdzqibjCYbmrUVn1Zz0OoTiIJvVpNrp2l3dhUl6u7k5rs2vys//2IXI3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mUBkf+1BpgXixD5j5HpcsV3VbedvsANPh6qhPuGLuncmtUcqQHdajDRhFeh4?=
 =?us-ascii?Q?rPqRukVz0kWcRB4uf7Od0GZQrKem62aCdhutOP+sgu3ikTueD3g7A9pphEve?=
 =?us-ascii?Q?FdN6Ave0VhIckC7J/MLP2siIlHF2qce3jf9SA7PxKsm/TcpVMB2uBeVdKYGm?=
 =?us-ascii?Q?vXu8VI7HCTZxA09UyWBZY9LbTgqBJix7Bvvu1EbdzPu4t7sP98zISPxsnZ+N?=
 =?us-ascii?Q?9m4XbKbWYhwX4LqGvnkxP1GcVpyJql6ZpS795XKJm05NogvKDWyjgwoRru2P?=
 =?us-ascii?Q?dmzkKj5OAtSROL3EqbnsuGN4eNoz+576jodAyWpNdhOci38MkxuPpFrpaUU6?=
 =?us-ascii?Q?+nwJtj23sqLxx6EX79Y68qkVgI1xRy5+D250h6mrpwOMhbLzmADEeqZzMD+a?=
 =?us-ascii?Q?p16fUNq85dYB9G7nhiLeL3eaTvCpzNqu2QSEGE8dWuwbHzlBpYuc3R8hSq6+?=
 =?us-ascii?Q?ieSlNmERsE9yl+TeAPqOyR1QsatnkDAdRP2sqKNbuYfJACbRfkx5UPIaXWt7?=
 =?us-ascii?Q?IEyr/7uz0puC7OP2YtasolXtXFulv0m29V5dOYGacOPQfg0CwAIygV1fDx94?=
 =?us-ascii?Q?ySm4EE08g4yTAgeMd29eV1GE39GVkb2gG8XkIPRYUuMTnxiPxt1HI6EKseJU?=
 =?us-ascii?Q?qDm7rjg8d+zlssjju+hHaLCVBqFwnW54x5f8Y3cuC78LYElad7LAlyfnI/vJ?=
 =?us-ascii?Q?EWgmVSiTsRhkHmfO1efTCCYrgZLlxT1q6M86wqDLuBC111WB7S81y7VXsdYR?=
 =?us-ascii?Q?DlIIXtg2RXl89ctR/EniXQ3wc3qaJPxkmfbK0AUs9sElWSe+DYBt0N5Ud7jN?=
 =?us-ascii?Q?2C69xICY5k28FG1Wsuh1bJLMB4uGZ8iRf3ZnD5TtDteb5TSM8wOyy8rLWqiV?=
 =?us-ascii?Q?4qLIci/ZVNi9Q1jrWQy+Rij8PRBSkj+nEoF2QS1Zr8DfnTwDCqLHvtofFk0E?=
 =?us-ascii?Q?NqeNqNUpogGXTo4mVLgLKv8ZeSScETbUmhUkNCG4M2CSAqqWObSrTwOD1rKs?=
 =?us-ascii?Q?E/a7pNYLDm85ogXjKbsmhzpOJ2lEk81TQj/JPEfFafL4HIPJhxTJbrmxU0AH?=
 =?us-ascii?Q?twAnWy8UyHmyawLmiLJVwMcIaQlSA4/VDZfHSpCJdfcQTjRu3ygpUW7y/BUA?=
 =?us-ascii?Q?7gZjtiqsHUNdrLxQb9a9iXn6lezK0bH3x/a4s6DaOTz7uTJjxGjFWRnhnsOc?=
 =?us-ascii?Q?R3D7L9wh412jxL2D2u4yUgGbPfo8El506/1pIFYYNIx9GtBjDrZVnisvmuQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 44336afd-7347-4edf-0bca-08db56fecc40
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 17:47:35.6257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4885
Received-SPF: pass client-ip=2a01:111:f400:fe5b::813;
 envelope-from=chaosdefinition@hotmail.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

DC CVAP and DC CVADP instructions can be executed in EL0 on Linux,
either directly when SCTLR_EL1.UCI == 1 or emulated by the kernel (see
user_cache_maint_handler() in arch/arm64/kernel/traps.c).

This patch enables execution of the two instructions in user mode
emulation.

Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>
---
 target/arm/helper.c               |  6 ++--
 tests/tcg/aarch64/Makefile.target | 11 ++++++++
 tests/tcg/aarch64/dcpodp-1.c      | 47 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/dcpodp-2.c      | 47 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/dcpop-1.c       | 47 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/dcpop-2.c       | 47 +++++++++++++++++++++++++++++++
 6 files changed, 201 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/aarch64/dcpodp-1.c
 create mode 100644 tests/tcg/aarch64/dcpodp-2.c
 create mode 100644 tests/tcg/aarch64/dcpop-1.c
 create mode 100644 tests/tcg/aarch64/dcpop-2.c

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0b7fd2e7e6..d4bee43bd0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7405,7 +7405,6 @@ static const ARMCPRegInfo rndr_reginfo[] = {
       .access = PL0_R, .readfn = rndr_readfn },
 };
 
-#ifndef CONFIG_USER_ONLY
 static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
                           uint64_t value)
 {
@@ -7420,6 +7419,7 @@ static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
     /* This won't be crossing page boundaries */
     haddr = probe_read(env, vaddr, dline_size, mem_idx, GETPC());
     if (haddr) {
+#ifndef CONFIG_USER_ONLY
 
         ram_addr_t offset;
         MemoryRegion *mr;
@@ -7430,6 +7430,7 @@ static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
         if (mr) {
             memory_region_writeback(mr, offset, dline_size);
         }
+#endif /*CONFIG_USER_ONLY*/
     }
 }
 
@@ -7448,7 +7449,6 @@ static const ARMCPRegInfo dcpodp_reg[] = {
       .fgt = FGT_DCCVADP,
       .accessfn = aa64_cacheop_poc_access, .writefn = dccvap_writefn },
 };
-#endif /*CONFIG_USER_ONLY*/
 
 static CPAccessResult access_aa64_tid5(CPUARMState *env, const ARMCPRegInfo *ri,
                                        bool isread)
@@ -9092,7 +9092,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_tlbios, cpu)) {
         define_arm_cp_regs(cpu, tlbios_reginfo);
     }
-#ifndef CONFIG_USER_ONLY
     /* Data Cache clean instructions up to PoP */
     if (cpu_isar_feature(aa64_dcpop, cpu)) {
         define_one_arm_cp_reg(cpu, dcpop_reg);
@@ -9101,7 +9100,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             define_one_arm_cp_reg(cpu, dcpodp_reg);
         }
     }
-#endif /*CONFIG_USER_ONLY*/
 
     /*
      * If full MTE is enabled, add all of the system registers.
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 0315795487..714a30355d 100644
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
+AARCH64_TESTS += dcpop-1 dcpop-2
+dcpop-1 dcpop-2: CFLAGS += -march=armv8.2-a
+endif
+ifneq ($(CROSS_CC_HAS_ARMV8_5),)
+AARCH64_TESTS += dcpodp-1 dcpodp-2
+dcpodp-1 dcpodp-2: CFLAGS += -march=armv8.5-a
+endif
+
 # Pauth Tests
 ifneq ($(CROSS_CC_HAS_ARMV8_3),)
 AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5
diff --git a/tests/tcg/aarch64/dcpodp-1.c b/tests/tcg/aarch64/dcpodp-1.c
new file mode 100644
index 0000000000..47c466a9bf
--- /dev/null
+++ b/tests/tcg/aarch64/dcpodp-1.c
@@ -0,0 +1,47 @@
+/* Test execution of DC CVADP instruction */
+
+#include <asm/hwcap.h>
+#include <sys/auxv.h>
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#ifndef HWCAP2_DCPODP
+#define HWCAP2_DCPODP (1 << 0)
+#endif
+
+static void signal_handler(int sig)
+{
+    exit(EXIT_FAILURE);
+}
+
+static int do_dc_cvadp(void)
+{
+    struct sigaction sa = {
+        .sa_handler = signal_handler,
+    };
+
+    if (sigaction(SIGILL, &sa, NULL) < 0) {
+        perror("sigaction");
+        return EXIT_FAILURE;
+    }
+    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
+        perror("sigaction");
+        return EXIT_FAILURE;
+    }
+
+    asm volatile("dc cvadp, %0\n\t" :: "r"(&sa));
+
+    return EXIT_SUCCESS;
+}
+
+int main(void)
+{
+    if (getauxval(AT_HWCAP) & HWCAP2_DCPODP) {
+        return do_dc_cvadp();
+    } else {
+        printf("SKIP: no HWCAP2_DCPODP on this system\n");
+        return EXIT_SUCCESS;
+    }
+}
diff --git a/tests/tcg/aarch64/dcpodp-2.c b/tests/tcg/aarch64/dcpodp-2.c
new file mode 100644
index 0000000000..3245d7883d
--- /dev/null
+++ b/tests/tcg/aarch64/dcpodp-2.c
@@ -0,0 +1,47 @@
+/* Test execution of DC CVADP instruction on unmapped address */
+
+#include <asm/hwcap.h>
+#include <sys/auxv.h>
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#ifndef HWCAP2_DCPODP
+#define HWCAP2_DCPODP (1 << 0)
+#endif
+
+static void signal_handler(int sig)
+{
+    exit(EXIT_SUCCESS);
+}
+
+static int do_dc_cvadp(void)
+{
+    struct sigaction sa = {
+        .sa_handler = signal_handler,
+    };
+
+    if (sigaction(SIGILL, &sa, NULL) < 0) {
+        perror("sigaction");
+        return EXIT_FAILURE;
+    }
+    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
+        perror("sigaction");
+        return EXIT_FAILURE;
+    }
+
+    asm volatile("dc cvadp, %0\n\t" :: "r"(NULL));
+
+    return EXIT_FAILURE;
+}
+
+int main(void)
+{
+    if (getauxval(AT_HWCAP) & HWCAP2_DCPODP) {
+        return do_dc_cvadp();
+    } else {
+        printf("SKIP: no HWCAP2_DCPODP on this system\n");
+        return EXIT_SUCCESS;
+    }
+}
diff --git a/tests/tcg/aarch64/dcpop-1.c b/tests/tcg/aarch64/dcpop-1.c
new file mode 100644
index 0000000000..c9fc5b7e57
--- /dev/null
+++ b/tests/tcg/aarch64/dcpop-1.c
@@ -0,0 +1,47 @@
+/* Test execution of DC CVAP instruction */
+
+#include <asm/hwcap.h>
+#include <sys/auxv.h>
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#ifndef HWCAP_DCPOP
+#define HWCAP_DCPOP (1 << 16)
+#endif
+
+static void signal_handler(int sig)
+{
+    exit(EXIT_FAILURE);
+}
+
+static int do_dc_cvap(void)
+{
+    struct sigaction sa = {
+        .sa_handler = signal_handler,
+    };
+
+    if (sigaction(SIGILL, &sa, NULL) < 0) {
+        perror("sigaction");
+        return EXIT_FAILURE;
+    }
+    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
+        perror("sigaction");
+        return EXIT_FAILURE;
+    }
+
+    asm volatile("dc cvap, %0\n\t" :: "r"(&sa));
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
diff --git a/tests/tcg/aarch64/dcpop-2.c b/tests/tcg/aarch64/dcpop-2.c
new file mode 100644
index 0000000000..8f8ed81720
--- /dev/null
+++ b/tests/tcg/aarch64/dcpop-2.c
@@ -0,0 +1,47 @@
+/* Test execution of DC CVAP instruction on unmapped address */
+
+#include <asm/hwcap.h>
+#include <sys/auxv.h>
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#ifndef HWCAP_DCPOP
+#define HWCAP_DCPOP (1 << 16)
+#endif
+
+static void signal_handler(int sig)
+{
+    exit(EXIT_SUCCESS);
+}
+
+static int do_dc_cvap(void)
+{
+    struct sigaction sa = {
+        .sa_handler = signal_handler,
+    };
+
+    if (sigaction(SIGILL, &sa, NULL) < 0) {
+        perror("sigaction");
+        return EXIT_FAILURE;
+    }
+    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
+        perror("sigaction");
+        return EXIT_FAILURE;
+    }
+
+    asm volatile("dc cvap, %0\n\t" :: "r"(NULL));
+
+    return EXIT_FAILURE;
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


