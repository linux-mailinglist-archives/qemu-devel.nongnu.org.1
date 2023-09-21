Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5367A9125
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 05:04:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj9y0-0006ua-At; Wed, 20 Sep 2023 23:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qj9xx-0006t1-Lb
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 23:02:57 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qj9xv-0007XE-2i
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 23:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695265375; x=1726801375;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1v1HVRaCr+GKSE6QOv2QMPgpV67uoWcw/fSkzVcvXjI=;
 b=ePYFAbEaqFIhQfgizIE/9Zs2heLGpaem1pngV/HMAX1r1i6U0nSJO1S+
 RQBIOwOopDXIz/oTNKD2KGsyOo07IcW16J+nLjDj1UZLVw1C1tiahfeev
 w8C0l+MPBfeWAU0hcrrHoOCWLdT7KCxO+cpoK1I+AaCX/PSA5zkLfW2HU
 K+RJYaedm9KLbgv0jilVR83aNAeTG+LgT0lMyRtuihCEe+R6qpu76IUXI
 C0CgSPLnooTzEDgZzQDdKjeDHIZYKHFAcuLHD2NkxW0booXMVw9HoR47h
 74PBJ8n4ZFTDmG3gGyLS/n6U8e2CFTCdQExZ8EGgeeB1+6T9VhhZ+WYiw w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="383150250"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="383150250"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 20:02:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="776251236"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="776251236"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Sep 2023 20:02:47 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 20:02:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 20:02:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 20:02:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNy0yR5UYFMP1nTeg9YucZaa8FD5fgKSZfHm8U4jpHQk95vAmkSWtYxxoA79rZ0KntmyJJV/lJQJ5kbcPUdV7+rgVY+XBpgbjCblDfBUglsMw1k1yksZ8ZxUxmurGf2NiJVczvRP00bl6CdqmitM2neW/asQhOFhlJ2SNZIq+iCXSxTX+m4XWqfC/1puduloPaz3jJv0n40Lb/X3o1WZSw6zFcRyqbQzFXSExSAZqtzQk1BOzp8P7Kx5kE8QLEar0O+PqvL+/Ex5Hd7DmKbuxNJC1Uxt4V8t+RSW2jBYarWJLBea8vB6eO0SCI0zKjniVu8TJBbA3Wm7J0/gQAgm+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1v1HVRaCr+GKSE6QOv2QMPgpV67uoWcw/fSkzVcvXjI=;
 b=MasdDtJ7snOeDuVw7Hvzv94ynXl7UOf5qhUIClggy5rlbVFpssENMoG0YXaEzoO4GltJFfYOG++C/yuWvQk92B3bJSK1uJA8pw1woOchD4zWesOMsITy0ljVyGUyrSUsZoXGmXWa3pGZ2K25bklWA1TqU8LK76O6JNzNout2oC2KJMmrOE5FcbyL7st7LQXzIOShnbZWVdbdIrRp6kg43h5Q8zpKw+j8Ud5HS28UwwbgFHB89qR5f31M3w/c1EKfigKmxK+4eLM2h8NezkFS+2L3fy5TbMmJHwRI3/5dNfpdBLAd9oiqOyK1zT19Vpf0XI270Z7pw0CStJuRN3Ec6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB4949.namprd11.prod.outlook.com (2603:10b6:510:31::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 03:02:34 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 03:02:34 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 08/22] vfio/common: Move legacy VFIO backend code into
 separate container.c
Thread-Topic: [PATCH v1 08/22] vfio/common: Move legacy VFIO backend code into
 separate container.c
Thread-Index: AQHZ2zAuXzuGu3kMvEeK6w3plT2NRLAj0b0AgADm5lA=
Date: Thu, 21 Sep 2023 03:02:34 +0000
Message-ID: <SJ0PR11MB674409880B4BD6B49164377592F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-9-zhenzhong.duan@intel.com>
 <f5838c21-bed2-b381-9969-70790b0db439@redhat.com>
In-Reply-To: <f5838c21-bed2-b381-9969-70790b0db439@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB4949:EE_
x-ms-office365-filtering-correlation-id: ff273b0a-7a65-4df6-8c98-08dbba4f3417
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iZxqDYXs9y5ENUxQLTimEB8+Rb5cfKU7di6Kr1704etVKrh1b87crGQvf/bU/oDPGVp/kYhaI2v8CeGbWVplk1up2LO3RCwfjXLEQCFm25uV583hmn00CBMWeDDKgWobC2BrJS+jwXL3wfOrbTl9WYZxMNiPBq991Z6rs3Mu63R4eJKmamFCaKTXtoIBmyQ49b+9s+hVRzLJXZtBEkCBSIZ0fucmxdqvS94XkTKwOy/Yuv0AKTvNXtS4tC8eeCIwtwkCeSDSmmRzCrnAf8tjof1rqzAuCH1Gk5BjVYFJfHSeB2wFU78hURnpuIupk74z1yVORftu4ij3RrQTkYx/xKqvQffqvthw808SNsEO81sViFMdY8UHcJSA35m0Q4pMIs4F0S4AQip1EU5rRCjka26V4gMz7N4PaWEMarCV9JyPh/MnePK0Y6BwLkQouwcKFN++jYqtPQU1H2CHgrI11UEg9/2d47Foobbah2y1oU8nhaUbxIXr7qXzmtqQrcKOhJGvSO1uJObd5QSs+55alPqLuk4+kSXg4YrFBOXZuSAxQvDFN+PAFIeDugUtFOa65OHrnfyBAhjTTRxhpnzTqW9lOmAMq0aT0XWNx+wf1JXdWZRm4SAAQwdQ2gfdIs3U
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(1800799009)(451199024)(186009)(7696005)(9686003)(6506007)(71200400001)(478600001)(83380400001)(26005)(107886003)(5660300002)(2906002)(4744005)(66946007)(64756008)(76116006)(8676002)(66476007)(8936002)(54906003)(110136005)(316002)(66556008)(41300700001)(52536014)(66446008)(4326008)(38100700002)(33656002)(55016003)(82960400001)(122000001)(86362001)(38070700005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3hwYW4zRWJLWHdFd2ppdzA5Z2lmSzRxZmpTZTdJRXdZZFE5ekxkWVlGVjBp?=
 =?utf-8?B?Q0IwVG9md284YXV2TFlXSWpSNGNrUnMwMGhUK2p2WmFlcys0RGlUSzFRZExp?=
 =?utf-8?B?Tnc0akh5RDZnaVpYSlBGL2IraVQwV3VaWFBrbkhGRWZDQ0gxL2NIYUU3c243?=
 =?utf-8?B?Y1NjRFFHZkVEeEdYK3VwWUFIQzB3MEZoWURDY3FDMWN3RFU3QVhqYmY4N2Y2?=
 =?utf-8?B?WVF1MWQ2RXZVVU9WZnlja0t0NHJxOFZadmt4Tk1NdS9OQmx5bER2MXdJSzdw?=
 =?utf-8?B?cnRRb1d6N3BrR3VYWVNkMmp2U01HbkZZQmRXSjZ0eDRVaVBuVWduQk1UVHBm?=
 =?utf-8?B?MTduOWNBL29VeDFpb0JocC80ei9lUHZnVVQxK3hLbS80RnVQc0RwclJVNnRk?=
 =?utf-8?B?WnRJeDhFcVpIVURaLytSU3ZxZ1pVQVd6UmNRdDVtUzQ3OUV4TXdPRUtrUkV1?=
 =?utf-8?B?T0x0ZGp5N3JYNjNNK25ZRWdIc2VoREQyRDc3b1E5cWRWRGdrUndGNnhia2Fu?=
 =?utf-8?B?RnF0UkhBRGs1ZXdwdVNHVmtJakhaWk9sSlAySTFON05SRXMvdmlJME5mS1VN?=
 =?utf-8?B?N3R2KzlEUzhFRm4yTVBERGQ4V1c1ekd5Y0lpRjRQWWJGR01GMkx1RncwL2U5?=
 =?utf-8?B?bmhGei95UkhaSXY3am5rZlk1akFSUm5qL2Jza20wV1lEUDZwNlNHS3RkNlJB?=
 =?utf-8?B?bklJZmh4K2pOK3lPSmIzcTUxdTYxUDZXeXQrK0RFZWFoZ1dqZjJ1UjJmK0Z0?=
 =?utf-8?B?NUdYWTZ0U3FsbDNzVStyRE5DdmhqREtaOG5NK3VIL0VhSnhGeHlCc2x0RCsr?=
 =?utf-8?B?Qmp6L0huRnozRDhFcXBXOHJwOERDblhqT29LQlJwbVE3UndWQXJHeFViamg4?=
 =?utf-8?B?RHFBNmlOU1FJZzN2ZEtoREhIUHdNdXFiYk0ySjdpNDd3TFBiZnJSSEw4REE0?=
 =?utf-8?B?SklFVmJGSFhUbzE2N0EyNmh5a3pjenZURnVsRTZCZURvSXB4aDZXS0g4V3dI?=
 =?utf-8?B?SkpSaDdoSTk1WDBUN2NpT2Vtdlo5V3l2dEdkU3k2aHJDWGZzNkVKS09SbkpZ?=
 =?utf-8?B?QjZhMFNZeG9IeE9vOHRTM1loZlNDNEhYNzB5Wk5qbUtCT2E1Z0VvWWFhS2xE?=
 =?utf-8?B?ZFNBbW1ROUVnQXpQb2hjc203NXFnUm00a0hicDRUMXYvb3g4bTl0MzhVK0RH?=
 =?utf-8?B?blk0YWNvT3NlUHJSb1Zyb0Z5M1J4TDNtbzRxUXNyeS9WN2tiVnNRR0lSemRE?=
 =?utf-8?B?dVVqZ0dXM0FxbDlOWTJmVWxKdmpYTGdYU0YzOTEvUmZuT0xmcTY4VjNZcmRZ?=
 =?utf-8?B?V0F4UndFaHdKZEtKbVNsZ1NtOUJnV1F5aVlJeGlnVnpJOEhhYW9WUFIwRTFs?=
 =?utf-8?B?MDlEMUl0ZHYzUVF5QVp1eGZRaXJuRVduY1cxMEU3Z29hTFc1YWVhWis3cnhl?=
 =?utf-8?B?TTNGNTIza21KTTNwQ21kakdLakc4TEF5d0RWVmpRVmRQbWI5aVNWR0ZZT0xy?=
 =?utf-8?B?M25LZWtIcy93cGZiaThWRXRzTnRZTUNKejRXbG9OZ0JHTy8xVjZ4STFrbE56?=
 =?utf-8?B?cmkxYlRTQnRBN08rdHZHTVFBVEcrY3c2MUtvMWpkQjZQSVNCaklOWWNTWjNM?=
 =?utf-8?B?RHByRHB3N1JMa0VPVWNpTnkyK1V1dGMvRm9ZLzBHQW1kbFFaeElIT281ZWwy?=
 =?utf-8?B?RURqd3lvU0pUaW03eC9BVjdxNHlsbUhGdUNIZnRNeUJ6eUdNVjFnb3JRdUo2?=
 =?utf-8?B?bGIyUUVhSVJJWkVXOFBGTGxOYkFranV3aTV0Wit5bXk2UGRJampBQkJFdENB?=
 =?utf-8?B?TXM4cFBCeDZpODcxcU5GbDVzeHZsWWIzYU5jUGZJUnpwelpXNldHOU0xRTh3?=
 =?utf-8?B?Y2RiWG84SXR6d0lKdzdZTU53SEk3STA0VzdZT3QybCtsVjE0Q0NYMDJFRXkw?=
 =?utf-8?B?YXF5ODRHbVNoT2F2V3dCcW0vTG5QL3NOQys2Q05wL0d3VW9VTUlxbmhiRXZZ?=
 =?utf-8?B?R28va2JKMWdYS214MHRHemdsOXdvSTdML2VnMU9ycDZrLzBpYW9XUmtzY2xR?=
 =?utf-8?B?d0JWOWRLNHdWd1htZkhFdDMxUDBHMk42cHo5R3RNZ0g0SHNtMG1MQldvU01U?=
 =?utf-8?B?eWsxVTdodmx2YTBQbm1tZE5yVExvK21uMWEvL0Rka3FSektCWmxWWEpERlJk?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff273b0a-7a65-4df6-8c98-08dbba4f3417
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 03:02:34.1768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vCxtKp9s3g6QRXRe8jGC+OWR+mBAxMN5aUussB1l6BkdwgkN8/jL97mEurx8U0IyGPcAXJ2syyafbvxhmOakKwAXVHWIQjh/VVxRtb6OTDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4949
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyMCwgMjAyMyA5
OjEyIFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MSAwOC8yMl0gdmZpby9jb21tb246IE1vdmUg
bGVnYWN5IFZGSU8gYmFja2VuZCBjb2RlDQo+aW50byBzZXBhcmF0ZSBjb250YWluZXIuYw0KPg0K
PkhpLA0KPg0KPk9uIDgvMzAvMjMgMTI6MzcsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gRnJv
bTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pg0KPj4gTW92ZSBhbGwgdGhlIGNvZGUg
cmVhbGx5IGRlcGVuZGVudCBvbiB0aGUgbGVnYWN5IFZGSU8gY29udGFpbmVyL2dyb3VwDQo+PiBp
bnRvIGEgc2VwYXJhdGUgZmlsZTogY29udGFpbmVyLmMuIFdoYXQgZG9lcyByZW1haW4gaW4gY29t
bW9uLmMgaXMNCj4+IHRoZSBjb2RlIHJlbGF0ZWQgdG8gVkZJT0FkZHJlc3NTcGFjZSwgTWVtb3J5
TGlzdGVuZXJzLCBtaWdyYXRpb24gYW5kDQo+PiBhbGwgb3RoZXIgZ2VuZXJhbCBvcGVyYXRpb25z
Lg0KPj4NCj4+IE1vdmUgc3RydWN0IFZGSU9CaXRtYXAgZGVjbGFyYXRpb24gdG8gdmZpby1jb21t
b24uaCBhbHNvIGZvciBjb250YWludGVyLmMNCj4+IHVzYWdlLg0KPm5vdGU6IHRoaXMgbWF5IGJl
IGRvbmUgaW4gdGhlIDNkIHBhdGNoIHNpbmNlIHZmaW9fYml0bWFwX2FsbG9jIGNvdWxkDQo+bGFu
ZCBpbiBoZWxwZXJzLmMNCg0KR29vZCBpZGVhLCB3aWxsIGRvLg0KDQpUaGFua3MNClpoZW56aG9u
Zw0K

