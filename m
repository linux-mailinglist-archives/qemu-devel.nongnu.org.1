Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C2A74C5B8
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 17:18:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIWAl-0008St-8T; Sun, 09 Jul 2023 11:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qIWAg-0008Sd-BW
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 11:17:59 -0400
Received: from mail-dm6nam10on20626.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::626]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qIWAe-0008WE-9k
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 11:17:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3/djmxDGv/sAhSFUCIgthGbza7UDOZ/k8IFfMITjlgpP7CO3d7RWATi2XoUfUQvoFCskhmJC6g5GnAumas5yTfKM3QzsrwRQZoeQIbYSqzH0sPCHdgr3ll4UKzMGkOHriSsxkfG6KVjc//Nh5pPDBVM1zv+L2DJBg33OJhXLSwmaAiB4hYb7dbpThaIdW/YNlbM+PLN3BNmdu/2Y7XvvQCupQE70MtJIM8mDXebJr2LON0k1ZU2oUb/VbpEfn41ECHUzoLHJqmlmIbYPeRxVddrOrhSS5+k6LJDC0oqPfZv9cxdWqThTDrwg+WRF3/wBT+f5oVl2FLzS09PkfNaBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x33GodbxEhcPKTMDuc5a29BiOuGuwqDwc1i01K3Ymws=;
 b=Xzu/9lMBDbaDme7lK54GtnCyMLTFxAjg7sDRP6jNKeQB7orLMAoP6FJzH4cTvnHX7W5Sz1380W015k5QFXRLvbTkv6cq7wSVS5zMvs37bsAwR7Q58SNdK3305PabMdE5PTjtVjaBIFHCsTkV8+ZP+UvXJpZpDIEmySfwFPPJd+NT7XK/vekuHpQR5KIW3grCHQCqwsC5ui0n4xZDYx5calU3lrmFbBIQ2zgLs8QKPxU6spaSgWwMuRpJBVVSZzHJB9fq8rj+NHQ8tRhxvxZcvgM7yBeL+WEs+TXrjDviS+9rlu3uG9F+hDN0VNyQ/K6qHtmIcn9koit97FCaXPc1xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x33GodbxEhcPKTMDuc5a29BiOuGuwqDwc1i01K3Ymws=;
 b=K9R2zJaBjfyOkoultpS9Yh6+oPhEMWH1JlLFyorrrS3Iu25p7wgerzbmtnw9QmWd0spbOkSoZLJdOT24BbDzIrwS5w1L40+RXExlzK6ZBajFYdslNblMDbvP7CGnaQ+eDQAQVw3vtuVMTTBHZNxEMyorSAAYwebBAz7SVqLckHNjpTxg7H1jGiF9+o/rjov3EDu00cDbNkEmMIqsNwzTYz6OWXg/d0XQygsZxvlfoxKlLMmQ6QsI+o9zLkyT+L0UOqnRFmE/udf8W4t/0koG+VjRN8lzBZHRm0jXkdmLWEjRd3pG6esV8P30Tm7mTuQ2LkkVT9+KcCjUNYfe9vZ72g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by BN9PR12MB5241.namprd12.prod.outlook.com (2603:10b6:408:11e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.29; Sun, 9 Jul
 2023 15:17:52 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b%6]) with mapi id 15.20.6565.026; Sun, 9 Jul 2023
 15:17:52 +0000
Message-ID: <d6787c69-e66b-9e09-2efd-8f60129f0ea5@nvidia.com>
Date: Sun, 9 Jul 2023 18:17:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 10/15] intel-iommu: Implement IOMMU_ATTR_MAX_IOVA
 get_attr() attribute
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
 <20230622214845.3980-11-joao.m.martins@oracle.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20230622214845.3980-11-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::17) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|BN9PR12MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fdcc985-45dd-43e7-c297-08db808fa9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5GyIdPZkqghobTk5Ex+dpaqir54GkInmRNNu8fQ7Kd6CZOmsOaFsEOPBSW9TEe32ZBxI+NmY4UABQ331NqKHKZlJJppo26RfA7BR3pz/TvQ2AlGM4FPjOqOvwLTazWnci9x7AXYJu7vh8ezlV1sgMmTBFVFG4J3Bn12ya/GjS2l7XCPUkS0jo7yapN4uwUwUTXLETdVHjJEzr0M8HU2UCu8jCyXzr4ycQSWEN0DNxS917X3Qoj1kKyeXPMRwdQri/qMvx8gLiNsO+cYMCZFbFm/4vCUMY5HrNv7u1vIfM0tglji/XdFgI08D8jPzP/5MY/d2pgqfjIc0SK7O0CwlIrTruWJfcE3MaWdSvKdVdatjdPFxxi7Tz0RJ5/+iqKbiDiFJxG0eL9g0bOgFzCSmXjCSK99Obvj0SVjH/YbccP2iOuqXVnCJKPTWDMEDQtXPStSuCf9fpJwT8c6ijXmoQPJcv015ZZhKvAQAOL+D4z4BBBAUvs6tZAZTW397Ho2PTjYptSA3PDirDMGW9q47EUHOliwm5MKB9njjvcmKN7jxsCGM0XUamXijrSzwMzbqVzifX8+T5lYCBRc47NQpJWSVg6MOBAEJOUeNhecnx+1Yu+k89kH4kZJxH6sB3XoZ57zPKpHOEHTdPr/G+eIA+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199021)(86362001)(31696002)(38100700002)(31686004)(36756003)(6666004)(6486002)(54906003)(107886003)(6506007)(53546011)(26005)(186003)(6512007)(2616005)(7416002)(2906002)(66556008)(316002)(478600001)(66946007)(8676002)(8936002)(66476007)(5660300002)(4326008)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3FBWXRCbnIzMUR0dW1sN2JEQkNINFZqNm5UQ1JRajhSZTF3WVpGcDcvMmFj?=
 =?utf-8?B?cGR0UHdRQnlVcXpXSTBSSGJMOWFGUEZQMmlhQTd3WDQxMUxURTVVcFdYRFFh?=
 =?utf-8?B?NnRjQUVZMWNNNlhOcjFzc0llMlJhRnhSRUZCRytaTU5LUjNmdzRYeGd5R1kv?=
 =?utf-8?B?SEkxMHJmV0NsTjI2bmNjNFl4ZUFZbDZsa0d6eGY1S1B0VVByTnRKeWoxUVpq?=
 =?utf-8?B?WDZjZ2hKV0MrR242eWs3MlY1cUxKbEYxK0RrNkxnaHlWTTBBc2NONHdwV0JD?=
 =?utf-8?B?OHI1ZW1PdW05MlpzbG84SWhmUEsvbENhNU43bzBBODJKeXpJdXE2WDBsdUZN?=
 =?utf-8?B?RU5Ia0lzcENIWkRweG1IYksyUE5EbGpUTUdGNmZudHpJeWx0MVJCblp0UEh5?=
 =?utf-8?B?RHUzekZiMVZCaEk4YjRlOExMRXJPbW1NY1pTUXZLdFFEeUk1dVBtem44WG1z?=
 =?utf-8?B?Vlo5SktlSFBHa3BSN0tHNDVxMlBLdDJQK1JQb3YwMEI0UDMvTjVBM1pvZ0VF?=
 =?utf-8?B?NkJwOER1NVJBT0FLRTQ4UXdtQnFmbmlMYklPOGE5dXZaN1pRempNeEJGaHo1?=
 =?utf-8?B?WkFJdHoyRzVjc2JUWnk1RDd0d0FSUXpjcmxWK0hoYmFJYXZUMUNLK3J2UFVL?=
 =?utf-8?B?d0xUYUJHak4wVWhVbUY0d2xqZGJra1BFNXhLSkVlL21GN0orL3NGWWJDUGRy?=
 =?utf-8?B?TWMvZWZZSlBnZzlrZ3FIc0Z6MGlIWklUWENkMjg5YWVMWGlBVDBiaVpLbmUv?=
 =?utf-8?B?OTUxMm1HZ3l3YjZXL1l0SlVHblRUSGdwOVB1bGQxOVArSUF3eGhaMmliM2cz?=
 =?utf-8?B?ell6WjZnVSt0bkYveVVOcUw5RnhaOFJqU1J4ZWIrZUtxOE1FR2hiNVlocUJC?=
 =?utf-8?B?N3dWMVVJVFp4eldzenNpY01xbnB3OWQyRVZXZnJaTDhjdVhQOHByMENRaTFq?=
 =?utf-8?B?WGpDUGR1SXVHSHJhcWlCb3RRV0xrT2FoRzZjcUZzeGJDYnZnVDFtUFNYY3hE?=
 =?utf-8?B?RFFFcG9maU5FdjFtWmxYaUJ6NklMR2JxbXhaK3drL1h4R2NnTEROT1BPdjRq?=
 =?utf-8?B?QTBCNVc4eXB1bGNyVnRrMlFBcU1RQWZyUVBkMVUzS3k5SEQ3MXhXRmp4ZnpH?=
 =?utf-8?B?VFJXQ0FtUWVwcS94eWt1WmRDb29JOVNGUkJ5a093UVgzTE9DVGJ1cUNwT3dp?=
 =?utf-8?B?bmJMdkhRbXZIWUM5UEQwRlhyRWhJZDN2TjdiUnIzWHFSU1FDM29QY1FLWFdP?=
 =?utf-8?B?OFFWa1Mvd0dLdWlMQkxTNlliUkJaczVZa2FNZVMrcVprZDZYeGl6WEhXNHlC?=
 =?utf-8?B?Q3ozMXZxZFk0M2dNdk5qZ01zRWMyQUd1L3ZnMEpIRGZvaUxucmVDSjJyM1hm?=
 =?utf-8?B?SUpMcGhQbWdNZVhHVUdPVnFza3AzWTcvL0tkWXNLL2NwaHJLeWFBT3VWcVNn?=
 =?utf-8?B?ajMvaVVrMlR5ZkxHQ3VqRGdnZFk3M0F6Z0ZFL1NhR3pLY1U3L1Z3WlVJK2JF?=
 =?utf-8?B?WHMrWFJjVm1oRnRsS2syeFFCRUJEd2hEeGt6RzJXYmlLbGZkTkoyWTU2c2tW?=
 =?utf-8?B?WHo1MGN6Q29qLzQ1VjJMQk8xUmhsSDFRWDRIT296MHJoUXZLTUVQMXd2U1Y3?=
 =?utf-8?B?MEdCblZZS2pyWVpQa0dmUUJ2R1ltVlQ3U0lxalAwODZmQ2VjT3pZdkM1Q082?=
 =?utf-8?B?R0V0M2VEdnpTTG9SZXVVeU54bXc1UjJMbFozaGNRMTczbldMUTRsbDZpUjBL?=
 =?utf-8?B?THJ0L1NEK2hpdXVWQkxRQ1pGa0VLVFdidjJPbVNzMlE1ZVlnL3RYM3crZlRL?=
 =?utf-8?B?ZXY4bW9MRFY4cDZmdUxibVRPeEwxY0tCQmpaRzNUVXdBMyt1VVI5UlFSdU4v?=
 =?utf-8?B?MklJalk5WUFaY2FrSi9md2xUVEJsazhZYm5TbmpiRFRWeEcrdEJKazViOVdw?=
 =?utf-8?B?VW1FR2RnREM2QmNLZmJLRGI0S3ZMSHVjdjBHSlVMUlBoNHZzSWVtWlFJTy9M?=
 =?utf-8?B?N3pkaHRpbWFvRVNQNTZuZmdrY1NRUVN2MW1SR3pyVlpWZnVVYUh1ODZOOUZN?=
 =?utf-8?B?OWF1Vm5yV1VwNUY5cUV0dkhNbnFZNFJPTjU1STRVMFRjNHFNV3pnQUM4dDRS?=
 =?utf-8?Q?j7X9G165Hp6ayvS/aBt8oyenN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdcc985-45dd-43e7-c297-08db808fa9e1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2023 15:17:52.3992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KcyjC5VKNTRYCj8vzyZ29G/U/BTktAvqlQUJrIpzHpSpLjAzwRISxKfQtva7ecnZtcGp/k8xb5MC+rPAht9Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5241
Received-SPF: softfail client-ip=2a01:111:f400:7e88::626;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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
> From: Avihai Horon <avihaih@nvidia.com>
>
> Implement get_attr() method and use the address width property to report
> the IOMMU_ATTR_MAX_IOVA attribute.

Nit: get_attr() method was already implemented in patch #6.
Maybe just "Use address width property to report IOMMU_ATTR_MAX_IOVA 
attribute"?

Thanks.

>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   hw/i386/intel_iommu.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index ed2a46e008df..989993e303a6 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3876,6 +3876,13 @@ static int vtd_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
>           *enabled = s->dma_translation;
>           break;
>       }
> +    case IOMMU_ATTR_MAX_IOVA:
> +    {
> +        hwaddr *max_iova = (hwaddr *)(uintptr_t) data;
> +
> +        *max_iova = MAKE_64BIT_MASK(0, s->aw_bits);;
> +        break;
> +    }
>       default:
>           ret = -EINVAL;
>           break;
> --
> 2.17.2
>

