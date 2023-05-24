Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE5970F7BF
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 15:37:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1oeN-0005cr-PE; Wed, 24 May 2023 09:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q1oeJ-0005cg-4a
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:35:31 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q1oeB-00033T-Jd
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684935323; x=1716471323;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Rpbq/f5DR9qNrC99f0D/+fDoXHWDUEE1UZFqeJX5cQY=;
 b=RwMy0OH5Ars4bIJYHcfI4TqfBr3dzqHRf48h8+8vmDNmataZlFNljGuk
 25HRVkdKdpqo2tKpaHwN5SaYmaxRJosisy69CP1+PJ+yxSUDhEVijRGlG
 fJTyGBGmDYwEKg0NKplQXXA26Gh2WRStP7sxZSK/IHZevzzT3MZsaMHAy
 OeA/kTYtmpCtsjQnkShwHyewYJfjFqwmm8z/cuM02bqA1Mfl7D5WiGuBL
 K+5KvnHfnkMRB5MQw1HOFI20i62+XLMvZYCa83C8Nnmwzxd3cxgXiRyVC
 EdJ/Sa/bmxAWo7NU3isTp0z5/Xxs9ysIowiLKc6Ih+miylO3RAb6MhUwG Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="381808053"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; d="scan'208";a="381808053"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2023 06:35:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="654798752"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; d="scan'208";a="654798752"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga003.jf.intel.com with ESMTP; 24 May 2023 06:35:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 06:35:18 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 06:35:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 06:35:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 06:35:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqyiBadVn3t0mQCOMIlHUYye9b8IlFvXmVw7nkMflLq7aM89vfokXFHMBhJDY2DP+/4xR6PaQyjlQygl3EHQs12rdQXfv2mBu9ZBBzIJHBov1XA+MzkmiLUOCO2OXon+rUQ1rkCENel1c4WJCw3pXlSwZavigd1RJMlxxSeFJdwlEh75qRk9ymdPIReqb7QS2TyYzUcao8l+8GcS2dGBtDcz65+uACDCNz0k5DBtztvXzzkW20rfkjaK04pPOG2kh3FLdDLW2mabO+hxqIQW7KZfK9NlYWdhz9V66G29+6oO4yg6sdB9TD/xFnGhVyINFHumWgLgYDzxSDTWzAh/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvis1F1/YB/kPlAxlYi5otZEDp9okQe+omndMFO7UZo=;
 b=cqdfJirhr0h+/ZsSuYx+qA6AtHzsUGfb7ZThYDURYPaCUaDjnQQKvSCXP7kVLojaweKlM0yklGKgTD+qwVeOyp+oXNFI4/RfFWzvdK5W/sVSl0wnF3jGJaalk6aQoLhWZa2501WPbUr9IyGrbT1/Zi2BIZ0p/1zHNsztYw1rniX0MS02yc2xryxxPrcqrO56ptXVxdRmwRRFKnUCX/XCwelL3DX7aziiAPWPIV1CkErjeP7z7ZQ6LUdnGiZNL4Qi8DR03EA7eQQJg+Wvepb2uRULeEC2l6nPVXnk2HEeLBFckyJMi9hr7WKkheywomAdQTK+TO4Xr/ddr1CmfW1fhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by DS0PR11MB7903.namprd11.prod.outlook.com (2603:10b6:8:f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 13:35:15 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::6418:8391:dce:a06]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::6418:8391:dce:a06%5]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 13:35:15 +0000
Message-ID: <8adea3c0-ca06-1dd0-366b-f7eba9be6890@intel.com>
Date: Wed, 24 May 2023 21:35:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v12 02/15] accel: collecting TB execution count
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>, 
 <alex.bennee@linaro.org>
CC: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>
References: <20230518135757.1442654-1-fei2.wu@intel.com>
 <20230518135757.1442654-3-fei2.wu@intel.com>
 <0bf482cc-fb96-0ada-f166-50d99b4952a5@linaro.org>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <0bf482cc-fb96-0ada-f166-50d99b4952a5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0100.apcprd02.prod.outlook.com
 (2603:1096:4:92::16) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|DS0PR11MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: a0821bec-9cab-462b-04a5-08db5c5bb4c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5rHkPswq7CN3I/yMwWrz0B4Fg5SaE7R/z2tcQmwP/do2wE/STx2x1hO/IgSlFEBz2pwgQ9KL2ZzMIiQMWcLmsq0aZZXlIBcsQu/sfutQR3Qe/S7nKo9xXVpwTNEkseykRqUpErJPuPaGyRSOQQWeajWZl2TnNDZ/LacMeMA7Z6yFEc5JTPZRJHXgYceFn2Nh5+HUWn+LIDz2fYBdkCZjJ7r2tUH8BnbWq4kyz0gHgA7LqBh4/IXlNT5LOHppxl9Njn7C8VXoAuCj0iG7Sole4noyrSGJQJGdOiLPrf7zj2sCalBZ1+t132uFe61KbYWiv+QYNRYh1oPPPxDVZ7aqPb6IWdq53TsRWPfEiTrIAjADDMtoNwJGoORzVApxW3l4Q2vX8Gf6AomQ8C/u01WSPrC/8Z6B0sGjoigBsUGmdgEUiTtR71s/Hf0jLwolY0EaS8DTbj2lzTCW1W/WQzeKXY/PSJsU54+kpsMlpb9mJoZP8niCIvBodhiItgLK3ceP1GQvUfz7MrGnb8AK2RiW97lT3CMFm3MwomVHuk2s4LjftzHyz0lCBPSXA0Q81liGiXYSXpl+Qegl8EM9Orz/NdbOVE6UW1XW4rSkCk5Qs/a+aCQjndcX3tCsicCeBbxfDncP/2SrQUsSim8EZ5vvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199021)(31686004)(2906002)(83380400001)(8676002)(5660300002)(6666004)(6486002)(66946007)(8936002)(54906003)(66476007)(478600001)(316002)(66556008)(36756003)(4326008)(38100700002)(2616005)(26005)(82960400001)(186003)(6512007)(6506007)(53546011)(41300700001)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d290VGZ3N2xsSTkyTmJyVVRhNmhDcmNNTkc3QXgyVnpGQWVwbzZtT1lUZnpG?=
 =?utf-8?B?dzVUZk94enZ0TTBIR0tKUTV3aDJ5QnNCV2FoZndnSW5IYzdJWW1xck9yYm9N?=
 =?utf-8?B?bkttYm81VkVOaWEwemo5M1dsSDl2UmE2Z3Rxd0lwV3loZnBLZDkzMWJ5d3N2?=
 =?utf-8?B?blhjL3hzbFl6azRVT2tEYXJtMWtIZENhbGpBVzd6akV2OHdjZkw4Nm9uK2p3?=
 =?utf-8?B?ZUd5WkRjVEZPVzdaZzNVS2M2L0M0bW9rT0Q2WFphR1AyU1M3YW83bzV3UkxJ?=
 =?utf-8?B?a2ZNVmVMK3Q5YlNheTRzVVppNDBjM3prQk9KVG1ZZGF6UFVPbDNtckplSXFL?=
 =?utf-8?B?NGJ2Z2toTHRpMUtRY2lSTWFtRlRYczJMbE93VTl5ejRGbnRjaXFHOWxFVlQy?=
 =?utf-8?B?ckNpQ2Z1S1ZKSGkwRFowYktsVWN3MlNjSGZiVzF5WkVFOEFnZ2E4em9oMFQ3?=
 =?utf-8?B?RUVaNTNFN1dPdExNdHdhUFRTcDkzNGFhdFlEVWxEWU9yZ1B3QWRYbjRLdC85?=
 =?utf-8?B?MjZ5cjRNVDFNWG94VDRES1RPNFh4Y0FGNHNybVdhcGlmTVdzVEJNeTJQVVhO?=
 =?utf-8?B?VUNIKzBmdU5qN3QySVZYV3Z0Y0xjUzNMK3ZEY2dHUFZqcy9Wb0ZhTjJuNmkz?=
 =?utf-8?B?VEM2blhQQXlGTDArRGdIRHBTQi8xcXN3RzBMYWdldHBmdTZwTkhqcVdJUnNV?=
 =?utf-8?B?VEc2ckZvZHljRUtzalk1am1ZcGRxRlFDUlhzbDFYUG95ZEpQSE5LbUxMUjRw?=
 =?utf-8?B?UnNSOWJWQ0FvVUtHU2lIUHRLek5FQjEyNVlJc3diVVFkODFMZlg5S2w5bUxD?=
 =?utf-8?B?WmtPcDVMTlRvanNqanAvSTBaSm1USGJHektFTksvNi9PcFNHbng0ZVVRZmZo?=
 =?utf-8?B?andxN21xa0JMYjQ0YW13YVJzQnE3OEUxS01CRWc1K2hreCtkd3lmaW16ZkFF?=
 =?utf-8?B?a1NxSWM0cHQrcDhFQ3pMZy90UnYyeXNvdllLVXoxY3VwT3g2eFdQbWZCY0w2?=
 =?utf-8?B?YkM3YzR2U01RdW5KYVlxakRYdmszbVpyeGFiR09ZL2E2QUtCcUVTb21VSGlR?=
 =?utf-8?B?RDdXNitOeVNtV1RaVm9jT2FXNm5lanN4S2ViaytQdmV2bzZSU3hXY09WZFVr?=
 =?utf-8?B?RWMrOHFVNWRHbktqOUlrNU4zemhnTjBtRjkvamRFOEpEMlFySllQNkdLYWo2?=
 =?utf-8?B?eCtXWStSUjF5N1JLWGxZRTJ4by9zVk85V3JHbHRRSmdhTmovYnhqcVpyb1Iw?=
 =?utf-8?B?a1pEWmFFdG1iTDNDVWhOOERsbUJLRkVUa3liaDk1Q0hsdGV5N3M3aGdpVnYr?=
 =?utf-8?B?R0NaMHhnLzBCWWtWelNDc2ZKUHVjMUhvREpSNFh6KzhvaityT1dZSHRLTnJO?=
 =?utf-8?B?M3MvUzJJcWFVK3UrVDAvb0xRcmgrUks0dkRZS1NGLy9FQnhJNU9wR2NQTkVn?=
 =?utf-8?B?eDM3TkczL0taTHIwTmJ2MDNzOVFMYlN5ZW10aGNaWnVZd2F1Vkp1T01MOEhi?=
 =?utf-8?B?dTVBOHJGSVRBRE8xYk9QQnBrY0FsSWozWENKY0owODExRDhuRnY0bU1IV05w?=
 =?utf-8?B?a1NFM2J3LzdkWXdnL3FGZ0NhemZsdmdYQ0ZuWkRFa1VLOFRIVlZMNG1vVlJQ?=
 =?utf-8?B?cHk3dUZjbHhIa1ozREMyeGg5c253U0NSdmlrcWk4QlRtRmMvcW1WM3VyQ1Qx?=
 =?utf-8?B?VGNvZWxkbVR1OGtZVldnWE5qV0o5bEpZNElOT1JNUUJqZ3hBWXZxR1NubERS?=
 =?utf-8?B?RmYvbDh3bTVNNGFLa2tRdlJBSUxSVEVWNkNRcHBXOFhzdm00SFNGWXVaVks5?=
 =?utf-8?B?WW8zUEI3WWVaUEZ4bS9kVW1CMFpYSlYyNmxyZ3NMM1N3bGU4RGlzTjBEU1BO?=
 =?utf-8?B?RUM0bWRMVjRUZE9QdlZ6dERwSGNlODhtWEZJV08ybmc0YUttaUliNCtuN1VO?=
 =?utf-8?B?MWl6bS9mTTRrWnZvZnhqNmo3UmJJbjJwbWcrdUZkelZERlNRaGxTQ2VjNkpF?=
 =?utf-8?B?bTFyMmN5L1lPOW9wWm1CK2VsTHJWeVQ5NjVUZVBlWkFCY1lBYTZTTVFLNjVS?=
 =?utf-8?B?ZTgvaVlMKzBqMXJ6YUdRNW51dDBURHA2YnI3Vzd6WmNXdVp5MHN1QWtydTN3?=
 =?utf-8?Q?UaVPCx19WQy0b7zWkblZry/Dt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0821bec-9cab-462b-04a5-08db5c5bb4c0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 13:35:15.0595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FseG+Eq11wDCO22MBoEF0tDiyFEInJsQHATrfyaxTPNrDPJwQM+1HNGfyOF4zD/febRKTXkLxVSAH7jR3CaLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7903
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.88; envelope-from=fei2.wu@intel.com;
 helo=mga01.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/23/2023 8:45 AM, Richard Henderson wrote:
> On 5/18/23 06:57, Fei Wu wrote:
>> +void HELPER(inc_exec_freq)(void *ptr)
>> +{
>> +    TBStatistics *stats = (TBStatistics *) ptr;
>> +    tcg_debug_assert(stats);
>> +    ++stats->executions.normal;
>> +}
> ...
>> +static inline void gen_tb_exec_count(TranslationBlock *tb)
>> +{
>> +    if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
>> +        TCGv_ptr ptr = tcg_temp_new_ptr();
>> +        tcg_gen_movi_ptr(ptr, (intptr_t)tb->tb_stats);
>> +        gen_helper_inc_exec_freq(ptr);
>> +    }
>> +}
> 
> This is 3 host instructions, easily expanded inline:
> 
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -11,6 +11,7 @@
>  #include "qemu/error-report.h"
>  #include "tcg/tcg.h"
>  #include "tcg/tcg-op.h"
> +#include "tcg/tcg-temp-internal.h"
>  #include "exec/exec-all.h"
>  #include "exec/gen-icount.h"
>  #include "exec/log.h"
> @@ -18,6 +19,30 @@
>  #include "exec/plugin-gen.h"
>  #include "exec/replay-core.h"
> 
> +
> +static void gen_tb_exec_count(TranslationBlock *tb)
> +{
> +    if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
> +        TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
> +
> +        tcg_gen_movi_ptr(ptr, (intptr_t)&tb->tb_stats->executions.normal);
> +        if (sizeof(tb->tb_stats->executions.normal) == 4) {
> +            TCGv_i32 t = tcg_temp_ebb_new_i32();
> +            tcg_gen_ld_i32(t, ptr, 0);
> +            tcg_gen_addi_i32(t, t, 1);
> +            tcg_gen_st_i32(t, ptr, 0);
> +            tcg_temp_free_i32(t);
> +        } else {
> +            TCGv_i64 t = tcg_temp_ebb_new_i64();
> +            tcg_gen_ld_i64(t, ptr, 0);
> +            tcg_gen_addi_i64(t, t, 1);
> +            tcg_gen_st_i64(t, ptr, 0);
> +            tcg_temp_free_i64(t);
> +        }
> +        tcg_temp_free_ptr(ptr);
> +    }
> +}
> +
>  bool translator_use_goto_tb(DisasContextBase *db, target_ulong dest)
>  {
>      /* Suppress goto_tb if requested. */
> 
> 
> I'm not expecially keen on embedding the TBStatistics pointer directly
> like this; for most hosts we will have to put this constant into the
> constant pool.  Whereas the pointer already exists at tb->tb_stats, and
> tb is at a constant displacement prior to the code, so we already have
> mechanisms for generating pc-relative addresses.
> 
> However, that's premature optimization.  Let's get it working first.
> 
Richard, have you reviewed the whole series? I will integrate your
change to next version.

Thanks,
Fei.
> 
> r~
> 


