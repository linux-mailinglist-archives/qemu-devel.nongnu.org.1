Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB6C752836
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 18:22:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJz4p-00025H-Ey; Thu, 13 Jul 2023 12:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qJz4m-000259-7T
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 12:21:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qJz4h-0004E8-Vy
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 12:21:55 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DEUecU018870; Thu, 13 Jul 2023 16:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=Uo1fMvt82TL9L6nCkutsKu6RK+b9SoP8CBpI0HLGbPU=;
 b=Wqe5nIuuckn6Th8r3z50wnnB55mrjFsNg+FfDKuhrQ4MSRKkbnd0qo+hCKjH0569byRL
 /aL1++bMk6W71rvvLFvsyyoPh+n/pdb/jsjdEUIb0SvtDPS+gbGcWuuX7JE2+xQ2aP1C
 S7dwsGbHnljCdKS8d1d1pe0kYdJ0g2QfXhiVDMLWsnb9b1VtqfVRFFPreUeYmQwwvv00
 lkVRmkMfiP0IeWzE8nNaPltRkv8dALhYIVmFGrixKBkqRKU2ljfgcRWEwgCPdNiHhGa6
 3wAk+ol+AwVniqVhC4yVxXINCiJCnbqBMp+8Z4aFeGbiVMWtBTUP1bSmZJVm8kslZFLO WQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rt3qfj0wu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 16:21:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEeaJ30I/h3Vb0pt6j3ZJHvdZd52NobF1SFv+5cWJ4p0eObp1CD24O/bObZ/IB0+YOQxijH/KR/SrrNedO9gXHpE5A8ElMSWHFM+HKn0/FPbTbmJBJInNwjE/TlHB2FDANL3wwjn4KQ3PXMwMe9cg7OwuNBRwnUzyJ7ZYl4HUXW/LbRWVRu/SKq4zpNj9tbD+z8dmwx50VsaVYrdwqsX08N2kEA2qx5qQN51NSApXGNE+DZbDsQG/OOyio+OWH9RSvk9oGlndYAiQe15gQX0SpEduKGuYX9ZEK+vWR+xMC4KRcfpMqXJ1ch1ZVxYCYrkx7f4B2jt4T7a7UMSYqKjsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uo1fMvt82TL9L6nCkutsKu6RK+b9SoP8CBpI0HLGbPU=;
 b=SZzfQFUQS+qMAQmDi2fLVp14gavi/Kd+OM3nQvL+5wKgOgyEAXLrbr3Lg4IFAEBMcFtpV9ZEXtYRyri/l//04EaaoWnP/Uv+sxqml1VKdzPydtuh5Hu9J+A2w9zUnZmddqjtjjtlVMxirccioI0FaCx8TWybXl2IR4Vt/tudQrsyXSs51nhPFUU12M1TB2HLZrioDLNz70XuYlYzKPlv7NqrKYcCF7hl2m7PT4Q+BD38Ol9MBPxtUlcPDgujP2iFoJoC25s7R48XmKlxkxh/OVvAO57r+CjdgrJlg+DDWsXnb1DKR9IYML6XDjCG+TQRpcT7nw+jQ6LSLJjKjjV6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by CO6PR02MB7748.namprd02.prod.outlook.com (2603:10b6:303:a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.19; Thu, 13 Jul
 2023 16:21:45 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::948c:d843:8389:cfeb]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::948c:d843:8389:cfeb%5]) with mapi id 15.20.6588.025; Thu, 13 Jul 2023
 16:21:44 +0000
From: Brian Cain <bcain@quicinc.com>
To: Anton Johansson <anjo@rev.ng>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: RE: [PATCH] target/hexagon/idef-parser: Remove self-assignment
Thread-Topic: [PATCH] target/hexagon/idef-parser: Remove self-assignment
Thread-Index: AQHZtYLSsDOvuPpz+0ibMCpzlCCNLa+34RUQ
Date: Thu, 13 Jul 2023 16:21:43 +0000
Message-ID: <SN6PR02MB42058323403CE9291E40E005B837A@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20230713120853.27023-1-anjo@rev.ng>
In-Reply-To: <20230713120853.27023-1-anjo@rev.ng>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|CO6PR02MB7748:EE_
x-ms-office365-filtering-correlation-id: 0936e76c-20f6-4d2a-d9d1-08db83bd3f3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oQPgWORtI1x7H/tL3FkJhh6roY2XSvctq49n273YS4iDovif89bN1jnL7qjmkfbHGvmFQTG8OgBFduRqcZGBo/XD1cIzzNlGCG48erw4DLiMg+3vHlD7c/nggWKJH38sSy7UEvd6AgtQyfZczbamAb+IPGRCPIHGPV1lKim+Ayrheb/OILQsvkis3GhKQE9WilBdhMwvfiQB0FqLiEyW346Jt/ssZJLUayL27ULXAZCVf3AYxkSiD5MQPWLUiy4lhn6rEOPNS9jUrJ1425tWjtFyD/1VFhBmFdqAHPe47dJRfMcV1rLWwtE1HNOeSMSzP0Yu46hHOeuOa+gCBzb/s/DnCeGc9LHk37iqPoeYVOayzcY6SdEfHNIrW2JewYGjHp3vHtrQoqH3Frlfl0HJSuypjG6Ou1BqQJrig7Prs3HCyJ2ZXXcKpiWv8v6VO1Rtgr/vcfLG2+wXGGTMhJh494q4PsAWld8Dvpw7sJEr7sQtm7JsPsHl8wDzUSZ81kkJPtenp7kAUm7678OkOnGxJz+Y3sX77dLoWpIPQXkCHLR40aYjxDT2+nAwG21tQUDqBbqFpEqnC9veUyj4OlwKAmwoj+qB53MXzB4eCPG/h2VEIj7Iqzhnwj0Fi7MpRB0L
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(38070700005)(33656002)(86362001)(55016003)(38100700002)(122000001)(478600001)(110136005)(71200400001)(41300700001)(8676002)(7696005)(8936002)(5660300002)(52536014)(2906002)(4326008)(316002)(66446008)(76116006)(66946007)(66556008)(66476007)(64756008)(26005)(186003)(6506007)(53546011)(9686003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UikO//srdmF1WBMaLDvzj7m0UITtlrhj9KPhngV2CLx6rQdm4u8blozK3vVw?=
 =?us-ascii?Q?SAE3lP10VemS6C+gZqwkRNDKFDnlhcOVK3im5/z5p+a1GqCAje+WCsWPIZmA?=
 =?us-ascii?Q?txj12oEp9fW5R1+N6diorzr60bG62t8vHaUVtNAAdbg5zxjOMUMeBv3Oxabn?=
 =?us-ascii?Q?D34909uMQWlaVNfcsGJWeid0FNhy6TQNmhPWJTBII1FkmHaL9AG3+cVbCqhJ?=
 =?us-ascii?Q?P1GsO0Y0DHwy5v6OBwbsQOMHKERlK/b61rvL0Q+b8QNwNO3pJFuq5dictyJG?=
 =?us-ascii?Q?ZTgJpk7amEgXGS0MwWamH6REe3ZcA3p7iig99FZJzT7DNYUzKbP6pjjQVOKL?=
 =?us-ascii?Q?q6vV31cpKeQyZ1mRP+Yf89Ii3MZL/BLeqvnliI8vYmHRfUtUKwMjufr3+7sJ?=
 =?us-ascii?Q?cQfAt4ytn0p031ZFDSM4tt0AqFY4TqRlf61g7npIC4wrM9bXIYbA4JvjRzJq?=
 =?us-ascii?Q?IBElgFM1GyUcvslYRuwgsVMywtvglX2KU7Fd2SeuP/zaoklw5yj7y8TD7WsP?=
 =?us-ascii?Q?JwIEzuSCvr8Kd/2wCIePbXJPfyCG44G/py2vAqLhhqVyGwXttLK9REc2h9hA?=
 =?us-ascii?Q?/2t+/wDon488sIFTGFBn5KtaO7UqN9kVOJIf4vsXbIOqz+N0Rx6qlD8mZu7d?=
 =?us-ascii?Q?STRhrtY3/XvZIwiSI4G18Ci0WZSnzYMXT0fC9RndLkxgLd+OZxjRI0digpl6?=
 =?us-ascii?Q?szZbdDC6GNyYAok3RURukqYueHhgp3l/ksBPzCy2I528Btk87V0vGEvfbJ2v?=
 =?us-ascii?Q?3Ln4eb+e2g2GEMuIx1WICcL8qM2500dIJ9Bi9s/MhPoHdvKmIl+gJlD3hiWk?=
 =?us-ascii?Q?lCXVlxJYZyABDqQaX8mphxUIPquFpcIFgd3UGe8d2RyrXiWT4CviIDSaGnNb?=
 =?us-ascii?Q?hKD6KYSfsvzvMz5izU9gfVeYttHbIrQzwDvTcbv6ml80SuP5CMorKuGN78OQ?=
 =?us-ascii?Q?pF8qN1pCicQ6mzpQOEpfHiGVeS6SZwqF9MSdINJAfi++fbCKGzNS4Wpq615r?=
 =?us-ascii?Q?CtjjMZGXQzIMM0a7abettcrGe3Y2yqA042Ysp8khUcQi2RDp6OhT1gwaMekL?=
 =?us-ascii?Q?EZfibtcrqziegX1jk2lKi3Py1pLM57gZiYr5Re104DNhVbdhyuAwJYGqqbpN?=
 =?us-ascii?Q?M8adYtrWWmjUe1p1sw5ii6sy5lNhj9vQCVJqEq+USN8n5l30fn45N/kELZUW?=
 =?us-ascii?Q?DOGgCPRtLEJchwne2p4/zbPn97lnICPfhUH3VqbgtR1Q38rpM9AbWPA59g7s?=
 =?us-ascii?Q?4fcCfVxLCjBc0gmWKsC4qq7U8RuHjA+smyR+79ubtcmAur6iKWBRPK7RZU4l?=
 =?us-ascii?Q?u+jXZxm5kwj68vF+HcWQm5S3MPx59BguTkY+wfq00eka0td4cHT3B6bdN9ON?=
 =?us-ascii?Q?8ohlzNJNlrspkpPEwm6jE0BiKG8yyn9p6g6ZxXtDiipEgqdktT9SUj1I7wmo?=
 =?us-ascii?Q?cNV3mBkobabuqCF6JfHNVWfkuFS4XfY0PUUFL3kqRhguKGsuqhSucBBLMzBe?=
 =?us-ascii?Q?CoROtF3LWSWb9Jhte+y5JioombXmk8PRG5Q69dYwrOf9yWBHON3LJI3Vcjah?=
 =?us-ascii?Q?EAHiR59PWtDDgY1F3mFh1I5q2E//RhHprq0dOmOU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vyq0dHl3ICPJKTQWr/Rw6jOf/09/+oyK/bTzLdC06i03gjtlRrOFeedGGigVY7GqxzxOkxZFlJ+jTfq4oZqoFMKSY1h3qFgpxcXvzgrGD6mIDjudrB/41uyNtr7A1ywAyn3AYwZQ6CYjXFc8nlwqs31c5vl+vARhlGHP0tW6lfepNL/l9BObo9b85LVtJdmWF4jYxjkYXyxxMDU4oIw9lEDeUa0i9L6Sfzd+hKVAlx6bOFj1y57bI1vGrhA2mibTD2IoqYgHVK4+B854Cw7xK6gRH6BnNAS3Klo3qouYHA1CZYt/nHelkG3i8aQlsam8riaEkTuxC+UrrHiwtYfr+ILsBSrxEqSQA7puv4XCoa7PR6K6JdtwlSOR43MgsONZyTSx7aS52dpoqXUrF0Xe4ldYUzP5s8XrUH6bTN50BMjxf8Mj4wa/Y90mrgTlhH2zOvvUms9tq039ZIAQjo0rLI4uvSI1fs9bO3ysN8X6MgKg5lqFmEelv40OxIHbfmRWU5ZlSd06C8EcftMhJL530iJnDRjjQNfLtxkZGVzeh7q4EdKvTNGyPdmTXeHic3W/IR2/EsB6RTvagZzZYQbRtSslNQhZQG2MyGGunPdjDoQLqKiKl0RlMH/oZ1Dj9lluhkvbztganFcgsHA/w+HA+KgDQKPWSja+SzvE9EqpGcaDORqsoqidtsm7jN6AHalU0CxxU5FVtQOP6vnWlDU+ugn109vN7nv4lmlhe3G3y37tr2xaT2fuIBYQQoBeJy7E0wff6v5dDS4My00izs1DQQv8fF+oIwhWqIG5iWDrIBkvClqJwO1c5UoYpe+w22yJ
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0936e76c-20f6-4d2a-d9d1-08db83bd3f3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 16:21:43.5789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xCs1Qmh5lGtFsVQybB/aKztFAt10pecv0CdqnPCUSY4O/kHwYAj+qbaZdkKmaUSZDvZ62uEbG2gfYGJP6ZQiDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7748
X-Proofpoint-ORIG-GUID: T43I1FmiXbADmJOu2eSrq_2TaGKtiWMt
X-Proofpoint-GUID: T43I1FmiXbADmJOu2eSrq_2TaGKtiWMt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501 mlxlogscore=645
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307130144
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
> From: Anton Johansson <anjo@rev.ng>
> Sent: Thursday, July 13, 2023 7:09 AM
> To: qemu-devel@nongnu.org
> Cc: Brian Cain <bcain@quicinc.com>; peter.maydell@linaro.org
> Subject: [PATCH] target/hexagon/idef-parser: Remove self-assignment
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>=20
> The self assignment is clearly useless, and @1.last_column does not have
> to be set for an expression with only a single token, so remove it.
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/hexagon/idef-parser/idef-parser.y | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/target/hexagon/idef-parser/idef-parser.y b/target/hexagon/id=
ef-
> parser/idef-parser.y
> index cd2612eb8c..a6587f5bcc 100644
> --- a/target/hexagon/idef-parser/idef-parser.y
> +++ b/target/hexagon/idef-parser/idef-parser.y
> @@ -802,7 +802,6 @@ rvalue : FAIL
>=20
>  lvalue : FAIL
>           {
> -             @1.last_column =3D @1.last_column;
>               yyassert(c, &@1, false, "Encountered a FAIL token as lvalue=
.\n");
>           }
>         | REG
> --
> 2.41.0

Reviewed-by: Brian Cain <bcain@quicinc.com>

