Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56563708C97
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 02:03:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pznZn-0002rR-7U; Thu, 18 May 2023 20:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1pznZk-0002qy-Vu; Thu, 18 May 2023 20:02:29 -0400
Received: from mail-mw2nam12olkn20811.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::811]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1pznZa-0007Sk-I6; Thu, 18 May 2023 20:02:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rc7TuESfzgWFbULYWya8i5BFFCRp7HD90nf5q8zBuo+EDNDd3YkDwEROAtPze20lNVQnhR2eYxdc9Vgu/s4SqNs7wr535HDuy1BcGS0JUKYfXD0/rUJBowRAKRm8GiObKe+LCtuj1pZs1CC4Lu4XCmlelC1kPN9jKlxp8M4RpPasuLykQ6Ar8RRO+D1zR8vGpdRjzQWHIBQhDzAbVDBtSlYo6liTFSn2Qq16wlVcALjGq0j253sp6s/Sq06IUYjFurAcBOsUtpAHmRgACpeMhSGFy3jSuUfNvdwlnPRMv8dDCsvYG0MRnb5dAlD8b0zy2TIG3HaNR8YxtPsevhlI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVhbSTn1f9xXwvJ+hF0swcFm8FM4hyHM9DIsrQ1twmY=;
 b=hgG1g6X3n9gSdBrtTsM3YnjbDsxCmo6RQNKs3iPGBkEUAi0lV+yCQ7j3Anjfo9gpepLjiJ2bV+1svb4jcDL1FjQI5mu847Tn4vtfK0GDmXaydgxSgbYj5/WmjYJsgcuFRxdlKA3DzmIujbaXti38AuG0l1bslUm+B6FZ2xf7n88Pqlm7a0umr89c35KCOVvtqu2wQYxuU95ytw8UEFIt9icpwcYT87NcSipYBEwgl1zAaCsbnBfw3Fv/VcJDnRXzZDb9G/AF5h48OOwMkFqMf6iKRKY1bkrh7+oeZxV1zKsZn8EzW6PCN2Ua0oX9TnnbTl4ruYvhR8getz3eBCgafQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVhbSTn1f9xXwvJ+hF0swcFm8FM4hyHM9DIsrQ1twmY=;
 b=DcK/UxcNmhmKWGkd+RB+4jxW5wT4vLCZeavbjtRLUgPXcLrX6L7Tsc427wd2XtxozbrbD3D7i1nPHTZFrRKSbYsn3mGobEJAQUP1D8PGVrrxszmzOKq88uTNrRXRHjzN7bTIU6y5Fmw+YkBTRdH84HsrBv8j26GwZ736J6psF65W69rZcAb6dZGvVizzE6xthQY1jeQ5A2i5p/fPkUXFOPHkzkeMR9CgBmU8dKPYUo/DJT2AdGJOnfRfX4ekFekBj9JiOq9AkRDDi2Zx301KY3WCH3ggxt0bkvxQPrRwHKShFD0CEEP1QORWOyH4ZmldfmjWjlz5FqVtVCmucpZtOQ==
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 BL0PR12MB5009.namprd12.prod.outlook.com (2603:10b6:208:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 00:02:15 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04%3]) with mapi id 15.20.6387.033; Fri, 19 May 2023
 00:02:15 +0000
From: Zhuojia Shen <chaosdefinition@hotmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-arm@nongnu.org,
 Zhuojia Shen <chaosdefinition@hotmail.com>
Subject: [PATCH v3 1/2] target/arm: allow DC CVA[D]P in user mode emulation
Date: Thu, 18 May 2023 16:46:04 -0700
Message-ID: <DS7PR12MB6309FEE04197EC96CB8969FEAC7C9@DS7PR12MB6309.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [4R01G/2pnwzwiSrOd5KA/u9AvrJKPrfQ]
X-ClientProxiedBy: BYAPR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::19) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
X-Microsoft-Original-Message-ID: <20230518234605.276443-1-chaosdefinition@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|BL0PR12MB5009:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ea78b6-f843-4dc0-1801-08db57fc4d76
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3nvAoS/oQTVQZ1S7Y8lGJvUp6lYURevRgk8qr4GFMn1LZaXms26drGpPUTdOpg40zesN1WJ0LjHyXZ3x5krrkx5jM9T2y2TZQ5zaQaea6Gw91RY3KT0eFGZvAVcIYTrfvpfcJXRN5N2B0DYcWDfEamCigj9dxHYpE7q+/RSraNaX98oYNOaRyaL6bZ0Qav5lESmr3MpuDfokdRFX8npPbUaOSOjZzKODIsIsTkjR+Rxn1gau1oNdLIv4TZXab9ndp4HuU156U+iPouc3E9pSwZtgpVGOmr6Sl79GxgA2dy4N7XBUex/p1rVSmjTgf4kajdIkTg8Gr5xXNUQFcjNEOlLLwT4lrp1Xf9MPpZYrOk/z/UVKq6Dqy/7zovUplhms18PG5CUSzsE0rDOZ1UTLuM4mE7QKTdx5au+aKRZoF3N9XiAAi5oTWXoEEdz/RvT74i5f22ASTnILDGbrIqrpka4P2c4xlTg7tZJha++xM9nsAnSAtwqSfYDvbemqrSdLj3ZaDrV2RcBIcbD/PNjExQwkbAdBfCMXlh4M56rh6BlEL2yq/bsMB7EFtFrgp6dFRHzCWMayLZ/fR2cxPBgiMc84DVRqHV3RTpq1lVfFB3tMRGduistI0dYDLwJ/0HN3EpFPnHk8a+8v1th5VQ6kZKHtOiOl60qHh094xwRBf2eyaG9aWhMVlTNEmvp9BTlFJxPO54zssdZteQI8KvW2CfrensOj1AoMPzHUZPizhH3KugYYZFz54C0zxRDkniMtra9T8Zy8OoMrkOIJSPSulE3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBpq/+fq9BxaWZ1USornF1i/+l/dh80j3d17FRPXQ1gFQZ13JXHmgaeZffkpHfGE47pWfK+GiQHhqwI3wvjUc8AlJtZgsOads2QjF2lyw8T2LYWGX7kzuVGkdYRQw74QUCWXTO6MLMIkXRhh2gAEw+OFgPGmK52r7ZsAjaQAQ3zDv7H2zfraXs0W+ckqjkFFxSACl4IXHbbTikqGxs/u2cK70mkoJZLSYMNV1rrh9apOANgWs4VHtGkmj+GhSU6mhK8Ns7xDslL+1OV1/PgmQ9fuqiWlDwKl0hnucaPD2HdKHaXKpyXsLyTfuNFNosscXfZMlFjIG1pyRr6IxUNenIsg8yCE0ygEMXpe7LfZfFePjaLSQZVfxScPTAEx05/ShsEdpVBoLBcfHym6PEDiYo3jZLsd8fc6YkbjlnLueIPAOHCbKj9qc245JqEophhT1S90HC99Z6QPdbc9e3SuYPhBic805Pt3UrszPEkjrILNRsDZ6Fdkk6ZCEwliOUtXfk8u0YOqnwLnUYJZbk9i53GifDFxL827e6Uu7OH6pDCEhBcxs+WzOTeKg7napv+NB8vFzYDYxo1qpTx8p/5suyj3nvr5+iJ5XPhgfaWDk7GaZQUfbUd1dIZCt2uEXgoA
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dDjaMzZzzXdbY8qzEJ/s+AMZpf6PCL+t8GdqN93/rArR6y7yJjPTcrY4brM2?=
 =?us-ascii?Q?6pu1iSjBYigGx0cshuw3HykNvvwdDbxkVJs/peT233ZRnmMyegc+aBsTzJRg?=
 =?us-ascii?Q?mdzIpUg2cL40tfFG1z7Rhgs+kMybK89LVuu2pDkp8+l0tBoywun0XIJdCwvH?=
 =?us-ascii?Q?AhSmfKV1Rf7RzLCTxvCz7VgGcG6BvO8eIpXmtEoTgE3D6iWZ1Bfp8N5NKp43?=
 =?us-ascii?Q?i2ZGVdrYPY5v/FyWfJjZLC9d031jii6SshiDEwYls38NLyUleV1nwjNzJY8F?=
 =?us-ascii?Q?OWXueb+hCu7Yvxtikos4slfe5H4D0t4EgQd0AeTu0H1rN1/0K7X3olpBwjHV?=
 =?us-ascii?Q?73FWYuujm+qtGIg92hU0Akd2Y7A9Cmgq3X3cCuQmXBaaDuBYBq3/ZrGq4ljP?=
 =?us-ascii?Q?TqCODxaTKY+5T74P8mP6gX7JME5xchTRuel3rOrd5AaE9hu1ZnMvBe1h1YrO?=
 =?us-ascii?Q?EVdkZEoarABHUjIHK8lrCMWo4yIRRqk0v6bFN0YFSq88rJcQo20Ms/cooh2G?=
 =?us-ascii?Q?1WYgGi+iioph6UI1BSW2xk0CaUmVSCMWB2YkUqzwxevGqgpfsKRCYk+7wuFx?=
 =?us-ascii?Q?RhqegddhuA0ibGUvY/jQDxiaoFJfWhZffpTJWw2XnjNKiPtUd/GrYav6AfVI?=
 =?us-ascii?Q?Qj73Q2CeaXj6POSK7QYXP/4We8CKQ6fhxcMmQepTHV+Jd4g64EnONw5UtCCa?=
 =?us-ascii?Q?4N/dKQc4fieKZXCcdfbLjUFSalcFfDJi11ylb8laiLNBcdT0a+DYQujq993j?=
 =?us-ascii?Q?aTKVlnUPQqSufYgwYW/6xYGBgt13jhz7vZ0/qColLH5m7p7gm8ViQCR+vAhU?=
 =?us-ascii?Q?0d7gIoH1oydJXg3Vbgb3mGpuMkVSNkaWp4tPhX1/qilm0XqGTOgru160skRK?=
 =?us-ascii?Q?prYjr7GQ8+lKwLG3bsDR2oBwxRM1+vQyTxgwaQCaQgVz2WjD9Rr2R7OFwFnC?=
 =?us-ascii?Q?z62GjPAdU6Ob/DtZMu/wZbR8nj+RhlFI6IfehMV/L0zXjpE/p4q7jjJiVKmT?=
 =?us-ascii?Q?KCGjdzgKwlWekfEyLRhA9ErXx/YoruIoF2BqUnAmcYOwxbqHt3eIpoP2ay/K?=
 =?us-ascii?Q?laJRBKD+mH/UVqKZaIvgTp2QYfQqJ+gykZVjzCf0SnNXACUqJhxnf2DMp6jc?=
 =?us-ascii?Q?lKvOyLqZQhcu1Yzn1uemc4BPrPxyyPlL/ZiSgo/RzFGg9ZCJdfozH0Fgv3v5?=
 =?us-ascii?Q?fjxhTSFaGKlAy/ipGF6aFkhlbig7Fo110R1W6LSq0hX6hQbS4UuqBlh87z0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ea78b6-f843-4dc0-1801-08db57fc4d76
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 00:02:15.0443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5009
Received-SPF: pass client-ip=2a01:111:f400:fe5a::811;
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

DC CVAP and DC CVADP instructions can be executed in EL0 on Linux,
either directly when SCTLR_EL1.UCI == 1 or emulated by the kernel (see
user_cache_maint_handler() in arch/arm64/kernel/traps.c).

This patch enables execution of the two instructions in user mode
emulation.

Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>
---
 target/arm/helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

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
-- 
2.40.1


