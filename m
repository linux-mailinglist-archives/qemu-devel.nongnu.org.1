Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 527697A946C
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 14:54:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJ1Z-00085r-Vk; Thu, 21 Sep 2023 08:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjJ00-00069N-Vp
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 08:41:44 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjIzN-0001iX-6b
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 08:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695300061; x=1726836061;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jU9rtE8ZWFBCfHSmeRLWRclEvuN8X1XmE+kJIrW3WNY=;
 b=GHNJ+gp8iy50qSmFIet/Q6Tinu2iyhvX5OjoqqZePOdtpS460MEQjenz
 1/a3RN5t8mdph/fg2Usd+NRDpVtdWyXh4Xc5Li1B/tf+RZ3RJ3GdB8ywz
 t7UXxa32dRnY/0Adk5exnZ4/v3AqcTuyhZb9Ul0aahnXRs8T2nzYTP6xf
 QsyynTm9nu2oXRA+KYy/qkqvV0iDpO2eEINQaDFbe0Dgn3cObVj8SjtwM
 FJZASuDj8+AvdomCWvYk9yhHcHJVwvEuhiTIXwqSNNfD7IaHUvb0BE4ZR
 S1hMij7zg5YSTLeFCyLNGJtl3ka8sgisNwuClZN6i/renjxRVCGu3B9ec Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="383220983"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; d="scan'208";a="383220983"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 03:26:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="862404259"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; d="scan'208";a="862404259"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Sep 2023 03:26:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 03:26:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 03:26:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 03:26:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 03:26:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/CYP2fHUkDrRhAPtscmJZOKgL4rECPL3wyRKiLDcYPWYslELj0cWL2m2PemrQF4WZgD9MItk3UbuahPs0WrQSjdmS0we+SGkLn9LTOijsfhYPaKJDAfflTB+dXgsDeCtakf9KY477Pzb2pMkg3M4ZEjSN6ofn0fG+I9srS+py4AkhuMIkR+mhkmyJoaFMKImY8/0kyBCqSZX6424yLSHH1mY1NJFggvSOeY3Ltjz8dbEkEEpQHuTHlqLxoG2vuIoo97cTskM0jirgDNKHDzM1bR54oxyjctXZr2QrvmGHUUg8GZFlnPJl7ZzoGDgekJSlNKuE0nitdOug6LIIT+/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jU9rtE8ZWFBCfHSmeRLWRclEvuN8X1XmE+kJIrW3WNY=;
 b=aVzwSwTir7jr55np8chy/v52f0SSM+XApUbR+wWKG8Bm5MQK3KrU5hOFtbYmGwaj9OH+UYwwDwi+QLU4WAK4X927/bG/CsSc2bkRl4kY/ae3+qaaTQpYso5AU58OeGgQNXkn63LW3iUNnQKoGDiDTYl6hGWcyzLodvi1UW/DnvPpPZx0MTHDrgnAyac5WW9m/zb3uTHn0mggrru/MnznG/1qxl9xcbC5G6yweg5eyuZnZE7oKw+QZEWTCN+pco0bKDAUuyy3AchCndRudPV6PcehtpJWcA1A3OUS72VE8MrNESolellXzXuCAYqDEm+fhbBdaLpQJxxSxhyYG/yrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY5PR11MB6437.namprd11.prod.outlook.com (2603:10b6:930:36::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 10:26:21 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 10:26:20 +0000
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
Subject: RE: [PATCH v1 09/22] vfio/container: Introduce
 vfio_[attach/detach]_device
Thread-Topic: [PATCH v1 09/22] vfio/container: Introduce
 vfio_[attach/detach]_device
Thread-Index: AQHZ2zAt41ZDXvCO40WspZxldOFEyrAlKiQAgAAK0+A=
Date: Thu, 21 Sep 2023 10:26:20 +0000
Message-ID: <SJ0PR11MB67448BB74DBC48BDC5E1C16F92F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-10-zhenzhong.duan@intel.com>
 <aa25cfff-d83b-cd2e-05bc-554b44c54584@redhat.com>
In-Reply-To: <aa25cfff-d83b-cd2e-05bc-554b44c54584@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY5PR11MB6437:EE_
x-ms-office365-filtering-correlation-id: 47a9792c-ab31-4536-316a-08dbba8d32c1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ReMrdHEi0Qcbx47/Kpcb+FPUTFvFIw6z63yu48jsRNyHQwVbAAZqYsmIfT1ME1fKdxjbzAF6jhntM9EjhWBN1ogDLZhzHIX8C8HWnJilnpA6RWn4zEqAvwHQROLhMWxyVOaFCBFo0j/ln6OEl+hBodywmI3TNAUZeKdVTaEkZQvMA2jgJPZTldvCjvepcilSUPbF1UvXbcpL1Zks2LVe4uVVSQvHfSHvGSYDBUIFlqPN3lXhs/jfW8pdX+5wGotDoC7op+CCaFj0C3F8x/UTbH2wNj7Ugxk8+naLFN1i0WxsQzK1TrbjQosybvVOQ7Jr8ON7/wqH3xz1/M6f5pplA+tjzcQ+IRbCucINVXjs0GYXwxXiWELhnfSwM2Jh0HryhQd7gpxl8c9Biy7sCnVbzH8CbXv7r8BT38cUhYedr1wUrml5bQqJFqdQD7KPcwAd514qwPRDgRNj63UoGekeIgHyuC4FkFZmFVZ2OUO8Xq/1ao4oRNeywcfLq7ViUk964d9oDyKy+VEPTQMg6TaPlcuGYokdJN/yi3cIuWBsgqJsoPDe+M3SaXRoFewYSxeKMnkhpJfdV54P7bYBbkNBfFOxVOKNOZLX06tF8m/F1DmtlsDRGHBhzKBiZg57Zruk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199024)(1800799009)(186009)(55016003)(5660300002)(107886003)(66574015)(26005)(41300700001)(2906002)(122000001)(86362001)(38100700002)(82960400001)(38070700005)(4326008)(33656002)(52536014)(8676002)(8936002)(83380400001)(478600001)(9686003)(6506007)(7696005)(316002)(76116006)(71200400001)(110136005)(66476007)(66946007)(54906003)(64756008)(66556008)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjRTVTRDK0ZRUkNuUGlvc3NKMEhHN1oyUGtnc2RSbGpOQkVYbmVqNkxiZ2Z2?=
 =?utf-8?B?aEtEWVA1MVVzZDM3clY1dFNISWdkdnAvS0g5b2trNDN5QnB2WXBwOENURVV3?=
 =?utf-8?B?dlgrS1pxQUswSUoyYVM0M3M1ZDQ5WjYwbWhxb25YNDlYdDlBZ21Xd2I2cjY0?=
 =?utf-8?B?SWxYV1ZhRTZIQUtIT2tBWElKemkrdjNDcXdGalk1V1RkUGUvSG1wMTZReG15?=
 =?utf-8?B?bkhvdmt0NmY3UW5GV2VLZkFKZ1hlUTZYSk1TdGR6SlVja0Y3OWMyOWthZjh1?=
 =?utf-8?B?VVhjeXM4eVJOa3MyQ1ZFTDhScmEzRGFWencvcitvbE1UcE5TeHprZFJWRE1K?=
 =?utf-8?B?L215OEV6dHB0anRldWRGSVBmTVd5dDNFQVh6dUxIWWphaXNNNEdqSGk2cFlD?=
 =?utf-8?B?a0pTVXE1UnRMU0lkMTJuV2NrV2lhY01aN1RGa2EwWlVSMGlWMmg1b01BVndU?=
 =?utf-8?B?bCtWMmg1WHFrQTBVbDVIcmFnZlRXbGhmOXEza2RVU0JsZ0tzZjF4S25MT2JW?=
 =?utf-8?B?ZGpIMjNHS0JyZWkxKzZSclllV21Mazlad0xBaW51aDRzRGd3ODZxelNqQTNz?=
 =?utf-8?B?TzlzYXdqZ0UvdG5IaUkyQTQyWUVmdldNWU1mQk5Wa3FvY29IVzlwN0xQTWo0?=
 =?utf-8?B?MVFDTFI3dDZ1THdpK3EwRjdUc2JjblVnVm1OdWkweGt0MHlpc0FYTGd0OS9S?=
 =?utf-8?B?UzlMUkRDN0I2aUhHRlZZcC9kSGUveXNidzBBLzI3ek4rdXJmTnhuVHdMQzRa?=
 =?utf-8?B?K2dDODVteFN2bktLbk5XK2ZjOEJCblR0MGM0V2tCd1lvenN4NVRJb1JtSXB5?=
 =?utf-8?B?MmhjVmQ0a2VPZWJKTUFPK25TQ3RNdTdNTW1rNHIvM1pNaktJUGkwTWtoRkpM?=
 =?utf-8?B?T0RjbG9CV1Rsd2x4YUlReTFqTHppQXA2a1poYWI1RlZGcFNUMXptRHFIcTVi?=
 =?utf-8?B?R3Rnd0pPME5DV0h2OVlJa1R5VzRUMjN6dnZhYmsrY2NOc1FidkFjM0FIT0hH?=
 =?utf-8?B?U3h5ZDg4Wk5mS0Eza2QrZU5iMmROakpuY3JaNWRqNFB4dHlFZnVKL3FNdFFO?=
 =?utf-8?B?dnBOVTdXUDlHcW1oTUVoTzdnRWlvcENYaFAxbVJxYnYzUXllTElxKy93ODV2?=
 =?utf-8?B?dkp3WGc5dEZLSjhMeVVPVi9qbXo5V3ordjNSTTBibUh4TGFXUm5MVjhvSW5B?=
 =?utf-8?B?YUVFYUJtS0txd2htZUdFeS9FY1BVSE9JNkszUnRtc3lPL0dVSDFPVWFPNUJW?=
 =?utf-8?B?cFZiWFdFYVJVdmlZYlRENG9yRFFtUGJaNUFIVkJTZFp1aGN3dW51VW5RS2Ns?=
 =?utf-8?B?QnE0TG1qOEQ0cXlYZTJqQ3hHalg0OEdvdjU0NnlOS2V1Zzc5NnhkOGlFTkF4?=
 =?utf-8?B?Z3F0akVrTFUrTlhqc1kwVVQyM1pSbnc3cW51NWxBZHhUSHdUS2ZuWlFRNTJY?=
 =?utf-8?B?QzZwWFRCQkRIVTFBRWJDblV2VW5ja1RrK2E3RDlqNWQ3Tll3UGhnbVQyckth?=
 =?utf-8?B?bElqZWc4ZVpjRG5adDh2S0E0VVdZa2dFMUhHN1g4VXFJa0lVVEdvMmxoWU8x?=
 =?utf-8?B?U3N3UnluUVVYWHNDSEp0N1RjaC9VNThQT1BRS08xeUo4bjBVWktnNmQvd2dp?=
 =?utf-8?B?L1E3K3BmVXVUd1hvMExPc08vc291dUVsNjhob1RpdFJtRWl4aGptRzVvZ0x6?=
 =?utf-8?B?dHkzbmprRGxicE16RWJYZ3R5UHN0T1hGUjZTRlBHTUk4RjRPMDh1ek1GRkxP?=
 =?utf-8?B?Q1ZscDFXZ2JYa2EwWFZlTytaZlJmQkdVS0xobVBDOUlaSlBWRVBYdXE5a2xK?=
 =?utf-8?B?bzVDMFlPYk9SMWhVZXVPVE80UW04c0dFRlFpQU84QXU0U1F3TmxzQUNVWlha?=
 =?utf-8?B?NkJRMmV4Tm5DVHBvSjk3RXFYVE9SY3E0bU52em15aXpMYWVIMFVyWTBOdDho?=
 =?utf-8?B?cCtreGpSNU8zK2ZGZmYvWHdqSk4veHpaVEliSG4ybitRYzZUd1lZU2lYTUgz?=
 =?utf-8?B?SXBWS1lYcTdNRHpqc2pEUDN3WExpNzdzVktqeDU5WGdhZHoxN3dOTmg3UVo0?=
 =?utf-8?B?UlY1OE5yZzdDUkZ1cDZpdzhtYS9vbXVKQVN0b2IraTJQMGVVSW83RXhtRnBs?=
 =?utf-8?B?QkFLUnBDejdoYWJPM1VCMTlISmJjdDEwaWhYd25KZlIwQVVLdlVhcTdBd0Zy?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a9792c-ab31-4536-316a-08dbba8d32c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 10:26:20.7532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kzHILl2V/eszE5jbJBODXHrbnblhBT/SaXGH2TMkJRAlnCsLvh1tJP4LSDT6p9kprZKWlfSj5+N9ajIjlYKXuwiFVmgP2bo9t9YLz3xshf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6437
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001 autolearn=ham autolearn_force=no
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDIxLCAyMDIzIDU6
NDUgUE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDA5LzIyXSB2ZmlvL2NvbnRhaW5lcjogSW50
cm9kdWNlDQo+dmZpb19bYXR0YWNoL2RldGFjaF1fZGV2aWNlDQo+DQo+T24gOC8zMC8yMyAxMjoz
NywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBGcm9tOiBFcmljIEF1Z2VyIDxlcmljLmF1Z2Vy
QHJlZGhhdC5jb20+DQo+Pg0KPj4gV2Ugd2FudCB0aGUgVkZJTyBkZXZpY2VzIHRvIGJlIGFibGUg
dG8gdXNlIHR3byBkaWZmZXJlbnQNCj4+IElPTU1VIGNhbGxiYWNrcywgdGhlIGxlZ2FjeSBWRklP
IG9uZSBhbmQgdGhlIG5ldyBpb21tdWZkIG9uZS4NCj4+DQo+PiBJbnRyb2R1Y2UgdmZpb19bYXR0
YWNoL2RldGFjaF1fZGV2aWNlIHdoaWNoIGFpbSBhdCBoaWRpbmcgdGhlDQo+PiB1bmRlcmx5aW5n
IElPTU1VIGJhY2tlbmQgKElPQ1RMcywgZGF0YXR5cGVzLCAuLi4pLg0KPj4NCj4+IE9uY2UgdmZp
b19hdHRhY2hfZGV2aWNlIGNvbXBsZXRlcywgdGhlIGRldmljZSBpcyBhdHRhY2hlZA0KPj4gdG8g
YSBzZWN1cml0eSBjb250ZXh0IGFuZCBpdHMgZmQgY2FuIGJlIHVzZWQuIENvbnZlcnNlbHkNCj4+
IFdoZW4gdmZpb19kZXRhY2hfZGV2aWNlIGNvbXBsZXRlcywgdGhlIGRldmljZSBoYXMgYmVlbg0K
Pj4gZGV0YWNoZWQgdG8gdGhlIHNlY3VyaXR5IGNvbnRleHQuDQo+Pg0KPj4gSW4gdGhpcyBwYXRj
aCwgb25seSB0aGUgdmZpby1wY2kgZGV2aWNlIGdldHMgY29udmVydGVkIHRvIHVzZQ0KPj4gdGhl
IG5ldyBBUEkuIFN1YnNlcXVlbnQgcGF0Y2hlcyB3aWxsIGhhbmRsZSBvdGhlciBkZXZpY2VzLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2lnbmVk
LW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0t
LQ0KPj4gICBody92ZmlvL2NvbnRhaW5lci5jICAgICAgICAgICB8IDY2ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+PiAgIGh3L3ZmaW8vcGNpLmMgICAgICAgICAgICAgICAg
IHwgNTAgKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgaHcvdmZpby90cmFjZS1ldmVu
dHMgICAgICAgICAgfCAgMiArLQ0KPj4gICBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCB8
ICAzICsrDQo+PiAgIDQgZmlsZXMgY2hhbmdlZCwgNzYgaW5zZXJ0aW9ucygrKSwgNDUgZGVsZXRp
b25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vY29udGFpbmVyLmMgYi9ody92Zmlv
L2NvbnRhaW5lci5jDQo+PiBpbmRleCAxNzVjZGJiZGZmLi43NDU1NmRhMGM3IDEwMDY0NA0KPj4g
LS0tIGEvaHcvdmZpby9jb250YWluZXIuYw0KPj4gKysrIGIvaHcvdmZpby9jb250YWluZXIuYw0K
Pj4gQEAgLTEwODMsMyArMTA4Myw2OSBAQCBpbnQgdmZpb19lZWhfYXNfb3AoQWRkcmVzc1NwYWNl
ICphcywgdWludDMyX3Qgb3ApDQo+PiAgICAgICB9DQo+PiAgICAgICByZXR1cm4gdmZpb19lZWhf
Y29udGFpbmVyX29wKGNvbnRhaW5lciwgb3ApOw0KPj4gICB9DQo+PiArDQo+PiArc3RhdGljIGlu
dCB2ZmlvX2RldmljZV9ncm91cGlkKFZGSU9EZXZpY2UgKnZiYXNlZGV2LCBFcnJvciAqKmVycnAp
DQo+PiArew0KPj4gKyAgICBjaGFyICp0bXAsIGdyb3VwX3BhdGhbUEFUSF9NQVhdLCAqZ3JvdXBf
bmFtZTsNCj4+ICsgICAgaW50IHJldCwgZ3JvdXBpZDsNCj4+ICsgICAgc3NpemVfdCBsZW47DQo+
PiArDQo+PiArICAgIHRtcCA9IGdfc3RyZHVwX3ByaW50ZigiJXMvaW9tbXVfZ3JvdXAiLCB2YmFz
ZWRldi0+c3lzZnNkZXYpOw0KPj4gKyAgICBsZW4gPSByZWFkbGluayh0bXAsIGdyb3VwX3BhdGgs
IHNpemVvZihncm91cF9wYXRoKSk7DQo+PiArICAgIGdfZnJlZSh0bXApOw0KPj4gKw0KPj4gKyAg
ICBpZiAobGVuIDw9IDAgfHwgbGVuID49IHNpemVvZihncm91cF9wYXRoKSkgew0KPj4gKyAgICAg
ICAgcmV0ID0gbGVuIDwgMCA/IC1lcnJubyA6IC1FTkFNRVRPT0xPTkc7DQo+PiArICAgICAgICBl
cnJvcl9zZXRnX2Vycm5vKGVycnAsIC1yZXQsICJubyBpb21tdV9ncm91cCBmb3VuZCIpOw0KPj4g
KyAgICAgICAgcmV0dXJuIHJldDsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBncm91cF9wYXRo
W2xlbl0gPSAwOw0KPj4gKw0KPj4gKyAgICBncm91cF9uYW1lID0gYmFzZW5hbWUoZ3JvdXBfcGF0
aCk7DQo+PiArICAgIGlmIChzc2NhbmYoZ3JvdXBfbmFtZSwgIiVkIiwgJmdyb3VwaWQpICE9IDEp
IHsNCj4+ICsgICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJycCwgZXJybm8sICJmYWlsZWQgdG8g
cmVhZCAlcyIsIGdyb3VwX3BhdGgpOw0KPj4gKyAgICAgICAgcmV0dXJuIC1lcnJubzsNCj4+ICsg
ICAgfQ0KPj4gKyAgICByZXR1cm4gZ3JvdXBpZDsNCj4+ICt9DQo+DQo+VkZJTyBoYXMgNCBvdGhl
ciAgcm91dGluZXMgcmVhZGluZyB0aGUgaW9tbXVfZ3JvdXAgZnJvbSBzeXNmcyA6DQo+DQo+ICAg
dmZpb19jY3dfZ2V0X2dyb3VwKCkNCj4gICB2ZmlvX2FwX2dldF9ncm91cCgpDQo+ICAgdmZpb19i
YXNlX2RldmljZV9pbml0KCkNCj4gICBzeXNmc19maW5kX2dyb3VwX2ZpbGUoKQ0KPg0KPndoaWNo
IGNvdWxkIHVzZSB0aGlzIGhlbHBlci4gVGhhbmtzIGZvciBpbnRyb2R1Y2luZyBpdCAhDQo+DQo+
DQo+DQo+PiArDQo+PiAraW50IHZmaW9fYXR0YWNoX2RldmljZShjaGFyICpuYW1lLCBWRklPRGV2
aWNlICp2YmFzZWRldiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIEFkZHJlc3NTcGFjZSAq
YXMsIEVycm9yICoqZXJycCkNCj4+ICt7DQo+PiArICAgIGludCBncm91cGlkID0gdmZpb19kZXZp
Y2VfZ3JvdXBpZCh2YmFzZWRldiwgZXJycCk7DQo+PiArICAgIFZGSU9EZXZpY2UgKnZiYXNlZGV2
X2l0ZXI7DQo+PiArICAgIFZGSU9Hcm91cCAqZ3JvdXA7DQo+PiArICAgIGludCByZXQ7DQo+PiAr
DQo+PiArICAgIGlmIChncm91cGlkIDwgMCkgew0KPj4gKyAgICAgICAgcmV0dXJuIGdyb3VwaWQ7
DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgZ3JvdXAgPSB2ZmlvX2dldF9ncm91cChncm91cGlk
LCBhcywgZXJycCk7DQo+PiArICAgIGlmICghZ3JvdXApIHsNCj4+ICsgICAgICAgIHJldHVybiAt
RU5PRU5UOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIFFMSVNUX0ZPUkVBQ0godmJhc2VkZXZf
aXRlciwgJmdyb3VwLT5kZXZpY2VfbGlzdCwgbmV4dCkgew0KPj4gKyAgICAgICAgaWYgKHN0cmNt
cCh2YmFzZWRldl9pdGVyLT5uYW1lLCB2YmFzZWRldi0+bmFtZSkgPT0gMCkgew0KPj4gKyAgICAg
ICAgICAgIGVycm9yX3NldGcoZXJycCwgImRldmljZSBpcyBhbHJlYWR5IGF0dGFjaGVkIik7DQo+
PiArICAgICAgICAgICAgdmZpb19wdXRfZ3JvdXAoZ3JvdXApOw0KPj4gKyAgICAgICAgICAgIHJl
dHVybiAtRUJVU1k7DQo+PiArICAgICAgICB9DQo+PiArICAgIH0NCj4+ICsgICAgcmV0ID0gdmZp
b19nZXRfZGV2aWNlKGdyb3VwLCBuYW1lLCB2YmFzZWRldiwgZXJycCk7DQo+PiArICAgIGlmIChy
ZXQpIHsNCj4+ICsgICAgICAgIHZmaW9fcHV0X2dyb3VwKGdyb3VwKTsNCj4+ICsgICAgfQ0KPj4g
Kw0KPj4gKyAgICByZXR1cm4gcmV0Ow0KPj4gK30NCj4+ICsNCj4+ICt2b2lkIHZmaW9fZGV0YWNo
X2RldmljZShWRklPRGV2aWNlICp2YmFzZWRldikNCj4+ICt7DQo+PiArICAgIFZGSU9Hcm91cCAq
Z3JvdXAgPSB2YmFzZWRldi0+Z3JvdXA7DQo+PiArDQo+PiArICAgIHZmaW9fcHV0X2Jhc2VfZGV2
aWNlKHZiYXNlZGV2KTsNCj4+ICsgICAgdmZpb19wdXRfZ3JvdXAoZ3JvdXApOw0KPj4gK30NCj4+
IGRpZmYgLS1naXQgYS9ody92ZmlvL3BjaS5jIGIvaHcvdmZpby9wY2kuYw0KPj4gaW5kZXggYTIw
NWM2YjExMy4uMzRmNjVlY2QxNyAxMDA2NDQNCj4+IC0tLSBhL2h3L3ZmaW8vcGNpLmMNCj4+ICsr
KyBiL2h3L3ZmaW8vcGNpLmMNCj4+IEBAIC0yODI4LDEwICsyODI4LDEwIEBAIHN0YXRpYyB2b2lk
IHZmaW9fcG9wdWxhdGVfZGV2aWNlKFZGSU9QQ0lEZXZpY2UNCj4qdmRldiwgRXJyb3IgKiplcnJw
KQ0KPj4NCj4+ICAgc3RhdGljIHZvaWQgdmZpb19wdXRfZGV2aWNlKFZGSU9QQ0lEZXZpY2UgKnZk
ZXYpDQo+PiAgIHsNCj4+ICsgICAgdmZpb19kZXRhY2hfZGV2aWNlKCZ2ZGV2LT52YmFzZWRldik7
DQo+PiArDQo+PiAgICAgICBnX2ZyZWUodmRldi0+dmJhc2VkZXYubmFtZSk7DQo+PiAgICAgICBn
X2ZyZWUodmRldi0+bXNpeCk7DQo+PiAtDQo+PiAtICAgIHZmaW9fcHV0X2Jhc2VfZGV2aWNlKCZ2
ZGV2LT52YmFzZWRldik7DQo+PiAgIH0NCj4+DQo+PiAgIHN0YXRpYyB2b2lkIHZmaW9fZXJyX25v
dGlmaWVyX2hhbmRsZXIodm9pZCAqb3BhcXVlKQ0KPj4gQEAgLTI5NzgsMTMgKzI5NzgsOSBAQCBz
dGF0aWMgdm9pZCB2ZmlvX3JlYWxpemUoUENJRGV2aWNlICpwZGV2LCBFcnJvcg0KPioqZXJycCkN
Cj4+ICAgew0KPj4gICAgICAgVkZJT1BDSURldmljZSAqdmRldiA9IFZGSU9fUENJKHBkZXYpOw0K
Pj4gICAgICAgVkZJT0RldmljZSAqdmJhc2VkZXYgPSAmdmRldi0+dmJhc2VkZXY7DQo+PiAtICAg
IFZGSU9EZXZpY2UgKnZiYXNlZGV2X2l0ZXI7DQo+PiAtICAgIFZGSU9Hcm91cCAqZ3JvdXA7DQo+
PiAtICAgIGNoYXIgKnRtcCwgKnN1YnN5cywgZ3JvdXBfcGF0aFtQQVRIX01BWF0sICpncm91cF9u
YW1lOw0KPj4gKyAgICBjaGFyICp0bXAsICpzdWJzeXM7DQo+PiAgICAgICBFcnJvciAqZXJyID0g
TlVMTDsNCj4+IC0gICAgc3NpemVfdCBsZW47DQo+PiAgICAgICBzdHJ1Y3Qgc3RhdCBzdDsNCj4+
IC0gICAgaW50IGdyb3VwaWQ7DQo+PiAgICAgICBpbnQgaSwgcmV0Ow0KPj4gICAgICAgYm9vbCBp
c19tZGV2Ow0KPj4gICAgICAgY2hhciB1dWlkW1VVSURfRk1UX0xFTl07DQo+PiBAQCAtMzAxNSwz
OCArMzAxMSw3IEBAIHN0YXRpYyB2b2lkIHZmaW9fcmVhbGl6ZShQQ0lEZXZpY2UgKnBkZXYsIEVy
cm9yDQo+KiplcnJwKQ0KPj4gICAgICAgdmJhc2VkZXYtPnR5cGUgPSBWRklPX0RFVklDRV9UWVBF
X1BDSTsNCj4+ICAgICAgIHZiYXNlZGV2LT5kZXYgPSBERVZJQ0UodmRldik7DQo+Pg0KPj4gLSAg
ICB0bXAgPSBnX3N0cmR1cF9wcmludGYoIiVzL2lvbW11X2dyb3VwIiwgdmJhc2VkZXYtPnN5c2Zz
ZGV2KTsNCj4+IC0gICAgbGVuID0gcmVhZGxpbmsodG1wLCBncm91cF9wYXRoLCBzaXplb2YoZ3Jv
dXBfcGF0aCkpOw0KPj4gLSAgICBnX2ZyZWUodG1wKTsNCj4+IC0NCj4+IC0gICAgaWYgKGxlbiA8
PSAwIHx8IGxlbiA+PSBzaXplb2YoZ3JvdXBfcGF0aCkpIHsNCj4+IC0gICAgICAgIGVycm9yX3Nl
dGdfZXJybm8oZXJycCwgbGVuIDwgMCA/IGVycm5vIDogRU5BTUVUT09MT05HLA0KPj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAibm8gaW9tbXVfZ3JvdXAgZm91bmQiKTsNCj4+IC0gICAgICAg
IGdvdG8gZXJyb3I7DQo+PiAtICAgIH0NCj4+IC0NCj4+IC0gICAgZ3JvdXBfcGF0aFtsZW5dID0g
MDsNCj4+IC0NCj4+IC0gICAgZ3JvdXBfbmFtZSA9IGJhc2VuYW1lKGdyb3VwX3BhdGgpOw0KPj4g
LSAgICBpZiAoc3NjYW5mKGdyb3VwX25hbWUsICIlZCIsICZncm91cGlkKSAhPSAxKSB7DQo+PiAt
ICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIGVycm5vLCAiZmFpbGVkIHRvIHJlYWQgJXMi
LCBncm91cF9wYXRoKTsNCj4+IC0gICAgICAgIGdvdG8gZXJyb3I7DQo+PiAtICAgIH0NCj4+IC0N
Cj4+IC0gICAgdHJhY2VfdmZpb19yZWFsaXplKHZiYXNlZGV2LT5uYW1lLCBncm91cGlkKTsNCj4+
IC0NCj4+IC0gICAgZ3JvdXAgPSB2ZmlvX2dldF9ncm91cChncm91cGlkLCBwY2lfZGV2aWNlX2lv
bW11X2FkZHJlc3Nfc3BhY2UocGRldiksDQo+ZXJycCk7DQo+PiAtICAgIGlmICghZ3JvdXApIHsN
Cj4+IC0gICAgICAgIGdvdG8gZXJyb3I7DQo+PiAtICAgIH0NCj4+IC0NCj4+IC0gICAgUUxJU1Rf
Rk9SRUFDSCh2YmFzZWRldl9pdGVyLCAmZ3JvdXAtPmRldmljZV9saXN0LCBuZXh0KSB7DQo+PiAt
ICAgICAgICBpZiAoc3RyY21wKHZiYXNlZGV2X2l0ZXItPm5hbWUsIHZiYXNlZGV2LT5uYW1lKSA9
PSAwKSB7DQo+PiAtICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiZGV2aWNlIGlzIGFscmVh
ZHkgYXR0YWNoZWQiKTsNCj4+IC0gICAgICAgICAgICB2ZmlvX3B1dF9ncm91cChncm91cCk7DQo+
PiAtICAgICAgICAgICAgZ290byBlcnJvcjsNCj4+IC0gICAgICAgIH0NCj4+IC0gICAgfQ0KPj4g
KyAgICB0cmFjZV92ZmlvX3JlYWxpemUodmJhc2VkZXYtPm5hbWUpOw0KPg0KPkkgd291bGQgbW92
ZSB0aGUgdHJhY2UgZXZlbnQgYWZ0ZXIgdmZpb19hdHRhY2hfZGV2aWNlKCkgYW5kIHByaW50IG91
dCB0aGUgZ3JvdXAuDQo+T3Igc2ltcGx5IGFkZCB0cmFjZSBldmVudHMgaW4gdmZpb19kZXRhY2gv
YXR0YWNoX2RldmljZSgpLg0KPg0KPlRoaXMgaXMgYSBnZW5lcmFsIGNvbW1lbnQgb24gdGhlIFZG
SU8gUENJIHJvdXRpbmVzIHdoaWNoIGRvIG5vdCB1c2UgYSAndmZpb19wY2knDQo+cHJlZml4IGFu
ZCBJIGZpbmQgaXQgY29uZnVzaW5nLCBzb21ldGltZXMuIExpa2UgdGhpcyBjYWxsIHN0YWNrIDoN
Cj4NCj4gICB2ZmlvX3B1dF9kZXZpY2UoKQ0KPiAgICAgdmZpb19kZXRhY2hfZGV2aWNlKCkNCj4g
ICAgICAgdmZpb19wdXRfYmFzZV9kZXZpY2UoKQ0KPg0KPkkgdGhpbmsgd2Ugc2hvdWxkIHJlbmFt
ZSB2ZmlvX3B1dF9kZXZpY2UoKSBpbiB2ZmlvX3BjaV9wdXRfZGV2aWNlKCkuIFRoaXMgaXMNCj5u
b3QgZm9yIHRoaXMgc2VyaWVzLg0KR29vZCBzdWdnZXN0aW9uISBJIGhhZCBldmVyIGJlZW4gY29u
ZnVzZWQgYnkgdGhpcyBmdW5jdGlvbiB0b28uDQpJIGNhbiBoZWxwIGlmIHlvdSBoYXZlIG5vdCBk
b25lIHRoYXQgeWV0Lg0KDQpUaGFua3MNClpoZW56aG9uZw0K

