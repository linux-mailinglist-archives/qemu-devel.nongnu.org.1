Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4966710216
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 02:47:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1z6e-00055v-OK; Wed, 24 May 2023 20:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q1z6a-00055c-Pq
 for qemu-devel@nongnu.org; Wed, 24 May 2023 20:45:25 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q1z6X-0006XD-Ru
 for qemu-devel@nongnu.org; Wed, 24 May 2023 20:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684975521; x=1716511521;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kuE9oxKGV7pERfG3j1fwzeFTeEdS/NEhc9BAgM7fJZs=;
 b=UB2yPd0rfkBKLNTchXd5hBIr2xUQZAGt37w+NtppMYLotYJAeRHq0sHS
 X0aLBaiiEUGKbPDNQhNFy+kwyegu2fxxvgIYm2hQ55UEoOnzYtBzwEgQN
 o2/ezCciXQ2+oPg1UhCkA2n9yxckCTI3Y0/ZIA8NzD4+S94XKc6wgXG0b
 RvgEszIUiw2YXNFbJuyRFqpf1FH8fIRBfCuRnx9Dr3tiTfuOY8bPrZsBN
 RurUzHkCtBPH3aDquYSO8z9PU0dFPnyF1SJFBfkRpnUdq5nZ5UI6ftQ9J
 jMMbvoeasCwM8OAQpZD5bvvjjR3n0OnTwQ4Ckv3tSej/uf+qqHvKHevBs g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="356968324"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; d="scan'208";a="356968324"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2023 17:45:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="848983325"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; d="scan'208";a="848983325"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga001.fm.intel.com with ESMTP; 24 May 2023 17:45:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 17:45:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 17:45:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 17:45:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbLL/mDWhNYEwU0NbPhKXGWNcw+aKH1VQw8x5vw2/93/UcIO0TuBHjJ3/7iyxzVG3NkVQweeYTO4nA5vDcrlLqQcQyVZH47Dav/TLsJNrx7mSvsbpHKW8IJzL+nMBa1hwQmOJJ+GNIa4vAZ8a9N8ssfya8FcbQ1PfplyHeCpFgpT9SGypwjXCEMyy6q6VQptR9u7ZaIDPUbmaTiU5boEbzB5gIAUaV8pWXmLNLyVEFnteHSkXcsAh0eGi34R12rZ1R4VybV+6iht0pNrEHedBjANewTPq8Jd5Z4y66EXVVnLl6DuIm0ITdSk29rqg/6bh1jtx3qLPBcffRNNFAkrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SX6QJdeA4ZYry9Lthjbbuh1Dchq11i0h6bmele1kLgE=;
 b=imrHgLVLFPJKucb+HIwFzNQcV/P4o2sioMK1GhxITYifnUbLxgPpEUoqL6cMhPoR91838jPabTMv/nUtYibSbp+xOsUjoB+gqf9Cs7HK+ltD2nqNaR1hSS9pgqZL9+/lULj6FQfbWMHYPpJHVbjj/7KfaxAfXYfBYlSy7IS95BNOZ0Allw3w3p5JUWtrmduYjDmuLhu1t6J5RopN7I80PBfD0Z9xYe8FVlMufMNvJgHh+ILsJrjFsnpHMwpTZ2KgvxwSB8cXYliC6SsevL5J4shk+jcsMRZvk55G6vJP2mDECFWXRFMN7uaWl2h3vje9Yup+zr4UX4YvjwIupMJMjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by MN0PR11MB6229.namprd11.prod.outlook.com (2603:10b6:208:3c6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 00:45:14 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::6418:8391:dce:a06]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::6418:8391:dce:a06%5]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 00:45:14 +0000
Message-ID: <cc040c82-3c2d-f781-1168-4cb76d90d2e9@intel.com>
Date: Thu, 25 May 2023 08:45:07 +0800
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
 <8adea3c0-ca06-1dd0-366b-f7eba9be6890@intel.com>
 <fd8a711d-7940-c990-bbed-7c4d9a46a664@linaro.org>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <fd8a711d-7940-c990-bbed-7c4d9a46a664@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::34)
 To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|MN0PR11MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d9a1b6-8330-4ebd-5861-08db5cb94d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hguv+wnFCNM0pxrMgmE2lPemw6csYLLKdnmcBD2ldhCIBJL1BABjSvJvieFDKJIBsjykFf3lPl5vf8xOBY1GrK4gQL870PTEkv8oO1dNfGhlaCj11CXFtnqJqcOtkV0oDUbZ5urtHE7AmogjtLdQVEiA3xV96+RxbVzp6wballCWlFQ/W3fDkmORbSh4ZCfYlafQingE6znDHxi+unDUYaa+XCCsmWNpcNGggEOerHHJJ1cYyiRwkmkCZkkAXqRM7DpGuEFcinYkjUnF80vbhPmpVmRnSoh59ubPcjkde89nDOAGWMxNj015rvIlQO57NR+cm6lLOzsGa9VXuoB+caWSCGl1FVHewBkeqBNtCnsYtGTBNBkPLNjX1VCckcZUgiN7HxypPZB2wXwXh3RGCV5FkB/wwiUhcyMqxiqKlK4fntKIEnstkD7gD9X90eAPEIt2kSgluYoZsPdDBg7PygmzFbT3cqIO4RXUoLRAMsya3sddQ744yqTHsArg9P4G7unX5hTQsXz6esQSnnRqkptrNZN/0PZ9S2ZZp2oYTnmCGcYS8G4hJABusMLvm343+jdbb2W0FLAUttRi48OpqBtn6y00xumFwUTOPkF+s6PEy5ApDUy+QmCC7njP9EknRsecu5Ei3Tk2PUeO8adHDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199021)(83380400001)(54906003)(86362001)(478600001)(38100700002)(31696002)(2616005)(186003)(66946007)(66476007)(66556008)(31686004)(2906002)(26005)(6506007)(82960400001)(316002)(6666004)(6512007)(53546011)(4326008)(41300700001)(6486002)(8936002)(5660300002)(36756003)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3AzMlViWENNYktQU0FYa0U1cEFPUi8rSFpxTWhobVBDMFVtdTVJTmJFemJY?=
 =?utf-8?B?UFZsdmtRdEtGQ1A4NUNRVitSSk1uL2ZJSlA5Lzl5Skw2d0tCaGZ0WU83UGJn?=
 =?utf-8?B?UFBOS0pLT1ZqcFllQmY2K2hmNGJ1b2QzTUN0UkU4eDZZQXRHS1dqc2tFQk5F?=
 =?utf-8?B?K01FRGlkak9OWCtVRUxxaUZKbVhLWUJKRFdNUUlnUDBwN0czSTNWRlJXRk5T?=
 =?utf-8?B?T0VNSjBxT1VvODRDNUJKYTVlKzhKUGRsTDdyTWR6aE1KRU1XNEJmM003OGht?=
 =?utf-8?B?R0diMldqOEEyWmdhUkFXNExaU0FqTytzVzIwYU92dVhIMlVUc3VYL0RoR1Bi?=
 =?utf-8?B?RmNiNkljUDl1T2ZwR1JjaFh1d3VQVElXbGFjWjFmUFkxSjMrZDI4VHNYUkli?=
 =?utf-8?B?SHBvdTBRQVBmYU4rZ2g1ZHZuWXNlTi9pWFJPRTlESytZWVc1aTV2SnAvNUFC?=
 =?utf-8?B?WmdHSkNFSEhRMC9NZ1g3SnNSYkJOQlJSOUxwMDhDekszSmxXOTBKYy8zRGNw?=
 =?utf-8?B?OUluMEY1aVNxanVXWGhuallRNTUwN0cvMkFPejRibmFqT2RrMG9vTmw2elpa?=
 =?utf-8?B?RWVpNmJobHlXL1hibFdHTCtxZ2VISFp1eU9MMThtK29UWitoaUdxVDV1cGhk?=
 =?utf-8?B?WS8zbkJJWGlzQ0xQMWJiN0lON2ZLNU0wTWZWN0NqMDZscDVaZThPem9oYzZx?=
 =?utf-8?B?K29mc1Z4MDd2TlJFOVNDaENRUEQ0amluYUx0ZVBSdDFzRklONkVZcFVPUE5P?=
 =?utf-8?B?Mmo0aWRmM3B6c2l1N3BCWWk5b3M1U014WFdoWGdXL2N3eXBwNTBiaGh3R2dD?=
 =?utf-8?B?cXNrMTZtOUhFcjBkNS9uQUw2QnF1ZXY4c2RsUCs5ODRJcGEyMXBSejhzSytK?=
 =?utf-8?B?MnNpaXI0Sm9QOS9TS0xOSVJMT1FRa2hIdE43RmxROVZBWHk5T3AvWHFFNzMz?=
 =?utf-8?B?ZU5ua1oyN2c3cjl1NVFxbUM1aTF1SWJ4OXdIdERqSlRBUjh6WGhjbzBpeWNx?=
 =?utf-8?B?VkhFdHhidVNmTzlGWE40d3hIMi9odXJ6OG94UWpLNjhGTndrVkJzMFdPTjE5?=
 =?utf-8?B?UHBKbzRNMTkzanlPVU5CRElscnphbUgyMUhZcFBCWG56VGIvcWtMVVRLOGxu?=
 =?utf-8?B?TEpLb1IydkNiMGNnRWtOQ2gwKzc2REJFSmZLZUVxRE9SWjhETkxZK1BmZ1pO?=
 =?utf-8?B?c0dJMVZTUlN0dms2cWJIRW5EZkk2N2xodnZsMkR5OW53YzR1aVI4NmlPY21o?=
 =?utf-8?B?aEZVWnZndFRBZlZuOE1QUnlFL3EzZmYzckc1RjJtQjRzRkcxQmo0RWNiVGky?=
 =?utf-8?B?bGRkTUJpOHd5OFMyY3FqVG9LaGEyZ3hqMElGVDdLdjhGN3FzanZnc0pDdUNU?=
 =?utf-8?B?cnRmaElpUzhKajRQZlNHMnUwRnExQXE2KzdFR3BpcTAxL05VZzRkam9POElh?=
 =?utf-8?B?ZnkwZVo1cHZpRWsvNzFIZEVlRXArM080eGQ4ckVRZTlEUFZRZERvWGVXU2Zz?=
 =?utf-8?B?b1ZENXZZSkszcTRjSUE2RVBXQVlrREM1Yk45WjZHWHBOVUMvdmVQWEJFcXp3?=
 =?utf-8?B?VEVTZUhBN0xMWnY4Qld3MTZTV0NpanhLU3JMTlRQRG1aSVdpa0JjTm5qTmF0?=
 =?utf-8?B?ODkrbzJhU1NFb0swNURDdGNQQTdBVWxQUzdvSkJCM2tkenUyZkk3ZHJGd0Y3?=
 =?utf-8?B?RVk4cGdzVERzS1p2RzlRRDNLSXQ2RmpiR1lrV3pjb0U4SmZxYjN4Q05DUVNM?=
 =?utf-8?B?WkNMbVlLMnZlVERmUVE0a3JYT3B5disweXI1dDZqUURwSjVoTHFWZHN5OVFa?=
 =?utf-8?B?YkkxZExpMFVHWnB2V25yOVZrWU11dDRJVmZDcS9xWG10QVJlSVZnRVUvdi9U?=
 =?utf-8?B?L3pueTRnMG1Mc2x0b001aTNxOXpGejB3ekpPS3pvNmVQMERBZVVOWFZncDRR?=
 =?utf-8?B?SjB0b09QSXhnd09ReEVUaW51V01VS1c0L3lPRHRKd0l2MzFhNFNaaHV1emRP?=
 =?utf-8?B?dFlzMGVZbFBWVFBJVC9JemVKeHRwbjljUVNmZHZ6VVlPNkROWEs3V3g5SXY0?=
 =?utf-8?B?MEtLSVhwbWxIbGplYUR3NEFISm9YYTNkZVZuYUtLNEF4dHpYMElCQmNIL2ZM?=
 =?utf-8?Q?i27Ndf31Hoks0gAk78REuXj2l?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d9a1b6-8330-4ebd-5861-08db5cb94d93
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 00:45:14.6711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+1yf7mW5S18GISb+PtXP+tz6WMaUWXEbaQHhCHuhw59B8xy41X1IlbLrw4J5p8Z3rkoY7YNCzLvUGK3L9+Oig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6229
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65; envelope-from=fei2.wu@intel.com;
 helo=mga03.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 5/25/2023 1:02 AM, Richard Henderson wrote:
> On 5/24/23 06:35, Wu, Fei wrote:
>> On 5/23/2023 8:45 AM, Richard Henderson wrote:
>>> On 5/18/23 06:57, Fei Wu wrote:
>>>> +void HELPER(inc_exec_freq)(void *ptr)
>>>> +{
>>>> +    TBStatistics *stats = (TBStatistics *) ptr;
>>>> +    tcg_debug_assert(stats);
>>>> +    ++stats->executions.normal;
>>>> +}
>>> ...
>>>> +static inline void gen_tb_exec_count(TranslationBlock *tb)
>>>> +{
>>>> +    if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
>>>> +        TCGv_ptr ptr = tcg_temp_new_ptr();
>>>> +        tcg_gen_movi_ptr(ptr, (intptr_t)tb->tb_stats);
>>>> +        gen_helper_inc_exec_freq(ptr);
>>>> +    }
>>>> +}
>>>
>>> This is 3 host instructions, easily expanded inline:
>>>
>>> --- a/accel/tcg/translator.c
>>> +++ b/accel/tcg/translator.c
>>> @@ -11,6 +11,7 @@
>>>   #include "qemu/error-report.h"
>>>   #include "tcg/tcg.h"
>>>   #include "tcg/tcg-op.h"
>>> +#include "tcg/tcg-temp-internal.h"
>>>   #include "exec/exec-all.h"
>>>   #include "exec/gen-icount.h"
>>>   #include "exec/log.h"
>>> @@ -18,6 +19,30 @@
>>>   #include "exec/plugin-gen.h"
>>>   #include "exec/replay-core.h"
>>>
>>> +
>>> +static void gen_tb_exec_count(TranslationBlock *tb)
>>> +{
>>> +    if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
>>> +        TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
>>> +
>>> +        tcg_gen_movi_ptr(ptr,
>>> (intptr_t)&tb->tb_stats->executions.normal);
>>> +        if (sizeof(tb->tb_stats->executions.normal) == 4) {
>>> +            TCGv_i32 t = tcg_temp_ebb_new_i32();
>>> +            tcg_gen_ld_i32(t, ptr, 0);
>>> +            tcg_gen_addi_i32(t, t, 1);
>>> +            tcg_gen_st_i32(t, ptr, 0);
>>> +            tcg_temp_free_i32(t);
>>> +        } else {
>>> +            TCGv_i64 t = tcg_temp_ebb_new_i64();
>>> +            tcg_gen_ld_i64(t, ptr, 0);
>>> +            tcg_gen_addi_i64(t, t, 1);
>>> +            tcg_gen_st_i64(t, ptr, 0);
>>> +            tcg_temp_free_i64(t);
>>> +        }
>>> +        tcg_temp_free_ptr(ptr);
>>> +    }
>>> +}
>>> +
>>>   bool translator_use_goto_tb(DisasContextBase *db, target_ulong dest)
>>>   {
>>>       /* Suppress goto_tb if requested. */
>>>
>>>
>>> I'm not expecially keen on embedding the TBStatistics pointer directly
>>> like this; for most hosts we will have to put this constant into the
>>> constant pool.  Whereas the pointer already exists at tb->tb_stats, and
>>> tb is at a constant displacement prior to the code, so we already have
>>> mechanisms for generating pc-relative addresses.
>>>
>>> However, that's premature optimization.  Let's get it working first.
>>>
>> Richard, have you reviewed the whole series? I will integrate your
>> change to next version.
> 
> No, it's difficult to see what's going on.
> In your next revision, please remove CONFIG_PROFILER entirely first,
> which was what I was planning to do locally.
> 
OK, I will update it.

Thanks,
Fei.

> 
> r~


