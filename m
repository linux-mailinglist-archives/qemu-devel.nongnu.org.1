Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E92798B25FD
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Apr 2024 18:06:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s01cF-00063N-9s; Thu, 25 Apr 2024 12:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1s01bl-0005nM-9j
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 12:06:04 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1s01bi-0005gD-Tt
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 12:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714061159; x=1745597159;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ypQmBaqoXAcxCb6eyazFVv9muorvBM4i8vbupTsHNYA=;
 b=fUd91epnO8pgEGgnIhUFcoOUtF9jxftuTBDje3rNQ2DsLME4OdkF8cDz
 Uz/XnuuQ2a6lKN+HM44wO9TAyMNp8Ishw4qI+cqWGGsWje+BzTSBRI/5z
 +pM2e27mMZ2GBgsvYYuUkFLR93OzXB9VreoepcDRi3Q71qoP6m8jWNuSk
 OqevOwumrk4kIEpK+J/B0A537FBKgUER3Tin9bnD1bqrsksPSdngj4eTV
 rKL4UqdBCKRvw/apx+bxwthS7s+YEgwIUisoB1sTcAF43szGilGG8DewT
 j4pNHYnCgZrRIlfKDYhnHLmOfiuS6YHZURDeg3hj/HZoDqA29WOtWCfI0 A==;
X-CSE-ConnectionGUID: BbnnI06xTqybYMH+gpUOGQ==
X-CSE-MsgGUID: Ea2egdvET1CMR7coTFI13Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="32254664"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; d="scan'208";a="32254664"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2024 09:05:43 -0700
X-CSE-ConnectionGUID: bvnOkDEmQDOg/V/i4il+yw==
X-CSE-MsgGUID: VtWi5n2GSM+Q20vw+qDOUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; d="scan'208";a="29746794"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Apr 2024 09:05:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 09:05:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 09:05:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 09:05:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 09:04:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LstExSPbmtq70RDLqpuS8Z6dzEGpoIajIKvhzoKzqMYsJO1KooSl+iSqXkrlnj+FXVc3BvYEL3EHP1+7V1cMtX3ZMo4mH4jyL+Xh84wwxK6ylIwQYoTkvvvsl5+X/Gr+bsyxq4A+mVqRnBRj9BfCA7YSF4L0+XMXHqIc/pl1WipYZAfqkvh9Do2YFPiV6EHbez2HSGIqhz3gWpJOA7ItlypTIBFSfhxTQaCNqaHAJk5M8KAlRxrzjER88xe3pP766Ot8KIPm17QlG09s4SsdwuVxkeIYiW/UdUkMDhqtSmQCjTvXHda1h9ayovjTFFLLYpdBcmFAWN5hvmI+/MVD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJLUWnChbMt3MNspb3N1UiQrQVDwk0yb2Q5J/2S8osw=;
 b=Wy0B3WdbjzzscF41yOz27u0jGwDQhqTPrc973N7B1c4TZ3Pi+n+MmlkHSttM63jjB1FiSBDmGocjQtkdeuP/EvBvlI1upUnXQIFkGl6C9ENrGPbHK06OnVsHHQn0OZYR4mO+tVxZw1b7+FLwSXRfk+Zx3Af51cKk1zsZoxGXQDEg6lTVgYAMCKAqoZWH/Pyse+R+Xt26Uy6OKzFmb0hxKzM0b48943D3Lsm7kwe3Oyp4xhmb8yP5rVYD6kM20DsHazXEF+sX8qH4JC3uxdvuBGctEVlpOrmcMFUrPAq15b/UEjMIgHdj7LFJHiiBR8axEIMiC5dhyJ9T4EQ86GHTKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB8105.namprd11.prod.outlook.com (2603:10b6:510:254::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Thu, 25 Apr
 2024 16:04:47 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.020; Thu, 25 Apr 2024
 16:04:46 +0000
Date: Thu, 25 Apr 2024 09:04:43 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, Ira Weiny <ira.weiny@intel.com>,
 Alison Schofield <alison.schofield@intel.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
 <dave@stgolabs.net>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] cxl/core: correct length of DPA field masks
Message-ID: <662a7f1bae7c0_f81752941c@iweiny-mobl.notmuch>
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-2-ruansy.fnst@fujitsu.com>
 <ZifzF8cXObFiDiIK@aschofie-mobl2>
 <66282269c8d4e_d2ce22941e@iweiny-mobl.notmuch>
 <5563b68c-48ab-48e3-bbc9-b93236ea0543@fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5563b68c-48ab-48e3-bbc9-b93236ea0543@fujitsu.com>
X-ClientProxiedBy: SJ0PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 84edaf72-9836-4050-6c1f-08dc65416daf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QW8xNng4OE1tS24zQWViQStzOW93TEd2Ui9obmlhRkM1NEJrZVNLRG9sUmFE?=
 =?utf-8?B?NkpBZzZJR1VIUHUrU1NEdW1GSlc0bVZPY0ttZ245MVRUNW9VYkZIaGZtQ1pL?=
 =?utf-8?B?Ni9JblpNcUFLakMrbWNPaFgrNzc5SzlXenhJZ0ZxaHVET0JCQlAxL0lLeWht?=
 =?utf-8?B?SnVITEhKbWtHbGpYam1OMGV2cmUxZVpuY2FaeUVUUmtDMG1TVUNnOGpkYU56?=
 =?utf-8?B?TUU3WFByYnlKckdvc21CVE8rbHE0cHdzbkY4aE80UFRrZGcwTGF2UGZJcHgv?=
 =?utf-8?B?Z3BXeEgwNk51a1AydUxNVGM5YWpBY3dNeElTQ1QzbzQ5aGtQa0pqUGNaYWdm?=
 =?utf-8?B?bzFQditWTHc4YzNYMDRleS9DSjJzcFgvalBwaEZIKytDaE1OWGFzWmUvN3pE?=
 =?utf-8?B?S1RYNWVXSGxIa3VDdW96NisvVHZJVnFCaFNTT0pUMFpLampDMkxYSGtPSzdO?=
 =?utf-8?B?UVpvRHFFMStVV2d5ckdqTzl0V29UNkE2MEVYbFErNUd1d3BnZHpBWEhsNXdl?=
 =?utf-8?B?TnhucVJFUnM0aHBtOStBSEFpalkwUTVkYmEvSVh3MFB0cW5jQ0NVcW5hOThV?=
 =?utf-8?B?L3BmYWJjbEVjVm5TdnRabExyQWRSY29CMDBZUU5kaml3b3ZFdjZaUElkYjBL?=
 =?utf-8?B?WUNCa2xmbzZwdUNPeDBaekRKakd6akdOOWhuNDFIalM5V2JRTm1HblFpWHBq?=
 =?utf-8?B?WnlxZXdpVFlJRS9YNUwvQnhCdFliSzB5Q0hiNDZmNHljWVo4RmM2azhwOGtB?=
 =?utf-8?B?Wk9UQjNiNnRlcWMrWENVN050WUVNNHFvTTJtM0hLMXZ6QWc1SlZKaW9xZThI?=
 =?utf-8?B?QzZUa1lUTnN4V2lObDg4LzA3V003VVpNQmRMdXUrMDVESGRUSitocXFzUDJm?=
 =?utf-8?B?RXBya3BqZGUyL1l3d1g4MlJlMmpYdmVZNXFmeklKV2JCSDhEVDFIaWlFZmVU?=
 =?utf-8?B?ek4wTWk5N1I2QmxyWnc0d2tHUmM1K01ES1R4T2hsMSt0U0RQT3ZHSzFXRnBv?=
 =?utf-8?B?Rk5pSWtrNzFKanA4SDkydk9mRHovNnlPQ2c5WjJGZ1R4QVdvYWN6bkVjZk5I?=
 =?utf-8?B?OEdZdElZSnlGVzNBOHgwWWxnN1dTNGFhS1NzUk5WNWFybFp1NkNxaDFJTU1s?=
 =?utf-8?B?cnU5RjRBNDl3SVUwaXRoQTFOQnQ5UWhBZVBnV01LeStLbFdOSzhEdHVoK25V?=
 =?utf-8?B?akJsNmQzUEhZNWNMNGliWEpBOHZGcjVLQW5FRFpLcXdYWmZPeXg0UlVubEZz?=
 =?utf-8?B?T28zbnJMcDFRZXpIb0FjUWthMnJURWVPckVqaTZWUTdSQk9sV2JGS0VJQ3J1?=
 =?utf-8?B?aGhZYjFpYXMyYkhvY1orbGE4UVFRQXllTWZ4a3czSXJwZUx0czZGRytvRlpw?=
 =?utf-8?B?QXgvMkl6aldHR3hSc0UvbFp3VmpQQ1VlM2RWbnRIVmdPakdiNFJQYkRKWDN3?=
 =?utf-8?B?em5wMHF3d1lDNzdsSGZ4MGRmV0hiRWoyWmYrK2xVYVF4NkovQllCWk1hWmR2?=
 =?utf-8?B?TTFlYnhLeUpaVU41SitJWjBjNUxWOU4rUlRFWmFpd0VUZmdiUHVWNzhycXZL?=
 =?utf-8?B?QTIrYmlzbDVITlY5d0JLdnlTVW5DdmI3bW5IWVM1TUkrWGQzaVFyd2o4ckxP?=
 =?utf-8?B?Ui9jQ2VGZ3dnVm1KYVNaZmVFVWtWL2k1a2ZPMXZVYVBwV0JrbUxRUDZXZWQ0?=
 =?utf-8?B?WG9SRGhrTzZLVXh3cmYrdFgxbWF4VWdhTFI5K3Q3Um1MamVIV0E5OVZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB6733.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Lzg0c3BmeHRpWDNiSGpTQjIrYnZ2TUwzTEl1RkVYMXVKd2NZOUdjbWEyclFP?=
 =?utf-8?B?UFlGTktaVjlVK1hxekl2a1lOUzFuSlQ5THJlcTcwTjRLb3NwRzVmSERLZjAw?=
 =?utf-8?B?YWZldHBkQ20wNzZWcmxKOHpKbERRZk9WMk5YdGF1YkduKzFhaTAxTnhPV3BO?=
 =?utf-8?B?L01mWGQyVlI2OHIxaGpBeDJnZ0l6bjk1NEgwR2hkUWtseUdVdTBZK2x6MWVU?=
 =?utf-8?B?eGUweFcvR2ZnSkc0T1NIYW5BZU11ZmFUa1RaSkdRT0NrLzVvcC9LdTlTRHRJ?=
 =?utf-8?B?NnUvU0NFSlROY2VJZHdLeCtrZTQxVFM1OHY5TW1xWC8xNU84bnJqK0NQR01x?=
 =?utf-8?B?dGpoYWZyT1ozTTRLK2RqamkzWUphZFNuSmp1aUVNQkdEYlhWb0lMWkIranM5?=
 =?utf-8?B?Vkl3c3dFMHI3cUd5Nmw5Ny9Zek5XVFR5aW9nZnFqN0tLRjlTcHRNL2ZzV2wx?=
 =?utf-8?B?djFFZU85MTlSS1Q1RzRCL3BqOGJ0dFkza0hYTTUxWmpzMU53K1luRkExOFZF?=
 =?utf-8?B?MGJBUXoyL0JwQVlMT1hiSHlBK3V4Tzk5Zm10KzI1SjYwQ3NxUDI4UWhQMUxN?=
 =?utf-8?B?OU5DMjBFZndiWS9GcDQzRDZieG1yNVRGdERjRXA5c3cyZnNqOGlKVC81K2tC?=
 =?utf-8?B?MXIyR1hvbEJweFJQK2Fyb01MS0w0dmJ3WFZNeVl6ZnY3c2x3d1JMQzRIMGRQ?=
 =?utf-8?B?a0wyTkF5WGY0WFQvZ2RtQVZSMzZ6dkZxWmtjVmtJYkIxMnNESVRuOXRqUzht?=
 =?utf-8?B?RElVSEJqRDloS2xHeUhYSE8rUFJEWUl2Tnlqd2ZDUE0xRjRlSlp2TVZvQ2tp?=
 =?utf-8?B?aFdLUlFFV3huaXdPZWFidzQyNFMwWWwwVXEzWWFlRTFJQVN3NW5adko3NkRk?=
 =?utf-8?B?eUdTTTA0TUVvM0dUQWc5a3R5TmQrTmZraTZqbE9KNFozeXNLcnV4U0ZIK1Z6?=
 =?utf-8?B?Z0QxTmpvYnVmR29QaXNHZ3MrTklLSGkzWjdLSkxhS2tWTVVJSUR2M2lzTStP?=
 =?utf-8?B?UzkyS3gvY252T1IxaG0rUmptOXd0RU5OOXY3N09iczZSYnBQU2lqOGt1Yklm?=
 =?utf-8?B?endyWEdaU25aYSsveWFyb3hrcysxTGdkcVNMdms0YVFkYjByRTdETmJVNkc3?=
 =?utf-8?B?MFdzK1dwS2RuMGhIekUwMUpXcHB6ZUFPR1B6Q3Z5aENDZUxQeTVVMjBmbyth?=
 =?utf-8?B?RXhTTnBieW1Hd21LSHlLQVBTTDlTUWpYcTg5emFuY1Q3S1lNaHN0bDZuZmhS?=
 =?utf-8?B?RXFhdCt2WGJkdEt0WFBIWlZYK0I1dGNObXJhUHVubHc0QWNnU2o0OWJXdktt?=
 =?utf-8?B?Z1JnUk8xd1I1emVPajNCcEtOTGxIK3BMWkhXOHFKUi9VWUFkWEJZVUR2eVpQ?=
 =?utf-8?B?U2VidUVzeWNvSmFmUEE0MTdjcFEvc2lYT3pXSGtwdjViejV3VmQzTHhocTMx?=
 =?utf-8?B?eVdmS0FTeFl3TktqM3V2bG1FZmhXTW1xbjI2ckEvWTRKNkNqdldGQmhYTGQ0?=
 =?utf-8?B?TGE3WlNSUDU5R2E1YXlnTWdEOC9Ya2puUnlMcG9mWjlOT00rMk9ZYjB3dXVQ?=
 =?utf-8?B?N0RjSW5QVkpnNExidTZobUVqMmVKN3FlUFlNUjRSWm11Y3BhUjlQQnZqbnV1?=
 =?utf-8?B?elZ4Y05OeW84d0RnL1J0UTZ6N1AvMUdoMEZadHVmUEJTbVhQOU9OMmhZS0No?=
 =?utf-8?B?elFtTGFxZ1lMNWlIWVd5WFdLanRINzdlaGF0TVNMNEZ5YXRRdHVINm9jTm83?=
 =?utf-8?B?WFNSSFVITUFTYjBpWDBGMDNVcTlwVGtLR3VRT2lQUkprbmRtOWt5Q0hQVVY1?=
 =?utf-8?B?ZVh4R0Ezdjl4cWJYM2Y0YkMySVFTalFKNUIwYXkvd3MyYWU0TyswVkRYWXpl?=
 =?utf-8?B?YlgzQjc4dllIYS9ramVwMEh5Y1BFeVdBSmxkY1RTQVo4UkplRzBqbmprTWVB?=
 =?utf-8?B?RjhaaXBnSEljVlR0ZGxGT1JSd09ZNys5cC9aSGN0d0xjY0NBV1BKWVZ2MUdC?=
 =?utf-8?B?UWN2K3BsMysyaDZtaTAyMWdzNFpBM1ZlbVRseEdVcGxMZlNta2xWQXJBNjU1?=
 =?utf-8?B?S3pybkRwU2ZaMXFXdEkzTUZyVVJBeUdFcGgwRFltUkxya0JCeTJzZ01aMFhr?=
 =?utf-8?Q?XSTnR0LL6CFjMJzYrhZ8Ooq2b?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84edaf72-9836-4050-6c1f-08dc65416daf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 16:04:46.8663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKmr4tr4GScB1xzUWILgGtweTxdcGwSihCUuRhGqPEPVG4nH88ex8fA5ih1IzuaBrGim8t50gZkqeJbRV64GZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8105
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=ira.weiny@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Shiyang Ruan wrote:
> 
> 
> 在 2024/4/24 5:04, Ira Weiny 写道:
> > Alison Schofield wrote:
> >> On Wed, Apr 17, 2024 at 03:50:52PM +0800, Shiyang Ruan wrote:
> > 
> > [snip]
> > 
> >>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> >>> index e5f13260fc52..cdfce932d5b1 100644
> >>> --- a/drivers/cxl/core/trace.h
> >>> +++ b/drivers/cxl/core/trace.h
> >>> @@ -253,7 +253,7 @@ TRACE_EVENT(cxl_generic_event,
> >>>    * DRAM Event Record
> >>>    * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> >>>    */
> >>> -#define CXL_DPA_FLAGS_MASK			0x3F
> >>> +#define CXL_DPA_FLAGS_MASK			0x3FULL
> >>>   #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
> >>>   
> >>>   #define CXL_DPA_VOLATILE			BIT(0)
> >>
> >> This works but I'm thinking this is the time to convene on one
> >> CXL_EVENT_DPA_MASK for both all CXL events, rather than having
> >> cxl_poison event be different.
> >>
> >> I prefer how poison defines it:
> >>
> >> cxlmem.h:#define CXL_POISON_START_MASK          GENMASK_ULL(63, 6)
> >>
> >> Can we rename that CXL_EVENT_DPA_MASK and use for all events?
> 
> cxlmem.h:CXL_POISON_START_MASK is defined for MBOX commands (poison 
> record, the lower 3 bits indicate "Error Source"), but CXL_DPA_MASK here 
> is for events.  They have different meaning though their values are 
> same.  So, I don't think we should consolidate them.

By definition the DPA in all these payloads can't use the lower 6 bits.
We are defining a mask to get the DPA.  This has nothing to do with what
may be stored in the other 6 bits.

Defining a common DPA mask is correct per both sections of the spec.

> 
> > 
> > Ah!  Great catch.  I dont' know why I only masked off the 2 used bits.
> 
> Per spec, the lowest 2 bits of CXL event's DPA are defined for "Volatile 
> or not" and "not repairable".  So there is no mistake here.

I appreciate your not calling out my code as a bug.  :-D

However, bits [5:2] are also Reserved.  So it is incorrect to mask off
only the lower 2 bits.  Even though the reserved bits must be 0 per the
spec, it is still better to properly mask all reserved bits because they
are by definition not part of the DPA.

Could you create a common macro for the next version of the patch?

Thanks,
Ira

> 
> > That was short sighted of me.
> > 
> > Yes we should consolidate these.
> > Ira
> 
> --
> Thanks,
> Ruan.
> 



