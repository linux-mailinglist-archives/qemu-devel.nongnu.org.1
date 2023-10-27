Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE097D9048
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:49:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZO-0007q3-Ug; Fri, 27 Oct 2023 03:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYg-0007BD-H7; Fri, 27 Oct 2023 03:47:21 -0400
Received: from mail-db5eur02on2072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::72e]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYc-0003oB-Qx; Fri, 27 Oct 2023 03:47:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1j8tcAY83sbeQv8vjWaTytbx1YXQWux34cw+YMVd5f8oUZLT8YrJb3vnm34CqVM41Rae0J/O78blZfcZSE11KCTFr9rv6A+iDW1wnVXBujkNgymvc2OArjIueyKUkL46LqSJhOL4mQieHxxidzruJit93WHLbubxw4XKgiFEwRog2tByGupcZtYK/EpczKiCbeT8TIt3H7WnJOlYPazVpb9Rv/yPaHKUPnbxwldAdHSCDfXQd4F8DTAbCwm+F5JWBtoOqEE0/WgNFiD0ZrTopduUKTACPpPJHirfVJXEBxFrjwSHPilQisRH2voisyQuDh7MlJT7Mu28nE7SQ4gew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5maZsP7dUdy18yzJAs3ERgqRMtGnX1B0lZ+3GOQoSk=;
 b=lyocBvDPsFU1mJQw6NEYtmkogq3YpffFJzCWJqCJ+luDQtEV1WY9ctk36OaBYBviveM6MlDziQA/NCWXSh4bGLnncgoFAlXevs46YNJfTn1wcxw9WMszdFQOm0S0JHDtstmbhQ7bpKtYvbiRyW5PjXnva42zgeQYCWSACF5Yvr8A19guFYIDjRf+0oUJtSzf1GQhfBQujqw6NE9At+y7LBEW07D21HG56I+3w5bS4+CvdCJ4BipSRnvcsAAotDmn/YITogyhyN9phlEo7mkjrY3BviTE5r7Ya2JG4Z/63+a4sWUXJx4pf2tAyY0oSRxj9/xYTSJ/H6tS3Ucaz8rrqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5maZsP7dUdy18yzJAs3ERgqRMtGnX1B0lZ+3GOQoSk=;
 b=vU4pqKlnuqZ05XkCxfVctaZRpyQoPDHQqD8B2F6jkf3Phc+a+G7IqEZ7V47xsXyvCEQ9GoueC4ZOf44f7slHENHo9/hn2QzeFz6EF4sGSZaU1TeExzAx4P2jkQAm8qtHHiEL4ixQbBvExcv7RH9DHdqBDHoJ3Rc6hBBGVXJErQMZA8Ywr2BPOgpEUlUwEkGLEbS6EqefHlA3yttZxXCt2yCDpayapaE7n8J5RVru+nESvbJDEwrmhvYcTERyrXzCrA5C08aQjcJPHEMgRmMNfyD+0oZyWE/uvYcnc57v/wsDilQdXNAPrYLbE273vtnUjrAeWadLh0lbFvUvvZ6Arw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB4PR08MB8056.eurprd08.prod.outlook.com
 (2603:10a6:10:387::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 07:46:46 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:46:46 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 06/21] parallels: Set data_end value in
 parallels_check_leak()
Date: Fri, 27 Oct 2023 09:46:21 +0200
Message-Id: <20231027074636.430139-7-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 65f88207-0d5b-4222-5f09-08dbd6c0de1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PcecocJ6donb8oZEY7c/nfx1hRRGLaDZ4K7I3O3+PAIfM+MOB210Khm34ecKXUL0f7DoPQhUmxaUVMfwIVy3AEIMO2p7lSFIxyKtVz/yyCvEB68WPrbI1Taa9OUSf7Qb7d5jvfBAl/DmQBrdzhSiEuzVvvdtD2PHntBQdugorj0A/YRGoP+WmXB0Fi5Hoj2wcOtOzfWJMUUMXhnAJYCoPf61E5Eh8JaS5pVaqoT6QyD0KX3vhXFLvl/9S1BDI3xwNlloCHHd1vOqycRFxXXY23VHkOVIX1UujkhZBk/pC4fOI7ROqSz2u9ABk5BKLhDJeA4CH967iCkET3VB6YDmLkj6YGE6zS7R+Y4/O1DWB5PR5nwcFmxRvO1fWqG5ftnCl29rzw8rMwe2ErkSqTpWLrr8BXTJuhYp4ia2WSXs30fXhpB12SbYfxYbJy30zfVw6Bl0yrUHUZNorN3kstpd9CNzYoYsGDSxe6zjbzfpNwf565t0w3pMl0bv2mB36dQ9K/xJP6mmcFopIJCwfqSrfG1bro6BbwDkzZNTeyS3VK0F/Vh1PPgr4qsvfPE2sQU9gtFLv8tiAgEhNcxHG7/UoImE/k6PO0l8ecqqm1uD4lPuTCutxUiMDeyt8z95fuwM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(6512007)(6666004)(52116002)(6486002)(6506007)(478600001)(38100700002)(86362001)(36756003)(2906002)(4744005)(66556008)(2616005)(26005)(1076003)(4326008)(8936002)(316002)(66946007)(6916009)(44832011)(5660300002)(66476007)(41300700001)(8676002)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kgyFfVSKbq/9vxojCk0RrBXtM7I6N+ZNb8na8+BTdOiEZeTqflXYDrFCPNxa?=
 =?us-ascii?Q?1DB3TzC7Ibn1gFgpsG9dXLhVLvfOlb66ICfeTeoV0R1QAzfYQwF2fNUMdsx2?=
 =?us-ascii?Q?x8wecZnrMxWictt/MNS1MMDq0elq4qPTd59xZpAjKD6EpltPQKc0mg6grIIm?=
 =?us-ascii?Q?jn7n+XiPgFDrAwQaYGW0bx1VxC79g9TsNZF/Yjcxg8p073UxqO2sKZ7niQOT?=
 =?us-ascii?Q?ZUJ1ozZY5Y3GvMssyvOqoNTwURsXlCVdY6Xhg4p1IJ13AWjq4MjbN9J3mCfL?=
 =?us-ascii?Q?1dpqN2etorno37qlx6zyaKaK7/N4gXJ1slqvnpIMelsEB+/nBvZmZvXgIco6?=
 =?us-ascii?Q?kZQk96fjKpiuj+1HE0CVjQPCeHGZgtvd9piuTOjKry06HmJiPAo7MVyBC28e?=
 =?us-ascii?Q?ExSFgfgtPuS9zY2LeB1BDOZaDnpcmlYJBpvqlofUUpV8TUgMYaOodOcD3vPQ?=
 =?us-ascii?Q?Gh1sfnQr1d3hF92K2zWfYA/6C2i9SuEorqIM9F8QMRgvsDbwoDVgD2opFi88?=
 =?us-ascii?Q?brzheOou6s/cJItpBpzZSy7YXX735hTCAOOcIcuFhh+Xb+ufp1u69fa2iKyc?=
 =?us-ascii?Q?P1IQSyERzd2a+U0H7B8m4FMcrHoa2atxhjsr+G7vD9+8Y98+hRF9k1fysGum?=
 =?us-ascii?Q?E2pkVncyz5wp+82N+NO5EjbbpTpOKPhCZtasIZafEPOXQ7u8vyMiw1x211WZ?=
 =?us-ascii?Q?amxTVOIjtInkU7Xza1NFkXB7EJCbD/ROy60/vYtZrt6JNQiq6Ma0yAtjt9si?=
 =?us-ascii?Q?ijMKTiWHds4yeLRtzzsSkMM5y2c4bkbP+l/zbkQ7sB15EXR0TRz86pktBJBY?=
 =?us-ascii?Q?VnBOxF1mbIcaprXESHbqE06ewlSwk3iyJcCVwJau6i5sVvlvG2VRBRr4SRTq?=
 =?us-ascii?Q?CWoti6jMEPSCo/uV7Sa7PbjfNe3EVIq3vWjlG9QLMRjgaieYZ/Sx4AOmlHx+?=
 =?us-ascii?Q?2FECgjVGScai00oSMPBHa+0voAA/0bLE3fc+wCdgzbzCOO6LP/3PsgnchhVn?=
 =?us-ascii?Q?Bfsc1ZewhfrUAaAWjXQz2nRtgDgoQHoLqSAs2nexHO1DQC7Y7PDS59pyLpKq?=
 =?us-ascii?Q?GCAawJZXIFC2xNJ+jnMGOVRAvYDRKVT6ONJxwJ2+OSrx7kkXtpVG5O9X0qdT?=
 =?us-ascii?Q?+q+4d4tmvu77C6G5iLq/vI8N0q64v7y0SBKMDIHpx1Vjz4twJX8+e3nr3+4T?=
 =?us-ascii?Q?PfMtDnxQF7O2B3XFMviXfRSKGOL7vs5sq+6CrYVdolAHET0UxzJroxMGQWtn?=
 =?us-ascii?Q?mDM4GE2JcPpWPURzGc1gDLBICzqM6Li9DLvelY60dPGVjkV8zld5pfA7a+8C?=
 =?us-ascii?Q?TdN9DcbfE+ggtU/6qhnGkaYUOg6QgSoYzfsNJRfIkQUFt/H0Cqmozt021Kmg?=
 =?us-ascii?Q?d5f1OJjnl/XZKXeMtWVXHgjv4D+8o5UBtqAJPUBoF40elxHAYq+VOXbkELZx?=
 =?us-ascii?Q?Iht7/kIEf+f3FvPuYyHNJIKJdeg16GfKl57vWfpSWGO8hiBsn2yeqYKX4zGc?=
 =?us-ascii?Q?NlWIir1od32qxV7Yjian1IaRIjTktrAT+2huzKx+rnBX0etP/wXfVkRl64FM?=
 =?us-ascii?Q?U+nCSmDfwpF0xyZyIl6d091Sm6hk5LWe/ED7h0ld5opsdyWK0gP9VLU52k8d?=
 =?us-ascii?Q?/TWDi/gu4Eexy3BxqSwrchY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f88207-0d5b-4222-5f09-08dbd6c0de1f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:45.3365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+286afHoPglFx8egIMNJjeVrRWjDP0SkTGzu3JJCbwFmBcK+e/CeW8mlRg3cQIacxjaax9DaeeuWc9IwsCgruICidGXpXsTy6783TNNXic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056
Received-SPF: pass client-ip=2a01:111:f400:fe12::72e;
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

In parallels_check_leak() we change file size but don't correct data_end
field of BDRVParallelsState structure. Fix it.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels.c b/block/parallels.c
index 33bb8f1084..d6dbb6757f 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -808,6 +808,7 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                 res->check_errors++;
                 return ret;
             }
+            s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
             if (explicit) {
                 res->leaks_fixed += count;
             }
-- 
2.34.1


