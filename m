Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BC2838AB0
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 10:46:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSDMJ-0006mP-7o; Tue, 23 Jan 2024 04:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSDMF-0006m1-Gd
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 04:46:16 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSDMD-0006Zv-0n
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 04:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706003173; x=1737539173;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sYVZmENdbb+Wf+gN0PZjHpnsGMPvEifIqvbWuzr6jtk=;
 b=H+/z8b7hP/dcrarnqe+AjhR0LNi9tFQ/66pxPi5AYXSZN7YJz+mE0Sdg
 8tYwtr3U1e+rHH70dvLFt+yHXd8tMsDj4Z19ZqLV/O8+cCw4nyETrP+hF
 f5yYUgfU/6m3hPhQ5ff7FBdSnkbcFnBKSKpCwuXN2wwmO0hfDB7q1nazU
 HVi0ldKyKcaQG++djBAtewFX7qWTogH+y1ge6ekHmWiISujovGmb3XnWg
 sENnSzC7+2PBjr8y39ap9UB2mf3ZkV7+/1m5+nNjUdVRiEA6K4bYmjTtK
 nII6zkWTXgXS2gIPSQDg2F6mwwGV6boVZvywdjFcp3W7M4HDfXhMf9pzC A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="20038976"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; d="scan'208";a="20038976"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2024 01:46:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="1538757"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Jan 2024 01:46:09 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 01:46:08 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 01:46:08 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 01:46:08 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Jan 2024 01:46:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFskHwQ77GeMNmbf7H4LNtyGNNOxvtuuyjAxSv9ovIeYeNyMJDEVUXz05WXunOza1uPt676JXmDeMw3VhmlP6hQP4zySZUNgJap8uxNGO33W2lJTQZy/C35xKZBEDzhGldeijuWYqfP7LX4YBqhTPYeJ43Cb3TL0l7/CCHLC6R/uLqk1ffbZngMjXMsnMCMHCARb4tg3O4CCgD3h3t/n7Sb51keUvijMoCKnhUjEvQv/AvrjbD1KmA59YN1+pzpuwdWww4WZvrDP7iNTaiFRUbEkZTEOBoq31ZILe1+zL3o0Qs44jD9pnNXOvq1cgZyBVAt7Pnq7FaUoLpasckBHaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYVZmENdbb+Wf+gN0PZjHpnsGMPvEifIqvbWuzr6jtk=;
 b=Jl5+rDt6/8NFVtonXeVCXFlwXwGBdm1pa9ACZo0aHbF5k0BZYLAI1PUl3ejfgVL+KnC6c4/yGi0FzDoHYsGmxcDN6oqyM5zKZb8G55E0Yg2q03tMGb6OizGkY5ZeWWYQrRfEHorBHsY2h8mIg0+NcKPGqHmtg++ro458LHMCS3Mq+CYpLRU0FuqX/DsjK7BxmIyALkvsnESbJPszZbwk43cmvFy2HGW7Macb71gd8zDWkxuil2ktXiprTT40nKnxQD9LqTXguegX1899XsQGx5IHyi0udkCQRLAzQqU1RxZ5UjPj2Es/tOfrcV9YvR1nQdG3jPcCLN2BL1pokl82jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB5518.namprd11.prod.outlook.com (2603:10b6:5:39a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 09:46:05 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3%4]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 09:46:05 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH rfcv1 3/6] intel_iommu: add set/unset_iommu_device callback
Thread-Topic: [PATCH rfcv1 3/6] intel_iommu: add set/unset_iommu_device
 callback
Thread-Index: AQHaR5vxspHwco5YmUmE0e1P7iLakbDmHEsAgAERqgA=
Date: Tue, 23 Jan 2024 09:46:05 +0000
Message-ID: <SJ0PR11MB674451CBD15A1573B09E134C92742@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-4-zhenzhong.duan@intel.com>
 <64d09a08-cf9f-4020-86c7-b0a41eddc572@redhat.com>
In-Reply-To: <64d09a08-cf9f-4020-86c7-b0a41eddc572@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB5518:EE_
x-ms-office365-filtering-correlation-id: aa607192-4280-4853-e3f1-08dc1bf81e70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wBqALCebZeEvpSnlggFSxcEgX3a1e4A+5Xzsxw5GLQgFsvjZd1tvrF/aIJpflewBf+YjIzSkF87NboICAJ6YuS1tEFIdOz/r6exjfH4fpQiAFHLz5fHynSHfXZzo3uNjTwgQk3zM/PqlqekPNRWyIO98XmBza/sDq4aJeO5hz8RQDJYVdg3lZyo8YESSerkIqPceCEEKpAHDX46NiFWYaH65x18OM1EM6q2zbDRuqOAAo0+vqbBDwsrdFTlmayi47mEw/qhU9nMbfKqKIeyYD8peBbTJgBYRQius8f7iUaSP6VbgEnZVEaKiAa5KtC6z2dtmgD9pqj6Oa5vjHAy/6JGpQJyk77LXpO7eOON2Wq7dlJeBQnPvWWe5vXUc5R/CpeMuw5Yi6+CpVjxAy+B1sg76r0sV+Jt7zQIf8JQdooJBnpT8qbfkMGPkeaf/dpaLxCHprweuqoEk0XWwXKL0IVQiFC9K105JXYJVG9gH2Z32mhMg6gYcl7Al2bL7XMKBgPfyLlRtFIwyFNgir2fpESSmrN2SHUF/KhiOw5gn1V0O5ug83mbjGgz8kAsb4VIyhq4YYt1rFHjhfwm84rJerhWUqQSaOK6yuzrJnvE/NyLjKg1mUQ700NF77yuU7ddG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(33656002)(55016003)(38100700002)(122000001)(82960400001)(66899024)(64756008)(4326008)(8936002)(6506007)(66946007)(52536014)(966005)(7696005)(7416002)(2906002)(26005)(5660300002)(9686003)(66556008)(66476007)(316002)(478600001)(110136005)(66446008)(54906003)(8676002)(76116006)(86362001)(71200400001)(83380400001)(38070700009)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlJHVzArZmFTS25wNHJJSE0vL1dEVU1UTER5Z0Y4QzBlRnNseEZuWXFCNzI0?=
 =?utf-8?B?RU9zQWs4cmkrMmptcVd4UFZWY0Zwb2FEK2U5SlgzTjFIanY0aGNYMHU3R0Qx?=
 =?utf-8?B?VnhTenNRd2pDSnJ3ZSt2UlIvZEZBa0dwL05JZFhOcjhjbVIwQWFwWXJVajl3?=
 =?utf-8?B?QnhGSGEyUGJtQ3JqRGNkT3NJVmtpWnRTQTFMZUhvcWxFUm9nK0pmTFNYVGx0?=
 =?utf-8?B?Y1cwMDZvNWxBcVlKMnFmeHdIanI1SzRVMHdSR0FYbmV3dE1UUTd0dmhDVXR2?=
 =?utf-8?B?M21OYitWS3lWLzdjZE5odlcvS29LdFNMVm9SZ1phYXBmUElHUDQzblVTWmx3?=
 =?utf-8?B?ZXkxRCtkY0hONXFtQkFkT0tyRVgxNDBjWm0wSDlDOW5kT1RDUU9KeTVteWtY?=
 =?utf-8?B?N1dkSXM2Q2UyVGh4RXloUlNxQ2ZwWGU2RXIwdTlsZ0N4Ynk4RmgzWVJEMStu?=
 =?utf-8?B?R3lGbWVOSWIvNTB0dzc4NlJudmloVjBkaDA5eDhVQnJtcGMwa0duQmlEcUJR?=
 =?utf-8?B?SFZ2aVR1dkNUTmdmZllieStrd2VvdXM2czNTM2tYbERsYTVsRUl0emJmOFpj?=
 =?utf-8?B?ZksxbUxuMFRoYzVqdW5XZDBVQ3U3SDkxYW1HTlFibTVjaFJWWU5FQ05hOVZJ?=
 =?utf-8?B?WGt1bE1laUtEWHdVUEo3K0RaWE5qK2VMWi95am9WRmdYc3NDcWdCdFFOVDhY?=
 =?utf-8?B?Z1dKc0NicDQxcll1M2J4V2ZRYk9MWjNqNWVFLzFidXVIUWJSYld1eWZyUXRX?=
 =?utf-8?B?VUQ3ek1JMHlKOCt2YUpWbmU3YmVMdnBhY0lJL2MwQ3Zaa2g3THl4RTg0UnJz?=
 =?utf-8?B?U3R5cjFRblAxSjc0WTV0WDBqT0ZhaHk5Y0N5V1c2SldzdzlaUFNJM1M2aVBk?=
 =?utf-8?B?NzlGdERTb24xdFJqbXR6VzJYUUtaKzdjUlg0NkV3K2I3SnhpQkJTVnNkSjFl?=
 =?utf-8?B?UzlNanhxa201WUFDZWtSV2xzSExjVWwvbHpXUWwzbzhSNkl5MzRsbkprTWNG?=
 =?utf-8?B?c25ybmZzTjJSSUx5VGFaZW5Mak5sZWhsYnJZMXNjOThxNWlrT1l0V1YvM2hM?=
 =?utf-8?B?aXFld2VTNHNaMTNZMWNubWVGYkQvaE1waW01WFIxMkpjOVg4YXdabERZR1BM?=
 =?utf-8?B?azU0Wm50eFE4TlBpd1V4N2x4Z0ZBdnpDUkZKdzJCQ3JYanlsZUg2MGpmQTli?=
 =?utf-8?B?dHU2amZWa1VjNzBGSUtlbFc1bjYzaERmRktkcGVSQUJacHN1QTBTZU8xelVa?=
 =?utf-8?B?ZzVLR0wxcFowbllaRFhoazRHSjF0Q1ErUjBCZmViM3RVNGFrelJIZytTRVJr?=
 =?utf-8?B?SVVGMGpvNlV6Rm1DSTA0THkrdk1NbW90Qi9hMm1weXVzU3ltc0hIeXVpc0lh?=
 =?utf-8?B?QTNaUGJ4NVBXQ3ZxUndpcXRQNUtFL2RobzRvUEo2Sld1ODN6bUpZTkJEYzMx?=
 =?utf-8?B?cmtIdENNYk5RdG9jY1NnU1J5dk84Ujd5cWhkdnE5aC9OYlVzdnk4U2VNVURo?=
 =?utf-8?B?OWhoV1pPV09oVmNLTnBhbTUzS0swVTNacWhrQWFaVW1LdE1rcUZCNklvOCtF?=
 =?utf-8?B?V0h1UE9Wbk43aU10Tks5SzV4WHFhamdzUWRGcmhvTjRDeEJaWm1aamNZMk12?=
 =?utf-8?B?V1A0cnRHOFkrQWluMlRCVFRLVGpXWXY0a0M0cGR1NjRTK2dYNjBYVm8vOEFx?=
 =?utf-8?B?Tk1xejRPUzZwTGttelVMVlhvZlVvMHFTcnZkQ0NUa3M4VkxYL1N5TXdCRE91?=
 =?utf-8?B?anQ5WVZ0SE83L2pQZ0hHSDI4dk1HYjJ2bGxTdU1veENrYnArTlRSS1JVbXZo?=
 =?utf-8?B?ZGZkN3ZQTklibHN6RldNNFk3MnAzTnAwcEZFSkJrajd6UWlnQVJFOHIvS2Fl?=
 =?utf-8?B?a2ZxT2RCU2llUytnY3EzWU9QMlIwVjI4azFNaks0SzQ2YStaNTYvUFhuYnF1?=
 =?utf-8?B?cTVvRTFKcGpjY3JaSTBGTUlXT0hiK1Y4WkQ5VkY2bGNoVGpzUDhVbk1mdnBW?=
 =?utf-8?B?aU1EdzFhQzVFY3dyU1JEUW90UjAreWViSjRXa1Z6SWs5UU0reU9oSDN5M2hH?=
 =?utf-8?B?aHI1Uko5Z0pJVGd4UGpnOWdLTEVHMXhTc3FJOGQ3VmEvUk1MeHA2WkQvWWUv?=
 =?utf-8?Q?YfEOe5AC5BAJ3Fb00giFhvpYV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa607192-4280-4853-e3f1-08dc1bf81e70
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 09:46:05.6193 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DGFRgu1K8fgXyNp4ZYYxEGkkerTS1vpSZE4Q92E7bIE5bhX4zI5sSeWwzVGV6qNrQFM8dfz3usSTO0tCaufxUViHuZikiVuthcgWbUxYCPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5518
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YxIDMvNl0gaW50ZWxf
aW9tbXU6IGFkZCBzZXQvdW5zZXRfaW9tbXVfZGV2aWNlDQo+Y2FsbGJhY2sNCj4NCj5PbiAxLzE1
LzI0IDExOjEzLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEZyb206IFlpIExpdSA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPj4NCj4+IFRoaXMgYWRkcyBzZXQvdW5zZXRfaW9tbXVfZGV2aWNlKCkg
aW1wbGVtZW50YXRpb24gaW4gSW50ZWwgdklPTU1VLg0KPj4gSW4gc2V0IGNhbGwsIElPTU1VRkRE
ZXZpY2UgaXMgcmVjb3JkZWQgaW4gaGFzaCB0YWJsZSBpbmRleGVkIGJ5DQo+PiBQQ0kgQkRGLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2ln
bmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1bkBsaW51eC5pbnRlbC5jb20+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0t
DQo+PiAgIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oIHwgMTAgKysrKysNCj4+ICAgaHcv
aTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgfCA3OQ0KPisrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgODkgaW5zZXJ0aW9ucygrKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPmIvaW5jbHVk
ZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+IGluZGV4IDdmYTBhNjk1YzguLmM2NWZkZGU1NmYg
MTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4gKysrIGIv
aW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+IEBAIC02Miw2ICs2Miw3IEBAIHR5cGVk
ZWYgdW5pb24gVlREX0lSX1RhYmxlRW50cnkgVlREX0lSX1RhYmxlRW50cnk7DQo+PiAgIHR5cGVk
ZWYgdW5pb24gVlREX0lSX01TSUFkZHJlc3MgVlREX0lSX01TSUFkZHJlc3M7DQo+PiAgIHR5cGVk
ZWYgc3RydWN0IFZURFBBU0lERGlyRW50cnkgVlREUEFTSUREaXJFbnRyeTsNCj4+ICAgdHlwZWRl
ZiBzdHJ1Y3QgVlREUEFTSURFbnRyeSBWVERQQVNJREVudHJ5Ow0KPj4gK3R5cGVkZWYgc3RydWN0
IFZURElPTU1VRkREZXZpY2UgVlRESU9NTVVGRERldmljZTsNCj4+DQo+PiAgIC8qIENvbnRleHQt
RW50cnkgKi8NCj4+ICAgc3RydWN0IFZURENvbnRleHRFbnRyeSB7DQo+PiBAQCAtMTQ4LDYgKzE0
OSwxMyBAQCBzdHJ1Y3QgVlREQWRkcmVzc1NwYWNlIHsNCj4+ICAgICAgIElPVkFUcmVlICppb3Zh
X3RyZWU7DQo+PiAgIH07DQo+Pg0KPj4gK3N0cnVjdCBWVERJT01NVUZERGV2aWNlIHsNCj4+ICsg
ICAgUENJQnVzICpidXM7DQo+PiArICAgIHVpbnQ4X3QgZGV2Zm47DQo+PiArICAgIElPTU1VRkRE
ZXZpY2UgKmlkZXY7DQo+PiArICAgIEludGVsSU9NTVVTdGF0ZSAqaW9tbXVfc3RhdGU7DQo+PiAr
fTsNCj4NCj5Eb2VzIHRoZSBWVERJT01NVUZERGV2aWNlIGRlZmluaXRpb24gbmVlZCB0byBiZSBw
dWJsaWMgPw0KDQpObyBuZWVkLCB3aWxsIG1vdmUgaXQgdG8gaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oDQpJdCBsb29rcyBJIG5lZWQgdG8gZG8gdGhlIHNhbWUgZm9yIG90aGVyIGRlZmlu
aXRpb25zIGluIG5lc3Rpbmcgc2VyaWVzLg0KDQo+DQo+PiAgIHN0cnVjdCBWVERJT1RMQkVudHJ5
IHsNCj4+ICAgICAgIHVpbnQ2NF90IGdmbjsNCj4+ICAgICAgIHVpbnQxNl90IGRvbWFpbl9pZDsN
Cj4+IEBAIC0yOTIsNiArMzAwLDggQEAgc3RydWN0IEludGVsSU9NTVVTdGF0ZSB7DQo+PiAgICAg
ICAvKiBsaXN0IG9mIHJlZ2lzdGVyZWQgbm90aWZpZXJzICovDQo+PiAgICAgICBRTElTVF9IRUFE
KCwgVlREQWRkcmVzc1NwYWNlKSB2dGRfYXNfd2l0aF9ub3RpZmllcnM7DQo+Pg0KPj4gKyAgICBH
SGFzaFRhYmxlICp2dGRfaW9tbXVmZF9kZXY7ICAgICAgICAgICAgIC8qIFZURElPTU1VRkREZXZp
Y2UgKi8NCj4+ICsNCj4+ICAgICAgIC8qIGludGVycnVwdCByZW1hcHBpbmcgKi8NCj4+ICAgICAg
IGJvb2wgaW50cl9lbmFibGVkOyAgICAgICAgICAgICAgLyogV2hldGhlciBndWVzdCBlbmFibGVk
IElSICovDQo+PiAgICAgICBkbWFfYWRkcl90IGludHJfcm9vdDsgICAgICAgICAgIC8qIEludGVy
cnVwdCByZW1hcHBpbmcgdGFibGUgcG9pbnRlciAqLw0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYv
aW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gaW5kZXggZWQ1Njc3YzBh
ZS4uOTVmYWY2OTdlYiAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4g
KysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBAQCAtMjM3LDYgKzIzNywxMyBAQCBzdGF0
aWMgZ2Jvb2xlYW4gdnRkX2FzX2VxdWFsKGdjb25zdHBvaW50ZXIgdjEsDQo+Z2NvbnN0cG9pbnRl
ciB2MikNCj4+ICAgICAgICAgICAgICAoa2V5MS0+cGFzaWQgPT0ga2V5Mi0+cGFzaWQpOw0KPj4g
ICB9DQo+Pg0KPj4gK3N0YXRpYyBnYm9vbGVhbiB2dGRfYXNfaWRldl9lcXVhbChnY29uc3Rwb2lu
dGVyIHYxLCBnY29uc3Rwb2ludGVyIHYyKQ0KPj4gK3sNCj4+ICsgICAgY29uc3Qgc3RydWN0IHZ0
ZF9hc19rZXkgKmtleTEgPSB2MTsNCj4+ICsgICAgY29uc3Qgc3RydWN0IHZ0ZF9hc19rZXkgKmtl
eTIgPSB2MjsNCj4+ICsNCj4+ICsgICAgcmV0dXJuIChrZXkxLT5idXMgPT0ga2V5Mi0+YnVzKSAm
JiAoa2V5MS0+ZGV2Zm4gPT0ga2V5Mi0+ZGV2Zm4pOw0KPj4gK30NCj4+ICAgLyoNCj4+ICAgICog
Tm90ZSB0aGF0IHdlIHVzZSBwb2ludGVyIHRvIFBDSUJ1cyBhcyB0aGUga2V5LCBzbyBoYXNoaW5n
L3NoaWZ0aW5nDQo+PiAgICAqIGJhc2VkIG9uIHRoZSBwb2ludGVyIHZhbHVlIGlzIGludGVuZGVk
LiBOb3RlIHRoYXQgd2UgZGVhbCB3aXRoDQo+PiBAQCAtMzgxMiw2ICszODE5LDc0IEBAIFZUREFk
ZHJlc3NTcGFjZQ0KPip2dGRfZmluZF9hZGRfYXMoSW50ZWxJT01NVVN0YXRlICpzLCBQQ0lCdXMg
KmJ1cywNCj4+ICAgICAgIHJldHVybiB2dGRfZGV2X2FzOw0KPj4gICB9DQo+Pg0KPj4gK3N0YXRp
YyBpbnQgdnRkX2Rldl9zZXRfaW9tbXVfZGV2aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUs
DQo+aW50MzJfdCBkZXZmbiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBJT01NVUZERGV2aWNlICppZGV2LCBFcnJvciAqKmVycnApDQo+PiArew0KPj4gKyAgICBJbnRl
bElPTU1VU3RhdGUgKnMgPSBvcGFxdWU7DQo+PiArICAgIFZURElPTU1VRkREZXZpY2UgKnZ0ZF9p
ZGV2Ow0KPj4gKyAgICBzdHJ1Y3QgdnRkX2FzX2tleSBrZXkgPSB7DQo+PiArICAgICAgICAuYnVz
ID0gYnVzLA0KPj4gKyAgICAgICAgLmRldmZuID0gZGV2Zm4sDQo+PiArICAgIH07DQo+PiArICAg
IHN0cnVjdCB2dGRfYXNfa2V5ICpuZXdfa2V5Ow0KPj4gKw0KPj4gKyAgICBhc3NlcnQoMCA8PSBk
ZXZmbiAmJiBkZXZmbiA8IFBDSV9ERVZGTl9NQVgpOw0KPg0KPkNhbiB3ZSBtb3ZlIHRoZSBhc3Nl
cnQgZWFybGllciBpbiB0aGUgY2FsbCBzdGFjayA/DQo+cGNpX2RldmljZV9nZXRfaW9tbXVfYnVz
X2RldmZuKCkgbG9va3MgbGlrZSBhIGdvb2QgcGxhY2UuDQoNClN1cmUuDQoNCj4NCj4+ICsNCj4+
ICsgICAgLyogTm9uZSBJT01NVUZEIGNhc2UgKi8NCj4+ICsgICAgaWYgKCFpZGV2KSB7DQo+PiAr
ICAgICAgICByZXR1cm4gMDsNCj4+ICsgICAgfQ0KPg0KPkNhbiB3ZSBtb3ZlIHRoaXMgdGVzdCBp
biB0aGUgaGVscGVyID8gKExvb2tzIGxpa2UgYW4gZXJyb3IgdG8gbWUpLg0KDQpXZSBuZWVkIHRv
IHBhc3MgaW4gTlVMTCBpZGV2IHRvIGRvIGZ1cnRoZXIgY2hlY2sgaW4gbmVzdGluZyBzZXJpZXMu
DQpTZWUgaHR0cHM6Ly9naXRodWIuY29tL3lpbGl1MTc2NS9xZW11L2NvbW1pdC83ZjBiYjU5NTc1
YmI1Y2YzODYxOGFlOTUwZjY4YTg2NjE2NzZlODgxDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

