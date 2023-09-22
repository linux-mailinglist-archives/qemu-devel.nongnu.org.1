Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CF67AAAC8
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 09:51:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjaw6-0000aQ-2G; Fri, 22 Sep 2023 03:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjavu-0000Ze-IJ
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:50:38 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjavr-0000CY-Nv
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695369036; x=1726905036;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=SRUo8oGc6dYyBqJnxA1HtlxGKctpyuzDF8ISS5pQibs=;
 b=ILGQ5+NGhIJHBsMdv5jl1cOoIddyQr1+cRjDvdhfiJS/Z0yh6yopDl5J
 hRbxDCmNf1L0U4HTbK8Z5tB5zDUXsSJ25+A/GhBxSAsUEjVQC7iwBeKl8
 3nRCdavJHz7QxyJwL25oMGprO0lWWyvTflD92VId+CBuzb0s9s61NK2dW
 hsQfCdszF2/ca0vRWj5mmOW8xG9G7OdlKReO/2RltdyzwPSLPEASOTtH5
 gfbYzIUQQV4Ag31A7y0i3Y4hvw2hltjuqH4Oc4M/FkCTJxshB5an2t9Gt
 S+spbNyZcL2KAd0haqUWcZKLbXPlM816X/9wx5/+Az4yUEo9KrrIGiQXm Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="7281164"
X-IronPort-AV: E=Sophos;i="6.03,167,1694703600"; 
   d="scan'208";a="7281164"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2023 16:50:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEUSPiWTM4E+EN5Y1v+gDmWkvOw7DRgFn0km8gEEe97ptq+dMyQfj4jVVe1cHbjK0Xlk9NBS8cmd3SJR3wBht1V8cSwX75w3jlbhFHYLLW4T/pcsIQzZ2YCCSTSWCFG+btYU86SBoz9HkuDILrXWOj0pM40wVwZymuU028lFJ0aOCvb1sx1GVGSDDdFW6YHvZBBtGHWTQTU/BcNJ5WjE2YmJptKZkhWnrI+ot7w8uWYl83Aw+hlnojk/uozA6UV4OPhiRQdolNMkcP3M6bpb6jkpPnuTM2VLZ40+OyNHEjOIcE07HM9LVT227pEubUb0FGkFfKmpt8zbEvxtyN3uDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRUo8oGc6dYyBqJnxA1HtlxGKctpyuzDF8ISS5pQibs=;
 b=L86sNYRuVIQqekXTai/iqEdSY23UsjLyc6NBXsL+1L93lQYWWgLegBzFEHhf2PePKydMM5j5FROGNK/8pACTzsJykE0+9dCESCit5X+GwURP25u7h5cc6Ef9wV1HDrdQToTg//Q4GB9SEEhGCWuu+gO7mNMOFdjt/JYOGAzzp9dM9d0skSUlNfYGAuKxWJOHnRFknQrTHDJf/FqVmBpgLkLnnIg1i7AuIRBF1ALh3vEPFKEqFSn1Mpf2Xj5Bc/CUFNmJFRdLMWxo7gTvZDINLEoGiFV41PXdcebW8UPn8wKNUiSB1lC3621BrlhVvXtVdSeTlvypl45EhWICndobGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TY3PR01MB10339.jpnprd01.prod.outlook.com (2603:1096:400:253::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.22; Fri, 22 Sep
 2023 07:50:27 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 07:50:27 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 12/52] migration/rdma: Drop qemu_rdma_search_ram_block()
 error handling
Thread-Topic: [PATCH 12/52] migration/rdma: Drop qemu_rdma_search_ram_block()
 error handling
Thread-Index: AQHZ6j9cEibpGrWCbUqVD0IDjnqr2rAmfmYA
Date: Fri, 22 Sep 2023 07:50:27 +0000
Message-ID: <4a891f13-092c-0611-abc1-e85912d794c1@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-13-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-13-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TY3PR01MB10339:EE_
x-ms-office365-filtering-correlation-id: 3aae9159-915f-4746-a9bb-08dbbb4095f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bZ33cjcW/aPI17hdVda4/zhxrJGLF0NgmxJTpcpuohHIhRDNYAIcVIKfHVN/GSnJr7FKxmkJOR644sYgEI/cEaXGYyVNZX5Rh7M07x2jdJE+j0ZOWBmhtOiEVvjAM2YTqNXfuu9pt2GsdZ/HYDKZJWam99dlqtfT+ZfCYtXSF9RFUO4Bu4GOAUejyyjXxisyE1PD90717vV8QpvAqWAI1swr8/z8zx1y+eKhXr63ZRlImUdbuVMmjUlArEkHm4VXoz1pPwOwvVOs/DJMK0Fj4FCXzrppq/LC4TwhTlrJenMgzJitu9tnuhExBQo9ZoX8C7A+5ebrY1q6hQhYtb6qbPZM6QzgoPzcpoQtHbJ5rfwgYhVmhaz3cT+6ckFqZ2USLMum+N6j+E9cUSlbfafKavpxGppiX4Bc1OJ+TN5Dbqocgsh9W9EfZQjcRSDlawz0WbOS/vrCx4aGuBi3aA1v/lj2EyKfuW4T3cEVdQDWY39hOb2uaNwmRltdZMZiVeEYBv4DTtkULe7jaLIBRnHut2Zbs3WqxqM7uID7giVpZGXicJddg4BBtueIxWNgFwBeaj+i2qg3YuakdO3SfHK8kDYZOv2K+1vMtik+1kwcNXMPsOTRyySrs8+YxPJNKey3S8Lr/mOTTQ0/P9csxPYeta8h2k2wTDxaV9AU4NtlK1PNzo2kBg2PY2o8OAtkUpw0nrqt+B4URWKoCI7pI6SXKg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199024)(1800799009)(186009)(1590799021)(31686004)(71200400001)(6512007)(6506007)(53546011)(1580799018)(36756003)(122000001)(82960400001)(85182001)(6486002)(31696002)(558084003)(2616005)(38070700005)(38100700002)(86362001)(2906002)(66446008)(478600001)(83380400001)(26005)(5660300002)(41300700001)(316002)(110136005)(66476007)(8676002)(4326008)(66946007)(91956017)(8936002)(54906003)(76116006)(66556008)(64756008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXlZRjkzcTFxSVFEQzI1NkpHZDBSNDFzT0F3aHpMSkg5Mkx6Vnd3VWduV2hw?=
 =?utf-8?B?RmVVTUNUc2gvM2dVVW5rWWQ4ckFLTUIvUjI0eS9zd1JXeTB3eFdvVDIzcmhB?=
 =?utf-8?B?djV0em1kcld3aFErZHgzamZiaTRMR095aDlJUUlEdjFreExRR1dPcHdBdFNX?=
 =?utf-8?B?UWJ5MzhZT2pjZW90L256d2lCS21GYWVGRWxNbEU3c2J1UHdIMUlQdC9nS01U?=
 =?utf-8?B?YzNDeVVJZ0NoV1VZZ0hRcGNGLys2ME55L2VOUmtCNnROdU16V2lBNFEzK3RB?=
 =?utf-8?B?RTI3eWNUczBsWFVJMGtSc2Rrcm5RT2pOdFkvSjJpRUZod2g4TTBWelREcEQ3?=
 =?utf-8?B?NVltNmkxUmxKa0lhZ3I0SWtTRXdDWjVlUCtYM1hJWDdLNmNjQitBR2FGKzRm?=
 =?utf-8?B?L3NKU2Q1TE5qME5xaU5EL09jcm5CUlZZOWZFaXRITU5obUkyREFjRDdEMzF2?=
 =?utf-8?B?c3lac0ZYbE9NV0RtT1RCNXJPRUdEOFRNaHRnVVFiVk91bHk2UkF3anZhOUlC?=
 =?utf-8?B?ajA5YnNEZDU4Wk1uWUJZVWlNRFVNN3htcUJvU0NRMGFyVFlzbjdEck1WWlF3?=
 =?utf-8?B?OXIxQm5rT0UvYnFuSmU5MmF1QUlZZnlRM3RpYXVLQy9xUW9sMzJKcnJSczJK?=
 =?utf-8?B?V2tJOU1YYnlYejRKR0RHMzJ0Q1RhV1VjQUhuSS9lajlVZVVaWTUvbFB3MUds?=
 =?utf-8?B?Ym1zRFRuYmhGNDN4d1BoaFYyQnR0ZE14TjZoeFNYeWlyMWdBaWlCd3JYNkJZ?=
 =?utf-8?B?OENOR1g1YThEbW80WUVWb2dFbllGbHF2L3VNR01rZ09xSWtxZjZaRzk3L1RL?=
 =?utf-8?B?UWs5N3hxeWJxdlRKdTBNUWUrTzRJNk5tQnFBUGZYUEVhOC9TNEFEakVBT04v?=
 =?utf-8?B?TjFGSm1qOGpkMDJ6VWhzaDRJRFlpaHVWVmF6bmZjZktxZkNiUzArc0dxQmxq?=
 =?utf-8?B?ZWE2Q0w1UStCL2NtUTdhMzdMcjlidCtoUnY1VHJPa2s3VEZLSURDMlNVN1J6?=
 =?utf-8?B?OWZPS2xEVHI0L09PTmlKdFFJNlF3TDEyMTlBazUvd29NZDFhQVMzSitlUlBr?=
 =?utf-8?B?NDZTcUZQKy9sUlJFa0g1eEFLdW52Yy9FV0NidERjbHdrWUxkY2k4MmlxTVRU?=
 =?utf-8?B?ZHdqNjhkODNGVklKS0huMVRYWkVDY0NWOW9abGdxUndFV09xVUhWNlpTK3c1?=
 =?utf-8?B?ZE9wcU5pY2dPNWcwekJpNkhGQUZlOGxWaU1PejJWV3VyQWg3dVBUdkNGTlZj?=
 =?utf-8?B?bFdwV2k4a2RBdGE0b2duUVJvRytuS2t5VXhlWCtuZ2VmcCsza0JPU0h1RjF1?=
 =?utf-8?B?S0lCTGh3R3p5cG5scERRb29rM2oyRGpEcVJrRk44L2pwQzNaYWMxeU5TZ0VO?=
 =?utf-8?B?ajdlcUd0YkhiMGdhNW1QNncrTFZaOWxCYWY0UEpDV2NvYW9FQ3RKR3c0cDhX?=
 =?utf-8?B?VDJKN0xyeUlBQldjTnhvUDR1cWIwT3dkZDFBR0hwV2FXcFMwblZvbjRFQWVY?=
 =?utf-8?B?eEs2WEtPWUVSYnJIUWpOTFVXOU9JMTd1TmFwUm1lUFBiU0tCMnB5UXBjeG5L?=
 =?utf-8?B?R2FrUlJTc2N2eEZoMWxBYnY5MDVLN1JOUlJrZWFud0dDRkNjMVVrdzNBS3M3?=
 =?utf-8?B?MkxQUm85T0YxcVBYUXFYTUlLL2VVb21taEx1cC93aDJxWXpDdWpzM0ZVUWk2?=
 =?utf-8?B?RFVVNjJHZmJ5T2JZKzBUZ0hoUnJZRE9EbzZQb0gwbHNWUmU1U05SU3UzVEg5?=
 =?utf-8?B?M3RLWUNMQkNDK0MrNTFIbXRTeHVFN2xrUEpqdlNlVjFTOC8yaFFlaXp6d3I5?=
 =?utf-8?B?emRxMStVUExTQzQ5dWVnVEpCaG1CQXJPWll4dTAyWEUreTU3VlNFTjA2cTJZ?=
 =?utf-8?B?Sjc4MjJ4ZDluNzc0eVlLeDlNMUhzSXJHaFowR2FWcXVoQ0VLQnJNTkVuSkxV?=
 =?utf-8?B?akdUNDZQZkdqMDhKNE94aUhRN3BtTEh5ZndGWlA0QWNuMC9nTldiQWNZVVky?=
 =?utf-8?B?bHVUWVBKaHBEcFkzQWlkWUtwWTFZTGR3UXYyYlBPcmIyQ3p5MTJoSERBbU5H?=
 =?utf-8?B?RFdhODlDNHFaNjY5VFBOZHUxb2pJdXpObUN6ODNXZEZMUXkxWll6U2FCL1Yv?=
 =?utf-8?B?L3JVMUJTR3lFL0lRb29TK3BPV1ppWG5EbThQMTE4TVJ2emdISThDQkI2VWcx?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <693CCA3480CE2741824DF27227277A71@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RQRmvH4EdHPUfmKzI5VN73m8eyChRheqJZIICXf/UpIO3EfaM6xS48LBLTnX6KLqBWJ84UeWuKa5dI3L3jMK+SzZKTAQ/I6UiqUfuBdtUhfPUsYDXnY2OK5QUBWIUHqd3WDu0qjHwp1v2kPfSYg05jM3ncBv46I4MClcqYpGX4my3gA26EkUjZqlQO14+NRqEtGR/ejNVPhtY6w4VWwmmsmNU+ec2HRXhEmAXVqCy51xi7vKI6Gj+pNhFc7tKnaBeAgqsVmbOuFh9XSi0JPtI6ztqT/AWohyo6HclHgdAbLpBPll6qrYvHH4RLxdzXxFfM9VxfU9oQWHI9mmnqXOz+OO31OMFEKDb+g7NghRFUQXy1P0vnP0M2lGIL3/4E0ln+hRwN7TGY53b/YMAKK1T4YO0GRqVRe+A7fIkxVXP2CF39TerlyAGMKnlu9nD+8KDaAzXTV+l+7q7tPDjKeZqGSv8eCSVDZUrhX9bWu8Axm9rQn4cCn+L2XDbw1ntLcBf41qeAfEoWwDEjTGYDcRMuuguGzvJRMvpi2oCaewegOPM66olwn1RuHgNDtRqIZ65zQIMFHt4mCumqCuJskILB9XNsvKnhdJny8wQ1RZJAt28Mxo8lfUs/gPXpesSnFJqzgNlLUKyLpKeGY/jwQi/H8/3i7fOwC/E+NTHFdXE2mLCubdMGJg51vGfLFmIz5HuzXoWFG+CYr4EHE2FOENXhAWGPloJsQPDwZrBT2XkpiDFzbD1oh0ZgxkQn/CQl2G3RoeM9gNh2Qn3/UQz+WyFUPF6UsyMMHG9SSkDBnIyYY=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aae9159-915f-4746-a9bb-08dbbb4095f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 07:50:27.0874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MDngiF9mEHrzU6OrnMW5YN3KnQ+j21AhBMlYz9eh6Y6lF/kJ4a2897QmidCgCUXg3eChedIRvN4RpiG1YuvIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10339
Received-SPF: pass client-ip=68.232.152.245;
 envelope-from=lizhijian@fujitsu.com; helo=esa1.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBxZW11
X3JkbWFfc2VhcmNoX3JhbV9ibG9jaygpIGNhbid0IGZhaWwuICBSZXR1cm4gdm9pZCwgYW5kIGRy
b3AgdGhlDQo+IHVucmVhY2hhYmxlIGVycm9yIGhhbmRsaW5nLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTog
TGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0K

