Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96280A18C3F
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Jan 2025 07:45:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taUTW-0004gA-V8; Wed, 22 Jan 2025 01:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1taUTR-0004fz-NG
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 01:44:26 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1taUTL-0008Qm-KU
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 01:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737528260; x=1769064260;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GG3X4w9WrATSI3twij37Gb3JcsQU1iNDFZNDiQUmtEU=;
 b=PJdjeTdQKBh91pFnng0Q154/FGcSFvx265lEOryKyyUWpJ+4TpsNvsmY
 M+mCEe1IHuXOa8YkV1whKeZQTKgthPm0aI91A0rUxOBzMF9IXbxikAXj7
 ++PxzxE+insQBahbOkv8GlojmychXVrp7QzhM1hC8/j2sOjb1LDrVf2yI
 opEKo42Yfg62Sbc5vHFi4ludCOZTVSWHurxwGMiXxhLTZTvy+pwP6d30G
 4QEd7nedc/Klo7JirHcAGOd1jlriYO8eMNZrexoOuvE9LdQ3tcLWNhit6
 vYHuAWjGmn85l6D3wfX8OXLBvY0j97DX/deb5fVcStTXfzIUvJeHMvfGo A==;
X-CSE-ConnectionGUID: hEA85ZVZSZODiOBcIIfovQ==
X-CSE-MsgGUID: zWKRS1nIROuShI5eXCP+dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37668144"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; d="scan'208";a="37668144"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 22:44:05 -0800
X-CSE-ConnectionGUID: NjvqCUDEQ2iudNvy1TMqFg==
X-CSE-MsgGUID: N4nW/CY1SZ6g0VecBPADlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; d="scan'208";a="106861752"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jan 2025 22:44:03 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 22:43:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 22:43:53 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 22:43:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uD21twmKiMaYrd3KQcU1NmTZJlL6aZNr6Xah4x8GnzqWHJdPN9x8UnQQQnGZcz1xXr57gNbR99Hj2ojl6vxCLUeN6KfcOwt2nRYopHoQiSiB6yWg8YMjSIdQCx0ErVNWfF+0T+sFfSaJjDEp6UjaOtQilyHw0xH8RtO8QxpQWEoNs/NBni23T3HqsoSqAywdNxLMfW4y2yvmWJbfoXBxwaD5dwtcyiTeq1LmrL+rpwr09QD+X79hJJDZsmnvTlgqUoF3+vCg6XGSU1t017Ty9ageXYfipVR31N6yGRZcIjt+NWtqMF7dlNZcSL+fpD3NyKRz2P2Dd4gECOnE1ykzDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fa+gQ9sz5O1iDs3pqhQblcFbVqStf9yLCy2zJKxpDU=;
 b=lhbV1fRNSxqqVKPIOS0G21ed1Mnw7zBYXX9lS+rjZho50/JXa8QS04GdL40+JaavJDJt1isrNq8lR4ACEriuC4FRpgGrYhFEU/6GAKwCRPH8K3kPrnYku5p+W8PQpsk+tdq3VgojpfwtwB5Z6kh9stpyEOXtgPjgt31NG5Y8KihEMsVEWDdgHrh3i092ocVu8aywCpk1WBVtpsYGeTYQrvIqTP3o5JIFaeSOVvdDtZo3AJuKg2J16skQoFlzFp69jjb1XgVPWkY+OuYdps01OB4V+OWcJjyjCw4HQ5JEyu0Yf1tB8uLpIdKvbYH39clu76Ati3rbkIuE0yBLKc9nyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 CH2PR11MB8867.namprd11.prod.outlook.com (2603:10b6:610:285::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.16; Wed, 22 Jan 2025 06:43:46 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%5]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 06:43:46 +0000
Message-ID: <f1b4c00a-0e8a-4579-9951-d2d31c0214e1@intel.com>
Date: Wed, 22 Jan 2025 14:43:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
To: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Michael Roth
 <michael.roth@amd.com>, <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
 Williams Dan J <dan.j.williams@intel.com>, Peng Chao P
 <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>, Xu Yilun
 <yilun.xu@intel.com>
References: <20241213070852.106092-1-chenyi.qiang@intel.com>
 <20241213070852.106092-3-chenyi.qiang@intel.com> <Z46RT__q02nhz3dc@x1n>
 <a55048ec-c02d-4845-8595-cc79b7a5e340@intel.com>
 <7176db79-cd04-4968-a61a-a753e3668564@redhat.com>
 <5515f87d-63a5-4c70-b421-616e706324a5@intel.com>
 <065250d4-84f1-4dfa-a938-98a61082a666@redhat.com>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <065250d4-84f1-4dfa-a938-98a61082a666@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|CH2PR11MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: c7922d13-a3b7-4236-65e4-08dd3ab01e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1Z6eWlMUENURHF1VWd3VjVKRm9zM2tNVVRnZHozZnNMelZWWjNmZnM4UVN6?=
 =?utf-8?B?YzR5a2I1b09RbzY4SnoydmFVQlVMbGNIOGlBMUxMOXR5YXFqVjFqVlUzd1Jo?=
 =?utf-8?B?M2NaRlMzaWlKMXBsLzFSNnBXN1lqdGlaSjRWRStCRHRZclp2SE9wMjQvKzBn?=
 =?utf-8?B?VkJPTGo5N25xMU1ZdXBzSjZyRWNpcHk1TnMyRVpGdEhGb3FaMEgyQWg4RnJN?=
 =?utf-8?B?SVR0V25ER2lZVGtILzBGQWVoUURNbmQxSktTcFFqb0NXbnlySEdwMEhubXN1?=
 =?utf-8?B?MDZaSHNGZXZ2WTB1N1lXZDFwd3UwWFQ2b0pvY2M4VVI4empSYU8rTm5mREJ1?=
 =?utf-8?B?OEdHejRsSzd1QTQ0L1RhNUhPUXNDdlU2Tm5kSE1QUnhCQ2h2UGJKbFR1RUxK?=
 =?utf-8?B?VFZaZnBxK2pmMkJzSTZFQWZDODJyUTVZaHZqMFREdTNqY1UwTGVBK3c0RjBj?=
 =?utf-8?B?cGQyODZTTDVYckNTeUZ3d2xXdGhRNzVaamN0U0hiaUdlNTQwWmxkWEw0OXJx?=
 =?utf-8?B?ek8vMmlVQmQ1ZGxWOWlmd0tJU0RoTU4wb3lRS2ZRSkVGTFpaUzFoREhZNE9a?=
 =?utf-8?B?NTZXVk9YWkdjWmR0RG41eVlWeW9TeDl4M0hscTJYejdDdjJ2L1hFTlEvL1Nk?=
 =?utf-8?B?U1NZRjBwczR2MElSaVE5ZExZZmtKSDBZcXp5aElhdjk1cDhUV1JtV2h4VWIx?=
 =?utf-8?B?UHZYNE1ZM1VzNWFnejZETXRjZThHYkdvcjltUEh1YnlZWEJCRkJqRmZXd2R5?=
 =?utf-8?B?L1cvdkEvTU00UkRGTzI5YURydFJQME01UERhWFFYWUdjdHFSMlBqUlpJS0hw?=
 =?utf-8?B?ZXZkVVV5YjBya2Vxam9aM3lmdUdSZmhRSS9od0czNTdjUWxCMUpmT3E2RDU2?=
 =?utf-8?B?Q3dlMEJNWUxnaUVMcC9FYS9OeFM5dEt3MmRDSHd2dThqaDIzN2tqVDBiUVFq?=
 =?utf-8?B?WXMvQ01zVjRUWFp6LzVpSm9WanU3Vms3QytQMUxwVUlPN0xwRmZuUkgyTWtL?=
 =?utf-8?B?WlNMdHBhOXhCUHRPTDY0RmpnYmVCbmZSVVAxcnY5OVovMGM3cThXWVBqUmpv?=
 =?utf-8?B?Y09NRUI1ck9FTHNwV2RudzRkV3VwT0VjMnZpYzlXTVdONm4rUHFoaGdYdjJW?=
 =?utf-8?B?RHZZcHlvL1lkYjZBc0RIYmRtTVhBenR6WlNUaTZreEpxS0JaMGVxb0Y2T0I5?=
 =?utf-8?B?UkgrYXpObFdKSHlNZXVSUnhreTVzb0tIZktoWndmN1R0OGNzSWNQWTNnU2tL?=
 =?utf-8?B?R2lEYnhhNWp2K21tUml3ZmFzMGRtUS9ZRUU0blhyUUZOUk5idDQxSFBONlln?=
 =?utf-8?B?YUhtNnI0K0VlZTBmVXltVXFNTTZwcllLSGtYZnRNVUtNSGIvdWw2Mmdncmpy?=
 =?utf-8?B?TGFxakpVQ0xxcTRBR2FpbVQxSGZhTG9hN0FyaDhmZXl5U2RlUWZCZ0paREpT?=
 =?utf-8?B?ZDk5SXViK0JDQUlGbUVwN2Q3T1ZPQnZMcXhxS25ibmRyOTlIN3ZLc1hKQ2F6?=
 =?utf-8?B?K014ZXAwTmJldm9MNGNpNWl3ZFdGRURVU2ZhK2x3aXFMaVI3dEg0cEZVOTRM?=
 =?utf-8?B?eWdsbjh2NFlFUkdUSUxYQXRmelJLZjFIT2FmQmNhQmNoK1gyOHA5akkrMjVm?=
 =?utf-8?B?TTZHNys5MVlzdko4U0ZyT3VmeHhFRkNGMEhRcndCVjRQSWc4TGY0eE43L2hx?=
 =?utf-8?B?N1A2OWtNNi9vbWNnVVpMSHlkQVFnVmxiV0YwTnRzUGlpcHdZa2c0cnZKNVJn?=
 =?utf-8?B?MzdOL25NdC9EdW5JN3BOVXZjRWxkSldRRnlCa3ZrZjFJUUZKL1FaSUM4R3g2?=
 =?utf-8?B?RlRsWU1NZEpueWFCcGtONTdGM2FxNlBWZ3A1aEhPREZMT1IwbTNTaklPU0E2?=
 =?utf-8?Q?ZtDb9Zn9IhrK8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkFLZ2txdXV2anh2UHNvRVNBUVVaTmoveGNidlF4ZkljYW90c2hpaUQ5VVlI?=
 =?utf-8?B?MTJGeTdadGk1UjZFZXkybnEveXlEYzRwQmtjRUxBeDcvSFZhM1U2b1N2ZTNZ?=
 =?utf-8?B?QVlYa2dRL2p2ZWZvMHhUTFlyaEdvY3dRSFczQ3FLdU8zQ2R2Rm9LYzJIUTFa?=
 =?utf-8?B?NGtHajN0WDZSSHhkRnJDRXpQK1FDZDJzZTNsRnlCSTBGWXJrclNUZEFKR0Zw?=
 =?utf-8?B?VjZQdlp3NUR2NEkvT2RhMFB2QU94bys0c2N3NEVIZlVaR0xZdm83UGNUM09I?=
 =?utf-8?B?RXR1U1ByZmZEMU1hNnhZbVliV2FrU2VlNDVERi80Vm1qalU2NS9PaVFVanFE?=
 =?utf-8?B?dGlLZVcwVjZqbDlOZG02N0s2eS9TVEkzRGlZQkYyNWVaN0dkMmxKdnR2UG9R?=
 =?utf-8?B?czVmengxY2UycGdZaVRqdEVqK1pTcUc1TEozcEg5WG1Pd3lkUzNIWXh4bk12?=
 =?utf-8?B?UkVweHRJQUd4L1NhQjBjdVJJUjUxT1RKanVISzlleFJJWHFoMnBYdFlPMFhw?=
 =?utf-8?B?aDVCR3VlRGlGVms1T0dlc0tsclZQdE8xWmpEbVllMDZtQ0h4TlhSWXJob1FF?=
 =?utf-8?B?ZjZIMmZNbGdsbHZjalBVQnkySWlyc2pMM0VPV1lZbklCVmttMXN5d0RQNDlJ?=
 =?utf-8?B?Z0YzWFRIUFdORTBpU1U2VHRJbTdxVzRETityT2p5K2x0WW0xUTdmWTQrYnhp?=
 =?utf-8?B?SUR2VkFQc0dUOHdpKzNsWHcyeVppZXB0aHFXam13a3NIOXFLeERWaXh2Yjh6?=
 =?utf-8?B?eGdjcDIwYnEya25sWlZ3ZUZmVjJDUEtZRjdMTlZBaGx0ODFBUElqRzhyUDVt?=
 =?utf-8?B?VG1vUDh0VnltdnVBdlN4MURHV3lEMFpodDdFaHZzNHJZTzJoMDU4YzFKQnNz?=
 =?utf-8?B?ckM0NHlhMk5IVTNVZ0hDK3k5czJ0MmhVVy81WWd0QWxnVk1IQWEyNWNHSmpO?=
 =?utf-8?B?Sk9vWkVwM0dKRDJmTmhOMDQ5RWN5SWR2VXpBdDBxbHBKa3g3V280ZDFLK3U0?=
 =?utf-8?B?S0hLdmJGR2RqQzQ2N1hhNTdVZ284NE9yNG5DMFdCU2w1M21xVDZoYW5jZkJJ?=
 =?utf-8?B?LzRXL3JoRjFMK3h4c3dFS0JQTzBSTFlSb3FYR2g4WmFjOUhta3YydmwzQlFj?=
 =?utf-8?B?TkkvY2s1MCsveEJYZjJoQi85amFUYktEN1dYU3lFTGNNa0RONUFZVUM0eXdB?=
 =?utf-8?B?K1lFYTRjQjJ5Q1RtcUYyaW5laUZtbjBuWHhNYWhVakhpQnF3L0JKZmFmc1Yw?=
 =?utf-8?B?N2hDRlA2YjM1VFhHRU5pYXpLeTZRSUgwbWpaSC9nNEdoM2QyN3drK0NEV1di?=
 =?utf-8?B?OUNNS0tBRVBmeDhkc0htaytlU05qbThrS1dscEx1T0tnUDVXbDFsWDdBVEdD?=
 =?utf-8?B?ZjdpUkc4bGNCd29tZXppUDNLSy9wV2w1REIyUzZvNVBrNHFWcUY4R2V6ZlFz?=
 =?utf-8?B?TjR6TzEvbkFFd3NkVVFtcUl3d1g4Undlb1JHY3ZqQkZmbjVDcVkvR01DTXlJ?=
 =?utf-8?B?RzAxYXgrQmgrbU84ODQ5ZGJxZ3JHdGdtZUQzelVnaUlIZnZHRWlMU1krTnNV?=
 =?utf-8?B?b3BMQUFycVo0TXVpa0krQ3U3Mm5tK0JpZHRCYzZEV2J5VnlDeEFicnQwSWdz?=
 =?utf-8?B?UjlTUGJxRlU5aVp3VldMRkhFWDk1cXdkK3ZZMmhBSUh4eWpzN3o0U0Jyb0Fa?=
 =?utf-8?B?c0szUjJ3VjVrY2hucjdLQzNUNUo2UHRGendKaFlZYkkxMUZmc1FkSW13NXBh?=
 =?utf-8?B?Mm1HMklYK2kwL2JBYXNBS01lSmF3NWZta0p5bHFUZ3RnQWo1QWJtMEYzMG9G?=
 =?utf-8?B?YUJqazlzQzNIdW91RnJQMkdHSFU1WGV3ejNOdzVpeFl2MExDZ2xhZ3lHVkM1?=
 =?utf-8?B?bkRWei9oNTRRWElYZStNNUhaOW4xSVN5VDBQSjR4ZEt2aFVXczYwOGhkWFFK?=
 =?utf-8?B?WFpIVi95cnA0NzMwbTFKUU9ZL2VRa0Vpc25ZWGdJTFFMZ2ZlaS93MC8vZkUz?=
 =?utf-8?B?cG5jelVQNDNvM3orbkxvY3NLcCtrOXBDUWRKS1FtRC9tUmFOcSthTEhlZzJL?=
 =?utf-8?B?YUczdnRVVjhDM0F5b0RMVEV3S0dWS0dHSVhxciticW1yRmM2WHgvNTJiUXVt?=
 =?utf-8?B?d0lLcGh4ZUpEenFNTjFpSmJiRVNtV0UrUW41ZFpMWkZ4VkJkZDBlTWRnejkr?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7922d13-a3b7-4236-65e4-08dd3ab01e96
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 06:43:46.1686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/P5AM+McPCxN4N3/ywHa5suocBjevzgdQ2tMahI4xRuPppjkgZhzwTaJh6oPmrG7I+7LLPKsZr1JzW5EpWayg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8867
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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



On 1/21/2025 6:26 PM, David Hildenbrand wrote:
> On 21.01.25 11:16, Chenyi Qiang wrote:
>>
>>
>> On 1/21/2025 5:26 PM, David Hildenbrand wrote:
>>> On 21.01.25 10:00, Chenyi Qiang wrote:
>>>> Thanks Peter for your review!
>>>>
>>>> On 1/21/2025 2:09 AM, Peter Xu wrote:
>>>>> Two trivial comments I spot:
>>>>>
>>>>> On Fri, Dec 13, 2024 at 03:08:44PM +0800, Chenyi Qiang wrote:
>>>>>> +struct GuestMemfdManager {
>>>>>> +    Object parent;
>>>>>> +
>>>>>> +    /* Managed memory region. */
>>>>>> +    MemoryRegion *mr;
>>>>>> +
>>>>>> +    /*
>>>>>> +     * 1-setting of the bit represents the memory is populated
>>>>>> (shared).
>>>>>> +     */
>>>>>> +    int32_t bitmap_size;
>>>>>> +    unsigned long *bitmap;
>>>>>
>>>>> Might be clearer to name the bitmap directly as what it represents.
>>>>> E.g.,
>>>>> shared_bitmap?
>>>>
>>>> Make sense.
>>>>
>>>
>>> BTW, I was wondering if this information should be stored/linked from
>>> the RAMBlock, where we already store the guest_memdfd "int
>>> guest_memfd;".
>>>
>>> For example, having a "struct guest_memfd_state", and either embedding
>>> it in the RAMBlock or dynamically allocating and linking it.
>>>
>>> Alternatively, it would be such an object that we would simply link from
>>> the RAMBlock. (depending on which object will implement the manager
>>> interface)
>>>
>>> In any case, having all guest_memfd state that belongs to a RAMBlock at
>>> a single location might be cleanest.
>>
>> Good suggestion. Follow the design of this series, we can add link to
>> the guest_memfd_manager object in RAMBlock.
> 
> Or we'll move / link that to the RAM memory region, because that's what
> the object actually controls.
> 
> It starts getting a bit blury what should be part of the RAMBlock and
> what should be part of the "owning" RAM memory region :(

Maybe still part of RAMBlock. I think guest_memfd state should go along
with "int guest_memfd" as it is only valid when guest_memfd > 0; And
guest_memfd is only valid for ram MemoryRegion.

> 


