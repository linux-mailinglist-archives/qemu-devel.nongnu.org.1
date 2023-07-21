Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8736875C5BC
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 13:16:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMo6O-0000GH-Lf; Fri, 21 Jul 2023 07:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1qMo6G-0000Ft-N8
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 07:15:08 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1qMo6E-0001nf-BA
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 07:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689938106; x=1721474106;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vy5LlvUyYPGahnBhSfzzUfC9mnmDYIys3b88GMWtONE=;
 b=H22w2DgbYaDtb1dErw/nJ8a0DAdsgMZ3ub5NwYGymp40C4gdKL19ilHt
 g2srp6k9Svbrf2ueWX/NTzrsVtsfXWOeFlpvRXJ+gqeUcL5SAkuLpFbe7
 jDVgL5YF4XVuxhjp2dCXJcMWeqznuGuk3xckz0AMtCzOCLlKoLsQD1C5w
 XF/T6JAImSJqMzv7caAOPtciouMCAtSPfQ3sE3EDHR01n3BahLLSD0i4M
 OKc9lI74Kh6GsGUnKimZGFSUki4rhediCRTRry8D2tst9CHsK9ic0fsEZ
 IkV+Ht+to4k55Pz3cpExUY3ZQ3c8F0DhfqGfq5xpBQf5kEy4lGBva1b6x w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="433227828"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; d="scan'208";a="433227828"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2023 04:14:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; d="scan'208";a="868211240"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2023 04:14:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 04:14:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 04:14:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 04:14:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 04:14:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTnSVDRnxHppJSbAISUcp6NsG3zjpxf3LCeRivbDI77a1dFWm/ba56p3FfOL0KvpRm05zRJBpcWbofiCnNfidRC3wPrLsChc0zxg9gXAeZJokyoWWdlkhinSNVpckvAZvyv8ylkuA0JeF7tjKj50zB/a0d7NBBQps04U5A5fdO+ZVhhatoGD8LoFEFE7rL30SgKnjT2r6LkQrzc6t3Ots5jSSFzNNZU8I/++/hJLrGXgU6Q9/0vgwZ7OBmvdjGwHmzQRXwW1DUgUDiQ9Co8wZE0ikEgJlYSERDcJEAjS2nqahhbcRB3Ekg7Amu+ikSL9/ZbGJUw1BjNueNvcZaPPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vy5LlvUyYPGahnBhSfzzUfC9mnmDYIys3b88GMWtONE=;
 b=kkm0T/YWqegnPwXLAlKDSSXLDZEgU+rYwHOHhNrTZSgup5gA9mAYR7yKWtYNMC6W+z8EiqMHKZdvPTnMQfDkioDdMQb2hgafi7Cr5ZI+n57Vbkcq0WI6nRn4ae8PvbqjpyERYSlNf4icV/sxO+n31nCgdz5dhvhPtOCPaA5mm1o/IjnGKxPVUabMndArgi4A9Znnq3mQVgigDGM9p7SHFFX5y+lpJsClCetJQuCE+ZGtyWPpuY99oWijJ51OYwH4FPh+5HNQ67F5mtN1QmCXlWoXnnTjvYSmmlIo2yobA7q2XZoJmxV5kkNu72YjlXVZty0cIo0aSUh7dAIVfyOiFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 DM6PR11MB4643.namprd11.prod.outlook.com (2603:10b6:5:2a6::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.26; Fri, 21 Jul 2023 11:14:56 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::292d:f381:e584:9214]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::292d:f381:e584:9214%6]) with mapi id 15.20.6609.024; Fri, 21 Jul 2023
 11:14:55 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: Isaku Yamahata <isaku.yamahata@gmail.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v1] migration: refactor migration_completion
Thread-Topic: [PATCH v1] migration: refactor migration_completion
Thread-Index: AQHZtlGE+Wh4fGObDECF1brZ49mxaq+/CS6AgAADl6CABBq+gIAAbEQQ
Date: Fri, 21 Jul 2023 11:14:55 +0000
Message-ID: <DS0PR11MB6373FA83BFCF6706F671B36ADC3FA@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230714124823.25142-1-wei.w.wang@intel.com>
 <20230718054425.GA1807130@ls.amr.corp.intel.com>
 <DS0PR11MB6373E417A60B2DEF9EFE3697DC38A@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZLmbKSqrDvg7Tx4A@x1n>
In-Reply-To: <ZLmbKSqrDvg7Tx4A@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|DM6PR11MB4643:EE_
x-ms-office365-filtering-correlation-id: 4a12dc6d-1f22-4272-025b-08db89dbb65d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fCZfapzVzyztrbL5qmi3GPnUj65iTj+90xC9wNgEWee2d3uOJYjuXtZCjpY/4wKsaEN18aRpzVYicCWAqauaG77zVCmtKuEHuIWJC8XBIbEixcBNjLCIddOB1zlDVRF8lVwdZ1S9kBLZjPd707N9CbBA5y6/c5W3MQzotKNMfqQP8gC/8gKk78lv5he3iMHdzL9OC621DiBMI/zubnmhevPtXXQLTMiHfJy5Rhi9Om/JXjrgQVYGKraho5xl/vcZSYfP3v00lmvBkaj21tcmdqFPqYf/uU0QQCcsQQGdvj1Nns9CrL+07AggUXVuJitSPtqw8K77ozV45fKbgZXyL0NloJglRD1YeEmfK/rpjUyFtQlXaDuTKhnQarWM0EAokNoNFwzZmPMf+BSZB6Ovt7qn4OXba6EoZM8ty5fqf+xyVsPWG3quz5HcWjRDCzt3P5sYJCLpu3fktj8eDUnYGDd1sZz/VRU2pajBttyNdtGznlJocLNvqpSu+XkfcO+ZBzgRFvAD+3w8bvobQob9qzBpb5oytFgPrE1bIcSaedQ44OHcGFq0yGjGnkyMkca0Jq02AZyToA6OmHQELh6V4G45v3aOkN4+14588Gmg9zfMAAz7Ra+ACeskWhHCbakp3y5zb0UAPkCWvSZbIDFhwA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(9686003)(478600001)(7696005)(71200400001)(83380400001)(6506007)(26005)(5660300002)(186003)(52536014)(66446008)(64756008)(54906003)(66476007)(66946007)(6916009)(316002)(76116006)(4326008)(66556008)(53546011)(8676002)(8936002)(41300700001)(38070700005)(2906002)(86362001)(33656002)(55016003)(122000001)(82960400001)(38100700002)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDhSclJ2NzlLbFZadkdUZk14MnFncUZibUwzZUlabjNBTnNQRTAvemQyYUkw?=
 =?utf-8?B?dEZuUzJnSmUxbVltZStvRWJscUhuRXVwRk5sOGhUTldXa05PZExTZXA3SldI?=
 =?utf-8?B?b0VkR3l4akxPZjdNdSt6UFlJbjVhUWZUUVBnTGd4NHBnak1OdUpPVHJqdWNF?=
 =?utf-8?B?cTQ5WVJBeWtldGJEUXo1K2FyUmIrNDY3QlNtUjhSenA5cTFMazRHOG1LOXhN?=
 =?utf-8?B?NWNWU3hXV055SFJZa3RWdUhRQnM5d3ZIM2VTS3VPd0l6cHF3YXRIZGZIcG9r?=
 =?utf-8?B?RlZUSlhVRk1NQm9XTmlsb252WWFMNVIyZktENGh3N0Y0dkFaRGI4Rmg2WkY3?=
 =?utf-8?B?c0lKQjBtKzdoVm9HR0RTVFlZUFBSakR5WU91M2lyZlhqVmFGUzZScm5iVUox?=
 =?utf-8?B?Q21XSnlmSE5oaDNsRXN5YUFSOGMzcm1FRWRVVzNlUDBDSXJZbWEvTlAweEEr?=
 =?utf-8?B?Sm1PdGJoR0g2S3E5OTUyMGxZdEZzcUV1cmRNTXE5RmVtWTJkSFlIM3FwTzBh?=
 =?utf-8?B?eFd3QVh4dmdiYTN6YStHQVdOb0NGRXZIbEsvb2ZiZDFFcUFJN2M4RkM0Q0lK?=
 =?utf-8?B?Zmk4dnZhRGUrakxnc3EyZHdUa3ArK1UrZlZZKzRlMlFodmQ4NGNXdmJGeU5Q?=
 =?utf-8?B?RDBFSWhjRlJTc3NRa2tZbi9WVy8wdi9qaEVqQXN3K0JpSFU4ZzQ1ZVpMMjFx?=
 =?utf-8?B?Q2RzZE5CK3pHZ3duWEZxbUpkbXN1RDcwVmREU1FtRmZwbE8rZ2pxQkhPd2lw?=
 =?utf-8?B?U042Sy9DMEg3NDFJYnFySXlWMFVOLzlETkdLeWhmbW5iZFJHQ1JVdmFoWVhj?=
 =?utf-8?B?OWw3QklOK1ZFYWdOSVV1OTZpVlgvcUtHdVc4SzNBVXJLaFNoMFMxN1dHOHFO?=
 =?utf-8?B?Y3p6ZzIrZ1hYNzBXcTJnd3dTTTBJMm9xbzhqSkMrSEpKY093dTJpQnQyemU1?=
 =?utf-8?B?a25CSDkvU09zTDZZNTJjck92ckphWDN5NEhtdG1qUGF6Mkg1SEFsVjl0dXIz?=
 =?utf-8?B?b0d6RVpUZ0YwRW1VV01hTVNuWnB2Q1IzSGdZdTFCd2FNUGpLUmlyQTBXQlA2?=
 =?utf-8?B?VkFheHZQMzlPRE1kd1JJZ1dwdHhMcHdaMVlWYjNrQUFvM3duMTA5SDhiem1p?=
 =?utf-8?B?WTdqMzVLVExEaXErcGFVc2ttbnNFSm15Y1hpNXYyL2trSSt2WEFJRVR5b1lE?=
 =?utf-8?B?eWpZdUFlTmFNWjI3S2NPTzFMT1owMGdweWV5SVJkeG0vYmdzeDJWRC9DY3VQ?=
 =?utf-8?B?ek14ckM5Yys4NWU5M1Brb1I2TWNpU29abmdaMHl0MW9FZC9QVXRSdFB0MUtr?=
 =?utf-8?B?b2ZCeUVxbU96aUFzb0xQYW03N2kxQUlUZFpnKzJyZG9jazJyMi9aQ0dVaG4z?=
 =?utf-8?B?OGYwelhBR0lpM1hBTmJObjkwSXB2SkhEalcweVlUb3NrazdSYjZEUGo5dWlx?=
 =?utf-8?B?dkVUdWdUU2R2aGJoWms1cUhtaFgrYkhCVkhlUzczNElLcGJDaDQrYWlpeDJ6?=
 =?utf-8?B?Q3NBVzcxZUpMY3JiM3p5NHRFdGwvc0xJVDFUSThtbWxFeThxTVFtb1IxbWJj?=
 =?utf-8?B?Qmw0NE0zOGhwenphdkw5QXBLdVpwcE9BRVVaUHppaUd2SmVGYzlwejBaZUkr?=
 =?utf-8?B?bDVrSEFyQzZIelE5VjR6VkY3a2pGclBJbjJZN0VOL0lKM0FRUjRjZE5mQkZG?=
 =?utf-8?B?ODl6aXduQW10NmFzNVd4SEE4YnpXUEtBTmhyR21iWXVLcGpQTkJvN0tNMVhT?=
 =?utf-8?B?OU5zRGxKTitMZW5HTXM5TUl0WFh4N2hsYTBSaDYrR05STU84SHRBWnlhaVp4?=
 =?utf-8?B?T3VkYXVnM1hYWVM0NWx3RzZSWnVnWWFvc2lRMnVtaE00UjFteWlyNmtZb1ZN?=
 =?utf-8?B?TWtoUXFOaVpOYmZ2QmQvSkw4TnhKODR0aTJsVUpDVzBGc1lZOUZhZFVpNUF3?=
 =?utf-8?B?cnF6R0VZbW0zZWJsWkEwVFk4cnA0NDlEempiVlBXZTBUbVpBSTdTVytjL1lE?=
 =?utf-8?B?TUpjNVlLamFkNXdPc1ZTUGczL3QweTAramRIb3RyMUkrNzZYeGNwSjV3MldS?=
 =?utf-8?B?MzU0NE4vZU5GK3g3SS9remxtSWs5OWNyMTZqRFVkY0t5V3p6UUVZazFIQy8y?=
 =?utf-8?Q?cdiSaRRRk0S5ZGKQjeQ2lHW2n?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a12dc6d-1f22-4272-025b-08db89dbb65d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 11:14:55.3398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+HwrOMIOTwrVnBJRm8BPmq7kKD0VLdszsjCpaiT+cm1iHgeLneTFHPDwXsL86gJl2FFWIlmx69GtUPQCUvQfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4643
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=wei.w.wang@intel.com; helo=mga07.intel.com
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

T24gRnJpZGF5LCBKdWx5IDIxLCAyMDIzIDQ6MzggQU0sIFBldGVyIFh1IHdyb3RlOg0KPiBMb29r
cyBnb29kIHRvIG1lLCBhZnRlciBhZGRyZXNzaW5nIElzYWt1J3MgY29tbWVudHMuDQo+IA0KPiBU
aGUgY3VycmVudF9hY3RpdmVfc3RhdGUgaXMgdmVyeSB1bmZvcnR1bmF0ZSwgYWxvbmcgd2l0aCBt
b3N0IG9mIHRoZSBjYWxscyB0bw0KPiBtaWdyYXRlX3NldF9zdGF0ZSgpIC0gSSBiZXQgbW9zdCBv
ZiB0aGUgY29kZSB3aWxsIGRlZmluaXRlbHkgZ28gd3JvbmcgaWYgdGhhdA0KPiBjbXB4Y2hnIGRp
ZG4ndCBzdWNjZWVkIGluc2lkZSBvZiBtaWdyYXRlX3NldF9zdGF0ZSgpLCBJT1cgaW4gbW9zdCBj
YXNlcyB3ZQ0KPiBzaW1wbHkgYWx3YXlzIHdhbnQ6DQoNCkNhbiB5b3Ugc2hhcmUgZXhhbXBsZXMg
d2hlcmUgaXQgY291bGQgYmUgd3Jvbmc/DQooSWYgaXQgaGFzIGJ1Z3MsIHdlIG5lZWQgdG8gZml4
KQ0KDQo+IA0KPiAgIG1pZ3JhdGVfc2V0X3N0YXRlKCZzLT5zdGF0ZSwgcy0+c3RhdGUsIFhYWCk7
DQo+IA0KPiBOb3Qgc3VyZSB3aGV0aGVyIG9uZSBwcmUtcmVxdWlzaXRlIHBhdGNoIGlzIGdvb2Qg
dG8gaGF2ZSBzbyB3ZSBjYW4gcmVuYW1lDQo+IG1pZ3JhdGVfc2V0X3N0YXRlKCkgdG8gc29tZXRo
aW5nIGxpa2UgX19taWdyYXRlX3NldF9zdGF0ZSgpLCB0aGVuOg0KPiANCj4gICBtaWdyYXRlX3Nl
dF9zdGF0ZShzLCBYWFgpIHsNCj4gICAgIF9fbWlncmF0ZV9zZXRfc3RhdGUoJnMtPnN0YXRlLCBz
LT5zdGF0ZSwgWFhYKTsNCj4gICB9DQo+IA0KPiBJIGRvbid0IGV2ZW4ga25vdyB3aGV0aGVyIHRo
ZXJlJ3MgYW55IGNhbGwgc2l0ZSB0aGF0IHdpbGwgbmVlZA0KPiBfX21pZ3JhdGVfc2V0X3N0YXRl
KCkgZm9yIHJlYWwuLg0KPiANCg0KU2VlbXMgdGhpcyB3b3VsZCBicmVhayB0aGUgdXNlIG9mICJN
SUdSQVRJT05fU1RBVFVTX0NBTkNFTExJTkciLg0KRm9yIGV4YW1wbGUsIA0KLSBJbiBtaWdyYXRp
b25fbWF5YmVfcGF1c2U6DQptaWdyYXRlX3NldF9zdGF0ZSgmcy0+c3RhdGUsIE1JR1JBVElPTl9T
VEFUVVNfUFJFX1NXSVRDSE9WRVIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBuZXdfc3RhdGUpOw0KSWYgdGhlIGN1cnJlbnQgcy0+c3RhdGUgaXNuJ3QgTUlHUkFUSU9OX1NU
QVRVU19QUkVfU1dJVENIT1ZFUiAoY291bGQNCmJlIE1JR1JBVElPTl9TVEFUVVNfQ0FOQ0VMTElO
RyksICB0aGVuIHMtPnN0YXRlIHdvbuKAmXQgYmUgdXBkYXRlZCB0bw0KbmV3X3N0YXRlLg0KLSBU
aGVuLCBpbiBtaWdyYXRpb25fY29tcGxldGlvbiwgdGhlIGZvbGxvd2luZyB1cGRhdGUgdG8gcy0+
c3RhdGUgd29uJ3Qgc3VjY2VlZDoNCiAgIG1pZ3JhdGVfc2V0X3N0YXRlKCZzLT5zdGF0ZSwgY3Vy
cmVudF9hY3RpdmVfc3RhdGUsDQogICAgICAgICAgICAgICAgICAgICAgICAgIE1JR1JBVElPTl9T
VEFUVVNfQ09NUExFVEVEKTsNCg0KLSBGaW5hbGx5LCB3aGVuIHJlYWNoaW5nIG1pZ3JhdGlvbl9p
dGVyYXRpb25fZmluaXNoKCksIHMtPnN0YXRlIGlzDQpNSUdSQVRJT05fU1RBVFVTX0NBTkNFTExJ
TkcsIGluc3RlYWQgb2YgTUlHUkFUSU9OX1NUQVRVU19DT01QTEVURUQuDQo=

