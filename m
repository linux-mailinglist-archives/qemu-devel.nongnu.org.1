Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 207DC7D9039
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:47:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZD-0007KX-Rp; Fri, 27 Oct 2023 03:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYX-000779-32; Fri, 27 Oct 2023 03:46:57 -0400
Received: from mail-db5eur02on2072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::72e]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYQ-0003oB-1q; Fri, 27 Oct 2023 03:46:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxgoRhwzZj3oSuYQNP9I9gDakOwC57VLSk9VuOaA4LJwPoV7zzp2dsYSVS/xPEeZm40CwdE5xzdKbgJlIquhZmnyInD/G2cMST8xk8JMd/6IFyteWfzfKLrKjaSMp1iZc8hTZuIY+MR7m/NYXYGHb2C6DqXYFZ4/qFpa9fxBPeEfdjo0VApADC4YlHtqyQtMhxiwTEjqvZy6brjWM5NTY9zzhFKM992uctSY89YnCPfgOR6PQCMMm5WHiKoldx/X+74kOwYkDnEe6T2HREsZMKfl6zcmkzWhE9jntEzobpHu+/zFNMIj9NN+r2dzOov3O47QHpZBiRmQMIVXfq5Ehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJX5n91qwCXUk4APlYK8YlvcjkcmYVcnzmXsaC5WqA4=;
 b=Jj+RvAEUBGItpsV26wCzWTclzyKUScDaZMoJrWL9n+X4pEyLZG1nQ0ls83/Hx9hdoMLONLCYiOGlogzczsmuw+yCMPOCsRawAHbLC8zkJUbQ1yTmPgFwUaJi17Bc6O2PflZFokbkk+D1ZB/Ijtk6LXFzm1I2DzA/B7wIdfGJ8BS7EnFkbePLYuLSrENoMS250K42Vof8ggGO05Q6PhKyJCpDh7GgDek4HjlZRUKSA67CSpSmTSzvZMIBSmBBu4LcE7HaKmrsry4uOHys2qnjN/SRVhGJyRV6/wUi3Di5dutOsq1dPPoi/pkal3tnX0IkwUkbmMJbxsLfcXZvAMo7GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJX5n91qwCXUk4APlYK8YlvcjkcmYVcnzmXsaC5WqA4=;
 b=Uu3b+D4kZJHYlbuvDqr3/7Q7Bi2S4Zo2vX/ZDgikCyIq5pJj5RA5rCJKy6qOXvfpUwzIRijIhAPnQ/mnVzW/T86vlU+ratd7mfbFZ5Raakr44BcKPMOQEn1g29UFN+shCjw10FxShM1lwoUzh5Z9u3lzyqCYCSn8XOCtbkPuAtWoaSxHSrDphTuq0yyLyUt7skeEGWqcajfTgShvXNHfKDc1z6Ly7fNoqjj1PRkYz31l1O7Bl34P5X4vBVCzVeeltUQt4UEto55cQkbiaAzL5wG/1uvGc8ZVmaxjOiGCHtUR5LewzbNKUASDT46L4NhidKtSSvRUzWGHt1TUfbGEoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB4PR08MB8056.eurprd08.prod.outlook.com
 (2603:10a6:10:387::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 07:46:44 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:46:44 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 01/21] parallels: Set s->used_bmap to NULL in
 parallels_free_used_bitmap()
Date: Fri, 27 Oct 2023 09:46:16 +0200
Message-Id: <20231027074636.430139-2-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 02d922df-90fc-4de9-17a5-08dbd6c0dcfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6szAIv1YtJcfsF+8i1hfK/JexDwI//DjRX4amZTKZP0LWxEWTy9r0AatzBmkA/acireQ5I/P6+g6J26g3GDHEwAcqPNoxlCuyRpDz7Q+SLH8f0HOoXv/D91YAYTpFyfuBdfYFn1YMhkix+Pp6RYBNcDQ/AZB/kLN3oSwTJxmwx/crBYHyPbN5TPq27iuAoF0SffRKZEniwNdO7xBGL8LqM8YA6JvTvl9BoP+QRBpOOMJiPYdihZ3IFeClV0wz5VZ5AezfXdxMDNdomnLXSZTeESaqfrS9Dpg8Kdcsj1+d14sS/0aJyy89jcqLyseMC2WvLIWCFsP0xbEKRWBYZ3YWle8OC5JilJXT/gE/rwpy+O+xrbKdSXQcbb1SWbUn66G6UPA8CxLU1FDCMQXQY2/MeUvb5scoaYG68ahye/U/yEKFLWQyFVNmVP43I0/wQ57GaZCawcKq38PJYi5uJygxKNbG6goIM1lZdT4rjrXjfp37sdmsXbjpkQDAxwTQv9bL6FhXHQ9q8k0kiuYhWYFBoPl8cBcsV50fDWidkH0zyAHqA1Nam9GrWYuRJ0J6bMZ6fK0IKBbZhpePAg65kHkVWfT+54g/Pb9I7kJ3+6n0MR2/UermU0STHqPEHFCnsh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(6512007)(6666004)(52116002)(6486002)(6506007)(478600001)(38100700002)(86362001)(36756003)(2906002)(4744005)(66556008)(2616005)(26005)(1076003)(4326008)(8936002)(316002)(66946007)(6916009)(44832011)(5660300002)(66476007)(41300700001)(8676002)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zLRI2Vo2WOxY74wAfIHcU5LzLVeOQGQaxHb+USoYJHt0g8dq+wxcXaHp7Tuk?=
 =?us-ascii?Q?Q0Y+AEYd4Dbu6HB7mxS1fi6UOP2gaUudVGfxobUMsEL3LDcbPenhJP77RHs/?=
 =?us-ascii?Q?oW/TyryBZzrSMRJlyfKAq8pIzH9OoEPH6FOYwByTmILlIBYgNotP6l02Dn6r?=
 =?us-ascii?Q?beM+QHI0/D5RCkDoHfCD1aE1mznWUeDPsLoZ5h/56E/Q3yp+MInO9u/I4JEU?=
 =?us-ascii?Q?5m5mRFFEPelFdwusnnXHjVuN3wE6tDaqUOAQlQogD/zdvxHXzUS8kQiWcyyt?=
 =?us-ascii?Q?PHqPWVMX9kw8uhaXk973VerDUxQLk9FuvygmA/45BwOBQ7J3Mcd27HPPfX4s?=
 =?us-ascii?Q?jLxHtf2VjPaopFpepyxvbR8J8n13UTT4jcOviJkymCPbqgu1FDyUsJc9k0Dh?=
 =?us-ascii?Q?871Vg5uDvl4Hs1kejVaAqvDUZOd5zu2rKDayPu060KVlqujUkIvfdXs9NrBV?=
 =?us-ascii?Q?wG22P9bYT+ITe7EsjvJA5LJzaCJjnR13UvNlux0zYgtP/0DXRTOncpXpd7dq?=
 =?us-ascii?Q?tD2xEfa4CtncL6nQqbrpv+E5WNPbfkdzL7txiLv5VV/gasQhOc6eNQRazr9V?=
 =?us-ascii?Q?IBp49SgISXE+4fMXcVkyVyxG3mzw1TCWIMOHwc9o6G0Kuo5WaAIAwmCeyC8n?=
 =?us-ascii?Q?XmuAN4Kw4Sv7TQ2vDZ8efIoR+L1Q/JB2Gpb3nI5a9d632dgaECY1X6L6hM2e?=
 =?us-ascii?Q?DisKmlA7QH5cLmuCx6bTbTyQ+v7f3C1ysGzXuXnlVMYrySbcxQ9DYALcC2k8?=
 =?us-ascii?Q?n/leBj44RQMHLGOZFERySiI3OhMWLcfAanXQbuiwaltvmoyYEnN0wzDz+KBk?=
 =?us-ascii?Q?ngzXsle6nJ8IzziYnjJtuomMpaZvHnmYcF61WJaBl5E9FoIcvm8eek4mn3RO?=
 =?us-ascii?Q?ZcOdtMlomt56xEB3KVTR44Mckw71ZXGCyeBKgJLC0v/gInXEjuqUFto+TiPM?=
 =?us-ascii?Q?buDCGwb92RbHpNSTUU3AkzbZEcu1tDBlPhCFZWcOou40+g6hhpa+yBSHRWXr?=
 =?us-ascii?Q?V5qbJscDTXh8hAGdNJxWPCf6gRfVuxrjA4vN9q9lvE2k6IjdOwngM2j2piaD?=
 =?us-ascii?Q?OCk9U8qwb5PUMhfxS2SEpKAD6ZaAmT7+KHmyaW1KH3dsCW/ZiWwWlffUGZ3k?=
 =?us-ascii?Q?5ObscnlDqPGuFloLWYmQBFTUDwDW2rrKHa94fuxR0K2AuVrUDvn2I62E8Sbk?=
 =?us-ascii?Q?CxQMYB8b9o0a8m1zvzkS6fHElfGcuqmCS8nPwg3zSDzFYHAoEFenbE6tFIwj?=
 =?us-ascii?Q?YdnZb3F85Cbz3Hi44GsQVVPh2biA7ZnvECyHrKk6oXAaI1hQhWrlctZyPDwy?=
 =?us-ascii?Q?YKcZtPM9NsRnrZUPw7ufLBTk4ZQ5x9vWd/n3ug98EbySV2zUcMQzzABsMb+U?=
 =?us-ascii?Q?Yv2rhjAFRrXsvv4CuoXCUOrhahXYIvH3LbuukTlVsU5yyNFuCiZ9ls9U5vpe?=
 =?us-ascii?Q?p42SPPxnG42+MEdPaSf9j+nzpE6N7S7U6ahcihemyupHvbeActWraMNLa2uE?=
 =?us-ascii?Q?kgFhS6IrecdBEYhClvEkEodP+r63Ej4trvpw45vjWmhAZ+tQ1U9HpLa978aC?=
 =?us-ascii?Q?bI1tx5kWkRrz/bb8Cd3P8eKJPw7oWoDBML/1gN23rs36V6dM91g1SjuTIzc9?=
 =?us-ascii?Q?dqVUBGRLxLhp9kV7hrKAuVY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d922df-90fc-4de9-17a5-08dbd6c0dcfa
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:43.4584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sv0enxTTde/AQPjST+pspexRWgfpMxTvY8aHOmlP1noQ4vJK1O6buNFB8gY2g1MyaGbHftXBr7lYh9SaMLeHZWadI/ldnieWIeFMrbDZxbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056
Received-SPF: pass client-ip=2a01:111:f400:fe12::72e;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
index 1d695ce7fb..01a61a4ebd 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -245,6 +245,7 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
     BDRVParallelsState *s = bs->opaque;
     s->used_bmap_size = 0;
     g_free(s->used_bmap);
+    s->used_bmap = NULL;
 }
 
 static int64_t coroutine_fn GRAPH_RDLOCK
-- 
2.34.1


