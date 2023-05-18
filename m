Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E58977083FF
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:37:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzekG-0007Wq-Uk; Thu, 18 May 2023 10:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pzekE-0007WM-SP
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:36:42 -0400
Received: from mga02.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pzekA-0001Sl-I5
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684420598; x=1715956598;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CIKMw6z8kOqXaW++dZznpkpV4hQV6N4ch+ZAJser5ns=;
 b=H9+cCsh/YgP8NoV58kIgG6ICGDJtSmpFqfA/axi1FAXK4GXylxjorpPK
 Isgwdo5PGXBN5sy+E+fseCwF4eh07pty1fnKNr05V8sbc6s1bW8EkodZU
 bEe5u6G14Y6Qm1wm3V/pJL2JhNZVt8OgZtEyf4GHLkZy9K74rTow/dDbQ
 8jn431E9F9R9a8meHbRIvX/aFmgV6NlfQTjAt42T+Z1ShG4crJ/lUPCSv
 x8vIse+Fg/pw+bUg8/NHDHP22jv2vxOvdubk1C88cEfQ0UbBOWVvfdmAF
 mUsh3w6ik6IuNmrkdhMvNqHyfmQ6dy/I2whr1sTal/uH3AQ+vxFWMiYDu w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="341509285"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="341509285"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 07:30:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="791989763"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="791989763"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by FMSMGA003.fm.intel.com with ESMTP; 18 May 2023 07:30:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 07:30:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 07:30:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 07:30:20 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 07:30:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVwM4VsbOr95SptX6BTMCovMmIwNnwi4PwqJn4lHsGB4rz0Cnk1TAUOiXEXZ4iBXpScyr9IypPCLGDdFHasV+nf1YqgjMbAj2MrzjdzGNJRVmYoDq0K1dqLKhB9WSkfM93WXoCbkfdTlNTeHVTwGx0fuDlP/gEcTJq6DzbtznW5Dh8V71I51XYOU3DDe815/y3EieYQ5SbiGgEtaeMb7ecPZUDlIqdRYhfptMgaP5mIXwtl7wMMtl73QWGXs7ddCu/zViRrGLtTSTcQ8fjwGTJUN6M8vud2EQ9Gi9jyfQalaoOMGWtQRPWm/WzW1CWjslr8retq5c1sD4CJ6qGjtoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6ex6m+6h4QDErOhJ1Rq1EEFpJ+PJJDQx1DXhMkH4DQ=;
 b=fIYVXVt0xmUi+msonzP4AT3ul8asqHQdtQVhpASDtLNJo+kc+DbEvfN6rK0ugXikI4MSvDN/05qF3Svhff1x85nfhnFE/DZxXb3pxiYySFpopFdAWFb/I7qCG2aetfexteiaurblV1RFJPkrCw1FXQsSJQyYDOAbpUEibtay09UBhtl0vwA7gOJXcKbBjzG1rRvd8HU4OtdzAJ48jwqvKS2qaBOvUBG/6YaDkAOjJQ7R3uM6Eicanf+77rT84c1f55ai4gSoFAtARGv2eSP1h67H1oPKtWfmwKL7pFoQky+3VWZsGeLgH2zn8N48aHPx22JsD8EAoEEjUfSq5GvUjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:30:17 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::b80e:1bbb:b818:10bc]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::b80e:1bbb:b818:10bc%3]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 14:30:17 +0000
Message-ID: <139e44e0-5ddb-ddd6-4a72-f64cb41a84c1@intel.com>
Date: Thu, 18 May 2023 22:30:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v12 12/15] Adding info [tb-list|tb] commands to HMP (WIP)
Content-Language: en-US
To: <qemu-devel@nongnu.org>, <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>
CC: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, "Dr . David Alan
 Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>
References: <20230518135757.1442654-1-fei2.wu@intel.com>
 <20230518135757.1442654-13-fei2.wu@intel.com>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <20230518135757.1442654-13-fei2.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0087.apcprd02.prod.outlook.com
 (2603:1096:4:90::27) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|PH0PR11MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: abe1b245-2f88-4809-d2f2-08db57ac66cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HwfR5zg1W4xv/jEle6r0t9u/ZRy6tlExz3Y7MOoQPGmMJx+8DJHEgQ1GcthTXgtzABHrMXQgB7lk+BGE1oHQvGjV0SWAq78HnC+Y6G5pLxrFxkiX6mk2MPcAlPkivTh9x3nk6ile7hBEb2qq9+DVqBtrHYILFe2700o0IWU1jw3jeX5976hlAhWUMg+oO+7TEzyzyVZpX9Pc2yWf3MvsNyMAQFTZ1iE2ROfDFw59iEJIvaG4b0fXmJzmK4tDqX/vMCS2OsogSKEEDC+ut2m2X7JIady3fpJ4pD9cT6XLYAI7BCv0YHMxCphNGmhKDnM20HsE4hMhITJhiBjEUU3P9+vm2faDHcciV2yCDgvXVTCl0H/P1Rx7Bp3G8trK9LOKlVFmFYp/71v7gHjkM0aNWAVQ1FEG/X+hDyfZPtmIQ1rlMhV2/khOBGk4wczHOqI/CD1cG7t0GduhP6q2NvwB7uLPLz9ZLY6dPzL4VLLu+v2EOdhJDfoDPSCo5DmJv/6GZ2ISPNvVQQkaWF1cJPBeWxb2qdd5hJ+oABjB+ji+ndT9c+QF7F4JTDBGRzbNaaay9iZu/fDMYBtraTmLKMh2grjkhjipmMXAmB4i7qjd4DZgeviypOTSD6+AFNyg+fXtplnXC2G61m5D727iTxQ3mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199021)(31686004)(2906002)(30864003)(4326008)(8936002)(8676002)(5660300002)(66946007)(66556008)(316002)(6486002)(36756003)(54906003)(478600001)(41300700001)(6666004)(66476007)(86362001)(82960400001)(31696002)(186003)(6512007)(66574015)(6506007)(26005)(83380400001)(2616005)(53546011)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGZ4S1RUUHp4SmlHbStLY0NvNE5veXF0R2tKVk1RWkowbDN3ZjMvZ2VhYVNq?=
 =?utf-8?B?cTRSSHdPOVluV2d4TUNCbkpaZkdoSjQ4ZkdRaWdUc2ZHLzVLczlvNDNJVFd1?=
 =?utf-8?B?YWwreTQxMDFmbUF0djc4MFVkZFhYTktRbGEwdm50cldrODlwUXFPRXY2dUZQ?=
 =?utf-8?B?L2tzdzJhbkdSM0xCdDA1UlRjVUVlL2pwVXlOUWRMYWpMZjlRN1BpTXlEWDRM?=
 =?utf-8?B?RVRJejBGT0RGckZuSVRVUThQMktpSFJiSEdRNU9hR2I0ZkVUai9tc3oyK2M1?=
 =?utf-8?B?ZExBZng1NERadlZ0M0lSMk9mdjNNci9kVGljRTFTWHJ3TktQRmxOMVNhdGZp?=
 =?utf-8?B?eVh5ZlJmanV0OEhWZ240Vzg0dmQzRFJrRzJFaUpiNkM0UWdkbzJROEZIQ3dK?=
 =?utf-8?B?Y3Vrd090L2VIdU5LSk5pWEsvSWNFVE5Fb3pqYkdXUndWS1czWVNnRndXbzBX?=
 =?utf-8?B?MHlVeFQxTFA5N0JrYW1FejJZem1tWHFXYkxNSCtGd2tLTk1QaHVRMVdtdXk1?=
 =?utf-8?B?UTF2bFNGNUZKcVR5bVdPWnE1T0Jtcmg5NDloTThsMXFDN2ZiZEd3aWJiZGta?=
 =?utf-8?B?Ukhjb1gzamNjMnplNm56U1A2RFB6ekFtejJIY1kwYkRkOTBRR0pYOWNXODJv?=
 =?utf-8?B?YWtyMWdxZk5VVEJBZVdxc0RLa2dpckRkVmxQVFZEU25ZOEVJeHE2MjViSDgz?=
 =?utf-8?B?MVNVOWNKN3pvSThMN2NXaXJWRkpGY0kvOVExZ1QvaFFVd0pjRTMzaGt5WE5k?=
 =?utf-8?B?Q05vOVRmUHZyS3lIM0g0M3A1dDNjYkZIZ0FudmM5RUxLdm5vQXhKR2VPdHl1?=
 =?utf-8?B?cEFjblVKZDJaRnJQNmhTY29xMGpEY05kcVY0RDcvSi81eU9rKzhnYnk3VzlU?=
 =?utf-8?B?VC9tZXN0Q2dCQ2pmRnZhQ2l2cUMzcHd3RTlsdkF2dWFiVnpUR3BjQ1JqZWI5?=
 =?utf-8?B?QjdFdk4yZ3k2NzhMaitoS1N2cnE3VjVURjl5RTYxYjU3NzBKcjVZNDUzR3lU?=
 =?utf-8?B?YlNEVWZrd0VxbXNsZGJEeWVyaW5qYkY0V2x5VVpjUmhJdTQ5Y3pHY3pvTDRF?=
 =?utf-8?B?Uzl4T1ZWdzVOZUZtdW5INk1tMmlIUFhiSXdEZitPam1oT1ZPb2tXaTdZM0VK?=
 =?utf-8?B?UVp6dkROUncrZlFyeDJrSjdTL0xuU2xubkJYREZIb1lvK3RUeEpkTEl5UlA0?=
 =?utf-8?B?NlpYZG9QMG5XVUxUVzJwSE5NczVFczJBWmlwTjk0dkpJbGx5SW94ZjRxdTRm?=
 =?utf-8?B?L05Ha01QbWd3bm1jWjhIemw5Tk96Y3VWYm9lVDcrQVdlY3p3OEhJNllsVGlM?=
 =?utf-8?B?S2hSK2FsZ3c4b2VVRjRZZ0g3UnExejVYY054b2VnQ3dCM2M5NEtlZThxcDNw?=
 =?utf-8?B?VVAxOHFwY3dTWFltTnBINUJvbUVPekU1RXBiWWNYVnhVWjdTTlFLT0g3YWN3?=
 =?utf-8?B?VVcrTEcwbVExWXRtcU5CcGh3RnJJK0hMNk91VjR3dldJV1IzNks2Ym1PVElj?=
 =?utf-8?B?YkxmakVpWWRHZWgzRkdXQlhxV09nYXgyQjc0eDJHcHhlMXo1VktOOGhVUUFN?=
 =?utf-8?B?QkZpbVdsTjdaOVJxN3BtQ3k0c0tTanhGTEpIaitnQzBZeURMMVpHa1R5eXJk?=
 =?utf-8?B?U2RmRzV6bk1sQjNuNjdMZUxMZklXRGZKTmt0VFY4NFdZTWJpSnptcGdYZDA1?=
 =?utf-8?B?Nk5BV2dIdk04eWZWQjRyMzMyYWs1UTMzem9WV1R0NUNoNksybHVndHlxZ0J3?=
 =?utf-8?B?S0g3RjJ4bmFjSlgxcllxM0ZqYnAwWTBtUUNwZG9IR1F1UnFlbWJhcWdHNmo1?=
 =?utf-8?B?MU5hcGlLYlcyVTJ2Q3hoMktUY2E2Nk10U20rTEFybTREL3RUK1kwNFZ4UUZ5?=
 =?utf-8?B?ZjFjV01YRUZFR3plMEdqbkQ2Zi9yUXpjcW9lcC9VbUZIVG9OS2NyREFUK011?=
 =?utf-8?B?eG04OE1RdW5rdXgyZi9UNzRuYmptMk9XUzRjN1ptRnN6T0gvT0FYT25KK01G?=
 =?utf-8?B?TFhYT1EvM05SdVgwc0xmVlV0SHNSdWVvYWNCVGNBVEhtazBxMWJJQXQzQjdy?=
 =?utf-8?B?bkxCeHJXZTI2RUdHRFNTdnpXRXhIT09MZUdlOVRaWkFjRHV4V0NFWmIyN2M1?=
 =?utf-8?Q?eezzc9wmSUhFoBL8Oj31AjQmL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abe1b245-2f88-4809-d2f2-08db57ac66cf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:30:17.7748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4L+7EApAf+PCLF8tz4MWzAaQB4QG3F/zDfL68V0Y2sCPD2Q/KY3emcPJWffzuq352YKCVQ3VCqdJmF8eDtEynA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7424
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20; envelope-from=fei2.wu@intel.com;
 helo=mga02.intel.com
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.544, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
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

On 5/18/2023 9:57 PM, Fei Wu wrote:
> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
> 
> These commands allow the exploration of TBs generated by the TCG.
> Understand which one hotter, with more guest/host instructions... and
> examine their guest, host and IR code.
> 
> The goal of this command is to allow the dynamic exploration of TCG
> behavior and code quality. Therefore, for now, a corresponding QMP
> command is not worthwhile.
> 
> [AJB: WIP - we still can't be safely sure a translation will succeed]
> 
> Example of output:
> 
> TB id:1 | phys:0x34d54 virt:0x0000000000034d54 flags:0x0000f0
> 	| exec:4828932/0 guest inst cov:16.38%
> 	| trans:1 ints: g:3 op:82 op_opt:34 spills:3
> 	| h/g (host bytes / guest insts): 90.666664
> 	| time to gen at 2.4GHz => code:3150.83(ns) IR:712.08(ns)
> 	| targets: 0x0000000000034d5e (id:11), 0x0000000000034d0d (id:2)
> 
> TB id:2 | phys:0x34d0d virt:0x0000000000034d0d flags:0x0000f0
> 	| exec:4825842/0 guest inst cov:21.82%
> 	| trans:1 ints: g:4 op:80 op_opt:38 spills:2
> 	| h/g (host bytes / guest insts): 84.000000
> 	| time to gen at 2.4GHz => code:3362.92(ns) IR:793.75(ns)
> 	| targets: 0x0000000000034d19 (id:12), 0x0000000000034d54 (id:1)
> 
> TB id:2 | phys:0x34d0d virt:0x0000000000034d0d flags:0x0000f0
> 	| exec:6956495/0  guest inst cov:21.82%
> 	| trans:2 ints: g:2 op:40 op_opt:19 spills:1
> 	| h/g (host bytes / guest insts): 84.000000
> 	| time to gen at 2.4GHz => code:3130.83(ns) IR:722.50(ns)
> 	| targets: 0x0000000000034d19 (id:12), 0x0000000000034d54 (id:1)
> 
> ----------------
> IN:
> 0x00034d0d:  89 de                    movl     %ebx, %esi
> 0x00034d0f:  26 8b 0e                 movl     %es:(%esi), %ecx
> 0x00034d12:  26 f6 46 08 80           testb    $0x80, %es:8(%esi)
> 0x00034d17:  75 3b                    jne      0x34d54
> 
> ------------------------------
> 
> TB id:1 | phys:0x34d54 virt:0x0000000000034d54 flags:0x0000f0
> 	| exec:5202686/0 guest inst cov:11.28%
> 	| trans:1 ints: g:3 op:82 op_opt:34 spills:3
> 	| h/g (host bytes / guest insts): 90.666664
> 	| time to gen at 2.4GHz => code:2793.75(ns) IR:614.58(ns)
> 	| targets: 0x0000000000034d5e (id:3), 0x0000000000034d0d (id:2)
> 
> TB id:2 | phys:0x34d0d virt:0x0000000000034d0d flags:0x0000f0
> 	| exec:5199468/0 guest inst cov:15.03%
> 	| trans:1 ints: g:4 op:80 op_opt:38 spills:2
> 	| h/g (host bytes / guest insts): 84.000000
> 	| time to gen at 2.4GHz => code:2958.75(ns) IR:719.58(ns)
> 	| targets: 0x0000000000034d19 (id:4), 0x0000000000034d54 (id:1)
> 
> ------------------------------
> 2 TBs to reach 25% of guest inst exec coverage
> Total of guest insts exec: 138346727
> 
> ------------------------------
> 
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> Message-Id: <20190829173437.5926-10-vandersonmr2@gmail.com>
> [AJB: fix authorship, dropped coverset]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> ---
>  accel/tcg/monitor.c          |  54 ++++++
>  accel/tcg/tb-stats.c         | 322 +++++++++++++++++++++++++++++++++++
>  disas/disas.c                |  24 ++-
>  hmp-commands-info.hx         |  16 ++
>  include/exec/tb-stats.h      |  33 +++-
>  include/monitor/hmp.h        |   2 +
>  include/qemu/log-for-trace.h |   6 +-
>  include/qemu/log.h           |   2 +
>  util/log.c                   |  66 +++++--
>  9 files changed, 507 insertions(+), 18 deletions(-)
> 
> diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
> index 2e00f10267..a1780c5920 100644
> --- a/accel/tcg/monitor.c
> +++ b/accel/tcg/monitor.c
> @@ -8,6 +8,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/accel.h"
> +#include "qemu/log.h"
>  #include "qapi/error.h"
>  #include "qapi/type-helpers.h"
>  #include "qapi/qapi-commands-machine.h"
> @@ -18,6 +19,7 @@
>  #include "sysemu/cpu-timers.h"
>  #include "sysemu/tcg.h"
>  #include "exec/tb-stats.h"
> +#include "tb-context.h"
>  #include "internal.h"
>  
>  
> @@ -132,6 +134,58 @@ void hmp_tbstats(Monitor *mon, const QDict *qdict)
>  
>  }
>  
> +void hmp_info_tblist(Monitor *mon, const QDict *qdict)
> +{
> +    int number_int;
> +    const char *sortedby_str = NULL;
> +    if (!tcg_enabled()) {
> +        error_report("TB information is only available with accel=tcg");
> +        return;
> +    }
> +    if (!tb_ctx.tb_stats.map) {
> +        error_report("no TB information recorded");
> +        return;
> +    }
> +
> +    number_int = qdict_get_try_int(qdict, "number", 10);
> +    sortedby_str = qdict_get_try_str(qdict, "sortedby");
> +
> +    int sortedby = SORT_BY_HOTNESS;
> +    if (sortedby_str == NULL || strcmp(sortedby_str, "hotness") == 0) {
> +        sortedby = SORT_BY_HOTNESS;
> +    } else if (strcmp(sortedby_str, "hg") == 0) {
> +        sortedby = SORT_BY_HG;
> +    } else if (strcmp(sortedby_str, "spills") == 0) {
> +        sortedby = SORT_BY_SPILLS;
> +    } else {
> +        error_report("valid sort options are: hotness hg spills");
> +        return;
> +    }
> +
> +    dump_tbs_info(number_int, sortedby, true);
> +}
> +
> +void hmp_info_tb(Monitor *mon, const QDict *qdict)
> +{
> +    const int id = qdict_get_int(qdict, "id");
> +    const char *flags = qdict_get_try_str(qdict, "flags");
> +    int mask;
> +
> +    if (!tcg_enabled()) {
> +        error_report("TB information is only available with accel=tcg");
> +        return;
> +    }
> +
> +    mask = flags ? qemu_str_to_log_mask(flags) : CPU_LOG_TB_IN_ASM;
> +
> +    if (!mask) {
> +        error_report("Unable to parse log flags, see 'help log'");
> +        return;
> +    }
> +
> +    dump_tb_info(id, mask, true);
> +}
> +
>  HumanReadableText *qmp_x_query_profile(Error **errp)
>  {
>      g_autoptr(GString) buf = g_string_new("");
> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> index 469e3e024b..cb28879a45 100644
> --- a/accel/tcg/tb-stats.c
> +++ b/accel/tcg/tb-stats.c
> @@ -11,14 +11,18 @@
>  #include "disas/disas.h"
>  #include "exec/exec-all.h"
>  #include "tcg/tcg.h"
> +#include "qapi/error.h"
>  
>  #include "qemu/qemu-print.h"
>  #include "qemu/timer.h"
> +#include "qemu/log.h"
>  
>  #include "exec/tb-stats.h"
>  #include "exec/tb-flush.h"
>  #include "tb-context.h"
>  
> +#include "internal.h"
> +
>  /* TBStatistic collection controls */
>  enum TBStatsStatus {
>      TB_STATS_DISABLED = 0,
> @@ -32,8 +36,23 @@ static uint32_t default_tbstats_flag;
>  /* only accessed in safe work */
>  static GList *last_search;
>  
> +static int id = 1; /* display_id increment counter */
>  uint64_t dev_time;
>  
> +static TBStatistics *get_tbstats_by_id(int id)
> +{
> +    GList *iter;
> +
> +    for (iter = last_search; iter; iter = g_list_next(iter)) {
> +        TBStatistics *tbs = iter->data;
> +        if (tbs && tbs->display_id == id) {
> +            return tbs;
> +            break;
> +        }
> +    }
> +    return NULL;
> +}
> +
>  struct jit_profile_info {
>      uint64_t translations;
>      uint64_t aborted;
> @@ -296,6 +315,309 @@ void init_tb_stats_htable(void)
>      }
>  }
>  
> +static void collect_tb_stats(void *p, uint32_t hash, void *userp)
> +{
> +    last_search = g_list_prepend(last_search, p);
> +}
> +
> +static void count_invalid_tbs(gpointer data, gpointer user_data)
> +{
> +    TranslationBlock *tb = (TranslationBlock *) data;
> +    unsigned *counter = (unsigned *) user_data;
> +    if (tb->cflags & CF_INVALID) {
> +        *counter = *counter + 1;
> +    }
> +}
> +
> +static int dump_tb_header(TBStatistics *tbs)
> +{
> +    unsigned g = stat_per_translation(tbs, code.num_guest_inst);
> +    unsigned ops = stat_per_translation(tbs, code.num_tcg_ops);
> +    unsigned ops_opt = stat_per_translation(tbs, code.num_tcg_ops_opt);
> +    unsigned spills = stat_per_translation(tbs, code.spills);
> +    unsigned h = stat_per_translation(tbs, code.out_len);
> +    unsigned act = tbs->tbs->len;
> +    unsigned invalid = 0;
> +
> +    float guest_host_prop = g ? ((float) h / g) : 0;
> +
> +    g_ptr_array_foreach(tbs->tbs, &count_invalid_tbs, &invalid);
> +
> +    qemu_log("TB id:%d | phys:0x"TB_PAGE_ADDR_FMT" virt:0x"TARGET_FMT_lx
> +             " flags:0x%08x %d inv/%d\n",
> +             tbs->display_id, tbs->phys_pc, tbs->pc, tbs->flags,
> +             invalid, act);
> +
> +    if (tbs_stats_enabled(tbs, TB_EXEC_STATS)) {
> +        qemu_log("\t| exec:%lu/%lu guest inst cov:%.2f%%\n",
> +                tbs->executions.normal,
> +                tbs->executions.atomic, tbs->executions.coverage / 100.0f);
> +    }
> +
> +    if (tbs_stats_enabled(tbs, TB_JIT_STATS)) {
> +        qemu_log("\t| trans:%lu ints: g:%u op:%u op_opt:%u spills:%d"
> +             "\n\t| h/g (host bytes / guest insts): %f\n",
> +             tbs->translations.total, g, ops, ops_opt, spills, guest_host_prop);
> +    }
> +
> +    if (tbs_stats_enabled(tbs, TB_JIT_TIME)) {
> +        qemu_log("\t| time to gen at 2.4GHz => code:%0.2lf(ns) IR:%0.2lf(ns)\n",
> +             tbs->gen_times.code / 2.4, tbs->gen_times.ir / 2.4);
> +    }
> +
> +    qemu_log("\n");
> +
> +    return act - invalid;
> +}
> +
> +static gint
> +inverse_sort_tbs(gconstpointer p1, gconstpointer p2, gpointer psort_by)
> +{
> +    const TBStatistics *tbs1 = (TBStatistics *) p1;
> +    const TBStatistics *tbs2 = (TBStatistics *) p2;
> +    int sort_by = *((enum SortBy *) psort_by);
> +    unsigned long c1 = 0;
> +    unsigned long c2 = 0;
> +
> +    if (sort_by == SORT_BY_SPILLS) {
> +        c1 = stat_per_translation(tbs1, code.spills);
> +        c2 = stat_per_translation(tbs2, code.spills);
> +    } else if (sort_by == SORT_BY_HOTNESS) {
> +        c1 = stat_per_translation(tbs1, executions.normal);
> +        c2 = stat_per_translation(tbs2, executions.normal);
> +    } else if (sort_by == SORT_BY_HG) {
> +        if (tbs1->code.num_guest_inst == 0) {
> +            return -1;
> +        }
> +        if (tbs2->code.num_guest_inst == 0) {
> +            return 1;
> +        }
> +
> +        c1 = tbs1->code.out_len / tbs1->code.num_guest_inst;
> +        c2 = tbs2->code.out_len / tbs2->code.num_guest_inst;
> +    }
> +    return c1 < c2 ? 1 : c1 == c2 ? 0 : -1;
> +}
> +
> +static void dump_last_search_headers(int count)
> +{
> +    if (!last_search) {
> +        qemu_log("No data collected yet\n");
> +        return;
> +    }
> +
> +    GList *l = last_search;
> +    while (l != NULL && count--) {
> +        TBStatistics *tbs = (TBStatistics *) l->data;
> +        GList *next = l->next;
> +        dump_tb_header(tbs);
> +        l = next;
> +    }
> +}
> +
> +static uint64_t calculate_last_search_coverages(void)
> +{
> +    uint64_t total_exec_count = 0;
> +    GList *i;
> +
> +    /* Compute total execution count for all tbs */
> +    for (i = last_search; i; i = i->next) {
> +        TBStatistics *tbs = (TBStatistics *) i->data;
> +        total_exec_count +=
> +            (tbs->executions.atomic + tbs->executions.normal)
> +                * tbs->code.num_guest_inst;

num_guest_inst is sum of all related translations, this looks not what
we want?

> +    }
> +
> +    for (i = last_search; i; i = i->next) {
> +        TBStatistics *tbs = (TBStatistics *) i->data;
> +        uint64_t tb_total_execs =
> +            (tbs->executions.atomic + tbs->executions.normal)
> +                * tbs->code.num_guest_inst;
> +        tbs->executions.coverage =
> +            (10000 * tb_total_execs) / (total_exec_count + 1);
> +    }
> +
> +    return total_exec_count;
> +}
> +
> +static void do_dump_tbs_info(int total, int sort_by)
> +{
> +    id = 1;
> +    GList *i;
> +    int count = total;
> +
> +    g_list_free(last_search);
> +    last_search = NULL;
> +
> +    qht_iter(&tb_ctx.tb_stats, collect_tb_stats, NULL);
> +
> +    last_search = g_list_sort_with_data(last_search, inverse_sort_tbs,
> +                                        &sort_by);
> +
> +    if (!last_search) {
> +        qemu_printf("No data collected yet!\n");
> +        return;
> +    }
> +
> +    calculate_last_search_coverages();
> +
> +    for (i = last_search; i && count--; i = i->next) {
> +        TBStatistics *tbs = (TBStatistics *) i->data;
> +        tbs->display_id = id++;
> +    }
> +
> +    /* free the unused bits */
> +    if (i) {
> +        if (i->next) {
> +            i->next->prev = NULL;
> +        }
> +        g_list_free(i->next);
> +        i->next = NULL;
> +    }
> +
> +    dump_last_search_headers(total);
> +}
> +
> +struct tbs_dump_info {
> +    int count;
> +    int sort_by;
> +};
> +
> +static void do_dump_tbs_info_safe(CPUState *cpu, run_on_cpu_data tbdi)
> +{
> +    struct tbs_dump_info *info = tbdi.host_ptr;
> +    qemu_log_to_monitor(true);
> +    do_dump_tbs_info(info->count, info->sort_by);
> +    qemu_log_to_monitor(false);
> +    g_free(info);
> +}
> +
> +/*
> + * When we dump_tbs_info on a live system via the HMP we want to
> + * ensure the system is quiessent before we start outputting stuff.
> + * Otherwise we could pollute the output with other logging output.
> + */
> +
> +void dump_tbs_info(int count, int sort_by, bool use_monitor)
> +{
> +    if (use_monitor) {
> +        struct tbs_dump_info *tbdi = g_new(struct tbs_dump_info, 1);
> +        tbdi->count = count;
> +        tbdi->sort_by = sort_by;
> +        async_safe_run_on_cpu(first_cpu, do_dump_tbs_info_safe,
> +                              RUN_ON_CPU_HOST_PTR(tbdi));
> +    } else {
> +        do_dump_tbs_info(count, sort_by);
> +    }
> +}
> +
> +/*
> + * We cannot always re-generate the code even if we know there are
> + * valid translations still in the cache. The reason being the guest
> + * may have un-mapped the page code. In real life this would be
> + * un-reachable as the jump cache is cleared and the following QHT
> + * lookup will do a get_page_addr_code() and fault.
> + *
> + * TODO: can we do this safely? We need to
> + *  a) somehow recover the mmu_idx for this translation
> + *  b) probe MMU_INST_FETCH to know it will succeed
> + */
> +static GString *get_code_string(TBStatistics *tbs, int log_flags)
> +{
> +    int old_log_flags = qemu_loglevel;
> +
> +    CPUState *cpu = first_cpu;
> +    uint32_t cflags = curr_cflags(cpu);
> +    TranslationBlock *tb = NULL;
> +
> +    GString *code_s = g_string_new(NULL);
> +    qemu_log_to_string(true, code_s);
> +
> +    Error *err = NULL;
> +    if (!qemu_set_log(log_flags, &err)) {
> +        g_string_append_printf(code_s, "%s", error_get_pretty(err));
> +        error_free(err);
> +    }
> +
> +    if (sigsetjmp(cpu->jmp_env, 0) == 0) {
> +        mmap_lock();
> +        tb = tb_gen_code(cpu, tbs->pc, tbs->cs_base, tbs->flags, cflags);
> +        tb_phys_invalidate(tb, -1);
> +        mmap_unlock();
> +    } else {
> +        /*
> +         * The mmap_lock is dropped by tb_gen_code if it runs out of
> +         * memory.
> +         */
> +        qemu_log("\ncould not gen code for this TB (no longer mapped?)\n");
> +        assert_no_pages_locked();
> +    }
> +
> +    qemu_set_log(old_log_flags, &err);
> +    qemu_log_to_string(false, NULL);
> +
> +    return code_s;
> +}
> +
> +static void do_tb_dump_with_statistics(TBStatistics *tbs, int log_flags)
> +{
> +    g_autoptr(GString) code_s = NULL;
> +
> +    qemu_log("\n------------------------------\n\n");
> +
> +    if (dump_tb_header(tbs) > 0) {
> +        code_s = get_code_string(tbs, log_flags);
> +    } else {
> +        code_s = g_string_new("cannot re-translate non-active translation");
> +    }
> +    qemu_log("%s", code_s->str);
> +    qemu_log("------------------------------\n");
> +}
> +
> +struct tb_dump_info {
> +    int id;
> +    int log_flags;
> +    bool use_monitor;
> +};
> +
> +static void do_dump_tb_info_safe(CPUState *cpu, run_on_cpu_data info)
> +{
> +    struct tb_dump_info *tbdi = (struct tb_dump_info *) info.host_ptr;
> +
> +    if (!last_search) {
> +        qemu_log("no search on record\n");
> +        return;
> +    }
> +
> +    qemu_log_to_monitor(tbdi->use_monitor);
> +
> +    TBStatistics *tbs = get_tbstats_by_id(tbdi->id);
> +    if (tbs) {
> +        do_tb_dump_with_statistics(tbs, tbdi->log_flags);
> +    } else {
> +        qemu_log("no TB statitics found with id %d\n", tbdi->id);
> +    }
> +
The HMP output has some small issues in my tests:
* enter monitor use 'c-a c', start tb-stats then after execution of
	(qemu) info tb-list 1
  the prompt (qemu) shows before the output instead of after

* enter monitor use 'telnet', the output of 'info tb-list' is not in the
telnet term, but the term starting qemu-system

* 'info tb 1', the addresses and instructions are seperated as follows:
----------------
IN:
Priv: 1; Virt: 0
6422              ld                      s0,8(sp)0141              addi
                   sp,sp,168082              ret
0xffffffff8059bca0:
0xffffffff8059bca2:
0xffffffff8059bca4:
------------------------------

Thanks,
Fei.

> +    qemu_log_to_monitor(false);
> +
> +    g_free(tbdi);
> +}
> +
> +void dump_tb_info(int id, int log_mask, bool use_monitor)
> +{
> +    struct tb_dump_info *tbdi = g_new(struct tb_dump_info, 1);
> +
> +    tbdi->id = id;
> +    tbdi->log_flags = log_mask;
> +    tbdi->use_monitor = use_monitor;
> +
> +    async_safe_run_on_cpu(first_cpu, do_dump_tb_info_safe,
> +                          RUN_ON_CPU_HOST_PTR(tbdi));
> +
> +    /* tbdi free'd by do_dump_tb_info_safe */
> +}
> +
> +
>  void enable_collect_tb_stats(void)
>  {
>      tcg_collect_tb_stats = TB_STATS_RUNNING;
> diff --git a/disas/disas.c b/disas/disas.c
> index 0d2d06c2ec..6cdd797874 100644
> --- a/disas/disas.c
> +++ b/disas/disas.c
> @@ -8,6 +8,8 @@
>  #include "hw/core/cpu.h"
>  #include "exec/memory.h"
>  
> +#include "qemu/log-for-trace.h"
> +
>  /* Filled in by elfload.c.  Simplistic, but will do for now. */
>  struct syminfo *syminfos = NULL;
>  
> @@ -199,6 +201,24 @@ static void initialize_debug_host(CPUDebug *s)
>  #endif
>  }
>  
> +static int
> +__attribute__((format(printf, 2, 3)))
> +fprintf_log(FILE *a, const char *b, ...)
> +{
> +    va_list ap;
> +    va_start(ap, b);
> +
> +    if (!to_string) {
> +        vfprintf(a, b, ap);
> +    } else {
> +        qemu_vlog(b, ap);
> +    }
> +
> +    va_end(ap);
> +
> +    return 1;
> +}
> +
>  /* Disassemble this for me please... (debugging).  */
>  void target_disas(FILE *out, CPUState *cpu, uint64_t code, size_t size)
>  {
> @@ -221,9 +241,9 @@ void target_disas(FILE *out, CPUState *cpu, uint64_t code, size_t size)
>      }
>  
>      for (pc = code; size > 0; pc += count, size -= count) {
> -        fprintf(out, "0x%08" PRIx64 ":  ", pc);
> +        fprintf_log(out, "0x%08" PRIx64 ":  ", pc);
>          count = s.info.print_insn(pc, &s.info);
> -        fprintf(out, "\n");
> +        fprintf_log(out, "\n");
>          if (count < 0) {
>              break;
>          }
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 47d63d26db..01d9658aea 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -262,6 +262,22 @@ ERST
>          .params     = "",
>          .help       = "show dynamic compiler info",
>      },
> +    {
> +        .name       = "tb-list",
> +        .args_type  = "number:i?,sortedby:s?",
> +        .params     = "[number sortedby]",
> +        .help       = "show a [number] translated blocks sorted by [sortedby]"
> +                      "sortedby opts: hotness hg spills",
> +        .cmd        = hmp_info_tblist,
> +    },
> +    {
> +        .name       = "tb",
> +        .args_type  = "id:i,flags:s?",
> +        .params     = "id [flag1,flag2,...]",
> +        .help       = "show information about one translated block by id."
> +                      "dump flags can be used to set dump code level: out_asm in_asm op",
> +        .cmd        = hmp_info_tb,
> +    },
>  #endif
>  
>  SRST
> diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
> index 30b788f7b2..f2a6b09da9 100644
> --- a/include/exec/tb-stats.h
> +++ b/include/exec/tb-stats.h
> @@ -36,8 +36,11 @@
>  enum SortBy { SORT_BY_HOTNESS, SORT_BY_HG /* Host/Guest */, SORT_BY_SPILLS };
>  enum TbstatsCmd { START, PAUSE, STOP, FILTER };
>  
> +#define tbs_stats_enabled(tbs, JIT_STATS) \
> +    (tbs && (tbs->stats_enabled & JIT_STATS))
> +
>  #define tb_stats_enabled(tb, JIT_STATS) \
> -    (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
> +    (tb && tb->tb_stats && tbs_stats_enabled(tb->tb_stats, JIT_STATS))
>  
>  #define stat_per_translation(stat, name) \
>      (stat->translations.total ? stat->name / stat->translations.total : 0)
> @@ -66,6 +69,8 @@ struct TBStatistics {
>      struct {
>          unsigned long normal;
>          unsigned long atomic;
> +        /* filled only when dumping x% cover set */
> +        uint16_t coverage;
>      } executions;
>  
>      /* JIT Stats - protected by lock */
> @@ -88,7 +93,6 @@ struct TBStatistics {
>  
>      struct {
>          unsigned long total;
> -        unsigned long uncached;
>          unsigned long spanning;
>      } translations;
>  
> @@ -108,6 +112,9 @@ struct TBStatistics {
>          uint64_t la;
>          uint64_t code;
>      } gen_times;
> +
> +    /* HMP information - used for referring to previous search */
> +    int display_id;
>  };
>  
>  bool tb_stats_cmp(const void *ap, const void *bp);
> @@ -132,4 +139,26 @@ void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd);
>   */
>  void tbstats_reset_tbs(void);
>  
> +/**
> + * dump_tbs_info: report the hottest blocks
> + *
> + * @count: the limit of hotblocks
> + * @sort_by: property in which the dump will be sorted
> + * @use_monitor: redirect output to monitor
> + *
> + * Report the hottest blocks to either the log or monitor
> + */
> +void dump_tbs_info(int count, int sort_by, bool use_monitor);
> +
> +/**
> + * dump_tb_info: dump information about one TB
> + *
> + * @id: the display id of the block (from previous search)
> + * @mask: the temporary logging mask
> + * @Use_monitor: redirect output to monitor
> + *
> + * Re-run a translation of a block at addr for the purposes of debug output
> + */
> +void dump_tb_info(int id, int log_mask, bool use_monitor);
> +
>  #endif
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index 2e7f141754..acdd6f1561 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -182,5 +182,7 @@ void hmp_boot_set(Monitor *mon, const QDict *qdict);
>  void hmp_info_mtree(Monitor *mon, const QDict *qdict);
>  void hmp_info_cryptodev(Monitor *mon, const QDict *qdict);
>  void hmp_tbstats(Monitor *mon, const QDict *qdict);
> +void hmp_info_tblist(Monitor *mon, const QDict *qdict);
> +void hmp_info_tb(Monitor *mon, const QDict *qdict);
>  
>  #endif
> diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
> index d47c9cd446..5d0afc56c7 100644
> --- a/include/qemu/log-for-trace.h
> +++ b/include/qemu/log-for-trace.h
> @@ -20,6 +20,9 @@
>  
>  /* Private global variable, don't use */
>  extern int qemu_loglevel;
> +extern bool to_string;
> +
> +extern int32_t max_num_hot_tbs_to_dump;
>  
>  #define LOG_TRACE          (1 << 15)
>  
> @@ -30,6 +33,7 @@ static inline bool qemu_loglevel_mask(int mask)
>  }
>  
>  /* main logging function */
> -void G_GNUC_PRINTF(1, 2) qemu_log(const char *fmt, ...);
> +int G_GNUC_PRINTF(1, 2) qemu_log(const char *fmt, ...);
> +int G_GNUC_PRINTF(1, 0) qemu_vlog(const char *fmt, va_list va);
>  
>  #endif
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index 6f3b8091cd..26b33151f3 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -85,6 +85,8 @@ extern const QEMULogItem qemu_log_items[];
>  bool qemu_set_log(int log_flags, Error **errp);
>  bool qemu_set_log_filename(const char *filename, Error **errp);
>  bool qemu_set_log_filename_flags(const char *name, int flags, Error **errp);
> +void qemu_log_to_monitor(bool enable);
> +void qemu_log_to_string(bool enable, GString *s);
>  void qemu_set_dfilter_ranges(const char *ranges, Error **errp);
>  bool qemu_log_in_addr_range(uint64_t addr);
>  int qemu_str_to_log_mask(const char *str);
> diff --git a/util/log.c b/util/log.c
> index 7ae471d97c..6477eb5a5f 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -50,6 +50,8 @@ int qemu_loglevel;
>  static bool log_per_thread;
>  static GArray *debug_regions;
>  int32_t max_num_hot_tbs_to_dump;
> +static bool to_monitor;
> +bool to_string;
>  
>  /* Returns true if qemu_log() will really write somewhere. */
>  bool qemu_log_enabled(void)
> @@ -146,19 +148,6 @@ void qemu_log_unlock(FILE *logfile)
>      }
>  }
>  
> -void qemu_log(const char *fmt, ...)
> -{
> -    FILE *f = qemu_log_trylock();
> -    if (f) {
> -        va_list ap;
> -
> -        va_start(ap, fmt);
> -        vfprintf(f, fmt, ap);
> -        va_end(ap);
> -        qemu_log_unlock(f);
> -    }
> -}
> -
>  static void __attribute__((__constructor__)) startup(void)
>  {
>      qemu_mutex_init(&global_mutex);
> @@ -206,6 +195,55 @@ valid_filename_template(const char *filename, bool per_thread, Error **errp)
>      return filename ? vft_strdup : vft_stderr;
>  }
>  
> +GString *string;
> +
> +int qemu_vlog(const char *fmt, va_list va)
> +{
> +    int ret = 0;
> +
> +    if (to_string && string) {
> +        g_string_append_vprintf(string, fmt, va);
> +    } else if (to_monitor) {
> +        ret = qemu_vprintf(fmt, va);
> +    } else {
> +        FILE *f = qemu_log_trylock();
> +        if (f) {
> +            ret = vfprintf(f, fmt, va);
> +        }
> +        qemu_log_unlock(f);
> +    }
> +
> +    /* Don't pass back error results.  */
> +    if (ret < 0) {
> +        ret = 0;
> +    }
> +    return ret;
> +}
> +
> +/* Return the number of characters emitted.  */
> +int qemu_log(const char *fmt, ...)
> +{
> +    int ret = 0;
> +    va_list ap;
> +
> +    va_start(ap, fmt);
> +    ret = qemu_vlog(fmt, ap);
> +    va_end(ap);
> +
> +    return ret;
> +}
> +
> +void qemu_log_to_monitor(bool enable)
> +{
> +    to_monitor = enable;
> +}
> +
> +void qemu_log_to_string(bool enable, GString *s)
> +{
> +    to_string = enable;
> +    string = s;
> +}
> +
>  /* enable or disable low levels log */
>  static bool qemu_set_log_internal(const char *filename, bool changed_name,
>                                    int log_flags, Error **errp)
> @@ -523,6 +561,7 @@ int qemu_str_to_log_mask(const char *str)
>              trace_enable_events((*tmp) + 6);
>              mask |= LOG_TRACE;
>  #endif
> +#ifdef CONFIG_TCG
>          } else if (g_str_has_prefix(*tmp, "tb_stats")) {
>              mask |= CPU_LOG_TB_STATS;
>              set_default_tbstats_flag(TB_ALL_STATS);
> @@ -553,6 +592,7 @@ int qemu_str_to_log_mask(const char *str)
>                  }
>                  set_default_tbstats_flag(flags);
>              }
> +#endif
>          } else {
>              for (item = qemu_log_items; item->mask != 0; item++) {
>                  if (g_str_equal(*tmp, item->name)) {


