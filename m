Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A81F70E414
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 19:57:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1WFg-0008LN-BX; Tue, 23 May 2023 13:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1q1WFW-0008Cy-GX
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:56:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1q1WFT-000537-64
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:56:41 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34NGIxmK020730; Tue, 23 May 2023 17:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=NdvwR/16OW7gpOuK1eyG7X+l8IiL49mEhMJTfMbdPQk=;
 b=fvz0tXy98yHsf/FUFjutA+OOZxiLOdLv8V+MKbknkLJk4qaepku7voUMofQqFKQHymWl
 0liikZG9apJmL18ua+TWVvus3Bt/KuZit/Yvr9kXgmo+aPMWdajv7ntCsiiafE3N4pEU
 4mwYsELRfXGuVXBSXWOzc+oTzlkvJO9VVts8VB11e/3HFQWZT9z8SNsWSWxIrglrsW+b
 5BJPT+LsGtNwsYTed4WB8TLT+N24RNuZnD7In4z6JF0saW7e28y+gTu6W71L9pKN7tM9
 PVyLTl8npuK514yRNufY1igthvR1d/9XcVomlhKsPiim2qw/jsDSAdD2WgnfLz1cOHro 0Q== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qrhb0jgtf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 17:56:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwesDMXo37bJxKCzxDTBDun+SkWe3Wdhu+hLqOi9zTs4Jv7HE4HaJr1qAlj/REKWeg4AVYcUFLxoDLsFwdMJOEc+zY8gCFK+tpeQsDt90jqywktlTpGDG+f8FRb7Blf5U1Sqxa7LyoZRkTjYNMA/jMXHQjEtr17csC9aaTlrnrXx2acXCM2kbrgsfKbFhVR/3SJ+CRCKtgsZ7Ptybmql+RYZTX+vWIunUGKCTPgE9ttbWvZmmtF28wYEHjPE/igo4SkaFVWDB9BLNSsXySgfWHmF1V/b6j6iys1uGbYoSbPJewOHKZJSv0u5AFloEEfghzX5zdY7NWmmv5+6ghrbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdvwR/16OW7gpOuK1eyG7X+l8IiL49mEhMJTfMbdPQk=;
 b=HHk/BLY6LMvfe45p7cdkyzuBr4rSnudSS3KaTO+aHmk7pleII4nGjiKbSexij5vJIJQ9qUDG+uELIoot0PDPp3oZv4CQKi994p5MlX9FU7jGfg1cKju7VNAyAbOFMSrUDJdzzlz8xgbCLn8KolnuTltV2duh6SW7snRIolRx+6NetehiRp927qKgvGET3HkKMzn64qJPe9JPQteQDxa1H/u1Mve7jabKgQWcZl1C+I5tMlka9SbUcpL554rsPsefKmt2fesTlAO9cg3RrVjf2x8mRdzByLpGNDFKpgVlxe9PVitiRsg42rV7cuEq1Qf73KTm5PpF10OpZ2oXXH8qHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by CH3PR02MB9858.namprd02.prod.outlook.com (2603:10b6:610:17d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 17:56:33 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::d992:f4f7:1e0f:a51c]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::d992:f4f7:1e0f:a51c%4]) with mapi id 15.20.6411.025; Tue, 23 May 2023
 17:56:32 +0000
From: Brian Cain <bcain@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "anjo@rev.ng"
 <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: Help finding Coverity defects for generated Hexagon code
Thread-Topic: Help finding Coverity defects for generated Hexagon code
Thread-Index: AQHZjOuqbmx+DZQNZUmc3x6Py8z3gK9nlQgAgAAUCYCAADJvgIAAIgsAgAAdJ8A=
Date: Tue, 23 May 2023 17:56:32 +0000
Message-ID: <SN6PR02MB4205B9575465FDD1A6A2F898B8409@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <6467d9133bd9f_57b172b16e2c9d98835043@prd-scan-dashboard-0.mail>
 <4ffdd486-ec7d-49c7-1330-0d0b090735b9@rev.ng>
 <CAFEAcA9ZctmXrCAwsAk6eBeF4ojB4QBwq16TsdcGZPHTin6LEg@mail.gmail.com>
 <CABgObfa7N+A=ReW-jme=Nx+wt7rZPcpuy-ANmxepcJMxeXeeWA@mail.gmail.com>
 <5de92654-52e3-6042-de5e-b2334b737c13@rev.ng>
 <57f69ad1-2546-535b-75fe-f5e3d858504b@linaro.org>
In-Reply-To: <57f69ad1-2546-535b-75fe-f5e3d858504b@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|CH3PR02MB9858:EE_
x-ms-office365-filtering-correlation-id: 0d28ed1f-615c-42f2-d3de-08db5bb70afa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2J/QHRrDtOEGppBlzWYopuLsVJDHkEay/UawFDu4dLC2g4kjHhXrvkpurG1LWiAPaQBTlmS9U6++HyWLjMNUAwXOY7lznThS0RnE0oxTIfsDdB56DZG1Nwi0YifUTWylFNJAbGIZMy8AgBt37WBPiEqLDjCc/bmXU53g0G5skb0mk4zkc+aSFVAl0o39SgC5zbD8v0HHcqcwPFzJhWvYHSn5aCZELNqD+pXivIlcr16E63cBrsniLgozXWEEdBMu7Vdeq3jZ4gnGPj+PLcPeQXWyjpm9jX/qIxWBPI/PZS8npP5Tg0BFilojrOtiPSyP78jgNQwAux1KvfZ+nTzmNVspuwWYzUCUy+zvxn6hfrNuuRXodIlbNJPJpXTR5yGKQnxJYJqmY1ThywBOXZpHXeOlCZ8Dg+kQgUGn2CI+hhAzbD5gap2z6ztnDnkYkgmvX2p0fEy5vx00XI7MM6Um4pIb5xU9iMs79MayFM+kCXEq6P2HYZZI9tkmToNHRcTJ7yCcRpredt6LynEQM5GOI6Q+PhsjzgYbWHbrV56M7Qk+bz/7s3n1asxzsPtOVPDD+NRamBDnjL9jXtOpv2/zpZcYlS/Uttsehi9MjDD4Lvohbr8Jzf9DWn20puSViY7Z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(2906002)(110136005)(5660300002)(52536014)(8676002)(8936002)(41300700001)(76116006)(478600001)(66446008)(66476007)(66556008)(66946007)(64756008)(316002)(4326008)(71200400001)(33656002)(7696005)(55016003)(83380400001)(53546011)(6506007)(26005)(9686003)(38100700002)(122000001)(86362001)(186003)(38070700005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVd0cjdvY0pVQVpRTkhwdE5tbnJqQmt0RFR4bEk5QkszVlhJK2srcjRtZUFt?=
 =?utf-8?B?MlJ3bHpVYmtxT01uRjRuK2NRcUQ3RlpWK2RSRmg2V1NadDJqWUpubkNKbCtw?=
 =?utf-8?B?QnhhZWpBL2pOR2MvSHpkdkt5eGM1MWwzUExHMHNFVUJ4SW1oUWpBaXFjcFlK?=
 =?utf-8?B?ZDN1VDB4UklUeFZkV1QwSzc1c2gvK2g4Lys5Z3NBYTRJZ2J0eTgvaVpYSUZM?=
 =?utf-8?B?bFlEZTF3MXk5cEdwb04xdG4vdFdFZDdnVE1FZkdXRWtmdDYxOFV1elh0cnN6?=
 =?utf-8?B?cVVqN1lEaC82U3ZrYk1UNWgyU1dPbWpjUG9ISkgrUnJyN2t4YUZ4VElXZGRE?=
 =?utf-8?B?d1M5RkZXeDNZdTkrRmxCOW42R1ZZTDExYnpUNWUxbm5XZW8yNXJ2WWJ5ekNB?=
 =?utf-8?B?WDd4WWlxN2JFTXpvU0RNRzVxcjFXcFBQK3pRMkduUkFlck5LNlBMWHdrck5N?=
 =?utf-8?B?MHVRUWZha2tYLzBYWWY3c3pRNlRYTW5KTWZjNjZTYUFlSnZKdFhrYjEyT1Ex?=
 =?utf-8?B?TytpcnRhd0lhZnlNMHA5c2RjalNvOUd4aXlaNVVhNWVaN3pja0R3L3Vtbnpj?=
 =?utf-8?B?THV5dWE2TXJSUHd2QkFLUVhucVZoVkhmZGFPTlVPbEE0SFRDQlg5MFdiUmha?=
 =?utf-8?B?WTZCRnFIR3JJcjAyU2JLSWMzR09jOFhaRnN4MTNKVm14dTdlQ2tHeDJsSnZR?=
 =?utf-8?B?d2FLNHBIM2dha1ZpR1FWRXJxR0p0VUNaeVExQ01xV3ErSm0rOGVJTlp0Uy9o?=
 =?utf-8?B?M0NVM2s0L3JiK0JMaTYydDQ5ajNpayszOEtlL3NHWGpQeGl1WnFhNitSdGZZ?=
 =?utf-8?B?Skd6VjBWL1pvcDErK1VsYkVsVU5Xc1VhU09pb1B6TW9uYkZrbDJsNnpyak52?=
 =?utf-8?B?NHZRNGRlUjg0Z2tZL3g1Z1hsdXhkMkJJb0p2VTRWQUtsWThYa2JKVU5IeS96?=
 =?utf-8?B?VjVJanJGdmlKQ2Rzbk9MWXhOSHRGa2VXdzJBMGVmbTh5TFo5L09FVmN6dzR1?=
 =?utf-8?B?dncvbExhaTBPR1gwa3c5cysvdG83VmtNVkU4YjF6TVlEQWdFbjkveEp3bVd3?=
 =?utf-8?B?d0dqb21aS1A0STJtbnQ2Zy9zYjJKSUI1VFZBdG9SckhTYm5FVEFRQ0loYVZL?=
 =?utf-8?B?T1Y0aFQ4SGZyc2gzWmY0RTdMZXBvUmVHMDlBT2VrVi9IQ3c1S1dXVXRXeStJ?=
 =?utf-8?B?VFJWNERLOTIyeFlOWHA4QnMwZG42N24xVGNUbjdta055WDhCVnpoRGlzb3l4?=
 =?utf-8?B?TVQ5Rzl5R01GQ1JwMHNPRWVDMVVoOE1zUzlNWkhKSWhsbEExOTQ0SC9wNEU1?=
 =?utf-8?B?RXNTT0h5Vkt4ME9WZ0hrOGdKMnpXb25ZM3hNMDRXd0xVSlZHT28xSlNYaUt3?=
 =?utf-8?B?RlJkdzgzb2h5L2Y4d0YzTjB5Ni9nT0tzY2NmNy8rNmlNMWJaZ1RLK0szWi9t?=
 =?utf-8?B?aVZBTFIzZzgvdlpLSklUNGttZnNZUnV4RC8wRGpPR1ExOTNpR0ROSTcxT1Vp?=
 =?utf-8?B?cHFUNGNWWHBaYWY4V05YYkJvdWEyUXRWMzdEMUhHVDB5R1NsL21uaWFDdEVi?=
 =?utf-8?B?TUxEeUhTQmJyN3p5d0NOSVNhaFlxeEdFTU9DaHE1d3RhdmFJYzdBSWtNRlRW?=
 =?utf-8?B?aGRnWjc1VzNPbE5pM1FmYmo0MFhqRzQwSlFSQzhHMFFpOG9ZNGh5c2dTM1FQ?=
 =?utf-8?B?bkN0S0N3UGpyWHVEY1J0R3JKelUxYzE2VlNrcVIxeFZkSkFLbGlVY2ZZT0Rh?=
 =?utf-8?B?bmVrd1VuR3dZbVQvTnNKVGtJTm96bm1VUk0xMDg4alVzTndQMkRoUGhrL2Iz?=
 =?utf-8?B?MFpMU1NTeDNoQ1hxYlNQYlc0WE1oc3FhTm1xU0t2VWJzemVDUWdTV3BQRDBu?=
 =?utf-8?B?bFJYbDhtZVdXNGlhL0NHV2ZtZk0yYWJFbVhpYVNZR3BBTFhERlNybkxVUk0z?=
 =?utf-8?B?MWFlTkkvaGRlNGw1Z3E2QUd6eTc1a1d5N1poQ3J2Wkl0Snc1Vk1aeEhEUUlp?=
 =?utf-8?B?TWhjdE82RGxOTkRiQXN5anZQcW40REJXWUljWVZKYmh5Vnc0aGxYMzRORVpv?=
 =?utf-8?B?U0JkaDJaMjBrblNrRFVZMW1sNks1eXEyWFl5NjZuODgxMXJsN2N4bVdualR3?=
 =?utf-8?Q?2vGHoAZUTFdpO28WFn/KJuovL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m3HtI61hU38PPzSmlvzG65gp45FNDA4fZdAyXVFCn54Py36uFuZD9ucsu5DzgUhJIOWrttxpd23Ae5thpp4sXXkLk/6izBsv3RYDvEwmzvhTTUI8oji++TYcC8qaJJ76bQ+gMmDyD26ZjVAtyDIsUZsSvmkS395fwXF83OMvB8b6fqOQwcg9/oUWbxQyWRvVAGHde6Cy8AN5iDhSpUug4pq1ARFw33SCKDWV4TryuR1o17K1YjFK4ZGiLtvnBqKQjLSOn/JLN01Sm/bgGFz+8ZOAtno9nbjuMZnKIxakSbrYGDIoi4TTGkiK1x4MTtYIumf7bIVppU2tO5apj+BkHqOPThuwaDMShGoXfnqNCqHtYmZisXNC9tenEMhvMtG9kZ5zlrYcpaeDYhsyBbsLR3F/Zx8iQe5+SUAJOgzKZlh0oRIAluMRQ6LwIBMNCOkpaZwXAQLv2Ww99ZTZIZLsrDgWWkqlkyh1ZFkgZ+Asww2/VOuXTAqtEP2peW3Yf8tikWo9iGyQI1weXqrrjkwlQTNkkiyc+PuJDPCOjOXqhjzZhKeNUVOoPuDFu/KUaFhKUJIuCX9AFmAPtNPU5UEoZeYDnRBDnsnJZU2ss34agKeBLqI4ghBwucbYb07VJX5wrWy5Ps/LD1l/QX6PTW6GR0tFK7axST8+00+fqouVMgSDTVBv6fFBHPVIIJYrl7BY3tyalgvrO9bXFIhKBmS7CXmZ1+4BfvJdZq4q4rxOo8UL6DZOvHDxSZLjQjS9bUVhsIhOgBB8fgel0rKDhyFNBKXUApjDR6mFBw0GNo4Xa/4CFfs2Mf2ClLOYBcMhihezgFCYHSI1Hk+T0Us7SiLC9A==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d28ed1f-615c-42f2-d3de-08db5bb70afa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 17:56:32.3893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rUGJdqLzV8j7dK2L7MMk8YJQMA/dluQur575Hd6ITpNGbpp8yzlxrz0+9SlMzuNNoNCvU4kY+rMY8UOst0JtNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9858
X-Proofpoint-ORIG-GUID: _MOFXPbgLQ9kV_SrQUTllXRfXUnoF1pD
X-Proofpoint-GUID: _MOFXPbgLQ9kV_SrQUTllXRfXUnoF1pD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_11,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1011
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230144
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogcWVtdS1kZXZlbC1ib3Vu
Y2VzK2JjYWluPXF1aWNpbmMuY29tQG5vbmdudS5vcmcgPHFlbXUtZGV2ZWwtDQo+IGJvdW5jZXMr
YmNhaW49cXVpY2luYy5jb21Abm9uZ251Lm9yZz4gT24gQmVoYWxmIE9mIFJpY2hhcmQgSGVuZGVy
c29uDQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAyMywgMjAyMyAxMDozMiBBTQ0KPiBUbzogYW5qb0By
ZXYubmc7IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+OyBQZXRlciBNYXlkZWxs
DQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5v
cmcNCj4gU3ViamVjdDogUmU6IEhlbHAgZmluZGluZyBDb3Zlcml0eSBkZWZlY3RzIGZvciBnZW5l
cmF0ZWQgSGV4YWdvbiBjb2RlDQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQg
ZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZg0KPiBhbnkgbGlua3Mg
b3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+IE9uIDUvMjMv
MjMgMDY6MjksIEFudG9uIEpvaGFuc3NvbiB2aWEgd3JvdGU6DQo+ID4NCj4gPiBPbiA1LzIzLzIz
IDEyOjI5LCBQYW9sbyBCb256aW5pIHdyb3RlOg0KPiA+PiBPbiBUdWUsIE1heSAyMywgMjAyMyBh
dCAxMToxOOKAr0FNIFBldGVyIE1heWRlbGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4g
d3JvdGU6DQo+ID4+PiBPbiBNb24sIDIyIE1heSAyMDIzIGF0IDIxOjI0LCBBbnRvbiBKb2hhbnNz
b24gPGFuam9AcmV2Lm5nPiB3cm90ZToNCj4gPj4+PiBIaSwNCj4gPj4+Pg0KPiA+Pj4+IGNvdmVy
aXR5IHJlY2VudGx5IHJlcG9ydGVkIHNvbWUgZGVmZWN0cyBpbiBjb2RlIGdlbmVyYXRlZCBieSBp
ZGVmLXBhcnNlcg0KPiA+Pj4+IChlbWFpbCBhdHRhY2hlZCkuIFRoZXNlIGRlZmVjdHMgYXJlIGV4
cGVjdGVkIGFuZCB3ZSBwbGFuIHRvIGVtaXQgYQ0KPiA+Pj4+IC8qIGNvdmVyaXR5W2V2ZW50X3Rh
Z10gKi8gY29tbWVudCB0byBkaXNhYmxlIHRoZSBzcGVjaWZpYyBldmVudCB0cmlnZ2VyZWQuDQo+
ID4+PiBXZSBkb24ndCBtYXJrIGNvdmVyaXR5IGZhbHNlIHBvc2l0aXZlcyB3aXRoIGNvbW1lbnRz
IGluIHRoZQ0KPiA+Pj4gc291cmNlLiBGb3IgdGhlIGZyZWUgb25saW5lIHNjYW5uZXIsIHdlIGp1
c3QgbWFyayB0aGVtIGFzDQo+ID4+PiBmYWxzZSBwb3NpdGl2ZXMgaW4gdGhlIEdVSSAod2l0aCBh
biBleHBsYW5hdGlvbiBvZiB3aHkgdGhleSdyZQ0KPiA+Pj4gZmFsc2UgcG9zaXRpdmVzKS4NCj4g
Pj4gVGhleSBhcmVuJ3QgdmlzaWJsZSBpbiB0aGUgR1VJIGJlY2F1c2UgdGhlIHdob2xlICJoZXhh
Z29uIGdlbmVyYXRlZA0KPiA+PiBmaWxlcyIgY29tcG9uZW50IGlzIG1hcmtlZCBhcyBub3QtYW5h
bHl6ZWQ7IHdoaWNoIGFwcGFyZW50bHkgbWVhbnMgaXQNCj4gPj4gX2lzXyBhbmFseXplZCBhbmQg
dmlzaWJsZSBpbiB0aGUgZW1haWxzIGJ1dCBub3QgaW4gdGhlIEdVSS4NCj4gPg0KPiA+IEFoIHJp
Z2h0Li4uDQo+ID4NCj4gPj4gVGhlIGV2ZW50IHRhZyBmb3IgdGhpcyBlcnJvciBzaG91bGQgYmUg
ImRlYWRfZXJyb3JfY29uZGl0aW9uIi4gSW4NCj4gPj4gdGhlb3J5LCB0aGUgaGV4YWdvbiBnZW5l
cmF0ZWQgZmlsZXMgY291bGQgYmUgYSBnb29kIGV4Y2VwdGlvbiB0byB0aGUNCj4gPj4gcnVsZXMg
dGhhdCB3ZSBkb24ndCBtYXJrIGZhbHNlIHBvc2l0aXZlcyBpbiB0aGUgc291cmNlLCBidXQgZmlu
ZGluZw0KPiA+PiB0aGUgcmlnaHQgbGluZSB0byBhZGQgdGhlIHRhZyBjYW4gYmUgbWVzc3kuDQo+
ID4gSWYgd2UgZGVjaWRlIHRvIG1hcmsgdGhlc2UgaW4gc291cmNlLCBteSBwbGFuIHdhcyB0byBz
aW1wbHkgZW1pdA0KPiA+DQo+ID4gICAgICBpZiAocWVtdV90bXBfMiA+PSA2NCkgew0KPiA+ICAg
ICAgICAgIC8qIGNvdmVyaXR5W2RlYWRfZXJyb3JfY29uZGl0aW9uXSAqLw0KPiA+ICAgICAgICAg
IHRjZ19nZW5fbW92aV9pNjQodG1wXzUsIDApOw0KPiA+ICAgICAgfSBlbHNlIHsNCj4gPiAgICAg
ICAgICB0Y2dfZ2VuX3NobGlfaTY0KHRtcF81LCB0bXBfNCwgcWVtdV90bXBfMik7DQo+ID4gICAg
ICB9DQo+ID4NCj4gPiBmb3IgYWxsIG9mIHRoZXNlIHNhZmV0eSBjaGVja3MgYXJvdW5kIHNoaWZ0
cy9leHRyYWN0cyB3aGVyZSB0aGUgZGVmZWN0IGNvdWxkDQo+ID4gdHJpZ2dlci4gTWF5YmUgdGhp
cyBpcyBvdmVycmVhY2hpbmcgYXMgd2Ugd291bGQgYWxzbyBtYXJrIHNpbWlsYXIgYnJhbmNoZXMg
aW4NCj4gPiBvdGhlciBpbnN0cnVjdGlvbnMgdGhhdCBhcmUgYWxpdmUsIGJ1dCBpZiB3ZSBrbmV3
IHRoZXkgd2VyZSBkZWFkIGF0IHRyYW5zbGF0aW9uDQo+ID4gdGltZSB3ZSBjb3VsZCBzaW1wbHkg
bm90IGVtaXQgdGhlbSB0byBiZWdpbiB3aXRoLg0KPiANCj4gSXQgd291bGQgYmUgc2ltcGxlciB0
byBkbyBiZXR0ZXIgY29uc3RhbnQgcHJvcGFnYXRpb24gYW5kIGZvbGRpbmcgaW4gdGhlDQo+IGdl
bmVyYXRvciB0aGFuIHRvDQo+IGRvIHRoZSBtYXJrdXAuICBBbGwgb2YgdGhlIGNhc2VzIGZvciB3
aGljaCBpdCB3YXJucyBhcmUgcmVhbGx5IHF1aXRlIHRyaXZpYWwuDQoNCkJ1dCB0aGUgaG9zdCBj
b21waWxlciBjYW4gYWxyZWFkeSBkbyB0aGlzIGZvciB1cy4gIElzIHRoZSBtYXJrdXAgcmVhbGx5
IG1vcmUgd29yayB0aGFuIGFsbW9zdCBhbnl0aGluZyBlbHNlPw0K

