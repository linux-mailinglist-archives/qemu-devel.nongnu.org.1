Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ECF81F66F
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:45:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImu8-0008Ad-42; Thu, 28 Dec 2023 04:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImu3-00089Y-Bl; Thu, 28 Dec 2023 04:42:11 -0500
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImu1-0008HI-Lh; Thu, 28 Dec 2023 04:42:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7PcElLhgEv4tKbFYzvD6O9xIB7t5Ro4HmdQlWoHsih0IUeocH6ry+zHIbRmAe+++hV/Bfvu+lwaSDI6HUGtJbWWZbhewCCUcFRC0f03cORAxC0O7DvB3ZlW4PMGykZ6LeUtkVVORSK32UcA1N04G6dlReZHXF168DlfjLtYnnk8wYrPnOG3vJ0r85UGRv8DcNV6FPBSxEH6XmytWrXoBoY+A4C/mqxyfeFhWGpmEXqJ3sA9HXz5xmykZiflPSpiuWuIG0YliWhAPF59dg8sOfQLqEu4o67nySyHr4IPsAksYbZmtqWLNsfgt03JyEGUggkiAVk+c/A11Tv4FpXZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiK8oZDz+rOtYNkEfWsCX0YcUHkmu5EZp+mPDs9p95Y=;
 b=fRlqOJmS1FbRBYQYl8M6bfNLefRqlX8DDSMGZOPCGezt5rg8/KmXbVI/cenCck5HoJ9REfFkhqVWF4Xo1/81AXxcPcrOXhaNLj8C33QTtliHRw53vWPRKFgpNfevsar5+w+h7XPQz9skjXQUezKRy1dFRhwYACbwJK+lBsBeApFbey/HmljN5d+9GbId2HHJLEERFJk+Fl00JuqOFEFQhey4ujWxtUSDoU9KaUtZGEHykKQka7HQeoA3pKiJisf+ZT/CFv1chmnDUpUwHcT6DFEBInU2AcQto23SAGMLW2TtIxlXMnb0JNHvHYbqL8nWWKsEFPwh0v5T1xYx1Ms/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiK8oZDz+rOtYNkEfWsCX0YcUHkmu5EZp+mPDs9p95Y=;
 b=qNBUUbQGUHm/eOsGgSTP/egmxTafBMtKjDgVlIi3gB8VCXSU3pMYweSikN7ch9zEmgNTq72pMRbzQposSEb4iaG1UL1ckRw4cs3/TqfucubG5QvIwMyy0xfZb6xwRa+m2kZYu/qqgtfmbEEcvJP0xSoMPcJd5f+5FDhY/PsTLpmdXxu+KMV/HeK3yPLnNiVNw7lTHmqkdALcfT3dmUd8GSfRrl8p2IvqGoLOwPk3MHa4fHlj8oX0BY7CWo/YgR8zv/YvXGVc2aLPBWKcyYnWU2TE8PuAlW+LEWP0S0jY4VFZIt+V3Qk2u30PS3LW+o/4Q0W4XHIu7vg5QOPNX/GDmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB6064.eurprd08.prod.outlook.com
 (2603:10a6:102:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:02 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:02 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 05/21] parallels: Add parallels_mark_unused() helper
Date: Thu, 28 Dec 2023 10:41:37 +0100
Message-Id: <20231228094153.370291-5-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 14df02fd-7ac8-4f53-34e4-08dc07893e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 82LhbH59bWqqQE6s/HeIjliQu4glBsnezrR8UzAb7hm8wnLOsHwE0JmFMRxlVrGJIh530W60y8D7ccnlprjfSijbeubvxftDQWtEmu2ie44aO/yGX6GtXGZ7vHLie8M0yI6ecztRoTTsTrPKn65fKH2e6Ml0BcF6o6kl4LdYVMFf2jglnuN+NxLQOpEepWGopMz3L/5xzznZmirwk6XZgesC14Jbc4uBbUk6aWkLnAss0MVVhByLBYjsM4q8ZA0avf/0esN5uYtIbWkVwclehwxxpsjB+MwvVEpvbP33MJB6F2edCZrwSBHzRzi8/o+Vm0G0OSG5FRoQiDTV2Eejpx5fBUvq121rd8C548wEvY0UZ9BXDACw+viT9kVDEM0hilIJtAQfjH60hBHjsQAY9H7iDq2ZoiQDG0RT7mYgzpn7LX9UeMpxZawnV7e18d3CuWgd2CdtP710AiBB2SoKgZ2nT6h2jh/0SEHjTJD5Bi2LZ4rzcNKYtFV3n4YShUBYM7rdLAiUAjpzpCp1tdABejIhQhvTLHGv1wFKGsaUN7dKTmpFJUp+C+0nIXtldbgQubaj3xSGCBXKIIbNvcAWylm1gH0MCaJegn1bWwlP7/6MUyHWFIhekpPztqTYiFy1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39840400004)(396003)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(6916009)(6486002)(4326008)(44832011)(316002)(36756003)(8936002)(2616005)(26005)(1076003)(83380400001)(478600001)(6512007)(6506007)(6666004)(52116002)(8676002)(5660300002)(2906002)(41300700001)(38350700005)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9jtAKYfPe9udfaDF0/0yw6FD0pxKjnnldBusEJIXBMkfVJGV70p+aZbaQuC5?=
 =?us-ascii?Q?RGUiUV7ueR6U3vckfRPHe4gycMhUeHJUMvsKT/4AqYVkXCr7cOX1cWuCqrHp?=
 =?us-ascii?Q?eL0ByJECWQiN8rJWh8EdA4yhBKO1u0vb2OpjXYaYbSr4GA2H7FyFwWxINSqq?=
 =?us-ascii?Q?d84caTOL0jYvQ1985y6rzzOG44dPAvXM923kseafK4PIv9krECoHwxLiOID8?=
 =?us-ascii?Q?iiIaGTwUZcbppLSmDysOpLbpn6F/oNkZRL9HkcBmflIRsGfRcrbhfFORimje?=
 =?us-ascii?Q?D7W7yKxG/chCW4qtyD3G5N3XhJd6Eyt2bAVuWccZ1vm7IICTPnjnucMesPBt?=
 =?us-ascii?Q?LyRtTyUEo9oOCmP8/Un967wzl1ZnqVSmbQEIu7E4EyvaV3AfrsW3orWshuB4?=
 =?us-ascii?Q?k/dpGJz1bQ/7vC6CoQ7nZ+6UJKhHrPtdPig8PEIAvV8AmWIio16ybV3DmGzW?=
 =?us-ascii?Q?8MESHnqA6tE9nVDqZUDjQ+7bN/IwunXdhfA/q0o3woozIZVUVx3PpfnSfNZm?=
 =?us-ascii?Q?BWni7rf32jFt2VuB7Tc/O+VW3me1Vwz1MmxjiQHzfZDcNGMABBh6XyGO7dhJ?=
 =?us-ascii?Q?7YELiSiiMQhgrdXQDPdzczN4066H8vy8xAiZkOfWs8zshETti5Y57tUECGFA?=
 =?us-ascii?Q?tHQDAfEWb/7i5XhXnn1x2KvfJGMstLX/qwQb6F6gm51Je49n+ZGEA75JqmDA?=
 =?us-ascii?Q?fw2XbxtlkcXlcNrnxPLiOQTdxk12IqMQuJ5bGZS5/U8DEiJcxD3ptNFgHI1Q?=
 =?us-ascii?Q?Tyi0qWcUWQIBLe0YYa+kDf2ENFTMMuPWjI3K5PXuhWpiveBJFEXWgrGJY8rb?=
 =?us-ascii?Q?g7L2urBExLncsdWUNMDv6xvxJsoAyM0wzy14Sxr/W77Hrs7xIABQWg6QuGzi?=
 =?us-ascii?Q?72oSdkPbRTxcmMaMhMtAnsaxQaCld/Wy8uxW2lUrEhvKMeZ7j9G8PdP4Tgkc?=
 =?us-ascii?Q?iI9d0Kj8bF7WxmI/BqnWxndkVjCNtBLxGTh55GPMOxUqKtoNnJyE7uDSxMQK?=
 =?us-ascii?Q?KVYaE0c73XRfqQZt7+y98K5tDjmwPDo2JMR8vyW6nPBFjWYqPgpZ4EXlSbzR?=
 =?us-ascii?Q?cF71wZHl+9yefvqsjGT4XEYFfPDTuxvchHkMR8PzpbZbXGd3lkR6ZcOfAJhl?=
 =?us-ascii?Q?9+jzS/JwkXt4ncSj1koZ7gqoZy14aJ6o/iWrKh6Dsw8rEiFZkX92zEAYF96w?=
 =?us-ascii?Q?bRTZu93CZrU6ftnhn4Zs6XaqZmvgjEl4vRft6SS9fHj18/NMFYcibVQLDPTX?=
 =?us-ascii?Q?hjblksB90sT9ScnRRBsoubjF14yLYuo4sCkV3dDTEjHrQf2RcYD1N6yPB2Vy?=
 =?us-ascii?Q?CFyAHiMRPWWCjkwzNOislEiowiiWkZR6Ft3IVjMX0L0pyaJ/FXqrjWFQMGb4?=
 =?us-ascii?Q?gU1O3YpQgf+wtCHWjQlA+N6lNVlFrY2OVDaAIweRHrLr2Ilw/jN/hhr5AJtm?=
 =?us-ascii?Q?BKYRK+cpXZ9xi+9ZWhE5CD+8I6MBt/hunQ/MBFguYR1AH4E8Zr8pE2qooJbp?=
 =?us-ascii?Q?WlTmUZWXEC+NiQq04P9MVnof+05xfn/m3G8bcm4dIULJCliIyY6uDYkIB9nT?=
 =?us-ascii?Q?QfdT9oHky7bTAeAl5v0jSxJEf4uErpOHa0uy2MQeaKwz6kEiCQfaiM/A+S0x?=
 =?us-ascii?Q?+ymwJVkEN7fVM66hmt/2p9k=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14df02fd-7ac8-4f53-34e4-08dc07893e17
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:01.4553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlMCrmfClnyvKhRjQr9kZ6IEL/hsl0FMna66PYyjyMlPE0MWKP7gtLdeUOSTdvh7QujibLRIQN39UhLvoW6hdG/RSumgKZbZ3zajON/dTYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6064
Received-SPF: pass client-ip=2a01:111:f403:2612::700;
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

Add a helper to set unused areas in the used bitmap.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 18 ++++++++++++++++++
 block/parallels.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 4470519656..13726fb3d5 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -196,6 +196,24 @@ int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
     return 0;
 }
 
+int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
+                          uint32_t bitmap_size, int64_t off, uint32_t count)
+{
+    BDRVParallelsState *s = bs->opaque;
+    uint32_t cluster_end, cluster_index = host_cluster_index(s, off);
+    unsigned long next_unused;
+    cluster_end = cluster_index + count;
+    if (cluster_end > bitmap_size) {
+        return -E2BIG;
+    }
+    next_unused = find_next_zero_bit(bitmap, cluster_end, cluster_index);
+    if (next_unused < cluster_end) {
+        return -EINVAL;
+    }
+    bitmap_clear(bitmap, cluster_index, count);
+    return 0;
+}
+
 /*
  * Collect used bitmap. The image can contain errors, we should fill the
  * bitmap anyway, as much as we can. This information will be used for
diff --git a/block/parallels.h b/block/parallels.h
index 68077416b1..02b857b4a4 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -92,6 +92,8 @@ typedef struct BDRVParallelsState {
 
 int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
                         uint32_t bitmap_size, int64_t off, uint32_t count);
+int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
+                          uint32_t bitmap_size, int64_t off, uint32_t count);
 
 int GRAPH_RDLOCK
 parallels_read_format_extension(BlockDriverState *bs, int64_t ext_off,
-- 
2.40.1


