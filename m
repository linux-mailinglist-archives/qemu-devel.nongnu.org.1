Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A227D3A19
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 16:55:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwKH-0005M7-8p; Mon, 23 Oct 2023 10:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1quwKF-0005Ls-B0
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 10:54:39 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1quwKC-0002HE-3s
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 10:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698072876; x=1729608876;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=e41pqJDc0Y+thsGnGjgM9ExdE38DXxbQWo3PcseTk0k=;
 b=Ij7z89E493/oeET0oH2c4RqH9ITAQf4MxkcOPrunyZsr+fwharBcn5UG
 jB/OR9d3MBJtonxBEzYHp4O0eU5tjUPrWRRg8PF2j5tNQgHuO18Mgd3Nd
 PeF4YbPM+huRgq7BorhzSpSBhAliNpfVrQIX6XzjFr8RCxMFsaxTkP+TZ
 xVkodaBA99CIXpLoog/QIm3DCFCqGQaypfkLLYpr10iJFHRWw5PZLHkmg
 kJ2GNH0pD76EFgHR7ws0cVPqa0Rzn6osHWhdoYYjug3Gq65XyjVBYtI6L
 1QfFO4rxNfz9Dgg4efPGAKC7tGEBNGY56yky77R+zscV2EU+6VZ8SMK20 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="453322868"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; d="scan'208";a="453322868"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2023 07:54:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="1005324165"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; d="scan'208";a="1005324165"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Oct 2023 07:54:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 07:54:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 07:54:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 07:54:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 07:54:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6dlhRBk0FMB0tLxgC9tbQEmtzbsliUgSbhDqljFj8DaO0CGNCbIizilHCgNzsh3otHhXfOun/DQluv2xyuN739I2SWuIJz6xR/kvlKeckKLFILsgVyd8YcOS1mFUc2dPbDs/fKI7PpcBrxn16t6r/7spCAVJehTtMrAb3JSd7WSyscWKdgNJMnP3KQYvoPdFF3LEhFgtLmp9fgJQIVgxffxrCWTeQCONBKprzjkh3PNZjBo3K1C6Z7hpZes2q6Rlucyv52vYYK4DfJ+wVfQksrk9mT59KtQMApSsbkE7GZm0lGYex4JVSKtmovqgBPK/7gUltT6xImkxePrKldAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e41pqJDc0Y+thsGnGjgM9ExdE38DXxbQWo3PcseTk0k=;
 b=DL4UiQhzJYYAMrug8y5yA7SIECZHWKVpqgH/kiok6pL8SarrM6uvqMi93JFIkE2msw7ZdEnJnjUcBIW+d7YMHCoZQdzO5YCzZOsZv/gC04yGSKkpEYVUqogVFK8Gws0xKiyGpwi9xfQWk7WBGUPPsDSnxP3DygylwOM0dQPU7WrtkFUrX7Sd03OtXOA2qs3BGNIMpgtazAQUxOxxwAPsfhq15Jj8qtiki6ZPNM2SLhqzoAHvpLTWlwp1vsLwYUflYkRcRWsDuEdCh9VZjJ1bL25XvmI2lIbjEwAiOSPfI3DxCKGmO6daB/jwDSqMuCrEtbDQ9EYJvdvKy5xctpHfUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4388.namprd11.prod.outlook.com (2603:10b6:a03:1c9::17)
 by SA2PR11MB4986.namprd11.prod.outlook.com (2603:10b6:806:114::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Mon, 23 Oct
 2023 14:54:27 +0000
Received: from BY5PR11MB4388.namprd11.prod.outlook.com
 ([fe80::a164:ef88:9f1a:8519]) by BY5PR11MB4388.namprd11.prod.outlook.com
 ([fe80::a164:ef88:9f1a:8519%3]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 14:54:27 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: "quintela@redhat.com" <quintela@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuQmVycmFuZ8Op?= <berrange@redhat.com>
CC: Peter Xu <peterx@redhat.com>, "farosas@suse.de" <farosas@suse.de>,
 "leobras@redhat.com" <leobras@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: RE: [PATCH 0/5] Live Migration Acceleration with IAA Compression
Thread-Topic: [PATCH 0/5] Live Migration Acceleration with IAA Compression
Thread-Index: AQHaAmKFMfJOhFrqz0aucJcr+N/dnbBQ/WaigAA1hgCAAAi9gIAAAmkAgAW4zJCAADwXgIAABRy0gAA/ziA=
Date: Mon, 23 Oct 2023 14:54:27 +0000
Message-ID: <BY5PR11MB4388E6857043B7ADA8A581BEA3D8A@BY5PR11MB4388.namprd11.prod.outlook.com>
References: <20231018221224.599065-1-yuan1.liu@intel.com>
 <87cyxa6dso.fsf@secure.mitica> <ZTFCnqbbqlmsUkRC@redhat.com>
 <ZTFJ84SnSOAcU5gY@x1n> <ZTFL+N3mxESxXpfv@redhat.com>
 <BY5PR11MB4388F9495DD42ACCFB980A6CA3D8A@BY5PR11MB4388.namprd11.prod.outlook.com>
 <ZTZLI1r+U5EbX12E@redhat.com> <87cyx5ty26.fsf@secure.mitica>
In-Reply-To: <87cyx5ty26.fsf@secure.mitica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4388:EE_|SA2PR11MB4986:EE_
x-ms-office365-filtering-correlation-id: 6de7e8c8-5a2b-4abd-62ed-08dbd3d7f44b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E0Vp6VcciFmBjhiMOAC2jB9znQxdvG8vb7UXgjkHwYpx4GQ4ijqkjWpyUI3tvFmtqCgoX4xRiN3WaPUu0VTYkpk/67CKaDwRh6ip7x6hr47/T2elDDwmYuuEz33nnhjvGwLGiceBqC4fguqqN9gDToFQQZhNfPLNRotmSST3ZMC9ECI/z4P8AcKBV6f3nYeVPLePqMe3E/NNLS5Tnl5oB6qVLuPkknPN42+SE6tfBq1xrorcXl4rlx51AyRz3S6hR9CHd6Co/L8Qo5ktdREYcB9A99dgj9qi5eyunvlfk4ZmKDSYVNMyyt06xOqOSLqtLUwAJ5o5nqjrElMtegj8i9CAnci+gTgKkvX3x5i3+BKdLGNo+NBPc/FAZdrwCSvMinyVzIBVG0x+VgeuDrKl/+Dv1436VhwwOcti0hgoyZJCTelIenqSlLiHJTdBOZcj7VXjikuVYXaCy1vtvpHd724HQLrHNBhU519a5Jl0ibM2gyDFvtyreqEiy5hkmRkntiUjql4mYEdEWlKGdEXelouuOOhKBs8QGY4G//qdKJ3zE1ox/7W4ikpMv2/jXkkWDRi1/a0T1AG9/Jw4saEJEFiycFD+8kNRG6TOztpLcw4VRYDh880mZml5miPOZcUo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4388.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38070700009)(26005)(107886003)(55016003)(38100700002)(2906002)(41300700001)(52536014)(86362001)(5660300002)(4326008)(8676002)(8936002)(33656002)(7696005)(71200400001)(478600001)(110136005)(82960400001)(6506007)(122000001)(316002)(64756008)(76116006)(66446008)(66476007)(54906003)(66556008)(66946007)(83380400001)(53546011)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3VYRjhiRVI4eWo5SDlya1B0ZVhHZ2VIM3k1Yi81ZFpUSmd4dDVnSFFBSDBU?=
 =?utf-8?B?UkhyYWMrWUpVelBwMFE5R0lPaDJuUkxiYVQ1MHQ5N0JDaDNJZEY3WWNoZVlw?=
 =?utf-8?B?alI3Q0crWFdIMmgxSDFjTmMrblNYWWxQQmNYRzNYN1NvQTRxQ0pvNFhtSm5n?=
 =?utf-8?B?LzRlMDYxM3NBWG9xaVVUUm0zMy9VUVNwSFZxSlZ0SjJiNTZaRUdKWkVVKzRr?=
 =?utf-8?B?dmJTbjNiNkFsMWZPTHNKNGhQcHFCdWdqTWZSSnZyWnpHYzUwU3VTbUtRajgw?=
 =?utf-8?B?TjR3QmpOckFSUHhybTRINFJCb0JiSktYUFBsS0NRbnVScDU1OEpoK1U4b1dp?=
 =?utf-8?B?d1RubFc0MkcySnJHdGl5cmhqTjAxbFl0ZjZZc2E2ck9BaWdrYk5yczBNeDNH?=
 =?utf-8?B?ZWI1MTNDeGg3Zjd2cXNuaWZlUzJDekdFMlhPQno0OWtzYkVLdnVGalA3cUN5?=
 =?utf-8?B?MTV4bWRuc21heEJoSjI2UFVoTDdlYUhQaU1vblRJNHBJUUpCQUdVTFo3emRS?=
 =?utf-8?B?UERhMXZncG5XM1MzNXBROHVpalkxMVdpVitjYm1sQWhNYmNoOFRvSmVPbW11?=
 =?utf-8?B?cnZqQ2xFeGlpaGRGV0lQcW9ubklCZHM5ZXJrRWRZSzdpam53Sm9SM3I5eW51?=
 =?utf-8?B?K3pLT1E1bzJwZ1ljMVMvUm9teHVoMTkzVTlpSEVMTGJTdnhCT05hbmd4czFB?=
 =?utf-8?B?K0dwS1JHOENveHd2N2MxQXNCV3ZrS0lEOCtOQXhXOUR1OVZ4cFR1WUVqb3dp?=
 =?utf-8?B?U1ovL2tGMXEwcXR0SHU1M29BaDRhNmVmNDA1SVE5bDNFTzAwT09EdXhxN3BZ?=
 =?utf-8?B?V2JnVURKcVk4RnkyZlFWcFU5V2lic2FVaE1QZkYzYlgzaTViVWM3dnczSHBz?=
 =?utf-8?B?OEp3eTdrYk1mR1JyMFBlUGNIbnkrYnllaUtwQUluV0tDcnJxNnFIcjVwWGUr?=
 =?utf-8?B?L05aN1ErN0xvTVVSVTZnd3R5SHpuYnlFMjJmT0xPN051dzVuRHZBbUtOVWJ5?=
 =?utf-8?B?dm0rWjcreDhRdXZiOElGaHkyRTJCNzNRQWdNNndxOEtmeHIyOHVQUGtNNkU1?=
 =?utf-8?B?ckd5NS9hRno1UDJyYm90MEdubENPbUlGNHpUeldla01LUlNSN3VpNUx4M2Fv?=
 =?utf-8?B?dSs3YkhObWErdlY3anFjZEJOZWVuU1BmWTJ0V2pleVVmM2ZmM0xaSTlCM3Zw?=
 =?utf-8?B?amNlQkRtYnM5dVZNZXNDNjJkTlRxdTVGWDcwSW40VzdKdHZJQjVUTWxlK1V0?=
 =?utf-8?B?NHg0SVZqM2F1M2RLTXBYUUMzRmp0Y3NEd3ZncjhnbW8wNXhOTHd3eEYrRjcx?=
 =?utf-8?B?N01KNTNDZlhDMzE3SzhyakREdGc3VGNaZ1NQT2Z0NzA4NUJobmdVRTd5N2hq?=
 =?utf-8?B?dksrSjh5eUZURmFsM2R5MmEyblFHbm9LM3pKaFVQMTlZeThTcUFEL1BSUHYv?=
 =?utf-8?B?VXBtYjZwTDVpTjFGcjdQVDcyaG1qR0VKa2hNdXBoWVlBNG5nT0RZMUtTYWVX?=
 =?utf-8?B?TXc4TTh5SzhEcWcvcnNYLzh5NTBja0ZPY0NtK3V3SXV3L2txV2d6RjRNd3R6?=
 =?utf-8?B?dGFyRmhLbkV3WVNwNnkxRmQ5VkFUTitBQkR4TlFacTNBdUlqTVNlSE4zQm1P?=
 =?utf-8?B?aFNDOUxFdC8wR09SVnRhQlRsVXhwTTZ5QUszQWFFSmQzNVdtemVFS3hNQits?=
 =?utf-8?B?ZEhDMGpUb3I4bnFzSmNRY0lOdmFPbGFyM0RVd2krNFlVellLNnpQc05QZGJt?=
 =?utf-8?B?Vnl4YTRRVzB1cUR6d3Z4eXdYVG5POUc5bTk1dlVNUGwyTkh6c0R3QVRQNzRR?=
 =?utf-8?B?bmJ4dFdvQXpUc09nRDN5aTY5SGkrcFdYVkpWdE1PS1M2WnE3OVlPem1vQ0c5?=
 =?utf-8?B?ekc2S21iUFZ6L2RMaVUzTWhyenNZWUEwY05jSmZzM0NnUXA0OWNTdmE3R1A5?=
 =?utf-8?B?ckhVeGc3WXBTa1pUaGtCbllZSWV5NzVDb2l6a1Y5YW93SDdSMzNKQlZvZ2p5?=
 =?utf-8?B?YTM2V0t3T3VjY1I3Y3hraU1GNVRZRkVXa1QwaTZxRDlCL2dTM0pVeXlab1pT?=
 =?utf-8?B?VnZsSHN3S0Y5Rzh6QjZYUTdMTUF1bDN2Q01SbkhiaDNMMEtMRWxJSmpUajR1?=
 =?utf-8?Q?v2Krz11WmQ3/qlI0PGzsL3ox/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4388.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de7e8c8-5a2b-4abd-62ed-08dbd3d7f44b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 14:54:27.2743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rsOwN+CB57jU5VSRcT6ovx8HX6H5A+qITg2VftNpFCwaTAz7CmrlGykvr1P/Z5SUw6pPXgtP0UeVAD6RIWhRsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4986
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKdWFuIFF1aW50ZWxhIDxxdWlu
dGVsYUByZWRoYXQuY29tPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMjMsIDIwMjMgNjo0OCBQ
TQ0KPiBUbzogRGFuaWVsIFAuQmVycmFuZ8OpIDxiZXJyYW5nZUByZWRoYXQuY29tPg0KPiBDYzog
TGl1LCBZdWFuMSA8eXVhbjEubGl1QGludGVsLmNvbT47IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0
LmNvbT47DQo+IGZhcm9zYXNAc3VzZS5kZTsgbGVvYnJhc0ByZWRoYXQuY29tOyBxZW11LWRldmVs
QG5vbmdudS5vcmc7IFpvdSwNCj4gTmFuaGFpIDxuYW5oYWkuem91QGludGVsLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAwLzVdIExpdmUgTWlncmF0aW9uIEFjY2VsZXJhdGlvbiB3aXRoIElB
QSBDb21wcmVzc2lvbg0KPiANCj4gRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0
LmNvbT4gd3JvdGU6DQo+ID4gT24gTW9uLCBPY3QgMjMsIDIwMjMgYXQgMDg6MzM6NDRBTSArMDAw
MCwgTGl1LCBZdWFuMSB3cm90ZToNCj4gPj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+PiA+IEZyb206IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+
ID4+ID4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMTksIDIwMjMgMTE6MzIgUE0NCj4gPj4gPiBU
bzogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KPiA+PiA+IENjOiBKdWFuIFF1aW50ZWxh
IDxxdWludGVsYUByZWRoYXQuY29tPjsgTGl1LCBZdWFuMQ0KPiA+PiA+IDx5dWFuMS5saXVAaW50
ZWwuY29tPjsgZmFyb3Nhc0BzdXNlLmRlOyBsZW9icmFzQHJlZGhhdC5jb207IHFlbXUtDQo+ID4+
ID4gZGV2ZWxAbm9uZ251Lm9yZzsgWm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwuY29tPg0K
PiA+PiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC81XSBMaXZlIE1pZ3JhdGlvbiBBY2NlbGVyYXRp
b24gd2l0aCBJQUENCj4gPj4gPiBDb21wcmVzc2lvbg0KPiA+PiA+DQo+ID4+ID4gT24gVGh1LCBP
Y3QgMTksIDIwMjMgYXQgMTE6MjM6MzFBTSAtMDQwMCwgUGV0ZXIgWHUgd3JvdGU6DQo+ID4+ID4g
PiBPbiBUaHUsIE9jdCAxOSwgMjAyMyBhdCAwMzo1MjoxNFBNICswMTAwLCBEYW5pZWwgUC4gQmVy
cmFuZ8OpIHdyb3RlOg0KPiA+PiA+ID4gPiBPbiBUaHUsIE9jdCAxOSwgMjAyMyBhdCAwMTo0MDoy
M1BNICswMjAwLCBKdWFuIFF1aW50ZWxhIHdyb3RlOg0KPiA+PiA+ID4gPiA+IFl1YW4gTGl1IDx5
dWFuMS5saXVAaW50ZWwuY29tPiB3cm90ZToNCj4gPj4gPiA+ID4gPiA+IEhpLA0KPiA+PiA+ID4g
PiA+ID4NCj4gPj4gPiA+ID4gPiA+IEkgYW0gd3JpdGluZyB0byBzdWJtaXQgYSBjb2RlIGNoYW5n
ZSBhaW1lZCBhdCBlbmhhbmNpbmcNCj4gPj4gPiA+ID4gPiA+IGxpdmUgbWlncmF0aW9uIGFjY2Vs
ZXJhdGlvbiBieSBsZXZlcmFnaW5nIHRoZSBjb21wcmVzc2lvbg0KPiA+PiA+ID4gPiA+ID4gY2Fw
YWJpbGl0eSBvZiB0aGUgSW50ZWwgSW4tTWVtb3J5IEFuYWx5dGljcyBBY2NlbGVyYXRvciAoSUFB
KS4NCj4gPj4gPiA+ID4gPiA+DQo+ID4+ID4gPiA+ID4gPiBFbmFibGluZyBjb21wcmVzc2lvbiBm
dW5jdGlvbmFsaXR5IGR1cmluZyB0aGUgbGl2ZQ0KPiA+PiA+ID4gPiA+ID4gbWlncmF0aW9uIHBy
b2Nlc3MgY2FuIGVuaGFuY2UgcGVyZm9ybWFuY2UsIHRoZXJlYnkgcmVkdWNpbmcNCj4gPj4gPiA+
ID4gPiA+IGRvd250aW1lIGFuZCBuZXR3b3JrIGJhbmR3aWR0aCByZXF1aXJlbWVudHMuIEhvd2V2
ZXIsIHRoaXMNCj4gPj4gPiA+ID4gPiA+IGltcHJvdmVtZW50IGNvbWVzIGF0IHRoZSBjb3N0IG9m
IGFkZGl0aW9uYWwgQ1BVIHJlc291cmNlcywNCj4gPj4gPiA+ID4gPiA+IHBvc2luZyBhIGNoYWxs
ZW5nZSBmb3IgY2xvdWQgc2VydmljZSBwcm92aWRlcnMgaW4gdGVybXMgb2YNCj4gPj4gPiA+ID4g
PiA+IHJlc291cmNlIGFsbG9jYXRpb24uIFRvIGFkZHJlc3MgdGhpcyBjaGFsbGVuZ2UsIEkgaGF2
ZQ0KPiA+PiA+ID4gPiA+ID4gZm9jdXNlZCBvbiBvZmZsb2FkaW5nIHRoZSBjb21wcmVzc2lvbg0K
PiA+PiA+IG92ZXJoZWFkIHRvIHRoZSBJQUEgaGFyZHdhcmUsIHJlc3VsdGluZyBpbiBwZXJmb3Jt
YW5jZSBnYWlucy4NCj4gPj4gPiA+ID4gPiA+DQo+ID4+ID4gPiA+ID4gPiBUaGUgaW1wbGVtZW50
YXRpb24gb2YgdGhlIElBQSAoZGUpY29tcHJlc3Npb24gY29kZSBpcyBiYXNlZA0KPiA+PiA+ID4g
PiA+ID4gb24gSW50ZWwgUXVlcnkgUHJvY2Vzc2luZyBMaWJyYXJ5IChRUEwpLCBhbiBvcGVuLXNv
dXJjZQ0KPiA+PiA+ID4gPiA+ID4gc29mdHdhcmUgcHJvamVjdCBkZXNpZ25lZCBmb3IgSUFBIGhp
Z2gtbGV2ZWwgc29mdHdhcmUNCj4gcHJvZ3JhbW1pbmcuDQo+ID4+ID4gPiA+ID4NCj4gPj4gPiA+
ID4gPiBBZnRlciByZXZpZXdpbmcgdGhlIHBhdGNoZXM6DQo+ID4+ID4gPiA+ID4NCj4gPj4gPiA+
ID4gPiAtIHdoeSBhcmUgeW91IGRvaW5nIHRoaXMgb24gdG9wIG9mIG9sZCBjb21wcmVzc2lvbiBj
b2RlLCB0aGF0IGlzDQo+ID4+ID4gPiA+ID4gICBvYnNvbGV0ZSwgZGVwcmVjYXRlZCBhbmQgYnVn
Z3kNCj4gPj4gU29tZSB1c2VycyBoYXZlIG5vdCBlbmFibGVkIHRoZSBtdWx0aWZkIGZlYXR1cmUg
eWV0LCBidXQgdGhleSB3aWxsDQo+ID4+IGRlY2lkZSB3aGV0aGVyIHRvIGVuYWJsZSB0aGUgY29t
cHJlc3Npb24gZmVhdHVyZSBiYXNlZCBvbiB0aGUgbG9hZA0KPiA+PiBzaXR1YXRpb24uIFNvIEkn
bSB3b25kZXJpbmcgaWYsIHdpdGhvdXQgbXVsdGlmZCwgdGhlIGNvbXByZXNzaW9uDQo+ID4+IGZ1
bmN0aW9uYWxpdHkgd2lsbCBubyBsb25nZXIgYmUgYXZhaWxhYmxlPw0KPiA+Pg0KPiA+PiA+ID4g
PiA+IC0gd2h5IGFyZSB5b3Ugbm90IGRvaW5nIGl0IG9uIHRvcCBvZiBtdWx0aWZkLg0KPiA+PiBJ
IHBsYW4gdG8gc3VibWl0IHRoZSBzdXBwb3J0IGZvciBtdWx0aWZkIGluZGVwZW5kZW50bHkgYmVj
YXVzZSB0aGUNCj4gPj4gbXVsdGlmZCBjb21wcmVzc2lvbiBhbmQgbGVnYWN5IGNvbXByZXNzaW9u
IGNvZGUgYXJlIHNlcGFyYXRlLg0KPiA+DQo+ID4gU28gdGhlIGNvcmUgcXVlc3Rpb24gaGVyIChm
b3IgbWlncmF0aW9uIG1haW50YWluZXJzKSBpcyB3aGV0aGVyDQo+ID4gY29udHJpYnV0b3JzIHNo
b3VsZCBiZSBzcGVuZGluZyBhbnkgdGltZSBhdCBhbGwgb24gbm9uLW11bHRpZmQgY29kZSwNCj4g
PiBvciBpZiBuZXcgZmVhdHVyZXMgc2hvdWxkIGJlIGV4Y2x1c2l2ZWx5IGZvciBtdWx0aWZkID8N
Cj4gDQo+IE9ubHkgZm9yIG11bHRpZmQuDQo+IA0KPiBDb21wYXJpc29uIHJpZ2h0IG5vdzoNCj4g
LSBjb21wcmVzc2lvbiAoY2FuIGJlIGRvbmUgYmV0dGVyIGluIG11bHRpZmQpDQo+IC0gcGxhaW4g
cHJlY29weSAod2UgY2FuIHNhdHR1cmF0ZSBmYXN0ZXIgbmV0d29ya3Mgd2l0aCBtdWx0aWZkKQ0K
PiAtIHhienJsZTogcmlnaHQgbm93IG9ubHkgbm9uLW11bHRpZmQgKHBsYW4gdG8gYWRkIGFzIGFu
b3RoZXIgbXVsdGlmZA0KPiAgICAgICAgICAgY29tcHJlc3Npb24gbWV0aG9kKQ0KPiAtIGV4ZWM6
IFRoaXMgaXMgYSBoYXJkIG9uZS4gIEZhYmlhbm8gaXMgYWJvdXQgdG8gc3VibWl0IGEgZmlsZSBi
YXNlZA0KPiAgICAgICAgIG11bHRpZmQgbWV0aG9kLiAgQWR2YW50YWdlcyBvdmVyIGV4ZWM6DQo+
ICAgICAgICAgICAqIG11Y2ggbGVzcyBzcGFjZSB1c2VkIChpdCB3cml0ZXMgZWFjaCBwYWdlIGF0
IHRoZSByaWdodA0KPiAgICAgICAgICAgICBwb3NpdGlvbiwgbm8gb3ZlcmhlYWQgYW5kIG5ldmVy
IHRoZSBzYW1lIHBhZ2Ugb24gdGhlIHR3bw0KPiAgICAgICAgICAgICBzdHJlYW1zKQ0KPiAgICAg
ICAgICAgKiBXZSBjYW4gZ2l2ZSBwcm9wZXIgZXJyb3JzLCBleGVjIGlzIHZlcnkgYmFkIHdoZW4g
dGhlIGV4ZWMnZA0KPiAgICAgICAgICAgICBwcm9jZXNzIGdpdmVzIGFuIGVycm9yLg0KPiAgICAg
ICAgIERpc2FkdmFudGFnZXM6DQo+ICAgICAgICAgICAqIGxpYnZpcnQgKG9yIGFueSBtYW5hZ2Vt
ZW50IGFwcCkgbmVlZHMgdG8gd2FpdCBmb3INCj4gICAgICAgICAgICAgY29tcHJlc3Npb24gdG8g
ZW5kLCBhbmQgbGF1bmNoIHRoZSBleGVjIGNvbW1hbmQgYnkgaGFuZC4NCj4gICAgICAgICAgICAg
SSB3YW50ZWQgdG8gZGlzY3VzcyB0aGlzIHdpdGggbGlidmlydCwgaWYgaXQgd291bGQgYmUNCj4g
ICAgICAgICAgICAgcG9zc2libGUgdG8gcmVtb3ZlIHRoZSB1c2Ugb2YgZXhlYyBjb21wcmVzc2lv
bi4NCj4gLSByZG1hOiBUaGlzIGlzIGEgaGFyZCBvbmUNCj4gICAgICAgICBDdXJyZW50IGltcGxl
bWVudGF0aW9uIGlzIGEgbWVzcw0KPiAgICAgICAgIEl0IGlzIGFsbW9zdCB1bi1tYWludGFpbmVk
DQo+ICAgICAgICAgVGhlcmUgYXJlIHR3by10aHJlZSB5ZWFycyBvbGQgcGF0Y2hlcyB0byBtb3Zl
IGl0IG9uIHRvcCBvZg0KPiAgICAgICAgIG11bHRpZmQNCj4gLSBwb3N0Y29weTogTm90IGltcGxl
bWVudGVkLiAgVGhpcyBpcyB0aGUgcmVhbCByZWFzb24gdGhhdCB3ZSBjYW4ndA0KPiAgICAgICAg
IGRlcHJlY2F0ZSBwcmVjb3B5IGFuZCBwdXQgbXVsdGlmZCBhcyBkZWZhdWx0Lg0KPiAtIHNuYXBz
aG90czogIFRoZXkgYXJlIHRvIGNvdXBsZWQgd2l0aCBxY293Mi4gIEl0IHNob3VsZCBiZSBwb3Nz
aWJsZSB0bw0KPiAgICAgICAgIGRvIHNvbWV0aGluZyBtb3JlIHNlbnNpYmxlIHdpdGggbXVsdGlm
ZCArIGZpbGUsIGJ1dCB3ZSBuZWVkIHRvIHdhbGsgdGhhdA0KPiAgICAgICAgIHBhdGggd2hlbiBt
dWx0aWZkICsgZmlsZSBoaXQgdGhlIHRyZWUuDQo+IA0KPiA+IEkgZG9lc24ndCBtYWtlIGEgbG90
IG9mIHNlbnNlIG92ZXIgdGhlIGxvbmcgdGVybSB0byBoYXZlIHBlb3BsZQ0KPiA+IHNwZW5kaW5n
IHRpbWUgaW1wbGVtZW50aW5nIHRoZSBzYW1lIGZlYXR1cmVzIHR3aWNlLiBJT1csIHNob3VsZCB3
ZSBiZQ0KPiA+IGRpcmVjdGx5IGNvbnRyaWJ1dG9ycyBleHBsaWNpdGx5IHRvd2FyZHMgbXVsdGlm
ZCBvbmx5LCBhbmQgZXZlbg0KPiA+IGNvbnNpZGVyIGRlcHJlY2F0aW5nIG5vbi1tdWx0aWZkIGNv
ZGUgYXQgc29tZSB0aW1lID8NCj4gDQo+IEludGVsIHN1Ym1pdGVkIHNvbWV0aGluZyBzaW1pbGFy
aXNoIHRvIHRoaXMgb24gdG9wIG9mIFFBVCBzZXZlcmFsIG1vbnRocyBiYWNrLg0KPiBJIGFscmVh
ZHkgYWR2aXNlZCB0aGVtIG5vdCB0byB1c2UgYW55IHRpbWUgb24gdG9wIG9mIG9sZCBjb21wcmVz
c2lvbiBjb2RlIGFuZA0KPiBqdXN0IGRvIHRoaW5ncyBvbiB0b3Agb2YgbXVsdGlmZC4NCj4gDQo+
IE9uY2UgdGhhdCB3ZSBhcmUgaGVyZSwgd2hhdCBhcmUgdGhlIGRpZmZlcl1lbmNlcyBvZiBRUEwg
YW5kIFFBVD8NCj4gUHJldmlvdXMgc3VibWlzc2lvbiB1c2VkIHFhdHppcC1kZXZlbC4NClRoYW5r
IHlvdSB2ZXJ5IG11Y2ggZm9yIHRoZSBRQVQgc3VnZ2VzdGlvbnMuIFFQTCBpcyB1dGlsaXplZCBm
b3IgSUFBLCBhbmQgcWF0emlwLWRldmVsIGlzIHV0aWxpemVkIGZvciBRQVQsIGJvdGggb2YgdGhl
bSBhcmUgY29tcGF0aWJsZSB3aXRoIHpsaWIuIA0KUWF0emlwLWRldmVsIGV4Y2x1c2l2ZWx5IHN1
cHBvcnRzIHN5bmNocm9ub3VzIGNvbXByZXNzaW9uIGFuZCBkb2VzIG5vdCBzdXBwb3J0IGJhdGNo
IG9wZXJhdGlvbnMuIENvbnNlcXVlbnRseSwgZm9yIHNpbmdsZS1wYWdlIGNvbXByZXNzaW9uLCB0
aGUgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgbWF5IG5vdCBiZSBzaWduaWZpY2FudC4gQW5kIFFQ
TCBzdXBwb3J0cyBib3RoIHN5bmNocm9ub3VzIGFuZCBhc3luY2hyb25vdXMgY29tcHJlc3Npb25z
Lg0KDQo=

