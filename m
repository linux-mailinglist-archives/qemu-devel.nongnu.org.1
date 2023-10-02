Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF177B4E6F
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 11:00:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEkt-0001WA-Hj; Mon, 02 Oct 2023 04:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkh-0001RO-1E; Mon, 02 Oct 2023 04:58:07 -0400
Received: from mail-db8eur05on2071c.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::71c]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkf-0003RK-6U; Mon, 02 Oct 2023 04:58:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnugBZwUhGLr0vT7WUAtqcwc4Ff2cy5VVwb2swxJyvUdsRAzX+lvEOIzUS2MtrZIX+715tb8kilzvs52c8rq/HYgykHz9mMaAaw7HdRAb7l6ORifdMv4zUBFk9utgFOXWk+gDZtbJ3bg5KQepVe+0qR3oXN5S+AeTQ86pqDBEuoc84xG8qrr6F34+OKgfXhjir4JMkX40u5zcvidx9iRt1Vx5itSwv6/pl3MHWIWPAw9PC2pVFBUl6ijb6RUNYZKVq43MrYZ6Q63zI29zH9YdjZUHLIhuK+VpUbP4k84C/rjIrSsobQGtj0wuUL3zrhWz/lhpFMgHF3XpgK0BcTbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bqwo7I0f1/bCP6x1bGw190cp0O8WAMRX3PUoVwUSAxc=;
 b=X2yWiaVBZzVvkNJj4DgWqtLZ3wVr4ePya5weUF1PvzME0ojCE/lIRQSEX+1ifPXYz3jN1sPRVpiUUSvXLtpsYKu3W8AmCNWgkiNTwW3JrF3RaAc1kd7cJvjordWXS5CUSPq+KrMLyAgVK+0gEo9QK9iLyEpTFpWdSRQWHfgrmvkYP8qYjIjQU4SCmcMi6Arh8SGdgmcFmogCvA4XFSp8yuJvzsTVXyG+uQIHIrAYiaM0wh4kEWI940EacatEzA9be7+Vm/47rGWMEM+f7mkMJ59QIKP2rWdlrAp+6RR0JNDTwR1e/CGDRqaA1DlLrpFmIxg4kz+qAV7jdoaWa08Q7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bqwo7I0f1/bCP6x1bGw190cp0O8WAMRX3PUoVwUSAxc=;
 b=ejHed0xck+jKNQ6eG3KBt5pBCgQOvr4sOlFrDjwRKTxapRQOtU1ZPiHtbkvKggh9jYI7aY4D7A1YXylgAZIGGrxpbJg7a8xY97BHYzUXggM7ZU3BuX5jGvtKFYQPqDyMKMj1XShtWocERXeOfdTGtxJcU0bWeiSD795h77zokA3fUqVvO8tGnLpTmNmlXjVEfPJ3NG3wcuZCfOOCFS2eBXTTEr/baV+43KrL8MYznPynK49Xs3UXRq0FDeKKrBDnj7Y2AK9fiSUhN38rzcBIQ2TROKw4hWaNLVd46YjhkiR8WDD5E3MHhfZwskCR3q9xa78bpcAkEoRBw8OqgJXyVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8273.eurprd08.prod.outlook.com (2603:10a6:20b:537::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 2 Oct
 2023 08:57:49 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 08:57:49 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 02/19] parallels: Add mark_unused() helper
Date: Mon,  2 Oct 2023 10:57:21 +0200
Message-Id: <20231002085738.369684-3-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
References: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::45) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|AS8PR08MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 98934c23-8e45-4f75-c3f2-08dbc325a6a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7a2BSMlXF3UtaXhogsGX4lQ0u8XXi33efdzBGUVGcb9PUV4kdqo5ZM6AQfEd9y9R+lCpBzdh3x1t8/D8REML9JT+v7ye2QajGL8kqzbznMKP5C7QQ02zOzl9vMiWJI04cXXKfSVlw2LeIuAKhUFpaEGxyQPndTz5p6UKHQP60qKSWjcwJO5HI8YaRWcHBNCq4aXE6CpREpitPdHlnVJ7tGLQbbShIYIB4+bU5jWcyrNAFcR45jS+TMTNFECD8T/l8rG0Z8hiLYZralLAQLvulHXxPDG1ie61Hu3JssDRWLHyGpiMm08AmtetslNLDF4z4xLx9Ffh5WpA8QraLjy6ckKN6pvaZNEIRLRIGvjIPaKcMUj6sJseQpI4xLVB6p7vgwsEvdshvhQcvV+VAzKbnWV2ctrqQm1v8q/kiE1FoX26itr9O8stXGYVg16/6CSu5RwsDHHmdZSyBRj7Fv2IGGsBSAfcnZcVuic8g4c6lywDZRFCHv7dx5BcLW2WuNnWFxrUXbU7mockCdSW9pz9PeFqJbbdc/2HiuIWmCEn8SbIwgEgDm8rzoy8WKjk42A6TtGBGKGM2DQAVnBxldq5xPLoMr0Ad3mnW/gYiWHXkEMGhL7L3jJ6bSBXzBH6E9+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(39840400004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(1076003)(38100700002)(2616005)(26005)(6506007)(52116002)(6486002)(6512007)(38350700002)(86362001)(83380400001)(36756003)(6666004)(316002)(8936002)(4326008)(8676002)(6916009)(41300700001)(66476007)(66556008)(66946007)(44832011)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aEpkORutSSOh6NjtSmqyPLGUe0vRq1pjF/JpaCkl0Mk/vR8IHV5sRyXrLXyM?=
 =?us-ascii?Q?kJtWNbaEzL5k9e4tMDDX6nxs9tOnktSm2PEFuo2wW3qK8quAqF7M+ep0B56l?=
 =?us-ascii?Q?eo0KXvd9d8XfLzuD2qNEycZiyFFOwqyWPG4ZLWn6C51p0SNWtrYCfr4EhQlt?=
 =?us-ascii?Q?wjWaEMNjxuOTozBFxLv8vEBwzRCavxz6ahSTQP6wz3+Xjon6kLiBdnKwQNI3?=
 =?us-ascii?Q?qXNEVXuwOuz4T45L0RxDpt9wgMXT4V+nVSJyf+MoRsRnAIrwlkPHEkQ8QFUF?=
 =?us-ascii?Q?Ygze8Q/+149lGLbRVDWSSIC02eqhLpE8VfrPKZyv2DXWKkyT58y4B/MhqQnr?=
 =?us-ascii?Q?Z7xaqxBYkB3/Hj5+D5w/yMGu9175DIvEOPm376kpC+yV6KjH8FVDHJS9f60W?=
 =?us-ascii?Q?K9JYRR54Eiz3qnOcSV7O23n1cQqlUqb0FtpJqCYzWdBwL3FKh/LOEs/esUZY?=
 =?us-ascii?Q?4MjXnC2Wdy9+XkP/duVA5F9X3R6NlEtQIQqWULN/yOLtwX+7ouhlwQiIEeyf?=
 =?us-ascii?Q?UIlMshvDK1o5ZKSdClWaLFaIVWKgA8HuSSoy/TYJpBJFCQ9/8UsWREBADvj4?=
 =?us-ascii?Q?Io0PbmVg7zCN8GwwJ5v7sZvHNouW1CkG2KHWPyX0N8fVcAnWWY+rIDzr2ILN?=
 =?us-ascii?Q?eAQzUgZIawWj2EYz+pCZ5CQrAM9k6ldE17svdv/it8xyMM2xvz+XzqRnKYQj?=
 =?us-ascii?Q?AlpmUu1wBCIUlkRX63Lj4Oq4IcgfX+1dBP0+P8mH2PtBYCNHliJksJ7mu9qA?=
 =?us-ascii?Q?9VDSH5fl6r7CcZHurEqJ+6cuEUCyHW2slZUE1WuN4Lvzjx29l8BqskdKH7zj?=
 =?us-ascii?Q?58TgmRp9KM7WzSeCIhECW9wQnhqBbqdNi/bZuQibO1lWYaHcppA11yzcNwZr?=
 =?us-ascii?Q?b6Ytn1lrddGh6BX+QoBhw7o9W0YILJQ3MALFNWB6qivez+OaheXxWoaTv6DP?=
 =?us-ascii?Q?NQ6q1yjZ6nMb8Mkyrc7W/WNozrolHJbDiuMf02WcZxasP0Mvwe8AUSk6ChHn?=
 =?us-ascii?Q?IJGbP75WCKZmg1e59npXokwwitDLsK08HXtXGreMRE4W+xwjyDVU6VHqlrUz?=
 =?us-ascii?Q?HH0CxDDCqgOraIG3sgKCxCxzXMeCWoceSDEnD2zDJeAS+0L6ptMNdGFbDglT?=
 =?us-ascii?Q?OecP4rsyZemmaKCsuy1IbJbsMhQZsI43fgzaF1ExANp89PMR3ZJiSBqFVzf8?=
 =?us-ascii?Q?utggXmqbwgLE1QNwqH6WYqeEG+9/Ey0+1QE08VTTd4+dhE/Y6j7Z2g7beys8?=
 =?us-ascii?Q?5VghGHjYGT1Vj4Z+9KWDejqvnaABXFPsvnCWLw3sS8gCNuf+O+LBWqrzeoZm?=
 =?us-ascii?Q?4+e1kRUCBW3Su/Aa+7XK9/8rWLExZmIsYsw6wRU/SHfitLf7EBV8GXpnpIBi?=
 =?us-ascii?Q?BHkpKe2gW+RieRq3WeZUt2hMHtjAh6gbGqCSlnRIVwdKhgxoxZzxr3OXrxCG?=
 =?us-ascii?Q?B5yqUQcTHJtk5snpscU/gF0jRzbKiowAwEsKx/g9cVaIA2Qwv6yZX+/jhoNU?=
 =?us-ascii?Q?UbhPsoEmb89vagam+ifuUCnTApMHilHxcNZiCWAO8Mcp5HgrPi85HUll0J/g?=
 =?us-ascii?Q?jzj/tbqIQT0499tOywY3PMJLc59qJ5eFQF+eTBfr4HqAvWvIJm6b+v4k31G9?=
 =?us-ascii?Q?4hlNy/VZUS1H7zVKFq6dNAo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98934c23-8e45-4f75-c3f2-08dbc325a6a5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:57:48.2520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASywujF3oxVb+qfdpzVtQm28iAd1q2BqOYbCUZe39DXiFePu9cQ+BC+T58o1nL0W6r8bcaK6fNke9DqnU8jig/k4DwW5AHlYY4w07ZTOOP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8273
Received-SPF: pass client-ip=2a01:111:f400:7e1a::71c;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
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

Add a helper to set unused areas in used bitmap.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index d5b333d5a4..b5e19ff921 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -195,6 +195,23 @@ static int mark_used(BlockDriverState *bs, unsigned long *bitmap,
     return 0;
 }
 
+static int mark_unused(BlockDriverState *bs, unsigned long *bitmap,
+                       uint32_t bitmap_size, int64_t off, uint32_t count)
+{
+    BDRVParallelsState *s = bs->opaque;
+    uint32_t cluster_index = host_cluster_index(s, off);
+    unsigned long next_unused;
+    if (cluster_index + count > bitmap_size) {
+        return -E2BIG;
+    }
+    next_unused = find_next_zero_bit(bitmap, bitmap_size, cluster_index);
+    if (next_unused < cluster_index + count) {
+        return -EINVAL;
+    }
+    bitmap_clear(bitmap, cluster_index, count);
+    return 0;
+}
+
 /*
  * Collect used bitmap. The image can contain errors, we should fill the
  * bitmap anyway, as much as we can. This information will be used for
-- 
2.34.1


