Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6754072C27A
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 13:06:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8fMG-0007Zb-Rg; Mon, 12 Jun 2023 07:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q8fMA-0007Z4-G2
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:05:06 -0400
Received: from mga02.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q8fM7-0000QP-K4
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686567903; x=1718103903;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=HBk2wljYnUP009eUdDb8aOKJG3CJWo24yEdKo+58xHY=;
 b=e0OXx/s0cHjpvtRU9WaxpexE8EwEn1VhxSU0DqpQhNGlzrblghtgl3Oq
 k088WMmUcQRsAe65zbr7D3IQu0d7+VTneNZqPExSSQNTPUoy2bs5Qyo/1
 GECXtpJ2hRz6TvQojuAYZnJFYVxjLiPMsNgwd2OUE+oDIAWKEylhrPNmg
 QrAYgIDJlQ0cNawpfwp8h/EN8J+NW4Y1SnKYQ7gybo0h4E5jcZGnWAl3K
 NxUDIc4Ejqu3AHyE9SKBK9hf2Cv8AqaAqDtSB5kEZKU1cX76IVc1kDS7I
 SO8fXb1/HVHsiM+HCyFJF8Ti/LjGavoMmKbm/85vhVE6JsYtLi3UMq0p9 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="347657345"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; d="scan'208";a="347657345"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2023 04:04:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="855578855"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; d="scan'208";a="855578855"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga001.fm.intel.com with ESMTP; 12 Jun 2023 04:04:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 04:04:49 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 04:04:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 04:04:48 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 04:04:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMEIsP8rj26jIn5Gu71u5zxaxgKyg049oDnHKuPysj9rSR15mgHj89DKQpdC1VvWO8JYsbyK//fsEgLFq6DDnn8u044L3gzzTQWGLGOr32cFeIuPG/RVyOo18X4CfEc54NT+Lvtxa5K0tVLRixrf3cfPnh1kWpgFbf2Q4zB6HOFuUCun0jeYrb5FgXjEKBiSJ2KdsZHrxf33eLr1uL5BIHktksFDgMTFzpLR7TwQMz+8LlZz/DOcCoez3qo040x9OZ0Pl5R82KJSvGwdkBKLbP6XYrGr7CzASpb2C2mesIuHbLl488qs17Ypph+uEGTzYZh1yr+vVSeruUk4zcWxqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUo/OhlW3yLif1y6jAHaB1uURaM3U6jeBEdAzmnLvA0=;
 b=CFvGeHltS2FsK/7mGa4r/+L9a8C2401/f3zDDc6CvaFI+ktbAlheTbTbGHYZEqHyIge2yGKu841HHccks0CES9fy9m5eXoMrKW6b303LE6LEcp/X+MObRijKkQDR1o+HGuXmPhw18G98g6lZQo0BWPKiCHnfXdm2Aewa0B3Hl3NrImMyyJEY2l5gK35hNQw/VvBrdBeq9SMNbsG/NGkH8Bd2aFwXqlKl+xHM4AFK/RmZCldKpTUlHTREHX36LeKCxqJPaIk8Zr+IB9BOPgtF8CSTVGYm3qtA6wU8Ys3pDvmJaxr6v+/Qr+0HB73YnmFZ8KMhzJggcRMN1MV+pN/dcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by SN7PR11MB7418.namprd11.prod.outlook.com (2603:10b6:806:344::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 11:04:46 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 11:04:46 +0000
Message-ID: <9e59c77c-4f7c-8693-5ace-15adb4d35968@intel.com>
Date: Mon, 12 Jun 2023 19:04:37 +0800
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
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|SN7PR11MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a27157-f1f3-4d1d-9795-08db6b34d4a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XGSf+A4KKKK1GC+Yt6VSaKK78cNQU/xWcOAHkp8O7qIN/vZ2ImeCmyqoC3MfBknF6Ueq9A/YRPMtx66mSIXShqK/icNLUmJwgd7yMmktV1OHTU37yyomf8rhXOb90dHFVh4nCE5yqYLhrM2gOXJ4JRWuG9YgkvlTJfy0NdgavU/XxaXHE6SXsTsRoDmuFh0N5wE/puUyQ1Ii0qvDOWYqMTiJhkQUu+nVdenMy2J7hfLf9CnYNXwbxPKwWnRAqxG+l0tedSWpXPlt7nIB//J5+pwvoB7WvIrO2tJhC9V4YwmOAcA2C0Dy5fuhWRSAGIPHVfB4rdLGxtmi5xA3hHm3E5qR0v3aR0LXphP4HBooZ1msB+NNZcxtprB2rYWYJmD40c6pdZ6bP0cgg0C+jwrZhoIAzLdG/jEnKrzRV/JTVCSXbZ9ryLzgNq6Oz3xZkXfuIbrv1smu2CWab+Svi2LxSj6WaO6giQneQkKDnyO8ZtSwV6KXO1AoGTSsB91Y4z2bj6KwT47i7pi+qM5qbhASHwadja/iTfkOm5R0WH9s2iw42ySqCxzAxawdNx3cpp1xdAAi56rTO4ke0npTByUvX4EKp54Acv8c9NtrLQW/NIdk3X7H2VLhx/0lBSqUpTGkPwM1FxxNigZLvLZkBPGeHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199021)(31686004)(66556008)(66476007)(66946007)(316002)(6666004)(478600001)(31696002)(86362001)(36756003)(66574015)(6506007)(26005)(53546011)(6512007)(186003)(83380400001)(41300700001)(8936002)(8676002)(5660300002)(2906002)(6486002)(82960400001)(2616005)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkIzUEI3R3pQT05vSDVaaE0zY0xQb2prcERPS0xMNFByTllhN2RwcWFjMTFL?=
 =?utf-8?B?TmM2eU9RSW9kU0IzaXdYTGs0RXdmaSt5amhKK0pyTm9PeDdIMjJjZFl2Y1Rk?=
 =?utf-8?B?K2ZuT3Z2aHRjZ3VxcUYyV0V6dXFEdnVONFIyZTduZ241ZnRlWmw1eTQxVVZt?=
 =?utf-8?B?blBZb2F5ZThHaUxTN1YzVjNDb3hDSUQvM2RpVThHWG94YzVLZ2VveUN1cGtG?=
 =?utf-8?B?MkRtTjVzSDc5UUxHY040TzhqVEdKTEZMdkFISjZzVlBXRThrWkxPSEt4MVRw?=
 =?utf-8?B?Vk5qN0JBVEkrb1dpeHlhK2FiNFJBUkJMVk1rejBrd3RzQmlnTndkc3VWeWl3?=
 =?utf-8?B?OWdhTFJQUTZLUUNSQUxVYS9hVUhtelVHRDlFdjhpNDNVRVlxRE5qR3o4WWxp?=
 =?utf-8?B?OURvQzNlSFhRRWRaY1N3aVRaUmJ5Q3Y1NWcyN3pzZ1Q5aXNPV2E1aTFGa2Rq?=
 =?utf-8?B?NExWUVZYQTZrNzRyNFZYQjNwU2FVV3VuNm1PbERJMVZLUDBGWmxiblZkaktT?=
 =?utf-8?B?Z2NMZ0FhNTdsZWRwYzdjUWQ0V3ovNiszU2tBRTUyK0JGL0pCMk1JSFlDblBt?=
 =?utf-8?B?TWxDaXFMQnUrbUxydXRYVXBHSnB4ZG9kcjA0dmlqUFNZMGJHOXh5b0NNaGtI?=
 =?utf-8?B?bXVqL252dzhxRERpclNMTVVSRXN1eGdJUWNMcDVyT1ppQ0VqWjdieHJUMHVK?=
 =?utf-8?B?ZFV1RlVzR0VFS3ZHUDhCelpmSWhVQ0NOZ0tHZGFUeUlOVFAxbU1jT1VwdTA5?=
 =?utf-8?B?WFlqN2t2eTV0V1pPR200Z1gwMEtzbERyNGpIa1dkZURpQnlXQ29aaFlRbDhJ?=
 =?utf-8?B?bkttSTd2aWpaK0hSWEt1N3F3enFJbHNkMlJSNHI4Q09VSDhwbk1UUXorN0lL?=
 =?utf-8?B?MWVXT0lzdHNEeUZjaExKdlFLTkloRkU5aUZPRjBaQzJrQlJxYm1mc2VCWk1Z?=
 =?utf-8?B?eFJobVljMGkraVRqcnZCbmE4NjRQNlo2UkpuUzFJek5pMEJoSTNCOUYydTlF?=
 =?utf-8?B?RDdXSk5LMGdMR2VCaTB0RXMyaXF0VGs5d29FMnI5RER6c1ZyWEFYRzIrN3pu?=
 =?utf-8?B?UG5UNkx2S1NyZ2NKUUNaTUovYnRTZk11QW5MelFwczhmSk42d1NCSzVHOEd1?=
 =?utf-8?B?ZWZsZGV6Y0JwbWdXUkpraW5HNThCbnpxNjRpc2dEL0hYSmhZV3VGZjhuVnU2?=
 =?utf-8?B?bUNaRGlsMU0xbVpoK3FUT0ErWWhPa1hTZkxYSDdZZzFhQWgxcFZ1d2lobEdl?=
 =?utf-8?B?Vngxa1hyQzhiUjlyY1FwRk9iS25QSTJJeGlxTm1WMEVKa1N5QlFzVEkxYkVu?=
 =?utf-8?B?K285aCtyNERjS1FldkNoMWtYSHV4WEpLd2tBbU4yc08zV3NFN0p6OWphUklh?=
 =?utf-8?B?ZDRic3pCdWVLc1EwbHVTR2dmZ1ZFWkl1TkVMaW9BWXVZdHdtSmI5ZmZ1YXZ4?=
 =?utf-8?B?R1MyQXNuUlpWSzhuckowN0V1Q0R3NUVxS2dMalA4UkZzUGgyYkd3NVk2bjI1?=
 =?utf-8?B?Z3FraTYvaFg1bkxMR3FDemNVT2NLSnBFNE14K3NsUVRJMHVjS3dLcnNtSkk2?=
 =?utf-8?B?N28wQzdzWC8wY3BzWHdqSXh5NU84MEVwbXhUYzR0ME9VaXJkeVdiYUk0YVlt?=
 =?utf-8?B?UWp1Um5TMi9hU2RmNHlpNThoZEtid0RPOXl6QzdZUFBpM1BEQ0NEVHl3Wnhv?=
 =?utf-8?B?cldrQkN0Qy9uNTcwOEw0VkdIY0c4M1Q2US9KdExLRVZKbTQwcFNKWVBNeTNw?=
 =?utf-8?B?YmtpWFJJR1dwaU1JRys3SEQ0WTRwTTdacWZWNXd0Q3lrRjFWRm5RWDc0SFdJ?=
 =?utf-8?B?Rno0UmVBa2ZXM1NqVkpGd3h4bXNjeGN4UlN0ZnhSSnorTkVSOEZoMHJQN3pL?=
 =?utf-8?B?WG5lRkRYNFJ1ekI4dW4zSnNjdnlJTWtxMEp3S2QvYkhrYVMwbXNsU0JSbXkv?=
 =?utf-8?B?UWhnN1lOWVhNK2xZWDNYa3FSYjZJQUlYTXg5czhVS2FvZ0JaK0crcEN1S1cy?=
 =?utf-8?B?TVBqR2dzYjFoR1daLzQrUWNuV3crYVYyRWI2Z3B5c1c2UmpxSlJvcmEyemQr?=
 =?utf-8?B?VWRJZ3NzM0NzRm5zTWI4TWMvOFRVS3BVZEIwMkZFQjBybHdId05LeDUvZDRM?=
 =?utf-8?Q?4+PM6XtBAdYdECU7q/GiDmVVQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a27157-f1f3-4d1d-9795-08db6b34d4a5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 11:04:45.6163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4yFLG0ED0zURVIeVx3OI+Sxvkq2Gn5bKogCUE+CH7iT1SqUC9RFXesCveG1TIieW6zNU50eQI6HCY53grr45w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7418
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20; envelope-from=fei2.wu@intel.com;
 helo=mga02.intel.com
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

I didn't realize async_safe_run_on_cpu has such a strong semantics,
I will add it back if it's necessary.

Thanks,
Fei.

> * use monitor_disas instead of regenerate TB, but **doesn't work yet**
> * other cleanups
> 
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


