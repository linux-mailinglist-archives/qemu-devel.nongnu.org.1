Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0422785C41
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 17:37:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYpvN-0000VL-NR; Wed, 23 Aug 2023 11:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qYpu8-0004yx-GV
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 11:36:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qYpu5-0000FI-OB
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 11:36:20 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37NDnWgE031015; Wed, 23 Aug 2023 15:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=DLqCwpyUd2mOvecr0IcMQH6T409yDXbxMspKBCIjvgc=;
 b=pD75JQQnRaaHu8BV3umraI3ApgUQ1YGd2frETQ0rwFTcHdO5RKOS/YM2kzbVWAOHVn9o
 3o0kjAnRuVzBvISvmWzlV+ATPFnMdlwaZEetHFpjf4VJkXYLPraqIsTzqmD4IkorHkvB
 nqM0gxdqKZTNUGQttNcOM7QUCHCEz0DPo0wEUgUDWsW5LYAtmVt8Dpv3UVYuLAd0vzTn
 8VxiS9/k+IIVgnkozposI9998BoWoLOWVszwExwRZw3QexF80EW1qrGh95piyvQ+MyPH
 GW6jbSb2QjvJgB6QISMYy1dh4I/hDEe3DNtxYrTDM9Kk4gwJHcnAFQXQcD45ADR/A4f2 yA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn208jh0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Aug 2023 15:36:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hF7zaujk4LFckKrOdcG700MCSVL4CvAiMjpkP5QbRsykYnMMQ+/XSosA11Suwl06Yfij7lOS/uGAbhhLHWwqfnZIAw/W/FSksQ0jZNw1t3jQ0p7f+ICLvg5Xu0OCkJvC19PcL22Wa5CEIYZPrStt+r8kismR5+EsIV0bGAQ81TuNKbUC/5UXnMGdflmIL4r9OzPHiBUUwOINvLTpj2dIlnbl8ToPOujlh2SzgG8+i21F0nDV0JN030zfNH4Xa64YHb9lE025qMKkIVQD6rDl+RkwDKJnFBtnqmspo1gUjc3DCPnY1cZ2g/GsaJx5br/+uIQD6pJD8eXLqyaNEjZj7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLqCwpyUd2mOvecr0IcMQH6T409yDXbxMspKBCIjvgc=;
 b=n9KGOlL8pc60DmqAPBShyATaOw3F5k4NncnzBm0I3eiM6TtArFcLX/eyxjp/bvJR8riX2GILdfaJqq9p+9vXPSuwKlftPkKXHeO9VOUnGnmS32fTApe7S7Lwq2SmJgXsfS4KT5MUmucMgJo7h/LNLTDmGA21bdd6EOLnfUSQ+VnT9YU9YFmXaa6dh4Yti+OiJySLwYkA0vXyyZXwxavByz//ZPqazP+OuTMcAg8oq3xM12O/w2dA3bYTOoYK9jXW6ZLkCdjrwMS/8Wp9QsqYs7sdimJ7NaNaGu5wOAWprhxQ6TcsSvUMaDuTfz336WM5uCezoUVgdwaXcs3/vGJ2nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by CH0PR02MB8165.namprd02.prod.outlook.com (2603:10b6:610:10a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 15:36:09 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::1329:89ed:4c1e:a28d]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::1329:89ed:4c1e:a28d%6]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 15:36:09 +0000
From: Brian Cain <bcain@quicinc.com>
To: Michael Tokarev <mjt@tls.msk.ru>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 11/24] hexagon: spelling fixes
Thread-Topic: [PATCH 11/24] hexagon: spelling fixes
Thread-Index: AQHZ1Y8A3WpaazCJM0WopscdqfSE4a/4A+Pg
Date: Wed, 23 Aug 2023 15:36:09 +0000
Message-ID: <SN6PR02MB420535802A6DA5CE281E6416B81CA@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
 <20230823065335.1919380-10-mjt@tls.msk.ru>
In-Reply-To: <20230823065335.1919380-10-mjt@tls.msk.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|CH0PR02MB8165:EE_
x-ms-office365-filtering-correlation-id: 0bf16a18-b2cc-4756-1efa-08dba3eeacb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: whgYHorDEdQefyOU13aazJATOe2LYIJkOn3vCrmaH0Ft8JaKzkMfql8i5jrINT7ruIPJWhgv4NKFybqY/9gV00vKxGHEJ38IkmAKGCsMmT8QEq0FtZ/6DQ8Zl1Zu98xS1XaWci5IsXsuZX0YHyglwHYE2kAw4gr2WLUlmoh/mLRCW8hz8h9y1Rf2xFUv/WWuYIgYvGlXxqOu3UokbZ6gM4q72gAUN/d9q0Xb4yyZLVz4yP8n326BpgUsk30euDrMxERsbDfUvBYgBgmx4LT6eCHsQtYglavRJDWa0+i6aGL/aU/07zR7bg48pzMYy75dlFQGZe7GgyMW5zQGM3ezD+ySGCddR9TtlM1do3ThiuGdwrAljO33a7YBm5yCOkSm0+UfNMQ69uF21iLtUKOPloLgr+ocodqI6EKCq2kruSli8IFlQ6muBO+qxX721OWJwlkZUSFty7ezRZcnDYu5PxdDURuJI8DHgGzz854Yv51CqHLNnQ+bIY11HHQl0ShRjF+ct5bQIULnRxRK0aA8nYJ8v4FucgucivE0fCWsaU+C9BXE4+ul9KQtbyfWlDfroYiq4FzfM8QBtrdlfjJZeevUod6N8dPJlWkjNbsU5wrjNptAfQKCcvduFCQ20T3d
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(1800799009)(186009)(451199024)(71200400001)(122000001)(86362001)(478600001)(38100700002)(83380400001)(38070700005)(26005)(9686003)(53546011)(7696005)(6506007)(55016003)(41300700001)(110136005)(76116006)(66946007)(33656002)(66556008)(316002)(64756008)(66446008)(66476007)(2906002)(8676002)(8936002)(52536014)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5SlZ7MxTKdBbfurl3WFIqyKw6o65zeXo7baV8sUULG0jGPXTGVJArecJPDXs?=
 =?us-ascii?Q?2/BorXjUMcyum0rEbmpHTucFukeoC3vjAKN7xtNNqLGr5BkqVgTPG1cuf10B?=
 =?us-ascii?Q?IoLWGNjPaJlc5Ag+CUDXs8Qgtw6rxNIfUCOxM/g7I5yTyHr7xw7dGuDo7Eg1?=
 =?us-ascii?Q?Ywe5bLthFU0q0Y3cOCwC/Jgb5+RCywdKJCZSMcRI8MjRhGeoFBHwKqe4Ku/s?=
 =?us-ascii?Q?68Dzi+A8woPjcPUi9rfQIyXh8BwNmWRqPQASQmdHBvA1gJ5eUxCNaBGQ6828?=
 =?us-ascii?Q?6I/bfd0mOBibzmDweGwOUpscte/B3XfzrFUvPhSmcs4q2li4l11nkLyWq8ak?=
 =?us-ascii?Q?RThIe1DVlu6Gp6P+nUXYVUh02F6XkYJJS+9yXFPBd4abE7teU5YTXQk97WFi?=
 =?us-ascii?Q?qPn4WiSp1i1e7P0PoSQUY/l7IjtdihL5EcoNS6UOQ595/3DmBE3OC7W0EKW0?=
 =?us-ascii?Q?YPTJyuZyW+yBypAJia7SbNKVZMV8uObE3hrL12uHn3xQMfXTT9yPozc05k26?=
 =?us-ascii?Q?soZIKrKeExBG2adJEIIFSzqO9A8P1s8smHh8dMuigOO+2oEDw4zXvp3fHs6G?=
 =?us-ascii?Q?73HMrQiB2F7DXglT5IO3zn3r7zzo5oJv4fqRYZd3KMKIm+vsEIhiQ62JaG1u?=
 =?us-ascii?Q?3CvUaOQgkmH/GG6NzlODYXsA9vWMmQiK14n8Aza0LiXuPaqXzE4HOBdpQErU?=
 =?us-ascii?Q?lJ8e1VAaltYFfsMjvi+yB1Uk8yY6chil3fh8F/MYEeNmnaREp9vw3NIj36Wp?=
 =?us-ascii?Q?BA5sKFmtxwkQ1X5AslG22+h6LiOpKex4lqdd5h0dab3dMPNgL32Nq0JkiR9n?=
 =?us-ascii?Q?9ww+72EdE8BFwPsfiWB95hoxIx8w1zDM7oXTA4hIuVifLv0kXfs4FUg3OMQg?=
 =?us-ascii?Q?W6w6lgU/vNqRTQpm2nAQ7NjUvcj4qvkd+LPX4IEXXe/iU0b3Z6T3Th/O8zHk?=
 =?us-ascii?Q?eTACCfrdzhtUZ0Zq5hQzxT8tg3JSfU/lthAHf2WjvDblyHx3sfmWfouVcdtZ?=
 =?us-ascii?Q?fCR24ypAiePzn7qflP4Sr5wACw7iD9kJ88eDS6j7GyodXpdBsWE85KYXs7C+?=
 =?us-ascii?Q?PlZ5psKU8ZdcxwgSyfNO+P4KNQoGsySxn10frc7ihAwGmUg3Cya1j9POZRrm?=
 =?us-ascii?Q?CzYt8lNwYD7DLD8Vg/PMQLAvI+7Rc9zq9A4IkFjffmVjQUY8yW9nfxLbUJzw?=
 =?us-ascii?Q?xG9MI0J7xF1OhaQzmiUszi0SNK6n5pRZL6jJ+WnDf6dx0n8p2ZdNQQ5ATu3c?=
 =?us-ascii?Q?8enhT+KsjabrRtwAVpWrq3QQLtJVcsOq9+bnTrSbILsxhtq/THkL2ycL6mvV?=
 =?us-ascii?Q?sKMH/hkjetj/Id7biDupiHlLsvB0C2TzTHJ4MFlxVLbohLyFuxnpMu1p78in?=
 =?us-ascii?Q?vt9vbO61WdRhMxA1q7RywX36gsv9djM4BE3noqNntyo643xaTOkgYE5CFWfF?=
 =?us-ascii?Q?gYODSJZnd1wDeHBD9XWU4c52xHBGmQe2du5/95XDp1NjC7Wg9KS9xEZP97r4?=
 =?us-ascii?Q?+ZkuawLbW30exaQ0FA5yzv5lxrB79ErO6TPrGVmoVxlnt34ynWh30oVIKZRi?=
 =?us-ascii?Q?FUU3d9KlwickwIil15U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iKms/LKwANR/SW7vmNrQ2wraJ3Ucyd2yJMCZeh0ZPXOxUNKQ/5qY+ASw5OnqMdJut4I3hPNKG6awB8LMb9Oo+wdQ8L6ZfNuxbkT0s8EE+7M7yt9/R8l1FWI6XXDlqPrVVaj28nZzdkR1F3ljPh910wP7c7BsiloTvwTVTNQ5t9c7rTTyDAbF+iqH255mEzFc1kyjZFII0zCGMMa0L4MkpcQCnAs8Mr3czS4jy/8SpgYy/7pI/JQ768TNrCNbPP4G/OVc+U7lvSKkY3m+LbJfILJyFaX9uuv1unleJSbprRGzO97uVAU1WzKzEPYUphNNqjLZML/wMiPRgimmpq2COQMNm1bjhNVz1Rf3TxmnsOF5DeWUsl4Ah842bTUmIWWo0YrB5tEq2CTgvW32GHqV9YD1tQgjmcBl2BJ1lpnJ6s2WMWPjsnaMnGFTD1+J7moyFlcUiFTevhPO8rqcGc0yN/lpC2nRTbGlNZjTFVciSfLPRqQAFOAYQ1f0SI9N6/y+uswVpe/aw89WaA3henfTFp2l2ggewiY1rqcgeqy6zdz80cUr7Zds6XCLFtIbFQbZExyR//TwELfv9cD51/01fFIn1tXq+ij0jC5E5qVKvRUKZlZW7Y72/xxGYI0fgj38T66FWTzIihaXCaIkKJ3skq9XLAOOouDpPLYTFTyszPsMEdh1TeOuHEL9Ej6dH5jEtbS3gWz2K01o/+YpmWOfpFXr5SyMkQYcaXYXJUIos3SyPEYl9N7jUzRo6YU1R+G1mZM6hTpLYktPFefhFYP6C9XiMYUmSuKfomSphkJ64YI=
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf16a18-b2cc-4756-1efa-08dba3eeacb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 15:36:09.7593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v01wmnF5QhCQiFztOgK4w1ohjEAjogLz35rd3Vxn4o+owMTx8Q8ASolcEQ3SJQOPrTFmxWyES62Ad5b8Ul7sGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8165
X-Proofpoint-GUID: Qr_6EzBcnnj1R5rAdoZKyl4QmE8AkykK
X-Proofpoint-ORIG-GUID: Qr_6EzBcnnj1R5rAdoZKyl4QmE8AkykK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_09,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 bulkscore=0 impostorscore=0 mlxlogscore=888 spamscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230142
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



> -----Original Message-----
> From: qemu-devel-bounces+bcain=3Dquicinc.com@nongnu.org <qemu-devel-
> bounces+bcain=3Dquicinc.com@nongnu.org> On Behalf Of Michael Tokarev
> Sent: Wednesday, August 23, 2023 1:53 AM
> To: qemu-devel@nongnu.org
> Cc: Michael Tokarev <mjt@tls.msk.ru>
> Subject: [PATCH 11/24] hexagon: spelling fixes
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>=20
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  target/hexagon/README                       |  2 +-
>  target/hexagon/fma_emu.c                    |  2 +-
>  target/hexagon/idef-parser/README.rst       |  2 +-
>  target/hexagon/idef-parser/idef-parser.h    |  2 +-
>  target/hexagon/idef-parser/parser-helpers.c |  6 +++---
>  target/hexagon/imported/alu.idef            |  8 ++++----
>  target/hexagon/imported/macros.def          |  2 +-
>  target/hexagon/imported/mmvec/ext.idef      | 10 +++++-----
>  tests/tcg/hexagon/fpstuff.c                 |  2 +-
>  tests/tcg/hexagon/test_clobber.S            |  2 +-
>  10 files changed, 19 insertions(+), 19 deletions(-)
>=20
> diff --git a/target/hexagon/README b/target/hexagon/README
> index 43811178e9..e757bcb64a 100644
> --- a/target/hexagon/README
> +++ b/target/hexagon/README
> @@ -240,5 +240,5 @@ helper_funcs_generated.c.inc.  There are also several
> helpers used for debugging
>  VLIW packet semantics differ from serial semantics in that all input ope=
rands
>  are read, then the operations are performed, then all the results are wr=
itten.
> -For exmaple, this packet performs a swap of registers r0 and r1
> +For example, this packet performs a swap of registers r0 and r1
>      { r0 =3D r1; r1 =3D r0 }
>  Note that the result is different if the instructions are executed seria=
lly.
> diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
> index d3b45d494f..05a56d8c10 100644
> --- a/target/hexagon/fma_emu.c
> +++ b/target/hexagon/fma_emu.c
> @@ -416,5 +416,5 @@ static SUFFIX accum_round_##SUFFIX(Accum a,
> float_status * fp_status) \
>       * Theoretically, we only need to shift a maximum of one to the left=
 if we \
>       * shifted out lots of bits from B, or if we had no shift / 1 shift =
sticky \
> -     * shoudl be 0  \
> +     * should be 0  \
>       */ \
>      while ((int128_getlo(a.mant) & (1ULL << MANTBITS)) =3D=3D 0) { \
> diff --git a/target/hexagon/idef-parser/README.rst b/target/hexagon/idef-
> parser/README.rst
> index debeddfde5..d0aa34309b 100644
> --- a/target/hexagon/idef-parser/README.rst
> +++ b/target/hexagon/idef-parser/README.rst
> @@ -441,5 +441,5 @@ interested part of the grammar.
>  Run-time errors can be divided between lexing and parsing errors, lexing=
 errors
>  are hard to detect, since the ``var`` token will catch everything which =
is not
> -catched by other tokens, but easy to fix, because most of the time a sim=
ple
> +caught by other tokens, but easy to fix, because most of the time a simp=
le
>  regex editing will be enough.
>=20
> diff --git a/target/hexagon/idef-parser/idef-parser.h b/target/hexagon/id=
ef-
> parser/idef-parser.h
> index d23e71f13b..3faa1deecd 100644
> --- a/target/hexagon/idef-parser/idef-parser.h
> +++ b/target/hexagon/idef-parser/idef-parser.h
> @@ -74,5 +74,5 @@ typedef struct HexTmp {
>=20
>  /**
> - * Enum of the possible immediated, an immediate is a value which is kno=
wn
> + * Enum of the possible immediate, an immediate is a value which is know=
n
>   * at tinycode generation time, e.g. an integer value, not a TCGv
>   */
> diff --git a/target/hexagon/idef-parser/parser-helpers.c b/target/hexagon=
/idef-
> parser/parser-helpers.c
> index 7b5ebafec2..ec43343801 100644
> --- a/target/hexagon/idef-parser/parser-helpers.c
> +++ b/target/hexagon/idef-parser/parser-helpers.c
> @@ -460,5 +460,5 @@ static bool try_find_variable(Context *c, YYLTYPE
> *locp,
>  }
>=20
> -/* Calls `try_find_variable` and asserts succcess. */
> +/* Calls `try_find_variable` and asserts success. */
>  static void find_variable(Context *c, YYLTYPE *locp,
>                            HexValue *dst,
> @@ -550,5 +550,5 @@ HexValue gen_bin_cmp(Context *c,
>          break;
>      default:
> -        fprintf(stderr, "Error in evalutating immediateness!");
> +        fprintf(stderr, "Error in evaluating immediateness!");
>          abort();
>      }
> @@ -1165,5 +1165,5 @@ void gen_rdeposit_op(Context *c,
>      /*
>       * Otherwise if the width is not known, we fallback on reimplementin=
g
> -     * desposit in TCG.
> +     * deposit in TCG.
>       */
>      HexValue begin_m =3D *begin;
> diff --git a/target/hexagon/imported/alu.idef
> b/target/hexagon/imported/alu.idef
> index 58477ae40a..12d2aac5d4 100644
> --- a/target/hexagon/imported/alu.idef
> +++ b/target/hexagon/imported/alu.idef
> @@ -293,14 +293,14 @@
> Q6INSN(A4_combineii,"Rdd32=3Dcombine(#s8,#U6)",ATTRIBS(),"Set two small
> immediates
>=20
>  Q6INSN(A2_combine_hh,"Rd32=3Dcombine(Rt.H32,Rs.H32)",ATTRIBS(),
> -"Combine two halfs into a register", {RdV =3D (fGETUHALF(1,RtV)<<16) |
> fGETUHALF(1,RsV);})
> +"Combine two halves into a register", {RdV =3D (fGETUHALF(1,RtV)<<16) |
> fGETUHALF(1,RsV);})
>=20
>  Q6INSN(A2_combine_hl,"Rd32=3Dcombine(Rt.H32,Rs.L32)",ATTRIBS(),
> -"Combine two halfs into a register", {RdV =3D (fGETUHALF(1,RtV)<<16) |
> fGETUHALF(0,RsV);})
> +"Combine two halves into a register", {RdV =3D (fGETUHALF(1,RtV)<<16) |
> fGETUHALF(0,RsV);})
>=20
>  Q6INSN(A2_combine_lh,"Rd32=3Dcombine(Rt.L32,Rs.H32)",ATTRIBS(),
> -"Combine two halfs into a register", {RdV =3D (fGETUHALF(0,RtV)<<16) |
> fGETUHALF(1,RsV);})
> +"Combine two halves into a register", {RdV =3D (fGETUHALF(0,RtV)<<16) |
> fGETUHALF(1,RsV);})
>=20
>  Q6INSN(A2_combine_ll,"Rd32=3Dcombine(Rt.L32,Rs.L32)",ATTRIBS(),
> -"Combine two halfs into a register", {RdV =3D (fGETUHALF(0,RtV)<<16) |
> fGETUHALF(0,RsV);})
> +"Combine two halves into a register", {RdV =3D (fGETUHALF(0,RtV)<<16) |
> fGETUHALF(0,RsV);})
>=20
>  Q6INSN(A2_tfril,"Rx.L32=3D#u16",ATTRIBS(),
> diff --git a/target/hexagon/imported/macros.def
> b/target/hexagon/imported/macros.def
> index e23f91562e..4bbcfdd5e1 100755
> --- a/target/hexagon/imported/macros.def
> +++ b/target/hexagon/imported/macros.def
> @@ -903,5 +903,5 @@ DEF_MACRO(
>=20
>  DEF_MACRO(
> -    fEA_GPI, /* Calculate EA with Global Poitner + Immediate */
> +    fEA_GPI, /* Calculate EA with Global Pointer + Immediate */
>      do { EA=3DfREAD_GP()+IMM; fGP_DOCHKPAGECROSS(fREAD_GP(),EA); } while
> (0),
>      ()
> diff --git a/target/hexagon/imported/mmvec/ext.idef
> b/target/hexagon/imported/mmvec/ext.idef
> index ead32c243b..98daabfb07 100644
> --- a/target/hexagon/imported/mmvec/ext.idef
> +++ b/target/hexagon/imported/mmvec/ext.idef
> @@ -18,5 +18,5 @@
>=20
> /******************************************************************
> ************
>   *
> - *     HOYA: MULTI MEDIA INSTRUCITONS
> + *     HOYA: MULTI MEDIA INSTRUCTIONS
>   *
>=20
> *******************************************************************
> ***********/
> @@ -296,5 +296,5 @@ MMVEC_COND_EACH_EA(vS32Ub,"Unaligned Vector
> Store",ATTRIBS(ATTR_VMEMU,A_STORE,A_
>  MMVEC_EACH_EA(vS32b_new,"Aligned Vector Store
> New",ATTRIBS(ATTR_VMEM,A_STORE,A_CVI_NEW,A_DOTNEWVALUE,A_RESTR
> ICT_SLOT0ONLY),,"vmem","=3DOs8.new",fSTOREMMV(EA,fNEWVREG(OsN)))
>=20
> -// V65 store relase, zero byte store
> +// V65 store release, zero byte store
>  MMVEC_EACH_EA(vS32b_srls,"Aligned Vector Scatter
> Release",ATTRIBS(ATTR_VMEM,A_STORE,A_CVI_SCATTER_RELEASE,A_CVI_NE
> W,A_RESTRICT_SLOT0ONLY),,"vmem",":scatter_release",fSTORERELEASE(EA,0))
>=20
> @@ -2046,9 +2046,9 @@ VxV.uw[0] =3D RtV;)
>=20
>=20
> -ITERATOR_INSN_MPY_SLOT_LATE(32,lvsplatw, "Vd32=3Dvsplat(Rt32)",
> "Replicates scalar accross words in vector", VdV.uw[i] =3D RtV)
> +ITERATOR_INSN_MPY_SLOT_LATE(32,lvsplatw, "Vd32=3Dvsplat(Rt32)",
> "Replicates scalar across words in vector", VdV.uw[i] =3D RtV)
>=20
> -ITERATOR_INSN_MPY_SLOT_LATE(16,lvsplath, "Vd32.h=3Dvsplat(Rt32)",
> "Replicates scalar accross halves in vector", VdV.uh[i] =3D RtV)
> +ITERATOR_INSN_MPY_SLOT_LATE(16,lvsplath, "Vd32.h=3Dvsplat(Rt32)",
> "Replicates scalar across halves in vector", VdV.uh[i] =3D RtV)
>=20
> -ITERATOR_INSN_MPY_SLOT_LATE(8,lvsplatb, "Vd32.b=3Dvsplat(Rt32)",
> "Replicates scalar accross bytes in vector", VdV.ub[i] =3D RtV)
> +ITERATOR_INSN_MPY_SLOT_LATE(8,lvsplatb, "Vd32.b=3Dvsplat(Rt32)",
> "Replicates scalar across bytes in vector", VdV.ub[i] =3D RtV)
>=20
>=20
> diff --git a/tests/tcg/hexagon/fpstuff.c b/tests/tcg/hexagon/fpstuff.c
> index 344b9f7772..6aadaccabd 100644
> --- a/tests/tcg/hexagon/fpstuff.c
> +++ b/tests/tcg/hexagon/fpstuff.c
> @@ -53,5 +53,5 @@ static void check_compare_exception(void)
>      uint32_t usr;
>=20
> -    /* Check that FP compares are quiet (don't raise any execptions) */
> +    /* Check that FP compares are quiet (don't raise any exceptions) */
>      asm (CLEAR_FPSTATUS
>           "p0 =3D sfcmp.eq(%2, %3)\n\t"
> diff --git a/tests/tcg/hexagon/test_clobber.S
> b/tests/tcg/hexagon/test_clobber.S
> index a7aeb2b60c..10046c30d2 100644
> --- a/tests/tcg/hexagon/test_clobber.S
> +++ b/tests/tcg/hexagon/test_clobber.S
> @@ -1,4 +1,4 @@
>  /*
> - * Purpose: demonstrate the succesful operation of the register save
> mechanism,
> + * Purpose: demonstrate the successful operation of the register save
> mechanism,
>   * in which the caller saves the registers that will be clobbered, and r=
estores
>   * them after the call.
> --
> 2.39.2
>=20

Reviewed-by: Brian Cain <bcain@quicinc.com>

