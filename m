Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0CC711FC8
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 08:22:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2QqP-0004Sq-Ra; Fri, 26 May 2023 02:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q2QqM-0004OA-PL
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:22:30 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q2QqJ-0000JD-Uc
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685082147; x=1716618147;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zdIqnLaE/3wJaqPHv8O/R5aA3ep50aaBvjrkb8STDKs=;
 b=hTmaIaUwFBPgwbAVPzQlEiWEh3ZKqz16L3/sExdNoqMtQ9OeFSGcBuLz
 Qxxmr9VakCtYI8Otm21YLj/PQ+NxLcfnOP4l9XiP4B06i1lyR/pAcT8sv
 /aA+C88pAvitf2zK2h9YTsvv3KC3kTWSbaw0aSun3OohQrAMNNTqILs3k
 t+Aek2/ybGdag9StrV/MQB3PD8S2q4rLAF8IUovMGIP5VEzuq4/afbtpU
 l5U95OyLnEd1J1LEw8zvwqD19P+VaV67qo1F8VZQEi0ZRyDcefih/0bGD
 Sbls+cy4Nh/rOaoiRg2kpgKB9AIl/2hFl4jU5bmOQ/WVhem2g7wA46F8D Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="352971088"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; d="scan'208";a="352971088"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2023 23:22:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="682617204"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; d="scan'208";a="682617204"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga006.jf.intel.com with ESMTP; 25 May 2023 23:22:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 23:22:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 25 May 2023 23:22:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 25 May 2023 23:22:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDJ/0QGO5zxt+NfdPbEQTGQRSp/4qJbvztQygCePxCuoLdrMvcdcomcE6iwBtxRsw+jJYC+QA/KxjMCgSFGgWoD4vcE2JSpYryLA2fm/8SFYgoVyKGE0GIaTaUPo5UNiBlggZTbBr+oqlL3QpqZMdAhlD1l5Ay4LeR55OQiFIj2QICpJbzpQRuivzieMx700Up92NznjE7D4F2vxhW3t8SMDyGSYP+PP3Rc3miP6OCSsYGDS9w5fQf+teiKQ26ylBbCvHamgs0r+4hTw1yeDuDv1L5cBxy637EDZVd8ApoxQlEQ8+iQlfD1oylDSYtXLsSsctY1HVZ7rcKrLX3tflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdIqnLaE/3wJaqPHv8O/R5aA3ep50aaBvjrkb8STDKs=;
 b=EoX4iFk/8OANUajISugoyIwY2D7HYWBhGFKm6kC7YMJUidRGfdRe7FbAX38XsNRIYJ8DBhwlIOg4ZmqpDRlvvTfAVXdM4w9T3FMR0xVx0qZJ6aQRf1GKVZWb/ON+NgGS9xksZiIJMWE389Vv6BMXBnYjFWozQTFpqbs6gsGu/NLvFolHd6wCQrxBUvfCwffqPOo2wgtOSY1MW4KIW0He22l4kVPl06FfUc7dDd6/45dkOCcDDkHO0htQEV9wFu0gVYc/cNxSTmrEYMs85tp1XXQPUtxMTmOLAJcbW79x60PLB+/0H1NXF/V9Yds+yiCX0zygaroX3vsvN5A1zdXSJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH0PR11MB5377.namprd11.prod.outlook.com (2603:10b6:610:b8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 06:22:20 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%7]) with mapi id 15.20.6433.017; Fri, 26 May 2023
 06:22:20 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Neo Jia <cjia@nvidia.com>, "Alex
 Williamson" <alex.williamson@redhat.com>
Subject: RE: [PATCH] intel_iommu: Optimize out some unnecessary UNMAP calls
Thread-Topic: [PATCH] intel_iommu: Optimize out some unnecessary UNMAP calls
Thread-Index: AQHZjU9UUNDgMVPBGUm9r6viRHCOR69pp1qAgAERSyCAAE1qgIABDM/Q
Date: Fri, 26 May 2023 06:22:19 +0000
Message-ID: <SJ0PR11MB67449B49619CCF94ECA7447392479@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230523080702.179363-1-zhenzhong.duan@intel.com>
 <ZG5CPws85lIvpT07@x1n>
 <SJ0PR11MB67447A3D47F6226F58DB813492469@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ZG9ocSY+vJAd1Hjs@x1n>
In-Reply-To: <ZG9ocSY+vJAd1Hjs@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH0PR11MB5377:EE_
x-ms-office365-filtering-correlation-id: 856bc6b9-9085-4f40-5d44-08db5db18f74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z0v5nMWyCY+l3aq69b0xvvzh953EYOCYlihG7Fbmdgv0FVE7lFz81iUNcMkOYynR8Hyo5FfzleIzNwWDt3gj8yqfgX4vL1wYVIYEqcwvj6PFObdd4x3WJBf3vLpSSXbUrGqdPFMpl2cux/sKOn/+hUWv57tnnpOTMhcPL4U/H97jCyEeOpNg31QdGmK3dHgxQExJZFcZpaDcwSAnvufttZCpW34PuomM8CUiKFN3hvJiBiBqARDedtMsmbEnTp3bTCSRVDtclWscHK6xGco85e1gx6geG2I7RnHOG/uVfcb+k1wTaEbWNIOGOWgsmp1XOzfr8g8gwocbeVn0ytJRRo1vTMlT87SIhoVTEgMXD4YFXVvtNTQ2SvAU7TNMbgIPm66YVLRXLzOSI+crftFU49aHwySHQ8AnFU8VW8vKtObqnro/uiu1ge3zOXBqFAFNUqwmTOtpCD/83WTuEw+deqSmLRKkr01amrqQK30iX3BIBcrlM7LMORW2AF0y2hqe8eLoLVD+yzSA6QDEWwhU7YY+YpHpesjWY1nIr8oKM+L9S/0JdQxjAG5u/Y8/MG9kksFoDJ6Ifv631Lx1RAXsL9vqZMcqKfJd4p6rh3kZ7hgbOMgkL+cRbJcyhGkgVFSlqPmVZ/MJKyRr2eBpaZC1Fw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199021)(52536014)(316002)(122000001)(71200400001)(26005)(6506007)(82960400001)(7416002)(9686003)(4326008)(6916009)(66946007)(76116006)(66556008)(64756008)(66476007)(66446008)(38100700002)(55016003)(5660300002)(33656002)(41300700001)(8676002)(8936002)(7696005)(83380400001)(86362001)(478600001)(54906003)(186003)(2906002)(38070700005)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXpRSjgxd1FGc3pzOHV6dDhqS2JzcFBybTQ5bGs4T0I4M05YSkZVbTdMa2hj?=
 =?utf-8?B?V2l3SnBrTk9hK3h6OG1GbUx3c3V1dlJMbVlMeENFYnlmSkpGTzR3WGtRNXJ0?=
 =?utf-8?B?dFdQamZ4dytaWXl1R0c3R29ORVpHQzFqOGd4RzVEUEhZc3BPeFBscG5PU2xi?=
 =?utf-8?B?dFI3a2FTTEY4Z1ZXMkh0bVJPMFBCbU16YkpEdE5kUno0bmlCZUJxNm1meHJW?=
 =?utf-8?B?cUtRUFlRMzJtcEx3ZlJpQytCL1k0K3JzckVCb0ZLSU9PN2V0ZDhTeFppK3N4?=
 =?utf-8?B?T2loVzF1cWZzRThXb2pGY1pFdVA5RnlVS1F4a2UxN0IvRUQ4MXZwYko1U1Nr?=
 =?utf-8?B?bnJkMWdUUUhYa2FQK1c1Uk9hVjFraDBzWnZ5bkZVem9iM1RkcFRvbXFkRERz?=
 =?utf-8?B?c2Q5STR0VEQzcU9LL1p0WDVOWkdsc2s0M1Y1U0xyRHJKNzZ0ZHVCMVczQ0lZ?=
 =?utf-8?B?bkkvd0RqTmRkVStJd3dDREdSaE1PZVgreTRFR3ZjQTJZYzRDQUVZSHBzbndi?=
 =?utf-8?B?bjVEemRkVmY2ME9KdDhJNDc2SWpiZkl2cWRFUitJaGRzWVVUM0F1RmMwbEFE?=
 =?utf-8?B?ZFk0K0k4bHEraWxKb2ZKVllnR25SVExxdXZpMlEvVndJazJ3bzE5cEJ0czVm?=
 =?utf-8?B?MkJWRHVGWS9WVUMzdG54T2NNS2VtQTdDQ2RnMDEwU2Fic3hvbUhOeU1HVmtR?=
 =?utf-8?B?ZGo2WCtvWnFCUkJjczhOalNhRGtDenZnMVZUeDRZZXVRdm1WUXprRHMyZU1p?=
 =?utf-8?B?d2JXN1AxektGRGQycTRvTitxdzk1a1BJRHowcVBYV1A5KzJXY1cxQ0xUVG9y?=
 =?utf-8?B?ajlkTjlScmxpQ0lEdFY4RjVLUGdSejZ4OXd3SWNXNGw3a1VrRjJPTUU3R21T?=
 =?utf-8?B?aEtYZDlza0FNVlNnelV2cTgvRlhibG43Tklxc09JdVk2NjhiQTJZUGJVamVH?=
 =?utf-8?B?WkpTYm1xUUppZ2Rjd1dpRFVDR0JmbmxYMTgyRmQwbWMrU1B1R2NJOFBxOEl2?=
 =?utf-8?B?cmdMYzhnUkJUTHdXN2tWWkxQTmc4ajBtV2hKNjA1Sjl2Z0p6VXc5OVNPY09j?=
 =?utf-8?B?NTI2VGpPTkpJNllrbjE1V0tXSkFERENoVU5OZG5uRGVyaWFONDZSYWZoV3NF?=
 =?utf-8?B?UFdPY3NyM3VSeGRoa0IyNnBobTNhaWV6aDhxaG1kaXVZWmQ2U2R0alNDYmNO?=
 =?utf-8?B?TSt4NngrdnFET0xoVE9BYi9HaXpQcW9sTnJtaFNYTDlVZSsxSFlQZnpHRzcw?=
 =?utf-8?B?ZUZGd05EbmxtSUNsTXFtYlpyTUxjWncrdmNFZ2d4cnZCcDRRZm1TZzFia3k4?=
 =?utf-8?B?UDFtSTlVY1VPdG1nUnlNMzdYeG50ck5wN2REQWpiU3NKL2xzcDd6ZzM2SHBn?=
 =?utf-8?B?alV0NDlEalltMUc2bGh3azVnY2tFTUtnV0l5L1B0SWFzaVRuaHlySEw0Rm56?=
 =?utf-8?B?VFp2ckp1YVFuc1R5azBBUTdLRURYNVUxTGxoSzFVa05rSHhrc3dQbmQxRVU5?=
 =?utf-8?B?c21rbjhidnBBc2U5UVVUNk1obHZ6NE04RjU3TTY4Z2NqYWJvSHdta2JEUk5v?=
 =?utf-8?B?dzQ5ek1RTkUyeDlCL1pHb3NoeUQ2QjM0eDhCbUpzbDcrekVaaEpadFV6d1B0?=
 =?utf-8?B?RFJyRUNOdjFRWkJTTUI2R3lxN01NUWNWd2dyN3NCWnRQRzhUc1pFaFpZWURH?=
 =?utf-8?B?b3ZTSTBDcUhWdFY4K3pxakcrY0FHbDlKZC9uYVpVMngvRVoxdkZIRStsSEVP?=
 =?utf-8?B?KytmZjE2d0VQMThCb1FBZi9uWkhuQTd4UTNVRlFqNXJmdlc1RXAzNnhwNGo1?=
 =?utf-8?B?NGVNYXpFaFFadmg4WUlOdjhBM2t0UnV6QVBMUCtSODhiM0hQelNWeGJJR0I4?=
 =?utf-8?B?cTlKZk9QOVBtRUhYYVJ3cmp0a29LMk82SWxiMWlkTFF6azUzYzR3MWFUbWlQ?=
 =?utf-8?B?YkJkN0JVQnJrYjcrYVlRaHpUcHNKMDlVV3VLK2NjM3N0Z2kzQURZU2xyVERC?=
 =?utf-8?B?V2tuMVFRRkxROHRjdHpQUjdRaU5mSm9oUi8xemVPRUhrUW5UMlJNSFBsM00y?=
 =?utf-8?B?Sk04Mjl2NTl4TUI0ZEM1RXNXaWZCcExrU1UralFDWUNpcUdWUklyMktVclIy?=
 =?utf-8?Q?vI99Qo5GYU6vAHPEdPWYoMKme?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856bc6b9-9085-4f40-5d44-08db5db18f74
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 06:22:19.9931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /PHgQJG5zuKZcdzh5/ZquZDWq0FqGuj+q9wSawdd2fuXiKmfCy/slG/oHGLHu1q8cdT1LH4OygQxiumaX8TDLNLKjB1yPdp30hQR6oKbNbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5377
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mga04.intel.com
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

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJl
ZGhhdC5jb20+DQo+U2VudDogVGh1cnNkYXksIE1heSAyNSwgMjAyMyA5OjU0IFBNDQo+U3ViamVj
dDogUmU6IFtQQVRDSF0gaW50ZWxfaW9tbXU6IE9wdGltaXplIG91dCBzb21lIHVubmVjZXNzYXJ5
IFVOTUFQDQo+Y2FsbHMNCj4NCj5PbiBUaHUsIE1heSAyNSwgMjAyMyBhdCAxMToyOTozNEFNICsw
MDAwLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+PiBIaSBQZXRlciwNCj4+DQo+PiBTZWUgaW5s
aW5lLg0KPj4gPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiA+RnJvbTogUGV0ZXIgWHUg
PHBldGVyeEByZWRoYXQuY29tPg0KPj4gPlNlbnQ6IFRodXJzZGF5LCBNYXkgMjUsIDIwMjMgMTI6
NTkgQU0NCj4+ID5TdWJqZWN0OiBSZTogW1BBVENIXSBpbnRlbF9pb21tdTogT3B0aW1pemUgb3V0
IHNvbWUgdW5uZWNlc3NhcnkgVU5NQVANCj4+ID5jYWxscw0KPj4gPg0KPj4gPkhpLCBaaGVuemhv
bmcsDQo+PiA+DQo+PiA+T24gVHVlLCBNYXkgMjMsIDIwMjMgYXQgMDQ6MDc6MDJQTSArMDgwMCwg
Wmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiA+PiBDb21taXQgNjNiODg5NjhmMSAoImludGVsLWlv
bW11OiByZXdvcmsgdGhlIHBhZ2Ugd2FsayBsb2dpYyIpIGFkZHMNCj4+ID4+IGxvZ2ljIHRvIHJl
Y29yZCBtYXBwZWQgSU9WQSByYW5nZXMgc28gd2Ugb25seSBuZWVkIHRvIHNlbmQgTUFQIG9yDQo+
PiA+PiBVTk1BUCB3aGVuIG5lY2Vzc2FyeS4gQnV0IHRoZXJlIGFyZSBzdGlsbCBhIGZldyBjb3Ju
ZXIgY2FzZXMgb2YNCj4+ID51bm5lY2Vzc2FyeSBVTk1BUC4NCj4+ID4+DQo+PiA+PiBPbmUgaXMg
YWRkcmVzcyBzcGFjZSBzd2l0Y2guIER1cmluZyBzd2l0Y2hpbmcgdG8gaW9tbXUgYWRkcmVzcw0K
Pj4gPj4gc3BhY2UsIGFsbCB0aGUgb3JpZ2luYWwgbWFwcGluZ3MgaGF2ZSBiZWVuIGRyb3BwZWQg
YnkgVkZJTyBtZW1vcnkNCj4+ID4+IGxpc3RlbmVyLCB3ZSBkb24ndCBuZWVkIHRvIHVubWFwIGFn
YWluIGluIHJlcGxheS4gVGhlIG90aGVyIGlzDQo+PiA+PiBpbnZhbGlkYXRpb24sIHdlIG9ubHkg
bmVlZCB0byB1bm1hcCB3aGVuIHRoZXJlIGFyZSByZWNvcmRlZCBtYXBwZWQNCj4+ID4+IElPVkEg
cmFuZ2VzLCBwcmVzdW1pbmcgbW9zdCBvZiBPU2VzIGFsbG9jYXRpbmcgSU9WQSByYW5nZQ0KPj4g
Pj4gY29udGludW91c2x5LCBleC4gb24geDg2LCBsaW51eCBzZXRzIHVwIG1hcHBpbmcgZnJvbSAw
eGZmZmZmZmZmDQo+ZG93bndhcmRzLg0KPj4gPj4NCj4+ID4+IFNpZ25lZC1vZmYtYnk6IFpoZW56
aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiA+PiAtLS0NCj4+ID4+IFRl
c3RlZCBvbiB4ODYgd2l0aCBhIG5ldCBjYXJkIHBhc3NlZCBvciBob3RwbHVnZWQgdG8ga3ZtIGd1
ZXN0LA0KPj4gPj4gcGluZy9zc2ggcGFzcy4NCj4+ID4NCj4+ID5TaW5jZSB0aGlzIGlzIGEgcGVy
Zm9ybWFuY2UgcmVsYXRlZCBwYXRjaCwgZG8geW91IGhhdmUgYW55IG51bWJlciB0bw0KPj4gPnNo
b3cgdGhlIGVmZmVjdD8NCj4+DQo+PiBJIHN0cmFjZWQgdGhlIHRpbWUgb2YgVU5NQVAgaW9jdGws
IGl0cyB0aW1lIGlzIDAuMDAwMDE0dXMgYW5kIHdlIGhhdmUNCj4+IDI4IGlvY3RsKCkgZHVlIHRv
IHRoZSB0d28gbm90aWZpZXJzIGluIHg4NiBhcmUgc3BsaXQgaW50byBwb3dlciBvZiAyIHBpZWNl
cy4NCj4+DQo+PiBpb2N0bCg0OCwgVkZJT19ERVZJQ0VfUVVFUllfR0ZYX1BMQU5FIG9yIFZGSU9f
SU9NTVVfVU5NQVBfRE1BLA0KPj4gMHg3ZmZmZmQ1YzQyZjApID0gMCA8MC4wMDAwMTQ+DQo+DQo+
Q291bGQgeW91IGFkZCBzb21lIGluZm9ybWF0aW9uIGxpa2UgdGhpcyBpbnRvIHRoZSBjb21taXQg
bWVzc2FnZSB3aGVuDQo+cmVwb3N0PyAgRS5nLiBVTk1BUCB3YXMgeHh4IHNlYyBiZWZvcmUsIGFu
ZCB0aGlzIHBhdGNoIHJlZHVjZXMgaXQgdG8geXl5Lg0KU3VyZSwgd2lsbCBkby4NCg0KPg0KPj4N
Cj4+ID4NCj4+ID4+DQo+PiA+PiAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgMzEgKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tLS0tLQ0KPj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRp
b25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4+ID4+DQo+PiA+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGluZGV4DQo+PiA+PiA5NGQ1
MmY0MjA1ZDIuLjZhZmQ2NDI4YWFhYSAxMDA2NDQNCj4+ID4+IC0tLSBhL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KPj4gPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiA+PiBAQCAtMzc0
Myw2ICszNzQzLDcgQEAgc3RhdGljIHZvaWQNCj4+ID52dGRfYWRkcmVzc19zcGFjZV91bm1hcChW
VERBZGRyZXNzU3BhY2UgKmFzLCBJT01NVU5vdGlmaWVyICpuKQ0KPj4gPj4gICAgICBod2FkZHIg
c3RhcnQgPSBuLT5zdGFydDsNCj4+ID4+ICAgICAgaHdhZGRyIGVuZCA9IG4tPmVuZDsNCj4+ID4+
ICAgICAgSW50ZWxJT01NVVN0YXRlICpzID0gYXMtPmlvbW11X3N0YXRlOw0KPj4gPj4gKyAgICBJ
T01NVVRMQkV2ZW50IGV2ZW50Ow0KPj4gPj4gICAgICBETUFNYXAgbWFwOw0KPj4gPj4NCj4+ID4+
ICAgICAgLyoNCj4+ID4+IEBAIC0zNzYyLDIyICszNzYzLDI1IEBAIHN0YXRpYyB2b2lkDQo+PiA+
dnRkX2FkZHJlc3Nfc3BhY2VfdW5tYXAoVlREQWRkcmVzc1NwYWNlICphcywgSU9NTVVOb3RpZmll
ciAqbikNCj4+ID4+ICAgICAgYXNzZXJ0KHN0YXJ0IDw9IGVuZCk7DQo+PiA+PiAgICAgIHNpemUg
PSByZW1haW4gPSBlbmQgLSBzdGFydCArIDE7DQo+PiA+Pg0KPj4gPj4gKyAgICBldmVudC50eXBl
ID0gSU9NTVVfTk9USUZJRVJfVU5NQVA7DQo+PiA+PiArICAgIGV2ZW50LmVudHJ5LnRhcmdldF9h
cyA9ICZhZGRyZXNzX3NwYWNlX21lbW9yeTsNCj4+ID4+ICsgICAgZXZlbnQuZW50cnkucGVybSA9
IElPTU1VX05PTkU7DQo+PiA+PiArICAgIC8qIFRoaXMgZmllbGQgaXMgbWVhbmluZ2xlc3MgZm9y
IHVubWFwICovDQo+PiA+PiArICAgIGV2ZW50LmVudHJ5LnRyYW5zbGF0ZWRfYWRkciA9IDA7DQo+
PiA+PiArDQo+PiA+PiAgICAgIHdoaWxlIChyZW1haW4gPj0gVlREX1BBR0VfU0laRSkgew0KPj4g
Pj4gLSAgICAgICAgSU9NTVVUTEJFdmVudCBldmVudDsNCj4+ID4+ICAgICAgICAgIHVpbnQ2NF90
IG1hc2sgPSBkbWFfYWxpZ25lZF9wb3cyX21hc2soc3RhcnQsIGVuZCwgcy0+YXdfYml0cyk7DQo+
PiA+PiAgICAgICAgICB1aW50NjRfdCBzaXplID0gbWFzayArIDE7DQo+PiA+Pg0KPj4gPj4gICAg
ICAgICAgYXNzZXJ0KHNpemUpOw0KPj4gPj4NCj4+ID4+IC0gICAgICAgIGV2ZW50LnR5cGUgPSBJ
T01NVV9OT1RJRklFUl9VTk1BUDsNCj4+ID4+IC0gICAgICAgIGV2ZW50LmVudHJ5LmlvdmEgPSBz
dGFydDsNCj4+ID4+IC0gICAgICAgIGV2ZW50LmVudHJ5LmFkZHJfbWFzayA9IG1hc2s7DQo+PiA+
PiAtICAgICAgICBldmVudC5lbnRyeS50YXJnZXRfYXMgPSAmYWRkcmVzc19zcGFjZV9tZW1vcnk7
DQo+PiA+PiAtICAgICAgICBldmVudC5lbnRyeS5wZXJtID0gSU9NTVVfTk9ORTsNCj4+ID4+IC0g
ICAgICAgIC8qIFRoaXMgZmllbGQgaXMgbWVhbmluZ2xlc3MgZm9yIHVubWFwICovDQo+PiA+PiAt
ICAgICAgICBldmVudC5lbnRyeS50cmFuc2xhdGVkX2FkZHIgPSAwOw0KPj4gPj4gLQ0KPj4gPj4g
LSAgICAgICAgbWVtb3J5X3JlZ2lvbl9ub3RpZnlfaW9tbXVfb25lKG4sICZldmVudCk7DQo+PiA+
PiArICAgICAgICBtYXAuaW92YSA9IHN0YXJ0Ow0KPj4gPj4gKyAgICAgICAgbWFwLnNpemUgPSBz
aXplOw0KPj4gPj4gKyAgICAgICAgaWYgKGlvdmFfdHJlZV9maW5kKGFzLT5pb3ZhX3RyZWUsICZt
YXApKSB7DQo+PiA+PiArICAgICAgICAgICAgZXZlbnQuZW50cnkuaW92YSA9IHN0YXJ0Ow0KPj4g
Pj4gKyAgICAgICAgICAgIGV2ZW50LmVudHJ5LmFkZHJfbWFzayA9IG1hc2s7DQo+PiA+PiArICAg
ICAgICAgICAgbWVtb3J5X3JlZ2lvbl9ub3RpZnlfaW9tbXVfb25lKG4sICZldmVudCk7DQo+PiA+
PiArICAgICAgICB9DQo+PiA+DQo+PiA+VGhpcyBvbmUgbG9va3MgZmluZSB0byBtZSwgYnV0IEkn
bSBub3Qgc3VyZSBob3cgbXVjaCBiZW5lZml0IHdlJ2xsDQo+PiA+Z2V0IGhlcmUgZWl0aGVyIGFz
IHRoaXMgcGF0aCBzaG91bGQgYmUgcmFyZSBhZmFpdS4NCj4+DQo+PiBZZXMsIEkgb25seSBzZWUg
c3VjaCBVTk1BUCBjYWxsIGF0IGNvbGQgYm9vdHVwL3NodXRkb3duLCBob3QgcGx1ZyBhbmQNCj51
bnBsdWcuDQo+Pg0KPj4gSW4gZmFjdCwgdGhlIG90aGVyIHB1cnBvc2Ugb2YgdGhpcyBwYXRjaCBp
cyB0byBlbGltaW5hdGUgbm9pc3kgZXJyb3INCj4+IGxvZyB3aGVuIHdlIHdvcmsgd2l0aCBJT01N
VUZELiBJdCBsb29rcyB0aGUgZHVwbGljYXRlIFVOTUFQIGNhbGwgd2lsbA0KPj4gZmFpbCB3aXRo
IElPTU1VRkQgd2hpbGUgYWx3YXlzIHN1Y2NlZWQgd2l0aCBsZWdhY3kgY29udGFpbmVyLiBUaGlz
DQo+PiBiZWhhdmlvciBkaWZmZXJlbmNlIGxlYWQgdG8gYmVsb3cgZXJyb3IgbG9nIGZvciBJT01N
VUZEOg0KPj4NCj4+IElPTU1VX0lPQVNfVU5NQVAgZmFpbGVkOiBObyBzdWNoIGZpbGUgb3IgZGly
ZWN0b3J5DQo+PiB2ZmlvX2NvbnRhaW5lcl9kbWFfdW5tYXAoMHg1NjIwMTJkNmI2ZDAsIDB4MCwg
MHg4MDAwMDAwMCkgPSAtMiAoTm8NCj4+IHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpIElPTU1VX0lP
QVNfVU5NQVAgZmFpbGVkOiBObyBzdWNoIGZpbGUgb3INCj4+IGRpcmVjdG9yeSB2ZmlvX2NvbnRh
aW5lcl9kbWFfdW5tYXAoMHg1NjIwMTJkNmI2ZDAsIDB4ODAwMDAwMDAsDQo+PiAweDQwMDAwMDAw
KSA9IC0yIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQ0KPg0KPkkgc2VlLiAgUGxlYXNlIGFs
c28gbWVudGlvbiB0aGlzIGluIHRoZSBjb21taXQgbG9nLCB0aGF0J2xsIGhlbHAgcmV2aWV3ZXJz
DQo+dW5kZXJzdGFuZCB0aGUgZ29hbCBvZiB0aGUgcGF0Y2gsIHRoYW5rcyENCldpbGwgZG8uDQoN
Cj4NCj4+DQo+PiA+DQo+PiA+Pg0KPj4gPj4gICAgICAgICAgc3RhcnQgKz0gc2l6ZTsNCj4+ID4+
ICAgICAgICAgIHJlbWFpbiAtPSBzaXplOw0KPj4gPj4gQEAgLTM4MjYsMTMgKzM4MzAsNiBAQCBz
dGF0aWMgdm9pZA0KPj4gPnZ0ZF9pb21tdV9yZXBsYXkoSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11
X21yLCBJT01NVU5vdGlmaWVyDQo+Km4pDQo+PiA+PiAgICAgIHVpbnQ4X3QgYnVzX24gPSBwY2lf
YnVzX251bSh2dGRfYXMtPmJ1cyk7DQo+PiA+PiAgICAgIFZURENvbnRleHRFbnRyeSBjZTsNCj4+
ID4+DQo+PiA+PiAtICAgIC8qDQo+PiA+PiAtICAgICAqIFRoZSByZXBsYXkgY2FuIGJlIHRyaWdn
ZXJlZCBieSBlaXRoZXIgYSBpbnZhbGlkYXRpb24gb3IgYSBuZXdseQ0KPj4gPj4gLSAgICAgKiBj
cmVhdGVkIGVudHJ5LiBObyBtYXR0ZXIgd2hhdCwgd2UgcmVsZWFzZSBleGlzdGluZyBtYXBwaW5n
cw0KPj4gPj4gLSAgICAgKiAoaXQgbWVhbnMgZmx1c2hpbmcgY2FjaGVzIGZvciBVTk1BUC1vbmx5
IHJlZ2lzdGVycykuDQo+PiA+PiAtICAgICAqLw0KPj4gPj4gLSAgICB2dGRfYWRkcmVzc19zcGFj
ZV91bm1hcCh2dGRfYXMsIG4pOw0KPj4gPg0KPj4gPklJVUMgdGhpcyBpcyBuZWVkZWQgdG8gc2F0
aXNmeSBjdXJyZW50IHJlcGxheSgpIHNlbWFudGljczoNCj4+ID4NCj4+ID4gICAgLyoqDQo+PiA+
ICAgICAqIEByZXBsYXk6DQo+PiA+ICAgICAqDQo+PiA+ICAgICAqIENhbGxlZCB0byBoYW5kbGUg
bWVtb3J5X3JlZ2lvbl9pb21tdV9yZXBsYXkoKS4NCj4+ID4gICAgICoNCj4+ID4gICAgICogVGhl
IGRlZmF1bHQgaW1wbGVtZW50YXRpb24gb2YgbWVtb3J5X3JlZ2lvbl9pb21tdV9yZXBsYXkoKSBp
cyB0bw0KPj4gPiAgICAgKiBjYWxsIHRoZSBJT01NVSB0cmFuc2xhdGUgbWV0aG9kIGZvciBldmVy
eSBwYWdlIGluIHRoZSBhZGRyZXNzIHNwYWNlDQo+PiA+ICAgICAqIHdpdGggZmxhZyA9PSBJT01N
VV9OT05FIGFuZCB0aGVuIGNhbGwgdGhlIG5vdGlmaWVyIGlmIHRyYW5zbGF0ZQ0KPj4gPiAgICAg
KiByZXR1cm5zIGEgdmFsaWQgbWFwcGluZy4gSWYgdGhpcyBtZXRob2QgaXMgaW1wbGVtZW50ZWQg
dGhlbiBpdA0KPj4gPiAgICAgKiBvdmVycmlkZXMgdGhlIGRlZmF1bHQgYmVoYXZpb3VyLCBhbmQg
bXVzdCBwcm92aWRlIHRoZSBmdWxsIHNlbWFudGljcw0KPj4gPiAgICAgKiBvZiBtZW1vcnlfcmVn
aW9uX2lvbW11X3JlcGxheSgpLCBieSBjYWxsaW5nIEBub3RpZmllciBmb3IgZXZlcnkNCj4+ID4g
ICAgICogdHJhbnNsYXRpb24gcHJlc2VudCBpbiB0aGUgSU9NTVUuDQo+PiBBYm92ZSBzZW1hbnRp
Y3MgY2xhaW1zIGNhbGxpbmcgQG5vdGlmaWVyIGZvciBldmVyeSB0cmFuc2xhdGlvbiBwcmVzZW50
DQo+PiBpbiB0aGUgSU9NTVUgQnV0IGl0IGRvZXNuJ3QgY2xhaW0gaWYgY2FsbGluZyBAbm90aWZp
ZXIgZm9yIG5vbi1wcmVzZW50DQo+dHJhbnNsYXRpb24uDQo+PiBJIGNoZWNrZWQgb3RoZXIgY3Vz
dG9tIHJlcGxheSgpIGNhbGxiYWNrLCBleC4gdmlydGlvX2lvbW11X3JlcGxheSgpLA0KPj4gc3Bh
cHJfdGNlX3JlcGxheSgpIGl0IGxvb2tzIG9ubHkgaW50ZWxfaW9tbXUgaXMgc3BlY2lhbCBieSBj
YWxsaW5nIHVubWFwX2FsbCgpDQo+YmVmb3JlIHJlYnVpbGQgbWFwcGluZy4NCj4NCj5ZZXMsIGFu
ZCBJJ2xsIHJlcGx5IGJlbG93IGZvciB0aGlzLi4NCj4NCj4+DQo+PiA+DQo+PiA+VGhlIHByb2Js
ZW0gaXMgdnRkX3BhZ2Vfd2FsaygpIGN1cnJlbnRseSBieSBkZWZhdWx0IG9ubHkgbm90aWZpZXMg
b24NCj4+ID5wYWdlIGNoYW5nZXMsIHNvIHdlJ2xsIG5vdGlmeSBhbGwgTUFQIG9ubHkgaWYgd2Ug
dW5tYXAgYWxsIG9mIHRoZW0gZmlyc3QuDQo+PiBIbW0sIEkgZGlkbid0IGdldCB0aGlzIHBvaW50
LiBDaGVja2VkIHZ0ZF9wYWdlX3dhbGtfb25lKCksIGl0IHdpbGwNCj4+IHJlYnVpbGQgdGhlIG1h
cHBpbmcgZXhjZXB0IHRoZSBETUFNYXAgaXMgZXhhY3RseSBzYW1lIHdoaWNoIGl0IHdpbGwgc2tp
cC4NCj5TZWUgYmVsb3c6DQo+Pg0KPj4gICAgIC8qIFVwZGF0ZSBsb2NhbCBJT1ZBIG1hcHBlZCBy
YW5nZXMgKi8NCj4+ICAgICBpZiAoZXZlbnQtPnR5cGUgPT0gSU9NTVVfTk9USUZJRVJfTUFQKSB7
DQo+PiAgICAgICAgIGlmIChtYXBwZWQpIHsNCj4+ICAgICAgICAgICAgIC8qIElmIGl0J3MgZXhh
Y3RseSB0aGUgc2FtZSB0cmFuc2xhdGlvbiwgc2tpcCAqLw0KPj4gICAgICAgICAgICAgaWYgKCFt
ZW1jbXAobWFwcGVkLCAmdGFyZ2V0LCBzaXplb2YodGFyZ2V0KSkpIHsNCj4+ICAgICAgICAgICAg
ICAgICB0cmFjZV92dGRfcGFnZV93YWxrX29uZV9za2lwX21hcChlbnRyeS0+aW92YSwgZW50cnkt
DQo+PmFkZHJfbWFzaywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBlbnRyeS0+dHJhbnNsYXRlZF9hZGRyKTsNCj4+ICAgICAgICAgICAgICAgICBy
ZXR1cm4gMDsNCj4+ICAgICAgICAgICAgIH0gZWxzZSB7DQo+PiAgICAgICAgICAgICAgICAgLyoN
Cj4+ICAgICAgICAgICAgICAgICAgKiBUcmFuc2xhdGlvbiBjaGFuZ2VkLiAgTm9ybWFsbHkgdGhp
cyBzaG91bGQgbm90DQo+PiAgICAgICAgICAgICAgICAgICogaGFwcGVuLCBidXQgaXQgY2FuIGhh
cHBlbiB3aGVuIHdpdGggYnVnZ3kgZ3Vlc3QNCj4NCj5TbyBJIGhhdmVuJ3QgdG91Y2hlZCB0aGUg
dklPTU1VIGNvZGUgZm9yIGEgZmV3IHllYXJzLCBidXQgSUlSQyBpZiB3ZQ0KPnJlcGxheSgpIG9u
IGFuIGFkZHJlc3Mgc3BhY2UgdGhhdCBoYXMgbWFwcGluZyBhbHJlYWR5LCB0aGVuIGlmIHdpdGhv
dXQgdGhlDQo+dW5tYXBfYWxsKCkgYXQgdGhlIHN0YXJ0IHdlJ2xsIGp1c3Qgbm90aWZ5IG5vdGhp
bmcsIGJlY2F1c2UgIm1hcHBlZCIgd2lsbCBiZQ0KPnRydWUgZm9yIGFsbCB0aGUgZXhpc3Rpbmcg
bWFwcGluZ3MsIGFuZCBtZW1jbXAoKSBzaG91bGQgcmV0dXJuIDAgdG9vIGlmDQo+bm90aGluZyBj
aGFuZ2VkPw0KVW5kZXJzdG9vZCwgeW91IGFyZSByaWdodC4gVkZJTyBtaWdyYXRpb24gZGlydHkg
c3luYyBuZWVkcyB0byBiZSBub3RpZmllZA0KZXZlbiBpZiBtYXBwaW5nIGlzIHVuY2hhbmdlZC4N
Cg0KPg0KPkkgdGhpbmsgKGFuZCBhZ3JlZSkgaXQgY291bGQgYmUgYSAiYnVnIiBmb3IgdnRkIG9u
bHksIG1vc3RseSBub3QgYWZmZWN0aW5nDQo+YW55dGhpbmcgYXQgbGVhc3QgYmVmb3JlIHZmaW8g
bWlncmF0aW9uLg0KPg0KPkRvIHlvdSBhZ3JlZSwgYW5kIHBlcmhhcHMgd2FudCB0byBmaXggaXQg
YWx0b2dldGhlcj8gIElmIHNvIEkgc3VwcG9zZSBpdCdsbCBhbHNvDQo+Zml4IHRoZSBpc3N1ZSBi
ZWxvdyBvbiB2ZmlvIGRpcnR5IHN5bmMuDQpZZXMsIEknbGwgd3JpdGUgYW4gaW1wbGVtZW50YXRp
b24uDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

