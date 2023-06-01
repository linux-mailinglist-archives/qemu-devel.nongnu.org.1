Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3402C71924E
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 07:37:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4azo-0004UY-Jm; Thu, 01 Jun 2023 01:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4azU-0004Kj-Rm
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 01:36:56 -0400
Received: from mga02.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4azR-0005Nb-Cr
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 01:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685597809; x=1717133809;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TUwGiW1weYWxEfa5NBkIuMaf0gU6cfK8LaRCyJSl3IY=;
 b=e6PcqI8oSA/sYu79wBQZ70pFSJzaNVFQu/EQWuAA+wcQLIIHFjynjsmz
 qekyBvNaIN9sX9KQFaO749fWoOXAGskIV/E3cBYXlVcpa5lliWwMH1I1Y
 B0oMLngXNBsEtnES/nFO2y4Dc/sjx7U8tv23whLWy7t6cGdccTVb1oEXf
 +m0JYZVIxuAR0V8AJVZjDg4iYVwfU4O56pYm7svX08hBvfnTgtmQtV1hr
 +8+cf2/WlNOBImRpazEQX5gFs/Qq6m/fz9Ir8D6j0Vo7/zmela60D1d3u
 j8CWphAKxDHPkVBpYXN/Cp4hwFe7KrerAhLg+RnYdAMkyvvEu0ldKlSd+ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="344985549"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="344985549"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 22:36:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="796994212"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="796994212"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by FMSMGA003.fm.intel.com with ESMTP; 31 May 2023 22:36:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 22:36:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 22:36:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 22:36:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMN3IL91hupA2j4FDiX87+RWoKYZuyT7l7Hcoj5pYcUThuEW0z7luKdkGGK43Lp99qD8IE+Wa33+6musgDLsDCSakCGGwpOES4IqqKEyn/zQAq4aWzIcDJStNwNkmV4C0qVa99E3lX2eSePuVeCzuCPknB3mi1hoVj68NkeeS9YK44F5VxxVqKZWIv16k/gu/tdVWKeumkdxpRMS8nYyGKkBNyqRofJ4n8dH1xPlCACNMwxEQCz2WdjIVwI7c71UcLbbkj6sd1Pby2nFn4VtkkiXfHicXIaZD/tCKAdLT1AFlEwIk1AkWXGDCHW19igfdSvFs+Dkh2gqwCLawgQ2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msLFSP/5lY/VBglE4C8QZQ8LFBHRzZJa43WZNbpadFA=;
 b=klMN+Ar+ltrZ1GlYgBIClp6j3P67gjCJK2n9I4rJNhhfWPLSRhzp5qkg8hDyi5/DLV4kvDspX49MR0k28GKWzVj7eEXnSZefMUORNXbJI8ALE/bTtHwkEXvJHo4g8u6g5y0jVy5J/fgbdtQeuV0quDQAPZU365lA1RePGGeWkb4/kfNHQE0i+He6EC0fP1qbjraDiyqSOLVWwa6jLnoZls5GKiJUJQEe4ZLivEWHaIdgyFksO81vOrjSWKiMPY7iawd80GmDkddk4tw+/T2Bpkw+9iwtcegeRaEeMdwVKWdgcfYyoHg5QBsaITo3uiL5UnK2v7HZ4UbTE+AxB3yyPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by CY8PR11MB7242.namprd11.prod.outlook.com (2603:10b6:930:95::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 05:36:37 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 05:36:36 +0000
Message-ID: <a7dacff0-1c1f-9734-3a88-cd07bb646232@intel.com>
Date: Thu, 1 Jun 2023 13:36:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 02/10] accel/tcg: introduce TBStatistics structure
To: Richard Henderson <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>
CC: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-3-fei2.wu@intel.com>
 <b4859236-58eb-7709-235f-5096aeb9861f@linaro.org>
 <eb173080-68e6-df4b-f070-49315a09242c@intel.com>
 <62b50a3a-1e03-ef88-ed39-89cf61048122@linaro.org>
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <62b50a3a-1e03-ef88-ed39-89cf61048122@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0143.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::23) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|CY8PR11MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d60afa-9eaf-4970-acd2-08db62622aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NyX9rErhTBfsalI7hDWR5xABgHazgiQ1axhd3xu8jz7UJPjyFBp8CilymdBTNbxyDmSV++jgmShaFNkWH4zIncPOpyaHYMuRPo8ierYLGpyeEPbDicfl7DxMfL7784OtLBvxFLFzr76nqILzzqUVlUnYUjV+fdAw9H2Xi3b2a0M22SOwOx2mLBpNf6oxEGeJexGMtaJg5S3H3Y1tSj0nWc64SuYclEbUApD50p9zm73eqZ+FOIYcgPHSfQviwShvX8Xzs019EIMe1yIiszmFFAyB1i3NnlyZCea5Th0PHqpm7vRajhquPnPQ614gRdL4JJo7Dsm9fUvmBcTbq3jAzyFLAl+unlMYLSND8mvrfJ4Q46wDUiXXz43KYU5f+zRBOdF5o8NlLP0GjU2kos2c4+PogML2BRs99E4swu17X0K9nyJ4zaZtRkZtBQ5b+sFdqhT4PTO3j9TZxaYduTcrnuFed63fGh4F/rjOyM8PVBjSXegE0GHjwsEI4USgFGXVpFkLaz0I7Sh+97aDKjdtNDE/SKgpq8AtNhQDtYPlrTrd0wt3KrRGaWFgUPdaTEHvagxpyNcWmNfu6/Dyh7msw5I9oq1t5+ZPiWAFd79oWax1MAmJcT5Yqhm+TmqzvawYxomjFmfS1DBHqypy1fK/RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199021)(6486002)(86362001)(41300700001)(31696002)(478600001)(6666004)(66556008)(316002)(66476007)(4326008)(36756003)(66946007)(5660300002)(186003)(2906002)(6506007)(31686004)(26005)(53546011)(6512007)(83380400001)(54906003)(38100700002)(8676002)(8936002)(2616005)(82960400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHFxMHNUN3F0aXBac1VvTGJHVnNUK0wrU1lyeVFkVXFXY01Rdi9PODd6Smpw?=
 =?utf-8?B?SjhLUkVHWnc1VVUrWm9kOEx4Wmg3ZmpEekdpM0FqZkdheGprem80dDhQZXlV?=
 =?utf-8?B?TkVVcmlDNDllbFlKYVBscDFyM2E4eGpmOW1MNkxQY2FaVUVVdC9MTGZsWmRG?=
 =?utf-8?B?THBQVlkwcm45bWZtZy9OcU1wZHI5WlhDaTY5aDZteTdFVWw0dU84Q1N1bEc2?=
 =?utf-8?B?cnBnY3NONGxldWVHN1BkSUgrbHZ1emZ6ZXdyQUJWcmp1WkZpb1grV3hkMStu?=
 =?utf-8?B?a3hFQU1zSmUxeUNHUmphbnBaTS9ZRml4RWtNYzJMZ1dHQ2xWNUd2UTNyZWtX?=
 =?utf-8?B?eDdhc2JVcG5WTW5SNldsRFAvbFVHVDVMNm1HZWJwL1oyWlFWVGJjY2s2b05l?=
 =?utf-8?B?ZmJDemdJclJkVmNoMzVtS0o1cDNnZUZMY3BxZkV4U2svZFMxVlI3SUhtWXJR?=
 =?utf-8?B?YTlmOWtqN09FeHBub1dIZXdIanhqNHNOUDBFV3ZDWGRDYnJSNmtCSlh1S0F2?=
 =?utf-8?B?c2hrNklWV3Q0eG1Kbmhvdk9iYy9ZNytocVFRNGRJMTRyQ1ZYTUJDOHBKOWUw?=
 =?utf-8?B?aFpSMHdqZXFkNDhmMTVheDBKdW9LNXd4bWJsVjJLajVMK2VzaVhvek85cmdu?=
 =?utf-8?B?VHloU1o1SDFsMjFMSWhNQUFtWVJqd0dveDQvMW51U3AwblNUbnpTdHpEM1NP?=
 =?utf-8?B?aHZRcGpubEZWRHZ2N2VENXZZVElydGR0cGltU1JnT0phM2J5SnBOeVdsUWNz?=
 =?utf-8?B?cnBGNGNpODFGNUxRczkyNWIrVUxzVTZqUVhyMTFNZ0hZVU84VkJYODBLcDl5?=
 =?utf-8?B?K1dGNlRuaTh2bHVZVDRLM21JSU1lS1YxUGk5eHAza3hBNFQ1dVZQR1RJOHFv?=
 =?utf-8?B?R2VWS0hwS0dEUktVTDB5T1oyT01vRjhvbVN2ZTJCWVhtT2NhbDdXZm9sRnF2?=
 =?utf-8?B?UFpucVRhOXJML2trNDJSZW1XUEg0c2JDL3BlbnU3dmlmMzNxNm5wVTArTXBL?=
 =?utf-8?B?V2VQTmtVK3ZXem04c01talppYlIxeFR5QUxZY2R3blYvKzFBb3RFZFc3OW5n?=
 =?utf-8?B?M2VCU0tZZVl4OWo1SEZuZFBLSDRPd1JUMnhsTVhjbVVoRGVZd01mT0Qwa3lo?=
 =?utf-8?B?V09qQkJVQ1FRMjQ3KzArZ3Q0SG9kQTM0U2l2VStWQk9wNUtvMStxbGJDZW1q?=
 =?utf-8?B?K01WMnBPd2YrRVJIWTF3MThVc2xkZnp4V0VvVC9Pa1dHYUlNSDAzN1FvaUt3?=
 =?utf-8?B?T3ljN0JFQnRwNXdGZmVLazVyNy9tbTJ1T3NQcXpHZktIOU1saDNYSHJjc1Vq?=
 =?utf-8?B?RWcvQ25kKzE5NlFpZXl2K1l4WDA3ZThJVGZoc3NMdUtwY2JsV1RVazBGSVF4?=
 =?utf-8?B?YkZ2c2RRa01Ya04xelgwUitKMWFGKzBId1FueTZPYkgxQ3ZINFhuQlNYSnZI?=
 =?utf-8?B?M3ZmWUxEcnpQZkpUME1RbnpLK0ttK21BdjBWZDZ0aEhRbW5kN0lJVFpmN0NE?=
 =?utf-8?B?VW5nb0UwTE16ekM5SFVHS1BUb2gxZktTRkEzQytrRlZOYlQrcENwYUxVMDJh?=
 =?utf-8?B?SWtndEZ0a1lqVFBJSndBUkJWekp0aFh3S0lkZlFLK2VoZ09HeUMrK2tDUy9i?=
 =?utf-8?B?eStnUlViRXlJdXZndFFuTS91dGhUazFZdzZXQXFPT1AwZVhWNHlUdmlvZ3l2?=
 =?utf-8?B?eTRBZXE1czF2RnZJMzhXUXJocEpNUGUxbDBLOWtWWXMwR0F5K2ZQY2ZpdXNt?=
 =?utf-8?B?RHZ5bFNSaTFvcXJkdmkwMlNWVitiaHZsZS91SExWQ0UxSm1pY0pqVjRvdTNt?=
 =?utf-8?B?WWlFM2tDa3pKZ2FJbWtsUWtKN0dhMjBRcXhZL0h6bENaTXlWejcwekpTZnR4?=
 =?utf-8?B?RDU5L2pqQ0ZmdHp6RHdWTWR1WHA2RCtxelRyWVRMMjNlbW1WbG1QRE1UOWQw?=
 =?utf-8?B?OHNYU3lIMmNIODRVbm5RWGpKUUR2MWhUT3lFOXZHSHdBcWxVUFk4b2NCQTE3?=
 =?utf-8?B?MFdnL2F3aFBoSEFUbTBRYnBQRE1Jem16bGpHNFA1SUhyQXV2Q1FHOE9PclZy?=
 =?utf-8?B?QnBqb2p1byt3TWZ6bEhLNmhWMGdkM2JzM1hrU3hWckdJcEdpbTlVZVJMZ0JE?=
 =?utf-8?Q?lr6hpzCP/8c12nYrl4616+iul?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d60afa-9eaf-4970-acd2-08db62622aa8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 05:36:36.8205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1tyYADBxiyoTxWB0A3YyiEkDk/a5qZAmuSXSx+dv8uVzR56rt8/ZQIXnopcn36msAwpvxWrzU6G3/GVwNu2Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7242
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20; envelope-from=fei2.wu@intel.com;
 helo=mga02.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
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

On 6/1/2023 12:16 PM, Richard Henderson wrote:
> On 5/31/23 20:19, Wu, Fei wrote:
>> On 6/1/2023 8:01 AM, Richard Henderson wrote:
>>> On 5/30/23 01:35, Fei Wu wrote:
>>>> +/* TBStatistic collection controls */
>>>> +enum TBStatsStatus {
>>>> +    TB_STATS_DISABLED = 0,
>>>> +    TB_STATS_RUNNING,
>>>> +    TB_STATS_PAUSED,
>>>> +    TB_STATS_STOPPED
>>>> +};
>>>
>>> I don't see what PAUSED or STOPPED actually do.
>>> As far as I can see, stats are either being collected or not: a boolean.
>>>
>> If STOPPED, clean_tbstats() gets called, all the tbstats history is
>> destroyed, but it's not for PAUSED.
> 
> But it doesn't PAUSE everything either, since (1) code is built into
> each tb, and (2) each tb->tb_stats->stats_enabled neither changed. 
> Indeed, tb_stats_collection_enabled() is only checked in a fraction of
> the places stats are collected.
> 
tbs are always flushed at the end of hmp tb-stats cmd by tb_flush(),
stats_enabled can be changed e.g. during pause/filter cmd. It should be
a bug if stats are collected w/o tb_stats_collection_enabled().

Thanks,
Fei.
> 
> r~
> 


