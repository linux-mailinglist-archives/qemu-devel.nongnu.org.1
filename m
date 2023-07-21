Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDF475CA96
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 16:50:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMrSN-0003ZX-P0; Fri, 21 Jul 2023 10:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qMrS6-0003Na-6R
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:49:54 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qMrRs-0004oY-6g
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:49:43 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36LDgFEC003513; Fri, 21 Jul 2023 07:49:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=vSqndeJjS5AH5gNpHzpeSwSHT4tT7TDFsVU9lRb8L
 14=; b=LZkrqAr2WHWUFNY/CAfKTeLPyJJcvWjwwkROUYhtox15aGA3pwUxG4/Ht
 bHCn+VcwlkUiJbzdKQ7R4VYV8EaQrpBJPh+ZUE9v/eUXuCuu4FHcduYDxGpti2Kj
 4BX3abXhg6vfyRbywyrGrMnith4bjJT3NkvRTMEYgKFwEL2qq0JXQBSgOsRbFpXF
 mQAlaGaBUqWD17/nks565q0Bu+YtKp3lX5NeVvQUEjRGqC3qP2lp9D8v4ElW85IE
 BiOLfwA/g1wlLg/zxRmy0r8YzzjxBiJRnFwKE2oCKksyr1vCEFihkr+lOJ7Fpjpz
 /ulUZiCk33Gs0sERWUsXL8pHTyywQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3rx2wn73f8-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jul 2023 07:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dp01BCUUENDH6JYWuSZSt7Eue2rN9h9qCvaAMQKww5FcuI6jIReQMcIHLO9UCf6CVn4lG9ARAuo28yW9C8StQ+tJArmz7Bs6pyKnCX9fzGXYNbKANzl+kXOOw7Xk7yw1vlnhQkpQqUxAJ4vZXb2WawCs5LnVIcXjaP6mxD4LZ1I5Ht1t4TepdhTgRe1KJqgcqy0DFGpTUZ5EsR3rDp+Kg/WQMifWxx1TbWAjO9LZw3wIcLzzJhksEkkCiR3k2s/LlfWrtAaRwk2Vi+ZbsmAqgw7vNbzWRSJ0tKPIBkY34B8n10fzu7dYdI2FJWMUh1yIPEp3LFuDuIxe3TYx3bJjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSqndeJjS5AH5gNpHzpeSwSHT4tT7TDFsVU9lRb8L14=;
 b=ABCxic/xxf6eFjTSVQvHK/T8YDxc/tw6JkJDXI3FnhqqczZiD/I7F4oC59gxfbPfxZ2YuluPnkk8Aa+BrAMlyV1ATQvZPRRV3qTcgmmHDrgWyHcetERddKsqdmA2xWBBRzNWPox6/wgkpmWJsYCrcGgDE7Sj9tqe4/Yk2pY4YLvFjuq1sYAoXVlT/ACMnMeQN68GiM0XZ7hTEuJUIwK00032QXxBXXuLd/PqjpLtszVY4wXNau9nv22KfOMsFjpuPkMDd+M9ihfWF9YtSfInGuJmomZAj2BMQh7xdlU9mnZVCu+hd9wq+u6cBHquCWWM93v0VSusuu5G2B/AkhaXEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSqndeJjS5AH5gNpHzpeSwSHT4tT7TDFsVU9lRb8L14=;
 b=AIE0si9OBlHviucsbw+5j+TohcAQ7t6QKqpaGUHJ1SFvLyXCnPf0+3OhmNuuk6XIm6V5Ys6+UIUHtgHGY/zCQ4T5j//AsgYRlzCRFk8MUZ2DkY6R/GOPuPJsPK12C9LYqOENm6+7wc09qFQ/T1EZoq8eWcREW+5EfeLIXg3Rlfz8vASp0jXZthEFUubkyBKnkLdR/m+o56bdLNzlPjn0JLg5uuyL/HxznW6dEoguMnBrou1EY4hZtzHKf2cp2vNmwoKKBfzJ0ieuNA+3WuPT2vMVazaUww/Wqmis20FkoCaHYWUbtA15hAZ3TzwSWMuOa8tKWxSR9Kp+ZcuBLNg2XQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by BL3PR02MB8020.namprd02.prod.outlook.com (2603:10b6:208:35b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.16; Fri, 21 Jul
 2023 14:49:37 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e%7]) with mapi id 15.20.6609.022; Fri, 21 Jul 2023
 14:49:37 +0000
From: Het Gala <het.gala@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Prerna Saxena <prerna.saxena@nutanix.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, Manish Mishra
 <manish.mishra@nutanix.com>, Aravind Retnakaran
 <aravind.retnakaran@nutanix.com>, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v9 10/10] migration: modify test_multifd_tcp_none() to use new
 QAPI syntax.
Thread-Topic: [PATCH v9 10/10] migration: modify test_multifd_tcp_none() to
 use new QAPI syntax.
Thread-Index: Adm74pIx2/PqSaZfq0yFFfjd+124IA==
Date: Fri, 21 Jul 2023 14:49:37 +0000
Message-ID: <20230721144914.170991-11-het.gala@nutanix.com>
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
x-ms-traffictypediagnostic: BYAPR02MB4343:EE_|BL3PR02MB8020:EE_
x-ms-office365-filtering-correlation-id: 3e03c69f-2ba8-40fd-02ae-08db89f9b4b0
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jU8XGSqK2RY96WejfZOaDWJM+Nd4P6pmf6Pt0Rj4M5jQJz0B78eOvoYWGsp6/rr5ee4iVsJD5NSFkdFqKgJv/GY4hGBrBrKTwjKAPDStVqYG396zAF1uHKmRuDxonrT80zvCxtfcWZgUwdZH2q2M0pIBK4EZ55sgc/bdYd800Jz6/3cIBlJ0ugo3e+D7Ub5Bk5Vqc4IBUx3JzLUPVAvzT0cpU7sDoCQrnB8SKpisIhFpK2zZ1PvZkbXy0pj/GqR+5TWl/6ecCesU39Z2LrprCNILi3nVclqLGq56ujYqU1C8Gb2T6WG9svBYwVCwUX32TyNYOhHcx/B3w8D4eL5fPeFcYlFelTPlprlfgcMtTxYPynfsH+NGMFZ2pQktGqkaMoFSASupjklLNhwcwf7T3SnjLjrNeFJO1Rp9Q67a38DzI/ATq+ZNjrE/I4tXmVPuW3ALbyXuAQEQ9+zcYkUcWLlsTnNTZIr9LXtgSMtIh7Dm6t6EZ+GdwwK7Z6IunYo1ZtZ/Qj4z9uUx8FJZPa8TwABLTRSXkv8mCQj/TKrjY3oFMe1WdF3EhzJT9+byzAX6S5yLW1VIEHqvTdUevvGM7AGmVHhhUpqAZVWDqZy/4QmN/AyvDCSGb+FJleDUm25x
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(6512007)(1076003)(122000001)(38350700002)(38100700002)(83380400001)(186003)(2616005)(6506007)(26005)(107886003)(44832011)(4744005)(2906002)(8676002)(8936002)(5660300002)(71200400001)(36756003)(6486002)(478600001)(316002)(52116002)(64756008)(66446008)(4326008)(6916009)(41300700001)(54906003)(66476007)(66556008)(86362001)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWJZUzk0NEJCTmlOYmM0RFYrQ21VeHFBNmY2WWN4UGMyZWxpenp5TW5qNlVR?=
 =?utf-8?B?cFVRREFyRXdVWnpKMlNjb0ZSUW1mVXNFOEVCMngyYVViejZzc3BGQkRQOVVo?=
 =?utf-8?B?dmNVMnQ0S01MTzBsY0pVVXBHYXFHMHVjelJycmFRSlhiN25SZ1ZZL3VFeVhC?=
 =?utf-8?B?TXNTUTRndDBSc1oxYVJzdllQa0lwTlkvcEI0bjlybC9EUnVwUlhlUkxLWlhJ?=
 =?utf-8?B?RDhEdXo5NUx0ZjFvSlZWS0FCRjdTNjh3Y2tJZ2g4REhtdFpadmg4bVVEYmJH?=
 =?utf-8?B?T2tnYjJmNU05RERQSnFCRmZ6eGRJemdCRU9tMUhDOGY0YU5oeWJaWTdnZjNU?=
 =?utf-8?B?amZDc1J3ekR3TkJxYVNIclJUWHhqRDNsSlM2S29zR09uRlFHczVFNFJ0QkY5?=
 =?utf-8?B?OHNFTlNvTHFaZW1JZzJpMm9mT3kvNkJjd1hITWJ5eXNSeVpCSUpiZlZkeTU3?=
 =?utf-8?B?ejlHS0poV1M0cDMvYVh4Z3FtS3g2RzVEZXYwNFZCWFZNTzl0YWxmVEs0YW9z?=
 =?utf-8?B?RlBPRkQyeFNHak9TbWtCdjgwR3QrSzU2WURyWlBXK0xNejlneGJUcitqYTcr?=
 =?utf-8?B?MFk2elV5L0FNUjJHZk9YYkZoOGJ3aHd5WXJKc2RtZUw1TjF6dmEyTTc4UXRF?=
 =?utf-8?B?OWk3VzJ1a1lrVXNYdmF0K3YvWjd1WDlRQktZWExQZ09GTXRuTXRUS1lRUVNQ?=
 =?utf-8?B?VFZHZWQ3aTFWLzNPNTNkVnJMY05OMnFkc01NZDM1TGczemh1K1hBdzBZQyt0?=
 =?utf-8?B?ekFLRmZ6NXpySytsTWQvcUdTazNoOExhOEdjM2FUVHByOGpVNXc3VVlYcnBh?=
 =?utf-8?B?SFNtVFFCWlBPaC9SL3NUODNDSHN3SXVoNGRNVkp5ZlBIZVcwQWZBTUpHZXp3?=
 =?utf-8?B?Vnc5ZW9wTFV0ZWx3cXd1NkFSTFU2ZDQ5YUU2djBwa1Z2VnFsMEJIVDlaU1lD?=
 =?utf-8?B?T09VbjBKTXh4NGRUOEw0TjJHR2c2eUVTRGZ1cU9sYWNZNUR6WWRzOHovTUg1?=
 =?utf-8?B?V09hSzUxc21hNGtId2NrazdyOUNOL2NoZVF3UW51a0UzWXhGSnBVcC9vd1o2?=
 =?utf-8?B?bUo4Y1R2NTVFa0xQeSt5QnZhUlFNNHNQK2h1UUJZNkZKTmtxMWExZHNTM05o?=
 =?utf-8?B?em9sWVIyK0F4SWVSM21ZUktoWVllS2h6Skl0Vm5ra3JTY0ZZWEFadGJrU3lK?=
 =?utf-8?B?eWwyWWV2M0tZSHFUNzlQamJhWlcza3pxUlJzOUF4emQ2b2cvQUpKUnRBUDU1?=
 =?utf-8?B?SndjNmNoNFFKTVZIUVZrQzBRbm9ncTZ2cE94NkdmYi94N1JRb1BzMjNuT003?=
 =?utf-8?B?UE93N2ZHVllaSWtKSDdDSldoNVhCOURnVzBNems4bXp0dnNSWldGMzk2b0lC?=
 =?utf-8?B?YUtuUTRTN2MrNGRDSlFST3BNczd5Rm5sWHFkU2ptWkIyUFRXQStvMHdtRXBl?=
 =?utf-8?B?bUNqdXNFQkliNVpwanFIanJXOUZDcUh1ZW1Vdkc3T2psOWdJcWlBZlFzSmhG?=
 =?utf-8?B?T2owY3hHN1ZqR3o3RlR0Vk9Fc3dJTndwY1hHems3ODc5bDV5TFAwYVlhVFBZ?=
 =?utf-8?B?aHc3UUdkeC93eHdqTGpzM3ErTzBtdytQL0ZYK2F6Y3JybjFnMXdmVW51aDZk?=
 =?utf-8?B?dDVDOGlUeldPTU1qeEhCVjUzVTNFUSswbnE2TiszWkI1eHluZmJKbW1YZ0hR?=
 =?utf-8?B?SWhPcmdWeFJSWWg1VzdjN01wZzZ4SkRnQWM3NzBhUUZnNVdrQ1R3MW9IME5N?=
 =?utf-8?B?V2ZZMVNUM2pJRUpHNVdnVGhTUmc1ek5JYjRwbWJxUEFIemdCZTNQbWFtZ2Zp?=
 =?utf-8?B?cGxYTFJudTdqZTU3U3VBaTRUVlNDRFlJUjQrdHJVZU5OK3Yxenk5RGtuU0Rl?=
 =?utf-8?B?d0JzQ1BqN3J4cyttVEtuQ0VXc0Q2MlhiZVU0RXFrWndaSmR4ZkxnZWRqTkg2?=
 =?utf-8?B?d1B5WHAyQjhLVkxEWVdUUGlUeENXWDhBTk1kUWpjZUtqenM5a0JXVW9kUXhX?=
 =?utf-8?B?bVdJM3lkWTl3dDIva0xiY1c5ckNXb1ZveDlKdHB3SWFXMWpOZWpNSGs5SnJZ?=
 =?utf-8?B?S2xmMTd0MVVMZXNQMklNWUxaVDhIaTN2TDA2bHVva0dyYjE1N3JPMEV3ZzZS?=
 =?utf-8?B?Zm5ZZG5VMlBhQ05Vd3FCbmplamZOSUlQS0Z1YitFVFQzL2Z2MmZ0WUw0eVJC?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e03c69f-2ba8-40fd-02ae-08db89f9b4b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 14:49:37.3967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sSVzHWtA2gUcj7LLna6WepWPLUD0+FM+OfQ8GOH5eJXZvJ2qNWjqVICRlDsriw4MlA44rRjoi+wJ908CAs9ydg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8020
X-Proofpoint-GUID: R1m6A6kpxuiVsoeiYzw_8EEjtCbhwhmF
X-Proofpoint-ORIG-GUID: R1m6A6kpxuiVsoeiYzw_8EEjtCbhwhmF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_09,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
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

bW9kaWZ5IG11bHRpZmQgdGNwIGNvbW1vbiB0ZXN0IHRvIGluY29ycG9yYXRlIHRoZSBuZXcgUUFQ
SQ0Kc3ludGF4IGRlZmluZWQuDQoNClN1Z2dlc3RlZC1ieTogQXJhdmluZCBSZXRuYWthcmFuIDxh
cmF2aW5kLnJldG5ha2FyYW5AbnV0YW5peC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBIZXQgR2FsYSA8
aGV0LmdhbGFAbnV0YW5peC5jb20+DQotLS0NCiB0ZXN0cy9xdGVzdC9taWdyYXRpb24tdGVzdC5j
IHwgNyArKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KDQpkaWZmIC0tZ2l0IGEvdGVzdHMvcXRlc3QvbWlncmF0aW9uLXRlc3QuYyBiL3Rlc3Rz
L3F0ZXN0L21pZ3JhdGlvbi10ZXN0LmMNCmluZGV4IGUyNTZkYTEyMTYuLjM3NmZhZDgzMTEgMTAw
NjQ0DQotLS0gYS90ZXN0cy9xdGVzdC9taWdyYXRpb24tdGVzdC5jDQorKysgYi90ZXN0cy9xdGVz
dC9taWdyYXRpb24tdGVzdC5jDQpAQCAtMjE4NSw3ICsyMTg1LDEyIEBAIHRlc3RfbWlncmF0ZV9w
cmVjb3B5X3RjcF9tdWx0aWZkX3N0YXJ0X2NvbW1vbihRVGVzdFN0YXRlICpmcm9tLA0KIA0KICAg
ICAvKiBTdGFydCBpbmNvbWluZyBtaWdyYXRpb24gZnJvbSB0aGUgMXN0IHNvY2tldCAqLw0KICAg
ICBxdGVzdF9xbXBfYXNzZXJ0X3N1Y2Nlc3ModG8sICJ7ICdleGVjdXRlJzogJ21pZ3JhdGUtaW5j
b21pbmcnLCINCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICIgICdhcmd1bWVudHMnOiB7
ICd1cmknOiAndGNwOjEyNy4wLjAuMTowJyB9fSIpOw0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIiAgJ2FyZ3VtZW50cyc6IHsgIg0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IiAgICAgICdjaGFubmVscyc6IFsgeyAnY2hhbm5lbHR5cGUnOiAnbWFpbicsIg0KKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIiAgICAgICdhZGRyJzogeyAndHJhbnNwb3J0JzogJ3NvY2tl
dCcsIg0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIiAgICAgICAgICAgICAgICAndHlw
ZSc6ICdpbmV0JywiDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiICAgICAgICAgICAg
ICAgICdob3N0JzogJzEyNy4wLjAuMScsIg0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IiAgICAgICAgICAgICAgICAncG9ydCc6ICcwJyB9IH0gXSB9IH0iKTsNCiANCiAgICAgcmV0dXJu
IE5VTEw7DQogfQ0KLS0gDQoyLjIyLjMNCg0K

