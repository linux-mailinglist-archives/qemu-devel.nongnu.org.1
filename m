Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A55A7E568C
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 13:52:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0i1V-0007bY-1i; Wed, 08 Nov 2023 07:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <LeoHou@canaan-creative.com>)
 id 1r0i1P-0007bQ-Fc
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 07:51:03 -0500
Received: from mail-bjschn02on20614.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::614]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <LeoHou@canaan-creative.com>)
 id 1r0i1E-0001HE-8r
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 07:51:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQO0s/2KVUwAlD2r25P/+k/rTuEWeOluZmQ+0p0UsQZK3TQXuySeY5HYfFZyM8iO1tAB6JvelODNwflvjkcx4jN9pEPJUeiVASbqFRTnIksuqhE1PSUJfZq+WflgurFhRm98O6Qd/WMcovv9Rv53hGeozT0gzJ4k1BI1YyFukan2PyeI0bXP58ojcMcFwf6u8kQtnBhRkIFNHFPAixaSLsUchm1gY6GGMqjq65Lu+WFWy6kBFz7IpdVJ6dHVq0Ki8cSA+GeXSuyGI8Z6zIqRVcu6BO4l/RWgIKSwhrX3VcXnQbP+8f9xc2fYxJTW9m+9Ckkn4+u6i7pAkEG+UvR/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8s/kjUiq3uCxInjco1c6nJKEvc9yxFI5t5ejcVi9rCQ=;
 b=ZHqFWUfnDOXyV02L5VFxikWc98Xkrk0ZsxErlJpREwPVr6djMqN68k/+9bmlaeDM8d5iuYRgIexp08XTRVJwFuCBxjZfzwtaqczpy8ID/LeqmsXLfCpyyZwsYor1NVWxg0ffvVdvdJFr//L+ip+Z4QewXnGMQUlHdae/fBuZXxPezpk1FKQopB4+nLZmXjU1KhSkalgQSxKUa0015lCL3+WieLqBCA79/G9gKQ5f5NFz3IrgrBAVeVs7c8Hkq58+UkGTXWkewjwrao3mguYP0wMbkudcRU5spFy/CslxtK+HCBNEVVyzrBVGvVTyfF/lvrW+Rsl3G9V8hwxcj4SNjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=canaan-creative.com; dmarc=pass action=none
 header.from=canaan-creative.com; dkim=pass header.d=canaan-creative.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canaan-creative.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8s/kjUiq3uCxInjco1c6nJKEvc9yxFI5t5ejcVi9rCQ=;
 b=hb4/CJRZWILLamUttDrHx47Hk9DPDLELkEiNX38dIsSFUynsBVrDLtmvWw0Uz32xy5PALthsY+r8XMyt/s/r/GFB8QPMFkt/IbuaGyZtxJ1Z3yWPRsU3Z1bYcisbgnCWbVX0BMFJ/lrDtIbjQHpoX4tDjiUQ1G4Z3X+CyGn8IWd5mb4/EUg+YpkCEOzQ0phKV+pIcbHFU7DAPngkK0gv/m3vmC6Z7ZpG+VEGnTfKuhsvTJjzKlpE+26mWMm8O8N9gDu0S8DkH/TWcy2DlLIeDUB2qObOUH0X5H5P/P8h3lAWXax+BQFZIZVSNfOmBPpAfdm/fGZFRCAUod6xHkoJtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=canaan-creative.com;
Received: from BJSPR01MB0627.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:d::14) by BJSPR01MB0881.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.39; Wed, 8 Nov
 2023 12:30:56 +0000
Received: from BJSPR01MB0627.CHNPR01.prod.partner.outlook.cn
 ([fe80::16f1:3381:bdd6:efc7]) by
 BJSPR01MB0627.CHNPR01.prod.partner.outlook.cn ([fe80::16f1:3381:bdd6:efc7%5])
 with mapi id 15.20.6933.038; Wed, 8 Nov 2023 12:30:56 +0000
From: Leo Hou <LeoHou@canaan-creative.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, jason.chien@sifive.com,
 zhangdongxue@canaan-creative.com, Leo Hou <houyingle@canaan-creative.com>
Subject: [PATCH 1/1] Changed the way aclint gets CPUState from hartid-base to
 cpu_index
Date: Wed,  8 Nov 2023 20:30:46 +0800
Message-Id: <d9ea63e85600c805c5399ef2c78bc556f7a9c323.1699433553.git.houyingle@canaan-creative.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1699433553.git.houyingle@canaan-creative.com>
References: <cover.1699433553.git.houyingle@canaan-creative.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::14) To BJSPR01MB0627.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0627:EE_|BJSPR01MB0881:EE_
X-MS-Office365-Filtering-Correlation-Id: d572467c-82ae-4f3c-0efd-08dbe0568e65
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Swzs0ueJoNVxMtCvGsBwZALWiVGBbAn/Gv9oBEvfL7N/wPLlmDIdoIrGHS8x0Cp36JcVI/fmwX2VxdN1ui/uy5X2uvXTFqF7im7ewnH4JYd72EUTnxW8ILK6NMXSETT/EoNuE7Pzrehu8YEkOygpxpVe4yUse2Zx0uukMaPomEATq/y/Yp8IikX0WyfWLUhXEyCO+ZGzYBv9fZWOn2oJyhDSJwQ5T3RC+VcZdQHGiuSwnsmOSoiXAs2zV2HjbSZ13CBPjjU/2W31J05JYp9IsVYC/nhvwWt1h4oyacI78Syke6EYSBOQUVbKK3PglhhoYw+bxifusbGF5K5vNk2+4POrq5xnoLGe8fRAxSZ/9anqskW/XEZ2Xiisqq24xAg2LAJIddCrdTRk6VctuubMyzlquqRhw4W+NmYo3FK2B7nsJVKDjd75HAMKdEPcaJs+Re5930n2TUiL4aTJNt9xxoClD0jGg8mM/wjZTVbVTTHrdt7ckYt9LTY6QwhTu9SbARMdeqOeoC06BIlTBkWr4R7DrSENRpHZTBFlsE4Epif8tVIozoOBywtb37Zc4Kus
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0627.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(39830400003)(346002)(366004)(396003)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(52116002)(107886003)(6666004)(41300700001)(26005)(40180700001)(36756003)(6916009)(66946007)(41320700001)(66476007)(66556008)(38350700005)(2906002)(86362001)(508600001)(40160700002)(83380400001)(8676002)(4326008)(5660300002)(8936002)(2616005)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FMydjmuIyYddWMNQw2oatml7J0OSTF9G1TH8jN2uON6xJj89vE06Hj3gX+g1?=
 =?us-ascii?Q?2iN/VHaUhcWel9oEZn7TGtVnQGma5AScTOW7TlS/xc4E49/N9ff2UFqTGR68?=
 =?us-ascii?Q?dbXkpWDDeqyxeF7p+/wPYCke0XqT6iDHG9PsmXaJkdzHld7aTX+qq8vPhxN0?=
 =?us-ascii?Q?c2NrvK0lREKAH50fWEbJeXzqiS1hBQaNPN9uXLxG9wj9Hg/NBqHoRR2Px5v8?=
 =?us-ascii?Q?TIZHOrmoW43rQGUfDNe+HpW+D72XMqC3SRnn8jJUnkOg2zeRcLRIUjKzWm+x?=
 =?us-ascii?Q?w0IZqk+0UjtK2KQvPAERKAp4QnMjsbLLIzCQRW+M1e0rdrEdWevN/CFW5j1T?=
 =?us-ascii?Q?v5qcRxeWoqmhYCWhSS7RykQUM7vHROu6BRzzhAeUWNa/mVmU1vzn7KQb0Yd7?=
 =?us-ascii?Q?CIXyxL3MSEbjKGscE4dm9WK5fZZ9CQWCi+r8TFdyPg0xM29ELSRvKZj6AZ4K?=
 =?us-ascii?Q?rnAh/UfwnrKbqeSob6bcv43jAYgWm4/NXQTuCmIV4ajxD4rRA44jXHy5f8Q6?=
 =?us-ascii?Q?uha4WPAqTZL3J6wkGjU1TEpewie4JrQAHp65eUoLL+qWILsbyUB3soHST/zD?=
 =?us-ascii?Q?ecL7B4Zq7zdQdnb1AtRmUUkUUk5Jb4wqMgTigYqSzVnKs85KThLL+/Uj32QO?=
 =?us-ascii?Q?QFY2jzS89vSXHYUORVwImgG4TSLkqE4UxpEffzvOhialplt8TCEwho/j3nMN?=
 =?us-ascii?Q?uNuw2Sz/4tB6QAzA+ARLrZdieAHp8eeL4LhbIR2OiDew+BNOiLPnQvbtFFmC?=
 =?us-ascii?Q?jPDeQRhHOA3Ojb3R5VIVvwDRCwDZXu6yxm/bmoA5cYYwL2foLTF4lpZ1lEaX?=
 =?us-ascii?Q?PBwKGHtmrJTj2RLNIgUpzUSSCaZqOvmoLOXi3le+XN2BXudyIAMuXSoA+NQM?=
 =?us-ascii?Q?ks5qFMCCLKPWDZZw0SEJHneYXBotnjkRkRoxe1L5ZQaT82LCn24APDkRYPjI?=
 =?us-ascii?Q?Iev72Uu/3DykHiRlVxTB7thVR5xq/z2zTEPb7n6i32q49glE/ojbrVKtFIFM?=
 =?us-ascii?Q?/6YUwzkUpPaw/Wfg+kHIGa+P3RTJJGvG6U8sWSBhZCgYKYjER0wa9IYYskPf?=
 =?us-ascii?Q?v7it8H/qAkyrcvGg505pO2zwujuHBZkA5EKOfXEN0d7lmSzYwnJIBNQmNnGe?=
 =?us-ascii?Q?ob6tTcoPZFPS0ZuXBYQI2DsxfgG1TgAuLn0tX3xu0fDfNUmciopBkPD+HcxX?=
 =?us-ascii?Q?uUbf56Bqvpis/Qyk1GpZcFR8IHvhklR8H+Q7Jk2k1nvY9KJ0NcSUYe8HWR3u?=
 =?us-ascii?Q?L8/CjxRlS6CqzNhkIUpCnkRsyLdU78UMay9ghM4gwhcjvV8JTLMTr+yIWbhj?=
 =?us-ascii?Q?QiYQSjp2tpmYGn9G0fhcwxrDIUA2PHT9BkborKFZq8jlvk1hC/OdQQJTTrwR?=
 =?us-ascii?Q?4TLU1njqxznhiQUSqHQWcWGylUdoNC9CpAvmb8Btxc4Zit+E6pfxZjzLVYyP?=
 =?us-ascii?Q?MqrAE46NF4Rlzwa5FhEInV2sqN3n+DxUfzYQmrR8Hy6ds0FlVnl/vc/KFtpe?=
 =?us-ascii?Q?11xQCMIzZqAohyDqjtdUEDGU3pM77nOWjbSxPN+S3AE4BaL4hw0uTV2TDPvr?=
 =?us-ascii?Q?0Vj4JLLN1IedoQxJ4k70t+bIq0G0J6s7g0vaNPUngye96QA/bxOex1eI90i/?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: canaan-creative.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d572467c-82ae-4f3c-0efd-08dbe0568e65
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0627.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 12:30:56.4678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb9be9d7-8f56-4a62-b26e-3018a3e771a5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kpvtvBx873MFOeWoUK1+z+K8WPX+JZue8xQh0030YJeX7L5jeQFpLM0irwTY5mjhRHW+g/bfrcngd8a0boAKXbCcMw8RJUYHyJwhJgPIEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0881
Received-SPF: permerror client-ip=2406:e500:4440:2::614;
 envelope-from=LeoHou@canaan-creative.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SCC_BODY_TEXT_LINE=-0.01, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

From: Leo Hou <houyingle@canaan-creative.com>

cpu_by_arch_id() uses hartid-base as the index to obtain the corresponding CPUState structure variable.
qemu_get_cpu() uses cpu_index as the index to obtain the corresponding CPUState structure variable.

In heterogeneous CPU or multi-socket scenarios, multiple aclint needs to be instantiated,
and the hartid-base of each cpu bound by aclint can start from 0. If cpu_by_arch_id() is still used
in this case, all aclint will bind to the earliest initialized hart with hartid-base 0 and cause conflicts.

So with cpu_index as the index, use qemu_get_cpu() to get the CPUState struct variable,
and connect the aclint interrupt line to the hart of the CPU indexed with cpu_index
(the corresponding hartid-base can start at 0). It's more reasonable.

Signed-off-by: Leo Hou <houyingle@canaan-creative.com>
---
 hw/intc/riscv_aclint.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index ab1a0b4b3a..be8f539fcb 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -130,7 +130,7 @@ static uint64_t riscv_aclint_mtimer_read(void *opaque, hwaddr addr,
         addr < (mtimer->timecmp_base + (mtimer->num_harts << 3))) {
         size_t hartid = mtimer->hartid_base +
                         ((addr - mtimer->timecmp_base) >> 3);
-        CPUState *cpu = cpu_by_arch_id(hartid);
+        CPUState *cpu = qemu_get_cpu(hartid);
         CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
         if (!env) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -173,7 +173,7 @@ static void riscv_aclint_mtimer_write(void *opaque, hwaddr addr,
         addr < (mtimer->timecmp_base + (mtimer->num_harts << 3))) {
         size_t hartid = mtimer->hartid_base +
                         ((addr - mtimer->timecmp_base) >> 3);
-        CPUState *cpu = cpu_by_arch_id(hartid);
+        CPUState *cpu = qemu_get_cpu(hartid);
         CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
         if (!env) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -232,7 +232,7 @@ static void riscv_aclint_mtimer_write(void *opaque, hwaddr addr,
 
         /* Check if timer interrupt is triggered for each hart. */
         for (i = 0; i < mtimer->num_harts; i++) {
-            CPUState *cpu = cpu_by_arch_id(mtimer->hartid_base + i);
+            CPUState *cpu = qemu_get_cpu(mtimer->hartid_base + i);
             CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
             if (!env) {
                 continue;
@@ -293,7 +293,7 @@ static void riscv_aclint_mtimer_realize(DeviceState *dev, Error **errp)
     s->timecmp = g_new0(uint64_t, s->num_harts);
     /* Claim timer interrupt bits */
     for (i = 0; i < s->num_harts; i++) {
-        RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
+        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(s->hartid_base + i));
         if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
             error_report("MTIP already claimed");
             exit(1);
@@ -373,7 +373,7 @@ DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
 
     for (i = 0; i < num_harts; i++) {
-        CPUState *cpu = cpu_by_arch_id(hartid_base + i);
+        CPUState *cpu = qemu_get_cpu(hartid_base + i);
         RISCVCPU *rvcpu = RISCV_CPU(cpu);
         CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
         riscv_aclint_mtimer_callback *cb =
@@ -408,7 +408,7 @@ static uint64_t riscv_aclint_swi_read(void *opaque, hwaddr addr,
 
     if (addr < (swi->num_harts << 2)) {
         size_t hartid = swi->hartid_base + (addr >> 2);
-        CPUState *cpu = cpu_by_arch_id(hartid);
+        CPUState *cpu = qemu_get_cpu(hartid);
         CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
         if (!env) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -431,7 +431,7 @@ static void riscv_aclint_swi_write(void *opaque, hwaddr addr, uint64_t value,
 
     if (addr < (swi->num_harts << 2)) {
         size_t hartid = swi->hartid_base + (addr >> 2);
-        CPUState *cpu = cpu_by_arch_id(hartid);
+        CPUState *cpu = qemu_get_cpu(hartid);
         CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
         if (!env) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -546,7 +546,7 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
 
     for (i = 0; i < num_harts; i++) {
-        CPUState *cpu = cpu_by_arch_id(hartid_base + i);
+        CPUState *cpu = qemu_get_cpu(hartid_base + i);
         RISCVCPU *rvcpu = RISCV_CPU(cpu);
 
         qdev_connect_gpio_out(dev, i,
-- 
2.34.1


