Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2880082269B
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 02:42:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKqFY-0004MT-0g; Tue, 02 Jan 2024 20:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rKqFT-0004MG-CM
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 20:40:48 -0500
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rKqFQ-0002w5-QE
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 20:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704246044; x=1735782044;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Jw34G3IxbGQJnm4SZAXyGe4ZSevqSLch6KA1hmOa0zI=;
 b=hhBiymaIBP8hksmOhm0IWaWb4mY+taPOGLeX9RsMxnft/vWfTsbfzSP+
 sAMGA5IoSBRMsEhd5R5aERjuMZjS8yL/NZDRxxzTm3wUTbYC06eFHYzQd
 TpYyRgOVnNXevm3HSqYw2CUl8LctYlFEYWrlQ9Qgbqo0D4HKXG1KEgmyS
 xqUgUMiKBMsr6L9w9yrzHITaYigg+ll//64yezDcymlREri00whP+YRf9
 Z2Wr+8K9nfSQ6Ea76B6fwFL+7v/+YCzfKVcD+aJNu9oUBnzIlejgz5gEg
 8DyYI4TYz/05QROpLLC5kSJFjG9YpmaLxqGkW8jEb+US/eiF8Kly8xWDC g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="399713355"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; d="scan'208";a="399713355"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jan 2024 17:40:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="783357233"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; d="scan'208";a="783357233"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 02 Jan 2024 17:40:39 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 17:40:39 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 17:40:39 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 17:40:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPR0ZJvfnAI47/vSegzh5qBUGhazaxDlwwipDQwItq7/C8pQLKFfG5vavhACX2y5hm2hq40nzDyPGaEJ8xlV0ZgCILqbDwVKeXKxUAivrg18z3ZLgzJiDcVfMhlPZQQorEX5UioSTJ9l9fApYho+LnQ/zqZY/IQL21YWgcBkl+BczQ7NGiAghK9O/9OyBdEdDz3m2FRnH8kdmeKj9w8reHQK4Uj7IMcJpYZ7ZSq/ILCVrmh3wc/FtrOzxqcvKacFbmUGLTY4IhaUwZIbEHcfMltt23Z8WYcRlhoXqtfTz8jXaho7bT0MA3ChIxA9IkbNWSRRL2xpIPgmrjfrP9LSxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jw34G3IxbGQJnm4SZAXyGe4ZSevqSLch6KA1hmOa0zI=;
 b=m4b3kxliMOCtUnFBzVMNuLNexhkI3C0qOKscnvqs95f3LDAJr16VvJkPrq0P12VuNpvFbdVoZ/F/XOZ66RL+eKMycX9P+DyRBbFq/s+ewZoDihrU7pWi3JV3bcCwjRAOn2Lvkof8mKMye1ZLfmrbiy9+aGg/8C/SNjxqQs1K0voGgPIxro4qr8D2CIC4oW+9fBbpIYbmULjhv8PHIK85Zah6iX3q4nYU7sFOJN8HffENM1LXZeU7Y4BMhus8+MgFwRccWorW9yDWqhrXYvOBlLomgdlpatoSEMqt50pKGT+VE31f5T7pnOjuEQr416ZGkzJIoY5qHvazkMUR5XjPQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA1PR11MB8350.namprd11.prod.outlook.com (2603:10b6:806:387::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 01:40:36 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 01:40:36 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH 1/2] backends/iommufd: Remove check on number of backend
 users
Thread-Topic: [PATCH 1/2] backends/iommufd: Remove check on number of backend
 users
Thread-Index: AQHaPXfBokplEuoqS0imKe8596uEI7DHTVQA
Date: Wed, 3 Jan 2024 01:40:36 +0000
Message-ID: <SJ0PR11MB6744F8F025A15F98773483E99260A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240102123210.1184293-1-clg@redhat.com>
 <20240102123210.1184293-2-clg@redhat.com>
In-Reply-To: <20240102123210.1184293-2-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA1PR11MB8350:EE_
x-ms-office365-filtering-correlation-id: b20b5785-e0e7-4503-65a4-08dc0bfcfbb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k02xZ1dFDWyMfr1XSNdsrs6rREtWmKBihZ2XuvyweLtole7YUHoUa+j2fs02nLDm+r4eGErQcxdC4Bbo+KJuBuYP4By1iu+JDL2pLdexiGqcDQ6VIAmz41Lv5ilU27+RmcdqksyMD2d0fYWfZvZ18J3+ozsTrNMLInftZrl+1x0M0UuDds5AfwhIqaAz8oAPYj3V2L3mmJq/fS0Gmox9jq5QL+BAJSB+1Yr0MOpTUDgDcYhzGv6xzj9sFGDkcZHPwQGENXB9P7h+ytoxo9iOEhmcCDGjZHrSreswNzyZKr9cX610UZet6AO2IHjA7hP0mUwoKCrVeux3VmC9O0OpjFr3UJWHvespNZB5QSJQ5piaB/v2Jg5AxC0e0HneUcXldgZPvES9GeCqGMdZolfGhUihsVhvMwnvsyou3oG4k1kmyOWwFmUqOzp2CjZd2XrOlMx14NMPJv57bfSTirGVv246OMzCysc1dCt5DETo99L/bR+aeqpnLJ6Fvyrr+CTxoxWYLNs0LHTA8voz/BYXVFdXrzXXHqpY1NTOyJPnqBRvUju5fiUEy1Uhe1jdsXKDcfQztTycQbz2gPgF9yFJOqEqwvT5xziiJk7SJA4fdDTk0PlijqBrh1/qf0RN8VwiKidS6NFJiyrFp5ebC93x/ZfYk0EaeG9bLquGVmS1WMs9HdHGtY9uAu82kkYnfkoL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(55016003)(41300700001)(2906002)(5660300002)(8676002)(66946007)(4326008)(316002)(76116006)(54906003)(110136005)(66556008)(52536014)(66446008)(66476007)(64756008)(33656002)(122000001)(38100700002)(38070700009)(82960400001)(8936002)(7696005)(478600001)(71200400001)(86362001)(9686003)(6506007)(26005)(66574015)(83380400001)(26730200005)(19860200003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1c0S1hPeURnSDJjcnAzY0xjRVNrRlRhbDJaZmtObFF5c20wWTMrdXZwbi9o?=
 =?utf-8?B?S0RWUHJ4WHNWblV0akVxN3ZWZGF0TDFkRkxpTUVKZW5WMkMzVTVjSGFqbEk2?=
 =?utf-8?B?TW90cHVrWC9JZlJlY2tYYkNkVDB3MThOcFIwNVp4SS9TaGUwT2FnaEtIWWJV?=
 =?utf-8?B?c0p5MzBuV25tWUpoTnB0ZVhPVk5zVW0zbktEMUh4UjNwcCtsT2hSOFZjbXRN?=
 =?utf-8?B?aVphLy9VRzNKL054Z0JhaGh6dW1IK1Q4Ykc4b1dzbk1LR2tYUXMzZE5hMDRo?=
 =?utf-8?B?NHlWMzRKNHVNMHpnVDFFN1E1VmV3c21UQUlUM3d4aXBieVVQcW1xZHRkRFNs?=
 =?utf-8?B?MmdGSU1jUDNCTW1nR1ZpZk5KM096bmRSVldKN2czVEpwYUx0ZUdJbzhPSTQz?=
 =?utf-8?B?OFFhQmZCaGJlU1NxdEhiYktCajZGVjViUWMva3BCTll1eW4rV2d5Tk9GanVw?=
 =?utf-8?B?VkRGQmw0dnUvZy85SzVzQ3kxK1JlTkhMUm94aFFRSFFxcEg3bzJPOUtnVVV5?=
 =?utf-8?B?bGpmS1l0cDNPd3Nra1hycDVvYkNvZHd6cmN2M0VOS29VbDV4Ukh3ZDFidTBa?=
 =?utf-8?B?ZFg0Y2RYMW5rSXdSZExIZ1RIRXBkU2lveGNmZnh5TmNiaDJNemc1UDJSbWxH?=
 =?utf-8?B?Q0dYalZTWDJ2dUd5UnlNT09pSFdJTmlOamg4WjkzSGpuQzFSTEIySjBFank1?=
 =?utf-8?B?Zm1VQTVMMzVpajFRdkVHZFRIaFpkY1FzTXIvZjdQRk5sdVhmalJuUnNOUWxT?=
 =?utf-8?B?ajZQdzRqa3RpOFpnSW0remErbm9DYWxPZTlnTlkvMUZHZXVzVTJGeXVUOS9Z?=
 =?utf-8?B?aXZyTWVvdlRpZWdQQTNwZ2tDUWJZaEY1SkMyZXEyTTFvWnJzVnRBczhjQlBr?=
 =?utf-8?B?d3o1ZG8wM2dHZkxvMHdqUVBaaTFNMkJsM0w3bFBabDBCbUdtcERJYk1yYUV3?=
 =?utf-8?B?b0JlUHpPOHdHVmM2NGFGY3ZHV1c3T3RxM09PODdvYjduL2YrYjRvTkE2cWFN?=
 =?utf-8?B?cVZMdEd0WDcrY1MwUlh2SEdkUjRXWEltZlJwZDVaUFlTbmhlKzdzK01CRnNG?=
 =?utf-8?B?YlVIV1BMU2dDSDVaZk9IM1dzS0NVY2UvM01wRnFmdWoxWjdVcmJNSGtVYXh4?=
 =?utf-8?B?VjQrSi9OOEY0R0p6elE0b2J5WHJidW1zWjlpS3pMZnZSeFhmOC9ZWXVtMURv?=
 =?utf-8?B?bDFuV0E1aGhFMzFZNlVKamxKekhiR1FDSGhIbVEycmcvcndmTkhHQ2hXOXNQ?=
 =?utf-8?B?QkhSRDRxckViazZGQjFWY0ZYNHVxT2kxSjA5RFBLOXlBc1FESnYxWWZkYlh0?=
 =?utf-8?B?K3YxRVRJS25wQzJwWkZlQkNOanlyTVZjUFAzbUlOS2RGZXpZVVpVcVZnNC9y?=
 =?utf-8?B?c0d5RXp6SWY3WlBuNnIzcWVmK1RqWmdxZEFTVVRLSGc0RW9Oa1gwOWlWL2Jy?=
 =?utf-8?B?NFhEVTJqR2kzRGJDVzFvTmlZZFBaalFsWnB2bitFM1FMVXMrTHRvQ2ZPdW8r?=
 =?utf-8?B?M3BJeXdiN3FFeS85bkRyZGZnYy9LbXY2Z2V1dFNtQlo0YTc3aWZUSktaNjhS?=
 =?utf-8?B?alBmMTc3bmFuVHRmQWFZQ1N4OEc3SnFMVjd0WWc5Tkpwem43UGE1Vk91WHh0?=
 =?utf-8?B?OXNGREF2T2ErM2o1QndYRmZXR21lWjY3c1FPMkRIbkdaVVhUaXc4THE3WEtI?=
 =?utf-8?B?MXhNMmlESXM0NVhWWS83RnlIMEY0aUJiR2dYTmxqS3UxSlRDTHora0lRcGZO?=
 =?utf-8?B?VndGbTl6eVM5KzhWYjhSeWFadGZlcm5TV09yOE5OUmI2ZzZMeEJFNWdsR3Fo?=
 =?utf-8?B?RXFFa2hlejB5dG84MllBUTR1VGV5a0xDdmExYnBWR2I1eVNpaDhpV3NnTnBJ?=
 =?utf-8?B?UlFTZEtwOXBqNGluSTYwb1E5QTJBd3NRUnljNFFyMko0LzZGNzBNWCtCQlB6?=
 =?utf-8?B?ZWlSTU9YMFhyWUtwcFAvUEZyaVBxSkphaXg4ZHRFUi95WWx1M1RFRXpycVNj?=
 =?utf-8?B?cXJYb21FSEFFRHdQOFluSkJIRmxMd2hCSHVFODV6QURKa1hwTnZMb3FsTTdP?=
 =?utf-8?B?OHpWVzYvT2NjaUxTbGZMN3BPTzJkSmJvQlZiYk04OWZadEZUZFVoMHNPQjA2?=
 =?utf-8?Q?oW10cKKtYQVkmzXC4YggjISpw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20b5785-e0e7-4503-65a4-08dc0bfcfbb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 01:40:36.2169 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hg/D2TxLnOr0G9UQfB5aob+MzT6Yd7xlWzUcD2mtqJWACUk4TM9CVstrekLD7WcURr6+243qA8qWoXXc8Okm+pbMCtOxApD8vP4lLzxAV6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8350
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.178,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMiwg
MjAyNCA4OjMyIFBNDQo+VG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPkNjOiBMaXUsIFlpIEwg
PHlpLmwubGl1QGludGVsLmNvbT47IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT47
IER1YW4sDQo+Wmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+OyBDw6lkcmljIExl
IEdvYXRlcg0KPjxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggMS8yXSBiYWNrZW5k
cy9pb21tdWZkOiBSZW1vdmUgY2hlY2sgb24gbnVtYmVyIG9mDQo+YmFja2VuZCB1c2Vycw0KPg0K
PlFPTSBhbHJlYWR5IGhhcyBhIHJlZiBjb3VudCBvbiBvYmplY3RzIGFuZCBpdCB3aWxsIGFzc2Vy
dCBtdWNoDQo+ZWFybGllciwgd2hlbiBJTlRfTUFYIGlzIHJlYWNoZWQuDQo+DQo+U2lnbmVkLW9m
Zi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KDQpJSVVDLCAvZGV2L2lv
bW11IGlzIG9wZW5lZCBvbiBkZW1hbmQsIGJlLT51c2VycyBpcyB1c2VkIHRvIGNhdGNoIHVuZGVy
Zmxvdw0Kb3Igb3ZlcmZsb3cgZHVlIHRvIG1pc21hdGNoZWQgaW9tbXVmZF9iYWNrZW5kX2Nvbm5l
Y3QvZGlzY29ubmVjdA0KcGFpcnMuIEl0IGxvb2tzIGRpZmZlcmVudCBmcm9tIG9iamVjdCByZWYg
Y291bnQgaW4gcHVycG9zZSwgYnV0IEkgYWdyZWUNCmEgY29ycmVjdGx5IHdyaXR0ZW4gY29kZSB3
aWxsIG5ldmVyIHRyaWdnZXIgc3VjaCBvdmVyZmxvdy91bmRlcmZsb3cuDQoNClNvLCBmb3IgdGhl
IHNlcmllczoNClJldmlld2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50
ZWwuY29tPg0KDQpCUnMuDQpaaGVuemhvbmcNCg0KPi0tLQ0KPiBiYWNrZW5kcy9pb21tdWZkLmMg
fCA1IC0tLS0tDQo+IDEgZmlsZSBjaGFuZ2VkLCA1IGRlbGV0aW9ucygtKQ0KPg0KPmRpZmYgLS1n
aXQgYS9iYWNrZW5kcy9pb21tdWZkLmMgYi9iYWNrZW5kcy9pb21tdWZkLmMNCj5pbmRleA0KPmJh
NThhMGViMGQwYmE5YWFlNjI1Yzk4N2ViNzI4NTQ3NTQzZGJhNjYuLjM5M2MwZDlhMzcxOWUzZGUx
YTZiDQo+NTFhOGZmMmU3NWUxODRiYWRjODIgMTAwNjQ0DQo+LS0tIGEvYmFja2VuZHMvaW9tbXVm
ZC5jDQo+KysrIGIvYmFja2VuZHMvaW9tbXVmZC5jDQo+QEAgLTgwLDExICs4MCw2IEBAIGludCBp
b21tdWZkX2JhY2tlbmRfY29ubmVjdChJT01NVUZEQmFja2VuZA0KPipiZSwgRXJyb3IgKiplcnJw
KQ0KPiAgICAgaW50IGZkLCByZXQgPSAwOw0KPg0KPiAgICAgcWVtdV9tdXRleF9sb2NrKCZiZS0+
bG9jayk7DQo+LSAgICBpZiAoYmUtPnVzZXJzID09IFVJTlQzMl9NQVgpIHsNCj4tICAgICAgICBl
cnJvcl9zZXRnKGVycnAsICJ0b28gbWFueSBjb25uZWN0aW9ucyIpOw0KPi0gICAgICAgIHJldCA9
IC1FMkJJRzsNCj4tICAgICAgICBnb3RvIG91dDsNCj4tICAgIH0NCj4gICAgIGlmIChiZS0+b3du
ZWQgJiYgIWJlLT51c2Vycykgew0KPiAgICAgICAgIGZkID0gcWVtdV9vcGVuX29sZCgiL2Rldi9p
b21tdSIsIE9fUkRXUik7DQo+ICAgICAgICAgaWYgKGZkIDwgMCkgew0KPi0tDQo+Mi40My4wDQoN
Cg==

