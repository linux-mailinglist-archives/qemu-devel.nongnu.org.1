Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA2A7DB5C4
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 10:07:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxOEH-0006a5-7p; Mon, 30 Oct 2023 05:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qxOEF-0006Zi-Oz; Mon, 30 Oct 2023 05:06:35 -0400
Received: from mail-ve1eur01on071d.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::71d]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qxOED-0002K2-FX; Mon, 30 Oct 2023 05:06:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPgHBtscnCqucgqzv0u0cxNPYP8Sp4gqCguPny7pmOlOGWtH1lXFMRnGDk+7iEIPb72YTmFbw2TvIqZHPSln4K+CwyPUBy4fQkr4Bj4afO8MXyzC3y9xI5mbn0+7+H4tfJGG7M9pBFWlXJgwqsMbH2rPy+3ba3C5TL9P5ANcaRv8yvLnUYyME4xt+Xs+m8LKXE722k4Fv8GYgsUslncJndBu3CgY2yQBrJ+/lA81BgcJCXUVPTZhigwtO1Ad1heM84PGB36Ne/hokXUyT2DOGbAe344RdLdE+Bwn69qpkztjeIgccQlcuqbD/o0Nhw9UaZ5D5Wv647sY8sC4GUPf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLW63r6r8Uk21fwxvQspgi4xmSrYo3B2/ZHfCposiXk=;
 b=HLZdZKYKdnX8nrRGk1xGjPk5BIn/Tl2rR4B6dNWE77ceaZufE0Q/xzDSDMLiDkszo+AVtKQ8rjJAQUXLIU9Gy/6gdK0b4oxTTpfLEX4mFrngPkpRA4fKKZudpWXvxIu8JDtvCDpULO4RuykFFco44BBRDiay76drG20ho7d5atYqPMttrcm/pUKui6e/Im3ltrK3KHiY/De02xM15OBFNLQLIkwlyub+wvfm1YQTrqL9YbyGBjBBhNSl1gHcjdC0PV4QFKv0TAD8Ck/Sneqm0t1hXbBAbWpxu9BGA487wrRVEL52JlJsb2WC4BhPgBsJ0VdiMTfofPdTl+7buULKFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLW63r6r8Uk21fwxvQspgi4xmSrYo3B2/ZHfCposiXk=;
 b=T8b0Xe0lBj3cHEaGwmZq0ax3etYCuF0Iv2oJpQjZnpMgxO2yPhqPeF7LQu+tuZpxrzeLD7DyDWjwxXNX5URtoYSooDyWs79s+njTduXOERNI54EEdFJFGYnMoePKkgyyLFnlYbTfDjy8lxo18UpLAL4j1MUZ3/Blv1myhKRsc9W0+lRimrM68dBF67VFdKtqjvRdFZIxsQ2n/ydv24h9c1UfHd2J5ebgVi0vElZELdf0PTBH5bZxDk49sNbiKrS+Ikf6mdYxnx88LF1F0S0ZLQt3viuuX8W/QuGVcsE/qYvh4S9b/7bDlDKUt6glm9aeup5c5cKkZyRf78Xnmx7R4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DBBPR08MB10628.eurprd08.prod.outlook.com (2603:10a6:10:52d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 09:06:28 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::c196:49d8:108c:2254]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::c196:49d8:108c:2254%6]) with mapi id 15.20.6907.032; Mon, 30 Oct 2023
 09:06:28 +0000
Message-ID: <c3eb3258-d650-43d7-91c4-0f262408e54d@virtuozzo.com>
Date: Mon, 30 Oct 2023 10:06:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/21] parallels: Add parallels_mark_unused() helper
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
 <20231027074636.430139-5-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231027074636.430139-5-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::33) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DBBPR08MB10628:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da650f3-7f04-4928-56d2-08dbd9278013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OTdYSHPBYjXAWtJ1ckPIKI8txZWWM1RNzoO8oqW/9/1OTa+genK2ekkO7xucePCmyfV3cP/DSeePS8ki8qjOyxXZKoRbr/bqwVhmUWIR6jZGIbkrIA1wjnM/DowDGgW+TWHkzI560ygRaJTVyQJaQSpvIMywcnHRkBfpIbqDcYQTXgsMwu9y493nTVgy/JbzJksKsV7YLMQPkxxx3FBdyJYqlHhPWNhpYEJGG43818II0PRnawIJBSgExPDNvV2U0R8nMgpwHFK1X7RUbiPWnC/rx91lYBAb6ei6WzBYLt3eLtkuKjbSykLgrABEm6LWum6bFkc5wy6XWHSSLrWs0BSB84vPdVuTlrnRLot3UkUtCWeZ+bt9pdETx+JzKBj+y8DTmDogT4DPk9waeVGEN8s88AsAodmXy5OD2T1YeWHDcV0qrsRT+9byc7ZRHRYlcFA0JOcbkwOCcwJVqU91eN65dWqlJTisr+deaM7hwTn33R6sN6hzN8M2n44DfonWg0Xy8BIXBLdVmLxkHzIYkRQ6x45V5bd8WONymEFaDhz1jNSIqhtX50PFKgrcSwfZNg3DfXJctcg/VdSH5A6OJ2XhCXCxgrWiKfk46kpOPth3IZIIqhPf0+OXXtr607j3HGXc1YyawiLeGJY2OdBgag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39840400004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6512007)(26005)(2616005)(53546011)(478600001)(6506007)(6486002)(83380400001)(2906002)(66556008)(41300700001)(66946007)(5660300002)(8936002)(4326008)(66476007)(8676002)(316002)(38100700002)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1VpUGVWRFNQY1VEdE54ZXN2c0tCK2dzZmI0Tno3VDY2L0xUM0FFb3FyZWI4?=
 =?utf-8?B?bTdTK0FsQXJQdmRZSDhSWGlRQUZYbXYzdVVETTdqc0Nna3ZFRURCT2VMTzkr?=
 =?utf-8?B?MzN2c01IZ3AwKzBCRmtyN2lYV0VIRW5SQTJ6Q1J3akZWR0JEalA2N1BWUktw?=
 =?utf-8?B?UWFhUThobk9LT2xub0RpWWtJL2ZzUG1rMGxiS2FpWGNPODRaT2JPeVN6dVRE?=
 =?utf-8?B?SUxyWFVXbVZIeWo2OGZGcU9vQVQ1N3RJck5GS3Z4bzhtbldCOEVQYTZuMWJa?=
 =?utf-8?B?Wll3VkpBbklMZEtxM3ZQQmtQbDlsRmwwdDQ5OVFWVW8vTUVkSXFaSmdKNGE4?=
 =?utf-8?B?MEREZVg3dEx2dm1sMlRqSndHUlFvRlVncDNrS3ZraU42V2ZFSGJYaWh5b1Ry?=
 =?utf-8?B?eVN1RTlObU5lbElyaEppQ091V3pQNkpKNFFxREZKZ1lxMU50cG8yRFRxaXh5?=
 =?utf-8?B?YStSTlVUSHJrVmY5TlFsQVRCNnRwcy94Y2I1SUdqemlFNnlYbzcxUWw3ZnEz?=
 =?utf-8?B?WjhTNGZ6Q04zem8wdC9OY3BYSzMrZ0RyaUpSSWVxV1ZScEZ1SGlRdHczRzYy?=
 =?utf-8?B?MDdMTmZ1R3MvMFFrSk9ITEh5WXBnQ0pseVNhbE9BUlVtTzhvVXZ0a1ZFYnkv?=
 =?utf-8?B?VlBiUXhYdWtyY2o0Z1ZIRDNXQkExTmZIc1JPQ2dxbksyemJsbldWNEFnZE54?=
 =?utf-8?B?ekNmVWF4RHAzazk2WWJjOUhjZUhneHo2cTVYamNLRWl5L3plRVF3YW1pSWFF?=
 =?utf-8?B?WnUvWk10VEd0ZGtWNkNRUElDbTc0QmFaY1ZySXNzMEFaMU1IM3hUVXM0U3Rx?=
 =?utf-8?B?NXN1OWR5ZU0xQTk2cGpjYzZFd1hidTFCODhzNExkSnhPaHRCSFZwdVNLcFpR?=
 =?utf-8?B?b0NDTGp1MkJMOEN1SVdrZXppMUJpaWpObWZucUFISkFKQVZjTUxNUjJQcThl?=
 =?utf-8?B?aW9hNUNKaVFZRFplSUZEbWZBSmVveVZJQnRTMVdrSzY2S2pVUzJQYjlsUXJI?=
 =?utf-8?B?SWkxclZTUGZFRThEdXM1V2Z0dEMwMlNqRkZIZnBPSzBnUUNFeVFuV2h1V01y?=
 =?utf-8?B?a0xBL1A3YjNXM1MzZm94Y2U2R25LOUR2UTBiVUhFUWEzWVNQVkN3OXlteVp4?=
 =?utf-8?B?RXVRcVp5K2cvYTNCYTAydGVGRUtmM3VFRmtOa2dkNTVGcUJMdFoyTjEwcXlE?=
 =?utf-8?B?bitXQUI5WHBJRFYxbTlEV2JZQWxTQlpTQ3d5UDV5MUIzRUY3bXlwOWtoOXhs?=
 =?utf-8?B?dzlsL0hlTVdXV0lJdDdIalhQZE1WZlNERG9aQ0VlUS9KTHBLdTVDb2VJQnpO?=
 =?utf-8?B?aHo1STFiZkRpMWxtN1JMU2JpVktYcWdMemxiRWdBelpzZ1VHa3Z5akNEdWN4?=
 =?utf-8?B?MGJMUVM4K3p5VnUxTzJQZit3cE5waUFCRVdPVjhReUltVTRYYStaanBUUU04?=
 =?utf-8?B?cGpqMDVpWWw1cjR2WitxMGpaU3I1dmFzcURZVUo5OTM3ZVhOZlc0Nks0OStP?=
 =?utf-8?B?UDl3WDRiRnJGM3ByRXBNMmVlTCs2cXJoM0xKUTdIYmhIUjBvNndYOS9VRUND?=
 =?utf-8?B?RUdrZlBkWURlRm1mSk1HcUVsSnZ2R3hCRXlNb2NMQSs2MFRGbDNRcHFvYytv?=
 =?utf-8?B?cDRPTmJrUHBHNkZ0RzErZlVhb0lxSGFFajV2cU1yL3hGb0xGZHpyU3JoWHFl?=
 =?utf-8?B?U0VSNTlaeVo4UWFzRVdRVG1qaHovUnpJWDF5Mm9qaE5zK2Z3YkNRcDNCc2tJ?=
 =?utf-8?B?VGxLNGxLZzJCMis4UjFMeEt6Zm1acEt6NWpHQzdDVVR5N1ZodkFHUVIxSGQ5?=
 =?utf-8?B?YTVBMmRRU1lYNjEvbjJKQm1HVlAveXYzYVBzeUh3dzVVM1hWN1FWcWlSTWRB?=
 =?utf-8?B?OXBaZHRYMGlNOTRFV0NicEtnQkVEMFNMODBYaUQvZVV4NUJ0U3JiTkI1ak9l?=
 =?utf-8?B?TzRHRDlWdW5RaDFLZzRld3lYVDdIUkhlandzZzNLOStaWFJwUGRKNHJsRlZG?=
 =?utf-8?B?KzRXR3RlR2NIQTFsMXVjQ1Z2Y0prSmJGdzFUOHdsWCtrUWRMWmNtZlFqb281?=
 =?utf-8?B?TGY5K3k1WTJzekFWWW5BRCt6YUM5TmljQ21iQUF3MFVNRWZjb3NEaTZSTjdn?=
 =?utf-8?Q?dklMtdoOLaoD7rm01xuTPgF/8?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da650f3-7f04-4928-56d2-08dbd9278013
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 09:06:28.0254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Sv3zJlKZh2HPbcPsDPtGjK12H2BCD/wPAnwIjvh2mog6sIrXiYHalwJzjMrrrQ1tMSzN3Bzgu9HkBAEDUO5qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10628
Received-SPF: pass client-ip=2a01:111:f400:fe1f::71d;
 envelope-from=den@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
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

On 10/27/23 09:46, Alexander Ivanov wrote:
> Add a helper to set unused areas in the used bitmap.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 17 +++++++++++++++++
>   block/parallels.h |  2 ++
>   2 files changed, 19 insertions(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index e9a8cbe430..a30bb5fe0d 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -195,6 +195,23 @@ int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
>       return 0;
>   }
>   
> +int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
> +                          uint32_t bitmap_size, int64_t off, uint32_t count)
> +{
> +    BDRVParallelsState *s = bs->opaque;
> +    uint32_t cluster_index = host_cluster_index(s, off);
> +    unsigned long next_unused;
> +    if (cluster_index + count > bitmap_size) {
> +        return -E2BIG;
> +    }
> +    next_unused = find_next_zero_bit(bitmap, bitmap_size, cluster_index);
> +    if (next_unused < cluster_index + count) {
> +        return -EINVAL;
> +    }
I would limit the search with 'off + count'.
There is no necessity to traverse the bitmap further.

Den

