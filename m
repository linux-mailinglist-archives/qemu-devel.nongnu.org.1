Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB7C73CEA0
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 08:02:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDIoB-0006Wx-Le; Sun, 25 Jun 2023 02:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qDIo7-0006Wk-Iw
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 02:01:07 -0400
Received: from mga18.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qDIo2-0006yV-DT
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 02:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687672862; x=1719208862;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vmCuTWlwoQZk+NxdOzG1clpDC04s4FJV2DLOnHvoOsg=;
 b=IZLtRxdqykjMTRrayLr46nzcB1NWMhP4cEle2hA42Q23/kuS/Pl/8Y76
 gpKYRG0PbHVxwHNPKNAN05YjA2h/34BcSrDbqCJnOucCy4f7/hmWXd0ot
 eTsectZTLGM26+2qBnejY2t3TuIZxSxhV6CVL2EPMFFCxhr34XYvgJGgt
 SZpGqSeFmbATvnJQ+mlRE9HUNs2r3ItHW4aI3WTwMlwXhVEgnN5QHTWB4
 RPugAJ57KXrams6wkjlrV3I9Wwo4kppktJVOBLPIA0Zz5JL3Gg2z4pKNL
 7OldIaAKR23O94o/iL4Og4a6wmj5ZtghNpdR9IgAbAiC9tIP/audvnECm A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="345782542"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; d="scan'208";a="345782542"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2023 23:00:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="693099798"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; d="scan'208";a="693099798"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga006.jf.intel.com with ESMTP; 24 Jun 2023 23:00:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 24 Jun 2023 23:00:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 24 Jun 2023 23:00:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 24 Jun 2023 23:00:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVpoulUzuX1KQbl0ahGnuSa7Z/fxRqUa2sQJkIkiDzWtn8eGLmsK6z6rdHloVFhM50+HUxbzeOEI7A8QMZuK9z30jrkbg8hs7HWoTt9kfhDugAJbYoKGaLrrGvAhNOiMl3P2netDeRo8qE5WZ76+Qaq3mwR4TbrnDyiMQe+K3ZKH5665DU52d5S5Ota2sITYarTinf3Q3qmGqVOOifI+c3LvrDz7tSyL1JsbgOvokc8syhTqO8ky6W0iM3uW9cWXXbhbrgHUOhN1vBZaWnykuiORU/HcJ02nMLusEJsk2X3aznwvgDBrA3r9cBqgFDc/zgET+ykNFB93QSQszmKbww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmCuTWlwoQZk+NxdOzG1clpDC04s4FJV2DLOnHvoOsg=;
 b=T+ULcrkUcs51ybHX4j7ReEFy9SA5IyME1liwcKDMmcv5Qd4lAffdICITW3Q7tzYd8ieJizHlERbgpu8FiOxhsD7L9laDKdBbBPUt+FK3B9SvKDwLU7kGOVEesawbY3ieICquKm6dmqyG+ii49MA7NnQEf7eWGFRScEb+1XFjUVLFI9aIQVE8morkEZ25iwXJ9xm2Q7C4eZCia10kK3LZCESSs9U1zWuc1AQmkBsGYMXvnIm6FQt35YaDIA0IHnAPVSfPjp2OHEEdFqFvEqtY3asDyj7I+cCHcL5zkR3DOUsOP0H0lr+mIiXNQw2m9+JeX5QolsuwZlbRZPdIy6GePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB4973.namprd11.prod.outlook.com (2603:10b6:a03:2de::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 06:00:54 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%5]) with mapi id 15.20.6521.024; Sun, 25 Jun 2023
 06:00:54 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 1/3] vfio/pci: Fix resource leak in vfio_realize
Thread-Topic: [PATCH v3 1/3] vfio/pci: Fix resource leak in vfio_realize
Thread-Index: AQHZpBh99h+ohEs6RE+cMJ5+wAFWM6+VGTEAgAXtPLA=
Date: Sun, 25 Jun 2023 06:00:54 +0000
Message-ID: <SJ0PR11MB67441D1922E854785F2FED3D9221A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230621080204.420723-1-zhenzhong.duan@intel.com>
 <20230621080204.420723-2-zhenzhong.duan@intel.com>
 <88aa1fc0-edf4-a98e-0cbb-fcf312b3b19e@oracle.com>
In-Reply-To: <88aa1fc0-edf4-a98e-0cbb-fcf312b3b19e@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB4973:EE_
x-ms-office365-filtering-correlation-id: f6d6249a-75e7-4998-883a-08db754189a7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fDtvX/6irAGUGz8AHcPpj6E1ZDAbCqvJV1+azKiqHkkq4W9GPqUsPs70jAiuqvICKh0HFSIMeWVbRrz8Vr2raLw45pYZ/S84YKWBlM5FlMhIkwUGDOlQmwk8RBPgXnKPe61UabHZuhTr2ouYePmicnmBv9mMc2hvrak9wX66XqF6YOoDk+81qw7SOo1dCmbq7qiwfkZUhe2HrblFgPSib2WPglzujCLOAGbF0dmlT+fM6BV7YIE4sp20QjahH4Ykg81cTr+/nrwhfiW7kQXAcjQMdlKZ6n3iaFnb9hjd1sb25IiZLvd94FB7I+JK6WZpizszrrm4pFV7WaLTL3LMgej9Y9pwR76FqGZIbnSw2jNfNWL2v5v7wvt7BBewGH/+oTSR1mq57MZKyEoUYQ8TlUW5lcCb369EyxQvCl3afhisQeKxA5BKxkaEbL4/p1uqSYK2ltpSBHMqYwVfoFZfsHsP5CLhqVHDhq08VjuEMtBG4KPdGQ+yo+z5OGXbxbze0mtunVtQdDaQH564qoPO2EJp13eQqlJByIeAF3XoSqOONyCR9KZtiL3lQZz9a11xY5M+3Kj1HY4AvNbDWK9opvYfjqoqf0AGjR3v4lvnOQgHLEaoprvuJcP2RlX2yBXP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(107886003)(478600001)(7696005)(71200400001)(54906003)(83380400001)(6506007)(26005)(186003)(9686003)(2906002)(5660300002)(52536014)(33656002)(38100700002)(122000001)(76116006)(4326008)(66946007)(82960400001)(55016003)(8936002)(8676002)(41300700001)(316002)(86362001)(66476007)(6916009)(66556008)(64756008)(38070700005)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlkyVXRLRlFDVEVoZFpVTm56MnoyZjNKUGxCYVJaeUVOTDAzaDVNdGEwKzBz?=
 =?utf-8?B?RlZBb2hSM0RpeHloOVdkbGUrZWNvQWNhT2JVQmN4QmNEM3RlT2VOWHd3Vnln?=
 =?utf-8?B?RkxqOFFVTnd6bW1oMkw4Z0JpMzNIWUZzOFJVR1dUY2d0NXZ6T2pCb2lFLzlT?=
 =?utf-8?B?YnMxY1RQTmkwa0JCOU9iYmRMaFV2SHc1QmF1WlJYMk5PMHpPTExubmZ5anJQ?=
 =?utf-8?B?TEpvcG5tYklKUmFkU2RtNGJMamQyRHppOWhFMkpqY2dCMDU1aUFvU3FIU2Nh?=
 =?utf-8?B?elUxWnJZckRyZDhua1NnKzdkSS9nNXFoUFF0cHkwVWJYaWwzYWpWSDhidGVZ?=
 =?utf-8?B?a0Frek8yUWdsZG1XZVUzRjNIcU9HNkR6SkNULzRVTEhpQ283RWpadzlEdXRl?=
 =?utf-8?B?eFhLbm41NFVNOWQ1L3ViRVA3ZmsxL0xZNUdIbFdQcXA5bUc1NmdSUXFTUHNQ?=
 =?utf-8?B?ZTdrRzdHdjlvbWRGN3Nqb0NKZG1zWkYwNk9USXZWQThDS0hncU1IS0FFaENa?=
 =?utf-8?B?YnZFcmw1QzZDcXFPdjRnRXRLTjRaOCtsaWRLRnk4ZEtpSStacHBZbDRZTm4v?=
 =?utf-8?B?N0RtZi9NdFRSVy91TUZDYjNLYUducm10eW1BY2NLanFraERuTGorMktIajNR?=
 =?utf-8?B?MVhHQ0F0eHdYc1N2Qkxvb0lKWFJjb3o5VDhDRUJkOWkrTFRZOVdoZlpwRDdo?=
 =?utf-8?B?Qndyd1oyTDhQY2ZkUnBLcGxLOFRoWGJ5UjJuTk5wWXd0VFhHUTcrRHNNdjh2?=
 =?utf-8?B?SnM3RUpxcUR6SXliM3RLMlZjN3R2SnpMNzJLaHZjTTROcHRBRDlNckZDQjhx?=
 =?utf-8?B?Mys4YjBLVjJmQ0l5NUhtMWRKT0RnL0dnVmxHRUZCMUpHTGpvRlBZVGhLWUJY?=
 =?utf-8?B?SXFmK1B0ZUR5cjVETUhhSVNKZmU5VUJpZjJtVDNHZXRxYTFMak9IQ21tUEda?=
 =?utf-8?B?bE45WnV4QnpRWHJSN3Q4U2JnZEtwU2NhYWhtTXF3eDZSVDJPak5nUmFmaGtC?=
 =?utf-8?B?V0NiMFhaa2hNVVRLU09kdDlIN0xkZ0RvaWQvdW1lMDFDeTFiTHVYb1dCdnZ6?=
 =?utf-8?B?QjZUb3RObllsQ0ZiUitUZFdaU2pyWGRPRTRSZTI4cThYZFczaGRCT3YxNHBz?=
 =?utf-8?B?ME0xVmp4OGI0cVl3THVzalJ0T01yamJyaWcvOThGNG1jOUZqVjlGZU5PdkNq?=
 =?utf-8?B?YWkyYnZFSVo0SHJWVDl1dnZiREN1TWVPSWlEMmRId0tGQUlpYXRZRXE2VWdW?=
 =?utf-8?B?Q004SE94VmdpTVpvU1kwRi9UQjJQeE56TS9iNEtSWWhTdjVGU25jMDBxcnYz?=
 =?utf-8?B?YkxaT2NoOXhzOGZYYUFRKzRVcWpLS3NSMmhVcXNTblBndkZYbEN3cHpyWE1X?=
 =?utf-8?B?Z3RnR0Vwc1pJT3VwdnhHNGVVUjNkTmdRcDY3S0VXc2V2bk80aTh2OWdibytT?=
 =?utf-8?B?NmEybGFPVFpBeVpzcXdYalU1N2ZUNk9qZXRzOVpXK1BzamxIWnJOcEtrbVFH?=
 =?utf-8?B?TDk4ME93d0FrNEp4V3cydkJhUURRZER6bHNsT2IvMlhiRUN3aHBKd0YxS0tn?=
 =?utf-8?B?QzdFcnFyT3orVS94dC9lVmZZdDNMN0w2NDBUVE91V08vZEp3T29tYm9aOVcr?=
 =?utf-8?B?K0xMS2QraEV3SGlnMnZDblp1S2lzM1NZUE1pNEFXRGovR0M5cDBHYXEweTVV?=
 =?utf-8?B?cURUbUxZUHZPbDcrY3hDRFhBZmVXQWl6dEFSYmRLVTZ5N21LZnRraHp1QnJO?=
 =?utf-8?B?cFVZODVHZE5ZREVkcTdhNW1BeGNjZ2pzcmVFdFcyc0lZdGYrQlA3ejViYXRD?=
 =?utf-8?B?OGNTelhaWTBjdXNROERoR2UvaFIzL1pOcnN5Q3hKN2p4TDlkQVdsNHVrYWVB?=
 =?utf-8?B?THZtVThCQVFqbThoVmJBanQ0N2ovMExuVEpiNGRMUmdxUVpReUpDeHg1Q01C?=
 =?utf-8?B?T2NQYXdDb29RNmhwb0x5L2dVdDVrbGltcHlRMkRwdHNvMjBsUThWVU42U011?=
 =?utf-8?B?ZGtzbDFjU0JrY09COFk4L2N5UHBFOWNpOTEzQjNMQS9DNTVoS3g1eTdIU0x1?=
 =?utf-8?B?dXJSKy9RcHNUQnRVOWc5TVJCeFpob1d2QUtaUHhvYzZ4NkpsUzViYTkyRFhW?=
 =?utf-8?Q?3PZrRN5fpeu76zrIWdLvsfD0s?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d6249a-75e7-4998-883a-08db754189a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2023 06:00:54.5444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iyosJfdLAWwB9QK+mMCicf5+z1/a+vEIm6GXQvRZzu6eOpINRmXynxXu3zSa4kJ849jDszWFfsRAZafTRUs5Nxt7/uCkv6Js4TCWRP/Q/Ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4973
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mga18.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSm9hbyBNYXJ0aW5zIDxqb2FvLm0u
bWFydGluc0BvcmFjbGUuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgSnVuZSAyMSwgMjAyMyA3OjA4
IFBNDQo+VG86IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPkNj
OiBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsgY2xnQHJlZGhhdC5jb207IHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZzsNCj5hdmloYWloQG52aWRpYS5jb207IFBlbmcsIENoYW8gUCA8Y2hhby5wLnBl
bmdAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS8zXSB2ZmlvL3BjaTogRml4
IHJlc291cmNlIGxlYWsgaW4gdmZpb19yZWFsaXplDQo+DQo+DQo+DQo+T24gMjEvMDYvMjAyMyAw
OTowMiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBXaGVuIGFkZGluZyBtaWdyYXRpb24gYmxv
Y2tlciBmYWlsZWQgaW4gdmZpb19taWdyYXRpb25fcmVhbGl6ZSgpLA0KPj4gaG90cGx1ZyB3aWxs
IGZhaWwgYW5kIHdlIHNlZSBiZWxvdzoNCj4+DQo+PiAocWVtdSkgZGV2aWNlX2FkZA0KPj4gdmZp
by1wY2ksaG9zdD04MToxMS4xLGlkPXZmaW8xLGJ1cz1yb290MSx4LWVuYWJsZS1taWdyYXRpb249
dHJ1ZQ0KPj4gMDAwMDo4MToxMS4xOiBWRklPIG1pZ3JhdGlvbiBpcyBub3Qgc3VwcG9ydGVkIGlu
IGtlcm5lbA0KPj4gRXJyb3I6IGRpc2FsbG93aW5nIG1pZ3JhdGlvbiBibG9ja2VyICgtLW9ubHkt
bWlncmF0YWJsZSkgZm9yOiBWRklPDQo+PiBkZXZpY2UgZG9lc24ndCBzdXBwb3J0IG1pZ3JhdGlv
bg0KPj4NCj4+IElmIHdlIGhvdHBsdWcgYWdhaW4gd2Ugc2hvdWxkIHNlZSBzYW1lIGxvZyBhcyBh
Ym92ZSwgYnV0IHdlIHNlZToNCj4+IChxZW11KSBkZXZpY2VfYWRkDQo+PiB2ZmlvLXBjaSxob3N0
PTgxOjExLjAsaWQ9dmZpbzAsYnVzPXJvb3QwLHgtZW5hYmxlLW1pZ3JhdGlvbj10cnVlDQo+PiBF
cnJvcjogdmZpbyAwMDAwOjgxOjExLjA6IGRldmljZSBpcyBhbHJlYWR5IGF0dGFjaGVkDQo+Pg0K
Pj4gVGhhdCdzIGJlY2F1c2Ugc29tZSByZWZlcmVuY2VzIHRvIFZGSU8gZGV2aWNlIGlzbid0IHJl
bGVhc2VkLCB3ZQ0KPj4gc2hvdWxkIGNoZWNrIHJldHVybiB2YWx1ZSBvZiB2ZmlvX21pZ3JhdGlv
bl9yZWFsaXplKCkgYW5kIHJlbGVhc2UgdGhlDQo+PiByZWZlcmVuY2VzLCB0aGVuIFZGSU8gZGV2
aWNlIHdpbGwgYmUgdHJ1ZWx5IHJlbGVhc2VkIHdoZW4gaG90cGx1Zw0KPj4gZmFpbGVkLg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5j
b20+DQo+PiAtLS0NCj4+ICBody92ZmlvL3BjaS5jIHwgMSArDQo+PiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vcGNpLmMgYi9ody92
ZmlvL3BjaS5jIGluZGV4DQo+PiA3Mzg3NGE5NGRlMTIuLmM3MWIwOTU1ZDgxYyAxMDA2NDQNCj4+
IC0tLSBhL2h3L3ZmaW8vcGNpLmMNCj4+ICsrKyBiL2h3L3ZmaW8vcGNpLmMNCj4+IEBAIC0zMjEw
LDYgKzMyMTAsNyBAQCBzdGF0aWMgdm9pZCB2ZmlvX3JlYWxpemUoUENJRGV2aWNlICpwZGV2LCBF
cnJvcg0KPioqZXJycCkNCj4+ICAgICAgICAgIHJldCA9IHZmaW9fbWlncmF0aW9uX3JlYWxpemUo
dmJhc2VkZXYsIGVycnApOw0KPj4gICAgICAgICAgaWYgKHJldCkgew0KPj4gICAgICAgICAgICAg
IGVycm9yX3JlcG9ydCgiJXM6IE1pZ3JhdGlvbiBkaXNhYmxlZCIsIHZiYXNlZGV2LT5uYW1lKTsN
Cj4+ICsgICAgICAgICAgICBnb3RvIG91dF9kZXJlZ2lzdGVyOw0KPj4gICAgICAgICAgfQ0KPj4g
ICAgICB9DQo+Pg0KPlRoaXMgZG9lc24ndCBsb29rIHJpZ2h0LiBUaGlzIG1lYW5zIHRoYXQgZmFp
bHVyZSB0byBzdXBwb3J0IG1pZ3JhdGlvbiB3aWxsDQo+ZGVyZWdpc3RlciB0aGUgZGV2aWNlLg0K
DQpJbiBteSB1bmRlcnN0YW5kaW5nLCBmYWlsdXJlIHRvIHN1cHBvcnQgbWlncmF0aW9uIGJ1dCBz
dWNjZXNzIHRvIGFkZCBtaWdyYXRpb24gYmxvY2tlciB3aWxsIG5vdCBkZXJlZ2lzdGVyIGRldmlj
ZS4gdmZpb19taWdyYXRpb25fcmVhbGl6ZSgpIGlzIHN1Y2Nlc3NmdWwgaW4gdGhpcyBjYXNlLg0K
QnV0IGZhaWx1cmUgdG8gYWRkIG1pZ3JhdGlvbiBibG9ja2VyIHNob3VsZCBkZXJlZ2lzdGVyIGRl
dmljZSwgYmVjYXVzZSB2ZmlvX2V4aXRmbigpIGlzIG5ldmVyIGNhbGxlZCBpbiB0aGlzIGNhc2Uo
ZXJycCBzZXQpLCBqdW1waW5nIHRvIG91dF9kZXJlZ2lzdGVyIGlzIHRoZSBiZXN0IGNob2ljZS4g
VGhlbiB2ZmlvX21pZ3JhdGlvbl9yZWFsaXplKCkgc2hvdWxkIHJldHVybiBmYWlsdXJlIGluIHRo
aXMgY2FzZS4NCg0KPiBNaWdyYXRpb24gInJlYWxpemUiIHNob3VsZCBub3QgY29uZGl0aW9uIGFz
IHRvIHdoZXRoZXINCj55b3VyIGRldmljZSBmaW5pc2hlcyB0aGUgcmVhbGl6ZS4NCldoYXQncyB0
aGUgaW1wYWN0IGlmIHdlIGNvbmRpdGlvbiBpdD8NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KDQo=

