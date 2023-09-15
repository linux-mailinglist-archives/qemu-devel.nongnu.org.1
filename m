Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A697A1F95
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 15:15:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh8eO-00040L-Md; Fri, 15 Sep 2023 09:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qh8eM-00040A-JT
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:14:22 -0400
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qh8eK-00051j-Df
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694783660; x=1726319660;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SINa+M6H0RblIWNEiRcqaYBMfIXBZptt8T5RcISFDJo=;
 b=jwPQlyNEc399wli4GpFXjK4GIniXVpPMtli5GrJ9/+th49yDD+EGQmbv
 77hOhNqlTQhj/5DloYItuFJMgIGmR5EIG6XwbUN9lr8mvG/QtSU53BvuE
 cGrOegsQbgmjdTfntvWgpWYeT8XPCVLMgmG7v72/S+rf7dcuPfO2jPxKi
 8N8H4CyqvL1Vw7Zwk+MSS9+ZViXEoSKTv5ryll3FiWWW0xawOHz/ZpIiQ
 oG0Ntu8bRnQbKe58zFTUne3ScZn5T2baMUzyV85TwRy5maB/TDyDewLSR
 IrirHy4y5PYCvwEuzwgEkU7EZEBGsk5uLLQ/+sNQl1OP6mA584ZYg8MMe Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="465607792"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; d="scan'208";a="465607792"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 06:14:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="774317493"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; d="scan'208";a="774317493"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Sep 2023 06:14:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 06:14:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 06:14:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 06:14:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXBzb/pzh2WX191HuRw2so7hjac5hqfQ7/2dgn9B52bPE5BrmeoPQ0+avL2xExtZkFnxdfWU05UEiS3N/M1MPjkQD53353S/QLvvi3QSmmtcelR3RuGQfxJkReKo5VBiIso7ZP1e0zjt5fEgwCQMaOXwLZIEXuLK3AYLOEYkT2pYmFYjCMGJmY/lCnWN2qUuPBgJtXnEglqAHBtIYuvU3s9MmwJogkAUkSOYRyjc6YBhZVnvYt6q1QBsVjtBNybVAK+iZQHrHz0K4c2lIk8+fxxT/Q+4/8uMoBfYKp5ZIZMJhZeHOx+flORok8rZhnmtJa2Pf0GcPlmY8IMmmqP8eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SINa+M6H0RblIWNEiRcqaYBMfIXBZptt8T5RcISFDJo=;
 b=NUu7yZpb09XzDbuXxM4s9sE2z3muT9I3RIdK/RY/R4/gpLA3+O+/Jr7YRTCSk1mVdC0KTOR1xgRJ53T8zclQeRMAlU48wfe3/zho5yriDn4xN4SNdwxEbElkNEdWhAxdC6I9tvpPBjCfqUO2wBVg8QHkKEuQB8h83OHATynJyrZuDFHYYZA1QAflyF6MmIerlg1VhvtG29mqzg+lqkqKPqkcqhvW/IAUmu7maKhfRrxMpV8WygfgP0yohDVipygMRQ2GLsuAJxIjaQiE1cVSWRJq5aWx3USvSJL1ZN7BszVVWB22SRfiMnB4xTxlxGb2OykQFDpcZdxFxdz7Yazb7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6931.namprd11.prod.outlook.com (2603:10b6:510:206::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 13:14:10 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::dcc5:b253:97d0:ff70]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::dcc5:b253:97d0:ff70%4]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 13:14:10 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 00/22] vfio: Adopt iommufd
Thread-Topic: [PATCH v1 00/22] vfio: Adopt iommufd
Thread-Index: AQHZ2zAWbRwNlGSkwk6jO8NZIq9umrAb7eMAgAAFkSA=
Date: Fri, 15 Sep 2023 13:14:09 +0000
Message-ID: <SJ0PR11MB6744DF8D38C6FE960E163F7792F6A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <62367cc3-20e9-f533-5f74-2dc3cba702ce@redhat.com>
In-Reply-To: <62367cc3-20e9-f533-5f74-2dc3cba702ce@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6931:EE_
x-ms-office365-filtering-correlation-id: bf30a1d1-be1c-419d-82e2-08dbb5eda603
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gsBAeSRGh1tZoIDC3h8aOMMg8i+OizxktmUApU8yWCy/E4sBJIZiPO2KOZNAV7tqgzjuFMoNjwZWMu7B54pP4d2HJ3izzzjmfP2ltwVOG3FuKDbAcyO4dxeCFu/x5FQWNjWGoUu8e8oaZTnZiq8u54UPGxMSO+16EWey6hshl09G5uUSS7R33kuT2//YgI9ym+5g0/UWhcIhCmKSo4gNqc4k7XJ9+ujXpZjx8HyPEEYPaI2XEJ+XmMCyhVyr/svP7N/cs8fNYcaCqo5i0bbviY0BJjwq9KMMMH+qpQJsjNyxxYQCMwDtvIP1yVLiVxNB9bVIqh6OGRydJpZP1whdKOVRxyYfbqtH6jiCerY3fHd33usUaVFhZGQtL5j9s+deANao1o5xkFQljzuLoH+rtMnApU0RUkg75IAOFZdE9TdH+c754q57ngjYkVBlFJOTHCyCYNsUG8Q65Jc5gzKlTHdMvWjnPesqG3GvDKWhVJDC9I5ANYVl9o3ITxdWa4gBBjVXfWcrkdtjmSncm3KsKzl05kJ4GtbP5zOHqovbMF9FeETPhJuqjU2zfWCGNbDBTuMWa18Th4/Og4QgOsuwXlph/OUwOIhAWBFhMKsuJHp3XKoC9e6CgrvHWwINh3Ue
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(1800799009)(451199024)(186009)(7696005)(71200400001)(6506007)(9686003)(478600001)(26005)(107886003)(66574015)(2906002)(66946007)(64756008)(66446008)(66476007)(66556008)(41300700001)(54906003)(76116006)(316002)(110136005)(5660300002)(52536014)(8936002)(8676002)(4326008)(86362001)(33656002)(55016003)(82960400001)(38100700002)(38070700005)(122000001)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmNaTjhCbW1ZL2FNZnhRNzdvM3NoUTVsTHVsMnh0RzJJZWQ4RDh5MER0ektp?=
 =?utf-8?B?ZCtLcTQvK0lRYUJPYVZuQ0E0NTZGbUlyRkk0enVYTWQyZm5CUVJyV1QvcVdo?=
 =?utf-8?B?N2FrRlc5SzYrZ29pOG4vancxWVFDU21TMHVNbUFvMDNtbUc2QTNWcmdXZk5F?=
 =?utf-8?B?WlpMZmRlb1JvbmQxWld3eTBlVDRjdkYwY1hUNVdZbTNvdTBucFgwQUI1RWRx?=
 =?utf-8?B?dGdsUDdBUTl2eFN4REgvK205L0NKMDJWNk9IcnJOTStoUlZhajgwTmtIUFBq?=
 =?utf-8?B?bDVST1YrSEptSkh2NGp2MzJSSWpKcFVnRG4wd3FXUEJCblUvOG43aUc1UFRV?=
 =?utf-8?B?NWhUdk5XSUpVVzgzRGd0RWFOejNjRFBTYTU4WDY3ZGszOTU4bTVkTHlUb2Jt?=
 =?utf-8?B?RHhIZDZiTTFoN1RyZGNDRTNSTzRQQW9hZHZyZXVSbjltSU1CenYvQ1h0TExU?=
 =?utf-8?B?aGdUd1NCNmg5MHFlRXpLVEZPWHA4cGR1WmV0NTRsZUVPTWJwQmZobzIzTlBn?=
 =?utf-8?B?SUNCNGVjMXdEM2FPamNESTZBdHBOY0xWZ3lHd1VzWTJVbEQwMUdialVsVWZF?=
 =?utf-8?B?MG1JL3NGUDl5dk1NWFg1djNnZGxOK0pDdGVmOHJ0d0x0MDhmODhxbFFNSyty?=
 =?utf-8?B?SHZOTjVSajJxSHZwZDFhRzZSRU8rSFdvU3JpL1BYZjFjbjFSSzRtalY3MzFm?=
 =?utf-8?B?ZFRWMU1xbEN3THdKampjOXlkZW1ic052WjIyWDRnTW5KWWM1cGdmRE1GZHZV?=
 =?utf-8?B?NTVZR25tdi96QS9uWHJ1VjV5WUFYY3VTd3BES21aeDIvY3dQTEFVMnBwQW1D?=
 =?utf-8?B?MVlBc0hNRFpMTVZSNTVESjFmdGFrQUN3RzBUemV0ZjA3UmV1QVdWNFVUTWtn?=
 =?utf-8?B?blFaN0pVQkR6T2N2WFVmVDJVMzZ0bHhkcXpiS2UwejFVa2tiRWgvbHRUK05H?=
 =?utf-8?B?SzZqLzhRSmROb0o5K1Z3T0RmdVFaY0g0MkNEVzBkY3plNEJLT2VFbkhWZFgy?=
 =?utf-8?B?T2t6VFAranI3MTg3c29EMXZWb0ZLYVQxMU9vcmRJeFZ6bjh5NW9IejZtRitz?=
 =?utf-8?B?MFBGbTZ6QTZmL29JSCtIU0VDN3BTdzVLdElFS1ZHRlhMc1c5TGgxbUhhZEdl?=
 =?utf-8?B?dlE1ajdDaGRtbmMrUG9iSThodm1NMzh1TVUweTZnSXFIUS95ejZvOC9zS0lF?=
 =?utf-8?B?VGdGN0VMZGlsR0xjMVJLYzB0bElTNThmSWU1d3hSaWVsUmJQRjZxUS9Wd2Fz?=
 =?utf-8?B?aGtQK25Ba1h1TkV3aERRRTNWa1FHdHJ2K1FNZWdYM1A2UStrZWN5eE5OYllF?=
 =?utf-8?B?ZXp5aUt5RGE2UGw4THNiR1AwdnI2eHhaS2VnaHZwRXZLazhPY0RKSG1nWTJL?=
 =?utf-8?B?dzFJaG9JTU8rell5NmFya3NUSVJCeGhzRUhFKzU0WGM5cGRDazMvR01sQmFG?=
 =?utf-8?B?MkFsT0s5WHRwRTZnRGJSVnV6SXVlQTh5bUpGcXM4bFN2OW1oOUZMVEZ3RDQr?=
 =?utf-8?B?amNGU2FUMnhKc2FmeUJ3K3NjelpaazZMbUlBRzVzMDh1QnVOem9WT0F0RG00?=
 =?utf-8?B?OWJvWXNaYUhmYlhMZUxFK0M2ejFpTkFSbldiQ2pVbGF4RVJ3WFJERDUyM0M2?=
 =?utf-8?B?amRWVFREYzlPbEgvVFZBbm5XUlM0YnQzOEpQaFFTa0JDa1NMUlloYUEzdzZB?=
 =?utf-8?B?S09nOE1OVEJ2b0djdFVOYU1PVmxIVHRHVnpUSW1qSnIyV2lzeDBZcFBTRUQ0?=
 =?utf-8?B?WXR0WEhXYmVOOVJSVkpGZzZuU0JzTW5EYmFqUk9MMWI4V280VkxPZU9tNXVo?=
 =?utf-8?B?U2RSTzhWQXRsYmhRVXpKWnMrMzE0VUQxRUFabUdjWDhXZS90Z1ZqYVN6bkdX?=
 =?utf-8?B?WVl6Z0FXeE1NbE9JazN1QmVsd1BlNW5uWVVycEQ5MEtkV1FXSmIrU0llckZR?=
 =?utf-8?B?WWNlSms2UGxpYW1URWt0a3MzN1YxZm9aTUhOWmRZZ3EzeitKU0RhVTZab0hz?=
 =?utf-8?B?Tm5iK3JVTlBrYU42N1pnc3czMjlxUlJjSGowMy9kWTkzTkUwMnc4S3pZamF5?=
 =?utf-8?B?elJhZE1rWitwSm9FcG9kUFY2TFc3dWtSVkhIS010VXJPV0UyOUo0TDhBdDRS?=
 =?utf-8?Q?nUAJ/ifqtUcRTyDdlT/fIhchX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf30a1d1-be1c-419d-82e2-08dbb5eda603
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 13:14:10.0109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5f8BjeeaZfJ4NQY3vo8yrzFLn0b18ZqyUOXPryHJbFCTcdUUNkdThqnFBBgE2ok9UYqhO3bVOV8XtP0UQf9926GDO0+abpfJQnrcL40nLpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6931
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.43;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIFNlcHRlbWJlciAxNSwgMjAyMyA4OjQz
IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MSAwMC8yMl0gdmZpbzogQWRvcHQgaW9tbXVmZA0K
Pg0KPk9uIDgvMzAvMjMgMTI6MzcsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gSGkgQWxsLA0K
Pj4NCj4+IEFzIHRoZSBrZXJuZWwgc2lkZSBpb21tdWZkIGNkZXYgYW5kIGhvdCByZXNldCBmZWF0
dXJlIGhhdmUgYmVlbiBxdWV1ZWQsDQo+PiBhbHNvIGh3cHQgYWxsb2MgaGFzIGJlZW4gYWRkZWQg
aW4gSmFzb24ncyBmb3JfbmV4dCBicmFuY2ggWzFdLCBJJ2QgbGlrZQ0KPj4gdG8gdXBkYXRlIGEg
bmV3IHZlcnNpb24gbWF0Y2hpbmcga2VybmVsIHNpZGUgdXBkYXRlIGFuZCB3aXRoIHJmYyBmbGFn
DQo+PiByZW1vdmVkLiBRZW11IGNvZGUgY2FuIGJlIGZvdW5kIGF0IFsyXSwgbG9vayBmb3J3YXJk
IG1vcmUgY29tbWVudHMhDQo+DQo+RllJLCBJIGhhdmUgc3RhcnRlZCBjbGVhbmluZyB1cCB0aGUg
VkZJTyBzdXBwb3J0IGluIFFFTVUgUFBDLiBGaXJzdA0KPmlzIHRoZSByZW1vdmFsIG9mIG52bGlu
azIsIHdoaWNoIHdhcyBkcm9wcGVkIGZyb20gdGhlIGtlcm5lbCAyLjUgeWVhcnMNCj5hZ28uIE5l
eHQgaXMgcHJvYmFibHkgcmVtb3ZhbCBvZiBhbGwgdGhlIFBQQyBiaXRzIGluIFZGSU8uIENvZGUg
aXMNCj5iaXRyb3R0aW5nIGFuZCBBRkFJQ1QgVkZJTyBoYXMgYmVlbiBicm9rZW4gb24gdGhlc2Ug
cGxhdGZvcm1zIHNpbmNlDQo+NS4xOCBvciBzby4NCj4NCj5UaGUgY29uc2VxdWVuY2VzIG9uIHRo
aXMgcGF0Y2hzZXQgc2hvdWxkIGJlIGxlc3MgbW92ZW1lbnQgb2YgY29kZQ0KPmJldHdlZW4gZmls
ZXMuIEkgdGhpbmsgdGhpcyBpcyBzb21ldGhpbmcgd2Ugc2hvdWxkIHJlZHVjZSB0byBtYWludGFp
bg0KPmhpc3RvcnkuDQoNCkdsYWQgdG8ga25vdyBJJ2xsIG9ubHkgbmVlZCB0byBtb3ZlIGxlc3Mg
Y29kZS4gSSdsbCByZWJhc2UgdGhpcyBwYXRjaHNldA0KYWZ0ZXIgeW91IGZpbmlzaC4NCg0KVGhh
bmtzDQpaaGVuemhvbmcNCg0K

