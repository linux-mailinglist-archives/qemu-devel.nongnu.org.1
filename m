Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D7772790D
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 09:45:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7AJ6-0000qq-Jn; Thu, 08 Jun 2023 03:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q7AJ4-0000pN-5J
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 03:43:42 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q7AJ1-0001lV-D3
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 03:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686210219; x=1717746219;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UCKoWV0mk85KWLUpDlU3lHi+qah6X8ARr87+AUiOZ6I=;
 b=d8dBjScYvyQ2XyhEVFcKXgtxMvLUCwCeMz30Yjgx4ioCkziS1kU9kJpY
 C+e9Bdi00WfyEga14h4h8YdNX89gr7w6r7HAn7TkWWrrs/zJfeiCvpjWZ
 a3Mlc8c8zRFK0Pcm0bU/IBDOzn5ddUkWudm+d+d7CNDP7jS3qF+R96Rwt
 0ODLSTfRzkjV6nEbPSWRJ3Nu5UAU8V2AWXc2isCQ4SuasOdGObv4cQLDl
 xKh1EjcGEfbeKBRDfqklGDYkQIjvgswuv/IXc3OIc+JvUa1cfMYU3f3eI
 LFrXvJTDYD8r9k0HtV98IL9SHy+xeNXO16Sh3sne60u9b4PV9JJanqxrn Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="356091247"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; d="scan'208";a="356091247"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2023 00:43:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="799715560"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; d="scan'208";a="799715560"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by FMSMGA003.fm.intel.com with ESMTP; 08 Jun 2023 00:40:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 00:38:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 00:38:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 00:38:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGEM/rWHAKuLIRZNTTwQBm2yVHP6Y+ep9W6pKsoVE9VBfPsri0NsfA7sB6Hi1YIYAm2iG7s9zKsBPmVdsKC1aBmGEkYDnIbns64lASyPyc4I3OC8BrvyE/D73GaXWWD46s21Co+ha291qyyht4lD/DBs2IMgPeNmIZtXPbN0ia0jlNmGjH8aJxjabfmB03AVmDcp00ZSyHkG6fYCnG74UBexG+qcGbHiwpOlYXCgb7nqrJ6w3ZN4fHZMwCQgDPQuVqB6jrwiD0YCRmlWfSX3gCJBSGiZ15fcZ/XM5sfhFCi4KNW0lkx182/K4+D7ZkvAjqIGCzzvCt3maNYIZ81mbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBQjX1rhh8z6QTeWWSKfIkhZGMl1jXEsbQuXZVhvwWc=;
 b=K0SFxLHp6rscfCqe5oRFoc/CT8nrdJtK4l1R1xOE2VZ8fHgGXFJRLmq90QiGajfJgQ/BUMakq9JkdSfRACwKt/1/OjPwNoijPQ5Xwphl6ytlsiulHX+V6UJTjVjQoA4nvyk5qFVyWrSktOoLDr/TBIuY8WPSH5x9JtPA8+IfJQmXboi1bm2q3y6vwaKKdwsgDNUsJciXoyHqpG2cmigP6mfjJZZdIVsUt4ZiP0oBb2O1MxOw4vswnDm9Z1LDjd47SLyVP+ZSbHgBdvhicb8pogskC/psVi380xQsxkCCMxUEXTDlKgvKmQ7TBEMwFKCkJMe0mYgx93aab6xn5npq8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by MW4PR11MB7152.namprd11.prod.outlook.com (2603:10b6:303:222::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 07:38:26 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 07:38:28 +0000
Message-ID: <ffe308e6-8d20-3282-a3b8-a9d6474fe7eb@intel.com>
Date: Thu, 8 Jun 2023 15:38:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v14 08/10] Adding info [tb-list|tb] commands to HMP (WIP)
From: "Wu, Fei" <fei2.wu@intel.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>
CC: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, "Dr . David Alan
 Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-9-fei2.wu@intel.com>
 <387127a0-4030-32b9-ccbb-db2f95bd618b@linaro.org>
 <dddb5c1d-be72-15a7-97c3-eb306acd656f@intel.com>
Content-Language: en-US
In-Reply-To: <dddb5c1d-be72-15a7-97c3-eb306acd656f@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|MW4PR11MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f34739-ae45-423e-b344-08db67f35938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJq6UO1GqVfwFNPtWwp0LyD01j+rSHc7r33B9pCLigFye5EuFaodrHLyPBjICvuQfGMjGHbuhb+xkoWXXJrGqAEIK21n0IKEyvxD9W6kv1xWeaDgtGCfDu/rfPs7iQi9N9kgo0tfE8c36VuUmIuIXc+s965Dc+WwBX60m9G8Qr9FciTRbXW9rzlawD0zO9pRYg7nwyKKJkCiK0KJGYXOdHRZnCEqvg/6ps3UQJKsWpdj7M5vsvB+r79nCP01Xvq+IdK+WbN5gNWLnBCSIcx11cv17xJf0StzoP1LapZu2nG1vMCu+KhZPe9tMIW9xjXFEAZm7ip255liljNOkLu6VAhI/SyMQfDtULOrxaSY+zh8eJxls6PulDr+0kumMKkqIcsy5t0RrJ9BLx4FM/LJ+oeB64LWRRjw5nqtx9/VsgEdSV9L720YaIlx3XkGZ2m8zZljmUBV8hziY34/pYJTYTcOzWTYDs5rrd8UyN22PoL2OBMl6hGehGGR9ojDyn8KZ8wYMhC/4vNoQt63z1tvNAgpREDMoETmZA35cgatVnCKgJ2fQ7rt/p9zlYKU2CcyBMnT1vmKfUWFZX7ApYQI06Scwrg4lqAR5Hpsaxh3IY5xUPdQL0zDXFAom9BUhR1Dfq/JD9gA1ZSmRlpMFaHflA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(26005)(6506007)(186003)(53546011)(31686004)(2616005)(6512007)(6666004)(6486002)(36756003)(2906002)(8676002)(8936002)(82960400001)(54906003)(478600001)(38100700002)(5660300002)(31696002)(86362001)(4326008)(41300700001)(66476007)(66556008)(316002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0FibExScXdUYUc1Wkl5VEFuZ0xERGg2Nmh6b3hGcmNGcDRoM3dvaHgrUHd0?=
 =?utf-8?B?bCt3T0VWYkRVOUlRT3pjQ29ORjF2bC9OMTdqRE5JWVdKL3drc3BTODJGdEFi?=
 =?utf-8?B?S2FCNFMxOTh1THVwNlRRRTcycXJDL2xEb3phemY3Y2ZiK1hVMnczaDRobDZT?=
 =?utf-8?B?N2I3K09VUlE2VHFRbm1BVm5VSCthSmxzSy9sbDZ6V3hHK3RGb0JLL0NUWHFK?=
 =?utf-8?B?QXRXcUN0bDVPSXhGQXpnZiszNXlUS2E0ZzNObHhZN211YW9iTEd4N3BkOFNQ?=
 =?utf-8?B?K0tqT01YVE5MNDd6WkJuYnk0R2U0NjdDalRrTXp5ekVHd3V6ZFJqRmJHMFBO?=
 =?utf-8?B?RUo1VVFNdGNYWTJxNFZvUGdwem5FNWI3R21qcjk1ZHR5NFA4UnY4MnY4MFhT?=
 =?utf-8?B?czhNb2kzdCtWMS9FUmxNSm03QUJic3BIbjBId2N2WUtEMDlwa0VGNXVGNnZW?=
 =?utf-8?B?Mk1QWHpNSkkxRjRyOTJKZEdYQlFjNDhWd1ZPSGZ2d01pbDljMkpIZnJLQ0N3?=
 =?utf-8?B?RTZKcC9haWpVcFlvQnYwWlBnT2s1aWw4THE0U0VMVmN2aVlCazdWam5RbHpQ?=
 =?utf-8?B?SWtFZFdUOGNBYktlRUc1RzY4WWdpTEJTV2pQcnBDbnB6bFo4dnBKYWNGMnh0?=
 =?utf-8?B?bGZjQ3ZEbWNRYW5RN3pnQlRId2h1RnNtY0VITzIyeFFNdU1VL2ZLa1liM0hD?=
 =?utf-8?B?NXJhcS9hbWNmVTRYZG1GWFozcExHb3BxcEI5VzYrZ280b3dCMXVpZUZuU2p3?=
 =?utf-8?B?NGJxU1VzbDJpazdZRXZYNGFtQ0h5U3YwN2VZN1hDT09nU0pYMzBlRGNKV1M1?=
 =?utf-8?B?eW50VG5hcndrblhna3QzSDdNU0MrbnBKd0h0NFNsWUUwMFdieTRvMmpGRHht?=
 =?utf-8?B?U1doOFhEeXpzSXFlTDZzc09mV2VDUnFOWWxadVMyMmxEc2t3bE9KSFB6OXB3?=
 =?utf-8?B?Qi9TanVMQ0FOTnFaNUdzWDVVYnA1MnJXem5DVm04aFlSZVVOSm0rUy9tNEN0?=
 =?utf-8?B?ZytmdlNRMDRuekg1cDFIUG5nWmVkRjRCb3RURmRPUGJGb0RuWGhaQlI3Z3hi?=
 =?utf-8?B?cGNIdnY4Rk9wUlZDeXNtZ3pJTkNzNFkvK0svTlVoNWFubDB6Uk9ncE5WTjQw?=
 =?utf-8?B?azVMUGJrVEJ0eC8zT2ZUU2Q4LytXS2RHR29vZUk0Z25wemhhQ0wwVTl1LzM4?=
 =?utf-8?B?aFBsN0lDQ1RzSDF3TVZWWVNoVHhrbDRDT1g1Unh5SWhtWFh2a2F1MWV0OVpn?=
 =?utf-8?B?M3d1Y0FKUWN2RTVtVkJBOFg5WktSS1RTYTRXcXZ1NG9kbFBydW01ZXRVTjRp?=
 =?utf-8?B?OWxZL0JIMWdVYnFWYlhNbnk2bWMyaWMzMEs0Ym5Gd0dyOWc3eWEzamhObjQ0?=
 =?utf-8?B?b2d0a05XeXF4M3JaNEhTdTRBWm56bnRtRUJWeHd0QjhoL3V1cHZnaU4wc04r?=
 =?utf-8?B?VTB6czBHczBaeUpGN0lGSlJROGI5ZU80dWRhREx3eDV5L1k2UkZjeDl3Wk9F?=
 =?utf-8?B?TkU1bUVZeVlpbVE3L002MERyWk10L2hINmFkY0RjQVQyeFZjQ2RBbEpjY1Zh?=
 =?utf-8?B?N2c5TzRKUXFkZ1g1czJMU25LYzl0OGlVUEpKRDdqTStmMUNYcnpBNXRnQTN3?=
 =?utf-8?B?QmkySHphN2lGV2ozNlJzaE8wUVZwM0hHQ3ZPUGZ6ZHg5MTEyOW9Sak5TVWkz?=
 =?utf-8?B?SVdiekJ0TEVXSndmMjFWazVZN0hwMUpJY3BSY2JNeWdzcERtZExmSjAySFB2?=
 =?utf-8?B?TE9GNEROWUJKNENkNWl3REVhM29DVGNxdytwSFh3WnlKRmJaeHRodTRnaGxy?=
 =?utf-8?B?dzdwdjU4RkI4a205MmZwTkI2Y2hFNnd0SEtZWGc4SkFCZ0hzcTRIeWdsOW9R?=
 =?utf-8?B?UVIzc2wzV21mL3R4YTRZQ1Jzbm5HeDQ2M3E2Rkl0U0ZCQnB2OTlZRXJ3YTBm?=
 =?utf-8?B?MUI1M2M0MDB4VitMOU5pUDEvYmlUaTl1eitjdkRjU0RvL290N0YxUDBJUldi?=
 =?utf-8?B?VitOeTd5Z1phR01EWkpVQzV3THhCSmlpeDNQUWJrdnJ6NjFaU3d4TExsekZk?=
 =?utf-8?B?TXZMcjZGeFFzWnRCTGFzTkdjNlpQNk1rVERqdWsxQUk5cnhlSlBZS2ZsT3VC?=
 =?utf-8?Q?wMrC5/jYZe2I30dHr7BPkdFy6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f34739-ae45-423e-b344-08db67f35938
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 07:38:28.0862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 212d4md9pKLrQPpBfKC7fx2qxkndarFDqIiEUpw6O0a2iDsngjYWXGhdi/Bz2rKMlNJeo4nUPaDxpNHY3HnYXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7152
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120; envelope-from=fei2.wu@intel.com;
 helo=mga04.intel.com
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

On 6/7/2023 8:49 PM, Wu, Fei wrote:
> On 6/1/2023 10:40 AM, Richard Henderson wrote:
>>> +static int
>>> +__attribute__((format(printf, 2, 3)))
>>> +fprintf_log(FILE *a, const char *b, ...)
>>> +{
>>> +    va_list ap;
>>> +    va_start(ap, b);
>>> +
>>> +    if (!to_string) {
>>> +        vfprintf(a, b, ap);
>>> +    } else {
>>> +        qemu_vlog(b, ap);
>>> +    }
>>> +
>>> +    va_end(ap);
>>> +
>>> +    return 1;
>>> +}
>>> +
>>
>> Not need on this either.  Global variable being checked on each
>> callback, instead of selecting the proper callback earlier -- preferably
>> without the global variable.
>>
>> Did you really need something different than monitor_disas?  You almost
>> certainly want to read physical memory and not virtual anyway.
>>
> Yes, it's usually okay for kernel address, but cannot re-gen the code
> for userspace virtual address (guest kernel panic on riscv guest). I
> tried monitor_disas() but it failed to disas too:
>     monitor_disas(mon, mon_get_cpu(mon), tbs->phys_pc, num_inst, true);
> 
> How to use this function correctly?
> 
'phys_pc' in tbs is returned by get_page_addr_code_hostp(), which is not
guest phys address actually, but ram_addr_t instead, so it's always
wrong for monitor_disas. After some dirty changes, tbs can record the
guest pa. Now we can disas both kernel and user space code. But still,
no code is regenerated, disas in 'info tb' is just a convenient way to 'xp'.

Is there any existing function to convert ram_addr_t to guest pa?


(qemu) info tb-list 2
TB id:0 | phys:0x11b97762e virt:0x00aaaaaab76c262e flags:0x00024010 0 inv/1
        | exec:4447539979/0 guest inst cov:69.06%
        | trans:1 ints: g:8 op:28 op_opt:23 spills:0
        | h/g (host bytes / guest insts): 37.000000

TB id:1 | phys:0x8063474e virt:0xffffffff8043474e flags:0x01024001 0 inv/1
        | exec:131719290/0 guest inst cov:2.38%
        | trans:1 ints: g:9 op:37 op_opt:35 spills:0
        | h/g (host bytes / guest insts): 51.555557

(qemu) info tb 0
------------------------------

TB id:0 | phys:0x11b97762e virt:0x00aaaaaab76c262e flags:0x00024010 0 inv/1
        | exec:5841751800/0 guest inst cov:69.06%
        | trans:1 ints: g:8 op:28 op_opt:23 spills:0
        | h/g (host bytes / guest insts): 37.000000

0x11b97762e:  00002797          auipc                   a5,8192
       # 0x11b97962e
0x11b977632:  a2278793          addi                    a5,a5,-1502
0x11b977636:  639c              ld                      a5,0(a5)
0x11b977638:  00178713          addi                    a4,a5,1
0x11b97763c:  00002797          auipc                   a5,8192
       # 0x11b97963c
0x11b977640:  a1478793          addi                    a5,a5,-1516
0x11b977644:  e398              sd                      a4,0(a5)
0x11b977646:  b7e5              j                       -24
       # 0x11b97762e

------------------------------

(qemu) xp/8i 0x11b97762e
0x11b97762e:  00002797          auipc                   a5,8192
       # 0x11b97962e
0x11b977632:  a2278793          addi                    a5,a5,-1502
0x11b977636:  639c              ld                      a5,0(a5)
0x11b977638:  00178713          addi                    a4,a5,1
0x11b97763c:  00002797          auipc                   a5,8192
       # 0x11b97963c
0x11b977640:  a1478793          addi                    a5,a5,-1516
0x11b977644:  e398              sd                      a4,0(a5)
0x11b977646:  b7e5              j                       -24
       # 0x11b97762e
(qemu)

(qemu) info tb 1
------------------------------

TB id:1 | phys:0x8063474e virt:0xffffffff8043474e flags:0x01024001 0 inv/1
        | exec:131719290/0 guest inst cov:2.38%
        | trans:1 ints: g:9 op:37 op_opt:35 spills:0
        | h/g (host bytes / guest insts): 51.555557

0x8063474e:  00194a83          lbu                     s5,1(s2)
0x80634752:  00094803          lbu                     a6,0(s2)
0x80634756:  0b09              addi                    s6,s6,2
0x80634758:  008a9a9b          slliw                   s5,s5,8
0x8063475c:  01586833          or                      a6,a6,s5
0x80634760:  ff0b1f23          sh                      a6,-2(s6)
0x80634764:  1c7d              addi                    s8,s8,-1
0x80634766:  0909              addi                    s2,s2,2
0x80634768:  fe0c13e3          bnez                    s8,-26
      # 0x8063474e

------------------------------

(qemu) xp/9i 0x8063474e
0x8063474e:  00194a83          lbu                     s5,1(s2)
0x80634752:  00094803          lbu                     a6,0(s2)
0x80634756:  0b09              addi                    s6,s6,2
0x80634758:  008a9a9b          slliw                   s5,s5,8
0x8063475c:  01586833          or                      a6,a6,s5
0x80634760:  ff0b1f23          sh                      a6,-2(s6)
0x80634764:  1c7d              addi                    s8,s8,-1
0x80634766:  0909              addi                    s2,s2,2
0x80634768:  fe0c13e3          bnez                    s8,-26
      # 0x8063474e

Thanks,
Fei.

> Thanks,
> Fei.
> 
>>> +void qemu_log_to_monitor(bool enable)
>>> +{
>>> +    to_monitor = enable;
>>> +}
>>> +
>>> +void qemu_log_to_string(bool enable, GString *s)
>>> +{
>>> +    to_string = enable;
>>> +    string = s;
>>> +}
>>
>> What are these for, and why do you need them?
>> Why would to_string ever be anything other than (string != NULL)?
>> Why are you using such very generic names for global variables?
>>
>>
>> r~
> 


