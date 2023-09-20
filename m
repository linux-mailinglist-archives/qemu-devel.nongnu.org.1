Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 612C47A70C9
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 05:02:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qinSD-0006Fm-BL; Tue, 19 Sep 2023 23:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qinRm-00069k-6J
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 23:00:17 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qinRf-0006Se-Pv
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 23:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695178807; x=1726714807;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VV//x1FyCBiQhjnbkeETo6o0+m3PiAtb/qMPNf834w8=;
 b=RvjxvgqChpiYk/orVRduY+wzPIuGz3GjTFYtmZjtiOmdlDNGa5c18q0k
 M45BulUweXRgjSTjIK6XYx8g8IHRjnayCyE+DsnNa5qwWyDQRcV863RiK
 UTD2gdrGHSCVRu5X5y1msv/0aYcvUcAjcKL0LntARVjUSk1uYzAtM9T4B
 IKr3dLpZJaqgGrUMuek7jgxRfCBwyadGnRbGeVEwOjlE2MnbbRyYd6x6D
 z7Ww6G8WjjgF52MAO6F0YmCiajpbf+PPa3NwuLBi/8nTNbCddSSNZjy3G
 pB4cCf4Hr/zP5ZOZ8KB5NE+0sHlmq+WrzE2e+CyKP/pr9MWouKAUH1NoD w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="359497730"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; d="scan'208";a="359497730"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2023 20:00:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="993411499"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; d="scan'208";a="993411499"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Sep 2023 20:00:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 19:59:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 19 Sep 2023 19:59:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 19 Sep 2023 19:59:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ei0/HFEY+UzUMUiFdbD+dy6tW12Drpbl5Irpa63sx9jx2dY+0de3plcsrL8qha29kKeEudygEZ0Bbw56n25zsN0gvokQOhNOaLiVvwfwl4V5lY5kldFhHh2y8jzR77iAU6R6TluidwaAuwDNr4VNXi0WLBxerLfsP4jmW8tmkn+y46DGNuNsbxKLB3cDnhIynHK3umIy5VDR1IGMPgPXt4W6MG78dLFhWWjoDM5GGaz4M5JtIQNGob4Fv87DX11c92tW3d1G8bGrYiMACHzSTwfZhliLGfba6XSv4D5+asKgNT2894XxYmcdEmXOn39Ywdig1ny4UuuuQGJtRluhnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VV//x1FyCBiQhjnbkeETo6o0+m3PiAtb/qMPNf834w8=;
 b=HebYkPOZ2UfDAqfF+BSB/L8K7FTnQrEuZ7UQUnd7pKPRUqHqsjLyUHNywLDo6RKJwOMCCXIG8CxD8Nwk5kwIdgJzLUNW5MPAFmHsXhF79Qw51OQLcYivGinYavPeWRlO3ttqkzh78eDdeco+2k0Mz/hVWc+mmVjXb/psY8fdwJQIYINDAOHdsaanP6MqUSnIjcytihWEUA7qEjBr5buCCmC80rNsGiu7eh5gzb70o6jAT0dI/BCymr3YbWBsr/P4q2ZuEfM1JIvvhMoJgS6i1eOas06UjaUbK5tlwLsXjIf+4QoliBQLfuWn3YLjmkGumlVJ/EBxoNLjK1A7H0mHUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW4PR11MB7008.namprd11.prod.outlook.com (2603:10b6:303:227::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 02:59:57 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 02:59:57 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 14/22] vfio/common: Simplify vfio_viommu_preset()
Thread-Topic: [PATCH v1 14/22] vfio/common: Simplify vfio_viommu_preset()
Thread-Index: AQHZ2zA8WTlR2XQyKEqNmQpnCBgTT7AibraAgAC3VOA=
Date: Wed, 20 Sep 2023 02:59:57 +0000
Message-ID: <SJ0PR11MB6744463FEC7E686EADF9893B92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-15-zhenzhong.duan@intel.com>
 <3dec9822-a884-af13-d8ce-1facbbaf6886@redhat.com>
In-Reply-To: <3dec9822-a884-af13-d8ce-1facbbaf6886@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW4PR11MB7008:EE_
x-ms-office365-filtering-correlation-id: fac1883d-4477-48a6-9b4b-08dbb985ac29
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bkM6TFQNH7b9/31VXFFF2sv9zeSBaE2YnXrZgQ6YxgRPFmTYyY+QZ1ybxLpqpasLDzx3zl3+ehkEJSm82uVqBrod1J1ZZZpMkvsz2AJOQ+9lV1D0v3SZTSZ9w7jSTgehJmXFUtHOJW6qNoOSWL+EQvdxNboUy2e2p7exXxgypeP53Tnp7vi1GkFeuHmyrcHA1mMMWGX0ZOqC82ghIrGxlV41QzFsGlgkpMMz2XKMnq/sGHkGXp8ruj+1xN8JPpM6VrFFnH9Ellg1Rpit9z+TwLBoAcwKDMZf978zWnBzTmGYRl0agfXNoRyKdotpvrN1snrOlrkCDplUL9rwUBP301rkWABjGDVBHSVe8q+1Ygv2TMwOPmkSxWIMNQZLjwhUorZYdUdY/G4cXQa5IvOih4XpUGv8d0FGH1jCagdI8nHf/StYOp08Y2kzWnSfxDif9zzBdR2ZjMyVyeumGe5wlOwwIjrsBkZXORvfZ0bfxoqwAcyB2Qw+R5t0BIuj51qwJ8J53n5TqIoVF9D1i1uff9e/vL5W6J/Nr91tSXVd/i3EaiNZorj6yKdxlOLTelX1tdikAxCXFOvWt3vxZhWaE5Cc5PdNIerIvSITIpMwLyJFdwMEXgTBEhpIbsG0gBa7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199024)(186009)(1800799009)(107886003)(4326008)(5660300002)(52536014)(8676002)(8936002)(82960400001)(6506007)(7696005)(9686003)(66574015)(83380400001)(26005)(478600001)(71200400001)(122000001)(41300700001)(316002)(55016003)(76116006)(66446008)(66946007)(64756008)(66556008)(110136005)(66476007)(54906003)(86362001)(2906002)(33656002)(4744005)(38100700002)(38070700005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0lkY0twRkhUaG43VVlMKzQ3Qk1HUDhDaUxIazlYdXl0cTFXa3J3TSsxY1RT?=
 =?utf-8?B?Zno1SzJnanB5S1pHalh6WDNKYkpMWUNNYUVTUE9TMFM2SFRXOFIwMCtuRW1B?=
 =?utf-8?B?bVk1SEV6NlBpNFNaZW9SM1Q0Vm9QVk83dHhoNEdqUHdEWjdpYnU1b1hKZUFh?=
 =?utf-8?B?WTZyeE5WeDJqbG9jSHFreGN4bVBpMTlHdmhYU2Z3NnJsd2g4UVNFWFpjU1Nx?=
 =?utf-8?B?d243V0FWZ3h1S2hobWNkSk5lNGpFOEoxa0g0OEpFK1RGanRGRlNBN1NzRlJn?=
 =?utf-8?B?QTdFMk13YzB0cmlGd1JlbUdmb0RQRksxem00bk15dnZ1VEk0TFJrK2pRYmh5?=
 =?utf-8?B?ZHFzS1R3ZXBCSDFaeCtDcCtjMm5yWEtUemdOam04cFZNWmd3Y0VYWC9mVlFJ?=
 =?utf-8?B?aDZlVTcyWTVHc2hzdXgzbnBBUkxtTTlmUzZpVFZLQ3dad2tsR3c5T2E4aVNR?=
 =?utf-8?B?OSttOWV3Y2hvM2FYQ1F4T0pnTjNzd1FPdWRBU0VQUkZxYnV6dW8xUFZ4cURw?=
 =?utf-8?B?VHQrK2pSQlVnelo1Z3lRSkhBTXhnT2ZVS28wV2hWTGhhaXBQSDRwdDFiM3li?=
 =?utf-8?B?RnM1czA3OGFOK2lQQTFYekY4ZU1aUFpMVTNzditveStCMUFiZWp0MkFpWXNh?=
 =?utf-8?B?YzR0MVVJTUJMTy90U3dRemlZYkF3YW5lU0RaZFF4VFdSSHkzNTFtbjVORGU1?=
 =?utf-8?B?Q1JCWDNPWFhmd0JrVEppamNpN3oxaTM4akU1S0VVeGZLaW5hbHJHb3BrejBw?=
 =?utf-8?B?REtNN1EreVZCSENVVi9vY2dyMTZEYThZSWlwaURtYXdGM29CN2paa0x6MzJZ?=
 =?utf-8?B?bTJ4bG53Z3FZYklrYXlMbmtXWm5MbUxkSE00cVVObWVkNVV6RUJ4ak8rRDV6?=
 =?utf-8?B?WmN4TnlNMmRkckt1ZnVoa1F3N0R4T052WTdMVEFFZTExNkhaVytWS2s4MFln?=
 =?utf-8?B?V2c2WnNVN3k2NEJXdUlvZGdOeTZpRUQ2ME5wY0JNNFBYM2xrUCtUbm1uVXd3?=
 =?utf-8?B?VGswOTlsUzQrUnBNakZwMmwzdVdWWEQ2VGtYU2xyZEdZeThvcSszbk0zYjU2?=
 =?utf-8?B?SUxoV2RUUllrajU0TTl1QWRORmNQMjl1bFdoZERHTXh6ZjZ3ekpKUEpnWURO?=
 =?utf-8?B?N1k1aEVCQll4Q1ZqWjZzcXJJSXdmbTdUa0Q4RXZFdHc2Tmo3aHlTTWJvQy83?=
 =?utf-8?B?ck9TZ2hkMWFMQWpOMU9aeDI2bWNySlRjSnhlc2ZMNHY4L1Vqa0pyTlNsbmVn?=
 =?utf-8?B?UE9TN2M1OGhNNlVDSCtMSlBRZWo1SWFsNlo1dUl1L1ovRTBxeE9NSS9YZVFi?=
 =?utf-8?B?Y0tGb21CSlFNMkRuYzRjQXBzbHVHT1NReFM5RWVucEl1OFM4cGtOaDFxQ1dm?=
 =?utf-8?B?dU1sTkF1djZCMS9SaDA4emVBaGlGQkgxY2I5aUtDQ3Bxb1VvdmFhdGRLRG5m?=
 =?utf-8?B?NzREQ0xmNStOWSt2QTd2empaa25ocGN2MEhyQTdvRGk5Nm8zQXQraVQwTFll?=
 =?utf-8?B?bjZPc2hqSEtsWmhkODB6YjZrR3dDcXlYWklQU0htcFUxaTNtcmNvSkgzNjJU?=
 =?utf-8?B?MnRIaU9SVWZ5NkFsYjdoMXEwTVJ6ak9aS2g5U0IrQ2JWcTNyL0h3VVA0QjV0?=
 =?utf-8?B?eURZOGNrOGpzSjRUc1RhcW5abFdVaVJTd2RxYmNoNjF3Nk5OUElwc2RhV0Jn?=
 =?utf-8?B?bHBmR1drcmJaaVQwRHB5bEpuelM1RXoxUkVCYmRlM2lVeVErbCt3UmxGemNU?=
 =?utf-8?B?c1J2QVdYbUhKREFUK2lnV0UwRnVjcUU3MWkxMjJSNU00bWVaWU1mcHlDTHgr?=
 =?utf-8?B?ckkxR0djUkdRMEJYdjJYVzBnTStKakZRVkFscmNxQ0J0ajBxeUFyK2U3MjRz?=
 =?utf-8?B?bVQ5NWdhTVl2UjdzbkM2bG92Z2tDcDVzcEpjQ0tsRjJIN01YQ3BYVm8zeFFk?=
 =?utf-8?B?RUtlRklhOVVoaW04bmQ1RVVnSC83WERJdnVBS0Rqa2lOSVdoNnlQZWlxL3Vz?=
 =?utf-8?B?TzBPYk1BcUxPRUYyM3Y3dkk4U0Y0dmpEK3VXaEtEMHhMa2NhdThUMkFWaXJD?=
 =?utf-8?B?RGt3cGlFeFpXVUNnM1FQREoyNVpBblhFU0RkaUFzZmNDRkp0Qm5RSVFTV2tC?=
 =?utf-8?Q?kMgGlsO3EW1Y7eqDzwZupnx21?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac1883d-4477-48a6-9b4b-08dbb985ac29
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 02:59:57.2742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+2zJN62yBm9V7AGeF6mieX+BBdLjiAl/2q6odkDBFh5i2FNcFecUAkwWHHluUGM7/uyfgU1aSqRSbCjh9BJCCrLR5rJwqD++Z997gZrH04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7008
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyMCwgMjAyMyAx
MjowMSBBTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTQvMjJdIHZmaW8vY29tbW9uOiBTaW1w
bGlmeSB2ZmlvX3Zpb21tdV9wcmVzZXQoKQ0KPg0KPk9uIDgvMzAvMjMgMTI6MzcsIFpoZW56aG9u
ZyBEdWFuIHdyb3RlOg0KPj4gQ29tbWl0ICJ2ZmlvL2NvbnRhaW5lci1iYXNlOiBJbnRyb2R1Y2Ug
W2F0dGFjaC9kZXRhY2hdX2RldmljZSBjb250YWluZXINCj5jYWxsYmFja3MiDQo+PiBhZGQgc3Vw
cG9ydCB0byBsaW5rIHRvIGFkZHJlc3Mgc3BhY2UsIHdlIGNhbiB1dGlsaXplIGl0IHRvIHNpbXBs
aWZ5DQo+PiB2ZmlvX3Zpb21tdV9wcmVzZXQoKS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVu
emhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPg0KPlRoaXMgbG9va3MgbGlr
ZSBhIHJldmVydCBvZiBwYXRjaCAwNy4gQ2FuIGl0IGJlIGF2b2lkZWQgaW4gdjIgPw0KDQpZZXMs
IEkgd2lsbCByZWRlc2lnbiB0aGUgcmVsYXRlZCBwYXJ0IHNvIHRoYXQgSSBjb3VsZCBoYXZlIHRo
aXMgcGF0Y2ggZHJvcHBlZC4NCg0KVGhhbmtzDQpaaGVuemhvbmcgDQo=

