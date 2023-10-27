Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F547D9041
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:48:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZb-0008M7-7s; Fri, 27 Oct 2023 03:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHZ1-0007Nk-AQ; Fri, 27 Oct 2023 03:47:28 -0400
Received: from mail-db5eur02on2072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::72e]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYw-0003oB-8d; Fri, 27 Oct 2023 03:47:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHVqEP6I65K2FGoR6QysRk2b8e3LKZ6TqRacEWQxbA0Iu2HxnkHDRpEdERm/tTdWudAWGQzqFddIouXrKPxmrJF0vimMqEXtwUV42Ei3Hdo/C8C1++mkywh4qVaBizyufCCUnASaWgxs7ApsVZUUWR5ZmaRlIwqHUfM730VpbYW6AZBVlOo9WnYabuv9Z7lChpovqQ24NYGjsB9S34va/TZDd+eFhc3zE3u0XkISmngZLNhzJtJQre6jjA6+hgFENySlue29ViPVHvQIAEIM8JtmKqQgnGHAyZ96uzRfE/hfIZB3je9MiS31GwmL+ngD8JCawwhc3wuPc9EQn9nr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smoM9hlqAl2sN4XDK7Jss4bKvBM82Bc4k5v44s7Xfuc=;
 b=WODzuOIFvAiRMllWRlkNhSatg16ev5VoJyQ/stgAPzBFBGKKMzvDSZyPTS1Yb796S4hR+eRhrI58vFR22qMfhyWImSdCcVkd66XSK21sxce9KDbQ+WQsh1X8sCCJSKQlB/+KPG0DJ+Ai72gGQh2FhH/lCMxiJ7pmXJ3nBn53PjuRWL3wir1LphKfTdNYTN9BVY+DiBkyR25c56B3eZrRBnjLFayp6UWZlL/FY7nw6VTyMZxok/SE/mm0nDfnhqKqGYA6Wcvlak6+QH3Ijqeay2KNoaSHJoo7kFU0ZOUYMNMz9dQ6CdAJcQlJzbWfDM6lMcCY0zHm/2hn5OyLcIC/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smoM9hlqAl2sN4XDK7Jss4bKvBM82Bc4k5v44s7Xfuc=;
 b=rxiv6NLDl5xzolD21n5AMisax9lEZ7d8CJsBQMjk5eor/jDB+g9d1PTkUAnZtQUz81jqJaN2ztYpEmN3cWVlM+rqKkyIkRJJ2LEDAKS7059zTE8AZ/lT+YRyMTsqoT+dYxYaBfqwGbTqAK0j6vWO/9A+fD6ywAAU7b3FtwJeF+vCXO9XNDQgFAnmbrFD4opGXmH6owknBooOlBh8+/VOSst45R6lhvjoN4rjsZcmZQ9btrawp+QhHrR7dIZCYK4ALjOisVnKZ0Z8NMX5xGwqKe3xoemkx/qAKwqoQFLFNDJ5aNqak7EwajB9PmpAMggDKiTIqNBt4u9PeEagfVCAkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB4PR08MB8056.eurprd08.prod.outlook.com
 (2603:10a6:10:387::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 07:46:51 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:46:51 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 16/21] parallels: Truncate images on the last used cluster
Date: Fri, 27 Oct 2023 09:46:31 +0200
Message-Id: <20231027074636.430139-17-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
References: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0101.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::30) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DB4PR08MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7f0d38-fe67-4b45-151c-08dbd6c0e071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gkzIaWx1KTeri+QqARMtK7g9TPV19AOFcXCrTWVuJB1iN9YHBZvzfSby6Nc256WyLu3nRgyjV33A5EwVJfi/KfpTUNZPjs1IHcFnmld9aWUGhMw+BWkj3xBPMqQ+5rFDccc32NkI/QfuwfSRZtZRIJAht0CtjxsIv8C2BQnUzMhn3VM/5QV/VkffNXUpgUt0FQcgzLS2ABwmUvYWO8jT4KvJQ0FE9fKnKfTM0uoKKuBJZukgZMtMdPty4gTHmhXqoJ3W03bZNqh9CT9uUDUNwWL+TUsgzFBzBFQrk9RWBDhp8MP83/AIwuXx1gru5mnH8hiJSJLEDNWCYm7dM1bD98TQH6vYVQzHLcErXHPB+bS9NgYt09FzukRRvuUc8/JGxbQlwmEJ7uEbVfG9jayYzEnAMnv/+NCy4smPeSEWFiptXMNqU/xi9dC0Ab2ZnPj6F9jd5l0pWUrCtBLwdVmR2EEX/aLMCLGJDfjabljVR715ehCCW5S/GzwFWB0UWHcvidYxY60PBwcSEoN6O7RsITkPPDCjkjLnwGd6Ik5Pn67CUhuwP+L5yevR/f61NGHsfEepdFej4afetAt6CMKtPhRerbnfdc4RTngpUQUnl7TCqo8hh8C9T6lRW3N0iOps
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(6512007)(6666004)(52116002)(6486002)(6506007)(478600001)(38100700002)(86362001)(36756003)(2906002)(66556008)(2616005)(26005)(1076003)(4326008)(8936002)(316002)(66946007)(6916009)(44832011)(5660300002)(66476007)(41300700001)(8676002)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q/4afLP5tsefO6uq0jhzB7D5GLvpVBSdIwYS+oLs9iiLxL5G6w8MDVhFNuac?=
 =?us-ascii?Q?SkKKumxC+xIhT9owksOr1ulFMOYpmyEzJ2UT0NIb/DDjyjYyQHK+/Vd7S9Af?=
 =?us-ascii?Q?D+6FGvJlES2SnA0S/MnMlpHuKqmWiUX6H9aicPsWIvhhO2n2554BQqJtHzIj?=
 =?us-ascii?Q?GQx95VdYkpiUg0EP0smw5GoYtEO3bC6ETnpnYx9UkJKGsQIZ2pz7yBmf1+79?=
 =?us-ascii?Q?p0jZkbsInscJfLUbUqvIUdvbMoPuLmtKSQrBRemwo+xa8URK+Oi9V7Ru9j6c?=
 =?us-ascii?Q?aJNUOX4yIvMTjVm4+pR0p0J3J03iUm68/Q5vPHqjBirPox0/uJ2sjzhH45kb?=
 =?us-ascii?Q?RUiQUA9PoFouOZ5d2MF8S5NrLhdiWAfigEhhhCLt30n/VyK20cvmYB08HF/6?=
 =?us-ascii?Q?KI7+5cPTzpTzdP/VPuykb5qPRdexz58IHVmy4PDQJ6iHpLMWrAOLUI1VN8XG?=
 =?us-ascii?Q?s4YqwK9n9hTPjn511Hd9gIUd/IDsYoiDPRrpHuks+HICfvIjXpb+yLqvTcdp?=
 =?us-ascii?Q?RSQZFRpFCbrQ7Ap7ThSFHaCjeDW1paDl9olClzQ7J59r888Ca5BbuveeBRya?=
 =?us-ascii?Q?B4WIbGwdj48n3AZtqTAYkx7WomHuh9DIbvmxH2b5i0RRyfA+dm0YDZpkVb0j?=
 =?us-ascii?Q?h4s0LX/V5gSvZXuAsgfNjFoh8XrloSz/EED7c9vzF+iY4D3GMxHJQ7F7w5pf?=
 =?us-ascii?Q?W/m0J5E35hsZYLSPRw4tlVhgc/StV8uc2NPhP+3J8EMi+/HaRmCnuvvbkORA?=
 =?us-ascii?Q?2iF8tp1kD2eEJ61jBdENKfes6gV5lC5B2fNIJ4zAztG3Q7ajNjKqSMMnTtNO?=
 =?us-ascii?Q?0oPkkp386EIkt5F08MSrIV/4h/RzUM7vghW+zmoNr8iO0ZBceZt9ttHV2qBh?=
 =?us-ascii?Q?Dkz5QlmFvZkAFD9f8K0vw5+vRPFkTIymYfKxcLm7rPz+fHqZBlWtDcJ1fsTB?=
 =?us-ascii?Q?ViUYmgjmZuK5UmCSbUnAUSXxYby7B5RS98tWNVNFbrZkU/txeKhYmiNJgn78?=
 =?us-ascii?Q?Ga1K98763qAktdgJXrkpS7EK5zBJjGjOjivzgpvAlSIOnuslb7y7wqu9bljQ?=
 =?us-ascii?Q?V6NWbEXekm5LsDRCTiioZ6Tm87p73+wv+KOQUn2TwiStKlMODREOlov9IVH8?=
 =?us-ascii?Q?vjHrc7i2ynDvOteA2syUBpAKnS4aJCIqF/okLqa7JC8TpAeRN/DbLmrGemWX?=
 =?us-ascii?Q?3idMCVdIQghmc7jNPI/VsdJd2ZkjRvqk0EncQ/h2SPPr/7Mwb7KE6XtQN8MW?=
 =?us-ascii?Q?aZkeXFhd8JNxRtlzZliHwjaetqAV+F8mROK4zq4BYrCa7oc6lLSfg7nPSLvZ?=
 =?us-ascii?Q?Id+mczi3UloKzajXwssFIzG7M+89XgsFR/0+x31k/YCmmOrVzRsn22bxYiTQ?=
 =?us-ascii?Q?KOlH9jhskS+odon7cKskdJOfgY/+pmoHG5EqR4DHlvV0GrRTbwn6TYthH5nN?=
 =?us-ascii?Q?ssfKB3PATmpjhOGK87NcNi+e+UK/JxaeBfUJQ3ouhPncEndoZ1Q9tJ3tGjag?=
 =?us-ascii?Q?BNM/MXyv9Dm1ipAXJLl5LxA24DjgHivAX52o2PM3TwoJwcDDSG+FkCuMfJVX?=
 =?us-ascii?Q?8swx0Pc5TaBMw/6U/a5TnshghrA7fho4M/2bvP0Qyfo4pDltQ9DlhwSv6PcD?=
 =?us-ascii?Q?0LQjSYLR5pwngtoZoWH5C3M=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7f0d38-fe67-4b45-151c-08dbd6c0e071
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:49.1860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEjlnDq2qdO1C8FsL/I0/oDuYPNfevOY70nS5Yo0bZgcAddvWaJD8/sYgTmjAFuIBuxpY+JoaX8MPg1DIuvW37nNK3GETsBk3iTIQtp18H8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056
Received-SPF: pass client-ip=2a01:111:f400:fe12::72e;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On an image closing there can be unused clusters in the end of the image.
Truncate these clusters and update data_end field.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 354fa0f2cc..472311e2e6 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1456,6 +1456,23 @@ fail:
     return ret;
 }
 
+static int parallels_truncate_unused_clusters(BlockDriverState *bs)
+{
+    BDRVParallelsState *s = bs->opaque;
+    uint64_t end_off = 0;
+    if (s->used_bmap_size > 0) {
+        end_off = find_last_bit(s->used_bmap, s->used_bmap_size);
+        if (end_off == s->used_bmap_size) {
+            end_off = 0;
+        } else {
+            end_off = (end_off + 1) * s->cluster_size;
+        }
+    }
+    end_off += s->data_start * BDRV_SECTOR_SIZE;
+    s->data_end = end_off / BDRV_SECTOR_SIZE;
+    return bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
+}
+
 static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
@@ -1473,8 +1490,7 @@ static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
     parallels_update_header(bs);
 
     /* errors are ignored, so we might as well pass exact=true */
-    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS,
-                        true, PREALLOC_MODE_OFF, 0, NULL);
+    ret = parallels_truncate_unused_clusters(bs);
     if (ret < 0) {
         error_report("Failed to truncate image: %s", strerror(-ret));
     }
-- 
2.34.1


