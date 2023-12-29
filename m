Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6BF81FD72
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 08:31:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ7J0-0006ea-6e; Fri, 29 Dec 2023 02:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rJ7Iy-0006eS-8O
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 02:29:16 -0500
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rJ7Iv-000638-CQ
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 02:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703834953; x=1735370953;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RtBZZ53HKr941JF5i4oZ4Ll12GTyDmKnmtESq0OeC3M=;
 b=LUa9JoGWAspoTOjyAnEKL4/Dzwe8NRowMXtDkQhZuJE3io8BwalRNGAW
 Ip8zHLdeN10Qr1MfpsEksBdgEwuZ1FhesC2ORWCwl8TIQLCkcyMXE2d5Y
 fL9TUBgv9sJU/qbalXMRYMfAWigXVsqLRZiXYraqz55PVB5s3aA+egRzf
 n/yk7l+YQIFEkEBE+LQyYC1Ym1TedmDMdFysKnGYrbxv+aLEcB3LLvuCO
 6o2CkHHQBWaMkudB54xugJ5k+VgDxT3En5uq26XMo7QSJHrQAOd7FkFFP
 o9sbVkB8d+BjYPRO22aMRlnJ01mjMecuf/cWFpVCD4KzkrqGfsinSeqxi Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="482812161"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; d="scan'208";a="482812161"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Dec 2023 23:28:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="849153905"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; d="scan'208";a="849153905"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Dec 2023 23:28:55 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 23:28:54 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 23:28:54 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 23:28:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cj7ZvTTQW2VT7pIF1p46bb/91nWUivJySXkJyJXab6tGSs0Lu7bV06FB5CiQBI2r8ZfC2msZ79V1+jMlZljg/NQRQHDs85/Brb9BBJOaQ9hSdzepYCWZPZyfdLrH8EaXyb7eiZfFHCcNIcNgfG6HDkeM25iUONrZKU/bjklLZi78NWYt68AKf1husdFPR1rrE2zC9emlapdOQrOyrPwGiBUKkkaxc/YoqnbUESRHdbKmUgCBaokXN9ORTZ5kpofbuggRdTuArVha1cXQbrB1Sg0D9NP6lpC2ZMEjZaLQKG7MasDjuUfIqybcjNS+s0SY5VKpIXXKdnuGWHX/4xd55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtBZZ53HKr941JF5i4oZ4Ll12GTyDmKnmtESq0OeC3M=;
 b=AyBGlv2m/rw9MM/9Ixa+SaosA1as+lw7o52W5tOHi3b++30qS5P9o4QexgG53fwaHykTYTT25TJqz+O5BIp9L6jOWaAunGe7eSLgUj4l9ZqOPV91r1Gk2dTEroJlE8LQKnLOP0by57pOgN0EL57k1kI8hCyK7GQXU9AJc8OK0Gm4jmfgSuFcqpKkzk3sCkuppLwdPKs3nG9UM06WELLh7wwQA4Bb1dVC7fTfrRSo6qmm1i1jwYAKrCiZ8xXvlbdAaz6xi2vBj05hB3Law60xegE2EArQwas8ZBRuaxZ3NFblzYvkxE4a8hQI1JCilOPkwEgQlpFQkarcIq5dF4kapg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 07:28:52 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::cbc8:6370:5df2:b2df]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::cbc8:6370:5df2:b2df%4]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 07:28:52 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, "Kim,
 Dongwon" <dongwon.kim@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 1/3] ui/gtk: flush display pipeline before saving vmstate
 when blob=true
Thread-Topic: [PATCH 1/3] ui/gtk: flush display pipeline before saving vmstate
 when blob=true
Thread-Index: AQHaLkWCo826H0dHXk6+C5zbCXPenLCqBjmAgBXdDFA=
Date: Fri, 29 Dec 2023 07:28:52 +0000
Message-ID: <IA0PR11MB71853BBB32D75EFF40F51B70F89DA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20231204184051.16873-1-dongwon.kim@intel.com>
 <20231213202419.15459-1-dongwon.kim@intel.com>
 <CAJ+F1C+-v7ZG5fFxrbcSEVOSrFEYx6dYYV02FraCOvfcG9sC+w@mail.gmail.com>
In-Reply-To: <CAJ+F1C+-v7ZG5fFxrbcSEVOSrFEYx6dYYV02FraCOvfcG9sC+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SA0PR11MB4719:EE_
x-ms-office365-filtering-correlation-id: 85e5e259-3126-471e-8694-08dc083fcec0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IrVag+Kjwb0YkawJ1CH8DRynbXwTMSi5naMaa6gWVhyUcWEva5x0ecJnE3y5vSOUBBoph1yg8ZRFoBHFcvtgNZi+WOVKwzlw6q7TISG7EZXWikK+XJovdqO1wAt5hhDp3R0dFTnCPWRunQrwUk+Sj5frUH2QIWpj9sAok+8iAB1Tz41PE5M0/SnLsnErYT10vV5NkWz3qIGBUI9+AonZX0p+dfPmfO7LAmljjTzJM/C/6cOSz3DjDeFBFEX+PDsDJZwgwFWIIO5H9ZbxoBQynIHVHDvbF6pniDGrNE09Z2USK+AuPYtDLy4oo1Y7RxaMvIo8V4vtw/zGRhAhdidAJxnsQ8hL10PdayR4DhWDDX6A7tHsbZatp7cv8j1GPEhEOc92h5UVkqr+QW1Rwc0nqkdLvK4nuRiLK1I0oOosOLt/1mtowSWbUHIKRtllNsAttzuZj+1Sap0GfCdfKgX9ZCSNvtWBXicuBppajuDIGFHiBOlCHro90wc9uaB8WWaYpIehKYmc/7HyTKlqroPJRtwVtPlVoXMr/gkCDJ6HKM2ONhlbX9Doz9qktHRl3ISCrJpcVrNwmJ9ziPWJQYQDJ45kOgFmMUVM5FFaMQTMnN8hWJc/iS9e6qxaLzeiAJBF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(39860400002)(366004)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(7696005)(53546011)(6506007)(9686003)(478600001)(82960400001)(110136005)(66556008)(66476007)(66446008)(64756008)(86362001)(6636002)(26005)(76116006)(71200400001)(66946007)(316002)(83380400001)(4326008)(52536014)(8936002)(38070700009)(8676002)(5660300002)(2906002)(122000001)(41300700001)(55016003)(33656002)(38100700002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGdYbWJuNEU3V2MvRFRXeHhsaEkvek1rRGZCcHpWZVI2cEUzMHczcXNKbjVD?=
 =?utf-8?B?YjF4QjlWVXVsdzZiaXVpQ0dkZHV1RWZXRFRMSHB0T05Sa3ExZG9tMUYrc2pI?=
 =?utf-8?B?SG9TanpLNEpFSGJYekNaYnM3d2lFVTV1eTBzT3NJYk5LR2RrQlhIQXhLQlhu?=
 =?utf-8?B?Y2YraEJ5bFZqS05hRnNsc3c4cDR4NEZqcXRUSEVuMGJ6RFZSb0VtdU9lRWJp?=
 =?utf-8?B?eTNSTDErYU9GcG8vSGtURWdiVWd1OXFIbU9OWE9yZGxYdFNIMzNMSUdncHNJ?=
 =?utf-8?B?citIYTJScFpiTFBQMUhSUG02WVdFSXkxbjF0cnh2S21NZVVlcHZXQkJGWDQ3?=
 =?utf-8?B?K1V0T3hBVmJVaDRmc3hieUxVOUdzYVh5UTNRUU4rSSswZnY4aWpjSE1ZcTRx?=
 =?utf-8?B?UTFzQ1RSRTRPU1JjVHgvOUFtb0psc0c3aTdJZGxLTFFZY0g1Q0ducUg4N2Rj?=
 =?utf-8?B?ZUU1QUcwdElqdGNXZXZvc1RTWFhYS2NTMTRzV055Qy8yMXdSZ1g2WXB6cm1C?=
 =?utf-8?B?a3dsRGRQUWo2VCszMERkbUUwSHdPa21kLzZWVWNOOGp4aWZvK0R3L3haZGdh?=
 =?utf-8?B?UEk0aHBBa0Era3VhL1plVGxzYTZQc0NMbklBWldaMDhpYjlKazZIcVg4aUI1?=
 =?utf-8?B?bzNTbE9maldNMUNnNGk0OHdRTEFuckxJVXVtWGV2bDk4RkcwQWpPemhCUExS?=
 =?utf-8?B?dFBYMkw3U1Q4Um1WaWpocy9oenpKSDIzSllOYmRYKzlGd0tROW9Jb0tueVlC?=
 =?utf-8?B?dTl6aWplUENzaDNoektXeFk0M1VRSmJzQzJleU80RVVaUXliSVQ2YmZtOUl2?=
 =?utf-8?B?aWk5N0gwMkUwOE12enc5MTc4UDkvRmQrVy9yWmVZVDlaOU1PZUlJeTgwdS8y?=
 =?utf-8?B?OS8ya1VhYURQeHo5TGVNTGxrS2tEeStJdU5TV2l1ZExtZW1GWWJVczlBZVVO?=
 =?utf-8?B?bjdoRFB0M2JsN2l4S2Y0Wk50OUtpRVZHdk0wN2JFbngzajhTSEgvSW9MTjZu?=
 =?utf-8?B?b0JXUGNVYTZjM0s0eXExeTJPbzBuSTdzWU5hYll1aldXSXBkVmwxTjZnZ0Z1?=
 =?utf-8?B?aWhJa01hZ2ZMUDM4TkN2K0sreUdKSkRFWEg3K2VxK1JDcmdOZmlpM2RabHdn?=
 =?utf-8?B?Yitqa3pGVHJnbExKTVZxU0FWQjhRWWJpN3N5K0lVRkhsM2ZHUjFtV241VkN3?=
 =?utf-8?B?N3FSSXNoYzJQbDZKOStPOTB4WW91TTJIM2svRnh5Nngvc1UraDNwb1RueE1B?=
 =?utf-8?B?RzhRUk5TdTBYazk2bEx6YWlNcHBncWhybTM5Wkt6VnZmbDQrQlU3UTJiVkl6?=
 =?utf-8?B?czZNdnlKQ1VtZHpSb2xLdHAvemhJbyswZ1ZnTnVZclhFUUhZWWIzR3J5Tmpv?=
 =?utf-8?B?ODROanVPMFl0TDZhZCtpR0F2K0d0Q3I0b3FScGRkRlkrc1BWRkJpQ2VobXhy?=
 =?utf-8?B?YTNYR0pucG5LRXFHSjJSWHRJdFRsaW9mc01XdWhxaUpSMEN3b29sWCtTSWxu?=
 =?utf-8?B?cXltNG9ZaEttbHBjNU9DUlQ5NVRhZDJIQ1ArUHBJWlJEeW1UWFMrbThnMzZx?=
 =?utf-8?B?Q3Z2dTN0LzB6RERoTlVMVEhwb1VVZEswc2twUDAwTHBWM0h6cTFETXZqeTEx?=
 =?utf-8?B?eGExSGpaS3BtTmZGN2xhN0p3dFk4NnRvMTlpcmtibUNtK1lmeDdGdC90cmU4?=
 =?utf-8?B?cCtyK09FeDhNL0FRVVJLb0JRS2NOOXp5TTBVaFdUSUVsakFLazhQQyswTXJZ?=
 =?utf-8?B?dnZ1QnpCTVRRUlhKb253ekJxVTZqbnJFVmxtdjFUaFNCQWN3SFpsU2tjSmNn?=
 =?utf-8?B?MVB1MFJxWXZKQTZ2T2IraGM5OWM2VER4ZzFzNnBuSmZRc1hpVWxzWTNEWnMr?=
 =?utf-8?B?dnEvWUxySW5WYUE2c2l3Uy9jK1ZzR24rMHUyRjlqSzNTUm1udzNjem51QmVj?=
 =?utf-8?B?MktMNVNqejMzczdUMExzbmNnNVhNVWZiRXZOUFhteTk1VitXenJrbkFUeU0x?=
 =?utf-8?B?cFRGL3FhNk5zdjNOZ2tkYzF6VXdXbEw5YmdhemRGT0dxcjBHWGtFM3d5bk5s?=
 =?utf-8?B?dFZiR1FWTkpaS0s5QjUrWUFMNWx6RTBYMjUrTzFLSmZ6MDFhazNWcU92M2Rw?=
 =?utf-8?Q?lSHZBz/Tmw2rP8ZnB4zfaOlSh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e5e259-3126-471e-8694-08dc083fcec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2023 07:28:52.3933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrtnSeo2d15cy+r3ycXPfbXPu4wiwus2ACUI/16D2HC2tA+7feT8l5KPQnuivmaEiR442CBAYVDsJqCxH0JvwEPWiCjxD8YFkTxL1uztQyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4719
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.43;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.981,
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

SGksDQoNCj4gDQo+IE9uIFRodSwgRGVjIDE0LCAyMDIzIGF0IDg6MjbigK9BTSBEb25nd29uIEtp
bSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IElmIHRoZSBndWVz
dCBzdGF0ZSBpcyBwYXVzZWQgYmVmb3JlIGl0IGdldHMgYSByZXNwb25zZSBmb3IgdGhlIGN1cnJl
bnQNCj4gPiBzY2Fub3V0IGZyYW1lIHN1Ym1pc3Npb24gKHJlc291cmNlLWZsdXNoKSwgaXQgd29u
J3QgZmx1c2ggbmV3IGZyYW1lcw0KPiA+IGFmdGVyIGJlaW5nIHJlc3RvcmVkIGFzIGl0IHN0aWxs
IHdhaXRzIGZvciB0aGUgb2xkIHJlc3BvbnNlLCB3aGljaCBpcw0KPiA+IGFjY2VwdGVkIGFzIGEg
c2Nhbm91dCByZW5kZXIgZG9uZSBzaWduYWwuIFNvIGl0J3MgbmVlZGVkIHRvIHVuYmxvY2sNCj4g
PiB0aGUgY3VycmVudCBzY2Fub3V0IHJlbmRlciBwaXBlbGluZSBiZWZvcmUgdGhlIHJ1biBzdGF0
ZSBpcyBjaGFuZ2VkDQo+ID4gdG8gbWFrZSBzdXJlIHRoZSBndWVzdCByZWNlaXZlcyB0aGUgcmVz
cG9uc2UgZm9yIHRoZSBjdXJyZW50IGZyYW1lDQo+ID4gc3VibWlzc2lvbi4NCj4gPg0KPiA+IHYy
OiBHaXZpbmcgc29tZSB0aW1lIGZvciB0aGUgZmVuY2UgdG8gYmUgc2lnbmFsZWQgYmVmb3JlIGZs
dXNoaW5nDQo+ID4gICAgIHRoZSBwaXBlbGluZQ0KPiA+DQo+ID4gQ2M6IE1hcmMtQW5kcsOpIEx1
cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KPiA+IENjOiBWaXZlayBLYXNpcmVk
ZHkgPHZpdmVrLmthc2lyZWRkeUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogRG9uZ3dv
biBLaW0gPGRvbmd3b24ua2ltQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgdWkvZ3RrLmMgfCAx
OSArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25z
KCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdWkvZ3RrLmMgYi91aS9ndGsuYw0KPiA+IGluZGV4
IDgxMGQ3ZmM3OTYuLmVhOGQwNzgzM2UgMTAwNjQ0DQo+ID4gLS0tIGEvdWkvZ3RrLmMNCj4gPiAr
KysgYi91aS9ndGsuYw0KPiA+IEBAIC02NzgsNiArNjc4LDI1IEBAIHN0YXRpYyBjb25zdCBEaXNw
bGF5R0xDdHhPcHMgZWdsX2N0eF9vcHMgPSB7DQo+ID4gIHN0YXRpYyB2b2lkIGdkX2NoYW5nZV9y
dW5zdGF0ZSh2b2lkICpvcGFxdWUsIGJvb2wgcnVubmluZywgUnVuU3RhdGUNCj4gc3RhdGUpDQo+
ID4gIHsNCj4gPiAgICAgIEd0a0Rpc3BsYXlTdGF0ZSAqcyA9IG9wYXF1ZTsNCj4gPiArICAgIGlu
dCBpOw0KPiA+ICsNCj4gPiArICAgIGlmIChzdGF0ZSA9PSBSVU5fU1RBVEVfU0FWRV9WTSkgew0K
PiA+ICsgICAgICAgIGZvciAoaSA9IDA7IGkgPCBzLT5uYl92Y3M7IGkrKykgew0KPiA+ICsgICAg
ICAgICAgICBWaXJ0dWFsQ29uc29sZSAqdmMgPSAmcy0+dmNbaV07DQo+ID4gKw0KPiA+ICsgICAg
ICAgICAgICBpZiAodmMtPmdmeC5ndWVzdF9mYi5kbWFidWYgJiYNCj4gPiArICAgICAgICAgICAg
ICAgIHZjLT5nZnguZ3Vlc3RfZmIuZG1hYnVmLT5mZW5jZV9mZCA+PSAwKSB7DQo+ID4gKyAgICAg
ICAgICAgICAgICBlZ2xDbGllbnRXYWl0U3luYyhxZW11X2VnbF9kaXNwbGF5LA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmMtPmdmeC5ndWVzdF9mYi5kbWFidWYtPnN5
bmMsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFR0xfU1lOQ19GTFVT
SF9DT01NQU5EU19CSVRfS0hSLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgMTAwMDAwMDAwKTsNCj4gDQo+IFRoaXMgd29uJ3Qgd29yay4gZG1hYnVmLT5zeW5jIGlzIE5V
TEwgYWZ0ZXIgZWdsX2RtYWJ1Zl9jcmVhdGVfc3luYy4NClJpZ2h0LCB3ZSBkZXN0cm95IHRoZSBz
eW5jIG9iamVjdCBhZnRlciB3ZSBjcmVhdGUgdGhlIGZlbmNlIGZyb20gaXQuIElmIHlvdQ0Kd2Fu
dCB0byB1c2UgZWdsQ2xpZW50V2FpdFN5bmMoKSBoZXJlLCB5b3UgZWl0aGVyIG5lZWQgdG8gcmVj
cmVhdGUgdGhlIHN5bmMNCm9iamVjdCB1c2luZyBmZW5jZV9mZCBvciBkb24ndCBkZXN0cm95IGl0
IGluIGVnbF9kbWFidWZfY3JlYXRlX2ZlbmNlKCkuIA0KRWl0aGVyIHdheSBzaG91bGQgYmUgb2sg
YnV0IG1ha2Ugc3VyZSB5b3UgZGVzdHJveSBpdCB3aGVuIHRoZSBmZW5jZV9mZA0KaXMgY2xvc2Vk
Lg0KDQpUaGFua3MsDQpWaXZlaw0KDQo+IA0KPiBJIHdpbGwgbGV0IFZpdmVrLCB3aG8gd3JvdGUg
dGhlIHN5bmMgY29kZSwgY29tbWVudC4NCj4gDQo+IHRoYW5rcw0KPiANCj4gDQo+IA0KPiAtLQ0K
PiBNYXJjLUFuZHLDqSBMdXJlYXUNCg==

