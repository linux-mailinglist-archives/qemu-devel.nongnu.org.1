Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0628F7D9045
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:49:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZc-00006a-N0; Fri, 27 Oct 2023 03:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYm-0007ER-63; Fri, 27 Oct 2023 03:47:21 -0400
Received: from mail-db5eur02on20701.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::701]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYf-0003ya-2M; Fri, 27 Oct 2023 03:47:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mE4wsPfrCVWiaZfObYTnGlVSQimnB2Z+htV9ojMhcXe18YqJMvEQyhxiaJL+a+E7SLh217ebAsY1GjQLFlESDEnhBozrssOdoxEki82LN2k6VPj5p41vuFMyH++xVA0HegET5IgGWU/a43rAb8p/H9PEwajnL+dqy4sPqJHy41ilh40SdcJXNcHBAxx7JNIi2aZk97RjVMcq+P4DDmI41vgeJ7bXzPYiNwJYKWb2VSkiXndGUmhPYq0eNHPJFeiYNwM4jh3qm004pUWlMC5XvNT2IIIFUQYuhVaDexT/JCUyz7tJUt+6flMZEtAP2oD4PXiAtwEMmbYgfkoAxAcDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfC5f5aaTOH8AnC560aZJtAvpUwVT8OctGCaLGlsUng=;
 b=CV96BCvqaEUFcTwHdAh7L9dDJSxi+grCUEAcc8RvhHUQqvYJ90drIvRofXLzFjaMlLbFRWbEV16JR8mQYoVxfkanYNGXQPeP4hWJ1O+Rn/qg9x8JKJZjStlN5VvkzuhtVydU9BxON126a+MXE7QBuJgTS+DChLd+rGeDctGRrzZk986OXV2Zf5vVgQlbIxmqefu8zoHBRnIaB0TSoeqZFuEwH/VonRCbaHjzTCSXsfDPy0Yf79JdsEWedy7AXI/6cwp2akStXBou/oGz3VPD6ULnyxbmvsM4gUDPLNta4cnKggyitBVe2RVtXphEGHKGx9A79EZSgv5Xxux+mPHfMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfC5f5aaTOH8AnC560aZJtAvpUwVT8OctGCaLGlsUng=;
 b=fHBhNxc5TXrS54Bawg9S77NexRa1/82/2FmzTgu41kmAKhN3+4G79j2JQQEqoiH6QIjdXabZv+SyknlSqFYSfWG1X8PhK5ctCV5WfJa517pPtTPZd8rM4DGabbPccZJrO4+cXsKtwrvK95pWLuzU1WqeOZha7BNWWFhxkKXAptHDrMjGV6UHVm0OCxEwsnKZFsvYh/7fV9pQoKpl2y9vZ8zZmhfDGVUYFzTaITUqXi61wnF34cAiRfyTaxAPE6/x8ULhYIre6P3sUILyRQPQNwuq06YhQpnNl4cmE/e3Ib/KqRpZXvY/QR1/xp5bi43N3nEQfIe/hsfxDRVEFfY0/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB4PR08MB8056.eurprd08.prod.outlook.com
 (2603:10a6:10:387::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 07:46:47 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:46:47 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 08/21] parallels: Add a note about used bitmap in
 parallels_check_duplicate()
Date: Fri, 27 Oct 2023 09:46:23 +0200
Message-Id: <20231027074636.430139-9-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
References: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0101.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::30) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DB4PR08MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: e1664f87-df99-4093-34bb-08dbd6c0de94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XV2sYahfJ/G+H0xlkm7fXOnpjWMqHFy53DDCIULt/4MlP9dxDDWin6JVsfzK68gwZnXjDDn1UJDHP9shI2cP2pOL3Rs6Y7OWfIxYlb9YcYqSmlw7dIRHpJ5XPWSauAk4jO/ASQzIbPv0spZmMXo9SfDjf5bgfOiysaxgeelaXVEGIHGRvHfSzLUuMe1Q7c9oDEztV6BY4QyLUnu45MD82Q2Xbzrf+EPiTchoUY7gODZi+GjiBz68/klV3JT5ZvfaKxUFos4Fk3WLpzSti8HN1HHVLazSa+1XGus6NqDjvek7mJwlZw+mV+zsX1OT43e93RqyyRdCqYeneZrG6QOLGOWxuPtyviH05eey7weHEgLlbFr3nTiIqLflR5vLPye13uvYMZKUg8vrWWNdE1dP0+3fQ8NR0ieRDNfTRWsMZt4UNeezSCPua5Dz3+Q6rdM1mphgtNG3ICAEOLxiSd9F9AKxuhe7pOJNmsQ5PADcmRPSqHXdWQQfAzqxSWb6D/4Hmxf3d3cI3aYCH8rwH7iOax4Za1ofQyHfgCHE+UmkdAsT5Iw3tTp8gbJpNxolim0huLJDPs2HTTEIcwG69seUSOBXZAq5EjLA0Y0uAXow94gcVmvQn06mMhLN4jPEiCkp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(6512007)(6666004)(52116002)(6486002)(6506007)(478600001)(38100700002)(86362001)(36756003)(2906002)(66556008)(2616005)(26005)(1076003)(4326008)(8936002)(316002)(66946007)(6916009)(44832011)(5660300002)(66476007)(41300700001)(8676002)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ob5ANLDi7qYWvLsjKHVHqomFMaCLTagOkO0yNIin8ApGoLtlAHnpOlIiqbg5?=
 =?us-ascii?Q?8Cw0qpxpUJlwj0UOmcLrGGuiB4erlw2jR0iJufWisKNJ5ffGzftmoJcBvY/V?=
 =?us-ascii?Q?yZIJyiQGkzKoEkxqr5NzJrtO3q/qV2zmvv8fD5H7ewxX5CghpE/hMNmk+Maf?=
 =?us-ascii?Q?5OZoiBLNXmkpsXeuV+wP/YN3NgFK8UD9wS6fZoEV3WpuDtQJ2Dv99HsrVL9o?=
 =?us-ascii?Q?jDZ9UUrHIyympEJ/iY8JnTR1cRkNZAjkodhuX+K3xlu0HuSW3hsMucvcCI+K?=
 =?us-ascii?Q?LrnvbsHWlBMR4BJndjN32li8E98JtmvLfUMqQeW5UH3wYMsdR+DeH/RoPHN5?=
 =?us-ascii?Q?+YKATBrw+msOlilxBCaaw5U0sVZX/8GjIoVXdg1LXYxHGFrs9N9D8gccCFEc?=
 =?us-ascii?Q?EGIZLqAf2Z7Vvogtm0M8cdoR1g9rBMpRrrxQmexamBmVmPHYzM38E3P6W68F?=
 =?us-ascii?Q?kL4BykXSTwhVT9SvQKw1uyi8OuGf8RdWTFVdAKY3Ea0ypkhVEpK/ITwudP13?=
 =?us-ascii?Q?UqxAr0WHCq2oLMLWHnabxx7miAxOxciWsjY/biyl9kOV1L0mpzgJ1s07QcH1?=
 =?us-ascii?Q?rm/2mLlOczzk2hZ/WOcKCjC6ZPf3LnXL22C8Futdh41Yae7o+7XL72pkh6Ol?=
 =?us-ascii?Q?QN5teU4HYoE1me9+aQdKKqKXH2EvFTd2NcAocz/IX+4AIs5gTxsjK76/OCxZ?=
 =?us-ascii?Q?FTJfqwFOUH+dTIDxGw60q2YVRgR3/hGCRvSTFuQwioECGipPUcLXehd+mHTp?=
 =?us-ascii?Q?1uUddC5Jtm3T6HkhgxIgL0U0L8lckp9YhdA0IQnAaK735F1/zx2jruh1NxAQ?=
 =?us-ascii?Q?NM3p2UHnaXomzg8eI5eswdhklBUzBgyzPRwz+E0+Vwcz3nWoveKl6nSlH2Ro?=
 =?us-ascii?Q?B2ikNPqtN5Jypn976tnpXqZsODvxKXRvy5BFcKiRR4MvZJxokRwne/KG202o?=
 =?us-ascii?Q?A5bSkG8JwZ55AOinylM/ItCoovF/a4b83NIlAU/Bw/QhTF5JQo9ab8GyUP2B?=
 =?us-ascii?Q?FdpJ6IoJgxS8KmynkPNi46AvIhjkEMsNzXSUc0gbXpz7TcKVHsxE6lUmSBXb?=
 =?us-ascii?Q?aU8MznlfZe6lYEwY+DgRswf51/8waizOYDvo+ROxweHkGF+vWycWqZLtUtx4?=
 =?us-ascii?Q?iqQEUSg8BW0wJjqZit16gxJ7nLuY6oiJsOJFjDqaaNmcCl0u1DPyHqKdbhPS?=
 =?us-ascii?Q?lGhCJAoqrSj3lm3OTYHMKRpCVWe2gETLsgIhM6LpWOqfjinefYIk9nvJR96x?=
 =?us-ascii?Q?nAo7x4vVSwoMeMKcgNPExwOBDE3Y0w90deeVPSeXD43xny++VlSgh3h1ZCR/?=
 =?us-ascii?Q?2Atg5xz++E8L0Buj5cIVnHBY6UG5zmv8ZlQS9VZIlyy8OaHSYqvRFJ34zpm2?=
 =?us-ascii?Q?mHTGz3AT6+fiGCNiEDF0vzaRD7bsj7oW6O1nPhVkUy51z/hT2Gp5/S9ylwkC?=
 =?us-ascii?Q?OZ9dOjTj6FaV0mU8d4o9sTKI1vsHPqtXwiMv0dlBzqi7gkvfjxdXLznu19IE?=
 =?us-ascii?Q?w88N5HrKuuplnAgGT9xMLrZZwVmhUIZ7rnvT9u6MYnihzKWHIgPOKBKNhwSz?=
 =?us-ascii?Q?XCgwepJn5g4BMMYJuyATIBp0YpKG0cQqpEz8RCaQPMSDfHz2ylfD9yJgbHEi?=
 =?us-ascii?Q?q8ISPaTPSgYlpsbGbly8qYE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1664f87-df99-4093-34bb-08dbd6c0de94
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:46.0519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/sSPwYzRwTj9MNcl261eolkdkJcJqiZ+NumYzQ97MImynGuz+dKx259BwDLm1HMnBIKf6/cxssIGEBG0wnOFrToCovq1ewvqCXF+PeaAq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056
Received-SPF: pass client-ip=2a01:111:f400:fe12::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
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
index 2ce3e40ce3..481b6992f4 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -839,7 +839,10 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
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


