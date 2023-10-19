Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3E97CFA31
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:01:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtScQ-0005iC-Kr; Thu, 19 Oct 2023 08:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScN-0005hd-Iv; Thu, 19 Oct 2023 08:59:15 -0400
Received: from mail-db8eur05on20725.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::725]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScL-0002g2-OT; Thu, 19 Oct 2023 08:59:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhTMvcbxHAsjDdNXLDeam9p5Qy8vd1rFd8ua2ZtAxgPL0TAcFh2DNzHpXbhSkCVrA4kjcoMZOwXi3SKypc0VchrfpVaAACgrok05Ijxtf/xJ1ZjL3rZA5NJTACMD2uBume9KGkRXVNDzKfYEeV7NhON84wZoqF2iwIfu/fDGTwV4jvMnPUgFjutRX9HGJYhEEHuyHAylJggRpG5ckgDLeuk7p3j36iuuv+mR9eyaqdC6GOJRXPzKpoLsPxP4ojY/iK4I4jIjlrQBBs1A4ClZOO/E6WBuQCzMiophBVNP1wtiBkQKKjv2g1mCijryTJJePZKIv8CkJZRzRdv+xogbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wmguTHr8AiAOvO1Cv4xcdIkU50krH8TmKkx+Ks4lSo=;
 b=kE1G3zZZAWnaffA1wJgFGmR11v1Y5+o+qErrAOrB/WDuE9KANbXOPlHBDtxrhpYkxMa2boTgTwlKBvql0dUnwgKhPviuLmRFHEaXR/+9RDpHzWy44r4xeiamaXT59gh95lYdSPsdZyLkjDz88Ta2Tzn8/DhaNu627InwmAXrU187mk33k24dvaJZfBXaBqMvGN1BRyB/5wrm3OJBiOaNXFReufsMDvmbcytuG4GqPBJAkt4IAlVQcnPp2S4zAbE3KLdPXlrA+k6h8E6RvYzpBjYP9O+toMaROfwEbebKW9IzhxuJ69G7L89Fo5AYjFUgO6wJ57iseH/aSzpIl28q+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wmguTHr8AiAOvO1Cv4xcdIkU50krH8TmKkx+Ks4lSo=;
 b=En9YMHYEywQ3/KF4JLFaO0si0Y1qrwPVyIvCouapczvhxcEnoE57xs+IB/KhzEYQjYCXUXT1gfjLhCJ3Y78kwmTAC2zdz3mBLIVqTGhs4+BNGDW9dNiYscQXAf5tUfUBhZNAWp3Kv3AIN5lEiIO9O4APwtcXMAzfcPpv4XsBr77gMvnODzuzoYrpEtgJ+TV3Q0zljwdk0Mr03+l1yQ2jbjK5MuKq8mi6Tu94Vyns+A3nvG61wL6CP1EeinyM9eXCNy/YhKVswmXcKIm/Yu0B7ks7Rimpv8/1CWNTshMl1xMli422eBwDNdpiUNEp6c5DrXZfifWWp4b9GDau33tEuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by DBBPR08MB10554.eurprd08.prod.outlook.com (2603:10a6:10:52d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 12:59:05 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:05 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 03/20] parallels: Add mark_unused() helper
Date: Thu, 19 Oct 2023 14:58:37 +0200
Message-Id: <20231019125854.390385-4-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
References: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::39) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|DBBPR08MB10554:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f1e8ff-5254-424c-14c9-08dbd0a32cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M1KnUp0HEkA3Ys7kVoi2zwEdkLrg2yR7e8+5MX1FBvqWQ+QIjkVaVzb5xhQqQxLQotJDKEhT4gy+XTEK7+KTmFhpFIL6PMcYG+WIqblFQRR6RlEvgk4qFv48Jmy+5XbnYeAO+Y+EMecO9/7SQ/UU7N5rjpLF5jBhmcJtxE9fmWu+e+zYFy9vrj4qr2kNvkGKn/7EUSuWE/MhBKeYXuGsdrwOiwZgQTANCO4fUZBRAsD9g4nv9ddTC/5GCPhdvWU1niPJmvw+YwYgkmGbIGV0MWSCGkFwCOQGalSdGmdd7lxcgrli5ba++A6KmBY72owfU/OB000lQS1mQeh8Zzg7aaPhqCt8KGT7dvUIaXIyZ93LG+GaOjPP1tcw+5hB4B/wfM1XY6fJWyOEzWzEI1lixADJP3lo1+rebDTuD1T0RT4ICRr4b2L3B7mSs6JIutVT7GI5xepZUeaMIaU4ZFyLxk2zF/cBbKf9VyyAqiKuNl4iZXfc880FKpbc6oNpOd9HmFjz+4leG6uIAUpbekxrgRPIZsPdcE+0Hg7FTnhO+S5CXKgRR4FGTlJsh8/eSpWSxFd43gJiGYQZ3hxR0V0gDtep0DOMhgVtnYZcVQL26HwbbNeiZsKIc/wKndHe1sRT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38350700005)(38100700002)(5660300002)(83380400001)(44832011)(41300700001)(86362001)(8676002)(4326008)(66946007)(8936002)(316002)(1076003)(6916009)(66476007)(66556008)(6486002)(6666004)(6506007)(478600001)(52116002)(2906002)(2616005)(6512007)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ANDOA7wsLYSDBZgWTS6RO7Z8vb+Fd7ok+Wq/EZgloZIq9b13x0DyXchR6Vf?=
 =?us-ascii?Q?hogmlRxxmgdsc2BbsjnsbtfmVOAxLla10y0JC8iubw1D83cLBLTBCTAaMO9j?=
 =?us-ascii?Q?XssuSvb6o2Swbyqoi6jPyMFWsHBgSRAhn2j1Gnu8jmnzWINTrZZMDCwzbNiu?=
 =?us-ascii?Q?f2G7Kua/9gLWq13PSaz42ENp3xYOEp18va3rkjuBQbt7R3VSpCRt6L95mwHQ?=
 =?us-ascii?Q?AgnaWtL1tEz/kINiplGIjWX2IfAfac4OZK4QnU2Fv9qi9ZvbZG2zgLm08NCm?=
 =?us-ascii?Q?GwWVu7vY3ly0Lpbs5ZDwzkFiK0EQrW1teZ6XJom8vLBhundaP0ZCpjfA96Bz?=
 =?us-ascii?Q?M1rHTqCdK26XooW/D5fWbYv0aEcuTYh6C8pLVISZCs/jj9b+SS8JeY7dXw3y?=
 =?us-ascii?Q?incYSM/QIyQPJ0Du4qGESuDwh0bN7aYrDaMQCfYnHrpl7F5mdWqfHRDurYR5?=
 =?us-ascii?Q?ex4ZLc0MnEX5xcVyhFYLk1bgfyDpRVBdWxDZkrLzxsyBpq8Jx9qxihE3bsjU?=
 =?us-ascii?Q?JDbM4l6ETcSDIROlfjehTr5G3pgKe28vcynqhfm42MAa8k/yZW50BXIgnuU2?=
 =?us-ascii?Q?Qeipx6ub+5SxNEvZY1gMgyWXSO4NV2eEH9/L4HRheI4c+unfdweJJ0t0q+qG?=
 =?us-ascii?Q?t3ZVZveW02kZ5beuTClDyofNULV2+K+rdE4AxB3JCHHJLKxxqKGuxHTEx6fo?=
 =?us-ascii?Q?dN1lJODe2oz4nP7pi7jXDnwrcgHP2yIprMbjkWsJ5uR08xWdWGLuZpY0IIzG?=
 =?us-ascii?Q?CB3l5noJNPr5LEt6Vo53NQY6kH25Sn7drosrzLiRjjhguKnb4BypVXUCf0BN?=
 =?us-ascii?Q?cAzh/VXALhXDrrSHmofpeqb2H+tjyMu0FVCxReDi+D2tYfoY8BDiCDZTEqTl?=
 =?us-ascii?Q?hBr1MMtQXXKeXB+gtse3WAs0HE133D2xx0K/4ls0YSDF4ZnmmYVBt4DPu64q?=
 =?us-ascii?Q?b7hghlYajsu7KyDY7+udUas8Kwa+iSDBjqQ3iBM3zaz3KAduZS/0zKbvPufL?=
 =?us-ascii?Q?aJMYWA8rwYRerSh07xVMUoTUaJEmCjwW93aFitX9M6JP7vJw6UIB64yiKRxa?=
 =?us-ascii?Q?w4XKLA80/1aevFsiqr16gx+gQK/X/w0zcMYA8wCQph6d5goWPuXqFBGecYEv?=
 =?us-ascii?Q?8FZ6qbkgeBvQIbDDQWE12qkp5j7dclJWPAAqSRWCB/lNKGeRjIJoeB3sNZ0C?=
 =?us-ascii?Q?2XTpeSNO5/ybuyyIstFqOd9XImdbNU1F24EnayjRcWSFoBFT58tW/OtKodTC?=
 =?us-ascii?Q?QdWzuNjXQ3AJP7DxqPYrHT5sfK+1TC05+zjwQTaNpO+Z862JNMeabkRRpStR?=
 =?us-ascii?Q?YRgNjVOsTRFz3NoiJWtx6M915zDkhskWt3sYJLm9CSH6b0DgSWWA5p2hT2iQ?=
 =?us-ascii?Q?ZB1NwjBYH2DGQ8sbclO5zLG8937S/lJNXvtNhWo9u1qGonLjYk6/9MLA60Ja?=
 =?us-ascii?Q?yNgYs1F7yU2ymBHXGdJtP3oUVb203xe91eOMg+r3gOMFtd1q+7qUhta4WUbB?=
 =?us-ascii?Q?SQfiyKMGw2nUEbOzdrker4uyHH4bjOl1zdnvwrYh3xl//NpaN7lq3r4zKNge?=
 =?us-ascii?Q?AYcAQpdQRghRXmH+b0lgVKai1B1/e8/jOFpA4GVcuqWka9FM/+UsWSfcZ6eg?=
 =?us-ascii?Q?fqjDBJVDMwonnqXFiLMxic4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f1e8ff-5254-424c-14c9-08dbd0a32cfe
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:05.8213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhlOlilHHSkWYdaMzprBLWR32yex8qXETeVEt/yjFLUGZrHIISwamPlvj57bX1SdL6lCO4Fe04cWPLxI6p5fyadcvcr6JRa4a8/sS1rYZz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10554
Received-SPF: pass client-ip=2a01:111:f400:7e1a::725;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Add a helper to set unused areas in used bitmap.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 7eb92f87ab..6a4e3945c6 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -195,6 +195,23 @@ static int mark_used(BlockDriverState *bs, unsigned long *bitmap,
     return 0;
 }
 
+static int mark_unused(BlockDriverState *bs, unsigned long *bitmap,
+                       uint32_t bitmap_size, int64_t off, uint32_t count)
+{
+    BDRVParallelsState *s = bs->opaque;
+    uint32_t cluster_index = host_cluster_index(s, off);
+    unsigned long next_unused;
+    if (cluster_index + count > bitmap_size) {
+        return -E2BIG;
+    }
+    next_unused = find_next_zero_bit(bitmap, bitmap_size, cluster_index);
+    if (next_unused < cluster_index + count) {
+        return -EINVAL;
+    }
+    bitmap_clear(bitmap, cluster_index, count);
+    return 0;
+}
+
 /*
  * Collect used bitmap. The image can contain errors, we should fill the
  * bitmap anyway, as much as we can. This information will be used for
-- 
2.34.1


