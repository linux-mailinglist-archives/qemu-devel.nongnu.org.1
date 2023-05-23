Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B5E70E725
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 23:08:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ZDX-0002fL-3c; Tue, 23 May 2023 17:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1q1ZDV-0002fC-GR
 for qemu-devel@nongnu.org; Tue, 23 May 2023 17:06:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1q1ZDS-0005sM-1K
 for qemu-devel@nongnu.org; Tue, 23 May 2023 17:06:49 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34NKvCHN001771
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 21:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=EElqmj3RBqVttbl/c5uAF80qCW19sWWxx12X27jVRY0=;
 b=bpEmcfPyfKsIzMwbXGVUMkgQxm3+lRSmcSsSRiKYiQV/F8a4QWId6YIt/eVnZ+7+uaQq
 2lxvnoEzzsauswfnLxQESMpz3QrOk9d+ru7loKCEtq8BJKRaUKRgH3ExB2v8gs2Zr0jg
 3iVdlbAP7deagtLy2X854eBDhtRhycEJz4n8rXCt2VFym5wi79vFsy+TNt6S8XtyfIyx
 imaH8CpxHJf4GEYBMWMfN6fWRTiOyPmKm4BVl3NB+lBTxPMETaj2FBbr7LDV6Yxu1+hz
 IlWlmGM8vBl8L3bM/FHvuSldm3BhofIz0jIMLWWsQAQInae/fDUlBoB7UzxXiMKpsgmX yA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qracskubx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 21:06:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+yNrYodDNbT1xIDvM9mowXMapf2vtP3CqLc5Dfby6qvu+k4uY78w2vCir7UIl5VSJlw2Chb341OFNULIDCbTeaiouRx2ntEaCLbuUfaWEnJ2Dso5rnmI+FrwfPeH60gyghfIBC6ZcYGM2tLHZ+XJWMW7iByC3s8yJE3igEG4haWBg+r5+rcDNOz/8/jzqEyCIQyG78wRqWdrSQkz+xZWaqPNzQwzvGdFbiTFcSsb+zdCNXGuv/xoaJ0LauMZiEZa8NCLrMoTeweqECIPLygDw6EvbULYC4ggjfhcX7tB5DIk8+oYw1IwHdPRi4Y0u6hIkBNvpXB8ls7ygMxsWox/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EElqmj3RBqVttbl/c5uAF80qCW19sWWxx12X27jVRY0=;
 b=OaD+Byao1UcHYgOBTkF1OFoJVtVnLER7mI++gyYujdTnIOHdvnMY9v/Vjnf7ussNssFpxHAF5h3yueg2/P/TRwUaKUUeKtIxvjWWvII7xR3osqjkS/+al7LciZhK/uqszB8Z1i3dCUg4KdncYU2jKyzIuTIXdCDJ9L3rsSJIW09lu/LmaNiV09050r45cqOC8YUSjy/mOV3ZzBrwKS9zVtm/Rgyp8Iaooo2Vh7s2+S1YGaNvGyGKA5dJCKnYOgz6t7AGvX7PTG59mmsQfjVIVdqvh3RtvrOupXOoCNDYETLNoLvTKGbedmOrPeDoWqUvyi0GVBzxxFkjprZQS/TPlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN4PR0201MB8808.namprd02.prod.outlook.com
 (2603:10b6:806:203::12) by CH3PR02MB9713.namprd02.prod.outlook.com
 (2603:10b6:610:17b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Tue, 23 May
 2023 21:06:34 +0000
Received: from SN4PR0201MB8808.namprd02.prod.outlook.com
 ([fe80::eb63:d1c0:28de:72f5]) by SN4PR0201MB8808.namprd02.prod.outlook.com
 ([fe80::eb63:d1c0:28de:72f5%6]) with mapi id 15.20.6411.027; Tue, 23 May 2023
 21:06:34 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Brian Cain <bcain@quicinc.com>, "Marco Liebel (QUIC)"
 <quic_mliebel@quicinc.com>
Subject: RE: [PATCH 1/2] target/hexagon/*.py: remove undef vars from
 bad_register()
Thread-Topic: [PATCH 1/2] target/hexagon/*.py: remove undef vars from
 bad_register()
Thread-Index: AQHZjbZE57+sTqiryUqBLXsBTuICg69oVoFw
Date: Tue, 23 May 2023 21:06:34 +0000
Message-ID: <SN4PR0201MB8808832258C95CE662386AB4DE409@SN4PR0201MB8808.namprd02.prod.outlook.com>
References: <cover.1684873957.git.quic_mathbern@quicinc.com>
 <ccd8a781537de107a9acfc0610a29837245d0a26.1684873957.git.quic_mathbern@quicinc.com>
In-Reply-To: <ccd8a781537de107a9acfc0610a29837245d0a26.1684873957.git.quic_mathbern@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR0201MB8808:EE_|CH3PR02MB9713:EE_
x-ms-office365-filtering-correlation-id: e792495a-786e-48a7-9714-08db5bd19731
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4189CtLnLZzIg+E/M1w5r9Hmj7ZqfAwyVb0nYsPDURlkm0aFGIlLsLuJW2Fe3xysQoU4n4DOAK1TeiLQ1Ui0b9aCuUYif8NnN/Ebg5TOri/dpkc/W0XiBCN7cGlLxlfOJW4IBprC42RbBCCUZYVuKes7YZ1z3B+KjbPMoeS4+3qWe7ZC+iFlKD4Q9XlnEOYe5K/RrGHzi2NMB8838E6CpKdP9VmoheQ/Wl1lLrPfuzO/il2niBiN4aAnuZn05S/n5/UwYlEzkV39SYieKt80Em3Mx2thYSBIItjDSfVAG0YUSqHHPt5BABloKGexWIM36LABLf6N9hBDXlf/rKWFZWZaVhHi7XG8Q7FpLpRbg3No9fAIEA92BjygJ87/+LnnMFyOZQjhN+qUWfrCNAzHHEDRu6Vild/w2zQ9PoGiQ+JRF/88463FHgbmGmpydwowvMiyNdsdDELs1Qcpxp2Z/AehscYMk63Gh9zUhMrA/CQtLKlszYdTgwMtAaHOnMCV3P8nNvSJRVsV9WHZp3u44VprtggNkzfEWO6JGO4Ky1gecunrPXc8zAA+uKgMe3c5rl9Qu6G18h/dsX9TrYkdGfnoIZGMjNxpGu0BHao9Qqs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0201MB8808.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(8936002)(5660300002)(52536014)(83380400001)(186003)(6506007)(26005)(9686003)(38100700002)(86362001)(122000001)(53546011)(107886003)(38070700005)(8676002)(41300700001)(7696005)(55016003)(71200400001)(33656002)(66556008)(66446008)(66946007)(64756008)(66476007)(76116006)(316002)(4326008)(478600001)(110136005)(54906003)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cPkMOj1xGrpCkGHG54xQbzi7Tm5hfEJlzJ6+1/IkkiWMLAyhYgqwjJgZdEee?=
 =?us-ascii?Q?gMsXTxcWjLWin2eTmkoj35jWHgcMNjV/j6/XFMEmrKyGfZ4bUXZ9qtotyl1m?=
 =?us-ascii?Q?EG/JvVIfz6HMLX7YDYj0J4jRetgkrHubGtBB0axI6LlQ6ERz4x6lRmC5rpTy?=
 =?us-ascii?Q?GgcdBHq8sDY3FEVfVwauzXYEOtIX3ceppvNZC5X0CLFHXk5eqUNu5wRh4W4o?=
 =?us-ascii?Q?0suEJkRTKpdWQxXseNmJhbGAt+j2B4Bgc4FpR2ss+qF0066oK7aaZmXGK3vd?=
 =?us-ascii?Q?L0Lu/40bSiXf6Y5fKF2dEl7NY0SaRGL9F9k0HdmLIBe0or+pKBTdPNeGeAIZ?=
 =?us-ascii?Q?PcGvQ9E83Jci7vCcNSU5ls8pFIeUQrd8BEg3inEmSyjA85AExIbq+OmsCKn9?=
 =?us-ascii?Q?/v6GDIhCEBjTGd6DdwtC+NLHuHxUzgg1inaUXG6O8htnEGUAQ/mxSuHtUsf2?=
 =?us-ascii?Q?lDLr1IB62VwTOmlgOlJyAyY2lNmGnjRF9rfOhTl4NRaqA3d4AGL4nQBVGONg?=
 =?us-ascii?Q?r65VK76yJUeI5BmkbSr8paC2Mw1s+WSJd8hTda8u95L6wFZXcG+h/0p5INSv?=
 =?us-ascii?Q?FdoaaIRDGgQ4KF+69ZWj1wmXN5L9a4m2fklwhlxvuIKAvfW5wXb1pzfvdpwG?=
 =?us-ascii?Q?/zTEKv6gXz+DTQcaJPEpPMj5FGdnVx25M3fVkcLhSRJZuMXOJRyRDWh0O2Zd?=
 =?us-ascii?Q?g2nEKM+NuOta6wU6ubzrXShV6JBUdyVv8xq/9yZRtpqfBvVsAkuVrzqEdPpA?=
 =?us-ascii?Q?3+XMxVX2fuxbCPj7nbOMSRYUnH6WJDRZEYPXxdyTQOy59TTvkTjbqgy75UEn?=
 =?us-ascii?Q?5h+f69LZmXCymoO6ST3CCXMz3VtbOND056UskrXCLduTKhmXH4z2vNWoqoGr?=
 =?us-ascii?Q?3KGa8Bh9QjVjTEVXedQgzHqhxGOd6Mt93RBtNkxrjjdUqqbjYafGRzMBvWsH?=
 =?us-ascii?Q?F5ZiKe2Wh3NsBI1f/7xw32HZN0rwQ90FSJPQNgOqA1JV0Hssg+jVybKt0qxz?=
 =?us-ascii?Q?AMaOhFDz9z7clHQy7cjBj4MJIdiI3BWs4ztqAJ4J7idVUvWFfsXy7MubuFeR?=
 =?us-ascii?Q?c6csjQnd0NmJCEzPPylc1Ou069nkjsm6geDIKW0FCfQYCRpqWTtE74kbhiQL?=
 =?us-ascii?Q?gfTsRCkCSH1cwClymJkQY/PtEmkuvvwLjEEKiz5u7I02vy+fJo0hhJT0+r/7?=
 =?us-ascii?Q?TO7K/6ATz6X96uyuT8JYnBYRAhZQdBdhSJ/wRAEEnRqOx73crRMBuBf/jl3Y?=
 =?us-ascii?Q?cDjaQEPsX+0PLyPh7q1znhoiZ43u1XpSeKh/tmhw3Bb9oze8zov0itsv++tD?=
 =?us-ascii?Q?Zlt7/iJiG+WSQIdFiHyavVKHOdyKF/L9/kpqJuuCJi5ZxerayAAHkMEcDbWy?=
 =?us-ascii?Q?SLP3UXBcFDxe2JalAJ08NigJ+A6xmtcqg3R2OR8Jj8PeVMe/xj04jAkkNXiv?=
 =?us-ascii?Q?Q9r4BJ98fZDZfwY1cAV7gl8sOCsAA1zRjRY9FQCu9h7H+FLQT2bR/rBujqc0?=
 =?us-ascii?Q?g2+X0xoQTPGQvuzN+f5Ed4pmvcGi5+6I5/aoyma/n5wrIESTaxkTlkJ3HEXO?=
 =?us-ascii?Q?fUxd3PwiM5ke5tE5XyRdwanHLshMcxjfs+IiGlZ6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZLBjLEG+fGRZbub6VG7uzYf3adj3FNEG3ZbqLxtL8tWjJBp+Fyp9M5x/yUfdbB/Fmhlz5NYluAwewGJP48aaiEixbDEhNxivO0XE+3hhCRaoo1ETJ0E5Y1KP5RFY1tHK/av+TU9vVhldHVW0FcI0NoAbKnkl4mOhWfC2XCZ9bv8p4br7QwHElZRHb5K1LY1xy4AamogqwbTJ5K6x8JfqAZLTslDxxwSRzUjB79QlJHw1At6dIFWSUeGWFGMPluk+nWpfObWPiHTpMI381vRAqP0UQOhQyUMUeU12zuaRKf5o7zEQGYmjSXlJMIk5iwISCsWiLUs3i5nwR3d6sVQWFqLOHecLKZJCyMggjH6QMkcwihiimM0K0GprFgIp0eOutKwYGpNlMYWThAG5t4DUzx2w/nJ0p6XHbTgt1YLmmdB9DYp5VL38n+myQ14OXcGQqGBXAJT0VLia4waDMsZEHDI5p3YvMDnTvZCzBuxewtWtmBoi8wDZZAXRkSFIEpP1HV5MiIWUhT5gsorKo32W2MOYL7HPfKFBg9nH+SRL+JaEi4wetxcEMMmdJwWhmV6rsejziwxRnapcobuaixfSYM0vswh0P2+i7n7YYUG0Q/5ackS2QUCSPx9flYr4hHwlCihYggiUEA5QiGzy6+StzmqGJRjJ7n61QRdwKxFTbsGv3Cvuw/xG8O3FMgbJat8ppg8HF+EiHg8wA/NqLRtPGL1y4Kq1wzD/WNjGJwuK/f3rj4duJEiLu2dL23CY42epccVht84AaVEJSW6IlF0Qhg==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0201MB8808.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e792495a-786e-48a7-9714-08db5bd19731
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 21:06:34.5438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TY3CXLM4aZMfT1kbbz2KPB7l1ZMu/GLNBJrjj3KvskFBemjc62v0jhJSjBlUoI4Q4LKdz01PVYs6dfSjzD2zVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9713
X-Proofpoint-GUID: MVax6ZadzNMDWuvf_srw3bb2_nWVZFKG
X-Proofpoint-ORIG-GUID: MVax6ZadzNMDWuvf_srw3bb2_nWVZFKG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_14,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=871 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230168
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
> Subject: [PATCH 1/2] target/hexagon/*.py: remove undef vars from
> bad_register()
>=20
> Some calls to `hex_common.bad_register()` in Hexagon python files are
> passing undefined variables. Let's remove those.
>=20
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
>  target/hexagon/gen_helper_funcs.py | 8 ++++----
>  target/hexagon/gen_tcg_funcs.py    | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/target/hexagon/gen_helper_funcs.py
> b/target/hexagon/gen_helper_funcs.py
> index e80550f94e..367d08aceb 100755
> --- a/target/hexagon/gen_helper_funcs.py
> +++ b/target/hexagon/gen_helper_funcs.py
> @@ -87,9 +87,9 @@ def gen_helper_arg_opn(f, regtype, regid, i, tag):
>          elif hex_common.is_new_val(regtype, regid, tag):
>              gen_helper_arg_new(f, regtype, regid, i)
>          else:
> -            hex_common.bad_register(regtype, regid, toss, numregs)
> +            hex_common.bad_register(regtype, regid)
>      else:
> -        hex_common.bad_register(regtype, regid, toss, numregs)
> +        hex_common.bad_register(regtype, regid)

There are other places where toss and numregs are passed to bad_register.  =
Let's go ahead and change bad_register to only take regtype and regid as ar=
guments and remove those arguments everywhere.

Also, if you want to pull the thread on the sweater, go ahead and remove to=
ss and numregs from the many places they are unused.

Thanks,
Taylor


