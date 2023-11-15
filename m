Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A027EBB3C
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 03:38:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r35mA-0003Cr-3R; Tue, 14 Nov 2023 21:37:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r35m7-0003Cg-Le
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 21:37:07 -0500
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r35m5-0008Om-0v
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 21:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700015825; x=1731551825;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wXFvy4fxFGRuFlJCxAwYQtSfXFmS2Faob6PoFZRz1jo=;
 b=TOy/CZn54dv5xfmGeaWys3ZjQbt8j/ZTsi6054rrtySuPnjTBhW/8It1
 ri2Ry0gPtALOXYXAonBZt1PzcZDJSklaivFpXpE5/9yi57cl9uWzB2Xe8
 sm84bCxi+G3BTfbNDlCuPh5gtR0SfczVeF6zKoFshSgV/h0MNy7wXGIRn
 tvcrtBdL7mjKd1BtUTxTkuzUuHn9Zys7zuvF2jGSY5gancape0IGdZ1sc
 YFvCGBQM1rfIHv9JUufmaLELbeJv1g583Z7gj39qImbCxIYZdOi29sRbJ
 Ne1oBzkHn6oEFnve5aerVJChymiIr1cQ9xjHoI4SRvd0HQGgqdrszDlkz Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="370988044"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; d="scan'208";a="370988044"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 18:37:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="5991804"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Nov 2023 18:37:02 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 18:37:01 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 18:36:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 18:36:55 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 18:36:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XADIIs0W4ad6ceGHF7/HTo40d/bQkL4ZeIUYOrYSEploMRddbXK1DullVgRUvI77SqsTSe2rCDWAfd6AIeFVR9O6QPHHC+eJEdW+INCo+JGYCjlPUHXibRoySqQI0eQ/nGz6od2CqSw++3o4a5x0vYxFgRzYmvemOmtFeJMC5r9NxOGYHNe+Am+80KOb5KEDw3WiwhuIoR6GkxeZ0Yb3PEXfpogLcw84SCEPcK/wMOcxxcVAhkMFSRXhA3UpgQegjSIXAUyUmqyuY3xS1r2urvZtJaSW6sBAvC9HZGBNFRUfnKmrH+bhzm4dUtBCzp/aLVkwyDM3bSIcfPjKvIvuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXFvy4fxFGRuFlJCxAwYQtSfXFmS2Faob6PoFZRz1jo=;
 b=lZiLUSO1mhOqmeX3RGn2Tm1Z9IFRIZmjPlkLXRGx1cgotboSmPC0kV3JC7TdqiHQgZcAmLr1SrQj1bPlxo4L15pAB+y0awYsIqhZJkcAjyXdRWfz1pgZQ7hHRu8tnK6Y2kaarX+sE72rKt4yCHQqBe3HrcsgYrs3kG6VyyPKMZmlvkZoPbdxpAwB2yyNIwOXi9Uja9dAKBY/2ksLRKAZgoUptKQED0xENcDXOpjDxbmTuIwfDK2YG2i0LH8dIOQDJ+XQaG71XxDKWBjSEv6+JIYS40zSpUMztFLQ0SPdGJDGTxnMqztQt7+qac1a9IoCJW6GKBDWF2i3b8HXM1JY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB8116.namprd11.prod.outlook.com (2603:10b6:8:12b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 02:36:53 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 02:36:53 +0000
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
Subject: RE: [PATCH v6 06/21] vfio/iommufd: Add support for iova_ranges and
 pgsizes
Thread-Topic: [PATCH v6 06/21] vfio/iommufd: Add support for iova_ranges and
 pgsizes
Thread-Index: AQHaFuT1HH/sJuTJZkSTZbIjs3SuN7B51BeAgADW4lA=
Date: Wed, 15 Nov 2023 02:36:52 +0000
Message-ID: <SJ0PR11MB67441FBF0E9654483ADB742C92B1A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-7-zhenzhong.duan@intel.com>
 <fa72e44b-e865-47c3-855f-b947a4e5c1e5@redhat.com>
In-Reply-To: <fa72e44b-e865-47c3-855f-b947a4e5c1e5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB8116:EE_
x-ms-office365-filtering-correlation-id: 3c4ea21c-cc18-425d-b31f-08dbe583ba21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2a3jI/v1U6K2R48iQVMs7ZYAxr/Q8wpfuzhvKlJ79YY8TiA09gTAMsRxmgjL040WvjOUfbxOrk6upAyN6G6xW7KTj87IKi8p24MEbnKchhG4h4PzPP2akZ881gPlgq6sShw8MXGRKJRzAhZDOGByam01Nsqyo6zYMGC4PwIIgtKVE9rpFVOwvQS1Aqru6fUtyYM1hoMX8hqYGhf9iLA+jln+sLZi5zsVEmchFsBdZmSd5Szh1/V3fs2gnjypwBk4o49dAktiCTdEEW57VNYyrcoKZjcvOIDKtVm6M/GaseWEEa6BBwHlPefNXhi/B1G09IXxPQbMKXI2nOWJsYqJQeSNYHx6YdD9K3MJX1d6J1AHLJVNSIP3CMzL2Z+x3lHfYjQeHfib1yz4AKKojat4V4hbYG0c9JtgZe93BILuomQJaiFLzmNJmSUOxfPAnqb6VwoWV+BDYVfw9G8Rul54nz/Xl9dKh71nY2M8jgl5VLwOZL2ENT95L7XzUdEgkND41lUAkJTuIMY7uDgZecGHQFGFJSvdw3ifbNW4Jf1+fkz8XhRiLVROhVgUIwOBPcZWPXGMfBNfAwjSt+5XjsJRJIMRQh20pFn5vzHH4NKqd4h/50q0ONOm+fi6pV+57lasUaVZoeLSJpYVCSH6b5Awj5FSfufZh2hqeid/rTJ15Jc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(55016003)(54906003)(66476007)(66946007)(76116006)(110136005)(66556008)(66446008)(38070700009)(38100700002)(33656002)(82960400001)(64756008)(122000001)(86362001)(9686003)(83380400001)(26005)(66574015)(7696005)(71200400001)(6506007)(2906002)(478600001)(107886003)(316002)(8676002)(8936002)(5660300002)(52536014)(41300700001)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0hCOVB5Sk5SUmpUbXluWEN2aDBHY1BVRUhJRVlETkVBc0JlUEdZYlV1WCt0?=
 =?utf-8?B?MnNRRVE0REdDaXdXaUZrUzBadGd1eGFlYXN4VTJJbU9JeDF5a3ZDQ3JzeDVP?=
 =?utf-8?B?d2VqcHN4U0RtUXZ3WWZGN29BdTJTVHdnNEtjMGs3OFUzaGFJRGhwaDdtV1Y2?=
 =?utf-8?B?SDE3K0FqR0syeTlnZlFXTDI5c05RMGxJZ3h2eTNpQ2J5SVV1Zk9semxwR3lE?=
 =?utf-8?B?aXZzVDZsQm50OXFqNDN4TmljWlMvcjZUVFliaFR3RkZnM0ZQUkFRREdjaTNS?=
 =?utf-8?B?d0daTzgxRzRoQXVodG1WdUp3RWk0UFNEd3hSdTBYUFdyUm8xbWtkelp0Q2JR?=
 =?utf-8?B?VWpZckloTmZ1eHRDUm5aZVJkcHJiWGFPS2pDWGhVNmRuMHVBRUU4QzdOb2FP?=
 =?utf-8?B?ZVU4ZGtQeVhuamZWYzRCQlFnOEs2OExOc1IyUHltLzczcEIwOFRHYzBBMk5h?=
 =?utf-8?B?dlpFZ21Rc210S0gzcGxRWkpBOUxRWHpMeURreUxnWFVSQnFkYjdwN3hHRjhz?=
 =?utf-8?B?RnJPU3pVemczR252Wk9PVkg3Yk8vRDBtS1BUVXVXdE9VdS92dnc0NHNOOUhp?=
 =?utf-8?B?eXY0WW5wcEpnS2tTeXczVE4zVHpuT0N2Vm5kTnpETFhTUHZzc3pIUU5UK0E0?=
 =?utf-8?B?VXI5N3RjL0I3SVF4bVhVZ2FPeGxmaGhsRGZRdDlLWENiMFYyMmFFNzZSa1BK?=
 =?utf-8?B?NXRjcDNqa2QxaUhNdzlpc2VIcTZPUU95dHlTVVVIcm5UdGczaTI5Q1VrVmx6?=
 =?utf-8?B?d3JOdXd2TW1Hdy9zMWpIYWdrNVdFNUthd05vMzJzSXhEVmVuaFdIekhZSzgz?=
 =?utf-8?B?YWJsdDhKaHJ4SE9SK2xXZEFxb29xZnVicVZaZXNxRFduWlhWVzZRa3k5clYr?=
 =?utf-8?B?eWRDNkwrWDNFRVVzMm94TVRBZlBMRnZva1lzUEFTRVNvSWhqYW5tb04ycENN?=
 =?utf-8?B?dGlBRFN5QitodXJXK3VkdVdyNUFObFNVNXNvRVRNeGtYdWxKT09BMDA5SVRr?=
 =?utf-8?B?ZkEvSzIvNGtmQ1VnZTA1NzFSYmVZcUlnc29aZFAyNzlwTUwzdlpYelQwSWp3?=
 =?utf-8?B?Z3Izc2R1TlI4RU02VkJGQkFKbGNTMHNxN2lHU0NLLzEzdVk0bUZnY3hPRTNx?=
 =?utf-8?B?cTNaNkxQMk5lMHl0eHBRM2NBRXpRUEszSEZQdWszRlVEZFA5bmZqc3RYd2da?=
 =?utf-8?B?YnN6VjN0aUFnemV0dW5TSzQrZ0llL2t2RS9KSkRjN0I0cDVwK0xjb3Y1YkRZ?=
 =?utf-8?B?UUE0bVJweC8zNjZmTTNXZ1NNMDlVYXB2ZjQ2aWdLTjBnYzBlVjk0dUhOS2wz?=
 =?utf-8?B?Y2txN2NZZzhMbnU0K2NOOUhXUEdjZXVQRlVHWEFzYTRQOExKMkwvMzE4NldW?=
 =?utf-8?B?Yjk5eTFxMVpHSjRFWFBMWjRNR2J4TUZGQVUwajhibFNrTEE5NTdWcEFTaWVH?=
 =?utf-8?B?NFZldStDYXNjdUVCZHFTSUY4VTgzOFFUenkzMnJOeUZJVVlnSWJXQmg0aHky?=
 =?utf-8?B?R0luZEJyQUtQK1liNUcvZmxTcGkydHBCV3E0NW5YNU9PMTZnQVlqKzdkcUVB?=
 =?utf-8?B?KzZ2ZWM3S0dwS3JOdm5DUGtPZXdZb2N1YURjeWNBQldub1dOa0NLaG91dmxy?=
 =?utf-8?B?dW1GWW4vVkE5WlRTaHg3dFEySjJrdmZtenFHRERQbG91bHVCRkQyaWgrQ3Ey?=
 =?utf-8?B?a3ZwYm1qN3QrS3AvYjlKTTl1R293YTc1a05ibEJoZXNBbXdjR0hubko3STE0?=
 =?utf-8?B?b0RIYVVmbXFtTVBKMWRzb1RSZTNmWVNXejk1WFRka0M3dklHWEJEczZyL1pt?=
 =?utf-8?B?M21FeGhMTmx3Q1FGN2pNYkwya3hhWFBadDk1NVRBVHNaNTZZZERkQjVPUWNs?=
 =?utf-8?B?NlNoRk9hdmpMUmtVTUp0ZFZTa3dpWHNSM2hXMkFYV3JQdi9iVWpHMkRPUkti?=
 =?utf-8?B?SWdnbWxaZXNsdy9YNTZSL2lTeENQMFJWTW1LbkpUZTB5cFU4SGJsbjk1T3B2?=
 =?utf-8?B?ZzV1NmtsQUZoTGd3M1dOcThZMXlISmQ5MGpSc24rWUFJQmpxOHEvbE5ZVjVt?=
 =?utf-8?B?ZStZRkFYd1RCOEVjTFJqNFI4cEN4MHRWMkJnQnJmTVZHV2VmakQ1M2VOVnM5?=
 =?utf-8?Q?4H7dfPVPrHiz9dxaffCfhBNgJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4ea21c-cc18-425d-b31f-08dbe583ba21
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 02:36:52.8871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erjpB2Nu8fwCSfAfhY/3mtJhbIOp+qLo+CAA1Dwrh+dpTm2KMg/DrMzc7T1kvDz+2g/asGzri9tGVUDOsLN4IFgI451MxC2wpvk+8oopChs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8116
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.151;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxNCwgMjAyMyA5OjQ2
IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NiAwNi8yMV0gdmZpby9pb21tdWZkOiBBZGQgc3Vw
cG9ydCBmb3IgaW92YV9yYW5nZXMgYW5kDQo+cGdzaXplcw0KPg0KPk9uIDExLzE0LzIzIDExOjA5
LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IFNvbWUgdklPTU1VIHN1Y2ggYXMgdmlydGlvLWlv
bW11IHVzZSBJT1ZBIHJhbmdlcyBmcm9tIGhvc3Qgc2lkZSB0bw0KPj4gc2V0dXAgcmVzZXJ2ZWQg
cmFuZ2VzIGZvciBwYXNzdGhyb3VnaCBkZXZpY2UsIHNvIHRoYXQgZ3Vlc3Qgd2lsbCBub3QNCj4+
IHVzZSBhbiBJT1ZBIHJhbmdlIGJleW9uZCBob3N0IHN1cHBvcnQuDQo+Pg0KPj4gVXNlIGFuIHVB
UEkgb2YgSU9NTVVGRCB0byBnZXQgSU9WQSByYW5nZXMgb2YgaG9zdCBzaWRlIGFuZCBwYXNzIHRv
DQo+PiB2SU9NTVUganVzdCBsaWtlIHRoZSBsZWdhY3kgYmFja2VuZCwgaWYgdGhpcyBmYWlscywg
ZmFsbGJhY2sgdG8NCj4+IDY0Yml0IElPVkEgcmFuZ2UuDQo+Pg0KPj4gQWxzbyB1c2Ugb3V0X2lv
dmFfYWxpZ25tZW50IHJldHVybmVkIGZyb20gdUFQSSBhcyBwZ3NpemVzIGluc3RlYWQgb2YNCj4+
IHFlbXVfcmVhbF9ob3N0X3BhZ2Vfc2l6ZSgpIGFzIGEgZmFsbGJhY2suDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0t
LQ0KPj4gdjY6IHByb3BhZ2F0ZSBpb21tdWZkX2NkZXZfZ2V0X2luZm9faW92YV9yYW5nZSBlcnIg
YW5kIHByaW50IGFzIHdhcm5pbmcNCj4+DQo+PiAgIGh3L3ZmaW8vaW9tbXVmZC5jIHwgNTUNCj4r
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4gICAxIGZp
bGUgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9ody92ZmlvL2lvbW11ZmQuYyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+PiBpbmRleCAw
NjI4MmQ4ODVjLi5lNWJmNTI4ZTg5IDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby9pb21tdWZkLmMN
Cj4+ICsrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+PiBAQCAtMjY3LDYgKzI2Nyw1MyBAQCBzdGF0
aWMgaW50DQo+aW9tbXVmZF9jZGV2X3JhbV9ibG9ja19kaXNjYXJkX2Rpc2FibGUoYm9vbCBzdGF0
ZSkNCj4+ICAgICAgIHJldHVybiByYW1fYmxvY2tfdW5jb29yZGluYXRlZF9kaXNjYXJkX2Rpc2Fi
bGUoc3RhdGUpOw0KPj4gICB9DQo+Pg0KPj4gK3N0YXRpYyBpbnQgaW9tbXVmZF9jZGV2X2dldF9p
bmZvX2lvdmFfcmFuZ2UoVkZJT0lPTU1VRkRDb250YWluZXINCj4qY29udGFpbmVyLA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgaW9hc19p
ZCwgRXJyb3IgKiplcnJwKQ0KPj4gK3sNCj4+ICsgICAgVkZJT0NvbnRhaW5lckJhc2UgKmJjb250
YWluZXIgPSAmY29udGFpbmVyLT5iY29udGFpbmVyOw0KPj4gKyAgICBzdHJ1Y3QgaW9tbXVfaW9h
c19pb3ZhX3JhbmdlcyAqaW5mbzsNCj4+ICsgICAgc3RydWN0IGlvbW11X2lvdmFfcmFuZ2UgKmlv
dmFfcmFuZ2VzOw0KPj4gKyAgICBpbnQgcmV0LCBzeiwgZmQgPSBjb250YWluZXItPmJlLT5mZDsN
Cj4+ICsNCj4+ICsgICAgaW5mbyA9IGdfbWFsbG9jMChzaXplb2YoKmluZm8pKTsNCj4+ICsgICAg
aW5mby0+c2l6ZSA9IHNpemVvZigqaW5mbyk7DQo+PiArICAgIGluZm8tPmlvYXNfaWQgPSBpb2Fz
X2lkOw0KPj4gKw0KPj4gKyAgICByZXQgPSBpb2N0bChmZCwgSU9NTVVfSU9BU19JT1ZBX1JBTkdF
UywgaW5mbyk7DQo+PiArICAgIGlmIChyZXQgJiYgZXJybm8gIT0gRU1TR1NJWkUpIHsNCj4+ICsg
ICAgICAgIGdvdG8gZXJyb3I7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgc3ogPSBpbmZvLT5u
dW1faW92YXMgKiBzaXplb2Yoc3RydWN0IGlvbW11X2lvdmFfcmFuZ2UpOw0KPj4gKyAgICBpbmZv
ID0gZ19yZWFsbG9jKGluZm8sIHNpemVvZigqaW5mbykgKyBzeik7DQo+PiArICAgIGluZm8tPmFs
bG93ZWRfaW92YXMgPSAodWludHB0cl90KShpbmZvICsgMSk7DQo+PiArDQo+PiArICAgIHJldCA9
IGlvY3RsKGZkLCBJT01NVV9JT0FTX0lPVkFfUkFOR0VTLCBpbmZvKTsNCj4+ICsgICAgaWYgKHJl
dCkgew0KPj4gKyAgICAgICAgZ290byBlcnJvcjsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBp
b3ZhX3JhbmdlcyA9IChzdHJ1Y3QgaW9tbXVfaW92YV9yYW5nZSAqKSh1aW50cHRyX3QpaW5mby0+
YWxsb3dlZF9pb3ZhczsNCj4+ICsNCj4+ICsgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBpbmZvLT5u
dW1faW92YXM7IGkrKykgew0KPj4gKyAgICAgICAgUmFuZ2UgKnJhbmdlID0gZ19uZXcoUmFuZ2Us
IDEpOw0KPj4gKw0KPj4gKyAgICAgICAgcmFuZ2Vfc2V0X2JvdW5kcyhyYW5nZSwgaW92YV9yYW5n
ZXNbaV0uc3RhcnQsIGlvdmFfcmFuZ2VzW2ldLmxhc3QpOw0KPj4gKyAgICAgICAgYmNvbnRhaW5l
ci0+aW92YV9yYW5nZXMgPQ0KPj4gKyAgICAgICAgICAgIHJhbmdlX2xpc3RfaW5zZXJ0KGJjb250
YWluZXItPmlvdmFfcmFuZ2VzLCByYW5nZSk7DQo+PiArICAgIH0NCj4+ICsgICAgYmNvbnRhaW5l
ci0+cGdzaXplcyA9IGluZm8tPm91dF9pb3ZhX2FsaWdubWVudDsNCj4+ICsNCj4+ICsgICAgZ19m
cmVlKGluZm8pOw0KPj4gKyAgICByZXR1cm4gMDsNCj4+ICsNCj4+ICtlcnJvcjoNCj4+ICsgICAg
cmV0ID0gLWVycm5vOw0KPj4gKyAgICBnX2ZyZWUoaW5mbyk7DQo+PiArICAgIGVycm9yX3NldGdf
ZXJybm8oZXJycCwgZXJybm8sICJDYW5ub3QgZ2V0IElPVkEgcmFuZ2VzIik7DQo+PiArICAgIHJl
dHVybiByZXQ7DQo+PiArfQ0KPj4gKw0KPj4gICBzdGF0aWMgaW50IGlvbW11ZmRfY2Rldl9hdHRh
Y2goY29uc3QgY2hhciAqbmFtZSwgVkZJT0RldmljZSAqdmJhc2VkZXYsDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBBZGRyZXNzU3BhY2UgKmFzLCBFcnJvciAqKmVycnApDQo+
PiAgIHsNCj4+IEBAIC0zNDEsNyArMzg4LDEzIEBAIHN0YXRpYyBpbnQgaW9tbXVmZF9jZGV2X2F0
dGFjaChjb25zdCBjaGFyICpuYW1lLA0KPlZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4gICAgICAg
ICAgIGdvdG8gZXJyX2Rpc2NhcmRfZGlzYWJsZTsNCj4+ICAgICAgIH0NCj4+DQo+PiAtICAgIGJj
b250YWluZXItPnBnc2l6ZXMgPSBxZW11X3JlYWxfaG9zdF9wYWdlX3NpemUoKTsNCj4+ICsgICAg
cmV0ID0gaW9tbXVmZF9jZGV2X2dldF9pbmZvX2lvdmFfcmFuZ2UoY29udGFpbmVyLCBpb2FzX2lk
LCAmZXJyKTsNCj4+ICsgICAgaWYgKHJldCkgew0KPj4gKyAgICAgICAgd2Fybl9yZXBvcnRfZXJy
KGVycik7DQo+PiArICAgICAgICBlcnIgPSBOVUxMOw0KPj4gKyAgICAgICAgZXJyb3JfcHJpbnRm
KCJGYWxsYmFjayB0byBkZWZhdWx0IDY0Yml0IElPVkEgcmFuZ2UgYW5kIDRLIHBhZ2Ugc2l6ZVxu
Iik7DQo+DQo+VGhpcyB3b3VsZCBiZSBiZXR0ZXIgOg0KPg0KPiAgICAgICAgIGVycm9yX2FwcGVu
ZF9oaW50KCZlcnIsDQo+ICAgICAgICAgICAgICAgICAgICAiRmFsbGJhY2sgdG8gZGVmYXVsdCA2
NGJpdCBJT1ZBIHJhbmdlIGFuZCA0SyBwYWdlIHNpemVcbiIpOw0KPiAgICAgICAgIHdhcm5fcmVw
b3J0X2VycihlcnIpOw0KPg0KPkkgd2lsbCB0YWtlIGNhcmUgb2YgaXQgaWYgeW91IGFncmVlLiBX
aXRoIHRoYXQsDQoNClN1cmUsIHRoYW5rcw0KDQpCUnMNClpoZW56aG9uZw0KDQo+DQo+UmV2aWV3
ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4NCj5UaGFua3MsDQo+
DQo+Qy4NCj4NCj4NCj4+ICsgICAgICAgIGJjb250YWluZXItPnBnc2l6ZXMgPSBxZW11X3JlYWxf
aG9zdF9wYWdlX3NpemUoKTsNCj4+ICsgICAgfQ0KPj4NCj4+ICAgICAgIGJjb250YWluZXItPmxp
c3RlbmVyID0gdmZpb19tZW1vcnlfbGlzdGVuZXI7DQo+PiAgICAgICBtZW1vcnlfbGlzdGVuZXJf
cmVnaXN0ZXIoJmJjb250YWluZXItPmxpc3RlbmVyLCBiY29udGFpbmVyLT5zcGFjZS0+YXMpOw0K
DQo=

