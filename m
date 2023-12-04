Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E20C8029E4
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 02:29:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9xku-0007br-Ez; Sun, 03 Dec 2023 20:28:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1r9xkr-0007a5-DE
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 20:28:13 -0500
Received: from mail-sgaapc01on2087.outbound.protection.outlook.com
 ([40.107.215.87] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1r9xko-0003Az-Sj
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 20:28:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lr+IuI1UKDA++swDrl84aVzyNe854pNTpYMpAjnJSpm2DnnPm08TzKFwOhkrt5vTrOy/m/++D+hYgNqhmEhvnNaw7ewRmdrf05IJrNQZaf5M4aHgYawJyZxCeEtC4DXhGtRX+1vMjfo3qsM2rfv6cJ2NUACex7XFDaF0ZcNqkML1DSfPKhwGfgJDosgnOCmFhf64G8PMwOcNBwjWCiCgf3HK75sO0P1pthTqxTZSdmtW2mysIEseEBgApPulbkT0UpiFyi/Oyu4v1jyNFCDJ3WKKm4AREOfy3KF3kO3BX/ECiQbnG+gWaOoV/cKlV5vO5e4vzQt8ggKRE32rBZxO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyP/hn8vx1GjLhBl61MyKFtsC+t706nsLzdPHLEBY+Y=;
 b=UTDsrQE1t6UHAqbpVGvvypfnNska9B+YdkXFZKrc6y2nmP/affshWgoAR4qo0QDhDRFcZG71izLNt5WqppxKVPDnKbQEtnwNt7aA1HL+E/cKxbfN/GClamiaqojR3uRXZzDflDCNdUQIzvHKXwyT0CbN1YMan4D3n7jpRKLaQRkei4AUZxVRg6tgIryeXf68BDK6RvK8P15IGk0DDJd0pa3LxI9EtDC2w2C2D0x35Fyn2ok6N1bFyD0rBsXsjslsDbUmm21QN122q7b6Zad+gaCpTQI4HnEHJt4jIagz/jVYSZISK1xPpNKeh9TzZKkDpdoQm07oGBoY+oGpDnLKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyP/hn8vx1GjLhBl61MyKFtsC+t706nsLzdPHLEBY+Y=;
 b=btz6FtV89ULOq+1DEy+3XZWAoxhbTRVzgYIshAWIb74pM7G+xRoOVBXJZF1HPrYl1OKJEE/XHUOYwhWTMHYtkxAtypUHDLfNA57fUhJunWCiKacBO1R/LbjyfeQ2aSJwXuIUyD9t+j32xQaulnKzjj+VOoDyi/S7xwSyxzl9C11CXZFXZsUN9eR7XGkjxdjTlApvMhOdruJN1fuhA6M75KIxhsbDsfnpTTHOkCSUrHwM/PdIgfQqIYccZwWUGd/pW+9ODh+lLmt73+VckYxL05ZMzCU/p8vum7EVF9LYptnjhGxKZJVnpT30yrr7h92dL4sgxGTiVsznjNLSg0Bm2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32; Mon, 4 Dec
 2023 01:22:56 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::f525:3501:d5c5:15b8]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::f525:3501:d5c5:15b8%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 01:22:56 +0000
From: Wafer <wafer@jaguarmicro.com>
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org, angus.chen@jaguarmicro.com,
 Wafer <wafer@jaguarmicro.com>
Subject: [PATCH] migration/dirtyrate: Remove an extra parameter
Date: Mon,  4 Dec 2023 09:22:30 +0800
Message-Id: <20231204012230.4123-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::23)
 To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|SEYPR06MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b1c539-9345-4523-6ddf-08dbf4678b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WjsLJsqB/hiR8UQOKY7P6w7MSOVsfYbul+ug7Bn1Z5DLJRgbH0tzMVCm2jlMe6+D1MLJqQPqqddLuMXKIr5NmV0UX+VFK/EgzA0hd3UH0Zb6lwTxHAmM6gY83dELSsnEJMZhHzUmG50CQStdFFMsCGYm5YbOWJjgsIHILyX6SpXuRUGQ37zQnD2yDGXoCnxZ/5x6/y6LM4Fjfy888MGpaO+7AiWlY5+FYgbb/mRjLGGvHwHWVKYPwQ7e3kiOGe8t5xv3gVt5LxMFjGvll+2d8LiQIiN+GX0G06AXyzDgrErDKue3qTd+OTcWXBb99Fa2+FvfFdTLBKdog+P3d0N9qzBZJsfcH3KTs6StWKmIZm0nAKl2Pm+mHRLDlPvZPztEmaLVYzN9TxtjPhVVm7KyxKJxJVW1VG3elFdnCP1CBS/J1upYfOyjO3Er5xb/QfT4ivrrc9QpHmqUb/i8affQPgSMSp0+lC+9pjn8YzbzUAamIuSZS8N1jqo/so2j6Ixebc93ewIeMvfuWi1uDlRXYwStuMOpyBx96h1VnYtqDuZcukl5s25neh3b9BlfCCnqN8bk9fTAbTZoz9zbJrG5xHCBzEPWHQGRvNHzCNkKwcUBs6fxDwzkG+e00YfhXlX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39830400003)(396003)(376002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6916009)(66556008)(66476007)(66946007)(4326008)(8676002)(8936002)(316002)(6486002)(478600001)(6666004)(5660300002)(38350700005)(36756003)(41300700001)(2906002)(86362001)(83380400001)(2616005)(26005)(107886003)(1076003)(38100700002)(6506007)(6512007)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+t6/y0/omdT/go98Z2U0BN3oq4tq7OSNZOd2dRowZ5QdJYx8dyxmmaa82eKw?=
 =?us-ascii?Q?uTiVMGZt79rbv0WEjWusIPlk1aY4/JqBWuqG03RwcsvrQU+bnwKkd3ERhrnG?=
 =?us-ascii?Q?7iGQLI14gmvU+8brxa6d/xdcs+n/YOeaHJhHvJO0m82h1pzQr3hwhHNnV20d?=
 =?us-ascii?Q?SNsuZlHjCqKmrpsxP6H/m3XunQoZsy5yuCoVEd+L10/olv6s0h3UzIBh9pcC?=
 =?us-ascii?Q?qbOZD6Z49zG/0QimrbsgIqdWfoifVGdrQMUn19o9vz1bSkGnrWfxKckz1seU?=
 =?us-ascii?Q?LN4GcS36/dVAQYawJM/49l2NsRrrx2r61WI3GHSbnFg+ltcgrEGkwnI7bzpd?=
 =?us-ascii?Q?CfQ8JO5yv7Z0qEKRx6a2ufrGLPKM2rBCxwLtgTNwuE4VSA3Zydr/EdE5cqnD?=
 =?us-ascii?Q?PSY0Le8FVsF3jZ6beBkVbFYTJBz1WbYaOUV8aXAmnBRNRHsG453awIpRly35?=
 =?us-ascii?Q?mWYv4YCDwm+u+jkCUrMz+HoqfZOrtD+h6R2lFWrLn1SZ+rla22UmquXK7NKx?=
 =?us-ascii?Q?Q1zEd/Qh39kYZIcf5GQsWHQEyUEtJIzCXH8g2Syi8fvnJj/eYi8KV2p7INJ4?=
 =?us-ascii?Q?WjaSwztH6lfc4EAbEZHnIrl+Ienj2ExSeTXofU8mk1uN0iNFwCNvhaBuYoh0?=
 =?us-ascii?Q?LY8Xn36QwNcNbqhIdKTnbIXK7WHm/TNMdvTnSCEI0Jh+SIC3oNmwgqtDx07L?=
 =?us-ascii?Q?WoIr6lYzuD2l/ZYNxBWHr1B1jwVhLGWuBhnUx7YMt37WQY6MucZCCLDareg2?=
 =?us-ascii?Q?6+waRiTSQs8Gf8b0/cF6AqS5zJbnjB0JTTxWbUnSgOM94Vti265MY2flNyEm?=
 =?us-ascii?Q?o9zw4xFGl9Ep9DMu2Djxy4C2vLJBJiBAK9iu3wUWkm8yskICNlAwQkxfdMdO?=
 =?us-ascii?Q?tTr6Zm2hp/AeBzqSyry6Tyv1nDXaf1Ui5aAW9EaWd4Wy2hxMUJsmm1OvDLvG?=
 =?us-ascii?Q?dr6RSo6aY2RmAiuYa2ZWpbFYVnRKe0ltettw7P1FIPZTizLy/PYo1MALirkt?=
 =?us-ascii?Q?rRmbDTfTFAxhgBU24R7iJpcDuSSkW8t48oABJezlCIFf4Q3NVvfpi/YrHan+?=
 =?us-ascii?Q?pcjaFRyQ8BcUA1ko/km7lmrRa9oVzBPegRcocqRgaz04wBrli8TF5yDpnzOe?=
 =?us-ascii?Q?ymGWmnYU5nui1XjScncP9E4VeTOy+xLo8qkXIkLIT+Z46dgxGGNF1JvFY9SR?=
 =?us-ascii?Q?9Uc59zhIKeg6rl2R36CaNOB5tV9U/eJtlfgkIvnURtun8CyKk+HxXN447uoo?=
 =?us-ascii?Q?MLIw0wmDc3b+SdSPbPFR3oPWoR2T+gjn14gqQ3z3Sj6yJZsCgarAibvQeDmV?=
 =?us-ascii?Q?K+P5GcV3j5fp8vLRI2+Ma69HNbgxOBGQQjz2WDc4NTvF5GFVQpseP2ZcPPAg?=
 =?us-ascii?Q?uP4YRRID9UkBYEW0B1ZBr84YqVtxP6wB1EPajTmoqnl101eeWqTlOg2XJCfN?=
 =?us-ascii?Q?YpcsFMOAsgLEN6BYmcKetHT//bkbK9xuI5UL5GIDD6WoqmyQ58xtSqhquF4o?=
 =?us-ascii?Q?IlobenIOfAHf3+Jg+RnV1dQjmJTkorIPlu0iGnk53EF4vILOlqEtVO12FavJ?=
 =?us-ascii?Q?lopGntqEIcQZa1PeDQ1T2qnhndyWRVU+oyrK/Zkx?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b1c539-9345-4523-6ddf-08dbf4678b49
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 01:22:56.0764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GESJhGwiJQmt1rNIELtB9HX4tIaW5xa8PAdg/dGtAhnx3sA2cEALbAyJgDwlDdqZs9XHd/93OhS7V2obEDLGqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6278
Received-SPF: pass client-ip=40.107.215.87; envelope-from=wafer@jaguarmicro.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

vcpu_dirty_stat_collect() has an unused parameter so remove it.

Signed-off-by: Wafer <wafer@jaguarmicro.com>
---
 migration/dirtyrate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 036ac017fc..62d86b8be2 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -129,8 +129,7 @@ static DirtyPageRecord *vcpu_dirty_stat_alloc(VcpuStat *stat)
     return g_new0(DirtyPageRecord, nvcpu);
 }
 
-static void vcpu_dirty_stat_collect(VcpuStat *stat,
-                                    DirtyPageRecord *records,
+static void vcpu_dirty_stat_collect(DirtyPageRecord *records,
                                     bool start)
 {
     CPUState *cpu;
@@ -158,7 +157,7 @@ retry:
     WITH_QEMU_LOCK_GUARD(&qemu_cpu_list_lock) {
         gen_id = cpu_list_generation_id_get();
         records = vcpu_dirty_stat_alloc(stat);
-        vcpu_dirty_stat_collect(stat, records, true);
+        vcpu_dirty_stat_collect(records, true);
     }
 
     duration = dirty_stat_wait(calc_time_ms, init_time_ms);
@@ -172,7 +171,7 @@ retry:
             cpu_list_unlock();
             goto retry;
         }
-        vcpu_dirty_stat_collect(stat, records, false);
+        vcpu_dirty_stat_collect(records, false);
     }
 
     for (i = 0; i < stat->nvcpu; i++) {
-- 
2.27.0


