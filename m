Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BC27CEE13
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 04:31:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtInZ-0003GY-1v; Wed, 18 Oct 2023 22:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qtInW-0003Fz-TQ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 22:30:06 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qtInS-0006U9-Pi
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 22:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697682602; x=1729218602;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lnHiIIGgZXaWR2GMjrMSRErzwxsfZRUElI5wPWi6ki0=;
 b=IjBF3+CKWAj4RPhZ4Tm2lC61iqpqOEpatlsKeaOT41PFN8BYSUWkNUjc
 lDN2LxOp9E2DITfT6HxDeEwkxYSkSm96DYX04QgKcV8YvkudKmetTv3TT
 k9vtl1JcloOIEfLW4zrgd9dqBQmFrfWCkaI9mZGPS9BriGQFitKMfeUHE
 spocJmK3uQF3a4ujkP0iQfXoKnVkQKVjKJkjKAe1EQWhlrKnu1pqhN2Ug
 mCt87RW7csqozY1445zJCjwCVmQoSDiMsRHZtyuP3+oGrh5zK98mk1it9
 IxxYhWtPyMWCXtstHv4Zkr613xPKyUud/BQdoUgsH3s+WFlpa92bj0gNf g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="371221215"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; d="scan'208";a="371221215"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2023 19:29:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="750340045"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; d="scan'208";a="750340045"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Oct 2023 19:29:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 19:29:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 19:29:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 19:29:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDmae2BDteOvZYgr++5yRy8EXN/zMYtt/f0ZcyBl39cALCixc9MxtIUixUIw6bZWbXdK9XYZLqRGD6TD3wXgFwgzmast6aR0mvvmoJN+ARWEaYflMZKTRbb9eB3HulcHepjCUZNXOQ+v4NLpgESeoCM2U4je2a3DnLdC+yIQRghkA6TsG/3GMbyg7piilFSDt98AOdYlC6j7eKoVdctkJypZLqux9rIQD3fRnR5FkFW7EjZUXi+L+v8igJItl4y4uFGtSk79Xmhe1zWoDKBmq6HwOXBBq3HFME6RUpe9hu8zN2vCz3j5AlHmSp7pL4wOkBMMgg60MWf31NFuwVJkPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnHiIIGgZXaWR2GMjrMSRErzwxsfZRUElI5wPWi6ki0=;
 b=MKgSJ1b0LY0OMVH9mz/Vh3Z8wDoxnp7/p3PJOCOJd0GkHdf2sa79xxXdK09VZCHpEFHgviHCjveTsMETF5r7FuiDtc9kAhHI6MQNcJBV/G80tvZtegPGyj3NVPqbvK7PKLdAOo+iEYx9pMjQAfYgkUIOFRhKOjmxY7nqDXoGP5CrmCRqhQYfgWPzWyTYVsz7Ws8P96MyIEAVP4ycLz/G0XdIPeeL4mPGHJESnEF1KKUmIrtgJok0c1BE9e84TqQT2O8OaVH3B3jcDDflPA8ykUSXym2522A9oLiN0MmEDsTIfjtreuODosB4xYTELVEM5wAZpwCJI+PhbNvhYGjklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by SJ2PR11MB8345.namprd11.prod.outlook.com (2603:10b6:a03:53c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.37; Thu, 19 Oct
 2023 02:29:55 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a%3]) with mapi id 15.20.6863.043; Thu, 19 Oct 2023
 02:29:55 +0000
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
 <yi.y.sun@linux.intel.com>, David Gibson <david@gibson.dropbear.id.au>
Subject: RE: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer
 and targetted interface
Thread-Topic: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer
 and targetted interface
Thread-Index: AQHaAA1niboIxiaoHk+mLfxtQdCD+rBOI2WAgACzxLCAAFwsgIABLpGg
Date: Thu, 19 Oct 2023 02:29:55 +0000
Message-ID: <PH7PR11MB67226A6A32A4655138CE1C8A92D4A@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
 <20231016083223.1519410-3-zhenzhong.duan@intel.com>
 <f8089865-20cf-4f11-981a-e593a103a387@redhat.com>
 <PH7PR11MB6722FF23DC574EB09300075292D5A@PH7PR11MB6722.namprd11.prod.outlook.com>
 <c5c0c0ff-3eb1-4b46-b39c-e4e7fa250618@redhat.com>
In-Reply-To: <c5c0c0ff-3eb1-4b46-b39c-e4e7fa250618@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|SJ2PR11MB8345:EE_
x-ms-office365-filtering-correlation-id: bab24d7c-1ac1-423f-0356-08dbd04b484a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GiPZSro/y5EwvEO1Fx1UhUWwRgsc87ZbVfMR0ErqhDrj0B2ytH6IhV4WuzlNLRqzaPv0qg5+ALgViKXQs3f64aH864nUHT4nlVQmNzFmd9CKQ4GzrGK3snJeZ2UKmHTrGoFdSIT7KBnS7EF8VzzPjVsPtR/Ifm+qwmEjGHXNifoPZtT0Dn6XBhW3y8Y7BE0PsaaevXNq9G1iw+AMVdd/3qWbHK216S6/yjJdqkPbudi9rUSUm2o+7jloPne28zK11mtHg00lQ0EhvK40NtQm8nhIT/q6GZVNh9rLMmmvhzcQDcH+5J6+MnGn/uYDoMV9gitQwhcFmpR+/yAEnNJFtoB5i4eTMy6NlHDLMx1FXb7shSnA/43yn/FIDUzR7PFYv6XuNsgu3yilU7FYHu7Rj7Y1Cgd/7aa194rP4kFBnHiEwbv9+sDE4k+Do4Ta+pU38Q/AP/ru6qaTHDeMoSFEehEzeaWvO0Uxvcwl/zTKjH2zykBzVr3+K453w8P28Xg8dfRMcTtGgVkwET75Rf6J8lmneiUthRjMIiZyraAhldTgMVWW25r7YrmP3p5A1GspuD6u2xbQRt7vMi6YizTfdgsV+g4ZQVKxREPyC+8VYW6hGBrTOFj0w+ljSXnnYeCATnsSiNHhX51jlTbcJR3jkY1hvdRzM3jewXSm9yKCK8s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(7696005)(316002)(966005)(66446008)(66476007)(64756008)(66556008)(76116006)(54906003)(66946007)(110136005)(26005)(83380400001)(38100700002)(66574015)(71200400001)(122000001)(38070700005)(86362001)(33656002)(82960400001)(9686003)(55016003)(478600001)(53546011)(2906002)(7416002)(6506007)(41300700001)(5660300002)(52536014)(4326008)(8676002)(8936002)(2004002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW1kWG53WnpocC84NEN3MnZxaFlUUnhqWmJKbEsxS2lBNEl2S1V0c09PU1ZY?=
 =?utf-8?B?VnlEV0Y3aFRzWVEwdCtkakVCdnB4VXNybzRJQkljWUg1Z3VsQlptMkxXVDZD?=
 =?utf-8?B?VXBFVW5kMWlRM2hZNGhQbHhJYWNiZ3dqMjdjYkVkM0sxZThNLzRWRGlLWVF1?=
 =?utf-8?B?R2NBZWd4QTA4dU5ycEd5WnVzelZKNjlhZTh6bUtQUDYxZVk4cktLT09MMlY0?=
 =?utf-8?B?ZzQ4ZlRuMXNDbU1SNVVldGdGZTFuOFJjYVN5UytOaSsvOWE5MjNWNGRJeXcr?=
 =?utf-8?B?bVhpL1RzbkNDUkwwQUoyM09CeHo4Y1BvdzNvRGJ0cHNYV2xnS0IyTDNuOWJW?=
 =?utf-8?B?SEliOVY2OHE1SFhwMStLYmF1WUhaZm1sWk5JL3JKbXoyMk9VUG1raS9tblRJ?=
 =?utf-8?B?R0huT09PS1pDNVRuZlpMRjIzcTJiTWtzL0g0MU5Kc0JEcFVPN1NCMHFMK2hV?=
 =?utf-8?B?R1RTVlI1eERjeVJmQmhNaXJ1K1hTa1RDdXdsTUlUbTFHTTJiYklKdFBrekFV?=
 =?utf-8?B?MTBRRERWMVJXaG5OZUN2QUVXUkhRdmNUN3BhMVRHZGlTWXU1c3BkZmx6YkpV?=
 =?utf-8?B?RDNCaG5NMUF3T0ZlbE14aVJVc3NzY2QzbmViZmxyZmVDVjZKdDJRRHZROHhS?=
 =?utf-8?B?QTFSSEpJZ05zRlIzaTA3NUJUNUhUQ2krQXFJS3BpR2VENTZ4WFNJcE5RMzlW?=
 =?utf-8?B?Ky8yY0o2ZElIcHo4N3lsdGJQQlJxY2t1OFdqZzZyejQ4SW1CbThaempuUTJp?=
 =?utf-8?B?RmJKR3pyNGxJUUJYZjU1eksrK0NoS0tBVDBtWW1qT3dtMTBPVE9jRThzTHVq?=
 =?utf-8?B?L2RQajNPRmJFUkN5ekJhYUFBMVVwWVlQVGp3RmxtbWYxZFJHMUZEbXBOaWph?=
 =?utf-8?B?bWlweHR0RXNmNmN6UDNLbjZ4MytTOE5uUHdKOVNYU0tHK3VJdVFJeVJ5QTVx?=
 =?utf-8?B?a0hQNDI2K3RpY2tLYWZDV0dGZzVFNjREQTVWQUkyVCtrazhxWGRNRkhibHly?=
 =?utf-8?B?c3BzZ3F4QzVxSFZNR3pBUC9KK0MzYWx3RXFqTXNaRURMTWpoaDB5VzdFOXFp?=
 =?utf-8?B?UGNGU3RzMmQ2dURkQWJrVVVRd2tWWitTaUtNM1VmZy9pT3hrdTBFcmFiQ2NQ?=
 =?utf-8?B?WW94eWxtbEk2eGx5emFhOWNBMlRSOHIvM2lNTG5qSFIwTVZadFlCbEhIK212?=
 =?utf-8?B?c1dML2pmT3RCZlp1NS96UVRZZ29KOEc0SW1ubm9jVnJaNEdsZVZ2Y3k4OHVn?=
 =?utf-8?B?QnM0bnJGbjhyUit2Yk9uUG0rTE1va1RnSVovbm1HY2tSaVlieGVHWmVreWJP?=
 =?utf-8?B?RmNvWmRSREgwSVZtakRTVTBZUjU3NzJkZnhjNk5lOXZOSE10UUVwak1SSGFj?=
 =?utf-8?B?bVBKT0ZyVlFUclJCK28rNkxKNzl5RzVXRlo5SjIvWldNdjVRblJ6elV4Q1ZD?=
 =?utf-8?B?SjI0aThlOUFuMkNYTzhQcE5qS2VjVW45RzUrc1dUK3JmcDBMenNOdTFpTkZF?=
 =?utf-8?B?cVN5ZlpKdUsvM0MxUFlmeFR4MFZUTllWblBmZGcyNGVvbDVqSGJuck9ienZ4?=
 =?utf-8?B?UE5hVFFEWTdSTkFNZ1c4MGhybmVRRmlBZDRFQ1I4Z2IxQW1uWUJDeWxha1Rn?=
 =?utf-8?B?dENwTmFwT21XWVgxaE9MRmtqb0oyY2xuaWRzc3AxdGZNNlNTOGVFaTBWekJD?=
 =?utf-8?B?Z1ZKTVcvZUNUSlJ5bXVMcEJ6V0pNY2t1cjE2ZXBYbzNTd2RjYmwzUkVscHg5?=
 =?utf-8?B?K2ZtcEhxaUE4L1pYeklJQVhIclhaYjlGUnkrYVZESlVVOWtyWFhTdXRWTHlG?=
 =?utf-8?B?bmUxS0RhcGRuSnZudHlJb0toZDg3dFp4cHlFT0VDcXVPa214OFVnZ1FIV3JG?=
 =?utf-8?B?MXBkUTJ5Q2ZNTkRNYmVyaU16WnRqTmNQYmdzSGF0SVdtd2I5MWhMMlNvMjRL?=
 =?utf-8?B?ZHMrTklNMlBmbGJxK1pVSFdjSFU3c0tleE5iMDBYekRvSVlBd0pMbFVqQ0po?=
 =?utf-8?B?cVhZbEtIYTdTY1ozUzkxa3I2SmszNHhHUncvS3d1aXRhamJIRG1pWTlOeWpY?=
 =?utf-8?B?RXdSOU5JL0t1NytHZHI2UUF5SHZmemc4b2VCZlhuSFFBbGdXWHhvQzV5TTNt?=
 =?utf-8?Q?QVl5oenqwl/ZDhoGrVfYahVmA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab24d7c-1ac1-423f-0356-08dbd04b484a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 02:29:55.6387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ccmc07D2Qw/fj7gp2fz3mPflbO1gXRr5g5kwuheJcPpqVwjiz2/hULu1Wgl38eGf/Y046xJWQVWiHfDZ5ehkGAdHoV5WKj4dyTyXSLz83X0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8345
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNs
Z0ByZWRoYXQuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAxOCwgMjAyMyA0OjA0IFBN
DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MiAwMi8yN10gdmZpbzogSW50cm9kdWNlIGJhc2Ugb2Jq
ZWN0IGZvciBWRklPQ29udGFpbmVyIGFuZA0KPnRhcmdldHRlZCBpbnRlcmZhY2UNCj4NCj5PbiAx
MC8xOC8yMyAwNDo0MSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4gSGkgQ8OpZHJpYywNCj4+
DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBDw6lkcmljIExlIEdv
YXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+Pj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAxNywgMjAy
MyAxMTo1MSBQTQ0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDIvMjddIHZmaW86IEludHJv
ZHVjZSBiYXNlIG9iamVjdCBmb3IgVkZJT0NvbnRhaW5lcg0KPmFuZA0KPj4+IHRhcmdldHRlZCBp
bnRlcmZhY2UNCj4+Pg0KPj4+IE9uIDEwLzE2LzIzIDEwOjMxLCBaaGVuemhvbmcgRHVhbiB3cm90
ZToNCj4+Pj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4+Pg0K
Pj4+PiBJbnRyb2R1Y2UgYSBkdW1iIFZGSU9Db250YWluZXIgYmFzZSBvYmplY3QgYW5kIGl0cyB0
YXJnZXR0ZWQgaW50ZXJmYWNlLg0KPj4+PiBUaGlzIGlzIHdpbGxpbmdseSBub3QgYSBRT00gb2Jq
ZWN0IGJlY2F1c2Ugd2UgZG9uJ3Qgd2FudCBpdCB0byBiZQ0KPj4+PiB2aXNpYmxlIGZyb20gdGhl
IHVzZXIgaW50ZXJmYWNlLiAgVGhlIFZGSU9Db250YWluZXIgd2lsbCBiZSBzbW9vdGhseQ0KPj4+
PiBwb3B1bGF0ZWQgaW4gc3Vic2VxdWVudCBwYXRjaGVzIGFzIHdlbGwgYXMgaW50ZXJmYWNlcy4N
Cj4+Pj4NCj4+Pj4gTm8gZnVjbnRpb25hbCBjaGFuZ2UgaW50ZW5kZWQuDQo+Pj4+DQo+Pj4+IFNp
Z25lZC1vZmYtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+Pj4gU2ln
bmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYt
Ynk6IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50ZWwuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5
OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+PiAtLS0NCj4+
Pj4gICAgaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggICAgICAgICB8ICA4ICstLQ0KPj4+
PiAgICBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oIHwgODINCj4rKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCA4NCBpbnNlcnRp
b25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPj4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVk
ZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaA0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby0NCj5j
b21tb24uaA0KPj4+PiBpbmRleCAzNDY0OGU1MThlLi45NjUxY2Y5MjFjIDEwMDY0NA0KPj4+PiAt
LS0gYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPj4+PiArKysgYi9pbmNsdWRlL2h3
L3ZmaW8vdmZpby1jb21tb24uaA0KPj4+PiBAQCAtMzAsNiArMzAsNyBAQA0KPj4+PiAgICAjaW5j
bHVkZSA8bGludXgvdmZpby5oPg0KPj4+PiAgICAjZW5kaWYNCj4+Pj4gICAgI2luY2x1ZGUgInN5
c2VtdS9zeXNlbXUuaCINCj4+Pj4gKyNpbmNsdWRlICJody92ZmlvL3ZmaW8tY29udGFpbmVyLWJh
c2UuaCINCj4+Pj4NCj4+Pj4gICAgI2RlZmluZSBWRklPX01TR19QUkVGSVggInZmaW8gJXM6ICIN
Cj4+Pj4NCj4+Pj4gQEAgLTgxLDYgKzgyLDcgQEAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0FkZHJlc3NT
cGFjZSB7DQo+Pj4+ICAgIHN0cnVjdCBWRklPR3JvdXA7DQo+Pj4+DQo+Pj4+ICAgIHR5cGVkZWYg
c3RydWN0IFZGSU9MZWdhY3lDb250YWluZXIgew0KPj4+PiArICAgIFZGSU9Db250YWluZXIgYmNv
bnRhaW5lcjsNCj4+Pg0KPj4+IFRoYXQncyB0aGUgcGFyZW50IGNsYXNzLCByaWdodCA/DQo+Pg0K
Pj4gUmlnaHQuDQo+Pg0KPj4+DQo+Pj4+ICAgICAgICBWRklPQWRkcmVzc1NwYWNlICpzcGFjZTsN
Cj4+Pj4gICAgICAgIGludCBmZDsgLyogL2Rldi92ZmlvL3ZmaW8sIGVtcG93ZXJlZCBieSB0aGUg
YXR0YWNoZWQgZ3JvdXBzICovDQo+Pj4+ICAgICAgICBNZW1vcnlMaXN0ZW5lciBsaXN0ZW5lcjsN
Cj4+Pj4gQEAgLTIwMCwxMiArMjAyLDYgQEAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0Rpc3BsYXkgew0K
Pj4+PiAgICAgICAgfSBkbWFidWY7DQo+Pj4+ICAgIH0gVkZJT0Rpc3BsYXk7DQo+Pj4+DQo+Pj4+
IC10eXBlZGVmIHN0cnVjdCB7DQo+Pj4+IC0gICAgdW5zaWduZWQgbG9uZyAqYml0bWFwOw0KPj4+
PiAtICAgIGh3YWRkciBzaXplOw0KPj4+PiAtICAgIGh3YWRkciBwYWdlczsNCj4+Pj4gLX0gVkZJ
T0JpdG1hcDsNCj4+Pj4gLQ0KPj4+PiAgICB2b2lkIHZmaW9faG9zdF93aW5fYWRkKFZGSU9MZWdh
Y3lDb250YWluZXIgKmNvbnRhaW5lciwNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICBo
d2FkZHIgbWluX2lvdmEsIGh3YWRkciBtYXhfaW92YSwNCj4+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICB1aW50NjRfdCBpb3ZhX3Bnc2l6ZXMpOw0KPj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLQ0K
Pj4+IGNvbnRhaW5lci1iYXNlLmgNCj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+Pj4gaW5k
ZXggMDAwMDAwMDAwMC4uYWZjODU0M2QyMg0KPj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4+ICsrKyBi
L2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRhaW5lci1iYXNlLmgNCj4+Pj4gQEAgLTAsMCArMSw4
MiBAQA0KPj4+PiArLyoNCj4+Pj4gKyAqIFZGSU8gQkFTRSBDT05UQUlORVINCj4+Pj4gKyAqDQo+
Pj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjMgSW50ZWwgQ29ycG9yYXRpb24uDQo+Pj4+ICsgKiBD
b3B5cmlnaHQgUmVkIEhhdCwgSW5jLiAyMDIzDQo+Pj4+ICsgKg0KPj4+PiArICogQXV0aG9yczog
WWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4+ICsgKiAgICAgICAgICBFcmljIEF1Z2Vy
IDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+Pj4+ICsgKg0KPj4+PiArICogVGhpcyBwcm9ncmFt
IGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkN
Cj4+Pj4gKyAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExp
Y2Vuc2UgYXMgcHVibGlzaGVkIGJ5DQo+Pj4+ICsgKiB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0
aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcg0KPj4+PiArICogKGF0IHlv
dXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4NCj4+Pj4gKw0KPj4+PiArICogVGhpcyBwcm9n
cmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsDQo+
Pj4+ICsgKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGll
ZCB3YXJyYW50eSBvZg0KPj4+PiArICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEg
UEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQ0KPj4+PiArICogR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4NCj4+Pj4gKw0KPj4+PiArICogWW91IHNob3VsZCBo
YXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYWxv
bmcNCj4+Pj4gKyAqIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHNlZSA8aHR0cDovL3d3dy5n
bnUub3JnL2xpY2Vuc2VzLz4uDQo+Pj4+ICsgKi8NCj4+Pj4gKw0KPj4+PiArI2lmbmRlZiBIV19W
RklPX1ZGSU9fQkFTRV9DT05UQUlORVJfSA0KPj4+PiArI2RlZmluZSBIV19WRklPX1ZGSU9fQkFT
RV9DT05UQUlORVJfSA0KPj4+PiArDQo+Pj4+ICsjaW5jbHVkZSAiZXhlYy9tZW1vcnkuaCINCj4+
Pj4gKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQ0KPj4+PiArI2luY2x1ZGUgImV4ZWMvaHdhZGRy
LmgiDQo+Pj4+ICsjZW5kaWYNCj4+Pj4gKw0KPj4+PiArdHlwZWRlZiBzdHJ1Y3QgVkZJT0NvbnRh
aW5lciBWRklPQ29udGFpbmVyOw0KPj4+PiArdHlwZWRlZiBzdHJ1Y3QgVkZJT0RldmljZSBWRklP
RGV2aWNlOw0KPj4+PiArdHlwZWRlZiBzdHJ1Y3QgVkZJT0lPTU1VQmFja2VuZE9wc0NsYXNzIFZG
SU9JT01NVUJhY2tlbmRPcHNDbGFzczsNCj4+Pj4gKw0KPj4+PiArdHlwZWRlZiBzdHJ1Y3Qgew0K
Pj4+PiArICAgIHVuc2lnbmVkIGxvbmcgKmJpdG1hcDsNCj4+Pj4gKyAgICBod2FkZHIgc2l6ZTsN
Cj4+Pj4gKyAgICBod2FkZHIgcGFnZXM7DQo+Pj4+ICt9IFZGSU9CaXRtYXA7DQo+Pj4+ICsNCj4+
Pj4gKy8qDQo+Pj4+ICsgKiBUaGlzIGlzIHRoZSBiYXNlIG9iamVjdCBmb3IgdmZpbyBjb250YWlu
ZXIgYmFja2VuZHMNCj4+Pj4gKyAqLw0KPj4+PiArc3RydWN0IFZGSU9Db250YWluZXIgew0KPj4+
PiArICAgIFZGSU9JT01NVUJhY2tlbmRPcHNDbGFzcyAqb3BzOw0KPj4+DQo+Pj4gVGhpcyBpcyB1
bmV4cGVjdGVkLg0KPj4+DQo+Pj4gSSB0aG91Z2h0IHRoYXQgYW4gYWJzdHJhY3QgUU9NIG1vZGVs
IGZvciBWRklPQ29udGFpbmVyIHdhcyBnb2luZw0KPj4+IHRvIGJlIGludHJvZHVjZWQgd2l0aCBh
IFZGSU9Db250YWluZXJDbGFzcyB3aXRoIHRoZSBvcHMgYmVsb3cNCj4+PiAoVkZJT0lPTU1VQmFj
a2VuZE9wc0NsYXNzKS4NCj4+Pg0KPj4+IFRoZW4sIHdlIHdvdWxkIGNhbGwgOg0KPj4+DQo+Pj4g
ICAgIFZGSU9Db250YWluZXJDbGFzcyAqdmNjID0gVkZJT19DT05UQUlORVJfR0VUX0NMQVNTKGNv
bnRhaW5lcik7DQo+Pj4NCj4+PiB0byBnZXQgdGhlIHNwZWNpZmljIGltcGxlbWVudGF0aW9uIGZv
ciB0aGUgY3VycmVudCBjb250YWluZXIuDQo+Pj4NCj4+PiBJIGRvbid0IHVuZGVyc3RhbmQgdGhl
IFZGSU9JT01NVUJhY2tlbmRPcHNDbGFzcyBwb2ludGVyIGFuZA0KPj4+IFRZUEVfVkZJT19JT01N
VV9CQUNLRU5EX09QUy4gSXQgc2VlbXMgcmVkdW5kYW50Lg0KPj4NCj4+IFRoZSBvcmlnaW5hbCBp
bXBsZW1lbnRhdGlvbiB3YXMgYWJzdHJhY3QgUU9NIG1vZGVsLiBCdXQgaXQgd2Fzbid0IGFjY2Vw
dGVkLA0KPj4gc2VlIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9ZbXVGdjJzNVRQdXc3SyUy
RnVAeWVra28vIGZvciBkZXRhaWxzLg0KPg0KPkkgc2VlIHRoZSBpZGVhIHdhcyBjaGFsbGVuZ2Vk
LCBub3QgcmVqZWN0ZWQuIEkgbmVlZCB0byBkaWcgaW4gZnVydGhlciBhbmQgdGhpcw0KPndpbGwg
dGFrZSB0aW1lLg0KVGhhbmtzIGZvciBoZWxwIGxvb2tpbmcgaW50byBpdC4NCg0KK0RhdmlkLCBI
aSBEYXZpZCwgSSdtIGRpZ2dpbmcgaW50byB5b3VyIGNvbmNlcm4gb2YgdXNpbmcgUU9NIHRvIGFi
c3RyYWN0IGJhc2UNCmNvbnRhaW5lciBhbmQgbGVnYWN5IFZGSU9Db250YWluZXI6DQoiVGhlIFFP
TSBjbGFzcyBvZiB0aGluZ3MgaXMgdmlzaWJsZSB0byB0aGUgdXNlci9jb25maWcgbGF5ZXIgdmlh
IFFNUCAoYW5kIHNvbWV0aW1lcyBjb21tYW5kIGxpbmUpLg0KSXQgZG9lc24ndCBuZWNlc3Nhcmls
eSBjb3JyZXNwb25kIHRvIGd1ZXN0IHZpc2libGUgZGlmZmVyZW5jZXMsIGJ1dCBpdCBvZnRlbiBk
b2VzLiINCg0KQUlVSSwgd2hpbGUgaXQncyB0cnVlIHdoZW4gdGhlIFFPTSB0eXBlIGluY2x1ZGVz
IFRZUEVfVVNFUl9DUkVBVEFCTEUgaW50ZXJmYWNlLA0Kb3RoZXJ3aXNlLCB1c2VyIGNhbid0IGNy
ZWF0ZSBhbiBvYmplY3Qgb2YgdGhpcyB0eXBlLiBPbmx5IGRpZmZlcmVuY2UgaXMgdXNlciB3aWxs
IHNlZQ0KIm9iamVjdCB0eXBlICclcycgaXNuJ3Qgc3VwcG9ydGVkIGJ5IG9iamVjdC1hZGQiIGlu
c3RlYWQgb2YgImludmFsaWQgb2JqZWN0IHR5cGU6ICVzIi4NCg0KSXMgeW91ciBleHBlY3RhdGlv
biB0byBub3QgcGVybWl0IHVzZXIgdG8gY3JlYXRlIHRoaXMgb2JqZWN0IG9yIG9ubHkgd2FudCB1
c2VyDQp0byBzZWUgImludmFsaWQgb2JqZWN0IHR5cGU6ICVzIi4NCklmIHlvdSBtZWFuIHRoZSBm
aXJzdCwgdGhlbiBJIHRoaW5rIFFPTSBjb3VsZCBiZSBzdWl0YWJsZSBpZiB3ZSBkb24ndCBpbmNs
dWRlDQpUWVBFX1VTRVJfQ1JFQVRBQkxFIGludGVyZmFjZT8NCg0KVGhhbmtzDQpaaGVuemhvbmcN
Cg==

