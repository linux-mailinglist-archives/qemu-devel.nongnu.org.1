Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9742172F25C
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 04:01:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Fni-0008Fu-Nl; Tue, 13 Jun 2023 21:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongwei.ma@intel.com>)
 id 1q9Fnh-0008Fm-CK
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:59:57 -0400
Received: from mga02.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongwei.ma@intel.com>)
 id 1q9Fnf-0003s3-65
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686707995; x=1718243995;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YNvTDul6HQEj1VcGt4px/OORA5ACA7+RruCnihs4EY8=;
 b=Ed/OI5WmzWtgXWldt0cG9ZJibXvUwiz5tIPhmeQxCNDTL0K5aDTCVxsL
 Pjx01ZdpAQtDNDvI8wvJr7A4sYjB2sx/8mEwiGgR73ttK7JWlRhaUqSIG
 mwOjfaUXVZPk4ehjqlnRf7qFrrqglWq27ZV0xRFwhi1teOlzIDRhwz4MH
 qh1wNMtCDA5Noxh/mxfldkIUkIckgzjIQUkqwixeEF264wyfz8G+ce6Eo
 AdNOhQBT0ZI3ArhTluBvlXWDeeYRdLU4TJb8ls74lVx7If+px8lonuppY
 GwRN+V/sRwvls8VpHByPHBb8J7gF/igLIgd0Ge5xWO15kL2GZz+O2OZDs g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348157240"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; d="scan'208";a="348157240"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2023 18:59:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="706026471"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; d="scan'208";a="706026471"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga007.jf.intel.com with ESMTP; 13 Jun 2023 18:59:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 18:59:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 18:59:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 18:59:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 18:59:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5g+Ssg74/65vZNChPSdUZJYIRy0Lf4ijO/A3KaRfoQxqu/FuQ2E1g2Eea/G1QiqMEqNHDMlPFyEeKa1QpeyoBVP6AMJzy5kI5upWjefKcA+12Ujyie8fucih/aBQrXwpmgOScFo4JfiM131l5EydAOwKNtJ3xRI4M5pQC2G0kwOluugh7XMLHzYrhzDGwRdN1LhjqxJbhQ69SnmV6QW/QoO7yzBWKTZQUeVOno1k5ttyrxLuDEyTmTcEBVBYlCZiSk+B35rF/JSCY+XUd/jDNef6ksKdEhLg7x6JUV91hq41LqpTuphu2fmbQ7TMqdBqwmcgNDl+4q9T9sb4im/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNvTDul6HQEj1VcGt4px/OORA5ACA7+RruCnihs4EY8=;
 b=khZuZhstel0aIP7D/3JO8qcGcqfGaBAxx9Urlw9rzx2Lqk6yclgOjXVBJYuJp6smIVcbCVTN6bolKgLybDBYA43g+2JJcy5JGFdbrVYPMwP/21KT3/+BF7ZkPUlFvclbF0d98WMqQG5AFBUqK+cfa3HM39kZAO0Bd1j4/pVgnM098ss6AKl73xegG6lILBugBSzTPOVZpnqv4qvlWIM5Eqneyju0yBilWHpdIoLvLRm2LAJhwpMq3jJU/iiFnBiKXBbU5G6QS1ci65M8Q468SWqs+MCgz9OcEPZFge0B9/n//2mlH49FEUlmKe5l+lr0KBeeeA18y67EaGazm+Jeqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5368.namprd11.prod.outlook.com (2603:10b6:208:311::17)
 by MW4PR11MB7079.namprd11.prod.outlook.com (2603:10b6:303:22b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Wed, 14 Jun
 2023 01:59:42 +0000
Received: from BL1PR11MB5368.namprd11.prod.outlook.com
 ([fe80::24f7:be2d:5d10:11b7]) by BL1PR11MB5368.namprd11.prod.outlook.com
 ([fe80::24f7:be2d:5d10:11b7%5]) with mapi id 15.20.6455.045; Wed, 14 Jun 2023
 01:59:42 +0000
From: "Ma, Yongwei" <yongwei.ma@intel.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
CC: Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, Babu Moger <babu.moger@amd.com>, "Liu,
 Zhao1" <zhao1.liu@intel.com>
Subject: RE: [PATCH v2 00/17] Support smp.clusters for x86
Thread-Topic: [PATCH v2 00/17] Support smp.clusters for x86
Thread-Index: AQHZncthGOwhVCwXt0CYee8Y0soNnq+Ji/9g
Date: Wed, 14 Jun 2023 01:59:42 +0000
Message-ID: <BL1PR11MB5368F7A3E16D9DDD5E4F3BD5895AA@BL1PR11MB5368.namprd11.prod.outlook.com>
References: <20230529123101.411267-1-zhao1.liu@linux.intel.com>
 <ZIghamzyQD9IdbjO@liuzhao-OptiPlex-7080>
In-Reply-To: <ZIghamzyQD9IdbjO@liuzhao-OptiPlex-7080>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5368:EE_|MW4PR11MB7079:EE_
x-ms-office365-filtering-correlation-id: 6d144759-de96-4834-3b74-08db6c7b04fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XNEhQSWbmJIqytwolkU5XdIiBrOlUvOaR4NPWzfdu+qDrM/POuM2MYawK/vFke+kXFQHjQ+lXNum23OLVEkFjK8aCD77xYCF389CoQ79YM3W9RU0R2c6UW6zMERUc2k03rRSydzPQPsBDW24R42xLobO+S7WNpnbUkpIRt8gwUscA23IjHUjKjad4jDEiyLLPT2c+eiFMvRkIcs5MZnjY2GdyoVDMcFpbbd9axbRWR7JkqGcNAUy0DJOfG+Kg1Qo+hU5s2tQIHDc425b3vUshCqiJ7rQfY8o76B6ynwTc7u7CU6WkMD/ujpAJp9okjRKzMHvQWPyc0lqAvM/rWi+hfFzozFBuDciyuyGCJCXbKGRb3KpeJ/oEvLmSmsbSXVtOzTYbttlMPEvmyuem/+e9vurH4CGU6rldidzcHDzyKLiNX4hxp5oOmFlAkFgyXy4Q6HbV26Z+bBaxJ1KlJhTCPbvI5onyydR5pKl7FLu6R8rgE8fPs4rps5PRL49ScKzpAOn92w2KAtmu95ARttkA8+LbifTHIRedXwWqbqVB4K9uj8EwXWGkRhdwijci53RcUC2Jweuaa4QIhcq91kwFzp7ujaaLi1msdDrc2v/PtQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5368.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199021)(26005)(8936002)(86362001)(478600001)(6506007)(9686003)(71200400001)(2906002)(186003)(8676002)(966005)(41300700001)(7696005)(66899021)(316002)(64756008)(52536014)(76116006)(5660300002)(33656002)(66946007)(38070700005)(55016003)(54906003)(66476007)(6916009)(66446008)(4326008)(66556008)(7416002)(122000001)(82960400001)(38100700002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iheEdLh5a3FiO0Y+mRb7Kzex7GRf/Dfy8GwTRdor297Kv3eteFvDFHNJoK?=
 =?iso-8859-1?Q?c+R/bSkkiR5agYAuzBpBzmAODKvcEpLwkbldJXumWsOFV3Y+AVsCwtj8Oa?=
 =?iso-8859-1?Q?5wwQg8ZmH5Aib2E7XBPpMLWee5/b3oKDMpnzajbKey7Hh57oQNVN84WjLt?=
 =?iso-8859-1?Q?XEXXdfWVxKevBFebOY5PjTyUxE2gBOcGtDd8MO8ujmJ6q8U0XFU1USo3tw?=
 =?iso-8859-1?Q?RRQ2KrfQfPQK97pEvDjMF85r2S4S9OVIMZiOdnhc5psEAsgnFuHUz+Wn8X?=
 =?iso-8859-1?Q?DHi1fObiZDLfZxgiL7dF+dG6tQJTl57YcLwgxxINlPdJORc3966DYWA4CP?=
 =?iso-8859-1?Q?FVNDKEMo+u3yTAvN8bc6v5dsA9l5HLPJbQ5t/4uyGSn8od/gdvZX/2R6l0?=
 =?iso-8859-1?Q?2yOyjMaJHGtgTTKTZ51+a81+m/PL76P8YKJ3Vgx+zZAQZ01Fy1xs8FXCG1?=
 =?iso-8859-1?Q?cm0rLBA7h3iZjjI72y7BoDCRkdyU6LCUhbadFtm+el2oUKo7dyQ3avRw5I?=
 =?iso-8859-1?Q?aNdreWe2xF8l3ovVj0TBj5Mr7NUrqOjT/y/yBOHHFT2T6P7ocXnMFrEfGN?=
 =?iso-8859-1?Q?FZJXErNJ5rKc7aO8Ing2HT2senC6xPj66H42hjN2k31evHezUPg+neyMea?=
 =?iso-8859-1?Q?/TZMLvc9NZrmTamxtv2CBcaWjEXq1xohKF2t0JnpbImB7yj21PNcnAq4L7?=
 =?iso-8859-1?Q?iey/eYnOiqBHzjFBKWJsycJJd1ap/ioJZaT9ELYG/hEuRe9jcIHXFTegjY?=
 =?iso-8859-1?Q?fL+xC1z6ipRCW/4aiLdqJhPXdQFSzTMext9N2UKz8Ehw2mpX58BbSTqDxy?=
 =?iso-8859-1?Q?xvf+kxBtW3mr/MdMIZF+5vNoAfUcUFYrjn/9EKb+cJ2nTblL1uLXeXXYjp?=
 =?iso-8859-1?Q?34JX7nlg6kMyWjvrTzOdX7JmnnLbuD8NcV/+YEEj+Gb5w/6AvV17fs29m3?=
 =?iso-8859-1?Q?8dX7rOEP51htWWXZ6G8/Ygu74KTA5dKe/2t8bC2of0Mb9ETPXMzG78ktfE?=
 =?iso-8859-1?Q?UZzdHda3fIZJcqSfvL7SLS86SbsI3FlPvzRr/2/jwRf22SsMcLimmbN8/j?=
 =?iso-8859-1?Q?53lXk/YIDxswYE0injgiAwfOGfCalDwPzKS8sjtPFf/EzryDov2+vHDzEW?=
 =?iso-8859-1?Q?TGah3gpEuTS27z6TFOCXb0NrbePocMt4OPLyO1xhojOIZG+cTJbmrZMaSu?=
 =?iso-8859-1?Q?BbPfQviAeP4mX7y8PgYuPpDhWTGv7byn1R4YyKxpvXdITFV9tSHN7lrpqi?=
 =?iso-8859-1?Q?v8VxLHk3fcYFyFAellksVBgitjoMGDGct4u/g6t3NKJTdy2OROhU9W7p1Q?=
 =?iso-8859-1?Q?X62QpW4pDIJudkuRqg8h/MTJ97CB2tZFlL6dJCXcQA1a42fTFTIVNgiLKa?=
 =?iso-8859-1?Q?EmQ/FMXyqsHpwu3qsmMigQD5lwDu0YZdcmGqLYaJcsb4DCThdkUpEHifWJ?=
 =?iso-8859-1?Q?TEc+15R6b9nuhhq+a1N9vj1T32Rf6qxmDsFym35tdFYYk6lI9yZoarfnWd?=
 =?iso-8859-1?Q?kBtRAPh1xHafDheqSIpHEFAHt79OgNivPWsEX92Xc1FMAi6KHYy1iUEQda?=
 =?iso-8859-1?Q?G9ToZ0C/u0AnWXgw8S1wlc3MblPhWzSw8unIOtrNHuSP1Rj0NfIeffiJJA?=
 =?iso-8859-1?Q?OgEmwf2hW5I4zkygsWDxyeBDQwyHz1fiG3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5368.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d144759-de96-4834-3b74-08db6c7b04fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 01:59:42.3325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OFwbSewl3GYqRtbSSv+k6xrkF4zXMYDyjoJxtz3/gd1hkNOEPwwPWm8Quvv2CfwPf2oLCPm6Ypa5soqcDkthEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7079
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20; envelope-from=yongwei.ma@intel.com;
 helo=mga02.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On Mon, May 29, 2023 at 08:30:44PM +0800, Zhao Liu wrote:
> > Date: Mon, 29 May 2023 20:30:44 +0800
> > From: Zhao Liu <zhao1.liu@linux.intel.com>
> > Subject: [PATCH v2 00/17] Support smp.clusters for x86
> > X-Mailer: git-send-email 2.34.1
> >
> > From: Zhao Liu <zhao1.liu@intel.com>
> >
> > Hi list,
> >
> > This is the our v2 patch series, rebased on the master branch at the
> > commit ac84b57b4d74 ("Merge tag 'for-upstream' of
> > https://gitlab.com/bonzini/qemu into staging").
> >
> > Comparing with v1 [1], v2 mainly reorganizes patches and does some
> > cleanup.
> >
> > This series add the cluster support for x86 PC machine, which allows
> > x86 can use smp.clusters to configure the modlue level CPU topology of
> > x86.
> >
> > And since the compatibility issue (see section: ## Why not share L2
> > cache in cluster directly), this series also introduce a new command
> > to adjust the topology of the x86 L2 cache.
> >
> > Welcome your comments!
> >
> >

[snip]

>=20
> Could you please attach the test results?
>=20

Tested module level APID 'test-x86-topo' cases and 'x-l2-cache-topo'
 based on CPUID on Intel platform.
Result looks good hence,

Tested-by: Yongwei Ma <yongwei.ma@intel.com>

Best Regards,
Yongwei Ma

