Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D83E828340
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 10:33:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN8Sh-0006I7-IU; Tue, 09 Jan 2024 04:31:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rN8SW-0006Gb-RD; Tue, 09 Jan 2024 04:31:44 -0500
Received: from mail-db5eur02on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2608::700]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rN8SU-0007y5-Fn; Tue, 09 Jan 2024 04:31:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmI1aD54H8cE8LDT8M6F3mxFe5Sj8kh1KjSXaXl8TvQdC8XON6RijEtM20JyoW4v1On2y3difoJrLfulUkADjee9hxcYKYlh7VikycoepgVu8+S1qS2eHXWZ+fxnZzcP2rtlXANYYN2qVejPu6k33zP5Hm6oe+kZQvnUkjvNTTgs9bOx2ScmMpnMJ+fga4hT/8cW5dBd3py2rOSo/jLdwJh+0sGGrH5o5dpQbJl/M6p6IzyjDFAl30X3QL1wZc5IjzZcooBCaVHkKH6+EYri0ApOaD74NevYVayvVRDeSKKxGKjEKUBfP+RGAP8Jgm9y1B6q5pVS9rl4L61fBW2LDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obkVePTiX8FFUMnEArE4mw+VNWyzIgeCYV8NaPVVM3A=;
 b=G7kj3XLbe/J94UIT7Ex6yG+MfKzz6j8u8kSHivHnAL0Jao+bqIi3++/J/M3FUPIq3CkQHlbQMoxesG65rYwWv4q/uQMf42cpODMMPGX/Idm8CWq0OtILxGi8wk9Pt7Erxj+ofT7w2Y8ZTlBmmaBFNeIQdFSWAR2RvDMK8QnJDW8pPRhoSGfUf2hTS+uQUPh3JW5IWQHrsSQT/+LvZBKzqlkN+9KobCK2029Mf2NlXHOjW+YMsPhBwlzKGVHfmqicoPsaMrfC8MGPAmvEIeRQhtAvdu6GCTSUkMHtmMSBGSZYYDWi8qyDVwovuxJ0m2FBrH7TWwiHzTPfM22y8EIvmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obkVePTiX8FFUMnEArE4mw+VNWyzIgeCYV8NaPVVM3A=;
 b=uDIfDw/ox895LE5xzJqv0Ci1EET+Fe036aHXW0Em1uZwt/dV44qMxJO39bgKI3PcDiKL86fXwcMlyhK3QOGIcbU/Prwq0pZ/uMiH1vhqfzwztEWCtcH/Ejqd97eGGLbcOssLxngPfg4YbXsse1fst/38LE6m+lYdoE//taWRJsYUGbXKR5INnO1IgX0eu8ffVby1+adkJ5h9aGRAM5uA71pOkN2b5q9u25DMSk6W+ogWFLtU1GNJUTDcx1W8dGH7QqdLgmT0cy/1Rh1x3Ct03Jwze1QQ/Lq3QmX6F1X6m/Tc0Cvv8+Fjk88HOFEX159G8/rCTZ+NBOmh7rpCF2QfNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PAVPR08MB9283.eurprd08.prod.outlook.com
 (2603:10a6:102:304::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 09:31:36 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 09:31:36 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 jsnow@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
Subject: [PATCH v2] blockcommit: Reopen base image as RO after abort
Date: Tue,  9 Jan 2024 10:31:28 +0100
Message-Id: <20240109093128.157460-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PAVPR08MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a0ad26-4820-4e32-4795-08dc10f5c654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLxmv1Wxs68FxUBgucAd3ZPjzqCryA+GNBQP5cu8M0CaPVtUtNzqAZKR7hPgjZjwSgh4Yop0SXXL3jFvCN6gHOXXJYYZjcmZQ61uspOU16Kd9ZpDSbFtHJLrzuSu1ITlWUxH5j6qfBQ3rMiWfkXUpB9Fs7hmsf/UiFkTTTtGQpfbLREc4HP/Z771dH8MMzS96pZ8j2uVSHKE6TB1X4R8wLuoQZA5ggIZSSGhr3w1Fyvy3yGfSjf6NAD5mXK+wKwx+V36di7MzkA2cVbpcOcC/rN7zwA18gjSJgo0g1guG2ahIXcRqg1wnp4uvJHEtYT1zCQOJF2oabEtBHQybJ6DzuRfq7yAHSySmTjLrlTXbAabIKGfCVmo/EpzG2jRcNDZ5dAnQdH+MqSQpKlojYKZpa3XC24GKg9eJTwe9XDkeNLVX+QmQC7D11x3VNKDcvVOgCYc4qAMtWA+j1F1kg0mF7bcxTx4tRKOHJCr+53r7oNVwee2x1TVnN67PqwIp93ky7riaDpCb+D34wAE3S5zUA6zTjudJwiHSJzxz9SS9X4MSFLG0toB02z42jxUFgzE9KTcHP+I/da2z5IWYHVZUIOo7SLiqtdg5RXkEEoVBfUhN9GaT6rYiI3LEGIw2GIr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(136003)(39850400004)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(6486002)(2616005)(52116002)(1076003)(478600001)(26005)(6666004)(6512007)(66476007)(66946007)(83380400001)(41300700001)(2906002)(6916009)(4326008)(316002)(44832011)(5660300002)(66556008)(8936002)(8676002)(38100700002)(86362001)(36756003)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y5+onOqfRA+pCxmos0KPpslA0s7LhFp7vtyLbjhuFSjBioClSCXr7ejSdrn1?=
 =?us-ascii?Q?AOp3k1052Xim02T+9Fws3N5K07ydZOks24iU9sOkwIy7mbqqzOR2K9lA7/Qa?=
 =?us-ascii?Q?J58p9RMhjkTEdepzdTHlho5V0sJeqm/NVvJ1fwUq4VDY3MVapWie3AuP8ncC?=
 =?us-ascii?Q?lBOGvqTsWhBLIlEX+iaDcy8afXSHHXeHZLJvKAfF/42XzdITEi3WCLG4+YtS?=
 =?us-ascii?Q?FIvlMAOrI3HYSTVoCQ2tzz/sj81RRQXe9ch8nkkGSEoc+kGAWePlw/HdQS0n?=
 =?us-ascii?Q?X+3gjxvyKRmck07mTOR+P5Os1wE8IIRW3epSoxYQjPlXCXHKsi4I20gSIpi8?=
 =?us-ascii?Q?CmRxpcRMUa0QfW70tpvNKtURURy19G389xPt4XPcN7UO/ALv9zhEbgmBKZ5M?=
 =?us-ascii?Q?scmz9/6ehMH/lkIJqSD9B99uBCttqCByDlXOo1aEWXnyY3u5fVLPxCxpetsA?=
 =?us-ascii?Q?eCKpuW/ER5pIpQKYqTqDFIDwy7VTmJz5r3d/hYWje/LooE63qXP7Htjv7Sof?=
 =?us-ascii?Q?uGAIO2pXfrldvhneAQoGNNRQbpbVianzlYAwDXVOyhkQDBEfz8wg/GnYc/Z+?=
 =?us-ascii?Q?tiPmQt8DsuGeoPypbHlZUjsm9zJt/QD5TMyJS0Ur3b/3+c6EmsSTmHgJ6Ref?=
 =?us-ascii?Q?wUSbHW+Ca3YeuZWmExEsMbGi+0LV38QVe6ZQ0ivoKLFKNzNJpD/gH/gOXKPg?=
 =?us-ascii?Q?Q0mdGSgbWmSWbiv0Rf8c0CITUYh9OVej9hjqCZO1ilvcFVfC020Vq8pj6M/T?=
 =?us-ascii?Q?cGlCo5IoRpB1jsbEkm+gNoCoBtt8cgt8mwt7RkPGv7EoXCKe2Kvg8yg4ktrx?=
 =?us-ascii?Q?ntL3cj//EmOS3YoWYl1VkJJfYIiYoKh7z1/v7+c3iyRnwp0WRI/fO2yBN8UY?=
 =?us-ascii?Q?oXb45x8e6IRTzRfJIESC2jtTZgBllDZCE7OSKj0FE8lozXsYhRYQM0/mAUTZ?=
 =?us-ascii?Q?G5oyAbO5RxfKzx2FbWPjYBYsmLPnGZzlHVDlArwACdt8MS+x6L216/zdmjOt?=
 =?us-ascii?Q?aDcY0aLch6v1/IsafZifWyv99qL99UYcZpeSsFj+dqpGeaVe8/1ML7T2EXsX?=
 =?us-ascii?Q?vhR8aPBEPRsQ/idrrON8Vkl8TiPabMpvva8FLJfKOfynkCb4Gbe5cvR+1EDU?=
 =?us-ascii?Q?PMrL0AX8ypyJv38gGJRVsIDiJFYFDVBnyUh67pHu2nO+nuV6+FOXpagyvKBR?=
 =?us-ascii?Q?4/iSbjnSmRbwqh1Cs+RhEuwaC2am2v/NKUsZJWoOr3H9AB9F+3tO9l2Eerip?=
 =?us-ascii?Q?O6vKQz2JHL3nJwaoAMlbRWmHLu0mgVP+lIr6E4hnyWCnk3U/rtxCLX0jT9ci?=
 =?us-ascii?Q?0acKH2tAec0LH/E0krBWmGEA5h4G7GnL/oPgciuhsz++sYW1nHzI9cd4Z3KT?=
 =?us-ascii?Q?FEnsuhNNWBhI6cH7XjFG/xnjm8uGZ/qfTuWzA5PEZGL014hMCUJnqnn59OSe?=
 =?us-ascii?Q?hxkP4HGgHwfoxuCoeffPBYQX1oyP7lGqxZtPnwMr++et4AM2wpBi7NdNsilq?=
 =?us-ascii?Q?wtypbHZ9eqWX1cq3C+q4tYCMlw9X8W1PsBVybYVQuBx+y+gwuOw7EQ1xkqfx?=
 =?us-ascii?Q?1JwjMuRsF46wxhKBiJqudLwINmc/ibNOfuRYGLPA/sHQtE/mTLMfkBYKtj5V?=
 =?us-ascii?Q?0E5otPvc4OAIFsm+s9JapKk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a0ad26-4820-4e32-4795-08dc10f5c654
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 09:31:36.1873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRSccm5VDUt3uRqKv5yZC3YK/Km+mbBt5otFGMrquxAbwTdwvoyVyxgQjmYcJ2blh5BVye/vwXj4mqyqyfiW65pbj/oNRtbKU/JSfhNumoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9283
Received-SPF: pass client-ip=2a01:111:f403:2608::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If a blockcommit is aborted the base image remains in RW mode, that leads
to a fail of subsequent live migration.

How to reproduce:
  $ virsh snapshot-create-as vm snp1 --disk-only

  *** write something to the disk inside the guest ***

  $ virsh blockcommit vm vda --active --shallow && virsh blockjob vm vda --abort
  $ lsof /vzt/vm.qcow2
  COMMAND      PID USER   FD   TYPE DEVICE   SIZE/OFF NODE NAME
  qemu-syst 433203 root   45u   REG  253,0 1724776448  133 /vzt/vm.qcow2
  $ cat /proc/433203/fdinfo/45
  pos:    0
  flags:  02140002 <==== The last 2 means RW mode

Reopen the base image in RO mode in mirror_exit_common() if the blockjob
is aborted and the base image was opened in RO mode before the blockcommit.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/mirror.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 5145eb53e1..9a5f5cbb4d 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -93,6 +93,7 @@ typedef struct MirrorBlockJob {
     int64_t active_write_bytes_in_flight;
     bool prepared;
     bool in_drain;
+    bool base_ro;
 } MirrorBlockJob;
 
 typedef struct MirrorBDSOpaque {
@@ -793,6 +794,10 @@ static int mirror_exit_common(Job *job)
     bdrv_drained_end(target_bs);
     bdrv_unref(target_bs);
 
+    if (abort && s->base_ro && !bdrv_is_read_only(target_bs)) {
+        bdrv_reopen_set_read_only(target_bs, true, NULL);
+    }
+
     bs_opaque->job = NULL;
 
     bdrv_drained_end(src);
@@ -1715,6 +1720,7 @@ static BlockJob *mirror_start_job(
                              bool is_none_mode, BlockDriverState *base,
                              bool auto_complete, const char *filter_node_name,
                              bool is_mirror, MirrorCopyMode copy_mode,
+                             bool base_ro,
                              Error **errp)
 {
     MirrorBlockJob *s;
@@ -1798,6 +1804,7 @@ static BlockJob *mirror_start_job(
     bdrv_unref(mirror_top_bs);
 
     s->mirror_top_bs = mirror_top_bs;
+    s->base_ro = base_ro;
 
     /* No resize for the target either; while the mirror is still running, a
      * consistent read isn't necessarily possible. We could possibly allow
@@ -2027,7 +2034,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                      speed, granularity, buf_size, backing_mode, zero_target,
                      on_source_error, on_target_error, unmap, NULL, NULL,
                      &mirror_job_driver, is_none_mode, base, false,
-                     filter_node_name, true, copy_mode, errp);
+                     filter_node_name, true, copy_mode, false, errp);
 }
 
 BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
@@ -2056,7 +2063,7 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
                      on_error, on_error, true, cb, opaque,
                      &commit_active_job_driver, false, base, auto_complete,
                      filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
-                     errp);
+                     base_read_only, errp);
     if (!job) {
         goto error_restore_flags;
     }
-- 
2.40.1


