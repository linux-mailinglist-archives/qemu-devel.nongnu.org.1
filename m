Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E46A7A4B6C
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 17:10:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFsY-0005O3-Cw; Mon, 18 Sep 2023 11:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiFsV-0005Ms-HX; Mon, 18 Sep 2023 11:09:35 -0400
Received: from mail-he1eur04on0712.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::712]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiFsQ-00007d-S8; Mon, 18 Sep 2023 11:09:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcI+o3h8QoSMboVp8WCcm4P6FJ+9jzsYi7s/ag5dObuLWpW/fHEN0UGnb9mX0+vuTK/hHi4YQopLxxn41a2ntonbMkjgHucsc+Ah7iYetpQ/Nbvjxr6uuCiFgJ/7J1EuwaZ3flsunNuf39VGa47AYuWWsMLvK7J+GRLY7ByDGtRbcuspLHYlMhpdyljyWgpAxFN/XDriblRi+1jy72aNi/GczZXGRIU4gB4GbN6kL+nlDuvLSg8j0EdH71jB4dDo91ikwkQjAu1kUh2t+nFgb8EzcAr3+aDRwlCejTizK0B/ivHIfWYNRuujfAq3pxRK7+3GbS3qYLRDRMmAjeZYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxDx0TmpR2vjHrT5/S2Nw55U9LuRfW9HSKpIN3FgNP0=;
 b=YKsBRy4QoacTFriWUXCNuaTDlnCCgVf9IJiv9jLhWZiDBxlYPjSmII++0M6AuLD2ML8JQLecw3AMBDxla3pJfPs2pLaGmtElOp7bUpWIPvEaTFkrdchOhD034orNMAoDZjiGCVY66r4y8inJ13TiuQ530brfgCC2A5jk+xU/qW2nmqHCi9kMLTNjuEH2zKzbNFWN69NQ74oC65okenpukvkfopGRAXKXZjj1Iho6aZ80JXSZF9fQPOzIQQHsv1Wr/ZxhQTQrWoBuGaLZJTHQortVdCW1eaq0OHwiB8WV6KL6tpH/v2rRmAHE6amjPPBhCKMjtztTojC5mBX60wOZ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxDx0TmpR2vjHrT5/S2Nw55U9LuRfW9HSKpIN3FgNP0=;
 b=Uzhc78m/7Xu+dZhh/2M0UYJgw0AqYhQ19iDJ3fik4JGayvexM9Vh8ZCU/RnqYNbv7IIdav8Y+ruVef0wfFnZpyo+YeszFq+QzpwQmUuU6RFoclY4/qizlANPbxTjF3uRW88bwh0rzh+45yZUOlhNKPzcPWSi5kONguBBRprcTgd9WzWdKBNa2eWr4RKzVa/Ew3MMO4XjwYgiqkMsXJ6crTAB2wyakZo+GhlvgPPqx1oG2lQTTvGlGIMaG7tCFr5m8Umjgx5mMwFzaUD+Jtvzj5faMMbjJNFO2gbCxOKCEYcxjt0TcFhXHw/xpUK6DDzeSObtfSbklil/LLbaySqZSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by GV2PR08MB9277.eurprd08.prod.outlook.com (2603:10a6:150:d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 15:09:24 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 15:09:23 +0000
Message-ID: <60f6b218-7d52-e2d8-5608-47c8ef8d39df@virtuozzo.com>
Date: Mon, 18 Sep 2023 17:09:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 19/21] tests: extend test 131 to cover availability of the
 discard operation
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-22-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-22-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0109.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::38) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|GV2PR08MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: be49af17-f9d1-4978-0028-08dbb8593e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qb+WnpkWvsqiXMxdIspx+RTC74DKc7McAELsIqN75oXkyJ76MoAMQWfPMKCUb2eOrAncCMZfEB22U740cADoxHwWlwUgdHzS9aNU8uzEAo9qad55jXjxsvLW21hIOqRhGYx7IFzEmQeSPyMCW0oJMUnuiUpJ+8UjROzr8OfKQJaM2ob1NLPjkLEnmSaT7Ra8D0W2zAbgCIbcKohchjVJGy7GfdA+8uZ0ZgmZIB+ATSHtdLs+aD7vgoXJtZAi4Xk0wRSa1grt+tAA2QDVfoJCRhjBSduWmgqrvc/BT/itPiL4/+qaR4Qnct7yRcP1RV786yOPhINejGhQmxTXjRwcwAYeCWlEGt1JzT7vfVTutvYfOwH5oix+xIn8hdlynhaakWF4f4hX+PJzPNyFmxmm8+/K18FKerpJ+QzMUxX3ctVjs/6bxbtLPi81szagvEygl0gEOR1rOGiAvXZ0VLTQiiUFhzv0M56Isi4SgQHXhUZSGZP5EEMe2wMEZKivcPRSRU1gJYqatOFPGhseRyphaxFjSMw1MfJffsL010CGlvwzO7U2T3tvGR30PTRcW5k29qTY8nFQrkFAqmKIyIgdj9XQ0EvDeNfpzgjjWfVo8sb4razDavGkt+Bw+rOIsU1pSqjQXC/jl7K6SII0hKrX4WZhDSoDWEBtSIDmTBu5wJqqNa0mpLZ4WvpPy732sa6F3a+YqdbAOVHJY4raGMiJAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(366004)(376002)(346002)(396003)(136003)(1800799009)(186009)(451199024)(31686004)(36756003)(38350700002)(38100700002)(86362001)(31696002)(6506007)(6486002)(53546011)(52116002)(478600001)(66946007)(5660300002)(66476007)(66556008)(2906002)(6666004)(8676002)(8936002)(4326008)(44832011)(6512007)(83380400001)(41300700001)(316002)(26005)(2616005)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGU5bXRlUVZ2aHZROVZoOXJKcEVrdnZWK2E0Y2V4L3JsdGhJaW9JakdLdXEv?=
 =?utf-8?B?elRLUkJXQmRQa2JXK0xuYU5BbkMwcjRKTFdOS3NVVlZlN0k0WWpXMTJtSm5z?=
 =?utf-8?B?a3pVZ0xPZEs4enpnOHR4b1RNdVd3ekJjRkdtdDRjQ0wxUmdCMC90bWhTd2Zk?=
 =?utf-8?B?UmNZQjBJMnNYT3NoMFc1aTZTclg5d1BBKzJOZENFODJXNFhVdE5Mbk5XYzM0?=
 =?utf-8?B?aVU3WmdNamplUUlaajk4NlJhY3ZXYURUTS9IZFdYNVovMG9XQzJJbW5ReEd0?=
 =?utf-8?B?bEcvNms4amJhekRvUjNGMFgvWUJOTU1lamlUb05ObmxTUUhuV3JYS0ZIbkJw?=
 =?utf-8?B?eFNrbVBMbnllcThSbVQ2V3JxR1RoZ1V1YVJVWjBhRjV0dGxOcCs2cWF5Mkhk?=
 =?utf-8?B?R3JvTWQycjU5Z3o5WlhpSjh6b3JiUktoc2RPa0plcVNIU0Q2aUtCOTV2SGxW?=
 =?utf-8?B?VUl4eGFvQUxrS3lQTjUwNlI5RzlpL3dMaUR2bG1xVlR5eXlOQnpPd2lnUjNn?=
 =?utf-8?B?Q3R5Vlg3OHk2ZWtGSE1Sd0FRMVpsS1NwTXJvSHltOCtvQ0Q4akhSd05lY0dN?=
 =?utf-8?B?WEI1QzdIM3VuMTJua1gyYkUraFdScFIzQnptemxZeGN1VnZOQ1NJZ0luM2Fv?=
 =?utf-8?B?QVEwempFaDFnVjl4TzJMaExERkZ6OWFseGZMN3VHb1ZYQTJEZnVBbEpwNHVM?=
 =?utf-8?B?M1A4R1RWNVZTRHBpaDRUZVMvTjNHcTRPdjBjMWFPS0xWUDkvY1RWSWluNVln?=
 =?utf-8?B?clozMnZRdjVqYlZPTHlaRUJNRXl5NDJ4MHBwVUNBTE1oT3YrTE9QaEx2UEsv?=
 =?utf-8?B?RWV2VkRxeWxoWGs5WXFRYkhvalh6a1lQYStFd0NHQ1JQTFdrSUpZWFFlZlda?=
 =?utf-8?B?NWxVcU12MkhWZzUwYmo1V1ExVm5Sd0psaDFxaU9UWXVrei9tTjRKeTg3TnZK?=
 =?utf-8?B?Q0M1VCs1VWJ3WEQ3Z1ZyUXZZN0NwSEFmdk5IanpmZW5aajdaUTdJaVZSNVAz?=
 =?utf-8?B?OXFMd0JuNnVJUDRjT1c0NzdMR1Y1ZGs2eWpBdjR1dFhHcFJYcGIwWFZyTDlZ?=
 =?utf-8?B?T3BzM09TeDVDSTdqQnlmSEZPenJCdVgyeVplZG1mTm1VcnZVWFJDdkIwRXF2?=
 =?utf-8?B?bzBacmowNVppV1N6MFQ4NllFQlJ2RFd1VjVmUXM0SXFBZ2ZPbFZJYm5sRm9N?=
 =?utf-8?B?NWhUMlNGMitDaUZBL3IwbEpEL0hqbDhRZ2Zqb1pySEIzYXpKN0dET3FzS0lr?=
 =?utf-8?B?VUdGa0pDUHhnOU9PWXo4NldzWjRrTExZTVEvTkNCR051WU5uUzc1amNzcnA5?=
 =?utf-8?B?RWhBeVFId1J5RzIwbEFwWnVOb3N5R2NFb3FZeDhQcUYvVTYxSGlnd1BUemhv?=
 =?utf-8?B?VUZJRHBSNHVLb2lGeXN5S1F6MmtxTFFMVUFYYUFtdnBzMkVUOVVGcGhSRGd0?=
 =?utf-8?B?bGZ5R1gyc2FiWEwxRTRnalVzQm5kaFZHekJPellTUTUxQ2cxb0l6MWZKZ0Jm?=
 =?utf-8?B?YW9Rd3Y0RWN3RWRYZ2JKRmZtVEpzdlVWSzU2aUoreS9wZWVGd1NVbktrZzA1?=
 =?utf-8?B?cjBGS0tjSUpMbEF4Tnc2RkVyT0JsVjJSejJmQnhYZUZXdm5KVWxOWnd4OEJH?=
 =?utf-8?B?QTBjaDFVV1d1YksvUUlPL0ZLZUpYUE51WFpvR2tmdlJsdGI1WUpBR0E1MnZW?=
 =?utf-8?B?OUpTbk5RZk00dTJxeUhyeTNoWHA2N082QjFiNWJvVVRNRnh3ZTFpTVAveGps?=
 =?utf-8?B?VXZheU1IL2hZWnQ1S2tuM3pieHpFaTByM2VuWlpZZ2wvK2JCM3BOK0RPVG5n?=
 =?utf-8?B?YnJaV1h2emt0ai94OWlGVWxSR2dmV2hTNjhOVXVMSTJNeWZsQXoxemIrcExN?=
 =?utf-8?B?eGZiZjcvSVVxWkZLdE8rcjZGNWVPMjdpNDVleEpSTUZ0NDF5ZnYxYmpxcWpu?=
 =?utf-8?B?bTlwN2RVeFhheCtlbzlmamY5UzFGVFJTcW9vV0JRaDY0dXljc3B6a1AwTzM5?=
 =?utf-8?B?L25KOHUzSitFV3JkOStOcGFmZ3JnbTlMY1FKWmJDaGhtUDBqcG1TTjBmVGdY?=
 =?utf-8?B?dXBhd21oK3NZYVVCU2tTWGlKYXNiNGR1ZWRoWHE2L0JzZFJsa3A1UlpVaHVT?=
 =?utf-8?B?a1hlK25uU2QxVEpYN0ltdnZoMHk2ZTdGZVhTQU1BL3h0dUtqL1dGY3l5TFc0?=
 =?utf-8?Q?NDiKaZPJcnfXUwGArrAwWOE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be49af17-f9d1-4978-0028-08dbb8593e11
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 15:09:23.6863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxSDrsjM7r/09Qw2nLH2WthXRSA18x6MPV3BHjtXW1f9mLiIKrG4mQx4xWzhQsiJdTeqYpvOh8P+YJPxNzNrDm8r0s7umYn/nNhu7GHihTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9277
Received-SPF: pass client-ip=2a01:111:f400:fe0d::712;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/15/23 20:41, Denis V. Lunev wrote:
> This patch contains test which minimally tests discard and new cluster
> allocation logic.
>
> The following checks are added:
> * write 2 clusters, discard the first allocated
> * write another cluster, check that the hole is filled
> * write 2 clusters, discard the first allocated, write 1 cluster at
>    non-aligned to cluster offset (2 new clusters should be allocated)
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   tests/qemu-iotests/131     | 31 +++++++++++++++++++++++++++++++
>   tests/qemu-iotests/131.out | 38 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 69 insertions(+)
>
> diff --git a/tests/qemu-iotests/131 b/tests/qemu-iotests/131
> index 304bbb3f61..e50a658f22 100755
> --- a/tests/qemu-iotests/131
> +++ b/tests/qemu-iotests/131
> @@ -74,6 +74,37 @@ poke_file "$TEST_IMG" "$inuse_offset" "\x59\x6e\x6f\x74"
>   echo "== read corrupted image with repairing =="
>   { $QEMU_IO -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
>   
> +echo "== check discard =="
> +
> +# Clear image
> +_make_test_img $size
> +
> +{ $QEMU_IO -c "write -P 0x11 0 $CLUSTER_DBL_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IMG map "$TEST_IMG"; } 2>&1 | _filter_qemu_img_map
> +{ $QEMU_IO -c "discard 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IMG map "$TEST_IMG"; } 2>&1 | _filter_qemu_img_map
> +{ $QEMU_IO -c "read -P 0 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
> +echo "== check simple allocation over the discarded hole =="
> +
> +{ $QEMU_IO -c "write -P 0x11 $CLUSTER_DBL_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IMG map "$TEST_IMG"; } 2>&1 | _filter_qemu_img_map
> +{ $QEMU_IO -c "read -P 0x11 $CLUSTER_DBL_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
> +echo "== check more complex allocation over the discard hole =="
> +
> +# Clear image
> +_make_test_img $size
> +
> +{ $QEMU_IO -c "write -P 0x11 $CLUSTER_DBL_SIZE $CLUSTER_DBL_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IO -c "discard $CLUSTER_DBL_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +# There is 1 cluster hole. Fill it fully and allocate 1 cluster at the end
> +{ $QEMU_IO -c "write -P 0x12 $CLUSTER_HALF_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IMG map "$TEST_IMG"; } 2>&1 | _filter_qemu_img_map
> +{ $QEMU_IO -c "read -P 0x12 $CLUSTER_HALF_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IO -c "read -P 0 0 $CLUSTER_HALF_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IO -c "read -P 0 $((CLUSTER_SIZE + CLUSTER_HALF_SIZE)) $CLUSTER_DBL_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
>   echo "== allocate with backing =="
>   # Verify that allocating clusters works fine even when there is a backing image.
>   # Regression test for a bug where we would pass a buffer read from the backing
> diff --git a/tests/qemu-iotests/131.out b/tests/qemu-iotests/131.out
> index d2904578df..9882f9df6c 100644
> --- a/tests/qemu-iotests/131.out
> +++ b/tests/qemu-iotests/131.out
> @@ -26,6 +26,44 @@ read 524288/524288 bytes at offset 0
>   Repairing image was not closed correctly
>   read 1048576/1048576 bytes at offset 1048576
>   1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +== check discard ==
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +wrote 2097152/2097152 bytes at offset 0
> +2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Offset          Length          File
> +0               0x200000        TEST_DIR/t.IMGFMT
> +discard 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Offset          Length          File
> +0x100000        0x100000        TEST_DIR/t.IMGFMT
> +read 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +== check simple allocation over the discarded hole ==
> +wrote 1048576/1048576 bytes at offset 2097152
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Offset          Length          File
> +0x100000        0x100000        TEST_DIR/t.IMGFMT
> +0x200000        0x100000        TEST_DIR/t.IMGFMT
> +read 1048576/1048576 bytes at offset 2097152
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +== check more complex allocation over the discard hole ==
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +wrote 2097152/2097152 bytes at offset 2097152
> +2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +discard 1048576/1048576 bytes at offset 2097152
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 1048576/1048576 bytes at offset 524288
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Offset          Length          File
> +0               0x100000        TEST_DIR/t.IMGFMT
> +0x100000        0x100000        TEST_DIR/t.IMGFMT
> +0x300000        0x100000        TEST_DIR/t.IMGFMT
> +read 1048576/1048576 bytes at offset 524288
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 524288/524288 bytes at offset 0
> +512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 2097152/2097152 bytes at offset 1572864
> +2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   == allocate with backing ==
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>   Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864

LGTM, but it didn't detect incorrect discarding.

-- 
Best regards,
Alexander Ivanov


