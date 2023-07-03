Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F2C746526
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 23:52:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGRSy-0000r8-TH; Mon, 03 Jul 2023 17:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qGRSw-0000qo-MY
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 17:52:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qGRSu-00025T-Fr
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 17:52:14 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 363LmHO0011300; Mon, 3 Jul 2023 21:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=nb3qPgh+g4au3woVwiKH3WGkIS4RSbYCNKUV1OcM6+c=;
 b=hRwf/dttX4WEVt32vQ8IN6dIr7Re/c7PK4FCQtIlNvJCguEabU2tZHILEJLwqapeM6eC
 I823tQ2mLP0EprWIEBYwipO1H03fYhKNCeXZAEfSg/9ow+MajlODNonmbGUq3P6ZMRp0
 N1o9UNqPqmNPnzmPGLze5uDsvK+pCngPk+DbrqThtSecRwwZrXpklXxa61T8xsXF5oTh
 pT9rCAAU4R9rOKij08+DuIkE7ywXf1hyZsoo4rT1xgKtsfYR3Qx2qDu8XdCHv5ONaAk8
 LgwGIFgcJ/0Wy0loXRZH+90oeIxk8myrCdJpsxgMn8mrBt/A57TROy9OT8TJn2oypdKJ IA== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rky5mgwtr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 21:52:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2W/odqtja7g39mxJchvDeBtLYV2pw4sax5RG8fR3E/VoAcme5IeCsMboycffmmmQOSHloqGC3FUMyliDThCcB3jbTnMSV0H9zA1GtuLPAkCqUIa+Y+Sjggjl5/jkJAEOc9bL16+tz6cr0+l6rKOw5S9OyXU4Wlg2O5IANXbVbSkv/mRJmj+LCt8+8moiN0DLhdLbczyUTXoE5B1gFMJBbCXRtWlkDeMQms2L/qmmpIAb9afkfn9Zla2qvgar7DzG5Xi7IeO2u8YFBNrFZo/thpMbWmgGvVnLZ3cYeHlITsypQntY37RPRqfKmwYG+vEqIYGZYsm5TOnmnqUjO8jeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nb3qPgh+g4au3woVwiKH3WGkIS4RSbYCNKUV1OcM6+c=;
 b=MPoZmYVUJQddw06epgO57Nbx6WetMXxLRtx/hwS26QD02JjzPIQ86KFpdX1jtFGn9MiVcNxqpP8+6je60OE1nVcTFbsOlGMj88i56fJT7FbenbGyC5WlJNTtVYwO9V9RVrlvnwgjpPclLppXs9EEN8gq7U1ezvmB6uUu1588UWKjpgl98D38faEE5ugLIqEc02EY1AQdkw9DahwLKZMJGEgBxTC+GwH7KphqDQQhoTfGg8Mp6GU5eOr0Wa1MtsGm1LT97nZ4nVfUWr8hLc/d7BedGBgvN1Knev+06NTlG1kUcdMVkhNOszz3Nh4dZVPaaOf3S0e8Uf8mGkudNstFFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by CH2PR02MB6968.namprd02.prod.outlook.com (2603:10b6:610:8b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.13; Mon, 3 Jul
 2023 21:52:04 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::948c:d843:8389:cfeb]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::948c:d843:8389:cfeb%5]) with mapi id 15.20.6565.011; Mon, 3 Jul 2023
 21:52:02 +0000
From: Brian Cain <bcain@quicinc.com>
To: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>
Subject: RE: [PATCH] Hexagon: move GETPC() calls to top level helpers
Thread-Topic: [PATCH] Hexagon: move GETPC() calls to top level helpers
Thread-Index: AQHZrfhP24UbNvexZk26teXHyn1UJq+olSEQ
Date: Mon, 3 Jul 2023 21:52:02 +0000
Message-ID: <SN6PR02MB4205C7894F08F963A752A6B8B829A@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <d40fabcf9d6e92e4cd8d6a144e9b2a9acf4580dc.1688420966.git.quic_mathbern@quicinc.com>
In-Reply-To: <d40fabcf9d6e92e4cd8d6a144e9b2a9acf4580dc.1688420966.git.quic_mathbern@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|CH2PR02MB6968:EE_
x-ms-office365-filtering-correlation-id: 9f0b18cd-cbb1-49c8-23a7-08db7c0fbbff
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dfV5t8+8zJZj37jANLtenLyIXiENJwFHQ96r3iYshH2KF3JVzlG8YvW2Cb0Xdmi6YJAgyNXNc+mqywC0jf7Y+vefo5kGAoqn47N0tTidSNm8ChP36lq1netYiWP6nxQGl9/jQfOMqHcuJKNAXAEx+T16S0ZTySlwNYGB8nV/ti5H6aGLR3z3Q5OJxtS0swr0xIKIxj5fKAy0pdW7Pjl3QYF7hFxG3jVpSJ/sMSJOUcgEmfI23p+fwhh4pqHlfk/2SHB/Wgw8OMiVWm0+feHFLJ1RfjRId8xjoA1SrI+8BRCpxk4bIeRsP0RLF4jAsGhT11cHniWkgTf1+ARFzGkstQ40k6ecuEDjmS2q6h5ltwwwNOn45bYfQIMLndLtCziKFP3qw7zOaKg7o68KydhBXfnlR/GID1GmtlwZ/QOK/nvKnAhYQnOJO9N9sD5nzPia9su2NDgdy6DVVYGVyycW/6wqJbxRCxJF7Ez6fSIhi3Zq8muD7wJvnD9FJEZQIIuPbecTB1aW9amddqoxxwq3u+lZ65NA/FusYglTkuAu/x/QFdOmtL9R5grB0zFRtMZotp1VzCgFpqDWzONxZaqYaY9Hm3LquV7qLQ81bXWbaoGJswoDe5pFoOQxYUHc4se5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199021)(2906002)(8676002)(41300700001)(5660300002)(52536014)(38070700005)(8936002)(33656002)(55016003)(86362001)(7696005)(478600001)(71200400001)(83380400001)(186003)(9686003)(53546011)(26005)(110136005)(66556008)(66476007)(54906003)(6506007)(64756008)(122000001)(4326008)(66446008)(66946007)(316002)(76116006)(38100700002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A5BfOW7uhZyia/LbnsULiojkXIPgZU9yy8UrI8NdCoaX0WD5G6Fr+wLTfJ24?=
 =?us-ascii?Q?54XK94CV/U9V0xwqDAa8xOGpw591kLzmLOnmEAUqZj4FqO8imFwBYNNzNKXc?=
 =?us-ascii?Q?4umzU95Axvnr3dGHCP13tX+qHStQzgZcw33Gim1Rjny6Ff+pAlo2qhzODzw4?=
 =?us-ascii?Q?/n9gx+1wjTzzPPJ4/XhVpM+DqLgpZPWcYo/cU76ZI/4bgmBtL7u+MphdvmUf?=
 =?us-ascii?Q?QDiA/D4kW32XcA5jkGtF5MgVzBF6AXH0dBEcYP6dorAfeSAbc/dVKXm3KO1o?=
 =?us-ascii?Q?VVnSRV5m4nc8tnVV7awOx/CSk6ibzG+lifOvwZzVX/joJjqMQ4p7aQWvoH4D?=
 =?us-ascii?Q?Y4PaGV0rj1xC8rKHbl7KAPWnpYPq0GaKxDne6db+6x/kHSuNSFJ5dtGqRyx6?=
 =?us-ascii?Q?jUgf6Slq7NffRkUwFgHrDBPDPzcknEeVtbn+et+LEh6RQtPtVeMTLXJGmal9?=
 =?us-ascii?Q?yUhECQnbfQjNQqRizueGqtW+ejRwW4UbgngHkcHt0AfOYMn0CZbm6q6yUyJc?=
 =?us-ascii?Q?qxh5/xyVpvCoxHpUTd/JKwLTRgx1/EoOU60rpF+uVjvpXKyLhzKiaJE6oFIP?=
 =?us-ascii?Q?c9g4zMwTDH9OWTBIesLEloXGqNgyL7g/Fi9N6RxqbJoP0UQbObA22R2kuEl5?=
 =?us-ascii?Q?Izw7b+EGRx1kaCpS/JDKhk1qa99fxAX93/L38eGsSnehjlcruoAcFi8MRdiR?=
 =?us-ascii?Q?pQiJcqcFyZ1s1jydXR48XcIo1G5RBRynJVXoFqd3uPQfa9mQ0qYDPM3Zk5Tf?=
 =?us-ascii?Q?8EorIEVwAil+x5F8ErZ+i9vulB93CUj/PxdLA/a3JIj5P1RtRY3RUEel66FX?=
 =?us-ascii?Q?yhlc+QRpQljUdUuHYjjM/GMJlRVBDFmBcooImQMLkcvSWriK6rHKwtn4ZQaJ?=
 =?us-ascii?Q?CRop/Pj2KOhuXkqA06MbXI2W2Lf5bt9UT9I5u1enCRXzZ9CHAhQVDnsoxtdQ?=
 =?us-ascii?Q?vOmkpQaG7DZAV6VBqcpVebeJfKHgMwGwCQCkdPBYH0YjzluoPhOa7f/giXF5?=
 =?us-ascii?Q?w3CtiUQrLtCKO3139lhHdfM2fZqFbp91su0lt/OuRo8G0AG49w9shcPa0Al1?=
 =?us-ascii?Q?FJ9PLofIR7gVoY6x7ssnorqzBkEqH0texYYsH96xx+z49mCDCLXrHjEj5sqr?=
 =?us-ascii?Q?0UY9GrW5HndyWYD7HdiPsyWGG4HVO8ZUfOeuRWxAC7VrP3RZ+hIxBdDR46/z?=
 =?us-ascii?Q?6Nno+5EESlFLSpp+tMYqA47hKUzy431PwvTWpCczZ9JBbsv08Hn75tU5/FZT?=
 =?us-ascii?Q?Yn8nFF+aiLNkLnqJHxxfblB2WGvujhw3eWWYCDUuhdszO4IWmqmRH4oMeuP/?=
 =?us-ascii?Q?ul+SGwWG3heiBMj+3kpkrsnGiS0j6Z0x3G7DHjJpDdeGMqMSXvVS/uONoUqJ?=
 =?us-ascii?Q?d3gSd+Zo92+QyLU5F9Gn1Vk6qCkvQtVSXvVvZIyNWElujKakuo+CuusKTM4O?=
 =?us-ascii?Q?3ORQpYtolsa9l3SC8ch9UAH5Roc6tSejME26EQngRdky6e5lkbZyxZyJ5TV2?=
 =?us-ascii?Q?Ac95eletVo5nywWzUQI79Qu4o+lpaNGL8eK6UV5d3oSYYYkb1JAcj/Vypkee?=
 =?us-ascii?Q?Z1Yi+zAwvyxmHc0794y/rQvIvXsC3gYx5RGvnjxe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zfAm3tdEA4V9M2q9VmeHv7JKm5/252fzam0OiXkUVFXb9mw91T2JJ6cAIogz9rLoVvjwwGnurXq+xmE1QwnAviERo1i2IJtUlOcAqdvp1bp49umW3EF9t0Z23EBrJ90sihqnXk8oBuBScikqAk3uN2LWI1PORc+QKXxZXX+/kYknz67tLI5AIY0PQPSuVSJql4dn48He3rpYiygovOYOfcua4qXFfvf3rLYX04FEnOxdxzUuKn2Vmh9akZt9S4q/CcfLWRsV8Qvwdt+W0efm7ReItsu4Drun8TcV7WnSYrKIZiT+8J67A8Bc/jYSNvgEiyuVomKkiXHOr2BZhO/1tKzgSGBkFvkc0vw5boiRMqNo9FA4VSBIp+4J8O8Iw3gdcnphLhD0B1oWYh0JJFzdWbYMb7SLaxuQdLwnOSEiQBcGfpUpZYGFZYKVc7gQTQu5XB5RmhMdkpvDOp7R0gWBz/k38mrefg6fOishh7/nvkFv5exSIIUAeDi4WBzcr72eDEv/o/AZMjGOyNLlcG2mn6jxBO8imyKszLtnnGk3C+MiYYgvSyhTH7K8Zg7D3U2pSsHI+f2a7KZo3TVJ9DUuzR0cABsb8CTB/QHjIehtWGMI2Q3JpCgK7QmBffcTEqBmKYIdXH+MzHkxAMpZXkLdaQHBkzc9VXqwQIuyaOaXP8vBe9JahCGDohLyPKaggpt8QzH/KhTJOTWATs9fKtBa892pSwztX8tVvjopa/CxYqx044ybo8LSbSRfcBoW5nZ28eSTfW8zcVEcR38o1nXHzoN+PmK1BOFoSniRIY2h648=
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0b18cd-cbb1-49c8-23a7-08db7c0fbbff
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 21:52:02.3233 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qVohHNuUmwkiOsM9kSRPzZcJHpQqO4+uJTmGJY76XY37G0q5zJnTbxh/4UIYhOYrBz58roE6eE6v95nbbm4E0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6968
X-Proofpoint-ORIG-GUID: AG1VeiioSXlv0zkapAgdoLZHMLu9uYwP
X-Proofpoint-GUID: AG1VeiioSXlv0zkapAgdoLZHMLu9uYwP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_15,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0
 spamscore=0 clxscore=1011 mlxscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030200
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


> -----Original Message-----
> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Sent: Monday, July 3, 2023 4:50 PM
> To: qemu-devel@nongnu.org
> Cc: Brian Cain <bcain@quicinc.com>; Marco Liebel (QUIC)
> <quic_mliebel@quicinc.com>; ltaylorsimpson@gmail.com
> Subject: [PATCH] Hexagon: move GETPC() calls to top level helpers
>=20
> As docs/devel/loads-stores.rst states:
>=20
>   ``GETPC()`` should be used with great care: calling
>   it in other functions that are *not* the top level
>   ``HELPER(foo)`` will cause unexpected behavior. Instead, the
>   value of ``GETPC()`` should be read from the helper and passed
>   if needed to the functions that the helper calls.
>=20
> Let's fix the GETPC() usage in Hexagon, making sure it's always called
> from top level helpers and passed down to the places where it's
> needed. There are two snippets where that is not currently the case:
>=20
> - probe_store(), which is only called from two helpers, so it's easy to
>   move GETPC() up.
>=20
> - mem_load*() functions, which are also called directly from helpers,
>   but through the MEM_LOAD*() set of macros. Note that this are only
>   used when compiling with --disable-hexagon-idef-parser.
>=20
>   In this case, we also take this opportunity to simplify the code,
>   unifying the mem_load*() functions.
>=20
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
>  target/hexagon/macros.h    | 22 ++++++++++-------
>  target/hexagon/op_helper.h | 11 ++-------
>  target/hexagon/op_helper.c | 49 +++++++-------------------------------
>  3 files changed, 25 insertions(+), 57 deletions(-)
>=20
> diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
> index 5451b061ee..efb8013912 100644
> --- a/target/hexagon/macros.h
> +++ b/target/hexagon/macros.h
> @@ -173,14 +173,20 @@
>  #define MEM_STORE8(VA, DATA, SLOT) \
>      MEM_STORE8_FUNC(DATA)(cpu_env, VA, DATA, SLOT)
>  #else
> -#define MEM_LOAD1s(VA) ((int8_t)mem_load1(env, pkt_has_store_s1, slot,
> VA))
> -#define MEM_LOAD1u(VA) ((uint8_t)mem_load1(env, pkt_has_store_s1, slot,
> VA))
> -#define MEM_LOAD2s(VA) ((int16_t)mem_load2(env, pkt_has_store_s1, slot,
> VA))
> -#define MEM_LOAD2u(VA) ((uint16_t)mem_load2(env, pkt_has_store_s1, slot,
> VA))
> -#define MEM_LOAD4s(VA) ((int32_t)mem_load4(env, pkt_has_store_s1, slot,
> VA))
> -#define MEM_LOAD4u(VA) ((uint32_t)mem_load4(env, pkt_has_store_s1, slot,
> VA))
> -#define MEM_LOAD8s(VA) ((int64_t)mem_load8(env, pkt_has_store_s1, slot,
> VA))
> -#define MEM_LOAD8u(VA) ((uint64_t)mem_load8(env, pkt_has_store_s1, slot,
> VA))
> +
> +#define MEM_LOADn(SIZE, VA) ({ \
> +    check_noshuf(env, pkt_has_store_s1, slot, VA, SIZE); \
> +    cpu_ldub_data_ra(env, VA, GETPC()); \
> +})
> +
> +#define MEM_LOAD1s(VA) ((int8_t)MEM_LOADn(1, VA))
> +#define MEM_LOAD1u(VA) ((uint8_t)MEM_LOADn(1, VA))
> +#define MEM_LOAD2s(VA) ((int16_t)MEM_LOADn(2, VA))
> +#define MEM_LOAD2u(VA) ((uint16_t)MEM_LOADn(2, VA))
> +#define MEM_LOAD4s(VA) ((int32_t)MEM_LOADn(4, VA))
> +#define MEM_LOAD4u(VA) ((uint32_t)MEM_LOADn(4, VA))
> +#define MEM_LOAD8s(VA) ((int64_t)MEM_LOADn(8, VA))
> +#define MEM_LOAD8u(VA) ((uint64_t)MEM_LOADn(8, VA))
>=20
>  #define MEM_STORE1(VA, DATA, SLOT) log_store32(env, VA, DATA, 1, SLOT)
>  #define MEM_STORE2(VA, DATA, SLOT) log_store32(env, VA, DATA, 2, SLOT)
> diff --git a/target/hexagon/op_helper.h b/target/hexagon/op_helper.h
> index 8f3764d15e..845c3d197e 100644
> --- a/target/hexagon/op_helper.h
> +++ b/target/hexagon/op_helper.h
> @@ -19,15 +19,8 @@
>  #define HEXAGON_OP_HELPER_H
>=20
>  /* Misc functions */
> -uint8_t mem_load1(CPUHexagonState *env, bool pkt_has_store_s1,
> -                  uint32_t slot, target_ulong vaddr);
> -uint16_t mem_load2(CPUHexagonState *env, bool pkt_has_store_s1,
> -                   uint32_t slot, target_ulong vaddr);
> -uint32_t mem_load4(CPUHexagonState *env, bool pkt_has_store_s1,
> -                   uint32_t slot, target_ulong vaddr);
> -uint64_t mem_load8(CPUHexagonState *env, bool pkt_has_store_s1,
> -                   uint32_t slot, target_ulong vaddr);
> -
> +void check_noshuf(CPUHexagonState *env, bool pkt_has_store_s1,
> +                  uint32_t slot, target_ulong vaddr, int size);
>  void log_store64(CPUHexagonState *env, target_ulong addr,
>                   int64_t val, int width, int slot);
>  void log_store32(CPUHexagonState *env, target_ulong addr,
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 12967ac21e..1bc9c7fc2e 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -467,13 +467,12 @@ int32_t HELPER(cabacdecbin_pred)(int64_t RssV,
> int64_t RttV)
>  }
>=20
>  static void probe_store(CPUHexagonState *env, int slot, int mmu_idx,
> -                        bool is_predicated)
> +                        bool is_predicated, uintptr_t retaddr)
>  {
>      if (!is_predicated || !(env->slot_cancelled & (1 << slot))) {
>          size1u_t width =3D env->mem_log_stores[slot].width;
>          target_ulong va =3D env->mem_log_stores[slot].va;
> -        uintptr_t ra =3D GETPC();
> -        probe_write(env, va, width, mmu_idx, ra);
> +        probe_write(env, va, width, mmu_idx, retaddr);
>      }
>  }
>=20
> @@ -494,7 +493,8 @@ void
> HELPER(probe_pkt_scalar_store_s0)(CPUHexagonState *env, int args)
>      int mmu_idx =3D FIELD_EX32(args, PROBE_PKT_SCALAR_STORE_S0,
> MMU_IDX);
>      bool is_predicated =3D
>          FIELD_EX32(args, PROBE_PKT_SCALAR_STORE_S0, IS_PREDICATED);
> -    probe_store(env, 0, mmu_idx, is_predicated);
> +    uintptr_t ra =3D GETPC();
> +    probe_store(env, 0, mmu_idx, is_predicated, ra);
>  }
>=20
>  void HELPER(probe_hvx_stores)(CPUHexagonState *env, int mmu_idx)
> @@ -547,12 +547,13 @@ void
> HELPER(probe_pkt_scalar_hvx_stores)(CPUHexagonState *env, int mask)
>      bool s0_is_pred =3D FIELD_EX32(mask, PROBE_PKT_SCALAR_HVX_STORES,
> S0_IS_PRED);
>      bool s1_is_pred =3D FIELD_EX32(mask, PROBE_PKT_SCALAR_HVX_STORES,
> S1_IS_PRED);
>      int mmu_idx =3D FIELD_EX32(mask, PROBE_PKT_SCALAR_HVX_STORES,
> MMU_IDX);
> +    uintptr_t ra =3D GETPC();
>=20
>      if (has_st0) {
> -        probe_store(env, 0, mmu_idx, s0_is_pred);
> +        probe_store(env, 0, mmu_idx, s0_is_pred, ra);
>      }
>      if (has_st1) {
> -        probe_store(env, 1, mmu_idx, s1_is_pred);
> +        probe_store(env, 1, mmu_idx, s1_is_pred, ra);
>      }
>      if (has_hvx_stores) {
>          HELPER(probe_hvx_stores)(env, mmu_idx);
> @@ -566,8 +567,8 @@ void
> HELPER(probe_pkt_scalar_hvx_stores)(CPUHexagonState *env, int mask)
>   * If the load is in slot 0 and there is a store in slot1 (that
>   * wasn't cancelled), we have to do the store first.
>   */
> -static void check_noshuf(CPUHexagonState *env, bool pkt_has_store_s1,
> -                         uint32_t slot, target_ulong vaddr, int size)
> +void check_noshuf(CPUHexagonState *env, bool pkt_has_store_s1,
> +                  uint32_t slot, target_ulong vaddr, int size)
>  {
>      if (slot =3D=3D 0 && pkt_has_store_s1 &&
>          ((env->slot_cancelled & (1 << 1)) =3D=3D 0)) {
> @@ -576,38 +577,6 @@ static void check_noshuf(CPUHexagonState *env,
> bool pkt_has_store_s1,
>      }
>  }
>=20
> -uint8_t mem_load1(CPUHexagonState *env, bool pkt_has_store_s1,
> -                  uint32_t slot, target_ulong vaddr)
> -{
> -    uintptr_t ra =3D GETPC();
> -    check_noshuf(env, pkt_has_store_s1, slot, vaddr, 1);
> -    return cpu_ldub_data_ra(env, vaddr, ra);
> -}
> -
> -uint16_t mem_load2(CPUHexagonState *env, bool pkt_has_store_s1,
> -                   uint32_t slot, target_ulong vaddr)
> -{
> -    uintptr_t ra =3D GETPC();
> -    check_noshuf(env, pkt_has_store_s1, slot, vaddr, 2);
> -    return cpu_lduw_data_ra(env, vaddr, ra);
> -}
> -
> -uint32_t mem_load4(CPUHexagonState *env, bool pkt_has_store_s1,
> -                   uint32_t slot, target_ulong vaddr)
> -{
> -    uintptr_t ra =3D GETPC();
> -    check_noshuf(env, pkt_has_store_s1, slot, vaddr, 4);
> -    return cpu_ldl_data_ra(env, vaddr, ra);
> -}
> -
> -uint64_t mem_load8(CPUHexagonState *env, bool pkt_has_store_s1,
> -                   uint32_t slot, target_ulong vaddr)
> -{
> -    uintptr_t ra =3D GETPC();
> -    check_noshuf(env, pkt_has_store_s1, slot, vaddr, 8);
> -    return cpu_ldq_data_ra(env, vaddr, ra);
> -}
> -
>  /* Floating point */
>  float64 HELPER(conv_sf2df)(CPUHexagonState *env, float32 RsV)
>  {
> --
> 2.37.2


Reviewed-by: Brian Cain <bcain@quicinc.com>

