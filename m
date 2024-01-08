Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B22A482675B
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 04:19:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMg9a-0006Iw-2I; Sun, 07 Jan 2024 22:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rMg9Y-0006Ij-2X
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 22:18:16 -0500
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rMg9V-0000Hm-LP
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 22:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704683893; x=1736219893;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Yv2uNhYVCRYH0t8LkAYGPo8zBGdgBY//fvFb63HTXeY=;
 b=NjAhGgF/K+qRk/i6PEofUGGOt8HQEXpMEdEU3Bxmhhp57NDjdS83GQXx
 lRO83Q52+f0anr/+QKfCJU5F9m2JHIiacLb3UffqlezdarNguXz8OYkUh
 ekxDqLrvXcFnG1DJzSskkXmCzqHbMe/oqXB0NMpAfEj604adkS2JubRA+
 khBPOB4MgsMMSVof+ljRTgLNgLvoiOFCKLF4ktY1lyYeSjgyZsKDaWk6w
 gar4il0E1k4AQDf5VnRBny/6WIC3BfYaYKUJMuCKpbhKwCIEQ74gRB5K6
 KQ2Rw68ytDFxs9UvKviGf7AN8XIIjDiTiuQ21T2Nj8GxVhHRoZ9HzjDFt g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="462076706"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; d="scan'208";a="462076706"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2024 19:18:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="757491417"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; d="scan'208";a="757491417"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Jan 2024 19:18:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 19:18:03 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 19:18:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Jan 2024 19:18:02 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Jan 2024 19:18:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFtFE2vEzRGlIq740zf9ocs24+MgPw6n0kNSuqYIqDUCXFdlUf4VQhMCXkFMugpMxLuoRVO0SYuX4aFd9MBInHwVQAP1K9faDWCy94zSuvcuwbv/huDB2EvPEQtyLggAcEx7/nQclkWeXVLHLHPM3X25RguYb84e4hwKYbtK4V9OzMo+SKZi1+rODVMTorlVmsafzKsQRCGGKSAlM014HAJ9r23EgKTnR1LGskAbkx+dKGU1zQznBqeH7/lTedB9Gbc3aSZN8kUzrWY4x+HN8dKmthz/lEiFgna7P5TE+YWV3FZB2F9p5QtN983fIw6RnI5HrIdgOzuG+ExKMltKZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yv2uNhYVCRYH0t8LkAYGPo8zBGdgBY//fvFb63HTXeY=;
 b=fqYemTpr5nC8tQzrGXvLY4GIzzYMiUNwpNW7Cqksu/T20B4U8jH3X6va0TwqUG686lvKHHzsjLKBlLjV3BXyb1R8gkMX9u3Ll5nUi7FqdMKkSWQZyjJEND57i+WF4/8+A9kdq6EqGI6kS4GckBvaX297Df5ZDgAd5Hp/pE/zyFeMBNea2/yc7MbPDjZirXMJzQREjW4nZ2WnatVJSo4XQ57ITTMCcpUuGA740lHYB6qm14wuu4QYEF7AmemFDzcQ+tKv7aJnCC12FSmjn5FOmNIj0v4MYFb3UCa4UmqZGes9/6jj8VApNj6ME5gnHbjHU6Ra2aC08b3CHZCOyZRwZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by DM4PR11MB6120.namprd11.prod.outlook.com (2603:10b6:8:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 03:17:59 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f0ec:877c:fd93:a04c]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f0ec:877c:fd93:a04c%3]) with mapi id 15.20.7159.013; Mon, 8 Jan 2024
 03:17:59 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, Bryan Zhang <bryan.zhang@bytedance.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>
CC: "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH 3/5] migration: Introduce unimplemented 'qatzip'
 compression method
Thread-Topic: [PATCH 3/5] migration: Introduce unimplemented 'qatzip'
 compression method
Thread-Index: AQHaQBLbbmpfHBoi10eEBscMUOnzCrDPPmhQ
Date: Mon, 8 Jan 2024 03:17:59 +0000
Message-ID: <PH7PR11MB5941070ECFA88490DC671BEAA36B2@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20231231205804.2366509-1-bryan.zhang@bytedance.com>
 <20231231205804.2366509-4-bryan.zhang@bytedance.com> <87jzon8ryv.fsf@suse.de>
In-Reply-To: <87jzon8ryv.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|DM4PR11MB6120:EE_
x-ms-office365-filtering-correlation-id: babc6e5f-a328-4d28-8286-08dc0ff86a68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RB8iWCa/ryOhmJvForw9md+wGbgQJXsax72z8+hYwdNa0NbfjPqSgsq9pKYIHT6H09O/FinckNFZ6nP0a487qtgSWZZcC0y5Ceu2hgm3E/vTYLamvshoz3LlM08V40O7x3lGo9JFS1klxwz7KqRIjp15d7BfpbKkFztYW4fw+SmtGXILkFmhsG1iD9DnnGy9j2MT8nr4lYA7bQ/+wNVBYZXzQoItzlgtL2Dzh2/zJ7crE4L6YgUiz2Vbq07ix1tQgqmdzsy58rR9X4x9bnx2XEVVTNH35TmTaBpsaRBpuxy7MtjSFAw+LwWYuZLN8hQ0WGI/Tz2A9Q1tU6Vo/L3FB3LBKq8uM09MgQOm2BMhMCIeJ2zhF4i2SXsc2Wg7gXKCsrIHTwqaUu0Krf8SClSQPSaZ6bf9nQ1TIXqCjVTA1XTOH8X9jf766YjqfZoGVgSHrCniF5NAs1UP+uMdz9qgSKehAbdQOO2aD9SqgHafVe5AlF6RVZfAu/umVgWv2xdN84v044T2j3hjdePPATl8y1+ymsvL/AysNtpWxWX53IMoKxoX1ZfQnVJnL5ySJxcyyewXR0b7dCXHAYuAJesN3lYLr6JaKkmfrxpdDZq8XZinfX6LVBm1ROSbItEz6FrLPZQnZxtGeXTb08TDplIZ7g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(26005)(9686003)(53546011)(7696005)(6506007)(478600001)(71200400001)(966005)(38100700002)(122000001)(86362001)(33656002)(82960400001)(5660300002)(2906002)(41300700001)(107886003)(83380400001)(38070700009)(110136005)(66946007)(66556008)(66476007)(66446008)(54906003)(316002)(64756008)(76116006)(4326008)(8676002)(52536014)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHo3clFNSVVNR3U3cGVqZCsvRXNzWkk4WUsxL2pSKzZRdlova1BkSHNDWXkv?=
 =?utf-8?B?UWJleXNUTmxvcXptZGJhamxKQjg3d1ZtNEZsK1Npa2k4OVJrS3MxblhPd0g1?=
 =?utf-8?B?dkFYK0NoanRrWW93RHdsS2JGMkxDV29LNTRlY0sxQWExWlVMcDRwMXV2STRi?=
 =?utf-8?B?THAyeFBGb3d5U0QrRnZYM0M4aVYwYkJGTnRIUlF4YmVXeGxvUlNmNFhWQnJj?=
 =?utf-8?B?NjArRmtGY0FzMWZQYzRCR2JiaWkxZXNaaE1nc3BndktEajBhbHdyeFV0ZzYr?=
 =?utf-8?B?MWdzUWxsNWlnOFVBQ0I2a05yTHhuT0NUR2xUQkJrcytFaEV3cFJtMHJpTlVJ?=
 =?utf-8?B?QlZ1UjVjL3BxckZESWU4R2tuK1ExREkvdmNvTHlUM1ZwdkhUeXgyMkc2WUpC?=
 =?utf-8?B?Sy9lZUYrWVlkTFljeUtXQ1Eyb2gvdTdqOENxZXpKNnpjcHl4YmIyS1hrNjZ3?=
 =?utf-8?B?UHZXblc0bEE5VXJ2MGc1dERyZytEQUJtaFNBRkM3Ly9yM3A0V1A4dE16RS95?=
 =?utf-8?B?Q2h6RHJPSTk0UGJRKzlWay95L2RVajJIS2t5eC91bWFzOUpGZVVwY21kZWNE?=
 =?utf-8?B?Z0Nud1lDYk8rMnI3emlmTXEyQWN2ZndlQjlheiszYmxyaXAvcGd6dGZVMFhy?=
 =?utf-8?B?Q29seFNhaW9RS2JqNEczZy9TUm1qVU5MMjBzbnU1bldMNERuaUVRVnJBc0NJ?=
 =?utf-8?B?alJiRkZRYkhhRTJ5VUNyV3ZJQVBHOHE2V1pYWStrcU5EZ3lsM0RxcnJkSEpE?=
 =?utf-8?B?eWNJV3FVSVl5NGNKTldndVdYNUNyNkp2d24xelNLbWd2S3dQN2xEaHhzWUww?=
 =?utf-8?B?S0tnTVlIZ2l6V1pZVXJwaVM3S3pxWnJmSTlJaXQzMnU1Uk56QUF6TVI0WnIx?=
 =?utf-8?B?VUg2WnFPRXNCRTJGWlh3WXhGNXMwd2Z3Y3M2SDZLeHR1WURTY2tnOUQyTmNu?=
 =?utf-8?B?OTFYTzhGdWpjTjZpVHgvckpBZ1J1VmR1VC8ycjg2K3k2aWhPQ0JJOVhSOU4x?=
 =?utf-8?B?T2dsVEZpUWdRWjNTNkVHWDEzcG1SZXdWNm51bjJTYmFIc3hocHdoU3c3OUpU?=
 =?utf-8?B?aWdMTHZpWUpVTWRGVW9WR0Z6RE1vNnVPY3IvRm43TU42Q2V4bVNPeW02SUtj?=
 =?utf-8?B?RlEzaWo0STdRTXp6Qk9iTGxYZHJLcHdGTm9ueWJCTGRuU1dnOFgwV3dYVk9B?=
 =?utf-8?B?bmR4ZUV0ZXBaY2lCSVpOYTI2MFlRb0RhdVVKU2ExWHFEZjNQdmxFMlNuUDdl?=
 =?utf-8?B?aUJYRnlHNGFpRHkzUXFGM2Z2Z1YxdnNvZ01VYkYzV3kvOUJCc3pvdmx4TUpF?=
 =?utf-8?B?L1QvTWVmV21ONGFuUzBrNXVab3NBTjlMa2tQbDFLVkIzd3FRUkNEY3JoQXpV?=
 =?utf-8?B?cGRzZHZ2ZnVNL21pR1M3cjh3MmIxSlhZM1RkNjBSVjA0MVROVlhLbWRwNGV4?=
 =?utf-8?B?SkFVZWgwTWV1cG1ZS3VnQWpyK2J3aTJZeFVDWURiNldtdVBlU3NZQ2hjbHg5?=
 =?utf-8?B?ZnRpcGp2QzR6VFVzK2NTMHE1Um9jVU43QUloUHBjbzZOdG0yazNTZVN1czZV?=
 =?utf-8?B?TExmbDhDYlRaZXFvZnVqaGlVcWFlUE4zNUxzM1hQcFhlSGVuUUtwRnlmanhn?=
 =?utf-8?B?NTVPV3BxaXdjWG1YampUVlhiQ0wydzBlTFBBMGRMN2N5TkRKRGRoUDZ3N2pv?=
 =?utf-8?B?eTREcXM4anRUTlVZc05RbU9KTmQ0ZFoxaDcxSnR3Nzd5bHh4K1NTYTI0L0wx?=
 =?utf-8?B?ZDc3eFg2NXZnOWFVampLdWFXbHZnMHFwRXN4VURLWjFiVEtMVjc4SmsxT21q?=
 =?utf-8?B?MXoyL1NZOE1MYzFHb0Z3RlJSaFdSSE5PenRMTTdPQVpWTm0yVmh0ZUsvaXc4?=
 =?utf-8?B?SmVpVUVrdGw3ODRvdkdIR0lXU3VpcGczWHZjaHA1NGZoc3NHN0IySGZtQ1M3?=
 =?utf-8?B?TUExR3BsUHFLQUR4azlIekI2TjBXcXowM01jUlV5SlZMekhlRWlqNlZueElS?=
 =?utf-8?B?eElnekcxbmxocnZNYmdOUENzK2FRemFHSDBUU2wyWC9uQXZlVzBLcFlNSFBF?=
 =?utf-8?B?czc3SG9IV3BsTCtlNlpuQlJ4NFZiWGZqN0dnNE0xZnJXTFRPQWVwSXVmbnF4?=
 =?utf-8?Q?2Hn1KIQNzYDCbyXPCHoHL09Aw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: babc6e5f-a328-4d28-8286-08dc0ff86a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 03:17:59.0994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xSHX5+dKc1JzOyHKrBEJ2ReK+vShudgMjoHYXS9vwbQiHYDGzuKWTqNwODSTC1ARxQiZ1/QBsxQGPN6tq5nWzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6120
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpYW5vIFJvc2FzIDxmYXJv
c2FzQHN1c2UuZGU+DQo+IFNlbnQ6IFNhdHVyZGF5LCBKYW51YXJ5IDYsIDIwMjQgNDowNyBBTQ0K
PiBUbzogQnJ5YW4gWmhhbmcgPGJyeWFuLnpoYW5nQGJ5dGVkYW5jZS5jb20+OyBxZW11LWRldmVs
QG5vbmdudS5vcmc7DQo+IG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbTsgcGV0ZXJ4QHJlZGhh
dC5jb207IHF1aW50ZWxhQHJlZGhhdC5jb207DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsg
aGFvLnhpYW5nQGJ5dGVkYW5jZS5jb20NCj4gQ2M6IGJyeWFuLnpoYW5nQGJ5dGVkYW5jZS5jb207
IExpdSwgWXVhbjEgPHl1YW4xLmxpdUBpbnRlbC5jb20+Ow0KPiBiZXJyYW5nZUByZWRoYXQuY29t
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy81XSBtaWdyYXRpb246IEludHJvZHVjZSB1bmltcGxl
bWVudGVkICdxYXR6aXAnDQo+IGNvbXByZXNzaW9uIG1ldGhvZA0KPiANCj4gQnJ5YW4gWmhhbmcg
PGJyeWFuLnpoYW5nQGJ5dGVkYW5jZS5jb20+IHdyaXRlczoNCj4gDQo+ICtjYyBZdWFuIExpdSwg
RGFuaWVsIEJlcnJhbmfDqQ0KPiANCj4gPiBBZGRzIHN1cHBvcnQgZm9yICdxYXR6aXAnIGFzIGFu
IG9wdGlvbiBmb3IgdGhlIG11bHRpZmQgY29tcHJlc3Npb24NCj4gPiBtZXRob2QgcGFyYW1ldGVy
LCBidXQgY29weS1wYXN0ZXMgdGhlIG5vLW9wIGxvZ2ljIHRvIGxlYXZlIHRoZSBhY3R1YWwNCj4g
PiBtZXRob2RzIGVmZmVjdGl2ZWx5IHVuaW1wbGVtZW50ZWQuIFRoaXMgaXMgaW4gcHJlcGFyYXRp
b24gb2YgYQ0KPiA+IHN1YnNlcXVlbnQgY29tbWl0IHRoYXQgd2lsbCBpbXBsZW1lbnQgYWN0dWFs
bHkgdXNpbmcgUUFUIGZvcg0KPiA+IGNvbXByZXNzaW9uIGFuZCBkZWNvbXByZXNzaW9uLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogQnJ5YW4gWmhhbmcgPGJyeWFuLnpoYW5nQGJ5dGVkYW5jZS5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFvIFhpYW5nIDxoYW8ueGlhbmdAYnl0ZWRhbmNlLmNv
bT4NCj4gPiAtLS0NCj4gPiAgaHcvY29yZS9xZGV2LXByb3BlcnRpZXMtc3lzdGVtLmMgfCAgNiAr
Ky0NCj4gPiAgbWlncmF0aW9uL21lc29uLmJ1aWxkICAgICAgICAgICAgfCAgMSArDQo+ID4gIG1p
Z3JhdGlvbi9tdWx0aWZkLXFhdHppcC5jICAgICAgIHwgODEgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gPiAgbWlncmF0aW9uL211bHRpZmQuaCAgICAgICAgICAgICAgfCAgMSAr
DQo+ID4gIHFhcGkvbWlncmF0aW9uLmpzb24gICAgICAgICAgICAgIHwgIDUgKy0NCj4gPiAgNSBm
aWxlcyBjaGFuZ2VkLCA5MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKSAgY3JlYXRlIG1v
ZGUgMTAwNjQ0DQo+ID4gbWlncmF0aW9uL211bHRpZmQtcWF0emlwLmMNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9ody9jb3JlL3FkZXYtcHJvcGVydGllcy1zeXN0ZW0uYw0KPiA+IGIvaHcvY29yZS9x
ZGV2LXByb3BlcnRpZXMtc3lzdGVtLmMNCj4gPiBpbmRleCAxYTM5NjUyMWQ1Li5kOGU0OGRjYjBl
IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2NvcmUvcWRldi1wcm9wZXJ0aWVzLXN5c3RlbS5jDQo+ID4g
KysrIGIvaHcvY29yZS9xZGV2LXByb3BlcnRpZXMtc3lzdGVtLmMNCj4gPiBAQCAtNjU4LDcgKzY1
OCwxMSBAQCBjb25zdCBQcm9wZXJ0eUluZm8gcWRldl9wcm9wX2ZkY19kcml2ZV90eXBlID0gew0K
PiA+IGNvbnN0IFByb3BlcnR5SW5mbyBxZGV2X3Byb3BfbXVsdGlmZF9jb21wcmVzc2lvbiA9IHsN
Cj4gPiAgICAgIC5uYW1lID0gIk11bHRpRkRDb21wcmVzc2lvbiIsDQo+ID4gICAgICAuZGVzY3Jp
cHRpb24gPSAibXVsdGlmZF9jb21wcmVzc2lvbiB2YWx1ZXMsICINCj4gPiAtICAgICAgICAgICAg
ICAgICAgICJub25lL3psaWIvenN0ZCIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAibm9uZS96
bGliL3pzdGQiDQo+ID4gKyNpZmRlZiBDT05GSUdfUUFUWklQDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAiL3FhdHppcCINCj4gPiArI2VuZGlmDQo+ID4gKyAgICAgICAgICAgICAgICAgICAsDQo+
ID4gICAgICAuZW51bV90YWJsZSA9ICZNdWx0aUZEQ29tcHJlc3Npb25fbG9va3VwLA0KPiA+ICAg
ICAgLmdldCA9IHFkZXZfcHJvcGluZm9fZ2V0X2VudW0sDQo+ID4gICAgICAuc2V0ID0gcWRldl9w
cm9waW5mb19zZXRfZW51bSwNCj4gPiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL21lc29uLmJ1aWxk
IGIvbWlncmF0aW9uL21lc29uLmJ1aWxkIGluZGV4DQo+ID4gOTJiMWNjNDI5Ny4uZTIwZjMxODM3
OSAxMDA2NDQNCj4gPiAtLS0gYS9taWdyYXRpb24vbWVzb24uYnVpbGQNCj4gPiArKysgYi9taWdy
YXRpb24vbWVzb24uYnVpbGQNCj4gPiBAQCAtNDAsNiArNDAsNyBAQCBpZiBnZXRfb3B0aW9uKCds
aXZlX2Jsb2NrX21pZ3JhdGlvbicpLmFsbG93ZWQoKQ0KPiA+ICAgIHN5c3RlbV9zcy5hZGQoZmls
ZXMoJ2Jsb2NrLmMnKSkNCj4gPiAgZW5kaWYNCj4gPiAgc3lzdGVtX3NzLmFkZCh3aGVuOiB6c3Rk
LCBpZl90cnVlOiBmaWxlcygnbXVsdGlmZC16c3RkLmMnKSkNCj4gPiArc3lzdGVtX3NzLmFkZCh3
aGVuOiBxYXR6aXAsIGlmX3RydWU6IGZpbGVzKCdtdWx0aWZkLXFhdHppcC5jJykpDQo+ID4NCj4g
PiAgc3BlY2lmaWNfc3MuYWRkKHdoZW46ICdDT05GSUdfU1lTVEVNX09OTFknLA0KPiA+ICAgICAg
ICAgICAgICAgICAgaWZfdHJ1ZTogZmlsZXMoJ3JhbS5jJywgZGlmZiAtLWdpdA0KPiA+IGEvbWln
cmF0aW9uL211bHRpZmQtcWF0emlwLmMgYi9taWdyYXRpb24vbXVsdGlmZC1xYXR6aXAuYyBuZXcg
ZmlsZQ0KPiA+IG1vZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAwMDAuLjE3MzNiYmRkYjcNCj4gPiAt
LS0gL2Rldi9udWxsDQo+ID4gKysrIGIvbWlncmF0aW9uL211bHRpZmQtcWF0emlwLmMNCj4gPiBA
QCAtMCwwICsxLDgxIEBADQo+ID4gKy8qDQo+ID4gKyAqIE11bHRpZmQgUUFUemlwIGNvbXByZXNz
aW9uIGltcGxlbWVudGF0aW9uDQo+ID4gKyAqDQo+ID4gKyAqIENvcHlyaWdodCAoYykgQnl0ZWRh
bmNlDQo+ID4gKyAqDQo+ID4gKyAqIEF1dGhvcnM6DQo+ID4gKyAqICBCcnlhbiBaaGFuZyA8YnJ5
YW4uemhhbmdAYnl0ZWRhbmNlLmNvbT4NCj4gPiArICogIEhhbyBYaWFuZyAgIDxoYW8ueGlhbmdA
Ynl0ZWRhbmNlLmNvbT4NCj4gPiArICoNCj4gPiArICogVGhpcyB3b3JrIGlzIGxpY2Vuc2VkIHVu
ZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdQTCwgdmVyc2lvbiAyIG9yDQo+IGxhdGVyLg0KPiA+
ICsgKiBTZWUgdGhlIENPUFlJTkcgZmlsZSBpbiB0aGUgdG9wLWxldmVsIGRpcmVjdG9yeS4NCj4g
PiArICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPiA+ICsjaW5jbHVk
ZSAiZXhlYy9yYW1ibG9jay5oIg0KPiA+ICsjaW5jbHVkZSAiZXhlYy90YXJnZXRfcGFnZS5oIg0K
PiA+ICsjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPiA+ICsjaW5jbHVkZSAibWlncmF0aW9uLmgi
DQo+ID4gKyNpbmNsdWRlICJvcHRpb25zLmgiDQo+ID4gKyNpbmNsdWRlICJtdWx0aWZkLmgiDQo+
ID4gKw0KPiA+ICtzdGF0aWMgaW50IHFhdHppcF9zZW5kX3NldHVwKE11bHRpRkRTZW5kUGFyYW1z
ICpwLCBFcnJvciAqKmVycnApIHsNCj4gPiArICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0K
PiA+ICtzdGF0aWMgdm9pZCBxYXR6aXBfc2VuZF9jbGVhbnVwKE11bHRpRkRTZW5kUGFyYW1zICpw
LCBFcnJvciAqKmVycnApDQo+ID4gK3t9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGludCBxYXR6aXBf
c2VuZF9wcmVwYXJlKE11bHRpRkRTZW5kUGFyYW1zICpwLCBFcnJvciAqKmVycnApIHsNCj4gPiAr
ICAgIE11bHRpRkRQYWdlc190ICpwYWdlcyA9IHAtPnBhZ2VzOw0KPiA+ICsNCj4gPiArICAgIGZv
ciAoaW50IGkgPSAwOyBpIDwgcC0+bm9ybWFsX251bTsgaSsrKSB7DQo+ID4gKyAgICAgICAgcC0+
aW92W3AtPmlvdnNfbnVtXS5pb3ZfYmFzZSA9IHBhZ2VzLT5ibG9jay0+aG9zdCArIHAtDQo+ID5u
b3JtYWxbaV07DQo+ID4gKyAgICAgICAgcC0+aW92W3AtPmlvdnNfbnVtXS5pb3ZfbGVuID0gcC0+
cGFnZV9zaXplOw0KPiA+ICsgICAgICAgIHAtPmlvdnNfbnVtKys7DQo+ID4gKyAgICB9DQo+ID4g
Kw0KPiA+ICsgICAgcC0+bmV4dF9wYWNrZXRfc2l6ZSA9IHAtPm5vcm1hbF9udW0gKiBwLT5wYWdl
X3NpemU7DQo+ID4gKyAgICBwLT5mbGFncyB8PSBNVUxUSUZEX0ZMQUdfTk9DT01QOw0KPiA+ICsg
ICAgcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgcWF0emlwX3JlY3Zf
c2V0dXAoTXVsdGlGRFJlY3ZQYXJhbXMgKnAsIEVycm9yICoqZXJycCkgew0KPiA+ICsgICAgcmV0
dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIHFhdHppcF9yZWN2X2NsZWFu
dXAoTXVsdGlGRFJlY3ZQYXJhbXMgKnApIHt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGludCBxYXR6
aXBfcmVjdl9wYWdlcyhNdWx0aUZEUmVjdlBhcmFtcyAqcCwgRXJyb3IgKiplcnJwKSB7DQo+ID4g
KyAgICB1aW50MzJfdCBmbGFncyA9IHAtPmZsYWdzICYgTVVMVElGRF9GTEFHX0NPTVBSRVNTSU9O
X01BU0s7DQo+ID4gKw0KPiA+ICsgICAgaWYgKGZsYWdzICE9IE1VTFRJRkRfRkxBR19OT0NPTVAp
IHsNCj4gPiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJtdWx0aWZkICV1OiBmbGFncyByZWNl
aXZlZCAleCBmbGFncw0KPiBleHBlY3RlZCAleCIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICBw
LT5pZCwgZmxhZ3MsIE1VTFRJRkRfRkxBR19OT0NPTVApOw0KPiA+ICsgICAgICAgIHJldHVybiAt
MTsNCj4gPiArICAgIH0NCj4gPiArICAgIGZvciAoaW50IGkgPSAwOyBpIDwgcC0+bm9ybWFsX251
bTsgaSsrKSB7DQo+ID4gKyAgICAgICAgcC0+aW92W2ldLmlvdl9iYXNlID0gcC0+aG9zdCArIHAt
Pm5vcm1hbFtpXTsNCj4gPiArICAgICAgICBwLT5pb3ZbaV0uaW92X2xlbiA9IHAtPnBhZ2Vfc2l6
ZTsNCj4gPiArICAgIH0NCj4gPiArICAgIHJldHVybiBxaW9fY2hhbm5lbF9yZWFkdl9hbGwocC0+
YywgcC0+aW92LCBwLT5ub3JtYWxfbnVtLCBlcnJwKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3Rh
dGljIE11bHRpRkRNZXRob2RzIG11bHRpZmRfcWF0emlwX29wcyA9IHsNCj4gPiArICAgIC5zZW5k
X3NldHVwID0gcWF0emlwX3NlbmRfc2V0dXAsDQo+ID4gKyAgICAuc2VuZF9jbGVhbnVwID0gcWF0
emlwX3NlbmRfY2xlYW51cCwNCj4gPiArICAgIC5zZW5kX3ByZXBhcmUgPSBxYXR6aXBfc2VuZF9w
cmVwYXJlLA0KPiA+ICsgICAgLnJlY3Zfc2V0dXAgPSBxYXR6aXBfcmVjdl9zZXR1cCwNCj4gPiAr
ICAgIC5yZWN2X2NsZWFudXAgPSBxYXR6aXBfcmVjdl9jbGVhbnVwLA0KPiA+ICsgICAgLnJlY3Zf
cGFnZXMgPSBxYXR6aXBfcmVjdl9wYWdlcw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIHZv
aWQgbXVsdGlmZF9xYXR6aXBfcmVnaXN0ZXIodm9pZCkgew0KPiA+ICsgICAgbXVsdGlmZF9yZWdp
c3Rlcl9vcHMoTVVMVElGRF9DT01QUkVTU0lPTl9RQVRaSVAsDQo+ID4gKyZtdWx0aWZkX3FhdHpp
cF9vcHMpOyB9DQo+ID4gKw0KPiA+ICttaWdyYXRpb25faW5pdChtdWx0aWZkX3FhdHppcF9yZWdp
c3Rlcik7DQo+ID4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9tdWx0aWZkLmggYi9taWdyYXRpb24v
bXVsdGlmZC5oIGluZGV4DQo+ID4gYTgzNTY0M2I0OC4uNTYwMGY3ZmM4MiAxMDA2NDQNCj4gPiAt
LS0gYS9taWdyYXRpb24vbXVsdGlmZC5oDQo+ID4gKysrIGIvbWlncmF0aW9uL211bHRpZmQuaA0K
PiA+IEBAIC0zMyw2ICszMyw3IEBAIGludCBtdWx0aWZkX3F1ZXVlX3BhZ2UoUUVNVUZpbGUgKmYs
IFJBTUJsb2NrICpibG9jaywNCj4gPiByYW1fYWRkcl90IG9mZnNldCk7ICAjZGVmaW5lIE1VTFRJ
RkRfRkxBR19OT0NPTVAgKDAgPDwgMSkgICNkZWZpbmUNCj4gPiBNVUxUSUZEX0ZMQUdfWkxJQiAo
MSA8PCAxKSAgI2RlZmluZSBNVUxUSUZEX0ZMQUdfWlNURCAoMiA8PCAxKQ0KPiA+ICsjZGVmaW5l
IE1VTFRJRkRfRkxBR19RQVRaSVAgKDMgPDwgMSkNCj4gPg0KPiA+ICAvKiBUaGlzIHZhbHVlIG5l
ZWRzIHRvIGJlIGEgbXVsdGlwbGUgb2YgcWVtdV90YXJnZXRfcGFnZV9zaXplKCkgKi8NCj4gPiAj
ZGVmaW5lIE1VTFRJRkRfUEFDS0VUX1NJWkUgKDUxMiAqIDEwMjQpIGRpZmYgLS1naXQNCj4gPiBh
L3FhcGkvbWlncmF0aW9uLmpzb24gYi9xYXBpL21pZ3JhdGlvbi5qc29uIGluZGV4DQo+ID4gNmQ1
YTRiMDQ4OS4uZTNjYzE5NWFlZCAxMDA2NDQNCj4gPiAtLS0gYS9xYXBpL21pZ3JhdGlvbi5qc29u
DQo+ID4gKysrIGIvcWFwaS9taWdyYXRpb24uanNvbg0KPiA+IEBAIC02MjUsMTEgKzYyNSwxNCBA
QA0KPiA+ICAjDQo+ID4gICMgQHpzdGQ6IHVzZSB6c3RkIGNvbXByZXNzaW9uIG1ldGhvZC4NCj4g
PiAgIw0KPiA+ICsjIEBxYXR6aXA6IHVzZSBxYXR6aXAgY29tcHJlc3Npb24gbWV0aG9kLg0KPiA+
ICsjDQo+ID4gICMgU2luY2U6IDUuMA0KPiA+ICAjIw0KPiA+ICB7ICdlbnVtJzogJ011bHRpRkRD
b21wcmVzc2lvbicsDQo+ID4gICAgJ2RhdGEnOiBbICdub25lJywgJ3psaWInLA0KPiA+IC0gICAg
ICAgICAgICB7ICduYW1lJzogJ3pzdGQnLCAnaWYnOiAnQ09ORklHX1pTVEQnIH0gXSB9DQo+ID4g
KyAgICAgICAgICAgIHsgJ25hbWUnOiAnenN0ZCcsICdpZic6ICdDT05GSUdfWlNURCcgfSwNCj4g
PiArICAgICAgICAgICAgeyAnbmFtZSc6ICdxYXR6aXAnLCAnaWYnOiAnQ09ORklHX1FBVFpJUCd9
IF0gfQ0KPiANCj4gSW4gYW5vdGhlciB0aHJlYWQgYWRkaW5nIHN1cHBvcnQgdG8gYW5vdGhlciBJ
bnRlbCBhY2NlbGVyYXRvciAoSUFBKSB3ZQ0KPiBkZWNpZGVkIHRoYXQgaXQgd2FzIGJldHRlciB0
byBzZWxlY3QgdGhlIG9mZmxvYWRpbmcgYXMgYW4gYWNjZWxlcmF0b3INCj4gbWV0aG9kIHRvIG11
bHRpZmQgemxpYiByYXRoZXIgdGhhbiBhcyBhbiBlbnRpcmVseSBuZXcgY29tcHJlc3Npb24gZm9y
bWF0Lg0KPiBUYWtlIGEgbG9vayBhdCB0aGF0IGRpc2N1c3Npb246DQo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3IvWlRGQ25xYmJxbG1zVWtSQ0ByZWRoYXQuY29tDQo+IA0KPiBBcyBJIHVuZGVy
c3RhbmQgaXQsIFFBVCArIFFBVHppcCB3b3VsZCBiZSBjb21wYXRpYmxlIHdpdGggYm90aCB6bGli
IGFuZA0KPiBJQUEgKyBRUEwsIHNvIHdlJ2QgYWRkIGFub3RoZXIgYWNjZWxlcmF0b3IgbWV0aG9k
IGxpa2UgdGhpczoNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDAxMDMxMTI4
NTEuOTA4MDgyLTMteXVhbjEubGl1QGludGVsLmNvbQ0KPiANCj4gQWxsIHRoYXQsIG9mIGNvdXJz
ZSwgYXNzdW1pbmcgd2UgZXZlbiB3YW50IHRvIHN1cHBvcnQgYm90aCBhY2NlbGVyYXRvcnMuDQo+
IFRoZXkncmUgYWRkcmVzc2luZyB0aGUgc2FtZSBwcm9ibGVtIGFmdGVyIGFsbC4gSSB3b25kZXIg
aG93IHdlJ2QgY2hvb3NlIGENCj4gcHJlY2VkZW5jZSwgc2luY2UgYm90aCBzZWVtIHRvIGJlIHBy
ZXNlbnQgaW4gdGhlIHNhbWUgcHJvY2Vzc29yIGZhbWlseS4NCg0KDQpJIGFncmVlIHRoYXQgSUFB
IGFuZCBRQVQgc2hvdWxkIHJ1biB1bmRlciB0aGUgYWNjZWxlcmF0b3IgZnJhbWV3b3JrIGFuZCBi
ZSANCmNvbXBhdGlibGUgd2l0aCB6bGliLg0KDQpSZWdhcmRpbmcgdGhlIGNob2ljZSBiZXR3ZWVu
IFFBVCBhbmQgSUFBOg0KDQoxLiBUaGlzIGRlY2lzaW9uIGNhbiBiZSBkZXRlcm1pbmVkIGJ5IHRo
ZSBlbmQgY3VzdG9tZXIgdGhyb3VnaCBsaXZlIG1pZ3JhdGlvbiANCnBhcmFtZXRlcnMuIFRoZSBY
ZW9uIHByb2R1Y3RzIGhhdmUgZGlmZmVyZW50IHNwZWNpZmljYXRpb25zLCB3aGljaCB3aWxsIGlt
cGFjdCANCnRoZSBwcmVzZW5jZSBhbmQgcXVhbnRpdHkgb2YgSUFBIGFuZCBRQVQgZGV2aWNlcy4N
Cg0KMi4gSWYgdGhlIGN1c3RvbWVyJ3MgY2hvc2VuIHByb2R1Y3QgaW5jbHVkZXMgYm90aCBJQUEg
YW5kIFFBVCwgdGhlIGxpdmUgbWlncmF0aW9uDQpzb2Z0d2FyZSBjYW4gbGlzdCB0aGUgcHJpb3Jp
dHkgb2YgYWNjZWxlcmF0b3JzIHN1cHBvcnRpbmcgdGhlIHpsaWIgY29tcHJlc3Npb24gDQphbGdv
cml0aG0uDQoNCg==

