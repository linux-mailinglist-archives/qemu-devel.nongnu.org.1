Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B31B17A48DF
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 13:54:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiCpA-0001GY-Jv; Mon, 18 Sep 2023 07:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiCp7-0001Fp-VP; Mon, 18 Sep 2023 07:53:54 -0400
Received: from mail-db8eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::700]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiCp6-00062U-1H; Mon, 18 Sep 2023 07:53:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZETb4OjBpU4C1BP8T8CmEAUKO4i/CM/X7VIAoCg2Y4ZBOLW1wUrYl5N0DmBRudgq/NFdW4q6nbO8qRq5J5ayYwUDszO6q9sqVlao8kAXYuti6Ep0CHCNMd8RjUpQzGWOfno0SlcsI1ZiXaHDYL6B7ca0/ewPItxmMjkorSYCz+RSGKDm+jZ2px7OPj6aTygeZ7P1dLxtcSz6iSHe9MwiLx39X47QoSK+mYNRiBIhhNNAiG2BMQJSboRyaZPR0bbmUvFX0Qq+Fk0o5tux3JcJfJBp6KHoWvaDF2LDDtrtl+Qk+YNfzGMq+m3GVfFHZUoWgBp7DsbZgk73S9QEE7Iug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iB6TtOG0z7DG8r8psPPgk9mTDhZxik6Yd3wUjTi3POc=;
 b=biZdRBUtcRjTqWvjzSpnHbW3xPGObNaYOc8kTjkGaFEJMuNTRUXJNJ4vy7gBhhPB47BVSElDqnEZFcGzJ7B4HTrKHCAgBbYiW6VPUYFobah++xO29Fjm6MBT8dVSP82u8Ks0ooNfx4k1fNetMid8XzlTPtxJ1tWt+kdVmYeQR5Ox9BjeblVFy2sMVPQavPJbXzm6L2EdP62MUAw9CBPFsWRXaSQlrW2mA0PQ05oWaLl/v7lYu61JE8prIWfddZtBzG1AgO5cL0qoy3DlNEPEtr7UkE3gJxtno5VF/C5o3Nd5cjSDGbtYxMiAtisAfBaFoX9okWy2uul2o1nRfvUftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iB6TtOG0z7DG8r8psPPgk9mTDhZxik6Yd3wUjTi3POc=;
 b=ISV/Z0io1ViBTxcg44q8VM9dXGqkS25XFG7vUWk+Z5h+u9zvZmsvcetjFnBeh06syXoIp5wSEY/8OU6LfmMkq5UVX/dnjXb+dHxQNtB6uNTn83PZr4s/i6NtPEYqd6AYKpLLhqNMw2InjTlbMtZ3S0nV5EM2Mf946xNzNzKDgeur8ajA9LmupWWzD+6cf9svEFD65CK1L0k4Bj7FUNXFLmDM0UNXJ6qG9KLwa9Tn8xTvuKfH6i0GdXAwuvJVSwTPv/lzG2oId7Jy62+KnoIfztBhXo/2GZT6QNUXRPvNSya9Qar+reoFX6neof+7mnSClaRUIpabztas1r2awWWAhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by PAVPR08MB9459.eurprd08.prod.outlook.com (2603:10a6:102:317::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 18 Sep
 2023 11:53:47 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 11:53:47 +0000
Message-ID: <01edf2ac-92f8-f987-6365-52bd53e32891@virtuozzo.com>
Date: Mon, 18 Sep 2023 13:53:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 14/21] parallels: accept multiple clusters in mark_used()
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-17-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-17-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::44) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|PAVPR08MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: bd441aca-c87d-43b9-a7d0-08dbb83deaed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dSaFTVs7HO0h0X4/GfusfEWZHFqNqO2Q+/c7v2J1juafR+MMuoqXSBkCoA5VN4ssvQraLHOxrAwgUu4YTE6py76CbTl8O844vkgc9H41HBCkfxYUt28hwGvTN4snoZBeQJQhwhi7/06GeUBpPmcRZez1bbZo5T8lUTl+jVjhYnQINnssGHJIGrIKOBMLyZxf6ohDgs3c1G+Z46TseJJluAFV9NKGE0qX4XNee98vApDHJFRvxMpsx9oGaCUdcbgKAEmOrFDnDMQqCjxRNsNaYCf6sXaEXyuDeKOOXbIucaCTSB1BvqDjEjGOEA4eoJAxvaYpBjwt5+35rATgGDkSEHwx1cd9Fnw9WiK59uJBc87azXUEs8lXb1yAVbo/YHgV0AIAio2K89WLxocDosHV6mlEwfwmr7g+v1fSNfIQ4t8Zd4y+L09b9ukK+VajH4ij8ulXGO6okmL1lwBtadQ2ZcIC5zL0etzMJiMyp8n/3KYRoDF31oWh6rJhNhKo3pGGqGTnJNRJxDGjqmNV6bxe2587EgKaMxyJ+xoZ1ErhbkdtKd4v4J4t4GQPrfnd8yoym7mFJ0C/ZmKXVv8MtYnxXot6Sa77OKhCKZFuzNlWBRheJVVnQDIOeksigUIiLxuQ3JTtsB3yUjLsIg13yg0Q3fGIF2zlJdltVFWLmvmED4wQ5k8V2ZBCbgDA6a3NUK7/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39850400004)(136003)(396003)(346002)(186009)(1800799009)(451199024)(6506007)(31696002)(5660300002)(8676002)(41300700001)(44832011)(31686004)(66946007)(66556008)(4326008)(316002)(8936002)(66476007)(52116002)(86362001)(26005)(478600001)(36756003)(2616005)(6512007)(53546011)(2906002)(6486002)(83380400001)(6666004)(38100700002)(38350700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1V3Sm5tRERDYi9reWR1b1lhN2U1SGpYcG5zb1NraW5xUlhpMEk0S2VTSW5M?=
 =?utf-8?B?bklod3Eza0pGaXdQMnpJeVF5M0hLQ05SdmJUT3dlL2hVTXJqUXpoWnR5Mkh2?=
 =?utf-8?B?d29rTlN5dDQzZXlNdUQyYlJuSWdGVlZld05TYlErQ0lyY2JjSVByVGNZSVZY?=
 =?utf-8?B?Z3FiUHpNSWRFUmdiMngycStUa2RwOWFtc1ROMkMySGZZYTNCWS9HUk9nYlBR?=
 =?utf-8?B?bEdCaEdYNkhpUmZXYWY4TFZXLzh0anpYMklHVjJzV1grNGVKNEJQelBlOFlM?=
 =?utf-8?B?NDZYa2xUb21DUzMxMWRLY0pYdnIxaTRnTlF2bzdUZ1hZRysvb3pZSGNDVU1S?=
 =?utf-8?B?Z01PNkhnT2xkZDN5bk1CNk1UV3h6d200bXZTbEo5M2hKT3YzVGJGZVdaZEZC?=
 =?utf-8?B?OWwzZjB6NDJIcWdJK25CVzVNTEdDajRhajVYNk4vM1hEa0N1UTNWT0FYSWY5?=
 =?utf-8?B?cjFEMk5KMlAwTHMyNmZ0djNNL2JWN1o2UWgwOTVCaEhkOE9Fa0N5amUxTUkr?=
 =?utf-8?B?U1gvVmV6Y3RZSjFncVpmemxvTVhaMWpidllaeE9CMEdOUXBTd0hwWkJ4Qndo?=
 =?utf-8?B?WjlaYUZRSVR1NHdMZXFOWFlRYWJ3OW11SmxTVHlNTUppeGQxUWNiTTJ3WUpp?=
 =?utf-8?B?NXAwU2VaT3ExYnMxNGJqUVBUKzFuRUFiVXRjRVZQZ1prMmxUdkF0Zkw1RzZC?=
 =?utf-8?B?SEFVWit5VU9SMGdIM25YMURiWUhTZm9YTjFJdm53aS9aKytvQStFZGpIaEQz?=
 =?utf-8?B?RjFLMXNtelppdCtaTDdoV3JRV2NsaDl1N2RocGM2WFhjb3VTYnpXT0FEL1dH?=
 =?utf-8?B?VFlZbjRTbUV0d3Y1eVlzZ3NYcnpMTkd6RVJxVG5pWHp4YVNMMDhxVVNkK1FT?=
 =?utf-8?B?NTR0THE1bFh2YU5qT3FYVEduWWVTWUtTNXo4RVFzSWx4TzBPMkdrNnNXdGJE?=
 =?utf-8?B?dXl4aUFOamFKVXprMFh1WFo1RTFVNklLTHZIMG92UWU0b29pVUkrSFdLcnNN?=
 =?utf-8?B?VWhSZitHUGlvY1prYkwyTEdWYTlkbExIVWR1QzNVZEk1Z1pGM0FuN0NDT3ZL?=
 =?utf-8?B?OFBqYU5FMjVQb0JRZWh5QUdEMmJDN2poSmdjRXAzVUtnZ0IrSXlhT2pXQmVn?=
 =?utf-8?B?bFE3SVoxREZSdTRaQmc3SkZ4bXo0MkRxOEVPTzBWNVQvbCtTeVdTSUxCSUhP?=
 =?utf-8?B?WEFvVjJweUlmZXhXOU9peG1SYTd0K0FVNnlOdWoxR0xuejRIYm5WUzN3bnFR?=
 =?utf-8?B?TlZ1SG9wYU1DZHBxb3ZpdUJEUTJ6ZDJTc3p5cXEyODJyU1ZRd00yc1p5ZHBj?=
 =?utf-8?B?T1MxRk1nZHY0NUJ4VW13dEs2eDNVOXRhZHlNMHQ0Yzc0MzR0Q1BYNjl1Ynk1?=
 =?utf-8?B?RnExbDV0VC9GbWZJeVIzUklJdU1tZFA1VkdmTTlHejcvWUpSN3NUcEVwT2pv?=
 =?utf-8?B?NVkyNW5KOXhDNTRJYm5UNTFKN2k3cmUzZzFQT1FEd01MWjdEMXJWYmlBaGlD?=
 =?utf-8?B?M0ZyZkp2eTduRkJYY1V2NVV1LzhOWklHcnllMlR4WEtTc2FvMCtRWWVCeUxX?=
 =?utf-8?B?ZktZTmdHOVQ5enZ2azdKSUx3Zjl3SkFESzdsemN6eDI0QW1jZWtKcXhvTnVS?=
 =?utf-8?B?SXlCL2h6c2pZWlM0TFhpSzhiUzMvUjVOamtMaHQ2K0x0UUttaFNXeXpqeWNu?=
 =?utf-8?B?WHcvVzlkelZEL0FwYmNCOFNYbS85Vi9WSmxMMGlkbU5iZS9oTXVQc0psdHJ3?=
 =?utf-8?B?V2FGbUt5OHNjOXA3bWJnbEdhNHFML1AvSXNIVlRPVFd3RklKN2o5dU5RaGlL?=
 =?utf-8?B?YlVVSXBlVWlzZHVMNmtxOU8wczZsR3d1cDcwRGVWTk9Za2UyaTE5OWN5TGNU?=
 =?utf-8?B?anplL1dIMUt5TnMxYzI2WlBFS3hrRkxPdS9FMytORGtsdkZ5VWpwdnJWUXo0?=
 =?utf-8?B?aWRKcmwzQ1BtZE1YcUNxajRQa2pQbytPOE82NkJPTEgvV1VacWhmakYvV1cz?=
 =?utf-8?B?TlU3RzRhTHJGemRtTThaNWNoOXhuWno1N1JDMXQvRkJXUEVteEovVDNHcm05?=
 =?utf-8?B?YUR1RzZoaEFmdVZsbGM4VVUrWmg0QVduMGdDK1RvajVKbWJteFpMTThnYTBK?=
 =?utf-8?B?QmdheHZ6d095RWFxNmlLbW8wL3BWL2VWZXlMRTZsUlpkaWgraWsza0Q4Ly9B?=
 =?utf-8?Q?YvtwhNy9ECsRIH/+gCyyV80=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd441aca-c87d-43b9-a7d0-08dbb83deaed
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 11:53:47.7927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5305AsV41xihwNVbDAt0dXAV8ZHkdYyX5xJkX8rh217YckY8Uk5bpURBYaK0TBJ+uzUXlk+LuUiH3Vnj0u0ffZEHsdako5//CkgIlLdV7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9459
Received-SPF: pass client-ip=2a01:111:f400:7e1a::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
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
> This would be useful in the next patch in allocate_clusters(). This
> change would not imply serious performance drawbacks as usually image
> is full of data or are at the end of the bitmap.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 2517f35581..a2ba5a9353 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -178,18 +178,20 @@ static void parallels_set_bat_entry(BDRVParallelsState *s,
>       bitmap_set(s->bat_dirty_bmap, bat_entry_off(index) / s->bat_dirty_block, 1);
>   }
>   
> -static int mark_used(BlockDriverState *bs,
> -                     unsigned long *bitmap, uint32_t bitmap_size, int64_t off)
> +static int mark_used(BlockDriverState *bs, unsigned long *bitmap,
> +                     uint32_t bitmap_size, int64_t off, uint32_t count)
>   {
>       BDRVParallelsState *s = bs->opaque;
>       uint32_t cluster_index = host_cluster_index(s, off);
> -    if (cluster_index >= bitmap_size) {
> +    unsigned long next_used;
> +    if (cluster_index + count > bitmap_size) {
>           return -E2BIG;
>       }
> -    if (test_bit(cluster_index, bitmap)) {
> +    next_used = find_next_bit(bitmap, bitmap_size, cluster_index);
> +    if (next_used < cluster_index + count) {
>           return -EBUSY;
>       }
> -    bitmap_set(bitmap, cluster_index, 1);
> +    bitmap_set(bitmap, cluster_index, count);
>       return 0;
>   }
>   
> @@ -230,7 +232,7 @@ static int parallels_fill_used_bitmap(BlockDriverState *bs)
>               continue;
>           }
>   
> -        err2 = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off);
> +        err2 = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, 1);
>           if (err2 < 0 && err == 0) {
>               err = err2;
>           }
> @@ -732,7 +734,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
>               continue;
>           }
>   
> -        ret = mark_used(bs, bitmap, bitmap_size, host_off);
> +        ret = mark_used(bs, bitmap, bitmap_size, host_off, 1);
>           assert(ret != -E2BIG);
>           if (ret == 0) {
>               continue;
> @@ -792,7 +794,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
>            * considered, and the bitmap size doesn't change. This specifically
>            * means that -E2BIG is OK.
>            */
> -        ret = mark_used(bs, bitmap, bitmap_size, host_off);
> +        ret = mark_used(bs, bitmap, bitmap_size, host_off, 1);
>           if (ret == -EBUSY) {
>               res->check_errors++;
>               goto out_repair_bat;

Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

