Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 672939BD73F
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Nov 2024 21:52:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8QWz-0004sR-4M; Tue, 05 Nov 2024 15:52:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick.p.edgecombe@intel.com>)
 id 1t8QWt-0004sD-NB
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 15:51:59 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick.p.edgecombe@intel.com>)
 id 1t8QWr-0004LQ-0D
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 15:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730839917; x=1762375917;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=keDXEsi9JFPfKlCf22IeWSD/+U1X0c0RvTAG+ANe+y0=;
 b=cWX8+5aOWTy5ufO+FzHXYPdv3hmg87gSH0wzF5JB3dcTlp4Aql5CxsnG
 WVkLPH5DJqhFcGBdsLGgC6R/pObgttr0wbjoISsfa0vpheQ7Y5ZBq4rsn
 +X3dyMi/O883WcrZuAg0k5CcTT1+NXZJ+LljgQAU3irnTB4G0G89jXI4c
 2CRWab+m5Rdx8A+aMmlWKWC3kkLizx7rnbDRq8y1aaEM3QduVQKM6llwP
 mGmx7iXdVAVjhHRnrZIDVQyEoQBa82hupMnA2kq71kCBPK8ZOTxor9zPc
 BJwxY8+LLYcB2d1cwQcPUlB6dz5znOcTzgb6GdAvNZVdrq6oRgIO+kB3Q A==;
X-CSE-ConnectionGUID: PGKbDd1dQc+PjmlqVSHSxw==
X-CSE-MsgGUID: ADJYgNgeSNeMBx702aOQDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30568182"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30568182"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 12:51:53 -0800
X-CSE-ConnectionGUID: CQEEifmtS+K2QcMmgcuimw==
X-CSE-MsgGUID: S1+fmzBlRXe39V04ohcJcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; d="scan'208";a="88734186"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Nov 2024 12:51:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 12:51:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 5 Nov 2024 12:51:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 5 Nov 2024 12:51:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixGnDuLiJ0vRniv+ojNvbe0alfgdmQ94Qk+FNpuYh+hloirYjPeDJybEiOMf5xhzBo3MFaVNN99rIzgAACqB0RF4U9X8rV8IHnRjUNSQ8KcX3bRSBIS8t63E8dNNAuPceXbpZgrL7l0pbRbiWPpfENvkdNhtUQKi5ZXWQ71GnXkep7Kgeyq5vodH+GrKcRcub4AmQtftx3dcFTqC0MY7n6cWSCiRn9C/xQ9eE3KLj7wM2FUn/zD/8xDn8bvCubIE1LsWm+AYiSqH40Mo/aVCcWy6WDhtk5G1Ed0vzb3fMwTiscf6V+VPXePCfSMFeRCCSPmpHt8WrCnbC2HGFF5NoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keDXEsi9JFPfKlCf22IeWSD/+U1X0c0RvTAG+ANe+y0=;
 b=VPwgr5AOog5Xes9iyKI4ccM17Blzlnw2pB7rHblg2kLcn/ixYW4+KoVN3wgGJsuGQx2zk0dGfUjRZjnYmitVFk8ozun1/OhrDd4kNossSCV+2Vrwhj6L5H/B53ekkEW93uQNky6w+kgcc8JgpQRFGCfze7lR9H4BYdw9/G9KPIPvu3WufCKa/ckKUBRFT/3igUWXJUWvxK0+ho1f3GkIbgQ5A7zpwlHi2ULVapzS2QBHp1+7ZnTVyv+GrnQpKfEZxMX+mH5d5SKQtwxXgRUmnV1DXaPHYDGR639arR29EFtS9tnFNXhVGdaCESqvgthQX4UCZ8GtpJx8ljhgG1dp1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA0PR11MB4637.namprd11.prod.outlook.com (2603:10b6:806:97::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 20:51:43 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 20:51:43 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "Liu, Zhao1" <zhao1.liu@intel.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>, "Li, Xiaoyao"
 <xiaoyao.li@intel.com>, "tony.lindgren@linux.intel.com"
 <tony.lindgren@linux.intel.com>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>
CC: "armbru@redhat.com" <armbru@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "wangyanan55@huawei.com"
 <wangyanan55@huawei.com>, "berrange@redhat.com" <berrange@redhat.com>
Subject: Re: [PATCH v6 09/60] i386/tdx: Initialize TDX before creating TD vcpus
Thread-Topic: [PATCH v6 09/60] i386/tdx: Initialize TDX before creating TD
 vcpus
Thread-Index: AQHbL00oyfgwDO3nBkaUsK6wSNJRMbKpKm4A
Date: Tue, 5 Nov 2024 20:51:43 +0000
Message-ID: <1235bac6ffe7be6662839adb2630c1a97d1cc4c5.camel@intel.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-10-xiaoyao.li@intel.com>
In-Reply-To: <20241105062408.3533704-10-xiaoyao.li@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA0PR11MB4637:EE_
x-ms-office365-filtering-correlation-id: 2de3585f-74e5-4dc2-7c69-08dcfddba808
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?blJQN0NZV1JwK3lmSnU4enhLTXJGcnJoRlhBMHl0NDBWVk5LSEE3ZzVPTVFr?=
 =?utf-8?B?eEZxbnhieno4cDJpZDNEcjlzQkdkcTNhdkRJTHpBWUUrRytrSXMwUFlGMmlD?=
 =?utf-8?B?bzROZ0c5Rll6RmZBUHBqbHZXV1FCUy9rUlFsQXlxN2tiUFk2UlB2V09iR1ZZ?=
 =?utf-8?B?MnhGR0ltcU5UQnBFcUFKc0FrUlVncVlOUjk5a1dWU2dQcndHQjRuaW1LeEVk?=
 =?utf-8?B?d05EemdEVE15c1ZuQ0oveTUxemNUdERiSThMK2pla0pzUFlyNWVhTmJra0pp?=
 =?utf-8?B?U2gyaU14bWFJM0JPOG1DMWJLY3k0NGE2NHVmZTZrbDkzZnV6VEE5LzlRdExq?=
 =?utf-8?B?WUZuNXB1ZUMzb1h3YlZTTkhuVWU0Z1hVaVFlZWZIMUZKbVFYbTc2S0ZWWEs5?=
 =?utf-8?B?bXpUNFZYRXRGcXZGWktlZ0JZVVdTK1N2ZXpnT1NKcEFINGMzTnhGQUtyc1B4?=
 =?utf-8?B?V1Y0ekMvblpTdUI5TS95L3VHY0MzTk90QTNHSm1Qb01kM1hLYWpMcDV2R1VL?=
 =?utf-8?B?ejB6c1d5eEp2YWJWakxteFlQS1h2UVIxUjBHcmlZSSs3eXB2Y3JLZ3Z1RW9q?=
 =?utf-8?B?Y3paV3dEOWtnM3RFcWxVdEFCZkx2LzhaSHFzaCtVRmlvZlhhV3BaWWNDQ2Y2?=
 =?utf-8?B?bWMzMWllWGF2UXVKaWF3OWtUZ2Vrd01xZDI5aEJidkNjaHB6U2tERjdqYUQ1?=
 =?utf-8?B?bHZ5ODJ6RTV1T2YxV2ErdUxKSllzZUJRblFqUzdSU0s5UVdpVFFmQStrbzlu?=
 =?utf-8?B?Rmdxb2dwbFR6QnNtZktyZTRWRDJwOU9IbzUwdStHeDdkV012R09xeWUvWnV3?=
 =?utf-8?B?ZlZDSGR1UVhlMmFicGY4WkVpK0kyc2crM1BDM2x2dVg2Yy9jenAzVFk3TkJo?=
 =?utf-8?B?N0lXclNiYmRjVXdSempMZHBvd3ZFLzRWOVpMSjB6SVBBQzgvWDNVNGhha1BY?=
 =?utf-8?B?V1lDdStBN1RlMHpWYVBNV2xvdXQyZ3p5WDB0c0UyS3FhSFhCQU5GZkRmaWth?=
 =?utf-8?B?cUpMYVl2LzhQU0RTd0pSTHlpVnhOL3hSV1Z2MUFIV3E0S1BuZzc4Z3RvMGEr?=
 =?utf-8?B?UnY2VTR6VWthNjY0K3FnZmxyVWlnQUtvTFBobFNvYmZkbVl6c29vbGFrZ2tt?=
 =?utf-8?B?dEJZaVU1eTREV1V0OXBYUG01c09tWHhuQzlIOCtwRFhVeHpRc1JGc0FaM3o5?=
 =?utf-8?B?elZsUTdFazBSb2QydkxBMnUxeXVEUjUvVFZScjZlbHJ2enllblpLK2VmamRZ?=
 =?utf-8?B?dFhZTWg0QW1DM2xmeTVqRjZpTUhCSFJ5TmVWeG94ai83UXVRbGVqZEVTVzJW?=
 =?utf-8?B?UTdxbG11V0dOUWN2bUZiSUwrQUF3SVNLMkl2enhPb3RIVGprdVZ0Sk1kVUtB?=
 =?utf-8?B?bVVjTWh6cDhwaVZ6YUtjU3Q2ZHMxbWQzSy9CbkxoWFRYODBYWWtWajJSZmtB?=
 =?utf-8?B?NWRrK0RZQi9CUHZQcTlvRnFFTnE3L3JUTzRQWndqcVVNbmJWOUdja2JoMjA1?=
 =?utf-8?B?bW81cEtpNTlsS2d2RGZFWFhZZ0MrRkJiZW1tN0FqSmFPUXdlUUs2Y1pCdkt4?=
 =?utf-8?B?b3IrbnlaRHl1NG9IT01SRklJTit3MVdXVlY0SHRhR0h4MzFYdisrS0Uzejgy?=
 =?utf-8?B?TDBoRzg2aUY2SEhVWWlmVkhmYU5VYkUzV0MvK1ByTDhINnZCaE5aYk1PZ2Vt?=
 =?utf-8?B?bjFhWFNud2I3Z0JqVWgyYy9xdTlWTkdRMnVQUjZzZ1kvTXdMbERPY2JvME1m?=
 =?utf-8?B?QlFrbTIwQlJDTjhUMHBIRis5YnhIU2VSRi9zcEI0WXFiaExSTVMxcTNHZWVQ?=
 =?utf-8?B?VnpOMWJxek8xN0gxWVdxVmhDM0hNaGlRLzFLZW9SMVVmS1ZOTnBYUkFBNDhH?=
 =?utf-8?Q?OKuKAt5duX8nI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB5963.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2JHb3R0NGFBZlRZYk05SmRUeDdaR082d2g5aVBDK3Z0anNLRldqV08wdkFs?=
 =?utf-8?B?SDl2SFRRSkJOaU5XOVhUME1QZ2kwUDJBMERLMEJTQXdjYlp2MVZRczE1Rzlw?=
 =?utf-8?B?UEFRbU41d0JJRm8xSlJmdGRLUHFkeHFFL3gvbG9VeWRmd3EwdGRoVXJVSWFz?=
 =?utf-8?B?L0ZGZnppVTNURjBYeDBhTExmUGNGbVlFMWxBZnczbzVmMmRlalFtLzFtRDBj?=
 =?utf-8?B?Vk95bFFOYU1peWQwcW4xZ3Zya2Jkam0wNDQvTytJc2RZYWR3Wm5adGZySS8y?=
 =?utf-8?B?dmRwNW5NNENNWHlVcDNqemVGSXRxZlAybU9MTWsxTVgyamsrWXVOWEpQcEVH?=
 =?utf-8?B?UWU0TmYvRmVLV2Z5S0dxNFdxWVdENkdSa2NqOFlKUzJpcm9lbDE5MTZRbWF0?=
 =?utf-8?B?cEVvdW1FNkxmWERZcGtzd24ybWVsQ1BrY0hXTnJPMjY3UE9BL1MzK0hBclBs?=
 =?utf-8?B?amFZRy8zUXZLM3R3QkdKY001Q0NmbUpBb0JCOHA3RXFwQzluNy9Vend4VUs5?=
 =?utf-8?B?cS9uZUppblZ3RkZvcDN5Q1Z3ZXh4Vml2UjJQSFVhZ25IQ2ZFYTVwcUcyMUxq?=
 =?utf-8?B?NnIxRmxyQlRXWU9VcWNHMnErNEsydXBmWFp0S0dkd0dzc1ZxbG5GSmVZN2Ix?=
 =?utf-8?B?VVNYYlpaK1FWcGtxMmhsZFhmK1UxZWhSeHJLZzNhQ2lDRklDZlZhaHdoQmgw?=
 =?utf-8?B?WVp4Sm1NWFd5YjN0MEJZTVJKbDFCZmM5aGV4cWhtWTRtcmhRODZXVVdsamZx?=
 =?utf-8?B?Q0czTUdvYkZ3K3J5SVg5Mlo5djQrMnIxUTFKUUpFRmh4RitrMmtKMlc2a0ZF?=
 =?utf-8?B?Z2d1RTFSUC9mcHl0bDRodU5nVDZ1T1pCeWZYUkZDaWErazkrSHFPZ2J2QzdZ?=
 =?utf-8?B?dkQwK1ZZNXcxZFg2MFUxYTVoMmd1dENJOS9XMk9WWlpOTnFpa3NOREcvNkl5?=
 =?utf-8?B?QlJGVWEzMG0wVmxkWGxRZ1owRFJNdmRDSjBSQVdGcFNqL1kzWXJSaktQT0Ft?=
 =?utf-8?B?SDlHOEVoQzh2MXpEYlhqOS8wd1BXMlFqMjQ2dEVCOTBzbGt3MTUzRmhkNjZ0?=
 =?utf-8?B?T3AwNjdtaXlNaEhxZkxrVzlTUnRxRWFkVG9TSFB1K2VOZDAweWEzcmpsYk1h?=
 =?utf-8?B?R1ZoVE9nMXN1ZzhtRFZEWEtiQ3cvWlJTa0NqUElQWnR5UFQrMWFMSGZGQWFV?=
 =?utf-8?B?SlRUalZPRmNPcENFbytpY2hyem14Y3hwMXBOZFZMQUFoREZHUFM3TUhKNGpO?=
 =?utf-8?B?eWdDZ0tRQ2JmdkEzeW1tNEhKK3M5cEVqNkM0VzF2bHozTmFvSStXYmJMRDJj?=
 =?utf-8?B?UzZmbjhUa1NLZ3lGek5GN2I1ZFEzazd3WGhqbzVMU3pranJUa21ML2VYMFI1?=
 =?utf-8?B?S2ozenF5cTZmb1FoRGFwZnFjb0lFUTZkU1ZmTUNlM2FiQ1ZJZ0FLOWx5ZlI4?=
 =?utf-8?B?MmhCblFhdDNVenloMmtoWUhiTGQ2SkVhRFFhQzBRWTgzQnJVMlFrV09xRXdN?=
 =?utf-8?B?YmJHWWoyRStFNDVrRVJ5Yk5udUI1YU9CWDJxSVhDaXdZYXFMVjRDU3BWSTlm?=
 =?utf-8?B?NjYrZjNsaHN2SWQ0YmJBdEdwQlpZUGs3bzlLSmJLTjhxRXpTQkRhbDlpK1px?=
 =?utf-8?B?VVlyVTgrdXZCZEdYNHlUWEtpdkdDNCtESnRLV0VQUDVhOEhwREdQY3RsR1U1?=
 =?utf-8?B?dmwrNmUxUW9DcEtmd3ZHNTlZSmdBMnhRRlIraFpSblRCTFJoQlBQMW5ocUJ5?=
 =?utf-8?B?bk1jSk5WSEt4eUxUNXp5WklycVZDbXpJNmx2ZzRQQ3NhSHBnMExoUlNudGg1?=
 =?utf-8?B?REhLWW1yYjkwZ1FSV3NjY09BdXpWU0V4eVZ4bGhhcXA0a1VqSzloTm9USHpp?=
 =?utf-8?B?eW5iWkJ6OWF6blZyb280MUd6V1hUcnFJUUdzUUdVemZDT0k5R2NjS00yVDVr?=
 =?utf-8?B?b1BHaUp6c2FUZVk2WnJLeVpJU2tDUStOWGcxdHFwMUl5S21ONWtHdXBrZ1dn?=
 =?utf-8?B?bDNuT05LcTJsbGs5K0ZFN1BpY3NwRDYyN1dhYmN2Zm5kWHpEYTJWTGwwL0FT?=
 =?utf-8?B?Njc2d3BDTk1EU3pMaXh1cTByVUNoSVZheTZCb1NiK1dBa3M1VjEzbzd6cDNk?=
 =?utf-8?B?cVhmbDN0M1FoYms3ZW9mRkpGTzVtRG1MdFd6cnZFWGE5MnJ6UEJZajRMb3VC?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAFFD70045F01E4B920ADFC3264FF028@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de3585f-74e5-4dc2-7c69-08dcfddba808
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 20:51:43.7956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MjIfuc1Awq6gr3lA1TV/K20gJMNuiEhZZGsq9ByrrrOwE38bAmMxLso1BV4x9xBYY2bscnEpwrJF/eFIVUc5z7M9ZR1Em6cZocEnbu3qPPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4637
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=rick.p.edgecombe@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

K1RvbnkNCg0KT24gVHVlLCAyMDI0LTExLTA1IGF0IDAxOjIzIC0wNTAwLCBYaWFveWFvIExpIHdy
b3RlOg0KPiAraW50IHRkeF9wcmVfY3JlYXRlX3ZjcHUoQ1BVU3RhdGUgKmNwdSwgRXJyb3IgKipl
cnJwKQ0KPiArew0KPiArwqDCoMKgIFg4NkNQVSAqeDg2Y3B1ID0gWDg2X0NQVShjcHUpOw0KPiAr
wqDCoMKgIENQVVg4NlN0YXRlICplbnYgPSAmeDg2Y3B1LT5lbnY7DQo+ICvCoMKgwqAgZ19hdXRv
ZnJlZSBzdHJ1Y3Qga3ZtX3RkeF9pbml0X3ZtICppbml0X3ZtID0gTlVMTDsNCj4gK8KgwqDCoCBp
bnQgciA9IDA7DQo+ICsNCj4gK8KgwqDCoCBRRU1VX0xPQ0tfR1VBUkQoJnRkeF9ndWVzdC0+bG9j
ayk7DQo+ICvCoMKgwqAgaWYgKHRkeF9ndWVzdC0+aW5pdGlhbGl6ZWQpIHsNCj4gK8KgwqDCoMKg
wqDCoMKgIHJldHVybiByOw0KPiArwqDCoMKgIH0NCj4gKw0KPiArwqDCoMKgIGluaXRfdm0gPSBn
X21hbGxvYzAoc2l6ZW9mKHN0cnVjdCBrdm1fdGR4X2luaXRfdm0pICsNCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZW9mKHN0cnVjdCBrdm1fY3B1
aWRfZW50cnkyKSAqIEtWTV9NQVhfQ1BVSURfRU5UUklFUyk7DQo+ICsNCj4gK8KgwqDCoCByID0g
c2V0dXBfdGRfeGZhbSh4ODZjcHUsIGVycnApOw0KPiArwqDCoMKgIGlmIChyKSB7DQo+ICvCoMKg
wqDCoMKgwqDCoCByZXR1cm4gcjsNCj4gK8KgwqDCoCB9DQo+ICsNCj4gK8KgwqDCoCBpbml0X3Zt
LT5jcHVpZC5uZW50ID0ga3ZtX3g4Nl9idWlsZF9jcHVpZChlbnYsIGluaXRfdm0tPmNwdWlkLmVu
dHJpZXMsIDApOw0KPiArwqDCoMKgIHRkeF9maWx0ZXJfY3B1aWQoJmluaXRfdm0tPmNwdWlkKTsN
Cj4gKw0KPiArwqDCoMKgIGluaXRfdm0tPmF0dHJpYnV0ZXMgPSB0ZHhfZ3Vlc3QtPmF0dHJpYnV0
ZXM7DQo+ICvCoMKgwqAgaW5pdF92bS0+eGZhbSA9IHRkeF9ndWVzdC0+eGZhbTsNCj4gKw0KPiAr
wqDCoMKgIGRvIHsNCj4gK8KgwqDCoMKgwqDCoMKgIHIgPSB0ZHhfdm1faW9jdGwoS1ZNX1REWF9J
TklUX1ZNLCAwLCBpbml0X3ZtKTsNCj4gK8KgwqDCoCB9IHdoaWxlIChyID09IC1FQUdBSU4pOw0K
DQpLVk1fVERYX0lOSVRfVk0gY2FuIGFsc28gcmV0dXJuIEVCVVNZLiBUaGlzIHNob3VsZCBjaGVj
ayBmb3IgaXQsIG9yIEtWTSBzaG91bGQNCnN0YW5kYXJkaXplIG9uIG9uZSBmb3IgYm90aCBjb25k
aXRpb25zLiBJbiBLVk0sIGJvdGggY2FzZXMgaGFuZGxlDQpURFhfUk5EX05PX0VOVFJPUFksIGJ1
dCBvbmUgdHJpZXMgdG8gc2F2ZSBzb21lIG9mIHRoZSBpbml0aWFsaXphdGlvbiBmb3IgdGhlDQpu
ZXh0IGF0dGVtcHQuIEkgZG9uJ3Qga25vdyB3aHkgdXNlcnNwYWNlIHdvdWxkIG5lZWQgdG8gZGlm
ZmVyZW50aWF0ZSBiZXR3ZWVuIHRoZQ0KdHdvIGNhc2VzIHRob3VnaCwgd2hpY2ggbWFrZXMgbWUg
dGhpbmsgd2Ugc2hvdWxkIGp1c3QgY2hhbmdlIHRoZSBLVk0gc2lkZS4NCg0KPiArwqDCoMKgIGlm
IChyIDwgMCkgew0KPiArwqDCoMKgwqDCoMKgwqAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCAtciwg
IktWTV9URFhfSU5JVF9WTSBmYWlsZWQiKTsNCj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiByOw0K
PiArwqDCoMKgIH0NCj4gKw0KPiArwqDCoMKgIHRkeF9ndWVzdC0+aW5pdGlhbGl6ZWQgPSB0cnVl
Ow0KPiArDQo+ICvCoMKgwqAgcmV0dXJuIDA7DQo+ICt9DQoNCg==

