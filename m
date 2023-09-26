Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C191B7AE501
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 07:26:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql0Yx-0005od-Qp; Tue, 26 Sep 2023 01:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql0Yt-0005oU-El
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 01:24:43 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql0Yr-00021E-6m
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 01:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695705880; x=1727241880;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=y6LLEfsb0N2ie97xiZzg5cdcH6Dm0Nk2aoaD5h8HAOM=;
 b=gce1JbxPFOGHKuXxOH/zbB4NuJVp//VDZbZP6nG+VzawQUwzNZWEOf2/
 PgRQwpSx2vWaHWgu1LlqxpiL5x5rThTBEouqOmIW2mDMkgziHsOvONkzb
 hu2i394P7bHU5D1jxAuh9O1WtneBv5fPl5lKpBucd/89u5wCaxkLcr223
 rSMJcaunIsOW/X41PJMAN1dn9aikGV8pCwr+NWwLOuXtyUU2qlrq6DE9F
 XqrW/zVJnsEbKhYD5a6nPQVhsENXGkVvV2EWFPFgXP0tGQpCyP/TT7Kee
 5V73iOBXdKiD/UATbnLYHM4y+LBNb8zeptfCZlV+xYjFiSPi5BIzMUu88 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="97268559"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; d="scan'208";a="97268559"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 14:24:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A90MCKsm9oy3JNrgmmlu69TfqbnRAv+qGHVHqBbRRVtn67/0SfXu/Gw18t00qzCGW7PX4Vje3ybD4QhNF9hGJSuEOv6F7oML0U6QuQjbN8QTdvbO1j+gc9WRF3eWbesfrC6EZctneiNqfRxzqfOXR4AdEecmqb2RzDn4lmyAGzvgjYqLMbOlS0eNderiVb5xOR2sZ1HmuhCyh77gIuZG44l1zTX10ZhTRitjNfUo8ZLPFx78nttoLd/3nRf2648U2L0kMqCKq4TPDzE2Our6dbq4qBESA4cZVrqCvecGI/0z8BeGAzZWZ973zBFjoFASyISGQV/a3QRwpvM/ba+gmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6LLEfsb0N2ie97xiZzg5cdcH6Dm0Nk2aoaD5h8HAOM=;
 b=Uw8jRBUbtM5ZYBQ4ws/yZSZg3PSzxYuMoRrINutZQzfYUrfj3tdaV42WVLLGkNid4k6hFydmI8MQoaUZdlAJXcJ/ZU/6v50GqCLZV+8ASnz/x3KwgYWHEl6RiDF99p8x6UDXII5lCcZyeyq7/wiAir2X8OEmRE+YcHTYFMK4U9zpZEUh+8RgbOQlfH9KIp/t41vZVs6awF/Hk6Azrm4dBhoUJdZwf+t3Dd5HUbebweNPhF/gFfYRRhtLxRtNNN+odr/HuYVjKrFiMBe06FglJygANmnWO28n/wse+aBrWg59EA0UNMpKAxRT+Z7ZIrDfEf5hwcnPpQuLIm1yboq+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OSZPR01MB8123.jpnprd01.prod.outlook.com (2603:1096:604:165::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 05:24:30 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 05:24:30 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 39/52] migration/rdma: Convert qemu_rdma_write_one() to
 Error
Thread-Topic: [PATCH 39/52] migration/rdma: Convert qemu_rdma_write_one() to
 Error
Thread-Index: AQHZ6j9fgex1HQn4skmnwwB9vRYjH7AsnvOA
Date: Tue, 26 Sep 2023 05:24:30 +0000
Message-ID: <ac8b29e5-c722-9b55-c93e-4d4f2c87399d@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-40-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-40-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OSZPR01MB8123:EE_
x-ms-office365-filtering-correlation-id: 8ba63a87-a9e0-47b3-a6cd-08dbbe50dc53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KUq6Hf07NYDDuAa5GGBr7ubANLvCZUextRPJ6IptFGIOe4CpMtBUDAOH9u6b8JaZBjesjx00azogYevajKwDCvYn3Alz1p9xJJoErHLepBEbz9+e6zxterF79X8Ep83+Rii2GvqzUXzoM+g3onGwl1ZCv/5/5vC5KOAc9MFFyRBGkEIkvbmuM1JsAAaVRxgw7VPQ66QMHFixr6R5Y+0RGDx/wHvSPKbnXHVFGdI/nZMZ00fUaKNgi4HL++eAvJlSiPqEvUWcCAZqh8aFEBJvHdktc5mQ7qJeiZaeQu/34+nxNh1tEda1yTq6y3rhGPW6yxvE5W1eG0Ft3j8xlU31TeZQRML/xXVylHZBOSMcPkITFVo+VQjOTCN4u+yvWXoa33ovXiZVCmDgCidTn9Xnqu6sPfDlL3lMc7miggTCZnfaoduSS7mYsk/ruYchX/5fJ78gQ5lqHTS1M7W/TPZnQeMxC75KveAXWVVnuS5hup8zShprv1ce2RCdN7NyDM0R1OOdNrbEjo2HXNFA4xxdNwUKBMPoKP7GGVxkLt5JvRQk1UEdyyv/wljlYaSuJpB9efO/fiivkSR6jq1Lu4vv/+tEhYGwlUOibve7oKzQ1SopOzKlIXHy1RCYtDDIk8I+OhkH1e0alSe/Fw+/3lLDHKciYhDLuypgiAGVL25LTg1rro963VZJiAYmfYKi2CtiofIXcKbtWl2Kws3vsjCPnA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(1590799021)(186009)(1800799009)(451199024)(38070700005)(36756003)(122000001)(38100700002)(82960400001)(85182001)(86362001)(31696002)(31686004)(1580799018)(76116006)(53546011)(6512007)(5660300002)(66476007)(2906002)(2616005)(4744005)(478600001)(41300700001)(316002)(66556008)(66446008)(54906003)(64756008)(91956017)(110136005)(66946007)(6506007)(71200400001)(6486002)(8936002)(8676002)(4326008)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXlKUmxQc0pBc2FVa3h5UnlMNmtUWis4eTBsTkw3b08yZTBrVFAxMW85ZnVu?=
 =?utf-8?B?ZFBid0RhSzZZUE1ESHl3RHJXOVc2dWd1NEZUa2NuSWg3MWJLODVxK2pYTHZw?=
 =?utf-8?B?bWNvSXdadVhYSVNaMkUwV0ViOFdUYWV2ZnV6Z29Ob1owRXlnUHB1bU94T0lE?=
 =?utf-8?B?alMrZzZwcEg0ZS9ITWJsNzJwdlZRNkxJWEVvelYzakE2bTlNV0g1VVJVVERy?=
 =?utf-8?B?aGZaQ2FsMlA5SEREcjliWllIbWxNb3JrdWhLMWt6NmdUaUZVWjBFaEt5bDRP?=
 =?utf-8?B?STFEWUNpN0NPNVhHcjRrK250alZXMG5rRUpoRWZRT2ZieHd4UUNpMjJHaTlN?=
 =?utf-8?B?TXpGMkhQMVloc0d6RFJxR2ZpckFGaU92bmRNOGk4U3FMQ3hiTmVGU2RtNnFr?=
 =?utf-8?B?UUZFVUVmTjU1c2hNd051S0lSUGxWelZsYjNkNWd1MXcvbDkvcmVldmxjK21z?=
 =?utf-8?B?S0NPUnUyQ3Q2L0ZUbUMyeDRyTnA4ckhaS2hyUkFGRWs0TFQ5dGp3UXltRnFv?=
 =?utf-8?B?WnZ2Y3oxaXdpU0xrQ0dvQkpIbEF4Y1EwV2ZDTVp1RVJTSENjdVhrTi9VMVp2?=
 =?utf-8?B?UUZBRDVabHZaS2w1cEVSdXFCdFJxNnNPRHBjanhHcEVYWEdNVjJPU0hDclBO?=
 =?utf-8?B?WWNWRm81Q01zcVczZ1BpOG1ydlN5YmFCOVNWTDRidTdId01LT2lDc3hTMWlt?=
 =?utf-8?B?NEdDb0I0NzdqQy9qeG45MnR5NmRncUxVaENVMWJQT3RoWWJZU0V0SjNPc24z?=
 =?utf-8?B?c09TRlJFS3RwSHdpSytlZG5IbDlDU1RWcjMwQnIxYlJzL2t5VFRXNElZL01l?=
 =?utf-8?B?c0kyd2Z2MjZOM3IxR2c3Y0pMQks4WkljNUdYSFlmMGw3c0F3cURxTUVhZ1pu?=
 =?utf-8?B?YnlJMCtIUzVQQ05SMWdUelJmSEQ0OVM1T2NVRkQ1ZUI1VFJXVDRsNnFvaVFM?=
 =?utf-8?B?bGxtTmJKcVFCeklNM3VQN1BQS1M4SE5jdTVrWXFvc1dzVkxEY2E2WWVYZW1Y?=
 =?utf-8?B?cVliSEptRmlyQmMwd1p3OHFYZUV3ZGNnQ2Q4UFAraWE5d3RSaE9RMWdDZlIy?=
 =?utf-8?B?UXllU3NKell2dUJnaEtCOEJxWWkrVE1tYXZBMTZ0aXVCa1BaQ3hSNFVWWllI?=
 =?utf-8?B?LzI3V2s2cnVGeWRzd1BJa1YxdDhZSmQ2eWhEYWJ2RE1CMzNtTnU4TnVpMmNx?=
 =?utf-8?B?UXRuLzB0MG90MTI5SmNpbkw2bm1yOEllUGhMMzFva1E0K1dUb2VKQVdHMkg0?=
 =?utf-8?B?bjVFNDU0Nk00UlRZdlJ0ZTQzTHlUODNDUjFnTkpBL3Z2Wkg2Mmt4eGgrYTkr?=
 =?utf-8?B?TkdoY08zYWVyZUNBQTM0NkVEdEZDMDBockQzWXpFUGpGUEZDYlBYN2I5V2hR?=
 =?utf-8?B?c0VJRHg1UXRXSCtGRXBjZTQ4ckx0TWNTcEhJNjVzTFZRakFiQXp0L3Z1Ny9O?=
 =?utf-8?B?VURSMEhHUmdaMnI5S2NkaHJBanl2bXVXNEtGaFN2bVJzUUdac3FVL3Zzc0tC?=
 =?utf-8?B?QXJiZFQ4OENCeTI5ZkpsdWhwNVhId255WWhzazZVWi9rSHBRYnZzeDhCZ2Z1?=
 =?utf-8?B?eHNGSWJrQnBQSldtcVNLbVRLU1EwSGxIMS9LKzBVZGRCUFh0ZXpRT1VWSjFI?=
 =?utf-8?B?b2xac2ZpQ29ocDlBVmpvWVRUb0pjVnR5UGU4MTJVdDZDclZLTkVtZ3dRaGZm?=
 =?utf-8?B?dHR6QnlJM1l3dGVSenBIZm1USXQ2Z0dDTjY0ZjZCeE5ES2ZsSGEvb0t3THY3?=
 =?utf-8?B?L2VCWGl2NFBXcFlmWWxNdENSRTZRZTVGdmNLc21OUHo1QjZrYjMwSHZIWEgv?=
 =?utf-8?B?VWxtYXFhbXNmNGs2MUphVUhOVzM5Y1dqUnd6UTE1ZlQwYzdaMHlDSnFEYitk?=
 =?utf-8?B?TjFCUmdaVTdiTjlHUkNTNDRJSEs0NzZTdVBEbnJ4TUx0cDhCWnIxZTFtcVZN?=
 =?utf-8?B?QVhJZjUyc3AxckkycUIzalVDYURjaEJ6N3RzdzBKOWdRNklBQzFBVlBsdG84?=
 =?utf-8?B?UGNMTk5UbGszZkF4ckNlcVI5ZlBtNGYyYVZKNUpvSGIrYmlMdGVKVUtEa0Ji?=
 =?utf-8?B?YzVEajFVNVZRMUZUYW5sL3lzZzFqRmlhWmU4NlVFazZpSjVzQUNnUXJyeFFi?=
 =?utf-8?B?T3ZUNVdnU0VmMWFoM3pvbFNiRTRDOFd5Zm95ZmlYUktINndJYzBmdlNaR2Q2?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A609A8EF90C19D4483D3598592E90F5C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dz/+cpoP2lfDsXsLU10JqcLVChmPsFuXNU+IpcSvHtHsIHume3SfTBe/IWXlUYsewvBuRexoqFFGkHy8TGyrbhb61g9KxPHJOFxgs2mRtw2gyIrkxjpWXPHAkdqTRRxuB1NMEPgMXN8hCA+hdJix71Fo+gwckZ036mApI9Am5SzPdrBfgByx0UJhOfGKiZJ6cNcHNXmtdcH3Cq95AfjGSke34im3e+SP7OBROPWxwmvFxf9XTp+t8z/0NE7HkSWRnxSSZPq4QW+HMd7wnQhgB6IKk3lk6af4fNSPrtX8rtFlULMbRVTjYJTEdbayi5Xm1F/m11GpBBnhU4gCLq6UGGMJQnnmyuNQ/by+ZsJNKVDTE/QtQuOaMJeKxGqR6a8D01WPWYG4KDgjp6ZiqZmPUOzB1ZN6kI/Jcw/1BGSKEIFuDO2SncCFY53+LAoTFmuEvsOriwWbUEvJV1O8oYIRAkTstJ9dBuGITwV8c0xAv0qV8IubFZr4xG5pxyJt9SiglunlvGs4GdHjpzs8RhQ4/Gl7nY2jLMjFYzcWooLyJYuUugx8TpQA69nmLHWjy7z42HyzC+kesXKkeyZoo/jbzUCy61RL9rcxicr93G1c4dRjw+KuvbYS3sGJ5ItR4XOj/V+T36DnwAga2eB5O5wY4vYbS2/rk91veVhCPFPnSnX+w90bUgAYPfuzmXSWRKSU1B7t6wtlIVo3qF+MRsN8xnJpuUt5fc4o5xg+X9KZE1dob7vyUzLq1wwq7AOAuBqF6tk50W0zPoGYR1iJEHJOuEiO8QWgmPeDzmY8lyMHqko=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba63a87-a9e0-47b3-a6cd-08dbbe50dc53
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 05:24:30.6149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VGvKr2a3vs/hpRdXtWw/UsEBH1p507NzOdhxahZDgwG+tZWLmKtDXCSr8HSAc4wbW7f+A0WwAqDe6H/gtjyOuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8123
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBGdW5j
dGlvbnMgdGhhdCB1c2UgYW4gRXJyb3IgKiplcnJwIHBhcmFtZXRlciB0byByZXR1cm4gZXJyb3Jz
IHNob3VsZA0KPiBub3QgYWxzbyByZXBvcnQgdGhlbSB0byB0aGUgdXNlciwgYmVjYXVzZSByZXBv
cnRpbmcgaXMgdGhlIGNhbGxlcidzDQo+IGpvYi4gIFdoZW4gdGhlIGNhbGxlciBkb2VzLCB0aGUg
ZXJyb3IgaXMgcmVwb3J0ZWQgdHdpY2UuICBXaGVuIGl0DQo+IGRvZXNuJ3QgKGJlY2F1c2UgaXQg
cmVjb3ZlcmVkIGZyb20gdGhlIGVycm9yKSwgdGhlcmUgaXMgbm8gZXJyb3IgdG8NCj4gcmVwb3J0
LCBpLmUuIHRoZSByZXBvcnQgaXMgYm9ndXMuDQo+IA0KPiBxZW11X3JkbWFfd3JpdGVfZmx1c2go
KSB2aW9sYXRlcyB0aGlzIHByaW5jaXBsZTogaXQgY2FsbHMNCj4gZXJyb3JfcmVwb3J0KCkgdmlh
IHFlbXVfcmRtYV93cml0ZV9vbmUoKS4gIEkgZWxlY3RlZCBub3QgdG8NCj4gaW52ZXN0aWdhdGUg
aG93IGNhbGxlcnMgaGFuZGxlIHRoZSBlcnJvciwgaS5lLiBwcmVjaXNlIGltcGFjdCBpcyBub3QN
Cj4ga25vd24uDQo+IA0KPiBDbGVhbiB0aGlzIHVwIGJ5IGNvbnZlcnRpbmcgcWVtdV9yZG1hX3dy
aXRlX29uZSgpIHRvIEVycm9yLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFya3VzIEFybWJydXN0
ZXI8YXJtYnJ1QHJlZGhhdC5jb20+DQoNCg0KUmV2aWV3ZWQtYnk6IExpIFpoaWppYW4gPGxpemhp
amlhbkBmdWppdHN1LmNvbT4=

