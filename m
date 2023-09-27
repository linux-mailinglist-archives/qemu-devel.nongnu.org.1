Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA2F7B012D
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 12:00:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlRJr-0007Qb-VO; Wed, 27 Sep 2023 05:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlRJq-0007QP-0p
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 05:58:58 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlRJn-0000pi-5D
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 05:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695808735; x=1727344735;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QdG/X4aNr9CMDotS/KmEHvSkHKoEx49Di0r0l9/mbq4=;
 b=QQ1DuY9hA/5gGshZizoJFaGGmMiyr88guOQTQ1pD4HU+cCbmO/a6FE8+
 gX/V0bm3t8Ux5S6ZRTFa8EOY7D4OXrLZCps5ju9buo7GBjZUWrt0PeACj
 A1SnqHG+ZpIWZI/ob8mlZUlM2AVqeEPaDmzWB9XGLacdo402TiGHntCqW
 k5wbmk7bgtPHO345HuNBiTiBF4J2UxHyf514FxjcvKfExDS+hgYWqTWIq
 nILAnSVp2b85du7hyRFUejemstW9zT3IyKOFMmfcNixz/gqQZqWDG/7w5
 KfDRIyDPaxd0pqMc4BJJeE5RsjemF66aXxOKR7XMD6Y+CnZO0Hxh9yMqa g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="361172399"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; d="scan'208";a="361172399"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2023 02:58:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="698799450"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; d="scan'208";a="698799450"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Sep 2023 02:58:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 02:58:50 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 02:58:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 02:58:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 02:58:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+2YWGU8+TQqaBVlPYRqCggwcvXsW0LdmfQxMJ+f+t8X3XZgczJw5pzJreILbb7mpAryqTciW/nX+hixA1mYK7cJIvk5Jub9oWgoMkoh1TgTdZcj463Gm64RC1biSNXdQqnl+18sq0BuIJkeRYWmp+Ew3Nw7c69ty+eTzC6VCeoPz6b6D00OjpTuhUCFI2sXq5YuOj5XlERAZ83Y7SxiLgk108Ql0XTzDzWLokjB6XgGl/BTJYhBGbU5I9LOspbge/OnqU0L6XAU8c3cmNVp5mbzYYiH59NIL7EJ/UVuNpt4GK6en/f4MbYlewtHkVp/12NOmTnLUvI4SXv5XXGBqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdG/X4aNr9CMDotS/KmEHvSkHKoEx49Di0r0l9/mbq4=;
 b=flvnw24WUDySqfn0yWsveoVhfRJkXvrPs3qkYp0BwWRo+yWo8YNTrT7slds9EymDXZ6Qr1gyMJpKGUdSFqRtKcCWtWvIOCvz667JOBHnAWKajSURWp3KxJPWlEunBCK/5rZ1bIVQF0jZb4mhXGJeQr81jC2nUBCbR5pvoH17UzUZirMMNAsykIIGmII/RLQQOtF9J0eb8ZRWq58zhJ0iBbrUW3FMYdK1m49J9uA4x/+IWrVt0Zvzd3NA18OPFvyW6kMs0rajwzfwfp7+xNi/TO/admrEMke/o1+CW1NO3yx0xgJP7av220S0xiHc1TYQLAIY086aehfUr20IzZNqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by SJ0PR11MB5662.namprd11.prod.outlook.com (2603:10b6:a03:3af::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 09:58:48 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24%3]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 09:58:48 +0000
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
Subject: RE: [PATCH v2 06/12] vfio/pci: Introduce vfio_[attach/detach]_device
Thread-Topic: [PATCH v2 06/12] vfio/pci: Introduce vfio_[attach/detach]_device
Thread-Index: AQHZ8G9MBK3w/OsZY02YQxt5EZwDgrAuSYuAgAAlf5A=
Date: Wed, 27 Sep 2023 09:58:48 +0000
Message-ID: <PH7PR11MB67228C4D41CD0DB1E3C9001992C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-7-zhenzhong.duan@intel.com>
 <0c11b6c6-1ae5-c116-7938-0c99ccfc87ae@redhat.com>
In-Reply-To: <0c11b6c6-1ae5-c116-7938-0c99ccfc87ae@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|SJ0PR11MB5662:EE_
x-ms-office365-filtering-correlation-id: d5211e93-a5fa-4dbb-712e-08dbbf405836
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6edTFAOIOI6FkemL1qnOWFvvSwujOL3S4E9tZHSOrQDHhTq2r3x4ng5WOCtkn1mYHXHsYx3ET6QERFXwLKbL+6n52unqOG+b4ZfjyJnNivW0IZVtiBrZI+i0P5AWoFlBpOnNXCIgXq1QmUJ8KSNcJc8QY9Cxbhjz+GzsDdEuW3wF6Slz7ynQbH+D64ZOq0Ul+1Mtykq/7nGlugKTNUYAckmrcK5MiIuV1r+MmXNeR2JwmS9uMy5WdQ2J1FCpXMUYxKw/Penr1E0W3TnorfARK5aWGYYeIToeFjtV3/xuwbtWJ8qa/0dDYwLEwN6Y/AucuMKfYSiG6Icvqxp1YQC5i2OmloPmywwfBU+sGlr3mHUIot7EVnKpU2WnrC34YfmsAT14AB/qGrMaIN7hdgXIZAZ1k4UhWF0/pHlEvmClDzfqBZZB+5J8epRk4sOMU6WQutu1NqKSM/cSPwaspQfH2ODiM3DroYBb8BdIpPFqEU6s2S6t9K6EF8mvqdeH3ZlwCAu1ABVoR3AeUpPxu3Nez1TMKYN+O+nUGM1KraSO4BIzfiGPvOW1F9EIKmI+OtpiUFX7pyYuRspq2X+WPtEU49LOYjk8yYiA4XIRNYkwuA7VPNOWRLoBrdqhD2SrgrJs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(366004)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(2906002)(4326008)(8936002)(52536014)(8676002)(5660300002)(66476007)(54906003)(107886003)(41300700001)(64756008)(316002)(66446008)(76116006)(66946007)(66556008)(110136005)(55016003)(7696005)(6506007)(9686003)(83380400001)(26005)(478600001)(71200400001)(33656002)(122000001)(38100700002)(82960400001)(38070700005)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjU2dGlNYnFNSWxVeEJRQ0JjNFZlN09yUWVBUXdmZEljSHhIRm9Ba3NURkZM?=
 =?utf-8?B?SzR1V0xyKzJWOHZLWUlDY3FITkJBVjlFVHVsdlVyWE9SWVg0WVpyYkgvY01W?=
 =?utf-8?B?YkFDQmNrMGV1NmxLb2hnRGJOK0tJeXQ0VkZYSFcwbENHcUh4WmZJTUNhRk9j?=
 =?utf-8?B?a2xWTHNOdlhIQ3J4MFpMTlZFdjdKRUhUaEZrdlZ2K3pBWWxCKzFKVjJsMFUw?=
 =?utf-8?B?ald3NmlTdEU4OXpKa3ErMkdRbENhZGZUYXpWOGowVFNYNlRxZVB0VHc1WTM0?=
 =?utf-8?B?QjNBM1lXNnZQVUIyNG43YksvaWhqcURDdVhHWlVjeU5mK05oYlh6bDJhT3Jx?=
 =?utf-8?B?TVBKT2NRV3FNL2pGVzlDNldUeGk1bUNpTHlJMlJESzNCbEIvK1ZKL28xUEtY?=
 =?utf-8?B?ODhjL3NiQU92TWk0M1V5U1BSZlFzRk5lTXk4a2Fac2FraEJaSEZJUThPUkFo?=
 =?utf-8?B?VVBsbC9ESnlZVVdOMlV4S1h4M3ZjQktMZVlhem05emxPT2JNdnd3YWdTU2lk?=
 =?utf-8?B?YVZQc3dxc0Y1bk40dmttcjlJeDlFVXYwQWtTY1dZUDJTTm5jWXJscUVnb2V5?=
 =?utf-8?B?Rm9BdjVQb2JTcmtNa3BtUnV4N2luT05jRnM5b3NZNmJTOC9SN3JiajhZTHlo?=
 =?utf-8?B?V05YVXR1VXRKMmRibUs4a0tuOVg4LzVES1IyYXFvZ29jU3pSenhsanVWczBr?=
 =?utf-8?B?S1kzK2ZQK3VpTHFWMzcrVlhDM2Zjb0Q2WGIyRzFNaFhYWDRUejJMbkhuamoy?=
 =?utf-8?B?STBmNkdBTTR5MXJ3Qjh1NnFNdUtmMmJleXM3MEpZOS9lNFE5eHNOT1krZDVt?=
 =?utf-8?B?M2ZGcFB3KzY5OVZNRTZQRjNKaDQ5UEhRWGNlTlJPY0hUeFJUUVIzVG5DckNu?=
 =?utf-8?B?VVA3bElFZHFaQ2dKVDhOYUpVQk9oMkViQVplNTUxeXlNVGlibVJZcFNFMnJK?=
 =?utf-8?B?c1FZZ2NhemlydkNYWVZBNDBVclErUVM4TEdRVXZxdlIweG1kVVlFL0czNnY0?=
 =?utf-8?B?NTRvdTIwZmk1UWVsVXJPOGZqUTd3UzZCNDZjUzd6c09waXRhUUVYZHFodVdE?=
 =?utf-8?B?SDQ0YWUwSnhVOTBreURPbnMyb1NlazFUdDkwZmZLc2FrbGVZdiszdXozNWhi?=
 =?utf-8?B?WXJDaUlEU3ZuZ2EyRnkxK3NKYm41VFFETHptWnBrK0NzMk8weWRxWTNueTNy?=
 =?utf-8?B?TGNpekxuOWF1aHQyMmZRZ0JiOFRsR0FKOEhtYmxsU0hVSlZBLy95WlBUbzJF?=
 =?utf-8?B?SlhtYUpvV2l3YXJPS3VRYkV1am9EL2VhVmdsR3F5UmxPbGZLVlJXNkEyblNh?=
 =?utf-8?B?cENDS3lZcUZUQnp3bXFXRkhmTTJCcmhsQW9XRm5DTjV5UzJNcGh5VTYyeFMy?=
 =?utf-8?B?WlVwa1RhbzZWUWtwNVkxNmRRb1FPOVAxRnlHUnhDY3ZjTU1tZnQxb0svVVdL?=
 =?utf-8?B?V3pMTnlTcjQ0bFpTRGg5TkpIaWhrODF1UUtIZWxSMWNZN25BMExPMm1LVkJJ?=
 =?utf-8?B?ZEJYZnY4ZWQ0QitDczFGbmtuQjFvRGpxTGhTNlFpemJLQ2pVUyt1blVRM2F2?=
 =?utf-8?B?a2dtWENndHRCdlhNM1lCU2xaMUdEL1FLd0Z1NTcwOVg2SEt5VUNQT252MTVj?=
 =?utf-8?B?ZXlrWi81Z1FpdjVJemlZeEhHeXhOVTdPNlBwUVhRa0RYZVlIdVVCVlFVckpV?=
 =?utf-8?B?U1dHdnE2YTkxSng3b3FVaXU3STQ1MnVzOGhWdlc3czAxTXRiSlNWVkcvclFC?=
 =?utf-8?B?V3k4UGFLT1h6bW9YOVZDd1JzWnE4VkNPY3ZrbHpmV2thU2JzSDVZSkFaUjA1?=
 =?utf-8?B?Y0ozS3dlVXJIYnRQZy9FNFE2eFVIMnJlbWtRU0JvUnlLRms3aitzQ2VEZlNY?=
 =?utf-8?B?KzRXWGtTN2tEQkpYMElKRGh5ZG9EZm16ZWVMRkRaRFR5bWxaSGJjRGZtWFQ5?=
 =?utf-8?B?YWVhWFA2b3JBZWRoR0FMeGp3NHUrOHNhSmRyOC84eU0rdWlqRlZwTEh3c0ty?=
 =?utf-8?B?WklaeFVIM21pQmhROGhSN0R1SDhIQVI3SEhTOS9tYVc4WVQvT1djVnRyZG50?=
 =?utf-8?B?MHBHdWtpZU5Bek03Zzc2blcrUlZta2tyR1ZCMElFOTROdGluUWRUUFNCOVRE?=
 =?utf-8?Q?4qx89d3KTt4J//uRcqpq5e7M8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5211e93-a5fa-4dbb-712e-08dbbf405836
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 09:58:48.1413 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FDz21n2KlTBUAy7BizNT3ANUdkBtZqZbqMS7ANhRcrN8fTInqNHEV0NEuPGpAb4LyOJTjSyy4y75qbWIjuLPQJQHVmjOeHBtH2xBDAvIRCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5662
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyNywgMjAyMyAz
OjM2IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MiAwNi8xMl0gdmZpby9wY2k6IEludHJvZHVj
ZSB2ZmlvX1thdHRhY2gvZGV0YWNoXV9kZXZpY2UNCj4NCj5IaSBaaGVuemhvbmcsDQo+DQo+T24g
OS8yNi8yMyAxMzozMiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBGcm9tOiBFcmljIEF1Z2Vy
IDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+Pg0KPj4gV2Ugd2FudCB0aGUgVkZJTyBkZXZpY2Vz
IHRvIGJlIGFibGUgdG8gdXNlIHR3byBkaWZmZXJlbnQNCj4+IElPTU1VIGJhY2tlbmRzLCB0aGUg
bGVnYWN5IFZGSU8gb25lIGFuZCB0aGUgbmV3IGlvbW11ZmQgb25lLg0KPj4NCj4+IEludHJvZHVj
ZSB2ZmlvX1thdHRhY2gvZGV0YWNoXV9kZXZpY2Ugd2hpY2ggYWltIGF0IGhpZGluZyB0aGUNCj4+
IHVuZGVybHlpbmcgSU9NTVUgYmFja2VuZCAoSU9DVExzLCBkYXRhdHlwZXMsIC4uLikuDQo+Pg0K
Pj4gT25jZSB2ZmlvX2F0dGFjaF9kZXZpY2UgY29tcGxldGVzLCB0aGUgZGV2aWNlIGlzIGF0dGFj
aGVkDQo+PiB0byBhIHNlY3VyaXR5IGNvbnRleHQgYW5kIGl0cyBmZCBjYW4gYmUgdXNlZC4gQ29u
dmVyc2VseQ0KPj4gV2hlbiB2ZmlvX2RldGFjaF9kZXZpY2UgY29tcGxldGVzLCB0aGUgZGV2aWNl
IGhhcyBiZWVuDQo+PiBkZXRhY2hlZCBmcm9tIHRoZSBzZWN1cml0eSBjb250ZXh0Lg0KPj4NCj4+
IEF0IHRoZSBtb21lbnQgb25seSB0aGUgaW1wbGVtZW50YXRpb24gYmFzZWQgb24gdGhlIGxlZ2Fj
eQ0KPj4gY29udGFpbmVyL2dyb3VwIGV4aXN0cy4gTGV0J3MgdXNlIGl0IGZyb20gdGhlIHZmaW8t
cGNpIGRldmljZS4NCj4+IFN1YnNlcXVlbnQgcGF0Y2hlcyB3aWxsIGhhbmRsZSBvdGhlciBkZXZp
Y2VzLg0KPg0KPnlvdSBtYXkgYWRkOiBubyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZA0KDQpX
aWxsIGRvLg0KDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckBy
ZWRoYXQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwu
Y29tPg0KPj4gLS0tDQo+PiAgaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggfCAgMyArKw0K
Pj4gIGh3L3ZmaW8vY29tbW9uLmMgICAgICAgICAgICAgIHwgNjggKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4+ICBody92ZmlvL3BjaS5jICAgICAgICAgICAgICAgICB8IDUw
ICsrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAgaHcvdmZpby90cmFjZS1ldmVudHMgICAg
ICAgICAgfCAgMiArLQ0KPj4gIDQgZmlsZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKSwgNDYg
ZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNv
bW1vbi5oIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+IGluZGV4IGM0ZTdjM2I0
YTcuLjEyZmJmYmMzN2QgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21t
b24uaA0KPj4gKysrIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+IEBAIC0yMjUs
NiArMjI1LDkgQEAgdm9pZCB2ZmlvX3B1dF9ncm91cChWRklPR3JvdXAgKmdyb3VwKTsNCj4+ICBz
dHJ1Y3QgdmZpb19kZXZpY2VfaW5mbyAqdmZpb19nZXRfZGV2aWNlX2luZm8oaW50IGZkKTsNCj4+
ICBpbnQgdmZpb19nZXRfZGV2aWNlKFZGSU9Hcm91cCAqZ3JvdXAsIGNvbnN0IGNoYXIgKm5hbWUs
DQo+PiAgICAgICAgICAgICAgICAgICAgICBWRklPRGV2aWNlICp2YmFzZWRldiwgRXJyb3IgKipl
cnJwKTsNCj4+ICtpbnQgdmZpb19hdHRhY2hfZGV2aWNlKGNoYXIgKm5hbWUsIFZGSU9EZXZpY2Ug
KnZiYXNlZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgQWRkcmVzc1NwYWNlICphcywg
RXJyb3IgKiplcnJwKTsNCj4+ICt2b2lkIHZmaW9fZGV0YWNoX2RldmljZShWRklPRGV2aWNlICp2
YmFzZWRldik7DQo+Pg0KPj4gIGludCB2ZmlvX2t2bV9kZXZpY2VfYWRkX2ZkKGludCBmZCwgRXJy
b3IgKiplcnJwKTsNCj4+ICBpbnQgdmZpb19rdm1fZGV2aWNlX2RlbF9mZChpbnQgZmQsIEVycm9y
ICoqZXJycCk7DQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9jb21tb24uYyBiL2h3L3ZmaW8vY29t
bW9uLmMNCj4+IGluZGV4IDk1OWIxMzYyYmIuLjdmMzc5OGIxNTIgMTAwNjQ0DQo+PiAtLS0gYS9o
dy92ZmlvL2NvbW1vbi5jDQo+PiArKysgYi9ody92ZmlvL2NvbW1vbi5jDQo+PiBAQCAtMjYxMSwz
ICsyNjExLDcxIEBAIGludCB2ZmlvX2VlaF9hc19vcChBZGRyZXNzU3BhY2UgKmFzLCB1aW50MzJf
dCBvcCkNCj4+ICAgICAgfQ0KPj4gICAgICByZXR1cm4gdmZpb19lZWhfY29udGFpbmVyX29wKGNv
bnRhaW5lciwgb3ApOw0KPj4gIH0NCj4+ICsNCj4+ICtzdGF0aWMgaW50IHZmaW9fZGV2aWNlX2dy
b3VwaWQoVkZJT0RldmljZSAqdmJhc2VkZXYsIEVycm9yICoqZXJycCkNCj4+ICt7DQo+PiArICAg
IGNoYXIgKnRtcCwgZ3JvdXBfcGF0aFtQQVRIX01BWF0sICpncm91cF9uYW1lOw0KPj4gKyAgICBp
bnQgcmV0LCBncm91cGlkOw0KPj4gKyAgICBzc2l6ZV90IGxlbjsNCj4+ICsNCj4+ICsgICAgdG1w
ID0gZ19zdHJkdXBfcHJpbnRmKCIlcy9pb21tdV9ncm91cCIsIHZiYXNlZGV2LT5zeXNmc2Rldik7
DQo+PiArICAgIGxlbiA9IHJlYWRsaW5rKHRtcCwgZ3JvdXBfcGF0aCwgc2l6ZW9mKGdyb3VwX3Bh
dGgpKTsNCj4+ICsgICAgZ19mcmVlKHRtcCk7DQo+PiArDQo+PiArICAgIGlmIChsZW4gPD0gMCB8
fCBsZW4gPj0gc2l6ZW9mKGdyb3VwX3BhdGgpKSB7DQo+PiArICAgICAgICByZXQgPSBsZW4gPCAw
ID8gLWVycm5vIDogLUVOQU1FVE9PTE9ORzsNCj4+ICsgICAgICAgIGVycm9yX3NldGdfZXJybm8o
ZXJycCwgLXJldCwgIm5vIGlvbW11X2dyb3VwIGZvdW5kIik7DQo+PiArICAgICAgICByZXR1cm4g
cmV0Ow0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGdyb3VwX3BhdGhbbGVuXSA9IDA7DQo+PiAr
DQo+PiArICAgIGdyb3VwX25hbWUgPSBiYXNlbmFtZShncm91cF9wYXRoKTsNCj4+ICsgICAgaWYg
KHNzY2FuZihncm91cF9uYW1lLCAiJWQiLCAmZ3JvdXBpZCkgIT0gMSkgew0KPj4gKyAgICAgICAg
ZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCBlcnJubywgImZhaWxlZCB0byByZWFkICVzIiwgZ3JvdXBf
cGF0aCk7DQo+PiArICAgICAgICByZXR1cm4gLWVycm5vOw0KPj4gKyAgICB9DQo+PiArICAgIHJl
dHVybiBncm91cGlkOw0KPj4gK30NCj4+ICsNCj4+ICtpbnQgdmZpb19hdHRhY2hfZGV2aWNlKGNo
YXIgKm5hbWUsIFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgQWRkcmVzc1NwYWNlICphcywgRXJyb3IgKiplcnJwKQ0KPj4gK3sNCj4+ICsgICAgaW50IGdy
b3VwaWQgPSB2ZmlvX2RldmljZV9ncm91cGlkKHZiYXNlZGV2LCBlcnJwKTsNCj4+ICsgICAgVkZJ
T0RldmljZSAqdmJhc2VkZXZfaXRlcjsNCj4+ICsgICAgVkZJT0dyb3VwICpncm91cDsNCj4+ICsg
ICAgaW50IHJldDsNCj4+ICsNCj4+ICsgICAgaWYgKGdyb3VwaWQgPCAwKSB7DQo+PiArICAgICAg
ICByZXR1cm4gZ3JvdXBpZDsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICB0cmFjZV92ZmlvX2F0
dGFjaF9kZXZpY2UodmJhc2VkZXYtPm5hbWUsIGdyb3VwaWQpOw0KPmh1bSBsb29raW5nIGF0IHRo
YXQgYWdhaW4sIEkgd2FzIGNvbmZ1c2VkIGJ5IHRoZSBmYWN0IHdlIHBhc3NlZCB0aGUgbmFtZQ0K
PmFyZyBpbg0KPg0KPnZmaW9fYXR0YWNoX2RldmljZSgpIHdoZXJlYXMgdmJhc2VkZXYtPm5hbWUg
d2FzIGFscmVhZHkgZmlsbGVkLiBMb29raW5nIGF0IHBjaQ0KPnZmaW9fcmVhbGl6ZSgpDQo+Ym90
aCBhcmUgc29tZXRpbWVzIGRpZmZlcmVudA0KPg0KPiAgICBpZiAoIXFlbXVfdXVpZF9pc19udWxs
KCZ2ZGV2LT52Zl90b2tlbikpIHsNCj4gICAgICAgIHFlbXVfdXVpZF91bnBhcnNlKCZ2ZGV2LT52
Zl90b2tlbiwgdXVpZCk7DQo+ICAgICAgICBuYW1lID0gZ19zdHJkdXBfcHJpbnRmKCIlcyB2Zl90
b2tlbj0lcyIsIHZiYXNlZGV2LT5uYW1lLCB1dWlkKTsNCj4gICAgfSBlbHNlIHsNCj4gICAgICAg
IG5hbWUgPSBnX3N0cmR1cCh2YmFzZWRldi0+bmFtZSk7DQo+ICAgIH0NCj5UaGlzIG1heSBiZSB3
b3J0aCBhIGRvYyBjb21tZW50Lg0KDQpZZXMsIGFncmVlIHRoaXMgaXMgY29uZnVzaW5nLiBKdXN0
IHdhbnQgdG8gYXNrIGFib3V0IHRoZSBkb2MgY29tbWVudD8NClNob3VsZCBJIGNyZWF0ZSBhIHZm
aW8gZG9jIG9yIGp1c3QgYSBzbWFsbCBjb21tZW50IG9uIGNhbGwgc2l0ZSBvZiB2ZmlvX2F0dGFj
aF9kZXZpY2UoKT8NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

