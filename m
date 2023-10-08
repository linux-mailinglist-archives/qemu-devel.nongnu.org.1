Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB417BCEA2
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 15:51:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpUAa-0000yl-0q; Sun, 08 Oct 2023 09:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qpUAX-0000yY-40
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 09:50:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qpUAV-0008LW-3u
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 09:50:04 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 398Dnveo010380; Sun, 8 Oct 2023 13:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=v4P7bH6Zm7kbxXEqPBd0Wg8JPLkaC3i2eZYeSiES1H0=;
 b=J0aL0JUEfqyM4mxO36kEKVuEwc+AnFdyjDAVuRiNqgBJvNpOHIK1spdwDkmdABFHP9qO
 8ZWPSKFd186dJHUZ+/AV5qu0K8e6yucdbtfCOuSy+dDwJpuK4TfBFgrt5k3w4NCKSrfE
 i054j5wNISMTMGd6G/lGftJenmfokSQSDgKKJcIgODjWPNkUSXJrgWMVgfSFJ9waNRyL
 ZFiKvpjLt5jpUrpu2N24F7jxcMkxWFn9P41kpQtrGlv19DsfbuCrBGwXnSONpOWc8/Ya
 Ox74oLQP0vnRk1hFZd+hPT0nCmlyX1ICbZpAeNeKM4wvSp9tNLeuGTGjG9yc2Ak8/22W YQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkh878p1m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 08 Oct 2023 13:49:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6Xkv0OjxGWGpOxYNY3kIT4GJ/pbi/q5HrajUcW7NEaycwVQwjMUFqN7YGTeKqRCYs+kcasnw80V1v7jSati17Re6/rkhtO9p2tii13e/S0+fBmcBQ2qof0bl4wWRTemHSX43rPLrqiLP7/S+X6vHDcU7qrPZiMYQyvTSmjoqaPIKlttsL9XXle/HrmZptSg4rPm3McgmhPnoU0VP2c359CZjzj3nGGuFg1oCb2O7VSP7n0EkVFQayTtEwv0LcxG2aF5FA7cmnKslfG/HFdXqP+TEUJtALh+0kMyLlmvTPrsyuHVsKADjFaSYiDI8DWGCz18FBLn1dCKVieJ3Rg/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4P7bH6Zm7kbxXEqPBd0Wg8JPLkaC3i2eZYeSiES1H0=;
 b=Guh48ZLo9fa7t8h2DTBRW+GKbCT2viIvnx9zu82hhp5BvfRzzv/7R1VZ/PlIAy7N8askDJR6GQPG6Pi0qVLjelbIj06tkomNIFg31Hj3v/re6kLGK0MTOfsuX8MYLwyBK4g0fRtF7oC3D6N1Wnu0sQ+nANlnHkwRP5YTC6kYRwGc+ZlcPpkyJ+VBScW/ml0d1pAJdHDzTnLOK3WEzXXVLskrWv9TJ9xdU15zrbKVl1x2/GGWieyiIXNv2YsqeGKxM8ogQPE9l0muqnFP1pBkHyvT1ORIHtqPG/Qgikc7ghaYsnz7H3Mj9FvSarqlY82u+NgVDEAvQHX1bWS9ds0taQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by CH2PR02MB6664.namprd02.prod.outlook.com (2603:10b6:610:a6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Sun, 8 Oct
 2023 13:49:52 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::4e82:c5b1:f941:be35]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::4e82:c5b1:f941:be35%6]) with mapi id 15.20.6838.040; Sun, 8 Oct 2023
 13:49:51 +0000
From: Brian Cain <bcain@quicinc.com>
To: "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "armbru@redhat.com" <armbru@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "philmd@linaro.org" <philmd@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "Matheus Bernardino
 (QUIC)" <quic_mathbern@quicinc.com>, "stefanha@redhat.com"
 <stefanha@redhat.com>, "ale@rev.ng" <ale@rev.ng>, "anjo@rev.ng"
 <anjo@rev.ng>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>
Subject: RE: [PATCH v2 3/3] target/hexagon: avoid shadowing globals
Thread-Topic: [PATCH v2 3/3] target/hexagon: avoid shadowing globals
Thread-Index: AQHZ99p0kpQSem9BGEaufyVyuucJMrA87MaAgAL9sPA=
Date: Sun, 8 Oct 2023 13:49:51 +0000
Message-ID: <SN6PR02MB42059CEC773018D164164A86B8CFA@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20231005222206.2784853-1-bcain@quicinc.com>
 <20231005222206.2784853-4-bcain@quicinc.com>
 <316e01d9f86e$401f62b0$c05e2810$@gmail.com>
In-Reply-To: <316e01d9f86e$401f62b0$c05e2810$@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|CH2PR02MB6664:EE_
x-ms-office365-filtering-correlation-id: 7d81e6a2-4a6c-42aa-f7f2-08dbc80571d8
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Sbl1nCv72iUgcz0LC3v1yG9p4yp6dqcNeLDcd03p+Z7MfuQk9m1TxxM4IXfr2TUgN/wU5kD9e/7b2mrgSxe9SU6q8jK5L1Pjsdk3W+jjUk1rASD3u5MGkqfEiHwKRDW3o7elr37ebnfMI22XV92oXqIitjOqvc/AtcKvOTLqzQue2ELATRe1FWZfVW6bwqyc5v4I3tUWrJEtqlqLvHF/IsfBtQri4QUxkgtR01p9MWxly1ieqznFzCh4lbZXeg+phBif1NnJmxaYHbXy1mo/NjPU/Hp7H8fi+l2ZpbjK2TenZNufHhwkWeUHyGR23ttKnAXmlfkfh8x+2UtmZMso5qV8uOIztH0FyWABqXmL52Fur259O5bZazUUK9jhZspO9h0TYzNid4GQ8PBF6EY2PCNews4UqScU0USF1Ci8OzzL3XI0XCxWLaP+HUvwQunNdV7yQkDDhq+anlMNMwAI2JCXc588ixPqujdVi3cHsPDvvk8U/Kla33VhFjL5uiE42hJHso7Z5KC9cChq9lz8qx18V15QeCfR4j167jvKxUUhmhWfJZ5hMRO5pz/8a7d8kPdJ1sLyWabuGlQOCy/KViOApAAxUPDkyd/LgFbSns=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(83380400001)(55016003)(6506007)(7696005)(53546011)(966005)(478600001)(71200400001)(38100700002)(122000001)(33656002)(38070700005)(86362001)(2906002)(41300700001)(107886003)(26005)(316002)(9686003)(54906003)(66946007)(66476007)(110136005)(66556008)(66446008)(76116006)(4326008)(64756008)(52536014)(8936002)(5660300002)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2FnQnJnUE9LK2pzemJXZER0UjJxSjNaMkJleEVwb0p4UEtzZ1hOcGZHSUNx?=
 =?utf-8?B?MWdIaTh3VFhYMC9GSHhRN3BYTU9JeTV6aDJaRW41YUZxbVE1anVkeFBuWkQr?=
 =?utf-8?B?N29zQkJzSXQxUGF2TzRZbDh3N1Q4VmdQWEk5Z0RiQ3JvMjlOWVRRUnVNdjRV?=
 =?utf-8?B?UkgvQkw3TUJXc1lFZHdwTW5ITWVzd0VzTXp5Y3NYcjNkYlgxUk15KzNRelJR?=
 =?utf-8?B?ZDlVWWJSNXA0UTRWZ25kK3Nqc3NqcnZuRzNvZ0pDKzFHUUQyOXdENnRJTDkv?=
 =?utf-8?B?eXNMVWJwdEFkejFNMVQrU0E1OElLRkZIRG1GVXdCWncvZEU2TGoxNmVmQU91?=
 =?utf-8?B?L1luZmpIZmFrOTNTVXA5L2g5ZHhkM25YMWZPY2hCTUZXYXFGQnovTm92U3VF?=
 =?utf-8?B?bGp3aVBLUXhlK1lkcFAyQm5aVUR0UW8vdmZoY3prb3lQUlhRQUN5WUxOWkFF?=
 =?utf-8?B?U1lPMllaZEhDcm82VEd2NTdWaHVhZ3doL2o5Q0p5VWQvWjg0NHFoeVAxYzR4?=
 =?utf-8?B?Y01RSWhoQXc5c1Z4UVVyT0JiV0lQV0FsZldXMlF6SmZiNTgxUEgwRmhhR3Zs?=
 =?utf-8?B?aTVnUkx2Tk9abFJrK3hodXpvNHdYQ0xTQzA5eCs0VjB4bVhXdmhDVTMyYlR3?=
 =?utf-8?B?T2tDdW5nd1M3WWIyVDFUTkJ4SXAvZTcvK2NOQ21EeDJPOTU0bXRKbUxqamQw?=
 =?utf-8?B?UGFQQmphWHRBaXhwbWNaMDBJdFViWERtbFJ1RjQ2aFlONENrSEJqYUJubVR1?=
 =?utf-8?B?YmozUHlFZlZRZHh6WGFTTlROWXcxRkx4d1pSSjZvTHd3N29VMTR1V095b05F?=
 =?utf-8?B?blo1ZHpYTW1mZlNjZlFBR014MXp5R012amQrNysrNXdHZlZaMld1NGJLcVhF?=
 =?utf-8?B?VEVMUVBYZDZ2eXh2dmxiUWQrNnJ6cy9GYXpiYW9ZYjI1Y2dZK0E5Nk5odUxh?=
 =?utf-8?B?NUpKaC9qSjY1dGhNT2E5ZlpsNEFwNkUwVnI2K2NQTVVZQnhNcCs4d3Z0NVAy?=
 =?utf-8?B?M0FKMS9TOWFYT0tlSTNlck9pNnh5aXVSUm5aRVhmcVZFdllTNjJEM25xWWNN?=
 =?utf-8?B?U0tEaTRLYXg4eWhjU1VDZ0JHamkrb3R1ZTNTdkNSSWNBSjFNcmZDeWhiUXRT?=
 =?utf-8?B?OUFEUWkwNm1YK1BVRXNsVzBoa0VuTVhlQklVOWQvRjFoMmpQMHZkeW4xTTk3?=
 =?utf-8?B?MUpxalRKWmhrYkR0ZGZxR0s1ZlJNMWxyMmlnVEFzeEZPSm5PNGs3Z1F5dUcw?=
 =?utf-8?B?cHV6aEg0YnVOVTlDTU9MQllNK3RTKzFKbFlodDlMbXplQUFJaGh3VzdwMVU5?=
 =?utf-8?B?NHorSFl3bnVuUEVsenhTM294QzFjbU1yaC9telp5UUJVVzVmYjAzZEh1Ym5H?=
 =?utf-8?B?ZFY5NXRBUzUvcXh0MUZkSjgyMXV0dlRsZEdHYnprbmQzbU1oRU04YjZFSjJo?=
 =?utf-8?B?dVM2cjJReVllZUNRZjJSZXljM0ZGbllkcnc1MHhISWFVUDFHaTUyckJrZ0xu?=
 =?utf-8?B?eS9SeUFwWkVyUXBqNzZHWVdZaFhCZ01nM3FHeTNJRWM0NGZaMXpzRFdOSWY1?=
 =?utf-8?B?Wi8wSkpvbk54ak1KMEdyK3JwZHRFWXBtN2I4eFNPcStGaDI1blRBbjg2ZVJK?=
 =?utf-8?B?SDZXVWVwNzIxOXJDZkc5RHkxZ0pyWUYrd1VvSmJrdUVvV1NQU0JEb0ozYnpm?=
 =?utf-8?B?MXVnSXFDTXVTeS9iNDIxeStpcVJsemJMeThkcDJsUmI5dDFzYkRLbVpkb0Qv?=
 =?utf-8?B?cGhLUkRSbjJFTFVjRnY5Uk1lMGJUYmJGb3Nnc3NiMHZqY0c2Z2tUR3ZYZEJG?=
 =?utf-8?B?TVBnc3VmS3ByRXV1dXF4YTRzSnpqNWg5UFZMTDZ1VFVkeU51V2Y2bDVEU0gz?=
 =?utf-8?B?MnlwVWxrTDRyWm1wcXJUU2hBQTVLblFQV3NycXZrMFlEajU4akxuczVhczhL?=
 =?utf-8?B?TTJGRTQ3LzdJWHhqV2RiSWFDQjhxcHlvL3NmZTVYRlFRblM1Qk1VQzAwMi9X?=
 =?utf-8?B?NmtpM1hMSGZ2VktWTVY1ZkhteHJGN3F0RU5XTFNLUWdyRkRLSGlvNFJtdDhC?=
 =?utf-8?B?WjVrZTdLbzZjYVY3VWdNYWlFZENmc0ptTDV5eUc0eFlCUU9WRTB1T2ZsV1lR?=
 =?utf-8?Q?on30=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DnZJ+SMfkNy0hTfA71a0o2zZ5fvXBHfkTH8wIaHX7QP8axPU1QNZokCxKW8PrAj5EFdwW+ZhNU8rw76SACaNa2WktkTKOgbdB5OHYe2ZtmgNbKmSvmkT1do3hhGBDdpds5xaOkiBQIsWbKdEQ2lBHOrvG0mlUV3PTf2u/bFdwvv3z35t/YDhOEPO4/dkyKNw+ekjR8twbAo9+NwU5tlLFLXSuTh8I3lUp9T4JhwpCrkuiVpJRSzrIjfhyEWopu3ehOHiQydqmCJwz8j4DTpKEluFxgxWqlwcSoFYhJhV1EkhrYNqAbyf1mnqBRpQkryTwNGQIbQUZHyXs83VH/GDFUGy55NorrmHkGtFG4GjHbM/Y5TAOl75JIj+HAorMZwNKo7TS7cxT4czCKZjxrsQ2lYjX40j9SGVMUWFUJPt26Wg8cLjNCv08oHTsqjHnYDweGnHyvT+OG1ANqE2P/cFj0cTFVJlg2PynAitsgN57zq1uFUINAYkYb0aIp4fmfVGVEp/GLcjdYAr1clNNodtkFKSkToBBL4HVYVM/5x1UQ7eldzP0wNGuKF4t3sOc/9h8mPfayfT7zcxd35VERNX91srSf+6+/d0ayCu65jBLjRa/LYiRIZ6hZapIlSDUUy8vVJhWqNI9JbuyQllkcvloStg4MalwEiWjXvb/M5zlVsv3fJCB/pEhZHz5LMz4ZyJ+aVCPuUy3A7GQcl5JFjAQt+crj+N0dmiJ2EPNAQFihfQV37IizTx/A8n+uOLKOEb7xagXz+cGGBMBBe99KoOo8P26SYlFdDICEp1pVDrFxWakC/KT0E0yq4MR1PA3TAqQ75ESSVQJcRKF1rzHS/5HrRBpoK3sUa98YHNPgRZ0zWURYrS4ZVjhv5+6tC5JrC8
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d81e6a2-4a6c-42aa-f7f2-08dbc80571d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2023 13:49:51.3047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G7qTMO/DDgnqEewTRD00nYo9sSMlwEZkSArf0FRMkoLQQvC5/F2pnwau/aXyTc4rOqX2L4VFQatinRNNdzNuuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6664
X-Proofpoint-ORIG-GUID: 9-bDls868NBgCM5IOrUo3Q-rZatlFA3u
X-Proofpoint-GUID: 9-bDls868NBgCM5IOrUo3Q-rZatlFA3u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-08_11,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 phishscore=0 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=612
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310080124
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbHRheWxvcnNpbXBzb25A
Z21haWwuY29tIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgT2N0
b2JlciA2LCAyMDIzIDExOjAxIEFNDQo+IFRvOiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNv
bT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogYXJtYnJ1QHJlZGhhdC5jb207IHJpY2hh
cmQuaGVuZGVyc29uQGxpbmFyby5vcmc7IHBoaWxtZEBsaW5hcm8ub3JnOw0KPiBwZXRlci5tYXlk
ZWxsQGxpbmFyby5vcmc7IE1hdGhldXMgQmVybmFyZGlubyAoUVVJQykNCj4gPHF1aWNfbWF0aGJl
cm5AcXVpY2luYy5jb20+OyBzdGVmYW5oYUByZWRoYXQuY29tOyBhbGVAcmV2Lm5nOw0KPiBhbmpv
QHJldi5uZzsgTWFyY28gTGllYmVsIChRVUlDKSA8cXVpY19tbGllYmVsQHF1aWNpbmMuY29tPg0K
PiBTdWJqZWN0OiBSRTogW1BBVENIIHYyIDMvM10gdGFyZ2V0L2hleGFnb246IGF2b2lkIHNoYWRv
d2luZyBnbG9iYWxzDQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBv
dXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZg0KPiBhbnkgbGlua3Mgb3IgYXR0
YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4N
Cj4gPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciA1LCAyMDIzIDQ6MjIgUE0NCj4gPiBUbzogcWVt
dS1kZXZlbEBub25nbnUub3JnDQo+ID4gQ2M6IGJjYWluQHF1aWNpbmMuY29tOyBhcm1icnVAcmVk
aGF0LmNvbTsgcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsNCj4gPiBwaGlsbWRAbGluYXJv
Lm9yZzsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBxdWljX21hdGhiZXJuQHF1aWNpbmMuY29t
Ow0KPiA+IHN0ZWZhbmhhQHJlZGhhdC5jb207IGFsZUByZXYubmc7IGFuam9AcmV2Lm5nOw0KPiA+
IHF1aWNfbWxpZWJlbEBxdWljaW5jLmNvbTsgbHRheWxvcnNpbXBzb25AZ21haWwuY29tDQo+ID4g
U3ViamVjdDogW1BBVENIIHYyIDMvM10gdGFyZ2V0L2hleGFnb246IGF2b2lkIHNoYWRvd2luZyBn
bG9iYWxzDQo+ID4NCj4gPiBUaGUgdHlwZWRlZiBgdmFkZHJgIGlzIHNoYWRvd2VkIGJ5IGB2YWRk
cmAgaWRlbnRpZmllcnMsIHNvIHdlIHJlbmFtZSB0aGUNCj4gPiBpZGVudGlmaWVycyB0byBhdm9p
ZCBzaGFkb3dpbmcgdGhlIHR5cGUgbmFtZS4NCj4gPg0KPiA+IFRoZSBnbG9iYWwgYGNwdV9lbnZg
IGlzIHNoYWRvd2VkIGJ5IGxvY2FsIGBjcHVfZW52YCBhcmd1bWVudHMsIHNvIHdlDQo+ID4gcmVu
YW1lIHRoZSBmdW5jdGlvbiBhcmd1bWVudHMgdG8gYXZvaWQgc2hhZG93aW5nIHRoZSBnbG9iYWwu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgICAgICAgICAgICAgICAgIHwg
NTYgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiA+ICB0YXJnZXQvaGV4YWdvbi9nZW5wdHIu
aCAgICAgICAgICAgICAgICAgfCAxOCArKysrLS0tLQ0KPiA+ICB0YXJnZXQvaGV4YWdvbi9tbXZl
Yy9zeXN0ZW1fZXh0X21tdmVjLmMgfCAgNCArLQ0KPiA+IHRhcmdldC9oZXhhZ29uL21tdmVjL3N5
c3RlbV9leHRfbW12ZWMuaCB8ICAyICstDQo+ID4gIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5j
ICAgICAgICAgICAgICB8ICA0ICstDQo+ID4gIDUgZmlsZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9u
cygrKSwgNDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFn
b24vZ2VucHRyLmMgYi90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyBpbmRleA0KPiA+IDIxN2JjN2Ji
NWEuLjExMzc3YWM5MmIgMTAwNjQ0DQo+ID4gLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMN
Cj4gPiArKysgYi90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYw0KPiA+IEBAIC0zMzQsMjggKzMzNCwy
OCBAQCB2b2lkIGdlbl9zZXRfYnl0ZV9pNjQoaW50IE4sIFRDR3ZfaTY0IHJlc3VsdCwNCj4gVENH
dg0KPiA+IHNyYykNCj4gPiAgICAgIHRjZ19nZW5fZGVwb3NpdF9pNjQocmVzdWx0LCByZXN1bHQs
IHNyYzY0LCBOICogOCwgOCk7ICB9DQo+ID4NCj4gPiAtc3RhdGljIGlubGluZSB2b2lkIGdlbl9s
b2FkX2xvY2tlZDR1KFRDR3YgZGVzdCwgVENHdiB2YWRkciwgaW50DQo+ID4gbWVtX2luZGV4KQ0K
PiA+ICtzdGF0aWMgaW5saW5lIHZvaWQgZ2VuX2xvYWRfbG9ja2VkNHUoVENHdiBkZXN0LCBUQ0d2
IHZfYWRkciwgaW50DQo+ID4gK21lbV9pbmRleCkNCj4gDQo+IEknZCByZWNvbW1lbmQgbW92aW5n
IGJvdGggdGhlIHR5cGUgYW5kIHRoZSBhcmcgbmFtZSB0byB0aGUgbmV3IGxpbmUsIGFsc28NCj4g
aW5kZW50IHRoZSBuZXcgbGluZS4NCj4gc3RhdGljIGlubGluZSB2b2lkIGdlbl9sb2FkX2xvY2tl
ZDR1KFRDR3YgZGVzdCwgVENHdiB2X2FkZHIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBtZW1faW5kZXgpDQo+
IA0KPiANCj4gPg0KPiA+IC1zdGF0aWMgaW5saW5lIHZvaWQgZ2VuX2xvYWRfbG9ja2VkOHUoVENH
dl9pNjQgZGVzdCwgVENHdiB2YWRkciwgaW50DQo+ID4gbWVtX2luZGV4KQ0KPiA+ICtzdGF0aWMg
aW5saW5lIHZvaWQgZ2VuX2xvYWRfbG9ja2VkOHUoVENHdl9pNjQgZGVzdCwgVENHdiB2X2FkZHIs
IGludA0KPiA+ICttZW1faW5kZXgpDQo+IA0KPiBEaXR0bw0KPiANCj4gPiAgc3RhdGljIGlubGlu
ZSB2b2lkIGdlbl9zdG9yZV9jb25kaXRpb25hbDQoRGlzYXNDb250ZXh0ICpjdHgsDQo+ID4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRDR3YgcHJlZCwgVENHdiB2
YWRkciwgVENHdiBzcmMpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFRDR3YgcHJlZCwgVENHdiB2X2FkZHIsIFRDR3YNCj4gPiArIHNyYykNCj4gDQo+IERp
dHRvDQo+IA0KPiA+ICAgICAgemVybyA9IHRjZ19jb25zdGFudF90bCgwKTsNCj4gPiBAQCAtMzc0
LDEzICszNzQsMTMgQEAgc3RhdGljIGlubGluZSB2b2lkDQo+ID4gZ2VuX3N0b3JlX2NvbmRpdGlv
bmFsNChEaXNhc0NvbnRleHQgKmN0eCwgIH0NCj4gPg0KPiA+ICBzdGF0aWMgaW5saW5lIHZvaWQg
Z2VuX3N0b3JlX2NvbmRpdGlvbmFsOChEaXNhc0NvbnRleHQgKmN0eCwNCj4gPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVENHdiBwcmVkLCBUQ0d2IHZhZGRyLCBU
Q0d2X2k2NCBzcmMpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFRDR3YgcHJlZCwgVENHdiB2X2FkZHIsDQo+ID4gKyBUQ0d2X2k2NCBzcmMpDQo+IA0KPiBJ
bmRlbnQNCj4gDQo+ID4gLXZvaWQgbWVtX2dhdGhlcl9zdG9yZShDUFVIZXhhZ29uU3RhdGUgKmVu
diwgdGFyZ2V0X3Vsb25nIHZhZGRyLCBpbnQNCj4gPiBzbG90KQ0KPiA+ICt2b2lkIG1lbV9nYXRo
ZXJfc3RvcmUoQ1BVSGV4YWdvblN0YXRlICplbnYsIHRhcmdldF91bG9uZyB2X2FkZHIsIGludA0K
PiA+ICtzbG90KQ0KPiANCj4gRGl0dG8NCj4gDQo+ID4gLXZvaWQgbWVtX2dhdGhlcl9zdG9yZShD
UFVIZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIHZhZGRyLCBpbnQNCj4gPiBzbG90KTsN
Cj4gPiArdm9pZCBtZW1fZ2F0aGVyX3N0b3JlKENQVUhleGFnb25TdGF0ZSAqZW52LCB0YXJnZXRf
dWxvbmcgdl9hZGRyLCBpbnQNCj4gPiArc2xvdCk7DQo+IA0KPiBEaXR0bw0KDQpJIGNvdWxkIGJl
IG1pc3Rha2VuIGJ1dCBBRkFJQ1Qgbm9uZSBvZiB0aGVzZSBsaW5lcyBhcmUgd3JhcHBlZCBpbiB0
aGUgd2F5IHRoZXkncmUgcXVvdGVkIGFib3ZlICBpbiBteSBwYXRjaCAobm9yIHRoZSBiYXNlbGlu
ZSkuICBJIGRvbid0IHRoaW5rIGFueSBvZiB0aGVzZSBsaW5lcyBleGNlZWQgODAgY29sdW1ucywg
c28gdGhleSBzaG91bGRuJ3QgbmVlZCB3cmFwcGluZywgZWl0aGVyLg0KDQpJIGRvdWJsZSBjaGVj
a2VkIGhvdyBpdCdzIGRpc3BsYXllZCBhdCB0aGUgYXJjaGl2ZSBodHRwczovL2xpc3RzLmdudS5v
cmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAyMy0xMC9tc2cwMTY2Ny5odG1sIHRvIG1ha2Ug
c3VyZSB0aGF0IGl0IHdhc24ndCBhIG1pc2NvbmZpZ3VyYXRpb24gb2YgbXkgbWFpbGVyLiAgRm9y
IGFub3RoZXIgcGVyc3BlY3RpdmUgLSByZWZlciB0byB0aGUgY29tbWl0IHVzZWQgdG8gY3JlYXRl
IHRoaXMgcGF0Y2g6IGh0dHBzOi8vZ2l0aHViLmNvbS9xdWljL3FlbXUvY29tbWl0LzdmMjA1NjVk
NDAzZDE2MzM3YWI2ZDY5ZWU2NjMxMjFhM2VlZjcxZTYNCg0KSXMgeW91ciByZXZpZXcgY29tbWVu
dCB0aGF0ICJ0aGVzZSBsaW5lcyBzaG91bGQgYmUgd3JhcHBlZCBhbmQgd2hlbiB5b3UgZG8sIG1h
a2Ugc3VyZSB5b3UgZG8gaXQgbGlrZSB0aGlzIj8gIE9yICJpZiB5b3UgYXJlIGdvaW5nIHRvIHdy
YXAgdGhlbSwgd3JhcCB0aGVtIGxpa2UgdGhpcyI/ICBPciBzb21ldGhpbmcgZWxzZT8NCg0KPiBP
dGhlcndpc2UsDQo+IFJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25A
Z21haWwuY29tPg0KPiANCg0K

