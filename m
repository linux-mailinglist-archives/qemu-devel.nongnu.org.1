Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 463C6AE11FE
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Jun 2025 06:07:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uST0Z-0000MQ-2K; Fri, 20 Jun 2025 00:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uST0R-0000LP-GZ
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 00:05:38 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uST0P-0000qK-07
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 00:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750392333; x=1781928333;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=i8mnhtmun4LgBYtg4G5jJRalFU6uLlokvs58dDApbiI=;
 b=e3iRITne8gS+KAOPmwSZ9CLAvWTGjEDfU+GMQN3BDccfupYXfthg8DuP
 7TiIMFIZMDKHLfPGf5CwJDcMoCuvE0vF2XIEp5y6E0oVgbeDz6Z2KqU6K
 uKGCiKgmcvyzgGMGCBwiKiUHUHBAjD9s0276hMOUSKhqeUfSW5iNmtnJ9
 /C36pR2L1JjJAVEvbEKj8EpDUqJnOgR7h9ZO47jlZLcfgugED/r++c/A+
 Yjp7jPK2O78+QNjQshWoH/tq+ggCPmnScq3YcxH9dTAxSB4j3v9Idgapx
 l8wcSTlWj+1siJGG2xREJbepojPukMHWVcBlw57nLZfmdtYBs1Q+xEY2D g==;
X-CSE-ConnectionGUID: xAnq2lDuT3GZ3QsFiLYm8Q==
X-CSE-MsgGUID: Wk1QJOj9SCqo8byInb6aFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="56444847"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="56444847"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 21:05:27 -0700
X-CSE-ConnectionGUID: lZPuPtc4QU+8CUb5vBLWMQ==
X-CSE-MsgGUID: CXTxSOoyTs2Gz00MsIEFug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="188028626"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 21:05:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 21:05:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 19 Jun 2025 21:05:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.56) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 21:05:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLiUK4YVG7ZBpI8Chr0jGUkjnfqe7itYujFRXrF54yNKumsBz1eI2xjQDBQn4ehbve4z9JSLwhFfbtu9N3dqnpznjo9o3GoJBkUkfCVxjRmHfiGPTHg4yju4Tz24ybZRu2OTWKDMtRSYzgozT2BL3u4HI+iGfCbHaS9PSJzOmJL/tczVnsChXZgU2psBb8iBovMMW771AtrUzJqgl3Dpkf61FPiEi4kDGf0Jev1RVhjHX+hqfrCwLJraOwPT5nDNA8IPdMrkb8a7SBoiHExw5n+yqKETNbP3zDF4+E7C95KokThCX2oPD8R7N5AsI7VqSAAEhDjs0rAEePAjWRIM7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNvLVClLGZ21D0gKpRYoymNPqlC7Qyg3eRd7GZK+PjE=;
 b=CoiU0l7q81o4IG5BQuwKNM6d//xGjfyyNRnIRlWXbX+vENOL5Vq4itB+b6Lwa+w0FU8um/05UtZMY4f/mkvfmsueySlFa6m6GD7N5JmXE9kSQhtJgnaqzmIlOC18Et41cd0ZEoIwfH0T8+7ZSV3Eu/WKykShgLWON4465kSRrdLZ7h2KCtwC0mEd08uEUzC+LfTjG8zdkP0OB3q4uFGxgKqNEP8TcOk/Hn30ya2zBZnOmg6BKvDgYokN3eMxOJh0pTpiRE7EjXaHkhgYKt/wMoF9TVzKZnZf4ai/jtZEr/D0LfLIahzkgze9vyYJqE/MONgF7svImZHN4d/cYFkNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Fri, 20 Jun
 2025 04:04:55 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%4]) with mapi id 15.20.8835.034; Fri, 20 Jun 2025
 04:04:55 +0000
Message-ID: <b890b7f4-8765-4f44-9334-8a14178a498f@intel.com>
Date: Fri, 20 Jun 2025 12:04:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] memory: Unify the definiton of ReplayRamPopulate()
 and ReplayRamDiscard()
To: Peter Xu <peterx@redhat.com>
CC: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>, 
 Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Michael Roth
 <michael.roth@amd.com>, <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
 Williams Dan J <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>, Xu Yilun
 <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Alex Williamson
 <alex.williamson@redhat.com>
References: <20250612082747.51539-1-chenyi.qiang@intel.com>
 <20250612082747.51539-4-chenyi.qiang@intel.com>
 <0de41d54-31da-466c-a6bb-f45ff919ced5@intel.com> <aFQe1NcMSyCTiDoF@x1.local>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <aFQe1NcMSyCTiDoF@x1.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|BN9PR11MB5289:EE_
X-MS-Office365-Filtering-Correlation-Id: e92b2120-74ce-41d1-c74d-08ddafaf9d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkVWOWJFNytnN0Jsd3JBKzJOQkRLcDNFUmlRem9PSUY0M01TVmV6Nnc4YmRt?=
 =?utf-8?B?UXN6KzlhL3JyQWVZNHZvdWNYdE5EenBLS1Z6eFJlNnFQS0p1NGtyWTM3UzN3?=
 =?utf-8?B?dkhPZGtZTEErTk5LSlRuY1l5N1ZtVDJBdGpzalhzTThWeXJyRDFDM0FHYVB5?=
 =?utf-8?B?TUQ4S2NtNmM2dTZNbm9xREJpUXhnK2VFNDdjbG8zSDBLVFBGOWVlRWhLVWJj?=
 =?utf-8?B?SUF6MWl6NzUrczV3NEp4OE8yQkwwalA1SU05c29wR01Pc242MFh6a2JiM3lC?=
 =?utf-8?B?YVo4RUpkc1M2THpRNHZzdHh2eHhwQjlmK3RCUFdwdWxzRjlSSXZ2c3NyT3Y2?=
 =?utf-8?B?OCtSeTJRSmk0VUI4ank3TGluQXRUaDAvLzROTFNURHRQZmlWVHlYRndNMXlY?=
 =?utf-8?B?QmpUeTRkb0hNZVhJK0tuUlpUNXc1OE1hUDRYazBTdjJmbHRlN3ZNNEpWbmc0?=
 =?utf-8?B?M295Q2xkOXgvc1NHdldHUmNCZ3pTQmp0SkhEbWV2Mk95Sk9tVVpadk43d0Mv?=
 =?utf-8?B?bW1iY0tnOEU4cGYrUHI1dTlRM3RXWC9OSFVrSDVhZnEyKytaNTMyNllqWHZQ?=
 =?utf-8?B?WE1QWDFQKzY3cXJwaGIrUmVTbUpZVXMvWmp0SUNmM3pRK1hZMnJCZjVsZ3M5?=
 =?utf-8?B?WmFXYlJlS0ZmNS80MlpDRUtXM0pGTXd2L2t0QlNPcjBSdi8yL3B0ZnFkcjBk?=
 =?utf-8?B?d2xRenhNTmplYzEzb3dITVBJd3huWlRqb1BhSnRvYzMyQWUwbEFPL1UwdnFH?=
 =?utf-8?B?OTJiZUx0QlV0WXZSNEVUSk5yeWhmdTFnZkszRU5pOXcyTkgzaEdFODNhekY4?=
 =?utf-8?B?UkN6dHIyWDk1S1c4RHlXbzdoTExiaEpDbDN6ZElyWlhUVDZ1bWgwSzFUUE1L?=
 =?utf-8?B?VWlMWWVnS2Jvajc3eExHV2FvVmhtMnRMR2lrUWEvSzh3L21TT0FrNndUekZr?=
 =?utf-8?B?S0txVEh4WTQ1UHJudVdaandFczMrZE5LVTBJVUY0M0RoNEN5Ti9kMEVGcU13?=
 =?utf-8?B?cER1dFdVTHJTdG9CNWZScHlsdWNCVEhpbVFnL05TSWhnbTlydnRvMWw4bnlR?=
 =?utf-8?B?UkVYSmNwRDlKbHZlcFZuUDd6bVdUN25MRzNLNjloWUxmbWJKU3ZNMk5HbUdG?=
 =?utf-8?B?dnZieUJLRjY2V1I2UkVLenU0THNBaUY0YVl4TUk0VEpMY1pmNmttL28zT0Z6?=
 =?utf-8?B?alp6SFB3dTczWW85UTZEMjg3Y1hLTldUWXZqOGU4anBwQWZMRGpOYmkwNkJy?=
 =?utf-8?B?N2x5bVpkWFZzRC9Scjd6QUN1dDB3ZGJzMHJ5N3dZdHV1M3QyNUdkdW1CYkk3?=
 =?utf-8?B?NW4vWGN5QzJTd0dnaDBaYWdXMHlKenZSdW5XaklMZEVlMzF5NTd4TU0wY3JF?=
 =?utf-8?B?R0t5YWJYZFdYMkhNUFBHdnh1MXcwWXRMbTNrYmhjQ1ZYT0JkOEhyZGdEbzdv?=
 =?utf-8?B?bGpEZkEzdDdXb2ZWd01CWXYzSWhWZU5IMTZJNjVoTDU0cjZCc0sweDFWbjVE?=
 =?utf-8?B?dmZxMUY1bkd0WWxtWkpaUjMwbFlEZWpza2JyVDN2ZGp3QjNQY2ZzVlBDaDZw?=
 =?utf-8?B?dzdwRHVpa1Y2cTVNQ25iTExwT21zL203ZTB4eHpwazE5VGFxV1VacHdab01V?=
 =?utf-8?B?enZlWWVhdTd4ZlJ2a1RKSGNQb0taSURQelFndjZDS21lREgweWdINU1TWnE0?=
 =?utf-8?B?eHJUcy9yNGxUdmMxOXZBK2RxR2p3Q0d4Y1BSa0crUTZ2WWMvai85V2U2alU3?=
 =?utf-8?B?SUlwS25nc29QWVJCL2h4VkhBTDdSckNBSkNVbFIrRTQ1MTErOElBNFhFVndR?=
 =?utf-8?B?NEp5TGNMQmNCV0NEdU51aEFXbFhoNTZmNnlJSE1iK3YxVkROWnBhbW16RHBh?=
 =?utf-8?B?VjQwbkdoSFBQNkwyM21raUxlR1VSRU43b0V0WVA2ejZwcGRkQjVjUHU2RHBy?=
 =?utf-8?Q?dqf4vEute3VZw1BYPzNJOB3vrBM4u+Rf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3AyRnFleGZwTC9lZGZxZkx5YllZUnlTd1hkejlQSkFFdzVrNkppL0o0c0lI?=
 =?utf-8?B?bkdBejZ1ODRQMGwxN05kNEVxNnFmK1g2UEFMWG9PN2h5VE41d0gxcVhINzZz?=
 =?utf-8?B?Ym1HR0dQMUYxK2pWQWFYa1VIUlFDZW5TV1daMlUwbXBIdmVlQWMzQVR5T3ZG?=
 =?utf-8?B?QW5NaURSWmNoazR1Wm8vL1RHUk9KUXZsQ253eDhIeEdrdzBsQTZnR1NvVmNq?=
 =?utf-8?B?VkpNR0UxMFBEQWQ1a1dGUnRWalhjRUo3MzRDRUR3WjNhOWdZZmFHeTdNY1lZ?=
 =?utf-8?B?UEdWdDRnM3NGb0xCbnBYMjdYRUkvUmgrWHl6c2doWXBwSVo2Rk9GM0RaTGpo?=
 =?utf-8?B?WWRGN2NpMlZYSTd3WXI5OGZ6UDZYY2wxRVBNcU90Yk9JZG9EdmFlakVtY0dK?=
 =?utf-8?B?dDBhQWVrWE9JeUNnQ0ZnN3ZPQ2dFNDlhUHdlSUhEYTV3WUtFeWRjVUZ3YVho?=
 =?utf-8?B?Q1ZHbHQybzNBRnBWVzA1L21NMWNiNFJxWGVpVTJBelY1MXl2c1dQRG9IeFF5?=
 =?utf-8?B?MTVyRkZlenpPNm5XNHFTVUhpZlNZQmV6cnpCZGxkY3FwUkZzWTlxaVIvcVoz?=
 =?utf-8?B?VmgzcFJaQXNLUGZjcDhsc3FWblRkVmlGNldnN0xEa3lSYXZJYWNneXV2Z05P?=
 =?utf-8?B?YlQxbHFoQXQ5ajd1MjlMaytaZ2NVYVkxUUU2ZEJId1Jsdk1VazdlVXljOWhP?=
 =?utf-8?B?UEZkZTVQcFlVamxaVytsZ2NsMUZCTGVIMHNXWlhBelhWbHo0OWsrSzRSNi9l?=
 =?utf-8?B?bVpsekdiQmZnVkZ2VWRWQUFvdFpGbUlHMGVGNVY4UXB5R21GQjc5NmpWalU0?=
 =?utf-8?B?NnhlK00vRE16b2RyTTJBdmd4V3V5Rk93VjBiMjNDckVOWUZzWTYwMnkvdUY0?=
 =?utf-8?B?OGZTU3VEWG44aVI2OFZlZFVCLzU4TGhJRjJPT3lpajUxdnpyeEVsRzBRT0Vp?=
 =?utf-8?B?Z0hUNHMwLzBKMjIwbTltSnl4aXB3MkgvZ3VGOGkvczJuT0EvRDBFczZMdnQ3?=
 =?utf-8?B?UkF2bVpuSVlaWGJsdE8vMWRvcGkzVjY4dGN3ODV4V0haeTlJZDRMWm9zbmR2?=
 =?utf-8?B?ak5LZEZFWmJkb1g0RTRNMzdaTVczbTFML05hbHJIV29keU5uR0JmLzltL1di?=
 =?utf-8?B?alRjLzI4VnkxQjZ0Vzcvc3Axc3gwN2xrZHdkdFBOa1ZTbmtIajhLYVRkTnlG?=
 =?utf-8?B?ZjRHaUUvUXhpdnlyVGc2VWgyNHArWW5QK0lYVmVsT3BQZHJkM2daK3N0MHZE?=
 =?utf-8?B?NEhQNG8xK2Vib1BheitxTi9vVjNYNkRGVDN5QlR5Yjc2UHErK0ttVExEd255?=
 =?utf-8?B?di85ODl3a0xjVGVVTXVIeUgyNFY2d25wVUFybW5BOFFHNVRiVkhFaEU0dXNT?=
 =?utf-8?B?bXFHREsyRjJGWXdFak5EaGkzWDVmZExmWWRUeEVNTHdHdElDb2s1RjNJR0pD?=
 =?utf-8?B?aG5GQTkwYXRQdXkwVHBHeG5FbDNsR1BWTDErS2lmc09YdGxQUVM4NzVuUC9l?=
 =?utf-8?B?ZTBld2UrY2JJWEJudEcxUUJ5TldGa2FRamJTUGtlREcrMDJSOGdzZEVQR2xS?=
 =?utf-8?B?UlVlMWFXa2FvcEZqcW1Ec1VKcFYxSDk4eGx5UHhXaDN5TGJ4MlMrR1BGTzZQ?=
 =?utf-8?B?bDVVR1ppaGtZbnpIRzBZSjU0cUhmR1pVYU9ibHZTVmdaL2s1RlNzbVlqaFBG?=
 =?utf-8?B?cEZwYVZDUGd2K1dmNlpzTVhINklXZnE1MFg4WS9HeWFzNXZlamlON3pFamhm?=
 =?utf-8?B?WVFJQmZZTERRaVd5Wkg5ZWhhZm9GanNRTTZTOGhmQkx4a3dlVi9RRnl0Qzll?=
 =?utf-8?B?TlQzeFNGSkRqb1JUeUc4U2l0Z2FHaVJ4WXc3ek1jOFdLbzB6SFlITXk1cjVU?=
 =?utf-8?B?SGxjRDdnVW1oelUwSzNvQS90bi8wZTlHaGJiUjVDZDJlbTIxeWgzWWlxandM?=
 =?utf-8?B?RHZhdU12dy90ODZZcTdXTGZDbHZJcjNnR1VJVzJrUGg1WktFS3JnWXBvdi9k?=
 =?utf-8?B?UnhYNmxiWWlJeHNIb0tic2I4Lzc2YitYY0kxbVk0NlNmZC8rcWlMb0s0eDZk?=
 =?utf-8?B?VGNORURSanQ0SE5yQ1ZOUkZ1MFNBcnllUCtkY2JraXNKNVhKZFVTajJaRWQ5?=
 =?utf-8?B?YUgyaTdLR3IyVFZmUjJnNHNWZE81ZGorRG40RFRFWlNsQTFLTi9LbmFEQmxW?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e92b2120-74ce-41d1-c74d-08ddafaf9d69
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 04:04:55.5509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2yE9mMMSgr3UBLfn29/btZH3mKZFiqgtK8vlD40kPgou5graw9o13xnP4ZCdpxMi2ZprZNSMaBhINauycPEfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 6/19/2025 10:29 PM, Peter Xu wrote:
> On Thu, Jun 19, 2025 at 11:06:46AM +0800, Chenyi Qiang wrote:
>> To fix the build error with --enable-docs configuration, Add the below fixup
> 
> Thanks, this works for me.
> 
> Though I just noticed it has more than the doc issue.. please see:
> 
> https://gitlab.com/peterx/qemu/-/jobs/10403528070

Thanks for reporting. I didn't try the different configure combination..

> 
> So 6 failures (and you can ignore the rust warnings):
> 
> https://gitlab.com/peterx/qemu/-/pipelines/1878653850
> 
> WASM complains a bit more than others, but worth double check from your
> side too.

Most of the warnings are not from this series. I think they can be ignored.
I have sent a fixup for patch #4. I think it can resolve those 6 failures
which report the same error.

> 
> Thanks,
> 


