Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E6372D826
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 05:31:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8ujf-0005M1-JH; Mon, 12 Jun 2023 23:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q8ujd-0005Lp-3t
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 23:30:21 -0400
Received: from mga18.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q8uja-0006Ms-4n
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 23:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686627018; x=1718163018;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=5pPsdAWO7EFgIpIiDPFnWkUYxif7/JDaHaVzmCqfwXM=;
 b=P8mqRHhjpYZnwM9Pp1O9JKptleoX4kPZhgs1ddRLdPOHU20szvWF+rCE
 25rM0tEu+bcURsqKTuob0EGLdUuiJ3okIH2tmsrG0VBsz6DgjSTzc1ACF
 IoXF49wSfJ6/0VXUAwr9hVhozWGF3RMNZxPgrPMjEpwHKz3mQcLbN29/D
 zyUpHN2ZMqxAG/7XsVhpU1vcXtyDx8D29acVmgIg/Ze/joEA0hC4NRWoW
 BvwzeHS32N6XgN8y5UA7O91VMkVlwHoYYBIeqzQvU+LIa3pH5N6b5T2uq
 0GurU0pyoxnnJXwjh1WM7TyAJ05yL/zEdKEqWsQDz8VgAfDIOZQU7NwQE Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="342908738"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; d="scan'208";a="342908738"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2023 20:30:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661844984"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; d="scan'208";a="661844984"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 20:30:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 20:30:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 20:30:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 20:30:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 20:30:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8lhw+uvRgEyXiZ7kiyw9Y21AA1gw1KqO2dg52q58Zj308YRG0jJLvYpBKSXCs5cAjFUUBO1u/TO+dGrrNvvYi/1i3jnXi7M76sV1I5HO8xQ6s02zSV9t/0aaqbaDzPInKWd5ym0ygak8V4tzJ23zfXKN/dlaW9AWw6AfhNLjiG7Jm3Qq1HQ5yDmKyh0ExROjZq51fOV7Rma5nsU/dMZpChDFr/Ik4tgVpiqQ75za/U5lvLzRMblETGruvIcdPmCfJZ7maTkU5kq6daHf0/zLIuEPforEaBx2MoJwSVRJ3mgpSgtboFRJGxQTsMjc4h3WSvtRk5s7p1XS5GZ8BchqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvKLJEip/2S0KqB2PC3Zd0KCYegX8xNY2JV6M0Gs6C4=;
 b=gaVQRjmdMsIFbZItHtmg2PJGJMXwy3Y9XA1vt+XJL4oqiZB94asMpyNYYv4kYhreJ6FYuz3cuEZgQFGr5fuHNihm7/vw2m0mdzErZ03jwoIB25bxMSPz/Ea6zvhDEscDtzZAgI4Jk1cZJlO48BdMsLYTG+fSLFwnhZiOnBQNiL4MaC7EE9KVYFVXssuGSl5/2opcUe+ftuV9CE6el0hT+ra8rVto+HMe0JfqvN2lUfApZnKzbk08oyhdKYredG/6VJzq/dbqE7enXHXQyrxoTfd915MfPBwK2y9jKQtXm7GkeLH15IIQURfzk7p9wLh2v0ave2x5eVSJZ+54zGll0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by SA0PR11MB4608.namprd11.prod.outlook.com (2603:10b6:806:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 03:30:06 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 03:30:06 +0000
Message-ID: <4a1515be-909f-d2a6-3020-f952c0301008@intel.com>
Date: Tue, 13 Jun 2023 11:29:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v15 00/10] TCG code quality tracking
Content-Language: en-US
To: <richard.henderson@linaro.org>, <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>
References: <20230607122411.3394702-1-fei2.wu@intel.com>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <20230607122411.3394702-1-fei2.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|SA0PR11MB4608:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d3aae17-5f92-4b58-1094-08db6bbe7b03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: liuLbcdAwjvcE7786bpduiBhSCoCZ65EfmyvqVTg1q6+NY/A/OCv9Id70/kzrfOVIJdqFLcXAALCiWOcH9uy0r4aALg0biSLuf8jv4ovwEaMBHaPS69HJ72Pk9+HFCwav4fFduWONsaQnUAmDwE7oILe0NKqRNisqakU0aN094oxevU/pLMOo0MnAKPzQ80mxAZORXkfJD4Gw3Rp9YjS3eTMKN3uZ6xZU8HKvTRDPJ9nJRTFASNk+7+/zo7MkhBc+QHhpiTiPFrsBmCXkZfQyfaEQ3kyDGjRZ6X/ffqyGsqpgzaWWLINck2zchz073xcc4DcuizmJEjpDDss1jR3N1hKZCfrTLaPvWL93pSPVau1KHdXHXqhOS5UAoPoSXNVTsoXspWsWe/yVAs0VVRGUvrVYAywnepncVbhCv5Itcts5qOxyUek9wu1p7thXWMhuDVPM7duEDBiHlZnzbRgdE12WBW33t3Jq4ZIgQOtgWPDOMvBhOcZDvssOzqUYbRRnJyep3SkqNZoKJzzzGkoI1tG8F/+znOSkgVevVGM0cQM/6xG2awlTieT034bvmWDrrvoaVTf480HOA8ABFp2BblY6JSiGGpP1hjgOEjVfXtVYDy4Z7TJiJpIvILeptSntc4SbgBPLM0aE14qeZtuEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199021)(2616005)(66574015)(83380400001)(82960400001)(86362001)(31696002)(36756003)(38100700002)(478600001)(6666004)(6486002)(8936002)(2906002)(8676002)(5660300002)(66556008)(66476007)(66946007)(31686004)(41300700001)(316002)(186003)(53546011)(6512007)(26005)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTBRU1crZ1hNdWVWM3Y2U0YwOG9sWEoxQmZRU0hmdDYzVk9pZkNsWnlKby9U?=
 =?utf-8?B?eUNlZ2l6R2hPMDVxWDFvS3owZ2YvZ2FFRHEzTDJaL1JpeGZWZDhaYVMwUnZw?=
 =?utf-8?B?L3NTWDFDQXpOcWtqWS9LNFY1QVQ1ZTUyZi9xbkdLTW44Zm9XV05tT1NUNnJv?=
 =?utf-8?B?V1hEV0tSZlhlbjBOZ1RHZVRIbVZnbFJhZ2xVWkxLaEF3Y0tMVHZEaGdYM3hR?=
 =?utf-8?B?eWptNlJyNjY3N3N5aTFpNlc5Y1d6bDlZUVNwcFgxUU96VUJTUXJoVUFvWnYv?=
 =?utf-8?B?am1PTUVRTHBhSzhXWUdBSUQxd1grS1d5SE53bk1QeW91TzRibWViMDRrZE9j?=
 =?utf-8?B?b05wOXlRa1NNa1lNT1Vyb3lDNHRETUkyV1dhR3JLOWsvT3QzdDBNVmpLQ09R?=
 =?utf-8?B?ZjE3SjFHQSt4YUd3YVgvV0p5cGVuMGhBbGpPeEJaU0lQajhCSnA1RTZIMlFW?=
 =?utf-8?B?ZURRUGtmZjRoa0ptSHR1OGt0SXY2eWFOUDhHUElqVGJBVjZOMGxrN0lMWGU2?=
 =?utf-8?B?UVJ0ckwza2lORS90aWh3VXVhSWlOUnp5M0FzNlNWSS84Yzd4VFRVVFBpWVov?=
 =?utf-8?B?QmhDZzJuUWJzOGJjUS9aWEdNS3Zoc1cyYTRnVHNsTGRGTFZWcnFLZ1duclpp?=
 =?utf-8?B?NGhFS1pSYUZEejBPdjYrQVIySFFIVEFENDF1WTA3QS96TlRaWEVMZnB3eTFO?=
 =?utf-8?B?dWorYm5BZGV3NFR0bXAxVmRvZkZXd2RpenpzbzNqU1ZtTXRjU0UzNTl5bmJz?=
 =?utf-8?B?MHJiYzMzYlJCOW5kOERaZlZFdFQ2OERNWEFyNERTK014eE1CRkxmMWtKb2sr?=
 =?utf-8?B?UjRzUHhpNXNIaFlzLzhJZlBjaEluVnQrZ2ZhSXlnLytiL0s1U0ZBMHgzZkhI?=
 =?utf-8?B?NVpKcmVocUROZ1Z4Nmxta1cvSVE4eVFWVWUzaERTRUxlZ0FucXh1QTBUMmNt?=
 =?utf-8?B?RXoxU3IvSWxYWnZNTStXRWdpL0ZiMzB4RjBidlorYXdZZHlRK21OUWFXRHd0?=
 =?utf-8?B?dFlnRFlPZHB5ODRvcmg0aGxUUVhwY09idUVJbEU5NjZ2Z3llTWxyVGE4VjQ1?=
 =?utf-8?B?WjVwK1Y1UnRoZnRHVmh2STYycWtNbzNqZmdhc2gvWTZoWHhxakJ1OWVlTExj?=
 =?utf-8?B?ejBid3RmTTRlTGZnTVk2b09DdmJYVkVwTkVNN2Mwd2pzaUk3Nno3dWthbVZq?=
 =?utf-8?B?aExVcVBlVHE1K1hleXVEcWY1dUlJNEpUcjArZVdjb0RXU2YyT1F6aGdvY3NU?=
 =?utf-8?B?QytaK1pEdmpaZHB1QmZFeUk0YnRzRVcyS3dqdHRReFlnY2VUK01mVkR4d1Y2?=
 =?utf-8?B?cUtMRkZuTVJUZEJ5b0hUVmJjbmVKeXo0bmdFcXBPalFjL1BsOVg1ZUtpZVhp?=
 =?utf-8?B?Nno0Q1dQYkxyVjBUSVgxNXVUN0hmb2pCWERHUXNXSGdwWWZKTU85eFQ0b1R2?=
 =?utf-8?B?NGgrYVBUR2V4OEFQRm9FaWpFSjRWeWxkUkxHMDJyd2VZQ3hlZVlEb0JzMlJE?=
 =?utf-8?B?eG5RaTFDVWR4YklOUmh1YjZmeEZVT1JYaXNUZnNrYlRGdGR3aVIyVjhvWk51?=
 =?utf-8?B?cUd5NDdac3pSZkVYU0docUJ6dFFTb0JRRnovdTZqVU9MK1dHZWJzTzR3b3F2?=
 =?utf-8?B?aGNzNFNDRUtPSlZ6SkJVbHdzV1ZCbVhvbkt4bFdUdlVwSi9lZEZkNEhKd1pv?=
 =?utf-8?B?OTFLLzQ3M3VIT1ppa2c5eHBmNFJZRkMxOGR2b1JneWFKM0tUWEVaeUozTm9L?=
 =?utf-8?B?UU1iTGcyVzlha1FNRFpNT1RIS2xKTCtZc1g0bGc5VnROTVpldHdYS1dEbzVy?=
 =?utf-8?B?bkQ0Sm4yM0crTnFrYXljNzNNdkpsUmdYbXBMVHVtNnBubktRUFRCOG5VZWRQ?=
 =?utf-8?B?VENEZ0pMdUs0MndFQURzYWxOM1hoeXNlWHFpU3d2VXlFMjdzWm9LUmw2QURj?=
 =?utf-8?B?cWpEYzFsQ3pMVUhzekxGZEh1ZElxNWMyOVMrdlpEVkpkUkpFL3d1Q3FqUyti?=
 =?utf-8?B?djVtZWErb2RXK1p0cjNyOWJoUksvZkU4b01vU3h0Y0h1WEYya3BMdUdQVDNi?=
 =?utf-8?B?QlVRSDRTc2tiTFROSkhGNGIxZzdYN2tsSVhKQ3MzZWtUL3hBNXd3bFNvUUVV?=
 =?utf-8?Q?/T8SQfRxhkEjmZuGkCe3pdHZX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3aae17-5f92-4b58-1094-08db6bbe7b03
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 03:30:05.7971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0CcwmOsvaf9uffkxCilcxEt+yXjhxFoTFwwQEFtZgFRSRsrxapOSw4UgQ+VOGM8xMGXfuxHKPgcHSpFhIn2BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4608
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.126; envelope-from=fei2.wu@intel.com;
 helo=mga18.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/7/2023 8:24 PM, Fei Wu wrote:
> v15
> ---
> This is a large change:
> * remove all time related stuffs, including cmd 'info profile'
> * remove the per-TB flag, use global flag instead
> * remove tb_stats pause/filter, but add status
> * remove qemu_log changes, and use monitor_printf
> * use array instead of list for sorting
> * remove async_safe_run_on_cpu for cmd info tb-list & tb
> * use monitor_disas instead of regenerate TB, but **doesn't work yet**
> * other cleanups
> 
Hi Richard,

Could you please take a look at this series? I hope most of the comments
on v14 have been addressed.

Next revision I will change:
* add async_safe_run_on_cpu back in case of any concurrency issue
* add tbs->gpa_pc for monitor_disas, which requires
get_page_addr_code_hostp() return both ram_addr_t and gpa
* finalize the commit logs and documents

Thanks,
Fei.

> 
> Alex Bennée (1):
>   tb-stats: reset the tracked TBs on a tb_flush
> 
> Fei Wu (5):
>   accel/tcg: remove CONFIG_PROFILER
>   accel/tcg: add jit stats to TBStatistics
>   debug: add -d tb_stats to control TBStatistics
>   tb-stats: dump hot TBs at the end of the execution
>   docs: add tb-stats how to
> 
> Vanderson M. do Rosario (4):
>   accel/tcg: introduce TBStatistics structure
>   accel: collecting TB execution count
>   monitor: adding tb_stats hmp command
>   tb-stats: Adding info [tb-list|tb] commands to HMP (WIP)
> 
>  MAINTAINERS                   |   1 +
>  accel/tcg/cpu-exec.c          |   6 +
>  accel/tcg/meson.build         |   1 +
>  accel/tcg/monitor.c           | 184 +++++++++++++++--
>  accel/tcg/tb-context.h        |   1 +
>  accel/tcg/tb-hash.h           |   7 +
>  accel/tcg/tb-maint.c          |  20 ++
>  accel/tcg/tb-stats.c          | 365 ++++++++++++++++++++++++++++++++++
>  accel/tcg/tcg-accel-ops.c     |  10 -
>  accel/tcg/tcg-runtime.c       |   1 +
>  accel/tcg/translate-all.c     | 110 ++++++----
>  accel/tcg/translator.c        |  30 +++
>  disas/disas.c                 |   2 +
>  docs/devel/tcg-tbstats.rst    |  97 +++++++++
>  hmp-commands-info.hx          |  31 +--
>  hmp-commands.hx               |  16 ++
>  include/exec/exec-all.h       |   3 +
>  include/exec/gen-icount.h     |   1 +
>  include/exec/tb-stats-dump.h  |  21 ++
>  include/exec/tb-stats-flags.h |  29 +++
>  include/exec/tb-stats.h       | 130 ++++++++++++
>  include/monitor/hmp.h         |   3 +
>  include/qemu/log.h            |   1 +
>  include/qemu/timer.h          |   9 -
>  include/tcg/tcg.h             |  26 +--
>  linux-user/exit.c             |   2 +
>  meson.build                   |   2 -
>  meson_options.txt             |   2 -
>  qapi/machine.json             |  18 --
>  scripts/meson-buildoptions.sh |   3 -
>  softmmu/runstate.c            |  11 +-
>  stubs/meson.build             |   1 +
>  stubs/tb-stats.c              |  36 ++++
>  tcg/tcg.c                     | 237 +++-------------------
>  tests/qtest/qmp-cmd-test.c    |   3 -
>  util/log.c                    |  26 +++
>  36 files changed, 1093 insertions(+), 353 deletions(-)
>  create mode 100644 accel/tcg/tb-stats.c
>  create mode 100644 docs/devel/tcg-tbstats.rst
>  create mode 100644 include/exec/tb-stats-dump.h
>  create mode 100644 include/exec/tb-stats-flags.h
>  create mode 100644 include/exec/tb-stats.h
>  create mode 100644 stubs/tb-stats.c
> 


