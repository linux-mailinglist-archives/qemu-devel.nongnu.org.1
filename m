Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E24774486D
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:12:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXZy-0000On-JQ; Sat, 01 Jul 2023 06:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXZs-0000JX-Vu; Sat, 01 Jul 2023 06:11:41 -0400
Received: from mail-db5eur02on20726.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::726]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXZr-0007vo-9A; Sat, 01 Jul 2023 06:11:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4NojxE5cPuEtfIOZ37ipfNOwlrVbOOvhTfoD+YAXn1yKpD1MnKLzgV6HCYKLCPAWGpaxaR4AcRcqHhNAFwjj5AMlpNIBEaiRZQ2iJMH6/XSNLbTGtt/npQzkEyLHkIHrUBo/fM9OOVvB0J35E53vXT62ptEHwvKNWhRSnV9F2w5R7vlApRY+XVY3yLI+yYsXo8xodF4dbbu3SyhNWFWGCVe+WJeZclbgFQIJDYx9OZlnTwrdNp5dfejcLGEVJTpHfHWwgQBgibBMnoXkfIZLM0KLZNpaKyNhUkBD9SU09w8llv56VpKwyi++3SVFaGXSsHu48JODQ2opUltLXmyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uk7I4dAzmdN29D9AIJXGJSiGT8T8bEMxyKtmA16X+IA=;
 b=IeE30rasQc5VK5PqjxyZUpwYEnbD7NFU30sxIno4cOEUy2GI6CJSoPbyF2NrXdUC5E/Bv+tBXoTcBDIN9RibxrUqt899v3rBDf1cUj/8ckdTGfuXEcUZ2ICDSzEEfkP3st7czrp2jj7Xq3u3zMs/cy2o5xKW+fjYvXeqGdNxxaT+FrIkiUlDkxizWBSvqY5W+m148xCVRA0pdq59TioaWXxCNJ33MjKNnV92A7bnau2BdwholIDCvcQmxUr6ljNRN4pQ/blQ2utJXX8gqNldzgFICuwjeE/RiK0oQNC8xjB8TvdD21JPjR/fEUyitQjaWy8hyj9S3aE1x4+lu5LihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk7I4dAzmdN29D9AIJXGJSiGT8T8bEMxyKtmA16X+IA=;
 b=LZSQ++33ka0znvwmXuepnT1cAwzGmCBWAO40QOlAkjSWzEbc+9kIHaTwl6IHbpnurVgb1mYlE1IerQk6iV1DkXinVv/JvHat2k5eTmNtINAXVW5v/5Ryw3CacDYukI12ro37hx9sa40svJO+uq8S+vXREeXNzkhqMuEyiGG2r6RX4r5iw+xSh12Quer4d4+8Xqpur+bNwieymS/8KArDDqGLeR0jiDI6SYUITyiTZDHqwDS2SR+zwp/Ok4YByZoFmH7Upiq0naElSLnFnvjXqrhVQUV8ks/gW9udLuKLFwP0jdPCntLiECaPC9ziSpSI/PVLF2EaLit6LhyuQanivA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS2PR08MB8832.eurprd08.prod.outlook.com (2603:10a6:20b:5e6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 10:11:32 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 10:11:32 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 4/7] iotests: Refactor tests of parallels images checks
 (131)
Date: Sat,  1 Jul 2023 12:11:20 +0200
Message-Id: <20230701101123.261104-5-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 60e2d2b6-7a8f-4fb7-b35d-08db7a1b8b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDz/pKZlCsAiLVnaBXMjs1OZOZeQRnwg0qzdiGP0hFy457N07v+K9JnTwVfeCbZC65rIeg2Vxh+HC2GhtYGI6kQzLP0ANM4q1Rr4H9w6a+pewRwxUk7K6XTFUQyASA8Ubp8dCQL1r6zJsxel1aK7cO4QQAJyAX854ZBhNJLPXAqWlKuoJipcD28FhuKSSxF2XwDquE61ukWuLlGQcrKPabAiXEPelU/GQj366rtonIROH+JobUxbrVNW76tUOtR0QlmCydmyJOnw04a12LFi18c7aB9BTdr9SYDRvqXn6dLl/fXAtuTkyJNMbqN5rxERmRDzOpnHyqDI1w8LzRB1jB5f+BFvPZTFObyxYSyTG577xm4pLwA5d9TA+0Nwb/ieeIltG6IzlKf7nEhClHUxIiR73JPj2RRVxrffx8BbbRpfI9OnABtUbJqnRI1rC8SGjihwZRPRSgFInkAlEywxMSlHt+t7xwUJc8DNi/PbM0X/5UNV1CDZ+XTG8qjyWR54MFChWk8zcf2FSKJ5ResyPAS0D8po8ePXVL7vMq7JHyiyi4IWbBsE24QoIbN76HT9l7EatFKeG3MuIghcEw3VGRMgK79Bf6hZMApOC6zDZqRB1qTLwjE8KVkNBAPTtCbN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6506007)(6512007)(86362001)(2616005)(186003)(38350700002)(38100700002)(6916009)(66556008)(66946007)(4326008)(66476007)(83380400001)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(44832011)(41300700001)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yX5FZPiJqcinJdU6np/iYyMLbF9E0ydtk8b5xkI6bUQQmRibIawQBI+98u0O?=
 =?us-ascii?Q?MLWfrCMCgQ3kMLl3vaLLYgxIenl8KRSLlODHB/dgihMJF1A8Dcbf1o012pRG?=
 =?us-ascii?Q?hOlEHA7KEY4iV9nRarPK+U+d/mUL3qGtKFHidP2T/SPskwCrsxsaqoIStQwh?=
 =?us-ascii?Q?ki22Sx5tp0LmPXrYluLDQ2jqqBXzQSMdgYUErpHkvLH2UwvjxhatZfCE8NnS?=
 =?us-ascii?Q?YuUe1fykoeNwcZrAmKLTvqMdYpplONboQ849eT/uGnr4rXvbEXqR4XveUVLA?=
 =?us-ascii?Q?zTiPXextGZ6cDRs1Wo92rHfMsQdevMYnhRcsXKfBy7OtURVYIXKgzLNGvF5T?=
 =?us-ascii?Q?iIcKJkNokavC76v0BmRDVq+rqfy/H8Wxiom4tQY4aD5lVYVlVVgiac6f69qB?=
 =?us-ascii?Q?I2EsY23CLyoAeE3V2zA6xmMIel5e2nts3/l91NdnH2aAd8Qiz4g9IGJIvBsu?=
 =?us-ascii?Q?UpMvis1Zwo7gbAXaZfTStrncSf7QVpK1uvWcdb8WtKZTPSgGB/PnCB28TVrn?=
 =?us-ascii?Q?oLe2m21E8avroEFyQQi740X+xX6RoMN14hjqYyr6PY0XTqMENG0+Kar3pDud?=
 =?us-ascii?Q?8maLtd5RN14spE+5BmT7u07W0i7l5H7MrZmjfthr96PgFJRBxFsc52MBT44B?=
 =?us-ascii?Q?fb4BvhGdDfa+2kegLjHgK7qvolBo1XUxQj0OT3F4Ey4drzZ9yR16yXsGgJ0/?=
 =?us-ascii?Q?tyIVFrYqtbxq/L+F9k0HkZb+dcM72yybexJLsYcgyuZD6QYRr3+VuCi3nRWm?=
 =?us-ascii?Q?9rnidhOz2jIWge1L9ApfqUk5FNkD6ox0weqaRk5lvzOTtqTJstMg577AVR07?=
 =?us-ascii?Q?1Q3nbTTuEhE/rYLM8BC4V/hbehbdWsqRoFvtuZPza4c8f4mQtbCElQhpS5pD?=
 =?us-ascii?Q?bA61HmZyXPlBvNMMQpXgG0WSDJ5dHt/I8zK3gS1u+stawel42BMCdA1qIbRn?=
 =?us-ascii?Q?ZQsdx2tXZNanyJ9NRoMFMt+eDWtCnpeegG4CGbHMTFCD8pJ19sQwToW7hK+1?=
 =?us-ascii?Q?LgB/4Gn/KalVjgByCaJ77Snuy1H67yoJbos3CS0c69TCm80bj+HyHd5oMnqf?=
 =?us-ascii?Q?7vPuQDPRRhLqveiVeIdjg0TZLlPxyQc4KMWX6bVFS0Kfoa83HPS/avkzQkzz?=
 =?us-ascii?Q?CfKzp3eXxIFH6E37Nnut+Cq1eVDAkwoCPg6NckeCjCFSLM7Ju493MhwNNSym?=
 =?us-ascii?Q?Nzf9NMqqrSp5IGo8zLz4S+l8cKkP2zPmqkp2XXMruKMgnfWEpJhQQPSm9p4r?=
 =?us-ascii?Q?TEyw4ztqT0fytd8POxFtXf6g0TELW65eZyksGno66Ych3EcdbWLXpC69RAoX?=
 =?us-ascii?Q?Hapn7R+58wqa/WL7xLFk4jWJZEjuXpKZQgVkytY21704q7uz5kpcTa7yYspo?=
 =?us-ascii?Q?krRK/6DLKdlsXvdxVUvTbq9C9jGPKCI4uuCmXfSWSf9ZkEd+4TCvnEZolDAw?=
 =?us-ascii?Q?IFxQPRQNXz8GoCLr5243ZIxqPEhdGrlgl2z8uhetdgjvLrt0yHCXTS1Tmjc7?=
 =?us-ascii?Q?gDIqxRvb4AojGIp6r9i15LofV55JF1e2KyNuVz3Y4S19OFrd6tXg01Xotudr?=
 =?us-ascii?Q?3Ym8eOtCmz5LzyNG5xeZbKBbebaceWorDg/Z2PeXx774uO1Ek1axXjktpjv4?=
 =?us-ascii?Q?HsBU9rSvrWUBdMatI6NcN+g=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e2d2b6-7a8f-4fb7-b35d-08db7a1b8b8e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 10:11:32.8103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOCuMVjrjC+HdA5OrAYElvVqYb1hEndG+1q+dSmUK5+HrfVuQhkfQxVO2xZsA/RHZspxzvfBCuCeXz01k7de1lYy/gPleua/ptdc2j2XeCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8832
Received-SPF: pass client-ip=2a01:111:f400:fe12::726;
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

Replace hardcoded numbers by variables.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 tests/qemu-iotests/131 | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/131 b/tests/qemu-iotests/131
index a847692b4c..601546c84c 100755
--- a/tests/qemu-iotests/131
+++ b/tests/qemu-iotests/131
@@ -44,31 +44,34 @@ _supported_os Linux
 inuse_offset=$((0x2c))
 
 size=$((64 * 1024 * 1024))
-CLUSTER_SIZE=64k
+CLUSTER_SIZE=$((64 * 1024))
 IMGFMT=parallels
 _make_test_img $size
 
+CLUSTER_HALF_SIZE=$((CLUSTER_SIZE / 2))
+CLUSTER_DBL_SIZE=$((CLUSTER_SIZE * 2))
+
 echo == read empty image ==
-{ $QEMU_IO -c "read -P 0 32k 64k" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -c "read -P 0 $CLUSTER_HALF_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 echo == write more than 1 block in a row ==
-{ $QEMU_IO -c "write -P 0x11 32k 128k" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -c "write -P 0x11 $CLUSTER_HALF_SIZE $CLUSTER_DBL_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 echo == read less than block ==
-{ $QEMU_IO -c "read -P 0x11 32k 32k" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -c "read -P 0x11 $CLUSTER_HALF_SIZE $CLUSTER_HALF_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 echo == read exactly 1 block ==
-{ $QEMU_IO -c "read -P 0x11 64k 64k" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 echo == read more than 1 block ==
-{ $QEMU_IO -c "read -P 0x11 32k 128k" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -c "read -P 0x11 $CLUSTER_HALF_SIZE $CLUSTER_DBL_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 echo == check that there is no trash after written ==
-{ $QEMU_IO -c "read -P 0 160k 32k" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -c "read -P 0 $((CLUSTER_HALF_SIZE + CLUSTER_DBL_SIZE)) $CLUSTER_HALF_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 echo == check that there is no trash before written ==
-{ $QEMU_IO -c "read -P 0 0 32k" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -c "read -P 0 0 $CLUSTER_HALF_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo "== Corrupt image =="
 poke_file "$TEST_IMG" "$inuse_offset" "\x59\x6e\x6f\x74"
-{ $QEMU_IO -c "read -P 0x11 64k 64k" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 _check_test_img
 _check_test_img -r all
-{ $QEMU_IO -c "read -P 0x11 64k 64k" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IO -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo "== allocate with backing =="
 # Verify that allocating clusters works fine even when there is a backing image.
@@ -83,7 +86,7 @@ TEST_IMG="$TEST_IMG.base" _make_test_img $size
 
 # Write some data to the base image (which would trigger an assertion failure if
 # interpreted as a QEMUIOVector)
-$QEMU_IO -c 'write -P 42 0 64k' "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write -P 42 0 $CLUSTER_SIZE" "$TEST_IMG.base" | _filter_qemu_io
 
 # Parallels does not seem to support storing a backing filename in the image
 # itself, so we need to build our backing chain on the command line
@@ -99,8 +102,8 @@ QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT \
 QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT \
     $QEMU_IO --image-opts "$imgopts" \
     -c 'read -P 1 0 64' \
-    -c "read -P 42 64 $((64 * 1024 - 64))" \
-    -c "read -P 0 64k $((size - 64 * 1024))" \
+    -c "read -P 42 64 $((CLUSTER_SIZE - 64))" \
+    -c "read -P 0 $CLUSTER_SIZE $((size - CLUSTER_SIZE))" \
     | _filter_qemu_io
 
 # success, all done
-- 
2.34.1


