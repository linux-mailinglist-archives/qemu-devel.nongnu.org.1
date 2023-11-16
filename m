Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9757EDC23
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:44:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3X2c-0004Wb-0t; Thu, 16 Nov 2023 02:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3X2M-0004Un-P1
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:43:44 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3X2J-0004en-JR
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700120619; x=1731656619;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PrHUpImgFeILfLyN1TtsKmUVpGeStb8q4B7wqPfXZGA=;
 b=VgtzE0TgtbQ8OaqdpjjUgQe8hAyOSYJwu1MaUiSyFV+Pyrg+dF6AWHGN
 Rng8LPXK85GFp0Ans20bPQmUb+bx9KWrnb9Q5p7OFLK7NBbXv/0PdIVzO
 1tHhYqzD3Xc29Kctuglt/ul1frTx0lUEq8KGpx6SlREUnvDE333MAEw2O
 zq3HSz/fZZ58DLTcO6b8qu+xXZyVtIuhOkD1zW1rZN2ZihS+k0y0iiB0G
 mtxo/grSVZw2qoiOH3sZSf6NFnZGw79KkoL+1XgG0r2NeHu9WI/Q0ki/F
 dWFUrjhAg684Hj3Qp0h0K2S1QB+6eMnHejiudnqnNZru1PYM/ED0nNjO8 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="394952596"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; d="scan'208";a="394952596"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 23:43:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="741680719"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; d="scan'208";a="741680719"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Nov 2023 23:43:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 23:43:12 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 23:43:12 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 23:43:12 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 23:43:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9rUxdAtsAK5i0DHA3I9OhhLjj8Wl2MJTccJ5sVWOkZD2bH0saHi3K0Swa4+eCQ2/48BRn/0MYRJJ4WaapEuW1fpsn0wrhEuvqqYjq3h1hWf+Cd92KFV60ML73IfJKw4dFoUm/w/RZXqbp7K+Q1mb1w5pi0bgtxe8wyS5VqulcDDfifivkyeRKkTUqacUoYtTfxMOVe7B89j85yj7mH1xek13o3lc5BLguvDtY45y3FjU5eFuWKOtn28jQtOREAC9FNeeSXgVVhib1bivJz6gmuiZBMLmp+WSJ6ag2QA4D0kJY5CPoyy/jSM4dImbotOJHvMNLE4LOuTwQflPMkdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrHUpImgFeILfLyN1TtsKmUVpGeStb8q4B7wqPfXZGA=;
 b=lBGp2sMNjkmv67bX1YEePH6WT+cggGWmCnKLgD2gseSzaYm1qLoFcIfbYD/BoeDVG/nG8LQNeQq3HjqbN0ry3gG+SSXdwNs94Y/79qBVmHsJ+2gNIr5f5yHxgBJsZB3pNFKgTDSVC6tc7Z2Z/hmIc3TS5cWznW0E2TR8FsyaFDT8AMLiDzEgU4vnXA2BW4UGdM2ddBp+NtVPypD+PHE6qAOmB1ifE8mGhwYwP9zhSnGYGTLMP1F6FiaSzK+43CYQ7RnCyRvQjf5g++r8bXMdkWrKjLD5uICrsqdZtShiaZzLVoLkF38euGHVB+92l4ulnxiNieUH6dyZzoIm67hA0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB4975.namprd11.prod.outlook.com (2603:10b6:a03:2d0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 07:43:05 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6977.029; Thu, 16 Nov 2023
 07:43:05 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 11/21] vfio/pci: Make vfio cdev pre-openable by passing
 a file handle
Thread-Topic: [PATCH v6 11/21] vfio/pci: Make vfio cdev pre-openable by
 passing a file handle
Thread-Index: AQHaFuUGAaflN6h7tkiX6y1xaFrADLB7S3IAgAAPiICAANrMAIAAWIGAgAAEdOA=
Date: Thu, 16 Nov 2023 07:43:04 +0000
Message-ID: <SJ0PR11MB674457CE88DF5EF29BB25C9292B0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-12-zhenzhong.duan@intel.com>
 <b6c6f336-8f56-415a-b6a7-fce19dfd2241@linaro.org>
 <de1bb7bf-64ee-4378-b757-eca7f547b674@redhat.com>
 <SJ0PR11MB67444C431A56866888D1621A92B0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <8d2c39d1-3918-46a7-91bd-db6ec22c7384@redhat.com>
In-Reply-To: <8d2c39d1-3918-46a7-91bd-db6ec22c7384@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB4975:EE_
x-ms-office365-filtering-correlation-id: 2e4ef43f-c19c-4c1c-3bd6-08dbe677aaa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: orv5b/SQZKZAAWmymWPXUI270Rd5tzMab/uT5vHOhHbkV6MtgdjoNE7GYz4PUosgSqRQBNd59Le7oizdnixPaCqJVHALtaN+l2epEbLLAlIayIQ0mf258A7KMZm8OWKlIsZucYa1rMBhpXzLkhYprUUeQhgN7fqAnS8rv0tf2/vAxGZgUw4CD9F+I1uinZbQPUbb2PdA7I1fkxvYYsWSEaI/j3Oo/a1ioVtU9AXr4NMYVeV3euwn5IfdfyrIZf44ZZattuZ9p2u6RNjZ4Y/zN3tYNWMAKk7oAYVDjjDBpGG6cwl26DDuNUp5qwhvAgxMt9QCVd+2rxe82aWntTWDB6qWfLJ0j17EoffdNTgxAlBE6bd1RgRopwwQhmEZ/1EOAg21xr3JICxkiVDHqIih+yPdQg60GDYlwkdF8iuDa98cUoXUZ9wNslXntcdJ+32m9YbkQrw6uV0+OUtKmAe4xa+WDYnGNK9EAKi9UyhZ/8m8z/9UtRIxcve5wNjA/VFG7+SeUPyJ+p/xblJGbAshUkoRec4SiddITsIcV2fQRdtilyJ7PMsqXNQtBkNVYnbnclSfhf6maPnzF17JzTQsysZzmfDqDZarjfL9oLppFm/Ow4JqZlAILYtwkAHzSR7O
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(82960400001)(122000001)(38070700009)(55016003)(86362001)(66574015)(83380400001)(26005)(7696005)(478600001)(71200400001)(110136005)(107886003)(38100700002)(6506007)(9686003)(2906002)(41300700001)(33656002)(8936002)(52536014)(5660300002)(4744005)(7416002)(4326008)(66556008)(316002)(66446008)(66476007)(64756008)(76116006)(54906003)(8676002)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2ZrWm1WYllDMVA5a3JianJYR2hBQXl5UTVuQ1lPRjZPUDRibkVLb093a2RP?=
 =?utf-8?B?QnhrZUVERTJDRjQrWWpFUXJxMi82R2FXVTYrdlMrZDNPTlJ5SG9yVy9IVG9P?=
 =?utf-8?B?NzBYT1FBa054WW1wZUI2RjgvL21hQlp0WldheDl1TnRUY05YcGlPdllOLyt6?=
 =?utf-8?B?Z0ZSbGhIVUwvZHNtUWNxWWExOC9USU81NEhkTTJ2UGxTVjhWY3BwNjZsL0J6?=
 =?utf-8?B?c0ttU0dkTU5iamNTWWF2OGNMc2FtSmwyT2RWZzBIQyttMXFsNXVFWXdUMWZY?=
 =?utf-8?B?Tnp3RjZpU240TGhhSHRhcTQwdjFJOCtYemVTbGw5Vi9mY0FOOFBwSUc2Z0pT?=
 =?utf-8?B?RjNCOTdoREZKRnFiQ1ZQYklkTlorZ1pJcmNFOFZEb3I2eE16RkN4TW5aVW9K?=
 =?utf-8?B?azh2K0VrOW5LYlMwRHliNXJKNTcrSjBLbmp5cVkzcXlueEplQUhDRHhrYVEx?=
 =?utf-8?B?UmVFZ2ZSN0FrZXNmc0EvS2NOZ3FiN0R2NmhMcGtqMlplakRmZVg2ZWR1WXRV?=
 =?utf-8?B?bHlXUldxYWREcW0zTkxFY2dQRHlzY3R2WlY1RWZNS0NLQjR6ZEZLbjRJa1Bi?=
 =?utf-8?B?NUxuM2ozMy82aGt6eVJObVEycVIwamRDTDQ1ejV4enpTWmUwQ2UrWFgzVTNH?=
 =?utf-8?B?bFdPZkYrRVY0d3MrbHdUSWF1RGlING5pdnNKNCtuc2tiUmpmTDFpd0NqeFZB?=
 =?utf-8?B?Nk9ZK1ZSaEJSVk1mOENGbjVwTjNxM1Q5MVZjdzhCY3RXa2Y5RzNBS1V1c092?=
 =?utf-8?B?a0lEOUZ1QkJyYmFyZ3c3UHkySjllVGNKdkIrLzNpMmlYMnlNc295NWRURnpt?=
 =?utf-8?B?ZkNwTGRSNEpJK25GeHovTkNscW5vZDRiRkZhUVV6RlV0MHl6ME1nM3pZdXg2?=
 =?utf-8?B?YVpyWTdXUFVOU3VxNkF2MmN2RnJkOVlOT1hjWUxOMmZMZkxpbFk3MXFFM29S?=
 =?utf-8?B?T0d5bHIwQVIyekVsQWlTV3JJNXN3dmZTeklHa25jeklpY1Bpakg1UE1rY094?=
 =?utf-8?B?ZkpGV0hxVXN3NlRGY2FhdDBQdDdwVldJNCtieVl2SjJqbWkvZkE0OGtoQ3dB?=
 =?utf-8?B?dkdNQTdyRlRxSm5NZXRQYnp4MXh1NmZZOU8wbEkzemtHUm9PMTdBcTh5QWVq?=
 =?utf-8?B?WjJUdGt2Ymk3Z0c3bEVuS1J3RnRiNEY2RTZ2U0d3VGIzNG51UmtSTnVRdERV?=
 =?utf-8?B?VFZ6K2RhS3dmN0VxcWowaVFGSHVPNzF1dkdLdzhBU1VjUHVSakYxL20rci84?=
 =?utf-8?B?TlNWMDJnY1ZhZ3lZenlxbkp3UTNMZlRzcHhXeU0rcnBZUEtzZ1pWbVBoZFZ1?=
 =?utf-8?B?eGY4RVZtVThqY0hJWFBIb2R2QTl2NlJWM1VrU1VvMTNlcElKNWRqOHlWZk5M?=
 =?utf-8?B?Qk96MGxPcUxKTHNhTEY1QXFIQ2thQmMyQiswd3RDTkFIdEkzdThYY05KRXBq?=
 =?utf-8?B?YmV2aVQzNTVoM2F2TFk3dkp5K0ZSbW0wSDloZUt3OHdEWXo5OGR1MDV5eE9G?=
 =?utf-8?B?RG53bExtL3YyLzBwNEVvWDR3bVI2eU5ZNlg1TDFzZVJHNVhzS0x6NnlJWGdJ?=
 =?utf-8?B?WDBQYWtqQzMxekpTU3lCbnMwdVBBamNIS0xUQWpDaTN0U0tuaU05ZGRUcDVV?=
 =?utf-8?B?eW9JZlZERjJPUlhqRm1BdFVYdHJkS0xNTXpxdlZjQUpWS0MzcU41OENMVGZ1?=
 =?utf-8?B?dy9McDhBbWNoVnlSRTl2ZkFJVERXRzljVTdYZnJFWndjTkZrTy95ZlhrUHhS?=
 =?utf-8?B?eWJNNG9VTWxlOU5zZCtQTFZRTGYyQUc3SWR1cU9TVlRWbmQvTWUvWFdsUmFB?=
 =?utf-8?B?UmE1b05TZjBnRTdOQmVmeWpRRXZPU2tBNEdLS1lyNnpQZm1NTkhCdkc2OTUv?=
 =?utf-8?B?UE4yR01UKytlbXlhYlByV0hjYVNQblV0RXdFT3R4VzRWZW5EUi9SVTRmdlpo?=
 =?utf-8?B?eXRVamZncGtXd21Pd3ltTklZSWtDNncrSkIrUm5kU21acWVCNnpwYmNaWHg2?=
 =?utf-8?B?ejZjVE8xVWcwY3lzUFJFaEI5dlp0VXZEcTFBUXJpWjNLS3ZpU0cvaE1GVWpS?=
 =?utf-8?B?bmdobi93bWlqVlBDMjBMd3B6Vm16bXcyU3J5TysxSlhqU3BscWdhQzNZWGpa?=
 =?utf-8?Q?pnOl5aBR9t7Ll8xnLpTbhCfzT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4ef43f-c19c-4c1c-3bd6-08dbe677aaa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 07:43:04.1303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: St27K9N4A6IGjYtQGyAmxuNuXc/d5D2a7OeVNKXWvqtZPlM3GuvKcjT9QsF/wGt9lsMgclwsvHVU+8WceGNTzer4OJ2d3Mi8WZ1+OzkJA98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4975
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTYsIDIwMjMgMzoy
NSBQTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMTEvMjFdIHZmaW8vcGNpOiBNYWtlIHZmaW8g
Y2RldiBwcmUtb3BlbmFibGUgYnkgcGFzc2luZyBhDQo+ZmlsZSBoYW5kbGUNCj4NCj4+Pj4gUGxl
YXNlIGFkZCBiYXJlIGRvY3VtZW50YXRpb246DQo+Pj4+DQo+Pj4+ICAgwqAgLyogUmV0dXJucyAw
IG9uIHN1Y2Nlc3MsIG9yIGEgbmVnYXRpdmUgZXJybm8uICovDQo+Pj4+DQo+Pj4+PiAraW50IHZm
aW9fZGV2aWNlX2dldF9uYW1lKFZGSU9EZXZpY2UgKnZiYXNlZGV2LCBFcnJvciAqKmVycnApOw0K
Pj4NCj4+IFdpbGwgZG8sIEknZCBsaWtlIHRvIHdhaXQgYSBmZXcgZGF5cyB0byBjb2xsZWN0IG1v
cmUgc3VnZ2VzdGVkIGNoYW5nZXMgYW5kIFJCLA0KPj4gVGhlbiBzZW5kIGFsbCB0aGVzZSB1cGRh
dGVzIHRvIEPDqWRyaWMgaW4gb25jZSBiZWZvcmUgaGUgcHVzaGVzIHRoaXMgc2VyaWVzIHRvDQo+
dmZpby1uZXh0Lg0KPg0KPlllcC4gQ291bGQgeW91IHJlc3BpbiBhIHY3IHdpdGggYWxsIHRoZSBj
b21tZW50cyBvbiB2NiA/IEkgd2lsbA0KPnRoZW4gYXBwbHkgZGlyZWN0bHkgb24gdmZpby1uZXh0
Lg0KDQpTdXJlLg0KDQo+DQo+UGxlYXNlIHdhaXQgZm9yIEVyaWMgdG8gZmluaXNoIGxvb2tpbmcg
YXQgdGhlIHBsYXRmb3JtIHBhcnQuDQoNClN1cmUuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCg==

