Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 958E2A835E4
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Apr 2025 03:46:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2gyf-0007Zj-LQ; Wed, 09 Apr 2025 21:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u2gyc-0007Z4-Te
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 21:45:11 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u2gyZ-0005Jb-Tu
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 21:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744249508; x=1775785508;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/KB8z8hOWBRYbvUOO8tiJKcmD1yNGF8GQRhmYoE9Wk4=;
 b=aok9KD6DZ+cfGrTruJ38ynPOpscS5gPCzhexgin79b+I5Wofbs6t04DW
 F0OWhuLj09sMEjpH3aQDYafki2e1VV8xeTZMOdhC6oNcdiO690RogE6ni
 Oxy/R6XvsNqG1fvG953Z3QEo8bF6ZxXUUFl6L+sIa5U7N8fMomPHAwWMx
 sxF3BqG3dpcj4p6AD0kzZ8L+B5eztCBbJuRLggpJilbH2JtjcTT78RQWs
 EMDom+0dzf6zRZImDzI313gyqTx4tCogP1FLdVU6rkcxd+zb2I0C6ocby
 DnfRqVzj7A6/eRILxwy2EYDTG3OPGBCBjD4FthwaSfYao88P49E87D9ez w==;
X-CSE-ConnectionGUID: O0P/52nHSLK/2mZLOwarOw==
X-CSE-MsgGUID: pMG3d9dYTSKleSuWQ2yf2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="49411731"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; d="scan'208";a="49411731"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 18:45:04 -0700
X-CSE-ConnectionGUID: 11lffiwuR4yupNPakRgMQg==
X-CSE-MsgGUID: +xrPA8ELROOLKQ5ZY1E1qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; d="scan'208";a="151930053"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 18:45:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 18:45:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 18:45:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 18:45:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDJzDvILBE4tfLHenP9FSPgKh7oMoRHnSDDALd6P7b81Cfw3kwhxJhUexE0tApYulZKaHe6boqPWnKtBCWzhZqWrk7P3E0GVPvPt4YA7EBdnqek0PqAF+q0k2NRAogJc0cR+E8SzMCehvWk7sXi225eYUWDZQuWKJEUJ/6V16mOXLL2NqKms04b1xsdfMubx1knfTj/LFOYbtvRR6G0YgCwOjbe2gOSaQrKnKoZskxOpSg9TXBo9k4cKhZwIc4/R4Fi5KUzx82KqngX1Y5hBSy1T5X38jJ19pPa/J0Akl59a/2LJL9AFxD0AJosVObEsXCY0AdlbCR/zHMRQn0WaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lHFHrJY/j9eA5lpiZDtg8uq2jz09wrUptQ81zhJZVg=;
 b=TfkPwQwX+PD1hi+XZuPI36+dFABqPnKHMQD0FKsPaCQ058bdAkRJuPfjl6KLVDRqRfV1SCVS3UgwPqveO4Lt6S5ViBH7mUHCdPLUZO2v1OAZDci81OYJVNPf3odK4UN9aOf9KCPcvLqYZjoDxmTFJE72Voy/1isobaHkXC1kxumQHigsKCldVnnYkGpIXlhMQaqk8HXZXtxDt5/Y6WInd846UtkDsNoY0gFtjMhcm/Sm/UB1IDg/44Zc42qJXEdrBWj8mkY4gGSORHUra2SLrge0nUha1JqCjct4bfIHksZmqscz+HX43hu5hKqKDkXfH6NkWnPLXHqv1Kalc+7XFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 CO1PR11MB4930.namprd11.prod.outlook.com (2603:10b6:303:9b::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.21; Thu, 10 Apr 2025 01:44:55 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%4]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 01:44:55 +0000
Message-ID: <cfffa220-60f8-424c-ab67-e112953109c6@intel.com>
Date: Thu, 10 Apr 2025 09:44:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/13] memory: Introduce generic state change parent
 class for RamDiscardManager
To: Alexey Kardashevskiy <aik@amd.com>, David Hildenbrand <david@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Michael Roth <michael.roth@amd.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Williams Dan J
 <dan.j.williams@intel.com>, Peng Chao P <chao.p.peng@intel.com>, Gao Chao
 <chao.gao@intel.com>, Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao
 <xiaoyao.li@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
 <20250407074939.18657-5-chenyi.qiang@intel.com>
 <402e0db2-b1af-4629-a651-79d71feffeec@amd.com>
 <04e6ce1f-1159-4bf3-b078-fd338a669647@intel.com>
 <25f8159e-638d-446f-8f87-a14647b3eb7b@amd.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <25f8159e-638d-446f-8f87-a14647b3eb7b@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0235.apcprd06.prod.outlook.com
 (2603:1096:4:ac::19) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|CO1PR11MB4930:EE_
X-MS-Office365-Filtering-Correlation-Id: d52cba3c-8625-4e91-eafc-08dd77d14b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUVYUlZLcERkQ05oYk8vS0tiMWhsRXBPb3Vsb0ZkdVh2QnB5Tkp0RTc0TTBO?=
 =?utf-8?B?V0xHL3dYWWgxdHVLMXVlZFNXa1dqSHhscFpvRUdUc0l5YlZMMmZRdGtuV09Z?=
 =?utf-8?B?WEVlYTlla1NZd1dnWUQvQXIyM1VHUzVkbUo4RHBlQTJYaFVMOTBSQ1lrdnF1?=
 =?utf-8?B?WWo0T0JDL2c1MHpRMzYwOWJ0RUZoZGlUK1hCMkUzNEwrZTlFSWVRc0pla3hM?=
 =?utf-8?B?aDhNeG4ycTkxWkVZNjNqM1pGMW5RM09DaDJRTFdjaXhwc2N0bXUzNTlCeWF2?=
 =?utf-8?B?QW1nL1RqMUhzL3paaU80YnpzWlNhNDlKbGxQdGtIMU9SSFZXZm1WRVM5MUdy?=
 =?utf-8?B?WnhoNGpQK0g1YldMZWFtTFk4bjk2Tm00dUJ5ZWNQWGRWTDN1d3gvelBrZG45?=
 =?utf-8?B?N3JRT2lVZTViRGVDRko3bCtiUHV5WFJQdzFrd3ZMVWhpSmY5Y2ZvSHMzWEZz?=
 =?utf-8?B?TytNMk1EZ0ZiajlWYkQraFhLYmo4UW9CalNySzRSYVc2WEg1Qmx4c0Y5Zm05?=
 =?utf-8?B?TlJydzhVSkZnSWFaUVhURmtIVWExaStpaHJicmtWaThuSkRTZUEzeEpYRHhY?=
 =?utf-8?B?bGd6eEVBWmhvR2k3bXM5SUF4OThhUnYwWmJzT280SlVpbnp3dzRKemF2R2Vw?=
 =?utf-8?B?ZHJZSWhMMThLUk13elNsY0EraXdDaXpNNXhPaVFuTC95S1VIMEhvTDQ5cmJl?=
 =?utf-8?B?enptUzBpdkpjNVRaSUFWVzZOWmVFYXVlZ1R4TlhJNWM3enM5YmU5VFgvYXVl?=
 =?utf-8?B?QytmTnJQV1FvUW1iWVQremVpd0xXVTZTNzV3dXA3UHZ5NUpsNGxOeElXVjY2?=
 =?utf-8?B?clZUanllZEdWRVIzUGRhMlZLbUtZNFRRSEVuTGZGdjBhSnpUWExPNFVKTS9p?=
 =?utf-8?B?TmtvcVozLzJrTFhPenpFR3JhdHBQRGlWZ2F2NzlOa1l0eGpBNGR3MUNaelND?=
 =?utf-8?B?WmRtdEdoclpvQmNuVEFWakNyQkV1QUNFTXJZZis3TVNHejYzRnJRMzF3bWlI?=
 =?utf-8?B?YnlUT1BrSTE0QU45ZmQ5UmFJSXFRUVNnTWhCMCt5Y0VSTlpuR1RaU0hseW1U?=
 =?utf-8?B?d3c0Y0xtdzhnY3VKc01BOHEwQ3YvZ0Y5czQ5aWJmZERuUmlRVWY5Qk9La05W?=
 =?utf-8?B?QWJwZUtJKytKVytvSFFkeEdyWDR3RFlCUGVLaGh0VWNvcUpvWVE1U3FBM0VK?=
 =?utf-8?B?OUVOMGVoNTNGc1B4bzNadWM3dXFoOFNQclhyUkxqQUpXVmlGdFp6akhUUnRt?=
 =?utf-8?B?K2ZTaFQ1UWVYVlovY2VDWCtUKzJyMFZTbkdtcjBqS1htR05IV28rOEplOHNh?=
 =?utf-8?B?TGN1NXNpdVA4YUMvNlVZS0NaQ20wdFZJdVJnWmtSd2hZZWYwc2c4RnZZbXQw?=
 =?utf-8?B?Mk1LVThoSkFtcmNlNlFOV25SSURONUF3V2IwNGlMaHpjTFpaTUZVT1VkVTNE?=
 =?utf-8?B?RXZsRkZMWnJVR1I3djcxbmViem9oNVdHQURwbnZkdXhmR05abnNNWFQxeUNs?=
 =?utf-8?B?TS83bkQ4WXFFNFRmUVd6REw4amphUHhtN2h5ak1EZ0JxVTVmKzE3bVViRWNt?=
 =?utf-8?B?NVJXb1Z0K2FJRU5OVHVvSGtuenVrczFsUkJva05IZ0xVaFFwK2tpK1pZSEdi?=
 =?utf-8?B?aTdUMVlDU2JkdmloS0RMeHBMQmErMDdGTi9lWVNEdnJLcTdZaTA5dDRFK3Fy?=
 =?utf-8?B?V09ScE1iMzJaZXdRVS9kSTUzcXJ6QTBYNUg1S25EemYvTlFMVG9iaDg4dzFI?=
 =?utf-8?B?TUVvYTlycjlqdHQ4eENzejBQUmJoeVhhUmRPekd2Unc2UWhjUUkwd3B6OWRx?=
 =?utf-8?B?N3B3dDNmWTVuWWVMLzJzZ1pnTk9aSkdjc2kraGkrc0NXS3lLMXRySElHTVM3?=
 =?utf-8?Q?KmMsm3scJp+pT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGFxd0hQYjFLR0VmUmlFWU1IR1lyZjJVNGJXVVFZcVAxVTlLQmwxSnFlcFVX?=
 =?utf-8?B?VGRUQ1V4bUdEVlVvWi9oL253SU8wQVZuM01xK0hjQnI2OFk0N3RXU3h6ejYx?=
 =?utf-8?B?VVFuekwxVGNtQmMrK0ZIUkRxa0dNaS83dE1BeTJBRkdOQlF3RnZnWTdsdE1L?=
 =?utf-8?B?OG1iTVlmdCs5M0h1VjkrQmcvWDBMT0Z2STFvQUJQQkU5MmJVblNFNXFLS2VE?=
 =?utf-8?B?RFJTbHFqVVdhbm82WnlScFJyZk1FRjV1UHpiZDVsaWNVSDdQNDFyRkRSajNN?=
 =?utf-8?B?cHJDNm1XN2lkc01qcDB0OFU3UTFkcFNyaExIMWovZVZ3ai80T3kvbHNIcVEz?=
 =?utf-8?B?Vkh5cEI5ZjZFSncreFlOM2l3cllqS0NKY0pqU0lLd0J5NFg2Skw4NTQ1QjYx?=
 =?utf-8?B?N0svemErNk8wbC9QTXlSQWlaUURrRjlTUlYvK0g0UjI2c0FBdUppUitFMTFB?=
 =?utf-8?B?S1lEK3BYZU5rWnFrNVpSVDVTbE1UblQrZ1h0MFlUM3JucmNCZ0o5cWRVNmo3?=
 =?utf-8?B?VUVpMDFYTU5pL3N1L3NjRS85WkxLaG1JK1BFLytuVG9IWkZUQUNaRXBZVkh6?=
 =?utf-8?B?WGJpQ2xzVWdHSndENEh2QlAzWG9pOUJHODUvbmpWYUtrM20wRUZCRndjMHBw?=
 =?utf-8?B?TEFGaGhiWHRNdGxPWm12WHhtck1HYTJkTlc3NFlKQXQ0OGw1K0NIcy9sR2Ey?=
 =?utf-8?B?a0t3eG5MdDMxZi9ISjM1YWhGUVhKdXhMQldWSzJuQlNkUVR2MFBiU05GZXZB?=
 =?utf-8?B?dUtVZS9GK1o2WG9kSldSQkFsVnNXTGN0T2lxa1o4UXJtbU5ibGFDY2xYdTEz?=
 =?utf-8?B?VFlLU213YTFiR0FUQjJBbTdkUHBWd2d0SmZtcXpRN2tXZ2NLQXIySmIvaHpF?=
 =?utf-8?B?U3pQeUlTdnFPemZWT1RRZmZWY1FReGVqUkZQMnMvZGtSaWZCUW5FUmVTdGE5?=
 =?utf-8?B?YkpDcENKZjJLZGtoWU4vT2pWYUhMcUtnWFEzck5TVTl0NkpIbmcxN2M0V2lR?=
 =?utf-8?B?NTJkc24xMjM2Rkthc3oxYlpPdTQ1azhGd1Z0UFJZR1FxclRXRm56Qk5OUWR6?=
 =?utf-8?B?TEZJaUlucU84bHhCVlErdUtSeHB6SWRkT2JBQWdMZkNES1Z1eTUxalowUnFs?=
 =?utf-8?B?Vm1jQVBCZTVFYnBMMlhJcjZoVVgzNHJCYnRHckh4THFsR1M5MnBUd2Y4Sndn?=
 =?utf-8?B?Rk5takQzbkpvOUNub1lsaitTeEI5QUI4cDVXR0MrZDNYVGVCZFJBdXV2bzky?=
 =?utf-8?B?K0M5N1ZuaU5JcmxTNkFyQUlqSGdqUkMycU1SRTdTUEltUm9wRU9HSVZ6WVZi?=
 =?utf-8?B?aWpkckhSN2ViRllEZXRlUlF3REl3RktxZmZvK1p3T3JKbVJpc1lBalgxL1ZI?=
 =?utf-8?B?aTNiYjVUaWFISlJwUU54TGMrbEIxZVRzMkQ3YTJ6SERxWmF0VWRDQStWSVpP?=
 =?utf-8?B?VHdjU1lWek55WEF4QVRDTnlxbkM3NzF0bWFMdlc0YmJnL1c2QVVpNVJOSWJW?=
 =?utf-8?B?VzllVFFSQzY1K1ZsdHpKZ3VEQUMyS0MxOGRGU3k1NG8xalVFSTlLMTRic3hi?=
 =?utf-8?B?VjhiU2V0TXppTjdVd2xSZkoyRFRxK3BwOTZPLzRGN1ZhNFcyMGc2TFk3a3Zz?=
 =?utf-8?B?RFU5bk53a3ROV3VTS3pDYkk0V0lpMTlXM2s5UmRqQlFkdjdhYjBDUWhnQ3F6?=
 =?utf-8?B?clZBRVI5dmcva1gzTE5lQThsRHRkZGptN2VIbEFaMjhka2F0emRYaGVKVThW?=
 =?utf-8?B?Y1pxeGkwSHlpMkovK3pFZDJrbHpVN25qVld1aG9WYlBRR3ZuODdUcG1XRnlV?=
 =?utf-8?B?TGFkZFd2VmlHSDNNR1VVNXlUN2pRZjJxOFllTW0xdy9MSlFTcFFVQU1LdFhX?=
 =?utf-8?B?dzAvVC81NkR4WHlOamJGZ2c4TFFFVks4eGcrRGl3ZWpjQWtLdkFxd3Q0bmZr?=
 =?utf-8?B?bUEzOGRuYnFoVEt1SUg0Z2ZwbVBhZGE1VlBaVy9NU3JDQUFDSS9HQ2N3Ynlu?=
 =?utf-8?B?YkN2Q1BXMUgwaWdid2hQQUdwak5CaklUcUgvTmEwbFJKWkNyRnNlV3M4clpE?=
 =?utf-8?B?NTZWNVNab0NjWUNlZnBLSms4UnphQ2laa2RySzVtY2ZsR1lyOVA5SldnMHRX?=
 =?utf-8?B?MG1PbDhJNnNNTzQ2ckRWL3h3K3pWSGRxbjk1THV2aC8vZ1dEN3ZWcFg3ei9a?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d52cba3c-8625-4e91-eafc-08dd77d14b3b
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 01:44:55.4056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K20JgZLbvK66dMT4VX7pQwiGtULPIwrx+rKOU3J5Oi9q06LHxBuLJ19CsvwEEt0ga7OAEIqKP4AcRqu+b43GAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4930
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 4/10/2025 8:11 AM, Alexey Kardashevskiy wrote:
> 
> 
> On 9/4/25 22:57, Chenyi Qiang wrote:
>>
>>
>> On 4/9/2025 5:56 PM, Alexey Kardashevskiy wrote:
>>>
>>>
>>> On 7/4/25 17:49, Chenyi Qiang wrote:
>>>> RamDiscardManager is an interface used by virtio-mem to adjust VFIO
>>>> mappings in relation to VM page assignment. It manages the state of
>>>> populated and discard for the RAM. To accommodate future scnarios for
>>>> managing RAM states, such as private and shared states in confidential
>>>> VMs, the existing RamDiscardManager interface needs to be generalized.
>>>>
>>>> Introduce a parent class, GenericStateManager, to manage a pair of
>>>
>>> "GenericState" is the same as "State" really. Call it RamStateManager.
>>
>> OK to me.
> 
> Sorry, nah. "Generic" would mean "machine" in QEMU.

OK, anyway, I can rename to RamStateManager if we follow this direction.

> 
> 
>>>
>>>
>>>> opposite states with RamDiscardManager as its child. The changes
>>>> include
>>>> - Define a new abstract class GenericStateChange.
>>>> - Extract six callbacks into GenericStateChangeClass and allow the
>>>> child
>>>>     classes to inherit them.
>>>> - Modify RamDiscardManager-related helpers to use GenericStateManager
>>>>     ones.
>>>> - Define a generic StatChangeListener to extract fields from
>>>
>>> "e" missing in StateChangeListener.
>>
>> Fixed. Thanks.
>>
>>>
>>>>     RamDiscardManager listener which allows future listeners to
>>>> embed it
>>>>     and avoid duplication.
>>>> - Change the users of RamDiscardManager (virtio-mem, migration,
>>>> etc.) to
>>>>     switch to use GenericStateChange helpers.
>>>>
>>>> It can provide a more flexible and resuable framework for RAM state
>>>> management, facilitating future enhancements and use cases.
>>>
>>> I fail to see how new interface helps with this. RamDiscardManager
>>> manipulates populated/discarded. It would make sense may be if the new
>>> class had more bits per page, say private/shared/discarded but it does
>>> not. And PrivateSharedManager cannot coexist with RamDiscard. imho this
>>> is going in a wrong direction.
>>
>> I think we have two questions here:
>>
>> 1. whether we should define an abstract parent class and distinguish the
>> RamDiscardManager and PrivateSharedManager?
> 
> If it is 1 bit per page with the meaning "1 == populated == shared",
> then no, one class will do.

Not restrict to 1 bit per page. As mentioned in questions 2, the parent
class can be more generic, e.g. only including
register/unregister_listener().

Like in this way:

The parent class:

struct StateChangeListener {
    MemoryRegionSection *section;
}

struct RamStateManagerClass {
    void (*register_listener)();
    void (*unregister_listener)();
}

The child class:

1. RamDiscardManager

struct RamDiscardListener {
    StateChangeListener scl;
    NotifyPopulate notify_populate;
    NotifyDiscard notify_discard;
    bool double_discard_supported;

    QLIST_ENTRY(RamDiscardListener) next;
}

struct RamDiscardManagerClass {
    RamStateManagerClass parent_class;
    uint64_t (*get_min_granularity)();
    bool (*is_populate)();
    bool (*replay_populate)();
    bool (*replay_discard)();
}

2. PrivateSharedManager (or other name like ConfidentialRamManager?)

struct PrivateSharedListener {
    StateChangeListener scl;
    NotifyShared notify_shared;
    NotifyPrivate notify_private;
    int priority;

    QLIST_ENTRY(PrivateSharedListener) next;
}

struct PrivateSharedManagerClass {
    RamStateManagerClass parent_class;
    uint64_t (*get_min_granularity)();
    bool (*is_shared)();
    // No need to define replay_private/replay_shared as no use case at
present.
}

In the future, if we want to manage three states, we can only extend
PrivateSharedManagerClass/PrivateSharedListener.

> 
> 
>> I vote for this. First, After making the distinction, the
>> PrivateSharedManager won't go into the RamDiscardManager path which
>> PrivateSharedManager may have not supported yet. e.g. the migration
>> related path. In addtional, we can extend the PrivateSharedManager for
>> specific handling, e.g. the priority listener, state_change() callback.
>>
>> 2. How we should abstract the parent class?
>>
>> I think this is the problem. My current implementation extracts all the
>> callbacks in RamDiscardManager into the parent class and call them
>> state_set and state_clear, which can only manage a pair of opposite
>> states. As you mentioned, there could be private/shared/discarded three
>> states in the future, which is not compatible with current design. Maybe
>> we can make the parent class more generic, e.g. only extract the
>> register/unregister_listener() into it.
> 
> Or we could rename RamDiscardManager to RamStateManager, implement 2bit
> per page (0 = discarded, 1 = populated+shared, 2 = populated+private).
> Eventually we will have to deal with the mix of private and shared
> mappings for the same device, how 1 bit per page is going to work? Thanks,

Only renaming RamDiscardManager seems not sufficient. Current
RamDiscardManagerClass can only manage two states. For example, its
callback functions only have the name of xxx_populate and xxx_discard.
If we want to extend it to manage three states, we have to modify those
callbacks, e.g. add some new argument like is_populate(bool is_private),
or define some new callbacks like is_populate_private(). It will make
this class more complicated, but actually not necessary in legacy VMs
without the concept of private/shared.

> 
> 
>>
>>>
>>>
>>>>
>>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>>> ---
>>>> Changes in v4:
>>>>       - Newly added.
>>>> ---
>>>>    hw/vfio/common.c        |  30 ++--
>>>>    hw/virtio/virtio-mem.c  |  95 ++++++------
>>>>    include/exec/memory.h   | 313 +++++++++++++++++++++
>>>> +------------------
>>>>    migration/ram.c         |  16 +-
>>>>    system/memory.c         | 106 ++++++++------
>>>>    system/memory_mapping.c |   6 +-
>>>>    6 files changed, 310 insertions(+), 256 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>> index f7499a9b74..3172d877cc 100644
>>>> --- a/hw/vfio/common.c
>>>> +++ b/hw/vfio/common.c
>>>> @@ -335,9 +335,10 @@ out:
>>>>        rcu_read_unlock();
>>>>    }
>>>>    -static void vfio_ram_discard_notify_discard(RamDiscardListener
>>>> *rdl,
>>>> +static void vfio_ram_discard_notify_discard(StateChangeListener *scl,
>>>>                                                MemoryRegionSection
>>>> *section)
>>>>    {
>>>> +    RamDiscardListener *rdl = container_of(scl, RamDiscardListener,
>>>> scl);
>>>>        VFIORamDiscardListener *vrdl = container_of(rdl,
>>>> VFIORamDiscardListener,
>>>>                                                    listener);
>>>>        VFIOContainerBase *bcontainer = vrdl->bcontainer;
>>>> @@ -353,9 +354,10 @@ static void
>>>> vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
>>>>        }
>>>>    }
>>>>    -static int vfio_ram_discard_notify_populate(RamDiscardListener
>>>> *rdl,
>>>> +static int vfio_ram_discard_notify_populate(StateChangeListener *scl,
>>>>                                                MemoryRegionSection
>>>> *section)
>>>>    {
>>>> +    RamDiscardListener *rdl = container_of(scl, RamDiscardListener,
>>>> scl);
>>>>        VFIORamDiscardListener *vrdl = container_of(rdl,
>>>> VFIORamDiscardListener,
>>>>                                                    listener);
>>>
>>> VFIORamDiscardListener *vrdl = container_of(scl, VFIORamDiscardListener,
>>> listener.scl) and drop @ rdl? Thanks,
>>
>> Modified. Thanks!
>>
>>>
>>>
> 


