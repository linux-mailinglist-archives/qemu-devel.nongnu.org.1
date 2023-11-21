Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6837F32B8
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 16:52:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5T2d-0000ej-SJ; Tue, 21 Nov 2023 10:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1r5T2a-0000Jm-KK
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:51:56 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1r5T2W-0001UL-LW
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:51:56 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALFgmuB022706; Tue, 21 Nov 2023 15:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=lYJHjGojZpNEC5PQGUcl0B/YF0nigipccDuSd4YYwSg=;
 b=M0RHY+NDI5r19t55Lt6lG+ilbsM7A8CaNlb4E4GDn4WXJ4oXwV8QqFBBrz5fknkvD13h
 d32WO0ujy3U+tky3LUbEaix21EVez4rFZLQ3dQpGy9SAmaH1/rjyeBGM9Amui0xPn/Z8
 xX4l04Uks4tFj9HP1KlHSQtEbGSPijO77kHiC3TNCGiPNIo40Syl18E+eW3Xjz8xJB1H
 jCc5VM39pHbhdoU3wg4aidQFbtDc6LytlUG3CH8xBRoAvmEJU6hpRZaxd3V8TbYwiQJK
 kpYWBESoUABFu2Cklx4+2yY0/0AclKT87fXBU0rVvTlew2ebRKXcnHnUWMXJ2qJn4k8H hw== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugge1ae60-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 15:51:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kurkAaJtWI7I6zix/ETGXm+b9NHEf1MKxzZu2C2fCzV6Udq2FvVV+ZzsbobrOw70xShMrnWM1fCc5oQ5fEglFH+FbB2Oh4vLH5rHxYLA3y9T7EpMpc00iZxXO/eojLCjSKOyemZ8dt4P7dWKxXP+ORXCNmOw1UK/2xEzuhL4HCY1PcpsYa95p/vZ4izFbbToEJbjrvTsw5wZhRNI9qKHzPrcwuMJ8k8Rh5FGMGXPQjMINTMbs/JyMjaB4uNwGAg6ZmdC+wGsmUhA8dvQ7xOLs3KOzs6jpHZL7fajrAXJtfBWm+FtH8/5atDcTZTUh0Qn6DWtjlVi4hRxFCjOnzfWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYJHjGojZpNEC5PQGUcl0B/YF0nigipccDuSd4YYwSg=;
 b=fBK7GLK+sCwLs3Glr7D2EphlvA6WzxPRv88msI75xHrK4pK/HBRzF5E0TdDC4OubEkAiG3zWorAyQ1zNoqMIg/SdEmR8yUCQOSm8l9K2RO9UAC5P33o6gIwOpgs1j2wBSq3qVJ+l9F5ANrE5/d/dfBot+NE7Dle2ME0JnbasFhZ2U7uambHjtiaN8jJvvUNYo0Xp1oM6VZsg/lI8fbDv6NzmAqPrIjIzZuEbi/YAsPl0llszV6Zp0JAkiaHRrOLxb39IA+f/LbWvHMN/5OYaxerwb1wnAoTZUVdz71IdECTMnPgkiQ0Io9YuN0fmijJKTQUkIaqeTr0l7KeYvRAMHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by BY5PR02MB7090.namprd02.prod.outlook.com (2603:10b6:a03:21e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 15:51:43 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c%6]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 15:51:43 +0000
From: Brian Cain <bcain@quicinc.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "f4bug@amsat.org" <f4bug@amsat.org>
Subject: RE: [PULL v2 25/30] Hexagon HVX (target/hexagon) instruction decoding
Thread-Topic: [PULL v2 25/30] Hexagon HVX (target/hexagon) instruction decoding
Thread-Index: AQHaHIfcyIHup7w1PUeMeBlJwOJ32rCE57iA
Date: Tue, 21 Nov 2023 15:51:42 +0000
Message-ID: <SN6PR02MB4205881CE71AC823000E3E49B8BBA@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <1635974247-1820-1-git-send-email-tsimpson@quicinc.com>
 <1635974247-1820-26-git-send-email-tsimpson@quicinc.com>
 <CAFEAcA-rPwmE1oXoPROUEfpa+CDL0zFK5U5N=wPVhWtBif-b9Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-rPwmE1oXoPROUEfpa+CDL0zFK5U5N=wPVhWtBif-b9Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|BY5PR02MB7090:EE_
x-ms-office365-filtering-correlation-id: c2533484-10ae-400e-1b29-08dbeaa9c214
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a5EXfSrXVWhwWlBVk98CjxV8tH3QqcHV1VfVzN82ec/7nZIs+1lcbzP+VKwZIRc4yCvNz64+I/Wa+NaMBIraHID4vvk1HWyhyU76lLMU68e2TMzis7MAhO9kHAU+L4bU1fZ69I+Q1P8ndtpDsBYooFjQtYdvm/8Umh3I0S59X1OeHrnYDA6NyrcYL3rMOoMfm7tVVbYMbp41J0tOdJholslDQ7TfePqo34I0zv6hhF5kl+Lo/ioXgy3H9XG/zctv4J1uC9SwhHrttwIwSf/kjk3BBONiSqThR+diA0tzQXWbAKLwRjiOiLnPi6LGhE3+qmgACqJWRtMJ9FOnSa5Kh6c0yfFXgKVOVfpFDpN1YHoVQCutEnx0yd7zMpLTm1P5xal3AAwYySqsoFw1gADHYmWc56przU69hibgYKoZJAwTO5Nl2lRmZe/lO58hdbhTIHP3MhKRKAmUMhRXwOfvnmySQ2LWo5YFziJxp9SBb5xspU6YfX15SD+TMabbreK5IqI2PNd6WfeuigjehOkwo34GVhJ43fcEqt3/gnYoPrhfbp1svNa2FwoLxqWoe5RrJVuySbypvxM4ldmRbeP1hMKDNE9X5feKVOwsA/VT4Kt9YcxF7kXXyibaPVOgFLRRPNUjH+HJho7/mkMGwHnlCfRaRCt9XoYu6egfVt8k/4A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(76116006)(66946007)(66556008)(64756008)(316002)(6916009)(66446008)(66476007)(54906003)(26005)(52536014)(4326008)(8936002)(38070700009)(8676002)(38100700002)(41300700001)(122000001)(33656002)(86362001)(2906002)(5660300002)(83380400001)(55016003)(478600001)(9686003)(53546011)(6506007)(71200400001)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVREYlY3QTNKNUxiVjZNVG0yZjRXaHlmeVV0allrM21MbzhCR0tvK1V2RTdJ?=
 =?utf-8?B?U3BSbldVdzc0UFRIdmhLcHhpRnBYbzUyK1M4MlVFY0xjdmJLVy9KOEkyTWZK?=
 =?utf-8?B?SUVtbGRLOHkxU2VndmRqcDF2M2I2ZjQxVllFNkJUNVpNb2hQSTM4UVJkc2NK?=
 =?utf-8?B?M05nNm43VW9sd3IrcExhRjFTL2xNZW8ySmpFd1M0eFBxNXlrL3hlaHFnbWM2?=
 =?utf-8?B?QUEzRHlMdFpFbjBFMzZmTXI0YWtpZkpFZW9uTUlnTWdzem8wU2ZJeldJS1pH?=
 =?utf-8?B?dTZBRUN2akNxY1dYVjhmKzZrRUFmTm1vMlJqb21QbktCSjQ4VXRVakZvbnlT?=
 =?utf-8?B?SSt1OXFMTzBGZ3pQVnhsaE02eXBuR3A5TzlrdlNadHJjY3hIQXNEWC9ZR0RT?=
 =?utf-8?B?RC9NYWRNQlo3cFZTQUtBaCtYZFdKVGc3Uy9sV0F5cnN4WGkvckVJQXg2Q3U5?=
 =?utf-8?B?dUozdHNyL3d1TGhNUEh3a2ZpenovK3ZsdUVHdzZpTDRrb2czTnBNd2VFVVln?=
 =?utf-8?B?WTJOMGtHaStqeFVXdjR2dTFic1NIYUxaUUVIRzI4ekZnb05aS3N6ZE9LNmlY?=
 =?utf-8?B?anBVR2RsUGJGWWk3Um04ajBqeXh2WE13NXAxbVdDbUxxN0xIekdDTU5VcUVj?=
 =?utf-8?B?Q2RIWHlOZlh1Nm5LOTVlMFNKM2RzMHFYM1FzMXlqbjg2bEJSaVdFODFEeXo0?=
 =?utf-8?B?dkFVT0xpSEI4UlJia2NZTVdmdHV1WEZZd2t6eFNJVTBxQmJaL011b2cxSmkv?=
 =?utf-8?B?WWpKRDM4RjFvOFJwTzBLVlU5OFR6bWE1NWtuM2Zld1NHdktIS0lOS0djaU9N?=
 =?utf-8?B?UmZpc3hDeGhBUzl3WmtXRFJ4VEIrclUrQXFpOE9xZG1VS3VveVREY2IybURh?=
 =?utf-8?B?d21HTUJSbTg0dkdmK094SG0xcWgxRGdoamltUFZOTnoxcDdOU2l4dUMrQmoz?=
 =?utf-8?B?VHBXSFJQWDdTWlVvNGNydktxN01pRkFLaUwvdGEvRGxpWVlmVGM3b2RPQU1R?=
 =?utf-8?B?dFdROFEzRkZGaU5nWUZsS3NaQk1vUTRCamNFbmo3UGwzSkNwZGFqMWdyTHoz?=
 =?utf-8?B?cUxmN2EzZ3lRTTRpODd0UnZoMHBuSkFjNFNMTWRURSswQUVrenovOS84aWF4?=
 =?utf-8?B?bk1VTkxKUkt3YTA4U1ArWld0Um1YR1NWY3hzbDhnQmlqQVNsektGN2Fwakhl?=
 =?utf-8?B?U2l6cXBLakxPcW9kRHVXdERaZllGK2xyN001OTRVSGVMeFBIYVZiaVlKUS9D?=
 =?utf-8?B?QUlxWEdpZHBoQk9wU3N4T0swZ2tYMXhpTHlWQy9xR2pMeDFyY3hBUDVER3Jo?=
 =?utf-8?B?VnFoaVVlSmsvcG5Oek8xQ3VQM1Y4WFlTSjhXMTRMbzNnQmpiRmoyRk54OGxD?=
 =?utf-8?B?b0NzWS9LZGRuaVE5K1pKMGwwYnZISzhkazBBb0lTSWJVdVprWHIzT3ZnZlNT?=
 =?utf-8?B?c01nWFlGOERBS21yVkNYTjYyZkdKMVUzSnB3Q1dTZXdGRGVqb2dGb1hHM3A0?=
 =?utf-8?B?MTBxMWZPS2d2S3dsSjFHb0lGbmhHaDAzenBsT0hwSEcvTDB6OUtCM0luLzk2?=
 =?utf-8?B?U3VoL0ZLNW9wNnUzL2o4S2lpZzFiM1VaOStHcmdsL28wOEZlZjlucjk4QXpZ?=
 =?utf-8?B?Z05hMkFlYUVGUzAwaE9abHllaXdMdlF1cXI0RFlqakJ1N0tSNG15ejZMRTFY?=
 =?utf-8?B?dEZLQzBXTjFsVnJ0THVLdDJYL3UwSmdlRDVycnJGWDI0RUFkYVYwM1BvQmRj?=
 =?utf-8?B?a2RsWGxuZVJpSE1ZRGVjbDRJVE5zZ0wyRmhjanBaV2V0cm4ybnNaTzA3UURP?=
 =?utf-8?B?K2xUbjZHTjFwOUFmM1hpZUY4QnlBbDNwVjdPYlJRZTFBUVFHNjNnOGpBMlA5?=
 =?utf-8?B?L0RGeEVLOXkxeElUSjlhS05PR1dody8xNTNXSk5iN1FKTGpUUGV6MzlIK1VR?=
 =?utf-8?B?eS9zQ2ttNkdsSzlDTjRJQmh5RElCRnpNejEySklubE94TG9NdUVsbVhRK0Zy?=
 =?utf-8?B?MCthOGdIRWpBYmx4c2R2NUdZYTdMWW45djZtQnEwNzI2K3g4ZFNCdURrK0lm?=
 =?utf-8?B?MEtqUmhWZVJMYzNvRmE2YlkrT0tHUXU4NmhLcjB6TmpWRXZkN3I1YlhWMkkw?=
 =?utf-8?Q?AeC4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AUxB4RBxlWgigZTuowW1YDbUlS+oZtpwAkIH1jfImrCapYOuvgdErfuh8aaGiRBEKgQQmbCG+NAbR0BOs27xSz429d/aPSPXvfsPOL08bmewnvg9Xbq1xNxjsJhi76DBhcv+f1NVVOLJstq4TZNltXriwHQN5489CQ3kPyC9MvVKk/yhEWDIGcY+lVbutMh9nQq+hSMdzF7oc6eApsN40dmT7j1vYUaraDeqjaLXLNholsU128OrcncGOU9y1vN5ni/YZnIHwfGIWN08cHLMBqtEAl82Qq3GBrKKO5TzTOi4Bed4I0/1sLIqjSvhatoe9K8Th5ymBwCB/aDz5yuQjTens5TCjXNQbetho9e38LSKts2ebvyQy9q05ov9OhCsmAalvlZdTPI3RGQusOnc7ZqMNw1ggs8KlCyBzK8TdbDQFd/ePmDkjA85wkvTrKVgnW/bs4NbABi1K04LfQJvQ6hN1Lyerow9fWI4o0vwZulVoC9Fe17JuM16/Itgw9OHEtQL9uO9nlt/iyb34o5Ymm0LtHvoPI487wZ4dyaVcu62at2RpWLtSx5EqfYKaiTo/oEI9iBh1xaQ/tlpWw0bebH2HMDZzxtkU7sYm5DCUrU/vN8iycrFh1LYTmThkF8GppwFrH4aEcy2qJjTF8ZmaBsipUbJhoobMNVa8Nx+jk71kRIic9tpSQyHjU5lJ0kQX2FvEaO8al6GeHEtrqHN7LHT8pcBAXuRdl8sOi9w62azqc5h8WaAQ2YSLSuDAX1Re9129UHbTG1nYMJjEiz2bCesOinXZ49gdcQJZRdMVm2ieWpgYKY68mAiIq3zCe7JTDOb26MaJgCFcrCTLtFbIg==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2533484-10ae-400e-1b29-08dbeaa9c214
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 15:51:42.9026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPAQx0iJF8IpP8v1I3l1FePmGkF/febGyc2fK3byY5yalleFtxXDY/AvfvH55U9LxKmYrXz3Tq336wIUiyZkAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7090
X-Proofpoint-GUID: RrpWTTL5qFeqps2hVF8sfmdTGNQuMh8h
X-Proofpoint-ORIG-GUID: RrpWTTL5qFeqps2hVF8sfmdTGNQuMh8h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_09,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=891 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210124
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogcWVtdS1kZXZlbC1ib3Vu
Y2VzK2JjYWluPXF1aWNpbmMuY29tQG5vbmdudS5vcmcgPHFlbXUtZGV2ZWwtDQo+IGJvdW5jZXMr
YmNhaW49cXVpY2luYy5jb21Abm9uZ251Lm9yZz4gT24gQmVoYWxmIE9mIFBldGVyIE1heWRlbGwN
Cj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMjEsIDIwMjMgODozMyBBTQ0KPiBUbzogVGF5bG9y
IFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPg0KPiBDYzogcWVtdS1kZXZlbEBub25nbnUu
b3JnOyByaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOyBmNGJ1Z0BhbXNhdC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQVUxMIHYyIDI1LzMwXSBIZXhhZ29uIEhWWCAodGFyZ2V0L2hleGFnb24pIGlu
c3RydWN0aW9uDQo+IGRlY29kaW5nDQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0
ZWQgZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZg0KPiBhbnkgbGlu
a3Mgb3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+IE9uIFdl
ZCwgMyBOb3YgMjAyMSBhdCAyMToxNywgVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IEFkZCBuZXcgZmlsZSB0byB0YXJnZXQvaGV4YWdvbi9tZXNv
bi5idWlsZA0KPiA+DQo+ID4gQWNrZWQtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhl
bmRlcnNvbkBsaW5hcm8ub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDx0
c2ltcHNvbkBxdWljaW5jLmNvbT4NCj4gDQo+IEhpOyBDb3Zlcml0eSBwb2ludHMgb3V0IGEgdmFy
aWFibGUgd3JpdHRlbiB0byBhbmQgdGhlbg0KPiBvdmVyd3JpdHRlbiBiZWZvcmUgaXQncyBldmVy
IHVzZWQgaW4gdGhpcyBmdW5jdGlvbiAoQ0lEIDE1Mjc0MDgpOg0KPiANCj4gDQo+IA0KPiANCj4g
PiArc3RhdGljIHZvaWQNCj4gPiArY2hlY2tfbmV3X3ZhbHVlKFBhY2tldCAqcGt0KQ0KPiA+ICt7
DQo+ID4gKyAgICAvKiAubmV3IHZhbHVlIGZvciBhIE1NVmVjdG9yIHN0b3JlICovDQo+ID4gKyAg
ICBpbnQgaSwgajsNCj4gPiArICAgIGNvbnN0IGNoYXIgKnJlZ2luZm87DQo+ID4gKyAgICBjb25z
dCBjaGFyICpkZXN0bGV0dGVyczsNCj4gPiArICAgIGNvbnN0IGNoYXIgKmRzdHN0ciA9IE5VTEw7
DQo+ID4gKyAgICB1aW50MTZfdCBkZWZfb3Bjb2RlOw0KPiA+ICsgICAgY2hhciBsZXR0ZXI7DQo+
ID4gKyAgICBpbnQgZGVmX3JlZ251bTsNCj4gDQo+IGRlZl9yZWdudW0gaGFzIGZ1bmN0aW9uIGxl
dmVsIHNjb3BlLi4uDQo+IA0KPiA+ICsNCj4gPiArICAgIGZvciAoaSA9IDE7IGkgPCBwa3QtPm51
bV9pbnNuczsgaSsrKSB7DQo+ID4gKyAgICAgICAgdWludDE2X3QgdXNlX29wY29kZSA9IHBrdC0+
aW5zbltpXS5vcGNvZGU7DQo+ID4gKyAgICAgICAgaWYgKEdFVF9BVFRSSUIodXNlX29wY29kZSwg
QV9ET1RORVdWQUxVRSkgJiYNCj4gPiArICAgICAgICAgICAgR0VUX0FUVFJJQih1c2Vfb3Bjb2Rl
LCBBX0NWSSkgJiYNCj4gPiArICAgICAgICAgICAgR0VUX0FUVFJJQih1c2Vfb3Bjb2RlLCBBX1NU
T1JFKSkgew0KPiA+ICsgICAgICAgICAgICBpbnQgdXNlX3JlZ2lkeCA9IHN0cmNocihvcGNvZGVf
cmVnaW5mb1t1c2Vfb3Bjb2RlXSwgJ3MnKSAtDQo+ID4gKyAgICAgICAgICAgICAgICBvcGNvZGVf
cmVnaW5mb1t1c2Vfb3Bjb2RlXTsNCj4gPiArICAgICAgICAgICAgLyoNCj4gPiArICAgICAgICAg
ICAgICogV2hhdCdzIGVuY29kZWQgYXQgdGhlIE4tZmllbGQgaXMgdGhlIG9mZnNldCB0byB3aG8n
cyBwcm9kdWNpbmcNCj4gPiArICAgICAgICAgICAgICogdGhlIHZhbHVlLg0KPiA+ICsgICAgICAg
ICAgICAgKiBTaGlmdCBvZmYgdGhlIExTQiB3aGljaCBpbmRpY2F0ZXMgb2RkL2V2ZW4gcmVnaXN0
ZXIuDQo+ID4gKyAgICAgICAgICAgICAqLw0KPiA+ICsgICAgICAgICAgICBpbnQgZGVmX29mZiA9
ICgocGt0LT5pbnNuW2ldLnJlZ25vW3VzZV9yZWdpZHhdKSA+PiAxKTsNCj4gPiArICAgICAgICAg
ICAgaW50IGRlZl9vcmVnID0gcGt0LT5pbnNuW2ldLnJlZ25vW3VzZV9yZWdpZHhdICYgMTsNCj4g
PiArICAgICAgICAgICAgaW50IGRlZl9pZHggPSAtMTsNCj4gPiArICAgICAgICAgICAgZm9yIChq
ID0gaSAtIDE7IChqID49IDApICYmIChkZWZfb2ZmID49IDApOyBqLS0pIHsNCj4gPiArICAgICAg
ICAgICAgICAgIGlmICghR0VUX0FUVFJJQihwa3QtPmluc25bal0ub3Bjb2RlLCBBX0NWSSkpIHsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gPiArICAgICAgICAgICAgICAg
IH0NCj4gPiArICAgICAgICAgICAgICAgIGRlZl9vZmYtLTsNCj4gPiArICAgICAgICAgICAgICAg
IGlmIChkZWZfb2ZmID09IDApIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICBkZWZfaWR4ID0g
ajsNCj4gPiArICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICAgICAgICAg
IH0NCj4gPiArICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgICAvKg0KPiA+ICsgICAgICAg
ICAgICAgKiBDaGVjayBmb3IgYSBiYWRseSBlbmNvZGVkIE4tZmllbGQgd2hpY2ggcG9pbnRzIHRv
IGFuIGluc3RydWN0aW9uDQo+ID4gKyAgICAgICAgICAgICAqIG91dC1vZi1yYW5nZQ0KPiA+ICsg
ICAgICAgICAgICAgKi8NCj4gPiArICAgICAgICAgICAgZ19hc3NlcnQoISgoZGVmX29mZiAhPSAw
KSB8fCAoZGVmX2lkeCA8IDApIHx8DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgKGRlZl9p
ZHggPiAocGt0LT5udW1faW5zbnMgLSAxKSkpKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgIC8q
IGRlZl9pZHggaXMgdGhlIGluZGV4IG9mIHRoZSBwcm9kdWNlciAqLw0KPiA+ICsgICAgICAgICAg
ICBkZWZfb3Bjb2RlID0gcGt0LT5pbnNuW2RlZl9pZHhdLm9wY29kZTsNCj4gPiArICAgICAgICAg
ICAgcmVnaW5mbyA9IG9wY29kZV9yZWdpbmZvW2RlZl9vcGNvZGVdOw0KPiA+ICsgICAgICAgICAg
ICBkZXN0bGV0dGVycyA9ICJkZXh5IjsNCj4gPiArICAgICAgICAgICAgZm9yIChqID0gMDsgKGxl
dHRlciA9IGRlc3RsZXR0ZXJzW2pdKSAhPSAwOyBqKyspIHsNCj4gPiArICAgICAgICAgICAgICAg
IGRzdHN0ciA9IHN0cmNocihyZWdpbmZvLCBsZXR0ZXIpOw0KPiA+ICsgICAgICAgICAgICAgICAg
aWYgKGRzdHN0ciAhPSBOVUxMKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+
ID4gKyAgICAgICAgICAgICAgICB9DQo+ID4gKyAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAg
ICAgaWYgKChkc3RzdHIgPT0gTlVMTCkgICYmIEdFVF9BVFRSSUIoZGVmX29wY29kZSwgQV9DVklf
R0FUSEVSKSkgew0KPiA+ICsgICAgICAgICAgICAgICAgZGVmX3JlZ251bSA9IDA7DQo+IA0KPiBJ
biB0aGlzIGhhbGYgb2YgdGhlIGlmKCkgd2Ugc2V0IGl0IHRvIDAuLi4NCj4gDQo+ID4gKyAgICAg
ICAgICAgICAgICBwa3QtPmluc25baV0ucmVnbm9bdXNlX3JlZ2lkeF0gPSBkZWZfb3JlZzsNCj4g
PiArICAgICAgICAgICAgICAgIHBrdC0+aW5zbltpXS5uZXdfdmFsdWVfcHJvZHVjZXJfc2xvdCA9
IHBrdC0+aW5zbltkZWZfaWR4XS5zbG90Ow0KPiA+ICsgICAgICAgICAgICB9IGVsc2Ugew0KPiA+
ICsgICAgICAgICAgICAgICAgaWYgKGRzdHN0ciA9PSBOVUxMKSB7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgLyogc3RpbGwgbm90IHRoZXJlLCB3ZSBoYXZlIGEgYmFkIHBhY2tldCAqLw0KPiA+
ICsgICAgICAgICAgICAgICAgICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7DQo+ID4gKyAgICAg
ICAgICAgICAgICB9DQo+ID4gKyAgICAgICAgICAgICAgICBkZWZfcmVnbnVtID0gcGt0LT5pbnNu
W2RlZl9pZHhdLnJlZ25vW2RzdHN0ciAtIHJlZ2luZm9dOw0KPiA+ICsgICAgICAgICAgICAgICAg
LyogTm93IHBhdGNoIHVwIHRoZSBjb25zdW1lciB3aXRoIHRoZSByZWdpc3RlciBudW1iZXIgKi8N
Cj4gPiArICAgICAgICAgICAgICAgIHBrdC0+aW5zbltpXS5yZWdub1t1c2VfcmVnaWR4XSA9IGRl
Zl9yZWdudW0gXiBkZWZfb3JlZzsNCj4gPiArICAgICAgICAgICAgICAgIC8qIHNwZWNpYWwgY2Fz
ZSBmb3IgKFZ4LFZ5KSAqLw0KPiA+ICsgICAgICAgICAgICAgICAgZHN0c3RyID0gc3RyY2hyKHJl
Z2luZm8sICd5Jyk7DQo+ID4gKyAgICAgICAgICAgICAgICBpZiAoZGVmX29yZWcgJiYgc3RyY2hy
KHJlZ2luZm8sICd4JykgJiYgZHN0c3RyKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgZGVm
X3JlZ251bSA9IHBrdC0+aW5zbltkZWZfaWR4XS5yZWdub1tkc3RzdHIgLSByZWdpbmZvXTsNCj4g
PiArICAgICAgICAgICAgICAgICAgICBwa3QtPmluc25baV0ucmVnbm9bdXNlX3JlZ2lkeF0gPSBk
ZWZfcmVnbnVtOw0KPiA+ICsgICAgICAgICAgICAgICAgfQ0KPiANCj4gLi4uYnV0IHRoZSBvbmx5
IHBsYWNlIHdlIHJlYWQgZGVmX3JlZ251bSBpcyBpbiB0aGlzIG90aGVyIGhhbGYgb2YgdGhlDQo+
IGlmKCksIGFuZCBpZiB3ZSBnZXQgaGVyZSB0aGVuIHdlJ3ZlIHNldCBpdCB0byBzb21ldGhpbmcg
b3V0IG9mIHB4dC0+aW5zbi4NCj4gDQo+IFdlcmUgd2Ugc3VwcG9zZWQgdG8gZG8gc29tZXRoaW5n
IHdpdGggZGVmX3JlZ251bSBvdXRzaWRlIHRoaXMgaWYoKSwNCj4gb3IgY291bGQgd2UgaW5zdGVh
ZCBkcm9wIHRoZSBpbml0aWFsaXphdGlvbiBpbiB0aGUgZmlyc3QgaGFsZiBvZiB0aGUgaWYoKQ0K
PiBhbmQgbW92ZSBpdHMgZGVjbGFyYXRpb24gaW5zaWRlIHRoaXMgZWxzZSB7fSBibG9jayA/DQoN
CkhtbSAtLSB3ZSdsbCB0YWtlIGEgbG9vayBhdCB0aGlzIGFuZCBnZXQgYmFjayB0byB5b3UuDQoN
Cj4gPiArICAgICAgICAgICAgICAgIC8qDQo+ID4gKyAgICAgICAgICAgICAgICAgKiBXZSBuZWVk
IHRvIHJlbWVtYmVyIHdobyBwcm9kdWNlcyB0aGlzIHZhbHVlIHRvIGxhdGVyDQo+ID4gKyAgICAg
ICAgICAgICAgICAgKiBjaGVjayBpZiBpdCB3YXMgZHluYW1pY2FsbHkgY2FuY2VsbGVkDQo+ID4g
KyAgICAgICAgICAgICAgICAgKi8NCj4gPiArICAgICAgICAgICAgICAgIHBrdC0+aW5zbltpXS5u
ZXdfdmFsdWVfcHJvZHVjZXJfc2xvdCA9IHBrdC0+aW5zbltkZWZfaWR4XS5zbG90Ow0KPiA+ICsg
ICAgICAgICAgICB9DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgfQ0KPiA+ICt9DQo+IA0KPiB0
aGFua3MNCj4gLS0gUE1NDQoNCg==

