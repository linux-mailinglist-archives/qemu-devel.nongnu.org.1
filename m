Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 181B9744868
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:12:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXZu-0000Jx-Di; Sat, 01 Jul 2023 06:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXZp-0000Gm-Vu; Sat, 01 Jul 2023 06:11:40 -0400
Received: from mail-db5eur02on20724.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::724]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXZo-0007vY-Bw; Sat, 01 Jul 2023 06:11:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQb+FuXDkyhGkb50WLkhLRT/UbMBQ9I8lWcMgbiURmz+bQSv9TdbwpCSCfb+8wE5Tn4oqw/YZipBdXp4ufk49955u/YnZfqIyGDWSl0O+YKTLUK6jUtkfpgYF6LRGdibL2RblcIMIZKESEaLAiPaK3TOr/PQD1C0JIeM2XIwV9KgoHIy7ZOMbHNRdaJeTdDGNiUCYuW1x/U9L9rNLFPmDNP5Ue5qpVCx0gq2cCsPakaEpLKhnuCIORleC06raTY/FAd8+QzdV+xx3yJmeq1zFOIDYCEAmShAhIhfAbr7srqZXNMIkBHcI98WNr1ONNi55vKrhmw4ELEgZXrKqvsJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEe0eihCeuFAUQQRulF0qttAaOppAZRgF56WPxz05os=;
 b=C/l32tNdTknOOZcfU3v34ddcIbs+8Xgoqh2Z10JtPDJgJG5eIyjKJgvL0viotGvBuxSEOwQqkPAPcaFlFWw+6J4D/Xx70UR3c2FuJlhgSUBvQEhRG+bPIXO7Ml3p3dVqdlRq0bAUqdLsy0fLPeKFrKU0hI1PvdgEn/kRLZ3nxGJ/0hOkh/VU9Dt/OPCmeeOyuuQ8LBId20aFziKWn83WLSTswoXPjb6wdhIc3wSNOahucNEvsr7EHt4dadi8iNE2Sdmggl9gZk9piseAbOlHCEmhkBUkzL6bOTip59lM7M5HbjNU6+/m8lMxmEkEuwashMwawsY0ZKAN7Nxz3JcScw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEe0eihCeuFAUQQRulF0qttAaOppAZRgF56WPxz05os=;
 b=EENDd0rC+QAzG69G6a+659Fnfq1kLsKfK4apdgzojCK5no7A+jegQW3HNAYoNFCDXVsKIswuAWbpO6SH9aGTr/zIIPa6dyU3TKqqHoBJvxp9tbzYHOXLTLahNFEC3rOj5DMztmoYZYP095dBqQWau93VAhjvwZDbh7nGWkWbCR717sig3LIHJiS72u4K4Lp90O46wgudJ6nVlRflWMtSoN3mp38jH9bRr07g3J7xl9qDI4HnZiM/qubypuM3x0kEgMtJXrIFC0IY2RbCnhnMDorYXh6U0AFzEAWoGc4ucdPLpvA/QJIf0MNlc3hIWuvgIRPHMrPdJWIhj3NysYgZGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS2PR08MB8832.eurprd08.prod.outlook.com (2603:10a6:20b:5e6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 10:11:31 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 10:11:31 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 2/7] iotests: Add leak check test for parallels format
Date: Sat,  1 Jul 2023 12:11:18 +0200
Message-Id: <20230701101123.261104-3-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 32c1cbc6-00b8-407f-d4a8-08db7a1b8ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KniehuelLzbQKm57CgOszbLpeJpYS3vwl1hrIDSpqdWvkEhxuwlSCpQ58HnmPzNQcvGYlN7Nd0joWeYgc6Yo0YzUakzSwoyoSycCOxa/Q8/IDkadohQ0MoH203YfkRfmJeWwiCy+i4UrQK+eMJetJi0UCQm3IhjSydWPPYarFceRdHxQQ8o9ugxwzX+jFiz0mO98p5FGdwF5JI0uJ+hX7T7HGlz/FijN1Y/QPgBpw9oTtFGIlAvp8i9ojIMh/z1/7UWOsWiqFmfyhkdw0ezIvVnitp2Yb3SORn29vALoObyOK46z9Ftaxjakji1bSY6mCSmVwK5J3kTCoF6i3wCJpOJzlKZu/f4gL55TsduaiF2NDHixCdRaI3AKCUijcZN21iZdlAeOSTFrkj9js/jEkw+p+KYOgHAOWWjfcRU3FRS21ww16BwVBz7ks8e9umfKUMTLRSaGcKP4fVj5cbhLYQYDTFLbmYn2I9BYAsTmEoB5UadVTf5p6YIDZIQoCFmtyMdFVNxzM8PyKixfbLz0nRlWnH1tc33obhb1kugz3aix1GDftaMKMT1N669ncVsOE4/OOdGsjNiD+L2RFN6tHQKA4eqyarQx8mnmyy5QQRqy2cg9iW9HzFJEcci07JFrdWTG4EtkzwlAf8tvWR8VOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6506007)(6512007)(86362001)(2616005)(186003)(38350700002)(38100700002)(6916009)(66556008)(66946007)(4326008)(66476007)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(44832011)(41300700001)(2906002)(36756003)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MVNkfd5hG9DE26VhcJH2G69ABs6rfbcXkBdQwvSwHVgFQYApeH3suU70pP8o?=
 =?us-ascii?Q?zuDtys9Ja5J60eNgizjhH7TxsHpep7DeiFqZtIZrKsdmL6M406oJ1cJzhYF0?=
 =?us-ascii?Q?okB/xHyX3eWicf8w5u8JGAzYDhRm7VDrFn1EwzhZV6Yxr2c2yaJr/mNgs3oS?=
 =?us-ascii?Q?/6i+w5rlnkv7Y3cP8Me4xGRCMjQDTFVixcmh8ER/XIvBaOq+HUUhqjE0YWR7?=
 =?us-ascii?Q?+9kbZhGzP/TGm28gmjHRvsyE6yGEzMxU/6sfZ0mislfP5caxDjeX02wWfJAf?=
 =?us-ascii?Q?WsyYYEw4ThjbrkJPGHnaf5V6ZYlu8vuQlFKYl6VmjBtRd69eRNAB8x1f4il1?=
 =?us-ascii?Q?b3KYsuJjtqQVVK8TrTFlvqTrfJJjO+PM4bjAxEcQDlbjBMtfDsxYl51fiFRg?=
 =?us-ascii?Q?zBKramzULuN16bHNmiNkgK6DSD51yhXsAXd8Nk8mMIrAEzIxG17hYYfJwGn0?=
 =?us-ascii?Q?EFqgyzsSXMMI8CVpFcgHO92EuuLWpkgw0du8GxyzcHVgOOPRiJeNd/JuV2yK?=
 =?us-ascii?Q?WyED/6BP2mE7TQoLE0PrznEFzoHp6XrzYUzAAcoCOqXsH6heYr0xhize7zXs?=
 =?us-ascii?Q?CqyZgDtRKJ/VCgNMlhdaoSOiQIJOOawUQ8rkWdp65+l4tKuk9XbIl58RmnAf?=
 =?us-ascii?Q?ExfDOScncOg+lFOQMvAR3K0J76vAcjSm95zPHtnLN3PcIu2knXkp86m3CeeK?=
 =?us-ascii?Q?SEZkb3ibjs4fGjkx1SjY78PBEHY4hBzWV0iqRro+6DXZLesIBED4tVYHAm27?=
 =?us-ascii?Q?R/zFZ65kYUPPTiFThUXVE61vSB7jrb8Quk7Y710m9gJ26euQJrVKAQFoov3y?=
 =?us-ascii?Q?CQU2Z2SRGTCFOTJ4lxDsLaxZCtdKH95vKylqzYfzmobsPRv4qGGb9FasrRRq?=
 =?us-ascii?Q?GW3NV62fmWfMYjsxmzyFHhmqY3ag7a1kOEOCYBZqB3ixSJEmudiWvdqZIf5p?=
 =?us-ascii?Q?fK1qGN3vrdgfr7gPrEopzSNLzDb8EtgaQO/9g8cy+15HRfgm/8/boIjMmPje?=
 =?us-ascii?Q?mCsIDZEf+lIzJPzQod3VINtphve9sSSsIgGZTdVAxmhNCe4OUFCzVO2hSOPC?=
 =?us-ascii?Q?5p5FOh/ZzJbY2rOpxyHBq1yBWsODtkXWNmFtJzX2OR0e0xHJYyGvE0sSCsI1?=
 =?us-ascii?Q?9sQKTtHJo4R12oZngyAZ91JfloLaWux8uf/rAhLV4RWkK2wXI4kbTUyTbirq?=
 =?us-ascii?Q?/KKugATYtg4H4v+b0/pT0dnc/LI87BHXg1+YZJEKdQctaGBnHgg4oEkh96yT?=
 =?us-ascii?Q?eb9GiNHFJ8+iAPlYZfJnl8KqIYA+Kp43iwJf4Z+02hHbeoAVVYanGgine76u?=
 =?us-ascii?Q?mntF0/Q7vHmcViKPx5hpiqaWry6A8p1Xtlfia2t+C85Q41CEpULs8e/M70ex?=
 =?us-ascii?Q?aQf9R48E8Gc5Hx9pM+wfFVTcL8fLXgDvS2BOZAJ9xX3BiCi4BN4wXSrOgkEO?=
 =?us-ascii?Q?JfXzlygwbPMrHCvLf4mj8Cmp+zahJX15853uInZzrhoUeXQ5t+kz/MuLTJrd?=
 =?us-ascii?Q?dAauSeOseRgn+cZILc3IohHMCHKlNRJZWhQXYr3x5Hmpg+BqWry+wGHq4B26?=
 =?us-ascii?Q?uNf/rD2FTy8bPuboOoWmDR5jK3YovVz7O8EG+s0XDMqEsGlh5uNOzPnGWU+X?=
 =?us-ascii?Q?pymlNrNGx1aXnltO2eKGAJo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c1cbc6-00b8-407f-d4a8-08db7a1b8ae7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 10:11:31.7346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qp8OIb6OET81z591BBL3XPlWHMqAA05p4HpVnBJ8eq9VJmuuZqX71R4b35nf0HyqAalrtyd3iFJRwp9rLYAjt5q1e7NJXgBjDsd7mqZCxEk=
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

Write a pattern to the last cluster, extend the image by 1 claster, repair
and check that the last cluster still has the same pattern.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 tests/qemu-iotests/tests/parallels-checks     | 27 +++++++++++++++++++
 tests/qemu-iotests/tests/parallels-checks.out | 22 +++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index 055ce34766..8be282fabe 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -65,6 +65,33 @@ poke_file "$TEST_IMG" "$BAT_OFFSET" "\x$cluster\x00\x00\x00"
 echo "== read corrupted image with repairing =="
 { $QEMU_IO -c "read -P 0x00 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
+# Clear image
+_make_test_img $SIZE
+
+echo "== TEST LEAK CHECK =="
+
+echo "== write pattern to last cluster =="
+echo "write -P 0x11 $LAST_CLUSTER_OFF $CLUSTER_SIZE"
+{ $QEMU_IO -c "write -P 0x11 $LAST_CLUSTER_OFF $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+file_size=`stat --printf="%s" "$TEST_IMG"`
+echo "file size: $file_size"
+
+echo "== extend image by 1 cluster =="
+fallocate -xl $((file_size + CLUSTER_SIZE)) "$TEST_IMG"
+
+file_size=`stat --printf="%s" "$TEST_IMG"`
+echo "file size: $file_size"
+
+echo "== repair image =="
+_check_test_img -r all
+
+file_size=`stat --printf="%s" "$TEST_IMG"`
+echo "file size: $file_size"
+
+echo "== check last cluster =="
+{ $QEMU_IO -c "read -P 0x11 $LAST_CLUSTER_OFF $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index ea4dcef0a6..f2cb6dde85 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -9,4 +9,26 @@ wrote 4194304/4194304 bytes at offset 0
 Repairing cluster 0 is outside image
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== TEST LEAK CHECK ==
+== write pattern to last cluster ==
+write -P 0x11 3145728 1048576
+wrote 1048576/1048576 bytes at offset 3145728
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+file size: 2097152
+== extend image by 1 cluster ==
+file size: 3145728
+== repair image ==
+Repairing space leaked at the end of the image 1048576
+The following inconsistencies were found and repaired:
+
+    1 leaked clusters
+    0 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
+file size: 2097152
+== check last cluster ==
+read 1048576/1048576 bytes at offset 3145728
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
-- 
2.34.1


