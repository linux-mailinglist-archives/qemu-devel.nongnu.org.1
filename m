Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9E67EBB5B
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 03:57:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r364X-0000hf-52; Tue, 14 Nov 2023 21:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r364U-0000hE-Aj
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 21:56:06 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r364R-0007G1-MU
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 21:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700016964; x=1731552964;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=F2qHY2DuZ3uMWityXbeIMZU7gdN/Iw+gQyPv0SL3jxE=;
 b=G56KUdnwOoeokCWEDXmwsoabtK57sF2jnw9pI3zrZEeoTr97hJ0DMpbF
 a8xlKf0oB/hcUEE1qJgifHam29m+/R46c2ft8g67cz0jMwbeolaZxnMKp
 xo6JXiB+rvthRdZaNNsZLjIZwhqudmFKCjA4FDYdEYCqisAtr50YOpzzC
 oQwJAfF9bqYwl+69LlFzixdVundkTer6qLIIFGcXVhAmE8nM5MAji0M5J
 t1pCwd37rD7vJNvTLrpTrSR31GEXYQ4AOrN2m8kGKPC719cVz/JjorFoz
 nq5ewaT377CbIGiYKQh9UneXO35fGb2LC/O/Upku53xueARYzIapUTzq5 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="9436735"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="9436735"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 18:56:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="835266196"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; d="scan'208";a="835266196"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Nov 2023 18:55:59 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 18:55:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 18:55:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 18:55:58 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 18:55:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3arMMDnYagriPyAkgX8URUpo6toMn/1/a6SkD9XqSLbKSWZdHFAyYVzZHcQLdQk7IQq8+LjxT4yRYWuVUxtRjz6ql4RTmgr//aTuZ7kOoCVSZ0e7aKsfxgQaT3CvUb36TnJ7846aDEGikPxVL/XCad2lL8LV3SXuBS/y452VreHTVV8iGBT3xX7IrNcGAVb1JlNxq04KA2X9BOspePYf4OHh0Jh7uCbXFHwkOeLdogmsw5tsskkBRiH89WOmrzvI2wfohHf+48ZLgZKFD3uPO4K9b4+6iAMC5t9+Ucevd+7LMJOgLuguruhEMr0AUxMWCVyPoGiTZMhjcS7AMVn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2qHY2DuZ3uMWityXbeIMZU7gdN/Iw+gQyPv0SL3jxE=;
 b=OmZ9wXs1cTTN5OZGBtIj+Cih9APmKqSzu25WwOSTedn17yGlNcXL93vFAuphbnTOdFkMfFqFt3z7CXg7iqptjaR4cmEaCfsDJtGxBjmdoj3fNye07QIEUZYVpsc40ZLNSqVFO+0gUnGr40IJhYWyO7L1CvE9dKsKJrwmcgCwJZmri0Q9pM25u0rzAayte99H0J8mn12sTy41SY0EdkjBoJ7XP2REErpEunEws32/LYAHmX9VMygM4ft0L5/QVnJ589jGrX6JnP2lQ5ljcSoogQo3hxliS0TfMi13ixz4ibRDvQU757NCsuvc2WZ2uc0+Bd2foyQ8fg8Qu32zqZyRWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA2PR11MB4858.namprd11.prod.outlook.com (2603:10b6:806:f9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 02:55:56 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 02:55:55 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 08/21] vfio/pci: Introduce a vfio pci hot reset
 interface
Thread-Topic: [PATCH v6 08/21] vfio/pci: Introduce a vfio pci hot reset
 interface
Thread-Index: AQHaFuT9oVtmgCOXSUmIvZteXZjuJLB51a2AgADZdyA=
Date: Wed, 15 Nov 2023 02:55:55 +0000
Message-ID: <SJ0PR11MB6744BC2D1A9C08FEA668909992B1A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-9-zhenzhong.duan@intel.com>
 <2b0aac23-6c79-4dde-8053-a51f4ecc5b92@redhat.com>
In-Reply-To: <2b0aac23-6c79-4dde-8053-a51f4ecc5b92@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA2PR11MB4858:EE_
x-ms-office365-filtering-correlation-id: 8c327eee-24dc-4415-308c-08dbe58662e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9k6cr2bKm6wLwo3/75yaqP3Fo921ac2nxDyA/vPzYC6k65gnpftB34/t2Tds6CwZ1FhiwBGaGkZ4N9eh2E9qtO05Tec1lZlNtUFw5HeYbYsFnovSnmnYEPvw0m8m3/wfHi8ILyiXZ7ZhcefU6yaij7J7uyyMCH13JNQaoNvAjfUtnj3X7opvqC98B+ZVR+HWKBjVmzWE7xf8T1aV1CtnK0/sQ0OdrJggEqe/erpp2MFayeuQAExcrU4XhmJkRskfU19UgpyxO2Qc+CnsHEAezDz4jog7Lgyyvo1rJWExqBadFrXQfX3MwRP2Ca29FAROiShG4YkLTHvbd8Sldn/VXUibTzFftiDmN7E1s3TJcbT4clL5Ap7pQaHqXulu1ki0VZMzl2JI77x8KgmjdnSpEt7JCTWHpoqNQDHISz8Sj3qUUdC2whrnIh/iL7X3HG4ODjVJA9DhKPTn9eRWJTHyHdXrjRsUxq/lqUsDkWTp3bxvHxEOaK/PjGdBxvfP7ydDpxFt5vZOqVBclBXnk/hk3MMyFrp7VGP3McsAfhqU9ukJdkGAKu/Hrk9eqb+8ausD/rbCpVOTP44xMvv5J3KTMahMd76S48J69rPxup6+u2i/s1HOEthrqjoaljKaZFmF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(82960400001)(9686003)(66574015)(107886003)(26005)(478600001)(52536014)(86362001)(4326008)(8676002)(8936002)(5660300002)(41300700001)(33656002)(4744005)(2906002)(76116006)(66476007)(38070700009)(54906003)(64756008)(66556008)(66946007)(66446008)(316002)(110136005)(6506007)(7696005)(71200400001)(55016003)(38100700002)(122000001)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUlXc2ZRK2J3N3FHY25qMFpTcXh3L3RWSit1R2lBZWd4VjEyeXQvWVAvNjZX?=
 =?utf-8?B?d2QxV2luS1JZdjQzelhiOTAxQVB2OTFoQlBTVE90aTRIendKckNyOERUMXht?=
 =?utf-8?B?V1FRUTlqa096MTVCUCtpZXR1ejh0NXFTUE51WTR0bGZVR2FISU9LWmYxTnZj?=
 =?utf-8?B?YTBnTVFURkR2MkZub0JWSlgvZ2JZZkhzNGxzSmtJUXo2UWNtcjlpY1k5RmFK?=
 =?utf-8?B?QjRFUnAwbkJOWk1YN0JTRnRLSTZpY0pWSDB2bFN1U0I5TmNiU2FyNk9zOUlm?=
 =?utf-8?B?ZGw4Zmh2T0Mzc2s4WnNQTjZmc0tVSDdsWVlFVWFSR0w5eDZpd056emh2bENE?=
 =?utf-8?B?Z2tybEJVQW01aUpBZkxsRnljbm8vaUVBNURKRS9UU3U4cjYvTXBMRjZFMkJB?=
 =?utf-8?B?Ui9haFl5YjEzNnROWnJNNktyVEpDYnhUbWw5TWVsdTQ1VEdtRVpNRC9QU1Vo?=
 =?utf-8?B?ZUFXVFRtemliQWJ1OVJWcjhtM3VoNlVlS0t4Z2NzSFNzNGc1QkhWSkRXUjNl?=
 =?utf-8?B?djByb2plTDJWdEw2enVGSGpUZnVEbkVOVzJXT1dBSkxWTWhHRzh1ZmlrcGJL?=
 =?utf-8?B?UUFKTjdnRkQvNHVOTXJ2L1FBbFliQXZCWE5JYmRMMUZIZkJGd2dTbC9RWVd1?=
 =?utf-8?B?WkdEbnpzcklESjU3MTZkZ01qRFo2ZkhXRTlQbngrUEVveXRUY2IxU096SVNN?=
 =?utf-8?B?cXB1OVdybjBpWmJSajJXOUxEMms0WS9VRFYydExDZDRGdkRZRk4raTJsUXdy?=
 =?utf-8?B?ZDR2TllZYVdZbDNCSU8xN043Q3plODh0cmlOcWJ4RTJaQ1cyMHBqR3dkdFp0?=
 =?utf-8?B?dVBiOURzQXZiTkxxdW0zZnozK3hPZ0VvQlQrYVQyWWZCQTNLbmNRWGttOFNj?=
 =?utf-8?B?Z0RuZU5ZQ21nYTNBWDJNcENDNjJzNzhYVXlPekZROWIveXlST1hjRzVPcmJv?=
 =?utf-8?B?THRuOXEzSmJ0ZWRES05ZRDdFNGtrZWJyOHFvME5XS1BLemhnbHZ4aU5NVHdT?=
 =?utf-8?B?eE5NWXd5ZVZwN1BOZ3AvaUQxSlJUeUpIV1BNVkRNa1E1NHZ6cDFwQzl0eWMr?=
 =?utf-8?B?bHYzRXR0MmVtcjFwa1dmcE84S0l5RzQvN2FiMEZwQkN3TDBmQWp6a1NQa1pk?=
 =?utf-8?B?RVBXWXgvYWMyZnVtRVR0ZytnZTBPYnhjL3BESzYya2JQUnhWTmtoYnpVbUNh?=
 =?utf-8?B?bkJ1MGFYc1lEVnZaNEcrOVEvaU1memJwL3Q3VlU5QzNYbnhHNHp0SE4vMDJU?=
 =?utf-8?B?L2ZEd3k0SllNUWUvQ0RSamtOS1UxT3hUaFFzOVlyd2phelJlUjNxRzZQRzVh?=
 =?utf-8?B?TXY2VjQ0SmMzQ0t2RzR6OEQ5TDh6YWZWak4wQzBhU1BNcWZDdFoxVEc3OFo0?=
 =?utf-8?B?VTdySTdSM1BoRXN3azRWNFRPNG9KOXJDTDBTRWFQeitPRDFuUmRmcWhhSXA1?=
 =?utf-8?B?K0Q5TXNOMnBPcUF6Q2lIZU9uaWh6Q0ovUlVJKzEzaHBPRDcyUDd5K0JUSmZZ?=
 =?utf-8?B?dzZ4dUovOTJxSDRCSEloVkNaWEFpQU5uMzc1ZTBMUUlmZXFySnFtSFlnNTZN?=
 =?utf-8?B?Y3BiOVR2WThqclduV2VIYmo4MjJrWDhHY29NUWxJeVhzRFBsVk5LVmh5NjlK?=
 =?utf-8?B?UWlxVzZjSWhOY3Q2ajNyQXgwaFhUUk8rdjI4d0xKdXRFZ2FlNktFQzlrV1lE?=
 =?utf-8?B?T3V2MjFnTXlJZ2lyZ0RtL1NtWWUvRWVqZ0VZVlVENEF0bFlvREs2RTdObE1G?=
 =?utf-8?B?dDVOWW83RUdGdk9yb1J2TXRCb250eXFJUGhxb0NPY01RZlZmZnpibjc3S1ZH?=
 =?utf-8?B?aUszdkhvQzM3TGVUSmlyM0JNUE1QSkFiQjB2NVJQeXpJTkNSaU5vL3RsUlNw?=
 =?utf-8?B?N3ZieWRJYlg0Z0FzNWphbkJBWWl0N0tpcXdFQU9rS1NESWdPR3Z5NTR4VG81?=
 =?utf-8?B?bW1FUW1FejFtc213M2dMQXExblA3SW1WT2ljanFPbXNybXhVS0E1bkhQYmFk?=
 =?utf-8?B?dkdFSjhkc2YwemVSZXJrZHJONzJld21HbnV3QW9IYkZ3blM4azA4a3I1ZGNi?=
 =?utf-8?B?MWFiNDYwaWQ4eHFqNXRFYTlKWUxKUVgzcFlRd0k0TEpGR29qUGVDMWNPdmxH?=
 =?utf-8?Q?uXGFmQRrjJVTjMz2ncgjfqIrH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c327eee-24dc-4415-308c-08dbe58662e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 02:55:55.0351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BI8F7F6BAsQtwvrWgzlk8KmTZY9baXts/G8j7DvN6knlP+K7YRx2DKrI5V56pfTUIY8hiuuqTk7FOhedd6/ZRkLcIgc5K5zNpIMQVyjGDi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4858
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxNCwgMjAyMyA5OjUy
IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NiAwOC8yMV0gdmZpby9wY2k6IEludHJvZHVjZSBh
IHZmaW8gcGNpIGhvdCByZXNldCBpbnRlcmZhY2UNCj4NCj5PbiAxMS8xNC8yMyAxMTowOSwgWmhl
bnpob25nIER1YW4gd3JvdGU6DQo+PiBMZWdhY3kgdmZpbyBwY2kgYW5kIGlvbW11ZmQgY2RldiBo
YXZlIGRpZmZlcmVudCBwcm9jZXNzIHRvIGhvdCByZXNldA0KPj4gdmZpbyBkZXZpY2UsIGV4cGFu
ZCBjdXJyZW50IGNvZGUgdG8gYWJzdHJhY3Qgb3V0IHBjaV9ob3RfcmVzZXQgY2FsbGJhY2sNCj4+
IGZvciBsZWdhY3kgdmZpbywgdGhpcyBzYW1lIGludGVyZmFjZSB3aWxsIGFsc28gYmUgdXNlZCBi
eSBpb21tdWZkDQo+PiBjZGV2IHZmaW8gZGV2aWNlLg0KPj4NCj4+IFJlbmFtZSB2ZmlvX3BjaV9o
b3RfcmVzZXQgdG8gdmZpb19sZWdhY3lfcGNpX2hvdF9yZXNldCBhbmQgbW92ZSBpdA0KPj4gaW50
byBjb250YWluZXIuYy4NCj4+DQo+PiB2ZmlvX3BjaV9bcHJlL3Bvc3RdX3Jlc2V0IGFuZCB2Zmlv
X3BjaV9ob3N0X21hdGNoIGFyZSBleHBvcnRlZCBzbw0KPj4gdGhleSBjb3VsZCBiZSBjYWxsZWQg
aW4gbGVnYWN5IGFuZCBpb21tdWZkIHBjaV9ob3RfcmVzZXQgY2FsbGJhY2suDQo+DQo+dmZpb19w
Y2lfaG9zdF9tYXRjaCgpIGlzIG5ldmVyIHVzZWQgb3V0c2lkZSBvdCB0aGUgbGVnYWN5IHJlc2V0
IGNiLg0KPkRvIHlvdSBoYXZlIGZ1dHVyZSBwbGFucyA/DQoNCk5vIGZ1dHVyZSBwbGFucywgSSdt
IGp1c3QgZm9sbG93aW5nIGEgcnVsZSB0byBrZWVwIHBjaSBzcGVjaWZpYyBmdW5jdGlvbnMNCmlu
IHBjaS5jIHdoZW5ldmVyIHBvc3NpYmxlLiBNYXliZSBhbm90aGVyIHJ1bGUgaXMgdG8gbWFrZSBm
dW5jdGlvbnMNCnN0YXRpYyB3aGVuZXZlciBwb3NzaWJsZS4gSSdtIGZpbmUgd2l0aCBib3Ro8J+Y
ig0KDQpUaGFua3MNClpoZW56aG9uZw0K

