Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0587A7CFA58
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:05:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtScQ-0005i4-7j; Thu, 19 Oct 2023 08:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScM-0005gT-AP; Thu, 19 Oct 2023 08:59:14 -0400
Received: from mail-vi1eur05on20717.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::717]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScK-0002ew-Pj; Thu, 19 Oct 2023 08:59:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJI2jEnoYoWiuG79dZ7/gCU6wQbEytF8OAP3XKRkqQzf/NIdmN5ZbVt3yw75fZCLEFDJdwOL6bf7oWx4/n1ehBRCzXY5tz3d62xAnIVpiPaKt4vKNAjy/fklOVowTR6J2AnPp/8LrcvRBc/n5w5j8ONAzrMCjehfslQc1Foee8hWzX5gK/fptBUR5bE3tu3XZ9IHUGXRwI6rL4sMc4wo7fDz2FdNfvwWxOCG2tWCnNiDz/QhQmpLwhI9aF1ZUN8v09HjEFKnIt45ZbmCkY5UTJJojJreeGX9IorZnjmGNy2ij8eZYMnM6SKQUPKeBFTX1MleVcShvBNmpSBpQyRbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdxpCNCExdXIlG04uu3xZW928uMbN8sgV7wRopaQH2w=;
 b=kgs89uJ4RfmA3xLoPkHnmtf55w//ya1BEFiDCvPVj7Httbu+RiDJsTpkUqNgYdcey3XTcfE0GmJqGfcImiiWvsHMgoBbAtZmcqkiUkCn5GxdqRTgVgAO7vFKJejgl3xVfA8PwgV38ZrpGWnQQqNeLmge/I1HTjqAwin0gF1QhSjitdWTAAG2u6wCAO3H3d0dvF15ibMxZ7OLliY7U7dw0jW1Vjhj55vjzB/kgXdOxjqWMpxDZawheS+ahXo5TXCKtyYXV5+dEJOTQ3Y8p/GdnJJu2S5vxrqYPYUS1CgzF19r7PJZmDhoRWmYf8TCSYot18NbVQ/ik8ztCObZH4JIlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdxpCNCExdXIlG04uu3xZW928uMbN8sgV7wRopaQH2w=;
 b=qpFts582Vt9cYvlqSSCXCkgqkG3VodJ4i5oJGhrtiuT3yfvslG8i+ZS/aR1nJitqM6e62gDfN9nJOPGSe1zKcq8sRFRlr2meVp8DC7W7btX0BPQfeRmw0eofWnCY7n2E4fUskh3qUlJ5haC4mIioJd0u5W3kHyalIj3POL1YEIvjB+FbPVca1OvzHO+NJU0oyEQ8dqRJ7RsQzu3c2XRS2ARq0hVefD5s9KGOBZGTKm9onmCNKmQnONXWhFTIIAMAshgYkjuOFncmy1t09wyD65ZzLbdPPKWmXx293OExNsv1BunHpU+RiylRf6wUjxITJOZV5JDV0Lu0EjBPcTAAUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS4PR08MB7997.eurprd08.prod.outlook.com (2603:10a6:20b:580::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 12:59:04 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:04 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 01/20] parallels: Set s->used_bmap to NULL in
 parallels_free_used_bitmap()
Date: Thu, 19 Oct 2023 14:58:35 +0200
Message-Id: <20231019125854.390385-2-alexander.ivanov@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|AS4PR08MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a3a482-e9d6-4110-d6b6-08dbd0a32bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TH+PBP9Sx8D7oqF5qjkrhSNvv0KnSJbiup88IUcgfY+a10FAcDxxPYMte6falMiw/UYCVZH7T/yD9YMpK/FYUI8IBti7TnoP1UAJR4CLM/nW++cUataWH5HdZta+BBXBJUdRcmAY1JFWonCtlmx8HtLW3r70FS1Totiz1FpMcUJR4ekZkGl9Xa7gOq9NOboqzPCSwnflscCmTYWsm/w35ginpBVqHHWlwOZ2USdRS2pyF09AfO+t+/0CB0jg55iZmOKmoEy54PaMC26w/PZQHw1ZTjnE5q3xmVBrEjskyc+9ObqmubA1BW0B8I34NBDZtFgY/jxtsM0GCHtaOYWPDftEtxqau840RLb+csEqleBGghRPA3rids71rsig9F5vNp3+/sD3/+JvSqnp0bSEaX6KI1S1OruMmtKjWriKJRQdjlU6Cj8Emaug0mykQJsmjWvPMoOUiuSnSF+QLN26UaKRBx9nC9dHZ8I07Y62N+hVEUEOTzPGSi6KDjRWxBYALiQO/Fv9Ii/KM0bhYhuSI42lX95P5IJIoAXLgdbFS4ACPHlH5/atJiXTIfgnGY7FFUJu1oiWtLaoMJhiASm9i7DFd/jlHDDPbQiynbf9Cfrkykc6LriVUXvGOy5kHgXx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(2906002)(4744005)(8936002)(52116002)(66476007)(6916009)(66946007)(41300700001)(316002)(86362001)(6512007)(66556008)(478600001)(6666004)(6486002)(6506007)(44832011)(8676002)(36756003)(4326008)(2616005)(1076003)(38100700002)(5660300002)(26005)(83380400001)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lbDx6O6nECOvOH2EFYLhUiU62V42YFtcotFfU5I0nxArIoE3n/5A0DwMoNNA?=
 =?us-ascii?Q?t3z2ghV8MdkaJHF15v3xuOUG9kgQSPnT7DdOhviYJGporaq8AGrl8POtFpUn?=
 =?us-ascii?Q?s1wmljo7f/pfiMdw6H2X6cbnHeJEf8EWWCAhBMAPW0ec30XUeCfKoBUhvlyF?=
 =?us-ascii?Q?htuioBDNkIp6hurFzOdNSlRo7q/Nwe/qvMe41RBy+X7ZYhwmB6Ap6YspvdJ7?=
 =?us-ascii?Q?ssfDyxO0mOntsy+PMZnGTHNDEMHS7Mn6qnzfmWms8SGeYOw9mcnASM5NX4Gd?=
 =?us-ascii?Q?h2FnXdZ60U8Vh7Web0eNlnQ5Ig45RuTxzofBe/FyKywXckN/2B9xZyMedDmH?=
 =?us-ascii?Q?k6gmh+bJRIVZiISGSGQzUVQklTKw2kPwghDGzFX3n8RE+dr+rRjn9Vm1G7Do?=
 =?us-ascii?Q?Im18dqJhebCCdsDtMR8/xt3ehJ+ixbOxCZpRh5ncfgHPuxwwrdDhBExqUwVQ?=
 =?us-ascii?Q?GgoBKz7kW7zWvSpJyffw73hDNGZmJMJ6kP6iinOB7VGQperfSTYA4ROw03xo?=
 =?us-ascii?Q?uS9ISY8qEriMCfntmgfEhD/WKE1byJUblALE/rB5PVumxGnNxLL0xhuj2r6T?=
 =?us-ascii?Q?tMugCMstIHksE0kMdpzA8xZh/hTREqRuGhavIa033bjz3HAmDnKTKfMo6XNe?=
 =?us-ascii?Q?xC97GKEkulEJNgsqY81iPN6j4EoAidQARswTm+2pQWUroVPGZCs6JlPFzivi?=
 =?us-ascii?Q?X70WCVL4MhCmbTlnOMLdy3RJynjxomG3HO3c6rN8PnvljN/mERVefGN95grS?=
 =?us-ascii?Q?uzpONvr/bpo3BdYZsRN6c1i8QCnvC0qn8uFlsMG+SuTN152aZVGDchz7LWka?=
 =?us-ascii?Q?RyJTRgYUrTS+x1v0RMb1YRvtcE/9O3s4HGuGQMjpOhmZZwrhdHsqPqs/QLZm?=
 =?us-ascii?Q?cUaxh0TT1kMqjLqzJGtFmSrumljrPmUI9GHpXd9h2y/hmMvJ4jZTCALZiYK0?=
 =?us-ascii?Q?T7PIEbBL5U0Mg3MZxi3OV1dtS4I1BaphoDd3/4FQ864ak8OLohJD/Q4coPwq?=
 =?us-ascii?Q?6sX+BADzDc73s9DYYWuPye/msiA+JhxlpQ6FFiJblZdcfvjt9j2rDtFPRfW/?=
 =?us-ascii?Q?50E30JZtpJiJfeqz9HcUxu35sjcWEr+qZxv0CxgXHMZ5rUVIOK4Zq9rH1y+P?=
 =?us-ascii?Q?xBOC8QismysFIOaeraUKvaeApvlhVsoSZQ+FuR85iQuxgiRtxBxP+GsFbiez?=
 =?us-ascii?Q?a7iCGmv3qyHuCv/TIo20hskmAb0un7UPbtrcTzcWaTP8qsf4dZMis8ZrkIvC?=
 =?us-ascii?Q?8Ii++tWISwPj5+y/U+851bII/dpgfaQyjiG1EJZPYGe39IumxecQ/u+iCXYo?=
 =?us-ascii?Q?H2mS7VMMniqgblsSrqPZpzIZ36vI/UCSzfk4AEgnqoOdBBVh1p8N3zx/5Bwf?=
 =?us-ascii?Q?MkXx4B9NDzrnjRnLuaNS4Y5duy1iaks+WHqFEq4+Ms5FSUASVGAR3LoaIyIB?=
 =?us-ascii?Q?Ol+kFVT/V83SsTktXov7Gta+uZcb9fhoAiie4wMqVgn3Bp7BhRMdWSHjFgbF?=
 =?us-ascii?Q?U2h6z+GpU5ZwJQWIP0cu8DRthFbPkGo5VgoC6nqYlNYT695T+z2+PRFfIrbG?=
 =?us-ascii?Q?kGn1EyOKPPAaixug4E64JqPBewT1G6mAEeJO6FizLy5HgN3o6ja5ZWdxrqdc?=
 =?us-ascii?Q?R90675vXSXqES8lY0rw4mZE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a3a482-e9d6-4110-d6b6-08dbd0a32bf7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:04.1335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ka3KxhXNX761ucsDi8j/hh5OO/2rHUr6UG2/N8OAgd+zcP0eepDt8JMn29pXehwqPU0ZI8oX5eo92BR+t/OgVAxNlvmwD3MiUXDuCGdagQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7997
Received-SPF: pass client-ip=2a01:111:f400:7d00::717;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

After used bitmap freeng s->used_bmap points to the freed memory. If we try
to free used bitmap one more time it leads to double free error.

Set s->used_bmap to NULL to exclude double free error.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels.c b/block/parallels.c
index 6b46623241..ba1fdde259 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -244,6 +244,7 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
     s->used_bmap_size = 0;
+    s->used_bmap = NULL;
     g_free(s->used_bmap);
 }
 
-- 
2.34.1


