Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4857CFA32
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:02:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtScN-0005fr-CU; Thu, 19 Oct 2023 08:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScK-0005fU-3A; Thu, 19 Oct 2023 08:59:12 -0400
Received: from mail-vi1eur05on20717.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::717]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScH-0002ew-Uj; Thu, 19 Oct 2023 08:59:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/TjrgP/yhBG3areZqyQ8ZFPIkaQ1EWb50VkcU3RGv+UICJ55cyQZkV4Rftj3wD59u9Dw/nsANbzu5bDS+KLyz1XoJUNosK/BmlAZa+JPgNBCp4L5l6itcNPbhpmXzt28kZsg+9FQCLBk0mQPbFQ9eWCuJBOvHK55QOIRf26gnffeko+5VPWCNzaMk9MbG7YjAakLJXRprqnIzRtPqjzhd/6lM0l1U7Q7NGMGcbhmLu44aZPnB6GAt68gzO1xJtbMpCpb6i2KdgFX0PsW2p2QOfILMh1kC5mkJxMN96yTMtHPhOIXkbizM5qOe/+vTnIoBIFNxlddtXeS43LKOJeYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8z8dgV7RCTVE/nGdwEZcc1Sb2eXV2j9Jtwj9hm2WdA=;
 b=PTWmLMZhgxinsYYIpVnmnXG3TWejz8nbVmsWQKFIgp3Y0Mc5W04qCRgVYLYr0rMeoJ57Gi8iv6+WT2bvNAEZdPREDGnBfhlTVIU00sVErG5buVk7VlJ0KgKYEgBjRkjLmkEVsnQ1tzeCT3wPzkM6BcWAQbppLqxYqPBt/B78VIRYT959htpX91FjAph+sYLxjoXiPbfeIkiwgnSQfDEt82IrGk3Yv7ka314jBmmOIZ91GzjfdobTxROYIxIc5ogEnh9MmkjiZSTTi7F1LzhOdpw51w/y4OiqS+35h5qSZFFfXgQwPcex1b9DdbYiMLkPRUReGyJVNV7noLFqQFalDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8z8dgV7RCTVE/nGdwEZcc1Sb2eXV2j9Jtwj9hm2WdA=;
 b=UKxzqJwX18pv7kKBygE8XGvIZ8gXiKVmq+MHU/RDRWpv4QOkYzMm75iyMBlyqOP20EY55bAGyaKDGd7r+eeW61knoUJkkdP0m/kXv+jz7VGfH94FCUGntEq2pmaQMPtzuFO70mFGvZAfssohMb32V0HZCTPSCrMHf4/8YQFzZXGRWxYqrhJTzonkOID+vrBMbODEloJSZ/WGToabTMVTIGu2pkwr9kjFOO/k39cBtq9wAmHh8OlXf1i5plPyfT5wgPS/5cn/wD4o5wpwmvcQ2RZq5NxRLaJnOX5Jd/ayV+3GoNCFt/h2npwqV8ealJewxs0sfUqJRB6XhtH2lqNdBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS4PR08MB7997.eurprd08.prod.outlook.com (2603:10a6:20b:580::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 12:59:03 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:03 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 00/20] parallels: Add full dirty bitmap support
Date: Thu, 19 Oct 2023 14:58:34 +0200
Message-Id: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::39) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|AS4PR08MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: e458edf9-8c7b-45c2-b7b8-08dbd0a32b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oc3J0B2uQQHIPDSN7RWBWHcXkCqN7q9e5lF9CbX35A+uYdFDn/WqPopvtfJHcCsC3+S8+Litp9t3PGiNwHFwZXbmRVbtjtRlcH5Gpkl/Bdn8aIzamHkuOjzrDWDoRYxVPZNhGKgo9i+xyoEwA+2FFrZXl1ZkFUdy03tBN3rGBEthcWPHVaJDE5BQjWAoLzU0qKMorLbrD0q0iJ0t2iFhMKA/2ygTblrIvMWllvK1H5527c8kMhwtkvTZgmvtuNqmiaFB4pkwwT+M/mwpIM7bgIrKJAIEh3Qk/eMM4OldF0piLhAvNuBkom31ASL8CInvKX/YWqs98t64fmI5pcWe3VTYI9VkQBEbQvhx5bfVRqgJ5OFe0fbAhor1YDC4+2rSnWObF1szeevloYHGTyjC2Bd3Difvtlvzdq7vJ57wWoyV5liEqmZ9MFTj2AfLK65Y9xk4pXGUWe2/6m6LEBgLWjtrQ8Y5eLUGYr1xpeJX+37qcpHRyQ60Q1Mhh+W54LleIZW6REGXHL4qkIsM+k0zJR3ndU2RC+sOvk8GZVTJnKrgEjVHqe9UXuC9gDcVW4HzPU3YYZsAjbpxdM0yFTPO7/Z0zJwY88wdJLTBElsQD8q11zXNoYE6+pJ9V1xNKxvt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(2906002)(8936002)(52116002)(966005)(66476007)(6916009)(66946007)(41300700001)(316002)(86362001)(6512007)(66556008)(478600001)(6666004)(6486002)(6506007)(44832011)(8676002)(36756003)(4326008)(2616005)(1076003)(38100700002)(5660300002)(26005)(83380400001)(38350700005)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TV9MsPRSqdrkxqdHDTnA5v5BARjFq8xloy1f0ZDgWGN2xPzlFQcn7ng3hnE+?=
 =?us-ascii?Q?sV8ZY4s1Qm6X2eSxi+7kVvE7hp83hn75IqfCGz47XxAQ7joO4s4OEK5E6oNz?=
 =?us-ascii?Q?p5CU0E3H9r3BdVgD7/3/S6zgoyPP5wB6XNB+4wVx0npzORWQARsw5H6VNkef?=
 =?us-ascii?Q?5P2MfMDwYtfIzEcqq52GK4W+S7ohFH5xI2I8lM7c79wBTj5Qj2+hNJjLKEZU?=
 =?us-ascii?Q?NCmItSXs86AskWTrwGCiBfB1sOEHV8MKiOLcMkugFgnKfpA2h8Wmpw4CA/HC?=
 =?us-ascii?Q?ZUvqPU6bibnj/vI67GlIz6sVujCuX0KGTfU+CgtdmGCaaGyMb29aNTXCnp+c?=
 =?us-ascii?Q?Roo3AmanilBjx2hFlfQT5G1l/ACgjbGrAAivY1fEXAZRR6InFkMvyaERYzkz?=
 =?us-ascii?Q?5ijiOdlRZG0BWpOZw5sz0+KQ8kxyOrJB/xHgz9R2vVe5WLEx5/LuM19voYW1?=
 =?us-ascii?Q?JdOTtXWR1jfFH4/O4oorlSFwBk18t52dVzMBGXOL1FIMttsjAwNilJqfD0dG?=
 =?us-ascii?Q?kWxqyldAVlgKE02z/toUhRTzxvnVowvwt0ypFGa5OvWXl7u6fgDPp/FVoCFj?=
 =?us-ascii?Q?Sx1T8NxepvrLcWAOGt6S3fx1m+yj+00GQ4KJwKD1KeMPlS4yw1KhwgBc7TS/?=
 =?us-ascii?Q?18rKAJeiU/0hWO7y6vQDJOUifm4hypB6daMp4C6rM7UyPGZDjRGer447tG6H?=
 =?us-ascii?Q?IrleYPYwfrpYD5AbknxqjZoeLyqRr1jqs9e2aAp6UwhQ0RJ+AtoVwz1mG/au?=
 =?us-ascii?Q?Le9LcLV34SRgO8R3yT3CvHc7J7Xl8pI61Ya//EE8slOiXuDbknzmuvVD0SdX?=
 =?us-ascii?Q?ZcAEnmWvdAU7NyXQxk/c4KUV7NGBY9gInDX2h4T0Ynm7Ruf0fQjlpY9AazBH?=
 =?us-ascii?Q?PcHwVlE0vYh1Fgb5Frj1RjcprsjhX3POk3Qvy7zDupBJ33ITqqxha6ojPGcF?=
 =?us-ascii?Q?FZlk2BA5gqWNjpGitMkqqqfee4iFe1npELbkFnF8cCk7Oj1PAFv99n7+QLiw?=
 =?us-ascii?Q?GcccfgwgZzFUfxYECeHZNOpAQd8MJnMh5O58luAiHsRo0Dz0T2Gh5sXieaMt?=
 =?us-ascii?Q?j9/zzoRJ8yYsBPq83DCwr4Rs6X62Kd8k/dW4RxhtJfQ0kFhAyM9kZJxvr6Ii?=
 =?us-ascii?Q?BqracOdzChNPgvicc91AqMtlCkol6jt7AO99Ptq+ts9jVwVY72DtVdNCGp1/?=
 =?us-ascii?Q?F3GNrAEtHis7YU2iuB1ZDXTyuGzz6cF7OBzqLhFvgQAItkYQ+am/W8bsf2pq?=
 =?us-ascii?Q?ntROJ9ugsvzDey7teTE/KJJtrEAzcJiwmt77Q58cZ5IT7hZ6wgGvmqcwBEGi?=
 =?us-ascii?Q?gq+a10PnUsKTR4MzPSKqueNvIrkzv6dRM7EIsAaeo6zl8p4IuTY6sXIxC50z?=
 =?us-ascii?Q?iCaR17VTMiB3et2BoLDSYmH/r4Jz/vGK3ZalMJG2p5QjXW0JOx665aQb1Ajq?=
 =?us-ascii?Q?hWrb+K8MlxlZhZl8yOJX3gGdbkIyFr9obOUwE9dYXoLKBJBBeGMmwJSKacA7?=
 =?us-ascii?Q?wsCDjuEJtvUhoOBE/hcHQTGO1uMCVGCsenlfT67aN0D+4Mu+f4RtfyeZ+TIs?=
 =?us-ascii?Q?uxdd8NkLx5UH/58fyhFGsDUthyRUftEMQvW/Xv6Y/cUlbrRvFPwSOcL+oLZj?=
 =?us-ascii?Q?zypkWZVmAGfz0cI2cAbFpIA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e458edf9-8c7b-45c2-b7b8-08dbd0a32b74
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:03.2218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seAxljT/3nrlR8ZY+OASo5J/K0mVad+5DIFe5FKD0GbhTayeiO4nQPDwa8hvjeByMSu6y7G4QFgFlZjp1jGo7M8Cr8oGbBcvlBFs9Yuza1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7997
Received-SPF: pass client-ip=2a01:111:f400:7d00::717;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
https://github.com/AlexanderIvanov-Virtuozzo/qemu/tree/parallels-v2

v2:
1: New patch to fix double free error.
4: Fixed clusters leaks.
15: Fixed (end_off != s->used_bmap_size) handling in parallels_truncate_unused_clusters().
16,17: Changed the sequence of the patches - in this way we have correct leaks check.

Alexander Ivanov (20):
  parallels: Set s->used_bmap to NULL in parallels_free_used_bitmap()
  parallels: Move inactivation code to a separate function
  parallels: Add mark_unused() helper
  parallels: Move host clusters allocation to a separate function
  parallels: Set data_end value in parallels_check_leak()
  parallels: Recreate used bitmap in parallels_check_leak()
  parallels: Add a note about used bitmap in parallels_check_duplicate()
  parallels: Create used bitmap even if checks needed
  parallels: Make mark_used() and mark_unused() global functions
  parallels: Add dirty bitmaps saving
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
 block/parallels.c                           | 361 ++++++++++++--------
 block/parallels.h                           |  15 +-
 tests/qemu-iotests/165                      |  40 ++-
 tests/qemu-iotests/256                      |   2 +-
 tests/qemu-iotests/299                      |   2 +-
 tests/qemu-iotests/304                      |   2 +-
 tests/qemu-iotests/tests/block-status-cache |   2 +-
 tests/qemu-iotests/tests/image-fleecing     |  13 +-
 9 files changed, 447 insertions(+), 172 deletions(-)

-- 
2.34.1


