Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3073683878D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 07:38:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSAPT-0002tL-OY; Tue, 23 Jan 2024 01:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSAPR-0002nA-9N
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 01:37:21 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSAPO-0007lj-DC
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 01:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705991838; x=1737527838;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wEJ/zDxFWpPxLJ/DXH180sOjlvjlq0DHSXuN1Rf6kk8=;
 b=CK/PT9N9YUyc24N+d7MY0AGN4JwZrcIC4Z3CTU0cmOWTuqrSlRADsNeR
 saqrBMe2ZNFz4myY3RRufH9cnnTW/2m/RezzPJvBdl5sEbUynQ7Yf3zk2
 +D0sDCJ0FTaS3gyoU+4Qk3RqUirb3Dlxr6OjeO0Ib3lA3RTJtlXi8abyI
 kvEM8li+1O7uRHqsuFWv+FFtI1OGAsBj0tdc55afTm8oc598A9SFOOV4i
 GGNB9gQZXyYbxQ7GDs0TlCYZKgONzFeAG6605WR5txU19qmNZaLJkmUeY
 MhHZ+TbLnqC3JBeOl4hvkvTfu+TqRPxPTrbRWVfHLtUyLmCwEDqJsh3uN A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8824529"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="8824529"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2024 22:37:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="735461289"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; d="scan'208";a="735461289"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Jan 2024 22:37:11 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 22:37:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 22:37:10 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 22:37:10 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 22:37:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1ZS4mTqLRih7mJFvw1F3zKjejDkf+CZzFWPdbogdBQ3BwdoUt1ibpybgOCCEqgCUdIGvBeDeNhMDeky0dwIqgLR56xSxzLaq9T2Ijpfb0bR3ET5tC/+m0eRGJV/M8S2D5l9t7k3eQrfTdWxor0g393fSQrWLdV9EH+ioyVh/i148dxZGe7iYnrElvVrTViMCA2Hi1yyHPCjdzcE8iXXdfWh6Ay/QqitgoK+K3Ojw9EuP7iFNnTzLyDOnkXjA0tfy5xYIOR8a93FERxCAT6kpjvUA/YLitPnEXvXxDuaIn/EAOnELlKwbyXjn3lUFfjiHyNRHfIZEj+dug9rNYu8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEJ/zDxFWpPxLJ/DXH180sOjlvjlq0DHSXuN1Rf6kk8=;
 b=DXz6hrZb+bciycE/ZhfA5mvl0SwMuj4eqk6u6hxD1FiXGCdsUg5H6SRFXBpmGqCE+MT8a9gyUGuVKbMV7VGjRLVeNAHNDwCePCukkPUOKB9bGaD3lPeBt9z5Xasrr1XE4KtMJHfsFhUbXQVO6pP+PCNDvyUlEfsOto5W02JbSMtQdCjd5GeKv2gOOQ8Z1ucNYr3e/nDx6EqkLMXh+ud7ZWx/7Zgvus9+H1OdUGkAn6UwLj/pIfTIY/vWciAyUyaTgztsK5CtPWa/T4XkaLWZ44N+O4bQ29QwLBqoc3OJGUART25aEoIXeNamdj5yWGutnkquSeZc7DlN38ysICM7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7649.namprd11.prod.outlook.com (2603:10b6:8:146::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 06:37:03 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3%4]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 06:37:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH rfcv1 2/6] hw/pci: introduce
 pci_device_set/unset_iommu_device()
Thread-Topic: [PATCH rfcv1 2/6] hw/pci: introduce
 pci_device_set/unset_iommu_device()
Thread-Index: AQHaR5vrPb8w/pVxfEGbuNI7QgnDG7DmGFKAgADgPYA=
Date: Tue, 23 Jan 2024 06:37:03 +0000
Message-ID: <SJ0PR11MB6744075B12BE080F9BBEC37792742@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-3-zhenzhong.duan@intel.com>
 <f2ca6b36-922c-42e4-98d6-59616099980a@redhat.com>
In-Reply-To: <f2ca6b36-922c-42e4-98d6-59616099980a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7649:EE_
x-ms-office365-filtering-correlation-id: 62699737-50d9-46ae-c7af-08dc1bddb5f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cL8WcM5ChnCU2Cy1VMv54ArROxFZHF4qPwXcGAOoTUVoPs7E5B5P4KHdjLRJrsvF10nFP9ZAP1gyeRYiQV3wfLHbkyywY1e1sOayPl3GLwzL4oJg33ndLvujyddGDFNMAx9yj96vNQhmqYCNBCZ+Zw6UZvrgF5xsIjZklZhMxGdCzMr5b+vKYHji/Yfse7Dq4IScbEai4/+yFYjyaMaG6tSX1RW3WcUlVdjD44mPzjxwIEfn/zuaMfVXWYDk7QOii23U1oY5jFwiTGnFw/DJty0GBIIXeYOxZd6WxpWOPK/lNg9LhnWSZK0hdyz/YJCFI9TnpOLBE+1ef66V00Tkgo2B/uAOWYKchRQ/rG66nSsXMszBrzXZOX5jiPPxTNTocJkJSBO0MrMOnhVK9RFLWg0AUvuBkPqdjBj/bx5kw7wYODALWQk+AvJC93z6oP+PnVxGI/YZBu+3IlN/dfP5acklwrW3b1esXe5SMBq9rljQkM75a+fvaaZ7rSzxmQfkE26pcgl+BNtSgAkYWn32FySpneU0pI5QTE9cdEy/ZNyDCB6jdXqgOawW+bG+KP695snUIIcadpZJkhfl99P0h8JqF1qC4Y5cGTgcIADdOXP4+E7lVzZtjwT7Z+oL6fQhx9Sm9n+6m3i1B1IRkLZEqQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(396003)(346002)(366004)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38070700009)(55016003)(4326008)(9686003)(6506007)(83380400001)(8936002)(5660300002)(8676002)(316002)(71200400001)(54906003)(7696005)(66476007)(66556008)(66946007)(66446008)(76116006)(64756008)(478600001)(110136005)(26005)(66574015)(52536014)(122000001)(38100700002)(82960400001)(2906002)(7416002)(86362001)(41300700001)(33656002)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFZxTDBxMEFZWk91alZhNjhwbDlSeGFCeWVBVWYwOWZGcHZkSXJ6eXZWUlpI?=
 =?utf-8?B?eHliYmNVc0sxQURUd3AyeFIybnBLV3Bzd0NxaVhJN1RXWjlGLzVvVHBxeWZa?=
 =?utf-8?B?Y2dUVE9TUnY3VjdWMFNaU2s2eFJqblFZNkpSNTdoVkdUaUp6UWw1QUt4bzlO?=
 =?utf-8?B?MlpLeDVkOE5QZmNLOW9nMHhoM1pkcnRRZ0pQcWJHOXZKM1FaTy95eFlNNndZ?=
 =?utf-8?B?czB1UkNJSXFveEQ4UWtHMTg2a1RyL3IxVG9hSDViTWNGOWRsRUlsdzEvV1l4?=
 =?utf-8?B?bmNXaUJ1MU9HY3p4MytGUStaTEtsY0lsY0p3eGt6eHVmOGVLbllWdzhucDNF?=
 =?utf-8?B?aXNCTFhJQXdYR05ZV0FOdmp1dHI4UU55bEtpRUVhT1JrNG01YlRURHE5QVF3?=
 =?utf-8?B?aXM3MUFWOGJQQXVIc3pzRGFvcUJEVVVxOCtONjIyNzFoemRGbnZzcEtSb3p1?=
 =?utf-8?B?bUkvYU16UDh1cFU4cXZmTHYxL1oxZ1V2UXFPQjEremJDeXFhM0l0YjZDdklN?=
 =?utf-8?B?Yzdnc1JXcFdrUURVUEFUL2c2R2tkbTJ0Q01pWWl4V3krSDZyV2tZYTQ4Mmt5?=
 =?utf-8?B?SUd6elFzVEZ1cHYvdk02aElYelVIMHBoMEVwZWNabEkxMVl6SUJudEtFcUEx?=
 =?utf-8?B?dTFXaDJTc2kxbStMQUVKSWQ2bWpIZ0d3OStVUGpNbVVwRXEyZ0thOUYzQit3?=
 =?utf-8?B?TnBZZER5Qmc2Rk9xWStiMGVIZkMvNnZqc3NKQnJQaG94eFpiN05QRHBWZWs4?=
 =?utf-8?B?VlcwelF5QmlXWGJzY3Q2ZzhiZjREUlAyeDA0QUZRZTJKMUZMT3JmcHMvNGxr?=
 =?utf-8?B?T0IvajBCWlVvS3BLSVc2NUI2cEVET2UyZDROeTZpb2s2cW11amFWZGU3VkJL?=
 =?utf-8?B?aWVWejY2MTJFdFZqWGl5S3o4TytiRkZ3VUdCTllYREs3a0JiTHpPOTlJV3V6?=
 =?utf-8?B?Q2NucmJtZkRrYklvQ0MvZUtDd3ZrUVdoTjJPWVdLbEc2M29KUWR2VmJzT2h1?=
 =?utf-8?B?WmtRSFZmNHFiNEFYUTQ0VHhMdmg0VUdpWHhnZWpXSWJsclJ4cVJyOExkMlZa?=
 =?utf-8?B?bnBwVGV5ZFVndHVBZDFmMVRzcWpNQU1XZHFPWTR6cHl5TmpRRWZFK21ndjZz?=
 =?utf-8?B?enlha05DQmQvSnAvYTR1V0hHcnRtQVNQT1p6dlJhZlRMT3VxaDQ3VnJSWnJk?=
 =?utf-8?B?d3RCdkJ3MFpYbEwvMEg2WDdhbmI3NWhwR25BclVOMThUZmN3cVcrSUgzc09N?=
 =?utf-8?B?ZjEvQVdSVmJkbFdremNXUkQ3OHlXNWttTGlZRm4yWXRtYnB0WTdabVkzaEhh?=
 =?utf-8?B?M2Rxcmo5elYwOGpQUW5PMTU3cUZ1RzZ0SGkzQ0U2S1VFWFNiN2VaNmhYS0w5?=
 =?utf-8?B?MnhiS3J3RU9GeERYVmNMcWR4L3pZc3JsbmgvVW96QklzS2lhM3NaZ2tXS0Fz?=
 =?utf-8?B?NnU4bkRBQmJtRnlLYUx0WEMyYUtGQUhLYTBhbWVzWUlCWGRMZ2UrRi9WRUFk?=
 =?utf-8?B?emxNS0E5SW94TFFPOG1BNFc5Y3dZaW9qcFEyMlFRK3lUZkp5aDRwVU5NMlRZ?=
 =?utf-8?B?WWY1L3B6cHJ0eEVPT0NhSk9TaWJQV1lEeGNWTGtCZEhtcG1lbEp4UUlXSzU5?=
 =?utf-8?B?VUo5MjYzM2RlWDJxaFdmSHJNVDVxeWlxVkthZzNZQVlEV0lmVm84QlF0U0do?=
 =?utf-8?B?OE9tQlVQYWRvTmJleU9JaXArQ3VROUlTc3hZcUFid1ZuQS9aejlibEdLeGRT?=
 =?utf-8?B?WnhVWjhaZ3RKeGVyRzZVUG0vWFZTQ0pnL3hIcHc1WEVHSVVCQ3puMXNyTHFS?=
 =?utf-8?B?OTRnOTNNalA3eWdXcUtoL25ob0JpOUVkN1QwRVpDQld6akVQR1o5TjZEbmM1?=
 =?utf-8?B?NXgwM0I3QzhReEVSMW9TSklLOTNzZ0tmVHRmT2ZpVWlFRXBFTXRGS3QyT1ZF?=
 =?utf-8?B?QitGbEFDZXAya2Z1MTVKTUI3N1RwZzhiN00rRDBWdVN3bmpCeHo4SGJhMXY1?=
 =?utf-8?B?dHI4WEdSakdhVzdvSEcrTmRxc0dBNnMzQXJ5WVduYk05Ykp5LzhyMm5GTHE2?=
 =?utf-8?B?ZU1nSGV6anZHNVQ2cVRXNUZwb1d4Ym1jNVcxL2VHWU9JcERRckhPT2x1MFJN?=
 =?utf-8?Q?D5qgnr4USZBNSXcGz8j1xoKmG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62699737-50d9-46ae-c7af-08dc1bddb5f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 06:37:03.3650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0pZ3JQTKrsU2ZYRHXmISjpOgi49XASuh9KC6VN7gnFqDqPJWqsFjvR0un47H80KswAAAypmnw4pm/8UlT7t4ku7qza42mOnijGHK6WbaGoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7649
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YxIDIvNl0gaHcvcGNp
OiBpbnRyb2R1Y2UNCj5wY2lfZGV2aWNlX3NldC91bnNldF9pb21tdV9kZXZpY2UoKQ0KPg0KPk9u
IDEvMTUvMjQgMTE6MTMsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gRnJvbTogWWkgTGl1IDx5
aS5sLmxpdUBpbnRlbC5jb20+DQo+Pg0KPj4gVGhpcyBhZGRzIHBjaV9kZXZpY2Vfc2V0L3Vuc2V0
X2lvbW11X2RldmljZSgpIHRvIHNldC91bnNldA0KPj4gSU9NTVVGRERldmljZSBmb3IgYSBnaXZl
biBQQ0llIGRldmljZS4gQ2FsbGVyIG9mIHNldA0KPj4gc2hvdWxkIGZhaWwgaWYgc2V0IG9wZXJh
dGlvbiBmYWlscy4NCj4+DQo+PiBFeHRyYWN0IG91dCBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNf
ZGV2Zm4oKSB0byBmYWNpbGl0YXRlDQo+PiBpbXBsZW1lbnRhdGlvbiBvZiBwY2lfZGV2aWNlX3Nl
dC91bnNldF9pb21tdV9kZXZpY2UoKS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlp
LmwubGl1QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIFN1biA8eWkueS5zdW5AbGlu
dXguaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0Bu
dmlkaWEuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5k
dWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBpbmNsdWRlL2h3L3BjaS9wY2kuaCB8IDM5ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+PiAgIGh3L3BjaS9wY2kuYyAgICAg
ICAgIHwgNDkNCj4rKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0K
Pj4gICAyIGZpbGVzIGNoYW5nZWQsIDg2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvcGNpL3BjaS5oIGIvaW5jbHVkZS9ody9wY2kv
cGNpLmgNCj4+IGluZGV4IGZhNjMxM2FhYmMuLmE4MTBjMGVjNzQgMTAwNjQ0DQo+PiAtLS0gYS9p
bmNsdWRlL2h3L3BjaS9wY2kuaA0KPj4gKysrIGIvaW5jbHVkZS9ody9wY2kvcGNpLmgNCj4+IEBA
IC03LDYgKzcsOCBAQA0KPj4gICAvKiBQQ0kgaW5jbHVkZXMgbGVnYWN5IElTQSBhY2Nlc3MuICAq
Lw0KPj4gICAjaW5jbHVkZSAiaHcvaXNhL2lzYS5oIg0KPj4NCj4+ICsjaW5jbHVkZSAic3lzZW11
L2lvbW11ZmRfZGV2aWNlLmgiDQo+PiArDQo+PiAgIGV4dGVybiBib29sIHBjaV9hdmFpbGFibGU7
DQo+Pg0KPj4gICAvKiBQQ0kgYnVzICovDQo+PiBAQCAtMzg0LDEwICszODYsNDUgQEAgdHlwZWRl
ZiBzdHJ1Y3QgUENJSU9NTVVPcHMgew0KPj4gICAgICAgICoNCj4+ICAgICAgICAqIEBkZXZmbjog
ZGV2aWNlIGFuZCBmdW5jdGlvbiBudW1iZXINCj4+ICAgICAgICAqLw0KPj4gLSAgIEFkZHJlc3NT
cGFjZSAqICgqZ2V0X2FkZHJlc3Nfc3BhY2UpKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGlu
dA0KPmRldmZuKTsNCj4+ICsgICAgQWRkcmVzc1NwYWNlICogKCpnZXRfYWRkcmVzc19zcGFjZSko
UENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50DQo+ZGV2Zm4pOw0KPj4gKyAgICAvKioNCj4+
ICsgICAgICogQHNldF9pb21tdV9kZXZpY2U6IHNldCBpb21tdWZkIGRldmljZSBmb3IgYSBQQ0kg
ZGV2aWNlIHRvDQo+dklPTU1VDQo+PiArICAgICAqDQo+PiArICAgICAqIE9wdGlvbmFsIGNhbGxi
YWNrLCBpZiBub3QgaW1wbGVtZW50ZWQgaW4gdklPTU1VLCB0aGVuIHZJT01NVQ0KPmNhbid0DQo+
PiArICAgICAqIHV0aWxpemUgaW9tbXVmZCBzcGVjaWZpYyBmZWF0dXJlcy4NCj4+ICsgICAgICoN
Cj4+ICsgICAgICogUmV0dXJuIHRydWUgaWYgaW9tbXVmZCBkZXZpY2UgaXMgYWNjZXB0ZWQsIG9y
IGVsc2UgcmV0dXJuIGZhbHNlIHdpdGgNCj4+ICsgICAgICogZXJycCBzZXQuDQo+PiArICAgICAq
DQo+PiArICAgICAqIEBidXM6IHRoZSAjUENJQnVzIG9mIHRoZSBQQ0kgZGV2aWNlLg0KPj4gKyAg
ICAgKg0KPj4gKyAgICAgKiBAb3BhcXVlOiB0aGUgZGF0YSBwYXNzZWQgdG8gcGNpX3NldHVwX2lv
bW11KCkuDQo+PiArICAgICAqDQo+PiArICAgICAqIEBkZXZmbjogZGV2aWNlIGFuZCBmdW5jdGlv
biBudW1iZXIgb2YgdGhlIFBDSSBkZXZpY2UuDQo+PiArICAgICAqDQo+PiArICAgICAqIEBpZGV2
OiB0aGUgZGF0YSBzdHJ1Y3R1cmUgcmVwcmVzZW50aW5nIGlvbW11ZmQgZGV2aWNlLg0KPj4gKyAg
ICAgKg0KPj4gKyAgICAgKi8NCj4+ICsgICAgaW50ICgqc2V0X2lvbW11X2RldmljZSkoUENJQnVz
ICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50MzJfdCBkZXZmbiwNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgSU9NTVVGRERldmljZSAqaWRldiwgRXJyb3IgKiplcnJwKTsNCj4+ICsgICAg
LyoqDQo+PiArICAgICAqIEB1bnNldF9pb21tdV9kZXZpY2U6IHVuc2V0IGlvbW11ZmQgZGV2aWNl
IGZvciBhIFBDSSBkZXZpY2UgZnJvbQ0KPnZJT01NVQ0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBP
cHRpb25hbCBjYWxsYmFjay4NCj4+ICsgICAgICoNCj4+ICsgICAgICogQGJ1czogdGhlICNQQ0lC
dXMgb2YgdGhlIFBDSSBkZXZpY2UuDQo+PiArICAgICAqDQo+PiArICAgICAqIEBvcGFxdWU6IHRo
ZSBkYXRhIHBhc3NlZCB0byBwY2lfc2V0dXBfaW9tbXUoKS4NCj4+ICsgICAgICoNCj4+ICsgICAg
ICogQGRldmZuOiBkZXZpY2UgYW5kIGZ1bmN0aW9uIG51bWJlciBvZiB0aGUgUENJIGRldmljZS4N
Cj4+ICsgICAgICovDQo+PiArICAgIHZvaWQgKCp1bnNldF9pb21tdV9kZXZpY2UpKFBDSUJ1cyAq
YnVzLCB2b2lkICpvcGFxdWUsIGludDMyX3QNCj5kZXZmbik7DQo+PiAgIH0gUENJSU9NTVVPcHM7
DQo+Pg0KPj4gICBBZGRyZXNzU3BhY2UgKnBjaV9kZXZpY2VfaW9tbXVfYWRkcmVzc19zcGFjZShQ
Q0lEZXZpY2UgKmRldik7DQo+PiAraW50IHBjaV9kZXZpY2Vfc2V0X2lvbW11X2RldmljZShQQ0lE
ZXZpY2UgKmRldiwgSU9NTVVGRERldmljZQ0KPippZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4+ICt2b2lkIHBjaV9kZXZpY2VfdW5zZXRf
aW9tbXVfZGV2aWNlKFBDSURldmljZSAqZGV2KTsNCj4+DQo+PiAgIC8qKg0KPj4gICAgKiBwY2lf
c2V0dXBfaW9tbXU6IEluaXRpYWxpemUgc3BlY2lmaWMgSU9NTVUgaGFuZGxlcnMgZm9yIGEgUENJ
QnVzDQo+PiBkaWZmIC0tZ2l0IGEvaHcvcGNpL3BjaS5jIGIvaHcvcGNpL3BjaS5jDQo+PiBpbmRl
eCA3NjA4MGFmNTgwLi4zODQ4NjYyZjk1IDEwMDY0NA0KPj4gLS0tIGEvaHcvcGNpL3BjaS5jDQo+
PiArKysgYi9ody9wY2kvcGNpLmMNCj4+IEBAIC0yNjcyLDcgKzI2NzIsMTAgQEAgc3RhdGljIHZv
aWQNCj5wY2lfZGV2aWNlX2NsYXNzX2Jhc2VfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIHZvaWQg
KmRhdGEpDQo+PiAgICAgICB9DQo+PiAgIH0NCj4+DQo+PiAtQWRkcmVzc1NwYWNlICpwY2lfZGV2
aWNlX2lvbW11X2FkZHJlc3Nfc3BhY2UoUENJRGV2aWNlICpkZXYpDQo+PiArc3RhdGljIHZvaWQg
cGNpX2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZuKFBDSURldmljZSAqZGV2LA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQQ0lCdXMgKiphbGlhc2VkX3Bi
dXMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBDSUJ1
cyAqKnBpb21tdV9idXMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQ4X3QgKmFsaWFzZWRfcGRldmZuKQ0KPj4gICB7DQo+PiAgICAgICBQQ0lCdXMg
KmJ1cyA9IHBjaV9nZXRfYnVzKGRldik7DQo+PiAgICAgICBQQ0lCdXMgKmlvbW11X2J1cyA9IGJ1
czsNCj4+IEBAIC0yNzE3LDYgKzI3MjAsMTggQEAgQWRkcmVzc1NwYWNlDQo+KnBjaV9kZXZpY2Vf
aW9tbXVfYWRkcmVzc19zcGFjZShQQ0lEZXZpY2UgKmRldikNCj4+DQo+PiAgICAgICAgICAgaW9t
bXVfYnVzID0gcGFyZW50X2J1czsNCj4+ICAgICAgIH0NCj4+ICsgICAgKmFsaWFzZWRfcGJ1cyA9
IGJ1czsNCj4+ICsgICAgKnBpb21tdV9idXMgPSBpb21tdV9idXM7DQo+PiArICAgICphbGlhc2Vk
X3BkZXZmbiA9IGRldmZuOw0KPj4gK30NCj4+ICsNCj4+ICtBZGRyZXNzU3BhY2UgKnBjaV9kZXZp
Y2VfaW9tbXVfYWRkcmVzc19zcGFjZShQQ0lEZXZpY2UgKmRldikNCj4+ICt7DQo+PiArICAgIFBD
SUJ1cyAqYnVzOw0KPj4gKyAgICBQQ0lCdXMgKmlvbW11X2J1czsNCj4+ICsgICAgdWludDhfdCBk
ZXZmbjsNCj4+ICsNCj4+ICsgICAgcGNpX2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZuKGRldiwg
JmJ1cywgJmlvbW11X2J1cywgJmRldmZuKTsNCj4+ICAgICAgIGlmICghcGNpX2J1c19ieXBhc3Nf
aW9tbXUoYnVzKSAmJiBpb21tdV9idXMtPmlvbW11X29wcykgew0KPj4gICAgICAgICAgIHJldHVy
biBpb21tdV9idXMtPmlvbW11X29wcy0+Z2V0X2FkZHJlc3Nfc3BhY2UoYnVzLA0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpb21tdV9idXMtPmlvbW11X29wYXF1ZSwgZGV2
Zm4pOw0KPj4gQEAgLTI3MjQsNiArMjczOSwzOCBAQCBBZGRyZXNzU3BhY2UNCj4qcGNpX2Rldmlj
ZV9pb21tdV9hZGRyZXNzX3NwYWNlKFBDSURldmljZSAqZGV2KQ0KPj4gICAgICAgcmV0dXJuICZh
ZGRyZXNzX3NwYWNlX21lbW9yeTsNCj4+ICAgfQ0KPj4NCj4+ICtpbnQgcGNpX2RldmljZV9zZXRf
aW9tbXVfZGV2aWNlKFBDSURldmljZSAqZGV2LCBJT01NVUZERGV2aWNlDQo+KmlkZXYsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+PiArew0KPj4g
KyAgICBQQ0lCdXMgKmJ1czsNCj4+ICsgICAgUENJQnVzICppb21tdV9idXM7DQo+PiArICAgIHVp
bnQ4X3QgZGV2Zm47DQo+PiArDQo+PiArICAgIHBjaV9kZXZpY2VfZ2V0X2lvbW11X2J1c19kZXZm
bihkZXYsICZidXMsICZpb21tdV9idXMsICZkZXZmbik7DQo+PiArICAgIGlmICghcGNpX2J1c19i
eXBhc3NfaW9tbXUoYnVzKSAmJiBpb21tdV9idXMgJiYNCj4NCj5XaHkgZG8gd2UgdGVzdCBpb21t
dV9idXMgaW4gcGNpX2RldmljZV91bi9zZXRfaW9tbXVfZGV2aWNlIHJvdXRpbmVzDQo+YW5kDQo+
bm90IGluIHBjaV9kZXZpY2VfaW9tbXVfYWRkcmVzc19zcGFjZSgpID8NCg0KaW9tbXVfYnVzIGNo
ZWNrIGluIHBjaV9kZXZpY2VfaW9tbXVfYWRkcmVzc19zcGFjZSgpIGlzIGRyb3BwZWQgaW4NCmJl
bG93IGNvbW1pdCwgSSBkaWRuJ3QgZmluZCByZWxhdGVkIGRpc2N1c3Npb24gaW4gbWFpbCBoaXN0
b3J5LCBtYXliZQ0KYnkgYWNjaWRlbnQ/IEkgY2FuIGFkZCBpdCBiYWNrIGlmIGl0J3Mgbm90IGlu
dGVudGlvbmFsLg0KDQpiYTdkMTJlYjhjICBody9wY2k6IG1vZGlmeSBwY2lfc2V0dXBfaW9tbXUo
KSB0byBzZXQgUENJSU9NTVVPcHMNCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

