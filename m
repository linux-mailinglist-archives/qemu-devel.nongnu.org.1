Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C2C7D904C
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:50:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZb-0008Mj-Eq; Fri, 27 Oct 2023 03:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYv-0007K0-CW; Fri, 27 Oct 2023 03:47:26 -0400
Received: from mail-db5eur02on20704.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::704]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYt-00040L-Ly; Fri, 27 Oct 2023 03:47:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAy2Sb1zVRLGqPzvu9WhqUirwDyKacy0ZysHUp4BJFQxC/68HVWRFDiWC6Is/fQtLPaJD04N1uNqv+bePiWvaGLCdEp+MZICcFl+OaJpZoeeuJh1ABsi8g3Hl/IKxeB3iAtvafvmWYaYRx1hQNeQgkMBdX8k8uVpNrcjxVxPqWhQYlCSROybw2/KwjozOyqPTZDTvv4IzHe1j1aZAuH6PG+YArMkvDGspWfJl19POFD9YEAaa3LsGQiqqW4TLtgloQN8ZdH4lr2LP8+LzVOcxpUbpv342HUSd0KQIppMMHAfd12EV/wD9PjrGvi2Py1pA7k1YiKqJ6cCFVC3ApNTDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97ukfm6vS/99N2d/mWr2AxWxYEsWR6QQMKlvpEE00Dg=;
 b=aq6AFpVbq1bPJHQ+3ek+XtJn3Sr23QRxLZdcSDcw2hWDNBqQzsMBS1vpT1NEwdiA2ttkWVVFJH/7Fjsp34G7rEds/bi0uKuRTazQbpNWcwJlzN/FGDc1Ee0dMpaApIfhYelCNG8/3st3hQnqKlO6ZYwvmD5tWZFlz5mNThQ7vINL/Xzv1uxi/d9d4H39rqua21GZwF9bR85bY2LjqOPeaXzwkQfdCcqLyZUV0/i9q1AC1XIWgnYSAGDKCLhgeb7FMn6fKkMwsKpE2qIQwdpHPVDYnYK3pxHl30+iaosf5sqEWO9Fdn3I708q6AD5VJMB2EEOpB5tck2rs4FPDeTuQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97ukfm6vS/99N2d/mWr2AxWxYEsWR6QQMKlvpEE00Dg=;
 b=JL69t6Ufk/ziyhRxL6wf8NOiNmhK1hNEXmQcy/NTLIGORqwNt7vnQROGQ5Ix/fQ+oEPLRY5FbKcQNlXxSDuYdl0W8rOLxcZJM0XdbAB9Tx5DVx8uTZ0g81eq+QGa2+NjjCwjCpO44xd6J4a/m64r4vQcPLsFgebuHavpI3t0LpZVKrLlao5P8H51x6Zzke9Yrgky344KaU4OkLm6Ab9PbTAlcu3AcZguaDBQdWkUZH+3HaLO3C/AhPoVT7ydffV4hJwZf31AYhtwgIqc9WVQqLqZnf7lmbSmG7rbo3LAKpG7cxGBTjFsmLDL54v4PXc0U4XQT0hOSztR2bsp5zu0Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB4PR08MB8056.eurprd08.prod.outlook.com
 (2603:10a6:10:387::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 07:46:50 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:46:50 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 14/21] parallels: Make a loaded dirty bitmap persistent
Date: Fri, 27 Oct 2023 09:46:29 +0200
Message-Id: <20231027074636.430139-15-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: eadad7c1-59cb-4fed-dcef-08dbd6c0dff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7AQcVKR3SLrOl6+9DoQUYCmztARSiBAY4AQYO37bMGuDQhwvoBsnYvmcKc/xnQVvvxFUzCXHlTv/5ZMq+ovqfmxIcD572U+8veynw1TC48uXzPVY6t7223z4+1FZz3EFth7DVeE2X1XvQZ1n/MoaCCXQOBRPIsHz/KXvIaNqTuBh60EV50wyWmyfuk700AgwooxZFTySCUDFuSLpW1TmQfq2IOli3+P1J0AIfR15xVSqohittnC1tCZonKqT8A7Ngk5PywDNtLvhqLhdfLn07QfVko+Ry+Oeju86vksrQOipvdcsMClGTqEhXw0itiNpB4F1/zVaUxNsErzbzXthROaJ8kOCw099Gj0OKOVi4CmToAx/hllWGdsMt69+JVukXaZq9YAmMcUsdzimU7Nc8SkebpTzH0yYMnakTaz2HRsb2SmTYfr8Pb9XjdFpQplLqywfMH1y/DBmg6BMxGDc5Gja7Oi9SnEdOutwqs1BWgt1YrM+6cGkOOzQj0Vfmf+NXPyYbH+2l2EPf0z2F5+XelF3SgV5JiZbNn2efxrihEoJteEJHrp6kV3pC8XUxBYRX8jK6eB1HJ7jEGsYWyEwtXbozEdu27uswpiqysBEozKVQgakNzNMkMd5Po4tpYZ3adYv7r+v3zD7GItstXsvIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(6512007)(6666004)(52116002)(6486002)(6506007)(478600001)(38100700002)(86362001)(36756003)(2906002)(4744005)(66556008)(2616005)(26005)(1076003)(4326008)(8936002)(316002)(66946007)(6916009)(44832011)(5660300002)(66476007)(41300700001)(8676002)(83380400001)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7pIY35CUlCMm1sbu92jdE+XyoqdufKZ/0T9zbFLVLz0PjyAGuKRS0sAU0s5U?=
 =?us-ascii?Q?XNgWzPgEjhsqfMBqc4IU2/nB6VfMJPBdnW+/CDUO/oaEPACml5wAo9avNdwa?=
 =?us-ascii?Q?JrEf8DaEUT9GM+ulLyD5gABSY8G7bzs1Ynvw3amCvpXUFiDL+121vGLBdeFL?=
 =?us-ascii?Q?ucUaQVnLX7gqv+tD6t2senn2p8ti5OTdZEy2/g0ZO+LmmWwPxmx87t+a8zs9?=
 =?us-ascii?Q?AHeg8UHv1TylrmtpHWIx+Fs5pSgZ+IiNN1z4uU99NczKuL8TXUmBdCEykwCo?=
 =?us-ascii?Q?jrJD27mIFBLqILa8p0DqL/0vmgzAiXnZaqQC8OVi7mddkk3SPVfZaAHd8OIn?=
 =?us-ascii?Q?p6nEUKblqkxt053MsAAT2MOV0tstxfSU5FZqNdCg1Yir5Vl73yVhCUAtE8Di?=
 =?us-ascii?Q?8QjOWa9BBavtmmdt/AOrJlbyPHhGoXLfyUvAG/RM1hBWiVrKib2U6NNgBkJm?=
 =?us-ascii?Q?U7nVaxh1nk7WiiJz9gNYZcz8igsFOAgPyTUJOcCnmuWAv6b1LKvGvfqfKGbz?=
 =?us-ascii?Q?W3qtXm7FHiBLBxuzK/VPx8o3lAymdkWo+KtNtcyVPk+9cEkpqhOnwKgWevFd?=
 =?us-ascii?Q?TNv0rVb3k680D9SUAEYQ5ZmYOs+mCitGR8MSRfYM76XlRtVBBaiK3gXRnJcQ?=
 =?us-ascii?Q?lV9MFOpylBEEyjIdo8rG1mRJahxUiBdrESaIgWqPcjyHtzQVVOidBDDLYRCx?=
 =?us-ascii?Q?ANwyPade2k2qt2DYv8wMk8s+poZtihYAss+JXdSB6vUQbC1BNzrHhu0uptHK?=
 =?us-ascii?Q?LDUOOJVKwjJyTrCLwyYSyo0NjmJFNDwjCqP5owQpcD0LNd07RIrzOUKV12kG?=
 =?us-ascii?Q?3vr8C9iE+g7qu8KQvCHzcDdG64CkdlSIcK/X0rqgVkscomHtj7kRgUp0AT98?=
 =?us-ascii?Q?m5791WgjYrgGwQCew20JE7itlfZKQjP8Co04ZYyg781TYQD55+jTjUDnytaY?=
 =?us-ascii?Q?NR6Xedg0981+OnOf5r//889h8loGrN96XofsKuYiPIuWSrisketBGtdkerl4?=
 =?us-ascii?Q?KYvC4MAbcM61PIgtGv9bexlAqFhl6m0lyoES8WNq6UbpPsMjqjRVxlwCUxpw?=
 =?us-ascii?Q?3sLdqLhWXlN/9NUUf8RhovL+5M1VO6/4lI/Y+guhcdHzCeor0yyT0mU5Ier6?=
 =?us-ascii?Q?/1JRBBSfskEL4d2ApWtTmTj5g3w8QQhp47pASa3rjG+FZfQy7TdEJBUdnP5M?=
 =?us-ascii?Q?MVEybh+qOqn4rL7UeOZR1D231Yiyt9cpJ++VguwFP1VRUFwhpgM/xoW2Iwlr?=
 =?us-ascii?Q?bp/KnevRzMGAYfmRO5Xg8P3LOM0xgwtZtqLvXMmAppeTIOtD7tliqr8nUzgp?=
 =?us-ascii?Q?RVF4PT70oTOD2b+M6x7zgLDRDEC81cLLFv0OtXP+1HokJp9Xtv6u9IsdQMZu?=
 =?us-ascii?Q?WpKPEqQzOgGEoy6GY+Byh8hLXLIPgMWWzIPVQR+IISEfqQ+5xXjtMF+S5ptp?=
 =?us-ascii?Q?Q60MYLt4A4nzVUkn08pYxwp8/a7PgWzGdt4Ob11ardfcJFPkghBwwgAVvWkO?=
 =?us-ascii?Q?qFRBneC9s2a9GeOFajuMdqs4ebeze5mmHbKddcJeoA0vrUKMJCoqIcH56zm2?=
 =?us-ascii?Q?6JTcw30689FiuQ033AHRDu7OCKghqjD0tgnhG4cxnpcxbUoEhiIGfgIdP5w/?=
 =?us-ascii?Q?7P/kGIu4SjTWt5yUsTXPOl8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadad7c1-59cb-4fed-dcef-08dbd6c0dff9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:48.4828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CW+T4kEW2c4bLUVuKySge94/gjH7dY7mwlLWse3/0zdYFnzS4IRHikghRIciCAmQf4wyQGm07hshA9/PkDLgS3sksv50iFQQ0u+VnOdMm98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056
Received-SPF: pass client-ip=2a01:111:f400:fe12::704;
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

After bitmap loading the bitmap is not persistent and is removed on image
saving. Set bitmap persistence to true.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index ebda6b0a01..bb4478c350 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -256,6 +256,7 @@ static int parallels_parse_format_extension(BlockDriverState *bs,
             if (!bitmap) {
                 goto fail;
             }
+            bdrv_dirty_bitmap_set_persistence(bitmap, true);
             bitmaps = g_slist_append(bitmaps, bitmap);
             break;
 
-- 
2.34.1


