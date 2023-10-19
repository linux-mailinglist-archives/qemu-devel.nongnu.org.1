Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 995177CFA64
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:07:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtScV-0005lg-6f; Thu, 19 Oct 2023 08:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScS-0005kM-Ex; Thu, 19 Oct 2023 08:59:20 -0400
Received: from mail-db8eur05on20725.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::725]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScR-0002g2-0j; Thu, 19 Oct 2023 08:59:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhOHKpZcUvTR0rYe1zMACvj7svrzAQQUQM5LT7NM9M+UnmJTZRCYS8PEY/SESx6OZVhfT7xjqY90I4WSMfl+KXlJ35tqIko1TNNimI79xJV5fPqCFe3K4Is3UtAB4nZ1gF9fRk8haBJxI36k2ONmLeIjlIwGIdzMCEGNk7V7wOhLx5c/yCe/Esi3rf3DGePanpLCTjhjQFpVd4XRWfDkNm2saNTp4oOqkSbAmluVl8fU85kWuT/fG/2keekkTbyP3FUtZb+ET3dd/cNM9PToNF232aTiEXLqVRXVU/75BFepwkKX9p7vYfHw56CThIC+SLRzOTTYwu3WMdIEhsvc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+dkAU8jB3VPCRKq0mCBLdFkw9LSev8c99bgqrLPiBE=;
 b=aV0zvsMJgAZg+spmXTE/kZ7swWKlBDDjnx9sihkoHvLpk+5EF5TVX5djsHFRXqcvgjSgPxy8J0VlfJSpJM93M14kWvT8bULbiB4nVun8prhN+LzWm7uX0JZYb/4q4sCbjnViYcGpOE6JT2bT7xOZikMCagSoqfv0iN9rA2x78HHBDca0pNC9GoQwjt/sYm7x4BFx87OIxKOFY9va46LAz8tZ5MfRMBiQXT6AFUwPPEfPvucYEwInHkW624oopXIv9IhlyTTN6owvA9NkWNVA4zXxE1ufghla1WYb/bQoQvMojzKdmusMA71aNNSJopmRXd6Gk1v3yUmSDBczDfBO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+dkAU8jB3VPCRKq0mCBLdFkw9LSev8c99bgqrLPiBE=;
 b=S+Kt8yWSQIrDdUlM+l69vJgWLfMj55CCM7O4nT0JE88hwa6yGlOYm6J1PZI2bpCl0ndlvUoHprt7AAOX7XuBGnwsiQsDTVXAuUHFehxn930xzJJYcjRsp5OTEzcQuMaXWqo/2nRL6NQo2KH02GUMiqzs/DRbSd75/ZV10i3aE7yDRT2MG5lUGISmtplU/iXhXi2MUHbrEvt45ph0JRpD7qxp75WKoawAe93cgZmnLfD3j4i1BiMcJ9AIj0lR47q/Gtw0m8Z6rFQWz0TT2f5UCEQqZaOJ40G+HSKG4RPFInm+cvgJ/VDk7KmE6QvVOUVyt8yVpUnbvzvvvcH9MAB0qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by DBBPR08MB10554.eurprd08.prod.outlook.com (2603:10a6:10:52d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 12:59:10 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:10 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 08/20] parallels: Create used bitmap even if checks needed
Date: Thu, 19 Oct 2023 14:58:42 +0200
Message-Id: <20231019125854.390385-9-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
References: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::39) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|DBBPR08MB10554:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf71d27-3c45-475c-996a-08dbd0a32fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+jeOXWp+pfLqpRhvrXhe0TuHgl+EeeC5piXUC67oHZ102queWjnfW11sY0n6k/Cu++75lH7zjFMNoz9OiKD0tAVyJuHyPSwO3NDLSffNXvPm/SGOmaj6OEkLoTcS2BRb8AojCH1mh2dcJZ+TB8q19G4kX0R5Lri5P1/7fAS23+LjK4wn+y7uaWsM4X42s8TdVZKvAcdD/XPNNHyyBezQjCFsiJIehtTbRQH9FznL4r+y2KgpLZTAIROwGsw5HxnBLOgkOq9sRFzFjqB7CbhGojysjSc/Afpwjd0rQBoND1ypnsxBPGE5qqLIjsR6vB2xxehIN4Y5GCniICZ8aR5sqdy5alJnQyFDkJBFDa5P47DXIBl+X9TnjVaQy3jQ+7PdyXKnm7ZH5nLlGQZAGvQO0AP1PVKJ+onle9SR1SS8dD4a8ZHtKcFbg/WmFqhf55UxPXfC9iQF4ZlXMcTk2Qsdsh4/3TQAaCz1iLgZB89UD/RUiDHlWzIm9K4yuB7TYhRe/3Y2C7fSqK6xzQZwl1xOUHmxCKuR9Lcyz//J1Ag4JALnxkK01S15UBucsGBkgt74qeGTl6yawedS6di4bAIC2UvEcWOCYJj4UTm8U29MyyTE4tM9UzX831wRBhv0gXH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38350700005)(38100700002)(5660300002)(83380400001)(44832011)(41300700001)(86362001)(8676002)(4326008)(66946007)(8936002)(316002)(1076003)(4744005)(6916009)(66476007)(66556008)(6486002)(6666004)(6506007)(478600001)(52116002)(2906002)(2616005)(6512007)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?far0YfP2Sr8bppqsPUrSl8SVlsqmzaEdnApE/AKsl5+S14GfrARwU50dwbWz?=
 =?us-ascii?Q?akkqSI0SY2rZ8xQuPNE0h6GQeBaskoxWS4qkGvcipjoEBbZS/1JQWJAtq+sH?=
 =?us-ascii?Q?PqipMaNrOadfSVPel0yViZ3y4/8cRMSEY0Gj59Z/eC9Un+C4tRW0iXQq0ZIG?=
 =?us-ascii?Q?5M+YuBGS6LddT2gSZ5jX3HFJxrgRBDD4493xWvD2HI5MH7kw/N4xGdPX1gjg?=
 =?us-ascii?Q?jimGyi0R7eN9ifkkrF7xQD8dmsh8xxKO1bkH30dip4r4JhhBq0XzFXPDlIRg?=
 =?us-ascii?Q?XVCnqsc38HLhXWEQfhqHxn/H53/5gQoPV+0virh22DORqa4cQTNoNBkA+WYU?=
 =?us-ascii?Q?gntZYugTv6mN3kZo/7CSXu0TJcO8mfTbCt+72uivSZhEM6GH3T5vcIXnodQe?=
 =?us-ascii?Q?Zt2CUVxJ3LeT7vIN0mSR0HUfkY8Q7MKTEWF3IRBgCWdAvJbxsZ2wI6F55PQZ?=
 =?us-ascii?Q?APuQpMnEdAePJ4XqTre7qg+2kouammWTftj5O7I9Tz2YeN9aetlDRY8y8w63?=
 =?us-ascii?Q?rIv2gK4c345lhCjZp26aIeOSDIwrqmkKoPlkfYhmUC5lL3D32n6GsOd8M+x4?=
 =?us-ascii?Q?5uXT3NQ4bF46b1QxKbTNBXyGitMHCZbfRhvDNS4bZx88reU1VuGI9mSnYQId?=
 =?us-ascii?Q?WMZxz3ftYXYakoZ+HId+A/gf7S0NPmTwRPQNuD8HBT+F1ho98t7doup64q1f?=
 =?us-ascii?Q?u0YzBR9kLmGpZSd1UHWJ+d+dFffLVlsmNmsb3eIOJvzr4XTay2Qeg/nTGQFX?=
 =?us-ascii?Q?lkc4bEZ3RnUrGR0dq+OkFr6IUNguklX4HVKrDADQC52JlTRAruGdcX+rkfK9?=
 =?us-ascii?Q?zlddy+Gnf64pUD1r2LQG2iM6SSYgUE+5ohEtQgEvlRVQCvrdqVnJtIWONU/n?=
 =?us-ascii?Q?972xXIrFHN9b0F84jnHcS2GpCeQlTJNWx9kO2zSh757Xy1H26eMbGN8t01Hg?=
 =?us-ascii?Q?nsyI8HJhYDIMkVGsbyLM6LK1fVHsm2Gz+5DSO+UTRXb6e0/WjphLN7AzXjn6?=
 =?us-ascii?Q?pHnS8romx1vlfxqB+fIpjqgHx0IRytqt7EYGRvmvqbkgZbSoObhJux+yMKb1?=
 =?us-ascii?Q?1wd9FzY+GbFOr8teugpL8VMeKaAFn2b3i3idzj8MS0K9EXgJdm16NXggwlzU?=
 =?us-ascii?Q?NMNm7/qRhfIJi6ldJ92bjA2WNW5GNhL+T2KKfhMNz4V5szyD54K6kOx7lPCd?=
 =?us-ascii?Q?uP8Z2kK/veMtuk3SS4QQXti6rGg8Lpf7vfkshuQIH4hj0Hmn/jG4UNzGiaLC?=
 =?us-ascii?Q?PgAtzWbc7BrFhCg2vIXUoW8jEAmelw1mjThzhDvGX8kbhezePsDGMyZJj6Wy?=
 =?us-ascii?Q?ucDPNtHg6zp6tykVLjaHOq/O9ouWXnWzlOGsvqe9YVVY+wY3yhHiIUfZ0UEN?=
 =?us-ascii?Q?LO3KOnKzGZ0YbPv2VQhziy90EMF9BuZ3TTtrcaC3it7pR4oLzRCyOQfFrioZ?=
 =?us-ascii?Q?iRMmCJU+8SEDcV1bxYhv0oLhmexVD3sa/BQBfjye3LJcwYxToUt4OTVnkTf5?=
 =?us-ascii?Q?rkXCc5PeW+Th74rFgcjkL/2cY3sMKZjzxy2ztDmxybQLRjGHdsGSfJtnTKkW?=
 =?us-ascii?Q?prTjSqI9mPgcPShmkDjSpgNlDbRER5fiBi8/8N+Z2017Yw0ttzNjcphfQKca?=
 =?us-ascii?Q?TKVcKGKog1P6XTe+zpMI5wU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf71d27-3c45-475c-996a-08dbd0a32fb8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:10.5668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2e+jn88fwZpzEQQMcfm7PhorzRNIx+DfkxG4YoMp339j3bOwSJWlYyijv2lGzmjPq1X9fwciZuWsmGZvP5NCZRaPH2xHdD+lE1bIDdWrSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10554
Received-SPF: pass client-ip=2a01:111:f400:7e1a::725;
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

All the checks were fixed to work with used bitmap. Create used bitmap in
parallels_open() even if need_check is true.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index dd8ec925f3..a22ab7f2fc 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1422,13 +1422,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
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


