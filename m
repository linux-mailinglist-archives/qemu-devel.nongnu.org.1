Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9597573892D
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 17:31:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBzmq-0002Dt-Vo; Wed, 21 Jun 2023 11:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qBzmo-0002DP-Hc; Wed, 21 Jun 2023 11:30:22 -0400
Received: from mail-db8eur05on20710.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::710]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qBzml-0002w9-C8; Wed, 21 Jun 2023 11:30:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkWUD1KdzHVyRcUfwOzTQ4pdga1/NABXIrR11+5Styz6RPInULMuDyXHh5ucindpLM7T1EFAq9ghrlw+BUDckxEDxQR9VjFBPBdCD8OGVzW6BkMOIXi4ccCsFOImyREIpFyvDk5QSO97huSAp3waFyenlWihz25DixDiuWJHPQTrtd79oQDUVuaJM72ZadwGzKBPu8rgpwEJZhyp6zMD1FCkeVfbVq2Rj6qyKsrGCPGO3/1JFIPn8m/L6XCZMT3WG3DAVsbpN5Jrn+H6DTCATTG3GJgS0+97aXwkzAfD+s7/7jUQtE8QcMYGJ0D/GzzW2WbWz5nj6Xy6YGeeycx51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAMqlF87ghueQrVOoNNwZlKCGTza8ZLodcd37XkCYm4=;
 b=AE29z2QnIeMfARerNW3Jg6vMrav6nvg5+zyG7GMfCw71i4JdQOX1v5/cttp6rk+a4nb0gns18hd8fljjgPJyENtzzWK7I6eKxjlk5FhbQkMHPzwwJfDmeRMXO5OOlha4oLVrHM5QR8wi9CG25PmHTUEYus2n2i5sSJxNyqXdyINpkA3EsF0xt4yz+SlzO7X9DfLdkKestbUUkag/hIb90oy6Sg9VViJCQdpGHMsh3xCaj4jG7KMkyF23aTN63+VUhtcjXgaQ8NEyd5ttTagNpU6vFAJ865Cca94qluguHHdZVCKz5wbfHnx2OVL3zmEF5UsrfuRpwDf51H95Xf6slQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAMqlF87ghueQrVOoNNwZlKCGTza8ZLodcd37XkCYm4=;
 b=b2GN9tub1SJVpfrj/nUi9AtPVZHZYIjVUerEmDG4c+LTa5FT6bPvIKkbOZoPle/uX8jkqtxRzpWn/wTQBCFsYSsnz2vJ/AUHOx1tMju2poOca924qLNELTmNIlqDnL8WfIpO6jIqS0FMAzjRuFYhA6MetzPAI4kIBvEsOB6kgQZE7sTiQs0ptdGuhsjn01K9G8FP7qsalnvQap2eSsfLnBl7mEVNJDlOfOUizoWjaDWRY5thzqc3pcWTec0uP/GdXlgac7PUgy26Y1c4WnQa+HvMnrFLn9WE9p5zham6dGBXc+1lsaztMFtTOUtwePTZbw8gGEapbxgD0IChJnbaKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DB4PR08MB10342.eurprd08.prod.outlook.com (2603:10a6:10:3fe::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 15:30:12 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 15:30:12 +0000
Message-ID: <d0608e82-4b9f-3b1b-64fd-aa4a8be4a8d2@virtuozzo.com>
Date: Wed, 21 Jun 2023 17:30:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 4/5] parallels: Add checking and repairing duplicate
 offsets in BAT
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20230621082010.139195-1-alexander.ivanov@virtuozzo.com>
 <20230621082010.139195-5-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230621082010.139195-5-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DB4PR08MB10342:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c93aa1-40da-4612-4595-08db726c67c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /pae1HA1IgL3h/6spdNyWNFXQv3XW0KOzUJJ/kZfZe4pf8GV8tMkyiW7RwsgrPRPemxXBF4aOvv79dXjJhXauO2pYrYN3MmLn7IUgeLWGXturkvEu40WaHA3AO/JTX8zJVzmirh8Hk/CBCNKwF+n3gt/nFZx+A7Cgq1HazfZvAxN0QGSkCkALnfII60CzPKamO3bwmeYa5dLOHnA+rpYPg70EL5fB8DppbPpSpZ578qlfuCLmC6Ce4+4/TOvc6SCcfx3FaqaFSzwES1lJq3hn3PeZlAhPj8mabBlvgnrZ8qYssCE0Nl+4cuBJYaTYixfLqLzUbWK2HjbXsHlBiom7i+crR5IZQx3guGWnbdlyu+6rpwaax0hL+mBemxQe0MzA+jNcYaWlOtVNdMcAM/MXt3jgRRqLF1ELSr7r3Cjh7GLugZC9lurdmGIrxJrtnV4YJBnWrGAz1+GuVEABs5af800P6EobzN3X2KFV74Ofm/g2NitpqPGyFZcxhnNIS1pRKlErLufrdpRy6+SpDT4UWkwmkHSlK69c+RtHqCdSGyaFq+GNo5PTQPtHMzNkBv7V4I3ZLMQafSQQSxk28r3McPUf4tx0ADanSiA+6mHOj3llit5GELXJWCms6h5xRDX9ZFMZkq9EKUkLKH8LB/ndA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39850400004)(451199021)(66556008)(66476007)(66946007)(4326008)(186003)(2616005)(38100700002)(86362001)(31696002)(53546011)(26005)(6512007)(6506007)(83380400001)(478600001)(36756003)(6486002)(31686004)(8936002)(8676002)(5660300002)(2906002)(316002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VURQcGFKM3YxN2p0Wi96TzF1NjR5SUNyRldnZ2FMSUIrSFZFTGlYMzJSazVU?=
 =?utf-8?B?cFVBT0NDanF5ZnRNZGRIN3Y0aVhsQ0lCOWRMM2E4QjRxVWtlWjNwUW5tQitv?=
 =?utf-8?B?RUhvWVhURUhrT1NkamtlWXJlYlNJdXVYVHdMZXVLZlpvRWt6NmkwVk5WbFlu?=
 =?utf-8?B?bTYwbURJVGhvbkxWQkJsbTVBcmNxR21ySkJ1aExwTVVWOVVTSm1ZcnJYVTgx?=
 =?utf-8?B?WThpeVBBMUlEMGIvRGVvYllpUmNQL0wvV2xPcTJUcHZrSTNBSEljL1RwKzQ2?=
 =?utf-8?B?azNvNSsvMDdKc3JnaEJOVGNySDhNZS95VVhkVkJiTExRVkd5VHBYMktzTEVU?=
 =?utf-8?B?NG0wZUNscEpnSitjVHBwUXRoWk5UeXlEditJRDQrU0UraXdOVUt0bkdya3JT?=
 =?utf-8?B?bUljc3hWYWF4VHpJQ1hQcWN5cGdBaTdTNFkzU3Z2VU81T25DU1YvV0RIVkRO?=
 =?utf-8?B?N1hHWGRyTGxUeDJvR09iSzg4OWtoVUxRQ0dZL1JTbXZHckdjdGJxdjdXSWlX?=
 =?utf-8?B?VnIvekQ3QTZyeGpoVTUxc0lWaTVtUHpUM1FOTVVSR05jQ2JVSXRDbjRzeUVP?=
 =?utf-8?B?ZGJNd1lqdUs5eXdrV1d2aWhtNnRWMmFlWmwvTzJlZkluL2lqWktqbjhJTm10?=
 =?utf-8?B?bGEyVnhrUmwzcUlMUlZJYVB0TmVnaEc1VTQ2TEwwOTJPeHpTdExZRkp2a1RE?=
 =?utf-8?B?QTJoNlhvR0htOGIwb3k1cmtxSlVoR0NvdGxrSFFiUWFkcE10TlByTjlCR2Zk?=
 =?utf-8?B?VVZSRmxWYU03WDVaalo4RWZpWlVHTzUxTFBHNmlxUDJJbkdxMTNwVnFMZHJT?=
 =?utf-8?B?ejAxSTZTMGJteDRQd1ltangyck1Bc0trQnhnOFpTV2xIVldKbFY2bkhQWEN1?=
 =?utf-8?B?S2RqOHBMUmk3SmJ5QzJGTFRndFdTZkFBR0xnaXFSbkRER3F1ZmhlMUtFNkI3?=
 =?utf-8?B?Z1IwVDY3Q0RqV0srK29QM1MrU2JBWHFkMFg2bnNML1p4MFdrOVBEU1NON3lu?=
 =?utf-8?B?T09YSE9YaTEzWDBublAwYkE3ak14RFNqcFFhaFZQeHBBc1hLR2ROUVJxUzhj?=
 =?utf-8?B?Nm9kQ2E1Znkvd2dwRWE3akxlMkplRG0rT21SRHFzeWNYRkdFVFhZaFpJcmhr?=
 =?utf-8?B?R3AwUVp4aWlISmhjMGdRcTFjUTZocDFXZVJab0JGSlJrMTB4ZnkzN01YN09W?=
 =?utf-8?B?bUFWdVplais2U1hsdFh3K2dRVStuVTlXTE1Idk5DOEVTQjFlcFE4dFVCQXlz?=
 =?utf-8?B?QUZjWFdUMlUyVDlOSWs2enpSMnBYcFFVcmVSTSt2cFd1MElMM1g5aTkxeks1?=
 =?utf-8?B?UVJKUlk1ejF4VDIwcEs4VTRKbUhweUI4SGZjRjY4Ylk4ZURCWGsxZEtnajB2?=
 =?utf-8?B?cStRVWY2VWg2UmxtWXdkMWVUckpvV1lJcG1UT0tFVkZOVFdRRWYrZEV2SFFq?=
 =?utf-8?B?ckp5R3FiMUpSQktPNUF4NWlXbHRYb3lkUEdLTzN6SnJUYlRwdmdaYjNtYjMv?=
 =?utf-8?B?UkNhYTFOYmFoa3VPMzQyTmx3VjJ0TkZoNDNOdmxlS0g2VDU1dU1KaXkxdWtP?=
 =?utf-8?B?MHNoRlJVUnU1ZGJIRUNFNlpOU1BqNzhWNFhPa0JuRlNtMVlQWTNPbjgvQXlL?=
 =?utf-8?B?My9YNzRmV0hFK0VCOTB0a3JvTWJBTjJwR0ZOOWVWUStrY1U3cHhwTGQ4UFda?=
 =?utf-8?B?dmZCdTBTdkxNYTlPWHpxTlFFbUZUUHNzbWR6ZlNXcXZ2SWxucHQvdExRcXND?=
 =?utf-8?B?R3NUaUlBalJTR1lkWm5OMFE1SVlIRmlxNFZ0RHFuWUUyNlVldFdCMFdIZ1ZD?=
 =?utf-8?B?aEZOS0JqL2t4V1ZNNkI2QVNITFFKanNmdS9sOVFCY1N2YUZWNklmMDhnNmJF?=
 =?utf-8?B?ZitTSTBTUGdzMXNKcU13K1I5ZVVYb29hNEpUUVJwb3BSRC9xR2dUbFl2WEk5?=
 =?utf-8?B?QWhzcWRrVGprQWhqbWpjVW4rNXJ4SnNmY2d3cWRINXdjQTIwWVI0NTRwRXQx?=
 =?utf-8?B?SjVFQU9pQkpQU3RDSXM3OGxaSlp2QW1LQkxEbkdkdndYTTBQMWp2TFFVYTRE?=
 =?utf-8?B?Q2FTeHNuMWZsYko4SlJpdHBXSjdSNFBRMWZzaHhxUENoNjNRdndrVmZTRGFq?=
 =?utf-8?Q?VBEHhG/XamCNohNeIYS5gtlA9?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c93aa1-40da-4612-4595-08db726c67c4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 15:30:12.7473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtaMD0cIddOjz5TLrKuSjcMkxmrs2mgxbh4Zwj4SgVw83BZ++TeTrWeSuB7jykoJCmatcKtrMbBJBtdSuC59pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB10342
Received-SPF: pass client-ip=2a01:111:f400:7e1a::710;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/21/23 10:20, Alexander Ivanov wrote:
> Cluster offsets must be unique among all the BAT entries. Find duplicate
> offsets in the BAT and fix it by copying the content of the relevant
> cluster to a newly allocated cluster and set the new cluster offset to the
> duplicated entry.
>
> Add host_cluster_index() helper to deduplicate the code.
>
> When new clusters are allocated, the file size increases by 128 Mb. Call
> parallels_check_leak() to fix this leak.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 142 insertions(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 78a34bd667..d507fe7d90 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -136,6 +136,12 @@ static int cluster_remainder(BDRVParallelsState *s, int64_t sector_num,
>       return MIN(nb_sectors, ret);
>   }
>   
> +static uint32_t host_cluster_index(BDRVParallelsState *s, int64_t off)
> +{
> +    off -= le32_to_cpu(s->header->data_off) << BDRV_SECTOR_BITS;
According to parallels_open()
     s->data_end = le32_to_cpu(ph.data_off);
     if (s->data_end == 0) {
         s->data_end = ROUND_UP(bat_entry_off(s->bat_size), 
BDRV_SECTOR_SIZE);
     }
     if (s->data_end < s->header_size) {
         /* there is not enough unused space to fit to block align 
between BAT
            and actual data. We can't avoid read-modify-write... */
         s->header_size = size;
     }
data_off can be 0. In that case the logic of conversion of
host offset is incorrect.

This does not break THIS code, but by the name of this
helper further code reuse could lead to mistakes in some
cases.

Side note. This function could result in a bitmap which would
be shorter by 1 if file length is not cluster aligned. There are
no such checks.

Side note2. It would be nice to validate data_off in advance
as follows from the specification. In all cases data_off should
be greater than bat_entry_off(s->bat_size) if non-zero.

   48 - 51:    data_off
               An offset, in sectors, from the start of the file to the 
start of
               the data area.

               For "WithoutFreeSpace" images:
               - If data_off is zero, the offset is calculated as the 
end of BAT
                 table plus some padding to ensure sector size alignment.
               - If data_off is non-zero, the offset should be aligned 
to sector
                 size. However it is recommended to align it to cluster 
size for
                 newly created images.

               For "WithouFreSpacExt" images:
               data_off must be non-zero and aligned to cluster size.

> +    return off / s->cluster_size;
> +}
> +
>   static int64_t block_status(BDRVParallelsState *s, int64_t sector_num,
>                               int nb_sectors, int *pnum)
>   {
> @@ -528,6 +534,137 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
>       return 0;
>   }
>   
> +static int parallels_check_duplicate(BlockDriverState *bs,
> +                                     BdrvCheckResult *res,
> +                                     BdrvCheckMode fix)
> +{
> +    BDRVParallelsState *s = bs->opaque;
> +    int64_t off, sector;
> +    unsigned long *bitmap;
> +    uint32_t i, bitmap_size, cluster_index, old_offset;
> +    int n, ret = 0;
> +    uint64_t *buf = NULL;
> +    bool fixed = false;
> +
> +    /*
> +     * Create a bitmap of used clusters.
> +     * If a bit is set, there is a BAT entry pointing to this cluster.
> +     * Loop through the BAT entries, check bits relevant to an entry offset.
> +     * If bit is set, this entry is duplicated. Otherwise set the bit.
> +     *
> +     * We shouldn't worry about newly allocated clusters outside the image
> +     * because they are created higher then any existing cluster pointed by
> +     * a BAT entry.
> +     */
> +    bitmap_size = host_cluster_index(s, res->image_end_offset);
> +    if (bitmap_size == 0) {
> +        return 0;
> +    }
> +
> +    bitmap = bitmap_new(bitmap_size);
> +
> +    buf = qemu_blockalign(bs, s->cluster_size);
> +
> +    for (i = 0; i < s->bat_size; i++) {
> +        off = bat2sect(s, i) << BDRV_SECTOR_BITS;
> +        if (off == 0) {
> +            continue;
> +        }
> +
> +        cluster_index = host_cluster_index(s, off);
> +        assert(cluster_index < bitmap_size);
> +        if (test_bit(cluster_index, bitmap)) {
I would prefer to revert this if and next one and have a code like

if (test_bit(cluster_index, bitmap)) {
    
    bitmap_set(bitmap, cluster_index, 1);
    continue;
}
....
if (!(fix & BDRV_FIX_ERRORS)) {
    continue;
}

> +            /* this cluster duplicates another one */
> +            fprintf(stderr,
> +                    "%s duplicate offset in BAT entry %u\n",
> +                    fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i);
> +
> +            res->corruptions++;
> +
> +            if (fix & BDRV_FIX_ERRORS) {
> +                /*
> +                 * Reset the entry and allocate a new cluster
> +                 * for the relevant guest offset. In this way we let
> +                 * the lower layer to place the new cluster properly.
> +                 * Copy the original cluster to the allocated one.
> +                 * But before save the old offset value for repairing
> +                 * if we have an error.
> +                 */
> +                old_offset = le32_to_cpu(s->bat_bitmap[i]);
> +                parallels_set_bat_entry(s, i, 0);
> +
> +                ret = bdrv_co_pread(bs->file, off, s->cluster_size, buf, 0);
> +                if (ret < 0) {
> +                    res->check_errors++;
> +                    goto out_repare_bat;
> +                }
> +
> +                sector = i * (int64_t)s->tracks;
This is somehow counter intuitive. I vole for
     sector  = (i * s->cluster_size) >> BDRV_SECTOR_BITS;
This would be transparent for the rest of the code.

Anyway, we use tracks in other places. The question is
just about readability. I would not insist too much :)

> +                sector = allocate_clusters(bs, sector, s->tracks, &n);
It is better to avoid such code. There are "guest_sector" and "host_sector".
I would say that they should not be mixed. It is too dangerous.

Actually the same applies to the 'off' variable.

> +                if (sector < 0) {
> +                    res->check_errors++;
> +                    ret = sector;
> +                    goto out_repare_bat;
repair

> +                }
> +                off = sector << BDRV_SECTOR_BITS;
> +
> +                ret = bdrv_co_pwrite(bs->file, off, s->cluster_size, buf, 0);
> +                if (ret < 0) {
> +                    res->check_errors++;
> +                    goto out_repare_bat;
> +                }
> +
> +                if (off + s->cluster_size > res->image_end_offset) {
> +                    res->image_end_offset = off + s->cluster_size;
> +                }
> +
> +                /*
> +                 * In the future allocate_cluster() will reuse holed offsets
> +                 * inside the image. Keep the used clusters bitmap content
> +                 * consistent for the new allocated clusters too.
> +                 *
> +                 * Note, clusters allocated outside the current image are not
> +                 * considered, and the bitmap size doesn't change.
> +                 */
> +                cluster_index = host_cluster_index(s, off);
> +                if (cluster_index < bitmap_size) {
> +                    bitmap_set(bitmap, cluster_index, 1);
> +                }
> +
> +                fixed = true;
> +                res->corruptions_fixed++;
> +            }
> +        } else {
> +            bitmap_set(bitmap, cluster_index, 1);
> +        }
> +    }
> +
> +    if (fixed) {
> +        /*
> +         * When new clusters are allocated, the file size increases by
> +         * 128 Mb. We need to truncate the file to the right size. Let
> +         * the leak fix code make its job without res changing.
> +         */
> +        ret = parallels_check_leak(bs, res, fix, false);
> +        if (ret < 0) {
> +            goto out;
> +        }
> +    }
> +    goto out;
> +
> +/*
> + * We can get here only from places where index and old_offset have
> + * meaningful values.
> + */
> +out_repare_bat:
> +    s->bat_bitmap[i] = cpu_to_le32(old_offset);
it would be better to move out_repare_bat: below return to get jumps on 
error path only.
> +
> +out:
> +    g_free(buf);
> +    g_free(bitmap);
> +    return ret;
> +}
> +
>   static void parallels_collect_statistics(BlockDriverState *bs,
>                                            BdrvCheckResult *res,
>                                            BdrvCheckMode fix)
> @@ -579,6 +716,11 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
>               return ret;
>           }
>   
> +        ret = parallels_check_duplicate(bs, res, fix);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
>           parallels_collect_statistics(bs, res, fix);
>       }
>   


