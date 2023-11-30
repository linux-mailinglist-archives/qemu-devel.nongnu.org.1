Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC707FFB70
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 20:35:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8mnO-00080R-JR; Thu, 30 Nov 2023 14:33:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1r8mnB-0007zr-Dp
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 14:33:46 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1r8mn1-0004qu-IJ
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 14:33:40 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AUFqjmu017090; Thu, 30 Nov 2023 19:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=WwXABhYy+gktMQSLq6io25EFHv3/M0IoncU57+wmHis=;
 b=XvKRzEjlqsMpGeeY0Vc3D3EB54EeK2AoT4gDttSSJNg451BJtKP24vRjfC5bgXPO2v/o
 325kZZ6BJG+EPeyf1iJuhpNySw6Fb3ZlY9JAzaFPKd/+uZXpl7xmiSQNZ8G+oR0mVtJM
 Pbd/mayJ2Vm0fmgfBKOK2LycLcL64yVBKsW7MKZiWP9h7Cz/desgwqz2FabQh/DuJQvQ
 PVQ3CoA2b1QzyWyqWFfTCBOSoIo8cJn7AT7q3wykSOE7ASfGARimOt0Wwn0lOgN1d6AS
 U+7E4/wUAa45wSFDfyie35aOKOUiWyfBilWSr1u6NH5hJ5ithHseSHPPQEE7xXyTqH5f VQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uprhdseg8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Nov 2023 19:33:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Brdp6eKwyCN0RgbZJ/lOQBJzcbz9o89dcq4jr6+yOluvKhwuNEuvbbIcdaEL22aOfnwLJWaoms6kybqzdEmkCmMO2H1TtLIn/ycqYB6gHpCwtD1nFDKtrSVnT+xqzXdWs7YT2lTtHzjSA2L67S85is1D8h5FrGtCumDnzYxs4SDwEcvy+3ZFlp9sE9qXg2Zn5IHXeCnT+P7pGkkXyx9gjh2eLWIf2Lq3AvIK7C9LL5Rh5LUW8/S3aOaCyBZObFKshJ/b2Bep/Lm2HRF3A/0uZ+OLip5EE0rGlJZ5cim6u0F2mNjis1Ts4w39W2enEv0DwVBLM19c7wXCJF6z0Ao4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwXABhYy+gktMQSLq6io25EFHv3/M0IoncU57+wmHis=;
 b=M8RS8Ty1GbLQ6kNdRaoaSMcMCjgRfAhjmUayQURsbcYrJSThQtDmy+Llv/i/OhZFmXhIPkTt8HYhYgyXDnrl7paRjePCFlBBU7qhnXtFv803v/CSA63T4xsPMsSTIytNxZE7g49aforsvo2hOHhBNGL1QQAYops8UZwB4VVfOVj4OkM6V5iRxJjuDjRx89rFtPUlD4IOn52NOidbLsGPq8Ej/5iIx7drVoAgG3TQq2Fz0Vw+RpdBY+hjZqTmz6np2sYfyzdkOl756YYJdFb9wMdn3QQE4tBbUl/rwyIY4TMlAk7jtBqJpcn59xEtIzGJqoYmSnfDcRib8yJzjLoOEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by PH0PR02MB8565.namprd02.prod.outlook.com (2603:10b6:510:100::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 19:33:25 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c%6]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 19:33:25 +0000
From: Brian Cain <bcain@quicinc.com>
To: Taylor Simpson <ltaylorsimpson@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, Sid Manning
 <sidneym@quicinc.com>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: RE: [PATCH] Hexagon (target/hexagon) Fix shadow variable when
 idef-parser is off
Thread-Topic: [PATCH] Hexagon (target/hexagon) Fix shadow variable when
 idef-parser is off
Thread-Index: AQHaI7yhMiQWAo4Zs0aWvFDA7cRChrCTQHwA
Date: Thu, 30 Nov 2023 19:33:25 +0000
Message-ID: <SN6PR02MB420537DFCB1AB2C87AD332D9B882A@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20231130183955.54314-1-ltaylorsimpson@gmail.com>
In-Reply-To: <20231130183955.54314-1-ltaylorsimpson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|PH0PR02MB8565:EE_
x-ms-office365-filtering-correlation-id: 42b53388-c4d6-44a7-76d5-08dbf1db38db
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IfdhNXc0ZgJcquODiHb7qBySWxs3c5h/p5+qEdx+M+ZOg2WAiLs4jSnuXRVPhklMSn6SuHV79kn6xoU4FQ0If4dRVEq/FPgmBXqd7kGFQ8MWxCzyAplhDGt5LyJx+afXsTxKV6tD1NmYd+lQOa25NXtKIbkvwocwGTzJ8WFAda5meTtC0xCIOaniKku5O2bAkwJWPT6uy6hLQXk9mX2uRgpU5b/uPHWzQ7q3KWAxxWbzQMwfDLkjlDGWC1bSBsZ7eudOErWZsZTiQCrDjLbEl5C07HuBYpu2fNgylQfNKAXTnwmYTi7RRZJL21YPgfkOsBrYpjtP33ZUp2eQ4XhTZ/r4UWkxt3veHyucdU4WwJ8qcrIpaI7TOApL2aQjxXyxs/8Qel2uLq/x7MclH1ZG9B608cRIqXlWPB2lNJMEkasXFfNPhp+JbEX6YWMuoPJPNhS6bnRA+vW4vFajcF/MHhXkFyuoDMIy0rNdghM7sY6GsxDtfE5BXfJDfZlnV/Y59H7Sb4Guzd2Zfj4Y6qsZZ+qJ4wQEgl2pQtMm/eoyegXx58lPGlRRLSeijngmF0Iw6U0jQZCuUvdweoyAKhkIEJ+/kHOmJFeKN5Rvc2m7sQTFSe44iWNSDeYohzE2ABMPQWQ4JZiNj2yr4XBD9cvcQoBTs4/14QHliw4KKFKHi2s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(230273577357003)(230922051799003)(230173577357003)(64100799003)(451199024)(1800799012)(186009)(7696005)(55016003)(33656002)(83380400001)(38100700002)(41300700001)(38070700009)(53546011)(9686003)(122000001)(71200400001)(5660300002)(2906002)(54906003)(316002)(52536014)(66446008)(6506007)(66476007)(64756008)(110136005)(76116006)(66946007)(66556008)(478600001)(8676002)(86362001)(8936002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHZKVDd6UDBUa0JMN0hhQW5UU3JFTXpDVk85WVREellPSWN2TnJoQmlMejZa?=
 =?utf-8?B?K3V1NHU4NWNaTnhFUzNhcFNWbG5lY2ZrZFFDTTVYd0tSamplVGhLUy9JUU9m?=
 =?utf-8?B?QVNVcXZlNTlGTGhkVHV0bzkyMzFoM1NlYWIwMjVzNG82TUxOSnJBc3dwdVRy?=
 =?utf-8?B?VnZMa2ZVZmpJck9oMVprTDNZN3lnTW5ZT3ZUYnNiejdKMkdvUDhndHlqbFB1?=
 =?utf-8?B?WXFsOHZ3eVVpeVBLa3pkdGlvNkppY0w5d3JSd1NZaEZPU2Nyc2QwQ3g2YzRK?=
 =?utf-8?B?Tm1sY3h5VWtrMXkrT3JvKy9NenJQdDRuSEJwdkYxN0xSMEhONDI3elh6RFBk?=
 =?utf-8?B?b0JKZjdZT0ltK2drWkJiSGQxZTlsbWZ1QmdXQzd2ditzWFo0eFdIdmRLNmJO?=
 =?utf-8?B?eXBWMzBmT0hLY3VaaDdjeENQN2pzTTV1aCtlc0dMNGVxaW1qQmRBMUxLQVJu?=
 =?utf-8?B?UUtVWFVoZkFMK0lIU1JZZWEzOVM5UmltVk5HU1c2bzkxdEZqVmgweFBDT24v?=
 =?utf-8?B?OTNjcDNjcXZhRUJVTDdlR2xkbld4amJDWk4wdk5pcFFTbWpoMllUai9IMjNI?=
 =?utf-8?B?VWRESUoxK2ZyQm9VbjFYZm5DQldkNk8rdDNqaGtXSW5iUGJGc3NqdWI0ZFd0?=
 =?utf-8?B?Um5FeVhBNmE2dWFvSEw5VzVlN05rL0YrRlo1NURBZE13YUIyR0VUR0xmTHhD?=
 =?utf-8?B?Y2tNc3lDU1BldDhORXBralBudENKMEJleC96ckZhK3RnTlpRRG5kVlJsNFhm?=
 =?utf-8?B?WUd0QXVDKzQ1Wnh0QVg5bk9JdnFwWEFvaWpGa3dZemg3R0JIcXNQcDM4ZkNa?=
 =?utf-8?B?Wjd3MzZHZzVyVEtuTXF2SHAxNDF4dUdwbjA1SXZmampKd1hFYk92TzNCNS9Z?=
 =?utf-8?B?b3FHVGx4bnpIbkRZQXM0WlBGWHhSSjdpRDVkSm1BalBxRm95c1k2TVZJeXBH?=
 =?utf-8?B?RlJHV0hsUjZBSUM1QlV3aExZOWllZ0FyMHREOVprK0FnbmJrZUpkZjIvTWxw?=
 =?utf-8?B?TW9oQ1FDM0VXZGRjdjhWMzJUclcyZDVMd0FwK2xsZEQ2UzRBeFFsckliOWZW?=
 =?utf-8?B?T0xydk1oMUh3eGZ1WGxWLzhqUUE1amNUSXpISGloaXZVbjZuQUw3WVhjU3hF?=
 =?utf-8?B?NThRSkdTallHNFRVTHlCaTh3QlRlU2h5RzFtc1ZlUkJudVZ5MnQ2YnFxNmdG?=
 =?utf-8?B?S29yWlh3QVpKemVRMmh4SVFCM3VSaU8yMTc5SkdGK1NBcmRCaTRrRUdZRy9y?=
 =?utf-8?B?Y3V1SFJrczhPNXZrT00yZ09nMC80STNxS1pCNXVUa3FybHRaSXk0VTFhYmVx?=
 =?utf-8?B?Mm5iYk55S2lVcHRFcFJoQmQ4eGd4K1F0NGg0ZlUwM3hoVTdURVVVaWdZOVRl?=
 =?utf-8?B?QStUb2NiM3Bybno0VmQ4Z01PQm9jNHppb0pwbG1ycENma1pUSFVOM2NCZkEy?=
 =?utf-8?B?NWE1eE01Q1RqbFlOQVNPNDFYNzNsMFJ2dWljaGVhUDZRYmRjSFcrcTg4cndq?=
 =?utf-8?B?UkowQ1c0a0dkSjBLbjZUTGFXdDI3MVczYWlpeFprV3llWVZPMUZjQlBXaUhB?=
 =?utf-8?B?ODArUzd1SWdZMzc4bjM1T1BSRVFqaXpGZU1vL1NpbVhuQVdzTUFkU2tIc0FT?=
 =?utf-8?B?ZzBRZFZyR2hIN3Jobk1EVHdPS0VQT3c0aWdtU3hSQmNIMGxhQWJiN0Z4aVdI?=
 =?utf-8?B?Z20zcnZEcm5KQzE3ZWRoeWV6R0s1L2hUMVFxb0lTYU8zMDJ2bXNJM0dQbDg4?=
 =?utf-8?B?aXFMeGhEc3BMY0VwclhZOVhIUkZ6U2ZERnVuRzFrc0xSMnRrNFJ4M0dMN0wx?=
 =?utf-8?B?UzJkM25CaFptZjBya2VIZDUzenFTdEk0R1hvMC9KcmJ3QlM0eUd3Q1VlcUY0?=
 =?utf-8?B?NUFxZ3B6d3RzU1lBc3Z6WkVDck5hbVNFaDI2bDdIMitPQXJEREtNLzhHc1d3?=
 =?utf-8?B?amg5d013dHpHTkc5Y2hkakJRNTQxalo1VjFMcWY3Z3V1WmdiQ3JKQWlTd2ZI?=
 =?utf-8?B?Y21tODAvaFlOSFRuMWhhRjF5QVY1b3pqS3hQUFJtQVdqa2dDVFJCY0xQbzVP?=
 =?utf-8?B?L1Zkd1FLRVVvOHlnbHRNY2h6Qk4xYnNxeGRBVC9DN0k5SlhvOGFhWTJUa0I5?=
 =?utf-8?B?U1ZGNGduNlNDUDNMOGxZTUtKYy9Yc2hXcEMwTlpPdjBoUW9ncUw3WUM3bHFH?=
 =?utf-8?Q?o/KzgAIfenG9nMlCInm6u2g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /X4xa0qZ1TpwMQ1zim0McYYWAF12SMk8AfO/bJEiREPMe8dzhagioVAhRFM1uDlZO83506O6Oftt55Os0PIYP23LuB7OeXMyQcZ2tpawN/M/7J+OaKX/JGPHpyXh0NHvR//9iv6+eXc48Q6rYmmLGAFfAqnRsOyH3C3ERTcvKZsZZepFkneptVaVFOdNUs2mfHdaguGpV1RCXOkQD5dNkPcJ0FqtUBWAnhYPrjkTxbsjLlaqQivXjpbDJFFBGk802PCmstAA8RY0H8OsRMiwKRYauV/Xs2d6gYaVuawQUAH/L3Ci8TiYRb4na9oddtJ83/0izJN0mDWUme91BFYaCxAVMH8iUtOLR7eRX2xkpoz50vCDK2S+GXcISycXrn7Gex0sHiGXf4xninQS2shq4G0v8liydBa1mublTU//6TXQwxLZvIQarP2yBxa/sEuF6/IV6WvPswGmt4kPFKLeeKyXqFiMP/4Sqc04fHTQpEb1tTlP8HC8kPjRqU9nlvXpxTEeOE9XPO+g6RZQm3rGZatxlzuXPucFngt9vWNPOZUhZ8MpKF1igXZTx7LJmS3/Ziwwgpjsp7593KCgSP95kYo0g65j6q6y9Zn8EVaRpEAhzkMZ4f+3bcVEsAWZF7arxj8CG1wWiCTk5Q4v8zRMHOv4o50bgDBsQ5/DBr42PogurngBczGTELeuqPO1OaMNsGc5IeyEui5po50s48HTB7TYNG1hRMgv1UNwI+1z2Ep7cIVm4W2FoIW9XzUvBtYnw3bMw4I+TlhZmcWorXsagPkNIhk5qNyWmyiRo7CJS4PVpuM/9aZ2UKM7S+5ZILkRcG9mJ8pFk0SGWoqvz4bIxg==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b53388-c4d6-44a7-76d5-08dbf1db38db
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 19:33:25.6629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yg086h/b6Wvu/4TihQavsHLvNs7Vbgka3qyPYhzT+Cu2XZWU4MAon8okGrXVE4zfb34Lom1GM0+45guH4cHQhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8565
X-Proofpoint-ORIG-GUID: dYDEqBIwkpCV7FvEJr5mfhX7u9fUVNyt
X-Proofpoint-GUID: dYDEqBIwkpCV7FvEJr5mfhX7u9fUVNyt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_19,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=717
 clxscore=1015 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300143
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUYXlsb3IgU2ltcHNvbiA8bHRh
eWxvcnNpbXBzb25AZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMzAsIDIw
MjMgMTI6NDAgUE0NCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogQnJpYW4gQ2Fp
biA8YmNhaW5AcXVpY2luYy5jb20+OyBNYXRoZXVzIEJlcm5hcmRpbm8gKFFVSUMpDQo+IDxxdWlj
X21hdGhiZXJuQHF1aWNpbmMuY29tPjsgU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+
OyBNYXJjbw0KPiBMaWViZWwgKFFVSUMpIDxxdWljX21saWViZWxAcXVpY2luYy5jb20+OyByaWNo
YXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOw0KPiBwaGlsbWRAbGluYXJvLm9yZzsgYWxlQHJldi5u
ZzsgYW5qb0ByZXYubmc7IGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBbUEFU
Q0hdIEhleGFnb24gKHRhcmdldC9oZXhhZ29uKSBGaXggc2hhZG93IHZhcmlhYmxlIHdoZW4gaWRl
Zi0NCj4gcGFyc2VyIGlzIG9mZg0KPiANCj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVk
IGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkgb2YNCj4gYW55IGxpbmtz
IG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBBZGRpbmcg
LVdlcnJvcj1zaGFkb3c9Y29tcGF0aWJsZS1sb2NhbCBjYXVzZXMgSGV4YWdvbiBub3QgdG8gYnVp
bGQNCj4gd2hlbiBpZGVmLXBhcnNlciBpcyBvZmYuICBUaGUgImxhYmVsIiB2YXJpYWJsZSBpbiBD
SEVDS19OT1NIVUZfUFJFRA0KPiBzaGFkb3dzIGEgdmFyaWFibGUgaW4gdGhlIHN1cnJvdW5kaW5n
IGNvZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBz
b25AZ21haWwuY29tPg0KPiAtLS0NCj4gIHRhcmdldC9oZXhhZ29uL21hY3Jvcy5oIHwgNiArKyst
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmggYi90YXJnZXQvaGV4YWdv
bi9tYWNyb3MuaA0KPiBpbmRleCA5YTUxYjU3MDliLi5mOTkzOTBlMmE4IDEwMDY0NA0KPiAtLS0g
YS90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaA0KPiArKysgYi90YXJnZXQvaGV4YWdvbi9tYWNyb3Mu
aA0KPiBAQCAtOTMsMTMgKzkzLDEzIEBADQo+IA0KPiAgI2RlZmluZSBDSEVDS19OT1NIVUZfUFJF
RChHRVRfRUEsIFNJWkUsIFBSRUQpIFwNCj4gICAgICBkbyB7IFwNCj4gLSAgICAgICAgVENHTGFi
ZWwgKmxhYmVsID0gZ2VuX25ld19sYWJlbCgpOyBcDQo+IC0gICAgICAgIHRjZ19nZW5fYnJjb25k
aV90bChUQ0dfQ09ORF9FUSwgUFJFRCwgMCwgbGFiZWwpOyBcDQo+ICsgICAgICAgIFRDR0xhYmVs
ICpub3NodWZfbGFiZWwgPSBnZW5fbmV3X2xhYmVsKCk7IFwNCj4gKyAgICAgICAgdGNnX2dlbl9i
cmNvbmRpX3RsKFRDR19DT05EX0VRLCBQUkVELCAwLCBub3NodWZfbGFiZWwpOyBcDQo+ICAgICAg
ICAgIEdFVF9FQTsgXA0KPiAgICAgICAgICBpZiAoaW5zbi0+c2xvdCA9PSAwICYmIGN0eC0+cGt0
LT5wa3RfaGFzX3N0b3JlX3MxKSB7IFwNCj4gICAgICAgICAgICAgIHByb2JlX25vc2h1Zl9sb2Fk
KEVBLCBTSVpFLCBjdHgtPm1lbV9pZHgpOyBcDQo+ICAgICAgICAgIH0gXA0KPiAtICAgICAgICBn
ZW5fc2V0X2xhYmVsKGxhYmVsKTsgXA0KPiArICAgICAgICBnZW5fc2V0X2xhYmVsKG5vc2h1Zl9s
YWJlbCk7IFwNCj4gICAgICAgICAgaWYgKGluc24tPnNsb3QgPT0gMCAmJiBjdHgtPnBrdC0+cGt0
X2hhc19zdG9yZV9zMSkgeyBcDQo+ICAgICAgICAgICAgICBwcm9jZXNzX3N0b3JlKGN0eCwgMSk7
IFwNCj4gICAgICAgICAgfSBcDQo+IC0tDQo+IDIuMzQuMQ0KDQpSZXZpZXdlZC1ieTogQnJpYW4g
Q2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo=

