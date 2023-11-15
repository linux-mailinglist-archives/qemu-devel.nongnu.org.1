Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D16D57ED55E
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 22:04:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3N2l-0005Gf-EC; Wed, 15 Nov 2023 16:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1r3N2Y-0005Cv-6i
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 16:03:14 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1r3N2W-0003k6-Bh
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 16:03:13 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AF9NO7X002864; Wed, 15 Nov 2023 21:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=XgaibUi1OhFaIDq1WiM7WghrPnug3/PSJwT3xDy/Wpg=;
 b=ZfZe9V88boQ5OiM8Kfw7S9fGI6yA9o9rFTVKmDVaVg36hLEiLump2/sBkR2m+lHRmF4u
 DVPtNAcTGELpaxBprD1kpHTnaQI8gG56917VPr5IYN0SPxnsiegEFU3JXOYhIEEroClp
 OBfu6sssvf6AJlkk4PTHtHtTAFLyRUUa/dtjtM6w2QuveY169CcCQv7x5S/dKgW0FW32
 yA3FZ7wwpE+WrU/q9oHdS73z1nrymRAPIIcu+F5eOrtnv5GJ0tevhKSia99gnWxmJcu1
 AldmB64xBw+fY0y52sc+3+qQZW6rXr9sjUnwCeecb9IrxQcKMLV0bmoV+PZx6kSHg9XQ Xg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucuac1jv7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Nov 2023 21:03:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0wTlXGuKMyi4TZoAWMbZRg53Smw+vuDeIM6VlTXcViwf7jlc13U6hzAA0AR1uotXyHhms999vJkdxNJssxEdcleZTbwbDTZOoigCe6uUGAka7E5dl9kUGmPcubngBY3CV36Af5sCAQhtMoUy1q8Z7whj372sJMmkbKxY9iqhtycsoDzQrOFiNbXvTXjLMVV3sZcBN96ZadCrZ6aCfzO4J06U4TS6L/0EosgMHbWeDoEKWD+1icFvrTZmqgMy5XTBEBMlMEgrdnyyqjJhiIjqYHcoBNW0QpJZjjrcuyRlfLu9cfgWOKYabJTSRIKomRdUeUXFGB3GXQmD5ZdWDJcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgaibUi1OhFaIDq1WiM7WghrPnug3/PSJwT3xDy/Wpg=;
 b=Q+4CCGqNXWmz75sJSE2Q6UPaZaUjXJW8WfTObsPy6zbbp39lQq3/qT1QvHi/AQUslln3jgp0fV4jthWVQTFWOxJSGP0nIx6Qpa8ff/B2nIxyBP+yhfDSmNsQYcou8Kmw5b9ip3b0RVSt3FuvS0kx5r6pMbP9De+FSeh4UdSRkF1rwMJF8qGbllpB6ZGkte4SxOixsde7DPheDagXEsX1jcx48JFaGZmbxpQwxjQ3GhN4j8hx989w33YWkmyaBqIn0H7Fz9AxiTyW0p5dJpVEBLDqiwffdwhzktof/BfP1sWcKgm0y7IqDfJu8nQObTgTyM4jJPmexDSHFATWckF8iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by CO6PR02MB7602.namprd02.prod.outlook.com (2603:10b6:303:b0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 21:03:05 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c%6]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 21:03:04 +0000
From: Brian Cain <bcain@quicinc.com>
To: Brian Cain <bcain@quicinc.com>, Taylor Simpson <ltaylorsimpson@gmail.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, Sid Manning
 <sidneym@quicinc.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: RE: [RFC PATCH] Hexagon (target/hexagon) Make generators object
 oriented
Thread-Topic: [RFC PATCH] Hexagon (target/hexagon) Make generators object
 oriented
Thread-Index: AQHaE1NXmbv5ymjOZU6CrdzTksAFm7B7z8cQgAAXjoA=
Date: Wed, 15 Nov 2023 21:03:04 +0000
Message-ID: <SN6PR02MB42051D1CC449EDA779378046B8B1A@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20231109212549.356168-1-ltaylorsimpson@gmail.com>
 <SN6PR02MB4205D15E8A90CBFDE1C81D0FB8B1A@SN6PR02MB4205.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4205D15E8A90CBFDE1C81D0FB8B1A@SN6PR02MB4205.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|CO6PR02MB7602:EE_
x-ms-office365-filtering-correlation-id: 31fa4adb-68c1-4e74-ce24-08dbe61e42d9
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WUDSHDSb90asabA1zhAwmynJ+yIjFPUqan0q92JjV/UjHdYZOWe8SSFxcdSVoB6q3e0RZL1W7mDBCuG50l7sG919+0TtgmVuCy8NlySy3xT6Y90bFIM3n3RCtg5EoilN8f4lZDkF+MKJqWUPd0ZlLIRTPtGFTSI+oVB0M5nfjnOC4aGnEu457f1HP1mw98prhz4+NGnbvLrLtfd2XvdjT6WuGxbCiIHpk7jm4tTvdi9lAp4Y70yzI4r1VrQUT4GX683gxSdupYGDvwgEiSbjQ9VdzrBcuY2RSgndcp7JN58k30TODPoREDto1PO8V9u92pjijtoig/aHWQQqsz7c1kIh0JrD1FZ6aEP3cLtkloBzASsMzOOYtR/XEsobMCJARJqZywc6sNP6auGNA2CsSxczvKbkR1gifTBTdFjFNIw7/xMqkQ62yMkEnbvVglWTbom1o/jL8RBoV0hxHfCaDVzChPRJ8wgpo1LYScQTLNpykJfAGmWLEvFwPrEyYmb+rAH9VN2Zb0IfmDDAh3Ro27uBQ/GAkWKItlyUqkWA17I8bCNy12z5s/5Ofon84T5SBXp4BdvcjredGMx24noAo34WBHddWeEuvi4yvg0uif9bH1d4qONUtiC7Au3zZCnQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(346002)(396003)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(4744005)(41300700001)(33656002)(316002)(52536014)(66556008)(66946007)(110136005)(66446008)(55016003)(54906003)(66476007)(76116006)(38100700002)(64756008)(4326008)(8676002)(8936002)(478600001)(38070700009)(122000001)(86362001)(5660300002)(83380400001)(26005)(2940100002)(71200400001)(7696005)(6506007)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enVyQ1lmd3EyL3owcWxaYys4Z054ZTYzWG5udXZNOGJXbzAvTm9ZVVlTL01p?=
 =?utf-8?B?bVIxU2xicWNYa1BGZEdQcHRObkE3NDAwU2EycW1LUlQ4ZGtFZzdJcTRCNDBD?=
 =?utf-8?B?QkowU0hPNjFNRDZTREZBcE5Vczh1WlcyczFxcGVYaU9XVWN5ZjQvZDdrZzBp?=
 =?utf-8?B?ZlhPUFN5bFowb2JPaDFsVGZORWdHYkRaY1NzVFFtZjdaa0RZNUpDVjFtUFpZ?=
 =?utf-8?B?WGNSUytJaEExbkZKQTRtTnB1RnJNZ0JrRFhIMXUxUk5xUDRiR0drcjJnUEta?=
 =?utf-8?B?K1JJaStoL0l6Qi9uQk85bzNxeEx3UVY5UTNGRis1bVBRalNYTkFuQkV3UVIx?=
 =?utf-8?B?bE5Nb1ZqQTFoeW84ZGUxSTE2YWNNdktiZ3dYd1o2am45amgxcVVMNEhCbmta?=
 =?utf-8?B?TmtybkNhck9scHJvUWVUK3VlSVY0eklNbnc4MEI3b050b2ZYK1lCWGNiYmlz?=
 =?utf-8?B?MFo4UXIwVXFZNCtDSGZ5SDh0ZkMvY2wzdVFseE5JVGpYSE5uNFFQYTFBMW5B?=
 =?utf-8?B?cWJvRGZIRlpScm9zOWJYMlFObnFxdGhTV3BQNnQ5ZVlCTVlGb1ZaUVhNd3cv?=
 =?utf-8?B?RVBBYW5URVNVV1Jvc2xHSFpuQnFMVFZHaURpUEZ5eGdRUENaMk1BcG1nK3dy?=
 =?utf-8?B?YmZzcTFyeGYzYXZiTWlMbWtHUTdKeUQxclVtSTBwSHNpZ01aeWNjaU5uL2R0?=
 =?utf-8?B?QVRNRWw4aVFKd2UrcDdGeW0ydHZSckwrYmYvc2ZpVWJOcHNmRHlLSzJOVTRk?=
 =?utf-8?B?UGtlRUUwekF5Ri9GTEZlRGdnTGN2c0VnYUxCNHBvNUQ4aWtsRkZSYTNXa3dV?=
 =?utf-8?B?Z0k0WE42bWVxL2FoNitGckxQZmZzMGt2N291aGV2Ty9tNHNOSDIyR0tXeTIr?=
 =?utf-8?B?dE9hcXJObEJPR2k5Q0RIemNZYTlrQmQwQTJ4bEFidXVLVHpiUENUWS9KcGZq?=
 =?utf-8?B?YThhRjlCUlJFUmhIYzRGZE9taFVGK2hFWDBXSmVSZ2VOb2hoS25wc1FZNnpw?=
 =?utf-8?B?UFpIbnR6UlZrdmJSRitwd2c3REtTNWlkUjVHZWpuRS9GS0Zyb3BYeXZyY21m?=
 =?utf-8?B?ZnlFNVBFbzNEandNTTdnelNMa2NTOTJjQ2lrU1puWS95eXJDcWJ6TGo2MHRn?=
 =?utf-8?B?bm9nTFdNd2k2aDNnd0FqV3F0QitlUElRVkt0VGVwcnFlUW5TUFdHQmJ5aVRR?=
 =?utf-8?B?bXdybm05YWE2TFVjd3RtVnpGS252MHhmQ1UxOWQ3aUd4clBaNmtHYzNRL3FU?=
 =?utf-8?B?V05OcnVrSWF4a0ZPVzd4UnFuaUEralRBUlNSVzd3VEdvd3VWaUJsSnVoQzdH?=
 =?utf-8?B?WXgvOXpRU0NXY3ZTQkpVamtxeENRMVMyNm9SM25KejdBWndQT1F0K21veUdz?=
 =?utf-8?B?bUZBbklNdTlLZEMxQW1OejdRR3QvU3ZJcCs4M2lhWSt5YUl6VGZoWExkczdS?=
 =?utf-8?B?K01xMEt3RGsvUi9Dcno1VHRwcEU0ZHRRQmtoVWxDWTlpT2FsdlZwOE9KbFlF?=
 =?utf-8?B?MEVKZWozbG5GLzYvZG5ZdlRoejE1N2R1NGVqeHRyTXRPRXpFS096dGZDSVJM?=
 =?utf-8?B?c0ZLcXRJdFpNdElhNFhTSU1yR1U2SkFWSzVMc2RRcThWcExDMGdjSmhSMEpD?=
 =?utf-8?B?YndCZmhKdzEyRnN6c2pwT0lIZ0Z1dllqSVBpR0J5YnlKZHd2N2dwK0wxbzlI?=
 =?utf-8?B?TVhBNkpteUttTVdmaHBxOFdDK09rRldBZ1d6aGN1S1BQc3ZVZTBqUy9mbU9v?=
 =?utf-8?B?MUNTRHlvUlNvRWpxT04vUCtrbHB3N0RHRGZpUFMwdmdQajczWnFWTlVEZjJE?=
 =?utf-8?B?RVEyYkNsd3VacWhQdW9mbTFscnU0YjhxVmdhRlcvYXI1SHNqTk1icFdCWEI0?=
 =?utf-8?B?Rk9MM2ZSdVVNa2lzVGdxY3laSkN6NktDcXc0R2hRZ2NPZUhsNDlYNDhWTXc2?=
 =?utf-8?B?dENJOEtiZGZrcU82QWFaZHA0cDlOeDd4bGI4bjI0R1JQaGQ0azRuYnBrdE1x?=
 =?utf-8?B?QVdUTi94cFBseHhodnphcGYxUVl2c2UxdGdMcWpta1Zya2ZGYjBKZTdCek92?=
 =?utf-8?B?VFA3SUNqRldtT2xXTHZTTk4yQWdPcU90SUVjOW1NQWg4UE9XNlNwQ2ZHRmV5?=
 =?utf-8?Q?Tt8c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8H2ywkt0GB3cPTiy3X9GC74EjC8l2jBiPIkzg+aglNl7ZT4SvwRfSmXH/uThA/DlKfYMvCKUnCpYFF0/jR7YzFZ73fwtuLrMz7sVg2os+UkAScedIkAhD13k7a1ZVTM/YcRhPI45MywGghpeZx44Nj++p+/fgtfwiN6h9g1M4bOB0vTOxmBHeQt6L/LdseJmk19lSBc5zWfvJQL0auzxHsUje8BDHd1Io06TQEM33tM1AESgsgmeE+C+P42aA8eRF+REJYtYiSGFKJ4GoTgVg/aE+ssR27b273TO7SrN5PilNlNqsVFByMiGkkYYD4xb/Up9BozlgIFN1FfaCMHgvq561c7PWA8dWnxxztFYl/nt/IHa28N8zGP5kXXfno79dYU7GVXzvgysJvQlhO/mA04/rhTC1uG2YwJtevIh6qFfIlg8qB/C/N5nJa3HDuVPhSheRWoJQCmRiqGmzS8cdXQgsZm6ydopx5T2ri6oNhNWdjAUjPcWodUxkf2nEftOFZFnmt+6VTQ1ioQFDsO50Dcv3bE7w7pVRwFeMX1UAXjWwe/0M7M8HyD3+WzI2LZ0FjuKEOias2eG/ls40uAWIkQojQbw4VyvcEgxGFm348vRP1v14j8cSDGNVvMyQBmiPbAbA9dFu+fl2TIq6Gs7CNhwZoWGlxcaVl1X0qYxgVJtXYEpbQx/RhdGPp5IYymA9mAGJ9Dv588P91coa3XwlC4msIE5qZTABilSbXoY/VaLvlsf2ctC6UljBL4aYvxFRzDnoYpz+Di4I07wyISN+Rq4+Ah1CsIuM8ucmfitrrXrm/8r4XSVFZ/PsNLBoFAHHE7qg5qTFQkzQ2mfqrLB+A==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fa4adb-68c1-4e74-ce24-08dbe61e42d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 21:03:04.7635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBi99JXCkkDqs/1A3JLHJLJsKCuGqBPtbmbVI8v1VV7a10ggrYfmiKVkFc7hZO3WekQnlKsedMY1DQezj5eLuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7602
X-Proofpoint-ORIG-GUID: Vst-9tZv0PLxtGmi5D7FFV1gMYULbuR4
X-Proofpoint-GUID: Vst-9tZv0PLxtGmi5D7FFV1gMYULbuR4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_20,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=499
 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150167
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBxZW11LWRldmVsLWJvdW5jZXMr
YmNhaW49cXVpY2luYy5jb21Abm9uZ251Lm9yZyA8cWVtdS1kZXZlbC0NCi4uLg0KPiBBRkFJQ1Qg
dGhlIGtleXMgZm9yIHJlZ2lzdGVycyBhbmQgbmV3X3JlZ2lzdGVycyBjYW4gYmUgZGVyaXZlZCBm
cm9tIHRoZSB2YWx1ZXMNCj4gdGhlbXNlbHZlcy4gIFJhdGhlciB0aGFuIHdvcnJ5IGFib3V0IGNv
cHkvcGFzdGUgZXJyb3JzIGNhdXNpbmcgdGhlc2Ugbm90IHRvDQo+IGNvcnJlc3BvbmQsIHlvdSBj
YW4gY3JlYXRlIGEgZGljdGlvbmFyeSBmcm9tIGFuIGl0ZXJhYmxlIGxpa2Ugc286DQo+IA0KPiBy
ZWdpc3RlcnMgPSAoDQo+ICAgICBHcHJEZXN0KCJSIiwgImQiKSwNCj4gICAgIEdwckRlc3QoIlIi
LCAiZSIpLA0KPiAgICAgR3ByU291cmNlKCJSIiwgInMiKSwNCj4gICAgIEdwclNvdXJjZSgiUiIs
ICJ0IiksDQo+IC4uLg0KPiApDQo+IHJlZ2lzdGVycyA9IHsgcmVnLnJlZ3R5cGUgKyByZWcucmVn
aWQgZm9yIHJlZyBpbiByZWdpc3RlcnMgfQ0KDQpTb3JyeSwgZm9yZ290IHRoZSB2YWx1ZSAtIHRo
YXQgd291bGQgeWllbGQgYSBzZXQgYW5kIG5vdCBhIGRpY3QuDQoNCnJlZ2lzdGVycyA9IHsgcmVn
LnJlZ3R5cGUgKyByZWcucmVnaWQ6IHJlZyBmb3IgcmVnIGluIHJlZ2lzdGVycyB9DQo=

