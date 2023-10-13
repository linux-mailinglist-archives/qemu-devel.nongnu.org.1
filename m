Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD9F7C8034
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:27:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDN7-0003gy-DF; Fri, 13 Oct 2023 04:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrDMt-0003Ej-5o
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:18:00 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com ([68.232.159.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrDMq-0003RX-Vk
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697185077; x=1728721077;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=LVCETEDro9GGQB4GwBofohERhSBJgXMM5xeHdZD7ONI=;
 b=veZdKiChGHZVac3y51U5yqr95BdhRZ8X02nz1Ar8oLllHQ7OzT0bKuNW
 wS/lb016hZvwhUmKVPqpFyl/hRtAVTkvrpyhrY+ydWWUm0hivsNHwwCY5
 K+m7GPV5pHZH4bVdAT5ge+DNn4X5SyfjwrAZGNF05ghTghUffvCtemldY
 N1kDdARR8CLumxzP8yYPWmbFBz0URGHciQM77NR6Ca0/Ekqef1F0yxQrL
 5P4V4Txkdq7IsM1p45arFrzrUc/7Qobg8JObEnJNIADYeNntLHnU5RweJ
 UYlWoDslYHnMoIegaL6fF6yHXTY1zMvID03DlMeDTGJCBisXd3CmUjtDe w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="99067739"
X-IronPort-AV: E=Sophos;i="6.03,221,1694703600"; d="scan'208";a="99067739"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 17:17:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odHocsvA/SBBpHFg8SAumgv29T6KigmfBr/rBA3vaqVfGPRqT8pZworf3Tsc0/jO5R4BBbpGkVrvCC1LuaZLYFCLPpsu+5YIkK/ln6yh8s6epfY3QVeecvu9g3TLfQwQovazoAALEFpT8AI3H8+KMnoBqlbYfAnoFLySxEG3pNeUlSdj97mHv9Tr+YOFL4VRd0DR/e62n2jCKmTLrX+j682+TiwwDpTrZxM4S+zNU03OEprDmo3vaLlHgonqzbnCSvnU/+4X892tT2C/0UOmq7k+6aU68uzJCK7TEIHc6J0WFZrqDZb7R2cEqKgBeTmer0OyOhKgiyBJd6jUyNfyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVCETEDro9GGQB4GwBofohERhSBJgXMM5xeHdZD7ONI=;
 b=KgVR4HiY+O0RWRpE4t9sIvDboOiLS0TBJjiujq71oymn2siWWLRjdAvglpxn4Hkemsp9gzyQ41zkLS9MQeSJOyzWevV6YoKJ3mZIJoWliJfo1AfcxjBP5QZolIj3BlXJfrjHzsLpIQOdKqUcmLtUY8ImoIWsdIsW8wszPlFH2VspD/suScPpttJOoSZ3TtC9frcvoa3r3sTtK4pUYCpyuU2dmOjxiwwf1qrOpdcDI/dmlLIZ+Bb5gUqEUJxz8LfBLho04+NzRk9AoveJm6JXpffatvbYOa/9fZ91RVwZQw745CKPwowdoLvSJc8az5UsAcPjU2Oplw4C3Sb4nY1Zgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 08:17:47 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 08:17:47 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 12/13] migration/rdma: Declare for index variables local
Thread-Topic: [PATCH v3 12/13] migration/rdma: Declare for index variables
 local
Thread-Index: AQHZ/IKWKjRn84jNpUmN7TQtFfajsLBHYngA
Date: Fri, 13 Oct 2023 08:17:47 +0000
Message-ID: <eafc048f-560b-2060-b483-c3455984845c@fujitsu.com>
References: <20231011203527.9061-1-quintela@redhat.com>
 <20231011203527.9061-13-quintela@redhat.com>
In-Reply-To: <20231011203527.9061-13-quintela@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYCPR01MB12093:EE_
x-ms-office365-filtering-correlation-id: 9a89f8b6-9578-486e-c0cc-08dbcbc4e283
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t9uaCTvhbS6dFexiMtvl0KVejgRyIoViRpKCb+T0x2NQ+HshexXxNHyeUIIkr/RdITwSor1SJ7XQPgDoG4jdgK/R5/vovc3E6Z7zueLhBp0TLwTp1D5a629K+u7gQRbjbAh+mGaps6d86lTcMidnVXDdC3aOCrwox2hQm4oX3eKfn1Eg7GvCvi21ayAxjLkTo3SgNUu7DEON4FlHZWHOaptjUnsBjs6KYkpnqEXSRZ4x39lL/U703RXVL0qFDpg3gTrsTu4PDYSkrSq9rKHL8RB3Lfkkxu//iUNRBTyb0rwS1sFRbrgBlmdLHrVO8dPHUHIW7lzaqBgDHcMK+jtGwKzL7wmI9if9y+8Na7PGstQKslqNG1HPsANiWDVQBvYRhZz4j6ceF4xScoSSym/7ydP8D0QzhiWN7DKZiXLj8HrYtWxtGYTdrjl3+Ch20kWY0DTKdWbXfOELGnPLM0WJIISJ3+2sQ7YCSwMmHC50E3NOC4xleMCdf4ZBs46Z1dKpk+96VMB8QEDcOacmkPo3vS81k8KyUtxP/Ar10yhFtQ1Mr2KkqY2fmKJ9PoI2eeyw2IWbuFg22KtFKJ9zc+hKzmpXIZDnsoFN82g6lN2feHfvA91y33TiHHZLQCOfWxMjCzH5PzqsBhx/L1TfO37DuGkJeZfzYPe3Vam9FmlfNHKMgZ+1F+k0hQFYVg70hUh4ktBAuk3jMStPIdQrRj+PJw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB5442.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(1590799021)(64100799003)(2906002)(1580799018)(2616005)(26005)(122000001)(478600001)(38070700005)(38100700002)(82960400001)(31696002)(86362001)(6486002)(6512007)(71200400001)(53546011)(6506007)(4326008)(41300700001)(8936002)(558084003)(66446008)(64756008)(54906003)(66556008)(316002)(110136005)(91956017)(66946007)(76116006)(66476007)(36756003)(85182001)(5660300002)(8676002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YytIYXoxRkswU2JyQXNTc202OUFBNU85ZE5IT290Uy92QUJYOUNzdFRSRjdJ?=
 =?utf-8?B?QXVQSVgySUR6ZzRKT2NnYTdqZmhWbFFRdi9sSlhHV0JndFdrV3djQkVaYWhv?=
 =?utf-8?B?ZUFJa1dHa0FkRHgzdCt3RnF6OGRBT0lIUG5tdnNCT1V1T1Noc3lnVXNUOFVN?=
 =?utf-8?B?OTNrZ2RJYzVrWE5mMTdTVnQ0TWJNODVBY2VkNFUyQXFoMUJ2NnJLT3Y2dEtZ?=
 =?utf-8?B?NUJoNXBHS0FKRkJYZUx4MjR2UEovT3NyOUNVLytxOUpMWEJ1akdZcDAvclZU?=
 =?utf-8?B?OFVKWWNDUUF1dmJ3S2xhUVkzeWlreSt0TnBrbjlycXh5cDRtNm8zZ2tzQndl?=
 =?utf-8?B?NjJjZzl3NmF2TWE2aVRNMjdzUzByL245dFAxN1QwZHF0NUtnbGNCQkQxbTFz?=
 =?utf-8?B?ZGJUTG9UMk41OVVtaWJUb08zbWxUcXYramJHdThZM3QwL3BMZ0xRVEVVUWxk?=
 =?utf-8?B?ckxLM0pncWtnTCtKTWlPSjZtdXJ1T2YwNzBFWGJQY041S2JVQWxkUlZacWYw?=
 =?utf-8?B?U2JhOHVHSkJPRDBpR3RJSHJtV1JLWGpULzFZdnFlWlduaXpzT0hHMGx5MXVL?=
 =?utf-8?B?Yi9PU0dodXhLcEY3cXR6RC8zNmZzbU40ZGVkZ2xTNW0rbUx5RU4remtDQU9n?=
 =?utf-8?B?YUllWVBRdHNhbXhXWkEzeVRkQ2JnUFp0akl1U3J2amJaQnAwQitqbWdaTysy?=
 =?utf-8?B?ZzFaVkVtdkpnSnJYZzBBQW5yQ1RIUWRkTTlrUWU2VFhML01jd08rV2lTbktV?=
 =?utf-8?B?NlYwc3Z2ckhtWWEydGI4SFVxVWw3OEJSQXV4SDNnNnZHTTZtSlpJUEQyeGF5?=
 =?utf-8?B?aGhmV3lKUUc5RHd5NkZGNFlxN2hoNW1JbWRtYU5xQ3MzUzU1cGFmTFBVQnIx?=
 =?utf-8?B?MW8vNHJ3TzdTVHNNc1k1dFU5VnJQN1lFUXZWQ0RtQURXdHRyUkhKWXl4V2or?=
 =?utf-8?B?cndTNUE3NWlWdEtPaFlSMlBhMjhkU1RQUkhxV2d5Q3cxY2kzb2c0UWJNM0pw?=
 =?utf-8?B?VU9KcXRoLzE5S2U0TDBtTWo0RStnTDFjVy9LcFhyOHBFMTlEUVU3R3V1UDdw?=
 =?utf-8?B?eWpYYVNSRlIzUjluUUpLb2kxV3NMOVgzQ3M3bklWRzBtK2lUamlpbEJ5b3Rm?=
 =?utf-8?B?cU1Xb3hSUjRFK1REVWI4cWtLVFZGbzg4eWtXbk1oZmxGQWdDSGhrckVndUNp?=
 =?utf-8?B?WE8vaEVNZ09TaGxrRXk0U2pQODVmU0VWWTVsd3NockJuQVNMSC9oa1dtcXB5?=
 =?utf-8?B?aEdQZFpFU2IycnBrMlhLS210RjU0dkNsaGpmUmEvay9EZ2QyYjEyVEhBZWFT?=
 =?utf-8?B?b0ZNTlB6R21pOEpPZk9lUG5oOGZXY3Bvd2J5VTljYWtlV2I3RjArdDU5b3Mz?=
 =?utf-8?B?SVgxY3dyeHhMb0Z3WmRyK2ZWRzdBeDNLWlo0MVNHRVBDZWZ5VXNOVTQrQmo3?=
 =?utf-8?B?anVxeG93b0FyeGhtUTEyR3F2eHpPMWMwM1FSQU8rNjVEcXV2eFd2dzRaNVQx?=
 =?utf-8?B?RGptQ3VkT1BJaitSd1FFT2hVM1VuSEE0VlJUMnZpVHJWZWh2QVpDb1kxRmlh?=
 =?utf-8?B?cnYreWZKM1FlZndTMVhXVzJ4ZkFEV0hOMWtDS05sd3l0KzkyUkduVFhxeDkw?=
 =?utf-8?B?U0RwOTdZQklKSGUwR3hmU2M5QTBua29PbWIrZUttV1FkTmlTKzBOSzhQNTJp?=
 =?utf-8?B?UEJ6b3pQQkUyUEhqREZaNkVJaWMwODJsbHJKZ1JGQjMvek15cGxkRUVGaG1U?=
 =?utf-8?B?T0E1Vld2TkZScFlJN3Z1VEVGc2hsQmZEaUxOazZxa2R5a3Y1eG9JaXVabnFE?=
 =?utf-8?B?VUwydFJXcTlydnNaQklxRG5pZThQMkh0dkVXWlBWb2Nab1cxbDNPUk9xUS9O?=
 =?utf-8?B?N0dzUjFEdlZKam1HTzBnWWkxaFl6alhMT3FZamd5QlJBMlZDZUxoRnNtT3pE?=
 =?utf-8?B?cUZaZVZzYlZCS2tEUzFGcG5uV05xL0Z0ZHk4MHRmRUlDbjFReDJZMjFRQmsv?=
 =?utf-8?B?ZnF6OU9YQkhKK1ZKMHBQV0poRHgvNUNoNTBpRWEreXNkTnh6MjZUY09GQmFC?=
 =?utf-8?B?aThJOEZhbzdYaEYxNVg5dEhvME9LcGpWaFZkRmozRjR0a25SNXF2WmNpTGkr?=
 =?utf-8?B?eWF6emZhMkEyc1J4d2x2d1pqK0ROVGhnZkVWZjZXejYxMVUwYU9XS094bVBS?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B411F35C07828489A5CD1E676300F9A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s+SzrfgPfkIAe3fNV6PefEqgmI/Q82siHTiRLa7IzOZT1NKn6rhUCAQ77qIqVTH1D0b5bzm11HF6Rar/5VDi2C6emkPfIOQXu/wAmzKfd46ZiHK7vJbYIPqf0EjzbOTxwmqlpVxUobvHNDe9oqKonXIkR89zDxu9hPM1Hdi36Rfuo2KQvfmrwuJnKNM0FJ2DVQu7CmVWjG7/D7VFI46HdHiRE5uOW+u4yhZeaMM8je/vjSOH3giUkJ17tNWMtikdUbIAVA3vGf0HeGgmre9uTpZb1W6lKZY+f2rzONZjkHuejaSJnMwG34kiWHv9VAglh2y3RX6A5nLPtbPP4RUv07utkiprHyGdObqVnC67mYMjfBtoFXj0MxWov0h/YUV+RJAd1daR/VVgTs1ezZ78RmhDWEHI0S+4Y29jmzxQP0V4GozBhb2HP+BzyZffXucLupC5ZPDWXZ+BrBsKjisr3zYtF8D09AZwVRCfZ1FBf0ONSbVsO9oT5cHf7bXHmhPpfQ3d3v804KnFXjXByppWSCX40a3WA7H/IkphMGEeRfFLmOeJyfHRKi/ubTIh5sHr2TwAvdQNpGHQDAwWo+vFSpq3Wo3mDRWNKnYzSk80nREI9BnqneXHYFPa3rjyEovJUsNTi1otL/5yH1jBjucGlHJl4aZix/LO8bwb8307gnMWGs3hnR8ByUK1b+aVEbj6nSBgPsF/lblcyq+lf/2ZRJbEMNYOiDIOeAAykOCzTemzdnoiiTN4JOZBmfPoehbwpP1UQtRLxTLafuAG/2UssCJsBhofQzGj43+NwgsPY/WjMXOVcQrEudD097X030Td
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a89f8b6-9578-486e-c0cc-08dbcbc4e283
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 08:17:47.6900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekBVfsrhIERKUnUSiTWZVcAAnPsQ0xcZGK08UrLVbiK0/5nO1QWfshz8HeYSWMhpDBhWMhu/sR5OY3zrMwDmFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12093
Received-SPF: pass client-ip=68.232.159.83; envelope-from=lizhijian@fujitsu.com;
 helo=esa6.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDEyLzEwLzIwMjMgMDQ6MzUsIEp1YW4gUXVpbnRlbGEgd3JvdGU6DQo+IERlY2xhcmUg
YWxsIHZhcmlhYmxlcyB0aGF0IGFyZSBvbmx5IHVzZWQgaW5zaWRlIGEgZm9yIGxvb3AgaW5zaWRl
IHRoZQ0KPiBmb3Igc3RhdGVtZW50Lg0KPiANCj4gVGhpcyBtYWtlcyBjbGVhciB0aGF0IHRoZXkg
YXJlIG5vdCB1c2VkIG91dHNpZGUgb2YgdGhlIGZvciBsb29wLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogSnVhbiBRdWludGVsYSA8cXVpbnRlbGFAcmVkaGF0LmNvbT4NCg0KDQpSZXZpZXdlZC1ieTog
TGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg==

