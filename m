Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F06A3838ABF
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 10:47:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSDNL-0007Rv-R5; Tue, 23 Jan 2024 04:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSDNH-0007RD-2L
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 04:47:19 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSDNF-0006on-2s
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 04:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706003237; x=1737539237;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jqqI9J79Wc2wbP8xHsQsk7fri2NXomharBrAEJiJs00=;
 b=bxj06OFtQaVqvdineUP+DWiQ+mNBwUMDB2zDqBuoqlKzq2ZX/l4mPu38
 omerPfN6+TwPS4p2ar75RgGzJRQ1FSpA3tQntopcLTl6nALJpWX64sSbU
 Jz1olOYVTvDdLDX+Q07exS55W91VQ2Cd3qrTZOCZZX5mow9Iir4gq7QxS
 7mg7N9XBeorPqdMXOnD4Rig0/TCU4Vhuvd6qokgiVcHnInU/vhso2FWMj
 8QcQjiPy1F3OFKw+wOEybFQImo5wG5Kz2znBOAO3UxlAdPTxurFSOGF5X
 ysT1TXluWIRHz9ijGkOo2++jiMVTtYV1ibgAmmS1ZHmSPLI2JGP9+lRgM Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="363470"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="363470"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2024 01:47:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="785995471"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; d="scan'208";a="785995471"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Jan 2024 01:47:06 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 01:47:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 01:47:05 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Jan 2024 01:47:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k17zfhx8DMZROzXidHovp0uK06yEJR7zhqVMOBroRPgrqt592mqCgWddCQ+uD2pZyLpD+Eiab4UVp+eO6wNz1+TwgvscBZkseN59f7fib1PI8RHujPwiJaYC3z24qxfrtlj0ovJ+8QmnuFcyEKgxWEFL1b0lkWKeu+YbrSeT7pqYV4/CXREfVX1iWvars9A578KI6Ixi7TrWJnRpqywBUGLcI16ONCAuAFdNmyrhWDM2YzBd3GFKr4f9kOX22nA0m/sLjMtdXylOpuG+XeRl42FBl2VTJWCpuuW05ex+cqq5yCr4eV3WR5WS2qCY0bbUw7ta+YP1aYDyXdjRsPlC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqqI9J79Wc2wbP8xHsQsk7fri2NXomharBrAEJiJs00=;
 b=VE4Rs3O28BLqJZ2TGfBsT63CRVVba7jBkKwEn2JvIi0OLkO5DAU0jaOGwyvESggZ1Nw+8cPpbEMexUc9GQqXptoLPKn2ILu6/8fpVW+CU9j2iYdavIH1eocHkQVT7eQ5RjdqOwLLQ5sXw1xVEMc7UkCx6GVbXRGzpQjWLyJDlodO5GnBwO5S/fg0d+oCSsXNYO/BCNGMnMZjjMHq0DRtj7+rmmVuk6A5cZq2L5swQeObjJrl4nEn23E11skJFaU18UW/dPpwVQXtMlClNJ/E4LmWRccUXv7KWoRg/98YAxZsJACVWw+TN0FrofiPJw47R36lBqzPeTFpojbIYtcR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB5518.namprd11.prod.outlook.com (2603:10b6:5:39a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 09:46:58 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3%4]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 09:46:58 +0000
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
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH rfcv1 4/6] vfio: initialize IOMMUFDDevice and pass to
 vIOMMU
Thread-Topic: [PATCH rfcv1 4/6] vfio: initialize IOMMUFDDevice and pass to
 vIOMMU
Thread-Index: AQHaR5v0AZ3rmcpUu0e+6RYUwmKBmbDmHeSAgAEUL8A=
Date: Tue, 23 Jan 2024 09:46:58 +0000
Message-ID: <SJ0PR11MB67442926DAA9AD72F1B89CED92742@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-5-zhenzhong.duan@intel.com>
 <852e8e08-1d82-49d4-a19c-36a6b256d662@redhat.com>
In-Reply-To: <852e8e08-1d82-49d4-a19c-36a6b256d662@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB5518:EE_
x-ms-office365-filtering-correlation-id: a72d47b9-a43c-4419-7694-08dc1bf83db9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oo6z9YOB21wkfQ8c0DUWOc0bmaj4P3T8RIKKV1pWD4SoFWhvi9h+4IHkfWO8oG7ukycrwGcbl4Hi/voMbQtQ8rGZ3qaeJItn4xvLYPPk59IEVZG4NpDdfvZh/t4I+mqoAGmgqGMuT3O7BfspfyKfsUQ0fIbXed+1YgN1U4F9ZlqmGSpZWSGvqX8h7LIty70WwM+nRWQcsbdS5XNNn97aRId5AzzxkdvBZyMXtUq9nGDRknaqLWsAeFdPr1ktFdCacuWNHbxRw2T+sD4dETjVhgHtRNOuvA0F43qXUp2tgRwwdj7Q/g6wOD8PkR2noO05QCM+enlCADh1UhxtZwe/qnIqM0JenHX7eeraiqMjaM4zqcF1PZYz4oMf+dBUJrZYDe8ctLpA3oPxsl+TGolpda7bd4lz1AfjnDNJIBbsbjHJLmQy9p3BvHRsLaWDK7cWkowoJJ2BTEzghTlVGo9Ij0vP10hkfAkh+42TTh2H1AU8YEkG/K77GM4lLuKgepf/ngJDDaYm6rT1N/7azvSFGA4SEGMCUv/hFqcamndMs83bp9Ct9STYxk4iOmIxZmYLr806YR/lpjKoE/8irVNl755CxOHYblI5Vaqu3xL+h1mdCwBNKKEamGHRZJm+R+H7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(33656002)(55016003)(38100700002)(122000001)(82960400001)(64756008)(4326008)(8936002)(6506007)(66946007)(52536014)(966005)(7696005)(7416002)(2906002)(26005)(5660300002)(9686003)(66556008)(66476007)(316002)(478600001)(110136005)(66446008)(54906003)(8676002)(76116006)(86362001)(71200400001)(83380400001)(38070700009)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlluSHRPMUw4TmpxalhYN2VjcnJMS1RjekdHc3B5VXRlekMxbkkyWnFIdTgv?=
 =?utf-8?B?aEp3VVF0ekMxd2xMWHNjaUFnN2hPVm14UWk5bWsxdWtUSEtRdHZwWGxOaEdj?=
 =?utf-8?B?U0FQQThwbXhRNkx5ZzZzcVQ4em9OWCt4bTVOWDZWUXdESUNBMFZ1Z2NJcDJL?=
 =?utf-8?B?Y3hFOG5SZTFpLzRPRFIyS2cwNjA1QnBrNktiZ1J0b0RFYlpBbHZBbDh1V1Fl?=
 =?utf-8?B?dmQ4WFlkU2tZKzQ0Y2JzUWtaeURVV3JTSWlLaStUZHdpWlI1Vm9uN2dZZEk2?=
 =?utf-8?B?bmFxOGhDc2VxZENxVFZKenBPUitTZlFPdFVRdDFPUzVoY0RVbG5LM3FRN0ZV?=
 =?utf-8?B?YXZFYzNETHdhKzdIMmJjaWtjdmVHRGRJOXhRVlRUZkZxZEFxRWhyM0Urd1Bt?=
 =?utf-8?B?dEg2RVcyOWFNK3JPa1NTU0hPUnlZQUFPYTdIc3dKV2ZSN3Q1bk5VRGh2TDJO?=
 =?utf-8?B?ZXd5WVY4VUVmM0dLWkU0RUM5SGhoUndaTEh6aExreGJsWEE5ZEtGVHBvR0Z2?=
 =?utf-8?B?T2drSThmMDdOdTJFMXFYcjZtYStqaktnc1J0R0xHSlZkdjN1dUxMWGZZSmd4?=
 =?utf-8?B?aVFNSjI5dzhPNkVycXpqYmRkZFFJUVhPZ2RQdnd2cSs0SEJ4OGpIeXZtalQ5?=
 =?utf-8?B?VEVCazFBZkIwcElicWlvSWRySmdVMENzejVhbzR4RG1rSnE5MWhLa3hXNlJE?=
 =?utf-8?B?dmgyZVpQZ0tLK0NZaEVUMlhIRHZGY0VldXJ6YU1hWTl5V3lpUmsweGs1S01B?=
 =?utf-8?B?OFJrME00SDRjQlVKc3R3bWVBYmNzRkJrZnl5aHlMSTUydnNUWElSUGRyT01h?=
 =?utf-8?B?S0xyUFpCWTNvTkErK0krUGNLVFdJdjdlNUdIVGw1a0VGSmhicitsTFU2a2Jt?=
 =?utf-8?B?a2d3RHFWVlp6NUVjL0VzT1c3akk0bGtWVVJCdzQxWUVoVU84R3hOQUlvOWo5?=
 =?utf-8?B?aWRSUjU4YWtwR1dNNXkxUEJMSTl3c2Uvdks2Zk44YXNJSmg3eUJNdzdLS0JH?=
 =?utf-8?B?bUdpRENVNXIrYjc4MFZpamE4UXEybElOUHkza0ZVTmZlQm4xR0dOam9zRmZp?=
 =?utf-8?B?V0c1a0JocVUzNjFzbFpyRDRrR29PaDAyNGp1RUxTMC8wVjZvUjhheG9WS3hG?=
 =?utf-8?B?dExaSHM1eHJURUJDZTVqR1ExdEZQUzRVUjczNm5FVTNFWW94dDhDaXpGRjBn?=
 =?utf-8?B?VUgwUkw3NkFTVzFuWHJ6VU4xc0NDeGFxL0ZYNHlaQU9hZnpYQTRDYzRBejlE?=
 =?utf-8?B?eWpSYlphclBSakkxY0N0RkY3UHBWWHhKc2hDa1lrakpsQ0NNVWh5YWpnSWhi?=
 =?utf-8?B?Z1B2Mnk1aksyNnVGNmNQaFFRRGZES1ZDTUxwL05WdVJyeVRwVlpIWGR4NnZm?=
 =?utf-8?B?d3VZWUJpZkxrSDM3RzV6SVk5NEhoUjBaM1E5c1VkVGJhWXBKK2VkeUlVbjBs?=
 =?utf-8?B?VjF0aklXZDJobnc5Z1hHaWV5SzhHV3dzMlBPUFNDZFAya3N1aDIzMVphWTJT?=
 =?utf-8?B?ZGUwTS8vZDZROTZJMUVZdEZoUXc2Yy9ibDFOVitIS0FPM1ZiVUFxNGNMR00r?=
 =?utf-8?B?cWppMUVxN0NneHV6cmdYMWNCaHdlNGxrazg0QkVjMVJFUXM5b2xOdlVyelFx?=
 =?utf-8?B?Z2p0RGhkcGJFOWI0ZGlQV2ZOQjVRNFcrdHZ6NDFtQjJqaFFmdXJYZTlKTmNm?=
 =?utf-8?B?a0owRWpuYm8weEZrMmFtdGV4YlBXaVMrcXlXUEl5V280QktvRGVNUjYxK3Vs?=
 =?utf-8?B?YmVEaWZOWUhxa2JHT01BN0cxSGd0NEVWZmU0ZHFzQjFjMW1wTTlTdGJzU21U?=
 =?utf-8?B?ajkwUWJoQ2UySFZDdVF2OUNVK3FmdDFlU25XaEI2VER0Ny9uaWxRbkxaZ1g5?=
 =?utf-8?B?Z2M1anNVVnArbTlOTUwzUCt3QjVCTEdIY1RnVG1jalJLdVd2TDJ5dzFyZGgx?=
 =?utf-8?B?Y1BsbHBSYjZyenlMQzJlajVKUmtIWlg4cEk5emZ0aGpUN0hDTTRBZjVjNnFQ?=
 =?utf-8?B?UHRXSkRHZWY3Y0o2bDVhelZadklwV2Evbk1DOTVGNzZIaVc3RHdZMkc4TUNl?=
 =?utf-8?B?enppSHY2clEvclNKNlB0ZFpieUJVeHhyZEorcm9rWnd1WUsvNllqL2gxQVVR?=
 =?utf-8?Q?GkScOhJg/o5uGMiWUfqI1drsb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72d47b9-a43c-4419-7694-08dc1bf83db9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 09:46:58.0774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uh+GgpKw//HtMsAYqx7PYkvIp7VcOVXvGU67Rl3ZEiS4eoRIiChBth/jdrsWwG2dTA/t8yxuJS1ngsPlnutFMM/EPp6qiE0hXhItJEha8AY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5518
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YxIDQvNl0gdmZpbzog
aW5pdGlhbGl6ZSBJT01NVUZERGV2aWNlIGFuZCBwYXNzIHRvDQo+dklPTU1VDQo+DQo+T24gMS8x
NS8yNCAxMToxMywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBJbml0aWFsaXplIElPTU1VRkRE
ZXZpY2UgaW4gdmZpbyBhbmQgcGFzcyB0byB2SU9NTVUsIHNvIHRoYXQgdklPTU1VDQo+PiBjb3Vs
ZCBnZXQgaHcgSU9NTVUgaW5mb3JtYXRpb24uDQo+Pg0KPj4gSW4gVkZJTyBsZWdhY3kgYmFja2Vu
ZCBtb2RlLCB3ZSBzdGlsbCBwYXNzIGEgTlVMTCBJT01NVUZERGV2aWNlIHRvDQo+dklPTU1VLA0K
Pj4gaW4gY2FzZSB2SU9NTVUgbmVlZHMgc29tZSBwcm9jZXNzaW5nIGZvciBWRklPIGxlZ2FjeSBi
YWNrZW5kIG1vZGUuDQo+Pg0KPj4gT3JpZ2luYWxseS1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRl
bC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5j
b20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVsLmNvbT4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5j
b20+DQo+PiAtLS0NCj4+ICAgaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggfCAgMiArKw0K
Pj4gICBody92ZmlvL2lvbW11ZmQuYyAgICAgICAgICAgICB8ICAyICsrDQo+PiAgIGh3L3ZmaW8v
cGNpLmMgICAgICAgICAgICAgICAgIHwgMjQgKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+PiAg
IDMgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggYi9pbmNsdWRlL2h3
L3ZmaW8vdmZpby0NCj5jb21tb24uaA0KPj4gaW5kZXggOWI3ZWY3ZDAyYi4uZmRlMGQwY2E2MCAx
MDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+PiArKysgYi9p
bmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPj4gQEAgLTMxLDYgKzMxLDcgQEANCj4+ICAg
I2VuZGlmDQo+PiAgICNpbmNsdWRlICJzeXNlbXUvc3lzZW11LmgiDQo+PiAgICNpbmNsdWRlICJo
dy92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaCINCj4+ICsjaW5jbHVkZSAic3lzZW11L2lvbW11
ZmRfZGV2aWNlLmgiDQo+Pg0KPj4gICAjZGVmaW5lIFZGSU9fTVNHX1BSRUZJWCAidmZpbyAlczog
Ig0KPj4NCj4+IEBAIC0xMjYsNiArMTI3LDcgQEAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0RldmljZSB7
DQo+PiAgICAgICBib29sIGRpcnR5X3RyYWNraW5nOw0KPj4gICAgICAgaW50IGRldmlkOw0KPj4g
ICAgICAgSU9NTVVGREJhY2tlbmQgKmlvbW11ZmQ7DQo+PiArICAgIElPTU1VRkREZXZpY2UgaWRl
djsNCj4+ICAgfSBWRklPRGV2aWNlOw0KPj4NCj4+ICAgc3RydWN0IFZGSU9EZXZpY2VPcHMgew0K
Pj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vaW9tbXVmZC5jIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+
IGluZGV4IDliZmRkYzEzNjAuLmNiZDAzNWYxNDggMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL2lv
bW11ZmQuYw0KPj4gKysrIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+IEBAIC0zMDksNiArMzA5LDcg
QEAgc3RhdGljIGludCBpb21tdWZkX2NkZXZfYXR0YWNoKGNvbnN0IGNoYXIgKm5hbWUsDQo+VkZJ
T0RldmljZSAqdmJhc2VkZXYsDQo+PiAgICAgICBWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5l
cjsNCj4+ICAgICAgIFZGSU9JT01NVUZEQ29udGFpbmVyICpjb250YWluZXI7DQo+PiAgICAgICBW
RklPQWRkcmVzc1NwYWNlICpzcGFjZTsNCj4+ICsgICAgSU9NTVVGRERldmljZSAqaWRldiA9ICZ2
YmFzZWRldi0+aWRldjsNCj4+ICAgICAgIHN0cnVjdCB2ZmlvX2RldmljZV9pbmZvIGRldl9pbmZv
ID0geyAuYXJnc3ogPSBzaXplb2YoZGV2X2luZm8pIH07DQo+PiAgICAgICBpbnQgcmV0LCBkZXZm
ZDsNCj4+ICAgICAgIHVpbnQzMl90IGlvYXNfaWQ7DQo+PiBAQCAtNDI4LDYgKzQyOSw3IEBAIGZv
dW5kX2NvbnRhaW5lcjoNCj4+ICAgICAgIFFMSVNUX0lOU0VSVF9IRUFEKCZiY29udGFpbmVyLT5k
ZXZpY2VfbGlzdCwgdmJhc2VkZXYsDQo+Y29udGFpbmVyX25leHQpOw0KPj4gICAgICAgUUxJU1Rf
SU5TRVJUX0hFQUQoJnZmaW9fZGV2aWNlX2xpc3QsIHZiYXNlZGV2LCBnbG9iYWxfbmV4dCk7DQo+
Pg0KPj4gKyAgICBpb21tdWZkX2RldmljZV9pbml0KGlkZXYsIHNpemVvZigqaWRldiksIGNvbnRh
aW5lci0+YmUsIHZiYXNlZGV2LQ0KPj5kZXZpZCk7DQo+PiAgICAgICB0cmFjZV9pb21tdWZkX2Nk
ZXZfZGV2aWNlX2luZm8odmJhc2VkZXYtPm5hbWUsIGRldmZkLCB2YmFzZWRldi0NCj4+bnVtX2ly
cXMsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmJhc2VkZXYtPm51
bV9yZWdpb25zLCB2YmFzZWRldi0+ZmxhZ3MpOw0KPj4gICAgICAgcmV0dXJuIDA7DQo+PiBkaWZm
IC0tZ2l0IGEvaHcvdmZpby9wY2kuYyBiL2h3L3ZmaW8vcGNpLmMNCj4+IGluZGV4IGQ3ZmUwNjcx
NWMuLjJjM2E1ZDI2N2IgMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL3BjaS5jDQo+PiArKysgYi9o
dy92ZmlvL3BjaS5jDQo+PiBAQCAtMzEwNywxMSArMzEwNywyMSBAQCBzdGF0aWMgdm9pZCB2Zmlv
X3JlYWxpemUoUENJRGV2aWNlICpwZGV2LA0KPkVycm9yICoqZXJycCkNCj4+DQo+PiAgICAgICB2
ZmlvX2JhcnNfcmVnaXN0ZXIodmRldik7DQo+Pg0KPj4gLSAgICByZXQgPSB2ZmlvX2FkZF9jYXBh
YmlsaXRpZXModmRldiwgZXJycCk7DQo+PiArICAgIGlmICh2YmFzZWRldi0+aW9tbXVmZCkgew0K
Pj4gKyAgICAgICAgcmV0ID0gcGNpX2RldmljZV9zZXRfaW9tbXVfZGV2aWNlKHBkZXYsICZ2YmFz
ZWRldi0+aWRldiwgZXJycCk7DQo+PiArICAgIH0gZWxzZSB7DQo+PiArICAgICAgICByZXQgPSBw
Y2lfZGV2aWNlX3NldF9pb21tdV9kZXZpY2UocGRldiwgMCwgZXJycCk7DQo+DQo+DQo+QUZBSUNU
LCBwY2lfZGV2aWNlX3NldF9pb21tdV9kZXZpY2UoKSB3aXRoIGEgTlVMTCBJT01NVUZERGV2aWNl
IHdpbGwNCj5kbw0KPm5vdGhpbmcuIFdoeSBjYWxsIGl0ID8NCg0KV2Ugd2lsbCBkbyBzb21ldGhp
bmcgaW4gbmVzdGluZyBzZXJpZXMsIHNlZSBodHRwczovL2dpdGh1Yi5jb20veWlsaXUxNzY1L3Fl
bXUvY29tbWl0LzdmMGJiNTk1NzViYjVjZjM4NjE4YWU5NTBmNjhhODY2MTY3NmU4ODENCg0KQW5v
dGhlciBjaG9pY2UgaXMgdG8gY2FsbCBwY2lfZGV2aWNlX3NldF9pb21tdV9kZXZpY2UoKSBubyBt
YXR0ZXIgd2hpY2ggYmFja2VuZA0KaXMgdXNlZCBhbmQgY2hlY2sgaWRldi0+aW9tbXVmZCBpbiB2
dGRfZGV2X3NldF9pb21tdV9kZXZpY2UoKS4gSXMgdGhpcyBiZXR0ZXINCmZvciB5b3U/DQoNClRo
YW5rcw0KWmhlbnpob25nDQo=

