Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8FE7F86A9
	for <lists+qemu-devel@lfdr.de>; Sat, 25 Nov 2023 00:26:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6fXL-00039C-Hb; Fri, 24 Nov 2023 18:24:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569229df20=volodymyr_babchuk@epam.com>)
 id 1r6fXJ-00038e-K9; Fri, 24 Nov 2023 18:24:37 -0500
Received: from mx0b-0039f301.pphosted.com ([148.163.137.242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569229df20=volodymyr_babchuk@epam.com>)
 id 1r6fXI-0003dN-05; Fri, 24 Nov 2023 18:24:37 -0500
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AOMwAPK014042; Fri, 24 Nov 2023 23:24:29 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3uk2wmr6b0-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Nov 2023 23:24:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8iqL1p9hM7JDy2vjcS3+1q4pA+KmyXHAtyotsorzKcIDmP0ob6nfvSX98zid0DvMR7l3y99NX8mOLLl3E6SofGhenTPj4Nq++3yGMttJ6TKvg+aBaXu7G+qT6TDR9c/xQPQaO7RnxJY211ZdPehy7emA8sBir+Jdk53GWOSaCDfSeIIEERvfaM05moYKoqEu4PRMnVsO/oxyr8jPGNVBjFf23yK3BcqdDpthtOMfqEax8lnMFEG1Qvzbu1Ou1cyCp1BndSb57n0h4K6yAZxIGfUKe2aYD1KxkRBDPaY3RYalU7wBf0Q8ObbdRf+v5fN9S1zQEDkDtZxUB59DkVIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=602dKa1VR8fPvQHqtVLjjZVu2RbSyKF63LAUWSpxQ3M=;
 b=f3noakK5BBcEGsFSEA4/mYkq28nqi+1gu/pWV3cW4jkG4J+2SGwE02wsHbkp77/8iOH70KkJd32iDQYl7Rcp8DnTc3BTpmyg3ovgiubT3dzhRUZUDxXtaXik21cb//uemCkw1VI8SIjDozKIFQqUUha+h49QUhHMAY8XMtOjUt8QwFqllVhkjmbydEZI2gY77Y+qYkH7v0A1NxrnTAUMfhh9GCMflwbO2WnBYKFTe2o5GLMz5zTEDSKt3WH5hBbtJlzVOD9fBI7eTdEUKaEdYQC0/esY3ZysGsSGGyXbkEb7Jh1tihmrq4f2bWT18Fucpq8s1AXRiYSUDA+yRcJNOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=602dKa1VR8fPvQHqtVLjjZVu2RbSyKF63LAUWSpxQ3M=;
 b=VPagikpJskYrT0a3uKTUr3+4rPtVZIGg8v1bTdj2NahSnqbUbqcrPLbpuZFj2uJOmvR/06Yi89vGgT1u5EDyymtoWS+tM5NIE/X+Gv1X5hjLofM8R/MXueedBat4KFXyEiz3Czo3YM7nSnuix5j/vxKw9qlKa8TyF+c4oWMcjDCtKCEfTszBe77od5W2MyFXzoNU8x4zDqzA1fRAVlOfXRTmPPwt6aObNN1vaUwy3d+Y0qd1fudcoPfYuzRb2tt5nyyEUb0sLvFEJPJufaDh/C3WFWOyycZeoQAfQ/dxuiYlco8sTFTTg3So7VNCpgpQ5Yp/hcyIkoIDtlB9w3C7uQ==
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com (2603:10a6:803:31::18)
 by DU0PR03MB8551.eurprd03.prod.outlook.com (2603:10a6:10:3e2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 23:24:24 +0000
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::8e03:368:1fd7:1822]) by VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::8e03:368:1fd7:1822%6]) with mapi id 15.20.7025.022; Fri, 24 Nov 2023
 23:24:24 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: David Woodhouse <dwmw@amazon.co.uk>, Stefano Stabellini
 <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>, Volodymyr Babchuk
 <Volodymyr_Babchuk@epam.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: [PATCH v3 4/5] xen_arm: set mc->max_cpus to GUEST_MAX_VCPUS
Thread-Topic: [PATCH v3 4/5] xen_arm: set mc->max_cpus to GUEST_MAX_VCPUS
Thread-Index: AQHaHy1bXZxItaI7lEWj7O2d5pS3Rw==
Date: Fri, 24 Nov 2023 23:24:23 +0000
Message-ID: <20231124232400.943580-5-volodymyr_babchuk@epam.com>
References: <20231124232400.943580-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20231124232400.943580-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.42.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR03MB3710:EE_|DU0PR03MB8551:EE_
x-ms-office365-filtering-correlation-id: 0abb95d0-583f-42ef-b57a-08dbed447eaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wV+C2ZR05VHyKijt+4qVUF8aa+iE89gLOX4tmsASRtMPT+0Nz8wS9qJTZ+aXj6jOhMFYSy+qO3FmEq+b5iXH88fmE2v7he8IcZsZZf9cwPbG/L/rtL28XjhniMm2p2XQPkIcAxKZPGzod7Qc1+xb/BCAhQySb6GIHh6EZHEUZTdlW8uKfk4wx0ee8hy/r4RX+6Lo5QkJPphxaC8PZmowkN94tm+rfMpNYCS2e1TAqq+D2RDFwaecSlr3lEIJs8U83FvIe0yoeeSlUJDfBKYoW66aIgBnijByUf3qUWAM58QQ4bOJOUvZr+ud4gqkLMLxe4zsUstsnkZ0Cu2QcBIA9SYRvzqSCtEO6MPnFzDzjcSsJ8MlSQxlCkW7mqdXiRhTOUFkVjaTsjwBxItjDu1GGVr0ZNVFbn28xDNO/itxDbGG3UL75R1J4S7QIM0nAutbrPY8eEGMP5e21IHjBIesaUYnoPjR0MpRrsqJqHJvzhgMlIk0DMfbii870Sjt8VTLBbMyNbTyKpvpGdnDSDx9fhN8A9i1qgbuE3tDekNczNc7l/nwj0PdgSsOUprZBlMvlafaQDLAkozBNDu6uVEMP8dEC5VE6GUGZuaacsrj9/Pcqi8a6PeZpWrVz/M0Zeh5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR03MB3710.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38100700002)(1076003)(6512007)(83380400001)(2616005)(6506007)(55236004)(71200400001)(41300700001)(8676002)(4326008)(5660300002)(8936002)(26005)(478600001)(6486002)(2906002)(6916009)(316002)(91956017)(66476007)(66446008)(54906003)(64756008)(76116006)(66946007)(66556008)(86362001)(122000001)(36756003)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVFKVjFMYnpidDMyT0IyNm5RK0xIUnkydldSVFhxMmlxLzN3RjZPanVCRFRV?=
 =?utf-8?B?TGtVcS9xY2dOTTBmeDZ2RElRcXRobXlXcitRWXhhZ3dLZ2V0TW5TeVRnaDVL?=
 =?utf-8?B?S09HYWJsYnBaNlc5S2llRDJQY1RxUExjcTJNcWZJRS9oSzYxejVDVFZrNHUv?=
 =?utf-8?B?dlVabzdHTmVOaUFHekk5ekJzdDhodGYvMHI3a2E3b0JPUXFEMndUZHhHOEJ1?=
 =?utf-8?B?ckhKejlGM0cxY21oQTJBUnFmMzE3VDNuaWs5RFhhVHJUcVNIdGdTeVd0SWdQ?=
 =?utf-8?B?SDY5YmJZVllUNlFmZUxPUlpYcWhlNUNuMi9zMG4yV0JpY1lqS29DUndtZGd0?=
 =?utf-8?B?MkRuS3BxSlZvRGI5NkxYQXAyaGo4N0krcjEyOE9GOUhyai9NZzMrV3lodGRM?=
 =?utf-8?B?bHFxaFYvTUkvSHhaclBrTGpWNGFQL3JHbUpIbVdjck9LVDAvUGorclcxV3ZU?=
 =?utf-8?B?TzFEYkZzcG1aNExNV3pTaHpsd0E0Y0V3WUVCdTZ2b3k0TUNKaHhaMjFPcEsz?=
 =?utf-8?B?SzF0Q3lPNldOMXBDcmtnWUFxVGFSQ2hSb1ROSGZ4R0lLR2xBaFZKbkUrWGxR?=
 =?utf-8?B?ZDdPVjBpU1NCVFlBWUpYK1creUpRUE1WaTVYTkpwQnM1V2RSRldSbGxVU3pI?=
 =?utf-8?B?TmNjcWhJVVE2d1BIRUtabVc2bU1hZ0gvc2VUMTFrREo4TW82M2srdi84Ykt5?=
 =?utf-8?B?aGwrUmwwVWo3byt1amlKQ2lzU1QxMkNWd3dvRjNydExsMDBPd1ZFZnN6WkVh?=
 =?utf-8?B?TFBBL0xqYWplT3U0KzJHUU1ZSWRmREV2SHRmTWNqbG9ycHRtUGRFeUFtb1Nu?=
 =?utf-8?B?SXJ6dHhPRUR3V0IyK1lvT1V1UXd0Q0hBR2FEYVpQSjhiR2RjeXIzTDJUa3o1?=
 =?utf-8?B?K1pHaGx5NElrNGFHay9BRzE0cTdsODJyaXZWZFVPS0t0M2JwRVdUMjd4NGJN?=
 =?utf-8?B?M2xTV0NHSEtuVHIrYU1wRGxiWERXaUo3d1NxRW4zdTFuMHBoRmJHazNkZzVS?=
 =?utf-8?B?TUs4QTM1aUpDZkkvVkFrVVZIM2tuUVRCaGdHWXFKS0tJQlVvZC9SOFM3WXA1?=
 =?utf-8?B?ZW1nRHU3RnhjQktUTUdHVXUxKzZOcnlSMjYyWGhYTVBVamljNVk4eStvSzRZ?=
 =?utf-8?B?Z0hiVkVsUGR3MXBqTFA5OFZvK3J1Z29EQUNZZzMySFpVcHJOR0FvVHhpaEx0?=
 =?utf-8?B?QkxFcWhLbUtudU1RRFIzeU1vcXY1VVJZSTh1SkhaRldIdXBnU2hWZW8xNnUz?=
 =?utf-8?B?VkJNSUlTZnFrbS9Dd3hoWUVwRzZpcjM5QnY1S1hNMjZOR2lJY3RhcEdBOUYv?=
 =?utf-8?B?eVdIN0RXb3FRWjM3R25mWUpoMWV0VForUVVwdXhET1l3Vnc3Y0F6N3RBYVR3?=
 =?utf-8?B?ekRyVEhLYjBSM2g4MXZEL2VyOFhIeXcxV1ZGU0l6cTNUcFBDWWl2QmJUYmQ3?=
 =?utf-8?B?TTdTUjNGRnIvaVhCT0xGanNOYnVKSko2bHZsVVIwTGI5VVoyRExNWjA2M1Js?=
 =?utf-8?B?cHloblh4cjNYRGt0dFFRWFdDN1d4VHgvdmFuVExyY2pSYWVtakc2WWYvWm16?=
 =?utf-8?B?WkxLM1RidVhuems5a0FLbWo4OEFtYkFhemkrZWNUQzdNdjJPRGVGWWYzTVdk?=
 =?utf-8?B?aHM1ejdsTXQyMGhFQXBhNUxXdFM2V01GQ1E1U2QxQUVnUzZ1SE9tMXFkTy95?=
 =?utf-8?B?UHM0OVIvZVp1Y1R4bGhiS1ZkZnlDY1pZUmZ1dHd4RnM0aWpGYlN6b2tPWkM4?=
 =?utf-8?B?SnluNzZRU0pBSEZyYjA0dHF2YUMyNTRnQWNkaFNSclN4WndRazNGQVJFcGFj?=
 =?utf-8?B?ajJoNDJjTEd2YW54QVNKWjBkOTl1cUdLcGovSmFqSVZTMCtCRDhiK2xjdTJR?=
 =?utf-8?B?SnNDbi9qc21OWVR6SDFiR21RL0xWN0J4V0FDZGRpQVpjM1ppSzBaNEVydE1v?=
 =?utf-8?B?MzdPWmx1ZlNHcXlueVRPRkFUYzY3ZkZLZmV6NFloTUxPaTBicEtjMFdRb3Aw?=
 =?utf-8?B?MFc0eFZkb2o0Z2lBYUhtb244a2VhMWY1elV0dDFyRWVMRTRrQk1oOS8vYW1t?=
 =?utf-8?B?L0E4WmRINzVMLzdKRi9HQnlPekJLWnFGSTlmaDV2U3V4M0JmV0QyTndwcVN3?=
 =?utf-8?B?YjViNGd2ZDhzS25SVzF5VS9PSE9QL2FLRHlxVUZaSkNKb3RGVVM2dXRZcWdo?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF87BA16DD90894B979141206C90B66D@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3710.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abb95d0-583f-42ef-b57a-08dbed447eaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2023 23:24:23.2961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QSgrPViEY6YWF14a4pkIINtrXTP8B5lDYZPKwo/6VSzP5c6qyHyP7I3fqvS+u+biAsZ/+oFhTQkejFCkbSWObCTecV6OAe2akeUrNk4d8xA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8551
X-Proofpoint-GUID: wlrvwSBVyXrZHTBAcyzmz3LHI6wiypTr
X-Proofpoint-ORIG-GUID: wlrvwSBVyXrZHTBAcyzmz3LHI6wiypTr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-24_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311240182
Received-SPF: pass client-ip=148.163.137.242;
 envelope-from=prvs=569229df20=volodymyr_babchuk@epam.com;
 helo=mx0b-0039f301.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

RnJvbTogT2xla3NhbmRyIFR5c2hjaGVua28gPG9sZWtzYW5kcl90eXNoY2hlbmtvQGVwYW0uY29t
Pg0KDQpUaGUgbnVtYmVyIG9mIHZDUFVzIHVzZWQgZm9yIHRoZSBJT1JFUSBjb25maWd1cmF0aW9u
IChtYWNoaW5lLT5zbXAuY3B1cykNCnNob3VsZCByZWFsbHkgbWF0Y2ggdGhlIHN5c3RlbSB2YWx1
ZSBhcyBmb3IgZWFjaCB2Q1BVIHdlIHNldHVwIGEgZGVkaWNhdGVkDQpldnRjaG4gZm9yIHRoZSBj
b21tdW5pY2F0aW9uIHdpdGggWGVuIGF0IHRoZSBydW50aW1lLiBUaGlzIGlzIG5lZWRlZA0KZm9y
IHRoZSBJT1JFUSB0byBiZSBwcm9wZXJseSBjb25maWd1cmVkIGFuZCB3b3JrIGlmIHRoZSBpbnZv
bHZlZCBkb21haW4NCmhhcyBtb3JlIHRoYW4gb25lIHZDUFUgYXNzaWduZWQuDQoNClNldCB0aGUg
bnVtYmVyIG9mIGN1cnJlbnQgc3VwcG9ydGVkIGd1ZXN0IHZDUFVzIGhlcmUgKDEyOCkgd2hpY2gg
aXMNCmRlZmluZWQgaW4gcHVibGljIGhlYWRlciBhcmNoLWFybS5oLiBTbyB3aGVuIHRoZSB0b29s
c3RhY2sgcGFzcw0KbWF4X3ZjcHVzIHVzaW5nICItc21wIiBhcmcsIG1hY2hpbmUgY3JlYXRpb24g
d2lsbCBub3QgZmFpbC4NCg0KU2lnbmVkLW9mZi1ieTogT2xla3NhbmRyIFR5c2hjaGVua28gPG9s
ZWtzYW5kcl90eXNoY2hlbmtvQGVwYW0uY29tPg0KU2lnbmVkLW9mZi1ieTogVm9sb2R5bXlyIEJh
YmNodWsgPHZvbG9keW15cl9iYWJjaHVrQGVwYW0uY29tPg0KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCi0tLQ0KIGh3L2FybS94ZW5fYXJt
LmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQoNCmRpZmYgLS1naXQgYS9ody9hcm0veGVuX2FybS5jIGIvaHcvYXJtL3hlbl9hcm0uYw0KaW5k
ZXggYTU2MzE1MjlkMC4uYjljM2FlMTRiNiAxMDA2NDQNCi0tLSBhL2h3L2FybS94ZW5fYXJtLmMN
CisrKyBiL2h3L2FybS94ZW5fYXJtLmMNCkBAIC0yMzEsNyArMjMxLDcgQEAgc3RhdGljIHZvaWQg
eGVuX2FybV9tYWNoaW5lX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCB2b2lkICpkYXRhKQ0K
ICAgICBNYWNoaW5lQ2xhc3MgKm1jID0gTUFDSElORV9DTEFTUyhvYyk7DQogICAgIG1jLT5kZXNj
ID0gIlhlbiBQYXJhLXZpcnR1YWxpemVkIFBDIjsNCiAgICAgbWMtPmluaXQgPSB4ZW5fYXJtX2lu
aXQ7DQotICAgIG1jLT5tYXhfY3B1cyA9IDE7DQorICAgIG1jLT5tYXhfY3B1cyA9IEdVRVNUX01B
WF9WQ1BVUzsNCiAgICAgbWMtPmRlZmF1bHRfbWFjaGluZV9vcHRzID0gImFjY2VsPXhlbiI7DQog
ICAgIC8qIFNldCBleHBsaWNpdGx5IGhlcmUgdG8gbWFrZSBzdXJlIHRoYXQgcmVhbCByYW1fc2l6
ZSBpcyBwYXNzZWQgKi8NCiAgICAgbWMtPmRlZmF1bHRfcmFtX3NpemUgPSAwOw0KLS0gDQoyLjQy
LjANCg==

