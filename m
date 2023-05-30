Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9451371593C
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 10:58:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3vBc-0008Ke-1i; Tue, 30 May 2023 04:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q3vBZ-0008KB-UG
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:58:33 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q3vBY-0001xS-52
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685437112; x=1716973112;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JQvovoz9wvrhyyR7m/2VLmdzvbFViE9bsuVDLpuF2DU=;
 b=Y0UDzt00QEP5XfK5WM7YGePnHtdZOTf6CxO70tnl5kNsg7SNeGo+s1Ak
 M21HeFkUUNGXG+SJHabj1PmKefP1+Arc2IBUWtAnxKScrAM1utQ0yVpUe
 oGmpehuAxRHJ4+kijI1eWcTcl3WbMAbuVpqzNq/jLBDgV+YOchKRepsLd
 g/N+rWAPl47htfyJn4hleglAXnIscUnefeUdJBEeFTKb6DyJfqaqzdL73
 d1g5t4JFzfVGBuDHvQweUsEO18RODB7+uPCgmoybENN7CEUimqNvqJggn
 nWhjlJOyM1MHKg29LkbggsNnDFh40KZNyg77MhAMl+93QWqlSYIFn9U2J Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="334480671"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="334480671"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 01:58:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="700537420"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="700537420"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga007.jf.intel.com with ESMTP; 30 May 2023 01:58:29 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 01:58:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 01:58:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 01:58:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHf2lKivgMIMzTnGGyYBn0GuuTPxQHhiVH6jxcIpIWJ4qAFs763p4ytewWtH2/crULPzdcZLzrsgzfJQ5q5mroz1jVtW20JN4YAB4LxIwVjoiXRIJ/TVLXmon7/L09TvnvUTuF+U6B/Tmf4PDb+t5PEtTcBeiQDugngE5DyRjr2xOPQis6r6s0UPLR9VJk+DMNeGuxDEyUvC77RQTnen6kjmn5FWK9WsuNtd2EhUrgy3SxfakFEHmyRSpNuwKTtTpguLS5ttDhK5exxkgQCWM/wMu0QPBLpSNoqmijw6CbWgeCKcK1akKoknrIWrRhjQgzYTMPpz6lUejCi+eurirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQvovoz9wvrhyyR7m/2VLmdzvbFViE9bsuVDLpuF2DU=;
 b=UJTcY2ehXfrmiPOwxOeLlRB3GOv5CML3PHn0HSSyGUlc+su1caw8YFWYuReIrqDtbp2tTGlLwPK5n/r9gxB6nrvq0C92j+nt0l050IxuuX+K3JWw6y5KnGjN4dCL9ogd6TMpxVuVntzkXFMiggdpwV4tp3BlszxMRqr3/wEOxMoIglYg+KHWrcdbdMd48FlfN4ek9fL879cAvKmHJzu5p6xDyM9HKqvwcCl9RHY823DYGempa9ch6jTU1rUR1zdN5uaCIxMLSoXHwYqB7M1XivpXLq6IGZOZrgX3bmE834bkGWWVXVho+ViNFhTJ8UyRJCeri0iI86Ap4pSKGd7J7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 SJ2PR11MB8421.namprd11.prod.outlook.com (2603:10b6:a03:549::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.22; Tue, 30 May 2023 08:58:26 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6%7]) with mapi id 15.20.6411.021; Tue, 30 May 2023
 08:58:26 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "armbru@redhat.com" <armbru@redhat.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v1] migration: fix migrate_params_test_apply to set the
 dest param correctly
Thread-Topic: [PATCH v1] migration: fix migrate_params_test_apply to set the
 dest param correctly
Thread-Index: AQHZjhYa7hgK0hnt5Ey8I2oBcOKhkK9tG6+AgANx4kCAANIUAIAAx9NA
Date: Tue, 30 May 2023 08:58:25 +0000
Message-ID: <DS0PR11MB63738A069EA93BB34EB091E1DC4B9@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230524080157.530968-1-wei.w.wang@intel.com>
 <ZHEpYQ01D7O3MQqM@x1n>
 <DS0PR11MB6373304AA3B38CBB22D22BADDC4A9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZHS9YgSA5Jggd7ay@x1n>
In-Reply-To: <ZHS9YgSA5Jggd7ay@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|SJ2PR11MB8421:EE_
x-ms-office365-filtering-correlation-id: 189ccf86-943d-4264-04b0-08db60ec076c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fFD3PTsSObSXSVa/dJFNMlqdMP5IHZvRKeerfU93m8hn1WRVX11NM7HNmzxsdjT5bN7G4IGWuZL5xdcY8UYNx+LYAnCEXdJsyNeP4yumubMQBlnNMlECddPWWlnBvks41azh6PImGu5eCb/hc1MJtYtKElz0enCLoAhFizeMochGB4woOdqYY5uguKiqfCkY+vq7WPadxOUtxu0/tVq2PziWrDNyQxd7RKpjal/Jq3LhJ4lJd2JvO7Uqcj4EQE+8IcZ3m2zENp57YAeBgmYm4zMjN/CL0ykhBLN3dUvaPnIVcFKOrQjxWtIEQboijxQJkCcc2j0iQgetNdAcaGsqjrPT++Sd569vvJJ8GPFx7hc2A+OrHeoDVUGuhN/gwIIy0SQn2dQxr80e+RE/Y9yJhWugIEH74zu5vF6q9Kj7lN9ZPKDbjPbrySDhTlNGiWNR30zb+0osP9SFf6mWYbEDkr+x7anb/FWPrWCTPa9MZCoqRvHXicCbIX3FJLghDhBSZncpo3C8gvjaHLnQQFTqX4+jShd/ozoxavZ0RdMgD97w+fbK1SB8KS8dkEXuVd+bAivJmv1gKQQMOEyzUR3+mNK6QhhR4zp2ef/owQkHEPoyXAl8gRIX80lC2QQ2UjOS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199021)(122000001)(38100700002)(41300700001)(316002)(38070700005)(82960400001)(6916009)(4326008)(33656002)(71200400001)(52536014)(86362001)(7696005)(4744005)(2906002)(8936002)(8676002)(66946007)(76116006)(9686003)(53546011)(66476007)(64756008)(66556008)(66446008)(54906003)(6506007)(26005)(478600001)(5660300002)(186003)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vk45RjU4SWlEdy96bkN6WDZxb0NMUW9vMllxUkJJaUdHZ05WcHkzTGNKY1dL?=
 =?utf-8?B?YStkS1hGTUJkeUx3bTIxOHhlcEdid1pXVjZ0aTZuNVQ2L0QvY2k1SGdSdUt0?=
 =?utf-8?B?bk8vRldDc3hMNGhOVXZPdGhid1lxbmVrc2oyNndudFJHYmRCNnBpZERFcDNu?=
 =?utf-8?B?MDFmRkduNWhSWmlnZ0ZZdlRmU3cxV3lsT1hjcVBObHl4cEdJNWtPd0lRS1lG?=
 =?utf-8?B?M2R5SjhHcVFTVUpHbXBiWHR1MjdvcDRhSWJjdlZGVkZZeTUvQXhSMldWRkgy?=
 =?utf-8?B?K05IWi9qV3l5akFXWjNobC94b29hRTc5MnlUMCtIdkdadStFaDl3MUZ3TUpi?=
 =?utf-8?B?aEp3dzQyWk5aMHZwemNkcFZHUXlVTjZXNW5lUmlQNFMxcExsSzM1N0FvTngz?=
 =?utf-8?B?SWQ4MzVBK3o3VmRWekZlaGZ6T25TOHJmY1VYbTM2QUxra2t3ZFBpZGxwdjlv?=
 =?utf-8?B?VWtCbmVxYkQwYmYrSllkK1BoTlVTK2QxZ0h3OWJLcGNiTkp4bzRwMUFCZmYv?=
 =?utf-8?B?NjlPRGd2dE9taXlzcmZic0V6WXdhTi9oKzBZYWVZQU5JdEtBWFNUa3c5bzly?=
 =?utf-8?B?TytVVWIxRWxJQW53NldJN2p2SVh4blhGSHd4MmFVcHFjaE9YZDJubCs5Uk81?=
 =?utf-8?B?ajh1bDd0YmJTZWdOTjFRb3UvTkYrYTc1YjdIZUI2eTJBZGZuTU5sM2ZDQk1x?=
 =?utf-8?B?V012czlGWXVMU2M2dnBweEhlS1FtOFNLaTE2S3kzcDhWSGNYemRYaWFBV0dt?=
 =?utf-8?B?bU5LZklnZ1hLRTlHMGZxOHJXWWFtZDNScTJuZjB4UXBSdU5mZytzSmIwZzBM?=
 =?utf-8?B?b3MycDVtWGxFOTkzR0lWWUw2TDBZblAvRW9ONTJHa2lWNkdXSXFaSWFydzBR?=
 =?utf-8?B?bFR2VzdoQ2JNZlVWWm9wYittVnViT3VqUm5oMitJZ0ZnM1hkdWd5d2VmdVhH?=
 =?utf-8?B?aVpjM1FiVjljR2kzeExLMCtvOUhXeGhycWJFYTJhTzR6R29KUmxBZGpXQmVk?=
 =?utf-8?B?TmE1WkUraklQS2VsN2pteTY1dmUvTlRmTjBkbitsQldxU0VMVE1hUURJMGxC?=
 =?utf-8?B?bjU4bG1NZmhDRmxPa1JubDlOclVGQVZtQ1lFWmY0bjM5dWJEQktweWQyanFO?=
 =?utf-8?B?OHg4Z2g3YTNRdHgwWXhtUktHY2xKZU1mbGFRRE1NYmtzNU9kbEN2MzBTbm13?=
 =?utf-8?B?TDI3STBUclY4bCtqaTRVUlVyK0pmNFNGdnZ0a1Z4K1FSOWpwUnI3UDVLRkFa?=
 =?utf-8?B?MUdFZmJnYWpJNHFCN2RlQmVQUDRpOGxkTUFORm5Mc2cwT0Z3czNRSHJNanJM?=
 =?utf-8?B?OE9tQlR4SittaVdsYWk2YmNrcUR2RTZRTFlCQlE2eWNUTWJxWndqV01ITDJZ?=
 =?utf-8?B?WXozYzRtUEFLNkhmbDRxa1ozSG9mWE5XZk5ZcnR6ajlpcjdHWnp2WndRbUxL?=
 =?utf-8?B?MXdhTHVOOWRwa1hCdnJpVVRmTXVmNmZ0dWR2YzAwZHhiZmNvM2p6RTBhZ3dL?=
 =?utf-8?B?d3FDeEhUWEtTbFBBN2VCOHQ5L2Z6KzRaYkl2UGZVQklsODZTNVRUeGVIYTNZ?=
 =?utf-8?B?dEVIbkNSbm5WbThlZ3p2emcyTldSWFBDcEJtTlM1cEFMMStEVTJzamJaLzVi?=
 =?utf-8?B?WUhkRERHZFR6UkovQWNOckEwNXdLWW5lL2hnSHowdmNGYUZ0MEJxYmtSb0tk?=
 =?utf-8?B?cUJtM2hZT0lIL2ttZXd0Y1RJOG5pbWdsa3QvVDlqalFOSFpTL2dMSVErQklS?=
 =?utf-8?B?cDRjUlVubGF1UjF1OEtCWkFmdlk4N3dkZnhOYkNvNTBSaFlERTVTQ250eGRM?=
 =?utf-8?B?SkxWYWI4a0lvclpmZnd0eHFrckxIUXZDRjM1eVFVUnF6N2tqVUNBdHQyUTQ4?=
 =?utf-8?B?T1NGbUxEcTUyN3hIcmx6c1R4QTBMbU1rZTY2cnN6ajFLbFFGNXhjbVNidDJl?=
 =?utf-8?B?Z3hTY1VESXF1TE1LQmQyMGY1anRiRFlzd09MZXNWU0dhSjNkVEhhQlh2ZWZ1?=
 =?utf-8?B?NFdWSWczK3d0NExOeUZ3Q3dLbjBvV2VwT2FRL056WXRqWjhHMFRxQnFpN2xh?=
 =?utf-8?B?ZkJvUTBDeHFGVndMSmFtNm8vU1h1WTFFUmI5VEFBc2wyTktrZ2JRMGxnV2Jn?=
 =?utf-8?Q?fcvav2ZGU3sEx8YHyaTneu9g4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189ccf86-943d-4264-04b0-08db60ec076c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 08:58:25.5929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DXiI/eldc2FvYzJto6hbv1wGwG7JSyfWKrvGqVqHTQFJdTBL126CsZQjvyHBZ6w1s7x8jDZf//GreEVOqQR/Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8421
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136; envelope-from=wei.w.wang@intel.com;
 helo=mga12.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

T24gTW9uZGF5LCBNYXkgMjksIDIwMjMgMTA6NTggUE0sIFBldGVyIFh1IHdyb3RlOg0KPiA+DQo+
ID4gIzEgICAgbWlncmF0ZV9wYXJhbXNfdGVzdF9hcHBseShwYXJhbXMsICZ0bXApOw0KPiA+DQo+
ID4gICMyICAgaWYgKCFtaWdyYXRlX3BhcmFtc19jaGVjaygmdG1wLCBlcnJwKSkgew0KPiA+ICAg
ICAgICAgLyogSW52YWxpZCBwYXJhbWV0ZXIgKi8NCj4gPiAgICAgICAgIHJldHVybjsNCj4gPiAg
ICAgfQ0KPiA+ICAjMyAgbWlncmF0ZV9wYXJhbXNfYXBwbHkocGFyYW1zLCBlcnJwKTsNCj4gPg0K
PiA+ICMyIHRyaWVzIHRvIGRvIHBhcmFtcyBjaGVjayB1c2luZyB0bXAsIHdoaWNoIGlzIGV4cGVj
dGVkIHRvIGJlIHNldCB1cA0KPiA+IGJ5ICMxLCBidXQgIzEgZGlkbid0IHVzZSAiJnRtcCIsDQo+
IA0KPiAjMSBpbml0aWFsaXplZCAiJnRtcCIgd2l0aCBjdXJyZW50IHBhcmFtZXRlcnMsIGhlcmU6
DQo+IA0KPiAgICAgKmRlc3QgPSBtaWdyYXRlX2dldF9jdXJyZW50KCktPnBhcmFtZXRlcnM7DQo+
IA0KPiA/DQoNClllcy4gU29ycnksIEkgaGFkIGEgbWlzdW5kZXJzdGFuZGluZyBvZiB0aGlzIG9u
ZS4gQWxsIHRoZSBoYXNfKiBvZg0KdGhlIGN1cnJlbnQgcGFyYW1zIGhhcyBiZWVuIGluaXRpYWxp
emVkIHRvIHRydWUgYXQgdGhlIGJlZ2lubmluZy4NCihJIG9uY2UgZHVtcGVkIHRtcCBhZnRlciBt
aWdyYXRlX3BhcmFtc190ZXN0X2FwcGx5LCBpdCB3ZXJlIGFsbCAwLA0Kd2hpY2ggZHJvdmUgbWUg
dG8gbWFrZSB0aGUgY2hhbmdlcywgYnV0IGNvdWxkbid0IHJlcHJvZHVjZSBpdCBub3cNCi0gdGhp
bmdzIGFwcGVhciB0byBiZSBjb3JyZWN0IHdpdGhvdXQgdGhpcyBwYXRjaCkNCg==

