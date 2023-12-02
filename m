Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0172080199D
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 02:43:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9F1g-0007ZE-Gw; Fri, 01 Dec 2023 20:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6700ee1bd8=volodymyr_babchuk@epam.com>)
 id 1r9F0u-0007M3-6B; Fri, 01 Dec 2023 20:41:48 -0500
Received: from mx0b-0039f301.pphosted.com ([148.163.137.242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6700ee1bd8=volodymyr_babchuk@epam.com>)
 id 1r9F0n-00057W-TB; Fri, 01 Dec 2023 20:41:47 -0500
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 3B21X1Qo015641;
 Sat, 2 Dec 2023 01:41:28 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3uqa3aucrx-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 02 Dec 2023 01:41:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaLUJZVHbDztQuejeV3sVzX9LQU04aVbSmv6N1+oehtTnAAhn/d0BRXPldl2gYXq2KaPN9ErL2dLwwsVPG4DzjCbs/+cBHHP7vzC4FXsZ1ZlidenVD2ZGTl7Z0Z6LueVkvtprsCld3qxHXba9Jib6WuP3dGZ3PxtWY3m6VF4fojNRb5hpSeI6KGDfwL4hxq8PV9aWQM+lLemx6GrB9atYebLl/6dfb+4nHC02TVaYBW3xmxCDMz51aD7gFzUCUCJuqbPh63ihiqIZlmF8BS5P/LkLfgbLOz4AEclRyjotWpYccn0n+RVFF6Rbn1Y2LXH0KZNY5QbnsvXiGUSbxfUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=602dKa1VR8fPvQHqtVLjjZVu2RbSyKF63LAUWSpxQ3M=;
 b=n5j+mlTaClkxyp0BuuIR4D9Qif3k2R5aIZOsruCjfVhMMaE/Fb2MKDI//oLt6GoKcTLPaF9Dbm0ddoBOKOB4xpSh1zxkxO0glRHmR4rkciPCN9ss8tbXO6fmg07dyVR7YZ5uSThrKtBmeVZ7v3cams7U1+VeV6DXSwSj1oOeJRYxYn84+twy38J8vOmVfHgu3J6AFgL6RSsWUxG3Yz+GfoGnRmrDYpnD0GcJKyMsCsM5tT6cuZxRWO/8rmC6yqZpAy1t6DKT4CrswmJUFMsDgt8JfH/SrdVs0SpQJciGGQVymv2BwWjmITd7P/AV9tYeyblDOXqM3ehKqZ1UG1nXBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=602dKa1VR8fPvQHqtVLjjZVu2RbSyKF63LAUWSpxQ3M=;
 b=jmtdybKPcY4lEbWoQ99WvmhKu6sGJJDGM3Vv4VcsJgkESUcB7X2AhT9dOMfKwrbezhkHQ8sR6CQSNihRCRfSZZ2nBsO6YBFWIRVA0/Y3UrF18GiihDS5g7jm+X8nBCnJtA48k3CGXvXv0hfwJcnf/EFvArRK8nLuxkiIAMZo2tWQ/7bGIn833iHAmNL46MVTHkaVSntgX1i8gHBeZjxct5s/ewXcV2NjXKACPB7Pc/3AFNMRr7Tn2LeTVe9VmaAJgdv7TvugrjW72J/E4IvdR51qoQcsmpy5YQPh0Ecjr13RoHkn8DKo6/Izcpu67GZqEDLQLDnv3lobQOvLy0RAdg==
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com (2603:10a6:803:31::18)
 by AS8PR03MB7285.eurprd03.prod.outlook.com (2603:10a6:20b:2ef::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Sat, 2 Dec
 2023 01:41:23 +0000
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::8e03:368:1fd7:1822]) by VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::8e03:368:1fd7:1822%6]) with mapi id 15.20.7046.027; Sat, 2 Dec 2023
 01:41:23 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: David Woodhouse <dwmw@amazon.co.uk>, Stefano Stabellini
 <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>, Volodymyr Babchuk
 <Volodymyr_Babchuk@epam.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: [PATCH v4 5/6] xen_arm: set mc->max_cpus to GUEST_MAX_VCPUS
Thread-Topic: [PATCH v4 5/6] xen_arm: set mc->max_cpus to GUEST_MAX_VCPUS
Thread-Index: AQHaJMCoUgquUnKvjU6ewDeCcsRksA==
Date: Sat, 2 Dec 2023 01:41:23 +0000
Message-ID: <20231202014108.2017803-6-volodymyr_babchuk@epam.com>
References: <20231202014108.2017803-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20231202014108.2017803-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.42.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR03MB3710:EE_|AS8PR03MB7285:EE_
x-ms-office365-filtering-correlation-id: e70983a7-4d8f-4f2d-df4e-08dbf2d7ca8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +s0BWuGbZAopSfMhTEaqbTkFuUiXuR19EHTqtUxKwmvHHJrR2SZyYgmi6h8dGwpOhF0U1Rgpakk8Ien6fQ4WcXK6H5Rd6R1ZfhmCFIBg99OpJFdcLgnpw45HZfvbuKtyuTU7tEW7rDlw5uCm0G2w8MUBLfgvhZ3eTqCSVOyLK9TQYXKKuyantVjZiqjOfvprou4in6zz6VMVmC+K70Eq9l53ActWBCybkQy9+yjIAEzkvxSTgugvYvQkz/6IIkK9y01NjgRyj8RVq7zubFxZu/8aWxh6H0MBO1eWdD5BnT/TS+T3XwsgbqAR7FWhjXG9jvGStypGUEQgrqyS9r6T595gg/ndFj7VOdCuYQXKmZFHR+/RPSyFNtFHJaOK7anCLQ5zwL0fwpqfqywmmftWkg8OVljiV1H6B3xP1B9dDP0vn3zSXHQx5sUhvOO0a+3XOXHOTcJYGOvBxuMSMQXoMBaACOD+xc4awbtWNlM9Ju229ONPeMKiUiL+3u4POjwlGo+H/TP97svK9JAP9+QABsK3Oe0IeHo9+0NZhln8us7b5XVjHUqISrx0e8/EQ/V9eRo9ifJEZNTNe2xVPj8FqkevFhzA6UP2ZqLmXU54XSySZ2aGImMwtqpfE0bAh6V1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR03MB3710.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(122000001)(38070700009)(41300700001)(2906002)(5660300002)(83380400001)(71200400001)(55236004)(38100700002)(6506007)(6512007)(1076003)(2616005)(26005)(66556008)(478600001)(91956017)(6486002)(36756003)(76116006)(66946007)(64756008)(66446008)(8936002)(6916009)(54906003)(86362001)(66476007)(4326008)(316002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlV5eThXcW9ZOWYxb3VxbTh6SEVUWmJ1S3BIclJFQ0dmR3gybXd6YmRKT05L?=
 =?utf-8?B?amY3UXUwVmo1aWdib2pzbkdFUkJtWXNqZmJhZThqZ2Zka1d1L1Z2aTh3U0ha?=
 =?utf-8?B?elRPNkRoRkorRlBMeERXbVVDZGx0dlhhQTRmNk1adXpNYkU1QTJWWmY5WS91?=
 =?utf-8?B?Mm55K0JnMUQ2bVBQeWk2NGw0UEY5RTdMY0MzR2hEc0tSbUcwYVRmYkxpRlZ6?=
 =?utf-8?B?RHRpUjRVUENod0RDVHM0Zk9oTGorSDFUUkQ0aEdJdURJRW52aHE0RmZZQk9B?=
 =?utf-8?B?MVR3NldKM2taLzdEbzdMd3htcmU3RWRyaFZZOUhDRHUrMEF5b2MvbGpYT3dv?=
 =?utf-8?B?ZWZ5b1B0N0NlNjJ5Zi94bk5tak11MGo3dlJKNEFQUjBsdlFHMFVZd2FvTGhy?=
 =?utf-8?B?cjhhdlFieTFrYkZwc1Vpem1rNHE1VDYxRGd4TDNwUEVuTlkrRzRpRTVwVU1F?=
 =?utf-8?B?aEJnZ2p3YW9EdmFFdDhxVVhZTmpoejZzOHcyaXhpZjVjaXhVVHRhOHRoSy9L?=
 =?utf-8?B?Szl5aCtoM0Q0SExDbXA3bHc0T0tub1QwOC9GbzVXUTZKbnVEMzlUUjRXOFhW?=
 =?utf-8?B?UHduV1lsT3BBZmZtZjd3VDd4Uko3R3lyQVFDSFBRMFdUK0l4NFNnTjc4RCtF?=
 =?utf-8?B?YUwvR1NwcmV6YndPbTlQenVQbDluSlNSeHE1bS9JU3V5Y2dxM2xScnBSMHEr?=
 =?utf-8?B?dUt5aGYwRk44Njdabm8zUzVaYXF1RHdKeEdhSUZSa2IxdlZFQStxWlFnc2RD?=
 =?utf-8?B?N1p5T1BUUEJPWXgyb25xR1FTdTk1MktmV0xyU3M4ZmNsNEgybDN0TVVPU2p4?=
 =?utf-8?B?TkY1OUVkWHlDZ0N3b0U4c3pXVXJuMmFabEpIeGVkYWZSb1RTKzFwME1Yd0dm?=
 =?utf-8?B?bytIQ2h1M0NoYi94WURuQWo0QVZ0Q2I5YkdGSFZFeERsRUdXVEFyQ2xBUEFS?=
 =?utf-8?B?R2tRUXBadVBrVi9xVjBwU25GTkMrcWhjQjRaN1ZzbTZibVp1d29NdjAxYjBk?=
 =?utf-8?B?NTVzTUUyRzkzTkdqRmFLUit3a0FsSXlSWGRQTEUxYm5TWVY0c3pYd3RvMWZp?=
 =?utf-8?B?MUVHcmxDVEdVVWg0ckhEUUdBY21VOXMyTUVGeUhyMERWUFA2amJaMkRoOHIy?=
 =?utf-8?B?R09TYXlLUitjRWgvOFpYT2JBWmg2T3VvZ3VwS0oycDl2RkFEak51Tjh5cmo3?=
 =?utf-8?B?cCtZV3JneUora01OY09tWDFrK2RBdU1nSlIrUnQrSEhVME9RMzM5NjVhZkk1?=
 =?utf-8?B?QzJQRStKM0pxOWpsSm9xMzRhTGc3ODZUenpiRTRzeVk3b0lGSUx1cWRYTFU4?=
 =?utf-8?B?THFUQTRFTldtME1oS3lWQk1kVDBiUW9zUDRmSHEza3pOdkk5RHY3S2NZdHFi?=
 =?utf-8?B?alVjZW5NbmVGUEhuQXZzRDRMZWMzRE0va2xWdE41VkNWZXpTSHd2U2tlMm5m?=
 =?utf-8?B?QS9YY2psb1dCd0VRVjd4VUdOZFpJYTkzOVdTNHcvaU9hY2F3Z1BvRHAwbllG?=
 =?utf-8?B?bUZVSVJ4UWRGMjZsVWtacGdOWWkwK1dvaXpJNHZXNWRYeTNJSCtRUlFDODM1?=
 =?utf-8?B?VTdndVhYMFZIUW9wTk5nZWEwVjhwMTJnMytISUpRWVNvdUh0czJqaWgwSkFV?=
 =?utf-8?B?djB0RW5ZTjhHMGM0YjU2ZkNZQkxoNVBWMnVsTVcxbnhkSGdDN3V0bHJ5cFBh?=
 =?utf-8?B?U0tqYjlNNC9CTHpkVHBBVkE3cmF0ZmRLRHJtVE8xL01vaDJKbXo1YURPNFY1?=
 =?utf-8?B?NXF3RSt4M2greXJlVkh5UmdhUFlBRENnb3RlY0JSa0lNTWwrRytYazg4VVdK?=
 =?utf-8?B?K2NmdG5wQStBTlRIOW9IYnRQRVpnWUNPQzRIMDZpcnRlOUVHbktPZUdGWXFo?=
 =?utf-8?B?VHFiWjlYWGg1TkFoc2hwUkFsSUNlMFptbDErdXZYNTI1WndIU0p2MnZtVzJI?=
 =?utf-8?B?WmwzU1VuSmxjbThkUmU4WDZUVmhidXJKVk1KdEJvWVhER21QZk9TMFZBMnFH?=
 =?utf-8?B?Q2wrWHlSd3Y5SVdQUnZJWXZERFU3THNxR1pHTms1MU42REc1dk1tcmFlSHla?=
 =?utf-8?B?VGhQclkvYUdwTFRLMlJVT0MrZjZ5cSsxUUUzdW13VVYxVnZaUERZbTZEQ0Zp?=
 =?utf-8?B?RVQ2ZG5pMEFkZnB0cW14dDA4L3Z2YTdvaWRuWGNSMXlpR2hFNEtkRkI2dXJy?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A693FC4ED0861F4C8A66227288172DCC@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3710.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70983a7-4d8f-4f2d-df4e-08dbf2d7ca8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2023 01:41:23.2558 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 93VqHggG33F6TgXuJ/tp66ZEcCvhd05TUHlugZb2BVT1QYQD+oEV6jiM32nRXuyNPtb5/A2Nh11NbNZ/fqpuSFmg5uaOwPOcOc0sGQeMk/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7285
X-Proofpoint-ORIG-GUID: 8ZBby8TmH1h2ph8djR-WB88q5H98YnKi
X-Proofpoint-GUID: 8ZBby8TmH1h2ph8djR-WB88q5H98YnKi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_24,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312020009
Received-SPF: pass client-ip=148.163.137.242;
 envelope-from=prvs=6700ee1bd8=volodymyr_babchuk@epam.com;
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

