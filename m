Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D75C47A3FB4
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 05:36:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi52c-00023P-G8; Sun, 17 Sep 2023 23:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qi52K-0001vW-Gq
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 23:35:00 -0400
Received: from mail-bn8nam11olkn2010.outbound.protection.outlook.com
 ([40.92.20.10] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qi52I-00030p-5f
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 23:35:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMH8yin3gCNzUAFqYTxsxJDYLMfeYWDQBOd4N8xqttMj2NBVKb05Vwe8il30uuW3rQOqWl/dZHs2eWzhV0KdUWLzMsG75dTTwolXcWmlWjSisVc++cfJlCrX99z8YHqs/OSktCOb9xJWelBin29TDvfy6ygTugmpAZc1XFkitTmn+DbM+b2boVeC9ymE5XUq1YWJcTJco3w8pPVlm2dncfFGudtVNjQp54IZsuG7/EM1jSkXNUlwCZ9Y+45ug5i4xrpHcYjpFJaak5bur7H0VT8vjAOS6q6SXh5w0Gp7FCm9htwB3v7ONwhO7Bz5d+zmZ2R5+NspxLFDRDWp5+u+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzhGZXQHm0UfNJbF/cpAGesPs2SrcqerahJAYsYiddA=;
 b=FVAbvuiqjOcevINoHpzRKUs2fHmeiUHHrAz1L+i/tytJfXlUegnWCUNqSsaGCPQ+OMuhaNU2AphcSTCGjG64EaI0cWgtHhwxAhz/nJTVMWHgnxXsxdwdg1+jYxO8jQl5C8hmcUIYC2vwqzt+vgqnQXfFKs1grk0WHe2CYyUio+dFMlrsUmUo0mBmZShBaOwUNgd4ReQbF9jLl6ScFFfHTNSUyPkLWKUpTn1hxi9G0F+SInnf9cOTFGCDjXdcqcjdMwXgbeVgzWyvGTxg2I7iIkFRXOYQGaJ1lMSfeBNVWGdj+Fv/QEfpGI8/N5c/xQBbjYWrEN/n2GpLmus3Gu/qzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzhGZXQHm0UfNJbF/cpAGesPs2SrcqerahJAYsYiddA=;
 b=G5JCnYPXV3kyow9oTFF+4mx6mD+/qQKvGpef02oTfaXyxTaPgC//pj9iDZMCMIPDkyert1zNRaSmJ6SmyD64//KPfbD5Gen3qWEIaQL+1MuupFzO5Bvao78q0JsNG6pxbm6BzUJsBZSOfKBtKMeruCdWD8kcV+wCmW+LWIC0yR41RqvXoLsXNmSGx+TSRHND95erczGz6AOVUS21IZyMHS0Lujg4XtEWaETcLhGqXcBw/CuCbuQZQP+YSaVwStvgRvvAMRLGEHoTQld694F243ZZkUOfz3rle5g4uppy0bOYvHYe9Barmdy73j2lYfvVK37MOOXznFgCjOvVPwajZw==
Received: from SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14)
 by CY8PR11MB7241.namprd11.prod.outlook.com (2603:10b6:930:94::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Mon, 18 Sep
 2023 03:29:52 +0000
Received: from SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::6393:8db2:10a:a6d8]) by SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::6393:8db2:10a:a6d8%7]) with mapi id 15.20.6792.023; Mon, 18 Sep 2023
 03:29:52 +0000
From: alloc.young@outlook.com
To: pbonzini@redhat.com
Cc: philmd@linaro.org, eduardo@habkost.net, qemu-devel@nongnu.org,
 alloc <yangcg26@midea.com>
Subject: [PATCH] cpu-throttle: Fix vcpu missed throttle work
Date: Mon, 18 Sep 2023 11:29:27 +0800
Message-ID: <SA1PR11MB67600F56B3AE6348E7D6FEBFF5FBA@SA1PR11MB6760.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [HallMiO/EgWE1XHBm3hBHOUgCCk/+4ajvsqyVAJf7mI=]
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To SA1PR11MB6760.namprd11.prod.outlook.com
 (2603:10b6:806:25f::14)
X-Microsoft-Original-Message-ID: <20230918032927.1708042-1-alloc.young@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6760:EE_|CY8PR11MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 02779a8e-c739-4a83-0730-08dbb7f784f3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: daBlJ90ggZXcQVGTJR4T3J7B/Qp+zzXrB2mRJqi4UIJvsVuJcIhfFEiAjKfNbch9ZzUjQtLj3WyUyTcnK0jdiVgHEnf4TQ/Om4FPkiHEUAgDQGCKkPyhS+sLmfRRnpehieNfXgZNmRLyGk5RTwK2jIjZmZOkVS7/+lro7qAJHuDiZB4BKYlOdSTL6Gir6uH7pUOHSPqQ5aBXFa6cR7SD7+hc9jhXaNvxPG3Hex5F5aNa18yi76rzkXhfenH9K1cwmrbaK3WmNW1CisIQQPgEN8VLk2Z6VRNcjEFZL4SbNIDsJXzjFKsp3WVH1BhI5UMrXE0kLF5+DJahfeP2SPZi+Zdtde/p5Xgx/53vRy2OwH0LI1pz5U2EOLrrchze03TTU7JrhWfsYMv6WqYFNo3turakhT6yQoSisulifQoUe1CRItECAOAEGCyDEj09mDiO3G/YjVtkcViPKIzU5ZuX2e9NuZ1/RMzdg8wWiRO00yDlh2s3J0qjVDtMyek42dkQVnMjhfavq0viXCLuiAp/htMHD0WjOIY6EeSdQbE0/WqPEJDKUFqEFjm2DYplocvz
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f7QqJBRRXNBpRUi42EFv2cgFAwg/k6OBlBsvdaCvg+pE9vavAiec4rn/YUGY?=
 =?us-ascii?Q?Pseo2IX1z/oGWyE8uBbJlFBSH50L+BDM0Sk311QmWUSYUD7w99YOjSRd0mKP?=
 =?us-ascii?Q?22AuGkPiPvxqtELEPT7W2iXJRb1BYYXtzvH9K6JgrEdwWT+eos41OaHId7Oh?=
 =?us-ascii?Q?p7JIcP4uLrWyiZJTj53ZVeB0gam/DJ57zgM36S4vo9l45ON5XfAP5+WiEc//?=
 =?us-ascii?Q?MYlAOa2DnUXT5qwPffNtwYjYZfMhXyLp64L32+6F9xPNGOy9sDmh2FnkXltd?=
 =?us-ascii?Q?DUG+928WHfHAICo2fNmJkHs6sYXcq8xhggusQvFz278HP7xrCJGFq2hgUi6a?=
 =?us-ascii?Q?Se6NtCwzoDJfR9YZ2eWUXOBLsyGWyDlG/YXuy59HaETHQ7QuolfcY4EWmjXq?=
 =?us-ascii?Q?LcfIiKxIXG17q6kGVrugF7QXRkNuFXwtmfI046+DZjsRzfb5GotU3l13YaWS?=
 =?us-ascii?Q?4LPnaWLNH5TZE/V72i587MaLLt686NpW/rb/UbWLHWp+OIOQnrQWLirL5Dyf?=
 =?us-ascii?Q?hmHehgiCl+da3RJK8rIh2OG+UWOkQRpPtOG0WFyMELVuHIPZ3/GMrfxuo/J6?=
 =?us-ascii?Q?HpTh2TQar+oR6N6iMI3z7ha8MRCA9ITDGC4QBmAzMAzHs0/2IOonAsRDqGzI?=
 =?us-ascii?Q?IiVOGR8lXZ5VSslhED+cWsMmaCcVHzPyNUTb6wVrpAMowzD71cMzRyHsmkLA?=
 =?us-ascii?Q?xYpe65ZkVeNiXu4TpCijDrg6zLZ4pRTS/DXMqb6mt0co9z89g7gVMFroucTK?=
 =?us-ascii?Q?DUu5k9A4eF1gKoh23stKPwLivGjt1eEkta2FsAEIHFcl04gmYgYGOIna9cOE?=
 =?us-ascii?Q?fAOXtQ+2vgdhBEqBGmC5eCWYodkURCfZ1fXKgcrNruASWVFqXOAslQMsZ/OI?=
 =?us-ascii?Q?xdZuHFybv3ROjk0/hmT/E6InYELIjptt7mEMfA5JvHImTXXmR7+KDnq+cBYq?=
 =?us-ascii?Q?3OIbnShGfgnnwFkyYxazwEqDZNMjn2JhPPS4KamQMxGA+CO7uBuweyKnpPrW?=
 =?us-ascii?Q?oA2Ps0dqwqvoZ8afdwPynLiLpDZcDdDRtumHgvhkL3Q9kfx5XJTEhpCmR/hb?=
 =?us-ascii?Q?CpuzL8LWRy2u7v2jJC2frX2cbuSKmfv/ZZmOyRzD/AYz3f3ScwpSdv4FOeeq?=
 =?us-ascii?Q?92b1CSUOgykcK4NZ2EvQz9KxpMzVR9bYnaMzxp7NBMgnxDGddv/iNg9eXQnz?=
 =?us-ascii?Q?PpwYF5cRe7QIAF46r5D9rn6hqiLi/pJ0IJkqpd7uP+eMM9VjIJK5SLextSY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02779a8e-c739-4a83-0730-08dbb7f784f3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6760.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 03:29:52.3171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7241
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

From: alloc <yangcg26@midea.com>

During migrations, vcpu may run longer than 10ms and not exit
on time. If the vcpu runs over 20ms, then it'll miss a throttle
kick and will run the whole tick. When this happens and vcpu
dirties pages fast, the migration will take long time or event
not enable to auto converge. To fix this issue, take overrun
vcpu time into account and adjust the whole sleep time.

Signed-off-by: yangchunguang <yangcg26@midea.com>
---
 include/hw/core/cpu.h  |  5 ++++
 softmmu/cpu-throttle.c | 58 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 92a4234439..0b3cc3e81e 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -430,6 +430,11 @@ struct CPUState {
      */
     bool throttle_thread_scheduled;
 
+    /* Used to keep last cpu throttle tick
+     *
+     */
+    int64_t throttle_last_tick;
+
     /*
      * Sleep throttle_us_per_full microseconds once dirty ring is full
      * if dirty page rate limit is enabled.
diff --git a/softmmu/cpu-throttle.c b/softmmu/cpu-throttle.c
index d9bb30a223..bdec8dc954 100644
--- a/softmmu/cpu-throttle.c
+++ b/softmmu/cpu-throttle.c
@@ -36,22 +36,66 @@ static unsigned int throttle_percentage;
 #define CPU_THROTTLE_PCT_MIN 1
 #define CPU_THROTTLE_PCT_MAX 99
 #define CPU_THROTTLE_TIMESLICE_NS 10000000
+#define CPU_THROTTLE_RUN_MIN_NS (CPU_THROTTLE_TIMESLICE_NS / 100)
 
 static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
 {
     double pct;
     double throttle_ratio;
-    int64_t sleeptime_ns, endtime_ns;
+    int64_t sleeptime_ns, endtime_ns, now, overrun_ns;
 
     if (!cpu_throttle_get_percentage()) {
         return;
     }
 
+    now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     pct = (double)cpu_throttle_get_percentage() / 100;
     throttle_ratio = pct / (1 - pct);
-    /* Add 1ns to fix double's rounding error (like 0.9999999...) */
-    sleeptime_ns = (int64_t)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS + 1);
-    endtime_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + sleeptime_ns;
+    overrun_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) - cpu->throttle_last_tick;
+    /* If vcpu runs longer than 20ms, then the vcpu will miss next throttle tick and
+    *  will run almost the full tick frame. When this happens and vcpu runs fast dirty
+    *  pages, migration may take long time or can't converge at all.
+    *
+    *  Example of guest run longer than 30ms when cpu throttle is 99%
+    *
+    *  guest run(x) throttle tick(*) guest sleep(+)
+    *
+    *            +++++...+++++x xx+++++...++++++xxxxx...xxxxxx          vcpu
+    *
+    *  ----------*----...------*------...-----*------...----*---------- timeframe
+    *
+    */
+    if (overrun_ns > (CPU_THROTTLE_TIMESLICE_NS - CPU_THROTTLE_RUN_MIN_NS)) {
+        int64_t timeframe = CPU_THROTTLE_TIMESLICE_NS / (1 - pct) + 1;
+        int64_t new_ns = overrun_ns / (1 - pct) + 1;
+        int frames;
+        int64_t adj, remainder;
+
+        frames = overrun_ns / CPU_THROTTLE_TIMESLICE_NS;
+        sleeptime_ns = overrun_ns * throttle_ratio + 1;
+        remainder = new_ns - frames * timeframe;
+        if (remainder > 0) {
+            int64_t left_ns = timeframe - remainder;
+            int64_t left_run = (1 - pct) * left_ns;
+
+            adj = left_run < CPU_THROTTLE_RUN_MIN_NS ? CPU_THROTTLE_RUN_MIN_NS - left_run : 0;
+            sleeptime_ns += left_ns * pct;
+        } else
+            adj = CPU_THROTTLE_RUN_MIN_NS;
+
+        /* Limit max vcpu sleep time to avoid guest hang,
+         * max sleep time is 10s when cpu throttle is 99%
+         */
+        if (sleeptime_ns > 10 * timeframe) {
+            adj = remainder + CPU_THROTTLE_RUN_MIN_NS;
+            sleeptime_ns = 10 * timeframe;
+        }
+        sleeptime_ns -=  adj;
+    } else
+        /* Add 1ns to fix double's rounding error (like 0.9999999...) */
+        sleeptime_ns = (int64_t)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS + 1);
+
+    endtime_ns = now + sleeptime_ns;
     while (sleeptime_ns > 0 && !cpu->stop) {
         if (sleeptime_ns > SCALE_MS) {
             qemu_cond_timedwait_iothread(cpu->halt_cond,
@@ -70,6 +114,7 @@ static void cpu_throttle_timer_tick(void *opaque)
 {
     CPUState *cpu;
     double pct;
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT);
 
     /* Stop the timer if needed */
     if (!cpu_throttle_get_percentage()) {
@@ -77,14 +122,13 @@ static void cpu_throttle_timer_tick(void *opaque)
     }
     CPU_FOREACH(cpu) {
         if (!qatomic_xchg(&cpu->throttle_thread_scheduled, 1)) {
+            cpu->throttle_last_tick = now;
             async_run_on_cpu(cpu, cpu_throttle_thread,
                              RUN_ON_CPU_NULL);
         }
     }
-
     pct = (double)cpu_throttle_get_percentage() / 100;
-    timer_mod(throttle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) +
-                                   CPU_THROTTLE_TIMESLICE_NS / (1 - pct));
+    timer_mod(throttle_timer, now + CPU_THROTTLE_TIMESLICE_NS / (1 - pct));
 }
 
 void cpu_throttle_set(int new_throttle_pct)
-- 
2.39.3


