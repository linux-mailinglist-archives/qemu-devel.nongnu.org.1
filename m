Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 937BF744863
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:09:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXWc-0001Y6-Nk; Sat, 01 Jul 2023 06:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXWa-0001Wb-Ej; Sat, 01 Jul 2023 06:08:16 -0400
Received: from mail-db3eur04on071e.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::71e]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXWY-00076K-W3; Sat, 01 Jul 2023 06:08:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KULPkrbHe12Gp93U+URPUmSqSiRBG94A15diaHzv5ecK6fGNOsTVsiihqm/aJ5DNXF0MKmrhJcNkUC7Qfo29USfo+s5hWpg8ddFSSjEEC1LaOumpeClc13ZDX59q9M3Z8fAaGY5Uj6P9dKIT62+9auZ0dpfH+EmRMgU9INm64scUgbmOSz/yBBsJ3ZtBskA1hFmM/O4Nqzcy1LNjv1Q0rSxoiw6MORd/awrezHoDcWxcMBTHoUDCkKWkjRfq7u/DILnkdZiSbjoEeOPkmxS3D7Qx816Z/1LBejeaIBjSVdSe2Dn5hZAc7M67IWz+hPKRRKEnb5HHUGJEHpb9JLdd5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYFtJkHvB2sGs529bdWj6IlGeO3j8PwXarlbxavyln4=;
 b=RDxpBdHISj2RRdOeKXpOynwhTek1CWPv6MK/cbTrky7H1t5rC8ooFmP1tJnnlxK6ieSCGgf2NGvahTixd/ASjCC8vRvlGBffhGxuyE3bbgAsrin5uGTJdcMeeErBdChF81f22FhArlZprF+m2vSbt9sJVq5BJxX/Dr98j9zP5Zfj2RH56cPGEneaNMOfpXzFXCAPSh/SKl4oatCVcomxJpsPJq1CUrKMIuSPHtII2FxGw8uH0uebY5nbrRBEt+jXkz6+73iB9B7aMnEOnXnvsk8gbOZXTM3/PT64j3RRU8+8KOpfky8MyMl7LKPqeMFh5mf+cumiHQdL5PK0GVSuow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYFtJkHvB2sGs529bdWj6IlGeO3j8PwXarlbxavyln4=;
 b=cqj5/vYV18KV9NxbBEqck3w3aZSLa5ayiGDFlDv6aH7fPjFTnUqLypZdViDYbvjIfj1yqyzBdOdFur1jXOMxXsMGUYzeuHr8dZ908EJdMON9tG/GLBm5k64Gc8n4t6vjk/I7S2EHkQE5Fs/R/30DSHJNVHg30KKv/nbiYI9yAHWEIjvIaLGOlwUG2/qCTKeVIn8V300HZhGmkSTgA/cAkcAPzfhL8rufOBcKoksV1iRC8onl12nDVg+tyu3wkEPu30I/5kSPVJ1X3YzABQ08xGIu3WKncwuxbsD4CwxTrKmV61kMgnMEUbP53xuhgN508NbqWe8I8v7LS0EMc9uGMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS2PR08MB8832.eurprd08.prod.outlook.com (2603:10a6:20b:5e6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 10:08:07 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 10:08:07 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v7 2/8] parallels: Check if data_end greater than the file size
Date: Sat,  1 Jul 2023 12:07:53 +0200
Message-Id: <20230701100759.261007-3-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230701100759.261007-1-alexander.ivanov@virtuozzo.com>
References: <20230701100759.261007-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0108.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::37) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AS2PR08MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c68334-1f58-41b3-6efe-08db7a1b1155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aMsNon3P5DyVZrUz8VvYYaDiuKeevoMM3eIcuczh45Yttjzbw90KkR0YzAG1Y/cMbyn7pWHa2ogGgR/nv6qE/oX2kESzXBAbkHrL5YFicGueizZHsxzNlcdR1XORi1CATV6AHAzZtfSC2jPqiWn/FQCuWYYzJOrjVoippRkiRqRBPxZ/XVrwhUuWZuJ798rqw2YxnJ7J8XXyU+7OMmQtGymLSJsA3WwytlqHo3hCbVOWVZ/UzaWdto0yexGOGqxm1LaxMCGqiezza1c4mp7REp5v8ZAwS9hnf8kjPjWGdo8vWngHxiKE0kvNS+HsgAoL+bOfvoGwYlLtFXKAAqQjPLYeHMA6h5Mb9MMF8m0rA2f2jCgJCbJ//FpjYgfkUCXU/R1U0xOqwNnnv5hMkESEoWS4DFKzk9zNxvzNVU0mNlT5chjGyNgxUBxFnkD0BNrL2qZWJV560uwYiKs0o1/QD7xWfzGOqP/j9sAo8C7v1o26xZ+eMHPh1dVVQNrWNAxEKlRU1XeMIy+aLTf4p4tpJGbFpne+9WhLwkvpDDR2P013PRB+NbhoL2QMmnsrtf60FvuhXjg8WK+qr+FDMvCLp74ydrMDqemD0mKOZf0YvSefJE6XNQwSAej4o9r0Fktx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6506007)(6512007)(86362001)(2616005)(186003)(38350700002)(38100700002)(6916009)(66556008)(66946007)(4326008)(66476007)(83380400001)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(44832011)(4744005)(41300700001)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ssKBkjXIbDlB0k6lFVyKMMfwAsHgRf0z6Pre7ySsihJ4t5c5wn8uj0TroGh6?=
 =?us-ascii?Q?LBO6UONdS8CNTkKDH8KrAfcIsCcw8/lUztUZwFAsdR/IWifSX4T1Z5U80L4U?=
 =?us-ascii?Q?YAJhDVafBzjfMgFdK3HYPPiHnX0TYpZGXT1d1eYyNeR5QlzDo6QSixfj5tB3?=
 =?us-ascii?Q?cWWkKSjK4K9mrF7s3qBopBQrWnQJRpgGbyUnL0HFAlcHJEVZgLY1o5KPQuoW?=
 =?us-ascii?Q?OtFx/mvGKW6atjvz5O4UUmcQJSatOtqAQrcbIc0Xw3JJJNhXH36pthZb+nEu?=
 =?us-ascii?Q?09HUKOkGGs4m9kfivuxMtmB66FceeNT1p5zDoXGH6cBahpgukl0thPe0vyRq?=
 =?us-ascii?Q?OaVBeFu9UyFMipcgC1uw95lK5toITWKVjfXuBy/NZejgmQQifP/ezxhGouVx?=
 =?us-ascii?Q?r9x/D+2NOhbxx7LN5C3EGiwmjmsChV0ySeTnNKxZY866IbsAeREwD//VjDX7?=
 =?us-ascii?Q?5Gv1Z+PUHliux/8p7J3Sic3GOdaqpMkhX5+aBwNR2cL9Fgvz+U7fyUMZpgfT?=
 =?us-ascii?Q?oPE/F7mNXbmUe7pXV/pu0XsGgSLQc3w+78y4cL8c2MfoG7slh4oeOQlK50zu?=
 =?us-ascii?Q?LxzuUSfnz5rt4juGdX21Ap0PtrPs7eGrZHRMru7RqpSEXa906DB2zqBPR1bq?=
 =?us-ascii?Q?8xeBnUmUMuBkj7t6HuM1srFz/2KGXxRfNQg+7nLxxlGfANn3L0xStg2OeJws?=
 =?us-ascii?Q?uOxnJAp+Uyr84eqdfVIzp/lIEZ5TCOoCWRgT3Y7/reswzZI/QY9of/Zt1usE?=
 =?us-ascii?Q?oD3//MGEdv6LAjIIDpEZHjjPcXROvFWS9cpaexHszChdeIOM1IuCZY4gio3o?=
 =?us-ascii?Q?4Tcc3e2F3FPgl/S4U2nQZ39xTPnLU4e0At8g1Fj0/UXcdvP+mu8vIAyXaTBF?=
 =?us-ascii?Q?cuRgBhDAOKiGDF73R8tvrLcX4nElhzDFghMatyhueuzsy7CQ7ANbcIr86Hbv?=
 =?us-ascii?Q?Ovfi8sLAw1MfoRS8pBmkCqVN29db5WsCfEHqmm+V0d9p10CsZohAGzPcv3JE?=
 =?us-ascii?Q?L9xyuYP1IQXsNtLXBD8XOPE+QCOD4KBlidVV54iskQH+CCdbHiahgPnFveME?=
 =?us-ascii?Q?az7HTnRaOOXpnUDVJJCsbfxhnliBVTb+dOs05MjHdDxcWdoqxWB7CYkSe0N8?=
 =?us-ascii?Q?3wYhji4i3F1Am9b21jIcUnugVn2XHdNfNUL6g1D/ETfR59c0HCQVk7ffCn5/?=
 =?us-ascii?Q?DSAAqGlv4+6bVUnOD3S2lCjdaJNEdZN/CgEVwu+Lem3ajBmUFGD/BbLXWQDF?=
 =?us-ascii?Q?nGK2UYCvcE8B92nw0AGUyUkxkBZ4V5PbKoGqXqq4/uNpy3/wd3S1OPzvsz9q?=
 =?us-ascii?Q?ibtKjNTlXSn8YCPHubN6geU4trmBTDLdIyB2d6BRJXHrDYtF1ZUP25hry4Bl?=
 =?us-ascii?Q?F139LxqM7D8/iSAi1NSyo+HPeG7UV2g3Cepl1pWb1P3Q5yMC2uqHhTqhDXeN?=
 =?us-ascii?Q?96w5Hj+xx1a+q1NudeZ8cw2TSDn5MJcpBNfm23LXGP32uH61GxxB9UugYXa+?=
 =?us-ascii?Q?kgtqhPg0En6tv7jKXu0BlsHyHRoRcHEjNhUsdHVCLLZBZw3THqBwNwnecFtH?=
 =?us-ascii?Q?5KKSI2eoF/Us0PNR8SEeRYFBnERS95BC76NyUgKKVuCxFWGAEcs3GBrQti3/?=
 =?us-ascii?Q?lHykvWKaDQnWqlJc6wF3SAI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c68334-1f58-41b3-6efe-08db7a1b1155
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 10:08:07.7938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WoapTDgUGsgzFiUOcvzdInq+YwYUwAljsDkCR3IQWZCPLvgGWG8TOFoHTAzLQfeQ7uY8UDEMsI7eZCV4vEYvngMmwVXg5/S7tvPodN0bswc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8832
Received-SPF: pass client-ip=2a01:111:f400:fe0c::71e;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
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

Initially data_end is set to the data_off image header field and must not be
greater than the file size.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 86bc3bfcb8..40a26908db 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -868,6 +868,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
            and actual data. We can't avoid read-modify-write... */
         s->header_size = size;
     }
+    if (s->data_end > file_nb_sectors) {
+        error_setg(errp, "Invalid image: incorrect data_off field");
+        ret = -EINVAL;
+        goto fail;
+    }
 
     ret = bdrv_pread(bs->file, 0, s->header_size, s->header, 0);
     if (ret < 0) {
-- 
2.34.1


