Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 594007B4E60
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 10:59:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEkv-0001bY-A9; Mon, 02 Oct 2023 04:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkj-0001SW-Dp; Mon, 02 Oct 2023 04:58:09 -0400
Received: from mail-vi1eur02on2070d.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::70d]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkh-0003Q6-Dr; Mon, 02 Oct 2023 04:58:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eV6RyW1X2QdlkrPAFNoHod9YjdJWXalSZBCOtK3zzcvKH61nNAY0ZtGsP+exTIqeuAjVIEcYu40d0L6lSXGDo59iUR+w4U/WyofnN7fbBQpx+YoLI9Gt1lPM8Uvnj+L2eDqbU/nsM1+jIIKsJENkAEnUfGQGKEavkHdFRSdsPEb1ECPIDCWe31eRBGxX5+zc3BPUmZ8DS9ZnRJ7uqbZIRcI6UcNkVzcVCWyZz5lY4GtrZCrXeXg+G5C3HdxLAAL71QyQkatCoYi8tR5Om/hJEV7+pNeSaTawDe5UmO9iCTxEwpOm/uARL+qu+Exo83z53L/jnXfuFkwQwVK22S6csQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rP2WfR5LznZQflbxF8b4NflbJ+cE2L2sIVhfBFf0B8s=;
 b=R+KByZPYvtcAE8nM8WmdJKSkRRZ/qPz3qDA/1k5UN5rHhdASsRucMVJu5g54b7f4UOeQQy1xa02a+850f2JIIILcyGnZ22N4IJxfmRKU4QUh2AOREb/8LhqW6ArurbDdFE7W94DvicZH+pmKQJRZQs/VPP7VMFbXDuqGBrK4+PjLQMGjnEwi7wTh3EgsRCGk35TFvmQ8L0YWGmPRJSVaTDgPl1f9Lvhp6e21Fxvlf8oC99Tpx6ex9OF47LO4coOeePeKSETmgmf873pOkBBeGUXe3JKWbcInbpU5wMHJ3cWJkTEgJ0ScQNXtks8dTRKzfvrMF7PqwttnAQvSh2wF0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rP2WfR5LznZQflbxF8b4NflbJ+cE2L2sIVhfBFf0B8s=;
 b=YVe2Uk3ujvk4RPIy5OM1gPImNumVVU7Ykk5BqMhb2IMoYeXCOLI0/QjKe36fPd4SS/PspwODThwkIq7Wc8Aj1eMaqbIt1E+S0SmHM9/K77YjNZ/667tuji3y5yA7j3kfwxuK5oNYnG3iGDPEpnIsoZWiATHZHIYaW0XAk8ItKyohDuKDzR7rnBmK/mhxVx0RTwtBbI8bH/VgjzjDh0shvnNAZTunb3fpTNzcjZq7GWKNlOnm0XoQ9Ra8hMBgsKDLLewgGemBS7DCL7x0uzYAeN61imPCnzn+B5SK1BCwOYchWotR0/2ZoVmSVNFQSKNBnUeJEQehspre6n/kitT4OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8273.eurprd08.prod.outlook.com (2603:10a6:20b:537::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 2 Oct
 2023 08:57:52 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 08:57:52 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 05/19] parallels: Recreate used bitmap in
 parallels_check_leak()
Date: Mon,  2 Oct 2023 10:57:24 +0200
Message-Id: <20231002085738.369684-6-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
References: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::45) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|AS8PR08MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 899d2dab-f845-4602-be88-08dbc325a82c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ErbZ/nx8ifZwPP/VRtj/QE3J3/EvHrVZcGlmM0h4e9L5Y+9cusAMwV/p9oWeFW+6DPg/0G3e/dN28Nt5KPnhlbgNb3XsgpNWL7ScSejReQoNicpsQmG/0k5Ui+i+Mwc08jWh6iJbVt57gI/jY3SguM/+pN8LN9twSLFgSHCrI902lLDy3YNh419Gt/GJAgro/2gVPN5aR4m7icmC5ZjCg7giwDR2aVjKW2q6hsoVS0Sg7bdlLR9x+7xhupLJp7Eao8jxMcQ3V/TUVJzVsI4ISVHvUbcEtTq5AJg3aSD1MYvU3fTSjNRqT2IJOn5r3NCE0HcFce0HiWFstzEpJ1btiRJpCgz8mooEcnRMycKJVGDZWYKR1xAZNqJ8chrdH8Gk2Jkv6UrW+bKyS4Gy/qkE7YLlR9XLOLRl7IY/6A2EIqirKsx1NMZEd2IJBvtTK7AFHikFjLjoaHMzbyg5HgF+UFtxz16rBsYOYWoWKf5w3yK2auDDv6SGxDJKHR/Ab++fXYkN1vQ021q3YUvPA+k4WGhbptoYcDc8LRRmiUnacpI3qBExj3g02AWTKSD+WAUTSlIsseiznYlKJL3cyfxbFu0o5KTPk1wY2jDhhE9VhQXdtJlSv0NAWXaGcqqvogAv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(39840400004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(1076003)(38100700002)(2616005)(26005)(6506007)(52116002)(6486002)(6512007)(38350700002)(86362001)(83380400001)(36756003)(6666004)(316002)(8936002)(4326008)(8676002)(6916009)(41300700001)(66476007)(66556008)(66946007)(44832011)(4744005)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5er8JfwUMEXeNQHVNXMaJMu3/Qw6fsBNJGw93Ote31NOrSzai8CgUoTM6+yY?=
 =?us-ascii?Q?MBRLPUJZ9DsWCM/npm57gv1H46uHbcUhkiCmgDi3YM7MXX+5bdCPEizfSEyh?=
 =?us-ascii?Q?4CUaRoeu8T16gfivJETIzOzCNYbMbX52F6c64ogi7Vks4/hPN+QL0g9QPtUz?=
 =?us-ascii?Q?3WV4bOTOtP3SuBlguc8fKbBPPxnqGhtsW6NgnpxfJq1POhRSIy1tYyiQNxho?=
 =?us-ascii?Q?EjXC8bWrf6oPSAwBwUv5o9DyKsSG9ohMooMoefuv6QTSgJSGCr6ETeEgBbJf?=
 =?us-ascii?Q?oUmImQVSjoPF9GwdfMIylzllMICEZAfXyE5qFvnts/dLp/OEfDihT3yt/AGr?=
 =?us-ascii?Q?wAyaDoFVSxqGJt06ObdJzW+LYOATNXc5XWlqBXGLznDl7HO1cRjwGs98nF6i?=
 =?us-ascii?Q?4CCzAkvh+tjAqKpgx+uafjIibvHhaQcnu5iYtaST0hRJyJomfXti9B9F9B0E?=
 =?us-ascii?Q?bTPj3qkkiYFwjaSJjcYCieUapgB+fk0E8eRoLFliW73VOurfZqEAE3llUt/Y?=
 =?us-ascii?Q?IPVKc0HCfxv7jzSj6Pn5iGhbd15ucm3o8NKFUWzK1YqEbDWvv7/Bb43+nM2b?=
 =?us-ascii?Q?21PoeZ3My4f/h//jSQ/HPA1E1F4bPD0uZF7wguY3vOGPMLrCNDdbVMcbGkF0?=
 =?us-ascii?Q?lueJoJElvIKBvPuK7Wmapy3mWZt7Ur+5gSht28TnEUBm8oq1e0LkOGNrval6?=
 =?us-ascii?Q?RQFvXhT1ZMScWdRzMTDGWWVhOol34G8T8iQ9B9q9OajgoTaF39pGbAGcbA+0?=
 =?us-ascii?Q?GtrGiXPmJjp7deyR8/g6TxaRfq4MLx3Whd6pOMwOCkUYOnJ0zvpI3KO7r8N+?=
 =?us-ascii?Q?QBTiX+7GShMhxlc6bPc4f47SZVAazFqqpPQ3dmtSUJr1nD+wWcM4OTWB/ha7?=
 =?us-ascii?Q?TvgLAkmX6cMJzw+2gIiAYd7nj8PS3MitIJkyiZ50o2sA9go70nDkHyj2uvyV?=
 =?us-ascii?Q?dcQtUssr8n3sHC82R2b0Kim9w/PVrlrPiAzpIyVW4ntXLUMsiBh+gxjmOeut?=
 =?us-ascii?Q?J4QX4YGA+tclo2nxyR7kLb4TrGgcNGzOn+Dg0lUk2Ac6vX+lFvSAIaIWj7jT?=
 =?us-ascii?Q?QVm1EndvEUW34dBxoGq5+iy0Ns7X0JWbanNJ+e/5Xm+1sLAuTBlhYniMeif4?=
 =?us-ascii?Q?jBJezNxtBRjb6O3Mb0ZewiyUYy34h6PfZlXwMxpSbHN2sW6bLtR51HKhEkys?=
 =?us-ascii?Q?O5BK2dBWDmEsGMZHkecsUvY7pt4ncbkrP8j71DPVGlTBWPDrg5yoryKAx+MD?=
 =?us-ascii?Q?mIFUrn/qc+FD5PpxtOJCSe2df8fziROmAIdwCpBF2XHIXxlXH6bciiT8asAh?=
 =?us-ascii?Q?Z1Al+verYOoNB5qp933k+DNoDwcGBIHMnqpqb3XPndsOpyAiX8gYd/LHN+g3?=
 =?us-ascii?Q?UfNLYjXrBQ4ifMC+apqpKBYa11VDVUxA+BXgNnXb1mLimOCyXekSGD8sy1zz?=
 =?us-ascii?Q?qvhS551In4B/h6YAwHQm1hFlHF6mOIb5oHZ4L0mtN3lcE95Ywg0Tzq8Ls5qU?=
 =?us-ascii?Q?SZ+HuXNYj8B9BUbgT5jTYtTCBqptEEiv87F6TokAhgFgTJ1ad9vCbHhCMYi1?=
 =?us-ascii?Q?QDu71au8bARJl7DrcMU4i/ck9WA0RbE8TdW5/7AGX4PcuKTgmlo1gcVKUcWy?=
 =?us-ascii?Q?n1TCNOCQ9pGgJ0UfdU+AA2k=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899d2dab-f845-4602-be88-08dbc325a82c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:57:50.8078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZTWo0ylS6c9qMUv4h6gEKVQp2xK+qkR/gy6ZNNS2dJ1KK37le6f/tMXP9h4Z3440pe8owvRopSkKjrT6CPzT3eIyJKJlXJZ6W15usnBhGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8273
Received-SPF: pass client-ip=2a01:111:f400:fe16::70d;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
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

In parallels_check_leak() file can be truncated. In this case the used
bitmap would not comply to the file. Recreate the bitmap after file
truncation.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index e8d6d30fa5..1a4f8d1eb2 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -804,6 +804,14 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                 return ret;
             }
             s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
+
+            parallels_free_used_bitmap(bs);
+            ret = parallels_fill_used_bitmap(bs);
+            if (ret == -ENOMEM) {
+                res->check_errors++;
+                return ret;
+            }
+
             if (explicit) {
                 res->leaks_fixed += count;
             }
-- 
2.34.1


