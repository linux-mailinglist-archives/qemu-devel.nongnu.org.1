Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFC370D0A1
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 03:46:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1H4l-0002DL-Ku; Mon, 22 May 2023 21:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q1H4j-0002DB-EV
 for qemu-devel@nongnu.org; Mon, 22 May 2023 21:44:33 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q1H4f-0000Ez-MJ
 for qemu-devel@nongnu.org; Mon, 22 May 2023 21:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684806269; x=1716342269;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vA40w4Wq3LiAH0erOxR4t3t/y6hJp5VWqD/Sl3hMbWo=;
 b=PFbYwDtT0cRytbhCLKNxSUYZisdXFPgbhPXADp5Bh5zmujpjxxdzS6P0
 vhJuizGM0C6/+Cg3fWtYUDSs3ThWgoU0m56cGbPpfD+i3ANcf+82ZYMD9
 1tvjiWCUw8jwfjr33nBlTdlXd4RxmnO3lKjsyjVrVJRGVH0+4IKFZAktN
 4jFrKIYMjEnkmuaajLskkFpPcuJ2QrWS7lP6ZOgtrM7xe5wQGwf1rpQ2E
 XaVJFQaUyxSuU3CVCbnlTnYGPPSeGgUt13nHp+gF2P/DQC/S8ZrxuRjbu
 /H0xfUUeJKOPgJOgYxD9OwJ9bDfW10QpBNRJWimA9GiPdI/Q8iYURWnUA g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="351942742"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; d="scan'208";a="351942742"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2023 18:44:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="1033855324"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; d="scan'208";a="1033855324"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga005.fm.intel.com with ESMTP; 22 May 2023 18:44:07 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 18:44:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 18:44:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 18:44:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoK4myXJHFISUIdox5efFGfF7cOkhJgMgTZLOiQN+RQ/gt+s6UEvtYsf4NVI3xGqBn+l1bey2o4epQdEvrxix1Fo8cuyOE19W7tfpxU6TDCQ9rOwOA1u1BzeWwsomnHs84KuSc1KGa8dz9z2wZDbXAauecVo5y0qbIkGfPFT6358D5z6Vrve/jjPoTvUULLLo32MeoSf28sXKCaVeuDnbitr4GNqlTWusc7Qi8lsROQYGguyw7nUz+A3TcXS5qK0AK7gIKV0TmE+e57U8ZakmR1KPwEYWxmFrhC1smsy1byPCvZnGfM1N/QcYicXfCnIywD7tw46J4m/uezSiwnMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vA40w4Wq3LiAH0erOxR4t3t/y6hJp5VWqD/Sl3hMbWo=;
 b=Jatc8k3LUOPJXBJBIpqvAFP2DEhgM2LaPSCbx4Ss1yKhXy4/DL++d3aQf5ZPmiAxjrzfVI4ufVTs24iOoqpEN41Ta8F3yOyuAA/5/B7H4tDRgiRtg1psaNFTB/zjBPfqVKYgfmY5eqb/dT7ZDUo6W1dRJeRbf9rzpjDfGY90fFVB4c9bFMHPXkILmfcDa9V7OadlpYlwEEcYqNz4gPTa3TB6cAM7X7OBgDiocxrngU3kW+26i8JE7E+9fuisePLgNkGm4421cupXAq0nbeegshq7BGxaxkGRA4j0LqBVVUrVCEWGjfRzcUSmsWtgbG4bVxgPjQKlepkRxXk++amcyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 DM4PR11MB6408.namprd11.prod.outlook.com (2603:10b6:8:b7::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Tue, 23 May 2023 01:44:04 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6%7]) with mapi id 15.20.6411.021; Tue, 23 May 2023
 01:44:04 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "quintela@redhat.com" <quintela@redhat.com>, "Wang, Lei4"
 <lei4.wang@intel.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v1] migration: fail the cap check if it requires the use
 of deferred incoming
Thread-Topic: [PATCH v1] migration: fail the cap check if it requires the use
 of deferred incoming
Thread-Index: AQHZiaHrpdDskbcmfUmdUetnWYWQW69gaDgAgABj4tCAAO5TgIAAAOyAgACb1xCABKHrgIAAHRqA
Date: Tue, 23 May 2023 01:44:03 +0000
Message-ID: <DS0PR11MB63737B09D72A735EC21F3C41DC409@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230518160026.57414-1-wei.w.wang@intel.com>
 <ZGZ6Yqx2+dOp+Q73@x1n>
 <DS0PR11MB637350354B0285ABF3FA1BD9DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZGeWF4lzBldLLH/y@x1n> <ZGeW3R5McptUueJF@x1n>
 <DS0PR11MB63736A4AE4A624D2B9EFD19DDC7D9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZGv8adigFYpLD89k@x1n>
In-Reply-To: <ZGv8adigFYpLD89k@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|DM4PR11MB6408:EE_
x-ms-office365-filtering-correlation-id: f1f12eaf-b871-48a4-f67a-08db5b2f3049
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NQgmOIVWUk/xs0vWGl6DbwGhgNZai06KDMQigYpxgO94IdLq1u/eZFonv0MGGtYiiXXkyjhGvSU3isusKqhIia4JZiDKN3R7itcM+QDq90Rdc13k75fK/vkT2X6wWuiGkQV/hJbLnNu9Hi1Z3lxFR7ISrxcSVvXnz+Hs5DvUTdmSGHJyqnyYnmtRbJZvUoU0hYGwS28wyjWKs57Zqbg/2/SydOZUnKBZIZ/9T0C5OucHFCscu5g7xTkNYdKXfvlUrkExqDBms+ZEx1x+7GtR0cHGtwRA388e0gebU7adWuQF6xsuxyEwK7z7+NtSt9Wy2B+O+DwFHkOZwA1cq+Gk9dqFRfS/PhsGCA9cGybRL0LXUVmaNAoEipp+gV0ziyfOVy9dw0F45LtwO7wXD7fXqg2usiQdwDUbETeN13gBOcDv4AZ0C1lcRTc8XQNPwz8ayJFKk3UGlwbmxyxFsBs6xOUSjk0i5FLmxzfrdiK5ZMCz4/JciKv1FFsF5oT0XBbVgdImk6q/uXq0QhU5EK7keRRwIQ0Tid8B4mSBmjQ5e5+xRcyJlUAL6B6pox9azGpMmKoU86fOPRl4Qk5+IMusMzD443W0vpcZ6g7HCdXgE91w29C/nWEwRXxhjL3cNMMh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199021)(38070700005)(122000001)(82960400001)(38100700002)(33656002)(86362001)(55016003)(53546011)(9686003)(52536014)(7696005)(6506007)(8936002)(8676002)(2906002)(4744005)(186003)(54906003)(4326008)(6916009)(64756008)(316002)(26005)(66446008)(71200400001)(5660300002)(41300700001)(66476007)(478600001)(76116006)(66556008)(66946007)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0tSQmRrdmV6MTY3UVNXc1dTVkdLbTVST1daYWJRWHJMZ3E1SXVjNWtNZjkz?=
 =?utf-8?B?eHczckttcmRpNExGVXdvdFp4TVA1cmxCRkdzZVk5c25CaUdFQ2hoMTNlNVFN?=
 =?utf-8?B?SXREaEk5enJmY3NlUmNtc3M3c0xxbTdOS1dXNnI1cThLL1ZMckptaDgwQjIy?=
 =?utf-8?B?UEN0bUtqYWRwWjVheTVpV1BIQlNZZHJHN3hkL3FXVEVzVDlYOTBuMmhSVEhH?=
 =?utf-8?B?RjI5Nkp4Yzh6b0lodmVxTlYvVjlFWkdISElpS3BoZGVYSEJDNjQxSkl1a0lY?=
 =?utf-8?B?bkkxWll0Zm9xZWVwSm5wd0s4S1ZJRXh6QmZBdWwySm9wOUNYWFc5NkFpVTVL?=
 =?utf-8?B?eUxRSTQ0RW9sRERWYmhFZkF0UGRSL3BwVzBLRnZMRGNUTmFjZysyc2ZGaERl?=
 =?utf-8?B?Rjl0UVFQd0FzUXQrb2I5NmxSK285V1VWcFRTTFpldU9VNnBGMitNZHA5cUky?=
 =?utf-8?B?cWhxeU0wb0RnUmx3Kzd1TEpLTFUycG5NNGJxZkdEaHYrMlhpeUFXSE9WRFI1?=
 =?utf-8?B?YTUrM0x4blErWVQ4RW5vNXVodnlKSHFBN1RrQ29BVGRRS2FhbnpLOVhHV1dY?=
 =?utf-8?B?dUFRRTRTdmtlRXZNZHVmc1JDNXhHaTQvbjUwMjljYS8wd1hYM3hxaTIrWEM1?=
 =?utf-8?B?eVh4bE5BQVlwR0U5cWZMbEtzTVlvckoyVnNJaDAvNWorb3AwdkhHNVdyc2dM?=
 =?utf-8?B?clBoODRHNjQvbXY3QXhPOStqT1R0Wk02bm85UHNGb20vQ0NKYXRrTGZDSG5I?=
 =?utf-8?B?YW5zRmlRNjdKS3FVM2lnVDdVdVlBeEtaaVQ5cVhqUEJNejhjZ1gyU2ZzeE5X?=
 =?utf-8?B?WTRiRDF0aTVxSVhxZkVMdFZlcDEwZUcvWVRnVXNmdWlsWm44eG1rSUNEVXo3?=
 =?utf-8?B?NFpmU3FTYUtWbWswby9tcklsdXRtd2xoZEF6UFdNUUh2Q1MyYXYvelZNWjVW?=
 =?utf-8?B?L3FwaUs4RHh4dVNxTEErMXZsUFJkZEZ0LyttWTI3cmtGbjQxcDN4MTI0NEMy?=
 =?utf-8?B?YlF3RjVIRlVrcldPQVhpT2pvSmkxNlRuNWJsdjExbFRUVUdES2Rib000U2RM?=
 =?utf-8?B?R0UwUEJXbmozbmtKdTY4MG4zYXFwQzh3Vk1FYjFOSzNBWG8waHlRNkwrMUpJ?=
 =?utf-8?B?UXdOSGJIcDVhTkJwOWtwUTVRTTdYTThkdUhSWC95NWw1Q1lLUEZmOUU2enhP?=
 =?utf-8?B?Vk5TT0FoMUdGanZnSmNZNkVMeFZIUUhPVzZPdk1lVXlneWJIblcyYlVYZGx4?=
 =?utf-8?B?WkthbDg4OEViYkRzQUVkeEU5WnAwRUVQR21ZR0FzU0p4amUrK3hoRkh1M1U5?=
 =?utf-8?B?NTNmZXhJN0YzK0hpckNieXdjNDJMWXVHRXhJOE16ZFNRbWNnSjNuaTFudllI?=
 =?utf-8?B?ZnhyY3FSYjBnK0dKNFlXTFdGTkVXaEgyVzJxei9KMW52WTNUQ0ZhdnJ5ZTJK?=
 =?utf-8?B?NGpXY2VybHV3TmlEdm51ZUlVeWlJeDNWRVR2Z2ZyaTZZbm1lekwrMjFOKzRX?=
 =?utf-8?B?TEJkSW9QY0NFT0laRVl4SHBZMmQ3QmZDMTc3bTJlV045WFBMM1NvUVloVlh4?=
 =?utf-8?B?Ryt3TkY0R25pN250cHBhV3VwdlFrT3laQ1JSbUFzTWl2T0NlVWR4bklNNTdh?=
 =?utf-8?B?Y3Qwcmg3eDZwbDBYVTJDMk94VGx4dzNOTlppbkhoZ3J1VHB6aEZWNXN2QVR0?=
 =?utf-8?B?R2MyTkZzUXcramNNR0ZvM1pMNHRYUlZlTUE4SEtZRU0xMjAyYnJtMm16MU5D?=
 =?utf-8?B?VGsvWkU3Y0JERGV1aDFESzB4eE1IQWRvUysxWWptNC9SZHkxb2hobUQrdVQ1?=
 =?utf-8?B?SzZ2cjluMmViY04wNCtzak1KWEl6SVk4azBWK3lCeTI2eGVROEpvV2tZYmEz?=
 =?utf-8?B?b2dTRGtnVG0rSW1sYmZDVnpsNDg0Y2IyZDVHSlNBQWt1RERxenUwV2xkL3Nq?=
 =?utf-8?B?SDFPWE1zQWRsSkdqWDZwTzV1MjlRcjZ0T0l1bm4vbnE5MUtZNWRFblkwdjA2?=
 =?utf-8?B?MHVlbmRBMUVCZW00KzMyWjVJMWV0RGlEWStqRTZxam1NeUZqS0dwK0dVVElR?=
 =?utf-8?B?QmI5UCtEd3FNd0JWQldJVkJtMHp0S0JsT08zaVhpU2Z3MkJ5OGYrTEZMeVBO?=
 =?utf-8?Q?Dpmcq2XWpxBrIVljbWWvndw9a?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f12eaf-b871-48a4-f67a-08db5b2f3049
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 01:44:03.4663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZ+nToD1fnOrIL3yOJ6qmT9waDSDh/oOiNLeH/fv4tuC8pqvDCtUdSrztfqTPgVIdSvJomIl+gza5hRHTjHChQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6408
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120; envelope-from=wei.w.wang@intel.com;
 helo=mga04.intel.com
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

T24gVHVlc2RheSwgTWF5IDIzLCAyMDIzIDc6MzYgQU0sIFBldGVyIFh1IHdyb3RlOg0KPiA+ID4g
V2UgbWF5IGFsc28gd2FudCB0byB0cmFwIHRoZSBjaGFubmVsIHNldHVwcyBvbiBudW06DQo+ID4g
Pg0KPiA+ID4gbWlncmF0ZV9wYXJhbXNfdGVzdF9hcHBseSgpOg0KPiA+ID4NCj4gPiA+ICAgICBp
ZiAocGFyYW1zLT5oYXNfbXVsdGlmZF9jaGFubmVscykgew0KPiA+ID4gICAgICAgICBkZXN0LT5t
dWx0aWZkX2NoYW5uZWxzID0gcGFyYW1zLT5tdWx0aWZkX2NoYW5uZWxzOw0KPiA+ID4gICAgIH0N
Cj4gPg0KPiA+IERpZG7igJl0IGdldCB0aGlzIG9uZS4gV2hhdCBkbyB5b3Ugd2FudCB0byBhZGQg
dG8gYWJvdmU/DQo+IA0KPiBJIG1lYW50IGFmdGVyIGxpc3RlbigpIGlzIGNhbGxlZCB3aXRoIGFu
IGV4cGxpY2l0IG51bWJlciBpbiB0aGlzIGNhc2UsIHNob3VsZCB3ZQ0KPiBkaXNhbGxvdyBjaGFu
Z2luZyBvZiBtdWx0aWZkIG51bWJlciBvZiBjaGFubmVscz8NCg0KR290IHlvdSwgdGhhbmtzLiBU
aGF0IHNlZW1zIHVubmVjZXNzYXJ5IHRvIG1lLCBhcyB0aGUgY2FwIHNldHRpbmcgaXMgcmVxdWly
ZWQNCmZvciB0aGUgdXNlIG9mIG11bHRpZmQgYW5kIHBhdGNoaW5nIHRoZXJlIGFscmVhZHkgYWNo
aWV2ZXMgYmVsb3cgd2hhdCB3ZSB3YW50Og0KLSB1c2VycyBnZXQgdGhlIGVycm9yIG1lc3NhZ2Ug
d2hlbiBkZWZlcnJlZCAtaW5jb21pbmcgaXNu4oCZdCB1c2VkOw0KLSBmYWlsIHRoZSBjYXAgc2V0
dGluZyBmb3IgbXVsdGlmZCwgbWVhbmluZyB0aGF0IG11bHRpZmQgd29uJ3QgYmUgdXNlZCAoaS5l
Lg0Kbm8gcGxhY2UgdGhhdCB3aWxsIGNhcmUgYWJvdXQgbXVsdGlmZF9jaGFubmVscykuDQo=

