Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 046E3710DD0
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:01:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2BWA-0006vd-7A; Thu, 25 May 2023 10:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q2BVn-0006sR-8j
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:00:16 -0400
Received: from mga09.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q2BVk-0004Dz-WF
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685023213; x=1716559213;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vZNU3Sz+ogSy1qFsKZwGRH6n51hmz0ZMpb2fVlrT7TE=;
 b=MvqZt7+ZGgjG9Patc5lLEmPlRIgrOzScnCKPa7tXCkwSq12iDFocdxgE
 sd09RzzQlG7Dk8eiOHCQHP+xDnktrktjbHAXGRI8DPBo+2RiPj3c7sCwh
 FWuEf0Y/N+DlT32qurZxftL+ctqFWzuRygcDeFLYsptyfq/R2Akg95M2G
 gpYn56U47K+FiH09ZQoBKQtdDirXLInhe8pMtCn/zH0Fv6U39L1y6sMuh
 NUWoTY3cdu/0GoA4iKVUV3Kydir8hNoegOF5aaH0/+jqttZfzTDNp4i0t
 9y65uuMDapOCnZj+0Hu/jCvcOL8kVHEs1nj0HlvZTYQ4MbmThVg13XKot w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="356249820"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; d="scan'208";a="356249820"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2023 06:27:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="817093301"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; d="scan'208";a="817093301"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga002.fm.intel.com with ESMTP; 25 May 2023 06:27:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 06:27:55 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 06:27:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 25 May 2023 06:27:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 25 May 2023 06:27:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLsJgIr4NNz3cRuvg0TOkepxpdsth6+V/jjW6mhCIxS62ivfjktdoQwz6frRJ/C5CFQdAUBY23MVb/tyUfe3Ycs8nZ9pGgRcIgbwa/aKHOK1NaDEgf+dXOSuarsufhL3Q+lQVnJzcd776VcoSHlrSq0tv2DsVNKwrGglJKk6OKArsJlObcE+toaCo3mFs/uEP7Qwg0hMxv6PxW/BWe8qVcUea1xPLSQoSyfRAOaiPLPgzV2LPOlGO2QExMRP2KsViIDmfNCRstYCzk59lHQUiGoisiyBd2a6hN2rwqoKxd0036rX+NYQ48RLz8q1J2mFpbcrRKL5vWoVns5qLMb0BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WM/qa4XEQecARsg3lv60lsCrCedtXKer8uIPMVW+B4A=;
 b=jrV0feZPts53wEpv7dA5ZdlKtDgsk5PAYikxk1WkcaHNDAAlM1w+rLwhrMmpSK6deDtWnYIcqCt6o24AfvYnn+pXQbxiYAH6xzQKwD+tc3QQxb1gLa/VQc3Cx1M9mzTFf4YzxEeDJFZ1/oXIp4qK2+fd241YgIoQhu9DCWODkzgWyyHu4SyT8uaj5uHmq/3mxhdNeIo4jE6eJqu2Zp4RyOCNdzGg4M/ZocC5Yr6IL89kRFWwOCkygj2On8F5Gp9bAKgwmcANvz/VGttasIzTXh1GfaDId9GDheF+Y3Zuq0Dez9gMutzbBi3zzKlilSXyhe1wJcGhLce6ZXInSfM01w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 13:27:53 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::6418:8391:dce:a06]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::6418:8391:dce:a06%5]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 13:27:53 +0000
Message-ID: <d7ac5b50-e652-d84e-86b5-8c4e1257122f@intel.com>
Date: Thu, 25 May 2023 21:27:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v12 02/15] accel: collecting TB execution count
To: Richard Henderson <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>, 
 <alex.bennee@linaro.org>
CC: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>
References: <20230518135757.1442654-1-fei2.wu@intel.com>
 <20230518135757.1442654-3-fei2.wu@intel.com>
 <0bf482cc-fb96-0ada-f166-50d99b4952a5@linaro.org>
 <8adea3c0-ca06-1dd0-366b-f7eba9be6890@intel.com>
 <fd8a711d-7940-c990-bbed-7c4d9a46a664@linaro.org>
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <fd8a711d-7940-c990-bbed-7c4d9a46a664@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0195.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::17) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|PH0PR11MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd9fdbb-2e38-4a33-63e4-08db5d23d7d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2dKEDm/sl6jV7vhUtmGipKGuhrvY7E5dA6rNSzXU21swM32Be4dpx3I7AhqV28+Zoxid40H+rUmBOh58kxF9NukxU+rBkwK40xI5mbYySgqKGXjlGsbqMt87xVe74VLSKVmkwc2Pb3R+2pyVzr5tua7SaVdthInG4PWUwVKxwu3zXjt2JS/NKL43C1g6XVQlK/tQxkvwjfmLiwQhl8IZAOGoEsyZEIVnHjO/ZYGTziBTUlKdk41IiRWfc1y6FJv3KA5ExyHc+0We1Qmz90IkvmvAWg4v6Tujb3ynWBwvUKj+yG4/SowQvNzA3aEzer0nEG46Gh95zyDuDkJRyOX0yZnm70gDc9uxE1G4Ya4gQTEsWhVxW2wSn+n2DoEun6VlazyrLs4VhCIhMD0dBNp5q9YWvoMKgh0eE6BN6EJJURASCDQW9WavxnR7YnMrV7kMkGShZA6wvgIhpEkdOf4QMwfJ+XkDVoqRXolKhfsJr9b8I5P4fKMLJkGfgr+e6EjSpYfW22SUyhL3d7AKpUulObtvlW+xPgQXHAxuqF67xcvUSbEW2VZYehDWueRvZZOTiMMGzZdsNG/rhOkBVujTWtzPSCsrZLfeN0Li79YQ90eo1dgTRU0hcR/HBUJM8QkhAreNLhK/KSs9pl71lDKMgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199021)(31686004)(66556008)(66476007)(66946007)(478600001)(54906003)(4326008)(316002)(86362001)(31696002)(36756003)(83380400001)(6512007)(2616005)(6506007)(26005)(53546011)(186003)(41300700001)(5660300002)(8936002)(8676002)(2906002)(6486002)(6666004)(38100700002)(82960400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVRGWTJ2MTdRYzFENy90QVd2NEwxdkdWd0N6WWNoa2ovWUptdDc1WXlFYVFn?=
 =?utf-8?B?cGFQY2xlMWxXY1ZuTHYwVzhUVWt3MEVlNEdBSmlVbVFxWHQxTGs3NFRkSnNh?=
 =?utf-8?B?aDUzNTc3UGhXVHhxSDJQbEdyVklBd2VYT2E5STUrQkp2dzE3ZFFVUTlDbjdn?=
 =?utf-8?B?bTZuT0U2WWhLY3YwS3VYNWwwMVd0akY5VWFaQ1VzY0g3NU1sSUVwS3RzVU1a?=
 =?utf-8?B?Q0ZWVEV3amUzV1Z4R2JTM1hRcThaYjJnMEVBSHdYNEVNUnM1U0VXemdicjhK?=
 =?utf-8?B?ZlFPdEU2bHR5R3Z3Y0F5TitQN0xBVGFEejM0ZXdCKy9aamQzMjVPQzhJaVpi?=
 =?utf-8?B?aXdqc0g5NVlDcmdnMi9BNmR4aXRaYkFuRDJUZ3NRY3AvdnFXb1NFZUhlY2p3?=
 =?utf-8?B?QlNhOWhQZm5TRUREVzMyc1V5d1hNajdyYXVhT0xwRjBTdkdwMy8yc0JFTkJj?=
 =?utf-8?B?MWxack0yS2tLZ25EcVh5VEtaMG1ZVnA3c01uZ0ZUbnpZM2gycUVxbm02aVNm?=
 =?utf-8?B?QmdwZTJsUWMrR0hXbDIweEd2UzJ5QlNrUWpoVFA3eVExb1gvMGJ1bVYxMGNw?=
 =?utf-8?B?YS94bTg5SjJNTlhnanFOcU1IVG1sOGFtZUVOaTNsaXcwUzdleHFSZWNKWjRn?=
 =?utf-8?B?MFQxcjI1a3FROHU1akpHNWNjQVBqT3RibkdEWHhnd2dKNFFMVHdqNllEYzBL?=
 =?utf-8?B?UU1DaGxKQUcrcnZwQlFtMTF6UVMrcUVsYW4zeEluZTJSYVpqaFM0WUpHNFpj?=
 =?utf-8?B?aUFjcm01UHlRQjEyR05Hd3huVXdBS0xyZml6amViRTM2WCt0VUZUS1BiVUFz?=
 =?utf-8?B?RG1EMUFJOVBELzY1Y3p1K0c0cCtTSUZJNkM5RXYyenhmNVl1ZnVGak1abHNh?=
 =?utf-8?B?dDhtbDNMNktvK0hvOStGSVdjY1VqRW1MeDBhUSs4UDlvYjZLTU82OVVGc00x?=
 =?utf-8?B?NzZtallWZVgvS0hET0h2ditoc2NKdm5FcUxaU0F2WUdmMklDRE55ZEdKNWlF?=
 =?utf-8?B?eHhnRmFMVzNTSjN2YTBkNGw3NkFRcWN0OTVPTmQydHB0S0NJYmRMVlJ3czBL?=
 =?utf-8?B?bGE0bW92NlUxbWRVQ2JtQW5zakVXemtWelUvNEdFeUtIWlhET3lMTDM4a2F1?=
 =?utf-8?B?TzF1bEpYdjhQK0tZU2c1cHlFNjd4THpNN3pGb0xOVmtmYmk0Z2VXVmNNcmc1?=
 =?utf-8?B?TjRqT0JZaVArOXlNblo3NTJIZ1RST2FYMTdzUnI5WGV5a3NPc2hYMVJlcXFl?=
 =?utf-8?B?NDVmOGwxZkZ3Um5XZWFJRXczcVpmMWNwSmVJdkpCR0I3QU0zYS90ME11WEdy?=
 =?utf-8?B?clJvdFJpMXhRa2dKWlplTVd4Sk9GemRyTGc2ZHBnMGpRZFB3REI5MUVNaWJy?=
 =?utf-8?B?VjRYTFVPVmIyZnJkL2VFY0NkRytKN0FYb0pVSEM2dGRSVlRXOGloNFlDKzdF?=
 =?utf-8?B?RGhsaSt0TkZ6ZWZocjNOc3RlaXZyc1VMSkRDM2dTN2tOeU5NRWtRVm80ZXQ5?=
 =?utf-8?B?UGU4SlU1cG9TOWZyMXYyVHd6NjhScHhnMXFQQmN1Q3E2ZGhsY0JWMnFOdThw?=
 =?utf-8?B?MG1EeGU2bndVV3VORUxwaXVWcmdKWG4rRkMxbDEyZUlmMWl1R25DRmpxd0p5?=
 =?utf-8?B?ckpoSE4rSjdzbWREdjcvdE42TkNjbE9udUJWSXNrR1dWK2FrdTNlUVhtU3Rr?=
 =?utf-8?B?cm96NzQrTXM0WnpHZkg2cndVWUw0ajRSa1pNVDBpUXE4blhkNnZ2ZG12QldR?=
 =?utf-8?B?SURKcUFvaHJiaXJ5eVQrRlBGOVlpK2I2Wm1sNkFod1B0VjZPVWpqYmpWNTk5?=
 =?utf-8?B?ajZWdEJhcDB0YjE4elArNjJGaTVYTzU4NUk2VTI3Z3Rhdm9qeW1IVmg0aWVu?=
 =?utf-8?B?TXgzbWYxTlFzeUdYSGk4SFYrRDdwdk1HK2dxMnlDVjdIamt6VTljdlNnQnUx?=
 =?utf-8?B?SFdHRHJtNXdNSmZpaHQ4RENCLzZFN0dkRmJsRXdsc1g1cmVZR05hNUlicGdh?=
 =?utf-8?B?em5sdmg5aWM4ZTRqWnVZWmZpWVd1S01BTzdGS2xFQlNhUWNZNlJqaWU2dVMv?=
 =?utf-8?B?RUxmS1Jac210bkpuL2trdWthQXZZS3pKdWNPWjJjMlk4ZkNWTWozb010ay9l?=
 =?utf-8?Q?BS16wRj5sXNqMyJv6otAGJQCr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd9fdbb-2e38-4a33-63e4-08db5d23d7d3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 13:27:53.2241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5axO/dfUKI+XVlh/MkUUUMO9RrkGp5Blo1HVxX3OHEj+xas1D5+YkZJkS4F7DU1KNNjYEaEQeYS3ouhIrOTe9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5077
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24; envelope-from=fei2.wu@intel.com;
 helo=mga09.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
This will change the series dramatically, the patches probably need to
be reorganized, a lot of rebases are required, and some functions such
as tcg_dump_op_count which is in the scope of CONFIG_PROFILER will be
removed first then added backed. It takes time, I will try to send it
out asap.

Thanks,
Fei.
> 
> r~


