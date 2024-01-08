Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED10582676A
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 04:27:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMgH8-0001tK-0h; Sun, 07 Jan 2024 22:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rMgH5-0001sq-5Q
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 22:26:03 -0500
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rMgH2-0002rb-DW
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 22:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704684360; x=1736220360;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7+a283POKq98yu3zdW1n9PGTCkj+ywZ+QdHDC893Dmw=;
 b=Kq5idU9Jk8e6wZdJVbLc1//9BshwDbEf5v4IryOvTOPLs1VXzCo3Hjow
 8h0N20WJrfLugqxUiKZbh1DWdfzLBEBTkuV6HtP1D+WN9kXuvsJ5RePKk
 kkye6a2xm8qpXb6KyPv7huqqHewWKyejDaII/erXXY49yYo+RciuAzAXl
 x9bXntmy8aSGqTxkxdjS/lIOQRTRwprJak79FG00INZu1ZMRRexzJdF35
 wgZmNFsgKPMOyiIR2SAq6jZtf/MhiAFgQVjhjzyDRSuO5affjGqrF7aBl
 wCgCkEA/Yfsl+prqT/YkM0RA1Hs2djHG6YkJ+0EUQrT0zu2EAiKD47sfh w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="377930099"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; d="scan'208";a="377930099"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2024 19:25:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="900245888"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; d="scan'208";a="900245888"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Jan 2024 19:25:57 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 19:25:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 19:25:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Jan 2024 19:25:56 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Jan 2024 19:25:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elwqkn8JQp4wZOauptBjJB+OhSDBD4IdYwP/ngN/rcYbOkVFPg1+V0i74o+9stC+ioRSizZdtKKcMKrxB+0yNdCnro20ONccwogzgJRN7SephDfZ54QdaT/9Uu5iTBM5V9v/sLr3PpOtINQzQZQIcluef68imHLmApM0U0zo5p39HTLnqkk4piSX7uHVsXO8R+Z2lNmU+FbdLC/Emqv6iI2n+yPc8mWGEA8/NdL7eynFb+PdTLAo8ZiCKhHgm/TjeAEOCD2ia5u7HmZSYDXuufrr87Sx2CUyhyt+llbK1FB5LvntlnkkBjweJOPBaz0WCdmOTH5SjFngEJCFg2++rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+a283POKq98yu3zdW1n9PGTCkj+ywZ+QdHDC893Dmw=;
 b=klrF6RkVjUjE78yPvwynaXg1ckp8FjfVY81tDCISOvySGDh9+gddbTe5+T+7Hqk8CDdg9O7wvSqiXk8eri6/lwJ9KubDtbG09nJp2MJrNqVZ64+XRk1VDsZzTGWp+sZ6odIG3Zba30/Cu7o/dToFbjI0C1w/uvmeZ7zD7QLeh6IxNivq0BnHwdks/whN2/SO9w7peSl7/UD5xIWi9o8hAdoBNS3DfRHguYQ3qelT6QwUYZqpQ+XTvujRi6ZokI7cTpYgYS5KeDDvdY3M+ZenFODvg2m1Dp3kVYONpCbjCi8dMu2rwEwqPA5P9nv+fr+izhKpQ6HjNkhXylPHsO6zQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by DM4PR11MB6120.namprd11.prod.outlook.com (2603:10b6:8:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 03:25:54 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f0ec:877c:fd93:a04c]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f0ec:877c:fd93:a04c%3]) with mapi id 15.20.7159.013; Mon, 8 Jan 2024
 03:25:54 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Hao Xiang <hao.xiang@bytedance.com>, Fabiano Rosas <farosas@suse.de>
CC: Bryan Zhang <bryan.zhang@bytedance.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "berrange@redhat.com" <berrange@redhat.com>
Subject: RE: [External] Re: [PATCH 3/5] migration: Introduce unimplemented
 'qatzip' compression method
Thread-Topic: [External] Re: [PATCH 3/5] migration: Introduce unimplemented
 'qatzip' compression method
Thread-Index: AQHaQBLbbmpfHBoi10eEBscMUOnzCrDL5F2AgANemYA=
Date: Mon, 8 Jan 2024 03:25:53 +0000
Message-ID: <PH7PR11MB5941E2494C523E92DAF57DF7A36B2@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20231231205804.2366509-1-bryan.zhang@bytedance.com>
 <20231231205804.2366509-4-bryan.zhang@bytedance.com> <87jzon8ryv.fsf@suse.de>
 <CAAYibXgNC1vL1i9M9Sj1J1GS_msxTMJS+B143qFO0pnF4UQGKA@mail.gmail.com>
In-Reply-To: <CAAYibXgNC1vL1i9M9Sj1J1GS_msxTMJS+B143qFO0pnF4UQGKA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|DM4PR11MB6120:EE_
x-ms-office365-filtering-correlation-id: 4bcad338-96ef-49d4-56a9-08dc0ff9856a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZEH3XWhMX6SlDrW3GbNWw6O0jPhkwP03+0uRYO+3O2z7Cb3zK8CrhUlQo5pq6Mn2h+97uMfLEvNrtuYY6229eMuns0GRq5+27xeSPiBI/Bz2bPfsRFHrpt1koutnc4nhXk6pxFvaiwiRXg9e/8+QaVo1X1itKWF4SgN2oOYxHGwBFIf50+9qDU/QGp2RwGkpx7+k/Fo5AebaT/ani21gEQn8XJCCQFXThzXznKmfeACt7BD84/CMhtVqJyQRUgzFdY/IUsIQBuO7v5OvsLyrqnJd1xHFO82NLRhdb1GM1c+vcHq2Jo8UjYBblW3Lmm5YcM00dFCMGYpkNWF6pSo8uQznnaQ9e7hyfTS90Wq6ZHSsIJnj9DR+3kvEEwMn+xFCwhWoVwCXmnPdT1NuON/6y95OSpN6DhVP0mtvwguu4ZCfXKyV+QUD0MKL4BlCZJR/LA0AayhLEG0YcH5c4LpgfWgc4PhDTIfLmc/17BntiJVJibe/2Yor+34Zd7cD26i+4ksiujwNiAyuKj6TIfe/8c33BhY+3CVKtC7rQkZF4SdLGm53l+cH3QlRPhoF/epcB0U0UkeomGP9X3jIC0KO2omKdwpHme9X2lZ/aLaLyTPXkyEDWvAr42c4giD5U67AdcmN9Lp0axW/Yxi6iV11Ez52EpQqfP4gLGz7Wy4k6PJ5Mbsi5fCtsTZj52GAThvF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230273577357003)(230922051799003)(230173577357003)(64100799003)(186009)(451199024)(1800799012)(55016003)(26005)(9686003)(53546011)(7696005)(6506007)(478600001)(71200400001)(966005)(38100700002)(122000001)(86362001)(33656002)(82960400001)(5660300002)(2906002)(41300700001)(83380400001)(38070700009)(110136005)(66946007)(66556008)(66476007)(66446008)(54906003)(316002)(64756008)(76116006)(4326008)(8676002)(52536014)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmtSYjVlSktLeHVyQW1QRk1DaFM1SlBtL2I0UXlaK3Npc0ZQN25yTm5XN1Q1?=
 =?utf-8?B?UmhKKzd4MnZxZ0E4R1NnNk1FQ0JRbnRqNkdheFg3ekNwL1NDU2hqdjFjWjRx?=
 =?utf-8?B?RXE3RlIrTno3WmxkRDFkQ0wvSTFvRFNiVG5BY0ZoVmRpR2FxQ3l1M2YxQmVK?=
 =?utf-8?B?ZDhNZHdzdnN4b3NHTWdIZkxZWlZ3Z1VpbUlsUU4vWXVsSmdnZWJOSnBXbEw5?=
 =?utf-8?B?MjZPTnhpVTZjTkQrZEpPR09zYlVRTlkyTnVBSDIxQytpVVJzMlJueU84dFY4?=
 =?utf-8?B?SG5NdnRhZDl6SzFyMzA4eWlUZWlyY3pkL3NFU21vM0M5RVlGL3hzSmJDRkpv?=
 =?utf-8?B?UjFDYjUwYWtzR3Iyc01FMlpDdlNFeVhrVWVuNzMvMVdBVkV0UVNoTnBDeTZx?=
 =?utf-8?B?MCtrVFdzZjFmME5LTHZ0LzBEa25zWmJuK2NWdFMxZ3JWbmoxR0xseHR3c2ta?=
 =?utf-8?B?SFE0RS84VDBEaFR0Ty9TWkhLZGlud3hLM2RHdXpMMCtRVmdHeEZZcWJRd0Fj?=
 =?utf-8?B?bmtxVkdxRmMrV1IzV0VGNzZKUzN4R20wVVQrM2c5OThvODlaZ1lXbFhrQ0lT?=
 =?utf-8?B?THdWbG05U3hUc1ArM2dlbFpDdWhLTWpSU1B6WDJxd3lZdk4yYU0wbCtpUEYw?=
 =?utf-8?B?cTlaUXo5bEZWSHE0dGgySXJSdHlkb3pPWWxEMmtKYzZaOG0xK1dxRDBtM3pZ?=
 =?utf-8?B?SVQyREVFQVBaUy93R29Sa3NOdnJyajhsUFpHMVJIazVWK2ZkUWV1RHg5MFF1?=
 =?utf-8?B?R2RuMTNOZWVxR1pWUDZIOXNaanprWkY1SThYa0xkUUNVenVYZUYwTnhJZmNC?=
 =?utf-8?B?MTlXdkFORVVidnRWU01GUE1VcTV4alRhN1pLV2taei9VVXNIM0hvRllCVTJT?=
 =?utf-8?B?YmpmVElodnpycUdhTlA5QTVHcEZuRjVzWFNEUVlhb2ZRM2tlRDJES1FSZWxh?=
 =?utf-8?B?TDRkOS9sL1RPZFMvSlNCNmI4UER0ajNqU2lQOGVvcERPZm1mN1VJZFhqZGd6?=
 =?utf-8?B?V2hiY0dwTEJVallBNEdRU25zQ3l5RFRZNXZHK3B0MzFzajkzK3JSaEdtckxB?=
 =?utf-8?B?aFNIRFgzYjBxYTh5aXFGOEpJNXV0Uy84R3VFYWFOaXNNeHp6VGp3bUxpSFE2?=
 =?utf-8?B?Z2xodFpMK3dqTEk5TDZPZUF5eWdhTmZLbGxvcHpLK0Q2N1ZVZjlDTlVTbms2?=
 =?utf-8?B?V1dmVGM1RDlrRTVqdFBKR2dCYlVRSGxpd0lNQy85dkF3Q0pZbzJ5c0RDMjF3?=
 =?utf-8?B?bTFzY1YrS1Z2b243T3Z2REhZSHQ1R3Z2UjZNc0RjM0FrSHlNZU51ZGJCVkx6?=
 =?utf-8?B?eHM1Y0pUd3FLcjJCOUFmYWhpMm94bU1UMFhWS0wvb1pMeGJxR0hITHNQMFVP?=
 =?utf-8?B?ZEpYSUVOVkRkZWF3YnVadVIzYTlIVXd4Q0lDYVFlWTZWZDVVYlEvSHhlNjNq?=
 =?utf-8?B?cDRVMFZxZGhMOERlYjRKZC84Y3pRZXBuOUNoTXh0dU4zZlVQb25FYUtXbjZT?=
 =?utf-8?B?RW4xYWJkTGE4dE9tWmVqbDdjZmtwM0l1NkJTZ1dRNkFSYkI3aXdSWXczd2pw?=
 =?utf-8?B?L1oyS3FsVHZNVmtOVTF6TjhQVzY0WVJkSlRGNUpxcXhDUGlMc1psSFcrV2R1?=
 =?utf-8?B?SXovaFFRZitCQjFzYy96N3VPSEQ0d2RxdFlEVlBQbzhidXZ5TEhwOXhPK0Ja?=
 =?utf-8?B?VUd6aWhpZGI2cWhLSUE3aEQyTHd5b0NnNVAvWm1rY01aVDlRT0tRYVVQWFlh?=
 =?utf-8?B?dlVoakpKNHlyOXQyVlJYd2p6T2tyK0wxWDh5Y3VjYzE5QVRLRHhpbDBHU0ZW?=
 =?utf-8?B?VlFaai9KN21XdzVieThuaExRZnRzTjJ3VVYvTUJ6emp6YTJ2Y3N4a2ZsNjVY?=
 =?utf-8?B?eUhZaDJoQmdTdXJDMnkrTFJTNTBWaEkwNXVRZEtReWNnaUt2RDhQcjlGSzR3?=
 =?utf-8?B?bkNoUkdJQkdHVzZPNTFpTWRRTTU3cmp4bHdQQ0ZHbjdGZTYzOW9BSDZoN1dr?=
 =?utf-8?B?byt2bkF6ZjNQakh4K0QwNG52aks2NjRtdDdubGVnTWp6VEYvUThXakd1WXJl?=
 =?utf-8?B?UUV5TnB0OHkvMjlnMTJmVVZqbk8wMlhENUtvWHZITzZYYjNlaU9uVmxpZ1VZ?=
 =?utf-8?Q?IrhD2JPINCa0sCcQe0yEMZwwD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcad338-96ef-49d4-56a9-08dc0ff9856a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 03:25:53.8774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: edFkHF5F4v7yCjN6pEDHdYMrEkS2X2f02EJeaWxxgHjOUbl2D2a8B1PP2fWmNzPZqkjH1iylLWDIkHc4QBkoVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6120
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.151; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW8gWGlhbmcgPGhhby54aWFu
Z0BieXRlZGFuY2UuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgSmFudWFyeSA2LCAyMDI0IDc6NTMg
QU0NCj4gVG86IEZhYmlhbm8gUm9zYXMgPGZhcm9zYXNAc3VzZS5kZT4NCj4gQ2M6IEJyeWFuIFpo
YW5nIDxicnlhbi56aGFuZ0BieXRlZGFuY2UuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0K
PiBtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb207IHBldGVyeEByZWRoYXQuY29tOyBxdWludGVs
YUByZWRoYXQuY29tOw0KPiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IExpdSwgWXVhbjEgPHl1
YW4xLmxpdUBpbnRlbC5jb20+Ow0KPiBiZXJyYW5nZUByZWRoYXQuY29tDQo+IFN1YmplY3Q6IFJl
OiBbRXh0ZXJuYWxdIFJlOiBbUEFUQ0ggMy81XSBtaWdyYXRpb246IEludHJvZHVjZSB1bmltcGxl
bWVudGVkDQo+ICdxYXR6aXAnIGNvbXByZXNzaW9uIG1ldGhvZA0KPiANCj4gT24gRnJpLCBKYW4g
NSwgMjAyNCBhdCAxMjowN+KAr1BNIEZhYmlhbm8gUm9zYXMgPGZhcm9zYXNAc3VzZS5kZT4gd3Jv
dGU6DQo+ID4NCj4gPiBCcnlhbiBaaGFuZyA8YnJ5YW4uemhhbmdAYnl0ZWRhbmNlLmNvbT4gd3Jp
dGVzOg0KPiA+DQo+ID4gK2NjIFl1YW4gTGl1LCBEYW5pZWwgQmVycmFuZ8OpDQo+ID4NCj4gPiA+
IEFkZHMgc3VwcG9ydCBmb3IgJ3FhdHppcCcgYXMgYW4gb3B0aW9uIGZvciB0aGUgbXVsdGlmZCBj
b21wcmVzc2lvbg0KPiA+ID4gbWV0aG9kIHBhcmFtZXRlciwgYnV0IGNvcHktcGFzdGVzIHRoZSBu
by1vcCBsb2dpYyB0byBsZWF2ZSB0aGUNCj4gPiA+IGFjdHVhbCBtZXRob2RzIGVmZmVjdGl2ZWx5
IHVuaW1wbGVtZW50ZWQuIFRoaXMgaXMgaW4gcHJlcGFyYXRpb24gb2YNCj4gPiA+IGEgc3Vic2Vx
dWVudCBjb21taXQgdGhhdCB3aWxsIGltcGxlbWVudCBhY3R1YWxseSB1c2luZyBRQVQgZm9yDQo+
ID4gPiBjb21wcmVzc2lvbiBhbmQgZGVjb21wcmVzc2lvbi4NCj4gPiA+DQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBCcnlhbiBaaGFuZyA8YnJ5YW4uemhhbmdAYnl0ZWRhbmNlLmNvbT4NCj4gPiA+IFNp
Z25lZC1vZmYtYnk6IEhhbyBYaWFuZyA8aGFvLnhpYW5nQGJ5dGVkYW5jZS5jb20+DQo+ID4gPiAt
LS0NCj4gPiA+ICBody9jb3JlL3FkZXYtcHJvcGVydGllcy1zeXN0ZW0uYyB8ICA2ICsrLQ0KPiA+
ID4gIG1pZ3JhdGlvbi9tZXNvbi5idWlsZCAgICAgICAgICAgIHwgIDEgKw0KPiA+ID4gIG1pZ3Jh
dGlvbi9tdWx0aWZkLXFhdHppcC5jICAgICAgIHwgODENCj4gKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gPiA+ICBtaWdyYXRpb24vbXVsdGlmZC5oICAgICAgICAgICAgICB8ICAx
ICsNCj4gPiA+ICBxYXBpL21pZ3JhdGlvbi5qc29uICAgICAgICAgICAgICB8ICA1ICstDQo+ID4g
PiAgNSBmaWxlcyBjaGFuZ2VkLCA5MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKSAgY3Jl
YXRlIG1vZGUNCj4gPiA+IDEwMDY0NCBtaWdyYXRpb24vbXVsdGlmZC1xYXR6aXAuYw0KPiA+ID4N
Cj4gPiA+IGRpZmYgLS1naXQgYS9ody9jb3JlL3FkZXYtcHJvcGVydGllcy1zeXN0ZW0uYw0KPiA+
ID4gYi9ody9jb3JlL3FkZXYtcHJvcGVydGllcy1zeXN0ZW0uYw0KPiA+ID4gaW5kZXggMWEzOTY1
MjFkNS4uZDhlNDhkY2IwZSAxMDA2NDQNCj4gPiA+IC0tLSBhL2h3L2NvcmUvcWRldi1wcm9wZXJ0
aWVzLXN5c3RlbS5jDQo+ID4gPiArKysgYi9ody9jb3JlL3FkZXYtcHJvcGVydGllcy1zeXN0ZW0u
Yw0KPiA+ID4gQEAgLTY1OCw3ICs2NTgsMTEgQEAgY29uc3QgUHJvcGVydHlJbmZvIHFkZXZfcHJv
cF9mZGNfZHJpdmVfdHlwZSA9IHsNCj4gPiA+IGNvbnN0IFByb3BlcnR5SW5mbyBxZGV2X3Byb3Bf
bXVsdGlmZF9jb21wcmVzc2lvbiA9IHsNCj4gPiA+ICAgICAgLm5hbWUgPSAiTXVsdGlGRENvbXBy
ZXNzaW9uIiwNCj4gPiA+ICAgICAgLmRlc2NyaXB0aW9uID0gIm11bHRpZmRfY29tcHJlc3Npb24g
dmFsdWVzLCAiDQo+ID4gPiAtICAgICAgICAgICAgICAgICAgICJub25lL3psaWIvenN0ZCIsDQo+
ID4gPiArICAgICAgICAgICAgICAgICAgICJub25lL3psaWIvenN0ZCINCj4gPiA+ICsjaWZkZWYg
Q09ORklHX1FBVFpJUA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAiL3FhdHppcCINCj4gPiA+
ICsjZW5kaWYNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgLA0KPiA+ID4gICAgICAuZW51bV90
YWJsZSA9ICZNdWx0aUZEQ29tcHJlc3Npb25fbG9va3VwLA0KPiA+ID4gICAgICAuZ2V0ID0gcWRl
dl9wcm9waW5mb19nZXRfZW51bSwNCj4gPiA+ICAgICAgLnNldCA9IHFkZXZfcHJvcGluZm9fc2V0
X2VudW0sDQo+ID4gPiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL21lc29uLmJ1aWxkIGIvbWlncmF0
aW9uL21lc29uLmJ1aWxkIGluZGV4DQo+ID4gPiA5MmIxY2M0Mjk3Li5lMjBmMzE4Mzc5IDEwMDY0
NA0KPiA+ID4gLS0tIGEvbWlncmF0aW9uL21lc29uLmJ1aWxkDQo+ID4gPiArKysgYi9taWdyYXRp
b24vbWVzb24uYnVpbGQNCj4gPiA+IEBAIC00MCw2ICs0MCw3IEBAIGlmIGdldF9vcHRpb24oJ2xp
dmVfYmxvY2tfbWlncmF0aW9uJykuYWxsb3dlZCgpDQo+ID4gPiAgICBzeXN0ZW1fc3MuYWRkKGZp
bGVzKCdibG9jay5jJykpDQo+ID4gPiAgZW5kaWYNCj4gPiA+ICBzeXN0ZW1fc3MuYWRkKHdoZW46
IHpzdGQsIGlmX3RydWU6IGZpbGVzKCdtdWx0aWZkLXpzdGQuYycpKQ0KPiA+ID4gK3N5c3RlbV9z
cy5hZGQod2hlbjogcWF0emlwLCBpZl90cnVlOiBmaWxlcygnbXVsdGlmZC1xYXR6aXAuYycpKQ0K
PiA+ID4NCj4gPiA+ICBzcGVjaWZpY19zcy5hZGQod2hlbjogJ0NPTkZJR19TWVNURU1fT05MWScs
DQo+ID4gPiAgICAgICAgICAgICAgICAgIGlmX3RydWU6IGZpbGVzKCdyYW0uYycsIGRpZmYgLS1n
aXQNCj4gPiA+IGEvbWlncmF0aW9uL211bHRpZmQtcWF0emlwLmMgYi9taWdyYXRpb24vbXVsdGlm
ZC1xYXR6aXAuYyBuZXcgZmlsZQ0KPiA+ID4gbW9kZSAxMDA2NDQgaW5kZXggMDAwMDAwMDAwMC4u
MTczM2JiZGRiNw0KPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gKysrIGIvbWlncmF0aW9uL211
bHRpZmQtcWF0emlwLmMNCj4gPiA+IEBAIC0wLDAgKzEsODEgQEANCj4gPiA+ICsvKg0KPiA+ID4g
KyAqIE11bHRpZmQgUUFUemlwIGNvbXByZXNzaW9uIGltcGxlbWVudGF0aW9uDQo+ID4gPiArICoN
Cj4gPiA+ICsgKiBDb3B5cmlnaHQgKGMpIEJ5dGVkYW5jZQ0KPiA+ID4gKyAqDQo+ID4gPiArICog
QXV0aG9yczoNCj4gPiA+ICsgKiAgQnJ5YW4gWmhhbmcgPGJyeWFuLnpoYW5nQGJ5dGVkYW5jZS5j
b20+DQo+ID4gPiArICogIEhhbyBYaWFuZyAgIDxoYW8ueGlhbmdAYnl0ZWRhbmNlLmNvbT4NCj4g
PiA+ICsgKg0KPiA+ID4gKyAqIFRoaXMgd29yayBpcyBsaWNlbnNlZCB1bmRlciB0aGUgdGVybXMg
b2YgdGhlIEdOVSBHUEwsIHZlcnNpb24gMiBvcg0KPiBsYXRlci4NCj4gPiA+ICsgKiBTZWUgdGhl
IENPUFlJTkcgZmlsZSBpbiB0aGUgdG9wLWxldmVsIGRpcmVjdG9yeS4NCj4gPiA+ICsgKi8NCj4g
PiA+ICsNCj4gPiA+ICsjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPiA+ID4gKyNpbmNsdWRlICJl
eGVjL3JhbWJsb2NrLmgiDQo+ID4gPiArI2luY2x1ZGUgImV4ZWMvdGFyZ2V0X3BhZ2UuaCINCj4g
PiA+ICsjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPiA+ID4gKyNpbmNsdWRlICJtaWdyYXRpb24u
aCINCj4gPiA+ICsjaW5jbHVkZSAib3B0aW9ucy5oIg0KPiA+ID4gKyNpbmNsdWRlICJtdWx0aWZk
LmgiDQo+ID4gPiArDQo+ID4gPiArc3RhdGljIGludCBxYXR6aXBfc2VuZF9zZXR1cChNdWx0aUZE
U2VuZFBhcmFtcyAqcCwgRXJyb3IgKiplcnJwKSB7DQo+ID4gPiArICAgIHJldHVybiAwOw0KPiA+
ID4gK30NCj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgdm9pZCBxYXR6aXBfc2VuZF9jbGVhbnVwKE11
bHRpRkRTZW5kUGFyYW1zICpwLCBFcnJvciAqKmVycnApDQo+ID4gPiAre307DQo+ID4gPiArDQo+
ID4gPiArc3RhdGljIGludCBxYXR6aXBfc2VuZF9wcmVwYXJlKE11bHRpRkRTZW5kUGFyYW1zICpw
LCBFcnJvciAqKmVycnApDQo+ID4gPiArew0KPiA+ID4gKyAgICBNdWx0aUZEUGFnZXNfdCAqcGFn
ZXMgPSBwLT5wYWdlczsNCj4gPiA+ICsNCj4gPiA+ICsgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBw
LT5ub3JtYWxfbnVtOyBpKyspIHsNCj4gPiA+ICsgICAgICAgIHAtPmlvdltwLT5pb3ZzX251bV0u
aW92X2Jhc2UgPSBwYWdlcy0+YmxvY2stPmhvc3QgKyBwLQ0KPiA+bm9ybWFsW2ldOw0KPiA+ID4g
KyAgICAgICAgcC0+aW92W3AtPmlvdnNfbnVtXS5pb3ZfbGVuID0gcC0+cGFnZV9zaXplOw0KPiA+
ID4gKyAgICAgICAgcC0+aW92c19udW0rKzsNCj4gPiA+ICsgICAgfQ0KPiA+ID4gKw0KPiA+ID4g
KyAgICBwLT5uZXh0X3BhY2tldF9zaXplID0gcC0+bm9ybWFsX251bSAqIHAtPnBhZ2Vfc2l6ZTsN
Cj4gPiA+ICsgICAgcC0+ZmxhZ3MgfD0gTVVMVElGRF9GTEFHX05PQ09NUDsNCj4gPiA+ICsgICAg
cmV0dXJuIDA7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gK3N0YXRpYyBpbnQgcWF0emlwX3Jl
Y3Zfc2V0dXAoTXVsdGlGRFJlY3ZQYXJhbXMgKnAsIEVycm9yICoqZXJycCkgew0KPiA+ID4gKyAg
ICByZXR1cm4gMDsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIHZvaWQgcWF0emlw
X3JlY3ZfY2xlYW51cChNdWx0aUZEUmVjdlBhcmFtcyAqcCkge307DQo+ID4gPiArDQo+ID4gPiAr
c3RhdGljIGludCBxYXR6aXBfcmVjdl9wYWdlcyhNdWx0aUZEUmVjdlBhcmFtcyAqcCwgRXJyb3Ig
KiplcnJwKSB7DQo+ID4gPiArICAgIHVpbnQzMl90IGZsYWdzID0gcC0+ZmxhZ3MgJiBNVUxUSUZE
X0ZMQUdfQ09NUFJFU1NJT05fTUFTSzsNCj4gPiA+ICsNCj4gPiA+ICsgICAgaWYgKGZsYWdzICE9
IE1VTFRJRkRfRkxBR19OT0NPTVApIHsNCj4gPiA+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwg
Im11bHRpZmQgJXU6IGZsYWdzIHJlY2VpdmVkICV4IGZsYWdzDQo+IGV4cGVjdGVkICV4IiwNCj4g
PiA+ICsgICAgICAgICAgICAgICAgICAgcC0+aWQsIGZsYWdzLCBNVUxUSUZEX0ZMQUdfTk9DT01Q
KTsNCj4gPiA+ICsgICAgICAgIHJldHVybiAtMTsNCj4gPiA+ICsgICAgfQ0KPiA+ID4gKyAgICBm
b3IgKGludCBpID0gMDsgaSA8IHAtPm5vcm1hbF9udW07IGkrKykgew0KPiA+ID4gKyAgICAgICAg
cC0+aW92W2ldLmlvdl9iYXNlID0gcC0+aG9zdCArIHAtPm5vcm1hbFtpXTsNCj4gPiA+ICsgICAg
ICAgIHAtPmlvdltpXS5pb3ZfbGVuID0gcC0+cGFnZV9zaXplOw0KPiA+ID4gKyAgICB9DQo+ID4g
PiArICAgIHJldHVybiBxaW9fY2hhbm5lbF9yZWFkdl9hbGwocC0+YywgcC0+aW92LCBwLT5ub3Jt
YWxfbnVtLA0KPiA+ID4gK2VycnApOyB9DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIE11bHRpRkRN
ZXRob2RzIG11bHRpZmRfcWF0emlwX29wcyA9IHsNCj4gPiA+ICsgICAgLnNlbmRfc2V0dXAgPSBx
YXR6aXBfc2VuZF9zZXR1cCwNCj4gPiA+ICsgICAgLnNlbmRfY2xlYW51cCA9IHFhdHppcF9zZW5k
X2NsZWFudXAsDQo+ID4gPiArICAgIC5zZW5kX3ByZXBhcmUgPSBxYXR6aXBfc2VuZF9wcmVwYXJl
LA0KPiA+ID4gKyAgICAucmVjdl9zZXR1cCA9IHFhdHppcF9yZWN2X3NldHVwLA0KPiA+ID4gKyAg
ICAucmVjdl9jbGVhbnVwID0gcWF0emlwX3JlY3ZfY2xlYW51cCwNCj4gPiA+ICsgICAgLnJlY3Zf
cGFnZXMgPSBxYXR6aXBfcmVjdl9wYWdlcyB9Ow0KPiA+ID4gKw0KPiA+ID4gK3N0YXRpYyB2b2lk
IG11bHRpZmRfcWF0emlwX3JlZ2lzdGVyKHZvaWQpIHsNCj4gPiA+ICsgICAgbXVsdGlmZF9yZWdp
c3Rlcl9vcHMoTVVMVElGRF9DT01QUkVTU0lPTl9RQVRaSVAsDQo+ID4gPiArJm11bHRpZmRfcWF0
emlwX29wcyk7IH0NCj4gPiA+ICsNCj4gPiA+ICttaWdyYXRpb25faW5pdChtdWx0aWZkX3FhdHpp
cF9yZWdpc3Rlcik7DQo+ID4gPiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL211bHRpZmQuaCBiL21p
Z3JhdGlvbi9tdWx0aWZkLmggaW5kZXgNCj4gPiA+IGE4MzU2NDNiNDguLjU2MDBmN2ZjODIgMTAw
NjQ0DQo+ID4gPiAtLS0gYS9taWdyYXRpb24vbXVsdGlmZC5oDQo+ID4gPiArKysgYi9taWdyYXRp
b24vbXVsdGlmZC5oDQo+ID4gPiBAQCAtMzMsNiArMzMsNyBAQCBpbnQgbXVsdGlmZF9xdWV1ZV9w
YWdlKFFFTVVGaWxlICpmLCBSQU1CbG9jaw0KPiA+ID4gKmJsb2NrLCByYW1fYWRkcl90IG9mZnNl
dCk7ICAjZGVmaW5lIE1VTFRJRkRfRkxBR19OT0NPTVAgKDAgPDwgMSkNCj4gPiA+ICNkZWZpbmUg
TVVMVElGRF9GTEFHX1pMSUIgKDEgPDwgMSkgICNkZWZpbmUgTVVMVElGRF9GTEFHX1pTVEQgKDIg
PDwNCj4gPiA+IDEpDQo+ID4gPiArI2RlZmluZSBNVUxUSUZEX0ZMQUdfUUFUWklQICgzIDw8IDEp
DQo+ID4gPg0KPiA+ID4gIC8qIFRoaXMgdmFsdWUgbmVlZHMgdG8gYmUgYSBtdWx0aXBsZSBvZiBx
ZW11X3RhcmdldF9wYWdlX3NpemUoKSAqLw0KPiA+ID4gI2RlZmluZSBNVUxUSUZEX1BBQ0tFVF9T
SVpFICg1MTIgKiAxMDI0KSBkaWZmIC0tZ2l0DQo+ID4gPiBhL3FhcGkvbWlncmF0aW9uLmpzb24g
Yi9xYXBpL21pZ3JhdGlvbi5qc29uIGluZGV4DQo+ID4gPiA2ZDVhNGIwNDg5Li5lM2NjMTk1YWVk
IDEwMDY0NA0KPiA+ID4gLS0tIGEvcWFwaS9taWdyYXRpb24uanNvbg0KPiA+ID4gKysrIGIvcWFw
aS9taWdyYXRpb24uanNvbg0KPiA+ID4gQEAgLTYyNSwxMSArNjI1LDE0IEBADQo+ID4gPiAgIw0K
PiA+ID4gICMgQHpzdGQ6IHVzZSB6c3RkIGNvbXByZXNzaW9uIG1ldGhvZC4NCj4gPiA+ICAjDQo+
ID4gPiArIyBAcWF0emlwOiB1c2UgcWF0emlwIGNvbXByZXNzaW9uIG1ldGhvZC4NCj4gPiA+ICsj
DQo+ID4gPiAgIyBTaW5jZTogNS4wDQo+ID4gPiAgIyMNCj4gPiA+ICB7ICdlbnVtJzogJ011bHRp
RkRDb21wcmVzc2lvbicsDQo+ID4gPiAgICAnZGF0YSc6IFsgJ25vbmUnLCAnemxpYicsDQo+ID4g
PiAtICAgICAgICAgICAgeyAnbmFtZSc6ICd6c3RkJywgJ2lmJzogJ0NPTkZJR19aU1REJyB9IF0g
fQ0KPiA+ID4gKyAgICAgICAgICAgIHsgJ25hbWUnOiAnenN0ZCcsICdpZic6ICdDT05GSUdfWlNU
RCcgfSwNCj4gPiA+ICsgICAgICAgICAgICB7ICduYW1lJzogJ3FhdHppcCcsICdpZic6ICdDT05G
SUdfUUFUWklQJ30gXSB9DQo+ID4NCj4gPiBJbiBhbm90aGVyIHRocmVhZCBhZGRpbmcgc3VwcG9y
dCB0byBhbm90aGVyIEludGVsIGFjY2VsZXJhdG9yIChJQUEpIHdlDQo+ID4gZGVjaWRlZCB0aGF0
IGl0IHdhcyBiZXR0ZXIgdG8gc2VsZWN0IHRoZSBvZmZsb2FkaW5nIGFzIGFuIGFjY2VsZXJhdG9y
DQo+ID4gbWV0aG9kIHRvIG11bHRpZmQgemxpYiByYXRoZXIgdGhhbiBhcyBhbiBlbnRpcmVseSBu
ZXcgY29tcHJlc3Npb24NCj4gPiBmb3JtYXQuIFRha2UgYSBsb29rIGF0IHRoYXQgZGlzY3Vzc2lv
bjoNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yL1pURkNucWJicWxtc1VrUkNAcmVkaGF0
LmNvbQ0KPiANCj4gV2UgaGFkIHNvbWUgZWFybHkgZGlzY3Vzc2lvbiB3aXRoIEludGVsIGZvbGtz
IChwcm9iYWJseSBhIGRpZmZlcmVudCB0ZWFtDQo+IHRoYW4gdGhlIG9uZSB3aXRoIHRoZSBhYm92
ZSBwYXRjaHNldCkuIFRoZSB1bmRlcnN0YW5kaW5nIGF0IHRoZSB0aW1lIGlzDQo+IHRoYXQgUUFU
IGlzIGdvb2QgYXQgYm90aCBidWxrIGRhdGEgY29tcHJlc3Npb24gYW5kIGRlY29tcHJlc3Npb24u
IElBQSBpcw0KPiBnb29kIGF0IGRlY29tcHJlc3Npb24gd2l0aCBzbWFsbGVyIGRhdGEgc2l6ZSBi
dXQgY29tcHJlc3Npb24gcGVyZm9ybWFuY2UNCj4gaXMgbm90IHRoZSBiZXN0LiBJbiBtdWx0aWZk
LCB3ZSBhcmUgY29tcHJlc3NpbmcgdXAgdG8gMTI4IDRrIHBhZ2VzIGF0IGENCj4gdGltZSBhbmQg
cG90ZW50aWFsbHkgdGhpcyBjYW4gaW5jcmVhc2UgYnkgY29uZmlndXJpbmcgdGhlIHBhY2tldCBz
aXplLCBhdA0KPiB0aGUgdGltZSB3ZSB0aG91Z2h0IFFBVCBjb3VsZCBiZSBhIGJldHRlciBmaXQg
aW4gdGhlIG11bHRpZmQgbGl2ZQ0KPiBtaWdyYXRpb24gc2NlbmFyaW8uIFdlIHdvdWxkIGxpa2Ug
dG8gaGVhciBtb3JlIGZyb20gSW50ZWwuDQo+IA0KPiBGcm9tIG91ciBiZW5jaG1hcmsgdGVzdGlu
Zywgd2l0aCB0d28gUUFUIGRldmljZXMsIHdlIGNhbiBnZXQgZGVmbGF0ZQ0KPiBjb21wcmVzc2lv
biB0aHJvdWdob3V0IHRvIGFyb3VuZCA3R0IvcyB3aXRoIH4xNjAlIENQVS4gVGhhdCdzIGJlYXRp
bmcgdGhlDQo+IGN1cnJlbnQgc29mdHdhcmUgaW1wbGVtZW50YXRpb24gKHpsaWIgYW5kIHpzdGQp
IGJ5IGEgbG90LiBXZSBhcmUgc3RpbGwNCj4gdHVuaW5nIHRoZSBjb25maWd1cmF0aW9uIGluIFFF
TVUgbGl2ZSBtaWdyYXRpb24gbm93Lg0KPiANCj4gPg0KPiA+IEFzIEkgdW5kZXJzdGFuZCBpdCwg
UUFUICsgUUFUemlwIHdvdWxkIGJlIGNvbXBhdGlibGUgd2l0aCBib3RoIHpsaWINCj4gPiBhbmQg
SUFBICsgUVBMLCBzbyB3ZSdkIGFkZCBhbm90aGVyIGFjY2VsZXJhdG9yIG1ldGhvZCBsaWtlIHRo
aXM6DQo+ID4NCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQwMTAzMTEyODUxLjkw
ODA4Mi0zLXl1YW4xLmxpdUBpbnRlbC5jb20NCj4gPg0KPiANCj4gSSBxdWlja2x5IHJlYWQgb3Zl
ciB0aGUgSUFBIHBhdGNoc2V0IGFuZCBJIHNhdyB0aGlzOg0KPiANCj4gIkhvd2V2ZXIsIGR1ZSB0
byBzb21lIHJlYXNvbnMsIFFQTCBpcyBjdXJyZW50bHkgbm90IGNvbXBhdGlibGUgd2l0aCB0aGUN
Cj4gZXhpc3RpbmcgWmxpYiBtZXRob2QgdGhhdCBabGliIGNvbXByZXNzZWQgZGF0YSBjYW4gYmUg
ZGVjb21wcmVzc2VkIGJ5IFFQbA0KPiBhbmQgdmljZSB2ZXJzYS4iDQo+IA0KPiBUaGUgYWJvdmUg
cHJvYmFibHkgbWVhbnMgdGhlIGN1cnJlbnQgemxpYiBzb2Z0d2FyZSBpbXBsZW1lbnRhdGlvbiBh
bmQgSUFBDQo+IGFyZSBub3QgY29tcGF0aWJsZS4NCj4gDQo+IEZvciBRQVQsIGFsdGhvdWdoLCBi
b3RoIEludGVsJ3MgUUFUemlwIGFuZCB6bGliIGFyZSBpbnRlcm5hbGx5IHVzaW5nDQo+IGRlZmxh
dGUsIFFBVHppcCBvbmx5IHN1cHBvcnRzIGRlZmxhdGUgd2l0aCBhIDQgYnl0ZSBoZWFkZXIsIGRl
ZmxhdGUNCj4gd3JhcHBlZCBieSBHemlwIGhlYWRlciBhbmQgZm9vdGVyLCBvciBkZWZsYXRlIHdy
YXBwZWQgYnkgSW50ZWzCriBRQVQNCj4gR3ppcCogZXh0ZW5zaW9uIGhlYWRlciBhbmQgZm9vdGVy
LiBOb25lIG9mIHRoZSBoZWFkZXJzIGNhbiBiZSByZWNvZ25pemVkDQo+IGJ5IHpsaWIgc29mdHdh
cmUgaW1wbGVtZW50YXRpb24gaXMgbXkgdW5kZXJzdGFuZGluZy4gU28gaWYgd2Ugd2FudCB0byBt
YWtlDQo+IHRoZW0gY29tcGF0aWJsZSB3aXRoIHpsaWIsIHRoZSBRQVR6aXAgbGlicmFyeSBuZWVk
cyB0byBzdXBwb3J0IHRoYXQuDQoNClRoZSBRUEwgbGlicmFyeSBjdXJyZW50bHkgY2Fubm90IHN1
cHBvcnQgdGhlIFpfU1lOQ19GTFVMU0ggb3BlcmF0aW9uIG9mIHpsaWIgc3RlYW1pbmcuIA0KVGhp
cyBpcyB0aGUgcmVhc29uIHdoeSBpdCBpcyBub3QgY29tcGF0aWJsZSB3aXRoIHpsaWIuDQoNCj4g
PiBBbGwgdGhhdCwgb2YgY291cnNlLCBhc3N1bWluZyB3ZSBldmVuIHdhbnQgdG8gc3VwcG9ydCBi
b3RoDQo+ID4gYWNjZWxlcmF0b3JzLiBUaGV5J3JlIGFkZHJlc3NpbmcgdGhlIHNhbWUgcHJvYmxl
bSBhZnRlciBhbGwuIEkgd29uZGVyDQo+ID4gaG93IHdlJ2QgY2hvb3NlIGEgcHJlY2VkZW5jZSwg
c2luY2UgYm90aCBzZWVtIHRvIGJlIHByZXNlbnQgaW4gdGhlDQo+ID4gc2FtZSBwcm9jZXNzb3Ig
ZmFtaWx5Lg0KPiA+DQo+ID4NCj4gDQo+IFRoYXQncyBhbiBpbnRlcmVzdGluZyBxdWVzdGlvbiA6
LSkgSSB0aGluayBvdmVyYWxsIHBlcmZvcm1hbmNlICh0aHJvdWdocHV0DQo+IGFuZCBDUFUgb3Zl
cmhlYWQpIHNob3VsZCBib3RoIGJlIGNvbnNpZGVyZWQuIElBQSBhbmQgUUFUIGFjY2VsZXJhdG9y
cw0KPiBkb24ndCBwcmVzZW50IG9uIGFsbCBzeXN0ZW1zLiBXZSBCeXRlZGFuY2UgY2hvb3NlIHRv
IGhhdmUgYm90aCBvbiBvdXINCj4gcGxhdGZvcm0gd2hlbiBwdXJjaGFzaW5nIGZyb20gSW50ZWwu
DQo=

