Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F95B80C103
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 06:54:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCZEw-0003Kk-J2; Mon, 11 Dec 2023 00:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCZEt-0003KL-VX
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 00:53:59 -0500
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCZEs-0004jb-CM
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 00:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702274038; x=1733810038;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=N2I1W2NX5ewesifASoi9A2Pc5OxavWcOIrB0+i0APPY=;
 b=iAr0gjq2QrREnh2/Ud3yICNohfg7PGP4xfCItTtrjSaKZ30IjgiDPUcC
 UiVZuCUBuf8rbDqbEZQMGDJZNAb5VuAnABi6MoP+ikEkFuPpa7j/dYr1N
 KMjQqWMAXzzusMmQCwfWwV0e1BvZjytHYbhNFh8Fj4sdDB3b4IyW1vjDb
 xnS94C2eV3Qgukn2tphi8sAJmkkeBC4q0B123xruYuesvlOUofj3e0GAO
 1BfxkYCDe4XU9tbhXjekSkN1AROVga330GV4UIUg2lFHE2bpUijn4SuPq
 KBT/zsrnRACGRzNyNMpkftyWGgUCIIjspIoc5sFq1a8pwS8//zJTPCHHV w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="397384940"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; d="scan'208";a="397384940"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2023 21:53:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="916710571"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; d="scan'208";a="916710571"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Dec 2023 21:53:56 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 21:53:55 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 21:53:55 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 21:53:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ot0IDt46waNkdssfuRvNzAlFeVqb7jBcb15l3gXcSzi9Un2C2eBkpaC9/OvKUjNOrAOOEYyAfzHFtDtchcHA1s9B6/kknDGWzHEq3Gi9QYIok4dI7l6tq/kjwXZwkV5ibzznf7TauuC7eCVY/yQWlTywpDdggxr958DdelxPZclZNCWTiHNJSmwDlU5Bym4ncbrZ4HkbtFZxyJXnjLDyHEOy9ZmrQ/516q3yvNDaDe0KvNSCLDRzLsPfB1BrF+uqCruFLk6Aa2S9MutmZb3m1y/WrMq/+dKUUnUvkHLt4TiDtitRNM6FszE6O0/JyMGfl2OWZ0W0GXm0CU6aKwIqVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2I1W2NX5ewesifASoi9A2Pc5OxavWcOIrB0+i0APPY=;
 b=Y4BEz4jKRcfhQ+sc8+38AGGmcSS2cGLMWWFNc4O0BdWtEvJ1bC+XKUF7c/2386YuMHAeNK8U8IJLMfQQ+Bj7Ji1W3nHkdfEx+zwFWzgqmVudNR5eUcwZuPboLuVGUWXjnOnoDNKWGf5inMii6y0g/TzCFXR12gMI9Fjioxx6vKG+BHyGRDpiBuNMrmG1yAr6EQSNfvcCR9qqlMY7zFEuLIpkskxsFWF8s8457SKG5Yv6UHRYz8Z0ZW6HK6jouT7lzQTjDuCKr/t+w8xYa+76Nyd7hl8oK/qlv6Emexet/XFaFDEk+SFKOKa2SAOdlFHyOO+xJbQ14aXr2Hg+tJuc4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7947.namprd11.prod.outlook.com (2603:10b6:930:7a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 05:53:48 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 05:53:48 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>
Subject: RE: [PATCH for-9.0 02/10] vfio/container: Introduce
 vfio_legacy_setup() for further cleanups
Thread-Topic: [PATCH for-9.0 02/10] vfio/container: Introduce
 vfio_legacy_setup() for further cleanups
Thread-Index: AQHaKbMn3N6fKcQuhESU0+VQ0D+YBrCjmVBg
Date: Mon, 11 Dec 2023 05:53:48 +0000
Message-ID: <SJ0PR11MB6744987774DE324895390D25928FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231208084600.858964-1-clg@redhat.com>
 <20231208084600.858964-3-clg@redhat.com>
In-Reply-To: <20231208084600.858964-3-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7947:EE_
x-ms-office365-filtering-correlation-id: 3d643482-3ed0-4660-b12a-08dbfa0d8b4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: myGNQ4z1ZT0usRxp9vXFwkHw6JS2r7wb0FEQQfSP+xZVDeNY91ygduQUKxGoEt0Ukrb65DVtQ+K2hJCdEcGrtFgDMMG9ihznRyjfkw3yRrJ4bYQCThXC7ZU5GVLusobAFP1v8aNTcW+giH7PiozIPEilw83fytyXKfUFAsrE0R91TS5a8Gsmx1TXvLXwpPlcRvZ1/+sh3AqBpFcq1fUIQ1fZxMd6AWx5CcoSheRXbbBRLtL3/ox+u78I42zGAV43K06lfPC5X1dBBJia0TZ+gINt2W74X72yGRVmS/4fIPcxBG9zu7BBV5ymz5s5TBd3aje1Z+AJ4wydila+Hgyp3LPPlGGPVrC2WPcQRgufDnTQUb0rv2KZmyGOp2i8fGOy5YREzktaObS8Mjm/UIaLMiri8IXJY5d8k49KC6DCK0X8dL0t2TkYuVrJJ7WDklUyEX/6vjSVAomJ52MBYwkt751lIkRFpmZruh0SxJOBh6LWMJasqthf12cqX4JNXFWINg85nX14VRKXwUxkFhyA1aV/Kq96zlTyojJpqovld2kQXsvd2W6+gFZMl8+GIopSi/SEpJTfjvuKNVsXh7+aXowGKSemJoCQDBxt30Zaet/ZEJaOXxnNvuD14hezTe8F
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(9686003)(52536014)(6506007)(5660300002)(26005)(33656002)(55016003)(38070700009)(4744005)(76116006)(54906003)(66446008)(66476007)(66556008)(66946007)(64756008)(2906002)(83380400001)(82960400001)(41300700001)(478600001)(7696005)(86362001)(8676002)(8936002)(4326008)(122000001)(110136005)(316002)(38100700002)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFROK1F5KzNlNW8wUWVUaHVKWFBFUEtmaDR1K0M5dlRORXdxM2lySlJWTW0y?=
 =?utf-8?B?REhvTHlNakl5VTF5b1krVnlSZzNHci8yZGJhR29Gbms4UzFJenJFV0RONG5C?=
 =?utf-8?B?SDhmdXhzWHFhUEZucmxaVkdIb3djTzRqQmNJb3dJTXBNWm5KaE1uR1FaMm45?=
 =?utf-8?B?Y1lkSlcyaWQ5bXQ5eHJHSmo2cEVLR0Njd2dzeGk3UG41UjJCaUd4Q09JVnY4?=
 =?utf-8?B?OENqV0dXa1VhZGJETmpmUEJOM1ZMejBxa25vYUtPeFlFc1NnZjd6N1RwY0Ey?=
 =?utf-8?B?b05GY1ZmNWtwUitzeDJsTlJZZml4NS9ZdE1QQXFxOEloT215TmdNMDgwNFEz?=
 =?utf-8?B?R1RIM3pKd21IUVNBUTVlMEllK1ZYek5wRWhIZEtjQ3VWRFp4UW9jWVc3OStW?=
 =?utf-8?B?a2FQWlQvSnNnVTFubEI4elF2RVhlbGZETVNSbmtFZzRFeTBra2kyN0hzVjU1?=
 =?utf-8?B?dUxNYldFSDVnQytDT291c0RUdjZycFVLalZRMnFRZGhESTNqU0w0bDJndElw?=
 =?utf-8?B?M1dyQ2d6aHlQcllVT0dTL3hlQ1NYMWpNdWVJZ0NKUkhJQ3paejBvZVV0bU10?=
 =?utf-8?B?UUI1WE1hK0ZUOUhSbDdZOU95Z1BodXNHN1hPVkN5bFBaWmxyMVRtNmNwd1da?=
 =?utf-8?B?cDB2UUR1UDh1azF4dE9pa2NQLzQ2c3QwVmpSYkJMZCtVRDlKamhXQjRsclRT?=
 =?utf-8?B?ODBEK2xJbmxmVWdtaHJOdkdOT3JoL2FXZVg2MUQvYWFsY3BkTnZ1NE9ySGsw?=
 =?utf-8?B?U3JRbXA0OHYrTThBMkl6SkpkbUxlK1drZTJiQnlnS0pTNkFuUXg2Ty95STBU?=
 =?utf-8?B?UDhnVUtTZFZvcXZsbXMrcEd0QkV6R2RxS2xYZFpJNkJRTXhObm5Fa1FtVzlB?=
 =?utf-8?B?YnM0TzdsYnF2bnhVTE1SNTl3RzZwMDEyZDdZZzFhdDRLMjBnazFiZ0pyWU0r?=
 =?utf-8?B?OFlzNmhjYmJUNk9rcnBORGJTSlFqM25HWUFUUlpDeEplRTdLc1gvZzE4NnRs?=
 =?utf-8?B?dXhKamJmS2xyUzBKeURDaDZTWnFVVTR3cEJzMlh5ekMwNEVCR3Y2aXo1MDgy?=
 =?utf-8?B?OXRPYnFCM0ZGdkV4dmJDVzhhYVVaTjJMdnllRVlKcHd0L05jZ3FFODc0Y0tL?=
 =?utf-8?B?dGpLalFNVmRCZEZ4cS8vTWxzN2lxbndETmV1cnJRRndVZmREMG50M0pzVndX?=
 =?utf-8?B?bDhiUmpnNmh6UktqR3F6SEhZeUhzWklJZktWSEJaNVMxVHJ1YkFralJVSzZt?=
 =?utf-8?B?elg1bXpwakxmQkVpQ1gxRndLK0VqV1VNN0djaUpHZnZBaS95cEtVY3RoTlJQ?=
 =?utf-8?B?QUc1bnQzWmlKMFRpYUt0YkFWcHg5UlhiWXFOTStrRVhsMzJvTTh4MWdraFlT?=
 =?utf-8?B?Mk9aYmlGQlhDYzNaOVdiMndCUlI3OG9vMXlqWkgrZ0Y0YlRHVkMwL08vdGhL?=
 =?utf-8?B?ZFFOSmZQT2h5SVB3RTBKQmVLaFFhRjg5UGlBcUNUTHVQWGhZVDM4VXdJL2RD?=
 =?utf-8?B?Z0lNbkFwM1JkM0w4SVhqYWZrUWJJVUxSK0tDbHNDRWMrNU9tbUR4RWJ2WEp3?=
 =?utf-8?B?RS9qeVRXS2YwTk9MOE00a05FeVc2UjMwRFJhd0lROWpGWmtVYi9iU0pFaVFK?=
 =?utf-8?B?OGUwSTloa0plRjh1Tm8yU3F6VVkzcHlMaTNCNEF1VHpnMjdjdzJkQXhQUG9a?=
 =?utf-8?B?WWxDc1NOOGl0dEpGUUNQZkZlUUEwbWIxWFVFM0djdzJtQ1hRd0s2TXQwZEdG?=
 =?utf-8?B?SzFUNTVhNmJGS3NiajJTWUl1azhQR3JIVm5BRi8vdDlHUDFGM3Jnb08zMm1v?=
 =?utf-8?B?dFRqdzNrZDJaS01WZTVCRnVKTjd4NlN2cFo5anlYQ3NvZENBSHRNZkEwdmdY?=
 =?utf-8?B?ckdpMWNrMXV5YlkrdGszSEhoNmxDdHA1T2hpRVptSUdSODh2d1ZrUnJlMitJ?=
 =?utf-8?B?bzl2S3kxZ3ZVWWZJRGxzazZBZWhQMG9qTzFXZ1N3MGNJOHAvQU5iUmhGemho?=
 =?utf-8?B?bUhJOHZud1BDeEZ1T0xyNTVMMEdqZlREUmNiQTVMcXNlUmlaT1dleUk5allx?=
 =?utf-8?B?U09aUURPaEkvZHVIRFBxMkdXazVpanFxSitwZTFNVTB5MVljQTdQTWxFOWtr?=
 =?utf-8?Q?OL03KWHZGDpQwwNM0HNIGWqh2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d643482-3ed0-4660-b12a-08dbfa0d8b4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 05:53:48.1512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F70x7vlspUchCpD57IP0xQ8Qpfr2e0kqHA+VvMR9EUTDJlkQ5DEW5HQroFgwooqademGHphCB5EuwEJ+1toBBm3WROEXEkg6MCHRgqWxhJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7947
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIERlY2VtYmVyIDgsIDIwMjMgNDo0NiBQ
TQ0KPlN1YmplY3Q6IFtQQVRDSCBmb3ItOS4wIDAyLzEwXSB2ZmlvL2NvbnRhaW5lcjogSW50cm9k
dWNlIHZmaW9fbGVnYWN5X3NldHVwKCkNCj5mb3IgZnVydGhlciBjbGVhbnVwcw0KPg0KPlRoaXMg
d2lsbCBoZWxwIHN1YnNlcXVlbnQgcGF0Y2hlcyB0byB1bmlmeSB0aGUgaW5pdGlhbGl6YXRpb24g
b2YgdHlwZTENCj5hbmQgc1BBUFIgSU9NTVUgYmFja2VuZHMuDQo+DQo+U2lnbmVkLW9mZi1ieTog
Q8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogWmhlbnpo
b25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCg0KVGhhbmtzDQpaaGVuemhvbmcN
Cg0K

