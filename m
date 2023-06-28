Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A577740862
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 04:28:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEKtZ-0002iv-A2; Tue, 27 Jun 2023 22:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qEKtU-0002gt-6L
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 22:26:56 -0400
Received: from mga05.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qEKtR-0006bz-Gy
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 22:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687919213; x=1719455213;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PvHDTB11NcO9WHU+EMn5ENvv3qcTgGvrPi4ycuJrlHw=;
 b=YEqFrpI9R8J54Ojp/uTWtKC4TH7u9jz5adMjLwvHJ+Gs8Fc2JjX9Oe7W
 4llOX56/ymAg/fITcO7qLv17S8RwruKwjW57n8hBZQSU4bi+wkiYdGLGn
 WxpoaoWV6QGie8tFcFDfHnssg9ZJrNSYrP81KyGp8x1aWjtUyoRUePRsU
 I5LSDyx1jLHE6bKg5oB81J1o1RzweyBZJu0uweMLHWt/a6VsNXCXlDMd4
 xx1daZFjejqIX1FY2uES6obEla18LsYy/WEr9JgOYGBpyVbnEVKvkYSvk
 uzSuWQTONW8x78Acn2nhdJYkDfXGA4Lkl5Y00GaNbhTNLiWfSYKxLlqrd w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="448115235"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; d="scan'208";a="448115235"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2023 19:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="861325813"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; d="scan'208";a="861325813"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2023 19:26:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 19:26:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 19:26:50 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 27 Jun 2023 19:26:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kj3KsJgbsxW/WhtbO3oNrIjbB0xJz1k7ExNZoKL4ax/TQJVxQysB34UA5waw98jkG6wSloOeF5FPSfss6dxskVUGe3HbSoVwPlrvRGmUo8VYInAY81fHVCJKO3MPFFEDueFsyRasf1FXjQgTexHz7TSPemqSRNVaV7g2gYK3oU4de99mAA0h0cvbKH8YFJ/44HQhGyY89mjuQOvPmJdC6+qiAyilkhH0+tu+rhLvT16KmRZo/VUHPCTp3jDX78n0oe17FDt7XS2MdVWBbBQm11pQosWzrneuLenwOHOtJD+Xpu9OlxFTZIeOqpuWwgQE+9oPh5+Zb4YpIcJQ9s00Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvHDTB11NcO9WHU+EMn5ENvv3qcTgGvrPi4ycuJrlHw=;
 b=JrS6FFb5/sIQnzSA2z5pk9ATdd83A6X53YPLljNCnpSxz5k/C6QOIhHlLSyvkcCtic9LutoV+OqPbN2AF2PoILLKbNEAj22SuArfpdPIXuBJMkD2MwpAVcHefVzHZ5Hlr3QuG8W6KgXap9D205uxMU4AraX5p2ohV7d7gIlaaAYLfJg05pvSxnsHGIScajsWzqmWEoNFS4qGQtnBFVePJKUeEt7AM8nOP+K+eeTg9zGesdfC2hiW0BwJhV4u8zmxbeRu2op1xx/tJu0MXwOtDREK9d10ybdwabOCH0Fvx3l2dcmztT67ohiXDq0ExAdjP7ESLUoAfaWdQlncTIcJpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB5207.namprd11.prod.outlook.com (2603:10b6:510:32::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 02:26:47 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%5]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 02:26:47 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>, Avihai Horon
 <avihaih@nvidia.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3 3/3] vfio/migration: vfio/migration: Refactor and fix
 print of "Migration disabled"
Thread-Topic: [PATCH v3 3/3] vfio/migration: vfio/migration: Refactor and fix
 print of "Migration disabled"
Thread-Index: AQHZpBiDMAK8vCWoSUWN+eGvuOKtiq+c2rIAgAAMTICAARVJUIAAh7aAgAD5vTA=
Date: Wed, 28 Jun 2023 02:26:46 +0000
Message-ID: <SJ0PR11MB6744E50618281FB98BE2FF2C9224A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230621080204.420723-1-zhenzhong.duan@intel.com>
 <20230621080204.420723-4-zhenzhong.duan@intel.com>
 <c8583433-9b9f-4380-8076-8ca623b66770@nvidia.com>
 <3afe5106-414e-5a3d-4a15-3992f80fac5b@oracle.com>
 <SJ0PR11MB6744F88600646B8FD4E7F5019227A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <bbdf6724-4c5c-cb93-9da3-c28d3b75620a@oracle.com>
In-Reply-To: <bbdf6724-4c5c-cb93-9da3-c28d3b75620a@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB5207:EE_
x-ms-office365-filtering-correlation-id: 118af701-7793-4ed5-3d46-08db777f1efb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lWQhJKiRtPl7vIlkV5HadWpCrcm61lLdqJNoC9Tn36NPHMIyAze21rfQYKS9mOnjRmwp9K3i5cpJkkDYMlqJ7mJ6zo3kLvwvMTH5ZknPIBxwJwG/HxuiIDccX49nV88TzLMZvY+yUNwjRo5p0Rl6Cgr+UCbPfdQ/v3qSNIwWXwDLpzcVJfXlG+xUPvSGJ/HYUFsVOeCGdcDx/TVuA0pVLyM0iq3oBlBPRZObqzgyWQ7nCz8RFzk6f348dOy4TMFvJicbAUep1DUg/gEXwGCCGaP1J4HPfA1y3e+/7ITc0fiunmIKBanL9bT5XOuWQn+0j4nsMQkSpTk52Pq8vJWmmK7pvGo3qMFAzZnfvrMxYEsk9FYgXsQJ6OrRHahv8V0pvanCqIEVipemy4f/qviWKrCDpPLKCi+qMg6/pH7K5nFSfpF0OgjyYSljfwM1w8eEWRyJ5L0Ck4UKWgCPhMnXoPkXISREJ64RF7MdJlNkG0OgUIPtaSkuga8mPLFM7UxByS3ZK8QWI809nS2c3BOFtLEt3sR61jsTCt2EPFRZRhpIoCKGJtTkSpLRYls+ExJXDMvuzTtp/jGJ7vRdbbZVLGUVgHlz4XM4w76BONkqys828jTOo6eAxKe7lpIhtjcX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(52536014)(478600001)(110136005)(54906003)(2906002)(7696005)(83380400001)(9686003)(186003)(6506007)(71200400001)(86362001)(41300700001)(33656002)(38100700002)(5660300002)(4326008)(122000001)(66946007)(316002)(66556008)(55016003)(82960400001)(76116006)(8936002)(66476007)(64756008)(38070700005)(66446008)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDYwR0w1Q3BPN0tYdDB6akI4RmRaRldMVVNrOUFxZ2FFbDA2WTVNWG9FQXYv?=
 =?utf-8?B?Uk4zY2l2SVhDd3NRS3NxZHAxRjJXMkk5bUgrWldhQXFvTXV4L21UeXZrdm8r?=
 =?utf-8?B?TkRlUEpKS3pYLzZqU3JodWlvZHFKTWVoZ1d4a09RRXdXSkZKakRWampnaVBJ?=
 =?utf-8?B?bkx1TkdFNzBUVEtRYWlLSGQ1b0ZDMzZ6MWRMWE13NnF3RktvY1BpRDZIQzNL?=
 =?utf-8?B?TlAvK1VKM0tES0tmalo2aEhXb2FZakgzWEFubFZUbkhaeWRBUU1ORVZGOThi?=
 =?utf-8?B?ZW9pTnB6ckoreTVyVmlPbnVMOUlibWlIRnB1TWdURFlZcnVRb3E2Z3N1WVpu?=
 =?utf-8?B?SDI3MXo0K3VrcDVsS2dnUjZWb05FVVZxdGUyR1kxQkt5dHNSaWlNMWQyL1lP?=
 =?utf-8?B?SEJKU3dhSE5tYk1tWk04NjBTTUNNa1ozWUdTK3p1cEIySlZoUEtMczZRMHda?=
 =?utf-8?B?RjBMaVRqeDcvR0dZVHdYemx3eGhHMWs0U1pJa1VRdDE3bFpVZ1VsTjd1a3Zr?=
 =?utf-8?B?N09hakRzOXFmdGNLek1XZGVWZWdOQXpYVFVGbWFtVjJRMmtuTGYycEk0YkFm?=
 =?utf-8?B?SWtHMDNWZllBTStGUCtHalFOb3o1WUorT1NZb0o4cUVOVWVZOE9TNnhhZ21s?=
 =?utf-8?B?dkRwUGVubWpoMkR3V3BZL2lTVVU4RDNwVFUxMDBrdWpORzlHbnFPb1Jtd3VN?=
 =?utf-8?B?bUJaRFFMRlhKZjhwV2FlcW1RM3NKK2lkK0dDQkNnZ29DTnVOWlFJU2NlYXhD?=
 =?utf-8?B?dDYxbUZwM2NpYjdpWXg0SmN1eUhVV0ZsQVRSWGw2RHlPYmZmTUxCSi9lelNy?=
 =?utf-8?B?eGFBb21YZWdWSGxva3NqNG54TjFlcEViNitPdWlyMXR3L2lGbmNGc0dxcm0v?=
 =?utf-8?B?UjhFVW9VNURMUUN2WklIYjdsVkplc3RTck1ET0JpbGFrUm1BblVJL1lyRWl1?=
 =?utf-8?B?cGlGTjY3U0VuR2t4UVJxeVNIWnJrdXpHYWZTenpoZHg0ZmZCd0czYzV5QWp2?=
 =?utf-8?B?OStiNVdtbzZjYjFkeFAwc2wzNnFwRS8yU1Z5K0dKOVl3SThOZXlyZHY4R3Q4?=
 =?utf-8?B?SUxIcmhydUo1eTc1S05tUXNZL1NydjZLQTlRUW9KVm1hVndlS25ZSHYrTG5D?=
 =?utf-8?B?MFRsQ1BEMEQyUC9OaDhvM3RpQ3ZsNHRLRnFkdjhzTXByOW9oWGtRZUx2TENK?=
 =?utf-8?B?SEtRMEVLK01ad25qVlVVRmtPYnVaNUFhK2VrUkFScktWcC9ycDdzZ1o1OUp6?=
 =?utf-8?B?SitCMWtYTGxNK0trc08zeExoQlN4U3BnVVJIcjFiS2c2NkRNZ1NVMUhrUnBw?=
 =?utf-8?B?aXNKaFpnM1V2UmdjMHlBNUtaYUJqaGpQUkUvMFhzRjdVem14VTdtbjBoam5B?=
 =?utf-8?B?bjNjQ3laMzgzcGFENTJLMzFLZ092cnJBamZzeGcwdWVaSzBtR0FzRkVueDM5?=
 =?utf-8?B?Ym1XZjVDQmVYUGlQOFBPQTZQaTR4WXZMRGpndkNNNjdITkVYNmVlaEdUQm9C?=
 =?utf-8?B?cmQxTFc0OTM5TWIxOHlDL3dhMFY3d2sxOHBPM2Fpajd1eVVlM20rVmlYbGFp?=
 =?utf-8?B?YURMbC9DRmZwQzZuUU5HU3hEMHlSUzBwUGdlcjVUWktxN2RnTjBTM3JmckNo?=
 =?utf-8?B?eWIydVhHcUx6c1lxZWlKODBkc3lWN2Z0QTNlL2lXcDZRY0hYa244My9VZ3Fw?=
 =?utf-8?B?eG1mK01IV0xLZWVzTXNwSXFlRlJkbmVUODRFR1c1d3ZzZFBoV1JWTDJCdlVN?=
 =?utf-8?B?S0doTVBZbkRGTGhOTFo5Z3hzYWNRNFJobUZLNURONW9SRStvUElncno2SitW?=
 =?utf-8?B?amxnNythcG5qMVdwcmtPS0FJZ2tscUdCc1V0KzgyaXJ1VUcvcUMycWJzbGhm?=
 =?utf-8?B?NWVzMGdlZC9XaVZBVFpDSGU1MFl0ckFVTGV2L1hBRXhRbWQ0VW9CMkx6M2lJ?=
 =?utf-8?B?TEIxbFNpM2xSVjdrZ3pxZk84TlJxLzJzTWpTZWUyemVTUDVTQWFmbzVNYkl4?=
 =?utf-8?B?YkwwMmNXQUFJVy9YR1NxeWNKaG1XODBQUkJwclFINUVwRGNjenVabnNweXY5?=
 =?utf-8?B?QWFpTGRkS0dXS0NodDd1UkNILy9DQmVRMlp6Q2NKZ3Y0NGdqVkFjL1NjYjZB?=
 =?utf-8?Q?X11Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118af701-7793-4ed5-3d46-08db777f1efb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 02:26:46.7128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rzAIFaBGjPn4iYpKZmSYUKHD7CHnolPUUPKv1E/FKro4Xq1PbI/rpIXGiR6uhgv5IxcEKSubsWmd543H3THC3HnmjwgARRFntvedpxdiIU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5207
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.43;
 envelope-from=zhenzhong.duan@intel.com; helo=mga05.intel.com
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
bWFydGluc0BvcmFjbGUuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIEp1bmUgMjcsIDIwMjMgNjo1NyBQ
TQ0KPlRvOiBEdWFuLCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT47IEF2aWhh
aSBIb3Jvbg0KPjxhdmloYWloQG52aWRpYS5jb20+DQo+Q2M6IGFsZXgud2lsbGlhbXNvbkByZWRo
YXQuY29tOyBjbGdAcmVkaGF0LmNvbTsgUGVuZywgQ2hhbyBQDQo+PGNoYW8ucC5wZW5nQGludGVs
LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMy8z
XSB2ZmlvL21pZ3JhdGlvbjogdmZpby9taWdyYXRpb246IFJlZmFjdG9yIGFuZCBmaXgNCj5wcmlu
dCBvZiAiTWlncmF0aW9uIGRpc2FibGVkIg0KPg0KPk9uIDI3LzA2LzIwMjMgMDM6NTUsIER1YW4s
IFpoZW56aG9uZyB3cm90ZToNCj4+PiBJIGd1ZXNzIGl0IG1ha2VzIHNlbnNlIC0tIHRoZSB0aGlu
ZyB0aGF0IHdhcyB0aWVpbmcgaGltIHdhcyB0aGUNCj4+PiBnbG9iYWwgbWlncmF0aW9uIGJsb2Nr
ZXIsIHdoaWNoIGlzIG5vdyBjb25zb2xpZGF0ZWQgaW50byB0aGUgbWFpbg0KPm1pZ3JhdGlvbiBi
bG9ja2VyLg0KPj4+DQo+Pj4gTXkgdklPTU1VIHNlcmllcyB3aWxsIHJlbGF4IHRoaXMgY29uZGl0
aW9uIHllcyAoc3RpbGwgc2FtZSBwZXItZGV2aWNlIHNjb3BlKS4NCj4+PiBBbmQgSSB3aWxsIG5l
ZWQgdG8gY2hlY2sgdGhlIG1heGltdW0gSU9WQSBpbiB0aGUgdklPTU1VLiBCdXQgaXQncyBuZXcN
Cj4+PiBjb2RlIEkgY2FuIGFkanVzdCBhbmQgWmhlbnpob25nIHNob3VsZG4ndCB3b3JyeSBhYm91
dCB0aGUgdklPTU1VDQo+Pj4gZnV0dXJlIHN0dWZmDQo+PiBBIGJpdCBjb25mdXNlZCwgeW91IGFn
cmVlZCB0byBtb3ZlIHZmaW9fYmxvY2tfZ2lvbW11X21pZ3JhdGlvbiBpbnRvDQo+PiBtaWdyYXRp
b24uYw0KPj4NCj4+PiBidXQgSSBkb24ndCBleHBlY3QgdG8gaW5mbHVlbmNlIGxvY2F0aW9uLCBz
YXkgaWYgaXQgZ2V0cyBtb3ZlZCBpbnRvDQo+Pj4gbWlncmF0aW9uLmMNCj4+IGFuZCBmaW5hbCBk
ZWNpc2lvbiBpcyBubyBtb3ZlIGZvciBpbmZsdWVuY2luZyBsb2NhdGlvbiByZWFzb24/IERvIEkN
Cj5taXN1bmRlcnN0YW5kPw0KPg0KPlNvcnJ5IGZvciB0aGUgY29uZnVzaW9uLg0KPg0KPlRoZSB0
aGluZyBpcyB0aGF0IEkgd2lsbCBuZWVkICdzaW1pbGFyIGNvZGUnIHRvIHRlc3QgaWYgYSB2SU9N
TVUgaXMgZW5hYmxlZCBvciBub3QuDQo+VGhlIHJlYXNvbiBiZWluZyB0aGF0IGRpcnR5IHRyYWNr
aW5nIHdpbGwgbmVlZCB0aGlzIHRvIHVuZGVyc3RhbmQgd2hhdCB0byB0cmFjaw0KPm1lYW5pbmcg
dG8gZGVjaWRlIHdoZXRoZXIgd2UgdHJhY2sgdGhlIHdob2xlIGFkZHJlc3Mgc3BhY2Ugb3IganVz
dCB0aGUNCj5saW5lYXIgbWFwWzBdLiBBbmQgYWxsIHRoYXQgY29kZSBpcyBpbiBjb21tb24sIG5v
dCBtaWdyYXRpb24uYyBhbmQgd2hlcmUgSQ0KPnVzZSBpdCB3aWxsIGhhdmUgdG8gbG9vayBhdCBh
bGwgYWRkcmVzcyBzcGFjZXMgKGJlY2F1c2UgZGlydHkgdHJhY2tpbmcgaXMgc3RhcnRlZA0KPmZv
ciBhbGwgZGV2aWNlcywgc28gdGhlcmUncyBubyB2YmFzZWRldiB0byBsb29rIGF0KS4NCj4NCj5F
dmVudHVhbGx5IGFmdGVyIHRoZSB2SU9NTVUgc3R1ZmYsIHRoZSBtaWdyYXRpb24gYmxvY2tlciBj
b25kaXRpb24gd2lsbCBsb29rDQo+bW9yZSBvciBsZXNzIGxpa2UgdGhpczoNCj4NCj4JcmV0dXJu
ICghdmZpb192aW9tbXVfcHJlc2V0KHZiYXNlZGV2KSB8fA0KPgkJKHZmaW9fdmlvbW11X3ByZXNl
dCh2YmFzZWRldikgJiYNCj4JCSAhdmZpb192aW9tbXVfZ2V0X21heF9pb3ZhKCZtYXgpKSkNCj4N
Cj5XaGVyZWJ5IHZmaW9fdmlvbW11X3ByZXNldCh2YmFzZWRldikgaXMgd2hhdCB5b3UgY3VycmVu
dGx5IGNhbGwNCj52ZmlvX2Jsb2NrX2dpb21tdV9taWdyYXRpb24odmJhc2VkZXYpIGluIGN1cnJl
bnQgcGF0Y2guIFNvIHBlcmhhcHMgSSB3b3VsZA0KPnNheSB0byBsZWF2ZSBpdCBpbiBjb21tb24u
YyBhbmQgcmVuYW1lIGl0IHRvIHZmaW9fdmlvbW11X3ByZXNldCh2YmFzZWRldikNCj53aXRoIGEg
Y29tbWVudCBvbiB0b3AgZm9yIC8qIEJsb2NrIG1pZ3JhdGlvbiB3aXRoIGEgdklPTU1VICovDQo+
DQo+VGhlbiB3aGVuIHRoZSB0aW1lIGNvbWVzIEkgY2FuIGludHJvZHVjZSBpbiBteSB2SU9NTVUg
c2VyaWVzIGENCj52ZmlvX3Zpb21tdV9wb3NzaWJsZSgpIFtvciBzb21lIG90aGVyIG5hbWVdIHdo
ZW4gc3RhcnRpbmcgZGlydHkgdHJhY2tpbmcNCj53aGljaCBsb29rcyBhbGwgVkZJT0FkZHJlc3NT
cGFjZXMgYW5kIHJldXNlcyB5b3VyDQo+dmZpb192aW9tbXVfcHJlc2V0KHZiYXNlZGV2KS4gVGhp
cyBzaG91bGQgY292ZXIgY3VycmVudCBhbmQgZnV0dXJlIG5lZWRzLA0KPndpdGhvdXQgZ29pbmcg
dG8gZ3JlYXQgZXh0ZW50cyBiZXlvbmQgdGhlIHB1cnBvc2Ugb2YgdGhpcyBwYXRjaD8NCg0KVGhh
bmtzIGZvciBkZXRhaWxlZCBleHBsYW5hdGlvbiwgY2xlYXIsIEknbGwgdXBkYXRlIGJhc2VkIG9u
IGFib3ZlIHN1Z2dlc3Rpb25zLg0KDQpaaGVuemhvbmcNCg==

