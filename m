Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E54D775797F
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:46:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLiCS-00027Z-1c; Tue, 18 Jul 2023 06:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCQ-00024v-8u; Tue, 18 Jul 2023 06:44:58 -0400
Received: from mail-db3eur04on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::703]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCO-0001xm-Qc; Tue, 18 Jul 2023 06:44:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHpUKeDIIolj2fvlat4Ot++u5zQHlFVXeb9DzXqWHIUXfuLAHLoYI3nH1GcLm5GfhdL5ynhcRFKHk8nOgtQwEJ5onVv/t4o+ByocTwkD03eApAdmYcij20vGV8VJ5A/EvLGkEi/V6BdzcLhVyoA95Y1KufwUzrwtMhQVtQAGkHk/UcZKcs+I1tC7AAEOJ7RZZj0RmsPPgNySTeFa4hY3hP+7yTtYG4Z58eaucp6l3JlqfnPQPMo3ODjOlzy3Ugb/8eWSynfa26swYJWju5rRa8jqJhLoNS6uRBzFDn4XUjArgJqLxpdVOYseCc9k2r3lXA3cJaRT9K9ECbsmK3Hy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dG16+u4BMTFpxqaFYEey2g3N4e6uYVt8Sgm2cD0F/1g=;
 b=Qgb9T9k0nf6lJqPD01IYJ34wMGqghgRnz/sZj07sZzaDknQTK5hDhoZiaHdf2KA+zcCTLxq6pja3bo8n1uQGbA6+AsoUsZ2j4VjA8K+eQlhYqjejgmxmXOycKyMOWRA4yq4+qQPpaZRjtz58A9MlUSUTvwiSBR57f7RC9BBxQe7dSkV0FK52zeMWR0+j38NcJdEk/m4fSEdveyRFYSBVXvVvRTLZX7dkBE7MclFdVMkcq3epg3nCv8bqjz3C3GVLcT0WN8tCshX6+gvW13U9ZgVMlue1CnFtZ/0t26/Tm9s0tDJKNPdjP/RACtbFKX9brxi+5vL7Eje2XgDl5y57Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dG16+u4BMTFpxqaFYEey2g3N4e6uYVt8Sgm2cD0F/1g=;
 b=xNk3cVNg716waLY6oZA28mH57svRERRM9V2exqmfQCMbEwJaeDUGnZMXc8k6z39SL585bzyIYVTpWcuZRJkxq0pdjHKQwdC88rwQeY6oDpMN4VH0APG5eOgkj22Jj9QGQwwY/ACk7npo18g4NjN1LFuh8NughAbZVeYYOTZHl81B71eFwaE/UfeMnwa08omohl03iNqjM9JxHNpxYdswPXEcJnXZ7xmnIO745W38RdwAlihTqGpN783qNHOcL4H47ewyEtN6wMSzYQUcrMMx8KwWpiQp19ug9eGYMP4mAqPzNngy4npfNkjFIp91D//buDWQU8N/Z/gUTB+Rh0B72g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by PAWPR08MB9784.eurprd08.prod.outlook.com (2603:10a6:102:2ea::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 10:44:43 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 10:44:43 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v8 08/10] parallels: Use bdrv_co_getlength() in
 parallels_check_outside_image()
Date: Tue, 18 Jul 2023 12:44:30 +0200
Message-Id: <20230718104432.1130469-9-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6f1a56e4-f7dd-4ae4-6289-08db877bff38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwC/3uAsY2ovZYyBICLCwU98yTYasKrJWI7lrXhIzzY8QKt7I2TDmV9EGOuXYZQsUOrw5QNj0hg2h+N2LrTShDIe3IHzmQDWZMo3AZddwSem6IbWSK5h440cMP/e2HEftQiWO/FTU+zmes6Mi2XI9eEEI9n47Js2Rt7fY5zaWlYVSjxUt+BSYm2pzaaLFGqFtBaERZrPHvLq89c96tXnbP2b80p/F43ZsyzmlgXecmxD2k8XDeQYc1nJf5MZnG9pHBJQJ4AXQjT3+MaAjQBq/njWZac8CE4C1m9k9SgL/ircBxq+SYjfic3u5h9NW4VBwFTBle0gPJCwNK9NQmtd/peTvrtngqfpf9clRN8gHCVYwG2KjZOouIkoDr36CnnIHpZ8xGMsH8bnV4o1jirZxuNcgQ/YUNHldKxVBgS4sX/GykGGuGblGigbrhOGWvY4wczvO4VfZ3qwH6PdQftYymICAzScfoWCkCiPnfKRfA0tNKJvsB5FZ/SzT45CLp4SmUJ3m+8xq5g6lOFlWO5hm148FBUlDGOC4D5any0xuqxYr7wX35kC6SXYNiiH0OGdqa7pizU9Tk8MOA8eOCchEfB2gJZeb5wgFKLxjHvBWFTbofagijRPCChNlGyh+ufb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39850400004)(136003)(346002)(376002)(366004)(451199021)(478600001)(52116002)(6486002)(6666004)(1076003)(83380400001)(2616005)(36756003)(86362001)(4744005)(2906002)(44832011)(186003)(26005)(6506007)(6512007)(38350700002)(38100700002)(66476007)(4326008)(66946007)(316002)(66556008)(6916009)(41300700001)(5660300002)(8676002)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uUhQ9nXT5vIs55hldmoHyd+bsXLcv4yONsi1Cktn+zNn0IeCzBrdDSl5kYGN?=
 =?us-ascii?Q?rAW6UtVgb9z4RmhVWQgv1wKeaxIAqCMWxRlsIAu2tEwrGItVdQQ6ml61o9YT?=
 =?us-ascii?Q?0XFgy7M2QA0mb4pywx8csZS9S0jottkqL00sFflYNo9KxY7HUnu3adgS3U6g?=
 =?us-ascii?Q?+Z1MozDvGstFkU0biwGQZGOte9OALer/uU2bzn4dYlTHqSMw6kJGQjCzVQe6?=
 =?us-ascii?Q?WpMmLVL4QlqJodEDLCXnoiq+i2nndm0KxerSs45XZt3oLyHe0I/aTmFS6z4m?=
 =?us-ascii?Q?h0SIcCpRikvm6wWjanDIe8tJkdc0nHX1jjom+oULL0dBkRzIrQsjS4KcsbaU?=
 =?us-ascii?Q?xUQH3Zx5uuqV4up8GJGeaC4BZyum9zjLVqSiBozw7Ac2VeX8h/wWBt8r6BY1?=
 =?us-ascii?Q?rcoQzghpGNqoAqybYvJP9Y8pQZHI3POHaFQUbIBO/sq4T5kVAJUM8kvz46Ep?=
 =?us-ascii?Q?hP0EWq4FJ7Gvb8D98WClHc71QkAzrhrdUiMETMlTzD3dRke5iqn+4gCDZukI?=
 =?us-ascii?Q?gcLBNJw4MiMpDxjF35uz3kHYlbRy9DP1A38lCiaNypyFI4j2JWJyjAZhuxX3?=
 =?us-ascii?Q?6wqRQq6mrWxbbDqMhsVLWn84jm46j1Zu+wT+EDjhTFrro7moV1d62L/MgQNL?=
 =?us-ascii?Q?JMFd+5sRTdWhhxTGBj1X3u+LqKe1ZLMYmKrBH/1NCleFR/253fri+5K/CsX7?=
 =?us-ascii?Q?cS6bNlaSs/4dYKl8SHl9Ubrsd5a4bBCEcGK1IDyZFAUyLP8IGjP8TvEG9Ih8?=
 =?us-ascii?Q?hs7T73C/jR/ZbsKFK+ljxv73Aw0wVkON8XbJHrLXdZpg+Ppecn/z268SQCsD?=
 =?us-ascii?Q?D4X0BZeT/w/AJ/vEoMX10o+gJjc5b48DpeHyfCbdExMRw4lBifbtwJ7MMD0D?=
 =?us-ascii?Q?NcPexCGosOAhjkDN7pe+BKFtW1uooUPltIi+Cnfibd9AuOE55DY9R5JTt2px?=
 =?us-ascii?Q?dtbz5A7JT+8ZjmONbA2cVpjAUaHLUYAXWqJAPh8lW82DS/SrGnNvGK7W/PbM?=
 =?us-ascii?Q?WvjiZ4FruqfEisOSaTOBIybOE3cAVco/FtuqJIydbj4IuDrDZxQrLz3mbU2x?=
 =?us-ascii?Q?2dWOdaw9K97PMCoXwV/oh36oAW+hkUFMpUiZM5b6JYqZXDMik8bLwqV3NTxe?=
 =?us-ascii?Q?nr5DHhkDp3POveEftCGXnFr5hKcclrHqbwG6f2F3jdSsdi+QsOkidePhFK6I?=
 =?us-ascii?Q?3tHpgR882K22xYKe89xg0p3edRh5t0ltejekuTJr9m37nWL6SJvp0alVP1id?=
 =?us-ascii?Q?yqm20TADcx92Ga9+WA/LMKr8H0Noq4oHU44va09HSB3y1+3t+Rn7md+fmeuX?=
 =?us-ascii?Q?DoWlcRwZqwtEHQCPnCEqWeUDgZJT+DjKBzps0uPXDsMRsm2zZLS0gVVJigTv?=
 =?us-ascii?Q?3s5qJoKKDZwm2GMEYCH6DujgWiCDnXrxK3jhGDq6xLE7x2ZHsuEQvxGtSQiM?=
 =?us-ascii?Q?JMKUVO76MxL/hjw/cz5b5/eZjcCaR1tckfu3F+FN19Q70OSW/0TByb7cUBr0?=
 =?us-ascii?Q?jVs5gzpYudM0hr2OdQ2YCPXjktSdtlJwDg191/VQimkiMVa1Fjr4frPuCOUZ?=
 =?us-ascii?Q?9wRVQhHoCd/x3idBGlvO9bp7N1NOJbYNrLGcUfrzhcEi+4MNryFocsz/4JKm?=
 =?us-ascii?Q?j4sUD9f6ie8wjJko9UFEsdM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1a56e4-f7dd-4ae4-6289-08db877bff38
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 10:44:43.7080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TCa0ewEBC5LZZSzlNqmHVwBzQTedvY/aFjn5m0P7J8ecjO/EoX4WTPAXTGcG2ptg0TU5euf4ySS+iMUZ+sdaZx3FTkWe9kkWT4ymU8wy4WQ=
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

bdrv_co_getlength() should be used in coroutine context. Replace
bdrv_getlength() by bdrv_co_getlength() in parallels_check_outside_image().

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/parallels.c b/block/parallels.c
index 5100c8f903..3414807089 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -500,7 +500,7 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
     int64_t size;
     int ret;
 
-    size = bdrv_getlength(bs->file->bs);
+    size = bdrv_co_getlength(bs->file->bs);
     if (size < 0) {
         res->check_errors++;
         return size;
-- 
2.34.1


