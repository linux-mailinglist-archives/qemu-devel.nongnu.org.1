Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B10B37517C0
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 06:55:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJoKo-0006nZ-MM; Thu, 13 Jul 2023 00:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qJoKm-0006n8-Hh
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 00:53:44 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qJoKj-0006h7-AQ
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 00:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689224021; x=1720760021;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Kh/iEdwq0sqQzD7AnipW9ApjzHBZ29CZfMOzIieH7JA=;
 b=Xxr5VvMioshVIHDf2EoviWFky8PZeGA9TDl6wX++sTl5neP5/qvz5dY6
 4P8y3oGdF6jpoJWHPintzYie3+fyfGTv4SM4GV7PT9hdgqdB5GHt0RzsN
 UDfcA1LSrKt7wGQbY03N2XUX9EfwTvUYLatVNREubgMJeaPBCO7yGnm3F
 2dtBSriNx5hf8ViD6O94SKFtC3rYv9/7uUtY6mDV5vaEQOBRmaK7IbbSP
 KEgjtdTAnc3+nQK4xb7QJE78AJatS6TS8HcPxGfDGqTWsLo35T8rO6aYt
 YcclKbP5xwDr59v8MfRUaFz3XtevmsVCvmMydYsDf1PaAlVkyKMfIIKEl Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="431235298"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; d="scan'208";a="431235298"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 21:53:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="751458701"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; d="scan'208";a="751458701"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga008.jf.intel.com with ESMTP; 12 Jul 2023 21:53:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 21:53:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 21:53:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 21:53:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 21:53:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJYWOch8j1Xp4sitG3wZgbzcbh4tG/T0i8bqEDUWVsnze2hABd0RqkIhrIL+z4xTB7Xx7iSq8XO5zDTkMFQ6LZctcQmzNHx4AI9Lheu5/PwX+dPB8xFE02mTOb5RnN1ZY29mUES/iumDr9bCtxKcgbWprpCXn8FqP2zAOL3qgGfGGKSsKzUzraChdhnHRTte8LvqFm6yLwit5le94dKqfwrm6a8RnSKCnI8m+2SKYcm17LiOlPpiUND4tBFYqUild+nKoQyYJjanuGeYuujdvwdf0sG2grzoChMMCMFK6r5y76o3bN/bl8NkzX9XY/+4cKZWjY3TH8l5HbnVPoeRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hwq22GwbQsoISDtitgTLr+BQDl6fLiC3pgD4MAqnyfU=;
 b=PURB2X1oM/DG4vdCE9OF+WoDKvkrbku+/i0+qCXSJ0SS/x76Gp2cqP4/A62fjYAJ409qtN6NZ3+agbeJYoWoJNCK+blskA7JA6hpnD6KaHnc8Z+s3U9/inZCioLJvRzUzoM209Il81Zp1wdFFZlJqSTVsooM8LLfVOoyMmpmha1teaq6C+5pBG091kbRnA2ue5T2UGsEkC+cBShSxpd6xrzc/rJQqd9I1uF0CQhksJ2eumrSMGreKSkO0uHB0tLU3rJAKtfLrjtp3a6SBp4+/v2iyK3+O6L+xYMskDruV37OhxoIuIbTKQ/Q1m9ElxrkIYwFpN2wbC1G9waxvN3K9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by PH7PR11MB8599.namprd11.prod.outlook.com (2603:10b6:510:2ff::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 04:53:31 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::3af9:ac1d:49a4:8493]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::3af9:ac1d:49a4:8493%6]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 04:53:30 +0000
Message-ID: <dfcaf851-915e-d813-f72d-7fa94dec452a@intel.com>
Date: Wed, 12 Jul 2023 21:53:27 -0700
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
 <2d40fd7a-0f94-6aa1-32e6-3060d20dda33@intel.com>
 <87edldu16m.fsf@pond.sub.org>
Content-Language: en-US
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <87edldu16m.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::17) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|PH7PR11MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: cf72df28-2a22-422f-0afc-08db835d1a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDcMeJvcEdvAaTYorfRJG1SppARVEnL+ba3zSUf0oOm4vd9rFuHuuKdhGWk3njRaPYmfweE5IxUvl37j0iQiFd5SImMZhGb2NopsOaiowBE+PqRUtlRk4Z8tsIvESyyQMmve4BBEaL5Hoe9w2SCKUxgBE2tH60znU1H1QwBIpNIK9eFCBrlRfnGERBRLmU0HSbyEdbh/pQUaHrLrlYM45skE4SJeSnUox1XD8a8bUowKf1rwoC251gXCSvsZ5n3w5KcjXnrPVBiwVxVdgaKAEFvJOnym8cJnsjR4H+A0gibrn2c07dqoENcLP4TIHoEWOchCkN6MZa0ZU0bVohsjHubwwUV056lNqkpj8U759nSsoPxUSxiLomgztlRXBcEGbyNPLJH/ZBKjQLr5IIpD9r2NgnnxuNBLwG3oqmletAJzWuAEpa4SR/WuI7kp4CG+nVHMqioiu4wA69ta9sBC+ostjWBaoVBjXT6/dnJi3I9daq4knJ4AtrSMqqH12q3m83qJ43MkbFk5+jsAE63JD0UvXfdhL2RP70sj8Q0tgN6nN0Lv1UlRBROLBahAP9qgZq9URfabjMz2LWYY8pklOwRG+8lLdDVbAv65hl35LjjJqfnEuwioGyGle7mmTmaJ3PYKgThHZDS2ohDxbjBmsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(6916009)(66556008)(66946007)(66476007)(2906002)(316002)(4326008)(83380400001)(6512007)(41300700001)(5660300002)(36756003)(26005)(38100700002)(6506007)(8936002)(8676002)(31696002)(86362001)(6666004)(82960400001)(478600001)(53546011)(186003)(31686004)(2616005)(6486002)(107886003)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2VVaklrUHVHUnk4S0U2Sm5QY2FjWWFwaks4NkI4d2FEOEROSkl2Uk53NC9a?=
 =?utf-8?B?bFNPQ0hjRVNJWCtKM0JXamRGNllIdWlTVDlIZzJMcVRrakU2djNGdlBEcUk5?=
 =?utf-8?B?dHVLaXUrTG5vb05xdThoamNKLytPWDRZRjRNM2R0c1EyNkhreDBUTndSN2dr?=
 =?utf-8?B?dWo3YXdrYVUrWHVYN1BPZTgyLzhvSUIyVm9qZkhEMzNxdjhmSGw2TWY1VHlr?=
 =?utf-8?B?Sm1JSStDY1Rmd0FqNlJsa3NFSElBblY2RkxscUZCcCtXVGNWRkxoN0ZQeVkz?=
 =?utf-8?B?T3NzUXFZNlpOUjBkY1BhYlZma2g5NmZrVFpLMVpFaWt3a0NVNzV5d2FtbUtu?=
 =?utf-8?B?alFNWHdmQ3BKc2VVTzcwZ25kdkNQanBQTVV3RG5aNVoyYTlCMDFmZEZCdmwr?=
 =?utf-8?B?a1BsMEozbk45K0ZFZDZwMW1VYUpmOURvZ0ZHWVUrdWRPVGpxcWd4Q01zeXpS?=
 =?utf-8?B?SUs3RXZxa3FFaVlhVW5yZ3ZEUFloZVpaQ01tVHJuN1BQdUFUQUtPc3IwbUNJ?=
 =?utf-8?B?cHNrYmdORkVxTG5uMUcrRmhQSUNRRDh4Rm1pOTVjbS9qNnFUR1BvNHI5SkhE?=
 =?utf-8?B?MkkzSVdFOVVTNHo1ZXVNd0Q3bWtadW5aaWY3T2t5eWRPelZKcUIwQnJjRC80?=
 =?utf-8?B?VWpTYjgxMElYT1ZEMXArTWRzVGgzOXNNWWYzbWQ5SnFnRDB3MzBzeTdUWk01?=
 =?utf-8?B?SkFsM2k4QTBLQVZKZXZXSTFoZ3JSZXZWc0lMUTBFWGt0cGRsLzhZV2V6NVpk?=
 =?utf-8?B?a3NyaVVzRzB1L2MwOGRoa1M4dC8xR1JjaHJvNzJXZUsyWnBhRUhSWnJEdkhE?=
 =?utf-8?B?RzBzcThRaDlKalhabk9YdnRlaEowektzam1lZnJpWGtvSlRzOCtxcEs4YTc5?=
 =?utf-8?B?dTYvWWJrQ1hyU0FPWE85K0kwSlhEUTNHSlNaa28xdlBKVDB0V05wWkNQOUdR?=
 =?utf-8?B?S1hUdjBEdVRtbWRYNXRwK01sWnlXemhDY3N3eUJ3c2orK2dkeUZwWGFYZjEw?=
 =?utf-8?B?WW56L3htNW52TXJQcHpEZ0RBa0JvMGNvN3N4MFRNSTdSNVN6STNydHdqaTRK?=
 =?utf-8?B?cDgrdzFQOTgxakcyUUtEMTdXWksrS09QcGRENWVSMFpWcC9mdkJFakl6c1R6?=
 =?utf-8?B?M3MxaVVBdTVCNVFpZnlRemc2MUVoandUTFA0ZGVCRXNLbG1tdTNXT1ZXODVa?=
 =?utf-8?B?WmxCVE1CNU9neWFmclZhMkx2SFo3NElmWlJmNjBoK3lOWDBpa1MycTNWUWdC?=
 =?utf-8?B?M3c5MTJIcnMwZjU1RjV0UjJ3U2tlZnBibFcwUGpCbkZlQVp3NXpNVUNaTDR4?=
 =?utf-8?B?L0x5QkloY0Q5L2FDbkZMaGdLaFJhZ21leFprYXBOL0U1cGs2WVpoa0FLT0RN?=
 =?utf-8?B?MHJ6RGVvWGRyREhOeHlCQkJoYTR1amkwTDA3VFIxRFJOVDVkeURSdy9QN2U1?=
 =?utf-8?B?MlU0RlZQSVptenkzaGRQMTNxL05qZmo1Z1hqaHNiZWhSenpvMnVZUFNHRkNS?=
 =?utf-8?B?MGhBSWVhd1psMmNhcVBMcWVvRkVZdUxNNHNHT1ovaVg0ZDg2WlBUTkJsWHRy?=
 =?utf-8?B?MW51dnJhRW9Ia3lVMEJxWWc5OGQrNzg4WVBwd0dIZGp6Z25EbkZSdkp2Yk1G?=
 =?utf-8?B?VUl4OXV4SUV6WW9iSDY2aXZ4Zm9qVTZTL2NkTzFmNDZKYXBnOUV6R0ZpcEZ2?=
 =?utf-8?B?S3FGeXlqb0ptUGIxczBMaXhvVFl0b3RSejA4dlU3NGsxNTJSRWpiOHAxSEY0?=
 =?utf-8?B?Q25lUWl5SnRGb0hqaW1GUWtldjRiek9XODlnbkRvTW43ZVJaWmFiWm10Zkd3?=
 =?utf-8?B?RUxiZTM5NVhab2tuTDBxV1pQQ2xYTVl1b2ZXNkVoYU4rNGRKTkRzLytQcWdq?=
 =?utf-8?B?RTRLdFYyZ3g0b0lwYW9LKy8wTFllVEdTTTFXaGc5ZDkwQjNnUGd4dTJVd1g2?=
 =?utf-8?B?WHVGcEdPYjFSdDlzVllRTVFEZnFqNzdqem9iMWN4ejRJSDBGOEkrTGFKUnhY?=
 =?utf-8?B?MTNTNktSeXA5YlVsKzEzb3lLQUgwQ2s1bVFaSVlNU0N1T1oxMDVseU8vVTJi?=
 =?utf-8?B?ZzFEcUJzMFBXVVBRM2hYenNKZ0pUVGRzYUNiVVdXenJCVmw0cGhyKzNkaGIy?=
 =?utf-8?Q?h+K089rIu5qTLS1P4pyaU6cJH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf72df28-2a22-422f-0afc-08db835d1a89
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 04:53:30.4941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlCI/+p4SjZMUNwkYruJWvCD9zdmLnOQKfAYTdHWVbwpSBERrl7BYs74jdQBEeGRbBIQUji5Zf99VYyuavjZiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8599
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=dongwon.kim@intel.com; helo=mga07.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.11, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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


On 7/11/2023 10:52 PM, Markus Armbruster wrote:
> "Kim, Dongwon" <dongwon.kim@intel.com> writes:
>
>> On 7/10/2023 11:36 PM, Markus Armbruster wrote:
>>> "Kim, Dongwon" <dongwon.kim@intel.com> writes:
>>>
>>>> On 7/9/2023 11:05 PM, Markus Armbruster wrote:
>>>>> "Kim, Dongwon" <dongwon.kim@intel.com> writes:
>>>>>
>>>>>> On 7/7/2023 7:07 AM, Markus Armbruster wrote:
> [...]
>
>>>>>>> Old question not yet answered: Using a list for the mapping means the
>>>>>>> mapping must be dense, e.g. I can't map #0 and #2 but not #1.  Is this
>>>>>>> what we want?
>>>>>> No, it doesn't have to be dense. In your example, you can just leave the place for VC1 blank. For example, you could do connectors.0=DP-1,connectors.2=HDMI-1. But in this case, VC1 won't be activated and stay as disconnected from guest's perspective. I think this info is also needed in v2.
>>>>> Have you tried this?  I believe it'll fail with something like
>>>>> "Parameter 'connectors.1' missing".
>>>> Just tested it. Yeah you are correct. I think I had a bad assumption. Let me take a look to see if I can make it work as I assumed.
>>> If sparse mappings make sense, we should provide for them, I think.
>>>
>>> An array like '*connectors': ['str'] maps from integers 0, 1, ...  It
>>> can't do sparse (you can't omit integers in the middle).
>> Yeah, I understand this now. Despite of my initial intention was different, I am wondering if we don't allow the sparse mapping in this implementation. Any thought on that?
> Repeating myself: if sparse mappings make sense, we should provide for
> them, I think.
> So, do they make sense?  Or asked differently, could a user conceivably
> want to *not* place a VC?

It should be very rare. I can't think of any valid use case other than 
test cases for validating this feature. If VC is not mapped to anything 
from the beginning, there is no way to get it displayed. So there is no 
value to do so. So I assume provisioning a full list as a requirement 
would make sense here.

>> The V2 patch is with that change in the description. Another thing I think is to change QAPI design little bit to make it fill the element with null (0) if it's not given. Would this be a feasible option?
> A 'str' cannot be NULL.  In fact, no QAPI type can be null, except for
> 'null' (which is always NULL), alternates with a 'null' branch, and
> pointer-valued optionals (which are null when absent).
>
>>> Instead of omitting them, we could map them to null: '*connectors':
>>> ['StrOrNull'].  JSON input looks like [null, "HDMI-A-0"].  Since dotted
>>> key syntax does not support null at this time, you'd have to use JSON.
>>>
>>> Only an object can do sparse.  However, the QAPI schema language can't
>>> express "object where the keys are integers and the values are strings".
>>> We'd have to use 'any', and check everything manually.
>>>
>>> Hmm.  Thoughts?
>>>
>>>>>>> [...]

