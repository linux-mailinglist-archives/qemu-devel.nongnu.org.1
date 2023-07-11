Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8910174F63A
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 18:58:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJGgO-0007xm-MH; Tue, 11 Jul 2023 12:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qJGgM-0007ww-K7; Tue, 11 Jul 2023 12:57:46 -0400
Received: from mail-ve1eur01on0725.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::725]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qJGgK-0008OO-3B; Tue, 11 Jul 2023 12:57:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIcZxKYJLfvomHxWwFnfholz4q4JfU8Gb8z0LdNMP+Aa7AVJrzmBIpZJvWDNtcPGrFxhUqyHyZ6bxC8614dy+4ZEPp1vgY09zu5/EB3Lyd93G0n9j5xnj/Dor8tPoeEYAQgCxi9yKGoLD4EO8rO8mJqtrSdzTWDnERny1tVO5jBEGfpb6gjmPztk9SsFUqwn4L/M9ZOvwdsiwfK4WLKI0GgtCwvomB6eOwC3eH57LMEsms996rB+QgsklJF0oyeuH8XAbXnbIVCxQ6uMPnv73HqlW1oK4BJYxOlRRQn2mGCmI52FrNa22ONYJOu6fszHbP10HXQ+jxLdYPv/On5wRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63I43v2Xal7iNai8Pvkdn7talRPm7BT32mGkIOlKARQ=;
 b=Ja/xkHldkvoCB2WlgJwYxvs8sEt356tQWO8PDYhNZuri6u3zzv+WlzbTX7sgo4EOiSVwX5e1KNkCCOjLfvPcJtl2RU54REKc99flANlE+j8DjUNAF2wXxMM5gGvyAaxa18NDgPQoMgIlTd7rElXsEAsXN6vHUlmD4z97ZuhJuwyyHhfQk5t8T73d+CRw2WCYmY+5UYX0BvDu/dlcabx70WulZ7mLjemXw9XOzAGeHJhgpC/zSLM4cUY1AMjvt6TeXOiwWlA4Xyitd7noDXl1MtZ2trN4SIpobPheYs/lGW9r/bMvN1KmHRs+cYBlFXSxSK5Oxyw2Sl6Ps7TAOLAHyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63I43v2Xal7iNai8Pvkdn7talRPm7BT32mGkIOlKARQ=;
 b=rawaGq0DcByYP5iOO7myIrHoAbS5l6b7A0J4cCtufxoi9eOQtTClQV62gyOe6W+L1xnXygr/H48OsH+mJBPL33PZ2aLIfd+5WZ/rjLAy292XMPP9Rr3uOyv5EUqvg+axbRq5Hi85egV+C54qEVQu6PXBNNncpqrgVWWtGRaYmhY1SX0vwwxvij+vA2zOwtme6xvk5hC7dZFcmtJNfAh8Rx8cJ72TzuMDl5P2+QzNOie0oe4WUWMiksIcGXePvHA06rEYrwG16VIBNM676gQKfp+h2j4hASrDX0ytXiHoVdcCQrxr0+81jRozltFkATlQ4pWipJQxXO2+MKLaLOsxKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PAWPR08MB10258.eurprd08.prod.outlook.com (2603:10a6:102:358::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 11 Jul
 2023 16:57:36 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7%5]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 16:57:36 +0000
Message-ID: <0ecaafdf-e5dd-f260-b07f-8a91c37b2270@virtuozzo.com>
Date: Tue, 11 Jul 2023 18:57:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] block: add subcluster_size field to BlockDriverInfo
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org, 
 qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru, eblake@redhat.com
References: <20230626160834.696680-1-andrey.drobyshev@virtuozzo.com>
 <20230626160834.696680-2-andrey.drobyshev@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230626160834.696680-2-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::22) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PAWPR08MB10258:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ffa78a6-7467-4d3e-a580-08db822fed3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YPNlBhrVhNzDpwGUCI48ukZm7Q68fE/Urt7Cm3WNj8aNTV827kXHffe3ZSH1BEcqhcVkhxp4RY7uvt3MN7ZLTQ2luRHPPow83ZSH90dPp3cNmDtFLgU92gFchNQztzKkR1k4QKh/WSNaMZlM+HpbxvEXea58iepGQcyr7/gjSUjiAHlUbZ7jrHbFObf/Utt1Z3PiycxXXTi2V1OiaLxDFdAOwxeg3h2bZ+j3HYKuJowRQntltlOCR7qUiJ+l34pmERrppQSyOkjbhxnxJrphrieChp+X7/ubHuCP6gEogUA6uNgwy+sq9a0RLKsVzE/1mOetWPwXXWkUHSWF91qzLtEYZ66Xb7RWyQcKCQkCSZDly+WolT94CotZQCmsVcwgoWu5dW+XcFU9uqEIV3Szq9sBIxsGalmKfpz1sBrOZFhQ2HMeXpSKBVdYBUAlCD5r8jB90zmPqZtBm6Mqsv4mbTL5n/5nUyS9e8HoYqGkNK4nsxfdzyzbIsKHoWZJrvXCpMUFtpOgNMlKboWHur9yXLeLLUqUZHKRzXhelKGRVRdZTQenaLCYw/+EYE2K2FLx7gJUpqMiLDwaHE77WdHk44Gj1NJs6oT9mJNLY/mu5dCd8gemRx5eNThu+H/PrendDqGxsIqsihAL7frIyQRM7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39850400004)(346002)(396003)(366004)(376002)(451199021)(26005)(53546011)(6512007)(38100700002)(6506007)(186003)(83380400001)(2616005)(36756003)(2906002)(5660300002)(478600001)(31696002)(86362001)(6666004)(6486002)(41300700001)(316002)(8676002)(66946007)(4326008)(66556008)(66476007)(8936002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFNJbUIrNDFNRW52YWlCVDNFMHBRZ1RwQjZkY05FcVY3MVJNUXhGTjRIVkdy?=
 =?utf-8?B?bDVTaU4vQUJHYjRwZ0g1cVcvYktnVUc5RGRyK3phTFYzdVVqajAvYStIV2F3?=
 =?utf-8?B?MFZMTUZEd056Z3B6OGV2YjBIb0JyVlNUR1VWRkF6V3p6ZTVzcjc3cVY3VUx5?=
 =?utf-8?B?cU54Wk5kOGYwYjgwTjZGK2M1VnlPQU56WXBvRE9zMkJ5ZUxnRTFrWkRqMDhv?=
 =?utf-8?B?b3l6dkZSVVpSc0xvcGx2bHVlNW1UWkxYc29DTUVheHdmRTBWYzFhaEZuVTI4?=
 =?utf-8?B?eDd6L1Z5b0FhVGlBQWRVdzRJUXRZbzZ4YzdnQXhzV0UzSndHaWhZaC9sR2ZY?=
 =?utf-8?B?SEVKYUZWWDBuVjBzeDBZWkVYaGdRZ1BMOEg4WnpVdXpabk00QkpyMktIOTFz?=
 =?utf-8?B?ZHNwcjFxWTg5enBkWFVZZ2ZZQWRWb09ZNWdGMStFL0xMZ0tPMy9TVGJ2aHBF?=
 =?utf-8?B?blBWMHNZTFM1cS9Ydit3ZzdEUHpNK1ljV21kSGt1MGt5Qm4xV2ZjYjFyN3E2?=
 =?utf-8?B?azZYUTdaWTMvZldzTnkwSmI5Z3RKTmlZYm81aDBjd0hVaHZnUC9uZ25Ud0ly?=
 =?utf-8?B?UENrZGtaK2tWNGpFNENqTk90cVh5anFkTVl3TXJ3WnNsNE9LSkhiTE9ZaWh5?=
 =?utf-8?B?SzFidWcrekVwVjgxUTdnZmJPMlhiWHlVTDFVdUdtWVp2ajlySjhRN2VWek5m?=
 =?utf-8?B?dVBCUUh2Wm9NcWh5ZU1YVEFIS1pISFhENDRZUkRyMkpWa3JNVE9zaGZ6RHhn?=
 =?utf-8?B?aXFiazVId2ZjSVZydUlyYkVlWlYydHEyVkVsTStBQ1Q3RjhpUEtDNGx5ZWZU?=
 =?utf-8?B?OVUxMjBCRkkxMjNrK1NIVlVta3FNS1g5b1VaVDVVTEYrakRKTmoyQ01lSmJu?=
 =?utf-8?B?RTBoY2dWWW4xM0pNajJLZCtEeDdSQTFPa2g2aCsrY1ZIZW9lZ2c3VHViNU4r?=
 =?utf-8?B?d1FsRmlsK2NtMTdlTU1rZVBUeXBHVm9tMW1zdTVsRzlVYTdwMnRxSzZaZTJ2?=
 =?utf-8?B?MnlkaHU4N2RNM3NRTjlrT1JrQTRGNG9RZ2s1c0F1SlI5OVc0eVFMMEhpTTBD?=
 =?utf-8?B?UnJNUnpSdGliUit3czd0M1lrK1U3TEJHc2pwdTk3SFUyUGExMy9pMDlOemtP?=
 =?utf-8?B?aXNNQU84NWk5SWRVUmQ2ZG1CczlPSEZJSzJNSC9KM1lvL0c2dDNIZGJ6M3BH?=
 =?utf-8?B?VzROWlNDazE2N2ZrMEhZZkwvaXJQMnF4eStIbW9XR1MyTzl2NHNTVlg5Z0VU?=
 =?utf-8?B?RnlEQjc5R1dJZEFOKytkemlpQU1tQXZuTWk2L0JsN25GOWcvdnNmR0hZKzlh?=
 =?utf-8?B?UTA2TmFtK0cvMHVqci80UXVzMWgwQmhYVWJSUjc5Qy9HTWo5UlExMU81SU9k?=
 =?utf-8?B?Tm51ZWwxenY4aW1iTVUxM0l5U2RaaWJqQXZIaGRKYUYzY2pGV292ZWt6VU9M?=
 =?utf-8?B?MzlWQnZOUUlEWGlSMkFhZ3pvazJMMFh6Wjk0cHhjR3ZNQm9pcFNqSGVha2tJ?=
 =?utf-8?B?U0YwaFVlampnelNNMjJ0VGVVTStrUE95bjVuSktSc21PWTArNzQ5c1VHb2Zm?=
 =?utf-8?B?Y29rT2tZbStoekJxR1hlNXhIbEhPM1dRbnN4aGpoL2t1RExhSWo0WEVraGpx?=
 =?utf-8?B?TXV0N3p0OXhGQUlzUjFlczQ0RSswdWZVWjlrTmJhUklTTXlSazdlQm5GbkYw?=
 =?utf-8?B?U1RIbUI1ZkZXcVA1L2YwYzFtN1hrNGIwdkhrT1RLem9xTW1yZk1LVko1Nmtk?=
 =?utf-8?B?N0NuUXpBbzd1cllnYnhwVlFGU0dkbXBBQnVvOGdtRThBRXRjUkNCek9pM3dv?=
 =?utf-8?B?S1NLT1h1bllxMnlQYVQxa295ME5qYjhmTjZHTXBjVXdaMDNGc3dSaWlIUW9R?=
 =?utf-8?B?S1dSUnlGS25BaXFmeFQzR3Zua2pHbStpWFRZeGt3R0Nua2tYVktJNDQ0WVVi?=
 =?utf-8?B?dDhxeEF5Y1hsL016ZFRBT2pSc0Mrc21rVW1oNkcwTlVKY3kwNzBDdHBRQXJm?=
 =?utf-8?B?TFUxRU5lVDFYcmRJN0tLMXQwamdaSHU5cDUzb1JPMHVJZ0F3bnIzbk1Rai9I?=
 =?utf-8?B?UFB1UGtadFJPM0xYUis4RjRIVFJGMTRYVzZrS0NmdEZVRVROUHN6bUZkdGFU?=
 =?utf-8?Q?XdVCyqMDbrId9KC7fhAVEoOTW?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffa78a6-7467-4d3e-a580-08db822fed3b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 16:57:35.9620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zs5BuhNyuBlvkwLuqSHDPY5JduaeG3tkZobnfN1hEdVhnKHuKE7fshhuiLw3ESJlEOnSloPx0/tiqpyn2R5qrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10258
Received-SPF: pass client-ip=2a01:111:f400:fe1f::725;
 envelope-from=den@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 6/26/23 18:08, Andrey Drobyshev wrote:
> This is going to be used in the subsequent commit as requests alignment
> (in particular, during copy-on-read).  This value only makes sense for
> the formats which support subclusters (currently QCOW2 only).  If this
> field isn't set by driver's own bdrv_get_info() implementation, we
> simply set it equal to the cluster size thus treating each cluster as having
> a single subcluster.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block.c                      | 7 +++++++
>   block/qcow2.c                | 1 +
>   include/block/block-common.h | 5 +++++
>   3 files changed, 13 insertions(+)
>
> diff --git a/block.c b/block.c
> index 0637265c26..4fe1743cfb 100644
> --- a/block.c
> +++ b/block.c
> @@ -6392,6 +6392,13 @@ int coroutine_fn bdrv_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
>       }
>       memset(bdi, 0, sizeof(*bdi));
>       ret = drv->bdrv_co_get_info(bs, bdi);
> +    if (bdi->subcluster_size == 0) {
> +        /*
> +         * If the driver left this unset, subclusters either not supported.
> +         * Then it is safe to treat each cluster as having only one subcluster.
> +         */
> +        bdi->subcluster_size = bdi->cluster_size;
> +    }
>       if (ret < 0) {
>           return ret;
>       }
> diff --git a/block/qcow2.c b/block/qcow2.c
> index e23edd48c2..94b8d0e1c2 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -5197,6 +5197,7 @@ qcow2_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
>   {
>       BDRVQcow2State *s = bs->opaque;
>       bdi->cluster_size = s->cluster_size;
> +    bdi->subcluster_size = s->subcluster_size;
>       bdi->vm_state_offset = qcow2_vm_state_offset(s);
>       bdi->is_dirty = s->incompatible_features & QCOW2_INCOMPAT_DIRTY;
>       return 0;
> diff --git a/include/block/block-common.h b/include/block/block-common.h
> index e15395f2cb..df5ffc8d09 100644
> --- a/include/block/block-common.h
> +++ b/include/block/block-common.h
> @@ -132,6 +132,11 @@ typedef struct BlockZoneWps {
>   typedef struct BlockDriverInfo {
>       /* in bytes, 0 if irrelevant */
>       int cluster_size;
> +    /*
> +     * A fraction of cluster_size, if supported (currently QCOW2 only); if
> +     * disabled or unsupported, set equal to cluster_size.
> +     */
> +    int subcluster_size;
>       /* offset at which the VM state can be saved (0 if not possible) */
>       int64_t vm_state_offset;
>       bool is_dirty;
Reviewed-by: Denis V. Lunev <den@openvz.org>

