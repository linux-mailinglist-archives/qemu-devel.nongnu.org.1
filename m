Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1D982B667
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 22:10:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO2J3-0005Yq-Vt; Thu, 11 Jan 2024 16:09:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rO2Iz-0005Ly-SF
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 16:09:37 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rO2Iy-00027g-7E
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 16:09:37 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40BKXGOI003384; Thu, 11 Jan 2024 21:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 qcppdkim1; bh=ScTp7GFSC9vIXWSDsiohYSEaY1hGLKATyOUpAhuV9U8=; b=ls
 W+VRLMtO/Am6hnBGUicQOHog2XU0C3bddUz8nUq9NZ7siAkXF//M37ogwXaUz6w5
 KZTyAozyWG8L07Ud2JODqhGU9dRR9woE5QQDB8foCulk7HWIudL6ccdv28BU6kjZ
 n6ehEne/7Fzy9VbL4MHh6o98EvM8lGIVW7kgRnyS0oDI/SwmslGxk+Wkx7/hWk2t
 +shBvRFZFQXPhRZIRqx+kcBlx6mfd9+9snHbt9f0gOa04/J0OEvFRS8goWWKfSn/
 RRHK79srNr/fK+sKlJwEeDSJRlEOJCc1yf5xx5P2wTLk25YNriJcDzz5SxOVdvvA
 HgvzkMTihEE4bUhn0kxQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjf231g2s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 21:09:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aodXxBpkYqgihe7EIAG5MhUTSWyMHDyGzstPLGw4qwD0ftAzoXLapA6Q18epyWJFn6R4MUzrSfyToF21qY5v9TXlKqqWk7agnqGbtWG75hriO/I2yDxcJkDWre6No1QJXHs7GK4g6kQJEnXSGaycRMO+a7ly9TfikpKHZh9LhgjxWVeyb4XJmBAercdVwQ4x4hWRscQp8fFnWeWYPSBj4+ZXARq7rQ4HHCvMtNoAxn4czB+ChR3SJuCBfCLdd6s8LXsgkAl4MrD8ssL9UskSEuktb3JfcDsU2dTjuoIfbrfYWfkC1VUwzOPqfVDcP2ojPn5cOmhSRfMckjUs/8OXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScTp7GFSC9vIXWSDsiohYSEaY1hGLKATyOUpAhuV9U8=;
 b=WX7NIwHyAYDzMlj4MxuveaZqULaFOQFfm4a/YtI+Wa/zwJVhBUJo97Tw4ytVioEBLGG5w+9eFfE11YQwWm8oKy3fx3+OIVk/v7fjLskcG4LxPWjR9I0Y76a6AFUsGkNo12B5QieAn/WKudn9ZV/Bmv9fBrpkCB3e4wVGWG8x04JkkuN1OfuDQpnJsEAJ6xjARQ1nDK45yAWujS2bk3vR21xOIysCHpJ0EVr96j/eevxZv2zmgWnYk8ExjaEOGQwERqPkI9jMyPuKPjEqFR/a+eU/6GpqXyE4pOLW3Viy6QzAt/3aqueQ3MlGvIxymPi4UPv23gYuSEdyWGDtcO9Lmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by PH0PR02MB7800.namprd02.prod.outlook.com (2603:10b6:510:53::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 21:09:31 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::dfab:83e2:41:20c8]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::dfab:83e2:41:20c8%5]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 21:09:31 +0000
From: Brian Cain <bcain@quicinc.com>
To: Taylor Simpson <ltaylorsimpson@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, Sid Manning
 <sidneym@quicinc.com>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: RE: [PATCH v2 6/9] Hexagon (target/hexagon) Make generators object
 oriented - gen_op_regs
Thread-Topic: [PATCH v2 6/9] Hexagon (target/hexagon) Make generators object
 oriented - gen_op_regs
Thread-Index: AQHaK7VFYQooAyWvcEurcUQCB6yRZbDVTX+Q
Date: Thu, 11 Jan 2024 21:09:31 +0000
Message-ID: <SN6PR02MB42056B869CCD0B8186F35FDCB8682@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
 <20231210220712.491494-7-ltaylorsimpson@gmail.com>
In-Reply-To: <20231210220712.491494-7-ltaylorsimpson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|PH0PR02MB7800:EE_
x-ms-office365-filtering-correlation-id: 50024c12-d73e-412c-eb2a-08dc12e99ad2
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZEOLBBKwxEX23qSPvxeos7PQ5aiJOHOYYZYVcJ7ETh4aXlI/XNhtSydzVJ2PUf2v5z+wbKKBEtVYQ7+2chnrIlXOHtaSndtYMDnK6J/O/z6B7f5cIAA69GUFRYE9lv0R9Tq3CGU1nKci5Becmb5yFC4JlnQjhKMFE09pXLv6gbKY20UATuq1ukNfD8HrS3wDlS6QhE+8cnHftcF5lL76eb44F8G8BL0sIwkOaqz9Ds9ENVmcYakRTy/o9evGYWBbPLcMuXNEKgiaJWEPqC3hHWz82R9eaMDJEEJfHT6viQb6rCo9mMkA4MJyWAtlY8tLy0ZS1JUmKABNv7AAaNzGpr6aZXeyeh9iPVKYopEt6RAMZCnDo7rJ5Adq88Bbi600xwXbZjtsWo1lpA06vMwKx0ijPd+heD5j2I+XSEkESKE2W/YpLC4VTrY3pXLEvy7JoUJWEbqzKqYfp0mmuBlnE3hwZ9jf6KWQ/guqU7RyJISuT61E3+mStCoH2D6lcpgHTklUI6aoQAQ9kPyWAhh94gzpw/6l+o73XEN4eSSZty5V1zzIzq03i54S/ZuVfA2du02jUwXic2xP/VldWxsb5qbzP6F+FxByNGPZXo7eHXzzfw/RkYRMf0xDDuQMjTXUwlv7y1ZjEN306Zd/BC8YHzrjnICQ3GIfugqggMTpTao=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(366004)(136003)(346002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(55016003)(7696005)(71200400001)(53546011)(9686003)(122000001)(38070700009)(86362001)(33656002)(5660300002)(478600001)(26005)(6506007)(83380400001)(8676002)(52536014)(8936002)(4326008)(38100700002)(76116006)(2906002)(110136005)(66946007)(41300700001)(316002)(54906003)(64756008)(66556008)(66476007)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDRsNW10blFoRGNsWDVnUWsrR1VWK3EvSFFnMG1KQm54Kzcxckp1TGlFL1Qv?=
 =?utf-8?B?TEF4Ukt6cy9GYy91dHNSZGdQVkpHQW13Y2tSUWpqNWtVTms1d0tIeEpiMUZB?=
 =?utf-8?B?WWxEYkp3MGpIcTZ3SGdHK0N6Y1BNVXJSditDYkZMampiZ3NOT3gzYlplOE9C?=
 =?utf-8?B?Wng0bmJ5ZzhEVnl3OS9vZ2JnVE1hSkU3WmE5a3NxSG85a2VIYTVpRnhZWXRI?=
 =?utf-8?B?TFc2TE9aOW43ei9XV3g0cUI2V2xobjhHejRySCtBeFlQczcvd0xia1RBdG9t?=
 =?utf-8?B?VExpalNpTlZoVGsrQ3g5L0NBQWdNcWxLMnhJckpMekR2QXo1S0JjYVc2bUw2?=
 =?utf-8?B?TjJxK3FWQ1RiVUE4RU03eFQ2ejgzVENjV2lTMlR3aGtHait0enNZd3BINmpJ?=
 =?utf-8?B?cnp0QmtON3AxeUd0bFlRU2gySnVjRnh0a2RmNTgwNDQ4RUJucDM5VnpXOTFz?=
 =?utf-8?B?SU1JRkJEQzFkVEV4QmltbDhXZFdiRVdTWGlxa2FNNUIvM1lmQVU1Q3pmU2VQ?=
 =?utf-8?B?U0owQXhFcU4vUGFFTkJabFRDbnU1QTRLaTlUdUlKTktYWXVYTW12cm1PMnlY?=
 =?utf-8?B?ZmV5VGlFQkNGNmNHNUlmRXhEeHVVVEx6bk1NVkJwS0tXWFhPQ0Vjbk0zY01w?=
 =?utf-8?B?bHRFaTl5NUU0bDlFMTVmWG9wVmtTeWJDMkVTa2xLZEJiN2RaTXRJdHhhT3Aw?=
 =?utf-8?B?ZEl0dFZLVFpGMXk3T1VyWFI5R29IeU9Oa1c1MDBtSEYyb3lLaVh0YWZQM2g2?=
 =?utf-8?B?NW9jSkh1ckNseS8zbW91NVg0Z2c5MHlLckE5dmJGL001NlpYMVpEeFAxTWlJ?=
 =?utf-8?B?Z1h1QWhUVkNQdDBkT0hQa2FMamdpK1Q3U01qM3VnN2FTdkduU0Z4dVFaQW9m?=
 =?utf-8?B?TUZZQjVaQXZPWDFPTEVmWlVQbzJmRytNb3pWSUtBNUwyQ0tvRG9vT2VqN04x?=
 =?utf-8?B?eGtpYU11QmVlQmkrQ3Y0SVEwVENuaDJ5eVpOdTZCQ0RJaXVrTEpvZ2QzRmRG?=
 =?utf-8?B?Q2xQS2tBc1Foa3FZdVlSWW9jbS9vT3lDZWVmejFKdjNIaWRFV3ZjaWZYN3Jy?=
 =?utf-8?B?RGVvZkZBYWw5alZaL2lTcm5sd292WEFMMXVxNWRUc0t3YnAxVy9DVnhCbUwv?=
 =?utf-8?B?R2diM1k0RWlxeUN3Y1FZdGt6RDBHOU1VazRic3N3anl1dGlWTUF6bnVmbm9o?=
 =?utf-8?B?VE5FUWpYSWpCS2hPN2svZWdVaHdNUzhlU05XREZtVzFBbG9QczBheHFuQm5p?=
 =?utf-8?B?c3M2K0hTaXF2MXBremlMYmdiWS9XV0lrMERqQ0hRcGlEVTlUdzJuem0xM0gr?=
 =?utf-8?B?S0Zvb2EyRnhXTnhDcW14bGtiNGMweEZVOXZveUhvS3RDdkNmUW1wbm0zMi9B?=
 =?utf-8?B?MzdQQmoyM01VQyt1Um85a1oybUE2L3MzZFlkYTRBV2Nsd0IyQ3IwclZjUU5I?=
 =?utf-8?B?WlNMdXR2QVh2TWtrSkE2Z0FzSHkrdmdMaTRld3VWUkZPMis3SEJiNTNJSSs1?=
 =?utf-8?B?RzhuZzVSMzFnRlJId2cwMmRHNWRQMXBFUTAvd05oWVUyWFZvU0tpR1ZQUDNK?=
 =?utf-8?B?Z0Rob2hzUEwrYUtCSFozOEdmeVRoOVhCUlo2djhoREZ6eExEV09aWCtZTS9o?=
 =?utf-8?B?SXM1OEhBMXR2T1VYWCtRTVhYajZFb2JQZWd4cjUzL3lDV1lSb3laT09EZTYx?=
 =?utf-8?B?Z0hFQ2M4a1hLb3Z2bzRjbVhTbkFGbHZGVllTeWwrMVU1ZXY1eU1Dc3I5MnNG?=
 =?utf-8?B?Zlk0UUo2WGRMMXZHNWNESlZJOVM0YjVsWml2RUc0T3ZjRzJFMnplLzZsb2N3?=
 =?utf-8?B?SjU4NFRXWDk5akRMNHFXSE1ibnFmT3FPWk5qakUvdU5YUWpQTC81SUxoZy9D?=
 =?utf-8?B?cmk0VDFmdEpTYndCL3BkVGd6WkwrZjZtelc1eFp1Y1dGbnNWOE1vNE5hdEc0?=
 =?utf-8?B?dTMwajYrMVcxUGJCZnNPUVN5NUNDNVBzeTU0dUc5YVhEdysxeHIxMnpTNG5E?=
 =?utf-8?B?WXUvN3Rra1NEemNoUHZCeStDOTE2Q01vajB0ZzJ2UUlxVmw2aGRrbHZBZC8x?=
 =?utf-8?B?aGZWSlpPY1FKeUIxVUo4N3J2MGhuYjFnaEVzRUZwekNDVVN0SXVwM2ttTy9N?=
 =?utf-8?Q?6/Us=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VzJE38uDM40RJEv/OymThOv+9sVn7gkwMCeM2zemKkRetGRRY6+4dnxs5RIXl2HbIq9drss8apAgxk+s7Uufb9fp0TlCdJWTxBJQsBmFJpOG3UuvHTKCMlOI7I3vIrK9PURC62JGe8mVbTXx+sm/RtusbuF1U/L56f9TVCLVgYBBWD4YxN4FwZBhmgqK7KFF7mQfpcIfuSDsuyyh8/XnOVzGHaG48GfPJjDBojDD6tqlKMHLaztx9G3RTOGLY7lARGPhB2Tgj+LqHdpkkDAeE8ePF3d2cTM7CAsJRj4IqwiNdLNaDWgoM6MXZhMPFiJcdm68nta2kzSs4PyqaW/KhEUGAljEfI8ie80KZsgYOiU3PaZJFVDaKRrBV6nwjVPzbtx6mKy45NaRnL4ZyoalSb2swY1nfFKOSHdd4Iu9lHhldwbgN1d6JI6+b2UQiq6RJJqJNYdk8ruu8AhwxBeEdhhveNUqnSGbyWm5L5RcJ7CdEnv67QlUNrV/EmeyOhzY97OkCqu/q2Cemk/FwCz/+FJRv+dZ1GGoP+oZBIqHGvpxnI6QHlFHztNaXd/zlM0dU6AQKOJcBT2wJTLSSB3tXj7g6u1bFZiv3NM3fS30rIClXHtwjXgn5ZlOCWnutpir
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50024c12-d73e-412c-eb2a-08dc12e99ad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 21:09:31.3767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M96Sc4HV1E8szNHgzE1BKs2o4n7Q3P8g9crYJSglha8JVoppOTcvhpSRfet/5MFuvNXUUGCkzquRQxSkZsUZAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7800
X-Proofpoint-ORIG-GUID: Ib2qEnJ5T4m6XThWP7Wr1QtJBZZZQT23
X-Proofpoint-GUID: Ib2qEnJ5T4m6XThWP7Wr1QtJBZZZQT23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=410
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110163
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
VENIIHYyIDYvOV0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIE1ha2UgZ2VuZXJhdG9ycyBvYmpl
Y3QNCj4gb3JpZW50ZWQgLSBnZW5fb3BfcmVncw0KPiANCj4gV0FSTklORzogVGhpcyBlbWFpbCBv
cmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkgb2YNCj4g
YW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3MuDQo+IA0K
PiBSZXZpZXdlZC1ieTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+DQo+IC0tLQ0K
PiAgdGFyZ2V0L2hleGFnb24vZ2VuX29wX3JlZ3MucHkgfCA2ICsrKystLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9nZW5fb3BfcmVncy5weSBiL3RhcmdldC9oZXhhZ29uL2dlbl9vcF9y
ZWdzLnB5DQo+IGluZGV4IGE4YTc3MTIxMjkuLjdiN2IzMzg5NWEgMTAwNzU1DQo+IC0tLSBhL3Rh
cmdldC9oZXhhZ29uL2dlbl9vcF9yZWdzLnB5DQo+ICsrKyBiL3RhcmdldC9oZXhhZ29uL2dlbl9v
cF9yZWdzLnB5DQo+IEBAIC03MCw2ICs3MCw3IEBAIGRlZiBzdHJpcF9yZWdfcHJlZml4KHgpOg0K
PiAgZGVmIG1haW4oKToNCj4gICAgICBoZXhfY29tbW9uLnJlYWRfc2VtYW50aWNzX2ZpbGUoc3lz
LmFyZ3ZbMV0pDQo+ICAgICAgaGV4X2NvbW1vbi5yZWFkX2F0dHJpYnNfZmlsZShzeXMuYXJndlsy
XSkNCj4gKyAgICBoZXhfY29tbW9uLmluaXRfcmVnaXN0ZXJzKCkNCj4gICAgICB0YWdyZWdzID0g
aGV4X2NvbW1vbi5nZXRfdGFncmVncyhmdWxsPVRydWUpDQo+ICAgICAgdGFnaW1tcyA9IGhleF9j
b21tb24uZ2V0X3RhZ2ltbXMoKQ0KPiANCj4gQEAgLTgwLDExICs4MSwxMiBAQCBkZWYgbWFpbigp
Og0KPiAgICAgICAgICAgICAgd3JlZ3MgPSBbXQ0KPiAgICAgICAgICAgICAgcmVnaWRzID0gIiIN
Cj4gICAgICAgICAgICAgIGZvciByZWd0eXBlLCByZWdpZCwgXywgbnVtcmVncyBpbiByZWdzOg0K
PiAtICAgICAgICAgICAgICAgIGlmIGhleF9jb21tb24uaXNfcmVhZChyZWdpZCk6DQo+ICsgICAg
ICAgICAgICAgICAgcmVnID0gaGV4X2NvbW1vbi5nZXRfcmVnaXN0ZXIodGFnLCByZWd0eXBlLCBy
ZWdpZCkNCj4gKyAgICAgICAgICAgICAgICBpZiByZWcuaXNfcmVhZCgpOg0KPiAgICAgICAgICAg
ICAgICAgICAgICBpZiByZWdpZFswXSBub3QgaW4gcmVnaWRzOg0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgcmVnaWRzICs9IHJlZ2lkWzBdDQo+ICAgICAgICAgICAgICAgICAgICAgIHJyZWdz
LmFwcGVuZChyZWd0eXBlICsgcmVnaWQgKyBudW1yZWdzKQ0KPiAtICAgICAgICAgICAgICAgIGlm
IGhleF9jb21tb24uaXNfd3JpdHRlbihyZWdpZCk6DQo+ICsgICAgICAgICAgICAgICAgaWYgcmVn
LmlzX3dyaXR0ZW4oKToNCj4gICAgICAgICAgICAgICAgICAgICAgd3JlZ3MuYXBwZW5kKHJlZ3R5
cGUgKyByZWdpZCArIG51bXJlZ3MpDQo+ICAgICAgICAgICAgICAgICAgICAgIGlmIHJlZ2lkWzBd
IG5vdCBpbiByZWdpZHM6DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICByZWdpZHMgKz0gcmVn
aWRbMF0NCj4gLS0NCj4gMi4zNC4xDQoNClJldmlld2VkLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBx
dWljaW5jLmNvbT4NCg==

