Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 477CA7E520D
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 09:39:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0e4S-00009U-Hj; Wed, 08 Nov 2023 03:37:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0e4Q-000099-5p
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 03:37:54 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0e4N-0004VZ-Vw
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 03:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699432672; x=1730968672;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mr09LpcERjs47XvA9mGUMTNntU0wlrLqfN2RFproQtY=;
 b=RhZNqdqQNkHv8KL1eX6VO5vl3TD8nBhxq+vuoMqjz2BI92UCAFS4YZL7
 a+O9IExsv45THVcXhfLTvecWEY+bFgOePp4B2YdSp1skxacYshc187r2K
 cjd5anmfMUogsVzIEL3UEd/TUockD5GNNAx9lhIptE6bkau257kBfJAc0
 hrzbisBv1aC4CU9AFf03Meq56FuOYs+7xcC3S29+1e+m+t6PPH7Z0onBm
 vDiDXhFL6E9iVQzFJGHAhvZVMbyze4fAZpl5I+P+tR9pMruyqu49+Uy9f
 a8zOAQhBEASdgKU/diB8eNHUW5bzD3GXJS/Ae07j4ldyYMErxCKFKxq7K w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2744825"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="2744825"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2023 00:37:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="4113217"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Nov 2023 00:37:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 00:37:47 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 00:37:47 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 00:37:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adoLHBQmgrW/OPoeYWzFt/MfQFatw/vi4vMzlAzyIqWDxYBUV1N3YJO0DpXU1wlfowB779mnl9MF6RQM0otmDF/IMH5u608/zoFePyIXZM1rFWsOIb43GcUmYp99zZFYOucpq+XuBnpgORrSCa/SmOeyNfFZ6gyYvTprt58qWOpfO7HUAB4zXDYvFeuwS26KoxXrQYBQLxQrMqn+fWvLDcbQP3WxOINo5I9WHDhETialmtzlglvSC0JEzfouZJ8/XSUlrJWht0oOmm/YGjLuwVePF+LfNgKBkCjirdzMEfmEmyXSQPGyCFdSctH4ViI1g9SPuKdstpsNhPKbGQ3WMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mr09LpcERjs47XvA9mGUMTNntU0wlrLqfN2RFproQtY=;
 b=PZtGXilnvtg6mhyk5bcpyLfhjlxbidhjvAiklK+nyZ6DSdd/qkhu68X2K0PW/QwbbOkGj8JC1CAnedrrxyZEUqlaqxnpCInt1L9kYlRan9vfx5s5A4LmHt77s7JRkU4RpCmTweGpJuuVp59b5vJ84FmGHbwp9EXVY/tJtu6Rm5SjVHEq0Mtb1lDCCdPfGB8lb9sUy/88uU9FzEnFi6HVhC6WiHREGbbVAG5tRvpZ0OeEroVIzWTKRZZIacl6732s+yBbz7dw+xYQBc9WYqwa8tHECus/sOSmLKkQSyDORyMjbZm9Pno9YXLqEcxcYJ+cFM7vuY9MfIn4au+sNgen2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB6123.namprd11.prod.outlook.com (2603:10b6:208:3ed::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Wed, 8 Nov
 2023 08:37:43 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 08:37:42 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Thomas Huth
 <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>
Subject: RE: [PATCH v4 00/41] vfio: Adopt iommufd
Thread-Topic: [PATCH v4 00/41] vfio: Adopt iommufd
Thread-Index: AQHaDV4v7k+KAYZ49k6QYTXZyZG4O7BvNckAgACWOICAAFWToA==
Date: Wed, 8 Nov 2023 08:37:42 +0000
Message-ID: <SJ0PR11MB67444527CF73955C131AABD892A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <d8f1ecdd-4ce8-4811-8efe-6607e71a9f98@redhat.com>
 <923acaad-4e52-442f-b688-277e87a48469@linux.ibm.com>
In-Reply-To: <923acaad-4e52-442f-b688-277e87a48469@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB6123:EE_
x-ms-office365-filtering-correlation-id: a2103b27-111e-4f51-3505-08dbe035f99f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D3HFVsdPcJtgkaAw45BViQnTlBCJlhhVQfHjpt/Zf8EUigprZW/HMvFDwpwiY8g/Qh0lTLGAJwRKdMa5QSNH0IC4kWJO5G7lr5WNlrAhQkxO8808LKnW/DPyNksBpxb0RqRFqM3mEaG6fEdlFU+fmNcKdDgQwLXJNNJaHOJP1wR25eLvHT2BPVlFIAk9CZ19+1Jm/EkQv5OMU40lBJCQsE74cMXgpzWAhbf88q0qDVwLPowKCj8l3XEXZJOI+ZgznoURvVpDzHS9j9mmAG0IlyRnv2aumJeBnCe3Q9KPCd8dPhzKzaNkyve4bvZAyR98U8mJprP8iw4XV8prenAATfwEkgwO2SjiGuaFCDuVynGzXp+OLB3rBMU4hwwVzWpMQ9aootYZy324z2NvdJo4EkJph8W4XsLRLXp8nGYqfBGOUiO4zihHb0NJ/lMlwSFc0aXJii/HRFh7hGqfy4zZDndKWByTGJfkL+3tQwkY0UIHp1xznuJnIe29b4Fipz4xxfQEuEvPGPuES+NMwbccg45GEJsbADNE3Z2WaDXCk5gu+IG86V28+Ud/OHmRHRlqWYZ94AE8D2mYaf/I368zraCXW2wBRDu+Twa3nAdM9JbIJYqY1iREPGxCp0U01VHG7JIK03ii28SIsjrmOyKq6Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(55016003)(38100700002)(71200400001)(7696005)(53546011)(83380400001)(6506007)(122000001)(9686003)(82960400001)(66574015)(26005)(86362001)(7416002)(2906002)(41300700001)(33656002)(8936002)(52536014)(4326008)(5660300002)(8676002)(54906003)(76116006)(66476007)(64756008)(66556008)(66446008)(316002)(66946007)(478600001)(110136005)(966005)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnFXZXV5OFVUNDJjRXl3ODhmZCsxN0RHTnA1Y1JQdFc4SVZtMk9mWlFCM05P?=
 =?utf-8?B?QkI1Si9ZT0x5M1FUd29jVGd2S3BYaUFyT1QzSHBhcHpOT1ppbzlndVZTU1M0?=
 =?utf-8?B?N3pvdHNBdVFpcVoxN3NzQWdvWG8rWENTaFhmVDl0b0o2S2hkaWI3Qm55dGlQ?=
 =?utf-8?B?RUx4S1hQSlA3M3krVjN6ZzFYU1FFMEx0ampUSUtNeWVFaHJvUXRuc1crQTdZ?=
 =?utf-8?B?R0lWQkk1ZHo2U3cxdnFhemh0cThPRmQrTTE0WTN3c0xyOVBEU0QyU2FVOGFr?=
 =?utf-8?B?STZhTFhjV3phUHRIN0o0TnhPWVYxa25NejFIWEthUU9XcjVIR2dPSW5oazZP?=
 =?utf-8?B?cXZKMjlRVUptZHZQSnNhUGx4Qm1SOHJrWFJlN1o2WUM2UUxseVZoQ1RLMXV1?=
 =?utf-8?B?d2ZwUWVqZVZQYXc3QnRjbTJxRlh6dThCU0NURGlYQXFrQnhZQzF4WUVnZWNq?=
 =?utf-8?B?aTlERXkySzR2WkxWZ0dqSjBUTHYvcTNNSS94R2xMQWwzOTRSd0VPYlc0b3Mw?=
 =?utf-8?B?N0dmMEZDaFhFN29lZEk2N0xxWFU3aGRTR3hWTVdQcHJWb0Y0S1hiWXdsaHpB?=
 =?utf-8?B?QXE5akRoZDV5a3MwUXBidTRDdFJhWXJUbTlEVlBUY2dIRXVOcjZ3dW9WQ28r?=
 =?utf-8?B?ZmNwcThqVHd6Q0xNWDNhQmtuYm05WGt0ZENQb0VQMld6UFJwTVMzYWVWU2hG?=
 =?utf-8?B?cXhFYndFSkhNNnB4N1ZsMndhYTBKSEVERGpCZDNKK0syZVJEbTVWNk91MmtC?=
 =?utf-8?B?ZXBpM1BMajV0b0FYMEtsTDdmbW51bFU2N3FKQld1NGF0dFp5c2pCMEFPVzhh?=
 =?utf-8?B?bG9pUFR1b25aa015S0RYTFVTTncrTWZWMEx2NFMzRnFqNjdERVZhcko0czFw?=
 =?utf-8?B?NFppY1R0MkpqN2MwbjBmemwveFFzMytYVmNzRGRyN0N0VlREME9HWTNqVCty?=
 =?utf-8?B?TU9ZTVljZHVFQkh2RTBKQk5LUEtObXIrdXZsVHRFNW1VbUs1cC9rd0Z4d3JJ?=
 =?utf-8?B?dTYwNFh6d0tDNkpJSUdTM0k5YW5Fd2JWcGlQVzFWSHBqT1Z5QXpQM0REY2tP?=
 =?utf-8?B?dDV5OGJHYzVlNUVKTGQzNU1JQi9lbUpLWFh3bk1wcGJFOEp2V3BGbDdXV1JG?=
 =?utf-8?B?bWxxQ0k4YWFHY3FyRURMdmFOSHlmMVdWOCtlUndZNVhpTmRZd3lVTGRMK2sr?=
 =?utf-8?B?R0s5QnlOeXJkQ3dFR2psQ3I2Qk1Gd2F2UFg4em4zV09Va05DYUVtMW1NWjhN?=
 =?utf-8?B?aXpnMERhM0phWVVITlY4bENwV0x0QmxweWhhclVWMUQ0Y3k3VklZUVdodFM2?=
 =?utf-8?B?ZjJIdnJLZlUwYnFUTXU1R2FkOGtLVlc2WEprc2pFcjFmcVpvK3UxbXdjMHd6?=
 =?utf-8?B?TGhCZ3EwWXo5MHgxL2xYeS9VcjJYNmZKRkw2dHFrQXVTQ2xJUkVGZ3Jsd2RU?=
 =?utf-8?B?c3ZkcUVCL0RYRFdyb0JoSzNpWU84bzA1ZjRkUlUrN0pubmMwMEZ3T2ZMdXkz?=
 =?utf-8?B?NEdHaDJJejAzSTE2QmpSdTZXL3JuWjlITDhwdFd5VExidHFINjlPbkFMSmdq?=
 =?utf-8?B?aHhYdGRXZlFHSnVxVVVZWHFTSkRIVGc2KzJqd05kUDhWVXRyenA3Mmw0YkxG?=
 =?utf-8?B?R3ltSGFaTGhzZCtaZjlwK3UydGV0SnJPZ0dZaDgvYzZES3pvUlNJQmJUcXJJ?=
 =?utf-8?B?Nk5qVXhwS1FWSkl6cGVxei81NVBBQ0tXM09kVm9xYjNsM1lEWmg4QTJickhT?=
 =?utf-8?B?Q3ZhNHFRNXIxNzRTK1dmSk9keTJUQ1ZId0czZytqbUdLeVBOMkp2dlhRRGxs?=
 =?utf-8?B?Z2dWVGt2KzB5RnIwVG1aalB0M053UDhQZVVwUStvc0MybWN5bkJMbjA3NHI3?=
 =?utf-8?B?bitCRXZhTU1PTDJQMW5rQXBJWC80cW5LVmpSd053UUk3bEdqbEYrcXdEMjhj?=
 =?utf-8?B?MFFTMnRJNGk4dS95QmFJQmkzM1VvVzJ6bUFJVTF4K3pXM2wrcFhscnVkOFBw?=
 =?utf-8?B?eXNYUDIrM2VnM2Fvb3VUVUdqWFdjMjBvM1JGQzVCY2ZUendTRHI2bEN4WU40?=
 =?utf-8?B?ay9XTUlaLzIycDhPVm1FNk0vcnJrMW15ZFhzdXg0VVhRT2s4ZGtCMTJ6WThG?=
 =?utf-8?B?K3FPNFpRRHFyTWpDeDFTem5nMjJINnM0Rm1FbGw3RWVLN09URlhHQjgwb2lO?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2103b27-111e-4f51-3505-08dbe035f99f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 08:37:42.8711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKqKUT+r1a282pcujhJmtYhvUHsklMA1Tn88/LmteVNlD/lJGJCxvH/VfZU9A97rN6BEtLuLsAl5WsUrZaTZyS4e72IZN+q4vFHXyumHmlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6123
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1hdHRoZXcgUm9zYXRvIDxt
anJvc2F0b0BsaW51eC5pYm0uY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgOCwgMjAy
MyAxMToyNyBBTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDAvNDFdIHZmaW86IEFkb3B0IGlv
bW11ZmQNCj4NCj5PbiAxMS83LzIzIDE6MjggUE0sIEPDqWRyaWMgTGUgR29hdGVyIHdyb3RlOg0K
Pj4gT24gMTEvMi8yMyAwODoxMiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4gSGksDQo+Pj4N
Cj4+PiBUaGFua3MgYWxsIGZvciBnaXZpbmcgZ3VpZGVzIGFuZCBjb21tZW50cyBvbiBwcmV2aW91
cyBzZXJpZXMsIGhlcmUgaXMNCj4+PiB0aGUgdjQgb2YgcHVyZSBpb21tdWZkIHN1cHBvcnQgcGFy
dC4NCj4+Pg0KPj4+IEJhc2VkIG9uIEPDqWRyaWMncyBzdWdnZXN0aW9uLCB0aGlzIHNlcmllcyBp
bmNsdWRlcyBhbiBlZmZvcnQgdG8gcmVtb3ZlDQo+Pj4gc3BhcHIgY29kZSBmcm9tIGNvbnRhaW5l
ci5jLCBub3cgYWxsIHNwYXByIGZ1bmN0aW9ucyBhcmUgbW92ZWQgdG8gc3BhcHIuYw0KPj4+IG9y
IHNwYXByX3BjaV92ZmlvLmMsIGJ1dCB0aGVyZSBhcmUgc3RpbGwgYSBmZXcgdHJpdmFsIGNoZWNr
IG9uDQo+Pj4gVkZJT19TUEFQUl9UQ0VfKl9JT01NVSB3aGljaCBJIGFtIG5vdCBzdXJlIGlmIGRl
c2VydmVkIHRvIGludHJvZHVjZQ0KPm1hbnkNCj4+PiBjYWxsYmFja3MgYW5kIGR1cGxpY2F0ZSBj
b2RlIGp1c3QgdG8gcmVtb3ZlIHRoZW0uIFNvbWUgZnVuY3Rpb25zIGFyZSBtb3ZlZA0KPj4+IHRv
IHNwYXByLmMgaW5zdGVhZCBvZiBzcGFwcl9wY2lfdmZpby5jIHRvIGF2b2lkIGNvbXBpbGUgaXNz
dWUgYmVjYXVzZQ0KPj4+IHNwYXByX3BjaV92ZmlvLmMgaXMgYXJjaCBzcGVjaWZpYywgb3IgZWxz
ZSB3ZSBuZWVkIHRvIGludHJvZHVjZSBzdHViDQo+Pj4gZnVuY3Rpb25zIHRvIHRob3NlIHNwYXBy
IGZ1bmN0aW9ucyBtb3ZlZC4NCj4+Pg0KPj4+DQo+Pj4gUEFUQ0ggMS01OiBNb3ZlIHNwYXByIGZ1
bmN0aW9ucyB0byBzcGFwciouYw0KPj4+IFBBVENIIDYtMjA6IEFic3RyYWN0IG91dCBiYXNlIGNv
bnRhaW5lcg0KPj4+IFBBVENIIDIxLTI0OiBJbnRyb2R1Y2Ugc3BhcnByIGNvbnRhaW5lciBhbmQg
aXRzIHNwZWNpZmljIGludGVyZmFjZQ0KPj4NCj4+IFBBVENIIDYtMjQgYXBwbGllZCB0byB2Zmlv
LW5leHQgOg0KPj4NCj4+IMKgIGh0dHBzOi8vZ2l0aHViLmNvbS9sZWdvYXRlci9xZW11L2NvbW1p
dHMvdmZpby1uZXh0DQo+Pg0KPj4gKHdpdGggYSBnbG9iYWwgcy9mdWNudGlvbmFsL2Z1bmN0aW9u
YWwvKQ0KPj4NCj4+DQo+PiBJIGFsc28gcHVzaGVkIHRoZSByZW1haW5pbmcgcGF0Y2hlcyBvbiA6
DQo+Pg0KPj4gwqAgaHR0cHM6Ly9naXRodWIuY29tL2xlZ29hdGVyL3FlbXUvY29tbWl0cy92Zmlv
LTguMg0KPj4NCj4+IHdpdGggYSBzbGlnaHQgcmV3b3JrIG9mIHRoZSBJT01NVUZEIGNvbmZpZ3Vy
YXRpb24sIG5vdyBkb25lIHBlciBwbGF0Zm9ybS4NCj4+IFRoZSBWRklPIGZyb250ZW5kIGFuZCB0
aGUgJ2lvbW11ZmQnIG9iamVjdCBhcmUgb25seSBhdmFpbGFibGUgb24geDg2XzY0LA0KPj4gYXJt
LCBzMzkweC4NCg0KVGhhbmtzIEPDqWRyaWMuDQoNCj4NCj5GWUksIEkgZmlyc3QgdHJpZWQgdGhp
cyB2ZmlvLTguMiBicmFuY2ggb24gczM5MHggYnV0IHdhc24ndCBhY3R1YWxseSBhYmxlIHRvIHVz
ZSB0aGUNCj5pb21tdWZkIGJhY2tlbmQgKHdhcyBnZXR0aW5nIGVycm9ycyBsaWtlIFByb3BlcnR5
ICd2ZmlvLXBjaS5pb21tdWZkJyBub3QgZm91bmQpDQo+c28gSSB0aGluayBzb21ldGhpbmcgaXNu
J3QgYWN0dWFsbHkgZW5hYmxpbmcgSU9NTVVGRCBhcyBleHBlY3RlZCB3aXRoIHlvdXINCj5jaGFu
Z2UuLi4NCg0KSXQgbG9va3MgQ09ORklHX0lPTU1VRkQgaXMgcmVjb2duaXplZCBieSBLY29uZmln
IHN1Yi1zeXN0ZW0gYnV0IG5vdCByZWNlaXZlZA0KYnkgY29tcGlsZXIuIEknbSBzdGlsbCBkaWdn
aW5nIGhvdyB0byBwYXNzIENPTkZJR19JT01NVUZEIHRvIGNvbXBpbGVyLg0KDQo+DQo+SW5zdGVh
ZCBJIHRlc3RlZCBvbiBzMzkweCB1c2luZyB2ZmlvLW5leHQgKyBwYXRjaGVzIDI1LTQxIG9mIHRo
aXMgc2VyaWVzIG9uIHRvcC4NCj4NCj5MZWdhY3kgYmFja2VuZCByZWdyZXNzaW9uIHRlc3Rpbmcg
d29ya2VkIGZpbmUgZm9yIHZmaW8tcGNpLCB2ZmlvLWFwIGFuZCB2ZmlvLWNjdy4NCj4NCj5Vc2lu
ZyBpb21tdWZkIGJhY2tlbmQgZm9yIHZmaW8tcGNpIG9uIHMzOTAgZXhwb3NlcyBhbiBzMzkwLW9u
bHkgaXNzdWUgcmVsYXRlZA0KPnRvIGFjY291bnRpbmcgb2YgdmZpbyBETUEgbGltaXQgKGNvZGUg
aW4gaHcvczM5MHgvczM5MC1wY2ktdmZpby5jIGFzc3VtZXMNCj5WRklPRGV2aWNlLmdyb3VwIGlz
IG5ldmVyIG51bGwsIGJ1dCB0aGF0J3Mgbm8gbG9uZ2VyIHRydWUgd2hlbiB3ZSB1c2UgdGhlDQo+
aW9tbXVmZCBiYWNrZW5kIHdpdGggY2RldikuICBXZSBkb24ndCBldmVuIG5lZWQgdG8gdHJhY2sg
dGhpcyB3aGVuIHVzaW5nIHRoZQ0KPmlvbW11ZmQgYmFja2VuZCAtLSBXaXRoIHRoYXQgaXNzdWUg
YnlwYXNzZWQsIHZmaW8tcGNpIHRlc3Rpbmcgb24gczM5MHggbG9va3MNCj5nb29kIHNvIGZhci4g
IEknbGwgc2VuZCBhIHNlcGFyYXRlIGZpeCBmb3IgdGhhdC4NCg0KVGhhbmtzIGZvciBmaXhpbmcg
dGhhdC4NCg0KQlJzLg0KWmhlbnpob25nDQoNCj4NCj5Vc2luZyB0aGUgaW9tbXVmZCBiYWNrZW5k
IGZvciB2ZmlvLWNjdyBhbmQgdmZpby1hcCBkaWQgbm90IHdvcmssIHNlZSByZXNwb25zZQ0KPnRv
IHBhdGNoIDI4Lg0KPg0KPlRoYW5rcywNCj5NYXR0DQoNCg==

