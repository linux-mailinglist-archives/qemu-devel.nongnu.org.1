Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 334C972B515
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 03:22:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8WEc-0003Ia-S8; Sun, 11 Jun 2023 21:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q8WEa-0003IP-QS
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 21:20:41 -0400
Received: from mga09.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q8WEY-0006NI-Nw
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 21:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686532838; x=1718068838;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sOdmtMAQXofHyQ/M2i6AS7KZyOsBB1OKibT30Es9ii4=;
 b=Lb2PdbHxZeHfWHXlsDdIEIe3f8GUKR6Ejc66ktl2SpM6VeJYD6f6blhY
 pJxwezq6IwoC+py9KwEhifK85f9DlOCoS+wjafMcTLyqFLbkueMdCgEgS
 ULCABSd3JyC078kFlrKnUoHH926LE5h6K6qDB70Tcw7cE8RHJ6pxBatJT
 VaZwL/cvXfa5GsErzJHOUeVM4DwW0wuj+0n410kfczKpqNnjIktxnvzyo
 b1GRPJib2RoCdZMcESoD2YFnlrZi/WZMRKg3CBYWpwnsw2DG1NDahB6AD
 dIypI2QhIfD6SB6lF5IPYyMqi0rXaUPDFxnUBRQTAhzq+ABybtMX2W2fx Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="360404818"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; d="scan'208";a="360404818"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2023 18:20:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="705192807"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; d="scan'208";a="705192807"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga007.jf.intel.com with ESMTP; 11 Jun 2023 18:20:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 11 Jun 2023 18:20:30 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 11 Jun 2023 18:20:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 11 Jun 2023 18:20:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 11 Jun 2023 18:20:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AE9yEskc8MdQy+jlncwhYw4QCALz3ETxvfxp3+5ZtxYyqwADZI88kAH/g16PjA9H+dLbVaTUW6KAR5OOdRh+cSeVpAIMFq6noqOubbQxCXFw5R1Oz5LLCiKaxnx0nhOSVcbp3cv920LBHgWk+zHuofEpodkEUz3+nWigLFQRCdmb7f6I7AvJnthHANIrktqr+YiOTBlNHevFpxczDwWnosOksJFDpK+G65I/gqrQ1Hk4BusxJQ0U16ls003mKtW3LZ7CZCHlNgYmd6tCUiwIOL2VE4zAH0kCnfb9nte2j0n6DnM0cFRcQY6wOgyav8LXppqjDS38OgYQIrga5QS+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4AhujBV9lrjUBpuktzKZTzRSz69Bf7NaZxxgyTgyRw=;
 b=djAHI8irBh0ELwug8VBuAOjkpS/LzfOiJR005ZcDCaOpH1M/hYSYCpTzNsk0olfSZLBCZ9MTPXzHCeH/WHYrKYXyCM8/y5Konlni9map62aj26M7YKQLCdfSHqwpyF2iKFNZAP8dcw070YrosYd8q1ZKuhciBZbzECynbrVksWyj3kITMwm4CZnQViq+Ca5riZ2QU/nMfKeaVm579apN+QYR6qhfwimwiAuRbKlj/f2pvX/pOwgNb4SFFJ65kkEK/pKsOAgkJOzKMkMWOnIEuq8fKzJ82sL6hlRbctIBlqmkzh26epg+gZEowwhezmGQuI6MyuxbiXWvpBkhkqKuJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by DS0PR11MB7310.namprd11.prod.outlook.com (2603:10b6:8:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 01:20:27 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 01:20:27 +0000
Message-ID: <8b126f3d-906a-bd0b-01d7-3603f3d48568@intel.com>
Date: Mon, 12 Jun 2023 09:20:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v14 08/10] Adding info [tb-list|tb] commands to HMP (WIP)
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
CC: Richard Henderson <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>, "Vanderson M. do Rosario"
 <vandersonmr2@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert"
 <dave@treblig.org>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-9-fei2.wu@intel.com>
 <387127a0-4030-32b9-ccbb-db2f95bd618b@linaro.org>
 <dddb5c1d-be72-15a7-97c3-eb306acd656f@intel.com>
 <ffe308e6-8d20-3282-a3b8-a9d6474fe7eb@intel.com>
 <CAFEAcA_YGEHouLDdnEHUUeYDiEgjY4W83-XjzPyjDTGzf2+Qdg@mail.gmail.com>
 <da39dc7a-4741-7c1e-fc64-ac2bf76e4354@intel.com>
 <CAFEAcA8+aw0Nd7tA7667RrGg+AZDf4MsAJs+_GP4nhdpXQwnRA@mail.gmail.com>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <CAFEAcA8+aw0Nd7tA7667RrGg+AZDf4MsAJs+_GP4nhdpXQwnRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|DS0PR11MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: a5da188d-6672-42ac-41b8-08db6ae33438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5MECZg0u9pPGI09KamWQoI3N0CsermAaIt2TsAqAAZjkNX2mswWx7K81rnRaoDxUry47bDSr4mC/hf5axjbXMSD9cSE1BAnkC3cpSXA8MFs5mJ9exppbRmK4DP2la4kGsCpcylTwqpXyXkPdEaM9nX7EKxdi0QjzzeSTbKzt/0Iz/+2N5HVcjFkdDD/8Gop2ggCFgcfVCaTuEUrBtiAQAov1Iwpr+LM1BiYT7S9U/5we5FHv4F3TGXURjPZMUANbD+VlRmF7mj1fmRlt8JbMHbtIS3lHFr5U1Sgr9oBAgQ60mTbtaQDvkSWJCkRNPSoQo64qvWSHD7VFrqrt0pXyUm0pvJswdyZqMJ7knuchTDpIS4LHzf8KNK1KB5+OzRlT4taNN34rs/G2qpzFmjDUWpFJjYxyVwTW58i9ovD6oQJa3GcOCiff72J+SI3gu7LDJlUBhPnNg/72xMfHmFScoJ9ypkSjFUYr1aLZsCo0H/f8tUYLIInznBXv4OP25xKz1EgfPN/6uPvx5nRdPG0MUi4QUL4l0qu7dfaz8/B/a2gtrPBERVLGXCBfOxNrkYJI92k6UPN+zjlMdSEnybEBZFct/ZjQyFXhQEkMuPGGniIZRFMrx/s4Sg8CHINWfEgP8K2uDWZfwZaBrFdCFSBSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(4326008)(66556008)(316002)(6916009)(66476007)(31686004)(41300700001)(186003)(2906002)(54906003)(478600001)(66946007)(8676002)(8936002)(5660300002)(6666004)(6486002)(53546011)(6506007)(6512007)(26005)(83380400001)(36756003)(86362001)(82960400001)(2616005)(31696002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmtrTHN0aHFqbW1qcUJ2dlpTSGNBa0Z1OEozOFVzc0lHT2FReGZTdGYrRmlQ?=
 =?utf-8?B?dmtxOW5rTDl6bDZRVEFaTDgvUzRyUGFWVFlSU2dNVW8rbVlJcDhnSDlnbndX?=
 =?utf-8?B?YXNybFY2UkdjamFYQjFmRkNrK0lteUx2dzc2WlViZVU0dU5oN05TQmYydEtS?=
 =?utf-8?B?RkRjaHluUmFFcktINlJKZHMzcC8wQi9MK0hyQ0lPQTFYOCtsdEZOVWFZUVRq?=
 =?utf-8?B?SkdpUTdEcjV1V0pPVXdUUGJic2M3VXBaSGxtUkNFREljTFhJSFc3OHVlZlNP?=
 =?utf-8?B?OFNDczJLNjRNRkNIaFVmMitQOHVJTnF5VGhwOGc2SzJIelIvTGRkVWFXaDNS?=
 =?utf-8?B?eVdrczZjS2o1U1UrQTRaNEtzY1lTSlJPZU9TbFlnZ3prUGtZT2hRTmg5QTU4?=
 =?utf-8?B?MnBpU0Z6SWRFSE9XVGp5eHE2RUtpdzN1b2FVUjdXVjN2VU02UzhTSS9RU0Ns?=
 =?utf-8?B?TDNDQjkvSnBISmthY2FmTXhaUXEzdWVvL2JVZVB4bExIdG8rOGdhaHBDSFBI?=
 =?utf-8?B?NmQzRGZOMjVYeENvdWhuQWhjRklVVk84VGZvcG5TUmRYVjNZUVUwd0FuazlY?=
 =?utf-8?B?NUZ5clh5djAvUUdiOUkyZFN3Y0dLQWVwbnl1bG5TaDFsb1pGN2N2UEhUTlo3?=
 =?utf-8?B?MEFjOFJZa2kxMkRKTm9LRHZOZldTNnJoUEI0UzBIU0FVOFBDRVJwMEp5eGd2?=
 =?utf-8?B?WDRaR0w5c0hyT0pOUGF4endRUVoyZ0MrWk96R3pUUzZsUTJRdjR6VU9oNUIx?=
 =?utf-8?B?QmFscW5LdEhYRmZ4SUdsMVJLYi9PWVNNNFRIbGtiUlFWRlZOSGhPMk9uOWc4?=
 =?utf-8?B?WGxXQlhyMldiWHlkbk5nSFhhUklOaFREQzRsVmZlN0p0ZGRpWldodjlneEhP?=
 =?utf-8?B?VzZtZlNJalBvNUtHK25IbVBVbXY4ZW1oOEFCdVoyUkgyRWNlTnVCZFo1Q3Vq?=
 =?utf-8?B?R1RWKytPL0xMbVg0VklBSDlrbVdoSkJwQmFIazMxUnRBMi96ckU0SFBkejU0?=
 =?utf-8?B?WkowK1VqTW1WVVQvK05ydTRvQ05xbHExQlhRUEVaTDB6RXBIbUd4aE1IVStv?=
 =?utf-8?B?Uzc5Q0NXa1cxMSs2K2kwVGtkNU81dHJFRVhoV1NFbWVrYU1VcXo0U0FGTVhJ?=
 =?utf-8?B?WUFMM3lFSlV4UnY4WFJCMGtqa3hZR0VBQ0FiMm9FNHFvdmdHUmhmbWFNb3gw?=
 =?utf-8?B?SHMxTWtuMGFrOXd3Nzl4SkI4Yk9DaytzWlJyQndZWHJCdzFmRWo1Smw0YjJW?=
 =?utf-8?B?eEx3TEdJK0FxM3ltMEplQUhwamg3b3I0RExQZ0M1WFlPSFVjZHdUUUM1ZExp?=
 =?utf-8?B?Nm81QThJRDhRZ1Rja2M5K1ozY2kra0hFdUEwdmw0OXRNdmJEUnQwM0NRckl0?=
 =?utf-8?B?eE00WkYxaUxzYmdBUzY2MWNGSlFwcTh0d01RaGh6aExaNHR5VTBKYWg1ajFF?=
 =?utf-8?B?eVJtNFRJYzJSVVVrN0FqZDEvQzNVY3lweitLbFUvWnhwMUJzd0xGYXFVWkt0?=
 =?utf-8?B?Q08wNGpYNUxmeXlId20reVBxdFp0Z0N3R0FBNzNqb0Z3bUYzc0t2UjdDZXNk?=
 =?utf-8?B?SW9hNTQzT0VxVTQzQ1ViN2dIeW80QUJINkFnUUVBZ3dTd2pxblRINWJnV0hE?=
 =?utf-8?B?enRXZFNjYUY5T3E1OE1BNDc2OUM1NjBneFlqOExmS1Y0WUI3c1ByQlFuQ09K?=
 =?utf-8?B?WkpGUkc1MkQzOU9HM2ZmME11dVdhZWE2Q0Z3M1NBY3dWM2pPTHE5QUcxYm9G?=
 =?utf-8?B?NVhKNXJ5MVhJMy9WbjVTKy9zMDIyM21SK3E4UTlqQWFicHY1cVRtZTVFemdO?=
 =?utf-8?B?SnpxNUtBaWNYeldnb2Q4VG93bjl4NkpjYXNRSEpCazZCaG9OQnVURi83VFdq?=
 =?utf-8?B?RXpNeUp4TjR5ODZab1JUdGxTTEJWY0RNTWNQaFdicHVPMzJmeHpFVTNmdE5n?=
 =?utf-8?B?Q3AxRHpSUXJNRkZqbWYySVV3SHF2cEY0Ni9DOUpFVHZDckdMNldndEdnTXcr?=
 =?utf-8?B?VVU3Nk12ckRPUXBYc3hmeGZwbDlXbm9SZlBpTnoyWDRDNVhBc3dqQUJQSWZy?=
 =?utf-8?B?b2pwZEIrNFQ1VzZVWEFTUW9Zb3UzYVNDcUZTKzkxaHNkS0k4Um0rNU9ZQXJM?=
 =?utf-8?Q?g9spL9MWZxqiNxDz6WlY1Tlyu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5da188d-6672-42ac-41b8-08db6ae33438
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 01:20:27.2992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpxpJgd23SfWp4ILuWeBA3pD3rqZQVXDobFyk0NuWJ42P9gMoDvgkAdRwTNaDb7hbxEHjk2VtIPbIlXhN1MNVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7310
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24; envelope-from=fei2.wu@intel.com;
 helo=mga09.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/9/2023 11:51 PM, Peter Maydell wrote:
> On Fri, 9 Jun 2023 at 15:32, Wu, Fei <fei2.wu@intel.com> wrote:
>>
>> On 6/8/2023 5:23 PM, Peter Maydell wrote:
>>> On Thu, 8 Jun 2023 at 08:44, Wu, Fei <fei2.wu@intel.com> wrote:
>>>> Is there any existing function to convert ram_addr_t to guest pa?
>>>
>>> Such a function would not be well-defined, because a block of RAM
>>> as specified by a ram_addr_t could be present at (aliased to) multiple
>>> guest physical addresses, or even currently not mapped to any guest
>>> physical address at all. And it could be present at different physical
>>> addresses for different vCPUs.
>>>
>> Thank you, Peter. What's the scenario of the last different physical
>> addresses for different vCPUs?
> 
> You can have a board with two different CPUs, where one of them
> has a RAM MemoryRegion that it puts at address A in its address
> space, and the other puts it at address B. This is most likely
> with 'heterogenous' configurations where you have an application
> processor A and a board-support processor B. (I don't know if
> we actually have any board models like that currently, but it's
> logically possible.)
> 
>> For this specific case, I found I don't have to convert ram_addr_t to
>> gpa, the real requirement is converting ram_addr_t to hva, this one
>> seems well defined using qemu_map_ram_ptr(0, ram_addr) ?
> 
> That does work for ram_addr_t to hva, but
> but note the warning on the comment above that function:
> you need to be in an RCU critical section to avoid some other
> thread coming along and de-allocating the RAM under your feet.
> 
> (Also it's tempting to remove that support for passing in 0
> as the RAMBlock, because every other use in the codebase seems
> to pass in a RAMBlock pointer.)
> 
Got it, thank you very much.

Fei.

> thanks
> -- PMM


