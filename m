Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A82740323
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 20:24:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEDL4-0001mf-GG; Tue, 27 Jun 2023 14:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qEDL1-0001lf-P5
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 14:22:52 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qEDKy-0008O0-QE
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 14:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687890168; x=1719426168;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jfeO8nXdTGXs2SGRKFAv3cdXRdzGlr5wP4MjmsQ7XNw=;
 b=minQm/YAgfOodPgxT7RLiuAMbfLO4WDYnbN4fc8PbxVFwEWp1qsyiPE4
 uHAeaD5g4g1kkUA5d7b2NO9Z5Z3HHnWzuqb4ekNfuqSMPyMmUbsXY4RqG
 HSyThs2Nzkh+wMuJrpImZGYl6QQiy5qfBP/GWCAH3UzSFNYaOXKPzc1kp
 xI4Z4794DP2f2CPkwICYwbQHNv5SkAzGpn21jOQph8MOC8IhrKDkHqdkm
 k3q7ECtXqxhhHcPbcFJF4xuS+lvB6mBeJFHMtOxFAz9mHQSqzXt5BTk4U
 ouHid6YjiA1s/crS4dXav1gJY4MWM5YxOfDp0X8xmVjTK3HQ3bKyPC4Qi A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="359148365"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; d="scan'208";a="359148365"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2023 11:22:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="806603467"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; d="scan'208";a="806603467"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by FMSMGA003.fm.intel.com with ESMTP; 27 Jun 2023 11:22:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 11:22:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 11:22:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 11:22:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U64s446fq2YiDG6GMx3PdVk4t4i2XRCi3DkqwA5Hun/c2Il3Dgl14NmLpDoyO73VnCXg0rIZwyREzVcohed1HO9fjEK7JVU8L4Ewfbr8eWLnewkyl3pCGPISCaRYQiV5bThzKckFqLZisGnnkSxgiC01hYBzglxzqotz1qr0yseod6WQE43LarQvfPBM5NQP2z6IVjVYHXI0g8bNh1Ahxm8Spa2A2tJryiFcC7yEkWYqGvcUhcCOEX2TcHk5r3zpot6+4UErlKH2DUAN7+GjSbf6Wnvw74/gFaXySpd7sbq+pWxYuhtbjivwJoNldzENus3fSjLUXJI1vvKHXe5hpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MCDK+CLD4gTpbNLa5RfAR3c/Dbaj1mT/s6K+U/ZyBY=;
 b=DYNf9ufNY2JDLtDPLApBcRoatzWKXgOBLZaH6e4FZw0/qXx5OQ5NTDXyefzvjB0A0L5XejBUtksH8yb+YR2ead+s9YDl1+/hA67gJ77o9OOSoeq3bh+1G9GFgLqu+vB0IMFiHv/xBuGpA5ANTbFamM08+SkhJ05+OJ1cuiTu/svCgZfiGfN+jHLEFeqdHTgYbYgl8DPJ4+poaLX5MTJm74ryPvBhSLvegfao1eMhhrEaLyP/Wl5YQgRck7kAkjvEySgLFBvhCq+9tLV3LH9Pi5q4bQI7CAgrZR6tDkJHgtLP45UjIAMVLT9jgnIq4EqvnCfOuvWzKWC0BFF0SbadOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by DS7PR11MB7952.namprd11.prod.outlook.com (2603:10b6:8:eb::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Tue, 27 Jun 2023 18:22:36 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::b33c:de68:eacf:e9c4]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::b33c:de68:eacf:e9c4%3]) with mapi id 15.20.6500.036; Tue, 27 Jun 2023
 18:22:36 +0000
Message-ID: <46dc1ac2-2ab5-48f7-73da-4160c26c3171@intel.com>
Date: Tue, 27 Jun 2023 11:22:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 6/9] ui/gtk: Add a new parameter to assign
 connectors/monitors to GFX VCs
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <kraxel@redhat.com>, <berrange@redhat.com>,
 <philmd@linaro.org>, <marcandre.lureau@redhat.com>,
 <vivek.kasireddy@intel.com>
References: <20230621004355.19920-1-dongwon.kim@intel.com>
 <20230621004355.19920-7-dongwon.kim@intel.com> <87h6r1mkhc.fsf@pond.sub.org>
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <87h6r1mkhc.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:a03:338::29) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|DS7PR11MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 80fb4542-cb5d-4568-1af4-08db773b7b1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nam9yP6qYOtNoSvFqyl/KBetvQ+G9EqlP4OnuCQkNuA2yCiQnWnzI0/tv7wdao9mzkp7a3pLrICHy9EANbKF5qnPE1zSRCV/XK1E9nh9IYOF64DVFbnz9aWEm1xVRgcqlpr5J5/KwuhRgIgwbyaAzhPm45tLkcQKQF4ab1owpWlxOOj6Odzz9MxMmNUfe7gwH6HzxtboCQiXjJ2pmGZBhRsPN20mL2hgKA/Ug0jyyeo2zbKzcwvlPMvwPwmQDsmaEIhPuJPWMsSNB6MbZ4VJ1YdtjJuItkNWOBBoPtZqclWHhAeqzvEARfKzafe6DOOmpuT3D3wP9eFtuURvrHKFrevS3ZCwbeFVpmWb7vKkr2/A1isW9Cz2tAKMoPbqFmnnp+PiPBUR5AUeyNB9X4opDBlS1SzMNBh4+9viOzX0RC1x49pormDWU+RRbBE2ljim2yV3apNh0LpG0UZqflXtNu1ZOmengL9Y/Numha1fApUEFeIsHPILbeQkGy0mGI9MHiHzwHjaiU3jln7ztGyHuvFc/laA+p3VK4C5Bq7yRryBdjFHJR2f6DzeatkBCZuFNoDh2e4xv8UuIkkqKNoMIl98uRNxQloEBp5qHPRLote8ZS866WLJBgSGmeh7oApsof0UtWhmL2CUTKvV0EWy3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(66556008)(66476007)(107886003)(6506007)(36756003)(6666004)(478600001)(2616005)(83380400001)(26005)(186003)(53546011)(2906002)(6486002)(5660300002)(6916009)(66946007)(82960400001)(31696002)(38100700002)(8676002)(86362001)(316002)(4326008)(41300700001)(8936002)(31686004)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmpsQkUrdXVOTTlER2VuOFovUlpqa0l5LytzcVJKVDZRZ2JnbkNocmxpRjk2?=
 =?utf-8?B?am1ITGlhVXo3WjcrcEdMbFhmZFRwcVkwcFpBT1QxbDB6T3Jtd21ZQjlrcHEv?=
 =?utf-8?B?K010Zy9CMnV0dkYrSmVRdytORTRibW8vN1VzRUlpVEdjSGxtcEphVEdzMjJh?=
 =?utf-8?B?MFY1dE1KVnlzWkNhZXUyYWFHSG5QRGkxMFVZb1hGQTBRckNKTTJEMkQ1NDFO?=
 =?utf-8?B?eXBqaDBrN1h1WXYrTUZHQUJyRVVhWm80ZUNnT1R1NnJ3dGd0SXNzZ1F4Nzk1?=
 =?utf-8?B?eUJtWmhFNXFNKy9MTG1QZ1pQdElRL3B0cUNwOGRyT2F0THRUd3kwZ2xVSXdQ?=
 =?utf-8?B?TkNUMHUvZG5jSmM0WFdqNFdOZjR2WHVlVjQzaElZMDAvZkRGVUxOYnZCQ1Bi?=
 =?utf-8?B?YzdsSkwxN1JzdXlDQWJta01GLytNK3ZGZEN6UlhCYStsZUVoSmVBOVR0bHZQ?=
 =?utf-8?B?T1FRVmNZL1ZVemlQaFYyUklOOCtEU1hCalR4d2xScmd0SXMzK0ttRUgzUWd1?=
 =?utf-8?B?aEVZd1hXTVJadWc2UXRvS3Awa1V1eUl6NWJPaFpIT0lzZUEwOHpOUU11VWlh?=
 =?utf-8?B?ck5XYXFrSkJaTHdxNlFjeUU0Q1cvMkUrcmxLTlc3cGVPRjJIZXg2aVRZbjlE?=
 =?utf-8?B?TzBIOXdvUjQySmtiZmU2ZExMdUp1ZHFlcjNXSW84cEJlSHNGVVI2R0RvMnM1?=
 =?utf-8?B?NHJrRnZ3N0ovR2U4QTdodEVEL0pWTzlpc3dUVHRKUXJSN3FRa2FuRldaMkZH?=
 =?utf-8?B?V2VBck43dm1IR1pLK2tXS3ppZ0JZcjcwaXN0endTQXBvalNLZEZ4ZTVwTFdw?=
 =?utf-8?B?STVVQ1h0b0JZcGJaVGhUK2lmeHV6dmFxOGo4Tlg3RUNWUCtaZGZ3cFJQRlNJ?=
 =?utf-8?B?WldMaTIzaVljVTFqSElLQ2krMmZCSUFxMTdNSFA4N3l6T00xSllTQUloenZO?=
 =?utf-8?B?MFp5TExIdUlBbjFKS2Y1cWpUdUp5S2p5ZitJcDUrY0c0ZWRaSGJLOTFVc0JK?=
 =?utf-8?B?UnNYN0U0a2I1bFg1K0hiMmFxd28weXR5OTVqc2ZRc3FuNFVHZDRYRGxDOEtU?=
 =?utf-8?B?bWxlbDNiVTlkS1c5SGNEVW5zTTJwclZEWlFnTHhHSFRmRitLcjZQSkUybjhv?=
 =?utf-8?B?bWNjR3JuQU5PVGZkRkk2N3BneldnRWdCcCtPYzNieWF0TkdrU3VtVHJXMnNw?=
 =?utf-8?B?cmhWanVBRDhLR3d0aHNibFpWdTVoVlFKSTFta3lQMzJjMDdOVmZvQmc0TmZw?=
 =?utf-8?B?ZHQ0b0F1M2kwTVZJZGoxZkhxSjJZc2l5OVR5SUJMdndGZHgwK2FLbXpoK3RW?=
 =?utf-8?B?M21BamRlaXRZbWtXWGtvQ2V6M2FJaHpuN3hvZmVqVW5NUldTOHMycklpd2V4?=
 =?utf-8?B?TUJ0eW1sckNwMndyQVRxR21HWGxyNnBmZUxmeWJPMG8ydFBGdE5lUHBGVGZ4?=
 =?utf-8?B?dEJHRDlTQklPZURFRlkzalBXN1VHclNJMDh5MEFoblB1OWRJTUNqTVVyc0VM?=
 =?utf-8?B?dFRTNTZjWll3VEUrU0pYMEU0NTc3MzhETytZUmVZNXg2elEwSWpncExXamhY?=
 =?utf-8?B?YVdwMFN1WFhqNld4enRSUnV5WWpTMlB6M3dYUjJGQ3pmaEtVVENiOUpBNjZM?=
 =?utf-8?B?ekUzbVAxRWZrbXZaK2ZlZGJMVkVHdmFUTXVoaWd4ZWIrYnNrT21wVlpLdDNt?=
 =?utf-8?B?RnpSZjRqSld4SG91dmIzb1N2bFB4cXFoTWJOSkxxcnJDdFhZTGorbTZ4R0hj?=
 =?utf-8?B?VDBWVGlNWTRodU9BUitndnZkQnBXNmRwS2s0cTdKWFZJMzVTdGMyWjRZTkUx?=
 =?utf-8?B?aGlGNmVwRWNjUFJjK05NVjJuVnhLbkZ3RlU3QnJpRzl2ekZUeWpPN0dpbVVQ?=
 =?utf-8?B?ZDk1bUZ1eGo0MldLaGlWRi9KU0l5c1ZFUzNURFNuVmNhNzMxcDNoRHFiZVU1?=
 =?utf-8?B?bmtKR3AzOEhxYjJ5YmxYU0JkbHpEMUtxdDBZOVFPdTFFZWlOYzBmRFAvTDI1?=
 =?utf-8?B?T0dTN1pidEVCYTlQdlpDS1pKTnIzWWkvZUFHNGtrSEZMZ0tsbGtTM3hSYkw3?=
 =?utf-8?B?ZmVlTHUzakRSa3BXRU5lWnRyblExcEUweUVxSGlkZUFOMGtScENXWnJhcFRM?=
 =?utf-8?Q?mekreU/LpWaHABCpFDFZsHO/q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fb4542-cb5d-4568-1af4-08db773b7b1c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 18:22:35.7248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vaWNt0MCvdRqvoBbONBFXkgPeaHiCGYq6uAOUXqjALzsaVmzv6iIEatJMj2ANjPPPDcW0Jg6xO+DRN8y3jcGBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7952
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93; envelope-from=dongwon.kim@intel.com;
 helo=mga11.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.103, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Markus,

So I've worked on the description of this param. Can you check if this new version looks ok?

# @connectors:  List of physical monitor/connector names where the GTK
#           windows containing the respective graphics virtual consoles (VCs)
#           are to be placed. Index of the connector name in the array directly
#           indicates the id of the VC.
#           For example, with "-device gtk,connectors.0=DP-1, connectors.1=DP-2",
#           a physical display connected to DP-1 port will be the target monitor
#           for VC0 and the one on DP-2 will be the target for VC1. If there is
#           no connector associated with a VC, then that VC won't be placed anywhere
#           before the QEMU is relaunched with a proper connector name set for it.
#           If a connector name exists for a VC but the display cable is not plugged
#           in when guest is launched, the VC will be just hidden but will show up
#           as soon as the cable is plugged in. If a display is connected in the beginning
#           but later disconnected, VC will immediately be hidden and guest will detect
#           it as a disconnected display. This option does not force 1 to 1 mapping
#           between the connector and the VC, which means multiple VCs can be placed
#           on the same display but vice versa is not possible (a single VC duplicated
#           on a multiple displays)
#           (Since 8.1)

Thanks,
DW

On 6/20/2023 10:51 PM, Markus Armbruster wrote:

> Dongwon Kim <dongwon.kim@intel.com> writes:
>
>> From: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>
>> The new parameter named "connector" can be used to assign physical
>> monitors/connectors to individual GFX VCs such that when the monitor
>> is connected or hotplugged, the associated GTK window would be
>> moved to it. If the monitor is disconnected or unplugged, the
>> associated GTK window would be hidden and a relevant disconnect
>> event would be sent to the Guest.
>>
>> Usage: -device virtio-gpu-pci,max_outputs=2,blob=true,...
>>         -display gtk,gl=on,connectors.0=eDP-1,connectors.1=DP-1.....
>>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Daniel P. Berrangé <berrange@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> [...]
>
>> --- a/qapi/ui.json
>> +++ b/qapi/ui.json
>> @@ -1315,13 +1315,22 @@
>>   # @show-menubar: Display the main window menubar.  Defaults to "on".
>>   #     (Since 8.0)
>>   #
>> +# @connectors:  List of physical monitor/connector names where the GTK
>> +#               windows containing the respective graphics virtual consoles
>> +#               (VCs) are to be placed. If a mapping exists for a VC, it
>> +#               will be moved to that specific monitor or else it would
>> +#               not be displayed anywhere and would appear disconnected
>> +#               to the guest.
>> +#               (Since 8.1)
> Please format like
>
>     # @connectors: List of physical monitor/connector names where the GTK
>     #     windows containing the respective graphics virtual consoles
>     #     (VCs) are to be placed.  If a mapping exists for a VC, it will
>     #     be moved to that specific monitor or else it would not be
>     #     displayed anywhere and would appear disconnected to the guest.
>     #     (Since 8.1)
>
> to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
> to conform to current conventions).
>
> The meaning of @connectors is less than clear.  The phrase "If a mapping
> exists for a VC" suggests it is a mapping of sorts.  "List of physical
> monitor/connector names" indicates it maps to physical monitor /
> connector name.  What does it map from?  VC number?  How are VCs
> numbered?  Is it the same number we use in QOM /backend/console[NUM]?
>
> Using a list for the mapping means the mapping must be dense, e.g. I
> can't map #0 and #2 but not #1.  Is this what we want?
>
> The sentence "If a mapping exists" confusing has a dangling else
> ambiguity of sorts.  I can interpret it as
>
>      If a mapping exists for a VC:
>          the window will be moved to that specific monitor
>          or else it would not be displayed anywhere and would appear ...
>
> or as
>
>      If a mapping exists for a VC:
>          the window will be moved to that specific monitor
>      or else it would not be displayed anywhere and would appear ...
>
> I think we have three cases:
>
> 0. No mapping provided
>
> 1. Mapping provided, and the named monitor / connector exists
>
> 2. Mapping provided, and the named monitor / connector does not exist
>
> We can go from case 1 to 2 (disconnect) and vice versa (connect) at any
> time.
>
> Please spell out behavior for each case, and for the transitions between
> case 1 and 2.
>
>> +#
>>   # Since: 2.12
>>   ##
>>   { 'struct'  : 'DisplayGTK',
>>     'data'    : { '*grab-on-hover' : 'bool',
>>                   '*zoom-to-fit'   : 'bool',
>>                   '*show-tabs'     : 'bool',
>> -                '*show-menubar'  : 'bool'  } }
>> +                '*show-menubar'  : 'bool',
>> +                '*connectors'    : ['str'] } }
>>   
>>   ##
>>   # @DisplayEGLHeadless:
> [...]
>

