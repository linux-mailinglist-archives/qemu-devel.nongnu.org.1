Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E1E7324AC
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 03:34:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9yKw-00042P-5f; Thu, 15 Jun 2023 21:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q9yKq-000423-Kn
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 21:33:08 -0400
Received: from mga05.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q9yKn-0000FH-SJ
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 21:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686879185; x=1718415185;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=sEDcYc2vov3TOjb7932A42BytANj09+hTu1XMoaEmh4=;
 b=eRpELeoWDeAtGigbWoxUWygrmOZhrX+cepfSboSJKiU6zOy1eKEl7JQQ
 C8qYsUjjI6hcdY5LvSz7DZXWy+8KVdiL9ILU+ETtPwxDbo2d819ge+vWQ
 7UOiSpgzOw7mBHiGk3FkcEB060cs7M6D0cqGhNbZYFOTivJLCE1ETToM5
 B3kZKkrX9CHdQug1uC2oAEaq+O1Z66LmeGtUFHy5cIqnomkuX/kXNsoFB
 cADnRK2vKW+NF2iFuZuP7pQsTXVH6RZgvV9pP5haVldKnq6kb4wa/SqD7
 hZNK03gzKa6v4W38kOAN9EJ8nGYTy81KS+UzopFbgo3XUZ6qKELKVD5oS g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="445468415"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; d="scan'208";a="445468415"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2023 18:32:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="706890770"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; d="scan'208";a="706890770"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga007.jf.intel.com with ESMTP; 15 Jun 2023 18:32:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 18:32:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 18:32:56 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 18:32:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ott9NOwTfciZVAD2YqoZO6GYb944QR3By/ckWJEBx0zRVvyBplV/KAxSwfUkNNNg6ebRoHqtnUd37yyTdz07wyUN6ixznVLbrCi+Sf2RYABCRg0XUpl1bL45XLMIVKQsmYSphS5GwvSous9rNKbt1ne8Kyy2rMdeiLOjckoSU5vczIIG3xHyX9uWHNfqNRxdYO1ZihX+2C9b7GkoIJf99aPZEWMHFbNE4AudXOAzPQNYY2wo1GZAK/Sw64+w5qCvHbMq/n0j3aurnXtR19Q/0SfxUYHn5Byn3j7Ue7F8IHLpFf0uhRPBV0GLBHy7M0Ud5Nub9juKw8XbucO9wJ3N2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OwIVo0sEB/+gZSitbGzodi3ectbYVUIPd+T+YpcPMQ=;
 b=CH8k2phnBLqQYbEq/ipVmEebq7+q8MkHGRSAbe00Rbd9cKPZz34v3LTPZtKvuuesLPIlu5neoG5K808mlUB36wld85gKxS0ALl1Z8q4BGgXRXaFk3IGa1gotgplBvYIAjyoX0XjcVOQSp6rXTv8yHDre1BswJVRXOQzqh1aisWKoTtLuVIFxSP0F8nILoFXQ9NT+DzAIr6f3oBqk2A3TiTvN8kfT9HbbP3yDpVRPjF09mEwPAlBo4nA1HYtQTb617zv+KNpTv5N/eQ4C8KOLnL6srD52/VM8Lc9lJM3ZpPWq53fT8UzW1u1eIwxtr/HC/rrYcmn1Xw84KTGK5EBr/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by CH0PR11MB5428.namprd11.prod.outlook.com (2603:10b6:610:d3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 01:32:54 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 01:32:54 +0000
Message-ID: <232662cb-128e-77f8-8359-add8aeafb544@intel.com>
Date: Fri, 16 Jun 2023 09:32:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v15 00/10] TCG code quality tracking
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
To: <richard.henderson@linaro.org>, <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>
References: <20230607122411.3394702-1-fei2.wu@intel.com>
 <4a1515be-909f-d2a6-3020-f952c0301008@intel.com>
In-Reply-To: <4a1515be-909f-d2a6-3020-f952c0301008@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|CH0PR11MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: d633deda-4906-4feb-96f0-08db6e099b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 85DREQdOo3NmKiTS3/Ao9ea7uxN3TOeIJiO6+FyTGEmnOBJSfyX/lY63SQ2TdCEI8hJdA0S0SDy/JpxxX9eqIoQ5TToZPAaACh9Rl8LRP8ZdGa8Fz9iL01AHnf8YfWv2As6VfVBEm0FJrPW10OSnXis/tnnE105hGlEwYOBdY+i0EmXuZtAa8+xgyUO1iTmYjpJl7zFtQGdNJhq+nU9eZAjFW3XGzA+Tzd+5UxLc1kqIQukaruBZlgN+3XIF6ZSQWC6gWL4AdwvI27NpOoXAHLLadDVlk/VHGqCEdtjx5JNV9ly5HVZk4gGJ5fsWMi57nGLrnJZAttl+p5V4cdqWRVf7L/taHHC05rEeqFnt5y0ODJUXLPk5R3DraXg0qMMxfVpKM0NsZ/TojAubMIzUY87Qv3HIJIkiZCtbsMKVf6fpcFLr9CsvBTEmWpGo5zZNVYltpBJqJ7ZOHe+Y8BVAzc6e76DLvxHjONt0Qrtt/f+ftuHJAg5/xcLEzsecS7wDjtsj1yAkVF5743NLnZEzKLxrKHMfmOLZLu/dIs5M93FLmPJ8r7aYRAfkhAeXtvlCtXEZrIaDHMqnbLwzOPvbDydcpzHhmfbNE19nN2W6p/YrCJf5/5S+dphkEC1WANSezwbqCnoNOT9pWsoXn53rNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199021)(26005)(186003)(6506007)(6666004)(478600001)(53546011)(6512007)(31696002)(86362001)(6486002)(31686004)(66476007)(66556008)(66946007)(316002)(2906002)(8936002)(8676002)(5660300002)(82960400001)(38100700002)(2616005)(41300700001)(36756003)(66574015)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M056aWdINDVIYjh1VFdZbUM1alVxZzRwdTVKayt3M0I1UHh2RXZPUVVDUGV1?=
 =?utf-8?B?YUtFaXE5aGZKNzY1ZE1EZktPQnVMYTRMNnIva1VjZ2JGcVVEV04rNUV6aFFB?=
 =?utf-8?B?cVZnUXNTc2dUTmUxSDR3Q1BuZ09HRlBLSzk2Qy8rVER4VHNZSGZ4TVRSMmhv?=
 =?utf-8?B?VjR4YnRJcnRRYTFXYUtoYVRIc2hleit1U2pJRzAwbkR6V1RVS241TkM4MGs1?=
 =?utf-8?B?SkEzbVhod0tKZUlMMU80b0U2RWhmYmNUSFUxNEwxVmZ4Zit5ZUk4cXR3QWRm?=
 =?utf-8?B?RUNiY0h3YlBHaTJMcEtSdlBwNUZPOW5sNmtMTWlacWVGU1lUOXFpZ2hWb1g3?=
 =?utf-8?B?ZUNIT1dkejh1WmFpVXlXbzBYOWtCT2FpQkF4ZlpxRnZFQUVzcW12ay9GSi9S?=
 =?utf-8?B?TStLSUdvTWlPVi9FVjErMFdPRG1QQ3BORytOMGRLajRZUTNjN0xIeklWRVBO?=
 =?utf-8?B?d3p5VnozNkRubWltT084RC95cXVweEJRUWU5Y00wNkRDcE04SGsyNVNpQWZ6?=
 =?utf-8?B?Tm5QQ0lZdENVZnM5czhHbU0yZTBXdHE4RjdiTCtuQXF2VjlubEg2TVpYa0RU?=
 =?utf-8?B?R0ZpWWVsSzN6R2k5VER4S1grWldUM2ljdTczc2IxRFNXUUltQXBRVmZGTTY0?=
 =?utf-8?B?aDA2MllXU00rMXVaV3dtTVhkUlNhWC9vaWxSWCtOMzgrWWRHTE1qUitlT0oz?=
 =?utf-8?B?bVM2dEp0b1JlU1dKY2tZSTlWNHZWalYvRHM0VkJIZk1PSUpoYlVXc1pHVlRY?=
 =?utf-8?B?Ni9QOTJZM0dXWmRscjBmb1BHcEpSWXNnby9URmljanNZQjdwa3pST3A3aTBs?=
 =?utf-8?B?TkkvcHVFNjlCSmRTRDdjSDJlV0V1dEQ5MkpZaDVobVdjaGxWL0tya2tRZGtZ?=
 =?utf-8?B?NmpGTGlhRnVyWUxsVDFUMy9QRlB0NHBHUTdWaFlwYVZZbFJ5MHAxSDJNQXVv?=
 =?utf-8?B?NW9USFBOUmRwYjFLZDZYbFlpbnMxdlNKS0pQUlJSaVhYREgrTGdQZTF4bUVw?=
 =?utf-8?B?UkpEbnptWmhvOCtzWld2RTJKUm1zL1FUK1BHZldZeFppaElseDZvb3lCaHhR?=
 =?utf-8?B?YUpZMHREMTdLNlRHSXBYVW13ZDBLMUhCbVBPaFNUcjFmSFlVbktKTk1JL2ZZ?=
 =?utf-8?B?MVNEQ1VqY0tPYUJ6VWxVWXVucEFGeFVhM2tnUVhrUE0yRlV5bVlsZ01sbytM?=
 =?utf-8?B?NkFPbGlndjFIK1M3QUhIYjlWRWZXb0t1VktuUis4WWk3aUpWekg1ZmpxeUdZ?=
 =?utf-8?B?MmxyeDRDemRjV0lhK1dLM21QK1BUWmlzK1l5WWtKNnF6NUFhUlFtR3pNaFhV?=
 =?utf-8?B?MUVwalRZUlg5U1l3WHRCMDFLcWkwSmx0YmY0NHRGWWM1b3czQ3FsZVZFeFI3?=
 =?utf-8?B?T3V1RW1wSGl5RVlXOHJGZDJ0WCtaUmlQMGw4SHV5b0ZMS0txWmI3cUxtQjJX?=
 =?utf-8?B?LysxdEtHZTl2NkEzMDhwOTdQRVBoNE1EWmdoV0FmUXRubGJqT2p6SUQwSmI0?=
 =?utf-8?B?ZitrZ1lzaDB1OGtCSDBSSERmMGdkdFFBQ3BPWndLNWR3UXY0UWlTTCtJUzNF?=
 =?utf-8?B?SmRYUjcxMG80RmdUbzhlZ0lpTjI3YlNiOENFM1ZBZFJXMVRDTnRHczdYMjVC?=
 =?utf-8?B?OFN4M1dIMHl0Q2FHd1lYb1ZZMzNBbzhLdGttVk5PN3VuTjlHSjgvOU9mNWtR?=
 =?utf-8?B?WUhsNnBwczhUZTlxa1M4Vmg4enA0dGJ2WHNaMWlQYnZISVVJQmdaYzRsRVBs?=
 =?utf-8?B?RmFYZnRQb2Y1NmpLdGRhckE3ZUlyOVhvVmtWZlVDVXlDYnpkaFZxU0dqcHZY?=
 =?utf-8?B?Tk0vcGlOcjJEMDQ2SWJ6bG1QM09oelhFRXZWL0RkZktVSi9YWXpZaTdTTVBs?=
 =?utf-8?B?VWl5bVFQazNGangvU2Z1Zjd3aUxEZ3ZYQTVBb3FIYis0MlVpNXM0T3NGOEJY?=
 =?utf-8?B?bmc2Rlh2UTdEemUvSCtaVVkrZ2NJVFY5WEZCd3QrWEdKcHZGMHVaaDVUODh3?=
 =?utf-8?B?VDI5VzlpOFU3czhveGFHSW00a2dGb1ZTYlNOQTZJRXFQaE1XVUM0T2d4ZXlY?=
 =?utf-8?B?TlBLR083d3kwVUJIOVpKa3VENElFWGI5QW9SSzJoN0FFVUxwcjl5d0JTK3RE?=
 =?utf-8?Q?rOG3B+NCtnEgLmUrO0xZ7oeze?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d633deda-4906-4feb-96f0-08db6e099b15
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 01:32:54.1936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 062v/+ld1JNd89gLHa1tdQvskMkUhXX2rkK1+8Mky6TBpluLyCp2yDkTTP+qbsIWoQjSjQ3UWRGyJp4Fj2/0zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5428
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.43; envelope-from=fei2.wu@intel.com;
 helo=mga05.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.098, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 6/13/2023 11:29 AM, Wu, Fei wrote:
> On 6/7/2023 8:24 PM, Fei Wu wrote:
>> v15
>> ---
>> This is a large change:
>> * remove all time related stuffs, including cmd 'info profile'
>> * remove the per-TB flag, use global flag instead
>> * remove tb_stats pause/filter, but add status
>> * remove qemu_log changes, and use monitor_printf
>> * use array instead of list for sorting
>> * remove async_safe_run_on_cpu for cmd info tb-list & tb
>> * use monitor_disas instead of regenerate TB, but **doesn't work yet**
>> * other cleanups
>>
> Hi Richard,
> 
> Could you please take a look at this series? I hope most of the comments
> on v14 have been addressed.
> 
> Next revision I will change:
> * add async_safe_run_on_cpu back in case of any concurrency issue
> * add tbs->gpa_pc for monitor_disas, which requires
> get_page_addr_code_hostp() return both ram_addr_t and gpa
> * finalize the commit logs and documents
> 
Should I send the new revision with these changes, or you take a look
first then I address all of them together?

Thanks,
Fei.

> Thanks,
> Fei.
> 
>>
>> Alex Bennée (1):
>>   tb-stats: reset the tracked TBs on a tb_flush
>>
>> Fei Wu (5):
>>   accel/tcg: remove CONFIG_PROFILER
>>   accel/tcg: add jit stats to TBStatistics
>>   debug: add -d tb_stats to control TBStatistics
>>   tb-stats: dump hot TBs at the end of the execution
>>   docs: add tb-stats how to
>>
>> Vanderson M. do Rosario (4):
>>   accel/tcg: introduce TBStatistics structure
>>   accel: collecting TB execution count
>>   monitor: adding tb_stats hmp command
>>   tb-stats: Adding info [tb-list|tb] commands to HMP (WIP)
>>
>>  MAINTAINERS                   |   1 +
>>  accel/tcg/cpu-exec.c          |   6 +
>>  accel/tcg/meson.build         |   1 +
>>  accel/tcg/monitor.c           | 184 +++++++++++++++--
>>  accel/tcg/tb-context.h        |   1 +
>>  accel/tcg/tb-hash.h           |   7 +
>>  accel/tcg/tb-maint.c          |  20 ++
>>  accel/tcg/tb-stats.c          | 365 ++++++++++++++++++++++++++++++++++
>>  accel/tcg/tcg-accel-ops.c     |  10 -
>>  accel/tcg/tcg-runtime.c       |   1 +
>>  accel/tcg/translate-all.c     | 110 ++++++----
>>  accel/tcg/translator.c        |  30 +++
>>  disas/disas.c                 |   2 +
>>  docs/devel/tcg-tbstats.rst    |  97 +++++++++
>>  hmp-commands-info.hx          |  31 +--
>>  hmp-commands.hx               |  16 ++
>>  include/exec/exec-all.h       |   3 +
>>  include/exec/gen-icount.h     |   1 +
>>  include/exec/tb-stats-dump.h  |  21 ++
>>  include/exec/tb-stats-flags.h |  29 +++
>>  include/exec/tb-stats.h       | 130 ++++++++++++
>>  include/monitor/hmp.h         |   3 +
>>  include/qemu/log.h            |   1 +
>>  include/qemu/timer.h          |   9 -
>>  include/tcg/tcg.h             |  26 +--
>>  linux-user/exit.c             |   2 +
>>  meson.build                   |   2 -
>>  meson_options.txt             |   2 -
>>  qapi/machine.json             |  18 --
>>  scripts/meson-buildoptions.sh |   3 -
>>  softmmu/runstate.c            |  11 +-
>>  stubs/meson.build             |   1 +
>>  stubs/tb-stats.c              |  36 ++++
>>  tcg/tcg.c                     | 237 +++-------------------
>>  tests/qtest/qmp-cmd-test.c    |   3 -
>>  util/log.c                    |  26 +++
>>  36 files changed, 1093 insertions(+), 353 deletions(-)
>>  create mode 100644 accel/tcg/tb-stats.c
>>  create mode 100644 docs/devel/tcg-tbstats.rst
>>  create mode 100644 include/exec/tb-stats-dump.h
>>  create mode 100644 include/exec/tb-stats-flags.h
>>  create mode 100644 include/exec/tb-stats.h
>>  create mode 100644 stubs/tb-stats.c
>>
> 


