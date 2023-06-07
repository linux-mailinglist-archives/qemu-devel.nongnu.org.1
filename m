Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4F172655F
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 18:03:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vbw-00017L-Ah; Wed, 07 Jun 2023 12:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=515b4f0f9=Niklas.Cassel@wdc.com>)
 id 1q6vbh-0000tk-JK; Wed, 07 Jun 2023 12:01:59 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=515b4f0f9=Niklas.Cassel@wdc.com>)
 id 1q6vba-0005xm-3A; Wed, 07 Jun 2023 12:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1686153710; x=1717689710;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=KDG/LlJ7UIAVNDkIrh0du7czRV3esDpgpY3eL6ofw7w=;
 b=ho1CDNMTFT9e7LGJJ3jhIRDBPBuIsFTM4D6Yp9nGz2VCEYCY/Ka0EGxG
 NpyALoIOj615F3+RCiM3mhb6/tmxxD6I5kZWcySBMgeFVSgiYy4sTa63b
 LlY5oFH9uH38d10FEHtULTCZOzZ/9Kib6BPP/6ZDafgZZBks60liU1AU8
 +easJiauK9J9JLIx9iZT14av62ZioARvevno4OyGbXOxmaahj38n4yjRc
 9yDAeOh7kIyjr0wqDEln/fAdulCll0pYaFAPkhHvZ0eQ+iBs2gsk1jdIb
 5U6lHQtHJEzAyXPDPO35fufZZq94Y9mUYhk6DomLLOqPWNXTtlUIEzBkw A==;
X-IronPort-AV: E=Sophos;i="6.00,224,1681142400"; d="scan'208";a="233034309"
Received: from mail-sn1nam02lp2041.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.41])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2023 00:01:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLEtc4RQ1hkbpu58r5vWLsOD8jWOwuKlV0KUni6DH4dEJf6rpnjA/vAobbUS7pGorlFjJhtsQ9BDEifmCy+RQ4JVw74ZHGHnhoGRYbp+GTqLngOWEEoWoq81vZb/2xPPgZQYVPHYp/q3op/I1ihK3hNWEG+VfaXhGnYJLfR342gqeippW3b9qOIm58L7GGNPox7htYf7Y5e0piz2gIBtHi5jr5nMM+5ZLqnfZ6mDw0N35bckPQBEH0zoENzdv9rf0G4eyStjASh1yfy8FdCmlk0z6WUsTzvn/4uO2XFvwcYqeBSvLLpRmaeFUgJsxgTCW/PyYeNxXyYMiB0MIoy0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDG/LlJ7UIAVNDkIrh0du7czRV3esDpgpY3eL6ofw7w=;
 b=csMsnrh1MZJZHpxW7Lg/1RD0LZZjFaLn8DqwHYE6FPk5BBLFo8o1/Ee5CZLl8gTqGDxYhcIPfPLeQ+p2ZpaNjASwqB9l2YC++qgcGvmXUFGPrlyKdZRLEzPFlBVl4ukdIFKbjnUQtgDyhKGr8VFP0EJvtmVznUdWgkB4ukwuG2+5d4Nsd2vAI2TYlEm/425N065zANk1ASS+vWYvTpSuraQNp2mSW7+2yuSPgLRbFuzPEEJJSWeL5LJhgmIas2O+Ouf9vHZ05UJvgyEFo3vKKXEeILNNMqf7mT3vQkW4zlwClyRowXDXxNwlREA0gFkbYZbSkM+N1PN85cp86UAsyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDG/LlJ7UIAVNDkIrh0du7czRV3esDpgpY3eL6ofw7w=;
 b=qjX7tRaNnHa+RH6f7l0HWySf3zhsxVhRwpuNObd32Z4bYBxrUL18D7P+kIoumNbxoMNjjWk/Blxd7x+Y+ocS4NWWV0Z5Wby1+2MPz27z5T14STvqFYTl7JBrh6Ngj6Md2kq1zXFP5oZszhWCXRi5iic5lCBgJIxNuPHJF9DrIEU=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB6930.namprd04.prod.outlook.com (2603:10b6:a03:229::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 16:01:21 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 16:01:21 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: John Snow <jsnow@redhat.com>
CC: Niklas Cassel <nks@flawful.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2 5/8] hw/ide/ahci: PxCI should not get cleared when
 ERR_STAT is set
Thread-Topic: [PATCH v2 5/8] hw/ide/ahci: PxCI should not get cleared when
 ERR_STAT is set
Thread-Index: AQHZmAyiwKDusrJ5mUOPZxqulXEU0a9/gnyA
Date: Wed, 7 Jun 2023 16:01:21 +0000
Message-ID: <ZICpza8boQt4v/Yr@x1-carbon>
References: <20230601134434.519805-1-nks@flawful.org>
 <20230601134434.519805-6-nks@flawful.org>
 <CAFn=p-Zy_Sg1GwzmNUS1WwGTDR2kvxoz8_=9KC9Y_r2Ckd5siA@mail.gmail.com>
In-Reply-To: <CAFn=p-Zy_Sg1GwzmNUS1WwGTDR2kvxoz8_=9KC9Y_r2Ckd5siA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB6930:EE_
x-ms-office365-filtering-correlation-id: 11ecd309-ad65-40ec-dfb9-08db67706fc7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I3cdB9lPByhdfFbnGQNGHaog0V061/Q5QWOTSksBwdB2IT6y3bCL04CF9nxXlg2243GqcDiPBOGURoUCHoK4LXxhFW+LP8csqVbZtvh1EUNynSNWizgqOjNVe5gbjCzJzOt2ywZOrJWsXFaAaOtRJplXIGntaYmA9eGwIqPYrQBb2Ocuz3gYfbnrGcppR03Uzu7Bba7GnDSB1ei+bRgDc4pjH/g6wEhhHTzqxDdFFhhlX5/s0oDQFHBIKsSOExrcb5wiR/9FwSaapD+44yZ5ymdQiuNCnUYK8cpBskbQjId2lAIm8kmgrHLfwsgpxolVpMSZbDOBRf+OwBsjHcM+rPWDiPh1yQtvD8V8FTQfxgyPjQbhCmPG5GeR3ERdEWPH+JQv1FkxYNpI27vSmS9pFdQiMsLZXhBB5vM9zqClXUkR2xRA5HnUGcP5l4owk+0zdur2cJ+DyDw/58KBMRJ74dfSjGgExEglhzhIESpT+AZ2XwF+CrUgIc1n73scqtijl45jy8T23K/PIwib4MtXP1RVVbqnYjiwTlxP22LY6ZLOxcivshsla8+ufinSEOTiSbesJWSxikx/Eb2IaSbPMfdTV/Js8xg18Ko06SyULfO3G/aPQKjCzu9HWB+R8iRl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6272.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199021)(9686003)(26005)(53546011)(6506007)(6512007)(83380400001)(86362001)(38070700005)(122000001)(38100700002)(186003)(82960400001)(33716001)(8936002)(41300700001)(54906003)(2906002)(64756008)(478600001)(6916009)(91956017)(76116006)(66946007)(8676002)(4326008)(316002)(5660300002)(71200400001)(6486002)(66476007)(66446008)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NE9GWWYvUXBDSmp4TDNXeGxKQUszNUZzOW9Qd1J0UTdmblVNdVA1RUxJRjJY?=
 =?utf-8?B?U0dnc1oxanloWDNCOWlOSzFiTUtsdzJlbjM2dXB3d1VpMFpZY2djdlp0M1Z3?=
 =?utf-8?B?ZG1zL1FieHIvZVJJSTdOUFZlaE1rWlhYdWIrOG90NkNaS3VNQmhuNTE0SHBL?=
 =?utf-8?B?bFprZVphenNTRjgxV2RldkhpZ3JRK3FSNGcwWkFCYWlEcDA4enFGZnZzU2Q1?=
 =?utf-8?B?UmF2NTdIajR0UmQxcm1SMUU3b2FZQVhFbld4K2J5Z2J6U20wRVJYU1FmVU95?=
 =?utf-8?B?ZzVOVldGek9lVnY5SXV1R1hBLzhxUGNyZTdjbFd1eXdtSWkreUFiZHZsNjNN?=
 =?utf-8?B?aHc5elREMnFSTXZ3Z0c0RUl5QVp2VzZoYkQ2TER5TDN1Y2V0N3JFWU9qdDJt?=
 =?utf-8?B?VkxZMkU0NmFKZnVHcm5pODFLMG01dHpkMnVvb3YyYVllSlpleTdxSUxlZHhR?=
 =?utf-8?B?RXZYaGhXWXFwMEM2Tmo4ckduZExqanFsUDB1enNHOEpkSjNTbWoybmhFNHVu?=
 =?utf-8?B?US9WM2c5WjhCMThtTlU1YXQ5cFVQamU2NVlCQUVwTVgyMXF3eVcwZWNmQXJP?=
 =?utf-8?B?MjBXOEVOc0FhQ2NPTGk5WkdrVW1tbmEyZVYxc1M5Q01oQ0ZlNlByb3Z3S0FY?=
 =?utf-8?B?WjBLV1FheXNGRlFpYmpUcWRxWSttRXlqN0xSM2JQWGhnREUxd2V4S09uZDRu?=
 =?utf-8?B?OWM5a29JTlo5WDVVc0srUFU3ODUzaW0wZUZIWHJyaU9LODVzN0RCWTQvdlZG?=
 =?utf-8?B?R096L0ttQzRXQTNwSjIzM2FJVFFGL05QRndvSXVsOXhESFE5NG5CSm1GUTRw?=
 =?utf-8?B?czVWNlV5Wk0rajh1a0lZU2ZuVFB5SjdreGtINFk2d3N3aGtZaWRqL01sbDVr?=
 =?utf-8?B?aGVQZFUrL0h5UTA0cGFJakZKSFJwY29lZVhFV25EbnBjcytMTXNHOW9qTEF4?=
 =?utf-8?B?bmEzQi9NQmN1eUVrRHFIQVUxL2x3MU1SeXNpeWdUMmhGL1laZGg1emxXRGY2?=
 =?utf-8?B?UkpmMTRVcnlCQXUrRFI5UXFkMElsd010Z09tRnJOa3YyMEk3MGlScGx0d0Y5?=
 =?utf-8?B?WXNTVWFFUEd1N2NxaUk5dHJDbHFVRHkwbmxxTkxGaWVkYWw2RHM5eW9jdTdO?=
 =?utf-8?B?YkYrZVZhdmR4L0ozSTlzOUZpdWVFbGNmb0EzUzhLUmVGcVlYQTlJMmVVeEEv?=
 =?utf-8?B?RVF2V25ZZnF3RjV4TWRkcFQ1bUo1aURUS2ZsNDJUS2Eyam5teUE1LzZJdGNo?=
 =?utf-8?B?UnFvTDRZM2poZTNZRjlYTjFqenRCRlFpMWcrdklCb3pEWUxiRlA3T2pvNHY0?=
 =?utf-8?B?L3ZaeGpSWUNUWEVFNWxiSjJxamc5bzVDQXcxb1VrMGRYenFsdkVjMlM2M3k1?=
 =?utf-8?B?OHg3Q1J1VkVoQkE4UnhucFpXeDZGcXFuNWk3dStHWDhaT29XVytLazR1TkhS?=
 =?utf-8?B?bnBoYjMwL1c4OTRTN1kzZjMwbGl4TW1tckt1ODR2dUVKdXk3V29KMEZlZDA1?=
 =?utf-8?B?WmQwalZuOTEzeUorRk5taGdWb2JPQ1lEUlBNVjlOWldUc3lqeGRjVk4rcmNo?=
 =?utf-8?B?M1ZKbHo2c25hY3N4ZkJOQ21ZdDhzOVRtYklQREczWnJOZnlzbHJVTVJYdXdm?=
 =?utf-8?B?R3g5MjJrTktQdFlnKzVabC9ORFNmQ1d3V3dNODNVWndzN1YvdWNaZjJTZGZl?=
 =?utf-8?B?Q0wzQmJZam1YYmNSbE1qeC8zd1B4V1FoUFNyOXVUb254YVFsbHUra3NVZzJT?=
 =?utf-8?B?QWlNUFdBQVhIZ1JaS1JCazlXVHhQQ3E1VCtaNmlVQ1drOUZYMFJoR3FwYzNu?=
 =?utf-8?B?eno1eUduc1V3N0JXNXg5QklnRHp3NWdOSENCSmpVdUQ3K1pOd1dIZUtNSFN1?=
 =?utf-8?B?dDZKZHc1cE54dW5idmhFRHJEK2ZIYWdkYXVuYWN1Rk1UdStXQzFGWTR1eFdS?=
 =?utf-8?B?NkI5Q3hvL1ZCRmNtdzBTbE9xOStXQkVuSkdkRjgzUW1DMEhmN1B0RjJEUjAv?=
 =?utf-8?B?VUVrUzc2Yk9IR3hrZ1hkRVdneGMvN0Z3TjNNOXRDYVJNeVQ2blh2VDBzVmRX?=
 =?utf-8?B?aVozNWoyb1FmbmpZdm1DWGRYclJZbkpTOGsyRzZPYlhCZ1Bwa0srbGZhWHhC?=
 =?utf-8?B?amxvalBHdVZkWVUyL3VobS82UU55eUkxN0QzSDFJOVhGV053M2ZUZnJRelF6?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <351348E30AA0EC4088023F9C5AB22438@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 19dUARNCZJoVDgSqv0fRa7stk/PZZACHVvupy3gktM3/w1mdnf8FXcmAw+5VOTUY7Ta3QFAd2o5t42TubdFgolUgnkZIRTWn4Vb+SjVNCwdfYLkbJvC+qOrcIZ124+0XYbz374Eq5xseETQYvVVvvJURMqQUiMRKYyk0G4AQuq/qtuAPY0QSugHtHBHhoxdwPV7sC8wRwgZojdaQttomkTzGG/O+TN3I6mtke9Axv3BmjiGhRzyprags6cK/PzRM6nfszwb6YNC4ruI509YJGt0bFq2OjdXh6yVlkSZU5PdzeFMSsXzssTe9g4gmT3g0ZBLal8Fws1OlHyb/NT2EjcYFzhWrcpT/90lK6O0+uNIwPbCDvRNIeDuVW/rdczYdcHz5kD1Cjhwx5GaORDUhTIjiCLFUlz81Psoh0PMXMaYVKF8xAmkDag2jcksKyjP1E5MQSM4P2L1Gt54JS23jKhvdi6YXhD7EykcLkcLa107G/7rGUR3Ns7MZdgEO6vgikoEIwX8KFrRkNXR3WFofhd66ZEsEKxsTJs5CdUDNOLC0qfiuraGnSCJT63582wxAI835LJAIkSsbQeP7fqUyqxV2YpVMtHTM/Y5AeWtd8bfP/C/cd2sEe4NPWMMLeDUZ6DKNQDqqyLlfPPHtUeBIgHRlJGdnnIuZzBVRfpUCWIyLMKab1BHpom0uX8OcaZ2HxJOJ4SLIhwpO3kTmUokQgQvoW0xnaOArvEWwDpoVSJ6QzJjGjuL8t4jbD5XZmRktYSTSf96vM2BjdyPAbziqQuRDMKRsYOCsNYaJ0QVcYconmoJd+12GxSESG1sJz7uqZlPRbrttCGnNgK64gc16jWpZ2I3bOYH+lgY6CkJ9GgU=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ecd309-ad65-40ec-dfb9-08db67706fc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 16:01:21.2099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1bcAe8UoB3I7kJGpAGWv2Oe38J6/M+//b/xYg+sqVQZHKupew1MjnmLFg9fjyWRq5E6CscMbMy0wakGWDolgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6930
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=515b4f0f9=Niklas.Cassel@wdc.com; helo=esa6.hgst.iphmx.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

T24gTW9uLCBKdW4gMDUsIDIwMjMgYXQgMDg6MTk6NDNQTSAtMDQwMCwgSm9obiBTbm93IHdyb3Rl
Og0KPiBPbiBUaHUsIEp1biAxLCAyMDIzIGF0IDk6NDbigK9BTSBOaWtsYXMgQ2Fzc2VsIDxua3NA
Zmxhd2Z1bC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogTmlrbGFzIENhc3NlbCA8bmlrbGFz
LmNhc3NlbEB3ZGMuY29tPg0KPiA+DQo+ID4gRm9yIE5DUSwgUHhDSSBpcyBjbGVhcmVkIG9uIGNv
bW1hbmQgcXVldWVkIHN1Y2Nlc3NmdWxseS4NCj4gPiBGb3Igbm9uLU5DUSwgUHhDSSBpcyBjbGVh
cmVkIG9uIGNvbW1hbmQgY29tcGxldGVkIHN1Y2Nlc3NmdWxseS4NCj4gPiBTdWNjZXNzZnVsbHkg
bWVhbnMgRVJSX1NUQVQsIEJVU1kgYW5kIERSUSBhcmUgYWxsIGNsZWFyZWQuDQo+ID4NCj4gPiBB
IGNvbW1hbmQgdGhhdCBoYXMgRVJSX1NUQVQgc2V0LCBkb2VzIG5vdCBnZXQgdG8gY2xlYXIgUHhD
SS4NCj4gPiBTZWUgQUhDSSAxLjMuMSwgc2VjdGlvbiA1LjMuOCwgc3RhdGVzIFJlZ0ZJUzpFbnRy
eSBhbmQgUmVnRklTOkNsZWFyQ0ksDQo+ID4gYW5kIDUuMy4xNi41IEVSUjpGYXRhbFRhc2tmaWxl
Lg0KPiA+DQo+ID4gSW4gdGhlIGNhc2Ugb2Ygbm9uLU5DUSBjb21tYW5kcywgbm90IGNsZWFyaW5n
IFB4Q0kgaXMgbmVlZGVkIGluIG9yZGVyDQo+ID4gZm9yIGhvc3Qgc29mdHdhcmUgdG8gYmUgYWJs
ZSB0byBzZWUgd2hpY2ggY29tbWFuZCBzbG90IHRoYXQgZmFpbGVkLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogTmlrbGFzIENhc3NlbCA8bmlrbGFzLmNhc3NlbEB3ZGMuY29tPg0KPiANCj4gVGhp
cyBwYXRjaCBjYXVzZXMgdGhlIGFoY2kgdGVzdCBzdWl0ZSB0byBoYW5nLiBZb3UgbWlnaHQganVz
dCBuZWVkIHRvDQo+IHVwZGF0ZSB0aGUgQUhDSSB0ZXN0IHN1aXRlLg0KPiANCj4gIm1ha2UgY2hl
Y2siIHdpbGwgaGFuZyBvbiB0aGUgYWhjaS10ZXN0IGFzIG9mIHRoaXMgcGF0Y2guDQoNCkFyZ2gg
OikNCg0KSXMgdGhlcmUgYW55IHNpbXBsZSB3YXkgdG8gcnVuIG9ubHkgdGhlIGFoY2kgdGVzdCBz
dWl0ZT8NCg0KIm1ha2UgY2hlY2siIGFuZCAibWFrZSBjaGVjay1xdGVzdCIgYXJlIHJ1bm5pbmcg
bWFueSB0ZXN0cyB0aGF0IEknbSBub3QNCmludGVyZXN0ZWQgaW4uDQoNCg0KS2luZCByZWdhcmRz
LA0KTmlrbGFz

