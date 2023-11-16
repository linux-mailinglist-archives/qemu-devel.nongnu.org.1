Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E0D7ED92C
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 03:16:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Rvn-00070p-6s; Wed, 15 Nov 2023 21:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3Rvb-0006uZ-G9
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 21:16:27 -0500
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3RvZ-0001Yp-MT
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 21:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700100981; x=1731636981;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PcmAbUEJA0HXhRRgNMftmYkOsBa3fpEHvtMXjTEqGRE=;
 b=GJX9dEhtFzwo0yEm4hIYsV8koqHko8KEHlCxcKhL2rXMYjFBeo6B5n79
 mUjIn2wuPt65nVMJ7lDvWdcly2XDwatl8d+F1sPv2l1kKGvfE4Mqt9BZ2
 qORpuD6OM6A4ZI58LqQJtzD+4u5NQQnrZclij/FKFn8fRGUKxWYn/UD5R
 0P4n0QxPiYNI/aWoW+3kRYVBbfFW+gO2UgsBMiYVWD7myCFGtWXoNgJ4+
 NDjDZJRguSamwP9J20kxQTNoXS5QYAQ/yAyIBbLPEiD+IJGcGmBiFVFPs
 YM289+yvc631CJKJQwJOg7nXr7A2V9/SIDwdRIer/yjg1fZiSnHhKv0QA g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="393847816"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; d="scan'208";a="393847816"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 18:16:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="758684203"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; d="scan'208";a="758684203"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Nov 2023 18:16:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 18:16:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 18:16:18 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 18:16:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/UyOVz81as9Pp/VCPOmIjNodMId6ciN163Jubj0Rioz8pyVGOD7ARVo7kjx7Z4gT1xalrAlBov9Xc85izYem2RORJzgDrCjp2QEHtvRF6h9KngBf62UryWt7kac2Zk4x55i/oJaOzuU57/+NSF9tCxd9QFfoXTt4YIVuk1TD2i25XvCNgF+vh73AQa5P44ytADtSRDDFx4xdlDp94xi3p4/soR8OZtp8hMDzNtNWGKnspmF207RxPy6JXIS5ZcAbSVYWfxBH/6SChN8h583WyGGMgxMGclAojZKoitGw2RvqI7ruHEe53waa9H1lmLVpj4kOIk6a5fQtmwFjbMbrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcmAbUEJA0HXhRRgNMftmYkOsBa3fpEHvtMXjTEqGRE=;
 b=eT5bW0ok1iKr6YmC3reZiiNIBtwHOE+BB3oR2b1we/h2RzM+mddtkH46iWr4QKLQmmlZkQ/xmf8zUNV1CxguO7BubDIG0+UyyejLgYWPMD9qDYwgL0XAaQiK2TVfOxTLhoob8yOvr+q8daQd+YxCPkh8iFlNLqRnxVat9SU9zq3hdBPVqcrzfQjR5gmoJgxxe0yQ4+3ZqQs0jsEv8gRl43OAY/IjCvqC+tOsMrJRvxcdwkCTfWx4ifcBdQAIxsyEjwRyCrzAdqJjsAbk2uUN1DK8SMDLP1TfO2i14yM4xcMWqlcll+zx66HJN0X3uPPbVdKcLhCr28kVJ3hF6Hbcvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7927.namprd11.prod.outlook.com (2603:10b6:8:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 02:16:17 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6977.029; Thu, 16 Nov 2023
 02:16:16 +0000
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
Thread-Index: AQHaF6B1Bv9BpMJmgkqK874EmoZbP7B7W0QAgADbEZA=
Date: Thu, 16 Nov 2023 02:16:16 +0000
Message-ID: <SJ0PR11MB6744ED3C5F3F828BECBDC6FD92B0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231115083218.1973627-1-zhenzhong.duan@intel.com>
 <20231115083218.1973627-2-zhenzhong.duan@intel.com>
 <fcf2c5ec-ca54-45c4-b6a6-4f302a6cddf7@redhat.com>
In-Reply-To: <fcf2c5ec-ca54-45c4-b6a6-4f302a6cddf7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7927:EE_
x-ms-office365-filtering-correlation-id: c986cf7d-4bbe-4378-677e-08dbe64a03be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kysfj3CeB81qjZ0U+4xNEXANS/VpTGaR36xQPcuLVjxJceLJE30hQ6osYowapFjKXpLw/1QQPIpubecO3I8EnJivrWohi/nnsF6p/UZMP/UVRbk6Cg10+djSXO0sNVs0OwJ8Fx2eQCHzMhUm1QtPg9/XMBAll6dxpZKfWXxkk91MwPY2pkWwa6m6OkeEmbrWl6qMomMbHY2Xjkm3ZiS7YDkMR6343NiJwOgvJ7snvr+nKrl3P9JVt4Vsf8oLvf1oJjZTjwttTYnDS+IoH77wOZUCM2yR/V+osv8q/hGTA6BC1zpfPBCC/Ps2F96EQnOaW5QJe+Zq4ufdn47HZJ4x9uFZxxFXUtry/dyxbBEPEgwXs+8DQyoTnGAwtEtTxZXk1GbnALUDNeK87N/w9FdA0uo3yxvJLs22gQpexpgyjSK1xt2V5KwFy9LK3O1+bCCmPZRXCkwGL8OxstXJgaDgb5OLHmEC1/YQP9KysmzzaNMX0Lg2XXTG7TjpEFtbYzch9H6rTdeeBzbrWsM85qOBarCldKUonnVcI0/ckD6iJ+LzILiMXqQ9G3zQTGJbt72aMZJoxmLmfICVckjPqKq79QzADohZZC3ydfpfw9jy0fEr9AXn7mQwnNB6fGxgHwC8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(5660300002)(8676002)(8936002)(26005)(83380400001)(33656002)(82960400001)(4326008)(122000001)(38100700002)(86362001)(2906002)(55016003)(52536014)(41300700001)(110136005)(9686003)(7696005)(478600001)(6506007)(38070700009)(107886003)(66946007)(71200400001)(76116006)(66476007)(64756008)(316002)(54906003)(66556008)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnkxU1VtbmVyWVZiczhXZUlGeHQ1R1o0a0liSmNzOVk5MUZrQkNHVzFTVEtX?=
 =?utf-8?B?VWRjblUvMHZIM0QrMlhBUHNKcm9BNzBLd0JkZjZYL0JyelRCdEdvUUpqaDVX?=
 =?utf-8?B?U1FKWEJaN3pZV0c2RDFxZUhtZGtqVFBEQytCZmVwcEVPQ1J6RWlzdHA2QlJ2?=
 =?utf-8?B?RHdRVDBBa3paL2t3NUFYWDE2WGhuV1NVMUplMFhJSUp5cFlpSXhNelltSVpI?=
 =?utf-8?B?QTRtYmZ2UHAyTVdza3dmQlBzUk9XV0pYUjNUSXlyV3BaanlqTmh3VnZISXZ1?=
 =?utf-8?B?SHpnNTZuYWQ1YVc5UmJXVkd0QnQxTFJrcDZIQWNMenBybG9JWmxQczUyR3NB?=
 =?utf-8?B?NFlNbEdiYStoUmNXckRabThvOXZWZ1luQXMzeVZWdkhYVFAwR2tKNkdHWTZH?=
 =?utf-8?B?S212TUd4U21uNzVxaXVsVFlKWXRYUXN1RWNKME9QZnpWNjN3V2tVSkN6RTNu?=
 =?utf-8?B?K1pHMVFpTU0zUDZudERLTmlpTmdzNEVZZG1TQjFBa24yTGZ5Qmo0VmhLY0JW?=
 =?utf-8?B?YVNtODZuU1FNSWRMa3dqTDJES3QvVnk2WWdIT0I2OFFjUGkzOFhiZWwwa1J6?=
 =?utf-8?B?VHRJVnpFU2RkMEswSmxGYVJIOUZqYjRGMFZNYUlnek5TNlJwMUEwQVozSDhy?=
 =?utf-8?B?MUNoVnVnNHRDNWx2YXRLSExBQUR0M2YxWjQ3NlQ1OERxYU5heFpDRmlYTCtq?=
 =?utf-8?B?ZC9jNkQ5MzI1Tk94WTE5R2RlaUprQ0xnUzNNNUxKZk1yVnc1U1JyOExmczJZ?=
 =?utf-8?B?K1hIRWVPWkRWOEFnNXNvLzBaY1dzcDAzNVBOSXQ1LzFabkQ2cXR2QVlIWVhj?=
 =?utf-8?B?QytncEIvYWI3a0FUc0NNazF1REJhUnBralNJK25xNTd6SXVmSEJybWlaUm0x?=
 =?utf-8?B?QkhHY01UNTU5UjhaR3FNTlVSREVBSWRyekZlNk9LSzE0NFdaR1A3RTJkUnFo?=
 =?utf-8?B?Qi8xWHh5WXRqNlhCazJMelB5M3B4N0d3Q1creG8vb1FTTjVPY3JvTFNpaER6?=
 =?utf-8?B?enBsMDROb2FTZUdpa3A4Lzc5Um1sblRQTTl2V3dtalNKbW9nTjZrZXY0SXMv?=
 =?utf-8?B?K3V6b3RDUlB0RDhFTHlRaEI2QUZ5aVlwZ2RsNEt3Wkp6Rlg0dzF1MFI2K1B2?=
 =?utf-8?B?Qzh3S3VoY2txUnhqVWNzUlJnUk5PZFV2RGNFeGF5OE5yMXhYUkhuRktPdExq?=
 =?utf-8?B?cHlKUUIvZkdhMWNiaURPMmh4Q2NsTmFJbUx3MDRxQzJoMENua2N2VjhsWGlt?=
 =?utf-8?B?TXJNaUxxSGQrQS92UFBSMzMzTzdxS0treGFYMlgzQXljZ0JUaDZ6MStwWHph?=
 =?utf-8?B?Z3hPcUIwVDlEQnh3aTVGM3lIZWxKQ2tQcUlYbExrNWhvS2FOQjUxcjhCbDJa?=
 =?utf-8?B?aHBiL3BhMkFHRWtCZDBTUnR1MjltU3Z0cHgxaEZZN1QwR2hpUlhYVGk0WjRo?=
 =?utf-8?B?WkZQcFl6MzQ1TVVncWVFOU55RUdIY3NRWlR2Sk9TbGFPMHFxQkpOK1V3MEVq?=
 =?utf-8?B?VGx2cDc3Si8zbmVYWWFtVWtsWDhrSXY2K2V5NXlpbWJGM2xoWUtmOGROZGVt?=
 =?utf-8?B?bXVGZUxxSGZtK3BLY3VFRGM1cVBFdElFOXE5azdIdndwczhrUDAwWDdRN3Fh?=
 =?utf-8?B?K3RNVHZ6Ykoxb0hkbXVTdjRpeU96K2V3M1NaMGIrVUxud1pXSzUyNDFXOFpl?=
 =?utf-8?B?V0JxR0ZmZWRVYlB4eUVZNUw3c1MrU3BwK2ZMd2U3aXZ6bnpEN3NxWEoxb1lW?=
 =?utf-8?B?V3hOWXdCNENMOUpRZjRZN0VnY1k3SzN2Sm1xcnk0bi9JOFFPazNacHBPWm10?=
 =?utf-8?B?eDJVcldTRUtwNVd4Nno5SWtjcm5NVXM2US9JeGU4T1c3VUpGYXZkL09WUFFl?=
 =?utf-8?B?TnVZeElSWmQ1bks4bGtYMmtSODJwM3RXVEJPZ2Qza3NtRDY5L2dTeThDaGt2?=
 =?utf-8?B?MTVEVmRlcGRidmhQYkt1dW54NHkrVU1NdHM1d0FvWWg3Um40RUtDdkpYUXhn?=
 =?utf-8?B?WUdPWHlqTkJGZ3RJdW4rWlA4UTcybE5pbVBsT3lsZEpETWtMR1VMQXlvNm95?=
 =?utf-8?B?aFFIeU5yWnFoK0Rldk9UMVhuamRmVVJxSnc1YkZrV3F0dVRaNm5RTERqVW1Z?=
 =?utf-8?Q?BGtcE3RRD9Oaffhn1BA9IXFC+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c986cf7d-4bbe-4378-677e-08dbe64a03be
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 02:16:16.7689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3LQrffTbbwivmhwZvmg65oLL9ayJC0Fvx8F8ojWqeLVEYKwGMLRDsNrsMQUeX9FiRF86R63QAzVQ7HZmLoJ4tpH3ZmZGI37o3jNXfr0Z0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7927
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDE1LCAyMDIzIDk6
MTIgUE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIDEvNF0gdmZpby9wY2k6IE1vdmUgVkZJT0Rldmlj
ZSBpbml0aWFsaXphdGlvbnMgaW4NCj52ZmlvX2luc3RhbmNlX2luaXQNCj4NCj5PbiAxMS8xNS8y
MyAwOTozMiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBTb21lIG9mIHRoZSBWRklPRGV2aWNl
IGluaXRpYWxpemF0aW9ucyBpcyBpbiB2ZmlvX3JlYWxpemUsDQo+PiBtb3ZlIGFsbCBvZiB0aGVt
IGluIHZmaW9faW5zdGFuY2VfaW5pdC4NCj4+DQo+PiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRl
bmRlZC4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBp
bnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaHcvdmZpby9wY2kuYyB8IDEwICsrKysrKy0tLS0NCj4+
ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9wY2kuYyBiL2h3L3ZmaW8vcGNpLmMNCj4+IGluZGV4IGIy
M2I0OTJjY2UuLjVhMmI3YTJkNmIgMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL3BjaS5jDQo+PiAr
KysgYi9ody92ZmlvL3BjaS5jDQo+PiBAQCAtMjk2OSw5ICsyOTY5LDYgQEAgc3RhdGljIHZvaWQg
dmZpb19yZWFsaXplKFBDSURldmljZSAqcGRldiwgRXJyb3IgKiplcnJwKQ0KPj4gICAgICAgaWYg
KHZmaW9fZGV2aWNlX2dldF9uYW1lKHZiYXNlZGV2LCBlcnJwKSkgew0KPj4gICAgICAgICAgIHJl
dHVybjsNCj4+ICAgICAgIH0NCj4+IC0gICAgdmJhc2VkZXYtPm9wcyA9ICZ2ZmlvX3BjaV9vcHM7
DQo+PiAtICAgIHZiYXNlZGV2LT50eXBlID0gVkZJT19ERVZJQ0VfVFlQRV9QQ0k7DQo+PiAtICAg
IHZiYXNlZGV2LT5kZXYgPSBERVZJQ0UodmRldik7DQo+Pg0KPj4gICAgICAgLyoNCj4+ICAgICAg
ICAqIE1lZGlhdGVkIGRldmljZXMgKm1pZ2h0KiBvcGVyYXRlIGNvbXBhdGlibHkgd2l0aCBkaXNj
YXJkaW5nIG9mIFJBTSwNCj5idXQNCj4+IEBAIC0zMzIwLDYgKzMzMTcsNyBAQCBzdGF0aWMgdm9p
ZCB2ZmlvX2luc3RhbmNlX2luaXQoT2JqZWN0ICpvYmopDQo+PiAgIHsNCj4+ICAgICAgIFBDSURl
dmljZSAqcGNpX2RldiA9IFBDSV9ERVZJQ0Uob2JqKTsNCj4+ICAgICAgIFZGSU9QQ0lEZXZpY2Ug
KnZkZXYgPSBWRklPX1BDSShvYmopOw0KPj4gKyAgICBWRklPRGV2aWNlICp2YmFzZWRldiA9ICZ2
ZGV2LT52YmFzZWRldjsNCj4+DQo+PiAgICAgICBkZXZpY2VfYWRkX2Jvb3RpbmRleF9wcm9wZXJ0
eShvYmosICZ2ZGV2LT5ib290aW5kZXgsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAiYm9vdGluZGV4IiwgTlVMTCwNCj4+IEBAIC0zMzI4LDcgKzMzMjYsMTEgQEAgc3Rh
dGljIHZvaWQgdmZpb19pbnN0YW5jZV9pbml0KE9iamVjdCAqb2JqKQ0KPj4gICAgICAgdmRldi0+
aG9zdC5idXMgPSB+MFU7DQo+PiAgICAgICB2ZGV2LT5ob3N0LnNsb3QgPSB+MFU7DQo+PiAgICAg
ICB2ZGV2LT5ob3N0LmZ1bmN0aW9uID0gfjBVOw0KPj4gLSAgICB2ZGV2LT52YmFzZWRldi5mZCA9
IC0xOw0KPj4gKw0KPj4gKyAgICB2YmFzZWRldi0+dHlwZSA9IFZGSU9fREVWSUNFX1RZUEVfUENJ
Ow0KPj4gKyAgICB2YmFzZWRldi0+b3BzID0gJnZmaW9fcGNpX29wczsNCj4+ICsgICAgdmJhc2Vk
ZXYtPmRldiA9IERFVklDRSh2ZGV2KTsNCj4+ICsgICAgdmJhc2VkZXYtPmZkID0gLTE7DQo+DQo+
VkZJT0RldmljZSBpcyBzaW1pbGFyIHRvIGEgYmFzZSBRT00gcGFyZW50LiBDb3VsZCB3ZSBpbnRy
b2R1Y2UgYW4gaGVscGVyDQo+cm91dGluZSBsaWtlIHdlIGRpZCB3aXRoIHZmaW9fZGV2aWNlX3Nl
dF9mZCgpID8NCg0KU3VyZSwgd2lsbCBkby4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

