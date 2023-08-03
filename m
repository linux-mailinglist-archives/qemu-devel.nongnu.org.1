Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9E476DEAA
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 05:01:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qROZg-0000Ac-Hm; Wed, 02 Aug 2023 23:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Evanzhang@archeros.com>)
 id 1qROZc-00009N-IP; Wed, 02 Aug 2023 23:00:24 -0400
Received: from [2406:e500:4440:2::611]
 (helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Evanzhang@archeros.com>)
 id 1qROZZ-0003gA-FW; Wed, 02 Aug 2023 23:00:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQqkVeCi4SmQdNaaEiotR/cHoqcdgkTd3RBhaYQYXYCYTuojdXa6AvQ5UWu/BIgj+HvgjPTEeQcV3OksdaBCoAo/bwutHbWjJwDqO5i9+lLASw821qq4GLTKYCHu1AS9JrUt+heRDkqfhhqydyatl7UMVXgvy9Js91rI7adjZGUK/13IHUqaCKZ592IUElsQK/gH7vLt0Hc6owXdnEQqQzYASQpbNQJoWod5qUSsiZzu0gsM2C4oH9jOpl3c5o1GjhA8PlJSURqyPw6SyLPyiQr0i3/ci7/Lr/KpXOSX73WkCg5ldu7zPC+WlF3/9cmEf752YMsi+Sw3CmbbGPEB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D79GUabz+sLsE8HmP/kyqeLBAq8ufktvwM1tTYhIhSU=;
 b=A8U5MuWx6FBEwtLqnPVk4MhATYoMU2xOu3Na3VeumCfq3JOI/GsalBeCwEIMN3KS+UiMxBvr8R+A/fo8EY8Yh5JBnccBz/yEHE5PRPCZ0XqXFTz82J/IAwLY4q4jpUgItKyEkKi0jMFqpZc/8ywK4I7guhtITWoqBhWGhM//xvOVcRlKcH4vIDqIW8Pv9UZ+4+74Ds3Dv6rdAoc1YtsxHxCKWKPiJsBQ4TJBUPd0Dh+Hpv+XH6idNvBOvPEHnj9ryEt/r/kkZo5ZJhYcG+YirnC6IEPJidEXgmcIg5IKOdHskLIyvc3qaZ30XuYddhjNQTzEIia/8ddbrxvnPbiwVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=archeros.com; dmarc=pass action=none header.from=archeros.com;
 dkim=pass header.d=archeros.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=archeros.com;
Received: from ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::13) by ZQ0PR01MB1077.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Thu, 3 Aug
 2023 02:44:20 +0000
Received: from ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
 ([fe80::2fe3:37d2:6bba:87f1]) by
 ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn ([fe80::2fe3:37d2:6bba:87f1%5])
 with mapi id 15.20.6631.043; Thu, 3 Aug 2023 02:44:20 +0000
From: Evanzhang <Evanzhang@archeros.com>
To: vsementsov@yandex-team.ru
Cc: Evanzhang@archeros.com, den@openvz.org, hreitz@redhat.com,
 jsnow@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, vsementsov@virtuozzo.com
Subject: Re: [PATCH v4] block-jobs: flush target at the end of .run()
Date: Thu,  3 Aug 2023 10:43:46 +0800
Message-Id: <20230803024346.1446-1-Evanzhang@archeros.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20230725174008.1147467-1-vsementsov@yandex-team.ru>
References: <20230725174008.1147467-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BJSPR01CA0012.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::24) To ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1015:EE_|ZQ0PR01MB1077:EE_
X-MS-Office365-Filtering-Correlation-Id: fd322d73-1d97-438b-3803-08db93cb8a0f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DuBrzscdTP7GfXWAkrlVTAWR5EOvvSMDUt2fWl1JhUO2u2drf9JoBjDSgUAoviHSJN0dNz549i6oQKLO+7uaohAaCG6Ypk0eb7bF/sqXFq8FTcHVjy8EMs1qPJZodgE4W/Y84rBiKyjbtyfvSsaLf42VvYbQQdAcBocC0zCf9NeNyhGRzhUw84xGBrqGKQEgR1KiF/Vax3/8i3FW/e9mERhAbXzuXmxI8FgpvpvLxeTBQu4Z2tDvxShS9PM2T2EAO+6hP9J6cpEFrppcGB/1RTFMfoZeFejswQFbCnexh6kbi6dv/3FiJO6PuTPJOG1V/jf9wmaMJ6rUWBDixYNeTNorfmM7ddWQ4lq29oOQhT9YXjT7jM1tTzlRt0LGvwLGyiHZIGu3gbYL+e8kVTF9mTS/IXLP5sBhNy0L2fToaqkv8WoT2wrCGWCaFkKOed/RFioyx8B1YGLfmjM++AuqfcSpDbcfAiRWJ1VPIsEiWHWSqqJv6zyDsU4OWqnDJ5OMxxkzXnuTWZwEIf/W1la7j9052weh9ndSEKr9pBsw2Q1pRv+/hj4aJ+8YpgDbCFOyOAFNec/qTlSKSbByNQuI9sdESh+V5SQLGCawSqAhOO5v3YP+d8CvB/IasLQUSt5nFvlIFoV1awJ4CI4x7r7qUSdiyZ9XM8c4rfg9AfqsVex7lGI2tGWiN/WQWlYFN5un
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230028)(396003)(136003)(346002)(366004)(39830400003)(451199021)(36756003)(41320700001)(86362001)(40180700001)(2906002)(40160700002)(83380400001)(186003)(26005)(1076003)(38350700002)(6666004)(508600001)(38100700002)(52116002)(6916009)(66946007)(66556008)(8676002)(2616005)(4326008)(66476007)(41300700001)(5660300002)(8936002)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Up6ACE8YSATNTSaS0cZA+MiDsU8Y5oqNYIm9sVtNHyltxJNOtknp57xNAJg+?=
 =?us-ascii?Q?vj0ibnmZihZFi6nuO67f9VoA7RflE6dvrUc65oaCWqiAnF5gxqk/yZXdLZJw?=
 =?us-ascii?Q?MRghec/BClAMjDQE3gR2/kO9jEhPvA1KgeI/ImHN0yeZtN0n51znBNS/ckK8?=
 =?us-ascii?Q?+oNWi3KtWkoqTxN0KbncZVxQokUJoYzP7MkPp2BNL1l/xJ9UCDZqrAbYIqaw?=
 =?us-ascii?Q?jiyIegnelHb+asJdIpr2KdN+AxekZlpWzM0uLVQtILj3L7aDUaibjn1Laq25?=
 =?us-ascii?Q?cDvGZAGpkefomUoXhGzsiGh5SCwZvV51kxGqtDc8WDLoKVGfoLmQhlm6jMhc?=
 =?us-ascii?Q?Yy739ymRiNHFPvBsIC1S/jfjD21McrlAyRv4K9qjJtJTMOkHPrDmiot7pN0S?=
 =?us-ascii?Q?bkQSoqKvjZgjEi47Qj7VslUXConny4vdlQLbYpVIw6OgEz1R3ni5FTv7tVKz?=
 =?us-ascii?Q?dkiCOnS0I6LTIzhcsZSXTASIUY++6tOV5QA+TB1Crk7tLqGkU/PlP8baMOvO?=
 =?us-ascii?Q?iNcAEmcS/YEGYYZEw5QdmghJjBtUEIo8HA7xaqlPPhLn4kCB7FSC6Rq10qnL?=
 =?us-ascii?Q?tz6BZnwKG0TOhCp7G1Mm2MFup4EpVkLiZ8QlyPx587QPyHGM24CBTsdrinnA?=
 =?us-ascii?Q?iSxz4+90oqbh4UI0GCIkMiXCgBET15tQg6sMfNJjpQFc93RAE1RpV8ShjuPY?=
 =?us-ascii?Q?hVJKhYXkF01XPwXfrOjePYC8fLBdr+aIL1NzhyqaTKMRgDzJgb5K5l4W5fyc?=
 =?us-ascii?Q?ZboS03hZdbZGMbYL13+dpa81iLYxy5mkGwEhbE631m9oiN0VfCp4+bY2IRRz?=
 =?us-ascii?Q?yVqQvyLmuUE5a18+5rwyufOhGfFU8UeKy75pn/tbIBe1CxG8lBL17Ypq3tdX?=
 =?us-ascii?Q?b0HhNnVeTVK1JPd789wSlC3/yjCBV5/DN8cCDRTSBZo+qAtw8iUr7NWNNrcy?=
 =?us-ascii?Q?byi1wfXGr11rkHLEP92jvAry/QahnUdO8BC0r5NyAa90RtwGRwQQT3nLvcgP?=
 =?us-ascii?Q?V04b2r8hv7vzKeCBbHw6VteZYEFGAhmBOlybY2GZX59WPd4lJ0P6kxD6VWvy?=
 =?us-ascii?Q?Tgvi4jBA1XE+qygQmEQP9LFMp7gKr8RyCei2qpK6U5kUPgbg2ZF60A2Uyo8j?=
 =?us-ascii?Q?iu3dZOL3fZkmxBjOvfZCOOUVTq8fMX4I1sV9ZKlkJuPa2UBZyA1ct+Dhze6p?=
 =?us-ascii?Q?lr+ZmpxJn2JL2/RRlazp7AsuNgX9J8YfwhMvL/KHolPXNMaY+aaMQQfOIrIt?=
 =?us-ascii?Q?AYL28FZBHYh5LFIwnBXWg7FcosGnAV3M9Nt3ZeR8XMj52CR7y4rDnZxVtxiw?=
 =?us-ascii?Q?xZraO9yROje8eq8pIr6xIsJ/ZBI52CnAvIsJBnmQvV2YOgnG5az4A4Lam2v4?=
 =?us-ascii?Q?t4UvDXm0fRX2sVR6/xAy1r/0Hj+uhXXTgGFbxklb8Qj0DFHDSkay8uS/iMAt?=
 =?us-ascii?Q?732DlQobQAZuzWNIhCInIjwY5mReiMFkQdNhZGDzsX9OPV2c1ks715Blv0LD?=
 =?us-ascii?Q?FOmqJBBmMLxcSr8vucNkFFtAE61xVN17p/YIyqzvUMhrxa4FQqcqnkwcxC1p?=
 =?us-ascii?Q?ynMWOEgVf9Hj5HKwq1EOi/GvyT9x289S/eH/yEgR1Bl2Nq8C8NlQQ0iqyiLM?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: archeros.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd322d73-1d97-438b-3803-08db93cb8a0f
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 02:44:20.8639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8387253c-f44a-4a28-8058-3e5c20af6b4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tF/dMK54FD2qEo6AZF/S4TnRJEFxmaZOEfeXz4czr7ECjujGZCm2v43+xQwsJc4DW0sCa///dT1f214LYmwuWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1077
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2406:e500:4440:2::611
 (failed)
Received-SPF: pass client-ip=2406:e500:4440:2::611;
 envelope-from=Evanzhang@archeros.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, PDS_HP_HELO_NORDNS=0.001,
 RCVD_IN_SBL_CSS=3.335, RDNS_NONE=0.793, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

[...]

>diff --git a/block/mirror.c b/block/mirror.c
>index d3cacd1708..cd19b49f7f 100644
>--- a/block/mirror.c
>+++ b/block/mirror.c
>@@ -1143,6 +1143,10 @@ immediate_exit:
>     g_free(s->in_flight_bitmap);
>     bdrv_dirty_iter_free(s->dbi);
> 
>+    if (ret >= 0) {
>+        ret = block_job_final_target_flush(&s->common, blk_bs(s->target));
>+    }
>+
>     if (need_drain) {
>         s->in_drain = true;
>         bdrv_drained_begin(bs);

hi,I use gdb tested drive-mirror，break block_job_final_target_flush,
mirror_run  was not called it.
qmp command:
{"execute": "drive-mirror","arguments": {"device": "drive-virtio1","target": 
"./data1.test","sync": "full"}}

[...]

>--- a/include/block/blockjob_int.h
>+++ b/include/block/blockjob_int.h
>@@ -152,4 +152,15 @@ void block_job_ratelimit_sleep(BlockJob *job);
> BlockErrorAction block_job_error_action(BlockJob *job, BlockdevOnError on_err,
>                                         int is_read, int error);
> 
>+/**
>+ * block_job_final_target_flush:
>+ * @job: The job to signal an error for if flush failed.
>+ * @target_bs: The bs to flush.
>+ *
>+ * The function is intended to be called at the end of .run() for any data
>+ * copying job.
>+ */
>+int coroutine_fn
>+block_job_final_target_flush(BlockJob *job, BlockDriverState *target_bs);
>+
> #endif
>-- 
>2.34.1

