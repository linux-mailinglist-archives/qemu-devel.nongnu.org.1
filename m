Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7322274F6F0
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 19:20:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJH1O-0003AK-U0; Tue, 11 Jul 2023 13:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qJH1K-00039X-6y
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:19:28 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qJH1H-0005Jc-D5
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689095963; x=1720631963;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jUUvl/6HKWGCcv3fuQw2+g354U2vw1haBKHxS/i1B3Q=;
 b=KLSLmcRJVjiLKgzQmdg6YjK4ct5H34uJb0OH5qeKt+m5jASs6hV3uxXH
 sqyYCv9ABsD1MvActy5rwoIRdYdEXIf+q1QdK+Z9SrUl2e+IiqPy0yrPN
 sheXEZ17u6ab20nh3H3jfAdDGwNVphy7ZTweXAqoNCHp+5QsLFXjcXNDG
 C67nH16Rcz79MMjsMI6DM+TGQ4Yc+XaVcksoleYPvYj/SN/4ocqteP78M
 nNy7/3uFmU589hcg6iA4eKLYgyKK41bbPu1b4E5J28G1QbYjJScZQQLI+
 pM5GK3t+1aG6CRIsrzVajXWmv0ba8gjJIJbdaNulE2R1qqaiGaQA9AQXa g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="363545969"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; d="scan'208";a="363545969"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2023 10:19:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="756427559"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; d="scan'208";a="756427559"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga001.jf.intel.com with ESMTP; 11 Jul 2023 10:19:20 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 10:19:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 11 Jul 2023 10:19:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 11 Jul 2023 10:19:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geasQ5DS8CnUDxSnoBhKczt4ckv42qTXyvBfcVf2nIgTSptuycp4XPVILswV96QIxeEb68sprhJvzvqoM7lqOlvVkg2ZosBtB4/96c6nwP1OzlKHXvlSZ9yHwkT3c8OPEtUhFjUtaNMu5vYpAgaNa6VVCnZlHT15v/6SotrUlo8yBOj626BOjfwYkMBePBSYXWNprXvJWSLhujNLR+g2EYvWL3TcDgeq+nZc5DWb26Kt9zGYLJmW4BddyUYC+KFyLkecnjYqhfGQGimBumqyWBgPXf3V9drTc3iwCgZVo+/0f0T96yf9HXv+bkvG1DEnwxefNsx784Ax/LLgFpqTgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9ZNxvO32l78dzjZZiK+k4dLsJAgeS09VP4msplhghU=;
 b=Hh9YI21n+ibD0FPULHqh09wIW6zrTvquG+VmSWP6FhOXCiDbAF0UE5U7mps0XBL5PD+WMRhYmv+pisx6YJT04d2dzI13lj0GO7SJh7L6mJDMoUuQbsLDKxrG1DsCV+K9YWeVNqoBP5nZxIykPJT39FLXZ18Vltv0iLfw3G8HpFiZDsT/LQH87XjVs5jOWuBxK/S7XwktolITA6iMLtB6UQ2P8XLIoisCZkpDAi3q3pjRHSiyenKRh23DN/2s71yixNoj2txDnEL9kPuc7R1nQ6y4c8zDVNd0vdM2Akvd7VP9+zXnd9W6COXU7pCBbUdbxMGHpdgxKc8YPO8nkiD+uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by SJ1PR11MB6081.namprd11.prod.outlook.com (2603:10b6:a03:48c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 17:19:17 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::3af9:ac1d:49a4:8493]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::3af9:ac1d:49a4:8493%6]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 17:19:17 +0000
Message-ID: <2d40fd7a-0f94-6aa1-32e6-3060d20dda33@intel.com>
Date: Tue, 11 Jul 2023 10:19:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 6/9] ui/gtk: Add a new parameter to assign
 connectors/monitors to GFX VCs
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <kraxel@redhat.com>, <berrange@redhat.com>,
 <philmd@linaro.org>, <marcandre.lureau@redhat.com>,
 <vivek.kasireddy@intel.com>
References: <20230621004355.19920-1-dongwon.kim@intel.com>
 <20230621004355.19920-7-dongwon.kim@intel.com> <87h6r1mkhc.fsf@pond.sub.org>
 <46dc1ac2-2ab5-48f7-73da-4160c26c3171@intel.com>
 <878rbrizmo.fsf@pond.sub.org>
 <6351a85a-db49-7d6b-2a55-1ea7c65b3a8e@intel.com>
 <87r0pgb8su.fsf@pond.sub.org>
 <ed732fc3-bb1d-42da-e179-0dcd08c663a8@intel.com>
 <878rbnymxf.fsf@pond.sub.org>
Content-Language: en-US
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <878rbnymxf.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0040.namprd07.prod.outlook.com
 (2603:10b6:a03:60::17) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|SJ1PR11MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: d66c41ce-a8ff-495a-d256-08db8232f4c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ekhGrCoxVhutPxV4JjkBD6Wd7EA6ejv39Gnee5Hse+eSgWlbqyKqisUN0FFS5mo3JC6pS+l0PRy69C9tV5/hgyQ6CFe2kZQCF3lPWXxfQlHhPZgZslX7AfyJYZKL5vIX7+v3GlNgcVCw/z31YHMpfrG1cAwFM63n3syNbXktK+zlw0lr1kXjChLG4ANHnQbTopEMJ6wc9X+3dKEu6xC19JRV6Q/l4tfp+ObUUFAKjYaOsI9BHlyeSQ7UuJ08oloKuCaljFVhC+xus4g6cDiCG7DDZsI2hsavVSZYkOO0rddE78NGdqoC7qTdi7R1MbWvf3a6j19LAKnJ/X9GWBwbUaOanoRlY6I66H/dcQKspiqk0AEChgynCLJHx9e/e+dfqMM9G87Kcj+CdknaxIYEBORdAKSlQ/DiS0OnwEimZOZrew1YTdJOrOKC4tjAbmjnq2tihdyMzxegPChaLLY8saazZZYeuBbnpXV8q7tgXmVWVsOspve62qCFpqj/j48J2TgbX3gRSAgdPs7mDl3FgzL6EGxBklF3mMOZs+kYWeMziBgGEYgiAqImGRtNNEQT/z5NzYx4ULeZY3dvYx/WVD5XSG20TqUSG16Oi9gQn8m/sN+wUOFtUBgoEwV2iA0dOfP/KbZ6j3olNoFBWU6TRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199021)(6486002)(6512007)(6506007)(186003)(26005)(53546011)(36756003)(83380400001)(2616005)(86362001)(31696002)(38100700002)(82960400001)(107886003)(4326008)(66946007)(6916009)(66556008)(66476007)(2906002)(316002)(31686004)(5660300002)(8936002)(8676002)(41300700001)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGZBeVdwa0prc1JEWlBSdmpNcVRVdDBhTm9PekY3eTA5TEwrc2xSeG5YZVN6?=
 =?utf-8?B?R2tsRVFhZC9OZFhoUzNOclprTXpEOFdhSVpRVk1NTndQNitXR2FRSEJ0ZDN5?=
 =?utf-8?B?VDVGanR4WElieHhub3cwWEZJbUdVcE9iRDVkU25LYkNJQ0VZR2t2bTNBbW9J?=
 =?utf-8?B?eFgrcFJBSEZVRGljaER4K1ljS0VzM1FxcFRBK3J1a04xMDJlYldlU0p4QmlZ?=
 =?utf-8?B?SWRGT20vZWR4K1lDSEFYUEN2MDFNZVhqcUJ4dE4zY3BMb3orRFBCcGdYQ1lr?=
 =?utf-8?B?T3pBeTNPbXh2OFR1amtqWVZtMmxGSHUxTEpvb1BEZTJKUzh2UEh1dFNWbjZ2?=
 =?utf-8?B?V2pabTJneG9ycjlXeGhwY0hNekRIWkdRblpmb3dYcnRYbThBNklvVHdicjdI?=
 =?utf-8?B?VHJKc09ONDZHYVdJeEFXWUx4T3BUb1NmNlFUZTJ0L1AvMGFjQ0lwbkMwUG82?=
 =?utf-8?B?S2hUREEzNGt1L3llREZxN1BwUGgzclE0a2p5TkticndLK29lRmJma0JWZGM1?=
 =?utf-8?B?K1VlOUI5a09DQjZwWW5oNlZxVjFwUWFKaTB2OHVGZ1JXTk9WQzBEYTJKL1Ft?=
 =?utf-8?B?d2hRN2RONjJpVGt2MjdkOWdRUk8rQllBdlJpeUUyUDdlMUdnNUlCUVVObWZG?=
 =?utf-8?B?Mml6Wk92TjFTTDMvbTFtZlU5YWo2YkxGMmI2Qkx6SXJkL2FIcTR2VzF1WUNl?=
 =?utf-8?B?Tnl2NldVYitzSzZldytWNUVBQ3FIaTRLdU5YMlNSV3Q5cXppdkEvcm9LWk5h?=
 =?utf-8?B?NzloR1dYUWY1OGlhVThpcFlQY2lsQW1MZDVXVGF3am9WcUpEWFdhVm51c1A4?=
 =?utf-8?B?ektYT0c0QTA5a3NBeERody9xS2V0dldWb1V3bXY0Y2loU0dSL1VXSGw3YTBq?=
 =?utf-8?B?UVNIV3lhNi8zRHAwYjNkaVpnMFFQUDNRWkJ6U0tYUVdmQ3FsOVhMR3VHQUNG?=
 =?utf-8?B?cjBaNXJhT3RnaFloL0w4N05ITmV4eHJGSXJ4WXFwK1pyRVlFc0tWaGRhUHJ0?=
 =?utf-8?B?WWRmRUtvNE9FdUUzaVI0Q2Vlc2hKWkZURlBDQ01HNDZQU0loT2NyRW1RczFP?=
 =?utf-8?B?MGRBSkRmbGdhNGRCang3d3VXaks2WjVmWjJacTFyUkFkS3U5Y1l4QTdpdEhL?=
 =?utf-8?B?NW53aTFrL1g5aVRwenNkQnRtOHptdzQxbW02WEpRalpvaGJIRFBBODBTREY2?=
 =?utf-8?B?SVFMYmRLbk0wMmxZOWxBWG5jV21TV2R3cEdlQitNWkF2WUwweDJudUs0ZWx3?=
 =?utf-8?B?N2IyTTlYZVRaYVh2a2htYURlR1c0Y2FvWkp5MGxTRG12NjVIeVlGYUp0dmNQ?=
 =?utf-8?B?RkkrTDlWeENybDBlT1MzVGozaHMxSDVoMDEvSUFaRWorQWNQUUVwNWZubExY?=
 =?utf-8?B?R0prNHdFL2tISEdQQ3lhYkdYajlYVzVpaWJHdWovaEdtV2pvOUNLSXZla0dt?=
 =?utf-8?B?YzNMZjV3emZ2S09FWml4RGpVcFdDV3JMT3Z4Y0taTk82TURHN3VMV0hSWjFQ?=
 =?utf-8?B?RjFqQUJjTUdVUnFhRGFzRVV4OWF4Y1l1MjZXRG40WjR5RVFJcGJXNVNFdkw2?=
 =?utf-8?B?aGp6VU45MTdMYkg0SVNPWi9Ec2pZR1hhVWxjSXJFK3VLVEVEcm85bGQvdjIy?=
 =?utf-8?B?ZDRGdldyc1pDSGQ4R2hNTjYxOEZ6bVlwRWlWRUpJTGpzZ0hXczdhT2V6NzdJ?=
 =?utf-8?B?eHl3RUdrRUcydVNCM2NLTUdkR2tycFFaOGVZaDA3MHNNQUZ4TzFMdUdmRjdW?=
 =?utf-8?B?WmUzcnRaaklMcEtObU1CbGJ3ZEg4ejZGSmhOdXJjODhtb1JIbDQxaXg2Q1dV?=
 =?utf-8?B?TkpDdXZEZlYyM3dsakJjSjRaRkk5bGh3K1pJR2tYY25OQU12WUpMbXNjMmda?=
 =?utf-8?B?UUpIZ3VrczZIYU91TW9Cejg2K3VCTGpWNzVjeGdPWmk4OFhiQm01QVE1MldU?=
 =?utf-8?B?STVQVStHdmFtOElEd3FyRFZXZVRXczYzM3czTTZMQU9vQS9EcnRHQ1lQbStm?=
 =?utf-8?B?T1JTQm03aHg0WHloUHRKaENSU1BpTzJUdGREdnRRZjg1ZEJzQitkNEJMS1FX?=
 =?utf-8?B?MjRBOEJ3eTlOSUc4c1BZOGFBcDRoVHFxK0hlRUdjSVdwTEVpTWtlSkN5d1kw?=
 =?utf-8?Q?edrGupRLxyFVTfzDWvdxCKQOH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d66c41ce-a8ff-495a-d256-08db8232f4c7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 17:19:17.1221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adIQf0hWd4UxPwHb0mr+8ho9s2LeyzQFFtnzgHfIKIB7EJWenWxsp2fycXEecyRPwW5mbEQA7DmUeSBYGf/Q/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6081
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120; envelope-from=dongwon.kim@intel.com;
 helo=mga04.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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


On 7/10/2023 11:36 PM, Markus Armbruster wrote:
> "Kim, Dongwon" <dongwon.kim@intel.com> writes:
>
>> On 7/9/2023 11:05 PM, Markus Armbruster wrote:
>>> "Kim, Dongwon" <dongwon.kim@intel.com> writes:
>>>
>>>> On 7/7/2023 7:07 AM, Markus Armbruster wrote:
> [...]
>
>>>>> Ignorant questions:
>>>>>
>>>>> 1. How would I plug / unplug display cables?
>>>> I am not sure if I understood your question correctly but 1 or more guest displays (GTK windows) are bound to a certain physical displays like HDMI or DP monitors. So plug/unplug means we disconnect those physical HDMI or DP cables manually. Or this manual hot plug in can be emulated by you write something to sysfs depending on what display driver you use.
>>> Let's see whether I understand.
>>>
>>> A VC is placed on a *physical* monitor, i.e. a window appears on that
>>> monitor.  That monitor's plug / unplug state is passed through to the
>>> guest, i.e. if I physically unplug / plug the monitor, the guest sees an
>>> unplug / plug of its virtual monitor.  Correct?
>> This is correct. When a display is disconnected, "monitor-changed" GTK event will be triggered then it will call gd_ui_size(0,0) which makes the guest display connection status to "disconnected".
> Thanks!
>
>>> Permit me another ignorant question...  Say I have a single monitor.  I
>>> configured my X windows manager to show four virtual desktops.  Can I
>>> use your feature to direct on which virtual desktop each VC is placed?
>> Would those virtual desktops will be their own connector names like HDMI or DP? We use the connector name for the actual physical display you see when running xrandr.
> Output of xrandr is identical on different virtual desktops for me.
>
>> I don't know how virtual desktops are created and managed but if they don't have their own connector names that GTK API can read, it won't work within our current implementation.
> After searching around a bit...  Virtual desktops, a.k.a. workspaces,
> are a window manager thing.  Completely different from X displays and
> monitors.  Programs can mess with placement (wmctrl does).  No idea
> whether GDK provides an interface for it.  No need to discuss this
> further at this time.
>
> [...]
>
>>>>> Old question not yet answered: Using a list for the mapping means the
>>>>> mapping must be dense, e.g. I can't map #0 and #2 but not #1.  Is this
>>>>> what we want?
>>>> No, it doesn't have to be dense. In your example, you can just leave the place for VC1 blank. For example, you could do connectors.0=DP-1,connectors.2=HDMI-1. But in this case, VC1 won't be activated and stay as disconnected from guest's perspective. I think this info is also needed in v2.
>>> Have you tried this?  I believe it'll fail with something like
>>> "Parameter 'connectors.1' missing".
>> Just tested it. Yeah you are correct. I think I had a bad assumption. Let me take a look to see if I can make it work as I assumed.
> If sparse mappings make sense, we should provide for them, I think.
>
> An array like '*connectors': ['str'] maps from integers 0, 1, ...  It
> can't do sparse (you can't omit integers in the middle).

Yeah, I understand this now. Despite of my initial intention was 
different, I am wondering if we don't allow the sparse mapping in this 
implementation. Any thought on that? The V2 patch is with that change in 
the description. Another thing I think is to change QAPI design little 
bit to make it fill the element with null (0) if it's not given. Would 
this be a feasible option?

>
> Instead of omitting them, we could map them to null: '*connectors':
> ['StrOrNull'].  JSON input looks like [null, "HDMI-A-0"].  Since dotted
> key syntax does not support null at this time, you'd have to use JSON.
>
> Only an object can do sparse.  However, the QAPI schema language can't
> express "object where the keys are integers and the values are strings".
> We'd have to use 'any', and check everything manually.
>
> Hmm.  Thoughts?
>
>>>>> [...]

