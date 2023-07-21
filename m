Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BA375CA99
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 16:50:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMrRs-00033N-Uu; Fri, 21 Jul 2023 10:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qMrRl-0002nR-7l
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:49:35 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qMrRj-0004mT-Bf
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:49:33 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36LCwD6q029460; Fri, 21 Jul 2023 07:49:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=LdFPeWHVioB1e7qZ7C2aafcMAQvP9Z+ahpshtJ
 0ONDQ=; b=Pr8poepAKrOprH5Xib/yK6e/i1OatkL9z7Y3wcW6PA5enR8EwFcyNQ
 ycgO30LbK8r/uOGQapPQQy9slGx/nftVp7ZL2vci1Df5eMqOMgLhfzF4fC6wmT54
 8Rh6P4GbTH+lmd+h+4oCZ8zJZiWr0s6n0zkmqISVOQ+g0uAjoTeh59FHmWjDeYud
 YLnn0icAEQK+WvbwLF5XdEUIC7rKfbU7RlIENSXM9y4BZsey4K1kzvYHyqMhgrOa
 9r4HPfZhhdsZykael9WouVLWARjyAbudKziz4ETUOIk2DI5/4e+qR30pRS9fcPR+
 RWex6lkoQTqANDAP7vnEJ2KioDARFwEw==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rx319phvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jul 2023 07:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZIfhVDxMKPcauGgWMkXZf2yx7JKgkNl/mzCuQ2o+EQlsJagIqRY00puLTLz850EABgHJn8VPmb7WgIjOvwKSDqK8AgTTpF/bno/hcG+ckRySpByjhmt8uNYD5h3OvVbE05SZDf2IHkpFXnu9yVDpspmaLGX+0qDhOSInCjeWuClXfEN1LPPmpsXgKSM2pjVuk1UqV5QNuo1n4byRNFmHoUBBOk5FtC70HevVNU1r4LiEhi1mpnuaROk8Dky0mn1Ducpm4uY0dcIpIQR3+byvdarVH3fy/hDfrrMIIJ12gXpUsZZyc8ZN1I44e86nx0SYDXKAoQO6W1SApQQGgSrLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdFPeWHVioB1e7qZ7C2aafcMAQvP9Z+ahpshtJ0ONDQ=;
 b=NljYJvv78XS2bZMniKxjZ+ccp25Jf9VuN3i8GV07mTQA5NqZP4nzEjpAKYVqkm+mjFIF9JPCL/N+B5DXNHke10yhWZzoKzfWUICTxTWNKtp9IA4+Bwh50a6CLf81fZR3Ibj2jBA+q6xsx3VHLuXwZLgsfNU7t/2aICqqrX7yiFK8zSwDBGeY2pdAEQDyhY6dS8W4WQXefaj5P/Sh3Ov3Ha3BidAm+s809wjwqSagcAdQl846oeDAk9qxnMQW1cjzDoSLH1yCkiiLkOv6KvgeG6/GyT3c7K6wasW5loSvmbtEmnYtYJkNReGfEprAKM1OfJCdMIm8vMU7J73n/zf06g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdFPeWHVioB1e7qZ7C2aafcMAQvP9Z+ahpshtJ0ONDQ=;
 b=Q2gKN3dcSX+esTKPfguoxI6K7Hz6Wvdr1RYdpzaYoycYXL/tCAwGV/zPB/sGH1Uzox/p9xOzPcVYg4CIxDszjfCGtoWhkhKlMrYtgncdJXNeR7ZFB9KnB4zQbK4DJYS9pXtSLF+UYJeMPGCBjGizx4/nmLRPAjYJJuioJjhOj7dNrRvuxluSTkw7bVNq1ycowaCqhhtRL6hA089JPIDASDawCcINxQq0WMnlpmT85/S8Ybqwz7yig6p9jPIdSRQePsHUbB1PBsuX0svAAHuZKLPYF9nDa9cUKXwjeJoyc4aGJvokFBTjnRj1g/kGWHyAg9EU1GYrdP81fVseSZ7qEA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by SA2PR02MB7561.namprd02.prod.outlook.com (2603:10b6:806:140::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 14:49:27 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e%7]) with mapi id 15.20.6609.022; Fri, 21 Jul 2023
 14:49:27 +0000
From: Het Gala <het.gala@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Prerna Saxena <prerna.saxena@nutanix.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, Manish Mishra
 <manish.mishra@nutanix.com>, Aravind Retnakaran
 <aravind.retnakaran@nutanix.com>, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v9 04/10] migration: convert rdma backend to accept
 MigrateAddress
Thread-Topic: [PATCH v9 04/10] migration: convert rdma backend to accept
 MigrateAddress
Thread-Index: Adm74oxc2BvHNvUF/UiT5VPJngsiqw==
Date: Fri, 21 Jul 2023 14:49:27 +0000
Message-ID: <20230721144914.170991-5-het.gala@nutanix.com>
References: <20230721144914.170991-1-het.gala@nutanix.com>
In-Reply-To: <20230721144914.170991-1-het.gala@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PH0P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::17) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB4343:EE_|SA2PR02MB7561:EE_
x-ms-office365-filtering-correlation-id: 7feff78c-f31a-4c6d-9e09-08db89f9aedb
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4vpSAAJ9D7EXPH2tfWJdIvcsPuXMueTw041EpipEDAwlxcEC0uhDk2D0raajP45i2OEqQ+wnjI3dpPBWXSB6iBRvNlTHsUBwDsPlVAPgd0PFPQzee/qd0jFJGm5aKaILWbGUXnLj4Wew6lDFi9r0ViAIZ6uY5dNyMzO8iUW47VzzHW1MqWps04tmNGqCn1JkLKSULoEqQispWcfJwFWvVLe9lsLXuBejtUhEGdNXr7shWIMVTeckfnenuj+DuRQABwGIeGfYoCUQzjvURd4A8CpM9/lxLTaHUWp/a5Sx2K/TnXaxFRuDyGIkikY/7Y7d0Y8fmgEyJErW6Majy484/jRW+XA8MD9AyRNWPwhOpHL3Tpg/CkaIHwppW1cj515hg9+vre9yuJOZk4hwJNtjYUJu7bGywm8H7iN4MI1HVUuCCYeeD1mpX3YarE5Ti0OlVlXobDXw9xkrOvjcd8q2mRYUQ+j6MR2K4TWyAmOy8QmJyPbsSJFZW1GcmO0wJ1e/DZnNqxj1DIm+3XSdIVQV4aOPi9G6eBrSurT5g7GDS1dp+Nt+KrL9EB/5ldgMuVGu6XwVxNqHw3268xQaiIgakMdC1hc7G8PvlXoVN/fiSQSS0bhfjtCDPtgMOC6gpdUe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(2616005)(6486002)(52116002)(6512007)(71200400001)(478600001)(86362001)(26005)(1076003)(107886003)(6506007)(36756003)(5660300002)(4326008)(44832011)(6916009)(41300700001)(8936002)(8676002)(316002)(2906002)(122000001)(38100700002)(54906003)(64756008)(66476007)(66556008)(66446008)(66946007)(38350700002)(186003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0tjdGxFbHBrckJ0bEhSc3pCa1R6bW04dkVZVFZZSDZsOEw2V0JCL0xMVTE5?=
 =?utf-8?B?UnVzUGV2Z1N3L2dHRlRXRUt6N0xsdTBmWmMvRTcvemZDR3ZsekF6K0xxS2Vq?=
 =?utf-8?B?cXBKYTFLNVhUbk9DNkt0Ky8yTmxPMWFFQTgzOU1NUmZMUmc4UWJlZTAvcnNj?=
 =?utf-8?B?UlVsTlFKV3pYdEFNSmhSUG0zQndndDREdTMzdnJnVFQrVzE0ZzVzenRpbHBG?=
 =?utf-8?B?QmpVMmZXUGo4K29qSWhNZ1VLUEhLRWFpRldPN3lkM3pPOHZpNUg3RTl1Q3M5?=
 =?utf-8?B?Yi9lWlVIWnB1STdNcjdRVlJBV1lDYThNZ25GamlhcmtTaUd5QUd6M3lkTmtJ?=
 =?utf-8?B?NSs2MSt3UFVDWVp6VHpjZjVYUmtKTk0zckk1dFBjZkw0VXJMekNUcmdoRVZT?=
 =?utf-8?B?SW9nZjlEUFpCQnpLdFowYlNOc0s0aG01Q2dNVE1EZDNUbDhreU85ajZrMm5w?=
 =?utf-8?B?Zkl3VWJKMTdQOVpXMnF0bEZEMWNoUXpyQmVvbGswQ0tDUUlTSlk2ZWQ5Mzl3?=
 =?utf-8?B?QmVRSy81eEdDcndHVkYva2hKUnlxMUw3eGhKNWM3NHY0K0FPaFRZTmhoZ1Q0?=
 =?utf-8?B?QlFHL245SWZXSkxvSkk3M0NlWnI2R092QkUwTnlOaythSG9LeHNaTWxaTGlK?=
 =?utf-8?B?UXBub3lmWEVacEJqbkZtMkE3SUVXa3RBNVNkS081cFJ1Sm1KaEtqZ2E0MkF4?=
 =?utf-8?B?aUcxN3d4dVY4NzJXa3g0TFZSR1ptZlFibjFmNytNSDh6ODlwVDR1L3dTZ003?=
 =?utf-8?B?M3dSM0FiNzloL3g4eTdJNW5US2FodGlzUFFZUHhJeWFaaU9wTWw1bmZ3K01F?=
 =?utf-8?B?UzlJQ1JjWEVsc0loOWFIeGhKUE5GYVhxZ2pOdWVId0F5b2xJbTFpUklKdVBX?=
 =?utf-8?B?cmFNZHZ0MWFka0FUV2VNNjUwNm1jRExWQXRZWUhob1FQZlNuczdaRmEvQWlq?=
 =?utf-8?B?cGJIZXFxQXljdyt2a1hpcS8rVVdOay9TNlU3NEptR24vVFQ0TTYzSkdSZ3Vk?=
 =?utf-8?B?UFFEdlRxMHdGR1JMY1RlK0k3TjRPdHV3c2VmL2VMRVpCVmw1MFhOdE1JclFM?=
 =?utf-8?B?SmZHMXF5Q2loVWIyQStZRHN3Ynh4NkZQdnF0aFF6ZVdsTDNjTS9vbVE1YlZJ?=
 =?utf-8?B?TVhjWlp3K01mZndHb3FiQWJWU0dGcWtKdndEN05EZ0c0TFRmeXlXbmxnNDJ2?=
 =?utf-8?B?UjNDTjlSN1Vpb0FJeElqRlZ6cW8vTXJaSEZua09rbldKWi8vN3o1NngyWlpZ?=
 =?utf-8?B?RjZXNVUyeDQrdlNsTVhxWnVQWUdhQ2FacjRPOXloK2Q2OUNpZklhY0xrVnFV?=
 =?utf-8?B?YjRjTm02SUlPYmM4c205b29ZUXlBUGhkT3ROMmdQSzVRckdFZ2dOdkJxMSs2?=
 =?utf-8?B?aGpaSVFud1dhb0N5bi9pMC9UMXVPOHJ2QzV1clBHQ0VWVlJSazNtRWduUHpq?=
 =?utf-8?B?a0N0ZHpKbytmVkYrM2RLUlhxeGo2VGovNWlML0hMR3NVRS8zd09sYzBMaUlH?=
 =?utf-8?B?eSthN2h1YWlTLzd4MjYrS1NzaU9TUkVXa2ZlTlVLK3AwR21Ydi9ocUt3eHh0?=
 =?utf-8?B?SFRySVVKWDEycWMzbnF0MjZFMWFtOEFKdmJ4MWtMalltcmdaOGxWNUw5L01u?=
 =?utf-8?B?TktqMnlndXRhRXZKOGJocUZUK2h1TXJBVWkxWGpEY25UNmw4N3EvbkdrODVu?=
 =?utf-8?B?Z25INDlSWkJOblBWYThDLzFWNmsxekpJbFdPUUMrdUJEM2trRUFVdnhKdmtS?=
 =?utf-8?B?T3lJVm8xb0Z0OFF6bm5FazZMTnBwNFl2TW4zd0ZONXRWSVZteVIvWU9OOHZP?=
 =?utf-8?B?RGF1b0xtQTJVVU9LeUltTG5aUzY5RW9yY1VGT0JIMEF5WVlodklrOHZKZW9Q?=
 =?utf-8?B?d2pTbTZXYjZoY0FodGsrZzJXMU9xNDJaZWpFckpIZ01ZQjRtSWZiQzdtNkpR?=
 =?utf-8?B?K25lOGJ5dDBUR1VOcWZsTWdrNy92V25wU2NZQ3V4VEZ4aUkzZ2V0TzBZYTFh?=
 =?utf-8?B?aWpidEVWaDFKcWFhK0s1SWg2SkMzTGVsWDhERStlNHFFNzFEN0Roa2xGamtL?=
 =?utf-8?B?WTVmYnRXc2l0OWFZK0tITEpTWmg2WlFscUcwMnVmQ0ZuK0tKR2FDZHBLQkht?=
 =?utf-8?B?anRqOXpnTDY4V2FjZ2xGVjBhY1JiN3loeE9rdlkvd0NwUzhjM1dGQ2NtKzkw?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAEB0D3516AAD04EB664E9B5B673D36F@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7feff78c-f31a-4c6d-9e09-08db89f9aedb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 14:49:27.6200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HcnByRoAt+IAL1iN5tO6XE4qyqQbDTy1B93LhZYybfb86QfcdSBHWfzngP2bAf6ms7QWSRACBpMZbHXJe5NYAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7561
X-Proofpoint-GUID: UOm6NfzKrNWaoUWfXsZmCb_8dNNKp9l6
X-Proofpoint-ORIG-GUID: UOm6NfzKrNWaoUWfXsZmCb_8dNNKp9l6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_09,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

UkRNQSBiYXNlZCB0cmFuc3BvcnQgYmFja2VuZCBmb3IgJ21pZ3JhdGUnLydtaWdyYXRlLWluY29t
aW5nJyBRQVBJcw0KYWNjZXB0IG5ldyB3aXJlIHByb3RvY29sIG9mIE1pZ3JhdGVBZGRyZXNzIHN0
cnVjdC4NCg0KSXQgaXMgYWNoaXZlZCBieSBwYXJzaW5nICd1cmknIHN0cmluZyBhbmQgc3Rvcmlu
ZyBtaWdyYXRpb24gcGFyYW1ldGVycw0KcmVxdWlyZWQgZm9yIFJETUEgY29ubmVjdGlvbiBpbnRv
IHdlbGwgZGVmaW5lZCBJbmV0U29ja2V0QWRkcmVzcyBzdHJ1Y3QuDQoNClN1Z2dlc3RlZC1ieTog
QXJhdmluZCBSZXRuYWthcmFuIDxhcmF2aW5kLnJldG5ha2FyYW5AbnV0YW5peC5jb20+DQpTaWdu
ZWQtb2ZmLWJ5OiBIZXQgR2FsYSA8aGV0LmdhbGFAbnV0YW5peC5jb20+DQpSZXZpZXdlZC1ieTog
RGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCi0tLQ0KIG1pZ3JhdGlv
bi9taWdyYXRpb24uYyB8ICA4ICsrKystLS0tDQogbWlncmF0aW9uL3JkbWEuYyAgICAgIHwgMzQg
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIG1pZ3JhdGlvbi9yZG1hLmggICAg
ICB8ICA2ICsrKystLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMjggZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9taWdyYXRpb24vbWlncmF0aW9uLmMgYi9taWdyYXRp
b24vbWlncmF0aW9uLmMNCmluZGV4IGM0YmNmOGJiZDcuLjgwMTJmOTNmMWIgMTAwNjQ0DQotLS0g
YS9taWdyYXRpb24vbWlncmF0aW9uLmMNCisrKyBiL21pZ3JhdGlvbi9taWdyYXRpb24uYw0KQEAg
LTQ5MSw4ICs0OTEsOCBAQCBzdGF0aWMgdm9pZCBxZW11X3N0YXJ0X2luY29taW5nX21pZ3JhdGlv
bihjb25zdCBjaGFyICp1cmksIEVycm9yICoqZXJycCkNCiAgICAgICAgICAgICBmZF9zdGFydF9p
bmNvbWluZ19taWdyYXRpb24oc2FkZHItPnUuZmQuc3RyLCBlcnJwKTsNCiAgICAgICAgIH0NCiAj
aWZkZWYgQ09ORklHX1JETUENCi0gICAgfSBlbHNlIGlmIChzdHJzdGFydCh1cmksICJyZG1hOiIs
ICZwKSkgew0KLSAgICAgICAgcmRtYV9zdGFydF9pbmNvbWluZ19taWdyYXRpb24ocCwgZXJycCk7
DQorICAgIH0gZWxzZSBpZiAoY2hhbm5lbC0+dHJhbnNwb3J0ID09IE1JR1JBVElPTl9BRERSRVNT
X1RZUEVfUkRNQSkgew0KKyAgICAgICAgcmRtYV9zdGFydF9pbmNvbWluZ19taWdyYXRpb24oJmNo
YW5uZWwtPnUucmRtYSwgZXJycCk7DQogI2VuZGlmDQogICAgIH0gZWxzZSBpZiAoc3Ryc3RhcnQo
dXJpLCAiZXhlYzoiLCAmcCkpIHsNCiAgICAgICAgIGV4ZWNfc3RhcnRfaW5jb21pbmdfbWlncmF0
aW9uKHAsIGVycnApOw0KQEAgLTE3MjgsOCArMTcyOCw4IEBAIHZvaWQgcW1wX21pZ3JhdGUoY29u
c3QgY2hhciAqdXJpLCBib29sIGhhc19ibGssIGJvb2wgYmxrLA0KICAgICAgICAgICAgIGZkX3N0
YXJ0X291dGdvaW5nX21pZ3JhdGlvbihzLCBzYWRkci0+dS5mZC5zdHIsICZsb2NhbF9lcnIpOw0K
ICAgICAgICAgfQ0KICNpZmRlZiBDT05GSUdfUkRNQQ0KLSAgICB9IGVsc2UgaWYgKHN0cnN0YXJ0
KHVyaSwgInJkbWE6IiwgJnApKSB7DQotICAgICAgICByZG1hX3N0YXJ0X291dGdvaW5nX21pZ3Jh
dGlvbihzLCBwLCAmbG9jYWxfZXJyKTsNCisgICAgfSBlbHNlIGlmIChjaGFubmVsLT50cmFuc3Bv
cnQgPT0gTUlHUkFUSU9OX0FERFJFU1NfVFlQRV9SRE1BKSB7DQorICAgICAgICByZG1hX3N0YXJ0
X291dGdvaW5nX21pZ3JhdGlvbihzLCAmY2hhbm5lbC0+dS5yZG1hLCAmbG9jYWxfZXJyKTsNCiAj
ZW5kaWYNCiAgICAgfSBlbHNlIGlmIChzdHJzdGFydCh1cmksICJleGVjOiIsICZwKSkgew0KICAg
ICAgICAgZXhlY19zdGFydF9vdXRnb2luZ19taWdyYXRpb24ocywgcCwgJmxvY2FsX2Vycik7DQpk
aWZmIC0tZ2l0IGEvbWlncmF0aW9uL3JkbWEuYyBiL21pZ3JhdGlvbi9yZG1hLmMNCmluZGV4IGRk
MWMwMzllNmMuLjRkNjRmYWU0OTIgMTAwNjQ0DQotLS0gYS9taWdyYXRpb24vcmRtYS5jDQorKysg
Yi9taWdyYXRpb24vcmRtYS5jDQpAQCAtMzE5LDcgKzMxOSw2IEBAIHR5cGVkZWYgc3RydWN0IFJE
TUFMb2NhbEJsb2NrcyB7DQogdHlwZWRlZiBzdHJ1Y3QgUkRNQUNvbnRleHQgew0KICAgICBjaGFy
ICpob3N0Ow0KICAgICBpbnQgcG9ydDsNCi0gICAgY2hhciAqaG9zdF9wb3J0Ow0KIA0KICAgICBS
RE1BV29ya1JlcXVlc3REYXRhIHdyX2RhdGFbUkRNQV9XUklEX01BWF07DQogDQpAQCAtMjQ1NSw5
ICsyNDU0LDcgQEAgc3RhdGljIHZvaWQgcWVtdV9yZG1hX2NsZWFudXAoUkRNQUNvbnRleHQgKnJk
bWEpDQogICAgICAgICByZG1hLT5jaGFubmVsID0gTlVMTDsNCiAgICAgfQ0KICAgICBnX2ZyZWUo
cmRtYS0+aG9zdCk7DQotICAgIGdfZnJlZShyZG1hLT5ob3N0X3BvcnQpOw0KICAgICByZG1hLT5o
b3N0ID0gTlVMTDsNCi0gICAgcmRtYS0+aG9zdF9wb3J0ID0gTlVMTDsNCiB9DQogDQogDQpAQCAt
MjczOSwyOCArMjczNiwxNyBAQCBzdGF0aWMgdm9pZCBxZW11X3JkbWFfcmV0dXJuX3BhdGhfZGVz
dF9pbml0KFJETUFDb250ZXh0ICpyZG1hX3JldHVybl9wYXRoLA0KICAgICByZG1hX3JldHVybl9w
YXRoLT5pc19yZXR1cm5fcGF0aCA9IHRydWU7DQogfQ0KIA0KLXN0YXRpYyB2b2lkICpxZW11X3Jk
bWFfZGF0YV9pbml0KGNvbnN0IGNoYXIgKmhvc3RfcG9ydCwgRXJyb3IgKiplcnJwKQ0KK3N0YXRp
YyB2b2lkICpxZW11X3JkbWFfZGF0YV9pbml0KEluZXRTb2NrZXRBZGRyZXNzICpzYWRkciwgRXJy
b3IgKiplcnJwKQ0KIHsNCiAgICAgUkRNQUNvbnRleHQgKnJkbWEgPSBOVUxMOw0KLSAgICBJbmV0
U29ja2V0QWRkcmVzcyAqYWRkcjsNCiANCi0gICAgaWYgKGhvc3RfcG9ydCkgew0KKyAgICBpZiAo
c2FkZHIpIHsNCiAgICAgICAgIHJkbWEgPSBnX25ldzAoUkRNQUNvbnRleHQsIDEpOw0KICAgICAg
ICAgcmRtYS0+Y3VycmVudF9pbmRleCA9IC0xOw0KICAgICAgICAgcmRtYS0+Y3VycmVudF9jaHVu
ayA9IC0xOw0KIA0KLSAgICAgICAgYWRkciA9IGdfbmV3KEluZXRTb2NrZXRBZGRyZXNzLCAxKTsN
Ci0gICAgICAgIGlmICghaW5ldF9wYXJzZShhZGRyLCBob3N0X3BvcnQsIE5VTEwpKSB7DQotICAg
ICAgICAgICAgcmRtYS0+cG9ydCA9IGF0b2koYWRkci0+cG9ydCk7DQotICAgICAgICAgICAgcmRt
YS0+aG9zdCA9IGdfc3RyZHVwKGFkZHItPmhvc3QpOw0KLSAgICAgICAgICAgIHJkbWEtPmhvc3Rf
cG9ydCA9IGdfc3RyZHVwKGhvc3RfcG9ydCk7DQotICAgICAgICB9IGVsc2Ugew0KLSAgICAgICAg
ICAgIEVSUk9SKGVycnAsICJiYWQgUkRNQSBtaWdyYXRpb24gYWRkcmVzcyAnJXMnIiwgaG9zdF9w
b3J0KTsNCi0gICAgICAgICAgICBnX2ZyZWUocmRtYSk7DQotICAgICAgICAgICAgcmRtYSA9IE5V
TEw7DQotICAgICAgICB9DQotDQotICAgICAgICBxYXBpX2ZyZWVfSW5ldFNvY2tldEFkZHJlc3Mo
YWRkcik7DQorICAgICAgICByZG1hLT5ob3N0ID0gZ19zdHJkdXAoc2FkZHItPmhvc3QpOw0KKyAg
ICAgICAgcmRtYS0+cG9ydCA9IGF0b2koc2FkZHItPnBvcnQpOw0KICAgICB9DQogDQogICAgIHJl
dHVybiByZG1hOw0KQEAgLTMzNTksNiArMzM0NSw3IEBAIHN0YXRpYyBpbnQgcWVtdV9yZG1hX2Fj
Y2VwdChSRE1BQ29udGV4dCAqcmRtYSkNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIC5wcml2YXRlX2RhdGFfbGVuID0gc2l6ZW9mKGNhcCksDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9Ow0KICAgICBSRE1BQ29udGV4dCAqcmRt
YV9yZXR1cm5fcGF0aCA9IE5VTEw7DQorICAgIGdfYXV0b3B0cihJbmV0U29ja2V0QWRkcmVzcykg
aXNvY2sgPSBnX25ldzAoSW5ldFNvY2tldEFkZHJlc3MsIDEpOw0KICAgICBzdHJ1Y3QgcmRtYV9j
bV9ldmVudCAqY21fZXZlbnQ7DQogICAgIHN0cnVjdCBpYnZfY29udGV4dCAqdmVyYnM7DQogICAg
IGludCByZXQgPSAtRUlOVkFMOw0KQEAgLTMzNzQsMTMgKzMzNjEsMTYgQEAgc3RhdGljIGludCBx
ZW11X3JkbWFfYWNjZXB0KFJETUFDb250ZXh0ICpyZG1hKQ0KICAgICAgICAgZ290byBlcnJfcmRt
YV9kZXN0X3dhaXQ7DQogICAgIH0NCiANCisgICAgaXNvY2stPmhvc3QgPSByZG1hLT5ob3N0Ow0K
KyAgICBpc29jay0+cG9ydCA9IGdfc3RyZHVwX3ByaW50ZigiJWQiLCByZG1hLT5wb3J0KTsNCisN
CiAgICAgLyoNCiAgICAgICogaW5pdGlhbGl6ZSB0aGUgUkRNQUNvbnRleHQgZm9yIHJldHVybiBw
YXRoIGZvciBwb3N0Y29weSBhZnRlciBmaXJzdA0KICAgICAgKiBjb25uZWN0aW9uIHJlcXVlc3Qg
cmVhY2hlZC4NCiAgICAgICovDQogICAgIGlmICgobWlncmF0ZV9wb3N0Y29weSgpIHx8IG1pZ3Jh
dGVfcmV0dXJuX3BhdGgoKSkNCiAgICAgICAgICYmICFyZG1hLT5pc19yZXR1cm5fcGF0aCkgew0K
LSAgICAgICAgcmRtYV9yZXR1cm5fcGF0aCA9IHFlbXVfcmRtYV9kYXRhX2luaXQocmRtYS0+aG9z
dF9wb3J0LCBOVUxMKTsNCisgICAgICAgIHJkbWFfcmV0dXJuX3BhdGggPSBxZW11X3JkbWFfZGF0
YV9pbml0KGlzb2NrLCBOVUxMKTsNCiAgICAgICAgIGlmIChyZG1hX3JldHVybl9wYXRoID09IE5V
TEwpIHsNCiAgICAgICAgICAgICByZG1hX2Fja19jbV9ldmVudChjbV9ldmVudCk7DQogICAgICAg
ICAgICAgZ290byBlcnJfcmRtYV9kZXN0X3dhaXQ7DQpAQCAtNDExMyw3ICs0MTAzLDggQEAgc3Rh
dGljIHZvaWQgcmRtYV9hY2NlcHRfaW5jb21pbmdfbWlncmF0aW9uKHZvaWQgKm9wYXF1ZSkNCiAg
ICAgfQ0KIH0NCiANCi12b2lkIHJkbWFfc3RhcnRfaW5jb21pbmdfbWlncmF0aW9uKGNvbnN0IGNo
YXIgKmhvc3RfcG9ydCwgRXJyb3IgKiplcnJwKQ0KK3ZvaWQgcmRtYV9zdGFydF9pbmNvbWluZ19t
aWdyYXRpb24oSW5ldFNvY2tldEFkZHJlc3MgKmhvc3RfcG9ydCwNCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCiB7DQogICAgIGludCByZXQ7DQogICAg
IFJETUFDb250ZXh0ICpyZG1hOw0KQEAgLTQxNTksMTMgKzQxNTAsMTIgQEAgZXJyOg0KICAgICBl
cnJvcl9wcm9wYWdhdGUoZXJycCwgbG9jYWxfZXJyKTsNCiAgICAgaWYgKHJkbWEpIHsNCiAgICAg
ICAgIGdfZnJlZShyZG1hLT5ob3N0KTsNCi0gICAgICAgIGdfZnJlZShyZG1hLT5ob3N0X3BvcnQp
Ow0KICAgICB9DQogICAgIGdfZnJlZShyZG1hKTsNCiB9DQogDQogdm9pZCByZG1hX3N0YXJ0X291
dGdvaW5nX21pZ3JhdGlvbih2b2lkICpvcGFxdWUsDQotICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnN0IGNoYXIgKmhvc3RfcG9ydCwgRXJyb3IgKiplcnJwKQ0KKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBJbmV0U29ja2V0QWRkcmVzcyAqaG9zdF9wb3J0LCBFcnJvciAqKmVycnAp
DQogew0KICAgICBNaWdyYXRpb25TdGF0ZSAqcyA9IG9wYXF1ZTsNCiAgICAgUkRNQUNvbnRleHQg
KnJkbWFfcmV0dXJuX3BhdGggPSBOVUxMOw0KZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yZG1hLmgg
Yi9taWdyYXRpb24vcmRtYS5oDQppbmRleCBkZTJiYTA5ZGM1Li5lZTg5Mjk2NTU1IDEwMDY0NA0K
LS0tIGEvbWlncmF0aW9uL3JkbWEuaA0KKysrIGIvbWlncmF0aW9uL3JkbWEuaA0KQEAgLTE0LDEy
ICsxNCwxNCBAQA0KICAqDQogICovDQogDQorI2luY2x1ZGUgInFlbXUvc29ja2V0cy5oIg0KKw0K
ICNpZm5kZWYgUUVNVV9NSUdSQVRJT05fUkRNQV9IDQogI2RlZmluZSBRRU1VX01JR1JBVElPTl9S
RE1BX0gNCiANCi12b2lkIHJkbWFfc3RhcnRfb3V0Z29pbmdfbWlncmF0aW9uKHZvaWQgKm9wYXF1
ZSwgY29uc3QgY2hhciAqaG9zdF9wb3J0LA0KK3ZvaWQgcmRtYV9zdGFydF9vdXRnb2luZ19taWdy
YXRpb24odm9pZCAqb3BhcXVlLCBJbmV0U29ja2V0QWRkcmVzcyAqaG9zdF9wb3J0LA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCiANCi12b2lkIHJk
bWFfc3RhcnRfaW5jb21pbmdfbWlncmF0aW9uKGNvbnN0IGNoYXIgKmhvc3RfcG9ydCwgRXJyb3Ig
KiplcnJwKTsNCit2b2lkIHJkbWFfc3RhcnRfaW5jb21pbmdfbWlncmF0aW9uKEluZXRTb2NrZXRB
ZGRyZXNzICpob3N0X3BvcnQsIEVycm9yICoqZXJycCk7DQogDQogI2VuZGlmDQotLSANCjIuMjIu
Mw0KDQo=

