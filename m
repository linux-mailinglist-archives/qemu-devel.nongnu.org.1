Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D01E7B4E51
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 10:58:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEkm-0001Re-Q4; Mon, 02 Oct 2023 04:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkd-0001Qp-WB; Mon, 02 Oct 2023 04:58:05 -0400
Received: from mail-vi1eur02on2070d.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::70d]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkb-0003Q6-6w; Mon, 02 Oct 2023 04:58:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtXOxK9TyTWF7Ohx0iM0QsbKnL9PutiEBtvDd8PAO1p01+aDbjFH56elbKt0SEt9cM/SW8Apuj+ZK1lc/JHIY8X7TbrXjtjIlZ19TogvkfRohkeARkkwmrBuxx8Cbq0CZ87F/Gx8HPx+zKexP5RV/mwJk0bmwOnvfaDQhy+g83IpiSSFCFNYdpYcwmiSuaZaS8qgxGEB7o5yxJSTjWWn1zwyN05W6amIAlXMC2+oZJ8i74bJO9h1F6xaPqEP+sTLx28PhEtgjpjJqtfinRiiYzwiuWr7IKKNpjgMcI2nB1mUU8K52ruaWFX4ckoUnXwfTuQBKw4tWi+3e0IvLgw6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekGZtNqNQcYhkQjUbgxcwD6w0xYcPQutjAiXsHcWcI0=;
 b=AN/kDNqd8YiPSUoL4KxdHG4aA825/90OvclqybRns0jauVu1wlTkvm5teLxg3qzg8/S8pih3Wgkm/EhT6DnjotDq3gtNCVGI32NwD1qBiJNO99XHPanr3D7wF+h2PcQ1z8pGTeospvxxajGr7pzA4nhiafAvLlwX6EAsCeUHoSTbpBc5zjFROc8utpe4OMgVgeHzCPtG3Ucfm5uv0EHFy+oY4dKHHTQ+AspfXDOCCMuPMi5L42GiX9SltbqAWpPMW+bhLwx78laGCPJr8/IJGH6x1URDJVXLVb1IT/dRokyGb2QYXtfIYWSqkxyYIdP95Yf3iW4uzRZapjadt3kW2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekGZtNqNQcYhkQjUbgxcwD6w0xYcPQutjAiXsHcWcI0=;
 b=N+l+Qtym09eg3T7fE75p+N+5f0CZACsBVK387WLbSq6cdjBUFTlmoFgS5v3RtdlND3OelpgVLJHAA1sWFQxK4SGw+DDo6YqwyxcxCyFqgsL/VE4DvrOGq+OekMzVDxHSq4wlCefiU7qz36pW7DD/j3fC7T0edo0gr5aVVIalYzwu6SWbD+wv2/89VuZEWog3HbX0mo3O4oCpIeIv5Tufg82BZ7MwlUSp1HmoIdao06Eae3T99UTC/YJ0uQajBZA2MNA6AyrjG34WX8sqq2AiHsJ4vktfcegAzTttzLlU1tQSgqfyjk/fQWPdFkijoGoCNai+fUbtkbx9Sdi4fzDnmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8273.eurprd08.prod.outlook.com (2603:10a6:20b:537::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 2 Oct
 2023 08:57:47 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 08:57:46 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 00/19]  parallels: Add full dirty bitmap support
Date: Mon,  2 Oct 2023 10:57:19 +0200
Message-Id: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::45) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|AS8PR08MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5689d8-5b2e-4c59-23b0-08dbc325a59d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UbaYS7Ik/DCMxm8rxiMb9nIFbuVXpQGdVInVHG3xZhOPrydPhyP4cffPRyrVKuS9YqZFGPvFCe4Yd0itwy2cdRjdkNco9gz7vjyU4XYJ0H+n7/3jMrkoiE2AGus87MukrRtzqgCuX3qUJh3nQr344m12CE0ilIgziyAMDBc/alLE8GDTfrPLr2Q/c/C7IQECZomqkc7JT3seh46PtPYv5jZO1wSAgHX+vU5/BLxwQfPkcuVbdCKvyMiAjTYLBk8nME+6iM960CYpkWnnOMzJ9xN1N0umjyotbtwnsEM5jcmRfdVgHGrocuPnLhOXgVTQ8o/3P6bUwropRL0xWDKCaphevG2Fa12n7fsZflbsfDXEKvpsWjNG5vgW/LmaoG5MUY3gPXLCVUEbIUjUWHxB0KhIAOGP00WCXt9quV/zh9AYvI3R4szfw1w4adH/K7Oz+JBfGPwlAjlidyyg1BIHNEO17TYiKoG3SxUJ8wsDSsNzzPOY3RwLTisz1eUS2APJMyBgZGdb7UhMeNYgRLg5tzD3bkkk6hSjlkM7DhF1icFdraUVn01iRqYzIiQj5AwKP4DWs2ucxT+ifbtb57LeX9sIny5JpawBUrgptI1Bd3hkrSz6AXF+IG5C+pYM4TbVFrA+Uo940jwNMD9rhAyLXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(39840400004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(1076003)(38100700002)(2616005)(26005)(6506007)(52116002)(6486002)(6512007)(38350700002)(86362001)(83380400001)(36756003)(6666004)(316002)(8936002)(4326008)(8676002)(6916009)(41300700001)(66476007)(66556008)(66946007)(44832011)(2906002)(5660300002)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wqLZeg7PU3p0aDd62uYD7vtkxYAlyVvjUPnyjULuJCvLtz15hLwKvXuFvoIV?=
 =?us-ascii?Q?N6zeAwEYlY5ul+yHCVKjH4JEL9BZdi6Hjwl2An03oFRmd2atwB2XNSRCEgwT?=
 =?us-ascii?Q?wNYLAJ75QJbwAoDBHOVgBw995PW4rTVYZ0IPynxqizdVupeX/NlDmxgpvEEs?=
 =?us-ascii?Q?+CuFgRIWOe2aWkRsRzKtizkgFFNJG6uS2nrX4J7V8CKOCI73mfb41NDOxj2w?=
 =?us-ascii?Q?8LfFX/l9PZxQrMP1rNdOKPGswAN2iMKm+mzW6N/gSJrPiBucdy7XG9IRZ73B?=
 =?us-ascii?Q?ZkotvYj+0Tq29f3yGPnkkXdgH5jPUk7t2h5MMfLpAcKDWDIoiK1pH9zqjGw8?=
 =?us-ascii?Q?n6YuSBYiey6UKF6WanvmSBg2LSfYUZ31ReHe7BgF08jzvc2edvX74oMiNcT8?=
 =?us-ascii?Q?8siEpkln4ZkUWZ/PkzHtA5xovVgYDXxDOiJqsRk+7AWPcxUjg3Q3XKzcnto9?=
 =?us-ascii?Q?pTjO6ySFXQGDlOG3LnzU8ES8r8ykFcPKyig/QtiPtxuFpduljOUQY52awd7Q?=
 =?us-ascii?Q?25SIgictGA/Kni4WhvpwCtrwS9zbbVA7g4kjzLBGZmFFwFd8Czk46BMhL0AP?=
 =?us-ascii?Q?D3oH4/bQ1LpoF7i0uvAWXJIsqmWn2kZ4dYu9axNmWl8cnpGxpMHPTf3b5xd+?=
 =?us-ascii?Q?IqdEomRUgQlV96THSqfroWeKjpvz34duHt/TNoTSVrDZGsTJQ/k4VkZAMBnt?=
 =?us-ascii?Q?/uOvpcb8+Buz2Dax231KDwo+rP25AtudMwY5NAORu+rAG5YCMLZEkEcptBV+?=
 =?us-ascii?Q?ZU/rgdDrHx++zkweAqhVgN68Psq5daSk6T2T1S7T7HpliYZ6/DV7Jk8Qxy+g?=
 =?us-ascii?Q?wvJx8xPdiO2ublVawATHNPNgd/QZBfu7jqEcnDRP7EXcA1R1kX/B1UWtEti0?=
 =?us-ascii?Q?qb27JpC6olezDmsZ3mkiVIgh8ZVu7i0s87HsIA7ZtCvqiSqFPtin9CVR0mua?=
 =?us-ascii?Q?loEZdf4AN/L+o0sDqgoQ8+wdTsSzW9nIYxF7Vxg2RG/1SEGXqLjJKDx7QJAo?=
 =?us-ascii?Q?2pVVsw4IDdx5wFt2YIuUZYAmmYIVcUtcSq5OYmWPaWmVrHkiVFOueLPMLh1O?=
 =?us-ascii?Q?TtOyLIePPHTkh7V9awnMPWwhuyr0C+Mrk5Z7sro+1c6b6/Nt5jglxFVOZePa?=
 =?us-ascii?Q?jA9DIXtGOLNN2AwZ3+vZkZIolc4d/hzBX7Vc65GDGLMF0Q/lcW7Ppmu23h2H?=
 =?us-ascii?Q?IO6Lriq/sDQQFDGnkggRZ2H7NVPD4VL9+FGH/68c1GpTUOaDGxMBVga9eZP2?=
 =?us-ascii?Q?GBc3ewxhhlk2XhpnQFadFzdmkoffUi3rpWiA6m3E1HWN1IcMItPqUN8voG7z?=
 =?us-ascii?Q?I5mYtl9ffkMSrZCCgiXxCJO+VzcfpRJjTajSFB7EMTtCYLVBas3lGqHisjz/?=
 =?us-ascii?Q?6KMCIfgcfjVuSBX31nMszvqoOCW+Bk6ICdRi6SWzOrO8VvV7/2pE9nb6hR3L?=
 =?us-ascii?Q?TA8QsSqmJ111NZtZp8mXJXhPqApYu3StuQuai/80CYU0mv5LhyEl/vsoq83Z?=
 =?us-ascii?Q?ffl0Zd24dINjUHHeQkU74UNvyAtg10zyxofQ9bCygckqWTheHkGhqTgAi0BE?=
 =?us-ascii?Q?b7fn9h912qMK5t9H1lFWU2MpJrq7Pw8DB3ZC3R/uYS6GRL2IrROhwrN5Kn1S?=
 =?us-ascii?Q?JOSv6rCG4/dNdQlNDIoD/uw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5689d8-5b2e-4c59-23b0-08dbc325a59d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:57:46.4569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXCdeAuJ1vMF/c6DWA8kAz/s02nhLOB6+QxhIXKxXKdgxADIZbPjEFyeeqEug3ryUfh0hkLW3pUcpJvUcanYYySqr2K5G7eRpE5riEpFFfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8273
Received-SPF: pass client-ip=2a01:111:f400:fe16::70d;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
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

Alexander Ivanov (19):
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
  parallels: Remove unnecessary data_end field
  parallels: Check unused clusters in parallels_check_leak()
  tests: Add parallels images support to test 165
  tests: Turned on 256, 299, 304 and block-status-cache for parallels
    format
  tests: Add parallels format support to image-fleecing

 block/parallels-ext.c                       | 182 +++++++++-
 block/parallels.c                           | 357 ++++++++++++--------
 block/parallels.h                           |  15 +-
 tests/qemu-iotests/165                      |  42 ++-
 tests/qemu-iotests/256                      |   2 +-
 tests/qemu-iotests/299                      |   2 +-
 tests/qemu-iotests/304                      |   2 +-
 tests/qemu-iotests/tests/block-status-cache |   2 +-
 tests/qemu-iotests/tests/image-fleecing     |  13 +-
 9 files changed, 443 insertions(+), 174 deletions(-)

-- 
2.34.1


