Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F646717D4D
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 12:43:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4JH1-00028h-DK; Wed, 31 May 2023 06:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q4JH0-00027m-2b
 for qemu-devel@nongnu.org; Wed, 31 May 2023 06:41:46 -0400
Received: from mga09.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q4JGx-0005tT-UD
 for qemu-devel@nongnu.org; Wed, 31 May 2023 06:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685529703; x=1717065703;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UJoMrTdQ48Fzhmo3QSYci3TaGSXBC+33SYfNd/AMbIM=;
 b=SXPiT5kiTbw/WJedtkanxyMRTxjn/xWFiGgJPHOhpDC559Sada47aUeh
 rdI0I8y4pCqTH3Zwb9tRK4Gwci/7h9jap1diFLSytF68pgIctRwQD6qwk
 bk6OGMQ+7+Mct59nsxdQshU8h1H7AmaCWpKip8o4cEowCVkC1Ki0yi9v3
 PPCo/C+kZZs6qXJyEr39l7GXCndnzH3y4jfl1tPINyegdmOvruI+KVxAJ
 zhCjEYrDpTIS3luMczaKXWukSF4zk/6GlVBDgGSvHQnBop4+R5ZAJmdYx
 xg7G/UCir/uQ06raX3sZ6te2vAU4h9kMyHl1AikarJT6GZgrogY5qHbaj w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="357589900"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="357589900"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 03:41:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="851163572"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="851163572"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga001.fm.intel.com with ESMTP; 31 May 2023 03:41:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 03:41:39 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 03:41:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 03:41:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 03:41:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNctEVv1YVBHfCQTKhL9yWDgP1IO5IkfAtKitc0cG5bX7C6XCIDeaEB4XuxACSAnroy2dprOYexKo3Zsh1CES5pP6j/0q8wLFxmCByWJY3D9X7/OAZ3BDOPAo0ObKle+/eHeUvd/U7+JqbXTDhZjce3NJoBZ6Qvt29TjoRvek2xL1rD/RKk2wSOpnFXyfKqniTHXOivdt6PA0hQ3mu08P5XrXy0wYizJecisnXhBjSzS7/nktyq72Ter/96dYF0N3C7S0vZtg5GBqA27lsVt6WBCYxxl0CObySrcmgKIvwRySqxme/IeVmu8nD9rczsT3th1/f75P1nUeLuIIjuhmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJoMrTdQ48Fzhmo3QSYci3TaGSXBC+33SYfNd/AMbIM=;
 b=bXcQ2LabdXMrkSua2f5LsFCiw/juy08d6IktxNJlHUXK0/HEYNgkPbA7cdKELVcOMtnK/ZNkTo9tpGMATGpvpCsFklaqGo4N0T9nZebySDsbpv9FF/jd6M5PURnxHoWbEsxdjEVe1mmQyJ1frcgxQbaCbIqswf8d1bmS0joXTuvQ4yYN/k9FRbxr0B7qJ67OoNOysBv33BaoXRxltQIQB9TGyfdYSMVYaaPuKOSdXF8BFD49fMhg5T4OgUV8uEU/0+Qqsb3WERyNrRKqi1kerG2XarPvZHyBu796HVc8jQsgkN2d9JOcNk79mAfhhf78cJcdSxDPNYTRFS2VaKRUIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 DM4PR11MB6216.namprd11.prod.outlook.com (2603:10b6:8:a8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Wed, 31 May 2023 10:41:37 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6%7]) with mapi id 15.20.6411.021; Wed, 31 May 2023
 10:41:37 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "quintela@redhat.com" <quintela@redhat.com>, "Wang, Lei4"
 <lei4.wang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2 2/2] qtest/migration-tests.c: use "-incoming defer" for
 postcopy tests
Thread-Topic: [PATCH v2 2/2] qtest/migration-tests.c: use "-incoming defer"
 for postcopy tests
Thread-Index: AQHZktWTIexX3rIWCUy8lvegBejjAa9y4+mAgAC7pwA=
Date: Wed, 31 May 2023 10:41:37 +0000
Message-ID: <DS0PR11MB6373797A00F0A4E6B22EF639DC489@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230530090259.189462-1-wei.w.wang@intel.com>
 <20230530090259.189462-3-wei.w.wang@intel.com> <ZHYLDSZiP+BQXv6K@x1n>
In-Reply-To: <ZHYLDSZiP+BQXv6K@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|DM4PR11MB6216:EE_
x-ms-office365-filtering-correlation-id: 27ec0d65-fc16-4b89-3e5f-08db61c39c44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JHuZoyg/PeyV93qwkuA0lqXz+ONDh/BjWcpMgeptLw3Xs++DWeRgaDhMwJ/mAqOSF2vxI6GwcptPP37mwE2YtopuRHUwfnALEttSt0Z6rgRgp4jM9uczGZc06Fo7KrFUY7vRD6JNR+SmQr33iEtkNj2ub6a6DM7pkfCYJVbdjdVx7/pP5AB+VL8V0GsQ6N7Sy94rLCJwcKaB/IDwFBoxXIB/KkAKYfXzclnUGK49Sqf1OHk/6IJn9Mu3Gg4zS4qRVUgTncyxmYW2RutxAYmGJZuiv+64P80AIZdEaA6zPOBdRWTcvzdUTznHyaPGrq6zRYbDdtAJnliejzBWxCzRwXYWP6OL3sCh4ulKJP9cuRBEmy9xZ5fFLssZvmXNH+H1CcC2XrzPdz/Dkil/AplgMw1zyRKkiMKBd9b2Ra0jTq50EH+OtUoCPLor9/t1mgDmHvoCCMZZGuIUl9iaUZ7R/qbWXxloBGjZD3qwyBpfCN8QtYbeYIViYqPXnDsjShjxJe6SfvF+9YpfPMMX9M5npTxvWKRsNSq0XJSR4xN8N+722HuxIVjeRSKxFBHyD//p8mZ8yxGQt/fUy5Jit53UQ87NlZ7GM86Wrb/FO1hGzic=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199021)(33656002)(82960400001)(478600001)(54906003)(122000001)(66556008)(71200400001)(7696005)(64756008)(66446008)(66476007)(76116006)(66946007)(41300700001)(38100700002)(8676002)(8936002)(52536014)(86362001)(5660300002)(26005)(2906002)(53546011)(55016003)(186003)(9686003)(6506007)(83380400001)(38070700005)(4326008)(6916009)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTZPMytoQjNJSHVFM2MzNGJyUFNLVzd2Yks2UUpNZzhYT1lrRmhKcWhEZ25V?=
 =?utf-8?B?bTdoRnFndGZBK2g3RVVzYkplNnVFbDY4aitxRTZDcm9EZXpjR2hkUm1BRUI2?=
 =?utf-8?B?Mk1oYWpTbm9kay9OSnI4SnpQZWVybndJVkVibzBBVVhDb1gzZFlEQjRhRXBF?=
 =?utf-8?B?MWtiNXVCbVA2dUpuR1JtQVJQV0ZjdXBnZk5xVWwrelRqOUFpRHRGVGZhaWY1?=
 =?utf-8?B?Z1J3ZElubFhrRkhyaXZkc1dHMFExazllbnJCTm40Ukc4aTNtcGpyc3BJWHNS?=
 =?utf-8?B?bllFYWVBd1JhZTMrTHZCV091Z1RNQUV1NXNScm0rN0N5MTdmQ3ROWHZScUNR?=
 =?utf-8?B?am9vZUN4bUZVSDRwRzRRTXlUU0VrQ0N2cTF6VkVDMjlRVE5jRzlHUW82SVNI?=
 =?utf-8?B?NDZKdVBxbVdlTmhlbi9Fc2FqTkkvNlhwWWxmN1hsVHovQ0VwZmxXbjFPK2xz?=
 =?utf-8?B?UTBMUTZFK09FTmFRQkhUa2VTRDRBcmFoblpNbW1CSVd2WEdTTDdXZG9rMmxx?=
 =?utf-8?B?S2crMUY3dnpyVjVPNEN1SFZFTWFRaWUzdWxFTVYzMWhHYm9sMzNWZGZ5cFZC?=
 =?utf-8?B?VHpGWTVIbTR4MXgvSVB6UFBkTkVoOHRrZCtVQWw5R1VORGlTOEY5cmdUMHVp?=
 =?utf-8?B?MmtQU0hocnhUVyt4WEh4M1BJQVF4SEowQ2dzR01OTnl5OWVsMnc5TzRnZVhV?=
 =?utf-8?B?WlVXcDRUeFJ2NVB5ZkJibVVEVmk1eE16L2pDRWUrZ01tM3krNXdhaEI5M2I3?=
 =?utf-8?B?RklkME1HWnN6K21IR2t6eitTamxnYmYrVzR0d0dYZ0FQbmRPWDhLTHVTMHQ0?=
 =?utf-8?B?VWFaMEV5L3FkbGdEcjhUVGNYWXg2dnpoL0UyQlg3RHI2SmNaMG9FbHBpdXV2?=
 =?utf-8?B?VFhaZWpIRUpvK2QwWHQrTlZYd3NIZ3Qxc216Z2ZzNjhOSldyRDI2VGxUdXk4?=
 =?utf-8?B?L3dncmNSckVTRk43VWtuWXZYWUJDV2l3ek5TQTg0c2J1dWtENlpJUjZ3WWc1?=
 =?utf-8?B?QXlURnBIWU8rUmdJV05IVmNvTUZlT0ZTL2xETmpua0hmQ1JVdzlEZFN2V25R?=
 =?utf-8?B?OC9EMFBYc2lzWkE1a2NpV0JkTGpRS3BUV2R5TFFXZDVGbDhkRjRGVGNkcGJ4?=
 =?utf-8?B?MVhGWjdtbmsyWUpyUkN5SnhIZllRRHBFdTg3c3JCZEVmNzl6MCtYcERFbGg3?=
 =?utf-8?B?d3o0akZ6V3RQWDlGcVhwem5zanJ0N2w3d3I4aDVzZzNVcW5DRGNoWWZwemd5?=
 =?utf-8?B?VmpJRG1PbDlwTXVpeGYySUpYeTJEd25TaklRcm1Dak54SndPNTJsbEZ3akRx?=
 =?utf-8?B?ajQ1MFRmZWNpbVZsdk9KKzBBWllGMmlTVDlJMHo1L3kweTNDQ3hVazU3TWRy?=
 =?utf-8?B?NktJZTMxNC9DcmF2ZDNSSnlSNzVOYnlieUc1aVNLNklKYTlZbkx1MVBaeVVJ?=
 =?utf-8?B?V2l2dSt6NGtKOWsxMjZRK2x1bGs0Yk03ZUI0VmJYc2NOWlJ6WldYY0c0dytp?=
 =?utf-8?B?VEo0czZmVkxZU1dMYnp1VTdHdVcvWVc5ZXhBTmt4NGV2MXhXR1pLRndVSVVJ?=
 =?utf-8?B?UWdpRE9kRlJrZFJQenZpTEFHQVdWeGhVNHk1dzM4YnpacFRZb2dJSHFyK3Rj?=
 =?utf-8?B?TXhZMnBZbVlrdVdZeXNwY2VkRW1rbUpsaXo4TGNmWm80bk9HdFNhanRLYkZs?=
 =?utf-8?B?aEVQbDlFSTgzeU1PS3FPWWVLV3czVlcrQjdZRDF0TzkzSXpzcnJhYndvaTVZ?=
 =?utf-8?B?RUxYVG9OblFyTVFVQ1JxZEJsT0VMZVFVVXBuQjRWdWlUME14MENxeCtMYThE?=
 =?utf-8?B?SXZvY3AwV0RFSC8vSXRGWVM3NzJIUndya3B3UFBWMlM3Umc4Q3g4cDlIMkhr?=
 =?utf-8?B?YWFEMi9IVmZxdldyV2NwOThqQ0RDVGU3NGhBdTNGZmMzd2ZRdEkrRFEwSUJk?=
 =?utf-8?B?bjhlVHJkZGlVamN6VWhRUDh6YWJUR2NKSHBxQzNRWlNHV2N1R0JvdFdyL205?=
 =?utf-8?B?dmFlcTIyNGNISEdQaFEwYVJQcU5oY2ZoTVBGdzlrUzNwTlNkc1FJN0RDaVBJ?=
 =?utf-8?B?TnAxREEwNUpNN2xlZGQxZHBjNFZLR3JUQm5EV2NjNm10S281REw2S2hTVnZX?=
 =?utf-8?Q?K44m/8ol7GLK5IynaD1XSK8PA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ec0d65-fc16-4b89-3e5f-08db61c39c44
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 10:41:37.1172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4pMkM4ZZoK4X1uC4mKQ0Ggzlv+DwJZE9MrVZ8TBREFlRO9GdfwaHK1L/9wHgX/FjHbyDZ3qFdBImqBJ7LsgxQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6216
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24; envelope-from=wei.w.wang@intel.com;
 helo=mga09.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

T24gVHVlc2RheSwgTWF5IDMwLCAyMDIzIDEwOjQxIFBNLCBQZXRlciBYdSB3cm90ZToNCj4gT24g
VHVlLCBNYXkgMzAsIDIwMjMgYXQgMDU6MDI6NTlQTSArMDgwMCwgV2VpIFdhbmcgd3JvdGU6DQo+
ID4gVGhlIFBvc3Rjb3B5IHByZWVtcHQgY2FwYWJpbGl0eSByZXF1aXJlcyB0byBiZSBzZXQgYmVm
b3JlIGluY29taW5nDQo+ID4gc3RhcnRzLCBzbyBjaGFuZ2UgdGhlIHBvc3Rjb3B5IHRlc3RzIHRv
IHN0YXJ0IHdpdGggZGVmZXJyZWQgaW5jb21pbmcNCj4gPiBhbmQgY2FsbCBtaWdyYXRlLWluY29t
aW5nIGFmdGVyIHRoZSBjYXAgaGFzIGJlZW4gc2V0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
V2VpIFdhbmcgPHdlaS53LndhbmdAaW50ZWwuY29tPg0KPiANCj4gSG1tLi4gc28gd2UgdXNlZCB0
byBkbyBzb2NrZXRfc3RhcnRfaW5jb21pbmdfbWlncmF0aW9uX2ludGVybmFsKCkgYmVmb3JlDQo+
IHNldHRpbmcgdGhlIHJpZ2h0IG51bSBmb3IgdGhlIHByZWVtcHQgdGVzdCwgdGhlbiBJJ20gY3Vy
aW91cyB3aHkgaXQgd2Fzbid0DQo+IGZhaWxpbmcgYmVmb3JlIHRoaXMgcGF0Y2ggd2hlbiB0cnlp
bmcgdG8gY29ubmVjdCB3aXRoIHRoZSBwcmVlbXB0IGNoYW5uZWwuLg0KPiANCj4gV2VpLCBkbyB5
b3Uga25vdz8NCg0KSSB0aGluayB0aGVyZSBhcmUgdHdvIHJlYXNvbnM6DQojMSAiYmFja2xvZyIg
c3BlY2lmaWVzIHRoZSBudW1iZXIgb2YgcGVuZGluZyBjb25uZWN0aW9ucy4gQXMgbG9uZyBhcyB0
aGUgc2VydmVyDQphY2NlcHRzIHRoZSBjb25uZWN0aW9ucyBmYXN0ZXIgdGhhbiB0aGUgY2xpZW50
cyBzaWRlIGNvbm5lY3RpbmcsIGNvbm5lY3Rpb24NCndpbGwgc3VjY2VlZC4gRm9yIHRoZSBwcmVl
bXB0IHRlc3QsIGl0IHVzZXMgb25seSAyIGNoYW5uZWxzLCBzbyB2ZXJ5IGxpa2VseSB0byBub3Qg
aGF2ZQ0KcGVuZGluZyBjb25uZWN0aW9ucy4gKFRoaXMgaXMgZWFzaWVyIHRvIHRyaWdnZXIgZm9y
IHRoZSBtdWx0aWZkIGNhc2UsIGUuZy4gdXNlIGEgbXVjaA0KbGFyZ2VyIG51bWJlciBsaWtlIDE2
KS4NCiMyIHBlciBteSB0ZXN0cyAob24ga2VybmVsIDYuMiksIHRoZSBudW1iZXIgb2YgcGVuZGlu
ZyBjb25uZWN0aW9ucyBhbGxvd2VkIGlzIGFjdHVhbGx5DQoiYmFja2xvZyArIDEiLCB3aGljaCBp
cyAyIGluIHRoaXMgY2FzZS4gQWRkaW5nIG1vcmUgcGVuZGluZyBjb25uZWN0aW9ucyB3aWxsIHRo
ZW4gYmUNCmRyb3BwZWQuIEknbSBub3Qgc3VyZSBpZiAiIGJhY2tsb2cgKyAxIiBpcyB0cnVlIGZv
ciBvbGRlciB2ZXJzaW9ucyBvZiBrZXJuZWwsIHRob3VnaC4NCg0KDQo=

