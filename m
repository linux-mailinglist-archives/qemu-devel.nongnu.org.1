Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E3F7B4E74
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 11:00:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEl6-0001pD-Mc; Mon, 02 Oct 2023 04:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkl-0001Uy-Lw; Mon, 02 Oct 2023 04:58:12 -0400
Received: from mail-vi1eur02on2070d.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::70d]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkk-0003Q6-6M; Mon, 02 Oct 2023 04:58:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/B32BHwkp8G/6N4HvIjeDl/8RFt1YHuyZZA451f4WO6RdF9HXLzdAIanNu0mmyBU4pQzRmsz4g9a5e8ST/ljnCktinna11OevTrK4br9HiIV9q/qIXOPIomOjqDt75jdoo2RQi5uxoEKSoabfbxiD5+4qmjnfzzuiB30DfpPEBYwHmqLmOHCZ/krcc6pIEj0RkPAi9ejRUol9bnYSJpBS+dRziEtK0qKaNUf2vJUmp17Moll9/NzIJzyBhFPExxIfnKbR1nimGht9oOeSfGnQCeYh30woo5fSP+nrzBUfijwgMCXsWkqK/hH752VHvKis+f0VyjgC4iy2xghE9drQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msTmpVNhqjvEFefXPwsB7dm4quOpNOlDM6fU8dd+8OI=;
 b=CVO/8nvImnYYhTxPJalGGpy5lYHV1kMaiFrF+ttr30qtWfvh/oCiBaUgNuYTRwRE7LKJIv6IKxHESIjd87GeeQQXH8q5Rj3jHrpP+gQJM2n3mCPKL3eE9p/lYvfvMfv/tLsTtBANx0wuL2FkJ1G5hbie584ydmtLrtN8yzJzzuSl/np5Fsl0A9VQ6aLMHM0qrIwuDcGQTl3NKg7cpj5Ixe1klumPfllTL9ECrl/XRWBJ8f5sbbYn7geZ7z6mlR53qFpduVVVIoYtUt81WMEwKW3l3lescSVNHE2bzXUH/JeCSDAecDLJYxj+OZFj/xvcB5cu9do4+dCaFO/lEcPz4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msTmpVNhqjvEFefXPwsB7dm4quOpNOlDM6fU8dd+8OI=;
 b=gJGs2nesg4Z2n85MfHG72/6gZn/QwvG5fp5snEN/r9fESI0fAGrOh8VaXC8nd7wkkt7GEu7fZJ5vqDWlGV4sPmyre6Dqz30kpoCwcpjJKWT2wRuU9QQ8KkUtRjMpz70aImg1aKl3muDSjG7/qif97/3fxvd2D2/sz+Kp4ocjCX3vQc5/NyiGEzy3D9KkZTgrhjEPWYTFwL9sydYW/mkMjoj6WftfSb8Q7vI/YWy2yJ/I65HV5urwZW2GiHC9Rtkx94/+j5t39bpvrsCzJEE69pOZ9alSC6YzLLCMeHv9QMnghRyMhMLBi4Qlxa29oQv4i8btE/SxbUJht/q5B0d8NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8273.eurprd08.prod.outlook.com (2603:10a6:20b:537::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 2 Oct
 2023 08:57:55 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 08:57:55 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 07/19] parallels: Create used bitmap even if checks needed
Date: Mon,  2 Oct 2023 10:57:26 +0200
Message-Id: <20231002085738.369684-8-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: e019d578-66f3-4a5a-6b3e-08dbc325a9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02ZsbUYwST+cVw0eeYNlg567IApSj9/RfZhM3LkQhYQr08Akbcks9/J/I1pubu5uqOeKMqzqxHhx2jGILjEaMmP8a8C7pOYgSHhvYthQJRHfPpRyWXxV2OjBhm6OeCOD3UzjQ1L4rHLczq3SU3RZmtAqGkYgDaas+5ZUTTW25Es5NXrQhlhMaQiNrwypyfE/tK2copp2imYAYQCsn4yJIG5r43a6e2hcmVvxNRiS8Ol8uHyinRCWf2efLREUbES84n3qg1YC/As05KzQkRTN6RCPnGFVg2uPcJYFLwCdHkFo+n77nWm8O8ZOtyarrGpFqZprWfVX8MZcOM2kYxdidzJLuR0hXfM5KhWkI+XBoSSTJCgE5l7c0uPbFUMLN3bhu/dDf0EWs2z0no4USAaNnvwr/3Zu9h9dy34HKNyoP76xlzepOKi7XvUgj0/LiWCeaT2k8+TATqXy8WW4+momNe9/auALc4fUhTGRJl1+tLWLDL7OlpFudJkUwZNYjcehjzR5guQO9Ydx314HyHVsUiAxPZqALcD+cKibCfCL33GEEexx2dm2ydOsxIzui+lIDy7htRt+2FznB2RHsPRdUH0DZx1U/vux75SZe6Tg5tWj10G1SGJSaaRCrDyAdtNF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(39840400004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(1076003)(38100700002)(2616005)(26005)(6506007)(52116002)(6486002)(6512007)(38350700002)(86362001)(83380400001)(36756003)(6666004)(316002)(8936002)(4326008)(8676002)(6916009)(41300700001)(66476007)(66556008)(66946007)(44832011)(4744005)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MtxxQ1n9+ZOZLgBk90fz0Fn04HV5P0IgvEg6MANokyJRh40Pc/2dvGupsmIw?=
 =?us-ascii?Q?VQvEuH7fCcfZvWITqfM3fw+PCqLXMQpelm0Dhah03a4k4ZssV+JCorq/Gk/D?=
 =?us-ascii?Q?pmExrU4KJ0NxZ3T0oCO4dPiLEUCiYEjeRYSNp4VrJxrqgr3A4lqd6cQQHlMV?=
 =?us-ascii?Q?P5/SkRMTqGs3D9jWes1KA/vxKFAX1oIIQS1XaZNH8Ju5puM8gavGVH5lWfLn?=
 =?us-ascii?Q?6SemYWNzmpfL1/O6LkcLEhfbuCBrsNzT2oQP0rlpG6Ca4/rnKmQk71JjXA6+?=
 =?us-ascii?Q?W3v/BALDgm8XEVU7QvJdpDiXXckVtp7AGNMjy9VPcD/CcPHJKE+Uz02RvqVv?=
 =?us-ascii?Q?pbGIGkEvB5aZOpiU66V2Onao0G0simKy5aDnXG+OQw+k3GagA4pyJQ8GbV8u?=
 =?us-ascii?Q?EHKkwon8f9OacaUtFwqnKShe8Ui0DVCkXHTrdqB0B9644RJ4mZZhKwMstvTN?=
 =?us-ascii?Q?dUVWteUpRRNbT7KvWjIXa2G8Q4ArOa2zldIshPUsv+1Z4terpjNUNXXUj2NH?=
 =?us-ascii?Q?dCnSD6HgSPTc2RIlBe8c01KelgzWMN4dyS02AlAubHXFNn5BI+IqeiMMpRHE?=
 =?us-ascii?Q?LcR1MPqLdkpAf50kCLj8/J7qA6/v5BhqCZSQu/0vnC0FKpuDHLRVkHoeeCQ6?=
 =?us-ascii?Q?MzVPrdswiogeqHjM5XlSHbEYbdjO1p0AagTZCchzZ7slMAme09OH1so2VqQ1?=
 =?us-ascii?Q?QYdUHRG5WhoGirdS7EdcD46V1xxwh4cY9AA6gzP/LZvzT976ZkT3LuH4jVGq?=
 =?us-ascii?Q?E+8xVn3bDYkXp0zyP2q/Bu5d0hzW9j7XYC3E5eKZnYTf5VA9JTJAtrrgvZCr?=
 =?us-ascii?Q?RIn+Ut6J2i/GIZfVuOWLRIzSa+azhoX4bQaVr0yqL6VyX9NJ4s6QcK5chhqg?=
 =?us-ascii?Q?TiJpIbNbHVk8sS8Et6XFHNmChvwGSbSkZWcBkbG0GVnZIy94UdGH/LOWdlsX?=
 =?us-ascii?Q?3V0fTKyDhLJ2lNGatT++iuljxZTnSnAIrGS5K+DQ6ohJdmRBnYFlckgwG2q2?=
 =?us-ascii?Q?3GqjUmO+/QIOxkbprAyodp7rXR83Mz/mPOzSo3kLFi3PwFK99yBHheeI0j+N?=
 =?us-ascii?Q?RSN3cVvhKuYUjzRPV6Lw3iG+nxFjkTSu7PkxlE8BfNwi+MHR+WhrxP+FU6qq?=
 =?us-ascii?Q?DVLUyde57ANzYXGmJYhCqUGjtp+s6jgCCI8GEJUyvkhaFQAmuf11oCh6wKhE?=
 =?us-ascii?Q?hpHbDG93AWT/Qb214Zha5aSnQOaPf/nOafQ3UMYxqrMtRIm/eMDmdsSk4EXg?=
 =?us-ascii?Q?nqEqVlkxrJeYpHdjg6Wt6CNQKua5ErhFUTOsRn/Q1et8Wjz3SrKsEXVJE+cQ?=
 =?us-ascii?Q?jvso3v7Ip8iLren6pG/qSrPRKcrQKOtFthoCwf4DwnNoBOuEISSuB2Cc8eKz?=
 =?us-ascii?Q?B8AwPwoYnppJ0XH4yEFolFYPoXOXJcOGeaTFISawlxVnfHXeb1RsBbIt2Slo?=
 =?us-ascii?Q?kQrDHxl15DIZoR72n2KAIcTdGC2Zz1asb/+DYT06hLy36xnE+kZXf8KVPVHL?=
 =?us-ascii?Q?iTMMo1habl8xPiU5XnScgiJGWys7diPp/xd/Yeo2ZjljJ9otqJB2A2Wxh8UD?=
 =?us-ascii?Q?CO/WtPxZPf2lq87mOIeEjsimp6y7GYwR8RvmtZSj0XCVBnbZNXrZ18Wi+K3I?=
 =?us-ascii?Q?F/fybOmrD8iTqVljznxedSk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e019d578-66f3-4a5a-6b3e-08dbc325a9a5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:57:53.2605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiLSVQs+Ie3vUOnB2SShJN4sUK51vHKlvZ76bTOTTDgYsfCzP02tqUqUpCCy5P2CKUMNlYmac9yvWgxR71vLcAGwzRElKu23CqxV9Hq+VpA=
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

All the checks were fixed to work with used bitmap. Create used bitmap in
parallels_open() even if need_check is true.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index b735ba8390..8208c0bc1a 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1416,13 +1416,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
     need_check = need_check || s->data_end > file_nb_sectors;
 
-    if (!need_check) {
-        ret = parallels_fill_used_bitmap(bs);
-        if (ret == -ENOMEM) {
-            goto fail;
-        }
-        need_check = need_check || ret < 0; /* These are correctable errors */
+    ret = parallels_fill_used_bitmap(bs);
+    if (ret == -ENOMEM) {
+        goto fail;
     }
+    need_check = need_check || ret < 0; /* These are correctable errors */
 
     /*
      * We don't repair the image here if it's opened for checks. Also we don't
-- 
2.34.1


