Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2766B7084C0
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 17:19:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzfNs-0003wZ-2Q; Thu, 18 May 2023 11:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1pzfNq-0003pV-8y
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:17:38 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1pzfNm-00024h-SC
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684423054; x=1715959054;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=r2IvxCTKHFhloW1BYtLIzDA2NPOLs1Sxew61zfzmNxg=;
 b=nxnqCo3z3uro4nB5UAV0ct2j3kLCCvIO6sq2bap0H0ZbKv8tnGpJ8xYe
 7WzwOK/DeGKWu8N0ncXK+4ptN8Qg5B4xLjHXapw6Zr/l5L6T6wwxjwczr
 teY6Vk0v6dJEKTBvy5vPwzZ4aiFxRtZvQJm0YGI2a7L1+IMmU0ZlvC+6v
 K28OM/ncfIzQpoc5zauOIs3bAgJniVEXzWlIsQT2UPH0QsQ5HToQUSTap
 JsZxvBCzHGlIR5pVvcPhy50JhCDcq9P3V87sPC3WmE4vB0vi7pSYP5OYz
 1eGn//KtYVJs3Wh5pYauKpCHng8HSuDJrtyR6BgqJPJEKWOlA7rsgw+lS g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="380305909"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="380305909"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 08:17:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="826417326"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="826417326"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga004.jf.intel.com with ESMTP; 18 May 2023 08:17:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 08:17:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 08:17:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 08:17:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 08:17:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpQniisTfKJeGHKmQuQTPNsHRTZsQvPgrZ82L78wK7obS2LGSciTIuKq77x28gsmsBWVv/bckbd5tL9qPYYpklAoB18ztwH6a0EuPWH70juD6n8TPiKJPj5qy7u+WI+gs6/OIC4kI0AaSNRVJ60lnoOzJ2cFH/aumb0n+Yyty1OG0Uz2pCMtM/8dXydPX1f1P7cASqJg7UNeymajaAmUMmCAi4mxDOIoOqRDcbUfvlfcFDOdhr3ATSKW5577Qy6gN/QdRTdR1GBQETQ4wUlWGXYSJN87h0+z03WuAgHW0ciJk5Rd9zlb73H8ipAS8B2tyiLscit+y6bbE84WJhiyLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2IvxCTKHFhloW1BYtLIzDA2NPOLs1Sxew61zfzmNxg=;
 b=dZUE4q9uZJTASNOBpfwOknJhr9MUaaDi9Gd7OV9KTAkiJeGd/DEumimjkRcgoAnTLxrqqvadvSoWnCD8heMd7X4bMYqpA7VGzP+2CA7Ogl+xe8nWtXr99DbdMLMFsWU/pTo7WXC8t/YsG0EHDRm0amKEuAxYcyrky1gMHWhafmkHz4u1LtJik8T/W2DbmvjFFUK8+h886ugCRkCyYcxet6vJ1d5LYgvaVk2cHcUswvluO76aqthYwEeiCHs/wH/nK8rV7+w5P0p7J9BbQNGseZ7dsP9oM7FP6alhZoiMEQggSl1zgDxDCN8IBUymTxyaEmg7GcVs1S7EJQdOhFUoWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 SN7PR11MB6899.namprd11.prod.outlook.com (2603:10b6:806:2a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.35; Thu, 18 May
 2023 15:17:08 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6%6]) with mapi id 15.20.6387.022; Thu, 18 May 2023
 15:17:08 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: "quintela@redhat.com" <quintela@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuQmVycmFuZ8Op?= <berrange@redhat.com>
CC: "Wang, Lei4" <lei4.wang@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: RE: [PATCH] multifd: Set a higher "backlog" default value for listen()
Thread-Topic: [PATCH] multifd: Set a higher "backlog" default value for
 listen()
Thread-Index: AQHZiWYZ7y7VWW++XEaEtTpWSpii1K9fvHdAgAA5mQCAAAOjUoAAKaGw
Date: Thu, 18 May 2023 15:17:08 +0000
Message-ID: <DS0PR11MB6373526303940FC5D9892BABDC7F9@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230518085228.172816-1-lei4.wang@intel.com>
 <DS0PR11MB6373D659BCA67BD75D8ECC5DDC7F9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZGYaOu3F3hsiPj5N@redhat.com> <87a5y1dd55.fsf@secure.mitica>
In-Reply-To: <87a5y1dd55.fsf@secure.mitica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|SN7PR11MB6899:EE_
x-ms-office365-filtering-correlation-id: f584dbb9-b9ea-4d63-a848-08db57b2f226
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y3ogo7DkqUJ2jzHWmDoheTXoOh+YvquqAqmKckEsOwh6y5jlIQmX7mRaQNoTF4X+dPqlJGiWOYxyGWcQxPajD8aU0usm8lqClQOxn+WG84azzXpocSwhTMV+gPXdBSZxeBMPzKgT2sUJCbsktGpWOvO+hiT7NQiWf24W3jdCwc8VM1EyOX6BXqAJyzu/newpzefU1U8HEOM2ygi6S2H1b2N2H10WiKNXGj7w+LpbCrXJG2CHytuUsxdXb7GN9Ti6CGmVrLbhRpVhGjbR+MhkpHJ8Wvsx7B1JqKpEwxfndPbsgyxr4IY400qf2WqE/GqQxjd2hRCtmunRwcAjT8Oa4NiLafHj3gLtv73v7X6IhnC2s4sSMtDR5wOgWEOu2aLnCEPCtz1ZKpLBhjQkU2ylDbdCT0DM2r+Grv+jfKRZ8nI+NprDX2EcIjW4CMHfMhPXkLvXACPA+JySk7t6/L6Ab3cu4v55C5+Vf+bOca/yY8W5TedN+zIIPwRkucjBfJ+UWo34cS3I3HoUM8hWs+tpXRRwot0LlULQ3mUGd9obImPGAkT3IHRobZyqARo9OZoLJ7Kq2fAmJtvv2QqGpeJpjVHYdAsbqKh1aDeS094dbudq/4aKAfec+dHYKMNx0gok
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199021)(478600001)(7696005)(53546011)(76116006)(64756008)(66476007)(66446008)(66946007)(66556008)(316002)(4326008)(110136005)(54906003)(52536014)(41300700001)(71200400001)(5660300002)(86362001)(26005)(186003)(33656002)(9686003)(55016003)(6506007)(8936002)(8676002)(4744005)(2906002)(83380400001)(38100700002)(82960400001)(38070700005)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXAyelZ0di94V1BmT25qVFNQbWNzQWpyK0I2cmdIRHBOZmJjdk9VYjB1TGNL?=
 =?utf-8?B?R3ZZcDlDTDZNU2gyMHdkdlF0NGtHbFlSc0o2L3hHNzBWblFJL3laODlVNUxY?=
 =?utf-8?B?ZFhrOTVYNEZCS2xzNThMRnVjc3NTNGNHWTdkVEUxcTEzcmxENkppazNMVys1?=
 =?utf-8?B?dEFQb29QKzFCNHZFL2lWVlVuWXppOU1kdUNhNWRpUWdwUXA0UWdLUWg5a0ZQ?=
 =?utf-8?B?bHBPSHh2bWE1SERYV3dWbnRWZVU5SDBoamxwem1vMW5ERTFOMzlubnJvRnNi?=
 =?utf-8?B?NHJvNmdjOTZrUERHZGpNcEtWcjhEcGtnTlJiYXF5dStCMHdQYnYvQ0R0OTlC?=
 =?utf-8?B?dFZyeXUwb3lIWW1odE94ZUpvdkZPS1IwVnZjRjBVY0huYlBmTUkzVlBZT2VR?=
 =?utf-8?B?WXNjM1ZaeE1qWGNMR3RXZ3BET2tQY3ZqKzc1cURabndTSlJsSVFuelVTSGFp?=
 =?utf-8?B?SDdUMkVBcFREZUFuYlBVUHZ5ajFWdnM0bzZoMWJHQnhYelZiaGtadjAraGla?=
 =?utf-8?B?YWRySHQrMUduSlMrZ1hNWlh3a2lkbXZhU2FWTTVXb29ja0M2ODYyOFhuQjBC?=
 =?utf-8?B?K0xsZ25ndklMVGpYdWQzOTI0UkhiSWJteW51cU1YSnRvaDZoVkczTHI0dlZC?=
 =?utf-8?B?MW0wTVFSL0dLWFJLRFltNUQzczQ1R2hoTkZBVGFMeC9BN0RLMG45dVAyZDcx?=
 =?utf-8?B?R0lySkc3VjAvRnVGUTZscHIxMlJtSllST3c3dGpSZWVUQWgyOXllYy9yeGFV?=
 =?utf-8?B?N1pJcGowbEVjTmY4UVVZRUs0THNxNDAvOWM2aTZudDJ4bDdtNU82VHhCelBZ?=
 =?utf-8?B?bTZYd0Rkb05zcFhPeWU2ajYwVnptbFVpWlRKRmJib0VQbG50VDB1N2hJUElo?=
 =?utf-8?B?UWtreXpSRmM2eUwzQTRxRUF3dHBXVUtsbXJTYVZxMlNJM2lHajJINURITVFy?=
 =?utf-8?B?U05lNTloNWtQbEt3TC9YZVZSNkFBczJxbm9qRW9LMVFQek4rRG5iR3F5STFF?=
 =?utf-8?B?UU9kUU0xRCt5VWJBOE9uM09xdFAxcG0ySTBZVFpyMUdzck83TkFPS2ZCdUJS?=
 =?utf-8?B?ekk0RlFObkFBRnU5VWxlQy9Ta2pTSFVEVVB3Y1hzUS82SUFRUlY1V3psdnNX?=
 =?utf-8?B?UmJ2TmZHUEp5Rzg0d0RLdGFEUVl3SW5iMk5JRXMyN3RHSlduTndFdE9Vbktw?=
 =?utf-8?B?bVBmRWxCcG1BdDJ0aUJOaVE1cThDSW94NGU5Q2RvWTg3ZXBnem40aTBkYzBW?=
 =?utf-8?B?dDNLVkl4djVsYjdZM1dqSUNjaFZpZnNQV2tVK3VYSm9uNHBVbjNpRGpRcmVZ?=
 =?utf-8?B?eTVSWGx2dWJ5V2RDaUZ2UXBaT2xoZmxZNUh3UnRVOWJHNlhOd3JQdi9SZlRi?=
 =?utf-8?B?RlBNWE9jT3EyenlDKzJZb05RdDJEZVpzajJvRk92Wkx1ckdiUkVpbGx4N3ht?=
 =?utf-8?B?V0laVFRESExRRkJqQWFiMUp2QTFUMGU1ZFB5V0pueGF4emxDMitlbWtOQ1M0?=
 =?utf-8?B?eE8rYnNlUWhHQnlmLzA3UGFwM2VadDQ0VlpXaGgyVEdQYTJDK2hqdEZ3MFZm?=
 =?utf-8?B?USttemdQTTR0QlNHTDQ1WmFOb01rbWpmNFdvM1BOYVZFUXVuT1BUY0REZUNJ?=
 =?utf-8?B?YWJtbGR1Q2RqOGtDYXBRWjBla3B0TFF5WTRjc3dYTllrcnoyeFRrOVlEWTQ4?=
 =?utf-8?B?bTdueHNVZXFFQzRZUkhlNFlxV09JYnh2a1o0Tmt6dXdwSVd5V1l5endueU82?=
 =?utf-8?B?ZWZHZDMrcENCUzdOblRPNzZOUXdoaXBwN3EwSHR5dzZEa1FFY09TaHEraC8r?=
 =?utf-8?B?NUsrUHU5OE4wWlVvamRtZlAwa0xXRkVLZURXT2JFT3JjUXg2R3RKRUNIYkw4?=
 =?utf-8?B?blhZazU1WE45OGZwWUp6Y25LUVExME9waTdpWTN4a0dTWlhFRXJ2MmdOZ0sr?=
 =?utf-8?B?NnVhbE54UXpJa3BFVjFUMjRwbytjNVlscDlLanNKUnl2ZG1objBiOEorT2xF?=
 =?utf-8?B?U3FPUHRlUUowOGVBN3RkVVR5Y0lpemlKSVE0cnMrZXVMM2NGbVFYREFMakhF?=
 =?utf-8?B?eXp3NTdRNHVvV25UeDRzSmtFUTRlbXlpamhwdnBqdWZ2K09KR1lMZ1dFYVlY?=
 =?utf-8?Q?K4JNrphgK3/ffXGlivmH1FQrE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f584dbb9-b9ea-4d63-a848-08db57b2f226
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 15:17:08.1173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wa1ecyQdsnC+k1guuC7gR9PcJDZ46Cn74bIajXhIG1zYdbU8qG+WO5q5aqpo36ugf8Hi3/Qq3tnh9wPM4LNTQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6899
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.88; envelope-from=wei.w.wang@intel.com;
 helo=mga01.intel.com
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

T24gVGh1cnNkYXksIE1heSAxOCwgMjAyMyA4OjQzIFBNLCBKdWFuIFF1aW50ZWxhIHdyb3RlOg0K
PiANCj4gDQo+IEFyZSB5b3UgdXNpbmcgLWluY29taW5nIGRlZmVyPw0KPiANCj4gTm8/IHJpZ2h0
Lg0KPiANCj4gV2l0aCBtdWx0aWZkLCB5b3Ugc2hvdWxkIHVzZSAtaW5jb21pbmcgZGVmZXIuIA0K
DQpZZXMsIGp1c3QgY29uZmlybWVkIHRoYXQgaXQgd29ya3Mgd2VsbCB3aXRoIGRlZmVycmVkIGlu
Y29taW5nLg0KSSB0aGluayB3ZSBzaG91bGQgZW5mb3JjZSB0aGlzIGtpbmQgb2YgcmVxdWlyZW1l
bnQgaW4gdGhlIGNvZGUuDQpJJ2xsIG1ha2UgYSBwYXRjaCBmb3IgdGhpcy4NCg0KVGhhbmtzLA0K
V2VpDQo=

