Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEA079869B
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 13:53:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qea2f-000660-F6; Fri, 08 Sep 2023 07:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qea2b-00062Z-2V
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:52:49 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qea2W-0004qM-6r
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694173964; x=1725709964;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rbzkttdxciXViBS2KCb64NUJYqbYcZEGVh7YpUCqGAQ=;
 b=Ly1JL9zY7oK5czCZ++Xt4sCTYVhjv9S0OodAUdjNc+DMc2azlJxB6Sff
 54iPC7WLsYRkkKoOsQ0FdKgvTT4h6uJPOPOyzMVvK9Nks9YC+n0hkbYXr
 qwLRKTs/iDCIG7nI6D3sghkQTDhv2EFmwqHTVDD5/NgRNsRhMvrT/hCo1
 eKTlKBm64/Yw/FMuphzHksZg+3asAPGAJoYyaAGM/sT8o1GfdmtstwZvw
 TateoRPugGIo8k0XGiu/vRn9cJ2evcAFxq2C3HWoUpvrhXH1WIsgFmPdO
 9GhCQBqrEahWZWkLaqAsZZmcNhx2TA0edzz/grlkEPg1EjOH2RhzbB8lL A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="380366763"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; d="scan'208";a="380366763"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2023 04:52:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="832642095"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; d="scan'208";a="832642095"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Sep 2023 04:52:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 04:52:34 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 04:52:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 04:52:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 8 Sep 2023 04:52:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMMOrffGOn+iPSp+KMIGacsAJWyu2jEEUEU98C7G3uZi6ZsGab5q6RFKvtuoHe/F3Hx9nzX28Gubh5pkY3ndzXFdp3lxdqFqNRrRUFhvS47hvelZoe37YcKl3ShEKh499+yNe96bKqr53Is1TbYOfYPj2VCg0P2HwEmuxRFBpr/0aqueH3nscoZuLrIw907m6WxldS6O4N6fjOTAFYmHyMvgU6mvElG+mhBOlfxq62HVAtTK+wv9nSngob8f00BkAzDgDnr8vf+CQHym8Taue5AUB8gIbi6xwm5opC4zBEb5+/6AnS5QSQMKUIMSfaeb7UfSg9PC0jK47FQSoRNKlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEeQG1mBQXEI5FbrBuxfO2RpSIhoNHSws/4VpMlFQWM=;
 b=U3UqRP8AMFDJaBQlqYHxjTDlWeg9YOhQitpeAipTd4vRhGX8zCKlq1BsrblUPVB4gCD3aQlGrz2uaYpcGcLKDE1LALUJC3HHWOkvlkn6afMxB3q+6o0XO8eEJgff5C4YfEw24AMAMFm89OdaeeeO0GxXDAp10bgMmztOaFkYNfwLdi89Kcr2uJhpvN3SBYCMS1qbcezk7ctqK41bWL05AZzvU41C7iunwhAo0HhWLsu4QisonlTKKHDr3V2L4bQ3TUdaff4XtLnbRr7+bovawwRPcvPy4KgG8/Uy2Mshrcd3g3UlLjS2QUnHhPfoy7WkDYFcTkEMV+13kyhotOOs8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA1PR11MB5899.namprd11.prod.outlook.com (2603:10b6:806:22a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 11:52:22 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::cac7:3146:4b74:8adb]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::cac7:3146:4b74:8adb%6]) with mapi id 15.20.6745.035; Fri, 8 Sep 2023
 11:52:21 +0000
Message-ID: <eda120ee-cfb7-3e25-acb3-44d4a6bdbcc1@intel.com>
Date: Fri, 8 Sep 2023 19:52:08 +0800
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
 <de2b72d2-f56b-9350-ce0f-70edfb58eff5@intel.com>
 <5a849c31-ae80-854c-03af-8fe87ba343c9@oracle.com>
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
In-Reply-To: <5a849c31-ae80-854c-03af-8fe87ba343c9@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To SJ0PR11MB6744.namprd11.prod.outlook.com
 (2603:10b6:a03:47d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6744:EE_|SA1PR11MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: 6522c996-4239-4669-39a8-08dbb0620f8d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +d09hR4QSSmdWIXCLC8xF4t3OAFXWSxct0Mnr/YIIm+3jvyTbRl32M/UJbvyAHuKXrfDHVHxI5HHc9YcxqzopJpsWraMNjaAv6AjDo4kdUDBpaG7xKeuAqxsXMrNQ7PLdr2krlcpZii4DXWgEyH7S/+YvyTTvzCpa3S/RShIiynj5Nlon2IkT0T2tnh9Q3diw0PTTTFDzSWgKmh+B6s9nd7TQ1/ZO89Dn74sC1BXgkAoZoh9cXayPQhKWfoOfdhCxEf2BB9B4cxjQuV+t/Pedixvn1YS0DvdDGmgS48blRSxTcOMHgo8bVtAIeD5kR5xRD5jJGcWTqIVVVWSJ7ZF9oO5mTPYGxcLLc8GR+IMPBpp2SRwcnMgDa3PqHFTli37m6PYpZt7EYfm2WorU7QbT3TDuqGcwJ9E8QHVUsspTePTkcfjHQWDcV+7uJeVNmZZSAdsITP4NQR+HaZ19mJ2l+5/Gh/JpIa0woDpnfNE6akRUdA/xCYCORuWNzxL/XCp/PD/rzXRkqaOGZL0OYoLWyqAPELme9M2OquO65+jL/1LkIiVA9EZuv5+BIpYISEiDEl4iszYzMnCWnSaCk74uCplB+4A4p7z/yN1bDj5YuobZ8Q/D6SFPgPxis33W7rXZeW93C4R+1r2GurY0ghaWTb9rd+FqkNbIpOB5tssT80=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(1800799009)(451199024)(186009)(31686004)(53546011)(6486002)(6506007)(6666004)(38100700002)(36756003)(86362001)(82960400001)(31696002)(2616005)(2906002)(83380400001)(26005)(6512007)(478600001)(66946007)(5660300002)(316002)(8676002)(8936002)(66556008)(54906003)(4326008)(7416002)(41300700001)(66476007)(14143004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmtoY004VEkvU1RDWGpFMENlWGdUQ1k5TmZrQlVuMkdrOFVoOUhIN0sxL0tj?=
 =?utf-8?B?WHQ3TEtDNnlvSVU0ZjhnS3E4TWg2a0l2RFBuT0xqK2VpNmtMdjF6ekpySlNo?=
 =?utf-8?B?V3BQOUVKS3N0aXh3V1FSTVVEZHFGUm5PRFQ0ck01YUxYZUFoSEdPYjkzQzYr?=
 =?utf-8?B?dE9nZlJ5VGk4UVc2ZGwvVDl3R0V5NUJFUnNnZWkwVEpVWHV6cXVmQ3ZHZHQz?=
 =?utf-8?B?U3o0Y3BRTWZOdFlWaGU2YkJUZmVGM294YVRxeVNmem4vMEJjcEVERUlXeHB0?=
 =?utf-8?B?bTJCdEZ6Z1N5S1I5Zm82VTNOd3pkQXdDM09kSjZGV2l2dTlXamQ3Y2lIVExi?=
 =?utf-8?B?UzNIdkNrZmdYdkNmWlAwbnBMSEJ2MzZrSDFmbHZsTGhSZm52ZmdqeHlWUjFB?=
 =?utf-8?B?RXlhb1Judi9NZzh3VzhCSFhnQXRzVUFXNWtDcHZ2WC9FanlLRHZIL3NnRjF4?=
 =?utf-8?B?RFI0MldLY3pxVzlDRFduL2ZKelRGcmxSU1dPQ05Sbkpxa0xGdFUzMmtyR0FT?=
 =?utf-8?B?TmRyMElPbklpYnZJRUNDSVcremxWS1VWNk9IQ3FiR2h0NWpWVXU4ZjVHcEZr?=
 =?utf-8?B?bzlrUmJEVHFDR2xURDNtVWI1NEd6V1haeEJVengxOWEvYXp0ckw4Y1M4ZUVC?=
 =?utf-8?B?WEFjSGRyVFd5cTBYSHNhVUF5MWRUQVZKVjhEUTFHbCs2NTJNRHZDd3oxV01L?=
 =?utf-8?B?ZkJqV2VXY0gvV2FBVzVjZFUzZS9SVTJMMHF5YW1ucWR0TXpCVGFKTGE4WGZ5?=
 =?utf-8?B?Vms5MW9kVGpsbmdEaUNYVy9BcVNZazFRVW5oMnVpQWlZOWxiU01Ddm5WanQ3?=
 =?utf-8?B?bDhMb3pSRmRWdEpjOVNVWWUwVjN4MUE1NXBvVGFJdExKaW1mWDBwQUJLSkpz?=
 =?utf-8?B?Z3BGc1V3bG83UllOMDRRZU1ham5MZWxpbmpJQmxKaUZnLzZuSDlrMWNhTCt0?=
 =?utf-8?B?UEpCTFhQanBtUGFTV0RyNXZXTWJtMzB4TXNrQlFFQjVBQ1JRdkYwQnRkVm5n?=
 =?utf-8?B?ZjdpYUhQSHdXU2hZWXpwTTFiL2tJL3dMdkNOTmNwUmEvYlU3QXhzVUpNdjk5?=
 =?utf-8?B?NTArVUhNRktqOE5VOWRQOC92UW5mVE5SZWovNy9oLzNnMmNaN2JiOS9Tb2FI?=
 =?utf-8?B?UURkZXU4K09QWGxOMm4xNW5BOERWYlhDdGN0MVlDM0YrbzhISzBqblRjZmdl?=
 =?utf-8?B?NFZxcTA1S3d6VzVDdTFlcXlLZ3JZSG5mOGpxNWJEL2JFSDA5dEdZTHZRempw?=
 =?utf-8?B?aFl0WmJlZHdWNERmdmUxTlQxbmU4ZkhzK2JTYTlOQzc1bytoSytmRXgvalVB?=
 =?utf-8?B?VVM4bFVrckZiZnBkdmxxVkxzSWhjcU52Q3Ztb2V6ZFN2UDRrNkhPODdxWEx0?=
 =?utf-8?B?bmRIL0EvazZXV2UxZXVKUUF0VW1WNjhQTFR1Vm4xSEx6UHpPTE1Zc0hKZ1dl?=
 =?utf-8?B?K0JDQytmRlpwVFRIa3A0WUF2bHhucWI5OFVtd0ZhaHFMelVwTU9kVzZlcWNq?=
 =?utf-8?B?RlFEeUJnV0lCT3N2b2lKclpXcEszb0MxYjJPeU00YXpFdFRYbzdPY0QvR2R4?=
 =?utf-8?B?RW1jMjBJQnhSTlJsOGo4amg5VVZGVHJJT1YvVEJ2M3REd2F2NTFselpURmV3?=
 =?utf-8?B?dGQzYTlLbWRRWjl5QS84TmRobjh4ZTM4SDUyT1JkS3lpL3VjUzRBSS9xTWRj?=
 =?utf-8?B?YzVMek9VRStwdkpISXY3akRzLzNtWUl2azNwdDAvNW1GZHkyZFpXOTIrZ3hS?=
 =?utf-8?B?cW1vWVJDRzFxQUtTY045NkZQc0N1c0g2eCsvejRoTHUwV3Y2TjNxZzJQbDc5?=
 =?utf-8?B?Y05yVytjNG5uTjVyZEhJSDFZMVdtL0NKNjB6dG1uMis2U1hPWHk1Q2JkTVU3?=
 =?utf-8?B?WWpVVVJWNk00SlZ3YlEwdTJjMUJPc0JZOXlRa1FnMVR3OVZBYmNMN21KNjFU?=
 =?utf-8?B?ck1KdHhiM1RwQ1FnbG52M293V04rZEJUZ29zMyt3L3VOTVE3VDAvd20zMWRV?=
 =?utf-8?B?RjQ0ZkN2MkZUVzJIcWp6MEFibk45V3dDb1d1QjZOTGlUT3U2TWR1QThlbER1?=
 =?utf-8?B?Um45cnlUb2w5YzR0a0E0MVhvb0d2US9QM2E3cnlWM0dQcGo1NnB0eFNNTWJM?=
 =?utf-8?B?YUJwdmVNbXNMNlVXV1J0MGZ5c1ZjLys5YUMvN1NrbEphdGYzSkZXTGpuMVc5?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6522c996-4239-4669-39a8-08dbb0620f8d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 11:52:21.8839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HGmS/sCKNwbIWeZNkljwAJgnkBV2Wg1XXdaMTyEiVweYNRNg+Q45ZyUg32AaPYj0c7En2yRSwCHEYsyofHySiQciRgYilWswF5g3dYdzBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5899
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 9/8/2023 6:11 PM, Joao Martins wrote:
> On 08/09/2023 07:11, Duan, Zhenzhong wrote:
>> Hi Joao,
>>
>> On 6/23/2023 5:48 AM, Joao Martins wrote:
>>> Currently, device dirty page tracking with vIOMMU is not supported,
>>> and a blocker is added and the migration is prevented.
>>>
>>> When vIOMMU is used, IOVA ranges are DMA mapped/unmapped on the fly as
>>> requesting by the vIOMMU. These IOVA ranges can potentially be mapped
>>> anywhere in the vIOMMU IOVA space as advertised by the VMM.
>>>
>>> To support device dirty tracking when vIOMMU enabled instead create the
>>> dirty ranges based on the vIOMMU provided limits, which leads to the
>>> tracking of the whole IOVA space regardless of what devices use.
>>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>>    include/hw/vfio/vfio-common.h |  1 +
>>>    hw/vfio/common.c              | 58 +++++++++++++++++++++++++++++------
>>>    hw/vfio/pci.c                 |  7 +++++
>>>    3 files changed, 56 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index f41860988d6b..c4bafad084b4 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -71,6 +71,7 @@ typedef struct VFIOMigration {
>>>    typedef struct VFIOAddressSpace {
>>>        AddressSpace *as;
>>>        bool no_dma_translation;
>>> +    hwaddr max_iova;
>>>        QLIST_HEAD(, VFIOContainer) containers;
>>>        QLIST_ENTRY(VFIOAddressSpace) list;
>>>    } VFIOAddressSpace;
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index ecfb9afb3fb6..85fddef24026 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -428,6 +428,25 @@ static bool vfio_viommu_preset(void)
>>>        return false;
>>>    }
>>>    +static int vfio_viommu_get_max_iova(hwaddr *max_iova)
>>> +{
>>> +    VFIOAddressSpace *space;
>>> +
>>> +    *max_iova = 0;
>>> +
>>> +    QLIST_FOREACH(space, &vfio_address_spaces, list) {
>>> +        if (space->as == &address_space_memory) {
>>> +            continue;
>>> +        }
>> Just curious why address_space_memory is bypassed?
>>
> But address_space_memory part is done by memory listeners

Only this part. Still think about the case with two vfio devices, one 
bypass iommu, the other not.

The device bypassing iommu will get address_space_memory, the other get 
iommu

address space. vfio_viommu_preset() return true for any device, so we 
never run into

memory listener even for device bypassing iommu?


Thanks

Zhenzhong


