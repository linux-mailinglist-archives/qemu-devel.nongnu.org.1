Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AC97EDC5A
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:50:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3X5A-0008LP-UE; Thu, 16 Nov 2023 02:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3X4s-0007Q5-LZ
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:46:22 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3X4p-0005fM-NX
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700120776; x=1731656776;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mdiJqnsaFzx4J6zSUj58bv0P+dBTI3zPMK8EAP8ASCY=;
 b=FDb7GbRbQ+HXXdsl29JY8LTOEq3ISbE25mmFIZW7PHa4243SNV0AmK1w
 UeC7Dd0PkwLrw1ix2HhcJgfEd8/Vl7tvy00bHu3W0EzctTFxNV0ZlMf1A
 8JpzGBadzNErb6Yr9tHpf/i612JuedNtdXs8Dqt08KFQOoXd756EFm6x2
 dikQebJnk/tsZ+pk9xuq1JO/P6cvKzcZ7VC7DwGHRjoA24GeqE0QsZjT6
 FDa9MsmGtdtu3/2DkukvBketDzgQio2U8dU4UGTMBYlWXDcGdCqnGXZat
 mndRVo3tKvF+3tzDsYHSaQOL7VfMt6ME6lqvsJgtLq4VN08b5bU1UWiUh w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="9675052"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="9675052"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 23:46:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="938762944"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; d="scan'208";a="938762944"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Nov 2023 23:46:13 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 23:46:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 23:46:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 23:46:12 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 23:46:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNwmlDh8yn+4iyyHuMiV5q+UQLrm/Msg7+HQyqE5XpC0XPXqIroNCwKcjc2fDJmhK/zPaVIpTRYoGFxbfKJBrRlSIcXe83jbsNr1kWyGYU1faQylvasif2FtpnntA9PgFWg6xEb0WWJ/kcm0cYjMMlfjzKg+oY4UwSzpQGonaPC1SZoqQTla80HasZVO46+anTIRejvrDzeAnWvRb8Qf0I2CmbR37/rImUidTmiPlho5hFw1vsSTSpew9AHhwr4ijZpde7QqcMuHNFUmKumQ69RC1rpnC7YxadKCofdJ1U/25l74ZUCOHJTRmd2ubrIjrQWYx2jXhG7UIcBP8J3yGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdiJqnsaFzx4J6zSUj58bv0P+dBTI3zPMK8EAP8ASCY=;
 b=iKBbumyy2zsXVn4DPSmbXq+pRBYrrH3uZqhuHRXSF3sgT3bKqeW+6rvxFSeaWdFPfqU+rDX6rCJBwNO0qwI/kCbnD6CW/5CwDyURnP8cQkejiqETvcHrT9sXIf9k5iS42KNurBlwcZLxT6As38Rddzi/CzvlAf9kXzQLVqpU7QvOHOpxz471Dwcj5VSMc2ZADs8Az971WWacjlzzeYx0c7gznFe1lzrXxhVFryH2Pa5sd2ntZb3sOyBTfS8oQ0q27HQfKV1CZmZOl82Sm/JMlLS7ZVZeIu5C0ju+zmHYPfYYFcEFKaP6tqyCZzeDjt1jsSdd5f44j1Md35D8oDgEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB4975.namprd11.prod.outlook.com (2603:10b6:a03:2d0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 07:46:10 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6977.029; Thu, 16 Nov 2023
 07:46:10 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH 1/4] vfio/pci: Move VFIODevice initializations in
 vfio_instance_init
Thread-Topic: [PATCH 1/4] vfio/pci: Move VFIODevice initializations in
 vfio_instance_init
Thread-Index: AQHaF6B1Bv9BpMJmgkqK874EmoZbP7B7W0QAgADbEZCAAFeKgIAABLVw
Date: Thu, 16 Nov 2023 07:46:10 +0000
Message-ID: <SJ0PR11MB6744895560FF0C11643BD59F92B0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231115083218.1973627-1-zhenzhong.duan@intel.com>
 <20231115083218.1973627-2-zhenzhong.duan@intel.com>
 <fcf2c5ec-ca54-45c4-b6a6-4f302a6cddf7@redhat.com>
 <SJ0PR11MB6744ED3C5F3F828BECBDC6FD92B0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <2da90861-3f10-47cf-9f6e-39d52b8c929f@redhat.com>
In-Reply-To: <2da90861-3f10-47cf-9f6e-39d52b8c929f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB4975:EE_
x-ms-office365-filtering-correlation-id: 62e47480-3564-4897-78b9-08dbe67819a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gWXwQkSN4iUFjpzGu0efgFprT19n6XvLWQCrWnEA500DUr5tjSs4va514oKyzD3Jg7k/Q5N47bL6s09GFsiCj9ltycrWrnZVho7NESF33yl9y5WqDFsI/SVqXM9KKkDhlCL4Pbt5FugYSE/fLYt0+33R18Dwl4cxFAPAqz0H/iF1KwdZdJhjWQoll1FL5o/8X1kXk/5WkKNK43u0xh1Ik3LaHFoTBPDun2qYFFc8NtLm/Dke7OErgUF/QA/DYX8fqmmKRl+gw6FoErN+l5vRo+/SpBpWNXI/7ohTbqbDeXVfhjJedek09GhXb45cIlY5BWOpPrhour/9maSDAu2rT5xWjn10ofnhvFziiwZdNrQzssYNfoJnLW7M5PPjibLYJy+VYegzK4C4UUqP3ReuVMj2dEzhVBLrVYbk5ZQDhPpvFZXRBmnxavbjQ0tmCih7C40ef7A/qr57dXJg2DsusU6034vElROOO8WJP955tcVSacK4fLkFCk/w4ADBEHObgNZC1aruF195dXA7yLZJJwDbkVaohrbtidwKUK+p7rCfSuoGnIJSlEhzI6JgWasuaF24Bp7YJx2D3nkFj7nqVp1jvjHCXhnT2ECVsEqhr/Aas+sTeCeKdsGixP8fSEaV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(82960400001)(122000001)(38070700009)(55016003)(86362001)(83380400001)(26005)(7696005)(478600001)(71200400001)(110136005)(107886003)(38100700002)(53546011)(6506007)(9686003)(2906002)(41300700001)(33656002)(8936002)(52536014)(5660300002)(4326008)(66556008)(316002)(66446008)(66476007)(64756008)(76116006)(54906003)(8676002)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QW80amJ6Rko2ZUhZMVlWamVya2hyeDNaWUZMWmk4TXpGWlIyQzRZY2hWTys4?=
 =?utf-8?B?ZGFKYVVzWE1RdmNQVitYajg1QTloL29mbDZzaDVOM2pVTUNQWC9oK2FmYVVG?=
 =?utf-8?B?ME1HQWpjenJ3UEpzeU14TjlOamluMkNPeUdHelJaYzloTFJsTmJVVDNzQ0NN?=
 =?utf-8?B?SmdnTkdmbFRhMHlaY21xTXRwMHg3MjQ3Rm11NVpWN2hRd0NCZlJYbGRQcDhQ?=
 =?utf-8?B?clh2OXVVYUhSd3B2cUxsek5iV0ZLUy9jMUV2YzJ3R3FZc0IycmdGR2RSd1J4?=
 =?utf-8?B?WktHeEpKSitDeXdoLzlBN3V1ZEd2b3BRTmNLZU5maVFPYlJSSFg1cFIrSHVY?=
 =?utf-8?B?amtzM0pxb3BrTzAxQnUwZXVMTTJqWUVOa1F1TEo2OUVnRmhXUTlwQzlpcFdP?=
 =?utf-8?B?cHFkNVVtV3RrcXZLa2cwbUgveGp6aUZ6OFltNXhpS3pQVTYzWHREMUpqc3pn?=
 =?utf-8?B?dWV3Zi9uOWFOblpqcFppelAyWjhOeTBvOGN5SGI4anlydHlwVGl0Vkdpc3pl?=
 =?utf-8?B?bVphRW93Q3BaK0lCVmJhR2hXZ1NBWDVKVFZJdytuU2dtYU9qRVgrOHNJc0FL?=
 =?utf-8?B?eEtmN3NobXYvcWl5Mk0wRVN1YkZxSTJteUhJMTh1ZEVqQnJPSk5hTSszZ1M4?=
 =?utf-8?B?WTU3QkhoV09rb0U3Z3ZHcjNPbzNMM2tlYlZ2YlUyZmI3WDBxNVdOSWdzUzhE?=
 =?utf-8?B?c2ZMbHhBVzdrUFJjbWFjb0Evb1hsbGRZWWhDZStqYU1iZUl1R3Y0TUtaYXVl?=
 =?utf-8?B?SWozTUt2WWhSNUNzVEg1NXRNSnk3Qy9zb2w5RG85WVJGQm9NTnJ1WGtwWm85?=
 =?utf-8?B?bTFiQy9iWjlHM2lacitWb3dxM2cwdllHN1ZUcTJ6TEhEai9iRThOdUUwdHBN?=
 =?utf-8?B?MnpKY3lkLzlIbFFzUFEzTGt4d3RHdFJlYmpYY1crcUpUZmc1RG9XTnN3MlpM?=
 =?utf-8?B?Vy83WFd5aHZNeWREM3RsZGFhNklPMUFoMlhoZThaajByVWRmV0ZhcGFybUlZ?=
 =?utf-8?B?dXB6NEE1UjYzZzVKSzl4MDc3ZDJIUHRnZ09GMXRTUmtlb3Y5c2FXdWFNbFUw?=
 =?utf-8?B?WUVLSFAyQk1sdXFrS3BkQlhnU0puSm10dGZtVitWUnkwZmt6V2RqSzdCYW5y?=
 =?utf-8?B?OFliZ3doT041dUxHY05IM1RheXdVK3hvTHJUMHZvOXE0cFJMVWVYeEVIS29J?=
 =?utf-8?B?UGNqRFJuazdOZ2E3bGxwZUpSeXJUUGJMZ1oyWjBRQS9ZT3c4WC80K0hMOUVm?=
 =?utf-8?B?M1c1aEFMZDdSQWVjNEZEOFFlQUpUck1oaUM3SHJnYTIxcjR5RjBMRWF4MHVz?=
 =?utf-8?B?aDlyekQ4UjF3T3IwYU9ReVpjVmhhdkxvOUhid0diTTZ4TS9VSXc0eUc4RTJM?=
 =?utf-8?B?MG5pUU9GemtzVmNlN3orUEpTbVF1RVovbjlqSDhDS20vUzZZb05EbHJlYkZj?=
 =?utf-8?B?bmFUT0I0WlFyV204Yk44SWVrVUMxUGVqdGx6SmhNMzJYL0ZCWGtWem90bEVV?=
 =?utf-8?B?MUUzZ2dsc0czTEVSdzRsWmg0ZTdpaVRBSHZiSGlxZzA0dTlObmpoSC9sN2lw?=
 =?utf-8?B?SkhraThkOXVXMG9vL1FPVmp4dTdIVDN0UlhsZWlyaXkwTUlDTkovRm1seEs2?=
 =?utf-8?B?VHRJVEJmcVRzazFpOElJdlFKTVZnbXZrTXRuQTN2VGtJMFBJbTBKT2kxUFY3?=
 =?utf-8?B?OS96NTU0bUsrWFZickFVUjc0Z0Z2cmVINmpWdVRsVmxMMStQaWVQeEpSL2Zm?=
 =?utf-8?B?K2Y1Y0dMYXphQm1MWE1Xd09PeGxvN3Q0S2R3S09VTVhvTGRaYnhXYmFLbVpX?=
 =?utf-8?B?NlVQZlJFaEdyeGxCemJYd05sVG9HTVJaQmpiZ01FNEVMSnhteVFnYWs2dG9B?=
 =?utf-8?B?NFNGcTVYTER4cml2aWRleUVadVJkeDFHWHJaTFZGeW5JRU9BakN4MXM4VW96?=
 =?utf-8?B?TTJyQTBqYU5qYjhjRjIvQldZMDdtR095Yjdwa3NpakIwT0pVZjREOTY5VUhU?=
 =?utf-8?B?amFPQ2p5UStUZmZVSFBoNGo0SkNPQ3RaWDhidTY2cWM0dGduUW5kMnVYemJp?=
 =?utf-8?B?S09aRDRGVVJXQkFhVVM1bVl2ZVR1Rk5VN295aDJ3YUtyTG5iaFVxRko5WXBH?=
 =?utf-8?Q?pwFewaUj24rbYGxn7dkbjyKGW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e47480-3564-4897-78b9-08dbe67819a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 07:46:10.3265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AhwHglrK32dgtDcFMuke+NSPFNyU4Y4hXaskcRIc6mYsLVDwmbtbqaAtkKVCV7C8dv8b2q0HHtAwbNJmXQzhc1p6TaWmIsIphvEGiKZvFS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4975
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTYsIDIwMjMgMzoy
OSBQTQ0KPlRvOiBEdWFuLCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT47IHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZw0KPkNjOiBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsgamdn
QG52aWRpYS5jb207IG5pY29saW5jQG52aWRpYS5jb207DQo+am9hby5tLm1hcnRpbnNAb3JhY2xl
LmNvbTsgZXJpYy5hdWdlckByZWRoYXQuY29tOyBwZXRlcnhAcmVkaGF0LmNvbTsNCj5qYXNvd2Fu
Z0ByZWRoYXQuY29tOyBUaWFuLCBLZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+OyBMaXUsIFlp
IEwNCj48eWkubC5saXVAaW50ZWwuY29tPjsgU3VuLCBZaSBZIDx5aS55LnN1bkBpbnRlbC5jb20+
OyBQZW5nLCBDaGFvIFANCj48Y2hhby5wLnBlbmdAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBb
UEFUQ0ggMS80XSB2ZmlvL3BjaTogTW92ZSBWRklPRGV2aWNlIGluaXRpYWxpemF0aW9ucyBpbg0K
PnZmaW9faW5zdGFuY2VfaW5pdA0KPg0KPk9uIDExLzE2LzIzIDAzOjE2LCBEdWFuLCBaaGVuemhv
bmcgd3JvdGU6DQo+Pg0KPj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZy
b206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4+PiBTZW50OiBXZWRuZXNk
YXksIE5vdmVtYmVyIDE1LCAyMDIzIDk6MTIgUE0NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIDEv
NF0gdmZpby9wY2k6IE1vdmUgVkZJT0RldmljZSBpbml0aWFsaXphdGlvbnMgaW4NCj4+PiB2Zmlv
X2luc3RhbmNlX2luaXQNCj4+Pg0KPj4+IE9uIDExLzE1LzIzIDA5OjMyLCBaaGVuemhvbmcgRHVh
biB3cm90ZToNCj4+Pj4gU29tZSBvZiB0aGUgVkZJT0RldmljZSBpbml0aWFsaXphdGlvbnMgaXMg
aW4gdmZpb19yZWFsaXplLA0KPj4+PiBtb3ZlIGFsbCBvZiB0aGVtIGluIHZmaW9faW5zdGFuY2Vf
aW5pdC4NCj4+Pj4NCj4+Pj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQuDQo+Pj4+DQo+
Pj4+IFN1Z2dlc3RlZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4+
PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29t
Pg0KPj4+PiAtLS0NCj4+Pj4gICAgaHcvdmZpby9wY2kuYyB8IDEwICsrKysrKy0tLS0NCj4+Pj4g
ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+Pj4N
Cj4+Pj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vcGNpLmMgYi9ody92ZmlvL3BjaS5jDQo+Pj4+IGlu
ZGV4IGIyM2I0OTJjY2UuLjVhMmI3YTJkNmIgMTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L3ZmaW8vcGNp
LmMNCj4+Pj4gKysrIGIvaHcvdmZpby9wY2kuYw0KPj4+PiBAQCAtMjk2OSw5ICsyOTY5LDYgQEAg
c3RhdGljIHZvaWQgdmZpb19yZWFsaXplKFBDSURldmljZSAqcGRldiwgRXJyb3INCj4qKmVycnAp
DQo+Pj4+ICAgICAgICBpZiAodmZpb19kZXZpY2VfZ2V0X25hbWUodmJhc2VkZXYsIGVycnApKSB7
DQo+Pj4+ICAgICAgICAgICAgcmV0dXJuOw0KPj4+PiAgICAgICAgfQ0KPj4+PiAtICAgIHZiYXNl
ZGV2LT5vcHMgPSAmdmZpb19wY2lfb3BzOw0KPj4+PiAtICAgIHZiYXNlZGV2LT50eXBlID0gVkZJ
T19ERVZJQ0VfVFlQRV9QQ0k7DQo+Pj4+IC0gICAgdmJhc2VkZXYtPmRldiA9IERFVklDRSh2ZGV2
KTsNCj4+Pj4NCj4+Pj4gICAgICAgIC8qDQo+Pj4+ICAgICAgICAgKiBNZWRpYXRlZCBkZXZpY2Vz
ICptaWdodCogb3BlcmF0ZSBjb21wYXRpYmx5IHdpdGggZGlzY2FyZGluZyBvZiBSQU0sDQo+Pj4g
YnV0DQo+Pj4+IEBAIC0zMzIwLDYgKzMzMTcsNyBAQCBzdGF0aWMgdm9pZCB2ZmlvX2luc3RhbmNl
X2luaXQoT2JqZWN0ICpvYmopDQo+Pj4+ICAgIHsNCj4+Pj4gICAgICAgIFBDSURldmljZSAqcGNp
X2RldiA9IFBDSV9ERVZJQ0Uob2JqKTsNCj4+Pj4gICAgICAgIFZGSU9QQ0lEZXZpY2UgKnZkZXYg
PSBWRklPX1BDSShvYmopOw0KPj4+PiArICAgIFZGSU9EZXZpY2UgKnZiYXNlZGV2ID0gJnZkZXYt
PnZiYXNlZGV2Ow0KPj4+Pg0KPj4+PiAgICAgICAgZGV2aWNlX2FkZF9ib290aW5kZXhfcHJvcGVy
dHkob2JqLCAmdmRldi0+Ym9vdGluZGV4LA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgImJvb3RpbmRleCIsIE5VTEwsDQo+Pj4+IEBAIC0zMzI4LDcgKzMzMjYsMTEg
QEAgc3RhdGljIHZvaWQgdmZpb19pbnN0YW5jZV9pbml0KE9iamVjdCAqb2JqKQ0KPj4+PiAgICAg
ICAgdmRldi0+aG9zdC5idXMgPSB+MFU7DQo+Pj4+ICAgICAgICB2ZGV2LT5ob3N0LnNsb3QgPSB+
MFU7DQo+Pj4+ICAgICAgICB2ZGV2LT5ob3N0LmZ1bmN0aW9uID0gfjBVOw0KPj4+PiAtICAgIHZk
ZXYtPnZiYXNlZGV2LmZkID0gLTE7DQo+Pj4+ICsNCj4+Pj4gKyAgICB2YmFzZWRldi0+dHlwZSA9
IFZGSU9fREVWSUNFX1RZUEVfUENJOw0KPj4+PiArICAgIHZiYXNlZGV2LT5vcHMgPSAmdmZpb19w
Y2lfb3BzOw0KPj4+PiArICAgIHZiYXNlZGV2LT5kZXYgPSBERVZJQ0UodmRldik7DQo+Pj4+ICsg
ICAgdmJhc2VkZXYtPmZkID0gLTE7DQo+Pj4NCj4+PiBWRklPRGV2aWNlIGlzIHNpbWlsYXIgdG8g
YSBiYXNlIFFPTSBwYXJlbnQuIENvdWxkIHdlIGludHJvZHVjZSBhbiBoZWxwZXINCj4+PiByb3V0
aW5lIGxpa2Ugd2UgZGlkIHdpdGggdmZpb19kZXZpY2Vfc2V0X2ZkKCkgPw0KPj4NCj4+IFN1cmUs
IHdpbGwgZG8uDQo+DQo+U2luY2UgdGhpcyBzZXJpZXMgaXMgcmV2aWV3ZWQsIGNvdWxkIHlvdSBw
bGVhc2UgY29uc29saWRhdGUgd2l0aCBhbiBleHRyYQ0KPnBhdGNoIG9uIHRvcCBvZiB0aGlzIHYx
ID8NCg0KR290IGl0Lg0KDQpUaGFua3MNClpoZW56aG9uZw0K

