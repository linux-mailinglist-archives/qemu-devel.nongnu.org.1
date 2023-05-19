Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D3A708DD6
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 04:36:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzpxc-0002zn-2D; Thu, 18 May 2023 22:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1pzpxZ-0002zX-34
 for qemu-devel@nongnu.org; Thu, 18 May 2023 22:35:13 -0400
Received: from mga14.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1pzpxT-0004Fn-La
 for qemu-devel@nongnu.org; Thu, 18 May 2023 22:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684463707; x=1715999707;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ARI0gf0PWxJbxl2+5llQwDE8L3hEVIr+xGIeGCwIiLA=;
 b=aclZ+w/YWpDJIRQ2aJY9pFosmsPIyv5B99o+KfptQ/5CMDGYEu4hHHK4
 31sc4HFRnWvSzjXH8IFHULIp92PGoYvTsZMde0xUKsU/NtbkV9PQUcQ8D
 0BvNZGgnDLr91xQq+6tkGJ5h+AcGrJ03RZNFAr/tPGqULsrlmfphCkcTg
 /eIvz5bqbXnv+QzS5oH+c7rF+sm5fDogYzFCjBsU2WMs0kPEk5TZ7NssN
 zkDem/f4lpqurfKDKh86IL56TJwkZCRECvcMdgBZZTu4jTghjRHUWRlPG
 N2TdlW2XRunEWRFIM/xqVU8KNl+CnN54y+rAvTuV34X5cer1e7qIqgbi/ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="352278078"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="352278078"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 19:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="814564771"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="814564771"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga002.fm.intel.com with ESMTP; 18 May 2023 19:35:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 19:35:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 19:35:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 19:35:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 19:35:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlQst91l9umesHezCLwmQpM+a6gkX2u/EYU5+kxli69SgP1kRRk7Zu0GI1eYL/nlYkS6JZDDCFZknZfhRv6XuY3bepk5sYzPRBfYPsXuvsXqXzD4K0AkvBKA9JBrdBI5hgLekOudIcQ9aYyVswUhmrEk23jp7CY6j5yekB3ODhb5YBHwKIAlE18487q2Ubroo4+v5w/Tj/EmsPYQ/1KdSMMmK6FJkfZvLda/gcntoL4//E10NhiR+VoID9ZOYRgPeCf7nMK8byuZs2HH301MUZkTE3nT/SJfi9+3dYmMkj9FqCfS6ZLr0dt3SxQsjtebyQeR16xLy6qYj6ySA6Q9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARI0gf0PWxJbxl2+5llQwDE8L3hEVIr+xGIeGCwIiLA=;
 b=mEyMadEsYqnQMVa7VaX5xYXpEJFGLZh9raqtQbTUoB9yGfOfWl2f5yi024GmE1ZM+SPaAcM+yl8GS+eufdU0HQBAwoVviXB6a8Qm5g7kNQyJu6JQ+1Ve3HkWm1gdycpspyteA71H0VxFdnt3+4Rsa6QymlLZ8fimUiamNBnxOjH/qr4EcPWZK9YKk4EiYVDLW+MrMLKSnjTnMmx/jRawqtqxPPoSXiF/HFQkrnWgVEyxWuTihFVsuidGc6WkvxmSeh9Qc5jakL4Pf1ZrYmS0v04BgiDMlUUNlLaffcOsNLcojj47avS6xRXFFSESSAUq5TfbGYb8EMsz/v47ga1j/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 IA0PR11MB7743.namprd11.prod.outlook.com (2603:10b6:208:401::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18; Fri, 19 May
 2023 02:34:57 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6%6]) with mapi id 15.20.6387.022; Fri, 19 May 2023
 02:34:57 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "quintela@redhat.com" <quintela@redhat.com>, "Wang, Lei4"
 <lei4.wang@intel.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v1] migration: fail the cap check if it requires the use
 of deferred incoming
Thread-Topic: [PATCH v1] migration: fail the cap check if it requires the use
 of deferred incoming
Thread-Index: AQHZiaHrpdDskbcmfUmdUetnWYWQW69gaDgAgABj4tA=
Date: Fri, 19 May 2023 02:34:57 +0000
Message-ID: <DS0PR11MB637350354B0285ABF3FA1BD9DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230518160026.57414-1-wei.w.wang@intel.com>
 <ZGZ6Yqx2+dOp+Q73@x1n>
In-Reply-To: <ZGZ6Yqx2+dOp+Q73@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|IA0PR11MB7743:EE_
x-ms-office365-filtering-correlation-id: 19ca7084-c3b4-45d9-cd57-08db5811a2dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6jlhR/3ktea+H+5WYHBx+t4AXM6e0qwg4jvK2hKtKOGI2Uv5ykuv9VOn1dLfg0Igcx1nd1Sz2VpotOMkyLw70pI6LTubTOEKsHpnjbT5UgIB0etoggsdPLuCkiuM9sQCju7uCe3CxRZFsm8laIS3hnhsuKnyAKHvSu2tbNklyVryJbwC8bkD4ll66H5gIGY3ozI2Ov66phhgbv6LAOwBLDRqZW9XomzuhkUGLjMe3M9gm4zXWMwfDkJ1UH8HK0RtBAjXJQFozo6bsAlX25p/VGEf/8t5TILWyQy5l+To3P5to4/3QxYGJ3eXhgLFkQMZDMJg7+yn96RvGMEAtrskdA6IZkasd6ybjYFg1r0v5leLfreYeurUEy4c7MmgwMojEjoVxfpb6qA2v/c5Ki0gb9yqSxGbvDXXLaLpi0h9hQfPIJ8aIkO7hAtzYgHtjLlJByLEOXkYUR+5vveN2Am+cHeJtxKw8NbUNiY89lu2JRD+MYAxfNJCB4D3oeq1uQmInQD43RvHKBtLswnL6bncb7N5kBhiRExyjIIEFAE5YfGzfel0sh59weHgF4IU0QjQDGr/+KhJjjg6bHOioxWRJjXdRvvcJYn3wQmJOKZHBZY3pqRkXII7BXnsF9fcAizK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199021)(86362001)(38070700005)(33656002)(7696005)(66556008)(76116006)(54906003)(316002)(6916009)(66476007)(64756008)(66446008)(4326008)(478600001)(55016003)(2906002)(52536014)(8936002)(8676002)(71200400001)(5660300002)(38100700002)(122000001)(41300700001)(82960400001)(9686003)(6506007)(66946007)(26005)(53546011)(83380400001)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGRiVTNBQjNFNWVFdklJNnp0YUFIdllaOU1ub0tTTXdTY2N4TU5MMUl0VHFm?=
 =?utf-8?B?M3RKUm1RL0FvNi9MakVOdWRrc3kvaXZuTEs2c2hBSTIvbEh6eTRMU0d2dEh3?=
 =?utf-8?B?c01xK0k2blJ4Z0thNU4zZUVPaDRIRVJPR2FhZmEzdjUyU2R4UUxXRllLaUdD?=
 =?utf-8?B?Tlp3bmZYQmR0b29NK2RXTExSY3ZqNHZzTCswRzZNSGxzL2RBaFIyaWZiNGcw?=
 =?utf-8?B?dFowT1FIREUzZ2xmTkNrRGxHQytIVE1lZkZFOVRsMms5Z20yb3RjWmhhTEs0?=
 =?utf-8?B?R0NBcm1Xb1oxR1RZTFRwTGdKTkFUVTNYai9PNWZIVWg1MmYwSXRUUGR0WUdF?=
 =?utf-8?B?MmV2RkxuekxJcWFHMGFodi8zaFg1Z0RPWEZ1WG9WZlgyM1FFL0ZNZUhFMndn?=
 =?utf-8?B?RDU0cWFVOUszN1hJRjlpRmhWU1VOZnNKMGtKTGJ1QjZCaUNCZGp1Y1lJTlI3?=
 =?utf-8?B?eDdDa0JrbWgxR1h0dTZ1R3RVZVNaTGlVUFVpWHppbVVlVVpFYTBmeXFaMUtr?=
 =?utf-8?B?N1dleDVpMWVmTHp0djlMUXhsSHVPMGkreVhCdVl6aFdyMFo4YVF3N1JTOWMr?=
 =?utf-8?B?Q1pZemJic2xBNG1vUStjbXIyREtyOU1ZVkRLUDRYSXNheVdteC8vcHFlR0ZJ?=
 =?utf-8?B?YmtSRmZwZjVQMG0rYUhlb0c1aS9QdkpmWTBwWkZLcjVYZnpqZ2hPUDM5WmV3?=
 =?utf-8?B?aGFhb1NQcjR4WU0rb1Y5N05xRmYxTUNJc3JLTCszcnNSMjFHWTZpdWxRZk9r?=
 =?utf-8?B?eEpCUHBvYnByM2hxZmFHMTQzNkJGazIxYkpJMVlCMlhrUjhReHVHR25KVTVD?=
 =?utf-8?B?STZqVmVwNWYyOVBGaGVKNXlydEgvRGNUMk1mQkNNZ1V5WGFVVmp0TUpoNEZl?=
 =?utf-8?B?b0VocXNjOUVCNGtXM2I0ckRZZERrL3oyS1FqQ2FSVEpEUHFtMkdtUlZGQ25Q?=
 =?utf-8?B?K0N0TUVxcktSWTU4bTkrMy9naFVKU25NME5nRlpKT3lxOVgvWlBYZCtDdXQ1?=
 =?utf-8?B?bStibWhXcTJ5Q3BBQ1huUW1haGxUZHpwSzl1RGNmK3JWUk11UGlwQWozc1ov?=
 =?utf-8?B?UFdXbDQyN0srM0NBTlh3RTNZWlNreVo5ZFFBWWtDaW1XNC84S3daWTVYT3RC?=
 =?utf-8?B?QVEvK3FzcFBJSGRGSlVSSzlGYUlVYkZBdWpBRUpYNW5MVkRYbkU1NGRWLytj?=
 =?utf-8?B?Qk0zb3l5bDhlaENlUHkwamErMjJVZi9sUDgxNXBFa2YzeC9OME1Zd2FXWGlp?=
 =?utf-8?B?cTgxRlcxQXhQQmxLWG9yS0x1dmJ2VFJ5RmpuODg5eVAzN25DcHNyZFBvZnZW?=
 =?utf-8?B?WFFHRG9qc0l6V3FlZm9paWk3RG1oTmpWZVZBWXJvT29nK0FDeVJKTXFCUE8w?=
 =?utf-8?B?RldPUE5YOEpCRTJPQWZDR2JTd2dMWTdPejZyZDN2VmVJTzFJcUJwOFh4eHZ6?=
 =?utf-8?B?cUNtSkxTK3VPMEFaOHlEdjh0ZjR2M1krbTYyWXN3VHgwS24xZE9od2NFeVNh?=
 =?utf-8?B?bnZ2YWhFRklkenA1anR3V0ZrOTA3Y0JNdGlqWDg0MFJhemJHOU56Z1BFY2Fh?=
 =?utf-8?B?VUdnQVJEcEFRcUt2TlJVMEhuUmRjRVRuSjNKcnNLL1ZqenhUcEQzUW0vV1h4?=
 =?utf-8?B?bCtTT29vS01iWE1ZM0VoUDA1dkFid0VqZm1vVjZLVlY1MEdDald3bkJJbWJ6?=
 =?utf-8?B?WnlGK1kzRmJCNklnZjY2ZGoyMTVKU2dwdVk0Yk1OT1JnWXN4OGszWFczRGZu?=
 =?utf-8?B?aG4yV2h4SUpnRFNDUjE5RHhhVG5TbjZXN1QzcHRiVGVsNUE3Q1RmUkRDbFF0?=
 =?utf-8?B?QU1CSnZzUVpSVXlDSmNxcW1GL05YQ2hkM3U4T3FMb1V2VDlwOU5jaHp3Y2Y2?=
 =?utf-8?B?NjV5SjFSdTBhc1gybnJMYm1sbzdoU1NnTUhpS3pobWpMOHJtc08yVlVaUklL?=
 =?utf-8?B?UnFnbEFzZFltZ3F2VDhjT1ZjVWdGNGc5bHFmVWRxQllCWSsrNlZ1cEVpNC9U?=
 =?utf-8?B?aWZhRUxHaVFoQVIrVTNuMkJvNHNmWEQ5a0VyZ1dUZGJOd3RIbFZLZUNtVWdB?=
 =?utf-8?B?WlE5UlNZNW9wZ1hXUHpGU3FFc0lhVlFtMU1pOS9Zbi9QeWFDUU9RaVRYMUUv?=
 =?utf-8?Q?TWmilR4LI1EmkRAD4jFZqo8Hx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ca7084-c3b4-45d9-cd57-08db5811a2dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 02:34:57.3022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDrlvMvpKFmprAy0cXwwnX/p3TtofaQGKEQOqc2D33gmlxIQy7Sg4JcNKGTuLMqlPFat4MCyUKb4pjYFacru+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7743
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115; envelope-from=wei.w.wang@intel.com;
 helo=mga14.intel.com
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

T24gRnJpZGF5LCBNYXkgMTksIDIwMjMgMzoyMCBBTSwgUGV0ZXIgWHUgd3JvdGU6DQo+IE9uIEZy
aSwgTWF5IDE5LCAyMDIzIGF0IDEyOjAwOjI2QU0gKzA4MDAsIFdlaSBXYW5nIHdyb3RlOg0KPiA+
IHFlbXVfc3RhcnRfaW5jb21pbmdfbWlncmF0aW9uIG5lZWRzIHRvIGNoZWNrIHRoZSBudW1iZXIg
b2YgbXVsdGlmZA0KPiA+IGNoYW5uZWxzIG9yIHBvc3Rjb3B5IHJhbSBjaGFubmVscyB0byBjb25m
aWd1cmUgdGhlIGJhY2tsb2cgcGFyYW1ldGVyIChpLmUuDQo+ID4gdGhlIG1heGltdW0gbGVuZ3Ro
IHRvIHdoaWNoIHRoZSBxdWV1ZSBvZiBwZW5kaW5nIGNvbm5lY3Rpb25zIGZvcg0KPiA+IHNvY2tm
ZCBtYXkgZ3Jvdykgb2YgbGlzdGVuKCkuIFNvIG11bHRpZmQgYW5kIHBvc3Rjb3B5LXByZWVtcHQg
Y2Fwcw0KPiA+IHJlcXVpcmUgdGhlIHVzZSBvZiBkZWZlcnJlZCBpbmNvbWluZywgdGhhdCBpcywg
Y2FsbGluZw0KPiA+IHFlbXVfc3RhcnRfaW5jb21pbmdfbWlncmF0aW9uIHNob3VsZCBiZSBkZWZl
cnJlZCB2aWEgcW1wIG9yIGhtcA0KPiA+IGNvbW1hbmRzIGFmdGVyIHRoZSBjYXAgb2YgbXVsdGlm
ZCBhbmQgcG9zdGNvcHktcHJlZW1wdCBhcmUgY29uZmlndXJlZC4NCj4gPg0KPiA+IENoZWNrIGlm
IGRlZmVycmVkIGluY29taW5nIGlzIHVzZWQgd2hlbiBlbmFibGluZyBtdWx0aWZkIG9yDQo+ID4g
cG9zdGNvcHktcHJlZW1wdCwgYW5kIGZhaWwgdGhlIGNoZWNrIHdpdGggZXJyb3IgbWVzc2FnZXMg
aWYgbm90Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpIFdhbmcgPHdlaS53LndhbmdAaW50
ZWwuY29tPg0KPiANCj4gSUlVQyB0aGlzIHdpbGwgdW5mb3J0dW5hdGVseSBicmVhayB0aGluZ3Mg
bGlrZToNCj4gDQo+ICAgLWdsb2JhbCBtaWdyYXRpb24ueC1wb3N0Y29weS1wcmVlbXB0PW9uDQo+
IA0KPiB3aGVyZSB0aGUgY2FwIGlzIGFjdHVhbGx5IGFwcGxpZWQgYmVmb3JlIGluY29taW5nIHN0
YXJ0cyBldmVuIHdpdGggIWRlZmVyIHNvDQo+IGl0IHNob3VsZCBzdGlsbCB3b3JrLg0KDQpBY3R1
YWxseSB0aGUgcGF0Y2ggZG9lc27igJl0IGNoZWNrICIhZGVmZXIiLiBJdCBqdXN0IGNoZWNrcyBp
ZiBpbmNvbWluZyBoYXMgYmVlbiBzdGFydGVkDQpvciBub3QuIEl0IGFsbG93cyB0aGUgMiBjYXBz
IHRvIGJlIHNldCBvbmx5IGJlZm9yZSBpbmNvbWluZyBzdGFydHMuIFNvIEkgdGhpbmsgdGhlIGFi
b3ZlDQpzaG91bGQgd29yay4NCg0KPiANCj4gQ2FuIHdlIGp1c3QgbWFrZSBzb2NrZXRfc3RhcnRf
aW5jb21pbmdfbWlncmF0aW9uX2ludGVybmFsKCkgbGlzdGVuIG9uIGENCj4gc3RhdGljIGJ1dCBs
YXJnZXIgdmFsdWU/DQoNClllcywgYWdyZWUgZm9yIHRoaXMgYW5kIHRoYXQncyBvdXQgaW5pdGlh
bCBjaGFuZ2UuDQpUaGlzIG5lZWRzIGxpc3RlbigpIHRvIGNyZWF0ZSBhIGxvbmdlciBxdWV1ZSBm
b3IgcGVuZGluZyBjb25uZWN0aW9ucyAoc2VlbXMgT0sgdG8gbWUpLg0KTmVlZCB0byBzZWUgRGFu
aWVsIGFuZCBKdWFuJ3Mgb3BpbmlvbiBhYm91dCB0aGlzLg0K

