Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCCD7A9088
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 03:39:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj8cq-0007ov-Or; Wed, 20 Sep 2023 21:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qj8co-0007o7-6A
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 21:37:02 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qj8cj-0003QX-M0
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 21:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695260217; x=1726796217;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=wjM5co6hewLqM5DX+3Kz+f7vLayz7ajj8iboag+S60M=;
 b=XUBe+51lC07lc1sPCIHB1IqkkXT7cWVyVTXe0MEBHaMf/sU8O20bqnxX
 Cg+8scWmSEiM12A257FbWMwFAFer6quuNtxsPC6ls0HYZAJDaGgcID0Vq
 OEcumBZnfmAAF/t05/ir0wuq8BxjCm3H7GECTyM0LD0x361k7Zf2XNAnJ
 qqH8k3A9qoWkF5HOZbb3Z5bDWBGO9ARpwNXr5KwrGZd3DjlgrJB9aNW0C
 ESSHkSSnWeF2KZsvN/KGiaGV6+q2z8kvdxNtEPjUMqxHA380M7QuFz6TA
 pMeUCxWYyiyFqyUkRaPSlb/oHLWqbbFsUzt4A52od3yajEVEX9A26guT+ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="7080455"
X-IronPort-AV: E=Sophos;i="6.03,162,1694703600"; 
   d="scan'208";a="7080455"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 10:36:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASF1Sv62pEWQVJwWAGIe2VE3JCWA3RgYuks9wzoVf5m1z79oZJSV48YQRz925STjODH8s4J7/1fbRrKyS0oyhMXWf3ZbGwzAUgORZTAy7MzO3ZMyalOcM+US3dPvevquukdpQWOaBlcYXez4RDPVsBMFWCPRxvLlGafP6rf1OQ/5ZWI95yt+6MrOx4dk3vK8vQByCtWP2IWpImY5xnoL/YJPsMZHC1Eh8baK9/aQOMOaAWReaXzt/PhQHdhT2bwwgclCWe01v3nRwsPM5phQ2jpQA5TVydy0J1DHqbTPo4TQwKKUlaWiFpEmr6rZUyh5V7asCpEd3lzpSVLYoWvdeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjM5co6hewLqM5DX+3Kz+f7vLayz7ajj8iboag+S60M=;
 b=Z29Ml/SdG/NpPQ6GQWXviIDzXRTuSVhaOkGvd2csMYXxkFdRduQ/kLbmSfD1V/P4vmcb0aqQllE/RK223SExAE93CbnoHRFkVDkKLi4yew6N+YPuWchzNf7mAiwM17vIbIKiDQq+DGFSWLccksRGT40Xd8FnZWdj6cHdUiXkCvwn0tUtOibIP49iV2vl0fI/Y7Gq6z/crmCfl9JeZIeCEB5liaIrg0S2UO55Q32PzbKVlIwPmuUkoUSMRpKyMyYcuew+7D03v0b+UuqJ/D9IRkxJfcsvw+7Z2ylZqAmYeNzZa1nhUM9ATovYI7NCrdxGE/ljjkxvU/fcqm2iX58L1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB8374.jpnprd01.prod.outlook.com (2603:1096:400:152::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 01:36:48 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 01:36:48 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Fabiano Rosas <farosas@suse.de>, "quintela@redhat.com"
 <quintela@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zhijian Li (Fujitsu)"
 <lizhijian@fujitsu.com>
Subject: Re: [PATCH 2/2] migration/rdma: zore out head.repeat to make the
 error more clear
Thread-Topic: [PATCH 2/2] migration/rdma: zore out head.repeat to make the
 error more clear
Thread-Index: AQHZ66F08Ixn3lyVw0ecGE6WyRcEtLAjrgSAgADS4wA=
Date: Thu, 21 Sep 2023 01:36:48 +0000
Message-ID: <2d876f0c-8726-81df-3a62-2d79a6b44ba8@fujitsu.com>
References: <20230920090412.726725-1-lizhijian@fujitsu.com>
 <20230920090412.726725-2-lizhijian@fujitsu.com> <87ttrpm20o.fsf@suse.de>
In-Reply-To: <87ttrpm20o.fsf@suse.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB8374:EE_
x-ms-office365-filtering-correlation-id: bf942450-7f86-474c-b417-08dbba433932
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o9RiVQcEf9ytfS/9Bx8TQ8LdpCX+4YzbU/yqJY0qNBxU941UN8xZkGPe0ZXpX0s55fftfxAf0wsp5MYX5va/ryvKMlaAX1QWpBHG2ok+gYI4tNeJxW85GmHljoHZs/LccRWZ/9RZjg1tnQkgPrc2Ze9dW0H0apZx0zCYWPFuhkxFsZvkLdS+yU14gtqqpNseQ/b1xbL165fuAddjaI0HvLyrK6HGGbyh/FGHTHrZ7RQjamMleHG10ES25i9bkK5cGKFpxBTcKGGUC8oX2SYEheW1jJMFHkvtYRwiRbCcSeTvfsi7HzS7g1ntMFnQqRTj+wdsfmOb7g2IRC5/+SHCXWWGzii4+ht/EiQUGhWWZKMeuTLU5YvRQ0ydL3aXmyNI0kqLpsSzozHbPt+Yfn8WppK+5BgVSpK4e7LGQfLreqoJjQTj6J5Wxbx0+eF7jYtgh2ePpJcZgTig8O1t2kXjafUJ4J6Pm6f4usbMmUwVJy7AaoLzTLGxnKT/K032+Lxkw2tS6Ln12KFMwmnRd/IzgravkcaQrYDtOUYo6um8p0xQtpHgCAwBJOjbE638VxHyAuMvIUdL2tNNV+to3xVsdPjf4YdEJ/78xb8juKfK5I3UjxO7j1a03yLT0Z0eIvHIzvkAEYWyS99PKcMFFHKXlk/mTB2iqBsD09eTSTjO72kfGKr1H44oggLkOmqU1w2ehdKWno99X0EYZPS/k9DYPw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199024)(1590799021)(1800799009)(186009)(2906002)(66946007)(54906003)(66556008)(64756008)(66446008)(66476007)(76116006)(41300700001)(316002)(91956017)(110136005)(4326008)(5660300002)(8936002)(8676002)(1580799018)(83380400001)(71200400001)(107886003)(26005)(2616005)(31686004)(86362001)(31696002)(122000001)(38070700005)(38100700002)(85182001)(36756003)(82960400001)(6506007)(6512007)(6486002)(53546011)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1pFOWpWa2diTmVTY0srMkF4cGdMOXMzT2gzcjFna0J4V2VwRXRhcm4xNDNi?=
 =?utf-8?B?QWp2UmVBZUZEcVFyWVRpRXFhM3FUejBWdXo3b1J6Q3FPcXVnd0Q1b2diK201?=
 =?utf-8?B?TzIzR1Q2cS9UUVVERytZSWRZRmdQTjI5Wi9jR203aUN2bVVRY2lFUVBsN1Bu?=
 =?utf-8?B?WW1heWVZendta0Q2Q3oyMEdZRHd3Z0RoYk1oZ0xJSHp1Z3hZZzV3SFJVdVUx?=
 =?utf-8?B?aHVtVFJuZ2Y4a0xzT2ttWUtjRVYraXNPSG1tMUZUeHhUckhIZDJ2bXBoMzlQ?=
 =?utf-8?B?dnlYUXdueDdOcE52bGpJNzdSNzBlOGdjWUZ6OTNHU2NIVkRRSHlDYlE1cnNs?=
 =?utf-8?B?eXhJaWlrWmVBcEwzTUM3RUhtSWdmSGRIa0RzbGlSMlBrWWFLQVZVTi9xdFN5?=
 =?utf-8?B?QitKVmJudkZJK2lQT1FyZEhDR0UwOFFhOC96SWlrdXoybytYNS9pb3p0VHJk?=
 =?utf-8?B?NkVhVW1SYWxPUFBkZi80dnZ2cFpJUkplVlNYNFFtWUFadkVVMitDbWdzaTIy?=
 =?utf-8?B?Yi8rWVVLY0tCUWlJTWFuUlIwSWRPdGpIcHh3eG1VNDkwUmNNc2JXclZtQnVN?=
 =?utf-8?B?cFBQUnd4aitLbTBGVklKV0MwYUNMaE9VUXJlNXlONHF0S041M0haZWkvaEtm?=
 =?utf-8?B?cDJydXc3MHNKemM4UG5ZTmZoQjJqdXNhdldtTndibE9xOGNWQnZvWWpRT1RU?=
 =?utf-8?B?bUdCOGUveW5JU0YycVkwWDI1dVBXZVhVaWRtVFVra0lqWC9ucGhwWXNTWFRQ?=
 =?utf-8?B?SGFsdWxVbUpYangyTksydTA4T05IeE9NZVp6ZjF5cWV5YStGQWlPMWxvZThi?=
 =?utf-8?B?MXhWMHNUdFBxUDBodjhJY0gwcnBYU1lvTExTUnl3elVvSU45eTBJVE5NblRB?=
 =?utf-8?B?anhWSXNtaE4vZi84QzBKZVFqd3NoamRHZ0tYWkhFRldmbTB2VENwMmkvb3JY?=
 =?utf-8?B?RDdZTCtzS2M3NWJNM1Y4VjhpM3QyU3BvTTJ0M1hGY3ZSeW1NK2JYYTFzMkNC?=
 =?utf-8?B?OVM3WkdiWHJGUVpDaXIvUWxRR0hCdDdlNEkyZFd6YXdZaENRSVFWeHhYeXBC?=
 =?utf-8?B?YkVvZmhNVHBiQmE3Q1dwOVJtT3JjL3FrSXRoZW01L28wRkVTWkJyOTBXUTZu?=
 =?utf-8?B?a1Q5cWxuTFFiTG1zeE9vejd4QWlNdHRKQUFDYThYWFpHKzFlS2phdC9XbDIr?=
 =?utf-8?B?VlNzK0J5bDBBRFpvMVdDMjJIOVpOaWU5VzVoMlZRd0Z5NllvM2FpVk5wb0tO?=
 =?utf-8?B?ZEZqcXRGWHlhZGY1ejRsYVZkL0RGVU1HS280a1pnbDQ0TG1hd01MaWNzTzNk?=
 =?utf-8?B?Q3IvY0QwZEhwSjlUMTdFWU9JdFB5d2E3clpROXhBS1lyNHJBNGI5a3hVSVd5?=
 =?utf-8?B?eGh5bDU0bmc0VExsczBJQU94U0ZlbWk1aDRueXFJK3lCd3VJRENNOTBqK3I1?=
 =?utf-8?B?c1M4U3paY1RTd3gzd3cwamg0d21vL0hqZ1VkOGFRVmZjZWhEK1YyT21FSDhS?=
 =?utf-8?B?alpMOG5CMktNYlQrbUtaMnAwQnBBVEswaHJEVlFCZHhHSVlIdC9ka3VFWHR1?=
 =?utf-8?B?K3hxMUZkbzh0b2sxUlRaMjVtZ01mb21ZdzFqcU1PdDY3QlcyVVhUTThtZ1hu?=
 =?utf-8?B?OE5vNUNDcHMzcWRreW9Nc1d0UklKbzJGdWlqNEpadFRLYlRQSmRiVWEwdmRY?=
 =?utf-8?B?MTN3NVpKZnhyY3RINTJmWWpDM0xvQkNFVGN0by9HU0hBTjN4V2JHVWQxWVdr?=
 =?utf-8?B?UjU3ai9seDJhVEZMMmdNU25LUzZJbkFSUzBUNk5kZ28wb241OWhIWmQ0dzE3?=
 =?utf-8?B?NkZIQlZEK3dTZEVPNHQrbXJqYTFuVkUweC9vdE5PQ0todXJpZlpIOGVkNElw?=
 =?utf-8?B?M1pKM1g3L2VlVURrMnZCTWprdmxBYTJxSG5qYjBUNkdLUE1TUzlNODBxaDBQ?=
 =?utf-8?B?UTJ5ZGh5WGhUV2FYbWFSUlBHdXFsNmtzZnFMVW1yejVINTNaNmdaeGV3cWVK?=
 =?utf-8?B?YkIzeTVCYWlDRTl3TlJiYk5GeXNBdFMyNG1wVE9hTTdRS01aK296YUdwMjBk?=
 =?utf-8?B?RjFGcEJZZitmM1pDbS9PYUYzRDg3cTBtL1JqVERzQlhWeTd6RG56d05qZk83?=
 =?utf-8?B?UUVzQmVCUjh2bk5sK2JYUGR6bVZ5SnUwTk5KQ1NhSlRxdXBWdU9CMVFMZ0NV?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66903290FE5FF24E8FC7929109DD3277@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rCpWvokHoyreAzZRhsKlkQ7H0apQoICFPsWjdgV9ldOl59uqLX45tkWIMMZArWB752LoZDI13oxemp4m+vUlzqNrA9VNfTqcVAADKRhUcq4QLR7lyld8j2iHMA+m1LpA1TJaudGrTWUxjynqU3wro1rlP0ADzS9nR3OjJdq5ZtjikshbPBFZcNzpkbgkVOgYKFrdlWEOEqZNYEBR5NyM1Y1GJ3pBmUIKxJrDDZvlvUeqF6+/kzr3iooZ9gsBjil1zKP6omy5KO5EP/ucR2mY1l0WPTV3tkaoM/hMje0FJNa93/Mk0quf71u3kX7rxPjIa6yOIGGoqV0zqDtvZqQxN6TPySLyShI2KO3CUcCR4QxJneepefqcqougTa2nMGPJQrPH8WM5DLTF+8ifnREO6k/59MxLt1bs6I526gt/MDoWxEFdsM2rGpMLMeSo62a9quF9aKe1A1V3/IdNQV88AyW7/w75lpa7Er3yz7RoI/yarwssiEA7mAEfkQFAHDE+naQ290iVYroBnHT/zGgKRFBeMKCGJ71ioXqJfqNpICr1vrYOsouwUiIsfP+BbNHSgy+GA9TtUt5/7P4QtQZv4AYjxqsOGzZ6sUPTUdK59Vo1uiAQKfkfsnfkpyIz7ulgWAV8UXN3PuYRCYrJKkDXvgDDc85gQUEHfdbQzfT+wl/CvI7g0ZdGSHLwuj+8ooS+SbiR79I/doJAWQVJ3Sy9SfSsLzCqYpu072gsNu5+Op3igEpbLbuuMpEjxQwrw0jT6txSGODsOk6lfhmaw7qsX81eTtJobTyNybwje4BaS3Jio0US02a8DlK+aODOk6YM
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf942450-7f86-474c-b417-08dbba433932
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 01:36:48.7880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +VkXtpCohfU6NXgSzVn/W42MWQrOSViiSuljJZPX+XdT/kXwxQhyp2JJoKA34Zoa8Y8frkgasymd10BVobUrvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8374
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

DQoNCk9uIDIwLzA5LzIwMjMgMjE6MDEsIEZhYmlhbm8gUm9zYXMgd3JvdGU6DQo+IExpIFpoaWpp
YW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4gd3JpdGVzOg0KPiANCj4+IEZyb206IExpIFpoaWpp
YW4gPGxpemhpamlhbkBjbi5mdWppdHN1LmNvbT4NCj4+DQo+PiBQcmV2aW91c2x5LCB3ZSBnb3Qg
YSBjb25mdXNpb24gZXJyb3IgdGhhdCBjb21wbGFpbnMNCj4+IHRoZSBSRE1BQ29udHJvbEhlYWRl
ci5yZXBlYXQ6DQo+PiBxZW11LXN5c3RlbS14ODZfNjQ6IHJkbWE6IFRvbyBtYW55IHJlcXVlc3Rz
IGluIHRoaXMgbWVzc2FnZSAoMzYzODk1MDAzMikuQmFpbGluZy4NCj4+DQo+PiBBY3R1YWxseSwg
aXQncyBjYXVzZWQgYnkgYW4gdW5leHBlY3RlZCBSRE1BQ29udHJvbEhlYWRlci50eXBlLg0KPj4g
QWZ0ZXIgdGhpcyBwYXRjaCwgZXJyb3Igd2lsbCBiZWNvbWU6DQo+PiBxZW11LXN5c3RlbS14ODZf
NjQ6IFVua25vd24gY29udHJvbCBtZXNzYWdlIFFFTVUgRklMRQ0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IExpIFpoaWppYW4gPGxpemhpamlhbkBjbi5mdWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4gICBt
aWdyYXRpb24vcmRtYS5jIHwgMiArLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL3JkbWEuYyBi
L21pZ3JhdGlvbi9yZG1hLmMNCj4+IGluZGV4IGEyYTNkYjM1YjEuLjMwNzNkOTk1M2MgMTAwNjQ0
DQo+PiAtLS0gYS9taWdyYXRpb24vcmRtYS5jDQo+PiArKysgYi9taWdyYXRpb24vcmRtYS5jDQo+
PiBAQCAtMjgxMiw3ICsyODEyLDcgQEAgc3RhdGljIHNzaXplX3QgcWlvX2NoYW5uZWxfcmRtYV93
cml0ZXYoUUlPQ2hhbm5lbCAqaW9jLA0KPj4gICAgICAgICAgIHNpemVfdCByZW1haW5pbmcgPSBp
b3ZbaV0uaW92X2xlbjsNCj4+ICAgICAgICAgICB1aW50OF90ICogZGF0YSA9ICh2b2lkICopaW92
W2ldLmlvdl9iYXNlOw0KPj4gICAgICAgICAgIHdoaWxlIChyZW1haW5pbmcpIHsNCj4+IC0gICAg
ICAgICAgICBSRE1BQ29udHJvbEhlYWRlciBoZWFkOw0KPj4gKyAgICAgICAgICAgIFJETUFDb250
cm9sSGVhZGVyIGhlYWQgPSB7fTsNCj4+ICAgDQo+PiAgICAgICAgICAgICAgIGxlbiA9IE1JTihy
ZW1haW5pbmcsIFJETUFfU0VORF9JTkNSRU1FTlQpOw0KPj4gICAgICAgICAgICAgICByZW1haW5p
bmcgLT0gbGVuOw0KPiANCg0KMjgxNSAgICAgICAgICAgICBSRE1BQ29udHJvbEhlYWRlciBoZWFk
ID0ge307DQoyODE2DQoyODE3ICAgICAgICAgICAgIGxlbiA9IE1JTihyZW1haW5pbmcsIFJETUFf
U0VORF9JTkNSRU1FTlQpOw0KMjgxOCAgICAgICAgICAgICByZW1haW5pbmcgLT0gbGVuOw0KMjgx
OQ0KMjgyMCAgICAgICAgICAgICBoZWFkLmxlbiA9IGxlbjsNCjI4MjEgICAgICAgICAgICAgaGVh
ZC50eXBlID0gUkRNQV9DT05UUk9MX1FFTVVfRklMRTsNCjI4MjINCjI4MjMgICAgICAgICAgICAg
cmV0ID0gcWVtdV9yZG1hX2V4Y2hhbmdlX3NlbmQocmRtYSwgJmhlYWQsIGRhdGEsIE5VTEwsIE5V
TEwsIE5VTEwpOw0KDQo+IEknbSBzdHJ1Z2dsaW5nIHRvIHNlZSBob3cgaGVhZCBpcyB1c2VkIGJl
Zm9yZSB3ZSBzZXQgdGhlIHR5cGUgYSBjb3VwbGUNCj4gb2YgbGluZXMgYmVsb3cuIENvdWxkIHlv
dSBleHBhbmQgb24gaXQ/DQoNCg0KSUlVQywgaGVhZCBpcyB1c2VkIGZvciBib3RoIGNvbW1vbiBt
aWdyYXRpb24gY29udHJvbCBwYXRoIGFuZCBSRE1BIHNwZWNpZmljIGNvbnRyb2wgcGF0aC4NCg0K
aG9va19zdGFnZShSQU1fU0FWRV9GTEFHX0hPT0spIHsNCiAgICByZG1hX2hvb2tfcHJvY2Vzcyhx
ZW11X3JkbWFfcmVnaXN0cmF0aW9uX2hhbmRsZSkgew0KICAgICAgIGRvIHsNCiAgICAgICAgICAg
Ly8gdGhpcyBpcyBhIFJETUEgb3duIGNvbnRyb2wgYmxvY2ssIHNob3VsZCBub3QgYmUgZGlzdHVy
YmVkIGJ5IHRoZSBjb21tb24gbWlncmF0aW9uIGNvbnRyb2wgcGF0aC4NCiAgICAgICAgICAgLy8g
aGVhZCB3aWxsIGJlIGV4dHJhY3RlZCBhbmQgcHJvY2Vzc2VkIGhlcmUuDQogICAgICAgICAgIC8v
IHFpb19jaGFubmVsX3JkbWFfd3JpdGV2KCkgd2lsbCBzZW5kIFJETUFfQ09OVFJPTF9RRU1VX0ZJ
TEUsIHdoaWNoIGlzIGFuIHVuZXhwZWN0ZWQgbWVzc2FnZSBmb3IgdGhpcyBibG9jay4NCiAgICAg
ICAgICAgLy8gaGVhZC5yZXBlYXQgd2lsbCBiZSBleGFtaW5lZCBiZWZvcmUgdGhlIHR5cGUsIHNv
IGFuIHVuaW5pdGlhbGl6ZWQgcmVwZWF0IHdpbGwgY29uZnVzZSB1cyBoZXJlLg0KICAgICAgIH0g
d2hpbGUgKCFSRE1BX0NPTlRST0xfUkVHSVNURVJfRklOSVNIRUQgfHwgIWVycm9yKQ0KICAgIH0N
Cn0NCg0KDQp3aGVuIHFpb19jaGFubmVsX3JkbWFfd3JpdGV2KCkgaXMgdXNlZCBmb3IgY29tbW9u
IG1pZ3JhdGlvbiBjb250cm9sIHBhdGgsIHJlcGVhdCBpcyB1c2VsZXNzIGFuZCB3aWxsIG5vdCBi
ZSBleGFtaW5lZC4NCg0KV2l0aCB0aGlzIHBhdGNoLCB3ZSBjYW4gcXVpY2tseSBrbm93IHRoZSBj
YXVzZS4NCg0KDQo+IA0KPiBBbHNvLCBhIHNtb2tlIHRlc3QgY291bGQgaGF2ZSBjYXVnaHQgYm90
aCBpc3N1ZXMgZWFybHkgb24uIElzIHRoZXJlIGFueQ0KPiByZWFzb24gZm9yIG5vdCBoYXZpbmcg
YW55Pw0KDQppIGhhdmUgbm8gaWRlYSB5ZXQgOikNCg0KDQpUaGFua3MNClpoaWppYW4=

