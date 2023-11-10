Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F9A7E7A78
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 10:09:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1NV0-00066N-Sz; Fri, 10 Nov 2023 04:08:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r1NUy-000663-Ej
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:08:20 -0500
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r1NUt-0000t2-Ud
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699607295; x=1731143295;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=USW+fq3UO1x3O8DgZ3C1tXcpQYtCl80HFdIC+AogAvo=;
 b=SUwu6vqe7pXlBhumd06Vv6AJV2pwmurygvbBV/yabkmifnmu+K3bPwfN
 JPM1IcMOitpJFZz7H1w3V/QGGsDCFxbKJ2R6DC8d/OMb+wyQCj4m+z0VW
 aHUMLy8MOg/cVng8U/mnt5rds6VLwn1W/AdWdHYMaSPLk4wO/zXNcYuHB
 uI/xeNOgabLFIxNDT6ctQMhmvDCAGyAN0liDNP8Vadw/Qa++Ob5Hmn3Y6
 /BbaswhdHi/IH1b5XGhjL3qPPgeTll7hKhOUGxhknG5YeC96I/sfhP1EJ
 u6qijdbRK5VvJbcLVZc4+KJkg579wfbmXCMsIWSbbnkeFF4XJhv2SwR+U A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="370362712"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; d="scan'208";a="370362712"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2023 01:08:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="1095146463"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; d="scan'208";a="1095146463"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Nov 2023 01:08:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 01:08:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 10 Nov 2023 01:08:10 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 10 Nov 2023 01:08:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FW/sw2Fzg7sai8Nvu6a7P/BSFu82iDnIthRQZQq+A3fj1PaAslUr46mNtnF9QjB6VpghjB4qutgG5C4wZx9dO987YXVqh8p1saiI0kPSCtBigvf3Zas0prPIxksR/M5K8ACOZ9Kdq8NUQUjHajl/R/5I9GjSUcEGagos8lPfl6j6XpqjpKNfEkH8J+wqSpXB0B7aZ1l/YGLlww8gRMd31hDytMs3NNCKlNWAN73ANMNdiwKVj/aLnEO1QGiz5j22IFS1qVUlGv0WqwPFKCNnmyJKBpQ43M9XoD0TpFwSH8xQayflEbmHxREHAQIu6KKzDk2qwyeLqR9eW5DNPk79IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USW+fq3UO1x3O8DgZ3C1tXcpQYtCl80HFdIC+AogAvo=;
 b=JiKFTbxrHmGXlPZ4RpE0WcNt0QfR4vb7ANg9p3NQW+lm5EFv+lMa85ovfK9jM9KnOuWYuE1NXkQh7VwbUZ0eB4UVL1MurAqt9KaFcZ1OvhVoe6V7mEoHQnyaGn2/Ulx6UdjsYyUnTp4Tg8NveRkwGRbGX4D3gSVUjiZ5nrb5kUU337WHqVSzWAvyo8vrlyQYC1fC6NBZ4fEJ/cA2h0GouD0n1lZi6XXakgQgMWkNsu2+Kh34nLwUyp1bRlTOz7aRl+xN7PAlqBEvA2z7qJgfEilmsvdAr+6Cc0pnL2lMAr0lpsIyuaPhR5myeuf5Hcbahjqy3it51qTE+d9KhDnt8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA3PR11MB7656.namprd11.prod.outlook.com (2603:10b6:806:320::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 10 Nov
 2023 09:08:08 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 09:08:08 +0000
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
Subject: RE: [PATCH v5 11/20] vfio/platform: Allow the selection of a given
 iommu backend
Thread-Topic: [PATCH v5 11/20] vfio/platform: Allow the selection of a given
 iommu backend
Thread-Index: AQHaEwSAj93WHaquz022W7jqjXIsEbBzP92AgAAETrA=
Date: Fri, 10 Nov 2023 09:08:08 +0000
Message-ID: <SJ0PR11MB6744CDFE2D9252BCBC798D9092AEA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
 <20231109114529.1904193-12-zhenzhong.duan@intel.com>
 <130a66bf-07b6-49ea-a7bf-de8afe0c83b9@redhat.com>
In-Reply-To: <130a66bf-07b6-49ea-a7bf-de8afe0c83b9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA3PR11MB7656:EE_
x-ms-office365-filtering-correlation-id: 388c0d79-8291-4940-1041-08dbe1cc8e56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: grOUUyCm5FvYEGPiprxfyD2vWVThrHLqI5sSKdIwadeH2+gG7yX03SxFAfcsMlPrRPneDs7H9oYkkZyz/ffpupUGxiFPSAdCj0tGGktzpisW05uRZWTm3pnBBa3WLg32H9xbKED9QzcLqBT0U17f+eggyHyjEAyMBF6G4OX5Mm4Sbbjvdv6fSekJ4VQm9rekaUzB+lqCJn0H4K+NliLa9RN+0CVN+sBSQYhqGuGw/FpldWDfbEeoEqyI9DltM6YIjkd8wPNo9j4OfqJwwQBuRl4IYEDjVfqIpRx45487An3oSdwy25MK2i7oBSEARPnDgnJWgIgvC++vAX/1JxJvklOUD39hfD+4tEjIrlGdXEhwXIbxb0JdctJqA8WMXN9+IJvIMHMnA6L0WfKEMVRxeMDSRaVQO9H+8QwZ9X3z3FxXKwykVxLq2saH//B6tO4eqzBiOyOuyhV/9547wIhYi5mP86k4VvvznZeq493PfehWdv0lPrGj7uy6WjY1PLPCmG0C1td7nWefxB6nsmY2FhJ3ccfLEH/kOD672mVkmYH9UsqDY8HZ0bUYC9IfGrjs5tYK5rHNpTWuuOpRmURQnNfSdlyPbtJCPCPf01oZZqFOHb2LFKaUYNAeQyyR/xrX+Xt/xwOjPgPM/1/ajctMVA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(396003)(136003)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(8676002)(55016003)(38100700002)(478600001)(9686003)(26005)(107886003)(52536014)(6506007)(2906002)(54906003)(41300700001)(71200400001)(5660300002)(316002)(76116006)(66946007)(83380400001)(66574015)(64756008)(8936002)(4326008)(66476007)(110136005)(66556008)(66446008)(7696005)(38070700009)(122000001)(82960400001)(33656002)(86362001)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmFoZU5ZT1BxV0I5Q2Iyam0yWWdRaU1tc2NFNVcrZVh4SmdESWZnSXhBWm5W?=
 =?utf-8?B?OTI3NnVaWGVZOHNSMXpMU0UyTTJLMWJvQnh3QzM1SzF0d1d5SXVPMDNsZjFC?=
 =?utf-8?B?QklCQ2w0ZkhiOTIvR0tHYW9zSTQyYXZqakN3TU1UUE0zN3Nrc0tFYlRHQTd1?=
 =?utf-8?B?UmhzKzR5YmpUS0tuaW9pWVpjQ0lodGJSdXIrdmwrRURSQUtCamN2L3A5Qm1r?=
 =?utf-8?B?bjl0bklOaHpQRU5LVFN6SG03VWJpRklrRzlTdmc5b3dLcjJyR1c3WEt1RjYw?=
 =?utf-8?B?YmN4ajYyNDBtZnFEZjJlSXpNWHFGZFE3cFoxUnVsVnVYb1h6bytpQkhRR3hS?=
 =?utf-8?B?TXdkelJaSnlRczZtcmlvVnNTR3VFenNjNG50N1BRdzQ4Q1RabTVYUFFEdFl2?=
 =?utf-8?B?LzRzek84SzBxZVpRbmpRazN2TUpEVVozOEx6M2xzWC91NWRqK1ZJNHhYY1R5?=
 =?utf-8?B?YW9RbnlYa1ZLYWpoMjBELzZOdVk0NHRrUUllRVNOTVRXdWhwTElza0N0RDFC?=
 =?utf-8?B?NmEzbS82cjB0MmdPYUpBUUJPK1lweHR4S24rZlpJRnFzRk5EdWJOMTNJdTNo?=
 =?utf-8?B?UGNpMWtyQWpYWXNLTEVQMVRIQWhPWmpDVGM2b2tTcGFIeEhKdkNXZXhFZUc5?=
 =?utf-8?B?NFVjQk5DY3BNWHkvcE9MV1lTYWlRd2lZSkVKY2d5bHZYdm03dStlVnE1UTNH?=
 =?utf-8?B?SGN5YTNsTTB4bUZuY0RZWStuNXl6ZlY5MFc5NUZlcVNNWGh6cnN1Sm5qYzVF?=
 =?utf-8?B?K29HanBZbzlxdW9pZzhYdFkzamJSWWVYN1hISHMyT2ZRK2hCanhHN1VqN2dS?=
 =?utf-8?B?Sm5ONjl5YzFyendoalM3S1ZuSXJxRWpEeU1ZaDJ2Si9IZUJVckEyS0JaS05v?=
 =?utf-8?B?RVZNNndlRkRNMFZKNDNFdHRyZklqWitva21ZREdwV0drVEFKV3RYc3h2bDRF?=
 =?utf-8?B?QWFXcFhtVk5CdG81VklpbHB1Q2lBTG95akxCeGRpb25IbGhlVUxHM1o1emZw?=
 =?utf-8?B?d2F5NFRxcEpMYnhQUG80NVB3SnMzL2RGenpROHVpNEh5K1czRWlqdWRVenB3?=
 =?utf-8?B?U2g2VzlPNHVCOE01NHBJR05rYk1IYkx3NUY5eGE3MXg1QjZqSFRjdDdqdTl3?=
 =?utf-8?B?VlVTc2F5Z3BVQ0xsUjY2N3prTk44N1JhSG9SU3ZrQnhnblphUGtFVHlDcXBx?=
 =?utf-8?B?NDJDemlDai9VVWVBeFkwSTdRdVY2Sy90UmUxWkpsdVhiMXNsWE5GN3hPM0dT?=
 =?utf-8?B?SlI0eHdGSjFMd0NDNW82WUhEV3FXK241OGlRa0g0bjNyNVJ0MFlSZVc3T2hy?=
 =?utf-8?B?ZTkvbzBQdTNhTlZMYlZ6Q05rNytKL0pHa3EzR0tnN2prVUlEVWNvVGIwMWRS?=
 =?utf-8?B?S0p0REdEd1QzT0xHVkxHQWsxMjNBcGUzTWRuMkRNb0tDQ3BSNU1sMG44RGZU?=
 =?utf-8?B?Uk5aeVBwd2JZb1dSRllCSVE2MWIwalEwNFU5M1QzVk8raWpPL1orQzFQeXls?=
 =?utf-8?B?bm1JaSsvaEJMTEJRRDVUZ0daUk5INEFlbWY0WlhaVWJpdHkxbGRJbGZXK2hL?=
 =?utf-8?B?NzdrakQyQ2Z6dldWM0pCeVRxajlLOTdPN1k4dU14S2NpMy96QlAvYVBKTlBY?=
 =?utf-8?B?YkNUMFBJd29kQUxoMFFxRzg5NDN3b1lTSktjWjNzT2FMbUxuVEtVL3lPOEU2?=
 =?utf-8?B?ZkEyekJIeERvbUtEUXNBVEhac1ZubjRjaDljbVRVZElEOXo5dTVyaTRlc3Q2?=
 =?utf-8?B?Mnk5R1VpRVNJWmxEL0RoZDhzQmhZUE03VDBPenBiR2ZOUXEzd3NFc0cvcDVX?=
 =?utf-8?B?QUZGMFI3dHY3eHFhYXQ4NUJRemZPSEhMellMcTRyenBoeDMrMHZMT2dkUWlH?=
 =?utf-8?B?b21JYXBFY29PUFVRdUlyMkhvT1RtdXhzYnFnQ2dVVG1tcmNzTCtBc2thVWJI?=
 =?utf-8?B?WG5kMStwRngvNW9TODdZNWE1NDlPRFh5dDFHdHhmRUdYckk4aFVhdXRjZith?=
 =?utf-8?B?M01KdkNIUGVYS1J3VGNJS1FmbWs4cHVabkJuWVpjcDhldlo4YVh5b0JST1FC?=
 =?utf-8?B?VVN5R28rWjhqUXlmcUVWOFFTS2ZZSlE2WHRwSDZnaDBOVUMvMlFDTHRLNC83?=
 =?utf-8?Q?OYGdZshOuG2LFSbOjzUVs+F95?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388c0d79-8291-4940-1041-08dbe1cc8e56
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 09:08:08.0572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iRhWgGzGBU8w6DSWsMkksMVAI4eKhMe3nO2+V4zB3l3rZV4mr6P/vJtfabYbWLt3felWje5HfDbL+uJUtB7DIJ79bRgKoMXW98KYo51YNpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7656
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIE5vdmVtYmVyIDEwLCAyMDIzIDQ6NTAg
UE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY1IDExLzIwXSB2ZmlvL3BsYXRmb3JtOiBBbGxvdyB0
aGUgc2VsZWN0aW9uIG9mIGEgZ2l2ZW4NCj5pb21tdSBiYWNrZW5kDQo+DQo+T24gMTEvOS8yMyAx
Mjo0NSwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBOb3cgd2Ugc3VwcG9ydCB0d28gdHlwZXMg
b2YgaW9tbXUgYmFja2VuZHMsIGxldCdzIGFkZCB0aGUgY2FwYWJpbGl0eQ0KPj4gdG8gc2VsZWN0
IG9uZSBvZiB0aGVtLiBUaGlzIGRlcGVuZHMgb24gd2hldGhlciBhbiBpb21tdWZkIG9iamVjdCBo
YXMNCj4+IGJlZW4gbGlua2VkIHdpdGggdGhlIHZmaW8tcGxhdGZvcm0gZGV2aWNlOg0KPj4NCj4+
IElmIHRoZSB1c2VyIHdhbnRzIHRvIHVzZSB0aGUgbGVnYWN5IGJhY2tlbmQsIGl0IHNoYWxsIG5v
dA0KPj4gbGluayB0aGUgdmZpby1wbGF0Zm9ybSBkZXZpY2Ugd2l0aCBhbnkgaW9tbXVmZCBvYmpl
Y3Q6DQo+Pg0KPj4gICAtZGV2aWNlIHZmaW8tcGxhdGZvcm0saG9zdD1YWFgNCj4+DQo+PiBUaGlz
IGlzIGNhbGxlZCB0aGUgbGVnYWN5IG1vZGUvYmFja2VuZC4NCj4+DQo+PiBJZiB0aGUgdXNlciB3
YW50cyB0byB1c2UgdGhlIGlvbW11ZmQgYmFja2VuZCAoL2Rldi9pb21tdSkgaXQNCj4+IHNoYWxs
IHBhc3MgYW4gaW9tbXVmZCBvYmplY3QgaWQgaW4gdGhlIHZmaW8tcGxhdGZvcm0gZGV2aWNlIG9w
dGlvbnM6DQo+Pg0KPj4gICAtb2JqZWN0IGlvbW11ZmQsaWQ9aW9tbXVmZDANCj4+ICAgLWRldmlj
ZSB2ZmlvLXBsYXRmb3JtLGhvc3Q9WFhYLGlvbW11ZmQ9aW9tbXVmZDANCj4+DQo+PiBTdWdnZXN0
ZWQtYnk6IEFsZXggV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0K
Pj4gLS0tDQo+PiAgIGluY2x1ZGUvaHcvdmZpby92ZmlvLXBsYXRmb3JtLmggfCAxICsNCj4+ICAg
aHcvdmZpby9wbGF0Zm9ybS5jICAgICAgICAgICAgICB8IDUgKysrKysNCj4+ICAgMiBmaWxlcyBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92
ZmlvL3ZmaW8tcGxhdGZvcm0uaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLXBsYXRmb3JtLmgNCj4+
IGluZGV4IGM0MTRjM2RmZmMuLmY1N2Y0Mjc2ZjIgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2h3
L3ZmaW8vdmZpby1wbGF0Zm9ybS5oDQo+PiArKysgYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1wbGF0
Zm9ybS5oDQo+PiBAQCAtMTgsNiArMTgsNyBAQA0KPj4NCj4+ICAgI2luY2x1ZGUgImh3L3N5c2J1
cy5oIg0KPj4gICAjaW5jbHVkZSAiaHcvdmZpby92ZmlvLWNvbW1vbi5oIg0KPj4gKyNpbmNsdWRl
ICJzeXNlbXUvaW9tbXVmZC5oIg0KPj4gICAjaW5jbHVkZSAicWVtdS9ldmVudF9ub3RpZmllci5o
Ig0KPj4gICAjaW5jbHVkZSAicWVtdS9xdWV1ZS5oIg0KPj4gICAjaW5jbHVkZSAicW9tL29iamVj
dC5oIg0KPkkgdGhpbmsgd2UgY2FuIG1vdmUgdGhpcyBjaGFuZ2UgaW5jbHVkaW5nICJzeXNlbXUv
aW9tbXVmZC5oIiB0byBmaWxlDQo+Imh3L3ZmaW8vcGxhdGZvcm0uYyINCg0KTWFrZSBzZW5zZSwg
d2lsbCBkby4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

