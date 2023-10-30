Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA0D7DB225
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 03:49:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxIKK-0002vt-R6; Sun, 29 Oct 2023 22:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxIKJ-0002vf-AV
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 22:48:27 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxIKH-0001T7-8N
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 22:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698634105; x=1730170105;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=b2YktOpfMc1IfNn9qm4QkJepeQwmHget7n5h9liFbRw=;
 b=c90m7RKIyCCiDgkH8PCd28SOondvp9Mv6gIuzmPSAnbEpyl3kQhxchbE
 vI/lbaCQBDhSvEETk7jtQSR78DZuX2RHwhATZgeP+DDqaReVdLJJqsSpD
 WVEbPFCp9zYvL2t8We/9mvwtw29m0kZOg8I/QVrFFRr/QcplCbldViUkv
 jOKmBJBVS3kogCSWMVIIOeziserRsc1POCIYdQz7gFbM6Ii98j0OFXjkn
 xohj9jqPyiVLIJ9sKS4dV7XAwlCuBGFgMwa13/+NXDZNy5mJgu0diSV7z
 6lFxrBruwlRTku6VqN+ocxWJ7Jm91BDeerNdN+vq07AKPSSmUOuT35E+z Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="367347194"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; d="scan'208";a="367347194"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2023 19:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="760135593"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; d="scan'208";a="760135593"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Oct 2023 19:48:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 29 Oct 2023 19:48:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 29 Oct 2023 19:48:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 29 Oct 2023 19:48:19 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 29 Oct 2023 19:48:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTuLwIsUevwLMKYC8sw0Pq0wrhGtwtGJeXnvV7TnQprsXBSMCj+Je9s/feHJM2zxg4k8gqDnUMNsBCw9WCsXFMcxsi5ucnqjfVExk4hgd1utfHRpHEnaYbnfe9/KcJk1pXvSUorJjALiwJU8nwFjf0qSeRaHw4n/lrWEdBjySPZ3Hng3EY120hMvjGuAeIVbjiCqoz2rK59qPgDZfDa6YMoxxLMGBf8lhz0w2sks4rxrEFofF4K3V5HY+qRNqW0FGu5yAI1izF2l/hkwqpeQ7M1TN16ahBI1eaBi7bm9oOBX9R6u3HgHj5X/u/VznKc2HNHeRTJQXRF4bd7XN4hZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2YktOpfMc1IfNn9qm4QkJepeQwmHget7n5h9liFbRw=;
 b=fwYvddtrUW5ECDL1irEaul1g8UtdMAX0KGC+wTbsnM3QDCXCTbWw+hifZGDVbOQZYvQDfqZhK+U5/Vg0AxGmUGBGhntBRpJ0zWOdXNUseGZiZ8Uz20ny7gQ7fi5eN50o/a8B/Tk0JTc03imgx1xtCLAHk9/kxz4Jr5EATlcqPemAmOVAf4xEX+YAacmcAshV38Y3M9iFJd0CJF5rt+whxueojg2lUN0QrcJ+d52H1U2JTiRwGjgeFrbL30/SNGdGz3y7m0d4AV8XtIZts5WqhD4U7aa+XKZjWyBKBpCOcmPK61AZGhCO/SAJzJzoeeqPgqflhj50oB76Xs6C6rIWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 02:48:03 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6933.024; Mon, 30 Oct 2023
 02:48:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v3 08/37] vfio/container: Switch to dma_map|unmap API
Thread-Topic: [PATCH v3 08/37] vfio/container: Switch to dma_map|unmap API
Thread-Index: AQHaB/m6pQ9td+ie/kuQbarag5PzgbBdsxaAgAPzEcA=
Date: Mon, 30 Oct 2023 02:48:03 +0000
Message-ID: <SJ0PR11MB6744024A038A26AD61EF9ABA92A1A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-9-zhenzhong.duan@intel.com>
 <1e5db685-0d49-43f0-8ff6-bc9f88d05131@redhat.com>
In-Reply-To: <1e5db685-0d49-43f0-8ff6-bc9f88d05131@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB4914:EE_
x-ms-office365-filtering-correlation-id: 9d631595-e124-4c98-8e6b-08dbd8f2a318
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6rYDf064jBXaXKb6a3FraPsO/B71RA8gWuLeZbvGbOMLLgJ+wLk5XJ3nXO4ZeWqZ1z0CTBk3lBKNMAvMFmNXbZZy8rLdCVJb6n156V3ZMwt5fFO3XP9FESeDrVrNEebuT2DPjGIjtKHr99/kmDEqCGMkTHZqO5dEtkCsdYkJsk7hpzOPxdTJHQgf25+3qddPrmzQhaOLH+vG2G77zfi+VVmUv6DBBTFMpvYe6I1Y0sJgj91x3ZdqKjbmsy+mZa+iK6cqBIJ1ZsITQI2vj2RkyB5B+1wF7s7Rm/ds2b0E4QljGOopMswqg9m8gHtEirziKXQuVx+lxQaeSI5xQh8vt9JFM8PZvQgkFV9XbRpakdF+eKbWow1UgmE+IwQLjZxB00QkzY4bVHF+koco05ncgnHKVNf4+P/ZQOxVFeEHBV7pOUcnBrztYZuwqI9R5ZPIAEsqOQ9vY0k4Kb7G9jAS5vbilVLKP4jJ8t8quABA9tkA5G3g8/SBFisKbi43AmIyK4wxFHRpMwa/5NTSvrxQ77dAU34/JN9wwxLqWy8djqf1oTS8G5cKjqCDBQAlhZkebA3TZFBeVl+yduwyCG5GNrvNsYD9LI+jZjitM6hiQ4SLG0FMkdZAZDyKs+QekNsk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38100700002)(83380400001)(122000001)(26005)(9686003)(6506007)(7696005)(55016003)(71200400001)(33656002)(82960400001)(38070700009)(86362001)(54906003)(64756008)(66446008)(76116006)(66476007)(66556008)(66946007)(110136005)(52536014)(4326008)(8936002)(8676002)(41300700001)(5660300002)(2906002)(7416002)(478600001)(316002)(2004002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzRzMUNiS2dVMDNtdm1wSEV6Q29NN1llSEdWTGhGTUp4VW0vNytPM0ZHWUVm?=
 =?utf-8?B?RFhNSWprZndvUE5hUXE4SUxPSzhYRWllZVJtRkgwak9qK3U5MFZEaU5sU0Jl?=
 =?utf-8?B?aW1RdURPU3c1SmlNODJDYlZZYWcwdzg0VG45VGFxWFIveHNYMUV0Q2NyQllG?=
 =?utf-8?B?OHBFZldzTjBlMzN3RlN5bWk2L0ZTcTA0eXdZcGt5NjY5b2U2c0FXMVNqUmM1?=
 =?utf-8?B?ditBdEJIWGtrdTVBQXRyWWlXM0lUalV5Q0hYcnovck43TXdENWdGSThRcWFz?=
 =?utf-8?B?RmhOeUpYMjZ5ZnZBdnZyRUxTakp0Z3dXLzlKdEtoWERVdDU0anhSSmdWMUIy?=
 =?utf-8?B?eWVJMld2L1FjSGZEVzgyTHpsdFAzMEpqUU1yTVBDb3JKTUcyUURhYVA0ZVJM?=
 =?utf-8?B?bE1nOVEvMktISlNraTQvckJxelp3azczYlFUYmtQVTh2dUR6MmI2N0hjempi?=
 =?utf-8?B?MFllM2pjWWRnN0VrdGt5bnY2UWlBY3h5TC9oY2VPNkVlRFFmUW11bG05WVdy?=
 =?utf-8?B?dTVFWmdJcm9wdnZrWnF4ZHZnVnRObFpONUtvNlFJZVVvTVJBWEV6eG1ub21m?=
 =?utf-8?B?emJRSzFyTFNDT2tCUnBPcFRBdWFPRGI5azhOVVlXMlM4ZEQ3akJuUndjY3kv?=
 =?utf-8?B?UDg0emhtNmZGQlRrSFJvejRLaDc4QWJQOThkLytkMGJPT1R3SzJldFdTbmwz?=
 =?utf-8?B?aWRhWWxJTllYOEpzL2ZkYmVRSzRHSGxWeUJabWkrRXJ3Wllwd3pUM2ZwSnVG?=
 =?utf-8?B?Nk9wZm1wbmQ0bGh1Q0RuTHdtZTRTRE9NMWpvNS9aZk93b0lYZnpocWJnL0p4?=
 =?utf-8?B?ai9XUityZFFUOE9FaWQ4OXJua3l4SFRNRlVabDhaUk5FOWZJWTErUlVLT0gx?=
 =?utf-8?B?YXpxeTdhQUo4dGtQV3RNWlA3cWZxMzJtWVUxSi9yV0R1NjJpTTFLTW85WWFr?=
 =?utf-8?B?b2IyOVhOT3Z1K2ZvNU0vTVJTTEgzZXdGRjVXa2Z5TFdwWTh1VWdXTVF0NzJi?=
 =?utf-8?B?TmRWNm5KNitMaTBwMCtWUnJaemhLSWRUSngrOWZESFFQUjFoeGp6SUc1Q2ts?=
 =?utf-8?B?ZkdZL2FjZDN4SXROY08zZDJuTXJBK0IvR0tJdWhYdnF4N3QwV1k0YXZqL3N6?=
 =?utf-8?B?cEFZM2wyS0JydS9ZRlJIaXllazNHVGlVUGNvZklNSktvUWJEd2ZEbkFWZzFS?=
 =?utf-8?B?WElWZ0ZHQkpzb1FHSDFBSGp3aEViemt0RUljWGg5cG5BOXozLzZiclQ3NUNO?=
 =?utf-8?B?U0dHMWVrOUJiakg0QVQra0ZDWWllWVY1cUZrU2hEQ0ZrWCtmSHJVUEdsR29T?=
 =?utf-8?B?bHpNRGhvcE5DY25pem9LdWRnVks4VGx2RXVsMGVyeW5TVk01VkVLeWUzNUgw?=
 =?utf-8?B?V0kyS1d3ZFJuSytBS2RJM3pocVdQSGs5MHhjQzdIR0FYaTJXejdra0FjK0tX?=
 =?utf-8?B?UFZac1diNEVZT3dXK3RGMEFRVFhURE9VY1Q0TTdRYnB2enVVajhybCt2WGs3?=
 =?utf-8?B?WjM1NXRlZjZwNVUwMHgwOWs1WTVDS0R4ZU1CWXhzSllBVGtxcllseldLQmtN?=
 =?utf-8?B?dFJVbno3NkErQWU0VHFZNTZQT05GcHdnK0U2THRXcEhSS3Q3MVUvb05sWEJN?=
 =?utf-8?B?NytDcmNqVzczVEZYR2JwQ1ltOUtHektqNnRsN2NvMXBYUlIrQ2p3QUY5OEl6?=
 =?utf-8?B?Y2lST2V4N09zUkZ3M1EvSHJzM3ZSZmsyT0dpYjBoNzdPRktTNFFSL1NwMzho?=
 =?utf-8?B?S0tCeFlaOC9JTnBHUG1vRnhSYWpiZUdGZzhHb2txYzFTN0t2b2RqVHU1Q3VH?=
 =?utf-8?B?STJDWjJoS2tRUmppMlhOTVdYZFdiVXNwZzBqYUpsTnVTMWYrUXRwVzlNajY1?=
 =?utf-8?B?L0MxbXU1NTdHWU85cE5JVnpSd0NteXB3NTRTVGdEcXQyUkFrVVlMS3ZHb2xy?=
 =?utf-8?B?NC9tSk9YeG4vbDNYN0lJWCtqeVgvS2ZrU25nUkp6WHI3Tk1TUmE4L3lvZVFO?=
 =?utf-8?B?ejFNZFAyNGMzNm9VTzVKWUFibVBrYjcvVE9TQUZFVnhMSm5OZmF5V2J2Z0pW?=
 =?utf-8?B?bVVPVVFyUksvQU1WMXNDSE80Qk00QkpwMU1hU2VmWnpXQkJUdEt2QzFLNGtq?=
 =?utf-8?Q?ilW7tJUHjMAA17BHdKq7yLUVS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d631595-e124-4c98-8e6b-08dbd8f2a318
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 02:48:03.2723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibDGHrTIULsrEvFwvS/iRP/yFTN2mnr8E9PTjYWUC0T5DJAauzgvBInpCAkyheEI57BO6JiDBIcb/OJe7tgw5IntCuIZu2zPHXLGhp2HzBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4914
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.478,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIE9jdG9iZXIgMjcsIDIwMjMgMTA6MjYg
UE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDA4LzM3XSB2ZmlvL2NvbnRhaW5lcjogU3dpdGNo
IHRvIGRtYV9tYXB8dW5tYXAgQVBJDQo+DQo+T24gMTAvMjYvMjMgMTI6MzAsIFpoZW56aG9uZyBE
dWFuIHdyb3RlOg0KPj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0K
Pj4NCj4+IE5vIGZ1Y250aW9uYWwgY2hhbmdlIGludGVuZGVkLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6
IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5
aS55LnN1bkBsaW51eC5pbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVh
biA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KLi4uDQoNCj4+IGRpZmYgLS1naXQgYS9ody92
ZmlvL2NvbnRhaW5lci1iYXNlLmMgYi9ody92ZmlvL2NvbnRhaW5lci1iYXNlLmMNCj4+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwLi45ZGI4Yjg5YjJmDQo+PiAtLS0g
L2Rldi9udWxsDQo+PiArKysgYi9ody92ZmlvL2NvbnRhaW5lci1iYXNlLmMNCj4+IEBAIC0wLDAg
KzEsNDkgQEANCj4+ICsvKg0KPj4gKyAqIFZGSU8gQkFTRSBDT05UQUlORVINCj4+ICsgKg0KPj4g
KyAqIENvcHlyaWdodCAoQykgMjAyMyBJbnRlbCBDb3Jwb3JhdGlvbi4NCj4+ICsgKiBDb3B5cmln
aHQgUmVkIEhhdCwgSW5jLiAyMDIzDQo+PiArICoNCj4+ICsgKiBBdXRob3JzOiBZaSBMaXUgPHlp
LmwubGl1QGludGVsLmNvbT4NCj4+ICsgKiAgICAgICAgICBFcmljIEF1Z2VyIDxlcmljLmF1Z2Vy
QHJlZGhhdC5jb20+DQo+PiArICoNCj4+ICsgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2Fy
ZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQ0KPj4gKyAqIGl0IHVuZGVy
IHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVk
IGJ5DQo+PiArICogdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24g
MiBvZiB0aGUgTGljZW5zZSwgb3INCj4+ICsgKiAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2
ZXJzaW9uLg0KPj4gKw0KPj4gKyAqIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUg
aG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLA0KPj4gKyAqIGJ1dCBXSVRIT1VUIEFOWSBXQVJS
QU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mDQo+PiArICogTUVSQ0hB
TlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQ0K
Pj4gKyAqIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuDQo+PiAr
DQo+PiArICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVy
YWwgUHVibGljIExpY2Vuc2UgYWxvbmcNCj4+ICsgKiB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90
LCBzZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+Lg0KPj4gKyAqLw0KPg0KPlBsZWFz
ZSByZWR1Y2UgdGhlIGhlYWRlciB3aXRoIGFuIFNQRFggaWRlbnRpZmllci4NCg0KV2lsbCBmaXgu
DQoNCj4NCj4+ICsNCj4+ICsjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPj4gKyNpbmNsdWRlICJx
YXBpL2Vycm9yLmgiDQo+PiArI2luY2x1ZGUgInFlbXUvZXJyb3ItcmVwb3J0LmgiDQo+PiArI2lu
Y2x1ZGUgImh3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oIg0KPj4gKw0KPj4gK2ludCB2Zmlv
X2NvbnRhaW5lcl9kbWFfbWFwKFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVyLA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciBpb3ZhLCByYW1fYWRkcl90IHNpemUsDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqdmFkZHIsIGJvb2wgcmVhZG9ubHkp
DQo+PiArew0KPj4gKyAgICBpZiAoIWJjb250YWluZXItPm9wcy0+ZG1hX21hcCkgew0KPg0KPkkg
dGhpbmsgdGhpcyBjb3VsZCBiZSBhbiBhc3NlcnQgaW5zdGVhZCA/DQoNCkdvb2Qgc3VnZ2VzdGlv
biwgd2lsbCBmaXguDQoNCj4NCj4+ICsgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4gKyAgICB9
DQo+PiArDQo+PiArICAgIHJldHVybiBiY29udGFpbmVyLT5vcHMtPmRtYV9tYXAoYmNvbnRhaW5l
ciwgaW92YSwgc2l6ZSwgdmFkZHIsIHJlYWRvbmx5KTsNCj4+ICt9DQo+PiArDQo+PiAraW50IHZm
aW9fY29udGFpbmVyX2RtYV91bm1hcChWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lciwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciBpb3ZhLCByYW1fYWRkcl90IHNp
emUsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVVRMQkVudHJ5ICppb3Rs
YikNCj4+ICt7DQo+PiArICAgIGlmICghYmNvbnRhaW5lci0+b3BzLT5kbWFfdW5tYXApIHsNCj4+
ICsgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4gKyAgICB9DQoNCmFuZCBoZXJlLg0KDQpUaGFu
a3MNClpoZW56aG9uZw0K

