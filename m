Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4697E77EB
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 04:17:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1I17-0004UW-QC; Thu, 09 Nov 2023 22:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r1I15-0004U2-Ny; Thu, 09 Nov 2023 22:17:07 -0500
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r1I12-0001m6-Mv; Thu, 09 Nov 2023 22:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699586224; x=1731122224;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7mY0ppTDr8Mxi8GieM/ObfJbDesmuf53fdYPhlZJIlE=;
 b=Ig0nUA8Dc2uomPJsCjf9RCJxBDo5pZJ+O5mFcfOPTXUX5s02G/cRoSEZ
 zxWnxRrv1dle2+x3zR4LLGEYlQFSC74xCNoByuL4hb1d8tkwQLTbd4bb8
 FEC0eLW9THl8nqhXvnmDpfNu8rY74ZIwuLQdF2BguNXy5lz4KY9UQbVha
 Z2Ic2sM9A5dWVukSnMsNXHFcuMtfg0OpJB9FQM17NYjiX1SDztC+QFkGQ
 O98aLpmL6SV9NHkYOVEpjHwev10Agzbj2ZTbKCkqHyJefVs1TO8V2ikLo
 gt4dkoC6vz2pYpIP4TPeWA3V4eVS4nBlX1qnzz/xRANQD2wcHDhiE4uUu w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="387284035"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; d="scan'208";a="387284035"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 19:17:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="834041869"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; d="scan'208";a="834041869"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Nov 2023 19:17:01 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 19:17:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 19:17:01 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 19:17:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXOWwwokJgs0YlDgLweeClXJt2CBTgZQ5/rHbS7flEvmrdXm9vgI3mmb7nR/lu72Zuo16ldHVOE+AObr9dztFAv/+LPp3wNLPEvBXBhjUrtICMmT5hYrX+xBjtrZoto1zGv0Yp9OW+NGKQlF/tuNO+G5jQxaS3TXhVduLL6P49Z5oQ+gYuqs0kx1kbjI4448wIMIFGCSuYfAS2VS4EZiBgCy1VFJeMFJrJaWYV+Yo03zUOFBfQT+e6JDdkutttTJqMamfoYr9SLJvYX0IUgsB3Rmd2seUA/1OMu8GbFg7WFWWto8JeRMJFvAa/u1s4I1oSQHFNJ7Orkr4UNHf4cQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mY0ppTDr8Mxi8GieM/ObfJbDesmuf53fdYPhlZJIlE=;
 b=m2RN5trd37KOzMGYCfFAUceJdHeRQeNSMvFFIV2Pndh57Qo+xU9VrZBqHfAc3LWu40T1Kg25A/1sNFKojpaCg9An0LVq+n/W8nnMIY4dXCScgK5wR1TN7BtVDHNcakVUtPlrWoOxlMpnqynpAc8ZYabkx2Boii/o/343j54LaXRt8GmgeF3ITl0ott70RFjPKjUmM18PqDNU8Myy3BDmDsUdtdTvM8mHJA6w73YOxDHnRRUFRtqSp0Te0FbDMeEbhOUhUrIFnPez93sc7gN21vtgLkEzW+qwIeL2+ofKXVBiIwlMlc9nNXasvsexvir14LrDIYY8KMkXeaZHEYofBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB5076.namprd11.prod.outlook.com (2603:10b6:303:90::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 03:16:58 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 03:16:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, David Hildenbrand
 <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, "open
 list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
Subject: RE: [PATCH v5 19/20] kconfig: Activate IOMMUFD for s390x machines
Thread-Topic: [PATCH v5 19/20] kconfig: Activate IOMMUFD for s390x machines
Thread-Index: AQHaEwSZpvHtWEsSG0m9X/UlI4qkMLBymwWAgABHYDA=
Date: Fri, 10 Nov 2023 03:16:58 +0000
Message-ID: <SJ0PR11MB67441A0692D630D1B5336BA292AEA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
 <20231109114529.1904193-20-zhenzhong.duan@intel.com>
 <2acb76b0-00cd-a448-f615-0cb1825e81a0@linux.ibm.com>
In-Reply-To: <2acb76b0-00cd-a448-f615-0cb1825e81a0@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB5076:EE_
x-ms-office365-filtering-correlation-id: 914dac44-5c78-4460-25e4-08dbe19b7fdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Blk1xz/w+Bz3PNFLFHuI64IyRJJSa/zXzCMW/BvOZdl3PtyYsizIvEmgDCnnSrg+wSeOPAQAjPvHUfxa9QWj6ExVeblZCmviTPUw5Fz1I3AMJ6YA77cm09igYH08PTLZD/39bnvQdhd7mIMkWdFmjt8/MRdnVht2JadHAnaWyC2ykBz3ZR3sTBfF45X4B6ec60os6FsdQDGSkIDWkhR7CjqCNXPmjVbXVSzmY4ttU5maZ1nwsJqcsEixSasaVb1bQJtjdugmy5gsv1VKXBPXc9Mu+iKG5fI/ZqvKTouVJPyaBJiIzV3u5w1onjoYHpWGwfK/oGsxv7muvuEKxzkAgkBcYviFTxYPJpb8PadjfOOiW9QuqiPdJkNhXyYB293BlY5zT3PTlO2M5acazUacqgRgZ1pqT4f7b9s9d360k8qfw/JMUFsznltgHquPhi1mjDjxvf6/X7h9doYgniifndzIuSti+qQnQmDPXqg+3pKDBxWx6mbSPbBqb3ezvgT7RQS7sPg5YX/yFQvKIsmrDi172GENpgK63Wpy3+/eVP0zJKh3SxvdFI3oxNaCq5bsLav2A0pw/JNilhdhrWQcQgZMsUHaVoLhTnbAMdIMKscEtw+otYbBugKo/yvsaqG9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(478600001)(8676002)(4326008)(52536014)(5660300002)(55016003)(71200400001)(7696005)(6506007)(83380400001)(8936002)(66574015)(316002)(2906002)(66446008)(26005)(110136005)(54906003)(66556008)(66476007)(7416002)(66946007)(76116006)(64756008)(122000001)(38100700002)(41300700001)(86362001)(9686003)(82960400001)(38070700009)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTlzM1VPQmJpbTlRQnZOKzlIM25PS096aGFXd2pQMmMxL3BhSlJpTDNjb1VH?=
 =?utf-8?B?MlhFRkZJbS9xbTlZT1F0enlEOWVVbXlvUnhLSmlPT3Y2RG1HTFNLRVhOczJD?=
 =?utf-8?B?WDltUlhURlFmNHFnZ08vZGZPR3FWWkUvdGoybytqbEo1OXJPdkxMS01Xb3B1?=
 =?utf-8?B?RERqM3BEaVNGNDR0NXlKNCt2TDVUekRKdTRLYXZ4RENjVitCTUpUS2JrSnZ1?=
 =?utf-8?B?a09HUVhBdXZXQnA0cnh5dStiU0VOZmR3ckVXTloyc1ArYm1BWEoxK3dabjRD?=
 =?utf-8?B?QXMwYnMxdHNBbzRVYVRJay9JZWF3MU9kY0ZmdTBjZkJWdFEyNlJUekdvdWFL?=
 =?utf-8?B?VUVRT1gyUkZjMGpvdDNsQmlJMzVCZlRjdmRPamhQV295Q1J2NXBnRWxsdlA4?=
 =?utf-8?B?ZzJ0TjFJUm5iUVp3RnVXQmtpU2ZyRCt4M0FSeVdyY2lPRklKN2ZZWjR1QnFp?=
 =?utf-8?B?MithTThaWFE3Z3YzMEVvTzV5MTUzWFEvNERnT1FCcE9yVmNCYTJpWEtwMVVn?=
 =?utf-8?B?OWdQWC9nbHNGMGVITFdCUFowNVcyZXRCYVZXNnh3Wm5MUGNBZHdJTTFpQjdm?=
 =?utf-8?B?QzVGSlpvQjQ3bm9ZNWVveCtjZll2S0d2QVJPK1BnbTV1WEJyYWFMZ3I4UStB?=
 =?utf-8?B?Rm94ck9zTGFhUkpoNlN1eEJZOGtOZkwvZEtRS2piRlNWdEMyRzkwcWtKVnBY?=
 =?utf-8?B?ekU0Y0FDa1I0QlV3OEVxaHcwOHg5L0h6RmN2Tk51NEtlMy9CQTNrZk9sekhP?=
 =?utf-8?B?d0JBYzJJay91alFhVU5qb3cwcCtFOGd2NmVHV2paQTNtUDZVS3Z1b0FYU212?=
 =?utf-8?B?M3ZFa1lHYXYycTlISXhtWitFT3N3S2Q2bE8wMzFLbVNKQXRTUUpmODJBeVZE?=
 =?utf-8?B?RFFwTmZnbWwraXFPMk1oWi9jb24yRzZrNGR4QmVSR3BIaTk1MGZHeTFaMXdL?=
 =?utf-8?B?bysyWVZBcE9OaWpnbnhTeHJJWHZpUUg1a0szcWhPRGFnSjgvOE9vVmoyVWtJ?=
 =?utf-8?B?OTVsYkJnVkprT3F6SlFRNEFvNFVlNTJjQzB0QitCYjJDRkNheWNGM21sMXNv?=
 =?utf-8?B?d2VidG1peDhWMEQ4R0tHeUIrT1RtKzJOWTZqYy9yTVRxdmp0N3BVeXpMd1RH?=
 =?utf-8?B?c25rR29TQmp0ODFMRDZqQkxCQ2UxU2k2c2xXZ0xwUFB6T3hxVnB1TEhrNXJs?=
 =?utf-8?B?bzVzRUtsUnorTmxLSmZDWWltWTI0YVdJQU1DemVwR2Z5L0FjZ28zRG5TT0Nm?=
 =?utf-8?B?V2IrRWRjQXUyZFU1aEd2bUVJdVB3QUNPSlRwOWdDTWtYd0hwbGd5RTNjVWZz?=
 =?utf-8?B?eWZrTXVmMzNMbGxSKzN3TWVQOWtjdUkyZWRvSGNTNHlLb1gza0tUUTd4RmlT?=
 =?utf-8?B?Ylc0WkVYMTFqZGlmRGFnMUtqS3V5OEg3QTg0SEZqQ09TbWxWc1d6SHV3dnNn?=
 =?utf-8?B?RnlLTS9SaFJjejBObVJKR05NSXZGTzFUQkVieWI0c0Z1NWJtajR1WS8xNE14?=
 =?utf-8?B?V3hBbXloNFl5bmhQSW9USVAwZmF0NDZ2cFFFNXpNamIwNnlieThqamxjQzZr?=
 =?utf-8?B?OVBGYWJaaUdRWGhMYTBFR1YvbWtKTE53QzZpNDkvSUxJWUw3ZGR3SGt5WE92?=
 =?utf-8?B?dnRJRTJLQ2JZZVRiQmdqNlBsMFpXSEp2OHNRclBzV3VmMk9nREQzbjJOZ01x?=
 =?utf-8?B?SXI2a3NiWkxGQTlNcUpZd3E0SWVPdkdYUEYwQWhNeExUQWM0QTg3NTJoeWdO?=
 =?utf-8?B?eVFaWnYxNW1RdGo2a3prSFI4VlplbC8yeFpiSytET2NTdWpSNnpuWEJsQUFT?=
 =?utf-8?B?eU5lVE0yK052RDI2Yjc4K3J1SEYrcSszMGVza0xsa21tbERLZ2ZPalFPejNk?=
 =?utf-8?B?ZzB6WkFLMExwd0J2WldvU29VODFHV0grK3E5QWVDdUZhV0VZQlJDRjZ2WHgx?=
 =?utf-8?B?N0JUSTdndVBxYkRGZFVpSVh1dTRONXRvV0ppcmZlSzgvTWo1b3ViMFlXb3da?=
 =?utf-8?B?cHFnN1hORXBZYng5eXJMeWtsVUtGZk9ha3ExeXZ2bmZXZUxyekVjWVVnZnJa?=
 =?utf-8?B?MWhyS1JVS3hoS3dTb3VPN24xUHdxRWdBYU1PS3ZhZEZGMURZaVRldUpMSy9O?=
 =?utf-8?Q?UQ10qxuGqKiEcg4eVplAAcfYK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914dac44-5c78-4460-25e4-08dbe19b7fdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 03:16:58.4207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LnwCJpUwJcwTHWL2Z+RZ4McQB6OPKq/DIYCVYB/ieT7oBUTKvC3vyDv7xm0Eg56xRigjOcpG9Au4j+Jj6JoXGAFI/QXSptyGGkD30271Yv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5076
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1hdHRoZXcgUm9zYXRvIDxt
anJvc2F0b0BsaW51eC5pYm0uY29tPg0KPlNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTAsIDIwMjMg
NzowMCBBTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTkvMjBdIGtjb25maWc6IEFjdGl2YXRl
IElPTU1VRkQgZm9yIHMzOTB4IG1hY2hpbmVzDQo+DQo+T24gMTEvOS8yMyA2OjQ1IEFNLCBaaGVu
emhvbmcgRHVhbiB3cm90ZToNCj4+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0
LmNvbT4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhh
dC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5A
aW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgaHcvczM5MHgvS2NvbmZpZyB8IDEgKw0KPj4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9zMzkweC9L
Y29uZmlnIGIvaHcvczM5MHgvS2NvbmZpZw0KPj4gaW5kZXggNGMwNjhkNzk2MC4uMjZhZDEwNDQ4
NSAxMDA2NDQNCj4+IC0tLSBhL2h3L3MzOTB4L0tjb25maWcNCj4+ICsrKyBiL2h3L3MzOTB4L0tj
b25maWcNCj4+IEBAIC02LDYgKzYsNyBAQCBjb25maWcgUzM5MF9DQ1dfVklSVElPDQo+PiAgICAg
IGltcGx5IFZGSU9fQ0NXDQo+PiAgICAgIGltcGx5IFdEVF9ESUFHMjg4DQo+PiAgICAgIGltcGx5
IFBDSUVfREVWSUNFUw0KPj4gKyAgICBpbXBseSBJT01NVUZEDQo+PiAgICAgIHNlbGVjdCBQQ0lf
RVhQUkVTUw0KPj4gICAgICBzZWxlY3QgUzM5MF9GTElDDQo+PiAgICAgIHNlbGVjdCBTMzkwX0ZM
SUNfS1ZNIGlmIEtWTQ0KPg0KPlJldmlld2VkLWJ5OiBNYXR0aGV3IFJvc2F0byA8bWpyb3NhdG9A
bGludXguaWJtLmNvbT4NCj4NCj5JIGFsc28gcmFuIHRlc3RzIGFnYWluc3QgdmZpby1wY2kgKG1s
eCwgaXNtLCBudm1lKSwgdmZpby1hcCBhbmQgdmZpby1jY3cgb24gczM5MHgNCj53aXRoIGFuIGlv
bW11ZmQtZW5hYmxlZCBob3N0IGtlcm5lbCArIHRoaXMgc2VyaWVzLiAgVGVzdGluZyBpbmNsdWRl
ZCBoYXZpbmcgcWVtdQ0KPm9wZW4gYm90aCBmZHMsIHBhc3NpbmcgaW4gb25lIGZkIGFuZCBsZXR0
aW5nIHFlbXUgb3BlbiB0aGUgb3RoZXIsIGFuZCBwYXNzaW5nIGluDQo+Ym90aCBmZHMuDQoNClRo
YW5rcyBNYXR0aGV3IQ0KDQpCUnMuDQpaaGVuemhvbmcNCg==

