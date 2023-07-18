Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 398B4757972
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:46:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLiCJ-00020Y-QT; Tue, 18 Jul 2023 06:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCI-0001zc-0H; Tue, 18 Jul 2023 06:44:50 -0400
Received: from mail-db3eur04on0704.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::704]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCG-0001yi-Gp; Tue, 18 Jul 2023 06:44:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxsaEYtHtBszPIQZ1CMjdQvx9YvRT2eXdNxUIJMG8Hu1JeIGVmkw+EL/6XoiNuoXdGOlEYp1Bs17K+FMqekAJs5z6zj07t9BSwqXwSvXtnuwtknmV2s55RyZymaYOqGLEWO4Bm/Y6w6KwKAXJdSkS9lrsM5Q3yKu2JwIMq9WyIoSWJLHyUmedVn+khJpXyPgeEzgi1OaMgIvqUu6RTI3rubK9mk7fOv5CPAw10ifN41gXWRiK08LQGxBgHsiUYhdwoOpEcRYUfY93WsEU+xQ7K6qYJx5qF+pcL4TRhYDoshZLI6STfC7U7ihaC1KOTYHK7AHsESKNzzDRmNBvS+cNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bU9kYmAMMpkItlyZ3OZS8PV4Y4XX2CRLrx/JT6o1Fs=;
 b=GhER3q8ef+wQ0pzs4I1fKLZxJXpghWvEtY1Va2ahJnWo6LcTXxHWnUts+04BOOTTu2vT0ajipBnAcZizduPdHBLWbFrIzVCXAmaurmrYVXEEQ/y8wzsg8RHF0jBLWmV39y/nPdwDPVBrUB7N8h/l0GpEpTmlkFb7QYnLSJWL9tSKI1jvw3uVKIoKwoYmBZKNFHaLr8XWuGxiJREoCjchEI7gFMffcvCK8QCZlrWa4/uSD/EXsPc1C5iX7VhdhBxA7qy96ryve3o4MJWKHhH14SRHCWdrLKclHhsV/H1WijT5SBgrZ7WhncH21tMeC0s8mePc4KtubSELuBznuVPk4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bU9kYmAMMpkItlyZ3OZS8PV4Y4XX2CRLrx/JT6o1Fs=;
 b=lw9qwa3uKIg4UdKViZWtRluh/Ui7feWz5DToAcoeW4NIzMJycpV4l2PU9UftBroqGtYo+wx6gwEWDhI1abyjD/FyHbqvAMWZ07Ec3PkZiZOwTDplFRl1fWK5wQHf9eq5Eaz2XH+6HkAj3BhHboG1WQpJc9Vmh+tvq0Y9FrEdQ+tAHOMsSzjHTNxl8Wsh8mOguXY2j4nQ+gIo9sDB6D91f6Cw9yK0SMvQnpXA+VQrYlqeTXoIcrfV3sgg7bzKRFgF7xhPOddQdXvnR+WazXz6+iG28fVHAMyioQNqDw0h7SmBjc6cSILlcQxrc7iaX1ZIh2tqLdY/DUsW0NC7SZKuFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by GVXPR08MB7894.eurprd08.prod.outlook.com (2603:10a6:150::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Tue, 18 Jul 2023 10:44:42 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 10:44:42 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v8 05/10] parallels: Add data_start field to BDRVParallelsState
Date: Tue, 18 Jul 2023 12:44:27 +0200
Message-Id: <20230718104432.1130469-6-alexander.ivanov@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|GVXPR08MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2d0c8a-ad24-4028-3fde-08db877bfe45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjj9k1GVAo91Ruj2F++YmT/iZcEoSja9AS/F4DPHRvPx1+kYgPWuhkAOk7+RrpPNzlo3L/kQVSwmf4MlZyirKjxBPsil0eZyN9Z3j+ND9TrJYkBVCI8ciAGelJl38IEiJf6BSXttIO91NTWWlePOQB4l3zFddc+VbOu9SKvxtCFotjsEukWlEG4ZVIJaMlZiicriAbugAEb2zk/DeYAY0JpQqmE9yLotGg5koY61fz/vF3Eb4+2CUFdWmazt2UAOi3XhWyIv5B8AqkChm0Vzy7DeUdV+A4OBAAD690nVO9Pmo9w8A1U+Xnat22w81IFOpfl+oKlXZhHOE0HzTFMuQv3UZL+qZGP+3DfvZ3BufHoDEPfwruHyy2e7ANJC5LreMBYk7eUkVuPv8VtoGfsfroU/+T6ecbAmMLQAh0yM7OycNF1UZDt3WAzKGxz/a8p2UqmRbCSLD4KdarX6hUll5dwjWGRJff+29oJiNN3jWC91hNoLZsjiFD2NDOC6OkzFWEk5aKbImgLAZ1TsMdq1Au0ujsQGW6q+9aytiU/tSwVC43GKkNxSi6lUAzuQB0eAheMr4JO9zukojc7fTVg8IRbEfPgXPVFAvu8pGu5HQKrRtZJ5zdgIQlapCYNjFaZr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(366004)(39850400004)(346002)(396003)(451199021)(86362001)(2906002)(36756003)(44832011)(6512007)(2616005)(186003)(83380400001)(26005)(6506007)(1076003)(38100700002)(6486002)(52116002)(6666004)(38350700002)(66556008)(5660300002)(6916009)(478600001)(316002)(66476007)(66946007)(4326008)(41300700001)(8936002)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uwcGUrIAz8D898qEyxoK+AUCi1PvV3sEx+aag4LIDt/l1JrKRFBiYK/jnUkX?=
 =?us-ascii?Q?S4Fdl6+JMWlOjEYZ56/7I/R9QHvjXO3u9kkws3ileA9QRVuamKnZTwPbT9ee?=
 =?us-ascii?Q?kriJeZHMKitJcFQsBkf2id8a00+MC54XjKmUQUUq8572ozv78tYzs565tFYq?=
 =?us-ascii?Q?e7zNJGEPqmyC0seVwyR1PXvW6Vg+vyVOLRfNNSgJT0cS6G4+is0YIf77JCAS?=
 =?us-ascii?Q?Qr3tXoKxyy7C9uPgpLIpTSq8toJD0Ek/L2khnE59MMcfSSyoOjyRLzXnAnSl?=
 =?us-ascii?Q?S+/0AEVuvWUvoltkVxvkI8oEFQkDuufapsZhNKziGUzH7zgakf0DbdUaxYOF?=
 =?us-ascii?Q?vBgOeVvyS6HOoUnO045stTrduyG84E4yulWIWzwcqY8h/0iXgjbTY/lumcog?=
 =?us-ascii?Q?OAIHhIzR18F0SjnCBl2NO1SLFvK8oceP1s/Y3soka8r/4WyHtEY1NF4KIusA?=
 =?us-ascii?Q?HmsGUWoyP2r5SUod5Wv+vmWYveYj8FSfaoEK2KBy0Abopo+ElcB9haKt+PSn?=
 =?us-ascii?Q?QUaSVe1xKE7i9nQ92HjD+/VtgUWBFKcF98K4NB320xJupI1+Ob1Tkw3+YtUQ?=
 =?us-ascii?Q?rECIYj2w6KWbyEf1ANpT2QWsV7DL2T6at2RTmEqFkmMieGCgsid4zSdoN2cg?=
 =?us-ascii?Q?xgfHqczUvYWDk5895CizuMF1XFdjXJUvjaff1ibDkoQsvAQ0YAG8Mpwpx3n8?=
 =?us-ascii?Q?+RWlxEvjZDG5QOHTHeeqXo9bDkCeRBq5BohvlhHo8ZifsMi7IQo/XRi+44lX?=
 =?us-ascii?Q?vV2u/J/sJgNAJHZ6ZU8PsQlChn9YoFN+/QBt5O9c7Mqh4aucKaksocre1m0e?=
 =?us-ascii?Q?UkVSRaFwYiyNNarImBiXAkztI7KYNuCK6ViNwrLsEDFt1FeYUrO59i/BeFDn?=
 =?us-ascii?Q?JI3lxv60Vc7OZTosW29Y1vvWpPx9xD0ye47rhbFwoiot3p0YGrertxXhm7sQ?=
 =?us-ascii?Q?88kHJV8ssvt65nA9t5xaJfMlmn7gPXSIoA22zZ0QwdsxtJ62/5v8N3oOa7Bk?=
 =?us-ascii?Q?pKK99c3R5cYeVVqqOUdnQiMnEEf4dXsmF8wHeaCR7chd0ntnSVOdmgS5C+9D?=
 =?us-ascii?Q?lN5tyrR3VXcNphMAKp/0gfY3xZV8wIp8q6ZcmDjsRCni4dGtITE6gXOXoNtM?=
 =?us-ascii?Q?LlwaMM+XdXPT0CDmZfltx7NYhqpIh0Xw6yF2Jk+P9OwKV5TCnYf4fe+DoVmX?=
 =?us-ascii?Q?IzPISD9kh2TvhpNJ5QzNEMGBzOVQrXbjFxDV5BHoVF8vGItwqLUdv1xd6lrU?=
 =?us-ascii?Q?xBlI3m+g/kZ4vSbb3RIsY3FuiIh3bzQThi3kiCLsKxit9qMco14DJMdM69Ie?=
 =?us-ascii?Q?hWYTtR4Y9vn8PFecX4ACpEsPoHWirkbkGzy5lu+8p7PffOjjg9ZaPgbJLaV3?=
 =?us-ascii?Q?ePtg06B8PO21l7IGDBHN2etr+pyDNnE1IZyYk2OoQFlh/AXLGMeEXgENppd0?=
 =?us-ascii?Q?lh9kctdcWD7IBhprv0Sby8P87RT03acPV9DOoSIHJqCTwv5XUe4eHkrDTpp0?=
 =?us-ascii?Q?sS0rRzIMxDxUqIULdD029N4HZ7mcQyO0u2CKfeMvCFijnBUG3baIBd2pTDm2?=
 =?us-ascii?Q?BrF63b0hH620wlyDy0YWqWYx+UUW+4b9fGNMaTvGcFT1OwqCOfi/jIhaHjqE?=
 =?us-ascii?Q?0rzAQL9xGHerPuLZMy5AbAY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2d0c8a-ad24-4028-3fde-08db877bfe45
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 10:44:42.0706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjaYGS0QtJyWA3hbnA/lRtuTZ8WnWgCmaivMSs7MU/VXTvuD0ylczv4M9mz/B+2cx+54pD3o6Q/V5XIR/s3dd4XPefSBjlJjdl75eWGgz2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7894
Received-SPF: pass client-ip=2a01:111:f400:fe0c::704;
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

In the next patch we will need the offset of the data area for host cluster
index calculation. Add this field and setting up code.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 7 ++++---
 block/parallels.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 8bb5d115fc..f7b44cb433 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -868,10 +868,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         ret = -ENOMEM;
         goto fail;
     }
-    s->data_end = le32_to_cpu(ph.data_off);
-    if (s->data_end == 0) {
-        s->data_end = DIV_ROUND_UP(size, BDRV_SECTOR_SIZE);
+    s->data_start = le32_to_cpu(ph.data_off);
+    if (s->data_start == 0) {
+        s->data_start = DIV_ROUND_UP(size, BDRV_SECTOR_SIZE);
     }
+    s->data_end = s->data_start;
     if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
         /*
          * There is not enough unused space to fit to block align between BAT
diff --git a/block/parallels.h b/block/parallels.h
index f22f43f988..4e53e9572d 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -75,6 +75,7 @@ typedef struct BDRVParallelsState {
     uint32_t *bat_bitmap;
     unsigned int bat_size;
 
+    int64_t  data_start;
     int64_t  data_end;
     uint64_t prealloc_size;
     ParallelsPreallocMode prealloc_mode;
-- 
2.34.1


