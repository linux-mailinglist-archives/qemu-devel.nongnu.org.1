Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9606481F664
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:44:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImuL-0008Ih-At; Thu, 28 Dec 2023 04:42:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuC-0008DZ-UV; Thu, 28 Dec 2023 04:42:21 -0500
Received: from mail-am6eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2612::701]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuB-0008Gn-Il; Thu, 28 Dec 2023 04:42:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMKGlacCvJk5YKKfvqHzgjEeYg8rahMK1h1SfBwZ4N/TsraiJ/6hdKkYzdj2pn+6pZBDhcsEuyhKXSVLp67OZrkTbSzwy6fw8IozWDr5J7q9Zp7IGuKJNlrguxGGb9xAsfEnQLd0PAkA4B2lLe0LRbh476eeYDka5VVX0I9qLlDEnz2kUEFXbTcpaS6nKb3+ssoPytepz/lFSttJFsf0izPQgwm/2ZUU3u8on+O0tUXazPMqMdEX8IgsS4245pqjEGc07LG8IeqRky9BPbvQih3vCmLn1GwupVCeJ3hT9sq7i4WFUNHWxd2JWQCuS3CIVo3AKv4XTYiRPlOvlyRhpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlLc3sGjbjLxYT0I28zHA5XYRyRf4UFwkyTz7Ixlqm4=;
 b=IucbmpkpBuawmn8+faVTnEdQBB+fyFbAWhFdpTKf59LKdJ1S/8I3afICPhu61S6IPEGHBDTZaSiCKJQDmC3AE2mQiqpLMVLq9qh8BsJqEseXvZ0devXmXtcFTvY4v0zDZHo5UzJNpq0yPKs6XtxoboIKx84B73OjHdkbLYSDRQkhmrKBFtkIY/h/Ou2FpkUHiy/znGUCLln9DcrOZQ9CmZAh3n+6qX+KiVO67k/6xNpGmSp5xcoSYGgMIHMkdmDAMnRGTm+2Xc8YqHaqbfPesPfXvtK4U3LpPJBEGs2MyTLlXCw2QA0vcHoQBzwmS5Ee+vpvHf/NSJJlUQSeMEnDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlLc3sGjbjLxYT0I28zHA5XYRyRf4UFwkyTz7Ixlqm4=;
 b=RIJQ/rx4U10OeCJ6xzcLIgGy7k0X8Fz8j/rgAp8FcXHAC+Fy1AIz1DN5SyCZ907NZPgGXubLzSt4y0AY+SKw6xzdq/Ypd163nnm1lGTk4JLXstKg8ycz4mmKIeQYwzr/GsAmoznPkpd0bTGdQ5H47FTDw6gsdpHIM8IWBhY+eOJi/ntl6PVjsc9XY3GYZGESRxKW2NsMI2tUJ+IEL3SzxmxSJNBbwQPeFLdLdNYGOVhl5oHa//nUXEHncuYLYToDWJIoFsPC7z4xS6c6WqHt7bGFYEdI3KcArRQuUeypjLe35R2BR4kEDo7FpD+T7/z/RkD2qP8xqW9AqGFgGo+WGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB6064.eurprd08.prod.outlook.com
 (2603:10a6:102:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:05 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:05 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 14/21] parallels: Make a loaded dirty bitmap persistent
Date: Thu, 28 Dec 2023 10:41:46 +0100
Message-Id: <20231228094153.370291-14-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228094153.370291-1-alexander.ivanov@virtuozzo.com>
References: <20231228094153.370291-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:803:104::16) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PA4PR08MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: a80d8183-86ea-485a-3685-08dc0789401a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z3BanPbjj3EoiQKwNYBs/naVq+oLN3TTtzXDQ2YT+NDTNtmD41j6fcUwvguzaLlF/kKXxpicFQRGpSpTgkHc429ndT05iYbYMBbD3RLv0LKHuApXWmCV2dEfm7Q0BUTHLK++LpoPVYIPD/8P067S5RvFXZlKVv3PDCsuIrXWdOsYY6SVnejkQxIV2oRcfsTbQ67Cz4GqLoH7KvKfgfjZHDP1iOg8pq4RhiRK5nDuUbBfbT4VNnP+VLeOXYidieQcmt0W/cpgP1KbUQ1NludcCtcdLd60dwkBNpjvsshf6Tnz4/2UV9PYwgEqnPXMp/FkMS4K4IWWA4/jb7bdKlePJm8YibaHJFyXWuWisfk22o3aIsfAfxnqcgMkoAuFSuGW/FIkyON3lecjWQf6LtL5O+cRom7IDydz2wWKdtXUw//CLEeOaq8EO0odigPldJdC9BX9Z4m2FJYvFEzqg+zwtm22p/qtA/+4/oGmY1HK8zcHRLc0S8iNmpNHkdC2j2UkQ/MZFc7xnNmSrkW1pPeAAISnk6nLI42rIca09uZF57pFRmcTbSEZRlqYMr4ntpHFNWmjhbPER8m3NrbswtfWSSNpIfERLw9Mlch27iqWevor+8jeZ4Fs+spI8H2rGhS3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39840400004)(396003)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(6916009)(6486002)(4326008)(44832011)(316002)(36756003)(8936002)(2616005)(26005)(1076003)(83380400001)(478600001)(6512007)(6506007)(6666004)(52116002)(8676002)(4744005)(5660300002)(2906002)(41300700001)(38350700005)(38100700002)(86362001)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1oicfisBr5ZPeUwQWQXamgR2k9WERcKitI7v5kjL7PrkaY/YtWmKBHETQEck?=
 =?us-ascii?Q?ELc2LRpDVOsYs1gpUAHOxCWqw+FWNKPwMs/aibyovb9/KKqAFYaTsn8Gt3Ea?=
 =?us-ascii?Q?vZ9Yi5y7EuYF2N4YoL5cCn3lHPWeRw2F9ScpzfLYHZhuJ8QqW+4FJLrGfh16?=
 =?us-ascii?Q?rdZFeUX+9d7mkVfgEznvWWpagEdqiMYGqp33eXyYciTPxgZFSnzE76ZTEQ1l?=
 =?us-ascii?Q?2/1nDKX5gnRmfWJGGNfsF1lliBSBOtulQI+k/5P+kIOfGJAfw6nN4YiGmpmX?=
 =?us-ascii?Q?iUDO0wePpGArHvY6rw9959J0mRWN0o2ft8z1hWSWzIr0OgkBomKJgWLgNhVw?=
 =?us-ascii?Q?SqcgKJZEFHminYWeNPNOcEEPAAqO2FAjhYW+nMOLzik/bvlXuaTJGdmDJQLy?=
 =?us-ascii?Q?uELDmaYKjzsiXIr6c8gofxDGCHDG668YkKfqQQQqMsjbg56N3uafqnKB3SEh?=
 =?us-ascii?Q?h9jxrOQD/bmNrOeiRyLK95+VWj5lED5Cf6sTaRHjsjHWmwLucwTBwx+Un+Sm?=
 =?us-ascii?Q?pOSkxkHJBkWDs1ORfSAl0uQ2FYvnU411y7aBRrfW/1T06fcR4aREqngTn5QJ?=
 =?us-ascii?Q?75DZQlLRpHZjuGRD8jqUbawgGphZ81OQoK1kUPktLMMLXULB1e8gFJwfdGrn?=
 =?us-ascii?Q?vgH/MUktbxVQ0c4w/7lY/zCrfg0Sa++mLyhrpDpYuh6FwextnTHkQcL5vHoC?=
 =?us-ascii?Q?j4n2nXkjLyHh+54yxJQkNhp0YojX/LtYWe+gQ3eC6BraqZUO63vFAWkiNtpx?=
 =?us-ascii?Q?u5G6jVnMmcPG1EPHRiZ16kSB9FSlYTveCqL58EA8TcSnnmpxnlxyO8V7yUD3?=
 =?us-ascii?Q?S23IniV05XBn6Sk7h7sfKauYsVBxJh6L5cXXVvh1xjpPOtJzBYuiwP87G1VG?=
 =?us-ascii?Q?fiSWlACScltPFNzh9OisYUMqDN2UTd8EUeKLr7T92oE41wYhcQJDQOiTNGp0?=
 =?us-ascii?Q?hcdBJy2Cxol6wPa6YvZIvmGBnc7iqQmrdeEDhzEj3WYqZ3TkP0N365S5CWac?=
 =?us-ascii?Q?LlFzV6C+2ZDCxXPpiqDbewUZpjNXoCDx2OU4uOJmMTJZ+qZxv8cfh+iFRJoT?=
 =?us-ascii?Q?Rg0P7USVtKhRJdtgGsuyIXW5Q0M5fm4dEm4MVoGICgsNKTvm8YsqA6JQpLPS?=
 =?us-ascii?Q?s2Q7b8YEqOkKYhN8opagXpyqeQhUmEF5fTlPsImsBNVZ9m04qJpmHRp/5gK7?=
 =?us-ascii?Q?ea4AEbqBLiPaJVvsFREQ9yE4Jroi5tkGxhyrU884tmKWyCBLk4tGd8+Fevdw?=
 =?us-ascii?Q?kIiXjcyHCyXOOE96ezfeRBt+NhgotkmzspQw90xpXjHG5hdS8ziMhxvU8wwp?=
 =?us-ascii?Q?DjrjRqxiIBzsSNogZReaWXqVm9H+s3bHzhSdugVq0HDyUFc3DLhOe7u8MOk/?=
 =?us-ascii?Q?RhPpMIARRjur/mGs83axC8OZdKg9Ovrjp0IToToSbNz4IOIod/uKz138mUkE?=
 =?us-ascii?Q?Zuglj5b47BoGJ7FcZJaPgOTItPp0zj3rnnrUBlgiVaRc0Nck21ae4abeMMy3?=
 =?us-ascii?Q?i/EaEsV16s1C+be08n3CgeTQfuCPSZJM4HVCY59VdWC5/O73RICVxRoMDE5N?=
 =?us-ascii?Q?7DFKIQ7ZRpWme5oLjvOfWAk5Pt3bPxsdWCRuLVcpkp25nas+U/ICDFXRkiAS?=
 =?us-ascii?Q?ekGgxrFmk71ozOwO40fhtUY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80d8183-86ea-485a-3685-08dc0789401a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:04.8638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pygl8KVRaA5eWHBzkAbmtFZUdtUlwk98DHd4VPJeKO9aMfJmvHrf/XDEHD8NiUEDeSXIjYr3gqtf2dK/WajCWdGKUU5gLjuz9GKMO4TOMf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6064
Received-SPF: pass client-ip=2a01:111:f403:2612::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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

After bitmap loading the bitmap is not persistent and is removed on image
saving. Set bitmap persistence to true.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 033ca3ec3a..2a7ff6e35b 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -255,6 +255,7 @@ parallels_parse_format_extension(BlockDriverState *bs, uint8_t *ext_cluster,
             if (!bitmap) {
                 goto fail;
             }
+            bdrv_dirty_bitmap_set_persistence(bitmap, true);
             bitmaps = g_slist_append(bitmaps, bitmap);
             break;
 
-- 
2.40.1


