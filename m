Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D8873D831
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 09:04:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDgFZ-0004YW-OI; Mon, 26 Jun 2023 03:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qDgFT-0004YD-U5
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:02:56 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qDgFO-0007zh-2X
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687762970; x=1719298970;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=U1FTxpPrKyZpvgYQvcxdq68btv9beui5CAIwl8M7kok=;
 b=Q4N9LBRVMfL+tajugXjCZiLcVADzPeZ291NZmtFgijjpKFkdQ21/SL2p
 W3izuz1cD+3JrPlXigD8Pb5Jt0gPBDSQ30VA7cZWdA4G1+uXYFd9KGjGO
 SYYftdhdA/34ONi5Kv7mIZJaXavxEJE6NK/GaACR2YDHy0l7c0EFzhl+U
 6GYLVySXrDsTG01yu9dmSQU3mrI8hLPXYuzhdfB7nRYaDuhHHkllMs3Lh
 0u43pJSQdU0MITqnloQ/0XIuKgkTKan+PFscH6tOfuo+zXnln+3fB9arr
 A13njPz16urH9i4e2d51hURCMSGdqHG2h3Liddsp6Y5a2We6xmURPHBLM w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="358686961"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; d="scan'208";a="358686961"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2023 00:02:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="962671585"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; d="scan'208";a="962671585"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga006.fm.intel.com with ESMTP; 26 Jun 2023 00:02:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 00:02:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 00:02:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 00:02:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 00:02:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYTC/ZpFF694S4aEeRg4VWRaFQR0/ZM85vjfm4hrDqDXU6OhNJ9XB4e1J4Tecyz3nE5dqDdQvxffO/Zuw43hA0AvGnLQyPRB6fRc+4Cm36J6eNaedMqF9AMpJL2pmuDN41a2K/cmfOeXBKciJvfhXJ+/HB2IxHCE0cD9v/YU5pYvWlwX4vkL8leWCbOcrKt89LHEoqad+vzURZAXR5B/bzIWzSdPeM4S9IDaBx+8bVi77I1ZryCEy/kWM6sB04O7HWfAPc3mE8xymS3Ubz+PMICETddsQp6ZlzyfPu/WzmhLsnUplG6axCp6ISWKCH7kkk5FlYjK65t0UjHV/KOYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1FTxpPrKyZpvgYQvcxdq68btv9beui5CAIwl8M7kok=;
 b=GEdoLPNgCJ9hLNXFMN/5k1VoH0YkpKn2H6yffmQiisOl7Ef6FKA/QkX+G0LcluH9vr8KyDkl3OnfYmXL9xNzYKoTTWi3wIeSBnMenIN1k4uzEPFV19CA+HsglfWbgA2oACxWcqFeZZ1d0ykcxM8dkcXI8AxMbmglOKoGOahHALCZ2+rcaPsZYMIVLVAIYdkHRjl8aEjYenu9Ec598tmBgkGNY18BoRiy8vunm/LFYcb4laAiP9pXWN6bsZJyAfHBylQEdz9RdSH0qOLFilnv9DxrSj+UkpubQemVL51AdNMjcAFC+nafi81zMZQ2XrPkN+xT24VIKhBycqh25UjoFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB7245.namprd11.prod.outlook.com (2603:10b6:208:42f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 07:02:37 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%5]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 07:02:37 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 1/3] vfio/pci: Fix resource leak in vfio_realize
Thread-Topic: [PATCH v3 1/3] vfio/pci: Fix resource leak in vfio_realize
Thread-Index: AQHZpBh99h+ohEs6RE+cMJ5+wAFWM6+VGTEAgAXtPLCAAaJjAA==
Date: Mon, 26 Jun 2023 07:02:36 +0000
Message-ID: <SJ0PR11MB6744837FBCEAB1F9060BBAFD9226A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230621080204.420723-1-zhenzhong.duan@intel.com>
 <20230621080204.420723-2-zhenzhong.duan@intel.com>
 <88aa1fc0-edf4-a98e-0cbb-fcf312b3b19e@oracle.com>
 <SJ0PR11MB67441D1922E854785F2FED3D9221A@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB67441D1922E854785F2FED3D9221A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB7245:EE_
x-ms-office365-filtering-correlation-id: df3d0736-d203-4495-bb96-08db761352c2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nlh+n1fbzRq3ixmvhzoDvEsgDX8xQB32Qa5Kc1NveRT4mJn1/TPL6o6UpUq+erk0C59hXYzBjQEo0Mk6decLrAaP0dLFjj2U2cU3Dq1FwPE5kFn844eH2kDqExwSv9ERbdod658z0qLQ6nO6LSrgbOW1Vlb9HVdOD973O11YIO6n14wULcvLiojn6YqsbTiEAlvVTYEBYXHiOHb/h4cIiMVtRN+3XLp9TTsbSeWO+csgPTJ5IHuIIBqoeLMjbqL3a7iIr9sQ6M9tLRq7+V8c7Akyx06Fj/NlkejsC8qkQlO/wY+o9UWYAIvQ30P7h8Ry9lp0cl920r9EiD7iEzsYkcF09f3De4j8rgZWBDRi5nUgO5Ej9ms9ytYGj3Eb+ZZ4s+oMLbYPqAvlHqnnHS96YApb2rCq82KZPvfthbm2tWDDhysfWprC4An8PkUf47OvyokN/7Zon+bOkv4c+kPPvav4NhKxvXYzv1K/iFk+zQkbx9LZVWuPbYKYLQhcxKtmAMxCpGTC45GBgzzsbnstq8HUnjdoaj2H3BArnaPMelacQmQaT2BYq/plOJDFI/6oP1bZXVD2lw2OCUWoiijoowpT4gL4ZlTFOTe1YaQo5vImp0TJLImB0Kr8aowOAQ9k
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(33656002)(52536014)(5660300002)(41300700001)(316002)(86362001)(66476007)(6916009)(64756008)(8936002)(8676002)(38070700005)(66446008)(66556008)(76116006)(4326008)(38100700002)(122000001)(55016003)(66946007)(82960400001)(107886003)(26005)(6506007)(2906002)(9686003)(186003)(7696005)(71200400001)(478600001)(54906003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2E3dEh4eVh0VUdnMmZGeDhVTmg0TmhFcW4wYSt2eEl5cWtJYnViVS91T1hk?=
 =?utf-8?B?dEppdWxkeHBqa0xzaFBDOUVJc2RjOUhEbzlxRXVROHBlSDk5WXFUTzVBWXFa?=
 =?utf-8?B?dTU1UDBsaW44clhKUUZYN0dOZ1dxekRCSEcyV2U1aTZJQlZDQWhaL0o4OEx0?=
 =?utf-8?B?RkFNWHRlejZSS0cxR1ZjTjBnWkdhRzd5MW1jSWd6QmRDZU1BUHl2cUVnQjJG?=
 =?utf-8?B?a04vUjRzaEJjMzU5Nm50d0RPNGpmbXZVTmdjSklrRDBXaklOa3R0TG1rUTJF?=
 =?utf-8?B?eGcwZm1SUlB2a0xFTUJiSXRlK3FialhHNFVnM0JoeWJ0UUlXYllNV0owMnRS?=
 =?utf-8?B?T0RxUWQxY2NRb1g1eFp4VjljSUcrYjhuRlVybmJIV3Fra3VrNHowenpJeE9N?=
 =?utf-8?B?OUVmamt0OStQcTNCYXBHT3hra1Q2TTlWUGJocXJ6d1d3L0xMNWhNQncwZmJT?=
 =?utf-8?B?WHYzeGRPYTREdWVZTlYwZkwxcjRISGQ3S3A5akpkL0diZXBkZGxsMFFJMVdh?=
 =?utf-8?B?djd3S2dWSWpoSUV5ZVEyeWNOdjVXN0lXR1hFNHpMZjkwS2NvOWMvRHVMaVNN?=
 =?utf-8?B?SjNudjVFdGJ3WWVpeDVidmx1SldKTzg0NFdVSXcyK0IwZU02Q0QzNWl6b0hD?=
 =?utf-8?B?ekRNZzZOeXMyS3dYZFhubjJOWXBDb2pVQkRJbEIxOG1GRkhUQW9sUzVnTm1t?=
 =?utf-8?B?MXMvZDJrME1zR0ZxTWEzRnQxZHN5SERZWjN6ZFEyT3hCWjJwSHZyL0xyZmQ2?=
 =?utf-8?B?QjMraGg1NEFRYWgrUjFLVDd1bnFiWlJKRUR1QjBuTDROcjN3NE1zazMrallk?=
 =?utf-8?B?NlhKTS9OZ05iZ0J2dUtldTRKeVdoc0lyMWsvd3RHU3ZkYmpnbEhHakU2VTBF?=
 =?utf-8?B?UldWSndpN3V4blh4RjBrSGk3Z093V3BXbk1WQmh6czZEOWlOMm44MklEbkdC?=
 =?utf-8?B?NVNPSHNyeExRcHRWVFg1MjI1UEdsWDRHSnVxTjlxUWdkdnN0dlNjcVRDTS9n?=
 =?utf-8?B?NWxnNE4yRjVsd1MvYmVraW1VMWtzem1MWmpxS1lqdVU1SDJZRWxMeFkyc1FL?=
 =?utf-8?B?ODNWYWhla01QeFFiTW9YWXVobmVQUjRka2gwRUUwS3dTb3gwdFJKc1BzS1o4?=
 =?utf-8?B?ak9nTEpZdmIwYUcyVnFYNXh5b0VJU2xsWkRYRzR6Q24rQ3BjYStiRjlYQzl6?=
 =?utf-8?B?UHpya1pBVGwyMkdaZTdOeUVGS3BianVUN3hqeWhkc1VQeVJRY1NDZHdLSGZa?=
 =?utf-8?B?LzNXRFlDRndUU3M3QUZVcGxzV2swZlBLTStOQUd1NXljdUdaYjRRcml1MTN2?=
 =?utf-8?B?anBoVkQ2RStXQU1IWkVQZTFQVGJUOCtFanoxNHRPZHJMbjUwUWtIT042Nms3?=
 =?utf-8?B?YnI5MlRsbUZUMlFwR2xnNVFwV0ViYlkxMFROcFhkWTNjRWxXTFQwdWI1R1VH?=
 =?utf-8?B?b0ErM1h5OXpyTkRzTkRaMlU5SjFqZThoUlNGaVNOSk9CZmVqeTM3dFNxbzNL?=
 =?utf-8?B?T3VDVTZlR0VWTUVPS0ZuRHNQU0R5RnNvT2ZGMENlZVRxdjFLMWFoazltSUJq?=
 =?utf-8?B?aS9OYThyRGhmencwZWN4OHhSUFVycjUxQnJjamx2cTQ2MlgvbEZ1VFQwOEtR?=
 =?utf-8?B?UGZXTmppbjZiKzAxcGtJQ3daYU9HMHlVVE9IYTIyYWdjSW5ES3pnL0tjRnJh?=
 =?utf-8?B?ZVVPbUF1YmtJSm9ldzExNTd0elNJTGttWFk4ZHpibGVxeXhkQXRTRWNZS0px?=
 =?utf-8?B?V1NzODE2aG1QTnVuK0NuOUZNcFExdHFIeVR0SlhHWU1kcmRsTitaSTViVGVD?=
 =?utf-8?B?YU85QjNPVUYzMTVWSkxuZFVQU0RiWldUcFVyemhScDR6UU42Uk1UY3dPSnJk?=
 =?utf-8?B?Sk9lNXBiL1MxRHlUZTE4UDhGNlg2MTFyNEIrU3o3aFdEQlJzUGl4eFlOeVk1?=
 =?utf-8?B?ODNVdlR2ZDNDYzQyQzYwcTRTM3pUa2dmdE5IK2hSUHJWVlFyQ05Za2lBK1Yr?=
 =?utf-8?B?b0ZCS2RaS3JGSXgxN3RxaUUyK2RFeWo3anJRcTZpa3cvNzVvSlRIYXlYUUc5?=
 =?utf-8?B?NlJsVVJpR3hLWTNLdjNmVStkZ1VjM0pSU0Myejh1ZS8xTjRHYXYwYWZLdzJn?=
 =?utf-8?Q?UEAY2VvH62JC/Ve2Qs+6fnCs6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3d0736-d203-4495-bb96-08db761352c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 07:02:36.7569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kD0cSRzmrz4qQ2pgCbd+3nJJXH5N4kmS1rnRV/VtdC1JtvYUvP4Iqu2WTzPyxl1vBgoy08h1XgGPmyWODs7wVvlFOmBoRnKOjkyBioSr0lI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7245
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=zhenzhong.duan@intel.com; helo=mga11.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRHVhbiwgWmhlbnpob25nDQo+U2Vu
dDogU3VuZGF5LCBKdW5lIDI1LCAyMDIzIDI6MDEgUE0NCj5UbzogSm9hbyBNYXJ0aW5zIDxqb2Fv
Lm0ubWFydGluc0BvcmFjbGUuY29tPg0KPkNjOiBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsg
Y2xnQHJlZGhhdC5jb207IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj5hdmloYWloQG52aWRpYS5j
b207IFBlbmcsIENoYW8gUCA8Y2hhby5wLnBlbmdAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJFOiBb
UEFUQ0ggdjMgMS8zXSB2ZmlvL3BjaTogRml4IHJlc291cmNlIGxlYWsgaW4gdmZpb19yZWFsaXpl
DQo+DQo+Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PkZyb206IEpvYW8gTWFydGlucyA8
am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj4+U2VudDogV2VkbmVzZGF5LCBKdW5lIDIxLCAy
MDIzIDc6MDggUE0NCj4+VG86IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwu
Y29tPg0KPj5DYzogYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207IGNsZ0ByZWRoYXQuY29tOyBx
ZW11LQ0KPmRldmVsQG5vbmdudS5vcmc7DQo+PmF2aWhhaWhAbnZpZGlhLmNvbTsgUGVuZywgQ2hh
byBQIDxjaGFvLnAucGVuZ0BpbnRlbC5jb20+DQo+PlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS8z
XSB2ZmlvL3BjaTogRml4IHJlc291cmNlIGxlYWsgaW4gdmZpb19yZWFsaXplDQo+Pg0KPj4NCj4+
DQo+Pk9uIDIxLzA2LzIwMjMgMDk6MDIsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+IFdoZW4g
YWRkaW5nIG1pZ3JhdGlvbiBibG9ja2VyIGZhaWxlZCBpbiB2ZmlvX21pZ3JhdGlvbl9yZWFsaXpl
KCksDQo+Pj4gaG90cGx1ZyB3aWxsIGZhaWwgYW5kIHdlIHNlZSBiZWxvdzoNCj4+Pg0KPj4+IChx
ZW11KSBkZXZpY2VfYWRkDQo+Pj4gdmZpby1wY2ksaG9zdD04MToxMS4xLGlkPXZmaW8xLGJ1cz1y
b290MSx4LWVuYWJsZS1taWdyYXRpb249dHJ1ZQ0KPj4+IDAwMDA6ODE6MTEuMTogVkZJTyBtaWdy
YXRpb24gaXMgbm90IHN1cHBvcnRlZCBpbiBrZXJuZWwNCj4+PiBFcnJvcjogZGlzYWxsb3dpbmcg
bWlncmF0aW9uIGJsb2NrZXIgKC0tb25seS1taWdyYXRhYmxlKSBmb3I6IFZGSU8NCj4+PiBkZXZp
Y2UgZG9lc24ndCBzdXBwb3J0IG1pZ3JhdGlvbg0KPj4+DQo+Pj4gSWYgd2UgaG90cGx1ZyBhZ2Fp
biB3ZSBzaG91bGQgc2VlIHNhbWUgbG9nIGFzIGFib3ZlLCBidXQgd2Ugc2VlOg0KPj4+IChxZW11
KSBkZXZpY2VfYWRkDQo+Pj4gdmZpby1wY2ksaG9zdD04MToxMS4wLGlkPXZmaW8wLGJ1cz1yb290
MCx4LWVuYWJsZS1taWdyYXRpb249dHJ1ZQ0KPj4+IEVycm9yOiB2ZmlvIDAwMDA6ODE6MTEuMDog
ZGV2aWNlIGlzIGFscmVhZHkgYXR0YWNoZWQNCj4+Pg0KPj4+IFRoYXQncyBiZWNhdXNlIHNvbWUg
cmVmZXJlbmNlcyB0byBWRklPIGRldmljZSBpc24ndCByZWxlYXNlZCwgd2UNCj4+PiBzaG91bGQg
Y2hlY2sgcmV0dXJuIHZhbHVlIG9mIHZmaW9fbWlncmF0aW9uX3JlYWxpemUoKSBhbmQgcmVsZWFz
ZSB0aGUNCj4+PiByZWZlcmVuY2VzLCB0aGVuIFZGSU8gZGV2aWNlIHdpbGwgYmUgdHJ1ZWx5IHJl
bGVhc2VkIHdoZW4gaG90cGx1Zw0KPj4+IGZhaWxlZC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6
IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4gLS0tDQo+Pj4g
IGh3L3ZmaW8vcGNpLmMgfCAxICsNCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
DQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9wY2kuYyBiL2h3L3ZmaW8vcGNpLmMgaW5k
ZXgNCj4+PiA3Mzg3NGE5NGRlMTIuLmM3MWIwOTU1ZDgxYyAxMDA2NDQNCj4+PiAtLS0gYS9ody92
ZmlvL3BjaS5jDQo+Pj4gKysrIGIvaHcvdmZpby9wY2kuYw0KPj4+IEBAIC0zMjEwLDYgKzMyMTAs
NyBAQCBzdGF0aWMgdm9pZCB2ZmlvX3JlYWxpemUoUENJRGV2aWNlICpwZGV2LCBFcnJvcg0KPj4q
KmVycnApDQo+Pj4gICAgICAgICAgcmV0ID0gdmZpb19taWdyYXRpb25fcmVhbGl6ZSh2YmFzZWRl
diwgZXJycCk7DQo+Pj4gICAgICAgICAgaWYgKHJldCkgew0KPj4+ICAgICAgICAgICAgICBlcnJv
cl9yZXBvcnQoIiVzOiBNaWdyYXRpb24gZGlzYWJsZWQiLCB2YmFzZWRldi0+bmFtZSk7DQo+Pj4g
KyAgICAgICAgICAgIGdvdG8gb3V0X2RlcmVnaXN0ZXI7DQo+Pj4gICAgICAgICAgfQ0KPj4+ICAg
ICAgfQ0KPj4+DQo+PlRoaXMgZG9lc24ndCBsb29rIHJpZ2h0LiBUaGlzIG1lYW5zIHRoYXQgZmFp
bHVyZSB0byBzdXBwb3J0IG1pZ3JhdGlvbg0KPj53aWxsIGRlcmVnaXN0ZXIgdGhlIGRldmljZS4N
Cj4NCj5JbiBteSB1bmRlcnN0YW5kaW5nLCBmYWlsdXJlIHRvIHN1cHBvcnQgbWlncmF0aW9uIGJ1
dCBzdWNjZXNzIHRvIGFkZA0KPm1pZ3JhdGlvbiBibG9ja2VyIHdpbGwgbm90IGRlcmVnaXN0ZXIg
ZGV2aWNlLiB2ZmlvX21pZ3JhdGlvbl9yZWFsaXplKCkgaXMNCj5zdWNjZXNzZnVsIGluIHRoaXMg
Y2FzZS4NCj5CdXQgZmFpbHVyZSB0byBhZGQgbWlncmF0aW9uIGJsb2NrZXIgc2hvdWxkIGRlcmVn
aXN0ZXIgZGV2aWNlLCBiZWNhdXNlDQo+dmZpb19leGl0Zm4oKSBpcyBuZXZlciBjYWxsZWQgaW4g
dGhpcyBjYXNlKGVycnAgc2V0KSwganVtcGluZyB0byBvdXRfZGVyZWdpc3RlciBpcw0KPnRoZSBi
ZXN0IGNob2ljZS4gVGhlbiB2ZmlvX21pZ3JhdGlvbl9yZWFsaXplKCkgc2hvdWxkIHJldHVybiBm
YWlsdXJlIGluIHRoaXMNCj5jYXNlLg0KDQpJIGp1c3QgcmVhbGl6ZWQgdGhlIGVycm9yIHBhdGgg
aW4gdmZpb19yZWFsaXplKCkgaXNuJ3QgYWRlcXVhdGUuIFdlIG5lZWQgdG8gYWRkIG1vcmUgZGVy
ZWdpc3RlciBjb2RlIGp1c3QgYXMgdmZpb19leGl0Zm4oKSwgc2VlIGJlbG93LiBJJ2xsIHJlLXBv
c3QgYWZ0ZXIgd2UgYXJlIGNvbnNlbnN1cyBvbiB0aGlzIGFuZCBnZXQgc29tZSBjb21tZW50cyBv
ZiBQQVRDSDMuDQoNCi0tLSBhL2h3L3ZmaW8vcGNpLmMNCisrKyBiL2h3L3ZmaW8vcGNpLmMNCkBA
IC0zMjEwLDcgKzMyMTAsNyBAQCBzdGF0aWMgdm9pZCB2ZmlvX3JlYWxpemUoUENJRGV2aWNlICpw
ZGV2LCBFcnJvciAqKmVycnApDQogICAgICAgICByZXQgPSB2ZmlvX21pZ3JhdGlvbl9yZWFsaXpl
KHZiYXNlZGV2LCBlcnJwKTsNCiAgICAgICAgIGlmIChyZXQpIHsNCiAgICAgICAgICAgICBlcnJv
cl9yZXBvcnQoIiVzOiBNaWdyYXRpb24gZGlzYWJsZWQiLCB2YmFzZWRldi0+bmFtZSk7DQotICAg
ICAgICAgICAgZ290byBvdXRfZGVyZWdpc3RlcjsNCisgICAgICAgICAgICBnb3RvIG91dF92Zmlv
X21pZ3JhdGlvbjsNCiAgICAgICAgIH0NCiAgICAgfQ0KDQpAQCAtMzIyMCwxMSArMzIyMCwxNyBA
QCBzdGF0aWMgdm9pZCB2ZmlvX3JlYWxpemUoUENJRGV2aWNlICpwZGV2LCBFcnJvciAqKmVycnAp
DQoNCiAgICAgcmV0dXJuOw0KDQorb3V0X3ZmaW9fbWlncmF0aW9uOg0KKyAgICB2ZmlvX21pZ3Jh
dGlvbl9leGl0KHZiYXNlZGV2KTsNCiBvdXRfZGVyZWdpc3RlcjoNCiAgICAgcGNpX2RldmljZV9z
ZXRfaW50eF9yb3V0aW5nX25vdGlmaWVyKCZ2ZGV2LT5wZGV2LCBOVUxMKTsNCiAgICAgaWYgKHZk
ZXYtPmlycWNoaXBfY2hhbmdlX25vdGlmaWVyLm5vdGlmeSkgew0KICAgICAgICAga3ZtX2lycWNo
aXBfcmVtb3ZlX2NoYW5nZV9ub3RpZmllcigmdmRldi0+aXJxY2hpcF9jaGFuZ2Vfbm90aWZpZXIp
Ow0KICAgICB9DQorICAgIHZmaW9fZGlzYWJsZV9pbnRlcnJ1cHRzKHZkZXYpOw0KKyAgICBpZiAo
dmRldi0+aW50eC5tbWFwX3RpbWVyKSB7DQorICAgICAgICB0aW1lcl9mcmVlKHZkZXYtPmludHgu
bW1hcF90aW1lcik7DQorICAgIH0NCiBvdXRfdGVhcmRvd246DQogICAgIHZmaW9fdGVhcmRvd25f
bXNpKHZkZXYpOw0KICAgICB2ZmlvX2JhcnNfZXhpdCh2ZGV2KTsNCg0KVGhhbmtzDQpaaGVuemhv
bmcNCg==

