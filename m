Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1156831458
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 09:18:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNbE-0001bT-0p; Thu, 18 Jan 2024 03:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQNbB-0001bD-UJ
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 03:18:05 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQNb9-00011o-Fv
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 03:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705565884; x=1737101884;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2qMnkAWP3yqJ8HhNZCBHebTumZl09Xh/V513TpQTdA8=;
 b=PIdU297fyifQaUNZ2O0xgm1+lQPYfT9Lmt7QbcMa3qRdH5z88BuL5hjI
 UwZp+JQDldoea7mcaRDcQkh9qf9C2+yqi94lkFTVTrWiZPQcPBDw5AusY
 RTYS6+Oprbkf722WtFuhcm4gUBdSIgNF10/xvagonLgT9qD9xmrPq4LRL
 CMiIXm0kjLr2libx2WkYKH9wTSnnSs677Ee/0jVSFSwQNL76wBvSWlfge
 Gcwdy6lw+wJQcf+iyEWdRfXi5mQWB4JIZcHCofzIujzOhOQwByaYnC9cL
 kT0pFqxg16WxDElA38o2ZkzUdjXK/MterW1nh47gUzEmzxgphQVXJiesK g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="18978263"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; d="scan'208";a="18978263"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 00:18:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="875011054"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; d="scan'208";a="875011054"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Jan 2024 00:17:59 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 00:17:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 00:17:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 00:17:58 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 00:17:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q91qP7uVQLAHE3JEjC+Clt4vf1MsT1btgTVFzogrbAn9mIaS3L2TbhL3qw1vhtd3CZNijghJtHpLBIfPraKApWoDvKluFOTZA3sdi7kYZ+OjhXbhrKe0fONSkFcV2HMU4Ov8MQfEstxAb0SUHGekHBymkNxBEujxLdz8czXuuKCatO7bbfpr7VpcqVkYFrYtcq8YPueczsUybgjOupQjX/vSBmhnWFRRIAqrD1hpnzw+9vquQPDS9FcesVv1gcJDMNYhlAOI0MNIgv2nTUhHwzGzhc6B/J4smyHhBFp2n+lnJ4Pmolk6CMZdaVyFyLIoIN9/uHM33k7w61tZEHET9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qMnkAWP3yqJ8HhNZCBHebTumZl09Xh/V513TpQTdA8=;
 b=UWTnyVE2D1f3YrN9IAP7uOO+NBpAhwmuwyoF1LSROcckkc4YiIiJT3VNQCdGlG3HtqgD1fC4YKyagUOjITU4rhr8KV9f42r704faRw/3634oA3FpQm84GYX2aFiiQTxXqqDra7jo+8injHkwwHXsLkctuhRRrOAy7DPxuJESKQRDJR2vmD2eYI4jTfMf+eaR8rzbmMSXK0q/VU99xZ022nb+45fE1P5mcemEoFFYfB7mKXm5nMSTmCCYcHGEwFE12ziYydCzRKDdTvxETQXgGuPIYIfFmQCnVJXl7VUy+rR+pjaxqpyGgsg7qTga9fPaAWtXxANjMmK6UQup8lNEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB4967.namprd11.prod.outlook.com (2603:10b6:510:41::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 08:17:55 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace%5]) with mapi id 15.20.7181.020; Thu, 18 Jan 2024
 08:17:55 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH rfcv1 4/6] vfio: initialize IOMMUFDDevice and pass to
 vIOMMU
Thread-Topic: [PATCH rfcv1 4/6] vfio: initialize IOMMUFDDevice and pass to
 vIOMMU
Thread-Index: AQHaR5v0AZ3rmcpUu0e+6RYUwmKBmbDeJw+AgAEV2eA=
Date: Thu, 18 Jan 2024 08:17:54 +0000
Message-ID: <SJ0PR11MB67446801223842563733262A92712@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-5-zhenzhong.duan@intel.com>
 <d6b4c54f-f24d-4e30-9e93-9c126a42e00a@oracle.com>
In-Reply-To: <d6b4c54f-f24d-4e30-9e93-9c126a42e00a@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB4967:EE_
x-ms-office365-filtering-correlation-id: 75987cdb-aaa0-4f77-5b74-08dc17fdf8ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dh+bUSCfZGe06kwET6aK9hfO+TnWam3w8/P3MPBcEsBdpq67toyb/RktjrDDhgxdCZcmoEM1ZwRcjrrItnBzdDCgk9VZnoe2hUAsGQ+pT/am7SePnKie5DjITPf7a3rC7MtbTkm8zrmRmap2JljE32CK9lq9jqH3v+ezQLrUKi1fXol2KEgn9gxA2Ec4ztOyKpHGPs6l54ABN29dhtcb9TAmEWtmOYz1PmO6pYbKDsa9MgAuiS75qitdhdY0zx8f8uUt7QngZ6WCl44ULBOXmwF/ht9mEy7wCn2XiaX5rTe2ouaOWn8CeEQT/fGeaDlhXrtiy/0t+ZSIQqNK8ObGQmYQNveFJ+pi4NI9VKRFHNhYN6JZ4+JBMsl0lrfxAffo+6+rF6ipegSGJetwAnq7X5kwmVinngbR1+ysCSREfC9DyF65xDkMGKIlrScBuYwrvD45JhK4XCH5We+juaqnf256MOf/4KEMIRSQDS4eQEN2rmWEPDgzAFaBFJB59x1hf5EPi2PYCzcEDzbY/bRF92UMtVym0X3A+zWZ/D6QxvLUg0Pv54KD9TsLK3FaSmP4g7F8/x42ItijLwAnbrE5+wUZaupcnTmd7e1jZaHNgPA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(122000001)(38100700002)(66476007)(66446008)(66946007)(66556008)(76116006)(316002)(6916009)(54906003)(64756008)(86362001)(478600001)(55016003)(7696005)(6506007)(71200400001)(2906002)(52536014)(4326008)(8676002)(8936002)(5660300002)(7416002)(26005)(33656002)(9686003)(83380400001)(41300700001)(82960400001)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWNiVWVBTEhzQmx6OFM5MXlLWHB4dmFuMUg4RHJMSUN5WElUcHl6U1BhU0F1?=
 =?utf-8?B?ZXZzd01TM3JLWFJLdjRQZWZNMUVuZ3pqaXFrUUhqb2lmTzF2aGZCQnhyM1Fj?=
 =?utf-8?B?dXIvWUtJV1k4TlpMSFhJTWhMV2duYnlSZFFOek1xcDErU21FMitkM3Q4bm9n?=
 =?utf-8?B?QmlQVmpPZUdPb21MRlpZeEc0eXpyb2I4Q3RMY1lqZnVyckswOSt6bkl1ellF?=
 =?utf-8?B?ZEtuV1kzRVlodWh2NVk2UXBwb3JKNFNNUVg2ZVZGK0U1M3hMOWltMEV4RC9N?=
 =?utf-8?B?alVnZmFnc2pJTFhodXJsMzBmcno5b2V4UVN3UGFZVitaRlI4eUxFU0V6K0Fs?=
 =?utf-8?B?cGVBa2tFblQ0OGJxNXRoVmRaUWFXSDNRQU1aTU1UTW1EeGRkU1JxWFpxTXE4?=
 =?utf-8?B?bzUzbmdCWmtPZ1JTN0NYWjU5bjdrMzZQaE5mdm44aGNHMExGcE9OZDM5MW9p?=
 =?utf-8?B?OFZCc2k1Mm53dFB0VDNBc0RrRURLMGxXQ2QrV1l0bGdsMFVORWVKYUVuWDRO?=
 =?utf-8?B?aEJ6Zy8rNDBxRjVBWjNQM0t2SUNNcmFJL0RPSmU3bVVDcTBJU21pMWtZNVRY?=
 =?utf-8?B?UEZGTnJRWmpmYjNjSkZmV0NwK1Byd1k3TkRzZnRWL2pId1VqRjFMYUdpQXMz?=
 =?utf-8?B?OG1scWNyRzNBZHZpbFl0b0pxeEp0S1hveUFkYWVza0dWTWFaMUc1U2MrTmk0?=
 =?utf-8?B?QnlxbE92cDA3LzhzOWFKV0RtOWpJZERkNWRCaldaczRqMFIvV3BEQnRHK2Ix?=
 =?utf-8?B?d09tSU9rVGdja0VXUHE3aGRkRjRqa2I0RUdTNXNEUjB0ZXp4cDliQUR1MklW?=
 =?utf-8?B?dGZYRW1uaVA5cHhsRXRHZ2k4bnQrNlByTTMvekpvSVROYUpIWmxTR0dZU3Vs?=
 =?utf-8?B?Tzd2RXZteTlETmxhekJxTlZYVE9BcTF3VUdHenZQdDh5bnRvWkIyTE5wN0tj?=
 =?utf-8?B?WkpkWUFiQXAvKzlXM21PcW5jWjFZcHUxeFI4MU1lNlVoc0JjVUdpVXYvNlFI?=
 =?utf-8?B?d1ExQjJiRy9OVjNUbTNwbWxpdnZSN1V3N2Evb09yNysvTGlSbzlGZnJoUjlx?=
 =?utf-8?B?R2hKNmRUeHNaYkFHRWZwcXBSNVVQd2dFMWh2Znc4ZDZwTUdUQmpheU9QK213?=
 =?utf-8?B?bVR1eTEyQmxSZkRDL1pTZzZlSXpyakRWVi9YbTBLTlhFZ2dQRFdhOG1pcHhl?=
 =?utf-8?B?eC9QdnRyaFJLaFVyQzZ0ZTNYMHpCSGZHV1BlRjdMTFBRa3ZGS1MwcTMxK3ZT?=
 =?utf-8?B?WHpkMDlxM2c0QTlhaVVRTjFJLzRqL1RqVVFoR09ZRExLMEJZT2phTTRHY0tS?=
 =?utf-8?B?OFVxRncxMklBay9IRndMb1BORVBOc2pxQnp6dmZLNTh1RVBsbCtGMGxCSWZ0?=
 =?utf-8?B?VXU2M2d0NXM3T1pLREtMTlRsQVo3aVZ2aWJ1dSt2RTA3SkFzSkNueFZueVo2?=
 =?utf-8?B?cUhwdGdCMGFaWm1aOWhLZWFOaVZPT1RYc0UrOXdsblA1QmwyeTFwNCtqekFr?=
 =?utf-8?B?L0g1bk1rNTVuV2QwZXdZNGVHZENCVmJSVFpYM28xeVZDdnMxUW9mK3VyWE55?=
 =?utf-8?B?R2x4ZDNPbjF6dGdmYnZiSXBqd0xxOEtFN2hRZ3VwWFRBS0VCbFhRZUdsaGdy?=
 =?utf-8?B?ZWIrVUFOdkp1ck9TR29aVnM2OGpQTXlwTVlRV2pmWTNwZHlEbGQ2Q2c1KzR4?=
 =?utf-8?B?NW5XM3lMYUVMZStsV0tBS1RhN1Q0RzhIVXhUZnQ5YmZ0ZjhWcWU0VTN3cHhN?=
 =?utf-8?B?eWhqWTVrTzg4ZGQ4bjBlNzJOWGwvSURuWWxVM0VoNDV4OTVqcXRUK0ExSUFy?=
 =?utf-8?B?RzR4d2YycERBRlFaalJzVjZqY3pxd3FId0QzWllIMDd1MGtIOGQxMDgwN3FX?=
 =?utf-8?B?bWZtMmMycmNhSmJHVW5vOVBjWTBxcWhsWm85QnA2b2Jxbnh2NVY2cmFtT0d4?=
 =?utf-8?B?MHZVa1lNQ25rRnIwNm4zOTBUKzN6NW9RZ3owcWJyaWNyMXZEdktHanRyK1FY?=
 =?utf-8?B?Mjlhc1BhM2dMSGZKSE4xZ0NqR1lxbU5mNU4rYWtRYXA5VldHdHJqNERuM0RS?=
 =?utf-8?B?Rk1wTUwwd1AvNkNVa2pSWms2TDlHWHl4akdnN2FTN3FLTlE1bGltZ3dBSkNX?=
 =?utf-8?Q?yaf3oKMa4tbI3GZnP/2srMNUS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75987cdb-aaa0-4f77-5b74-08dc17fdf8ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 08:17:54.9647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KgSt1/D53Ogl6QiMxfvJYRz6ouWToh39u4bDVtxeu+nmpZbGm/HxCqpKo3q0uUkbx1BelDQ8Bd8xEueUKPfpoea+zaVfGWtCdjvVr0BjUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4967
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YxIDQvNl0g
dmZpbzogaW5pdGlhbGl6ZSBJT01NVUZERGV2aWNlIGFuZCBwYXNzIHRvDQo+dklPTU1VDQo+DQo+
T24gMTUvMDEvMjAyNCAxMDoxMywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBkaWZmIC0tZ2l0
IGEvaHcvdmZpby9pb21tdWZkLmMgYi9ody92ZmlvL2lvbW11ZmQuYw0KPj4gaW5kZXggOWJmZGRj
MTM2MC4uY2JkMDM1ZjE0OCAxMDA2NDQNCj4+IC0tLSBhL2h3L3ZmaW8vaW9tbXVmZC5jDQo+PiAr
KysgYi9ody92ZmlvL2lvbW11ZmQuYw0KPj4gQEAgLTMwOSw2ICszMDksNyBAQCBzdGF0aWMgaW50
IGlvbW11ZmRfY2Rldl9hdHRhY2goY29uc3QgY2hhciAqbmFtZSwNCj5WRklPRGV2aWNlICp2YmFz
ZWRldiwNCj4+ICAgICAgVkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWluZXI7DQo+PiAgICAgIFZG
SU9JT01NVUZEQ29udGFpbmVyICpjb250YWluZXI7DQo+PiAgICAgIFZGSU9BZGRyZXNzU3BhY2Ug
KnNwYWNlOw0KPj4gKyAgICBJT01NVUZERGV2aWNlICppZGV2ID0gJnZiYXNlZGV2LT5pZGV2Ow0K
Pj4gICAgICBzdHJ1Y3QgdmZpb19kZXZpY2VfaW5mbyBkZXZfaW5mbyA9IHsgLmFyZ3N6ID0gc2l6
ZW9mKGRldl9pbmZvKSB9Ow0KPj4gICAgICBpbnQgcmV0LCBkZXZmZDsNCj4+ICAgICAgdWludDMy
X3QgaW9hc19pZDsNCj4+IEBAIC00MjgsNiArNDI5LDcgQEAgZm91bmRfY29udGFpbmVyOg0KPj4g
ICAgICBRTElTVF9JTlNFUlRfSEVBRCgmYmNvbnRhaW5lci0+ZGV2aWNlX2xpc3QsIHZiYXNlZGV2
LA0KPmNvbnRhaW5lcl9uZXh0KTsNCj4+ICAgICAgUUxJU1RfSU5TRVJUX0hFQUQoJnZmaW9fZGV2
aWNlX2xpc3QsIHZiYXNlZGV2LCBnbG9iYWxfbmV4dCk7DQo+Pg0KPj4gKyAgICBpb21tdWZkX2Rl
dmljZV9pbml0KGlkZXYsIHNpemVvZigqaWRldiksIGNvbnRhaW5lci0+YmUsIHZiYXNlZGV2LQ0K
Pj5kZXZpZCk7DQo+PiAgICAgIHRyYWNlX2lvbW11ZmRfY2Rldl9kZXZpY2VfaW5mbyh2YmFzZWRl
di0+bmFtZSwgZGV2ZmQsIHZiYXNlZGV2LQ0KPj5udW1faXJxcywNCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHZiYXNlZGV2LT5udW1fcmVnaW9ucywgdmJhc2VkZXYtPmZs
YWdzKTsNCj4+ICAgICAgcmV0dXJuIDA7DQo+DQo+SW4gdGhlIGRpcnR5IHRyYWNraW5nIHNlcmll
cywgSSdsbCBuZWVkIHRvIGZldGNoIG91dF9jYXBhYmlsaXRpZXMgZnJvbSBkZXZpY2UNCj5hbmQg
ZG8gYSBidW5jaCBvZiBzdHVmZiB0aGF0IGlzIHVzZWQgd2hlbiBhbGxvY2F0aW5nIGh3cHQgdG8g
YXNrIGZvciBkaXJ0eQ0KPnRyYWNraW5nLiBBbmQgdGhpcyBtZWFucyBoYXZpbmcgaW9tbXVmZF9k
ZXZpY2VfaW5pdCgpIGJlIGNhbGxlZCBiZWZvcmUgd2UNCj5jYWxsDQo+aW9tbXVmZF9jZGV2X2F0
dGFjaF9jb250YWluZXIoKS4NCj4NCj5IZXJlJ3Mgd2hhdCBpdCBsb29rcyBiYXNlZCBvbiBhbiBl
YXJsaWVyIHZlcnNpb24gb2YgeW91ciBwYXRjaDoNCj4NCj5odHRwczovL2dpdGh1Yi5jb20vanBl
bWFydGlucy9xZW11L2NvbW1pdC80MzNmOTdhMDVlMGNkZDhlM2I4NTYzYQ0KPmEyMGU0ZjIyZDEw
NzIxOWI1DQo+DQo+SSBjYW4gbW92ZSB0aGUgY2FsbCBlYXJsaWVyIGluIG15IHNlcmllcywgdW5s
ZXNzIHRoZXJlJ3Mgc29tZXRoaW5nIHNwZWNpZmljYWxseQ0KPndoZW4geW91IGNhbGwgaXQgaGVy
ZT8NCg0KSSB0aGluayBpdCdzIHNhZmUgdG8gbW92ZSBpdCBlYXJsaWVyLCBqdXN0IHJlbWVtYmVy
IHRvIGRvIHRoZSBzYW1lIGZvciBleGlzdGluZw0KY29udGFpbmVyLg0KDQpUaGFua3MNClpoZW56
aG9uZw0K

