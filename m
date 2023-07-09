Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E34A074C587
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 17:17:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIW8P-0007B5-4Q; Sun, 09 Jul 2023 11:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qIW8I-00077z-My
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 11:15:31 -0400
Received: from mail-sn1nam02on2076.outbound.protection.outlook.com
 ([40.107.96.76] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qIW8G-0008Gr-K2
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 11:15:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SI7tIt6wcoJ5Z2/j/tFXfTspO8mWUpiKu2PXJ5dyN3dW56RSTf116PuKqhgGqCqi+NrwXbPfKMZYLsIR6gviODzj1nrWBzqTkDaZQzFwwxQGR9VaDYIU+czjwJcZuKVTw1H5V1IxFy0YjCjzilwmZj6wX2trZMIu3I9mKar+7Ben58Ha9j7xlbzIPX6TJ3GltkzIz4J3LNpQVazUifyS7BIpi1vfxinQRa52WtDumYYhv7PITr3+/KVN/U+MKzttvfOUgh38UFgSd+S/Z1IYffFe1PY6ORPxYUdrW8BV9nd6As2TFKaXsKOMj2YaiDN/vU4/I3MbCy/b9vI+II8aIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpyLZhJwTEzAeVH39wHkNT4NpqwhYqD7izkbVN8GWVs=;
 b=Yl60DHscwXdvqLkjOZAnD24ehCRTXo6Bn5v4vW5bthMuoRM4MsQC3XBp/oeEcR2CbfY7WPspPicusa7aF56i2IepZq/431BWgz4lUH7fIalFmSDF4prpwh7sLnd+L4LUeUljDUb6ABk5kNsBld0rjtFYZ7eUEwmL8+GrYeJbcSMu/Ei4jZcjHJXkg2JbjH13S8LmG7dI+ldVY8g70A0DNw3uZ0KMk20RI9XIkKBjY9H1yIAJEk4wzV0oymySj7S75Z1e0kAPCzlzhNZXh1wuUltDRJwl04Zej2QbCbuexPvpTUj6j/EdqD+gclWQE6/Gqiqcv8SHiEpXhFhMXIqINw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpyLZhJwTEzAeVH39wHkNT4NpqwhYqD7izkbVN8GWVs=;
 b=i7NMx/KvDVmi64h0EQhkv3ndmwYDZzf0WVP7+GoQfkVXMY/WrIOpDBErArStkVueXN38ld0Vr+cLllTXSZlZpQ3qwdhUhuf4cURGexb4+pXB556LkrKa5/5KdheJaGHy1NfTDYPHuzI6N6LJ5D55hAo3mbb28/8qL94dhBhedM0csRkJhC7DXC/MOmqRhg6voTswB8fVVKKCslbeYR3qD0a7ol5OtrBWm8wPqZnYKNN1jfACiXbb5tdHUtnuveu+FAOzBPn0so3ZXJ+asQTTE54FiX3jtrsv3OF4qBfQPRykYmxl6+ROGoxncOZvRcBbTrMqEh4oH+sfaLgpxxrwhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM6PR12MB4561.namprd12.prod.outlook.com (2603:10b6:5:2ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.29; Sun, 9 Jul
 2023 15:10:23 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b%6]) with mapi id 15.20.6565.026; Sun, 9 Jul 2023
 15:10:22 +0000
Message-ID: <a9702678-496e-8519-8280-ae003440829e@nvidia.com>
Date: Sun, 9 Jul 2023 18:10:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 07/15] vfio/common: Track whether DMA Translation is
 enabled on the vIOMMU
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Gunthorpe <jgg@nvidia.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-8-joao.m.martins@oracle.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20230622214845.3980-8-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::6) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DM6PR12MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: 049f368d-79bd-40d8-10a7-08db808e9da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T3mS89dGZpTdDcn/2bvTAQrhtSiYp4uwOh91nMB8FLpWb1YkHCXNQSUeVLjY+zItuIR1tloCkTZexK4vLM+g70IKkWlH97dGHYHUZeTipYEMbRlpw3Q5fZVGvosudpSjcB5UIeNOot/aHqjreerCxQ9Zgfzrf82zComwyB1bqVxHHAbXketZ5NF+Sc3P/7v8GxUU76D678q67XiYBBM1wCdh9emlzTJFwp+WNCcd1Bdvao76krON74a0dqOshurRjeO4KRHWpbJ5mdYZEVPAZYtqbdxltNnsVj61jTYOIAnboDiVC/vyTR62qmHSLCfbDbyWnRJ9YChZd7OVLOs/OxWmk1AqQMOgFRODiQAOpfjtPNYs5ln1ypbw7Asi0QJO1KlVsUUz9XsZoDEdZIxpuiVf1IroXTvt2u8lUVKxiwZdw7KB0Gm4lwzH4DAmA/Z6WXjgnW2bjtRBpClcVKvGw+YUFRARrN/iVDLZ1UuCsKMJVhuvtiPP4+XLQTjO9rMJKVFPI1cDp0XSEk7qmZjPOiFtHedqDCbzBW0Uek8Wh0YH7ekfTyoRMUX7bWFL0vRUbcw6LS6achS2iZKS57bYIPha8YVrThfkXPq1/lDKFsg2PPrnhqlXBRqg9IoC+6M931w6gjrUTz9zox9yOEglhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199021)(86362001)(31696002)(38100700002)(31686004)(36756003)(6666004)(6486002)(54906003)(107886003)(6506007)(53546011)(26005)(186003)(6512007)(2616005)(7416002)(2906002)(66556008)(316002)(478600001)(66946007)(8676002)(8936002)(66476007)(5660300002)(83380400001)(4326008)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1VCdTdqMzNIcytHZFN2QXhuV3p5UE5XN1gyTy9IVFFwVE1uQkFHTDZzR1NH?=
 =?utf-8?B?UDBQSzV3UFlsWC9aKzRvbDVFL25QRHhGTGt1MVUxMWVxc0EwZmhIK3VNSTJ0?=
 =?utf-8?B?akZ5ZTJ4VXROWndBOUpidmlyMmVaNTZyS0lVeWhEcjhpQmRWMWYvcXd2VWwz?=
 =?utf-8?B?WEdGRnhiVmtlVlVUTlFQU0w5NHNjM0VLcmdCUXdDdUtWMEhtSVMvckRkTXVX?=
 =?utf-8?B?UDE0NkdLd2w3VTFwbm91YjlBSGM4RW5IR2hKZFJZa0JQL21nUkkvTWRHbC9a?=
 =?utf-8?B?b2FRK28xMWd1ZXhRQzhlNkJWRGhLUWYvNFFxelVzSnF2UVJNbnA0YkRaekxW?=
 =?utf-8?B?aHlYZE16UUYvMEFDVUZoa1dEeWRHbzR4bUNhYVdwVlNYOUZ6ZVRlSWVudHNN?=
 =?utf-8?B?eFE0c0FwbHl4N2F1UVhHVDZjUHNoNjFiWXNKeENZMG9ibDdpUUNRZm5mQzFn?=
 =?utf-8?B?MWF4WjJOdkJ4clRhNktCWG9idytSQ3NDV2hLWkVmS0RHUEhDNEsrUE1sbEc1?=
 =?utf-8?B?Mmt2NEtyL0R4S0l1bW5zVFhJcUNSYmZLV0I3cENQQkNTNGxYN3VKUW9BVjkx?=
 =?utf-8?B?SURjcWNLN2ZycDZQZC9JT0pXNWlnZDFtRU9kQytvRGhvZm9SK3JWUzdYcHdQ?=
 =?utf-8?B?aHQxTXBYTzdZajA3QWF3Z2NWUUtkSE81VXlza0JxTElJSUJ1eXBqd01zRWpZ?=
 =?utf-8?B?SUJ0QjZ5bnNZem1LZGljazM2OFdMbmkxUDk0MGFkd0FxWXNpSUp1Z3lydEdz?=
 =?utf-8?B?SFhGcEF5VGh6K1ZVeDdFVTFLaXErRXB3eVVzNEIrNm1iQWd1SGJRM051UWM4?=
 =?utf-8?B?N0lxd3RobFgxd05IRlZ1bllrald0UlpaQWg3ZzF0OTl4WXZkVTN3WURLZU11?=
 =?utf-8?B?L2R5d2N6eStkcnBRZXV0U0ZueG44dTMvWldHWGYyQ2ZHY3haYmFaRUdRdVRS?=
 =?utf-8?B?UklraTQ3eXBwWWYyb3VpMmF2bkJWdDFpcEFMU1AzRmlTMG4rRXEwcklUNUoz?=
 =?utf-8?B?a2NKRXZUS3BTc2xmOTlCeWR2OGsxUWJVbis0cXJDVUtkSUZtOU1vUVpaOFJK?=
 =?utf-8?B?c1Zub1pSZkZaVnBUQ202ZGJGVmR5VURSWVZoRmE0VlE1RTJxNTRYeGlKUG9L?=
 =?utf-8?B?dW9veVBoU2RETzN5bUlYd1h5aFVxQjNiUGVrL04wb0JpTGl6Z0x5OUJTL1Rj?=
 =?utf-8?B?YlJhMmloOEY1Rk9oQ3A1aU0wYkxDcitrdU0yU25GTXZJUi9oZkM3cHdpanNh?=
 =?utf-8?B?ZE5seXlQY3h6bFZjaWNmdktOVXVNYVVVRFR1dFVBM1o0WjBEN2tOZ09XZU1s?=
 =?utf-8?B?OURxK3hoTWNjZFNrd1FGaGdTeXJGc0V0M0p2cmNPakFyMHBpbnVTMmVVeFp1?=
 =?utf-8?B?OS9hWllGUVFvVW9hR3pJZWxaZWtDbU1XV1kyR2dwWU1xdmV0dE1yUDlnVUlk?=
 =?utf-8?B?RmU0RFl4NHNmR2tXczQyVGpwWTc2dFBJb0VPejJ0OTh4NFNOaVBRRUJ6bmpQ?=
 =?utf-8?B?UnFwdUhPNFZJTzZ3Q2JTd1MzWWdiL1I2WU1Sb3orZis1YXhJRlhFaXRXaDZ5?=
 =?utf-8?B?VzZ3MGtqejFrM25weEhPQmhDblhydDZYbnBGNFdnS2NaUzlNZllleWpBVUt6?=
 =?utf-8?B?TkRrTHMxOGQ2NDRYeGRSRVZWQ2owd1M5UUhMVTFBeC9McmhDd09pTlduK3dx?=
 =?utf-8?B?M3ZmSUNBTXVrYTdOZ3Z6NHBnRE1yd2xIM0RseGN4ZGE0Nkg2QmQvRWJBYlhF?=
 =?utf-8?B?VUc3UVNSNmw0VStuT2NaRWlTaEp5QTlLOUdML0tSZytQVU94eFRJZXhsOUdD?=
 =?utf-8?B?dnpRSUZOYTdnVEtLOUlwUmtuZDE2Y0RJdndYTzJlWk00Z0JwWFppYjIvRVYr?=
 =?utf-8?B?NGJ5VURvdmZlTDJ5cUdFN2F6Rk54NVU5dVNkMDlJR21teHZIWm9TY1lzZ0Z0?=
 =?utf-8?B?T0Rkd1EvcmpMaHcwcmdiWEFGR0RBd045Tmt6dlJ5M2h0cm9FcWEyWEhKSnR3?=
 =?utf-8?B?MVZQclRFUUpuY0FRbXNFYlQvVXJ4YmRCcmxnalQyVVo2UHpndFlEUTNueFFG?=
 =?utf-8?B?anoxZVd3Y0VqOFhQY0hLQks0NEdqSm5lOU1lcnY2azRhQ0R0VVJTN3lCUFN2?=
 =?utf-8?Q?EZY1qxmeaC2Bpgrbf8wc2+H6N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049f368d-79bd-40d8-10a7-08db808e9da5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2023 15:10:22.4239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EBMpNj/IFX8fbiW1bLPM08qTbhGflnJJh6R0ct48QCh057v7ycfCHaAB1yeppJDfQ1kY8aFXhwW1nrQ7wYunQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4561
Received-SPF: softfail client-ip=40.107.96.76; envelope-from=avihaih@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


On 23/06/2023 0:48, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> vfio_get_group() allocates and fills the group/container/space on
> success which will store the AddressSpace inside the VFIOSpace struct.
> Use the newly added pci_device_iommu_get_attr() to see if DMA
> translation is enabled or not. Assume that by default it is enabled.
>
> Today, this means only intel-iommu supports it.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   include/hw/vfio/vfio-common.h |  1 +
>   hw/vfio/pci.c                 | 15 ++++++++++++++-
>   2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index eed244f25f34..f41860988d6b 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -70,6 +70,7 @@ typedef struct VFIOMigration {
>
>   typedef struct VFIOAddressSpace {
>       AddressSpace *as;
> +    bool no_dma_translation;

I find this negation a bit confusing, especially when below local 
variable is "dma_translation" (there is also double negation in next patch).
Maybe rename to "dma_translation" or "have_dma_translation"?

Thanks.

>       QLIST_HEAD(, VFIOContainer) containers;
>       QLIST_ENTRY(VFIOAddressSpace) list;
>   } VFIOAddressSpace;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 73874a94de12..8a98e6ffc480 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2900,6 +2900,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       VFIOPCIDevice *vdev = VFIO_PCI(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       VFIODevice *vbasedev_iter;
> +    VFIOAddressSpace *space;
>       VFIOGroup *group;
>       char *tmp, *subsys, group_path[PATH_MAX], *group_name;
>       Error *err = NULL;
> @@ -2907,7 +2908,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       struct stat st;
>       int groupid;
>       int i, ret;
> -    bool is_mdev;
> +    bool is_mdev, dma_translation;
>       char uuid[UUID_FMT_LEN];
>       char *name;
>
> @@ -2961,6 +2962,18 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>           goto error;
>       }
>
> +    space = group->container->space;
> +
> +    /*
> +     * Support for toggling DMA translation is optional.
> +     * By default, DMA translation is assumed to be enabled i.e.
> +     * space::no_dma_translation is 0.
> +     */
> +    dma_translation = true;
> +    pci_device_iommu_get_attr(pdev, IOMMU_ATTR_DMA_TRANSLATION,
> +                              &dma_translation);
> +    space->no_dma_translation = !dma_translation;
> +
>       QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
>           if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
>               error_setg(errp, "device is already attached");
> --
> 2.17.2
>

