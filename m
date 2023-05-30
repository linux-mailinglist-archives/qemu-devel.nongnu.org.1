Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED917158D5
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 10:40:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3utw-0001Cn-Vx; Tue, 30 May 2023 04:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3uts-0001CG-QC
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:40:17 -0400
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3uto-0000I0-QE
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:40:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDYbYgPsMky/Hzkuy56W49VGXSE6pLzRsEmhUdtHJ1ZNiK+6iGWx6+GGj7iVrZcKFhUXu8eNJfnTsbk8/1lFwOtLkPhcGnbli/L/lk61daTL8WRX0shGj130iD/LBtolXf8rgDokAjMoHbIuvH+sR3ygCEBhNxgJ4P/fw1bjakoCPDAszatchhh6E9Y0BjMoCEuS6UjNKYcnteJ9usEGMsiI84d/9Ffx7ovwjH8SJSeJyyvgPyEe8cbw6Se2Xuq5xvzylQhG5zSwVIymG46N+d/XTYbh0x9i4NBO07TMAsGhna/Zap2xBFzPYXOO9P6FNvH3wbf7N6uKmPd75n60xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWcQKUrxNMbrLq8aexChX7CqJgqVGe9jCBYrM3C35hQ=;
 b=f0JIaHOx/zsiV7cfb8npAywEVmX2HPGKBWYYbkdXQQob21cAO8jTSFASUK4ww4WD5ltT8E/xyUvY3bXrL3NosfgRc0msyUfuICj1pPnWYFWSnyBE9m4K95e3usbMv3HUJCPsKMYuwd5OvIAOPKuabDhF/2KZY4UGvuF1AUVLukS2qLd5SwwCckqrkFO4fssiv6RPMZQC+IP0E+mzj5vTFTIWpJKmGzLDf7FdaHmcqoHnugxMtNMYKq81IiQEYEalTCfVLb7DOyvj0AMy2Tjjbv54lA4dp48we+n2UKIrgANPZ1nZokll3ms7V+JnLlYBFC5ylFXnfsoGemXKt0hXvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWcQKUrxNMbrLq8aexChX7CqJgqVGe9jCBYrM3C35hQ=;
 b=RTp343gZ2MQldnAfPU+9UC/Hbr9hvOWXUkfbm4RMM4r0q161V7qPlmntmpkXhQ7KTCqf9fzXc220uWUOfOsxMddvAzXy9VU2jdkMumM3vrJ/FfGYcLj9yjS60NqXL5AC0oM2mZ4Ctj+E7MJpA9iMR1/Gb+BLzpVsPYlnMYEfriRVd1/AuhxKM2AINE1NvVzqStD+dSZnKpZqo5QtYajyZY7gKscNxntXJgHZIz5X4Vh8/d9p+x7eCqKnnEF7q1mvTj41XYQdK/tZg1TBFpxIdKMBveHX1qyLgq2QUOUiI01+rk5i21HcduWMaPXiXSu9DxBehOR/MAvl3CRGpnU9kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 08:39:36 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 08:39:36 +0000
Message-ID: <33c0d0b3-fbe5-9f1a-b3ff-f3e1f25d09a8@nvidia.com>
Date: Tue, 30 May 2023 11:39:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 2/2] hw/vfio: Add nr of dirty pages to
 vfio_get_dirty_bitmap tracepoint
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>
References: <20230529121114.5038-1-joao.m.martins@oracle.com>
 <20230529121114.5038-3-joao.m.martins@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20230529121114.5038-3-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0235.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:372::13) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc1dbfd-23a8-44ee-60f0-08db60e96641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqYtYiGBtBbUYH4mlLprvgf3zP1V/EeTxx/nNByTAgRhAv8RkS+am/AdU2PV8mf9kdUkc6maC1RWYMmbllR6L0apzyl7/v7t7yxhSE18YQwW5P8daBIQBQFiOr9WXCNMBr9n++tPkP+ax3oXz8+dVutIFRdsDq7HlmC4okkUShLhepmV85S3GTsrQx7ccRtnf7u3wBX+cZ+qgplk4f9oO8V+MjOGD9HYG9GamEL6LpdwCtx0VILo0x5d12NS2c3CkqbGeC14hSCpVdMkilO4kOGNw4rXBpJyQtfVYsSZrLrGt89auzxCCKCNfAzTxMNikXcoQgwR6T9X4wDQ5jWMYCUkoSm6kwXBrvwrsVoUpIOfPhI6UuJK+gr88Q+2+C3GmcDJm909QhHDiOGxfRhDzMTEiClxMWEN/VYUJvMHBvo6e8V77a6QLJHRVUpGCy3gAc8vTS5HLJmaAhwJrlYvCvM8kR+KOeMMQrRh55WiJLggpXEK6K1JEE7JBHpJ2mcjwYBzqHn6XuzvUE3kUR8ko0XUIK5GpxweYSmeFDfwOcCTdl+0P8r+MMq/pL29GSI2S3HP1eOxXes/pEPlMf25DGr0yFJFxEu8vRQX4YJPmGjh1NSTui/STjdoXDxfY94pXFOoGaOslIqGc8YSwjea0qUHQTz54EI433v6Sa5BN6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(83380400001)(86362001)(36756003)(66946007)(5660300002)(6666004)(316002)(66476007)(66556008)(4326008)(31696002)(8676002)(8936002)(6486002)(38100700002)(41300700001)(53546011)(54906003)(2616005)(2906002)(6512007)(6506007)(186003)(31686004)(478600001)(26005)(14143004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGhBZUF2V1NrNmJiQXZmV0FxdXg1dzV6RWJqZTFXYjRpclZJN2N0bkdseU96?=
 =?utf-8?B?V1VZVnA5QWN6cll4MWJBcGVxeXJVUkpxeDlqTGNqUTdpQTdQWnU2bDVoVkVU?=
 =?utf-8?B?WFBtelFXK2tqdjVhVFVFeXczZ0VqVzNuU1VQY3NsM3RoQlg5c28vTm9ES0Vz?=
 =?utf-8?B?a2dmM05KS1h4MzVZWkV2bytpZTlxRytDUDNlK3VBd1ZmYVFyYzJTZVRZY0JH?=
 =?utf-8?B?VEg0YXhVR0xXNFZwL3Rhdi80TlNSMHVKZ0Nzek00MjdMY0xZT1FLWUJza1Rk?=
 =?utf-8?B?WDhnNUNhL0ZOTHNURFVLU29qQU9QcGF4SWRGUjJPOGZvTlQvVFIyWjl3K2lR?=
 =?utf-8?B?MTgrRkJOcDh1MVZmaG9td3ZOSU5oK0xWRGNZMTlPU1ZaSHVKcWF0MUpnZmZI?=
 =?utf-8?B?MXRMd1U1ckVkYm54dERKOHhYSWIyZU83RUtoK1JzZmRua2p6VnhtSloya3lL?=
 =?utf-8?B?Q0dhN2RBSWtKQzFxOHBscjUrV2lpMFNZTjk4QllhTkRTNDg5NzFHT25sdnFW?=
 =?utf-8?B?Q0JqT0xGREtES00xYndmNVNQTVoxSUFCQytjYUJ1YTZVRXp6dEFTYU91dGxD?=
 =?utf-8?B?KzQrbGRKeEQvd2lrdExxMmhtRmJINU1iZmtXTlhpcFRhSFhSSGZDeWFlQzFl?=
 =?utf-8?B?OTkvWmEwT3V5Ulo3K1lFY3JBL09RcU9jZXVRYkIvODR6VmhxRHJva0VudUxG?=
 =?utf-8?B?NEk0VFRITjdkaGJIQVFhZnZYdHFiS29oeDBpdjJoWmVrK2Z0R0tZMXQ5VG1F?=
 =?utf-8?B?Wmkva2RRbWFjZEg4eko5OG16c2YxdGg3TndFendaN1FZbDVLZlhpdjU0WWh2?=
 =?utf-8?B?dE1MbEV1TGYyNWZ0b3BXaXZRbVlHd0RrVnlkL1dFSXBtbzNmY3E2QmRNWExC?=
 =?utf-8?B?WTFENEo5cGRFUnhDWm9aYnpFMy85RDFtNXlET2RxSzlLQy8zMXNKanFjUkhh?=
 =?utf-8?B?Q3B2eUdabmJTQWJJa0I5SVloZXFObDVoQjRma0RRUzUwQnJ2cEhPWXFKa0Vo?=
 =?utf-8?B?NGxtOTZvWHJ1Q3NzUXpLSGVIYXd4Vm5ZeW1DZXQraHJ4VSs2MmdqelRNNkM2?=
 =?utf-8?B?ejNjMDk5Qk1Ta1FocU5UMlRtQXR1bUpJZTlBN1ZjZFhSRGVpZk9MKzI1YUxm?=
 =?utf-8?B?a241eDlzUWFtdG1Ec1daU1FSS0NtTDlsK2dFSDlJY1ZDam90QjN6bkxKR3Nr?=
 =?utf-8?B?VFkxVTNOTlpYc0pzZm5hK2hMcGtyR0M4MXlkUG8vQzNlWDFjcU1EUmRDMG0r?=
 =?utf-8?B?aTBzcTM4V1VNSGx1OU0wbFVsOGhZOHZGWEVjdnVYQ1JyakdFNytGQjB4Qy8r?=
 =?utf-8?B?ZEJKbDhnV1Rkc3dQNjdYU2JoVUlDMVQ1NjNyYk1KSEo5M3BaVmtpY1ZlNGxh?=
 =?utf-8?B?RWJ1c216bTkwSEJQVkQ0azAyMFg4REc4ZS9DanZZclJiMXZ0bGo5TmJ3UFZG?=
 =?utf-8?B?c0JrRHp6OE9NZXN3WUJGa2R6UTFocjE4R0drL2xoVG84dXR2Z3ROa1h5Sk5Y?=
 =?utf-8?B?cmZ5ZkQ1cmwwRW5hYXpyV0VPMmJHNFhqUmc3R3dSZXRVRUN1SlQvT3VocURX?=
 =?utf-8?B?c0NmMUUzd2h1TkpkQ1FjOER1TUMxVlNnVmdOYXlMMFZkeTFiaGc5WVdqZm4y?=
 =?utf-8?B?UmNtd3htdnBNN3o1NCtWTGt5MW5yMi9LZ09CWWhlb1htMk5HbUFDbWNPRlBm?=
 =?utf-8?B?SUJZL2c5b2JJUDUzWWRoSW10Nml1Tit4REQzak1xdTlEQTFTV2FFTjBVMzJo?=
 =?utf-8?B?RFdSUC8wVXFqalRoOU5LbStLSUM0ZWk0eVo3bUROYjRhb2dRUnNNMVQzR2FO?=
 =?utf-8?B?REJySXg1RUN5S0xKK0FnaDJCdXJKeTFjQjV3UDQzVXNIbndCU3RTZjVPRkVr?=
 =?utf-8?B?V0dXMGh3aUw3M1lDQ1pRMUg3NFMwMXlKd1oxOE1yVGZVbmxxR1dkbzZsVEZ1?=
 =?utf-8?B?TG82bFYrYXI3VUgvaVZQaEo5WUFORUxnYkswYVBRaHY4SUdzMlRrYlVaS01Q?=
 =?utf-8?B?SnVHbDl4S0V6NGVhL2VUSEh4dDEzQUlyTy9kdE9VNG1aKzU5bE00eTE0Mkpm?=
 =?utf-8?B?N0hXb2Nld1QzeEpEZjJ2bWQ5aGRaRkd6TldtUHpzNUJBbVVuWUZ2OW5OYTda?=
 =?utf-8?Q?aQmXgkGngVtMNGZGz/RyGqVrb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc1dbfd-23a8-44ee-60f0-08db60e96641
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 08:39:36.4335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpCU3B8znJce8pXRtsHaVzt4Fu2kzwSMbojHskSNHt36t5B/yjT350xvfpOOIpWWtdT0l3lZKRlkIkNN6hxaDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590
Received-SPF: softfail client-ip=2a01:111:f400:7eae::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 29/05/2023 15:11, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
Just a nit, maybe subject should be "vfio/common: Add number of dirty 
pages to vfio_get_dirty_bitmap tracepoint".

> Include the number of dirty pages on the vfio_get_dirty_bitmap tracepoint.
> These are fetched from the newly added return value in
> cpu_physical_memory_set_lebitmap().

s/cpu_physical_memory_set_lebitmap()/cpu_physical_memory_set_dirty_lebitmap()

>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   hw/vfio/common.c     | 7 ++++---
>   hw/vfio/trace-events | 2 +-
>   2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 78358ede2764..fa8fd949b1cf 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1747,6 +1747,7 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
>   {
>       bool all_device_dirty_tracking =
>           vfio_devices_all_device_dirty_tracking(container);
> +    uint64_t dirty_pages;
>       VFIOBitmap vbmap;
>       int ret;
>
> @@ -1772,11 +1773,11 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
>           goto out;
>       }
>
> -    cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
> -                                           vbmap.pages);
> +    dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
> +                                                         vbmap.pages);
>
>       trace_vfio_get_dirty_bitmap(container->fd, iova, size, vbmap.size,
> -                                ram_addr);
> +                                ram_addr, dirty_pages);
>   out:
>       g_free(vbmap.bitmap);
>
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 646e42fd27f9..cfb60c354de3 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -120,7 +120,7 @@ vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Devic
>   vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
>   vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
>   vfio_dma_unmap_overflow_workaround(void) ""
> -vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64
> +vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
>   vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
>
>   # platform.c
> --
> 2.39.3
>

