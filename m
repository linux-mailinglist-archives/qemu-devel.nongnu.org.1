Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C767CFA6F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:10:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtScV-0005ll-Kf; Thu, 19 Oct 2023 08:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScR-0005k8-OA; Thu, 19 Oct 2023 08:59:19 -0400
Received: from mail-vi1eur04on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::703]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScQ-0002f3-2F; Thu, 19 Oct 2023 08:59:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlpRPM2vpwnI1v5jvKkC+uhgRZjt/BenYlbAy9SZX47H8pnblmnXVLEDqVKT3xnh5lfkPpUL6M8OGdENHetgoJwEc2m1oyQyXcd2KXBo8t9khPYdpAva9HK2pIqD6F8VNEpxbcuwAxqfppXLXL5cZxWB8WDWk/xr4UdmJLnT/U6XexfbjkLmw9j+d19DDx/PJq4ls/9OhvmZivh7l3NCmBNOfiVrZCr3nhWECQTujaQopNEZwDxFw4XWG+BSCj258vMK6hasinwCkV2Ta5JA5VQeq4YWm8mrztNvJAYoUAhe9+S5vxjzS+6mDTewisetL8+ljaY0UkTAU/iCe7qhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcgepgWnCdHnhMgOTwm0Ko6SgRB62LnSc/g+1ZQ7t1Y=;
 b=FIXkGq170FUJ/D4CF3BnbeN1ihp7RiRHRUJx/WlmsmrFFC8EzWv8Pd4BtTiXM9SIL4N5KZxDGycojDMFX9GhOLyuM7D5dXhdKdhXGD/HRDpbaqSb8KC024i3/zDguPe8qL2yZ9711yBCg0ebLRHbi0fyAxsLqU98kRIdrs4DOpZhzNNIErRdNCdhDi8Tzt1WZP/dqTOvGC1B7uFIaHXIlpOJqlbT5vB+T5V5lI/z05N6kQHM7Tm09MZ0kfg6pAAU7A6ZxuVI+5+VWuKF/E7d8BJerIHE7rzMobZ60sCUziRTnV6S3bjqRfEMTxAjZk17vRRnjaZNbk1ExaGR/cHZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcgepgWnCdHnhMgOTwm0Ko6SgRB62LnSc/g+1ZQ7t1Y=;
 b=VjE4qoVksIdQGEzkwFtVXmvgvfnXab7nlgFx2TBwoNBNEwEJKuaRINy2xHZw+/4B6orcr44zA350NVlDR4y9YRmLiah+AZlH16NjDZuwLwAEm5nPc+exeFe4/dkzkGe/MQNyfomwXcqWJqVx1oW56pqT0CAoFrnmfOPwkMi6h7FKgFPys2kRVyQ0QCqNS85tHNKyBwx/7Nlw/GJ/iiadSrzfPhUODjut1hgZcz65MqAoc4tFYL2VSqBJcpdJ5mrV+BVg8sG+I4Sac2kgyq8gxZronc1ALB77bxbcbaLtaoGCD4i6kWSnm500OF4rPggWq6b+uq/gE02avoK7dosPLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by DBBPR08MB10554.eurprd08.prod.outlook.com (2603:10a6:10:52d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 12:59:09 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:09 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 07/20] parallels: Add a note about used bitmap in
 parallels_check_duplicate()
Date: Thu, 19 Oct 2023 14:58:41 +0200
Message-Id: <20231019125854.390385-8-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7d1199d8-c45c-4d0d-03a5-08dbd0a32f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WbXPB/xx1ZPi5FxxKYZuPTwXOVJMxivTXE8bNEe0LQQALir+zIUIWikkE36h2NF1NWo44ILM6nLV96Ht3QUL5uj5ApUuZ3ojmesCDGLiqdH9WkchnrVXX9P0KsmSzVgEdF3sx9Yj6O3AxXs+5pAGB4TXcu0zxBteUwx/R/2MpG/2HS6YD8eTTZ6J1MtbeaySyJuEqy0kcrzdB/Gs9hqOLowS+H2tcusucIWFFKgsnfGQrPj/P6CJBQnizE8lAYC751rdPGLMMCGpajSouKJRarKdbj/zL3aBebLBHCj1jbPnEi7G8MHXcAT+42dhZTytIge7O5LJUtLrSPvED7VYLAGS5NpktQuD9iNfNzdq7GuG61ZED9+ZSd590pYWhWgC8lH6TwaxBvjdR+yKxEzcAp1BHfHUXSuO8kLGbickslhcns92pDmLeUmzxFaXpzLSJI5L9Bw9xzp12i2VG5Wx3Sv0tCNfrSpO/70ZUav9LJkj0eFog0+Fwy+Nhmbwo3RfozrAB9RxaD5Hd1+gYz1DEuwzhCS63UrE7OfGLUAlB/QvOkUaWeGiUjXcW9UCLkxhH/tov49QyRU7KrK0zy5xGDcPqX/gasJDn4ktDdnpwpkgc1kZsir/ION0VedTjYeW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38350700005)(38100700002)(5660300002)(83380400001)(44832011)(41300700001)(86362001)(8676002)(4326008)(66946007)(8936002)(316002)(1076003)(6916009)(66476007)(66556008)(6486002)(6666004)(6506007)(478600001)(52116002)(2906002)(2616005)(6512007)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VYUVo4s8GJYEorLj1cpRqksBdBwz3NaQYUcAAqLklznj5VXuXdSR+ybKJPzH?=
 =?us-ascii?Q?JEN98U4zfaJzrC4RnZWMiYiPuJGPS98d55XUpFIaO4DoNk94KYCSyKdALvbW?=
 =?us-ascii?Q?MTNohxKp7kWYS221XvsBi7AlECh5mKZSH9W2QEYvbIz2H8ssc9FWxGQ9NuoM?=
 =?us-ascii?Q?202Buw9GLB5Afx63FqhXZ+p4Do4CSdfV9zQZKyFw69qheIq68f65z7wVZ9/O?=
 =?us-ascii?Q?5P5JUvAyWYIDre1ZmjEbr2pt85Ip89QegeQHRJVS4CVcRSLgZIupn6RAuT8S?=
 =?us-ascii?Q?rUiFyGJ9f+Y+wVHwK97EJE6NlZqrMpLJVZ0vgGaX8IfGAHSJuhfLZXaScF8c?=
 =?us-ascii?Q?3F9HLR1EFZMaP84MCDQP/N8nc2Ci11bhhlO8L1c7IbczuwAiVx6bLoVcR639?=
 =?us-ascii?Q?uYqcvHJj+/JGXkfGhTWZlBOJtdzWxL67BxWfAVWAhxgvOVMZzmkL56S4aIE9?=
 =?us-ascii?Q?4CfaySxeZkEXy3QgWQYflT6SXmEU5I2uX8HRAePJSuzKgQWbdt6esJVFdzQG?=
 =?us-ascii?Q?yoxYcZfH3W1aBRpxeoTXCkIAptiR/li2SGmyt6aP3wIwgIB/8MgzoJbuG1D+?=
 =?us-ascii?Q?ziIzZKmIPoPca82Seu7Uyd7tMsS/jQeS/g/shMMHhOrEC2GbjSXsOVXM+Wnw?=
 =?us-ascii?Q?Vg/Hz0FGx61sS+OB2+eAKtm4CI/Rv1aEeVLiCGnSYiUpP1kGFxfM2pOvGcSm?=
 =?us-ascii?Q?6XJCETaLtG4k06kgX2ASkX2RDRqj7QKFQhRfLQifP4XV9fJr0sHk3w7szfab?=
 =?us-ascii?Q?PV24CidY4Fi+g1DPIIAOYwksMIRFILvAd29Ban5QdWhPIA/zXbMqIowdMn5X?=
 =?us-ascii?Q?FpHHkmWH/YmEOJbGa9eHejW/f9TTTXFMairxJhqGR4abm43FHcEwvyKS/wpW?=
 =?us-ascii?Q?KZGuucWtZfrcQ7ZG2LGUWVNSU4TFqg1xKUX5Aqt3MGQ18+1LDXZK/ul32/x2?=
 =?us-ascii?Q?WpeEZklNgHYfAGRoy8LZtL6D0LAIU0K8TRCsZnFMyZr9PGBh8A9vHEuVZepn?=
 =?us-ascii?Q?bGVutxwthTiBC6IKjZeAI3T4BFoOcZb2/PkUhiufQOKtpJ6wUXqwWEHrbaIh?=
 =?us-ascii?Q?4Xjg+qkmpma08jGhSD7Q+PgiCbU3dl31dWrRe+f1QxBT3KfvwF6MpkwCQhEt?=
 =?us-ascii?Q?3i89FufwNFbgiXb3acW+Q6xcpkr6c+VIkR53nXfNhT2S0509LNPDgU4gmPMy?=
 =?us-ascii?Q?aHiBmGHTZeDOWvE/6dcgGE1Xf451OCM9U0RwolsNTRdGhOh4j/rCY+DgMj1t?=
 =?us-ascii?Q?EsR51rBP9ul7xiolb+uN1j45np/PpMAnqhgOmQ/Yxddx4m/CPH76qfv/ab+v?=
 =?us-ascii?Q?hJN2eViJzQDWp9ZUK4ufoChKbPpiUMcV3OLIjCEXBnnp6s5qZPFlIiEP+1c3?=
 =?us-ascii?Q?yNUnV3Snoxy0W6sot5OzXbnVkpedEm4+bxMhRKTzmFxmStfGNNZ7F6M4WG3R?=
 =?us-ascii?Q?OAIMi+hXiOocQuUaX4NyAe8lEGGgmDDcsri5SG7YGJ3WfnMx7tVXSfw00nPS?=
 =?us-ascii?Q?kN+3E06EsGveqUyERnQty9ong1B6paqwUIhtQI9T790d5WT2Nacqmh2/2tWB?=
 =?us-ascii?Q?LA7IXsV5t/QisTufFa5BNV+xHRjT51jH7YafH1syj92mdU0FET2YlEGtGsW/?=
 =?us-ascii?Q?+uUnWKafd9JLEPdRkRfQ0mA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1199d8-c45c-4d0d-03a5-08dbd0a32f3f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:09.6101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmgUC89kX1/vKDxlcM50I9bQjKzmkp1dEAghSoVIKYaC/5C0MI/Amy2SkXcojq2BmCZTQm//U/7/pGSfeXsuSFAWWAB4AoMUSAOTWUCQgAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10554
Received-SPF: pass client-ip=2a01:111:f400:fe0e::703;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
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

In parallels_check_duplicate() We use a bitmap for duplication detection.
This bitmap is not related to used_bmap field in BDRVParallelsState. Add
a comment about it to avoid confusion.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/parallels.c b/block/parallels.c
index dad2bf67cf..dd8ec925f3 100644
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
2.34.1


