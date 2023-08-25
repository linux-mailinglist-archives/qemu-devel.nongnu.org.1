Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E065F787DC3
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 04:35:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZMfH-0003Mz-1z; Thu, 24 Aug 2023 22:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qZMfE-0003GD-CF
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 22:35:08 -0400
Received: from mail-dm6nam12olkn2014.outbound.protection.outlook.com
 ([40.92.22.14] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qZMfA-0001oI-H1
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 22:35:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixeW3G97R9PhziBALfS1/6fF1wZVidi7Il3CiX1gVSAC/B5iQWjItx/ztC5yHNIfZYewCaVHcvhws6lXyu/jaxjkuBVwmc/HqfM56Dry5iHgFoDje3U2rHor5R6X4mKvYU7/hxFD4HDdFBg4kHZBoIK2njawkK/czAWEaLZKzYMnIMRblzvpXGkH+/I4BkK0xi4SUl9iMQr+WbHPSMdS2vdb3lyUj4+6VG57DyV/mOPw9OANcgRVrDeqUiUKsMLdEcIcDswSm6WdXrJrugYmmYn1KUzO+i066nV2P/pScQ9+UoV37DaS5Qv9AgZ01mAd8ipaw5abRb90r4Ne/LMqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhE6ydlORfb2UZJkiln73TNI06VfIG20tGkbYWxQyl0=;
 b=IMiIbTsT75GIGDVbvj97iCdOFJ4xgTN6tKiY5Czd8+jDo37wdyZFrGCWcmHt4y3B/dZvzlSF0bc1hDrdRqQjZRHJ3JPCQmljqJXy4Ir3hb0Pd+Jcpc68CJ3V07mzYrgDhgoxZlLsmhkLDdFYcU3ZawmH+9t8Q4baywbiQjJeOf9d7uMsrtGqZkXySBKJNHkVjjytDcOv3pA9HjheSQOTVjvRd8AWgZEW272r7CTKWN+0lxAdi9FfUv5+7KcSqu5lX0Avt3p2IJy4jb9tgZxr6Ut4u56kfTS6uVQZtsgcRHg7BNDyyVggTN61eCBJwKtGQ9PgreFAeW7HPx8PdFLGcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhE6ydlORfb2UZJkiln73TNI06VfIG20tGkbYWxQyl0=;
 b=nAYn6aa4taek1+6CGhT4SuGJi8fMhbTeNKrfVFp4EQ4cavillyGPCkPpTkeRU28m8arOreHx66VVUzVOkLMoTW6pSEj8Ladm0Dzv9wJ/PGAtFtXCzojwERqugiAfTKX4ELQ3DRhysoSm2CoszP+kcCFlJU3xNuOOSykm4/QWFeCrF02l27RwxqhMBMYvoia1uDVeqEDUgxqaO06SJvHCzrNqX5u6MrctYL4phIQRw6u/IfmIUQ/SO04BJhXIGdssY7UMiPPD+YUTMTv2vk/5HE9AImY3TO1gNa6cWBZ+idryjUCl8TTcGLAsR9+hKioB0WStKkTip9+mqTWz2R3AAw==
Received: from SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14)
 by SJ2PR11MB8449.namprd11.prod.outlook.com (2603:10b6:a03:56f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 02:29:57 +0000
Received: from SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::df85:2db:d56b:38bf]) by SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::df85:2db:d56b:38bf%5]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 02:29:57 +0000
From: alloc.young@outlook.com
To: yong.huang@smartx.com
Cc: mjt@tls.msk.ru,
	qemu-devel@nongnu.org,
	alloc <alloc.young@outlook.com>
Subject: [PATCH v2 0/2] softmmu/dirtylimit: Fix memory leak issue
Date: Fri, 25 Aug 2023 10:29:33 +0800
Message-ID: <SA1PR11MB67609A76D397056973B406B1F5E3A@SA1PR11MB6760.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [sU5pLsvnH4gkw+LdvEZTPoOfF3H1T4/AcD3qh2FHNpU=]
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To SA1PR11MB6760.namprd11.prod.outlook.com
 (2603:10b6:806:25f::14)
X-Microsoft-Original-Message-ID: <20230825022933.1081999-1-alloc.young@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6760:EE_|SJ2PR11MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a2b402-9189-4725-4b68-08dba5132c6c
X-MS-Exchange-SLBlob-MailProps: gMiuAN0LASLasUZbrOQ/jdDqZDmVQGhzc24/MBl/vcz8gZO0QRovOTcvTBUSxXS6LMmihOXmATpWkCEomRCF/qBCk+ZdE2w1fy2N+sx+O66Tds/7n6dR7slFbq0u/IRpHOdAcso7B7GvTRoqxv9/iUHA1h+5EMMxxYr4QJho/zg1KJC/ONFHA6Sh93s1S1yqOI8dJfmb88F6DmEQt2TN2ioVNRISYfIobWt8Pur6lXnBJrgdK4YBOTsYq3/8Zs6mDK1+vO9Og1qXkZqGPwRRi9d4tZ0RAMUwzM5dZ367NAXQvKiLsGWipoOQV4tGrH/GUWHn6QE4MXQNHcY1OK9pR0IWNWcyFgRYT6My3tgIH4AM9+n3bIfypJSuZPgqDLmcGEEX+x41mxQC5zKHeKg4MyWN4cQEuapodTFFhJqZQl1gCJ9fckDh3FcYX7+eEiOujoDHstqx+hu+KRC2Xt8uRDbedO0rlThrsCJsBJ5TdFD+h0mh0sAK9Xz0HlsAVAO50QRo90UJx4D6iqJpgsQ9zcPPd1/gVq4CTqevwqjiAt6KnUTRyzP6wgfiyTw2hwW8K334HrPGytNtNm56wqIgNqRYqSDz5X0G+wMj8AYxfFE/pzIciIf6ywc7gxPvESLvTkL4GgPDqePbrdPYNH2RiXPswyBXN5+/k3aofzX2ByKGi+8WG2J8FQ0pw17fNcrIACHTqIzeGrsMewr0BqsdyQ==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2h4EbzDNRBj47kGujidcMDFO9HtZ5YQOFOUv79PKNiJxbascCljgGByLbqEb1/7SjQ3vHRqIkZrQ/lQmkNXowQK3YXpyADDCMr1HvLdGDnS5+NJeyGfORWL1Y99DLOPu5DvlHht5f5p0HBkqFldlB6WDAeWjYBBKtEWl8FHt7nJOu7fDVpUv/US0YisJrkbEutlfr/4o/2MzVVBJKajktmT9OYQoZBzkFq3uXCvv/C+ULV7AQvDqvMgBxbxgYXub4nknTOF8nHn9aIt1WNtFjVt5DJkFUzDS0m69GDRIoDsUW3xmkXPzcyJkfjVy0gyCHGZJXZ1+RB6uIhbnF7fNZdt8+gdZuAJhrltVGmQTwFnXXC5wt3oZ8tEZ75gENo6HiEb2JLx1iovNKElrwKSGfIJ5O+oGMMUx80iDqtZFywERQX+TXJaoZ8a+wgpcVYUmsGdUKK1jYwqI/PexlvCgSM6gqc+72Bd10q+PP2mXXyFsfgnn6YBU8wjOnVWFBIcv1yQq0Jpu1HDNDQivXVoD1JNoEag060Rr04eU9RS2XBr06v2xJxLFedaGwOdzPjR/KJpJ+lPbMY57zEEleZFP2zo1/LInDV55Fs2g+x1FpOFO9T/g70+E2ngpp3/WYkTi
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uotTO4/qtSJzRvyRdpLvA3w1d2iA34XrpWc5r/mJ7DtPIaqhc4yzJJi0txP8?=
 =?us-ascii?Q?ob/Rz7z3zteF1FmtlsAC+htikCGWsb2tQOd+oPCvxB6cs3U39WA2geOEFFau?=
 =?us-ascii?Q?h+4uB0k7/6Akw7ufAfc14B+UxPX4lbYQiHYeGfaFMAiEU560uGyWLvchndHa?=
 =?us-ascii?Q?mKeomkXtFQdGWGK1ffb+vlCtm617SSt0xTDc8G+vDZCYWi7Iwwtk/oWvi9C7?=
 =?us-ascii?Q?mnBUoyzCs/AJo0Lx+EGzT8nVdZZS+Q17eKxUVEveuErUIldYKnXgxSL4oq/G?=
 =?us-ascii?Q?d+Vr3XiREA+R+BGDOpj8GK3iM0vocyJVg4luczofZ0b9GXkiQocaHWB/LZHW?=
 =?us-ascii?Q?/ks3ICewHe8Ot6rcT4xX/57NWi7YiZlXJdNY/AJPzm1M9jxT9CxJHwYgCDqX?=
 =?us-ascii?Q?Q7zK+Vod9Wi6uvsFRpyocCLYLEfTKYdRuBpPALpu/AuqYX/IceHDXTGkSOAT?=
 =?us-ascii?Q?+EywxkLx2GWM/IUyVL7PlbcaPZbAK5+mPOuTAH5sUT/iGCWxAyCUrD67hCRo?=
 =?us-ascii?Q?XkADf62ADjBeSl8+a8vdBpVkiySLsyoDwd/IBHeoUxF2IvbPQRPwTPPV+B3s?=
 =?us-ascii?Q?fOl/w9/r9/PWI7ybx+6e6wdTydsb/QLtLZgLk8gkrds2wnFv2CxAZk+/CIjb?=
 =?us-ascii?Q?QNPesHuycC+M70YitR+Ynv222HG35Z/+WEX3fOYLnBsVceadJ2j4qnaUfhD8?=
 =?us-ascii?Q?SP6LhA9HciU8rF5mx82/QOSzagBWWtkBX9Mw3QPvTfEu7PXLJ5Pl2wvjJvqo?=
 =?us-ascii?Q?rfHFf0feeVLN4b2g+xckWfEjeyo5AKC7GFsYmbIEJiw85Xbr3p2aXb5qQZpa?=
 =?us-ascii?Q?64QBqw+9de4XxpmC5uBNs7ZFgDpMPJNScVJIhVrRUyqesCa/MLNmDr9+0zLJ?=
 =?us-ascii?Q?zRWnNVjQopQTbfLy3a89prp9G2EzldHzoUh3k69pi231Eqeg1FpHinfOoLgR?=
 =?us-ascii?Q?ttHfd+4pbI4tAUdESvZKBTGCtUOY2sP7W6k31Zn0rxK+m1iQvlz3Krw3wbzu?=
 =?us-ascii?Q?GX4BZ7Nk+IKmUMB+/V5HHIU75cxw+/aMlPj++JfwqjtvuuRVme/zy5SMFc4F?=
 =?us-ascii?Q?4+gToxtdakVpecRBbakUJ/WyPYxcEnjHLoWTUTorXqQRvjbO5p9TrQshIi0Q?=
 =?us-ascii?Q?nvqUf4i7XLf4bVWPi5RA/gKDdYATIOwjmnOaVRtImxyRTO+DlIEy56rOkvd9?=
 =?us-ascii?Q?X1YlVKDQw08Tt+Wvnl4aQBnNvRoY8YJg9TV3uXhTbE7bseuO6opbkAPB/Ac?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a2b402-9189-4725-4b68-08dba5132c6c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6760.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 02:29:57.6358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8449
Received-SPF: pass client-ip=40.92.22.14; envelope-from=alloc.young@outlook.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

From: alloc <alloc.young@outlook.com>

Changes in v2:
- Split into two patches, one fixing memory leak issue and another
  converting free to g_free.
- Fix typos

alloc (1):
  softmmu/dirtylimit: Convert free to g_free

alloc.young (1):
  softmmu: Fix dirtylimit memory leak

 softmmu/dirtylimit.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

-- 
2.39.3


