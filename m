Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78664719411
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 09:21:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ccO-00061E-Qt; Thu, 01 Jun 2023 03:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4ccM-00060e-DN
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 03:21:06 -0400
Received: from mga18.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4ccI-00056n-2D
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 03:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685604062; x=1717140062;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zRWmq3MTnfahouiOTTeMshZyDxNqgzL0YD+T24TmA7U=;
 b=NQSXEXBYXgFAVF+h1hG9qCEqKYy4WqMqKv9ILDXSpMPBSL0KSTKpjc4l
 vFEUBXuQUgWc3mmUtcgpj7eLOP2mRhuqTase+OLNgM8ak/Tw2uE4vQGtx
 YzrZoqc25gKuyRW4URlpJoXuB6HHE2T5HS91GZEWv0A4JC+E14KYvMfuR
 mdycLbAfYoSD/TU1cMb8dFhLhij2gkEebFkXszgg5jSr7B65C5DXZEN/B
 DtZieh00Vd1tDPStorAbU/F9IYRhmCvUB4EyxLS1f6pz2j+rAbgIKwIFQ
 OCjmoaG0fqeE6+Nq5cZd52mNK4NIEiHztJlukzuzhGVwqX77hOvFfmP5Y A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="340078004"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="340078004"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2023 00:20:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="701433752"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="701433752"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga007.jf.intel.com with ESMTP; 01 Jun 2023 00:20:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 00:20:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 00:20:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 1 Jun 2023 00:20:52 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 00:20:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEOUMfOb4WtQI/L7nz9XIDslLUylP5jxYV+ypO7B3E6dVLUSEzofkl6wvIyYEasFyXFg89SS9SVsXmq0wMqSBoa50dk3r/706l2rARu5NTqAYN5YsEtT36Hd0x08XpuUcJSudyiOsP+r8kwKdRAVrlEMOYL+OVNsAvRoQGBgbzV/0zZU7nHhXTawGljeBi4IhWxV7cdykE/GdDZ4oYZesPXOrdLoChx6QHHpay52Q9j6qi9GelN4Yrg6eouP2wMS9960p+CJ/0D7UYbtUzJCdIUp32pekx47uDoPBCza69dVly0YnRz4++/pqIuwWmskYNNlzwkNDo67H1vMf4tjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3+Phytrdr+SaxrsqmTUYRVXFfw8NBDG/x5xvthJ7cs=;
 b=Q0/b2zkbHfOELgszcQNqlET6IWAjWBe5TSLXGjHwitSJs1Q9sXzwtc2DT1oROLgtH6/VFNODJOfuFfkMwmJgKfsoz2VIMAwbmWnxY8FvAk6F9Bj14eBisUYGk5E/MnkiI0JdHdtWRJ4XgkAgvgDyHgXYqc+OK3izGZAj8xNWQKGP7YVE1etHfl7RWpbutv4Cut1hATvjLVi1kc6KK+J2d7wuOcdz3PBXtV7NpCh5BryNJTdZt9xcTZLOSLvwqko3nSt30JLjy6dS16gXl+wYWEZSnJhVGMPpOQ3IfJgZLouiB8ZG3m4wTZ4GZ5LQsyAO6oNO+5eW1UFzKdF0hBu/Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by CH3PR11MB8187.namprd11.prod.outlook.com (2603:10b6:610:160::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 07:20:45 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 07:20:45 +0000
Message-ID: <ec13fd0a-ef33-44fe-0171-7ce20fcb6a85@intel.com>
Date: Thu, 1 Jun 2023 15:20:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 06/10] monitor: adding tb_stats hmp command
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>
CC: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, "Dr . David Alan
 Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-7-fei2.wu@intel.com>
 <f37aae7f-7b90-af71-a188-bac4e7bf851f@linaro.org>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <f37aae7f-7b90-af71-a188-bac4e7bf851f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0182.apcprd04.prod.outlook.com
 (2603:1096:4:14::20) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|CH3PR11MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: ca67bd46-4055-4860-7fd7-08db6270b74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2NgNpD1yRxdKGNkxB68GvUuDLRebsZmQTBNBQ74yCcLV6U0M5hafjR3iGoN6ckCAMmlfCFNXuHoWkRx+hEhhL+E5UfhCzzhu/4sE/lkaxBIUbsc1nhFoBInFNg6V6f2vVa0TRVLVp40HEjBnHQI2vGi7t0C7khVKqCYjWH4tzn5FunShb8x9Wq05IjUxTeJIaZTYC0LCwC0RE6S+v6AStMY6+xChGow1/VCRaDIfDsn8FSLxXVY9w0E7AwbS+awdTNreqGZ6M2357nzkawpK8TcSiuiiXgZtmvY3V4W+T7IpkDD2xS5qnI3IqWwp4X2HIXfUdfly94pZmd8cdt6JYHuB8jIBNRteBBLAX67YszVKnmcmK8rCfgEWvsQCHroZdJvLp2X+vYFX5USkvkCX9tOljsOWm0YJSC5W26g3U9Q0buwu5bjMfxjwVleZMGt4CM+6j7MI/BxWZRgbpa65qI8vTH4ng72MMkiz6yKGovySbddX2U74PD9k5sYFztn9n6avlXTHGRICMJpdDpEG1yQeIEgfEa6p1GPyC+5uEUtYfYZPfJW70Ddpi+glhriO+7ysxh2F6G1snz+3kWj0EkbiYEs1KOhwteUi75ZjkinnT9YC/or81NT9Dwsb+SrqXZMqJxxqY8BSKSbYS2aINQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(54906003)(478600001)(8676002)(5660300002)(31696002)(2906002)(86362001)(36756003)(8936002)(66476007)(66556008)(82960400001)(66946007)(316002)(4326008)(41300700001)(2616005)(38100700002)(186003)(26005)(53546011)(6486002)(66574015)(6666004)(6506007)(31686004)(6512007)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmRXYWVqTUVqSXBwakhSalRUUVIvUTZWa0hKK1FFWlJ3NkVxT3FvTy9wZzhU?=
 =?utf-8?B?TndENlJDQ3Noc2g4dzNJVzZxdEp0L3VoRVZiK2p4eHVJdU1ncVYya1phSE9L?=
 =?utf-8?B?UUxBSXZ1SkV0V2taTnkyWVhmbVg3Nk1wTGhUZTlKQW9pRjZWTkUvdEhvUVVj?=
 =?utf-8?B?TVhZb0hTZDhGV3RLWm85eER6aGdwVUZiVGsra2d0RUppZHI1M2VJVmpacEt3?=
 =?utf-8?B?R1RycThOVGRNeHVEMEpQd1A4S015bUN3Ung1cThvSmdwd2pJL0lqeHEyc2Zu?=
 =?utf-8?B?L3JSR2hLNmtUV3JuT2sxNm03bCtZRUdqcG4wWWhVSmpkb3NMdDF2WmVPS2lj?=
 =?utf-8?B?b08yTkJnMnpZb3dKQXBHSHkrZW5mRUEyQm1YMllVd29rU3ZwWVl5ZE53b1BI?=
 =?utf-8?B?Y0VRUGlvc1lDRGJMcUdscGdoTVg5bWNyWWRMV2wvL1EyWXVRL3lPeUJZTjJy?=
 =?utf-8?B?RTVUNVA0S0ZNTktTSVlDYkRMNENGK25YUUpSRUFjYWR0VHNRUnRZT3BLb21h?=
 =?utf-8?B?b3JNM2VYNllWUElyay9iNWx5WnRkc3I4dVdQUHZ1bDFHV2dnNkllNFU2RDVB?=
 =?utf-8?B?M3BBdEtTMlY4SzFHVndBQkFodThWUkpqaU1NQkl3MGt2b2haTElWNW43UkUx?=
 =?utf-8?B?V080ZXJ4bXBVaVgwM0kwUWFXSkYrT01JRlBVZ0Qvd1dscXdQOXN6OUdnVWxx?=
 =?utf-8?B?cTNWUGJGS0ZyOUpuK1NVa2tucE1tMlM0LytsTk9DNVdscFYvd2g0d0tZYmxZ?=
 =?utf-8?B?WE51T3B3ZWFiU0xUOE1mK01ycjd3b2lWZWRYaUdsVXd0M0NrRU5mNyswWlhI?=
 =?utf-8?B?TGZrdkZzTCtCYkxOejQ1WHVTbnVrQ3FYd3gzM01xUFBGdG5jaTBaVkUxWXUx?=
 =?utf-8?B?cVNyeFA2eUVlRlQ1WXlzcy9CT0NUb3NxR2NxcHVsOFMrcVpyNUI4N21iemY3?=
 =?utf-8?B?RUlTWU9qK2g0RnhLclpMQTBsVHBaZ0poai84dHdkdE5Ra2RiMUw3Ni9yV0FK?=
 =?utf-8?B?SmlvR0JyL2FyQWlLVVM3VlFBQlloLzErVkdhdFBSVGdyL3RIQUF3VE1BNW5T?=
 =?utf-8?B?andodllvQWlTSDdUdUhrY0tMNGlrbmRjRDlLNEpodk16UlhLN3cvYVZURFFH?=
 =?utf-8?B?NWNwYTRscnNpditnaFVhNTZYNmJ4ekthQ2RBZ0tSd2xQdnBKOXgwakVodUVz?=
 =?utf-8?B?ZEN0REtWNXBLTCsyM3hPQi9yeVVMVGFhcHNCZVFXSzdTbTZTeEE1QUdFQ0w2?=
 =?utf-8?B?VmpOMFljaVM4QnlIQ0NhUW5GL01nV3YrY2F3VXc2Y2lmS3hHM2dTZVFEMkE4?=
 =?utf-8?B?TGZsNnVodmxwNTNicWpwQmpILy9ySEdJZjRXeWNoYWNOVlRjWS95Si9Eakg1?=
 =?utf-8?B?YzA4NG1WY3ppNE9GK2tMa0xEUHZDdnR5SVJoWTNEM1FIR3ZVWEplbUhSM0dm?=
 =?utf-8?B?L1lQdGM2OWltckFNckdkSi9JYmk1eEJ3dWx2UEZNSGJWTTVObHJwdlgxWGRk?=
 =?utf-8?B?eWpmVVVEWG9ZS3JRZ2xFampGNEp1MUdHdnlFdFo3MHlrditjWWFTMVI5UVZ1?=
 =?utf-8?B?RFFjMDl4VWRBUU9HdzlVVEc1aUNPMHpGcGMrN2FrUUpES1B4ODJnQzRneUMx?=
 =?utf-8?B?NUlkUDR4TlgyeVN3ZkxycWN5eGRUSmpLcVZHSnNnSjVLVkY0Y0FlUzRxblB0?=
 =?utf-8?B?ZVc1cTl3OGVqQlQxNVZxc0s1bmRtWHZUV3pyWC81MENicitVS3RhQmZqSmlW?=
 =?utf-8?B?a05Cd2Y5ZW1pdE1mT3VOVGduU0QvQUx2UmNmb3JiNFNsV1FsLzYwZmZrc2Y3?=
 =?utf-8?B?YVF2ZUtUOWNXTTI4Z2ovUGtNRitIUEpwWUpkRVBrb1MrbGdNeEIyazhnSUNk?=
 =?utf-8?B?bFIxMWV0bi9jRmdRc0JRUHR2Zms3QU5HbDNpSHIyM05YMndObWZYQXU1cGJo?=
 =?utf-8?B?TTl6bVNrbDBGMWErUWQ5cEVSMWxUTG02NWp3b0d2am4yZVUyUlNDSDBDNVpB?=
 =?utf-8?B?UFBLMUlaczVyRHFLN1ZGUTQ1MEprb2xvaUVPc0FvMGhVTnlHaTI2L1RkVFIx?=
 =?utf-8?B?NkRONTE4bm5HWTkyRlUrY016V2pSN0h6TmFUekhkZlhHWXVOampzUVNQOUxq?=
 =?utf-8?Q?ntpBDQoNBgeuXOeAsfp1olbJv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca67bd46-4055-4860-7fd7-08db6270b74f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 07:20:45.7754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUDt0JsmVxe3SNuZBduX03Kg0ayle0m0jiO8GmbxNbeA6UVmt2lDuJ/qTMi23gKi6BkqtRn8pXFOXNwVRDEf5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8187
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.126; envelope-from=fei2.wu@intel.com;
 helo=mga18.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/1/2023 9:23 AM, Richard Henderson wrote:
> On 5/30/23 01:35, Fei Wu wrote:
>> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
>>
>> Adding tb_stats [start|pause|stop|filter] command to hmp.
>> This allows controlling the collection of statistics.
>> It is also possible to set the level of collection:
>> all, jit, or exec.
>>
>> tb_stats filter allow to only collect statistics for the TB
>> in the last_search list.
>>
>> The goal of this command is to allow the dynamic exploration
>> of the TCG behavior and quality. Therefore, for now, a
>> corresponding QMP command is not worthwhile.
>>
>> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
>> Message-Id: <20190829173437.5926-8-vandersonmr2@gmail.com>
>> Message-Id: <20190829173437.5926-9-vandersonmr2@gmail.com>
>> [AJB: fix authorship]
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>> ---
> 
> 
> I still don't see what pause does.
> 
maybe it's necessary to discuss the user scenario, I suppose the
original design is for this case:
* start
* pause - there are some interesting stats we want to keep
* not interested timeline
* start again - continue to investigate the interesting ones

>> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
>> index 68ac7d3f73..805e1fc74d 100644
>> --- a/accel/tcg/tb-stats.c
>> +++ b/accel/tcg/tb-stats.c
>> @@ -16,18 +16,20 @@
>>   #include "qemu/timer.h"
>>     #include "exec/tb-stats.h"
>> +#include "exec/tb-flush.h"
>>   #include "tb-context.h"
>>     /* TBStatistic collection controls */
>>   enum TBStatsStatus {
>>       TB_STATS_DISABLED = 0,
>>       TB_STATS_RUNNING,
>> -    TB_STATS_PAUSED,
>> -    TB_STATS_STOPPED
>> +    TB_STATS_PAUSED
>>   };
> 
> Why?
> 
STOPPED is the same as DISABLED.

>>     static enum TBStatsStatus tcg_collect_tb_stats;
>>   static uint32_t default_tbstats_flag;
>> +/* only accessed in safe work */
>> +static GList *last_search;
>>     uint64_t dev_time;
>>   @@ -170,6 +172,101 @@ void dump_jit_profile_info(TCGProfile *s,
>> GString *buf)
>>       g_free(jpi);
>>   }
>>   +static void free_tbstats(void *p, uint32_t hash, void *userp)
>> +{
>> +    g_free(p);
>> +}
>> +
>> +static void clean_tbstats(void)
>> +{
>> +    /* remove all tb_stats */
>> +    qht_iter(&tb_ctx.tb_stats, free_tbstats, NULL);
>> +    qht_destroy(&tb_ctx.tb_stats);
>> +}
>> +
>> +void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd)
>> +{
>> +    struct TbstatsCommand *cmdinfo = icmd.host_ptr;
>> +    int cmd = cmdinfo->cmd;
>> +    uint32_t level = cmdinfo->level;
>> +
>> +    switch (cmd) {
>> +    case START:
>> +        if (tb_stats_collection_enabled()) {
>> +            qemu_printf("TB information already being recorded");
>> +            return;
>> +        } else if (tb_stats_collection_paused()) {
>> +            set_tbstats_flags(level);
>> +        } else {
>> +            qht_init(&tb_ctx.tb_stats, tb_stats_cmp,
>> CODE_GEN_HTABLE_SIZE,
>> +                     QHT_MODE_AUTO_RESIZE);
>> +        }
>> +
>> +        set_default_tbstats_flag(level);
>> +        enable_collect_tb_stats();
>> +        tb_flush(cpu);
>> +        break;
>> +    case PAUSE:
>> +        if (!tb_stats_collection_enabled()) {
>> +            qemu_printf("TB information not being recorded");
>> +            return;
>> +        }
>> +
>> +        /*
>> +         * Continue to create TBStatistic structures but stop collecting
>> +         * statistics
>> +         */
>> +        pause_collect_tb_stats();
>> +        set_default_tbstats_flag(TB_NOTHING);
>> +        set_tbstats_flags(TB_PAUSED);
>> +        tb_flush(cpu);
>> +        break;
>> +    case STOP:
>> +        if (tb_stats_collection_disabled()) {
>> +            qemu_printf("TB information not being recorded");
>> +            return;
>> +        }
>> +
>> +        /* Dissalloc all TBStatistics structures and stop creating
>> new ones */
>> +        disable_collect_tb_stats();
>> +        clean_tbstats();
>> +        tb_flush(cpu);
>> +        break;
>> +    case FILTER:
>> +        if (!tb_stats_collection_enabled()) {
>> +            qemu_printf("TB information not being recorded");
>> +            return;
>> +        }
>> +        if (!last_search) {
>> +            qemu_printf(
>> +                    "no search on record! execute info tbs before
>> filtering!");
>> +            return;
>> +        }
>> +
>> +        set_default_tbstats_flag(TB_NOTHING);
>> +
>> +        /*
>> +         * Set all tbstats as paused, then return only the ones from
>> last_search
>> +         */
>> +        pause_collect_tb_stats();
>> +        set_tbstats_flags(TB_PAUSED);
>> +
>> +        for (GList *iter = last_search; iter; iter =
>> g_list_next(iter)) {
>> +            TBStatistics *tbs = iter->data;
>> +            tbs->stats_enabled = level;
>> +        }
>> +
>> +        tb_flush(cpu);
>> +
>> +        break;
>> +    default: /* INVALID */
>> +        g_assert_not_reached();
>> +        break;
>> +    }
>> +
>> +    g_free(cmdinfo);
>> +}
> 
> Why isn't all of this in monitor.c?
> It's not used or usable from user-only mode.
> 
closer to tb-stats, or closer to monitor? It seems to me monitor.c only
contains the shim layer of qmp/hmp, the real stuffs which are large
enough are put together with their logic part, e.g. dump_exec_info().

Thanks,
Fei.

>> +void set_tbstats_flags(uint32_t flag)
>> +{
>> +    /* iterate over tbstats setting their flag as TB_NOTHING */
>> +    qht_iter(&tb_ctx.tb_stats, reset_tbstats_flag, &flag);
>> +}
> 
> Again, I question why a global variable is not more appropriate.
> 
> 
> r~


