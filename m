Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAC578F714
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:26:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtpn-0008H4-1P; Thu, 31 Aug 2023 22:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qbtpk-0008BA-7T
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:28 -0400
Received: from mail-bn8nam11olkn2010.outbound.protection.outlook.com
 ([40.92.20.10] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qbtph-0001XL-UZ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8aIVlFNiETY7a297dZCefJUecJhIf7Cmy5DegilMT1J1W5wL35TnKZ2KSl6KY7+1sDB+/P84wTv/mOBKxlTGadx7YNgjtYpKdlZEj7nuVV4DM+VvKic31KiQef79UP1BfrYnLirzvEaye+jYPdXEoUVyRHvPs1ixm6GRYSqTQM/77/Dog4MY+za0+0jUgkwZ8bHU0tOVmD3SJ3pRvHYuqIFXmgVkRT3sGNdPplxDraimrI1uZOByzCNQKhePYtPiSxtjCJ7KlZNxIz1lJtrPqDMPufayqzO8+ZW4YnYZwHDSKrjJhNI66vi+hVErQrdwcfBANP1mf6+OoveZPMkcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlOZUy0JAVkbapmLLpiv5O4u2EMOH71mIiQfR91rGdc=;
 b=KNde24Lx91l3PUDRNmhpz/dN1yCsobTN1IqHREhWxSHF/Hi1Q/tzqfP/oOai5tGN9U5olRrrX8R8VU66Lslh8t9sohFXeZk4Q6AmIvijQD02ifZ0b/nuKC12+zyATjYBxcWQZhNiJ4lNbhcdqCPY8DB0NSPlja5C8Li+AL5quh64aBinM6SU5gH12lpLG88KbAXf3tFXQ7nCCkYlyA5wG1dn1K9qDlEzq9/NI3QfG144VZRbK2ZiFQs/605JM65rgB5dvYfIMCgzr2JnOZ5X6mQqtd0N4ZoCaXzyYtERKJRDc3MUyqDyJjIkXpULdPbBKLArdzEZxUiU8yo1+bJ2VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlOZUy0JAVkbapmLLpiv5O4u2EMOH71mIiQfR91rGdc=;
 b=S02yBT9cRSzIAhAzJH4jrb1nyhgUiN4tkPkmYJ20dilsvlxyCJ2ZmvKGYKGwp1oPb55VEPLWrN0zBWyG9SoOx3oautREbUTEIdU2aGFAqe/35tBbnRpdlNpFslc6YsStsorBGAa/XrS8jNnBvudJ2ODZaR7ppVZLeMGXgMew0Ys67dC7NwxgGfB9q9jUCYJaKAnWZlKH0PSmA03Q162VBvosW5k/7bFKHhN6mV4CfZo+olFjofHyE+QQSUaFkiAEm9088CCYItsVuJArmsWVT73aLej0z5QyYTHE3HLj7wwDnmXU+mSTJIG2gqPLRBJjKUCqFyApBo+V0qOv8jpENQ==
Received: from SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14)
 by MW4PR11MB5936.namprd11.prod.outlook.com (2603:10b6:303:16b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Fri, 1 Sep
 2023 02:19:21 +0000
Received: from SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::6393:8db2:10a:a6d8]) by SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::6393:8db2:10a:a6d8%6]) with mapi id 15.20.6745.015; Fri, 1 Sep 2023
 02:19:21 +0000
From: alloc.young@outlook.com
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org,
	alloc <alloc.young@outlook.com>
Subject: [PATCH] softmmu/dirtylimit: Fix usleep early return on signal
Date: Fri,  1 Sep 2023 10:18:45 +0800
Message-ID: <SA1PR11MB6760A4AD57255448B62EDE38F5E4A@SA1PR11MB6760.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [nazokdcbREQc/fZtt4T39fTdMupUvl8NpY2rez+Ue2M=]
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To SA1PR11MB6760.namprd11.prod.outlook.com
 (2603:10b6:806:25f::14)
X-Microsoft-Original-Message-ID: <20230901021844.1464967-1-alloc.young@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6760:EE_|MW4PR11MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: dc43de87-e910-4a9e-5d02-08dbaa91d9c1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: we5sInx06wn56xzp9zEFxeZSAFuOWIMZymVYSCqrch/qkigtrPzhXeUcEB33a2uRC3TIerZg9VX1071X4rT5zDqGZHwzRhGzYxr0t0fRtzHNmK28tBECniJvye8NzHZEBxKYW+eDV4r4U4OPP2vP/Y5ezjcg1iF+C+S27SibQhOQZQIXJNx7jvXtXYQA0AUZ6KsJfUBxj/nbWROPuMKAVHNYTWdDiythQiN+RVKXLM3Cc3Mjna3VC3wp55qZNuiIdSOg32if5lahnaD7R+bCur+iD7SvHpvGol8Qx6L5rPt2QLtkQfLH7v2UP0vCzR6oh33GrKqaY04pBjbBccnfKWYamkbakVQPAT3cnSoSgqBnEQb/AsBCQwcTdPSN0X2g1hnuhOOVn9nzmS62B/EWCUIQyEXFgeKOrQj/6AXblQS2lr+loUh7kt5OZ4yFW4o5N1ck8hRvq1M6s0rDTVfRLMpb//Q49pssdjq//CIsXshFw+jxGB8hZjlFvZJ18m9XI1wcQcO29QNxLfqGSJlD4y+ygSEwQrBtsQ2zKwr+G3Kk3aG0o6UIAm8+07tNDMgKr9N7kSR7XQ8ymuZo4dB4XnzZGzH4ojWUerfy62NTPJM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c9P0XOU0NhJdMGty5K6whxaD/oAHizvrcNfeQt2uuX2n3GvbZ1iWDwCdSbTi?=
 =?us-ascii?Q?QcP0vYB/01vSElWskrglLeEwWO4T+TGj6QboyIwPSBoufm10PMnzRZMLOeJd?=
 =?us-ascii?Q?YSPEca2H/c76caMTYVoJHI1WNK4Q9EjPBlk2tO5BN64Il3mhXSb7fNQL2UUI?=
 =?us-ascii?Q?3j5sHP1Jp0ptYqI39phbflFWRy1FoqpEw7EV30r5gcfPT5XQ7taPBWEHE837?=
 =?us-ascii?Q?Ay7xLLPim3hIqRU9h4U96iAcK7mOpKEV9FK/qYZ/g/0bHs1TZABRrDVwaXse?=
 =?us-ascii?Q?Ybnd6P+7vvF/b5pjLWDLXjiY9hXM6gHzGwpzUgrSrY/RwgV+YfMNY9VA4+Al?=
 =?us-ascii?Q?v8y+ZK7C4xsLOihY+5OUO6atzUk73ID4od8PCenLzxZ/qTHxrDq5P0cmHFTq?=
 =?us-ascii?Q?cX6SBlrEq2e7MVcBQr7ulZtBpSS7f9VM8aLcPLnGxeMcIF+TOv1qdp61xAcB?=
 =?us-ascii?Q?xCrALdx7MfDi2lUa+NgZz1egr90KEeI0yMpmSmozctdn1K+5Ijee1Znflh93?=
 =?us-ascii?Q?jRAgzcoxfwA5x/oha19TqDirQS3FpylWWFlN42VnOyS9xregt8zzBq4tx9DY?=
 =?us-ascii?Q?WcTP9bt6XiHreBb3qfZCFhcTTzoNpjhMtCmUpBRP6gdzgdgku9KKaShSEfw+?=
 =?us-ascii?Q?L9ampNWgfAuiZV5/Bx4OxNJhMQmIf75y2xGD+MVuhDPUNu2vOa7dD2OOGFKO?=
 =?us-ascii?Q?in7yBZ1ySnEas9bvEcFfmNGxS6b7ipcAIzjkDwCiN2FQwWyQ9iqb1RuO1x0Q?=
 =?us-ascii?Q?mtqi8NdoUaK236lQBsxRl3ZIIp2kFh/zYVzzyEQ/y8aow7SpDCp09lGcZ+4L?=
 =?us-ascii?Q?6BZO4kzlDeUI59ZHdBbu9dfbuZtC5oW5dbyBjVBbqc6UH2mxoddXquixWOPd?=
 =?us-ascii?Q?11nTs4cTAzX+MUwMjOpO7C+Rayvd4fb3WeA7MAxrGOtTNAyQiEjJFcJh5/Zj?=
 =?us-ascii?Q?NQQ7SViZYrCQImp9DX7V7uCFnVxj238dAdipfN6feVjesmT/w91cJ+RsYY5I?=
 =?us-ascii?Q?NRUD9dE72E2SZ91/Xffm9NtViS5KNp9W339Qsex83arh8H4HzOvLFt15B1tR?=
 =?us-ascii?Q?ytqQlfMUV5Btm+ESoNY2lQaUMMrKHPoaCIonWUYFbfeAgek8K6WEjwaBvbgc?=
 =?us-ascii?Q?FiLQ6bv8gL8fcfy6mQGFbmIBgryK5IKxVE7OLBjSZ16twf7NIRdOf41kN/5y?=
 =?us-ascii?Q?aHhPnAHOetgtJRSamh6nCYh5ZiQHwcK+/t91y8AFICXQKPrg1i2Oka+NcZE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc43de87-e910-4a9e-5d02-08dbaa91d9c1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6760.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 02:19:21.1535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5936
Received-SPF: pass client-ip=40.92.20.10; envelope-from=alloc.young@outlook.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: alloc <alloc.young@outlook.com>

Timeout functions like usleep can return early on signal, which reduces
more dirty pages than expected. In dirtylimit case, dirtyrate meter
thread needs to kick all vcpus out to sync. The callchain:

vcpu_calculate_dirtyrate
    global_dirty_log_sync
        memory_global_dirty_log_sync
            kvm_log_sync_global
                kvm_dirty_ring_flush
                    kvm_cpu_synchronize_kick_all <---- send vcpu signal

For long time sleep, use qemu_cond_timedwait_iothread to handle cpu stop
event.

Signed-off-by: alloc <alloc.young@outlook.com>
---
 softmmu/dirtylimit.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c
index fa959d7743..ee938c636d 100644
--- a/softmmu/dirtylimit.c
+++ b/softmmu/dirtylimit.c
@@ -411,13 +411,28 @@ void dirtylimit_set_all(uint64_t quota,
 
 void dirtylimit_vcpu_execute(CPUState *cpu)
 {
+    int64_t sleep_us, endtime_us;
+
+    dirtylimit_state_lock();
     if (dirtylimit_in_service() &&
         dirtylimit_vcpu_get_state(cpu->cpu_index)->enabled &&
         cpu->throttle_us_per_full) {
         trace_dirtylimit_vcpu_execute(cpu->cpu_index,
                 cpu->throttle_us_per_full);
-        usleep(cpu->throttle_us_per_full);
-    }
+        sleep_us = cpu->throttle_us_per_full;
+        dirtylimit_state_unlock();
+        endtime_us = qemu_clock_get_us(QEMU_CLOCK_REALTIME) + sleep_us;
+        while (sleep_us > 0 && !cpu->stop) {
+            if (sleep_us > SCALE_US) {
+                qemu_mutex_lock_iothread();
+                qemu_cond_timedwait_iothread(cpu->halt_cond, sleep_us / SCALE_US);
+                qemu_mutex_unlock_iothread();
+            } else
+                g_usleep(sleep_us);
+            sleep_us = endtime_us - qemu_clock_get_us(QEMU_CLOCK_REALTIME);
+        }
+    } else
+        dirtylimit_state_unlock();
 }
 
 static void dirtylimit_init(void)
-- 
2.39.3


