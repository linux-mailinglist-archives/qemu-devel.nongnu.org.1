Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D02D0744866
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:12:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXZp-0000FZ-ID; Sat, 01 Jul 2023 06:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXZn-0000EY-QE; Sat, 01 Jul 2023 06:11:36 -0400
Received: from mail-db5eur02on20724.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::724]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXZm-0007vY-91; Sat, 01 Jul 2023 06:11:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYCO6IZjFn0TFlWZu/UvveGPUaI19XWzydMjKGw8sjbOMdDMqs6ipmipUmYTDETeg1Ga4Uwm4Q55QX3kjIVwCHVqNOVF1tGTWCRqpnXzQHZlXwewT0wyPgnk9yGxNlugyqFb+Ir6zm8neDlAaPenLq4XhsHl5GFC+wMDybmCbsyy8fHy5mR2YlzzcAPdyuFT7+4INuH8SQGEyI8bI0nU++/ngo6CCNWSlsdDdAqxTFq0+TnhG9Mb078UFBDooU0ls9Ko65q6xnsqnzJ2QMYjj6MpGN+w4MRMRUerVe1Oj1VfliO/5bJqs2CgjBfV2eXYpZfOXxDt+7cGMYN8nfyU+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blR1eHx9sU3ZZdpvPsXWTJgPPhGQOsLq7LBxGRBHKc8=;
 b=lZ0qOMQ2/O0YirKvPQr5mNdeTHh3FE+xtfilX2K466kMalV67SfCCrGwMPwXSFFMv2pB4b7zWVmcECk7bHz/ouNONVDE6NPeO1UMnfrf7ybC+47Zy0E6M845m8AHbPGTY3gjTBjKcEH2+T9T6pTfRETQlcXP9Ci7pRUbMVKSbD2aHGP85m2L8k4+jfBDCofgnZPz4s8RW2uBCy3JpHdhK3wT/pbe5cld0h0hlGboBO1//oxeZWHYAsN7WisJvPdJeh+fgxTKURrzelFDovTuigTptzBt7m7bfuv/RTmztMfn3H9cOLRBhlzUGLKSGovt4DWqzrw1B3i/30vNE2ni/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blR1eHx9sU3ZZdpvPsXWTJgPPhGQOsLq7LBxGRBHKc8=;
 b=RA08sRJGndxKGn02yf5mFyxq8Uupae+jXD9fz/+yXsrZcodSIMw7Wgob0wBvvMgg+McfWmIkQuoEU9qlFDR2YMcSp19ZbEnFZvDb9e65GkI5d6HgHvKKOMsZxs/uRma2xcKA+ny60YVZy3qOzzutuWiWhZjB8WBexfxsWO/bSvRgWFgfBhuse3teLovDMTZEAlxAmSUoa1w0sg8pVfayRiapq/RTaCPAQpsiB57ZZS1xuzdCkYIy7QPkWHf0A5OFVjCRbIKlSgOVQwOFH9GXWAOT5owByvBmBMJ9OTdgXwovs6Sx3Xtnn2tmsRtBI9FTBdg0FU1jmXbWUkcWz2dmPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS2PR08MB8832.eurprd08.prod.outlook.com (2603:10a6:20b:5e6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 10:11:30 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 10:11:30 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 0/7] iotests/parallels: Add new tests and fix old
Date: Sat,  1 Jul 2023 12:11:16 +0200
Message-Id: <20230701101123.261104-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0005.eurprd02.prod.outlook.com
 (2603:10a6:803:14::18) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AS2PR08MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 498cb5af-65af-4d6a-97ee-08db7a1b8a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LzmOXVkqyVf8K6FygRZxpFxi22usF5T9b9uiaDkYCULkQLZiNaTXgDUAHrtSB5lvgXavWzNRxzKsZjBky3t7VnaXQvgtp2pnGI7RUWFY0Ca+UwaJFP1YNh8yyBXa4Du/0xsguhvevcbEuqg3SEUCzOKWawhRRs2AzLupeTN/ez/GCx0TP6ZlEJE+XLKHxj1EszIMFRcJsgzZ13DbURfxhPlfJk3rI4i/r+qb/sV8dta6ojO1FFCwKpx2RQ2cMjNKqpE+JpUTVmqTINU71y0lOs+q9LPeKC0e07cPcR4CuuMZbTNjl0f2zxfWuKrYAOzJk54Rm+yw/kwzmbXjY+fbfndllUK9V5cTJUZLVDAaKqtVYNb0gKwDDIB6kn6/tv2t1dmAN/OtvR0aimTcrjDp2ij31GFOq7MMZ2oSMS4htobZ5Egz+sUxEWTeFCTXm6uQEE6dUlTfkU7Y2h8swpKMP3vXQwK8g/lJ8UTWLzWdxl8ThE5NZCHotONvSJ4qDL+tYJi2gSNL4uAzTfRdAJlQRJ90mY/dCqOIyb5pvVatLKjqrfQkprpz7+FwoeW1+mW3HMPqKDMSU0EU7wJd5WkjkK3qEvlAZJ6blvSBf0gWr1xbdKD5IeIIAGvr+HUqOPlB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6506007)(6512007)(86362001)(2616005)(186003)(38350700002)(38100700002)(6916009)(66556008)(66946007)(4326008)(66476007)(83380400001)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(44832011)(41300700001)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wjAHDzCHY7j1GAdy8NJNRKd4CrVzdJOGF+LZarwxNGmCTyK7uwnadUpVEESY?=
 =?us-ascii?Q?sm0l6std7QBS39nDTWiNc8IDY8ALJlyah7FDEXju51PIeDvKhHEZePs3wl7s?=
 =?us-ascii?Q?2qyzmdbuXayM6F85RkbRM65w0hgLhS6cjyeOtrMykhU+lAUM+aSYYqs4Tbmq?=
 =?us-ascii?Q?MtEsgf001saG4G1LSjPG8TlqDkiLXlTXkmc66hTfFa920newrWobIfCdsHag?=
 =?us-ascii?Q?tC/f545a3huXz9xwpbhg4mDQDQATAq1xqnildvRmTeZ3wXPWBj72BFuIVdGa?=
 =?us-ascii?Q?iwGPjwGfXD/O4Vc7Zeoxo7AqXSG2bVQ1tEeTpGQpBwb4Pmt9zlYAl2blebzT?=
 =?us-ascii?Q?bEJoj9URyxYNUAVjzfm4woCT1EhY+XTmH9jQ2CMA7LL5ZMPxRdvZVo1HD43B?=
 =?us-ascii?Q?ZCJwFf3PMlSx4UhE1wdwpLcpNVk7To/R9t18R6t36d2SQcFzBN/E4W0aWFIL?=
 =?us-ascii?Q?6sC6DlNyPNS1Hy/AjvY5qHjUgWsJOSrbttKvaJChhbzHRlF4GHMBqOv4wn35?=
 =?us-ascii?Q?Cn/BXRZoIYanXVMtnxjj+1k5FZqV8/Jt1crgH74WLk/LnSDghdG/QXZnYk31?=
 =?us-ascii?Q?414Ry/nnM2ZxBRkFN7C7w4bOAK8zFpaW6VHohkGKp9TxoPRjN8VexLE3MInV?=
 =?us-ascii?Q?sE70Esmc/Zf7s21qhy0eWD2hVXgg60ym+QxWlDwGaGV3p2udUQh7HYPoWNWc?=
 =?us-ascii?Q?tpdl/CGdjreQ3THJT0jnvcF02BNtR+c84irwBMc9qSVjzvoVNUl+EFa8FQoj?=
 =?us-ascii?Q?7+tLOENQwAHgzlJQphVNlyqZNNerWRMRaP8qFiKfTvx4eadPGREx7V4wWee3?=
 =?us-ascii?Q?IZYxWnjYK3dMJweHvUPMMg2WWDR3d1y47guDHzL3sFqP1bp4Jyb27kgvFLNj?=
 =?us-ascii?Q?3YgoZyDX5TjjE6OAm/cvaD92bY96XExTeRV54JFx1c83Bf11fE0gOsT/FTaV?=
 =?us-ascii?Q?xkal5+E/lpZYteRC7AnUDJbsSs7GO9A+dOpVlMVZUsUwXlrZ2NktqdphvHXA?=
 =?us-ascii?Q?FcOWGs6KFD8zGjD4FEnO4XZR4aLl3+kav1L4DiecixHNdwfubiiQU+IC0+Ci?=
 =?us-ascii?Q?7sI6q2E1qhBapT35itfwHLyBL9ZJsvd9i3isnq7EpYd9s5H4IaHfz+6F0G28?=
 =?us-ascii?Q?f6NNaGnpkn7c7Hgs7d7TmJgSGdXKKJthpCbBSz94jmpru1z3YFoKlZ058v0P?=
 =?us-ascii?Q?iTrEa889pNU6M6KnxF4NHm66abqmo/P+n7+ryIfPh3tnuLJiMQBnzpsf3ru5?=
 =?us-ascii?Q?9TRalban+GaIKXuog1hBDrm/Ke0ZJehgVkafbyRI5QlfrdFYYOB1F1Ps7MuJ?=
 =?us-ascii?Q?iCdN73rVSWeuSuCFbIdZf7wr4WkcJzytoilaQKay7gRgUgo/KmF91tZrNUQE?=
 =?us-ascii?Q?OAQw8GubzD3O3I/OiePh5HiaCj2fFV5hhE3i90c4DIZ/zxTCkQEfZzu4EgZ9?=
 =?us-ascii?Q?/5x3WhOXgZXXJcGg5uM0xXY6IyQdXb1yGjJ7jN1WDBK/zySypbJtGfggDQqN?=
 =?us-ascii?Q?McKsdElDNrAmZ51I9OpVdrxK2xHHS9sG72b9mq+tDhIUXkrKj1SizXzBTZrY?=
 =?us-ascii?Q?rdNqg5lB1shj8vIS8SvQpKKQ+e8I85kIPIXoAY0vLyVqDpyAUv+LEstta0dG?=
 =?us-ascii?Q?MYM//VhZ+H52jCJnVqZ8y+4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498cb5af-65af-4d6a-97ee-08db7a1b8a3e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 10:11:30.6501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NxXrYFhO8LOqU8yJTecaHywC8+CQkmEKC0/9a8d+0ycr92ZAqo1YvKRnjHh2aUQ98z4TH8Qvp9+UIw4fHyX9Y4+I2m7c0ZzQ7a/oDb3i/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8832
Received-SPF: pass client-ip=2a01:111:f400:fe12::724;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
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

This patchset should be applied on top of [PATCH v7 0/8] parallels: Add
duplication check, repair at open, fix bugs

Add out-of-image, leak and BAT entries duplication checks tests.

Old parallels images check test (131):  Refactor, fix cluster size and fix
after repairing was added to parallels_open().

v2:
5: Fix a typo.
7: Add a test for data_off check.

Alexander Ivanov (7):
  iotests: Add out-of-image check test for parallels format
  iotests: Add leak check test for parallels format
  iotests: Add test for BAT entries duplication check
  iotests: Refactor tests of parallels images checks (131)
  iotests: Fix cluster size in parallels images tests (131)
  iotests: Fix test 131 after repair was added to parallels_open()
  iotests: Add test for data_off check

 tests/qemu-iotests/131                        |  36 +++--
 tests/qemu-iotests/131.out                    |  59 +++----
 tests/qemu-iotests/tests/parallels-checks     | 145 ++++++++++++++++++
 tests/qemu-iotests/tests/parallels-checks.out |  75 +++++++++
 4 files changed, 264 insertions(+), 51 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/parallels-checks
 create mode 100644 tests/qemu-iotests/tests/parallels-checks.out

-- 
2.34.1


