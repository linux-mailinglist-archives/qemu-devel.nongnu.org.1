Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA76ACC627
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Jun 2025 14:07:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMQQ7-0003Wg-Tl; Tue, 03 Jun 2025 08:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uMQPv-0003Uo-3l
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:06:56 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uMQPq-00021F-Ki
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748952411; x=1780488411;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=auBZDDpIgL1IDXl78jebFohB0YbLmw6ljPuYHqPVcNQ=;
 b=UQIBaafymb1fbEIqQb5E9njqHwoRUwhyZs/sw+yBgB4IJI8XJT/ZpHQ+
 VWSpkI9v106IlbcrV3WUmUqReZ1tlbDGQQMbSLy6Ah0Y6UYGF373BxeTY
 UuqTbkeGFO14Umo6boh1RSzrW7zFYeNqjmOXP/z/f56xVrdcybdFpADRL
 aiP+i5cKdgVMKqoChz/fjwvwX9MNsJKArtzKYHxo/G9YnyZ3aJkSe8DeK
 UZasKHS0qpfKg+K0Y7YnjbO0C+MwwmGFdS/gJKj5VRciplGKbdV602KJl
 7hoGDl4P3AYsd3F0Waqy8TMFKxoHbF5/ok9G0yVgFDBL7wT9tm85saZo7 g==;
X-CSE-ConnectionGUID: C5gFN32xQuKVpRTERjJ+1g==
X-CSE-MsgGUID: 9h99w0gSSauF6L0n70sA6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="73518463"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="73518463"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 05:06:43 -0700
X-CSE-ConnectionGUID: xwLXnNghSk20I5FT4WwyXw==
X-CSE-MsgGUID: /mGaNt/aSj6hisuDiC2awg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="145463500"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 05:06:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 05:06:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 05:06:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.71) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 05:06:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZL2Cig7i2V+1Plu0iUFN9DZlioeEn7mt8/X/UIsMWcyo2YJdY91wA9LES9GZEZTr+XcT8Uxqd/1ulxX8IiXXRbGTmAPMt87xPCrISM3/DBkv29afkpoQZQ0MmrVxbaoAaEI6gvFG+T/4+DLyG59S57UiH2G6qXQcePXen4ZD9r7Ac96XZEsPojzI6WMvMGuLXmbgqegk5hgqKV4Hob0WynUoXk4TP9q0T3+LxVgpKVivjHDWSkI+MMqeQqei1qQ8lRhHXlPai9nWXlTasKM4yKtrBUpnsQK5YwvzIxsL1yzbedUv9Yp6sMGosKiOhiU2UmnA0rP+QwoDM4EJQGf8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqRdcb0kibflYZ+5io8+D6W01pzg/8yfnt8IO2VBgEY=;
 b=pkJFkvRJio/eC2+YPs/zHn3Q95XJgabsS7mNlCdMrt3FVimmHPjbKZVmAK6eBm3VNbaQsXfh3R44fawNAbANuTf86cIWGr1iOlFDn9w1h2aJq04LQmgqrMDvrEdcKrUEZpoY+CYyYTjmqR/S4f7QY7OiuaEo5xevUPRbzkCmplnpLy8QB7QVjLJ/iMpgZglMkxTXdrH7kGubjsgLG+owgSp4sMgMSNomRUYRyHry7yscLXj0hLEW7f+mnpRcJvbd/cFUyOLxCsbq1oHGSQi1h5tqS9v5kXZldEvSFw/766a9QcZdECcAsa3eZTdSyHd9TtD2gdsjw4WYSwnJZdXklQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 CH3PR11MB7868.namprd11.prod.outlook.com (2603:10b6:610:12e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.37; Tue, 3 Jun 2025 12:05:56 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%4]) with mapi id 15.20.8813.018; Tue, 3 Jun 2025
 12:05:56 +0000
Message-ID: <902a2687-d936-4943-bd5d-c41b85e2f1d3@intel.com>
Date: Tue, 3 Jun 2025 20:05:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] ram-block-attributes: Introduce RamBlockAttributes
 to manage RAMBlock with guest_memfd
To: "Gupta, Pankaj" <pankaj.gupta@amd.com>, David Hildenbrand
 <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>, Peter Xu
 <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Michael Roth
 <michael.roth@amd.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Williams Dan J
 <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Baolu Lu
 <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>, Xu Yilun
 <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Alex Williamson
 <alex.williamson@redhat.com>, "Lindgren, Tony" <tony.lindgren@intel.com>,
 "Maloor, Kishen" <kishen.maloor@intel.com>
References: <20250530083256.105186-1-chenyi.qiang@intel.com>
 <20250530083256.105186-5-chenyi.qiang@intel.com>
 <4105d9ad-176e-423a-9b4f-8308205fe204@amd.com>
 <9a9bb6bb-f8c0-4849-afb0-7cf5a409dab0@intel.com>
 <d0d1bed2-c1ee-4ae7-afaf-fbd07975f52c@amd.com>
 <c646012a-b993-4f37-ac31-d2447c7e9ab8@intel.com>
 <219c32d8-4a5e-4a74-add0-aee56b8dc78b@amd.com>
 <828fa7bb-8519-4e3f-a334-c1b4ea27fee3@redhat.com>
 <93d48fc1-9515-40a8-b323-d3e479d30444@amd.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <93d48fc1-9515-40a8-b323-d3e479d30444@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|CH3PR11MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d9fd20-5cbd-4481-af4a-08dda296fe7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ck5QWU91dFJPTDYvYWhSNFNRRGFXS0ZOaHpjT3J5RXZHcnREWWxZVUJqZnpY?=
 =?utf-8?B?b0trY1VkdEx1cTA0YjNQUGViWkROcUJFaFZ2MTNHTWpzQ0krYWxhVzd4Tm5m?=
 =?utf-8?B?TmtpMzQybUxTcjZuSVJHZFhmNjFBRTJWckhsQ1Z4dHFVeVBHRjVHSzhHZ0ts?=
 =?utf-8?B?clg1SnZNWld6bXF5WGhobkVka2hBUDh4VHB3cHppa3lEdytUcEhEY2lRa1gz?=
 =?utf-8?B?VjJZWGNkQktVTnU4WCtXbVcvdEFTbE1weVhzblJwdWZjLzVtT0E2a2JQd214?=
 =?utf-8?B?OTJhSUpwRGhqNVRnQkpLNEVzWDVhdUltV3JBQkMvNHFvZEJWdFY0M1ZSWjNH?=
 =?utf-8?B?bzhaTHI1M1U0RjJLMGpZUGdZbkdXdUoyZGpjTlI1cDBORWtMck1UWGxkWGNS?=
 =?utf-8?B?bkplUXNWcTdoNjNaU2swK3FNOEdBSVNHR3pBejdKTmFCYTdyZmoxNHZHWnBl?=
 =?utf-8?B?R1V4L1lSb2xlb1JLbnk2YnZPMWpEcERwVGRMTWY1ZVFoZVRxRS8zRkk0aUor?=
 =?utf-8?B?bG9WSG1FRjlnQkt4QUlPdGZCUUZlejhzWkVtTE9tblJJV05VM0RLZVJpNUc4?=
 =?utf-8?B?aGwrM1E5ZEgzY0pLSy9UTnN0UE1ML204MGx2OUZBU3lXUnVBMG1vdTBMUjR1?=
 =?utf-8?B?d3UyN2grMkhsMnNPK3IzNEhSZ1I2dmUrSnJydFB2ejYvUFVtdjIzaTQ0ZStt?=
 =?utf-8?B?Y2ExS09mRWpkUzRLNjlLS2tLMWpIamJkQ2JqY0x1cVhjenFsYzZyZHF4SnZ6?=
 =?utf-8?B?eXExK1Q4N0gwV211L2o3anlLZ2daTjRMcVN3ZEpsRFNhWXFCVWlaZCtqaEdx?=
 =?utf-8?B?MjRzRnJqS0RSQlo3QmJ4d3NmK2dYL1V3eFJTZ0pVQjU3bHFkK0thSW92bUMy?=
 =?utf-8?B?T25RQlRvTlJTQVR4MDF1OENYQWptZ1FjZ05RcmpzejNCM1lSVTlmQjhYdEJU?=
 =?utf-8?B?bWIxWlhlY3kvWnA3T2pYcnZNUkpEeGsxY3pxQ0xFdDI4L2RWcGdMczhmYmll?=
 =?utf-8?B?U3J5d003M0JVNSsrT2dDbzlGanN1MGlCbkxnM0ozRDIrejRsb1dZdGVNQlBD?=
 =?utf-8?B?OEZhNDBvM3FiTkhwMXV3L2JLTHF4VU9FSG1DaHllSWpPSnJHa01BU1RpNjNV?=
 =?utf-8?B?ZnVYaGxKMVcwU1ZhS1RabFVPME9Xc2xmKzRZK1RsMTJjNHV2RWhLRFFDV09Q?=
 =?utf-8?B?TFlOYm9xRVFMNGY2djZ1MGNuTjJLN3NwYVRIVVZYc0RXc21aZGJpVW1xZExF?=
 =?utf-8?B?MFY1U054QjZySTlBQmhubWV6bVVrME9abUtKMk9DYWRnNUxEZFBXM3lqY3c4?=
 =?utf-8?B?dGRMaXVTU0lJampHSTR2RFRNSmFkaE5jb0g0NWluUnQ2bnFwaVhyenRTWVFG?=
 =?utf-8?B?c2xZV29OZUllUDJLMEZsTXBOT2NrM1R4VFVqenh1Z0p2bUVhWUorS1d5c0xw?=
 =?utf-8?B?VWRzb1hMbmhwdkF1dEdNc2FpeTdiMVlSM2hkeTVrYXNlQzJxYkE3VXpiZi8y?=
 =?utf-8?B?bjQ3OFlaT0gzVmdyRUxveHNOMUQxVGhDL1IyWktJQkRuS2h3aklCQ3lYWGNX?=
 =?utf-8?B?SmtPaXAyaWIyMEsvMVB1UEhJNENYNHpYREZ1TUI1M0dzcEEvbVBYeGw3Y041?=
 =?utf-8?B?UjRzY09oTklDS2hTRXBPRFo1a3lSTUd0Y2dVUTZra1g4TjVKemk5RFUxZDZC?=
 =?utf-8?B?Z0tybEtYbFNLbFhyNWtBdUhyRHF2MGlxMFZ1cTlldHN3S1FPbTdxTDNIMkJF?=
 =?utf-8?B?dGZ0Z3VSV1dVaHZBYlkxVVVvcWxqS1VrSGo0eVRsVGoyV0RJMW43SzVpcXlj?=
 =?utf-8?B?OENNaHVhdGEzZUhRNGJMUHBYYXgwci9WdHNObEJQcGNkTjZ5VGtjd1FFdWt3?=
 =?utf-8?B?bEtlVS9LWHJPRmJWS1JKL2Y4R0UybUcwekUzSFBpdGk5ZTNKcFRzMDVrQTlo?=
 =?utf-8?Q?GZ0l0ZOsHyY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmZ3alRJb1l0eTExYW5aS05qTUJNUzltTEVVejRRcnVTelNyU3V4Z1ZRT3Jl?=
 =?utf-8?B?N0FKQ05WM0Q5dUsweldsUk4yWGJINGhUMHQrSTU5VXIzcnJEdjdjL2wybHg5?=
 =?utf-8?B?MFJsbUNScUxxd3BDcHNsUDkvZTBmMnY0UmZ2NmZnM0toWjJXYmVuOEt5UUY5?=
 =?utf-8?B?cDhxaStlVHJIbmJzSERZTElOZ0t0a1BrZUdzTks0TjFNZXQxU2JNUCswVDBu?=
 =?utf-8?B?bTBZMUNHNURLM3QxL2tLRHlIQVZFZ3hwMGxyUWh3UFZNR0UxMFQ1Tm1mTGdF?=
 =?utf-8?B?TXlOT2NyQUpqNUhJK2lZS3dCbGRPYUxNSGNXZ2h4L3h2QkRGazFJdEtkNUpy?=
 =?utf-8?B?MlFEUVI2aEpCMElhelhQdTUrMVA5QWcrV0RSUzJ0cGFVbjlNUmRpWFdXODN3?=
 =?utf-8?B?S0ZSTE8xdG5ETHJhTVJIaFdmS2I1ZnJjdlVyb2M4SjdlYlNhTXIrb2VlSFFM?=
 =?utf-8?B?djRscWVOUCtQYVJJWkhVMW85R0p0MElVMVV2b1RVVEtWaG5JbndNUXdjZ1hq?=
 =?utf-8?B?YjR3V2VsU204OWFiTEZCazhPOS8vejRWK1dCNDhaM1dkQS9mdXkxVWxsdndU?=
 =?utf-8?B?c3p6NDRMa2pjemZMY1dkZ0t4Sm1EQ2RnaFc4K09Vc1BpVHJLY3J5cnljK2JN?=
 =?utf-8?B?RDZocEN2ejRpT2tYaWF5SkJkY09BTldMZVpBVXlpQVdhTWFOWU1EZmdubDFJ?=
 =?utf-8?B?YzdPbk9OeG5ud0YyeS9yM1FWMDMyUWhLcmhUMERSWFFwYVdpWVdxVFNzS2Rq?=
 =?utf-8?B?NmFObE9BVlcvRVZtQmQveU9FWTZTVW90a3A1YUwwTExCblFVbUc2K0RTUkdO?=
 =?utf-8?B?d25ZVVNVL3UvMTAzS2xMMStDb1l6S2YrZ29tSkRWYldOTzVYcnZtYW94bTI1?=
 =?utf-8?B?ZVZVbW1vU09BRlpZaVRRVVg3M3Z3dSs4alpiYkoyV3lXNmpYbzdYcmdVcUZ6?=
 =?utf-8?B?SzFkOXhMYmh3SC90VWtwVlVjaVVmL0JQK3cwV3djZUlUeGI3aGNBVE1HQTky?=
 =?utf-8?B?SzRSNkFZVTJDaDRsMzRDeVYwdUs5TExlUHQ2UVlIYWZUcEJLczlKRGRlVjc3?=
 =?utf-8?B?V3p6cG9vL2pWaDZkbk1zeUttcXBVVE5RY3FhSDZMKzdNZW1CcmRoVkNpbjNI?=
 =?utf-8?B?K2QrR0pKSzhjRzV4SkNPYnAvVUZjb3BRME9teVRsTmFERldFQllMbG9CbWNR?=
 =?utf-8?B?cDl4WFMybFdYanhTbEdsMHkyTXdGdmIrU2dzSEFiSlIxV0dMeGwzbmd3SVY1?=
 =?utf-8?B?eFVCY3hIcEZ3cDRGdDlFaGpTSEhaS3BsVk55L0NibDcydkMxcFBXVUhieWJm?=
 =?utf-8?B?KzlBRkdQRTlFL3VsVFl5QzlJTG9LZ2VZY2prNE9wd1J6cENEUlRRTnZSb3hy?=
 =?utf-8?B?R2dKWFFMNUlJckpMVXpZZjlkU2gyemNMckZ6RVJRZkovQTNDTGl0REsvQTl4?=
 =?utf-8?B?cmRaVHRVWGprZGtDN20vNG9RQU52VWNjTElTWTB2QTRGdmMxTC92NEVrRlRT?=
 =?utf-8?B?TzlsRlpjdlBCWS9yam5xNllleFJaZkovY2s1RUFFZ0QzTUE0NjgxZGJGUjZG?=
 =?utf-8?B?MFRwVnRyMHBmOFBHWDN0OTVGRUdkbmZ4ekhCZFY5dU1GWUFtWmdjZFFoTzFJ?=
 =?utf-8?B?cnVwTjg0MTRNeGxkUHpueWsxelRiMnFibFNtWFRWQ0FZQTBNVEVBakp2aDls?=
 =?utf-8?B?MmVFWlV4NW5SVnZRWTh2Z0dOdTE3ZmR2ajJxSVBrd2dnZmVQZ0NFZDJ1aGZ3?=
 =?utf-8?B?b3FLaUptY25PdUd5OU1rTVFjeGdFcmc3NW53d0FpY1RiVXg5MzcvMWpDYmxv?=
 =?utf-8?B?YXpTcnRnUVF1VEpOYkpKaThPLytOYWRHVTBpZDk2SnFMRGdTTlVVYTRBMEFU?=
 =?utf-8?B?cUpVQ3BxY1hmV2k0ZkVOdTZ3b3hwVU9ZbEs0bVJLZ2Zaem1qK2V3VXVRdzYz?=
 =?utf-8?B?YkZvQnJ2UzRzemhqVTRlSUtySHJrM20vK2ZnUjkrYWFxZ0FXaVdQbCs4czhQ?=
 =?utf-8?B?SU1JLytKM0ZHYU9zR2REOWhZTENGUkpsYmtFY1JkVzdNWlUyVGt1d2dVMUpF?=
 =?utf-8?B?WTlYT2VkN3k3L05GWXk3UE5vMnhTZFpwT2Qva3BWR0NWS0ZMUllKblZYdmtK?=
 =?utf-8?B?aENWTzE0T3lXdFAyVUlNNVc2ZWhnZDd0OHNvaTRVemlvaEJzazV4Nm1DOHJi?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d9fd20-5cbd-4481-af4a-08dda296fe7d
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 12:05:55.9111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkspptoTxztMH4amVxUX8Fz4+eRYK/phkhMnEzyIE/QxRwjgw/Gpt//PQIfMbjSi4+Aq0zlShY709ai4H9FM2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7868
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=chenyi.qiang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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



On 6/3/2025 5:45 PM, Gupta, Pankaj wrote:
> On 6/3/2025 9:41 AM, David Hildenbrand wrote:
>> On 03.06.25 09:17, Gupta, Pankaj wrote:
>>> +CC Tony & Kishen
>>>
>>>>>>> In this patch series we are only maintaining the bitmap for Ram
>>>>>>> discard/
>>>>>>> populate state not for regular guest_memfd private/shared?
>>>>>>
>>>>>> As mentioned in changelog, "In the context of RamDiscardManager,
>>>>>> shared
>>>>>> state is analogous to populated, and private state is signified as
>>>>>> discarded." To keep consistent with RamDiscardManager, I used the ram
>>>>>> "populated/discareded" in variable and function names.
>>>>>>
>>>>>> Of course, we can use private/shared if we rename the
>>>>>> RamDiscardManager
>>>>>> to something like RamStateManager. But I haven't done it in this
>>>>>> series.
>>>>>> Because I think we can also view the bitmap as the state of shared
>>>>>> memory (shared discard/shared populate) at present. The VFIO user
>>>>>> only
>>>>>> manipulate the dma map/unmap of shared mapping. (We need to
>>>>>> consider how
>>>>>> to extend the RDM framwork to manage the shared/private/discard
>>>>>> states
>>>>>> in the future when need to distinguish private and discard states.)
>>>>>
>>>>> As function name 'ram_block_attributes_state_change' is generic. Maybe
>>>>> for now metadata update for only two states (shared/private) is enough
>>>>> as it also aligns with discard vs populate states?
>>>>
>>>> Yes, it is enough to treat the shared/private states align with
>>>> populate/discard at present as the only user is VFIO shared mapping.
>>>>
>>>>>
>>>>> As we would also need the shared vs private state metadata for other
>>>>> COCO operations e.g live migration, so wondering having this metadata
>>>>> already there would be helpful. This also will keep the legacy
>>>>> interface
>>>>> (prior to in-place conversion) consistent (As memory-attributes
>>>>> handling
>>>>> is generic operation anyway).
>>>>
>>>> When live migration in CoCo VMs is introduced, I think it needs to
>>>> distinguish the difference between the states of discard and
>>>> private. It
>>>> cannot simply skip the discard parts any more and needs special
>>>> handling
>>>> for private parts. So still, we have to extend the interface if have to
>>>> make it avaiable in advance.
>>>
>>> You mean even the discard and private would need different handling
>>
>> I am pretty sure they would in any case? Shared memory, you can simply
>> copy, private memory has to be extracted + placed differently.
>>
>> If we run into problems with live-migration, we can investigate how to
>> extend the current approach.
> 
> Not problems. My understanding was: newly introduced per RAM BLock
> bitmap gets maintained for RAMBlock corresponding shared <-> private
> conversions in addition to VFIO discard <-> populate conversions.
> Since per RAMBlock bitmap set is disjoint for both the above cases,
> so can be reused for live migration use-case as well when deciding which
> page is private vs shared.
> 
> Seems it was part of the series till v3 & v4(in a different design), not
> anymore though. Of-course it can be added later :)

Yeah. I think we can consider the extension in a separate series and
view it as the preparation work for CoCo live migration/virtio-mem
support. Since v4 is considered in a wrong direction, maybe David's idea
[1] is worth a try.


[1]
https://lore.kernel.org/qemu-devel/d1a71e00-243b-4751-ab73-c05a4e090d58@redhat.com/

> 
>>
>> Just like with memory hotplug / virtio-mem, I shared some ideas on how
>> to make it work, but holding up this work when we don't even know what
>> exactly we will exactly need for other future use cases does not sound
>> too plausible.
>>
> 
> Of-course we should not hold this series. But Thanks  'Chenyi Qiang' for
> your efforts for trying different implementation based on information we
> had!
> 
> With or w/o shared <-> private bitmap update. Feel free to add:
> 
> Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

Thanks Pankaj for your review!

> 
> 
> Thanks,
> Pankaj
> 


