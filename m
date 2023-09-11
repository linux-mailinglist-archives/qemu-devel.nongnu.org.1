Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0188779A784
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 13:04:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfehN-0003Dn-TX; Mon, 11 Sep 2023 07:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qfehL-0003Df-7I
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:03:19 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qfehI-0002Js-2G
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694430196; x=1725966196;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8NL8yn/myUtXXVY7eHsQ17tZzYmW7ep7MyUeAly2Fso=;
 b=jQ/vBb7qkQm1IVWHr2dil6avFABixtPxhI1AMXRAO594ixvlOx85TjYo
 e9yn1+TL1ye6Re5X57MYa+eCresC4CHnP+Lgte0GVJThvzlCxfjQ/txDH
 cmlvF+fhZUkFfIER2CLX6PcHL74my7ZSod9GeOSHq7OQggDGefS+Et83V
 uG/yj/lAa3WN0ywqa8yXVuhjbmdMvrkV/Oo8lPM/oIKqT+AApsAwvqZOo
 ISlDW1J9yETbnlJIc2VWKAoX+AeML5+3+GiTTrWFPUm79uRfFqcGqFj6r
 6iA0/apwhpwkkhZ1ehVrck/a/sIlx00n/XxOmomG9GySrolFIeABs8Iko Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="377968217"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; d="scan'208";a="377968217"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2023 04:03:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="719950457"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; d="scan'208";a="719950457"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Sep 2023 04:03:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 04:03:11 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 04:03:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 04:03:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 04:03:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irwWbQK+zlcxR1O9JF8KUoP/HKNT5Yinh6eO8AAIeI8Y9ICasI7zT2RlsWL1PO8/c95TJte66xHrg4a8voT1hR45jAQYXJms/ADl7pFUbMMOkKutRtm+HLPWH/qg6E2heF22SJ5t+XEyjJc4D90qacZ996IZKdPciKR56cFkBG1bxB/8709GolIv9pbl6uPBJJsWKTV0urBl31Jy/fOBG7h/OmE5J98kIm3eWyr4Wazo3032gRjObI18EerjgyrilqEe7+kxBnc477NbxeHBvel8b6+9/JCt5qdxBxqu/BdBOi2tewdQTPxUyG8jUs9U7koTfRU9wKEoWn1O8b5flw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NL8yn/myUtXXVY7eHsQ17tZzYmW7ep7MyUeAly2Fso=;
 b=G5VnMta5Ut1ngJ4W8YmDyJd42EzZKEGEj7a7yo4MD8TcygSSTfcTD5jkEuSYUGu2Glvnyhk7cWVYaOefjBMGqkfueo3CZnhT9R0b4YSWsyxydQulBbfOpWOJvEDBe7oEavpqxxcI7PY9amGscueR9s69VtctEF3zbZUFHhoYnt5sRFsSiapOx6qXJjNyaLJuHebju5cQ24+taqLggGkI2Gp2j28gw/4U6eVYB0tQ0MoraqDSLJNy41a3Sz9r68UTejdtz20rizhXenDEvhJX3BFyXbNrrOHT42Ci9KDKChZBEtwKeURMi6fkQK9EUlYKNFxhqLDIxhpKR86NvAnXfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM8PR11MB5637.namprd11.prod.outlook.com (2603:10b6:8:33::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.35; Mon, 11 Sep 2023 11:03:08 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::cac7:3146:4b74:8adb]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::cac7:3146:4b74:8adb%6]) with mapi id 15.20.6745.035; Mon, 11 Sep 2023
 11:03:08 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Avihai Horon <avihaih@nvidia.com>, Gerd Hoffmann
 <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v1] vfio/common: Separate vfio-pci ranges
Thread-Topic: [PATCH v1] vfio/common: Separate vfio-pci ranges
Thread-Index: AQHZ4tZ5L57QHMgEL06JAtdqYWcKlbAVVWmwgAADeQCAAAcVkIAAC2uAgAANp2A=
Date: Mon, 11 Sep 2023 11:03:07 +0000
Message-ID: <SJ0PR11MB674470FF4DF16E41554E6CE492F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230908092944.47589-1-joao.m.martins@oracle.com>
 <SJ0PR11MB67441FE6EAE5A0AB8992FEF792F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <83d2de3c-7a3d-4943-d4b5-1f4a86030512@oracle.com>
 <SJ0PR11MB6744CC7FE6F48E7D17ABC3CC92F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <c2a52c37-b6e5-1229-3e22-90a5ad8068b6@oracle.com>
In-Reply-To: <c2a52c37-b6e5-1229-3e22-90a5ad8068b6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM8PR11MB5637:EE_
x-ms-office365-filtering-correlation-id: 5c98b8c4-82c7-4cc9-e8e2-08dbb2b6ae2f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wp2YWSmwOlg83tNwIX5o+3K2mwgUddGFX/oiZz3pNv6YkvinuSjXv/RfI23bBDO8vUWEPMuRWMPo/J0m/lDGMEZO2lpZEz2lwUVC8NAZTjKHdrP05R+CsG5iglQLswXtBoyE9u3wIyAVquCNqNi3eyQrx9rqEU5mnTrxi6f/xPswa/o4+EUvVMIAbjvgbiPV6GgUXVNPFJUKRZrOzawFTdbbO4+WpTgYrfdZ507wJMF5wJgZjlBWgWECTtaL4+wDvsouyneQe5lHP4Q+92bFSpe5u9HqwT80iAAd/ltgNhBbPUF68n/vjcoaXU42nl9SDGRdH4Y9+oyczxM2dXYMiD72j73bBobCfacdKw7v5nQj869RwEz2HDxeFGvHs6lS7Zp8o4L3J+g+eYBM/ogOlIvkVe4aH7JCbqxAFsyWvAIw4iT+eLcywH+M3IioWMUjvaghiE6qJjHSl8FMkO/Mo5Oxuf2DXuBS8ULiaF8uKCzK4uLgSVaTihSB1QkNyvXJTIiicOo6nSAeX9EKiPA+IgWLwezZSPxP/YodZ8VAIyF6aaTv3uEyEPv06kUsuSfdomUvr8dnTfpu+O4pNRzLak7Y5GzB0w6dibEHSLy13W+Ot/UsKIwNo8RsBWAi5q0q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199024)(1800799009)(186009)(66446008)(4326008)(54906003)(52536014)(64756008)(478600001)(6916009)(316002)(66476007)(76116006)(66556008)(66946007)(8676002)(5660300002)(41300700001)(8936002)(2906002)(55016003)(122000001)(83380400001)(38070700005)(82960400001)(38100700002)(33656002)(26005)(86362001)(71200400001)(9686003)(53546011)(7696005)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ak14c2RaS0FrWHBZMnZCSzdteHVPTHVFQ2J3TkpqYVplWUIxREFSYUUwWXFG?=
 =?utf-8?B?UktmVnB6RllybUY4YnNLNGNFWFJYUU9LMGovaGdqcWRHcTlsa2hRSmZjaG9n?=
 =?utf-8?B?QitVV0JiZ080TXk1b04wbFJKTXU2QkRLRVVJNm1xUUlXSmw2Q2JXZ2pWaENW?=
 =?utf-8?B?UWVZTXdBZ1QxTnRJZndIbGU0OFliQnI5VDRDdFRmdzJMZWtlRTl5QlpCU1FZ?=
 =?utf-8?B?Y2tsenRQTDY4MGNBdVdQME0wL3Z2emVhamZEVm5ROTQ4YUR5ZFpIMDI1T1lL?=
 =?utf-8?B?MG1hbW1tR2R4K1pERHFCTzlIbHBOY2RIUDhVSDF5Vm5iNzFUVzI1TXp2cDBk?=
 =?utf-8?B?QWt5SUplWlgzRlBoMldGN1VXZGRKcW5YajhucEYrSzlJMHRXWUhEVm8wTkZl?=
 =?utf-8?B?WkVSWGQyUHU0eFRSWFNzdVE5R2tacjdTbVBqU1hVSHBRU3V3Um5ERjVFTHk5?=
 =?utf-8?B?aXdFSHlzZDVPTkEzeDlGZmJnRVo5cnAzR1I5VWpTdzZhcjdSbXVZeFp3MnhL?=
 =?utf-8?B?Yy95M28yVjNwZUt1THRNbndNOHNaenJZc1J0bnFKbjhUOW93THZWUzVoaUdz?=
 =?utf-8?B?REl0ZWxPUy82aFVCbzdSL2pQeXJPVXNYc0h3WFFma2xFTFBzcEJ3a2ozOXZO?=
 =?utf-8?B?K0NUYURQdU5mUlJzbFNDNU82aGxzRmw5aHdJT1hTdzdJUzlxMUs5dGlINEtK?=
 =?utf-8?B?YSt6M2pEQmswL0Q4ZTVzNlFFeitkZTA0bWFZTHZyWHJxNktFVXVIZ08rM1g3?=
 =?utf-8?B?ellGQVd6NjBoK0hMelVvVVFxR2VBNEQvdnBmRXBnckJsVXVMT3VFdHNEMkdv?=
 =?utf-8?B?K21yWGQxVHpVSllOMko5Vkd2RnRvdzIzeGdMLzNqUHpOSjQ5ZEkzTVFFbkg1?=
 =?utf-8?B?OUtvM1k5SEFhRmdyT2dNb0ZramNKc1VCeTJIMHdvOGtxSUpXaSthUWxHN3F4?=
 =?utf-8?B?SXV5OFd0dTIrcUhSdE1qN0lOd1hBaGlCRlViRy9yUXJLS1FJVzBidG40VndR?=
 =?utf-8?B?aFplOGdKUWxGZ0Y1eUQ4akQ3WE1TYi9GL1FZYS9pa2dxS1ZzV1d6MktyK1dW?=
 =?utf-8?B?NkhCWXZRWDZJQW44UUFmWnpTSXNlZzdVNU9mYTNCakQwRDA4M0FHS1Q3K0Vy?=
 =?utf-8?B?eHo2KzhpdGM4ZXpCTFlyUTJQbldyVG10YTlkWWtzQXFmUk12OXNqQUlaU0sx?=
 =?utf-8?B?OFFJYldSVWUranhKRm93MmxOeEQ0UG81K2JSYlRMRzk1YUlrUDhQY3dQdHNt?=
 =?utf-8?B?eVZTUHVqbnRQUElZNHdHNGx5UENuTXJpeVhEeS8yS0tzRjhpWHNOaTFBSmh0?=
 =?utf-8?B?WmVyTGpUdnl5V3l4aGxVbnZpclQ2RXR2Q3QxVEVTN3BVUXlqTkVMTjF1T0Qw?=
 =?utf-8?B?dDNlTUZlTDVYR0RIUTg2WFQveEQ0ck1kVXp0K1RIZ1JVMDh6dFVPVEZISU5K?=
 =?utf-8?B?RXlDb0JDemY3M0tXUkNaNzJaNVE0cHhlai9FQzJ2dGp4UkNXQXIrZzNwbllI?=
 =?utf-8?B?clBVZk54ZDRZVnlsMHI4WUxOcllUSjM3N1hqMW9nUlNVYmY4MnRrMXA0d0RW?=
 =?utf-8?B?djZDWTF1d21XbDNvSXdNdmx6NnhPS1YxZVNGMU9BVFptVFNWN3d6RWJKR1F0?=
 =?utf-8?B?RklaWlQ2U2VySDcrV2QzbW93TUN2WnJVcWlQbDZEQVVKeG5KVU9yMHdFY2tO?=
 =?utf-8?B?MjJTRjZBbHBUTU8yVDRVRjZCVjNEdGVqczZQaU9DV3FpTkgrRkdlVk1oNmxt?=
 =?utf-8?B?Y3FEdXNiYTh1N01xYjE2T0h3UHo2bGEyVVNFUS8vM1grb0RQcTJ2cUFtL0o3?=
 =?utf-8?B?MHI1ZkpLdnJ6Q0RrQThiTGREd2Vkb3dZcS9xRE5EbWcwdGZMRTVGdk9sNjRF?=
 =?utf-8?B?d245QTdaM2FKWXJUb0xYWVU3WGZFUzBQVUZNOUpWMWllS2ZCdzhvdUVTYk5D?=
 =?utf-8?B?WmFXNEllR2x0dTV4Vkl0c1lTWCtLaW9DOVFyYkl4cXFXdFFiSnI4OVArUGNo?=
 =?utf-8?B?bG9iY0pDWVZXcThzenZVbGZBcFZUUmVZZWJMQkNzUjliZ24velk4TVNDeDFv?=
 =?utf-8?B?Y1NRTGJ1Z2xrVHhsREUwMmNqYzR2OGJ6dGgrT3dkcXdZZXI5UXVkanN1dUZO?=
 =?utf-8?Q?pRR5LeQzhJd4WTA+o1BMw3rNz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c98b8c4-82c7-4cc9-e8e2-08dbb2b6ae2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 11:03:07.8915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wjm9p2Syv3ZrfNVrfIpWoDst/s4+HabOj4ZJSlxUwr3CXUwLXq5chjcc/OAju4Ib6pgKT5K64bS5kQC+VGAW/S7xrDAO4o6wqMatRq67Hsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5637
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TZW50OiBNb25kYXksIFNlcHRlbWJlciAxMSwgMjAy
MyA2OjEzIFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MV0gdmZpby9jb21tb246IFNlcGFyYXRl
IHZmaW8tcGNpIHJhbmdlcw0KPg0KPk9uIDExLzA5LzIwMjMgMTA6NDgsIER1YW4sIFpoZW56aG9u
ZyB3cm90ZToNCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEpvYW8g
TWFydGlucyA8am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj4+PiBTZW50OiBNb25kYXksIFNl
cHRlbWJlciAxMSwgMjAyMyA1OjA3IFBNDQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gdmZp
by9jb21tb246IFNlcGFyYXRlIHZmaW8tcGNpIHJhbmdlcw0KLi4uDQo+PiBJIGhhdmUgYW5vdGhl
ciBxdWVzdGlvbiwgcHJldmlvdXNseSBJIHRoaW5rIHZmaW8gcGNpIGJhcnMgYXJlIGRldmljZSBz
dGF0ZXMgYW5kDQo+PiBzYXZlL3Jlc3RvcmVkIHRocm91Z2ggVkZJTyBtaWdyYXRpb24gcHJvdG9j
b2wsIHNvIHdlIGRvbid0IG5lZWQgdG8gZGlydHkNCj4+IHRyYWNraW5nIHRoZW0uIERvIEkgdW5k
ZXJzdGFuZCB3cm9uZz8NCj4NCj5UaGUgZ2VuZXJhbCB0aGlua2luZyBvZiBkZXZpY2UgZGlydHkg
dHJhY2tpbmcgaXMgdG8gdHJhY2sgYWxsIGFkZHJlc3NhYmxlIElPVkFzLg0KPkJ1dCB5b3UgZG8g
cmFpc2UgYSBnb29kIHF1ZXN0aW9uLiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgbWlncmF0aW5n
IHRoZSBiYXJzDQo+KmFzIGlzKiBtaWdodCBiZSBkZXZpY2UgbWlncmF0aW9uIHNwZWNpZmljIChu
b3QgYSBndWFyYW50ZWU/KTsgdGhlIHNhdmUgZmlsZSBhbmQNCj5wcmVjb3B5IGludGVyZmFjZSBh
cmUgdGhlIG9ubHkgcGxhY2VzIHdlIHRyYW5zZmVyIGZyb20vdG8gdGhlIGRhdGEgYW5kIGl0J3Mg
anVzdA0KPm9wYXF1ZSBkYXRhLCBub3QgYmFycyBvciBhbnl0aGluZyBmb3JtYXR0ZWQgc3BlY2lm
aWNhbGx5IC0tIHNvIGlmIHdlIG1pZ3JhdGUNCj5iYXJzIGl0IGlzIGhpZGRlbiBpbiB3aGF0IGRl
dmljZSBmL3cgd2FudHMgdG8gbW92ZS4gTWlnaHQgYmUgdGhhdCBCQVJzIGFyZW4ndA0KPmV2ZW4g
bmVlZGVkIGFzIHRoZXkgYXJlIHNvcnQgb2Ygc2NyYXRjaCBzcGFjZSBmcm9tIGgvdyBzaWRlLiBV
bHRpbWF0ZWx5LCB0aGUNCj5kaXJ0eSB0cmFja2VyIGlzIHRoZSBvbmUgcmVwb3J0aW5nIHRoZSB2
YWx1ZXMsIGFuZCB0aGUgZGV2aWNlIGgvdyBjaG9vc2VzIHRvIG5vdA0KPnJlcG9ydCB0aG9zZSBJ
T1ZBcyBhcyBkaXJ0eSB0aGVuIG5vdGhpbmcgY2hhbmdlcy4NCg0KVW5kZXJzdG9vZCwgdGhhbmtz
IEpvYW8uDQo=

