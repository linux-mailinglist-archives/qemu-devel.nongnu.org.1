Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D8182B66D
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 22:10:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO2Jz-0008Ea-3W; Thu, 11 Jan 2024 16:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rO2Jv-00086W-LB
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 16:10:35 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rO2Jt-0002up-LE
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 16:10:35 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40BIWJ1j002732; Thu, 11 Jan 2024 21:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 qcppdkim1; bh=LHDvwlSK/JXOYRbPJtutl7AJJmQ3bakHkx9f61zhCyk=; b=gc
 oLRsgVuiQpyOrUShkJNw57GbYtsxPMYlgWMtHQkQ/T50LcL5gPCtF4x4gUVywuFl
 Oaw/aaK/OGEgzc+3KkCpYZSTOfbOS5lKdVfd/0i3NaFqIqo6uRNwWF2DBDHZNAvd
 /mXTS+mV+1btVad1C4jLXziF2KlEmwNh0nbVCgO2EFKAhVc3rCl63yyfE2xZA0w3
 nB6QOhC/Jid9yPaGGO3M72orBYs+vUCI79wrCbjF/Yob8mLjHhZLE5mDrMFBfdnv
 6D5RsOCY+sRG87Ue/8rocPy/AYGgPf/7q4cL+KXbmKhBAH30HOwXpz3oY+c2YROf
 wkq9OWEzwMHCQspem1AA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjmkd0j8n-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 21:10:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5Z9fmLwIsFldUWLeclYLUeCE5AFllSsqldE6789Gtsl6c3hoYtby//jBiYepHHsclqEUqUi/qWrtdy54wudG+3XVZyAEh4KW9snLKRviw+psebgKTmdtyyKnBLacS0oX2oiCPoOaYgoFjCStKyd+epXsPyib4wVwv7+SL2NFf0lQpgzfs1UaPwjKekGEJn4NBqCJD/yZAeIzW7W3cgXExPJBlSgcDJbvIstpmH8FCsFPeffyQ9BOrlruxrZu/QjmoMZx9skTYFMq0ILOK0PqzLwEFnc9YNGCv/waPoRxfsrWRzbIXg1Y8RjxOt7QnwTiHVR/LifWRUgS3vg3Pacxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHDvwlSK/JXOYRbPJtutl7AJJmQ3bakHkx9f61zhCyk=;
 b=nNIF6lkXJUbCPAA79fvpJ0Q4WaiFoXCFF/QcnS5N8HJb498nooqSDJqNr+HdcpyqJhwy/pf6LFkA3STZwKJCfohcWrF0xNGE7TU0pYeI0pywUmIwR8gQMRfPOSlLkRuSxrhapGJBtjY1zIsNO7WzhSarr6BrJTFdabUuBgAx5k8ZxmLfAOnxepT4nR+uyfcNr/0+NQAMU9hi97KLo6m0nOSZNpZe+Znv9hAbVt8QobJ5XAGk4pcMG6tHDeU9mtcBa71CDmQeyBJXABS0g4Sar8iCbce53UlcoisUMvtqIiV6g3OlVuVEKmVGSkKak6EDi+DC2gbHOALae0cCnt4r1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by PH0PR02MB7800.namprd02.prod.outlook.com (2603:10b6:510:53::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 21:10:03 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::dfab:83e2:41:20c8]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::dfab:83e2:41:20c8%5]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 21:10:03 +0000
From: Brian Cain <bcain@quicinc.com>
To: Taylor Simpson <ltaylorsimpson@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, Sid Manning
 <sidneym@quicinc.com>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: RE: [PATCH v2 9/9] Hexagon (target/hexagon) Remove dead functions
 from hex_common.py
Thread-Topic: [PATCH v2 9/9] Hexagon (target/hexagon) Remove dead functions
 from hex_common.py
Thread-Index: AQHaK7VHxNVGsM6LlkKFPT5a352ml7DVTaUA
Date: Thu, 11 Jan 2024 21:10:03 +0000
Message-ID: <SN6PR02MB42050A9F0F5D0DC7EE4BDC02B8682@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
 <20231210220712.491494-10-ltaylorsimpson@gmail.com>
In-Reply-To: <20231210220712.491494-10-ltaylorsimpson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|PH0PR02MB7800:EE_
x-ms-office365-filtering-correlation-id: 2f0dfbc5-3d95-4d7e-3f12-08dc12e9add0
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fH5iw78wCHC6IDyIL0UIvCRXRUgJza6tffG9Xq5CkRYIpdC9nfTRBG6CmYpznxt2xgWgqVGi7fC0rOWvLUp46vnGgvnFkCeStg+VpIeN9PcD9t3wTWiRMRp+h4MD95UhVUKvEKqkIqLqy8kba+rJCuGQHASulp5cpCy57ng0ka/NwB9gSsd8E1WWQxrdzTPTxOKilSawZ2aSXrmgXrk/1quGoxu2N7F0Fb2Th1yINDso0qoAYQlAtCumTWkeZMyu64DL0C6J1r1lH6XSSwd1GlC4DeF2/dC/fNRg38WscBaZFTWPT17VTqQAoIcM0RbLlGk7EsM93oHRf9hN0GRath6Kky9e83Plz/TufuvFvh6zYsHGoqsMvmkZxyHgoOjA/1/cp1JhWTMy8khxC9kJ05+nZSiBCrimVLunaao1BfyK+Xj91hz8fA1NRmLlsu6dZlJFe46vGpM8rqlQt4MOo+5ZKE1n7vfdJr6Z9ps8PCHMVgOVezwDvghXN1Ek7R9r988VikJmoT+DEeC7YOBTTd6jQlPboEMJUwqOGws9mq7uJof3YZKk8F9F+SyEuG9DyZWBhCXPXm7oDoBL+qix+2FrjlGbBDzu0IEWgfujJJGJninEVyfwFadCUuguSEQLyc8+dxgd+R8kPn5cf/MZnqCULcY1sTrDn63eXQowEXw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(366004)(136003)(346002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(55016003)(7696005)(71200400001)(53546011)(9686003)(122000001)(38070700009)(86362001)(33656002)(5660300002)(478600001)(26005)(6506007)(83380400001)(8676002)(52536014)(8936002)(4326008)(38100700002)(76116006)(2906002)(110136005)(66946007)(41300700001)(316002)(54906003)(64756008)(66556008)(66476007)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkZEaUdINU9HYVovc0J2VGVmamt2cGFmckhZSDZDMUQ5TktlWmNaaUFlWWk3?=
 =?utf-8?B?WUZxaldrUHQ2U2JIT3lsQTFUaEZBRGhwNk1kN2cwUmJxUG1tRmNDc0RkR2V5?=
 =?utf-8?B?dzR6UUo1VjN5Vkh5RFlieVZOZ2NjNkhOYlQybnpTc0ZaejBBLzA5ZkJCa2Vw?=
 =?utf-8?B?ODIzWG0zK3FTajAvQ0RlSmh2U0JYVjA4TGZ6WUxmWFhqMEQ4Qm44dGZGa2R1?=
 =?utf-8?B?Ui9uM1VzOUQzVCtyQUg3WDRSaytzNW1NQU1MdUVtaUQwZ1duRkg2WnNaRmt1?=
 =?utf-8?B?QWxKaVJxTjRpdUxQdm41RFY5OXVncUxrRDdxaU83RHRWc3VxdFBXMnhWeTUr?=
 =?utf-8?B?cFRNZlRxRnc5WkRlUW52K2VQRXJKQWZKZ1BOUnA1YjVMTE1yVFBSNUlKNk9E?=
 =?utf-8?B?NzhjcWpiSEllcHJhTlQ2alNuZ1UyUGlJZEl6OExTQWZUbTZLNk8zeVV6Vlgx?=
 =?utf-8?B?QWZONkRYeTJxaW10S1JsNjdzcjZKS0NURHdJZzZWK200bmIwVHMxOXQyTFRx?=
 =?utf-8?B?bktaa2FwVW9WZVdYRllQbEY0aUxZWVJMdzRPaGxFRkVmK1JmOVh2enQ3Q0dM?=
 =?utf-8?B?M1h1YWRNL21BT1Q0SllnT1ljbm9tQThRR0lWOWZyaWRoZGNmTGZ4WGx2OGw2?=
 =?utf-8?B?SmFFRkpTSEl4N21hVmswUHpMaWYrTTZsaDh4bE1aZDFKK2VrYnBoMVVLRnk2?=
 =?utf-8?B?WVV4OTBzN0ZwK3VONG1VZmpCbG1EMnZXVExUbkxTN0xmbjFyRUphVkZNTysz?=
 =?utf-8?B?RUNqMisxWTdJWC9zRlVoZGZkdTJ6ajgveTJ5VTZkVDhzMEJ3SEhoRm02QVdX?=
 =?utf-8?B?b0hyem8xUUFYelMzWmJUQ1d6YnRrSTgvaUYxcnd4V1lkdXE0TXNKRWIxS0g0?=
 =?utf-8?B?c09FNWJ5c2RYRXYwaGVOSG5reklxRGJnN3JXQ3VGUkZBYXluQ2RyNlh0aGFW?=
 =?utf-8?B?VVdRaUkzMGFENVhDa250NnA1RG5DbUFDN1lkY3Y2M2RNckx0MEZDUWtqbHlR?=
 =?utf-8?B?YUNRTEJKWGliOFFsM2ZZTnNDOUJ6M0xkVHZZM1BmREdvVkdrOGMvUGZTMCtS?=
 =?utf-8?B?SEZSN3Rvci9QeUJvT0pEc0c5dEZyK2I5b0VNRnBrQlZwWmR6MllwTVhGWWwx?=
 =?utf-8?B?TlFZTHUvblhXR051TmlNUjhBNmhGYUx5VVZCallnWmVaeThjVmdBeXJGLzU4?=
 =?utf-8?B?T0lVb0orak9LekdzR3J4SzB2dXY5RnpxaVFnblM2eU4xSTZyYXFlOHY2Z05k?=
 =?utf-8?B?ZDliQ0QvNG9nellhcTlaNnRtZTBBRjR4UGZWelBRMGcwY3doa0ljV0xZbWo3?=
 =?utf-8?B?eEtxSXE2YTZtcGNYYXB6TURxK25CZm1nOWQwaFlpN1BucXA3d2x4cDUweDlo?=
 =?utf-8?B?REZPTHFRUzJEdjZ1dFhUN041N0hCb0hzbm9ySjQxWHlhaGpsam9IVk8zVU13?=
 =?utf-8?B?eDgyUEhZZmphNUZRYUpYRTN6eVBTamRuaGtxVWhYSUZyRkQwV1NZMUxCdkM1?=
 =?utf-8?B?UjhpUkRmQkorVkZoVmN3NmU4ZEZzbEpLVTBKSFRaenBqSVU1N3Y0cElqKytD?=
 =?utf-8?B?dmFmREhBTk0vaElCWG96b2EzTDI1WWFLU3hoSUgxa3ZTOTZYZ05uRmdEelVD?=
 =?utf-8?B?VytUdUlxZkc2am5vd0ExSzFmNzF6MC8yZStqcU82UXd3RDRna3BhUk5LUHFS?=
 =?utf-8?B?ZHorb3dnNmNaTWVFc2NKUGc0aTFldWFJUkpTZVp0L3JJYkg0MzlpZVRaOEpj?=
 =?utf-8?B?NEtyYnBtZFdNbnRSdnJUcHQxU1JFeFhQRHowb3hpWGxBOFcxaXRkOStLYkpp?=
 =?utf-8?B?c2FvMUl3UWsxY21NZkZ3VmpXNTlpdWtZV2RhaWJ3ZWhEZG5VWjZIMndmYmht?=
 =?utf-8?B?aFhhRUNMcUp1OWF2N2JremZRQ29LQktVaHRRWE80WWNQZEpVNmE5YVFJc2Rk?=
 =?utf-8?B?ZVk4MDVsVkNZRlBBdElnNGZ0UHZ3bWJsN0ZxYUQzVXFQVXVKMDJuZU5CcmpE?=
 =?utf-8?B?Z1FXN3NSVzJtQ2RQd2lqY3V1TFpXSkowOGhuc1V1b2NWcHAvVUxEWlRKUm96?=
 =?utf-8?B?S0tNTlZERC9BeWRtbVpDYmV1UEFjb1ljUlFKelluYllxVkhlZktJa3NsTFZw?=
 =?utf-8?Q?MrIoRv/+RlymxJP2f3CwYzHBo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CCg7IrTkE3ti93JXBOYCL6xMLY+bV/MitZMnqF0ExvwOq0fHCZkSrBegmkOnbutV4ouLBP1mkhA8RrO2eF1mfCoCqavk05IOuccU3nSlcPRbAYlOXW3E4zIZ85/DI9lo2sroTK9hUXLm0Ze0Jn9WctNGYHQgabK99WhzYeQCKjNO00S2M+GfkyVbLKWyuELnRnK5nFHB9zzXN1MospjDBueUC6rkB89uVyLh3Sl93STEPt9yfPG61QdAnWm8s3Is6mL/QjCdmidtLcFv7chQjmssnAbsBGVxDghZVVL3FmogvEuIE4ttIuoBzL7MJ7XHVpzq10oMYtM7xIje5z1SpczFs2ZvV9SOx1Pml91PzVbuEawgv6Uy+PfAVePIISz/rbLse62CyzeOx0RcTukrfZeg6paVhcnctC0rPdlt8mlCKftpurZFy8jV0K0WU15JTOJoKeOBdHBZg1A4it/wiDphRyd8dppukvCyc6gpfdfQs8kuojIZ/LQUV0IRb1NLelBmwYP0om/EqZppCVtsZB3Blo1uo/SPyA1xWVyzsZ/9MMxV4ULEXevPYzcm8Cg4QcKoz3xE4p88sjuVMRZFJz0Ru36TBNZxNHs+wHbm2DnUJf8xnR+SzY+OpRV3o3Bp
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0dfbc5-3d95-4d7e-3f12-08dc12e9add0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 21:10:03.2140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KIfmK8TJFMlMbITqUevrn7g8/0jAffBawlgKsCK/pVmjEh48KdjDQKk37C4xaiReg7SHQIvd552UREVVnQqdXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7800
X-Proofpoint-GUID: dd85QsBZvu58MbB-6ubUQqJFbCbKGZV1
X-Proofpoint-ORIG-GUID: dd85QsBZvu58MbB-6ubUQqJFbCbKGZV1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=468 bulkscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110164
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGF5bG9yIFNpbXBzb24g
PGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4NCj4gU2VudDogU3VuZGF5LCBEZWNlbWJlciAxMCwg
MjAyMyA0OjA3IFBNDQo+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IEJyaWFuIENh
aW4gPGJjYWluQHF1aWNpbmMuY29tPjsgTWF0aGV1cyBCZXJuYXJkaW5vIChRVUlDKQ0KPiA8cXVp
Y19tYXRoYmVybkBxdWljaW5jLmNvbT47IFNpZCBNYW5uaW5nIDxzaWRuZXltQHF1aWNpbmMuY29t
PjsgTWFyY28NCj4gTGllYmVsIChRVUlDKSA8cXVpY19tbGllYmVsQHF1aWNpbmMuY29tPjsgcmlj
aGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsNCj4gcGhpbG1kQGxpbmFyby5vcmc7IGFsZUByZXYu
bmc7IGFuam9AcmV2Lm5nOyBsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20NCj4gU3ViamVjdDogW1BB
VENIIHYyIDkvOV0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIFJlbW92ZSBkZWFkIGZ1bmN0aW9u
cw0KPiBmcm9tIGhleF9jb21tb24ucHkNCj4gDQo+IFdBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2lu
YXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5IG9mDQo+IGFueSBs
aW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPiANCj4gVGhl
c2UgZnVuY3Rpb25zIGFyZSBubyBsb25nZXIgdXNlZCBhZnRlciBtYWtpbmcgdGhlIGdlbmVyYXRv
cnMNCj4gb2JqZWN0IG9yaWVudGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBz
b24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICB0YXJnZXQvaGV4YWdvbi9o
ZXhfY29tbW9uLnB5IHwgNTEgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgNTEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSBiL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkN
Cj4gaW5kZXggY2E1ZTk2MzBjMS4uMTk1NjIwYzdlYyAxMDA3NTUNCj4gLS0tIGEvdGFyZ2V0L2hl
eGFnb24vaGV4X2NvbW1vbi5weQ0KPiArKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5
DQo+IEBAIC0zMyw5ICszMyw2IEBADQo+ICBvdmVycmlkZXMgPSB7fSAgIyB0YWdzIHdpdGggaGVs
cGVyIG92ZXJyaWRlcw0KPiAgaWRlZl9wYXJzZXJfZW5hYmxlZCA9IHt9ICAjIHRhZ3MgZW5hYmxl
ZCBmb3IgaWRlZi1wYXJzZXINCj4gDQo+IC1kZWYgYmFkX3JlZ2lzdGVyKHJlZ3R5cGUsIHJlZ2lk
KToNCj4gLSAgICByYWlzZSBFeGNlcHRpb24oZiJCYWQgcmVnaXN0ZXIgcGFyc2U6IHJlZ3R5cGUg
J3tyZWd0eXBlfScgcmVnaWQgJ3tyZWdpZH0nIikNCj4gLQ0KPiAgIyBXZSBzaG91bGQgZG8gdGhp
cyBhcyBhIGhhc2ggZm9yIHBlcmZvcm1hbmNlLA0KPiAgIyBidXQgdG8ga2VlcCBvcmRlciBsZXQn
cyBrZWVwIGl0IGFzIGEgbGlzdC4NCj4gIGRlZiB1bmlxdWlmeShzZXEpOg0KPiBAQCAtMjAwLDQ2
ICsxOTcsNiBAQCBkZWYgZ2V0X3RhZ2ltbXMoKToNCj4gICAgICByZXR1cm4gZGljdCh6aXAodGFn
cywgbGlzdChtYXAoY29tcHV0ZV90YWdfaW1tZWRpYXRlcywgdGFncykpKSkNCj4gDQo+IA0KPiAt
ZGVmIGlzX3BhaXIocmVnaWQpOg0KPiAtICAgIHJldHVybiBsZW4ocmVnaWQpID09IDINCj4gLQ0K
PiAtDQo+IC1kZWYgaXNfc2luZ2xlKHJlZ2lkKToNCj4gLSAgICByZXR1cm4gbGVuKHJlZ2lkKSA9
PSAxDQo+IC0NCj4gLQ0KPiAtZGVmIGlzX3dyaXR0ZW4ocmVnaWQpOg0KPiAtICAgIHJldHVybiBy
ZWdpZFswXSBpbiAiZGV4eSINCj4gLQ0KPiAtDQo+IC1kZWYgaXNfd3JpdGVvbmx5KHJlZ2lkKToN
Cj4gLSAgICByZXR1cm4gcmVnaWRbMF0gaW4gImRlIg0KPiAtDQo+IC0NCj4gLWRlZiBpc19yZWFk
KHJlZ2lkKToNCj4gLSAgICByZXR1cm4gcmVnaWRbMF0gaW4gInN0dXZ3eHkiDQo+IC0NCj4gLQ0K
PiAtZGVmIGlzX3JlYWR3cml0ZShyZWdpZCk6DQo+IC0gICAgcmV0dXJuIHJlZ2lkWzBdIGluICJ4
eSINCj4gLQ0KPiAtDQo+IC1kZWYgaXNfc2NhbGFyX3JlZyhyZWd0eXBlKToNCj4gLSAgICByZXR1
cm4gcmVndHlwZSBpbiAiUlBDIg0KPiAtDQo+IC0NCj4gLWRlZiBpc19odnhfcmVnKHJlZ3R5cGUp
Og0KPiAtICAgIHJldHVybiByZWd0eXBlIGluICJWUSINCj4gLQ0KPiAtDQo+IC1kZWYgaXNfb2xk
X3ZhbChyZWd0eXBlLCByZWdpZCwgdGFnKToNCj4gLSAgICByZXR1cm4gcmVndHlwZSArIHJlZ2lk
ICsgIlYiIGluIHNlbWRpY3RbdGFnXQ0KPiAtDQo+IC0NCj4gLWRlZiBpc19uZXdfdmFsKHJlZ3R5
cGUsIHJlZ2lkLCB0YWcpOg0KPiAtICAgIHJldHVybiByZWd0eXBlICsgcmVnaWQgKyAiTiIgaW4g
c2VtZGljdFt0YWddDQo+IC0NCj4gLQ0KPiAgZGVmIG5lZWRfc2xvdCh0YWcpOg0KPiAgICAgIGlm
ICgNCj4gICAgICAgICAgIkFfQ1ZJX1NDQVRURVIiIG5vdCBpbiBhdHRyaWJkaWN0W3RhZ10NCj4g
QEAgLTI4MCwxNCArMjM3LDYgQEAgZGVmIHNraXBfcWVtdV9oZWxwZXIodGFnKToNCj4gICAgICBy
ZXR1cm4gdGFnIGluIG92ZXJyaWRlcy5rZXlzKCkNCj4gDQo+IA0KPiAtZGVmIGlzX3RtcF9yZXN1
bHQodGFnKToNCj4gLSAgICByZXR1cm4gIkFfQ1ZJX1RNUCIgaW4gYXR0cmliZGljdFt0YWddIG9y
ICJBX0NWSV9UTVBfRFNUIiBpbg0KPiBhdHRyaWJkaWN0W3RhZ10NCj4gLQ0KPiAtDQo+IC1kZWYg
aXNfbmV3X3Jlc3VsdCh0YWcpOg0KPiAtICAgIHJldHVybiAiQV9DVklfTkVXIiBpbiBhdHRyaWJk
aWN0W3RhZ10NCj4gLQ0KPiAtDQo+ICBkZWYgaXNfaWRlZl9wYXJzZXJfZW5hYmxlZCh0YWcpOg0K
PiAgICAgIHJldHVybiB0YWcgaW4gaWRlZl9wYXJzZXJfZW5hYmxlZA0KPiANCj4gLS0NCj4gMi4z
NC4xDQoNCg0KUmV2aWV3ZWQtYnk6IEJyaWFuIENhaW4gPGJjYWluQHF1aWNpbmMuY29tPg0K

