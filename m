Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4455B7E6D09
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 16:14:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r16jU-0002OM-Fn; Thu, 09 Nov 2023 10:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5677a8076b=leonid_komarianskyi@epam.com>)
 id 1r16jS-0002GF-Q3; Thu, 09 Nov 2023 10:14:10 -0500
Received: from mx0a-0039f301.pphosted.com ([148.163.133.242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5677a8076b=leonid_komarianskyi@epam.com>)
 id 1r16jQ-0007pS-N4; Thu, 09 Nov 2023 10:14:10 -0500
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
 by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A9E4NoM016893; Thu, 9 Nov 2023 15:14:03 GMT
Received: from eur01-he1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2051.outbound.protection.outlook.com [104.47.0.51])
 by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3u90v809hw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 15:14:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2OGq/AbIBB21kJ9Oq9Of44SiB8FYjNwDnZZ4zZaoGiVKDGjbiBh4a3Xo8Bd5Nz8MJuYUUOKU1ZCZJPi/tZ3qadH7MFQdFi8uI+PSFMVAmyuexpDR0LlyI5Lx0qqQD74KzmU9zKh8nTl5lA9ZBP72aXIFlIo6WAdg2Z3P4LP3M25dcEpZQF4kk8We5Hfqrq1hM1tse34euIKM+qiFguYw+PkG39z6qzHNMS/slADVIjSQPOLiylalH9FG4nvTCVKKNBGQf0It5YGhNgakgRDsKR4wpcIRLU5yxvGfsVqloNoFmBvUendIOWik7ub7AhKAoCu3orajeOxZEzyYwcuHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IW3F9zsXL5OHVAxnI/Q1RIxuSiXQ3EgFo1rKBfsRwsY=;
 b=B9udOlv/uP+pb4H2xAHmIM/gLEF1T3/AdL5/reu1oklsWxDVMdLn9Oe9QQ4OtsmLmFt/m0rFEdeQJK/jSk5h2JVASMP3j+pSNpkGat0vsY+p+NzGts++8sGvZr3IFwBIHZb6TmG9y/XV6OWxpWSe67DixDV27a5YlgmrvfB3zXfkRjX3ivU+oP7ZzwvVv08J4z4Hb68IVuT0cZvMppHQA0UjILGRPRoY6GK8u1EgxfrO+5HHlkVvZRrRq0P6dXz0zzKvcA37ZKa96XRjyIUiYmm1Wjwaz4uboaWuqcsLCgL/sORyFBcJsL40UPVw6/RkZtIGte5lp/Dq6c74FHgFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IW3F9zsXL5OHVAxnI/Q1RIxuSiXQ3EgFo1rKBfsRwsY=;
 b=ZSweSCFaUXn1GtGUJ6JUwNEncJUB1qyG9UatO3SuPvFp3hbOiC+Z+bnVyTm5764RHdOddWX7ra0KEpHL0Zpju+DB/0Mbdaj6X7SXGClOsem0xJxz2UUnqSj3pb7rQG/h+HJ6wePXm5Q0MlNFHJSg9QoxfGS2C8AjY5bGSeIKYvo+Z/wvY6VcBmZ70LKmupnmP1ruDrbEYcm9/QxFty3VbOZaPyu0uQy/NjehiNkzIXlvWwdg4kMW0KFZg1sfuN9nxQUetL2pJe54izrV2pihXQcJMtT+zJexQjL5sv1a2iI9KNB2ECLqzC9dsnfEtfN/sqhp+UF6kd9rE26LlN1diA==
Received: from AS4PR03MB8676.eurprd03.prod.outlook.com (2603:10a6:20b:58c::8)
 by PAWPR03MB8913.eurprd03.prod.outlook.com (2603:10a6:102:331::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 15:13:58 +0000
Received: from AS4PR03MB8676.eurprd03.prod.outlook.com
 ([fe80::3779:1a8d:a31f:95a3]) by AS4PR03MB8676.eurprd03.prod.outlook.com
 ([fe80::3779:1a8d:a31f:95a3%2]) with mapi id 15.20.6954.027; Thu, 9 Nov 2023
 15:13:58 +0000
From: Leonid Komarianskyi <Leonid_Komarianskyi@epam.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 Dmytro Firsov <Dmytro_Firsov@epam.com>
Subject: Re: [PATCH v2] target/arm: Add overflow check for gt_recalc_timer
Thread-Topic: [PATCH v2] target/arm: Add overflow check for gt_recalc_timer
Thread-Index: AQHaExRfPMvujsWDHkC+f/nKYA3iT7ByGI+A
Date: Thu, 9 Nov 2023 15:13:58 +0000
Message-ID: <baafd137-58de-42e9-9f06-c7f7789d4b77@epam.com>
References: <CAFEAcA_koyJSR_7kF6TByA_rm2nJQr-8UnXrtu3JqwgpqUEctw@mail.gmail.com>
 <20231109135439.1297135-1-leonid_komarianskyi@epam.com>
In-Reply-To: <20231109135439.1297135-1-leonid_komarianskyi@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR03MB8676:EE_|PAWPR03MB8913:EE_
x-ms-office365-filtering-correlation-id: 87e89705-e973-45e4-fd6f-08dbe1367f5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wwPrkdWBw2lTeXRh+40nMj8ddvrdVe5tNasAbBWgYIb8CF9B1A6Ot0AeknQoMTGb1ZvRLqE5x4e1sBnjCL+mCJ3BoS2dJTxNSkfEE7i/x+W1OhS/tsuN3aCo9Uw1VSoqBl5XdLLWYjA9s5hxE4KlRZb4mRkinGeMnOr3HTL5P4daoSpC6MiBzsO1YNd9sRGiDetOlwuERM9AlGlwS9UmBsl1rwGq0b0T1+wN+K4XIgqX9iGSa7coniw7KU18WyUTls9dKamKszmwEqcqebMHyZY8+irpjn7F1CuFwse9Cgf+2+oyjGj2xNNxHGs+IZRSS/x9hl4eqay1Ev7aPZog0qEX1zILSv+dlMGUgmDfMrp+0KPwHlDRj59cr7ItBLOgXRVNUk4kSFCMLnQLXlpfpB1MkVfqpSdMmybEF1POUYk6DEOr/6IpDYsyc/nMrzs1Rl6t3ncQBBpkPIV2jkyR8p1QeDHzmKeH0LxpWzF9+yBRnKkU6QJWJVeJ1TGuHcR58jwj1lgigNXJRum8xEhQoKiigfEovNg48MWAPTql7/E5RYd3YeJqB13NghHjBuvYrSpoO+UTeobHakkAklsxdgGtu7FJ93oDwo+CQcg66ehc9jDCLNOcehrwuDRMTKkwPy0mJaFvkb27mtz4XR8hiw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR03MB8676.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(136003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(4326008)(41300700001)(83380400001)(6916009)(66446008)(66946007)(71200400001)(53546011)(6506007)(54906003)(478600001)(64756008)(6486002)(6512007)(26005)(76116006)(91956017)(316002)(107886003)(2616005)(66476007)(66556008)(5660300002)(2906002)(8936002)(122000001)(8676002)(36756003)(31696002)(86362001)(38070700009)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkFTY3VKbkN6NDRmZnhmdWdWbmNta0Z4RDRwUFhTQ3h2cVdaVlVqWjdOZGIx?=
 =?utf-8?B?M2c0ZWwzM2ZqQXpBU2x3cFRLZVE4TjJkS2FqRTZOVDI2MzY1M0tuZ3paQ091?=
 =?utf-8?B?Y1lYMEV4YnBOV0l0ZytGcTZaYmVtckU1d2NUYnJESGFNQmMreGprd21xTU1x?=
 =?utf-8?B?Lzh5UDhNRVRVMERycnZwOGlzcU01d1pWNy90R1lnbFY3NkNtdWVDeHhMWEFR?=
 =?utf-8?B?RUVzUnNSVmJGK1l5ay82Mjl3ckVlMXpadGJJNHY2d2tsbTcwajZweWtDZGhS?=
 =?utf-8?B?Q1plRFNrM1oyaVJDWUdFalV4SmtLdEVoVlBvRDJMZE9QUjBQeHVaNEZtTHNj?=
 =?utf-8?B?ZVczTU9MOUNCVTQvelFMUXFCRFhxTFI2RFNOenZ2TnkySHc0MlNySzFyZDAv?=
 =?utf-8?B?ZWpZMUxxKzdaY2tSckFMOXUzUDBXTHNxNTVwMzNuNTIrajJmYXJHM2g4TnFi?=
 =?utf-8?B?amJwVEY1ejZKYTFJU0FVU21laEQySzhhVUh2eHA0dnpDSG9RUTBkL00vWFJS?=
 =?utf-8?B?YTliOFIxY2pDY0w4M2YzVkxUUXNZdjJZaXFHS1dQWEVEdDFXVytiWXJ0UzAr?=
 =?utf-8?B?bm9reW9rK0o3aXFzdHJLOTVsbjNFamxBMEVxOHFId3l3QTZObWFBbXZsends?=
 =?utf-8?B?RVJhKzJOdEx3RWN5cTNwaGV1ZnJYbjYrMmpVd2xKMXhhaWJXZmlIWisxWlRR?=
 =?utf-8?B?YStOZVo3U3pkbDBSeEFhMWxaeE1kRFlXdzRLM2lDajJlZEltOWYvWlhLMDJS?=
 =?utf-8?B?L1B2eE56YzRqYmVoUElnZFAyVWg1TnZxU1NMc2dvNjhQai9xbjBBcG1PMVRu?=
 =?utf-8?B?UDA0UnhmbDdrK1lKYUFTbmdOM2tnMHZVWlhQNUVFM2gvMkNTNElpdHZVanBP?=
 =?utf-8?B?cUdlR2hSZmQ0UnU4UVNEdjQ0U1JBcmxxazlBbEZzZHpPMlhzYlcySCsrd2kx?=
 =?utf-8?B?Rlc2S3daRzdhQU5Tci9ydDlPL2FQMVRDbHpac1hidjkvMm8wQTQ3RzRxSTIz?=
 =?utf-8?B?cVIrbU1vOXNJT0VkOE9GOVRrQTEzRXZ5U3ArdTB2dHpzUklWSkhWZG9tVEgv?=
 =?utf-8?B?WE1ib2NZazkxS0ROYkJydDdudW14elRjb3RUVW40dWVXRDhwYWJuMGFLNEVk?=
 =?utf-8?B?dlo2Q2Yya1R0V3B5VU5VZXRlbUxWVGR4S2J5ZjF0VkRYdGpHOGlrSFY1TDRS?=
 =?utf-8?B?MUk5WmxUWnFWRXNEMmt3Q3AzaUZMVVh2cTNmdjFmUzdhWVYwRFhLdXlsbGQ3?=
 =?utf-8?B?a3pOR0dIV2tBek1XMUtFZnNncHBiN2xveExuZVJoWjJ2VWQrQmpDMzZmVHhH?=
 =?utf-8?B?YmhGSTBsQWYrbGJteUlrcXlWN1pVVE13Tm9sVGVDeGNza2ljNEN1OU9rMU84?=
 =?utf-8?B?L3NGTzZYckVJRm1jcmxTSFY3L0FibUVnREN5S3A2ZUlwUG1lcFZrZ1pxd0Vj?=
 =?utf-8?B?QVY1d3c4RVpkWmRLeEVvS0tYYVpxc1NGM25VWEJ2L2pUYWMwNzIzaW9uSVd6?=
 =?utf-8?B?WXBjaWJ1WGM0eDY0ZlpDNlFnU243YldPNngweCtXZHJjRy8rTVZHeWNmUHVN?=
 =?utf-8?B?amNFbzNQYklmVzJFVGZudGttTUdGTTFPbVF4SGY5dExsVVpXdDZPQUM1WThw?=
 =?utf-8?B?NW1tdm1yb25tMXl3djlPMi93cmtFMkpOR3FySG1iazZUbzZLQ09kZDVZYXU0?=
 =?utf-8?B?S0F3UW5oQldLUnVSZTNjQ3JNU2dGTGhiRWtwQzVXM3dIUURKanhVUmlBYVcw?=
 =?utf-8?B?eTVhWmtHV3FvVUNTa2RIOXMxZzRwZm43M3FmLzVYUG9UVW4rR296dTZqUDRp?=
 =?utf-8?B?b202L2VkZk1vWHcxeGNrZkRkWVVsZVM2Tkw3UXZ6Ync2bHZBcjN3VUFhTWty?=
 =?utf-8?B?aE9nenRpalNKUk1SNFdueDRsRTRNejBGOW1ZT0FsaGEzdEVnSGNkenFETExO?=
 =?utf-8?B?dWxwM0RGc1RSY0VBZDBVeFRFOEJ2M2lZMDYraVl6cEoyRGFid2NOeUxlNkt1?=
 =?utf-8?B?WHltU1pyejg2QllDN0NaTW8vQ2xweUkxS0NTVjFQRVNqSTgwQjVqWWVCNWVo?=
 =?utf-8?B?cVNJUEJvRWk2N2hnWEViYUdXVEREWkorajdFTDRqdkx5TmNqZWlZV2greFR5?=
 =?utf-8?B?VzVZanppODRUY2c4bW1HNXdNUldNU0t4dEorczlWWTVTMDNHYkxBamcvajJK?=
 =?utf-8?Q?5TfxGetooVtwep+eMfE/+6Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45FEFB30DBBE7341B216CFB52878F7B2@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR03MB8676.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e89705-e973-45e4-fd6f-08dbe1367f5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 15:13:58.4390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQPdHlaAOffodff5Ti0LhOd+RXRnzhI6NTbgknZ6PvyuQ1kWKXVdyUSWtmjBPkkom8l0J8jQqCVp8VGjMVEYMYPiMnNBaPJcNxnfbGbXyYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB8913
X-Proofpoint-ORIG-GUID: GShtAWAXLUTBM5Rd4haQ4kPNT7vGnmGP
X-Proofpoint-GUID: GShtAWAXLUTBM5Rd4haQ4kPNT7vGnmGP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_11,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090114
Received-SPF: pass client-ip=148.163.133.242;
 envelope-from=prvs=5677a8076b=leonid_komarianskyi@epam.com;
 helo=mx0a-0039f301.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

UGV0ZXIgTWF5ZGVsbCwgdGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzLg0KSSBhcG9sb2dpemUg
Zm9yIHNvIGxhdGUgcmVzcG9uc2UgLSByZXR1cm5lZCB0byB0aGlzIGlzc3VlIGFuZCBub3cgSSB3
aWxsIA0KYW5zd2VyIGZhc3Rlci4gSSBmaXhlZCB0aGUgY29tbWl0IGFjY29yZGluZyB0byB5b3Vy
IHJlY29tbWVuZGF0aW9ucywgDQpwbGVhc2UgdGFrZSBhIGxvb2sgYXQgdGhlIG5ldyB2ZXJzaW9u
Lg0KDQogPiBUaGVyZSBpcyBhbHNvIGEgY29tbWVudCBvciB0d28gZnJvbSBtZSBpbiB0aGUgYnVn
IHJlcG9ydCBwb2ludGluZw0KID4gb3V0IHRoYXQgdGhlIGhhbmRsaW5nIG9mIHdyYXBhcm91bmQg
aXMgYWxzbyB3cm9uZyBpbiB0aGUgb3RoZXINCiA+IGhhbGYgb2YgdGhpcyBpZigpOyB3ZSBzaG91
bGQgbG9vayBhdCB0aGF0IHRvby4NCg0KSSByZWFkIHRoaXMgdG9waWMgYW5kIGFzIEkgdW5kZXJz
dGFuZCBjaGFuZ2luZyB0aGUgb3RoZXIgaGFsZiBvZiAiaWYiIGlzIA0Kbm90IHJlbGF0ZWQgdG8g
dGhlIHJlcG9ydGVkIGlzc3VlLiBTaW5jZSBpdCBhZmZlY3RzIHJ1bm5pbmcgdmlydHVhbGl6ZWQg
DQpzZXR1cHMgb24gYXJtNjQgUUVNVSwgZS5nLiBaZXBoeXIgDQooaHR0cHM6Ly9naXRodWIuY29t
L3plcGh5cnByb2plY3QtcnRvcy96ZXBoeXIvYmxvYi9tYWluLy9ib2FyZHMvYXJtNjQveGVudm0v
ZG9jL2luZGV4LnJzdCkgDQptYXliZSBpcyBpdCB3b3J0aCBtZXJnaW5nIGF0IGxlYXN0IHRoaXMg
Y2hhbmdlPw0KDQpCZXN0IHJlZ2FyZHMsDQpMZW9uaWQgS29tYXJpYW5za3lpLg0KDQpPbiAwOS4x
MS4yMyAxNTo1NSwgTGVvbmlkIEtvbWFyaWFuc2t5aSB3cm90ZToNCj4gSWYgZ3RfdGltZXIgaXMg
ZW5hYmxlZCBiZWZvcmUgY3ZhbCBpbml0aWFsaXphdGlvbiBvbiBhIHZpcnR1YWxpemVkDQo+IHNl
dHVwIG9uIFFFTVUsIGN2YWwgZXF1YWxzIChVSU5UNjRfTUFYIC0gMSkuIEFkZGluZyBhbiBvZmZz
ZXQgdmFsdWUNCj4gdG8gdGhpcyBjYXVzZXMgYW4gb3ZlcmZsb3cgdGhhdCBzZXRzIHRpbWVyIGlu
dG8gdGhlIHBhc3QsIHdoaWNoIGxlYWRzDQo+IHRvIGluZmluaXRlIGxvb3AsIGJlY2F1c2UgdGhp
cyB0aW1lciBmaXJlcyBpbW1lZGlhdGVseSBhbmQgY2FsbHMNCj4gZ3RfcmVjYWxjX3RpbWVyKCkg
b25jZSBtb3JlLCB3aGljaCBpbiB0dXJuIHNldHMgdGhlIHRpbWVyIGludG8gdGhlDQo+IHBhc3Qg
YWdhaW4gYW5kIGFzIGEgcmVzdWx0LCBRRU1VIGhhbmdzLiBUaGlzIHBhdGNoIGFkZHMgY2hlY2sg
Zm9yDQo+IG92ZXJmbG93aW5nIG9mIHRoZSBuZXh0dGljayB2YXJpYWJsZS4NCj4NCj4gU3VnZ2Vz
dGVkLWJ5OiBWb2xvZHlteXIgQmFiY2h1ayA8dm9sb2R5bXlyX2JhYmNodWtAZXBhbS5jb20+DQo+
IENvLUF1dGhvcmVkLUJ5OiBEbXl0cm8gRmlyc292IDxkbXl0cm9fZmlyc292QGVwYW0uY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBMZW9uaWQgS29tYXJpYW5za3lpIDxsZW9uaWRfa29tYXJpYW5za3lp
QGVwYW0uY29tPg0KPiAtLS0NCj4gICB0YXJnZXQvYXJtL2hlbHBlci5jIHwgMTAgKysrKysrKysr
Kw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQg
YS90YXJnZXQvYXJtL2hlbHBlci5jIGIvdGFyZ2V0L2FybS9oZWxwZXIuYw0KPiBpbmRleCAzYjIy
NTk2ZWFiLi5iNGFhYTI5NjViIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvYXJtL2hlbHBlci5jDQo+
ICsrKyBiL3RhcmdldC9hcm0vaGVscGVyLmMNCj4gQEAgLTI2NjUsNiArMjY2NSwxNiBAQCBzdGF0
aWMgdm9pZCBndF9yZWNhbGNfdGltZXIoQVJNQ1BVICpjcHUsIGludCB0aW1lcmlkeCkNCj4gICAg
ICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAgICAgLyogTmV4dCB0cmFuc2l0aW9uIGlzIHdo
ZW4gd2UgaGl0IGN2YWwgKi8NCj4gICAgICAgICAgICAgICBuZXh0dGljayA9IGd0LT5jdmFsICsg
b2Zmc2V0Ow0KPiArICAgICAgICAgICAgaWYgKG5leHR0aWNrIDwgZ3QtPmN2YWwpIHsNCj4gKyAg
ICAgICAgICAgICAgICAvKg0KPiArICAgICAgICAgICAgICAgICAqIElmIGd0LT5jdmFsIHZhbHVl
IGlzIGNsb3NlIHRvIFVJTlQ2NF9NQVggdGhlbiBhZGRpbmcNCj4gKyAgICAgICAgICAgICAgICAg
KiB0byBpdCBvZmZzZXQgY2FuIGxlYWQgdG8gb3ZlcmZsb3cgb2YgbmV4dHRpY2sgdmFyaWFibGUu
DQo+ICsgICAgICAgICAgICAgICAgICogU28sIHRoaXMgY2hlY2sgdGVzdHMgdGhhdCBhcmd1bWVu
dHMgc3VtIGlzIGxlc3MgdGhhbiBhbnkNCj4gKyAgICAgICAgICAgICAgICAgKiBhZGRlbmQsIGFu
ZCBpbiBjYXNlIGl0IGlzIG92ZXJmbG93ZWQgd2UgaGF2ZSB0byBtb2QgdGltZXINCj4gKyAgICAg
ICAgICAgICAgICAgKiB0byBJTlQ2NF9NQVguDQo+ICsgICAgICAgICAgICAgICAgICovDQo+ICsg
ICAgICAgICAgICAgICAgbmV4dHRpY2sgPSBVSU5UNjRfTUFYOw0KPiArICAgICAgICAgICAgfQ0K
PiAgICAgICAgICAgfQ0KPiAgICAgICAgICAgLyoNCj4gICAgICAgICAgICAqIE5vdGUgdGhhdCB0
aGUgZGVzaXJlZCBuZXh0IGV4cGlyeSB0aW1lIG1pZ2h0IGJlIGJleW9uZCB0aGU=

