Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6498E7CFA6E
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:10:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSca-0005qT-SR; Thu, 19 Oct 2023 08:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScX-0005ng-4r; Thu, 19 Oct 2023 08:59:25 -0400
Received: from mail-db8eur05on20725.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::725]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScV-0002g2-KK; Thu, 19 Oct 2023 08:59:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPwoa6/ij04YTVnHZKXVMa80ry+6RDniJQH7enZBpdJBtFA2ihQcZ+sp9cWPukCLr7qoKDI94qLnXUCJIkEBqcm73lcwFV5Mc5c3fixy2fiYe2jBm+jPTmHFRJH8ZrOgbEq0/E2yqKpybTmdPwa7/MqisZfwB4KujuvjUgWYvBj/dKXLe6LWuUnk6pKDXPILerWTbR4AlBlWIuJ9xRF/zmSBYsxPpZ/KrO5U47HXxkwrvq7QvSOvkeORDp/OIlr7NjsHkwHYypM97edS5OLCZU+0KOd6dtTFWcYU/2/ja1vhzUPRL5UnNew7er5VaHCMDBqbLATiThDFZV8HI0/kGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97ukfm6vS/99N2d/mWr2AxWxYEsWR6QQMKlvpEE00Dg=;
 b=P1tBOD1wRsxWnxQIEc4/A8cx5hqKoNStDmILxyEViIDYwCIrFI5NuLumGSDFYGeIPs7ZzUaY3sUdWAW5OtSNw+TCMg8icXZfmPKgtVMFw7QZ4nFG16krnG4XK8Ppc0vrnPhvLTm5nNQj7CXhRNvU1vDJRodb2Ofm1Xa6+BeNsTl0pnpLyBPQ/JospJD9cSkjOnSMQ5RNZZXwpeWY7zOGdV/7S7RG4rvJEhsvUAZYg07vOBPb/W+pdjtlcaG3o4Yqb0CvkfHQcKs7fU1gaB0KznxqyWfcivsi5XpSf2tEESS1FG2AzvVXYKn82vFlmOqkY47wZtgS3pgP9NcrcreYow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97ukfm6vS/99N2d/mWr2AxWxYEsWR6QQMKlvpEE00Dg=;
 b=RVQ3Y1eMqT/MRICQ+rdndslIPvWR8z4/8SBgoVyP75a5XSWa/RbJwqLxGDsSj62pdN/iUge3lixcQSDFiAXaco9Gjm0Nj+ChpZWhgaF9z3Hmhr6rztTX1LbxWwW+pxpLc5dPljuk0BI/mpmPvtEA5q8Nx+MlZWbA1oVz5QC2mfUGbte9Bt4l8jtxhymUYhACrLlk3onVUEm0agRpfND7zRNq1TMogEnc3Z1UuLg77Nk36OdeCXFOEtAwwR1eNej4yPAjz82SSfHDdmK+Gwo3SM7HO7CGuSmaUq4EvZTWqYR20Ro2UofHjBr5jCJNdbz+v0qfwVraNkf4swJyWQdhzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by DBBPR08MB10554.eurprd08.prod.outlook.com (2603:10a6:10:52d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 12:59:14 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:14 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 13/20] parallels: Make a loaded dirty bitmap persistent
Date: Thu, 19 Oct 2023 14:58:47 +0200
Message-Id: <20231019125854.390385-14-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 67640a00-eb8a-4a29-bfaf-08dbd0a33232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3KCI3QahdlC3JHSve509W24U8rZue5YfIG+ueZ4l1Pxq9SSChSnxB/liwE4Fv/Nv52bxyQyHLiZyTpGWYF3KvSmnRjYDiZdxsf4sy59/QqX8Jdc7gVtzkc7lXTp4O6Tg0AIA1y4J60SM/Swt5vOngh3rShec1OJhWZYd6NdXa2bq3oQAgj2Cbk8HOFMm/jeH9ZqaQVy32m75QM9QKO8zUl46ZqjtQY/3GK2hnCbER0kHnyL/ZC5mVBmmluA/t6E7GyxApsk65S0porSXJv6Otb7ciSnCVfqafQz5ChZlnMRWHLtQe/ck3uShDcMvRbKKsYaVxvwyUpeSEq9PSOFK9Wo/aWXCLM/9vqSvZtA4sBaf45h+LCOZhsSbN06jnr6sl5yTkt9M4lQQOcuVGHhkZ4NCyUXI54CqL/+bibL/NVVPa01RnstAI+4MHZ86alXxkAn12XV7cbhJGYWbDApyZP8fpLpWpP3wI92/u4kaNlRbpCHRyMUtH/5GBYIYdyAQwO86iXyBFg1xUZCbYAOF02x5/Edo5kycwweBdXMDvn+KhIwu4mPaEWazdd7TEbEcYWV2sen+5zxTs9rJHABNISSxLUnA9vTAFsi8jTLd65UlymFxARtrTarwB+gn3iOGAS6EEfrRLSr6v0yPJSmL1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38350700005)(38100700002)(5660300002)(83380400001)(44832011)(41300700001)(86362001)(8676002)(4326008)(66946007)(8936002)(316002)(1076003)(4744005)(6916009)(66476007)(66556008)(6486002)(6666004)(6506007)(478600001)(52116002)(2906002)(2616005)(6512007)(36756003)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tQMyUTQQ0C2xoX967A7svIdQ/cHGjngpVhyAE3b3WdASBZuSicKYfqt5L5ea?=
 =?us-ascii?Q?BtPM704tV3waU8Cd+LuU/R2TBa7DaErimcgkmCLCD32V6XNNpLOEbmtvnL4H?=
 =?us-ascii?Q?WCWE9Dgj75ZnfgVKbtMdalPu1xTjfJg9mjMCIGXB+jcDTxMnEMFxlBuPsY3D?=
 =?us-ascii?Q?jOjduHZdtTGJ7GHxStOJJFjsrakeCt6yxUp+GC7mLQtzz7G7cBpf/og/IZak?=
 =?us-ascii?Q?nuKzwKB4dDolt3fbvVq5j7v9t94Qk1Z5IMECu8BGDCY3pZwtQR7aGm3zF6BZ?=
 =?us-ascii?Q?zLhbH8J895ryT0HgOI/ZMOwu8bXR1DveAbbUoUFaY8c9wmVZAx/togtMjx1G?=
 =?us-ascii?Q?9NGnqeVsuD3B0/Ajr9+IpOXfsCVDq6iMzMvzUwxb3zxsktwueVRdI24YHltJ?=
 =?us-ascii?Q?4V69a7Hsw2fL/Lmyq+jC/yQalWbUpIJprSCTb4dUu7vUsdOq5NmLzHx7C0a2?=
 =?us-ascii?Q?+xflOlK3IA/SHADkx3aKVX0C/ZN8Kh+o+EOWQhLoVaJVBHXjNrK/Qt+aMnfA?=
 =?us-ascii?Q?ihdqiAgevo2WC2i2HaBSYuH6j3abW633NFHBWE7cGvd/TMjo6TdwtLJCHqJx?=
 =?us-ascii?Q?+EbQWxjdfWqCqV+hiJbZ5yKsO6bPy2H4AqfHMc2MIQkx0PZ5cgN8eYC8QCGw?=
 =?us-ascii?Q?OnxyreuuzanpcgzohoTA48MkGhLTz+QwVCEPmRW9CVAFKm1Jr83uUUEaOvRg?=
 =?us-ascii?Q?onsdlRQL3J61+pshKiMq6f5kXni4wdv+aZF42Y+kqAvN8XV4MUhUeUZNFblK?=
 =?us-ascii?Q?9BdV2V0GwysAUloK1HF4CKtG5l2nhy2bzCoYgeMI2h95OQDciKy826et56Wn?=
 =?us-ascii?Q?Lf++XyrzqjDkq27u4FbxhTrmvGbtXHFDCJTrvyffkb87O7hCXYZVlpY/5Bos?=
 =?us-ascii?Q?SnJvweyZ2tLPSQgwEltHimgAmzY8TFX1r08cJOcIv392KI3iYKbCOHWoXt/H?=
 =?us-ascii?Q?swynx/ERNPuC/rSGbSUUA/Rq50NCVdBgz0c08+svToWLD6Wjty7oehufckt9?=
 =?us-ascii?Q?oY7mwYWs5smfZ5wfVOmQI/JEsomRfuOMxT+Ls+nEJ8klaMgFsHUgJfOxZJnX?=
 =?us-ascii?Q?xpMqBcR7qsd/B7EatxG8Z0Qm4yU9Sw63BiZKnmUdzat4r95GuiVUTjf0rb5G?=
 =?us-ascii?Q?FWDjov0EyBZoy0xgArcIr+gk6q1gLPdREXB0aHyUlpUU2YUWO4fqjgVM9FIC?=
 =?us-ascii?Q?2zScZRhlARgDz2XUUz5OJY5uTN3HAvS/PC9h4XZmCaoMO4oyZBqCfgwlJwtc?=
 =?us-ascii?Q?sPoj/5E/WYWvUpyUDDPX/NEFNoJDJswKFf52QfXmVe08RFCqxtwLsUtoe1Au?=
 =?us-ascii?Q?3P4E52NHDSHoyFPowQXR1BPyC0I8doHPR40RK7vMdAza/jFumB1/pOXvIFfQ?=
 =?us-ascii?Q?5vC5rpz9RHNSf74zKjHwrLOY5nALJmnhMNxbXbobQH1Tn6CwD8FegYshmMgX?=
 =?us-ascii?Q?jK3t0M1ywj4hr2swfabwH1I+QAO4RXGPgzsnyq2r4CIa3jM1x3GIKhWe+4/t?=
 =?us-ascii?Q?Ko3j5IgbbDxbt/jkoY1RgC/HamK/olL84WUPRtF5GJtKiZcjwiW2ic8nbrDQ?=
 =?us-ascii?Q?ySXs377Df82QACrq2o98wxXnXrGMC+W00w4XxHuNWPaiWjMg9zTo/lOXYr2u?=
 =?us-ascii?Q?fjlQVefcb4pqyR5pdsQLeC4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67640a00-eb8a-4a29-bfaf-08dbd0a33232
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:14.5457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8fBWuXzqdOuIJOt2t/LTvnUe7yQ74zC8qqba6Sw5PBzKsMOs5+ZDfevIKG6kfbNgDKb4rY2PWDMD+jp3uc6K8OP9Vua7hw6pss89KZKkUg=
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

After bitmap loading the bitmap is not persistent and is removed on image
saving. Set bitmap persistence to true.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index ebda6b0a01..bb4478c350 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -256,6 +256,7 @@ static int parallels_parse_format_extension(BlockDriverState *bs,
             if (!bitmap) {
                 goto fail;
             }
+            bdrv_dirty_bitmap_set_persistence(bitmap, true);
             bitmaps = g_slist_append(bitmaps, bitmap);
             break;
 
-- 
2.34.1


