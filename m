Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3535D7B03B9
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 14:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlTSI-0003qC-Af; Wed, 27 Sep 2023 08:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlTSC-0003pt-Gk
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 08:15:45 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlTS8-0005rB-08
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 08:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695816938; x=1727352938;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7NupNreWS/Ic9FT9ZJue6CTsfZo6pzZd+tUsDRWW9Oc=;
 b=nKov9rU3/YhK50kZ0aYqIi2T/8y+nPbJbsPiHiGkUTAdfcNRAMiZheyC
 FOopeaRaonGDHke9X41ycOfCxKeFd0mO/LvSADLvp9yGid50OoVnAv3sq
 +n7hA/saNarAIXdoKyD50algAbYyuTGy20adCL9z71OjI0PkyBhAx/kzk
 PrmC7gA8U5OzTupBjdwak9UVzhIg1DdZ9HO7YapoPl82utJPoUzlbh2qR
 cFTQjITs6rqMGwsxbPg5qI7E3UiJcv4W6RYX0cff/8YlTZoajTLQKf1kF
 gaUj6vzA9f8XW5iujZxuFP1+pVShqljnPPMEN7HtN6I/Dy4+Z8dfG00MJ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="385665284"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; d="scan'208";a="385665284"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2023 05:15:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="784301576"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; d="scan'208";a="784301576"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Sep 2023 05:15:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 05:15:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 05:15:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 05:15:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2v40IjbLE9yhx9ab+mOBFdrnFlyn33h+ed+3OmZhKA6+H66nE7EwLLpp9Njz+GND5LZYyaK1kprNoUImu5jKMKUG0akD25aLAWUdx5L2MD4CDVKEIQPIDYbePV9KaJEBXes7sSzAbOMlLQQZxJwjfjcnT7ZKIUNfg42GmT5U0k6BCKO83WOmFNBwTBRnW8hIJZw/fH9EXdXeQO/cK3AOgA/GKIOdAeJbwH7YH7YHQCejPIeI/35phvOfETSL8Zm4t9AYn4K/QFq06RgZq97WQWW+8DIsTdxYkXpDG3rdwtgbudGCzQ2+nm/mC0U1Zx4ELpewY1ppxjMNga22DlO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NupNreWS/Ic9FT9ZJue6CTsfZo6pzZd+tUsDRWW9Oc=;
 b=iucXbgctHWJLu1Foefgc0tUKmMzfLFwIUjLOpzA/uSR64tjLOaVgi6lJ3EWvNduKI1yQtsRq/UXp4whX7hGZjCiHHEN0MAb55gWI6MyccTidJ3UnWRST0flPK6H+w5f3koKPY0ZhcKUIhbLXbPPtl7R0oGkvxB/Y+VyS30GtAY3xesEJV2/z0bsP56Hgrp+lTupQoYDPeF8kRuAKd7Q0W/jP4HBHXXTRZOrZLYTpG+qm9rYYkr+WEZTb0ePc9zaku7RJPH4KEkHOooLkE/lK8i7GGICZpLdEZRLmtUk21dlMZCNqvmx/4KE9+sap2qeBG1BUqWEvZpbwEpxZkVQ/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by MW4PR11MB7128.namprd11.prod.outlook.com (2603:10b6:303:22b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 12:15:19 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24%3]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 12:15:19 +0000
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
Subject: RE: [PATCH v2 06/12] vfio/pci: Introduce vfio_[attach/detach]_device
Thread-Topic: [PATCH v2 06/12] vfio/pci: Introduce vfio_[attach/detach]_device
Thread-Index: AQHZ8G9MBK3w/OsZY02YQxt5EZwDgrAudpKAgAAfnMA=
Date: Wed, 27 Sep 2023 12:15:19 +0000
Message-ID: <PH7PR11MB6722C5494B6575BAA3D8D79592C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-7-zhenzhong.duan@intel.com>
 <0de7cf0d-5f38-f20e-7f80-c419bc6e8bd3@redhat.com>
In-Reply-To: <0de7cf0d-5f38-f20e-7f80-c419bc6e8bd3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|MW4PR11MB7128:EE_
x-ms-office365-filtering-correlation-id: f8b9d09f-c347-4576-6dd5-08dbbf536a58
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tHoO0F9L5F1slNfG64b5quvfUKDjybGUs6eBIqw1CFLH9FoCIV5zUyhKAtOdVAiAKTUhCSeEmrW1jTpzwdtZRiBRkbLnywW99OyVuwq7SSfz8+5zRmgvzAykTML7ASALJSZVnHLAGp+/roilPXJSNcagHr5vEnFxMrcyJ4kgmGrEOAd+b621wanOWW7YC0L/nW/ltV5Ef7MgRaIA2B9nSo8VFRP815m6Xn3T1HmDcToLq3THRqnZXUOb34Dzzts940CjPVo6RgvQ+kvN3hjG3b6YNmeR5PX4el6GM43bgsvI6hGCzpZGnQWpY/ckDJVa3RRcJEJdUiIwqWcpsok7HH/eu+rVgfnAq/VeV5Iur05uEazmwcIXTg+/lHZEXt0OY/8emJuaXyGIjvb6v7UkMI3uzxuLDgfPyMMYUyvwmb9/yD/u//RaDlf/L9JfUwLEeBQ0ZKPbC6Y6W9u3XZOYocz7YP4IB4bUp0vFRHX9E0YQzizAvOTKhnAz0Tz0FCHF4G70hNeyPZ4Qn05/QpDZcyJMkf9rRhz+/AgAo7UYctfvmwTXmkDzIGqy1rf+/EtMtWRvQl4ijt60jXrLolOXCgA5DZdltgk8mopL9VQ9iRPpKS35tqAddvKfPyLvY+DC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(186009)(1800799009)(451199024)(107886003)(7696005)(6506007)(26005)(9686003)(38070700005)(82960400001)(122000001)(38100700002)(86362001)(33656002)(55016003)(66574015)(4326008)(83380400001)(8936002)(316002)(8676002)(41300700001)(66556008)(66476007)(66446008)(66946007)(5660300002)(110136005)(52536014)(76116006)(2906002)(64756008)(54906003)(71200400001)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0QreFZzZzNlZk5NVENGUCtLTmJhb1l6SnVxMkJhRnFOT2hrUkVCOVFTcXMv?=
 =?utf-8?B?VE9hZVN2ZThDZjExbTBGOE9CWVpUYzRaMXJJOVhEWGJ2WkZMb2xudEVLVGRh?=
 =?utf-8?B?Sk9mL3lRQm1GRzd0UGJ5RDc5WUdHV0RpajRCaVB5bnlpSHdiQzFWZGxDZm50?=
 =?utf-8?B?UGJRckJubVFPcm5VUmZpQWk4SHROblc0dEZ5enZkRi9oZFFKblFROVdJTWR1?=
 =?utf-8?B?TmFxaDgzSWZQWGRwYTI2TG5MdGhXMFZQOWVjREdjbmtEVnI4aXpaOGxkMklN?=
 =?utf-8?B?Q2N0ZUluMC9MMWJlcXg4ODV5YXNFMnFCR0NUSXJlaUV4NmZScDE0OXVNM0VX?=
 =?utf-8?B?Mk9YeTZwSHdaUmRIWjVYWVU1L3Y1TVVWdzdpL2lTeUttb2FCSDRVTXA0emFH?=
 =?utf-8?B?ZDlnbkJGVlRDOHVLbXk0akNwZll5MFVTUHJPNjZZMzhjb2lWK2VpTDFNbElN?=
 =?utf-8?B?VzRGL0lLcHFIY1h5R2JKWWxRVURhSDN6a0owcFVBSXdJVmgvbmpPOWNNMVZm?=
 =?utf-8?B?SitlL1pSMUNXbCtHWjMzOHEyYVhReGkrSC83VFhhNG02ajhnR0NjSXBFSmtJ?=
 =?utf-8?B?TnFhZjFEbnlyUUxPR1FxcnJhUEMzVm1Pdi9acDF6bnh2SlVjZTQvWFJ2eExo?=
 =?utf-8?B?akd0VkptcFAxWSs1ZVVObHNDUFVSTDY0UTJNNHFVRURuYlFnMlZQSURmcVpn?=
 =?utf-8?B?dFhpQ3E2YW1zeFJzbHZmUEpSVE53QU81dDdCeURaVnVEOFEwdnNWcE9VK3VY?=
 =?utf-8?B?MEc3cUlQeGJLczJRcUJ1WUV6ZGQ0S0FXTFNIYXJ2VVJVcWQxamx4OXNzeUx2?=
 =?utf-8?B?TWZaOW9tSUJ1R2VxYXJlM21DN0RPYzFRSEFHb3ZFQ3IzbjZaMWxYMTdVOTFH?=
 =?utf-8?B?ZEZPNGIwbm11cjM1VnlNTkM4T1hoTm5UeXZaSjdoNzFSZ1NGTUpPN0tUV20v?=
 =?utf-8?B?OFpwc05ZYi9pL2I1L2tpRlJVL01DVnZsTUp6S2Q0TTEwVlpGNy9uTVpVZDQy?=
 =?utf-8?B?aTlwSGV2QUhuSmxtTFRvZkJNMzZmcGJLbjIxV3VIa2k4U09UVHJzcFZVOWgz?=
 =?utf-8?B?UHpnR3Nac0pYaHFYUDB2Wnk4dStXR3ZiWjhYUkFBNlRHWitsdmYyaUd1dkhK?=
 =?utf-8?B?NFpDWVlJUnFHYkJpSmc2YVRuOHVlM001bzZsZlh3SmszSGhhdFZPajhlcFk0?=
 =?utf-8?B?TjhKb3NkMDYzcWVZdGJ4M2xlRm9keWZnRGpJWEl1aXZLaGNjaExQb0dXUjBh?=
 =?utf-8?B?TXdjTE01UXgxR2szUXlrYnpSM1NNYUI3ZUtmd3M5RnNFeXpQN2hXNEFyWldt?=
 =?utf-8?B?cUh2bUtUSk1Rd3EvZ3l4aThSdGZ3OTJMOFFITnlDNGxvbkpGZUZ5bkNxdnZa?=
 =?utf-8?B?QUlDMzlEeGxDaitLSzhZV0xiRHBrY3p2a2ZYWFN6SEx6VHlhOFJXaC9XbVJ1?=
 =?utf-8?B?cUtlODlLeWN6VFprZnYzTWVGZGNtcEJlTlRyWUhSdjRORmRwREo1b1gxN0Vj?=
 =?utf-8?B?VHFGZExkMER0Ty9xUWkwb1BPWDMwUnkwVjkwTkhRSnVqVE01c1ZFdU5MMGQ5?=
 =?utf-8?B?Q2VhbzVaMTBzWkdtR0gveThKMFNJb1lWLzJ3TDZnYkpGbmdsZXMrN0dJbmV5?=
 =?utf-8?B?Yi9tLzZ3RTdTbWh5dTFjQkpZZnpCVGM3UVVyaEJwYytwamo3V0pDeWFUbGhP?=
 =?utf-8?B?cHpDa2tnYVYxcVZNN2dYSmpSaEFDT1QyN05VL3ZhUjcwOTF1MlpPS0VYc0xY?=
 =?utf-8?B?YWYzRG56bjZDSjVQZk9ZbWtuWmY4K1ZreHV0bFRabXFpTmtKZkZmREMvbXJ6?=
 =?utf-8?B?REhsSmNTbWNCdXpzZk4vYTcwUTVnajA0TlBValRTa1lJNDREa2dzUDY4ZzFa?=
 =?utf-8?B?Q2swMEJTd2FlYm5jQXY0VGEvMEoxZUsvay9HeFZFV2wxRllnaVJDZDVVc3Jp?=
 =?utf-8?B?QVFHOGxqRHVBam12S0xKK1hkU0ludEUzak45Sks0K3lQamU0Z3RjVW9NYXJF?=
 =?utf-8?B?UFZwVzdvUGUvTWVtanFzK0UwSmRpYVBxemFDdEc5TkxxcEQ0TTl2ZzBJUnVi?=
 =?utf-8?B?SVNrVnhHZFgrMXBYaGlWZ2VuM2ZQUWtiZDJQRzF5WWpNenJxSFU1VE1ySy9u?=
 =?utf-8?Q?i7eXiDuhgLVvjTJqePXli3lBL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b9d09f-c347-4576-6dd5-08dbbf536a58
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 12:15:19.0161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QlQO1LC3Fqc3wOD8JRgNG4/vewRQC4skzmLs0QDcyXwTmXDVJTCbV+zHhPUG3/v6a+BqTw+umlQWLlVDVAasnabWSm5MyDb3przyoSZUpls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7128
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyNywgMjAyMyA2
OjE3IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MiAwNi8xMl0gdmZpby9wY2k6IEludHJvZHVj
ZSB2ZmlvX1thdHRhY2gvZGV0YWNoXV9kZXZpY2UNCj4NCj5PbiA5LzI2LzIzIDEzOjMyLCBaaGVu
emhvbmcgRHVhbiB3cm90ZToNCj4+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0
LmNvbT4NCj4+DQo+PiBXZSB3YW50IHRoZSBWRklPIGRldmljZXMgdG8gYmUgYWJsZSB0byB1c2Ug
dHdvIGRpZmZlcmVudA0KPj4gSU9NTVUgYmFja2VuZHMsIHRoZSBsZWdhY3kgVkZJTyBvbmUgYW5k
IHRoZSBuZXcgaW9tbXVmZCBvbmUuDQo+Pg0KPj4gSW50cm9kdWNlIHZmaW9fW2F0dGFjaC9kZXRh
Y2hdX2RldmljZSB3aGljaCBhaW0gYXQgaGlkaW5nIHRoZQ0KPj4gdW5kZXJseWluZyBJT01NVSBi
YWNrZW5kIChJT0NUTHMsIGRhdGF0eXBlcywgLi4uKS4NCj4+DQo+PiBPbmNlIHZmaW9fYXR0YWNo
X2RldmljZSBjb21wbGV0ZXMsIHRoZSBkZXZpY2UgaXMgYXR0YWNoZWQNCj4+IHRvIGEgc2VjdXJp
dHkgY29udGV4dCBhbmQgaXRzIGZkIGNhbiBiZSB1c2VkLiBDb252ZXJzZWx5DQo+PiBXaGVuIHZm
aW9fZGV0YWNoX2RldmljZSBjb21wbGV0ZXMsIHRoZSBkZXZpY2UgaGFzIGJlZW4NCj4+IGRldGFj
aGVkIGZyb20gdGhlIHNlY3VyaXR5IGNvbnRleHQuDQo+Pg0KPj4gQXQgdGhlIG1vbWVudCBvbmx5
IHRoZSBpbXBsZW1lbnRhdGlvbiBiYXNlZCBvbiB0aGUgbGVnYWN5DQo+PiBjb250YWluZXIvZ3Jv
dXAgZXhpc3RzLiBMZXQncyB1c2UgaXQgZnJvbSB0aGUgdmZpby1wY2kgZGV2aWNlLg0KPj4gU3Vi
c2VxdWVudCBwYXRjaGVzIHdpbGwgaGFuZGxlIG90aGVyIGRldmljZXMuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4gU2lnbmVkLW9m
Zi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVu
emhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1
ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oIHwgIDMgKysNCj4+ICAgaHcvdmZpby9jb21tb24uYyAg
ICAgICAgICAgICAgfCA2OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4g
ICBody92ZmlvL3BjaS5jICAgICAgICAgICAgICAgICB8IDUwICsrKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+PiAgIGh3L3ZmaW8vdHJhY2UtZXZlbnRzICAgICAgICAgIHwgIDIgKy0NCj4+ICAg
NCBmaWxlcyBjaGFuZ2VkLCA3NyBpbnNlcnRpb25zKCspLCA0NiBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggYi9pbmNsdWRlL2h3
L3ZmaW8vdmZpby1jb21tb24uaA0KPj4gaW5kZXggYzRlN2MzYjRhNy4uMTJmYmZiYzM3ZCAxMDA2
NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+PiArKysgYi9pbmNs
dWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPj4gQEAgLTIyNSw2ICsyMjUsOSBAQCB2b2lkIHZm
aW9fcHV0X2dyb3VwKFZGSU9Hcm91cCAqZ3JvdXApOw0KPj4gICBzdHJ1Y3QgdmZpb19kZXZpY2Vf
aW5mbyAqdmZpb19nZXRfZGV2aWNlX2luZm8oaW50IGZkKTsNCj4+ICAgaW50IHZmaW9fZ2V0X2Rl
dmljZShWRklPR3JvdXAgKmdyb3VwLCBjb25zdCBjaGFyICpuYW1lLA0KPj4gICAgICAgICAgICAg
ICAgICAgICAgIFZGSU9EZXZpY2UgKnZiYXNlZGV2LCBFcnJvciAqKmVycnApOw0KPj4gK2ludCB2
ZmlvX2F0dGFjaF9kZXZpY2UoY2hhciAqbmFtZSwgVkZJT0RldmljZSAqdmJhc2VkZXYsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICBBZGRyZXNzU3BhY2UgKmFzLCBFcnJvciAqKmVycnApOw0K
Pj4gK3ZvaWQgdmZpb19kZXRhY2hfZGV2aWNlKFZGSU9EZXZpY2UgKnZiYXNlZGV2KTsNCj4+DQo+
PiAgIGludCB2ZmlvX2t2bV9kZXZpY2VfYWRkX2ZkKGludCBmZCwgRXJyb3IgKiplcnJwKTsNCj4+
ICAgaW50IHZmaW9fa3ZtX2RldmljZV9kZWxfZmQoaW50IGZkLCBFcnJvciAqKmVycnApOw0KPj4g
ZGlmZiAtLWdpdCBhL2h3L3ZmaW8vY29tbW9uLmMgYi9ody92ZmlvL2NvbW1vbi5jDQo+PiBpbmRl
eCA5NTliMTM2MmJiLi43ZjM3OThiMTUyIDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby9jb21tb24u
Yw0KPj4gKysrIGIvaHcvdmZpby9jb21tb24uYw0KPj4gQEAgLTI2MTEsMyArMjYxMSw3MSBAQCBp
bnQgdmZpb19lZWhfYXNfb3AoQWRkcmVzc1NwYWNlICphcywgdWludDMyX3Qgb3ApDQo+PiAgICAg
ICB9DQo+PiAgICAgICByZXR1cm4gdmZpb19lZWhfY29udGFpbmVyX29wKGNvbnRhaW5lciwgb3Ap
Ow0KPj4gICB9DQo+PiArDQo+PiArc3RhdGljIGludCB2ZmlvX2RldmljZV9ncm91cGlkKFZGSU9E
ZXZpY2UgKnZiYXNlZGV2LCBFcnJvciAqKmVycnApDQo+PiArew0KPj4gKyAgICBjaGFyICp0bXAs
IGdyb3VwX3BhdGhbUEFUSF9NQVhdLCAqZ3JvdXBfbmFtZTsNCj4+ICsgICAgaW50IHJldCwgZ3Jv
dXBpZDsNCj4+ICsgICAgc3NpemVfdCBsZW47DQo+PiArDQo+PiArICAgIHRtcCA9IGdfc3RyZHVw
X3ByaW50ZigiJXMvaW9tbXVfZ3JvdXAiLCB2YmFzZWRldi0+c3lzZnNkZXYpOw0KPj4gKyAgICBs
ZW4gPSByZWFkbGluayh0bXAsIGdyb3VwX3BhdGgsIHNpemVvZihncm91cF9wYXRoKSk7DQo+PiAr
ICAgIGdfZnJlZSh0bXApOw0KPj4gKw0KPj4gKyAgICBpZiAobGVuIDw9IDAgfHwgbGVuID49IHNp
emVvZihncm91cF9wYXRoKSkgew0KPj4gKyAgICAgICAgcmV0ID0gbGVuIDwgMCA/IC1lcnJubyA6
IC1FTkFNRVRPT0xPTkc7DQo+PiArICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIC1yZXQs
ICJubyBpb21tdV9ncm91cCBmb3VuZCIpOw0KPj4gKyAgICAgICAgcmV0dXJuIHJldDsNCj4+ICsg
ICAgfQ0KPj4gKw0KPj4gKyAgICBncm91cF9wYXRoW2xlbl0gPSAwOw0KPj4gKw0KPj4gKyAgICBn
cm91cF9uYW1lID0gYmFzZW5hbWUoZ3JvdXBfcGF0aCk7DQo+PiArICAgIGlmIChzc2NhbmYoZ3Jv
dXBfbmFtZSwgIiVkIiwgJmdyb3VwaWQpICE9IDEpIHsNCj4+ICsgICAgICAgIGVycm9yX3NldGdf
ZXJybm8oZXJycCwgZXJybm8sICJmYWlsZWQgdG8gcmVhZCAlcyIsIGdyb3VwX3BhdGgpOw0KPj4g
KyAgICAgICAgcmV0dXJuIC1lcnJubzsNCj4+ICsgICAgfQ0KPj4gKyAgICByZXR1cm4gZ3JvdXBp
ZDsNCj4+ICt9DQo+PiArDQo+PiAraW50IHZmaW9fYXR0YWNoX2RldmljZShjaGFyICpuYW1lLCBW
RklPRGV2aWNlICp2YmFzZWRldiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIEFkZHJlc3NT
cGFjZSAqYXMsIEVycm9yICoqZXJycCkNCj4+ICt7DQo+PiArICAgIGludCBncm91cGlkID0gdmZp
b19kZXZpY2VfZ3JvdXBpZCh2YmFzZWRldiwgZXJycCk7DQo+PiArICAgIFZGSU9EZXZpY2UgKnZi
YXNlZGV2X2l0ZXI7DQo+PiArICAgIFZGSU9Hcm91cCAqZ3JvdXA7DQo+PiArICAgIGludCByZXQ7
DQo+PiArDQo+PiArICAgIGlmIChncm91cGlkIDwgMCkgew0KPj4gKyAgICAgICAgcmV0dXJuIGdy
b3VwaWQ7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgdHJhY2VfdmZpb19hdHRhY2hfZGV2aWNl
KHZiYXNlZGV2LT5uYW1lLCBncm91cGlkKTsNCj4+ICsNCj4+ICsgICAgZ3JvdXAgPSB2ZmlvX2dl
dF9ncm91cChncm91cGlkLCBhcywgZXJycCk7DQo+PiArICAgIGlmICghZ3JvdXApIHsNCj4+ICsg
ICAgICAgIHJldHVybiAtRU5PRU5UOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIFFMSVNUX0ZP
UkVBQ0godmJhc2VkZXZfaXRlciwgJmdyb3VwLT5kZXZpY2VfbGlzdCwgbmV4dCkgew0KPj4gKyAg
ICAgICAgaWYgKHN0cmNtcCh2YmFzZWRldl9pdGVyLT5uYW1lLCB2YmFzZWRldi0+bmFtZSkgPT0g
MCkgew0KPj4gKyAgICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgImRldmljZSBpcyBhbHJlYWR5
IGF0dGFjaGVkIik7DQo+PiArICAgICAgICAgICAgdmZpb19wdXRfZ3JvdXAoZ3JvdXApOw0KPj4g
KyAgICAgICAgICAgIHJldHVybiAtRUJVU1k7DQo+PiArICAgICAgICB9DQo+PiArICAgIH0NCj4+
ICsgICAgcmV0ID0gdmZpb19nZXRfZGV2aWNlKGdyb3VwLCBuYW1lLCB2YmFzZWRldiwgZXJycCk7
DQo+PiArICAgIGlmIChyZXQpIHsNCj4+ICsgICAgICAgIHZmaW9fcHV0X2dyb3VwKGdyb3VwKTsN
Cj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICByZXR1cm4gcmV0Ow0KPj4gK30NCj4+ICsNCj4+ICt2
b2lkIHZmaW9fZGV0YWNoX2RldmljZShWRklPRGV2aWNlICp2YmFzZWRldikNCj4+ICt7DQo+PiAr
ICAgIFZGSU9Hcm91cCAqZ3JvdXAgPSB2YmFzZWRldi0+Z3JvdXA7DQo+PiArDQo+PiArICAgIHZm
aW9fcHV0X2Jhc2VfZGV2aWNlKHZiYXNlZGV2KTsNCj4+ICsgICAgdmZpb19wdXRfZ3JvdXAoZ3Jv
dXApOw0KPj4gK30NCj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL3BjaS5jIGIvaHcvdmZpby9wY2ku
Yw0KPj4gaW5kZXggM2IyY2EzYzI0Yy4uZmU1Njc4OTg5MyAxMDA2NDQNCj4+IC0tLSBhL2h3L3Zm
aW8vcGNpLmMNCj4+ICsrKyBiL2h3L3ZmaW8vcGNpLmMNCj4+IEBAIC0yODI4LDEwICsyODI4LDEw
IEBAIHN0YXRpYyB2b2lkIHZmaW9fcG9wdWxhdGVfZGV2aWNlKFZGSU9QQ0lEZXZpY2UNCj4qdmRl
diwgRXJyb3IgKiplcnJwKQ0KPj4NCj4+ICAgc3RhdGljIHZvaWQgdmZpb19wdXRfZGV2aWNlKFZG
SU9QQ0lEZXZpY2UgKnZkZXYpDQo+PiAgIHsNCj4+ICsgICAgdmZpb19kZXRhY2hfZGV2aWNlKCZ2
ZGV2LT52YmFzZWRldik7DQo+PiArDQo+PiAgICAgICBnX2ZyZWUodmRldi0+dmJhc2VkZXYubmFt
ZSk7DQo+PiAgICAgICBnX2ZyZWUodmRldi0+bXNpeCk7DQo+PiAtDQo+PiAtICAgIHZmaW9fcHV0
X2Jhc2VfZGV2aWNlKCZ2ZGV2LT52YmFzZWRldik7DQo+PiAgIH0NCj4+DQo+PiAgIHN0YXRpYyB2
b2lkIHZmaW9fZXJyX25vdGlmaWVyX2hhbmRsZXIodm9pZCAqb3BhcXVlKQ0KPj4gQEAgLTI5Nzgs
MTMgKzI5NzgsOSBAQCBzdGF0aWMgdm9pZCB2ZmlvX3JlYWxpemUoUENJRGV2aWNlICpwZGV2LCBF
cnJvcg0KPioqZXJycCkNCj4+ICAgew0KPj4gICAgICAgVkZJT1BDSURldmljZSAqdmRldiA9IFZG
SU9fUENJKHBkZXYpOw0KPj4gICAgICAgVkZJT0RldmljZSAqdmJhc2VkZXYgPSAmdmRldi0+dmJh
c2VkZXY7DQo+PiAtICAgIFZGSU9EZXZpY2UgKnZiYXNlZGV2X2l0ZXI7DQo+PiAtICAgIFZGSU9H
cm91cCAqZ3JvdXA7DQo+PiAtICAgIGNoYXIgKnRtcCwgKnN1YnN5cywgZ3JvdXBfcGF0aFtQQVRI
X01BWF0sICpncm91cF9uYW1lOw0KPj4gKyAgICBjaGFyICp0bXAsICpzdWJzeXM7DQo+PiAgICAg
ICBFcnJvciAqZXJyID0gTlVMTDsNCj4+IC0gICAgc3NpemVfdCBsZW47DQo+PiAgICAgICBzdHJ1
Y3Qgc3RhdCBzdDsNCj4+IC0gICAgaW50IGdyb3VwaWQ7DQo+PiAgICAgICBpbnQgaSwgcmV0Ow0K
Pj4gICAgICAgYm9vbCBpc19tZGV2Ow0KPj4gICAgICAgY2hhciB1dWlkW1VVSURfRk1UX0xFTl07
DQo+PiBAQCAtMzAxNSwzOSArMzAxMSw2IEBAIHN0YXRpYyB2b2lkIHZmaW9fcmVhbGl6ZShQQ0lE
ZXZpY2UgKnBkZXYsIEVycm9yDQo+KiplcnJwKQ0KPj4gICAgICAgdmJhc2VkZXYtPnR5cGUgPSBW
RklPX0RFVklDRV9UWVBFX1BDSTsNCj4+ICAgICAgIHZiYXNlZGV2LT5kZXYgPSBERVZJQ0UodmRl
dik7DQo+Pg0KPj4gLSAgICB0bXAgPSBnX3N0cmR1cF9wcmludGYoIiVzL2lvbW11X2dyb3VwIiwg
dmJhc2VkZXYtPnN5c2ZzZGV2KTsNCj4+IC0gICAgbGVuID0gcmVhZGxpbmsodG1wLCBncm91cF9w
YXRoLCBzaXplb2YoZ3JvdXBfcGF0aCkpOw0KPj4gLSAgICBnX2ZyZWUodG1wKTsNCj4+IC0NCj4+
IC0gICAgaWYgKGxlbiA8PSAwIHx8IGxlbiA+PSBzaXplb2YoZ3JvdXBfcGF0aCkpIHsNCj4+IC0g
ICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJycCwgbGVuIDwgMCA/IGVycm5vIDogRU5BTUVUT09M
T05HLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAibm8gaW9tbXVfZ3JvdXAgZm91bmQi
KTsNCj4+IC0gICAgICAgIGdvdG8gZXJyb3I7DQo+PiAtICAgIH0NCj4+IC0NCj4+IC0gICAgZ3Jv
dXBfcGF0aFtsZW5dID0gMDsNCj4+IC0NCj4+IC0gICAgZ3JvdXBfbmFtZSA9IGJhc2VuYW1lKGdy
b3VwX3BhdGgpOw0KPj4gLSAgICBpZiAoc3NjYW5mKGdyb3VwX25hbWUsICIlZCIsICZncm91cGlk
KSAhPSAxKSB7DQo+PiAtICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIGVycm5vLCAiZmFp
bGVkIHRvIHJlYWQgJXMiLCBncm91cF9wYXRoKTsNCj4+IC0gICAgICAgIGdvdG8gZXJyb3I7DQo+
PiAtICAgIH0NCj4+IC0NCj4+IC0gICAgdHJhY2VfdmZpb19yZWFsaXplKHZiYXNlZGV2LT5uYW1l
LCBncm91cGlkKTsNCj4+IC0NCj4+IC0gICAgZ3JvdXAgPSB2ZmlvX2dldF9ncm91cChncm91cGlk
LCBwY2lfZGV2aWNlX2lvbW11X2FkZHJlc3Nfc3BhY2UocGRldiksDQo+ZXJycCk7DQo+PiAtICAg
IGlmICghZ3JvdXApIHsNCj4+IC0gICAgICAgIGdvdG8gZXJyb3I7DQo+PiAtICAgIH0NCj4+IC0N
Cj4+IC0gICAgUUxJU1RfRk9SRUFDSCh2YmFzZWRldl9pdGVyLCAmZ3JvdXAtPmRldmljZV9saXN0
LCBuZXh0KSB7DQo+PiAtICAgICAgICBpZiAoc3RyY21wKHZiYXNlZGV2X2l0ZXItPm5hbWUsIHZi
YXNlZGV2LT5uYW1lKSA9PSAwKSB7DQo+PiAtICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAi
ZGV2aWNlIGlzIGFscmVhZHkgYXR0YWNoZWQiKTsNCj4+IC0gICAgICAgICAgICB2ZmlvX3B1dF9n
cm91cChncm91cCk7DQo+PiAtICAgICAgICAgICAgZ290byBlcnJvcjsNCj4+IC0gICAgICAgIH0N
Cj4+IC0gICAgfQ0KPj4gLQ0KPj4gICAgICAgLyoNCj4+ICAgICAgICAqIE1lZGlhdGVkIGRldmlj
ZXMgKm1pZ2h0KiBvcGVyYXRlIGNvbXBhdGlibHkgd2l0aCBkaXNjYXJkaW5nIG9mIFJBTSwNCj5i
dXQNCj4+ICAgICAgICAqIHdlIGNhbm5vdCBrbm93IGZvciBjZXJ0YWluLCBpdCBkZXBlbmRzIG9u
IHdoZXRoZXIgdGhlIG1kZXYgdmVuZG9yDQo+ZHJpdmVyDQo+PiBAQCAtMzA2NSw3ICszMDI4LDYg
QEAgc3RhdGljIHZvaWQgdmZpb19yZWFsaXplKFBDSURldmljZSAqcGRldiwgRXJyb3IgKiplcnJw
KQ0KPj4gICAgICAgaWYgKHZiYXNlZGV2LT5yYW1fYmxvY2tfZGlzY2FyZF9hbGxvd2VkICYmICFp
c19tZGV2KSB7DQo+PiAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAieC1iYWxsb29uLWFsbG93
ZWQgb25seSBwb3RlbnRpYWxseSBjb21wYXRpYmxlICINCj4+ICAgICAgICAgICAgICAgICAgICAg
ICJ3aXRoIG1kZXYgZGV2aWNlcyIpOw0KPj4gLSAgICAgICAgdmZpb19wdXRfZ3JvdXAoZ3JvdXAp
Ow0KPj4gICAgICAgICAgIGdvdG8gZXJyb3I7DQo+PiAgICAgICB9DQo+Pg0KPj4gQEAgLTMwNzYs
MTAgKzMwMzgsMTAgQEAgc3RhdGljIHZvaWQgdmZpb19yZWFsaXplKFBDSURldmljZSAqcGRldiwg
RXJyb3INCj4qKmVycnApDQo+PiAgICAgICAgICAgbmFtZSA9IGdfc3RyZHVwKHZiYXNlZGV2LT5u
YW1lKTsNCj4+ICAgICAgIH0NCj4+DQo+PiAtICAgIHJldCA9IHZmaW9fZ2V0X2RldmljZShncm91
cCwgbmFtZSwgdmJhc2VkZXYsIGVycnApOw0KPj4gKyAgICByZXQgPSB2ZmlvX2F0dGFjaF9kZXZp
Y2UobmFtZSwgdmJhc2VkZXYsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwY2lf
ZGV2aWNlX2lvbW11X2FkZHJlc3Nfc3BhY2UocGRldiksIGVycnApOw0KPj4gICAgICAgZ19mcmVl
KG5hbWUpOw0KPj4gICAgICAgaWYgKHJldCkgew0KPj4gLSAgICAgICAgdmZpb19wdXRfZ3JvdXAo
Z3JvdXApOw0KPj4gICAgICAgICAgIGdvdG8gZXJyb3I7DQo+PiAgICAgICB9DQo+Pg0KPj4gQEAg
LTMzMDQsNyArMzI2Niw2IEBAIGVycm9yOg0KPj4gICBzdGF0aWMgdm9pZCB2ZmlvX2luc3RhbmNl
X2ZpbmFsaXplKE9iamVjdCAqb2JqKQ0KPj4gICB7DQo+PiAgICAgICBWRklPUENJRGV2aWNlICp2
ZGV2ID0gVkZJT19QQ0kob2JqKTsNCj4+IC0gICAgVkZJT0dyb3VwICpncm91cCA9IHZkZXYtPnZi
YXNlZGV2Lmdyb3VwOw0KPj4NCj4+ICAgICAgIHZmaW9fZGlzcGxheV9maW5hbGl6ZSh2ZGV2KTsN
Cj4+ICAgICAgIHZmaW9fYmFyc19maW5hbGl6ZSh2ZGV2KTsNCj4+IEBAIC0zMzE4LDcgKzMyNzks
NiBAQCBzdGF0aWMgdm9pZCB2ZmlvX2luc3RhbmNlX2ZpbmFsaXplKE9iamVjdCAqb2JqKQ0KPj4g
ICAgICAgICogZ19mcmVlKHZkZXYtPmlnZF9vcHJlZ2lvbik7DQo+PiAgICAgICAgKi8NCj4+ICAg
ICAgIHZmaW9fcHV0X2RldmljZSh2ZGV2KTsNCj4NCj5QbGVhc2UgcmViYXNlIHYyIG9uIHZmaW8t
bmV4dC4gSSBtZXJnZWQgeW91ciBwYXRjaCBzaW5jZSA6KQ0KDQpTdXJlLCB3aWxsIGRvLiBNYXli
ZSB3aWxsIGJlIGEgbGl0dGxlIGxhdGUuIFdlIHdpbGwgaGF2ZSBuYXRpb25hbCBob2xpZGF5IGJl
dHdlZW4gU2VwIDI5IGFuZCBPY3QgNi4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K

