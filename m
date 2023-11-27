Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2917F9809
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 04:52:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7SeJ-0005SJ-QC; Sun, 26 Nov 2023 22:51:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gihun.nam@outlook.com>)
 id 1r7P8l-0006HV-O8
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:06:19 -0500
Received: from mail-bn8nam11olkn2010.outbound.protection.outlook.com
 ([40.92.20.10] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gihun.nam@outlook.com>)
 id 1r7P8d-0005uf-Iq
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:06:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKt3TsEolmlca2ouGEjqtjXC6q1JR6eubj10W/GYCmCF0/z0ASN6Yw7TtaT7of4an1W0kGYF1iSDAeIpwp7HzPWzKlnXJjbiC9ImDXBi5ZoR+6tXRphhCGMn4AZlCiskYBxMwxWE9UYq6PM8p9YQo60hC/L1UW3zs28EqBWGOwuoDEhx4Q4vHdC/s9kOGOL+eTw2WFXLHXE/fHLQisZZ8fX9HGSUhH+C7380Ph1P+WhWsUXQiDktmPm4Kd30MTgOd6s4ZAiOqiaNCwSvC6iVhtnHmh/i6mt2j5oeDssH8StdLoJNiQlxLOeaPCq8+0gnFecCZDj+T6IinjLLExlW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scbcTh/C8XY63miuE4rlOPkVn3XWTkOLdFwJ02Az3xA=;
 b=Yc6DlRkzEnACZBVWMgftFk2gbGksnRzhW2xzNjJ3nQNb1Z/rOTPvF/pOM5QyHu9fTuOEQOiQxgVy16F0nRTXCDQZVTzgOwRdIJeVRsyLioNjW64EhsIDpBcDZyJnPaT60TWTvvZCLWKBYdH9Q/W6bAbkddmB1GQeajSpkgfEcTUlK70oWLd7NjMSrhJlNEneEZFaoU7Ww3SUoLCIsE89ieQQlbro45nxpbfjCpPkS3P9N+bEqxrVcEPgzzU7ZS9muQji5GsHAp5FqviZmYCD/wCdrG8ryyjd29hvckBDxB3z/owxPp5Kiz87eRbMh304sOB7OawDKdGPzhRunnHedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scbcTh/C8XY63miuE4rlOPkVn3XWTkOLdFwJ02Az3xA=;
 b=kSealRw7gKk0oLOay538GjiZpIzh490quuGitp1lkstAYIu3qMrfh/0/0s5eaUAdWZ0XEyFS+kSIMI8rcPMtEmcT5+blOb6B9bHSPRQB8v6uGDozC+y10mfRjGwqwgwrnjuwuaY3THCijGmZmOnSpmAtN7DtQfqiaarlgqq5ZGqpLwOhlqZUeXGvdBYt1VD3CUyQXfjzlakk16NC9GpgPmJbgjGtE9K+FRazIPP6jgt/1gk9LvommTD98fuci845p9K2ZWL5vZNn1AEBLKhRwJhrBW2ejjHp0ecr1NbdcKFFATVEtybm81co9YXlPy9247C5TkFrsLw26aqQsM9QQA==
Received: from PH0P222MB0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:103::23)
 by SN4P222MB0542.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 00:01:02 +0000
Received: from PH0P222MB0010.NAMP222.PROD.OUTLOOK.COM
 ([fe80::4627:8edc:133d:401a]) by PH0P222MB0010.NAMP222.PROD.OUTLOOK.COM
 ([fe80::4627:8edc:133d:401a%5]) with mapi id 15.20.7002.027; Mon, 27 Nov 2023
 00:01:02 +0000
From: Gihun Nam <gihun.nam@outlook.com>
To: qemu-devel@nongnu.org
Cc: Gihun Nam <gihun.nam@outlook.com>,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH] avr: Fix wrong initial value of stack pointer
Date: Mon, 27 Nov 2023 09:00:52 +0900
Message-ID: <PH0P222MB00109DEBEA0D55483D5FCB63DEBDA@PH0P222MB0010.NAMP222.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Hp4P0CprvUvlzsbE+QhxWs0VusPDIBMc]
X-ClientProxiedBy: SL2P216CA0221.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::15) To PH0P222MB0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:103::23)
X-Microsoft-Original-Message-ID: <20231127000053.7614-1-gihun.nam@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0P222MB0010:EE_|SN4P222MB0542:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a06fdc-b7c1-4746-3b4d-08dbeedbf185
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s37OtLuAfdZnQ3QPlQ5zqwLd/MQdqq71w5PSsEHLBrX20Vla3IfzY9okiU8ybcgiFhFIjqRqf6MKbJmyDbg2qBlFHzduK+5Odz2GMOMG1Y4BBD6rAxt/eFVTGlQiW/CpPhp0A3vFm/BXoE7EDwwhJC1JcqlxMgN2RQZvAD5kdtN2slAi2fi3Yrhd846DfTL77Lio98Ucs1sNL/EfFV947Y+OH2bK0XbTITQWBWQ4bOimy0Xz4rvcMhsY2MYvR8BE5SgzVWpbQahPWhn4AkEaH0FEuec1QkwPmG+0d2pDWRDk5V6MUXvPvjwNafY0xc+/BuzoCk3jVdGqma+qCx/DD2F5VcjWaF/nieMQdM7dg0ABS/M2l1VTOWziOPxMYeTZxejJvSxn3Uz1REOb+WIfbma22HXtTEiniNt5f0ODmR6P0luNwLPrLSrYP06rcwchFw6XZhUq5SaJbgRl/6A5S1q7nah64i5yPtu2NWF3q994QYskqVTfjFcM3wmhMAqaILlzAko9JbLw9Oecx2/QnlXS2NpXnskZBZilfEWuM9Il+F4juWzq0ocvxY3GvSHzMYezKYmQSnUHEX+9CltNx0dJZE6Y/h8HH0e37Wa4BFhFqvpW9CzPmerWOhlr3h/M
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yzmcNUHvgwxKxaGBZwLvcxvWrngWCBFtOyPZhx0qD96/yrie24rQ46HONsl2?=
 =?us-ascii?Q?HTHxWFwgF6inO71YQn+Wdwye9zf6uyeVhgR4vtoMa11CxYIva5v4TGPcck1F?=
 =?us-ascii?Q?TAUHJ987n7RoPXZgLcDMHr0O9jQhgQBnka7PYcibr58rFXbqbtETqVxY32so?=
 =?us-ascii?Q?F0o4fuq3suKpj6SCmy9BkvdcV0XOyXHJWqvZNe9XtV+MD9Ob3ArrWo+txRVc?=
 =?us-ascii?Q?R1uXO6UE8Zxm+4R6N5xdsutSfnHtDZPyZ+Ns6wXIlAS+n0U2mGTXFoKme4v2?=
 =?us-ascii?Q?OkDhPYo7FwCtQkF0o/MYfXgSgsTk/0lMld+PbqwetkKQhQdLFs/TkedtEBHg?=
 =?us-ascii?Q?cN4a4eEMsuCRhSkk726vZFZAFgZ2r3nPp9Qrwz6+7yMz5Jxo1Zihe4Sj1WfU?=
 =?us-ascii?Q?7igvMs7vsNGw9mQqLAxpq/SnlMPw6/Uvs1gqImnnOgRAD148BGdJekI1bSNg?=
 =?us-ascii?Q?qi+HE0zxS+DhTf0WgApSxYfCg1kIIZ/g+eAp42YD80oT+W5V05Z/wiBX/7Tj?=
 =?us-ascii?Q?hr7X4Z2VhoQxvmG8YbFxnXt4N+mPIXRQdNn7sa9TzbzHPS5S7FeXmqnHbSVt?=
 =?us-ascii?Q?cEZgw87QM3///UB9zyEtY/+0awdL1TuEtvxhKLb72Zyv1rhGKGzP0q3TuegB?=
 =?us-ascii?Q?i7tdW9v/SGNIKEMVh5bSO9GKlxmOglM8FxjNGWPN6/7fUnmvzrB3uSGIS5Bo?=
 =?us-ascii?Q?FlDtXrquzPP3JMMEmJghWK8hwvYljwx8MThcV71mYQWxx7INYaU2agPEGg4O?=
 =?us-ascii?Q?E6o+xUoOyi1/VZCAWsW9BXTdVPN6SomWGTkj/hhYP3ZWMBzE3Lu3jC4Aq3PC?=
 =?us-ascii?Q?GsCr1F3s2rYesfDp9j+uZFq0dWNZWI6bQR+eldfy5i2c01HtJCB4Jy6c6mbJ?=
 =?us-ascii?Q?GjjtnY8K7PXF9MdcS4Njg6jSdfRgm/twZfMnTdUwpuGoGrEHVZ8FLpVTdqlq?=
 =?us-ascii?Q?V9JhJDqbBE4ZfmhbEGTvuRSMQ8UASgDIddhu4Zw+o9FbHqEYW2ys9/7DR0Fb?=
 =?us-ascii?Q?9tsEdI+6bP8SmjnImXtUXIvLTBIDWVHXNOR22VVh3N7/1EeqUCtZ/NZMwUbh?=
 =?us-ascii?Q?cJrf1AuCRowMfqRRoVB6jVrM8AH77Wph9+u6dSlgLO0SNyfm/yCmEX9e8sKc?=
 =?us-ascii?Q?4cufEUJ3woRSSmWV+Tyl5+fa6XlcUQlrImlNNehothc++lpGbC0/zBaJgqUU?=
 =?us-ascii?Q?2EWRcQlLqB3uib/bpAWUlEURM5Mu59JKT5oDew=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a06fdc-b7c1-4746-3b4d-08dbeedbf185
X-MS-Exchange-CrossTenant-AuthSource: PH0P222MB0010.NAMP222.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 00:01:02.2429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4P222MB0542
Received-SPF: pass client-ip=40.92.20.10; envelope-from=gihun.nam@outlook.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 26 Nov 2023 22:51:06 -0500
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
to 0, but it should be set to RAMEND according to the specs.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1525
Signed-off-by: Gihun Nam <gihun.nam@outlook.com>
---
 hw/avr/atmega.c  | 3 +++
 target/avr/cpu.c | 2 +-
 target/avr/cpu.h | 3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index a34803e642..3a8caccf99 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -233,6 +233,9 @@ static void atmega_realize(DeviceState *dev, Error **errp)
 
     /* CPU */
     object_initialize_child(OBJECT(dev), "cpu", &s->cpu, mc->cpu_type);
+
+    s->cpu.init_sp = mc->io_size + mc->sram_size - 1;
+
     qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
     cpudev = DEVICE(&s->cpu);
 
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 44de1e18d1..1da7d7dbf3 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -95,7 +95,7 @@ static void avr_cpu_reset_hold(Object *obj)
     env->rampY = 0;
     env->rampZ = 0;
     env->eind = 0;
-    env->sp = 0;
+    env->sp = cpu->init_sp;
 
     env->skip = 0;
 
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


