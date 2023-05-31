Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2884717385
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 04:10:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4BGk-0006MV-2p; Tue, 30 May 2023 22:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4BGh-0006MI-Uv
 for qemu-devel@nongnu.org; Tue, 30 May 2023 22:08:55 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4BGf-0003q0-D4
 for qemu-devel@nongnu.org; Tue, 30 May 2023 22:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685498933; x=1717034933;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kAsOu2ul1U8KuwVCri+wxZt/zSwzHeUwOCC4wQ+ICSo=;
 b=ZLK4ZYwrkU0mFLd/1GYcLxvrCkP7m3kvrr+6NoihhgwBITmB2SIixLMj
 bDjlhHU8YCopn1Kq6jNpN7dXgjkR1VZRTYwAotMfIRO8cg+64iVcUkhf1
 edqpRAIWFMSdMEJv5ClG5qhta+79phR4MNrUDz+qhQihKlZEK5l+J4/da
 Us7ktjCRZ/mmz2htAGOHt/+T3xu2w1Ca0urVyaOsgmmC7YmUqyGj9p1S8
 nwOmlUDyQBocXVll8GXNp8P7QMHvi74lB/hQMm+qAb51rJ1m5ISVeeLBt
 ZTnExGYF4RgAJp5Oj1AEwrtYeA4UBwMnJz72sXqOQ7lgaEGOdUYZCK5Sg g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="353950814"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="353950814"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 19:06:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="709861504"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="709861504"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga007.fm.intel.com with ESMTP; 30 May 2023 19:06:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 19:06:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 19:06:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 19:06:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrqSVurO+Yyn6oSgn4xg+Komb8mIscIIlHEHTS/Pi/r90wupJU4yX6jPJ/Yg2EO8taUB8L83TVl3MtknVs+Aanmel5RPmSLf5/g0cw/vH0BXpiv/C/G44PaJuTlE4Nim7uGV1TzXbUMVJTf2jrYMgGzznGRx7+tjkYmDPvov2GmYyycFgTF3So0+wIvQhLEVCAZv4EAphVmIZ0zfzleds0yuePGMeDAFBeVUdc9qC/vnJpylxgo6rrM8lhCPGqVCO7Znn7Ah7lMpL6XXiBjuXSBEzi85IzmhlXKsR8w1Ev4Bep/glllGBktcvfaBQWIiqHagSjcmvH8wdramn8xmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mg8tP4s+7AxsTYW681rTr/WpQNX+0OD4erdIGxsQ2kY=;
 b=ULCi1YDNdNiqmB+nM91Xv5FVHOqO1vMvEHv+4KTwz5t0bkeXaS5QFFm0H0BSa2LzUgNKMkZjIKyZwU/eTXK077rs2EvA3+z8YqaJ0Jm6M/2Ozt9c6SMXVzJPOs+Ft1jwWj6iIfWJ2yHDshmf6MHLWnBVkxVrQA9uDMld9U53d8wwshuL1juJzUlxJColto5BCVLukoMVNDGSjufKANPsGYGBdtCx/oNZd6RoSI34MM0yZu1mgv/1hgM6GmUjyAll4N9Gf8qpdzLXWxZ40kKuw4wB5MqiOUFixdZImTPOiVTSxZh+aR56ysH/4ourUvg9Pk8A8H+Niyn7EDjPxuj7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by SA1PR11MB5945.namprd11.prod.outlook.com (2603:10b6:806:239::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 02:06:05 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::6660:3269:205:8c6]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::6660:3269:205:8c6%3]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 02:06:04 +0000
Message-ID: <ec09d167-18af-9170-3d35-2d55fa6112d8@intel.com>
Date: Wed, 31 May 2023 10:05:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 04/10] accel/tcg: add jit stats and time to
 TBStatistics
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
CC: Richard Henderson <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>, 
 "Vanderson M . do Rosario" <vandersonmr2@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230529114947.2123652-1-fei2.wu@intel.com>
 <20230529114947.2123652-5-fei2.wu@intel.com>
 <98196efc-213f-3351-1564-5008ccd90f36@linaro.org>
 <ddc552ba-c95d-4b31-01d2-a6d70a978f1c@intel.com>
 <a6a88248-4142-baa6-dc86-b6d471477384@intel.com> <87cz2idt3m.fsf@linaro.org>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <87cz2idt3m.fsf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|SA1PR11MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: bb34f50e-f78d-4199-4490-08db617b96ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZaZP8OYkc64Jmo3/TSlVEmUsLXxakS0bTClvULyUEVHzxIZmVha1P7Z4h0oTmUkO/KYNkHtgjAKmPCTepfOhAqT41sYIo7SuDVfmox5i1xQYOW3+ZReEOeJ0UItJWOEncvapNJYP02SoANMTMKxQkEqFa/Famdo9ljbYNz41OE7U51UiP1s9vHg4z4LFhoLkzFGIeSbWHKMBHQwQgbOsfoLXCiZAIf0/GRpC1iq0fVL21+2LthQZiPDIHCoEMz4v26ODMvAHEctRzLhXPrK9tpsLwGhL5r5aoU44rmq3LtZ/7zQCmd/nVO4N1twHIr5veCvEJTSar6XOGU0W/jsD+MVD8+M9ytKymhoLqjrj8NF+R1AvySxmTO8GZdQniZOtex+VjCvVakOcD4WOZIWgY58uD9JrMyIiZ1slz318yiFCWy8wq6MsfMCUT4UA6gOt9tp7QgHfTsnQmMkuIg/iy3RZBmGp1qJJ4rCEFcaz9lDhsVtC9HKf6gcWrncAhXgz+a16Sr2EuETt43ULKYE+/02TmyqTKVYyaBdRjpUWUUaf7lXoWBnh9fviGLa7087KsvLd0wjt/mQCi0w5gpGV2Swv+S6+fkxYIuAmEeHNpVl7AGnwE7VgypXn5Nx/Y9vSXNCVoy07OiKJOdZ+0w4DdzLu46n6WHwhc4tri37V4L/LL1jHr8B/BBjYkndtfl2965keRLvlH43v0yhcoC77kEd/QTvTk1YQTaPTDYEi9Ko=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199021)(6916009)(5660300002)(66946007)(66556008)(66476007)(316002)(6666004)(4326008)(31686004)(8936002)(8676002)(54906003)(6512007)(478600001)(53546011)(41300700001)(6486002)(186003)(26005)(6506007)(2616005)(2906002)(83380400001)(66574015)(38100700002)(82960400001)(31696002)(86362001)(36756003)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2FhcmdBMFZTWTI0WGtoSXpmTm5VcTJuNkd6cXdLQWFRSHVWQTBLcVVzYzdu?=
 =?utf-8?B?SDRETmIzdnFQaDRzbVBzY2xVTmorSlJSSjd5UW1NcGViejZ0MmVHTDUrdkZL?=
 =?utf-8?B?NHVhWUZuMG5LeDlZWGI4bzNQb0QyWTBEUDF1alZxNHVwNGQ3MS9XSkVORzZO?=
 =?utf-8?B?d3VVTDJWRCtNRUkvRTNSd1MyUDdDWnNJWUFuVnJKZ3F2MmtVeTUrQ3doRjVw?=
 =?utf-8?B?emE0UEhPU3FLM3paeWhpT0xZbWdqenNpN3E5ZlYwN015Wi93bVJoNmFZOFYr?=
 =?utf-8?B?WjNzWGFTNHNQakNPdHh3ODVMaVhqVy81MkMzdUorV0paRU05NklBdEhpRDBX?=
 =?utf-8?B?SVB5L1lFTVFQcytoMDk1OEVHNDFRVVFnb21jSEpmUlBDRGZhYWQ3L00vTkor?=
 =?utf-8?B?cjNtVFV6MmVJWENjeWQ0d28rOVlKaWZYYnVWUXYzTDF3cGpLK2lSSVlzSXpX?=
 =?utf-8?B?WHFTT0NvNXhJQUZ3Z1NEcGZWTmRMWitZdVV2WWN1QXUzL1JJYXJZU3hRNnNU?=
 =?utf-8?B?VHFFMnhpQnBGbWlVQllQVTBVbE1OSVgvZkhqY2czd091NHVDcXhpUGVoYkRI?=
 =?utf-8?B?ZkF4c1htMGUvY3BKVXVCUmNmL0w2SE5TZkpHcE9NVFVXV0dWYWlUYitQN3Fr?=
 =?utf-8?B?bWs0SytUNHdkRVJmN2dNdWtZMU5CQWlpYjVsNDcyTVVNV1p3UGdlMTRTRFAw?=
 =?utf-8?B?a3dMSTc3cWdHYURFUDM5L2o1VHA4ZHZnVVZJdG5HYXNjZnQ5TVdZa0U3Sk43?=
 =?utf-8?B?TjlTRGtDcVNYOUI3S2RPVWtta05EU3FlQklUQ1dFUWhlUzlxTVJnNVEzS1Ny?=
 =?utf-8?B?S2pLMVZBTUtJdjkxTVBCVzdLOGtuU1RVVngydVFsMEtTc2pkMHZIaC9ENVFM?=
 =?utf-8?B?eGtrWHdtM1hUK2dRblZuUWpVcS9jUDlSSzRHWkJDNFJOZ1ZNaW45MlBXT0FB?=
 =?utf-8?B?R3R3eWc4cnQrRlNEY1QybW5pSW1XRVBSZHlsZ2ZvaW9ML3RxN3c1NTlWOVBL?=
 =?utf-8?B?cjNkSnQwa3o5UmUwT2RpVDRJL3ppdHRUKzlwRmovV3lPaER4WTNSQnhNU1pN?=
 =?utf-8?B?RVIvZDdzRUhPTmpzL2RkNCs3aEhpV3dEVU8weCt1QUZZOTRlTHJtcnAweEcz?=
 =?utf-8?B?emR3RklyNmhPeFNidC9lRmxiakkyR2RLNmpBMEo0LzRTTU93K0F2anpQclVr?=
 =?utf-8?B?VVp3YXRPUG5FTVY1b0ZNeWQvM2syZlNCSENnSFcvRFF4QkRPWGFsYmtTdHY3?=
 =?utf-8?B?bThjc09MZTJJZzdYYzlydTB6QThSKzVneE1GRWhBaEw3NUptRXBLZnVsYm5D?=
 =?utf-8?B?cG53b1QwYUExR2FtejUwVFgvQ05wY2RMRXRFRXVOTkNsM2pkTkZsanpDajZ5?=
 =?utf-8?B?eWIwbDAwUFpzTVMzNCt1YlFHaWNrdjYydE1BQ3llMnRGd0pwa3Q0Z1RPb0Nu?=
 =?utf-8?B?ZFJtZ1JMaTMrT3dUNG9PdGxrOGJaZkZCRWM1ZGg1OXJWSjVBUVVITUlJUEpV?=
 =?utf-8?B?VEZDMm1ReUcwTzM5a1YrRDRKbm84N3c4R2p4dFJPK2pFZkpGVTF5ZytadkMz?=
 =?utf-8?B?cjBvenQwTHZ6SEtOQ0Vvek9IYjhBMEcrV3c0aU1VQkNSSG8rRWhoQWtMMSsv?=
 =?utf-8?B?c2w3YkIzMER0NTFiTjJaRnpYYzVZdFJEUjVYWUJEdE5DZUFIQjZtQzgxdWw0?=
 =?utf-8?B?aDk0ZDNrM1pkb2YrK0ZPc2F0S3lsV2M1aW5SMGxkN2d1MFNzWW5qUzVRQXNr?=
 =?utf-8?B?RUtmbFRpMldYc2ZuR2VkUjVTMG50Rm9ObElUbmx2VXJBcE1ncFk1ZklsVjJW?=
 =?utf-8?B?bWxoK1Q1ckZNaytGb2hMNkFLSTR5eHZNQm5DNnlTbFI5bThNMWRJcEZBblVI?=
 =?utf-8?B?SFh2bGV6bTZjWFhEUEExMmJHeU5qcWgwNmU2WEQ5eGNaMndjWjI2b2N5QW1k?=
 =?utf-8?B?OUdRaG56SFpKcjdJbUNMaDFUWWU2L3BMNVdhaTNoTjl0My9rMnFxVXlOUS9B?=
 =?utf-8?B?RkZQWkUyWjlLbEZzTWxYQ2plc1p6K2g4QlJnQzBmbU9ZTFczVzdlVU4zNkFh?=
 =?utf-8?B?a2thRStTcmgxYmkxU1NRcXEwaWMxTjh2dU0ybDRaNy82cEJGb0FBbXRTaGlD?=
 =?utf-8?Q?deGeYLdCB9dsOVuHo19lq1XJp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb34f50e-f78d-4199-4490-08db617b96ff
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 02:06:04.8592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcjXvGATCbReiPnFeWBKEWOqjkBGskbeB+q9M5zVwFkczalLXcRmm3OmQDTLi1zGVuOe94+DIHnP0XQfNton7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5945
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120; envelope-from=fei2.wu@intel.com;
 helo=mga04.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 5/30/2023 6:08 PM, Alex Bennée wrote:
> 
> "Wu, Fei" <fei2.wu@intel.com> writes:
> 
>> On 5/30/2023 1:01 PM, Wu, Fei wrote:
>>> On 5/30/2023 12:07 PM, Richard Henderson wrote:
>>>> On 5/29/23 04:49, Fei Wu wrote:
>>>>> +/*
>>>>> + * The TCGProfile structure holds data for analysing the quality of
>>>>> + * the code generation. The data is split between stuff that is valid
>>>>> + * for the lifetime of a single translation and things that are valid
>>>>> + * for the lifetime of the translator. As the former is reset for each
>>>>> + * new translation so it should be copied elsewhere if you want to
>>>>> + * keep it.
>>>>> + *
>>>>> + * The structure is safe to access within the context of translation
>>>>> + * but accessing the data from elsewhere should be done with safe
>>>>> + * work.
>>>>> + */
> <snip>
>>>>> +    int64_t cpu_exec_time;
>>>>> +    int64_t op_count; /* total insn count */
>>>>> +    int64_t code_in_len;
>>>>> +    int64_t code_out_len;
>>>>> +    int64_t search_out_len;
>>>>> +
>>>>> +    /* Timestamps during translation  */
>>>>> +    uint64_t gen_start_time;
>>>>> +    uint64_t gen_ir_done_time;
>>>>> +    uint64_t gen_opt_done_time;
>>>>> +    uint64_t gen_la_done_time;
>>>>> +    uint64_t gen_code_done_time;
>>>>> +
>>>>> +    /* Lifetime count of TCGOps per TCGContext */
>>>>> +    uint64_t table_op_count[NB_OPS];
>>>>> +} TCGProfile;
>>>>> +
>>>>
>>>> Why have you added this back?
>>>>
>>>> The whole point of removing CONFIG_PROFILE to begin was to have all new
>>>> code.  Not to remove it then reintroduce it unchanged.
>>>>
>>>> In tcg_gen_code, you have access to the TranslationBlock as s->gen_tb. 
>>>> There is zero point to accumulating into TCGProfile, when you could be
>>>> accumulating into TCGStatistics directly.
>>>>
>>> TCGProfile contains global wide (per TCGContext) stats, but TBStatistics
>>> is TB specific, some info in TCGProfile such as table_op_count is not
>>> able to be summed up from TBStatistics. The per-translation stats in
>>> TCGProfile may be removed indeed.
>>>
>> After some cleanup locally, these are the remains in TCGProfile:
>> * cpu_exec_time - which is not guarded by tb_stats_enabled, it could be
>> moved out as an individual variable?
>> * gen_xxx_time - which in kinda global variables across functions to
>> calc ts->gen_times
> 
> Given the work on JIT profiling I think there is an argument to drop the
> time profile bits and pieces. I think you can get the same information
> from a perf run although it does amortise the cost of generation over
> all translations. Do we see any particular TBs that are particularly
> expensive to translate by more than a standard deviation?
> 
I added some code locally to sort by ir/code, (opt & la are not printed
in 'info tb-list').

(qemu) info tb-list 2 ir
(qemu) TB id:1 | phys:0x2abe14 virt:0xffffffff800abe14 flags:0x01024001
0 inv/1
        | exec:99079/0 guest inst cov:0.03%
        | trans:1 ints: g:6 op:24 op_opt:21 spills:0
        | h/g (host bytes / guest insts): 20.000000
        | time to gen at 2.4GHz => code:840.00(ns) IR:75274.58(ns)

TB id:2 | phys:0x24cf94 virt:0xffffffff8004cf94 flags:0x01024001 0 inv/3
        | exec:99085/0 guest inst cov:0.53%
        | trans:3 ints: g:31 op:86 op_opt:74 spills:0
        | h/g (host bytes / guest insts): 42.322582
        | time to gen at 2.4GHz => code:10011.25(ns) IR:118656.25(ns)

(qemu) info tb-list 2 ir
(qemu) TB id:1 | phys:0x24cf94 virt:0xffffffff8004cf94 flags:0x01024001
0 inv/3
        | exec:131259/0 guest inst cov:0.59%
        | trans:3 ints: g:31 op:86 op_opt:74 spills:0
        | h/g (host bytes / guest insts): 42.322582
        | time to gen at 2.4GHz => code:10011.25(ns) IR:118656.25(ns)

TB id:2 | phys:0x2abe14 virt:0xffffffff800abe14 flags:0x01024001 1 inv/3
        | exec:131541/0 guest inst cov:0.11%
        | trans:3 ints: g:6 op:24 op_opt:21 spills:0
        | h/g (host bytes / guest insts): 20.000000
        | time to gen at 2.4GHz => code:4411.25(ns) IR:88288.33(ns)

(qemu) info tb 2
(qemu)
------------------------------

TB id:2 | phys:0x2abe14 virt:0xffffffff800abe14 flags:0x01024001 1 inv/3
        | exec:668754/0 guest inst cov:0.16%
        | trans:3 ints: g:6 op:24 op_opt:21 spills:0
        | h/g (host bytes / guest insts): 20.000000
        | time to gen at 2.4GHz => code:4411.25(ns) IR:88288.33(ns)

----------------
IN:
Priv: 1; Virt: 0

0xffffffff800abe14:  864a              mv                      a2,s2
0xffffffff800abe16:  85ce              mv                      a1,s3
0xffffffff800abe18:  8526              mv                      a0,s1
0xffffffff800abe1a:  46bd              addi                    a3,zero,15
0xffffffff800abe1c:  fffff097          auipc                   ra,-4096
              # 0xffffffff800aae1c
0xffffffff800abe20:  cc0080e7          jalr                    ra,ra,-832
------------------------------

Look at the tb with phys:0x2abe14, although the first time IR takes
75274ns, but in the second command we can see it takes much less time
(Note IR time is accumulated).

So if the time for the same TB is not consistent, and the deviation
could be dominated by system events such as memory allocation instead of
codegen itself (?), I think it's less useful.

Alex, regarding dropping time profile, do you mean remove TB_JIT_TIME
completely?

Thanks,
Fei.

>> * table_op_count - it's indeed guarded by tb_stats_enabled, but it's a
>> large array, it might be too large to put into TBStaticstics.
> 
> Probably. This is probably more interesting information as an aggregate
> than per TB.
> 
>>
>> Thanks,
>> Fei.
>>
>>> Thanks,
>>> Fei.
>>>
>>>>
>>>> r~
>>>
> 
> 


