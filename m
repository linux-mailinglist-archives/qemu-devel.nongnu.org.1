Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9972832502
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 08:28:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQjHw-0001kz-DE; Fri, 19 Jan 2024 02:27:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQjHu-0001ke-0s
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 02:27:38 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQjHr-0007Ad-IU
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 02:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705649255; x=1737185255;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UaVhMmpTMRvUWf5mUtd8nHKRw8bwWxQdHlPMfMDTse8=;
 b=f5Y0o5/Gw8Ox0SLX4aJZQxRPaONJFQohJcoCTK58pZmrCEAK6D1Q8HwZ
 IgOgbDQaxN1Sj0vQ50jjnT81mQ35eIzwibpTt7T6PTZQnUeFJefuxrOg2
 HSMaDIVWF0btrt8yCidCBFrssAJpHykjR8fsR5xipQDOX5iJ4Ce1qaTbQ
 hIQdDfa+5nbNIant9uqvEJj4mfyVRpVZDgXvrphKE2o0+lSpLvkB1Zz3I
 wLeZEz+H0D3tlvZa2MqFl08ku0Cz9dRhk4u9KW1qpFvultCpk5y95Br0p
 6TpBw+/jtP/8ci5HYCNqbBWSQj5JUITv6cJS6GDnZhLYSsASjeFlEjU+K w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="582756"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="582756"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 23:27:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="734493378"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; d="scan'208";a="734493378"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Jan 2024 23:27:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 23:27:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 23:27:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 23:27:31 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 23:27:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mvlj5Yk0WPgvYVwJI0IpqZbryXSaoa48tt2B9A4wFQmgj4kBRIiT/ByLxjc3KmnxWerIS4xcMF/+Ax64vOzjlQBc77VPphVuD1fYm6myYuEdTCLcncdSttfPS6aZOB8S5ckAQF/hEpTCoC/XXGcyCj2WuByMb1T1e74gUS6oltRGxaOc5wryMlUoQXzLDBtHVu79O8Amdc9ngFAZtEKawRpcXbWaoKBcRHJaLcM9NKaHw6UAxxwX3V8XWgj+pz8GYCCPeYHKoHio6Ghbn/JdeK46kRFWK+KAPHUUGUvFYay4wZgno58F1m2wyk3oSOoaSnwDjs4CqUvIcMIvQWVn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaVhMmpTMRvUWf5mUtd8nHKRw8bwWxQdHlPMfMDTse8=;
 b=Di8CAYE3j/kChDylvln5yYZqocjavStAqcP8E68GHwKpuJnNB6RF4i9zfQkePfZFqKnyjAXE9kQu12CccTVv5DuFOsz/pTWD4uXhMljJnoG71qDRr1UrQ7qZEJDs3CUI1tTUcxwOyDShgApBaMD9o1vm8IZxGueCLl76a5BG7vB4ctxHQs6i8Dfb2/0rUTKDRjGPtxIxRaaR0u6RoGuwyaMKbgtaoZSW/EdbOO3c6Vk2y474kqM9K9rUlpxFCX4+A+9ZVNUXSF55AiP8VE18SfR3lWP2phfqea9MePdcvFGdrmKfUh9yoOmhQlIIPsd3IdXSsVk4/n7OANgUhLKIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA1PR11MB5802.namprd11.prod.outlook.com (2603:10b6:806:235::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 07:27:29 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace%5]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 07:27:29 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH rfcv1 3/6] intel_iommu: add set/unset_iommu_device callback
Thread-Topic: [PATCH rfcv1 3/6] intel_iommu: add set/unset_iommu_device
 callback
Thread-Index: AQHaR5vxspHwco5YmUmE0e1P7iLakbDeKQiAgAEQanCAAEypAIABNWfw
Date: Fri, 19 Jan 2024 07:27:29 +0000
Message-ID: <SJ0PR11MB6744AFB02761BB2F14A4082992702@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-4-zhenzhong.duan@intel.com>
 <4db1ddc3-efef-47ff-bc34-4cb3eb3fc5e9@redhat.com>
 <SJ0PR11MB6744FA461B1033965302689892712@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <c76d4875-4569-4a33-9821-644b608c487e@redhat.com>
In-Reply-To: <c76d4875-4569-4a33-9821-644b608c487e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA1PR11MB5802:EE_
x-ms-office365-filtering-correlation-id: 911f95bc-543b-4687-91ed-08dc18c017d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ps9CsVD9cAnrXfyJ9gnu9ovnEkJAFcI/d9DhHrey2kcqAZuLVpClO/Fj0KgjYMimoN6noTx0a/5OTqLQ19NKevsmnxfrwHvBjz6Xnj/BA5RPwVILVzKR8ZI0bx+bw/FYFujk6uSukEZWO5KowdgGtyimw2DpE8XryBB/xCAttPlstRfs0MRmLc7sKJcRZynbAsktfvIyn9PsNYcNtUfCXTSNXrvzZauL8C3Tw9dzGGk9AU/8iK1hxDsf8alFh2oThhbZj4/vrXAGXqFXz27nKmbEOVdSHe2h8onxJL7FE1mBJIAjw50iFo/qVRC9qJVZXB+RE+N+UdqjotO3N2t7d9R4Ugm9y6SAnGw3U4qoSJvlKCUkD5SzI1vpPH5ymrgOgbKOnDsGPa6osH7D4YGAuRCRy4M3W7xYTp7XVBe72oZDUe0H6NLP9uoUmtNbImV7Gls1m3VzPmJxWiMYq/TweJzHi3ongLRp83Yu+gjc70YXoQqtAyLdv4vhtcGMzCR3Yzr2m3Ty80EfR7V2Cv58Xgv1FVplTKoLXe3xoCE+eyRtLIdIzXuNNuWWd8WyQDSh0QE7X4+bSXhyWrMCTNNPPANqhvHGs1cwoVKjk0p9SUtk0ldmiZmJll8HIi4Vjl+x
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(83380400001)(38070700009)(82960400001)(33656002)(86362001)(7416002)(316002)(5660300002)(53546011)(26005)(9686003)(4326008)(122000001)(8676002)(8936002)(478600001)(110136005)(66946007)(7696005)(66446008)(71200400001)(66556008)(76116006)(64756008)(38100700002)(66476007)(54906003)(41300700001)(6506007)(2906002)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFNEVVptQk82ZkxsR0tSTDlkL1RFa0FGRzBXN3YvbVlzZkRoWnZOY01TYWo2?=
 =?utf-8?B?SXp3NFFzdHdzQkRTaGROTlpSYnF4bDZZNENLbktPSk42ZVlQNzdKdTErKy9H?=
 =?utf-8?B?c3ZwTnZXRFZSQjJXMStJNUdlbDJ4MXpySzlDcGJMYzdtVjBwalhaQUE3M2ZB?=
 =?utf-8?B?YTNzTWI0SWlYanBiZ2s0SXduekFhS0hmY2lNNU8wNTVoWG1vSVZtL08zWFVN?=
 =?utf-8?B?TzdEa2V3TGN5UWNTK2VRSWp5UTlsRWpCLzJ2RG9jc0lTWXh3WXJoUDdNVVVx?=
 =?utf-8?B?VEhJdzN4bmN0aHRGWllzT1M1a1o5dndDNytabWdvQTd1Y214SUd0WGNlMUkr?=
 =?utf-8?B?a24zcnRhb25XQ3g1VEVTVkZnTlZ1NGhuNERRUm96MG9icUZXZitpR0Q1ZFEy?=
 =?utf-8?B?SDFZRzZNNC9ZL1hWVzNRUUZEdW1yOVpJZ3BaNTVOSUc5cFJlRW82L1IwbGtK?=
 =?utf-8?B?NkJpeDFnWlRYdnZpbTlucWs3MVgxZFQ1Mk9Md01rditLQm9tenRTR3hZZDBo?=
 =?utf-8?B?YVV1OThmaWlhMWhlNnhYL0JDemtKemtxWGVJSTNlajdyT25TS202ZmduR0Vw?=
 =?utf-8?B?cW0vSC9LeGk2RTNqRzZCdHlVWUh5R1ZIRmdWbGFnRXVQQ0FHUUFOV2VnajZM?=
 =?utf-8?B?azlLQ25weER6WDJDNHpEckNNQW1zUnQxMzdVTGZDSUlYQVZicDRiWHpuT1NV?=
 =?utf-8?B?dnZOUmJUakhsbVo3dVlGSzdUYk52NkR4VkNCTURPUTljcHlWNzdFUnJlZlRv?=
 =?utf-8?B?d0tkamNxYzlVU1BYOUZwSjREdk9sVWw3ekllSlFjS1o2S1BNSDJEalNZUWx0?=
 =?utf-8?B?ekdlclRFdkhGKzhKV2JyV2FVcEsyRzE4VVhpa2FBNmRLSjg0RkNrVEZLNGF6?=
 =?utf-8?B?YTY2VTZqaG9HWmNEOXVibVpZMTg2UEpKUmRtUGRpZkwvNllmdmNtYUd0YmlY?=
 =?utf-8?B?djhTbVdIcUFsSWVDQ1cxUGF2OFR6Rmo0YlBPWHpXRDc0ck9MS2RpT0hUdVhR?=
 =?utf-8?B?cUdZUTBzR04xcFhkUGVzT2lXVjkwQStpdzB6N0tHUVdTTDhiYnAwTGR2bmdR?=
 =?utf-8?B?WVh0eEx0dEZuWTNETXZCaUM4MVlHS2lLVlV2dStFRFI1enp0RWdRc21GMG5R?=
 =?utf-8?B?Sjc5NXBqSVRNaEhZV00zdGJVcHBCVmdnUXo4bWNMTmJ2ZkpGaEtFdE9EOXMx?=
 =?utf-8?B?YWY3QllBQ3Z1RnVTL25hN29CRzM4eGZYWUcrVTNWMlptQmNqZVhUVFVMZzk5?=
 =?utf-8?B?M2FGZWpTN1hvWXpjSnpNYS9TemxhbGU0YWgyMHFKVFlPYklWUmR6NDlHcXpv?=
 =?utf-8?B?OUR6UEVhYUd1VW9kbWlKNS9LOVhtRExEMWN0Ykw5ek4rQ0hZT1J6MmJuRy81?=
 =?utf-8?B?bHFpSEp0UkVZcE10b1EydFRqQjBFTEFNSU9OWkFOSkZHUVgxbGlob3VRbDBI?=
 =?utf-8?B?WFF6YWpISnZYTXVMMXloVGk2WnhVNW9FbThLL1MvMi83b3FRMkF3QlM1Yjcr?=
 =?utf-8?B?d2E1b29UYXQ4VGgvZzZXSVE4eGd2N2VicFpNVlpKZFBYa2U1dGErc0xDWFcw?=
 =?utf-8?B?d2VnUzhVTWR1OUJ6QjNOWm1hV082cDZGV0FZZ2IwMERKN1E1UmNCRWxXSW9v?=
 =?utf-8?B?cDB4dW5sT0xmejNFR24vdW9meEhwYnllL2c4aWNSS0dIQXFrbFEyQStuVXpB?=
 =?utf-8?B?T3MrUXlFQ1M2Q2M1Zy9SdVc5cWlIai8yOE1HSm1xOUJudVhST00raVNpU0tE?=
 =?utf-8?B?WG8xUlAvY3NQM0FYMXI3d0U3TXFoYU0vYWhNSlNMOEZidmRSNlZOUWJKbE81?=
 =?utf-8?B?Mk5xejAvbUhNWEpPY0t5eDBhTWlJc1pkcE5ra3h3aVdLQnZWSGVQZENiamZu?=
 =?utf-8?B?clBtekxWU1FSbWhYOS9uU2NsT0xtWnd1QkhvcVlPRERpK3phUGQ3UlJ2NUVa?=
 =?utf-8?B?clE0TkxBd21SVFBETSthK3U0ejVPRm5GNEJvSDEvSUhwQXh2TUhQVHk0SDRR?=
 =?utf-8?B?UzFIQWtGRERmUEhrY1E5TVJVbEtPeG9FcmN2KzBoanJSbmFVK2VhdjdmSTRP?=
 =?utf-8?B?QTh5MXNLc0p3TDBDKzZLdVN3RDZwQU1ESTcwTVNKMjRkQXp5RWFhM0dVbkd1?=
 =?utf-8?Q?DpyZ+Knmo6/ioV/y/vBdO+D7L?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911f95bc-543b-4687-91ed-08dc18c017d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 07:27:29.2279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s5MT/rQAlmribz13gR6hxk0kZ94UJAEPpU/IYOMlPiU+SmCt5+sA0k2hO3hPadBnGub9rpQQO5oy4d08U1YU+sR6A18FKj9OvIy2vp1Q4R8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5802
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YxIDMvNl0gaW50ZWxf
aW9tbXU6IGFkZCBzZXQvdW5zZXRfaW9tbXVfZGV2aWNlDQo+Y2FsbGJhY2sNCj4NCj4NCj4NCj5P
biAxLzE4LzI0IDA5OjQzLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pg0KPj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRo
YXQuY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggcmZjdjEgMy82XSBpbnRlbF9pb21tdTog
YWRkDQo+c2V0L3Vuc2V0X2lvbW11X2RldmljZQ0KPj4+IGNhbGxiYWNrDQo+Pj4NCj4+PiBIaSBa
aGVuemhvbmcsDQo+Pj4NCj4+PiBPbiAxLzE1LzI0IDExOjEzLCBaaGVuemhvbmcgRHVhbiB3cm90
ZToNCj4+Pj4gRnJvbTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4+DQo+Pj4+IFRo
aXMgYWRkcyBzZXQvdW5zZXRfaW9tbXVfZGV2aWNlKCkgaW1wbGVtZW50YXRpb24gaW4gSW50ZWwg
dklPTU1VLg0KPj4+PiBJbiBzZXQgY2FsbCwgSU9NTVVGRERldmljZSBpcyByZWNvcmRlZCBpbiBo
YXNoIHRhYmxlIGluZGV4ZWQgYnkNCj4+Pj4gUENJIEJERi4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9m
Zi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFlp
IFN1biA8eWkueS5zdW5AbGludXguaW50ZWwuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVu
emhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+PiAtLS0NCj4+Pj4gIGlu
Y2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oIHwgMTAgKysrKysNCj4+Pj4gIGh3L2kzODYvaW50
ZWxfaW9tbXUuYyAgICAgICAgIHwgNzkNCj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPj4+PiAgMiBmaWxlcyBjaGFuZ2VkLCA4OSBpbnNlcnRpb25zKCspDQo+Pj4+DQo+
Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4+IGIvaW5j
bHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+Pj4gaW5kZXggN2ZhMGE2OTVjOC4uYzY1ZmRk
ZTU2ZiAxMDA2NDQNCj4+Pj4gLS0tIGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+
Pj4gKysrIGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+Pj4gQEAgLTYyLDYgKzYy
LDcgQEAgdHlwZWRlZiB1bmlvbiBWVERfSVJfVGFibGVFbnRyeQ0KPlZURF9JUl9UYWJsZUVudHJ5
Ow0KPj4+PiAgdHlwZWRlZiB1bmlvbiBWVERfSVJfTVNJQWRkcmVzcyBWVERfSVJfTVNJQWRkcmVz
czsNCj4+Pj4gIHR5cGVkZWYgc3RydWN0IFZURFBBU0lERGlyRW50cnkgVlREUEFTSUREaXJFbnRy
eTsNCj4+Pj4gIHR5cGVkZWYgc3RydWN0IFZURFBBU0lERW50cnkgVlREUEFTSURFbnRyeTsNCj4+
Pj4gK3R5cGVkZWYgc3RydWN0IFZURElPTU1VRkREZXZpY2UgVlRESU9NTVVGRERldmljZTsNCj4+
Pj4NCj4+Pj4gIC8qIENvbnRleHQtRW50cnkgKi8NCj4+Pj4gIHN0cnVjdCBWVERDb250ZXh0RW50
cnkgew0KPj4+PiBAQCAtMTQ4LDYgKzE0OSwxMyBAQCBzdHJ1Y3QgVlREQWRkcmVzc1NwYWNlIHsN
Cj4+Pj4gICAgICBJT1ZBVHJlZSAqaW92YV90cmVlOw0KPj4+PiAgfTsNCj4+Pj4NCj4+Pj4gK3N0
cnVjdCBWVERJT01NVUZERGV2aWNlIHsNCj4+Pj4gKyAgICBQQ0lCdXMgKmJ1czsNCj4+Pj4gKyAg
ICB1aW50OF90IGRldmZuOw0KPj4+PiArICAgIElPTU1VRkREZXZpY2UgKmlkZXY7DQo+Pj4+ICsg
ICAgSW50ZWxJT01NVVN0YXRlICppb21tdV9zdGF0ZTsNCj4+Pj4gK307DQo+Pj4+ICsNCj4+PiBK
dXN0IHdvbmRlcmluZyB3aGV0aGVyIHdlIHNob3VsZG4ndCByZXVzZSB0aGUgVlREQWRkcmVzc1Nw
YWNlIHRvDQo+c3RvcmUNCj4+PiB0aGUgaWRldiwgaWYgYW55LiBIb3cgaGF2ZSB5b3UgbWFkZSB5
b3VyIGNob2ljZS4gV2hhdCB3aWxsIGl0IGJlY29tZQ0KPj4+IHdoZW4gUEFTSUQgZ2V0cyBhZGRl
ZD8NCj4+IFZUREFkZHJlc3NTcGFjZSBpcyBpbmRleGVkIGJ5IGFsaWFzZWQgQkRGLCBidXQgVlRE
SU9NTVVGRERldmljZSBpcw0KPmluZGV4ZWQNCj4+IGJ5IGRldmljZSdzIEJERi4gU28gd2UgY2Fu
J3QganVzdCBzdG9yZSBWVERJT01NVUZERGV2aWNlIGFzIGEgcG9pbnRlciBpbg0KPj4gVlREQWRk
cmVzc1NwYWNlLCBtYXkgbmVlZCBhIGxpc3QgaW4gY2FzZSBtb3JlIHRoYW4gb25lIGRldmljZSBp
biBzYW1lDQo+YWRkcmVzcw0KPj4gc3BhY2UuIFRoZW4gYSBnbG9iYWwgVlRESU9NTVVGRERldmlj
ZSBsaXN0IGlzIGJldHRlciBmb3IgbG9va3VwLg0KPg0KPk9LIGJ1dCBpZiBzZXZlcmFsIGRldmlj
ZXMgYXJlIGhpZGRlbiB1bmRlciBhbiBhbGlhc2VkIEJERiwgY2FuJ3QgdGhleQ0KPnNoYXJlIHRo
ZSBob3N0IHByb3BlcnRpZXMgKERNQVIgZWNhcC9jYXApPw0KDQpJdCBkZXBlbmRzIG9uIHRoYXQg
aWYgdGhlIHZmaW8gZGV2aWNlcyBhcmUgdW5kZXIgc2FtZSBhbGlhc2VkIEJERiBpbiBob3N0Lg0K
SWYgdmZpbyBkZXZpY2VzIGFyZSBjb25maWd1cmVkIHVuZGVyIHNhbWUgYWxpYXNlZCBCREYgaW4g
cWVtdSBidXQgdGhleSBhcmUNCm5vdCBpbiBzYW1lIGFsaWFzZWQgQkRGIGluIGhvc3QsIHRoZWly
IGhvc3QgY2FwL2VjYXAgbWF5IGJlIGRpZmZlcmVudC4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

