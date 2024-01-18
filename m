Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A3E831507
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 09:45:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQO0F-0006fF-1U; Thu, 18 Jan 2024 03:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQO0C-0006eP-9y
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 03:43:56 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQO0A-0000NK-3b
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 03:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705567434; x=1737103434;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=u/9xcI+J0QCB9gOz6QtKuossuMPJNOBXwJ1qBt7J2t8=;
 b=SXnOY7ggnHVr/wzo1tzlJTlIiq4wgs4GIWEdKYHwCCx6F71mng4rcc5A
 HHbdNFtMLNuD1a3PfiWdDnZhHwY7fFnWFyHiL5Q/yRPP6vqoZg97JjU8S
 gdDFcRRqwTZp46CHKH6d7tcETu+zUr5oPQP6inrGyr066lilQTtIaUuTq
 +gKjIST2jKN774RogJqjW/S/IMoix5b4y3IyjBt57S8rLBoELbP95pJ6W
 e1zcwdHyb72PzlOmRvpOtNCNWFWco4wPdztPwr7lDski3xl94ewYl2Xlq
 x2B7lL41Wstoc4kr81UxqKT7YkuM/z2SnYA2PK+LD/jbc30a/lBuX3qB6 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="290542"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="290542"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 00:43:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="261850"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Jan 2024 00:43:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 00:43:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 00:43:49 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 00:43:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akwGn9gYZ7aqNKHqtdPvbtc47SRxHegktZR6gCHg+YapEdA+7KEWMNOz87ufJvpiP5BAexMxTOC2KdVDFhXV0Pv7eObowp/2kSYD7TApg7sNVCcJacMEMpvY9VOOds1u2WwQjj1vlHdE3NTtpaFxMAbVDKFJvgAIBolD9ZZ8pDFt1uaANW4jPLIzvWj63jSkHLyuImURVzzvTFQqLV4DDRA9blX9kXa4p54N5AcXSWotGiz2NTjEw4dIhHCzG8IsXjYiVb9GOTp6p6iLHRJ1Yx3DHOCKDoUxWQICQOJhXSdIvLHAXGdwrz8b5RgGwKnHLGqwS7hJJG8AqsZeGcwtBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/9xcI+J0QCB9gOz6QtKuossuMPJNOBXwJ1qBt7J2t8=;
 b=Kp36QWoZRW+tBRpGraKjC+Dl6dTulj/3p70sXBXfUPTw7I7v69xda4irMdUrFt/QcrqJZ5AmLLse4vNQjECeY0XPPDV38FKM0oUPBB9fgMnum3mOxXwxpONn/FfeBhyLE4pTd6xHxcWeRHZgFLdZtUKeFjDx5Mu3kO/atAo9fPifw0gYAvk9VkCVzgbCEh6gJEog3RYMrUaa1Bk8BQ+hs727WIm29FEP9ixzzX/mQG0/Fmkw/1FxJFQra3vt3rsShVKQ3o9o8TcnUAM773C5b1MCc7DdUo09rwklhwd/8/QIhBw14/aTULvXZPeKfxLxYm8shYQeoudrjyFdmaUukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS7PR11MB6197.namprd11.prod.outlook.com (2603:10b6:8:9b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 08:43:46 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace%5]) with mapi id 15.20.7181.020; Thu, 18 Jan 2024
 08:43:46 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH rfcv1 3/6] intel_iommu: add set/unset_iommu_device callback
Thread-Topic: [PATCH rfcv1 3/6] intel_iommu: add set/unset_iommu_device
 callback
Thread-Index: AQHaR5vxspHwco5YmUmE0e1P7iLakbDeKQiAgAEQanA=
Date: Thu, 18 Jan 2024 08:43:46 +0000
Message-ID: <SJ0PR11MB6744FA461B1033965302689892712@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-4-zhenzhong.duan@intel.com>
 <4db1ddc3-efef-47ff-bc34-4cb3eb3fc5e9@redhat.com>
In-Reply-To: <4db1ddc3-efef-47ff-bc34-4cb3eb3fc5e9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS7PR11MB6197:EE_
x-ms-office365-filtering-correlation-id: e0a1ea3a-aa4d-49a6-ebd6-08dc180195c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Jk41/oOZTXOKNdbiNKgO8bSTFMXaLBOs80drHrMbSr5m/e+1A9LEHs6PeqnWagcIABc8bRoV6qjaZwIwENUnwtfBTP4A2bsn5WnIa5OUzig3cQBevSLcjEGWFnBqk+0oD2NjyHEVk/SYoJN+Vg9m7nCHh99ie5Ky4FpiRSP2usy1XMHd7ecm4CciEVQtVLfRIzkbn3x9qLrFLJhhbeOs/ysVVZvZ4BGPtUhS6f0EEyrd9cAy5uVKCzSyIKiXHG4OREfE5uRwYl5J24OxrwdFZldrfqSyNtFCnY9qt2U/jR3JNOtMFeQXMSY5JboRU3HNMCH+PS2CK+AjybTR5GG1VcngUVpy38r48Bf8eHWSxBHbU0VsV7Fdxwal2FsfQ39v+8BPgPEjhajX9/sd0PcPPNOra0m2fQ0FN8Iid5aNUd8wQfYXbjsIVXifixD9JoYOo3bijl1KOZLvLNkvUDyzAGv6CZSpfzVOZRzBMoP0I+w9o1R1MPvHqlo/lEQW3XeKVKytZ4EiAwmiGYtwq0a0HXzN6f1s/WunB5j/K1CNiyZGEcL2GRmrkYbF/N7H4KjmuJgbwDee9czszOdJRPT45tJlOR138bnlRbYG94Df1w/UOoWHiMoLv5HZkYdw6B3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(66899024)(55016003)(26005)(71200400001)(6506007)(9686003)(7696005)(33656002)(38100700002)(86362001)(38070700009)(82960400001)(2906002)(8936002)(41300700001)(4326008)(8676002)(122000001)(83380400001)(5660300002)(7416002)(52536014)(478600001)(316002)(66556008)(66446008)(76116006)(64756008)(66946007)(110136005)(54906003)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTFyM0NFMmJrQ2UvNHIyMGtMYmhQZFZmd0VtZ1ZPeC9ja1VXSXN1YnFuVFpy?=
 =?utf-8?B?UGg0Sll6cVJ3U1grYWFMUGN1aHgybkJzMldkYU5yMEJGc1Nac00zRHR3UTVB?=
 =?utf-8?B?eVJkcDdVb0pPbkxqaS8yZnhYdXJUckRiWm82TTRTbDNKZmJlME9SSGEzUVd3?=
 =?utf-8?B?ckZXTmp6ZXd0NWlwY014T2EwUjNBTHJtR3FIaVovc1ZmcWJ6bDVNc3N1UzZ5?=
 =?utf-8?B?UUNkTzErWVMybXFkazhXTlF2ZERGNVJnT3lQYnZORzF2SEkzYVU1em5jTkdO?=
 =?utf-8?B?WHBWRTQwTlVzdHZNUE83enBDR0xhOWFQYlBGNU1Nc2F4MFYxOWF5VTBZU200?=
 =?utf-8?B?djBmQ0FuV0prVW1Md0pHZkI1d1JlZzVmcEJnL2thVXl3bDRBblRLZkFwYXZ1?=
 =?utf-8?B?M0I5VENITGRiU0c5R2Q4aGxRRnczWmp2aTJNN1dyb2grN2VhNm9FUTJVVCti?=
 =?utf-8?B?NnNkaDVrMFI3aXdYZkxMdVNUZVNhNURFYnV2QyswejZFUnNPK0hLM0NvNWE4?=
 =?utf-8?B?WXNBV3BFeEFpeDR2ejg2bks0cXU2MS9FQk1WbFVIV2ljeTZBWWR2K3JuaTB6?=
 =?utf-8?B?T09kMThxUXAzanJndXNMYnVaM3VFVThNRGtvUURsRzNDZkVyaU9BU1duZGNw?=
 =?utf-8?B?TVhudHozTjRiSEdZcVZZWHZUSllWSWtTeGY2aS81d2Jlcnc4WFB3UDBpbmxO?=
 =?utf-8?B?ZWFPUk9ySEFWaEYxd3NDM2d3c0QrVWM0M2ZLZjVPVUVKTVM1bUlIWmFXWDFH?=
 =?utf-8?B?eHRkdGZxL0JXNHFDMFhPalRacmxOSUp4S1BWMjd3RUdYUjlSU2R5NUpUNGNN?=
 =?utf-8?B?N2FGZXFlb0pDZDhrYU9RZWhKU2lBUXpyWTZJcFZkSG1zYkxaaUNCVzQ0dWJi?=
 =?utf-8?B?c3NaY0wwNm1LOVRZanY0R0xnSTRjWWtuSWpRZElhTnFVT0tKQW5pM2hlUyt6?=
 =?utf-8?B?VXRZZGhKRE1GdElUY1B6UHBOZjRKcWRLTVlwU09lN2hDVTJJYTg4bGJJT1k5?=
 =?utf-8?B?dFRycm9vRlYwcVJCT2toM0pMa1ZGMDZreHdPOW1Tc1I3ZlpVRG9CUXNWRW1K?=
 =?utf-8?B?R2c0bjJ3TlRaMStqaHA1RTdtWEhnWUU2L0d3bGthclNPSDZSRjUrT1JqTkUx?=
 =?utf-8?B?RnBDc09uTE5wM2V4UmcybldWMnFlTjdxaGFZODVWT3pTVzJacUlmVlFvMkNw?=
 =?utf-8?B?WHlqWVc1V0pqbVhXNkdKRmF6eFJ6aDkwMEZKd1U3SHFqdm1DQmxiaUcwVVpl?=
 =?utf-8?B?ZDFDSVNTU1pXZnlQRXpyd3MyejFMN2RHSXk3ZTMzY2hpbnM1TW5MU01xUDVK?=
 =?utf-8?B?Z21mRzZaRm1HdGszRzdDNTZXYVlnL3RUbjFqb3B5ZGdNUVBRTSt5NytOblha?=
 =?utf-8?B?Z3JPWGt0Rk9pR0twMTdSc2ZDVVh5YjNVUUkyb2VlN2RYV3Y0TkZBYXNLdE5U?=
 =?utf-8?B?bFBYSjBYb0VDbDJSOGQxY0MyY3pqdGxId05hYnF4TjdRQjNzTGVFZXZpRjdQ?=
 =?utf-8?B?eVhNVUZXaGR2cUZWQlVyL3ZUb1V0OEtkeDdsdzEyZVMxOVZkdFhsalY3STF2?=
 =?utf-8?B?elZWVzVROUJpY1JzUzA0eEt5bUJ0NkxNSytPU0pvNGF3azI0SGZvdkdkZ2V4?=
 =?utf-8?B?UnNraGNDakZFbVFFeHN1K1liWDFWU2R0KzZybmQ0cWJmRFZQSWR4dG1NOWpR?=
 =?utf-8?B?V0N1SGpYMzRLbENuWGNDNlo3Tm5Ldm0wZWVCeXZXSkJNQXB4K2VFQnF4emhS?=
 =?utf-8?B?bTQxN0pMaE10ZFJUU25LUEJoNEdQbHpSajkxVVZjZFNRU2k4NVdGbktkblR0?=
 =?utf-8?B?Ry9EWklaYklxdnFVU09DaTNnbFFONit4YWV1ZHdHaHpycFNvUWsrUHRDL2lL?=
 =?utf-8?B?eWZsWlVZTkxUS0lCMTE1bVRqOU1SZENNY2FVSzgveE85Rzh4anFDbGRWUmZ3?=
 =?utf-8?B?WnJ3Q3NOV05WVGVFbC9oUURWbGxjOG16RVIvRnRlMzFnOEZmSEtFS2dYWCtD?=
 =?utf-8?B?bnRGNmlIT2cxcDczUjdLVnR2WVZiSVY4eFFrekJpN3VzSFR4aTlHR0xHRVFw?=
 =?utf-8?B?Qkg3dnRnMHRTamh4RXQ4Q0VzcG5RSDc5WUNrL1ZpWjBoazhNdXMwV2xtOFpB?=
 =?utf-8?Q?mlLnn2xEzIZlS2lzIYyLlYCj6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a1ea3a-aa4d-49a6-ebd6-08dc180195c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 08:43:46.6589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4HEICDiVImkr6QW9trjZ2nP+cqVtoRueGVt1f8Y+lpPLdfuqrk+DLwGOk7jCaSfeUIasbj0ArpUI2iWnxwsZtIh4o1S0XoMhOB+XM/a32Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6197
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YxIDMvNl0gaW50ZWxf
aW9tbXU6IGFkZCBzZXQvdW5zZXRfaW9tbXVfZGV2aWNlDQo+Y2FsbGJhY2sNCj4NCj5IaSBaaGVu
emhvbmcsDQo+DQo+T24gMS8xNS8yNCAxMToxMywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBG
cm9tOiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+DQo+PiBUaGlzIGFkZHMgc2V0L3Vu
c2V0X2lvbW11X2RldmljZSgpIGltcGxlbWVudGF0aW9uIGluIEludGVsIHZJT01NVS4NCj4+IElu
IHNldCBjYWxsLCBJT01NVUZERGV2aWNlIGlzIHJlY29yZGVkIGluIGhhc2ggdGFibGUgaW5kZXhl
ZCBieQ0KPj4gUENJIEJERi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1
QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50
ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFu
QGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oIHwg
MTAgKysrKysNCj4+ICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICB8IDc5DQo+KysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDg5IGlu
c2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lv
bW11LmgNCj5iL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiBpbmRleCA3ZmEwYTY5
NWM4Li5jNjVmZGRlNTZmIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lv
bW11LmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiBAQCAtNjIs
NiArNjIsNyBAQCB0eXBlZGVmIHVuaW9uIFZURF9JUl9UYWJsZUVudHJ5IFZURF9JUl9UYWJsZUVu
dHJ5Ow0KPj4gIHR5cGVkZWYgdW5pb24gVlREX0lSX01TSUFkZHJlc3MgVlREX0lSX01TSUFkZHJl
c3M7DQo+PiAgdHlwZWRlZiBzdHJ1Y3QgVlREUEFTSUREaXJFbnRyeSBWVERQQVNJRERpckVudHJ5
Ow0KPj4gIHR5cGVkZWYgc3RydWN0IFZURFBBU0lERW50cnkgVlREUEFTSURFbnRyeTsNCj4+ICt0
eXBlZGVmIHN0cnVjdCBWVERJT01NVUZERGV2aWNlIFZURElPTU1VRkREZXZpY2U7DQo+Pg0KPj4g
IC8qIENvbnRleHQtRW50cnkgKi8NCj4+ICBzdHJ1Y3QgVlREQ29udGV4dEVudHJ5IHsNCj4+IEBA
IC0xNDgsNiArMTQ5LDEzIEBAIHN0cnVjdCBWVERBZGRyZXNzU3BhY2Ugew0KPj4gICAgICBJT1ZB
VHJlZSAqaW92YV90cmVlOw0KPj4gIH07DQo+Pg0KPj4gK3N0cnVjdCBWVERJT01NVUZERGV2aWNl
IHsNCj4+ICsgICAgUENJQnVzICpidXM7DQo+PiArICAgIHVpbnQ4X3QgZGV2Zm47DQo+PiArICAg
IElPTU1VRkREZXZpY2UgKmlkZXY7DQo+PiArICAgIEludGVsSU9NTVVTdGF0ZSAqaW9tbXVfc3Rh
dGU7DQo+PiArfTsNCj4+ICsNCj5KdXN0IHdvbmRlcmluZyB3aGV0aGVyIHdlIHNob3VsZG4ndCBy
ZXVzZSB0aGUgVlREQWRkcmVzc1NwYWNlIHRvIHN0b3JlDQo+dGhlIGlkZXYsIGlmIGFueS4gSG93
IGhhdmUgeW91IG1hZGUgeW91ciBjaG9pY2UuIFdoYXQgd2lsbCBpdCBiZWNvbWUNCj53aGVuIFBB
U0lEIGdldHMgYWRkZWQ/DQoNClZUREFkZHJlc3NTcGFjZSBpcyBpbmRleGVkIGJ5IGFsaWFzZWQg
QkRGLCBidXQgVlRESU9NTVVGRERldmljZSBpcyBpbmRleGVkDQpieSBkZXZpY2UncyBCREYuIFNv
IHdlIGNhbid0IGp1c3Qgc3RvcmUgVlRESU9NTVVGRERldmljZSBhcyBhIHBvaW50ZXIgaW4NClZU
REFkZHJlc3NTcGFjZSwgbWF5IG5lZWQgYSBsaXN0IGluIGNhc2UgbW9yZSB0aGFuIG9uZSBkZXZp
Y2UgaW4gc2FtZSBhZGRyZXNzDQpzcGFjZS4gVGhlbiBhIGdsb2JhbCBWVERJT01NVUZERGV2aWNl
IGxpc3QgaXMgYmV0dGVyIGZvciBsb29rdXAuDQoNCkZvciBQQVNJRCBpbiBtb2Rlcm4gbW9kZSB3
aGljaCBzdXBwb3J0IHN0YWdlLTEgcGFnZSB0YWJsZSwgd2UgaGF2ZQ0KVlREUEFTSURBZGRyZXNz
U3BhY2UgaW5kZXhlZCBieSBkZXZpY2UncyBCREYrUEFTSUQsIFdlIGRpZG4ndCB1c2UNClZUREFk
ZHJlc3NTcGFjZSB3aGljaCBpcyBmb3Igc3RhZ2UtMiBwYWdlIHRhYmxlLg0KDQpUaGFua3MNClpo
ZW56aG9uZw0KDQo+PiAgc3RydWN0IFZURElPVExCRW50cnkgew0KPj4gICAgICB1aW50NjRfdCBn
Zm47DQo+PiAgICAgIHVpbnQxNl90IGRvbWFpbl9pZDsNCj4+IEBAIC0yOTIsNiArMzAwLDggQEAg
c3RydWN0IEludGVsSU9NTVVTdGF0ZSB7DQo+PiAgICAgIC8qIGxpc3Qgb2YgcmVnaXN0ZXJlZCBu
b3RpZmllcnMgKi8NCj4+ICAgICAgUUxJU1RfSEVBRCgsIFZUREFkZHJlc3NTcGFjZSkgdnRkX2Fz
X3dpdGhfbm90aWZpZXJzOw0KPj4NCj4+ICsgICAgR0hhc2hUYWJsZSAqdnRkX2lvbW11ZmRfZGV2
OyAgICAgICAgICAgICAvKiBWVERJT01NVUZERGV2aWNlICovDQo+PiArDQo+PiAgICAgIC8qIGlu
dGVycnVwdCByZW1hcHBpbmcgKi8NCj4+ICAgICAgYm9vbCBpbnRyX2VuYWJsZWQ7ICAgICAgICAg
ICAgICAvKiBXaGV0aGVyIGd1ZXN0IGVuYWJsZWQgSVIgKi8NCj4+ICAgICAgZG1hX2FkZHJfdCBp
bnRyX3Jvb3Q7ICAgICAgICAgICAvKiBJbnRlcnJ1cHQgcmVtYXBwaW5nIHRhYmxlIHBvaW50ZXIg
Ki8NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVs
X2lvbW11LmMNCj4+IGluZGV4IGVkNTY3N2MwYWUuLjk1ZmFmNjk3ZWIgMTAwNjQ0DQo+PiAtLS0g
YS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0K
Pj4gQEAgLTIzNyw2ICsyMzcsMTMgQEAgc3RhdGljIGdib29sZWFuIHZ0ZF9hc19lcXVhbChnY29u
c3Rwb2ludGVyIHYxLA0KPmdjb25zdHBvaW50ZXIgdjIpDQo+PiAgICAgICAgICAgICAoa2V5MS0+
cGFzaWQgPT0ga2V5Mi0+cGFzaWQpOw0KPj4gIH0NCj4+DQo+PiArc3RhdGljIGdib29sZWFuIHZ0
ZF9hc19pZGV2X2VxdWFsKGdjb25zdHBvaW50ZXIgdjEsIGdjb25zdHBvaW50ZXIgdjIpDQo+PiAr
ew0KPj4gKyAgICBjb25zdCBzdHJ1Y3QgdnRkX2FzX2tleSAqa2V5MSA9IHYxOw0KPj4gKyAgICBj
b25zdCBzdHJ1Y3QgdnRkX2FzX2tleSAqa2V5MiA9IHYyOw0KPj4gKw0KPj4gKyAgICByZXR1cm4g
KGtleTEtPmJ1cyA9PSBrZXkyLT5idXMpICYmIChrZXkxLT5kZXZmbiA9PSBrZXkyLT5kZXZmbik7
DQo+PiArfQ0KPj4gIC8qDQo+PiAgICogTm90ZSB0aGF0IHdlIHVzZSBwb2ludGVyIHRvIFBDSUJ1
cyBhcyB0aGUga2V5LCBzbyBoYXNoaW5nL3NoaWZ0aW5nDQo+PiAgICogYmFzZWQgb24gdGhlIHBv
aW50ZXIgdmFsdWUgaXMgaW50ZW5kZWQuIE5vdGUgdGhhdCB3ZSBkZWFsIHdpdGgNCj4+IEBAIC0z
ODEyLDYgKzM4MTksNzQgQEAgVlREQWRkcmVzc1NwYWNlDQo+KnZ0ZF9maW5kX2FkZF9hcyhJbnRl
bElPTU1VU3RhdGUgKnMsIFBDSUJ1cyAqYnVzLA0KPj4gICAgICByZXR1cm4gdnRkX2Rldl9hczsN
Cj4+ICB9DQo+Pg0KPj4gK3N0YXRpYyBpbnQgdnRkX2Rldl9zZXRfaW9tbXVfZGV2aWNlKFBDSUJ1
cyAqYnVzLCB2b2lkICpvcGFxdWUsDQo+aW50MzJfdCBkZXZmbiwNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBJT01NVUZERGV2aWNlICppZGV2LCBFcnJvciAqKmVycnAp
DQo+PiArew0KPj4gKyAgICBJbnRlbElPTU1VU3RhdGUgKnMgPSBvcGFxdWU7DQo+PiArICAgIFZU
RElPTU1VRkREZXZpY2UgKnZ0ZF9pZGV2Ow0KPj4gKyAgICBzdHJ1Y3QgdnRkX2FzX2tleSBrZXkg
PSB7DQo+PiArICAgICAgICAuYnVzID0gYnVzLA0KPj4gKyAgICAgICAgLmRldmZuID0gZGV2Zm4s
DQo+PiArICAgIH07DQo+PiArICAgIHN0cnVjdCB2dGRfYXNfa2V5ICpuZXdfa2V5Ow0KPj4gKw0K
Pj4gKyAgICBhc3NlcnQoMCA8PSBkZXZmbiAmJiBkZXZmbiA8IFBDSV9ERVZGTl9NQVgpOw0KPj4g
Kw0KPj4gKyAgICAvKiBOb25lIElPTU1VRkQgY2FzZSAqLw0KPj4gKyAgICBpZiAoIWlkZXYpIHsN
Cj4+ICsgICAgICAgIHJldHVybiAwOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIHZ0ZF9pb21t
dV9sb2NrKHMpOw0KPj4gKw0KPj4gKyAgICB2dGRfaWRldiA9IGdfaGFzaF90YWJsZV9sb29rdXAo
cy0+dnRkX2lvbW11ZmRfZGV2LCAma2V5KTsNCj4+ICsNCj4+ICsgICAgaWYgKHZ0ZF9pZGV2KSB7
DQo+PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJJT01NVUZEIGRldmljZSBhbHJlYWR5IGV4
aXN0Iik7DQo+PiArICAgICAgICByZXR1cm4gLTE7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAg
bmV3X2tleSA9IGdfbWFsbG9jKHNpemVvZigqbmV3X2tleSkpOw0KPj4gKyAgICBuZXdfa2V5LT5i
dXMgPSBidXM7DQo+PiArICAgIG5ld19rZXktPmRldmZuID0gZGV2Zm47DQo+PiArDQo+PiArICAg
IHZ0ZF9pZGV2ID0gZ19tYWxsb2MwKHNpemVvZihWVERJT01NVUZERGV2aWNlKSk7DQo+PiArICAg
IHZ0ZF9pZGV2LT5idXMgPSBidXM7DQo+PiArICAgIHZ0ZF9pZGV2LT5kZXZmbiA9ICh1aW50OF90
KWRldmZuOw0KPj4gKyAgICB2dGRfaWRldi0+aW9tbXVfc3RhdGUgPSBzOw0KPj4gKyAgICB2dGRf
aWRldi0+aWRldiA9IGlkZXY7DQo+PiArDQo+PiArICAgIGdfaGFzaF90YWJsZV9pbnNlcnQocy0+
dnRkX2lvbW11ZmRfZGV2LCBuZXdfa2V5LCB2dGRfaWRldik7DQo+PiArDQo+PiArICAgIHZ0ZF9p
b21tdV91bmxvY2socyk7DQo+PiArDQo+PiArICAgIHJldHVybiAwOw0KPj4gK30NCj4+ICsNCj4+
ICtzdGF0aWMgdm9pZCB2dGRfZGV2X3Vuc2V0X2lvbW11X2RldmljZShQQ0lCdXMgKmJ1cywgdm9p
ZCAqb3BhcXVlLA0KPmludDMyX3QgZGV2Zm4pDQo+PiArew0KPj4gKyAgICBJbnRlbElPTU1VU3Rh
dGUgKnMgPSBvcGFxdWU7DQo+PiArICAgIFZURElPTU1VRkREZXZpY2UgKnZ0ZF9pZGV2Ow0KPj4g
KyAgICBzdHJ1Y3QgdnRkX2FzX2tleSBrZXkgPSB7DQo+PiArICAgICAgICAuYnVzID0gYnVzLA0K
Pj4gKyAgICAgICAgLmRldmZuID0gZGV2Zm4sDQo+PiArICAgIH07DQo+PiArDQo+PiArICAgIGFz
c2VydCgwIDw9IGRldmZuICYmIGRldmZuIDwgUENJX0RFVkZOX01BWCk7DQo+PiArDQo+PiArICAg
IHZ0ZF9pb21tdV9sb2NrKHMpOw0KPj4gKw0KPj4gKyAgICB2dGRfaWRldiA9IGdfaGFzaF90YWJs
ZV9sb29rdXAocy0+dnRkX2lvbW11ZmRfZGV2LCAma2V5KTsNCj4+ICsgICAgaWYgKCF2dGRfaWRl
dikgew0KPj4gKyAgICAgICAgdnRkX2lvbW11X3VubG9jayhzKTsNCj4+ICsgICAgICAgIHJldHVy
bjsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBnX2hhc2hfdGFibGVfcmVtb3ZlKHMtPnZ0ZF9p
b21tdWZkX2RldiwgJmtleSk7DQo+PiArDQo+PiArICAgIHZ0ZF9pb21tdV91bmxvY2socyk7DQo+
PiArfQ0KPj4gKw0KPj4gIC8qIFVubWFwIHRoZSB3aG9sZSByYW5nZSBpbiB0aGUgbm90aWZpZXIn
cyBzY29wZS4gKi8NCj4+ICBzdGF0aWMgdm9pZCB2dGRfYWRkcmVzc19zcGFjZV91bm1hcChWVERB
ZGRyZXNzU3BhY2UgKmFzLA0KPklPTU1VTm90aWZpZXIgKm4pDQo+PiAgew0KPj4gQEAgLTQxMDcs
NiArNDE4Miw4IEBAIHN0YXRpYyBBZGRyZXNzU3BhY2UNCj4qdnRkX2hvc3RfZG1hX2lvbW11KFBD
SUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludCBkZXZmbikNCj4+DQo+PiAgc3RhdGljIFBDSUlP
TU1VT3BzIHZ0ZF9pb21tdV9vcHMgPSB7DQo+PiAgICAgIC5nZXRfYWRkcmVzc19zcGFjZSA9IHZ0
ZF9ob3N0X2RtYV9pb21tdSwNCj4+ICsgICAgLnNldF9pb21tdV9kZXZpY2UgPSB2dGRfZGV2X3Nl
dF9pb21tdV9kZXZpY2UsDQo+PiArICAgIC51bnNldF9pb21tdV9kZXZpY2UgPSB2dGRfZGV2X3Vu
c2V0X2lvbW11X2RldmljZSwNCj4+ICB9Ow0KPj4NCj4+ICBzdGF0aWMgYm9vbCB2dGRfZGVjaWRl
X2NvbmZpZyhJbnRlbElPTU1VU3RhdGUgKnMsIEVycm9yICoqZXJycCkNCj4+IEBAIC00MjMwLDYg
KzQzMDcsOCBAQCBzdGF0aWMgdm9pZCB2dGRfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJv
cg0KPioqZXJycCkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ19m
cmVlLCBnX2ZyZWUpOw0KPj4gICAgICBzLT52dGRfYWRkcmVzc19zcGFjZXMgPSBnX2hhc2hfdGFi
bGVfbmV3X2Z1bGwodnRkX2FzX2hhc2gsDQo+dnRkX2FzX2VxdWFsLA0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZ19mcmVlLCBnX2ZyZWUpOw0KPj4gKyAgICBzLT52
dGRfaW9tbXVmZF9kZXYgPSBnX2hhc2hfdGFibGVfbmV3X2Z1bGwodnRkX2FzX2hhc2gsDQo+dnRk
X2FzX2lkZXZfZXF1YWwsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBnX2ZyZWUsIGdfZnJlZSk7DQo+PiAgICAgIHZ0ZF9pbml0KHMpOw0KPj4gICAg
ICBwY2lfc2V0dXBfaW9tbXUoYnVzLCAmdnRkX2lvbW11X29wcywgZGV2KTsNCj4+ICAgICAgLyog
UHNldWRvIGFkZHJlc3Mgc3BhY2UgdW5kZXIgcm9vdCBQQ0kgYnVzLiAqLw0KPlRoYW5rcw0KPg0K
PkVyaWMNCg0K

