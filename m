Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D25A74C612
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 17:25:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIWH1-0001D2-W6; Sun, 09 Jul 2023 11:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qIWH0-0001Ct-EO
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 11:24:30 -0400
Received: from mail-co1nam11on2062b.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::62b]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qIWGy-0002XP-98
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 11:24:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGJmpp46iD51c1E5fF0n9e1E5/xRSdOl1mmV2NPzZ+yNBEpu5qlR7OLzis+d6HccMjLlsodsmqDxAi7M0ZPM1ybOEJIMoXNFQDHOJwFAuB1+K1rGSJ6Arg5XPT7z0Pb3u1oq29SFFikn+a/AZBlRaORzQkH93KAC/D3iWfsZb8yJxq4aBOzAES+uRXCOMvWXa2bZMeYhVbYv0SExvpeUxG7qIZ6PbcnznBVgsEXQRpdKLPI9rjtR5FyGT2NGnrz7+B8+wKgliqYB1rHKdvhLZUZGM3ooCBxzxMa5pKqmWP4kRMKM3fXkiri8oKs0i86wGH5kZ7nJ7X5T4chJEC+43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhzjk3bL4V9qvlyhLP3kLzz5OsLgmJAj6rDhmMmxSeM=;
 b=KYNe2UIs7uDYBF8axjZJB0EsEYGf6DhmrzyIk8p1FG+SJHYRw1Qg2hsVZBNlHWAufjM8v9OaqEnqWhweq1/vwsSQkSztcnjXbzK32hiakieRCvnkU42S4lUrPhi3e6jNv4H1+rmMT5yvX/Nqc58O0PwAagMXKsp/yKCgRCq1D8VEiB1tlJRW/tFxNpoxtfgI0uuJuoZOdzlPrrgA0vxYoNoCiJdj3gPZ8NgMESQnOx7chBdvXKSOq3Q6eSHgX2PVSE52jc7WW6EScHLoe5C3lkxDWk2Q+4lqIPBZ58HXD4eOc+fP7MBTEYcwO5e1pgFH7Kewueu5vr5+R5NIMPoScw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhzjk3bL4V9qvlyhLP3kLzz5OsLgmJAj6rDhmMmxSeM=;
 b=sP5KTedM1NW+hdJKfm3wCp35I6PKSQLzdISSUdKHyDYmDiLenVuu5zIS/3CwRatfet/3qHYlVTzFu9dm+yxKUcbxkaGV76h3H/SVXTPXOonkzRxVSnyoAGsgDm00mBs7e/sCCo287OHXs89jWznst6RqHiJbaINko+zOTeZexIw5IasS/nLb7hO3icADj67kuhVSpl0a4izW56UtD7E1AXqlltAJ8LOJxFIlQURehOVyChygYbEXwnLfxUJlIw4KCiBUMpQy+Lf4AqgtLxu96mkOCePqzgrQTY4ANhBE3KhnDEvYam+dBbuySqEFLzk15ZUtMP5JRODS7LwEl/MWjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sun, 9 Jul
 2023 15:24:23 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b%6]) with mapi id 15.20.6565.026; Sun, 9 Jul 2023
 15:24:23 +0000
Message-ID: <3dd304a7-3ec2-9e6d-1916-adfbb0c417b6@nvidia.com>
Date: Sun, 9 Jul 2023 18:24:15 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 12/15] vfio/common: Support device dirty page tracking
 with vIOMMU
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
 <20230622214845.3980-13-joao.m.martins@oracle.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20230622214845.3980-13-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::15) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: 616ec27c-d69d-487a-f286-08db809092ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bUL6MZQA7kkLo4Fv3woVzr2kvRZJqw27FzGsbe3gCA0aqLKVj5WxA8PVu8PMPdzSBbSFSKN3L+hs0z6Cm3k5mj93byDEPEEOAPzaPgWLCR2NSccu3OrK4ZfST4BbKZ62AclxhEci4chYpjxUvXqynpgSRiZDcQGAYGLMaNgBd80lhdvbsHaFSop0XRkE8LgLvAwxAt3DL9eG86wHNtDhqXZ+j9DTAgqatqLLFXz65DkfnHwUWa+Gwx8lR5XqFcXKOIfauC2J6bpmmfev5pW984QrOi8NM1Xeuslr1Kv9/8fKQGLblEc3C/ghn37FPXjT7EcbltfbqcNVY1mjPn96W9Lv2WsgpEFrbgHMAWtD82jANkLrAVFnRPElff//ww7IASvnBFRt8DPVsoAc/8iNuk64kwWfAKt8lwuhMqFB2zM/p/hgcduK+zpXZx5JcbAbFI+RdtKyFJVWj+h2ozlzwfzy8btsQuJCMgbv7qCwjxtkHuYz9VfWqgpMTnkYhJslIN5aOezqG1Xtpjlq18JwU74wyApFJ8MdImZ8krncti2oIq5wCRYvtdfR1AslcnzAaYE9cPBt0TEdFXivnoZxUEt29exVdzhrtwWeeXX9j2RwURGcN1hgLsJyux88YWTe/C5DtL/WaAWHEK2ShzMZ5vG4iiJpudPN2HFTLgeNR50=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199021)(31686004)(2906002)(7416002)(5660300002)(31696002)(86362001)(2616005)(8676002)(54906003)(8936002)(66556008)(478600001)(6666004)(36756003)(53546011)(26005)(6486002)(6506007)(6512007)(186003)(107886003)(38100700002)(83380400001)(4326008)(66476007)(316002)(66946007)(41300700001)(14143004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1JDOE5hTzNBbUc5VXJxV2d6RUVaWjFjMmZzeE9YNXovWEI2cUNyMEdGcmNl?=
 =?utf-8?B?OVFCTFdTWkF1Q01ZdnNKY085d3NaaTNZY1VWYUxUeGwzZkpKakRXTkErRnZT?=
 =?utf-8?B?YXZYcmMzNWxCZ1QxbmovY2JtS2FlTlNNVUhEK1Fubm9WQXBjTlNkLy9pelVi?=
 =?utf-8?B?RDRkRHhJOXJRNEtWaDdMNnY4ZVk2TCtsZlRlSlFwUDNSdnVKL2NUdnhnWm1Y?=
 =?utf-8?B?QVZiYTl3RC9XM0lHelRPditmSmNHT2VpNHV2bCt5OXVmVlMyNVNUMlZRbmNN?=
 =?utf-8?B?ZEJrcGlYdHdVbE00allkUEVTRGJ6czdRMkg2clJ1dFlTRlprZVF0L3o2aUcx?=
 =?utf-8?B?SWdaaFFVKy9hdFA0bWJZRnBJaXV1b1c5amcveTFWNmxsN2VrMDZqUEdJYlRx?=
 =?utf-8?B?TlRQeHd0TGZKV3pRVG41MzZidkJwbDFtQW9SMkhRSUxVTER0dHdVZ0I2d0dC?=
 =?utf-8?B?RFB2Y1BZYW1vMlJJbjJRVCtDQmdTbXJyaTVBbXloZGFObmpmOHRMM0o3bzF2?=
 =?utf-8?B?V3NWTndkRkVNeUVPbG8wVGFSc1FCOUF4Vjc4dTcyajJFT0VBWVR2K1Yvbkta?=
 =?utf-8?B?Tkp1MHFxYWNXZ3N0QjBRNm94MDY0bHRvRFdBUmNBK2dIbWQyZVJIbzg4dFFu?=
 =?utf-8?B?M0hSSFVvVTUzNi9yM2JMZUtoME42RG9JazJmblBha1pUMzNaemlOc1VYUndN?=
 =?utf-8?B?MGtmN3dUSWhJc1pXKzBNeC9hL0swR2w2cGc4a01CbzZHTkVFcHU0aXhjbFJh?=
 =?utf-8?B?cVJnbjRHUFVlRXU3bDVMeXpwMHlnanRmbFEzcUFxbTd6ek15eHZSQmhuWllN?=
 =?utf-8?B?ZFowbU9YdUhTdnhtOG1jU0cyOXB2TFlPOFVlQktVZmhFNG16TmkycWxPU2R2?=
 =?utf-8?B?c2RxT2h3MXVqOVo5Y1dDZVZFNmE2eWQybUNKTUtJV0ZSeXpKV1gycm9xeWx5?=
 =?utf-8?B?OHNycGZZRjh3aWs3UFNyMEJnSFFwd0UwcEw1eHJ1aENaRUltclFaUDMvaXR5?=
 =?utf-8?B?RjI4ZGp6UHlMNVdnejFSL0RWL05qRC9PRUUvMW52ZHZHY2lGdFFkZHB5d0Uy?=
 =?utf-8?B?OUhaQ3lCMVVzMW0zaTBGaHN6aDZPbjFFNXJBcnhidTlOM3o2aFZ5bjVOeldD?=
 =?utf-8?B?MWR3VFFjUlU3bEV5UlFvUVBRbkJXU0ZTZm56Y1FOdm02Vm9QbkRXcEtsS3pz?=
 =?utf-8?B?eUhwMUJNamtDS3NXcVc4a2taUkZ0bEdhdjBjQlNuSEFhOEVFS001VmtWUXFt?=
 =?utf-8?B?RzIvS3VkMXBBRW9CdzY2MmhXTWNudFhuc0ZhQUZhaldwNC9FZEE5eEJtUlFC?=
 =?utf-8?B?cHRnTy9hM21uMmozd3U4Y1JyTVNYU3JGb0o1dXNGeVpCVml1c25vRGZoZzds?=
 =?utf-8?B?Z0JQTjIyL3kvcFRoMFI4T2hSelBQN2I1OVNqczY0TGIvMkRyV3h0MTRWWUc0?=
 =?utf-8?B?dkNBMnhyYXhSZDYxSE5EcE0rL2dJRjZEaTFaM05wNVVHWTBUaWt3ZXloK2hC?=
 =?utf-8?B?WktiQTc2S2hDN05xOWdFL1IySDgvMW9peVlDc2NDbUZFaFpCeUdQQThoM2x1?=
 =?utf-8?B?dDZ2eGk4WWU2QlFPZkoya29UZzRlanB3elRoRjVXQXhGYlpHTXZrSlBBclUv?=
 =?utf-8?B?Umt1QXdYa3NTWStmN1EwYWFad0llTzFJaFFzOTk2TEkvM0xaTlMrcmdPZDF1?=
 =?utf-8?B?TnhuWkh1ekZCU3Z3a01ocEI2NFdBWEJmSFFwYlh1MXd3YjJ0d2VnNi9FTUdZ?=
 =?utf-8?B?czEvWWx5djdFMGNCUDJ4eXNDK1NXdzQ2d1ljd2cwNllGamUzY05VcFBaWWNi?=
 =?utf-8?B?RHRYQS9kUkl0OHQzczIxbkxhaUc5Zkx1L240RGpZY2t6YUZEL3ZGbFFHd2x0?=
 =?utf-8?B?QUF5RGttKzlNVUt2eXpwVC82dURjMHlZVnRYYzVXVFR0Wm42WTBuaGlScS94?=
 =?utf-8?B?dFZ1Rms2QVRKUmFycmRpSEpHMC9TRndWc1dYbEJjenhYL1QvUFhpMFhwK1Nk?=
 =?utf-8?B?cEFHMHBES3dyNzlQdHBHakgwaGcwNGZONFRkTlNmMFJrSU9uV0htVXBVQVZa?=
 =?utf-8?B?MXhYenRhNHFNQUtDZnhyZUNLVG1Qc3puNFZJSjBsMGtrMlorTlUzVXQrMDVn?=
 =?utf-8?Q?gOENzzf9ATsZ+ZvzLLlcJdvHe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616ec27c-d69d-487a-f286-08db809092ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2023 15:24:22.9782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oianCslKv1QMh+9axyzPPHXI0/xwmqzUJeAaQQkPy8sNI9r2SDgwGDyF9RppIPRQZ4u5ftLFxDa4bxeULa4U0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848
Received-SPF: softfail client-ip=2a01:111:f400:7eab::62b;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
> Currently, device dirty page tracking with vIOMMU is not supported,
> and a blocker is added and the migration is prevented.
>
> When vIOMMU is used, IOVA ranges are DMA mapped/unmapped on the fly as
> requesting by the vIOMMU. These IOVA ranges can potentially be mapped
> anywhere in the vIOMMU IOVA space as advertised by the VMM.
>
> To support device dirty tracking when vIOMMU enabled instead create the
> dirty ranges based on the vIOMMU provided limits, which leads to the
> tracking of the whole IOVA space regardless of what devices use.
>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   include/hw/vfio/vfio-common.h |  1 +
>   hw/vfio/common.c              | 58 +++++++++++++++++++++++++++++------
>   hw/vfio/pci.c                 |  7 +++++
>   3 files changed, 56 insertions(+), 10 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index f41860988d6b..c4bafad084b4 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -71,6 +71,7 @@ typedef struct VFIOMigration {
>   typedef struct VFIOAddressSpace {
>       AddressSpace *as;
>       bool no_dma_translation;
> +    hwaddr max_iova;
>       QLIST_HEAD(, VFIOContainer) containers;
>       QLIST_ENTRY(VFIOAddressSpace) list;
>   } VFIOAddressSpace;
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index ecfb9afb3fb6..85fddef24026 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -428,6 +428,25 @@ static bool vfio_viommu_preset(void)
>       return false;
>   }
>
> +static int vfio_viommu_get_max_iova(hwaddr *max_iova)
> +{
> +    VFIOAddressSpace *space;
> +
> +    *max_iova = 0;
> +
> +    QLIST_FOREACH(space, &vfio_address_spaces, list) {
> +        if (space->as == &address_space_memory) {
> +            continue;
> +        }
> +
> +        if (*max_iova < space->max_iova) {
> +            *max_iova = space->max_iova;
> +        }
> +    }

Looks like max_iova is a per VFIOAddressSpace property, so why do we 
need to iterate over all address spaces?

Thanks.

> +
> +    return *max_iova == 0;
> +}
> +
>   int vfio_block_giommu_migration(Error **errp)
>   {
>       int ret;
> @@ -1464,10 +1483,11 @@ static const MemoryListener vfio_dirty_tracking_listener = {
>       .region_add = vfio_listener_dirty_tracking_update,
>   };
>
> -static void vfio_dirty_tracking_init(VFIOContainer *container,
> +static int vfio_dirty_tracking_init(VFIOContainer *container,
>                                        VFIODirtyRanges *ranges)
>   {
>       VFIODirtyRangesListener dirty;
> +    int ret;
>
>       memset(&dirty, 0, sizeof(dirty));
>       dirty.ranges.min32 = UINT32_MAX;
> @@ -1475,17 +1495,29 @@ static void vfio_dirty_tracking_init(VFIOContainer *container,
>       dirty.listener = vfio_dirty_tracking_listener;
>       dirty.container = container;
>
> -    memory_listener_register(&dirty.listener,
> -                             container->space->as);
> +    if (vfio_viommu_preset()) {
> +        hwaddr iommu_max_iova;
> +
> +        ret = vfio_viommu_get_max_iova(&iommu_max_iova);
> +        if (ret) {
> +            return -EINVAL;
> +        }
> +
> +        vfio_dirty_tracking_update(0, iommu_max_iova, &dirty.ranges);
> +    } else {
> +        memory_listener_register(&dirty.listener,
> +                                 container->space->as);
> +        /*
> +         * The memory listener is synchronous, and used to calculate the range
> +         * to dirty tracking. Unregister it after we are done as we are not
> +         * interested in any follow-up updates.
> +         */
> +        memory_listener_unregister(&dirty.listener);
> +    }
>
>       *ranges = dirty.ranges;
>
> -    /*
> -     * The memory listener is synchronous, and used to calculate the range
> -     * to dirty tracking. Unregister it after we are done as we are not
> -     * interested in any follow-up updates.
> -     */
> -    memory_listener_unregister(&dirty.listener);
> +    return 0;
>   }
>
>   static void vfio_devices_dma_logging_stop(VFIOContainer *container)
> @@ -1590,7 +1622,13 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
>       VFIOGroup *group;
>       int ret = 0;
>
> -    vfio_dirty_tracking_init(container, &ranges);
> +    ret = vfio_dirty_tracking_init(container, &ranges);
> +    if (ret) {
> +        error_report("Failed to init DMA logging ranges, err %d",
> +                      ret);
> +        return -EOPNOTSUPP;
> +    }
> +
>       feature = vfio_device_feature_dma_logging_start_create(container,
>                                                              &ranges);
>       if (!feature) {
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 8a98e6ffc480..3bda5618c5b5 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2974,6 +2974,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>                                 &dma_translation);
>       space->no_dma_translation = !dma_translation;
>
> +    /*
> +     * Support for advertised IOMMU address space boundaries is optional.
> +     * By default, it is not advertised i.e. space::max_iova is 0.
> +     */
> +    pci_device_iommu_get_attr(pdev, IOMMU_ATTR_MAX_IOVA,
> +                              &space->max_iova);
> +
>       QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
>           if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
>               error_setg(errp, "device is already attached");
> --
> 2.17.2
>

