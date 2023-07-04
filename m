Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A20746704
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 03:58:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGVHc-00060z-TF; Mon, 03 Jul 2023 21:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGVHb-00060V-9p
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 21:56:47 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGVHY-0004Pj-MW
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 21:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688435804; x=1719971804;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VuIszMBe5wJaM3pHUKuOKNrB3+lClgPHUyUI66ejMoA=;
 b=JJTcRuvK1aF2JnGqjrC+frEJcHkc4rYhZAEmeKF4NQmiUs2+0iM8V2ZP
 Nx49j1WmqScVA5TpCwJL+AxkL0NDUouQdnHJeSLC4+aIL/24NDf6+DXJI
 y19v6+od/Gp2Q/aENiRfcMLhOrR2iON+GOHzQfrZWmlScZ+3J/X8Zvt7V
 7Qx/519j1uVSBCH1HRpcvtgTlgHMQ6B59Fpu2suvMQCZgPLEIVKVyIsam
 G6kbv8ydaaKZEc3eSyiVphGqBozJ9X61ZorYnEXAq2I/qiuddGjKq85Po
 HV/hCnkQwcPhSyBF61I99ZOTO8KyZTwao7aPYErbjXBFCqhrH8bwiehcx g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="360485205"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; d="scan'208";a="360485205"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2023 18:56:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="863243112"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; d="scan'208";a="863243112"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga001.fm.intel.com with ESMTP; 03 Jul 2023 18:56:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 18:56:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 18:56:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 18:56:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evaHd5gf4xxyizaU+Wk+FEH4wk2IGW16y8UFltquG2sZfhp9QG4L+7AU21V93w9BzSL4qpc+ShvES6dpZBdMwENmkQCZSi68lV3wGJUtqDc7yIgMpRp7YXipZtnOIqkpp9rOI1v5DfGJrnsCjHnAsAmKFWtQjBUEFRTohKiABYmfZgKsC2BXctXwyun9K9usL/ZsXv/dEuvHfjwgoTX+A/TdVSlghBCOKQ9536q6nmbHbYNUt1J2eUjHsEf2qfGS0g5Zr1tkIDscQScc1L8QDEmExrUNUQgM0LY3CP0unDWaVqJKuNKLbGyO7xFq2Hb/ZXn2oQwFlI1YVKDzdnHvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuIszMBe5wJaM3pHUKuOKNrB3+lClgPHUyUI66ejMoA=;
 b=KPUgpbw5MMCqdSN5GrgDMkwhwDtBggbJiG5Nw0rYHW7xjKtUORern67Czu3Usme3fqkCgRupzM6cpW8LXI5g36/5aElFQzRZTRhfNssiLvYqd0hbGdGkd0OQugHIZyoj098z0Yb6LIXuk7tj6sU245ovwxStxpsZF+S8T1gxc3GX2OtcaO1yiYdB5b5yDfVcnJ7mR8GQn1vvbqpgMSYPooFZu5m5gknyF0QO2H1z6aTS60g4VW2Dw3GouJRFmKMF4jeDPq1JR4a4R7m0kuztqNuOYKXomewPXXHTyl+1WJ+QVttCp1MvYMxV5v0Q32MiJrTzVYHRYBAuLPw6CCDdRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB6624.namprd11.prod.outlook.com (2603:10b6:a03:47a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 01:56:20 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 01:56:20 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 5/7] vfio/migration: Free resources when
 vfio_migration_realize fails
Thread-Topic: [PATCH v6 5/7] vfio/migration: Free resources when
 vfio_migration_realize fails
Thread-Index: AQHZrX/zicQvDye0nUCHuONYtTXCNq+oL5KAgACkvsA=
Date: Tue, 4 Jul 2023 01:56:20 +0000
Message-ID: <SJ0PR11MB6744A5BF1CDE18DCAEF3AEE8922EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230703071510.160712-1-zhenzhong.duan@intel.com>
 <20230703071510.160712-4-zhenzhong.duan@intel.com>
 <26823c6a-cc90-3a87-c427-f16be1b99c66@redhat.com>
In-Reply-To: <26823c6a-cc90-3a87-c427-f16be1b99c66@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB6624:EE_
x-ms-office365-filtering-correlation-id: 39968b7d-ce17-47ec-b2eb-08db7c31dce8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nPiCLvu/6fMV5rsFMwSuLd181Ez+uE9KxgfqjuTadVptyYoW5wWkAZXz0xg2viL02aES1RN2JP6gNPIDRjX0hgY2ODYDWMRAFOwO85kh5ueg69Qu7zGP1w42i5DT6jLkXjgrW4WT+6mOZNK53r6zi9dScAEvtDF0Zwyoh2yyp78d4bNSxKJH/4N4l25eUgXontDmVevQY+GkkdZNCo1fCjW0cZJfKsN3s1dXHCh4pVK5a1hpWlucjW+TT4QXmHiqkLveLZFJmorLKuY7Cg6GA2aZ9tVzVpyl6dqsBAs2KcwtOKNsR4AhZGqXypyXf3v9DUGeH8j9GdZWmra2p3MnpugoUylRSUU10A1TnCCZXipCn6JilC1l1eLnvVgBJTiRKrwVh+9a0L7Bk4x25hKkfLqLYjOrumOlSyW3qJBrcv14J81r/fVy8Gr98HJ9bgu1oFTdEe/X7aAqU2baGG+JFAGt/V+qm5EDsf6J9Z9QVmpsYUFqL8POwgPhpd0f9wZQ3xEFTOfUyzBIrfFdtiPnPlK/ZycwWQICp3OngOfosPtywVYQfkixIAk4cVxZIMPRpIX284WqEpMS4op95cv+R7J6Rbi2X1tghPrvwkPtq93r5bdO9NDUmb031wfS19fX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199021)(26005)(41300700001)(110136005)(7696005)(38100700002)(71200400001)(122000001)(82960400001)(83380400001)(107886003)(186003)(66574015)(6506007)(9686003)(55016003)(54906003)(38070700005)(86362001)(316002)(478600001)(2906002)(66476007)(66556008)(33656002)(64756008)(66446008)(4326008)(66946007)(76116006)(8936002)(8676002)(52536014)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXg2dzJIR0lBdWZteUdldmpRSjlMeHFEZ0FkRFF0akZuRkd1ZEppRzVxTWpw?=
 =?utf-8?B?UHVxVWwxay92clpqSUxrcE9kZStUN2hRcWlYT1docDk4REtKVG5zbWJ2ZmQv?=
 =?utf-8?B?NlBCVDdscHc0RGw5dE5CeDdaYzloejJqR1FhQTJZcjMySERmTWdQa1IvRnRn?=
 =?utf-8?B?dGEwYTBvMkE3MGVmLzlWT2t3Q2dMWFpKVS9uVkdJZkhlSWxJZDJNNzkydVNj?=
 =?utf-8?B?TVMzeDhRbXM1akxRMHhBNkJqc1pTSEpsY2RrWjNmTjNJbEJhV3gyelZCTkVE?=
 =?utf-8?B?dnptdklpdzRwMGtnVzFDSUQvREd6OW9nekVpQ0NoZkRJdU5TakVvR2E1UlVF?=
 =?utf-8?B?bmg2SFFHN3IvNXBteVFBRzVCbW1DM3J2ek1PWlRodlVOeFM2ZFJZa1ZxUjRy?=
 =?utf-8?B?RUVCdmJBUkE3ZTB2ZVphTWdaNWV5emRZV01ITzZLWEpjRkFEdXJTTzhpamE2?=
 =?utf-8?B?YUNpK2xuNTJlR3loV01LYm1XMXArM3E4SUVEZlU1OU9XTVFPRlV0eWUyd04w?=
 =?utf-8?B?dmVDQjJLamNkcXpnOWJNaHA1SW01aXpXU0s5aEFSdHFNMElyZVU4czk5UldN?=
 =?utf-8?B?eVlMTHIwcThqZ1pwYWR5UmpsZWhKdU1sUVJ2ZDBFR0xiNkg1dWthKzQ4UVhj?=
 =?utf-8?B?NTd2ZXpZUCtIdDJxKzJsOVd5S0ZNUXZqRjBSb1BJRlFKU2tpMlNZeU9BTlFU?=
 =?utf-8?B?aFBJdkwvR0NyamcvUy9qZTFHanJ0eGNwS2dUY1JsdHk4TnUrclBoTnlqZnky?=
 =?utf-8?B?Vmk2R2ZObFZHZWdmbzdhalNlMTE3M3JtcTR3d0xHMFc1bENObGlHdmJVZ0h4?=
 =?utf-8?B?aTA5dm9BelIyMkJjV3kveUJtZ1hZVjY2di9Dakh5aUg5S0MxS0NVV3ZkSFhv?=
 =?utf-8?B?QkxodUdWUHNRZGRxaVBRaVdHVjlRRFVBSTlXOUJsbTBGQ0JlLzdEdW5jSzJu?=
 =?utf-8?B?NlpBZFdQTTI3VlBrQWR3ejM3cUVCclNFTkwyT3Y0TDFmZUtwRU1ISE9tRlJq?=
 =?utf-8?B?RFNlREdqWUIvUGoxeU92U0FkSGxrNmQ2TWVKd1BqZ3BIZ3pMaXlrTXE5djRy?=
 =?utf-8?B?N1dhL3hnT3dsZlU3NGJ4YWNrd3Y2LytMbUZ3Q3hGUy9pZ2RvVTdDcGh5R0VQ?=
 =?utf-8?B?T0ExemxsSWR5OEZlcHVqbzEvZ3pWZU1xM2IrMGpmWUU0ZTYyRno5SFdSV3Va?=
 =?utf-8?B?VXZsTGhuc2JpWTdIR0hIMHVmSFJ1cUp1a01BeW1OMmtKNDczUlR0RjhxT21L?=
 =?utf-8?B?UkVaK09mS056ZDFDOFd3RWxQYndMQk9aQTY3L3NSWDk4azRkM3lVOXd6a2NE?=
 =?utf-8?B?ZGx0djdGRzRPQ09WYzRkbTNrREhIMHRiTk1UblljWGlSd3daRUdraWNVWmVF?=
 =?utf-8?B?cVMvYmgwZ1gybnhZcGhDRWh1aXNIdzBCcC9yOC9tQXpTalpXRnY0dU9ldkd4?=
 =?utf-8?B?UXBhSGhMS1pSZ2QzaUpBaTAvZDNISnFlbktFL1lKdm1VVG5rdWRxUEVsK25J?=
 =?utf-8?B?M1ZWZzBhbnA2Ty9nYVNXb2ZvTkRsYzVhQ01NWmc3ZGZwRUJvNXBqRktxVnBv?=
 =?utf-8?B?aUtsZUkvMTNtYjM2em4vZjA1M3JDc1pwWlNjT3NSUy9hTlBHaktUWm1iMDhP?=
 =?utf-8?B?L1RWZEU0TzZha0JSRVp6Z1E2ai9hTDFHMDlwRWlTYnBYaHZQNEVpQkxId2F2?=
 =?utf-8?B?bkM3ZlRMWXNHbkd4QmdMaW9FOUs2K0tQMUwwMlYvYmU2eElvYnBJSGd4RlAy?=
 =?utf-8?B?RXJoUyt0dVRuQlZXbTFscmFzeFpBNTEwelMyLzhsbHMrRFJrQmMzVTFsZkZH?=
 =?utf-8?B?UElVMnhXVEduS3RQYm5JM1pNbUxNczdjMU1pcWVTQVlNNmFSNVQ2U0MrSzJ4?=
 =?utf-8?B?VFd3K2xWL21xNC96VStHYlFUbWo4eDRWUVdUbythOVV3S3BOUThvNVViU1Qz?=
 =?utf-8?B?TUJDaHZPdEZOTGppTTZiQURWdUY0bEJzaTZTeDFyNWN6SHMyYTJnbGdpcko5?=
 =?utf-8?B?TDMrVHpvdHJFcnpSSjVJenRtdkw4ckZpV0hUNmdmT0hhN1A3bTF5RG1GWkho?=
 =?utf-8?B?c2pFZElpVlVmMnZKVjlUQ0lHQk1xUWhxVUgva2luRkIxMUJYb1Q2dXh6cHlZ?=
 =?utf-8?Q?xIG42oXsrEY8AO/P0quspzAQW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39968b7d-ce17-47ec-b2eb-08db7c31dce8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 01:56:20.4171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIyuVHV5IZvJNTfcF9Z6olwut0A6gSDbifF7RRtmPxmM9wzV0F/00votXc3iEK+Gh1S6QaAFscsC91T/uhulV2jWK5hiJ1fm70Kaw1vSUsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6624
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=zhenzhong.duan@intel.com; helo=mga11.intel.com
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNs
Z0ByZWRoYXQuY29tPg0KPlNlbnQ6IE1vbmRheSwgSnVseSAzLCAyMDIzIDExOjQ1IFBNDQo+U3Vi
amVjdDogUmU6IFtQQVRDSCB2NiA1LzddIHZmaW8vbWlncmF0aW9uOiBGcmVlIHJlc291cmNlcyB3
aGVuDQo+dmZpb19taWdyYXRpb25fcmVhbGl6ZSBmYWlscw0KPg0KPk9uIDcvMy8yMyAwOToxNSwg
Wmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBXaGVuIHZmaW9fcmVhbGl6ZSgpIHN1Y2NlZWRzLCBo
b3QgdW5wbHVnIHdpbGwgY2FsbCB2ZmlvX2V4aXRmbigpIHRvDQo+PiBmcmVlIHJlc291cmNlcyBh
bGxvY2F0ZWQgaW4gdmZpb19yZWFsaXplKCk7IHdoZW4gdmZpb19yZWFsaXplKCkgZmFpbHMsDQo+
PiB2ZmlvX2V4aXRmbigpIGlzIG5ldmVyIGNhbGxlZCBhbmQgd2UgbmVlZCB0byBmcmVlIHJlc291
cmNlcyBpbg0KPj4gdmZpb19yZWFsaXplKCkuDQo+Pg0KPj4gSW4gdGhlIGNhc2UgdGhhdCB2Zmlv
X21pZ3JhdGlvbl9yZWFsaXplKCkgZmFpbHMsDQo+PiBlLmc6IHdpdGggLW9ubHktbWlncmF0YWJs
ZSAmIGVuYWJsZS1taWdyYXRpb249b2ZmLCB3ZSBzZWUgYmVsb3c6DQo+Pg0KPj4gKHFlbXUpIGRl
dmljZV9hZGQNCj4+IHZmaW8tcGNpLGhvc3Q9ODE6MTEuMSxpZD12ZmlvMSxidXM9cm9vdDEsZW5h
YmxlLW1pZ3JhdGlvbj1vZmYNCj4+IDAwMDA6ODE6MTEuMTogTWlncmF0aW9uIGRpc2FibGVkDQo+
PiBFcnJvcjogZGlzYWxsb3dpbmcgbWlncmF0aW9uIGJsb2NrZXIgKC0tb25seS1taWdyYXRhYmxl
KSBmb3I6DQo+PiAwMDAwOjgxOjExLjE6IE1pZ3JhdGlvbiBpcyBkaXNhYmxlZCBmb3IgVkZJTyBk
ZXZpY2UNCj4+DQo+PiBJZiB3ZSBob3RwbHVnIGFnYWluIHdlIHNob3VsZCBzZWUgc2FtZSBsb2cg
YXMgYWJvdmUsIGJ1dCB3ZSBzZWU6DQo+PiAocWVtdSkgZGV2aWNlX2FkZA0KPj4gdmZpby1wY2ks
aG9zdD04MToxMS4xLGlkPXZmaW8xLGJ1cz1yb290MSxlbmFibGUtbWlncmF0aW9uPW9mZg0KPj4g
RXJyb3I6IHZmaW8gMDAwMDo4MToxMS4xOiBkZXZpY2UgaXMgYWxyZWFkeSBhdHRhY2hlZA0KPj4N
Cj4+IFRoYXQncyBiZWNhdXNlIHNvbWUgcmVmZXJlbmNlcyB0byBWRklPIGRldmljZSBpc24ndCBy
ZWxlYXNlZC4NCj4+IEZvciByZXNvdXJjZXMgYWxsb2NhdGVkIGluIHZmaW9fbWlncmF0aW9uX3Jl
YWxpemUoKSwgZnJlZSB0aGVtIGJ5DQo+PiBqdW1waW5nIHRvIG91dF9kZWluaXQgcGF0aCB3aXRo
IGNhbGxpbmcgYSBuZXcgZnVuY3Rpb24NCj4+IHZmaW9fbWlncmF0aW9uX2RlaW5pdCgpLiBGb3Ig
cmVzb3VyY2VzIGFsbG9jYXRlZCBpbiB2ZmlvX3JlYWxpemUoKSwNCj4+IGZyZWUgdGhlbSBieSBq
dW1waW5nIHRvIGRlLXJlZ2lzdGVyIHBhdGggaW4gdmZpb19yZWFsaXplKCkuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4N
Cj5UaGUgdmZpb19taWdyYXRpb25fcmVhbGl6ZSgpIHJvdXRpbmUgaXMgc29tZXdoYXQgZGlmZmlj
dWx0IHRvIGZvbGxvdyBidXQgSSBkb24ndA0KPnNlZSBob3cgdG8gaW1wcm92ZSBpdC4gTWF5IGJl
IGNvdWxkIG1vdmUgdGhlIHZpb21tdSB0ZXN0IGF0IHRoZSBiZWdpbm5pbmcgPw0KDQpJcyB5b3Vy
IHB1cnBvc2UgdG8gcmVtb3ZlIHZmaW9fdW5ibG9ja19tdWx0aXBsZV9kZXZpY2VzX21pZ3JhdGlv
bigpIGZyb20NCnZmaW9fbWlncmF0aW9uX2RlaW5pdCgpPyBPciBvdGhlciBiZW5lZml0IEkgbWlz
c2VzPw0KDQpUaGFua3MNClpoZW56aG9uZw0K

