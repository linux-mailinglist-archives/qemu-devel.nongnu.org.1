Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38649804577
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 04:05:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rALjh-0005Q0-LM; Mon, 04 Dec 2023 22:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rALjb-0005Nk-9R
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 22:04:35 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rALjZ-0006Vk-E4
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 22:04:31 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B51j1Fm006553; Tue, 5 Dec 2023 03:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=V+JcwhSr438hz1iCjThSHsvJCwiNKsdeRi84FUTlSdk=;
 b=A6wO0Ndej8cUMctz5jlf3vK2YxkY+A3JeuurX1+55IYGUXojpyFl8gIyTSdXVmdKwCwU
 jHeGScFEcyMBKUxPfj6ZlaoLrcQnLGK91Ih/aYL3mlN+oty12l9PFHowYN765RubZDRP
 hH2NeX9YgTarTd5UUUXh+NyqP6OxFmvv0k9OCUS/1+vy2N/oNbnItTTLjjMmDeMrLWae
 vHM09VERpDAboR/KRH2Q+NHr2zUKWIJJd2DlTtOh9U6OmiZxzSU8JM+0yQ6bGA5bTIKk
 2OiLVbHhv0aiZV8lQXb7a5LP/rmSD6BTOAk684qR4aPZ/vjSBFejRAVDZPyh35i0o0p2 8A== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3usgs7hgep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Dec 2023 03:04:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOOwhhIEgUJVCcbNQT3Bj0RFNi2Tn6mS9CONO9pXpYWMDjFUg2Cd4XsvmMFKEDD9lQtKRvASOJU1UbN5WqdiB1LSAGbJpNfA/M3oZeuY43JNFf2W2mkpMzt63atSUMrqb5E0x/SdENJ4ZJmsZGDp2swmDgV27SBUcfvTu1slQOLicG+6eJcC3BRiedsHYtgzidVdUc7yvHfmKkR6fYonup7jQNVQxAASEUJGu6npxMVHAnjaa2Sb6QToCbtUto3IMGyqOXJjMFKj/+3VVgrk6+aSTcaGVM1JvqqUWjGVtsn4uIJ6h58Il2T0tdbi/ty7ZVietLJ21Td1105jwwBvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+JcwhSr438hz1iCjThSHsvJCwiNKsdeRi84FUTlSdk=;
 b=B22en0sFaPwwTAwe1hQFRM2e79V0Pp6wH2jfhS8MULAjl3P0MYx9ymy6+ATsTs9DldNPHl2TiTMHWOEXc3VT0uenXN7Nib4xZZozAvD6/ZWw27nPGDGfQ7qoWMARws7ToAi6ISCsfW0Hlb8PM8oByxXa6BebT/q1lYDipEYtcEq59STAtzTX8+u3MR3jj1ATBN0nEShZfoo1hc9vTem5JzYP/R3w63I35NWTSpHe0oIryk4kQdtwK1y03eB1PoCPNaSN3UZgLwW7OzyncgKYkl93Z84dSRibGm1jLRqiIcZKbAfEaPt4TkeLM8KceQufJx65qULRjEyp7nVy9Nt5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by CH2PR02MB6901.namprd02.prod.outlook.com (2603:10b6:610:8e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 03:04:23 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c%6]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 03:04:23 +0000
From: Brian Cain <bcain@quicinc.com>
To: Taylor Simpson <ltaylorsimpson@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, Sid Manning
 <sidneym@quicinc.com>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: RE: [PATCH 1/9] Hexagon (target/hexagon) Clean up handling of
 modifier registers
Thread-Topic: [PATCH 1/9] Hexagon (target/hexagon) Clean up handling of
 modifier registers
Thread-Index: AQHaJx3Oqk3mROWVTEe5b+pXFom+aLCaAS1w
Date: Tue, 5 Dec 2023 03:04:23 +0000
Message-ID: <SN6PR02MB42057616CCB46CBD4A7C64FFB885A@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20231205015303.575807-1-ltaylorsimpson@gmail.com>
 <20231205015303.575807-2-ltaylorsimpson@gmail.com>
In-Reply-To: <20231205015303.575807-2-ltaylorsimpson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|CH2PR02MB6901:EE_
x-ms-office365-filtering-correlation-id: 443bb927-0ae8-47b0-9cdc-08dbf53ee1ff
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AMWJnIE0ne1DZ+AEBUTbgDH2Whv+CFO83r9jEbg59sQXfuXU912na52cwYHnZIXsfJl+8YWXgqzuNxFHWvOK6V5whJv4faj2N2PA9H54YhZn1W8gTJOCpwbYHYZZmR0XjLlhYwhPqtUuV3wLjVYA9VPIRKsoc3hCfUbuebuONLUlJmk7IxXqp1AoqM0pmJiL39lt24RbN3abWO6uRj4+ea6ALASJX6IjP0v8FklZ4axj/dAxkcbHwPtbQ7efWYN3S3WETEQVPNdzsZYkOecZjBveUcgJ4TuptYRmvjyFga+0Hcfws67ehgoBLX62aZtfL5CGuJloWAe3OvEPRSdFolwvvhguLUJCFbYx2fY/YjLLBWSD1EuwOU4iKdUp40xJaErEm/EJHRJ3T9TaOs+vNR7a7IgcZwPBXvlppbnscPPfUJkuoQDUd1auYKRXWINIKGy2uIBP6NbC8oSAlXk3MFghfKv4ajj0McogYnhYdW1XYIVZiT+ejgSsK1DBH/2GPbvOtxg4CAFKQmfLU21o5U1w/SHrOnz0kc1oz7FUIAlJaFL+8G5VOOyZwBRoDQM7b4Mska3/zCI8LtJhlvfsKoKt7vWEYS+hHzkyTF/+tc7AQtRHj3h3qf63qHp1wjl1Vk1a6ovmyhHAAb01luyH+4ZOaQHY4uZgPf3X3XbeqgE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(52536014)(2906002)(5660300002)(38070700009)(33656002)(86362001)(41300700001)(6506007)(7696005)(71200400001)(478600001)(9686003)(53546011)(55016003)(38100700002)(122000001)(83380400001)(26005)(8676002)(4326008)(8936002)(76116006)(66476007)(66556008)(66946007)(66446008)(110136005)(54906003)(64756008)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjV1VWFScEI5T0hPdWZFMXhyc253T2ZuY1ZGeGkva2dzbThueDdpam5zU3hS?=
 =?utf-8?B?MXZKZkZkL28wUHUvNDNvKzE2RitBdkxvWFNRQXlOd2o3QjladXhBOCtZbnJJ?=
 =?utf-8?B?Ty9wT3BjTFB0UFU3N2s5L1lta2hFMnVZcmJUU1JTeXdZVUlCNmMweUZqWkVL?=
 =?utf-8?B?eGZlTEo0bWNhQ045Q2t3MDNrei83aERHdFp4ZGpjZkovdGcydUxJWi9DWStF?=
 =?utf-8?B?RzFPclBLUnRncitYT3ZXZHFOYXcyR25LdjZ4eFJKVE9NcFdGQTc3N0Z0S2Fo?=
 =?utf-8?B?c2Exd2RLNTY5dlZxRHQwLzRHeWJ1QTVmaGRTeFpQK2xwemJkNTg3aWJFQUZG?=
 =?utf-8?B?OWUyQWFTeVBTbHNWSkZsTHZldkkvdHN2dkl6b0JYWkFSWHd1RTM5NU5YTEJM?=
 =?utf-8?B?ZXUxTWxOUXNaVXp6UlFaUEIrK0hXS2UvOWlwcWF1MzlFbFhwWlFtdDVFQ3Np?=
 =?utf-8?B?UXFOYnRYR2ZzZFRyWGI1cEd2TndRVFNOWXJPeDhpb1RIVmVDZUFQYlVpVmdu?=
 =?utf-8?B?L2g1MzBvWTJwV1R0RExDSDNobTlXc00wVUhmUlEyVXdsT08zaXRDZ2FGeEly?=
 =?utf-8?B?MEJFeTN4L25GcGFFS3R6T2lEK1JxU0ZvRGJERlhMNmZBUHU2UXVxd2VsUmFL?=
 =?utf-8?B?emdvbWVzWmxRTHE2aHhTZXFCOXYxK0YrREVmNndueWlaYjJINkpRdkRtZzd3?=
 =?utf-8?B?N0poZXJZZ1loQmNTVmdYSXZPdzFNSDE1M0t4eTFJcFlDbjJ5aHVIc2hBY3Ji?=
 =?utf-8?B?ZDVKMUpuVFZaVGd0czNjWWJXSVJjQSsyT3FsQzFjdk5HbW4yRmFRa09TN2Vj?=
 =?utf-8?B?Qk9DYlRSOEZtMlRDb204OFRJQ0R4dWNwR3dBb1NGK3NsaEZkcGlYWlJDZGtv?=
 =?utf-8?B?TngrcnZySkVGODB3Sk81amM5Z1pEclBYdXZlWXk3eER6WDRUNlg1ZWdHVFZp?=
 =?utf-8?B?MWxqaERDNGRrdVd1UkhXOW95ZFFGYXlBODRqM29zdHU4QzVCdVk1YTZGVlJ0?=
 =?utf-8?B?UE91SmxiQ0djMUtabGFyMjhpN1A4UVd4b1Z0c2ZFK084TjZMMHU1VWlXaUJ1?=
 =?utf-8?B?NDJkdzlKR0Y4cEkvYnZYKy95WW5aZlAyOWdvQmNwWm5VbVFkY0hpZmM5QW1M?=
 =?utf-8?B?SjM2S0FlUUJoMVk5LzIrVk9KQTJQSFE5bk5oNmZuMCtrSFAvZmdMdTI2V2hv?=
 =?utf-8?B?MjBsZ0VGL0Z3MFBSQmlUcHpuUXd5ZVE1R0lacStYMGlvRnN1bkpaZTF6Tzlk?=
 =?utf-8?B?Z1hycWtZalhCSW1JM09YR3pvRFVwT01RK29nNUoyb3VUL2dhdlUvM0swcWll?=
 =?utf-8?B?RWNFSDZwR0dURERidDVOaTJWUlVzQWoweWdkcXBzTHl3VnREaTVJd3EzN2dj?=
 =?utf-8?B?NWdObGVOSXpoR3ErRHJpUVZmenBJbTlRNm9lWmNwQmphQzR3Y1BiVEFVc240?=
 =?utf-8?B?Y3J1UW5aMjdmQU05Qm52UjVSbFFWVncydWwxWjRzbWkwaytsNFJtbzdIWWJJ?=
 =?utf-8?B?dEw5VGRGaGR6SkJBZ29CanA3VHdmOW1TYVlEUVlXajRJK2NZQWI3SEVOaDBP?=
 =?utf-8?B?MmZhejAxY2hYRUNmK2M0ejZFUko5dFBJby9PZHVXRFlFRytSVU1RV2psNWEy?=
 =?utf-8?B?Vmt2dEJjelpzdFgva2pvSGlmcWRiZE9rUnJmNnhRZStKMFZvdldHYnpNWGY4?=
 =?utf-8?B?U2pjWXJhRGpTbTJVQmFabnp1ZWxHeTYyek50eVlONE9NZlFYbTV0aVZ6TVY1?=
 =?utf-8?B?ajVqLy81dDk3Z1p4ZVlFODdsd2VlbEdDdzh4UTFJWnVYU2hLWTNSQno1b0hw?=
 =?utf-8?B?U2t3WUZvaGJNeHlVL3dSTEVsTW03NHpDRDB0NTRkMUhnTjlvRGVnZC80SE1i?=
 =?utf-8?B?aHJnZG80aTh0VEphYnF2SlY5WStzR3czVGROb1Q0TUtPd3dqUVNRemhPMVgv?=
 =?utf-8?B?aUFxd2F5TWwxUE1xc1ljRTNkay9UUkVrb2lTZ0FQR2EyMXVGam8rRTZvdUx6?=
 =?utf-8?B?clhBTUkzeXJCcVJNcTlvbXZ3VVNIdEdsRkFNYVJ0bVZGcXlaNmpFbEhtZllJ?=
 =?utf-8?B?ckEyUVg2NnVxSU91QXlOUnhGZzJDWHkySlR2bGk1WnAxc1BFNHR1eDNTYUE3?=
 =?utf-8?Q?XWft/mZz4bTH74sO0RwU96HpX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0zROAnMWyo5IRSdgeah+QPKQDFaxcJUazTml942Nt2WiHSm2/ABLIyVzDYpgu8LxAtN8Km+Bq/C8BSMszNyGl+VybcIiIPi0UKAKgRQa61c+wVpO3DcqPSKkdXHqmHCzIh8naX3e3qJwk4kNivNYZFQUq246pbT8j91OpDfZW4zsMvELr31KJ9wc8qfwdQNJ4aEs4tNEiduUSvaYr2q0Czglc8s0NhN/fh9sQ10jvWbwmBdulyg1fQbkiB4GadmPFD97/pAkDgWLBL3A/E6vVfbSOr9M3cOHfCmTslgfMm0Y/3FXXksXS+KVlFaid9y+NthEVcQp3hL5Tv0RxXhJh1QYRaErxtEdE1cqnguQqYN6zHawaw5jPvjOOu7B8+IvogtO13C8ER4+xsXDfEfnV2Vn0VCatipSy8CBNfol6+oh7epf9hB9XYhGP0zbQ+PPhEx+41mpDb9pd/PKV9og5xRQE0XIgbaNXMDSUWNQuSXodK+G9iEQGdZRbPIYaxyihM9j3evP0wCspyLVvcOsyGm84goQfVcuoKJ6srWDptVASgBz2blXVUCfvOWvREYfUZMMoYNvXDTBlYQAPS8WeekVkzT/XRuPLHwzn8WIKSzF1CFMyq1nPPupNOO43DOFm4Iqpjbw209hYGsHYlT8ibODe9fwUQKbPwXQPezlAz+iiA0JWQbXOyhwc7Ux4njMZG7hLCF83c7Oq8GCVZm9D1lAt+SSO0MQHKm8EejcK1FhWC4UmkS/hXSatc/s7Bq92oxMhHoAavuYF43SWpUcu6LANIHgw3yFly8BkxipLm3NXH2VigJJxj57kPIj9tcG0pjaYYsLEmpxKDeVWKr+SA==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443bb927-0ae8-47b0-9cdc-08dbf53ee1ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 03:04:23.1355 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NKzoBte+XmvE9EUMOO3Hh7JTw73h/DTDqUfOXc4uTmTreh288Xc6psKHmREHGU4BCPiK3SeDoudm19DT/T0RNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6901
X-Proofpoint-ORIG-GUID: nGPZ2W09cWazdjqbix-qbyfvPacdUjsQ
X-Proofpoint-GUID: nGPZ2W09cWazdjqbix-qbyfvPacdUjsQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_24,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=731 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050024
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
PGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBEZWNlbWJlciA0LCAy
MDIzIDc6NTMgUE0NCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogQnJpYW4gQ2Fp
biA8YmNhaW5AcXVpY2luYy5jb20+OyBNYXRoZXVzIEJlcm5hcmRpbm8gKFFVSUMpDQo+IDxxdWlj
X21hdGhiZXJuQHF1aWNpbmMuY29tPjsgU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+
OyBNYXJjbw0KPiBMaWViZWwgKFFVSUMpIDxxdWljX21saWViZWxAcXVpY2luYy5jb20+OyByaWNo
YXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOw0KPiBwaGlsbWRAbGluYXJvLm9yZzsgYWxlQHJldi5u
ZzsgYW5qb0ByZXYubmc7IGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBbUEFU
Q0ggMS85XSBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgQ2xlYW4gdXAgaGFuZGxpbmcgb2YgbW9k
aWZpZXINCj4gcmVnaXN0ZXJzDQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQg
ZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZg0KPiBhbnkgbGlua3Mg
b3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+IEN1cnJlbnRs
eSwgdGhlIHJlZ2lzdGVyIG51bWJlciAoTXVOKSBmb3IgbW9kaWZpZXIgcmVnaXN0ZXJzIGlzIHRo
ZQ0KPiBtb2RpZmllciByZWdpc3RlciBudW1iZXIgcmF0aGVyIHRoYW4gdGhlIGluZGV4IGludG8g
aGV4X2dwci4gIFRoaXMNCj4gcGF0Y2ggY2hhbmdlcyBNdU4gdG8gdGhlIGhleF9ncHIgaW5kZXgs
IHdoaWNoIGlzIGNvbnNpc3RlbnQgd2l0aA0KPiB0aGUgaGFuZGxpbmcgb2YgY29udHJvbCByZWdp
c3RlcnMuDQo+IA0KPiBOb3RlIHRoYXQgSEVMUEVSKGZjaXJjYWRkKSBuZWVkcyB0aGUgQ1MgcmVn
aXN0ZXIgY29ycmVzcG9uZGluZyB0byB0aGUNCj4gbW9kaWZpZXIgcmVnaXN0ZXIgc3BlY2lmaWVk
IGluIHRoZSBpbnN0cnVjdGlvbi4gIFdlIGNyZWF0ZSBhIFRDR3YNCj4gdmFyaWFibGUgIkNTIiB0
byBob2xkIHRoZSB2YWx1ZSB0byBwYXNzIHRvIHRoZSBoZWxwZXIuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPg0KPiAtLS0NCj4g
IHRhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCAgICAgICAgICAgICAgICAgICAgfCAgOSArKysrLS0t
LS0NCj4gIHRhcmdldC9oZXhhZ29uL21hY3Jvcy5oICAgICAgICAgICAgICAgICAgICAgfCAgMyAr
LS0NCj4gIHRhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJzLmMgfCAgOCAr
KystLS0tLQ0KPiAgdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19mdW5jcy5weSAgICAgICAgICAgICB8
IDEzICsrKysrKysrKy0tLS0NCj4gIDQgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwg
MTYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3Rj
Zy5oIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oDQo+IGluZGV4IGQ5OTIwNTlmY2UuLjFjNDM5
MWI0MTUgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaA0KPiArKysgYi90
YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmgNCj4gQEAgLTY4LDE1ICs2OCwxNCBAQA0KPiAgICAgIGRv
IHsgXA0KPiAgICAgICAgICBUQ0d2IHRjZ3Zfc2lWID0gdGNnX2NvbnN0YW50X3RsKHNpVik7IFwN
Cj4gICAgICAgICAgdGNnX2dlbl9tb3ZfdGwoRUEsIFJ4Vik7IFwNCj4gLSAgICAgICAgZ2VuX2hl
bHBlcl9mY2lyY2FkZChSeFYsIFJ4ViwgdGNndl9zaVYsIE11ViwgXA0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGhleF9ncHJbSEVYX1JFR19DUzAgKyBNdU5dKTsgXA0KPiArICAgICAg
ICBnZW5faGVscGVyX2ZjaXJjYWRkKFJ4ViwgUnhWLCB0Y2d2X3NpViwgTXVWLCBDUyk7IFwNCj4g
ICAgICB9IHdoaWxlICgwKQ0KPiAgI2RlZmluZSBHRVRfRUFfcGNyKFNISUZUKSBcDQo+ICAgICAg
ZG8geyBcDQo+ICAgICAgICAgIFRDR3YgaXJlZyA9IHRjZ190ZW1wX25ldygpOyBcDQo+ICAgICAg
ICAgIHRjZ19nZW5fbW92X3RsKEVBLCBSeFYpOyBcDQo+ICAgICAgICAgIGdlbl9yZWFkX2lyZWco
aXJlZywgTXVWLCAoU0hJRlQpKTsgXA0KPiAtICAgICAgICBnZW5faGVscGVyX2ZjaXJjYWRkKFJ4
ViwgUnhWLCBpcmVnLCBNdVYsIGhleF9ncHJbSEVYX1JFR19DUzAgKw0KPiBNdU5dKTsgXA0KPiAr
ICAgICAgICBnZW5faGVscGVyX2ZjaXJjYWRkKFJ4ViwgUnhWLCBpcmVnLCBNdVYsIENTKTsgXA0K
PiAgICAgIH0gd2hpbGUgKDApDQo+IA0KPiAgLyogSW5zdHJ1Y3Rpb25zIHdpdGggbXVsdGlwbGUg
ZGVmaW5pdGlvbnMgKi8NCj4gQEAgLTExMyw3ICsxMTIsNyBAQA0KPiAgICAgICAgICBUQ0d2IGly
ZWcgPSB0Y2dfdGVtcF9uZXcoKTsgXA0KPiAgICAgICAgICB0Y2dfZ2VuX21vdl90bChFQSwgUnhW
KTsgXA0KPiAgICAgICAgICBnZW5fcmVhZF9pcmVnKGlyZWcsIE11ViwgU0hJRlQpOyBcDQo+IC0g
ICAgICAgIGdlbl9oZWxwZXJfZmNpcmNhZGQoUnhWLCBSeFYsIGlyZWcsIE11ViwgaGV4X2dwcltI
RVhfUkVHX0NTMCArDQo+IE11Tl0pOyBcDQo+ICsgICAgICAgIGdlbl9oZWxwZXJfZmNpcmNhZGQo
UnhWLCBSeFYsIGlyZWcsIE11ViwgQ1MpOyBcDQo+ICAgICAgICAgIExPQUQ7IFwNCj4gICAgICB9
IHdoaWxlICgwKQ0KPiANCj4gQEAgLTQyNyw3ICs0MjYsNyBAQA0KPiAgICAgICAgICBUQ0d2IEJZ
VEUgR19HTlVDX1VOVVNFRCA9IHRjZ190ZW1wX25ldygpOyBcDQo+ICAgICAgICAgIHRjZ19nZW5f
bW92X3RsKEVBLCBSeFYpOyBcDQo+ICAgICAgICAgIGdlbl9yZWFkX2lyZWcoaXJlZywgTXVWLCBT
SElGVCk7IFwNCj4gLSAgICAgICAgZ2VuX2hlbHBlcl9mY2lyY2FkZChSeFYsIFJ4ViwgaXJlZywg
TXVWLCBoZXhfZ3ByW0hFWF9SRUdfQ1MwICsNCj4gTXVOXSk7IFwNCj4gKyAgICAgICAgZ2VuX2hl
bHBlcl9mY2lyY2FkZChSeFYsIFJ4ViwgaXJlZywgTXVWLCBDUyk7IFwNCj4gICAgICAgICAgU1RP
UkU7IFwNCj4gICAgICB9IHdoaWxlICgwKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL21hY3Jvcy5oIGIvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgNCj4gaW5kZXggOWE1MWI1NzA5
Yi4uOTM5ZjIyZTc2YiAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgNCj4g
KysrIGIvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgNCj4gQEAgLTQ2Miw4ICs0NjIsNyBAQCBzdGF0
aWMgaW5saW5lIFRDR3YgZ2VuX3JlYWRfaXJlZyhUQ0d2IHJlc3VsdCwgVENHdiB2YWwsDQo+IGlu
dCBzaGlmdCkNCj4gICNkZWZpbmUgZlBNX0NJUkkoUkVHLCBJTU0sIE1WQUwpIFwNCj4gICAgICBk
byB7IFwNCj4gICAgICAgICAgVENHdiB0Y2d2X3NpViA9IHRjZ19jb25zdGFudF90bChzaVYpOyBc
DQo+IC0gICAgICAgIGdlbl9oZWxwZXJfZmNpcmNhZGQoUkVHLCBSRUcsIHRjZ3Zfc2lWLCBNdVYs
IFwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICBoZXhfZ3ByW0hFWF9SRUdfQ1MwICsg
TXVOXSk7IFwNCj4gKyAgICAgICAgZ2VuX2hlbHBlcl9mY2lyY2FkZChSRUcsIFJFRywgdGNndl9z
aVYsIE11ViwgQ1MpOyBcDQo+ICAgICAgfSB3aGlsZSAoMCkNCj4gICNlbHNlDQo+ICAjZGVmaW5l
IGZFQV9JTU0oSU1NKSAgICAgICAgZG8geyBFQSA9IChJTU0pOyB9IHdoaWxlICgwKQ0KPiBkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuYyBiL3Rh
cmdldC9oZXhhZ29uL2lkZWYtDQo+IHBhcnNlci9wYXJzZXItaGVscGVycy5jDQo+IGluZGV4IDRh
ZjAyMDkzM2EuLjk1ZjJiNDMwNzYgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9oZXhhZ29uL2lkZWYt
cGFyc2VyL3BhcnNlci1oZWxwZXJzLmMNCj4gKysrIGIvdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJz
ZXIvcGFyc2VyLWhlbHBlcnMuYw0KPiBAQCAtMTU0MSwxMCArMTU0MSw4IEBAIHZvaWQgZ2VuX2Np
cmNfb3AoQ29udGV4dCAqYywNCj4gICAgICAgICAgICAgICAgICAgSGV4VmFsdWUgKmluY3JlbWVu
dCwNCj4gICAgICAgICAgICAgICAgICAgSGV4VmFsdWUgKm1vZGlmaWVyKQ0KPiAgew0KPiAtICAg
IEhleFZhbHVlIGNzID0gZ2VuX3RtcChjLCBsb2NwLCAzMiwgVU5TSUdORUQpOw0KPiAgICAgIEhl
eFZhbHVlIGluY3JlbWVudF9tID0gKmluY3JlbWVudDsNCj4gICAgICBpbmNyZW1lbnRfbSA9IHJ2
YWx1ZV9tYXRlcmlhbGl6ZShjLCBsb2NwLCAmaW5jcmVtZW50X20pOw0KPiAtICAgIE9VVChjLCBs
b2NwLCAiZ2VuX3JlYWRfcmVnKCIsICZjcywgIiwgSEVYX1JFR19DUzAgKyBNdU4pO1xuIik7DQo+
ICAgICAgT1VUKGMsDQo+ICAgICAgICAgIGxvY3AsDQo+ICAgICAgICAgICJnZW5faGVscGVyX2Zj
aXJjYWRkKCIsDQo+IEBAIC0xNTU1LDcgKzE1NTMsNyBAQCB2b2lkIGdlbl9jaXJjX29wKENvbnRl
eHQgKmMsDQo+ICAgICAgICAgICZpbmNyZW1lbnRfbSwNCj4gICAgICAgICAgIiwgIiwNCj4gICAg
ICAgICAgbW9kaWZpZXIpOw0KPiAtICAgIE9VVChjLCBsb2NwLCAiLCAiLCAmY3MsICIpO1xuIik7
DQo+ICsgICAgT1VUKGMsIGxvY3AsICIsIENTKTtcbiIpOw0KPiAgfQ0KPiANCj4gIEhleFZhbHVl
IGdlbl9sb2NudF9vcChDb250ZXh0ICpjLCBZWUxUWVBFICpsb2NwLCBIZXhWYWx1ZSAqc3JjKQ0K
PiBAQCAtMjA4MCw5ICsyMDc4LDkgQEAgdm9pZCBlbWl0X2FyZyhDb250ZXh0ICpjLCBZWUxUWVBF
ICpsb2NwLCBIZXhWYWx1ZQ0KPiAqYXJnKQ0KPiAgICAgICAgICAgICAgY2hhciByZWdfaWRbNV07
DQo+ICAgICAgICAgICAgICByZWdfY29tcG9zZShjLCBsb2NwLCAmKGFyZy0+cmVnKSwgcmVnX2lk
KTsNCj4gICAgICAgICAgICAgIEVNSVRfU0lHKGMsICIsICVzICVzIiwgdHlwZSwgcmVnX2lkKTsN
Cj4gLSAgICAgICAgICAgIC8qIE11ViByZWdpc3RlciByZXF1aXJlcyBhbHNvIE11TiB0byBwcm92
aWRlIGl0cyBpbmRleCAqLw0KPiArICAgICAgICAgICAgLyogTXVWIHJlZ2lzdGVyIHJlcXVpcmVz
IGFsc28gQ1MgZm9yIGNpcmN1bGFyIGFkZHJlc3NpbmcqLw0KPiAgICAgICAgICAgICAgaWYgKGFy
Zy0+cmVnLnR5cGUgPT0gTU9ESUZJRVIpIHsNCj4gLSAgICAgICAgICAgICAgICBFTUlUX1NJRyhj
LCAiLCBpbnQgTXVOIik7DQo+ICsgICAgICAgICAgICAgICAgRU1JVF9TSUcoYywgIiwgVENHdiBD
UyIpOw0KPiAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICB9DQo+ICAgICAgICAgIGJyZWFrOw0K
PiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19mdW5jcy5weQ0KPiBiL3Rhcmdl
dC9oZXhhZ29uL2dlbl90Y2dfZnVuY3MucHkNCj4gaW5kZXggZjUyNDZjZWU2ZC4uMDJkOTNiYzVj
ZSAxMDA3NTUNCj4gLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19mdW5jcy5weQ0KPiArKysg
Yi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2Z1bmNzLnB5DQo+IEBAIC05OSwxMCArOTksMTUgQEAg
ZGVmIGdlbnB0cl9kZWNsKGYsIHRhZywgcmVndHlwZSwgcmVnaWQsIHJlZ25vKToNCj4gICAgICAg
ICAgICAgIGhleF9jb21tb24uYmFkX3JlZ2lzdGVyKHJlZ3R5cGUsIHJlZ2lkKQ0KPiAgICAgIGVs
aWYgcmVndHlwZSA9PSAiTSI6DQo+ICAgICAgICAgIGlmIHJlZ2lkID09ICJ1IjoNCj4gLSAgICAg
ICAgICAgIGYud3JpdGUoZiIgICAgY29uc3QgaW50IHtyZWd0eXBlfXtyZWdpZH1OID0gIiBmImlu
c24tPnJlZ25vW3tyZWdub31dO1xuIikNCj4gICAgICAgICAgICAgIGYud3JpdGUoDQo+IC0gICAg
ICAgICAgICAgICAgZiIgICAgVENHdiB7cmVndHlwZX17cmVnaWR9ViA9IGhleF9ncHJbe3JlZ3R5
cGV9e3JlZ2lkfU4gKyAiDQo+IC0gICAgICAgICAgICAgICAgIkhFWF9SRUdfTTBdO1xuIg0KPiAr
ICAgICAgICAgICAgICAgIGYiICAgIGNvbnN0IGludCB7cmVnTn0gPSBpbnNuLT5yZWdub1t7cmVn
bm99XSArIEhFWF9SRUdfTTA7XG4iDQo+ICsgICAgICAgICAgICApDQo+ICsgICAgICAgICAgICBm
LndyaXRlKA0KPiArICAgICAgICAgICAgICAgIGYiICAgIFRDR3Yge3JlZ3R5cGV9e3JlZ2lkfVYg
PSBoZXhfZ3ByW3tyZWdOfV07XG4iDQo+ICsgICAgICAgICAgICApDQo+ICsgICAgICAgICAgICBm
LndyaXRlKA0KPiArICAgICAgICAgICAgICAgIGYiICAgIFRDR3YgQ1MgR19HTlVDX1VOVVNFRCA9
ICINCj4gKyAgICAgICAgICAgICAgICBmImhleF9ncHJbe3JlZ059IC0gSEVYX1JFR19NMCArIEhF
WF9SRUdfQ1MwXTtcbiINCj4gICAgICAgICAgICAgICkNCj4gICAgICAgICAgZWxzZToNCj4gICAg
ICAgICAgICAgIGhleF9jb21tb24uYmFkX3JlZ2lzdGVyKHJlZ3R5cGUsIHJlZ2lkKQ0KPiBAQCAt
NTI4LDcgKzUzMyw3IEBAIGRlZiBnZW5fdGNnX2Z1bmMoZiwgdGFnLCByZWdzLCBpbW1zKToNCj4g
ICAgICAgICAgICAgICk6DQo+ICAgICAgICAgICAgICAgICAgZGVjbGFyZWQuYXBwZW5kKGYie3Jl
Z3R5cGV9e3JlZ2lkfVYiKQ0KPiAgICAgICAgICAgICAgICAgIGlmIHJlZ3R5cGUgPT0gIk0iOg0K
PiAtICAgICAgICAgICAgICAgICAgICBkZWNsYXJlZC5hcHBlbmQoZiJ7cmVndHlwZX17cmVnaWR9
TiIpDQo+ICsgICAgICAgICAgICAgICAgICAgIGRlY2xhcmVkLmFwcGVuZCgiQ1MiKQ0KPiAgICAg
ICAgICAgICAgZWxpZiBoZXhfY29tbW9uLmlzX25ld192YWwocmVndHlwZSwgcmVnaWQsIHRhZyk6
DQo+ICAgICAgICAgICAgICAgICAgZGVjbGFyZWQuYXBwZW5kKGYie3JlZ3R5cGV9e3JlZ2lkfU4i
KQ0KPiAgICAgICAgICAgICAgZWxzZToNCj4gLS0NCj4gMi4zNC4xDQoNClJldmlld2VkLWJ5OiBC
cmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4NCg==

