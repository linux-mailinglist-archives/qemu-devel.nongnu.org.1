Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 738AC757983
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:47:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLiCM-00022U-H0; Tue, 18 Jul 2023 06:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCK-00021J-3L; Tue, 18 Jul 2023 06:44:52 -0400
Received: from mail-db3eur04on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::703]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCI-0001xm-JQ; Tue, 18 Jul 2023 06:44:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfDq2LD7Za2sJQ9VR3dEIzZEn15xTGG/RFan124LZS2ZYDpD4G1Pf9vK389CEnurHEcT24JJlfKUvN1ZwcXwBkbdHpOIdVy75v3+q2mDedxjrWht3dccQ7SJILj9ZEIedFOripdRASw40hSjsz1AmWge5OEY45G0//VFEgeyRBA7N2uyfw4tS8jb1KUqxeS/g7wR0KCMQODuvdg87i4MABP90I6fu8nC+c00//F+/OZr4nS8Hpry4vYQ8XfQ3HTSTElpR7cDTAdoQtIjjwB3zpwfYDe5id1pPnRQVzb7Kd8XImCvBgYdWXV+oiZYHVZJflf7g/J+YtrJhJ69V79Ovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1d178C7HLbrsfWME8Ns1UxvsTeKlDgcAEjIdjdqkwI=;
 b=KHYQgD9tzcqJNWfIFw8UcMVrxNnpVLhRi7TsqHOm6ouLI6T8v+U6bPz1mPjBb4KwREx1diLddJsYjcfLi6/ENYah2CkILbHzY+x709fgzvrRp4x6yTRfo2RcBhytG/bPJ7uaX+lBobRSa5e6P/rbk00Sp+SgDZBBvg+gtvYg/Shk2PQGtXi9KVb+94B03WqTmV8JlxvgY+R1+/I7EU8beFGv0GZN/mi98Wzw5qR2K/Mu3PhV73vclkqjrDPObFS1tOxyDJiiQJXfQNdPDpW5OomU4O3F9WrphE/O8mA5zdYTMLvPhOt/haKxA3C2hkUS50WX4faGQpd+tyI5Z1Luiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1d178C7HLbrsfWME8Ns1UxvsTeKlDgcAEjIdjdqkwI=;
 b=OVVIsVhobNkG+dTmLsgPlzBtFpilQSW9GAmyuuqzST7TsM1PNlLffChqGHTEQ6fhd1/+NjK5lnbmF5JS1+1njAM3lu0QgNQLXRIPJuid0NkePI36jFTInfW1olMutroXt/OyGyKkl9jJvvjHlBOEHsbGIcgio4YciBUpjiesqmFAelLtIgabNITYA99NwEywFWGmrGZRoXhYLX/a46k7R+qDEstJ7f/uHot6ONLOJtxGXUIMgUMt9F8TOVEfwtjDwf6PkaCwrtw9nqjFOEM73a8GoOM8yFRLo7I8Xa4Td2I4fCzHFkRd6TrtSJhpOJefFmtyYdApzvCOu9ICdHeoOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by PAWPR08MB9784.eurprd08.prod.outlook.com (2603:10a6:102:2ea::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 10:44:40 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 10:44:40 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v8 02/10] parallels: Incorrect data end calculation in
 parallels_open()
Date: Tue, 18 Jul 2023 12:44:24 +0200
Message-Id: <20230718104432.1130469-3-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718104432.1130469-1-alexander.ivanov@virtuozzo.com>
References: <20230718104432.1130469-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0001.eurprd02.prod.outlook.com
 (2603:10a6:803:14::14) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|PAWPR08MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: a33a0e55-e2c1-4306-54f9-08db877bfd4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RCJo2Pecj93cPqV8gOskA/C2EyC40lH0GU9Xz8Ltdgl3TM6amVSJvVfo+h0gZwlG4XZuxyQbHQVhAfpSemXpxyAufYF6L5I5IIMdo2dAbOv6ZDG76nqwXmPgXxQ6uEr78oAMf1tV7FRzt7asq4QKydRvkncdiIDXpXiXHhpZpcIAjkarG/bXpMHzXLtgmWTZjCOw+6H9fCgSJUlkilF5MpHHioofhHQEf0p3briXA2YN99GkuNHq53tj9NnxivG5X4nGRugy+tEvCLyS3YI2goxIuig9UBrM7Q2ViBwuTpHLHIygxb912ATUy7w7syrS223BMKhrJdCCe5Q7wLu48/GnXO4T9xTfaQ0cGBRVe0lhv888KIrWMal1neP4Dbgqmv5vDubJC9/5kQ/2Bnhio2Cs4zHI4jz7KySaqRQUHSw2/ZPArf/kedemfscouJmKUsE5NixyjOVrAcIBGvDGoXop089prOashAA4amVaUM8fkl67QBoq22pTWLGKgM1ubMDIL8mGWST58Ckmpa4378ogph/yql74KjT8nJlf8gH07S/wFlEX83p1KsGcTDy2SIDFhEULihBCk1SvClNV3Rkoe5LzyHGC/ZphsgZx1Cl8iSEhBHK0rmGG+xk3p1KQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39850400004)(136003)(346002)(376002)(366004)(451199021)(478600001)(52116002)(6486002)(6666004)(1076003)(83380400001)(2616005)(36756003)(86362001)(2906002)(44832011)(186003)(26005)(6506007)(6512007)(38350700002)(38100700002)(66476007)(4326008)(66946007)(316002)(66556008)(6916009)(41300700001)(5660300002)(8676002)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3JFyBlUHfOVgJGHi13hrCgTFdp9mO9UTnETxFsKoTW6R+UU7BAPESlKrzkEN?=
 =?us-ascii?Q?7npTU4sqaBZMu+Rgml5fV+BdZbtpbZpYNhYH+PnJ7HosWjbqK6+hnMK7oZFF?=
 =?us-ascii?Q?tzv4JHVm+4OBSxVvoBTth9Ftj1N2XRU4bfa4M7ChscFY1oY+M1Q78Hr1Hn3p?=
 =?us-ascii?Q?Gcp00/mgNeI0JCtH+giHwVfmD9o2h2EhzUzCZAHSUJxXOv1mFMNHg7NZ7iOb?=
 =?us-ascii?Q?pzi98vYGBxcmPQNtzwfjU1X6CaFwgS4l3x29uc9ABSxrHFy+t2t09X3Gef2t?=
 =?us-ascii?Q?klJ5pOu0AGStnOfaVn6eU8LDnrxzSvtjskWKRqBKAMTuoU9kT6vwV7rz/YTZ?=
 =?us-ascii?Q?bH9Znmv+fBVGG84hpBlWaAysjboy0Rqar0HxaTGoWv+gNIGfIiM4IF7Pg/Es?=
 =?us-ascii?Q?/69BZGX/0tr3BcYCbEJTN/WSbJ3ihAn98KwHM+yOcymB/JeW43RGB1+XKDpx?=
 =?us-ascii?Q?zmwfLCf5qcDfrR8t3ByBSzE1eSTYapbgt8gOoXGSnHZVY4wqi5phRMayM7s1?=
 =?us-ascii?Q?aEj6FADI042T7cYU5oPTzhB++Lur/WZHsDX6Y5Z47eGX+6UN2Qsnwv4DJyGZ?=
 =?us-ascii?Q?YiYQAMq5afPmGkWLCieneWAr1jTEUIicUKJlpMfK7rNpIM8fvdLV/O1a++Ae?=
 =?us-ascii?Q?c9ALtEtMjX4gszId4Ydi9c2jnEMqwGW25dat/rcr4PRezFK38ksFGG7tX9dX?=
 =?us-ascii?Q?UVJ8IL66jLNnhv0L4jBxbdO4XdxBEok0E6uZLDDSMnxRx4wHaU4vm31vSFjH?=
 =?us-ascii?Q?lSwybCT9JsT6k8xZ0RLhk/pJnqVLEoaPPG9DLjFKmTjk50QJk9x9JVhHw8qE?=
 =?us-ascii?Q?/cZtgO7Lef8Jrh5fdxKb3IA5Zf6A/7g+9PVnDzdfYncsT67btl/wmU4hqVhj?=
 =?us-ascii?Q?4BSU9UFrY9HU0ewxf/pOxgSuc+qRv8K8tZ4RrLzTpKpxSlmQnM/oqDFTMWD2?=
 =?us-ascii?Q?FToFuc6+CAVtB9CsGjusaBwuipjyALmbJnaT3UqQr6GKtOWQXwfTLDlFifGA?=
 =?us-ascii?Q?k5CU0h8QH57k8GwPIhGOeyOE+2J14gRD/6dhaCnKFFdRi6x4BuHKqG42crkt?=
 =?us-ascii?Q?2l/6VhMW8Xki/9W2lk/uQE6MmM88ii0x6k2zAC5t4+uS6d/510smdIH+1jJq?=
 =?us-ascii?Q?v4w49nebWxIHkJm9F5G+eHBeOM7jaQYebx7/uu50c5de5yUSSubPLO0MXiUq?=
 =?us-ascii?Q?nS5Svmbbr2uxsCjlsqHGOy0ksI+abGjBNmabjPy3O/E2wL7JufhqyZg3SmTL?=
 =?us-ascii?Q?+a1grAKUVdI10mENA4JmnaAJtv2MFmJXxlvqbq/Pp1coaSe+Jr9ZYvMgLzMq?=
 =?us-ascii?Q?MsuQdUY0wL/GiRwgQ8BQVRMrHm7nFMONCoeDMKjhG4CQd+nUqh2J7V9Ihq4U?=
 =?us-ascii?Q?upRyfBq3DyKOr3gNn4p1B+iK2bx9QYqrJuPMerepk+3ISotBWDiUpkUV6tz7?=
 =?us-ascii?Q?eY8fFEzXgFumohb2IJ6Ls3OgxTgkIjX9m78eHRuHGQutp4gEW79d6T5pPz/3?=
 =?us-ascii?Q?7+4t5MZuImy8785T86AySXaO7CH3dC2cCAwCrmYFNDeB+TANAixsrO0/gAnP?=
 =?us-ascii?Q?nkFgY22pigCVpjHzDFP4jNhn8pczL/GVIviaGu/RoYyWBDaaeiybO7PLRbRB?=
 =?us-ascii?Q?dMCSJIHnhZuAwKRtW14oIj8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33a0e55-e2c1-4306-54f9-08db877bfd4d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 10:44:40.4459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1hRW0ad8geWfEmIazpeYzNEC1ueyaIVMmpK4Mr5pgTXBHl92JOVi48WctBCe+GwAJ/bsapL+WctDu0MrEvuFAgAvCXe8At1pHBeBvNzl0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9784
Received-SPF: pass client-ip=2a01:111:f400:fe0c::703;
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

The BDRVParallelsState structure contains data_end field that is measured
in sectors. In parallels_open() initially this field is set by data_off
field from parallels image header.

According to the parallels format documentation, data_off field contains
an offset, in sectors, from the start of the file to the start of the
data area. For "WithoutFreeSpace" images: if data_off is zero, the offset
is calculated as the end of the BAT table plus some padding to ensure
sector size alignment.

The parallels_open() function has code for handling zero value in
data_off, but in the result data_end contains the offset in bytes.

Replace the alignment to sector size by division by sector size and fix
the comparision with s->header_size.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/parallels.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index c7b2ed5a54..3c0dca3dbf 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -865,9 +865,9 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
     s->data_end = le32_to_cpu(ph.data_off);
     if (s->data_end == 0) {
-        s->data_end = ROUND_UP(bat_entry_off(s->bat_size), BDRV_SECTOR_SIZE);
+        s->data_end = DIV_ROUND_UP(size, BDRV_SECTOR_SIZE);
     }
-    if (s->data_end < s->header_size) {
+    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
         /*
          * There is not enough unused space to fit to block align between BAT
          * and actual data. We can't avoid read-modify-write...
-- 
2.34.1


