Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF7F745AEB
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 13:22:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGHdO-0000mi-Sf; Mon, 03 Jul 2023 07:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1qGHdL-0000bs-Re
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 07:22:19 -0400
Received: from mga02.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1qGHdD-0000ti-7i
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 07:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688383331; x=1719919331;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=NbTag6UotCxZjUJvW1KO9GT83BsnDBBc12IFl2uBfO4=;
 b=Kt/8MbhwDzQhTeDEkoHcADvALko9zwidEl3uKA2tLVdWhprj6FtkCOn3
 00P6B+RfIVQFBHAskJYBdjDvfTPsWSpFCrRN22RSYYL3tI/CgWmNa5YaG
 Bkk43Iu9iruIvIwPgbSKbKMm1n4N0GkqfdhVl8YkM6zBdMC8IaN83RmMF
 jCbY6Q0/RfXYiKtKUSZOJX3C30lATajmGHVQRhppijBmAgSjpQ1IsnHLk
 /cliNQ6PmZOF8bkVTwyTaKQvZ+wdKWlB+FnrWIaUPLDHU8OyaYVQSzUDn
 lFaboL2+sJ4XhWwjng87hvBCJN+rsWQO3hFOvNDMxstd/YVUx1JHjo6JB w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="352681318"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; d="scan'208";a="352681318"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2023 04:22:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="808539350"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; d="scan'208";a="808539350"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by FMSMGA003.fm.intel.com with ESMTP; 03 Jul 2023 04:22:07 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 04:22:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 04:22:06 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 04:22:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gtflb8VU9khJFHcBroRinxHqUJSs/xtZiu1fLz/MFxI9Q8Ab30dc0lK9KpLrwGDECBWAAlSPEU5W7BRLqTx9IRr4FqvJ2WZwOI5719d5OrBCOUnY8zfwl9vJxpCVZS6n3BcJuN+2PoFr4Z2Pa4RdBcxZkd3N1BjQZRzUxqtOo+HTHQX5P0mC4v48rxSh9e6pn6UHeRl4kXBNhRhXOnMQukUFMs4FBFoJ0Y5/wITUsHNSlzBxKWxklq4CyGFkzBDh+/DH1bxsbiT+VSePUUEzVEZuFBZxgQNNQ7oaVeejaAIh8lsNAi/1yy9u0Qe7z3AclJwY5BQjBws+xAJwQrN3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3y+2EBZgWDncqKTsCzkY2QN+O7iildW70ZnsUPIAlF4=;
 b=C+O7J7wxs3OsmJegtJ0yY1t3HrMineYsWOvWWWJ0Ch6WglV8Nn3dXMR0zYYhtZrWxAJchzmCrRSFaHPKTJLobpsRDVuXOUnWztnD52OPJfsqa1/HZqkS1gwy22hcK1cZawGcpqoDwKrNtqTGV1AnNxrAN3q14dRBHRQGeLZK/2Ay3J5sOFcPfLRUsfFsSEmvmwtjmEDJVR5lspIDXtCqmKy0DOx+g8lyVbUTsjMx1U3D34Mm/tkXtp/TpzfmNIri5mxrHvIaesz/xTttoCNEJqhi7ETIolay5AjKoXbHGKPBwswJuCJoSwDQ3N7MiySO+Mi7qeXR13vLIkarssOgUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by MW4PR11MB6864.namprd11.prod.outlook.com (2603:10b6:303:21b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 11:22:03 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::ac3:4112:114:5b45]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::ac3:4112:114:5b45%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 11:22:03 +0000
Message-ID: <f1309dab-845e-3555-fb61-6b0f81406896@intel.com>
Date: Mon, 3 Jul 2023 19:21:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v16 0/9] TCG code quality tracking
Content-Language: en-US
To: <richard.henderson@linaro.org>, <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>
References: <20230628120430.73777-1-fei2.wu@intel.com>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <20230628120430.73777-1-fei2.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0089.apcprd02.prod.outlook.com
 (2603:1096:4:90::29) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|MW4PR11MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: ced4bcf1-fe1a-47fa-7533-08db7bb7b99b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: npFrbXpcNPvY9cobEnEk/jHzIaNFRDxponujm8Hd/zeg7BxMbf7VLUrUiU1MWFzTIW5oWIo/cJXY/hGvpf2jD2Xke321Kl+idx9tveD76aDTToP61LMhOz+U0cs9ub9QQZSrudG3WCEYmq1j/e18bZvINnosU3ftt00hEMxc2L7/82HTxhJMHozSaXjwsUGf+94IqwgWgdEssTG+m3ktmx23Y6gv2WyIEQQBuihPeoL8jC9j9Xc9IJBgjg2o0c5ZrLyA/hIN6TDqHY0ABEUJDvZQeDxEA7tSBdshy7zWSj68Q/5HouRjHR3sUSbx4Hn7b9f0Q3ldG0P1+7KTx93OiV1esvfOb/IzOsHhmxqmjP+8fuGiWob1JdboMAsUC3AzqPOomSUXHA6J6aTcHhej8h20Oos7E+2GuE6e2Lz2JZ6pAxyHdXjxDaB6G4PhAU5BF0HF/uLB7NcqLKiRLvngcVpj0Ja6Zz2rWV+GZZgRuqNvcbkhLbiICE5SLfVf+RPqOmkHrA9TwEou7mHQiJbu4aQcJGaTFJDgQB8BJbmkBIsRbP6+CULYnb3LTVE4VEi6n9gcEB7lLJDSO2aAxKdLp/eQqECvE2e7CnIgsG/kpvGsELsl/cPqTVJVz7z4t81oW8I5obMfd6k3wWhcG+J0AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(31686004)(66476007)(66556008)(66946007)(316002)(478600001)(2906002)(36756003)(8936002)(8676002)(5660300002)(41300700001)(31696002)(6512007)(86362001)(6666004)(6486002)(38100700002)(53546011)(6506007)(26005)(186003)(66574015)(82960400001)(2616005)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3kxNnh5VllyL0N2SUUwTHJzRWRvL041OUF5clE1WTZWMGVIM1I0VVFZd0pW?=
 =?utf-8?B?Nmo0N1pBbnk4MlNLbkwyUHVlay8xUkhVaFNIUEZKV0YwSHJLTkhGRUNZRm5i?=
 =?utf-8?B?WWwzeUxzMWdsV0ZPdWNlc0VoVDZOck1TdjJ2b2NmSklNTTlEUTlIcWxaajIx?=
 =?utf-8?B?bG5qQ28weHdZeEdTSjRPYXpYWU1KdS9HNk11a2hwVXV2dFBlakRIQWdwQWxh?=
 =?utf-8?B?dUFKRlBKeW1zVDNxV3RHZ3FRcS9BY0lQcFphbW9WaTRGeVJoK2wxbDgzTkxY?=
 =?utf-8?B?Rms2d1kxaTdaT01aVG5zSkFMMXFBblppWk9vRXFpMnc5ZkUxWGpkeVhBMi91?=
 =?utf-8?B?anVoalBXcXNoeWdPRUNEdE05aDRJbW1iV1JmK2JjKy9zRmlyU1pyY1NjTnpE?=
 =?utf-8?B?VEtzVFBEanBFbVFTcWVSRXpIbVBzcXZseUtlRUZtZHRwajlscE50aUJwSkd6?=
 =?utf-8?B?dStja2RDRUFaYjJlOThScWZXK21oVlhkclZmT0RzbHVNazBzc2FDTlZaRDB5?=
 =?utf-8?B?czZram9va1VIWXhVaGx3bHdveSt3czU2bzJYU0NFSFgrdFBBU3V5LzVMWFhX?=
 =?utf-8?B?Q3p3WFVHeDFnL21CUlpWUVdoczdoZ2VjQ3c5SUJCVnFmcUJhc0t4ZWkwazJw?=
 =?utf-8?B?L2N3SzVESGs3U2JYc2lUcjF4ZUhsM1puZlVZRUJyc21UWlJoVlJCYk5ZQS9u?=
 =?utf-8?B?TERLc3V5V1hvN3VXZGxZaCthTnpzWGhLcFFSNlpxZHBmRHU0S0JmR1lPODdN?=
 =?utf-8?B?VCtLYU94RFlLcFF2NS82NWMyY3QzUDhtRktmMnhDM1h5WkR1cG5HMnpmYktX?=
 =?utf-8?B?MXRBMm1sNWE4YzYrRkszTjFXaWkyZ09ZSlZKVzVMK3UxYUY4U2d1MmFnUWgz?=
 =?utf-8?B?Ry9QcThGTjhFTlRnV001Y0hvenhka0hGTkFHaTVZVmJFanpUZlZPZ1IrNjh5?=
 =?utf-8?B?alBseHRsbzRmRHBScldIZit6cTZYMlJQZ2Y0UHNiMFc3VGlzejRuMGZCRnZq?=
 =?utf-8?B?THJETGxOYU1nNE9yL3NjNHdTemRoSG1iU3JVRHlKYWVINkhwN0ZaTFRxOGt2?=
 =?utf-8?B?aWpTeFJYTWk2OHNCbUdNeHNHWnJ3U3Y0aWV3bFFsY3U2SEdEc3EwWWlHZFJM?=
 =?utf-8?B?K0o3bms3NXEvTVlyNVZJY2htYmh4ZCtzNWI4TS9zRFBueEZpbGJiak9OdXJs?=
 =?utf-8?B?L1RpTldQSEhhcnhTbmQwQUdkcG1XemxDNFlienROSmRxWGFGRGJTNlY2bllh?=
 =?utf-8?B?MDYrMkVNZ1VwSmx5RS9PcjVLakwycXd0TVoyaGJyU3A4M25mRlAzUC80bHp2?=
 =?utf-8?B?VEIwbDNySW9uOWRWK051QnltdVZ4akRyQXBkaW93dmFYa1B4MTJSeHZCSEFn?=
 =?utf-8?B?TUszdUozOFgxbE8xNzBoL1JPUENqZmczSFYvYkJWbW9QaXVsc0FKa1BBMWtG?=
 =?utf-8?B?clZQQU0weVF4emxFL2Nxa3FoV05JWkViM2g3MllUV2pUSWkwcHlmOTVEeXVE?=
 =?utf-8?B?SDNjdFFmNHRSR1dTNnNlbnU4ZHVEeFJZZVhCTjNXdjdRVFdvSm1YWU9ySXZP?=
 =?utf-8?B?eExsWnVkUVY5OXM5WmZFRnJCOEpxVUZ2dU1tOXpZbTJPbm0zaElyQTdJQjZC?=
 =?utf-8?B?a3hxcXVlc1hKcm9NV2VzelFudE1DR2loaEhqOFhtZjN3YzNoZjd3cHhaazl1?=
 =?utf-8?B?NUR6bjUyV3YydzZ6Y1V1TFUyeVhha2JJMDdUOFAxems5eVlONTlYb0lkaUxX?=
 =?utf-8?B?a2p4KzNkR1ZwSjBOZXhDcWhMSldUNGZKTnNPamhlM1FUTW1LOEtweCtnaFZl?=
 =?utf-8?B?d3JqR3JPSDdXbDNUdlA3NXl1c0wrcHBhSk12cjQxd0xYcUFES3NkeHVHaHZx?=
 =?utf-8?B?V29BeFNDL2hUeE9sMnB2QWl6TUJ3dkNXNzd1dGdTYWV0MVYrRHZlcDFTWlZp?=
 =?utf-8?B?SGNMa3BuL0NFaWhTVXJqUG5ya0ordkFPQWZOOGNMMlpWTmkzNGpEN3U0bFcr?=
 =?utf-8?B?M3JTOHlOV1c4YzFBNlhabFQvRkduTEFUT2NmbllvaXU1aUpmbjJNUkFGNzZa?=
 =?utf-8?B?bE8rdDVHWGZ1allQRlpNckJkMndkSHplUVNGb0VmK1lMdnd2YjhuN0hMMTRN?=
 =?utf-8?Q?i/FmGDe3pr0nhRn4nGNOXmziy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ced4bcf1-fe1a-47fa-7533-08db7bb7b99b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 11:22:02.9963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XheMU/aHiV/L1ECaUFglDb8sUw5QZKRfgb1U8MngNIwzQoAwn5QaFEqdJKh88Kw0XMYxGIHR3u0A0Aatuv109g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6864
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20; envelope-from=fei2.wu@intel.com;
 helo=mga02.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
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

On 6/28/2023 8:04 PM, Fei Wu wrote:
> v16
> --
> * rebase to latest commit 4329d049d (Jun 26)
> * original patch 1 (remove CONFIG_PROFILER) has already upstreamed so is
>   removed from here

Hi Richard,

As CONFIG_PROFILER has been removed in upstream, could you please take a
look again at this revision?

Thanks,
Fei.

> * add async_safe_run_on_cpu back for info tb-list/tb
> * add ram_addr support to monitor_disas and use it to disassemble guest code
> * update the commit logs and documents
> * small change to do_hmp_tbstats_safe() to avoid memory leaking
> 
> 
> Alex Bennée (1):
>   tb-stats: reset the tracked TBs on a tb_flush
> 
> Fei Wu (4):
>   accel/tcg: add jit stats to TBStatistics
>   debug: add -d tb_stats to control TBStatistics
>   tb-stats: dump hot TBs at the end of the execution
>   docs: add tb-stats how to
> 
> Vanderson M. do Rosario (4):
>   accel/tcg: introduce TBStatistics structure
>   accel: collecting TB execution count
>   monitor: adding tb_stats hmp command
>   tb-stats: Adding info [tb-list|tb] commands to HMP
> 
>  MAINTAINERS                      |   1 +
>  accel/tcg/cpu-exec.c             |   6 +
>  accel/tcg/meson.build            |   1 +
>  accel/tcg/monitor.c              | 216 ++++++++++++++++++
>  accel/tcg/tb-context.h           |   1 +
>  accel/tcg/tb-hash.h              |   7 +
>  accel/tcg/tb-maint.c             |  20 ++
>  accel/tcg/tb-stats.c             | 366 +++++++++++++++++++++++++++++++
>  accel/tcg/tcg-runtime.c          |   1 +
>  accel/tcg/translate-all.c        |  77 ++++++-
>  accel/tcg/translator.c           |  31 +++
>  disas/disas-mon.c                |  15 +-
>  disas/disas.c                    |   2 +
>  docs/devel/index-tcg.rst         |   1 +
>  docs/devel/tcg-tbstats.rst       | 126 +++++++++++
>  hmp-commands-info.hx             |  16 ++
>  hmp-commands.hx                  |  16 ++
>  include/disas/disas.h            |   8 +-
>  include/exec/tb-stats-dump.h     |  21 ++
>  include/exec/tb-stats-flags.h    |  29 +++
>  include/exec/tb-stats.h          | 130 +++++++++++
>  include/exec/translation-block.h |   3 +
>  include/monitor/hmp.h            |   3 +
>  include/qemu/log.h               |   1 +
>  include/tcg/tcg-temp-internal.h  |   2 +
>  include/tcg/tcg.h                |  10 +
>  linux-user/exit.c                |   2 +
>  monitor/hmp-cmds-target.c        |   3 +-
>  softmmu/runstate.c               |   2 +
>  stubs/meson.build                |   1 +
>  stubs/tb-stats.c                 |  36 +++
>  tcg/tcg.c                        |  47 +++-
>  util/log.c                       |  26 +++
>  33 files changed, 1217 insertions(+), 10 deletions(-)
>  create mode 100644 accel/tcg/tb-stats.c
>  create mode 100644 docs/devel/tcg-tbstats.rst
>  create mode 100644 include/exec/tb-stats-dump.h
>  create mode 100644 include/exec/tb-stats-flags.h
>  create mode 100644 include/exec/tb-stats.h
>  create mode 100644 stubs/tb-stats.c
> 


