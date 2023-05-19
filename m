Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 565BF708E63
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 05:34:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzqsV-0005iq-Ro; Thu, 18 May 2023 23:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1pzqsR-0005iZ-Tp
 for qemu-devel@nongnu.org; Thu, 18 May 2023 23:34:00 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1pzqsP-0000MQ-Kb
 for qemu-devel@nongnu.org; Thu, 18 May 2023 23:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684467236; x=1716003236;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rgLCOfXc79ivEgT5X7rRyYxUOJ5nsmJ2SNUXmAbjFSo=;
 b=n3ylHh50+hj6yFBVAOrCyORKzcfXPpFmboyANpkFb60l7qGgU2wOy6pi
 RENJQRWTkKVAwBFDfjf+A6G/BsV9vL3/QR/1cR4NJC+k0PreJcxi6hihz
 DDlNPx71jjt56ZOFLDwm7WDELWc7vuQJdE49RBSTJJ8fcz7+FrMg5bCjA
 evnW+jlVrZubFWjtDjImoWKUuRnpdLlrgMqDfn191g0GQ7u0Du5pEzXJE
 RY6oSWNSMMrVSTCs2NKf4OotaF13nahwtkburr1usYx5WatgmCWBZA8Pv
 dtouetFfHqK0gPa3x4v2x55iCx1SAoVqcfY2be7ymzyyLTu4hmCV0AKIw Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="417960161"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="417960161"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 20:33:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="772144765"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="772144765"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga004.fm.intel.com with ESMTP; 18 May 2023 20:33:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 20:33:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 20:33:25 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 20:33:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjY4tIBCYdWRzZJ/GGEoqupl5m4FGkOB/pUoS3oyaEKE0yMAn8ip+pqXzkPuDoPUef/5656j8DDmfwyNpP8Gegg7UEYBQagaJvp8Aow0gtFMQuXjLtoQyEfJC1CnI6xR7ME/0aWwFS7wz8m55JuOlJh1f3VmEm/kgyXKmznjTXnCtYbSM+Dy/QOvfvRZUrAyoqZCOAw6Bkjxr+aDPXJjaFD+ADcbLyqSf11wZGVdZkliHBQrtiPOvDRmzepFRs1KTPOTcKS0m/LziPGy6lC8Xib7sbOQdO2tuRz8l2qtQTMxkJO0+s3ThQ3vYx6IaFHGD4C6PBIzxuuRbjuJJ4+ZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgLCOfXc79ivEgT5X7rRyYxUOJ5nsmJ2SNUXmAbjFSo=;
 b=A/vLRoBLla4kYCLhRN+JerKftSLNMcizwE6q+lzyO6Go7zQ0NB3RwasGX3w8NBxB+Yk0phUcGk5jqeYD+WdDVLWn16ZsMQO8M1Gs9iroFdUIqmUQWtZ0tWmWNWXYGOg8oRxnvcw1KeEJol7uapVTuuQGMsMo9g2vW/mLwmxbd19CXdjfyxUaEjVfW6x8370UvYJXOXVaR0vw7tNA+wAjgfSUwuaKrf/lf6Mzz9rRXtINZs45gf+HmTkcXGzQym8TOB6CsUTHzRBd8M4d+QBz6Gw4nzTl3NqxXY3W8nRWNxFO5qyQZjfmo5dtdYyNTswl742EVtQlP6BLFW1/UKgjQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 PH0PR11MB5628.namprd11.prod.outlook.com (2603:10b6:510:d4::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Fri, 19 May 2023 03:33:23 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6%6]) with mapi id 15.20.6387.022; Fri, 19 May 2023
 03:33:23 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: "Wang, Lei4" <lei4.wang@intel.com>, "quintela@redhat.com"
 <quintela@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>, "Daniel
 Berrange" <berrange@redhat.com>
Subject: RE: [PATCH] multifd: Set a higher "backlog" default value for listen()
Thread-Topic: [PATCH] multifd: Set a higher "backlog" default value for
 listen()
Thread-Index: AQHZiWYZ7y7VWW++XEaEtTpWSpii1K9fwDbggAEQCACAABIF4IAABJUAgAAG/zA=
Date: Fri, 19 May 2023 03:33:22 +0000
Message-ID: <DS0PR11MB63736463A526A0D1A0D64568DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230518085228.172816-1-lei4.wang@intel.com>
 <87h6saf18t.fsf@secure.mitica>
 <9def6eb4-e317-2b6d-87ab-d0aa34ea3afe@intel.com>
 <DS0PR11MB637345417B81FF5637B2D7D8DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <bc6f6fdb-ebf9-387b-9d56-5c61095a9473@intel.com>
In-Reply-To: <bc6f6fdb-ebf9-387b-9d56-5c61095a9473@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|PH0PR11MB5628:EE_
x-ms-office365-filtering-correlation-id: b040c349-a706-4bcb-0d3d-08db5819cc08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a6s/Jy0e2pZPWNUNNf5Ac7Wk4Pq0Zp6uSpx5r+C60/C4OMa84rk7+nMy/de4GOQITT2dPCarccpyi1DmF2gjP7zA5JsD2ZlmbYBrQoo6Eh0JL/1sS4ZIk36m0w+Qz/wcCtIn6LMK9TaSOGF7EXpNS4diK7qNMD/UI06mQBEHISmWNYGSxFze+LRE3gLbARS069RVSImvVch7zKHHNhSnPg59S5RQgJwGEr4Ip5y8tEigLwtkBHrdunvYQy+cpDGdURIE91qABf4lBJSEVcZtNqrIhw9ci4tznI93FFp6n0R45TRBoSgxK5m/TcwruT5UNTVBcVESB8elm6WSewjWbxREE8rTzVTLagpLcNCKGzP7kpxn5QFRWeBPwchWVYR/WDnPVZaeWZ6QJPFAXnBmAIfy4iLvnpoY9Z32P57f6uLkTfsLQYLyB6tP++mDivlEeHA1+8fHMwEscuzEFU/Cws8Gg0VgcyWWnek1IOnWEyeNZjsqwDGmeAkcHRTifgZ5gQmZNSlGkYm3ZeUykWUIY+5ir9Mw4WV9HIA00kJ0Al4CiIJRFZhcY5aOL5B8nB8zhkyiHQacjHJ+/EIh1ppqsx9S44hPt2uJwUfEdhuDsSgeGliIiGqMkmuF7/nxa5+Z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199021)(76116006)(4744005)(33656002)(86362001)(316002)(54906003)(110136005)(64756008)(478600001)(66946007)(66446008)(7696005)(66556008)(4326008)(66476007)(38070700005)(2906002)(5660300002)(8676002)(82960400001)(55016003)(122000001)(52536014)(41300700001)(38100700002)(8936002)(9686003)(186003)(53546011)(26005)(6506007)(83380400001)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekFPOGFuM2ttZE14aytHY01mWiswWVlTcXBIekc5OHI1Q2xkQjYrVjdzZFZJ?=
 =?utf-8?B?TlFnZWtvMThiMGgxa2hRdzNVM3IxYmZmdWM5ckFQWEFKSk5wN2VxWE1la1Fy?=
 =?utf-8?B?ZVl0UXA0ZU1zakhUeTYyT0ttVlRpL0hKbXhRd0ZVK1l1Y1VkcUc2U2JPMDli?=
 =?utf-8?B?VmRodmZpREg5c1pleklOTlF1bTd4SzZ5SXEwR3RFN0Z3WmhRSzV5b1Y5bk5U?=
 =?utf-8?B?czM3QmZBSFUrSjJoSUo1SXlTT2RQQmZYQmIyc0F0VGgvSjRSTmZ1QWVhRkZj?=
 =?utf-8?B?bHBYcUlqb1F5L2xqaWZCWDFvMVpxQ0lTUFNlWmNHYWVjbGtWZjA4YjJoQjZN?=
 =?utf-8?B?Z1MxQUJnNnNlM25MZXdESk8yeDJrZEEvV1JaSjhWTG0vQzFMaHpNdGhCbHhC?=
 =?utf-8?B?RC9ITzI1SlJhT3F3cEM0V2oyakFNeWkvV2wwZ1QxNC81U2FrZmUrQk02MGRT?=
 =?utf-8?B?MGFXaDlsV3VEUjdGUit0NERUbCs5U0E4UUlVN2dGZndoU05vV3pmL1pJM3Vz?=
 =?utf-8?B?MTA1QklockVNYm5xS0lYU0hKMUlOa1czYmVtSzNpWmN1bW9XQlNzd3JkTmtk?=
 =?utf-8?B?OFRIZWtEYndoVVZzUjlQYXIwbXg1WkI2YVk1V0t5dWdzQTMvb3VZVGNXR2t5?=
 =?utf-8?B?Zlk1cGpoMnViYWx6OHV3RksrZnpDa3dXRENrNCtqOGdwVk1IdE9ON3FTRXhF?=
 =?utf-8?B?bzBYQlIxWTVBNm5vYllndjc0QURtRjAvRDlJTkk3cjEwTWczV0pjRitkc3V0?=
 =?utf-8?B?Y1NGZGpxeDhvM2NPRnIzQWJBWVYxb2RzRTN6Unl4cmpjOUJ4QXNFanBHTHN4?=
 =?utf-8?B?K1NkRjdPVUpLTU9nRDZ1T1NXc0RWTzJ6eEcwQlB1SEk1VHhOcllIcTRneHZx?=
 =?utf-8?B?V0xBMSt6S2hPSmx6eWVmT2xGSk5KTCsrRVlrRXlFTEFTbTlDTThaSlBtemhz?=
 =?utf-8?B?SllvUVVpcGl5Um1rcXk2RDh4bnVzWDFjVnU3cmJTL1FOd3NndXdYZDFGSitU?=
 =?utf-8?B?aUl0Vm5ScVhqVC9Ba3A1RFJhdmRoeCt0VTBLNEI2TUF0V2FrNDZ3SXpTZFdr?=
 =?utf-8?B?dVlRWjBkN3hTN2sycVJ2c25ZbXFvcHN5ODBDdkFpV1Zuamdycm1yS0VzaFRZ?=
 =?utf-8?B?LzYwRGZVSlNnbmw1OE8vWXVHRzBIQjc3VWVNOTV5bXBDNHcvakEvTWFhUGRo?=
 =?utf-8?B?UG5RYWNScHM1T09sT0YwZXRQTzdoU0Q0cnJRQnJQeWZBand1ZTFPdWpoeGFH?=
 =?utf-8?B?RjJBQUwvSktYTWJaME5kZ05xandmL1hlK1pUR0U4UHRLUTBmbWkxNHNOV0g0?=
 =?utf-8?B?MGE1N0t2VTIxMGNhc0pGMzVPOTd1MWpHRWF3MDBzYVd6Z1dnT0MyRzZZSGt5?=
 =?utf-8?B?ZWVSYkpCOFI2bENVcE1EbzhVaUpkaVBTUVBqNFZtTk9NSjVFK2JlTTh2RmpO?=
 =?utf-8?B?MzFzOHhSWUszay95elhFTzdma3phUzc5MHI0RDNwbjk4YWlMcDFyTTRodVI1?=
 =?utf-8?B?VnhnTUwwSWphTWFuVS9ETVUwc0lQL1plVG5Td29CcUUyR01rVjkvcTdaZURt?=
 =?utf-8?B?Qy9XYlBnSXpVYUJ6Y0lMMU45cGtqcE81djEzSVd2OUJVL1hDYTBHVzlOaUNL?=
 =?utf-8?B?RnRYL2w4VlZVQ1BYelFpcVorNmY3aW5BV0ZTVVdGb3B5bFRNL0EwUE5mVlBm?=
 =?utf-8?B?OXJ2dmVwU0hTcWVOL25HZTRFNWJwZHpFZEJCQytDQ25qZXpLY1dSbmNxUXJv?=
 =?utf-8?B?NmVTUmtaQ3pSdlYyQkg5dklVdnc5N1VyKzZ0Y0ovekxXYTRZRzc1aGhyS2pu?=
 =?utf-8?B?MFVtMkZwTHF4MWUrcmE3ZmFKRTFFYUNMdTYzWDRLQ0cvVFdCeU1tMHZvakM0?=
 =?utf-8?B?SFlocnRkUnpac1FxNnpiUTBxdjNqbGVRVFlXYi9WY1dVVlNCcHFKb1Yrb2dl?=
 =?utf-8?B?bEMxcE9KeHdHQlF6Vlpid3FhWjVINUNLODFDSkdHWTJlcEphUThxVExTUnZG?=
 =?utf-8?B?WmtoZ29OMzlCb2U1eUN4ZWNDUEc1TTBOd2gzN294TThnUHVHNFZlcm4zY2pm?=
 =?utf-8?B?Yjlsa2x1NkpxbDJTa2ZKMk9HY2FPRDZGbWFreXlDWDg5RUh1SmVoZE9XK0RG?=
 =?utf-8?Q?DwFu+ZotAPyzlXZL8Z+fRw+fN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b040c349-a706-4bcb-0d3d-08db5819cc08
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 03:33:22.3045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YzwmkymaSo4XiAe4+UjYyGr+knYhezcbOVEhP2a5lpr9VuXeXla3rDCYjHvU/Wl60OW6BKA7SpEhrHOjy4CBzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5628
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=wei.w.wang@intel.com; helo=mga07.intel.com
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

T24gRnJpZGF5LCBNYXkgMTksIDIwMjMgMTA6NTIgQU0sIFdhbmcsIExlaTQgd3JvdGU6DQo+ID4g
V2UgY2FuIGNoYW5nZSBpdCB0byB1aW50MTZfdCBvciB1aW50MzJfdCwgYnV0IG5lZWQgdG8gc2Vl
IGlmIGxpc3RlbmluZw0KPiA+IG9uIGEgbGFyZ2VyIHZhbHVlIGlzIE9LIHRvIGV2ZXJ5b25lLg0K
PiANCj4gSXMgdGhlcmUgYW55IHVzZSBjYXNlIHRvIHVzZSA+MjU2IG1pZ3JhdGlvbiBjaGFubmVs
cz8gSWYgbm90LCB0aGVuIEkgc3VwcG9zZQ0KPiBpdCdzIG5vIG5lZWQgdG8gaW5jcmVhc2UgaXQu
DQoNClBlb3BsZSBjYW4gY2hvb3NlIHRvIHVzZSBtb3JlIHRoYW4gMjU2IGNoYW5uZWxzIHRvIGJv
b3N0IHBlcmZvcm1hbmNlLg0KSWYgaXQgaXMgZGV0ZXJtaW5lZCB0aGF0IHVzaW5nIGxhcmdlciB0
aGFuIDI1NiBjaGFubmVscyBkb2Vzbid0IGluY3JlYXNlIHBlcmZvcm1hbmNlDQpvbiBhbGwgdGhl
IGV4aXN0aW5nIHBsYXRmb3JtcywgdGhlbiB3ZSBuZWVkIHRvIGhhdmUgaXQgcmVmbGVjdGVkIGlu
IHRoZSBjb2RlIGV4cGxpY2l0bHksDQplLmcuIGZhaWwgd2l0aCBlcnJvcnMgbWVzc2FnZXMgd2hl
biB1c2VyIGRvZXM6DQptaWdyYXRlX3NldF9wYXJhbWV0ZXIgbXVsdGlmZC1jaGFubmVscyA1MTIN
Cg0KPiANCj4gPg0KPiA+IE1hbiBwYWdlIG9mIGxpc3RlbiBtZW50aW9ucyB0aGF0IHRoZSAgbWF4
aW11bSBsZW5ndGggb2YgdGhlIHF1ZXVlIGZvcg0KPiA+IGluY29tcGxldGUgc29ja2V0cyBjYW4g
YmUgc2V0IHVzaW5nDQo+ID4gL3Byb2Mvc3lzL25ldC9pcHY0L3RjcF9tYXhfc3luX2JhY2tsb2cs
DQo+ID4gYW5kIGl0IGlzIDQwOTYgYnkgZGVmYXVsdCBvbiBteSBtYWNoaW5lDQo=

