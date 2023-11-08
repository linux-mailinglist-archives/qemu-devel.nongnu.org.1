Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F06C57E5263
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 10:08:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0eXP-0004yZ-HW; Wed, 08 Nov 2023 04:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0eXM-0004y6-WE
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:07:49 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0eXJ-0002UG-OK
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699434466; x=1730970466;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5IBMa6jtlZo3TO2lZudpmYljqxVVmEXVpipKQzfvoeE=;
 b=IxA+lU3uBNlIRNC8YcZTMpFSDa7KHiA20GOhbYT4/JVQdczroO1Eveji
 xAr/08oToSO0PmXB6eFaJ2fO6xUcLhkz49jHMnpOX6oWiD3+k5Gq9VKoV
 8CwP7h995Y6mKCauHj2EkieQopxaa0NH7ZxhtJWjHJ2d5SGZ7RvvIURED
 VrHPvd3GIFiLQtNN3m98TbORStr1LujwcDrUirPS+cZbRF/q+TqRDc917
 TuAqXKb+ncDayhev6TmnodI2l/Evb6iGWB5Nmynfp5C1H1p/C2jK5OSFR
 inysm7+D75at4hGUd2pxQC95gLMqGg/GOVJYnJMQMQBzZkt/6g6xBg2s3 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="369060882"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; d="scan'208";a="369060882"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2023 01:07:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="762998168"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; d="scan'208";a="762998168"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Nov 2023 01:07:36 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 01:07:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 01:07:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 01:07:35 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 01:07:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/P8elOjAGmTaTUrYFdg1wLELBTxM6X62A+Z5JgNgVRtlQHxH4pU0eSteIg9WF9fm3jyJL3hKizQAprK+FIjVTevW4+9VbuYCB9959D6gO7DBConAByuPI68GYNqTUt1rzGkj7Lb4va3YjmeKgq7pecARfONKqdBwPvIbT6InJrDjtU7Ab+VQrRzgtfoBaekGtCcFtiVxpI7xXKmtaLqUaHzLcfqW3AdQv+eyfmzSWhIUHMQaP/q/HVbmkn6ZnR/yQHWPi7epPlTxK6SCQ1nqe8+TsaD2IVORmlffD/u9sucTtP4LEovGt0UtaOTk5IqOehBWzjcY+xJmkDBSHGIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IBMa6jtlZo3TO2lZudpmYljqxVVmEXVpipKQzfvoeE=;
 b=SDRJgVoT/mspbRBtEZJ4poejrqn2UxzMKZFOqgc2PkCJs+EPz+FP5LzVUqQqHCKMBC9P/pIqoo5C9NDqun4edVdqA6S3pMSR1XftY8EduIbJFpx8D3br5fbbiA/ichoel+ub5zHLzPTK9IQkA8C02lvAn7UiZ/KeFJBhrJe7HigTP0gtfc8FFcPeLGyI3D0HYtjV7h9rF76zk3YRhW9sC9brZhRgHLzJDyCrbYqa+fOtsjY3zp1NEU3ToyHhFwNs5ifuzIwBaFcEXVx3CufA3rp4Cj4xeeY7qV5ua3DsOAnigXCXD7r5UK8W16J86YH/rCXmJlhXQO3SvlZpjn0R4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM6PR11MB4753.namprd11.prod.outlook.com (2603:10b6:5:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 09:07:32 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 09:07:31 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Thomas Huth
 <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>
Subject: RE: [PATCH v4 00/41] vfio: Adopt iommufd
Thread-Topic: [PATCH v4 00/41] vfio: Adopt iommufd
Thread-Index: AQHaDV4v7k+KAYZ49k6QYTXZyZG4O7BvNckAgACWOICAAFWToIAACRuA
Date: Wed, 8 Nov 2023 09:07:31 +0000
Message-ID: <SJ0PR11MB6744D2DDA934B345ABAADFB092A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <d8f1ecdd-4ce8-4811-8efe-6607e71a9f98@redhat.com>
 <923acaad-4e52-442f-b688-277e87a48469@linux.ibm.com>
 <SJ0PR11MB67444527CF73955C131AABD892A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB67444527CF73955C131AABD892A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM6PR11MB4753:EE_
x-ms-office365-filtering-correlation-id: 39ff6efc-25f5-4e29-b3c3-08dbe03a239f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dWDEtLOCV9su2AmapECPL9r2aBqWSCiQdSuvIhhuZU3LlIByPa4FTHb24MJGdWqbwOfrsbeV1MuCOy4fjHE9EuNAKRsTDI71pnbdLRTUzahOtb868PaQMLqSeno1hXj4y1yNZn8HM8CTpPDhtLEj31wezdLWy9LNb2VpDcqR+57llc+GVbxl49EarZzdtbkiDQBa277llOKJ8i8Dl3wZjUWDLOV6p8sgTNnd84REnytuwdszbP/w6GdBDGOgms2nB7/ln3QaIgVt0Zm9k1SEcOze8i1e9KCbryRt2WOoIvOET64GV2Rja097oQpfOsdLlZtA1U31OhX4X/xO/Km1SOp3p4673d5ujOL8Jnadl9f9jStt8zOGkuOEhFQHtoV9dZVcb/jg8+btylorTiOPKhMCEmsqtSN7aYflnaNwyBgzweUwfKMBpN9hONwjKgraaKY15PEv65cYl5pK5gO4zjR7e6VYK66n5Db2gBNOwNdounDml4GGBXs9yOuik1LWvvxCZ2SaSpbPfw5nciMpVWgjor6lNaFeDd0ECcIjMzGp5HprXSI3ErHDOwBNC5QIUH9TVra0qCn6poEoF1cnKA+sc6M5vtozrH0txZJVpmHPsJOwsu58nGTtKgR4Cyz3ZYXdaVBrQwBl8x8CUawu4Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(82960400001)(38100700002)(122000001)(55016003)(83380400001)(5660300002)(38070700009)(478600001)(966005)(7696005)(6506007)(71200400001)(2940100002)(9686003)(53546011)(66476007)(66556008)(76116006)(316002)(52536014)(110136005)(64756008)(66946007)(66446008)(8676002)(4326008)(8936002)(54906003)(86362001)(7416002)(2906002)(41300700001)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjQ5RXozeFZ2UlRrSW9iL2lLZlJXMWRSWGdMVTIwdjJuUDlWRlhBeVRYOGt2?=
 =?utf-8?B?c0YrSmNoWHY5ck10d0J0QjJxUU1Hcm1sTGFEd1hJVHNmamNwdVRFeHA4NW83?=
 =?utf-8?B?YmFlUVRuM0haaWpUOGNNdGQzTkh6VVQ2Wnhtb01BUzVubXljT3pRYUJCVVl2?=
 =?utf-8?B?bUI1UTZBQWFJa3IwNHN3WGhyNkdVTXpzMlFBU0FOV3ZFRkpjd0xneUtaYUQr?=
 =?utf-8?B?MzRFSzYyN1BZQWllQ2ZEZ0NBRGFIdjN1M2ZMTUp6Qmd3ZTR3YzNaMi9nTUNX?=
 =?utf-8?B?T05LSXo4QnE4SlNORmRvQUdyelVkcHJSWXZlTjFLM3NYUm03Z3Fic1E2SDhB?=
 =?utf-8?B?Tzh2MXlWbFdJd0t6eDdzN1dKSXpIdVY0c251b0YyVndSc1JPd0R3eURZTHli?=
 =?utf-8?B?ditUcjk5YWhNaE9UVS9rVU9aUFhPWlREcTNURjMzNjhUTi9jRktPZDNLUnI0?=
 =?utf-8?B?VitsZWRKR0lJNG5MODdMOWFKeTAzWitOOE51VEQ4cHJGNmpxM1IvK3l2T1RW?=
 =?utf-8?B?MmR0aDYwajdockFSVjJTYkhSRnRzUG9WdmFibW9MY2ErdmZUYkVJRnRBR0Rt?=
 =?utf-8?B?QWhmTWZTbmNkNGEzMWc4RDR4NXVFNUhOMXhnQ2p2ZjZqVFNZS29VdnRlMExx?=
 =?utf-8?B?bUp5UER1KzlQYkh3SzlYSTVtN0huRkxGRUxjcFNtVUJyVlF2MVVOaGpQcDUv?=
 =?utf-8?B?dWhiOFFkVVB1eU5UWlNHdzNTajFZb2dLRE0rb2EvRzI5QTRaSzlRQXJyTWJJ?=
 =?utf-8?B?aGg3ODZLZ25nT09ETFZtUlRaTHUrbXhyV1NYWDB1ejlucGJPWW5MZkVmcWh0?=
 =?utf-8?B?bW5QLzY0eFlPa2gvQlNXUDV1MFBTL0JFRmR0NDRWSlRxL0NlbHMzL1prZEhF?=
 =?utf-8?B?UUk5TG1WM2xSSFprRkJYdlBRc1VGODlIRDlXcGdwVjdLNTluYk13ZEh4Z1ZQ?=
 =?utf-8?B?RExCc1laTC9NNkx3UEhLNk5ZYXovM2gwYkQ2ZUorMXE1VVVaTVp6OHp3M0Zo?=
 =?utf-8?B?Zk92NFJGN2hEbEJRanlqNmkrMHpsRnJCTS9VOUhPKzgwbis4QXVYU3BoMGMr?=
 =?utf-8?B?TU12ZDdCaWxReFJNVFp5RU84YUhuTm90ZkxZV0lWR1cwR2NWZ1h1cW5VODBl?=
 =?utf-8?B?ZHlvRXlrbjZ1Y1ByVHM3Q2NEalc2Z0l4eFZPK05MMmJXd2o1SDhQQ0lrS1Uv?=
 =?utf-8?B?WW15bTJJQTdaaG1GdncySUJqZldUWElRTjZxOEdVamlpcUFmNTJRN1F1M3kw?=
 =?utf-8?B?YTV6TlBGYktidi9JNk9VaW1GaUE3cFBiSnRpc1pTcm5CU0d0Zld1NHppcHVm?=
 =?utf-8?B?ZkdQTE5KczJHTWE3aWkyL09VL01oMnMzK0xwWjB6eUxuRlVTRVprbkg0U0M3?=
 =?utf-8?B?dG9ta0RIYWhwTU1MWGVxMjR6RWNlRnFLZnkra0dDT0hvR3I0S2tqdWFVVWx5?=
 =?utf-8?B?WWw3Y2NyUGNCS1FwN2ErbjhSbFdHcXJQdjNKYjF1L2VzcGtraWdQL0RNZm1K?=
 =?utf-8?B?aUp1Z3lWZWtRQVIwS2I2VkxMWWk2VkpiNnFWYUU1REpBSVFzQU5wMzNYS0JD?=
 =?utf-8?B?eHdESlJGeURBanh4Tzhhelpmd0VLcnozY29rM1pBUStDbWxEbHJnVzNKQXM0?=
 =?utf-8?B?Q09rMERpTTcrRnpIQWlzTk1TMDdlMUNkdG14UVZENXc0cnc0VmVldUFYUjRK?=
 =?utf-8?B?V3dOSjJ0Mm9zRFVCdUFISzZxdE13UDVTd0lYMTZpSVQ4UU5LMUtMdVh1OXpm?=
 =?utf-8?B?aEZiakZrSGM3d0U2V2VuTEhwM0dYcEVjZEdmK2d1NUorK1hPMGRObDc5cGp0?=
 =?utf-8?B?NHRCRG9XYTJONS9kdUt3NW9adnd2TFdQUkRibjRoazZyM3RPV01rR2J2VUl6?=
 =?utf-8?B?Z3U0ZjB5R3F2RUdkdUFhWVBkZHZBRlE1d0t3Z1NZbHE2WWFHcjY5ZjlFSSs4?=
 =?utf-8?B?VEx3cXVqZzJaMkM0bDI3T0Rlb0djOW5UTUNsc3R6TlFOUHZJRjlsSHVYaFlV?=
 =?utf-8?B?L2JHTG9xV1ZZMHNmeUJqR3MzcXcrRXUrRGUrdGlLbkFMcHJwNVpWRlpLQ1pP?=
 =?utf-8?B?c2l4L3l6N0R5Wlgxckh6c2ZKbDVuRkczOEpFTkVDVXRDNkQyQlJJcld1MHFV?=
 =?utf-8?B?ZUtFZjdrbGxxdmF0cDFWZ0ZNTDM5NVcwTFpjU1BKTW10UXNSVXFKQ1BjUVVG?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ff6efc-25f5-4e29-b3c3-08dbe03a239f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 09:07:31.3145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5gHs0LDPMSORgdZKj/KorNmMOKlYBcEvt+PXNWVUs+iN4FghjV8NGBGWbSj1WrWsPOwVogdzHmiA1AJGYyl9OKY0u5/792lDY8B5xCpgB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4753
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IER1YW4sIFpoZW56aG9uZw0K
PlNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgOCwgMjAyMyA0OjM4IFBNDQo+U3ViamVjdDogUkU6
IFtQQVRDSCB2NCAwMC80MV0gdmZpbzogQWRvcHQgaW9tbXVmZA0KPg0KPg0KPg0KPj4tLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj5Gcm9tOiBNYXR0aGV3IFJvc2F0byA8bWpyb3NhdG9AbGlu
dXguaWJtLmNvbT4NCj4+U2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciA4LCAyMDIzIDExOjI3IEFN
DQo+PlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDAvNDFdIHZmaW86IEFkb3B0IGlvbW11ZmQNCj4+
DQo+Pk9uIDExLzcvMjMgMToyOCBQTSwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+Pj4gT24g
MTEvMi8yMyAwODoxMiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4+IEhpLA0KPj4+Pg0KPj4+
PiBUaGFua3MgYWxsIGZvciBnaXZpbmcgZ3VpZGVzIGFuZCBjb21tZW50cyBvbiBwcmV2aW91cyBz
ZXJpZXMsIGhlcmUgaXMNCj4+Pj4gdGhlIHY0IG9mIHB1cmUgaW9tbXVmZCBzdXBwb3J0IHBhcnQu
DQo+Pj4+DQo+Pj4+IEJhc2VkIG9uIEPDqWRyaWMncyBzdWdnZXN0aW9uLCB0aGlzIHNlcmllcyBp
bmNsdWRlcyBhbiBlZmZvcnQgdG8gcmVtb3ZlDQo+Pj4+IHNwYXByIGNvZGUgZnJvbSBjb250YWlu
ZXIuYywgbm93IGFsbCBzcGFwciBmdW5jdGlvbnMgYXJlIG1vdmVkIHRvIHNwYXByLmMNCj4+Pj4g
b3Igc3BhcHJfcGNpX3ZmaW8uYywgYnV0IHRoZXJlIGFyZSBzdGlsbCBhIGZldyB0cml2YWwgY2hl
Y2sgb24NCj4+Pj4gVkZJT19TUEFQUl9UQ0VfKl9JT01NVSB3aGljaCBJIGFtIG5vdCBzdXJlIGlm
IGRlc2VydmVkIHRvIGludHJvZHVjZQ0KPj5tYW55DQo+Pj4+IGNhbGxiYWNrcyBhbmQgZHVwbGlj
YXRlIGNvZGUganVzdCB0byByZW1vdmUgdGhlbS4gU29tZSBmdW5jdGlvbnMgYXJlIG1vdmVkDQo+
Pj4+IHRvIHNwYXByLmMgaW5zdGVhZCBvZiBzcGFwcl9wY2lfdmZpby5jIHRvIGF2b2lkIGNvbXBp
bGUgaXNzdWUgYmVjYXVzZQ0KPj4+PiBzcGFwcl9wY2lfdmZpby5jIGlzIGFyY2ggc3BlY2lmaWMs
IG9yIGVsc2Ugd2UgbmVlZCB0byBpbnRyb2R1Y2Ugc3R1Yg0KPj4+PiBmdW5jdGlvbnMgdG8gdGhv
c2Ugc3BhcHIgZnVuY3Rpb25zIG1vdmVkLg0KPj4+Pg0KPj4+Pg0KPj4+PiBQQVRDSCAxLTU6IE1v
dmUgc3BhcHIgZnVuY3Rpb25zIHRvIHNwYXByKi5jDQo+Pj4+IFBBVENIIDYtMjA6IEFic3RyYWN0
IG91dCBiYXNlIGNvbnRhaW5lcg0KPj4+PiBQQVRDSCAyMS0yNDogSW50cm9kdWNlIHNwYXJwciBj
b250YWluZXIgYW5kIGl0cyBzcGVjaWZpYyBpbnRlcmZhY2UNCj4+Pg0KPj4+IFBBVENIIDYtMjQg
YXBwbGllZCB0byB2ZmlvLW5leHQgOg0KPj4+DQo+Pj4gwqAgaHR0cHM6Ly9naXRodWIuY29tL2xl
Z29hdGVyL3FlbXUvY29tbWl0cy92ZmlvLW5leHQNCj4+Pg0KPj4+ICh3aXRoIGEgZ2xvYmFsIHMv
ZnVjbnRpb25hbC9mdW5jdGlvbmFsLykNCj4+Pg0KPj4+DQo+Pj4gSSBhbHNvIHB1c2hlZCB0aGUg
cmVtYWluaW5nIHBhdGNoZXMgb24gOg0KPj4+DQo+Pj4gwqAgaHR0cHM6Ly9naXRodWIuY29tL2xl
Z29hdGVyL3FlbXUvY29tbWl0cy92ZmlvLTguMg0KPj4+DQo+Pj4gd2l0aCBhIHNsaWdodCByZXdv
cmsgb2YgdGhlIElPTU1VRkQgY29uZmlndXJhdGlvbiwgbm93IGRvbmUgcGVyIHBsYXRmb3JtLg0K
Pj4+IFRoZSBWRklPIGZyb250ZW5kIGFuZCB0aGUgJ2lvbW11ZmQnIG9iamVjdCBhcmUgb25seSBh
dmFpbGFibGUgb24geDg2XzY0LA0KPj4+IGFybSwgczM5MHguDQo+DQo+VGhhbmtzIEPDqWRyaWMu
DQo+DQo+Pg0KPj5GWUksIEkgZmlyc3QgdHJpZWQgdGhpcyB2ZmlvLTguMiBicmFuY2ggb24gczM5
MHggYnV0IHdhc24ndCBhY3R1YWxseSBhYmxlIHRvIHVzZSB0aGUNCj4+aW9tbXVmZCBiYWNrZW5k
ICh3YXMgZ2V0dGluZyBlcnJvcnMgbGlrZSBQcm9wZXJ0eSAndmZpby1wY2kuaW9tbXVmZCcgbm90
IGZvdW5kKQ0KPj5zbyBJIHRoaW5rIHNvbWV0aGluZyBpc24ndCBhY3R1YWxseSBlbmFibGluZyBJ
T01NVUZEIGFzIGV4cGVjdGVkIHdpdGggeW91cg0KPj5jaGFuZ2UuLi4NCj4NCj5JdCBsb29rcyBD
T05GSUdfSU9NTVVGRCBpcyByZWNvZ25pemVkIGJ5IEtjb25maWcgc3ViLXN5c3RlbSBidXQgbm90
IHJlY2VpdmVkDQo+YnkgY29tcGlsZXIuIEknbSBzdGlsbCBkaWdnaW5nIGhvdyB0byBwYXNzIENP
TkZJR19JT01NVUZEIHRvIGNvbXBpbGVyLg0KDQpOZWVkIGJlbG93IGNoYW5nZSB0byBwYXNzIENP
TkZJR19JT01NVUZEIHRvIGNvbXBpbGVyLg0KDQpkaWZmIC0tZ2l0IGEvaHcvdmZpby9hcC5jIGIv
aHcvdmZpby9hcC5jDQppbmRleCAwYTgxMGY4Yjg4Li4yYTMyNjNiNTFmIDEwMDY0NA0KLS0tIGEv
aHcvdmZpby9hcC5jDQorKysgYi9ody92ZmlvL2FwLmMNCkBAIC0zMCw2ICszMCw3IEBADQogI2lu
Y2x1ZGUgImV4ZWMvYWRkcmVzcy1zcGFjZXMuaCINCiAjaW5jbHVkZSAicW9tL29iamVjdC5oIg0K
ICNpbmNsdWRlICJtb25pdG9yL21vbml0b3IuaCINCisjaW5jbHVkZSBDT05GSUdfREVWSUNFUw0K
DQogI2RlZmluZSBUWVBFX1ZGSU9fQVBfREVWSUNFICAgICAgInZmaW8tYXAiDQoNCmRpZmYgLS1n
aXQgYS9ody92ZmlvL2Njdy5jIGIvaHcvdmZpby9jY3cuYw0KaW5kZXggYTY3NGJkOGQ2ZC4uMDgx
MDFhZDQ0NSAxMDA2NDQNCi0tLSBhL2h3L3ZmaW8vY2N3LmMNCisrKyBiL2h3L3ZmaW8vY2N3LmMN
CkBAIC0zMSw2ICszMSw3IEBADQogI2luY2x1ZGUgInFlbXUvbWFpbi1sb29wLmgiDQogI2luY2x1
ZGUgInFlbXUvbW9kdWxlLmgiDQogI2luY2x1ZGUgIm1vbml0b3IvbW9uaXRvci5oIg0KKyNpbmNs
dWRlIENPTkZJR19ERVZJQ0VTDQoNCiBzdHJ1Y3QgVkZJT0NDV0RldmljZSB7DQogICAgIFMzOTBD
Q1dEZXZpY2UgY2RldjsNCmRpZmYgLS1naXQgYS9ody92ZmlvL3BjaS5jIGIvaHcvdmZpby9wY2ku
Yw0KaW5kZXggZDhmNjU4ZWE0Ny4uMzEyMWI1Zjk4NSAxMDA2NDQNCi0tLSBhL2h3L3ZmaW8vcGNp
LmMNCisrKyBiL2h3L3ZmaW8vcGNpLmMNCkBAIC00NCw2ICs0NCw3IEBADQogI2luY2x1ZGUgIm1p
Z3JhdGlvbi9xZW11LWZpbGUuaCINCiAjaW5jbHVkZSAic3lzZW11L2lvbW11ZmQuaCINCiAjaW5j
bHVkZSAibW9uaXRvci9tb25pdG9yLmgiDQorI2luY2x1ZGUgQ09ORklHX0RFVklDRVMNCg0KICNk
ZWZpbmUgVFlQRV9WRklPX1BDSV9OT0hPVFBMVUcgInZmaW8tcGNpLW5vaG90cGx1ZyINCg0KVGhh
bmtzDQpaaGVuemhvbmcNCg==

