Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BA97D9042
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:48:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZJ-0007Z9-VP; Fri, 27 Oct 2023 03:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYr-0007Hm-Vr; Fri, 27 Oct 2023 03:47:23 -0400
Received: from mail-db5eur02on2072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::72e]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYm-0003oB-R6; Fri, 27 Oct 2023 03:47:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdS5N+RILEeVhraAAN/aEGHrL2EuPJAJ+AvEXwSdqZ24e79ELF+ITAa4JSBCzcsmTEqATGOfF6jeXK34deUnCwgvjM0svJf5ZceW/zrHf8ii0PCalf8vqAZ7uPVr1F0NO1B9iDXcLMLC349PZ//EvkHyTDuUXoxT8dlwCBDpMC5jWedyWyHB+NTHThA4lkX4TRlFzKsxKChQeO79NP6G05ivJQBkyFmYDJidND/3nBMW7eSXTWAY5e7ehAqrpv5WpHI30gwFDEYs6RS5+l1RVCQ2ehWyw46kX4OcYDrcNy6lMNaKt11/veAIXYLkopZd2gfUlDiw5gTkKrI3mheZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QE2iCla6rY7glxNoISym/FTt+shMMY16xHIaDHHE84M=;
 b=fdJ+Jv/al2rgsBdnInGSdgKIT+V08U6i37nrA+ViRPhjQRn+D+7f37QGh48GLhPUjyI6vlQ+tsCzQZtWJ1obwqvj17kdpjd+qN0xmdsqk2vTbaJd10OAK824CB/7LjXi71FKXGzVx7bUvkvlQekHSkvu//yC511aLKMCy5AblP+ZiEnmntIXUT7rXgSIfPsbSpOP3+BVlZcaJvW39jV74foLgLTw3ybQhH3gvwsumTIiQ7JvVA4jgMHA37BHX72QVSupm8fBJgYPXhwgoyF8fhSCZQZS/yiclLgiPEZmthLtl7qk7x8btfQpB9JG8tP+tWgioROJxEB7KvpLfMhuTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QE2iCla6rY7glxNoISym/FTt+shMMY16xHIaDHHE84M=;
 b=Cziz8zyrQ4CtJPpAXi0pL1N8BaA2RgIattQIDPvXpLnu2UlB/ep4m8ZhtBRMEkRLvaoWbYRUOyCtY24cXnDJnCENt5j2sGZG0zi0t6fhrz9ucroemsgILm8f+r4PMHclupmLkcldouhN3FQ569VdqAP+/5cU2uj4bi51PEG62/BGgofMQQ0UX5TEbvlS6sp+IiR4RjUQY8ezySvsC7AWBQNTRHq9UdJHiAegLmdWXmoC0/0ppQt5P+IKcpUYk1mkojXJBmxyC1RM2gXiwjSmsupJYMetNBMJsL2w+tmcznOEMmnbb8H21sEZptRdzMVULkDjWSZZzcAdvroDzTspVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB4PR08MB8056.eurprd08.prod.outlook.com
 (2603:10a6:10:387::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 07:46:49 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:46:49 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 12/21] parallels: Let image extensions work in RW mode
Date: Fri, 27 Oct 2023 09:46:27 +0200
Message-Id: <20231027074636.430139-13-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4065d1c0-03bc-46bb-f418-08dbd6c0df71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gl4lnqnz77YRFfu/gwT+awJHraGDHdfu4GlH1B5gOWRzwUnP2cPsyNrPRqY+ZjmUDlrYi4j9Rxy7X2QMvoIsLz4hNVD2brqXCSVg5Bk2CqLFP+n6nD6PP2ustODDR8d/hhrUwU87ERAZs9WfelQDTzSIxpVDdlZi07cYyOjqZ95mkPR1M+PF3BUOHRYvzNR4I4tZVUk0pn+vXY7jrm+VWmhbapf3Glr/Vkne5lpkMixjgbG+ODY1rwGppx7EyBBlrJFbOJcZV1vZ3Tb2ANQZZMYwivTJGWr26Bl+w3zVq5ad3RshLba5pM9+UcQsTYAMNmYmrGITAdNy1gI7vGD8jlunOSYIrn0mvGreaNahIdEqjh6iS7p79jo4skVSW4EhE5VLGXygpnAW/KRXnpUpNEhwS0Ze6eUkroWeOeZSh5IOALMRzouguFcf/1d13eGDIhrHmpsEWIbT1+o1Lu24XGemW1K4OXsI9UKBSTJ3T/iuSKO7shlFo5gEa9eNmZ0Zg/YGATFU9XfanjfNX8zWFV8GmPHbt1SLiugrKke8vR3K+MDIR/92lxI9edsQbGNal46vjam3tni3nSbB1ar/l0jv+waApZqU/fEBperD1KXOLq/F0pBCPqMhY+R5uyARm+OtM6GlQLlW/DDJW76dBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(6512007)(6666004)(52116002)(6486002)(6506007)(478600001)(38100700002)(86362001)(36756003)(2906002)(66556008)(2616005)(26005)(1076003)(4326008)(8936002)(316002)(66946007)(6916009)(44832011)(5660300002)(66476007)(41300700001)(8676002)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rseseDY+KS9icM/SCrb/btqHJ0q8iLB+w8/kfMVr2PlnzOdQd5mqfS+75bn0?=
 =?us-ascii?Q?TchX/nPiKp8v1+2/LGbrzoP6iCKLZjeh/+dfIo0kEn6mciD0u10EeCYoOJNL?=
 =?us-ascii?Q?ZvQGVwbiqVxb2pgQNc4jEfy3p0HKfU4KgbpkhT6mFRzKqYz9ka1lUAM5OvdD?=
 =?us-ascii?Q?fsuRCALfYlJFQkxnNxDlN611bs73UWsnL33t9QsmuVLQGCSyOw2p0KkY+Zhu?=
 =?us-ascii?Q?imQorbzqbIu8fYFrw5DuIKgwDpNo9vnGMV9m01XjGI3WjNgEUk/N3ZfDNPCA?=
 =?us-ascii?Q?YX2rUcTLQzEXnHRptuHE0oUKIl2ZcNEfk7uidBoBqvhqoT0tKc2snp7dqTmu?=
 =?us-ascii?Q?MjUfI1n3A/lm3PK4SG4Z3gDHO/gJOmwP+Q0MdIBj7u79CMFlf02xEKaw3iah?=
 =?us-ascii?Q?OdCuJdfFvvb1xcmBGWTF9/Nh9p2wTEHbS0Dn6r3VEvbO/MPVc7ix00ymzbtY?=
 =?us-ascii?Q?afKS7kbZ7GgJpmOHy4rwcfsqFSnmlCT0rYk/BA4A+DT71+wdzOYzzwfbttHx?=
 =?us-ascii?Q?AtRj6RUqkldjs4D3OT9AAE05IO6REZRTjW2pnmNNAki7Gr6M0FEXiTes3JWm?=
 =?us-ascii?Q?x4RuYxOgMqTxv/MXFhvWHPWYQWkS4VAEFZ4PGq7HYmNcAFNrMid8dOH5ffR6?=
 =?us-ascii?Q?dErGVHpz4sx2NXL2D/35GQlxZBFPV1dU3rDdSU4DArPwvCUJgj9WrnlkAWJ+?=
 =?us-ascii?Q?wgPFeIKmD88ADPgpTUxkSS08PlrwLIYrpTWyPUMrYvQHJBxsj07xeTOiRZVo?=
 =?us-ascii?Q?7lxj0bRRZ+0vraVXWDOIvVJZ9ebSUxQ8X38Rgt0M6Tbt/FLNaw2yOoEl5bw6?=
 =?us-ascii?Q?SHj5Mc6IW0qS0ANnknNcQRG0NHRmwA1rYiTbe/BXR5VrUttLP++4NXmpb9el?=
 =?us-ascii?Q?3D0zSXCbVRbxQ5I/H6U4q+ocQOrROOnLJJWyqJjsjbQMsc5Ulxcj0bUljTEA?=
 =?us-ascii?Q?otXKH0J2bI08tTrojFi9XlU7TsDfk0PKtf2wJrImwqJPl/RlonOXXN5xmYGP?=
 =?us-ascii?Q?/Pml2TBMKc59cEtYmMtPkvYVsZxy9KM8oFJvu4GYXptwtzxLq83WIC71s+kb?=
 =?us-ascii?Q?vhxhEIINZrGxRIG7Yzxpw6323jFJTT3AC784OtGBomsQ5XjZoyERMukuXIK+?=
 =?us-ascii?Q?WGFzb/00HK0a8fogE8VJiYsZhKbo8RfWpX2+ZWYP2uqYr0lR9N4NU5zJTXFm?=
 =?us-ascii?Q?Z7IUBlIRVQrhqOgkp3w3zZzFZ3S1DHyeOGNzXgaUGMyAu2ofxrOhLO6xb93+?=
 =?us-ascii?Q?T8fY3rFTe7If66zDWNFm7gQejGPqt/UDX0Pco7YSF29n4aYkNIkioaFvAp1g?=
 =?us-ascii?Q?2BAb3ZZUgXw5yCFSO4dKuVIohmGaVA/ojB73Tpj0TQROUv3j7qOHuB+Sf5Sz?=
 =?us-ascii?Q?B8aqkYwjpYczQ6VCXVa3kVIU1svwTgW7QGr/aprE4WEfvuf/FWQMQCo1ZJ3F?=
 =?us-ascii?Q?rGMZw6eYLuip9KJJjplTNEFwNTh85FGqxCITYp+YMf6eMNcYiOU7x+p+ahRd?=
 =?us-ascii?Q?bGfPogOGbWrVl/QBD/XXT0QbX8qH9UdE8TYp4UnyHL+bsPRpukRV9B9SNzDl?=
 =?us-ascii?Q?OFx/wZKvZalU89lBu37c9yjU1SAHSA+1/pN71iZKmoqN9cuXPaa2ESBjRTtI?=
 =?us-ascii?Q?F+Lsb0Ut6AXGEQiCoWDkD+I=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4065d1c0-03bc-46bb-f418-08dbd6c0df71
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:47.5025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0HmZlQUaxlqlVf2mgK2xjyFimF374kI/mYaLI15xJO088j1bMFcGgm64luQMtpbr4XO+C8qhsd4YhDtBqpLuTk0mpsFck/jii0XUFRuuhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056
Received-SPF: pass client-ip=2a01:111:f400:fe12::72e;
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

Now we support extensions saving and can let to work with them in
read-write mode.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c |  4 ----
 block/parallels.c     | 17 ++++-------------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 0a632a2331..a0de4f1b07 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -177,10 +177,6 @@ static BdrvDirtyBitmap *parallels_load_bitmap(BlockDriverState *bs,
         return NULL;
     }
 
-    /* We support format extension only for RO parallels images. */
-    assert(!(bs->open_flags & BDRV_O_RDWR));
-    bdrv_dirty_bitmap_set_readonly(bitmap, true);
-
     return bitmap;
 }
 
diff --git a/block/parallels.c b/block/parallels.c
index 4c2cb09e43..0a2956b45f 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1374,19 +1374,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     if (ph.ext_off) {
-        if (flags & BDRV_O_RDWR) {
-            /*
-             * It's unsafe to open image RW if there is an extension (as we
-             * don't support it). But parallels driver in QEMU historically
-             * ignores the extension, so print warning and don't care.
-             */
-            warn_report("Format Extension ignored in RW mode");
-        } else {
-            ret = parallels_read_format_extension(
-                    bs, le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS, errp);
-            if (ret < 0) {
-                goto fail;
-            }
+        ret = parallels_read_format_extension(
+                bs, le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS, errp);
+        if (ret < 0) {
+            goto fail;
         }
     }
 
-- 
2.34.1


