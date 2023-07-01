Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C915274486B
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:12:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXZw-0000LG-Hn; Sat, 01 Jul 2023 06:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXZs-0000Hl-BZ; Sat, 01 Jul 2023 06:11:40 -0400
Received: from mail-db5eur02on20724.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::724]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXZq-0007vY-IG; Sat, 01 Jul 2023 06:11:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEheRYOk0gC5vnxn0DdqrA9gDPNEB2rE1t3XTDt0CJRAC1u61UpXRge0/T8S99XJqHe+GOsxkdIGUeyMr7V097+/+HHrxbO8SWiPzO5NOreFWHlbaRQ5Jfy+MWLGxaRMZAiPvU9ZaZkm3QnElEFs3xd9BBmTpqJ1vgi7T5bkxxrqOpqZCL1QFlqita0tc2e63QdBe5A0fHK7LG9hXjOKbxUO8I+329hHER+JS5Il55/E1Fd2JgnZisFA6DWPzZaKpFdGqElQBQsr2FxzFV59gZpcCuZJLWqEiGI1exTy5kzA58eJRy+XJiO7F2MXOAr5idYD+Jg2Ch9whu/SqnNcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9C+biTLzNtKfdPkwSBMIbxNZ+DoYLugwnx4JnH826dQ=;
 b=PISw8UDlqITmmWMXVDmVnrUWMoOzHp5D1SPxJShYxYqZiSvzToJJ5//A1hwXmifO/bP3WZyI+00A/Ho8p/VxuYLmjHY+swSrhSes4OOxqlSxiOTIzzSsBXyq9XxwynK0ZDhMRIgmvrUsh9t9nUTMb2aoewHK7CgEefrO//kfVLys/etXbxzWWXJH2WT06ckCY/ZrLJK6KZ5vXCry/1a60qpJIcnU9WW8OUy5jOBZ++k4L0Bz+yysHp9OwtpL8sX/rVEILIff0OU4Rj6iayJ8MotYl69duy+KWngPCOY0jyvJLw23q5oxrV94px3LfYzkgVUS/bjO6spSBZKaVWCAdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9C+biTLzNtKfdPkwSBMIbxNZ+DoYLugwnx4JnH826dQ=;
 b=j2IO95dBvaAY1Pcz15gFrlyk4W+VqM/2ZFqBW94f3vuHegDAbPvt0MfPJihmHSU1cFq4nxxRQ+qlMTF2PziGmFcQqOhNFU7emVz8CgVCdAArQ8z2YXKW9LldZpwrPuz3/pY9FmR3VnrYuG4YNfBaqxjeHHHapmSyDjJCprhquoReH/9rPUca9sgSyltncvIHYSOkThQQk1Je2hoWHatxWc2qFNgH40kPNR53mx3kIx68cSw2VKbSuMbX/aG3oacsO85Tv1IJuTz9LHa7cbjhzy8zrbWe36vLumgk+K4/6y2xal/5sl/8962vQKTiDjDKtiWP9oO7spGmeOmiFrNURg==
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
Subject: [PATCH v2 3/7] iotests: Add test for BAT entries duplication check
Date: Sat,  1 Jul 2023 12:11:19 +0200
Message-Id: <20230701101123.261104-4-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5f40a87f-2d5d-4b47-a79d-08db7a1b8b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ZlHaPW56m+Cx+cxNXDuTbUMokhkCwYHgNAle0yTKlAi7UlOB8Eg7s7a8J+88/DJomgQsJgMmrQB4BgubyABo8jZqiyXHYaOBjnuHtg2CVacPiY1g597NG2nHy5t2+d3v0aqWNPIsMa/GMIisqVqS95DaLb9XCo+JnIbo22Ftek41+8PwuOo+Zncm7K2BeIhQy5w2UusqvC7vliZpgadH6GIax6U7FHtJyoM7xehJrF9aXEJk6m5PD3jelwCD+bDPHr53lsxFmLbiX9nj5C8xleR/efvYP2iWQd43HI9sSJxoubuSSf+e62sBwbdVe8Ekjjcyc5bVEzDa3m2ycWYT3GXSIqThk5XQPnrDLf6OqtZTyDrssqrDP/t6A9XLLUkaFzL/dVYa9x8yPH3EphpEVmpqKDE5coUSY7EdxSKamuQtjNUpbD5kxdkKGTJNb/tI4cPCmmDgnmNfHf9YML0aPwuPHd9dGNtm6d4+9UUmeWo5sbO6nQ4xkAFNiWh3cTtyBqJLUsMnaXjVofRO2G1KeZdSJc5MEZNsUiV/YwvDXlb/hQCjuDxhdynJZDPDbXZtfRnvtNu6jyT3CEOgggeMSENIOavGf2DzaA8jU+PwF5SZqlRZrYbxSenJYXnUHiuteeYirOjRdJzKPvtu1Bf8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6506007)(6512007)(86362001)(2616005)(186003)(38350700002)(38100700002)(6916009)(66556008)(66946007)(4326008)(66476007)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(44832011)(41300700001)(2906002)(36756003)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C3TnkpEZzmPqJkajtZhBf7aVkBjNQwxuyuh/rATcYbiJgUbd/yGYbdTRm0ly?=
 =?us-ascii?Q?fvcrAwTQeSizodsWTlW5aZz/BVUABF98+27czoq43Y+JNVxp31NksLdw7w9h?=
 =?us-ascii?Q?CpF55hH1AL5/bDJwA0qpwK/B2xv5GIx8tZbBX5zdZODKEVNuwIPxSTO9cd4y?=
 =?us-ascii?Q?g3KqHvuuyQxjXxexn6zziz3ciQtsUrgdghici9vINPTGzvMFDwy1hFkz7WrB?=
 =?us-ascii?Q?IFpOFL2ql7HxpjciGtyW91qcsjs/p951LNDrfQ2pGFfXgYqr0k89/O7gRUoH?=
 =?us-ascii?Q?dbM2yutVDNbqxIFRefiHJGOBn+y/mpRahbw/5hV+f9H5ZCNMxgF8zHd5U0kh?=
 =?us-ascii?Q?cptWFah9O4IYE8vWzVRHwD26UhictOvz29XHv8zdywRl///SLKm+NB3tcfwE?=
 =?us-ascii?Q?GF3IazAxkJZ1Ewv4wCjeK0coLMb4ot7A7l51ARIThAo+v6Jl8bynSI6Y2qGd?=
 =?us-ascii?Q?mXZ09MK2lalDrhKgm3EQCORaLo8IIUeUzhChD47a1h3gNniZS6JFn21UjeE9?=
 =?us-ascii?Q?gFKXV51CtCw1EAWCaiWzu7P52UkZ+YnRCdcps1jncx9Q9Uexv1NPUB9VS6+N?=
 =?us-ascii?Q?0/J4qWeJtIgVdGvO3O82mkjNShJvYBlX8Y+8Bh9yKaw2T31VkEIK2c9z+bGx?=
 =?us-ascii?Q?xgT6D5alQdL86ajOTneyDWPPsTTjx4JafTrMQQe8yzZ7BM3amdNqYZ0OG0JY?=
 =?us-ascii?Q?nT4Z9N9UFlJ0vmz1NRVyRVuurxWsdasNFNoOsjivK0ihNCxfhFNawtHFqz/J?=
 =?us-ascii?Q?63fh/wZPsgAJDRzeMXcdCk3VJeL3OqDP+zSx7Vjoz7MgsFN9uyQEhIOIsTxN?=
 =?us-ascii?Q?cd9UsoMCq+SBbZwEdWkaGX4Aj/ft7BRDz/X8K8nx8Esmn81chCEJ1IXsEIyw?=
 =?us-ascii?Q?SOSPAUk4Rlzer0NfSjz7dTEaZ44S+PocggKBBR3D0aYsL+/+eyWVSfnJwBLI?=
 =?us-ascii?Q?H3LajRfM/KXKBM78z/w2hbXZ+W6UTCDVKrm5vllceHRi8jdvu78OHl9lEdBr?=
 =?us-ascii?Q?g2HJFT4twzPE1P+35t8VpDeajsiEhy96Ixx2raQrl5IHUnihmUQK0v6oJtG5?=
 =?us-ascii?Q?AexL7Eh0/p6LDpIfNvJRUJ+E3P34Kt2qhLSksnyRpRUj8W67Zy9j+HVS2wg+?=
 =?us-ascii?Q?otVyNSBhxGOMFe8JKdtbiBaK+JA/aWbEAEkSlf3E8KjjcUgCP/WvD+9CC2nY?=
 =?us-ascii?Q?P/UIEE4p6viatlIZWRN/RgYoZCAtW/QY5e49ptiPaI0EMWy127MnPIgBAV5z?=
 =?us-ascii?Q?mVg6EGophz9WzzMweN7q4/7xh7DpRorjIehURSrso9hhRAEP3pdKKp4hu1DC?=
 =?us-ascii?Q?x6u1CyAUlKdkWfV8nOwGUDFYHb1g78pJjMr4fVP6k5usI+deMnLsA3/k3evo?=
 =?us-ascii?Q?63FMKSfong/OqejZpsv5nIzY6OVHxiWZyfGWtU/BCR2yl01Km98RNndnAsPZ?=
 =?us-ascii?Q?8FqTxCoR9LMPYsizodER3n4nwRjfPBW0ghEPyLcTrsW1AHzL+XjDSSunEcBT?=
 =?us-ascii?Q?1zfwnjsO/N4AUSrII/7dBzWDCkLjNQ1H0R7aNMjNfPTtfsYvujD+Jd8myeNb?=
 =?us-ascii?Q?SiClCEIXu9A48odOgYAkOjYnTVckSJ7t0rbkbEQh4cAFYQdGkvfkHOA0zlIg?=
 =?us-ascii?Q?Fd5qS3W4AOsRmTkUvpHbTaU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f40a87f-2d5d-4b47-a79d-08db7a1b8b3d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 10:11:32.2739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aO8Rgd0JZpFw3LaE3OWrL0RKN0GNYM1ITdMzh82Iz59W5o5wiOrbwkmTSp4nTScHA1L1sEaoS1igzxhEgJ3Rvnj7oF+rFrXudQZhw5Wu5d0=
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

Fill a parallels image with a pattern and write another pattern to the
second cluster. Corrupt the image and check if the pattern changes. Repair
the image and check the patterns on guest and host sides.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 tests/qemu-iotests/tests/parallels-checks     | 32 +++++++++++++++++++
 tests/qemu-iotests/tests/parallels-checks.out | 31 ++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index 8be282fabe..8a63c3daf4 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -92,6 +92,38 @@ echo "file size: $file_size"
 echo "== check last cluster =="
 { $QEMU_IO -c "read -P 0x11 $LAST_CLUSTER_OFF $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
+# Clear image
+_make_test_img $SIZE
+
+echo "== TEST DUPLICATION CHECK =="
+
+echo "== write pattern to whole image =="
+{ $QEMU_IO -c "write -P 0x11 0 $SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== write another pattern to second cluster =="
+{ $QEMU_IO -c "write -P 0x55 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== check second cluster =="
+{ $QEMU_IO -c "read -P 0x55 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== corrupt image =="
+poke_file "$TEST_IMG" "$(($BAT_OFFSET + 4))" "\x01\x00\x00\x00"
+
+echo "== check second cluster =="
+{ $QEMU_IO -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== repair image =="
+_check_test_img -r all
+
+echo "== check second cluster =="
+{ $QEMU_IO -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== check first cluster on host =="
+printf "content: 0x%02x\n" `peek_file_le $TEST_IMG $(($CLUSTER_SIZE)) 1`
+
+echo "== check second cluster on host =="
+printf "content: 0x%02x\n" `peek_file_le $TEST_IMG $(($CLUSTER_SIZE)) 1`
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index f2cb6dde85..b747bba1f3 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -31,4 +31,35 @@ file size: 2097152
 == check last cluster ==
 read 1048576/1048576 bytes at offset 3145728
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== TEST DUPLICATION CHECK ==
+== write pattern to whole image ==
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== write another pattern to second cluster ==
+wrote 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== check second cluster ==
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== corrupt image ==
+== check second cluster ==
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== repair image ==
+Repairing duplicate offset in BAT entry 1
+The following inconsistencies were found and repaired:
+
+    0 leaked clusters
+    1 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
+== check second cluster ==
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== check first cluster on host ==
+content: 0x11
+== check second cluster on host ==
+content: 0x11
 *** done
-- 
2.34.1


