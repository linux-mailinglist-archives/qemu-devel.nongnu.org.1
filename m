Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0CC80C14D
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 07:26:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCZk2-0003FL-DI; Mon, 11 Dec 2023 01:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCZjx-0003F2-EA
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:26:05 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCZju-0003IE-8D
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702275962; x=1733811962;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=c9YfYAyByoXiRFVzBcQLARKdBPCCzJnuypX371oPgfc=;
 b=FtZWLmZ7vJTEvw7mPfZieRu9eCjQvWf7rmtEMhnIEjbQK1aYNzHppj4z
 FxONr0TLdVJaCKsQVWtPQidmpa5z9q3rUr3waA2wHIQvLEr0WBRrKJGNE
 xwyvLwDDOk3EcfHn5udv1p1xosdDBIHg5PkO2ksZuq1wk4bJLJlRCZI8L
 nmXjvLGMRaXoaj6/OXRjOZSnO2UcIF4/aIoiIxwS2zO0ERpFdeBvnCUjs
 LwP/6ZOkSxHNWxDRe9lQfoS/uC++/vwC/OZGVBbJ3MberpaDpDs3/WuxC
 gtir3QTYE96NAVM7Jm0I4aiJ50qt6QswlRLJeo0S2cPTa/08ZqmCwNmqR g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="374104749"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; d="scan'208";a="374104749"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2023 22:25:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="843375420"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; d="scan'208";a="843375420"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Dec 2023 22:25:54 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 22:25:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 22:25:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 22:25:53 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 22:25:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7LpWV0pX+gPA84tmoDgdl6Xx+2cMLp9GFF9cA3K8/3dqVUvqROsV1rjGaj0tDJuacL2mx42LO2N58L+7wmoRtHs8ufBSpMezWaUZ7JK04Tdkbo4pXc3tC+SKB0XuoF3uqBGjmaU6miAAcS0LQWlWbmMH3BOMaoPaQEfOOoL5IEs0S9sZPMBnk/qy2iGQR6PxSmAOU1MNAp0I8U17M5py5IKCgekyMK2k7WignNApqdGciMZYS5IxgqgKrAmjqjAJCipj6bsybI+fE1Jk823S0EV9+7CmcKMJoRa8Q8xeo8pqhK5ZeqJYK4cLcb8GtoJuqOsLxA3DJqCYNBFhYjUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9YfYAyByoXiRFVzBcQLARKdBPCCzJnuypX371oPgfc=;
 b=Ndjl507iKiZTdA/OvniRgFRahpGQd/nVQQfyF6n0iu1md6YdMJlYkWbSZSzvLFFwyd0tYSDcvOms4aEBhVulq5ogZQipegvVspEDWeafM0mk9llunlxhWQ6dS8a0nQrcsW3u/cTW3Fk8+M4m5fhTDVFEVoaTVkSj74H872Po51aNpRoRTwnZaMkTgT8tKnB70s7duiq1S0D3lP8buBCNaCZwIfpnD6Bovk7jiV6NuD4LH3SNNJocc+97M5jKw+dTaXVLyrdIIwZSf1+cpMt+Hgr5139EySHzFnUC3T+PEdYNf0vlfiihg9TLPD05AUS1G2ye+XA4qKYdundwjceRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB8477.namprd11.prod.outlook.com (2603:10b6:510:30d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 06:25:52 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 06:25:52 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>
Subject: RE: [PATCH for-9.0 07/10] vfio/spapr: Introduce a sPAPR VFIOIOMMU QOM
 interface
Thread-Topic: [PATCH for-9.0 07/10] vfio/spapr: Introduce a sPAPR VFIOIOMMU
 QOM interface
Thread-Index: AQHaKbMqoNbb4cVtIEC9b8NH+1uoPbCjoAzA
Date: Mon, 11 Dec 2023 06:25:52 +0000
Message-ID: <SJ0PR11MB6744660C2087683E83A01E58928FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231208084600.858964-1-clg@redhat.com>
 <20231208084600.858964-8-clg@redhat.com>
In-Reply-To: <20231208084600.858964-8-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB8477:EE_
x-ms-office365-filtering-correlation-id: d28af535-6823-40cd-198c-08dbfa12060f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GMYPmgZba+LSPKaOCHaLc/9miVLf8VTamFt6+ShzpBmE98dvrn/shffR6c0DRpk347N73JFPfEX7YYV4/43+DOuXtmZsMi6hA+RVAZOeQd4tmiDfYDcSJtWwSDd3sHAO9R9vfqxuC9611cKI6SikLKEJt/uhSabfhWcwiRTQurbzfN7g7XZUaUa5Kgb3g46X9WRZn2CCj5LC4lR6adZX9Wwk9YP2GAbb/LOCd/y/c5Is0GZFjj5581arStWBWvvUItqQwWbXhxxoSvlJGALB6ssomQ7IQQ3EtcxB4RKsNYjseSq2F0UTbX0m8b3ZvPPDmPvXmWq9pB78n935EdEUcAgPi0pDeuj8bDXMj1p5FqRd/wy4dUKUI0eRgxzvAwIBIzNDMxb4OBolvioZJoaC+UX20AAq8D40dJQc3fP++5qBiDQwjYLRvPCevWF6+Z68g1EJSsQAlrGvwNd/2w7VBAbAXRl8/enkEY/0Nsb+Ex1G23HQ+wO7r/FeYlFNz+I2uSCH5syIL3KrhQitqKx740h/W5ju3ZIDqJjjjkZfnnQMKOh/OwvGeRkYno0OpctTpmE7koa4n2OoIZql9WmCow+EHQHfWIk/hxqSvZrGi7oVbL3kyzmL80RXs62HawAT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82960400001)(83380400001)(122000001)(38100700002)(86362001)(41300700001)(5660300002)(8676002)(4326008)(8936002)(2906002)(66556008)(66946007)(76116006)(110136005)(52536014)(66446008)(316002)(54906003)(64756008)(9686003)(66476007)(26005)(7696005)(478600001)(6506007)(71200400001)(38070700009)(33656002)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDJiS2YydkY2UXQyREQwZTJKNU5YMTRhWUJWSm9IWWhNdGd2bEpHaVJPQVpu?=
 =?utf-8?B?SW5XYlFRVDF6eVJ0amZmR2s0Z09CMUZIN3lNdTQzNFZQZDM2RFVyOXVSNHh5?=
 =?utf-8?B?K2JwaW5OK3JNMHBuR3FWZktJZEpTYU5ESWZibGplRUhnKzRUUGkxNUFwTm9z?=
 =?utf-8?B?NnNJYlRudTJrbHNjcUoxZ0gxVENHRkpCalFCZGNJREV2SUs4aEYydHNKdCts?=
 =?utf-8?B?WHMrbWNpRHVsRWVZVHQ3K055bXdzTnNrNmdmYVNZSjhFczRlVGtBY1RyRDhS?=
 =?utf-8?B?N09TSndVaHVRTStQRE1XZTVHOGlkbmlZb0hIMkx3NGQxM1ZTV053cFhBcmZL?=
 =?utf-8?B?cEtwQWx5RnlkNWNNZ3JoUndyZ2NjUzNOMVl3QXZ0eWdKeEpmUnpLaGlUem9k?=
 =?utf-8?B?c3lHenR3bEVGaEpoVjZ0OHVTdjkvVlRkYm5uczhEdFlnWDRoSHRJeWNBa0tn?=
 =?utf-8?B?dWswVHQrcFN6bXpycnh0RUNaTkpzdDRudTBRSURha05DMGRUcm5qT2Y5K0xk?=
 =?utf-8?B?L1BydEhFMXh2bnFsdXE0NXNnVmFIQVFtZXE3NTM1NTZnQXN4NXdZcnJhK2p0?=
 =?utf-8?B?NHYvaXJsWXJXeWpDbTh2UDgybmdHb1dZWmxQbHRYY2JTK1Baa29kbk95TlpM?=
 =?utf-8?B?NkRpaTBMZ2xzVFk1cHRKWThqa0tZQk1jMll6ZmRJSkdObTluMW51amdGWVdo?=
 =?utf-8?B?WTFISDdlWkV2ZC9IbjZYbXZGNUVvYzFSdzVobDRkOXk0ZS9VK3JINGVSdmtx?=
 =?utf-8?B?NXhLbXVFa1V1djl4ZkM0ZlVPcUNMRVhGU2J4bWRpTXJ4eCtyQzl0Z2NiN1Rh?=
 =?utf-8?B?d0tsZ1V4RVFzVkZqOUxyaEdJcFJTN21yZG05c2wyZHlFUDZNdEQrZ3VlQkw0?=
 =?utf-8?B?WVJDS20rUExQZ0w2QkJIU0ZvVVRVckpZa3lYMHlkaDV3bFFoTGxzcFRCTWtv?=
 =?utf-8?B?eXgyQjVvZ1huREkvdjdMV0gxUlpOSFMzNC9FZDlLRVFtaHY0Y2F6c1B3YVZN?=
 =?utf-8?B?ZUtuMjZTTDNmeHJ2WkszQ041VkRCdmE4VWxqWWp5M2RPOW0vMEhJcWtLKzRu?=
 =?utf-8?B?SzVEQTNhaG5Db0o2OHRleXdoWWtJWHlaTUxMQW5CbnBVd3Y3NHYxYXBxa3Uz?=
 =?utf-8?B?VXdGbDRGWGJ6OFZxejlKcHFyakVmZHYxRnRBS0hxMDVKT04wZkwwZlhTeU5O?=
 =?utf-8?B?L0NMSC91WnJicC91MXJWMU95b0Y0SGZGOTVYOUJ1Q2E4WHVJV0ZWOHh1N2ho?=
 =?utf-8?B?RjdRVExhMWNtNTVnckh4V3JRVjdQOUN0R1dkaWtCWTdOL1N5dTQzNXNMczdT?=
 =?utf-8?B?aEd2SHVJWHJxV0hXU2VIUnJUNTQyenN2RHBzTWQ0NTFDYy9DSWRNc081RnBs?=
 =?utf-8?B?S1BpVlJTSEZpVnB4d2ZwakhvbU1VZ2NFdFYveG5yeDhZTnBqdTEwT2pIYzg2?=
 =?utf-8?B?MW9ia2tyRzlsQmpFY3FoZ2RBNk11b3pBWDZoQ1pISWJQNVlHWkpRbU5xL01E?=
 =?utf-8?B?WStTVjZmUUsvcS9mMldFQWhZM21GSWVldFJ1cEdZMkJ4T29kTTRaNDdQdzRp?=
 =?utf-8?B?alZNVCtpZVZlMlBnOVNpVWhDSU9SbG41QjNoNllKazR5R0VqdE1UbDY1b2x5?=
 =?utf-8?B?dG1NeTU3NWpOd1BPdTJTTTBqR0FWNVBqcFMrYjEvM0RROFhQL1FkdVZCcndj?=
 =?utf-8?B?Z0JlaVp6eE5mL3RaRzdwTFg5ZVR5WWtQVDdWZDR6SEdQWHlGTmFmT1VwTW1S?=
 =?utf-8?B?cTQydVNMM2R6N2VENkNmL0lhZEhUclVaMmQwbGpGU0VFVytKalhxY2tUcW12?=
 =?utf-8?B?TFZwaEdlYm1LMytlZ29ybHJnVVlrS01WSmNsWlhmQ1VnMlR4eEVTU3F3S3ZP?=
 =?utf-8?B?YkJpTjdxZldySnFmNmphQ0lScC9NNkRWYmN5UE5UN3NxSDM4L29yT0JtMmxD?=
 =?utf-8?B?VXlRczNWQ293Sk9UbWZzaytVdmhDRDVBcDFVWE1QZFh0cnVMZ1I1aWEya292?=
 =?utf-8?B?UHltcldLY29GK3NubTZHY1hUOEQwVHNiaWhQUDZnM1dpSU1vekM1VmZHcnJ1?=
 =?utf-8?B?dFI2KzZiWTIwSEI2c3NjNXBSczVzSHM1QVl4WFIyZ0xrMVlLQXF0cGV3WFF3?=
 =?utf-8?Q?3eLdeFFmdZowwPfaWYd3kJfx3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28af535-6823-40cd-198c-08dbfa12060f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 06:25:52.0967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4uKNWNjkzoH/xB27WOpHKhRjwqRM5FhKlC6S4GLkSu2UgZgmHCwrtFVa423GVvrXIKorA0werJem/9rJZEry1h/0+DeH4h8m0Ik6lYqyljI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8477
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIERlY2VtYmVyIDgsIDIwMjMgNDo0NiBQ
TQ0KPlN1YmplY3Q6IFtQQVRDSCBmb3ItOS4wIDA3LzEwXSB2ZmlvL3NwYXByOiBJbnRyb2R1Y2Ug
YSBzUEFQUiBWRklPSU9NTVUNCj5RT00gaW50ZXJmYWNlDQo+DQo+TW92ZSB2ZmlvX3NwYXByX2Nv
bnRhaW5lcl9zZXR1cCgpIHRvIGEgVkZJT0lPTU1VQ2xhc3M6OnNldHVwIGhhbmRsZXINCj5hbmQg
Y29udmVydCB0aGUgc1BBUFIgVkZJT0lPTU1VT3BzIHN0cnVjdCB0byBhIFFPTSBpbnRlcmZhY2Uu
IFRoZQ0KPnNQQVBSIFFPTSBpbnRlcmZhY2UgaW5oZXJpdHMgZnJvbSB0aGUgbGVnYWN5IFFPTSBp
bnRlcmZhY2UgYmVjYXVzZQ0KPmJlY2F1c2UgYm90aCBoYXZlIHRoZSBzYW1lIGJhc2ljIG5lZWRz
LiBUaGUgc1BBUFIgaW50ZXJmYWNlIGlzIHRoZW4NCj5leHRlbmRlZCB3aXRoIHRoZSBoYW5kbGVy
cyBzcGVjaWZpYyB0byB0aGUgc1BBUFIgSU9NTVUuDQo+DQo+VGhpcyBhbGxvd3MgcmV1c2UgYW5k
IHByb3ZpZGVzIGJldHRlciBhYnN0cmFjdGlvbiBvZiB0aGUgYmFja2VuZHMuIEl0DQo+d2lsbCBi
ZSB1c2VmdWwgdG8gYXZvaWQgY29tcGlsaW5nIHRoZSBzUEFQUiBJT01NVSBiYWNrZW5kIG9uIHRh
cmdldHMNCj5ub3Qgc3VwcG9ydGluZyBpdC4NCj4NCj5TaWduZWQtb2ZmLWJ5OiBDw6lkcmljIExl
IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+LS0tDQo+IGluY2x1ZGUvaHcvdmZpby92ZmlvLWNv
bnRhaW5lci1iYXNlLmggfCAgMSArDQo+IGh3L3ZmaW8vY29udGFpbmVyLmMgICAgICAgICAgICAg
ICAgICAgfCAxOCArKysrLS0tLS0tLS0NCj4gaHcvdmZpby9zcGFwci5jICAgICAgICAgICAgICAg
ICAgICAgICB8IDQwICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiAzIGZpbGVzIGNoYW5n
ZWQsIDMyIGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPg0KPmRpZmYgLS1naXQgYS9p
bmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oIGIvaW5jbHVkZS9ody92ZmlvL3Zm
aW8tDQo+Y29udGFpbmVyLWJhc2UuaA0KPmluZGV4DQo+ODcwZTdkYzQ4ZTU0MmRkYmZjNTJlMTJi
MGFiNWZhYjQ3NzFhMWViZC4uNDAxMjM2MGMwN2I3YzBhMjNmMTcwZg0KPjk0YTE5NDU1Yzc5ZDM1
MDRiMSAxMDA2NDQNCj4tLS0gYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5o
DQo+KysrIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaA0KPkBAIC05Niw2
ICs5Niw3IEBAIHR5cGVkZWYgc3RydWN0IFZGSU9JT01NVSBWRklPSU9NTVU7DQo+DQo+ICNkZWZp
bmUgVFlQRV9WRklPX0lPTU1VICJ2ZmlvLWlvbW11Ig0KPiAjZGVmaW5lIFRZUEVfVkZJT19JT01N
VV9MRUdBQ1kgVFlQRV9WRklPX0lPTU1VICItbGVnYWN5Ig0KPisjZGVmaW5lIFRZUEVfVkZJT19J
T01NVV9TUEFQUiBUWVBFX1ZGSU9fSU9NTVUgIi1zcGFwciINCj4NCj4gI2RlZmluZSBWRklPX0lP
TU1VKG9iaikgSU5URVJGQUNFX0NIRUNLKFZGSU9JT01NVSwgKG9iaiksDQo+VFlQRV9WRklPX0lP
TU1VKQ0KPiBERUNMQVJFX0NMQVNTX0NIRUNLRVJTKFZGSU9JT01NVUNsYXNzLCBWRklPX0lPTU1V
LA0KPlRZUEVfVkZJT19JT01NVSkNCj5kaWZmIC0tZ2l0IGEvaHcvdmZpby9jb250YWluZXIuYyBi
L2h3L3ZmaW8vY29udGFpbmVyLmMNCj5pbmRleA0KPjVmNWFkODQ3OWYwODNkYjBiZTUyMDdmMTc5
ZjMwNTZhZTY3YzQ5YzMuLmNlNWE3MzFiYTc0NjAwZmJiMzMxYTgNCj4wZjUxNDhhODhlMmU0M2Iw
NjggMTAwNjQ0DQo+LS0tIGEvaHcvdmZpby9jb250YWluZXIuYw0KPisrKyBiL2h3L3ZmaW8vY29u
dGFpbmVyLmMNCj5AQCAtMzgxLDYgKzM4MSwxMCBAQCBzdGF0aWMgY29uc3QgVkZJT0lPTU1VQ2xh
c3MNCj4qdmZpb19nZXRfaW9tbXVfY2xhc3MoaW50IGlvbW11X3R5cGUsIEVycm9yICoqZXJycCkN
Cj4gICAgIGNhc2UgVkZJT19UWVBFMV9JT01NVToNCj4gICAgICAgICBrbGFzcyA9IG9iamVjdF9j
bGFzc19ieV9uYW1lKFRZUEVfVkZJT19JT01NVV9MRUdBQ1kpOw0KPiAgICAgICAgIGJyZWFrOw0K
PisgICAgY2FzZSBWRklPX1NQQVBSX1RDRV92Ml9JT01NVToNCj4rICAgIGNhc2UgVkZJT19TUEFQ
Ul9UQ0VfSU9NTVU6DQo+KyAgICAgICAga2xhc3MgPSBvYmplY3RfY2xhc3NfYnlfbmFtZShUWVBF
X1ZGSU9fSU9NTVVfU1BBUFIpOw0KPisgICAgICAgIGJyZWFrOw0KPiAgICAgZGVmYXVsdDoNCj4g
ICAgICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOw0KPiAgICAgfTsNCj5AQCAtNjIzLDE5ICs2
MjcsOSBAQCBzdGF0aWMgaW50IHZmaW9fY29ubmVjdF9jb250YWluZXIoVkZJT0dyb3VwDQo+Kmdy
b3VwLCBBZGRyZXNzU3BhY2UgKmFzLA0KPiAgICAgICAgIGdvdG8gZnJlZV9jb250YWluZXJfZXhp
dDsNCj4gICAgIH0NCj4NCj4tICAgIHN3aXRjaCAoY29udGFpbmVyLT5pb21tdV90eXBlKSB7DQo+
LSAgICBjYXNlIFZGSU9fVFlQRTF2Ml9JT01NVToNCj4tICAgIGNhc2UgVkZJT19UWVBFMV9JT01N
VToNCj4tICAgICAgICByZXQgPSB2ZmlvX2xlZ2FjeV9zZXR1cChiY29udGFpbmVyLCBlcnJwKTsN
Cj4tICAgICAgICBicmVhazsNCj4tICAgIGNhc2UgVkZJT19TUEFQUl9UQ0VfdjJfSU9NTVU6DQo+
LSAgICBjYXNlIFZGSU9fU1BBUFJfVENFX0lPTU1VOg0KPi0gICAgICAgIHJldCA9IHZmaW9fc3Bh
cHJfY29udGFpbmVyX2luaXQoY29udGFpbmVyLCBlcnJwKTsNCj4tICAgICAgICBicmVhazsNCj4t
ICAgIGRlZmF1bHQ6DQo+LSAgICAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsNCj4tICAgIH0N
Cj4rICAgIGFzc2VydChiY29udGFpbmVyLT5vcHMtPnNldHVwKTsNCj4NCj4rICAgIHJldCA9IGJj
b250YWluZXItPm9wcy0+c2V0dXAoYmNvbnRhaW5lciwgZXJycCk7DQo+ICAgICBpZiAocmV0KSB7
DQo+ICAgICAgICAgZ290byBlbmFibGVfZGlzY2FyZHNfZXhpdDsNCj4gICAgIH0NCj5kaWZmIC0t
Z2l0IGEvaHcvdmZpby9zcGFwci5jIGIvaHcvdmZpby9zcGFwci5jDQo+aW5kZXgNCj40NDYxN2Rm
YzZiNWYxYTJhM2ExYzM3NDM2Yjc2MDQyYWViZGE4YjYzLi40NmFhMTRiZDJhZTZkNTgwYzE2YmIN
Cj5hNzU4MzhjYjZhY2E3ZDQwNDdmIDEwMDY0NA0KPi0tLSBhL2h3L3ZmaW8vc3BhcHIuYw0KPisr
KyBiL2h3L3ZmaW8vc3BhcHIuYw0KPkBAIC00NTgsMjAgKzQ1OCwxMSBAQCBzdGF0aWMgdm9pZA0K
PnZmaW9fc3BhcHJfY29udGFpbmVyX3JlbGVhc2UoVkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWlu
ZXIpDQo+ICAgICB9DQo+IH0NCj4NCj4tc3RhdGljIFZGSU9JT01NVU9wcyB2ZmlvX2lvbW11X3Nw
YXByX29wczsNCj4tDQo+LXN0YXRpYyB2b2lkIHNldHVwX3NwYXByX29wcyhWRklPQ29udGFpbmVy
QmFzZSAqYmNvbnRhaW5lcikNCj4tew0KPi0gICAgdmZpb19pb21tdV9zcGFwcl9vcHMgPSAqYmNv
bnRhaW5lci0+b3BzOw0KPi0gICAgdmZpb19pb21tdV9zcGFwcl9vcHMuYWRkX3dpbmRvdyA9DQo+
dmZpb19zcGFwcl9jb250YWluZXJfYWRkX3NlY3Rpb25fd2luZG93Ow0KPi0gICAgdmZpb19pb21t
dV9zcGFwcl9vcHMuZGVsX3dpbmRvdyA9DQo+dmZpb19zcGFwcl9jb250YWluZXJfZGVsX3NlY3Rp
b25fd2luZG93Ow0KPi0gICAgdmZpb19pb21tdV9zcGFwcl9vcHMucmVsZWFzZSA9IHZmaW9fc3Bh
cHJfY29udGFpbmVyX3JlbGVhc2U7DQo+LSAgICBiY29udGFpbmVyLT5vcHMgPSAmdmZpb19pb21t
dV9zcGFwcl9vcHM7DQo+LX0NCj4tDQo+LWludCB2ZmlvX3NwYXByX2NvbnRhaW5lcl9pbml0KFZG
SU9Db250YWluZXIgKmNvbnRhaW5lciwgRXJyb3IgKiplcnJwKQ0KPitzdGF0aWMgaW50IHZmaW9f
c3BhcHJfY29udGFpbmVyX3NldHVwKFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVyLA0KPisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4gew0K
Pi0gICAgVkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWluZXIgPSAmY29udGFpbmVyLT5iY29udGFp
bmVyOw0KPisgICAgVkZJT0NvbnRhaW5lciAqY29udGFpbmVyID0gY29udGFpbmVyX29mKGJjb250
YWluZXIsIFZGSU9Db250YWluZXIsDQo+KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgYmNvbnRhaW5lcik7DQo+ICAgICBWRklPU3BhcHJDb250YWluZXIgKnNjb250
YWluZXIgPSBjb250YWluZXJfb2YoY29udGFpbmVyLA0KPlZGSU9TcGFwckNvbnRhaW5lciwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250YWlu
ZXIpOw0KPiAgICAgc3RydWN0IHZmaW9faW9tbXVfc3BhcHJfdGNlX2luZm8gaW5mbzsNCj5AQCAt
NTM2LDggKzUyNyw2IEBAIGludCB2ZmlvX3NwYXByX2NvbnRhaW5lcl9pbml0KFZGSU9Db250YWlu
ZXINCj4qY29udGFpbmVyLCBFcnJvciAqKmVycnApDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgMHgxMDAwKTsNCj4gICAgIH0NCj4NCj4tICAgIHNldHVwX3NwYXByX29wcyhiY29udGFpbmVy
KTsNCj4tDQo+ICAgICByZXR1cm4gMDsNCj4NCj4gbGlzdGVuZXJfdW5yZWdpc3Rlcl9leGl0Og0K
PkBAIC01NDYsMyArNTM1LDI0IEBAIGxpc3RlbmVyX3VucmVnaXN0ZXJfZXhpdDoNCj4gICAgIH0N
Cj4gICAgIHJldHVybiByZXQ7DQo+IH0NCj4rDQo+K3N0YXRpYyB2b2lkIHZmaW9faW9tbXVfc3Bh
cHJfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIHZvaWQgKmRhdGEpDQo+K3sNCj4rICAg
IFZGSU9JT01NVUNsYXNzICp2aW9jID0gVkZJT19JT01NVV9DTEFTUyhrbGFzcyk7DQo+Kw0KPisg
ICAgdmlvYy0+YWRkX3dpbmRvdyA9IHZmaW9fc3BhcHJfY29udGFpbmVyX2FkZF9zZWN0aW9uX3dp
bmRvdzsNCj4rICAgIHZpb2MtPmRlbF93aW5kb3cgPSB2ZmlvX3NwYXByX2NvbnRhaW5lcl9kZWxf
c2VjdGlvbl93aW5kb3c7DQo+KyAgICB2aW9jLT5yZWxlYXNlID0gdmZpb19zcGFwcl9jb250YWlu
ZXJfcmVsZWFzZTsNCj4rICAgIHZpb2MtPnNldHVwID0gdmZpb19zcGFwcl9jb250YWluZXJfc2V0
dXA7DQo+K307DQo+Kw0KPitzdGF0aWMgY29uc3QgVHlwZUluZm8gdHlwZXNbXSA9IHsNCj4rICAg
IHsNCj4rICAgICAgICAubmFtZSA9IFRZUEVfVkZJT19JT01NVV9TUEFQUiwNCj4rICAgICAgICAu
cGFyZW50ID0gVFlQRV9WRklPX0lPTU1VX0xFR0FDWSwNCj4rICAgICAgICAuY2xhc3NfaW5pdCA9
IHZmaW9faW9tbXVfc3BhcHJfY2xhc3NfaW5pdCwNCj4rICAgICAgICAuY2xhc3Nfc2l6ZSA9IHNp
emVvZihWRklPSU9NTVVDbGFzcyksDQoNCkluaGVyaXQgcGFyZW50IGNsYXNzX3NpemUgaXMgZW5v
dWdoPyBPdGhlcndpc2UsDQoNClJldmlld2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25n
LmR1YW5AaW50ZWwuY29tPg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+KyAgICB9LA0KPit9Ow0K
PisNCj4rREVGSU5FX1RZUEVTKHR5cGVzKQ0KPi0tDQo+Mi40My4wDQoNCg==

