Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D93657D07CC
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 07:49:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtiNa-0005GV-Rn; Fri, 20 Oct 2023 01:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qtiNZ-0005GL-9m
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 01:49:01 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qtiNW-0005tl-Qr
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 01:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697780938; x=1729316938;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dD+KOXHaWDiqBlienfzMCifI4yfiu087Tsd+dh2dTk4=;
 b=MGcoIkciL1JJqqIDpYRel2TOkQfmSxlohFck5I0d2EkBJQxXu1q9EyS7
 uBGTCVrfjbDVqnNkmFOAsgAklp0ULzQBQeTMHR724L9ZesMI+JzknC6c+
 ANpPV3wTBAQXtT9sAIQugKv+uXGZ3SyjuEZRqqEJWfh7Mjrovjor7WE/6
 MzwYIxtkaXdxpYaURiPLo/4/ZAMUVq4Ts91clLIoGU0Wklg8SGmFhc16w
 U0puqKQACzEjTj0VgwIhXGEXc63v4OvqpFylUtOkmeGi83t6E61/1GmYM
 xsXbPYAOocLLkGzvsBKFHG4ebXIybVmxpew+2EAHqfUwzdu6zBnDBxfHN Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389296652"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; d="scan'208";a="389296652"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2023 22:48:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="827617631"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; d="scan'208";a="827617631"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Oct 2023 22:48:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 22:48:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 22:48:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 22:48:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 22:48:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnJCTcxQmR+LuMSpECovX0q8vx8mx12DrcGpbtvRFTIfuPENeXx6Kgm6xGQ3rJaLAaGEFypDQoFWVaQReYEGu4BduSbKAgl4hdFHAKHPf8NCIE9bohu9I7C/Y2J8JJ66uq4f8+UjqsFtGLCzHpYBXqL5XjeBqNoSlhMvLGqZALMVKICexEkNJPirmXOeX2KuBawTLvo/Qrj+UTUrrhEWX8uNQqjOGE4vVizv6owRNWtT2r4IYS7M3bBUYSH677hWPK6x1+bPjUKN61YMdUlKpoNDr+4ZjC9pZR0U/0/NoLfGrLAztRbgAc142d38+hyCJ+zml59rXG8sNHu9Qv/3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dD+KOXHaWDiqBlienfzMCifI4yfiu087Tsd+dh2dTk4=;
 b=Vh3XokWg7xJchPQjoNuPNGBpMem9JcB/uzTbiAcrGcCZZbwg6L/B8jUsWtGIKtv67CaaecEPAwBaT711gP2diw/xXJoChPOC7daO64txfvXvbs6A0ZJoA3S0CwRfRPjghMK6CmqqsEgJ6/q5jrxmpBYBv3bIUX/ItGJRzl74OtEi4JdBkhYDJx76vtp54eu/A6DGhleXgJCpbru02VXlRqxdER6MuiguDakUS2bO2wV6sN+0tMmHgm8D5KZim1TAPkvr3tsvUigzYQRDzujLKC4glfmBb6MwMJwu4+/cPzlyuM1S3gfHvUkEbmuijPTHXfHvXxnn8/+32TTXNp61VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Fri, 20 Oct
 2023 05:48:50 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a%3]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 05:48:50 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, David Gibson <david@gibson.dropbear.id.au>
Subject: RE: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer
 and targetted interface
Thread-Topic: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer
 and targetted interface
Thread-Index: AQHaAA1niboIxiaoHk+mLfxtQdCD+rBOI2WAgACzxLCAAFwsgIABLpGggACqjoCAAP5hIA==
Date: Fri, 20 Oct 2023 05:48:50 +0000
Message-ID: <PH7PR11MB6722D6969CD287A86CFC469792DBA@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
 <20231016083223.1519410-3-zhenzhong.duan@intel.com>
 <f8089865-20cf-4f11-981a-e593a103a387@redhat.com>
 <PH7PR11MB6722FF23DC574EB09300075292D5A@PH7PR11MB6722.namprd11.prod.outlook.com>
 <c5c0c0ff-3eb1-4b46-b39c-e4e7fa250618@redhat.com>
 <PH7PR11MB67226A6A32A4655138CE1C8A92D4A@PH7PR11MB6722.namprd11.prod.outlook.com>
 <cf232093-a59c-49ef-9271-bb691860215b@redhat.com>
In-Reply-To: <cf232093-a59c-49ef-9271-bb691860215b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|SJ0PR11MB7704:EE_
x-ms-office365-filtering-correlation-id: a622366b-747a-4299-c472-08dbd1303c57
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aUimvnOKuLr1tvkREE7LQw9XIrEg2kkmolkjST/UwCYVUfWCEQhahW0fhylVMmd4BKTfZfbjKKor5Hyatggxpi89Oo7uCNnnlWPHKbhbPBFZAjiJYw0KwK2JZVFZNrAXt5zj8xfNmE2bQbdiTaBaJHvqGUZyooU6IYhUnT0ETK2s7UzSg/iRnwkeekipB/uC5ZF9akp3p8dUUWi7wx/kPWw34dujMZAZsu108CCydejwMAYU0B088cyQH2Qjg42fqqwnx2e+iIn+4OG1Tw+imJKwFWaqQ2AYGIbNn78aIUsdLkRM3bLv8CSCOn7CXb/84ogxUaOoyu+kKgWu9MtAsovaN6ogdh5giAlLdE8BfsbH0tNjDCzR1EwEfbwyyhIxiJuHz1UMDxYRHvu8xmEOaiVxdgYoECmJOoPX4ZtN2HnLfi/1ZE6C+wOEL1sRxcJ41aCAKyfCm6ozvyhEN7ezqupk4kSTjghDkDVSmj4xSoasnmnZfd3gWyX4Ketc+K5VFGPOEezfDsaezeM3nnHtugSQnCHUK6OjUENjlWPiYMkBlZIDK2UvzEVB9WCRtXRHJjkpV8u4bTyiiJaJOyCeEYpN8s177BorV20t9mcEblJAZjuKyLep7kg3vQ805Kn7EhpMRB0ObTo7Eg6Csoduk3NOxUeFh0UKuVAvpgDe4pU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(4326008)(38070700009)(122000001)(26005)(55016003)(66556008)(66476007)(64756008)(66446008)(66946007)(316002)(6506007)(66574015)(110136005)(76116006)(71200400001)(478600001)(966005)(82960400001)(7696005)(9686003)(54906003)(53546011)(5660300002)(33656002)(41300700001)(86362001)(52536014)(7416002)(2906002)(83380400001)(30864003)(8676002)(8936002)(38100700002)(2004002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tlp0Z2VVVkhXekpyd29FWk01M3hxMERMMXViWWVZdERrdjh6bWUxekIxeTJO?=
 =?utf-8?B?L292dFc3UWdid1hRYlBZWTgyVlQ0MVJPdkpzTlJJd1FkK2xLWE43UTZacjZp?=
 =?utf-8?B?cWw0QU5LSEt6Vjc5TVRYQ2hUbWp0MnlubEZOd2JVY3lXQzJzVUc0OTlQYkRo?=
 =?utf-8?B?eEx6ZW81REU1SWI5NzQxaXNHOTVzaUZ6MlY0T0oxeVhoMlF6SWg3TFR6a0VN?=
 =?utf-8?B?Qm5ybThWeTBPK3B5WjFJYUxCcHRMSDZqVWxCZzZ3bDBrT1A0OXhjMGt5dVdl?=
 =?utf-8?B?b2FvRSs2MUorWG5MNUVUUzlxS01qaVlVZkVyaHUvcmxGN0h0Z0ROL3pybVo3?=
 =?utf-8?B?ZjdVbFM2eGRaempOSkQ0R2R4dmZwZVBFUjRCSTgwaThRZzBnVDR0d2Q2Z3ZQ?=
 =?utf-8?B?cDFCSzRMSkpsT2tUdXpucVJSaHZiZUZCMjlTTEVLcVB5Y05VeGxyYktUanhD?=
 =?utf-8?B?OVUvbDgyaVh4MlAxZkdGTlcrY3lzditCcnhpREdzN0FhQ05WYmFWN0FsWVBO?=
 =?utf-8?B?TmZEdWRvcm5sOHZnSFdDWjFHejVkc0RGelJJWWkva2FOejcyajgwQlplTVlW?=
 =?utf-8?B?aHJyQUVLSFdab2ZGazByR1pHSUFxUjBweXEvbG1IWE1RSmRLUFF0RzJSemxr?=
 =?utf-8?B?TEgwR3Z3TFRNaldRWGc3amFZWUpucmlpTkpJM2JaRmNmSG95RjltUTZkTEh1?=
 =?utf-8?B?NGdZbnNqeHNsK0NMcE9HYW9lMkdNeHk3R0ZzL01ReTRGYStvTEJXSS85S3RX?=
 =?utf-8?B?WkhPcXFUQXpmUzFHYUxEdG1hL0k0QUhTbGl2NUJMb0hJaUtUK1lyMXJ2Q3dN?=
 =?utf-8?B?TVBmUTlBUExUSXdiSUE3Mm1XQ3ZVL3k4NjNVTG5FVE9rWkdMZzQ4KzIweGVm?=
 =?utf-8?B?WGpTdWVzSk9QQSszZU1IRHZSOFJnSC9IU3dQc0JrK0NrSG1jQUtOQkVZUkpq?=
 =?utf-8?B?NUxrSllBa3EwV1NDc3NCbFNFWGcxem1oNm9RV2RYakI0SUxhOVVXb04rVzhm?=
 =?utf-8?B?RFUraEtxOVd1MEs0S1cwbU03cjMyMU16ZVp6WG5jQkZjWG5PVm5vODBHMFdD?=
 =?utf-8?B?SDFOcSs1cVo1Z3hBWEFSL2padys1MDFZa0ZDTFJ4VUk2c3FyekRaajduV2VT?=
 =?utf-8?B?ZmtrZ09sZGJRQXgyVzVKNE5JWW9acDd4a28relNLNys4VDROcmErN3BUZ3Bz?=
 =?utf-8?B?RzZxSzVxK0IvTkE4bFpNclhtNTZkUERhQWEwMkc4NlYrSU03d2FGb05oa2Zk?=
 =?utf-8?B?UTVFNlhGQkg3NFpkZENVc3QrQ1hrYlJWemwweE5XQjNyeXo4dTJieVJCZm5U?=
 =?utf-8?B?NXhYSnNZU1B3SjlCanhoaHU5VzhxSFBZZUpyMEpLUjhzOGZnbldUaEJkb1oz?=
 =?utf-8?B?L2lCU2w3QS9kcXBZc2xvcEJaNkpsRENUVWxUOVRBbGVPTkg0R3pjTGo1QmNB?=
 =?utf-8?B?bEtaRURqb0RRV2FheFd2Q2U5emVlc0ZYVjBzV0VIbFdQWXhPS3ZiTGh3ZzFE?=
 =?utf-8?B?UlZHaC9VQi8vT1A0RnJxS2hyY2FsUy9veFFETkUwTmlEZHJqSUdqMTFxeCtS?=
 =?utf-8?B?S1JmTDd3Q3F6dWZsMjhFWE0vRzhsL1dIdGF1UElMMkZJR0hKTktkclBWMmJL?=
 =?utf-8?B?eitjSkoyZEFCbFI5d1VCNE1rNzA1NDAzVWM5R3I0czdxOUYyYkF2K1d0dTJP?=
 =?utf-8?B?cGtkM2VnU2E3a3RJZm1yWml6aEJCNE5aQjhFekE3aGpGK1BnODQ0NUk4Snlr?=
 =?utf-8?B?ZkhUMkdhUjN3MDk1dmpjMXhPODVoUzlGS2djUnBOQjVYTnpFellmZHVSV0N1?=
 =?utf-8?B?T1E3TWdONFZ0TWxQTkpVbU9pYUliRmlUL0ZwSHQzSjNvVTg1b0o0T21jNU5y?=
 =?utf-8?B?aXd0a1hLcWNhaXA4RmhIM1l3UjZjQUdGMHpPN1dGbzl1SjdKTStlTjVoSGl1?=
 =?utf-8?B?ZE9US1JmMk5qT3JlWTJkTlV1NFQ4OGc0K3Q1WmUxbjZoN3hMcWt1MDdTYUJ2?=
 =?utf-8?B?aTc5d0h6OHBSd2FNaU1xRW1NTHFGRzNjQ0dncDhaSS9iR3hkOVhheEp6L3FT?=
 =?utf-8?B?UVVyL2dHUnRUYXNOdlpjR3NpQklGQyt5aEhKdlovb3dBRFM3SDJpd1pURXJG?=
 =?utf-8?Q?IM8jL67/cx98rcaZdSNHDn3Qn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a622366b-747a-4299-c472-08dbd1303c57
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 05:48:50.3769 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6j4caSAOYJFXPhlrou+soYvr0C7xyAyWPxk38NKLNmxUs6xQn22SKcIikwhnDMitsPK/mB1MmiHED2Dfm0HMu9dFshiVX5BM2BvbfzJ2lA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7704
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDE5
LCAyMDIzIDg6MTggUE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDAyLzI3XSB2ZmlvOiBJbnRy
b2R1Y2UgYmFzZSBvYmplY3QgZm9yIFZGSU9Db250YWluZXIgYW5kDQo+dGFyZ2V0dGVkIGludGVy
ZmFjZQ0KPg0KPk9uIDEwLzE5LzIzIDA0OjI5LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQHJlZGhhdC5jb20+DQo+Pj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDE4LCAyMDIzIDQ6
MDQgUE0NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAyLzI3XSB2ZmlvOiBJbnRyb2R1Y2Ug
YmFzZSBvYmplY3QgZm9yIFZGSU9Db250YWluZXINCj5hbmQNCj4+PiB0YXJnZXR0ZWQgaW50ZXJm
YWNlDQo+Pj4NCj4+PiBPbiAxMC8xOC8yMyAwNDo0MSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0K
Pj4+PiBIaSBDw6lkcmljLA0KPj4+Pg0KPj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4+Pj4+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4+Pj4+IFNl
bnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTcsIDIwMjMgMTE6NTEgUE0NCj4+Pj4+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjIgMDIvMjddIHZmaW86IEludHJvZHVjZSBiYXNlIG9iamVjdCBmb3IgVkZJT0Nv
bnRhaW5lcg0KPj4+IGFuZA0KPj4+Pj4gdGFyZ2V0dGVkIGludGVyZmFjZQ0KPj4+Pj4NCj4+Pj4+
IE9uIDEwLzE2LzIzIDEwOjMxLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4+PiBGcm9tOiBF
cmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+Pj4+Pj4NCj4+Pj4+PiBJbnRyb2R1
Y2UgYSBkdW1iIFZGSU9Db250YWluZXIgYmFzZSBvYmplY3QgYW5kIGl0cyB0YXJnZXR0ZWQgaW50
ZXJmYWNlLg0KPj4+Pj4+IFRoaXMgaXMgd2lsbGluZ2x5IG5vdCBhIFFPTSBvYmplY3QgYmVjYXVz
ZSB3ZSBkb24ndCB3YW50IGl0IHRvIGJlDQo+Pj4+Pj4gdmlzaWJsZSBmcm9tIHRoZSB1c2VyIGlu
dGVyZmFjZS4gIFRoZSBWRklPQ29udGFpbmVyIHdpbGwgYmUgc21vb3RobHkNCj4+Pj4+PiBwb3B1
bGF0ZWQgaW4gc3Vic2VxdWVudCBwYXRjaGVzIGFzIHdlbGwgYXMgaW50ZXJmYWNlcy4NCj4+Pj4+
Pg0KPj4+Pj4+IE5vIGZ1Y250aW9uYWwgY2hhbmdlIGludGVuZGVkLg0KPj4+Pj4+DQo+Pj4+Pj4g
U2lnbmVkLW9mZi1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4+Pj4+
IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50ZWwuY29tPg0KPj4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4+
Pj4gLS0tDQo+Pj4+Pj4gICAgIGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oICAgICAgICAg
fCAgOCArLS0NCj4+Pj4+PiAgICAgaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2Uu
aCB8IDgyDQo+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+Pj4gICAgIDIgZmls
ZXMgY2hhbmdlZCwgODQgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4+Pj4+PiAgICAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRhaW5lci1iYXNlLmgN
Cj4+Pj4+Pg0KPj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24u
aCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLQ0KPj4+IGNvbW1vbi5oDQo+Pj4+Pj4gaW5kZXggMzQ2
NDhlNTE4ZS4uOTY1MWNmOTIxYyAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9pbmNsdWRlL2h3L3ZmaW8v
dmZpby1jb21tb24uaA0KPj4+Pj4+ICsrKyBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5o
DQo+Pj4+Pj4gQEAgLTMwLDYgKzMwLDcgQEANCj4+Pj4+PiAgICAgI2luY2x1ZGUgPGxpbnV4L3Zm
aW8uaD4NCj4+Pj4+PiAgICAgI2VuZGlmDQo+Pj4+Pj4gICAgICNpbmNsdWRlICJzeXNlbXUvc3lz
ZW11LmgiDQo+Pj4+Pj4gKyNpbmNsdWRlICJody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaCIN
Cj4+Pj4+Pg0KPj4+Pj4+ICAgICAjZGVmaW5lIFZGSU9fTVNHX1BSRUZJWCAidmZpbyAlczogIg0K
Pj4+Pj4+DQo+Pj4+Pj4gQEAgLTgxLDYgKzgyLDcgQEAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0FkZHJl
c3NTcGFjZSB7DQo+Pj4+Pj4gICAgIHN0cnVjdCBWRklPR3JvdXA7DQo+Pj4+Pj4NCj4+Pj4+PiAg
ICAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0xlZ2FjeUNvbnRhaW5lciB7DQo+Pj4+Pj4gKyAgICBWRklP
Q29udGFpbmVyIGJjb250YWluZXI7DQo+Pj4+Pg0KPj4+Pj4gVGhhdCdzIHRoZSBwYXJlbnQgY2xh
c3MsIHJpZ2h0ID8NCj4+Pj4NCj4+Pj4gUmlnaHQuDQo+Pj4+DQo+Pj4+Pg0KPj4+Pj4+ICAgICAg
ICAgVkZJT0FkZHJlc3NTcGFjZSAqc3BhY2U7DQo+Pj4+Pj4gICAgICAgICBpbnQgZmQ7IC8qIC9k
ZXYvdmZpby92ZmlvLCBlbXBvd2VyZWQgYnkgdGhlIGF0dGFjaGVkIGdyb3VwcyAqLw0KPj4+Pj4+
ICAgICAgICAgTWVtb3J5TGlzdGVuZXIgbGlzdGVuZXI7DQo+Pj4+Pj4gQEAgLTIwMCwxMiArMjAy
LDYgQEAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0Rpc3BsYXkgew0KPj4+Pj4+ICAgICAgICAgfSBkbWFi
dWY7DQo+Pj4+Pj4gICAgIH0gVkZJT0Rpc3BsYXk7DQo+Pj4+Pj4NCj4+Pj4+PiAtdHlwZWRlZiBz
dHJ1Y3Qgew0KPj4+Pj4+IC0gICAgdW5zaWduZWQgbG9uZyAqYml0bWFwOw0KPj4+Pj4+IC0gICAg
aHdhZGRyIHNpemU7DQo+Pj4+Pj4gLSAgICBod2FkZHIgcGFnZXM7DQo+Pj4+Pj4gLX0gVkZJT0Jp
dG1hcDsNCj4+Pj4+PiAtDQo+Pj4+Pj4gICAgIHZvaWQgdmZpb19ob3N0X3dpbl9hZGQoVkZJT0xl
Z2FjeUNvbnRhaW5lciAqY29udGFpbmVyLA0KPj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGh3YWRkciBtaW5faW92YSwgaHdhZGRyIG1heF9pb3ZhLA0KPj4+Pj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHVpbnQ2NF90IGlvdmFfcGdzaXplcyk7DQo+Pj4+Pj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRhaW5lci1iYXNlLmggYi9pbmNsdWRlL2h3L3Zm
aW8vdmZpby0NCj4+Pj4+IGNvbnRhaW5lci1iYXNlLmgNCj4+Pj4+PiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPj4+Pj4+IGluZGV4IDAwMDAwMDAwMDAuLmFmYzg1NDNkMjINCj4+Pj4+PiAtLS0gL2Rl
di9udWxsDQo+Pj4+Pj4gKysrIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2Uu
aA0KPj4+Pj4+IEBAIC0wLDAgKzEsODIgQEANCj4+Pj4+PiArLyoNCj4+Pj4+PiArICogVkZJTyBC
QVNFIENPTlRBSU5FUg0KPj4+Pj4+ICsgKg0KPj4+Pj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjMg
SW50ZWwgQ29ycG9yYXRpb24uDQo+Pj4+Pj4gKyAqIENvcHlyaWdodCBSZWQgSGF0LCBJbmMuIDIw
MjMNCj4+Pj4+PiArICoNCj4+Pj4+PiArICogQXV0aG9yczogWWkgTGl1IDx5aS5sLmxpdUBpbnRl
bC5jb20+DQo+Pj4+Pj4gKyAqICAgICAgICAgIEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0
LmNvbT4NCj4+Pj4+PiArICoNCj4+Pj4+PiArICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdh
cmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkNCj4+Pj4+PiArICogaXQg
dW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJs
aXNoZWQgYnkNCj4+Pj4+PiArICogdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVy
IHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3INCj4+Pj4+PiArICogKGF0IHlvdXIgb3B0aW9u
KSBhbnkgbGF0ZXIgdmVyc2lvbi4NCj4+Pj4+PiArDQo+Pj4+Pj4gKyAqIFRoaXMgcHJvZ3JhbSBp
cyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLA0KPj4+Pj4+
ICsgKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3
YXJyYW50eSBvZg0KPj4+Pj4+ICsgKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQ
QVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlDQo+Pj4+Pj4gKyAqIEdOVSBHZW5lcmFsIFB1Ymxp
YyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuDQo+Pj4+Pj4gKw0KPj4+Pj4+ICsgKiBZb3Ugc2hv
dWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5z
ZQ0KPmFsb25nDQo+Pj4+Pj4gKyAqIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHNlZSA8aHR0
cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzLz4uDQo+Pj4+Pj4gKyAqLw0KPj4+Pj4+ICsNCj4+Pj4+
PiArI2lmbmRlZiBIV19WRklPX1ZGSU9fQkFTRV9DT05UQUlORVJfSA0KPj4+Pj4+ICsjZGVmaW5l
IEhXX1ZGSU9fVkZJT19CQVNFX0NPTlRBSU5FUl9IDQo+Pj4+Pj4gKw0KPj4+Pj4+ICsjaW5jbHVk
ZSAiZXhlYy9tZW1vcnkuaCINCj4+Pj4+PiArI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZDQo+Pj4+
Pj4gKyNpbmNsdWRlICJleGVjL2h3YWRkci5oIg0KPj4+Pj4+ICsjZW5kaWYNCj4+Pj4+PiArDQo+
Pj4+Pj4gK3R5cGVkZWYgc3RydWN0IFZGSU9Db250YWluZXIgVkZJT0NvbnRhaW5lcjsNCj4+Pj4+
PiArdHlwZWRlZiBzdHJ1Y3QgVkZJT0RldmljZSBWRklPRGV2aWNlOw0KPj4+Pj4+ICt0eXBlZGVm
IHN0cnVjdCBWRklPSU9NTVVCYWNrZW5kT3BzQ2xhc3MNCj5WRklPSU9NTVVCYWNrZW5kT3BzQ2xh
c3M7DQo+Pj4+Pj4gKw0KPj4+Pj4+ICt0eXBlZGVmIHN0cnVjdCB7DQo+Pj4+Pj4gKyAgICB1bnNp
Z25lZCBsb25nICpiaXRtYXA7DQo+Pj4+Pj4gKyAgICBod2FkZHIgc2l6ZTsNCj4+Pj4+PiArICAg
IGh3YWRkciBwYWdlczsNCj4+Pj4+PiArfSBWRklPQml0bWFwOw0KPj4+Pj4+ICsNCj4+Pj4+PiAr
LyoNCj4+Pj4+PiArICogVGhpcyBpcyB0aGUgYmFzZSBvYmplY3QgZm9yIHZmaW8gY29udGFpbmVy
IGJhY2tlbmRzDQo+Pj4+Pj4gKyAqLw0KPj4+Pj4+ICtzdHJ1Y3QgVkZJT0NvbnRhaW5lciB7DQo+
Pj4+Pj4gKyAgICBWRklPSU9NTVVCYWNrZW5kT3BzQ2xhc3MgKm9wczsNCj4+Pj4+DQo+Pj4+PiBU
aGlzIGlzIHVuZXhwZWN0ZWQuDQo+Pj4+Pg0KPj4+Pj4gSSB0aG91Z2h0IHRoYXQgYW4gYWJzdHJh
Y3QgUU9NIG1vZGVsIGZvciBWRklPQ29udGFpbmVyIHdhcyBnb2luZw0KPj4+Pj4gdG8gYmUgaW50
cm9kdWNlZCB3aXRoIGEgVkZJT0NvbnRhaW5lckNsYXNzIHdpdGggdGhlIG9wcyBiZWxvdw0KPj4+
Pj4gKFZGSU9JT01NVUJhY2tlbmRPcHNDbGFzcykuDQo+Pj4+Pg0KPj4+Pj4gVGhlbiwgd2Ugd291
bGQgY2FsbCA6DQo+Pj4+Pg0KPj4+Pj4gICAgICBWRklPQ29udGFpbmVyQ2xhc3MgKnZjYyA9IFZG
SU9fQ09OVEFJTkVSX0dFVF9DTEFTUyhjb250YWluZXIpOw0KPj4+Pj4NCj4+Pj4+IHRvIGdldCB0
aGUgc3BlY2lmaWMgaW1wbGVtZW50YXRpb24gZm9yIHRoZSBjdXJyZW50IGNvbnRhaW5lci4NCj4+
Pj4+DQo+Pj4+PiBJIGRvbid0IHVuZGVyc3RhbmQgdGhlIFZGSU9JT01NVUJhY2tlbmRPcHNDbGFz
cyBwb2ludGVyIGFuZA0KPj4+Pj4gVFlQRV9WRklPX0lPTU1VX0JBQ0tFTkRfT1BTLiBJdCBzZWVt
cyByZWR1bmRhbnQuDQo+Pj4+DQo+Pj4+IFRoZSBvcmlnaW5hbCBpbXBsZW1lbnRhdGlvbiB3YXMg
YWJzdHJhY3QgUU9NIG1vZGVsLiBCdXQgaXQgd2Fzbid0DQo+YWNjZXB0ZWQsDQo+Pj4+IHNlZSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvWW11RnYyczVUUHV3N0slMkZ1QHlla2tvLyBmb3Ig
ZGV0YWlscy4NCj4+Pg0KPj4+IEkgc2VlIHRoZSBpZGVhIHdhcyBjaGFsbGVuZ2VkLCBub3QgcmVq
ZWN0ZWQuIEkgbmVlZCB0byBkaWcgaW4gZnVydGhlciBhbmQgdGhpcw0KPj4+IHdpbGwgdGFrZSB0
aW1lLg0KPj4gVGhhbmtzIGZvciBoZWxwIGxvb2tpbmcgaW50byBpdC4NCj4+DQo+PiArRGF2aWQs
IEhpIERhdmlkLCBJJ20gZGlnZ2luZyBpbnRvIHlvdXIgY29uY2VybiBvZiB1c2luZyBRT00gdG8g
YWJzdHJhY3QgYmFzZQ0KPj4gY29udGFpbmVyIGFuZCBsZWdhY3kgVkZJT0NvbnRhaW5lcjoNCj4+
ICJUaGUgUU9NIGNsYXNzIG9mIHRoaW5ncyBpcyB2aXNpYmxlIHRvIHRoZSB1c2VyL2NvbmZpZyBs
YXllciB2aWEgUU1QIChhbmQNCj5zb21ldGltZXMgY29tbWFuZCBsaW5lKS4NCj4+IEl0IGRvZXNu
J3QgbmVjZXNzYXJpbHkgY29ycmVzcG9uZCB0byBndWVzdCB2aXNpYmxlIGRpZmZlcmVuY2VzLCBi
dXQgaXQgb2Z0ZW4gZG9lcy4iDQo+Pg0KPj4gQUlVSSwgd2hpbGUgaXQncyB0cnVlIHdoZW4gdGhl
IFFPTSB0eXBlIGluY2x1ZGVzIFRZUEVfVVNFUl9DUkVBVEFCTEUNCj5pbnRlcmZhY2UsDQo+PiBv
dGhlcndpc2UsIHVzZXIgY2FuJ3QgY3JlYXRlIGFuIG9iamVjdCBvZiB0aGlzIHR5cGUuIE9ubHkg
ZGlmZmVyZW5jZSBpcyB1c2VyIHdpbGwNCj5zZWUNCj4+ICJvYmplY3QgdHlwZSAnJXMnIGlzbid0
IHN1cHBvcnRlZCBieSBvYmplY3QtYWRkIiBpbnN0ZWFkIG9mICJpbnZhbGlkIG9iamVjdA0KPnR5
cGU6ICVzIi4NCj4+DQo+PiBJcyB5b3VyIGV4cGVjdGF0aW9uIHRvIG5vdCBwZXJtaXQgdXNlciB0
byBjcmVhdGUgdGhpcyBvYmplY3Qgb3Igb25seSB3YW50IHVzZXINCj4+IHRvIHNlZSAiaW52YWxp
ZCBvYmplY3QgdHlwZTogJXMiLg0KPj4gSWYgeW91IG1lYW4gdGhlIGZpcnN0LCB0aGVuIEkgdGhp
bmsgUU9NIGNvdWxkIGJlIHN1aXRhYmxlIGlmIHdlIGRvbid0IGluY2x1ZGUNCj4+IFRZUEVfVVNF
Ul9DUkVBVEFCTEUgaW50ZXJmYWNlPw0KPg0KPkkgd2FzIGltYWdpbmluZyBzb21lIGtpbmQgb2Yg
UU9NIGhpZXJhcmNoeSB1bmRlciB0aGUgdmZpbyBkZXZpY2UNCj53aXRoIHZhcmlvdXMgUU9NIGlu
dGVyZmFjZXMgKHNpbWlsYXIgdG8gdGhlIG9wcykgdG8gZGVmaW5lIHRoZQ0KPnBvc3NpYmxlIElP
TU1VIGJhY2tlbmRzLiBUaGUgZmFjdCB0aGF0IHdlIHVzZSB0aGUgSU9NTVVGRCBvYmplY3QNCj5m
cm9tIHRoZSBjb21tYW5kIGxpbmUgbWFkZSBpdCBtb3JlIHBsYXVzaWJsZS4gSSBtaWdodCBiZSBt
aXN0YWtpbmcuDQoNCkdvdCB5b3VyIHBvaW50Lg0KVGhpcyB3YXkgd2UgaW50cm9kdWNlIGEgbmV3
IFFPTSB0eXBlICJ2ZmlvLXBjaS1pb21tdWZkIiBmb3IgaW9tbXVmZCBzdXBwb3J0LA0KYW5kIHZm
aW8tcGNpIGtlZXAgc2FtZSBmb3IgbGVnYWN5IGJhY2tlbmQsIGUuZzoNCg0KI3FlbXUgIC1vYmpl
Y3QgaW9tbXVmZCxpZD1pb21tdWZkMCBcDQogICAgICAgICAgICAgIC1kZXZpY2UgdmZpby1wY2kt
aW9tbXVmZCxpb21tdWZkPWlvbW11ZmQwLGlkPXZmaW8wLi4uIFwNCiAgICAgICAgICAgICAtZGV2
aWNlIHZmaW8tcGNpLGlkPXZmaW8xLi4uDQoNCkJlbG93IGlzIGEgZHJhZnQgZm9yIHZmaW8tcGNp
IGJhc2VkIG9uIHlvdXIgaW1hZ2luYXRpb24uIG5vdCBwYXN0ZWQgaGVyZSB0aGUgY2hhbmdlDQpm
b3IgcGxhdGZvcm0vYXAvY2N3IHZmaW8gZGV2aWNlIHdoaWNoIHNob3VsZCBiZSBzaW1pbGFyLg0K
Tm90IGNsZWFyIGlmIHRoaXMgZnVsbHkgbWF0Y2ggeW91ciBpbWFnaW5hdGlvbi4NCg0KZGlmZiAt
LWdpdCBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRhaW5lci1iYXNlLmggYi9pbmNsdWRlL2h3
L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oDQppbmRleCA1MzQ1OTg2OTkzLi41NGE2Y2U0ZDcz
IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaA0KKysr
IGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaA0KQEAgLTEyNCw3ICsxMjQs
NyBAQCBERUNMQVJFX0NMQVNTX0NIRUNLRVJTKFZGSU9JT01NVUJhY2tlbmRPcHNDbGFzcywNCg0K
IHN0cnVjdCBWRklPSU9NTVVCYWNrZW5kT3BzQ2xhc3Mgew0KICAgICAvKjwgcHJpdmF0ZSA+Ki8N
Ci0gICAgT2JqZWN0Q2xhc3MgcGFyZW50X2NsYXNzOw0KKyAgICBJbnRlcmZhY2VDbGFzcyBwYXJl
bnRfY2xhc3M7DQoNCiAgICAgLyo8IHB1YmxpYyA+Ki8NCiAgICAgLyogcmVxdWlyZWQgKi8NCmRp
ZmYgLS1naXQgYS9ody92ZmlvL3BjaS5jIGIvaHcvdmZpby9wY2kuYw0KaW5kZXggZWRiNzg3ZDNk
MS4uODI5ZGVkZGM3ZCAxMDA2NDQNCi0tLSBhL2h3L3ZmaW8vcGNpLmMNCisrKyBiL2h3L3ZmaW8v
cGNpLmMNCkBAIC0zNzI1LDYgKzM3MjUsMTEgQEAgc3RhdGljIHZvaWQgdmZpb19wY2lfZGV2X2Ns
YXNzX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLCB2b2lkICpkYXRhKQ0KIHsNCiAgICAgRGV2aWNl
Q2xhc3MgKmRjID0gREVWSUNFX0NMQVNTKGtsYXNzKTsNCiAgICAgUENJRGV2aWNlQ2xhc3MgKnBk
YyA9IFBDSV9ERVZJQ0VfQ0xBU1Moa2xhc3MpOw0KKyAgICBJT01NVV9CYWNrZW5kX09wc19DbGFz
cyAqYmVfb3BzID0gSU9NTVVfQkFDS0VORF9PUFNfQ0xBU1Moa2xhc3MpOw0KKw0KKyAgICBiZV9v
cHMtPmRtYV9tYXAgPSB2ZmlvX2xlZ2FjeV9kbWFfbWFwOw0KKyAgICBiZV9vcHMtPmRtYV91bm1h
cCA9IHZmaW9fbGVnYWN5X2RtYV91bm1hcDsNCisgICAgLi4uDQoNCiAgICAgZGMtPnJlc2V0ID0g
dmZpb19wY2lfcmVzZXQ7DQogICAgIGRldmljZV9jbGFzc19zZXRfcHJvcHMoZGMsIHZmaW9fcGNp
X2Rldl9wcm9wZXJ0aWVzKTsNCkBAIC0zNzQ5LDEwICszNzU0LDQwIEBAIHN0YXRpYyBjb25zdCBU
eXBlSW5mbyB2ZmlvX3BjaV9kZXZfaW5mbyA9IHsNCiAgICAgLmludGVyZmFjZXMgPSAoSW50ZXJm
YWNlSW5mb1tdKSB7DQogICAgICAgICB7IElOVEVSRkFDRV9QQ0lFX0RFVklDRSB9LA0KICAgICAg
ICAgeyBJTlRFUkZBQ0VfQ09OVkVOVElPTkFMX1BDSV9ERVZJQ0UgfSwNCisgICAgICAgIHsgSU5U
RVJGQUNFX0lPTU1VX0JBQ0tFTkRfT1BTIH0sDQogICAgICAgICB7IH0NCiAgICAgfSwNCiB9Ow0K
DQorc3RhdGljIFByb3BlcnR5IHZmaW9fcGNpX2Rldl9pb21tdWZkX3Byb3BlcnRpZXNbXSA9IHsN
CisjaWZkZWYgQ09ORklHX0lPTU1VRkQNCisgICAgREVGSU5FX1BST1BfTElOSygiaW9tbXVmZCIs
IFZGSU9QQ0lEZXZpY2UsIHZiYXNlZGV2LmlvbW11ZmQsDQorICAgICAgICAgICAgICAgICAgICAg
VFlQRV9JT01NVUZEX0JBQ0tFTkQsIElPTU1VRkRCYWNrZW5kICopLA0KKyNlbmRpZg0KK307DQor
DQorc3RhdGljIHZvaWQgdmZpb19wY2lfaW9tbXVmZF9kZXZfY2xhc3NfaW5pdChPYmplY3RDbGFz
cyAqa2xhc3MsIHZvaWQgKmRhdGEpDQorew0KKyAgICBEZXZpY2VDbGFzcyAqZGMgPSBERVZJQ0Vf
Q0xBU1Moa2xhc3MpOw0KKyAgICBJT01NVV9CYWNrZW5kX09wc19DbGFzcyAqYmVfb3BzID0gSU9N
TVVfQkFDS0VORF9PUFNfQ0xBU1Moa2xhc3MpOw0KKw0KKyAgICBkZXZpY2VfY2xhc3Nfc2V0X3By
b3BzKGRjLCB2ZmlvX3BjaV9kZXZfaW9tbXVmZF9wcm9wZXJ0aWVzKTsNCisNCisgICAgYmVfb3Bz
LT5kbWFfbWFwID0gaW9tbXVmZF9tYXA7DQorICAgIGJlX29wcy0+ZG1hX3VubWFwID0gaW9tbXVm
ZF91bm1hcDsNCisgICAgLi4uDQorICAgIC8qIFVuaW1wbGVtZW50ZWQgb3BzICovDQorICAgIGJl
X29wcy0+c2V0X2RpcnR5X3BhZ2VfdHJhY2tpbmcgPSBOVUxMOw0KKyAgICAuLi4NCit9DQorDQor
c3RhdGljIGNvbnN0IFR5cGVJbmZvIHZmaW9fcGNpX2lvbW11ZmRfZGV2X2luZm8gPSB7DQorICAg
IC5uYW1lID0gVFlQRV9WRklPX1BDSV9JT01NVUZELA0KKyAgICAucGFyZW50ID0gVFlQRV9WRklP
X1BDSSwNCisgICAgLmluc3RhbmNlX3NpemUgPSBzaXplb2YoVkZJT1BDSURldmljZSksDQorICAg
IC5jbGFzc19pbml0ID0gdmZpb19wY2lfaW9tbXVmZF9kZXZfY2xhc3NfaW5pdCwNCit9Ow0KKw0K
IHN0YXRpYyBQcm9wZXJ0eSB2ZmlvX3BjaV9kZXZfbm9ob3RwbHVnX3Byb3BlcnRpZXNbXSA9IHsN
CiAgICAgREVGSU5FX1BST1BfQk9PTCgicmFtZmIiLCBWRklPUENJRGV2aWNlLCBlbmFibGVfcmFt
ZmIsIGZhbHNlKSwNCiAgICAgREVGSU5FX1BST1BfT05fT0ZGX0FVVE8oIngtcmFtZmItbWlncmF0
ZSIsIFZGSU9QQ0lEZXZpY2UsIHJhbWZiX21pZ3JhdGUsDQpAQCAtMzc3MCwxMyArMzgwNSwyMCBA
QCBzdGF0aWMgdm9pZCB2ZmlvX3BjaV9ub2hvdHBsdWdfZGV2X2NsYXNzX2luaXQoT2JqZWN0Q2xh
c3MgKmtsYXNzLCB2b2lkICpkYXRhKQ0KDQogc3RhdGljIGNvbnN0IFR5cGVJbmZvIHZmaW9fcGNp
X25vaG90cGx1Z19kZXZfaW5mbyA9IHsNCiAgICAgLm5hbWUgPSBUWVBFX1ZGSU9fUENJX05PSE9U
UExVRywNCi0gICAgLnBhcmVudCA9IFRZUEVfVkZJT19QQ0ksDQorICAgIC5wYXJlbnQgPSBUWVBF
X1ZGSU9fUENJX0lPTU1VRkQsDQogICAgIC5pbnN0YW5jZV9zaXplID0gc2l6ZW9mKFZGSU9QQ0lE
ZXZpY2UpLA0KICAgICAuY2xhc3NfaW5pdCA9IHZmaW9fcGNpX25vaG90cGx1Z19kZXZfY2xhc3Nf
aW5pdCwNCiB9Ow0KDQogc3RhdGljIHZvaWQgcmVnaXN0ZXJfdmZpb19wY2lfZGV2X3R5cGUodm9p
ZCkNCiB7DQorICAgIHN0YXRpYyBjb25zdCBUeXBlSW5mbyBpb21tdV9iZV9vcHNfaW50ZXJmYWNl
X2luZm8gPSB7DQorICAgICAgICAubmFtZSAgICAgICAgICA9IFRZUEVfSU9NTVVfQkFDS0VORF9P
UFMsDQorICAgICAgICAucGFyZW50ICAgICAgICA9IFRZUEVfSU5URVJGQUNFLA0KKyAgICAgICAg
LmNsYXNzX3NpemUgPSBzaXplb2YoVkZJT0lPTU1VQmFja2VuZE9wc0NsYXNzKSwNCisgICAgfTsN
CisNCisgICAgdHlwZV9yZWdpc3Rlcl9zdGF0aWMoJmlvbW11X2JlX29wc19pbnRlcmZhY2VfaW5m
byk7DQogICAgIHR5cGVfcmVnaXN0ZXJfc3RhdGljKCZ2ZmlvX3BjaV9kZXZfaW5mbyk7DQogICAg
IHR5cGVfcmVnaXN0ZXJfc3RhdGljKCZ2ZmlvX3BjaV9ub2hvdHBsdWdfZGV2X2luZm8pOw0KIH0N
Cg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0KPkFueWhvdywgdGhlIHNlcmllcyBsb29rcyBwcmV0
dHkgZ29vZC4gVGhlcmUgYXJlIG90aGVyIGFzcGVjdCB0bw0KPmNoZWNrLCBsaWtlIGFyZSBhbGwg
dGhpcyBpb21tdSBvcHMgd2VsbCBzdWl0ZWQgZm9yIHRoZSBuZWVkID8NCj5MZXQncyBzdHJlc3Mg
dGhlIG1vZGVscyBpbiBwYXJhbGxlbCBvZiB0aGUgcmV2aWV3cy4gSWYgd2UgY291bGQgZ2V0DQo+
c29tZSBvZiBpdCBmb3IgOC4yIHRoYXQnZCBiZSBuaWNlLiBJdCdzIG9uIHRvcCBvZiBteSBsaXN0
IG5vdy4NCj4NCj5UaGFua3MsDQo+DQo+Qy4NCj4NCj4NCj4+IFRoYW5rcw0KPj4gWmhlbnpob25n
DQoNCg==

