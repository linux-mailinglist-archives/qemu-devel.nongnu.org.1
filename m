Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7831A72A12D
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 19:25:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7fqY-0006za-BS; Fri, 09 Jun 2023 13:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron@os.amperecomputing.com>)
 id 1q7fqG-0006yJ-Ib; Fri, 09 Jun 2023 13:24:04 -0400
Received: from mail-bn8nam12on20703.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::703]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron@os.amperecomputing.com>)
 id 1q7fqE-0004mw-VH; Fri, 09 Jun 2023 13:24:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evDJpxaUsn1OHKHax6zBK1cJ84bwP3Mj/X/wC3ec4YJjZKJSch16ygiCarFkYLXBRr7sRCV0/ZOqLpsLSSdvfVs9jRo6lHEUW1z2n7RVw+hecnBNLwkbGxIrOo7vKrTK9R6cACPoL/vlRIavDtVb+xHW7yamIyOiukDnIn9YR80+pViyvnQvYKWzijetoGIkGX7qobv3501jW6YII6HU+C0H85KToS+/gAACm6s3tYz31E/SMklPjx6UVlv4yOszp6ansvIqdtKp1jP2odYY0JRVLpnh9MvVzYSM0zVtM/EiWQoKegy/DMEOqM+PDvcMdwyUaJWcF8Yd2I1ve4hphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5O0U2P+y5TeFeDFmULhjEX93KahaFs/lwrUMg4Yx28=;
 b=Xfn6TaiktibldD12M0fEzAAHp+6+KGHcmFS5pc9p19xc7NXs1qtQgDxdYrbzTceeq6SZl+splbnlIVXi6vdh9Sgq6HgOX9RmAoNqeE8283xfFgB2C4gBNbF8pd6JPz/57iL13gSOE6k4modm74/LMRKBZg0pil4SaVrO7KXzsrUNzlnSG8L2EoT3nZyHeQM1/CX5EBnPwLkkivBzsmplif0xSiziJml3ZBmoL9wCgcPqqgrNt5Fk67K7YiPTBBGZ7+xF/gGOog3ucnz43J4MEkz8jU6Fk9wHNkwzJDsus9qZ3F4sl02DiQBv2p8GF2s0Rs5R60zG4F3ZHPLvQ7XHvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5O0U2P+y5TeFeDFmULhjEX93KahaFs/lwrUMg4Yx28=;
 b=MAUi1dpUTCGZw28Zjrb+ggFZBeUtqV+uVN7Q202pZ/DS1xYrj/RRx5AUuj+HEfIHbkRDZeo5N/16zLJLaqb5nz63dQIS2Ugd+P7hV38eFdlwzls8vIZSQZKHgh45h85wJbmHYi/QzAKXvPfYnzNFvJSm/mfP0k5gWIfecY+5Iy8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB7124.prod.exchangelabs.com (2603:10b6:610:f3::20) by
 SJ2PR01MB8481.prod.exchangelabs.com (2603:10b6:a03:562::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.44; Fri, 9 Jun 2023 17:23:51 +0000
Received: from CH0PR01MB7124.prod.exchangelabs.com
 ([fe80::9a78:4703:c6a9:16ed]) by CH0PR01MB7124.prod.exchangelabs.com
 ([fe80::9a78:4703:c6a9:16ed%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 17:23:51 +0000
From: Aaron Lindsay <aaron@os.amperecomputing.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Vincent Dehors <vincent.dehors@smile.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Aaron Lindsay <aaron@os.amperecomputing.com>
Subject: [PATCH v3 1/8] target/arm: Add ID_AA64ISAR2_EL1
Date: Fri,  9 Jun 2023 13:23:17 -0400
Message-Id: <20230609172324.982888-2-aaron@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609172324.982888-1-aaron@os.amperecomputing.com>
References: <20230609172324.982888-1-aaron@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:610:b0::14) To CH0PR01MB7124.prod.exchangelabs.com
 (2603:10b6:610:f3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB7124:EE_|SJ2PR01MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3dbb7c-885b-483c-a05c-08db690e4b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZYaD/WcjYhDJ+mJnATGDShqfJ89vq8e6O2X87JlW99DuguvO0451M1e8u71CL+7OCXk5d6T0+pWDinMtSTaoT2SGiki0jQt3Yya/iBfRW82UamxJ/NGCLZZsPTFMh8USC49HwnFPwzoYvbKqn9TZWG1YhHVqsX24WrfUCZ8AoFSQcWLIofSYXwE3lsYd45o6spzRcUw/u4mEj27VDNwQrgkotu6f2KUp+plWFnjOuH3K87UqCccfmpRsd9sqXRrdDk1J27CXTYPZLXILVniRk3/E1gbUal5lbEbHUK/TYpUAQTucXZ89tJjIxtKUNyyC9kjbG5QXbr1tVjwP7ETIMjW03xvx1uiYP6+0xN58oSCnW1tYVdgSPx9iIhi6er/Ys8aJzZUFdelURiC34VFL1pdY7d3UFppLY9U7GAA46ylKQ+0kZ9ZKVFdb6zDJqMTtvfjgsWA5uIxcUHbWlIGqDXSIQUCk+/IbxB9EH8yTe1K3rwfsPfGGIl2+YDRzsuALsMcG6Qix8ZHZSdoFVGwwrlLS6CoCqpOoZ9nSE2QBZjfZQ/Fwk2EJLlqpHARGOluOlnOC5LoFasiyRADLhTrM9YllJG0Wr2cTJTIkXwJjKvMxbY//ZM6acXHoJ+gcqkS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR01MB7124.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(346002)(39850400004)(396003)(376002)(451199021)(2906002)(83380400001)(26005)(1076003)(6506007)(6512007)(478600001)(110136005)(107886003)(52116002)(6486002)(6666004)(8936002)(8676002)(41300700001)(5660300002)(2616005)(66946007)(66476007)(4326008)(66556008)(186003)(316002)(38100700002)(38350700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cRyTW02TTksbgHE62ysLiN1P7V54diDQfn3cJTnbhTnITPE/398Q6b9m7ecp?=
 =?us-ascii?Q?OSyh2ncY6M9j9DesA2ZnAr6aR2W3JvNaS27RQCa46T5EYimJfF2RJAaqhiF6?=
 =?us-ascii?Q?8XNOL91TZMzs0EexcHNznohX1oKhfr/0utqxkV0VMEaxxlYblkYAyIEufHAW?=
 =?us-ascii?Q?moR+5PribqdmzFsnOMPJzaOXr/hj+UosGA/xck1QThabGOHW4+qrdgE9yJ/S?=
 =?us-ascii?Q?TAHW6Y4SyH+4UFkve7yhvfMsyN6CakG5ZmAWKbj5eZpnqWgVsd2KpB7UjsLQ?=
 =?us-ascii?Q?WCrdWb0tTzi6ecgtDI77+goghul32scxIl3qqWZvyRLw8WMm+pROzn+/hw2R?=
 =?us-ascii?Q?FKYfmuT7bzreRP3/OaZ8DvlDAGwQopbwX7iVmxl58UJNVn8uqZV1ksl9WauY?=
 =?us-ascii?Q?5Q1oGuQHBzXvMYJP/CSZ/pnr3BfhG8xiKGPwK2HOB3JGZ2YdhqfdZPbPXHbL?=
 =?us-ascii?Q?faHNZKGPMHVxDj0VjllWYhBcE9dZODb5Kvbvp6VVRa8D1grOQJEkPK69Eq3x?=
 =?us-ascii?Q?JBHr41PGlR6bSLJYr2t8adkM43G/XM/IE0laKzVDtlUqijNnVjqQQlcjLWM7?=
 =?us-ascii?Q?jnbYOTtd50gqYogvbazEngxCDzQ4dEfWmK18iWMTGrFq6b+Vt2jnXjvsak/0?=
 =?us-ascii?Q?YRgsPUt0q4qqX4JY0ySa8QejGepVTGBNEiX4PxBFb9o0YfbUFmvz5PTJSscl?=
 =?us-ascii?Q?6X173oD34kZv8umIAaMtStGDyaYwFt4lvPvwyBZWc7r/4uFAXiSyby2J4ZZC?=
 =?us-ascii?Q?o4fwYdO4hAeWpYdmd17uz6vcLR9Pjrcv+sxWGHRbZ3lfHyWV5g0sHQ1dFAjC?=
 =?us-ascii?Q?FcjII2x6GT3Dos78meliTYqAmlAIw2DOXsYNlxKCGtlVxJsEismCd3hqe8fK?=
 =?us-ascii?Q?/sO/2ov/Tta8tQ+SQwfIOreUJhrRrQ+xj2+UoEpPMblPEwFkTkU9aUaPRn2k?=
 =?us-ascii?Q?pKEZqGyo6zveKgX9uoJ97CT1fP+YNvDjBoUT+wq5Qi4mQ0qccAQDzW0MDlEy?=
 =?us-ascii?Q?DaWrpgJBkhzwu9qFyTT6r0ioelrlMiLEJ3xnBXRW7ptilYnDtSnNj4ZRroGD?=
 =?us-ascii?Q?3sXpwGGpkNaaYBG+pAPTAyCtC9sL4K4HXkhFgKsKD5o2GTQdkAj0Ra2MQMlu?=
 =?us-ascii?Q?5aaccG+V2fL5kJNmRMK+zDqXrEMu398e0rOgKVPiA32y5mvCNF8QHTnkI8Bi?=
 =?us-ascii?Q?g9238OOKZCT9gjPLdSvXIteI8sVebIYoHg+iWUbZUA+3IBu1ZwKxhjDhhzZF?=
 =?us-ascii?Q?xgAPWba7IKoof1VTy/qs56WcDs/Cyg809WB0a9GGjP+v4WJ7sBaz0gL2NXAl?=
 =?us-ascii?Q?CYfACdSohRlY+rNF7wvk8FvF1pi963tV2n47O/y8GU9KL5W9qpaDA8OTGA6W?=
 =?us-ascii?Q?95z9sYmW4lh1g8SFOUDjNa0gwEXb0cLDNrv37XYup7DaI1cuKYqjOQqnNv8S?=
 =?us-ascii?Q?bZNQ2y8D7T0LHCpjTT8feIItnlCIbe3NJOXlE4Lii8z2PahMk5yALnsmxqAt?=
 =?us-ascii?Q?n7OPFslIJA4i8f3C3kxPNy3XNUXS/e8kC4+7V2Zjvei6He+3uZ2rbERu+mzk?=
 =?us-ascii?Q?y2GB82mNEWq9XJSWVwfpVDbAwLvfaBtCfeULtzhWDKmX6s20s6Gdu7JRbmSx?=
 =?us-ascii?Q?Qud1nJQSkeq90woTB3mT2eE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3dbb7c-885b-483c-a05c-08db690e4b0a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7124.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 17:23:51.3966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eS8FbJCu6xd1i7sIR0qVWmpMz4PUt+Tq5j73lBpuJCwqpi/kI3ZAJUDXvqRHEd2uVrWuB7vUm4oEo38OiO09DBgkRBGxAWaqcDRWE8QmTsmCX8VgHP0SXe4OP+0s+V6Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8481
Received-SPF: pass client-ip=2a01:111:f400:fe5b::703;
 envelope-from=aaron@os.amperecomputing.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
---
 target/arm/cpu.h     | 1 +
 target/arm/helper.c  | 4 ++--
 target/arm/hvf/hvf.c | 1 +
 target/arm/kvm64.c   | 2 ++
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 36c608f0e6..df04c9a9ab 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1023,6 +1023,7 @@ struct ArchCPU {
         uint32_t dbgdevid1;
         uint64_t id_aa64isar0;
         uint64_t id_aa64isar1;
+        uint64_t id_aa64isar2;
         uint64_t id_aa64pfr0;
         uint64_t id_aa64pfr1;
         uint64_t id_aa64mmfr0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d4bee43bd0..4ced2f71e5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8204,11 +8204,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
               .resetvalue = cpu->isar.id_aa64isar1 },
-            { .name = "ID_AA64ISAR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64ISAR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = 0 },
+              .resetvalue = cpu->isar.id_aa64isar2 },
             { .name = "ID_AA64ISAR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8f72624586..bf567b24db 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -847,6 +847,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         { HV_SYS_REG_ID_AA64DFR1_EL1, &host_isar.id_aa64dfr1 },
         { HV_SYS_REG_ID_AA64ISAR0_EL1, &host_isar.id_aa64isar0 },
         { HV_SYS_REG_ID_AA64ISAR1_EL1, &host_isar.id_aa64isar1 },
+        { HV_SYS_REG_ID_AA64ISAR2_EL1, &host_isar.id_aa64isar2 },
         { HV_SYS_REG_ID_AA64MMFR0_EL1, &host_isar.id_aa64mmfr0 },
         { HV_SYS_REG_ID_AA64MMFR1_EL1, &host_isar.id_aa64mmfr1 },
         { HV_SYS_REG_ID_AA64MMFR2_EL1, &host_isar.id_aa64mmfr2 },
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 94bbd9661f..e2d05d7fc0 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -306,6 +306,8 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                               ARM64_SYS_REG(3, 0, 0, 6, 0));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar1,
                               ARM64_SYS_REG(3, 0, 0, 6, 1));
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar2,
+                              ARM64_SYS_REG(3, 0, 0, 6, 2));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr0,
                               ARM64_SYS_REG(3, 0, 0, 7, 0));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr1,
-- 
2.25.1


