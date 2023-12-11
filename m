Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D72E880C114
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 07:00:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCZKl-0005U9-BM; Mon, 11 Dec 2023 01:00:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCZKh-0005TJ-JB
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 00:59:59 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCZKf-0005hg-Al
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 00:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702274398; x=1733810398;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HbMtRDmyQFfQScgSdu+zSCMRKu/4LU1GAQ3LT6SPrEQ=;
 b=W1dZ85XpZ9MOmhSmM4+XmYhZND7An259JTM3iHXqSQBl3O21xLbqtCcB
 SlX5W30Z+w79nyBUbn8r1d1nO9AXHqvwiiK/nNy/bixxBZGsqLut9tZix
 9j3XaSQcIVn7JkGDr2NSYLQdOI0POpN9oSr42/6viMjPvLIaWtCRc5euk
 sSEukT3NZ5+RkvcnOJKcGIWpQbaqZ74lbVZCC97TdzKETlOmxZTG/nXmh
 YaWjDdFgFfmeRPMSFZhECspmTA3T1XrLr8XAY0jO7pkxmzwXwDbu+K5xJ
 mH9VwRxxDcFFFid6GIvgBjBRv+Xu+Viq2ACbRYi6sMVY/fe9COw6VF+RG w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1724709"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1724709"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2023 21:59:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="801870698"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; d="scan'208";a="801870698"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Dec 2023 21:59:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 21:59:50 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 21:59:50 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 21:59:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVMP/+O0gRt84FYn+Q4VD9LcCivYnYAJ7OuS6s19eplwoz+Yh87+TCiru29FR/aMHywcCZItAuwBPBYviMpBPPLjwKyUQA2CxiCOWmYYI5UhRjCBCgz4T9n9XOmay/GqitN9YaGUfnSep1QbtV2DFwhrHalNcDwilOCEV7nPy3ZO820kuvHUil8qcvj/tqdl583o2DuiKNfw5TBIQM6YPm1JU1jw4bcOCoMo/EOht3PIYnG2D3voTlGW76riFxHYDRBn43z+7sORQ0qFuK0qu7S0iscsHxVUoPNm+z9e9jo0Oes4liTZhE4zpsaA5RiocH2aKEoCPwOqOzot++oT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbMtRDmyQFfQScgSdu+zSCMRKu/4LU1GAQ3LT6SPrEQ=;
 b=Ro+h4fNBQ5NAVX2e1dyC31Ddyr2psPdy855a4z5GWoSXCzJ08dc9F8KM0vKiIc6oL5+0kFxh3eAbTSglleOlIrBnRm4lNksJohas94dWaH4ZXVij397EOdNlIj9Lu0vx/CZOex6jwU1N5+CVdvYQbqevuYyHdE+gldCvVn9q9lqIeOZblx1WptzLoyYC89W8Pw0zCh+rUCW0V58bnIxpmLRL41WkpRhT63PnAlVVkeXjrR0cRbeaJiI8JhrVX+eWhdVDbDmkhOHdqFchKNxJgwmd/tnF6jelHEba0w89po+F82825rHQsiWMishkETdIroa/4FIIfD712eJAKTDxRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB5577.namprd11.prod.outlook.com (2603:10b6:510:eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 05:59:48 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 05:59:48 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>
Subject: RE: [PATCH for-9.0 03/10] vfio/container: Initialize VFIOIOMMUOps
 under vfio_init_container()
Thread-Topic: [PATCH for-9.0 03/10] vfio/container: Initialize VFIOIOMMUOps
 under vfio_init_container()
Thread-Index: AQHaKbMoNBt6I0DuEUW5IKl+t8GtULCjmW+A
Date: Mon, 11 Dec 2023 05:59:47 +0000
Message-ID: <SJ0PR11MB6744ADC5CD40D8CF8013EEA8928FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231208084600.858964-1-clg@redhat.com>
 <20231208084600.858964-4-clg@redhat.com>
In-Reply-To: <20231208084600.858964-4-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB5577:EE_
x-ms-office365-filtering-correlation-id: 3bd2e309-a0dd-4c8f-a971-08dbfa0e61bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IGSK4ZmXQKzhKnWpFnMiswoJnD6WBBWi4bu/czcTsrh8xWMCAQMEgH/DhpGiuv48dKMpXO38RWYouWszVpVfNaOXlK3YPOZQt8BJI42A6BDHzDxvslHLtYY9en0dDZTnYMFTz6OR5sGrtgh7MknzvHTgqpXOCdMXxgKkdYegxrBPpMh+lVm0+NsFbMFagoO8FJDuZRFTfSIpUj03neUSxh6zGT+OQ3PEGmNz48NFc7ZbRDmfqtAofEr1a+rJXA9RL/1Q59UL3hnWcJIr3PkXlIncTQ6rfwjEj9PndGRS70+ypF5cD3h7T3ZMC0Wi93OUvZPLW70KqbYT+cX6rYw2AXV+SeKOXttAxBt5pqn2B4swItapYzy+2TZTpN3Zv/iKNdjg32iOZESIz7pU+z01xoBkll0juGEHV0aELk2xajzV3iGKDns+nGPzVxdfz50H+CXp04ymCDHHSArYNhuu45khgFqIR6OS6slF3kZNrdNiPuxgchI7xyrY3lCbv+co4PbXARAC5A4417yJKfeaXgfgaMM/IwxV2nOZZc1mzON8I7hiGz6Wk/nnniOiLoWZP8x7vX7HKwWBxr7rgEy1lCSpap6a8LSHNRh505PeVUIEvrh8q89jgfmdOHF39WiU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(55016003)(41300700001)(38100700002)(2906002)(5660300002)(316002)(4326008)(52536014)(8676002)(8936002)(76116006)(38070700009)(66946007)(54906003)(64756008)(66446008)(66476007)(66556008)(82960400001)(9686003)(33656002)(86362001)(110136005)(122000001)(83380400001)(26005)(71200400001)(478600001)(7696005)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHVkUThwTEpzWnRUVURqTEFJRDRic1poQWdtMnI1anZ4UEZQdUxJWnI2emoy?=
 =?utf-8?B?VGQramFVUlhjZzJtMXBoMHZINSszRmFkeUJSTjNXaFlMVTlERE9waDBic2pP?=
 =?utf-8?B?b3QrZUJwTXhKTlcva05PV21BdHNCZ284Smd0bG9YMzBtYk0ycC8vVXVvM3lB?=
 =?utf-8?B?M1UraGtLWFBwT2lQcCtXNjg3cDEzQ2t4TkM1TDBaa05MWnluSkhZTXZjU25k?=
 =?utf-8?B?UHJWYXdGTkJwTE1WNjlocDRUN1pvMXRraGd6ZjJBa0FybjZVZEp0amE3SDN0?=
 =?utf-8?B?V1IwZHIrUWZFZTBiNGRWVW5IRms2ZzA1c2pGVzNkcTBpNGMyVHl0TTg3K3hL?=
 =?utf-8?B?K3kxbzNPOStMNXBXeWxTM0lZVE1XdGZXanVqL3pEQVBkRjBCTithTUMyVkJ0?=
 =?utf-8?B?eUIzbXRUdUdvMEdoVnpCdkN4Z2xLUDQ3SmVZSWpxcHMzMmpSZUdYWm5yeU9t?=
 =?utf-8?B?cFNrbDRqTDZ5SHlSY0t2SG51eWFOUVBLMlgyd04rcnh5dkJKN2F4TkZEWGZT?=
 =?utf-8?B?aDZvUnU3cVphOFJoWnl5aVNIWEdEU1JUWHJST1FoZGVwWnpXaXNCREgvbm9o?=
 =?utf-8?B?NVRxZ0hINmxHTzltV0lHRC8xRjVFSnZlc1ZqZHJ0VWtVOE1NWlp2V3JRdUtB?=
 =?utf-8?B?dE5kekVwMVNQRmQ0dHBJWm10cnVVOEZvbExlM202YUFZREFJZXNQWXRWUE1H?=
 =?utf-8?B?YXZsTGQ2ODNncnRVa0xqTDJveTQ0dXU4RUgvREhHU0Z5ZjZLSW9PZWdUeXAv?=
 =?utf-8?B?SHJ2dDZWbkRUTmVDdWdVUlUyajlON3M3dXA2Qk84alpOZ2N3T2xIZ2hpNlBo?=
 =?utf-8?B?ZUsxNHJRdFU0bmRUUmVVRmJZWDJDOE14WG9DWWpFb08zZDhIOUVQQVJZaXg0?=
 =?utf-8?B?VlRxN1poWVJwV3hvWjJmNmZUU1BWRC9GbUVUbVZOV1ZEb3AwRkVQcWRLRzBT?=
 =?utf-8?B?WVdGc2E1RmJLMzlyY0hvdVh0UzlYVjBlOEdJeDZDMi9BMTloQlFrMUZrbnpx?=
 =?utf-8?B?aUdmT0NwbWpyMVZScVltam9QeHFtWEdpL2xjTWkwcW5SYVZ4TFFnV0tLRUI5?=
 =?utf-8?B?OEo1ZEtveUJSbUtweXRLRDNscUUxTGtlSlRSR25aNFRuMXZDQlFlQlU1aUVK?=
 =?utf-8?B?L0VIdVg2VHJkR01zYytERk1JeWY3T080U3ZJWSt4SmhwRmk3d2dpcmw5OFc0?=
 =?utf-8?B?dys2cVpQTi9nUS9EODk1Ri9jL2hiMm5iTktmSHk3TDRwM0FHWVR4SzVKUXpF?=
 =?utf-8?B?b29HTXp2TGIvNEZOeVFwNi9aWkxyZGpxUElQVEtIWkp6YXh0MG43WE5HamZa?=
 =?utf-8?B?N1U2dG5KQmg3RzltQ1BmUWtta0Jna2UvdFFzNUt0UmVWSlpMS2RVSDVWL29Y?=
 =?utf-8?B?WUl6Zys3RndXS1BZSGtUTDdTcmNPcmlRWkpFL3ErNWdCNHQ4Q3hwSzBjUDFK?=
 =?utf-8?B?bXdzRVNmMFJVaUVySXU3YTc3ZVkzS3Y3OE1nNHJ3MmpUaGhCaXhIbmdlcTRa?=
 =?utf-8?B?Z2NORVNpVmYvdUt6NS9acTZNSEREdUkyMnNra09qd0IzQmVEYkwzaUp2VFVP?=
 =?utf-8?B?T25FaTVxZXRuZ0Y3OGU4R2dnOWtCazg3eDdJZkV3bmd1aitFdXZCQTdJendz?=
 =?utf-8?B?cmV6MVlycUlYMU0zblRPSk1rR2s1alVDZFhlRXVkREJQYmVVMkVsdHI1SDFq?=
 =?utf-8?B?b2xsblU3dkNyaHRNOEozZUEzeld3V2xGYUlvdmVGRGRtMlIrSkZySEpEcE56?=
 =?utf-8?B?WDhVbnJvVkljVmpOZkpFNURENUVCREk2cUFnRk96Uzl4bjFqRElLSEhqZEh0?=
 =?utf-8?B?YlhsNzAxTHdYVGVWRkp0UmFCbGR3RUJVUlF0VnJPZWIreEExSjlFaEw0NW5L?=
 =?utf-8?B?amxGTE1ueUVLbWJWaDNJY1laSkhzcUx1QkhWeEU4Q3FPaWEwZy9aM1U4OEZI?=
 =?utf-8?B?VDdrLytWMDhCRTBEaUpkWTNydjFyMU81c2d6dm8yUDN6SmxpT1ZkdUVPRTBD?=
 =?utf-8?B?cCswci9raTJoWkxtNzhVakpsU1hNWDYvVWFCekZ3UGRObEhkT3BONEwwRHZz?=
 =?utf-8?B?NFFqaWRTZEM4L0h1K3hJeTByNU10SXZtQlpmRWJLQkRkcmhrelNiZFpqVjBB?=
 =?utf-8?Q?ewvk89JD5PNmWardqlRlYZwQj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd2e309-a0dd-4c8f-a971-08dbfa0e61bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 05:59:47.8840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0h+rod13ZZ5Iv1jQGCYVC43ajsUq9xtEe+NlngPRyA1jTiWJtP/APkcVehfoUUpI130EW+muOkFlYS3tGp77YA5rjVKUZ1/ILad71MUugRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5577
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIERlY2VtYmVyIDgsIDIwMjMgNDo0NiBQ
TQ0KPlN1YmplY3Q6IFtQQVRDSCBmb3ItOS4wIDAzLzEwXSB2ZmlvL2NvbnRhaW5lcjogSW5pdGlh
bGl6ZSBWRklPSU9NTVVPcHMNCj51bmRlciB2ZmlvX2luaXRfY29udGFpbmVyKCkNCj4NCj52Zmlv
X2luaXRfY29udGFpbmVyKCkgYWxyZWFkeSBkZWZpbmVzIHRoZSBJT01NVSB0eXBlIG9mIHRoZSBj
b250YWluZXIuDQo+RG8gdGhlIHNhbWUgZm9yIHRoZSBWRklPSU9NTVVPcHMgc3RydWN0LiBUaGlz
IHByZXBhcmVzIGdyb3VuZCBmb3IgdGhlDQo+Zm9sbG93aW5nIHBhdGNoZXMgdGhhdCB3aWxsIGRl
ZHVjZSB0aGUgYXNzb2NpYXRlZCBWRklPSU9NTVVPcHMgc3RydWN0DQo+ZnJvbSB0aGUgSU9NTVUg
dHlwZS4NCj4NCj5TaWduZWQtb2ZmLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5j
b20+DQo+LS0tDQo+IGh3L3ZmaW8vY29udGFpbmVyLmMgfCA2ICsrKy0tLQ0KPiAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPmRpZmYgLS1naXQgYS9o
dy92ZmlvL2NvbnRhaW5lci5jIGIvaHcvdmZpby9jb250YWluZXIuYw0KPmluZGV4DQo+YWZjZmU4
MDQ4ODA1YzU4MjkxZDExMDRmZjBlZjIwYmRjNDU3Zjk5Yy4uZjRhMDQzNGE1MjM5YmZiNmExN2I5
MWM4DQo+ODc5Y2I5OGU2ODZhZmNjYyAxMDA2NDQNCj4tLS0gYS9ody92ZmlvL2NvbnRhaW5lci5j
DQo+KysrIGIvaHcvdmZpby9jb250YWluZXIuYw0KPkBAIC0zNzAsNyArMzcwLDcgQEAgc3RhdGlj
IGludCB2ZmlvX2dldF9pb21tdV90eXBlKFZGSU9Db250YWluZXINCj4qY29udGFpbmVyLA0KPiB9
DQo+DQo+IHN0YXRpYyBpbnQgdmZpb19pbml0X2NvbnRhaW5lcihWRklPQ29udGFpbmVyICpjb250
YWluZXIsIGludCBncm91cF9mZCwNCj4tICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVy
cm9yICoqZXJycCkNCj4rICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZGSU9BZGRyZXNz
U3BhY2UgKnNwYWNlLCBFcnJvciAqKmVycnApDQo+IHsNCj4gICAgIGludCBpb21tdV90eXBlLCBy
ZXQ7DQo+DQo+QEAgLTQwMSw2ICs0MDEsNyBAQCBzdGF0aWMgaW50IHZmaW9faW5pdF9jb250YWlu
ZXIoVkZJT0NvbnRhaW5lcg0KPipjb250YWluZXIsIGludCBncm91cF9mZCwNCj4gICAgIH0NCj4N
Cj4gICAgIGNvbnRhaW5lci0+aW9tbXVfdHlwZSA9IGlvbW11X3R5cGU7DQo+KyAgICB2ZmlvX2Nv
bnRhaW5lcl9pbml0KCZjb250YWluZXItPmJjb250YWluZXIsIHNwYWNlLCAmdmZpb19sZWdhY3lf
b3BzKTsNCg0KUmV2aWV3ZWQtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRl
bC5jb20+DQoNCk5vdCByZWxhdGVkIHRvIHRoaXMgcGF0Y2gsIG5vdCBjbGVhciBpZiBpdCdzIGRl
c2VydmVkIHRvIHJlbmFtZQ0KdmZpb19jb250YWluZXJfaW5pdCBhcyB2ZmlvX2Jjb250YWluZXJf
aW5pdCB0byBkaXN0aW5ndWlzaA0Kd2l0aCB2ZmlvX2luaXRfY29udGFpbmVyLg0KDQpUaGFua3MN
ClpoZW56aG9uZw0KDQo+ICAgICByZXR1cm4gMDsNCj4gfQ0KPg0KPkBAIC01ODMsOSArNTg0LDgg
QEAgc3RhdGljIGludCB2ZmlvX2Nvbm5lY3RfY29udGFpbmVyKFZGSU9Hcm91cCAqZ3JvdXAsDQo+
QWRkcmVzc1NwYWNlICphcywNCj4gICAgIGNvbnRhaW5lciA9IGdfbWFsbG9jMChzaXplb2YoKmNv
bnRhaW5lcikpOw0KPiAgICAgY29udGFpbmVyLT5mZCA9IGZkOw0KPiAgICAgYmNvbnRhaW5lciA9
ICZjb250YWluZXItPmJjb250YWluZXI7DQo+LSAgICB2ZmlvX2NvbnRhaW5lcl9pbml0KGJjb250
YWluZXIsIHNwYWNlLCAmdmZpb19sZWdhY3lfb3BzKTsNCj4NCj4tICAgIHJldCA9IHZmaW9faW5p
dF9jb250YWluZXIoY29udGFpbmVyLCBncm91cC0+ZmQsIGVycnApOw0KPisgICAgcmV0ID0gdmZp
b19pbml0X2NvbnRhaW5lcihjb250YWluZXIsIGdyb3VwLT5mZCwgc3BhY2UsIGVycnApOw0KPiAg
ICAgaWYgKHJldCkgew0KPiAgICAgICAgIGdvdG8gZnJlZV9jb250YWluZXJfZXhpdDsNCj4gICAg
IH0NCj4tLQ0KPjIuNDMuMA0KDQo=

