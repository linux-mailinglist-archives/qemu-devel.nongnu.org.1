Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 021467497CA
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKmn-0006Pl-9q; Thu, 06 Jul 2023 04:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qHKmg-0006NA-4Q; Thu, 06 Jul 2023 04:56:19 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qHKmc-0005gt-9B; Thu, 06 Jul 2023 04:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688633774; x=1720169774;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sbuSdRgpoN/8JT9S+5X2beZby73nCAguJZpygSgHzo0=;
 b=eunwTdlLCVVJrI8E6MO8gG4j/ryPjSqzUtzCRpgs+OSkWiimqbVQro0m
 8UyoTLMBOyQTN7FTUOx9ysH54Rmm9l2GHA5FGWpDKwZVzUagvF0XNdXhK
 Qko8/GmPZNUw7HfiPUvgsd3HbBwBkEWuIs/kLDnfcyLuYL9ZR92E//yEk
 SK67uk9Ozi9VGIYfmZymj6nwgaauQ+nK7SxW9J4kdhtUkV/1YrTgISSjR
 CZWheb4pkUe+o3YGBe96zk2IVAtKmVOcaPQ/xlM2n8MCErt2Fw3AVbZ/b
 E/3aBmNYubwdh1n+JW8gyijdHqqiMQJ28IlKwPF2iCQKitOMPSjsJDeW8 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="429590559"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; d="scan'208";a="429590559"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2023 01:56:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="893486660"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; d="scan'208";a="893486660"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga005.jf.intel.com with ESMTP; 06 Jul 2023 01:56:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 01:56:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 01:56:07 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 01:56:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKnDC6v4veuGL4/v3sg3zUI7W4dn4lyv0fRA4mOaYFWQRvjTGYEoyxmZPW78eeSR7ixkb4BNxFDdzEk+tZ15kZSCvttmOIX/QAzJtcgD4wkXiqy/CoGM5k41bgxW9HU+DyGPHquAH2oSCqApry8nZy1wwUAHj2F88cb8uQNtcNUGF1uo7enYYkkI8DS77qH/rRiCvPoUPqFSk4VxWTYVX/ehKqVr1aHYXx8svamSFm89XxqohUSPTVAFwrVUBxPZXJTcZANI2QF/rzrd4BwoovRnd1FDzsa00FfmnqwkomLJcBFgMoXuQDy+CqyxhIc8ycNuAIxIb08dr6YRlrWR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbuSdRgpoN/8JT9S+5X2beZby73nCAguJZpygSgHzo0=;
 b=FUCQpSySHQTFIY2QJxFFL+WHT+DESFwog5tWZdj028IyZjy/zgpQC5El2PlRQe74UgL+QZ/PNXusXDZgN18seQz9ZXhDAfkjxOuO7aYqxGIMQ1iA2/mkRRSzdNtMKBLpS1naZV9teOrA7bHglk25ZiW7QBih3E+LR3kFurRGRxguucAgEriLWKTB9gM15TCLqlX05VkW7D8eXOX/Tpx3eQvsiXIMRFnd0TTUO9t3NWWoZW+qHKOoRD6nWTiT3UTqUvmRURgLWbeSfdgpTcvdCN8wGkv7noYPiWgRSL5Z78S+n6mNdW3XrwgLOW02yzPEP8Q8eMODtsG0zjtTWL90Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA0PR11MB7258.namprd11.prod.outlook.com (2603:10b6:208:43d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 08:56:05 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0%6]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 08:56:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhap.com" <clg@redhap.com>, "bharat.bhushan@nxp.com"
 <bharat.bhushan@nxp.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [PATCH 2/2] virtio-iommu: Rework the trace in
 virtio_iommu_set_page_size_mask()
Thread-Topic: [PATCH 2/2] virtio-iommu: Rework the trace in
 virtio_iommu_set_page_size_mask()
Thread-Index: AQHZrmjmjixANg4+sU2QQB+pIVxfpK+qnCOwgAA38RCAAFTtgIABR/Ag
Date: Thu, 6 Jul 2023 08:56:03 +0000
Message-ID: <SJ0PR11MB67449B6C4F690D002B279B51922CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230704111527.3424992-1-eric.auger@redhat.com>
 <20230704111527.3424992-3-eric.auger@redhat.com>
 <SJ0PR11MB6744FA4E41101F7EED607E9C922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB6744AEDC41BE576A59908A30922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <a11b8c79-9efc-6686-6405-863abb8824ae@redhat.com>
In-Reply-To: <a11b8c79-9efc-6686-6405-863abb8824ae@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA0PR11MB7258:EE_
x-ms-office365-filtering-correlation-id: a434d262-eafc-469c-2034-08db7dfed3cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YgbuS/evHkQUqVbddoNJSxjMG30xAXoqB4pYtLhVnL8gEu2Mb5PWXIqrX+nAdE7NrBuSEDqPgvt8XRyigji1rHhOuICVSIwJmKARtV6OOeh8oAENWvVPW9+HDS1cZWdxdmVg2K1t4hopM8qlJrkcCQdBb0CZyIIzeXexfKlk8EaC/16fbahADD7G/YJtSOdpT6v+tiYq9e1Cv8NQEObUIjMvQbNrMQnFJc++5s9uYPXz85L2cQhXxEiJeGSwf4u1detoM57wOO1IUbx5E4cImET376q4aJF/jCHT9s3hs5e+kAb0PlBGgXx9LiurktR6AzcI8NwupCY5l8jAR421FMvqb53A1nOaUqQMTcapPR0N/cjzl+kptmTyKhDF9mwePVFBIKuORM/ojSTwWeiQcoyjtRZGxqqIGYCY6B9zUsr9eYuiEEGiu0SnnaSSzDEY0BorL9dbwwA75NOipC6m/eupu8LV0cLcsEDbOwncYxTa6HF6a02ewxMum6TA39ONM1Rk//zPRbA063EFTfFjeeGA6ekjLkboDUndspYjw3dcsVL1oEx/7YB7/FWc9LcZYx5Y5BpmDnl1FIRss3JTpCv9rKpKpbuGCpyoYm9cHA36oNbYGMhRwUycsoRP2OKM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(83380400001)(7696005)(2906002)(7416002)(86362001)(5660300002)(6506007)(53546011)(186003)(38070700005)(8676002)(41300700001)(9686003)(26005)(316002)(8936002)(66446008)(64756008)(66556008)(66476007)(33656002)(52536014)(4326008)(66946007)(76116006)(122000001)(478600001)(82960400001)(55016003)(110136005)(54906003)(71200400001)(38100700002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGpTNXNKTEJCRkJXdkRMV2ZCcHNDaGcydkhVS0pBNFVPQy9qTDNQN1VjVjI4?=
 =?utf-8?B?bitGSktpQ3hxZS9pck9SWHBacHMzdkhzczFiRE5hN0tRVFAreEpUSWNLemhT?=
 =?utf-8?B?Q2tITDB5WC9RaHFNSXhGMCt5K3pZblJ0SVVCeW1zMlgrNkRVZS84dzM2MkR4?=
 =?utf-8?B?VkZqbmp6TVM5N3kxQlVzYUl2djVMeFlkbDFIRTVPRWQ0WGxJbWpyTUEzKzJk?=
 =?utf-8?B?Y2dKd25kUWdlNHBBbmJlWmJNVk8zcjdENmhCbS9sQkVxV3VIYWxUZEVSdUdp?=
 =?utf-8?B?OWZKWnZncGRmQVo0SVNyaFJpakM1cnQ5ZXlyeGZ6K2wzWDZTckU1Q0NPQTFp?=
 =?utf-8?B?TGRXQjVHTDNJRXV2MEFzbHpNbmJtVm1GVkE0YUNrSVJLVGJQMVJIbGFoUnR5?=
 =?utf-8?B?Y2NQcGplc0s4dzRVcXk1aUJVNFZoekJNa0ZPZkR1cEgwZ3VRQm4zeGJ5NHdF?=
 =?utf-8?B?S2UvazNpUFRHeXJkbjUzcEJkL2dTbks2TzZnUCtPQkVOWDFTMjRkVEJSTGRk?=
 =?utf-8?B?MThWYnRhTlBxK0ZGb1JtdkxnVDFMYzhUTkloOEpLVDgwOGowS21iTEh0T2Vv?=
 =?utf-8?B?ZUc0SVl5Si8ybmg2eEJYaUM1dXhEKzh0Z3gyS2lrWWFSYytVdVNISUpxQ1Nh?=
 =?utf-8?B?NHZPQWpHalJmOThrWmwySDZ6R2tNaVBqTitha2xBZzdKT0dkN2lKaFFvamVL?=
 =?utf-8?B?MlZpYm9xVE1vK3luWXdheHl6cVh3d2pxbVFXcTBzaFlFMjRaTlF1OWpoVEZu?=
 =?utf-8?B?VkVzQm42cG03dGd1QmJwcm8rV1pMZUFwSSt2emFteUxjQkw0QmM2c0dTOWV3?=
 =?utf-8?B?ZHRxRVkwRFY1M1JGN0hwbkNUamZxQjdCOFBZdjFTdVZJM0RReXU1ckc0K2Nm?=
 =?utf-8?B?SW13RVNhTk04bjVwL0szNTF1cE1CMHhONHVJd29RQldOeXY0cFVld1ErOHND?=
 =?utf-8?B?Yzlsd2VFUW83azZCSDZNZi96UkxkVWVpSnZwUEI3WFZ6Z3E3dUkrS1dwOHJq?=
 =?utf-8?B?ck9DRyttSHY1ZjBZMVRUQ2ZKQlFFL2pSbmpMbmxtdUhEU0lUUGQwbHNqNUFH?=
 =?utf-8?B?dVQ5QThIcjBxMjhObG93UXFwMDlwR1Exd3pTUFdwUmI3eEcyTnhJTWFiSlp5?=
 =?utf-8?B?RGdZTVArUERkY0l4NmFKYWR5STNEbW5STUhRdHlHVWRjNFJtcC91OHdZMmtn?=
 =?utf-8?B?bHRCMzhGVkZDc0V1clRYNC9IZlhCYjZaYlJuK051YXNBMFhUNE14ZTF3T1d4?=
 =?utf-8?B?c3hNTndnMGFRcmtrb1lqdWgvZ1dyUmpCVDJKQ0RuYkRCdlhaZlFhVWgzTmI5?=
 =?utf-8?B?N0lqcXhjZ3gvbTdqOXNqYWVCNUg0U29FMXJEOWlLQlNsQ2Y5S2tqOWd5SWIx?=
 =?utf-8?B?TzhPNW1XQjhhM2gvTFdzaTlNREJRSWg2Wm1IRk55OXR5RUFiS2VaOS9lemo0?=
 =?utf-8?B?dWRGMmJRKzNiWk44YWtqVldzY2pOVHNVTWJFR3N5RnhyZDRVSDZ5TlJJVE5z?=
 =?utf-8?B?ZGtmR1l1WVpsbmtFQk45VDFSTW9zamZNamZIdzlRVXJlTmI3akVGamlpeldP?=
 =?utf-8?B?RVNBMWV6aktqTWt1T0FZZVVJTmw2VXU0ZFN6OU5tblEyS3BuNm16b1QyVFF5?=
 =?utf-8?B?T09YbHNJcTNNUDVkQ00vQ1VoOVdtbkNxdEJDTkdmQWhCVkJodHhKa3ppWWpN?=
 =?utf-8?B?TXpUNUJ5VEdkaUVHYkpUQ3FQTHAxTW13azNTeEFHeEVFWmdKTC9UZGg5ZlR0?=
 =?utf-8?B?WWdCV2tZSHcydDdmK2FwanFYeitGVWlMN2d3V1B0R2FpaFplVDczbEJ6RXVi?=
 =?utf-8?B?MWw3cERONG5lTGhJY2lINGRISWpQNzdEOWdOVVVRMGdrbU9yejlaWHlveXpi?=
 =?utf-8?B?QkZaeVh2bkdFQm1xQ1RFWnBBVVBOTFVSVUVJc3BLSzZENC9HWHVnbXBKWVlP?=
 =?utf-8?B?V3dKRVZKNDVSVjBCWjQ3MEFaY3h0VEpMaHBLT3hHdHE2TDRuN09MaGRMNVJB?=
 =?utf-8?B?WHJYaWhqWVFQOE15dFc5STRQekVLUjJVVE5OWHdEYXNBekhVWjJpRkRqcEJD?=
 =?utf-8?B?QllkV0xGcHdwblRobDZPRi9jMkdPZnMrRHZPbkRYTmQ3REhKeG5SZnJZWkVv?=
 =?utf-8?Q?GSyxt/mtlFJpgPdXmkE/iPTSi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a434d262-eafc-469c-2034-08db7dfed3cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 08:56:03.1510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uI+GOk3k52PSCEBQb44ucvGvhvPNcg5vz7Q8qtFn6Ii2E+pcPeYErBewDis5vKXKdPDq9Q/QOqhUy02YwpS6bXh2N/v7hNO2hOjPRbJk15k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7258
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

SGkgRXJpYywNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIg
PGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIEp1bHkgNSwgMjAyMyA5
OjE3IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIHZpcnRpby1pb21tdTogUmV3b3JrIHRo
ZSB0cmFjZSBpbg0KPnZpcnRpb19pb21tdV9zZXRfcGFnZV9zaXplX21hc2soKQ0KPg0KPkhpIFpo
ZW5naG9uZywNCj4NCj5PbiA3LzUvMjMgMTA6MTcsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+
DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBEdWFuLCBaaGVuemhv
bmcNCj4+PiBTZW50OiBXZWRuZXNkYXksIEp1bHkgNSwgMjAyMyAxMjo1NiBQTQ0KPj4+IFN1Ympl
Y3Q6IFJFOiBbUEFUQ0ggMi8yXSB2aXJ0aW8taW9tbXU6IFJld29yayB0aGUgdHJhY2UgaW4NCj4+
PiB2aXJ0aW9faW9tbXVfc2V0X3BhZ2Vfc2l6ZV9tYXNrKCkNCj4+Pg0KPj4+DQo+Pj4NCj4+Pj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5h
dWdlckByZWRoYXQuY29tPg0KPj4+PiBTZW50OiBUdWVzZGF5LCBKdWx5IDQsIDIwMjMgNzoxNSBQ
TQ0KPj4+PiBUbzogZXJpYy5hdWdlci5wcm9AZ21haWwuY29tOyBlcmljLmF1Z2VyQHJlZGhhdC5j
b207IHFlbXUtDQo+Pj4+IGRldmVsQG5vbmdudS5vcmc7IHFlbXUtYXJtQG5vbmdudS5vcmc7IG1z
dEByZWRoYXQuY29tOyBqZWFuLQ0KPj4+PiBwaGlsaXBwZUBsaW5hcm8ub3JnOyBEdWFuLCBaaGVu
emhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+Pj4gQ2M6IGFsZXgud2lsbGlhbXNv
bkByZWRoYXQuY29tOyBjbGdAcmVkaGFwLmNvbTsNCj4+PiBiaGFyYXQuYmh1c2hhbkBueHAuY29t
Ow0KPj4+PiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmcNCj4+Pj4gU3ViamVjdDogW1BBVENIIDIv
Ml0gdmlydGlvLWlvbW11OiBSZXdvcmsgdGhlIHRyYWNlIGluDQo+Pj4+IHZpcnRpb19pb21tdV9z
ZXRfcGFnZV9zaXplX21hc2soKQ0KPj4+Pg0KPj4+PiBUaGUgY3VycmVudCBlcnJvciBtZXNzYWdl
cyBpbiB2aXJ0aW9faW9tbXVfc2V0X3BhZ2Vfc2l6ZV9tYXNrKCkNCj4+Pj4gc291bmQgcXVpdGUg
c2ltaWxhciBmb3IgZGlmZmVyZW50IHNpdHVhdGlvbnMgYW5kIG1pc3MgdGhlIElPTU1VDQo+Pj4+
IG1lbW9yeSByZWdpb24gdGhhdCBjYXVzZXMgdGhlIGlzc3VlLg0KPj4+Pg0KPj4+PiBDbGFyaWZ5
IHRoZW0gYW5kIHJld29yayB0aGUgY29tbWVudC4NCj4+Pj4NCj4+Pj4gQWxzbyByZW1vdmUgdGhl
IHRyYWNlIHdoZW4gdGhlIG5ldyBwYWdlX3NpemVfbWFzayBpcyBub3QgYXBwbGllZCBhcw0KPj4+
PiB0aGUgY3VycmVudCBmcm96ZW4gZ3JhbnVsZSBpcyBrZXB0LiBUaGlzIG1lc3NhZ2UgaXMgcmF0
aGVyIGNvbmZ1c2luZw0KPj4+PiBmb3IgdGhlIGVuZCB1c2VyIGFuZCBhbnl3YXkgdGhlIGN1cnJl
bnQgZ3JhbnVsZSB3b3VsZCBoYXZlIGJlZW4gdXNlZA0KPj4+PiBieSB0aGUgZHJpdmVyDQo+Pj4+
DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4N
Cj4+Pj4gLS0tDQo+Pj4+IGh3L3ZpcnRpby92aXJ0aW8taW9tbXUuYyB8IDE5ICsrKysrKystLS0t
LS0tLS0tLS0NCj4+Pj4gMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRp
b25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmlydGlvLWlvbW11LmMg
Yi9ody92aXJ0aW8vdmlydGlvLWlvbW11LmMNCj4+Pj4gaW5kZXggMWVhZjgxYmFiNS4uMGQ5Zjcx
OTZmZSAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5jDQo+Pj4+ICsr
KyBiL2h3L3ZpcnRpby92aXJ0aW8taW9tbXUuYw0KPj4+PiBAQCAtMTEwMSwyOSArMTEwMSwyNCBA
QCBzdGF0aWMgaW50DQo+Pj4+IHZpcnRpb19pb21tdV9zZXRfcGFnZV9zaXplX21hc2soSU9NTVVN
ZW1vcnlSZWdpb24gKm1yLA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBuZXdfbWFzayk7DQo+Pj4+DQo+Pj4+ICAgICBpZiAoKGN1cl9tYXNrICYgbmV3X21h
c2spID09IDApIHsNCj4+Pj4gLSAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAidmlydGlvLWlvbW11
IHBhZ2UgbWFzayAweCUiUFJJeDY0DQo+Pj4+IC0gICAgICAgICAgICAgICAgICAgIiBpcyBpbmNv
bXBhdGlibGUgd2l0aCBtYXNrIDB4JSJQUkl4NjQsIGN1cl9tYXNrLA0KPm5ld19tYXNrKTsNCj4+
Pj4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAidmlydGlvLWlvbW11ICVzIHJlcG9ydHMgYSBw
YWdlIHNpemUgbWFzaw0KPjB4JSJQUkl4NjQNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAiIGlu
Y29tcGF0aWJsZSB3aXRoIGN1cnJlbnRseSBzdXBwb3J0ZWQgbWFzayAweCUiUFJJeDY0LA0KPj4+
PiArICAgICAgICAgICAgICAgICAgIG1yLT5wYXJlbnRfb2JqLm5hbWUsIG5ld19tYXNrLCBjdXJf
bWFzayk7DQo+Pj4+ICAgICAgICAgcmV0dXJuIC0xOw0KPj4+PiAgICAgfQ0KPj4+Pg0KPj4+PiAg
ICAgLyoNCj4+Pj4gICAgICAqIE9uY2UgdGhlIGdyYW51bGUgaXMgZnJvemVuIHdlIGNhbid0IGNo
YW5nZSB0aGUgbWFzayBhbnltb3JlLiBJZiBieQ0KPj4+PiAgICAgICogY2hhbmNlIHRoZSBob3Rw
bHVnZ2VkIGRldmljZSBzdXBwb3J0cyB0aGUgc2FtZSBncmFudWxlLCB3ZSBjYW4gc3RpbGwNCj4+
Pj4gLSAgICAgKiBhY2NlcHQgaXQuIEhhdmluZyBhIGRpZmZlcmVudCBtYXNrcyBpcyBwb3NzaWJs
ZSBidXQgdGhlIGd1ZXN0IHdpbGwgdXNlDQo+Pj4+IC0gICAgICogc3ViLW9wdGltYWwgYmxvY2sg
c2l6ZXMsIHNvIHdhcm4gYWJvdXQgaXQuDQo+Pj4+ICsgICAgICogYWNjZXB0IGl0Lg0KPj4+PiAg
ICAgICovDQo+Pj4+ICAgICBpZiAocy0+Z3JhbnVsZV9mcm96ZW4pIHsNCj4+Pj4gLSAgICAgICAg
aW50IG5ld19ncmFudWxlID0gY3R6NjQobmV3X21hc2spOw0KPj4+PiAgICAgICAgIGludCBjdXJf
Z3JhbnVsZSA9IGN0ejY0KGN1cl9tYXNrKTsNCj4+Pj4NCj4+Pj4gLSAgICAgICAgaWYgKG5ld19n
cmFudWxlICE9IGN1cl9ncmFudWxlKSB7DQo+Pj4+IC0gICAgICAgICAgICBlcnJvcl9zZXRnKGVy
cnAsICJ2aXJ0aW8taW9tbXUgcGFnZSBtYXNrIDB4JSJQUkl4NjQNCj4+Pj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgIiBpcyBpbmNvbXBhdGlibGUgd2l0aCBtYXNrIDB4JSJQUkl4NjQsIGN1cl9t
YXNrLA0KPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICBuZXdfbWFzayk7DQo+Pj4+ICsgICAg
ICAgIGlmICghKEJJVChjdXJfZ3JhbnVsZSkgJiBuZXdfbWFzaykpIHsNCj4+IFNvcnJ5LCBJIHJl
YWQgdGhpcyBwaWVjZSBjb2RlIGFnYWluIGFuZCBnb3QgYSBxdWVzdGlvbiwgaWYgbmV3X21hc2sN
Cj4+IGhhcyBmaW5lciBncmFudWxhcml0eSB0aGFuIGN1cl9ncmFudWxlLCBzaG91bGQgd2UgYWxs
b3cgaXQgdG8gcGFzcw0KPj4gZXZlbiB0aG91Z2gNCj4+IEJJVChjdXJfZ3JhbnVsZSkgaXMgbm90
IHNldD8NCj5JIHRoaW5rIHRoaXMgc2hvdWxkIHdvcmsgYnV0IHRoaXMgaXMgbm90IHN0cmFpZ2h0
Zm9yd2FyZCB0byB0ZXN0Lg0KPnZpcnRpby1pb21tdSB3b3VsZCB1c2UgdGhlIGN1cnJlbnQgZ3Jh
bnVsZSBmb3IgbWFwL3VubWFwLiBJbiBtYXAvdW5tYXANCj5ub3RpZmllcnMsIHRoaXMgaXMgc3Bs
aXQgaW50byBwb3cyIHJhbmdlcyBhbmQgY2FzY2FkZWQgdG8gVkZJTyB0aHJvdWdoDQo+dmZpb19k
bWFfbWFwL3VubWFwLiBUaGUgaW92YSBhbmQgc2l6ZSBhcmUgYWxpZ25lZCB3aXRoIHRoZSBzbWFs
bGVyDQo+c3VwcG9ydGVkIGdyYW51bGUuDQoNCkkgc2VlLCBndWVzcyB5b3UgbWVhbiBtYWxpY2lv
dXMgZ3Vlc3Qgd2hpY2ggbWF5IHNlbmQgYW55IG1hcHBpbmcgcmVxdWVzdA0KdG8gdmlydGlvLWlv
bW11IGJhY2tlbmQuIEEgd2VsbCBkZXNpZ25lZCBndWVzdCBtYXkgdXNlIGF0IGxlYXN0IGN1cl9n
cmFudWxlDQphcyB0aGUgZ3JhbnVsYXJpdHkgb2YgaXRzIG1hcHBpbmcsIGV2ZW4gd2l0aCBwb3cy
IHNwbGl0LCBjdXJfZ3JhbnVsZSBpcw0KZ3VhcmFudGVlZCBhdCBiYWNrZW5kLg0KDQpUaGFua3MN
ClpoZW56aG9uZw0KDQo+DQo+SmVhbiwgZG8geW91IHNoYXJlIHRoaXMgdW5kZXJzdGFuZGluZyBv
ciBkbyBJIG1pc3Mgc29tZXRoaW5nLg0KPg0KPk5ldmVydGhlbGVzcyB0aGUgY3VycmVudCBjb2Rl
IHdvdWxkIGhhdmUgcmVqZWN0ZWQgdGhhdCBjYXNlIGFuZCBub2JvZHkNCj5jb21wbGFpbmVkIGF0
IHRoYXQgcG9pbnQgOy0pDQo+DQo+dGhhbmtzDQo+DQo+RXJpYw0KPg0KPj4NCj4+IFRoYW5rcw0K
Pj4gWmhlbnpob25nDQo+Pg0KPj4+IEdvb2QgY2F0Y2guDQo+Pj4NCj4+PiBSZXZpZXdlZC1ieTog
Wmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+Pg0KPj4+IFRoYW5r
cw0KPj4+IFpoZW56aG9uZw0KPj4+DQo+Pj4+ICsgICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAs
ICJ2aXJ0aW8taW9tbXUgJXMgZG9lcyBub3Qgc3VwcG9ydA0KPj4+PiArIGZyb3plbiBncmFudWxl
DQo+Pj4+IDB4JSJQUkl4NjQsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIG1yLT5wYXJl
bnRfb2JqLm5hbWUsIEJJVChjdXJfZ3JhbnVsZSkpOw0KPj4+PiAgICAgICAgICAgICByZXR1cm4g
LTE7DQo+Pj4+IC0gICAgICAgIH0gZWxzZSBpZiAobmV3X21hc2sgIT0gY3VyX21hc2spIHsNCj4+
Pj4gLSAgICAgICAgICAgIHdhcm5fcmVwb3J0KCJ2aXJ0aW8taW9tbXUgcGFnZSBtYXNrIDB4JSJQ
Ukl4NjQNCj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICIgZG9lcyBub3QgbWF0Y2ggMHgl
IlBSSXg2NCwgY3VyX21hc2ssIG5ld19tYXNrKTsNCj4+Pj4gICAgICAgICB9DQo+Pj4+ICAgICAg
ICAgcmV0dXJuIDA7DQo+Pj4+ICAgICB9DQo+Pj4+IC0tDQo+Pj4+IDIuMzguMQ0KDQo=

