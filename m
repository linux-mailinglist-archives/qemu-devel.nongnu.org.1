Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A07A7F982E
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 05:16:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7T22-0007Pp-PD; Sun, 26 Nov 2023 23:15:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1r7T1v-0007Ni-HA
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:15:32 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1r7T1s-0006Bc-3O
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:15:30 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AR3sthG007900; Mon, 27 Nov 2023 04:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=iq55asLFrWDOhKCBIAtJszRMxwQPXJogYJ/W9mZ675U=;
 b=CWG5zERzVE4x8BeqGTPJ7jFUUrS6dyG8ExhdU7WR/dD2PULpT1eWIfREmie5GZlWaFYR
 mknZCFpwnmJYKgIewniOSBjqfBG9g9+h58vbYlT63RSZQ7GYsmab98tGgHueuD8+Jh1a
 +bkyjn2swLFOzPX3wKElXCd92qqUKW4bMdQTKiSBcL9FUHgrGzlly3DwjFYHB/q/SJa/
 j4W0/R+q3nwHeJEq73OMXHFabsoY5M6javtqMlPlHe2Nyupgo0hHoZ+JokXWcKHPzzOt
 iI/I8jZ5G64APDgAhgkb7Mjl51c2HvDyRhNRXegZenfvIkbl91G5jSaOjDA2dDdTXy2K 3Q== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uk69ubdtn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 04:15:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9tBstRKyKgUmJRqsMYKhR79CcmSTTW+kvi0YwS+xh9EaChzux/3n/PopEdZE294NKXyFTWvXerdYDINNxxTIAPlTur8nv/alGOEgDOZ9J9szPQG2OWysoNFkPixHgnqd95dIfqksifcPE16+R6A0t+zhK82JIeJJFKV71QTycVhuoI/P9qMMzYe1bktfg5YTACvyU2GfB4P+2OW23ayJTttRRI09bhM+QqMR8dLclr+EVUO0z+wBA+bvLFCuIzrwKB92SQtOVn5jivK8zk7slHz5zqS9xPQKwsi1Nw4JTx6ePv51PbEedFmJRWh6Ekaa2vrphreszevu3wmoU4J7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iq55asLFrWDOhKCBIAtJszRMxwQPXJogYJ/W9mZ675U=;
 b=kHPKzHDxjQsKVUeCTzFCHMhEBk7PF1PKmh2IsIXITYMLcXV39tnpUBXXVaqav3DE6Ld9mQGPymAtT4gi84ZVESf5AyGS+4+ihgvXS1jpGkZ9wTb2TOgoawmjYpt/w8jNC9O+qy0CMY6M8xb9QLmL2c9Gq8eySOCO3mWJd45X7cCDoM4Hd6HrxyEQ7mM+tQpkdNvQerRUOb6JKnX+FMYSs1693dZlP0nqM7Ixu77JnUSGPZWKCOKiftJaIL2AVkSumkchAD+kz3v0HgFPKRHBeV/X0YLo+DhN6//KiMXujaAmS863X0kMhE4XnThb5vYlUFreXnah0wgldPDxK2MTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by PH0PR02MB8373.namprd02.prod.outlook.com (2603:10b6:510:100::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 04:15:19 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c%6]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 04:15:19 +0000
From: Brian Cain <bcain@quicinc.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "f4bug@amsat.org" <f4bug@amsat.org>
Subject: RE: [PULL v2 25/30] Hexagon HVX (target/hexagon) instruction decoding
Thread-Topic: [PULL v2 25/30] Hexagon HVX (target/hexagon) instruction decoding
Thread-Index: AQHaHIfcyIHup7w1PUeMeBlJwOJ32rCE57iAgAivoYA=
Date: Mon, 27 Nov 2023 04:15:19 +0000
Message-ID: <SN6PR02MB4205DDC0AB7C76F9F8BA7219B8BDA@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <1635974247-1820-1-git-send-email-tsimpson@quicinc.com>
 <1635974247-1820-26-git-send-email-tsimpson@quicinc.com>
 <CAFEAcA-rPwmE1oXoPROUEfpa+CDL0zFK5U5N=wPVhWtBif-b9Q@mail.gmail.com>
 <SN6PR02MB4205881CE71AC823000E3E49B8BBA@SN6PR02MB4205.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4205881CE71AC823000E3E49B8BBA@SN6PR02MB4205.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|PH0PR02MB8373:EE_
x-ms-office365-filtering-correlation-id: a12beb35-bd24-4922-700e-08dbeeff777c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EYDHvMGZyqtil+0w2eRDWXFeV0c0Lfylrm5NacUxbw4wEF892ETbfJNCwIy1oV7uZYWa5lu18drMVD/on84eNjdb+Tim4Wtx0Wb5Vpj050luEe1AFdJTVCedw95r3W4KxNGJbIrO4X1lb7ztUTDRo7NJvdE4eCB6EmC+ktmNmLQPgfRvUFbxzAAN2GwEpgjVYDAh3GBHJ5GA7vS8y7WL5CDUPL7x92icdl7d3xOF0Z+5xClJR/LXNshsSCEDaIYEyvIPkfa9z8EWaTo2ubYA/wn1XT0vPs9SplTELW1hDkG6ml2PQnxMEtMMfhO3fSJpo96OR42egpnPgpnJSD8PlFZk/kHpn9jtjY50pVMTHkFCsGnGq9/eDPDDbmkp1AEjsrUMMBWIvOv0ngqNNTO2m1mAVIqVQJlMErS1LxNDGRPj/tBbE0ZZRRneXsAB/qwuD8jR7uPXZqxAXA+GaRxT4FQa/lafZt2WmAqSDSVwVlJt3BQx5uzvD3Yr42as96IHiysgDf4Ag+iyusKEYL6C6dfLXvsaW1oBYoaLnWG+KoL3cY3vtAKGbzixZuyJ0KIXZgxyBi4NM6Ik3oYZ1QuzIGmPtNS8UAhaL+J/jVpXx9vWXAMOUjbFnmyIh3fdTazANN9ts0qkc05sMR5UNTZ8LINfWJkd12qRVvvr+L8423Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230173577357003)(230273577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(41300700001)(33656002)(86362001)(38070700009)(122000001)(2906002)(55016003)(83380400001)(5660300002)(26005)(9686003)(53546011)(7696005)(6506007)(71200400001)(52536014)(8676002)(4326008)(8936002)(478600001)(66946007)(54906003)(64756008)(76116006)(66446008)(66476007)(66556008)(6916009)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3k3MzdRdUFHR0RyZjl6RHkxWUVxVVg1WmR3MGoxbHpVci9XUk5ySVVMbzkr?=
 =?utf-8?B?VVBza0JVb3ZNQ1hWUWdWWUdRTFBvNUsxUm1wL05yWHZ6S0JQanVUWFNUK1VO?=
 =?utf-8?B?bEFoTmo0RUVGdWlrUTFXQlR4cSszelRpYit3eFovZ0lqNGYxbnNSamY5S1JN?=
 =?utf-8?B?ckRwOFFxL3g5ekQ2cldJTG9FOC93bGJtUmtEbGVyVHY3Ym9jdHY0TUZuQmhi?=
 =?utf-8?B?aWdMVjk1aUc3a2I0VXBsbUdPMTlja1ZXMS8vNHpwU0ZtRUxFa3FKTTZ6a3pt?=
 =?utf-8?B?WGVtejZybHdJQVpSclY2YWEwWElYNHAybFBsMGdkak1WdFVmWVJFMUlxMFB4?=
 =?utf-8?B?ejNsTE9JdWVzMHc5NmpSdzhpVDZwV1BpajZPNW1HcVM0N1RqcFpUSkhOK0pJ?=
 =?utf-8?B?NnRiSVZHMEZNV3M2WENhRXRiT0FWNVFHOERNOXN6TktRR2NLaldJdVZUNWtD?=
 =?utf-8?B?ZU04bDZSc0kvcXNhZGdXMk1iWnFRZEhXNEhnL3hMdjhvQlhyTUM4eE52SmV0?=
 =?utf-8?B?eFRucnVseFVaU0hPSys2aU5IUWY3UmdNR1Y5eDdPdVh2aWVHdW5pYVhkK1d6?=
 =?utf-8?B?QWxTdVExRWR4Y3dTcTZsRXQ4NDZxdGEzcXRpZkZBZzhtTGpDMjhMKzg5cXNB?=
 =?utf-8?B?aENLa0FaYnhySkw3OHByaU1aT2REeHlVZ3RuaEtZaE1kb1RKWHhkaVJlbXVi?=
 =?utf-8?B?clZXZUNpTU9SNElkalBqVHRiOVE4dnptb0FkZVM1Y2ZIVVhKa2lQLzBqbkJO?=
 =?utf-8?B?ZjgrbUhpeW5vQXRUb1drRUFYU0o3V21JZC9Tc2M0RzI0MFNjNUVFRm84UDdk?=
 =?utf-8?B?eXpFTGZLQkZURWhyVlhmSVBkZ1IxZDNwQlRwZnROSnVvZlhwTWFHYkIvWEVZ?=
 =?utf-8?B?OUFDOExKR3RQY0kvMm9TMHU2ZHNFdXNZQytQRjlQeUN3NytrQWxvVkh5WGg5?=
 =?utf-8?B?WXQ0T2cyQTVQOGdOTldqcXVHSWlIeE9lNFkwNEl4VVdLS0x0eWZBelEzRm45?=
 =?utf-8?B?ZVRwTXhhZkhHNHJPYWcrclRpL2RtUko2eGJxUzIwTzNYQTRlaXJFcUFSWnVW?=
 =?utf-8?B?Ni9YOVJJcTIxNEYyNkJUVTZGM2dVelZhTGo0dUlTZkgzNXJaV1pnSDZHUFN1?=
 =?utf-8?B?aHQxTm1DSk9sRkNQd2NaRDhoYy9SSnVVdmdVMXhGOXZqQ2RyMXl4YlpoSHNP?=
 =?utf-8?B?MU90K1ozeTR0NUJFdXRiZ1p1V1QxZHpoRk5xTXJXVCtKTnlFRllxNXVQYmxv?=
 =?utf-8?B?cjNpdzJlMDR5dU9rbTF2NVh6K3VSUzd4K2pkbnBEaHZURm5FMFpWSFFZQ1c4?=
 =?utf-8?B?TGVDeGZoWFZIZDQzOHBoNHI3WjdsTVh3KzBkUjM2RmtIbnRKVTVoandrcXlz?=
 =?utf-8?B?WXcxVFNPMUhja29nc2NOTDNRN2tnajhaUGFiRVVBNmR4WnhPRHFzQjhkOXhj?=
 =?utf-8?B?V24yZS8zampoV1B6NHBUYkhKcTlzMVBVQWJyMnNoTmJrZ29rbTZaZzYwSW5R?=
 =?utf-8?B?UGdoUlRQSFM5aG1adkprZGdZa2hFSERpUTl5Q0p4MzlWY1FRbWE4R002VDFD?=
 =?utf-8?B?VjJ5N3ZpUFFmUDhxTUVwRmlqaEZDdFVZN3AxZWI1TGF5bnc1aDlMNWV1UXU5?=
 =?utf-8?B?U1lQU2RwTTd0WDZhNUpZWFhOUkwrVjFxTHZ2YjBRcTJkaEJFcXBkWUtsU3Er?=
 =?utf-8?B?QU1hUjBQQU9hQ0FZb1R4RVVqSUJKNTRxYmRmajRjU3hqejQ2dm11NDRueEkz?=
 =?utf-8?B?NXQwRlBjNlpkV3BObXFuWU05TFo2Y3M5WnFZK0wxamxjWGNpa25LaHpjUVZq?=
 =?utf-8?B?R0JMajNoT1c2NE43NVFhZ0lUWHJFNWs1UTYrZVRSSm5RTkNtcEMvbFpYRVNJ?=
 =?utf-8?B?MUFqdjIvb2U3MTlKSXVRRG5rWnB6dVo4K2dUeXlZSGhBNk9ScXRxT1cwOU9Y?=
 =?utf-8?B?OHdhcllhZm51cUFWRDRjTDhGUVk3S29HODNsQ0RyMk5GekRkaVdoUGt1ckpy?=
 =?utf-8?B?b282R3M5NFlHZlVRaTRvWXJ2dGN0Uk1qaUpDMTRpZ2lXOTRhZ21oc3ljVW9P?=
 =?utf-8?B?OXJnTjZNZ1ovdHNyYzA5akVxWGxjS0Y5R215VDRyUTVNdTdONEVPZXcrZHVh?=
 =?utf-8?Q?42EY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7kB5cCRSAWDtNCV9lTD9oMBCnXdATGB/6Se9t0zvDtcDjKlVs5EwoLN8pafyfDvBvu+wm3N5FnJX25zib3csquv3wcnK8uFASXYvChS1ZpsfsbvbITpAugYjjfY0/N5VeV7XP9QVJC44l6q1JGYfTt433mAcHusDy4lfYJcveCDKhOrAEDvDdXlH21CXnq+/8nBCAy5Rk0lltIVZoJRenCOWp9b0ZfXzwKzhIVqu2hfJPZpx1oDf9Wi46Dir7mCGXy3W5xzpw15K/KPmWYk/bLanUQic2WF1WnJnr3hukSU2McP5hQLumQkzSvwU8OWQk67sSzMcHxH3E7Dfv9gqI8oAp2VpVDojCyIPK439BAgAXj1RQRhYmKO0y8W6JvJb2b44Nrud3IkfituO+B21buIeLrYBVkdg7X1h7yufe1OSqTrcPZvKC5XinkGHcwv1D80QnwKtA918oiqttK1GuxcxCjwqdyAelxcmhy7aaKf1GvkjirM9QqFA/URRHc+nacTnDMaRiedugcp1nCqtiZuL395PFGV8N5DsHj3xiipbr53UvDU3D02tnCEMPWqKvcUvQE6aYl0JSddMX7fS3V4bxAs3FHrhfPbyVg1lXdxBVbaQM2z1T28p9sybNwTcIyYK75svbr3UESHM1lwiGBDWmMkpTgemBag3gbcKe7toHGKmVirhPDpXMlsQtYieZnFD75FDUubak4i01mYyN+PKxMCK/xaj1tOyYg/lyB7dD8ztk/iCfMqWC0CIGDLUrGCvWfVfi26IQLKf2CriOPxaIKX+pUlIdqaTU38MM9DPxUYfsWcsXEXUCEMt7KaKBJFokkLQZBZ7pIUi1cozjg==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12beb35-bd24-4922-700e-08dbeeff777c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 04:15:19.1494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NmcYqIG46XY4/7zPT+QMCmpEIAZBsycsxU+0OX2yguYJdjIXpBCLtAd5aKPmBz01Rkj5FpnVZXnbP7+QKxO2pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8373
X-Proofpoint-ORIG-GUID: fSpkAcrAd9GD3aKE8_VuR9e98xmt45Ku
X-Proofpoint-GUID: fSpkAcrAd9GD3aKE8_VuR9e98xmt45Ku
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-26_25,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=914 mlxscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270030
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQnJpYW4gQ2Fpbg0KPiBT
ZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAyMSwgMjAyMyA5OjUyIEFNDQo+IFRvOiBQZXRlciBNYXlk
ZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5v
cmc7IHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc7IGY0YnVnQGFtc2F0Lm9yZw0KPiBTdWJq
ZWN0OiBSRTogW1BVTEwgdjIgMjUvMzBdIEhleGFnb24gSFZYICh0YXJnZXQvaGV4YWdvbikgaW5z
dHJ1Y3Rpb24NCj4gZGVjb2RpbmcNCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+IEZyb206IHFlbXUtZGV2ZWwtYm91bmNlcytiY2Fpbj1xdWljaW5jLmNvbUBu
b25nbnUub3JnIDxxZW11LWRldmVsLQ0KPiA+IGJvdW5jZXMrYmNhaW49cXVpY2luYy5jb21Abm9u
Z251Lm9yZz4gT24gQmVoYWxmIE9mIFBldGVyIE1heWRlbGwNCj4gPiBTZW50OiBUdWVzZGF5LCBO
b3ZlbWJlciAyMSwgMjAyMyA4OjMzIEFNDQo+ID4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNv
bkBxdWljaW5jLmNvbT4NCj4gPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyByaWNoYXJkLmhl
bmRlcnNvbkBsaW5hcm8ub3JnOw0KPiBmNGJ1Z0BhbXNhdC5vcmcNCj4gPiBTdWJqZWN0OiBSZTog
W1BVTEwgdjIgMjUvMzBdIEhleGFnb24gSFZYICh0YXJnZXQvaGV4YWdvbikgaW5zdHJ1Y3Rpb24N
Cj4gPiBkZWNvZGluZw0KPiA+DQo+ID4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZy
b20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkNCj4gb2YNCj4gPiBhbnkgbGlu
a3Mgb3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gPg0KPiA+IE9u
IFdlZCwgMyBOb3YgMjAyMSBhdCAyMToxNywgVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNp
bmMuY29tPg0KPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBBZGQgbmV3IGZpbGUgdG8gdGFyZ2V0L2hl
eGFnb24vbWVzb24uYnVpbGQNCj4gPiA+DQo+ID4gPiBBY2tlZC1ieTogUmljaGFyZCBIZW5kZXJz
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBU
YXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+DQo+ID4NCj4gPiBIaTsgQ292ZXJp
dHkgcG9pbnRzIG91dCBhIHZhcmlhYmxlIHdyaXR0ZW4gdG8gYW5kIHRoZW4NCj4gPiBvdmVyd3Jp
dHRlbiBiZWZvcmUgaXQncyBldmVyIHVzZWQgaW4gdGhpcyBmdW5jdGlvbiAoQ0lEIDE1Mjc0MDgp
Og0KPiA+DQo+ID4NCj4gPg0KPiA+DQo+ID4gPiArc3RhdGljIHZvaWQNCj4gPiA+ICtjaGVja19u
ZXdfdmFsdWUoUGFja2V0ICpwa3QpDQo+ID4gPiArew0KPiA+ID4gKyAgICAvKiAubmV3IHZhbHVl
IGZvciBhIE1NVmVjdG9yIHN0b3JlICovDQo+ID4gPiArICAgIGludCBpLCBqOw0KPiA+ID4gKyAg
ICBjb25zdCBjaGFyICpyZWdpbmZvOw0KPiA+ID4gKyAgICBjb25zdCBjaGFyICpkZXN0bGV0dGVy
czsNCj4gPiA+ICsgICAgY29uc3QgY2hhciAqZHN0c3RyID0gTlVMTDsNCj4gPiA+ICsgICAgdWlu
dDE2X3QgZGVmX29wY29kZTsNCj4gPiA+ICsgICAgY2hhciBsZXR0ZXI7DQo+ID4gPiArICAgIGlu
dCBkZWZfcmVnbnVtOw0KPiA+DQo+ID4gZGVmX3JlZ251bSBoYXMgZnVuY3Rpb24gbGV2ZWwgc2Nv
cGUuLi4NCj4gPg0KPiA+ID4gKw0KPiA+ID4gKyAgICBmb3IgKGkgPSAxOyBpIDwgcGt0LT5udW1f
aW5zbnM7IGkrKykgew0KPiA+ID4gKyAgICAgICAgdWludDE2X3QgdXNlX29wY29kZSA9IHBrdC0+
aW5zbltpXS5vcGNvZGU7DQo+ID4gPiArICAgICAgICBpZiAoR0VUX0FUVFJJQih1c2Vfb3Bjb2Rl
LCBBX0RPVE5FV1ZBTFVFKSAmJg0KPiA+ID4gKyAgICAgICAgICAgIEdFVF9BVFRSSUIodXNlX29w
Y29kZSwgQV9DVkkpICYmDQo+ID4gPiArICAgICAgICAgICAgR0VUX0FUVFJJQih1c2Vfb3Bjb2Rl
LCBBX1NUT1JFKSkgew0KPiA+ID4gKyAgICAgICAgICAgIGludCB1c2VfcmVnaWR4ID0gc3RyY2hy
KG9wY29kZV9yZWdpbmZvW3VzZV9vcGNvZGVdLCAncycpIC0NCj4gPiA+ICsgICAgICAgICAgICAg
ICAgb3Bjb2RlX3JlZ2luZm9bdXNlX29wY29kZV07DQo+ID4gPiArICAgICAgICAgICAgLyoNCj4g
PiA+ICsgICAgICAgICAgICAgKiBXaGF0J3MgZW5jb2RlZCBhdCB0aGUgTi1maWVsZCBpcyB0aGUg
b2Zmc2V0IHRvIHdobydzIHByb2R1Y2luZw0KPiA+ID4gKyAgICAgICAgICAgICAqIHRoZSB2YWx1
ZS4NCj4gPiA+ICsgICAgICAgICAgICAgKiBTaGlmdCBvZmYgdGhlIExTQiB3aGljaCBpbmRpY2F0
ZXMgb2RkL2V2ZW4gcmVnaXN0ZXIuDQo+ID4gPiArICAgICAgICAgICAgICovDQo+ID4gPiArICAg
ICAgICAgICAgaW50IGRlZl9vZmYgPSAoKHBrdC0+aW5zbltpXS5yZWdub1t1c2VfcmVnaWR4XSkg
Pj4gMSk7DQo+ID4gPiArICAgICAgICAgICAgaW50IGRlZl9vcmVnID0gcGt0LT5pbnNuW2ldLnJl
Z25vW3VzZV9yZWdpZHhdICYgMTsNCj4gPiA+ICsgICAgICAgICAgICBpbnQgZGVmX2lkeCA9IC0x
Ow0KPiA+ID4gKyAgICAgICAgICAgIGZvciAoaiA9IGkgLSAxOyAoaiA+PSAwKSAmJiAoZGVmX29m
ZiA+PSAwKTsgai0tKSB7DQo+ID4gPiArICAgICAgICAgICAgICAgIGlmICghR0VUX0FUVFJJQihw
a3QtPmluc25bal0ub3Bjb2RlLCBBX0NWSSkpIHsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAg
IGNvbnRpbnVlOw0KPiA+ID4gKyAgICAgICAgICAgICAgICB9DQo+ID4gPiArICAgICAgICAgICAg
ICAgIGRlZl9vZmYtLTsNCj4gPiA+ICsgICAgICAgICAgICAgICAgaWYgKGRlZl9vZmYgPT0gMCkg
ew0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgZGVmX2lkeCA9IGo7DQo+ID4gPiArICAgICAg
ICAgICAgICAgICAgICBicmVhazsNCj4gPiA+ICsgICAgICAgICAgICAgICAgfQ0KPiA+ID4gKyAg
ICAgICAgICAgIH0NCj4gPiA+ICsgICAgICAgICAgICAvKg0KPiA+ID4gKyAgICAgICAgICAgICAq
IENoZWNrIGZvciBhIGJhZGx5IGVuY29kZWQgTi1maWVsZCB3aGljaCBwb2ludHMgdG8gYW4gaW5z
dHJ1Y3Rpb24NCj4gPiA+ICsgICAgICAgICAgICAgKiBvdXQtb2YtcmFuZ2UNCj4gPiA+ICsgICAg
ICAgICAgICAgKi8NCj4gPiA+ICsgICAgICAgICAgICBnX2Fzc2VydCghKChkZWZfb2ZmICE9IDAp
IHx8IChkZWZfaWR4IDwgMCkgfHwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIChkZWZf
aWR4ID4gKHBrdC0+bnVtX2luc25zIC0gMSkpKSk7DQo+ID4gPiArDQo+ID4gPiArICAgICAgICAg
ICAgLyogZGVmX2lkeCBpcyB0aGUgaW5kZXggb2YgdGhlIHByb2R1Y2VyICovDQo+ID4gPiArICAg
ICAgICAgICAgZGVmX29wY29kZSA9IHBrdC0+aW5zbltkZWZfaWR4XS5vcGNvZGU7DQo+ID4gPiAr
ICAgICAgICAgICAgcmVnaW5mbyA9IG9wY29kZV9yZWdpbmZvW2RlZl9vcGNvZGVdOw0KPiA+ID4g
KyAgICAgICAgICAgIGRlc3RsZXR0ZXJzID0gImRleHkiOw0KPiA+ID4gKyAgICAgICAgICAgIGZv
ciAoaiA9IDA7IChsZXR0ZXIgPSBkZXN0bGV0dGVyc1tqXSkgIT0gMDsgaisrKSB7DQo+ID4gPiAr
ICAgICAgICAgICAgICAgIGRzdHN0ciA9IHN0cmNocihyZWdpbmZvLCBsZXR0ZXIpOw0KPiA+ID4g
KyAgICAgICAgICAgICAgICBpZiAoZHN0c3RyICE9IE5VTEwpIHsNCj4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgIGJyZWFrOw0KPiA+ID4gKyAgICAgICAgICAgICAgICB9DQo+ID4gPiArICAgICAg
ICAgICAgfQ0KPiA+ID4gKyAgICAgICAgICAgIGlmICgoZHN0c3RyID09IE5VTEwpICAmJiBHRVRf
QVRUUklCKGRlZl9vcGNvZGUsIEFfQ1ZJX0dBVEhFUikpDQo+IHsNCj4gPiA+ICsgICAgICAgICAg
ICAgICAgZGVmX3JlZ251bSA9IDA7DQo+ID4NCj4gPiBJbiB0aGlzIGhhbGYgb2YgdGhlIGlmKCkg
d2Ugc2V0IGl0IHRvIDAuLi4NCj4gPg0KPiA+ID4gKyAgICAgICAgICAgICAgICBwa3QtPmluc25b
aV0ucmVnbm9bdXNlX3JlZ2lkeF0gPSBkZWZfb3JlZzsNCj4gPiA+ICsgICAgICAgICAgICAgICAg
cGt0LT5pbnNuW2ldLm5ld192YWx1ZV9wcm9kdWNlcl9zbG90ID0gcGt0LT5pbnNuW2RlZl9pZHhd
LnNsb3Q7DQo+ID4gPiArICAgICAgICAgICAgfSBlbHNlIHsNCj4gPiA+ICsgICAgICAgICAgICAg
ICAgaWYgKGRzdHN0ciA9PSBOVUxMKSB7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAvKiBz
dGlsbCBub3QgdGhlcmUsIHdlIGhhdmUgYSBiYWQgcGFja2V0ICovDQo+ID4gPiArICAgICAgICAg
ICAgICAgICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOw0KPiA+ID4gKyAgICAgICAgICAgICAg
ICB9DQo+ID4gPiArICAgICAgICAgICAgICAgIGRlZl9yZWdudW0gPSBwa3QtPmluc25bZGVmX2lk
eF0ucmVnbm9bZHN0c3RyIC0gcmVnaW5mb107DQo+ID4gPiArICAgICAgICAgICAgICAgIC8qIE5v
dyBwYXRjaCB1cCB0aGUgY29uc3VtZXIgd2l0aCB0aGUgcmVnaXN0ZXIgbnVtYmVyICovDQo+ID4g
PiArICAgICAgICAgICAgICAgIHBrdC0+aW5zbltpXS5yZWdub1t1c2VfcmVnaWR4XSA9IGRlZl9y
ZWdudW0gXiBkZWZfb3JlZzsNCj4gPiA+ICsgICAgICAgICAgICAgICAgLyogc3BlY2lhbCBjYXNl
IGZvciAoVngsVnkpICovDQo+ID4gPiArICAgICAgICAgICAgICAgIGRzdHN0ciA9IHN0cmNocihy
ZWdpbmZvLCAneScpOw0KPiA+ID4gKyAgICAgICAgICAgICAgICBpZiAoZGVmX29yZWcgJiYgc3Ry
Y2hyKHJlZ2luZm8sICd4JykgJiYgZHN0c3RyKSB7DQo+ID4gPiArICAgICAgICAgICAgICAgICAg
ICBkZWZfcmVnbnVtID0gcGt0LT5pbnNuW2RlZl9pZHhdLnJlZ25vW2RzdHN0ciAtIHJlZ2luZm9d
Ow0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgcGt0LT5pbnNuW2ldLnJlZ25vW3VzZV9yZWdp
ZHhdID0gZGVmX3JlZ251bTsNCj4gPiA+ICsgICAgICAgICAgICAgICAgfQ0KPiA+DQo+ID4gLi4u
YnV0IHRoZSBvbmx5IHBsYWNlIHdlIHJlYWQgZGVmX3JlZ251bSBpcyBpbiB0aGlzIG90aGVyIGhh
bGYgb2YgdGhlDQo+ID4gaWYoKSwgYW5kIGlmIHdlIGdldCBoZXJlIHRoZW4gd2UndmUgc2V0IGl0
IHRvIHNvbWV0aGluZyBvdXQgb2YgcHh0LT5pbnNuLg0KPiA+DQo+ID4gV2VyZSB3ZSBzdXBwb3Nl
ZCB0byBkbyBzb21ldGhpbmcgd2l0aCBkZWZfcmVnbnVtIG91dHNpZGUgdGhpcyBpZigpLA0KPiA+
IG9yIGNvdWxkIHdlIGluc3RlYWQgZHJvcCB0aGUgaW5pdGlhbGl6YXRpb24gaW4gdGhlIGZpcnN0
IGhhbGYgb2YgdGhlIGlmKCkNCj4gPiBhbmQgbW92ZSBpdHMgZGVjbGFyYXRpb24gaW5zaWRlIHRo
aXMgZWxzZSB7fSBibG9jayA/DQo+IA0KPiBIbW0gLS0gd2UnbGwgdGFrZSBhIGxvb2sgYXQgdGhp
cyBhbmQgZ2V0IGJhY2sgdG8geW91Lg0KDQpZZXMsIEkgYmVsaWV2ZSB0aGF0IHRoZSBkZWNsYXJh
dGlvbiBzaG91bGQgbW92ZSBpbnNpZGUgYW5kIHJlbW92ZSB0aGUgaW5pdGlhbGl6YXRpb24uICBJ
J2xsIHByZXBhcmUgYSBwYXRjaCB0byBhZGRyZXNzIHRoaXMuDQoNCi1Ccmlhbg0K

