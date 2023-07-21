Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCED75CA8A
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 16:50:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMrRp-0002yL-E3; Fri, 21 Jul 2023 10:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qMrRl-0002nX-T7
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:49:35 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qMrRj-0004mk-WB
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:49:33 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36LCwD6r029460; Fri, 21 Jul 2023 07:49:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=VOYz5S/4uYWfmd8nUc24UL/Kyx+8c7qNbEVR9P
 b3iZs=; b=jxuC6aPIWp6gVOnpBsxVxoYTWMFxlzGjJznK8Y0eBD1YBovvhcLeEq
 FhjhxI+y2Mbng9VlSBzewQDKAqX8OBouJqYlQQZZstVB/Unx1n6tXAxO0t8774Bp
 19cB/ER3tHI5vdu6s9R3cZn9wU0qsESWdJKHpY9Go/H8uNS64VWpKMSFr7WVIDQo
 zi45raJeRpIPISZojaC0YhkI2w74fj6DejZAWmi/EXiuHvnDtuPEix1G0cjTF7E9
 Z4A9QQrNjHuMnkhSOfXCiO8Q860sdlWrJz1owcoRNKb7Njyh7zqA72FIQYiLBJ7i
 kQSxzG23bKhbM+YrAN+yi/DLXWYzNl5w==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rx319phvm-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jul 2023 07:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkRMYdiyTGPkThkJmRmsaL9NL5CeBz3iznNK/9a2MwjqawHgIgXJbZFGwmbZEEVEPAsf9PBwuXDwyDSSo05NWFf/wAc17LkocyjN6Ih5ky+KMA3YaGZe3V4MFrgVyWR12vSsIhM9DrUd8epiAFldQhXYAQwlhK2hSWeds3pa1RybNxlAfiq6ZzBxdnvB9ataEyjekJY0dhiwRfBJAvofyLs0P0tpRiwHo9DS0h+nIguh6zXnofE/YCkaaXpPgszwRztzT05ef4V4CMP7OfKXFc+0tm6+M3yM7m55zCZZmOS5ojeNUY3RNPmoVVo/15MGZfyAm4L2e6aewlJnlvQGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOYz5S/4uYWfmd8nUc24UL/Kyx+8c7qNbEVR9Pb3iZs=;
 b=HFipw8MBDjxZn0T4eq9VAxeKIw506Wt7VHHH3zfNaneUX1G7Sl2wOTvCukAiSlJFSa5ltnF/6Pg3wqucDKtH4CEsz2MIzz4vcA3xuJtPH/SZ6FmrgndtXO5otQrWrUFYBVmlPqYwTr002ts+OpEpKZQfcXcAILrZbUgiSS7K8eg/VYtYDkjWy+xMMIE3B6aabQYIBJb6ayKuUCfIUTJYLfRikeC5ng3pklBicn0CFHPta5YmBdvVTycsnomsHMrF3oTIsXK4WtCxvbjLO6Do3+CBtGN9fYBJ6g9f3j7e9rGpSoLcF2uI4fdOYdECLMacRQMr5eueIVS5ZLqyKhURBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOYz5S/4uYWfmd8nUc24UL/Kyx+8c7qNbEVR9Pb3iZs=;
 b=T/r1rkl8rJs0ihLBiCGDT6uhVJ5DdCPTs7YW5OLsSpPhscgQttgrm7EMu0lgisR7iYJ1uz8B38WWko/x/N5oZGJvrzwOD2p030OBNQxOsYdZrKxabfYlCqnxSZYZLfcvLfTwKP2DXSw0HnkWgZmj9YN9CohTpiUbgwaa24Zllq8kCTD9uKyX2lA7YGwOJLb3vQIEGx8CpmLjVZfKHChQKs7/qTkHyDUKE2V2xJzuEbOmwhfkZMa63nVHZI7MJkk2cQkMgV5rxs/jiJTnUC/snDk+jhdgfkmeYQ4BW8eiZdL2TVFOSrs2yahHOMUVxNaZnbrmtd7ojE2vxM91a9D/Zg==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by SA2PR02MB7561.namprd02.prod.outlook.com (2603:10b6:806:140::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 14:49:29 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e%7]) with mapi id 15.20.6609.022; Fri, 21 Jul 2023
 14:49:29 +0000
From: Het Gala <het.gala@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Prerna Saxena <prerna.saxena@nutanix.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, Manish Mishra
 <manish.mishra@nutanix.com>, Aravind Retnakaran
 <aravind.retnakaran@nutanix.com>, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v9 05/10] migration: convert exec backend to accept
 MigrateAddress.
Thread-Topic: [PATCH v9 05/10] migration: convert exec backend to accept
 MigrateAddress.
Thread-Index: Adm74o1FEhxkOQ2ejke62AvxQfbATQ==
Date: Fri, 21 Jul 2023 14:49:29 +0000
Message-ID: <20230721144914.170991-6-het.gala@nutanix.com>
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
x-ms-office365-filtering-correlation-id: 7f3ed791-6dd0-4e03-04cd-08db89f9afca
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e72fazQdGNASiWpdoYuSkIX0gncfF05QR7M7e4S/BexM08UQEQB8etoDqBQ8Atb5sMXwHQcTc2l5xfZs69PfAcjFWjhrM2h9ltXGfkZMiiMS+xw4KGHnVBOg125sC+iTP6+s9MqK/+oisXOYlshuA6NoeRXtnYmizR61eye0soI3kgjHh4nCRG9HRzbIA1cpR/Wp/eM6mI9a2R7orTPsPseH2+WmPOWtZMn3LXZSHHOBuaNe2U3whTSycI8+62rJNDMreih27s5gxWEmexutkdbSXfaJwrPfL7R16gIfB2b1L5j1UX7EvGty47NVzJWLCDJclCznvI1JFwetIyHRYLt07k4YpOS0hpmY1sBqJP5xlDjivXSRAnlIfG4HAoLnvzctqnudpEI2kM1TTh0E6hfnPhkOsB2RF/XK/WjevvsmwXGG3R5iSyI1j/Rd5hogAm3SvsAZUBmPQ67WR4arXMWwlavqlGiI7CGY8aH2Lhum/tNgrnU1yh9uz7DsNybiuJMy0g5SFy7OVL7qg6jQ0pIYKVlF9dIFFjyK9lB8mXOWxgpLx+mDWtWHMR0c6+lI9K6oj8GkIoH8f4QEJ4x3Yis8jtW9BX2CWCIh+65xmgrNMCjb/5sjmGy4yGggX773I7cPo36s38IsjFZEREVkxw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(2616005)(6486002)(52116002)(6512007)(71200400001)(478600001)(86362001)(26005)(1076003)(107886003)(6506007)(36756003)(5660300002)(4326008)(44832011)(6916009)(41300700001)(8936002)(8676002)(316002)(2906002)(122000001)(38100700002)(54906003)(64756008)(66476007)(66556008)(66446008)(66946007)(38350700002)(186003)(83380400001)(218753002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzFuQXhGQTFuN1RJTFBPSzdZOUE5OFJnQzhrUWtlNnNqaGV3NzR1Q1pOSTRI?=
 =?utf-8?B?c04rNTVCVkVtYlMzSWhhR2JKVWc3OTJBaCtpS2p4TStHNmljeExQeXI2UUxm?=
 =?utf-8?B?M245bU14dzJWcXMvZGo5aFRjbkw4VEhxRC8wZE5yNlBla2VjaVdzMmw3R3Iv?=
 =?utf-8?B?andZTzM5ZHpzQzk0dVRiL3A0WnEwQk45VDBhZVNXdmIza3NERXd4aC9IY0lD?=
 =?utf-8?B?aWFVeCtrbDQrc0libVorZzFkSVc3bCttNVd1QTBSTGdnTGJRSHpOTGVuTzN5?=
 =?utf-8?B?WDZoS21TRWNWZllXRW9ibWw2UGdMb3ZNOVFNMVFUVXkwVXhqVm8zUC80ZE5y?=
 =?utf-8?B?OXBsZjgzSVNEcEZLd3lqeEFoa1lXbmdoTEdKRkRhVWFqa0NTSk5BMml0QUFW?=
 =?utf-8?B?cWJYUDFwTjJia01WMHBrd3BlS1ArYk1lR1AvYjRKWm91b0FGQ0RQNGJTcTZo?=
 =?utf-8?B?SDhBQmJXbXJFQzkvRi93RFRWWWFEV2JFaGlwaUkrZWVYaCtMYUdlRW9BRFpM?=
 =?utf-8?B?ci8waFZpZDVPZHQ4OXdPdVAremlCUGVnNVBOcEk0VkE0aEkzSWtZNFJ0dnFZ?=
 =?utf-8?B?OGpXYmpBUTJTN2psOUpLUU82QllUSHVyUVhueHZuNEVqNktzS0crSkt3dUI0?=
 =?utf-8?B?eTJzV2tYRTh3bjZhUGFQWktZVXJ6aGpUMUZ4Q0dQUHpCbFIxVUlybitDVUtr?=
 =?utf-8?B?cm9JdWg4alBFR2VISVhwLzdBRVhxUjlNMlJiOTJqMG9VVlJyTkdqQzFrYkN4?=
 =?utf-8?B?ZUp2SnlzNjdGdEJ5REdsaEZhSk5BWW9lWmVBZlFpTC9ieWNSbHlXTGFPaXgx?=
 =?utf-8?B?Z1dha3Z1UWxEKzh5aWE0MTkvSXVUb09vSFVTOTk3eEJERzVYU013RDJxMGhv?=
 =?utf-8?B?SXBGaXhwZHVqdUYrOE14L0QyUUF1cHBoM1gvSHBrQVExUHl3OGFUN3pGOWd2?=
 =?utf-8?B?ekpjTVhlVDQxODdmNDN6NkhhZUZZRjU4VFBZbUo0cDBXelY3Z3BiVFAyZDBV?=
 =?utf-8?B?WU80c0xKTkZ4WkRTanJSa3QrWEhPbDRiY09ZNTVHY3NkYWYxVEtLdnFjYmRU?=
 =?utf-8?B?N2NKdm0zcWdjSHdieFNGQTVueUdaK3Z0VmxEOTlyYXNIZ0VlQUsxeWEwQXI1?=
 =?utf-8?B?T3QxSEhnU2FwWWtvVitkOFJaMDVBUENwY0tnb0s3N2NzWVBUajlLODV3R3RN?=
 =?utf-8?B?Q0tTbFRtL2lJYlhVelFndEIvL2xMM2NMNVZpaEpQcUJqV3FiZEFvVGpYeEc4?=
 =?utf-8?B?ZktzcjZEQTdaVExBRmgxbkcvQTVYOFBDbmZoMS94TGFmdDRpM1hIS1ZkZnhh?=
 =?utf-8?B?WlFQN2NkZC9veTdXMW9HakpFUys0bmhiUXdhbmNuVXpSUU91eU9qeHA0WFEy?=
 =?utf-8?B?bm5id3hETTBTSm1nbDVnelMrVFl3b0hKM0k4UWQ5RC9waWRxckR5bmNBenVD?=
 =?utf-8?B?SkVGZWVtRGROT3ZYSFJMbUp4WnpBSmlXOVVIeE50RmprT0I5TGsxMUNYV1hi?=
 =?utf-8?B?NStueDF3VThEOStmWUl4Z0NDVEZIem9kY0F0Tmx3Y3cwVWc4SGFaOUtQTUJ2?=
 =?utf-8?B?M25SekdxZFdHalZlMVV0bTV1YmJ0WEloWGdiL3VmN3ZzMUg2M0VqWXdrSHc4?=
 =?utf-8?B?QUtkaFNEa1VKZUszMzdTR3VBM2JNdDJCeDR6L3VYNWI1UER0d1VRZkJxQWJX?=
 =?utf-8?B?MjJlbUtlZjN3dVpJc01aeVFuc3RNdk5qYUpSV3lHVGdXV2srZEpRY2NvOVVO?=
 =?utf-8?B?bkl2ckIzY0gzVWw0ekJHWUVWV0Y0cHE0RUhrV1c2TDRIbTRYUDVtY1AvRzlR?=
 =?utf-8?B?YjlFVTYrRkFIUHNBaW9aQWtZYVVINjh1cGVjejBNaUlmRlZ4SlpxVmY3eXN0?=
 =?utf-8?B?Ly9wRFNucTlLUW94Qi9FblhUb0RERWdKcmUzUExGQnZTamUxc3NZTTlqWmor?=
 =?utf-8?B?WWlCMXVESVlYaXdCRytyQVB4M3lVU3JIeVUvRVVmK2t5ZElnMHgxM1FGb3l0?=
 =?utf-8?B?d2tkRzVxVFZ5eW4wM3RaMEdTdGY2eThReHVPZzNDVU16NjFITDdMUjdaYjh6?=
 =?utf-8?B?c2ZVYWNSZW1GSWpRd3lZOGJrSUM1Mk93S200dE9pTlkvWVQrbzMweS91d3hE?=
 =?utf-8?B?VnBmTitHMWEyaFlYVVpZbnMzMytacnNhR3ZWSTVrUFFWdGtYUHhZZ2ZNNTZZ?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4C8A4F8D3044143B198CDA4308A7F99@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3ed791-6dd0-4e03-04cd-08db89f9afca
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 14:49:29.1579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MEXtDuyBFFnEY6p4wEyMfno/IpKwb9y6nun4uxGbCLT3VsN3tYDv1GYo0fO1OppZVtsKGtKqJs4ZiPHBMDUZFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7561
X-Proofpoint-GUID: Wj51MFHXrPQsaRS5EfWkMGHCKEQKECc7
X-Proofpoint-ORIG-GUID: Wj51MFHXrPQsaRS5EfWkMGHCKEQKECc7
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

RXhlYyB0cmFuc3BvcnQgYmFja2VuZCBmb3IgJ21pZ3JhdGUnLydtaWdyYXRlLWluY29taW5nJyBR
QVBJcyBhY2NlcHQNCm5ldyB3aXJlIHByb3RvY29sIG9mIE1pZ3JhdGVBZGRyZXNzIHN0cnVjdC4N
Cg0KSXQgaXMgYWNoaXZlZCBieSBwYXJzaW5nICd1cmknIHN0cmluZyBhbmQgc3RvcmluZyBtaWdy
YXRpb24gcGFyYW1ldGVycw0KcmVxdWlyZWQgZm9yIGV4ZWMgY29ubmVjdGlvbiBpbnRvIHN0ckxp
c3Qgc3RydWN0Lg0KDQpTdWdnZXN0ZWQtYnk6IEFyYXZpbmQgUmV0bmFrYXJhbiA8YXJhdmluZC5y
ZXRuYWthcmFuQG51dGFuaXguY29tPg0KU2lnbmVkLW9mZi1ieTogSGV0IEdhbGEgPGhldC5nYWxh
QG51dGFuaXguY29tPg0KUmV2aWV3ZWQtYnk6IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdl
QHJlZGhhdC5jb20+DQotLS0NCiBtaWdyYXRpb24vZXhlYy5jICAgICAgfCA3MSArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQogbWlncmF0aW9uL2V4ZWMuaCAgICAg
IHwgIDQgKy0tDQogbWlncmF0aW9uL21pZ3JhdGlvbi5jIHwgMTAgKysrLS0tDQogMyBmaWxlcyBj
aGFuZ2VkLCA1NyBpbnNlcnRpb25zKCspLCAyOCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L21pZ3JhdGlvbi9leGVjLmMgYi9taWdyYXRpb24vZXhlYy5jDQppbmRleCAzMmY1MTQzZGZkLi44
YmMzMjFjNjZiIDEwMDY0NA0KLS0tIGEvbWlncmF0aW9uL2V4ZWMuYw0KKysrIGIvbWlncmF0aW9u
L2V4ZWMuYw0KQEAgLTM5LDIwICszOSw1MCBAQCBjb25zdCBjaGFyICpleGVjX2dldF9jbWRfcGF0
aCh2b2lkKQ0KIH0NCiAjZW5kaWYNCiANCi12b2lkIGV4ZWNfc3RhcnRfb3V0Z29pbmdfbWlncmF0
aW9uKE1pZ3JhdGlvblN0YXRlICpzLCBjb25zdCBjaGFyICpjb21tYW5kLCBFcnJvciAqKmVycnAp
DQorLyogcHJvdmlkZXMgdGhlIGxlbmd0aCBvZiBzdHJMaXN0ICovDQorc3RhdGljIGludA0KK3N0
cl9saXN0X2xlbmd0aChzdHJMaXN0ICpsaXN0KQ0KK3sNCisgICAgaW50IGxlbiA9IDA7DQorICAg
IHN0ckxpc3QgKmVsZW07DQorDQorICAgIGZvciAoZWxlbSA9IGxpc3Q7IGVsZW0gIT0gTlVMTDsg
ZWxlbSA9IGVsZW0tPm5leHQpIHsNCisgICAgICAgIGxlbisrOw0KKyAgICB9DQorDQorICAgIHJl
dHVybiBsZW47DQorfQ0KKw0KK3N0YXRpYyB2b2lkDQoraW5pdF9leGVjX2FycmF5KHN0ckxpc3Qg
KmNvbW1hbmQsIGNoYXIgKiphcmd2LCBFcnJvciAqKmVycnApDQorew0KKyAgICBpbnQgaSA9IDA7
DQorICAgIHN0ckxpc3QgKmxzdDsNCisNCisgICAgZm9yIChsc3QgPSBjb21tYW5kOyBsc3Q7IGxz
dCA9IGxzdC0+bmV4dCkgew0KKyAgICAgICAgYXJndltpKytdID0gbHN0LT52YWx1ZTsNCisgICAg
fQ0KKw0KKyAgICBhcmd2W2ldID0gTlVMTDsNCisgICAgcmV0dXJuOw0KK30NCisNCit2b2lkIGV4
ZWNfc3RhcnRfb3V0Z29pbmdfbWlncmF0aW9uKE1pZ3JhdGlvblN0YXRlICpzLCBzdHJMaXN0ICpj
b21tYW5kLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJw
KQ0KIHsNCiAgICAgUUlPQ2hhbm5lbCAqaW9jOw0KIA0KLSNpZmRlZiBXSU4zMg0KLSAgICBjb25z
dCBjaGFyICphcmd2W10gPSB7IGV4ZWNfZ2V0X2NtZF9wYXRoKCksICIvYyIsIGNvbW1hbmQsIE5V
TEwgfTsNCi0jZWxzZQ0KLSAgICBjb25zdCBjaGFyICphcmd2W10gPSB7ICIvYmluL3NoIiwgIi1j
IiwgY29tbWFuZCwgTlVMTCB9Ow0KLSNlbmRpZg0KKyAgICBpbnQgbGVuZ3RoID0gc3RyX2xpc3Rf
bGVuZ3RoKGNvbW1hbmQpOw0KKyAgICBnX2F1dG8oR1N0cnYpIGFyZ3YgPSAoY2hhciAqKikgZ19u
ZXcwKGNvbnN0IGNoYXIgKiwgbGVuZ3RoKTsNCiANCi0gICAgdHJhY2VfbWlncmF0aW9uX2V4ZWNf
b3V0Z29pbmcoY29tbWFuZCk7DQotICAgIGlvYyA9IFFJT19DSEFOTkVMKHFpb19jaGFubmVsX2Nv
bW1hbmRfbmV3X3NwYXduKGFyZ3YsDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE9fUkRXUiwNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZXJycCkpOw0KKyAgICBpbml0X2V4ZWNfYXJyYXkoY29t
bWFuZCwgYXJndiwgZXJycCk7DQorICAgIGdfYXV0b2ZyZWUgY2hhciAqbmV3X2NvbW1hbmQgPSBn
X3N0cmpvaW52KCIgIiwgKGNoYXIgKiopYXJndik7DQorDQorICAgIHRyYWNlX21pZ3JhdGlvbl9l
eGVjX291dGdvaW5nKG5ld19jb21tYW5kKTsNCisgICAgaW9jID0gUUlPX0NIQU5ORUwoDQorICAg
ICAgICBxaW9fY2hhbm5lbF9jb21tYW5kX25ld19zcGF3bigoY29uc3QgY2hhciAqIGNvbnN0ICop
IGFyZ3YsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPX1JEV1IsDQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJwKSk7DQogICAgIGlmICgh
aW9jKSB7DQogICAgICAgICByZXR1cm47DQogICAgIH0NCkBAIC03MSwyMCArMTAxLDIxIEBAIHN0
YXRpYyBnYm9vbGVhbiBleGVjX2FjY2VwdF9pbmNvbWluZ19taWdyYXRpb24oUUlPQ2hhbm5lbCAq
aW9jLA0KICAgICByZXR1cm4gR19TT1VSQ0VfUkVNT1ZFOw0KIH0NCiANCi12b2lkIGV4ZWNfc3Rh
cnRfaW5jb21pbmdfbWlncmF0aW9uKGNvbnN0IGNoYXIgKmNvbW1hbmQsIEVycm9yICoqZXJycCkN
Cit2b2lkIGV4ZWNfc3RhcnRfaW5jb21pbmdfbWlncmF0aW9uKHN0ckxpc3QgKmNvbW1hbmQsIEVy
cm9yICoqZXJycCkNCiB7DQogICAgIFFJT0NoYW5uZWwgKmlvYzsNCiANCi0jaWZkZWYgV0lOMzIN
Ci0gICAgY29uc3QgY2hhciAqYXJndltdID0geyBleGVjX2dldF9jbWRfcGF0aCgpLCAiL2MiLCBj
b21tYW5kLCBOVUxMIH07DQotI2Vsc2UNCi0gICAgY29uc3QgY2hhciAqYXJndltdID0geyAiL2Jp
bi9zaCIsICItYyIsIGNvbW1hbmQsIE5VTEwgfTsNCi0jZW5kaWYNCisgICAgaW50IGxlbmd0aCA9
IHN0cl9saXN0X2xlbmd0aChjb21tYW5kKTsNCisgICAgZ19hdXRvKEdTdHJ2KSBhcmd2ID0gKGNo
YXIgKiopIGdfbmV3MChjb25zdCBjaGFyICosIGxlbmd0aCk7DQorDQorICAgIGluaXRfZXhlY19h
cnJheShjb21tYW5kLCBhcmd2LCBlcnJwKTsNCisgICAgZ19hdXRvZnJlZSBjaGFyICpuZXdfY29t
bWFuZCA9IGdfc3Ryam9pbnYoIiAiLCAoY2hhciAqKilhcmd2KTsNCiANCi0gICAgdHJhY2VfbWln
cmF0aW9uX2V4ZWNfaW5jb21pbmcoY29tbWFuZCk7DQotICAgIGlvYyA9IFFJT19DSEFOTkVMKHFp
b19jaGFubmVsX2NvbW1hbmRfbmV3X3NwYXduKGFyZ3YsDQotICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE9fUkRXUiwNCi0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXJycCkpOw0KKyAgICB0cmFjZV9t
aWdyYXRpb25fZXhlY19pbmNvbWluZyhuZXdfY29tbWFuZCk7DQorICAgIGlvYyA9IFFJT19DSEFO
TkVMKA0KKyAgICAgICAgcWlvX2NoYW5uZWxfY29tbWFuZF9uZXdfc3Bhd24oKGNvbnN0IGNoYXIg
KiBjb25zdCAqKSBhcmd2LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
T19SRFdSLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXJycCkpOw0K
ICAgICBpZiAoIWlvYykgew0KICAgICAgICAgcmV0dXJuOw0KICAgICB9DQpkaWZmIC0tZ2l0IGEv
bWlncmF0aW9uL2V4ZWMuaCBiL21pZ3JhdGlvbi9leGVjLmgNCmluZGV4IDczNmNkNzEwMjguLjMx
MDdmMjA1ZTMgMTAwNjQ0DQotLS0gYS9taWdyYXRpb24vZXhlYy5oDQorKysgYi9taWdyYXRpb24v
ZXhlYy5oDQpAQCAtMjMsOCArMjMsOCBAQA0KICNpZmRlZiBXSU4zMg0KIGNvbnN0IGNoYXIgKmV4
ZWNfZ2V0X2NtZF9wYXRoKHZvaWQpOw0KICNlbmRpZg0KLXZvaWQgZXhlY19zdGFydF9pbmNvbWlu
Z19taWdyYXRpb24oY29uc3QgY2hhciAqaG9zdF9wb3J0LCBFcnJvciAqKmVycnApOw0KK3ZvaWQg
ZXhlY19zdGFydF9pbmNvbWluZ19taWdyYXRpb24oc3RyTGlzdCAqaG9zdF9wb3J0LCBFcnJvciAq
KmVycnApOw0KIA0KLXZvaWQgZXhlY19zdGFydF9vdXRnb2luZ19taWdyYXRpb24oTWlncmF0aW9u
U3RhdGUgKnMsIGNvbnN0IGNoYXIgKmhvc3RfcG9ydCwNCit2b2lkIGV4ZWNfc3RhcnRfb3V0Z29p
bmdfbWlncmF0aW9uKE1pZ3JhdGlvblN0YXRlICpzLCBzdHJMaXN0ICpob3N0X3BvcnQsDQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KICNlbmRpZg0K
ZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9taWdyYXRpb24uYyBiL21pZ3JhdGlvbi9taWdyYXRpb24u
Yw0KaW5kZXggODAxMmY5M2YxYi4uZjM3YjM4ODg3NiAxMDA2NDQNCi0tLSBhL21pZ3JhdGlvbi9t
aWdyYXRpb24uYw0KKysrIGIvbWlncmF0aW9uL21pZ3JhdGlvbi5jDQpAQCAtNDY4LDcgKzQ2OCw2
IEBAIHN0YXRpYyBib29sIG1pZ3JhdGVfdXJpX3BhcnNlKGNvbnN0IGNoYXIgKnVyaSwNCiANCiBz
dGF0aWMgdm9pZCBxZW11X3N0YXJ0X2luY29taW5nX21pZ3JhdGlvbihjb25zdCBjaGFyICp1cmks
IEVycm9yICoqZXJycCkNCiB7DQotICAgIGNvbnN0IGNoYXIgKnAgPSBOVUxMOw0KICAgICBnX2F1
dG9wdHIoTWlncmF0aW9uQWRkcmVzcykgY2hhbm5lbCA9IGdfbmV3MChNaWdyYXRpb25BZGRyZXNz
LCAxKTsNCiANCiAgICAgLyogVVJJIGlzIG5vdCBzdWl0YWJsZSBmb3IgbWlncmF0aW9uPyAqLw0K
QEAgLTQ5NCw4ICs0OTMsOCBAQCBzdGF0aWMgdm9pZCBxZW11X3N0YXJ0X2luY29taW5nX21pZ3Jh
dGlvbihjb25zdCBjaGFyICp1cmksIEVycm9yICoqZXJycCkNCiAgICAgfSBlbHNlIGlmIChjaGFu
bmVsLT50cmFuc3BvcnQgPT0gTUlHUkFUSU9OX0FERFJFU1NfVFlQRV9SRE1BKSB7DQogICAgICAg
ICByZG1hX3N0YXJ0X2luY29taW5nX21pZ3JhdGlvbigmY2hhbm5lbC0+dS5yZG1hLCBlcnJwKTsN
CiAjZW5kaWYNCi0gICAgfSBlbHNlIGlmIChzdHJzdGFydCh1cmksICJleGVjOiIsICZwKSkgew0K
LSAgICAgICAgZXhlY19zdGFydF9pbmNvbWluZ19taWdyYXRpb24ocCwgZXJycCk7DQorICAgIH0g
ZWxzZSBpZiAoY2hhbm5lbC0+dHJhbnNwb3J0ID09IE1JR1JBVElPTl9BRERSRVNTX1RZUEVfRVhF
Qykgew0KKyAgICAgICAgZXhlY19zdGFydF9pbmNvbWluZ19taWdyYXRpb24oY2hhbm5lbC0+dS5l
eGVjLmFyZ3MsIGVycnApOw0KICAgICB9IGVsc2Ugew0KICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJw
LCAidW5rbm93biBtaWdyYXRpb24gcHJvdG9jb2w6ICVzIiwgdXJpKTsNCiAgICAgfQ0KQEAgLTE2
OTMsNyArMTY5Miw2IEBAIHZvaWQgcW1wX21pZ3JhdGUoY29uc3QgY2hhciAqdXJpLCBib29sIGhh
c19ibGssIGJvb2wgYmxrLA0KICAgICBib29sIHJlc3VtZV9yZXF1ZXN0ZWQ7DQogICAgIEVycm9y
ICpsb2NhbF9lcnIgPSBOVUxMOw0KICAgICBNaWdyYXRpb25TdGF0ZSAqcyA9IG1pZ3JhdGVfZ2V0
X2N1cnJlbnQoKTsNCi0gICAgY29uc3QgY2hhciAqcCA9IE5VTEw7DQogICAgIGdfYXV0b3B0cihN
aWdyYXRpb25BZGRyZXNzKSBjaGFubmVsID0gZ19uZXcwKE1pZ3JhdGlvbkFkZHJlc3MsIDEpOw0K
IA0KICAgICAvKiBVUkkgaXMgbm90IHN1aXRhYmxlIGZvciBtaWdyYXRpb24/ICovDQpAQCAtMTcz
MSw4ICsxNzI5LDggQEAgdm9pZCBxbXBfbWlncmF0ZShjb25zdCBjaGFyICp1cmksIGJvb2wgaGFz
X2JsaywgYm9vbCBibGssDQogICAgIH0gZWxzZSBpZiAoY2hhbm5lbC0+dHJhbnNwb3J0ID09IE1J
R1JBVElPTl9BRERSRVNTX1RZUEVfUkRNQSkgew0KICAgICAgICAgcmRtYV9zdGFydF9vdXRnb2lu
Z19taWdyYXRpb24ocywgJmNoYW5uZWwtPnUucmRtYSwgJmxvY2FsX2Vycik7DQogI2VuZGlmDQot
ICAgIH0gZWxzZSBpZiAoc3Ryc3RhcnQodXJpLCAiZXhlYzoiLCAmcCkpIHsNCi0gICAgICAgIGV4
ZWNfc3RhcnRfb3V0Z29pbmdfbWlncmF0aW9uKHMsIHAsICZsb2NhbF9lcnIpOw0KKyAgICB9IGVs
c2UgaWYgKGNoYW5uZWwtPnRyYW5zcG9ydCA9PSBNSUdSQVRJT05fQUREUkVTU19UWVBFX0VYRUMp
IHsNCisgICAgICAgIGV4ZWNfc3RhcnRfb3V0Z29pbmdfbWlncmF0aW9uKHMsIGNoYW5uZWwtPnUu
ZXhlYy5hcmdzLCAmbG9jYWxfZXJyKTsNCiAgICAgfSBlbHNlIHsNCiAgICAgICAgIGlmICghcmVz
dW1lX3JlcXVlc3RlZCkgew0KICAgICAgICAgICAgIHlhbmtfdW5yZWdpc3Rlcl9pbnN0YW5jZShN
SUdSQVRJT05fWUFOS19JTlNUQU5DRSk7DQotLSANCjIuMjIuMw0KDQo=

