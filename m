Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 790F6744867
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:12:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXa3-00010W-Sk; Sat, 01 Jul 2023 06:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXZx-0000PB-4y; Sat, 01 Jul 2023 06:11:45 -0400
Received: from mail-db5eur02on20724.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::724]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXZv-0007vY-Ij; Sat, 01 Jul 2023 06:11:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXVUJR9r5F9fO8NvEBNfHuLmlVrL8Z/TZZZYUjfRNK23fvIdmr8KqSFWqEA6R215w4xuJETduAly8tkc67wey/gU3e3JmSYHAvxyQ7kh2KFw2cbWIIXCMn5iLYQe/h09EaOtS7oMHc6lUGtRajd6tsiC0FUfp90v/XEatMm1an+HOuGNLUfiv//+/e2eelgEVsp3wZOsl6mUotRJKYPo23ryo1AU3vCQ6bcnP9XCma4MR6CQorzeXFjl3FMexQbTn9j75nYzAJFeyZ+oHZuv5zoCC7kvmpYA0fDPoN5HM/4xFW/I1GzlrtlGoetrCNTNT4b1URVlGwUU6dOOzmAL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXgMd70NWa5HU3ws5yda/793VneZcsCeqDTRvomzBWE=;
 b=R2nF4KQNntTRBN0m8VbhR2KRGQCap1Iy0g8ksVavScxe4C8VpT0TaNS3vyfut0tqKoNMcd+6444GBYdW6hGoBN03627a2CDEzQOVnXhLzYEk7d+SaIF546FQ3X95X6A0raCTc9jXMhTMCoP5OeedBAkBy/C749wgE6RjmQP8fLENXr6TnYDhG4yLDoftgUQurzCAO792+BPeCqxPnF3khHSj2RPMd3aGTpVGIZXMvmBibhqBlC+ZvT1WLmmyaB9L3ceKxPyMyxYE+Ke3Yain8qS6tXuYeFcnwdHzAco38BX8Z00OHiuh2nyvbbAsAxPqJTaQdw9LH6OIjDkp20DVQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXgMd70NWa5HU3ws5yda/793VneZcsCeqDTRvomzBWE=;
 b=WgmehIWeGI4Dp4PJSoQDeBQhIU/78qwTLOcQ9sEElFKpCcGt8Eo0DFh2ocx/gDEDddFlfMGqmcCqex0A/r806G9lw1Xg48tw7lanOZeEVSzMDDMy1xdyskMXduF5/fCjAT9rm9i7MFS2tpslI6QjcYHj8+FOq6Cp5qRTIT1J1yNP1XfpAy8qy1qBvq0GN4Nd6TR7DV2sIUXp3ra7Nm66LKKkjYpW14baQfFr1a2ZAfj2A+tTTIJrjVckYCd5dbbUTPX3Kaaoq4CfaLBWJHOtExwPc/wRlZxQ4kKzfsGIjc2ahw+KoWPnTVi/KmcqOvzJSfwY1TPhP+qLgqve5wkdnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS2PR08MB8832.eurprd08.prod.outlook.com (2603:10a6:20b:5e6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 10:11:34 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 10:11:34 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 7/7] iotests: Add test for data_off check
Date: Sat,  1 Jul 2023 12:11:23 +0200
Message-Id: <20230701101123.261104-8-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230701101123.261104-1-alexander.ivanov@virtuozzo.com>
References: <20230701101123.261104-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0005.eurprd02.prod.outlook.com
 (2603:10a6:803:14::18) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AS2PR08MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b88ee7-cf2d-40a3-9d2d-08db7a1b8c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOmqXiKCfCNSc6ARqXpl+Rh0yFMGmXU6NLBLOWn1rnmPicQkCFUqZfVfXj8D6sXB+iwfNeqUupqBOmf8BYkx+kLdL8fih3bUzPLLQbCE3QwjDHZaSZa31jeLs+i2RA4qDu2WYqG2lvUKPx/W4ymNmzk5ycPgBcWVgSh9Uu1Hry6h8Rhex9ljry9647PDAD5KlhyAAPDvUGujtdQV/tQNmgxmYmgPpkqwUOB5bt86HYyl0I3PsES+EOUOSAi5zjjwdnKP1cZzMV7JAz18wZ3WbU16clfDLqY5XqtTX7HxdT2RiRnZ/BOiyRMkEKR6Eg+e6FC5aj7XpvN3Zs7mt9B1yQ+9LLhShJtQXSDeGKsWkjx8GUUv30uQbYcjNdDsrUkCqq9B3nHwUUJa7cEp/bjg7+XZ2AOw7enwHrX0JyzpMhhqd1sjqWQYIHB8nuESgqTgxnIjjRf/02a/vW/Lrah95mPfcSOZ0/3RtNbYLxPahJ2FW+mzDKZThFpNLWr3Gn5yQJFdWpwC86cuv56pIIzZSdIOAuKIPawttL/5ZHTJRycWNdvUIhi/T7Lhr/wZpSyShT1iwfuDe1YOWYguQMqqTtLDJi1JvQYWl4lgmr0AzYDErLbwzY10OSRh13W32Y56xNhLf2RRVwxAL3pw7yJdLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6506007)(6512007)(86362001)(2616005)(186003)(38350700002)(38100700002)(6916009)(66556008)(66946007)(4326008)(66476007)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(44832011)(41300700001)(2906002)(36756003)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wClkICh6DcJ7NbbiJF8UjokYgnGFeS37crPYS7KO1uzh6Ea9ERaWwhdPExvk?=
 =?us-ascii?Q?wgYAoJ90a55iznZS3AqV6jaKDqV7/x3Cw1tSuinUg6QHOIqlcnLpopL1YqiC?=
 =?us-ascii?Q?RExT0GIodznvauWTuq+rPlu1oHPNL1ZFAAOLbQLEfr9LKkIAA1ZF5+DCAUHn?=
 =?us-ascii?Q?VvvM7Ciem/MeRMBfrU+NH4UVbFQz8GRUKPEuF0bQZgDMNLJpeb8Q387xnbeO?=
 =?us-ascii?Q?e7KMP6a9xXiWi64jJ+77oKCB8XbePcFLLcbuRtx0znbDrmroaJZfktVzfC6h?=
 =?us-ascii?Q?5iNE+aKfvXks2jcqoYZ8Tpdb97rPPvJ165lr4QHxP6zazXvwcFxK64voVSWO?=
 =?us-ascii?Q?cVYAoi1IOMMxJYY/8T8Lqx0gW0/3IUJ6qCQUo5OCKLuyXqX7v/CIS95CdcuL?=
 =?us-ascii?Q?lOj+yleo/Yy8FQfzT7tY5MheJ14csPHnf4YC8wCLdW+O0IOon/6pnk++F5H1?=
 =?us-ascii?Q?Zho0XaTSLPfk9XRXk5ryHipkKWAZTSYLruMnWtk8Cr1AuNuB4hMj+rYORTdQ?=
 =?us-ascii?Q?aHL1XhgAgGuthCgeY2LmbPhz9oVTCMNGVpOqT+B2sQpSbd4QEsLaQGqQhOz7?=
 =?us-ascii?Q?hlLDcJj61qrZ8095jTr5UgayQ+4zQ1baFBMq4MRExhbhYkNkHchLps11SV8g?=
 =?us-ascii?Q?9ff7xMqn0BGGYpE/tEMmdf/qwF+NFmcc9hWuq5b9KbQJgKk+Fl8NmAEt5jDW?=
 =?us-ascii?Q?IcDsq/NK0Kk6ic0mFjFbHy9N+vm0oCBnI2d1uM3VdeoTUHPtLWl0E53q8Kuv?=
 =?us-ascii?Q?I8tvnvBNNq1swOi0Egdgc5pU8SyFn10uvPR8eZyQYhF8zcId/tbimxUjdbHs?=
 =?us-ascii?Q?N8u6IjR3guL4cYPQCyZiND3awJVCMdz4D4vRG6OTkLJEZAWOombf9fIWqECY?=
 =?us-ascii?Q?gYqxwG/bNJZ54MB0ytDC+4gA/rAtz8hSLLMQOV1AHfrENXuWaOV0QYnAQCgc?=
 =?us-ascii?Q?EmGH1muqpjaGwzOfn7i7BKdGvQ9sf41+uFNUfA7F2CK9hBLdouY1xM5o3RRZ?=
 =?us-ascii?Q?3ZNEXYYEH70DedCvz8/v37C5gpBywWv2C8CoV79pjyjpYbt0li54s4BnbEAD?=
 =?us-ascii?Q?Orz7TXznI2Lye/CU5BJbo51gN3CJVkCF6xib3v3INkXxbRENx8+pkb2TNt3x?=
 =?us-ascii?Q?JgaQdcZdUk8CsggCsC1qvrNMS2waTGFjBnn7qnI3GgGPGkcCqnOi+jWKrypo?=
 =?us-ascii?Q?dDX0n4w8+VHJTovhOnxzkJazkel7SHTolezSmHDC0Nusv+87BZ1MgaT4m/fx?=
 =?us-ascii?Q?FxbTw+6aohFTUWdvgHiIBfQs+3uRRsFGsxujfJjIjn/JVwNAPKFUZwqcvJjf?=
 =?us-ascii?Q?duksBjXRTUcesK/Lq4STBS0iQHLuAOAMl3rAW4ckNijmKNfxjyNSqv6FaKx+?=
 =?us-ascii?Q?aKEr7ywM9KbzeUzam8JJxx5/k+NGDZj0tJ1sBr77fzDA1wa0toqX1VrH5qV1?=
 =?us-ascii?Q?1mGbMw/diMqHuKavcLR6I9bYUR/Vvl0hejiLakt2PGzoVaH1WgoTGKjhFY7+?=
 =?us-ascii?Q?Mr9HUfm0Htp7dk1dkPd59ZnfY8TEbMrCmhSoCI1MBbA+PigFMiDkJIWS9mzQ?=
 =?us-ascii?Q?jJWtUHknBKyi/raJWXnBHBiuatl69zYCI0s3K6xbAIWRQ7SV3tWXAdzx9zxa?=
 =?us-ascii?Q?0XdpKUazm8y/toCZJaxr+CI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b88ee7-cf2d-40a3-9d2d-08db7a1b8c86
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 10:11:34.4229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRE+qdg9zvWkIIFRuLDUN4nrctvgdefvGyRiUVNq68HUMgaoElnfFnN+jOJD84RKpKn0CFYDf3B1fAOSFRvcrSyOZbNVz7AJUH09NbN71uc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8832
Received-SPF: pass client-ip=2a01:111:f400:fe12::724;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
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

Write a pattern to the first cluster. Corrupt the data_off field and check
if the field was repaired on image opening and the pattern has not changed.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 tests/qemu-iotests/tests/parallels-checks     | 15 +++++++++++++++
 tests/qemu-iotests/tests/parallels-checks.out | 10 ++++++++++
 2 files changed, 25 insertions(+)

diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index 8a63c3daf4..a7a1b357b5 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -44,6 +44,7 @@ _supported_os Linux
 SIZE=$((4 * 1024 * 1024))
 IMGFMT=parallels
 CLUSTER_SIZE_OFFSET=28
+DATA_OFF_OFFSET=48
 BAT_OFFSET=64
 
 _make_test_img $SIZE
@@ -124,6 +125,20 @@ printf "content: 0x%02x\n" `peek_file_le $TEST_IMG $(($CLUSTER_SIZE)) 1`
 echo "== check second cluster on host =="
 printf "content: 0x%02x\n" `peek_file_le $TEST_IMG $(($CLUSTER_SIZE)) 1`
 
+# Clear image
+_make_test_img $SIZE
+
+echo "== TEST DATA_OFF CHECK =="
+
+echo "== write pattern to first cluster =="
+{ $QEMU_IO -c "write -P 0x55 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== spoil data_off field =="
+poke_file "$TEST_IMG" "$DATA_OFF_OFFSET" "\xff\xff\xff\xff"
+
+echo "== check first cluster =="
+{ $QEMU_IO -c "read -P 0x55 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index b747bba1f3..98a3a7f55e 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -62,4 +62,14 @@ read 1048576/1048576 bytes at offset 1048576
 content: 0x11
 == check second cluster on host ==
 content: 0x11
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== TEST DATA_OFF CHECK ==
+== write pattern to first cluster ==
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== spoil data_off field ==
+== check first cluster ==
+Repairing data_off field has incorrect value
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
-- 
2.34.1


