Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D77281F6BF
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:14:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInNm-0005GL-JI; Thu, 28 Dec 2023 05:12:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNj-0005F2-Hg; Thu, 28 Dec 2023 05:12:51 -0500
Received: from mail-he1eur04on0713.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::713]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNi-0000at-23; Thu, 28 Dec 2023 05:12:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6N9+IqwYI207C/ICzZehkfE4EncI4nooptRRUdbdUJm8pEflNrzrtcAVxuVuCEpMb6NsUBSmR4ZEBc+ZWsWt2Bf60vY7//8KbmbxkmdUjetY8Tc/eDOhgwiJODtol1ERDd/qZ09tYdNMpWuf6AWsqwuurdOcTCnYUJRAD5bV5X/aRHuZuVnv7gZFWn1IU++NaXWf3gqtxJeJvC/9nPjWd08ZNcEqUOHn+Cnkz8s4LEB5a9kYX/cnuauwDzu47t95ErNcQGZuocognPbebqGpChTkPpEjZAAGNjqitECDbkuKWRBgLaMKIcwXxJqcQv5oRB7suM5QGazEFZFmTrC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XGM8R+1YhTFUzcMeWgYcDxrj2klo3PteoKf3LFzL1k=;
 b=nVfmBnbNxp00oqPoNf5x/3gq7qwe2vqEeDQXEQS/KWjnKfOy5zwl1Zo8AMZuaJJZdvV+QX0VTSBycWqyAzJJWNoHHVMvKe/Rx3bE5u/zYgttCYWOKbx5UIA1wVCX6FFShaKIwePAd8ZwV+aXJ7G648d3fROZAxpB1WvxHLnM0D17lCh1dDsetiWtsbQwBAGO9jH8IQB7sg9z6CzxBZIgFDvzKyreAOWJ6GHL0XPYinaTVpG4to9nQXow825/RflJIvKF5qWWPkLRca5bGSUBTaMkcRByZ2i4EQevHWfvp48ZKROFwdWqKSui4tjJKjK/JOtOjAEDPLXYSMi40OZf7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XGM8R+1YhTFUzcMeWgYcDxrj2klo3PteoKf3LFzL1k=;
 b=RXf3Eg0w0ebeYOx7xzEsy73BLzufbQI4lWl9xGkuSgbBxU7hFHK5wc/HDcIPCMycYeSZtHdF9dI7zBf0Ce6+3XbSb7r5LbLzm8+bLclK2CmIC3kmAwb9sYmFo7G0tYSm0oANQuUZqKOiFb+gkylQA/fqgjhynk0ZqVS2s7LGpU0KhXGi6lBeOJHhSFwbxYLN4PWrjilsqmu/abjgr2sZTvd8mzgKRGagokp/EO/LF98/wdL6lGYKM/Ylc4AFokvY98/nOX0oS/x8WIs1rrf+lNyIdJzmxeINAzNeRpEjV6zpe7qt3BIoIHYQn0m/jA4WDS80ErhOeRRxfFLcFtmPNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB7459.eurprd08.prod.outlook.com
 (2603:10a6:102:2a6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 10:12:40 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:40 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 02/21] parallels: Move inactivation code to a separate
 function
Date: Thu, 28 Dec 2023 11:12:13 +0100
Message-Id: <20231228101232.372142-3-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::8) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PA4PR08MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f84a55-b7d8-4be9-d4d4-08dc078d8647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cXfEihPpF5wMBqMyTHuYJQw410Q6umxN/rQ8TWOvc0cOcslE7vYzE7URvYN00TrvyO3Q5sCir4NUuOJS+kQ26HahPsY+ODzGsSoL2wT+g764U76VcKEnqCNsJOd4AnsTSygf11uU4yWBrUfYBkhvdiZmR+IteqSg7ZwpzbC24P20RGY+9WUqfZ9xOPDyIl1iYSKpPi08zof9Rt/32ER/cQWWsmh+kA7irJ7XZcJ4A81LjuFdu+KRYoe9l319hej2RtGCQ8sYMzF5hnAJHNSEhAgycigElMcz6wrglTQrNvyya4HHvwDDhGBsif7OAQ05Qe6rkXB/JHSgeaQifLgAg+79xC3KLIXU57TAm6RmKsjErb4F9NgpSPS9qBeCdpxQg0QGOXTsB01LrSJIJesAwT2AilFeuoyfsIY9TyvoC+yI6DgUH0WNbzicnffzFXYUg3DH18WW1VUsFWQfzgte23/m1VfhSosKIFx3KdMV3P3bh35aZdFY26dbkTiiglONatXqkZ3v0tOYwqtRf/WsEcXpGBszWybHEkUksGgprgiU+ZDyV5S2Mhx0etE49gHwGpAuoxNbck3kmDgRBezHXVCzARN/l8qnv/a9I0NR0cuT9FrQQYA+QazysjCfbwCN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(39850400004)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(1076003)(6666004)(6512007)(52116002)(6506007)(83380400001)(6916009)(478600001)(4326008)(8936002)(8676002)(5660300002)(44832011)(6486002)(66556008)(66476007)(66946007)(316002)(38100700002)(86362001)(41300700001)(38350700005)(36756003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tw4r3a+ciOcBKqsuo63E/sz5ko5FtXxQTHJOzrBy0s3zskmU2Qc1Il6uvzxo?=
 =?us-ascii?Q?qswNdQaNzz6x3fragtUbrprtICVgQFVx8U5Ht+fsOE/sk2NGtbxGMGExP2Hu?=
 =?us-ascii?Q?+fjCOPq6c7VkdhyKQsW84bsxN3mu6zxP17wtUFXoiwoKMRq2FEdOs8hjzu1/?=
 =?us-ascii?Q?o5Rp6vv3lVqRBB+YxZO5oY6LkuVwflwv7JiPQ9+UbIPNBKg/Cod7rw66h3Pk?=
 =?us-ascii?Q?Z4Hje0w+0fcb032fKmR3B1+Uu0jWW338k2/VemgpJkFXHSvEXudz+fXS5vLf?=
 =?us-ascii?Q?5AjXnr1AwiaQN80OuvROUYFgMKbSPKdw/vp00s++4HlX/um7LzsBrBeVMjOg?=
 =?us-ascii?Q?mq08DIUu91ldQdhrmhgXJTJxqw0ITM9tYERirWCLqOhdy0JPADuZwgZW9MGb?=
 =?us-ascii?Q?iMEenhHl7mGutjVA1YHDRKAxCHu7Oqu633FNE9aToIF+i6rUbyPKkKj8yJJ/?=
 =?us-ascii?Q?+cuDzeMAa7ab2p8HACTQuTyVWUxG/G67sWiq8fB4Wt6iqSGPyV4+j529SzK4?=
 =?us-ascii?Q?G5azuDgZq+sUwDeoeYurLBHih9KViZMAOsmY45lqpff2pjadZ5hzOdrVSjTL?=
 =?us-ascii?Q?qWoxngcWJJcJngXR0jYOQ6c2K+WpVMVW8pIU6+r5yh0UwvclnIVJVD556o6h?=
 =?us-ascii?Q?/rYF4xApudDj75YHYQuvYMXI91cpHMxXisa9ZqpdoRu9wOo8oe/+CVkhOWhP?=
 =?us-ascii?Q?7IV5pHQ0UOTSAZiu31qh18SYD2jW3waHXBfTxCQEdu6ujZh8KSgQtJB7Yac5?=
 =?us-ascii?Q?1xILzhkF0ifZ7ZNgntqt47K8qUlg+jeG9CNi19vPMJCKSXVqAXJj7UMF6arp?=
 =?us-ascii?Q?D0R65jZYsB19tVLRKVwa+uPVu1doqwsgauQN/xkdOEQkp/bC64TYIh8ug619?=
 =?us-ascii?Q?CrknJY+ZHjTBVE4FrL7Y8nJYPWcbM3C2kvDn2/AY+jz+FuhuCWjnDtg0FA1b?=
 =?us-ascii?Q?kL21hM35U5O/F7RG+MOyz9LjUM+2rKgDYlbLO/2FU/p8Lon7DDPixE7yEbKj?=
 =?us-ascii?Q?pY4FA+WZcusAEVixse4dm6vUCRU8u65rTqllacCQL4FgbKkgH8YRuM5F7bap?=
 =?us-ascii?Q?iln3xPdr8GkQ+ANPGF/eXxkae6LqHeAtcw443bYBTlvYwAwAk4eQIYhVq9we?=
 =?us-ascii?Q?x4//npG/pQCBSkPxt4cRv6UeeWKW9ApkplkLQ78hW0TECNEdHypBPbf+gd4j?=
 =?us-ascii?Q?lUiJe9IsjrgalDnnovNOl547dx597tqOINc8tCn1VPvI8De3hgIkB+1gLAuW?=
 =?us-ascii?Q?ZiD/RiZdqL/FIq5W+PJqvrw2UApGdLIFTGTlSdsCvrJYaaspTEUU420A3JQ7?=
 =?us-ascii?Q?kRkND2qybdQ9RSV95802NFCl49bDhsZtGE7bf8MhWvMXk7i/v7xQ4hzdu3yo?=
 =?us-ascii?Q?lr2+h0YdvlC8TilvinV7W+JC27oqWxsb7lldMAaIR16Tsr7TDpRaJcFVC200?=
 =?us-ascii?Q?6Nt7CkBqie6m4L3cis/PWb4ARnevvp/VXVvPFFVKd9EYg/Yvjj45XauXqtTq?=
 =?us-ascii?Q?osUhsYc+1hVT3g3eoy6aIqy5BawGi02fEHVsXmH/b9pTM0uRc30BOSBQqQ0P?=
 =?us-ascii?Q?AmKwGGd+onbS6MgwvPkryQsuicA14IyMFLZIRa/HylAnZtTQsOkHCbLfbUox?=
 =?us-ascii?Q?M0CU+BaXu0sWexbrqMzVa7c=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f84a55-b7d8-4be9-d4d4-08dc078d8647
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:40.5767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x//GWWOszEJeAAbm4J1tQ4aGO2a+9UWlrWqYOGHvf9doaXnjGf19MgJ2GsE0JpU49ZNK6M/JORu3hve3CCwCj7uadsrwszYM6axSBVIUyJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7459
Received-SPF: pass client-ip=2a01:111:f400:fe0d::713;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
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

We are going to add parallels image extensions storage and need a separate
function for inactivation code.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 072b1efd78..992362ce29 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1424,6 +1424,20 @@ fail:
     return ret;
 }
 
+static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int ret;
+
+    s->header->inuse = 0;
+    parallels_update_header(bs);
+
+    /* errors are ignored, so we might as well pass exact=true */
+    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
+                        PREALLOC_MODE_OFF, 0, NULL);
+
+    return ret;
+}
 
 static void parallels_close(BlockDriverState *bs)
 {
@@ -1432,12 +1446,7 @@ static void parallels_close(BlockDriverState *bs)
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if ((bs->open_flags & BDRV_O_RDWR) && !(bs->open_flags & BDRV_O_INACTIVE)) {
-        s->header->inuse = 0;
-        parallels_update_header(bs);
-
-        /* errors are ignored, so we might as well pass exact=true */
-        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
-                      PREALLOC_MODE_OFF, 0, NULL);
+        parallels_inactivate(bs);
     }
 
     parallels_free_used_bitmap(bs);
@@ -1476,6 +1485,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_check              = parallels_co_check,
     .bdrv_co_pdiscard           = parallels_co_pdiscard,
     .bdrv_co_pwrite_zeroes      = parallels_co_pwrite_zeroes,
+    .bdrv_inactivate            = parallels_inactivate,
 };
 
 static void bdrv_parallels_init(void)
-- 
2.40.1


