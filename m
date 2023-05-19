Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7475B708D34
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 03:18:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzokI-0003OI-HM; Thu, 18 May 2023 21:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pzok4-0003O1-A6
 for qemu-devel@nongnu.org; Thu, 18 May 2023 21:17:13 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pzok1-0005o0-Ck
 for qemu-devel@nongnu.org; Thu, 18 May 2023 21:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684459029; x=1715995029;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CYRe+mRSP+HCpS1ufHiiWruKpjIBOKBLfvWd7F9dLpE=;
 b=JjeIMzdnnPmYZGT/pQd7hw+J5UCyH3qLgnVntbNUnOO6BedKp0OPXorS
 F1QjMdXW6dMuq+rA9WNJIYZ+J1/AS52hUUFqvE8PZjqY2G66TC+PesS98
 ZL2ct0yGj+rC2xfviJpDtKA58XDKwY4nGFVlfoAG362jT/fdPM8JbIbAF
 SOC/bRoNFxlYkGJxm6zLs5V3SnWtZvYF7ORDWhn/6ptiG4g4pPdDmTbTU
 n02RCPxrS4BR22qh1q7675K2rbWqE6YUe0A6GmBLR1R+EvSGhd6dYjL6m
 qCTOWiJ7w000xZNrTJOoJtjhE2hzp38M8bbB/d2X//kYWxuZd2QFl0hWr w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="417934961"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="417934961"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 18:16:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="814539659"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="814539659"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga002.fm.intel.com with ESMTP; 18 May 2023 18:16:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 18:16:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 18:16:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 18:16:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFbNwpbnshy9xePcQCRFl2Toui+uESv5AVjb3DIUBRtjGjkwr7260bicrh2g63NIzFc78XXiHyzJBZqQaqNSPWWnRNMfLCxoX2+3PIW+8uI9SFr51PN6pFlczZtyVjVk782dDHmIGKLpNFPT8jrn5ekOAIrVUjX+/4ZIBePobn3azEARFQXIA6Wop0MFRv98hA8mPtcBiVRIM4csjjOtVYJSD7rJpkigfMOB7rWxKloPYkYPWJLGkbfznYbGW1UgeF8Y8XjJizCvbLH0Rt+ZBUUEQGnKUh602P9QouHCBzI47tEY3Ftrg3FkmLHI4wzkWlBzj+8EoUKr5lS3mL74+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyuu/ksUdPEtEwYb7lyQHqz2+9GycjhTKJCUjUjmWbA=;
 b=IwS89Nc3vcjolzkbHbYOwFGiOVLlNsqX4fw4fnupiKPFKoXNZSHE7s9+NLrMf0orsk6SLILPoHA9prFlHcE7WgN1tASbfD+10sJ8Rkin6nb5FFXb8bXmDVRTg1XQYGLok0MF9koHXvAR+/FiEqfc+k02aIdjzEQEDhghQtISIHT13RyiWTOWWojf3LyvfWfY8im2mPbvlVqo2GDhyPpKwMgP75WHNDVm7UTilGVggZYG4oFWSYrMBUczJHN0bABWienrhTymrbfmZC+HF3RJ+CRrERBas9CF922YWC/X3b0+/RJheFl+N8VBOLuthPc7KHa7dovAuqcnzLqqTgxHFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by SA1PR11MB8254.namprd11.prod.outlook.com (2603:10b6:806:251::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Fri, 19 May
 2023 01:16:25 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::b80e:1bbb:b818:10bc]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::b80e:1bbb:b818:10bc%3]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 01:16:25 +0000
Message-ID: <680395c1-8d8e-4f0d-f4eb-27cc0b15f033@intel.com>
Date: Fri, 19 May 2023 09:16:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v11 00/14] TCG code quality tracking
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
CC: <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
References: <20230421132421.1617479-1-fei2.wu@intel.com>
 <87wn259n4g.fsf@linaro.org>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <87wn259n4g.fsf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0122.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::26) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|SA1PR11MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d7e337-f440-49da-a8c6-08db5806a9e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OmHpcF4gz1QAIZ/vJqHJycTEJwD1lRhjUjQdSOF4Mr5nuvgXTaSQurPiVi2cMtSwtBMmd95+kGwvKpZ3U7yx+NWJhQWwgyEuR2GSqPcv7zvl/Lia0KHvqL/g8WpCj3mQtXxHPU1pKUwaGIBWiC1qBwVnvqiqV+OEEg8d34jXodJG6Mk72+h2N/ojOtyL8+3kSBmqo+QUa17HywKnx47Ap54bPcKiwkOI7VWp4bijSviE89E/nS2O5jrQAVyHlHCp8e0VRUEunJbrIl67FAvlrZshz1QMrcqF5mMJCcpCZLphZ5sXoxOpqsCxTXj/5pl/FUNW+LCqgMet8MtELtwGgL7mvvoGPIO/N6b+dUaXP/2OB4wyDIm2RLYxkPL7bMTWX7KImJDCDOa1GlxhrTi3V2M1lcjLSORwpi8kTf0J40OmqkF2U9VjALkL3KCpkUVnvE+SBChVH5jucZ9v1MH2c72pBOPxAOvCPzEnAriT4NBSKf2yDocm+56iWNaIEg10pxHhOtZ1IHKFb+yA910qK+OiFD6k7DzD/ut5rKsM8F6uVBJvxbpqthPkPKWfvik7KTd/Re+FdrTy1PH/YCN1p6iw01Hie4ZkIKDy76SLg3nRzoVly3WxhX5KnKhH8lATExrapXFpbIGLMFlEREiOMBbrYWf5/eCG0+ro9BN1K2WExSCF2PuPuzICBmOABMt7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199021)(36756003)(6486002)(66556008)(4326008)(86362001)(316002)(66476007)(478600001)(6916009)(966005)(66946007)(5660300002)(38100700002)(8676002)(2906002)(8936002)(41300700001)(82960400001)(31696002)(6666004)(6512007)(53546011)(26005)(6506007)(186003)(83380400001)(66574015)(2616005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uld3QUNDWWJLalRvd3N0U1NjdFkwNnNkZlB2eks2TUhKMklMbERkL2lTRU10?=
 =?utf-8?B?dGhHQSs5dnBWaDJCUWNUbTh5YVdkay9QSExIMnE2d01QRjJCSDJrQzg2MlZU?=
 =?utf-8?B?cXpuOEtDVEVkK0JENHFZYkhtWWdFbDE4a1JINzR6N3dyTnpJVktBWThYd0M0?=
 =?utf-8?B?Ykp0cXJyM29GYUVHcGIxdGdUUC8zdlFnSkZiOUZHM2tZQzgwWFVwTDhKV05R?=
 =?utf-8?B?VFlrb2hYVFBLWWIrWnhRMzU1STlCbm1rTUJrL1J1VDJlNWwxbmFnck1ua2Zl?=
 =?utf-8?B?aTdoZVNET05FYWhkRUM3MFBYV0lnYkRkZ2lVTGVwbnl1WmZOV2szV2U5Wkk2?=
 =?utf-8?B?SWVVTWJkMEhVVFF4dlNwM2w1bzNyMzVBdll1S2FXbS9nbWJKQkRFTDg5MmRx?=
 =?utf-8?B?cjZndHFpZ3haazRBbGh0VzZtT1NlTGZCYytVQlBBTzRHZ3hwUk80aEFGM3di?=
 =?utf-8?B?YzZvY2J1S20zR0l3aXlsQXF0SVAzTzBBZUVCM1hsbXJ6YmhDa3lmMEU5a0FZ?=
 =?utf-8?B?R1BZNHhVaCs2L0dCZVlGOUQ4eG1lRW9LZHhrMHBKV2l6S29Ja3JJWG5PNnZ1?=
 =?utf-8?B?OGJld2lkOGlIUEVDeU1kOFZ3UDNHQ3JuejZkbEtGT0pVTGRuTWprdEl2WmFY?=
 =?utf-8?B?MW42ZzhYSmgzQmU1Q0pVQVltTHdqVEcvY1YzQUxiZ0JxMmlyOGVyeXQ2NGxx?=
 =?utf-8?B?V1oxRjF2RGlFYm9LZUt1c00xdjNsUngzSU9YT0ZYWVplbVlBaXhNRmFIUEVv?=
 =?utf-8?B?MXdrSXpJNzIyV3RXQkZKMXpUcVZ6WUdwdEpkUFhPSUFORmZabktLODAzWHQy?=
 =?utf-8?B?ZkEvWUhKazVYcHIwWEdiOEFJaFBWNUo1andBREphMWhBbG9rQTZzVmR3R2RX?=
 =?utf-8?B?bHhPUVhCMDBwcExaSE5lQ1NGUHJYaXpOV0pXZlY5cCtDbFJ1ZXZpd2F0TGNE?=
 =?utf-8?B?UkNRcEhlMTAvTS9CdFFIUlZKQ0dTNm5jM0E2aVozcENVaU9pRzlKWUtjcnBH?=
 =?utf-8?B?VjJCUjdTUi8vajI3c09QNk1HRE1vQjZxUGsyT01nUXFIOTBVU05QK21VL2F3?=
 =?utf-8?B?NmhMMDNSYjlDZVRqMTZVWkdGS0psUDBWWndBY3FoazNLd2dvWVBFQmNCbHQ1?=
 =?utf-8?B?alBTWXhJYWNyYnBsTEIxUm5PczZvakh1TmJDcncxSmxpRytMVU4vcnlDNDMx?=
 =?utf-8?B?bzNZS3BtaW9UQjlzOFJ6MWtzWHBpNWhwbEFITUZYL1h0bWw3ZGpnaTBEYTZx?=
 =?utf-8?B?S3AzaHVmeXEzekFDbnRkTHdrV0w3UzFYZFExSHNZb09aZFdIL3NkMi9QOWpa?=
 =?utf-8?B?UzZSNXd4WGlNRkxaS3pTUUsrWnRvaGNBTWg4QlE4cUxLdUgxMjdrR0V4cHAr?=
 =?utf-8?B?WG0ycWoyUHMvdlZkcUM1akdNT2k1VHhUZE43eWhTS2pTQnAyYWR5VjFVaHpG?=
 =?utf-8?B?V2xKSURkUmppTitnclNXQm5RWXdoZGpJdGIxNklhRWczZ1NGUysxcWJac2t1?=
 =?utf-8?B?TGVENTRqWitVb0c1RWJnWUpITzRKMklOdkhvbjZnQW5xMXRZOUQ0STdieGVr?=
 =?utf-8?B?SjB5c0FEdEdyL2RkREpGTkwxcXVIZ2ljVEVaY0NrbDFQa1FwVzNMUGRuTmJq?=
 =?utf-8?B?eVZYcnMrSm1ZVUtwZEdlUXp0ZnNkMnlEMk5NYjhINHFVcUZtaStVK1ZrVDcx?=
 =?utf-8?B?aXd5a0xUa2NVdElBT0k3aTlTazEyL1FGZjRmdFliUTZCYkM3RHE3dkEvZmlm?=
 =?utf-8?B?T3B2SmVuWnZ0UzFsc2RoNWpNTEsydUFtbmoxbWZYOXpOdTJmMW9jTFhsdjYr?=
 =?utf-8?B?QVRXNkV6SE1yUTZDNUtCaGlLU0xFaGxMMWJHTzA0UEJHMnNaZHM2NVFyYWRi?=
 =?utf-8?B?U0piVEU0bkVhNUZzOGNyaW5nSDFybkh4Smp2aUpBNHdQbEtWOWdCdnRBeXdy?=
 =?utf-8?B?RTVEWGZ2RjVlNjhKL3BMelEzaHFNYTNGanJ4bW0yNVQ5ZDhHSHZJWXpicGxr?=
 =?utf-8?B?a2s2SFBqUkdNT1NuUVdmWjd2aFBPSzhabWppR3JISHJ3WUJSV2Y5Y2ViY1l2?=
 =?utf-8?B?bE42eDdSMW01YlRGemE4ZU5wdXp0OEhwMG5hQ044ckl3ODIzZWRaMUhjRTZi?=
 =?utf-8?Q?mOmI6lAdrV7VGWvwvQTGu3TQu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d7e337-f440-49da-a8c6-08db5806a9e3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 01:16:24.9453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjocdS6d6ACQ5lw1X/icJU4obwG5WlF5edDL3SV+DrlIl1sJB94yQW/aFsp9pSOo9g9mCEPGd3BLHk5ruDCBnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8254
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100; envelope-from=fei2.wu@intel.com;
 helo=mga07.intel.com
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.544, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 4/22/2023 12:42 AM, Alex Bennée wrote:
> 
> Fei Wu <fei2.wu@intel.com> writes:
> 
>> This patch series were done by Vanderson and Alex originally in 2019, I
>> (Fei Wu) rebased them on latest upstream from:
>>     https://github.com/stsquad/qemu/tree/tcg/tbstats-and-perf-v10
>> and send out this review per Alex's request, I will continue to address
>> any future review comments here. As it's been a very long time and there
>> are lots of conflicts during rebase, it's my fault if I introduce any
>> problems during the process.
> 
> Hi Fei,
> 
> Thanks for picking this up. I can confirm that this applies cleanly to
> master and I have kicked the tyres and things still seem to work. I'm
> not sure if I can provide much review on code I wrote but a few things
> to point out:
> 
>   - there are a number of CI failures, mainly qatomic on 32 bit guests
>     see https://gitlab.com/stsquad/qemu/-/pipelines/844857279/failures
>     maybe we just disable time accounting for 32 bit hosts?
> 
I sent out v12 series which fixes some CI failures. qatomic is not
touched yet, the current code with CONFIG_PROFILER should have the same
issue, what's the policy of 32 bit guests support on qemu?

Besides time, there are some other counters with uint64_t using qatomic
such as TCGProfile.table_op_count, we might switch to size_t instead?

>   - we need a proper solution to the invalidation of TBs so we can
>     exclude them from lists (or at least not do the attempt
>     translation/fail dance). Alternatively we could page out a copy of
>     the TB data to a disk file when we hit a certain hotness? How would
>     this interact with the jitperf support already?
> 
>   - we should add some documentation to the manual so users don't have
>     to figure it all out by trail and error at the HMP command line.
> 
added one in docs/tb-stats.txt. Some extra bits could be added to
explain the fields of the output.

>   - there may be some exit cases missed because I saw some weird TB's
>     with very long IR generation times.
> 
>     TB id:5 | phys:0xb5f21d00 virt:0xffffcf2f17721d00 flags:0x00000051 1 inv/2
>             | exec:1889055/0 guest inst cov:1.05%
>             | trans:2 ints: g:4 op:32 op_opt:26 spills:0
>             | h/g (host bytes / guest insts): 56.000000
>             | time to gen at 2.4GHz => code:6723.33(ns) IR:2378539.17(ns)
> 
Is it reproducible on your system? I didn't see it on my system, is it
possible the system events cause this?

>   - code motion in 9/14 should be folded into the first patch
> 
done.

btw, I also added a few comments on v12 series, could you please check
if they make sense?

Thanks,
Fei.

> Even if we can't find a solution for safely dumping TBs I think the
> series without "tb-list" is still an improvement for getting rid of the
> --enable-profiler and making info JIT useful by default.
> 
> Richard,
> 
> What do you think?
> 


