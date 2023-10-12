Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B139C7C621B
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 03:16:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqkHt-0002Mu-9d; Wed, 11 Oct 2023 21:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qqkHo-0002Mj-Gw
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 21:14:48 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com ([68.232.152.246])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qqkHl-00072G-Kt
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 21:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697073286; x=1728609286;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=CMCIPUHF1C+9j9dQznpI2WwagfidirOjyujUZUqweic=;
 b=CJFhhI7e+P55s4f/uqDn46IoZAV3rQN2KWQMHK4KRZ8DGU4Q7sB2U4Mj
 zMvj8MZZiKOwOtOX4uuith5ma1G5+0Bg4/m3GHG8CylShPf1E08vvWb+c
 uoEcXs2X/v9xOn0etZkCnfanKEqnzB3bEA3BBYyt7xPAJkuDIdRYYV9Mt
 xDpW35wzhkQxI26Vg/Uk2e8HjaVLJJr7B1Hx0zztyqbZco++Wnx4sB/57
 /JMfhdL79zQxZdWAmB4MwVPWpmRcWjZYT7mXY2BQVH+Jksy/VnfImLgHA
 vc/RC6lbez+sfyNDQHCMl6f4BNZesK7gULFvGCYr88/zWCOxOCN93l6hQ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="9840869"
X-IronPort-AV: E=Sophos;i="6.03,217,1694703600"; 
   d="scan'208";a="9840869"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2023 10:14:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZF+mAG5GgEY1ltdzfYXhbOmQfR9MsCy/GdSoJtcUaVgTaF3l74GTOlCLbBeTT6g7DXsVU8hz3h1+iDsZ7FhXnQCphzcth+3gFJQBYc/9k1fy29jK5opl2X+AgJqTmNpkvyj7WEuZ78Nr728MIeyjBMaOb188rr3kapYHFAPBIfF0uzK1uS+6Xi9qUs/xjfq1QJg31l2rNSizh7i3vznIvjBDPArKcrOvhgdu3wUS1UmEzxOfk0P9xNBjB+WZMeKFqOkw93+B3dgkUkYhsemDKi73QlidCiOr4mnMCPeBd4NdoMZwM1dvHldBhA5j95DrgsZfZXz7pPglt4Dur8fiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMCIPUHF1C+9j9dQznpI2WwagfidirOjyujUZUqweic=;
 b=jteZAvYLe05hXz0eY8AfKIhqDhLD+KTrNjw+Y4GuPrqth2phwLdeMvQybmXWXqhq4n5KX9AHAQHIPxKIGMJAMTRgyYpu5apa9n5F7hH1qAvZJ5zO5RVAaioJTOQ6qKhqUc9YIBvrrO+hDeVYbCxockkiBc3e309gNKwjMMASNo1T5U/XWYkYxDTunyg7toGW/H1T+fF8JGkj0Oxx7Fe8yocLkXy8VMA8I2Wui1EnawGa307UQQfhhQtlgWxM7vUTfKHJd8AnaOqQy+8hFL3fo3wDMFge03FHyxg+fFe93r9S3fiRHIGXTBBkUhXuohiFTDZS8S3sPghXeq6JIOq45g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSYPR01MB5445.jpnprd01.prod.outlook.com (2603:1096:604:84::13)
 by OS3PR01MB6037.jpnprd01.prod.outlook.com (2603:1096:604:d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 01:14:36 +0000
Received: from OSYPR01MB5445.jpnprd01.prod.outlook.com
 ([fe80::7b62:381a:d6fc:9136]) by OSYPR01MB5445.jpnprd01.prod.outlook.com
 ([fe80::7b62:381a:d6fc:9136%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 01:14:36 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano
 Rosas <farosas@suse.de>
Subject: Re: [PATCH 1/1] migration: Non multifd migration don't care about
 multifd flushes
Thread-Topic: [PATCH 1/1] migration: Non multifd migration don't care about
 multifd flushes
Thread-Index: AQHZ/IVXnHZR/zS+4U2ldqdEXycamrBFWeAA
Date: Thu, 12 Oct 2023 01:14:35 +0000
Message-ID: <d692b3dc-f480-cdbb-9218-bccc889fa9f5@fujitsu.com>
References: <20231011205548.10571-1-quintela@redhat.com>
 <20231011205548.10571-2-quintela@redhat.com>
In-Reply-To: <20231011205548.10571-2-quintela@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5445:EE_|OS3PR01MB6037:EE_
x-ms-office365-filtering-correlation-id: a61f55b8-716e-436e-ff73-08dbcac09973
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kZ2Rp7rxOSDsNb/iY8TbVXRDbB9tb6BP/MweUPkDeYkR5nIqyPk1Rq2GMSU4Xa7S7RwJFlmu40QFt+EmrnzyUIhq9I4fjmb9huvXNbhKq7B3us1n7aN5kBbQcwm8rrOda3KztatOpvyF0z2pCNte7TvEu6wEeYpif0ZPzwH9k7/dK3GM3FSidnKKL+qwo1zkBraj6+wZdzc32DFYD6bWQ5w6SqsTqRFA/Fq+bPYsy/w+G35Z11sEwYrIKk4tv4D6uwLdSfq/JpGMU0C3BWI3rwiCs45AbxwWGikhtANkXPhnEnjSm088d7EGYxqgsoTd0qZYtnTQfJvh4WeGeDivvyTXBJZlEhCaAKOzlfSN/5WId8gJuRzQnPJThhwiq5bb2Aq85sGhZ1/yibB+wwhnb0nz5FDD/2RZifPjsOeXTYbEkqtShNyiDX8j8H2D9uTMWtYSnayQnbaiXZwEko3tyMyIE0i7yFM7KLwwLwlSxUUbffr8i0c+dUQljIto4/jFqMbgcsm9xKb/3uOf7xU5XhxyWtVAplwrAciCMYsJmxUTAB0RjLyPXBbqS1ZzWzmqXKT014Uyuo09bjzDyBxlzNdZyXQJz8WOc6Q05ECD6/Gs4D8MRJJ0tsBaSboB+1WV0Cpsy9CVm+8jA57ZPFdXjOQd1JQ12TIbWJPhv83Ds437yFuKy/CN8d9yyvEZ3MdV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSYPR01MB5445.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(1590799021)(1800799009)(186009)(64100799003)(451199024)(966005)(478600001)(6486002)(66946007)(54906003)(66556008)(41300700001)(66446008)(64756008)(316002)(83380400001)(8936002)(8676002)(4326008)(66476007)(5660300002)(71200400001)(31686004)(76116006)(91956017)(110136005)(6506007)(53546011)(2906002)(1580799018)(2616005)(36756003)(85182001)(26005)(38070700005)(6512007)(122000001)(31696002)(86362001)(38100700002)(82960400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEFkYnZ5UTBUN2U3NTJIRkNaRkYrY004TFF3SmRoVUlYZEt4M1FxZGMycUVr?=
 =?utf-8?B?SU4ycUJCMm1uNVFYa0xLYWNNVkpHYm5YNDVDdmt0ejJESldYQlhXQnB5SkZn?=
 =?utf-8?B?bTZiZk8xa3daYjNDa2lGQ2hFcWwyWHJvRlBEeTVDWkxmU0x0MWdRSVN2eHVj?=
 =?utf-8?B?OFZEUFhFRG94NEFyTzJpOU1MV1YrQklncDJ2ZlhzRVJFV0lIdS9aeGdXbzlo?=
 =?utf-8?B?NE9NREk1UHdrb1JYaGVjaXUwaVBvTHlEQ3NrRGZhcHZnVytqOGdDODU2eDlz?=
 =?utf-8?B?S3hFc1prY0JlTWVMYTU1Y1dZMCs2UmgxWFFhVFNWNE1wMTVBdnJuUDZ1QStH?=
 =?utf-8?B?Q01tWHpvbDZMOUhBVVdERk5pUU95SHMyWjVWdUlWQlB4Wkhtamx3R09tdVlF?=
 =?utf-8?B?d1V4R2pzcHdvOUpPRHU5RWRPdG9JNnFNVEtIQUJtd0hUeVliS1ZrK0RTN21H?=
 =?utf-8?B?bVV2REJkMjh3YUIreW9sdTQrTWNnbVBWcG1Od2o0ZEN3U0R1RVZ6c1grYnJF?=
 =?utf-8?B?eWhKWmdSWjg5VUswQVJuVk5SZDlXQTc3ZjV1Q3V0S0l3ZDBhTkFKSEs0L3o1?=
 =?utf-8?B?L1U4UHFYalJXUXVNVGczL2x1SG03M0lMcTE0OFFPc2dvd2ExcitMbCtmWTVs?=
 =?utf-8?B?akZKQ2w5UE1yUG5mV2h4TmJ3RjFybG82dnhqcEcrUlAvZkR4R083KzZXZURx?=
 =?utf-8?B?bXRSZ0Q2OXFDaTNSdWZCVXA5clBYUDNZamhLQ2VNU2o5N0RnWDN2dysyenJI?=
 =?utf-8?B?QWhoMHJ4aUNKYyt2Q1FSZFNRNVZTRFYxL0NVR1NSRFdIMUlCcUpaRTYwcEho?=
 =?utf-8?B?UFdoUHlwb244cFNrV0R2Zml1bWNGcFk2dk5ybmN4aHlRcVdtSlhRdGwvU05K?=
 =?utf-8?B?NGJCMUd6YlBPd2RxVVZGODkzbmxTZWI4RUFBYUtvT3RwdHo5MFRkaDZIT3Zv?=
 =?utf-8?B?bk5WZ3ZMdzBhRjhoVUtOMUZOWWNiOUJwNTYwa3NSbGQ5UExyMDFWZVpoVmtI?=
 =?utf-8?B?ZVVtMCs4aXhRQnNRdTVXSE84WGs2azNxRkYzK0xKUk9oN1loU1ZNNjBidllh?=
 =?utf-8?B?b3NpMmtQdllFVUJjM2puaXkwdGswUjdsMFdmSHdSWjE5Mm5EZndodFFZUlJZ?=
 =?utf-8?B?WFVLWDlKaXJRSTdqNkJGVlZDQVA0cmZ0bTl3KzcyQ3ZETjBUOUZNS3ZXd1k0?=
 =?utf-8?B?Z3JQNTlFaFNsSmhVWFd6MDhCeHV1aWFsVUoyV3pWaXNKQ2NmRDVjNGMvWWhB?=
 =?utf-8?B?Y0VjaWFoSW9rdG5KTFdBSXZLdlRDYnNOa3BZeHl0MlkvdmhJY0tRK0kwdUV2?=
 =?utf-8?B?TzdVYm9zdmFvSlpNL255ZGE0QzNzdkkwYTUvbFU4WHZkTkxRRlk0V3RjZjJx?=
 =?utf-8?B?cC9nOGZ4bFRwTURScCtrNUt5RXFoZS85eHFRMi9XeWdRaE01ZjhUSmNaeHhz?=
 =?utf-8?B?UkJ0SW9qOFBGNjR5Sm82Q0ZrQ2xoVHo3cDc2THhGOHlRYkxFSStTUU5RQWUx?=
 =?utf-8?B?SDgxODNyUHVoSG9UcTRGVTQxbjgvaE1ReDhoZEZReFg3WVJUUWJpOVAxNTAr?=
 =?utf-8?B?aFBlRG91cFh0TzZCNnRkUnhVRlZuQ3QrTVZGZXIvbS9BNjJZOExxK2llSW1F?=
 =?utf-8?B?T0grTTk2K3BIZi9EOW9SMkMySytsL2U4L1cyNWtZWmhWaGx1SUNPUStnTFIv?=
 =?utf-8?B?aHVSVWpaWEFjZDFTczl4L0l5bHd5WHBFM1pzek1RVjY4ODJMU3NsK0ZYQ3Nt?=
 =?utf-8?B?SzFSRWtLc2VSb0ZHSmxyZmFFdmd4ODVHRVJWL2IvZjNNME1QVnRhMnZ2bVhY?=
 =?utf-8?B?ZUY5dUx2N1NQUUM2bFhBRHhoTHBoMkJlRjhib3FEd3ZLSEZZSEhJWTJMQ0U0?=
 =?utf-8?B?dFNGMlhTR3Yva3RNU0hyczNqMWJvSk1LTVhId3RVYmdxWERockVxSWhFRkJk?=
 =?utf-8?B?cmlKeGxwd2QwRnY0SUdIbkxBQndrUmRxSk5nbVl5SXdJUTRCVFZlSlpYU2g0?=
 =?utf-8?B?aVFBeWk2M2FWWCtDc0NWL1hMMSs5a1Vxb3FNRkg4dG85MFFXTWF0b1J0UHBZ?=
 =?utf-8?B?d201VDd5eW1Wd2VMTWM2aXF0c2VOeXdnQkJyb3NsY0VoNk9xMkRkRlJhejVm?=
 =?utf-8?B?c1M2cG5xeXlSL1N0ZFl2eFJuZ29WdGNrR1ZKYnMxajY3ZFlkYlcxQmptQnJE?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D816CA7A7B865945B1390EF602791DDF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: y3ulCjNBH+xCWk64MFLrCKJqzXX/5xsXyBMCujqIuKiiS/+YASUTmxsLunDaGLf00N2jamXJPabcdWHPeF9Avvk5UcH3x+aNK2WCuoxonOzeyzFCEnoitz3PiPtflXnHOpnq+hxHfPNO1MXbpJNLhop/Gs7SmU3B/Kbe2pHfGqqiuSCe7mx9UseC0xU7rY9HWuiPwHjBkBqh6zUQQFhK+f/xv77S4hmLFU98xZX1FEz4bqQ/GYHh2cppWTnB5R81O0G4+NvaTXojDdj8tnriMEclLxKixP5iKLx/BwRrBc7Fsw78gvELIdXO2yh2N7UkPkbh0yPWg3rDkVCx2suBM6gXth/vNZG8HQ8c06bT1BEbxpqIAi9jmp2E18RkssDo3+PQGHNJ8bZT4KTHggUJOwiwdGUZTTpFIE4RgbgwAcFOpauHZf+N/w4o7HiC4wmyv+hmevE3ufr+QbwelfqN/Kqvc/j2EGS8uHbtW7vmk7zN0s7vty9hAuY9Y2WkbfFkpmMypK6X+l1Igc59hoTo32zT7ssO47a90MW2yw11IFzIassRJH2jA7o062z2LNw80cFvWre1eLzPAkniV96/PCpQ1AurtdQmWOXzYIjmmHk2BSXou40p1TSuI/WqmfnibZ0PzuXq02yCzGr242vZHgA3cQlr5DzPvTacfYyR5dVgDhb/x9ad5gzDTxxNhpiyVhC3SK2QlrSQwWZJCQjXzqTMondJ/6K5BGDEfpuNsQc8xX4Nu3LDpj0P7+nNUfXd5Rw87Bz/iDj7w/Im89xhVzojeTIyEVXuCtbky1jMirii06E2otbPqK7qPgMnUK4h
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5445.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61f55b8-716e-436e-ff73-08dbcac09973
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 01:14:35.9585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zYR3pil2J1TG4oNn4Eaxnka7Yr9AEw7S+SukgVfdCWtj8NvB8YBRtgQNXzKu8uTAMVYMnS1bNGsi2TlejRukAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6037
Received-SPF: pass client-ip=68.232.152.246;
 envelope-from=lizhijian@fujitsu.com; helo=esa2.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -76
X-Spam_score: -7.7
X-Spam_bar: -------
X-Spam_report: (-7.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

DQoNCk9uIDEyLzEwLzIwMjMgMDQ6NTUsIEp1YW4gUXVpbnRlbGEgd3JvdGU6DQo+IFJETUEgd2Fz
IGhhdmluZyB0cm91YmxlIGJlY2F1c2UNCj4gbWlncmF0ZV9tdWx0aWZkX2ZsdXNoX2FmdGVyX2Vh
Y2hfc2VjdGlvbigpIGNhbiBvbmx5IGJlIHRydWUgb3IgZmFsc2UsDQo+IGJ1dCB3ZSBkb24ndCB3
YW50IHRvIHNlbmQgYW55IGZsdXNoIHdoZW4gd2UgYXJlIG5vdCBpbiBtdWx0aWZkDQo+IG1pZ3Jh
dGlvbi4NCj4gDQo+IENDOiBGYWJpYW5vIFJvc2FzIDxmYXJvc2FzQHN1c2UuZGUNCj4gRml4ZXM6
IDI5NGU1YTQwMzRlODFiM2Q4ZGIwM2I0ZTBmNjkxMzg2ZjIwZDZlZDMNCj4gICAgICAgICBtdWx0
aWZkOiBPbmx5IGZsdXNoIG9uY2UgZWFjaCBmdWxsIHJvdW5kIG9mIG1lbW9yeQ0KDQpTaG91bGRu
J3QgdGhlIEZpeGVzIHRhZyBiZSBsaWtlWzFdDQpGaXhlczogMjk0ZTVhNDAzNGUgKCJtdWx0aWZk
OiBPbmx5IGZsdXNoIG9uY2UgZWFjaCBmdWxsIHJvdW5kIG9mIG1lbW9yeSIpDQoNClsxXSBodHRw
czovL3d3dy5xZW11Lm9yZy9kb2NzL21hc3Rlci9kZXZlbC9zdWJtaXR0aW5nLWEtcGF0Y2guaHRt
bCNpZDM3DQoNCg0KPiBSZXBvcnRlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3Uu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKdWFuIFF1aW50ZWxhIDxxdWludGVsYUByZWRoYXQuY29t
Pg0KDQpSZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KDQoN
Cg0KPiAtLS0NCj4gICBtaWdyYXRpb24vcmFtLmMgfCAxNCArKysrKysrKy0tLS0tLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvbWlncmF0aW9uL3JhbS5jIGIvbWlncmF0aW9uL3JhbS5jDQo+IGluZGV4IDJmNWNl
NGQ2MGIuLmQyNWJmZjI0OTYgMTAwNjQ0DQo+IC0tLSBhL21pZ3JhdGlvbi9yYW0uYw0KPiArKysg
Yi9taWdyYXRpb24vcmFtLmMNCj4gQEAgLTEzOTUsNyArMTM5NSw4IEBAIHN0YXRpYyBpbnQgZmlu
ZF9kaXJ0eV9ibG9jayhSQU1TdGF0ZSAqcnMsIFBhZ2VTZWFyY2hTdGF0dXMgKnBzcykNCj4gICAg
ICAgICAgIHBzcy0+cGFnZSA9IDA7DQo+ICAgICAgICAgICBwc3MtPmJsb2NrID0gUUxJU1RfTkVY
VF9SQ1UocHNzLT5ibG9jaywgbmV4dCk7DQo+ICAgICAgICAgICBpZiAoIXBzcy0+YmxvY2spIHsN
Cj4gLSAgICAgICAgICAgIGlmICghbWlncmF0ZV9tdWx0aWZkX2ZsdXNoX2FmdGVyX2VhY2hfc2Vj
dGlvbigpKSB7DQo+ICsgICAgICAgICAgICBpZiAobWlncmF0ZV9tdWx0aWZkKCkgJiYNCj4gKyAg
ICAgICAgICAgICAgICAhbWlncmF0ZV9tdWx0aWZkX2ZsdXNoX2FmdGVyX2VhY2hfc2VjdGlvbigp
KSB7DQo+ICAgICAgICAgICAgICAgICAgIFFFTVVGaWxlICpmID0gcnMtPnBzc1tSQU1fQ0hBTk5F
TF9QUkVDT1BZXS5wc3NfY2hhbm5lbDsNCj4gICAgICAgICAgICAgICAgICAgaW50IHJldCA9IG11
bHRpZmRfc2VuZF9zeW5jX21haW4oZik7DQo+ICAgICAgICAgICAgICAgICAgIGlmIChyZXQgPCAw
KSB7DQo+IEBAIC0zMDcyLDcgKzMwNzMsNyBAQCBzdGF0aWMgaW50IHJhbV9zYXZlX3NldHVwKFFF
TVVGaWxlICpmLCB2b2lkICpvcGFxdWUpDQo+ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiAgICAg
ICB9DQo+ICAgDQo+IC0gICAgaWYgKCFtaWdyYXRlX211bHRpZmRfZmx1c2hfYWZ0ZXJfZWFjaF9z
ZWN0aW9uKCkpIHsNCj4gKyAgICBpZiAobWlncmF0ZV9tdWx0aWZkKCkgJiYgIW1pZ3JhdGVfbXVs
dGlmZF9mbHVzaF9hZnRlcl9lYWNoX3NlY3Rpb24oKSkgew0KPiAgICAgICAgICAgcWVtdV9wdXRf
YmU2NChmLCBSQU1fU0FWRV9GTEFHX01VTFRJRkRfRkxVU0gpOw0KPiAgICAgICB9DQo+ICAgDQo+
IEBAIC0zMTg0LDcgKzMxODUsNyBAQCBzdGF0aWMgaW50IHJhbV9zYXZlX2l0ZXJhdGUoUUVNVUZp
bGUgKmYsIHZvaWQgKm9wYXF1ZSkNCj4gICBvdXQ6DQo+ICAgICAgIGlmIChyZXQgPj0gMA0KPiAg
ICAgICAgICAgJiYgbWlncmF0aW9uX2lzX3NldHVwX29yX2FjdGl2ZShtaWdyYXRlX2dldF9jdXJy
ZW50KCktPnN0YXRlKSkgew0KPiAtICAgICAgICBpZiAobWlncmF0ZV9tdWx0aWZkX2ZsdXNoX2Fm
dGVyX2VhY2hfc2VjdGlvbigpKSB7DQo+ICsgICAgICAgIGlmIChtaWdyYXRlX211bHRpZmQoKSAm
JiBtaWdyYXRlX211bHRpZmRfZmx1c2hfYWZ0ZXJfZWFjaF9zZWN0aW9uKCkpIHsNCj4gICAgICAg
ICAgICAgICByZXQgPSBtdWx0aWZkX3NlbmRfc3luY19tYWluKHJzLT5wc3NbUkFNX0NIQU5ORUxf
UFJFQ09QWV0ucHNzX2NoYW5uZWwpOw0KPiAgICAgICAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+
ICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+IEBAIC0zMjYxLDcgKzMyNjIsNyBAQCBz
dGF0aWMgaW50IHJhbV9zYXZlX2NvbXBsZXRlKFFFTVVGaWxlICpmLCB2b2lkICpvcGFxdWUpDQo+
ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiAgICAgICB9DQo+ICAgDQo+IC0gICAgaWYgKCFtaWdy
YXRlX211bHRpZmRfZmx1c2hfYWZ0ZXJfZWFjaF9zZWN0aW9uKCkpIHsNCj4gKyAgICBpZiAobWln
cmF0ZV9tdWx0aWZkKCkgJiYgIW1pZ3JhdGVfbXVsdGlmZF9mbHVzaF9hZnRlcl9lYWNoX3NlY3Rp
b24oKSkgew0KPiAgICAgICAgICAgcWVtdV9wdXRfYmU2NChmLCBSQU1fU0FWRV9GTEFHX01VTFRJ
RkRfRkxVU0gpOw0KPiAgICAgICB9DQo+ICAgICAgIHFlbXVfcHV0X2JlNjQoZiwgUkFNX1NBVkVf
RkxBR19FT1MpOw0KPiBAQCAtMzc2OCw3ICszNzY5LDcgQEAgaW50IHJhbV9sb2FkX3Bvc3Rjb3B5
KFFFTVVGaWxlICpmLCBpbnQgY2hhbm5lbCkNCj4gICAgICAgICAgICAgICBicmVhazsNCj4gICAg
ICAgICAgIGNhc2UgUkFNX1NBVkVfRkxBR19FT1M6DQo+ICAgICAgICAgICAgICAgLyogbm9ybWFs
IGV4aXQgKi8NCj4gLSAgICAgICAgICAgIGlmIChtaWdyYXRlX211bHRpZmRfZmx1c2hfYWZ0ZXJf
ZWFjaF9zZWN0aW9uKCkpIHsNCj4gKyAgICAgICAgICAgIGlmIChtaWdyYXRlX211bHRpZmQoKSAm
JiBtaWdyYXRlX211bHRpZmRfZmx1c2hfYWZ0ZXJfZWFjaF9zZWN0aW9uKCkpIHsNCj4gICAgICAg
ICAgICAgICAgICAgbXVsdGlmZF9yZWN2X3N5bmNfbWFpbigpOw0KPiAgICAgICAgICAgICAgIH0N
Cj4gICAgICAgICAgICAgICBicmVhazsNCj4gQEAgLTQwNDYsNyArNDA0Nyw4IEBAIHN0YXRpYyBp
bnQgcmFtX2xvYWRfcHJlY29weShRRU1VRmlsZSAqZikNCj4gICAgICAgICAgICAgICBicmVhazsN
Cj4gICAgICAgICAgIGNhc2UgUkFNX1NBVkVfRkxBR19FT1M6DQo+ICAgICAgICAgICAgICAgLyog
bm9ybWFsIGV4aXQgKi8NCj4gLSAgICAgICAgICAgIGlmIChtaWdyYXRlX211bHRpZmRfZmx1c2hf
YWZ0ZXJfZWFjaF9zZWN0aW9uKCkpIHsNCj4gKyAgICAgICAgICAgIGlmIChtaWdyYXRlX211bHRp
ZmQoKSAmJg0KPiArICAgICAgICAgICAgICAgIG1pZ3JhdGVfbXVsdGlmZF9mbHVzaF9hZnRlcl9l
YWNoX3NlY3Rpb24oKSkgew0KPiAgICAgICAgICAgICAgICAgICBtdWx0aWZkX3JlY3Zfc3luY19t
YWluKCk7DQo+ICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgICAgIGJyZWFrOw==

