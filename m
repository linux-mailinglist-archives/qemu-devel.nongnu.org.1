Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F767AD034
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 08:32:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkf85-00039k-FA; Mon, 25 Sep 2023 02:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkf83-00039U-5A
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 02:31:35 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkf81-0007Iv-97
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 02:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695623492; x=1727159492;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=lyYEYGGt0QEjS7uuvQqZCpsCXko6otf42/wOnsw7tLk=;
 b=t54ltFNPDjTDhnVJjR2j+qVwBD3BPSf1irc9gclegOnOEFP5sZcX0Pw7
 0oaq63iCPysdmWTJ2yfYezOnMon/faQokk16nDGw7qMn6e3OlAFQA53gL
 PMpg2ccw7+Y7sKXdHAyF4E6c2s9BI2gmVwjhacyq2RJyMrRtEz/K5ffmY
 sDNYrzfXbqUKA5vqOmSx+cZ8ImDSeSo0eZjNog8AlRzAizvWntBVWaMG8
 lX7REM9V8rgtRE9f8cCZzKCt4SG3tC/gkdqhyKEM30TdpG6BtU+nyPbrD
 kvZdKVSLbNfqWpH1+7gtYBV2YNdqwQR5luopdYiQEjGnyEoa1GKp//MK4 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="97110852"
X-IronPort-AV: E=Sophos;i="6.03,174,1694703600"; d="scan'208";a="97110852"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2023 15:31:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn8QJ8/Z1K8l7txjMVnRW0qaG+FnfzIhTjdyPtcdbtzjr//GoDJzk5ZRceNhGSCMNhKx0YgzMx+bps39zoYmIHq5e+/x3T0/xabY5BeTuwh29jZ7J1KxXUMtGFdWo/Hv8oHnNChliKzc6kYQrvTdpFvVRBKCBjsySEUvWRiERA4jMqmFAFz1R7cAEe/zgPZXDJqGZ3PXBDw1ofFsfQfPWvKJgqzQ0Id+wF4kpdTEKa6nCN8FaA6Klufb0PRddkKAqa/sPMeNDXiwURl/t0/cIH0LK634VC8ANhynbGsIn6BbCeIFXQvU9y6xj5gcbvgcdVuNkI/NnIUHQNzKjHquGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyYEYGGt0QEjS7uuvQqZCpsCXko6otf42/wOnsw7tLk=;
 b=VCZa+GcdkIw6HuWZBbETTP4qnjPH7PChTEgy1e6LZqTVtuRBcdkSJgpTHsLM3BcClB4DbnwE1KwDU44F409mOjebd6wFpBuTr6sL7dsdU6Gzu6zAafqvBavSgakvbZbsXcKuFIFVmFtW9iOjfzBPcNkfOuVz0E55nXJLr2zOeZvsO+XebtmfLylaNuMxVP2fZhuSetke5j6ileDsFyrel1C+LzdAQGQ1hbcHithq9tH9FnZ+v+Ik3Q8qSOqQtO3NL3I8DFLbN9UT93Zza2VftG7q5475iC150BKjvq7ABPyxUC8PQ/oWae2HQPR38ZQOyo0dCvkZBydbsaBGrXAa+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYWPR01MB9645.jpnprd01.prod.outlook.com (2603:1096:400:1a4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 06:31:25 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 06:31:25 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 29/52] migration/rdma: Plug a memory leak and improve a
 message
Thread-Topic: [PATCH 29/52] migration/rdma: Plug a memory leak and improve a
 message
Thread-Index: AQHZ6j7Hu2qE/6AsMkemlCQwPKxgsLArH1CA
Date: Mon, 25 Sep 2023 06:31:24 +0000
Message-ID: <3c2c0805-d2bc-e537-8b7b-83475d633856@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-30-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-30-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYWPR01MB9645:EE_
x-ms-office365-filtering-correlation-id: 2e660e3b-a2ff-496d-0f09-08dbbd910aa6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZYbE36TMur93ixaA5xz+WqwynEc+Td6VxzdEXnh9NhFzqmy1mCq0hsX46g5P6V1WefM1+UD52zaU/qyft9s0HJJW/MijG3RttyvPM8na3xKwAbmC2Wiv0ZcBiydwZyGU1Oq+JNxmAKcsPyZW1v1XBjmibMX7H5UgHQj7tJ16agffZLdZukutzkPxEBfs3MHDQEYfoyMhJ2F0fmJizgRADa9P77IzY9zHRl92wgbcyi6FsLwdA0WUcg0yhottU1nXogU9VYJ+HV9rzE80X6IeSMs5aq8tYx9JiOcE42pO8hTB7FlCuaF0Hb39l0jkQGKHnFMHrIaFUTUy/1L+reVxuYRQ196FYAF1VFGkG0Qs02DM6p0FENXvgsL6TqqOvORL8okvbbz9Ofhj0oHhZb7HW4gewFC39SZoT9BGF/nxm3g4lsjiaSNWfxgXjpVR1iYr2xLOV6gybB4tH2Uw/H1X0YsvJtTi3IQRDzLzU80rxeoxT64Mwl/tL9xCQ291CEodung8ZoyKPjCWsEeACYHVOLS9rscc+sfAPbmWeKpe3nKc5QR7dpzi31HtdB7/IMhyD3U7VwzFlYejCR7e0oUZ0+VZapB+5HYJhigELAZSWC8bguOFj7Fl0Pee//QYfb1WwtdEA5YbX1ts5CSkQamo6ny6o+JSu0tPIwAvYIAVp8PVuuBInbgDfaJEMIWsLBZpjhE/QofNKcsMLpnJ0lwiJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799009)(1590799021)(186009)(31686004)(1580799018)(54906003)(83380400001)(2906002)(5660300002)(316002)(15650500001)(41300700001)(8676002)(8936002)(36756003)(4326008)(85182001)(2616005)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(86362001)(31696002)(110136005)(91956017)(6486002)(53546011)(6512007)(6506007)(26005)(71200400001)(82960400001)(122000001)(38070700005)(38100700002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDJuSjE0VjdJbjlDOFBuWWYxVTViUWRoOGxoVk9VVkdBQVd1UnorN1Y3T2FV?=
 =?utf-8?B?a25FL0wvUDFhZjBPRU0xRTQzbWRvdzZEU2NtWkFwT1l3ZERzeEh6Z3dWSFh2?=
 =?utf-8?B?TjMxYmtMNGg4RDRQMlJqTlFhVFZxSTgrWWc1QUVUVUY4V0RuSjBoTHovOEo2?=
 =?utf-8?B?YzVyTjRzbCs5UVQycE5SblFJcmUwY29SVWV2d2M1RzZUN04za1lXMjB3T2cr?=
 =?utf-8?B?d0hBYStPMXNjQWNJaFZOWUtNd3Y5TFI2TEt5OUdpcHk3WHloTEU2VVY4cm50?=
 =?utf-8?B?MHVHaWJpdmN1TWlGUGJZbnNBYWVoaWRCa0lLNUwzQmtXRGIzYjkxN3k4NTM3?=
 =?utf-8?B?ZXJEamJLOXFkdnh6Y2xFUm95d1BXWExTb0wwTkdqelFpOG1NQzNKNHd2VG56?=
 =?utf-8?B?anNjZWM5T21rOEEwbmltWGRMcXRaMG9QVnRISTNXUlJFQjdJRUlZTzBLMEgz?=
 =?utf-8?B?SFdDV2ZwdFV6T1ZoMnA3UTJZS0pkUFhMWUxvTWk2d3Y1SlRzekdjRHdpNFJ0?=
 =?utf-8?B?NTI0dDFZMHMvbUt0K0ZBYVpWT0VBQklBSFhZZDBGN09RSFplUEpoR2RHU201?=
 =?utf-8?B?eVJpbnY5QmFsbjRFMWpQc2syRkZkcHNMaE9IWDc0WjV4cWZ1SFBLbFpYQ1ZN?=
 =?utf-8?B?VzBZb3FFek1OS295N2FmMzVYY1pJYUMwMFpxNVpBR0xoOU10RVJOY0lHeWZG?=
 =?utf-8?B?dlpTcHU0U1V3cjFsb002RTZoeEpYNHhHdzgvTDdObTAvcUVtV29TaGI4emN1?=
 =?utf-8?B?b2FlbU5nOFB4Q243dnYveFNybHdtTCtjN0MwM2hXdUE0VVR0MTJQQXlHSTM1?=
 =?utf-8?B?MVVEZDVRbWs5SUR3cmg2cTRBTmg4L3dWL2pJcXVjREJNWnlyd1R5UEczTFJy?=
 =?utf-8?B?akU5UytZUVdnWGViWDI4SlRpQlNLOXo5WE9uVHJaN1VXZFUxQXJIZFJGUEcw?=
 =?utf-8?B?a3J1SG5mYU1lakFVWDJBcVN1TzZjdklsQzI4TEI3R0UvbmZ1N1pEWTc4dFlG?=
 =?utf-8?B?VHQya1k0cHJHYUxTWUpucWJsQ0VSMm5PNnlIVGwybFhKNHphTkxyS0lxYy9P?=
 =?utf-8?B?MHhEQ3JZUnZxYkpTejNCUWh5SXFBVGdzZ011ZUpKZHcyODdyRFdvTTBNQmk2?=
 =?utf-8?B?UUliblFybUJaeGFrTFgvSGgwN0o2Tm5ROStIVzhyWVdQZWp0VWFDTUpPY2Ix?=
 =?utf-8?B?WFZPQ2ZBRGRjTDQ1OHZCVzBxSUFjWnJqM05wc3JZWVhSU1pKVWpQSFFVdVVn?=
 =?utf-8?B?aG1xM052QVZvYnNrR1R6TGJrNm1yWFZCb2hUT2Z3anhaa1hwckV3ZjRLQlJi?=
 =?utf-8?B?ekRCVlJEeW1YSytUMWV4UFZGV3RXSTRxdStHdUx5Q1RFTGUzR3VVV0R0d3h5?=
 =?utf-8?B?VU51b0d0eHVJQXVhSlNQWXNMWmVIRTVCSnJ0NEpzUElWNTM5SzZEeHd1TkZx?=
 =?utf-8?B?eVZnUU1QZzFOMEF1R01obXdmdms1ODNTZFg3THk5aUdhRVM4SDhjTXd1Q25X?=
 =?utf-8?B?UEpGeFMwalgzdTJDZmJ5UUhvc0hVV3ZDYmwycXlCbGt5RnB2U2tMMExWbTBs?=
 =?utf-8?B?WjNZY0lzbEFOUTI2T2s3ZkhjN3R5SmRyQmZ1T0RmT3dZRFF0bjNLck9waXVi?=
 =?utf-8?B?VnJFdW45d2hTQmZYMldMVko2dTNTL1RCWGhNdTlKS2pCMEVxdzBtaXU2cEFE?=
 =?utf-8?B?VDBSYWEwZjg2ODJ4SVR5NUxubUIwMXFlR2pwSzlMNEE4SzQ2K3hUaHdVYytw?=
 =?utf-8?B?OWY1T200T091WUlEMU5EZW96WncraEtsTGhydy9GUGJabHBwOGlxWnJVZ2pO?=
 =?utf-8?B?THRzY0RBQmhHTzNWL2hVRERYOTVtemlQeGxTR0RTcTFPVWFnK0lBVTZHemRj?=
 =?utf-8?B?Z25qc1pzVWNwbGJBRko3ajZaV3VhTDlod1FoZ0taSHlDUDRSbTUvcEdjRjc3?=
 =?utf-8?B?QWJCaDRpV1ZoTXRtT0t3MVMwc0VoRktNbGlrSVhrOEdQbTQ2VXZvVnA5YTRK?=
 =?utf-8?B?cWdjb0p5SjFwakxtMnNmY1ZHcXdkTHNpb0xwd1ROR01pd0laemIyZUpvb0RW?=
 =?utf-8?B?VFNVVTdnTTZoR3JzUER6Q0JxQWk3eVYvMHBybTcrVUlnRmVnRWhmRk81RFZy?=
 =?utf-8?B?MjNrSkJwK1hjeHMxRTJqK0VQZm1MZHBERmQxTUhNdmFqNW9BdXhLMnA0QTBj?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00941F5034146F42A10B8700CADC7323@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oTEfMkg36fd/L+ZfkmnU/+ut1sgwUdkJik/XSzbjq4pXqmFz0IAQNC2tSDKTIVDgb/NXPCEbL5hX9d1wNRCjduVaC2PJ0o7j7f7nOEFrN62wdRIMlbqpuASX3wCwHnv1mh07aJmmo/3hkv9wC/19sWVPP3TKDIWkzxb+vweQVmmXPE/kKAXYcTqbWheBHkDuXqpWRaPozNvsAbROOL9R5QbFDJ9rQ6d9DjTG/yR1yLBDKDoNzzE2K6wHTLlN1yAGtqXq23lbcYhDDwph+5YqD0+2det9oDa7iMXz3qXCEEe8T04lYMYddU7scCvO84vcCmFJRCx2OQWofKtxsY9YnmaLyfaKrxwaqChn8BgM7v2INBeTL73f/egARlCTAGDRTwOSQ8UEvvw3o0drL3XrUwY1JseCiJd7H2sjXKrIAFkl5+1IF2O06DgX6+haDpvNn/t8XZ1X5tRWw7MQjifWM8zLPKtY64dbptUx+LRrB3+i/G/h6wIKKiI60tL8aeLVndRSTsiDZyYj38lzAGeQy9XdxHYcGNriBTZpN85xftAAXAXxJWHkaiUgKF9HwRiqYgXJ0jWubk6yDqyJk2MDiWWY7vgiAY4KXE5Ltwph/2lEfoGn1KtXLO1bpvl27MWUYdkttAmblV+i4rsQP/6gjwGXrhaitYYofk9WwlP/q6auyNlcOwR/s4y9U7H6S+CPD53j9TfPIC4ATpJu+ZwrA5NNJ0Eyn/iz5EdkX/UEDb2LHRUCQHEeCgq5gFZSC/aBH2InnDW0h/MhjS468UeXgSPwR3p2F+J9kZY1dHbTwr4=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e660e3b-a2ff-496d-0f09-08dbbd910aa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 06:31:24.9609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l1Jqm+YN3C6/6hRtiUP/7seR8BG4GjtRTzGWN201eOlyhkFgKJkc+mnk0Aho8qTUA1KhnK/xQZciuLuFqnZVlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9645
Received-SPF: pass client-ip=216.71.156.121;
 envelope-from=lizhijian@fujitsu.com; helo=esa11.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBXaGVu
IG1pZ3JhdGlvbiBjYXBhYmlsaXR5IEByZG1hLXBpbi1hbGwgaXMgdHJ1ZSwgYnV0IHRoZSBzZXJ2
ZXIgY2Fubm90DQo+IGhvbm9yIGl0LCBxZW11X3JkbWFfY29ubmVjdCgpIGNhbGxzIG1hY3JvIEVS
Uk9SKCksIHRoZW4gcmV0dXJucw0KPiBzdWNjZXNzLg0KPiANCj4gRVJST1IoKSBzZXRzIGFuIGVy
cm9yLiAgU2luY2UgcWVtdV9yZG1hX2Nvbm5lY3QoKSByZXR1cm5zIHN1Y2Nlc3MsIGl0cw0KPiBj
YWxsZXIgcmRtYV9zdGFydF9vdXRnb2luZ19taWdyYXRpb24oKSBkdWx5IGFzc3VtZXMgQGVycnAg
aXMgc3RpbGwNCj4gY2xlYXIuICBUaGUgRXJyb3Igb2JqZWN0IGxlYWtzLg0KPiANCj4gRVJST1Io
KSBhZGRpdGlvbmFsbHkgcmVwb3J0cyB0aGUgc2l0dWF0aW9uIHRvIHRoZSB1c2VyIGFzIGFuIGVy
cm9yOg0KPiANCj4gICAgICBSRE1BIEVSUk9SOiBTZXJ2ZXIgY2Fubm90IHN1cHBvcnQgcGlubmlu
ZyBhbGwgbWVtb3J5LiBXaWxsIHJlZ2lzdGVyIG1lbW9yeSBkeW5hbWljYWxseS4NCj4gDQo+IElz
IHRoaXMgYW4gZXJyb3Igb3Igbm90PyAgSXQgYWN0dWFsbHkgaXNuJ3Q7IHdlIGRpc2FibGUgQHJk
bWEtcGluLWFsbA0KPiBhbmQgY2Fycnkgb24uICAiQ29ycmVjdGluZyIgdGhlIHVzZXIncyBjb25m
aWd1cmF0aW9uIGRlY2lzaW9ucyB0aGF0DQo+IHdheSBmZWVscyBwcm9ibGVtYXRpYywgYnV0IHRo
YXQncyBhIHRvcGljIGZvciBhbm90aGVyIGRheS4NCj4gDQo+IFJlcGxhY2UgRVJST1IoKSBieSB3
YXJuX3JlcG9ydCgpLiAgVGhpcyBwbHVncyB0aGUgbWVtb3J5IGxlYWssIGFuZA0KPiBlbWl0cyBh
IGNsZWFyZXIgbWVzc2FnZSB0byB0aGUgdXNlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmt1
cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCg0KDQpSZXZpZXdlZC1ieTogTGkgWmhp
amlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KDQo+IC0tLQ0KPiAgIG1pZ3JhdGlvbi9yZG1h
LmMgfCA0ICsrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yZG1hLmMgYi9taWdyYXRpb24v
cmRtYS5jDQo+IGluZGV4IDZjNjQzYTFiMzAuLmQ1MmRlODU3YzUgMTAwNjQ0DQo+IC0tLSBhL21p
Z3JhdGlvbi9yZG1hLmMNCj4gKysrIGIvbWlncmF0aW9uL3JkbWEuYw0KPiBAQCAtMjU4Niw4ICsy
NTg2LDggQEAgc3RhdGljIGludCBxZW11X3JkbWFfY29ubmVjdChSRE1BQ29udGV4dCAqcmRtYSwg
Ym9vbCByZXR1cm5fcGF0aCwNCj4gICAgICAgICogYW5kIGRpc2FibGUgdGhlbSBvdGhlcndpc2Uu
DQo+ICAgICAgICAqLw0KPiAgICAgICBpZiAocmRtYS0+cGluX2FsbCAmJiAhKGNhcC5mbGFncyAm
IFJETUFfQ0FQQUJJTElUWV9QSU5fQUxMKSkgew0KPiAtICAgICAgICBFUlJPUihlcnJwLCAiU2Vy
dmVyIGNhbm5vdCBzdXBwb3J0IHBpbm5pbmcgYWxsIG1lbW9yeS4gIg0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgIldpbGwgcmVnaXN0ZXIgbWVtb3J5IGR5bmFtaWNhbGx5LiIpOw0KPiArICAg
ICAgICB3YXJuX3JlcG9ydCgiUkRNQTogU2VydmVyIGNhbm5vdCBzdXBwb3J0IHBpbm5pbmcgYWxs
IG1lbW9yeS4gIg0KPiArICAgICAgICAgICAgICAgICAgICAiV2lsbCByZWdpc3RlciBtZW1vcnkg
ZHluYW1pY2FsbHkuIik7DQo+ICAgICAgICAgICByZG1hLT5waW5fYWxsID0gZmFsc2U7DQo+ICAg
ICAgIH0NCj4gICA=

