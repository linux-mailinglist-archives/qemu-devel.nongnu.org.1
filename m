Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A1E715571
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 08:18:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3sfB-0006Q6-NR; Tue, 30 May 2023 02:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q3sf1-0006Os-FP
 for qemu-devel@nongnu.org; Tue, 30 May 2023 02:16:48 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q3sez-0005bO-Da
 for qemu-devel@nongnu.org; Tue, 30 May 2023 02:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685427405; x=1716963405;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=68tn1mLgilPVvgrx4Q+0GAUXniP8s2VKp9mQ3lMHMLs=;
 b=h9NJaW18mUvcylAn5rHMy4fbW8OcTKLy2+e+X/8D2mbYpAV8AE2Q617v
 ppdeNXozfcN70wP3DdK/KVhi7uHMbLyzjOyCfHDsVjCYTaLx7dI3m1ZUR
 XyOOuE01CJWT8BUGQHUJMNC6DXecf7K8C42Bh4+iyIFKcb4b2fnnRNPqx
 s8c0L/01RHIDOxgVQ9Zyak7vpnKDBO6YDOW8NEhsu4yGrr4BpTU8RSh6h
 9pr7UH2R+hndUx2SFU0tU4UiMQ6aefoYW1TFe76o1BUCW4qSTNidWaA+1
 vEpe1jaIEUpbHaFT6R6Xq1qG41DBkbLdF50jDnPLvDoR1chQH1wEKqLPO g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="353671251"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="353671251"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 23:16:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="700489286"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="700489286"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga007.jf.intel.com with ESMTP; 29 May 2023 23:16:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 29 May 2023 23:16:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 29 May 2023 23:16:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 29 May 2023 23:16:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 29 May 2023 23:16:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtGcvroGJythGwLIN/gGpf1Xrf29OEzlP44k0a/4hYEvpW5x5wRu7hHeDiNGhbvOBh+T3KztFX1nFN6rAnnsd5pamBXGOA6RoXa+m8y+YX3YbJ1X/OSD1CQ3W7fQmGekpNccuIkFdG8Xp6zFHoZ9IHQvz9IdAGk+IzBCA+N1N9qneTp1mP9QeHHzl/Bb1c1GBxS3lHuJnqxgHLQKuB4oZX68AdhXXmW4IYlLQeE0bZQ9V8C5iawnKNeBZ1TTo/qDlE5q08nI0OuybWS4q2UP+rWB0PWRqeUBeLS+JW8bi+PxJ98ApV7nAMt1we9EKUxkgU5s4/sEFjBfN3jUCYBHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9014bcGAyKCG2AJ0LnwUZd+ws3pIX7FBC/X2eUcoZo=;
 b=UFfZcP3AaZGnIxpKlXuykeEnc7j4QdsdpVwteYaxSBbW1Nyxjcwr1JB7Fxu0lhkwEeHI5elFt6qyOV7gIwPqs+XAk56s0pVS12/K0yWfkq7QZtN3dGTqTPjEbG9S4hfT/x2tR0UQgncINFP7FrRZoZUD24nbHN8NVQgRN3z64haI7CdFj4Qlvts07MQCAt+7KFcpkgYOITv6ykbie9JUwPHj8oDxOuvh2iGa9hhKYmqPXMioWGr9ETOdc98ZF6LWnaDbx/BP9e0eLIe6aPJ/2QILo8V1k4WLzNDSiqdqp0WyETnVEYrMwQxRdiTWvyUMVPTuAPFi9ebjT+V9Du9rKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by PH8PR11MB8014.namprd11.prod.outlook.com (2603:10b6:510:23a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 06:16:21 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::6660:3269:205:8c6]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::6660:3269:205:8c6%3]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 06:16:21 +0000
Message-ID: <a6a88248-4142-baa6-dc86-b6d471477384@intel.com>
Date: Tue, 30 May 2023 14:16:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 04/10] accel/tcg: add jit stats and time to
 TBStatistics
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>
CC: "Vanderson M . do Rosario" <vandersonmr2@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230529114947.2123652-1-fei2.wu@intel.com>
 <20230529114947.2123652-5-fei2.wu@intel.com>
 <98196efc-213f-3351-1564-5008ccd90f36@linaro.org>
 <ddc552ba-c95d-4b31-01d2-a6d70a978f1c@intel.com>
In-Reply-To: <ddc552ba-c95d-4b31-01d2-a6d70a978f1c@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0147.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::27) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|PH8PR11MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 905265ad-8d64-40c4-7f6d-08db60d5631a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LBEAh1oPjT11fzVPjzCxdCVbVuHsugNYFfh1EjkkjlWJoku7MptfONfbMxQbJqxvGQA0bm6e8wPZ9jD4OTx/xmI/ZYx1p8mLeWBZS37Nr1hwFDxfB0lb3S0MtitHdPbwbZAvVZWBPpPYHuEIw5slYa1D8krshZh/GbA8BDw7yOAxAELFqOsLZm/VsLvr6XOQNeR2f1st6xH3Sf2r8DCt1srsjckYdVqSE25JrLzLRsbH8lCYyHNDC8ecNgjUI0dO32Z71ICk3F0/9TyCDeNroUMyzUUF5KZrNHYeWu8OVGuCCttJfXuXxM4sA1zeKpXyxa9nAmJR55Q6CReuA+0h1sb9GKcmsCeJASVTeBGHMqMGEBIr7lxLp2miZ1+VzgSpb6UcxLUOipjbt3749O0onSujE64sJDTxN2xANottzO8sCtu6fhDHFAKJ/EHWl7uDRSwOhKUsULd5e3JyGcpPj1Mgp3qPpDOAeLbFBSr2PnWb4b2dxrXIbYVsKEJFlmrlkBNsV3MiBc/ytFMa3a2Bg2qL5nChCBVgQ/8VEmAffvzyF8A3Uh4Ie44LH2fG81sreQdR7eD6qUqDmmofTqueiYi+A1aWou2MjqZpqem+mjf4tejcmO/00q8xM55GYzFgRMwCrTYEZAybf9LXqLozX2r0ak1o7h7LmDq41ANNZ5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199021)(8676002)(31696002)(6486002)(86362001)(41300700001)(4326008)(6666004)(316002)(66556008)(66476007)(66946007)(36756003)(5660300002)(186003)(2906002)(8936002)(31686004)(53546011)(6512007)(6506007)(2616005)(26005)(83380400001)(38100700002)(478600001)(54906003)(82960400001)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlEyY1dXQjViWjdUWUtZOFVHY0JJY0NaRnpKd0R0QzBPeUxrdHJoUW5hbHhU?=
 =?utf-8?B?MG5xdUI4OFZVTzBIZmdxdDE3YzFHMTdBek5wRFN6REZBRXBFU256ZGR1MFd2?=
 =?utf-8?B?VVlaa1lpZEd4WTRCaVl4d3UrOXkyS1M0NmF0VnBPVGhpVVd4Uk92V1B4cjdi?=
 =?utf-8?B?Wk4zSkx6RDU1NElQOXF1MHpDQ0pMSlE1aVRmbmRrQlB3Y25YQVBiTDNoL1BQ?=
 =?utf-8?B?bGVpQzBlcHphTXFLWEVEZkFKM0VNalY5amxTT1EyR1JJdEJtcWhYWEsrcEEv?=
 =?utf-8?B?UHZPSUNXTUpjYUlXK1dobkVacUozaHpqRG5aRVU3MFppd1pEelEzTDNEREUy?=
 =?utf-8?B?bTR0c0Z5WGV6RGl6bDN5K01BMnAzai9aalZpejZIbXA3YVB0eVFsRFNXMndW?=
 =?utf-8?B?b21ONHNHRUpxOGxnK1ZLM2swa2FxSm9DVHhHRnV3MnExQ2ZjSnNQTXJBQVVY?=
 =?utf-8?B?MDRWQ09vU01SVElPZ0NlOHhzRFZyRVdVdk43bW1UK1dHZEIvQS9ia2xBYUFt?=
 =?utf-8?B?b0E3SHgvTG5wUW5iMTErdFJyN0tnRm9vclFEYkp5NnVadFlpOHl1M2o2aTlR?=
 =?utf-8?B?enJWRjNBdWFGeEpJQS82NGNPc2ErMXkyc0w4OHo1UTR3WTNRdGVlL1c1cjBN?=
 =?utf-8?B?RU4zbVJHWCt6N1U3eElTbU95NU5iVTdOZ212c0d0cEY0NnNmcFpHa0VHQ0k3?=
 =?utf-8?B?czhuUWpSUHdTWjNkZGcydGdUdzZjemt0N1lFRDZzdktsUXpjSGRrUXZvSG1N?=
 =?utf-8?B?Q0hqK2FMT2lOQlFGMml3YmZWV2ExNmpJMkVyTmh1WDh4cFY4a3BoYTJBblhP?=
 =?utf-8?B?VnQ5KzBLU3lmdHJ6Rm9QcVJVcVZqZDdpRW5HbWVVcXlqbHV1eFI5a05LeHhK?=
 =?utf-8?B?ZTQ3QkxWZnhYdkZIT3E3V0ZXRnFFNGlmb3NOZmc0Qnk2eXU0a1hjelpkYXJh?=
 =?utf-8?B?Z01YSDloSGx6YVBiTFhjU2NrMTEyc3h2NTBIdHN4UTV2SUZRbmEvaEJaNlFQ?=
 =?utf-8?B?YVROOCt1OU5mSmxTeTRBbXVScFd5UUNxY1MzMVlURnNmTUE1a25wZ2RsMWZs?=
 =?utf-8?B?R3pXMmN5dXg4OHI5VmdJZjg5c3pmVEhZL3FtVjB5QmVVUmRxa01HRUQ4Q2NT?=
 =?utf-8?B?VnM5U3VHSlVSUk9VNlhjZzhGV0VKNDVZc05iSlhnck5McVJWV3JnVER3b0Mw?=
 =?utf-8?B?aEZkeFY4b2xVejd5dFdDUWdZbWVydi9md3JkbkdVQ0x5UFJ5YTFBd3M5Tklj?=
 =?utf-8?B?Z1o2R1N2TTFxRG91NTlMS1B0RHJTckM1QU14NFJSVmhTd2FKS3ZsektvbnFD?=
 =?utf-8?B?Uk0zV2NqUmI0RUoyRXNITy82MDFXYmh0SlRlZkoxV2VsWlZPN1hRTmxBT3pD?=
 =?utf-8?B?Vnc4Y2xCY05yZk93QkY2VUFGK0dITG04WDI1cW5IdzFFUmlUNlhYVStPUG85?=
 =?utf-8?B?TnhkK2FqcnpKQSs1cDRXb09ZZWpvdzhRbWJVaWErN2o5YklUSk9ZeTBGejZ1?=
 =?utf-8?B?Y2diNmNaYVdLSnJ4VWE3ZmZKVkl4YWEzKzgyWnVqSk10Sld3c1BIWU1zblFi?=
 =?utf-8?B?bGI4eWxxdHo3K3FDZmVIOUVod0xaVVREbUI4SHZMNVJSWmI0VHJuY3JlSTE3?=
 =?utf-8?B?UmRjYVRtMzlvb0JqMHMzSWx0cmpGZXF5QldnSWNVckd2Tk0wRkxidEpDLzVU?=
 =?utf-8?B?V25OKzBzSndKZ2M3eVRKT3owQ1dHKzR1QXhvYUVqaS9wUUc2ampXZDF4RUF5?=
 =?utf-8?B?SVIyclUyUmZDMkJHY3hycGRBTERFbnpLbE91Wk0zSHdkalN6MUViUU9heW9V?=
 =?utf-8?B?c3hFUmhvMnBUQ1dna0dsaHhLRi9oMDRrOWM5NmozZFgzdGRZdDB2Q2pHVkNj?=
 =?utf-8?B?WU5jK29ZR0ZpNkZRREtmdi9SaFpxeUpWTEs1OXpZWlNWaVc5ZFRxdGo3TE9t?=
 =?utf-8?B?V3JzZG4yQ1o0YkQ2OFFiaW1EaXFMRWgwa0VmZFl6bklFclFKeVRrblRJSWFH?=
 =?utf-8?B?dHpubmwvMlhNY2p1SGVQTlJnTkNzN3dYbG5uRXpPSzhTT2NxTEliWVBQR2dY?=
 =?utf-8?B?RzlBc0NSNHlRVUNvZzRybVhjcU55Ny9RWjd0WWhpSElmQzc2aFhzaVl0MVdO?=
 =?utf-8?Q?B06Q4DiivvqOSGNtbJz3JY52t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 905265ad-8d64-40c4-7f6d-08db60d5631a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 06:16:21.3524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jinfzzR/b8BwU/P7MvxwTkCCOSz+h+6PcQHDxEa3fnAMOW6rRAmliSSBaLMZ4SpR95bYnCV8l2X+C6YbaQgROQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8014
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120; envelope-from=fei2.wu@intel.com;
 helo=mga04.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
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

On 5/30/2023 1:01 PM, Wu, Fei wrote:
> On 5/30/2023 12:07 PM, Richard Henderson wrote:
>> On 5/29/23 04:49, Fei Wu wrote:
>>> +/*
>>> + * The TCGProfile structure holds data for analysing the quality of
>>> + * the code generation. The data is split between stuff that is valid
>>> + * for the lifetime of a single translation and things that are valid
>>> + * for the lifetime of the translator. As the former is reset for each
>>> + * new translation so it should be copied elsewhere if you want to
>>> + * keep it.
>>> + *
>>> + * The structure is safe to access within the context of translation
>>> + * but accessing the data from elsewhere should be done with safe
>>> + * work.
>>> + */
>>> +typedef struct TCGProfile {
>>> +
>>> +    struct {
>>> +        int nb_guest_insns;
>>> +        int nb_spills;
>>> +        int nb_ops_pre_opt;
>>> +
>>> +        int del_op_count;
>>> +        int temp_count;
>>> +    } translation;
>>> +
>>> +    int64_t cpu_exec_time;
>>> +    int64_t op_count; /* total insn count */
>>> +    int64_t code_in_len;
>>> +    int64_t code_out_len;
>>> +    int64_t search_out_len;
>>> +
>>> +    /* Timestamps during translation  */
>>> +    uint64_t gen_start_time;
>>> +    uint64_t gen_ir_done_time;
>>> +    uint64_t gen_opt_done_time;
>>> +    uint64_t gen_la_done_time;
>>> +    uint64_t gen_code_done_time;
>>> +
>>> +    /* Lifetime count of TCGOps per TCGContext */
>>> +    uint64_t table_op_count[NB_OPS];
>>> +} TCGProfile;
>>> +
>>
>> Why have you added this back?
>>
>> The whole point of removing CONFIG_PROFILE to begin was to have all new
>> code.  Not to remove it then reintroduce it unchanged.
>>
>> In tcg_gen_code, you have access to the TranslationBlock as s->gen_tb. 
>> There is zero point to accumulating into TCGProfile, when you could be
>> accumulating into TCGStatistics directly.
>>
> TCGProfile contains global wide (per TCGContext) stats, but TBStatistics
> is TB specific, some info in TCGProfile such as table_op_count is not
> able to be summed up from TBStatistics. The per-translation stats in
> TCGProfile may be removed indeed.
> 
After some cleanup locally, these are the remains in TCGProfile:
* cpu_exec_time - which is not guarded by tb_stats_enabled, it could be
moved out as an individual variable?
* gen_xxx_time - which in kinda global variables across functions to
calc ts->gen_times
* table_op_count - it's indeed guarded by tb_stats_enabled, but it's a
large array, it might be too large to put into TBStaticstics.

Thanks,
Fei.

> Thanks,
> Fei.
> 
>>
>> r~
> 


