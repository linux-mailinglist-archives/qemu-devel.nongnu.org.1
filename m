Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E33D728E99
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 05:33:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7SrC-0004NG-Ae; Thu, 08 Jun 2023 23:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q7SrA-0004N5-7l
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 23:32:08 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q7Sr6-00032s-I9
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 23:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686281524; x=1717817524;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ynPfgKU65rDa7a4punmXTGUPSRMx60Hw4MPBq8Xedhs=;
 b=hwh3I3H7Nv3fmYz3QxxDKW73Iu3Oz+BBJHxT+vQEXvtpAyvdNPBR4+Wp
 bMPA6ExDsu823SHoIL4A5iEK/stclU/uoXLkHVi3IlT2hZjvn2M0LnDC+
 wuiKsGf6fok+J6HPy6d3tOWSdS2N4QQD0OyLwwwx7eKWB4W6ObPqSNM+u
 0/0YyNcfr7u0sS2pM7QJZec7pz7vj6GnBkLSQJUSlZ6EhVbpDuVk3yycs
 PLjKJqqOzMyLCnTqkXlvkFfvO/1jIVYgT1pJGeZl32tvZDrUy2/pXsvgF
 H0GvOCEHIe0ClWsApynBquG7dZQen/F/jbZVQy7SJKyMdjOEZRLORWI0z Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="337858392"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="337858392"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2023 20:31:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="687601810"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="687601810"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga006.jf.intel.com with ESMTP; 08 Jun 2023 20:31:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 20:31:48 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 20:31:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 20:31:47 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 20:31:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsgdNiU5d3blFYYfXS/yELgNxpQrqv4526b2330KwNqiOL+Oibz5cfV2x3KDMM8O49hbfImzX9UqW06puO4XHDJi/gXWJ9lvO9Yh4fDlsVZoN9lbWjQeYRjaVE1sRVS7jM7+MDVLkBeS+0AQ0aHVH6i96UD5fWA7SumPouMpvox2jRby47adayZWCwiKcD62wBY23eOblHP1pZsNDtPTdD0XTv3kDK6AEzRofWFgnMnKGiLz/McDeIIE4tZMsuxkGgQBURV7T1TTmw9ehsb5Ndbr76FZhUQd294zvMRrplb5GLCCWKtFuTE9TOtgZ4btxniLjEf7V7YCwJQASfTrMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynPfgKU65rDa7a4punmXTGUPSRMx60Hw4MPBq8Xedhs=;
 b=M04tq7+MfHub3IGQeUGTrVUT3s9CZ9uwnfiIHz+TbGccp11q4ZO+OgXtGkq69ZODQP4ZgrhIKDccrUev+H9yBWafzoEa7E6Acg9rrO53m6eU8+xG77M8fGBRzcCCqb8CiPOOmgft8O7EgNo0TAFv3STgMBMjw61dV4NvPFaPdPUaJcnIIR+/hoer6SCwP80GYuW+Cde9tMrxyyIPOS8bh7c7qcHOvNezgGvQXL/XdWvOkSswmRl1QQ44RHl75XGYqb2RkpW8SpFO9HBM+oxNqYfpycw7UQ1Anei5nxUjIWa3ADADZnRXDhcay66s6skcCFTUt0ktc2yFXGz8DkhJXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS7PR11MB6013.namprd11.prod.outlook.com (2603:10b6:8:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 03:31:46 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%7]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 03:31:46 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, 
 Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 4/5] intel_iommu: Fix address space unmap
Thread-Topic: [PATCH v3 4/5] intel_iommu: Fix address space unmap
Thread-Index: AQHZmfDJNompAIYbQUyvLWtPpjv+/K+A68sAgADmDmA=
Date: Fri, 9 Jun 2023 03:31:46 +0000
Message-ID: <SJ0PR11MB6744928AFD8CCB2C8C78D7959251A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-5-zhenzhong.duan@intel.com> <ZIHcEMO2ZWp636t+@x1n>
In-Reply-To: <ZIHcEMO2ZWp636t+@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS7PR11MB6013:EE_
x-ms-office365-filtering-correlation-id: 1e44df79-9639-4aca-a48b-08db689a0da9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uXr4/uaTzxB2vVZH0+L+n8HVd2Kt1481Ie/0CeifoYQtK3bWSDoyur0XBfZuHsLbO6n/DcgTwHWZqLyRPzEMfoNCBHDwJc3Mb+3IyhjuyX0arZFjHg0XNwz4TZXNscTJeV5bxyP1x6GYUIrW7AiWLaPbCP/AKgQugNYHUByUA4QnnSAHnvwMlTX5wkmtsNG2Ti58JscvXqo1JBQH4e8aNudkhovh0wWamC3Doq3aho5AoxizCfrJstZPzhARAgetU/45omLB/jL/ylyeyU3gnE7GlFsDKwYO/emQVCfL9DFuPWvIgiyUjfmLAgAJ53aewEq8HYDTCQ5Ihwfasv5d/snDSjwVyIjuAPvxOW8BdGdaEdWeyx009y+rf00quJj3EXeSeeTjLJ0pm6GMHxU83pqCTshxP3cNiggVKsB+RUgJsLn9EFwo8hIuPKxD1KRJ4iPGdHEkOOHi+RwO+/izWu/Ih2hUZcvkJWhwKKeWO9BpFxmsjzdH/YE/QnBeCRj8czFzf4cq8CnUOuz/uP9uTRZjPVfoPH2QieOOJnMJdRLdP0QL05cxfLxOU+9cCfpzCTdgk5pYzryA0naQhq6JQ5ruITL2PaPCZqryjeuVsHJxqAFg4uy5VZG/XpdAmAlx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199021)(107886003)(9686003)(38100700002)(6506007)(41300700001)(7696005)(26005)(83380400001)(186003)(71200400001)(478600001)(54906003)(64756008)(122000001)(66446008)(4326008)(316002)(55016003)(66946007)(82960400001)(76116006)(8676002)(66556008)(7416002)(66476007)(6916009)(52536014)(8936002)(2906002)(5660300002)(38070700005)(33656002)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEJTOEkwaDBMNmdvMUZPZ1M3RDZ0YVJEa0k1b2o4R1hNMEp0d0lVQWZpTDNE?=
 =?utf-8?B?RldRczQ4RkZjc2ZIWTNxQ083bmNCTXNpZjVyZDBiK1JUak1zYTl3RHA5cVBy?=
 =?utf-8?B?VXNBbTFkTzNzVGVwWERqMVptMG9mTk9GNzNVakZEcEdzbDRQRmtpRmNuaEFQ?=
 =?utf-8?B?U0RyMytQUkpHcVduQkJFRmlxRWtaMDFxdXFSRGxvNXNCUlZDYWMxUC9SSXIx?=
 =?utf-8?B?TVNTUnN0Vk5LcXFnUlByMDZvbnNXTmFhUkNFZW0xZTlBdkNyT3RDTlpnbWUv?=
 =?utf-8?B?QnhtSUNqUkR1OHlpeEpRZnVreE84bitXUHV5WGFYYXVIQm5wT2E5eXA4bitU?=
 =?utf-8?B?b29sZVRUMU1hbnFIQ1crRkx1UFQ4RmFOcXNTVTB6QUNSWDNyYWJ5bEszN25w?=
 =?utf-8?B?NjZnNW1YNTBIV0w5a1F5KytLTXZZdGgzUWVET0hJakdqV1FDKzdBR3FqYXhy?=
 =?utf-8?B?alNjWGFUSEE3VDVKZ0ZWNm5xUWFCd1kzQmZZSGVaTmdhUXdyb3lRWDFWSTJ1?=
 =?utf-8?B?VHhyYmh4cDRZc3dzYW83c3N3UDZSKzBWbEJxdlJHdEVySkdmMTFOVFp6Vkgw?=
 =?utf-8?B?WmJRam1TSEtjTlMxNzRBRGZ1VjR0UkpZeTVrc2l1bTRsaWRoV09taGt5R2NI?=
 =?utf-8?B?dXlkYmJvcDFjcDI2Q2FvUU5GdjI2YjRQR1dyTGpJY09ZZXhTNU00T1lIZ0hG?=
 =?utf-8?B?ZVdiVTg3amFjVTcyaUpiTUx2dEcvbUsrdFI1SHN2QmJDVGl2dVNSbWwveStV?=
 =?utf-8?B?SnQ5eW92aks4WGxld1FtM0FxTXl5UXZ5VWk4NVg4UHdaY1dEdEpEbkFZZW5C?=
 =?utf-8?B?QklZUStUVUFkWmF6bm9hcUZJUW5ibkxPRXJXanc5dmtWeHE1R1lhT0dtT1RE?=
 =?utf-8?B?UFplN2pnZ3dWbjVYNWhndUE1b2V1V3l5ZG1TNkdHb2l3M2czMlk4UGZiWk5i?=
 =?utf-8?B?R29qRkZza1dOM09iZ2czeG5UbEhqRDUyd0d5Q213a2x2VjEydFFLbkViRDcr?=
 =?utf-8?B?MTk5aVNQQTVGK1dRaXQzTi9mN2x5c1hpeVc3YjViVGhWdDI3K2xidk5RYnRv?=
 =?utf-8?B?Y0U4dnlzdklWQTI3NTJka3h3d2NBcGt4VTJMeFlxR09JOHZWN0ZHeDZEV2R0?=
 =?utf-8?B?TjdJdFBDck02YTBsZGJ6YlpGb2xuRlhQc2p3MUJKdUVnc21IZHJWRGxwZU8z?=
 =?utf-8?B?YmlMa1JHWlpJdUkrZWxkaUd3UGhFVkpXZWVoSFA2cXY3Smo0VGpLTTBDMXEz?=
 =?utf-8?B?VGZsZWF1N0NlSWVZMkNPOGFML0RnMkwwdFhuWVhTTHg3K3p3dTFVV3cwWGla?=
 =?utf-8?B?dFdVNGxoRE80alRrMm9RN0t0akxuVFF4c0JzZjR6aHErNWJUamVmMVdKQjBQ?=
 =?utf-8?B?WDFwQm5aUzU0TTJVRmZXY3pkTWt1VnZaTXBiSnBwQWw5d25Ld0xUU3RSRWlp?=
 =?utf-8?B?RkUzaDZITUswUkppbDM0aFlyTmFSdkxRNzh6QTZpVVQxbi80TTZ3UkpUeXBS?=
 =?utf-8?B?b00rTGptS09yNTA1c0NMV2syN0VwLzhYclRvODZNQVBmK0RPY0FoUUNBV0dV?=
 =?utf-8?B?VGZwVjErbmU3VlFLNmhrTEh4TjgvSEIyQ2JEb29JSUkrMExYd0lXNGNCeTYr?=
 =?utf-8?B?NTdvczM3QmRZMGMxR2dFa2FMLzloN1IyNTZvdlFnMnlKWTdZS0Rid3M1T1lj?=
 =?utf-8?B?ckppUm4yQ0ZUa2tCY1dBK3ZYbGc5KzVWaWR2TGJVMjJtZEN0d3JSc2N3amNl?=
 =?utf-8?B?eGYvN1RHc3BYbG1kVHNHTmlvM04yVHMzSWU5NUVLVjlQMXRRaWhWcXV4U1Ux?=
 =?utf-8?B?TXVYczhNdENyRlF6VTBFTHRJaWFmVnNtMmZmbWlaZ1hQeDhHMkhjWXloeDVV?=
 =?utf-8?B?STZFc3VPN3MxZzdObWNJZFVKejFublM3dFI4Z1psanhDNEkwWjBXaWZXV3Jm?=
 =?utf-8?B?bW9Gd2NTY2JGZ0pjYVRnOGFEcTVwQWpDeUJWZEIrU0lOVTVvTXJnREREeFNW?=
 =?utf-8?B?d2hyalN1R3ZSZ1J2KzNRZFU3MjYxNWpNN1A1NlZlbzhnMmJLMGx2WDlmY0Vi?=
 =?utf-8?B?NHVwWkFLbzVJeUE5SmwzVnBsRzFPak9BbXUxbmdGeWFvREhaRHUxVFpIekdT?=
 =?utf-8?Q?cXb2tRQeMnGsAe5GG8m22xQlN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e44df79-9639-4aca-a48b-08db689a0da9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 03:31:46.6361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tNjJMKUfP++UWwfC8onFQxnnNctxo3U2KIgPGA7UhWC7f/M0sSqfWqB36WXGLby3xg37XrI8wa4rD9HuVD2JXSTxPHoNpp/7MNwkptZ27uc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6013
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=zhenzhong.duan@intel.com; helo=mga17.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBldGVyIFh1IDxwZXRlcnhA
cmVkaGF0LmNvbT4NCj5TZW50OiBUaHVyc2RheSwgSnVuZSA4LCAyMDIzIDk6NDggUE0NCj5Ubzog
RHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Q2M6IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZzsgbXN0QHJlZGhhdC5jb207IGphc293YW5nQHJlZGhhdC5jb207DQo+cGJv
bnppbmlAcmVkaGF0LmNvbTsgcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsgZWR1YXJkb0Bo
YWJrb3N0Lm5ldDsNCj5tYXJjZWwuYXBmZWxiYXVtQGdtYWlsLmNvbTsgYWxleC53aWxsaWFtc29u
QHJlZGhhdC5jb207DQo+Y2xnQHJlZGhhdC5jb207IGRhdmlkQHJlZGhhdC5jb207IHBoaWxtZEBs
aW5hcm8ub3JnOw0KPmt3YW5raGVkZUBudmlkaWEuY29tOyBjamlhQG52aWRpYS5jb207IExpdSwg
WWkgTCA8eWkubC5saXVAaW50ZWwuY29tPjsgUGVuZywNCj5DaGFvIFAgPGNoYW8ucC5wZW5nQGlu
dGVsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDQvNV0gaW50ZWxfaW9tbXU6IEZpeCBh
ZGRyZXNzIHNwYWNlIHVubWFwDQo+DQo+T24gVGh1LCBKdW4gMDgsIDIwMjMgYXQgMDU6NTI6MzBQ
TSArMDgwMCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBEdXJpbmcgYWRkcmVzcyBzcGFjZSB1
bm1hcCwgY29ycmVzcG9uZGluZyBJT1ZBIHRyZWUgZW50cmllcyBhcmUgYWxzbw0KPj4gcmVtb3Zl
ZC4gQnV0IERNQU1hcCBpcyBzZXQgYmV5b25kIG5vdGlmaWVyJ3Mgc2NvcGUgYnkgMSwgc28gaW4g
dGhlb3J5DQo+PiB0aGVyZSBpcyBwb3NzaWJpbGl0eSB0byByZW1vdmUgYSBjb250aW51b3VzIGVu
dHJ5IGFib3ZlIHRoZSBub3RpZmllcidzDQo+PiBzY29wZSBidXQgZmFsbGluZyBpbiBhZGphY2Vu
dCBub3RpZmllcidzIHNjb3BlLg0KPg0KPlRoaXMgZnVuY3Rpb24gaXMgb25seSBjYWxsZWQgaW4g
Imxvb3Agb3ZlciBhbGwgbm90aWZpZXJzIiBjYXNlIChvciByZXBsYXkoKSB0aGF0IGp1c3QNCj5n
b3QgcmVtb3ZlZCwgYnV0IGV2ZW4gc28gdGhlcmUnbGwgYmUgb25seSAxIG5vdGlmaWVyIG5vcm1h
bGx5IGlpdWMgYXQgbGVhc3QgZm9yDQo+dnQtZCksIGhvcGVmdWxseSBpdCBtZWFucyBubyBidWcg
ZXhpc3QgKG5vIEZpeGVzIG5lZWRlZCwgbm8gYmFja3BvcnQgbmVlZGVkDQo+ZWl0aGVyKSwgYnV0
IHN0aWxsIHdvcnRoIGZpeGluZyBpdCB1cC4NCg0KTm90IHR3byBub3RpZmllcnMgYXMgdnRkLWly
IHNwbGl0cyBmb3IgdnQtZD8NCg0KVGhhbmtzDQpaaGVuemhvbmcNCj4NCj4+DQo+PiBUaGVyZSBp
cyBubyBpc3N1ZSBjdXJyZW50bHkgYXMgbm8gdXNlIGNhc2VzIGFsbG9jYXRlIG5vdGlmaWVycw0K
Pj4gY29udGludW91c2x5LCBidXQgbGV0J3MgYmUgcm9idXN0Lg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+DQo+UmV2aWV3
ZWQtYnk6IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4NCj4tLQ0KPlBldGVyIFh1DQoN
Cg==

