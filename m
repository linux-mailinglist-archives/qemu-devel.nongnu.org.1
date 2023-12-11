Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABA280C126
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 07:09:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCZSz-0007qM-TS; Mon, 11 Dec 2023 01:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCZSx-0007q5-SL
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:08:32 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCZSp-00084m-1S
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702274903; x=1733810903;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=J6MOTTZA2+cZCd/ERCzjY0yhehuRpTmFWMCF+lS2qRs=;
 b=QtZRGt7K0KDljeM0VizYexOHyl6oLpktNaYNENh3aPb7PbVf39wNF/FO
 eAdJtiU4AU4x6Da4NKpGUE+qRr1gpI/GaV2IX52lsZYdQjK6bBhzxgIv3
 gk3ndP7RRY/uhwJJc/nS7MSPOOsKPcFx2kc7QFNFaEGvKrS1m6mz2/22a
 +ZF0QTamrWe+vXXjYDjLCKNJswkAAIL3tVEMMgXCW7Y9es61d3AHB/dip
 G1f5QkNhUSN3Ul/2t91xpqUflFbUP94BcQK3lGxRNV1K0gPuM2g26jzJu
 9CgqgMZCHdhe5X1t76548GlU0kOqKj0D16QvVKyBwMAU0wpCBx9To1ueD w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="398453328"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; d="scan'208";a="398453328"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2023 22:08:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; d="scan'208";a="20949937"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Dec 2023 22:08:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 22:08:18 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 22:08:18 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 22:08:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QabV8ilmJW+r0hEjHaJpjK/eRvPZbRPiOuIUAo6h2zrj/TkY1tO/xr+tq526ufvlNgEzvWsjW9pttBU2JbllcPKriBXzzf5n0qI/rfikKRV5MSnK4OZl2o+lRVXnzIac4Wtoxdv0pb8WbIh+Jbf//FN83xdl25afq1dQw+ZHItRIttz8DdOpoolKTj9tDC4UUFiNlo+vSqleEVYdBV22tOJAW0AgKepZ/vTu6/OQK66rBswHYiKwj8BkeoQ/Nj3HM2NtIyRE4roYY4pVVN/EFOmelPLAPqE/mfKxfIU+zVo22xy/W98cyUPJmYC3ZdGJU/BuGSPbdjXQF7+jNoHvEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6MOTTZA2+cZCd/ERCzjY0yhehuRpTmFWMCF+lS2qRs=;
 b=Q6RKTCp+R3XmdUVlQyMAmN9eNJHTMWB8ZOOPSmZmzk6rMllZTUH+gZsx0waHGkjc63jbtDY3I6eoJmp2NY1TPzWvW4SNvtBvIyiCrsSAfjXy3U+5VdM2YpUzXHwlvEDNtYc/lJ37VvIz7Di6xSU6o6Gpwk+EcP+Z+QWtASUtSLt11KP3LMEykxlYNq3S7meFppuMsFifn0eFUlQvjvaTO/+y6z3NRdwT7t82y4qh+qdKFgNnAolIPHJSpAI8wB3THKw5p9Gq6CL7wGeVqJvKyiLX9bSQ5x531rpp+rQtr81OvRxScunFJE9ND8L3+lpZmM6k603uoVlLHeGi8SEqgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB5577.namprd11.prod.outlook.com (2603:10b6:510:eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 06:08:13 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 06:08:13 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>
Subject: RE: [PATCH for-9.0 04/10] vfio/container: Introduce a VFIOIOMMU QOM
 interface
Thread-Topic: [PATCH for-9.0 04/10] vfio/container: Introduce a VFIOIOMMU QOM
 interface
Thread-Index: AQHaKbMqZT74l/wki02ZKCK9coqLhrCjnFqg
Date: Mon, 11 Dec 2023 06:08:13 +0000
Message-ID: <SJ0PR11MB67447A62DBC85853B6AB4652928FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231208084600.858964-1-clg@redhat.com>
 <20231208084600.858964-5-clg@redhat.com>
In-Reply-To: <20231208084600.858964-5-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB5577:EE_
x-ms-office365-filtering-correlation-id: 66269aeb-2bde-4f03-505c-08dbfa0f8eed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YT+hXeZ3yN8jd2q9wHQRAutX01Y4QqYlTgeUKQUMwjGqCugQzUDCPZFcYlVOR/ebXbcD3bfk0aznz9WsSAYdsi/ImkcGW8BKFbGtTygASldZieHmOAzV7d1t/HmimfMVuGyTY0Rpfvo83e4z18bag0r8lemBq7+CloYEviGikFqxC6YoehALkYdstb+E2Tv6F9qfOzRwwgvcWnMDXclm7Hz1ETyCTAJKYeHxckZY72kn02/2+FBS0yntkFFQEYlCnqNWcX79gvwHfDhzim7LLYKpED5GOmdZ79+fVsos8S+VrjThYk1kMKcMhtATIO+l4syMqUkTtgIPPKPP5D4fALUGggd4iw5lMDed4xMYjqbBNMairuTtMVqXVNDy25t/RXDdu1NwxDFEyoOOiX5MsL3epgKRqohXE7NES7P4sfO0Xlxhc7+eY3Nuwwv8am1cvzW08MTHbc594+aBUAuhlYmm6ewa9X0IpoZEm8MPgm1kOUYi/2NuINm0P5qw8ztpmI+bW8WI7yrmEczsMmV8How779UY+4gyYTVQUhoflIQalHEQCT50KRgACU1Hv5XxhZndjjnm/+I7FGqNwIDmGH5XKgnTH5sF5L8vh/GlOf2XLZ8LuJNW2r8dkYnc4qIO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(366004)(396003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(41300700001)(38100700002)(122000001)(33656002)(110136005)(86362001)(82960400001)(9686003)(26005)(478600001)(71200400001)(7696005)(6506007)(66574015)(83380400001)(4326008)(52536014)(5660300002)(316002)(76116006)(66556008)(66476007)(66446008)(64756008)(54906003)(66946007)(38070700009)(8936002)(8676002)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGdIMGtqTUlxY1ZWU2NhV3N3SXlRRlFJak9JeVl2QWdWUXgrZjBxTkhtRTk5?=
 =?utf-8?B?L3UxODZRSHJQSnZFU0l2a1BZTXpJTDhwUGV2V1RYSVBXbXVDYnQ4U0FuLzUz?=
 =?utf-8?B?SzdUblpiYVJqYmNJUzZuemRQeVh3Q2VjcmhheTRXSEhEdVBuR3Rrait3b2VJ?=
 =?utf-8?B?QXNvQmhoN2NnclFXUmk5SzI2NXY3cXMyVWRNYm9ra0JQZFk3OVFQdEpGcngw?=
 =?utf-8?B?UVFpOWV2OHVBQ3RMZ0QxWnk4MDc5WlVtdlRndkpIRDZEcVRiTTlWNFVCVnoz?=
 =?utf-8?B?V3NkT2FUQzBoVWNZdW9Weng0T1NOWnlobm9rTW15K1p0dnRRdnl1RzZLM2ZF?=
 =?utf-8?B?dW5xZlpmc3ZEeHRFQW1rRlZFekkxMU5LYmdRSXV2elo1M2FVZjkvWWZGdTht?=
 =?utf-8?B?YllSQkFxb0Z2ZXdYWGNuTUZITDRhVDN0UnBUMGZXUHpiaENiVmUrdUxOb0ps?=
 =?utf-8?B?ejl6SFFFV2ZOTXdtd3p3OXZpT3ZhVmNKUm5PeVRFOTZDQ3hQOE8zbUF1RjFp?=
 =?utf-8?B?MWkvUkxHT1NXRldzczAvdThmeVpXd0NwZmJydnE4bGt5cnl5TUREVTRrZUlp?=
 =?utf-8?B?cDRVYzZ5UGpnbFQ3c0M1a0VlYmVJZS9lODh6R0lxY3hnczJhUWREYW40Mm9P?=
 =?utf-8?B?Sm9jdlB3Rnk5cTUxWlFYNWhod2xNNEFrTzNnTzdYajBSMTdadGJKVmlDVVZG?=
 =?utf-8?B?TlpCUmFuTU9vYmpjQ2I0UldiK1dtdUxtSWZ2Wmw1OWtSVGpOTElXWFRUSFh5?=
 =?utf-8?B?TTNJaUQzOGswTG8xdmxUdDBqYlFPZm41TlJKaWEyWlo1ZGxxTVJWWVhWZjVv?=
 =?utf-8?B?Wnc5aGhNQ2ZQMjN4cHovL1c4clJpN3o4UThick9Id2Z3bEJ6RkwyK2hac2di?=
 =?utf-8?B?STRHc2doZUQ5dThkYTBEbHlHU0ppSlMyN3NZMFRKUFNQdE82RHVub3R2Y3Rx?=
 =?utf-8?B?M0hrSFFJenFvaUFSR3ByYlR1S2pOWnpscWRyaTlIamh1S0trQ3p0ZjU4blhl?=
 =?utf-8?B?eGVlUjBhekFhM3hKWGFGSVIwT1F1UmUzRFowTkhyamg5MXQrTG8yZDlYUHJX?=
 =?utf-8?B?eExZYjN0Vms1UHFiLzE0UVdzTTBteDVlZ2VKYzJkNFY5K2FKbHZTZkdxaHdi?=
 =?utf-8?B?TjdzVFFJeWEzU2lRODV1VU1Kbzd3ZTQzTW9KVzl1bmRqSk16aXRuRXEwelpy?=
 =?utf-8?B?bFE2NDRXbVlTODFLc0RsZlZFVVM0WlBxNzg0MSs2OXpoUTdtVlJwaVNCTXVX?=
 =?utf-8?B?YkN3d25mczVGQ0V2SDlwYmwwKzVDdHJEVUFSU2hFQmgrU2xMQldnM2FMWGNu?=
 =?utf-8?B?ZzE4ekJKWXAzaDdHdVpDTzl0VTlKSzVwaS83UHg1VDQvb0pCL2t2NnAvYnk3?=
 =?utf-8?B?NVRGSUJzcVdwUHdjRUxFRlYzRm44MmxBV0JCY3B3bWd5V1J1OFlYQ00zNzM4?=
 =?utf-8?B?SkliMEZweG9mR0xQVXY1K0ZiVnhFa1lhaVVyWEcvbGtYVHEvK2UxQ1hBVjlN?=
 =?utf-8?B?N21yNmhsUnBOY3ZzRFBiNmdKcS96cVN4N2I2RTY2ejQxRlZWSWYwM1ErZ3dk?=
 =?utf-8?B?Qk4rWW5Bd2VxS3BYdHMwdVhINmpRdENhWWhyWEF0T0cvVkp6Y0pXbDNhQVc0?=
 =?utf-8?B?TUsvbzI2aEsyTFpsMDZKNkl2R3ZPWXpyWnhwQWg3V2R4OEVRcXVDaWh6OXhQ?=
 =?utf-8?B?RUlmbVoyWUxmTUs5NEcvQkJUNWV0WEdUcndkbDBXNzh4M0lvLzY5b1ErK3N4?=
 =?utf-8?B?NmN2ZVB3d0lLM3IyV0N6UGR1UlJPc0dISzY3WFdRSk5YcFl3QzJxOVpuR0g3?=
 =?utf-8?B?dWdYRnoyYmd0RUdVVzU5NUhSSThSVWw4SCtUK0YwMFE2Nk40NDBIRFRNNC9k?=
 =?utf-8?B?L2dYcTlsd0ZvS3V2QkduNHpOVEJlTlJFYUJtQy9RRmlydkN1KzlVU1JLaUFt?=
 =?utf-8?B?Y0JZNm5ic0k5NGFYTEE1emlLaTRNRFJkZGt1RjdVWVR5c3FQdGdma215MzNa?=
 =?utf-8?B?MXVoWm9FSVFMZmtsV2lZSDJ3Mnd4SnhMTndQU0NwNVJzaVdXRU5OS0orRU01?=
 =?utf-8?B?L3BSazRVZytPeGQ1MFBwVG1wQVZNVWJ3eE1SRThGZVBlbnlZUFpWL0M1L2lQ?=
 =?utf-8?Q?KTYXjiWxhM3wKs9kar3Fa8JQY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66269aeb-2bde-4f03-505c-08dbfa0f8eed
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 06:08:13.2167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6tFhxa/o76qjNc+Hi0zDxWNE3NkwNMTWl1N9HHGgrnXSZEzhVXfrTRCsVIIdzKYEqvVFyRu3fgaORlGVkAVdIab9PpewIu4tB1cYc7T68E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5577
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIERlY2VtYmVyIDgsIDIwMjMgNDo0NiBQ
TQ0KPlN1YmplY3Q6IFtQQVRDSCBmb3ItOS4wIDA0LzEwXSB2ZmlvL2NvbnRhaW5lcjogSW50cm9k
dWNlIGEgVkZJT0lPTU1VDQo+UU9NIGludGVyZmFjZQ0KPg0KPlNpbXBseSB0cmFuc2Zvcm0gdGhl
IFZGSU9JT01NVU9wcyBzdHJ1Y3QgaW4gYW4gSW50ZXJmYWNlQ2xhc3MgYW5kIGRvDQo+c29tZSBp
bml0aWFsIG5hbWUgcmVwbGFjZW1lbnRzLiBOZXh0IGNoYW5nZXMgd2lsbCBzdGFydCBjb252ZXJ0
aW5nDQo+VkZJT0lPTU1VT3BzLg0KPg0KPlNpZ25lZC1vZmYtYnk6IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj4tLS0NCj4gaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVy
LWJhc2UuaCB8IDE4ICsrKysrKysrKysrKysrLS0tLQ0KPiBody92ZmlvL2NvbW1vbi5jICAgICAg
ICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gaHcvdmZpby9jb250YWluZXItYmFzZS5jICAgICAg
ICAgICAgICB8IDEyICsrKysrKysrKysrLQ0KPiBody92ZmlvL3BjaS5jICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgIDIgKy0NCj4gNCBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCA3
IGRlbGV0aW9ucygtKQ0KPg0KPmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250
YWluZXItYmFzZS5oIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tDQo+Y29udGFpbmVyLWJhc2UuaA0K
PmluZGV4DQo+NWM5NTk0YjZjNzc2ODFlNTU5MzIzNmU3MTFlN2UzOTFlNWYyYmRmZi4uODFkNDlm
ZTU2MmQzODQwODU5MDk2DQo+ZGQ4YTYyYWMzOGQ2MjMxNDkzOSAxMDA2NDQNCj4tLS0gYS9pbmNs
dWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oDQo+KysrIGIvaW5jbHVkZS9ody92Zmlv
L3ZmaW8tY29udGFpbmVyLWJhc2UuaA0KPkBAIC0xNiw3ICsxNiw4IEBADQo+ICNpbmNsdWRlICJl
eGVjL21lbW9yeS5oIg0KPg0KPiB0eXBlZGVmIHN0cnVjdCBWRklPRGV2aWNlIFZGSU9EZXZpY2U7
DQo+LXR5cGVkZWYgc3RydWN0IFZGSU9JT01NVU9wcyBWRklPSU9NTVVPcHM7DQo+K3R5cGVkZWYg
c3RydWN0IFZGSU9JT01NVUNsYXNzIFZGSU9JT01NVUNsYXNzOw0KPisjZGVmaW5lIFZGSU9JT01N
VU9wcyBWRklPSU9NTVVDbGFzcyAvKiBUbyByZW1vdmUgKi8NCj4NCj4gdHlwZWRlZiBzdHJ1Y3Qg
ew0KPiAgICAgdW5zaWduZWQgbG9uZyAqYml0bWFwOw0KPkBAIC0zNCw3ICszNSw3IEBAIHR5cGVk
ZWYgc3RydWN0IFZGSU9BZGRyZXNzU3BhY2Ugew0KPiAgKiBUaGlzIGlzIHRoZSBiYXNlIG9iamVj
dCBmb3IgdmZpbyBjb250YWluZXIgYmFja2VuZHMNCj4gICovDQo+IHR5cGVkZWYgc3RydWN0IFZG
SU9Db250YWluZXJCYXNlIHsNCj4tICAgIGNvbnN0IFZGSU9JT01NVU9wcyAqb3BzOw0KPisgICAg
Y29uc3QgVkZJT0lPTU1VQ2xhc3MgKm9wczsNCj4gICAgIFZGSU9BZGRyZXNzU3BhY2UgKnNwYWNl
Ow0KPiAgICAgTWVtb3J5TGlzdGVuZXIgbGlzdGVuZXI7DQo+ICAgICBFcnJvciAqZXJyb3I7DQo+
QEAgLTg4LDEwICs4OSwxOSBAQCBpbnQgdmZpb19jb250YWluZXJfcXVlcnlfZGlydHlfYml0bWFw
KGNvbnN0DQo+VkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWluZXIsDQo+DQo+IHZvaWQgdmZpb19j
b250YWluZXJfaW5pdChWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lciwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgIFZGSU9BZGRyZXNzU3BhY2UgKnNwYWNlLA0KPi0gICAgICAgICAgICAg
ICAgICAgICAgICAgY29uc3QgVkZJT0lPTU1VT3BzICpvcHMpOw0KPisgICAgICAgICAgICAgICAg
ICAgICAgICAgY29uc3QgVkZJT0lPTU1VQ2xhc3MgKm9wcyk7DQo+IHZvaWQgdmZpb19jb250YWlu
ZXJfZGVzdHJveShWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lcik7DQo+DQo+LXN0cnVjdCBW
RklPSU9NTVVPcHMgew0KPit0eXBlZGVmIHN0cnVjdCBWRklPSU9NTVUgVkZJT0lPTU1VOw0KPisN
Cj4rI2RlZmluZSBUWVBFX1ZGSU9fSU9NTVUgInZmaW8taW9tbXUiDQo+Kw0KPisjZGVmaW5lIFZG
SU9fSU9NTVUob2JqKSBJTlRFUkZBQ0VfQ0hFQ0soVkZJT0lPTU1VLCAob2JqKSwNCj5UWVBFX1ZG
SU9fSU9NTVUpDQoNCk1heWJlIHRoaXMgI2RlZmluZSBjYW4gYmUgcmVtb3ZlZCBvciB5b3UgaGF2
ZSBvdGhlciBwbGFucz8NCk90aGVyd2lzZSwgUmV2aWV3ZWQtYnk6IFpoZW56aG9uZyBEdWFuIDx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4rREVDTEFS
RV9DTEFTU19DSEVDS0VSUyhWRklPSU9NTVVDbGFzcywgVkZJT19JT01NVSwNCj5UWVBFX1ZGSU9f
SU9NTVUpDQo+Kw0KPitzdHJ1Y3QgVkZJT0lPTU1VQ2xhc3Mgew0KPisgICAgSW50ZXJmYWNlQ2xh
c3MgcGFyZW50X2NsYXNzOw0KPisNCj4gICAgIC8qIGJhc2ljIGZlYXR1cmUgKi8NCj4gICAgIGlu
dCAoKmRtYV9tYXApKGNvbnN0IFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVyLA0KPiAgICAg
ICAgICAgICAgICAgICAgaHdhZGRyIGlvdmEsIHJhbV9hZGRyX3Qgc2l6ZSwNCj5kaWZmIC0tZ2l0
IGEvaHcvdmZpby9jb21tb24uYyBiL2h3L3ZmaW8vY29tbW9uLmMNCj5pbmRleA0KPjA4YTNlNTc2
NzI1YjFmYzlmMmY3ZTQyNTM3NWRmM2I4MjdjNGZlNTYuLjQ5ZGFiNDE1NjZmMDdiYTdiZTExMDBm
DQo+ZWQxOTczZTAyOGQzNDQ2N2MgMTAwNjQ0DQo+LS0tIGEvaHcvdmZpby9jb21tb24uYw0KPisr
KyBiL2h3L3ZmaW8vY29tbW9uLmMNCj5AQCAtMTUwMyw3ICsxNTAzLDcgQEAgcmV0cnk6DQo+IGlu
dCB2ZmlvX2F0dGFjaF9kZXZpY2UoY2hhciAqbmFtZSwgVkZJT0RldmljZSAqdmJhc2VkZXYsDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgQWRkcmVzc1NwYWNlICphcywgRXJyb3IgKiplcnJwKQ0K
PiB7DQo+LSAgICBjb25zdCBWRklPSU9NTVVPcHMgKm9wcyA9ICZ2ZmlvX2xlZ2FjeV9vcHM7DQo+
KyAgICBjb25zdCBWRklPSU9NTVVDbGFzcyAqb3BzID0gJnZmaW9fbGVnYWN5X29wczsNCj4NCj4g
I2lmZGVmIENPTkZJR19JT01NVUZEDQo+ICAgICBpZiAodmJhc2VkZXYtPmlvbW11ZmQpIHsNCj5k
aWZmIC0tZ2l0IGEvaHcvdmZpby9jb250YWluZXItYmFzZS5jIGIvaHcvdmZpby9jb250YWluZXIt
YmFzZS5jDQo+aW5kZXgNCj4xZmZkMjViYmZhOGJkM2Q0MDRlNDNiOTYzNTcyNzNiOTVmNWEwMDMx
Li45MTNhZTQ5MDc3YzRmMDliN2IyNzUNCj4xN2MxMjMxY2ZiZTRiZWZiN2ZiIDEwMDY0NA0KPi0t
LSBhL2h3L3ZmaW8vY29udGFpbmVyLWJhc2UuYw0KPisrKyBiL2h3L3ZmaW8vY29udGFpbmVyLWJh
c2UuYw0KPkBAIC03Miw3ICs3Miw3IEBAIGludCB2ZmlvX2NvbnRhaW5lcl9xdWVyeV9kaXJ0eV9i
aXRtYXAoY29uc3QNCj5WRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lciwNCj4gfQ0KPg0KPiB2
b2lkIHZmaW9fY29udGFpbmVyX2luaXQoVkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWluZXIsIFZG
SU9BZGRyZXNzU3BhY2UNCj4qc3BhY2UsDQo+LSAgICAgICAgICAgICAgICAgICAgICAgICBjb25z
dCBWRklPSU9NTVVPcHMgKm9wcykNCj4rICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IFZG
SU9JT01NVUNsYXNzICpvcHMpDQo+IHsNCj4gICAgIGJjb250YWluZXItPm9wcyA9IG9wczsNCj4g
ICAgIGJjb250YWluZXItPnNwYWNlID0gc3BhY2U7DQo+QEAgLTk5LDMgKzk5LDEzIEBAIHZvaWQg
dmZpb19jb250YWluZXJfZGVzdHJveShWRklPQ29udGFpbmVyQmFzZQ0KPipiY29udGFpbmVyKQ0K
Pg0KPiAgICAgZ19saXN0X2ZyZWVfZnVsbChiY29udGFpbmVyLT5pb3ZhX3JhbmdlcywgZ19mcmVl
KTsNCj4gfQ0KPisNCj4rc3RhdGljIGNvbnN0IFR5cGVJbmZvIHR5cGVzW10gPSB7DQo+KyAgICB7
DQo+KyAgICAgICAgLm5hbWUgPSBUWVBFX1ZGSU9fSU9NTVUsDQo+KyAgICAgICAgLnBhcmVudCA9
IFRZUEVfSU5URVJGQUNFLA0KPisgICAgICAgIC5jbGFzc19zaXplID0gc2l6ZW9mKFZGSU9JT01N
VUNsYXNzKSwNCj4rICAgIH0sDQo+K307DQo+Kw0KPitERUZJTkVfVFlQRVModHlwZXMpDQo+ZGlm
ZiAtLWdpdCBhL2h3L3ZmaW8vcGNpLmMgYi9ody92ZmlvL3BjaS5jDQo+aW5kZXgNCj4xODc0ZWMx
YWJhOTg3Y2FjNmNiODNmODY2NTBlN2E1ZTE5NjhjMzI3Li5kODRhOWU3M2E2NWRlNGU0YzFjZGFm
DQo+NjU2MTlhNzAwYmQ4ZDZiODAyIDEwMDY0NA0KPi0tLSBhL2h3L3ZmaW8vcGNpLmMNCj4rKysg
Yi9ody92ZmlvL3BjaS5jDQo+QEAgLTI0ODgsNyArMjQ4OCw3IEBAIGludA0KPnZmaW9fcGNpX2dl
dF9wY2lfaG90X3Jlc2V0X2luZm8oVkZJT1BDSURldmljZSAqdmRldiwNCj4gc3RhdGljIGludCB2
ZmlvX3BjaV9ob3RfcmVzZXQoVkZJT1BDSURldmljZSAqdmRldiwgYm9vbCBzaW5nbGUpDQo+IHsN
Cj4gICAgIFZGSU9EZXZpY2UgKnZiYXNlZGV2ID0gJnZkZXYtPnZiYXNlZGV2Ow0KPi0gICAgY29u
c3QgVkZJT0lPTU1VT3BzICpvcHMgPSB2YmFzZWRldi0+YmNvbnRhaW5lci0+b3BzOw0KPisgICAg
Y29uc3QgVkZJT0lPTU1VQ2xhc3MgKm9wcyA9IHZiYXNlZGV2LT5iY29udGFpbmVyLT5vcHM7DQo+
DQo+ICAgICByZXR1cm4gb3BzLT5wY2lfaG90X3Jlc2V0KHZiYXNlZGV2LCBzaW5nbGUpOw0KPiB9
DQo+LS0NCj4yLjQzLjANCg0K

