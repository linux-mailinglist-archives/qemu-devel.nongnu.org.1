Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB187B014B
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 12:08:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlRSG-0004gV-Il; Wed, 27 Sep 2023 06:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlRS9-0004g1-MX
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:07:33 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlRS5-0004l2-7e
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695809249; x=1727345249;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nnpUmBJidsga6i2za5ZoUYDntJVXaqeZbBoBIjNLD7Y=;
 b=FOXAtL8NRVFNYvL8Oygftmms6XBSRd1bXTXJb4GvdOTWB571pPFtrn7u
 YW4KGl3Pe7TobgBY+YlI7twVQzlrVamdc1zMH9HKBREiJ1+HlM65inKXc
 CS6Vt1ybaFCevkLE9rISu/s2b/gvIe993yEa9A16fhYhjKPVkPliB2GIV
 cGb4sIvDkpGzarF0Dws+JPh9OjzWjaWWa9nbCSauyW8t1TPUiLe0xreJe
 GqqXCf9xB8F+hG62wQgMZJ04ZfkeganBGZlic72efK67oOEzO0DzcppZB
 hPEjAy+wh7KBFkI6ncKSK2LX7qLBYP/VsKaDYIKa2Zp0X072/72bv94YG w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="384571411"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; d="scan'208";a="384571411"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2023 03:07:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="1080085731"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; d="scan'208";a="1080085731"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Sep 2023 03:07:24 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 03:07:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 03:07:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 03:07:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRqgPdrQIJTIzMPbh3hmWnp/wpt/JuZlrV1vJxxGP4b5TyQbKA4I+z4famZduOmAQdGZ93hr83KpmFVBbZT1SPTx87Nhfr9tho19GrzQxYx+SQ7QzUcpDPnEP2IYUlZi3eRR88Dy+JyN57vjUUQa43KvMsdjQgL3DOkBMhiHLbLTCs7oSHuK/mdb6nCqAa19PD6TFJxDpSikuXVlJruQl/nghb8heANAvJM71HY5rjBQ/4rbgUC8WMBZCiV7vOBP3uEEWvegwSefRPqfza2yTSlQdeG34Q+GPd24lJYBW9JjZWGI4BO21uhcqUrFTSqTpetUrelXNYQTQR9PuCAfSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnpUmBJidsga6i2za5ZoUYDntJVXaqeZbBoBIjNLD7Y=;
 b=Mg/5TIGNLjhiAHiTDfKJAc4ck1uCK0yKRbnzvps5shvfFIQbE+BKFDS0BLQpxUi5GxCiox7kIMQEYeCCUp5HhVQisduzk9bpdnFBftjp8h7+W63BQ3x9W0LSEdRY+7Tv4+HHJkPjWHUR1X5DoHt+wXYsvZ1xG5HJ1OZWwjgNYpnKllNzomGKOp9wCruL7lN/VQAmLZvAJGPGeD3FEy7FaHcQv1mzk7XIGyBaS75kaBctbprJH5ck1wQV4Fg+4vyB3jScHqWqVhFofA7vj6yiPp0x3Re+jXwtH6n0sA7fs7jz6xco/p91KYV2fMHAp6chyIM9CoU/15M7QkjCo3fezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Wed, 27 Sep
 2023 10:07:16 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24%3]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 10:07:16 +0000
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
Subject: RE: [PATCH v2 06/12] vfio/pci: Introduce vfio_[attach/detach]_device
Thread-Topic: [PATCH v2 06/12] vfio/pci: Introduce vfio_[attach/detach]_device
Thread-Index: AQHZ8G9MBK3w/OsZY02YQxt5EZwDgrAuYYwAgAAQeKA=
Date: Wed, 27 Sep 2023 10:07:16 +0000
Message-ID: <PH7PR11MB6722E62822B43C65DE5187C492C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-7-zhenzhong.duan@intel.com>
 <b1012c96-e76e-10eb-2080-af7d8ff606ee@redhat.com>
In-Reply-To: <b1012c96-e76e-10eb-2080-af7d8ff606ee@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|DS0PR11MB6375:EE_
x-ms-office365-filtering-correlation-id: 2a7e382e-187e-47b1-5297-08dbbf418754
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Li9DrbqeGUWMZ91XhkYQl3sYLojlWJ2Ln7+2cuwyG8ay8gj8ojezMIs7NEVTRx9kGIpOmXQxTwbR1LdXhEE6/AquAG5lI+bgIKWbWhRtzlORMMEcv8hzWJPmayT47RLTmzsKgHFqwYvsFciECpwhZ9YycAKvJwMvypVFLV7hXNsjZNSx99euIHNsoql3yTmgjh7GWT0ZU6IqSBUKYt1BDDuE0nXfkLWzCfAwFnc7PmiDJxv4YSpM0K+W+7CtpNvz/IFp44hFJwVxQGibnrnvZplfggC3WcH1EpBv/RZda4kgrZu/TyX5x6NXig22D9NwzKoNvkPNifOeeEViZQ1ptgu7aXhin6GIBnwnEAuQ498RPFbn2dOj5C7NPNxs/5FalH7Zf+6Om/844kKhDip2BGxwVYvRtvIck62JoiAMlLMY79GMCK7i6VXTFjs4EZrVR3yt7QqGKo6+trlwhkWDOF0e+PK91aOXDMVZnKf8tZ0OEkVqa2R5/f2RzEH/pPaplWAwx7STikqEf0jkaSMUtb0xShDB49VM/APQj4geEPgwFpv73CZTEJyYHUilU8PMWmXpynKDBcEeAELz7jlC8ymtRv1IlIg6zMCVsgj8XAlv7SfVw7kk5PNhnivdh0f+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(230922051799003)(1800799009)(451199024)(186009)(478600001)(55016003)(38100700002)(83380400001)(6506007)(38070700005)(9686003)(7696005)(122000001)(33656002)(71200400001)(82960400001)(26005)(2906002)(107886003)(316002)(8676002)(8936002)(86362001)(66946007)(66476007)(66556008)(4326008)(64756008)(54906003)(41300700001)(110136005)(5660300002)(76116006)(66446008)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UndCM24yM3I3N1M0Umwxbmp4RHZiVmZuSEQrWUlkRWZ1V2xlMFdoNUtUckJv?=
 =?utf-8?B?dkcxN1dGbCtES2x6SDBXZkZmc0FoamI2bmZNTTlyY3dycDF2cnVwYm9NOXNX?=
 =?utf-8?B?cEtqSDMwRlVWNWpRTEZEL0FCOE5MM3JzYmJXeUcydm4yUUFDY2hUcUpwN2I5?=
 =?utf-8?B?UXAxSVBTNFJTcXNIeDJHK05VeTdxUEMzeG84aVdVdnFDdmJOeSsvdTBPRkxk?=
 =?utf-8?B?dU5tY05rQnFoa3dXTkgzZlkyTmJ5ekZaajN2T2liZmxQaCtNaTd6K1BvYjAy?=
 =?utf-8?B?djE4UXRYK3JsOFIvdTJ0aisxZmJUK3daWXZtWGxEMEIzWUlqVHVXNTFtVE8w?=
 =?utf-8?B?UGdxQjZDWVRUaW1UUCtHcUZBUVVmZ1l6YVY3bTA0bmQrRlZaVk13Z1lHcEQy?=
 =?utf-8?B?QmMzRTllcGpxOXg1bmNYamNPTmhtZktVYkZBOEQvUGFGZ1d6QlhmVEMwL1ZO?=
 =?utf-8?B?T05oRzFvM0pZT1pHWm5ZSTZpRW9aNy9RclRtaGZnTkJ5ZlNiVHpZNElyNFZU?=
 =?utf-8?B?NktqWmVSRlNBK3lBQXRGWjd0ODl3VHNEbWhPanNMY2lYZGxVZEZjTEUyVWxF?=
 =?utf-8?B?djFCUkhmZytkQTVsbnphaWVFdzB3dlB5TEE3emp5dG5vNU9lOEU1NkY3Si9t?=
 =?utf-8?B?NUU4Vm1FR09pTUhZLy9DTm5USXF3eC9tWGZybG1CSjk4WG9STGpBRGY5WXpD?=
 =?utf-8?B?V1E5eGJ6MUVTWXBnTFpQWlJZUFdJOU9mNmkwV0s4Q1BhRDBDNkJRWk1zaFBm?=
 =?utf-8?B?eldVU0NTS3RLSTdrTXBWbm5Vdnd0d2ZXb3YydVZqemZYQ2trbUFJTm5BaEVt?=
 =?utf-8?B?Y2NTcXRVa0pkNm1WSmRqdTF3WkZhSVFhTWZvNHFBSmlyUHZ3YkVoeXZFeEVF?=
 =?utf-8?B?OU9ybU1HemZtbmVyTXdoYkFjdWVhdWpqc2lJS0wxSk94VXF1UzJFMU5MYks2?=
 =?utf-8?B?a3JyWkpWYVM2OXVoVEpnbE1adjdYcVhBODh0N0o4SU1iYkdGbWI3cm56enhr?=
 =?utf-8?B?dnAyUVVvQlBEYUtEV3Fta1JnMDhZQlltbGJkaFI4Y3dTYXRtNjJRVjFveWNw?=
 =?utf-8?B?cVVtdDBrNGo0NlRLUnFMSG5vVWdVQTgzcjNMSm1ybmF5aHhMUS9KdXNvOXhY?=
 =?utf-8?B?SHRDYmlPUXQ2RVRyOVJPRXdNcGpXSHM5TFo1cWQ5Q3haMkxxYW1jbTJwYm13?=
 =?utf-8?B?a0cyNFZId3FycmQxNzFPbE1ndHdkZkhiajZHUVd0ZEoxUjdrcDh4d1czQ295?=
 =?utf-8?B?cnBNSHVycGd5aHpXR1lqOWF4TTlYekJKSFVsdnFGYU9oM25pTUxwWWJ0NzBL?=
 =?utf-8?B?VUxiVEl2aWR2YzU3bTJRL3NvbGk0UUxxRGd6YXJRRmhLa1Njd2VlTCtvRE85?=
 =?utf-8?B?WHZFVkxJbE5jWWh1dlFhMFFiZ2M5dFROT0tJYjJQUG56YTVua0R0TmJHZG4v?=
 =?utf-8?B?SWVXSWEybzZleitMRHc2enJ0NWRNUWZHaWwyRXhRSytLYnNhRjREeUY0eE95?=
 =?utf-8?B?OGJWUTNUaGQ2TmtrTUNIYmU5MXNUaEdpOElwcENxdGlkK3liNUxrYk1EUStN?=
 =?utf-8?B?b0hpNzVpWVRFK3dZZk9WamcrTnhxQituSmxzU3JRandYMTBtV0hZc0NXRSs0?=
 =?utf-8?B?amQzZlNXaDQ3amh6S0hOZVZibXJSVVk4SnFqZXY5M3JJaXhOa20vN3VRd3FK?=
 =?utf-8?B?R0Q4ak8yM1BncFhNNGpnZUw0dHQweUg5Q29mejROL0hVTGM1dXpqMTMrci9h?=
 =?utf-8?B?b1BzRnVicTN0M1FENWlQNWZrZStraEJpT1l3V2xOK0QyajU0SUwxL1dVK3Z0?=
 =?utf-8?B?ZDNsQjRhUnczOVpJSlB1V0NKVFdUdGVjcFZTVzU1V1oyd0RtSEM2bFJBTERX?=
 =?utf-8?B?VGNzUGZFRUVXck1sOEw5ZTdWTDBCWEt1NnpjZWFYSVRXWVlFd2ptZGdlZTdR?=
 =?utf-8?B?N29pUEZTdXFkU0RBVWpJYlcrTURkajhqZnZVbzhmMm83RGFWUEwyNStQaWZ6?=
 =?utf-8?B?clFFYStvRjg5ck5UZzlKQmZyTEgrUW95d0d0SE56VDVXWFJtQWZ6MEMzYXVS?=
 =?utf-8?B?UE5HM3YvbitQSURad1lQeTdON2dJaHlSZ2FzQ08vUnVhejUyWnF4VForZjNr?=
 =?utf-8?Q?zsoJFTXLPG3FyD8ylp+cJjomD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7e382e-187e-47b1-5297-08dbbf418754
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 10:07:16.7042 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TUj0RUto8Js59VVcCQXjsFythS+wFR/PbealV93O46ubyfFPoks/2j5MtWFdENjNazpl1uBMB/Yu45KfVmPZBIiE42nwCFbuOYGPE1AGKTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6375
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24;
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
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDI3
LCAyMDIzIDU6MDIgUE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDA2LzEyXSB2ZmlvL3BjaTog
SW50cm9kdWNlIHZmaW9fW2F0dGFjaC9kZXRhY2hdX2RldmljZQ0KPg0KPkhpIFpoZW56aG9uZywN
Cj4NCj5PbiA5LzI2LzIzIDEzOjMyLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEZyb206IEVy
aWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+DQo+PiBXZSB3YW50IHRoZSBWRklP
IGRldmljZXMgdG8gYmUgYWJsZSB0byB1c2UgdHdvIGRpZmZlcmVudA0KPj4gSU9NTVUgYmFja2Vu
ZHMsIHRoZSBsZWdhY3kgVkZJTyBvbmUgYW5kIHRoZSBuZXcgaW9tbXVmZCBvbmUuDQo+Pg0KPj4g
SW50cm9kdWNlIHZmaW9fW2F0dGFjaC9kZXRhY2hdX2RldmljZSB3aGljaCBhaW0gYXQgaGlkaW5n
IHRoZQ0KPj4gdW5kZXJseWluZyBJT01NVSBiYWNrZW5kIChJT0NUTHMsIGRhdGF0eXBlcywgLi4u
KS4NCj4+DQo+PiBPbmNlIHZmaW9fYXR0YWNoX2RldmljZSBjb21wbGV0ZXMsIHRoZSBkZXZpY2Ug
aXMgYXR0YWNoZWQNCj4+IHRvIGEgc2VjdXJpdHkgY29udGV4dCBhbmQgaXRzIGZkIGNhbiBiZSB1
c2VkLiBDb252ZXJzZWx5DQo+PiBXaGVuIHZmaW9fZGV0YWNoX2RldmljZSBjb21wbGV0ZXMsIHRo
ZSBkZXZpY2UgaGFzIGJlZW4NCj4+IGRldGFjaGVkIGZyb20gdGhlIHNlY3VyaXR5IGNvbnRleHQu
DQo+Pg0KPj4gQXQgdGhlIG1vbWVudCBvbmx5IHRoZSBpbXBsZW1lbnRhdGlvbiBiYXNlZCBvbiB0
aGUgbGVnYWN5DQo+PiBjb250YWluZXIvZ3JvdXAgZXhpc3RzLiBMZXQncyB1c2UgaXQgZnJvbSB0
aGUgdmZpby1wY2kgZGV2aWNlLg0KPj4gU3Vic2VxdWVudCBwYXRjaGVzIHdpbGwgaGFuZGxlIG90
aGVyIGRldmljZXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdl
ckByZWRoYXQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5j
b20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50
ZWwuY29tPg0KPj4gLS0tDQo+PiAgaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggfCAgMyAr
Kw0KPj4gIGh3L3ZmaW8vY29tbW9uLmMgICAgICAgICAgICAgIHwgNjggKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4+ICBody92ZmlvL3BjaS5jICAgICAgICAgICAgICAgICB8
IDUwICsrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAgaHcvdmZpby90cmFjZS1ldmVudHMg
ICAgICAgICAgfCAgMiArLQ0KPj4gIDQgZmlsZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKSwg
NDYgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmZpby92Zmlv
LWNvbW1vbi5oIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+IGluZGV4IGM0ZTdj
M2I0YTcuLjEyZmJmYmMzN2QgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1j
b21tb24uaA0KPj4gKysrIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+IEBAIC0y
MjUsNiArMjI1LDkgQEAgdm9pZCB2ZmlvX3B1dF9ncm91cChWRklPR3JvdXAgKmdyb3VwKTsNCj4+
ICBzdHJ1Y3QgdmZpb19kZXZpY2VfaW5mbyAqdmZpb19nZXRfZGV2aWNlX2luZm8oaW50IGZkKTsN
Cj4+ICBpbnQgdmZpb19nZXRfZGV2aWNlKFZGSU9Hcm91cCAqZ3JvdXAsIGNvbnN0IGNoYXIgKm5h
bWUsDQo+PiAgICAgICAgICAgICAgICAgICAgICBWRklPRGV2aWNlICp2YmFzZWRldiwgRXJyb3Ig
KiplcnJwKTsNCj4+ICtpbnQgdmZpb19hdHRhY2hfZGV2aWNlKGNoYXIgKm5hbWUsIFZGSU9EZXZp
Y2UgKnZiYXNlZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgQWRkcmVzc1NwYWNlICph
cywgRXJyb3IgKiplcnJwKTsNCj4+ICt2b2lkIHZmaW9fZGV0YWNoX2RldmljZShWRklPRGV2aWNl
ICp2YmFzZWRldik7DQo+Pg0KPj4gIGludCB2ZmlvX2t2bV9kZXZpY2VfYWRkX2ZkKGludCBmZCwg
RXJyb3IgKiplcnJwKTsNCj4+ICBpbnQgdmZpb19rdm1fZGV2aWNlX2RlbF9mZChpbnQgZmQsIEVy
cm9yICoqZXJycCk7DQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9jb21tb24uYyBiL2h3L3ZmaW8v
Y29tbW9uLmMNCj4+IGluZGV4IDk1OWIxMzYyYmIuLjdmMzc5OGIxNTIgMTAwNjQ0DQo+PiAtLS0g
YS9ody92ZmlvL2NvbW1vbi5jDQo+PiArKysgYi9ody92ZmlvL2NvbW1vbi5jDQo+PiBAQCAtMjYx
MSwzICsyNjExLDcxIEBAIGludCB2ZmlvX2VlaF9hc19vcChBZGRyZXNzU3BhY2UgKmFzLCB1aW50
MzJfdCBvcCkNCj4+ICAgICAgfQ0KPj4gICAgICByZXR1cm4gdmZpb19lZWhfY29udGFpbmVyX29w
KGNvbnRhaW5lciwgb3ApOw0KPj4gIH0NCj4+ICsNCj4+ICtzdGF0aWMgaW50IHZmaW9fZGV2aWNl
X2dyb3VwaWQoVkZJT0RldmljZSAqdmJhc2VkZXYsIEVycm9yICoqZXJycCkNCj4+ICt7DQo+PiAr
ICAgIGNoYXIgKnRtcCwgZ3JvdXBfcGF0aFtQQVRIX01BWF0sICpncm91cF9uYW1lOw0KPj4gKyAg
ICBpbnQgcmV0LCBncm91cGlkOw0KPj4gKyAgICBzc2l6ZV90IGxlbjsNCj4+ICsNCj4+ICsgICAg
dG1wID0gZ19zdHJkdXBfcHJpbnRmKCIlcy9pb21tdV9ncm91cCIsIHZiYXNlZGV2LT5zeXNmc2Rl
dik7DQo+PiArICAgIGxlbiA9IHJlYWRsaW5rKHRtcCwgZ3JvdXBfcGF0aCwgc2l6ZW9mKGdyb3Vw
X3BhdGgpKTsNCj4+ICsgICAgZ19mcmVlKHRtcCk7DQo+PiArDQo+PiArICAgIGlmIChsZW4gPD0g
MCB8fCBsZW4gPj0gc2l6ZW9mKGdyb3VwX3BhdGgpKSB7DQo+PiArICAgICAgICByZXQgPSBsZW4g
PCAwID8gLWVycm5vIDogLUVOQU1FVE9PTE9ORzsNCj4+ICsgICAgICAgIGVycm9yX3NldGdfZXJy
bm8oZXJycCwgLXJldCwgIm5vIGlvbW11X2dyb3VwIGZvdW5kIik7DQo+PiArICAgICAgICByZXR1
cm4gcmV0Ow0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGdyb3VwX3BhdGhbbGVuXSA9IDA7DQo+
PiArDQo+PiArICAgIGdyb3VwX25hbWUgPSBiYXNlbmFtZShncm91cF9wYXRoKTsNCj4+ICsgICAg
aWYgKHNzY2FuZihncm91cF9uYW1lLCAiJWQiLCAmZ3JvdXBpZCkgIT0gMSkgew0KPj4gKyAgICAg
ICAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCBlcnJubywgImZhaWxlZCB0byByZWFkICVzIiwgZ3Jv
dXBfcGF0aCk7DQo+PiArICAgICAgICByZXR1cm4gLWVycm5vOw0KPj4gKyAgICB9DQo+PiArICAg
IHJldHVybiBncm91cGlkOw0KPj4gK30NCj4+ICsNCj4+ICtpbnQgdmZpb19hdHRhY2hfZGV2aWNl
KGNoYXIgKm5hbWUsIFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgQWRkcmVzc1NwYWNlICphcywgRXJyb3IgKiplcnJwKQ0KPj4gK3sNCj4+ICsgICAgaW50
IGdyb3VwaWQgPSB2ZmlvX2RldmljZV9ncm91cGlkKHZiYXNlZGV2LCBlcnJwKTsNCj4+ICsgICAg
VkZJT0RldmljZSAqdmJhc2VkZXZfaXRlcjsNCj4+ICsgICAgVkZJT0dyb3VwICpncm91cDsNCj4+
ICsgICAgaW50IHJldDsNCj4+ICsNCj4+ICsgICAgaWYgKGdyb3VwaWQgPCAwKSB7DQo+PiArICAg
ICAgICByZXR1cm4gZ3JvdXBpZDsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICB0cmFjZV92Zmlv
X2F0dGFjaF9kZXZpY2UodmJhc2VkZXYtPm5hbWUsIGdyb3VwaWQpOw0KPj4gKw0KPj4gKyAgICBn
cm91cCA9IHZmaW9fZ2V0X2dyb3VwKGdyb3VwaWQsIGFzLCBlcnJwKTsNCj4+ICsgICAgaWYgKCFn
cm91cCkgew0KPj4gKyAgICAgICAgcmV0dXJuIC1FTk9FTlQ7DQo+PiArICAgIH0NCj4+ICsNCj4+
ICsgICAgUUxJU1RfRk9SRUFDSCh2YmFzZWRldl9pdGVyLCAmZ3JvdXAtPmRldmljZV9saXN0LCBu
ZXh0KSB7DQo+PiArICAgICAgICBpZiAoc3RyY21wKHZiYXNlZGV2X2l0ZXItPm5hbWUsIHZiYXNl
ZGV2LT5uYW1lKSA9PSAwKSB7DQo+PiArICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiZGV2
aWNlIGlzIGFscmVhZHkgYXR0YWNoZWQiKTsNCj4+ICsgICAgICAgICAgICB2ZmlvX3B1dF9ncm91
cChncm91cCk7DQo+PiArICAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsNCj4+ICsgICAgICAgIH0N
Cj4+ICsgICAgfQ0KPj4gKyAgICByZXQgPSB2ZmlvX2dldF9kZXZpY2UoZ3JvdXAsIG5hbWUsIHZi
YXNlZGV2LCBlcnJwKTsNCj4+ICsgICAgaWYgKHJldCkgew0KPj4gKyAgICAgICAgdmZpb19wdXRf
Z3JvdXAoZ3JvdXApOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIHJldHVybiByZXQ7DQo+PiAr
fQ0KPj4gKw0KPj4gK3ZvaWQgdmZpb19kZXRhY2hfZGV2aWNlKFZGSU9EZXZpY2UgKnZiYXNlZGV2
KQ0KPj4gK3sNCj4+ICsgICAgVkZJT0dyb3VwICpncm91cCA9IHZiYXNlZGV2LT5ncm91cDsNCj4+
ICsNCj4+ICsgICAgdmZpb19wdXRfYmFzZV9kZXZpY2UodmJhc2VkZXYpOw0KPj4gKyAgICB2Zmlv
X3B1dF9ncm91cChncm91cCk7DQo+PiArfQ0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vcGNpLmMg
Yi9ody92ZmlvL3BjaS5jDQo+PiBpbmRleCAzYjJjYTNjMjRjLi5mZTU2Nzg5ODkzIDEwMDY0NA0K
Pj4gLS0tIGEvaHcvdmZpby9wY2kuYw0KPj4gKysrIGIvaHcvdmZpby9wY2kuYw0KPj4gQEAgLTI4
MjgsMTAgKzI4MjgsMTAgQEAgc3RhdGljIHZvaWQgdmZpb19wb3B1bGF0ZV9kZXZpY2UoVkZJT1BD
SURldmljZQ0KPip2ZGV2LCBFcnJvciAqKmVycnApDQo+Pg0KPj4gIHN0YXRpYyB2b2lkIHZmaW9f
cHV0X2RldmljZShWRklPUENJRGV2aWNlICp2ZGV2KQ0KPj4gIHsNCj4+ICsgICAgdmZpb19kZXRh
Y2hfZGV2aWNlKCZ2ZGV2LT52YmFzZWRldik7DQo+PiArDQo+PiAgICAgIGdfZnJlZSh2ZGV2LT52
YmFzZWRldi5uYW1lKTsNCj4+ICAgICAgZ19mcmVlKHZkZXYtPm1zaXgpOw0KPj4gLQ0KPj4gLSAg
ICB2ZmlvX3B1dF9iYXNlX2RldmljZSgmdmRldi0+dmJhc2VkZXYpOw0KPj4gIH0NCj4+DQo+PiAg
c3RhdGljIHZvaWQgdmZpb19lcnJfbm90aWZpZXJfaGFuZGxlcih2b2lkICpvcGFxdWUpDQo+PiBA
QCAtMjk3OCwxMyArMjk3OCw5IEBAIHN0YXRpYyB2b2lkIHZmaW9fcmVhbGl6ZShQQ0lEZXZpY2Ug
KnBkZXYsIEVycm9yDQo+KiplcnJwKQ0KPj4gIHsNCj4+ICAgICAgVkZJT1BDSURldmljZSAqdmRl
diA9IFZGSU9fUENJKHBkZXYpOw0KPj4gICAgICBWRklPRGV2aWNlICp2YmFzZWRldiA9ICZ2ZGV2
LT52YmFzZWRldjsNCj4+IC0gICAgVkZJT0RldmljZSAqdmJhc2VkZXZfaXRlcjsNCj4+IC0gICAg
VkZJT0dyb3VwICpncm91cDsNCj4+IC0gICAgY2hhciAqdG1wLCAqc3Vic3lzLCBncm91cF9wYXRo
W1BBVEhfTUFYXSwgKmdyb3VwX25hbWU7DQo+PiArICAgIGNoYXIgKnRtcCwgKnN1YnN5czsNCj4+
ICAgICAgRXJyb3IgKmVyciA9IE5VTEw7DQo+PiAtICAgIHNzaXplX3QgbGVuOw0KPj4gICAgICBz
dHJ1Y3Qgc3RhdCBzdDsNCj4+IC0gICAgaW50IGdyb3VwaWQ7DQo+PiAgICAgIGludCBpLCByZXQ7
DQo+PiAgICAgIGJvb2wgaXNfbWRldjsNCj4+ICAgICAgY2hhciB1dWlkW1VVSURfRk1UX0xFTl07
DQo+PiBAQCAtMzAxNSwzOSArMzAxMSw2IEBAIHN0YXRpYyB2b2lkIHZmaW9fcmVhbGl6ZShQQ0lE
ZXZpY2UgKnBkZXYsIEVycm9yDQo+KiplcnJwKQ0KPj4gICAgICB2YmFzZWRldi0+dHlwZSA9IFZG
SU9fREVWSUNFX1RZUEVfUENJOw0KPj4gICAgICB2YmFzZWRldi0+ZGV2ID0gREVWSUNFKHZkZXYp
Ow0KPj4NCj4+IC0gICAgdG1wID0gZ19zdHJkdXBfcHJpbnRmKCIlcy9pb21tdV9ncm91cCIsIHZi
YXNlZGV2LT5zeXNmc2Rldik7DQo+PiAtICAgIGxlbiA9IHJlYWRsaW5rKHRtcCwgZ3JvdXBfcGF0
aCwgc2l6ZW9mKGdyb3VwX3BhdGgpKTsNCj4+IC0gICAgZ19mcmVlKHRtcCk7DQo+PiAtDQo+PiAt
ICAgIGlmIChsZW4gPD0gMCB8fCBsZW4gPj0gc2l6ZW9mKGdyb3VwX3BhdGgpKSB7DQo+PiAtICAg
ICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIGxlbiA8IDAgPyBlcnJubyA6IEVOQU1FVE9PTE9O
RywNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgIm5vIGlvbW11X2dyb3VwIGZvdW5kIik7
DQo+PiAtICAgICAgICBnb3RvIGVycm9yOw0KPj4gLSAgICB9DQo+PiAtDQo+PiAtICAgIGdyb3Vw
X3BhdGhbbGVuXSA9IDA7DQo+PiAtDQo+PiAtICAgIGdyb3VwX25hbWUgPSBiYXNlbmFtZShncm91
cF9wYXRoKTsNCj4+IC0gICAgaWYgKHNzY2FuZihncm91cF9uYW1lLCAiJWQiLCAmZ3JvdXBpZCkg
IT0gMSkgew0KPj4gLSAgICAgICAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCBlcnJubywgImZhaWxl
ZCB0byByZWFkICVzIiwgZ3JvdXBfcGF0aCk7DQo+PiAtICAgICAgICBnb3RvIGVycm9yOw0KPj4g
LSAgICB9DQo+PiAtDQo+PiAtICAgIHRyYWNlX3ZmaW9fcmVhbGl6ZSh2YmFzZWRldi0+bmFtZSwg
Z3JvdXBpZCk7DQo+PiAtDQo+PiAtICAgIGdyb3VwID0gdmZpb19nZXRfZ3JvdXAoZ3JvdXBpZCwg
cGNpX2RldmljZV9pb21tdV9hZGRyZXNzX3NwYWNlKHBkZXYpLA0KPmVycnApOw0KPj4gLSAgICBp
ZiAoIWdyb3VwKSB7DQo+PiAtICAgICAgICBnb3RvIGVycm9yOw0KPj4gLSAgICB9DQo+PiAtDQo+
PiAtICAgIFFMSVNUX0ZPUkVBQ0godmJhc2VkZXZfaXRlciwgJmdyb3VwLT5kZXZpY2VfbGlzdCwg
bmV4dCkgew0KPj4gLSAgICAgICAgaWYgKHN0cmNtcCh2YmFzZWRldl9pdGVyLT5uYW1lLCB2YmFz
ZWRldi0+bmFtZSkgPT0gMCkgew0KPj4gLSAgICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgImRl
dmljZSBpcyBhbHJlYWR5IGF0dGFjaGVkIik7DQo+PiAtICAgICAgICAgICAgdmZpb19wdXRfZ3Jv
dXAoZ3JvdXApOw0KPj4gLSAgICAgICAgICAgIGdvdG8gZXJyb3I7DQo+PiAtICAgICAgICB9DQo+
PiAtICAgIH0NCj4+IC0NCj4+ICAgICAgLyoNCj4+ICAgICAgICogTWVkaWF0ZWQgZGV2aWNlcyAq
bWlnaHQqIG9wZXJhdGUgY29tcGF0aWJseSB3aXRoIGRpc2NhcmRpbmcgb2YgUkFNLCBidXQNCj4+
ICAgICAgICogd2UgY2Fubm90IGtub3cgZm9yIGNlcnRhaW4sIGl0IGRlcGVuZHMgb24gd2hldGhl
ciB0aGUgbWRldiB2ZW5kb3INCj5kcml2ZXINCj4+IEBAIC0zMDY1LDcgKzMwMjgsNiBAQCBzdGF0
aWMgdm9pZCB2ZmlvX3JlYWxpemUoUENJRGV2aWNlICpwZGV2LCBFcnJvciAqKmVycnApDQo+PiAg
ICAgIGlmICh2YmFzZWRldi0+cmFtX2Jsb2NrX2Rpc2NhcmRfYWxsb3dlZCAmJiAhaXNfbWRldikg
ew0KPj4gICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAieC1iYWxsb29uLWFsbG93ZWQgb25seSBw
b3RlbnRpYWxseSBjb21wYXRpYmxlICINCj4+ICAgICAgICAgICAgICAgICAgICAgIndpdGggbWRl
diBkZXZpY2VzIik7DQo+PiAtICAgICAgICB2ZmlvX3B1dF9ncm91cChncm91cCk7DQo+PiAgICAg
ICAgICBnb3RvIGVycm9yOw0KPj4gICAgICB9DQo+Pg0KPj4gQEAgLTMwNzYsMTAgKzMwMzgsMTAg
QEAgc3RhdGljIHZvaWQgdmZpb19yZWFsaXplKFBDSURldmljZSAqcGRldiwgRXJyb3INCj4qKmVy
cnApDQo+PiAgICAgICAgICBuYW1lID0gZ19zdHJkdXAodmJhc2VkZXYtPm5hbWUpOw0KPj4gICAg
ICB9DQo+Pg0KPj4gLSAgICByZXQgPSB2ZmlvX2dldF9kZXZpY2UoZ3JvdXAsIG5hbWUsIHZiYXNl
ZGV2LCBlcnJwKTsNCj4+ICsgICAgcmV0ID0gdmZpb19hdHRhY2hfZGV2aWNlKG5hbWUsIHZiYXNl
ZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGNpX2RldmljZV9pb21tdV9h
ZGRyZXNzX3NwYWNlKHBkZXYpLCBlcnJwKTsNCj4+ICAgICAgZ19mcmVlKG5hbWUpOw0KPj4gICAg
ICBpZiAocmV0KSB7DQo+PiAtICAgICAgICB2ZmlvX3B1dF9ncm91cChncm91cCk7DQo+aW5kZXBl
bmRlbnRseSBvbiB0aGlzIHBhdGNoLCBJIHRoaW5rIGluIGNhc2Ugb2YgZXJyb3Igd2UgbGVhaw0K
PnZiYXNlZGV2LT5uYW1lLiBQbGVhc2UgaGF2ZSBhIGxvb2sgYW5kIGlmIGNvbmZpcm1lZCB5b3Ug
Y2FuIHNlbmQgYQ0KPnNlcGFyYXRlIHBhdGNoLg0KDQpJbiBjYXNlIG9mIGVycm9yLCB2YmFzZWRl
di0+bmFtZSBpcyBmcmVlZCBpbiB2ZmlvX3B1dF9kZXZpY2UoKS4NCg0KPg0KPkFsc28gSSB0aGlu
ayBpZiBhbnkgc3Vic2VxdWVudCBhY3Rpb24gZmFpbCB3ZSBzaG91ZGwgcHJvcGVybHkgZGV0YWNo
IHRoZQ0KPmRldGFjaCB0aGUgZGV2aWNlIHNvIGludHJvZHVjZSBhbiBleHRyYSBlcnJvciBnb3Rv
IGxhYmVsLCBteSBiYWQgc29ycnkuDQoNCnZmaW9fZGV0YWNoX2RldmljZSBpcyBjYWxsZWQgaW4g
dmZpb19pbnN0YW5jZV9maW5hbGl6ZSgpLCB0aGlzIGlzIGp1c3QgdG8gZm9sbG93DQp0aGUgb2xk
IGNvZGUsIGdyb3VwIGFuZCBjb250YWluZXIgcmVzb3VyY2UgYWxsb2NhdGVkIGluIHZmaW9fcmVh
bGl6ZSgpIGFyZQ0KZnJlZWQgaW4gdmZpb19pbnN0YW5jZV9maW5hbGl6ZSgpLg0KDQpJIGFncmVl
IHRoaXMgaXMgc3RyYW5nZSwgYnV0IEkgZ3Vlc3MgdGhlcmUgbWF5IGJlIHNvbWUgcmVhc29uIEkn
bSB1bmNsZWFyLg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo=

