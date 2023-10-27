Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4000A7D9044
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:48:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZO-0007q6-RP; Fri, 27 Oct 2023 03:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYm-0007EP-5R; Fri, 27 Oct 2023 03:47:21 -0400
Received: from mail-db5eur02on2072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::72e]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYh-0003oB-81; Fri, 27 Oct 2023 03:47:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFoOzuiV19gEdP8DxZ0gwdKAGxFYdy4sjnxMSdpavCNAlgC7kTToI5q765XbX7dBpXgaZy+OWXZkAkvasY/qPDPFELAWVN2K8HnpqD58YGFI8zwYSF4t4G0sT0dg14k0zoNoPQErnSWuZ7oOC2dhrcQ61EK4C84WaF3tpNGcu58BjE71R4UeWQLL5dW1dfuDl9XyDJtYj62O8TC0uCfBoNTYHErNneuZ3IGgMC/Zu0lzfUHJiFJQ0bN0b/QaTLDZEwbw0yYwuCmg6kgbKJACtMYSmhXwyFG27dgc5MDLXkTGCywbOzqHGDD/FZn8K4vMtn1BTA7jMMZRvzYj14atNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDmo7LAvzK9QaWsuJVA1/nreuMd4fYKvz4iP8ze4nn4=;
 b=Sr6jMfuBCDeZRPrBjQN2RtwijpQp8yfn0EauPKjzjfsuziSL4NrGiELZUtOcMe/4xzgDleLU0KxikvyZmvDiRmQ4RrBEwukePIkX+4dT6bG7FwU4T1UqqZ3cK3IQ5uidJUSHMV4Dx/OOTIVfDdWmjhc4VrJhKN1OAwD0kjIX/bX+PYFRIg5j0qsvsqQcwwSTTpYKQtr0aGuNygW1nui3IaLyfFWG+cBq7/0mzJ6DoZxNdDz+IdSYn+A2jNUna97X7gXyhATVqK8XAQRLvJv6/zAx4qIt9IFPofzEuJA7eZikKmjespMHJfYIyD0nC9Iwj5t6cfwGEBZ06SVv2uJCTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDmo7LAvzK9QaWsuJVA1/nreuMd4fYKvz4iP8ze4nn4=;
 b=g6kv4kxLtjMehNrsT4jwquPfd8wf29pcjzrXnVdqDjCVbrwXAA+IjgzEMSrIvlTd8AuPt9Zh9KySGNQZ+rX52nwFKTCWQqyYzLblZ6TsRag7uTP7cGPfqksfiy2g9VHW+8hC6XqRmQTu22Qp1P3NehSMLWZgk/lx6wvbS2TKk73XrimdI37yKTVrHRheTvY3Dg+eNBeIj5dr9Y+jXhnbBC9Bd+a2f0XcRnsCG81U9XwkAQrYFBai2bvRXaCQNyvewPGx8gdGtaw/ZdO36NAHAsaBWS3GY+ZF1bq4PSzndpUaI6SR6H1S+NbSYtd1ndCTJZ0oYH7j0JQWjwlvAHWQpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB4PR08MB8056.eurprd08.prod.outlook.com
 (2603:10a6:10:387::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 07:46:48 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:46:48 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 09/21] parallels: Create used bitmap even if checks needed
Date: Fri, 27 Oct 2023 09:46:24 +0200
Message-Id: <20231027074636.430139-10-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: d71b61b5-614f-4f14-d0be-08dbd6c0decf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKZm/Gs67gS9AmbYSSndLCjDshW8DSj28EOGJvEotOQ74PVRI/g4lfV30ZPrgAmyb+agAzc+d2zAlSENrCRAtF/E11iN4R2DgdLVcDBULgZQHbaHHoFrcP59IUm/1UEi9xWtd986Dv1y4xV5f2LDPv1GELl/vwbkVOYGhLAlgfJhcmWfroUr4v0BLuciZBUXI64boTyhhLfj4Uli+cjDUi3vLXevNElR0hOOqg7XDPZP7Xu8zhZB3wDo4K4Z2+TIhGsHJKcCF7I18Ir0SMvhzsiuiU9RB8O9MEPQ7a2RP1AXxZtbweumJHLfeByx12RIXhJuOOaBfHgAzpgh+hTQe9i2YYv//x8VrU1UtdDLQhOMVOMCv7LtiUdm/j9jBnU4HFEfBHv58mkdesMKTluQ8vZnN87G5aUaP2KmJWTn7WhuvYnIrPETDZy0XtAzfKX0O1xoDWn2TVofEYB24vCfFDj4Kki/iBUgPBQ7AB/PsPSNwnKLbi087Vj9MomefHt+kjZ0WyZFoPIpKJdhziOwFRLKDFG6X7fX9/hJKmnSzYsC7jPwkIK817HAvlrgLax8iaNpkxEyDY5flwNzjpXgkFTfIsNQtmQ8YzQdWGZVloOoXg24krq9FOUa+YItd93N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(6512007)(6666004)(52116002)(6486002)(6506007)(478600001)(38100700002)(86362001)(36756003)(2906002)(4744005)(66556008)(2616005)(26005)(1076003)(4326008)(8936002)(316002)(66946007)(6916009)(44832011)(5660300002)(66476007)(41300700001)(8676002)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JbaxMgebiFTFXkwYhic3rHQWZyYv6CjNazK7W93RKTSzn0j4b47jfi05oUUL?=
 =?us-ascii?Q?k9QdOyqqAMavtKDZ7HZfpk54vFTmylkGWC00lHzRR153tVU7TRaa2Jiy4qv1?=
 =?us-ascii?Q?3jm5tokUuMGDteL+9fArPyoLWpgqlzYxH3xDGH1gB8HNeN8vN4xonT8rMlVi?=
 =?us-ascii?Q?QP0TJ0Fn0DAeoPswVayjplv4Cr04DBTARETUN97tc16jkNeXSqpR1u815thm?=
 =?us-ascii?Q?PeEWPa7eyYOWxRM6YJC4+/PqHCzZnPQY3pogldEo3hHQQRP9AlrIjbdbuisn?=
 =?us-ascii?Q?roVhloK8PqZk+R4kjL0A1mWLU+h2UyE6YwyW27eToRB9YvORVA5kLc74siSO?=
 =?us-ascii?Q?FsrnP6mN6w05XGsGWir91YuPyLj7+ckTNM5mf5ci9152lt2zScX/YaKfEv42?=
 =?us-ascii?Q?mjdKICLI5NRj1JkbPAey2O7lsh1QVZ5qy4BGIcAKpYn1KN/D22tw+1LqjesS?=
 =?us-ascii?Q?YTwkkK35iSOk5venkEByBlLf2OO4Dg+Ar/VVtorMiiPUhjHM7SLY1+wYSDCc?=
 =?us-ascii?Q?zr0AQnbv2BDUEr4ex4IEOLDRjZcAHU9Lk0SVAgc4RnXYRbRZON11h1dese1N?=
 =?us-ascii?Q?213l89SQgdIJ8aj9yHpIFUjatcIgBZbAtZqQhP8M+iXi5TJgSs3Oew/de+U8?=
 =?us-ascii?Q?o1glp344Lu5D0Md/90mCaxXWlU8OZmhy1HYEw73Jb7VR5r6hZ3nnFU7LcfXj?=
 =?us-ascii?Q?050lLLVGk/bGXpa1UPBiWLhn7qjToH1kADl9f1bB1G73/DML6uFw1r7P4oji?=
 =?us-ascii?Q?Zi6EOTK7FvICtApV3jJXnUF9+7xiCfnM3ZTuZ7wA4w4xwNcW8Zucfi2ZYDhS?=
 =?us-ascii?Q?ClxDfMrc1sCTf4b/+IbuphNj6wQnlsAqMCXG/9UMOevwOILp3hhQPAQ1IH7k?=
 =?us-ascii?Q?vVdbFzQq/C5nwzB295Om4j6Q4x6X9CYGLsrXnhYbKODEkpAX8kP5RK2T9BV6?=
 =?us-ascii?Q?BOsEbKymuFr2lFYbO1N8wW0cumiDcOZaf87xib3tNAw3umWg+6Dq2SleH4pz?=
 =?us-ascii?Q?FtnEcSaLeX6ya3/R+BMoGb2Q5ZJEAEm9CEjNRiyopLJPVPvxeleE5udhASiD?=
 =?us-ascii?Q?gL0t3zHyDpwwUNItruhnMOdVLcHcM9/OcKzTjrv+jKeDEIW+ALFWix1Chwnb?=
 =?us-ascii?Q?QNbdfdZWmLpy2O8scL4r3PbcQ/t8V30OrpjsM/BADZLLS2Gelagu7f2b9nLC?=
 =?us-ascii?Q?AR+V7QOgFixjxNMU/CPJbgQyHXZTLeJs76uCmxg3Njw+GBSnxsooCiDJlm2o?=
 =?us-ascii?Q?VZyXFjO/VvSXRcK/Y/eefpV7/Iy0dksVQhIB/FKa3rBxhkLZnpIf06c6VJ5H?=
 =?us-ascii?Q?IgUuV899HkUxTNqIUMQS05dH/hmnMVmwxOSc5xu0RdoVawt2JEVUhm3kZ5lH?=
 =?us-ascii?Q?fB1MGD9QBd7YPWuGlYGxV6tuPgI/Z37QpfrirxyBo9QOJN24tl9RX8apYGcX?=
 =?us-ascii?Q?nUe65CLYwYCyWWT9s7CjF9sQttYkMqE5+i9NWHl1j+SLfyqC0PU0tIw35X6e?=
 =?us-ascii?Q?xiGa1rdlLEnA6CnEtadxDaNaRp4HCgRq5U8Lg1zIjiqM3NehvmmjxlL9iXpf?=
 =?us-ascii?Q?eJdouP+gx5m/i3+UAQ32pcg5eW/Svl3tZUkO4DMZKxJB/FPnK95W4nanF2hR?=
 =?us-ascii?Q?qS895COrvyz99Eic6asWwQY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71b61b5-614f-4f14-d0be-08dbd6c0decf
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:46.4302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiI3g25micV0v+lpiLB3dLfd6vFpXOP26jFjj59rXqpnLggQlgeaFj3SBP3IRZjpHXH6ACDnRpwbRdwLuRZiBfwQDgj3NCjf1WWx+i7r964=
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

All the checks were fixed to work with used bitmap. Create used bitmap in
parallels_open() even if need_check is true.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 481b6992f4..925aa9e569 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1423,13 +1423,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
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


