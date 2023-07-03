Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4733A74557B
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 08:27:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGD1M-0007jE-PE; Mon, 03 Jul 2023 02:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGD12-0007ab-MK
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 02:26:30 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGD0x-0001JS-J7
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 02:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688365583; x=1719901583;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zQThVPEq5aWQ2AkBNpigNJ7cAwPWnQKJuM5Cttsqs2I=;
 b=Lt+XdFG3oqgcc0aB5eNdrPzBTAyNPm7hPtDCcwEpgIWbboojsIY4RsP9
 gp9fqPsQLbE1ouvbMM0/627EcKXCEw6+qV3NJWezosguYIRAfmqEmuqWR
 0RU4s3fXF8lxXdA+v2iqXRi7Sf6f+DCpI7iw9lBkVLwYpMp/8vpTQF+dZ
 6KW34VAtHmMHK335GMyEBUwbjRyHMUnm5IGuR6KgXma0sHCy+XI3BkJWc
 d9+wTNvj2uqpQO7qwYtoXgCPU50J+dKFD7AKA74yl64B3qu4U5rcYBM9b
 OgpEZQlvvV53cmJvLEi+3P+Yr7RzFGO0uCT901pmdv5CmYY7tL5ydU9LS A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="426485823"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; d="scan'208";a="426485823"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2023 23:26:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="1048951975"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; d="scan'208";a="1048951975"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga005.fm.intel.com with ESMTP; 02 Jul 2023 23:26:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 2 Jul 2023 23:26:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 2 Jul 2023 23:26:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 2 Jul 2023 23:26:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmQyWyZhKuaYk4cds0xd4IaPqQS/J+fspE9xdUQIGaH05z2sV4C78DBHnKpkXZbjlUfGFCYv/qgg/POyNwMz4KSR8GknnnOHZ2g4iSWfLEbVnaFCbtbF9LyiUu0Sgu+WkyoaEiiR4QbAYSDMPPfyEz78Gd2d1O2mU0Cgv2BEm2iqkCPunzLWS7SsxI/c/i/Dr/TS0gYkpU6WQSc9mrvliV6tNru80lTTBzusvEIFuDkn0dn7L/S4DKNeVP/TYvUKbGDXnAxuwLUuSJmiQBCU5RqKTsvyMn3QbauaWqbMgj8VB4eq07uk69WXqJOdENFBNCIMAgeiLsQFlCCPdb4R8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQThVPEq5aWQ2AkBNpigNJ7cAwPWnQKJuM5Cttsqs2I=;
 b=FFRw0ubIFqmzhJJCKAPz2PaRomxHAZoWpHMg52d6Iyu9aBn47JGTn0g1SqmfIlNYDnf3DwQtnqiDLqj8I1cF5qVfeMc/M7GJWlxKKiZb8KJCQ9U11XQqnP5dHB2LQkNgti9dRDQ7OvOvVsgLKFtjd8Ad6Iz5MRCWOYSIROPBCn6R1YLY+Vc3fuC8oefY6Mc8elCv9QemkE+g6uCcXj4v18psSOnr6swVIq9MNB+ncjYcNRLR9LNTsnh9g/EQlkVNVdon7UKEp/AsXLi9ojv32tcij6/OXFSRLxYHybQUHOeuE5lLdnJYD7EK/PwFQSwo3nHrJUgdueaeFTEnjrUXzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB8161.namprd11.prod.outlook.com (2603:10b6:8:164::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Mon, 3 Jul
 2023 06:26:17 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0%6]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 06:26:17 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, 
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 4/7] vfio/migration: Return bool type for some vfio
 migration related functions
Thread-Topic: [PATCH v5 4/7] vfio/migration: Return bool type for some vfio
 migration related functions
Thread-Index: AQHZqyd7tFaudIBN70qP/4DUYbCixK+jKIEAgARrKJA=
Date: Mon, 3 Jul 2023 06:26:17 +0000
Message-ID: <SJ0PR11MB6744B4F6ED2F3B7B87F7AF3F9229A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230630073637.124234-1-zhenzhong.duan@intel.com>
 <20230630073637.124234-3-zhenzhong.duan@intel.com>
 <908d5776-8539-7f5c-b7c6-ab64d4a85bd9@oracle.com>
In-Reply-To: <908d5776-8539-7f5c-b7c6-ab64d4a85bd9@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB8161:EE_
x-ms-office365-filtering-correlation-id: 9553e29c-7087-430b-8ab0-08db7b8e68ba
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P3yHFz/Bebu1CuAVyYb/pkoij5LaIVS8YQArZuo+6MBHMocw6wdvyY/mnRnNH8R1urlNtAVxKkzJD//4CUHFJ3awsag5s0OTuoTKcf5vAoAp2WRQ98OFBarXQXTmKE3Ck23ONkAFN+RZFa53MVUmqQ0Pt/NyGEVLLAdW5HG7kLHwTO8So/mkjqYMJtcd+pvbNd29itU+iqzg7k/Uw/HOBFJTKRFuIBs4KLtQk70iLUFVQlZdb3zAPmvLeCcNPwwZ9W5SF+S0xO53/ltti2xg6VG2OYn5gfDv3g+672c27fxOWi6h1BPdaK5I703XsRhMa84ADN+IP6RmlToOF4iMJrvhGXnODCBrQHdKoNh77LqMQFw377263HpwbOtXP6cnEweNbnTKt5mYbhvL8CUpQM2A1goptAgSW0bbt/UMqpI7vOu+neMH3Cju+OAk4BBD/pZfzthUEV4GHm4Nq5nE98OjtB2m0hM0HqvfdPNOJYT9DKg+gNyF7yDvDGPZMVXzam+2sQV1UHVbhQDndIsurDDG0wVScbBmGM9dZGmhFO0MK3Zhv9fTqirYYMoi/C9xQz7wdrR0RGqNCvzT4dVSE39kdS+D0eBFfyVk6zOyVwA8PNUucMXPprqWzKt5mM40
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199021)(38070700005)(2906002)(41300700001)(5660300002)(52536014)(8936002)(8676002)(33656002)(55016003)(86362001)(186003)(82960400001)(478600001)(107886003)(26005)(6506007)(9686003)(71200400001)(7696005)(76116006)(122000001)(316002)(4326008)(66476007)(64756008)(66446008)(66946007)(66556008)(38100700002)(54906003)(110136005)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUZjaFo4MmxFekZYZjNDWHp4ZWJDRk1mbzFZbWxQTWlyRVVOREZ1WWhJSEtX?=
 =?utf-8?B?RkVyUjBWN256dGJZQllFWDJSRExJWEdnNzdGRmV5cnZFd0pDL1E3dG4vdTdI?=
 =?utf-8?B?T1BnSDFwUDIzeW12SkN5ZnRDcWc2dlhFYWcvemlGZ3lkUmRHRW5PRVJ3b0xx?=
 =?utf-8?B?cVpVRW0vZ3hnTHJIc3g4RGRoVUgrUVhaQ1FsVU1SUHdac1pzT0ZNU1V6aklo?=
 =?utf-8?B?cVM5MkZqaUxXZHkwUWVXNWlCWG5LdzArL21lYzMzczNaUGRoMGVkNS92RTdG?=
 =?utf-8?B?MEdqcWxYL0VjMFBWWXVYMXRGejNsUFEwY0tSZktIaWMwemdSMDN3a1F3cEtV?=
 =?utf-8?B?TzFqU2pkWktDYXVlK2taYll5SHhBTTBjU1hTRHluSldkelpHYm9aWmZYOFBI?=
 =?utf-8?B?WlhaSi9ja3FQVEE2OEVPb25jeHhIRHBFRHg3SndSZzZOQmtRbmNtbzZXQzY3?=
 =?utf-8?B?Mi9OcisvTEF2M3F6T2hIRy9aZTBrQnVmOEVLWFgzd01tTVplTFFrU0pQNGpC?=
 =?utf-8?B?ckpkalQyLzNDT0JOakU5UTlmcEx1K2FvZnV2Qjl4SThiUWVSVzJTckJVZm80?=
 =?utf-8?B?K2R5cTF2bCtJcWxnQ0xoVjZCZ3dTbDFuRFRubjMxWldPbXg3ZlNDcTRIN0Mx?=
 =?utf-8?B?Qlh4bjZaSEU5LzJxT3dCcytQQzhEa2E4MUpPWTFRV0VIR0ttcXFPbWRIdTFP?=
 =?utf-8?B?My9WVmdoQnRhWlNGVU9RS2xCZHp3OXNMY1EzdE9yTnZIWjhMeEl6cUxoRnBm?=
 =?utf-8?B?c3VSMXh0UGtDSUlweDR3RUJOTTB1SUliaTlsRjNSTlU3azhVQTF6OFZna28w?=
 =?utf-8?B?YnlQNkZjTEtZR1RJOW5keitRT1A5MXI5VWNXbHNqQXNUS0t6b3RyblBpY2sv?=
 =?utf-8?B?ZlZkcGlUYm44OU1qR2Nkak1tNnRPTlh5Ym91TzlhUlUzUHhJNVRQVE83L3Rq?=
 =?utf-8?B?Vy93M3hSenRtTnhLR3pkaXRTT0NzMmdxeDZpRHFEQmxkTTN4QnEvU1lYNkwy?=
 =?utf-8?B?NjZyeitlNFBkZk1xNmxLczRvYmI4N0hpVE9pY0Q4d0JpWm9rb1VjMW1xNjRm?=
 =?utf-8?B?WmZCSXhnc2IvTkl3MUM2eFZYamtYQytQVXRRcVp4NTlDeHhlZDJkNGRZNzhv?=
 =?utf-8?B?OUd4Z0N2WFlvS2xaUTNnVUFHQWt0czdHVE9GaFY5SjRDd3B5MWJRTjhReW1U?=
 =?utf-8?B?VkRsZnJ3NUNuNEdLK3VrYjR3enFlcGpPaTc5YkJ2c05meWpRVXhrWExjV2tQ?=
 =?utf-8?B?Ti9PVEltbG1UbVBWR2N1dDJjY2pMTkJJbUl3R0RqbXFOZS9mUnQwNmc1UGVX?=
 =?utf-8?B?dGIvbmVEeG9LcmJ0Vkc0WHN3TUFiSnV4NXV5eUEwRURIbEU4cTVGTW9INlZu?=
 =?utf-8?B?bVd2K1JwNDZUVGZoK05kemdzVENyNEQvdXhYbm1sb1krOEE3a1BzeURMcHBP?=
 =?utf-8?B?YXNPOGhzY0NoY2NYei9JZTF5V1RyZHhVNjNYTzJsczlTSW8wQXYxUXQ1Q1hR?=
 =?utf-8?B?bE1ZL3dicXNhaHlZanBUcFRFMHp2ZGYwSHRpUnpBOEZ1dzhTVXU0TmxrMXNa?=
 =?utf-8?B?eXI4ZHBMTnNQWTV4MUpadW5TNzF4ZU9YKzZuOFZRdytidGo5bjVkejVTQ3dh?=
 =?utf-8?B?M29qaC9sam1yUlF2OFQwNmRqNzhiYlN2VlZKQ2FiUFpsMmV0UXg2M3NraUVC?=
 =?utf-8?B?RUhCRERyMWl2RExCSUZ2RjFhQXlMNVJZN1RjU2Z0Q05uYkx2K0dMZUlVb09y?=
 =?utf-8?B?dzd0a2M1NFlId3V2ODZwMDM4RFo0MVluNjFiTkdWdzcxSVVsTjlQYkJ6SktZ?=
 =?utf-8?B?OTlCVFRNYlpMZWc3VjExazFwSGtmNmZnZFIwZUoxUDNrY3Z1S3puMytEa21H?=
 =?utf-8?B?VUg2MVBWTEliTWxRNm02MElxZ3VpZlZvTUdlbzh4U2lkY291clNtL251eWlD?=
 =?utf-8?B?Nkk5aWd0Zmo0MXNkdnd2RGZ0Z1pWdmdNaElyWHRSVVBSUURrcGI0RzkzMTI5?=
 =?utf-8?B?eHZGV3cvTENTdlR4aytQNXRvRmg3WG1YUlBLWE5IK2xaQWtRMEVpTzZaa3Iy?=
 =?utf-8?B?NG9iaVkrYnJkMzZQaXZkeWtSK04zSzliSEsreFp1Y2w1elRXZmFBY3JZMnZT?=
 =?utf-8?Q?AjaEcdDsX6ZjsImIE4jzlmsEv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9553e29c-7087-430b-8ab0-08db7b8e68ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 06:26:17.5555 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v13xY1Cao5ZtnEmkG5voeZT1uFk+bzPvOmJdLSkWJI8Nkx0VfFAc4B2i7EFWaKGSVtSIzwJdROXuRqHXZhZhjBFsvEN8A1/o8Jk4aXtm44M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8161
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mga06.intel.com
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSm9hbyBNYXJ0aW5zIDxqb2FvLm0u
bWFydGluc0BvcmFjbGUuY29tPg0KPlNlbnQ6IEZyaWRheSwgSnVuZSAzMCwgMjAyMyA2OjQxIFBN
DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NSA0LzddIHZmaW8vbWlncmF0aW9uOiBSZXR1cm4gYm9v
bCB0eXBlIGZvciBzb21lIHZmaW8NCj5taWdyYXRpb24gcmVsYXRlZCBmdW5jdGlvbnMNCj4NCj5P
biAzMC8wNi8yMDIzIDA4OjM2LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEluY2x1ZGU6DQo+
PiB2ZmlvX2Jsb2NrX211bHRpcGxlX2RldmljZXNfbWlncmF0aW9uKCksDQo+PiB2ZmlvX2Jsb2Nr
X2dpb21tdV9taWdyYXRpb24oKSwNCj4+IHZmaW9fYmxvY2tfbWlncmF0aW9uKCksDQo+PiB2Zmlv
X21pZ3JhdGlvbl9yZWFsaXplKCkuDQo+Pg0KPg0KPk1heWJlIHNvbWUgYnJpZWYgY29tbWl0IG1l
c3NhZ2Ugd291bGQgYmUgdXNlZnVsIGFzIHRvIHdoeSB3ZSBhcmUNCj5yZW5hbWluZyBpdA0KPigi
TWlncmF0aW9uIGRpc2FibGVkIiBubyBsb25nZXIgYXBwbGllcyBhcyB0aGF0IGlzIGJlaW5nIHJl
bW92ZWQpOg0KPg0KPk1ha2UgdmZpb19taWdyYXRpb25fcmVhbGl6ZSgpIGFkaGVyZSB0byB0aGUg
Y29udmVudGlvbiBvZiBvdGhlciByZWFsaXplKCkNCj5jYWxsYmFja3MgYnkgcmV0dXJuaW5nIGJv
b2wgaW5zdGVhZCBvZiBpbnQuIEluIGRvaW5nIHNvLCBjaGFuZ2UgYWxzbyB0aGUgdGhlDQo+ZnVu
Y3Rpb25zIHVzZWQgaW4gdmZpb19taWdyYXRpb25fcmVhbGl6ZSgpIHJldHVybiBwYXRoIHRvIGhh
dmUgYm9vbCB0b28uDQo+DQo+QnV0IHNlZSBhIHJlbWFyayBiZWxvdyAtLSBJIHRoaW5rIGlmIHlv
dSBtb3ZlIHRoZSByZW5hbWUgcGF0Y2ggdG8gYmUgdGhlIGxhc3QNCj5vbmUsIHlvdSB3aWxsIGhh
dmUgbGVzcyB0byByZW5hbWUgKD8pIFVubGVzcyB3ZSByZWFsbHkgd2FudCB0byByZW5hbWUNCj5l
dmVyeXRoaW5nDQo+dGhhdCB2ZmlvX21pZ3JhdGlvbl9yZWFsaXplKCkgZW5kcyB1cCBjYWxsaW5n
IHRvIHJldHVybiBib29sLiBJbiB3aGljaCBjYXNlIG15DQo+Y29tbWVudCB0aGVuIG5vIGxvbmdl
ciBhcHBsaWVzLiBJIGdlbmVyYWxseSBmYXZvdXIgbm90IGxvb3NpbmcgZXJyb3INCj5pbmZvcm1h
dGlvbg0KPnVudGlsIGxhc3QgbWludXRlLCBidXQgT1RPSCBFcnJvciBpcyBwcm92aWRlZCBzbyBl
cnJvcnMgd2lsbCBiZSBwcm9wYWdhdGVkIGluDQo+c29tZSB3YXkuDQpNYWtlIHNlbnNlLCBJJ2xs
IG9ubHkgcmVuYW1lIHZmaW9fbWlncmF0aW9uX3JlYWxpemUoKSBhbmQgZm9yIG90aGVyDQppbnRl
cm5hbCBmdW5jdGlvbnMsIGtlZXAgdGhlaXIgZXJyb3IgaW5mbyBpbiByZXR1cm4gdmFsdWUgYXMg
eW91IHN1Z2dlc3RlZC4NClRoaXMgd2F5IHdlIHN0aWxsIG1lZXQgQ2VkcmljJ3MgZXhwZWN0YXRp
b24gb2YgdmZpb19taWdyYXRpb25fcmVhbGl6ZSgpDQpmb2xsb3dpbmcgdGhlIHFkZXZfcmVhbGl6
ZSgpIHByb3RvdHlwZS4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K

