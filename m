Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ECF75F92B
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 16:00:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNw6m-0000t2-6g; Mon, 24 Jul 2023 10:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Evanzhang@archeros.com>)
 id 1qNraM-00045c-1b
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 05:10:34 -0400
Received: from mail-shaon0119.outbound.protection.partner.outlook.cn
 ([42.159.164.119] helo=CN01-SHA-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Evanzhang@archeros.com>)
 id 1qNraK-00062a-5m
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 05:10:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlfTykY+sws95O/Yek9UThpFHX3LCNv4YWoCXHtSqMtqOm8yfO3ShoVmIQ3mgGM9WbQGSYz3V0EoSQPLvB7zcaVA7qfQ+YwkqR5xP0mH5YvLAnZOXrsEryluXNAXgrvtcDLUPtC9b3MwHRIGRgjFWAw0dOkeYT9kXBfnyorGcRcutKbdZvglcBMDDwEXuQLvcwDG80DQ9bWjQ5Eh3JexaOw5JU81xiG/hNBO+1/Pyk2hUrZ6/7Y4TVXXn7ItcTSXrezauZDv4Z1FYOs9UPSnMr09yk9D2N2lSYzoHj7wCxJDUEX4p97NSYVL2fIEejPk22vChQrt9iwMGnpOOiZYTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZNpEg48rq5ntjHJAxetOenIocTK7fc/C3Y3Yse1sbI=;
 b=kxVU8+DbpM/kjV0+dt8jkX5Uhy6gkR+7GcYGpwm7zA+rSe/Gqi/XQ3SEdrbAUwXzfPqqicpPTJCciJyDvPauEfjIhKelO+R1XqQYo/OgEhwc5yZNQjOLs62MaJYqpUIn7n9AdPhNSBofTEozck0EySYwAz34me1zpZ5OiIZ+9tHR8BN+xOi1Q1S98ErJTqrFYWHV8ygDzhyGH2wzkh/qa395vBFIz2LFQByIZ+1zON1nR6WlPQQRiTBMkStHD1Mlp6uU8FrlEb4StEIw+QFNpviZWciTY9wrRsUgVDe8eiNx5F8CwGRAEbjm3W4ugHbcbDiV0Gn0kmroQbRB76cEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=archeros.com; dmarc=pass action=none header.from=archeros.com;
 dkim=pass header.d=archeros.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=archeros.com;
Received: from ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::13) by ZQ0PR01MB1157.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 08:54:38 +0000
Received: from ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
 ([fe80::801d:e216:d86d:2c4d]) by
 ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn ([fe80::801d:e216:d86d:2c4d%4])
 with mapi id 15.20.6609.026; Mon, 24 Jul 2023 08:54:38 +0000
From: Evanzhang <Evanzhang@archeros.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	pbonzini@redhat.com,
	Evanzhang <Evanzhang@archeros.com>
Subject: [PATCH v1] rtc/mc146818rtc: improve rtc performance
Date: Mon, 24 Jul 2023 16:54:22 +0800
Message-Id: <4490419ebd87e46adf2294f62c5f3808d2467e40.1690188072.git.Evanzhang@archeros.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1690188072.git.Evanzhang@archeros.com>
References: <cover.1690188072.git.Evanzhang@archeros.com>
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0006.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::18) To ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1015:EE_|ZQ0PR01MB1157:EE_
X-MS-Office365-Filtering-Correlation-Id: a38fc389-39e7-4de5-0678-08db8c239cad
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qrEKZsHW0IFyqkUbbvfPIXy4qaEmSPUwA8U3EXAdc7aQyhhawIUMe5aR3cV1OMyixcF/OHgLk4Y15e+kZUZ6KOz4m15P2+1LlhSJyIMiy8b7+hV1mxuKqDJ8Bn9mKMrxHiyjfmEhX2ycis2bB45uRKfuuLDbUyErA5JSOX4unNzSVsI378KRL1D/RKuJTczc3LDvwedS7tABg9rSybbu254jNLWAd9ypRDpIQkKtA/Cln9+83Ks4AMzxJY8TEYgX8nctxNoaN6TpFR1jJBKVU0GHjqn8Fy8BJ15VC/Y/P8T1FdSr9ZfAZlIeo0tHuAQh1gRUJTMLMCWWxTOeoBtw/eMHiY5cwTEcpeNYP9+cYTBQStC8icAoSenF5UD0a0zRWiNxWMlwNOIOuEz2tAeXycYWwdxBIoETljXWsoBPO4j+YpS8mwisP6xjFFzwzFYeMyRx8zSEt+9urz3lTKbXiJQKpN9UC4INrnBjugqkY8dgwrooRf9lFdkp8zLfOBW2/iaej03UVjfqceFhYsEQ1nxJUsLilFBYDENUYgbsCNU+TlH7R8bJ4CWuZETGirHYb/Yzy5RyDMr7htjh7Rwxj/u21cGu3Mjpgj5sljz3F/52ci0rxj6uoRjqfnJ0gVTCQzVPEFIHHS4FmuLOx+4bXy6JpLccgbUEeAlgpg2wdNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230028)(39830400003)(136003)(396003)(346002)(366004)(451199021)(86362001)(40160700002)(41320700001)(38100700002)(38350700002)(66556008)(508600001)(41300700001)(6916009)(4326008)(66946007)(5660300002)(8676002)(8936002)(6666004)(2906002)(40180700001)(26005)(186003)(52116002)(66476007)(83380400001)(36756003)(2616005)(107886003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7IndM+MGtTlf+j55V6jIFyw0ZfyjG+guozPZz804QwNxkuO2eLMzzo64Szp0?=
 =?us-ascii?Q?WOoUVJvUm2JwVFarivZ4ep93+f4qePOzNZz57lGYeNddo91oj+O4IC1inX/n?=
 =?us-ascii?Q?jopAtyiO45QvhJfHQBdIqLq22oFRcgjzbvzaPW08L729X7XmNR+HOub2D6bw?=
 =?us-ascii?Q?BEs9Q+iU6J59CQq0/Jz0n9qPl5o2fO8eDvFy0pnrjv+zEQGR27Sf0ixRLMZJ?=
 =?us-ascii?Q?XD6YevE2FqxrduBk2v1RGXeJFEHqvbrmNoLF0fKEUq79/yNOk4aFO1x5MqEJ?=
 =?us-ascii?Q?rezN/zYDXhPw4iWZtmi3Dvc1ugEUjPBZXXBTYk7IW/CN5RVulMy6o+FmNiIz?=
 =?us-ascii?Q?QLM+7WaQ2RNynsWCF+szumC0hBq34XdAbYtCHOHC8Gy+gjMG4YnFXHdpkJJb?=
 =?us-ascii?Q?t1x/VTTxa4xPmFyvgQGd4wVwiIvJudwSb/5BC9544c5NnQXHtu+AoUeLTHq3?=
 =?us-ascii?Q?irYyZLiYWAllqw1OTXXfPUTtl/91w6rgWtjIps9nHMaJ23edPRchy4uff4T9?=
 =?us-ascii?Q?lZuhJLh7gzbzyrjhPXBPv6r0H6hgWr95vGQm4AKPeWhHqStMIohUa8FzW7kM?=
 =?us-ascii?Q?qFg8ceUg/3aJT2hyGJ8xPMOGS+au3cl9fp4qooJ2wz3rZrZ1C2tyUT8K7hIh?=
 =?us-ascii?Q?LY1+GGxXuaOhLNrigYnCyjbaLKpp7WktqSYo7BU+ZOtt1CgMD+784wEq3/gO?=
 =?us-ascii?Q?ppDZBMRi+0r8SENTuUaIyWhb2m/5nbzW08vP0WnWOzwlwl9K9Ylpo/ELiSFx?=
 =?us-ascii?Q?dnXN4jiuKbbKaPrXD9Kshx+skaA9gEpSo/Yf5XxUEY9d1Xu0S4gNzveGggCR?=
 =?us-ascii?Q?K7fBzW20xdrYmfseV7S8HSVs1ktwuiiyctphp1KOimZyFggLUmnr8TaQiU9L?=
 =?us-ascii?Q?v7RAo4XOQ35ZzqbhaBXXavx9X2M77Oj6xiimh5mdi4ydsc1jHb+QTf+/Tfqe?=
 =?us-ascii?Q?Pq3EBQWxbC5H8TnNfSVBNu3HTnbBpqnufk/kcU/yEZWhWvm5qh6N4m2N7diU?=
 =?us-ascii?Q?kSljluM6v/K+RK13nyJ1TMAj6hIRVX4hPoc122E4se/ZAd1Tq0yBleftg3Q9?=
 =?us-ascii?Q?A7T6/qXDNo38dQqwysZVRu5DsFiIZLo85SQo+H178t2I/Y0f/L1pPRN2llUY?=
 =?us-ascii?Q?JtIVPDvqvJwmD/X5wEuyb3gFnSINwkY1lKxH5biEt1c1cncT6jrBMSj2oLMx?=
 =?us-ascii?Q?7d5GoDAwMf/iY7zcEri74HqZSR2ozufmoJr+akaazdMAGmFOQLxJn4jgBF+D?=
 =?us-ascii?Q?eoQNqgj+CQG7Exnz1vGlJfh/ok+/IytGHtlaLCYUIzTzkNOSc3quu3hPffr0?=
 =?us-ascii?Q?/xe2/jAGwtldYVqgDuegUGoMinO9rbM4O+0vWSIB+K61TiLCYAb0gEKH6BsW?=
 =?us-ascii?Q?i4Lhfu4rjXidZZXaUeXLptO5gfv3V7xVlOBjlfoyPaYDCFJWKZgkoErDgJD6?=
 =?us-ascii?Q?eoETDwKe8lICuvHFWC54arCFF+1xmFHMJaO8TlMSv4WwjHvBGIgUA08aaOpJ?=
 =?us-ascii?Q?vuHEDr5b4F3cQk1aLAU92eQMF1Dac0mHLLoZKg0W/MNglroLnPJycrMntZ4G?=
 =?us-ascii?Q?wLCSkKig03wlKLOTyKlI0hgWNssZUKFiQXfByjTwA+EB9h5qKcPKLKqCy0m8?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: archeros.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38fc389-39e7-4de5-0678-08db8c239cad
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 08:54:38.4301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8387253c-f44a-4a28-8058-3e5c20af6b4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwIOYw/Bi+WVAC/G0imZULpbv1CWZ1h/u4FC5fn3JWYZi2JXFoz1LaYRiSy+zhvc2Xqu/7iWBfWqIcTDa4CnDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1157
Received-SPF: pass client-ip=42.159.164.119;
 envelope-from=Evanzhang@archeros.com;
 helo=CN01-SHA-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FORGED_SPF_HELO=0.024,
 KHOP_HELO_FCRDNS=0.001, SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 24 Jul 2023 10:00:13 -0400
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

under heavy workloads,irq_coalesced could up to 30+,
after modification EXTERNAL_INTERRUPT reduce by 40%

before:
Analyze events for all VMs, all VCPUs:
             VM-EXIT    Samples  Samples%     Time%

       EPT_VIOLATION    9833984    63.41%    15.96%
      IO_INSTRUCTION    2160843    13.93%    50.07%
  EXTERNAL_INTERRUPT    1949267    12.57%     0.89%
          APIC_WRITE     767795     4.95%     0.55%
         EOI_INDUCED     615308     3.97%     0.30%
                 HLT     130821     0.84%    31.77%

after:
Analyze events for all VMs, all VCPUs:
             VM-EXIT    Samples  Samples%     Time%

       EPT_VIOLATION    5238031    50.91%     6.44%
      IO_INSTRUCTION    2257658    21.94%    54.88%
  EXTERNAL_INTERRUPT    1160086    11.28%     0.61%
          APIC_WRITE     780454     7.59%     0.54%
         EOI_INDUCED     615309     5.98%     0.28%
                 HLT     179703     1.75%    36.87%

Signed-off-by: Evanzhang <Evanzhang@archeros.com>
---
 hw/rtc/mc146818rtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index c27c362..2995078 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -96,8 +96,8 @@ static void rtc_coalesced_timer_update(MC146818RtcState *s)
     if (s->irq_coalesced == 0) {
         timer_del(s->coalesced_timer);
     } else {
-        /* divide each RTC interval to 2 - 8 smaller intervals */
-        int c = MIN(s->irq_coalesced, 7) + 1;
+        /* divide each RTC interval to 2 - 32 smaller intervals */
+        int c = MIN(s->irq_coalesced, 31) + 1;
         int64_t next_clock = qemu_clock_get_ns(rtc_clock) +
             periodic_clock_to_ns(s->period / c);
         timer_mod(s->coalesced_timer, next_clock);
-- 
2.9.5


