Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4920A7A0001
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 11:29:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgie0-0006b1-24; Thu, 14 Sep 2023 05:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qgidu-0006Sz-Ml
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 05:28:11 -0400
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qgidr-0005lg-D7
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 05:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694683687; x=1726219687;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9r6nRmusuJfhLbLMJv4ElSAyaibgHOo9GpIFCCw0HXQ=;
 b=XljMtNAhiFG4hPsA7Y3uHYlcXrjem08ab+aQqWu7bxLgJyeL40gYt5Ya
 Qpt/pMPF63EZhYGExRDvDkHqx0PwkJxrNGj6EvBcTkELa0hpy9s6OVzlR
 2tp2KVallmkFLwHjCzMPVItkUFXSRKUTqdSWXgA0ZLzYoeoIKjZgGkDSm
 YbnegzHMelCLOWKkkelXnq6ik31R+5d9K5VKH3W6vMAvNy38vfaNU9HeV
 Q8joWHSB9sfO7aSQIgSbUkL9GdAvJWcxclOT3cAzfCvjMaV+U5+0GfsTf
 WbCI1g1KbFBH+w4gWdFZYryRa8voaNk9hAOH9QOlipcJduNkTYEinbCYI Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="369174841"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="369174841"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2023 02:28:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="918188490"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="918188490"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Sep 2023 02:28:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 02:28:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 02:28:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 02:28:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 02:28:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COqw2cvBIcbOg0vQWtQKp1rEPGr3OF5NNVs5uVV18zrDsjB9hMSNaoKcndW9sw9URM/Df5HIdZp9i9bDpEfV9DASVt30vkCcRwx/R7vFvXMR/eAqCm60zHgNeuDdgLydhPvSVLZ6e3jNV3v5WOw0Jbu2C+jfHq47/zjq97kPTvZk6MDeKZu+ObGYcyPX+zj3eF5m9cr/msBtvVJwAen1BTw6rWshWMXy6Dbna4CoBbrahmt+wkbgS++MY+E7xpKyVC+N2Jl434bRum09msFHtP1VcH57IrynjWhHHWtfgIfipILAOxlSG4RlKlKRihQqlWvBUFsFhl1Bj53QcO0AoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9r6nRmusuJfhLbLMJv4ElSAyaibgHOo9GpIFCCw0HXQ=;
 b=IG/D8hhRqXo8P3crpHY8Yv3Zg6ZUR5u1leExml3J0p4D05O5d1aob/YoocmlGlrgZBl5xHWWbUjemnVi5wnYp9qujkmKFGS0sGQmtNhE1m3wozfQo7U/4zYzepHJszVeBRTJuc/5U3CHr1bwO17oDdjqIzy7p3a0b5cMyN9/escyiWZxt6KeWk/6DiZnompSqk82BAFLfo9FhANJPoeKygK7TN3T8ipj0mPfp1awEX/pEIZONsu8NaKNN11yRPauK7+us8ueRv0oOaW7VDc4dY82pbxuTykahoGEcQfOmOWCzEnhiQSThpva2FgvDvSE/5En9e+nOPtpCXBBDn3iqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB7570.namprd11.prod.outlook.com (2603:10b6:510:27a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 09:27:59 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::dcc5:b253:97d0:ff70]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::dcc5:b253:97d0:ff70%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 09:27:59 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 00/22] vfio: Adopt iommufd
Thread-Topic: [PATCH v1 00/22] vfio: Adopt iommufd
Thread-Index: AQHZ2zAWbRwNlGSkwk6jO8NZIq9umrAaHnmAgAAF+/A=
Date: Thu, 14 Sep 2023 09:27:58 +0000
Message-ID: <SJ0PR11MB6744971405E2CD2B2B7AF66B92F7A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <8cd9a176-17b5-b6de-dc54-ba10124e9fe3@redhat.com>
In-Reply-To: <8cd9a176-17b5-b6de-dc54-ba10124e9fe3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB7570:EE_
x-ms-office365-filtering-correlation-id: cdeb3a2e-6bbd-4b01-ac9d-08dbb504e294
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cbwS4PBsOYLHxtD/E0bVLMictZ7nplm6pSIMVPEe+koDKv8ej75i0Aao2a367qjeaVhIEg3HzV0FSgKzD2uy2HTiqlPZ/0RS2xjekA353RA4WT+ofruMCKXq7l235SD733sUH/frlBx5pYK9a4HjXFKP0XeMRnEFBX1McAhLPz4yYalopZCKgiBxDnx+0H0/xym+hL8s8EbrxJidZd+EJLVCCV5lxHJZY+58dMKCB60R0W6zX2u0LwpXfgYqbXXw9/7uRxVdoFudYFRO3iHfrvQFSz3wv3o23mmKd0sLDtnX554hqQWonXDLmXXHR/eiw1K/MqXluZAushM2R4hkGdbhk19qDBAXEL6VaWnXGe2S3QYuLRKtacF43q+LyTCOOIRpigsHewXe3Ltohhgv8fVTlc7GyPIem5HPzqU7LcqOPS8lGWOvv8TuDsRZmlwoml0BgmIpsVpRsIIYfqbSNCO5fE7V3RipNYRrI8dAeughiTI1H9oRGZ48JXUnWGs2xvYGMtmVyP0jDkgocj8Iw4f8VJNi/rTx1IjaWuG+wrK3Ibx+xTtrrRjPE0+/0awiepdDKw5BtHPexvZ+V9yv5xnOtJvg2G0ZFJmFC0t9kRIQ8Yw3jw4e+xnr6/gbG7aytdBjCH5U5XjNUUaMzEG7Fw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199024)(186009)(1800799009)(6506007)(76116006)(66946007)(66556008)(7696005)(5660300002)(66476007)(316002)(64756008)(54906003)(110136005)(9686003)(66446008)(52536014)(55016003)(122000001)(4326008)(107886003)(8676002)(8936002)(478600001)(83380400001)(26005)(41300700001)(966005)(71200400001)(2906002)(86362001)(38070700005)(38100700002)(82960400001)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmphVjczRWJZRnFsVk8rRGFoNzZsWUVBamtrd0I2c0xIeGJBV0QzTzBCVEF4?=
 =?utf-8?B?Qmw1TEhhV3k4UWR1ZWVTT3NOSzdUYXpxL3lNT0I2R2hYM1lUUGxMTzIxSWVS?=
 =?utf-8?B?Y0ZQdExYdktnNUUzdHhENkxpRDZsZnZHZDdwc05UVnJPVXlYQTZ6OFF2eDBB?=
 =?utf-8?B?MGI5UzlGRzF6R3RxSFdrM29oaFlpU3A5UWJzV2pnWXFpc2NmYXBhUzlGYnJB?=
 =?utf-8?B?ZXVTZDQ0YnBicEVVOWpzRkpnRlpDNDBkdWFJRjJBdW9zbmVxcnllL2N2elEx?=
 =?utf-8?B?cFNSVFlaUFBGNnVPdFFic1JvYzNWSlNGSkR1a0I4ZjdqZXlPb2UrUUlsLzds?=
 =?utf-8?B?dXhhbUtLbjIwQ1lYbXN4Y0U1eVhsL3JaV3F6MEJJOHZkajZsaVNpOEExOXZF?=
 =?utf-8?B?dGQ0QTljSlhHUTFzeU50WlF3TXZLSkFZaHRqRkxVYW5nakxlaUp6aUR5T0VP?=
 =?utf-8?B?WlpHY0pPZklJZDRvV3BRc1RpeDJIOFpOOHFFcXYzaU9GQ0YxV2pONFdrL3F0?=
 =?utf-8?B?Sk1iMy82K1c4UUk0eVZrVUc3QWRNcWZMdnY2bWxpcWxKeGtsY29zZ3FLc3oz?=
 =?utf-8?B?NFJiK3FSU2dDV0M5SWhSSmR0UHN6L29GVWtNeThEbUxjbzVLY3l4b3k4bkNR?=
 =?utf-8?B?ZkpheDFnSmtDZ1NMMmxOLythY3Z2d0lZMFFnb0dxTGdRMThLK0VRUHBDL1RM?=
 =?utf-8?B?bXN6YUhHMTM5T245ZWx0Z2hpWGx0cDcwTmRWZXF2c3B1UEMyV1U0Q3B5aEdi?=
 =?utf-8?B?ZlFZSER5VFM5VWovSXNMZHp3LzN3U2xkUkNZOHBqazVQem9NK2xUQUFXWUpJ?=
 =?utf-8?B?UGhYZXgvZ2NSMW01Rm4rZXZuMTMvbkdBMCtLMWdRYWNJMmtFNXNXSVhGK1Ri?=
 =?utf-8?B?aXA5UjFHVit4cUpkWE9xWnhZQnRmNTcxOGNpeUtQZ3JZZ1FsV0RYejZvWmJs?=
 =?utf-8?B?REV6N0ZXQkJSbkszWnFQZ1FyWitBZklNaFVncGR5ZWIvdjI5QWZDOG9Ldmw0?=
 =?utf-8?B?ZDBRekJqOUhEOW41U0JzczN1bzY3TTRVbk1hVjE3Q3phZk0wb3FNaUk3aEhW?=
 =?utf-8?B?TitpdUx3Q1NackRRZWE3Z2duNEVjRUpDanJHT1Roek5xK2h1QWFLM3FPVXRT?=
 =?utf-8?B?bmtqTXdvcW9mRkd6OE5NdmV6VUw2YzlJa25ocUppUVdTSHR3MW5JZElDY0t2?=
 =?utf-8?B?NEJwWklHdlN1TUc4VXJDZ2ttYWVqRkRnL1ozWlpDZ0Fpd2ZFeVY2VDZjcDJa?=
 =?utf-8?B?VjlqYnhkbXFMZ2l3YlVJTThPQmFwV29KQUdDYUQySi9lcmsySjRJSnBqZ0J3?=
 =?utf-8?B?bHBySWE3cHNVTVc0MUtsVFI0TEdsOGoxeFdNQmtIU0ZmS1JXaVVWbnF5R2lF?=
 =?utf-8?B?ZER2VlZlNGh6Qi9UdUxudTRxdk40RDdsYXlHWDU4TVM1SFBpeXd3NzlnbTRN?=
 =?utf-8?B?ak9IRDgzN3RzYmJIQ1NWbVRaeWFTU01lRHlDUTl5WUFrdEMvdDVHcEVKWnFj?=
 =?utf-8?B?UGREOW5LWWZ4U0phL2ZiSzlUQnU2WjAwN29lR0VlaTlNNlI1SXdiRjRYeW9E?=
 =?utf-8?B?Qko0Y1pIM3BuYXBWTGpxV2ljc2Y0VE9iMGY1TEk3UzB4TE9iNzNVaGVmRVRP?=
 =?utf-8?B?Z1ZXdGtNSHZLbjVtckNnN1lSa1dkek5jck5rTDd4Vk5JdWtNTXNTZTd5MFd5?=
 =?utf-8?B?dkRrVDlxL3c3NkpyYys4V1JmdG0vZnpDN2FEbm0rR2JVcERCT3VkQk50Skt6?=
 =?utf-8?B?VXZLN3BlUmlmU1ZTWWIxbitueU5lcWZNcGoyZmVHZExwYmg2RExXSDJHelho?=
 =?utf-8?B?VGdNcWFXZWVWQjZJZmQrRElPaUNaY2RONW1XejF1NkQ5S0QvYWFFVEZ4dlBl?=
 =?utf-8?B?aUgxbUs5NEJHaWpYOFdZYmdYWjFrcC9CUEkvWTQ0MkVnU09yRWtzUThuVGF6?=
 =?utf-8?B?a3ZxMGdnU2FxQ2tpQmdUTzQ4U0Rla1ZvdlEyL1FlWThBYWZBWURWdUVURFpR?=
 =?utf-8?B?MXdMWGtwVUhVRjF5NW9IREF5ZjhHZjNIOGRQSmsybFVXMWNJN0xtYVlCOFpN?=
 =?utf-8?B?ZlhyQUszZHI1a0I0NVlndmQvNTdETlpTREZYaXZnWHNoaEM0OEFKOStFWXpy?=
 =?utf-8?Q?lAZc4XpViYp+TYjr8vHivC8u4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdeb3a2e-6bbd-4b01-ac9d-08dbb504e294
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 09:27:58.8596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GiOQXraHk4vo6DSm+WS3blk/byUQBW+hmRX+9ALLxTWEKnR6FFISajXkHJM0CpNV2A72kN5qrT1ArKvecx2F7gOvhzuxcBy9gVbxxy77+Gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7570
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMTQs
IDIwMjMgNTowNCBQTQ0KPlRvOiBEdWFuLCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVs
LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPkNjOiBhbGV4LndpbGxpYW1zb25AcmVkaGF0
LmNvbTsgY2xnQHJlZGhhdC5jb207IGpnZ0BudmlkaWEuY29tOw0KPm5pY29saW5jQG52aWRpYS5j
b207IE1hcnRpbnMsIEpvYW8gPGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20+Ow0KPnBldGVyeEBy
ZWRoYXQuY29tOyBqYXNvd2FuZ0ByZWRoYXQuY29tOyBUaWFuLCBLZXZpbiA8a2V2aW4udGlhbkBp
bnRlbC5jb20+Ow0KPkxpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPjsgU3VuLCBZaSBZIDx5
aS55LnN1bkBpbnRlbC5jb20+OyBQZW5nLCBDaGFvIFANCj48Y2hhby5wLnBlbmdAaW50ZWwuY29t
Pg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDAvMjJdIHZmaW86IEFkb3B0IGlvbW11ZmQNCj4N
Cj5IaSBaaGVuemhvbmcNCj4NCj5PbiA4LzMwLzIzIDEyOjM3LCBaaGVuemhvbmcgRHVhbiB3cm90
ZToNCj4+IEhpIEFsbCwNCj4+DQo+PiBBcyB0aGUga2VybmVsIHNpZGUgaW9tbXVmZCBjZGV2IGFu
ZCBob3QgcmVzZXQgZmVhdHVyZSBoYXZlIGJlZW4gcXVldWVkLA0KPj4gYWxzbyBod3B0IGFsbG9j
IGhhcyBiZWVuIGFkZGVkIGluIEphc29uJ3MgZm9yX25leHQgYnJhbmNoIFsxXSwgSSdkIGxpa2UN
Cj4+IHRvIHVwZGF0ZSBhIG5ldyB2ZXJzaW9uIG1hdGNoaW5nIGtlcm5lbCBzaWRlIHVwZGF0ZSBh
bmQgd2l0aCByZmMgZmxhZw0KPj4gcmVtb3ZlZC4gUWVtdSBjb2RlIGNhbiBiZSBmb3VuZCBhdCBb
Ml0sIGxvb2sgZm9yd2FyZCBtb3JlIGNvbW1lbnRzIQ0KPj4NCj4+DQo+PiBXZSBoYXZlIGRvbmUg
d2lkZSB0ZXN0IHdpdGggZGlmZmVyZW50IGNvbWJpbmF0aW9ucywgZS5nOg0KPj4NCj4+IC0gUENJ
IGRldmljZSB3ZXJlIHRlc3RlZA0KPj4gLSBGRCBwYXNzaW5nIGFuZCBob3QgcmVzZXQgd2l0aCBz
b21lIHRyaWNrLg0KPj4gLSBkZXZpY2UgaG90cGx1ZyB0ZXN0IHdpdGggbGVnYWN5IGFuZCBpb21t
dWZkIGJhY2tlbmRzDQo+PiAtIHdpdGggb3Igd2l0aG91dCB2SU9NTVUgZm9yIGxlZ2FjeSBhbmQg
aW9tbXVmZCBiYWNrZW5kcw0KPj4gLSBkaXZpY2VzIGxpbmtlZCB0byBkaWZmZXJlbnQgaW9tbXVm
ZHMNCj4+IC0gVkZJTyBtaWdyYXRpb24gd2l0aCBhIEU4MDAgbmV0IGNhcmQobm8gZGlydHkgc3lu
YyBzdXBwb3J0KSBwYXNzdGhyb3VnaA0KPj4gLSBwbGF0Zm9ybSwgY2N3IGFuZCBhcCB3ZXJlIG9u
bHkgY29tcGlsZS10ZXN0ZWQgZHVlIHRvIGVudmlyb25tZW50IGxpbWl0DQo+Pg0KPj4NCj4+IEdp
dmVuIHNvbWUgaW9tbXVmZCBrZXJuZWwgbGltaXRhdGlvbnMsIHRoZSBpb21tdWZkIGJhY2tlbmQg
aXMNCj4+IG5vdCB5ZXQgZnVsbHkgb24gcGFyIHdpdGggdGhlIGxlZ2FjeSBiYWNrZW5kIHcuci50
LiBmZWF0dXJlcyBsaWtlOg0KPj4gLSBwMnAgbWFwcGluZ3MgKHlvdSB3aWxsIHNlZSByZWxhdGVk
IGVycm9yIHRyYWNlcykNCj4+IC0gZGlydHkgcGFnZSBzeW5jDQo+PiAtIGFuZCBldGMuDQo+Pg0K
Pj4NCj4+IENoYW5nZWxvZzoNCj4+IHYxOg0KPj4gLSBBbGxvYyBod3B0IGluc3RlYWQgb2YgdXNp
bmcgYXV0byBod3B0DQo+PiAtIGVsYWJvcmF0ZSBpb21tdWZkIGNvZGUgcGVyIE5pY29saW4NCj4+
IC0gY29uc29saWRhdGUgdHdvIHBhdGNoZXMgYW5kIGRyb3AgYXMuYw0KPj4gLSB0eXBvIGVycm9y
IGZpeCBhbmQgZnVuY3Rpb24gcmVuYW1lDQo+Pg0KPj4gSSBkaWRuJ3QgbGlzdCBjaGFuZ2UgbG9n
IG9mIHJmYyBzdGFnZSwgc2VlIFszXSBpZiBhbnlvbmUgaXMgaW50ZXJlc3RlZC4NCj4+DQo+Pg0K
Pj4gWzFdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2pn
Zy9pb21tdWZkLmdpdA0KPj4gWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS95aWxpdTE3NjUvcWVtdS9j
b21taXRzL3poZW56aG9uZy9pb21tdWZkX2NkZXZfdjENCj4+IFszXSBodHRwczovL2xpc3RzLm5v
bmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAyMy0wNy9tc2cwMjUyOS5odG1sDQo+
DQo+RG8geW91IGhhdmUgYSBicmFuY2ggdG8gc2hhcmU/DQo+DQo+SXQgZG9lcyBub3QgYXBwbHkg
dG8gdXBzdHJlYW0NCg0KU3VyZSwgaHR0cHM6Ly9naXRodWIuY29tL3lpbGl1MTc2NS9xZW11L3Ry
ZWUvemhlbnpob25nL2lvbW11ZmRfY2Rldl92MV9yZWJhc2VkDQpJIHRoaW5rIHRoaXMgb25lIGlz
IGFscmVhZHkgYmFzZWQgb24gdG9kYXkncyB1cHN0cmVhbS4NCg0KVGhhbmtzDQpaaGVuemhvbmcN
Cg==

