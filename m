Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A967AB5A5
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 18:13:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjile-0000tg-Vv; Fri, 22 Sep 2023 12:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=362924a09c=oleksandr_tyshchenko@epam.com>)
 id 1qjhKV-0007xm-6U; Fri, 22 Sep 2023 10:40:27 -0400
Received: from mx0b-0039f301.pphosted.com ([148.163.137.242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=362924a09c=oleksandr_tyshchenko@epam.com>)
 id 1qjhKP-0006YH-F8; Fri, 22 Sep 2023 10:40:26 -0400
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 38MEK0Xq023692;
 Fri, 22 Sep 2023 14:40:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3t95uq1q55-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Sep 2023 14:40:17 +0000
Received: from m0174683.ppops.net (m0174683.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38MEXfxB025399;
 Fri, 22 Sep 2023 14:40:17 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2058.outbound.protection.outlook.com [104.47.13.58])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3t95uq1q51-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Sep 2023 14:40:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXd/54ke6o0+yARwa/HJioXsnRjPXc9cK+oe2k6KFkPBz+WnEmXEAm6f+oaAp1JWNypBZebpp3pXBb6M0b9clfc35WbchmBesblBF0N9mjn4sRMIZMOckn+oWtGJVD05nXZopgWwqN8Otn+imwaWlHl47pCR1k3yiZM/QzCFZEI/ooEI91MkKe891OltQJQ+63oZhiBc3iURD7LFUoUzVZgE/e/UKK/jeVktRVUfjh9/jiAEIzXOZOuqAbFHnzTRTg2mkeVN7ghvHUVwTXBNgxb/aVtct8Xu+ACEv60lvRz8Vi/7nt/v197Ta7WEDImgiKd/MfGkGL++0b6UTICnHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7O5TeyNFyI1dcXgg6AZ6imoPbAbInHfZdtd458m7FA=;
 b=icRlGlfi5f25WumIZ1zIpBBXP/qRVJpsmfo0TEmEf1xAjk+lQkaZNVst2u4ljdkEZjvQls5uE9vROfvkyzCRU5MukR4/awRT5uINodExaqU5MG0ex1nU3nPtWKkDLQPzMKNepBR4Tao2ncy4OIfNOnSqkezuEJJ3T2LHSBaA6CyYMeF/E7sNSwBmJpWbIoCpA0JmxhMOEHxY1A+EO+Lq5y9kBwIVT6CtyURKiWpAm0mK7uMI/rcua2lv+FUcX4b/Y+T7cV8wROvRltSfKhgWAdIy5KvFHrJ5ucJMTZdShN3EyrceL31lUiZfO2NInO5gcBTtIcbR8WfTRqJOztxVvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7O5TeyNFyI1dcXgg6AZ6imoPbAbInHfZdtd458m7FA=;
 b=i6AEX8jbYvObAvMIerPIV5IBCX79wpFR57oENfzbjNFRqdXYbpdQuxnAUcl04oY2woRhcVxxJCFp06u0fcrrvUDG4HSgQma+1NcmPeFWeJ7xzMgZMCTfgneUXSXYewoNsh4fovp6RxiFjgYQek6NlQ/tp09WHU96ctj9cs4cZxgt+WPETggo4LhzGS1Tnbqqhku1vhZ1wwuQlst7xWWLzln+YaRMSc9yLzO3K94Dj6nma0XturKP4kGsEgyo6Kzmz2zY3SS1yJ2v+w0yxiLA0ALNJLL5Zg7AI++Am8cSRWfBIh9drf5H79ReiBMOR16rwaAgVqnALyCPnzhGCltpsg==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by AM9PR03MB6753.eurprd03.prod.outlook.com (2603:10a6:20b:2d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 14:40:13 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::ac2a:7470:c441:365c]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::ac2a:7470:c441:365c%7]) with mapi id 15.20.6813.018; Fri, 22 Sep 2023
 14:40:13 +0000
From: Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To: Michal Orzel <michal.orzel@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Stefano Stabellini
 <stefano.stabellini@amd.com>
Subject: Re: [PATCH] target/arm: Fix CNTPCT_EL0 trapping from EL0 when
 HCR_EL2.E2H is 0
Thread-Topic: [PATCH] target/arm: Fix CNTPCT_EL0 trapping from EL0 when
 HCR_EL2.E2H is 0
Thread-Index: AQHZ7Ve4c2wmX4BBNUivSQRTH0qRxLAm6q2A
Date: Fri, 22 Sep 2023 14:40:13 +0000
Message-ID: <70d8bebb-d706-22a4-744e-eebf438a8382@epam.com>
References: <20230922132111.9149-1-michal.orzel@amd.com>
In-Reply-To: <20230922132111.9149-1-michal.orzel@amd.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|AM9PR03MB6753:EE_
x-ms-office365-filtering-correlation-id: c070f11f-0c06-407b-8081-08dbbb79d471
x-ld-processed: b41b72d0-4e9f-4c26-8a69-f949f367c91d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NKuWHBtUQyc9bSJOgtq0PKmM/HlbwLJhi3/PKDihmCbWVNeuxShEpFM0M5zUKjfOacgw2NSrmJXIjTBGzipu8VIZFbogifmvt+G1+IbqlQw+61UI3XafeItVEhotBVq03CqKEN6+IhVZs5Wo+sKT6D9IgSRb4iIUAeKlY7fuITC6w8SYu4BgNJVNmYh8md+v5zDYIFmgRhengw9B4aNiLEtMZ5PzTMbm8oDvbeXzB3ytg7C6x+WJ/1l06B9AzUNcS9OX9J7QNA3wN/9Wm181ondDjrOKe5HIVdf0he0eLQYlQ5DkI/oSxbtqICa3jnH4ZCLgOLGrVa7LToq9SJ/wZ0JZkCJnqTD75cvpr9MadgV8PKKLE7Aq+UHaucTs+Wj/HOBInjtDI+TZDkL0N9nqV+5cJX+SyrO5tL4sYAFlaLDGD77Il/0j8rRN2BPIxA9fwz/uVoefqwW56FUZi6EyjmvD02pf+WgNHdfmoREQBlxmZyQxbDsDt6SQyObn1NeDG6zb3ToH0jy684ngV68/pIb6pp4ZuI6nSZH7H7FIsqMECQQucdbCz1EDJfdrF4YsTVx4uNqsrWZu6q0SlGDAbJ4bhJon5tVVaAp936acw8Ls66vN1GH9ijE+fq1LHnntQDLX46HDwgo4MLUhWxgKuQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR03MB6108.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(451199024)(186009)(2906002)(31686004)(64756008)(66476007)(66556008)(83380400001)(66446008)(54906003)(5660300002)(316002)(41300700001)(8676002)(36756003)(4326008)(8936002)(110136005)(76116006)(66946007)(31696002)(86362001)(2616005)(53546011)(6506007)(6512007)(6486002)(91956017)(71200400001)(26005)(122000001)(38070700005)(38100700002)(478600001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2xUdWp5QTBLQ3dsQXZudUxVaEgrblBuZVE5TVdaZlNid2xPZ2V5NWtDY1NH?=
 =?utf-8?B?NG05bXg4anU5cGYzTUliSVkvSFdCcGxNZmFDQlRjd2szcmhYemwxSHB1UlYw?=
 =?utf-8?B?R3lEbHQ3bzFwaEJBdTlWYjBIREtmTHZ1bzlPMHhVRE1JbHUxV0w1ZEYzSm5X?=
 =?utf-8?B?YWM0eng5VGhkeStYZ3VGZDc0bEFpWjdGNk80MmtoREJ2SGhYODdjUFl0ZlYy?=
 =?utf-8?B?RmQ0RjN3U2FUbDlhcHE5MUNrNTUxVE5rSkZRbk9qcGlVVVh0bnh4Yk94ZzBP?=
 =?utf-8?B?SlFHdUt4MjBleG8zdjNlYnJkZ3o4ckhuZXQxZjNYSHFLcnRmZENlSThiMWZq?=
 =?utf-8?B?UE0rWUFPRnZIdElQVWgzd3Q4ckhEdUEvQTh4KzlRaFdJR3Z6aHQxWUtnK0VK?=
 =?utf-8?B?ZjIzR1E1SkhIT3BKZHNzOXJadFdBNUpCWkVJNUg4L01LMEJ0emlkQ3UxMkx0?=
 =?utf-8?B?RlEvZk5ZZ3BpeFc4ZmttbWlZV012TGl6emxSMERlMnZCczVkRm9nVmpvcEV4?=
 =?utf-8?B?dVRQSjJnOG9BV29xRFZWQU84bkFubWtWSjdnUjduT21IbEoxT1NoOGQ1Q0Jq?=
 =?utf-8?B?dEZZSjhMTS9Qd0VmdnF2R2ZXcTFJT3c0dk9QU3NVRlN6c1U0WkhrQnAxZzRK?=
 =?utf-8?B?elZGREozS0JJY0x4L2tka0FRN0ZkNUtDZ1kzZnRCZlNBL1dleWtsa3VVamsx?=
 =?utf-8?B?bzdvbkJYdTN1YWdBbWFlQVZXQURrMFFrMWJRbjZaQlBxd1N2OGVxdGlhYzJO?=
 =?utf-8?B?QUsxSDJHcFlqaTdqZ0ZESFlvcllpTGcydHFReUN5Z29hVXdzOVIwL3kySmFE?=
 =?utf-8?B?aytaZEdPMk4wSVk2dlhkOXNGbHl0V1djaTBBNk9HZWV3U2RzR3Z4NWhsM3A0?=
 =?utf-8?B?RFp2NmE3T1FKRHZ1Q1l3VkRnWU4wcGtWNXZOd0VRU1NMd0tBRnRhS3krTlN2?=
 =?utf-8?B?M3NLTllITXJMbDkwRGR3UW1EUUdFczNkR0VuZnM4dWtqNXNkbVMrMlY3dUow?=
 =?utf-8?B?Z1l6akpPWmJDNk12VlpOdXFrbDJnVzQ4MW1ZY1NBQWxLelc2OVhXUGYzZUFx?=
 =?utf-8?B?ZzlFMkxoaGE2SnkzL3Y3NEtRT2U3US9Gb1ZuUkY5VDBKY0lrRHFlRFhMRS9G?=
 =?utf-8?B?N29JWERNenNsUktJNHZFR0JrdnZUWUVHMm8vQzQ5Wmp0KzhZZ2Zxc096OXJS?=
 =?utf-8?B?Sk4zT0RGL0tuQnVqN0hZY0l0TUdlUHd5b3IzSFFhNzFmNDlERGJMVVdVdnZ3?=
 =?utf-8?B?cXRWbGRkSzRrSFQ0elFOckJIRTJKUVByY1dpNVNaSVFUT1pjR05IdGhlYTJl?=
 =?utf-8?B?a29qVTRTcjlybFB1YTJjTXhSbGk3SFRJS2JsZUxPeHFWQXFFRDMxaHRoU1Bs?=
 =?utf-8?B?QU9sZDRQOXBoWmtDQ3RrcjhNWlVxYzc2b3gwQURYeUtlWCtYT1dhOVpBSmV2?=
 =?utf-8?B?OFZ1MGp1SGFmL1FYV3R6RjFsb1dnam0zOGRwZXZEVE5UVGZGSmI2QWhwcjNB?=
 =?utf-8?B?M1ZKdnVlTUZySHl6d1VmQlM5K2I0bUprTVFUY0pSdnZvOHk1Wktaa2Fxc1hF?=
 =?utf-8?B?RzJJa1FsWjZlVmNMTDZDUTNEL3VYTmFVMyt6T25tcGRlZjl2dWJIalVHci9x?=
 =?utf-8?B?RHBJR3E5YmNCSXgzNm5rN3Z6UWV2R0JDL2xOa1BsOWtRR3B5VWlxcDVzandM?=
 =?utf-8?B?Wk1PSDNTSnRWb3NCNDVaSFRNL1NuU1k0ZVNJZVN2QTluRjZyeERzZ243a0Fy?=
 =?utf-8?B?bjlRdkNQcW9CQ2NlMDVNdXFaSnlWTmZwaGJ0akZkYit2UFI0bERhZ2I0ajJa?=
 =?utf-8?B?NmZkYWo3d21ZVWhYVHhFRUFObFpEdTNqSVhZUThNTzBZUjhjRFFYUGVlN1Z0?=
 =?utf-8?B?SGlOWUlMY3dOUUhlaVRydFlNUDlKd0hCRGVtT2hZU2lNQ3hNWXNnSVNFdWhV?=
 =?utf-8?B?S2VHeEd2bHZyZXl6Y2QvSndjSXdDc01IUzdRSmVGV2Rzc3FLUXZ2YmY4Z3Ix?=
 =?utf-8?B?TkNFeXhhRjVqeTFsZ0QzdmpiT3cya1pZRWpUY01QVmNPTEllM1lyV05YYzk1?=
 =?utf-8?B?RU52MEZsT2wvK0JNWWk4NG55ZnJaWmUraCtsaldXS1dWamY1bWVEYTV3TWRL?=
 =?utf-8?B?bTFCQ3V1dzR4Y1B6LzQ4NThXRFZrN2diMWRNZERtS0ZsaHJzWlhMNm5CSVNI?=
 =?utf-8?Q?tmxjaVCeDYxh9g8Ln4gu5QE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8BB051686BCEB4B96319FC60A3EC701@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c070f11f-0c06-407b-8081-08dbbb79d471
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 14:40:13.2123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I5OAcbx+G6gHsjbdSYAophzWETBhRUBvX2TOoCm4RojqfXKKIdsF0QmUKQ4qY3Qb8nzQHqPx8Y8bc/8cc/6j9rxrFDSPklXSGrVTNY9aCZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6753
X-Proofpoint-ORIG-GUID: UtSqLWtC3jxadjm-IU-X89-jv4Qh-G8N
X-Proofpoint-GUID: UtSqLWtC3jxadjm-IU-X89-jv4Qh-G8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_12,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=2
 engine=8.12.0-2309180000 definitions=main-2309220126
Received-SPF: pass client-ip=148.163.137.242;
 envelope-from=prvs=362924a09c=oleksandr_tyshchenko@epam.com;
 helo=mx0b-0039f301.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 22 Sep 2023 12:12:33 -0400
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

DQoNCk9uIDIyLjA5LjIzIDE2OjIxLCBNaWNoYWwgT3J6ZWwgd3JvdGU6DQoNCkhlbGxvIE1pY2hh
bA0KDQoNCj4gT24gYW4gYXR0ZW1wdCB0byBhY2Nlc3MgQ05UUENUX0VMMCBmcm9tIEVMMCB1c2lu
ZyBhIGd1ZXN0IHJ1bm5pbmcgb24gdG9wDQo+IG9mIFhlbiwgYSB0cmFwIGZyb20gRUwyIHdhcyBv
YnNlcnZlZCB3aGljaCBpcyBzb21ldGhpbmcgbm90IHJlcHJvZHVjaWJsZQ0KPiBvbiBIVyAoYWxz
bywgWGVuIGRvZXMgbm90IHRyYXAgYWNjZXNzZXMgdG8gcGh5c2ljYWwgY291bnRlcikuDQo+IA0K
PiBUaGlzIGlzIGJlY2F1c2UgZ3RfY291bnRlcl9hY2Nlc3MoKSBjaGVja3MgZm9yIGFuIGluY29y
cmVjdCBiaXQgKDENCj4gaW5zdGVhZCBvZiAwKSBvZiBDTlRIQ1RMX0VMMiBpZiBIQ1JfRUwyLkUy
SCBpcyAwIGFuZCBhY2Nlc3MgaXMgbWFkZSB0bw0KPiBwaHlzaWNhbCBjb3VudGVyLiBSZWZlciBB
Uk0gQVJNIERESSAwNDg3Si5hLCBEMTkuMTIuMjoNCj4gV2hlbiBIQ1JfRUwyLkUySCBpcyAwOg0K
PiAgIC0gRUwxUENURU4sIGJpdCBbMF06IHJlZmVycyB0byBwaHlzaWNhbCBjb3VudGVyDQo+ICAg
LSBFTDFQQ0VOLCBiaXQgWzFdOiByZWZlcnMgdG8gcGh5c2ljYWwgdGltZXIgcmVnaXN0ZXJzDQo+
IA0KPiBGaXggaXQgYnkgY2hlY2tpbmcgZm9yIHRoZSByaWdodCBiaXQgKGkuZS4gMCkgYW5kIHVw
ZGF0ZSB0aGUgY29tbWVudA0KPiByZWZlcnJpbmcgdG8gaW5jb3JyZWN0IGJpdCBuYW1lLg0KPiAN
Cj4gRml4ZXM6IDViYzg0MzcxMzZmYiAoInRhcmdldC9hcm06IFVwZGF0ZSB0aW1lciBhY2Nlc3Mg
Zm9yIFZIRSIpDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhbCBPcnplbCA8bWljaGFsLm9yemVsQGFt
ZC5jb20+DQoNCg0KWW91IGNhbiBhZGQgbXk6DQoNClt3aXRoIFplcGh5ciBydW5uaW5nIGFzIFhl
biBndWVzdCBhbmQgYWNjZXNzaW5nIENOVFBDVF9FTDAgZnJvbSBFTDAgXQ0KDQpUZXN0ZWQtYnk6
IE9sZWtzYW5kciBUeXNoY2hlbmtvIDxvbGVrc2FuZHJfdHlzaGNoZW5rb0BlcGFtLmNvbT4NCg0K
PiAtLS0NCj4gVGhpcyBpcyBub3cgaW4gY29uZm9ybWFuY2UgdG8gQVJNIEFSTSBDTlRQQ1RfRUww
IHBzZXVkb2NvZGU6DQo+IGlmIFBTVEFURS5FTCA9PSBFTDAgdGhlbg0KPiAuLi4NCj4gICAgICBl
bGlmIEVMMkVuYWJsZWQoKSAmJiBIQ1JfRUwyLkUySCA9PSAnMCcgJiYgQ05USENUTF9FTDIuRUwx
UENURU4gPT0gJzAnIHRoZW4NCj4gICAgICAgICAgQUFyY2g2NC5TeXN0ZW1BY2Nlc3NUcmFwKEVM
MiwgMHgxOCk7DQo+IC0tLQ0KPiAgIHRhcmdldC9hcm0vaGVscGVyLmMgfCA0ICsrLS0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL3RhcmdldC9hcm0vaGVscGVyLmMgYi90YXJnZXQvYXJtL2hlbHBlci5jDQo+IGlu
ZGV4IDNiMjI1OTZlYWJmMy4uM2EyZDc3YjNmODFlIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvYXJt
L2hlbHBlci5jDQo+ICsrKyBiL3RhcmdldC9hcm0vaGVscGVyLmMNCj4gQEAgLTI0ODMsOSArMjQ4
Myw5IEBAIHN0YXRpYyBDUEFjY2Vzc1Jlc3VsdCBndF9jb3VudGVyX2FjY2VzcyhDUFVBUk1TdGF0
ZSAqZW52LCBpbnQgdGltZXJpZHgsDQo+ICAgICAgICAgICAgICAgICAgIHJldHVybiBDUF9BQ0NF
U1NfVFJBUF9FTDI7DQo+ICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgfSBlbHNlIHsNCj4g
LSAgICAgICAgICAgIC8qIElmIEhDUl9FTDIuPEUySD4gPT0gMDogY2hlY2sgQ05USENUTF9FTDIu
RUwxUENFTi4gKi8NCj4gKyAgICAgICAgICAgIC8qIElmIEhDUl9FTDIuPEUySD4gPT0gMDogY2hl
Y2sgQ05USENUTF9FTDIuRUwxUENURU4uICovDQo+ICAgICAgICAgICAgICAgaWYgKGhhc19lbDIg
JiYgdGltZXJpZHggPT0gR1RJTUVSX1BIWVMgJiYNCj4gLSAgICAgICAgICAgICAgICAhZXh0cmFj
dDMyKGVudi0+Y3AxNS5jbnRoY3RsX2VsMiwgMSwgMSkpIHsNCj4gKyAgICAgICAgICAgICAgICAh
ZXh0cmFjdDMyKGVudi0+Y3AxNS5jbnRoY3RsX2VsMiwgMCwgMSkpIHsNCj4gICAgICAgICAgICAg
ICAgICAgcmV0dXJuIENQX0FDQ0VTU19UUkFQX0VMMjsNCj4gICAgICAgICAgICAgICB9DQo+ICAg
ICAgICAgICB9

