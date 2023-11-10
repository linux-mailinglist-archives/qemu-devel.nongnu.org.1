Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6E37E7B5B
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 11:20:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Obc-0002UI-KC; Fri, 10 Nov 2023 05:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r1Oba-0002U9-Ly
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 05:19:14 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r1ObX-0007Q6-NX
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 05:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699611551; x=1731147551;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+vtxSLeO907jayYCweTkkPfkL+ILxgas/JoBD52dqUI=;
 b=NLpYwLjFH2x32oYZYdJrmuyUNsHT+uV3NYFrM3rfdLEiPRz5v+HOBrd6
 tpUJPSUu0DVLdM/r3N6wUeQJr41fUwriJlcR8crPvSdxWodDDPvanmycr
 ae5Ntni+OpstESVXFcNcuLLUgkwu1tdm427BDz6gKxmd+jAMUNfwV7O0A
 b01zVOtDyc3hligThaN0KVRF4yFVLkq18bXSxh/28uDk3DptpZ7e3CtwP
 bBWkPG5JkHicDSGMynKWk07A0tiTM92jnIDqb8nxYC5hChRq5E/c1jVUm
 w6+ax2ucZEljoIJkWbRD+QZ3yLuEmKaGR2HcO8VzBRw3VemeYm1f0xM9c A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="380555193"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; d="scan'208";a="380555193"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2023 02:19:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="1095156620"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; d="scan'208";a="1095156620"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Nov 2023 02:19:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 02:19:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 10 Nov 2023 02:19:07 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 10 Nov 2023 02:19:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g438fJSXdbHIxuTTZEN/ogDLavHEwf6WYBV84MdxLRC9b9M54c0yfm6eUQk9EQ+m7eU//yg/XUMZghB9SO0r3mxU+74TgSh3hwHv+0srBYkp6jyHmYv0flmpVQfx13CAF6DoKflg0rwB1b1Od9R1KJJtTZGl52tEv1/DPlTkZSIDSw8mNiY7oXnWpOnWwxSTaa8tka6PsDr7L1UKyNbpggjlUsVOL6ZrHsslHtE1a78Tl60lCkaSDr3Ur3c2XWXfTcN4Hjw+2+Nb3mTwAFLP7LHRklbAa9vvuVhpx4dmZJ81YsYNrenFhBowgT/HXyGg1nd94e3+Usq8InoXAQZ48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vtxSLeO907jayYCweTkkPfkL+ILxgas/JoBD52dqUI=;
 b=KMXx7lV/ltnPzerJ/uIqeImrOyZHhzEYFKcwoQ8Q37bTGlJmmBccVbbrelDwoUvQhT13YMUQeIbMl02Nk3LVROKzx6SHT2IqfbiCqJy/ziZHAFh8aw3IgwAZbHaAJOtsnDFVf3OobZa1R29+iWrPkWE5KQK4zXKYtQjAZfwN5h2dXoswThGrESCuJUdbjVi+5ypKCO8ZpOHiknkMx8nPzACwEUo6+MbxfClXIcNlTx3tMn1VZ/3rrI20LEiR+muYE4oU6ZWMQ/JlgGMPSEgAfC+INkX4MsGcm1/tbauwHLzFdQ6nZJrsMi52BFL3MQ9USVk/KF8RR7Zmm+naylmwmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS7PR11MB6040.namprd11.prod.outlook.com (2603:10b6:8:77::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Fri, 10 Nov 2023 10:18:59 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 10:18:59 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 03/20] vfio/iommufd: Implement the iommufd backend
Thread-Topic: [PATCH v5 03/20] vfio/iommufd: Implement the iommufd backend
Thread-Index: AQHaEwR42BCiZCWwBkSSnflOiOwKYLBzTB+AgAAIQ+A=
Date: Fri, 10 Nov 2023 10:18:59 +0000
Message-ID: <SJ0PR11MB67443A3F92285FD074493FFA92AEA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
 <20231109114529.1904193-4-zhenzhong.duan@intel.com>
 <befa083f-2e1b-4895-97cc-f00cfe5fc9a2@redhat.com>
In-Reply-To: <befa083f-2e1b-4895-97cc-f00cfe5fc9a2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS7PR11MB6040:EE_
x-ms-office365-filtering-correlation-id: deebbbd4-d890-4e48-6ebb-08dbe1d67460
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s6q14+FrcuNRFTfjasVgW4Qx3j5RiU4AhC02jwd88Fo88j1EritVFIWGnOuUoyxBO9CqnHRztfDfkER0W8iFvuqcNupj6Lg9pyVz7wc7sIA1MZ/eLyDWHrGVvAtynCwcVLwn7EDUqfSJqJ/f0t/3f2HnbRkeLG/5ZRqSf+mc+uHR14RU1waKVNzEU8xLhU6HyjAz4gl7g+bbQ/injIXdQu7S/hPFMUCCejdXZEQ91yZE/D7UttvgTUHlLCRFfwQLDwjOJROV/lgncPu9qYgAaYxs0A58r3Kq5D9L0mRTSEEr24sz93tkZOqatRY2XO2BqUvMfBY/X+pyGQtngFFGZ+l834Xf5gXa7FskTfiJ125rHF/EkRNb3ojJ9YZryHDJH//rnn9tRjlVfkJgHG5riGJrQR/RVNWP/AA/x+8pg3+wLJTmd4IBjBdJe/M4fUmWbepup46wSngOonk5zJlHA3xaokhm6LeYlDX8M/WmAMO4sARQAMbazbqzP533fl7xo3F5P+qNAjNqmUxi6fB8jcUTYHy2900eizw95MTypC7s0s6YTfNY2OxshKsOPuJX8onGp6Ir0q+THsWmZTVFxfP9EshkrjsziVuVcALI0eh15iXkbvmzM1a5+/Bq/pnu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(26005)(316002)(64756008)(66946007)(54906003)(66556008)(66446008)(110136005)(66476007)(9686003)(6506007)(71200400001)(66574015)(38070700009)(122000001)(38100700002)(33656002)(83380400001)(82960400001)(86362001)(107886003)(7696005)(8936002)(478600001)(5660300002)(41300700001)(8676002)(52536014)(2906002)(4326008)(76116006)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUxodmx0K2Q2T0hoZkRvREtRaVN2N0tYZStVc0Z1RFEzWTdqTGV2b3ZaK09J?=
 =?utf-8?B?WjdCRmV2OXVnTHpudy9qVjd5LzNNTW96VDluamtFUXJZYXl1akhoZ1RzbVhO?=
 =?utf-8?B?S20rN3QwL3FHUlk1THJuS255ZzIwTFV4ZGl1NFdOZ0daL0o0d1pjVCthUjJB?=
 =?utf-8?B?dnBvQzFKT2twNFA4MGdHTXRnejV2TlZaZXRkc2lXV0lqNmVld0xZZW5iNzFT?=
 =?utf-8?B?akE3SEJPZmZqeUR6SWhtQnVaaWhoWU0rc0daMDd1ZjE1bEZBUG5ydlZMSHJm?=
 =?utf-8?B?RHg5c1FEN0hQRXkvMWU0T3duSDBTaHRJWHBCd01oTXd2RjFyQ2MrWGVPK05k?=
 =?utf-8?B?WVh0eHFrKzQ1cVMrUHBldEZpQ1V6eVVmdWpvWDREMXdNY1NtR1lockhkaHlw?=
 =?utf-8?B?S1JNclNZbW45LzNqaFN4N09QSkV5SXBGcVNRVFk3T2x2VmNNWHNEdjhGVWhB?=
 =?utf-8?B?Y0RsUGowUU1oLzdhSGVxUG0rdW5Tdi9rRjVwZExTUnRVS09UanFzaVRibFp3?=
 =?utf-8?B?Z2MvTFBxVG9ocEpQRVNtMG5MNm9sa1gxVXpiTHF2MDFNeThDWjZqekhDZHFN?=
 =?utf-8?B?YWhzdmRucm9NUlY1WEN0bWFIWG53T2Y1RllrdEVJdlFkNm1kODM3b1hpMUtQ?=
 =?utf-8?B?blRucU1ZUll1ekJ0TXVER2xFaVlpS1dJcjhXcmI2ZWEvNS9JdEdvRHpkU05p?=
 =?utf-8?B?ZnBtUFN2ekVTYjBLUkxPUFNNeXdHd1IrU214WkNxblpkMDFydHNKU0NaQ09S?=
 =?utf-8?B?RVlxZUlEOWVrVTFaYVdLbExZYlNCa1V1NTdVcHd1RHY0aFRVR2tKRnFpTnpQ?=
 =?utf-8?B?OS9ZbjAyb29uVko4azhtNTNFa2hHTythUHNpRGFQN3hxYlVSc0U3V3hDOXFt?=
 =?utf-8?B?amhycHRKZ0tpSEpoQzBxWTU4UmtRcXBiTFdxWjg3emsveFZCb0RsU29wSEVF?=
 =?utf-8?B?ZE12eWxLL2FFRmtxVHVzdnVqMmcrSUt5bVphaDU3b0lrVFlkY3p6aXJnTUQz?=
 =?utf-8?B?TDExODEzUG8xaGFBSTNYWnVVMk5LWmppVzVmcHJUN1NQNEwvbWFYcE56RUMr?=
 =?utf-8?B?aE81TlF4VDlCTC8rMVpCS3UxejdnRVMrR0lXUy91RmtFblpkMFFIYUYzcHdu?=
 =?utf-8?B?RzhpcEZKQU5iZTFJaGd6VzJuODBpc0xmSDA2YkN0SjVCKzVnY1RUVVhVQkhK?=
 =?utf-8?B?Nnl2b3prTDFlc0VxNFZJaWV6QjEwRytlOTQvUFFtdHdUYlNoaDM2YzV0UHdO?=
 =?utf-8?B?a1ZRVHprQURub3FvUEd3SkNoSzlmRURZSk5QaUFlenkrTzRDSlA2UkNWRkdl?=
 =?utf-8?B?Zkd4bi9KSFlwQUppcmN1ajhhcFBwOWxEM280V2xNajQ3QnNMck9IL3FJVERG?=
 =?utf-8?B?bDA5YTRVblp6MVhBV3poM0FBYWp5bThKQ0Z2MTVLdk5vV2RhT3J0VTN0MUhi?=
 =?utf-8?B?ODV4UDVsQkNNNW82d3F6TnZPdHdYQWVMZHVXM1FDa1dlOUcrM2pzcEZ2UTNw?=
 =?utf-8?B?eFJTeDY2NUp2d2txaE1icVB3ZXhjZ3oxUW8rNGxHUHVLblV6MC9vU1IvV0RK?=
 =?utf-8?B?d05QQWpMbHZPM0gwTnFTL3RQc2pycnFnb0NnQkRnZStOc25Lc0h3SzVqaWk4?=
 =?utf-8?B?YVpLR2xpcFNkVkF6SGxMMWVvM0wzNGNEVUxkMjhVVXRhWFdXYWxKQkdyTkJZ?=
 =?utf-8?B?ajF4T1JMZ0o3dEJvQ3BDM08vSmdVaTFwdnhvdTV3c2trUE5xdytNYld0TDJo?=
 =?utf-8?B?RS9say8rL1J1MktEblVKVExiNE0rdTJTTEJhOUdjbnN2WHBSNThsNmlxaXNX?=
 =?utf-8?B?OWFTaEk4cXhDN1ROTjRKY01iSWVNMUNjbFdjaWZtTTZjUVJWa1RCK1JGRnJG?=
 =?utf-8?B?S3JZLzV4VDlmTXkrOE9MNGNWNXlzTjErLzNkcXhlNUlxU2JJckNYUC9iUlEr?=
 =?utf-8?B?eUg4elY5WVd6SjFiYkN0emszYVlSL0p2Q21KdEFhdSt2ckhMSkFQeWF4Nmp2?=
 =?utf-8?B?UENXVVY1K2tuS2JlaGV1RERRTEREc2NYemU1S0FOM25OcncvWWZhMjBzN1hU?=
 =?utf-8?B?dDd1SWdGdGNYY25tQ2FWZ2xEN1NTdUdLbjR0MUNibWhMQ3ZqMEZ6bnE2Mjh2?=
 =?utf-8?Q?oLDsfH5xzXdzkN1G2uQWa+Flv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deebbbd4-d890-4e48-6ebb-08dbe1d67460
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 10:18:59.4499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzWKH6Oh8PN+gatoorjMJEHIEvR/+vpcs/pnJpeDx70x1M+Kwhh3Fq5//vu5GIYsLjl6u9eijbUGt/RK/VAD//z4y0L6tsB2frGhcoYNriE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6040
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIE5vdmVtYmVyIDEwLCAyMDIzIDU6MzQg
UE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY1IDAzLzIwXSB2ZmlvL2lvbW11ZmQ6IEltcGxlbWVu
dCB0aGUgaW9tbXVmZCBiYWNrZW5kDQo+DQo+T24gMTEvOS8yMyAxMjo0NSwgWmhlbnpob25nIER1
YW4gd3JvdGU6DQo+PiBGcm9tOiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+DQo+PiBB
ZGQgdGhlIGlvbW11ZmQgYmFja2VuZC4gVGhlIElPTU1VRkQgY29udGFpbmVyIGNsYXNzIGlzIGlt
cGxlbWVudGVkDQo+PiBiYXNlZCBvbiB0aGUgbmV3IC9kZXYvaW9tbXUgdXNlciBBUEkuIFRoaXMg
YmFja2VuZCBvYnZpb3VzbHkgZGVwZW5kcw0KPj4gb24gQ09ORklHX0lPTU1VRkQuDQo+Pg0KPj4g
U28gZmFyLCB0aGUgaW9tbXVmZCBiYWNrZW5kIGRvZXNuJ3Qgc3VwcG9ydCBkaXJ0eSBwYWdlIHN5
bmMgeWV0IGR1ZQ0KPj4gdG8gbWlzc2luZyBzdXBwb3J0IGluIHRoZSBob3N0IGtlcm5lbC4NCj4+
DQo+PiBDby1hdXRob3JlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0K
Pj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0t
DQo+PiB2NTogU3dpdGNoIHRvIElPQVMgYXR0YWNoL2RldGFjaCBhbmQgaGlkZSBod3B0DQo+Pg0K
Pj4gICBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCB8ICAxMSArDQo+PiAgIGh3L3ZmaW8v
Y29tbW9uLmMgICAgICAgICAgICAgIHwgIDIwICstDQo+PiAgIGh3L3ZmaW8vaW9tbXVmZC5jICAg
ICAgICAgICAgIHwgNDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAg
aHcvdmZpby9tZXNvbi5idWlsZCAgICAgICAgICAgfCAgIDMgKw0KPj4gICBody92ZmlvL3RyYWNl
LWV2ZW50cyAgICAgICAgICB8ICAxMCArDQo+PiAgIDUgZmlsZXMgY2hhbmdlZCwgNDY5IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody92Zmlv
L2lvbW11ZmQuYw0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21t
b24uaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+PiBpbmRleCAyNGVjYzBlN2Vl
Li4zZGFjNWMxNjdlIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9u
LmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+PiBAQCAtODksNiAr
ODksMTQgQEAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0hvc3RETUFXaW5kb3cgew0KPj4gICAgICAgUUxJ
U1RfRU5UUlkoVkZJT0hvc3RETUFXaW5kb3cpIGhvc3R3aW5fbmV4dDsNCj4+ICAgfSBWRklPSG9z
dERNQVdpbmRvdzsNCj4+DQo+PiArdHlwZWRlZiBzdHJ1Y3QgSU9NTVVGREJhY2tlbmQgSU9NTVVG
REJhY2tlbmQ7DQo+PiArDQo+PiArdHlwZWRlZiBzdHJ1Y3QgVkZJT0lPTU1VRkRDb250YWluZXIg
ew0KPj4gKyAgICBWRklPQ29udGFpbmVyQmFzZSBiY29udGFpbmVyOw0KPj4gKyAgICBJT01NVUZE
QmFja2VuZCAqYmU7DQo+PiArICAgIHVpbnQzMl90IGlvYXNfaWQ7DQo+PiArfSBWRklPSU9NTVVG
RENvbnRhaW5lcjsNCj4+ICsNCj4+ICAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0RldmljZU9wcyBWRklP
RGV2aWNlT3BzOw0KPj4NCj4+ICAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0RldmljZSB7DQo+PiBAQCAt
MTE2LDYgKzEyNCw4IEBAIHR5cGVkZWYgc3RydWN0IFZGSU9EZXZpY2Ugew0KPj4gICAgICAgT25P
ZmZBdXRvIHByZV9jb3B5X2RpcnR5X3BhZ2VfdHJhY2tpbmc7DQo+PiAgICAgICBib29sIGRpcnR5
X3BhZ2VzX3N1cHBvcnRlZDsNCj4+ICAgICAgIGJvb2wgZGlydHlfdHJhY2tpbmc7DQo+PiArICAg
IGludCBkZXZpZDsNCj4+ICsgICAgSU9NTVVGREJhY2tlbmQgKmlvbW11ZmQ7DQo+PiAgIH0gVkZJ
T0RldmljZTsNCj4+DQo+PiAgIHN0cnVjdCBWRklPRGV2aWNlT3BzIHsNCj4+IEBAIC0yMDEsNiAr
MjExLDcgQEAgdHlwZWRlZiBRTElTVF9IRUFEKFZGSU9EZXZpY2VMaXN0LCBWRklPRGV2aWNlKQ0K
PlZGSU9EZXZpY2VMaXN0Ow0KPj4gICBleHRlcm4gVkZJT0dyb3VwTGlzdCB2ZmlvX2dyb3VwX2xp
c3Q7DQo+PiAgIGV4dGVybiBWRklPRGV2aWNlTGlzdCB2ZmlvX2RldmljZV9saXN0Ow0KPj4gICBl
eHRlcm4gY29uc3QgVkZJT0lPTU1VT3BzIHZmaW9fbGVnYWN5X29wczsNCj4+ICtleHRlcm4gY29u
c3QgVkZJT0lPTU1VT3BzIHZmaW9faW9tbXVmZF9vcHM7DQo+PiAgIGV4dGVybiBjb25zdCBNZW1v
cnlMaXN0ZW5lciB2ZmlvX21lbW9yeV9saXN0ZW5lcjsNCj4+ICAgZXh0ZXJuIGludCB2ZmlvX2t2
bV9kZXZpY2VfZmQ7DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vY29tbW9uLmMgYi9ody92
ZmlvL2NvbW1vbi5jDQo+PiBpbmRleCA1NzJhZTdjOTM0Li4zYjdlMTExNThmIDEwMDY0NA0KPj4g
LS0tIGEvaHcvdmZpby9jb21tb24uYw0KPj4gKysrIGIvaHcvdmZpby9jb21tb24uYw0KPj4gQEAg
LTE5LDYgKzE5LDcgQEANCj4+ICAgICovDQo+Pg0KPj4gICAjaW5jbHVkZSAicWVtdS9vc2RlcC5o
Ig0KPj4gKyNpbmNsdWRlIENPTkZJR19ERVZJQ0VTIC8qIENPTkZJR19JT01NVUZEICovDQo+PiAg
ICNpbmNsdWRlIDxzeXMvaW9jdGwuaD4NCj4+ICAgI2lmZGVmIENPTkZJR19LVk0NCj4+ICAgI2lu
Y2x1ZGUgPGxpbnV4L2t2bS5oPg0KPj4gQEAgLTE0NjIsMTAgKzE0NjMsMTMgQEAgVkZJT0FkZHJl
c3NTcGFjZQ0KPip2ZmlvX2dldF9hZGRyZXNzX3NwYWNlKEFkZHJlc3NTcGFjZSAqYXMpDQo+Pg0K
Pj4gICB2b2lkIHZmaW9fcHV0X2FkZHJlc3Nfc3BhY2UoVkZJT0FkZHJlc3NTcGFjZSAqc3BhY2Up
DQo+PiAgIHsNCj4+IC0gICAgaWYgKFFMSVNUX0VNUFRZKCZzcGFjZS0+Y29udGFpbmVycykpIHsN
Cj4+IC0gICAgICAgIFFMSVNUX1JFTU9WRShzcGFjZSwgbGlzdCk7DQo+PiAtICAgICAgICBnX2Zy
ZWUoc3BhY2UpOw0KPj4gKyAgICBpZiAoIVFMSVNUX0VNUFRZKCZzcGFjZS0+Y29udGFpbmVycykp
IHsNCj4+ICsgICAgICAgIHJldHVybjsNCj4NCj5JIHRoaW5rIHRoaXMgY2hhbmdlIGRlc2VydmVz
IHRvIGJlIGluIGEgc2VwYXJhdGUgcGF0Y2gsIGV2ZW4gaWYgc2ltcGxlLg0KPklzIHRoZXJlIHNv
bWUgcmVsYXRpb24gd2l0aCBpb21tdWZkID8gVGhpcyBpcyBub3QgY2xlYXIuDQoNCk9LLCB3aWxs
IGRvLiBJdCdzIHVucmVsYXRlZCB0byBpb21tdWZkLCBqdXN0IGF2b2lkIHVubmVjZXNzYXJ5IGNo
ZWNrIGJlbG93LiANCg0KPg0KPj4gICAgICAgfQ0KPj4gKw0KPj4gKyAgICBRTElTVF9SRU1PVkUo
c3BhY2UsIGxpc3QpOw0KPj4gKyAgICBnX2ZyZWUoc3BhY2UpOw0KPj4gKw0KPj4gICAgICAgaWYg
KFFMSVNUX0VNUFRZKCZ2ZmlvX2FkZHJlc3Nfc3BhY2VzKSkgew0KPj4gICAgICAgICAgIHFlbXVf
dW5yZWdpc3Rlcl9yZXNldCh2ZmlvX3Jlc2V0X2hhbmRsZXIsIE5VTEwpOw0KPj4gICAgICAgfQ0K
Pj4gQEAgLTE0OTgsOCArMTUwMiwxNiBAQCByZXRyeToNCj4+ICAgaW50IHZmaW9fYXR0YWNoX2Rl
dmljZShjaGFyICpuYW1lLCBWRklPRGV2aWNlICp2YmFzZWRldiwNCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICBBZGRyZXNzU3BhY2UgKmFzLCBFcnJvciAqKmVycnApDQo+PiAgIHsNCj4+IC0g
ICAgY29uc3QgVkZJT0lPTU1VT3BzICpvcHMgPSAmdmZpb19sZWdhY3lfb3BzOw0KPj4gKyAgICBj
b25zdCBWRklPSU9NTVVPcHMgKm9wczsNCj4+DQo+PiArI2lmZGVmIENPTkZJR19JT01NVUZEDQo+
PiArICAgIGlmICh2YmFzZWRldi0+aW9tbXVmZCkgew0KPj4gKyAgICAgICAgb3BzID0gJnZmaW9f
aW9tbXVmZF9vcHM7DQo+PiArICAgIH0gZWxzZQ0KPj4gKyNlbmRpZg0KPj4gKyAgICB7DQo+PiAr
ICAgICAgICBvcHMgPSAmdmZpb19sZWdhY3lfb3BzOw0KPj4gKyAgICB9DQo+DQo+U2ltcGx5IGFk
ZGluZyA6DQo+DQo+ICArI2lmZGVmIENPTkZJR19JT01NVUZEDQo+ICArICAgIGlmICh2YmFzZWRl
di0+aW9tbXVmZCkgew0KPiAgKyAgICAgICAgb3BzID0gJnZmaW9faW9tbXVmZF9vcHM7DQo+ICAr
ICAgIH0NCj4gICsjZW5kaWYNCj4NCj53b3VsZCBoYXZlIHRoZSBzYW1lIGVmZmVjdCB3aXRoIGxl
c3MgY2hhbmdlLg0KDQpJbmRlZWQsIHdpbGwgZG8uDQoNCj4NCj5UaGF0IHNhaWQsIGl0IHdvdWxk
IGFsc28gYmUgbmljZSB0byBmaW5kIGEgd2F5IHRvIGF2b2lkIHRoZSB1c2Ugb2YNCj5DT05GSUdf
SU9NTVVGRCBpbiBody92ZmlvL2NvbW1vbi5jLiBNYXkgYmUgd2l0aCBhIGhlbHBlciByZXR1cm5p
bmcNCj4nY29uc3QgVkZJT0lPTU1VT3BzIConLiBUaGlzIGlzIG1pbm9yLiBTdGlsbCwgSSBmaW5k
IHNvbWUgcmVkdW5kYW5jeQ0KPndpdGggdmZpb19jb250YWluZXJfaW5pdCgpIGFuZCBJIGRvbid0
IGEgZ29vZCBhbHRlcm5hdGl2ZSB5ZXQgOikNCg0KU3VyZSwgd2lsbCBkbywgZ3Vlc3MgeW91IG1l
YW4gYSBoZWxwZXIgZnVuY3Rpb24gaW4gaHcvdmZpby9oZWxwZXJzLmMgd2l0aA0KQ09ORklHX0lP
TU1VRkQgY2hlY2s/DQoNCj4NCj4NCj4+ICAgICAgIHJldHVybiBvcHMtPmF0dGFjaF9kZXZpY2Uo
bmFtZSwgdmJhc2VkZXYsIGFzLCBlcnJwKTsNCj4+ICAgfQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9o
dy92ZmlvL2lvbW11ZmQuYyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+PiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMC4uZWE0ZTIzZjRlYw0KPj4gLS0tIC9kZXYvbnVsbA0K
Pj4gKysrIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+IEBAIC0wLDAgKzEsNDI5IEBADQo+PiArLyoN
Cj4+ICsgKiBpb21tdWZkIGNvbnRhaW5lciBiYWNrZW5kDQo+PiArICoNCj4+ICsgKiBDb3B5cmln
aHQgKEMpIDIwMjMgSW50ZWwgQ29ycG9yYXRpb24uDQo+PiArICogQ29weXJpZ2h0IFJlZCBIYXQs
IEluYy4gMjAyMw0KPj4gKyAqDQo+PiArICogQXV0aG9yczogWWkgTGl1IDx5aS5sLmxpdUBpbnRl
bC5jb20+DQo+PiArICogICAgICAgICAgRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29t
Pg0KPj4gKyAqDQo+PiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0
ZXINCj4+ICsgKi8NCj4+ICsNCj4+ICsjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPj4gKyNpbmNs
dWRlIDxzeXMvaW9jdGwuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvdmZpby5oPg0KPj4gKyNpbmNs
dWRlIDxsaW51eC9pb21tdWZkLmg+DQo+PiArDQo+PiArI2luY2x1ZGUgImh3L3ZmaW8vdmZpby1j
b21tb24uaCINCj4+ICsjaW5jbHVkZSAicWVtdS9lcnJvci1yZXBvcnQuaCINCj4+ICsjaW5jbHVk
ZSAidHJhY2UuaCINCj4+ICsjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPj4gKyNpbmNsdWRlICJz
eXNlbXUvaW9tbXVmZC5oIg0KPj4gKyNpbmNsdWRlICJody9xZGV2LWNvcmUuaCINCj4+ICsjaW5j
bHVkZSAic3lzZW11L3Jlc2V0LmgiDQo+PiArI2luY2x1ZGUgInFlbXUvY3V0aWxzLmgiDQo+PiAr
I2luY2x1ZGUgInFlbXUvY2hhcmRldl9vcGVuLmgiDQo+PiArDQo+PiArc3RhdGljIGludCBpb21t
dWZkX21hcChWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lciwgaHdhZGRyIGlvdmEsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICByYW1fYWRkcl90IHNpemUsIHZvaWQgKnZhZGRyLCBib29s
IHJlYWRvbmx5KQ0KPj4gK3sNCj4+ICsgICAgVkZJT0lPTU1VRkRDb250YWluZXIgKmNvbnRhaW5l
ciA9DQo+PiArICAgICAgICBjb250YWluZXJfb2YoYmNvbnRhaW5lciwgVkZJT0lPTU1VRkRDb250
YWluZXIsIGJjb250YWluZXIpOw0KPj4gKw0KPj4gKyAgICByZXR1cm4gaW9tbXVmZF9iYWNrZW5k
X21hcF9kbWEoY29udGFpbmVyLT5iZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGNvbnRhaW5lci0+aW9hc19pZCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGlvdmEsIHNpemUsIHZhZGRyLCByZWFkb25seSk7DQo+PiArfQ0KPj4gKw0KPj4g
K3N0YXRpYyBpbnQgaW9tbXVmZF91bm1hcChWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lciwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRyIGlvdmEsIHJhbV9hZGRyX3Qgc2l6
ZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVUTEJFbnRyeSAqaW90bGIpDQo+
PiArew0KPj4gKyAgICBWRklPSU9NTVVGRENvbnRhaW5lciAqY29udGFpbmVyID0NCj4+ICsgICAg
ICAgIGNvbnRhaW5lcl9vZihiY29udGFpbmVyLCBWRklPSU9NTVVGRENvbnRhaW5lciwgYmNvbnRh
aW5lcik7DQo+PiArDQo+PiArICAgIC8qIFRPRE86IEhhbmRsZSBkbWFfdW5tYXBfYml0bWFwIHdp
dGggaW90bGIgYXJncyAobWlncmF0aW9uKSAqLw0KPj4gKyAgICByZXR1cm4gaW9tbXVmZF9iYWNr
ZW5kX3VubWFwX2RtYShjb250YWluZXItPmJlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjb250YWluZXItPmlvYXNfaWQsIGlvdmEsIHNpemUpOw0KPj4gK30NCj4+
ICsNCj4+ICtzdGF0aWMgdm9pZCBpb21tdWZkX2NkZXZfa3ZtX2RldmljZV9hZGQoVkZJT0Rldmlj
ZSAqdmJhc2VkZXYpDQo+PiArew0KPj4gKyAgICBFcnJvciAqZXJyID0gTlVMTDsNCj4+ICsNCj4+
ICsgICAgaWYgKHZmaW9fa3ZtX2RldmljZV9hZGRfZmQodmJhc2VkZXYtPmZkLCAmZXJyKSkgew0K
Pj4gKyAgICAgICAgZXJyb3JfcmVwb3J0X2VycihlcnIpOw0KPg0KPldlIHNob3VsZCBwcm9wYWdh
dGUgdGhpcyBlcnJvciB0byB0aGUgY2FsbGVycyBpbnN0ZWFkLg0KDQpUaGlzIGlzIHRvIGZvbGxv
dyBsZWdhY3kgYmFja2VuZCB3aGVyZSB0aGUgZXJyb3IgZG9lc24ndCB0cmVhdGVkIGFzDQphIHNl
cmlvdXMgaXNzdWUuDQoNCj4NCj4+ICsgICAgfQ0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9p
ZCBpb21tdWZkX2NkZXZfa3ZtX2RldmljZV9kZWwoVkZJT0RldmljZSAqdmJhc2VkZXYpDQo+PiAr
ew0KPj4gKyAgICBFcnJvciAqZXJyID0gTlVMTDsNCj4+ICsNCj4+ICsgICAgaWYgKHZmaW9fa3Zt
X2RldmljZV9kZWxfZmQodmJhc2VkZXYtPmZkLCAmZXJyKSkgew0KPj4gKyAgICAgICAgZXJyb3Jf
cmVwb3J0X2VycihlcnIpOw0KPg0KPlBvc3NpYmx5IHRoaXMgb25lIGFsc28gYnV0IEl0IG1pZ2h0
IGJlIG1vcmUgY29tcGxleC4gTGV0J3Mga2VlcCBpdCB0aGF0DQo+d2F5Lg0KPg0KPj4gKyAgICB9
DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgaW9tbXVmZF9jb25uZWN0X2FuZF9iaW5kKFZG
SU9EZXZpY2UgKnZiYXNlZGV2LCBFcnJvciAqKmVycnApDQo+PiArew0KPj4gKyAgICBJT01NVUZE
QmFja2VuZCAqaW9tbXVmZCA9IHZiYXNlZGV2LT5pb21tdWZkOw0KPj4gKyAgICBzdHJ1Y3QgdmZp
b19kZXZpY2VfYmluZF9pb21tdWZkIGJpbmQgPSB7DQo+PiArICAgICAgICAuYXJnc3ogPSBzaXpl
b2YoYmluZCksDQo+PiArICAgICAgICAuZmxhZ3MgPSAwLA0KPj4gKyAgICB9Ow0KPj4gKyAgICBp
bnQgcmV0Ow0KPj4gKw0KPj4gKyAgICByZXQgPSBpb21tdWZkX2JhY2tlbmRfY29ubmVjdChpb21t
dWZkLCBlcnJwKTsNCj4+ICsgICAgaWYgKHJldCkgew0KPj4gKyAgICAgICAgcmV0dXJuIHJldDsN
Cj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICAvKg0KPj4gKyAgICAgKiBBZGQgZGV2aWNlIHRvIGt2
bS12ZmlvIHRvIGJlIHByZXBhcmVkIGZvciB0aGUgdHJhY2tpbmcNCj4+ICsgICAgICogaW4gS1ZN
LiBFc3BlY2lhbGx5IGZvciBzb21lIGVtdWxhdGVkIGRldmljZXMsIGl0IHJlcXVpcmVzDQo+PiAr
ICAgICAqIHRvIGhhdmUga3ZtIGluZm9ybWF0aW9uIGluIHRoZSBkZXZpY2Ugb3Blbi4NCj4+ICsg
ICAgICovDQo+PiArICAgIGlvbW11ZmRfY2Rldl9rdm1fZGV2aWNlX2FkZCh2YmFzZWRldik7DQo+
DQo+V2Ugc2hvdWQgcmV0dXJuIGEgcG9zc2libGUgZXJyb3IuDQoNClRoaXMgaXMgdG8gZm9sbG93
IGxlZ2FjeSBiYWNrZW5kIHdoZXJlIHRoaXMgZXJyb3IgaXMgcmVwb3J0ZWQgYW5kIGlnbm9yZWQu
DQpEbyB3ZSBuZWVkIGEgZGlmZmVyZW5jZSBmb3IgaW9tbXVmZCBCRT8NCg0KPg0KPj4gKw0KPj4g
KyAgICAvKiBCaW5kIGRldmljZSB0byBpb21tdWZkICovDQo+PiArICAgIGJpbmQuaW9tbXVmZCA9
IGlvbW11ZmQtPmZkOw0KPj4gKyAgICByZXQgPSBpb2N0bCh2YmFzZWRldi0+ZmQsIFZGSU9fREVW
SUNFX0JJTkRfSU9NTVVGRCwgJmJpbmQpOw0KPj4gKyAgICBpZiAocmV0KSB7DQo+PiArICAgICAg
ICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIGVycm5vLCAiZXJyb3IgYmluZCBkZXZpY2UgZmQ9JWQg
dG8gaW9tbXVmZD0lZCIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgIHZiYXNlZGV2LT5m
ZCwgYmluZC5pb21tdWZkKTsNCj4+ICsgICAgICAgIGdvdG8gZXJyX2JpbmQ7DQo+PiArICAgIH0N
Cj4+ICsNCj4+ICsgICAgdmJhc2VkZXYtPmRldmlkID0gYmluZC5vdXRfZGV2aWQ7DQo+PiArICAg
IHRyYWNlX2lvbW11ZmRfY29ubmVjdF9hbmRfYmluZChiaW5kLmlvbW11ZmQsIHZiYXNlZGV2LT5u
YW1lLA0KPnZiYXNlZGV2LT5mZCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHZiYXNlZGV2LT5kZXZpZCk7DQo+PiArICAgIHJldHVybiByZXQ7DQo+PiArZXJyX2JpbmQ6
DQo+PiArICAgIGlvbW11ZmRfY2Rldl9rdm1fZGV2aWNlX2RlbCh2YmFzZWRldik7DQo+PiArICAg
IGlvbW11ZmRfYmFja2VuZF9kaXNjb25uZWN0KGlvbW11ZmQpOw0KPg0KPlRoZXNlIHR3byBjYWxs
cyBsb29rIGxpa2UgaW9tbXVmZF91bmJpbmRfYW5kX2Rpc2Nvbm5lY3QoKSBiZWxvdy4NCg0KWWVz
LCB0aGV5IGFyZSBzYW1lIGFzIGlvbW11ZmQgZG9lc24ndCBzdXBwb3J0IGV4cGxpY2l0IGRldmlj
ZSB1bmJpbmQuDQpCdXQgaXQgbG9va3Mgc3RyYW5nZSB0byBjYWxsIGlvbW11ZmRfdW5iaW5kX2Fu
ZF9kaXNjb25uZWN0IGluDQppb21tdWZkX2Nvbm5lY3RfYW5kX2JpbmQuDQoNCj4NCj4+ICsgICAg
cmV0dXJuIHJldDsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHZvaWQgaW9tbXVmZF91bmJpbmRf
YW5kX2Rpc2Nvbm5lY3QoVkZJT0RldmljZSAqdmJhc2VkZXYpDQo+PiArew0KPj4gKyAgICAvKiBV
bmJpbmQgaXMgYXV0b21hdGljYWxseSBjb25kdWN0ZWQgd2hlbiBkZXZpY2UgZmQgaXMgY2xvc2Vk
ICovDQo+PiArICAgIGlvbW11ZmRfY2Rldl9rdm1fZGV2aWNlX2RlbCh2YmFzZWRldik7DQo+PiAr
ICAgIGlvbW11ZmRfYmFja2VuZF9kaXNjb25uZWN0KHZiYXNlZGV2LT5pb21tdWZkKTsNCj4+ICt9
DQo+PiArDQo+PiArc3RhdGljIGludCBpb21tdWZkX2NkZXZfZ2V0ZmQoY29uc3QgY2hhciAqc3lz
ZnNfcGF0aCwgRXJyb3IgKiplcnJwKQ0KPj4gK3sNCj4+ICsgICAgbG9uZyBpbnQgcmV0ID0gLUVO
T1RUWTsNCj4+ICsgICAgY2hhciAqcGF0aCwgKnZmaW9fZGV2X3BhdGggPSBOVUxMLCAqdmZpb19w
YXRoID0gTlVMTDsNCj4+ICsgICAgRElSICpkaXIgPSBOVUxMOw0KPj4gKyAgICBzdHJ1Y3QgZGly
ZW50ICpkZW50Ow0KPj4gKyAgICBnY2hhciAqY29udGVudHM7DQo+PiArICAgIHN0cnVjdCBzdGF0
IHN0Ow0KPj4gKyAgICBnc2l6ZSBsZW5ndGg7DQo+PiArICAgIGludCBtYWpvciwgbWlub3I7DQo+
PiArICAgIGRldl90IHZmaW9fZGV2dDsNCj4+ICsNCj4+ICsgICAgcGF0aCA9IGdfc3RyZHVwX3By
aW50ZigiJXMvdmZpby1kZXYiLCBzeXNmc19wYXRoKTsNCj4+ICsgICAgaWYgKHN0YXQocGF0aCwg
JnN0KSA8IDApIHsNCj4+ICsgICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJycCwgZXJybm8sICJu
byBzdWNoIGhvc3QgZGV2aWNlIik7DQo+PiArICAgICAgICBnb3RvIG91dF9mcmVlX3BhdGg7DQo+
PiArICAgIH0NCj4+ICsNCj4+ICsgICAgZGlyID0gb3BlbmRpcihwYXRoKTsNCj4+ICsgICAgaWYg
KCFkaXIpIHsNCj4+ICsgICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJycCwgZXJybm8sICJjb3Vs
ZG4ndCBvcGVuIGRpcnJlY3RvcnkgJXMiLCBwYXRoKTsNCj4NCj4NCj5kaXJlY3RvcnkNCg0KR29v
ZCBjYXRjaCwgd2lsbCBmaXguDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCg==

