Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 713627ED92B
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 03:16:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Rux-0006DJ-NX; Wed, 15 Nov 2023 21:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3Rus-0006CJ-6g
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 21:15:38 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3Ruq-0001HI-4o
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 21:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700100935; x=1731636935;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=g3/2bq2KYErRTQ95dpLsheP9Blflp+A/DABhZMEKNv8=;
 b=NE/4aDucATwemg21WNrKy3EATdSSatvqhA4oQDhVzryYF+HpwyISxrSF
 LV+S20ifMxhpMUtHuQR5atvtVZztrVhsCxBofQB/uUIs0sI8d1ukHA0GI
 duIy+1BL6T8s6nWLQWfORfDqi2fRDzJKS0yqL3lnIGeApXiRykq5ICzYi
 GNj76XuKHLBkRp2gYNwbsfZCvCS0Nf3OZwNHuW9JyjRchG5Ira1fNmLgM
 CI6L/A1bbhZbLJU+M+BWDATdW7DfF9Z6+IyHQZE+8nNn1Fzjy/P/YIioi
 QeYv0NBZdun+yYHKzYKD/GF3b8vRMBrgNXBiDKqJvWzX2UT/2DvLvpyH2 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="4074525"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="4074525"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 18:15:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="715052383"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; d="scan'208";a="715052383"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Nov 2023 18:15:28 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 18:15:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 18:15:27 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 18:15:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 18:15:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIJBov89mQbMz1NGsb3HeHqKDSeEzD9ngEi9qxZl0oPGNkiH+kYajICGYj2mXV7MzbpflvWN3WdDeqPBhqBX/ZLQOi/6MN7pmXrxQ+hrYFZ14YIAluxLOwyJ6fWEO/xWz7jHDvEAsXI+CV9QL6tq1aqAAcT3+sRkjXCChwjiFTy8qnhf0af5+BYJ4GyX5P3u/WxLFRao5NClYS/9ofXAc8//ueF744UUL4iD+apVDNHKIPnRPu+YM4O49KNKTfY9CYIAN45HQrK+QfOowHcRGEGOxln+lLrazyNzkVyufsGzxebaW2Q9fV3KdJyNL3tp9DKnCjpo6LFqDOhp3lMgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3/2bq2KYErRTQ95dpLsheP9Blflp+A/DABhZMEKNv8=;
 b=GsJ/D2+F5JV7LhI+WllSLxBXOGNsUMOL7jV2lo73ZzXwvQWPPBMF+TfNEL/YCwyCHvWFNB/dIlEE+PHQtd7rncU2AEgWiz/PDS6ywRe7SpVkFyQKj4ljATWstZ1Z5X/lPedL74n4my0Y/g3oQxlHT60VJnID3zOzEMe5quSpawhevY2rrH4Uoz8Fp6o7SlFhFxU0hNGcRfm9Cs3ZNwH6bDxj14veS3/H0XxY/i+Fax2N+jJ1j6XeRZtzGJpmXiUbfJvzxgcIPvJhIkadqM49HJYOYoK7YBQ6z/wdoOK0KmBUGqCk3/69MOTnbTDWfWZICbo8u5A0dLmn1R8gxGikpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7927.namprd11.prod.outlook.com (2603:10b6:8:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 02:15:25 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6977.029; Thu, 16 Nov 2023
 02:15:25 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 11/21] vfio/pci: Make vfio cdev pre-openable by passing
 a file handle
Thread-Topic: [PATCH v6 11/21] vfio/pci: Make vfio cdev pre-openable by
 passing a file handle
Thread-Index: AQHaFuUGAaflN6h7tkiX6y1xaFrADLB7S3IAgAAPiICAANrMAA==
Date: Thu, 16 Nov 2023 02:15:23 +0000
Message-ID: <SJ0PR11MB67444C431A56866888D1621A92B0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-12-zhenzhong.duan@intel.com>
 <b6c6f336-8f56-415a-b6a7-fce19dfd2241@linaro.org>
 <de1bb7bf-64ee-4378-b757-eca7f547b674@redhat.com>
In-Reply-To: <de1bb7bf-64ee-4378-b757-eca7f547b674@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7927:EE_
x-ms-office365-filtering-correlation-id: 40a876e2-8bb6-4eb2-1f87-08dbe649e408
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sRGVnnUHt32mMtixerIvDFUsgJs4mQvKCR8cghgb8zXFjwFG6+GfaMP2uBcPf6SRFBq7Lv/wljUWIKEvJTQybiNb7ru8n3db7JS8HyO+LOqXvKyHXVM13n9Yog2NX08tEjI32cOte13Rm7u16iMeDuOVw2c32YE2Ysef0aVBh+1xkw+H+qhtbrojva6EFiS/Q55VVP/n/A356SjfqmIrObPnbwpGbq0T2oNld32uB1zP81jPySMqIGJZPgO31l3kAAwha3bbHpkA9vHVR6YZk+QZGoZW/JcsEDOtgCr6UezFCji+MZC+RB2KCIqVzqnjx275A6Lf8M9vhZUQcrqs2ZzUs+LLijRT60YdmavFHmKSMCVw6IUWJY4A+i3LC7fliQtt7c9TwIJQlfU62dC9kNtJT1WmhRqw3Spn7t5Mx6Wp5Se376nbSgy2YH45dKlNuNqkXFirmvWIUGP32KfLuFmAThumRzhUCIzxRoA0b0TOnAXdZ1uacXHzZG0RdHnJVXMJxNoXQIK9gUityggYA+0ZpRDGBVU/6jq0Dlm1rYc4Krp7dlEtp/OmIJNkMmENBIBVB0YrJE2KEJjSdYL3Sj+g3V5bsjRvJg5PUWFWAZYZPdGPZ9kQIfGPVtX944rk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(7416002)(5660300002)(8676002)(8936002)(26005)(83380400001)(33656002)(82960400001)(4326008)(122000001)(38100700002)(86362001)(2906002)(55016003)(52536014)(41300700001)(110136005)(9686003)(7696005)(478600001)(53546011)(6506007)(38070700009)(107886003)(66946007)(71200400001)(76116006)(66476007)(64756008)(316002)(54906003)(66556008)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXdhZmV0MmkzQUhHZlBkTnp0UGNTQkZYR1U0TllOOXhJNVkrblRVdkE1NG5w?=
 =?utf-8?B?QUxHckptQmNQR1FqeGg5VllTR0F5MFZaNTQyZkVNR0MzdUdWdFJEUVBISkR0?=
 =?utf-8?B?b1Yva1ZWL2hzSHNaUjFSSzhHWmhZWFo5YloyQzIwdU5La3pyWlRsY0tmSHow?=
 =?utf-8?B?am1kTkN5NEJOMnJqdFlFRy9sTXRlL0hsc1U0VEJKRjZJYWhwYkVKMnljLzkx?=
 =?utf-8?B?ZWQwM2dTQ2RrQlBKQ0tNSzRqUXZEc0Y2MDJVSzIyVGxSVk1Oai8zeXR6bVRS?=
 =?utf-8?B?dEttUmxrRzZ1clJHUmN6OHMzaWJOVFV4THZyVFRkY1VWb3A3bk9QU2gwbEdP?=
 =?utf-8?B?MXRIOXFmb1JsU0p2QjV3N0tsNEMrNHNLQzRTRHlFOE1CVS9QclFEbkF6VWtz?=
 =?utf-8?B?RVMycUtMNGkrQ0VCUEpRTlU5U1g2d2hLa0NyOFgvSGxWSTJNLzlTYmkzeGJS?=
 =?utf-8?B?NlZLUlhFOWZOOGVZdkNhOVhoTEJPMkJYN0pmY1hXZ1l4cjRBclpMeVFhanJ1?=
 =?utf-8?B?T01HMDVzVlczdDJ6L3J4MjQwTktwc3c4NjZlYktOUW00T0FvRGJ5VGFqM1kr?=
 =?utf-8?B?aVQ3WWZKMlRKbHZ1emx3YkRMcmJJRXI4L3FiQllLK0M2NWExc3hhaVh2RUZL?=
 =?utf-8?B?WkVDYW1YYWFUU2VteFdHRWRZQzc0MnhuK0poZkticE9mWllmZWlFM1Zkdi8r?=
 =?utf-8?B?cTBjYm5OV1JoTXo3V1ByY1J1cmo1RVVLSDZNUFpkeWhNMWEwek00TUhFdVps?=
 =?utf-8?B?MytjdEorb1RiTzFuOG9nRklFWmFQNlFZNHcrRVRKOXBxNUhuU1AxRzRpdG0r?=
 =?utf-8?B?Z3drVndUY1NrcG5lbTB4eS93RzYxUkN5RGtzSzJFbEF5bFFiT2l1UlU4czFB?=
 =?utf-8?B?Q0M2SlJLYldMYlNUM1ZOT0dpczB4WE5yVjNxZkN3d0duU1FQV3VzRS9HcWUr?=
 =?utf-8?B?QmFhNSsza0l3amxRR05zeHQ1K0pIUHRNN2VKT0wzejdPeDFQTC9yL0hGKy84?=
 =?utf-8?B?cUFsck5qZmNvd2RMb3VmaWZpZUo0TE9CTjlIWFN1ZnBWTVgxSndsWFpWaEQz?=
 =?utf-8?B?WnNyQy91Y0RLc0k3ZW43R2F5WEMyanVCRk1hVnU5VWZWVWZiM2FLaDNuNE9X?=
 =?utf-8?B?RkozTlBrZDFZOC9GYkt4K0lrY2kweHFVVU1yOGxqanBVbjY5KzVkNXFNVXl5?=
 =?utf-8?B?UGZ1b1VEMTcwZ3VqQWFoV3hhM3NiNWNUcXVkYk0vRXc1aWI3b3VxZnJtMklO?=
 =?utf-8?B?Sks1c2RuYjE1VEtTOGJNNk1rRnpTMGZPbDNpN3lNZU0zNjI5VzZXWDhiV2ow?=
 =?utf-8?B?WUNBRy9DTFBFSE1PMWJMb09MUk9jZEtQeVJlWTJPb0tWWjNsRmI5QmtJZW9r?=
 =?utf-8?B?TFVNVDBjeVVxVWtCamF3UlBjSzZ0TGJyU1JzeEpDaHFMUVFxRG1TbklVS2Ur?=
 =?utf-8?B?VkFUU3d3dE42Yldsa2ZFei9oTjdPTmdYUWxER2ZOOXZRN2k4REdhU0FnR3Yw?=
 =?utf-8?B?OTRhb0ZicDNQb1BKS1VjWmlRb0xYYWFGWXl6WXRieDZtTlVxbTJPK3QzZW9F?=
 =?utf-8?B?Qm9odDY4cFkzNSsvUUhqMHVRMzFrVlR1cUJTcTg3bUkwT2hHb3pVT3N4alpn?=
 =?utf-8?B?R0cyaDJUOHFlVmczcXEyazNTWDVFbThTTFExYllEVGNZTjZhekVoU3BCZDNC?=
 =?utf-8?B?QkVZYTZHUTBFK0pjR1ZoaDk4WitXZ25MZjhBLzZpYnlSUFJkUzVsbldVamtp?=
 =?utf-8?B?YUc1YVdhNmxGbXFIbFoxSXVoeVJYSVF6cEszbjY0OCs0aWJ6YUdWTFpVVktF?=
 =?utf-8?B?cEhyZWovNFAycTQ4bmUzT1VkRDlpeExBQU9vQUlMNzlEZUF4bGEycmphbHJH?=
 =?utf-8?B?SjI1UjdVN2t4bUlUckVlZ2hjMW12cDlqbUMzSkZtZEtZUCt2YUNxM0hZWTRy?=
 =?utf-8?B?aGxEKzlTY1BYeTZjcjFxTzB3VndURlZVZWNhQVFkRGRpdFJ5MXVnMUxFOEVt?=
 =?utf-8?B?YU5yYXRJLzN2SlFTMXNlVU9VZFZCVkJ5VXBFNkF4NEFsS1UyYXNwdjV0ZnFr?=
 =?utf-8?B?dC9oV3RENlh0dWhzQjhkVzMrSjAzUEdGTkVnSmRxQjRwVE9vbXVhY2VEQTZ3?=
 =?utf-8?Q?iMzdao2Ed3M8mlTYQOHHnHcpg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a876e2-8bb6-4eb2-1f87-08dbe649e408
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 02:15:23.5423 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TQmgQT9pekcWQn2Ve8rrXEIUKwgH3BI1Vgp1mmdX/npgSnD+sR9nlSYDb59XQwW+RLp3OyZDgPukW6p4X9wFow5YeTGZCFYvAZWfc97Xd0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7927
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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

SGkgUGhpbGlwcGUsDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRy
aWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIE5vdmVtYmVy
IDE1LCAyMDIzIDk6MDUgUE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDExLzIxXSB2ZmlvL3Bj
aTogTWFrZSB2ZmlvIGNkZXYgcHJlLW9wZW5hYmxlIGJ5IHBhc3NpbmcgYQ0KPmZpbGUgaGFuZGxl
DQo+DQo+T24gMTEvMTUvMjMgMTM6MDksIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0K
Pj4gSGkgWmhlbnpob25nLA0KPj4NCj4+IE9uIDE0LzExLzIzIDExOjA5LCBaaGVuemhvbmcgRHVh
biB3cm90ZToNCj4+PiBUaGlzIGdpdmVzIG1hbmFnZW1lbnQgdG9vbHMgbGlrZSBsaWJ2aXJ0IGEg
Y2hhbmNlIHRvIG9wZW4gdGhlIHZmaW8NCj4+PiBjZGV2IHdpdGggcHJpdmlsZWdlIGFuZCBwYXNz
IEZEIHRvIHFlbXUuIFRoaXMgd2F5IHFlbXUgbmV2ZXIgbmVlZHMNCj4+PiB0byBoYXZlIHByaXZp
bGVnZSB0byBvcGVuIGEgVkZJTyBvciBpb21tdSBjZGV2IG5vZGUuDQo+Pj4NCj4+PiBUb2dldGhl
ciB3aXRoIHRoZSBlYXJsaWVyIHN1cHBvcnQgb2YgcHJlLW9wZW5pbmcgL2Rldi9pb21tdSBkZXZp
Y2UsDQo+Pj4gbm93IHdlIGhhdmUgZnVsbCBzdXBwb3J0IG9mIHBhc3NpbmcgYSB2ZmlvIGRldmlj
ZSB0byB1bnByaXZpbGVnZWQNCj4+PiBxZW11IGJ5IG1hbmFnZW1lbnQgdG9vbC4gVGhpcyBtb2Rl
IGlzIG5vIG1vcmUgY29uc2lkZXJlZCBmb3IgdGhlDQo+Pj4gbGVnYWN5IGJhY2tlbmQuIFNvIGxl
dCdzIHJlbW92ZSB0aGUgIlRPRE8iIGNvbW1lbnQuDQo+Pj4NCj4+PiBBZGQgaGVscGVyIGZ1bmN0
aW9ucyB2ZmlvX2RldmljZV9zZXRfZmQoKSBhbmQgdmZpb19kZXZpY2VfZ2V0X25hbWUoKQ0KPj4+
IHRvIHNldCBmZCBhbmQgZ2V0IGRldmljZSBuYW1lLCB0aGV5IHdpbGwgYWxzbyBiZSB1c2VkIGJ5
IG90aGVyIHZmaW8NCj4+PiBkZXZpY2VzLg0KPj4+DQo+Pj4gVGhlcmUgaXMgbm8gZWFzeSB3YXkg
dG8gY2hlY2sgaWYgYSBkZXZpY2UgaXMgbWRldiB3aXRoIEZEIHBhc3NpbmcsDQo+Pj4gc28gZmFp
bCB0aGUgeC1iYWxsb29uLWFsbG93ZWQgY2hlY2sgdW5jb25kaXRpb25hbGx5IGluIHRoaXMgY2Fz
ZS4NCj4+Pg0KPj4+IFRoZXJlIGlzIGFsc28gbm8gZWFzeSB3YXkgdG8gZ2V0IEJERiBhcyBuYW1l
IHdpdGggRkQgcGFzc2luZywgc28NCj4+PiB3ZSBmYWtlIGEgbmFtZSBieSBWRklPX0ZEW2ZkXS4N
Cj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBp
bnRlbC5jb20+DQo+Pj4gLS0tDQo+Pj4gdjY6IHNpbXBsaWZ5IENPTkZJR19JT01NVUZEIGNoZWNr
aW5nIGNvZGUNCj4+PiDCoMKgwqDCoCBpbnRyb2R1Y2UgYSBoZWxwZXIgdmZpb19kZXZpY2Vfc2V0
X2ZkDQo+Pj4NCj4+PiDCoCBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCB8wqAgMyArKysN
Cj4+PiDCoCBody92ZmlvL2hlbHBlcnMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQ0ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4gwqAgaHcvdmZpby9pb21tdWZk
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMiArKysrKystLS0tDQo+Pj4gwqAgaHcvdmZp
by9wY2kuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjggKysrKysrKysrKysr
LS0tLS0tLS0tLQ0KPj4+IMKgIDQgZmlsZXMgY2hhbmdlZCwgNzEgaW5zZXJ0aW9ucygrKSwgMTYg
ZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8t
Y29tbW9uLmggYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPj4+IGluZGV4IDNkYWM1
YzE2N2UuLjU2N2U1ZjdiZWEgMTAwNjQ0DQo+Pj4gLS0tIGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8t
Y29tbW9uLmgNCj4+PiArKysgYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPj4+IEBA
IC0yNTEsNCArMjUxLDcgQEAgaW50DQo+dmZpb19kZXZpY2VzX3F1ZXJ5X2RpcnR5X2JpdG1hcChW
RklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lciwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBod2Fk
ZHIgc2l6ZSk7DQo+Pj4gwqAgaW50IHZmaW9fZ2V0X2RpcnR5X2JpdG1hcChWRklPQ29udGFpbmVy
QmFzZSAqYmNvbnRhaW5lciwgdWludDY0X3QgaW92YSwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50NjRf
dCBzaXplLCByYW1fYWRkcl90IHJhbV9hZGRyKTsNCj4+PiArDQo+Pg0KPj4gUGxlYXNlIGFkZCBi
YXJlIGRvY3VtZW50YXRpb246DQo+Pg0KPj4gIMKgIC8qIFJldHVybnMgMCBvbiBzdWNjZXNzLCBv
ciBhIG5lZ2F0aXZlIGVycm5vLiAqLw0KPj4NCj4+PiAraW50IHZmaW9fZGV2aWNlX2dldF9uYW1l
KFZGSU9EZXZpY2UgKnZiYXNlZGV2LCBFcnJvciAqKmVycnApOw0KDQpXaWxsIGRvLCBJJ2QgbGlr
ZSB0byB3YWl0IGEgZmV3IGRheXMgdG8gY29sbGVjdCBtb3JlIHN1Z2dlc3RlZCBjaGFuZ2VzIGFu
ZCBSQiwNClRoZW4gc2VuZCBhbGwgdGhlc2UgdXBkYXRlcyB0byBDw6lkcmljIGluIG9uY2UgYmVm
b3JlIGhlIHB1c2hlcyB0aGlzIHNlcmllcyB0byB2ZmlvLW5leHQuDQoNCj4+DQo+PiBGdW5jdGlv
bnMgdGFraW5nIGFuIEVycm9yKiogcGFyYW0gc2hvdWxkIHJldHVybiBhIGJvb2xlYW4sIHNvOg0K
Pj4NCj4+ICDCoCAvKiBSZXR1cm46IHRydWUgb24gc3VjY2VzcywgZWxzZSBmYWxzZSBzZXR0aW5n
IEBlcnJwIHdpdGggZXJyb3IuICovDQo+Pg0KPj4+ICt2b2lkIHZmaW9fZGV2aWNlX3NldF9mZChW
RklPRGV2aWNlICp2YmFzZWRldiwgY29uc3QgY2hhciAqc3RyLCBFcnJvciAqKmVycnApOw0KPj4+
IMKgICNlbmRpZiAvKiBIV19WRklPX1ZGSU9fQ09NTU9OX0ggKi8NCj4+DQo+Pg0KPj4+IEBAIC02
MDksMyArNjExLDQ1IEBAIGJvb2wgdmZpb19oYXNfcmVnaW9uX2NhcChWRklPRGV2aWNlICp2YmFz
ZWRldiwgaW50DQo+cmVnaW9uLCB1aW50MTZfdCBjYXBfdHlwZSkNCj4+PiDCoMKgwqDCoMKgIHJl
dHVybiByZXQ7DQo+Pj4gwqAgfQ0KPj4+ICsNCj4+PiAraW50IHZmaW9fZGV2aWNlX2dldF9uYW1l
KFZGSU9EZXZpY2UgKnZiYXNlZGV2LCBFcnJvciAqKmVycnApDQo+Pj4gK3sNCj4+PiArwqDCoMKg
IHN0cnVjdCBzdGF0IHN0Ow0KPj4+ICsNCj4+PiArwqDCoMKgIGlmICh2YmFzZWRldi0+ZmQgPCAw
KSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChzdGF0KHZiYXNlZGV2LT5zeXNmc2RldiwgJnN0
KSA8IDApIHsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9zZXRnX2Vycm5vKGVy
cnAsIGVycm5vLCAibm8gc3VjaCBob3N0IGRldmljZSIpOw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGVycm9yX3ByZXBlbmQoZXJycCwgVkZJT19NU0dfUFJFRklYLCB2YmFzZWRldi0+c3lz
ZnNkZXYpOw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtZXJybm87DQo+Pj4g
K8KgwqDCoMKgwqDCoMKgIH0NCj4+PiArwqDCoMKgwqDCoMKgwqAgLyogVXNlciBtYXkgc3BlY2lm
eSBhIG5hbWUsIGUuZzogVkZJTyBwbGF0Zm9ybSBkZXZpY2UgKi8NCj4+PiArwqDCoMKgwqDCoMKg
wqAgaWYgKCF2YmFzZWRldi0+bmFtZSkgew0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZi
YXNlZGV2LT5uYW1lID0gZ19wYXRoX2dldF9iYXNlbmFtZSh2YmFzZWRldi0+c3lzZnNkZXYpOw0K
Pj4+ICvCoMKgwqDCoMKgwqDCoCB9DQo+Pj4gK8KgwqDCoCB9IGVsc2Ugew0KPj4+ICvCoMKgwqDC
oMKgwqDCoCBpZiAoIXZiYXNlZGV2LT5pb21tdWZkKSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAiVXNlIEZEIHBhc3Npbmcgb25seSB3aXRoIGlvbW11ZmQg
YmFja2VuZCIpOw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOw0K
Pj4+ICvCoMKgwqDCoMKgwqDCoCB9DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qDQo+Pj4gK8KgwqDC
oMKgwqDCoMKgwqAgKiBHaXZlIGEgbmFtZSB3aXRoIGZkIHNvIGFueSBmdW5jdGlvbiBwcmludGlu
ZyBvdXQgdmJhc2VkZXYtPm5hbWUNCj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIHdpbGwgbm90IGJy
ZWFrLg0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgICovDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICgh
dmJhc2VkZXYtPm5hbWUpIHsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2YmFzZWRldi0+
bmFtZSA9IGdfc3RyZHVwX3ByaW50ZigiVkZJT19GRCVkIiwgdmJhc2VkZXYtPmZkKTsNCj4+PiAr
wqDCoMKgwqDCoMKgwqAgfQ0KPj4+ICvCoMKgwqAgfQ0KPj4+ICsNCj4+PiArwqDCoMKgIHJldHVy
biAwOw0KPj4+ICt9DQo+Pj4gKw0KPj4+ICt2b2lkIHZmaW9fZGV2aWNlX3NldF9mZChWRklPRGV2
aWNlICp2YmFzZWRldiwgY29uc3QgY2hhciAqc3RyLCBFcnJvciAqKmVycnApDQo+Pg0KPj4gIMKg
wqAgYm9vbCB2ZmlvX2RldmljZV9zZXRfZmQoLi4uLCBFcnJvciAqKmVycnApDQo+Pg0KPj4+ICt7
DQo+Pj4gK8KgwqDCoCBpbnQgZmQgPSBtb25pdG9yX2ZkX3BhcmFtKG1vbml0b3JfY3VyKCksIHN0
ciwgZXJycCk7DQo+Pj4gKw0KPj4+ICvCoMKgwqAgaWYgKGZkIDwgMCkgew0KPj4+ICvCoMKgwqDC
oMKgwqDCoCBlcnJvcl9wcmVwZW5kKGVycnAsICJDb3VsZCBub3QgcGFyc2UgcmVtb3RlIG9iamVj
dCBmZCAlczoiLCBzdHIpOw0KPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+Pg0KPj4gIMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsNCj4+DQo+Pj4gK8KgwqDCoCB9DQo+Pj4g
K8KgwqDCoCB2YmFzZWRldi0+ZmQgPSBmZDsNCj4+DQo+PiAgwqDCoMKgwqDCoMKgIHJldHVybiB0
cnVlOw0KPg0KPklmIHdlIGhhZCBhIFFPTSBiYXNlIGRldmljZSBvYmplY3QsIHZmaW9fZGV2aWNl
X3NldF9mZCgpIHdvdWxkIGJlIHBhc3NlZA0KPmRpcmVjdGx5IHRvIG9iamVjdF9jbGFzc19wcm9w
ZXJ0eV9hZGRfc3RyKCkgd2hpY2ggZXhwZWN0cyBhIDoNCj4NCj4gICB2b2lkICgqc2V0KShPYmpl
Y3QgKiwgY29uc3QgY2hhciAqLCBFcnJvciAqKikNCj4NCj5JIHRoaW5rIGl0IGlzIGZpbmUgdG8g
a2VlcCBhcyBpdCBpcy4gV2UgbWlnaHQgaGF2ZSBhIFFPTSBiYXNlIGRldmljZSBvYmplY3QNCj5v
bmUgZGF5ICEgTWlub3IgYW55d2F5Lg0KPg0KPlRoYW5rcywNCj4NCj5DLg0KPg0KPg0KPj4NCj4+
PiArfQ0KPj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2lvbW11ZmQuYyBiL2h3L3ZmaW8vaW9tbXVm
ZC5jDQo+Pj4gaW5kZXggM2VlYzQyODE2Mi4uZTA4YTIxNzA1NyAxMDA2NDQNCj4+PiAtLS0gYS9o
dy92ZmlvL2lvbW11ZmQuYw0KPj4+ICsrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+Pj4gQEAgLTMy
NiwxMSArMzI2LDE1IEBAIHN0YXRpYyBpbnQgaW9tbXVmZF9jZGV2X2F0dGFjaChjb25zdCBjaGFy
ICpuYW1lLA0KPlZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4+IMKgwqDCoMKgwqAgdWludDMyX3Qg
aW9hc19pZDsNCj4+PiDCoMKgwqDCoMKgIEVycm9yICplcnIgPSBOVUxMOw0KPj4+IC3CoMKgwqAg
ZGV2ZmQgPSBpb21tdWZkX2NkZXZfZ2V0ZmQodmJhc2VkZXYtPnN5c2ZzZGV2LCBlcnJwKTsNCj4+
PiAtwqDCoMKgIGlmIChkZXZmZCA8IDApIHsNCj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGRl
dmZkOw0KPj4+ICvCoMKgwqAgaWYgKHZiYXNlZGV2LT5mZCA8IDApIHsNCj4+PiArwqDCoMKgwqDC
oMKgwqAgZGV2ZmQgPSBpb21tdWZkX2NkZXZfZ2V0ZmQodmJhc2VkZXYtPnN5c2ZzZGV2LCBlcnJw
KTsNCj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGRldmZkIDwgMCkgew0KPj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiBkZXZmZDsNCj4+PiArwqDCoMKgwqDCoMKgwqAgfQ0KPj4+ICvC
oMKgwqDCoMKgwqDCoCB2YmFzZWRldi0+ZmQgPSBkZXZmZDsNCj4+PiArwqDCoMKgIH0gZWxzZSB7
DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGRldmZkID0gdmJhc2VkZXYtPmZkOw0KPj4+IMKgwqDCoMKg
wqAgfQ0KPj4+IC3CoMKgwqAgdmJhc2VkZXYtPmZkID0gZGV2ZmQ7DQo+Pj4gwqDCoMKgwqDCoCBy
ZXQgPSBpb21tdWZkX2NkZXZfY29ubmVjdF9hbmRfYmluZCh2YmFzZWRldiwgZXJycCk7DQo+Pj4g
wqDCoMKgwqDCoCBpZiAocmV0KSB7DQo+Pj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vcGNpLmMgYi9o
dy92ZmlvL3BjaS5jDQo+Pj4gaW5kZXggYzU5ODRiMDU5OC4uYjIzYjQ5MmNjZSAxMDA2NDQNCj4+
PiAtLS0gYS9ody92ZmlvL3BjaS5jDQo+Pj4gKysrIGIvaHcvdmZpby9wY2kuYw0KPj4+IEBAIC0y
OTQ0LDE3ICsyOTQ0LDE5IEBAIHN0YXRpYyB2b2lkIHZmaW9fcmVhbGl6ZShQQ0lEZXZpY2UgKnBk
ZXYsIEVycm9yDQo+KiplcnJwKQ0KPj4+IMKgwqDCoMKgwqAgVkZJT0RldmljZSAqdmJhc2VkZXYg
PSAmdmRldi0+dmJhc2VkZXY7DQo+Pj4gwqDCoMKgwqDCoCBjaGFyICp0bXAsICpzdWJzeXM7DQo+
Pj4gwqDCoMKgwqDCoCBFcnJvciAqZXJyID0gTlVMTDsNCj4+PiAtwqDCoMKgIHN0cnVjdCBzdGF0
IHN0Ow0KPj4+IMKgwqDCoMKgwqAgaW50IGksIHJldDsNCj4+PiDCoMKgwqDCoMKgIGJvb2wgaXNf
bWRldjsNCj4+PiDCoMKgwqDCoMKgIGNoYXIgdXVpZFtVVUlEX1NUUl9MRU5dOw0KPj4+IMKgwqDC
oMKgwqAgY2hhciAqbmFtZTsNCj4+PiAtwqDCoMKgIGlmICghdmJhc2VkZXYtPnN5c2ZzZGV2KSB7
DQo+Pj4gK8KgwqDCoCBpZiAodmJhc2VkZXYtPmZkIDwgMCAmJiAhdmJhc2VkZXYtPnN5c2ZzZGV2
KSB7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghKH52ZGV2LT5ob3N0LmRvbWFpbiB8fCB+
dmRldi0+aG9zdC5idXMgfHwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfnZk
ZXYtPmhvc3Quc2xvdCB8fCB+dmRldi0+aG9zdC5mdW5jdGlvbikpIHsNCj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9zZXRnKGVycnAsICJObyBwcm92aWRlZCBob3N0IGRldmlj
ZSIpOw0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX2FwcGVuZF9oaW50KGVy
cnAsICJVc2UgLWRldmljZSB2ZmlvLXBjaSxob3N0PUREREQ6QkI6REQuRiAiDQo+Pj4gKyNpZmRl
ZiBDT05GSUdfSU9NTVVGRA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJvciAtZGV2aWNlIHZmaW8tcGNpLGZkPURFVklDRV9G
RCAiDQo+Pj4gKyNlbmRpZg0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJvciAtZGV2aWNlIHZmaW8tcGNpLHN5c2ZzZGV2
PVBBVEhfVE9fREVWSUNFXG4iKTsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm47DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+PiBAQCAtMjk2NCwxMyArMjk2Niw5IEBA
IHN0YXRpYyB2b2lkIHZmaW9fcmVhbGl6ZShQQ0lEZXZpY2UgKnBkZXYsIEVycm9yDQo+KiplcnJw
KQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdmRldi0+aG9zdC5zbG90LCB2ZGV2LT5ob3N0LmZ1bmN0aW9uKTsNCj4+PiDCoMKg
wqDCoMKgIH0NCj4+PiAtwqDCoMKgIGlmIChzdGF0KHZiYXNlZGV2LT5zeXNmc2RldiwgJnN0KSA8
IDApIHsNCj4+PiAtwqDCoMKgwqDCoMKgwqAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCBlcnJubywg
Im5vIHN1Y2ggaG9zdCBkZXZpY2UiKTsNCj4+PiAtwqDCoMKgwqDCoMKgwqAgZXJyb3JfcHJlcGVu
ZChlcnJwLCBWRklPX01TR19QUkVGSVgsIHZiYXNlZGV2LT5zeXNmc2Rldik7DQo+Pj4gK8KgwqDC
oCBpZiAodmZpb19kZXZpY2VfZ2V0X25hbWUodmJhc2VkZXYsIGVycnApKSB7DQo+Pg0KPj4gQ2xl
YXJlciBhczoNCj4+DQo+PiAgwqDCoMKgwqDCoMKgIGlmICh2ZmlvX2RldmljZV9nZXRfbmFtZSh2
YmFzZWRldiwgZXJycCkgPCAwKSB7DQo+Pg0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47
DQo+Pj4gwqDCoMKgwqDCoCB9DQoNCldpbGwgZG8uDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

