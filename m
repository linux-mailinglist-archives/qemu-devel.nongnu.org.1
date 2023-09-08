Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A04679822D
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:14:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUiR-0000sF-1A; Fri, 08 Sep 2023 02:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qeUiN-0000VF-6b
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:11:35 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qeUiJ-0000QV-3Z
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694153491; x=1725689491;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5ij2WKmmIh38eH1YuWKnXCyhrSPeCeYlxyjQkbGi910=;
 b=MNoiM/nfclkdM5HQ3+OKQVeWi8zcd0iHylIC3SN3aHQVjcLtFa2PuP2T
 LPGGB0gdXkHhf6DQmivWcTrmGg34lqD5tQMYz6NI9yunpcwwhfv0MG5eV
 UtCGhPUHVyTu6iiq4ln/gWlBuIRboDJxcTApQriHtAvXFc0KF2Jnfw3l3
 BDdaMgXtbwvk58/bc7DJPYqCPIWPFgmBeEwCO0QNwCwWiUVS8Dbfyd/HI
 k3OF6z2uFNfhhBtvUJDWVTPnr5Z4W9gT9talcuAPMzPwVWAcLn9nOMr8+
 d79D1Da+I91G2nuYZcpUT3ozxgaLUJE4itRpx3iZJYqevZRfyGCN+jSSZ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="444003881"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; d="scan'208";a="444003881"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2023 23:11:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="989106742"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; d="scan'208";a="989106742"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Sep 2023 23:11:26 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 23:11:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 23:11:25 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 7 Sep 2023 23:11:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j++WITf2UM1FsbYq8sQv9AgWqz3l7LqT6KECEazdp3cUBp+R5+u9Urjrgcn2dFSaPmWEG25V1xZe6xypeZeX6dCtggki51a7dVc2+7vA0Xk7w+IcsEr4F18YOUzb+069Lhb0E6jt9ABLHsldhfr1cyJg6PPD2UgiI3qN571W1lOq2mJ2Y60nIRcIexVyAEfeeiIwbss/P3NjDBGWX4WJLF4hGA57k9+t4PGjQk6CiXEWNaixNQPMeSvSpyxQrKJzEjRe8KtkuDqScG7VCap6J1v5JAaM91Yb4CF9W3uO4NC1YP9I5mlbgg1j+KUhy2YNEmT4W5yVRdcNMUoLyBDQnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcvNOKR3z5FJzxcOfk/crtKyYo/UlVxlCUFR97vogzY=;
 b=C+xD8iwIylIB9E7WyTA1/1Js2OoqyX8vVLteuKutgYEvWIOz55ZWRp86/oGikkZ05Yco8fnoDFgHJgRfxVkBppfvAG6i2+2tYN+yXqSruuNtaxYqWXAN27rulDkwxmiXmDloSR0qX/6gxS0fdZ55acRbFRPauqgSklTrDSRNP2LLqrRJrnp2KMRbVwO3TEurK8ZFcapEeFpOjoIHK1vBU1LpuPYC5fkJoNCnAUqkc5F8DidrbP+yXkkYixLSDI6riHVD8qlE0BWpImhujI/GeRoYQV7JRmaaoVvaU1oeZYzfsdpuoGsDAOS5rMT4D5wmNTC6AxwQ/vcFoytayJriaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6427.namprd11.prod.outlook.com (2603:10b6:510:1f5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 06:11:21 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::cac7:3146:4b74:8adb]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::cac7:3146:4b74:8adb%6]) with mapi id 15.20.6745.035; Fri, 8 Sep 2023
 06:11:20 +0000
Message-ID: <de2b72d2-f56b-9350-ce0f-70edfb58eff5@intel.com>
Date: Fri, 8 Sep 2023 14:11:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 12/15] vfio/common: Support device dirty page tracking
 with vIOMMU
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
 <20230622214845.3980-13-joao.m.martins@oracle.com>
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
In-Reply-To: <20230622214845.3980-13-joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c9bdf0-45e6-482e-232b-08dbb0326b84
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R6HV/ayz7LmagFEKONpO/udincnbH5bqcQMASEFgHirnH2OLATNq78UpmfNAjbtIHeRX9/lgvLCCOe5pU6crTFADQsRu6YoMqF2UklQM76Bl2Hv7tZJKG2M4NRB/od0nlQzWIY40pVJ3tKHRp0/RWfsWXnAkryO4IjnBQy698Gv4RWyigNpONWtsL/t4CVhRdOzgd2/Iy77nKHUR648rWAtRNXa6VKoVS4TW8uaaa+2rE9qi+4P69OsXgyM4+AnVy7COz2NN5xdq8pB3wiICvdpimc0R/OFTadgoI5MmCGmr0MUUSMg5xaQuG1xAD9yjyNgOTaYO7nx47wPcQrPzFWMQnfQBK3s9hXh5f1MK8lheUWrAiSXhmTVHa0kplNHhXbId+pAY1m+IxGyQIyCX75uhJLMxb8L8u07dTAnMVNk0m/g45KIdYzyOwjGYbwWOnGWhptt+p5lEQhooOnSdijoEZAdsgL6haQnbg2jun0FNwP226+f3dse6Rgbus7xhk2Ck76d2vF0WO5KmFE8WMApTVTgCj22oDazXzGvFm3H2Zj4wGn7u5FAvaE9XKuH28pbO+sTX18DqPgHouk30OIEOfq4x6D9waVRWGAFw1yrv3C65S4FtoffWxO19uM0bI4vlMH/N9TZvBFkYxdj3eEEUWucJIpRackA/tqzkw8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(82960400001)(31686004)(53546011)(6486002)(6666004)(6506007)(86362001)(31696002)(36756003)(38100700002)(2616005)(26005)(2906002)(6512007)(83380400001)(478600001)(41300700001)(5660300002)(8676002)(8936002)(4326008)(7416002)(54906003)(66556008)(66476007)(316002)(66946007)(14143004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWI2d0lTMEhoMG5qclFKV2lpdnUvRGF6VEN0T2E0TzlhVWxDaUxQUnFSL1BX?=
 =?utf-8?B?V1AxR1NpeEtNSUhhc1BzdnpTMk9uSFVFUHBGK3ZZUkI4N3Uyam5ac2hMTzBp?=
 =?utf-8?B?Smtpa201WnRLM2sya1FaU3RRVGR6SVNhTXpkVkRtRVZZaUIxQWI5enBRc0ND?=
 =?utf-8?B?a0VPUHdRRUNhVzh1c3U3ZDdIMmFJdGRXTHpxMVd6QmpsYjdhdVF0WFluaGdz?=
 =?utf-8?B?cUxralpSa0FreHF6Tk05VXRyTkkzdjlLNEFibmFxa000M2s2bDRXRFdUamJ4?=
 =?utf-8?B?OXFqV0R2SDRxQmFQK3NCTUdTT1JFU1dGblN6SndnK2lJTWhrZ3JkUC9nd0hm?=
 =?utf-8?B?ODFYdlk3bVBiU05pZk5sZXljT3RBWnU4WjVoSlhSMHVZZW5rV0FFc1BUL3RW?=
 =?utf-8?B?SllFYkNSZ3U5b29OWmZiRUc0Z256QjF4VDdtYkU1c2VXQkppbXQvRFlVOUNh?=
 =?utf-8?B?WXBLNnR2VzBoQUdtT3E4WHRPamp3YXpzTzZ4NmlRdzgvM2U5LzR0U1RBZ21l?=
 =?utf-8?B?VVN1TjlQMGNpZ0J2NkxVMHQ1SlpxdjJrY1dRNWdRckQwMXkrbUhPbUF5dFdk?=
 =?utf-8?B?QzhqY0x6MjBNSWxlaHpUZkxkVzFFc3FlWjkvcmt2dGxPZlpVR0JKQld4M1A0?=
 =?utf-8?B?T3lVamxwUXVVYWtGeWwyN2dPajZSLzNRV3Q2dUthQlV0Ymh3bHArV3MwQk0y?=
 =?utf-8?B?emI0Mmcyc1VUUC9PVGw5M01hdWx3QVFDQk9aM1lWampNVXRndERmWEZyZGNo?=
 =?utf-8?B?QWtMUXRFTHMzV1V2MW1wMnNKTmZwTVd5Wkk5aGNpYVV0RnJLY2pYbWdOQ1VZ?=
 =?utf-8?B?QVNpS2gvWjFQVkhVTDNVdUFMQ2lWaTdyUnlneHlZNk1jRVJkSDBrNlBQbkxC?=
 =?utf-8?B?cng0aVVFajh2TkliaitqalZwK1VlR2o3Sk5UeFpZUFlpWlNRTnJ6bWhva1JX?=
 =?utf-8?B?amJUam9uUE1MQ2JpYi80a2xEYXhJOXN3dE1QdXNaeWd5OW1HQ1R5YnRtSEtx?=
 =?utf-8?B?SXhNZEs5UzBkR1pQdTk4aXUzQlExQ2FEWnBzUGk4WjN3dmVqOTF4ZGZmaG9a?=
 =?utf-8?B?MU81dUVnWTlwMkRpK2hTWS9CSExKeTE4WG1uV3ZqdlV2bXZ4ckZSbnNwdTB2?=
 =?utf-8?B?N0hlTDFUMVBXY2d3eXZrUFdnb1lYUVlXRFpiVzA1V29PNWduZllUWFFWcHRo?=
 =?utf-8?B?L3BPZ3ZNTFkrU0czMEduWkYrNHlIaEErSml5OS9JR25acE5QVzNkRVhIMlBH?=
 =?utf-8?B?YWNLQ2hRbEZhY04zTlovYjJoYUloYnZtZG9HT3hlRURJeFJHK0lqVm1kSlFk?=
 =?utf-8?B?b1ZOM2V3WmtkZFI1TENrQmREU2Nya2V4QjM2cDB0Tkc4S2Z3VWpib3J4V0tr?=
 =?utf-8?B?RHViNnh2bWp0RnRiY3g3MS9Qa3dsVGtMa1ZkZHFzYTBFNE5aSEZkQzkzek5Y?=
 =?utf-8?B?RUQ3SXh4cjZRejlUbGI1SHdIb3lpWk9JZTVvUDVoRG81QjlCVU84cGxGUExw?=
 =?utf-8?B?NUUvSWlRR2l5dStBOE1kaTJRTVNNbnZHdmtZcmg1YWZsU0RBcDlySVU2V3Y0?=
 =?utf-8?B?b0J5c2k2ZmE5cXV4RWhFTm90RWhHN0tjZEh0ZHRidktmdWRuMjNXci8yUVdq?=
 =?utf-8?B?RE1lTWRXWjBCRkx3Q2R2UW9SOWxUS0hSOVpoRnM5VnpqeWpobDdZbUFxUVBD?=
 =?utf-8?B?dWRLdHIzSHUrNlJpNVVhUStVTEY4akFJZjhrOE9uVUhUNysrT2RHcExlNkpT?=
 =?utf-8?B?Ny9Ldm9jTEZGaWZkZjdubjZBZnVReVpyQm9GNzdBS0dWUE9rUW0wK1J4MHJh?=
 =?utf-8?B?c2FjeEhBT0tLZGx3N2Erd0lQM0ZGSWlaKy9FS0E0dHpvUUNabXZ4dVRndkdP?=
 =?utf-8?B?OERaTDlLLzNxS1cvWlZoSHQvdktady9LZmtjMERobTJNSHhjVGlLYmRPTktG?=
 =?utf-8?B?Sng0SGVaQ2t1NE5BVWF0WDcvbFhLNkl1Q0JBNVFHeEU0amFoOTZWVWdLbzFE?=
 =?utf-8?B?Q0lYR2hrYkllUGM5ckZoVUM4M0RGRkJKZG1QRDkwQkcrclVuUm5LSUZncWhv?=
 =?utf-8?B?Ymc0YkdoQXcxTlJPMnE1VmtRWHErZkt4aXZhbWdEVWF2a05PWjFpQlkvTEJy?=
 =?utf-8?B?Z3RNSHYzb2Z1aHNPbVlEUUJzNnZ1V1JnZGdrWGpsd3NuWnU3bkRQakRkZElN?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c9bdf0-45e6-482e-232b-08dbb0326b84
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 06:11:20.4854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTEHycLO0zxf17Yat6/CURTaAt58ZH0TyjKa8E6FnIBJgYCbcDu2KjtDzCIfg58sVB6BM3lEGyRj302F5k5BDEsL3pNV/G6tRdYQblT0dho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6427
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
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

Hi Joao,

On 6/23/2023 5:48 AM, Joao Martins wrote:
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

Just curious why address_space_memory is bypassed?

Imagine two vfio devices linked to two host bridge, one has bypass_iommu set

and the other not. Don't we need to include the guest memory ranges in

address_space_memory?

> +
> +        if (*max_iova < space->max_iova) {
> +            *max_iova = space->max_iova;
> +        }
> +    }
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

No clear how much dirty range size could impact device dirty tracking.

Maybe some devices linking to vIOMMU with small aw_bits or bypassing vIOMMU

with small guest memory could benefit if we use per address space's 
dirty range

Thanks

Zhenzhong


