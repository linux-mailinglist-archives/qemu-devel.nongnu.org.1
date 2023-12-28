Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B46FD81F6D1
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:17:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInON-0005fU-SH; Thu, 28 Dec 2023 05:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNv-0005MP-86; Thu, 28 Dec 2023 05:13:04 -0500
Received: from mail-vi1eur05on20707.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::707]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNt-0000Sp-Ky; Thu, 28 Dec 2023 05:13:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzBtrv+FYoKdjgn7ZFSmoVkmZYrgbqnmj5qbKFgtp8+OoW2opQTINYN9uYtncLqBKSLmzG9vNab6vBZS11nWuZMngQKMqxhLiu5nhZNF5j3w1ntdYTpSvu9505cxso9J80poCJu0OD9b4O42yEg6Wgti8TTfgzGyoJ92Pl8GghOXCmJUuB5/X8oUdIPWb0JGpJaOro7gUuPYTMKNRd3Q152Ayymig0SfMwQoLWxQhnrc9XcxKzqJmTRrjaR9D+lvJF634S68u6sdFVr8jsLJRES6/D8v/a8gyRWGFwqLdOgy2zSVVDDrtA4NArKp3XDhiWkZGp7564x4B8/VqGcnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3JRRZLsEPXH1NNIs6vNbF/7zbteI2Z70fhLrLAUmgc=;
 b=ghomKrYuOTyiO4ApNqYSsJBU9QTqoqbr9UdYR27DKsT8bdmqRUa6bpymvhcnqC03UOkdIuSvgnnPoGj8zGh0CCKMRQUPE3HLboa63pA9ipXWXaw0JEuxZuSUpFX0mYHytX0Ob/1GAg1KH0QOc2j4QWtzSqzt+ILsu0LxWNDYgMRK5Ii43dVN/0wRGoSKDc++bXQkuSprBLl6mFE1SLaf7n6Sj3NEbyzu5G1chLE3E0RFLsgwwEJIosbpy2U7buh/745+4wcsihdknjfHAOwxGPJwVh6ESVToFIcXutsjMGU2lcMQJ6PEsZKPFLJQjl7lnNJzFy5lIJbsHJduLsvW3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3JRRZLsEPXH1NNIs6vNbF/7zbteI2Z70fhLrLAUmgc=;
 b=eqDG8qNHq+ABQu0do56Ou1efeOI2GX6UyRuYDwVd7pQ3Z2qVGzwfJt/9Q3m59lTBXzfkMS7ArrwwFjbjDbMXL4O9+COQW6mhwh4NU8vbN7tC+hZPMOZm1mwvjEPXoq55mqTHuWPZcXqQ2LuWbjb/Tdnlx/8ydC7DbWUTfIQNReZcarYIUiGIRN0rXsv/kfO0YZApoIH+iHlMppIBtlOIGzFWX6dBhG+UfmSmX0jfWaitL1Tg3KiyDGmxf5BCkz4ulDtTnLpauIc6rLnvz4nqK4jtqxGKgLqXWakvV4eoGZtpe9X24KVMogq4ACbAMwBg+g3glfYvCNlAWAAKwNRu5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB7459.eurprd08.prod.outlook.com
 (2603:10a6:102:2a6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 10:12:45 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:45 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 10/21] parallels: Create used bitmap even if checks needed
Date: Thu, 28 Dec 2023 11:12:21 +0100
Message-Id: <20231228101232.372142-11-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::8) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PA4PR08MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: c878398e-0aba-4d74-e686-08dc078d8936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qX5l26dWspE2W19UZQ675sIqO6xoD1j/n4Lrt78ewCZpeNMKLQCzOsD/hx3T1OAf23/H81ND6SKb9JmOPvjZxIzEQCL5vXqon/AKbdglo2/rJdycXKhStWMlwTAJTy9VBVZ2Kv0MK1KZAuX7UDQb8swuQp9ZYT4cppGMknyF4WkPabrUeegXtYmTz1RPvD5mw83jmo/NkNHcuCdtk25TLPX1HKktCuR01Bbh5H/HVanppMGklbnUWh1l87KKHTQBipFPMYmpgEX3fHxEur0cp7YZiaKoLoOdtTl31mn50vaalcuomceXuT55KYTFInHrMYaYsXkTArVQyIrludkd2TTCuD5syroIlrhMe5Hvnl7se7LBdxPjPPqEkClVkx5iibZ30rN0+04YwA0hf89NaZlfxrqSMJ+yb7MTk24E6+vJTXfvGrY8kPh1C47nV0gMKOGT2WeGDMEY8bgnEEL8F/NeMqYfNLkyJdmjy7Qy0ET0FTdrHipgtJiZO7TsKeMK5TrJ8Sy76FJkGqxu7moaLL8VRMdAnWyTcNCkndOiOo/m0N9xiwLu2mRZhn6vEDKttgi3bEEtZLZbKKW6eLzOtbB0RmbGqBTbYifRIUT1Sw27KE6B96oCX3rS9plx+a+d
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(39850400004)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(1076003)(6666004)(6512007)(52116002)(6506007)(83380400001)(6916009)(478600001)(4326008)(8936002)(8676002)(4744005)(5660300002)(44832011)(6486002)(66556008)(66476007)(66946007)(316002)(38100700002)(86362001)(41300700001)(38350700005)(36756003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j3McvvMQp9JGXLJjbAiPoYSX6VtJFAW8lsdHQinJxpk2uXzCAuQuso27n/Ao?=
 =?us-ascii?Q?fykbrzUdB3XplLlEr/xWk1HqvPwlGOt6AYvGdR81a3AM3HL7z7PCMxoj8LVU?=
 =?us-ascii?Q?dEOXr2DC2GOrMp1HPDio6SER+VcWzfNOKExcZAjGtWKuJPa1RqWLFE0k1cHL?=
 =?us-ascii?Q?xYsLneHHSsYLqPmudv5xLt1c9uPt3STBqrog0uNf5Am5zh1R8TOA0ZbHkJa8?=
 =?us-ascii?Q?8z3wcNw94lKdmY3IsOfskFuxhWtSmSgeK7qMBZ+Tq9ill2tVDbtFdIS1DCJ8?=
 =?us-ascii?Q?dMwTdCzPSLskvMpC6w44r+lU09Cc/OF2eBGGRCG+OkcUWXizlKBJvP/VHsaM?=
 =?us-ascii?Q?+DG7s71Lm6vkphxM0mNVmZGxUP6ohEzTHfj66dXg8z1y8eS83wSBqQSwfX2a?=
 =?us-ascii?Q?yiBufTcpYbD6nh5ejXRxP5GnfJfejdsRxxbKSm0+H2PUBJcnf90fY9GV2mlE?=
 =?us-ascii?Q?n7iqfpn3WlurwFOfYEczO0MkHMKzCKlV9JlsDdVxE6kJf1eoR34Q5AbD9Yuz?=
 =?us-ascii?Q?uBZ8X6OpukluptjDMWlTFSUo/FowXZry9W66sHTxYlIt+SVfHrAXcgy7xWVx?=
 =?us-ascii?Q?/7gq/fUdy/AP+/mygrt1zSzIyLyhV9ei5UTEG7bH6uzT0B5koIK2gZZ1N6uX?=
 =?us-ascii?Q?1Jc1idsEOL8MYpHUhTSd6Oc1KLQxGAL56w5D5TvqnAHN1j61TQFvTGfy1ElW?=
 =?us-ascii?Q?CEr4Emhk1E6dO7XlBcB6YdVIqlGZublHGTrXwLr6pdY7H933O0xyBZdkLei9?=
 =?us-ascii?Q?B4Po+977co2Tm7h7B9hYn/Sf9lsbB2QKV5jJ3G79owxHQ55PLlhmIb9YlbCH?=
 =?us-ascii?Q?VwRL/G6Ptj4iS+rXloBEF5H9cEA5HlLkOXmS72mcJNC5BFxh1wuSJhairxvE?=
 =?us-ascii?Q?TpbRYPtKi2QF0Sdmbuc25fg2/sEVitK5CoWt7Sdl5FecvK+ujFRwY04UgY++?=
 =?us-ascii?Q?r8TcoBe1/UCN1NFhclNyn7fUG6ap3MrCYh5GedInswl9hGicLlvuHtNf5WMs?=
 =?us-ascii?Q?SM4ezgyQijurqh41IDxFgxKEnf2TnP/bIV7+OZ/SSkcG5XD6498MABtepaUN?=
 =?us-ascii?Q?A/iaaY+ymKKNQASwuODmY1Qootz1/5orMby1/yf2WwGj7IBRE2z20Xf+MW+5?=
 =?us-ascii?Q?6DlrrFJA7elP0AILDSYO4/ycDffjLKCDscyp3Ep1tnTXIuYGUtJ4Ey0cb+tZ?=
 =?us-ascii?Q?7wj+bOrDAWUzWHkW9pF+kpCSnQ75TqMwW+wlAiJjU50/L21Y65xQFYmaYdZU?=
 =?us-ascii?Q?a29tdJ4IEs1Syl+vLduHa0m6trduqRGPqME8uiYobuEv5e6TrWzknLK719LY?=
 =?us-ascii?Q?v7M791htvuJ1eRVU3qVuJMwJYhqGego9+opAg+RO3yyH83C9D2YRiRibVb7y?=
 =?us-ascii?Q?giq6bwq8kxXET2gsG/vpfAsSgDFd/0s3jwTkID36EEXt3rwdQ57Jzp8TnBGH?=
 =?us-ascii?Q?g75yL8NBz4Tk9CpduWO3/x3Duf2MSp4xcKE3cMeJ6EwiqulcdZU4M5V+J9iu?=
 =?us-ascii?Q?XZrJ0hJPS4LqcsYbKHZjBc/BYKJkVZNKN95y/REapMObwHvV+2PJA5OW33dI?=
 =?us-ascii?Q?C/kNJwCssHGBdCJb/+Hbp7aWzWjLVs4+cE06mKVTT5XdXXfcfc4+daaNPjjZ?=
 =?us-ascii?Q?/M+iQfAy8GokMyfqXET8wyY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c878398e-0aba-4d74-e686-08dc078d8936
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:45.5171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVLdprERXsudFmg17iVow2IuykE52b40j+ZN6RAjWotAilnrRgxdDtsmQ1UT2271zVqqnwjn8QUhIsT0b/fHP/O9+ZHHboNeHHBCLulWCno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7459
Received-SPF: pass client-ip=2a01:111:f400:7d00::707;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

All the checks were fixed to work with used bitmap. Create used bitmap in
parallels_open() even if need_check is true.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 0ae06ec0b1..f38dd2309c 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1421,13 +1421,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
     need_check = need_check || s->data_end > file_nb_sectors;
 
-    if (!need_check) {
-        ret = parallels_fill_used_bitmap(bs);
-        if (ret == -ENOMEM) {
-            goto fail;
-        }
-        need_check = need_check || ret < 0; /* These are correctable errors */
+    ret = parallels_fill_used_bitmap(bs);
+    if (ret == -ENOMEM) {
+        goto fail;
     }
+    need_check = need_check || ret < 0; /* These are correctable errors */
 
     /*
      * We don't repair the image here if it's opened for checks. Also we don't
-- 
2.40.1


