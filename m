Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB4F798253
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:25:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUuG-0003p5-9K; Fri, 08 Sep 2023 02:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qeUuE-0003ow-9v
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:23:50 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qeUuB-0004MG-4V
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694154227; x=1725690227;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AW4WmTXAynzMLlqIHvElAQYx9GJq5eBb5nwLGTBdE/I=;
 b=mO6iHtOV+MEeA8IpJJq2V/iCm9aaI5V7HTDOcttQfbq0AbikV9Cpk90U
 fhNzFlP3XwSPkLmomZGG07DeT2RgbGrI+tE6ltXs5/CvSsD0z43xhdICl
 8ala0XLeLira3BHg8mKpgxRkmJso4gqiXAOLmHbKm08pDNpHuUf1pcH7j
 Vw7ySm1wqpm9tximL6WVN8sfFi2p7lT8/hYNXmTFPjmK/1ierc0NFOcIo
 ZG3xN4d//sP6Layx/6qINv3gsLfg8Ufj2hqCp14dVtBRkfRneC9hqgw4s
 QLS1UA9aIWijjNVN+hFSM0K67f3NSO+iQbgufK/Pg/61ezwEo88F7K8wH w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="441591349"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; d="scan'208";a="441591349"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2023 23:23:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="692131488"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; d="scan'208";a="692131488"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Sep 2023 23:23:42 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 23:23:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 23:23:41 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 7 Sep 2023 23:23:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0mblh8NPwu2bUB6UZt/SkdGIKzjIH24LN0fWt5HYTM2726UVAyg5JXLSOcL5whrNcBNfSDyCiuaii25r/ZmIZj8wm1RFchSGJTtb8riSkmbOoABPFCGTjyhceR/11eL9iDFZtnOsgAox8Ndapxw+zRHoaEhTLzzsz+Lu2ODphkg4ud6mz4vK+ZCx/0Nw8bf5/y2qWZgQ0v/QKFtsI4RcotHPrZzpIXqDaV9d1SQLSUZpbubJCpdmagc5K95O1oAEOyNmsqQNeENjg6GzgJGSh231KE/0brLPOVpaLSsCmohyJjlRg9ci42xcIEqLhWfMMrmAhPcAvqc5fWjtfTMWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLqhSnbuWa56BHiSbhN2wb85KqjFAdjutji/MvfYI1c=;
 b=foDXE8NGDvkywyC0FQuyq41LRf761fUXG6o7+iLiz/amDckbrBY/VynirlmoylaH+TXqt5OFeFgsKG5lSlR1miZSpQIFae0aTGW69Pkl61tDwpFqajdCKGRH5aTrwF1l4+ar5qjV4K4sgaGLopC3ChlBataYKSFXD47XmN95fuGg/Z7kGrIWaM3RKytpPfOKzmjUYR4CkBS6iFZj8ZG6UmuNF4t32I8h1pnT92S4WGC1UbHGDpypvxT3bhBtwImNxGHY60kfyQGvmssA8Wg9Nl9DzVUrEvcE/B3WGy9wSerXhZkJxsQ7pfOJ0QN/yVdRHaChWxynaf7pc6zYlGr1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB7762.namprd11.prod.outlook.com (2603:10b6:610:151::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 06:23:31 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::cac7:3146:4b74:8adb]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::cac7:3146:4b74:8adb%6]) with mapi id 15.20.6745.035; Fri, 8 Sep 2023
 06:23:30 +0000
Message-ID: <e6e27cb1-88c4-5b1a-dce4-b4f31ecb68c1@intel.com>
Date: Fri, 8 Sep 2023 14:23:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 06/15] intel-iommu: Implement get_attr() method
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu
 <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, "Philippe
 Mathieu-Daude" <philmd@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Avihai Horon <avihaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-7-joao.m.martins@oracle.com>
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
In-Reply-To: <20230622214845.3980-7-joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To SJ0PR11MB6744.namprd11.prod.outlook.com
 (2603:10b6:a03:47d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6744:EE_|CH3PR11MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c500a5c-1e1e-413b-d2a5-08dbb0341edb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25oQ6A5jFJgHd44JbLOYUshPqx/8LLHLhjOLaqDsAUoicqUN5koo7jnZUzaZtL/qZV2ov0v4YwSAgZVEZSryukOHNMPdj++LMUdbPuEm5w0ePnChDUKYS7ZkO7SdfI3LlUJNP1ZZM1Us+hlL3tPYcjA+YhqS/hbYhp0bwv4C2Lr4rsSJIDkcdP+eAqLZCmKBAcB7SDhdMvI1JBfVtBEeQhMEJwpSx7A5yEF/drnfYwe7tDugKgVt8D6grJASIzpNVIKmcgvzZzjM53PR/bhewf6/iBswCKvaCRNiWYTGfQWIkw9sKpSGNcvYy21EIjV8BOsUIG3yfv4mtZVOHy0D2VaQfnvPRKZB33u0CtjVK0uus99fjlF97bcxJFPo3t/atJPzXG4Zd8o3uyX8KerO3GYHnHIEm8daIXQKIZnCs4iC0xQACmSQSGAsr6Roqe37W15EJwbMcwDY4jFHjMQ3nB4TkZvnilJH0j1FTSriv12caz4nEkI1o5LcPaBtVBYmbWuRphW84YrF7OCZpAapf4RJlcmgx0oTJDlml3V+jwoNjWzeqYc2+onDze5X46wj21y0ZUnTPEOyspl1HlOms6qoHvynhUG6uoFt0vtJ6Bt7VojX86zbdxtYDsoA6Lhl6+TYf+vkdPU7SeYdSCrXlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(346002)(136003)(376002)(186009)(451199024)(1800799009)(6512007)(2616005)(26005)(31686004)(5660300002)(4326008)(53546011)(6486002)(6506007)(8676002)(8936002)(38100700002)(82960400001)(6666004)(478600001)(54906003)(7416002)(86362001)(31696002)(41300700001)(2906002)(36756003)(316002)(66476007)(66946007)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2hzclBhRlNhWDE1RWU3eHVrYW9EeW16eUJqN0xSL1EzQk13WTJDb1pjc3Aw?=
 =?utf-8?B?OWRZQmJvcGpMU3J2ZzFmdENIMDJGT1JRclA5bEs2a1ZkL1I5QXlXa1pUU1k2?=
 =?utf-8?B?bThmd1lYdmdOampNSkhCcDlIWFRkRmdsS0Ziei9FMzFiMC9nNWtrV2h1N3hn?=
 =?utf-8?B?dlVxbE5Na0M3c3pRQTNGOUtYZy82MGo1SVVqcXV3a1plaXpITEFIUjQrT0NZ?=
 =?utf-8?B?Y2ZRb0JjQmNTUys3NkoxN3ljRU1nbzFEbWJxWmZWUzk5TXBxNlR5VmF2NUhX?=
 =?utf-8?B?MVFwdGRWczlITDdrSXZrdU1XUnpGS2dSNlQycnNnZWdKRk1tYTllZGdYZ1dE?=
 =?utf-8?B?MURPY2FkbHF6RENNSWtGV1RDRlhPb1JBNFdCZ0FiTHN0RzNPeGVJWlJtS1Fy?=
 =?utf-8?B?S3p4MllkTFJtUG5GTFNXenRkZ0pueWFUWjBnQ1ZNRjFvaG95V0FQS0JwcUhl?=
 =?utf-8?B?aGhWT0cvVTZhbVFlekVkZ2Z2Ni8vRlF5cHhqSWpIV252SVE3aGV4c1IxOWFF?=
 =?utf-8?B?WUhkNFRIbkZ6Wk5VeUdDeVlQNnNEa2NCQ3BKNFNmOWpldDhyVHM0ZnBNaHc1?=
 =?utf-8?B?QUdXbHRtY0hNZktsUUdvMVBWSWZwbU5vWW9ZMFBLMDUva3FpeUhmQzNFYkJ5?=
 =?utf-8?B?SnRJeVVldGhQcllLcmJmODdxd2xPMzFJY3ZOdEpNTDNpSUFLcVgrUjRYVGZq?=
 =?utf-8?B?K25sQWRYR0pyRkxiZ3ozQVV5dmMreWZMYWs1UHlkbTYrVGUvRUJWcVN5Szgz?=
 =?utf-8?B?NVhDYlZFWUJsM0kzY1cvemMveUx2b3dlOWQrc2dVMEkzSFZrUjFpaG5LcStw?=
 =?utf-8?B?RHdDU2dNQVNwbnJibW82eGtXTFB2djhCd1I2dWM0b1paTUVyWmU4K2dVQVM1?=
 =?utf-8?B?QnBPaTl2T2FrNVppOE01QnQxSVZWWDYvMXd3SzVmaW5jQkhhRlBqcGxFRDhi?=
 =?utf-8?B?VXBHeTNyRG1xVG5ibUFwazd3L2Vmdzhacis5V1MyVk9vN2FqQncyOWF1eVoy?=
 =?utf-8?B?V1d5cWdwcWpjZk0rN1QwUVhmTWwxaEthVWJrdnNLUHhRZTBhempqbmh3SVhM?=
 =?utf-8?B?aHhkakh1L2ZZUVVseXFpdE1pZ0pnZElMamUveXdTb1d0YnRuaTJScVFnSEFl?=
 =?utf-8?B?bEpqaUN0YVlPS3E3bCtDS1hZTjhlR1VpWkV4eEUrUHkwRVpRakZEQ2pROG1v?=
 =?utf-8?B?MnE5YWx4MkM1bUpseVFmVUdXOWJoMUU2UHl5a01tY3U1ekJCRTJzQWF0Tnpo?=
 =?utf-8?B?QWtSTzdwZ3l4S3JzcHhNWkMzdGtGNEl3c3ZVdzJEQTFxV2oxZ3NZRy9xVExB?=
 =?utf-8?B?Z2ZxbHp6M2xrTFNjTEhpblp0NUlVR1hFK2pyeXg2cnZTVkR1QUZUVmRlMkF2?=
 =?utf-8?B?ZHVyUHRyQWFEenlNdUJRVlB2Z2dKVk4zME9jMWJhNklGeVBUcWFGMlB1dU5n?=
 =?utf-8?B?dkEwV0dQUnVtSWs3RkwxWFF1Y2hGanVUeFp6M0g4R1VBWlNQNlRxbFVWNmZn?=
 =?utf-8?B?cEJOd1NKdUlQRmJaWXZ2U1cyQ3diMjhqRlNGTXg5NllaamtnYXdxUDlSQTdL?=
 =?utf-8?B?Qy94YXp5b054VHBtUkhEbU5wZWFucnFGMk5CY1FST0RPZzlVSFBsLzNLRkhP?=
 =?utf-8?B?M2N1NHZlV080S0xEMnlTQ3hkd1RSc1RvYmNqSDd6dmtVdHFMRVl4ZHMwN1Rt?=
 =?utf-8?B?Q2d6Qmt6YmI5ZVVUaXB3N21WSitQa1BlRjRjSmI1VXdqTlJ2dnY0ZVJPemYy?=
 =?utf-8?B?R3FZWWZKbW5ZdjRDekpHYkRsWUh0eHVQYkdURVVhVzdJbHpHTk84d1o1dHkz?=
 =?utf-8?B?endsdEVHTVh1ZlQyYVhTZEo3Z3ROM09HMUhnaWhqdWtXMUF4aHNlaHNKNUwr?=
 =?utf-8?B?N1pCMWJuNTFEb3Ntem9vQUo1c1BZOXJ2T3NlZ2pIaHJMUnVZdFBtanlWSmhO?=
 =?utf-8?B?WmZtVUZhNzFXbEdiTVgrU2FHbUgrS2pYMlRqbmxjaDlVYUNYWXdRL1RwWkFa?=
 =?utf-8?B?dmdmVE9oREJBZDBXR0JjQWthK0ljYkdsbDlDa1M1V1M3dlBDTXR5czZzN2w1?=
 =?utf-8?B?bGFKb3djdjVJMjBITkxHMFdGaVZyalVGTmVOYVlVeDlKVDVyYjlMbTRoZlRK?=
 =?utf-8?B?L1lmbm5zRVVZMDhSbGlhVHBPUG9od1V0TGlBT09PUHhseEh0UkY1TTI1L01a?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c500a5c-1e1e-413b-d2a5-08dbb0341edb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 06:23:30.9066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjV2ewNtJefKMAK8DxyCOuEQCoACH4IyQApPd2593uMYKk0glPgJ8RG/uiSrXS1Mco23ueSEL/TzhFAPnX1ddoP1eSL5VziQiw6bdy46vfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7762
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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


On 6/23/2023 5:48 AM, Joao Martins wrote:
> Implement IOMMU MR get_attr() method and use the dma_translation
> property to report the IOMMU_ATTR_DMA_TRANSLATION attribute.
> Additionally add the necessary get_iommu_attr into the PCIIOMMUOps to
> support pci_device_iommu_get_attr().
>
> The callback in there acts as a IOMMU-specific address space walker
> which will call get_attr in the IOMMUMemoryRegion backing the device to
> fetch the desired attribute.
>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   hw/i386/intel_iommu.c | 40 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 1606d1b952d0..ed2a46e008df 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3861,6 +3861,29 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>       return;
>   }
>   
> +static int vtd_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
> +                              enum IOMMUMemoryRegionAttr attr, void *data)
> +{
> +    VTDAddressSpace *vtd_as = container_of(iommu_mr, VTDAddressSpace, iommu);
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    int ret = 0;
> +
> +    switch (attr) {
> +    case IOMMU_ATTR_DMA_TRANSLATION:
> +    {
> +        bool *enabled = (bool *)(uintptr_t) data;
> +
> +        *enabled = s->dma_translation;
> +        break;
> +    }
> +    default:
> +        ret = -EINVAL;
> +        break;
> +    }
> +
> +    return ret;
> +}
> +
>   /* Do the initialization. It will also be called when reset, so pay
>    * attention when adding new initialization stuff.
>    */
> @@ -4032,8 +4055,24 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>       return &vtd_as->as;
>   }
>   
> +static int vtd_get_iommu_attr(PCIBus *bus, void *opaque, int32_t devfn,
> +                              enum IOMMUMemoryRegionAttr attr, void *data)
> +{
> +    IntelIOMMUState *s = opaque;
> +    VTDAddressSpace *vtd_as;
> +
> +    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
> +
> +    vtd_as = vtd_find_add_as(s, bus, devfn, PCI_NO_PASID);
> +    if (!vtd_as)
> +	return -EINVAL;
> +
> +    return memory_region_iommu_get_attr(&vtd_as->iommu, attr, data);
> +}
> +
>   static PCIIOMMUOps vtd_iommu_ops = {
>       .get_address_space = vtd_host_dma_iommu,
> +    .get_iommu_attr = vtd_get_iommu_attr,
>   };
>   
>   static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
> @@ -4197,6 +4236,7 @@ static void vtd_iommu_memory_region_class_init(ObjectClass *klass,
>       imrc->translate = vtd_iommu_translate;
>       imrc->notify_flag_changed = vtd_iommu_notify_flag_changed;
>       imrc->replay = vtd_iommu_replay;
> +    imrc->get_attr = vtd_iommu_get_attr;

Do we have other user of imrc->get_attr? If not, what about squashing

vtd_iommu_get_attr into vtd_get_iommu_attr and have imrc->get_attr removed?

Thanks
Zhenzhong

>   }
>   
>   static const TypeInfo vtd_iommu_memory_region_info = {

