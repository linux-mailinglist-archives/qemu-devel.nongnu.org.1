Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABD58324D4
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 08:03:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQisK-0005tV-OP; Fri, 19 Jan 2024 02:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQisI-0005tF-F0; Fri, 19 Jan 2024 02:01:10 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQisD-0005Hi-9j; Fri, 19 Jan 2024 02:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705647665; x=1737183665;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Kc8ut/hXNwtch5MaM+gbSyBueAjnwxt14TOXE5V6fyI=;
 b=IrqosrvIWpuwbpXCJkBTKQ/Cud9oXf54UpPjHq6w2ZhTiYeBnaJSBHvS
 iCGmfTP5X8r/izKAfjjK0ij7inoZWLwjo8mdUBSmGru4VhlGLZT/vOZ0T
 IH683xU+rTpxJSAHrPsXX9Wtet3MyDUjnRYmKsCckj2W6aRTnJ//f0xZE
 7sTIMonGe1FxBl+c+9/3OGJGWpQi175lNHWUSmbLLe/Xepd8ugJOMUTM9
 V7Rgzn10bENEMXh8ptDpnWXjCG11FZ0ETUgSvB49N3IAVx/dgrN4aR8cw
 tdn2DseM1chwcRMmn7Hp5BvnSyBXocjjmEi36wbGS1+X8wejbG/a/eElp w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="578744"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="578744"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 23:01:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="734486395"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; d="scan'208";a="734486395"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Jan 2024 23:01:01 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 23:01:00 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 23:01:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 23:01:00 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 23:00:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHbEV7PWP7ivB2q2OC3h7EDDygyr5IGEwtRltZjTzVxNgz6J7uw9YHPNHfEf1HdmeEOEYNKH2W+fFU5ClXfuP/T8Gx1AHnQtkScMKlSD8bPPkZfGugTcL+Eep3XYdgbfhNtZ7oQy83mccbm+HUZM8FEyLJxne9ffu5x1EMuDFdSgadW1HHIZTlMoFAHO8g33JOXmDjE424X5DNRiJndHN6XLn9meWO0InwBgMrZOQ3uP1tYqWC39CTtdti0GY7neIcobSXHYzTCrwrLHtb9pKPk/BfIpajoD5Fu4GSMBbVMnaRl1Gtd/LdvJKZwH3QVz6/Q9qsvufSo8+tADOUaVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc8ut/hXNwtch5MaM+gbSyBueAjnwxt14TOXE5V6fyI=;
 b=Kt+U7RDwbUBxNgNlZ3DmQ3QgZ3kFpZmn7wIPWaYA1YD9QvTgPDRNQj8o626/2o5U7nLG93IoWq1yUrOW8+8EL8QFXpSVZxy3FjUM4Enrf7znQF1GtBQf4A9IjBKjauc/KklT+Xipjfj/s20upb2koRLI+ip9yIZjvySlxDSaIW2pzaAYOqCg5ZINJuQKtZ0J1aWrBCuFQF9OyaNG9YoHARaQNvr3knUb69nXKtnRuZf4Rc+9v8d0TOm1bCx6RC51TRMG4eGJcHB8ZeIXwjIBABHO2KRRI79eWGSCRNjVd02XgC/prfKApvNwCZ6cEP08+lf3oQGJPqM4WggDmVnUwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB8286.namprd11.prod.outlook.com (2603:10b6:510:1c6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Fri, 19 Jan
 2024 07:00:56 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace%5]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 07:00:56 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>, 
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, "yanghliu@redhat.com" <yanghliu@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "clg@redhat.com" <clg@redhat.com>
Subject: RE: [RFC 4/7] virtio-iommu: Implement PCIIOMMUOps
 set_host_resv_regions
Thread-Topic: [RFC 4/7] virtio-iommu: Implement PCIIOMMUOps
 set_host_resv_regions
Thread-Index: AQHaSRvZODIWGRgczkWQzR/Sdm1iRrDfLnswgABSDgCAATT9wA==
Date: Fri, 19 Jan 2024 07:00:56 +0000
Message-ID: <SJ0PR11MB674415F01D3C4C46A7B6872392702@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240117080414.316890-1-eric.auger@redhat.com>
 <20240117080414.316890-5-eric.auger@redhat.com>
 <SJ0PR11MB67443F1D15B5959A77B60E3F92712@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <307bbfec-005c-4ca8-8c21-cb39f16812f3@redhat.com>
In-Reply-To: <307bbfec-005c-4ca8-8c21-cb39f16812f3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB8286:EE_
x-ms-office365-filtering-correlation-id: 5bd48ebf-5af9-42dd-792c-08dc18bc6240
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qf3dLlMvrYjccRzBeZWaY971dJcgUodXFjNCiBC8bOKX6JWVQFcIMHK6XDKPjOOv01ynU/PJyMz+fiPodKm6SPPJY+s4jJNkM8PhXh1XyZeLLAT97QQ89tY5QCBDDKMJXFwtAqwCBGViuABFk6/562Ei1R+2KnZpDBZ1si/s+9mXKQFZfhtID6V03GXNf+ZkTGJDPqxrvBh3W/T4IoT2udr9fxwlqCFsvgrD3+0eroWqIzc8/fgdnaBuy20aoAYXRzFYBi9F2m2yJhV5Vq74s5HBuJHt9QWsqjj+Tm2+ralfe7YCdSB3XCOX5A72yapFNv1HXCSXDGKGAAWVeYAaMgFLjYxubKBCygHkSVE0uvV4uxERGuZoV6A7C2jlZUMOwnfcMC7b70WK57/KqUGcPEhIiYy08EgA9Q6mFVfUtMsbdV58Z4LcTSQHJCqWheG4Zx5pleYHqh3fPQyq43/hWPUbQ358towevzHSezOMbLNqPNcvjnFICuk3eKhGWD2o1nBF++198TwPziJBRiCErvai7lFsRc4vUtu90whZXO+FWssRoy1iR9rJyF00xKclVQjO6JXYeV3GOXjDaVOIlUN+65UIdAKoVkVQtvoKvRWqOn8t5QyoZjPs3c8jLyftxW2gfXbzA1mZmCNK8/saq0+UBdJBzOcwfyBHDt/3T+I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(83380400001)(55016003)(64756008)(7416002)(33656002)(26005)(86362001)(5660300002)(478600001)(66446008)(54906003)(316002)(66556008)(66476007)(66946007)(9686003)(110136005)(76116006)(6506007)(7696005)(71200400001)(8936002)(8676002)(4326008)(52536014)(38070700009)(122000001)(82960400001)(38100700002)(2906002)(41300700001)(921011)(309714004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RU5LMUdaRWxBWXVncnZPcEl0R2JFVTcwRVZqQWozSUpudVpoRE1BS0F2ZExK?=
 =?utf-8?B?SFZmUFhCQnM2VVlLYTFUbHFYRzhTUjVINGh2VTI1SE5iRkxDell4OGtiU3VH?=
 =?utf-8?B?SUtEY1lSbU9zQ2JDbHpJZlFUN3I2SENobEc4ejVMTjZNSjlSdjhvNG91TTJE?=
 =?utf-8?B?OWc2ejgxb2VQeEsyb2ZwVjgxT0YxNEtDSkhRQnNoVTErV1Bmb1hvM3owVVlt?=
 =?utf-8?B?cnM3eGFpeVdZYk1FbFpPY1dIbk1YeHVEd08rdGI1bFRLMFZid1ZHeEtzZ3Va?=
 =?utf-8?B?Rm5rRExCa2NjdG5BV1V5aktWaUd1MHFEYWJ6UnJPRnpwTVRFcS9XeTczcUVo?=
 =?utf-8?B?K1BHRzlzVjc0MFVOVlpQSjZPUUx2OER4RlFRQS9PWnRwYmpFdmJCcFRYdXg5?=
 =?utf-8?B?bngrRW9WYWR0bnUrTkNreUVCOHM5NXB1Q0pQUkQyYXNtQmJNTVh3Mmt5S3h4?=
 =?utf-8?B?Z0lqTUFhQjlmQmFCSFd0cklDSDhwTk9SUG40cFMzd1hkNkJmeXRIZXprZExL?=
 =?utf-8?B?WlBiWnBlejhYZEhybVFOaGlXZlBCRHN5cXd6LytHeTFrUmFPSHNDdFhsN2lG?=
 =?utf-8?B?OTZxbWlCRzNNZDNQbTZqZjVCai9PYXNWYXovbzdVTlVpNm83ZXlEcW5JdkxC?=
 =?utf-8?B?dFhMVVFhdW9PWERlbzJ2Zk4zcDJhMnM1alFNN2xrRUhzaENveFhFVlI2emNR?=
 =?utf-8?B?ZkNCby9OWjhnNjR5T1M4YWRIdWRqUktRUlJ6dUNvemRweTVVVHUvQ21PdDFO?=
 =?utf-8?B?akQwNFVVamRRZlhMc3pSdnpiY2NQK2QzeEpkMkNJb1FWaXM2V0VNcGRkaE5x?=
 =?utf-8?B?N3k0SXh3bzFZdjliRm9IaDlqRDh0OU1sRElFRFlRbDhFdnJ5Vk1BcWJScjZK?=
 =?utf-8?B?eWgzb3N3bC9ZeEJjMXhDVktDdVhobWtiYUlLQmdFM002VEJKc2ZuYWpnYmF4?=
 =?utf-8?B?aVV0aVROS2VuY282aHI2aWxyUjZPNzE3ZnNuc1cwQ0MrSXJQV1RwRUhoc3Vr?=
 =?utf-8?B?b1NGNnk0OXBGRmZHZW9hbFlhNlRUZnllUCswYnNZZUdkRFhPTlJJV2JNczE3?=
 =?utf-8?B?cmp4ZTluUCt4RDBvNmk0MWtlYkx1bithVXZVQ2diMHY1YUVYSFhsWEZrV2Fw?=
 =?utf-8?B?Mzd6SytCWFZHNVpyaXV4VzV6bFc5cDhjMzg4QkNvWlhuNHRxMGFGY1d1S1cv?=
 =?utf-8?B?RFdpUWVCY3cvWFZIMk8ycGN3NUZxb3E0MmVOejIyb3lGTXp1eUgra1dMblI4?=
 =?utf-8?B?VWF6RU5MYW9mUmhOYjQ2ZloxVjNIU3FZTEU2MFBMMzBkQ1BCN1IwbzNZcXVO?=
 =?utf-8?B?aUpHbVlPdWd6MnJhWStxcGhWSUUvblMwdFloVzJ6cWdjSG9haWk0SFFROGpY?=
 =?utf-8?B?VUxOYXFZdzVaSkpWaEpBZmtLeis2UWxPaW1BWENTa3ZQaEpkQnozTGprajBT?=
 =?utf-8?B?YmtuUmZDL3pBbUUyN1o5VEZkYTVHcjJFUXVneGoyZ296d0JqRlUycXBZWDcz?=
 =?utf-8?B?M1ZrUUJxT0xtNWl1V2psVDZSNjdHMDVJbThtRDVMM0dVMHRuNjdKUE03WDM4?=
 =?utf-8?B?VVM1Sm9mSk8vRWpKTlFXZS8xL1N0UEY3eGJuUFVsN3RkWERrK0diRENzSGph?=
 =?utf-8?B?cXlhNzZOMlNFK2ZtVDhXaHZhSmRQQTVJNUZSSklvNHhYVjFWTkMyMC9VN1dm?=
 =?utf-8?B?UHpUWVVya2JzTEV4WERKS0h1Nnl6VjVpb1dGcWcrNVpWdzNDcjJZelh4VVcx?=
 =?utf-8?B?OVV5SzMxWUd0VDR6R0xoZTZWMUx3aWdLKzkxZ3ZuRFZ6N0RQYnpoM0xhU1Zi?=
 =?utf-8?B?SDM4WHREQ3dpOFo1d0hyWXZGN0hYWEd6cTF6Z01pOWlPL01hQnYzRmFzRlNs?=
 =?utf-8?B?dEYyZ3ZWNGRJU3BrVUVMWGk2UjJjWHZIOWxDbUwrWVRUUGdreVRwR0w5ZmZM?=
 =?utf-8?B?c0RFeE5iVXpOcGd6bkZoWWdlZ0pEUHNPSDM4UlJCWlBEYmZKQVZUYWFycjZD?=
 =?utf-8?B?VktpOHBGT0pVcTVzQ3VVTkpTZ0dEVDc1OURpSSt3Vnd1dkF6aDlqK1RLT0x3?=
 =?utf-8?B?Z1Q3dDBISHlmNDZraDZjN3FsanlUQmR4WjZ3cVJvdHpadGdzZTk0L3BIQnp0?=
 =?utf-8?Q?blDwukbzqji93Iowt4cLSO57t?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd48ebf-5af9-42dd-792c-08dc18bc6240
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 07:00:56.0682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bk38p3Pd2h85ExdA4w8wBKXJf0sTqef/8sBPKM9YZKJwOtzR8GmrSGC4Q071wspg5T5fiEv9kDYWWL3V5QTqOSaUFchxxCHQdSiiSVtkis0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8286
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1JGQyA0LzddIHZpcnRpby1pb21tdTog
SW1wbGVtZW50IFBDSUlPTU1VT3BzDQo+c2V0X2hvc3RfcmVzdl9yZWdpb25zDQo+DQo+SGkgWmhl
bnpob25nLA0KPk9uIDEvMTgvMjQgMDg6NDMsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+IEhp
IEVyaWMsDQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogRXJp
YyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4+IFN1YmplY3Q6IFtSRkMgNC83XSB2
aXJ0aW8taW9tbXU6IEltcGxlbWVudCBQQ0lJT01NVU9wcw0KPj4+IHNldF9ob3N0X3Jlc3ZfcmVn
aW9ucw0KPj4+DQo+Pj4gUmV1c2UgdGhlIGltcGxlbWVudGF0aW9uIG9mIHZpcnRpb19pb21tdV9z
ZXRfaW92YV9yYW5nZXMoKSB3aGljaA0KPj4+IHdpbGwgYmUgcmVtb3ZlZCBpbiBzdWJzZXF1ZW50
IHBhdGNoZXMuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2Vy
QHJlZGhhdC5jb20+DQo+Pj4gLS0tDQo+Pj4gaHcvdmlydGlvL3ZpcnRpby1pb21tdS5jIHwgMTM0
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+LS0tDQo+Pj4gLQ0KPj4+IDEg
ZmlsZSBjaGFuZ2VkLCAxMDEgaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pDQo+Pj4NCj4+
PiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5jIGIvaHcvdmlydGlvL3ZpcnRp
by1pb21tdS5jDQo+Pj4gaW5kZXggOGE0YmQ5MzNjNi4uNzE2YTNmY2ZiZiAxMDA2NDQNCj4+PiAt
LS0gYS9ody92aXJ0aW8vdmlydGlvLWlvbW11LmMNCj4+PiArKysgYi9ody92aXJ0aW8vdmlydGlv
LWlvbW11LmMNCj4+PiBAQCAtNDYxLDggKzQ2MSwxMDkgQEAgc3RhdGljIEFkZHJlc3NTcGFjZQ0K
Pj4+ICp2aXJ0aW9faW9tbXVfZmluZF9hZGRfYXMoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwN
Cj4+PiAgICAgcmV0dXJuICZzZGV2LT5hczsNCj4+PiB9DQo+Pj4NCj4+PiArLyoqDQo+Pj4gKyAq
IHJlYnVpbGRfcmVzdl9yZWdpb25zOiByZWJ1aWxkIHJlc3YgcmVnaW9ucyB3aXRoIGJvdGggdGhl
DQo+Pj4gKyAqIGluZm8gb2YgaG9zdCByZXN2IHJhbmdlcyBhbmQgcHJvcGVydHkgc2V0IHJlc3Yg
cmFuZ2VzDQo+Pj4gKyAqLw0KPj4+ICtzdGF0aWMgaW50IHJlYnVpbGRfcmVzdl9yZWdpb25zKElP
TU1VRGV2aWNlICpzZGV2KQ0KPj4+ICt7DQo+Pj4gKyAgICBHTGlzdCAqbDsNCj4+PiArICAgIGlu
dCBpID0gMDsNCj4+PiArDQo+Pj4gKyAgICAvKiBmcmVlIHRoZSBleGlzdGluZyBsaXN0IGFuZCBy
ZWJ1aWxkIGl0IGZyb20gc2NyYXRjaCAqLw0KPj4+ICsgICAgZ19saXN0X2ZyZWVfZnVsbChzZGV2
LT5yZXN2X3JlZ2lvbnMsIGdfZnJlZSk7DQo+Pj4gKyAgICBzZGV2LT5yZXN2X3JlZ2lvbnMgPSBO
VUxMOw0KPj4+ICsNCj4+PiArICAgIC8qIEZpcnN0IGFkZCBob3N0IHJlc2VydmVkIHJlZ2lvbnMg
aWYgYW55LCBhbGwgdGFnZ2VkIGFzIFJFU0VSVkVEICovDQo+Pj4gKyAgICBmb3IgKGwgPSBzZGV2
LT5ob3N0X3Jlc3ZfcmFuZ2VzOyBsOyBsID0gbC0+bmV4dCkgew0KPj4+ICsgICAgICAgIFJlc2Vy
dmVkUmVnaW9uICpyZWcgPSBnX25ldzAoUmVzZXJ2ZWRSZWdpb24sIDEpOw0KPj4+ICsgICAgICAg
IFJhbmdlICpyID0gKFJhbmdlICopbC0+ZGF0YTsNCj4+PiArDQo+Pj4gKyAgICAgICAgcmVnLT50
eXBlID0gVklSVElPX0lPTU1VX1JFU1ZfTUVNX1RfUkVTRVJWRUQ7DQo+Pj4gKyAgICAgICAgcmFu
Z2Vfc2V0X2JvdW5kcygmcmVnLT5yYW5nZSwgcmFuZ2VfbG9iKHIpLCByYW5nZV91cGIocikpOw0K
Pj4+ICsgICAgICAgIHNkZXYtPnJlc3ZfcmVnaW9ucyA9IHJlc3ZfcmVnaW9uX2xpc3RfaW5zZXJ0
KHNkZXYtPnJlc3ZfcmVnaW9ucywNCj5yZWcpOw0KPj4+ICsgICAgICAgIHRyYWNlX3ZpcnRpb19p
b21tdV9ob3N0X3Jlc3ZfcmVnaW9ucyhzZGV2LQ0KPj4+PiBpb21tdV9tci5wYXJlbnRfb2JqLm5h
bWUsIGksDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJhbmdlX2xvYigmcmVnLT5yYW5nZSksDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJhbmdlX3VwYigmcmVnLT5yYW5nZSkpOw0KPj4+ICsgICAgICAg
IGkrKzsNCj4+PiArICAgIH0NCj4+PiArICAgIC8qDQo+Pj4gKyAgICAgKiB0aGVuIGFkZCBoaWdo
ZXIgcHJpb3JpdHkgcmVzZXJ2ZWQgcmVnaW9ucyBzZXQgYnkgdGhlIG1hY2hpbmUNCj4+PiArICAg
ICAqIHRocm91Z2ggcHJvcGVydGllcw0KPj4+ICsgICAgICovDQo+Pj4gKyAgICBhZGRfcHJvcF9y
ZXN2X3JlZ2lvbnMoc2Rldik7DQo+Pj4gKyAgICByZXR1cm4gMDsNCj4+PiArfQ0KPj4+ICsNCj4+
PiArc3RhdGljIGludCB2aXJ0aW9faW9tbXVfc2V0X2hvc3RfaW92YV9yYW5nZXMoUENJQnVzICpi
dXMsIHZvaWQNCj4qb3BhcXVlLA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpbnQgZGV2Zm4sIEdMaXN0ICppb3ZhX3JhbmdlcywNCj4+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4+
ICt7DQo+Pj4gKyAgICBWaXJ0SU9JT01NVSAqcyA9IG9wYXF1ZTsNCj4+PiArICAgIElPTU1VUGNp
QnVzICpzYnVzID0gZ19oYXNoX3RhYmxlX2xvb2t1cChzLT5hc19ieV9idXNwdHIsIGJ1cyk7DQo+
Pj4gKyAgICBJT01NVURldmljZSAqc2RldjsNCj4+PiArICAgIEdMaXN0ICpjdXJyZW50X3Jhbmdl
czsNCj4+PiArICAgIEdMaXN0ICpsLCAqdG1wLCAqbmV3X3JhbmdlcyA9IE5VTEw7DQo+Pj4gKyAg
ICBpbnQgcmV0ID0gLUVJTlZBTDsNCj4+PiArDQo+Pj4gKyAgICBpZiAoIXNidXMpIHsNCj4+PiAr
ICAgICAgICBlcnJvcl9yZXBvcnQoIiVzIG5vIHNidXMiLCBfX2Z1bmNfXyk7DQo+Pj4gKyAgICB9
DQo+PiBEbyB3ZSBwbGFuIHRvIHN1cHBvcnQgbXVsdGlwbGUgZGV2aWNlcyBpbiBzYW1lIGlvbW11
IGdyb3VwPw0KPj4gYXNfYnlfYnVzcHRyIGlzIGhhc2hlZCBieSBidXMgd2hpY2ggaXMgYW4gYWxp
YXNlZCBidXMgb2YgdGhlIGRldmljZS4NCj4+IFNvIHNidXMgbWF5IGJlIE5VTEwgaWYgZGV2aWNl
J3MgYnVzIGlzIGRpZmZlcmVudCBmcm9tIGFsaWFzZWQgYnVzLg0KPklmIEkgdW5kZXJzdGFuZCB5
b3UgcmVtYXJrIHByb3Blcmx5IHRoaXMgbWVhbnMgdGhhdA0KPg0KPnZpcnRpb19pb21tdV9zZXRf
aG9zdF9pb3ZhX3JhbmdlcyBzaG91bGQgdGFrZSBhcyBhcmcgdGhlIGFsaWFzZWQgYnVzIGFuZA0K
Pm5vdCB0aGUgYnVzLCByaWdodD8NCj5JIHRoaW5rIHdlIHNoYWxsIHN1cHBvcnQgbm9uIHNpbmds
ZXRvbiBncm91cHMgdG9vLg0KDQpOb3QgZXhhY3RseS4gSSB0aGluayB3ZSBzaG91bGQgcGFzcyBk
ZXZpY2UncyByZWFsIEJERiwgbm90IGFsaWFzZWQgQkRGLiBPciBlbHNlDQp3ZSBzZXR1cCByZXNl
cnZlZCByYW5nZXMgb2YgYWxsIGRldmljZXMgaW4gc2FtZSBncm91cCB0byBhbGlhc2VkIEJERi4N
Cg0KSSdtIGp1c3Qgc3VzcGVjdGluZyB0aGF0IHRoZSBoYXNoIGxvb2t1cCB3aXRoIHJlYWwgQkRG
IGluZGV4IHdpbGwgcmV0dXJuIE5VTEwgaWYNCm11bHRpcGxlIGRldmljZXMgYXJlIGluIHNhbWUg
Z3JvdXAuIElmIHRoYXTigJlzIHRydWUsIHRoZW4gaW92YV9yYW5nZXMgaXMgbmV2ZXINCnBhc3Nl
ZCB0byBndWVzdC4NCg0KPg0KPj4NCj4+PiArDQo+Pj4gKyAgICBzZGV2ID0gc2J1cy0+cGJkZXZb
ZGV2Zm5dOw0KPj4+ICsNCj4+PiArICAgIGN1cnJlbnRfcmFuZ2VzID0gc2Rldi0+aG9zdF9yZXN2
X3JhbmdlczsNCj4+PiArDQo+Pj4gKyAgICB3YXJuX3JlcG9ydCgiJXM6IGhvc3RfcmVzdl9yZWdp
b25zPSVkIiwgX19mdW5jX18sICEhc2Rldi0NCj4+Pj4gaG9zdF9yZXN2X3Jhbmdlcyk7DQo+Pj4g
KyAgICAvKiBjaGVjayB0aGF0IGVhY2ggbmV3IHJlc3YgcmVnaW9uIGlzIGluY2x1ZGVkIGluIGFu
IGV4aXN0aW5nIG9uZSAqLw0KPj4+ICsgICAgaWYgKHNkZXYtPmhvc3RfcmVzdl9yYW5nZXMpIHsN
Cj4+IE1heSBiZSB3ZSBjb3VsZCBqdXN0IGVycm9yIG91dCBhcyB2ZmlvX3JlYWxpemUgc2hvdWxk
IG5vdCBjYWxsDQo+PiBzZXRfaG9zdF9pb3ZhX3JhbmdlcygpIHR3aWNlLg0KPnNvIGlmIHdlIGhh
dmUgc2V2ZXJhbCBkZXZpY2VzIGluIHRoZSBncm91cCwNCj4NCj5zZXRfaG9zdF9pb3ZhX3Jhbmdl
cygpDQoNClllcywNCg0KPg0KPsKgbWF5IGJlIGNhbGxlZCBzZXZlcmFsIHRpbWVzLiBSaWdodD8N
Cg0KYnV0IHNob3VsZCBiZSBvbiBkaWZmZXJlbnQgc2RldiBkdWUgdG8gZGlmZmVyZW50IHJlYWwg
QkRGLCBub3Qgb25seSBvbiBhbGlhc2VkIEJERi4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0K
PkVyaWMNCj4+DQo+PiBUaGFua3MNCj4+IFpoZW56aG9uZw0KPj4+ICsgICAgICAgIHJhbmdlX2lu
dmVyc2VfYXJyYXkoaW92YV9yYW5nZXMsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAmbmV3X3JhbmdlcywNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsIFVJTlQ2
NF9NQVgpOw0KPj4+ICsNCj4+PiArICAgICAgICBmb3IgKHRtcCA9IG5ld19yYW5nZXM7IHRtcDsg
dG1wID0gdG1wLT5uZXh0KSB7DQo+Pj4gKyAgICAgICAgICAgIFJhbmdlICpuZXdyID0gKFJhbmdl
ICopdG1wLT5kYXRhOw0KPj4+ICsgICAgICAgICAgICBib29sIGluY2x1ZGVkID0gZmFsc2U7DQo+
Pj4gKw0KPj4+ICsgICAgICAgICAgICBmb3IgKGwgPSBjdXJyZW50X3JhbmdlczsgbDsgbCA9IGwt
Pm5leHQpIHsNCj4+PiArICAgICAgICAgICAgICAgIFJhbmdlICogciA9IChSYW5nZSAqKWwtPmRh
dGE7DQo+Pj4gKw0KPj4+ICsgICAgICAgICAgICAgICAgaWYgKHJhbmdlX2NvbnRhaW5zX3Jhbmdl
KHIsIG5ld3IpKSB7DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgaW5jbHVkZWQgPSB0cnVlOw0K
Pj4+ICsgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPj4+ICsgICAgICAgICAgICAgICAgfQ0K
Pj4+ICsgICAgICAgICAgICB9DQo+Pj4gKyAgICAgICAgICAgIGlmICghaW5jbHVkZWQpIHsNCj4+
PiArICAgICAgICAgICAgICAgIGdvdG8gZXJyb3I7DQo+Pj4gKyAgICAgICAgICAgIH0NCj4+PiAr
ICAgICAgICB9DQo+Pj4gKyAgICAgICAgLyogYWxsIG5ldyByZXNlcnZlZCByYW5nZXMgYXJlIGlu
Y2x1ZGVkIGluIGV4aXN0aW5nIG9uZXMgKi8NCj4+PiArICAgICAgICByZXQgPSAwOw0KPj4+ICsg
ICAgICAgIGdvdG8gb3V0Ow0KPj4+ICsgICAgfQ0KPj4+ICsNCj4+PiArICAgIGlmIChzZGV2LT5w
cm9iZV9kb25lKSB7DQo+Pj4gKyAgICAgICAgd2Fybl9yZXBvcnQoIiVzOiBOb3RpZmllZCBhYm91
dCBuZXcgaG9zdCByZXNlcnZlZCByZWdpb25zIGFmdGVyDQo+Pj4gcHJvYmUiLA0KPj4+ICsgICAg
ICAgICAgICAgICAgICAgIF9fZnVuY19fKTsNCj4+PiArICAgIH0NCj4+PiArDQo+Pj4gKyAgICBy
YW5nZV9pbnZlcnNlX2FycmF5KGlvdmFfcmFuZ2VzLA0KPj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAmc2Rldi0+aG9zdF9yZXN2X3JhbmdlcywNCj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgMCwgVUlOVDY0X01BWCk7DQo+Pj4gKyAgICByZWJ1aWxkX3Jlc3ZfcmVnaW9ucyhzZGV2KTsN
Cj4+PiArDQo+Pj4gKyAgICByZXR1cm4gMDsNCj4+PiArZXJyb3I6DQo+Pj4gKyAgICBlcnJvcl9z
ZXRnKGVycnAsICIlcyBDb25mbGljdGluZyBob3N0IHJlc2VydmVkIHJhbmdlcyBzZXQhIiwNCj4+
PiArICAgICAgICAgICAgICAgX19mdW5jX18pOw0KPj4+ICtvdXQ6DQo+Pj4gKyAgICBnX2xpc3Rf
ZnJlZV9mdWxsKG5ld19yYW5nZXMsIGdfZnJlZSk7DQo+Pj4gKyAgICByZXR1cm4gcmV0Ow0KPj4+
ICt9DQo+Pj4gKw0KPj4+IHN0YXRpYyBjb25zdCBQQ0lJT01NVU9wcyB2aXJ0aW9faW9tbXVfb3Bz
ID0gew0KPj4+ICAgICAuZ2V0X2FkZHJlc3Nfc3BhY2UgPSB2aXJ0aW9faW9tbXVfZmluZF9hZGRf
YXMsDQo+Pj4gKyAgICAuc2V0X2hvc3RfaW92YV9yYW5nZXMgPSB2aXJ0aW9faW9tbXVfc2V0X2hv
c3RfaW92YV9yYW5nZXMsDQo+Pj4gfTsNCj4+Pg0KPj4+IHN0YXRpYyBpbnQgdmlydGlvX2lvbW11
X2F0dGFjaChWaXJ0SU9JT01NVSAqcywNCj4+PiBAQCAtMTE1OCwzOSArMTI1OSw2IEBAIHN0YXRp
YyBpbnQNCj4+PiB2aXJ0aW9faW9tbXVfc2V0X3BhZ2Vfc2l6ZV9tYXNrKElPTU1VTWVtb3J5UmVn
aW9uICptciwNCj4+PiAgICAgcmV0dXJuIDA7DQo+Pj4gfQ0KPj4+DQo+Pj4gLS8qKg0KPj4+IC0g
KiByZWJ1aWxkX3Jlc3ZfcmVnaW9uczogcmVidWlsZCByZXN2IHJlZ2lvbnMgd2l0aCBib3RoIHRo
ZQ0KPj4+IC0gKiBpbmZvIG9mIGhvc3QgcmVzdiByYW5nZXMgYW5kIHByb3BlcnR5IHNldCByZXN2
IHJhbmdlcw0KPj4+IC0gKi8NCj4+PiAtc3RhdGljIGludCByZWJ1aWxkX3Jlc3ZfcmVnaW9ucyhJ
T01NVURldmljZSAqc2RldikNCj4+PiAtew0KPj4+IC0gICAgR0xpc3QgKmw7DQo+Pj4gLSAgICBp
bnQgaSA9IDA7DQo+Pj4gLQ0KPj4+IC0gICAgLyogZnJlZSB0aGUgZXhpc3RpbmcgbGlzdCBhbmQg
cmVidWlsZCBpdCBmcm9tIHNjcmF0Y2ggKi8NCj4+PiAtICAgIGdfbGlzdF9mcmVlX2Z1bGwoc2Rl
di0+cmVzdl9yZWdpb25zLCBnX2ZyZWUpOw0KPj4+IC0gICAgc2Rldi0+cmVzdl9yZWdpb25zID0g
TlVMTDsNCj4+PiAtDQo+Pj4gLSAgICAvKiBGaXJzdCBhZGQgaG9zdCByZXNlcnZlZCByZWdpb25z
IGlmIGFueSwgYWxsIHRhZ2dlZCBhcyBSRVNFUlZFRCAqLw0KPj4+IC0gICAgZm9yIChsID0gc2Rl
di0+aG9zdF9yZXN2X3JhbmdlczsgbDsgbCA9IGwtPm5leHQpIHsNCj4+PiAtICAgICAgICBSZXNl
cnZlZFJlZ2lvbiAqcmVnID0gZ19uZXcwKFJlc2VydmVkUmVnaW9uLCAxKTsNCj4+PiAtICAgICAg
ICBSYW5nZSAqciA9IChSYW5nZSAqKWwtPmRhdGE7DQo+Pj4gLQ0KPj4+IC0gICAgICAgIHJlZy0+
dHlwZSA9IFZJUlRJT19JT01NVV9SRVNWX01FTV9UX1JFU0VSVkVEOw0KPj4+IC0gICAgICAgIHJh
bmdlX3NldF9ib3VuZHMoJnJlZy0+cmFuZ2UsIHJhbmdlX2xvYihyKSwgcmFuZ2VfdXBiKHIpKTsN
Cj4+PiAtICAgICAgICBzZGV2LT5yZXN2X3JlZ2lvbnMgPSByZXN2X3JlZ2lvbl9saXN0X2luc2Vy
dChzZGV2LT5yZXN2X3JlZ2lvbnMsDQo+cmVnKTsNCj4+PiAtICAgICAgICB0cmFjZV92aXJ0aW9f
aW9tbXVfaG9zdF9yZXN2X3JlZ2lvbnMoc2Rldi0NCj4+Pj4gaW9tbXVfbXIucGFyZW50X29iai5u
YW1lLCBpLA0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICByYW5nZV9sb2IoJnJlZy0+cmFuZ2UpLA0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICByYW5nZV91cGIoJnJlZy0+cmFuZ2UpKTsNCj4+PiAtICAgICAg
ICBpKys7DQo+Pj4gLSAgICB9DQo+Pj4gLSAgICAvKg0KPj4+IC0gICAgICogdGhlbiBhZGQgaGln
aGVyIHByaW9yaXR5IHJlc2VydmVkIHJlZ2lvbnMgc2V0IGJ5IHRoZSBtYWNoaW5lDQo+Pj4gLSAg
ICAgKiB0aHJvdWdoIHByb3BlcnRpZXMNCj4+PiAtICAgICAqLw0KPj4+IC0gICAgYWRkX3Byb3Bf
cmVzdl9yZWdpb25zKHNkZXYpOw0KPj4+IC0gICAgcmV0dXJuIDA7DQo+Pj4gLX0NCj4+Pg0KPj4+
IC8qKg0KPj4+ICAqIHZpcnRpb19pb21tdV9zZXRfaW92YV9yYW5nZXM6IENvbnZleXMgdGhlIHVz
YWJsZSBJT1ZBIHJhbmdlcw0KPj4+IC0tDQo+Pj4gMi40MS4wDQoNCg==

