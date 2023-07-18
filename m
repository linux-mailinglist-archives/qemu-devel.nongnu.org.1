Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4FA757D69
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 15:26:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLki7-0005mZ-KO; Tue, 18 Jul 2023 09:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1qLki2-0005mA-TZ
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 09:25:47 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1qLkhy-0000Wt-Va
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 09:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689686743; x=1721222743;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yycbjYuwaoOqqu0egqO4nlCzSresdcQmRXEHDaBil/o=;
 b=OUy0TY4RrrmKuzCXsFyUvklrIfpM+mc2UKN5wzP7vMNivaiMh9QUI/HW
 3H2nwBasJkwm1Ru5+8hYUhqVbXrWcJQvmcf0/Bye+iLGvi1JQYq58mMV7
 WyZVk3hof50AuVWdriroVe+NGoUdWGseOhdsfPdW46JtSmieqjJpZVPBh
 MrG3sDfmruOdVs2ai2AzRFR/gDjotL8/A7WxJnv3ZV0GZRi8Go1/g6pMN
 BIDbimBJ25OtTjiA93Jl+KQdE5acV/MLw6nGVsIfCRTGG9LviBaEPZ8M1
 XghhG8NrybzTfEnZwf0FZe8eenpZiNb+ZqwJoiAbgyqzO+x47yOoMdn9C A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="369759250"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; d="scan'208";a="369759250"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2023 06:25:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="970240234"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; d="scan'208";a="970240234"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga006.fm.intel.com with ESMTP; 18 Jul 2023 06:25:15 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 06:25:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 06:25:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 06:25:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AD0DOuHRiCeIP2pNERCg8pxJxOibXCVQ7D/2ecEb9SBOcJ00Mcnn06YphzOdWrTJKt8DMA42sdq9eL9jDoSZiMLvkNsqnjWmTY+DiXLJMPEBUBdGiVkADo2mJksCbOJN6scZItgVBMIDftmoGjynsaf1+ODE6zKkipj7v7DP9368Tw1pZm4FebwVcGciMs88QCTu+3q4S84psTJg57tQAExgnH9qpkG6gNZrQU2sJErWo1f8OKd08YKQ/fzVF3FLDukeAiBhdFpXz5GH2x2oM/CSk9Z2BwguRVByt86NUHwPRvwaHmGkJeZFnajz3sESy5Y2j535SyCmKlq/Zo3BDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yycbjYuwaoOqqu0egqO4nlCzSresdcQmRXEHDaBil/o=;
 b=P6hFwmaKTCtK9A4+e/keAd9NVg0rRrjVbb4BMqx95VRj9CtOwP1fMS/6f0M4Zkx1x9dJDEXrg8mcZpofEEfbKy8oI13NKi4yd6pTZo1rwAA62fa8zf93oIFZ+2e41J9edNKd9PfQ6EuG/lYP7Jwe5/kJLxNF31lnjQmKSqMhiL4zSaxVGumu57vi+6yruPNQ/04DFxXNxkkN4A21N9Z6VxwoH+UwOtHB2XTQlWwWqdDU/ZEVpO4NuLUq8mE5L6upTxmvskgec99vP+k5LWSHC2P9H5/MYrbo8ur6oSxd2y/2fzMHVF3ZNWFDXewvkXjGa/zFgAeXLhPmusmmYXIn/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 PH8PR11MB6831.namprd11.prod.outlook.com (2603:10b6:510:22d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 13:25:13 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::e8f3:851f:3ddc:fdeb]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::e8f3:851f:3ddc:fdeb%7]) with mapi id 15.20.6588.028; Tue, 18 Jul 2023
 13:25:12 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Isaku Yamahata <isaku.yamahata@gmail.com>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v1] migration: refactor migration_completion
Thread-Topic: [PATCH v1] migration: refactor migration_completion
Thread-Index: AQHZtlGE+Wh4fGObDECF1brZ49mxaq+/CS6AgAADl6A=
Date: Tue, 18 Jul 2023 13:25:12 +0000
Message-ID: <DS0PR11MB6373E417A60B2DEF9EFE3697DC38A@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230714124823.25142-1-wei.w.wang@intel.com>
 <20230718054425.GA1807130@ls.amr.corp.intel.com>
In-Reply-To: <20230718054425.GA1807130@ls.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|PH8PR11MB6831:EE_
x-ms-office365-filtering-correlation-id: a4b02ace-0321-4e36-45b8-08db87926a8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fOyyghMjYd8l5/NXN6U5pbelJtaEGrRwURIBQjsX8CIPzSwBeYJtFjymE+RQl5Wtfpo++tCBuCS6Gho+Dzwg7Hh+p1gytM57UzKKyQZP5AO6g0eWxkCPHItaTp7lnVGOPedrodFtyZBTdCoO63FXvyFveveN8gka+TPZkqsIvc3oJgxStshKwvvRmt19QdOP3bBBCZ9LXt6UphGwX+sa1Rq/j0N1+w6Xvu8MMkWuB9RzUXUlqfMUR0ba8NVxSe0iI5mZ1lrYTHLDJyIzIHhPjnlqWbDyAyxySYJ764V/QzhgYmZSGJ050+qsZJXaW5pBCyn15aRQEgnLU7ImLX4ponNFEX+ut0LPmqW56vX929HnKiw2yKaCBLO/SxTiIe/O3WX89urYxw6ScONBf3IRJUJBbu+IEAHGe/ym56IGxOL680xODRvGnMpaC9CR+P4Bu2Yxi12KNgK8S6RKfJQl3XJUpBnMaQODPvw5xJFllvSsYAq0RasE2QIJKnc7qnnMoKJIAJGR40ANQhdiPdAmUEx3Ir+p7SQsboNDLTrU6cFl9TwS7qHtlKYzsKp3J7bnagl4URsdyMQBO2DaY5ma04I8HnT/b81PL9Tk7CicsoLQxm8McYlrJ4v1XgM7q1D1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199021)(33656002)(82960400001)(6506007)(71200400001)(83380400001)(38100700002)(186003)(26005)(55016003)(478600001)(38070700005)(53546011)(54906003)(66476007)(8676002)(41300700001)(7696005)(66446008)(2906002)(8936002)(66556008)(6916009)(66946007)(316002)(4326008)(52536014)(5660300002)(9686003)(64756008)(86362001)(122000001)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlpuL0NSVUEzRlVvaUt6N3o1UlNxRDZVVHJsNjE3ektmdGd3cDFNbjFyaXFt?=
 =?utf-8?B?OTI1TVRxYVJibktUY0ZyWHNubTh0ZWZWVFFMZFI2dXJLUExQNVkvNWNYTmNE?=
 =?utf-8?B?QnpNUEwvdHJvVFozdWtpam9weHhmNTlURFNEVUtUdVcyZ0w0bk95RGIrVWR4?=
 =?utf-8?B?bjdRSXpESjFyOWdTWjRhb1ZLMG91b09iVW5YT2YvK1FZckVvNTlWbklZZE9k?=
 =?utf-8?B?VGtzRW9GQ3lzUVpnaUR1YUJSeXlQZWxjOUZvQ25zZTF5N0hSZ1dxdWRMcnlp?=
 =?utf-8?B?OUQxeVhlb2N1RHRES1hPZk10WWZmWmpUd0toOVRMZ0VQcGZUb0FnTEZjcUhF?=
 =?utf-8?B?K3VSTWVvZG9aSUZDSlVzczAxb1E5L0JZUE9JQU0yc3BQbXR2Q0N6YU5TZnVW?=
 =?utf-8?B?aFA1ZCtUWEl6QWgxMzJQY2tvaDZFcmlMU3lubVByb0R3MW9jWFZycnRUa0ZE?=
 =?utf-8?B?eS9GUVEvN3FaTlhQdktlRmZYY0w5R3I5RC9uc0FzVXdvNk9PakNPb2EwaHUv?=
 =?utf-8?B?Zk5YbnRXVnJYcTJQSTJXOU5meXFyazQ1QkFUTlB0SWhidUhoWFJ2T1U0K0dD?=
 =?utf-8?B?dUwwa3BqRlB0WFQxZDlxRGJ0QnBycTZxTEx3aTZha2s0clUvdVp2aDJBU2xx?=
 =?utf-8?B?aUUvT1JwR3VoYTU4QXk5bDhNb2Q5UWczLzZHQkxvZ2ExNC9zc0grQjlCckh5?=
 =?utf-8?B?dmI1ODdqNk1wcm5IR2JXNy9jVy9SbDc4Y0JZMzFPMG1yZjRZNU0wN0IzYlZ2?=
 =?utf-8?B?cXZWRFNtbllYTDFlSzRIZ2JDNWFnS1FidmNPaWdPaXA4KzBJQlp5MTR1S052?=
 =?utf-8?B?Nk1kMFI1MmZCdmoxNG9sVDZVYkUvREdDTEVPSkp2UUhqV0ZnNzhDZEgzS0J6?=
 =?utf-8?B?bUlMRWk1UWlCTU9uaGxmSmlXMEQvQW8vb2xMaENqc1kvNWZyTnBVaExiRkp6?=
 =?utf-8?B?U2tHV3ZjQUpER0kwbVVFWlFMSlRRVHVCcjFoU1FpOUptdDZLallBcVpFUTVZ?=
 =?utf-8?B?R3QwTmoyK1VQZFkwLzRGRGg3bVFzS3NlNExHNUR1TkVwMTlFT29RQ092Z1hz?=
 =?utf-8?B?NnhXajFXSkhEQWxVNm84T1IzQmkxSEIrTFUwQWlTL2ZKelFqSFphRnJwU20r?=
 =?utf-8?B?b04rRVJoSFFFbng2eURsWkJpL1drbUR3RUpRbDZJTTBDSEZmSDBhY3RVVjJL?=
 =?utf-8?B?Y2dtYlg2SUdFWGduT2Z0TnBCRExUUUYyU3JoQWJaL24wVG5IckJRVjBTYUdj?=
 =?utf-8?B?MXV0SlhCWEtzNmszeWRkRDNTZmViNnNNMnl5UzI5cHVUSUVISDEyMGxaR1ps?=
 =?utf-8?B?NFhuTExFcGxuTUxoaEpoMEl2dEcxenp0NVFOeDl3bGlHaDROZkdza1lBZFNq?=
 =?utf-8?B?a1VvWXgzZkxxTkxXSUdnMjZ6Mlkzc001YXRFTWVEMHlnMHVTWmJ4U09jUE44?=
 =?utf-8?B?dXp0S0hCQWpuM05CU1I3SmxPNEFuSENRR3ZRcXc3bWhkTCtTZ2dENEwwWVo4?=
 =?utf-8?B?SmZxMGlPRnI1aHlvUG96bzl5c0RXdUFYNzlMR0JaQ21kV1lOdzc0bGpJZERV?=
 =?utf-8?B?Q2RPUlU0SkM2VG5nUlFkekJSWVB4ZldxTXRDVzV0alh0STErUHMyWWpKTDZa?=
 =?utf-8?B?WUNlZlVuNnZhaXZzT2d3UFZGdW9mYVVuUzMzaEw2ckVlR3dJSkFNU250bGV4?=
 =?utf-8?B?aFE2eHJPWUVLR2NSRDd4VEJ0aTBEaU5DeTZjSW14N1VFc1RRcFJGZ1Vxb3ls?=
 =?utf-8?B?TE02S0JSQVIxWm8veUxDd3hMN3lBczZibEo5ODhkMHVRNHpsclp5aHdTb1ZB?=
 =?utf-8?B?WU42MC8vOHhYMzhIZmEvNS9OcFFRQzNwZWprbnNjd0lMZnR4Qlk1ODBiZzM5?=
 =?utf-8?B?TFV3WUR5Ni9rQnIxM1NPb2tkSnRjY0RHdUxIYWlWelhUWlU0bVpSekk0SlBz?=
 =?utf-8?B?RGo4aTJWTExaV2VWUU43OStPOWhuQ1I1R0pUN0xaSnpHNWNzOFh1NitWTk84?=
 =?utf-8?B?VEV1TWRJemwxSkJxR1pjam1mZHk0N2UyMkNpQ0NrbVVUMXhUVkh3Rlh5a3p4?=
 =?utf-8?B?cmdwN3k1TDdpVjN6d2JLSUNGS0N6MHNTbTE4UG5pTjRJL0I5dkhzOEZMd0Jw?=
 =?utf-8?Q?TDxqT0v/7SD3hN6XtB7I2xGQp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b02ace-0321-4e36-45b8-08db87926a8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 13:25:12.5508 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EgqG3EJV27LuAyxeEXu5Eo6xS+z+vI7fuZRgUzgVxsXYtvTJCrSgoVIyMsfm0z/AhV7npKEF99LDH5TTT2RdoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6831
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65; envelope-from=wei.w.wang@intel.com;
 helo=mga03.intel.com
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

T24gVHVlc2RheSwgSnVseSAxOCwgMjAyMyAxOjQ0IFBNLCBJc2FrdSBZYW1haGF0YSB3cm90ZToN
Cj4gPiAtLS0gYS9taWdyYXRpb24vbWlncmF0aW9uLmMNCj4gPiArKysgYi9taWdyYXRpb24vbWln
cmF0aW9uLmMNCj4gPiBAQCAtMjA1OCw2ICsyMDU4LDIxIEBAIHN0YXRpYyBpbnQNCj4gYXdhaXRf
cmV0dXJuX3BhdGhfY2xvc2Vfb25fc291cmNlKE1pZ3JhdGlvblN0YXRlICptcykNCj4gPiAgICAg
IHJldHVybiBtcy0+cnBfc3RhdGUuZXJyb3I7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50
IGNsb3NlX3JldHVybl9wYXRoX29uX3NvdXJjZShNaWdyYXRpb25TdGF0ZSAqbXMpIHsNCj4gPiAr
ICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsgICAgaWYgKCFtcy0+cnBfc3RhdGUucnBfdGhyZWFk
X2NyZWF0ZWQpIHsNCj4gPiArICAgICAgICByZXR1cm4gMDsNCj4gPiArICAgIH0NCj4gPiArDQo+
ID4gKyAgICB0cmFjZV9taWdyYXRpb25fcmV0dXJuX3BhdGhfZW5kX2JlZm9yZSgpOw0KPiA+ICsg
ICAgcmV0ID0gYXdhaXRfcmV0dXJuX3BhdGhfY2xvc2Vfb25fc291cmNlKG1zKTsNCj4gPiArICAg
IHRyYWNlX21pZ3JhdGlvbl9yZXR1cm5fcGF0aF9lbmRfYWZ0ZXIocmV0KTsNCj4gPiArDQo+ID4g
KyAgICByZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiANCj4gVGhlcmUgaXMgb25seSBvbmUg
Y2FsbGVyLCBtaWdyYXRpb25fY29tcGxldGlvbigpLiAgV2UgY2FuIGNvbnNvbGlkYXRlIHR3bw0K
PiBmdW5jdGlvbnMsIGF3YWl0X3JldHVybl9wYXRoX2Nsb3NlX29uX3NvdXJjZSgpIGFuZA0KPiBj
bG9zZV9yZXR1cm5fcGF0aF9vbl9zb3VyY2UoKSwgaW50byBzaW5nbGUgZnVuY3Rpb24uDQoNClNv
dW5kcyBnb29kLCB0aGFua3MuDQoNCj4gPiArc3RhdGljIGludCBtaWdyYXRpb25fY29tcGxldGlv
bl9wb3N0Y29weShNaWdyYXRpb25TdGF0ZSAqcykgew0KPiA+ICsgICAgdHJhY2VfbWlncmF0aW9u
X2NvbXBsZXRpb25fcG9zdGNvcHlfZW5kKCk7DQo+ID4gKw0KPiA+ICsgICAgcWVtdV9tdXRleF9s
b2NrX2lvdGhyZWFkKCk7DQo+ID4gKyAgICBxZW11X3NhdmV2bV9zdGF0ZV9jb21wbGV0ZV9wb3N0
Y29weShzLT50b19kc3RfZmlsZSk7DQo+ID4gKyAgICBxZW11X211dGV4X3VubG9ja19pb3RocmVh
ZCgpOw0KPiA+ICsNCj4gPiArICAgIC8qDQo+ID4gKyAgICAgKiBTaHV0ZG93biB0aGUgcG9zdGNv
cHkgZmFzdCBwYXRoIHRocmVhZC4gIFRoaXMgaXMgb25seSBuZWVkZWQgd2hlbg0KPiBkZXN0DQo+
ID4gKyAgICAgKiBRRU1VIGJpbmFyeSBpcyBvbGQgKDcuMS83LjIpLiAgUUVNVSA4LjArIGRvZXNu
J3QgbmVlZCB0aGlzLg0KPiA+ICsgICAgICovDQo+ID4gKyAgICBpZiAobWlncmF0ZV9wb3N0Y29w
eV9wcmVlbXB0KCkgJiYgcy0+cHJlZW1wdF9wcmVfN18yKSB7DQo+ID4gKyAgICAgICAgcG9zdGNv
cHlfcHJlZW1wdF9zaHV0ZG93bl9maWxlKHMpOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAg
IHRyYWNlX21pZ3JhdGlvbl9jb21wbGV0aW9uX3Bvc3Rjb3B5X2VuZF9hZnRlcl9jb21wbGV0ZSgp
Ow0KPiA+ICsNCj4gPiArICAgIHJldHVybiAwOw0KPiANCj4gQWx3YXlzIHJldHVybiAwPyAgTWFr
ZSBpdCB2b2lkLg0KDQpPSy4NCg0KPiA+ICtzdGF0aWMgdm9pZCBtaWdyYXRpb25fY29tcGxldGlv
bihNaWdyYXRpb25TdGF0ZSAqcykgew0KPiA+ICsgICAgaW50IHJldCA9IC0xOw0KPiA+ICsgICAg
aW50IGN1cnJlbnRfYWN0aXZlX3N0YXRlID0gcy0+c3RhdGU7DQo+ID4gKw0KPiA+ICsgICAgaWYg
KHMtPnN0YXRlID09IE1JR1JBVElPTl9TVEFUVVNfQUNUSVZFKSB7DQo+ID4gKyAgICAgICAgcmV0
ID0gbWlncmF0aW9uX2NvbXBsZXRpb25fcHJlY29weShzLCAmY3VycmVudF9hY3RpdmVfc3RhdGUp
Ow0KPiA+ICsgICAgfSBlbHNlIGlmIChzLT5zdGF0ZSA9PSBNSUdSQVRJT05fU1RBVFVTX1BPU1RD
T1BZX0FDVElWRSkgew0KPiA+ICsgICAgICAgIHJldCA9IG1pZ3JhdGlvbl9jb21wbGV0aW9uX3Bv
c3Rjb3B5KHMpOw0KPiANCj4gSGVyZSB3ZSBjYW4gc2V0IHJldCA9IDAuDQoNClllcywgYWZ0ZXIg
bWlncmF0aW9uX2NvbXBsZXRpb25fcG9zdGNvcHkgaXMgbWFkZSAidm9pZCIuDQo=

