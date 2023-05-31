Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF66C7172B9
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 02:48:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q49zg-0005bi-CK; Tue, 30 May 2023 20:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q49zd-0005bF-UU
 for qemu-devel@nongnu.org; Tue, 30 May 2023 20:47:13 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q49za-0007wP-RL
 for qemu-devel@nongnu.org; Tue, 30 May 2023 20:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685494030; x=1717030030;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dGXZ7oI75bqomKit7aTdT4RU2wN/1YzMK3m4TjOjApk=;
 b=BYMy5JQkQ5d2oMcM3S9cw5+ZBW3FESDGhCCYO2e61WJug3LU2d4YGd5k
 +iFlCCywLM2CUTk1ingzWtCBHr4oF6UMmfRsDjXh2BkUnfL2W7yHqAI9p
 JA73G+Qw3fAy9uIImL032244XxOx7oE8fEQuaX1Cux4dqu3O8Sl+6A9m2
 lGQ587Txf6Be0eNdFQVbZSB3RCArJz0mG0MGXC2ySW5nFYjmg6PuQt11T
 9Loahh4gloNhKeD6K2kU9PrwD7vaW7Bm6EEju6WMyg8qr56Bni1C2N1Rc
 rvni+tQ/ZPkHmpDVQI/TBxRHUHwXphrLIB0TFKR70d1zL9AD8oYpSVzF+ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="358348223"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="358348223"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 17:47:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="700866924"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="700866924"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga007.jf.intel.com with ESMTP; 30 May 2023 17:47:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 17:47:04 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 17:47:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 17:47:04 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 17:47:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jh5D38fDaylAL5tRoSV2C6yoPYRs6p1CGAfeVb3o6dPU0SVsojwUSnES29khFQPyvdxdj+mGg4agkDjECQlEhsACib0f19Rk8n3RInWNnu704cSRE5NMqbD3x1dEgr+erjVtTmqlKtKIXxpif6S36p7ERl+eIcGM+DVtbt0tq3PsNuu6wMEWSC51jflakmjgGpO91ckDX6E7sihl5udFX/WOGhvCrkaiIm+Yyu98bSQhm+q7jj1PalIN9XnQec0mm/StCpwMjM/BV2ZnYxz1AGeFl1/09GpMjA/wfZL72oz6cN8vgAhL8M0U5iutmhBzIIbFXxl/mpJlvZGEa2u/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GagAqjHHIY88So0m5+NkGE0Mz99sZQUIhE+6aCq7sI=;
 b=AWcENODTSM7hr7yg4N3MaYsBaQdD1nZmoNV/9vOtLQ+SVaL8/u8dKiUACDsoz+xj+bsb1v1zroEhXF7THm0o7s3W3SYbo9q1Xt3o9siaPO7dUJJXbAFVhiADcMJAOdkZpyLhN/duPuyXRjvxmwilBWNrkHkCyUlYrnqejQPPuC5oIkaDqHaU1X5f1p3WSBAAIfOuy78AWBHnpGyDX9XtSCxszFSraY81IUxXBSPH4p3hr2YAGE0jBd67YQHKQsV/xeR605KseP4B3mQ1JvLGXdW9Pvbpa/3KedsP6wnSd0Hl6vlomQTLApR5qaLqTLdZ6E5/pJzBqUG2BrzPB8p9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by IA1PR11MB7943.namprd11.prod.outlook.com (2603:10b6:208:3fc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 00:47:01 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::6660:3269:205:8c6]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::6660:3269:205:8c6%3]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 00:47:01 +0000
Message-ID: <db66436b-b42c-82f8-955b-6cba2bbce368@intel.com>
Date: Wed, 31 May 2023 08:46:51 +0800
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
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|IA1PR11MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: df0e6cb2-fbf9-42a9-99b7-08db61708b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LbGJ4GNJ1UTYsVxQkTyN9Yw4LO1wvkhLkVCevW+a+Gv7ZOwAAWwS8GYloI1UW94OrV72YNTWMVtodwbDSvGMW4jRXeDa99NcGDd7v+bjRDcro9tUvWruALV1BaGqtsM8vUEUgU9FZ1T/1BAu5SrJ6LoB7s7AqTNzTtTdtd5R3jpRQKt6bVNTCEhWHEVICyuWqONiKASdg1onOW7b3Ifwq28Q3z9rp+RKNFveU1CsReta2Wqk47UJpcuuTDoakWH2/dHD9O8xhstHJgnnDUywBcYGF235C4nnfOTvy0yusPyJTjRBrH9wB6nZH/7OuOabTj0UDlgAv3T5/fxHADtTI4kHG66zgjZ3bi8nHn4U8mM+4AVu0756yq8bXr9uh95T0leXmeKgTJbiU9SJWh2rlqeiHTDuk+ds0zfldA08KiuekYMwyRuo1duua/p5mPLo3trGaXgt6qjQT4A33RjgjsLL0SmtQA8RAq+9p7DHK9Hh3ID9AlSueATZDLa9AWRALJp16LtFqmhVFzk+//iCayWIFcQtXagAMGqiRn6aVwLUg+y6+KvlM8NH8R75fvlxZNieUpZin2+al6OxAzH8xdPl5fhAks7bLarAjIrAiMgkP31i8TaJHbNd/06Ktzw+QeuCh21O2ho4ROSE4CIxUWvAnJsQo1I7NDL/T6CLBQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199021)(186003)(26005)(53546011)(6506007)(6486002)(6512007)(316002)(6666004)(2906002)(5660300002)(41300700001)(36756003)(8676002)(8936002)(478600001)(82960400001)(38100700002)(31686004)(31696002)(54906003)(6916009)(4326008)(86362001)(66574015)(66946007)(83380400001)(2616005)(66556008)(66476007)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlpqUXBPQVAxcEZDN1BLYzR0bytqenBvRmk4OTh5cW9ZT3hPeFRLRmQ4d1JG?=
 =?utf-8?B?ZXFGT3hmRmh1ZUdjS1Rzc2JtNTFXTUlCeWFTS0RWTVNwZ3BGNGVyZjV6NTEx?=
 =?utf-8?B?b2ZxS3c0elFJQmFmK1NtM2JjdW1iYVZCc3FZdUxRNnQxZEd2amM3ejRzb25C?=
 =?utf-8?B?OUQrWEl4dUI1b0c1M0NyQ1FQd2dpMjdIbGlmeGVlczNJMFZwTk10R01pSTlz?=
 =?utf-8?B?RXJmYkFYY0YveUhnMExWUE43QjVDanRrYndlUlBodjFBcVJwVUxab0k4VTBs?=
 =?utf-8?B?ZWRiVkRnR0pXRDhVVG93bFliNWlWcSsvOFBvOEt0Myt3aCsrazRzbHhBTXFJ?=
 =?utf-8?B?cnNFUS9kdFNOZCtqVnd4RDRKdEFDOHFGTkU0OHpCc2hUc05CbGRVUzdZK3Zx?=
 =?utf-8?B?ODA2K3hPbjc3bkNPVHVudURlQkxxMnJlcVpTRElDdkFOUHBKRDJROEllRU9D?=
 =?utf-8?B?Uk1COGl0UkpuQWpVVktWYWtMSjN6QTB5VEZneS9HN0xwT2s4K1dpQi9LMDY1?=
 =?utf-8?B?Mmp4YnA4M0lhWGxReUdyWnpVRmwveDRneU50ZkFSUm5FRTNRNkc2a1g5cExZ?=
 =?utf-8?B?MHZ4dzhWTDhtbzcxZS9acjFTQVdkQUNJRUYwaE9QKzZVemxFU0xFRHVxRVo3?=
 =?utf-8?B?bEZSUit0ajFYZmxxWmRna0JqWmJSNTdUUTlwN1p3eHI2Y2VBUEtwbCtBUE95?=
 =?utf-8?B?Mjk5V0JrMTkyYi9LN3Bta09WV0ErRlZmWTJFVnpzRUlteVFaNmZTdmdqaE84?=
 =?utf-8?B?TkZuaXR4OHVFUC9OekVTcldOdnRJeFJPNGJPYUFqRDZ2b2pwUGMxLzBaMnN3?=
 =?utf-8?B?R1RqeVhjbEVKaHdJUjE0ajU3MnE3UGlwYVJRalpVOTVJMVlvVTg1RU5pZjFm?=
 =?utf-8?B?NXA0N0tmSW12YVg3ZU9XVUFoMVJlNFE0U1BZRWUvTXpMeTdxUE1ETUJrd082?=
 =?utf-8?B?TGt1TWdTdkdPVWM2blYzaEl6NzhKKzBMVlFvZ1JEV3lEZlA0bFArU1J5bWhs?=
 =?utf-8?B?Q1R4Z0ZwdHBnd0xtamRkZndLNzEvTEN1VVRPWXZWc1NKVHhab1A5QjlueDIx?=
 =?utf-8?B?WGcveExrbmVmc2ZQcE41SFMrdG5LZGQ5SUI4ZlpFSWU4UmRkUk4waDhMVFZ0?=
 =?utf-8?B?UWVQSkozKzJLc1huOVFxMVdUL2lnUFFsbUsxMDAwcEp6TFlyZ0l0MU9lU05N?=
 =?utf-8?B?cjRybS9DUmtJVVZRbVZDV0xBc3ZNQ1hnUmJMbXVxeVpyeGtZeEJxOTVCVUFP?=
 =?utf-8?B?aWFmYlVoUmhGOEUvMGduU3VZRERBZVV6Ym84dzZ0TnpQYWZod1N2SXRNSTB0?=
 =?utf-8?B?UllCQk1wdXZNcFhyU0JIM0g5c2lzdEJlNitWelBFbDRKcG13bzNPQ2F3N2lT?=
 =?utf-8?B?SmlWYitNVFFtZEtJcDNFdXJ6MXQ2ZTBGMEcybnRZcjh4d1VBY3pySGVmeDR5?=
 =?utf-8?B?Q1FzM0VJZUc5YXhCZktyamRmNFlaMUZGNVdERGlsMUJxajNnaW5nbklKeFM5?=
 =?utf-8?B?LzdQVWlPMHFDS1RIVjVYN1RMUDlmRmh3Ti8zZzBWd0FtSXJMbWRwVXVHbllq?=
 =?utf-8?B?SHltRGViQ2U0UFVmQnNKby9hTG8rNlRaZjVUalRXSzZhTUNFYTA1YW5HVnZz?=
 =?utf-8?B?dFpoaVFiN0QzeGNYVnVlcUQ0N1djVmVMNXdicVhsNjdETWdzZFpsaHdiV29s?=
 =?utf-8?B?S1F5ZDlJVWlXUEtsdHQ5ZFN1b2h1Tm1ZUkFpK0Z3RUs4R0JhWjdVUTRxcXJK?=
 =?utf-8?B?bFArd1p4TTVTYVBlbmdFdG5lQnZYV3ZFUHZxZlowYnpUbG1wM3hjS25hMDdK?=
 =?utf-8?B?dzAwVTBjZFNrYVN3TTJJdkgzNFdBRTQreVk0bGZORjlKRE5CSFF5bjc4bGYw?=
 =?utf-8?B?Q05WWnpMcUlqRHk5dFJLbTFwRmp2Z1VRc204ODZEQWxJYjlPL1FTTUZoWW4v?=
 =?utf-8?B?cnhwb3Mreld5d1M3MFp2ZFVmeXl0cmMzb0Ywd0ZrblFmMi9BUExYSzZlRUU0?=
 =?utf-8?B?UzF5SlhWZURnU1d4ZDE2SHVFalc0UHczYy9TOVdLV2dRcXdsT2M4aE9iODFX?=
 =?utf-8?B?MGREWFFqTmVMUEozMEtKM050bmNYK1pqV1dlYmd2M2YvTlhUbE9XZ0RLUmJl?=
 =?utf-8?Q?Ebv0pYNkqXbESS+MQfE88DrgO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df0e6cb2-fbf9-42a9-99b7-08db61708b57
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 00:47:00.7986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHX8w0rgUoFtop7gGat3ZdBM7TWjHK9oyVBBROU+Z2kgz1DY4Dxw018HDjWbEFd7jynwhrgKE67ZTfwUOQFO/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7943
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65; envelope-from=fei2.wu@intel.com;
 helo=mga03.intel.com
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
I haven't seen this before, but it may be different if we sort the TBs
by these times. Perhaps we can get some idea of some kinds of code takes
more time to optimize than others?

>> * table_op_count - it's indeed guarded by tb_stats_enabled, but it's a
>> large array, it might be too large to put into TBStaticstics.
> 
> Probably. This is probably more interesting information as an aggregate
> than per TB.
> 
Yes, I kept this here in v14.

Thanks,
Fei.

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


