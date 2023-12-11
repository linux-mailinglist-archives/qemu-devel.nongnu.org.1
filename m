Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F21180C17A
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 07:45:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCa1V-0008IT-8u; Mon, 11 Dec 2023 01:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCa1S-0008I2-KO
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:44:10 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCa1Q-0006r4-De
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702277048; x=1733813048;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yEAO3O3ur0cqyy622hAU/yNqqd8UhmgB+57eYgNJUEw=;
 b=KjqS+fEfy6DHswkolfmdQkwMOIjjNlLB+RqAHgNB4Voux7Vr2j4QiAQU
 7jA5Bxp+npYJkSvwnULqV/ocPqJygar5mUKiDZht20LJTBEIHQOfKjSgR
 Z42o0wE+CDLNFQCcMlOn1b2PCsd9JVbSpphYt55C8YSk9LpWCFFn2A7pU
 J+NDPSPC/ruikL77g3AGtA/Fie5e3deoAXLWNCqIPbtttT3AEdhKcERjm
 RPwnhLYrcIwA2loxFHZaJmoPSbPVbVR3yVVZ2zMa6Jy/wntTe42bETxSm
 SLvVGTAjffbsjRqdw17UYH7/G9WtSVZmvcj/oNt7zmJtEx/AFveKBYLrZ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1675020"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1675020"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2023 22:44:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="766249482"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; d="scan'208";a="766249482"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Dec 2023 22:44:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 22:44:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 22:44:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 22:44:03 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 22:44:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiY5BrAQydA1mPeW6BB8jwO87L6jQmtbpn+AHqG5fFCHb4CNGqSBEB2KcnocudZJsSyKh9zQ4lAxKJvfRXeTLhjGF7rBU2UQCdDmFoGu7kCYwa9WDalfLRe3qU/Ht6Z4yJtjTerxY86reYAVg0Vyu+3Rljz4b/r19rKA0D9XwkLHClUFYU8JBHxpizyqlnV1kR2OlzRFWs5l4pxLUmvNntOJNJXaWV4pSum0L2iSFKrcYsky0GSJtVntWYGiXHVihWZpBRFEMr4S/76b0tIwHRQg2Wm4WmAWQCVjyVUzymj0UV5gMgVaspODUyX81069MeSq2o3LIiFTK3JF1Vv6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEAO3O3ur0cqyy622hAU/yNqqd8UhmgB+57eYgNJUEw=;
 b=SpJU5rMgK50mhQ8UFYreCjLuc87UObo+jfCDzxOtE4O8FHvwevZ7a4ikiH68vM/xre4mAiV0bnVwpd33DJovv/5oYY4zwRqv5PNlLSIwIByP6a8vduej0//J/9EzgCBq3S+dFykYIxX/s18fQnnOyCNXkHALU8tFb/qlFhaAi5hJ3iX3/j0wl4vHHg6A8dx2cnkrrccGf8oJcDLRg+Np9nISddOQMKyr8kLwCBnkalfoDSQRPpqqVXq/psXJ1TnhEhACfuXi/VSsBKvHOjO66WuUiuLBuUwMgTHLs3Qk9jlIDBU1WLPs1SBF6T9QqpLysdHgSda4q1U9SQqcNC74Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BL1PR11MB5463.namprd11.prod.outlook.com (2603:10b6:208:315::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 06:44:00 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 06:44:00 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>
Subject: RE: [PATCH for-9.0 10/10] vfio/iommufd: Remove CONFIG_IOMMUFD usage
Thread-Topic: [PATCH for-9.0 10/10] vfio/iommufd: Remove CONFIG_IOMMUFD usage
Thread-Index: AQHaKbMi2otM6k6Ej0C/TeslqXpyP7Cjpukg
Date: Mon, 11 Dec 2023 06:44:00 +0000
Message-ID: <SJ0PR11MB6744AE89E15EAA2939F0E9E2928FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231208084600.858964-1-clg@redhat.com>
 <20231208084600.858964-11-clg@redhat.com>
In-Reply-To: <20231208084600.858964-11-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BL1PR11MB5463:EE_
x-ms-office365-filtering-correlation-id: 1523a3ae-d6e7-4a10-3030-08dbfa148eac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C0kEWd6AN2PJr790BWc02IjJIlvl3H/NIQIPreLXFKQ/O6vhWHcpD3s2AUjpZsHRRf0fjFgC2aYl/q72kXPd9usTzRRIu9EOLD2rAVQgMhMfz6RPBWX34fHN73gl83y8lBZHyNZkwaWRuIyyG0/6Ge60ZclZK15i0ULLF7jZUZytRvMebiYsOcyYsx8CmWB4wLG1ptEcxqJSxmlKWmbXiqqhu8Hq81/GU8WOURyFxnrfojpyew49DiVhMF4lwL76YsJI7bEJ/5eK5kq++HatUMtRiwBPUDb3lBzj4RriMtQshENbQGZUWKd4tGZSI2qIoj5kcKqNpHVjJFvb4ZEimw0RfV4GtKRDRsI3FVynjHUqOYHHEVbLnWBiCc0LYqUbHcPIjqnSlJGhdgpMXcEwnHqM33TKYmxx2F5/1B3dmpoUuMfC0vQpIkaizUW2gv9xg9ybrl7GrZX4dSoUYVSc0dReMC98V+BsIeE9AM4k/GACBcpsJp39Oog42GrXiQFL9xkdUEkYnj7LmTKBep6q9CSRDdHnD82+uJyJNgxpaKVjgaIxGnM6n7gdbLtv9zVVY6Pro7ZXUnBHfFMCxpB5i8cSq1Kwa8DIJ8E31basou8Nulm1yzc718hbXwcQ4SOa
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(366004)(396003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(4744005)(2906002)(41300700001)(38100700002)(122000001)(33656002)(110136005)(86362001)(82960400001)(9686003)(26005)(478600001)(71200400001)(7696005)(6506007)(83380400001)(4326008)(52536014)(5660300002)(316002)(76116006)(66556008)(66476007)(66446008)(64756008)(54906003)(66946007)(38070700009)(8936002)(8676002)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXJqUUJSWWN5cFZpTzJMZjVNNzVCeXFhUUJubkw2R0c0dHZKNExpRDRLQnQw?=
 =?utf-8?B?TkpnenFnR29oQzRUL3N6QjVmNVRFS0ZFRU8vc3VFTDlLZGNMWWtCU2V5d0Fh?=
 =?utf-8?B?SSsrK3dBbmZ5Rm5lWmtQc1d5WXZ4bjk0cnVjamhmbDNGekdYVS9BeW4wMy9K?=
 =?utf-8?B?VHJjRitDampqUzJYWWM5byt0WDQrT0NncXErWnhIZldMMHI4ZWNXNVk0Uzg5?=
 =?utf-8?B?ZnphN0w2MHVqaDBpYUMwaHd2V0VpODVHTzFvU254OVhCZm83U0FDWmdyaW1p?=
 =?utf-8?B?bE0rRkE4ZW5ZU01aVzN2UXhnQ1JDOTBnd3pGQUNxN0lHdmo1RjVUUWVGdno4?=
 =?utf-8?B?cnA5SFZDMWNTR2V6ZjhkUWZtdExaOXRsVS9lS1JmenVOT2VSNzNpOFNwUWJy?=
 =?utf-8?B?TVhRL3VyRkFTcUdWTWVpUkZZbEtQVW9qRTV4eHB4TDhHV3J6ZGpkRlRqTU03?=
 =?utf-8?B?MGZrcVZIK3k3TFBTL21MMTRBaG95TkU1NTUrZXlhSzRRWkszUW1qWVp4aXZv?=
 =?utf-8?B?bVBabThJN0ZvczJoYkJ6NkxnZUorcjVuYStaMDlYMmN2cjRGMnR0cTdPank0?=
 =?utf-8?B?a3pNR2owcUZPdGtsVlFaaWxwYmNsSGhpeHh3MTI0eUdZTURUc2ZtQ0ZjN0th?=
 =?utf-8?B?cC8vazZPWmtiRkFjOXk2WlVQSUh1cXhidWdqOTdaY0hMTmFzemdTK1FpbU56?=
 =?utf-8?B?SXVBRXkwUEJMdnkrZ3NWMW11ak1JRms0eHFjcStCR1ZLQ2pWd3RubjN4RjZr?=
 =?utf-8?B?UmVXUXVyRUJ5WmRjS0hGcG4wd0F1WjFUWTViajUzTFhDZmgxZWJxMFdBTlpZ?=
 =?utf-8?B?YnZudUNKTW5sNFhFZFJDb21RY21Rb2svLzBybXVDNi9qUXVEVDdFTjQyeHVF?=
 =?utf-8?B?TXBrL24vNVZuR0NjVVdlTmQxQW80cjc2aVdPUjFsM0tPSDdrbG1DcXhRMGhO?=
 =?utf-8?B?RllxcS8yNzAzaG5TMmliQzkzVzZyM0xqNCs5bWxmRStvMHgyWXRwM2NCWkF5?=
 =?utf-8?B?RXJYN1pjN0FxYTVKaWNQSVdOeGpzSCt2TVVMU2lYTml5V0dzNzR4VlZnejNV?=
 =?utf-8?B?eEd4Ny8rbW5SNjAwUmZaMmpLUDB4Nzc4Q0RHRjZlZ01uKzFQNXJINzFJUEMy?=
 =?utf-8?B?TElxNjBldFB6eGlzcGpVSkxXayt1MGdYUUY2d1dUbG5vMzVEQ0xyeC9TWVBT?=
 =?utf-8?B?QUNQMXZwUlQ2ZVU5UWh3c1BTSmJ0K0t1S2VndXNHbG03WTF5elVNWHhpendT?=
 =?utf-8?B?ZmhOcEJ0ejR3cHA5MGpaOFZ4QUlRVldqSUdUSnBCY1FYa3NtTndHczEyTjBv?=
 =?utf-8?B?NzFHbFlENXN5dVhnV1hyYjRBbmo1emkzeDJybytYK1BQNEtjWFdQSW4rYkJY?=
 =?utf-8?B?OCtBckdGUCtrNCswb1JSblh5dnh6OWpJbTBzd3oxUm9qUVZnTDErbURiRnpD?=
 =?utf-8?B?bzU3cTdKdGM2UlBTUWJHdy9wRDUyTlQ3SDViV3RlZG0ydzFKelZpNk1waEJF?=
 =?utf-8?B?VVhVbjR5QllmYXBMLzVJTXh6aUZzL2JJbk1mN0xPbDlVM0pBRDloRXFBVVda?=
 =?utf-8?B?ZDhIcVMvVUtoK1Brek4rQnZOWDVJZzFKMVpJU2s5MEoySlpzb0hKU1BnaFdG?=
 =?utf-8?B?Skd3TFBRMEt1UVdEd3h3SlN1SFNrQXA4SVhNOGhIREw3aSt6NUlnb1FYTXRv?=
 =?utf-8?B?Q3pZVlRNY2dWN1VNWE9INE0zTTdmTEJNZy91bmQvalZ2WUw2djI0R2RVdEhz?=
 =?utf-8?B?ZjB4SFEySkVwaUNEeEJySFhvMm82Q1E3Q3NSWVJqU2R5N0c3a2Y4U1ZNZVp1?=
 =?utf-8?B?UXJHcmxZdDk0REs1eVlrYU0xd2tFYkE4RnlLTkxaMUg2T2hJK0VKRmRtUUF6?=
 =?utf-8?B?Nk5oREo5SjFpS05Udzd5czRLM25jZmlzZHY1S201bTFJSE11WC9xajlMdXN0?=
 =?utf-8?B?ZCt6QjFWTHBVMEthUnlqMk55V043bEN6akxiQUpvc2ZvOHJXM0w3NWZTdXcr?=
 =?utf-8?B?VkJkVEVDdER4RWRxZUtzUlRMNXN0U3RLREp1RFBlbzNnWmRhLzBETGg4d0s5?=
 =?utf-8?B?NzM1Y1BKUXIyZWQzS0dadlRiaEovREVyaURJV1F3VzdpeGhyYXJXOHd2MWRU?=
 =?utf-8?Q?8p0WleHZqkCLbh5SqweWH7BF7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1523a3ae-d6e7-4a10-3030-08dbfa148eac
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 06:44:00.2968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dld0WpyXKqMY4ZcdaFoi3TbHPCGs/8yiNZ0ImiAT96fzOZmqefKFinzm8lFG9gx3erFRB0ToW9UkQeJvbMSc5ottX9mUBL0pVs4YyUCaY9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5463
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggZm9yLTkuMCAxMC8xMF0gdmZpby9p
b21tdWZkOiBSZW1vdmUgQ09ORklHX0lPTU1VRkQNCj51c2FnZQ0KPg0KPkF2YWlsYWJpbGl0eSBv
ZiB0aGUgSU9NTVVGRCBiYWNrZW5kIGNhbiBub3cgYmUgZnVsbHkgZGV0ZXJtaW5lZCBhdA0KPnJ1
bnRpbWUgYW5kIHRoZSBpZmRlZiBjaGVjayB3YXMgYSBidWlsZCB0aW1lIHByb3RlY3Rpb24gKGZv
ciBQUEMgbm90DQo+c3VwcG9ydGluZyBpdCBtb3N0bHkpLg0KPg0KPlNpZ25lZC1vZmYtYnk6IEPD
qWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFpoZW56aG9u
ZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQoNClRoYW5rcw0KWmhlbnpob25nDQoN
Cg==

