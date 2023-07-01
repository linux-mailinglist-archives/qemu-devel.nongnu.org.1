Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A84A2744869
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:12:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXZz-0000Ov-Av; Sat, 01 Jul 2023 06:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXZq-0000H2-Mp; Sat, 01 Jul 2023 06:11:40 -0400
Received: from mail-db5eur02on20726.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::726]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXZo-0007vo-TI; Sat, 01 Jul 2023 06:11:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEyENcPBq8RIhHhu6BcpJwCVesi4MK1os/ebdYAwpGqLopO+U3jGEUW8CFxjUj22DUfRgTzxwoTSj0/JjLQqqM1svEuENshW0snYjHQBg4PVu/JDhFRNqyAA0Kst4VBg8GiM3BTxnbDPCG3Pll/SLG2Ys/AfeyAtqw3Ib3iNvnuom3WNennDtPfIQR7BZ33qkTdfvjxmfteCMRP9CgwrQsiVy2LxeEBPWOccHGp9q69ZZDSO95Tn10SGDf8T9hQLDGKklLpKYxubJcd4rCl3RgrCkV4NhItNlPjbEZH/NB7x6uIWhQ44ijGs0xuxTb4yLOkNqtYpgPZTWa54xnF0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxUYf6aObS4iITGDY50zim4uxE7+oXyFe5i3tjss0V4=;
 b=DunpEa+36gUi7g/lh7pjy56TJRG5H4seqVmizQ0lwRtE6nKosLfWxxcONmuOJlFHL9toLEmKVLqMvYx4aRz2FqAUMQ08tfaDa5DcVYk6yOcQUTddpk/KVtMY4aKoXVHjDtTQ1lMTKkdFdQpyh3bbCOsQaJxczZpE+CfuOC7pWt5hw8QhkQFk40abemJUuhuVy+cjVn+615U1njTiiv939M9EukOkmvIkv/7JHRjioVMHoRTHhf2SqxeTWpau2OdM8c2DOrjpEAD9TWdj0hVXPVbBBdGtrGNBTy0aV+JNXokCZGZuF6UhelwAQAsVb9UYxlGeIXnGKdeh1L8snw6J6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxUYf6aObS4iITGDY50zim4uxE7+oXyFe5i3tjss0V4=;
 b=OLbPCU8aiM+y2xQFK08sgFuZrvzB3YC274H18Lsi9IpRQ/nao/VTMqEuIrGoKG6f7BBqr8nntDGc5UuofTxed7mhR+G0apbdQcnekuxleshF2zid1Ud653gxoDiPGWlq3vwBvb4Gza82K/TnPu2eT1D62mD9RZnHXbAKPVoIDN/JOdFe0qGtKcFkGvc6x68EPeOROvvuJFwUv8FqHkSslcW2Ruilgj5vhFVEJixB726xhAwhc+jXBsxgM0BuFRR+7JXVXppWIggxJZxNiSOuaqm85FSk9vIt/EHrTTTrXNR6Scl4uSUfxPd738qkgErOJvMnWYlhhqXTOdm1GdhvHA==
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
Subject: [PATCH v2 1/7] iotests: Add out-of-image check test for parallels
 format
Date: Sat,  1 Jul 2023 12:11:17 +0200
Message-Id: <20230701101123.261104-2-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7377bef0-b1bb-42b1-2a8f-08db7a1b8a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KfP5S8SNnT02/nDpTyuCW9qTUco7wrs6un79Hfdsy6riqZQSkghF7d3C2t34xWZjKrdc6jxVjKyX+JR1PKzWynVy28F4GXAdC7zG0X35+7eFDzRdMh/FT8C8uMuY/YiybqC0KixbKr0ZaZzaF5PxphE1mcSNBVI9xL6Qnn9BjkUHzn3C6aJxii9ZEfo55PKILj58Jj7tD408tRy61Lp7zfjNE86VW2tRziDiZFzeoCqEYeOL4C0krIbjjw6nGgprAHtL347Y/dHvKpMoMvL0xM/Ru6YDfL9be4xdo6dtnUmG8P8Yer5Z4FQOZ/D6i60+HIB46SkNNT/LGAbrZC4ojUW7HJf0IU5BvvWhqn+rvtepjC8TUVsJw3EJrb39ZcgeVsTl8I7DBlTDVdxwPE7PQag3Da8kmEL8ikhB+iBy+nUmTn9xkBka1Y2plg5eI3bgQWk9L6miqq5NJUhWpYOvbeCNsTd/ZIypUlQDUpvjRGfsGpcGyrnGlmWaFZS9iA1Hp/Z1kYQFSWpkUorbOYqmtS3b5LZ/GiHzR+0Iz4H9QnoMYVlqiNI+84qh0Ba8nmpG6Gtl8LW1H1BRJlke8z1KIOIRYiYqtAeP1lJ+eV94bBfB6GFe4C3IiwSxs+GYgUEaNLDbyM3n2pgAo8Dgj7zpDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6506007)(6512007)(86362001)(2616005)(186003)(38350700002)(38100700002)(6916009)(66556008)(66946007)(4326008)(66476007)(83380400001)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(44832011)(41300700001)(2906002)(36756003)(2004002)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/E0GID0JjsTzTScE+4QcuCcbUUaPRGOszmaZNnXEnQcxfa2bfqUllAFVO4/3?=
 =?us-ascii?Q?68PgLbFPLVpgOhmrVzPsydA0+SOhWvADXwipOBmibQm2vy+swl/FjPUAZU6R?=
 =?us-ascii?Q?A/PMvCJqe13idds6g5uqvKdBvUcvIScHyuVfhlyXs6VJDFCJpLPQ3CZ8oQNV?=
 =?us-ascii?Q?1lJ3np2lm6OCmo85dQ0EHCMVqjljIZz8CCL9REa48yedDPl/d2xBDiCLjWkS?=
 =?us-ascii?Q?K29DllA7JA/vTJo8+dkseBjlquE8mhCzksCCcYMGPa1Zi3OAimJ2jmfT0E/G?=
 =?us-ascii?Q?hnm1Ngg6rmYmx5tQhk61XmhrfwpyQYcys2UtSuOEuhHOYCvh1LJQ5tHp5afm?=
 =?us-ascii?Q?rATaXkSCLLGq0bB4LPPH2O4F5ErdJGvcneHhUY+Y5qvEALta18vmhiqePzMT?=
 =?us-ascii?Q?fykTErgYBbWyObodL2C4G9rVOMsdNI+YBxk4zpQOo/zt+3WnayzQI2CxEgXT?=
 =?us-ascii?Q?u4CpqOQPMxV4La5JY9VhWT8unawcEPGFU8lyzycth2oy6UO85cX55uyKU83T?=
 =?us-ascii?Q?K46UmzrMApUaVff/PQiUejcCivHUIhynAYiZnqgC9bK2rS/FPaChiYKCHJJv?=
 =?us-ascii?Q?2ZJWChqdwk2zX29fQXpiRBpMoFxGq59F1Sa6+L1q+EzyYPE55uJ6Q/Q8NcFf?=
 =?us-ascii?Q?/dKpysXUHMCsACSIkRMBLd/BNH1u7dUbEGSPB2/h2VUx1WybJ2/WW7wG/1Or?=
 =?us-ascii?Q?ETOhsqdIceqKmjMIdEZyM9spOIQ4KuTAZLL1WZDWB4ao7OqbJhFQd64ZTuM1?=
 =?us-ascii?Q?7owNf7XkXFNQ1bmJDuIQyP0HxXbr8g4WygICIUP0bIxC+TMuysRTA+K9yLlE?=
 =?us-ascii?Q?DeqoW4vsC3FOY0zD5bRtvBoCFKEOCQkYctmY1uelTNrVu9UwEv7FSabVQEiU?=
 =?us-ascii?Q?O/QqdqmG676fO1sy4ZkdWAaDGsjLvSHA3UdsrIhj/6oUZW7hC61uXvTggkWX?=
 =?us-ascii?Q?3O280t2K20F62geVnWemHndzuyy30kKGxrJdNE26aXHYIpHtNxXxFgCVXGuu?=
 =?us-ascii?Q?nsN5lKcpXgA91PT7Axo8RaO7j8sGI8wcSNTw3PhEBsruIo1pb8y7dLQrKISh?=
 =?us-ascii?Q?w/HRVpabUcvJLGQJ8fW1/Q+Oow0mb9C5upiaROaSITcl8PoKeh9Ir3HJt2ej?=
 =?us-ascii?Q?PS6YXOozqy1vc2pQWNM/cIAsOjm+VmJ5E4p1Rw8zId688yMy3HSP06vgQxyM?=
 =?us-ascii?Q?XW7G7SHRRtY8rtGJDTcT1Z2M78Qjyks8vQI9Zu21lmv1Sx+738J85UvRGS7r?=
 =?us-ascii?Q?BPWZ2KtaazG7BJVglDJnm1RfLfX8gfhx2IkUyM0JA7r00cJcoNO43Iuff9ga?=
 =?us-ascii?Q?tiYKwdqGxCD9BGAZHGEWMdyNmEcROh7jKaPNG9rzgoXiH1T50W045M8AofwN?=
 =?us-ascii?Q?Or6ZCHaTtPDuAUN0npooSQYyFU8zR/cylOhi9rfSO3ZOQWBGngaaGM2uZIj+?=
 =?us-ascii?Q?VxYTAgk4SvHT4bCMki6beJc0o3KHlIwWNJtwnuVorQA/brdoJeOTv4HudiNG?=
 =?us-ascii?Q?DaLgcj9iaYLlkXgD4SuAaVikv9xJCknIjmsu2XCY+ZUL+8bEmyTwmXwe0HEe?=
 =?us-ascii?Q?+lt0C5D3G8FM3HLmtn7z9BR1gpLDCc9qAWwRmlLIuWHJKkjqPUOcSZclOg2g?=
 =?us-ascii?Q?sdol6nBGYLgO6mgEja89Cgg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7377bef0-b1bb-42b1-2a8f-08db7a1b8a99
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 10:11:31.1843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KA8tliZ6Xro6aLaDPZ3LeWY61u/Usmw5geetvZlHxXY7bV+CvEccCRjsi3vfU36/chcYOiWl02eMnIoTOeewEjzk+VMy08uX6cJcPCQ7qY=
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

Fill the image with a pattern to generate entries in the BAT, set the first
BAT entry outside the image, try to read the corrupted image. At the image
opening it should be repaired, check for zeroes in the first cluster.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 tests/qemu-iotests/tests/parallels-checks     | 71 +++++++++++++++++++
 tests/qemu-iotests/tests/parallels-checks.out | 12 ++++
 2 files changed, 83 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/parallels-checks
 create mode 100644 tests/qemu-iotests/tests/parallels-checks.out

diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
new file mode 100755
index 0000000000..055ce34766
--- /dev/null
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -0,0 +1,71 @@
+#!/usr/bin/env bash
+# group: rw quick
+#
+# Test qemu-img check for parallels format
+#
+# Copyright (C) 2022 Virtuozzo International GmbH
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+# creator
+owner=alexander.ivanov@virtuozzo.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ../common.rc
+. ../common.filter
+
+_supported_fmt parallels
+_supported_proto file
+_supported_os Linux
+
+SIZE=$((4 * 1024 * 1024))
+IMGFMT=parallels
+CLUSTER_SIZE_OFFSET=28
+BAT_OFFSET=64
+
+_make_test_img $SIZE
+
+CLUSTER_SIZE=$(peek_file_le $TEST_IMG $CLUSTER_SIZE_OFFSET 4)
+CLUSTER_SIZE=$((CLUSTER_SIZE * 512))
+LAST_CLUSTER_OFF=$((SIZE - CLUSTER_SIZE))
+LAST_CLUSTER=$((LAST_CLUSTER_OFF/CLUSTER_SIZE))
+
+echo "== TEST OUT OF IMAGE CHECK =="
+
+echo "== write pattern =="
+{ $QEMU_IO -c "write -P 0x11 0 $SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== corrupt image =="
+cluster=$(($LAST_CLUSTER + 2))
+poke_file "$TEST_IMG" "$BAT_OFFSET" "\x$cluster\x00\x00\x00"
+
+echo "== read corrupted image with repairing =="
+{ $QEMU_IO -c "read -P 0x00 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
new file mode 100644
index 0000000000..ea4dcef0a6
--- /dev/null
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -0,0 +1,12 @@
+QA output created by parallels-checks
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== TEST OUT OF IMAGE CHECK ==
+== write pattern ==
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== corrupt image ==
+== read corrupted image with repairing ==
+Repairing cluster 0 is outside image
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+*** done
-- 
2.34.1


