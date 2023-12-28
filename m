Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D6D81F6C4
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:15:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInOI-0005QQ-Lj; Thu, 28 Dec 2023 05:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNs-0005KL-UW; Thu, 28 Dec 2023 05:13:00 -0500
Received: from mail-he1eur04on0713.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::713]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNq-0000at-Lw; Thu, 28 Dec 2023 05:13:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kt5RZleJ7cVaWrR2ggCRwo3QWxjuUTzdD1OIQkmw2Hyy1hsu942bHcX98XFIwWPD6hzaxS37NTunD4mxwBEurrxHWgvMwStPHpUvRQ9fMB/lzb78mpUUOOZvBctgCf2cCnnlGfiQ3wGz8/XlKf57ypxUKzgZpjWedVvYbuf/50+wOW8GUImm/u3tKpG5azfBFoPh6twn95Fv9kNhmOrLr+sBIKUrYLhuZAEUPIoWEUx4F3jiJ4Pqf3PvVA7XVW6XRZVNJAzEyBE0974eFNES3tToZcPwHcO8wVdJOTMpdheRanvs06xB0Z0Ipuke3GnCYAqIKcBMs7NWfg9nA7L41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MTFvJZaRYxijrcCiOR6/WdsYJiwbnhEJy5neS3DPRI=;
 b=EAY1fjkvp20Q7MlX5Fqfir/Yp89ptsSiMUoWIlU+ihDIQCfGYSHsBM2cNBQpODLBkqh7d+vnHBitsIU9XXtm2VkNM2djj+I2xpP9Fao2IP6WDgPiZJqxF0CWAxgVsSchs6oIrfKQbRML7Zd2JM7dzGp1/V3pwkt55COLTo7cKcEfQscwm3fc1GsRVCLr4/GYdDMGrCa+UKVjwYbfAMJuKTvJ4dFczMRfWTRbk2bZ7v05bKX5KV+7fYI7UE+iCN/YNBvzqVgH08wogtkbJe8E12vM1jAYHXQOjSh+XFrd0VTqrtKgcaSnrOhGPfNrV0Cib/wMVJZZilRrn6hjPR6p9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MTFvJZaRYxijrcCiOR6/WdsYJiwbnhEJy5neS3DPRI=;
 b=DQYf1ArQy/o+WsJjErpr1DcgpJ839wJZtvg7stczEnzjE7UwzMykajYde+kCyRVNKDEurFbF+m8w6PLxnVA3jxh/yM5U9zsbOrSoK6zeQJGQWGqAvMTSjEeuAwi1M7roc1m+oi1aAz4TFZL9FsW8Z/N3+OOs4c+KcgkD6i9ti+AvMwVbVS7DlCsAXeDlz+phfWsudTa5MYNtETQhYybR35sryt6Fd+uUIbHqarHt90nGbcY52RYCvOQ+hZwkc9FFMlJIWRLHR2KW5HuI1FJkpaSIwNzRb6J9J303ux3JOzDIdhFEc0W0+W9Cd2GAvKA25mVRMLp/kVc8jpaIB+eJ/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB7459.eurprd08.prod.outlook.com
 (2603:10a6:102:2a6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 10:12:44 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:44 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 09/21] parallels: Add a note about used bitmap in
 parallels_check_duplicate()
Date: Thu, 28 Dec 2023 11:12:20 +0100
Message-Id: <20231228101232.372142-10-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::8) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PA4PR08MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d51990b-4af3-4aa7-5f6e-08dc078d88d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cAqDsTQ8tA/A8IDHAgxXORuagU8UxfB3M+apirzX0erBTNALqYUYibozyE8gut3z+644fDequ5AKi0AtQPeS2rCzJBEZytvh9d51zJsjj403Tzymd4kV0+nr0jx32jX0KtUa8sWiR1r8OZzBtQrIo7cAxIyyPPsjlAjbEgpA+uRRXYLzgQiZxqPH199B156jilrHl9FfpGSALydHa7WWyPLGvst9ziRrOwev0YBVffL4+ti/UA2K/+Hu0csQMT57zC5yTH1Ud3iIUwnCX/7yeKYY4d660x/9xX5LaPEQvOoOvoAjT1rTFBikjLX1UTZvhLyGZ+x5BjdQYJkxck3xn9cJdgF3p7Hz3jkj2WRD46v+p4upQeWu+3o3xKoPFw5Qv5/Zg7spTv0LUWaklOsJGsB/JMxSLcTZm1EUCqd5IPmvOe2LqB7r7kIA06a2X8w0YiZxgmgQVnhvTqaSw6S31CBDJbQE6SpBVzs0sQtGdXqpKJMqWTLP9QweOsBmYXgmvAMWgjhfFT8kUACJNX4rEmMfkiQwbInb43XNxlcHDTQdNWWo54W+fIt95O/x+aD4Gum05atADB0onLv8rI7PwwsnFvLSOBaPbdSuBATIABDFKN2o5vx5uEbpHQyQ6lC7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(39850400004)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(1076003)(6666004)(6512007)(52116002)(6506007)(83380400001)(6916009)(478600001)(4326008)(8936002)(8676002)(5660300002)(44832011)(6486002)(66556008)(66476007)(66946007)(316002)(38100700002)(86362001)(41300700001)(38350700005)(36756003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W5XFRimpBB1YLURs9Xm0B84K0Y37eczIRGJrDkzvCph1/Xq1wSXRp+XFdTRh?=
 =?us-ascii?Q?CT7DCuMHTL6Vtx7SZQm1U8eFgofoYSxwkjOTH0D6aQJcsxdJWhT1+2/iE/o8?=
 =?us-ascii?Q?3wmKkimyhbzA9giqjaUBU8DpR7H+t6+mWwKn7WBZPeG2G62O/TNwJSBsTLz3?=
 =?us-ascii?Q?HHYrA2qh41rs/iZcCMxsmc/qyPjqDoInurWs+2ht5uLhLsv6TV6oiOyW+Nfd?=
 =?us-ascii?Q?rjSgoVMc8SJXseDz9hdhv0eCuZrwfQXGQhpLgvWPno+miVlRDzVPU+erQEqC?=
 =?us-ascii?Q?YnEU3aY5NJ3MUckqXe8Fba5rzdNI8xjTf66D3eEPDfexLZTKx+P6n7M2BgOF?=
 =?us-ascii?Q?B7+dzLlvvglHeLeYCHmI8Z1wwg1bGgpM4YJ1FxSQAMPQBE2XgFBfF/ssnG1y?=
 =?us-ascii?Q?ssrybgZjVdW52KoapYGPhHOuiPsBowfFkZO1jKm0c8fgXoV2RiGjJx9cdup9?=
 =?us-ascii?Q?Jy7leOuObqsTmYu9v+Za9IVhxLARgGeFTnO2pnN5DX4WFdXmIB+Ea0cnBgb8?=
 =?us-ascii?Q?tillFypRpwgaSJA18kwGjz79yObMOCKlXmYKj5WZaKa+mQZ9FrIbP5rXvt5H?=
 =?us-ascii?Q?2VjodEhej5o1nIsXXpo+wHMlJtjHMIezzPwr8jdSSuUePKemTRf+pqwcgBJ4?=
 =?us-ascii?Q?i3RS6vLUVXmM7dL2+2XJSSbakjeEAwEapAq60lu+KSDIMYOBtrGQxOKF/w+w?=
 =?us-ascii?Q?rwkNsDkRPSKjo1+jgO3jqhpYH+VpaHzhvjgVw30lbNwTg2lCO1eDEj8SWKq3?=
 =?us-ascii?Q?zPc94EsQ2dbTbS/RF7GEDhFeyHGO5+HNPDkZy+jg3ocVp8pDq1veAuZ6CFcu?=
 =?us-ascii?Q?tlQUJwYBj7yeYfWL9pzhb5lvtEXPYItf9pZwykkylX2iR+/gkC6rIf2GS0D4?=
 =?us-ascii?Q?KmHlYpn+kMEk+j5rtoYyhLh0F+RLtqwR6gQ5dJJVJMEtmto1DfnVfETS6yII?=
 =?us-ascii?Q?uh0Tb4w0F6ghx4Cy4qu0VyIAu0upvYJo1CMGe4r/P3J0f4WZDtE8hLsYEChC?=
 =?us-ascii?Q?0EfCr0MXqK5sOYhVAc1e4d0AUrn6vTIpDyi85v9qjS0MmLeyb2Mu76b0nG2I?=
 =?us-ascii?Q?IrF0QaRYmrSsI8hhTvkQb60RYyZMBafopFaLOuwL3UKcbQGpEnT6H+r/8PHI?=
 =?us-ascii?Q?iOXno9lvIhe8l/MbegUEfzHBF/H15MCMuIg6YMvbZGh1sUfPzO5doebXc2L6?=
 =?us-ascii?Q?w+vj8mudWA89uTGeKcpyZN0tnfWEc1w7kxcOvquqXBMLhZnIQ4mcQpa9/d3e?=
 =?us-ascii?Q?xBLgQEzDXv1vu2kFQA/GNmlftsPNY3SLGwIED+eXWh4/K9qcemNUmmASULcG?=
 =?us-ascii?Q?qhnAxeDA0e92rxmedyWKF9BtEtaesAFDLnuGfXhkcQv1I7oprFTK+jygL6xw?=
 =?us-ascii?Q?1/UdknDyUWWnmkT/BUh3ZJErd8v4fL5kkq7CcU2B+GeJZt54IlIEILjodKig?=
 =?us-ascii?Q?YH4Vc/DIBq49+JmXFHBbj1w03rMflqdzernKHOBLoH+QzqR/UuhhxJvc0NL4?=
 =?us-ascii?Q?IdDOSJBdT4DEWbbAZ9QkxvwHITiT4K6FzGynyLBXllarZVL0U/aCDWg2vUSQ?=
 =?us-ascii?Q?FCkJ3cOLH9hDwIXM/x196Ur7IA3040jqQA88vmDbPMuMpOPzGjxGPAeTbzDv?=
 =?us-ascii?Q?FxvDdgnYBaiLcY+iqdZYZ8I=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d51990b-4af3-4aa7-5f6e-08dc078d88d0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:44.8509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b61VTH+xZBeRI6w8i9KP7nrJ/f0MoY2xzhvZ0hooyMIja5ADVQiSQOPVZr5MPxwD/UkDQmqCQqef7em+iFAYG3Vuu8TDdntYjzqBM1Yo/pQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7459
Received-SPF: pass client-ip=2a01:111:f400:fe0d::713;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

In parallels_check_duplicate() We use a bitmap for duplication detection.
This bitmap is not related to used_bmap field in BDRVParallelsState. Add
a comment about it to avoid confusion.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/parallels.c b/block/parallels.c
index 04c114f696..0ae06ec0b1 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -837,7 +837,10 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
     bool fixed = false;
 
     /*
-     * Create a bitmap of used clusters.
+     * Create a bitmap of used clusters. Please note that this bitmap is not
+     * related to used_bmap field in BDRVParallelsState and is created only for
+     * local usage.
+     *
      * If a bit is set, there is a BAT entry pointing to this cluster.
      * Loop through the BAT entries, check bits relevant to an entry offset.
      * If bit is set, this entry is duplicated. Otherwise set the bit.
-- 
2.40.1


