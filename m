Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B89C97FFCCB
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 21:40:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8npC-0003Hx-MZ; Thu, 30 Nov 2023 15:39:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1r8np6-0003Hb-Jg
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 15:39:48 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1r8np3-0007h3-DL
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 15:39:47 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AUFVOsL027241; Thu, 30 Nov 2023 20:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=zdJnuOpyn5Bp8UIzsnxVCg5X77bJE8fNfAy/L+Ae5Lk=;
 b=Uo6aeJvzcJLRszHxqSb8hq7aiOmiJxEsvsOEfUxd5zuqVQe8WzzOJcLPapcUUAIkKjkk
 lVZOXHlkcBlnKD6NCXYAgXhRThStCxHCLQtKMFMnbJpGddAvnWaGd3FvmHvIlRIaRtpZ
 o84CdPsPyc9BgKgF7PJp0VjtUth8oDhAcwMS3fYlzwwtYrlhrPO+r+innw/W0mhsLYr+
 5F8BUSNerCNCd59od3+r+fIEUHpB2Rwx79qgRY6hCDvmieLRnmKouU5WctZ9GV6uy1iq
 lIAHPNqFpMyzXmlWeDzBJX3fEk8/5+dTPG/QKydCKpwUQT8zgCCiq56z0ddHKNWjdNZ8 nQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3upvm1ryfy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Nov 2023 20:39:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i38VkIzD3ujclIfaDeg0F8hKXeceZ2Zs3f1Gd9EOmadJOrpmzap9yS4e13xTfc4aPrQwhrWasVrPufyCyamhX7A1X7dNMHSwBOjIZ1PSJvtVP48np5egPcZ1PVnBsPvRDG3uQZTCTdq85M7YGdMuIFAlLdhS5sFsW9yLCtbTtVBvPWC979GjuFYVb7ulmzs/vEfuNqn8lA8SgwlsM19odBhDZCsPDOgDMkiRLmfLsdJ4KMSeKWpRTGXbvDry5aK0Tj2d03bcJBCm0K5bFkYVraPXscDI/DxpCod2opahb2kr1vZjLNuo6LzyYdca77fS7sSd5i9CL2SivuF0gIvf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdJnuOpyn5Bp8UIzsnxVCg5X77bJE8fNfAy/L+Ae5Lk=;
 b=EGJZ/mz9aql0zeKXbu2VxMVSxqS3Gu4ubxN97tEhjQHHFpRIfofB4UUF38AYuyFHz9amnZ5dhKBRFrk0NtWP0zidcIpeyaFz0ChDzErhtKvYbTbhK55bAHNzgNN+kQg9QxIl3ChkzvRUv/6hpyrbv8pPy+r/d1YtTRXAWb4+Yj7LUWpY/nwbrXVtzOHRMSK/KTkMJ1FlgQBo0++8TM6oenMfPclV68e1qiELqKr0ZciS1MzLj/bRFjgbL05Z3srBWTElVlOO4aeqN4NZ0PdljNxn7j4+B+6UmdKX4F55m46tTgoFaYcXzcJF/YQuzEwFjH8ieu6c4RExz0TB0XCP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by IA1PR02MB8900.namprd02.prod.outlook.com (2603:10b6:208:388::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 20:39:39 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c%6]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 20:39:39 +0000
From: Brian Cain <bcain@quicinc.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Taylor
 Simpson <ltaylorsimpson@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, Sid Manning
 <sidneym@quicinc.com>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "ale@rev.ng"
 <ale@rev.ng>, "anjo@rev.ng" <anjo@rev.ng>
Subject: RE: [PATCH] Hexagon (target/hexagon) Fix shadow variable when
 idef-parser is off
Thread-Topic: [PATCH] Hexagon (target/hexagon) Fix shadow variable when
 idef-parser is off
Thread-Index: AQHaI7yhMiQWAo4Zs0aWvFDA7cRChrCTTNeAgAAFz4A=
Date: Thu, 30 Nov 2023 20:39:39 +0000
Message-ID: <SN6PR02MB42057D4FC09929723903517AB882A@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20231130183955.54314-1-ltaylorsimpson@gmail.com>
 <36fe2c1d-4db6-498e-a7ce-da74410b4a03@linaro.org>
In-Reply-To: <36fe2c1d-4db6-498e-a7ce-da74410b4a03@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|IA1PR02MB8900:EE_
x-ms-office365-filtering-correlation-id: 1d532352-fc17-4578-b3d3-08dbf1e4792e
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VTqsrSe0tfg+0UAH+AINGr/O6tpNBPFnCdeaTcwi28p0q6OrbnBUeulXC0sYaT5aYcdO8uQ7tibQASLby9Zt9yatnJoOBkF4Cuw4ZEwN4wj0PMJmfuD+GnALtJXC2I0qahlUEh6EqO16i2jFNHZR0cRBIUA+4AwiXBlStG6tNyjo7PEMkDbee+vkn/i8fIU4EHwBzW6Iu285ijkruKx0GdRvx8qJZ/cyDbXRPvW3T+dAy+OIkZSx8x+NeB5YQnrChqADt58d5WldCrdX/w5XxLw7h6X2Ju0n90lSqVKx2dFRuFjQIW/9+3+HePdxRHFD4YS/7k4hVAemsinakIRrPq6PDZNIHXhH98jqtj9txjnHZ95C7sY8gAjAMsgBBnffyYd+FlWG9FNPDD8NbS+OAG0LkVHdiFlcceLZ5S7RGW4Nsqe38Hc11HD76c6DbH5WS8n6sskvNLLDF7T4ffr27TtjhZ3VXPqPdYOagDIfV6tUIxkcFrWeJZ7iCq3Fsa1q+Yf6W7c/xnFS1E9u23fgcc3iJYkG/KnTiZNOc5Qo9H2di+Jmn4J/ckq5+oLuKXR9Ub1QBK4jcix8K7iJdNJfQnVJduO5EiXOoLqtGAAMXE+NwrUp/m4+xAVHlM29x/V25R9gfI1WB5hv4ult5oMEbKIgq/fRTaR/mZXuk38TG0I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(346002)(136003)(376002)(230173577357003)(230922051799003)(230273577357003)(186009)(451199024)(64100799003)(1800799012)(55016003)(478600001)(7696005)(53546011)(122000001)(71200400001)(6506007)(9686003)(38070700009)(38100700002)(33656002)(66446008)(66556008)(41300700001)(64756008)(54906003)(5660300002)(66946007)(66476007)(76116006)(86362001)(2906002)(83380400001)(52536014)(4326008)(316002)(8936002)(110136005)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGRZalNaOG82WUNFRUs3OW5ZU0RBWlNJcVBTK0F0cnpLNHg3ZExUZktEcStv?=
 =?utf-8?B?aEdlSGcwaHJSMFBNUFlSMTR3ZlFPVzBPN3ZYWUtRdlVwQ3JOc1N0SlEwYkRR?=
 =?utf-8?B?djdub1dtOW9WbnFXa3k1UW5ySWRadjlUQmVJcTdjMlQxQnN0d1BGS2VKYzQ1?=
 =?utf-8?B?L0I2MytRN0pzN2RKMzZwS2ptK2dzeVpQeFZVd25DSWlUQ2FZN2E0RzE0RUtQ?=
 =?utf-8?B?UXNsRExlakt1Z3QzNGhXbTdxTm5lMmIrQ3AxVHBLV09kcjdUSVg2QlowbUZH?=
 =?utf-8?B?Rk5wakkxNHpBczRmQzNPTlZ2dFNDREYyUWFpWjZpalBRVUt1S2JsL2w5MllQ?=
 =?utf-8?B?T1hNbG9YZ1EwMGg1SjBmbWNYWTZXQ2NkdWZzdnBXb05xY2x2eDdidHF4OGtO?=
 =?utf-8?B?bGFtRnJ1NitIeHRJWCtmUVk0OURSbzFnZEdOeXBKL1JKVXJad0dDd0ZCWXFY?=
 =?utf-8?B?NjhTNGJNZU9EYW5qajVMekkvWm9NWVI1MVphT0VtWUQ4anp6REZzVitNWFpS?=
 =?utf-8?B?YUROR0wweG5WdGthVk4vdElKaHpUVENMMWVKZXg5L1RaaXdRa1JzWGRkZExL?=
 =?utf-8?B?T2MxMWY3dWJQUTBhUnA3TzV3c3JHWGp1bGJhd2lycTJPaGh5Rm9nb29HeGtF?=
 =?utf-8?B?b0VYRVBVVnVnWlBwZ2kvZTZZQWxKN1g4aktPUlhoc2prK1FuY0dVeGdveERL?=
 =?utf-8?B?R1pVQ29aRkw0ZmRNL1owUVdzMDBwaWJVNjNoYXdldjdZOEFPc1hmdkJ2Qmhz?=
 =?utf-8?B?OUw2bUEyR09sL2hReUxCMGFXc0hBUHROZURVeXYrNHl5bEYyK0ZDSTlzWElM?=
 =?utf-8?B?SHhSMG1Wd0VNN3AyTjlGQlo1akxMYlhuMGNVN0dacm1pKzFVYVZVSG9Rd3I3?=
 =?utf-8?B?eGxZWXJaNVk5aXlGM0JYZU5xYjZmdFNUZko5eU95a2RpMlErTitTUWFFWnRT?=
 =?utf-8?B?S09WUXhobHZqbmlpc2U0WE05MGZFanJPbHRyQnNFMVRKZHpIc0syMmsvbTNS?=
 =?utf-8?B?d1prYnRxUGFrNFJhZ0NOdW5oRDFWVUNFVEljU0JpTDIxUk01b2xIeXNXcThz?=
 =?utf-8?B?M0c0TnhkNm9qMTVvd0tMZm0vNk8vOElmRFEzRnhTVVo0Q3ZoRXUzZnFLWW1O?=
 =?utf-8?B?WUZreVdzZHpvM0UvYWk2aFdKQWRuVGVoUFRwcElsWXpROTZyY0RJK0VEZlp1?=
 =?utf-8?B?SlNwdFJEMzVVYnhzdXU0OFBDZFByek1ISGdhNy9Bd3FxTlVJUlZWcWNtM29r?=
 =?utf-8?B?WTRicjhKYVZVNHdmNmZ1K1FFQ0duNlJaSThud2kzbzlTUUtCZ3BLQm9saGJW?=
 =?utf-8?B?YmViZ3R6dWZOd3NWZHJqMEV6V29VQ0RJWVpvOFhWWlM4c0o4WnVJTFZWNFFB?=
 =?utf-8?B?dkFyL3FUMHcvaGtkZCt4Y000M0psNUdRc0pyWi9ZSi9taHE3UUszZlEyM1lQ?=
 =?utf-8?B?dlB6by9MVjU1ZnFvYStYY21La2t2MWVpbUdjeCtpazRWaUpUSUpXM09oemVC?=
 =?utf-8?B?WWVOUmFiYnhDMXFrU2VzMFFodUluY1ZjSE02LzBWM1c1ZTFTWlVJRm1wb01K?=
 =?utf-8?B?QjB6NGVGMWdSN2I0SGRUNjgrVjh5QXNvMlVnUVRHNmdCWmoyRkhyaDNSVG84?=
 =?utf-8?B?M2o3aU1veG42a0Z5Z3RjeVMvYitiMGpvNEs5OEg4NEg2blJScGhmUTFXcVJE?=
 =?utf-8?B?RXZEVTNpTlNGQmFxdXZSd0ZoL1NnT2FUbjFXTUI3SlQ2bnc4L1ZMZE56S2Zw?=
 =?utf-8?B?elErV0d0R1BOK2p4Z1hiazFMYXVvaStrUmQ0OE45c01QZTBwZG5KcXdRcUVH?=
 =?utf-8?B?UkFabHQ4eEZBb0pOU3AweEg3L2VWdkJkSUhuL05Yalc1RFREYU52aTZ1WnZZ?=
 =?utf-8?B?emNMVFNMdVRWM3M4dUtUbE15Y0RoTHRxNVFjQ2Nzb09uNERJbEhVQmtNK2Jj?=
 =?utf-8?B?MmRBU1F5TGRxMUZESDNmbzVqU0xMOEwvSGY2d1RzRHVlZmN3andhTExMYXV4?=
 =?utf-8?B?OXNJTUJjYWZZdHlXL2UvRzdoZ0RDWGwzeVpIQWdVQVdJb09FZmNwTjZMaVRt?=
 =?utf-8?B?S1NvODF6NnRpUjhEUXZCM2FYNWZWa1ZZRjVIeE5TTG9sTG9aZ1J4eXNySEVr?=
 =?utf-8?B?RWFZL0ozK0dpaTRwWi9BaWRDdXJ3bVh4andJYUJIM0JzaE9VN24wN2pHaGVU?=
 =?utf-8?Q?RKg3G3+3Cwsl0zaUT9ec8W4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f9ZcKtdVasXSBRN/YhiiU9nXTtHSHi4ia6M42UKf6gOmQSWD3XQVYS5DP1pn79w7ceWY+HqoITGkp7eMIsPz/tca3baRQ0SQTTuhYOLB2IffV6FPQcc4YyVoRFAIA5EB9Nm4HyOu9XTSiCRPF6toTdg+nyloue1h9vvUzE3RX6awa3hpOataZE+mKLAQYwKa0DX71nZ80aiJuZ45gfDv70Ba1FrM0l9UA/mw5vVAkhU2PV4DeZ/vU/+n1UKmD7wIiODeUZ2nNsBsAWYW4eH30Hv3QDQ50bhkt4tLl6ysg5RFaDsSjvTIAKLxXuUDDxwIGmAWbMDMcBUMOavLdaht1tJc+KI8KebgjqRuBo5OQUDUihncVDDzYlUtftaAK4hsLi8E1cz1Bjb/O+UKn8PR8bNDQc5IUOAe+fwDFlhwL4PQliUAOzic2e/imYqOO4Pobf42UAW1g3jowxyan9WjANZ3N2iMIXu06a+NYBYHHLVzI0I2ZJN4AAJIV6VWYqPkWPLENU/pVYdlI5/JCqqPPef71GbYPJPYVGd61JE4RED0lPOVNSsGm9KqomBFfQvELUaxWr6WxOXyyAY2c50DigxZzRaA+jf6LQxJ71IqSmKeuMlvAhjk0y9m/nL6020u8dF0LBicByDEB5EBN9shhoYPQDdkZszHOGIwe6I0QrK/GIERmiB2Voi2N2KGnxDILKgt8RK9QwirpHPiIcylctAvsIxr43nxyEmibtNQA4XSFqNiokvoa6ca/VM+RS+/GtAv73wMOxffBmKQvlIJ8/wvC/zWPR5BeUWFwfgj5rgFfs8QI5Q0J6oGKBfo8SBexkidBVhdWNaSLs3nf17RJQ==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d532352-fc17-4578-b3d3-08dbf1e4792e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 20:39:39.0965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A+QH3NdYJtrsc0y65eEkAgJwheFwMyS2JEakVzVxi+1IrLtT2TmwuLMNj4LRumqr84DjnXrElfk+sA/E4lvCfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB8900
X-Proofpoint-ORIG-GUID: G0bOq0aWKT7wLhkNleo2h_Nd7PNgULKq
X-Proofpoint-GUID: G0bOq0aWKT7wLhkNleo2h_Nd7PNgULKq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_20,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=905
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300150
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIg
MzAsIDIwMjMgMjoxNyBQTQ0KPiBUbzogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdt
YWlsLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogQnJpYW4gQ2FpbiA8YmNhaW5A
cXVpY2luYy5jb20+OyBNYXRoZXVzIEJlcm5hcmRpbm8gKFFVSUMpDQo+IDxxdWljX21hdGhiZXJu
QHF1aWNpbmMuY29tPjsgU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+OyBNYXJjbw0K
PiBMaWViZWwgKFFVSUMpIDxxdWljX21saWViZWxAcXVpY2luYy5jb20+OyByaWNoYXJkLmhlbmRl
cnNvbkBsaW5hcm8ub3JnOw0KPiBhbGVAcmV2Lm5nOyBhbmpvQHJldi5uZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgRml4IHNoYWRvdyB2YXJpYWJsZSB3
aGVuIGlkZWYtDQo+IHBhcnNlciBpcyBvZmYNCj4gDQo+IFdBUk5JTkc6IFRoaXMgZW1haWwgb3Jp
Z2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5IG9mDQo+IGFu
eSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPiANCj4g
T24gMzAvMTEvMjMgMTk6MzksIFRheWxvciBTaW1wc29uIHdyb3RlOg0KPiA+IEFkZGluZyAtV2Vy
cm9yPXNoYWRvdz1jb21wYXRpYmxlLWxvY2FsIGNhdXNlcyBIZXhhZ29uIG5vdCB0byBidWlsZA0K
PiA+IHdoZW4gaWRlZi1wYXJzZXIgaXMgb2ZmLiAgVGhlICJsYWJlbCIgdmFyaWFibGUgaW4gQ0hF
Q0tfTk9TSFVGX1BSRUQNCj4gPiBzaGFkb3dzIGEgdmFyaWFibGUgaW4gdGhlIHN1cnJvdW5kaW5n
IGNvZGUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNp
bXBzb25AZ21haWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgg
fCA2ICsrKy0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCBi
L3RhcmdldC9oZXhhZ29uL21hY3Jvcy5oDQo+ID4gaW5kZXggOWE1MWI1NzA5Yi4uZjk5MzkwZTJh
OCAxMDA2NDQNCj4gPiAtLS0gYS90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaA0KPiA+ICsrKyBiL3Rh
cmdldC9oZXhhZ29uL21hY3Jvcy5oDQo+ID4gQEAgLTkzLDEzICs5MywxMyBAQA0KPiA+DQo+ID4g
ICAjZGVmaW5lIENIRUNLX05PU0hVRl9QUkVEKEdFVF9FQSwgU0laRSwgUFJFRCkgXA0KPiA+ICAg
ICAgIGRvIHsgXA0KPiA+IC0gICAgICAgIFRDR0xhYmVsICpsYWJlbCA9IGdlbl9uZXdfbGFiZWwo
KTsgXA0KPiA+IC0gICAgICAgIHRjZ19nZW5fYnJjb25kaV90bChUQ0dfQ09ORF9FUSwgUFJFRCwg
MCwgbGFiZWwpOyBcDQo+ID4gKyAgICAgICAgVENHTGFiZWwgKm5vc2h1Zl9sYWJlbCA9IGdlbl9u
ZXdfbGFiZWwoKTsgXA0KPiA+ICsgICAgICAgIHRjZ19nZW5fYnJjb25kaV90bChUQ0dfQ09ORF9F
USwgUFJFRCwgMCwgbm9zaHVmX2xhYmVsKTsgXA0KPiANCj4gRnJhZ2lsZSwgYnV0IHN1ZmZpY2ll
bnQuDQoNClRoZSBmcmFnaWxpdHkgaGVyZSByZWZlcnMgdG8gdGhlIGZhY3QgdGhhdCBDSEVDS19O
T1NIVUZfUFJFRCgpIG1hY3JvIGNvdWxkIHNob3cgdXAgaW4gb3RoZXIgY29udGV4dHMgYW5kIHRo
ZW4gY291bGQgc2hhZG93IHRob3NlPw0KDQpXZSBjb3VsZCBjaGFuZ2UgdGhlIG1hY3JvIHRvIGEg
ZnVuY3Rpb24gb3IgZXhwYW5kIHRoZSBtYWNybyB0byB0YWtlIGEgbGFiZWwgZGVjbGFyZWQgb3V0
c2lkZS4gIFdvdWxkIHRoYXQgYmUgcHJlZmVycmVkPyAgT3IgYXJlIHRoZXJlIG90aGVyIHN1Z2dl
c3Rpb25zPw0KDQotQnJpYW4NCg==

