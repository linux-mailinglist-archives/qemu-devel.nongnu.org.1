Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9042743230
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 03:21:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF2nu-00010B-8W; Thu, 29 Jun 2023 21:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qF2nr-0000zm-DD
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 21:20:03 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qF2no-0005rE-EI
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 21:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688088000; x=1719624000;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ql0tpLL9WUAFrrAMDFph8KAhyBM4YZjVMcnkfXup/tc=;
 b=Ohvj+xYQOjz6lAwjfhrzYkhACsc0ywbAwyivSFZIdljrjjDMcq6fvnOZ
 nAFTBskuTN+bu3vZy50ILbBElabWLzLPjGjiYgtRKQ9qunpCYiAgCO4Eu
 SHxFzMhzJAh0LZEc8bN+WE7MYTLPKQiir/414vn9O0rSYFjDKZ/X1SqSx
 d4quct0rikIOE67ToQEo0fQ/6v5YIPNb4tA6fjMbw7ra2VtnnoF9eSoN9
 bZy8eOwxcjupj077hPReJkXtPlKkqEqngkZxA74UXGDZO3+wHCA+pl+/K
 We2TUdz7Wfm6ypxgZVkbZeJSXPwzGI2FVXy7Iv3wgyocAhuAaZHt1bl5b A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="341863314"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; d="scan'208";a="341863314"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2023 18:19:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="807567506"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; d="scan'208";a="807567506"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2023 18:19:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 18:19:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 29 Jun 2023 18:19:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 29 Jun 2023 18:19:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cc7nAIA4omd4Cpe8S55BHR2T1JYymQfeBGBF+ugQ62o2sIf2VOkgDlhykox+wX5tgBiwlNoV+tbC/LHk/z5plzdTfV3RGAYRL6rPe21Y9u0BAUcrBvxyifSb21Bi/6nKkPgfOMlaSwZDX8v1Bp11hP3xT2kt96xGbXebliMmW/dTncIMFAG/laeQX8nWPWqae5I8PW74DtFJBoY8lbdUEDyuw7+We8pE1yKmXUAaRiENlPEljV1Pl6CejDqiVW6WmIw1WYYex3gLP67OQRXq4djI03tcIhYqyuA3VmELuWsjJ7JGhqOckrFf+DpM1tzIEVC1IQZIoG9DczoW9QIC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ql0tpLL9WUAFrrAMDFph8KAhyBM4YZjVMcnkfXup/tc=;
 b=TAhZsKkggPkCXCI1YkH+xBF5v+6q/AcqcLiKIaERwHyV76PS/s6//4uZ7JuI2aNT/Q2+KocDlAJa68UAPc3tPkghyiCVhAXpXrTOojgids0wL0dALODc+RgANQVvbeWtASV93R042RuqpV/hsZGKO7gLLzcUAJ6rH9iDCYr1x+VYrHjBX/2VVDliazLsCB0yzFG4aqX8GWK4cS64gcb9N6f+pLjIaDTLYjRNs4MDUhHJLoUIhYBX+aTn84LsaPmpgCNTu7gqAsIYzKNt0Xcb+6rCudP0pkZOINBnDf6fERdwv+1gHsUBCGkIkMd01198RtTEOsCfxv170O7FK4Lsuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7729.namprd11.prod.outlook.com (2603:10b6:930:70::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Fri, 30 Jun
 2023 01:19:49 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%6]) with mapi id 15.20.6521.024; Fri, 30 Jun 2023
 01:19:49 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "avihaih@nvidia.com" <avihaih@nvidia.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v4 3/5] vfio/pci: Disable INTx in vfio_realize error path
Thread-Topic: [PATCH v4 3/5] vfio/pci: Disable INTx in vfio_realize error path
Thread-Index: AQHZqmc/D2fzNRNk0EGzNA7LI2vEpa+ho7GAgABACoCAAAWHAIAAoQ6g
Date: Fri, 30 Jun 2023 01:19:48 +0000
Message-ID: <SJ0PR11MB67445C4B405312107B81180A922AA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
 <20230629084042.86502-4-zhenzhong.duan@intel.com>
 <29b6ecd3-d0a1-c914-9bba-cb99d95acd8d@oracle.com>
 <393d930c-da04-4c86-0f77-615c511df77b@redhat.com>
 <c32ef5f7-4c42-403c-22b6-734432c01e19@oracle.com>
In-Reply-To: <c32ef5f7-4c42-403c-22b6-734432c01e19@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7729:EE_
x-ms-office365-filtering-correlation-id: 2d2e13e4-df36-4487-4282-08db790818fb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YMevmJSk+RWUCaUhJ8sa2o2MVSYNUlpUsQTsTLMV9ZedjCUR5DFE4lCw/67hHU2OdwrpnZSVnrtJgjPJQRrxL2dfqPxzN0m8b7ji0ZRv4LTu86G2L9KN3rX+p7EY7ywOefva/CUeOZBqMYiNL+gbBjw2W8x3U3V7gawm6gCAAZddjqDg/Glt2aU0kpS9q66V+LFIRiaIhNDtrOk0ffEh5W71Gbh1Bf/eLMjDKTzeCMXJlX6NZ7FdY441vyZmbBJWpfgRW7h+aIYvMWiR8GttOxs5iFo1vzBEfWONmsNUevPi9Xyg2Fqzs/MIuYVB/SCvJHryKaEla/4X303x5G/wmIPLRB9ZmPkfjBltPIoPW5nbw2szXBikIOIwU6qw/A162hbhuLgbMikuPjEkr0sUBUTArVMcqntd5STkCR7CNW1ZgfWXePGxB3qg6RCEVfQ5P3H8FvKfhYJL7vwFmUna2ouipZmMw1S9Hk5/fUpwwR/boNMJad9QnJRbiHPXnGgnT8RIC7O8TSZV/q1dHmPLrEntteWK8upy3FyXb+wb97kmjnXBnEp+C6U2Vsc+Lf/tIcL0LgOvEA5gJjVhcgLqGdgrDiyyGMo0X/a0P+qiBoaRc5s05xJL/2UdYeTaZ/+C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199021)(66574015)(2906002)(186003)(55016003)(7696005)(71200400001)(122000001)(86362001)(107886003)(9686003)(38100700002)(83380400001)(82960400001)(26005)(53546011)(6506007)(110136005)(41300700001)(54906003)(38070700005)(478600001)(316002)(76116006)(66556008)(66446008)(4326008)(66946007)(33656002)(64756008)(66476007)(5660300002)(52536014)(8676002)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHFCZU5Fc2VLTktETEozZEhudjJFTldNcDNKQmpuVHhScDN3eEhOclllN1JD?=
 =?utf-8?B?MXl3ZHNGa1hDaTkzRFg4ajFseEgyUS9KaldLWStzeFBmaFlnbHBoa2RJMTdz?=
 =?utf-8?B?ZHoyU1JoSUxIZVNzcHhSa080NDJuV081YUp4ZnhTU1pvREU0dHU1NDVLaVp2?=
 =?utf-8?B?b1F2NGo5YkFKY2dSRzRHU1I3R1NVR1d1aXczSzdEQnQ0REx5a1hzRWxTM3dr?=
 =?utf-8?B?dFVQb3VwRWhQak5BV2hNcURTYThwUmlkbW4vOGZWS0xpLzhleGdvSm1LM0VM?=
 =?utf-8?B?Qysrc2pQYmVFSWQ5MTl3eUtjL0tSS2RrTnY5NGNIS3pXNHl4a3lBZHZtVlRR?=
 =?utf-8?B?a3JTR0tMTDMvZHp4NGFHZDMvc1gyaWk0QjRDdXBUdHlaZEVUbWNXUnRwcG9M?=
 =?utf-8?B?ZWFGZE9XSTVXWlgycHRsbmgyd0NHWWoycEJ2QjBZVzFmNytZVkZ1U2dpdDlR?=
 =?utf-8?B?Um5TeXVFeWFVTllRSzNLcmQxb2VsNVUrVEpwMVdyRy9kT1ZGUjMvU3QrckRR?=
 =?utf-8?B?czRnOEk1S2NGZmlwTUFnL3NGTTBsZDE4UjBiUHE1NVZGRWpHbnlubm9uU0h4?=
 =?utf-8?B?M0VCZE5GbDkrTWtkS25sZHh0WXlhek05eU9VZ2F0MUZldStUa1YxNFJhWVk3?=
 =?utf-8?B?bjgrYUJydW01cG5SMHNueFJHWHNWMEdMTlg2am9KcVBzNkVnYWpqRHd3ZlBN?=
 =?utf-8?B?cDFkdXA2a0U5L3k5Mk9sdDk1REZnN2lzeGFtNTZCQUVQYjZZNmVUQUlwUnJU?=
 =?utf-8?B?NExOaVQzNlVJMElHMEpaK01xU0xGNGE4SHhwSnIrbGRYQU91L0NKTmxiZHlu?=
 =?utf-8?B?N2lrOGtJMXJ4WDV6UmZwRkNzeVg5dkxqZnpYUU1CZklZWUdiaElrU1psekJx?=
 =?utf-8?B?ZU9SblRxc0lWdTJxU2tRRE5xSm8yNnhlMklHQmswVktsdGNTQndWY3QvcnJy?=
 =?utf-8?B?blZXS1Q2NGdITlRDQ0VOVUdFaEdWV0ZFdkRYMGVFaHhhZldWR1pVeHdJTTZi?=
 =?utf-8?B?K1FFOExZa3ZQNHhsNlNMVkxXN3hqMDZmWGE1YVF1dmowdGs0bUdPZjgxQUtB?=
 =?utf-8?B?SzZTNGFtamQvbXgzWkVwVFd1K0VYWDQybEFSczNLWFRPVFNpUXJjTXhib04v?=
 =?utf-8?B?akZwenFPS0tOaVlqMk8zV24vSFkrSTNnVHJScUtUdVhjQUJKMjhUdDczRHAx?=
 =?utf-8?B?RjZGOG14OE00Tnk3RXhjSmltSW1nbjFYMWIyYmE5eXR5K2FLRnhGZjhTZ1B6?=
 =?utf-8?B?U1BvVnBFdUdWY0JRbElhSDlYT0t0NDIwV0NyL1hoSUM3NGtDMmp0VTBVRHNL?=
 =?utf-8?B?emMxOC8zWjJEbDVMMXhpRGR0L1NEcWEyZzZsT3NJS0FGRVNtR2x2NWpiVlM0?=
 =?utf-8?B?ZUkyZ2RRSkI4VndqMk1pdW1VK1VaYXMzT1ZBL1BnQXd0dk00cVB0NUJGT0lN?=
 =?utf-8?B?bllEdWhLVVYwMDVpWkJTRjVuWFZqOVMvT09OdDlGWW9HN1UzcGdBZHVTNzdR?=
 =?utf-8?B?blFkQmhSd1pOQlpDaGFHbDlPUHpoejBqZU5hdlVRQXZXa3ZEL0JjY1dTNFFN?=
 =?utf-8?B?YVQ0cGlsakNZTkNzNmlnUk5NTlgxQ2V6dmV3ZFh1N2VKZ0ZpZVJQOXFqcEhK?=
 =?utf-8?B?RzljRVdTZEhkbWNvb0ZaM1YrVjRkVUJIM1V5enR3S2ZCc253bGxTS1c5eldC?=
 =?utf-8?B?V080VlczUmliZHAwQTh3a1F5S0pHM2xaREk1Nno0ZTJtMERBa3oxeU5OSVRv?=
 =?utf-8?B?OW9iZzlWeWpZd1lSVVplZ3gvZXlCcU9hczN0cCs5WldRSG5QNW9QSndSaFBl?=
 =?utf-8?B?L3hKMmlBVTExdTZrVXJzdG9kVWtzVUhKTWMzcElkTm1rYk9aR2N5NjR4ZHl3?=
 =?utf-8?B?Z0kxd0NQZlc1U01kbDBhWHVnOFovVUp5WndRMy80bkFQWHFGdFB5cVdGYXZw?=
 =?utf-8?B?QlRUM2doM3FFeEU5ZDdsN05KbGkxM21ia05ZN2tPVi92SUcvMmRnalhaM1dK?=
 =?utf-8?B?enBUNmpWVkEvZXo4MnVEWXBpQW13NjRVRWdWK2FXak9XSk9FVDdFeEN6L2xL?=
 =?utf-8?B?KzhYRmQvVFc5Um10Njdwc2xjaml4aVdFZmptVG1yWGVOS2pxNmFXaG5LY2Fl?=
 =?utf-8?Q?8G38coGm8bpaeRXK/WCkjSKc2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2e13e4-df36-4487-4282-08db790818fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 01:19:48.8494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CtVjcE7i39leYqfMmlbILCepeNRGGR2r2MAvZnwT0/Kap6JodV4hTLyTEucRxoBR+097qkhx7Bj7+l2us8JKELLuIaPkD5/WG2GsEFcIXlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7729
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mga12.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSm9hbyBNYXJ0aW5zIDxqb2FvLm0u
bWFydGluc0BvcmFjbGUuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMy81XSB2ZmlvL3Bj
aTogRGlzYWJsZSBJTlR4IGluIHZmaW9fcmVhbGl6ZSBlcnJvciBwYXRoDQo+DQo+DQo+DQo+T24g
MjkvMDYvMjAyMyAxNjoxMywgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+PiBPbiA2LzI5LzIz
IDEzOjI0LCBKb2FvIE1hcnRpbnMgd3JvdGU6DQo+Pj4gT24gMjkvMDYvMjAyMyAwOTo0MCwgWmhl
bnpob25nIER1YW4gd3JvdGU6DQo+Pj4+IFdoZW4gdmZpbyByZWFsaXplIGZhaWxzLCBJTlR4IGlz
bid0IGRpc2FibGVkIGlmIGl0IGhhcyBiZWVuIGVuYWJsZWQuDQo+Pj4+IFRoaXMgbWF5IGNvbmZ1
c2UgaG9zdCBzaWRlIHdpdGggdW5oYW5kbGVkIGludGVycnVwdCByZXBvcnQuDQo+Pj4+DQo+Pj4+
IEFkZCBhIG5ldyBsYWJlbCB0byBiZSB1c2VkIGZvciB2ZmlvX2ludHhfZW5hYmxlKCkgZmFpbGVk
IGNhc2UuDQo+Pj4+DQo+Pj4+IEZpeGVzOiBhOTk5NDY4N2NiOWIgKCJ2ZmlvL2Rpc3BsYXk6IGNv
cmUgJiB3aXJldXAiKQ0KPj4+PiBGaXhlczogYjI5MDY1OWZjM2RkICgiaHcvdmZpby9kaXNwbGF5
OiBhZGQgcmFtZmIgc3VwcG9ydCIpDQo+Pj4+IEZpeGVzOiBjNjJhMGM3Y2UzNGUgKCJ2ZmlvL2Rp
c3BsYXk6IGFkZCB4cmVzICsgeXJlcyBwcm9wZXJ0aWVzIikNCj4+Pg0KPj4+IFNvdW5kcyB0byBt
ZSB0aGUgY29ycmVjdCBGaXhlcyB0YWcgaXMgdGhlIHNhbWUgYXMgZmlyc3QgcGF0Y2ggaS5lLjoN
Cj4+Pg0KPj4+IEZpeGVzOiBjNTQ3OGZlYTI3YWMgKCJ2ZmlvL3BjaTogUmVzcG9uZCB0byBLVk0g
aXJxY2hpcCBjaGFuZ2UNCj4+PiBub3RpZmllciIpDQoNCk9LLCB3aWxsIHVzZSBpdC4NClByZXZp
b3VzbHkgSSB0aG91Z2h0IEkgc2hvdWxkIHBpY2sgY29tbWl0IGE5OTk0Njg3Y2I5YiB3aGljaCBm
aXJzdGx5DQppbnRyb2R1Y2VkIHRoZSB0aW1lciBsZWFrIHdpdGggYSBqdW1wIGxhYmVsIG91dF90
ZWFyZG93biwgdGhlbg0KYjI5MDY1OWZjM2RkIGFuZCBjNjJhMGM3Y2UzNGUgd2hpY2ggdXNlZCBv
dXRfdGVhcmRvd24uDQoNCj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8
emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+DQo+Pj4gTG9va3MgZ29vZCwgYnV0IHNlZSBz
b21lIGNsYXJpZmljYXRpb25zIGJlbG93Lg0KPj4+DQo+Pj4+IC0tLQ0KPj4+PiDCoCBody92Zmlv
L3BjaS5jIHwgNCArKystDQo+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vcGNpLmMgYi9o
dy92ZmlvL3BjaS5jIGluZGV4DQo+Pj4+IGFiNjY0NWJhNjBhZi4uNTRhODE3OWQxYzY0IDEwMDY0
NA0KPj4+PiAtLS0gYS9ody92ZmlvL3BjaS5jDQo+Pj4+ICsrKyBiL2h3L3ZmaW8vcGNpLmMNCj4+
Pj4gQEAgLTMxNjcsNyArMzE2Nyw3IEBAIHN0YXRpYyB2b2lkIHZmaW9fcmVhbGl6ZShQQ0lEZXZp
Y2UgKnBkZXYsDQo+Pj4+IEVycm9yICoqZXJycCkNCj4+Pj4NCj4+Pj4ga3ZtX2lycWNoaXBfYWRk
X2NoYW5nZV9ub3RpZmllcigmdmRldi0+aXJxY2hpcF9jaGFuZ2Vfbm90aWZpZXIpOw0KPj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gdmZpb19pbnR4X2VuYWJsZSh2ZGV2LCBlcnJwKTsNCj4+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQpIHsNCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byBvdXRfZGVyZWdpc3RlcjsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Z290byBvdXRfaW50eF9kaXNhYmxlOw0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4+PiDC
oMKgwqDCoMKgIH0NCj4+Pj4gwqAgQEAgLTMyMjAsNiArMzIyMCw4IEBAIHN0YXRpYyB2b2lkIHZm
aW9fcmVhbGl6ZShQQ0lEZXZpY2UgKnBkZXYsDQo+Pj4+IEVycm9yICoqZXJycCkNCj4+Pj4gwqDC
oMKgwqDCoCByZXR1cm47DQo+Pj4+IMKgIMKgIG91dF9kZXJlZ2lzdGVyOg0KPj4+PiArwqDCoMKg
IHZmaW9fZGlzYWJsZV9pbnRlcnJ1cHRzKHZkZXYpOw0KPj4+DQo+Pj4gWW91IGFyZSBjYWxsaW5n
IHZmaW9fZGlzYWJsZV9pbnRlcnJ1cHRzKCkgd2hlbiB3aGF0IHlvdSB3YW50IGlzDQo+Pj4gdmZp
b19pbnR4X2Rpc2FibGUoKSA/IEJ1dCBJIGd1ZXNzIHlvdXIgdGhpbmtpbmcgd2FzIHRvIGNhbGwN
Cj4+PiB2ZmlvX2Rpc2FibGVfaW50ZXJydXB0KCkgd2hpY2ggZXZlbnR1YWxseSBjYWxscyB2Zmlv
X2ludHhfZGlzYWJsZSgpDQo+Pj4gaW4gY2FzZSBJTlR4IHdhcyByZWFsbHkgc2V0dXAsIHRodXMg
c2F2aW5nIHRoZSBkdXBsaWNhdGVkIGNoZWNrLiBUaGUNCj4+PiBNU0l4L01TSSBpbiByZWFsaXpl
KCkgSSBkb24ndCB0aGluayB0aGV5IHdpbGwgYmUgZW5hYmxlZCBhdCB0aGlzIHBvaW50Lg0KWWVz
Lg0KDQo+Pj4gTGV0IG1lIGtub3cgaWYgSSBtaXN1bmRlcnN0b29kLg0KPj4+DQo+Pj4+ICtvdXRf
aW50eF9kaXNhYmxlOg0KPj4+DQo+Pj4gTWF5YmUgJ291dF9pbnR4X3RlYXJkb3duJyBvciAnb3V0
X2ludHhfZGVyZWdpc3RlcicgYmVjYXVzZSB5b3UgYXJlDQo+Pj4gbm90IHJlYWxseSBkaXNhYmxp
bmcgSU5UeC4NCj4+DQo+PiBvciBzaW1wbHkgZXh0cmFjdCBmcm9tIHZmaW9fZGlzYWJsZV9pbnRl
cnJ1cHRzKCkgOg0KPj4NCj4+IMKgwqDCoCBpZiAodmRldi0+aW50ZXJydXB0ID09IFZGSU9fSU5U
X0lOVHgpIHsNCj4+IMKgwqDCoMKgwqDCoMKgIHZmaW9faW50eF9kaXNhYmxlKHZkZXYpOw0KPj4g
wqDCoMKgIH0NCj4+DQo+PiBhbmQgYWRkIHRoZSBhYm92ZSBjb2RlIGJlZm9yZSBjbGVhbmluZyB1
cCB0aGUgaW50eCByb3V0aW5nIG5vdGlmaWVyDQo+PiB3aXRob3V0IGFueSBuZXcgZ290byBsYWJl
bHMuDQo+Pg0KPkFuIGV2ZW4gYmV0dGVyIG9wdGlvbiBpbmRlZWQuDQpXaWxsIGRvLg0KDQpUaGFu
a3MNClpoZW56aG9uZw0KDQo=

