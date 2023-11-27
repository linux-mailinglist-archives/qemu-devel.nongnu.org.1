Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 315757FA045
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 14:03:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7bFl-0003Nf-Kf; Mon, 27 Nov 2023 08:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gihun.nam@outlook.com>)
 id 1r7bFR-0003Jy-Eh
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 08:02:05 -0500
Received: from mail-mw2nam12olkn20818.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::818]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gihun.nam@outlook.com>)
 id 1r7bFI-0006Af-56
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 08:01:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOAZfr20l2/q45K/oZcZ9mij2qf+nxWBC7pb2MjQkQmIbuWk9CLE3M3Sq2tVjMH5qzHhyxoBsvvvOqB38c8f2oTycmW4e0R+4JH48fNspON4qX2Or9TKWVpKefM0TaPbNE+z7+7JoM2kO5OukCEhTAOIRMuIXSyQaiH6TaaRy6VGfT8KNyRk4QZYlXS4N/gSawLN/nYY3hmHDADX/qPQveR2YT7Of1EhhbZkPh9U8WS6J5phSFaSa1HsZSyHIgmNRqGeiOSByMEPe0JC2phvbqOc3qwoCPQd6b6IVh8/K1UtCEn5I+IW3p4gwSI7rv6RBY9/Zzx7L04pmZDBI9RhFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCfYwVlG3pPOB1kU5ytkGX+NQdfKA8WDcztQYjoG04c=;
 b=e/3ePkTtoJXarCnuA+Ge123Z2MpkUyLHFwKPZAz/PuYL3ow51/8zlf5cVNhnc5pcFBwRrBlEfiWwZ1YL4+gmenDpnoyK37PPP1LauaNi8DGet0ZkK5jonmYiMUEpWbzCguFtgVwlcYT36PVrY++BvCYIPlC1Yxr2jjHigFZmYcotghL0h1codUstKnJT7gCHniuOY21raPBd0yyQpKM+z3sYwjZTr5gXVAm3wGsIxgCKRddFcPXyrSzLdtx7F6jpALU4BNu/UQzZs3hbYghd0Yfb+qH4usunrbUh5r6CRPjzdvgYSKUeEY32bKQyQIyEDM1ex3T6gB2rvTEXQpotgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCfYwVlG3pPOB1kU5ytkGX+NQdfKA8WDcztQYjoG04c=;
 b=BYn5YJ2mAsWxwmerRxT6PBXu37mmo7E3+/cDU89sSo4zZyzBsPDjNHDN6libjVK7BTIUNc+L/1AUl+yFLT0mMACBrZggllG2MJaMlKxvx4XWPAsZr++LmUYNaMiZEt8c9/BjiVDxe4CCThZiWca9uODjCt+lZ9rAmeZVdajJgHKB3g2crf5jxUEBWu6Gyd8zKUTnR5mQyeV4VlKoyhioMaVqiPKCs4+DjcKh1IFzZOZj4HS6D3yyYHUqTG65HhhWV2J57NXCJIKCnWTwa5YGDAR4/+QPMoeJ9eVmmv1Z5dRZ+yiZtcCGvDpOt/dM8GItxXxe8i2/ihMjoRmw1jUzKg==
Received: from PH0P222MB0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:103::23)
 by CH3P222MB1029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1b9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 13:01:45 +0000
Received: from PH0P222MB0010.NAMP222.PROD.OUTLOOK.COM
 ([fe80::4627:8edc:133d:401a]) by PH0P222MB0010.NAMP222.PROD.OUTLOOK.COM
 ([fe80::4627:8edc:133d:401a%5]) with mapi id 15.20.7002.027; Mon, 27 Nov 2023
 13:01:45 +0000
From: Gihun Nam <gihun.nam@outlook.com>
To: qemu-devel@nongnu.org
Cc: Gihun Nam <gihun.nam@outlook.com>,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v2] avr: Fix wrong initial value of stack pointer
Date: Mon, 27 Nov 2023 11:54:20 +0900
Message-ID: <PH0P222MB0010877445B594724D40C924DEBDA@PH0P222MB0010.NAMP222.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [vO0F08pU4VZITHrQ5ueV2cyGFa2Xnm+c]
X-ClientProxiedBy: SL2P216CA0138.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::17) To PH0P222MB0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:103::23)
X-Microsoft-Original-Message-ID: <20231127025420.19126-1-gihun.nam@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0P222MB0010:EE_|CH3P222MB1029:EE_
X-MS-Office365-Filtering-Correlation-Id: 9510d577-739e-40bb-932e-08dbef490220
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /yxBePY17o6f5D+UZrHCWXVx+COyh8fRj/p8o8Ln4+6A0XUlWKO1m3PSmNGPjN5v16QTsKHsgKOJ0iT9YF5b8aZAhM1MhsW+RGQZedihBrl7VOVa2X3QTNWenR0H+levL8FJuNiCDw26f6+qe2/mFzNXbmv5kqRkEtq1/3vpAfZu8ulBb86qSVHNZE4Cl49OslcVF70L1tCMs+a7pEO4A0AKgVbQMLGB9I/EKbp6Yekyxv7nsdH11NtJrD/qGxIh/hFGVOQ4+xbGsy5nGorIonL7/1XXFTFdDQ9P5gOCu5cKqOVP5sKZKKVLRNq1O8YNk6lEWwCkYxvAG16U9YFPZ7oBnPX5oiOafYc0uqDWubDwgUMT0vcVS5FWXU4fTrsiGpndxHkjbwI5BzzbEHdf/2s5ZSwN0unMsmQijREFHVFMGsk4JDvzaKFtb3iNy7kX0KGGfjF5aKEoC2w9GDtVZ0B7u1mKBPbY9dt9a8hdQsUbyiMo4COVYZABO6viOsBK4Fc57e2rt0F7jebH6BVDWm94KiUKYSLSzF2gIhbf7/qICeyqveilBlXKNtQzYKfjhe2E7clwlfdCz1bc32RAx+m+tHMd6zC8Uv/pYZrMI3cyrwQRwO/4FiSdquQRTbWG
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lp276P8x9c/txqiJ9GRDLiKzi7n593mISTOiCr6V/4h7YYxu37IpSloWNsoO?=
 =?us-ascii?Q?oNg962UBmcCMEzBrHtg6DxhHMOpwPVC5/9PTnNbfdwhBPjmQWrZkM4cKTNL0?=
 =?us-ascii?Q?A5UxgV9Ak0QUssMtRgOjpfIfG8c/ktMjsd0hpcDPta5T0+Vag5DqiBIbblog?=
 =?us-ascii?Q?bPjBm+vOvYS12VtAFeQ9boYpdePK+RFkitFlzV+a0W1h9ZIgUUKao9SDCscj?=
 =?us-ascii?Q?xwghSjDnglNDZg807jVFK7t8FlntE7UgqTSPaNiLXobZLwGB5Mw68hy8tjsP?=
 =?us-ascii?Q?PFtX8ncHcw7Fc7SgfNQcYWUeSwZT8EBDRRrzpLLW7CWXAB9Pr9ogUtpC8736?=
 =?us-ascii?Q?SFvQyiULP4CVDeigDiJGCAlta1e0BOVNK30xM8rCDBGxF/MKiaP7GNVyzren?=
 =?us-ascii?Q?OUUul7UEYWsM1SmWiws4EHwnbzzJ519UsN6V7FtMEeJ36TsH2vXM7peWwM+0?=
 =?us-ascii?Q?IJKH3oC6OA5V28R/K2eurrVG8QLgCbd1rghc4dNVLQ4vjC9CI/1GemwQeuzL?=
 =?us-ascii?Q?AwdPlSzLYo1PgbYMU+gBVITVz8wVxin1vstJfXHhQOM0Z0Fmv/nGs/lHjkFV?=
 =?us-ascii?Q?vXcrjNG/9IRusRtlMxuAkAVywHOu2GNT/IQsu4pL5PKGIZUWqA4Qqi4FbVOP?=
 =?us-ascii?Q?SfnG85yJhxuiCjJLLXRdk8XNU+ZXHk+h+3RZLRnLtfBBZEq1zhGovx1UbXQ1?=
 =?us-ascii?Q?dirYZvP1Qs2f7+jgRgIGsNOJLJbDQkI6lwRSmqLh9F2kkr0n/8hLQg7JKqx+?=
 =?us-ascii?Q?AGTf6lg+MfsGb8EtFagswVuhjz3do4ZErfiSJN6ZftVipakAouWmSpkhR6rH?=
 =?us-ascii?Q?owpiRRzJnEVR5IzxxCoRJ/aZXVGWEocnLj4HavsVo71XUBGkG1N+n4vAJvgy?=
 =?us-ascii?Q?5HxApLJQqMkLL4jGA+59u9+bXNCy2jA7+OsiMkx7WQFIZaKt7x59RgW+fH1U?=
 =?us-ascii?Q?gTkivnT8NTddQta4aDRjzFYapW1zJdmB93e9gh5l7zUsP+sdc21zRHuPulDq?=
 =?us-ascii?Q?ywP0ZHhxOaNjL271Qny6ept5q1fzGSBmmM0JVV1fMIJtyKZddbkyoOjtp7S3?=
 =?us-ascii?Q?pSQr1gFHLKZCdSYQjOgaoujOFt6omyKhwWnAHuIPb/7Lu8Z871IRPezuJy6n?=
 =?us-ascii?Q?cYDX23eWb5JgOsbr7gb0WY6EcJF2kORyab2rD95iKmlcRU2rKI+9xS04/DlI?=
 =?us-ascii?Q?VClPjfq6tAL7EEMTu5tL5KlMml+bJfDEQx2FBA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9510d577-739e-40bb-932e-08dbef490220
X-MS-Exchange-CrossTenant-AuthSource: PH0P222MB0010.NAMP222.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 13:01:45.3317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3P222MB1029
Received-SPF: pass client-ip=2a01:111:f400:fe5a::818;
 envelope-from=gihun.nam@outlook.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The current implementation initializes the stack pointer of AVR devices
to 0. Although older AVR devices used to be like that, newer ones set
it to RAMEND.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1525
Signed-off-by: Gihun Nam <gihun.nam@outlook.com>
---
Edit code to use QOM property and add more description to commit message
about the changes

Thanks for the detailed help, Mr. Peter!

P.S. I don't understand how replies work with git send-email, so
     if I've done something wrong, please bear with me.

 hw/avr/atmega.c  |  4 ++++
 target/avr/cpu.c | 10 +++++++++-
 target/avr/cpu.h |  3 +++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index a34803e642..31c8992d75 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -233,6 +233,10 @@ static void atmega_realize(DeviceState *dev, Error **errp)
 
     /* CPU */
     object_initialize_child(OBJECT(dev), "cpu", &s->cpu, mc->cpu_type);
+
+    object_property_set_uint(OBJECT(&s->cpu), "init-sp",
+                             mc->io_size + mc->sram_size - 1, &error_abort);
+
     qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
     cpudev = DEVICE(&s->cpu);
 
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 44de1e18d1..999c010ded 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -25,6 +25,7 @@
 #include "cpu.h"
 #include "disas/dis-asm.h"
 #include "tcg/debug-assert.h"
+#include "hw/qdev-properties.h"
 
 static void avr_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -95,7 +96,7 @@ static void avr_cpu_reset_hold(Object *obj)
     env->rampY = 0;
     env->rampZ = 0;
     env->eind = 0;
-    env->sp = 0;
+    env->sp = cpu->init_sp;
 
     env->skip = 0;
 
@@ -152,6 +153,11 @@ static void avr_cpu_initfn(Object *obj)
                       sizeof(cpu->env.intsrc) * 8);
 }
 
+static Property avr_cpu_properties[] = {
+    DEFINE_PROP_UINT32("init-sp", AVRCPU, init_sp, 0),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
@@ -228,6 +234,8 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
 
     device_class_set_parent_realize(dc, avr_cpu_realizefn, &mcc->parent_realize);
 
+    device_class_set_props(dc, avr_cpu_properties);
+
     resettable_class_set_parent_phases(rc, NULL, avr_cpu_reset_hold, NULL,
                                        &mcc->parent_phases);
 
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 8a17862737..7960c5c57a 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -145,6 +145,9 @@ struct ArchCPU {
     CPUState parent_obj;
 
     CPUAVRState env;
+
+    /* Initial value of stack pointer */
+    uint32_t init_sp;
 };
 
 /**
-- 
2.39.2


