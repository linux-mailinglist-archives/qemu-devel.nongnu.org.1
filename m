Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA9F838B57
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 11:04:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSDdg-0002xM-7U; Tue, 23 Jan 2024 05:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSDdc-0002x8-Js; Tue, 23 Jan 2024 05:04:12 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSDdW-0000py-Hy; Tue, 23 Jan 2024 05:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706004247; x=1737540247;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YTH/VHGYQBxBed9uhoqLI1chCMeG+DFPxs9C824krcM=;
 b=fW+z5vRbT/vP8Wb+3SPpisX1fuOj+r4m9LA34VxMdL/xEY/gSluIU/bK
 vGuJGvSIAl5XIxGDWRFCM/XjLhyagBC0KTszARmXSLMt1RhKoq8LR9IOY
 shQf4qJK/JKPA/MtoWhqzguoH+0n/+hQ6tdQD04jgsR47oorkiITwiSjs
 uhCH74LkreoEB++dTyXTIXp2ZJmY2Pefev24AmGHDRNsLyWdx72reLcCo
 dVRuvPu1EcR6aNXIIxAHf4QvVmyf0kyXpt/1ZNzAeFwEd9VmwR1eKc4cy
 Cv2b9SXiFhwcu1PPfK2nG9EIzc7BV1gDXyrGbXRV1pniW5xiV3jERmfVR Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8842615"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="8842615"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2024 02:03:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="959057303"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; d="scan'208";a="959057303"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Jan 2024 02:03:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 02:03:47 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 02:03:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 02:03:47 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Jan 2024 02:03:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPnsu3nkJJAp4CEGlJ9/C0VR5StIjNLSV51f46mYS1u/bWNsUdXQNe7uokoZh04Ynm5Km1g86kv0l0/RPwOVsJAWgJwa2MtAWXcxUmnxeV/0P+xuTzWyRYVWHVehyGxIFyFs1CafS+HqdjvDBQNW6lHK9A6oe4lSWBG/GPTlRgQOD2yVQxlKW/C9FU2fwcIydyw030b1yU59U8ycdnaW+95KqrxrXZCmty9fknO4lsDXc+DVfca/sxlekQLIjq+LQ6p93ZVdCTxwA7EoKOu2unx3DyD5GYMjbB9NISIzVFM3Ood+VWB06p+HsQY/x7z82vhMinslDXBFk7u4DFLzLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTH/VHGYQBxBed9uhoqLI1chCMeG+DFPxs9C824krcM=;
 b=B+Otiz1xrVcZfjV3hLDto32HJ02jXlxOL09tQzoMZaChY3hbrQBHTIpGQYMugL61UtzG2lB1vNuBpeSVVcugz2ali5sPc8KMw/ail5pPRCbdSCoaiaj27AzOYma7juouyVgNkVVWKAxNDLgmsyMKvrFXQ9uzUhUeib2rb/D4/5YvxUO9ujMNbKLBGtnt+CVHVanJiXWpVDq50hoLZ8SWBronoKiNhMhGhv1vpZLLFrBqykaLPxFgFaDVizQ6inC4bd3XtgjB5vvZroeHsJFMwur5NsfQsXP9YIB+CyFLR3C3w8/oNpyNTWjAbygeC7eROZaapjC0ZlEe0ZlomOj1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB7341.namprd11.prod.outlook.com (2603:10b6:208:426::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 10:03:45 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3%4]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 10:03:45 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH 1/3] virtio_iommu: Clear IOMMUPciBus pointer cache when
 system reset
Thread-Topic: [PATCH 1/3] virtio_iommu: Clear IOMMUPciBus pointer cache when
 system reset
Thread-Index: AQHaTP4zVTrr9AB0XEWQmwIG6AB3qrDnJr2AgAAF+NA=
Date: Tue, 23 Jan 2024 10:03:44 +0000
Message-ID: <SJ0PR11MB6744E96BE6A6014F7E43899892742@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240122064015.94630-1-zhenzhong.duan@intel.com>
 <20240122064015.94630-2-zhenzhong.duan@intel.com>
 <c47b95f9-ca42-4f8e-85d1-8fc72404e441@redhat.com>
In-Reply-To: <c47b95f9-ca42-4f8e-85d1-8fc72404e441@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB7341:EE_
x-ms-office365-filtering-correlation-id: ae3c37b2-4383-4e65-12cb-08dc1bfa95df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1fM+wWe+uE5ejGMBWXoSyt3cPXONh+41r3u30Z3AQXxvPsSyD+lKUP7L1O9C0/TP6ouMU1yiJUXtJg6UNHvsDYk2QOMvqbmZPa6DaBYPiJyEIn5FDZ0cBsqbHwai3GeLPl0bFkJR3ZKXZbt2YyZ2VtUXUV35linEX7IcLBogJ7dlNeRNE7Q44KiPZPb2V+xnLuMA3w2bFbsQL6p5EaH2T/zieDFCHOJZmzxfoP4xbajJCyEXzNhT5eynk4iSjKzQeha0pYh/xN2pFmePj7LOF6eiyyNPkYeA5Orb0ULDZr6wBwccbVwBIfxa4wwh4nnmn4GemsWHJctjLXik2DF7peTblsqqppB7T0z5PAqPfhlhp5+kgSBDfYcIXPfpU2vkPvnEaeOD2ufu7rgf55K8WiTXxNfwD3mH1/lOuocVJ0ydvVfIu7q6AbwtZDhMNbtoahKhUrCO4N6c/4hRJssKF7qgR4uiGJecPHpgWCPpamsA4cHasTutMKZBJW7o+/3J0fXuwrtDP+Yb9NRgzmYPgD+QNB3ekykeCS1GbD1oPNgTt1P96tganwRrAKkoDE/GcWwjPUHwmO54w8XBxr9sbPebHRkw2MW9drBBJqGxqx3a9Z9nt7eM3PnlG4hxsEIMd+eY/dplMr3eHGoNVhJ+kQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(71200400001)(7696005)(6506007)(9686003)(107886003)(26005)(122000001)(38100700002)(86362001)(33656002)(82960400001)(38070700009)(52536014)(41300700001)(83380400001)(5660300002)(2906002)(478600001)(8936002)(54906003)(64756008)(66446008)(4326008)(66476007)(8676002)(110136005)(316002)(66556008)(76116006)(66946007)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUhWemlzbVRiMFRMTjM4TWY2TzVwc2JrMGhFOGVPQVVBd3VtR0EzRDNUam0z?=
 =?utf-8?B?VU84QlZNL1BDZ09wYi85RXhXSnNiaGFCd3FaK2gxeDMzYU8zV1ZsOGxQeFda?=
 =?utf-8?B?b2ZyaVFQM0l2KzlzSTlydHRubnZXTFluTk1MeEJzUUduekFnbUxiMGJqQWJk?=
 =?utf-8?B?SXJiT0Y4UnNibGFsSGZWbWt3QnNhQ2tlc3R3bzlmNVJKckI2dnBCMVJRQVVm?=
 =?utf-8?B?ZVhldHBGcmZmbHRxK05icndSblJRYjdXRFMvdlh5VUYyYmE2eSs1ZnZYblh6?=
 =?utf-8?B?RVA5N1l1V1dOUTBnSHg5UmdmRWlwcVNXbmlESURLMytuMDhmOGRnalJ6bFl2?=
 =?utf-8?B?VEp2SzhPeThEdnhzUTdRVlhmajlNQzF3N2hydzFsaVEzb0dEemlqd3Y3eG1X?=
 =?utf-8?B?RWFlVjR6VXFvSzB2MEkvK3ZTbmYzWWpoZTZJeVowT0JuY1c5eGUvMUxYNHE1?=
 =?utf-8?B?UU5taVorRWpUYkM2S3NtQkl5alNSYUF0NGhlOU5pT2MvN3RNUzNEdkpkQkRZ?=
 =?utf-8?B?Sjh5RndsMmNGM0M2eTVWbDBOZXVaN0w3MmRKWTdjSW5RUFZ2RnVQRHV0SlJB?=
 =?utf-8?B?WGtkMFNXZXVDNXozYTVYY2ljVFFKRDJ5OUY3VFhtcHVEeVFOaHJXcGgyaE5w?=
 =?utf-8?B?Zk1OUk1zZ3V1M1FubWxFY3BQTWJBTE9FR2t4WkxZcXRLZHJDTkU5Nzl1eU1h?=
 =?utf-8?B?b2F6MEo0L0lYMGlvdEtXNE9abms4aVdwdnF1TlJZYzFIdE9yekhmTnFEWm9D?=
 =?utf-8?B?b0tmenp0ZlNURHlWSVhlWThVLzFBVU9KS0kyNG5kaG04VHpheXAyQVUvSU55?=
 =?utf-8?B?cGtuUUhDY3ZVRjFWTGJIbHZnU1VadGUycjJqbEdocDB4RjdxdFNYemFIblAr?=
 =?utf-8?B?NjA4a3dJZlQ0Y3Q4cW1zZlNveE9EdlJQQURpTVBDdHBoZWV2NEdGRzNSUytl?=
 =?utf-8?B?aXVrMHFVUlhpMjhJOXFmL1N6dFZwbnk5YzRqSHYzUklzQ0dzZjFSSjgzOVQ4?=
 =?utf-8?B?SmMxK3pwd0pPWjhWQStOM0haMXNwYVhMZUVtU2Y1Y2VXZmIrdzkrS09BbEpa?=
 =?utf-8?B?YXpvdk81REh1S3czQkM5NUNoa1R6NVVvWW9xenQ4amxhWWdab1I3Nm4yQ2pG?=
 =?utf-8?B?RjA3RTFrQ0lUMGErdG9qMjdUODdYOFZ3bjUzZlBZS2w2WjVTczN1OGp0NmxS?=
 =?utf-8?B?Y1FpSlRmaGFQbEQrU3VQdkZJbFVJY0xPODhRUWJ0L3hJNGZnd25xSjlobmJX?=
 =?utf-8?B?a25ya0hQU1lkaTAxQXNSNVozZUhiL1J0VFdpc2lTRHdnWkFKbTVYZWRHWGFo?=
 =?utf-8?B?azQyRE1XckpvN2gyRFovb2tKNFV5RmptR0g2TzdPdkQ2NmZJSmpLUVoxOTFI?=
 =?utf-8?B?WWo4UVp1bzZZSkxjQS9RSGZvM0p0eDNIdUVMRzNKM3ZZdzQwSENpTDEzTHhE?=
 =?utf-8?B?MU5WY1Y2UnVoQzZPYUZWN1hwYmZGK1luV2tML3Z3QTkyek9KdUN3a0YySHU0?=
 =?utf-8?B?QU1GQjA2M044SkNGTzlvZnVvN0hUYnorUkRRQ2lSUzROZnFDMENIWE91c1N6?=
 =?utf-8?B?K1kybXVuU2thc0xmc2lBQlR3T2MzM1MxaWEybWJ2dURETHpXS1A5SE5RWE8x?=
 =?utf-8?B?TUtIR3NDRTVhSnNKYzh0aFViZi9wWlZmcjlMVG12L2FDZ2VERlJTeFlyVUVq?=
 =?utf-8?B?T09aOUxSOUMweFM1NFd6Skw0MWk2dktRSHhoWGl5RnhUUHdoSllCK282bzdC?=
 =?utf-8?B?dWNwTnRRdi85MUd2eVYzNjZmY05LZXVzUmtocDZMYkNFNlRxanFHa1pmajEw?=
 =?utf-8?B?azZQeWs3YlpELzkwTHRacWJHNHhvam5mclViZDh4ZEVzSFUrRzk5SDdYclBt?=
 =?utf-8?B?Z214VmoyVUlYM2hJT1JOYmFuakRQdEJDcWVpd1MvUk8zNmRaelVJRmdRcXI1?=
 =?utf-8?B?RHN0bE5LUkFPRmx0TEgycmFabHpEbFd6dHQrdHNTZ0hVQ2xaU2RwbzRQNkdz?=
 =?utf-8?B?ZGNETTBUdTBlbHBRSE5jMDlGamdKOU9wTWRLdk9zVGpOYUtOVzhBTjlVYUZH?=
 =?utf-8?B?bW9JcWJrdjh6cjN2VVY3RGU5R0d2R0JXalFRLzFmWUU4UXhkWlMvcDhIemRy?=
 =?utf-8?Q?QLv/b3W1I0/8xzxJ4ZTMOuZcF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3c37b2-4383-4e65-12cb-08dc1bfa95df
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 10:03:44.9758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lwDzLdIxPacMMxeHSSpNGO8Bs8M/0jAbvIMLTTFXqjHGAkj84FtEug3RjT/5i8XZLf2lIZJdzdztP7RU9zERqJ6RBlDGdmsVLmqBsHcAT5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7341
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIDEvM10gdmlydGlvX2lvbW11
OiBDbGVhciBJT01NVVBjaUJ1cyBwb2ludGVyIGNhY2hlDQo+d2hlbiBzeXN0ZW0gcmVzZXQNCj4N
Cj5PbiAxLzIyLzI0IDA3OjQwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IElPTU1VUGNpQnVz
IHBvaW50ZXIgY2FjaGUgaXMgaW5kZXhlZCBieSBidXMgbnVtYmVyLCBidXMgbnVtYmVyDQo+PiBt
YXkgbm90IGFsd2F5cyBiZSBhIGZpeGVkIHZhbHVlLCBpLmUuLCBndWVzdCByZWJvb3QgdG8gZGlm
ZmVyZW50DQo+PiBrZXJuZWwgd2hpY2ggc2V0IGJ1cyBudW1iZXIgd2l0aCBkaWZmZXJlbnQgYWxn
b3JpdGhtLg0KPj4NCj4+IFRoaXMgY291bGQgbGVhZCB0byBlbmRwb2ludCBiaW5kaW5nIHRvIHdy
b25nIGlvbW11IE1SIGluDQo+PiB2aXJ0aW9faW9tbXVfZ2V0X2VuZHBvaW50KCksIHRoZW4gdmZp
byBkZXZpY2Ugc2V0dXAgd3JvbmcNCj4+IG1hcHBpbmcgZnJvbSBvdGhlciBkZXZpY2UuDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNv
bT4NCj4+IC0tLQ0KPj4gICBody92aXJ0aW8vdmlydGlvLWlvbW11LmMgfCAyICsrDQo+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmly
dGlvL3ZpcnRpby1pb21tdS5jIGIvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5jDQo+PiBpbmRleCA4
YTRiZDkzM2M2Li5iZmNlMzIzN2YzIDEwMDY0NA0KPj4gLS0tIGEvaHcvdmlydGlvL3ZpcnRpby1p
b21tdS5jDQo+PiArKysgYi9ody92aXJ0aW8vdmlydGlvLWlvbW11LmMNCj4+IEBAIC0xMjY0LDYg
KzEyNjQsOCBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9faW9tbXVfc3lzdGVtX3Jlc2V0KHZvaWQNCj4q
b3BhcXVlKQ0KPj4NCj4+ICAgICAgIHRyYWNlX3ZpcnRpb19pb21tdV9zeXN0ZW1fcmVzZXQoKTsN
Cj4+DQo+PiArICAgIG1lbXNldChzLT5pb21tdV9wY2lidXNfYnlfYnVzX251bSwgMCwgc2l6ZW9m
KHMtDQo+PmlvbW11X3BjaWJ1c19ieV9idXNfbnVtKSk7DQo+PiArDQo+PiAgICAgICAvKg0KPj4g
ICAgICAgICogY29uZmlnLmJ5cGFzcyBpcyBzdGlja3kgYWNyb3NzIGRldmljZSByZXNldCwgYnV0
IHNob3VsZCBiZSByZXN0b3JlZCBvbg0KPj4gICAgICAgICogc3lzdGVtIHJlc2V0DQo+DQo+eW91
IGNvdWxkIHJlbW92ZSB0aGUgbWVtc2V0IGluIHZpcnRpb19pb21tdV9kZXZpY2VfcmVhbGl6ZSgp
IHRoZW4gPw0KDQpHb29kIHN1Z2dlc3Rpb24sIHdpbGwgZG8uDQoNClRoYW5rcw0KWmhlbnpob25n
DQo=

