Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9564674486A
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:12:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXa0-0000Uo-HL; Sat, 01 Jul 2023 06:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXZv-0000M8-Db; Sat, 01 Jul 2023 06:11:43 -0400
Received: from mail-db5eur02on20726.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::726]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXZt-0007vo-JP; Sat, 01 Jul 2023 06:11:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYo76WGwZwBviVW9ci4fzGqWreiU8N7RG6yfJ9lWWzzhyQGUoz5SnW8N1QaSdr2vfo7Elij/Y5L0bHmCqzDvWYk94LLBfsIkcg9TIphVqdVkrfW6WXyTTiiWE5eYAUsxfYEFLjAOjmQ01sMezhwgk4R8XxuasznqmxFXTyQI+pu9wlPs1FXh3dcgieQvnonCDmRcM5WlqgFnSZRvM+42XBTEXGFfmgo33SpzGWc6aYEKAti0SpZZTzqCGWFdai1fPcZbbmWV1LWrEZqTDtL5oltStyI34+9CNfuEPUhvJLdfIqTEI+GwGOrNKBKDmVImnpMHoaVF6x3vkCijwGdA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMtuEDsZPPYVTJR0XAZT0RO8NrvWC9VdXbxBI2KqGSw=;
 b=UJdd3QvzC9t9+PlwQHVheCg6gO+1DxAv0tKAmOoLP4qpq4MKud4fNfmu8J54lJKqHy5GiI2lj+b7FyjTZYmKO5yC+u8EKPaRfXRyWNrMLfbu2WxpAxzso+tzlBRmkCWhZezkd74agp4f3ic5f9Dl3Z/vjrq37v9ycp5umEB3T84CQj8LMgJZHmFDTW418mQCKhbJlCdKq58n6Chd0K4jcbG8gZ2/vp+esl52ioF2aLpzscCq9k5F5bdaPr5PLqyHq2Horj6rqgiN8i+F69kUyvPAYu/Pbj/rPIoXYmJlZxtFUeRJN3Rp7dR6edpzuhSo+LWbfclLY+idEgA/8Rmmnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMtuEDsZPPYVTJR0XAZT0RO8NrvWC9VdXbxBI2KqGSw=;
 b=poky/OKHA8KgZVxMJnLF+sQTNNuS/1fkum6DqIRc8zNN3xYE53aO0UKA/VlIu4pQHNjJiNho+LgavZnAqq6ANUT7CIv5vOCxNDoO1ek4QCa7ctve7snyrOvJlZPWXFVpzbknbKsAPTLvhMTODeuO6Dg0pJa7/z9Gk7lhswKg6xIUqxZAcAjV2gK+2lQp0GntnJavqY29Wt0+Xt73TFSBmHwh9XEYJeu3paXMDPChuul2nNAjlueg5v5mxLRw6cY2CWebTVd7T/hVfb2ohIF79PGhDqaCiap0C+zGkw4axbJJDxTP87clom3yof6Qb4labufowJ5DZTpXH3rikLfmRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS2PR08MB8832.eurprd08.prod.outlook.com (2603:10a6:20b:5e6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 10:11:33 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 10:11:33 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 6/7] iotests: Fix test 131 after repair was added to
 parallels_open()
Date: Sat,  1 Jul 2023 12:11:22 +0200
Message-Id: <20230701101123.261104-7-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 90bd23c4-04d2-407a-9059-08db7a1b8c35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0s9H2vZkJVoc1FRX+CB9IfoTE1W9May9SF07mu/7TB9Nhh+6LtWX86RdJQgoWqOhwSlkRIQvPHBZHnISwZYH4rYtdb6Wh9LX3H0npbe9OmQS3DA6rpOJLq3cveEGQpY/OTF4KsluJDatB21on3fS5uXpJ2RXAoaoe1QibGBdtq6H8M5dMuWh0pEfCXNkiTS0t7bJdSTTLmDS3JnH0v0RuidBGTIv5gjolhULDPqE0alM0LS5wVwJXwjf5jsWxVLHXw7qz43Fotg9q2WkCzuH+p+wKEacClYmG4EPqIbfMLWogMvGFBCN1mD6pXIYFWNNBPUE7xWmQKKjsXPPQ/dzkQ38dHLBZKJLlcEPOx9DfI7XbqNN5WlTASm2Eft7v1fRDVQP6qXoQVuzE1ZLwYKFoINhcXQXpiqggQWYyChVS3i61qrG7hFk+Yef4wVpaZVvkBzITBtik91C7HkXsRPQTcGzmY6anNhK2kOPUvQeySrzy1Ej4g0N19gSRCQg4IZqLf2ehVDBfs9V2BpHOmml/NPo+rJx5vIv+2Tilzs+kuE2d4PESDBYQo9By6YD5TVvPPv379BvTPz9JPmx2N3eVVgLEQUiWBxs61PpPeOUPXf2qOzXLzQCaHfZOI1ZUS6IHrBF+1cVmgIrLbxpRYDWZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6506007)(6512007)(86362001)(2616005)(186003)(38350700002)(38100700002)(6916009)(66556008)(66946007)(4326008)(66476007)(83380400001)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(44832011)(41300700001)(2906002)(36756003)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qWTLZZRQiAVASU54infm60O5y5lfJc0ICBoYS6/JQrLbOn/VPa6FOFAI5cVg?=
 =?us-ascii?Q?D+LqQQDlmIcclMeBVDTef/o7QGkcGzr8lWd+7J46Xd8wFlnwMVBCwAiwR8M3?=
 =?us-ascii?Q?TKEyAncj2Y+9EjYnYVkKrQoGUha3I43xmoPpDwA5r2ayF5rpt9xRr+kRCr1s?=
 =?us-ascii?Q?nr7wzG2ybkukXlYM7vteYIIaazZTDSO8pl8bHIF0v0f6H/W5u89hczspSLmY?=
 =?us-ascii?Q?RdPeNNaCZv2sQ/OuAzXI2rbC5n2c2Ge1+0hTOJJAm5ooHyx3sTL1g8C33NTn?=
 =?us-ascii?Q?mpg45JrDrZGlbGLOwJPuxv6psD0iiX+ZTw6C4gmWclpNlGvJg2AU8Jp7LfKA?=
 =?us-ascii?Q?Uiinw0IW9iNnVBhmedMkKMeMzJ6bC5VWYlTQl8Lcb47Z46OsbuPa4/f8Nkg8?=
 =?us-ascii?Q?0WHzgVsyJL8sD6I1mZv2QY0XAVPx8J+7H1XNminM7/Vtbz7coSD2kvHVlLH4?=
 =?us-ascii?Q?lTNtRXenRQFIV7kd1zBvbaU+ax7pdJ2OtIWEZnwWmMVTShCM3exQaTrTdbGn?=
 =?us-ascii?Q?zU8xse1oqWvaYIbhB9kUkio87zGCxKqytpDiAwqTui2Jh+kRwkRMYjOPS4MQ?=
 =?us-ascii?Q?Pw3esBqg8CYeiDw3CXN2sFa+vOhGKr+YP2S6lGIyP03sPTMMt4Hoo7okGEFh?=
 =?us-ascii?Q?0LXbW3b+W/k/iRQLx12k2RZyUXPbqahwFKsXtQnzH30PD0Y+F4tZo+i30qII?=
 =?us-ascii?Q?UTjw6T597FPo1v0LCYqw4EVQ2QMEATcpsqIuhunCpfyXfSvVrb4yy53FuvTC?=
 =?us-ascii?Q?XOqxb1uvu1cvm+Bx2sBD7sOKnqUCjytZ0oiulWqZmV5/6lvVbcHxScINn07g?=
 =?us-ascii?Q?B1ZXKPQuryRBFI3//Pnt41DeljPx4Dnfij0R0Wnrb26ddu3YleNt1rQVc+TF?=
 =?us-ascii?Q?JL94XdsGCloAOzkTTPOI1i1RyBhkiw/ismkX2k5A0r5QO43f0zFQDxiSnaoo?=
 =?us-ascii?Q?d8auExZ3LSpwZeVQFd2r3PjZckCqhLtpzKp6YdkVxLjJZYVIyHh6AP96PyPY?=
 =?us-ascii?Q?UfJVaBe7lRSdp8lKGGAKm3gkO97coVyoAnMBsS+iTiULBu1TgB5o6vYzhDyt?=
 =?us-ascii?Q?zDYXe4sBDEjJ/MbapoZjOE/lYBii+mEhtpnuK+Y5AJqbqtoG7Xi2uM19L6ox?=
 =?us-ascii?Q?Ti0SYxswlg2ItRE5Y0Zo0AbYe9tOkZuzYtCoyfQz+PGC8Wyx7mAKRvzqJKOC?=
 =?us-ascii?Q?5Gf/XU4fbsrKITlTMK7dinghs3y1WuP6DQWMFN/2OFtgfPVURjn4VGraKeh8?=
 =?us-ascii?Q?bNzgJNXUuhwZfamv3STMTWY3X9fJBPqVCGOhC5VZXi93J7ehmOOf5RspZE5f?=
 =?us-ascii?Q?6BEW4tQ6YxU5VGOt2B2gbo56iODoDM48W9Tq7Gw0h3tWE+8BaKFG2htae41b?=
 =?us-ascii?Q?aQqgQVTrGyRHu57GrRlAWP0u7BnMkM2U/4D/wvSTkmDK6/TAEFjCfJzPXiSM?=
 =?us-ascii?Q?4UyTJfKPmyYZBIOVHofgPCvJJr0DmqLvTXhcQ27SGZ74Cf6lc2dVcRn/Z865?=
 =?us-ascii?Q?/55efK4svONGW8l+EcUS68Ly63IzoN0Nird4Rt8vxjw/efHxSZE/P9LBMiEH?=
 =?us-ascii?Q?AZP/LVNBpMXf6Ce3CTJx8CQZjjWl66F3IQmJKAHnH3LGVoDVZ9GxvhZgotCD?=
 =?us-ascii?Q?EvQcF1gVT2hUwhcWPUxGMQg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90bd23c4-04d2-407a-9059-08db7a1b8c35
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 10:11:33.8939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQqiRDXl7rxME8DSOA6deGlC8qDzb9FJGXBD4aAlCV7g7dVgGlhGdThwNhWk2yNiRVONPMUhwFuQX85wNVIoWbzvRmTVxP9E3CRwrFDrlso=
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

Images repairing in parallels_open() was added, thus parallels tests fail.
Access to an image leads to repairing the image. Further image check don't
detect any corruption. Remove reads after image creation in test 131.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 tests/qemu-iotests/131     |  6 ++----
 tests/qemu-iotests/131.out | 15 ++-------------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/tests/qemu-iotests/131 b/tests/qemu-iotests/131
index 72f6535581..304bbb3f61 100755
--- a/tests/qemu-iotests/131
+++ b/tests/qemu-iotests/131
@@ -69,11 +69,9 @@ echo == check that there is no trash after written ==
 echo == check that there is no trash before written ==
 { $QEMU_IO -c "read -P 0 0 $CLUSTER_HALF_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
-echo "== Corrupt image =="
+echo "== corrupt image =="
 poke_file "$TEST_IMG" "$inuse_offset" "\x59\x6e\x6f\x74"
-{ $QEMU_IO -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
-_check_test_img
-_check_test_img -r all
+echo "== read corrupted image with repairing =="
 { $QEMU_IO -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo "== allocate with backing =="
diff --git a/tests/qemu-iotests/131.out b/tests/qemu-iotests/131.out
index 98017a067e..d2904578df 100644
--- a/tests/qemu-iotests/131.out
+++ b/tests/qemu-iotests/131.out
@@ -21,20 +21,9 @@ read 524288/524288 bytes at offset 2621440
 == check that there is no trash before written ==
 read 524288/524288 bytes at offset 0
 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-== Corrupt image ==
-qemu-io: can't open device TEST_DIR/t.parallels: parallels: Image was not closed correctly; cannot be opened read/write
-ERROR image was not closed correctly
-
-1 errors were found on the image.
-Data may be corrupted, or further writes to the image may corrupt it.
+== corrupt image ==
+== read corrupted image with repairing ==
 Repairing image was not closed correctly
-The following inconsistencies were found and repaired:
-
-    0 leaked clusters
-    1 corruptions
-
-Double checking the fixed image now...
-No errors were found on the image.
 read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == allocate with backing ==
-- 
2.34.1


