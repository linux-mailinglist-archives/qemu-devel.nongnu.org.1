Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7747B7BD1CA
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 03:26:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpf1k-0001M1-Jw; Sun, 08 Oct 2023 21:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qpf1b-0001Lc-GP
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 21:25:35 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qpf1X-0002Oy-EY
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 21:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696814731; x=1728350731;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=OwH2ym7h9fvDDGDxndgNzhEtDA3PdZ2wMATGz8uNtPw=;
 b=aHkykQZeu1r89u1RbFUy/bcw/+h7pmetIBlysHrPUFPlxgWZF0GXCpYS
 4/MXkCTwNr2tGJv1+EKxNnY+VF9mkFe2cgDclov5t6I2jxkeFsSf7vPpb
 5bC2AP9xouT7Xm7ovAmXCTh4COV6/gX1IiYkh7kZWElO9biu7tx4VJUyB
 k1Rrl0Rlvbjv2ruq2JM7cZF6bdmpMRQrMvgSpxMS5zkylo+HYvS8YZ0BG
 pFMGfqN3TtKwongM8XLrr3g3JPWp/2C3nePEUhD3yJYeO+mtVlD662lJz
 wBuG9+BJEvCcadtGOxlRGvKn9PjMnaSmlWjAVvLEgjVQ0Ppv6In3TohVc Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="369111266"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; d="scan'208";a="369111266"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2023 18:25:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="869053071"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; d="scan'208";a="869053071"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Oct 2023 18:25:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 18:25:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 18:25:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 18:25:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 18:25:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZSh4HbbJ/6GzcYtYGznHXAKMvh26diZSPbZiAQCTRN7YXWuCzlI3mreXAhR3MYzriOb5FACSPeOCSt5xL43jWetBcODF+UZ4AtXo0fNuiC4o193PXsny7MNMuWqLY2eNGdxoA4DRMoDpuSOh4eoidjWzwRVIlejV9TjErC1YBBqBBNaMS1gcGnD9lyJv1LPR6Emy07gvyyN6rfLWyI4iEW1HsfpcmcJAQ6SFM8rSlQdEZFa6DUUjMHMwAiAt/ddxW3slNFa+prfO2Dzwl5/elq1TdIFLxr/+Njb7TYas/odYwgs6kj6VzQBWcOpxWgDwp7f8GwhLZppJZYfWlDwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwH2ym7h9fvDDGDxndgNzhEtDA3PdZ2wMATGz8uNtPw=;
 b=PdN/LgGtXT1P66OVTEODD8uN2ZTyxc264R0bOp7LrnHugv9LQGGMKYtwAdmcJ0lV7VhG23zmFVTG18RfoADYCmHjI7bWYROrStUMa5TLcs6wK/Ak5K9VrJQJah7GgiLaFn70bvToljjiuvsx45U9JI8GrFj1z2Pl0jTKQRx1chlYSsqQCa8lkEuTi9qhOzkUcSkFXuhS5ooOvhlusfwc8bdPxHKLPO1iNCtKb2BooDYktyS1Kt1CTGX/5bWUosUHBK3BsF56IqC1BO/KZSNykUb97QgYsdE7USP9C3dN4pDYVrrG5/mzOQSyOpZSZzvtDbEphH0L7bn+Nxvc8TS14Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by SA2PR11MB5148.namprd11.prod.outlook.com (2603:10b6:806:11e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 01:25:24 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a%3]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 01:25:24 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>, "aik@ozlabs.ru"
 <aik@ozlabs.ru>
Subject: RE: [PATCH v4 10/15] vfio/ccw: Use vfio_[attach/detach]_device
Thread-Topic: [PATCH v4 10/15] vfio/ccw: Use vfio_[attach/detach]_device
Thread-Index: AQHZ9tnw8//L3Tx/I0evXiAMnZMSkrA/ryVQgACBngCAAH3+IA==
Date: Mon, 9 Oct 2023 01:25:24 +0000
Message-ID: <PH7PR11MB67224BDF9E0837B921827C9892CEA@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20231004154518.334760-1-eric.auger@redhat.com>
 <20231004154518.334760-11-eric.auger@redhat.com>
 <PH7PR11MB67220561760B1AE2DB9277AA92CFA@PH7PR11MB6722.namprd11.prod.outlook.com>
 <4ac0b36c-bf7e-4f00-52f2-1499e75413e7@redhat.com>
In-Reply-To: <4ac0b36c-bf7e-4f00-52f2-1499e75413e7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|SA2PR11MB5148:EE_
x-ms-office365-filtering-correlation-id: 7d8bfab7-2866-498c-1cb2-08dbc8669c7d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZxXYE4PQUMUjmizYjXR08sRnLNBGWMpJBePrv0g2a/B2aeya3Bje+OSd3WGNrZYNO8HIybZLvONSp281Zch+ffaGIjLrikFYkNpmDtpOmpapFnPR+PNMEnM0FEaAm9ndQ5KFGk2zbPow60W/rOgs/jwaSsCZnRZBVOVw/5fMN7MJjKyhuAM64h3rcYZ8OLjPI/WR3blvB5Z7DrrfdGz5Mqp0cHCuj4QjGA3c0NKOTRj5fUQ8+v/ZZy12IRbMMtXmx2yvUnY0UZKSyoVQMEwg5fFGo8akJVBXYNBDqKpJ/n1EmE/hl8m3F0o+aiQkLE6El3oO+0MtKf5mUphR64SQDacPnZLXh1HNLuXogHvUXCL95+OrIP+yQvwc06nMP7uzVV0GjORfdVQpe/n8wqGrTkUMEe4I7haayFGv2us8mXPoQmcOx/3OEQ1NnCc/tIK8q2VtJ1MvYXJFTZM8Zw+Kiywn5PB4NOhr6vfqGbEkNgd3JkcJrZwur+HM/gVA/aWsDE9ISfxS9Srw3jmLWuzNDsjSY0UAmKWD05xolgPuk/uTpC5iXuk9ypwLv5UZrDoeSzUotcOfiVim6mWizt7hUpb/obck0vK94eOHWuCi+Nn2OEyUA1Y5Rgq2u5udM6x5EAOzt2490IutPTflVhv7yStncy5hHB4WZbWx0UY9b+t4oIqX6lDpdUwZtGPCGhkR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(346002)(366004)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(55016003)(83380400001)(26005)(66476007)(66556008)(66946007)(76116006)(110136005)(66446008)(316002)(64756008)(7416002)(8936002)(8676002)(5660300002)(52536014)(41300700001)(7696005)(6506007)(53546011)(71200400001)(9686003)(2906002)(45080400002)(966005)(478600001)(33656002)(38070700005)(38100700002)(82960400001)(921005)(122000001)(86362001)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2hTQTdXMTF1U0UvUUk3RzJwL2RqMjF1bXZYMUI3NmVBQ2tBdlgxTjZxY0or?=
 =?utf-8?B?dFZCcWVmT1lNdU9UcXdxU2cxOUdjOCtKbExVV1NmdGFjVlRzWlRSYWJHemEy?=
 =?utf-8?B?S0pNR0YzZnRkZzZjTldTUi9rSFVhZEtzVVRLdjR4UmtDNy9tc3ZoeWF5RUQ4?=
 =?utf-8?B?UTgrajBHSDhleDlzMmZySDhUQ3oycHZmeDBuR2Q3U0hGeW1GRWNWeEprUkIw?=
 =?utf-8?B?VUhZcUdib3QrbTdETG8raXMrY2tEVlVhSVB5ZnNJMHF2K0srNGxybVhSdG9M?=
 =?utf-8?B?eStaQ3pDQzc0NTl0VURGWkY2NnIvRTVFR0x0SUEwU1p6a3lHWEt5eWFNMFpT?=
 =?utf-8?B?aHNXdlkzdUtTanJHOEhjYnkvTmduVjRpSWJZanFSM1ByeDNjeVpuNFF2WkFF?=
 =?utf-8?B?L0pEMzlPYjdMOXZQb3NBcjFyOUJONzFWTDdaSlFyRzdPd0xOcTZrM2Y1aGNI?=
 =?utf-8?B?RHZxMGFvK0U2ODVWUFhLQm1EcnljaDFOVSszYTNEc2c5T21LNSt6b1ZqTWk4?=
 =?utf-8?B?SVR3OVk0aUM1SnFHZHlxMkNzTzIwK0Z6YmhoekZYYTBWVU4wV1dNQmRNNzBN?=
 =?utf-8?B?NVFndjlDVERtU2diNXFmZ0F2d1NDWmpNVmdnTFhKeEZhRmtvOUlBZllyTUQx?=
 =?utf-8?B?RE80RWdxZy90b2RPT3hjWjRFQVBiV1BPWi9PMVE4VlNNWVFQR1QwNW8weG5I?=
 =?utf-8?B?OG9IRGt4c3JTOEJKS1haWUtJNi92R3N2RmJXWklYSHBSK2gyTEJRcG5WcENx?=
 =?utf-8?B?bjZLU2NEbTF0ODRQUmttektZajM0bVNPK3ZabnJVR2I4K2V2ZDltMkM2SWVX?=
 =?utf-8?B?cFdPTUlvV2hiTDI3elpjSGpWRUEwTkh6bjQ0V2JKLzRoT1Q4S0w3MFBETjRC?=
 =?utf-8?B?ZURpSlFVOXFHSjZKNGt4amJOMVVOY3dzWFBhMFRTTlcvR1VaRmFXTlRaRk1T?=
 =?utf-8?B?QURtNkU3RHQ0SElBa1RQYzkraUZkYnozQ3VldGhVOVNkVVZwYVhsVDBwNUFM?=
 =?utf-8?B?NGRDUUxqaEEzZVJ3UGxjQTJYaEh2bmtJS2JIYmxJVDRiTUs4RlRMSld1WTF3?=
 =?utf-8?B?ZlJ3Rk9KRHVZUEVEdlBvREpsUU1adEUvWW1qQWQra0lsbVJoc1AwUWNIdFh4?=
 =?utf-8?B?SklSaWlRdG16QmVERkJ1cUNUOVBjY2l4VWdzZ2NCZnpiY3h0T2xwMXRnbGt3?=
 =?utf-8?B?RklNZHUzM0VWZnJORHM1aFJxc09Yb2RvbkE2NmdRQm5wWmo4anV4VENVRGEz?=
 =?utf-8?B?MEhnVWY4Rm5uNytUUnpIK0FNcm5XWGlNeFNSWHc2UVZwRThMTEJ6WWRUcTFL?=
 =?utf-8?B?a0d6UnlydUpybndlV1NzOGdhbGxYbEpVRnR2RU5wSDhHNnZibExGOEN6MFpo?=
 =?utf-8?B?T2JVUlJJQnh3NjhQcFNUdjh3T05aYUFzY1NJQ095Vk5lbERJZHBnamR5am50?=
 =?utf-8?B?bnRoNWFMYk5KSFNWeUQzNnJLY2lYK0psd0VvR3F6S2JSZ0VkZTB1bmZlRXho?=
 =?utf-8?B?Y1gvOC8xWW9mTkZuSm9uWVNiMmluZkxZRTNEUkVqbmFodHUxakh3YnA1Q0hn?=
 =?utf-8?B?RmdZVUtCK1hWNTFqME1obmpnK2g3dUg4OUJsM3FGQjhORXc1TVF0MHhWYm9O?=
 =?utf-8?B?Y2FlcHMzTitpU213Qi9hc1Z5Qyt0UFVWUlBXVjhGblMwd1dHYm9MRko1ZUNo?=
 =?utf-8?B?VWNlV0Zmak1LSHlXWHJRZDN2bXpZRHdRTmhIQzdIdnRNUCtkL0FzZjZQUUpH?=
 =?utf-8?B?dFcxN2pSUGtxdkpDYXhWMjdTbG5pcHpLbkwyQ3BYN1JsRjdDMnpodS9PMVNK?=
 =?utf-8?B?Y29IVnNjOVpMZnRZVmZpcWRqZEYweFBONStkTVBEeGMxS1RHM2JvazIxNTR3?=
 =?utf-8?B?Ujg1YVVuVkxvZVBBYkhuVlNvN0dLM2dhMHQyK0RpK0ZJemFNUnV0d0V5UWJs?=
 =?utf-8?B?SXN5ZmEwTTJRMTBNaDUzaG5wbUVISnpjVWRiUDhpUWNDWG02RmhBT3Q5RXh0?=
 =?utf-8?B?eVd6NUx4bEhsRFdhTXEwK0hQM2o1dEpTWnZ5V0J6RlVreEpBWk51VHVXT2M5?=
 =?utf-8?B?c0FQYzVQUGdqWVhBTEJvVGhLREdUMXBhR2pzdkd2cUgrTjJGR2xmcVFONDZM?=
 =?utf-8?Q?vZRqynH2mEhnI5z6ZLH+fPdm0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8bfab7-2866-498c-1cb2-08dbc8669c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 01:25:24.0723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5zUeyqItLbGMVV3oJXhsTLWu4xXhPyyv7C5/JwbWretXbjV4/0cHY23cAO09SRwfZmSUanf1T4m+FqS2WO7molJpIgGzePqsv+soMOgJ6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5148
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TZW50OiBNb25kYXksIE9jdG9iZXIgOSwgMjAyMyAxOjQ2IEFN
DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NCAxMC8xNV0gdmZpby9jY3c6IFVzZSB2ZmlvX1thdHRh
Y2gvZGV0YWNoXV9kZXZpY2UNCj4NCj5IaSBaaGVuemhvbmcsDQo+T24gMTAvOC8yMyAxMjoyMSwg
RHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4gSGkgRXJpYywNCj4+DQo+Pj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5j
b20+DQo+Pj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDQsIDIwMjMgMTE6NDQgUE0NCj4+PiBT
dWJqZWN0OiBbUEFUQ0ggdjQgMTAvMTVdIHZmaW8vY2N3OiBVc2UgdmZpb19bYXR0YWNoL2RldGFj
aF1fZGV2aWNlDQo+Pj4NCj4+PiBMZXQgdGhlIHZmaW8tY2N3IGRldmljZSB1c2UgdmZpb19hdHRh
Y2hfZGV2aWNlKCkgYW5kDQo+Pj4gdmZpb19kZXRhY2hfZGV2aWNlKCksIGhlbmNlIGhpZGluZyB0
aGUgZGV0YWlscyBvZiB0aGUgdXNlZA0KPj4+IElPTU1VIGJhY2tlbmQuDQo+Pj4NCj4+PiBOb3Rl
IHRoYXQgdGhlIG1pZ3JhdGlvbiByZWR1Y2VzIHRoZSBmb2xsb3dpbmcgdHJhY2UNCj4+PiAidmZp
bzogc3ViY2hhbm5lbCAlcyBoYXMgYWxyZWFkeSBiZWVuIGF0dGFjaGVkIiAoZmVhdHVyaW5nDQo+
Pj4gY3NzaWQuc3NpZC5kZXZpZCkgaW50byAiZGV2aWNlIGlzIGFscmVhZHkgYXR0YWNoZWQiDQo+
Pj4NCj4+PiBBbHNvIG5vdyBhbGwgdGhlIGRldmljZXMgaGF2ZSBiZWVuIG1pZ3JhdGVkIHRvIHVz
ZSB0aGUgbmV3DQo+Pj4gdmZpb19hdHRhY2hfZGV2aWNlL3ZmaW9fZGV0YWNoX2RldmljZSBBUEks
IGxldCdzIHR1cm4gdGhlDQo+Pj4gbGVnYWN5IGZ1bmN0aW9ucyBpbnRvIHN0YXRpYyBmdW5jdGlv
bnMsIGxvY2FsIHRvIGNvbnRhaW5lci5jLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogRXJpYyBB
dWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8
eWkubC5saXVAaW50ZWwuY29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4gUmV2aWV3ZWQtYnk6IE1hdHRoZXcgUm9zYXRv
IDxtanJvc2F0b0BsaW51eC5pYm0uY29tPg0KPj4+DQo+Pj4gLS0tDQo+Pj4NCj4+PiB2MzoNCj4+
PiAtIHNpbXBsaWZpZWQgdmJhc2VkZXYtPmRldiBzZXR0aW5nDQo+Pj4NCj4+PiB2MiAtPiB2MzoN
Cj4+PiAtIEhvcGVmdWxseSBmaXggY29uZnVzaW9uIGJldGVlbiB2YmFzZWRldi0+bmFtZSwgbWRl
dmlkIGFuZCBzeXNmc2Rldg0KPj4+ICB3aGlsZSBrZWVwaW5nIGludG8gYWNjb3VudCBNYXR0aGV3
J3MgY29tbWVudA0KPj4+ICBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzZlMDRh
YjhmLWRjODQtZTljMi1kZWVhLQ0KPj4+IDJiNmIzMTY3OGI1M0BsaW51eC5pYm0uY29tLw0KPj4+
IC0tLQ0KPj4+IGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oIHwgICA1IC0tDQo+Pj4gaHcv
dmZpby9jY3cuYyAgICAgICAgICAgICAgICAgfCAxMjIgKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPj4+IGh3L3ZmaW8vY29tbW9uLmMgICAgICAgICAgICAgIHwgIDEwICstLQ0K
Pj4+IDMgZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgMTAwIGRlbGV0aW9ucygtKQ0K
Pj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oIGIvaW5j
bHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+PiBpbmRleCAxMmZiZmJjMzdkLi5jNDg2YmRl
ZjJhIDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+Pj4g
KysrIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+PiBAQCAtMjAyLDcgKzIwMiw2
IEBAIHR5cGVkZWYgc3RydWN0IHsNCj4+PiAgICAgaHdhZGRyIHBhZ2VzOw0KPj4+IH0gVkZJT0Jp
dG1hcDsNCj4+Pg0KPj4+IC12b2lkIHZmaW9fcHV0X2Jhc2VfZGV2aWNlKFZGSU9EZXZpY2UgKnZi
YXNlZGV2KTsNCj4+PiB2b2lkIHZmaW9fZGlzYWJsZV9pcnFpbmRleChWRklPRGV2aWNlICp2YmFz
ZWRldiwgaW50IGluZGV4KTsNCj4+PiB2b2lkIHZmaW9fdW5tYXNrX3NpbmdsZV9pcnFpbmRleChW
RklPRGV2aWNlICp2YmFzZWRldiwgaW50IGluZGV4KTsNCj4+PiB2b2lkIHZmaW9fbWFza19zaW5n
bGVfaXJxaW5kZXgoVkZJT0RldmljZSAqdmJhc2VkZXYsIGludCBpbmRleCk7DQo+Pj4gQEAgLTIy
MCwxMSArMjE5LDcgQEAgdm9pZCB2ZmlvX3JlZ2lvbl91bm1hcChWRklPUmVnaW9uICpyZWdpb24p
Ow0KPj4+IHZvaWQgdmZpb19yZWdpb25fZXhpdChWRklPUmVnaW9uICpyZWdpb24pOw0KPj4+IHZv
aWQgdmZpb19yZWdpb25fZmluYWxpemUoVkZJT1JlZ2lvbiAqcmVnaW9uKTsNCj4+PiB2b2lkIHZm
aW9fcmVzZXRfaGFuZGxlcih2b2lkICpvcGFxdWUpOw0KPj4+IC1WRklPR3JvdXAgKnZmaW9fZ2V0
X2dyb3VwKGludCBncm91cGlkLCBBZGRyZXNzU3BhY2UgKmFzLCBFcnJvciAqKmVycnApOw0KPj4+
IC12b2lkIHZmaW9fcHV0X2dyb3VwKFZGSU9Hcm91cCAqZ3JvdXApOw0KPj4+IHN0cnVjdCB2Zmlv
X2RldmljZV9pbmZvICp2ZmlvX2dldF9kZXZpY2VfaW5mbyhpbnQgZmQpOw0KPj4+IC1pbnQgdmZp
b19nZXRfZGV2aWNlKFZGSU9Hcm91cCAqZ3JvdXAsIGNvbnN0IGNoYXIgKm5hbWUsDQo+Pj4gLSAg
ICAgICAgICAgICAgICAgICAgVkZJT0RldmljZSAqdmJhc2VkZXYsIEVycm9yICoqZXJycCk7DQo+
Pj4gaW50IHZmaW9fYXR0YWNoX2RldmljZShjaGFyICpuYW1lLCBWRklPRGV2aWNlICp2YmFzZWRl
diwNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgIEFkZHJlc3NTcGFjZSAqYXMsIEVycm9yICoq
ZXJycCk7DQo+Pj4gdm9pZCB2ZmlvX2RldGFjaF9kZXZpY2UoVkZJT0RldmljZSAqdmJhc2VkZXYp
Ow0KPj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2Njdy5jIGIvaHcvdmZpby9jY3cuYw0KPj4+IGlu
ZGV4IDFlMmZjZTgzYjAuLjZlYzM1ZmVkYzkgMTAwNjQ0DQo+Pj4gLS0tIGEvaHcvdmZpby9jY3cu
Yw0KPj4+ICsrKyBiL2h3L3ZmaW8vY2N3LmMNCj4+PiBAQCAtNTcyLDg4ICs1NzIsMTUgQEAgc3Rh
dGljIHZvaWQgdmZpb19jY3dfcHV0X3JlZ2lvbihWRklPQ0NXRGV2aWNlDQo+Pj4gKnZjZGV2KQ0K
Pj4+ICAgICBnX2ZyZWUodmNkZXYtPmlvX3JlZ2lvbik7DQo+Pj4gfQ0KPj4+DQo+Pj4gLXN0YXRp
YyB2b2lkIHZmaW9fY2N3X3B1dF9kZXZpY2UoVkZJT0NDV0RldmljZSAqdmNkZXYpDQo+Pj4gLXsN
Cj4+PiAtICAgIGdfZnJlZSh2Y2Rldi0+dmRldi5uYW1lKTsNCj4+PiAtICAgIHZmaW9fcHV0X2Jh
c2VfZGV2aWNlKCZ2Y2Rldi0+dmRldik7DQo+Pj4gLX0NCj4+PiAtDQo+Pj4gLXN0YXRpYyB2b2lk
IHZmaW9fY2N3X2dldF9kZXZpY2UoVkZJT0dyb3VwICpncm91cCwgVkZJT0NDV0RldmljZSAqdmNk
ZXYsDQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0K
Pj4+IC17DQo+Pj4gLSAgICBTMzkwQ0NXRGV2aWNlICpjZGV2ID0gUzM5MF9DQ1dfREVWSUNFKHZj
ZGV2KTsNCj4+PiAtICAgIGNoYXIgKm5hbWUgPSBnX3N0cmR1cF9wcmludGYoIiV4LiV4LiUwNHgi
LCBjZGV2LT5ob3N0aWQuY3NzaWQsDQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNkZXYtPmhvc3RpZC5zc2lkLA0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBjZGV2LT5ob3N0aWQuZGV2aWQpOw0KPj4+IC0gICAgVkZJT0RldmljZSAqdmJhc2VkZXY7
DQo+Pj4gLQ0KPj4+IC0gICAgUUxJU1RfRk9SRUFDSCh2YmFzZWRldiwgJmdyb3VwLT5kZXZpY2Vf
bGlzdCwgbmV4dCkgew0KPj4+IC0gICAgICAgIGlmIChzdHJjbXAodmJhc2VkZXYtPm5hbWUsIG5h
bWUpID09IDApIHsNCj4+PiAtICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAidmZpbzogc3Vi
Y2hhbm5lbCAlcyBoYXMgYWxyZWFkeSBiZWVuIGF0dGFjaGVkIiwNCj4+PiAtICAgICAgICAgICAg
ICAgICAgICAgICBuYW1lKTsNCj4+PiAtICAgICAgICAgICAgZ290byBvdXRfZXJyOw0KPj4+IC0g
ICAgICAgIH0NCj4+PiAtICAgIH0NCj4+PiAtDQo+Pj4gLSAgICAvKg0KPj4+IC0gICAgICogQWxs
IHZmaW8tY2N3IGRldmljZXMgYXJlIGJlbGlldmVkIHRvIG9wZXJhdGUgaW4gYSB3YXkgY29tcGF0
aWJsZSB3aXRoDQo+Pj4gLSAgICAgKiBkaXNjYXJkaW5nIG9mIG1lbW9yeSBpbiBSQU0gYmxvY2tz
LCBpZS4gcGFnZXMgcGlubmVkIGluIHRoZSBob3N0IGFyZQ0KPj4+IC0gICAgICogaW4gdGhlIGN1
cnJlbnQgd29ya2luZyBzZXQgb2YgdGhlIGd1ZXN0IGRyaXZlciBhbmQgdGhlcmVmb3JlIG5ldmVy
DQo+Pj4gLSAgICAgKiBvdmVybGFwIGUuZy4sIHdpdGggcGFnZXMgYXZhaWxhYmxlIHRvIHRoZSBn
dWVzdCBiYWxsb29uIGRyaXZlci4gIFRoaXMNCj4+PiAtICAgICAqIG5lZWRzIHRvIGJlIHNldCBi
ZWZvcmUgdmZpb19nZXRfZGV2aWNlKCkgZm9yIHZmaW8gY29tbW9uIHRvIGhhbmRsZQ0KPj4+IC0g
ICAgICogcmFtX2Jsb2NrX2Rpc2NhcmRfZGlzYWJsZSgpLg0KPj4+IC0gICAgICovDQo+Pj4gLSAg
ICB2Y2Rldi0+dmRldi5yYW1fYmxvY2tfZGlzY2FyZF9hbGxvd2VkID0gdHJ1ZTsNCj4+PiAtDQo+
Pj4gLSAgICBpZiAodmZpb19nZXRfZGV2aWNlKGdyb3VwLCBjZGV2LT5tZGV2aWQsICZ2Y2Rldi0+
dmRldiwgZXJycCkpIHsNCj4+PiAtICAgICAgICBnb3RvIG91dF9lcnI7DQo+Pj4gLSAgICB9DQo+
Pj4gLQ0KPj4+IC0gICAgdmNkZXYtPnZkZXYub3BzID0gJnZmaW9fY2N3X29wczsNCj4+PiAtICAg
IHZjZGV2LT52ZGV2LnR5cGUgPSBWRklPX0RFVklDRV9UWVBFX0NDVzsNCj4+PiAtICAgIHZjZGV2
LT52ZGV2Lm5hbWUgPSBuYW1lOw0KPj4+IC0gICAgdmNkZXYtPnZkZXYuZGV2ID0gREVWSUNFKHZj
ZGV2KTsNCj4+PiAtDQo+Pj4gLSAgICByZXR1cm47DQo+Pj4gLQ0KPj4+IC1vdXRfZXJyOg0KPj4+
IC0gICAgZ19mcmVlKG5hbWUpOw0KPj4+IC19DQo+Pj4gLQ0KPj4+IC1zdGF0aWMgVkZJT0dyb3Vw
ICp2ZmlvX2Njd19nZXRfZ3JvdXAoUzM5MENDV0RldmljZSAqY2RldiwgRXJyb3IgKiplcnJwKQ0K
Pj4+IC17DQo+Pj4gLSAgICBjaGFyICp0bXAsIGdyb3VwX3BhdGhbUEFUSF9NQVhdOw0KPj4+IC0g
ICAgc3NpemVfdCBsZW47DQo+Pj4gLSAgICBpbnQgZ3JvdXBpZDsNCj4+PiAtDQo+Pj4gLSAgICB0
bXAgPQ0KPmdfc3RyZHVwX3ByaW50ZigiL3N5cy9idXMvY3NzL2RldmljZXMvJXguJXguJTA0eC8l
cy9pb21tdV9ncm91cCIsDQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgY2Rldi0+aG9z
dGlkLmNzc2lkLCBjZGV2LT5ob3N0aWQuc3NpZCwNCj4+PiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICBjZGV2LT5ob3N0aWQuZGV2aWQsIGNkZXYtPm1kZXZpZCk7DQo+Pj4gLSAgICBsZW4gPSBy
ZWFkbGluayh0bXAsIGdyb3VwX3BhdGgsIHNpemVvZihncm91cF9wYXRoKSk7DQo+Pj4gLSAgICBn
X2ZyZWUodG1wKTsNCj4+PiAtDQo+Pj4gLSAgICBpZiAobGVuIDw9IDAgfHwgbGVuID49IHNpemVv
Zihncm91cF9wYXRoKSkgew0KPj4+IC0gICAgICAgIGVycm9yX3NldGcoZXJycCwgInZmaW86IG5v
IGlvbW11X2dyb3VwIGZvdW5kIik7DQo+Pj4gLSAgICAgICAgcmV0dXJuIE5VTEw7DQo+Pj4gLSAg
ICB9DQo+Pj4gLQ0KPj4+IC0gICAgZ3JvdXBfcGF0aFtsZW5dID0gMDsNCj4+PiAtDQo+Pj4gLSAg
ICBpZiAoc3NjYW5mKGJhc2VuYW1lKGdyb3VwX3BhdGgpLCAiJWQiLCAmZ3JvdXBpZCkgIT0gMSkg
ew0KPj4+IC0gICAgICAgIGVycm9yX3NldGcoZXJycCwgInZmaW86IGZhaWxlZCB0byByZWFkICVz
IiwgZ3JvdXBfcGF0aCk7DQo+Pj4gLSAgICAgICAgcmV0dXJuIE5VTEw7DQo+Pj4gLSAgICB9DQo+
Pj4gLQ0KPj4+IC0gICAgcmV0dXJuIHZmaW9fZ2V0X2dyb3VwKGdyb3VwaWQsICZhZGRyZXNzX3Nw
YWNlX21lbW9yeSwgZXJycCk7DQo+Pj4gLX0NCj4+PiAtDQo+Pj4gc3RhdGljIHZvaWQgdmZpb19j
Y3dfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+Pj4gew0KPj4+IC0g
ICAgVkZJT0dyb3VwICpncm91cDsNCj4+PiAgICAgUzM5MENDV0RldmljZSAqY2RldiA9IFMzOTBf
Q0NXX0RFVklDRShkZXYpOw0KPj4+ICAgICBWRklPQ0NXRGV2aWNlICp2Y2RldiA9IFZGSU9fQ0NX
KGNkZXYpOw0KPj4+ICAgICBTMzkwQ0NXRGV2aWNlQ2xhc3MgKmNkYyA9IFMzOTBfQ0NXX0RFVklD
RV9HRVRfQ0xBU1MoY2Rldik7DQo+Pj4gKyAgICBWRklPRGV2aWNlICp2YmFzZWRldiA9ICZ2Y2Rl
di0+dmRldjsNCj4+PiAgICAgRXJyb3IgKmVyciA9IE5VTEw7DQo+Pj4gKyAgICBjaGFyICpuYW1l
Ow0KPj4+ICsgICAgaW50IHJldDsNCj4+Pg0KPj4+ICAgICAvKiBDYWxsIHRoZSBjbGFzcyBpbml0
IGZ1bmN0aW9uIGZvciBzdWJjaGFubmVsLiAqLw0KPj4+ICAgICBpZiAoY2RjLT5yZWFsaXplKSB7
DQo+Pj4gQEAgLTY2MywxNCArNTkwLDMxIEBAIHN0YXRpYyB2b2lkIHZmaW9fY2N3X3JlYWxpemUo
RGV2aWNlU3RhdGUgKmRldiwgRXJyb3INCj4+PiAqKmVycnApDQo+Pj4gICAgICAgICB9DQo+Pj4g
ICAgIH0NCj4+Pg0KPj4+IC0gICAgZ3JvdXAgPSB2ZmlvX2Njd19nZXRfZ3JvdXAoY2RldiwgJmVy
cik7DQo+Pj4gLSAgICBpZiAoIWdyb3VwKSB7DQo+Pj4gLSAgICAgICAgZ290byBvdXRfZ3JvdXBf
ZXJyOw0KPj4+IC0gICAgfQ0KPj4+ICsgICAgbmFtZSA9IGdfc3RyZHVwX3ByaW50ZigiJXguJXgu
JTA0eCIsIHZjZGV2LT5jZGV2Lmhvc3RpZC5jc3NpZCwNCj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdmNkZXYtPmNkZXYuaG9zdGlkLnNzaWQsDQo+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHZjZGV2LT5jZGV2Lmhvc3RpZC5kZXZpZCk7DQo+Pj4gKyAgICB2YmFzZWRldi0+
c3lzZnNkZXYgPSBnX3N0cmR1cF9wcmludGYoIi9zeXMvYnVzL2Nzcy9kZXZpY2VzLyVzLyVzIiwN
Cj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuYW1lLA0KPj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNkZXYtPm1kZXZpZCk7
DQo+PiBIb3Bpbmcgbm90IGxhdGUgZm9yIHlvdSB0byBpbmNsdWRlIHRoaXMgaW4gdjUuDQo+PiBJ
IHRoaW5rIG5vIG5lZWQgdG8gcmUtYXNzaWduIHN5c2ZzZGV2IGFzIGl0J3MgYSB1c2VyIHByb3Bl
cnR5LCB3ZSdkIGJldHRlciB0bw0KPj4ga2VlcCB0aGUgb3JpZ2luYWwgdXNlciB2YWx1ZS4gQWxz
byBsb29rcyBhIG1lbW9yeSBsZWFrIGhlcmUuDQo+T0sgSSByZW1vdmVkIGl0Lg0KPj4NCj4+PiAr
ICAgIHZiYXNlZGV2LT5vcHMgPSAmdmZpb19jY3dfb3BzOw0KPj4+ICsgICAgdmJhc2VkZXYtPnR5
cGUgPSBWRklPX0RFVklDRV9UWVBFX0NDVzsNCj4+PiArICAgIHZiYXNlZGV2LT5uYW1lID0gbmFt
ZTsNCj4+IFRoZXJlIHdpbGwgYmUgYSBwb3RlbnRpYWwgZmFpbHVyZSB3aGVuIGEgc2Vjb25kIG1k
ZXYgZGV2aWNlIHVuZGVyDQo+PiBzYW1lIGNzc2lkLnNzaWQuZGV2aWQgYXR0YWNoZWQuIFdlIGNh
biB1c2UgY2Rldi0+bWRldmlkIGFzIG5hbWUuDQo+QnV0IHRoaXMgbWF0aGVzIHZmaW9fY2N3X2dl
dF9kZXZpY2UoKSBleGlzdGluZyBjb2RlIHdoZXJlDQo+dmNkZXYtPnZkZXYubmFtZSA9IG5hbWU7
IGFuZA0KPm5hbWUgPSBnX3N0cmR1cF9wcmludGYoIiV4LiV4LiUwNHgiLCBjZGV2LT5ob3N0aWQu
Y3NzaWQsDQo+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjZGV2LT5ob3N0aWQuc3NpZCwNCj7CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNkZXYtPmhvc3Rp
ZC5kZXZpZCk7DQoNCkkgc3VzcGVjdCB0aGlzIGlzIGEgYnVnIG9mIHRoZSBleGlzdGluZyBjb2Rl
Lg0KDQo+DQo+Y2Rldi0+bWRldmlkIGlzIHBhc3NlZCBhcyBmaXJzdCBhcmcgb2YgdmZpb19hdHRh
Y2hfZGV2aWNlKCkgaW5zdGVhZCAuDQoNCnZmaW9fYXR0YWNoX2RldmljZSgpIHVzZXMgY2Rldi0+
bWRldmlkIHRvIGdldCBkZXZpY2UgRkQsIG5vdGhpbmcgbW9yZS4NCg0KSWYgd2UgdXNlIGNzc2lk
LnNzaWQuZGV2aWQgYXMgbmFtZSwgdGhlbiBkaWZmZXJlbnQgbWRldiB1bmRlciBzYW1lIGNzc2lk
LnNzaWQuZGV2aWQgd2lsbCBoYXZlIHNhbWUgbmFtZSwgYW5kIHRoZSBzZWNvbmQgbWRldiBhdHRh
Y2htZW50IHdpbGwgZmFpbCB0byBhdHRhY2ggaW4gdmZpb19hdHRhY2hfZGV2aWNlKCk6DQoNCiAg
ICBRTElTVF9GT1JFQUNIKHZiYXNlZGV2X2l0ZXIsICZncm91cC0+ZGV2aWNlX2xpc3QsIG5leHQp
IHsNCiAgICAgICAgaWYgKHN0cmNtcCh2YmFzZWRldl9pdGVyLT5uYW1lLCB2YmFzZWRldi0+bmFt
ZSkgPT0gMCkgew0KICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiZGV2aWNlIGlzIGFscmVh
ZHkgYXR0YWNoZWQiKTsNCiAgICAgICAgICAgIHZmaW9fcHV0X2dyb3VwKGdyb3VwKTsNCiAgICAg
ICAgICAgIHJldHVybiAtRUJVU1k7DQogICAgICAgIH0NCiAgICB9DQoNCj4NCj5pIHRoaW5rIHRo
aXMgYWxzbyBtYXRjaGVzDQo+aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1BIN1BSMTFNQjY3
MjIyREQyODJGOThFMDMwOTVGQkE4QTkyQzFBQFBIDQo+N1BSMTFNQjY3MjIubmFtcHJkMTEucHJv
ZC5vdXRsb29rLmNvbS8NCj5ubz8NCg0KSXQgZG9lc24ndCBtYXRjaCB3aGF0IE1hdHRldyBzdWdn
ZXN0ZWQ6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvNmUwNGFiOGYtZGM4NC1l
OWMyLWRlZWEtMmI2YjMxNjc4YjUzQGxpbnV4LmlibS5jb20vDQoNClRoYW5rcw0KWmhlbnpob25n
DQoNCg==

