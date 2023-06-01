Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5F57193CD
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 09:01:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4cIC-0001oC-II; Thu, 01 Jun 2023 03:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4cI1-0001nw-LS
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 03:00:06 -0400
Received: from mga05.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4cHy-0000sR-Bc
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 03:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685602802; x=1717138802;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sH716KP7w/P4GoQSk7uJC1Mql2HC1KY4TfQe0bdtbEk=;
 b=QrTG5rDGjtB5PqnCkGcCD49b81zdWAsndb0RHeN5kheZMwNgt559ZR4z
 BJRqUQyFg2+ruFNZL3hTjwXwtp33IfAv+hIZdGiC0p6rRjBornBty1nS9
 8QR33BPuRrvGxpmPIqc/Dn+Lr0ewsirp52gQi1+Xu3s3oYwK/R9r74c/W
 m1UT6uSfT4+W7LDzPwq7SNcI/hjiW7oTDQyv8wVTvvohbx5/CzdqlO079
 GQ/v0XaYfQbwWi1txlSnvdeu53gzP1+1VIw3roZ/RBxmG5sixjiNdadx3
 N7TTu9Vg8R6Z89FsT8Op7inQR/0+rVCF6mkt90sCR6ZvgC11Dp1Nfb/LI g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="441831817"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="441831817"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 23:59:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="831469575"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="831469575"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga004.jf.intel.com with ESMTP; 31 May 2023 23:59:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 23:59:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 23:59:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 23:59:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 23:59:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBWhPnAaOh+6wjdE0EOkk5plbgO+ORKoPUxj17YEHumcvfrtKUeCpaptVqgUjAaqICQHHcSUx0KpJwAAWPBwrOTqckTMv3E9MdAstgUJ5uABGGzHK3fT7Ou8WEjoQ4+bZfQdw9Et09KHMi20u0J+SK1IQK9uvgy52VJHnE6D8ALhv8sdKQZF1uYC/3agQbv9av7WnsK01FLNkyIGax1FhjJ5WMEF+RbY1/uwfRT05c0O519XcnhXGx238KVYCccwfIFVBgINLhqVDfa8m3i/OKMXlEmWx5b4y7Sc7e3EQyU+GT0qH+yuE/M4KgN8RH8K/TljKOnalub5VaEPhKn/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKIgIWhLBqtdVMgEzUQIjzErzZQJKlH3Jho3Ps0IAQU=;
 b=GBxf5lXT9JytfA5c/wSQHAfIi42mpkFGSYyJzgas9uhXttmjyYZTRqZdvkJwm6Bki2/jwMZ9lZn+kL7wdsJSbB6nRIvsm9BYHqkKxoHr+Ld8pyGX3m9zwQ4MLT90z9us4yqgxM6su9UgJyPQfQuS3ofkgb6O4quFJBYNyXKz5qZF4TfdlTHBnaLNO5vM0uybHa+LKzw4h6EwxnuSj8BoEUVOtC5V7ngl690Etmu5arrPSkib2A3V2TFzC2w0Gg3FVYaLxLn7/JxC1qbiB7YtWb62S6IRwczzmj4X24N4/9WARtfkUKJleRkVTFZUbWdDMOgljvCDE1gkOUBJuLAQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by DS7PR11MB7805.namprd11.prod.outlook.com (2603:10b6:8:ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 06:59:44 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 06:59:43 +0000
Message-ID: <23f9d94c-6c4f-d915-b1e4-c195404afe65@intel.com>
Date: Thu, 1 Jun 2023 14:59:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 05/10] debug: add -d tb_stats to control TBStatistics
 collection:
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>
CC: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-6-fei2.wu@intel.com>
 <4c32a2e4-1370-b81f-9fec-2603648c60c3@linaro.org>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <4c32a2e4-1370-b81f-9fec-2603648c60c3@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0237.apcprd06.prod.outlook.com
 (2603:1096:4:ac::21) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|DS7PR11MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 544b8dc4-a062-4e36-99ed-08db626dc70c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zq/p03lf/GHFfIDUrlsrTJTqVzVK6v4JTfa2ILXh81bH1wxqYCKW64zLZjQZr2EJ5xa46uD2xNgaFfLu1nTkkh1G1Ou6GxMhhoJuMRuK7OBigBAhRvoq7Q7UOAA7sIv/9GJOgSTNsi2GR2Sp5soPJhQuTJoROyf+UcRQVM3i3KASBDR1vkUYVGLGKV88KzR+nqrDLupZKTdgkwHCVEy6nwvmYmPH/55AN6HFj68hOrGrwasrwLgth+HLlZeAn9piNpVcY9IwPmut56+oIumOuDElv8Z0YF8TpaHeg7CuQL1IKzqTz0IplbQJFxxy1ZoA+LVWll+ba5xrTzlel5vJcguHmWUiCzAc1ANI5xaYi8FnDdnl0uDepq5da1wSjBcViWurf6EMR9OccSAMAXT3TXeDflKc0eCQEWZJKa4HClqQO8RUMLOqwbJsC+55B4JZ2hw+ZjnbRa3U9lRnX1iPafoad0dqw7ABRT6aVjbQ+ShbD6s2P2Q0683k4cnhxXRLe9H7pX8x+pDRnv/DSd9gGxFxc7lS8OsTZ0LJ8he3pxtw4I7eSP8IJ34xA3ff75kYr1GJIQEIKlLkDAa0nQaOTUKB/Oj3ZuYJGHVJJpYUCo/4LzXDD4BXCA03p73uJouBygM+I3ERyZQIHy8Ru4cnzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(82960400001)(38100700002)(36756003)(31696002)(86362001)(31686004)(8676002)(8936002)(41300700001)(26005)(6506007)(6512007)(53546011)(5660300002)(66946007)(186003)(2616005)(83380400001)(316002)(66556008)(66476007)(6486002)(4744005)(54906003)(478600001)(6666004)(4326008)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXRSWnlWamdSOVB6NGcxKzR4WUtxTlBCMVh0cTdGakRDb2pqT1RIU3U0cndS?=
 =?utf-8?B?cVR0Sk1EL2xGdmU3alkwSWZ2MmpKM3l5UlJaQnZLR3hyaTltTHZkemNLNDZ5?=
 =?utf-8?B?NnhabC9uVTF0RlU4Q1RSWm5KcU9qNzk1NitqblRFNDZQRDhBT3M2eW1RUDN3?=
 =?utf-8?B?R3NaOEgrUmkrbFdrWi8vT3o5QzgvdzJTTWZ5U1JRNnN1MEh0bllJOHZYRDRS?=
 =?utf-8?B?bmZjMmd6cFRJcjA0Mm1Uc0VDWHpiQldkdjVKQjNqUVN3WXFzdWVNb3Ntd3Za?=
 =?utf-8?B?R0FsYUY5R09GaDlMWnZ2Mng4ZjF0ZUdPT3JXU2p3V094T0w2R0E4c1hyeG5T?=
 =?utf-8?B?K0UwQXdPM1pYTGhhZUQvWC9IcmZDOXBmd2VZUjFFT3NUZllpWDg2Mk1IR3V1?=
 =?utf-8?B?U0VBWWxHZVVOSzZUV2l6a0Q1R1hIaGVseTBaNkdESSt1dmVZZ1huNy9hV3dz?=
 =?utf-8?B?WVhsekVmVGR5VkZTUGo3alZZMWcraEZrME1VZ1ROU3FoMysxcE43eGVOcGc4?=
 =?utf-8?B?NWtjZWNrVzRSYUlkSEl4WFBXWjFRbnplWldoZG1mY1gwZFUzTUJRY1BRZyty?=
 =?utf-8?B?QWNGNjFDSWg5M0R5ZTRPUUVCQTJ4TzJxTXZ5d0JEM1VjWFJsNVg2R20xaG5S?=
 =?utf-8?B?bDVtOGUzbTFzdEhvWHpZdFg4SG41NzZmd0UyR2FYc3FTUUNTNjFiUzdoQVBL?=
 =?utf-8?B?aTgrem1sY09FMmpnUlNualBLOTFnYUdtcGpDaWNGMXhhK1RjNXBiQ2Y2VWtw?=
 =?utf-8?B?SS83OHB3OU9LS0hOS2p5UlN0bmxHYUpXcVRseU5yamh0c2JUQmlTYnR6K2dw?=
 =?utf-8?B?MDh2V1JySnhrRGR6ekdhaGVZQ3JQZDhwaG5vVGdZdGRhS3gyTnVzTkZYOEZT?=
 =?utf-8?B?eEZ4QzJRVm4ySExEWk9XejhQaWNuT2N6bEpvS2FnV1RyeTlHaldKNHZHWGZ2?=
 =?utf-8?B?MnZrZHBFUjZBVk9TNDVQRC9yWGdJeG13S05pT012L3U4V1VOUVd5dndMUUFO?=
 =?utf-8?B?UVI0emZ5dkEvVmlUSkxiZytyMURvYmpmUUJoUFI4dE5mMmRLR3JiNytqTXdU?=
 =?utf-8?B?NHlNYkxJZjZ1MDB2NnJFejJXZXR2QmZVUGZ6RElxQXdsZ2FyS1p6ZUxwWTl3?=
 =?utf-8?B?Mm1UbXY4dkpFWERkSUU2TUc2UDlyQWJpOEV4cm03N2kwdHQ1c1ZCRFYvTTVw?=
 =?utf-8?B?cXZrVys1SE1rWWlzMDJnUnBMcmtJTHlmYWphZ3FIdGt4UXNUUU9iV01QdCsr?=
 =?utf-8?B?RkhuZld3VXVCVEJSeDBpbVZtSStjdThWT0NzU0R3ZE9uZ0pSbDBzU1o4V05j?=
 =?utf-8?B?WExzdC9XMDdXUUx1T2t0aGEyNVdRdG00cWRoc1ZKNGdWNjkrS2s5cnBjek9C?=
 =?utf-8?B?TVpqWGY3YnRnYU9xUzJGcU9wVFZlRitoVGtNT0RBUXFQU25wWkR1Um9qVGNN?=
 =?utf-8?B?RUNROWVXWVYvczZ1ckM0eE4yOGNmZUdzUzVmYkgzYWpVdUhjRVZoQk9uTXhH?=
 =?utf-8?B?UUlQcHc2TnVsRXdlTW12Q0RiYkdCZnZvdmhCMHl0NlhTS3hWWjJPR0tiaEs1?=
 =?utf-8?B?aUcyM29BVjI0dEhMWGVkRzU0M0Z0c1NSVGt6VzBNS1dRSitrQU1WOHNVWEJY?=
 =?utf-8?B?VklhM3ZUeFVmT2I0cTV0dmFtSHdXdjdSM2loWk5vaUVkdjV4ZWlGYy9EQkNt?=
 =?utf-8?B?MVJ0ZFQ0MFcrNUR2V3BmV3BlanZoTkh4a1hHdWh3KzNrWkZWT0YxTXpyV3NX?=
 =?utf-8?B?bDNkOTU1TGZLekZmSktJdnZVem1CaXdYWTc4RktSM1BUbE5xR0lPdEk4SDQ2?=
 =?utf-8?B?VFE0UlRsVm4xWEphZHUvRThlY1ZXNGRoelpBV1VtczZjVHEzWE9FSEVJNm5M?=
 =?utf-8?B?cFRHamdwWktNNmJDZnRrOGkxQ1hBZTFVVFJvZ1RKOUdmWXlxNFNJblMvUFA1?=
 =?utf-8?B?aUcyQUJjQXF1KzBZQlZXNWpIVHcvWE9UQ1BveUszbTJyeHlzOFNLaFh4ak1n?=
 =?utf-8?B?SDFEOXJUblp1MHlFNDljQzFWbnNnUWtYMmJNVlJzNDYxWmZRL045Z3QzN2pH?=
 =?utf-8?B?Sks5cnQrZzFhSkVydG5ZbW04YXdQVGF4dzlHdTllWExKZDhhWDhneHBTUUM2?=
 =?utf-8?Q?dsgbozlpgPcpMQjjToaUhRPcG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 544b8dc4-a062-4e36-99ed-08db626dc70c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 06:59:43.6647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pf/3JsrSuifejIIBV0JbJqhqNNhyml8VrR4gfC8aAwmQWKaqalyjrT+m1WNVo+ti4KjsijanCmiBfKFfs/eiNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7805
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.43; envelope-from=fei2.wu@intel.com;
 helo=mga05.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

On 6/1/2023 9:18 AM, Richard Henderson wrote:
> On 5/30/23 01:35, Fei Wu wrote:
>> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
>>
>>   -d tb_stats[[,level=(+all+jit+exec+time)][,dump_limit=<number>]]
>>
>> "dump_limit" is used to limit the number of dumped TBStats in
>> linux-user mode.
> 
> Why is user-mode special?
> 
Should be an issue in comment, not in code.

>>
>> [all+jit+exec+time] control the profilling level used
>> by the TBStats. Can be used as follow:
>>
>> -d tb_stats
>> -d tb_stats,level=jit+time
> 
> Comma is already used to separate different -d options.
> You should not overload that.
> 
> "level" doesn't make sense for things that aren't hierarchical.
> 
> What's wrong with tb-stats-{all,jit,time,exec}?
> 
Let me try.

Thanks,
Fei.
> 
> r~


