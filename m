Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 676967158F1
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 10:43:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3uwS-00032q-Ia; Tue, 30 May 2023 04:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3uwQ-00032Y-Gv
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:42:54 -0400
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com
 ([40.107.236.40] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3uwN-00031w-MO
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:42:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHHQhkwr3SACpE+U8YdlgOpM1B0qbqQZdyKDggqCqZj6CGzfotxWid4952p4XX0OLHRHAP9EucHcFF5ngSij2d4HCD7UACOfCo4qg7GPJrszNXNHnAYt2fyDB9SxgH3DCfjXYMxtKN2iDpVN0+5DAjFoEZKhIHw2tSYvna3b8FCSr0kqeO5phURZdNr0PQY+Bevz83Ft04YFSFNsc8+3fm+MX3qXPlJ6nEj6XnwNquIvt8xFTJSTf+ch3cASc3q27J6Lb+QQUAybds4sYQndYBPV+T6oRdSvFf37QWO7HWm/XLfeo8qkkwh6HqC8FgjKpYQ+1ZcmRbQRTMdttoMtdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTXUJiHMlqKFwFSxtqaCK/CQ8hjSPtqJZz4lUqPVuTU=;
 b=YN7MJQI9xGB2P4AhvyNp4GWngcCNMcPJAQR3R9gX5jiZWko+M9R3BexKeINZKb2ASTnUf9FfYBD0dlKYRL6jiTcdHL50xcQcj9sUWIlC8rcQ7JBHiyt4Fp5eNnlRr34ILGye3U1hWkYPtwAWN8RgFYtKFlFwKG73OtqAKojp/AbhX5RAPx2dodRRu5qtHoONpd/sx41HAPsGjwE3X3uhRSYXRGPxRi944b0oyhDJNFgPxB934cGxUk+S+XJLlLlnzFkJSw8lpf6CrJI82ur4vvPPOmBnW8NC054wXp6wYFZIXOwNMRLEynAZ6s+kqiwVnM390RlZNxOfsYm74IH2rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTXUJiHMlqKFwFSxtqaCK/CQ8hjSPtqJZz4lUqPVuTU=;
 b=OYYdQehMFVOIaw2+UdLFvLbUlmFrB3PrpF5xK42snzuWBRpoWvfD3NzmwDG9WlIcElNaFm9JKhEBFq3d7Rt6B6ZzDz7yAbvdYPfawdwRYpP70UOrG2a/9IC0nTaj3V7999EG5iC29v8s7qx3KHN9h813281MWHOX47ydjBx6C7QvBFO0VtH+xzrXQKfTcgwbfBR5PPdTxo9MguTkMPHq3sbHDnLI/5flwkJ6wZiOemrhr7aIRyUxEXnYT5fY3QdDOhkuXQuNM6AiGY7Nxp4X95JOo1XeC+pM8Tal+3Y4ngFzhTvgxVOEyi6i7Ra8UxQ7ykDkX0UvpUDwcOwskkBsww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 08:37:48 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 08:37:47 +0000
Message-ID: <dd66848d-d1c0-e428-7a49-97751f7f62b3@nvidia.com>
Date: Tue, 30 May 2023 11:37:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/2] exec/ram_addr: return nr of dirty pages in
 cpu_physical_memory_set_dirty_lebitmap()
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>
References: <20230529121114.5038-1-joao.m.martins@oracle.com>
 <20230529121114.5038-2-joao.m.martins@oracle.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20230529121114.5038-2-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0185.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:344::13) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 352a638f-ed0d-4bc6-d31d-08db60e9256d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sHYwCHtBh5J39LwibB1dKw4R72MzfN1MP9CPXrb+13s105ByvoP+kheDLWy/tj5rB/20UwF8vrtt0q6/EYGuHNkk9bGbRoTYXuG0Vdkj3vLo21xxom/07AzVtWa0CwstqV/J9rUn0Oxo4ACrGcrhtFI7/mqtZNhRtPNfaSrqXxQal0DWHpM4/nnZ0Ayh3XNQqnC9rr+rn+Ix1yUlaxrMzdlzGs4jlv4rbW7tiRLG6e6orCRy1o4fi8gEHkJIfrJO+weKhMoIQiObj562ZQ37CIlnO613TE/p/ztfzAhtmCAP3OffNSwFjFZlPUD048TJ7jFTSWU1W+KQnoUb+BamFAg9mM3gQhXDk7HdB7rV0/f3Xmw042yGpLHPcj9t9fBdHLGbid8u7OUbqR/1D/LSNfv87H54nGlcsAz90s7omiTn2p3hGv+Mwa3ZPpJBvZUl/8wCzjsMai9pZEWAflRBx8zPx3QkpiviGo277IeFw4pSm9mMn7zd+D0uQnhpKhYO2jAmP2OpeOeSlAbeDgNkIrF+LFUpd14+l2LCs1AYGK4xbaQOf0Tt3nLKA8tXXs4v+XcUTmjakfxBRrL10cb7clHjN1CkWO8c30QUZSUYUAMj8X4rcHSfptNQl6pvvZkw1PorHAymRuQU6wr2I7O6dfTlz/9cgeezzNmdK6t/jxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(83380400001)(86362001)(36756003)(66946007)(5660300002)(6666004)(316002)(66476007)(66556008)(4326008)(31696002)(8676002)(8936002)(6486002)(38100700002)(41300700001)(53546011)(54906003)(2616005)(2906002)(6512007)(6506007)(186003)(31686004)(478600001)(26005)(14143004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnBJTGZ3dVhEN0ZCMk5pR3BwMGlPeFAyTWMrOGdpcWJmVFlCdTI5U2plV0pp?=
 =?utf-8?B?WHNWd1daWFI5ZmRnOE5Rdy9iOGcvWXNnTnRma1hRTDkvdG12eHBaVUxFN2dp?=
 =?utf-8?B?Z0NrNmZoNy9qWkk5NFpHNTNZNVdwbE9YRTR5V0x4TjRyZzg2UXhyZEtYK3lz?=
 =?utf-8?B?Y1hMZmVVSGE4MVJhRlphSG1Wa0t5c3l6cFVDYVdQMHUxQ2E2ZDlod3BtcXVx?=
 =?utf-8?B?RW9jRm5HQ3ArbVd0Z0FFckp3dXZ0VzdmWTQwRE5uM1pSTS9Bd0F1OVpJQXlB?=
 =?utf-8?B?OUNabUd2TDYrL0k1Y200Sk16S2w5cWEzbHhYRHpEc1lpeDcwajdnK245SSty?=
 =?utf-8?B?aVZ2ZTk4WXp5OWNyUEhGUjBTWUVmSmlhalljQzNxSnoxaGtNeHgrZVFuVlZO?=
 =?utf-8?B?THZDS2M1Q20rUzdzZDd2M0VNRERCQ3haR3gyWXppeC8xVVhWYmVPYUZlRjhI?=
 =?utf-8?B?MFI0TVMzelNYd1BzUTErZmZwN0N0bTN2dFAyWXpTbUd3N1NRUDN5U3huOW85?=
 =?utf-8?B?SkN1TDdSZ0JHSmpETHdPWkZVUmN5bEN5azNZd1doUVlCRUNBcGMyam5YcUpu?=
 =?utf-8?B?aDg5bVJ5T1pnV3JralZIRXV0QTVLUTZkUm9uN3BtOHczUFRQc24vNHdjRzVh?=
 =?utf-8?B?anUrS2xYM090MDB5Umh5aUl5d1dSUFU0WEFxRU1uMkJnWWFNSEJXaVdaS2lG?=
 =?utf-8?B?UUxEZzJqSWNobDdlVXF3WmszMVhYdW1INzdZWTZ6RzU0UXJnSklKTnFjOERj?=
 =?utf-8?B?djloL3c5WkpIOXc5TllCT3E0ZkJ4cFdWa3Vob0UvUVN6cXZHMmRtQWNJNWZD?=
 =?utf-8?B?OFFDcnF3Ykl3anhhc09zbEdUb3RBM2NCK1h4eHJUUlRzQ1lvUklCUzlxNXd1?=
 =?utf-8?B?SkI0ajltVWJNZ3RSUmxZNFN5NmZpdW05QitIb29DbFV0d2pPOHRWcDVLUWxJ?=
 =?utf-8?B?blNjOUhHK0Rtb0dRODYwQTMzdUxPdW9QTGgzVDZidHZnZndEY0p6ZFpVeFhB?=
 =?utf-8?B?Zloxc0xSNmhnVWc5a0g1dmlzanBtbWEvOWRrK3dVOFNWTnhBUVRnUlYzazNR?=
 =?utf-8?B?Nk0zNUJJK1VYbk1FZXRQMEJrbzZZRENTdnNUUlRRaTlZUTdYSmlVVm53R1dM?=
 =?utf-8?B?R2IzQ2VHbjJHNU1lNCs2VUVLQlUxTDgxQVFISFh5QXh4MkFhL2poZVNtL3Ji?=
 =?utf-8?B?SVhTQUFDT0RSMzZnUlpQSVNqT1BjUUFBZE80TUdxNzNleW5lOGFnTkxIRUI0?=
 =?utf-8?B?YzBTUVQ5MGVSMUJzTHFic0NYZ0M1T1JuQzUxMmZtVDNwZldrU0tmZmdna1Vk?=
 =?utf-8?B?WUhSMlNhNlFCYWJQYzRkZWk5Q1U2V2JGRzdERzE0VmVhWmpsNzVSSVNsWWY1?=
 =?utf-8?B?dGFUUHgwQjI0SmxNSHhmQjNQbkFnTXRMU2hkZWtGUyswdGtKd3ZVc1JjMDU1?=
 =?utf-8?B?SE1Uc1pwamQvS1pDcTVJVnE4SndlamhJWUFxZjN4TGxSSHdvNmVIVStvaGNa?=
 =?utf-8?B?eVlwcDd6N2FOeDYyY2dkaEYwcllOaTN3eERHZVYwSVRoWjBmNWh6eXVXTEF4?=
 =?utf-8?B?M1JpQWd1QWJ0Y29SckNtOG1QQ2RYNTFPd1BsOXM2dHZqa0pLQzI1OW1FbjB3?=
 =?utf-8?B?WnFpenBVazJPUE8xRE1IUXk4S3B5YnpydjFIenkyZjllTDI2ODk3b3h3R290?=
 =?utf-8?B?QlllTzdhS1M3N3JJbCtIcXNuMUtrU3Y1Q05HS3A0aWVEUTlaYy8rSkxBT0lW?=
 =?utf-8?B?Q0lKZi9zaGY5NzJkTFZSNWpNdUdaSnFYcXkzSDlaSjNRREFwajJhWGNGZW9y?=
 =?utf-8?B?VXJJMENwZjBHUUdNRUkzbFQ5elVWZUJUVk4wOFFjck05Y1N1WkNSNW9vTWFH?=
 =?utf-8?B?eFRmQnJVVkpEQncreWNGbDZDUlVkSXY5aXNPT0IwMHc1cnpBU1hXQW1FczJJ?=
 =?utf-8?B?ckhxTUFJdmZMN1NWZ2lnQWptQWEreG5ESDFWUEk5NUgzZnQxbXBJYW54Z1VU?=
 =?utf-8?B?R2dielc4eGlKTjVqNWNOeDBVOCtyWWhCalJCanJCUUpnUGNUYW1xYmo0Y3BW?=
 =?utf-8?B?VG1TeUxsdzVxcHEwM2tNWEdISGVmYVE0R0ZBekgxRVV2MFFkS05CMjFCZGY3?=
 =?utf-8?Q?v19gIazkweia1kf4WMTcTEj2o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352a638f-ed0d-4bc6-d31d-08db60e9256d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 08:37:47.7826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxkvycuRE+xy2j3a0O2YC4Y1+0T/+94l/IObvvwzH+8PeFsJS08DyMH0fxcq6PXcGowZZEK4GQjDNOgrrbSrzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590
Received-SPF: softfail client-ip=40.107.236.40;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


On 29/05/2023 15:11, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
Nit, s/nr/number in the subject.

> In preparation for including the number of dirty pages in the
> vfio_get_dirty_bitmap() tracepoint, return the number of dirty pages in
> cpu_physical_memory_set_dirty_lebitmap() similar to
> cpu_physical_memory_sync_dirty_bitmap().
>
> To avoid counting twice when GLOBAL_DIRTY_RATE is enabled, stash the
> number of bits set per bitmap quad in a variable (@nbits) and reuse it
> there.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>   include/exec/ram_addr.h | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 90a82692904f..9f2e3893f562 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -334,14 +334,23 @@ static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
>   }
>
>   #if !defined(_WIN32)
> -static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
> -                                                          ram_addr_t start,
> -                                                          ram_addr_t pages)
> +
> +/*
> + * Contrary to cpu_physical_memory_sync_dirty_bitmap() this function returns
> + * the number of dirty pages in @bitmap passed as argument. On the other hand,
> + * cpu_physical_memory_sync_dirty_bitmap() returns newly dirtied pages that
> + * weren't set in the global migration bitmap.
> + */
> +static inline
> +uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
> +                                                ram_addr_t start,
> +                                                ram_addr_t pages)
>   {
>       unsigned long i, j;
> -    unsigned long page_number, c;
> +    unsigned long page_number, c, nbits;
>       hwaddr addr;
>       ram_addr_t ram_addr;
> +    uint64_t num_dirty = 0;
>       unsigned long len = (pages + HOST_LONG_BITS - 1) / HOST_LONG_BITS;
>       unsigned long hpratio = qemu_real_host_page_size() / TARGET_PAGE_SIZE;
>       unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
> @@ -369,6 +378,7 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>                   if (bitmap[k]) {
>                       unsigned long temp = leul_to_cpu(bitmap[k]);
>
> +                    nbits = ctpopl(temp);
>                       qatomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
>
>                       if (global_dirty_tracking) {
> @@ -377,10 +387,12 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>                                   temp);
>                           if (unlikely(
>                               global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
> -                            total_dirty_pages += ctpopl(temp);
> +                            total_dirty_pages += nbits;
>                           }
>                       }
>
> +                    num_dirty += nbits;
> +
>                       if (tcg_enabled()) {
>                           qatomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset],
>                                      temp);
> @@ -409,9 +421,11 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>           for (i = 0; i < len; i++) {
>               if (bitmap[i] != 0) {
>                   c = leul_to_cpu(bitmap[i]);
> +                nbits = ctpopl(c);
>                   if (unlikely(global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
> -                    total_dirty_pages += ctpopl(c);
> +                    total_dirty_pages += nbits;
>                   }
> +                num_dirty += nbits;
>                   do {
>                       j = ctzl(c);
>                       c &= ~(1ul << j);
> @@ -424,6 +438,8 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>               }
>           }
>       }
> +
> +    return num_dirty;
>   }
>   #endif /* not _WIN32 */
>
> --
> 2.39.3
>

