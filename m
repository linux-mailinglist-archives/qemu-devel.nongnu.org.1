Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9187A9480
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 15:06:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJMF-00014d-BI; Thu, 21 Sep 2023 09:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjJIj-00021i-5V; Thu, 21 Sep 2023 09:01:04 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjJIZ-00031D-SP; Thu, 21 Sep 2023 09:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695301251; x=1726837251;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MkexK+V2O8q2152U3m6DpivWBFVVgs9h1khiCZ3/ywQ=;
 b=ByHyr1ectdUtm6HRdSiYFpr9SUvmGBaqsJAJup1ldC5K8lrE0Bqj/Djy
 Wc2CAUX/KqYi01FMvWTCYLM6V1VoB2aFGWJ3J9XZkyfzp4CKG+vQ3G7J7
 yX0iHGDNiAO06AyW8OoulxsOZS6v4ETIDsZ69wPltnF9fVOT3azLdar06
 6EGiRoQbHNDNzrSlNHtgitP2C9c8WdgnZiTKcLXnrfnjw3tDZcMybsJIr
 kHPr9pUnLbtOUulazr4bqxVm0Z5ph/WMRM73m5nUTyqP89hJP5pf/LDQP
 7PVR5XQ7gXfRpXL94aztuOnNUVmyudJbTX4eQ/1z2QKxNBMG7KLgX3V/p g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="446982196"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; d="scan'208";a="446982196"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 06:00:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="920715587"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; d="scan'208";a="920715587"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Sep 2023 06:00:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 06:00:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 06:00:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 06:00:46 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 06:00:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaBigiBZMCAnlPwjhF10ig4C+Sf1C3qtL07pUETLYPyotmR06kr07DPCkZs7vhHFVnTDCA+6m+qHW4ox75MlqNP9KA+Bocahg6FmQJ/hrPMXkUSsRvL0M2Apkq28XOcDOQtZL02jRuF6mmk6ajaXAYYlmDyHpS4lQEqbgy9Hd2M/T2gXBNUm4nhz5xpBA0w0svzAuZZdq9Nl0jK86UqF/JCycyffMiWDWCg39EkIyf2zE2biZfA6hX7Odk0W2fWkP2QxKWF0z0L6KB7na7tBnAYaKhtEUh/rjNaXy7FMyzWuewys9UgAs3/T0WZIr7K/xdCiRcI34z+AoVTPV1xJaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkexK+V2O8q2152U3m6DpivWBFVVgs9h1khiCZ3/ywQ=;
 b=Oc3PZj6Zs8H0IxEYaxI0IRe615pJU4dWhQWK56x4wqxt5M5Q5Kg6vrTVYMfjRg2dnDjIr6lsMRcaQ122jhSpkaq7OTP6OxH7ayGpilNEr5zz+/SzXZkkbEY6e1oUM+tl6j4LGWPM8OdUETmRDVcKyX+rTqsrrTfeOX2iomroAeT0zvKJ9SwTwom3lR+pIDtvatWhCijJdPuPOgVcm67jIRgC83Dm3Cq1ObYDKhkhtXJDmDSVSI0RqNXA+vPXX1NlaJOFX+SvngwYnC5AuTyfm6YJ3ZnplxFj0pknMOgzGV6hqyXIqHaRbfm9MK1d2vj4W+Zea5vwLmkh7TKMfIWy9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA0PR11MB7260.namprd11.prod.outlook.com (2603:10b6:208:43b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Thu, 21 Sep
 2023 13:00:43 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 13:00:43 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Eric Farman
 <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth
 <thuth@redhat.com>, "open list:vfio-ccw" <qemu-s390x@nongnu.org>
Subject: RE: [PATCH v1 12/22] vfio/ccw: Use vfio_[attach/detach]_device
Thread-Topic: [PATCH v1 12/22] vfio/ccw: Use vfio_[attach/detach]_device
Thread-Index: AQHZ2zBAIDt9b/ySLUmrVo9+B0gn9bAlVXwAgAAKJYA=
Date: Thu, 21 Sep 2023 13:00:42 +0000
Message-ID: <SJ0PR11MB67444F764D47D887D7FA8D6A92F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-13-zhenzhong.duan@intel.com>
 <ff418562-245e-2c7a-01a8-060ee970f195@redhat.com>
In-Reply-To: <ff418562-245e-2c7a-01a8-060ee970f195@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA0PR11MB7260:EE_
x-ms-office365-filtering-correlation-id: 718a147d-289a-4d4a-6f0d-08dbbaa2c379
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gnpp0muBLFYPByIySoONk6trzdRS3T3SFEWShJBrpTYjJaa80f8tBdl9BAK2Bxm0Oqk7WtLabRTzBmrLZwUEI+YCSOTk17/auzzIyfboNafFq9AJzBv+xyPcU0V1zDNlOcoMSltBNtlv+kqUtwycOxD46uQnZBKZdIo53HtMPYoixc0k46UEnvs1yA3mIhZafkeY8ogSNzXvO4rWCarimfJezTh4V8r2RjcMIGivPHl6eHfpjGjNe/LtQloucND2hvVlIrHQSahulWhGUg+UuXdxZDCTRgxCnC6RKqazzytT42PA9pSMK3QFsvTQHh/zCTkftUxuYa4t+1hIw376fSHfQZtiMfhd0/2nXZRksO50lW6XrgDm6sAqTRQm9pDqW79R0QWTkJXtgFKCT7VKTrbM/1ki1x5Y1VfenwcLtAdLD4OLdImytwk6GYTSoWb6rqHjp3Rrc4dWtJRQqDzW+slNihvt1qFtWRFqjCmuCc/9mShMlB1+JfkvSBCBLcQ+vV9CJFJvVOd3DW3TDNqXPnChAFH4s48ozH8/LLNo5A1Luh9mWvHWoHu+XOQvRTVGeDJdYb6+JrtXj0wvg7FFFb53gCBpWU5AyvQZFuPurhFnRqKGpAscmxeY68GsGTYM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199024)(186009)(1800799009)(38100700002)(82960400001)(122000001)(38070700005)(55016003)(86362001)(33656002)(2906002)(478600001)(66446008)(6506007)(7696005)(54906003)(66556008)(66476007)(76116006)(8936002)(52536014)(66946007)(4326008)(8676002)(64756008)(9686003)(83380400001)(5660300002)(316002)(7416002)(26005)(110136005)(41300700001)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzNIN0d3OTV1SmZXd3M1dFhGVXNXQ3ZIc3RqbUZmbEg0R1hobXhNUllRcXlD?=
 =?utf-8?B?S3VkcEphMlZwZCs5YTI4ckZ5U1FyaktZUVB3UTN3czJzZ3czYkJnem8ySFlE?=
 =?utf-8?B?M0V0RjhPNFFUUUZvVTJKbFdWOGkyampUNmRPRjg3RGJWWldHRXdzMFFaMk8z?=
 =?utf-8?B?UWVpTUNzUWs0dyt1OENLN0RlUVFMZldRdmRodkZHZ3IzQW5TM0xXQk8zTWhi?=
 =?utf-8?B?cjNaT1NZajVxWnZOTFU1UkxxNTl4UXVQdm1XeVpQeHVPUWZ3VWkwK3VPMldq?=
 =?utf-8?B?aUNlRGZRVEpKZUJXMmdXeUJPZlNTWFd0L2xjS296Q0tvTElNcVk3eDB0U0xL?=
 =?utf-8?B?K2JSM0JkbWo5TFRzeUlqSHBBQUNab0RqaitrOGJOU0xKKzFSd1JROW1lK25N?=
 =?utf-8?B?aWxoSkdJY3AvK215V0Z6bk1qT1psdktjRmczVVZieURVaDZVWGVXZFQzWFYw?=
 =?utf-8?B?Q1lVajJNRWVQMGVIL1Z4aVdiZjZkRFNLOUJCeDZ2OHVsVm5hMURDVjdJOEhn?=
 =?utf-8?B?VlRiVWNzc3pTaEZrS2xmQm9wZ3BudFdsd0Z3b1owd3pMMDV2b0taSklmZFdL?=
 =?utf-8?B?dDZCa1dsUEVtQ2tZblI5MXJ6QTZGbWtjdUEwV0JpV2xiS08wQW5hVkRFaVhS?=
 =?utf-8?B?L1h5RW5UMXBaUldyUFdkWHRhOFVPUXY0SjN5czkyZ3BFa1pzT0VnOWFWSU5x?=
 =?utf-8?B?SW5peTVXVDBEN21tWE83RmtZRzdFRUZJNmNGRnJxMWZHSDFyOHpiUmU0WGhB?=
 =?utf-8?B?bzRZaG9QejRnd2JDUm9RQkJ6ejJzSUIxRUJQTHZZeDF1aDVpN2tFbmp6VGNm?=
 =?utf-8?B?eHJIZU5hNU1nRXhZK2NmVGk4dzRKdFNob1pFa2xHZ1V1U2lsWW1ldXJuVFFp?=
 =?utf-8?B?TFJYaDZpSWsxOUxwNlVXM1kzZklDT1B0YVRzc0xMNjJmankwaDdyM2FPa2Ja?=
 =?utf-8?B?OHJSOStNTndyMDZ2b3JCbTMzRGVTemlZRnZqdkpod0M5MlJrY0pERjYrS2tR?=
 =?utf-8?B?S0RQUFdTcU1jOFpFSVIyOGR3QTAzcFpFaHFKR0VIcVBibEFVWFBIY3dQSW0y?=
 =?utf-8?B?SjE0K2lhVTJEcEV4cDFRNmp3YnVFMytDRFdncWUvTXhOcWVGVmtnNXp5OTZQ?=
 =?utf-8?B?T0ZRNWswUWRtQmJXMWs0aldqcHAwbDhIS2tSQzJrSE9aVHU3bCszQ0ZMMFBQ?=
 =?utf-8?B?TmYyT3BZQlVzVzIwcW1INHpxQ2FHYmEwdHZWZ2ltMmUxYUJUd01FYnVTb092?=
 =?utf-8?B?Vnk5VFdWZTRXSEhVdkNKVllDZloyOUYyd2xhTitLWk82eW8rSEswcFZsOFVZ?=
 =?utf-8?B?ZnhFWGxlcS9IV2NSaVJBUkJNcHNXc1drM0QvcVh6Y3VqYWMveCtrNVRPVU0z?=
 =?utf-8?B?N3VYbUZQZHVnNHFNZXF5cUNUV01JSjBXOWlpL3U5ZXJqV3BiRm9zSndwNjUx?=
 =?utf-8?B?aFZyYnQrblpXWXVUc2J6NUhzc2NtUXphWkEwRTB4TDFuZFl4S1lONnlpOEFN?=
 =?utf-8?B?Y1c5VEdKZEpWS1B1VTc5SkZqUkVPVUR1MXNsZ0ljM21lSXR4a2RDUGc0WlI5?=
 =?utf-8?B?Q0dicndKZ2JsdHhqc3IxRk5zc05lNGRGOEl4eGhpYmVJL0tNdDBCWG1aTC9V?=
 =?utf-8?B?VStYKzZRYUdqeHQzSlpoYXVUcy82NENHY1VhbWpCZjZ3VE9xdU5DR1N5SGt0?=
 =?utf-8?B?NEtpR2Ewd05MOEpoaUFHOUgxTUhrbXpLUUtDbjBFQU5qdkcvbUFHditZTHRu?=
 =?utf-8?B?UnFuL0NzWTV1ME1RTDBIYytRUWNhc3lMOWVTUCtHYzRVZ2YzK2NadTZBejFV?=
 =?utf-8?B?ZTFyaGFRUGdLMnB2aHIrRVZHNEU0aWltRUlzaDBDdU1jemFaRWxLZUsvSFph?=
 =?utf-8?B?bGFVVGNTQ1hxL3NuNlFzbVhlb1c0eTVOQlhod2JnQjRsQjhoQkc5ZXl6UGhL?=
 =?utf-8?B?YXdYbFUvMjZFQUdPR2FhdXNaT3RVdk5wSmZUL3BYSzRodmo0L1JkS0IyaWxV?=
 =?utf-8?B?bVVQNWdRaEFhaXd5VzhqcWk2emQ0T3VyVkVWK0lqNTBKRW5Kanh4TmQ1c2I3?=
 =?utf-8?B?VjFJa3NlNmNBeStsU1FpWGx0T0ZVNUNvWnlsVUlSMmh2Z3lIa2lZOTlXNG5F?=
 =?utf-8?B?Si9ZelFxZSt0bkJkd2VsZ1hnUlFFa0YrUkI0Q2J1dUFWbGFmZG9pd3ZPZ05N?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718a147d-289a-4d4a-6f0d-08dbbaa2c379
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 13:00:43.0013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6DEmJNIOOVL0AMmO4lIT39cjyC9JWt7DFRSSvbeO4w5e+y0rgd+Ygbp0WiStJcqmY3ukF88Dviu25riylHI1DMH2klXneNSK0epBPSff8+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7260
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDIxLCAyMDIzIDg6
MjAgUE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDEyLzIyXSB2ZmlvL2NjdzogVXNlIHZmaW9f
W2F0dGFjaC9kZXRhY2hdX2RldmljZQ0KPg0KPk9uIDgvMzAvMjMgMTI6MzcsIFpoZW56aG9uZyBE
dWFuIHdyb3RlOg0KPj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0K
Pj4NCj4+IExldCB0aGUgdmZpby1jY3cgZGV2aWNlIHVzZSB2ZmlvX2F0dGFjaF9kZXZpY2UoKSBh
bmQNCj4+IHZmaW9fZGV0YWNoX2RldmljZSgpLCBoZW5jZSBoaWRpbmcgdGhlIGRldGFpbHMgb2Yg
dGhlIHVzZWQNCj4+IElPTU1VIGJhY2tlbmQuDQo+Pg0KPj4gQWxzbyBub3cgYWxsIHRoZSBkZXZp
Y2VzIGhhdmUgYmVlbiBtaWdyYXRlZCB0byB1c2UgdGhlIG5ldw0KPj4gdmZpb19hdHRhY2hfZGV2
aWNlL3ZmaW9fZGV0YWNoX2RldmljZSBBUEksIGxldCdzIHR1cm4gdGhlDQo+PiBsZWdhY3kgZnVu
Y3Rpb25zIGludG8gc3RhdGljIGZ1bmN0aW9ucywgbG9jYWwgdG8gY29udGFpbmVyLmMuDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4g
U2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPg0KPlpoZW56
aG9uZywNCj4NCj5Db3VsZCB5b3UgcGxlYXNlIHJlc2VuZCAxLTEyIGluZGVwZW5kYW50bHkgYXMg
YSBwcmVyZXEgc2VyaWVzIGZvciBpb21tdWZkDQo+c3VwcG9ydCA/IEkgdGhpbmsgdGhlcmUgd291
bGRuJ3QgYmUgbXVjaCB0byBzYXkgYW5kIHRoZXkgY291bGQgYmUgbWVyZ2VkDQo+cHJldHR5IHF1
aWNrbHkuDQoNCkdvdCBpdCwgd2lsbCBkby4NCk5vdGUgSSB3YW50IHRvIHJlcGxhY2UgIltQQVRD
SCB2MSAwNi8yMl0gdmZpby9jb21tb246IEFkZCBhIHZmaW8gZGV2aWNlIGl0ZXJhdG9yIg0Kd2l0
aCB2ZmlvX2RldmljZV9saXN0IHdoaWNoIHdpbGwgYmUgdXNlZCBieSBib3RoIEJFcywgdGhhdCBt
YXkgbmVlZCBzb21lIHRpbWUuDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

