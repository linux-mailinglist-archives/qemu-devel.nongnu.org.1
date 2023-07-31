Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBA2768A76
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 05:53:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQJws-0003tF-4y; Sun, 30 Jul 2023 23:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qQJwp-0003t4-Su
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 23:51:55 -0400
Received: from [192.55.52.151] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qQJwl-0001bb-Hx
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 23:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690775511; x=1722311511;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rjm/qohlj+/jszic8Mw7Cn8/KwiBIpVY7vbCsUPmqic=;
 b=JWWas7ZYWozJpuRMMP2C22bJ8gFpGCfvjjRyU2UeaDrBwfkJ5f2o7NHP
 2EfxuYcUjFTboa2Z5GAmcRfY6LJdmymkx/FW6pnSbc1JMKDKDqCpT9jXU
 KQC5MpVK3A7DEUdO2G/MwVsIUuk8LZKBZ9wvmHVdDLw2GiBF8D7xHAKLl
 AnqpWEorBVx3qdeVmm6Dtfxx/cOMpmbOMy1v1iHA49E7z/NGns+j9w45x
 trx1BkikrgSKUckdxzryzSz4nJtihkEi28FjmDa8LNYViEIEc9w6H7SDt
 4XbYOIAMk/yJZavJz0pLPeGNYGwR2RCXmpBLEXEGOSHcUO81XrdrBFRJt w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="349215237"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; d="scan'208";a="349215237"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2023 20:51:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="818183897"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; d="scan'208";a="818183897"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by FMSMGA003.fm.intel.com with ESMTP; 30 Jul 2023 20:51:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 30 Jul 2023 20:51:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 30 Jul 2023 20:51:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 30 Jul 2023 20:51:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1THB85lY5Lx/vq0BRpioLdliyAfZmoU5qmuuEYZ9cHHHmDFQvdslDKqoTIWl3plzrYGT5YIt1hWw3qpSDMR84J/nqaa/tAb4xvqC7Enq+y5lHjk3B+VFT2bBTmLhmDEgc7XmfPg6GowJmB2vvabyub+bwSdybhTXd+KIUbz6NokzqZGC/Gl6nvSaGGMUg5lXO5fQfVg6+o+vyQeQ0K56HvIhC4PDrkX0VTUQ15N/7TrB0WOjUVMYbruRr1ELQpVDo0X/R1CVtFjNgCARGL/RmgGq56r53nn5rtJ0tuSWVb1E3QomyjEgcBZhRzVCtT7EGvyTApkcx1mUZ8mPoOFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjm/qohlj+/jszic8Mw7Cn8/KwiBIpVY7vbCsUPmqic=;
 b=e79R4xNabw2sLoN/uE/pj8nMgNlDghPq2sz+sSMH7KCY8lb9+LMH8HNmln48c9dRNYiQlyIahp2p0RNfCJV01U3Q1mYKotb0ZDSgwFoUAfs4Ak/Wab/WnymSJSGIJn5B3wSX6xPnw1gwAK9804d+kJBMvMaowlPBqxwTFROHrHPOVHsGYcq4pFqsKekJ21zcCMj79Vy8V9WPMJ9v8a2F2OuMqgVDUu8Bp4xN7GAxB3d6+ituPlgwYeLtWToGKpvbyLSV4K+nhSbFnQ+NE+u/PUNKGbj4ljwGr5FMfDBZ9HX1RgH/mG83LU/5+aVIetcIebO5hV9wc9b4gMumW6O5Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8114.namprd11.prod.outlook.com (2603:10b6:8:129::6) by
 DS0PR11MB7507.namprd11.prod.outlook.com (2603:10b6:8:150::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.39; Mon, 31 Jul 2023 03:51:43 +0000
Received: from DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::5de4:80fa:4a96:5dbd]) by DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::5de4:80fa:4a96:5dbd%7]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 03:51:42 +0000
From: "Liu, Jing2" <jing2.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "Liu, Jing2" <jing2.liu@intel.com>
Subject: RE: [PATCH RFC v1 1/3] vfio/pci: detect the support of dynamic MSI-X
 allocation
Thread-Topic: [PATCH RFC v1 1/3] vfio/pci: detect the support of dynamic MSI-X
 allocation
Thread-Index: AQHZwFtnD/lhplXI/0is72NhiwHcDa/N3dCAgADSDjCAACoOgIAAeUUAgAPvgAA=
Date: Mon, 31 Jul 2023 03:51:42 +0000
Message-ID: <DS0PR11MB8114B740C41BA80D333C9A24A905A@DS0PR11MB8114.namprd11.prod.outlook.com>
References: <20230727072410.135743-1-jing2.liu@intel.com>
 <20230727072410.135743-2-jing2.liu@intel.com>
 <20230727112457.1422f285.alex.williamson@redhat.com>
 <DS0PR11MB8114C864A2D55951DD621214A906A@DS0PR11MB8114.namprd11.prod.outlook.com>
 <e6d47754-9d2b-20bc-55b0-ed6685f7b3b2@redhat.com>
 <20230728094120.6c809cfb.alex.williamson@redhat.com>
In-Reply-To: <20230728094120.6c809cfb.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8114:EE_|DS0PR11MB7507:EE_
x-ms-office365-filtering-correlation-id: 44948973-106b-4ebe-7a41-08db917973c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bI6MoJ/ZJzWz7ccHteSQA71JbSt8icRRpVm+vkMNiRwtKCTuEns56/1QMbAB1NIa6KqaBy66eLW68ES6N8GM6FrHe9B3SajKK+wPXdgD5WQxzwL6CCSW5IKPQAeFf8/laffLyHJz1KYN0i4JjLoH2TiaKOBwP5i+id2XKYGq2S8W4Qdbkgjz2CJGUPfY6XYmlqYaQ4Zo0senryYblcQt7B8aG4lYXZRH4nr99+y0OJeaOmIQf8VMPw/BjNxFgtRuhF1IEdEW+FT9u5GoNX+usxiHFgXbyffm6iia6sCHFfT1GOwhlqKh29vreaFOodkD4KjQoISQJxpNURj926qWJsvRUf93HX+OMsioTat7IGMwZN4McNssf9ueKunHU9U55TU1QXu5Tfo9w1KawLPk22GfdUgaYAzyWPbSVYXsfm2pfnO+9eWU5ugM77Wj19suEGYXbgvmRlEy3FEDexgsuShdchkHyoZSBXPf6kMlvgE9JgTwdTihmNYHFCXhYQ1ZiH5qhuEL/aJLnV0gucbuV5UdHecoR/9p0NuX647rs9SmnShaG+zLKcJaMnSxR0IuoA+oSTP1cPs340ACC7/n/UHvieKMtpNR3ud+yehutuoAcJIg4ZhhKnqUvH1vuotE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8114.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(9686003)(7696005)(55016003)(53546011)(6506007)(26005)(83380400001)(107886003)(186003)(66574015)(33656002)(76116006)(66946007)(66556008)(52536014)(38070700005)(122000001)(54906003)(82960400001)(110136005)(41300700001)(86362001)(66476007)(316002)(64756008)(66446008)(4326008)(5660300002)(8936002)(8676002)(38100700002)(2906002)(71200400001)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGlyd0lnbFIwR2hnVi91b3dCemJlY2FreUozU0Z3b0syK0NhejFDLzZkOEVu?=
 =?utf-8?B?ZWQ4OGVtNjdZbFJnL2JDRFBLN2xCRUxaVEI0dTRDaDZjRUNQclZmZ29PcXo2?=
 =?utf-8?B?MU1laGx4RXdCZVNXU3NGbHI4bGZ5NTg3NVJ1WXRJT1N3Mkp0QXdKKzdsaC9I?=
 =?utf-8?B?SEF6ZVRuOWo4UVNya1pnem1iS0t5UG9YbFFkeHlPMVBTYlEvLzJHOXJtdTFU?=
 =?utf-8?B?S1U0V1BwS0l5cVZDejZtU0N1MXQzNWlHQzlTeXJLcXY5SjFQb01sRGVSTXlK?=
 =?utf-8?B?SEdQbFlBOExzSGtUL3Frdytub0dpQTJQbldTKzIvR2VXaEtwUktqQ3dzUk8z?=
 =?utf-8?B?YlFHdCtPbHhuVTVBRnBTTS9SL1UxbzN4L2ZyakJYY1ZacW9TUk9ZR1V1cHpn?=
 =?utf-8?B?ZHdLaDlweWpuMS9ZQWZHVEhUdXR3YTFaTnFsRkxKQTBJNkd0R0tsTTdJeTVD?=
 =?utf-8?B?RWJvcHFWUXQwd2JZUWYvWVp4dG1UTEYyR09oVFZIVElwc1dZRVRYVHpTME5V?=
 =?utf-8?B?ZmZMYW9xNDU2aEM5MHVRRjZLb2lQbHFzYmx6azNld3VtM1didVpCd0ZkeitC?=
 =?utf-8?B?RzFFQlhrL3pubEI3cURBdHN3VE5uSGszdTFWcGFhdTZ4bU5HaTNmb05IRmRR?=
 =?utf-8?B?SkxHZ0QwMHR1d2JzVDFhdEc2bEYwYy9pS0s1SzlIYUtpQnZhMHNoVGZSU3By?=
 =?utf-8?B?YmVOQTNIWGYrQTZuWkg0dFNyN3dIYVM0cWgwNldER0FsWm0ycndmbjJjS1B3?=
 =?utf-8?B?NUZyT1F3d240Q2g2MUdvS1pwTWdrcE5Gc3lGMU0rUzhVNzh1STdha1dsMmU0?=
 =?utf-8?B?RjAwdStaWVpTd3VLdklrMld6THZnbjFydnp2dVFRZjYyWEhmeG50cEplekVs?=
 =?utf-8?B?L0FPMDQxZTZjSEpCVU0wTnFJbEVsRUVUMzdqME0zY0FXbEcvTHZKNEE5aXM3?=
 =?utf-8?B?dTRCTDJhdzUxVmdvOWlUOTV2VUpWM3NES0tlWW5MV0N4aCtGWm9uWXVJZHdG?=
 =?utf-8?B?ME1ENEozdVlRaktvQnZqZnVvWnBFZjNHVTNaRW92eGt6RkNoeGlTUEtBZWdn?=
 =?utf-8?B?b2t0NjBWRHBSRTcyeWxmMXBPN05UaEZXdTJEWG9lUEdXNVVCT1ZLQTQvbG9Z?=
 =?utf-8?B?WVBOcHRTaHltUHNqQ2VBMFVaSlBJZmtweFQzeTFxQ3ZMczRWdkQ4UTFTa3ZO?=
 =?utf-8?B?NWFIcGtKcU1GdFFtVlFUS1BLNTNDMnczVU5WRVFoMDl0TWlYS0NYU1VNMUJv?=
 =?utf-8?B?OENvbjhqOXduNDFlRElIeVVxeEpkTzBUU3VEMVp4U09EYnhpWEZEcG1CM0Ux?=
 =?utf-8?B?SVpkeFp4NnBMQ0pvQ3pLRXA2UU80TTkyY2t0cHN3b2w4bFpna0UrVVdWVzVx?=
 =?utf-8?B?aUZhWmlKakJGdGhOMi94R3drU2dOeUhEOUdpVEdNZ3Rmdy9RUmVvL2o1TitD?=
 =?utf-8?B?SlB2dzJydmdsdlorUis3dWJYZHRsUSs3RWFsRlFiSzF6dXdFQnlrWVRjY2FU?=
 =?utf-8?B?SjRJcWVSQVpWRUpudlZVYi9YWnQwbWhLVy9uMllZVWN3QUMyUS9nbDJWMkg2?=
 =?utf-8?B?REZHRGZ1UTNzQzhjTGNHenAvSmF0VTdjZERneXpSbjkzcmVNM0Z5YTZBekxN?=
 =?utf-8?B?NnZDYUdxMFhWbjhESkoxcEJodUtkUkJ2Z3ovYWx3bXZNUFVuajBYbmRNaTZM?=
 =?utf-8?B?MnNld2JUdG5RWUF5WkJ1dFkxTDNuaVQwWHBQcXU5Ukp1V09oVjR4UE5oT0tU?=
 =?utf-8?B?blpYUk1tblVKcnNXRDdlOEhHMEN0TGZMcmpXMWFXcW5XV3llWThjelRSWGIv?=
 =?utf-8?B?WkdLeGlwN3VsemlDZGd4bm4xTHN0K1IyNXo5OTM2MG5vTzljMjJjeVZyRy9S?=
 =?utf-8?B?Q1p5SlVWUDdWU3pHdEIxVGNlL2k4RnlpaktZZUFXR05ZV3FrMGlXcW8vK0Ry?=
 =?utf-8?B?OUtkOHlzRDI3SkE5RG1Jb3lyb0I1b1VGaXRzc3pialRIV2tJSitJcDJmVkgz?=
 =?utf-8?B?UVBKamx2QXRzNHl2VEFrMmR2NzRCQzZiOEp4UWJ2UDkycUJ3WDVOWkFCWDE5?=
 =?utf-8?B?LzVWSk1pckIvdis1dTh6RlZXdk5yQjIwa2VSWlJESTFnNW1zaTArWDh6Nmo4?=
 =?utf-8?Q?frbE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8114.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44948973-106b-4ebe-7a41-08db917973c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 03:51:42.1622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHlmO26B2AvdUr9qeXr19tVrDVTm8FM3NAP/XOPK6jAeVkU/jGekE+G4DG3999l8I8s7d3EWkEnHUqfwdk2u2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7507
X-OriginatorOrg: intel.com
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.55.52.151 (failed)
Received-SPF: pass client-ip=192.55.52.151; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

SGkgQWxleCwNCg0KPiBPbiBKdWx5IDI4LCAyMDIzIDExOjQxIFBNLCBBbGV4IFdpbGxpYW1zb24g
PGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgMjggSnVs
IDIwMjMgMTA6Mjc6MTcgKzAyMDANCj4gQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29t
PiB3cm90ZToNCj4gDQo+ID4gT24gNy8yOC8yMyAxMDowOSwgTGl1LCBKaW5nMiB3cm90ZToNCj4g
PiA+IEhpIEFsZXgsDQo+ID4gPg0KPiA+ID4gVGhhbmtzIHZlcnkgbXVjaCBmb3IgcmV2aWV3aW5n
IHRoZSBwYXRjaGVzLg0KPiA+ID4NCj4gPiA+PiBPbiBKdWx5IDI4LCAyMDIzIDE6MjUgQU0sIEFs
ZXggV2lsbGlhbXNvbg0KPiA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+IHdyb3RlOg0KPiA+
ID4+DQo+ID4gPj4gT24gVGh1LCAyNyBKdWwgMjAyMyAwMzoyNDowOCAtMDQwMA0KPiA+ID4+IEpp
bmcgTGl1IDxqaW5nMi5saXVAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+Pg0KPiA+ID4+PiBGcm9t
OiBSZWluZXR0ZSBDaGF0cmUgPHJlaW5ldHRlLmNoYXRyZUBpbnRlbC5jb20+DQo+ID4gPj4+DQo+
ID4gPj4+IEtlcm5lbCBwcm92aWRlcyB0aGUgZ3VpZGFuY2Ugb2YgZHluYW1pYyBNU0ktWCBhbGxv
Y2F0aW9uIHN1cHBvcnQNCj4gPiA+Pj4gb2YgcGFzc3Rocm91Z2ggZGV2aWNlLCBieSBjbGVhcmlu
ZyB0aGUgVkZJT19JUlFfSU5GT19OT1JFU0laRSBmbGFnDQo+ID4gPj4+IHRvIGd1aWRlIHVzZXIg
c3BhY2UuDQo+ID4gPj4+DQo+ID4gPj4+IEZldGNoIGFuZCBzdG9yZSB0aGUgZmxhZ3MgZnJvbSBo
b3N0IGZvciBsYXRlciB1c2UgdG8gZGV0ZXJtaW5lIGlmDQo+ID4gPj4+IHNwZWNpZmljIGZsYWdz
IGFyZSBzZXQuDQo+ID4gPj4+DQo+ID4gPj4+IFNpZ25lZC1vZmYtYnk6IFJlaW5ldHRlIENoYXRy
ZSA8cmVpbmV0dGUuY2hhdHJlQGludGVsLmNvbT4NCj4gPiA+Pj4gU2lnbmVkLW9mZi1ieTogSmlu
ZyBMaXUgPGppbmcyLmxpdUBpbnRlbC5jb20+DQo+ID4gPj4+IC0tLQ0KPiA+ID4+PiAgIGh3L3Zm
aW8vcGNpLmMgICAgICAgIHwgMTIgKysrKysrKysrKysrDQo+ID4gPj4+ICAgaHcvdmZpby9wY2ku
aCAgICAgICAgfCAgMSArDQo+ID4gPj4+ICAgaHcvdmZpby90cmFjZS1ldmVudHMgfCAgMiArKw0K
PiA+ID4+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQ0KPiA+ID4+Pg0KPiA+
ID4+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9wY2kuYyBiL2h3L3ZmaW8vcGNpLmMgaW5kZXgNCj4g
PiA+Pj4gYTIwNWM2YjExMzBmLi4wYzRhYzA4NzNkNDAgMTAwNjQ0DQo+ID4gPj4+IC0tLSBhL2h3
L3ZmaW8vcGNpLmMNCj4gPiA+Pj4gKysrIGIvaHcvdmZpby9wY2kuYw0KPiA+ID4+PiBAQCAtMTU3
Miw2ICsxNTcyLDcgQEAgc3RhdGljIHZvaWQNCj4gPiA+Pj4gdmZpb19tc2l4X2Vhcmx5X3NldHVw
KFZGSU9QQ0lEZXZpY2UNCj4gPiA+Pj4gKnZkZXYsIEVycm9yICoqZXJycCkNCj4gPiA+Pj4NCj4g
PiA+Pj4gICBzdGF0aWMgaW50IHZmaW9fbXNpeF9zZXR1cChWRklPUENJRGV2aWNlICp2ZGV2LCBp
bnQgcG9zLCBFcnJvcg0KPiA+ID4+PiAqKmVycnApICB7DQo+ID4gPj4+ICsgICAgc3RydWN0IHZm
aW9faXJxX2luZm8gaXJxX2luZm8gPSB7IC5hcmdzeiA9IHNpemVvZihpcnFfaW5mbykNCj4gPiA+
Pj4gKyB9Ow0KPiA+ID4+PiAgICAgICBpbnQgcmV0Ow0KPiA+ID4+PiAgICAgICBFcnJvciAqZXJy
ID0gTlVMTDsNCj4gPiA+Pj4NCj4gPiA+Pj4gQEAgLTE2MjQsNiArMTYyNSwxNyBAQCBzdGF0aWMg
aW50IHZmaW9fbXNpeF9zZXR1cChWRklPUENJRGV2aWNlDQo+ID4gPj4+ICp2ZGV2LCBpbnQNCj4g
PiA+PiBwb3MsIEVycm9yICoqZXJycCkNCj4gPiA+Pj4gICAgICAgICAgIG1lbW9yeV9yZWdpb25f
c2V0X2VuYWJsZWQoJnZkZXYtPnBkZXYubXNpeF90YWJsZV9tbWlvLA0KPiBmYWxzZSk7DQo+ID4g
Pj4+ICAgICAgIH0NCj4gPiA+Pj4NCj4gPiA+Pj4gKyAgICBpcnFfaW5mby5pbmRleCA9IFZGSU9f
UENJX01TSVhfSVJRX0lOREVYOw0KPiA+ID4+PiArICAgIHJldCA9IGlvY3RsKHZkZXYtPnZiYXNl
ZGV2LmZkLCBWRklPX0RFVklDRV9HRVRfSVJRX0lORk8sDQo+ICZpcnFfaW5mbyk7DQo+ID4gPj4+
ICsgICAgaWYgKHJldCkgew0KPiA+ID4+PiArICAgICAgICAvKiBUaGlzIGNhbiBmYWlsIGZvciBh
biBvbGQga2VybmVsIG9yIGxlZ2FjeSBQQ0kgZGV2ICovDQo+ID4gPj4+ICsNCj4gPiA+Pj4gKyB0
cmFjZV92ZmlvX21zaXhfc2V0dXBfZ2V0X2lycV9pbmZvX2ZhaWx1cmUoc3RyZXJyb3IoZXJybm8p
KTsNCj4gPiA+Pg0KPiA+ID4+IFdlIG9ubHkgY2FsbCB2ZmlvX21zaXhfc2V0dXAoKSBpZiB0aGUg
ZGV2aWNlIGhhcyBhbiBNU0ktWA0KPiA+ID4+IGNhcGFiaWxpdHksIHNvIHRoZSAibGVnYWN5IFBD
SSIgcG9ydGlvbiBvZiB0aGlzIGNvbW1lbnQgc2VlbXMgdW5qdXN0aWZpZWQuDQo+ID4gPj4gT3Ro
ZXJ3aXNlIHRoZSBHRVRfSVJRX0lORk8gaW9jdGwgaGFzIGFsd2F5cyBleGlzdGVkLCBzbyBJJ2Qg
YWxzbw0KPiA+ID4+IHF1ZXN0aW9uIHRoZSAib2xkIGtlcm5lbCIgcGFydCBvZiB0aGlzIGNvbW1l
bnQuDQo+ID4gPg0KPiA+ID4gT2gsIHllcywgSSBqdXN0IHJlYWxpemUgdGhhdCBvbmx5IFZGSU9f
UENJX0VSUl9JUlFfSU5ERVggYW5kDQo+ID4gPiBWRklPX1BDSV9SRVFfSVJRX0lOREVYIHdlcmUg
YWRkZWQgbGF0ZXIgaW4NCj4gPiA+IGluY2x1ZGUvdWFwaS9saW51eC92ZmlvLmguIFRodXMsIHRo
aXMgaW9jdGwoKSB3aXRoIE1TSVggaW5kZXggd291bGQgbm90IGZhaWwgYnkNCj4gdGhlIG9sZC1r
ZXJuZWwgb3IgbGVnYWN5LVBDSSByZWFzb24uDQo+ID4gPiBUaGFua3MgZm9yIHBvaW50aW5nIG91
dCB0aGlzIHRvIG1lLg0KPiA+ID4NCj4gPiA+IFdlIGRvbid0IGN1cnJlbnRseSBzYW5pdHkgdGVz
dCB0aGUgZGV2aWNlDQo+ID4gPj4gZXhwb3NlZCBNU0ktWCBpbmZvIHZlcnN1cyB0aGF0IHJlcG9y
dGVkIGJ5IEdFVF9JUlFfSU5GTywgYnV0IGl0DQo+ID4gPj4gc2VlbXMgdmFsaWQgdG8gZG8gc28u
DQo+ID4gPg0KPiA+ID4gRG8gd2Ugd2FudCB0byBrZWVwIHRoZSBjaGVjayBvZiBwb3NzaWJsZSBm
YWlsdXJlIGZyb20ga2VybmVsIChlLmcuLA0KPiA+ID4gLUVGQVVMVCkgYW5kIHJlcG9ydCB0aGUg
ZXJyb3IgY29kZSBiYWNrIHRvIGNhbGxlcj8gTWF5YmUgbGlrZSB0aGlzLA0KPiA+ID4NCj4gPiA+
IHN0YXRpYyB2b2lkIHZmaW9fbXNpeF9lYXJseV9zZXR1cChWRklPUENJRGV2aWNlICp2ZGV2LCBF
cnJvciAqKmVycnApDQo+ID4gPiB7DQo+ID4gPiAgICAgIC4uLi4NCj4gPiA+ICAgICAgbXNpeC0+
ZW50cmllcyA9IChjdHJsICYgUENJX01TSVhfRkxBR1NfUVNJWkUpICsgMTsNCj4gPiA+DQo+ID4g
PiAgICAgIHJldCA9IGlvY3RsKHZkZXYtPnZiYXNlZGV2LmZkLCBWRklPX0RFVklDRV9HRVRfSVJR
X0lORk8sICZpcnFfaW5mbyk7DQo+ID4gPiAgICAgIGlmIChyZXQgPCAwKSB7DQo+ID4gPiAgICAg
ICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIC1yZXQsICJmYWlsZWQgdG8gZ2V0IE1TSS1YIElS
USBJTkZPIik7DQo+ID4gPiAgICAgICAgICByZXR1cm47DQo+IA0KPiBZZXMuDQo+IA0KPiA+ID4g
ICAgICB9IGVsc2Ugew0KPiA+ID4gICAgICAgICAgdmRldi0+bXNpeC0+bm9yZXNpemUgPSAhIShp
cnFfaW5mby5mbGFncyAmIFZGSU9fSVJRX0lORk9fTk9SRVNJWkUpOw0KPiA+ID4gICAgICB9DQo+
IA0KPiBObyAnZWxzZScgcmVxdWlyZWQgaGVyZSBzaW5jZSB0aGUgZXJyb3IgYnJhbmNoIHJldHVy
bnMuDQoNCk9oLCB5ZXMuIFdpbGwgcmVtb3ZlIHRoZSAiZWxzZSIgYW5kIGp1c3Qgc2V0IHRoZSDi
gJ1ub3Jlc2l6ZeKAnCB2YWx1ZSBpbiBuZXh0IHZlcnNpb24uDQoNCj4gDQo+ID4gPiAgICAgIC4u
Lg0KPiA+ID4gICAgICB0cmFjZV92ZmlvX21zaXhfZWFybHlfc2V0dXAodmRldi0+dmJhc2VkZXYu
bmFtZSwgcG9zLCBtc2l4LQ0KPiA+dGFibGVfYmFyLA0KPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgbXNpeC0+dGFibGVfb2Zmc2V0LCBtc2l4LT5lbnRyaWVzLA0KPiA+ID4g
dmRldi0+bXNpeC0+bm9yZXNpemUpOw0KPiA+DQo+ID4gSW4gdGhlIHRyYWNlIGV2ZW50LCBwbGVh
c2Ugb3VwdXQgaXJxX2luZm8uZmxhZ3Mgc2luY2UgaXQgZ2l2ZXMgbW9yZQ0KPiA+IGluZm9ybWF0
aW9uIG9uIHRoZSB2YWx1ZSByZXR1cm5lZCBieSB0aGUga2VybmVsLg0KPiA+DQo+ID4gPiAgICAg
IC4uLi4NCj4gPiA+IH0NCj4gPiA+DQo+ID4gPj4gSSdkIGV4cGVjdCB0aGlzIHRvIGhhcHBlbiBp
biB2ZmlvX21zaXhfZWFybHlfc2V0dXAoKSB0aG91Z2gsDQo+ID4gPj4gZXNwZWNpYWxseSBzaW5j
ZSB0aGF0J3Mgd2hlcmUgdGhlIHJlbWFpbmRlciBvZiBWRklPTVNJWEluZm8gaXMgc2V0dXAuDQo+
ID4gPg0KPiA+ID4+DQo+ID4gPj4+ICsgICAgfSBlbHNlIHsNCj4gPiA+Pj4gKyAgICAgICAgdmRl
di0+bXNpeC0+aXJxX2luZm9fZmxhZ3MgPSBpcnFfaW5mby5mbGFnczsNCj4gPiA+Pj4gKyAgICB9
DQo+ID4gPj4+ICsgICAgdHJhY2VfdmZpb19tc2l4X3NldHVwX2lycV9pbmZvX2ZsYWdzKHZkZXYt
PnZiYXNlZGV2Lm5hbWUsDQo+ID4gPj4+ICsNCj4gPiA+Pj4gKyB2ZGV2LT5tc2l4LT5pcnFfaW5m
b19mbGFncyk7DQo+ID4gPj4+ICsNCj4gPiA+Pj4gICAgICAgcmV0dXJuIDA7DQo+ID4gPj4+ICAg
fQ0KPiA+ID4+Pg0KPiA+ID4+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9wY2kuaCBiL2h3L3ZmaW8v
cGNpLmggaW5kZXgNCj4gPiA+Pj4gYTI3NzFiOWZmM2NjLi5hZDM0ZWM1NmQwYWUgMTAwNjQ0DQo+
ID4gPj4+IC0tLSBhL2h3L3ZmaW8vcGNpLmgNCj4gPiA+Pj4gKysrIGIvaHcvdmZpby9wY2kuaA0K
PiA+ID4+PiBAQCAtMTEzLDYgKzExMyw3IEBAIHR5cGVkZWYgc3RydWN0IFZGSU9NU0lYSW5mbyB7
DQo+ID4gPj4+ICAgICAgIHVpbnQzMl90IHRhYmxlX29mZnNldDsNCj4gPiA+Pj4gICAgICAgdWlu
dDMyX3QgcGJhX29mZnNldDsNCj4gPiA+Pj4gICAgICAgdW5zaWduZWQgbG9uZyAqcGVuZGluZzsN
Cj4gPiA+Pj4gKyAgICB1aW50MzJfdCBpcnFfaW5mb19mbGFnczsNCj4gPiA+Pg0KPiA+ID4+IFdo
eSBub3Qgc2ltcGx5IHB1bGwgb3V0IGEgIm5vcmVzaXplIiBib29sPyAgVGhhbmtzLA0KPiA+ID4+
DQo+ID4gPiBXaWxsIGNoYW5nZSB0byBhIGJvb2wgdHlwZS4NCj4gPg0KPiA+IEkgd291bGQgc2lt
cGx5IGNhY2hlIHRoZSBLVk0gZmxhZ3MgdmFsdWUgdW5kZXIgVkZJT01TSVhJbmZvIGFzIHlvdSBk
aWQNCj4gPiBhbmQgYWRkIGFuIGhlbHBlci4gQm90aCB3b3JrIHRoZSBzYW1lIGJ1dCB0aGUgaW50
aWFsIHByb3Bvc2FsIGtlZXBzDQo+ID4gbW9yZSBpbmZvcm1hdGlvbi4gVGhpcyBpcyBtaW5vci4N
Cj4gDQo+IFRCSCwgSSdkIHN0aWxsIHByZWZlciB0aGF0IHdlIG9ubHkgc3RvcmUgdGhlIG9uZSBm
aWVsZCB3ZSBjYXJlIGFib3V0IGFuZCBhdm9pZCBhbg0KPiBleHRyYSBoZWxwZXIsIHJlZ2FyZGxl
c3Mgb2YgaG93IHNpbXBsZSBpdCBtaWdodCBiZS4gIEV2ZW4gaWYgd2UgZXZlbnR1YWxseSBhZGQN
Cj4gbWFza2luZyBmb3IgTVNJLVgsIHdlIGNhbiBzdG9yZSBpdCBpbiBsZXNzIHNwYWNlIGFuZCBt
b3JlIGFjY2Vzc2libHkgZGVjb2RlZCBpbg0KPiB0aGUgVkZJT01TSVhJbmZvIHN0cnVjdCB2cyBo
ZWxwZXJzIHRvIGFjY2VzcyBhIGNhY2hlZCBmbGFncyB2YWx1ZS4gIFRoYW5rcywNCj4gDQoNCkdv
dCBpdCwgdGhhbmtzLA0KDQpKaW5nDQoNCj4gQWxleA0KDQo=

