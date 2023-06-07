Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D017C72600E
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 14:50:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6sbw-0001bG-QK; Wed, 07 Jun 2023 08:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q6sbv-0001au-9H
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 08:49:59 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q6sbt-0002d2-Jy
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 08:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686142197; x=1717678197;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=74xz1Ggqrl6u+kCJB8emESOsLUhRzK5d0iueEFjV6MQ=;
 b=YsU4gcMvSo5XPYNUYqGgzuvWc4FoM9X44yam+W51gRTp+vZV3m74Q01Y
 wXkYdhsiJQH59Cx8FzNTol4/sUCxsT+bl77bVRcmR8iX7KMuYEmZ3PjtA
 VvbS7cVaDg5ElNI2L1N7+4kzea3BogBCMraXOvazmklboHo5LInPNo3Is
 F/dzqIokcWQc1Jbhl19NWHU0rHY0t3W8L4qJgDqAm+udhXKibdM4ez1XJ
 N1paf/cCLwzkjtgDz3afJaM22shTJeg8PHOHqEsSUTkVBJJ60nQk8LETd
 cAPB3r/Zd0igdQjNBwiVaiLiARDPV6ucCSdtpnLchihom15SPx9Q2ouua w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="337334841"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; d="scan'208";a="337334841"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2023 05:49:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="686981519"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; d="scan'208";a="686981519"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga006.jf.intel.com with ESMTP; 07 Jun 2023 05:49:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 05:49:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 05:49:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 05:49:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 05:49:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFDQasX9GV0Wgh2l5nXAXXIezg56l4GM+4RP2LTONt45hchkVBLnykgicknPCvv6jIKZRhuCZhB571BKd8tMUaUSnyI9xL9KobcNagvzuIT5aaREz4rSxwJ/SuQfZ7apCKB4I+Qu/lYZhHGNRrd29wirWOxokZUon760hlhkNjAO27tJSKXGRsTfRIn236dMmyvixMTDbC7S5Fisrhyxi7cWb7zjvTy/DujD6iJ5H6iraLW89IquwXog1dA25AqdTZwkmk9U3zwOTBEYRILG/qeFxehj0ZVi/AzFxUWYRmz6fgjbciYUmFsTpGpdDs0HUU+6uw4wXeKgiwznlUj+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3phJO1bC3yTJuUmqIs2i8KC8uKSYGg0qOxurdKRN4PQ=;
 b=Eu7/BclGUgOQXCJ+mj+zPSfNNFIlIP8ekoRmKDXAeq5b9yXjdAgaYleFkLJJRRgP1XYhdcgcCkPsNAk5Y/dfblm7QU/JL9+YLWwobSPbPzi7Hprr3NdwTeNSS+O7STw1uYSksGx4droPPji2KiXRsTpE6K+knUBY1feHqaONJoM3pdxD81+f581mxSeviVi30nnGSpf3NTTdy7n4O3ScLTqojY3rbhbtUeO5fH8z99+UpsYFmGT8IDO8uGh5B3nRkis0dzizDMr+MMdmh4K+I25o79b2vx84a637PO9TjouL9iJIeX801EclhskJ4HaExAq7qwDkb0+aclOjOLHsCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by BL1PR11MB5254.namprd11.prod.outlook.com (2603:10b6:208:313::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 12:49:50 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 12:49:49 +0000
Message-ID: <dddb5c1d-be72-15a7-97c3-eb306acd656f@intel.com>
Date: Wed, 7 Jun 2023 20:49:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v14 08/10] Adding info [tb-list|tb] commands to HMP (WIP)
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>
CC: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, "Dr . David Alan
 Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-9-fei2.wu@intel.com>
 <387127a0-4030-32b9-ccbb-db2f95bd618b@linaro.org>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <387127a0-4030-32b9-ccbb-db2f95bd618b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|BL1PR11MB5254:EE_
X-MS-Office365-Filtering-Correlation-Id: 30836d86-caf3-44ac-429f-08db6755adcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHfqvz16smu275TqpWwd4tKMLNGxNabedr1O0iUm7a5CaWcYxazG2l0pl98S7VzoM5iA50hUcR9/kqDpTmitnSsbx3bwpRcPQCWlDBTeMWUjR+0NUmPGXwDBmdqzggJ+oZX4+dT6gCX5LjB+mWN/PIbw31k2PYK0mu38yTXWmevRXSiivk6WxpV01WkI2hOLd6720zmmTslCcR+zuERtjxXGQBXEQBf/RIFieadJXZxCDZ92wU1atXVW65tRCJnPfETmSrR8N1mCiJ6JZzf+Gf1pY3BRtWuaBXw011IYSiLinn0j/meOIt9jXvEQWpsPl7/hxde37HNHy9O4EQARpH7nZ2GknqExGvum7Dqku5jdTyGLqXbyFVWsVri7bEZmMq8FkH02pY3qW/lJAjZaqmOIfaLoF59m5BBK6WN12kUBIyT9YS0aCB8W9IN8MiDuR8DsSfokHUP2qe/Dx7JjYLPyY8dLjXlIAcA+Rom0P6pqpayo2YZ/Q6doJHgq3BVURs9zzn97otW5wzX0WlRFHgmqvwiGPEpAqSrsGvxWu1gdM7tua7usKJflTSWTTNswkY9sz4n8sQSAZlebnGof7/IEl1K44IHbPnZLxF7vwp9cHBc2b9tesVBi6idZd8wNy8E32IFST4bdCJhII4vlAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(26005)(66556008)(66946007)(66476007)(82960400001)(4326008)(38100700002)(6486002)(478600001)(2616005)(36756003)(2906002)(6506007)(53546011)(6512007)(41300700001)(316002)(8676002)(8936002)(54906003)(186003)(86362001)(5660300002)(31696002)(31686004)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk94NjJ4bUZMdWNVOGw0VzlvZFJVWlZPY2R4TUJVSjhadVhtczJJTkEwNHIw?=
 =?utf-8?B?YmF6Tkgxd0FrYkxlakwrN0cycTQ3REtYVHNFUktacHl3WlpxTm1CaHAvZkJR?=
 =?utf-8?B?UFozVVJveTNicXduMld5QW0zYXY5U3FwbVR6V2dDeFBOLzcxdDA2Z1dTL095?=
 =?utf-8?B?ZkFvMDJlUWhSVjZ4N0J4Qi93b3VyU1RCRmJCRVJ5TjRnUDY3UEVCbTRHbDBw?=
 =?utf-8?B?a2xDamZ6WnNVNlVaWXc2bVJJTC9DZG04YjZ4dVFjN1Jva09PSG5YM2J4b3dr?=
 =?utf-8?B?bVFDWENGdXZuaTI5MWFEajN0NDdKSk9Bdi9paHlHQ3hqQkNpd2I4blk1b1N0?=
 =?utf-8?B?aFAwL1NzTG5wRTI3d2lpNU5vb3VPZG14TzloZmpYYWNxOWJYS1V3L1djSzNW?=
 =?utf-8?B?RWRILzJYYlRqWUtNWm0xQnR6WlNzOWc2WGhRb3hXbXM5WjZzS0tkSnh0WG1N?=
 =?utf-8?B?WTcxSU9JR2RqNTNPWStTaEdFWENSamtaMFNPV2FmTHdVb05JaDlRdGtTeWU0?=
 =?utf-8?B?WHVPYWVlUFh3WnZKSTFYU2toY2ZQeVBwUjBoS2tlZk9Yekd6V1Y5akRNRzdU?=
 =?utf-8?B?Q08vZzdER2xGeVExL0VrUGRIZlFEdU5ZbUdaN1JXOFdnVGFFOHdLT3NidDRB?=
 =?utf-8?B?MFB1SHdoS1cxVVJOMDFXeEJldWxaZWpEMUhKTUZVTFhlaHRwT2JBK0pXNUpr?=
 =?utf-8?B?NUVXeml3b2hsRjY0eHUwM1MzYTMvV0U1OVUyV0tYd1ZmSUdRL0pqaHhDUWtG?=
 =?utf-8?B?MDl1ZTZYL3BtdkNrRFptUGt6ZkNqNmxteUlaT0FEKzZCcWtNaVdUMFI3N00w?=
 =?utf-8?B?NkR6c2g3d0tlMUphdW1oeGFMUEs0bnBIcFFvVTRSRTEwbmQ1dGZoVVBqNzd2?=
 =?utf-8?B?dnNOWHF3bTRXem5kWnMvS0laai93UURvT2RrTWxkb0g0SCtWTERwdVBaRTJr?=
 =?utf-8?B?QlV3UjRFcFlScytlR0hYenpvN1dVTnVrM1labzl4THllVVNTcStLTGRqbmZ5?=
 =?utf-8?B?Wk5uNTZlbCthTTBhQ25xRkRqTVhaSWVlSTFML0NycjlUcmhFV0JmejJBUzBX?=
 =?utf-8?B?VTFBeGpEbEYzeFc5aTRTVjFXR2VPbTNUWUpJczFINE8vam9qUXNubXpHczFG?=
 =?utf-8?B?R0ZwOEh1ZHlTS2pFTVIvTmcyYm5ETE4ybFV5NXFnN2hlM0RHdmdKN1NneFNQ?=
 =?utf-8?B?dUNhaWJMRjdjVFNHbmJvOG93VStnVytyWnN0YXJxcC9id2xVSXoyVHloc3h0?=
 =?utf-8?B?R2tFKzlzRzUvSGZnS0hpaTlKb2hoVGxrWWJFQmRLSFludEQ1WnZMbE03KzNY?=
 =?utf-8?B?Szc4bTVqaWlwMlhpcmFGWjFEMXptdTVuRVdjWFNBTEVSTFozSTRGWmpOVVAw?=
 =?utf-8?B?Uk5sMHUyWDBzWjk3NzR4ZXJuZmFFUHdrbmwzYXlwbmFSYXVTQTB1ZEFXL0FI?=
 =?utf-8?B?MXMwazdHUldQQ2hnV0FNRmdYSEdDNi9xak9EbHBqU2huUURwZEk3ejdCMWdB?=
 =?utf-8?B?MFFNbGFGdll4WTAyUng1djFhQ1I1Y0ZVK1ozMi9mdE9zaE5iVTJWQTNTSXZw?=
 =?utf-8?B?WGRoY0JzNnQzNE0yZjNtQmtIN3YwWTFJbmZxQ1RNa0lQWXFvanRYRE1FMlIz?=
 =?utf-8?B?eUhYU21SM3U2dHRkeUI0UW1WeFJDTlhpRzdPMnJldTZ4aUptYm8ydTlVcVNW?=
 =?utf-8?B?MzFhQTBEdEptYlJOZkFtdnY1UVV4V3pZaFFRNHF5ZGhxcjRDVkZmZjd6KzhG?=
 =?utf-8?B?bGlkalVWakhxaDlrcTVMTmVHQm1xbG1YQ08rQTFxbU4xREVJOXdzT21NOTJQ?=
 =?utf-8?B?alV1SXlFVWZmaUlyT1J2U1p5c0xJZFFqdGVPa0cwYTc1T1gyU0pUUGpjNDBo?=
 =?utf-8?B?U3RZaUk5bDdDY0UwM05tWmRxcDBXNUwvMnNybUcwRldTRm5MTWtIZzVGY0tO?=
 =?utf-8?B?bXY5Z3pwaWx0czVRbml6R2Z4SVh0L0xCaUJxTXJjUzBQbUFxZDh5elBmaEVn?=
 =?utf-8?B?TThMVDh0RGhEeVNwSWNzKzFaeGxjKytuRks2eVJRYUNVZEZIeE8zd2lUQ2xZ?=
 =?utf-8?B?WkFpTm1vd1FlVFg4ZUN4QWxrUXZ1dlQzZlFsZFdYWWFuNWwrODdpbW1Yaktn?=
 =?utf-8?Q?ASgqyPAO1ROnYb0bA9rfY+HEc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30836d86-caf3-44ac-429f-08db6755adcd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:49:49.1810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/YMOg4J5XxFwtMa9kA2bf70g7LzYGpftSl9Hw4OEO3JRzjOVIuR8fy5WKDVAhzy4CTKWoEuDg7AIlh7mOrF6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5254
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.151; envelope-from=fei2.wu@intel.com;
 helo=mga17.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 6/1/2023 10:40 AM, Richard Henderson wrote:
>> +static int
>> +__attribute__((format(printf, 2, 3)))
>> +fprintf_log(FILE *a, const char *b, ...)
>> +{
>> +    va_list ap;
>> +    va_start(ap, b);
>> +
>> +    if (!to_string) {
>> +        vfprintf(a, b, ap);
>> +    } else {
>> +        qemu_vlog(b, ap);
>> +    }
>> +
>> +    va_end(ap);
>> +
>> +    return 1;
>> +}
>> +
> 
> Not need on this either.  Global variable being checked on each
> callback, instead of selecting the proper callback earlier -- preferably
> without the global variable.
> 
> Did you really need something different than monitor_disas?  You almost
> certainly want to read physical memory and not virtual anyway.
> 
Yes, it's usually okay for kernel address, but cannot re-gen the code
for userspace virtual address (guest kernel panic on riscv guest). I
tried monitor_disas() but it failed to disas too:
    monitor_disas(mon, mon_get_cpu(mon), tbs->phys_pc, num_inst, true);

How to use this function correctly?

Thanks,
Fei.

>> +void qemu_log_to_monitor(bool enable)
>> +{
>> +    to_monitor = enable;
>> +}
>> +
>> +void qemu_log_to_string(bool enable, GString *s)
>> +{
>> +    to_string = enable;
>> +    string = s;
>> +}
> 
> What are these for, and why do you need them?
> Why would to_string ever be anything other than (string != NULL)?
> Why are you using such very generic names for global variables?
> 
> 
> r~


