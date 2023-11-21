Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1027F27AC
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:41:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5MIO-0003c3-7W; Tue, 21 Nov 2023 03:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MIC-0003be-B8
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:39:36 -0500
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MI9-0008BB-3R
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700555973; x=1732091973;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HKpyvkrCF2SXycDzPTaCI9Mr6lV3+vsXH8GFRFubGSg=;
 b=LF6WH9Gnx1Y6p2aR5z1tJUfr9lVzVuy3nDYnhQw2S9pxEGZM6fJThktJ
 TvFmP6yR7sbdxWfRuRgiBbvYJErVWznM1vXIRTk7NGaS+FFwOeIhCEgMo
 iddyPHl1+U7AmXmQFSsb0u8gg9mw6P1t+ecPoFAzFqybJME/l+w+tt5rH
 YIL8lUQli64bbcf+6qIkMdTfXN2qOyoXOGchNesm+x6ZqwHrBbmjHHdw8
 /oWe+6FnOJdh1/S3sqbylVvRzYQxJreNZwdVZh0xeZLWUsiBtwFw6BIKZ
 VV1zPL9E8JBVOy8C5m5UJdGdLfU70XXsJzRxTz6jHHHjLzqbMvCZ4KM+D Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="388940924"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="388940924"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:39:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="795723673"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="795723673"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Nov 2023 00:39:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 00:39:15 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 00:39:15 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 00:39:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8otzUUcJHv1FaLP4Ov13U5bONpvKCivLGPeFMkBhm5GMqm+Hj81macfrdUbkhUfDfgydsuRShZUAFWTqRaPfzcVGUH+pH1gAKf59LGxRFazdiXzvP4D2k+2o70V/ou3Mm/FIgtOrGPppbu7yZ6aeeFmfjkVrSSkwLp+F47o/JxYQx7ORRUZ+0uIQzWCraOs3hwFpqf/sc/tnrEX04UVZYLIxKZW+1QLF/u2DIV3XnWBmmvZBad2zLW9OZ67u9AOJESvLlnXJc+F3zV6eoJAjRNPJkDnJscjo1fz+UO6Jxor7eaH0yQiAWhd22JlOZsf/6Mk/RkrX+yn5Nsx6wwBsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKpyvkrCF2SXycDzPTaCI9Mr6lV3+vsXH8GFRFubGSg=;
 b=F9dmIPsm1A8Ov+wgoIC873QnMB78y7GciNsN3bf9kH5/6CCle2WYtyJlCmjmY1heyi0BsXVT2LfEsg+q2YUa8cK1IZzj7++tFPL+dla098DQY6h8oOHOCMTIpR8KmD7CIqntp5MG7uolQ7Eb/+xR5w2uy/AC6fENUpr9um5VfqLTqQ5g3oCuJvMblHb4LaXWzh64zWmgVX45gG2ZjH0mjsiV8NZ7QFz9GGr2APjeYPoZJQ7FVIR8IueZyiXMnfgelo+JdV2sUR0i3B5gR0KDtuvOP7Ecykk2bZ1AvYcwELnDavGZf+79IJ8NmGrvEiT+OvHGIx+4n6qgcQoWYOabuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7506.namprd11.prod.outlook.com (2603:10b6:8:151::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 08:39:11 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 08:39:11 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann
 <kraxel@redhat.com>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Subject: RE: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Thread-Topic: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Thread-Index: AQHaFuTq+kqpFvBx/0+jXWJho7L/CbB+X2AAgAAFFfCAACIGAIAAB2wAgAQAf1CAAFnbgIAAFZjwgAB8wYCAAKx2AIAATjCAgAAJF4A=
Date: Tue, 21 Nov 2023 08:39:11 +0000
Message-ID: <SJ0PR11MB6744FDF1D88846348D867E6792BBA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-2-zhenzhong.duan@intel.com>
 <c964fdf3-d6ef-40cd-b4c0-32f1fb8501ae@redhat.com>
 <SJ0PR11MB6744B1B91C890A9A1B81E89792B7A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <248389a7-3f89-42ae-98e7-34d6612cf186@redhat.com>
 <c0c265d6-aaea-4071-b280-b93df459165e@redhat.com>
 <SJ0PR11MB67444672699A62007207FB3492B4A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ebc65641-4597-4679-8214-0f4555f9bd21@redhat.com>
 <SJ0PR11MB674445FEAD689AF8B5A8A42B92B4A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <395120c5-06d0-4421-a9b8-20bd79bf3f5c@redhat.com>
 <SJ0PR11MB67441701C3CD12A968092CB192BBA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <405fbb52-df05-4511-bec6-66caab2b4c93@redhat.com>
In-Reply-To: <405fbb52-df05-4511-bec6-66caab2b4c93@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7506:EE_
x-ms-office365-filtering-correlation-id: 1814cbfa-9261-4ea1-7bca-08dbea6d5598
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FDgJz+Jnb45rwabKpveerYhm7vi5TuYk5JYNbGhjn08moTP+jysbVDCCG3D2A2VbomnjQ0Gg7X4CX9bbqUHUoqDqXc7b1fcEWmT5sCGhiWBp2GBCUjrOtrd4axEScfR/w9mK2rtSCH8eiEVWI5uTWV6H2A9Gbug92hag0kVFpT8r7q25bgmUoPr6Kg9u0qLclchXOT1J/qmuY8VFwCQEBY/BVdTkSkTXUz5QQPaVMaeC0ghKTVLAGS73/w8hTf6Myu89Doje3v6HUaMJwCaznaysXEr3pJTAanuETCtmblci6zo2w7hR/Oeql5PJJv9q4L9zI+nLEoKKuJO9ysMACzd6FwCbB3gej8KQRWs9wtOtjr7nV+f2cOmBJdtkXvA39MKHcH97UU0G1akhbASZOgCgl91L2/7Cd0HhA7gdI4GQc1AxFju8pLmac0i8gwNefkYJD/PzaJWDgkCW70Elc9FdshSDE0aF1YdDvaP6MEQPtEvZ/ov+UYJxTaf8KsSefqwYWE7O7EL7FR6gQx6p086TnQn6O0vryCuybT+Mh5bnCmG5tQi0Hvr+2ETSIl03X00/FDAluqtcyVODJGTYD6P4KuHNHvMgNvDJrWDWXLP3T53vzgJ6vnI8CmGXeBdy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(9686003)(26005)(8676002)(4326008)(8936002)(52536014)(38100700002)(41300700001)(2906002)(4744005)(7416002)(5660300002)(478600001)(6506007)(7696005)(71200400001)(110136005)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(316002)(33656002)(122000001)(86362001)(82960400001)(38070700009)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGtPL2xWOEMyL2JYakFvY29Ka0p4WmZXNzNHQ2NucFFmM3JwekFmZDl0ZVg4?=
 =?utf-8?B?MXBrSEkvM1g2ekJreEFNWlJ2bVZzc3VMdEtpNVlqRU5qN216TFFZblZyYzRr?=
 =?utf-8?B?RVlmc3lsV0N4OWdneHNnWms1SEVpYk1KUmkvS0hOL0ZiZHNScXlZVm1UWUs4?=
 =?utf-8?B?azhiaXFZUmhnNGpiRFBja3pPTnlPOGltemdhb0JRZUFvOS9yN0EvVWVXNFE1?=
 =?utf-8?B?Qkx6NnlPeHhIcUVKQXMvNDFlUWlsVFJoT1Yyc3Y4dlhoVWZXNFB5Um14bkhy?=
 =?utf-8?B?Mjhad1VDb1JvTnZnSU1ieDBHWk5aK1dGSjR2N3hpekU5amZaajRKdFhRS08x?=
 =?utf-8?B?WXVia1U1azREV0VFVXdVK2JBT05UT2EzVEhKWjJORnFGOU9HdWlZS3lzYk1L?=
 =?utf-8?B?akNqL0pBVnZ3ZWV1VVF0SGpmTmNxVStJVFlFRGRsYjU0Q3JwUjFVMUJvdFVV?=
 =?utf-8?B?MVZyKzl3M3ZwOWduRURFajJKRmY3RzVPUVRlRmI1Q2ZXdUU2bmtPSGVvNWNz?=
 =?utf-8?B?akF3aFc2N3NDMkE2cVpRaDBNTXZ5K2lRUXlWZDJHcGhVei9reTdjSUJ1UmR3?=
 =?utf-8?B?ZWVBWTB4RUQxaE4rNTFhMjRHWmhralNxbWh4ME1nQkxMWXRmTi9WRmF1NUJG?=
 =?utf-8?B?ajYwY3dWLzdVNWZobVRsRjlwUlZtVnU4eWVaQzF5TVc1MDRPLzBPZHk4cXkx?=
 =?utf-8?B?L2NBSTFZeW5mRVlOaDNmSWlCSk9DOFJ2RC9OUDJWUmNWbzYvM3lvYlh5Y3JC?=
 =?utf-8?B?bWVYenRpQ2NkcytZbGhqdWora21LNFFZZkRLWVZTeXBob3RFWkNoZWhMM010?=
 =?utf-8?B?SEZxWkJrZ0tGOFptekJnUG5VTnZyNHc2Z203MmFkY0dBSTBEM01TbDBrUHpy?=
 =?utf-8?B?RExpNjMrYzloUFMwZ2FkbWUzTkZRNjUxUHdEMzNmNEVSSGVxSWdNOGNIclZG?=
 =?utf-8?B?MXZJbG9renBaOXdKMnBzQlVCUVJVYmJ5TlhaZWV0TmluUC9RTGtrbjBZcFBN?=
 =?utf-8?B?L0NGcnhRakYvZlNNZExOSkRzQURzUzdNRXRyNVljaG9tQ2JPTFpmSlJYN250?=
 =?utf-8?B?eURWZ1NncnpXdFFUNzloeVljMm5kOEpLdkhhTTQ4ZnJQMVhPMmZRSVVma29E?=
 =?utf-8?B?M2IvL1RQdU5FcFlNVGk0dDdQbVdoanhaUlNYRldzcnZ0N2lSZDAxQnphbW54?=
 =?utf-8?B?TDl1NkErNktuRTVwa2szUDlPYmdYby9Cb2k5YzNqWXdxTi9Sb3dUOTJRVHNs?=
 =?utf-8?B?cmRLYlFEWUN3YlFwWDJjdFd4NThXdGY2T2txVnVTUVFxb3VsTGpxVzlYZzI5?=
 =?utf-8?B?ZE9lZ3BKYWN1bjRpVDhJbnJaUEZ3TnpSYUk4N0grbEx6WlBBMVdURjdMTWRX?=
 =?utf-8?B?VmlVS2grT29nTk5vMmZ4Y3B0UjZDbS9rNExJOTh3Yzd0QTVqbnJuZUFoUXVu?=
 =?utf-8?B?eVpNK1dNZ1RKaWxFN2J1aTBNdEZqcG96UlhDZjZWWkRvbWZKMjhmMzdvemF3?=
 =?utf-8?B?TDR6eU9RNnBKSzJpdTg0MEdnTk9ZRUxJam9BV1gzc241eVZWR2s3N0EwVTc0?=
 =?utf-8?B?SG5lWnpZSVFnTnhmM3dBajhxQ1R0TTZ3bndRbzduT1U2VHE4SlpNQzNyU3hJ?=
 =?utf-8?B?WUJBM0ZJNkk2bWdjOFB5L0hpbnJNN1JEWmZ4SURvZVdPNGg2T0ZpV21XT0xJ?=
 =?utf-8?B?VnYzQmh5Ty9HWlhIeXhJalp2NEkzVTZVVkdBNTlKYk0wcW9TU09Id1R5WGN3?=
 =?utf-8?B?YjUybE12dTRvTUN1L3ZLYi83aWtCK01GVnBhQkhFdFkvZ1dMVGlNQzY3RVNB?=
 =?utf-8?B?UjNCMHJPbndpUVBKUGJ0SXlGd2xnZ1o3VzBKV0g4OU4yaUgzWUhERFJoQUJp?=
 =?utf-8?B?TTZjQkxVK3NUUWpsMVVtK0dwbWR0RStZNitjNFBTQm4zc3NBcnlpZ2hkeE40?=
 =?utf-8?B?KzU1Q2svV2g1OTJYVE5xcjZtUlRpbUl2bGUrenp4OHVWcFlUTSs5bFBqTW1V?=
 =?utf-8?B?bEVUM3BSalZQSUR4RU0rOWhoeWx6VG91NHJoczB3NTdzcFNvMERhOFExK3pE?=
 =?utf-8?B?MERnZWJEbGdMK3Q1M1E0UGZQbGVYdS9uSzZPckFrMjVpcUhUSHYyai82Y3dT?=
 =?utf-8?Q?IquONNMVzZHyKxNrrIFnYNvQH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1814cbfa-9261-4ea1-7bca-08dbea6d5598
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 08:39:11.1362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RNR32xSYHiU7so4rZuOK9eo+aLEIuZm6ypHSvTJ7IJyOVgwsn7193h5+PJukRYbZTWN6Xllwsl98XxbX3C1vPmW0vrcbrE+FketDAl3K9G8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7506
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAyMSwgMjAyMyA0OjA2
IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NiAwMS8yMV0gYmFja2VuZHMvaW9tbXVmZDogSW50
cm9kdWNlIHRoZSBpb21tdWZkIG9iamVjdA0KPg0KPkhlbGxvIFpoZW56aG9uZywNCj4NCj4+Pj4g
QmVsb3cgYXJlIG90aGVyIGdhcHMgSSBjYW4gdGhpbmsgb2YgZm9yIG5vdzoNCj4+Pj4NCj4+Pj4g
R2FwczoNCj4+Pj4gMS4gZGlydHkgcGFnZSBzeW5jLCBXSVAgKEpvYW8pDQo+Pj4+IDIuIHAycCBk
bWEgbm90IHN1cHBvcnRlZCB5ZXQuDQo+Pj4+IDMuIGZkIHBhc3Npbmcgd2l0aCBtZGV2IG5vdCBz
dXBwb3J0IHJhbSBkaXNjYXJkKHZmaW8tcGNpKSBhcyBubyB3YXkgdG8ga25vdw0KPml0J3MNCj4+
PiBhIG1kZXYgZnJvbSBhIGZkLg0KPj4+DQo+Pj4gQ2FsbCB0aGUgc2VjdGlvbiBDYXZlYXRzIG1h
eWJlPw0KPj4NCj4+IEdvdCBpdC4NCj4NCj5JdCBsb29rcyBsaWtlIHY3IHNob3VsZCBiZSByZWFk
eSBieSByYzIgKG5leHQgd2VlaykuIEkgd291bGQgdGhlbiBtZXJnZQ0KPmluIHZmaW8tbmV4dCBh
bmQgd2FpdCBhIHdlZWsgYmVmb3JlIHNlbmRpbmcgYSBRRU1VLTkuMCBQUi4NCg0KR290IGl0LCBJ
J2xsIHNlbmQgb3V0IHNvb24uDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

