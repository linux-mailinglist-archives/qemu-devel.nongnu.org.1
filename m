Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5B9710AE9
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 13:30:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q29AB-00038o-G2; Thu, 25 May 2023 07:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q29A9-00038L-7W
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:29:45 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q29A6-0001EI-LX
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685014182; x=1716550182;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=arEg72tTa0cfwGTuF9E8X6A3IF7fukrPnbH/V8VM7Mo=;
 b=mXeOjNaaUhLVuOu+hQaHu5XPLMj37S9LRKeaGISlvVRFxe6p8dPmxu6+
 LOE3JUJWG6Ri8zWt5mv4Up3Kcyx8pM2M2m7spkvmwNTxCfC7ZK8nAUq6N
 LqocZ08BtzAm+QPcAkHbqj+WVR3wRnouAM8Cj2tXMBgngS9MjR3idy5g/
 WQ2G+mJfbSC6SLqUixmh0W/XUg21k/M/SzuIb+IHQNwOYdgwwGZLDCAny
 t29IorMbUraj5DcUDWH5TtjsQIasWYTRGSV9bxwDSD4ndVR50qR43Pae5
 kTxU/+4jh+OKlpbI8p/G+sfDkcM5QTkSJ+6EYaDECgGeoQw+wZtJuUFCH g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="351369462"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; d="scan'208";a="351369462"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2023 04:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="817047130"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; d="scan'208";a="817047130"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga002.fm.intel.com with ESMTP; 25 May 2023 04:29:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 04:29:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 04:29:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 25 May 2023 04:29:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 25 May 2023 04:29:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guL9fESe+bDr/GEtlD7n4IDUWq0b3vE04X9OP/5j8NgSslaEQLxqEUYy/Tqic7j9emqAvqT/vWPlgV9Jlpnlw+PnB33Uo4lj8iMX36wQB+sv7pKqw6+ja0f9OzakeHvmRQ1n11NKM0slDKiqlN1IvqFILUywkpuHRh0b0XwEFrPWkVoLJdfXX0h+UFDayVrgCOhJFoQGeLL6siIK3Vkxe8liSBdSCqvFyOEwGbXcPHwEGCvP/toGZbWraHcm9izq3bJWO+cMqyViSHaaKl9sZqf4dicFZMk6a5aVbwbPD2dSPAAa9LlTkYwvvWSGfeY2CM47vCmWXRIEhVXtZnf3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arEg72tTa0cfwGTuF9E8X6A3IF7fukrPnbH/V8VM7Mo=;
 b=a7IFNbiqrRPHz5QFiX7v1YYd4zUm7ISkshHyvoOZnwDFbRfIcoHtOAb/ZOwWBfPThVb25JdpEJIXODROByHinO0ZUfAVUpzlww4U4cGpwOglVQMKcQ16n2RQctdeOmu8nIBbL2f0tQUVJCxMEx9A+J0NTbCdpWsguz/T8BwupenslwX0pM6aTys3fVQmWLuMgG852m0Z1CL6QvzpqcYEyNg7PM3Q3bH+BnWytVnVsaGc17n5EQ6UeCeUrD6RDYQaSyHtPyJ33j6fshsgzmlh7qXA4TC6haSvAU1ZW8fqnDG3vOlVDXeUt0vZxqGhZd8gEjYF5FClJcOQYEhFCXKHWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA3PR11MB8002.namprd11.prod.outlook.com (2603:10b6:806:2f6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 11:29:35 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%7]) with mapi id 15.20.6433.017; Thu, 25 May 2023
 11:29:35 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Neo Jia <cjia@nvidia.com>, "Alex
 Williamson" <alex.williamson@redhat.com>
Subject: RE: [PATCH] intel_iommu: Optimize out some unnecessary UNMAP calls
Thread-Topic: [PATCH] intel_iommu: Optimize out some unnecessary UNMAP calls
Thread-Index: AQHZjU9UUNDgMVPBGUm9r6viRHCOR69pp1qAgAERSyA=
Date: Thu, 25 May 2023 11:29:34 +0000
Message-ID: <SJ0PR11MB67447A3D47F6226F58DB813492469@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230523080702.179363-1-zhenzhong.duan@intel.com>
 <ZG5CPws85lIvpT07@x1n>
In-Reply-To: <ZG5CPws85lIvpT07@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA3PR11MB8002:EE_
x-ms-office365-filtering-correlation-id: 861709a8-8693-42d0-8691-08db5d1350bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zDZ0A34Rv198vg8eEu536JeGymgcOrEi+VAhfubYIQTmCYqvld5erqRyA1XA+bXzzYlig8tEqFlUV7dkDIgmtb4/WgkNMHjh0jQqlvRVCi3OPFs3yHdQdM+NCCwvpyxzljzgRIoAvfrdSiUKCwqgXlmx3BpKUpaXmNYyV5YrOcXovIytTyzqnnWvvZY1ra96g3SwW2+wF4GAvQqUUjoSrx9RbANa+EJ0NqwSzwR9Xzz+sG6EwbgFJR/5JsViPX4awFsbEeBRrksYgtWYEI7E07dgLvsHb8A7n2sIY32KFOv4yTrROaNKCg7GRKQwF93aOffkaXVrPIBwHoSq+2+M23dqHPv6F0dekCaarVq6PxWeYDY9D21Bm3E+ErmCap58RvmHeBhDclHVpOylUixNS0oAnqKCd/WbLXfV85dbytBAIV0km2L+V1y46s3cFN8fvuXlfEQbWzEZZfdtsFV/yYpP4mihBP3JqME3OK7c2k11Wx5axWt0kr+kyJ8J/ggWnypGcALK1n6WLgDlR6ObYk0z2PH369dv//8UADiRjXn6kWRZvMxhbmKlziWwdG/6INQ+2xKeBEbwRQe1guf7PLs91o2FP5/Bky6btA/M/AcHyC1h+JE+QUn768+7qtzm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199021)(2906002)(83380400001)(186003)(38070700005)(33656002)(86362001)(38100700002)(82960400001)(122000001)(55016003)(5660300002)(8936002)(8676002)(41300700001)(7696005)(7416002)(54906003)(478600001)(52536014)(66556008)(6916009)(316002)(66476007)(71200400001)(4326008)(64756008)(66446008)(76116006)(66946007)(26005)(6506007)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3RhcEhETm1ucHhUeXBqVVRDdzdSUTZiVWxIZTlNUlllTEFKYzhHaktDdTlu?=
 =?utf-8?B?Z0pVam9VZy9ObEpkOGFpeUFGbnhqMzRHSGxrM0lVc2tZUzNGY0FOME5JR2Vk?=
 =?utf-8?B?VTI5aXg0VHE2TXVUT2ZFdkw1MnNUdFF3WGF4MGpPZ09UM0JwYTFtSjVRNVJY?=
 =?utf-8?B?cWJ5bkVXbFc0ODkzdlhUc2E5NEdURDdWVjNydWwvRHpsY0VVcWJLVW1rR3pP?=
 =?utf-8?B?MEFWS1p6WkVUWVFVRW01Mmp3Q0ZWeEQrT0hPdC9LSFZpUTNOMU9xeGdZb2tN?=
 =?utf-8?B?NlMxeDdTYWJ3bjVMZmhiUlhqV3pGc0h4T0FLaTBCYWsra2ZibzdLaXRFVytY?=
 =?utf-8?B?QXlWTVp5RlRWWDZxOVFKU1lMWXV1bjVaTjR6ZnFaY3F1N08rRWFPRlkyY1lF?=
 =?utf-8?B?UGpXZno5TDlza05Qek9jWk1vbnNibzVMc2VtVjdBTGRpcFJNdVM4U3VkM2Nv?=
 =?utf-8?B?cEhaaEpyNDFYdWlFREdabjYwMTBGbGlJbjcxdFQwU1NjWmNXTnNmeHd6ZzBM?=
 =?utf-8?B?elFVV0JJdzF2UFlDanpaTit3bU0xcitDZy95bG5oZXhLNWVJcVVLZVdpZ3lD?=
 =?utf-8?B?b0hvU2F6UFV1ZkUwVHJIR2lPL3RmOFZ1TUxMbFJubWQrZHF1YWRxWjVrU3ZQ?=
 =?utf-8?B?ZFExSWVCWlB0d01aMnpVRXJLS28yaXFFem9DaGRBS1lVeUFqM1F0Q2NucUFy?=
 =?utf-8?B?RVlnL3RhM1AzOTQwZXVvN1dXaXNjaW81S3hqWFhvdkxTbUdQYnR3ejEzU0Za?=
 =?utf-8?B?eGNVYU16VVV6R3NYbDFyaDBBNzNkY1JEM2s3VlBvV2k3Qm5hdTIwTGZpTkV3?=
 =?utf-8?B?RTZ6aUxuS0djeWtIek1zVHhNc1NaWjAwUFJoWk4xaGw5SUFFNXZBZG4xQzg2?=
 =?utf-8?B?YVpmaXVUanpyNHVZYUNLSjJyQjRoMU1aYWlralB3cjVRdHNPaTE5NGt4Smxv?=
 =?utf-8?B?a2ZFOEU2TitMRVNoNERscWNUOU9FSlAyNVFGZ09NYVA5VCtMd2pCS1hLdFNX?=
 =?utf-8?B?Z0htSDN6WWh3MFRlZVIrOW9GTVFTRkhsTUl3Ykx5SDhYMjMrNU9RRDBXNFRP?=
 =?utf-8?B?b3dVQ1hiZHAyRkVwRE1QYlI0TkJNYmxtSW5hWVJyM3JyY3pDY21pYmZFc3hn?=
 =?utf-8?B?aUVWa3BZSlRmcm1Wb2dlMkF5ZmRRZlRkSllmZjl2L09CbU5XTGI3SzVCZk1H?=
 =?utf-8?B?U0cwOUk5b2h1bHhMekZNRVVDTXRYL1NUTjlIRTlzYTVuRDFCSHBSSVR3T3BP?=
 =?utf-8?B?TWlFUmlqZ2JjcFRvY0RheTFkcitiNGZGV0kxTkp0SjlPdVBxRDk0Vkp0d3JS?=
 =?utf-8?B?VzQvdmJ6UFFmS05SamdDbnkvbjVMZzlnNGNVZ0ZVdUptckRlVFlFdTFOSnEy?=
 =?utf-8?B?MG5UVXl3YmlESElUbDF4WWxnRVk2SGJKSjErK0hGbC9xWVcwSkgxamRzdm4v?=
 =?utf-8?B?ckl4OTE5eGwrZEYwYUZRWGZ2ZlBtSnZ1SnQrY2ZmYUo1aldJQXpXWjZvek9F?=
 =?utf-8?B?U3VuNW1YT3djT2dLRFBWbmRyWmxhUHU0Q0djZHd0Sk1tUElodWtsQzFvYnZC?=
 =?utf-8?B?TGZhZkF0ODFvRkF1MnR0SUFmcVhHY1h5c1d5aEg2UkhlM2kydTl2WGdzaExv?=
 =?utf-8?B?VDNaMzdiaytmZzVsZDFrWkVmVk41THpYQnZQaTd5ajl2ZFI3U1FaemdqcmJi?=
 =?utf-8?B?ZE1OZEZUSDlTa2VmL1JmeUhLMSs1RGg5VDcra05iOFZubzhWL0FDSDAxY1Jj?=
 =?utf-8?B?WnpSMXI0dE90RjhDMzMyQjVINFkxZnlrU3loU2ZZd0VZbjZvSWpsZ2dYS21r?=
 =?utf-8?B?cUQ0bUNNeHdlTVNyMDEvbDBoMitOZ3gwR3FUelVmczJNNGpXcEgrWjhuY0ZL?=
 =?utf-8?B?aFlOUXZPeVl6RWN0Zm1kdWlPOTIyVjU2UTVQeFI2UGhwRUJWcGhiRjNEaUJX?=
 =?utf-8?B?QjM1dmRpTEFka3BUZ25EWkZCT3Z2QUxxOVJTUlZKRHpiOE5NQ3EyalhQUkRG?=
 =?utf-8?B?NUgwQ3RBYjkzdWozUytwKzk0ZGtxbCtWNTYyWEdvUHh5MU5LaUxDUitCc0JV?=
 =?utf-8?B?VzN5bVdtbllvUWxiUGVCYVAwYldwYXZ1TjJzYmVPOVhkYmF4Z1JwT01uWENz?=
 =?utf-8?Q?fWbd+CACbGsWWitM9bEe9eJ5x?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861709a8-8693-42d0-8691-08db5d1350bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 11:29:34.3000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qp1yKV5vzyvo4JXZIaTdAVwu7VRTbZKWvLxOPj62bOAZno2xP/AycQlp1Ps/ZIUamxx7PHJn/Ul1erjeSPgyCHooxUruguHOL4GQwLuOsIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8002
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=zhenzhong.duan@intel.com; helo=mga11.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgUGV0ZXIsDQoNClNlZSBpbmxpbmUuDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5G
cm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+U2VudDogVGh1cnNkYXksIE1heSAy
NSwgMjAyMyAxMjo1OSBBTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGludGVsX2lvbW11OiBPcHRp
bWl6ZSBvdXQgc29tZSB1bm5lY2Vzc2FyeSBVTk1BUA0KPmNhbGxzDQo+DQo+SGksIFpoZW56aG9u
ZywNCj4NCj5PbiBUdWUsIE1heSAyMywgMjAyMyBhdCAwNDowNzowMlBNICswODAwLCBaaGVuemhv
bmcgRHVhbiB3cm90ZToNCj4+IENvbW1pdCA2M2I4ODk2OGYxICgiaW50ZWwtaW9tbXU6IHJld29y
ayB0aGUgcGFnZSB3YWxrIGxvZ2ljIikgYWRkcw0KPj4gbG9naWMgdG8gcmVjb3JkIG1hcHBlZCBJ
T1ZBIHJhbmdlcyBzbyB3ZSBvbmx5IG5lZWQgdG8gc2VuZCBNQVAgb3INCj4+IFVOTUFQIHdoZW4g
bmVjZXNzYXJ5LiBCdXQgdGhlcmUgYXJlIHN0aWxsIGEgZmV3IGNvcm5lciBjYXNlcyBvZg0KPnVu
bmVjZXNzYXJ5IFVOTUFQLg0KPj4NCj4+IE9uZSBpcyBhZGRyZXNzIHNwYWNlIHN3aXRjaC4gRHVy
aW5nIHN3aXRjaGluZyB0byBpb21tdSBhZGRyZXNzIHNwYWNlLA0KPj4gYWxsIHRoZSBvcmlnaW5h
bCBtYXBwaW5ncyBoYXZlIGJlZW4gZHJvcHBlZCBieSBWRklPIG1lbW9yeSBsaXN0ZW5lciwNCj4+
IHdlIGRvbid0IG5lZWQgdG8gdW5tYXAgYWdhaW4gaW4gcmVwbGF5LiBUaGUgb3RoZXIgaXMgaW52
YWxpZGF0aW9uLCB3ZQ0KPj4gb25seSBuZWVkIHRvIHVubWFwIHdoZW4gdGhlcmUgYXJlIHJlY29y
ZGVkIG1hcHBlZCBJT1ZBIHJhbmdlcywNCj4+IHByZXN1bWluZyBtb3N0IG9mIE9TZXMgYWxsb2Nh
dGluZyBJT1ZBIHJhbmdlIGNvbnRpbnVvdXNseSwgZXguIG9uIHg4NiwNCj4+IGxpbnV4IHNldHMg
dXAgbWFwcGluZyBmcm9tIDB4ZmZmZmZmZmYgZG93bndhcmRzLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+
IFRlc3RlZCBvbiB4ODYgd2l0aCBhIG5ldCBjYXJkIHBhc3NlZCBvciBob3RwbHVnZWQgdG8ga3Zt
IGd1ZXN0LA0KPj4gcGluZy9zc2ggcGFzcy4NCj4NCj5TaW5jZSB0aGlzIGlzIGEgcGVyZm9ybWFu
Y2UgcmVsYXRlZCBwYXRjaCwgZG8geW91IGhhdmUgYW55IG51bWJlciB0byBzaG93DQo+dGhlIGVm
ZmVjdD8NCg0KSSBzdHJhY2VkIHRoZSB0aW1lIG9mIFVOTUFQIGlvY3RsLCBpdHMgdGltZSBpcyAw
LjAwMDAxNHVzIGFuZCB3ZSBoYXZlIDI4IGlvY3RsKCkgZHVlIHRvDQp0aGUgdHdvIG5vdGlmaWVy
cyBpbiB4ODYgYXJlIHNwbGl0IGludG8gcG93ZXIgb2YgMiBwaWVjZXMuDQoNCmlvY3RsKDQ4LCBW
RklPX0RFVklDRV9RVUVSWV9HRlhfUExBTkUgb3IgVkZJT19JT01NVV9VTk1BUF9ETUEsIDB4N2Zm
ZmZkNWM0MmYwKSA9IDAgPDAuMDAwMDE0Pg0KDQo+DQo+Pg0KPj4gIGh3L2kzODYvaW50ZWxfaW9t
bXUuYyB8IDMxICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hh
bmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBpbmRleA0K
Pj4gOTRkNTJmNDIwNWQyLi42YWZkNjQyOGFhYWEgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTM3NDMs
NiArMzc0Myw3IEBAIHN0YXRpYyB2b2lkDQo+dnRkX2FkZHJlc3Nfc3BhY2VfdW5tYXAoVlREQWRk
cmVzc1NwYWNlICphcywgSU9NTVVOb3RpZmllciAqbikNCj4+ICAgICAgaHdhZGRyIHN0YXJ0ID0g
bi0+c3RhcnQ7DQo+PiAgICAgIGh3YWRkciBlbmQgPSBuLT5lbmQ7DQo+PiAgICAgIEludGVsSU9N
TVVTdGF0ZSAqcyA9IGFzLT5pb21tdV9zdGF0ZTsNCj4+ICsgICAgSU9NTVVUTEJFdmVudCBldmVu
dDsNCj4+ICAgICAgRE1BTWFwIG1hcDsNCj4+DQo+PiAgICAgIC8qDQo+PiBAQCAtMzc2MiwyMiAr
Mzc2MywyNSBAQCBzdGF0aWMgdm9pZA0KPnZ0ZF9hZGRyZXNzX3NwYWNlX3VubWFwKFZUREFkZHJl
c3NTcGFjZSAqYXMsIElPTU1VTm90aWZpZXIgKm4pDQo+PiAgICAgIGFzc2VydChzdGFydCA8PSBl
bmQpOw0KPj4gICAgICBzaXplID0gcmVtYWluID0gZW5kIC0gc3RhcnQgKyAxOw0KPj4NCj4+ICsg
ICAgZXZlbnQudHlwZSA9IElPTU1VX05PVElGSUVSX1VOTUFQOw0KPj4gKyAgICBldmVudC5lbnRy
eS50YXJnZXRfYXMgPSAmYWRkcmVzc19zcGFjZV9tZW1vcnk7DQo+PiArICAgIGV2ZW50LmVudHJ5
LnBlcm0gPSBJT01NVV9OT05FOw0KPj4gKyAgICAvKiBUaGlzIGZpZWxkIGlzIG1lYW5pbmdsZXNz
IGZvciB1bm1hcCAqLw0KPj4gKyAgICBldmVudC5lbnRyeS50cmFuc2xhdGVkX2FkZHIgPSAwOw0K
Pj4gKw0KPj4gICAgICB3aGlsZSAocmVtYWluID49IFZURF9QQUdFX1NJWkUpIHsNCj4+IC0gICAg
ICAgIElPTU1VVExCRXZlbnQgZXZlbnQ7DQo+PiAgICAgICAgICB1aW50NjRfdCBtYXNrID0gZG1h
X2FsaWduZWRfcG93Ml9tYXNrKHN0YXJ0LCBlbmQsIHMtPmF3X2JpdHMpOw0KPj4gICAgICAgICAg
dWludDY0X3Qgc2l6ZSA9IG1hc2sgKyAxOw0KPj4NCj4+ICAgICAgICAgIGFzc2VydChzaXplKTsN
Cj4+DQo+PiAtICAgICAgICBldmVudC50eXBlID0gSU9NTVVfTk9USUZJRVJfVU5NQVA7DQo+PiAt
ICAgICAgICBldmVudC5lbnRyeS5pb3ZhID0gc3RhcnQ7DQo+PiAtICAgICAgICBldmVudC5lbnRy
eS5hZGRyX21hc2sgPSBtYXNrOw0KPj4gLSAgICAgICAgZXZlbnQuZW50cnkudGFyZ2V0X2FzID0g
JmFkZHJlc3Nfc3BhY2VfbWVtb3J5Ow0KPj4gLSAgICAgICAgZXZlbnQuZW50cnkucGVybSA9IElP
TU1VX05PTkU7DQo+PiAtICAgICAgICAvKiBUaGlzIGZpZWxkIGlzIG1lYW5pbmdsZXNzIGZvciB1
bm1hcCAqLw0KPj4gLSAgICAgICAgZXZlbnQuZW50cnkudHJhbnNsYXRlZF9hZGRyID0gMDsNCj4+
IC0NCj4+IC0gICAgICAgIG1lbW9yeV9yZWdpb25fbm90aWZ5X2lvbW11X29uZShuLCAmZXZlbnQp
Ow0KPj4gKyAgICAgICAgbWFwLmlvdmEgPSBzdGFydDsNCj4+ICsgICAgICAgIG1hcC5zaXplID0g
c2l6ZTsNCj4+ICsgICAgICAgIGlmIChpb3ZhX3RyZWVfZmluZChhcy0+aW92YV90cmVlLCAmbWFw
KSkgew0KPj4gKyAgICAgICAgICAgIGV2ZW50LmVudHJ5LmlvdmEgPSBzdGFydDsNCj4+ICsgICAg
ICAgICAgICBldmVudC5lbnRyeS5hZGRyX21hc2sgPSBtYXNrOw0KPj4gKyAgICAgICAgICAgIG1l
bW9yeV9yZWdpb25fbm90aWZ5X2lvbW11X29uZShuLCAmZXZlbnQpOw0KPj4gKyAgICAgICAgfQ0K
Pg0KPlRoaXMgb25lIGxvb2tzIGZpbmUgdG8gbWUsIGJ1dCBJJ20gbm90IHN1cmUgaG93IG11Y2gg
YmVuZWZpdCB3ZSdsbCBnZXQgaGVyZQ0KPmVpdGhlciBhcyB0aGlzIHBhdGggc2hvdWxkIGJlIHJh
cmUgYWZhaXUuDQoNClllcywgSSBvbmx5IHNlZSBzdWNoIFVOTUFQIGNhbGwgYXQgY29sZCBib290
dXAvc2h1dGRvd24sIGhvdCBwbHVnIGFuZCB1bnBsdWcuDQoNCkluIGZhY3QsIHRoZSBvdGhlciBw
dXJwb3NlIG9mIHRoaXMgcGF0Y2ggaXMgdG8gZWxpbWluYXRlIG5vaXN5IGVycm9yIGxvZyB3aGVu
DQp3ZSB3b3JrIHdpdGggSU9NTVVGRC4gSXQgbG9va3MgdGhlIGR1cGxpY2F0ZSBVTk1BUCBjYWxs
IHdpbGwgZmFpbCB3aXRoIElPTU1VRkQNCndoaWxlIGFsd2F5cyBzdWNjZWVkIHdpdGggbGVnYWN5
IGNvbnRhaW5lci4gVGhpcyBiZWhhdmlvciBkaWZmZXJlbmNlIGxlYWQgdG8gYmVsb3cNCmVycm9y
IGxvZyBmb3IgSU9NTVVGRDoNCg0KSU9NTVVfSU9BU19VTk1BUCBmYWlsZWQ6IE5vIHN1Y2ggZmls
ZSBvciBkaXJlY3RvcnkNCnZmaW9fY29udGFpbmVyX2RtYV91bm1hcCgweDU2MjAxMmQ2YjZkMCwg
MHgwLCAweDgwMDAwMDAwKSA9IC0yIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQ0KSU9NTVVf
SU9BU19VTk1BUCBmYWlsZWQ6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCnZmaW9fY29udGFp
bmVyX2RtYV91bm1hcCgweDU2MjAxMmQ2YjZkMCwgMHg4MDAwMDAwMCwgMHg0MDAwMDAwMCkgPSAt
MiAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkNCg0KPg0KPj4NCj4+ICAgICAgICAgIHN0YXJ0
ICs9IHNpemU7DQo+PiAgICAgICAgICByZW1haW4gLT0gc2l6ZTsNCj4+IEBAIC0zODI2LDEzICsz
ODMwLDYgQEAgc3RhdGljIHZvaWQNCj52dGRfaW9tbXVfcmVwbGF5KElPTU1VTWVtb3J5UmVnaW9u
ICppb21tdV9tciwgSU9NTVVOb3RpZmllciAqbikNCj4+ICAgICAgdWludDhfdCBidXNfbiA9IHBj
aV9idXNfbnVtKHZ0ZF9hcy0+YnVzKTsNCj4+ICAgICAgVlREQ29udGV4dEVudHJ5IGNlOw0KPj4N
Cj4+IC0gICAgLyoNCj4+IC0gICAgICogVGhlIHJlcGxheSBjYW4gYmUgdHJpZ2dlcmVkIGJ5IGVp
dGhlciBhIGludmFsaWRhdGlvbiBvciBhIG5ld2x5DQo+PiAtICAgICAqIGNyZWF0ZWQgZW50cnku
IE5vIG1hdHRlciB3aGF0LCB3ZSByZWxlYXNlIGV4aXN0aW5nIG1hcHBpbmdzDQo+PiAtICAgICAq
IChpdCBtZWFucyBmbHVzaGluZyBjYWNoZXMgZm9yIFVOTUFQLW9ubHkgcmVnaXN0ZXJzKS4NCj4+
IC0gICAgICovDQo+PiAtICAgIHZ0ZF9hZGRyZXNzX3NwYWNlX3VubWFwKHZ0ZF9hcywgbik7DQo+
DQo+SUlVQyB0aGlzIGlzIG5lZWRlZCB0byBzYXRpc2Z5IGN1cnJlbnQgcmVwbGF5KCkgc2VtYW50
aWNzOg0KPg0KPiAgICAvKioNCj4gICAgICogQHJlcGxheToNCj4gICAgICoNCj4gICAgICogQ2Fs
bGVkIHRvIGhhbmRsZSBtZW1vcnlfcmVnaW9uX2lvbW11X3JlcGxheSgpLg0KPiAgICAgKg0KPiAg
ICAgKiBUaGUgZGVmYXVsdCBpbXBsZW1lbnRhdGlvbiBvZiBtZW1vcnlfcmVnaW9uX2lvbW11X3Jl
cGxheSgpIGlzIHRvDQo+ICAgICAqIGNhbGwgdGhlIElPTU1VIHRyYW5zbGF0ZSBtZXRob2QgZm9y
IGV2ZXJ5IHBhZ2UgaW4gdGhlIGFkZHJlc3Mgc3BhY2UNCj4gICAgICogd2l0aCBmbGFnID09IElP
TU1VX05PTkUgYW5kIHRoZW4gY2FsbCB0aGUgbm90aWZpZXIgaWYgdHJhbnNsYXRlDQo+ICAgICAq
IHJldHVybnMgYSB2YWxpZCBtYXBwaW5nLiBJZiB0aGlzIG1ldGhvZCBpcyBpbXBsZW1lbnRlZCB0
aGVuIGl0DQo+ICAgICAqIG92ZXJyaWRlcyB0aGUgZGVmYXVsdCBiZWhhdmlvdXIsIGFuZCBtdXN0
IHByb3ZpZGUgdGhlIGZ1bGwgc2VtYW50aWNzDQo+ICAgICAqIG9mIG1lbW9yeV9yZWdpb25faW9t
bXVfcmVwbGF5KCksIGJ5IGNhbGxpbmcgQG5vdGlmaWVyIGZvciBldmVyeQ0KPiAgICAgKiB0cmFu
c2xhdGlvbiBwcmVzZW50IGluIHRoZSBJT01NVS4NCkFib3ZlIHNlbWFudGljcyBjbGFpbXMgY2Fs
bGluZyBAbm90aWZpZXIgZm9yIGV2ZXJ5IHRyYW5zbGF0aW9uIHByZXNlbnQgaW4gdGhlIElPTU1V
DQpCdXQgaXQgZG9lc24ndCBjbGFpbSBpZiBjYWxsaW5nIEBub3RpZmllciBmb3Igbm9uLXByZXNl
bnQgdHJhbnNsYXRpb24uDQpJIGNoZWNrZWQgb3RoZXIgY3VzdG9tIHJlcGxheSgpIGNhbGxiYWNr
LCBleC4gdmlydGlvX2lvbW11X3JlcGxheSgpLCBzcGFwcl90Y2VfcmVwbGF5KCkNCml0IGxvb2tz
IG9ubHkgaW50ZWxfaW9tbXUgaXMgc3BlY2lhbCBieSBjYWxsaW5nIHVubWFwX2FsbCgpIGJlZm9y
ZSByZWJ1aWxkIG1hcHBpbmcuDQoNCj4NCj5UaGUgcHJvYmxlbSBpcyB2dGRfcGFnZV93YWxrKCkg
Y3VycmVudGx5IGJ5IGRlZmF1bHQgb25seSBub3RpZmllcyBvbiBwYWdlDQo+Y2hhbmdlcywgc28g
d2UnbGwgbm90aWZ5IGFsbCBNQVAgb25seSBpZiB3ZSB1bm1hcCBhbGwgb2YgdGhlbSBmaXJzdC4N
CkhtbSwgSSBkaWRuJ3QgZ2V0IHRoaXMgcG9pbnQuIENoZWNrZWQgdnRkX3BhZ2Vfd2Fsa19vbmUo
KSwgaXQgd2lsbCByZWJ1aWxkIHRoZQ0KbWFwcGluZyBleGNlcHQgdGhlIERNQU1hcCBpcyBleGFj
dGx5IHNhbWUgd2hpY2ggaXQgd2lsbCBza2lwLiBTZWUgYmVsb3c6DQoNCiAgICAvKiBVcGRhdGUg
bG9jYWwgSU9WQSBtYXBwZWQgcmFuZ2VzICovDQogICAgaWYgKGV2ZW50LT50eXBlID09IElPTU1V
X05PVElGSUVSX01BUCkgew0KICAgICAgICBpZiAobWFwcGVkKSB7DQogICAgICAgICAgICAvKiBJ
ZiBpdCdzIGV4YWN0bHkgdGhlIHNhbWUgdHJhbnNsYXRpb24sIHNraXAgKi8NCiAgICAgICAgICAg
IGlmICghbWVtY21wKG1hcHBlZCwgJnRhcmdldCwgc2l6ZW9mKHRhcmdldCkpKSB7DQogICAgICAg
ICAgICAgICAgdHJhY2VfdnRkX3BhZ2Vfd2Fsa19vbmVfc2tpcF9tYXAoZW50cnktPmlvdmEsIGVu
dHJ5LT5hZGRyX21hc2ssDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZW50cnktPnRyYW5zbGF0ZWRfYWRkcik7DQogICAgICAgICAgICAgICAgcmV0dXJu
IDA7DQogICAgICAgICAgICB9IGVsc2Ugew0KICAgICAgICAgICAgICAgIC8qDQogICAgICAgICAg
ICAgICAgICogVHJhbnNsYXRpb24gY2hhbmdlZC4gIE5vcm1hbGx5IHRoaXMgc2hvdWxkIG5vdA0K
ICAgICAgICAgICAgICAgICAqIGhhcHBlbiwgYnV0IGl0IGNhbiBoYXBwZW4gd2hlbiB3aXRoIGJ1
Z2d5IGd1ZXN0DQoNCj4NCj5JIGFzc3VtZWQgaXQgd2FzIG5vdCBhIG1ham9yIGlzc3VlIHdpdGgv
d2l0aG91dCBpdCBiZWZvcmUgYmVjYXVzZSBwcmV2aW91c2x5DQo+QUZBSVUgdGhlIG1ham9yIHBh
dGggdG8gdHJpZ2dlciB0aGlzIGlzIHdoZW4gc29tZW9uZSBob3QgcGx1ZyBhIHZmaW8tcGNpIGlu
dG8NCj5hbiBleGlzdGluZyBndWVzdCBJT01NVSBkb21haW4sIHNvIHRoZSB1bm1hcF9hbGwoKSBp
cyBpbmRlZWQgbm8tb3AuDQpZZXMsIHNhbWUgZm9yIGNvbGQgcGx1Zy4NCg0KPkhvd2V2ZXIgZnJv
bSBzZW1hbnRpY3MgbGV2ZWwgaXQgc2VlbXMgdW5tYXBfYWxsKCkgaXMgc3RpbGwgbmVlZGVkLg0K
Pg0KPlRoZSBvdGhlciB0aGluZyBpcyB3aGVuIEkgYW0gbG9va2luZyBhdCB0aGUgbmV3IGNvZGUg
SSBmb3VuZCB0aGF0IHdlIGFjdHVhbGx5DQo+ZXh0ZW5kZWQgdGhlIHJlcGxheSgpIHRvIGJlIHVz
ZWQgYWxzbyBpbiBkaXJ0eSB0cmFja2luZyBvZiB2ZmlvLCBpbg0KPnZmaW9fc3luY19kaXJ0eV9i
aXRtYXAoKS4gIEZvciB0aGF0IG1heWJlIGl0J3MgYWxyZWFkeSBicm9rZW4gaWYNCj51bm1hcF9h
bGwoKSBiZWNhdXNlIGFmYWl1IGxvZ19zeW5jKCkgY2FuIGJlIGNhbGxlZCBpbiBtaWdyYXRpb24g
dGhyZWFkDQo+YW55dGltZSBkdXJpbmcgRE1BIHNvIEkgdGhpbmsgaXQgbWVhbnMgdGhlIGRldmlj
ZSBpcyBwcm9uZSB0byBETUEgd2l0aCB0aGUNCj5JT01NVSBwZ3RhYmxlIHF1aWNrbHkgZXJhc2Vk
IGFuZCByZWJ1aWx0IGhlcmUsIHdoaWNoIG1lYW5zIHRoZSBETUEgY291bGQNCj5mYWlsIHVuZXhw
ZWN0ZWRseS4gIENvcHkgQWxleCwgS2lydGkgYW5kIE5lby4NCkdvb2QgY2F0Y2gsIGluZGVlZC4N
Cg0KVGhhbmtzDQpaaGVuemhvbmcNCj4NCj5QZXJoYXBzIHRvIGZpeCBpdCB3ZSdsbCBuZWVkIHRv
IHRlYWNoIHRoZSB2dGQgcGd0YWJsZSB3YWxrZXIgdG8gbm90aWZ5IGFsbCBleGlzdGluZw0KPk1B
UCBldmVudHMgd2l0aG91dCB0b3VjaGluZyB0aGUgSU9WQSB0cmVlIGF0IGFsbC4NCj4NCj4+IC0N
Cj4+ICAgICAgaWYgKHZ0ZF9kZXZfdG9fY29udGV4dF9lbnRyeShzLCBidXNfbiwgdnRkX2FzLT5k
ZXZmbiwgJmNlKSA9PSAwKSB7DQo+PiAgICAgICAgICB0cmFjZV92dGRfcmVwbGF5X2NlX3ZhbGlk
KHMtPnJvb3Rfc2NhbGFibGUgPyAic2NhbGFibGUgbW9kZSIgOg0KPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAibGVnYWN5IG1vZGUiLA0KPj4gLS0NCj4+IDIuMzQuMQ0KPj4N
Cj4NCj4tLQ0KPlBldGVyIFh1DQo=

