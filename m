Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D2E71900D
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 03:32:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4XA2-00064r-J8; Wed, 31 May 2023 21:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4X9x-00064K-2J
 for qemu-devel@nongnu.org; Wed, 31 May 2023 21:31:25 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4X9s-0006Jf-9e
 for qemu-devel@nongnu.org; Wed, 31 May 2023 21:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685583080; x=1717119080;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=abeVZ91skAnAKDCpGr5lCrzvTmQVMxd+92R1f13hFXE=;
 b=IiVz+h5IOx49By83o/QxO3kAkYyv9/t2otAbc1n3QDxa3djZB+FaBVo5
 rebHGc2Wd0F4dCSB6GMLyoKQMuDwNEyxfbobql0UaI7vZYyzZfAtRZmyh
 zKmUWaqqP57Sehgx7J2PgdVp1WTkYhWlu5uOuPwFl5xuM6jM3DArkD8d6
 eifCvuu019Uywis3+CRZ0GHR8QETwvPEVtyWED0UlqkHojpLSEdvCUFhs
 6CXb25sNUhAlPR7Kh4By3ZihKjaS4zhJfzgJwx/kPGwC257OWmYkDKwf4
 48XNu03uXlmaarUSod0lzYtVyvVIs4/rM5ZNSzGu3mXI8JbIJZ9mPau4v w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="354268812"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; d="scan'208";a="354268812"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 18:31:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="776964353"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; d="scan'208";a="776964353"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga004.fm.intel.com with ESMTP; 31 May 2023 18:31:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 18:31:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 18:31:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 18:31:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQVfIKPngVYrFtggFiZK8IA0FfnL0P1vDKOPqLAPBf6NRAyGQ0lmSe357B3scvVQBZ9XPhCbDSmlcHol6ZZEnQWgeQ9vgh0Jztv4+7Nx1aS/HOZvSP/qoDlTdp1gMEgmGl2lJF1cvMa6zSadpDCQMw5h2j6IE6yeu3IQBQh3JCEqG52lkf+pwUDRSDdRV0DyHvXgs3nXmx3mSBi/NfelR+i4aY6TjsrYA/IIbU36506h7H1zmnQSd13xD4va/tH0RODv4O2putubxGQ7tFIYJSCBJDPS6EjBDuwhQDbgaV2Q664IFfpR6TbAQZSnjfCFis7rlZIgBaZn1VZQusr2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2J1TgHkTNxbkES8XtwNL/es5kcrwKFbbrx6wRJPN4M=;
 b=NbjLm/JAcNBiuniK1k4fQbKhInrA2nfcOmMl/4SCc6MDRg43g++qx3sOHMRy5L0U94gwpbiVF26nVz3BwPoRj34NBjS3IEy5Hr7gkhpobpswyZ+JcNVvZFHzpUX6kUliRGzLyKUnVAtyI0irgL5NNc7fWDP49VTCgL+gNen4+9JkAaEzTi104pFjF5WV/AZst3Zmk5LdB99CluPHGkve7ELGEVP/dwaahXcoRrzeUBZpOluyZyDRYbiDOpItpsY6sd4qVYQ60acxkF+Avlmv1dv3WDPJgfm0A8G56PEccmBbvePeN6Hb2i3r8hVlxdfWQhIXS8sEXXTVnmqMBVP9zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by CO1PR11MB5121.namprd11.prod.outlook.com (2603:10b6:303:98::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 01:31:03 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 01:31:03 +0000
Message-ID: <beb21871-3661-3096-2317-2cfb16bb0327@intel.com>
Date: Thu, 1 Jun 2023 09:30:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 02/10] accel/tcg: introduce TBStatistics structure
To: Richard Henderson <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>
CC: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-3-fei2.wu@intel.com>
 <3653fd43-6fde-7974-f723-51f1c06c069f@linaro.org>
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <3653fd43-6fde-7974-f723-51f1c06c069f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|CO1PR11MB5121:EE_
X-MS-Office365-Filtering-Correlation-Id: c517c09f-bca6-4123-f20a-08db623fdc8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tB6loHMWkxdjjpfPz2SOiAXuCifj+uDQrvwiBD48sm5DdNKAkjrvY1O7VOJ9j6Al3zxGA7XkjoFCN06tA8k3Un/FJouEg+3ZJJ6A7tBtceZHeBOh+b4t1hNfAm+C1s/Q/Uphg/5xcD8f59laln0Ahxyl8Bli+LZ9ljF04QWO8H8Js75dLn3l7VFVYSkWRxRHFGoj5G1KcuxfXgEH42hlBqTq2hExF6ktrrHxatVXICdbFz87U/jZDXQrDI0Ec2dVMQql21uJpcUi24xqe4ysKZbCWXcBeKYUuazo9YehaItgQnHPCXwyLvbX8+ckEAfNlkKpkvZGwEWVW+OU+efXzvwUna9UZZ3Um59shnx0hXOtt8hkZy22etmLQC1+9NoFZl55a2gKoyrCh7jTSHmLDHCQR7FnKSrOfKmQWbOD99L9nZiUv4FAH857Cab/oQNSICKhrkgGMK5B4fUbKcGibWlhDXXFfDgn5gJ2TJgpcBjR4PlX/NBX4Z0AI4umlqWbPbgGScuCHoWRR1wtPIck1QRmKodZ5MuL2fz7YhFw/WzYXXkqNnHtVWg2HhIxHg5z05MJgcXw+pmXEZKBtW8wP1pYzJhjFTtApKfG0mYBTmWKYTh3WZclhZ8clTTvlqo1b4hvVQ8G4RKHYnj1mmGpuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(86362001)(66476007)(36756003)(66556008)(66946007)(316002)(5660300002)(6666004)(4326008)(31696002)(6486002)(82960400001)(8676002)(38100700002)(8936002)(41300700001)(53546011)(54906003)(2616005)(2906002)(4744005)(6506007)(6512007)(31686004)(186003)(478600001)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW41cVRNRTRSQ1VQY2JrOEJ2aCs0N1ZXQzQwazBhVGVNZm53NE81NHlkUzZs?=
 =?utf-8?B?SFhZaXlDN3NURUV3dGE2dG9UamVwY01iWWZjK0JEQVhUM0p5ekFsNm8zWGR1?=
 =?utf-8?B?UUpTc0pJT2ZMSHJSNmdGUDBjMExQTmJGd0JzcUg4MnB6VWZkTzJ6RkdtcndK?=
 =?utf-8?B?bW1HS3lIZjM3UzB3clN0NllVK0JXYnhMeG9Sb3c0S2ZUTzErSjVacm56VHkv?=
 =?utf-8?B?N1Ewa2RnOWpCMWRTUWdMRlZDbVNTWGQxM1o0MGlwc1JmbVh5UWJiODBQaGVG?=
 =?utf-8?B?TDVnQkhIemNxOE9ud1N2cE9sTFd3RE80SGZzMitib1RFbVZ6bnpBS2hBVU5u?=
 =?utf-8?B?N3J2d2hTL3IreXl4anU1UUxjQlRpL1NKSWxpbEdzS051OHBka1NvaTM2NFB2?=
 =?utf-8?B?UmswWTZOamF1Rkw5c0QwQVJKZENTU0dNY1ZOa0JIUk5VMEE5NDAwbCtEZ1Vn?=
 =?utf-8?B?NXAzYlV2aGxybTNlK1RpV0NKQUt4Z242ZWxJdERsOHI1NUtEeXgzeE1TNW1r?=
 =?utf-8?B?cUFQL29EYlFKQng0T2lwUkU3ZDczT3JJTGJtME9vNk43NHpIOW91M2Q5MEE4?=
 =?utf-8?B?bjQvY1o0K1I2Mzc3cEllVndwcHBsQmg3ZHhBNk5RRkhWR2hHK1Yxc1ltZE5r?=
 =?utf-8?B?MVdCWUtidUN2dmVES1ZmWnprYmdXUE92SmwvcnlPeVVaSUphSjZyRGROL3lX?=
 =?utf-8?B?L2daM3JrS1c2bEpac3VrbGNvSDJ2bCtLY2E4Q3FpbUxCaDFoK09GNWJNeHlI?=
 =?utf-8?B?NDh3UUZXR1pGTGlENXg0UXlDNXBoNXcvNS9SZlhSRW1JUmt0a0VvOGkvZnNy?=
 =?utf-8?B?bzR1cXlrNWVmZWxKUkZOVjA5L3dPSEpMZVdINzZRaWpPOGFydXVabWVqWWd5?=
 =?utf-8?B?STNCZVZiWUF0dTRmL2todVI2Z1RzUUhVQy9FOG4yZ0oxZVNScDR4c3dCTEJ4?=
 =?utf-8?B?YkVKRE84ZGJQdjBSZDVRbjQzUVd2STZWZWxSMVc3TnhENUxaUVAzMEZCOGFU?=
 =?utf-8?B?MmFoMENvTjNwZktsQW5mN3Bqck9sUnAxVGxYcy9iOGN4cThkWkQwUjVMMlU2?=
 =?utf-8?B?bnozTTU0d0toVnY3V3Zad1draFBicW5oS1pZYkFGUDdoM3ZxR0NnS3ZFQjdD?=
 =?utf-8?B?NHpyMW4zUmhyOUtFWWdWT3VoRlk0M2MyMkRiaDE0dEtZOXpDYS9tVlcyc09k?=
 =?utf-8?B?blJRRzN0dEVHYWhpY1NkOGFvZmdCK1BFTzlSSGJSN2NSdDVGVXhZMm0xVmsv?=
 =?utf-8?B?Vm1sQ1RFMGt1a2kwaks4QmdSRG5pSnpIRjBLOVRPVS9NTE5TeUgrVjNPcVhw?=
 =?utf-8?B?WlVsUElqT04zN244ZzdrRmVHdjkzT3Ard1BIY3pKSWRWYStkc2VqSTg3WGI5?=
 =?utf-8?B?OFI0dG9WTmluaGZvTjJXbk1QU3RYTG14YnNCajBaejY5NCtVMHlnZU5zN1kx?=
 =?utf-8?B?SFAyUUJ2T0F3bTZoM1FNMUtjMWpTRHNNUGg0Q3Myd004eXA4MXpsVy8vR3RF?=
 =?utf-8?B?RTRGcHU5dXQ0VnN5QkJkQ3lYdCsxMGRBU0FtOWY0ZVFGR2M0bWVZQmplL3lt?=
 =?utf-8?B?bGVsWVFsSUh1dEFWUjE4UHNSZDNoZ3NDN1JsMmVsRXoxZE1iTG1FKzYzUDNx?=
 =?utf-8?B?N1l2R3V4d0dJQjdZQmxCZWtxbVlFSDVmRUxzaU9Sbnp5Snh5NjVSYTNsNHRT?=
 =?utf-8?B?YTcwN2JrajM4RS90UHNTQkVUMkhzOVY3dUNvN09FWk53d2tQODBsTjBTVUYy?=
 =?utf-8?B?MVR0MUpHVHN0Tmt0bUtaTFA0ZkE5UWdiQ3c0ZFh6SlFGWjhhcXJZZGlDSDFr?=
 =?utf-8?B?c0puSWNnWjJOb2FPYThqUHdDTHdEMGxoVkJhUndUdG5FRUtNelhFVzhTWnRv?=
 =?utf-8?B?dElNdlhGWXh3ekdua3RCMEJiYk9PR2Q0elBnajVwRmY3NDdzNzdyVHVxcHdh?=
 =?utf-8?B?a01sN1M3WFpieTk0Z0RYSjdoM25XOWEyN1Q3eEdMRFJqZjhjRXJiR1pqNEpw?=
 =?utf-8?B?VGN1bjhwcVdBWmltcldmN0VSSXVpcFNOQkZwWElLK3g5ZjRtL0xSU29iT3cr?=
 =?utf-8?B?a3BuTWpzVE1yL25VaGdFT0htdkNtbkF0TXRLSHVRREp5ZnFMUmpXYW1FOERB?=
 =?utf-8?Q?RYmzp0aHwxEUC9/D0S9gk3eEJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c517c09f-bca6-4123-f20a-08db623fdc8b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 01:31:02.8848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bz8G9F1Zbz/Oc3d1CRWHK+2gLAZ9rJOuNHgF3bozdtggle4qseHKwxK4l4gdf/iCy9eWpiC6HSiqctqBJtvcKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5121
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120; envelope-from=fei2.wu@intel.com;
 helo=mga04.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/1/2023 7:59 AM, Richard Henderson wrote:
> On 5/30/23 01:35, Fei Wu wrote:
>> +    /*
>> +     * We want to fetch the stats structure before we start code
>> +     * generation so we can count interesting things about this
>> +     * generation.
>> +     */
>> +    if (tb_stats_collection_enabled()) {
>> +        tb->tb_stats = tb_get_stats(phys_pc, pc, cs_base, flags);
> 
> If cflags & CF_PCREL, then 'pc' should not be cached or matched.
> Using 'phys_pc' will suffice, so pass 0 in that case.
> 
OK, tb_get_stats(phys_pc, (cflags & CF_PCREL ? 0 : pc), cs_base, flags);

btw, is it possible to drop 'pc' even w/o CF_PCREL setting in cflags?
Two TBs with different 'pc' but same 'phys_pc', are they the same?

Thanks,
Fei.

> 
> r~


