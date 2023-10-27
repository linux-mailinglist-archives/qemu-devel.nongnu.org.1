Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D857D9037
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:47:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHYp-00078r-KE; Fri, 27 Oct 2023 03:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYW-00076w-LB; Fri, 27 Oct 2023 03:46:56 -0400
Received: from mail-db5eur02on20701.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::701]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYU-0003ya-2r; Fri, 27 Oct 2023 03:46:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BP/LhFOuayRybVu6j2hgPUqlhREWqnGEpmuCBXWQf+xkcqqUdbR36Nw0rKa1G/034Eox3CG1HfS169mjwOwZB782kg5G+EgsCfbvC5qkd+61JAKpDszrxu7blwhwpmK6LGGr05mjq8Xv6q40ttF979UjC2Rqba4q1qhTzj5ZuJlOQ7dLbfD5vIq/G1zoFhmcwg2uz0y7ihm9rQIzi+IDhzQggeogfLdeeb+AZBPtPp6ARS4DdSiBVo5v9A/G43mnp6WV0hCzCn7FSJ0Oyi7M4s+tA7brI8tcPID8ua0RXTSwvC8MGeCole09QCVyTgtp9Eb/UXrriCaJHPKmIYcp+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9vsxLKZlpMHgQIm0TR6UHeUnNhRWfDMmYA1/4O9rlA=;
 b=KUasv8qwHnkEfhcGSW1u2+VbRzSOqdqSx5VRozxI7dT7pkAnKaWYD+Hjmp4SB/LkSRE5df4TH1WnpSbg1Pq0Gs+3uP+JlY3iGHXIXUPFlvhICQ2xeuSbGLsj+EpzSNPUNsGo/UCmW7N04d28ra7OUad4sJSHe6vRvuFDn4gJP9kS02ZNZMfWV2MJG4s5mYCb/3Vzbcn4pXyuCGdCYPf0U3r0LuGFBpUny9EiQjJ61ZT/HYLcilpI9wrJEv4RlKQA0omzdTP5YG+Wes38gWJiMl0N+FbABgKlzgZycUUMd3rHWfbJ/AW8C1s8i+AcIg4bHZYXxf4C1TWRHUyqeCy0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9vsxLKZlpMHgQIm0TR6UHeUnNhRWfDMmYA1/4O9rlA=;
 b=JvS6mjqkGFFNUr2J+wkKOZJf4c29Tcu44y13aUTh2/k8xGGW3oReZeGRnI1ZIaMrHXE01h5tDrCgSU/LjcevGDfxbNYKG+Sn6LtwsXBrUAUer6az4BM2WMqNW3myG9xMLmeTxMBr46OeIm0F7Li0ZTCRmmE50QtkGDqGmfdFnG7EDvvHDCNcixrhTKXlUSbvIysY9V/MB4+aUXkC0S0KFCH1gAfG2dQ0RKI3W29sVWYCYPwX5JtfzfHBX2xsTOPHwJOHH6vw03WwtLMoEF3Gsi0nzOA6CMZpHTEwvJjqoB6pexuI1ZQCUw1+mrmzmpqTg5zskgwqT1R9D2g0smFuXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB4PR08MB8056.eurprd08.prod.outlook.com
 (2603:10a6:10:387::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 07:46:43 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:46:43 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 00/21] parallels: Add full dirty bitmap support
Date: Fri, 27 Oct 2023 09:46:15 +0200
Message-Id: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0101.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::30) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DB4PR08MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: d668da4c-048e-4451-2d33-08dbd6c0dcb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHHlx3P0O4D57ns7m1yU+H0ad+L1HwKtMWxav0bDJ7IRgmTcVbjL/470cTyK3qo3Gn3zzW/uFiT6y47DSIOozO7jQJPw4hSB9Re7m1UO6WKfNlxgiK/XVCU/+VDo4+D0O/cBFaQVWKY3JZ5/azKjwp6OSg3JQis3bLOfoIXb0v9IOTZgCcvf1r9SF4VOlmuCs5SXTfwMDxs+oIlRX8uX4y/x6KVyp/ELaTVBVS8Rpr4DvzgmRi7CPCjMuJpt/sKY7eybJ9hNFGdKqIzhIhtjynvlCHp4+tHS6aimh63H5G12jtvYpieSSB8mhR5/lxFjAwPCOBGzHniR55P2t5lowWBe4/E0UxbUauAk68ZZFNNmRelpsN1HZ+Hpfy3o9RxtWsZI2M6V9R2sKWf+u++6fVqwuii0xcnWLboUI/BLnh7SwNMU44lhE3HSxAFoMYOv7mLfs2V43st6uYbb9f8Era1HIsXTikViS5LtLFnG3qNK0qq4iqXCB59Wji0OipDF9eHOQ+PskaTmPen3YGQGtek+VvyIP5BPB+87SZd31mhQgsHVQla6sh75aRdd5WnrQRek7qCmXUmfXfyG4cS6sGPAO5HmMwTwg6StOBMPx8k+fzwtbxbzQQBIxEZD353/w468u0+esBCmSH/Dcce23XZ6+kbzhjR2+VwOki8KtOk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(6512007)(6666004)(52116002)(966005)(6486002)(6506007)(478600001)(38100700002)(86362001)(36756003)(2906002)(66556008)(2616005)(26005)(1076003)(4326008)(8936002)(316002)(66946007)(6916009)(44832011)(5660300002)(66476007)(41300700001)(8676002)(83380400001)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QcvWonIxtDhrZatPTORohJX3ZtOUJVau+Kv99q0XGm9JGXy5wlOFHIW2fqno?=
 =?us-ascii?Q?O7Ct9+8dtD0cREPyeB1mKEmo0o0bh5SQ93GFoOHOGUvMG9MlrA2XgWGDOKWn?=
 =?us-ascii?Q?dpl48QS3ZV3zSvzWPM647+ZHZiKF7/S1YDLu0QbIyURh6CWfI1/8gSEPZkn3?=
 =?us-ascii?Q?BG0Xm9yBWY/Oo9Fix8Z/jA10SGZMny1RjzqwozPOn728/ssDIXomNbXGviUi?=
 =?us-ascii?Q?0ez6hzZoKoY+IRc4hMBba/XXOOCXKnUzXGCBuCFUyeMoPiDbSu8yx7EOMXqF?=
 =?us-ascii?Q?PvHN3lYgf+ZFXQRw667H0Z8mleoyxLTYu0hAu+AiSwdyzKmk3YMhOdlB6pa2?=
 =?us-ascii?Q?GHvmgSDMBRbPB9+4nrv/2G1yK8mxT8x0XW/u9iaMHpuQoa6s3HLCisYgMxXR?=
 =?us-ascii?Q?Xm5cPXC0PvcEW90NE0O4PqzShwzRMMmE9zS6OCIPJRzp7zcDjKxQPNPbgAXP?=
 =?us-ascii?Q?RYpGvsz8TWjFwbZ7H7wYMQP9qy/ekjV+I0eBnvl7URlahJHbFUJykahLaK7H?=
 =?us-ascii?Q?eFfdT5tC2XLmcCk9iL3SSPqSFTmb/DJeBXwMlOnkShr4VOF/4jCxUB98Qnlt?=
 =?us-ascii?Q?oUX+ruXi559mZDg5Qkzp50rFURP9ggFq4rMgdTc6Vmfxxjyevmt65NCSXrwa?=
 =?us-ascii?Q?iGAEuDWuobbVoyhG9bWDoNClCZVe2qwTKnkSVdEds5a6xpdmoOkGI5WydukT?=
 =?us-ascii?Q?PEzRzkpvqG4UYUjs4CG6V60zK0hQ26Td+VInFYVHLRKr2dDbrcD7RE4S9D7D?=
 =?us-ascii?Q?ZSutgrI/C8Jvpp6SN4P3B4nZ07C9oOC3KANMONIXZjxEeTDzPupwwyYgqQSo?=
 =?us-ascii?Q?m+/5MG09Om9JMwR8lTFqzgx2UdqOeuuulXiXAfF6xGv2byU00nvPo6J5RXFE?=
 =?us-ascii?Q?JtCX9CaLHxBept6EenkkB1rtFLatkbulOkRwZF6F6i7zvUAylzN4hZyoH3Su?=
 =?us-ascii?Q?F4q10ieKcTVrDks0EF/TL9VDg/U++p+ghLokrPe8mYPtGcTdfPk+Ey70yBKd?=
 =?us-ascii?Q?WNwb+30cNR+wW4gNlLfPxe8sp6G+C04F2fCuRkPHo6qOVPzaoDP6Y+UbwHan?=
 =?us-ascii?Q?f1Wt1GrtjzIqtsOBZdzn5R1ceRNSIZZ0MNmW8M9XE2CVzgXZ/3ZuZJulF49J?=
 =?us-ascii?Q?tJCEkpcS4dMbHYff/3kUZ0Ar62czlNebGA1bMzAJGHfRtr+EVAq6BpJ8VVGg?=
 =?us-ascii?Q?Ws5RO8aQriWwCa9kbB697Rf5kFNlVA3WbXoiB8hqqq3+TOX6g4X7RpuByeP+?=
 =?us-ascii?Q?bJAsVsGWdADXhxAs5SLxW0k6BOjAaE3V2ziTpvAwEOMbQP7y9m5+2Z49ry/6?=
 =?us-ascii?Q?nhoi3iOB8VgAY/Bz/JTTeWeGGDZgMN8cOcAjSjfnVUkcus19F98nscAwyIMn?=
 =?us-ascii?Q?cPs8mtdz1mORxyhaHx+1g1DhtpTT3s8QAKnVGLOsyIeW1DJ3najC3dDIp4lh?=
 =?us-ascii?Q?7FJyKPQn16qsS7+86N8NQi+3GGKN3sHLlC+6HU02gtw3EtvP/8NT3wSFHCy+?=
 =?us-ascii?Q?aWtoENcsLE/32ZIhlp1xHEDmm7fQ+D5vXlPwJyG9VLOghG1XAdG4i4B0e5FA?=
 =?us-ascii?Q?2lVFWa6gwtt1SLpY5VhX53w1OWGOZ5d+hBaWWR5Yr5Ivs8fxA6nDhPovidI4?=
 =?us-ascii?Q?tcPJFQz0WUK3agaOd371bHU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d668da4c-048e-4451-2d33-08dbd6c0dcb0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:42.9502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7omYQihqpHdkgOO4znNQhvJXiSmufcVb8dY0V7wD+fkKYS1jiN6PKN46WXq+v0lMeOdArbtBzGA3CQTXzDj30lDgIxvX6wUjfwcNTdVS3Vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056
Received-SPF: pass client-ip=2a01:111:f400:fe12::701;
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

Parallels format driver:
* make some preparation
* add dirty bitmap saving
* make dirty bitmap RW
* fix broken checks
* refactor leak check
* add parallels format support to several tests

You could find these patches in my repo:
https://github.com/AlexanderIvanov-Virtuozzo/qemu/tree/parallels-v3

v3:
1: Fixed the order of g_free() and s->used_bmap = NULL.
3,4: Made mark_used() a global function before mark_unused() addition. In
     this way we can avoid compilation warnings.
5-9: Patches shifted.
11: Added GRAPH_RDLOCK annotation to parallels_inactivate(). Guard
    parallels_close() with GRAPH_RDLOCK_GUARD_MAINLOOP().
12-21: Patches shifted.

v2:
1: New patch to fix double free error.
4: Fixed clusters leaks.
15: Fixed (end_off != s->used_bmap_size) handling in parallels_truncate_unused_clusters().
16,17: Changed the sequence of the patches - in this way we have correct leaks check.


Alexander Ivanov (21):
  parallels: Set s->used_bmap to NULL in parallels_free_used_bitmap()
  parallels: Move inactivation code to a separate function
  parallels: Make mark_used() a global function
  parallels: Add parallels_mark_unused() helper
  parallels: Move host clusters allocation to a separate function
  parallels: Set data_end value in parallels_check_leak()
  parallels: Recreate used bitmap in parallels_check_leak()
  parallels: Add a note about used bitmap in parallels_check_duplicate()
  parallels: Create used bitmap even if checks needed
  parallels: Add dirty bitmaps saving
  parallels: Mark parallels_inactivate GRAPH_RDLOCK, guard
    parallels_close
  parallels: Let image extensions work in RW mode
  parallels: Handle L1 entries equal to one
  parallels: Make a loaded dirty bitmap persistent
  parallels: Reverse a conditional in parallels_check_leak() to reduce
    indents
  parallels: Truncate images on the last used cluster
  parallels: Check unused clusters in parallels_check_leak()
  parallels: Remove unnecessary data_end field
  tests: Add parallels images support to test 165
  tests: Turned on 256, 299, 304 and block-status-cache for parallels
    format
  tests: Add parallels format support to image-fleecing

 block/parallels-ext.c                       | 182 +++++++++-
 block/parallels.c                           | 366 ++++++++++++--------
 block/parallels.h                           |  15 +-
 tests/qemu-iotests/165                      |  40 ++-
 tests/qemu-iotests/256                      |   2 +-
 tests/qemu-iotests/299                      |   2 +-
 tests/qemu-iotests/304                      |   2 +-
 tests/qemu-iotests/tests/block-status-cache |   2 +-
 tests/qemu-iotests/tests/image-fleecing     |  13 +-
 9 files changed, 451 insertions(+), 173 deletions(-)

-- 
2.34.1


