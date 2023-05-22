Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E60B70C47B
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 19:41:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q19VS-0002ds-PQ; Mon, 22 May 2023 13:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1q19VM-0002dY-7w
 for qemu-devel@nongnu.org; Mon, 22 May 2023 13:39:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1q19VH-0003Ik-Iv
 for qemu-devel@nongnu.org; Mon, 22 May 2023 13:39:31 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34MDJhCK031540
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 17:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=WeIyOQwfUXo1yEr5B4YSYL2Ddqu3mpkDJ4KNEHkq+Xk=;
 b=TFObDhs3pC+3S3LqJy+RPUNURoq/Zl6biwGlE6wu4RR2yfqAUjATBupu2jSD2pMqwXlM
 8UKp8nX1VcKUuMIbRrUCSzMcTMntumH5e/42asqpaRa6veGP5SHzCTJiTRW0VtuTkci9
 BVxABHRwjTHzzfV4whBX2r2ziy490FF4vjhcr1kVLHKMQD+9Xb4QEikq5M/yso5DWcum
 XpXndUWZq5NkvLjyCBqyv7RF9zp7CEWd+9rpQDfYl/rHgcGH/t7F6CQzP8mMAfACBsFy
 cNuuTrxPaSiTCYfgJWYvC6Xsl2VWqJuELNj66c7kdNrfC2I3UiVIdNLAck7h9FxFOu7R zQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qr53w95tr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 17:39:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdsWzfPUf4J0++LfGSIKhRWnPVD8POMzEWhmBzzUD60H7t8FFlx7U+Uown0oz7QAZg43rXrfrxEIXD6nBjyTUTtU/XTJgbD0nuDFxidKsXqr6f/RULCvrqkoDLEAKlIUlAjnuLQmkjYo2d5LZF+PBDoSLPyRw4qrA2MBx7aC9duXGrKF69h2X5Qquw4EBHEESzWU8FEeOAema5+333pVCcFLHYoyUjQNulOKtrLQHLrk8nOUuCk9d38WoO30zRz+6gOWxOvUnf0QNafktmnvYKiKSmWjgiq/KyDJiJ+0n2jJ/faV5xD2S/w/XBYDOzHIkdmX8wxoR4IlrqkX7tWfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WeIyOQwfUXo1yEr5B4YSYL2Ddqu3mpkDJ4KNEHkq+Xk=;
 b=jlbAOTLE1+1AyI67vgQ5JY+FDSP+ca9ba7ABwJcIxzK3/hKl7nYLTc5FVtUnjWYpI1i3hJqhcmbk7gowdWctVLBYOGN1U7ZIEI2TpQYLMyPwJ5qZuEB3l5PBZV5H3XdLLkri/05WFBdsGtE9YsC/XopqAXKWfXokXRFH7QKEWyE5Dn7ESk4LUBDmpcmsWYl7gxVIY/c9xEK8xpOTnVr4BOWxSaeTcfD91n22w7v+qcp6DSXi8e83YT8mn1wWtm3YFwKDprYLR+Km4mGySuRcL69BMjrq+mYFaRCZVFAl6ZtHVlIfexEO0PNtdiTjsQhqg+5ZHMbS14czTWetZaliEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN4PR0201MB8808.namprd02.prod.outlook.com
 (2603:10b6:806:203::12) by SA3PR02MB9945.namprd02.prod.outlook.com
 (2603:10b6:806:397::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 17:39:15 +0000
Received: from SN4PR0201MB8808.namprd02.prod.outlook.com
 ([fe80::eb63:d1c0:28de:72f5]) by SN4PR0201MB8808.namprd02.prod.outlook.com
 ([fe80::eb63:d1c0:28de:72f5%6]) with mapi id 15.20.6411.027; Mon, 22 May 2023
 17:39:15 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Brian Cain <bcain@quicinc.com>
Subject: RE: [PATCH] Hexagon (target/hexagon) Fix assignment to tmp registers
Thread-Topic: [PATCH] Hexagon (target/hexagon) Fix assignment to tmp registers
Thread-Index: AQHZjMiEtUdLrio2ik6oYCht7cb1Ga9mjh9Q
Date: Mon, 22 May 2023 17:39:15 +0000
Message-ID: <SN4PR0201MB88082D59775E7EBB170B487ADE439@SN4PR0201MB8808.namprd02.prod.outlook.com>
References: <20230522161356.438293-1-quic_mliebel@quicinc.com>
In-Reply-To: <20230522161356.438293-1-quic_mliebel@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR0201MB8808:EE_|SA3PR02MB9945:EE_
x-ms-office365-filtering-correlation-id: 292af5ae-c61f-4d15-4c1d-08db5aeb763d
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PsFUv/yezJrj6z0JF15gZkDchCjcA6EdPM1RF6kKP28KY01AxDqa6lPtrlPHaVTXSQ+Ci91H+lE3OrQUSLnk/Yn4jFmu/UZ7LrTCu1g1oGz3c6CQnaYru0+Mv1uth2t7davQoYaE9WaAPgKXJcrBRrkvDLvtZTKqrfpqiBcR8sKuHXZH/gFzFdErT2SvXSY9+wJS9DFUxoy+nJCr7PSKCp80wA2WZqHNUXsJ76U7PE254q9UtfkwZUdedecJAcJyurHHhA3ksi+89UhbZ7xlBOe0gtXOtYgfQ6iFRW5b+H9bz4KqpDon2nHaEjVwYwtRjZ1EVnD2358NXWS7/OFdTzmr7TSvN3RgYJE+7ZEzXmwSBH2T0GrsNlb5tSz+/cduPyWbsEs8z5AGVAb6Tsnlr+9McoKKSIYK/0ClmyYtDjl1OAbypA2rkK2AQhkGPKWPLyPk3wblximMr7FYPd7atxYLhERN3ETAxo6SeElh195QUn/ZShDYtnK+1IPcsSYLTds4KGL3vBDXVpwnP5VdWkjjJuunBfIxvqd9pND7DlOW90y2qnU1EVfJCqTiPq5dU6G+2a0Hlj422Y7dU619EKRgofkG9EiVleFXMdRkV1E5VCRzLWjG4uz5/uokl0Fq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0201MB8808.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(38070700005)(122000001)(38100700002)(33656002)(86362001)(55016003)(107886003)(53546011)(9686003)(52536014)(6506007)(8936002)(8676002)(2906002)(186003)(478600001)(64756008)(316002)(4326008)(110136005)(41300700001)(26005)(66446008)(71200400001)(5660300002)(66476007)(7696005)(76116006)(66556008)(66946007)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mca6mUZU11x23Tn/CULCeeDBPTe++M3WODs5z4afQ1fhMc3UJ5+D5PkJh+HX?=
 =?us-ascii?Q?ASzet9CBzff7LoNOEAhzpgeZsY72JAyRUiMInJs8Ai/56CfDxkyK9B4POg/X?=
 =?us-ascii?Q?SwRmqSc9MclNuLcdO/yJ2IWBueRPDYpmgzWbrtUZ4QTPnkGJIocr4UdY5iKC?=
 =?us-ascii?Q?nju38SEE/x73DZbcb46hvFp6oeM7wwpStBYN9tJ+GI1R2irQ4KDBhK8gfzL1?=
 =?us-ascii?Q?f4AleGAri42tsQ/feB6ObQYiayTszHXID9sbmXelcbOZcNf7WTpHUhZMk4Nm?=
 =?us-ascii?Q?NQMIF6zc5STzrHf5g7lxD+mNZMNadIX0DUvqbEoaVyOIoJfLjA4PaprdrWbb?=
 =?us-ascii?Q?h06fUbYGkWyGenx53pzUrRpRdN0dJ7iwZpgoraE2QPhJOnic2nTR4pZLC5+S?=
 =?us-ascii?Q?illB5P2Q9Y0kFzxCh+oPzPXS30agpCr5FrNvjCG7VBHgHmygTvTLpChFWcRU?=
 =?us-ascii?Q?q+xG1IO6xDdksdeFqz96VpPB/Se7yeNJmL0+CIlLCmB7KiGk7Cre6b4DbZov?=
 =?us-ascii?Q?ohjj9Kujsc10X16z5+Yt7cDyZ9a2bIKqShkUhE70QAgKPl+H5cL0epiRs97q?=
 =?us-ascii?Q?nu0Xo7NRNjR6RAC/x/kK2lAmGWhI02CiIlw8ldMaVYAPjoJdmJ/ncjM2zBLK?=
 =?us-ascii?Q?r+kUvq1iuoko/2Rf71rh0wgjjJRjVOU8PFRu9M0HrssFJTUiQ+tJRXhzMBmo?=
 =?us-ascii?Q?4yGeoXqVVWDqQCttT8nsEmG6niDN9I0Xop3/F7WoHcmvTn1JcIzWBTMLyGnC?=
 =?us-ascii?Q?IWd7VVa6ASOJSp/H0JL3pMZICbiGXH/oRRBVRGspX/pGgc1JX6c8mxrzzHj0?=
 =?us-ascii?Q?9+HftZGg4jcknwPC+j2BP1qtel59b7YS8s9vZeBMj5JfZUTiQRa/TBX12rsk?=
 =?us-ascii?Q?lKOe+PwjGWkOkgvNklshkuiZCTvk1jkHrUarlELMzyjvabHf4DC2TynMbh3c?=
 =?us-ascii?Q?lf/A517n1PLj5uo5io2UHp4b0n3Bu0/a6OeNM6nzCLw15JB8eLWAe1R+JKPf?=
 =?us-ascii?Q?ZG7jWRn+rrIGikvAZskBEZBfWHOncEgXGHPO3upSdW0miB16HWievZSTMKj2?=
 =?us-ascii?Q?1ZT/YzslwMSVJttg0veXz1Ws9xLxmgCuXuF/vOfjzoQ2/7hETjfbdDQHAPKL?=
 =?us-ascii?Q?4H9pSZPw4PW4f5kxqLvJjvzobbyEt8B5avUYB2qKJ9xwBpdbsiMfYfbDROxO?=
 =?us-ascii?Q?uYlqH8AmfWzW8DY63xn0e8+EYEGKUVnrkwaKVZhXMSrI/vVQNEohdNDdONaf?=
 =?us-ascii?Q?vNv7mdAmBCeCJO2bpKpNJeHQ8pcwUxZj7PQg/sN0hTBEldKYHD5f+EyMcHlF?=
 =?us-ascii?Q?qIZUVqRX+ExmjrA0j1H7nU12WRoTMOVOoJCZ6Tlsyp1d0BG1rmqFkOI2yrnE?=
 =?us-ascii?Q?qD3e/M24EIjcsWiQq6sw5bpz6s4rN8si68i89nlttm0n6/bfKrwZwgyCWdvu?=
 =?us-ascii?Q?XHd5cr389iu5ZMo0nO77yWrdLIv6poAPbkPeqVvYyhRsTr06aPu+psSnxT4Q?=
 =?us-ascii?Q?FdgnuXMEl+hw6uZGvyGm+TnnumOcce7L0lfqYtTmf+DFRzh2Tkq7m8vXEtvu?=
 =?us-ascii?Q?nb4yN2rMsAPseJJAqeMTkuNogcz8XUuD+pmeQYJQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WuYA5Qg6P0Jk1CmafDjdQDIZGo8Bgt5S7epet6x+gv0yyJn5/kYMmsqWXqrHZjyJ57vmuPALwWZGRLzsnfQmEtM6H0vIEP0pNE+9WVKoxTFIG1pxFTQr4+vK7NifiwH0IlNUADo8bhNyUEiKaWlzt17gVFxD3jX6esbNkM1RDe/pQzDhPamijr4Mz0GJl1/Jn7tEDCmdzIlErwpRHjiLMjd6KBfGrXAGU56J3ZPvPQxs1Mbrey6PMhQZyH3u4QFHFzuPykvM7Mn7zCvJOSPnQaa0NqxUqeTEvLzGSB+lL+qSaHPlzXMrs7q2UV500z6XS7IvwON0ozJH45UF3WKqAdbdSDq1gsKG8uTLsUsCBNGxXAF3wkvXGZ6wY0FipkuuLR8ex0TZSi3mpoDiMPWjJM8o0At+u0w/nMxROfAxoVshbs9KQWF/IWS/bM4x9GSDFL/9PtNGx0MfTGvhlLlh9xQAp+3fqK3JgdxH86O6HdzEcBtz18xoQlIY208aTESwtzI+TPkHCIqYsnJC7oSKY3MR4tbxjhAdpxeE9hPphbRuUdeTO/LkjGBu5klsfYO/IMZusAqNanEq2jL9BX2alZcZCNdKX5DppcbHCIc2dxKfPyazAgtvbu3raO0THADTlHkjy8aM5eB/gBcIDGwNlLJupHCeLz1DSDqw6scScIysf9cOGKkMPWbMDcFounfwsXOlJRVbSHWgR6kdq4iUHkXyjpJNpxifFx+q8aKcSMSEqOIRmPE9zjWP6HuPxUUky2+2x/hWsSgJTQ0Q1LcmWw==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0201MB8808.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292af5ae-c61f-4d15-4c1d-08db5aeb763d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 17:39:15.0295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Po9rWaR7P/lJxWNieLdlTG6BcCpUtvA2f0NCYSKTPZ4Cu/9llGVfznYK+iEz1HT3TZZih1wYDUxC0mPCJawQ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9945
X-Proofpoint-GUID: Jq6FIyCXJFJ4S926lCHyjiAuEMkL_3m5
X-Proofpoint-ORIG-GUID: Jq6FIyCXJFJ4S926lCHyjiAuEMkL_3m5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_12,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=856
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220149
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
> From: Marco Liebel (QUIC) <quic_mliebel@quicinc.com>
> Sent: Monday, May 22, 2023 11:14 AM
> To: qemu-devel@nongnu.org
> Cc: Taylor Simpson <tsimpson@quicinc.com>; Brian Cain
> <bcain@quicinc.com>; Marco Liebel (QUIC) <quic_mliebel@quicinc.com>
> Subject: [PATCH] Hexagon (target/hexagon) Fix assignment to tmp registers
>=20
> The order in which instructions are generated by gen_insn() influences
> assignment to tmp registers. During generation, tmp instructions (e.g.
> generate_V6_vassign_tmp) use vreg_src_off() to determine what kind of
> register to use as source. If some instruction (e.g.
> generate_V6_vmpyowh_64_acc) uses a tmp register but is generated prior to
> the corresponding tmp instruction, the vregs_updated_tmp bit map isn't
> updated in time.
>=20
> Exmple:
>     { v14.tmp =3D v16; v25 =3D v14 } This works properly because
>     generate_V6_assign_tmp is generated before generate_V6_assign and
>     the bit map is updated.
>=20
>     { v15:14.tmp =3D vcombine(v21, v16); v25:24 +=3D vmpyo(v18.w,v14.h) }
>     This does not work properly because vmpyo is generated before
>     vcombine and therefore the bit map does not yet know that there's
>     a tmp register.
>=20
> The parentheses in the decoding function were in the wrong place.
> Moving them to the correct location makes shuffling of .tmp vector regist=
ers
> work as expected.
> ---
>  target/hexagon/mmvec/decode_ext_mmvec.c |  6 ++---
>  tests/tcg/hexagon/hvx_misc.c            | 31 +++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 3 deletions(-)

Two things
1) Update the copyright year in decode_ext_mmvec.c
2) Add your Signed-off-by to the commit message

Otherwise,
Tested-by: Taylor Simpson <tsimpson@quicinc.com>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>

Queued for next Hexagon update

