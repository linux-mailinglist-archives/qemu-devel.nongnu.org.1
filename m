Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5257A764E
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 10:50:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qistD-0005kq-KV; Wed, 20 Sep 2023 04:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qistB-0005kU-QT; Wed, 20 Sep 2023 04:48:53 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qist9-0003BK-8D; Wed, 20 Sep 2023 04:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695199731; x=1726735731;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Iop84TM3b4Lkjvn41thv4XA9GqO7HZZuNPUdjMtNwgI=;
 b=EwwQCl5CCEWAOng6Coy2hDXfAu0rGy1SLfBj1NmNn0iCKpgxHaEoR9CJ
 m0pPOtAJ0MzSMSBGzVgUjqkEd630h3WJ1kz8/BjN/gLBwxW2MkhEXjbrl
 sqNdwoi3qE1viZO+kvtg5clhtkeLV3Z2TkWD2wlSqnMNMDhdYvUKRhsLC
 jlDSTcXVcM1WfRoiEV40Pqz/2MsMRz3svHCuvzH21Aero61wavNxPRfao
 81vwGJ19ZdUY1FMlUhY/ytjsMJakbLaiyxaheoByNHGBpNXWF2yr+j+Hm
 j+SUo0giuJpv05EHJdVgq6clTO6XzALFYougqChwsfU3rCWG59WVTfYet Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="380071495"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; d="scan'208";a="380071495"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 01:48:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="870285902"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; d="scan'208";a="870285902"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Sep 2023 01:48:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 01:48:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 01:48:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 01:48:46 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 01:48:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9HOvtlCU0OpvOs1rLP50GmoUrAFOKIvihRhVzW9aviJeW5eCi27y6G7zVXbmFYypWxHF2XUigVh6T0RDNgswbGNfogJ95qSBwir6LYV8FP9uQO/ga5brkf5cwXWjU8oV9u3kzUh4yHtiC+YHLSzqqCMw82Ep5Xs00iRXQS7yAGBD85vneq4Ti7I1YSRwX25n+Wjq739+cYlyVNBNb3+falHFmtneLUsMW9ipjwdjwtg2bqoJtze7wdcE3LDq8LbP1hgNWquL58hcJvOWO7YfoNNI2UfWiel0M72YfvfWRnMBMqKUYYtaJLjYQ928EzEEQNKBD0t0acIsPSCTl+VaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iop84TM3b4Lkjvn41thv4XA9GqO7HZZuNPUdjMtNwgI=;
 b=VudlPI4Z8hRRqq7aTtuhMiwwOXfsv+At2OvvbTJgODCFfgDw0Iv+lMXHWhTnC0cMhK3PfE7h7R7dvrdOyZz73MGe7m+AmcyShyyYOT5iZMky2AAPgLMJicaTAIi4WP0vpeszz4xgDVU1pd02n4H1NRFcb1v0HpZprRXtH0nCc0/Q60X2kvpW+H9GBYH+7Cx9nue8nw5H2nkYzdOy736Ma8QDD3J4gIP9A/Pp5R1lUpUXGVJono+7oO5xsxybxNxgNV5RjdzrizErusHcx7bj5WeTBiviQzKmo5ZVG7+ldjecs/mNdtqjsLvL9/m7hYm8YB5tr5y4O4DmE4kGBzBpFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM8PR11MB5687.namprd11.prod.outlook.com (2603:10b6:8:22::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.28; Wed, 20 Sep 2023 08:48:42 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 08:48:42 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "open list:sPAPR (pseries)"
 <qemu-ppc@nongnu.org>
Subject: RE: [PATCH v1 13/22] vfio: Add base container
Thread-Topic: [PATCH v1 13/22] vfio: Add base container
Thread-Index: AQHZ2zBKcvHai3HTVU61uaTXJ4y/6rAihaoAgADiycA=
Date: Wed, 20 Sep 2023 08:48:42 +0000
Message-ID: <SJ0PR11MB67449058E09E80EB7891381F92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-14-zhenzhong.duan@intel.com>
 <eb3c51e0-d1ba-1452-6f85-786f7c36411a@redhat.com>
In-Reply-To: <eb3c51e0-d1ba-1452-6f85-786f7c36411a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM8PR11MB5687:EE_
x-ms-office365-filtering-correlation-id: 47291ed5-0b23-4463-7d2e-08dbb9b664ae
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vy1P4aOqJLGivbiOGiCNIIztJKeMFfNmJhiquk+zPAn0NSmzIg4RP5lwA7gzsVzK5WI/l34Uu9m0gJWt8EAiHUwY2hI2SE54X+pQXGjed2jd+pUrZ7/1DOJG/jkauG/qjno/d6ugUKuKJtn5dw3Ewzl2V1KbO4UuZ9imW8HhoBQS2C1GXikW69sAUApfJ6BkzWTsXaFQeL/T/fHs6PGvy0CnOSoOkgwbxHodD4Ol3u3gHdYyOstnSQ25kUL9yTorxe9ML1NOnzEsLlL+nprT6N2GXgo024n4DDAn2oZPgjZn7zE8X5V9wYwtRS+hjPTJGiP3z7no2LvYzANGP52SV8eeKrIISDodhFoqHLiH4QWkdScYc7GlErhEBCi6cABaIa01qqFCpl/X4BpLaDcGZeNMl/xRs+nHGX11pMvnWy0qZpfEaR5xLXiJNB+LTrynvNWhuupX0eImV5wLTBDlhsJLh6bqUXzi7DZEajhYkeJUK4kYmhuBOc2BVX/1yRgpUln02aifK1XYYS0k5//vEtg58M+sYbehCzjji2dhjSGc1pDgZBUeRyiHo1zeoA99H/B0XLY+yR+5P3zB4mKCflEU95lBrrRUyB1oNHO5cwQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199024)(1800799009)(186009)(83380400001)(55016003)(5660300002)(54906003)(316002)(76116006)(66556008)(66946007)(66446008)(110136005)(66476007)(8676002)(8936002)(7416002)(52536014)(41300700001)(2906002)(4326008)(86362001)(38070700005)(38100700002)(478600001)(33656002)(966005)(64756008)(9686003)(7696005)(6506007)(71200400001)(82960400001)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXJMZDdVMy9MaXY2TlVQUnJBUDAzTldGMVpiNHBWYVZyWk9qbTRWdHFHbHBz?=
 =?utf-8?B?OWs5UFBqWUYxRmNPZEFqWHZ2WlV5Szg3ZEFOdkdxNDJGbWlvWGI5VWZSejBZ?=
 =?utf-8?B?cXVmeFVISW94MG44VFA5dWY3NmhDUjBqY3IvNlNSUmpiYjdkQ3psdTF3NHJl?=
 =?utf-8?B?Mnk4aDREOUN1OUxqb1MwRnhmaCtOdkJyLzlLOWJMRlM2UTRBc2x2WXpTdEJX?=
 =?utf-8?B?dmpTdzJwc3A4MTMxZUxtSHBYWHV1TUtCMkNKWGdDeXVnT25ROTI5ejZiUWtl?=
 =?utf-8?B?dXBLUXBNZjdEVHViZGYyVEhlVFNPalFlY25iUGdxOUE3YTVvb3Z2N0xhV0Jl?=
 =?utf-8?B?c0c2MUg1LzRLbEZwcXJZQWc1bThDZUtHaUgyTUUreHVkUk5pbDBBTm1aRU92?=
 =?utf-8?B?VGMvbDJraTg5aHA3eGt6c29QVlhmVWNCc05CcjhEZVdWTU9mV0FaREQyVzFt?=
 =?utf-8?B?NUwrVmdQZFJPMk1IMlpUMElGMWVXODVNdzZkcUNDYm9sTUpRcVlvYks1MmhP?=
 =?utf-8?B?U0x6OFR0M1ZnVXZjVGRCWnQwMjViK001enQ1WEo3TjZEbHJ1VnA0ZkYrQ2lM?=
 =?utf-8?B?cmNoakk4YmRUeGgva21MNi9Uamt6SkdyZStMQk5mV1crcWpQYktYTjM5VFJi?=
 =?utf-8?B?Vit1WjBuR3o5VDJQbUhJNEttQ1lPd25veC9VSE91SXA5bEYzWCtDNVZFcURF?=
 =?utf-8?B?Nml5K29Xc2pTS2IvRXBTNlQ5Zlc3SllqRXhkU2thNHJkQWY0NkpwZ08wVzF3?=
 =?utf-8?B?UEtGc1VQYzlscW90TVl5L0g4dUNQSUM5QUNBNlhiRlZnOFNIL3FUVTc2RHV1?=
 =?utf-8?B?LzNTL0owWEU2aEJjM0VPKzB6SG5IWUthVzRIanAwRHJsRWlTSWh4c1hUa3pX?=
 =?utf-8?B?WlBqQzFtem1LaDBiODZqZjBITmF1ZUhBTGpZTEJQVmlvU3MybnJqKy9TTEp4?=
 =?utf-8?B?RkpialRoRndxdE9ydGRWODhQMTN1SzZEVjNlWldwVytGUHR2NE5UN1dmNGgw?=
 =?utf-8?B?TjZIdTBVWjlzb3dteXNtNmN2SEFUVHhVdVhCSVhvYzlOelIvUDhnUVBDZDJx?=
 =?utf-8?B?bCs1dkRPenVmd0N0THNRZ0t3YXFFdTc1RE5hWlRSTG9Xa2IxZEdzVHZxU01R?=
 =?utf-8?B?YUk1dHFxUVhZb2FkUWw1a0hwRVVuSkpVRmNtT2pndCttS041YkUwOEh0Sm0r?=
 =?utf-8?B?Ym1KSDkxRUh1ZGppVi8weDhSYUtncGY2cmtSRURNaFdLbnNKSnNiTEwvQlVl?=
 =?utf-8?B?aGhNdFIxWk9tRGN1d25lMVhwZHdYMm52M2RnY3piTkdzdENHQmIxTTlMMDl2?=
 =?utf-8?B?T3NodzhpYUFOWHlteEE4aWNnNDFvUTZQSXV3QUpzRXYwVFpZNThNZ1pQdlRU?=
 =?utf-8?B?d3lVcFVqT3AvU2owZy9seEZBWEV4WDlGU3Myb25ZWHp3VlI3UExadGI2djdR?=
 =?utf-8?B?T0hxd3dWRnRNRXhpUFBrNUFXc2NnUFJWU1pjMzZtMytCODQvT1RGR1RVLzRL?=
 =?utf-8?B?Mk1xcVRtNk0xTytzeXNtWHArSWhMVDY3OThJTW85a01CeGxoVzJJWnBSelJG?=
 =?utf-8?B?SnpCaCtFWGRuZCtwaEZiYWVyakdCdTlZQ2NxTE10V3dLa2U0TjhSVi83aTZE?=
 =?utf-8?B?WTU5c2pGcGZYUDRTWHFLK2tsM1dsWFQvRkp3OU5MNUY2ZHgxb3J2VEpkc3lL?=
 =?utf-8?B?cjVreitxNkFVdGs5bkVpQnlXc29RYVFSZ3AvRHZ2aWFhMUdQcGR5dVhEMU5n?=
 =?utf-8?B?dUZQcFBBWmVOeWN4QVhYRS90Q2NPUHFseEJ5R1ZrRi9INHJSZXhlQzhxeHBJ?=
 =?utf-8?B?M01aMmEyNnM2aUlYL094ZzczeFpWOVFuSm9mWk12V2x1cEhadDc0SThKM3ly?=
 =?utf-8?B?U0VjY092UmlYaUFtOXBZMzdLOTRJZ1FydXR0WVEwcFhhRkRNc3E3S1ErMm90?=
 =?utf-8?B?Q3Blc3BPNUdlbXdJREpiSUROSnFIZkpxblB4eEhLQ3FHNmthUGdPa0NOR0FQ?=
 =?utf-8?B?T0NoTi9FWUNNalFYd0JLVkcwdGJBeVhBOTdoWjhLckFwcGgrd3pXMERNQzVE?=
 =?utf-8?B?VDVIMUlZR1lTbUhNZUhPZVRCV0tmYmxaSHJEY081NDlvT1lpbWNEay9WVUhu?=
 =?utf-8?Q?0rhU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47291ed5-0b23-4463-7d2e-08dbb9b664ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 08:48:42.7398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIHn8v4jiIkPYxrWQz7xN6K+spq1TCSaF9NlguPgv9YwM61GUalYq/VlI8OuOqqZZ8i3UUSooCUqbSJdNc7+PYX4tG0zsPeZ3qEdIBgsxxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5687
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyMCwgMjAyMyAx
OjI0IEFNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MSAxMy8yMl0gdmZpbzogQWRkIGJhc2UgY29u
dGFpbmVyDQo+DQo+T24gOC8zMC8yMyAxMjozNywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBG
cm9tOiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+DQo+PiBBYnN0cmFjdCB0aGUgVkZJ
T0NvbnRhaW5lciB0byBiZSBhIGJhc2Ugb2JqZWN0LiBJdCBpcyBzdXBwb3NlZCB0byBiZQ0KPj4g
ZW1iZWRkZWQgYnkgbGVnYWN5IFZGSU8gY29udGFpbmVyIGFuZCBsYXRlciBvbiwgaW50byB0aGUg
bmV3IGlvbW11ZmQNCj4+IGJhc2VkIGNvbnRhaW5lci4NCj4+DQo+PiBUaGUgYmFzZSBjb250YWlu
ZXIgaW1wbGVtZW50cyBnZW5lcmljIGNvZGUgc3VjaCBhcyBjb2RlIHJlbGF0ZWQgdG8NCj4+IG1l
bW9yeV9saXN0ZW5lciBhbmQgYWRkcmVzcyBzcGFjZSBtYW5hZ2VtZW50LiBUaGUgVkZJT0NvbnRh
aW5lck9wcw0KPj4gaW1wbGVtZW50cyBjYWxsYmFja3MgdGhhdCBkZXBlbmQgb24gdGhlIGtlcm5l
bCB1c2VyIHNwYWNlIGJlaW5nIHVzZWQuDQo+Pg0KPj4gJ2NvbW1vbi5jJyBhbmQgdmZpbyBkZXZp
Y2UgY29kZSBvbmx5IG1hbmlwdWxhdGVzIHRoZSBiYXNlIGNvbnRhaW5lciB3aXRoDQo+PiB3cmFw
cGVyIGZ1bmN0aW9ucyB0aGF0IGNhbGxzIHRoZSBmdW5jdGlvbnMgZGVmaW5lZCBpbiBWRklPQ29u
dGFpbmVyT3BzQ2xhc3MuDQo+PiBFeGlzdGluZyAnY29udGFpbmVyLmMnIGNvZGUgaXMgY29udmVy
dGVkIHRvIGltcGxlbWVudCB0aGUgbGVnYWN5IGNvbnRhaW5lcg0KPj4gb3BzIGZ1bmN0aW9ucy4N
Cj4+DQo+PiBCZWxvdyBpcyB0aGUgYmFzZSBjb250YWluZXIuIEl0J3MgbmFtZWQgYXMgVkZJT0Nv
bnRhaW5lciwgb2xkIFZGSU9Db250YWluZXINCj4+IGlzIHJlcGxhY2VkIHdpdGggVkZJT0xlZ2Fj
eUNvbnRhaW5lci4NCj4NCj5Vc3VhbHksIHdlIGludHJvZHVjZSB0aGUgbmV3IGludGVyZmFjZSBz
b2xlbHksIHBvcnQgdGhlIGN1cnJlbnQgbW9kZWxzDQo+b24gdG9wIG9mIHRoZSBuZXcgaW50ZXJm
YWNlLCB3aXJlIHRoZSBuZXcgbW9kZWxzIGluIHRoZSBjdXJyZW50DQo+aW1wbGVtZW50YXRpb24g
YW5kIHJlbW92ZSB0aGUgb2xkIGltcGxlbWVudGF0aW9uLiBUaGVuLCB3ZSBjYW4gc3RhcnQNCj5h
ZGRpbmcgZXh0ZW5zaW9ucyB0byBzdXBwb3J0IG90aGVyIGltcGxlbWVudGF0aW9ucy4NCg0KTm90
IHN1cmUgaWYgSSB1bmRlcnN0YW5kIHlvdXIgcG9pbnQgY29ycmVjdGx5LiBEbyB5b3UgbWVhbiB0
byBpbnRyb2R1Y2UNCmEgbmV3IHR5cGUgZm9yIHRoZSBiYXNlIGNvbnRhaW5lciBhcyBiZWxvdzoN
Cg0Kc3RhdGljIGNvbnN0IFR5cGVJbmZvIHZmaW9fY29udGFpbmVyX2luZm8gPSB7DQogICAgLnBh
cmVudCAgICAgICAgICAgICA9IFRZUEVfT0JKRUNULA0KICAgIC5uYW1lICAgICAgICAgICAgICAg
PSBUWVBFX1ZGSU9fQ09OVEFJTkVSLA0KICAgIC5jbGFzc19zaXplICAgICAgICAgPSBzaXplb2Yo
VkZJT0NvbnRhaW5lckNsYXNzKSwNCiAgICAuaW5zdGFuY2Vfc2l6ZSAgICAgID0gc2l6ZW9mKFZG
SU9Db250YWluZXIpLA0KICAgIC5hYnN0cmFjdCAgICAgICAgICAgPSB0cnVlLA0KICAgIC5pbnRl
cmZhY2VzID0gKEludGVyZmFjZUluZm9bXSkgew0KICAgICAgICB7IFRZUEVfVkZJT19JT01NVV9C
QUNLRU5EX09QUyB9LA0KICAgICAgICB7IH0NCiAgICB9DQp9Ow0KDQphbmQgYSBuZXcgaW50ZXJm
YWNlIGFzIGJlbG93Og0KDQpzdGF0aWMgY29uc3QgVHlwZUluZm8gbnZyYW1faW5mbyA9IHsNCiAg
ICAubmFtZSA9IFRZUEVfVkZJT19JT01NVV9CQUNLRU5EX09QUywNCiAgICAucGFyZW50ID0gVFlQ
RV9JTlRFUkZBQ0UsDQogICAgLmNsYXNzX3NpemUgPSBzaXplb2YoVkZJT0lPTU1VQmFja2VuZE9w
c0NsYXNzKSwNCn07DQoNCnN0cnVjdCBWRklPSU9NTVVCYWNrZW5kT3BzQ2xhc3Mgew0KICAgIElu
dGVyZmFjZUNsYXNzIHBhcmVudDsNCiAgICBWRklPRGV2aWNlICooKmRldl9pdGVyX25leHQpKFZG
SU9Db250YWluZXIgKmNvbnRhaW5lciwgVkZJT0RldmljZSAqY3Vycik7DQogICAgaW50ICgqZG1h
X21hcCkoVkZJT0NvbnRhaW5lciAqY29udGFpbmVyLA0KICAgIC4uLi4uLg0KfTsNCg0KYW5kIGxl
Z2FjeSBjb250YWluZXIgb24gdG9wIG9mIFRZUEVfVkZJT19DT05UQUlORVI/DQoNCnN0YXRpYyBj
b25zdCBUeXBlSW5mbyB2ZmlvX2xlZ2FjeV9jb250YWluZXJfaW5mbyA9IHsNCiAgICAucGFyZW50
ID0gVFlQRV9WRklPX0NPTlRBSU5FUiwNCiAgICAubmFtZSA9IFRZUEVfVkZJT19MRUdBQ1lfQ09O
VEFJTkVSLA0KICAgIC5jbGFzc19pbml0ID0gdmZpb19sZWdhY3lfY29udGFpbmVyX2NsYXNzX2lu
aXQsDQp9Ow0KDQpUaGlzIG9iamVjdCBzdHlsZSBpcyByZWplY3RlZCBlYXJseSBpbiBSRkN2MS4N
ClNlZSBodHRwczovL2xvcmUua2VybmVsLm9yZy9rdm0vMjAyMjA0MTQxMDQ3MTAuMjg1MzQtOC15
aS5sLmxpdUBpbnRlbC5jb20vDQoNCj4NCj5zcGFwciBzaG91bGQgYmUgdGFrZW4gY2FyZSBvZiBz
ZXBhcmF0bHkgZm9sbG93aW5nIHRoZSBwcmluY2lwbGUgYWJvdmUuDQo+V2l0aCBteSBQUEMgaGF0
LCBJIHdvdWxkIG5vdCBldmVuIHJlYWQgc3VjaCBhIG1hc3NpdmUgY2hhbmdlLCB0b28gcmlza3kN
Cj5mb3IgdGhlIHN1YnN5c3RlbS4gVGhpcyBwYXRoIHdpbGwgbmVlZCAobXVjaCkgZnVydGhlciBz
cGxpdHRpbmcgdG8gYmUNCj51bmRlcnN0YW5kYWJsZSBhbmQgYWNjZXB0YWJsZS4NCg0KSSdsbCBk
aWdnaW5nIGludG8gdGhpcyBhbmQgdHJ5IHRvIHNwbGl0IGl0LiBNZWFud2hpbGUsIHRoZXJlIGFy
ZSBtYW55IGNoYW5nZXMNCmp1c3QgcmVuYW1pbmcgdGhlIHBhcmFtZXRlciBvciBmdW5jdGlvbiBu
YW1lIGZvciBjb2RlIHJlYWRhYmlsaXR5Lg0KRm9yIGV4YW1wbGU6DQoNCi1pbnQgdmZpb19kbWFf
dW5tYXAoVkZJT0NvbnRhaW5lciAqY29udGFpbmVyLCBod2FkZHIgaW92YSwNCi0gICAgICAgICAg
ICAgICAgICAgcmFtX2FkZHJfdCBzaXplLCBJT01NVVRMQkVudHJ5ICppb3RsYikNCitzdGF0aWMg
aW50IHZmaW9fbGVnYWN5X2RtYV91bm1hcChWRklPQ29udGFpbmVyICpiY29udGFpbmVyLCBod2Fk
ZHIgaW92YSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgIHJhbV9hZGRyX3Qgc2l6ZSwgSU9N
TVVUTEJFbnRyeSAqaW90bGIpDQoNCi0gICAgICAgIHJldCA9IHZmaW9fZ2V0X2RpcnR5X2JpdG1h
cChjb250YWluZXIsIGlvdmEsIHNpemUsDQorICAgICAgICByZXQgPSB2ZmlvX2dldF9kaXJ0eV9i
aXRtYXAoYmNvbnRhaW5lciwgaW92YSwgc2l6ZSwNCg0KTGV0IG1lIGtub3cgaWYgeW91IHRoaW5r
IHN1Y2ggY2hhbmdlcyBhcmUgdW5uZWNlc3Nhcnkgd2hpY2ggY291bGQgcmVkdWNlDQp0aGlzIHBh
dGNoIGxhcmdlbHkuDQoNCj4NCj5BbHNvLCBwbGVhc2UgaW5jbHVkZSB0aGUgLmggZmlsZSBmaXJz
dCwgaXQgaGVscHMgaW4gcmVhZGluZy4NCg0KRG8geW91IG1lYW4gdG8gcHV0IHN0cnVjdCBkZWNs
YXJhdGlvbiBlYXJsaWVyIGluIHBhdGNoIGRlc2NyaXB0aW9uPw0KDQo+IEhhdmUgeW91IGNvbnNp
ZGVyZWQgdXNpbmcgYW4gSW50ZXJmYWNlQ2xhc3MgPw0KDQpTZWUgYWJvdmUsIHdpdGggb2JqZWN0
IHN0eWxlIHJlamVjdGVkLCBpdCBsb29rcyBoYXJkIHRvIHVzZSBJbnRlcmZhY2VDbGFzcy4NCg0K
VGhhbmtzDQpaaGVuemhvbmcNCg0K

