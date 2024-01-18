Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E0B831AF1
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 14:58:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQSuQ-0006kW-5i; Thu, 18 Jan 2024 08:58:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1rQPQI-0005BJ-UO
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 05:14:58 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1rQPQG-0007cX-PW
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 05:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705572896; x=1737108896;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7mAHuamwQFoLfXJC0uGNMuMRfKe3et7Xliu40BfJuzI=;
 b=Q9rhJFnNeCzETRDKLr0Wk7+yyo04RqriT6h3S9ENPLuvoHNyFAnE9/o1
 Ot4bOYHiN/YWrdCetLk43wT7HiCdYvvmA0xTBhe6Q2u+1FnvYSlTOh64V
 CDe+ui2uASe1y06dyOc5zOw4wfXGOdsFtGilmJrrzPc4vp3gQOhIe8Q05
 F+M2KEBo4DZmgYnMlcnyM0nqqKk+/aPmAbISImPX/jEjYDhLG4o0hFt4B
 eC6oGJr/HG9XMMQEjykMetHdG/97qvcDBw4CkSuW55QlWsP0GqXJli3fq
 bguH40Tqr3o0yH+IEucxrBRmrv+egqO26R086S+b6W8oGt/QdXrnRL1RE g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="390855793"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; d="scan'208";a="390855793"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 02:14:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="291534"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Jan 2024 02:14:53 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 02:14:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 02:14:52 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 02:14:52 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 02:14:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdpPlhOg3gEi9ayFUYbY9qgt2nW2kP3/fc7gBAU9tsfbqXW6DsJ7heEoT2x0rRnXQF1sPluF6m1lY6COEnrEe9VmSxBcJ/tO1MWYlbZ+GPgQ+sn2Bu//eF+1B0BjWhz/7UWYaG26WMjPOrHFjMykcoVx5eb4oO2KXwxDJNEIFzD/A3eglxxDEefHvGa05XXb7PWISvQFGImuQ5r2mFG1tkR3waW6Nn1qi+K+wd5zckZGQstzha/I5XkZkl97zCw7nSzq9gPNxb1KsLkWuhmMmnNcm5A5Q/QojAYmahnlXaICABwLymoKCSSdR0jxvQ28EwxEfJyw2urZMDM4AyBHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15/Ghwi5bXmxuqV13ckcPrkZQxwMbbHGS+tB1rvL5c0=;
 b=I4dtPx287Vq78O+gNcN7FToOQNVgQ9NkWzNNhBr5BPICWiEl0viSP1MpldnscFygTD7V8Oebk8xA/6PXVVa7Z2aFYmdb6GYobs1/FTYwV/E8/oBU1ThhMCzt0RQZJKVmv2ZqFrY7UKJSvF89uyWz/f0MB7Ua9kdKieO26gVESGl3vHsAd8a//R5xNpVQdvXXcTUvI9XmwHQ1pk7nR0jB9/A6kZ0NkZHRf96eaQw06b2RG1fT+BLchoccV6lc1sOXW6XUlwUe0LdEaRPTMg9LsthrW78wd3de1UYuW+vaoO6FYnbg8s7PM/rNC192fJ0FBkjUe1ws6uPDxKgaJ2nU9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by BL3PR11MB6361.namprd11.prod.outlook.com (2603:10b6:208:3b4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 18 Jan
 2024 10:14:49 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::a421:69e5:14fc:79d2]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::a421:69e5:14fc:79d2%2]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 10:14:49 +0000
Message-ID: <d495ced1-7145-4228-8927-705646fc0303@intel.com>
Date: Thu, 18 Jan 2024 18:17:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv1 4/6] vfio: initialize IOMMUFDDevice and pass to
 vIOMMU
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, Joao Martins
 <joao.m.martins@oracle.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-5-zhenzhong.duan@intel.com>
 <d6b4c54f-f24d-4e30-9e93-9c126a42e00a@oracle.com>
 <SJ0PR11MB67446801223842563733262A92712@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB67446801223842563733262A92712@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0123.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::27) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|BL3PR11MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 207d1be5-5795-4c38-dbc0-08dc180e4d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7LU4o0Zp+QFNUXu+DD6wFFZMBgTYDSdVkK1yzRhntof/qT2uAfCQrn92SSFruukkp/dyA+mflVodmoWQpb6NDrRK297vUHQunlPGHz4k/VDH361EwPlgqh8Y1zT5swCJLxR7pN/DB6jMt+gz+RgdPYfnMkEaQt6jElThO3db1wwCLPFdQuSrXVMosNS1FCbod54E7rZJ2IduGQWaiTyj7Szp8uBJd8BL603Mx4b4dVjv+nz4bLQMlrzNA1/4K5kCL2NlcRcFsabWRlXlZU+vm+VssyS6bL1Mfwg3kZam9oo8OpxX4KUx46Y8oIsea1ApVW1VVr5wdmqZDeLF/BKLIBsESEUoFL6OfDHiXg5OWrodDfrS2LevVfJes/gPBV3Vr0SciHDyWuCM45G40OKQk8zWKSCYNAWquTs08e1+gC+A4hRgzU6b2P4y42Obsz7+g2D8Ab44jelCNfnHWZ7Ffy3BrFqAXAxYEQNcQEZkK+h/wBw/6yx59FFXGzDfNWFrwooPO4ntbIba4f/7r4hGGW4acdju8N5b5U7udwdJKOBvCoBwOsJginWU5JppKiGCRe4jDDAEooiAfSp4Zpe8AqxvNUfYmXiiVmdILd5aaYvrJQ6g2avS94dLvsJjm0JKwRfAGQwNeUGMQISRlFs8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB7540.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(6506007)(6666004)(7416002)(966005)(53546011)(26005)(2616005)(478600001)(6512007)(5660300002)(86362001)(36756003)(38100700002)(41300700001)(66946007)(82960400001)(83380400001)(316002)(2906002)(4326008)(8936002)(31696002)(66556008)(6486002)(110136005)(54906003)(8676002)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXJMWXFVZ2l0Mjg5VTAzNlk1cENvMkFhcHNJQVZDR3RUaWNKR0lLTmR2S2g0?=
 =?utf-8?B?ZjNNSVI2ek5wSDNkYjl6NTZpS3RoRlhHZS80TXlnVlNWYzcrek1zUTN1dkZC?=
 =?utf-8?B?M0t4NEd0NEhaVG5wcTVqMTZnaFhxTDhKRzQ1UGFVMGZxVEcxOFdxb2EwR0tH?=
 =?utf-8?B?d2NLVGxURTRsa0s2NHlZdmsvdVlRNVdGYzJUcHA5QUczYkEzQVlET0RsbS95?=
 =?utf-8?B?Z0ViWk5ZaGxTbC9SYytnRS85UmpTSVZqczBZdVJ4UDluejcyYmxqMVVwaENO?=
 =?utf-8?B?Y2x2Q2hxNkhOQWs1aThqU25zMXArTHhkc05ySytXVUY1NnhzKzdZeng4OWFs?=
 =?utf-8?B?SHk4NDZkNnFXMkRVeFdsRWZ1Q3V1L0hiWDYwb216M1NiRWNjYUhVcmZ3S1Uz?=
 =?utf-8?B?S3YrZUwwc1pmNWlwMXJ4a2JRY1IzMmVTYjMzMzhmTndQRVJnSFh0MVpQWVE2?=
 =?utf-8?B?QkZ1ODlaMDlBVjZnZHhoblBZZ094ZnRnclJiUzNrRVRqMU9ITFQxZWUrYnJ2?=
 =?utf-8?B?ZFhMU3hkMFhvbUhsOHlGVFg1WDVsRHFia3lIaTMzdFk1QnFQK0p5akgwNFVr?=
 =?utf-8?B?M3R2dzZlM3JMaXlPMytTK0FtbXAxUDRVaEtZbzl0cGFVL1R2V25XdkgwMDll?=
 =?utf-8?B?eTZsOTdmc0hMeDRyc3VFd1RaTHIyWllxQWg1SnFpZU05Z1MyZjhCYVNLdkNo?=
 =?utf-8?B?OXBJV0p2Tm9zdXRyWWMyZHVBUkwzNVRsTjJQSnRYY2hFN1orajQ3bGJrSDha?=
 =?utf-8?B?MVBrelVZYUdEaFdNMEltS1NKMkZCRThyMk5HNnZ4amRYaFVBd253em0yN0lW?=
 =?utf-8?B?REgwYUFQWmk4Sjh5aVd4OHNqRmFHaDBPYnpmQzBYVHZ3OXNyTUlPN0JsZTdr?=
 =?utf-8?B?czlRSURqOHpzRTJHNWtWL2p3eGNsUEpSNFVuRVJpVml6bXpvRmgvRDFVV0FI?=
 =?utf-8?B?TDRvMFcxUC96bCsyNGtua0JXQzUrNmZmU25UNWlzYzNxdHpQL0E2VnZZWDJV?=
 =?utf-8?B?L0pMbVNEcW9KbzNwRVc1LzZRUFJCdWp6cW4zaDB0emlCT2wyZURhOW1oemN3?=
 =?utf-8?B?Z3BwdmlVV0Z3M2RuN3JybVhBZ3R1TmkrbGk0eThacDJiOFBqNEpLS2w2WDI3?=
 =?utf-8?B?UHBZc0laSHBSeDlBVkMyazU2Z1dDV0J1c2dWcklTTGlSc0gzTUFWRHI2QnNV?=
 =?utf-8?B?czZtZ1JZd2ZrSWdTcXdXK3BOU3BLVVhDT2gwR2JtMTRPMmpLMVRneGd6Nm4x?=
 =?utf-8?B?dU12KzBNanJlQnFQeG5sbWc2MGdYN2EzdTlJMHJVVUJHSlVqMEpBRjRwbXVo?=
 =?utf-8?B?LzBtRjJmdzlzZU9JbEVhV21jdzRRZTdCeHAzczdYK2dTVkw3c3hmVjJtZzRY?=
 =?utf-8?B?Uy85OGNLNnd3OWpMN1NFK0ljODhtUnZRS2lLSUxLT0ZwNGRlMURjOGN3TmVE?=
 =?utf-8?B?RHpoeU5QRHRTS2ViWC9weGRKYzBIUzBYMjRQNk9wMFY4ZmdCNy9rdS9pVzVy?=
 =?utf-8?B?NENyNVhlL0oxenFkZGlpa2pPRm12dDlLckIzU1lhTWg5SmIwYVN3ZVFXVEsv?=
 =?utf-8?B?MjNkUk0yb2ZnU0dZWGxRajNmdlFQcm9nbzJGYWlvL2M5ZE5FeWZLWFhUSko1?=
 =?utf-8?B?Q1R3bWpBWGJIS0UvSDBrMmJxYmRnT240ZkZYVDR2V2RoT0crNm9pL1pkMmYv?=
 =?utf-8?B?MjE4TjRWdmxlUTBHTzhCWHM1V2Fhb3ozUWFHSkpOMEZJVWtqWEtVbjEwdThP?=
 =?utf-8?B?Q3AwaDcreDdZeG03U3k0andnTmpVNlFQZHVjcTZNSlNtbFhad2lMSGl1V2Z3?=
 =?utf-8?B?M1JrV1Y4akxzV2djdTExNlZHN1NGM1FYbkgxZVF2UUhFcHdYZEhiblVhakRh?=
 =?utf-8?B?MEk5UzQyVjl1bElQbkw1OUU0ZnpBMkNwMkpwK3Jac1Q5YTFnSThZRVYrZUs3?=
 =?utf-8?B?TE8wS2RNTi9xNmFveGxVUWtTRFpjY0JjbE41UFlJNVBueWVRL3UwazMxTk50?=
 =?utf-8?B?WTNkQzNWOGd6bmJNR1I5bjFNdE1xRmJDUUNXazc2eXJrQXdKcEt1T1NKZ0h2?=
 =?utf-8?B?YWl0SnZuNTBHSjRjd1hLOEVXYUV2U3RFK0ZUdXZoT0p6ZktPbFFPcUtnTjBs?=
 =?utf-8?Q?ECDSo4+mHXI7Ncp/HVNkN1eSX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 207d1be5-5795-4c38-dbc0-08dc180e4d91
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 10:14:49.2690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/zeOmQL1etub60IBm1UxMwQ9jXqBPoobm/BOUYPfQgLscCYugUzGQzpYmq5Lz8/q8yq98Z20QrfeFX1DEA05w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6361
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Jan 2024 08:58:10 -0500
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

On 2024/1/18 16:17, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: Re: [PATCH rfcv1 4/6] vfio: initialize IOMMUFDDevice and pass to
>> vIOMMU
>>
>> On 15/01/2024 10:13, Zhenzhong Duan wrote:
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 9bfddc1360..cbd035f148 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -309,6 +309,7 @@ static int iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>>       VFIOContainerBase *bcontainer;
>>>       VFIOIOMMUFDContainer *container;
>>>       VFIOAddressSpace *space;
>>> +    IOMMUFDDevice *idev = &vbasedev->idev;
>>>       struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
>>>       int ret, devfd;
>>>       uint32_t ioas_id;
>>> @@ -428,6 +429,7 @@ found_container:
>>>       QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev,
>> container_next);
>>>       QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
>>>
>>> +    iommufd_device_init(idev, sizeof(*idev), container->be, vbasedev-
>>> devid);
>>>       trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev-
>>> num_irqs,
>>>                                      vbasedev->num_regions, vbasedev->flags);
>>>       return 0;
>>
>> In the dirty tracking series, I'll need to fetch out_capabilities from device
>> and do a bunch of stuff that is used when allocating hwpt to ask for dirty
>> tracking. And this means having iommufd_device_init() be called before we
>> call
>> iommufd_cdev_attach_container().
>>
>> Here's what it looks based on an earlier version of your patch:
>>
>> https://github.com/jpemartins/qemu/commit/433f97a05e0cdd8e3b8563a
>> a20e4f22d107219b5
>>
>> I can move the call earlier in my series, unless there's something specifically
>> when you call it here?
> 
> I think it's safe to move it earlier, just remember to do the same for existing
> container.

yes, as long as the input of iommufd_device_init() are available in the new 
place. And remember to destroy it if the code failed after initializing
iommufd_device.

-- 
Regards,
Yi Liu

