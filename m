Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D678EA11985
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Jan 2025 07:16:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXwh8-0004MO-KT; Wed, 15 Jan 2025 01:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tXwgm-0004LN-1A
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 01:15:41 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tXwgg-0005Og-RU
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 01:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736921735; x=1768457735;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=i9NUT+P6EXk8j5kDxYi9jCwEj6cZ161RySIg5JQPVY8=;
 b=dGJi24E5o0kB2x2hl1a4SMJuxl/CYZpXI8P6dqKyCFnqE7DGBzzC4wfg
 rONmHgKxNL5Xtl3deglAUgkyp5WghKw3pAMNtwDPPFrgq0FYGccX2NaPA
 Vc9FyuOYuhsU0Rl5T0f1MeKZTOMz68Ys8y4ea1f2OLVFC+wQGQN0iiWes
 d9b/+3Y7NpQbOTm4V7vXHA2XKL1codQt7CGy+wOaPQ1reS9XLWJZHI+KM
 M43ArVNEBRLNmc3tSOkEtohrYph+mO2tHUb50ZXBlECIJ+/TLew5vXYTy
 WWOpuxhmvoPxNDk2KOGb1BXCX8yJoj8z0QF4hXUwuwwr3Owqi1dDu/r+a Q==;
X-CSE-ConnectionGUID: ZjBdywGPSxmcMEDRFbO4TQ==
X-CSE-MsgGUID: pFf90SZeQJ+2q+/6s6YfUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37157441"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; d="scan'208";a="37157441"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2025 22:15:31 -0800
X-CSE-ConnectionGUID: p3DvmvCARyS4N05xwEIdTw==
X-CSE-MsgGUID: KIG+5gy+Sf6u/BAjjrtViQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="109098222"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Jan 2025 22:15:31 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 22:15:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 22:15:30 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 22:15:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfCyoM9H0vIcNNiOcjwT6HvNF3gRsM5lQRh4V8GBTRKrcc+x4iYYTVco2BbKYBmnetiKcWddGfXvpx55/GEXwQZHN/IMCLljl9Xq+/wyGRFjixuj5lE3G+LFRgJhrWJkSz1SSqwPwlGytN+d5PkoPIhnK+0CVF8oZ0yyZ2/AxBqfI/rycYqrxvj2LNQaMunp4lkfT3wzOdVt+aNGBp6XfzMd9NZl/4o43vOd/0PWCtxZX7F1jMXDiiSnGbaW/pn8fjBfHKDHEYG+De5kWdl1N700cowFcydPWGo7AttH+CqSSWAWe2Ob/XzMN7w145aj+t55tDg9QpG/CiGPyNHO1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwZyjtc71NoVOaxNl8xi0uNN9xN6OPc/AJOcyUCZ97E=;
 b=ZlGLjq3c3jm7mQsIN4AHdu9YXGdjAdIhiXmVhuhmQiFi9ijYAOUrv04X/85cyXdBSzsRdtvZqd9/I45X85yC6CfRlV3sB3/WOWQjOnJnLCT+71aQLDMRlPJr0aBM5Gt48Xqt7kIKzYohzUqNyfsCAHnoxe0CejXQ9StcQ/LDCJyBy25vfZ8DZUTQIkoNrSjX7JT9sKzcY1OBycnw7aQn/7TLiLk5YBZ5+AqPfMchO2Z+VR2h7BvhYYBFFsiE+gBziOkJygi6mXFwBrdWwSYMnyMo3sLjFi4m9ouK531rdDAsds2kpe7Br1MxvJDNK1+lvYQ52VsosEiqceHvBzIj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 06:15:28 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%5]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 06:15:28 +0000
Message-ID: <590432e1-4a26-4ae8-822f-ccfbac352e6b@intel.com>
Date: Wed, 15 Jan 2025 14:15:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
To: Alexey Kardashevskiy <aik@amd.com>, David Hildenbrand <david@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Michael Roth
 <michael.roth@amd.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Williams Dan J
 <dan.j.williams@intel.com>, Peng Chao P <chao.p.peng@intel.com>, Gao Chao
 <chao.gao@intel.com>, Xu Yilun <yilun.xu@intel.com>
References: <20241213070852.106092-1-chenyi.qiang@intel.com>
 <20241213070852.106092-3-chenyi.qiang@intel.com>
 <d0b30448-5061-4e35-97ba-2d360d77f150@amd.com>
 <80ac1338-a116-48f5-9874-72d42b5b65b4@intel.com>
 <219a4a7a-7c96-4746-9aba-ed06a1a00f3e@amd.com>
 <58b96b74-bf9c-45d3-8c2e-459ec2206fc8@intel.com>
 <8c8e024d-03dc-4201-8038-9e9e60467fad@amd.com>
 <ca9bc239-d59b-4c53-9f14-aa212d543db9@intel.com>
 <4d22d3ce-a5a1-49f2-a578-8e0fe7d26893@amd.com>
 <2b799426-deaa-4644-aa17-6ef31899113b@intel.com>
 <2400268e-d26a-4933-80df-cfe44b38ae40@amd.com>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <2400268e-d26a-4933-80df-cfe44b38ae40@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|IA1PR11MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 76354c6b-9085-458e-9a5d-08dd352c01b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wm5OWjBRRlUyQVA2WkdZNWkwZ2d1NTg2V2c4QzZMNS9jTXdmV2VwcWRkWU05?=
 =?utf-8?B?RmtLYnRMcXZLdWk1ZFBlbkx3VzIyeCtraC8ydEdra1lkV0FtRVNGSlRUMU81?=
 =?utf-8?B?VWUweVV4ZVRuYzgzKzRWMVhEdXIwMmN3eVNMU1ZIeERXbzlOc1RybmxiSGxX?=
 =?utf-8?B?d003dU9GdUtHcXNkQXZjL3V0V0M5QlZvQWxXMFExRW85OXNpNTV4WTgrdFNq?=
 =?utf-8?B?T1lBRXNlRERIQ2lWYU12TGRhZWJRdW1aNDhuN3NvTmlqUllUbW42Ynd2QXhC?=
 =?utf-8?B?TkJXYlhNQnBVdEc4VWNDRjVyc09zSTBzd1VZWnp4WTJPZDFNSnFuaUpVaVdB?=
 =?utf-8?B?RnYwdStUQUdvREU2aEI3amVETG00alFVMzZORHBqaFNRSE9hZmh6OXpRZTlK?=
 =?utf-8?B?WEU3ajIvSEJjNnVLbzVseGJSZm5KTXd2ZWRxMHF5YzMrb0ZuSEc5TEgvY0tC?=
 =?utf-8?B?M1ArUkt6akNkZ0N3cUFnV3daa0RtMmZ0TjVrOGdaSlBTRVdZRXdEQnhuZDEz?=
 =?utf-8?B?UlFTM2dMWHFzWU82RUV2N1VBZHJOR1kyVlhmOFBTMFY2NDgxM3JZSUVPaW1v?=
 =?utf-8?B?ZkswYmpLRXhuVlRuTmVzMWFUN1AySW94dlB1RWoxdEhxcjh3Q0ZQTHJINjdl?=
 =?utf-8?B?MFVYcEZZVjBIR2lWZ2xVM3luQmttYUprQVh5aU91UmNmaVU5TGdFMTdvdHNX?=
 =?utf-8?B?c1dJMjBVR3JuMlZJWWZFb1VLTEFybUFJQlBKaTB6a0hmUzB4NndpaGpFYnZn?=
 =?utf-8?B?Zi9VRUY1T3hrSVNWYytyeWFwRmZnaUtJVEZ2WU4wQjM3cWlEeS94YVBmVjV3?=
 =?utf-8?B?ckR4SWw5L205VDdZR0M0b2VWcnI1RGZCUWdVN0pON3RKbHpuc1MveHgxdUVl?=
 =?utf-8?B?YnlEVWY0M09OMUFwY2puWGRhMFU1dVgwVzJLYjU3aVNTdGwvUG5VWGpRL25l?=
 =?utf-8?B?OFRacUl1SmJRK1JRb0ZtVStsb0J3SHduNWdPWm5XcllPSlkzbERRajlkVGd2?=
 =?utf-8?B?dWIxaGVwV2hUZ2gxMkVRbm90cmlJWU9JVEZMUHdRbEl6MldRVjdkSC9MWjVW?=
 =?utf-8?B?aXEwRXZLR2ZDV3o2eEpFWndOZTFoZTRiTWhQSHF6UW56aU83cGhZaUpUcVlm?=
 =?utf-8?B?Mmp4cnRZcTZGMTRjbmRiQnFVT1pQTDg2N1g2VlB5czVDYlZrTEpxOTVZejRy?=
 =?utf-8?B?UWg3VDVkWWZYS0d1UVhoOExjQlFRUXcyYVZNcW9RWWgvWTJwQ0p4ZmdFQWVm?=
 =?utf-8?B?L25mbDZVTytIWVZRcmZhd1pqVWVHMkZ2ckNZVWI2bXA3alNnZSs4QkNXd0NF?=
 =?utf-8?B?VU03dkZtMjBGaXJBNFJBYnB4azcvbG9JVVNXWVA0N0laQUhGQ0F5RjNqbWpr?=
 =?utf-8?B?a3JGN2VPSFpLamtTdklzSUtFL09QUk9OMDNxYXdDVHdqcjZRWnQwMGQ4VkVJ?=
 =?utf-8?B?YmxXV0ZlQXRMQXpvalpmQlVnYWsvcHR5S3prT3J6RHZWTVc4ZjF3aTJ0Z0p6?=
 =?utf-8?B?anRQaHljZkFYVUM2d1BsZWJ3N1hlK3ZUSU9kWnpqWkdJMU56dXROYjI2Tis3?=
 =?utf-8?B?ZTByc3owQ2R2T0lzNm9Db1lRRGxsOXVjbnl0Z3MxRkF3dkcvQ254eGxhakx6?=
 =?utf-8?B?b1cyUE43dWVIRTZoaWJZMUZnZzhuWm1tc0JaV2VvYXhEVC9JU1ExN081bERK?=
 =?utf-8?B?eG1nN1hVbW1PbXB4clRncXVtL2ozYm5Pb2FpRFVVZkFDdlB3dmloTElOV2pn?=
 =?utf-8?B?VFRuVEdCdUEyQmVad2FQUVVVQUVYdWYvNmw4ZXhHY0NlQ25YbFBXd0J6ajMr?=
 =?utf-8?B?ZWZEQWFiQWhRbnpOM2dhUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnNKYTZNTWxPWDJpcklIa1BWRzJ2Ni9rZzJ5MG5Qb3kxc3d3VUgwYmJqZjFR?=
 =?utf-8?B?UWtBZkxqWG5WQzlocnZlZ1p6N3BGTFAzZk1qTk5KNktsbUVwRFl2ZTRNTWxk?=
 =?utf-8?B?NlVmV2pNMFVHcXd4Sm5JTkVyVnlhYjdIQW9zVDBCTnhwTTlkSTZadkF5dW9V?=
 =?utf-8?B?YzVxR09LSHhERTdyNkRXS1g4OEozTE1XSU9IVnFGR2R3VGcraDh1byt2Mk5s?=
 =?utf-8?B?Y2o5aHNJVGh6cGFEbDF4NmM2WTZKK2RFcWxWdldNOWp1UUxBY3RVa2VlZzNQ?=
 =?utf-8?B?N3lOMGFPc3Jmc2hRZmoyb3BSSncxMmo3TzJSb3BGRHJpYmJVWi9PdFNyVSto?=
 =?utf-8?B?dHF6WFlGeWVHbU5DeG85K0RSWXFoUVlkckdFOHZDWGVkRC8wazExSTBKUDIz?=
 =?utf-8?B?R25TcGVPTE0rMW01ZFBrZWMrR3NuTkQ3aWpNRFRpTktVeUFoSG5rM3JtUG01?=
 =?utf-8?B?a1ZFTlpSaWI3Tnd1S29xMDJWemxINUptSEZsd1psOXEwOTBVbis4VlZmU21q?=
 =?utf-8?B?R0dLTGgrQjROZjVWOWJiRWdmZVl1dmQzTVVpUmIyOU54NGpzNFJYOGF0NTdx?=
 =?utf-8?B?VlJtckJYRG9ya29pdHZhMXNSMEVGalh5WGVBWTJZYWtSaEVobmZnalRBN0U4?=
 =?utf-8?B?WndLZXkwNkI2MHIzY1oxODBFWHZGTFZJd0dEOVNERXd4ZWJSalZ5dU5KQ0s2?=
 =?utf-8?B?TUVLS1gyUE9NZTUzaXkvdmJzZEtkT004WTdJSlRDZWhuK3U1blNwaXVIamMw?=
 =?utf-8?B?MXU5U2w3N2NOQmsvVUlGc2J3NU9vOXlNejZnaW5DeGg3ODNraGR2Rm9qcFk2?=
 =?utf-8?B?S3c1WnA3ZE03dTZxdERxQW1VbEtBbzlJM0tRSEdEOHk0WFRCeEJ6czhDcEhL?=
 =?utf-8?B?SDhHM0poRGVLYi9FclVBOG84N0N4cmtmaHVaSHl3eWd5MXJwUElwWTlCNmRL?=
 =?utf-8?B?OWFlRHlkVmp5WWFhbzFDUHM1UVRkcENsbGErQndnWTl3MFFGUHh0YmN3YlFw?=
 =?utf-8?B?Ty9XUko1YS9IV3lIeTFMamxWKzl5NUpuRDNKL0FVTGpDZmd4N0JzUGNFZUht?=
 =?utf-8?B?SDlKekMycVJHWDNzTE9XVWtxdVNBRlhpNVBFVzZDZFNUazh5OGxjd2RNTnJY?=
 =?utf-8?B?UHJZNEVPcXdHa3p1WjVBT1h4bGdCYU9WbmkvRnJNbEp5bWlBT0NVbCs4OXJt?=
 =?utf-8?B?L1ExVTYrdmxreTVuaStmWENWYURTRlVjT2c2b0tQQlkwdXkybEoxWTVPYmhu?=
 =?utf-8?B?dkVnT01XWTNhWWhhR2xDRVl3ZW1ka1ZxU2JUTTY3YWFrNUhvZmZndDNoYUZq?=
 =?utf-8?B?Skl3cnh5YVFUWEw1VG9kSmVtM0M5VHBWSkF6WW05K2Fic1IzSG5YWllTUXk0?=
 =?utf-8?B?QzMwZ2t2d3BJdVVPNUFOUFQwZTlPWXBjNDIrWVd6OUFuZDBuU2dDR291Wlh2?=
 =?utf-8?B?Z2lVTGdYVm5iVU9Ddlp2TFNrL3dycDA4alBhS3RJdlNjMkpqekl5OXVYUXRu?=
 =?utf-8?B?VlNEWDQ2SE53TkJ3azB2RXlWRHZBVmZTdER0R0gwRDM3UW9nK3ZGS1RYZ3Zv?=
 =?utf-8?B?RzJUS2NaemFyMXhwNktiY0JwUHVZMzBqRFJkUThmZ2ZoYVBwbkZNbmZkbmdX?=
 =?utf-8?B?VHBJdWZNQmFwR2M2akxrZHFYd0RsaEE0QkpkMGxQSHJ5aExER001Nmttd21q?=
 =?utf-8?B?VDBHU3M4NHFUd2hMcnR1R0NKdUxsVVhYNUh0dzA2cVFQWFcxbERBSlBYYXo3?=
 =?utf-8?B?N2R5aVVHZCtUdkQxbGlySzk5SUx2TFB4Z25Xbkx0MFlBNUhjV1l0cE1Eeit5?=
 =?utf-8?B?cFJiZFJnOFFNZTN3UHdldlFueWtrSzdiUFVjcHZ2YXhnYk5MUGNHZXZPYTZB?=
 =?utf-8?B?TWl0Q3BBRXZmNjlnZStTWW14YnNaRzcyVWZabXlsMmo3UnY5L2xiVlkxVGla?=
 =?utf-8?B?L000aHVPU2tVVGNtOEg4b2NNcnlGU05DOTdkMm0xdFRuL2N1Y3pTRHBrbFJr?=
 =?utf-8?B?ak0xNGNlZjBsTFpDZWM5M2x5bTZCNGNjNW5XdDBxODcrVk40bFMyQXJ2RmxG?=
 =?utf-8?B?SVAzUDg3SzFwVmZyWTliejdQVW02aDlSc2lCY3lSNGNDc1F2WURPZGZneXJK?=
 =?utf-8?B?SGkxa2JlOTYwdXgzOEdvUWszVXNyb0t5R2ZFdy9yTStoM0E3aG1mY3NabHJW?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76354c6b-9085-458e-9a5d-08dd352c01b6
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 06:15:28.3433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aru3WPwVqAWQmdlxFteO+N7A0+gR6aGG2Es4k1zda1CdWlN2GhF+UrtMGhGmzB2UyN7O+qJ6vrUnLGiugCdtdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6395
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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



On 1/15/2025 12:06 PM, Alexey Kardashevskiy wrote:
> On 10/1/25 17:38, Chenyi Qiang wrote:
>>
>>
>> On 1/10/2025 8:58 AM, Alexey Kardashevskiy wrote:
>>>
>>>
>>> On 9/1/25 15:29, Chenyi Qiang wrote:
>>>>
>>>>
>>>> On 1/9/2025 10:55 AM, Alexey Kardashevskiy wrote:
>>>>>
>>>>>
>>>>> On 9/1/25 13:11, Chenyi Qiang wrote:
>>>>>>
>>>>>>
>>>>>> On 1/8/2025 7:20 PM, Alexey Kardashevskiy wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 8/1/25 21:56, Chenyi Qiang wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 1/8/2025 12:48 PM, Alexey Kardashevskiy wrote:
>>>>>>>>> On 13/12/24 18:08, Chenyi Qiang wrote:
>>>>>>>>>> As the commit 852f0048f3 ("RAMBlock: make guest_memfd require
>>>>>>>>>> uncoordinated discard") highlighted, some subsystems like VFIO
>>>>>>>>>> might
>>>>>>>>>> disable ram block discard. However, guest_memfd relies on the
>>>>>>>>>> discard
>>>>>>>>>> operation to perform page conversion between private and shared
>>>>>>>>>> memory.
>>>>>>>>>> This can lead to stale IOMMU mapping issue when assigning a
>>>>>>>>>> hardware
>>>>>>>>>> device to a confidential VM via shared memory (unprotected memory
>>>>>>>>>> pages). Blocking shared page discard can solve this problem,
>>>>>>>>>> but it
>>>>>>>>>> could cause guests to consume twice the memory with VFIO,
>>>>>>>>>> which is
>>>>>>>>>> not
>>>>>>>>>> acceptable in some cases. An alternative solution is to convey
>>>>>>>>>> other
>>>>>>>>>> systems like VFIO to refresh its outdated IOMMU mappings.
>>>>>>>>>>
>>>>>>>>>> RamDiscardManager is an existing concept (used by virtio-mem) to
>>>>>>>>>> adjust
>>>>>>>>>> VFIO mappings in relation to VM page assignment. Effectively page
>>>>>>>>>> conversion is similar to hot-removing a page in one mode and
>>>>>>>>>> adding it
>>>>>>>>>> back in the other, so the similar work that needs to happen in
>>>>>>>>>> response
>>>>>>>>>> to virtio-mem changes needs to happen for page conversion events.
>>>>>>>>>> Introduce the RamDiscardManager to guest_memfd to achieve it.
>>>>>>>>>>
>>>>>>>>>> However, guest_memfd is not an object so it cannot directly
>>>>>>>>>> implement
>>>>>>>>>> the RamDiscardManager interface.
>>>>>>>>>>
>>>>>>>>>> One solution is to implement the interface in HostMemoryBackend.
>>>>>>>>>> Any
>>>>>>>>>
>>>>>>>>> This sounds about right.
>>>
>>> btw I am using this for ages:
>>>
>>> https://github.com/aik/qemu/
>>> commit/3663f889883d4aebbeb0e4422f7be5e357e2ee46
>>>
>>> but I am not sure if this ever saw the light of the day, did not it?
>>> (ironically I am using it as a base for encrypted DMA :) )
>>
>> Yeah, we are doing the same work. I saw a solution from Michael long
>> time ago (when there was still
>> a dedicated hostmem-memfd-private backend for restrictedmem/gmem)
>> (https://github.com/AMDESE/qemu/
>> commit/3bf5255fc48d648724d66410485081ace41d8ee6)
>>
>> For your patch, it only implement the interface for
>> HostMemoryBackendMemfd. Maybe it is more appropriate to implement it for
>> the parent object HostMemoryBackend, because besides the
>> MEMORY_BACKEND_MEMFD, other backend types like MEMORY_BACKEND_RAM and
>> MEMORY_BACKEND_FILE can also be guest_memfd-backed.
>>
>> Think more about where to implement this interface. It is still
>> uncertain to me. As I mentioned in another mail, maybe ram device memory
>> region would be backed by guest_memfd if we support TEE IO iommufd MMIO
>> in future. Then a specific object is more appropriate. What's your
>> opinion?
> 
> I do not know about this. Unlike RAM, MMIO can only do "in-place
> conversion" and the interface to do so is not straight forward and VFIO
> owns MMIO anyway so the uAPI will be in iommufd, here is a gist of it:
> 
> https://github.com/aik/linux/
> commit/89e45c0404fa5006b2a4de33a4d582adf1ba9831
> 
> "guest request" is a communication channel from the VM to the secure FW
> (AMD's "PSP") to make MMIO allow encrypted access.

It is still uncertain how to implement the private MMIO. Our assumption
is the private MMIO would also create a memory region with
guest_memfd-like backend. Its mr->ram is true and should be managed by
RamdDiscardManager which can skip doing DMA_MAP in VFIO's region_add
listener.

> 
> 
>>>
>>>>>>>>>
>>>>>>>>>> guest_memfd-backed host memory backend can register itself in the
>>>>>>>>>> target
>>>>>>>>>> MemoryRegion. However, this solution doesn't cover the scenario
>>>>>>>>>> where a
>>>>>>>>>> guest_memfd MemoryRegion doesn't belong to the HostMemoryBackend,
>>>>>>>>>> e.g.
>>>>>>>>>> the virtual BIOS MemoryRegion.
>>>>>>>>>
>>>>>>>>> What is this virtual BIOS MemoryRegion exactly? What does it look
>>>>>>>>> like
>>>>>>>>> in "info mtree -f"? Do we really want this memory to be DMAable?
>>>>>>>>
>>>>>>>> virtual BIOS shows in a separate region:
>>>>>>>>
>>>>>>>>      Root memory region: system
>>>>>>>>       0000000000000000-000000007fffffff (prio 0, ram): pc.ram KVM
>>>>>>>>       ...
>>>>>>>>       00000000ffc00000-00000000ffffffff (prio 0, ram): pc.bios KVM
>>>>>>>
>>>>>>> Looks like a normal MR which can be backed by guest_memfd.
>>>>>>
>>>>>> Yes, virtual BIOS memory region is initialized by
>>>>>> memory_region_init_ram_guest_memfd() which will be backed by a
>>>>>> guest_memfd.
>>>>>>
>>>>>> The tricky thing is, for Intel TDX (not sure about AMD SEV), the
>>>>>> virtual
>>>>>> BIOS image will be loaded and then copied to private region.
>>>>>> After that,
>>>>>> the loaded image will be discarded and this region become useless.
>>>>>
>>>>> I'd think it is loaded as "struct Rom" and then copied to the MR-
>>>>> ram_guest_memfd() which does not leave MR useless - we still see
>>>>> "pc.bios" in the list so it is not discarded. What piece of code
>>>>> are you
>>>>> referring to exactly?
>>>>
>>>> Sorry for confusion, maybe it is different between TDX and SEV-SNP for
>>>> the vBIOS handling.
>>>>
>>>> In x86_bios_rom_init(), it initializes a guest_memfd-backed MR and
>>>> loads
>>>> the vBIOS image to the shared part of the guest_memfd MR.
>>>> For TDX, it
>>>> will copy the image to private region (not the vBIOS guest_memfd MR
>>>> private part) and discard the shared part. So, although the memory
>>>> region still exists, it seems useless.
>>>> It is different for SEV-SNP, correct? Does SEV-SNP manage the vBIOS in
>>>> vBIOS guest_memfd private memory?
>>>
>>> This is what it looks like on my SNP VM (which, I suspect, is the same
>>> as yours as hw/i386/pc.c does not distinguish Intel/AMD for this
>>> matter):
>>
>> Yes, the memory region object is created on both TDX and SEV-SNP.
>>
>>>
>>>   Root memory region: system
>>>    0000000000000000-00000000000bffff (prio 0, ram): ram1 KVM gmemfd=20
>>>    00000000000c0000-00000000000dffff (prio 1, ram): pc.rom KVM gmemfd=27
>>>    00000000000e0000-000000001fffffff (prio 0, ram): ram1
>>> @00000000000e0000 KVM gmemfd=20
>>> ...
>>>    00000000ffc00000-00000000ffffffff (prio 0, ram): pc.bios KVM
>>> gmemfd=26
>>>
>>> So the pc.bios MR exists and in use (hence its appearance in "info mtree
>>> -f").
>>>
>>>
>>> I added the gmemfd dumping:
>>>
>>> --- a/system/memory.c
>>> +++ b/system/memory.c
>>> @@ -3446,6 +3446,9 @@ static void mtree_print_flatview(gpointer key,
>>> gpointer value,
>>>                   }
>>>               }
>>>           }
>>> +        if (mr->ram_block && mr->ram_block->guest_memfd >= 0) {
>>> +            qemu_printf(" gmemfd=%d", mr->ram_block->guest_memfd);
>>> +        }
>>>
>>
>> Then I think the virtual BIOS is another case not belonging to
>> HostMemoryBackend which convince us to implement the interface in a
>> specific object, no?
> 
> TBH I have no idea why pc.rom and pc.bios are separate memory regions
> but in any case why do these 2 areas need to be treated any different
> than the rest of RAM? Thanks,

I think no difference. That's why I suggest implementing the RDM
interface in a specific object to cover both instead of the only
HostMemoryBackend.

> 
> 

