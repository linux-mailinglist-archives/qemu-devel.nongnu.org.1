Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FE2A18AAF
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Jan 2025 04:30:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taRQT-0001RQ-UI; Tue, 21 Jan 2025 22:29:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1taRQQ-0001R4-87
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 22:29:06 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1taRQN-0005Rl-PZ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 22:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737516543; x=1769052543;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bz26lGt17b8pYwm+eVdj7eGGrJFWvtp435GjCrcX4Ew=;
 b=iC8N9FSsMZ1r6dXKPTnmFHCmGEKN0M29mCVkYQL/FFHuZkTi4TvH0WMT
 OOThgzJ5enbkgeI50TJDYaNWfCSmxUbDQfN63J2+mPIGcH2bfi2lxr9Gv
 LIIpT2VmWYQ7XHPE/8pbAMwnk1Y+fSaAemZm8Bu7Nx39do0bo/ksenS7j
 dNPXsPA7MiZ4qtMh6N5lGOiRWeCc5B7648F6eMzjdNWqa6z3qg+ZvW7ep
 c9N7bcJuLQUwetCorrs+N7CtJ3Hp/kF8eenVbPbZxI/FuXxZUtwAParFt
 JR74hGc7VBJH5o7DegiCgRF31qj3tnc+iJcLkhrA7ZSW3K+ysuRXfAmmX g==;
X-CSE-ConnectionGUID: QTrS438UQz6VSgDwKYx8lQ==
X-CSE-MsgGUID: k+PvtqrzRGOaJLpJh+TS0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="40774948"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; d="scan'208";a="40774948"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 19:28:59 -0800
X-CSE-ConnectionGUID: 2hcFwsKNT8SuXfGUw/pwhg==
X-CSE-MsgGUID: dh+iVZWATPu/J7Cs1I73Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; d="scan'208";a="107607196"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jan 2025 19:28:59 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 19:28:58 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 19:28:58 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 19:28:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwvQoqQl6vep0uX9OpCo4dWLUDvKuID+fAHBnjhc/ekce3NSaUJ+8gZDpbHkBsqQacuhFnvMAMPtTLhKr+I4xSNwYcjLdIA1LWKIOoPXKVc8P35Sin0UdysnuOh2S8QFghpgFWdDXoMmCtghSum7wEbFDG5TpUJkByly3MjFgZ2/9BKtNK4vYDVxH0UPLpQuq3Z29pz9C9MH5Qah/FOtNJ3qcf1vV3YaIgSIslZMX12RYiL6JU0nk6KTVVyQQ0feJCsWipJebPjvaB3TwoTTqw516LCqOPt6XnNHB5gC724SpfsoEc/3jeo6R3FP+2w4kpDcyeFVGn8YrfF2wGGe+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEpv2h6BYM43+FI+q/Z1377Rf4+nDd9TR8uUQlkmRV0=;
 b=p195HmPa/hK69auyE2XrHuj2YOZ/ds/s687uOv9/pUV69DJR2FLL53LNemv0SzZPiKQMSyOuqa6pSCbvxb1R/frD7JWIYkUr2dtxDfG+gE0cJ3poVdepoInM6nvB1E6dtpLUfj+zrUI9vnGmHqz0QUCwpSVAhMWdjI4EA6c0UcG8Jg1hRRvauomXO+eB5V52tJEYvObY7I8BklWRmqHwTpW0Y9Yay+tierlqqNwusd2wwbKUsNyAMZTHuPOlAO/up6bLx7g4ofdW1eXdmxO+ZWz/0A/6N8MAjCw0tFhL9tV6vTdjckHzhwXO8rSgsyfAl6Snun4v7/9w2tp4QO8LBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.20; Wed, 22 Jan 2025 03:28:56 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%5]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 03:28:56 +0000
Message-ID: <c5148428-9ebe-4659-953c-6c9d0eea1051@intel.com>
Date: Wed, 22 Jan 2025 11:28:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
To: Peter Xu <peterx@redhat.com>
CC: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Michael Roth <michael.roth@amd.com>,
 <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Williams Dan J
 <dan.j.williams@intel.com>, Peng Chao P <chao.p.peng@intel.com>, Gao Chao
 <chao.gao@intel.com>, Xu Yilun <yilun.xu@intel.com>, Xiaoyao Li
 <xiaoyao.li@intel.com>
References: <20241213070852.106092-3-chenyi.qiang@intel.com>
 <d0b30448-5061-4e35-97ba-2d360d77f150@amd.com>
 <80ac1338-a116-48f5-9874-72d42b5b65b4@intel.com>
 <9dfde186-e3af-40e3-b79f-ad4c71a4b911@redhat.com>
 <c1723a70-68d8-4211-85f1-d4538ef2d7f7@amd.com>
 <f3aaffe7-7045-4288-8675-349115a867ce@redhat.com> <Z46GIsAcXJTPQ8yN@x1n>
 <7e60d2d8-9ee9-4e97-8a45-bd35a3b7b2a2@redhat.com> <Z46W7Ltk-CWjmCEj@x1n>
 <8e144c26-b1f4-4156-b959-93dc19ab2984@intel.com> <Z4_MvGSq2B4zptGB@x1n>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <Z4_MvGSq2B4zptGB@x1n>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|PH8PR11MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: d12fc75f-b73f-405f-9ffa-08dd3a94e6b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkVLc2dHdmQ4K2xNZktZNS9SNTdGZEllU2tPaDdsekMvR2VtbzZYc2lYeC9r?=
 =?utf-8?B?N0tKczJWS1kzVnNXSzhuWVlrY0N1bnQ4ZllTR01pcjcvSFhlNkRSU0RqR1pY?=
 =?utf-8?B?UGpFelZTRExNSGk0WWpSYVM0SUU3SUx1S1p3WW1YWTRBZW9IM1VCQVVDZHNq?=
 =?utf-8?B?V1J3ZEhpa1orMFpIMlFxdm81YzZTRmhaWjRaMS8xYmhFd2hGOUl3V2ZvWm5a?=
 =?utf-8?B?M0tCVjRkeE1oMk9zbGJaUUcyZUQ3c0xzK3dxSVlmVTdqTjN3RVhyQVpvekh2?=
 =?utf-8?B?OE8xL0dTcUsrV3pYb0p5NWNIQklmNUN5WUNlZUFzQ0tvdGduTG9zcEVkWU8r?=
 =?utf-8?B?K2tTUU16MU5CR2pXY3FhcWRSckxZWisvaE80TmZFM1p6amhlK3h5bUVRcFd2?=
 =?utf-8?B?YlRRa0dqVjc1TUQ2citBQ2pmdG40cUVjLzFwcnBRdXhhZzNVdmJmcVZ2SmN6?=
 =?utf-8?B?WElvdElaUHlzNkM3eFJ2cTMyRkwxVUEwYVZ4WkJWdzRWY1BCK0gwbVhwUUJB?=
 =?utf-8?B?THpDNmZUMW00UHhSOEJXdC80aWlINTRzUUoxaTRDN2N4d1hBdmV5VE1xbFZ3?=
 =?utf-8?B?Vm1JK29FRUFpZTJZalJpVk1MT25DNEN2N2RiK2w0TzFIdjRWTFpHbzQrOVBO?=
 =?utf-8?B?clZuMWZ3bnNsWXhWSWtJWTc2SE5QRGtKZmJpWVo0RVU3YXBFa09hcjdidUNT?=
 =?utf-8?B?LzF6L09TUEZhSERlOUo3MW9tQWhlMnc3TkNVNnpNeTAvdTBwQ0FuZUJYNXV5?=
 =?utf-8?B?eTFqSm1XRklCc1MrTnMyS3NCOUZxdUl0aWFzc2tFV2tmSXp5c1RvMnBuZFVE?=
 =?utf-8?B?bGt3a0RpQkhQZ3VGT0thbzQ4ckQ0dG5kN25aTHdacVpNKzVnNlNBZ2Z5d3pW?=
 =?utf-8?B?NzhnV3Fyd2oyZFB6TWZJaEh6M2ZwTXJDMkpxb2VMY1duYmVTSEpqNWdlajZU?=
 =?utf-8?B?NHp0UUtXMHZ6UTRoN2hKVldsRG92SE5MeExaMzlPbWh0QS9ZOGtwWXNhcFdI?=
 =?utf-8?B?TXlxTDdldDFYTmw4YkVJWmVKL2Y0Njlldmd1bm9wRm1FTnhJYnJzNG9vRHRR?=
 =?utf-8?B?ckZVRk51Wlk1WWV1d2RSeXpLNlNOcU4vMkhVWnBNeHkzaTZ2WWpaUHdoY3Rk?=
 =?utf-8?B?VnV1cWZ2T3cySzhkNkFxdy9IYmhJWGUrbjF3Mm93R2oyNDF0a3BoUnNIV1lv?=
 =?utf-8?B?THlsZllDZUw5U3dSdnVkVktvZmZFUmFHVWJvL1Y0aXY2YzRlYkR0V1ZVbXJT?=
 =?utf-8?B?TnZWYUJyajA2a1R6UzBDY3JCeVR4eEJIMVVBNGtHNWhjMWVZTGRoS3pjaFFp?=
 =?utf-8?B?ZUJHQWJtR3JqMW9Jc0hwcXMxSE5EaWduMlBFcHJoNnduaFJFeHYwQXcvQmRQ?=
 =?utf-8?B?cWJMaWNsUis1SExhRGNudE8wb2NnVFl1dURtcVlHQklWdlpOTktCdUZrOTZP?=
 =?utf-8?B?QURZQjhieEJadGpTZWJVMDdoVVZ1N0srQ2o2ei9sKzJFY2MvUVhtSjlOcjg3?=
 =?utf-8?B?ZHFwUDgxSmE2TjNNV3FXK2JKRTBBa1FqMTV3WEUvRTdFc295a0E2L29xckIr?=
 =?utf-8?B?WTN4V0ZyOURJZTFLUDl6R3dzM2lSUmxnZFFDWXNBSXhqY25PMEY3VVZ0em9F?=
 =?utf-8?B?UVFUUFdPeGI4YzhOVTBoa1IrWWJzNERNLytLSlhnMWxNUkxFZkpUNGMxZXg5?=
 =?utf-8?B?ZG1vOGZHY0g2cDh1dlB4NU10WTBWK00xY1J5OG05UklpMWl5VmZRTHRObHI2?=
 =?utf-8?B?MTNwZUlRTHJUZ0FRWU5OUmxmbFkyUTB4NjlPMW5hZWtxN244ZEk1WnV3Ujho?=
 =?utf-8?B?dHVQb3d6N3V2cFZETFg2WCtTaDllMFlxRjJyL3gwR3dkSEpMN0Jlc3MvM1Jx?=
 =?utf-8?Q?gXuXkIP7Wjfqe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1JRRmxEaUg2SnhOWjF6eTNZQXJWbnNEVTBCQ1ZHbHFXenJVVDFxYjQ3NUli?=
 =?utf-8?B?RFIxNU4yOTR2Rm5NemkvVkxCWnlXb0Q4NEY5Z3M4bm5vLzl3aXp4algxbnFq?=
 =?utf-8?B?Q3FZZlF5MWVvV0FkQ0RCVm14R2M1UWdmNFRBMFdGTi9LdWszczl4UXVHc0Vj?=
 =?utf-8?B?ajJ1L3plVnJEU2YzNEs2bW1zd1dvZVQ3UW04cCtQdnR6MGFKWVkvMVhTMkNC?=
 =?utf-8?B?WlNibXY3bEk2VU1LUitwQWkrNWhjdVJwb1c1QnJNTm5zU013QUJzcXB1MDRu?=
 =?utf-8?B?T0RRTThLc2k4YmdjK0xnMFR4QXNpUGRpNHR1NG96VkF6enErempOU2xITmp4?=
 =?utf-8?B?ZWR6cCtmY1lNaWxuNTExRTU0eGd6Zk9qaUl5RU85OGlCZXAvc3l3UUl6anV2?=
 =?utf-8?B?RHpSdzNwV3o0VjAzQnFsUDVYenpvUzJWOVJGcGtIekdQR0wwV3dmSmxSMno4?=
 =?utf-8?B?a0xkMjlWaW45R2g2bDc1bEFkQVVVTnRhR3VnTVNpbDI4emtmRzVkZkJFQjRN?=
 =?utf-8?B?eUlLRVh6SmxHczliUHlZSSsvTllNQUlqaXpXdFZjQkp3Yzc4aHVCcURQclha?=
 =?utf-8?B?aDRWKzQ0ZUZacWJvK0RublRqaThFWXFncXluRUcvT2NHaitneVM1UWFJbmVG?=
 =?utf-8?B?M1RCbHB3Q3NrRHFxS1Q0WVVoM0pRODhFMGE0R0ZxZEt6Yll5MjhKbGFtTnhh?=
 =?utf-8?B?MDV4T2lyNnVIK0RNK242d01qbTFDZXhONXVLNHJ0ZUNGOVI2V0liZG1QMWtJ?=
 =?utf-8?B?OEwvNnFEeEliWmtWc3hnd3BEZnp1WnBYbmxySzhZejFlTENEaFU0VHF5Q1ZY?=
 =?utf-8?B?bnBGYVRhcnRCRm9kNE5pZzA5bkliRlg0akpUZjhFWVRKVHIwZGRINERjcDVi?=
 =?utf-8?B?VFhaQTV0UUpFbEFmV01FbXRId3lpTXBnT0hxbkE3TFVBMUhSZE1oQWppelFP?=
 =?utf-8?B?MzczUEVGQ1VQc2VSNU05L1drVjRzMk55V1VVWHRud3o2elMvZWJJWjVkWWhI?=
 =?utf-8?B?ZDUzYzE4T3dMdGV3Y2tHYmN1MUZTTmdPbFhrVEdLbmFYWVRvcFMwQzEwZ2Fv?=
 =?utf-8?B?cnZ0TkxDcitZU1NVeVZ0dzh2OWdvZjZMR3JNWXU1RzhNVVZEaDdZYmYrakdH?=
 =?utf-8?B?c2R6V20vVWVMeXdQdGxmcGdVQXBzd3UrSWtXZ0pGRjNTanMyNzR5cnA4ZHNX?=
 =?utf-8?B?cmMvblBxU2ZwaWJ2RWZMVzdnUjU1aGVEZ2lKQ3ZuRDlaUzk4ZWFkc1d4eElr?=
 =?utf-8?B?RERlTlU3c2JSWDAvMCtaaDdWWGswclpJN0RkMkE5eUp3N0tIMGF3dWlWY2cy?=
 =?utf-8?B?eTl4Mmd0YzFBWVdkd21vRFBHUVlzeFdKaVhvd0NmVUpOaVIyL3NNWmVMaVVT?=
 =?utf-8?B?dmZWV3pZMWtmQU4xWWUxQklSV2tkTDhQTmVBajBYcnVYVUFQWlU1ZSs5Z2Nh?=
 =?utf-8?B?MjYxcFpMZWFzendRcUdwQ3BNdGtWU050bXNpQ3RBZDh2YkxQaVNlT2JXR1Vk?=
 =?utf-8?B?QTF0NEJ5Qy9zQ1JkUjh1QkVaT2JiWWJNSml4aDBUck9OOXczS3FvRWtTalVh?=
 =?utf-8?B?elh5K3M5V1hPT014blBaQ1pkeWdXaFlxVmRCV3dmYjRHTk02Tlk2a2VEZzBE?=
 =?utf-8?B?NHFmVGVXVWxMMi9JRy9iRmliZ3E4TmVLdlJNd3NlMkM4OEpPaW5vYXJybSs5?=
 =?utf-8?B?Y3BsdDVRNkJYREZsb3dGbEFZTXBLUW5hajJWQnduMUkraHpFM3RFR3UwcTZl?=
 =?utf-8?B?d2dxOHI5Rm9rZU5VcExDajNOY1ppcEt6RXg4bFp1aUNLRjJ6SEpLVDJPSHFv?=
 =?utf-8?B?aHM1Nmd5VU1XeUQwL0ExNlhCWi8xNUhQS2tyakdsWXEyZmo4Z21LTE1HblBp?=
 =?utf-8?B?K3EyRWt3WEUxNk90NlY0RTRSNHlFaTRMdmxsRTROQktlVjkvVEtsSFNMVitS?=
 =?utf-8?B?eVdQWXdDWXMxOTJpa2p4QzhMRkE3UEVTOExIWWxMT05iUE54T2ltYjBKeGZS?=
 =?utf-8?B?U0hwRjE4Mms3cW1EMGQ0SUI5V3Q2alg3c2Q2dnJvZ0tXa0RncWJJZ0ZWTThm?=
 =?utf-8?B?SnhOL25CSXhIdko5clRiWGZBTUNpeHVkK2dodm5DSU1MaHpEcmVPaFRyL0l0?=
 =?utf-8?B?VmVWRDI2b25GMDJlSkwyemI2NUpCVGVpZVZXMUs0Qmw0Mkd1NnZncG1wdGFF?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d12fc75f-b73f-405f-9ffa-08dd3a94e6b8
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 03:28:56.0305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmrR6l3tZVIISu+fAcUxOLErmacCQZKdiNLR+o0wMwjxZeVvsnyW5cDlCHHUQdRPhMXzb9IFNBiv970aAHmDnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6682
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 1/22/2025 12:35 AM, Peter Xu wrote:
> On Tue, Jan 21, 2025 at 09:35:26AM +0800, Chenyi Qiang wrote:
>>
>>
>> On 1/21/2025 2:33 AM, Peter Xu wrote:
>>> On Mon, Jan 20, 2025 at 06:54:14PM +0100, David Hildenbrand wrote:
>>>> On 20.01.25 18:21, Peter Xu wrote:
>>>>> On Mon, Jan 20, 2025 at 11:48:39AM +0100, David Hildenbrand wrote:
>>>>>> Sorry, I was traveling end of last week. I wrote a mail on the train and
>>>>>> apparently it was swallowed somehow ...
>>>>>>
>>>>>>>> Not sure that's the right place. Isn't it the (cc) machine that controls
>>>>>>>> the state?
>>>>>>>
>>>>>>> KVM does, via MemoryRegion->RAMBlock->guest_memfd.
>>>>>>
>>>>>> Right; I consider KVM part of the machine.
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>> It's not really the memory backend, that's just the memory provider.
>>>>>>>
>>>>>>> Sorry but is not "providing memory" the purpose of "memory backend"? :)
>>>>>>
>>>>>> Hehe, what I wanted to say is that a memory backend is just something to
>>>>>> create a RAMBlock. There are different ways to create a RAMBlock, even
>>>>>> guest_memfd ones.
>>>>>>
>>>>>> guest_memfd is stored per RAMBlock. I assume the state should be stored per
>>>>>> RAMBlock as well, maybe as part of a "guest_memfd state" thing.
>>>>>>
>>>>>> Now, the question is, who is the manager?
>>>>>>
>>>>>> 1) The machine. KVM requests the machine to perform the transition, and the
>>>>>> machine takes care of updating the guest_memfd state and notifying any
>>>>>> listeners.
>>>>>>
>>>>>> 2) The RAMBlock. Then we need some other Object to trigger that. Maybe
>>>>>> RAMBlock would have to become an object, or we allocate separate objects.
>>>>>>
>>>>>> I'm leaning towards 1), but I might be missing something.
>>>>>
>>>>> A pure question: how do we process the bios gmemfds?  I assume they're
>>>>> shared when VM starts if QEMU needs to load the bios into it, but are they
>>>>> always shared, or can they be converted to private later?
>>>>
>>>> You're probably looking for memory_region_init_ram_guest_memfd().
>>>
>>> Yes, but I didn't see whether such gmemfd needs conversions there.  I saw
>>> an answer though from Chenyi in another email:
>>>
>>> https://lore.kernel.org/all/fc7194ee-ed21-4f6b-bf87-147a47f5f074@intel.com/
>>>
>>> So I suppose the BIOS region must support private / share conversions too,
>>> just like the rest part.
>>
>> Yes, the BIOS region can support conversion as well. I think guest_memfd
>> backed memory regions all follow the same sequence during setup time:
>>
>> guest_memfd is shared when the guest_memfd fd is created by
>> kvm_create_guest_memfd() in ram_block_add(), But it will sooner be
>> converted to private just after kvm_set_user_memory_region() in
>> kvm_set_phys_mem(). So at the boot time of cc VM, the default attribute
>> is private. During runtime, the vBIOS can also do the conversion if it
>> wants.
> 
> I see.
> 
>>
>>>
>>> Though in that case, I'm not 100% sure whether that could also be done by
>>> reusing the major guest memfd with some specific offset regions.
>>
>> Not sure if I understand you clearly. guest_memfd is per-Ramblock. It
>> will have its own slot. So the vBIOS can use its own guest_memfd to get
>> the specific offset regions.
> 
> Sorry to be confusing, please feel free to ignore my previous comment.
> That came from a very limited mindset that maybe one confidential VM should
> only have one gmemfd..
> 
> Now I see it looks like it's by design open to multiple gmemfds for each
> VM, then it's definitely ok that bios has its own.
> 
> Do you know why the bios needs to be convertable?  I wonder whether the VM
> can copy it over to a private region and do whatever it wants, e.g.  attest
> the bios being valid.  However this is also more of a pure question.. and
> it can be offtopic to this series, so feel free to ignore.

AFAIK, the vBIOS won't do conversion after it is set as private at the
beginning. But in theory, the VM can do the conversion at runtime with
current implementation. As for why make the vBIOS convertable, I'm also
uncertain about it. Maybe convenient for managing the private/shared
status by guest_memfd as it's also converted once at the beginning.

> 
> Thanks,
> 


