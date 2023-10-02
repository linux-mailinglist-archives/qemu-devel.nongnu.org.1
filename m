Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7407B7B4E69
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 10:59:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEl5-0001n0-ND; Mon, 02 Oct 2023 04:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkk-0001Us-8w; Mon, 02 Oct 2023 04:58:11 -0400
Received: from mail-vi1eur02on20713.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::713]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkh-0003Qj-QX; Mon, 02 Oct 2023 04:58:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+b6Ev9KWJD/touac8kmS/GjSkakU0RaxCPf/ab7aEqftvsUFBqDJy1KaOW7plCvs1Lv14DDjvBaqvnRut/Lwcp8lZd4AdF1qMD9p6yAAZnHqTP7RW5LHuV7zvm5l8wib+UHUMhwYSV3kdmg6Nl4uGNlraUurqMDdXphcZSVHNaVEK1d/eW47jGBJgrDDU8x4g0Pgr2sKAGaQ88ckjqr1J55gx0VZf14CFeIHGSk+xVhTi/l/mQwwiKCTU050hIhmdIcuG4RLIGZtUUghnn4p82UK1H6h80WJcfLNIjI9pEehebBuPDFagMTkwWyvjfWzlPrqDoDYj+d47UmJpzFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSOC8T/RvkG1BGM2wRvFr+Qx1CXpkegjaxtGUI3juXY=;
 b=QG1tOXPeSoR6rPJacrFd0CCNOn1vtv2WLRpRdHA0HpqJWmAlfXp8iKD7r6Boiz6dJIHCP5sf/QylvXyBoiLfzucwJNPY2NzE0mhRqnK+2LceIGJg8h/ib3X7+vg28/omAbe7NuxCGsYp4iNszEFSYwHanaL1nMm48fkhSFZRDHmtTBYJ+068wGPSMGCQ1A0tvt8GKFg+FjX6pEXTdnpEiMZEaQA7bner1CLmVwH8SPH1scsj6YIGogb+0mxn8kL8R8i7jXm27lvWRoQuY9nSizTGV0A0SnhvN4BckIuIu3ywIq83oWHlMFgrWlIX7pjalJHS8a9lU+XejdMkW2FN9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSOC8T/RvkG1BGM2wRvFr+Qx1CXpkegjaxtGUI3juXY=;
 b=qJO6WenHX1kwKoYYlflLCrUkwccW7gWtDgBFqkYTHMk1ao+AqLhyXB1nNcSlZsHMSJu3wkX/0bNp/G1aY5/pTBtTacntbWbgTJ82d266uEcbmFMdKnhZM1pRvU/Hhat6fVMPmA5/Xev8XP+BV5ChpcFYyRbsTm/MdchWRBF3oo7VCxeWgJLztWUrYSgp6S06Lk6KpDQf8JW9BX0sMGs2o+Civ8mOONzHO61Ubs0k4dpcAxEBZd3GTwNVouIvQQ3pU1OAPK7KzPgPYB7QANoPxSrcHMqAWZcJjb1aa9tYMCedix5QWkdOxSUAJbqkev4fQx87ABC3/I9LstilkXvpDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8273.eurprd08.prod.outlook.com (2603:10a6:20b:537::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 2 Oct
 2023 08:57:51 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 08:57:50 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 04/19] parallels: Set data_end value in parallels_check_leak()
Date: Mon,  2 Oct 2023 10:57:23 +0200
Message-Id: <20231002085738.369684-5-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ea03a389-f7fa-4006-8b1f-08dbc325a7b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W02MVo5XPxizjSW29251DxHy3IA6DfjE3NQsD/PDobTr0meCRJnQ8STQ8M3AJncuSBcUbaBZfJBrlKnZelO9MDbMBUiAf0oaA2DEGdmTFaXH4JtFJx9As5UokYvNiXyCVHoytTKE4P0GQWfrzHgy1on25GHdj8KSGNh2sleSvfP/yIfIzDed2WpCW2Wa7A/ZvusKiw4W6g7RumGLHSZTNutM6FGbixMTh/sQwcwdxAWKNXxAdWmecPQnaWc66hAC2buZFgiG08ceO3J7J/U7a8cOFILOd514zl//hA2V2hWhxP79dnOWbWtOLRouiLIRCx5yGpVYkfSXCbDXgmHLZVULD6xh0Ux6DFU7LrUhMYUBsSRQGLaajKA30pbOy32Y+88hDOxZUGkv92CbEC+8L6x0xGTn8970bYbqlB24VWJG6VRqrkwkmtAW7dV9zzBLwhjoeM2ktqCLsGliCyHTIJFuAQJcrhZPTxt6HKl3Z9K334497UsL070qPVpawv3hGLnhN4QkKgLNAn0Q7NSeoN17Clh1zTFMR+kkPtABosFlJV8sXFuOGXpPKWZUaIkv9CXNYfwp+adnbSKVAPShF6svpeqMBQ1UGfs6oGMXN8lxCqM/TqOLF7mTmbLF51BC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(39840400004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(1076003)(38100700002)(2616005)(26005)(6506007)(52116002)(6486002)(6512007)(38350700002)(86362001)(83380400001)(36756003)(6666004)(316002)(8936002)(4326008)(8676002)(6916009)(41300700001)(66476007)(66556008)(66946007)(44832011)(4744005)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZBsvHIg8qFtG1AT7HeyXE79REz6ui89y2b4arvvlsR9iCjIz9X4IIig2lrpM?=
 =?us-ascii?Q?d0hyPjICOKCk39yzuA0qs7P8nY4+xfVX/g5CWo5H8FuwBqGVNB74zMxf1R4S?=
 =?us-ascii?Q?S4GS51xsxqG/hvrRmAvWG+mI+Sa+OUrrEvoJvR3kKkn9efrZhdgvf+xeiZgj?=
 =?us-ascii?Q?5EEKtSrE84r1v886Qg45MJHiMcacCqppBfwBuWe9ovUccrESQnWCvKH+Jq0B?=
 =?us-ascii?Q?pL3kUiiIyGq6deIaw5rMobt9D095+939GpDGcgCz7ypJiFAN0VpxuEjQm0km?=
 =?us-ascii?Q?Q/ZkSfHprCajhuZS/sDCIDILCOOpqVMNb6TFRpnoafr7Sk7Rv3K0KpJzv3TY?=
 =?us-ascii?Q?nqsiMletYkevJYlyhhsguVFr7lcICNapQwFgJp2ifM2wdmTgPN2OEXozqdtK?=
 =?us-ascii?Q?Y7tFczDLout9JJCcFo1gbtIH7grU2I/jCZ8v4UqjD54Ui6ycZfs0U0OUqu6+?=
 =?us-ascii?Q?ASPSvQC/40+ILJ8+f08KM7dhCluFWuMre0n7NpZuJM1McD/v2RYYirDgNI+6?=
 =?us-ascii?Q?FfeTNYxLTuTDpc6Nxx+5+3HCmnPqQCS3SFDrAvnOq8yf2wNBWNYTRfQg858M?=
 =?us-ascii?Q?zT3tGuL42t8HUBVFVosS5rmhdEc9DtHIEeLywQwZhwfuo2WVj6ilqqFgj4bd?=
 =?us-ascii?Q?ZkZ20kTZEVeo31DtG0fvyJTJb6Dxm4tfg6P6is4GtNySHW/tG3sq6H1urvA8?=
 =?us-ascii?Q?Bob4ruQKHCLh9EJBIIvfISO22X0tMwueA9aUj3f1W3qQ5X7T1KMtEN0kyYyu?=
 =?us-ascii?Q?Gt3Fc7E69ivvofnCim4kLvHwHLviANADCetjcODcmr8oNOM4uz8kWmBDkhga?=
 =?us-ascii?Q?J6plcyPJUkIhK+pZCgmVFw0GQ92L7Xh3vvw9AKddrRirfGMNySN4F6IwB+iu?=
 =?us-ascii?Q?xB9rlphHQmNNaen0WuCvVoog8nOLTCBEbKZKFyHnWxbdO6HQnkudNC3x8BLu?=
 =?us-ascii?Q?xqSdk/wCKuRBgBKkk6GxGsPFyVBJifpFTi+2Ewsdwm5SGjKdl/mr1VL8GcAx?=
 =?us-ascii?Q?tIYb/QGR41BTvgkKNUK6nMU5UYZn+ASJ+dt9trCAGWfnHAZhyHUF+1Ewc0rX?=
 =?us-ascii?Q?JGxgFcfN6Y15AT61L/M/j0VftjcX+lrG/Qa1xhS67qCM5xmZreq5gxhM2CGJ?=
 =?us-ascii?Q?GrEw/yibdjwUuyej94hzufDHrZvFHQIyAcy9lseFgZINh0aq+fQP/THrSVSX?=
 =?us-ascii?Q?0p3k73SnKYWANU3xGMf6z5v50YEU63czzSfsgVoc/rSx3+1qgJPNE75WBfWi?=
 =?us-ascii?Q?IfSj2lziFbHxLevXt9HS9/JaarSpTplno0BlEM7BiFTKe7i/HI1ZyLifu4D7?=
 =?us-ascii?Q?w0L6ld/3HrNfJZeZeVUKB8BBaxVxJhCLbSyWsv6ULUJnNI8t4319UPrBGi2v?=
 =?us-ascii?Q?8hjf9MSSQpV75rDbm8LlMQRAUx8w2YwgW4SwbVeGgjrP6UZC97gWSHi9PpMI?=
 =?us-ascii?Q?4YXKZ7qDFodf1bs6AP8rJmkCVRDl+aBjhm4SonCSGvF1Qk0U7pGiBREpsqx4?=
 =?us-ascii?Q?y3ym8796EDyS5GUC+HCrkVtwfB8/l3YsZSkLNpArjdZpKnvclOTmdfDm5PNx?=
 =?us-ascii?Q?mEVT/WppvQVz6fpCv6C83EJVpqVD/5B6vh4M6hm58injwRiLL4mW9kSJymVh?=
 =?us-ascii?Q?z4CT2ZsqaHga/ZBDvnsFhXQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea03a389-f7fa-4006-8b1f-08dbc325a7b5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:57:49.9941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlKpywoE/IGbBjCJ6ra52whMTcr2+9nh9WrcCpf/r8hiC6abK78t4DbTJAnbmjYQZNbGg214mDekCftJbWQTbye2AooUTxpGGr7qo8gwGgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8273
Received-SPF: pass client-ip=2a01:111:f400:fe16::713;
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

In parallels_check_leak() we change file size but don't correct data_end
field of BDRVParallelsState structure. Fix it.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels.c b/block/parallels.c
index 3c69afa04b..e8d6d30fa5 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -803,6 +803,7 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                 res->check_errors++;
                 return ret;
             }
+            s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
             if (explicit) {
                 res->leaks_fixed += count;
             }
-- 
2.34.1


