Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AA27154AF
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 07:03:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3rUL-0007wI-KJ; Tue, 30 May 2023 01:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q3rUH-0007tS-MF
 for qemu-devel@nongnu.org; Tue, 30 May 2023 01:01:37 -0400
Received: from mga18.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q3rU5-0004Nc-Ut
 for qemu-devel@nongnu.org; Tue, 30 May 2023 01:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685422885; x=1716958885;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=m7F9NWmx2OEsaAaTId5BL8VeJFJX0ldFWDGgG30t9DQ=;
 b=fp9M/kk33YnJiZ8GIIwWjY/af6Lqm5rZzWUe8mJ7VLedGn+DBLa2jRUo
 ShvQ2YTiyai95XHIhfKyy4J8RVVR4Irz1rggAnxkMPTqU7OL2aKwrcXZl
 d9OQFMFMxem+Qz99vvqbg8uG+t0qX92FMRcDEpfwVQ6udzkFj5qAC4m0k
 rBDNtPGfsgR8RcnRZ583F4JfcwiW+boA0rIhmFQ3L9P5p7ExnMfQQBYeI
 WYfCt/CVEHvENGOXH/MVLQedALvqDlGCpHP1h8WGUqEFhEtWxSTe/o4UM
 O8zZDgzFpheUamBy1JzzCq4LaIPzIBqoXSlHgpokqF4bCJmO+6u4weqFh Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="339405794"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="339405794"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 22:01:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739359492"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="739359492"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga001.jf.intel.com with ESMTP; 29 May 2023 22:01:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 29 May 2023 22:01:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 29 May 2023 22:01:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 29 May 2023 22:01:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTPNKWi7m1UTOh/tcA/twHf6G2bry/ZxCd4SXsnhOArLvalZFLQNJvBzm/xqtakVrEzja+wufh4sK+kmYnVJm3vWuR8bUck2C+4J8ZJ57oFNM8K3opamH1fnMhqTUUnO++SiNftVvsiYoUAmfTQR5UEtpinAAyUfJ7IZ8bV/+TZxmPEquS3JJqCpzWMDkSJh1z4E3YlOJHmIKIxuvsrcJltCdRlfTcQBARiQ1VWAx1SNbJJmPnwu2V+5+5OyzAoaYfn5mDmmxfssOo9yRrJYK9YH9ddBbYZV4qKFOAZZezWd79/gQM0UNXV3UGL7Fv4xNJ7fClzokBUDoqcw7KB68g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IGNqbNxbBWYFM4CsDsHcOoQaBdo3BMVu/fLpHA0sM0=;
 b=k33GZWj1HvBeJGU89EOPKZq5b0uDnp4fm+IKwi7F1Dt2t9U+Hu/J62mSb+F1Rd/CiAH50iBM+qV4nfmbused/5T4WtMEGErPPzYUTW/1el2bH8Bbx2z34oNlcgHZj38FR/afHKXTtF0w5P8vr5isuTBJW3s16t2TkdoY8J2BWXFJXCKXWlRFz8WZLlq0Jo1sOI6uD0eplZwiEjYykIOpj3v0ndBCfMVLqyZK4E8+0w1VXZmqSUyDafJQPD8RLzydlAY8VgUmcEeEJF5q+zZhJ7DeV3jRKubUJQHL/Ib8z1EHws6SEZazz+w5ZbeM3vZkCVrVKMBbgSLW3lH5EA6mmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by SJ1PR11MB6084.namprd11.prod.outlook.com (2603:10b6:a03:489::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Tue, 30 May
 2023 05:01:16 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::6660:3269:205:8c6]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::6660:3269:205:8c6%3]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 05:01:16 +0000
Message-ID: <ddc552ba-c95d-4b31-01d2-a6d70a978f1c@intel.com>
Date: Tue, 30 May 2023 13:01:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 04/10] accel/tcg: add jit stats and time to
 TBStatistics
To: Richard Henderson <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>
CC: "Vanderson M . do Rosario" <vandersonmr2@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230529114947.2123652-1-fei2.wu@intel.com>
 <20230529114947.2123652-5-fei2.wu@intel.com>
 <98196efc-213f-3351-1564-5008ccd90f36@linaro.org>
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <98196efc-213f-3351-1564-5008ccd90f36@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::29)
 To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|SJ1PR11MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: eb818748-3ca8-47d5-849a-08db60cae5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PE8Z2lkFhyOK3UPNVrIldtkCAy+hLh/5cUAGFxg162EVWBN1Pyzl0sb5MUB6/p2mhVVguVBmgLp3aVm2TK/+7Z/VDAJZsEwcSjmkVURRQ54DhIEJ2BmssJ+5qpq87S9HveS8QNDlYjUg23L4j80uQCiC8uwMsLKUbqjH3k3qESZ9AU78foZfr3yiFKwCXck82j0mFw79dp6zANm4yEqDfgjqFlMRHQUVbCfArChNV/7KjvVUNkGC1RAHae+6lrKVbDyV2qAw3ydXxYDA/GJ+ncTW+QocAxMWbAIKUACu1Qv3j8PXR3FTG5wD91lG+OT5kVtSWM/QnaEAg/qSWGYotU0T7BX9ndWBL8UkonpymLErckYDtQNJNILfgmLn3zmMqSumc4m6xGXVjDer+yQqpOyMhpAp5K6bzR9CjobBD25lq9cebvrlxaJDA5W0KII1ZDBiuKHfwwb0rzxqLz8tuujDaWZDIKP5sBzOqLql0GhN9cAVqVZvjdy2I+UmoBTkCPwmGkTFaSaqRGNaA5RPEY2/tFvvE+QbAPp+w6+mLN75ukdB1UQvqZWkXt4uz7SQWCuNJfWIDzyOoI3On973fMZOU6bTxrrMVWwQbG1hhaLqZBPLYXBGKIKTvgUaTvCxcLDNA6DbAU8MJUvZxym+Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(186003)(6506007)(6512007)(53546011)(2906002)(2616005)(36756003)(83380400001)(4326008)(316002)(6666004)(66476007)(66946007)(66556008)(6486002)(41300700001)(478600001)(38100700002)(54906003)(82960400001)(31686004)(31696002)(26005)(8936002)(8676002)(5660300002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFkzQlE1NDNZVSthLzhxVVpGM1N5eXUvZDNlemh6dVkybHVxT0NIa1FFTUFo?=
 =?utf-8?B?WHk1KzFsRzVVcXVRSUt4N1dIZitrY25GempuRkhTLzJNcEVaN3ltQ2JGYThT?=
 =?utf-8?B?eVVrUTRKb05JNDJtc3RvRGlabVZPMmJSNVF4KzZ1VzFVaDRnZWF5dEFBMFhS?=
 =?utf-8?B?ZDkzT1FzQWs1WWo5L29VTGszT3piL28yaVFBZTJiQ0tld3hnekY2K0dDeHo0?=
 =?utf-8?B?YU50YSttQmVRVW1ZWXROKzRQMUVQbFpsNmxwaXd0Z2d6RXd2bUd5Zlh2Qlhx?=
 =?utf-8?B?U3ZsZHVCQzd4Q3Z0Mm5OcjkwbzYxRXNPZDVldlJGbG9UNlp3VFlMTUl0Q0Uz?=
 =?utf-8?B?SXdwcTh3dVppQ05lRWVNOERoTW1LZGh5ZjNrcGt4eUZSK09VaEE1cEZIWGl0?=
 =?utf-8?B?V3liVHdJYUsrRjNsbUV4NVcrV1lSZzJIcWZHL005K0ZMVXVzeVBoSWNGcmU4?=
 =?utf-8?B?N01XbEYzcXpBaWhXN1B2VncyK3FHR2YwelZJdzYzenNhUWsyUUpFZmhwNWl2?=
 =?utf-8?B?Y2g3Q1lrdTVCUlBVa1dMKzJBTlVqblFZZmIrSURqUk9yU0RrcGowU3JTbUNh?=
 =?utf-8?B?eEJIa0RmMUJEeDVMMDhhYndNOWtxL05kRU8rdDFsdUl2cmgwbUh4U1ZGclg4?=
 =?utf-8?B?NWJCbkxnRVJXY056V1ZrTUFrMDNLNkZwV3ZlMVR0V2M3UXk5L0dvdUhvd0Y2?=
 =?utf-8?B?a3VENDllM3BWNFd5b3djc1M4TkR6WE15Y0RIUE5xbjE2RGFKd0RjSjFrL3BI?=
 =?utf-8?B?QkFremd0ZGxsQnAwV3RnYUNqZlNuZUk1SStNem9iQncxdGhmS2RTZHN4RGRQ?=
 =?utf-8?B?djZJVkNjNGppOXhwWHdsakErczBDNmZJUEcvVkJSUDFXZG4wSmovYU1LYnBE?=
 =?utf-8?B?M3AwRDJaNGhTRG44NTBIYlZWblgza01rbmcrckIxL0dYYzNIZWk1NndhbSth?=
 =?utf-8?B?dE1LQjRwcXFibzczWjJkdHUrK0FPNEMwZDdNaEN4TmY2VnRyUHFiK3ZXdjNL?=
 =?utf-8?B?QkZWcDRjYnM0MGw1KzBVOStqMmUvamhsVEpJWWtVRHVRb2QyVTBESm1ITTkz?=
 =?utf-8?B?cE04enVVcTRCdGl0VGlyb1BPZmlJT1J2U3NkS2V6Q3U4WGVrN2lvQnlJZ3o1?=
 =?utf-8?B?OUVDU3h0Y2ZTcDZhaUo3b0EwOE5IemxrdE01bVBJNEIzeHQzbUQ2dlpKTGVY?=
 =?utf-8?B?cWpHdVk4eXdubFBBWE1ubUs5NEg2ZGpVWmt5OWpLTXFVT0lRK2xDK210M1Q1?=
 =?utf-8?B?TDdLRXVqOU9QUFJyY3dCTmdmVEloNkJSUFJzY2NNY3hQajFFZ0ZFZVlISkhB?=
 =?utf-8?B?OGVvUW91WDYzUDFZWGJ5bzJRZmNCbkdaNU1TelZNeXlSZG1lMmE2WTBNbGlF?=
 =?utf-8?B?WWxiNWluaDg0QzEzR2NjUjkxaGRQU2FDMmFVaTBUa0tacy9oejBhTWZ3MTl0?=
 =?utf-8?B?akkrc2toNUpObUdyY0hhS0JjQzNWZU01WjZOZG9oc1l4d1ZLTjNGODYveE9n?=
 =?utf-8?B?dWxaZmNVUE5tNmpsVjJOWkxoellGVERqUHpPc3VDdHhDdHl2akcrbnhxeHN5?=
 =?utf-8?B?R1FIUnZ2UjhXZHJlQVE2emJJcnpnUmwxem1jcjMzSS9OOGRUSm1Ib2dDTEZ6?=
 =?utf-8?B?ZGFEV2J4RGI0WUY5MG1DaDVZUFRnb0hSN1crT3VjYTVmL1hrY0ZSZW5HVDFj?=
 =?utf-8?B?SGFjTFNuQ3hPU053Z0VBUG90cS9NbGdwZXRzYzQzNnozNDVrMzBxSWkvcW16?=
 =?utf-8?B?djYvdWo0RXI5Vmp6Q1plZm9mcEhBbXpWT1ZCTmNVSzd6QzZsSlY2c0UyRWc3?=
 =?utf-8?B?VDUwMmVPZmdmcGJxYU8xenAzNjFabnJPL25qdlNCaDhwRHpwK0NuYUxXcGl2?=
 =?utf-8?B?Q0NKRXl2NGdsZkFLNm1GVnE4d0hrQ3ZteG1EcjZNVGhIbVh6dzRqUU44Q09i?=
 =?utf-8?B?dks3blI5Y0oyVXNBUWVNYk1FZzIyNi9EeGtkaEFqaUl2NmtiYzlaMWxJTUZn?=
 =?utf-8?B?SndrK2YzOXlpOTdsT2JscWJZbVR6T3VybU1iSjcyT1hmZ1RmTXBHdE9UMkEr?=
 =?utf-8?B?VW5sbzByak9wT0ZqS0FqN2l3MGZsckQ1ZzVsV2EzdDBLSTE3Z2l0bDJmaVdw?=
 =?utf-8?Q?tUUKTtmpn/Hj1tsvE5us9b7va?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb818748-3ca8-47d5-849a-08db60cae5c8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 05:01:16.1259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Prs+vaPgZItrayE1UiWKuJ8xY8JxivDWMCzDvNOcotscDYfFS4M6NY2Lk+k2ykPsvAVtLZvSa8RWOxnkPwAeQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6084
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.126; envelope-from=fei2.wu@intel.com;
 helo=mga18.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
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

On 5/30/2023 12:07 PM, Richard Henderson wrote:
> On 5/29/23 04:49, Fei Wu wrote:
>> +/*
>> + * The TCGProfile structure holds data for analysing the quality of
>> + * the code generation. The data is split between stuff that is valid
>> + * for the lifetime of a single translation and things that are valid
>> + * for the lifetime of the translator. As the former is reset for each
>> + * new translation so it should be copied elsewhere if you want to
>> + * keep it.
>> + *
>> + * The structure is safe to access within the context of translation
>> + * but accessing the data from elsewhere should be done with safe
>> + * work.
>> + */
>> +typedef struct TCGProfile {
>> +
>> +    struct {
>> +        int nb_guest_insns;
>> +        int nb_spills;
>> +        int nb_ops_pre_opt;
>> +
>> +        int del_op_count;
>> +        int temp_count;
>> +    } translation;
>> +
>> +    int64_t cpu_exec_time;
>> +    int64_t op_count; /* total insn count */
>> +    int64_t code_in_len;
>> +    int64_t code_out_len;
>> +    int64_t search_out_len;
>> +
>> +    /* Timestamps during translation  */
>> +    uint64_t gen_start_time;
>> +    uint64_t gen_ir_done_time;
>> +    uint64_t gen_opt_done_time;
>> +    uint64_t gen_la_done_time;
>> +    uint64_t gen_code_done_time;
>> +
>> +    /* Lifetime count of TCGOps per TCGContext */
>> +    uint64_t table_op_count[NB_OPS];
>> +} TCGProfile;
>> +
> 
> Why have you added this back?
> 
> The whole point of removing CONFIG_PROFILE to begin was to have all new
> code.  Not to remove it then reintroduce it unchanged.
> 
> In tcg_gen_code, you have access to the TranslationBlock as s->gen_tb. 
> There is zero point to accumulating into TCGProfile, when you could be
> accumulating into TCGStatistics directly.
> 
TCGProfile contains global wide (per TCGContext) stats, but TBStatistics
is TB specific, some info in TCGProfile such as table_op_count is not
able to be summed up from TBStatistics. The per-translation stats in
TCGProfile may be removed indeed.

Thanks,
Fei.

> 
> r~


