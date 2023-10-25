Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E897D6DE9
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:02:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveS6-00041m-0R; Wed, 25 Oct 2023 10:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qveS1-000411-2M
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:01:37 -0400
Received: from mail-vi1eur04on070f.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::70f]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qveRw-0005dH-77
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:01:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UizAqPubzWY6XRfgAW8HwI2LUxXqObnCz3b3LI3vX2o8cGdaDvGJItbI261TxxspQu7yZP8TBVZ+3PUndYWLoarxIZa1JT6wcrSmbfliJUS5cdRKNgsPjWC7gQGx3Bd1/yrUf3Cn7ImiWwb3f8Sl672RsVPhIV+VEo8qJDmM3q539PC9zFFs9l3SF+fGhWKVqhdgf62lsZShWdiGnvGdBirQJJgxBaFw6KjTO8YYCm6mcuI5Q682KirXlKXPDRDUPqO7ZpdMrjvkdVMv2jcvvqZo7ouJ0vLt2ZZkPSCwmLhJyIKotv3k4xKTQ1qyC1dAH1Nn9shbg/FDdJ5DOfyCNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01N/Pl1AxQGsNtLAbQit5+BT+FyXQfOr8XWNMb5DDj4=;
 b=Mo5Nh+bB6JPcPuO++epRKcKf9lYhCn2LhdOvDTDALIRHcBVmDzNIo7vadHoBA/N+efbdzxScCW+Cz4QXO82xkFs5sa+i7Wc9EtgsBstacdrhsF7hzGLI+gdnTso7Z5Zfk47Aw+zQ3S9QHtWICSCkuDDi8WtCaS/hsTHtjwOzQDOJZOqVGaqckBo6d+6E3ZW7JDMCWfwwdzzi5wMy/p63TgVmddvbPMKt2EKMhGKg0p0lnmYneurHUEeuAT138ssTeeMB67eRXnzuKszS9M39rUgTEBAkFM+gRocMAVo8KuVQfqzmYUGq5FnnU9mCd+vA9ZC15mRXL6J5wXkdFJlqWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01N/Pl1AxQGsNtLAbQit5+BT+FyXQfOr8XWNMb5DDj4=;
 b=D6vXQjwYz22CwFYc0PsPrah0OWDteZxO+UC/bW+S5IkodRZhmxkaBdNptsahrOFEfDhIpC+NTQtocqpL0jEe43NzpUUfpGdh0bURwnUkRYuDBnaiynrPaqSMmIpK2KfPuq6ZMOjBMrXahTT9AODBreSlUEFy6MteDlyTdXmp5USWiEJER9Xv+SCL1l6wsi0T44Fze66e81YhF5jDFgIkX7eacgNShbe97A4RFvL2mgXkr80v7M5tSoVY1Y3GaG996IAntdloSBlozFuxkcii8cx4f5mWp0eF6lABM6C/gBS0XU8qVNE/DRb+qQmmpTjotzawRJkoG1dOfvNEqN3QWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB10363.eurprd08.prod.outlook.com
 (2603:10a6:20b:56b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 14:01:11 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6863.043; Wed, 25 Oct 2023
 14:01:11 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@gmail.com
Subject: [PATCH 6/6] qga: Cancel async snapshot before abort
Date: Wed, 25 Oct 2023 16:00:58 +0200
Message-Id: <20231025140058.113376-7-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025140058.113376-1-alexander.ivanov@virtuozzo.com>
References: <20231025140058.113376-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0167.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::24) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AS8PR08MB10363:EE_
X-MS-Office365-Filtering-Correlation-Id: 415cd5dd-dc22-4261-596a-08dbd562d85d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j1ywvobi7xwJcDhGQBMRLNT597WkCWgvxQJgB3RZYGTKriiW+iWiyJecKGXeD0hONJpNZ4jw7o5l2cYAcl67lsBQb+ljaTlJof4c0y0JubmAgcWzOS2OLWfWlJKKm5aetDpg3Gk0tfx2h3tLwOeSaxot6X7C3YB4Jd7peSdA2E9ROmzw0ty/u0+nPNUN8pi8FPVO+LqkE+7hFKBSTkOnGcjAQ7JE+4siXq5ihk7khFGBSz5c76tCQG8AwO6oBXkZFGoX7RUhK1lyqDF0eTzF0GBQ3sL2ncC6k1q3bt0J7k72GM69lFyiIqh+S51I2dMib2AFwTAoLOAbcrHzyuagpN+vQnquv3g0lZgJjSNNsWaNWYr9BjUvBV8vFvlKyEpltAKSmlM3m8K6FCA92uHJ0HAk014gUro5hamskvnu/yyzePwyzPxPTM9PGZaeoxjcstr0aNVw/XEYUxJ21PXi7G1rIY7RdF6TiOuDfia+brkHaVimAUU3oJWVsW81PfYNLjv0EjJhuBnkT1rhLZ1N2wcAucT8BNLCDvZJhnGEpn25UIJUtuGr2Z4ZdCc5fHMVerk+c41tBCthQJq7WqHLbndcMSY7NU9ABf+9xBje2o0jk7n3coizDq6avm2lerPR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(39850400004)(366004)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(4744005)(2906002)(38100700002)(66946007)(2616005)(66476007)(316002)(66556008)(6916009)(6666004)(6506007)(478600001)(1076003)(6486002)(6512007)(52116002)(83380400001)(36756003)(44832011)(5660300002)(86362001)(4326008)(8676002)(41300700001)(8936002)(26005)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qHETaNjUaw0zHJ+ksOArBJZCJfeTLXkjm3YZKHNHNaSNi4Ps8oDbBMPiQUEh?=
 =?us-ascii?Q?2CgFD7kWuXVNFNk1nHBWGrSOfBKcCLPhe5l0dfEVJfnodEcycnoq+BE3yRxJ?=
 =?us-ascii?Q?gHQcRSsK1zo6C/+ZErtahLCPhT+HaSmmYxYYHONADDZsiFT4xLX8VeIb3aDi?=
 =?us-ascii?Q?kU9FfwdU7KTNgghWoRS9Qt2AU3UNtR1+r2IsxecmtcBeiwT8Y9U1rG9fTJcR?=
 =?us-ascii?Q?IbyE+erZGeOgE7+hUfIvToCLRnX7b0L4yVVoM5C4DHlzyCqI1EMbcEP3GNfH?=
 =?us-ascii?Q?u3MyNaqEun7E2Yn/nxrEyvylCJzXYlULCnmJura/frJc4nbFekko2c1irPjd?=
 =?us-ascii?Q?iH341fblPmsT4jrwFMbgD1+1Wco2BNy2cNZqC2FwTi9Z59YCaHjZ/3N6F3JD?=
 =?us-ascii?Q?ttvd7PnNZOFfV7yHMI+L3yYZGqYKn/YsTXT848CW9Ka/Sti1fD8YkgZXlIj9?=
 =?us-ascii?Q?zwEqHrRPD1/p9q2B0MZhLx9UBgcpA0ruM48Jw7v6MzDEcrkduAObzyru1khM?=
 =?us-ascii?Q?YmtKc9BdgGevdVyyLuy+2vAkL01+fsS1Nfbaj6L4kZnTB7HZasJFSMw2JeGp?=
 =?us-ascii?Q?kXPaHeNuHXgVJWsKTC5Lj1h7myZWb5nomGYgNLNAxbZ0XPTEy6eoOXkvI315?=
 =?us-ascii?Q?1YDv1IB6poPPTET1Xjfjq6QEtaFwXjQzIk+AvXeWdpqduupZXcncoSzfb7Vh?=
 =?us-ascii?Q?qcd7IOZ6D5SI0bszT6yN0xGxJKUIQ4hGvS/BL97SdGpfza6lw1igc15dZofq?=
 =?us-ascii?Q?0QvF8wWEm/L8+1NZXvMys3i/GBKwwxxhng9yCy8LU4xEFxJOysW+iM1UThjs?=
 =?us-ascii?Q?lIF2sck22pZqlUBj7DjWJzV0gRnQ0UtREAnttYIKHN8SptN5B4GloUJCDxOL?=
 =?us-ascii?Q?/QZgaH2k9yDJ0RPG5gCV7DgUmpO5WqRlG0stqtif3OtonhIf0KF7bZ8pf89E?=
 =?us-ascii?Q?K6MCZhgJbfQNei4wVE9GanyDUe7cBPXpSDFBHMK39nkiANicx6g49fX2v/nG?=
 =?us-ascii?Q?5baz5HKU2c6ExLI8yZDu2t77l5IhXCJlbivdo0zhH+hRbxbnPb0R8A8zpjNU?=
 =?us-ascii?Q?4j0kHpDZEE8lucDPpsW1/CHLrjButclATu9AalrzJKn23JQqAGnnWlO8ksZp?=
 =?us-ascii?Q?hH2dfn/l5ELKjft+8C6UNH6ZZkP47dazDOiQoCu/RghMI0xdGE0W/XOjb6OJ?=
 =?us-ascii?Q?FNFwwR5zT8Suxc2AChChrdvFzqoIn8MwI2pp+OkQQfPZV+kd74O2egVEyu9L?=
 =?us-ascii?Q?bKkAEABlPiU0JtCBV1f8kuyK+qXOKt1s7+b8SHrmZLXmpSNnujn00TWa2EgM?=
 =?us-ascii?Q?ePoMI03uPTOBL3wh1ybi/y2AJiDzCNbjY+j4VXt/PWP8KpeLmM+fLWM806dk?=
 =?us-ascii?Q?t2OdmlYWGbptqC/gaiCeBoBpzvh3jHA1OJs+rvqqTcIPxWDtmT9f3KFc844I?=
 =?us-ascii?Q?OQepsJqsILadcQ34EtdTSsGmAxvKTA4vwZBvHoM4XVMdI4fg+kc/34IGQog7?=
 =?us-ascii?Q?u56v3B/fNImPJIAL3CPeol6A8Xv/QRzGFRUiGf5HaEDSOZ1ROGYpIKG5VDc5?=
 =?us-ascii?Q?MVk/cp4voQ28HrvZUG0L+sdFDCaKA0AxUYKj/XYJ7F6d2MpG+75F5DR9MwTD?=
 =?us-ascii?Q?IsqZU9Wd2DL+2IlVAEPK1Wc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415cd5dd-dc22-4261-596a-08dbd562d85d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 14:01:11.8217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaoUfp1wz3SBGuQ1+4MrTmfHu2J2M2bh6NlYjDLi2sTqIYRir/aNB97ImVeLLNO/2j98w3KVBZVvgcDK08x0EzZRxradpoHpCC5esSA/6xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10363
Received-SPF: pass client-ip=2a01:111:f400:fe0e::70f;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
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

VSS requestor calls abort after the timeout of the backup operation
expires. In the result later the process hangs on some internal VSS
lock. Cancel async snapshot before abort.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 qga/vss-win32/requester.cpp | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 9884c65e70..20680a42a1 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -533,6 +533,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
     }
 
     if (wait_status != WAIT_OBJECT_0) {
+        vss_ctx.pAsyncSnapshot->Cancel();
         err_set(errset, E_FAIL,
                 "couldn't receive Frozen event from VSS provider");
         goto out;
-- 
2.34.1


