Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A103B80C15D
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 07:34:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCZqS-0005ZA-Bg; Mon, 11 Dec 2023 01:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCZqQ-0005Z0-47
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:32:46 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCZqN-0004as-GD
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702276363; x=1733812363;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nla4J4oWmbY274rR5UWeCYmQcwJNnpKHofWkH8zIXP0=;
 b=b/XJowlZXrfb4EtNDC2w/gB9W5bxu+rLXuMDBd1EDwA6j4C7yapyY1sb
 Ct48ZAWN3vVWdw+AhoHMWCYIBl8WwjRrGyPkNlymDs1vXaONXGTPVyxIt
 MSXZ714uh+Tkxuk/Hxc1azw/BRKp+LD5N3EOXTT4txPcIHtpqQG/pVzt8
 G/1GisgKcMpgZD0F117SesHiM7avPLYTUIF3XENQgvT9CZyAAVPqYipXl
 bkBJBfQBrmyq9Qu4OyNALoOR5NDL0VxRLZPrUvnlPwCJ95vPP9wKbyafp
 8cmUMsH0hEEeolW48ecIbq7IOozhvE2OuZC2hnALfAkCWgCGPhqQYw70G Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1717473"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1717473"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2023 22:32:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; d="scan'208";a="20952534"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Dec 2023 22:32:40 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 22:32:39 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 22:32:38 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 22:32:38 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 22:32:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mfe1IfOHPrbYSBsKgyv6fQJxXWy58MMtD3/3lQa2PF0FROfAXjawTxWu2LlcDLceUcVoqKbQmG7ddpw8AF7QxAKliK83CUZxr4CkPa1A9jXgrRlDXNcP4xxJyCFNObkKfX0RpeOwwd0qQkrtu/1ZzwHY2vazNnJXi/hyjtFGWnhu09WcTY9vTOapfyP6aHpFJJbKsCr6jF0W+LDDMoM8+RLJUJHQxJqXU0hvp72XtX4T4DW4S5w6ZYs+v9ITEEFcIV6pP/sN15snGD/vQAkeSBzVER41kjROwmvh5IW37WAzeYnLz7O9tFNSJ9Cz7p09VFoRNwdCKpL9i8AvioIx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nla4J4oWmbY274rR5UWeCYmQcwJNnpKHofWkH8zIXP0=;
 b=diSJ1T7kqMwFCHyL+0wpmu7p+vRw8I5t7Q/B1V5fbWE97Xij9WtzE4Rmu7Hk1Wtxq9Mu//f2osfttGdxbJJlH3m3MiLDA7P8hEgU8dZ6oHx+1aT+3UYwWxEoOANPHQo26kzaDbX3eZ+3kalxvs2vnfGRgBnoBx5jKKUcEcgzkZR6phfGZYIEP9+5dbbPJOoKUjawnfO6RNRsrR7mZQIDcjc21qXF8gmBwpz2FP3XQ0VSlwHX0CZnzbn+Vdj9MSqDO86Cad6jf2khOMV+cEOiGcti2cd7BlG11rGa1JAP69TgDer0wvRbm9kdb++kawxs6vOXT+JGzD2W9uy08wAK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB7372.namprd11.prod.outlook.com (2603:10b6:610:145::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 06:32:35 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 06:32:35 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>
Subject: RE: [PATCH for-9.0 08/10] vfio/iommufd: Introduce a VFIOIOMMU iommufd
 QOM interface
Thread-Topic: [PATCH for-9.0 08/10] vfio/iommufd: Introduce a VFIOIOMMU
 iommufd QOM interface
Thread-Index: AQHaKbMoB930AztFbEeRn4MIGgxtOrCjpCSw
Date: Mon, 11 Dec 2023 06:32:35 +0000
Message-ID: <SJ0PR11MB674402E057ECB1175804D8E3928FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231208084600.858964-1-clg@redhat.com>
 <20231208084600.858964-9-clg@redhat.com>
In-Reply-To: <20231208084600.858964-9-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB7372:EE_
x-ms-office365-filtering-correlation-id: a3736e24-4eb4-451f-f450-08dbfa12f6a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sn3mPcb4jybHNcElfOBtlu0V4PFB2xO8efFzXPr3Wlgl3BxrkfCBiaxQwR5UIFXzpaSsnw4I/kh4pas8TM5JCjzGxV7lTK7LpqLza12la7XhAGuPb3/588rx3qD+L9NC74RKXMBHDAEEUR2rj2sVAVb58peuat+062in77g1IePYtoHasjpGUx4UJXDrv2JDnZ0+H0rMrQFUk6cBvyY3VNhlq5+Xf7JxYjl9B89dACdT5ClJmAk+D46//TmSAayH4O5epK3BSeNLB/UFQp1uf1jNCkaEJjN3XEvjlRXqzy5c4ognFYH3Um/dljzjLg9jAs5bwMFofskTBUCUZL1vTGPGQhkoZpqJ6tqUj9KQZ7hcClWK6SfgUNwkXfz+VAmOEPNhPCWHk/YWWjRIXzEpurCG91/HqKv6UwHTMirgfLcNXIOTCj/O884520GHgh2iMeHBXrpcm9rO6cNl34k/0CIqey/b37dzEHlL4RPZI6YeWK2kvWRlR8l139YmAiyKuDBSTErj7skVM6/Y8V6FpHKvgWdmX+32jjOO12j4m6slPtzz9EKuX/aBdhAW1G34QVpWMNOL3Q2UtsvwEGjgE/vsvVeVikOCbd4A4uMWwRNMhKm8OzcK97s7cNf3YI5l
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(9686003)(52536014)(6506007)(5660300002)(26005)(33656002)(55016003)(38070700009)(66946007)(76116006)(54906003)(66446008)(66476007)(66556008)(64756008)(2906002)(83380400001)(82960400001)(41300700001)(478600001)(7696005)(86362001)(8676002)(8936002)(4326008)(122000001)(110136005)(316002)(38100700002)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjAzb3U1UXpvaFpGb3VOQUFuZUFrWEw3bTg2QXRuc01ocVh1Qkh2QTREVVN5?=
 =?utf-8?B?a1J6cEJYdStLbzlwVlR6eWVsQ0pHWVM2KzhYLzhMdVpxUnU3Wi9wWVdKSVlK?=
 =?utf-8?B?YTZsRzAzd3NuOFhpZkNZOFJQUmo1YzZvS2s1UFAyWmtUQ2pIckRBN2YzanlY?=
 =?utf-8?B?UDd3Nnd3Vm82ME85VGV5UkoycklyMitHeGFHU3Y1T2FPb04xYWFiOWlwY2pT?=
 =?utf-8?B?c3Y5eFcyQUs1cFBFWkt1N2lLL0tBZEtMdUtjSWhhS2s4YlNUT29TTnhzSlFu?=
 =?utf-8?B?OFFRc1pmWmZqblhsVTE3OFlodXYvWVRScGxBYnVSc2p0WmI1NVpMMWQxZ3Q4?=
 =?utf-8?B?Ump4UUNrb29UZmlVS3ZrYm5SRVVuUWo2a3QwLzVqaGl5cE5wdEpBV2VTcFVJ?=
 =?utf-8?B?M2FLRjg5NTJBQU9OdlZKY2pxWUU2QU5ZT2EzZ2ZSSFdLc1FCcFFGM0N4elM1?=
 =?utf-8?B?NXBhaVlORGFVaEZRckdRcWhKVjZVRlUrQXFUMDhZeXJmYWp0RmcxZGpHaUNK?=
 =?utf-8?B?NU5XMGR2blFKcjQ2R094RGNMZVFaVHcyUWpoVGtBOFJ0OHp1WjNHS1UvTFR2?=
 =?utf-8?B?UlQ0R1RZclpiSHFTSHh6UHJtWDBaaEd0ZVhZZXRyVGJxN0V1VXFJOWRNWFdy?=
 =?utf-8?B?bDM5dGEvTTlMV0VjYnNsNnNqN1VDZHBEd01sckkvTkxmOXdOR3poTFcrdDlJ?=
 =?utf-8?B?ZGZsUUQxQTlBOCsycVhpSjVyaENkbGZDaERIaWprQmZ4ZUpiajNreFk5aFQy?=
 =?utf-8?B?WWFicWJtdTFlMnl0akVyVTRJTW9SdTB5SGVFa1NjWkJTZ0FDT3cvZ2pIZ09j?=
 =?utf-8?B?UDJWNTBzbVBQb3NrUEVjQnc2SXFEVzczZG9LSVozV2lRY1owN0wyeHRjNGhh?=
 =?utf-8?B?M3JUUmJUbTh3andOZDNHZ3oySzNaWHBlNnl5QkE2Zm9BbFpXcmo2QmZkbWNX?=
 =?utf-8?B?cldGN2V2bzZTa0xMZXZweUFLVUNoSjFZcDJFUUxNRlRJU0cwajN1TEhSSDNJ?=
 =?utf-8?B?MHVmak0zZ2hERXNIQkdrNFkveTgrU2ZCQ0JuMzc5dTFBOVdmdktUTm5GQkc4?=
 =?utf-8?B?VjFYeW13Z0VHUGxaTXdjVWJzcE5peU9PclIrUlV4QTRYZVJkZkYvQWxoakJo?=
 =?utf-8?B?TWRRb1RyblFwUk01WkxzbDYvZWVCcnYzZ1cwRUYzL1dOMnBCZm91dTNhQjVJ?=
 =?utf-8?B?ZjBrTmdLTnlaTnZYVGpRd05Dc0pDVVFsbjNzUjV3bnRYSFJJVVRpV2ZKZmpK?=
 =?utf-8?B?VTh3V3pLRVpmUEo5c2RkUGp1aGZ3cGU5UUpJZTkxdXEvV0U0TGUrUjROWVh2?=
 =?utf-8?B?Z2NNcmt6LzUrc3VjbE92NTladXlKa0ZwSjdEa2lqeXRsME1uZ2lvNnhOQzFT?=
 =?utf-8?B?aUtrcWg2RTZQczhBZ09aanZKMXZROVBSZHRaT0RsSDhVQkdZend3L1FpQ3Z3?=
 =?utf-8?B?YTFyQjkxSEVwUStoeTFDNDIrSEFYUEZicjVWZStjTDF0ZDM3UE1QcmJrbXNs?=
 =?utf-8?B?c2dNV2FPVlpiNEFxNEtDTHdJeVlSaXQ0L2p2bWlQVDBXenk2emM2MG0rREc2?=
 =?utf-8?B?bmM3V1U1YW94SlZFUGFVNnM0bjBJMjdiSm10UEdiYmFmV3UyMXlrcU5qU1BU?=
 =?utf-8?B?RHU0MjB1VTNMVFp0VkdZSnlzUDdGNVYyS0lhNDBhazhYWDRQVTR3RlV3VkNw?=
 =?utf-8?B?RkRNVjZvWjZZUVRxOGUzeUpDWHZUQ3kyaHpKRHNCMmdDV0xPTkdJUWxVQll3?=
 =?utf-8?B?VngwcnhRTW5yM2xQTUhpdklzR1FqT2JWLzZyZTVKYWNrd2dNSEl2T1N4SE5a?=
 =?utf-8?B?UVYyMlYyeXJYYVFNUU9qdXI2UnFFZ1dmTmZCSXRMdE40Ykg3anNSdmhQeXBV?=
 =?utf-8?B?eWM5SVFrMEpWdU1HWG5qRHlXRlNOMG8zR05QZDdjUFZERThCVEM4alhQbG9Q?=
 =?utf-8?B?MWZpYlVuYk5zSDBQSjhZVEZrYU1vc0QyZkRscXd3WnhzWk9kZittYlBvNXN4?=
 =?utf-8?B?aE9ibDNyTXVTcTYweGwvdjlGVXRQcEFOMFBoTzRHZXIxb3B2TXlaSDdhekVB?=
 =?utf-8?B?RjY5WUVHcjJNeUZQQTIrbE9FWWdNU2JLZElqTGlMNVNBYUVnK0xlY3JEbDZr?=
 =?utf-8?Q?rbwd2m9CXjF0yZDdPh3NpFIW1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3736e24-4eb4-451f-f450-08dbfa12f6a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 06:32:35.7443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y8xOO21AxlZ74NROSblquoO2bfncTrV3umr5jtQAzg4w2zeTGSHIf/XIwpTCWFBwpgffVDmZq3Gi4qJ1UM+EhLQAi109qdUkOxMLOrvv20Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7372
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIERlY2VtYmVyIDgsIDIwMjMgNDo0NiBQ
TQ0KPlN1YmplY3Q6IFtQQVRDSCBmb3ItOS4wIDA4LzEwXSB2ZmlvL2lvbW11ZmQ6IEludHJvZHVj
ZSBhIFZGSU9JT01NVQ0KPmlvbW11ZmQgUU9NIGludGVyZmFjZQ0KPg0KPkFzIHByZXZpb3VzbHkg
ZG9uZSBmb3IgdGhlIHNQQVBSIGFuZCBsZWdhY3kgSU9NTVUgYmFja2VuZHMsIGNvbnZlcnQNCj50
aGUgVkZJT0lPTU1VT3BzIHN0cnVjdCB0byBhIFFPTSBpbnRlcmZhY2UuIFRoZSBzZXQgb2Ygb2Yg
b3BlcmF0aW9ucw0KPmZvciB0aGlzIGJhY2tlbmQgY2FuIGJlIHJlZmVyZW5jZWQgd2l0aCBhIGxp
dGVyYWwgdHlwZW5hbWUgaW5zdGVhZCBvZg0KPmEgQyBzdHJ1Y3QuDQo+DQo+U2lnbmVkLW9mZi1i
eTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogWmhl
bnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCg0KVGhhbmtzDQpaaGVuemhv
bmcNCg0KPi0tLQ0KPiBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCAgICAgICAgIHwgIDEg
LQ0KPiBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oIHwgIDIgKy0NCj4gaHcv
dmZpby9jb21tb24uYyAgICAgICAgICAgICAgICAgICAgICB8ICAyICstDQo+IGh3L3ZmaW8vaW9t
bXVmZC5jICAgICAgICAgICAgICAgICAgICAgfCAzNiArKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0NCj4gNCBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkN
Cj4NCj5kaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggYi9pbmNsdWRl
L2h3L3ZmaW8vdmZpby0NCj5jb21tb24uaA0KPmluZGV4DQo+MTRjNDk3YjZiMGE3OTQ2NmU4ZjU2
N2FjZWVkMzg0ZWMyYzc1ZWE5MC4uOWI3ZWY3ZDAyYjVhMGFkNTI2NmJjYw0KPjRkMDZjZDY4NzQx
Nzg5NzhlNCAxMDA2NDQNCj4tLS0gYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPisr
KyBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+QEAgLTIxMCw3ICsyMTAsNiBAQCB0
eXBlZGVmIFFMSVNUX0hFQUQoVkZJT0dyb3VwTGlzdCwgVkZJT0dyb3VwKQ0KPlZGSU9Hcm91cExp
c3Q7DQo+IHR5cGVkZWYgUUxJU1RfSEVBRChWRklPRGV2aWNlTGlzdCwgVkZJT0RldmljZSkgVkZJ
T0RldmljZUxpc3Q7DQo+IGV4dGVybiBWRklPR3JvdXBMaXN0IHZmaW9fZ3JvdXBfbGlzdDsNCj4g
ZXh0ZXJuIFZGSU9EZXZpY2VMaXN0IHZmaW9fZGV2aWNlX2xpc3Q7DQo+LWV4dGVybiBjb25zdCBW
RklPSU9NTVVPcHMgdmZpb19pb21tdWZkX29wczsNCj4gZXh0ZXJuIGNvbnN0IE1lbW9yeUxpc3Rl
bmVyIHZmaW9fbWVtb3J5X2xpc3RlbmVyOw0KPiBleHRlcm4gaW50IHZmaW9fa3ZtX2RldmljZV9m
ZDsNCj4NCj5kaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2Uu
aCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLQ0KPmNvbnRhaW5lci1iYXNlLmgNCj5pbmRleA0KPjQw
MTIzNjBjMDdiN2MwYTIzZjE3MGY5NGExOTQ1NWM3OWQzNTA0YjEuLjVmZDAyZmFiNWZkNjI3ZGM2
MDEwNjgNCj41ZTlkOTU2YmEyMGVlMzI5ZmQgMTAwNjQ0DQo+LS0tIGEvaW5jbHVkZS9ody92Zmlv
L3ZmaW8tY29udGFpbmVyLWJhc2UuaA0KPisrKyBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRh
aW5lci1iYXNlLmgNCj5AQCAtMTcsNyArMTcsNiBAQA0KPg0KPiB0eXBlZGVmIHN0cnVjdCBWRklP
RGV2aWNlIFZGSU9EZXZpY2U7DQo+IHR5cGVkZWYgc3RydWN0IFZGSU9JT01NVUNsYXNzIFZGSU9J
T01NVUNsYXNzOw0KPi0jZGVmaW5lIFZGSU9JT01NVU9wcyBWRklPSU9NTVVDbGFzcyAvKiBUbyBy
ZW1vdmUgKi8NCj4NCj4gdHlwZWRlZiBzdHJ1Y3Qgew0KPiAgICAgdW5zaWduZWQgbG9uZyAqYml0
bWFwOw0KPkBAIC05Nyw2ICs5Niw3IEBAIHR5cGVkZWYgc3RydWN0IFZGSU9JT01NVSBWRklPSU9N
TVU7DQo+ICNkZWZpbmUgVFlQRV9WRklPX0lPTU1VICJ2ZmlvLWlvbW11Ig0KPiAjZGVmaW5lIFRZ
UEVfVkZJT19JT01NVV9MRUdBQ1kgVFlQRV9WRklPX0lPTU1VICItbGVnYWN5Ig0KPiAjZGVmaW5l
IFRZUEVfVkZJT19JT01NVV9TUEFQUiBUWVBFX1ZGSU9fSU9NTVUgIi1zcGFwciINCj4rI2RlZmlu
ZSBUWVBFX1ZGSU9fSU9NTVVfSU9NTVVGRCBUWVBFX1ZGSU9fSU9NTVUgIi1pb21tdWZkIg0KPg0K
PiAjZGVmaW5lIFZGSU9fSU9NTVUob2JqKSBJTlRFUkZBQ0VfQ0hFQ0soVkZJT0lPTU1VLCAob2Jq
KSwNCj5UWVBFX1ZGSU9fSU9NTVUpDQo+IERFQ0xBUkVfQ0xBU1NfQ0hFQ0tFUlMoVkZJT0lPTU1V
Q2xhc3MsIFZGSU9fSU9NTVUsDQo+VFlQRV9WRklPX0lPTU1VKQ0KPmRpZmYgLS1naXQgYS9ody92
ZmlvL2NvbW1vbi5jIGIvaHcvdmZpby9jb21tb24uYw0KPmluZGV4DQo+MjMyOWQwZWZjOGMxZDYx
N2YwYmZlZTUyODNlODJiMjk1ZDJkNDc3ZC4uODlmZjFjN2FlZGExNGQyMGIyZTI0Zg0KPjhiYzI1
MWRiMGE3MWQ0NTI3YyAxMDA2NDQNCj4tLS0gYS9ody92ZmlvL2NvbW1vbi5jDQo+KysrIGIvaHcv
dmZpby9jb21tb24uYw0KPkBAIC0xNTA4LDcgKzE1MDgsNyBAQCBpbnQgdmZpb19hdHRhY2hfZGV2
aWNlKGNoYXIgKm5hbWUsIFZGSU9EZXZpY2UNCj4qdmJhc2VkZXYsDQo+DQo+ICNpZmRlZiBDT05G
SUdfSU9NTVVGRA0KPiAgICAgaWYgKHZiYXNlZGV2LT5pb21tdWZkKSB7DQo+LSAgICAgICAgb3Bz
ID0gJnZmaW9faW9tbXVmZF9vcHM7DQo+KyAgICAgICAgb3BzID0NCj5WRklPX0lPTU1VX0NMQVNT
KG9iamVjdF9jbGFzc19ieV9uYW1lKFRZUEVfVkZJT19JT01NVV9JT01NVUYNCj5EKSk7DQo+ICAg
ICB9DQo+ICNlbmRpZg0KPg0KPmRpZmYgLS1naXQgYS9ody92ZmlvL2lvbW11ZmQuYyBiL2h3L3Zm
aW8vaW9tbXVmZC5jDQo+aW5kZXgNCj44N2E1NjFjNTQ1ODBhZGM2ZDdiMjcxMTMzMWEwMDk0MGZm
MTNiZDQzLi44MDdiZTI1NDVlYjE0N2E2ZmFjOTcNCj4zNzUyY2YzN2VlZWRlMWE0ZmY2IDEwMDY0
NA0KPi0tLSBhL2h3L3ZmaW8vaW9tbXVmZC5jDQo+KysrIGIvaHcvdmZpby9pb21tdWZkLmMNCj5A
QCAtMzE5LDYgKzMxOSw4IEBAIHN0YXRpYyBpbnQgaW9tbXVmZF9jZGV2X2F0dGFjaChjb25zdCBj
aGFyICpuYW1lLA0KPlZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPiAgICAgaW50IHJldCwgZGV2ZmQ7
DQo+ICAgICB1aW50MzJfdCBpb2FzX2lkOw0KPiAgICAgRXJyb3IgKmVyciA9IE5VTEw7DQo+KyAg
ICBjb25zdCBWRklPSU9NTVVDbGFzcyAqaW9tbXVmZF92aW9jID0NCj4rDQo+VkZJT19JT01NVV9D
TEFTUyhvYmplY3RfY2xhc3NfYnlfbmFtZShUWVBFX1ZGSU9fSU9NTVVfSU9NTVVGDQo+RCkpOw0K
Pg0KPiAgICAgaWYgKHZiYXNlZGV2LT5mZCA8IDApIHsNCj4gICAgICAgICBkZXZmZCA9IGlvbW11
ZmRfY2Rldl9nZXRmZCh2YmFzZWRldi0+c3lzZnNkZXYsIGVycnApOw0KPkBAIC0zNDAsNyArMzQy
LDcgQEAgc3RhdGljIGludCBpb21tdWZkX2NkZXZfYXR0YWNoKGNvbnN0IGNoYXIgKm5hbWUsDQo+
VkZJT0RldmljZSAqdmJhc2VkZXYsDQo+ICAgICAvKiB0cnkgdG8gYXR0YWNoIHRvIGFuIGV4aXN0
aW5nIGNvbnRhaW5lciBpbiB0aGlzIHNwYWNlICovDQo+ICAgICBRTElTVF9GT1JFQUNIKGJjb250
YWluZXIsICZzcGFjZS0+Y29udGFpbmVycywgbmV4dCkgew0KPiAgICAgICAgIGNvbnRhaW5lciA9
IGNvbnRhaW5lcl9vZihiY29udGFpbmVyLCBWRklPSU9NTVVGRENvbnRhaW5lciwNCj5iY29udGFp
bmVyKTsNCj4tICAgICAgICBpZiAoYmNvbnRhaW5lci0+b3BzICE9ICZ2ZmlvX2lvbW11ZmRfb3Bz
IHx8DQo+KyAgICAgICAgaWYgKGJjb250YWluZXItPm9wcyAhPSBpb21tdWZkX3Zpb2MgfHwNCj4g
ICAgICAgICAgICAgdmJhc2VkZXYtPmlvbW11ZmQgIT0gY29udGFpbmVyLT5iZSkgew0KPiAgICAg
ICAgICAgICBjb250aW51ZTsNCj4gICAgICAgICB9DQo+QEAgLTM3NCw3ICszNzYsNyBAQCBzdGF0
aWMgaW50IGlvbW11ZmRfY2Rldl9hdHRhY2goY29uc3QgY2hhciAqbmFtZSwNCj5WRklPRGV2aWNl
ICp2YmFzZWRldiwNCj4gICAgIGNvbnRhaW5lci0+aW9hc19pZCA9IGlvYXNfaWQ7DQo+DQo+ICAg
ICBiY29udGFpbmVyID0gJmNvbnRhaW5lci0+YmNvbnRhaW5lcjsNCj4tICAgIHZmaW9fY29udGFp
bmVyX2luaXQoYmNvbnRhaW5lciwgc3BhY2UsICZ2ZmlvX2lvbW11ZmRfb3BzKTsNCj4rICAgIHZm
aW9fY29udGFpbmVyX2luaXQoYmNvbnRhaW5lciwgc3BhY2UsIGlvbW11ZmRfdmlvYyk7DQo+ICAg
ICBRTElTVF9JTlNFUlRfSEVBRCgmc3BhY2UtPmNvbnRhaW5lcnMsIGJjb250YWluZXIsIG5leHQp
Ow0KPg0KPiAgICAgcmV0ID0gaW9tbXVmZF9jZGV2X2F0dGFjaF9jb250YWluZXIodmJhc2VkZXYs
IGNvbnRhaW5lciwgZXJycCk7DQo+QEAgLTQ3Niw5ICs0NzgsMTEgQEAgc3RhdGljIHZvaWQgaW9t
bXVmZF9jZGV2X2RldGFjaChWRklPRGV2aWNlDQo+KnZiYXNlZGV2KQ0KPiBzdGF0aWMgVkZJT0Rl
dmljZSAqaW9tbXVmZF9jZGV2X3BjaV9maW5kX2J5X2RldmlkKF9fdTMyIGRldmlkKQ0KPiB7DQo+
ICAgICBWRklPRGV2aWNlICp2YmFzZWRldl9pdGVyOw0KPisgICAgY29uc3QgVkZJT0lPTU1VQ2xh
c3MgKmlvbW11ZmRfdmlvYyA9DQo+Kw0KPlZGSU9fSU9NTVVfQ0xBU1Mob2JqZWN0X2NsYXNzX2J5
X25hbWUoVFlQRV9WRklPX0lPTU1VX0lPTU1VRg0KPkQpKTsNCj4NCj4gICAgIFFMSVNUX0ZPUkVB
Q0godmJhc2VkZXZfaXRlciwgJnZmaW9fZGV2aWNlX2xpc3QsIGdsb2JhbF9uZXh0KSB7DQo+LSAg
ICAgICAgaWYgKHZiYXNlZGV2X2l0ZXItPmJjb250YWluZXItPm9wcyAhPSAmdmZpb19pb21tdWZk
X29wcykgew0KPisgICAgICAgIGlmICh2YmFzZWRldl9pdGVyLT5iY29udGFpbmVyLT5vcHMgIT0g
aW9tbXVmZF92aW9jKSB7DQo+ICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiAgICAgICAgIH0NCj4g
ICAgICAgICBpZiAoZGV2aWQgPT0gdmJhc2VkZXZfaXRlci0+ZGV2aWQpIHsNCj5AQCAtNjIxLDEw
ICs2MjUsMjQgQEAgb3V0X3NpbmdsZToNCj4gICAgIHJldHVybiByZXQ7DQo+IH0NCj4NCj4tY29u
c3QgVkZJT0lPTU1VT3BzIHZmaW9faW9tbXVmZF9vcHMgPSB7DQo+LSAgICAuZG1hX21hcCA9IGlv
bW11ZmRfY2Rldl9tYXAsDQo+LSAgICAuZG1hX3VubWFwID0gaW9tbXVmZF9jZGV2X3VubWFwLA0K
Pi0gICAgLmF0dGFjaF9kZXZpY2UgPSBpb21tdWZkX2NkZXZfYXR0YWNoLA0KPi0gICAgLmRldGFj
aF9kZXZpY2UgPSBpb21tdWZkX2NkZXZfZGV0YWNoLA0KPi0gICAgLnBjaV9ob3RfcmVzZXQgPSBp
b21tdWZkX2NkZXZfcGNpX2hvdF9yZXNldCwNCj4rc3RhdGljIHZvaWQgdmZpb19pb21tdV9pb21t
dWZkX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLCB2b2lkICpkYXRhKQ0KPit7DQo+KyAg
ICBWRklPSU9NTVVDbGFzcyAqdmlvYyA9IFZGSU9fSU9NTVVfQ0xBU1Moa2xhc3MpOw0KPisNCj4r
ICAgIHZpb2MtPmRtYV9tYXAgPSBpb21tdWZkX2NkZXZfbWFwOw0KPisgICAgdmlvYy0+ZG1hX3Vu
bWFwID0gaW9tbXVmZF9jZGV2X3VubWFwOw0KPisgICAgdmlvYy0+YXR0YWNoX2RldmljZSA9IGlv
bW11ZmRfY2Rldl9hdHRhY2g7DQo+KyAgICB2aW9jLT5kZXRhY2hfZGV2aWNlID0gaW9tbXVmZF9j
ZGV2X2RldGFjaDsNCj4rICAgIHZpb2MtPnBjaV9ob3RfcmVzZXQgPSBpb21tdWZkX2NkZXZfcGNp
X2hvdF9yZXNldDsNCj4gfTsNCj4rDQo+K3N0YXRpYyBjb25zdCBUeXBlSW5mbyB0eXBlc1tdID0g
ew0KPisgICAgew0KPisgICAgICAgIC5uYW1lID0gVFlQRV9WRklPX0lPTU1VX0lPTU1VRkQsDQo+
KyAgICAgICAgLnBhcmVudCA9IFRZUEVfVkZJT19JT01NVSwNCj4rICAgICAgICAuY2xhc3NfaW5p
dCA9IHZmaW9faW9tbXVfaW9tbXVmZF9jbGFzc19pbml0LA0KPisgICAgICAgIC5jbGFzc19zaXpl
ID0gc2l6ZW9mKFZGSU9JT01NVUNsYXNzKSwNCj4rICAgIH0sDQo+K307DQo+Kw0KPitERUZJTkVf
VFlQRVModHlwZXMpDQo+LS0NCj4yLjQzLjANCg0K

