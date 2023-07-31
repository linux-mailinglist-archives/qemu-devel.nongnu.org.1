Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A9E769086
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 10:42:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQOSq-00039u-Dp; Mon, 31 Jul 2023 04:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qQOSc-00038D-Kn
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:41:04 -0400
Received: from [192.55.52.88] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qQOSa-0003ga-Ch
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690792860; x=1722328860;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SscUATA0BahEdphJ3pvCmc78p+Ptosa8aCBrTvqS9BE=;
 b=cv8IK3uTRDnkTXYAzrQdkhUjgSxhXxoGDp9G0n2pyrZDbUuNNoqaduQF
 n7JD9yvK4ump2kdEOQdWXPQV22oIeo6JQqhf0UR7dUiW2zr3TdpOIRUzb
 vIPmbSxLZ6xNhCGyxlRF/SgPee+w82LpXXTAECmp7hIaJX+W9nrquRK3u
 07jCdQpDNRf7PoUB3kRTl7BPia64V5qpMC7iVV+LvuubK3+PagpKNa7Sw
 XM6QeMp9XjSy5YNY/ezAy8oepyxVqv0N0jN0SN7CuSWaJP6I2QBogH7om
 PuP+ZRz2uTng36LC51OyZ5Uv+iGiQRnAOowucSFNeWIqOEwOEDurKoD7Q g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="399904211"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="399904211"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 01:40:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="731516328"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="731516328"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga007.fm.intel.com with ESMTP; 31 Jul 2023 01:40:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 01:40:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 01:40:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 01:40:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6b9IGkcycsx3Y0kQ0jVNL3S/3DVBaC1Gj+fKzLOsnFxpT2nh5PZNh2so8rabpCaOnDSvFalgQRC9wgthP0JFnhd6N/jFCHSyztjaboU3hHiQxIr8kZ62Kp3OJ8t0t3f+jeMG00pk9G4Xji448DKAotYQFBM2y0QMK2wq+m3Nw4fRS74e/jen99yozVcY4qZllH/1+KcGR1oDZ4gOR6IrdC9r0pyMFvjJrE6ffZ9LyPFiunQnaa2evnQ7xPd0EF3JLd/D5K7EZgdu65F5AysPEanUUdnkvttzuMHEppn+I16iEdlPBYUHGbF2SF04bmpIOtBgYavy/0xMuXEF11b3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SscUATA0BahEdphJ3pvCmc78p+Ptosa8aCBrTvqS9BE=;
 b=jVCcBIJk1dty9cPnm7viYJ6Gcili9zS2Fnlxeqhbkl/gSnOe+w3Hrik62ZuQV3P6jaG4qwJuCOX23NJ5SzwAltof4isCx7qE0j4Bwjq/9l0TDz4jiCd7o+XRziEYn+C0owfd7z5SNuWM+AcG6BikkQswl+EcWcyXygkbKhCOCvcE0xeEQ1qLLx4xRpBuZ1DTO9ibE0UVy+nUT/cahM5R+XdvZqUEpN+jg6yNeE51zVX8LFZYw/cAa0WU47aACZ2zKR6XKgTRJ54oVGd/LxC1Kyk8sHCJ+xi9NkYqvjRMepOyDlCjwpmZaO/+RM2s/utWAyDtkL/bHXqePURnZuV78Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8114.namprd11.prod.outlook.com (2603:10b6:8:129::6) by
 PH7PR11MB8456.namprd11.prod.outlook.com (2603:10b6:510:2fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 08:40:55 +0000
Received: from DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::5de4:80fa:4a96:5dbd]) by DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::5de4:80fa:4a96:5dbd%7]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 08:40:54 +0000
From: "Liu, Jing2" <jing2.liu@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Chatre, Reinette" <reinette.chatre@intel.com>, "Liu, 
 Jing2" <jing2.liu@intel.com>
Subject: RE: [PATCH RFC v1 1/3] vfio/pci: detect the support of dynamic MSI-X
 allocation
Thread-Topic: [PATCH RFC v1 1/3] vfio/pci: detect the support of dynamic MSI-X
 allocation
Thread-Index: AQHZwFtnD/lhplXI/0is72NhiwHcDa/N1lcAgAD+laCAAAmiAIAEZZ/wgAA7hYCAABQ7sA==
Date: Mon, 31 Jul 2023 08:40:54 +0000
Message-ID: <DS0PR11MB81144008CEEBE00EF30B5151A905A@DS0PR11MB8114.namprd11.prod.outlook.com>
References: <20230727072410.135743-1-jing2.liu@intel.com>
 <20230727072410.135743-2-jing2.liu@intel.com>
 <841b1ff1-0a50-e9c9-d405-256a16ffdf8c@redhat.com>
 <DS0PR11MB8114B633ED8814B272673415A906A@DS0PR11MB8114.namprd11.prod.outlook.com>
 <8e44b87f-c22c-9071-1ffe-7d16cff58869@redhat.com>
 <DS0PR11MB8114EDC8682BC265FFFA34C8A905A@DS0PR11MB8114.namprd11.prod.outlook.com>
 <6187ba85-5082-02e9-159b-1abb6b6371e9@redhat.com>
In-Reply-To: <6187ba85-5082-02e9-159b-1abb6b6371e9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8114:EE_|PH7PR11MB8456:EE_
x-ms-office365-filtering-correlation-id: db1a6fd0-428e-491e-1d94-08db91a1dab3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 604EClbDT2kPhHvNfl7pbPfj+zK0CjtujzkTzF7z7zBRLYEmEv5DOl1ISTEJMqE4VzOQ55rkhOMrFRYLCbg6ypU1ksKbqylaJPDEGZmfl5iGjDDcQ/zF9Aqzq0YqoHrnj7neGESuY0lY9PYDmkK6fRtAKKUfw2OYzx7maxrHutJ2rbNQnK7FBHV1zrGx5Y9qe0p6WxICtOAnYGhPctmMw30+J/FCfQYqcXPnTZUlFOkECvLqC8EdyD91HAr0uw/JYCcukihuNZpxRLX2jT0PZxsVNSU8NVOV1m0TuTtg725FmhOxBvlZ+rp7Es96mbh/CJZLrwQgfjfUxIse5c6p75Iqwz7QcJWI6qniudzs5FR8lolY07BwTuxpdfgmF5zbLWmkPILJisWNz2O2m2NI7XDX+Ja0bN9TDG+gKhV6UCBK555BNKznioJiCDootNVCkLE8wM/fV92e2e7aSP8nREPnqBbapnE59PQJ4btBmD2D/d0uK38hKlqCrrjYI6kdpTx1hYs29TiCFHbBYNljMSG/Ws2qzDG1//UtH4GhHr6sQAz0sFJ83J9GRTUHW0dOUCJMRWkg2ldltMErQp0t9yW32MCvMn5BSxKC+gKxgBVN8Wz/l31ANCaApZxsA/XZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8114.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199021)(66476007)(86362001)(41300700001)(8936002)(8676002)(316002)(5660300002)(4326008)(66446008)(64756008)(122000001)(38070700005)(33656002)(66946007)(66556008)(52536014)(76116006)(54906003)(110136005)(82960400001)(478600001)(2906002)(38100700002)(71200400001)(9686003)(7696005)(107886003)(6506007)(26005)(83380400001)(66574015)(186003)(53546011)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE1VZG1FT3lZd3laY1FqNGxmUUVmZFQrV3RSL2h0ejJsTjlOMHRhUFc4YmNV?=
 =?utf-8?B?K2tGdkFJTTBUTjBGTVhKWlJ3Ylg2cGpPM01JVzNvWk1IdytBR0x3Sm5IbTJp?=
 =?utf-8?B?dlJ4R0VkZXllRDlSbEZkdk1RQUNJbzVJbHIreGh3Tis2Ky9VZ3JxZjV3bHlw?=
 =?utf-8?B?UjkvL1Y2anppVjZ6VzZRQlczdzQxdWFtczVtMXhaWUk4Q1oxVUY0MVpHZ2ww?=
 =?utf-8?B?SE9RTFRid3JtSnA5aUxHY1Nza1JKSzVTaW5Jb2NaVFhsVVhQUlVobTdSU0pV?=
 =?utf-8?B?UWttbTNPa1VIRUFOQ2NUd0ZSQlBaU0NvWXpDYTJ4NjZIK1dvYkc5QXhtL2RB?=
 =?utf-8?B?enp0aFRyRXdPSnFUZUVJRG05SkJ0OUh3NEw0R2doczJjMWtWTVRWOXZjbTlS?=
 =?utf-8?B?bTVmV2FPN1NoZ1BvVkdRVitEVjBZRUNYMU91b1RHUWNnNzRWcXFnczV2UU1Q?=
 =?utf-8?B?TCtnMlZzZmkyQ2NSZ3JPUVlhdXZSYW5lZ1dhYzZlRzVyTStwZkZSQXhKZnVa?=
 =?utf-8?B?bnlmMWsvZzlKMC8wK2JBcHZzSjZVV1lpaGdiMkpYMHRQazZMTDVDOHdUdGFx?=
 =?utf-8?B?eCsraUpIT2hKT2dEb3gvVXlsNFlidTMxYnF2bEE3cFpXeVJlZjI2UTRvRThr?=
 =?utf-8?B?K3lSTjllL0pyNmthVUpYZlhxdUI4cis3NGJ5MXNNbkJNUzV5T1B2c1pINi9j?=
 =?utf-8?B?cHM5QzBLei9SbnpubTNjMlcwZVR3YzB6NzNsVCtDbFVKdCtuU3k2d3N1Ni9E?=
 =?utf-8?B?clBNWlBpK0g1ZU41ZVFWSEsyaEc5cGJJcm5TQi9qMVBHZVJtYXliNkhnYURo?=
 =?utf-8?B?dHV5VG9mQmZMRUJTeHlvMnZqcnE5Y01xalVxRllUd1pVY2JKTGNZMXV4UGdS?=
 =?utf-8?B?Um9mSlprM0lhaG1BOWVBdFo0cEFXVllxUmJXcUdJQVBYMkRPRjZCdmgvSUd0?=
 =?utf-8?B?R2E2ZldPK3k4UWJtNVlrMmFUMXZUNzRYdnlvYXNFWkZMNVFUcE1mUVNncElT?=
 =?utf-8?B?MTQ1UWRWdlBPVEptVVV6Z29zUmlPcllxSjJrOUxib3ZvOHVwSVgxNCtpN3pu?=
 =?utf-8?B?SjJPRXpiRFFFUzh2ajUzY004N3pLV3gvQlZBeFpYMXI3a0ZLdU5FVTV2Y0JB?=
 =?utf-8?B?a0pwVjQ3b1pHRHdsTkZiSnpiL2VwTkxOV0lSZHhuT2ZnS2hkblhiOGZkeHZ2?=
 =?utf-8?B?WWV6Z3FESUNnTGV3NHI5a0RCcEpPZUw2UCtWOGFmLzd3UXRqZWNhRk5KVUpK?=
 =?utf-8?B?MEZzaHgxM3pqVGN4Tk1WeFdTbXRKclBJSUZMMVQwM0JmblcxdGlOTXFLaGww?=
 =?utf-8?B?TkJlSENYLzY3WDRVVmg4UTY4bm5OUHRkaUE3K2YxNkJJRURmNnArNVd0dVpo?=
 =?utf-8?B?OVlHY2dRL0tvMHMzVCtvZWJwakhITnNmS3ZIK0NJMDY2MjN6Skx4b0ptMG1P?=
 =?utf-8?B?Q3VBODJhTmtCS2xDODdPQUNOT216WStCMlFxK3JVK1FpbVBvWlJPd0JnV2Fi?=
 =?utf-8?B?L3YweWlqQ2VQYkJxdzhQMVZyS3o1NUpEb1B1QzNEZjlHdTk1eXA0TkxwTXE2?=
 =?utf-8?B?VmlEaWJXZ1dtSm1Uang3Sm5lRUhkNnZ2bUZYTlI0bUJOVTZ5cnNZMjNzb1Fx?=
 =?utf-8?B?a1NoWm1MUWsvVGVIRWhVZ0ozQ3NJaDllR1RkSFVoT1JackhzakF2Tno0N3hQ?=
 =?utf-8?B?OGdLV1ltTVc3QkpCaTkyMllWVnBJQ3pNbUdrTlBDV2pobGFvQjMrV3p0WmdM?=
 =?utf-8?B?N3NsM1dmN0p0RXlpOWFWZHBXcnlTOU5aMm1aUy81bkxuZ0wyNlV4LzhMMzNJ?=
 =?utf-8?B?R3pOWS91T3VYM1N1U0dJVEQ1SUtCUVh5WERnQnJ1akYvWmpzU1JGSTZUZksy?=
 =?utf-8?B?YXNPa1h1b3BBcGtpdWthTWsycVV6QjdSN1FKVVdFUFVpdTNzT1FIMzJtNDJZ?=
 =?utf-8?B?R0x5aHprd2poYlkrRkpsRHNDZ2xrdDJESUZ2SEJWb280WnN3UEJRMnhUQnlZ?=
 =?utf-8?B?Zk9TeDFpcCtRRi8xY2JwdnRjUXQraHU4NEltMG9EcmQyUjRGRzNmelViM05i?=
 =?utf-8?B?Vmd5VWVhWWNCcTd0ak15Y0JxSXcxaThCREYvOTNLZmEwT1Q3YlE5NndqYUNW?=
 =?utf-8?Q?GZQZhA4qR5ZzCauk5It261RVI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8114.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1a6fd0-428e-491e-1d94-08db91a1dab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 08:40:54.7972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PDIHkA7g33hvnSzrYaja7E6BlSz+2yBMnQdi1TGx8gBE6Tq5VDwpSB4fY0Bes6TBL2htD9eiAKC0yhgT9WX+0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8456
X-OriginatorOrg: intel.com
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.55.52.88 (failed)
Received-SPF: pass client-ip=192.55.52.88; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

SGkgQy4NCg0KPiBPbiBKdWx5IDMxLCAyMDIzIDM6MjYgUE0sIEPDqWRyaWMgTGUgR29hdGVyIDxj
bGdAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiA3LzMxLzIzIDA1OjU3LCBMaXUsIEppbmcy
IHdyb3RlOg0KPiA+IEhpIEMuDQo+ID4NCj4gPj4gT24gSnVseSAyOCwgMjAyMyA0OjQ0IFBNLCBD
w6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+IHdyb3RlOg0KPiA+Pg0KPiA+PiBbIC4u
LiBdDQo+ID4+DQo+ID4+PiBTb3JyeSBJIGRpZG4ndCBxdWl0ZSB1bmRlcnN0YW5kICJpbmZvLmZs
YWdzIGJlIHRlc3RlZCBhZ2FpbnN0DQo+ID4+IFZGSU9fSVJRX0lORk9fTk9SRVNJWkUiLg0KPiA+
Pj4gSSBzYXcga2VybmVsIDwgNi40IHNpbXBseSBhZGRlZCBOT1JFU0laRSB0byBpbmZvLmZsYWdz
IGFuZCBsYXRlc3QNCj4gPj4+IGtlcm5lbCBhZGRzDQo+ID4+IGlmIGhhc19keW5fbXNpeC4NCj4g
Pj4+IFdvdWxkIHlvdSBwbGVhc2Uga2luZGx5IGRlc2NyaWJlIG1vcmUgb24geW91ciBwb2ludD8N
Cj4gPj4NCj4gPj4gSSB3YXMgdHJ5aW5nIHRvIGZpbmQgdGhlIGNvbmRpdGlvbnMgdG8gZGV0ZWN0
IHNhZmVseSB0aGF0IHRoZSBrZXJuZWwNCj4gPj4gZGlkbid0IGhhdmUgZHluYW1pYyBNU0ktWCBz
dXBwb3J0LiBUZXN0aW5nIFZGSU9fSVJRX0lORk9fTk9SRVNJWkUNCj4gc2VlbXMgZW5vdWdoLg0K
PiA+Pg0KPiA+IE9oLCBJIHNlZS4NCj4gPg0KPiA+Pj4+IEluIHRoYXQgY2FzZSwgUUVNVSBzaG91
bGQgcmVwb3J0IGFuIGVycm9yIGFuZCB0aGUgdHJhY2UgZXZlbnQgaXMNCj4gPj4+PiBub3QNCj4g
Pj4gbmVlZGVkLg0KPiA+Pj4NCj4gPj4+IEkgcmVwbGllZCBhbiBlbWFpbCB3aXRoIG5ldyBlcnJv
ciBoYW5kbGluZyBkcmFmdCBjb2RlIGJhc2VkIG9uIG15DQo+ID4+PiB1bmRlcnN0YW5kaW5nLCB3
aGljaCByZXBvcnRzIHRoZSBlcnJvciBhbmQgbmVlZCBubyB0cmFjZS4gQ291bGQgeW91DQo+ID4+
PiBwbGVhc2UNCj4gPj4gaGVscCByZXZpZXcgaWYgdGhhdCBpcyB3aGF0IHdlIHdhbnQ/DQo+ID4+
DQo+ID4+IHllcy4gSXQgbG9va2VkIGdvb2QuIFBsZWFzZSBzZW5kIGEgdjEgIQ0KPiA+DQo+ID4g
VGhhbmtzIGZvciByZXZpZXdpbmcgdGhhdC4gSSBndWVzcyB5b3UgbWVhbiB2MiBmb3IgbmV4dCB2
ZXJzaW9uIPCfmIoNCj4gDQo+IFdlbGwsIGlmIHlvdSByZW1vdmUgdGhlIFJGQyBzdGF0dXMsIEkg
dGhpbmsgeW91IHNob3VsZCwgdGhpcyB3b3VsZCBzdGlsbCBiZSBhIHYxLg0KPiANCk9oLCBnb3Qg
aXQuIFRoYW5rcyBmb3IgdGVsbGluZyB0aGlzLg0KDQpKaW5nDQoNCj4gVGhhbmtzLA0KPiANCj4g
Qy4NCg0K

