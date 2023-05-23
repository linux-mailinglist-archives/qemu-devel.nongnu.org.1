Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3A570E729
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 23:10:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ZGb-0004As-4k; Tue, 23 May 2023 17:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1q1ZGZ-0004Aj-LI
 for qemu-devel@nongnu.org; Tue, 23 May 2023 17:09:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1q1ZGY-0006Rf-03
 for qemu-devel@nongnu.org; Tue, 23 May 2023 17:09:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34NKJddx003166
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 21:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=/j9WZqoJLvDV9mhxWOEhlPRLZmSiaiRclu6ufR/LPUs=;
 b=XYD6fgKbGV4qe3XXaIgIAPbU/mGinSeStirYPYIEZklMFpZpzuA91DLCnZOR9CAH2MyU
 5FTTYRw/bzssnFl/hP8Ex9+/bBfEmHQT/iZzKVpMAGbTo6pUyATwfGtP6MveTCQ80y8f
 U1VbS1Yg5QD77bP1yyKdg9z/Of7QkOnDDpfpKWlkju0eKzKODbiv7FDqucmKDZFW8K2a
 cEJhzc+Nk2mM44iFzT455ASFfFFh836Zm/z8mGnQ86h6HsS86trouN8hY+rlaLf2MWZX
 enYQaZKrVSsHoKjVqln5Cw2rWmIqOJegt8My+J0e+xkhu7NVKbZOsiK0gJ4vnEY7tntW lw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qr8qrc1gc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 21:09:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1klqsLWKzB85h7TFB4MzvFMQ+dFPiPX0kpO5H8wZCLuazGbyi6078etk9R+jCuxQXCAMUgqplXfn6tIOPtSLMIvMPpBrl3dLEefTjaOdz468ke4hEH3Rggr3cAs72A393blbex9UEslfASa+5MHR58MFP+BwH/Qn7N5p0ZXMQh0ndCz7KUR6Jz5beD3K9mFBVqETj4jSknxXSfYoifRPPbnr2y0tVC56lsp1QwPQ+8ma8tLh+JvhhwOev7qXSiOGJHB6fKkkqweMHdJi2kXsZfhtB+T6rb4v/M4n4zerBJGiQ9fae/XNjrdhQOU0xdb8ph1J6iNS4tbWRZZn4AcTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/j9WZqoJLvDV9mhxWOEhlPRLZmSiaiRclu6ufR/LPUs=;
 b=aYY9bqtb79TircvZGOpUQHEZyk+SnekPfozrhcP6GCsLP4DgFx2/n0UB29NMlMeHY5V090fuQSB9HF0AYoEqBLhmqZ43LxiZjHsE0tGp3zIplI0R6L5S+egqO3T3eE9yYcB2CbHvB9Zerc/uIed+KswpYRQLhtTuS2XXIhxsefCmJ8fhT+oO4NFl7AdL9YsQwwyLP5ShIiHUR2XZCm1Obvyl4mTkjy292NGb8RKxfXqdNMArL4slk4QTHisBwgO2NqNElNmxUavZODeLKVQJodmUc0qChd7QL+qkh2gQ26apHy6ANYSRcLNJdniOP5nPJGFhkcmortc/uYDHM2Bbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN4PR0201MB8808.namprd02.prod.outlook.com
 (2603:10b6:806:203::12) by CH3PR02MB9713.namprd02.prod.outlook.com
 (2603:10b6:610:17b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Tue, 23 May
 2023 21:09:53 +0000
Received: from SN4PR0201MB8808.namprd02.prod.outlook.com
 ([fe80::eb63:d1c0:28de:72f5]) by SN4PR0201MB8808.namprd02.prod.outlook.com
 ([fe80::eb63:d1c0:28de:72f5%6]) with mapi id 15.20.6411.027; Tue, 23 May 2023
 21:09:53 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Brian Cain <bcain@quicinc.com>, "Marco Liebel (QUIC)"
 <quic_mliebel@quicinc.com>
Subject: RE: [PATCH 2/2] Hexagon: fix outdated `hex_new_*` references in
 comments
Thread-Topic: [PATCH 2/2] Hexagon: fix outdated `hex_new_*` references in
 comments
Thread-Index: AQHZjbZENYKYf39To0+aY0uYLetIIq9oWYrA
Date: Tue, 23 May 2023 21:09:53 +0000
Message-ID: <SN4PR0201MB88088459F389E007CD82A98FDE409@SN4PR0201MB8808.namprd02.prod.outlook.com>
References: <cover.1684873957.git.quic_mathbern@quicinc.com>
 <eeb2d1a1d3db8c9444db20a3df01fe93faddc3cd.1684873957.git.quic_mathbern@quicinc.com>
In-Reply-To: <eeb2d1a1d3db8c9444db20a3df01fe93faddc3cd.1684873957.git.quic_mathbern@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR0201MB8808:EE_|CH3PR02MB9713:EE_
x-ms-office365-filtering-correlation-id: 3b3c4abd-5a16-4cb1-be7a-08db5bd20db5
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qlFXvLWHt85ltfZlJ8FLke4zjEEvVWHAEzv+RUjyOhKv3tv4F103tEcaYNr2G9okOooxTP/Ja32cwOfRdbC35NYS6XYQzXgoT/Ai2eJyBnBWj/c4uodKj/hKyr+7W0EaxwwEGB8jjpLoZcDXiAFA/larKC8EsYeLYRckSbxFjecI+LflfD/EnzpWmFlMVijhUtRx55uHaeB3DNP7DdNSwl0PhQhckShIv4S+9IYPfMWOwH9roJr437m4dWp/fdXu3kIyzI+9T3YLuxreNhwV67CnaFZM1RJUvvY83mRVrHHJ/yr5SvyAU0dshZT+2JiZAHV6EJaJAuGaHUK20T/eNA2JZTs9uFaq3tIek1m//ZF7YlyI2erKMANZvi3CI2U+5OJ6R4WbmmnCtUp8tVHQc/Bi6Y4okd/aaRyEHznSXUosr9thFIyDLED6+H86mpuJPRj3fm63B8ksYyV/ZK5pVebnu0CMiqD+4mB09ee35F7st+xnYyL4DGYVCilKzTMZ8F75C1ThpI0qMfm2gLWs5t5OKQBzbYIXDr1WFqbyI7z55EXlSklJaR0Yis9Jlt9JHy+7AaZA2i8wi/6ByWvns/sGJgoAhV+KXjfsej6zvCyr0zTKMszIhI3PQANvQTklWZP3WTKYxzFyt+2+MCYvFQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0201MB8808.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(8936002)(5660300002)(52536014)(83380400001)(186003)(6506007)(26005)(9686003)(38100700002)(86362001)(122000001)(53546011)(107886003)(38070700005)(8676002)(41300700001)(7696005)(55016003)(71200400001)(33656002)(66556008)(66446008)(66946007)(64756008)(66476007)(76116006)(316002)(4326008)(478600001)(110136005)(54906003)(2906002)(81973001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yibqw6jmbrNLbfYIvtdejW77z+P0reBHpzVH2/2hs/Q1eRoyAGIBMbY9pQK8?=
 =?us-ascii?Q?XBj6qJH4VEJs+jCXtv29OzDqQCbqrGluwwpawSexQ/pZ7yxDV0C+7osg73E2?=
 =?us-ascii?Q?VA8iHwvmesMMDN1uDfj8rLUUSieSw+h+g7wT65Cj216SLWvZKJGIbNCIiGAy?=
 =?us-ascii?Q?80TMnveCEkSQ2u0076jaJxVOVeTJ+KScNBtLTQYwCcoInFvXjtjMrxdfIVT7?=
 =?us-ascii?Q?eHdHCtzebGtQI7Zek/TjorUlr+MIikWv5g/eFho0gIkPHBblmh0BzTA4m6Sk?=
 =?us-ascii?Q?8jeYK1ITtKh9JAmPczGtXG8TZiHTz8AOiHobknjMnawI00W0DkQ727J4TPz9?=
 =?us-ascii?Q?GG/S04/VnA7iKAw+LhC1FX6D2kzW3Oy7Djo4TgYRGAYBsBGDsKYLo57+5FF+?=
 =?us-ascii?Q?MZ02gEdGLYsjzOLDEKHzKZUGS3zjK54ry4XJTWwFj7A0UqKEVJmCadTi3pQg?=
 =?us-ascii?Q?8ke1ifGcA/lnbJT4NUywHbNKfu7IXBDjySBf7BZQqo0v68isQbcg3/6XbbNl?=
 =?us-ascii?Q?TzcKH7hK2JDsEapmcgVH41nAr6tT3ptK+nG1DRg/XF4zgsQddZJZmp/ZSE09?=
 =?us-ascii?Q?JQJ3qwc35pWhwMr04uYSWr3V8Vk3Mss2UDVNaxi2FYjUOZPocnPthGPuav5K?=
 =?us-ascii?Q?GeVsx3jO1d7Jcc6o7zC0CR4QRd1iFxm1IbTqJMJEX0v22ec1WMGx0rvNb5Ny?=
 =?us-ascii?Q?rwe5PJGM4UoKbISu5lnmSz1U/ukIRCe86lilL6eEqmBp+eRbRJTTA5AuVQjv?=
 =?us-ascii?Q?IqetNFwmGlVIComM0cOiHYmdib+rx885UhIbkXaUbdqLocG/2FwlT6SEC+nT?=
 =?us-ascii?Q?JgsErLgLnXIp8QB/dPNxi5q1HTdm0T5RvD4TbhWK7ShtHq54gMAR5TiX732D?=
 =?us-ascii?Q?xZcaV2GRhLB7VquPFVyJ0+j7wMClr4Qpjm4uic+yyyhaYhsTsCke9XHTRo25?=
 =?us-ascii?Q?w1HCxBUVfjj0UL+fM/ZFDOg9ed58ylDUUU75cNyEaGTbmZLKVEK7chK4yTwA?=
 =?us-ascii?Q?lQIhDwljQfMRWEobg19katZfLRMjn8NPlY2F0VYUDin4omKCtVmaH32E1LCV?=
 =?us-ascii?Q?AJn+4ry3MbTgfilUeNezCyxiJVRXpYU+NiaJqPrewVOa23dNzVjeM/3iVyCx?=
 =?us-ascii?Q?kC14JqIcjXKxVKbbxqxkNIA7Ugl9Eny+o+fFUl3Cw5v/D8idjCKDPtPNqqVp?=
 =?us-ascii?Q?+kVIGd4oHZnh6mE/IHV7Uy3fYZsXOp2cnCN9jTRiHUTy3CmkzfDl/j3Ik9zo?=
 =?us-ascii?Q?pJWiofR3WEJszWRZYK4ElBaJtybRMxApOoDmW9XbhCxDDv2mBzwKcbHbHsbA?=
 =?us-ascii?Q?ZhUApvNDvu1yIdAJURxuArHCICHUeKbtFccLJAHfSyiWovDyEEG/3O8qBBjR?=
 =?us-ascii?Q?eeeb8/WkNn5sPIEPKKFPMdlu0Fw+H6MLm+Pc+cQz/OJ7PMm+Vn3vJEEU9oR3?=
 =?us-ascii?Q?idlfBdoiX8xwNBeNz/d8zbsKvnwmfMSqrxshj8pg6RcTN910eKNd+i8By8Vy?=
 =?us-ascii?Q?zVl0ZABTI8FeWvJ7SP2vSxaVmazOMdMiVSD+mSIeyh2VMDX9kiyWXVBQdloi?=
 =?us-ascii?Q?JMavGyNb5+Fq/nlEjNDpJmr0o9H/NTgKE02US+I9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zKfiY6cj4m8Y7pcqULGTPM72x5iVpZthz0b//J+wHc7LIfPBEcst825aEg9OD5Xw86MIqeLucVqKyzSHEECpwICms01XpHE3H3tvV5G5+dgMAx8OXeE8mNWG1ggpsL/PaArtMZMQv+LzRK7cXX52hBNpA4aVo1eOK44uIyNoEpPYd4AKzZDJ7GFnDMiP2/1r8pMsJXujk+0QJa29nhI0dUvoENzFiMBOzU1SLCsWBMXbupx27GHJvzsBL7UXhHkucP+fTYUeiBuHDDCppNps97aluSLIBu94pm5PGqFchrfRzdV5sN5RJm7xQZNj5EQxcq4wZk/tQkabevgxUMrYoVTv1QCd2EAo5FFa3ARZ0kSHk0qTHn2JrEfj4BZh0a43Cysjr7LExAaIkU6O6K5gbBUS7nX+DkKVybKr+MbFbwHedZrhrNE38u1It94n3tdtu0+mpjFQZgVc2+o9ioonBCY+B36R6bOeGkvTelDJE2nWTbQyMfeBNPkCTGRirp7VQ7qw9neREwwEiYo/T146sXhFrpuno7AzsEbwvzywIsb36cX4EoQAfh00uxKUjH1Wyk5cychctX93dtDW76SRLKhl+/ziaUqAxTSIxMwlVuA0bT9h6MHZUnMKNA6g+J7O8ab1d856jKJVvD263gLHGhEAOTIxVA9VpxpAeM4SAoUniPLYJDUFwuOA7y9cuY2kTZXvwH8dqRUI0cO9QXMlWia1PSqpCZxsbStf0WCyELfCgLzhRaQms4iTFoRGKCxqw2Ype6BxSTCcybsSdUmHyg==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0201MB8808.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3c4abd-5a16-4cb1-be7a-08db5bd20db5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 21:09:53.4011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZYeNGKX5JEoJPcZ4HX0AlY3cwkuCpBRSkecDjHP6KrfQcTFz6Cgq916z4POETlJklKoN0eOZ2xMrMMpdDPEpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9713
X-Proofpoint-GUID: 7Af1apaHaasiKVM0PA5Hvt4Edwo6ClHp
X-Proofpoint-ORIG-GUID: 7Af1apaHaasiKVM0PA5Hvt4Edwo6ClHp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_14,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=740 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230169
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=tsimpson@quicinc.com; helo=mx0a-0031df01.pphosted.com
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
> Sent: Tuesday, May 23, 2023 3:36 PM
> To: qemu-devel@nongnu.org
> Cc: Taylor Simpson <tsimpson@quicinc.com>; Brian Cain
> <bcain@quicinc.com>; Marco Liebel (QUIC) <quic_mliebel@quicinc.com>
> Subject: [PATCH 2/2] Hexagon: fix outdated `hex_new_*` references in
> comments
>=20
> Some code comments refer to hex_new_value and hex_new_pred_value,
> which have been transferred to DisasContext and, in the case of
> hex_new_value, should now be accessed through get_result_gpr(). Let's
> update these comments to reflect the new state of the codebase. Since the=
y
> are only meant to assist developers, we can replace the old names with so=
me
> pseudocode when convenient.
>=20
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
>  target/hexagon/genptr.c    | 10 +++++-----
>  target/hexagon/translate.c |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c index
> cb2aa28a19..8d11d928c9 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -880,7 +880,7 @@ static void gen_endloop0(DisasContext *ctx)
>          /*
>           *    if (hex_gpr[HEX_REG_LC0] > 1) {
>           *        PC =3D hex_gpr[HEX_REG_SA0];
> -         *        hex_new_value[HEX_REG_LC0] =3D hex_gpr[HEX_REG_LC0] - =
1;
> +         *        result_gpr(HEX_REG_LC0) =3D hex_gpr[HEX_REG_LC0] - 1;
>           *    }
>           */

Go ahead and change these completely to pseudo-code
    If (LC0 > 1) {
        PC =3D SA0;
        LC0 =3D LC0 - 1;
    }

Thanks,
Taylor


