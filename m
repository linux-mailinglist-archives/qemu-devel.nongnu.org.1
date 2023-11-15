Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9267EC718
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 16:23:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Hid-0003B3-Vg; Wed, 15 Nov 2023 10:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1r3HiZ-0003Ab-5N
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:22:15 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1r3HiV-0006sk-KJ
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:22:13 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AFBekSA000397; Wed, 15 Nov 2023 15:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=qcppdkim1;
 bh=y8QTvnxMacUdRlzsMiO+UtcyvTaSuXSmBeBwxGWZPEg=;
 b=m5E8D1jNdz1b5TrdY2OIub8M9OrKikxrjQW+CYPf0v4Zd/DnTJAv7v/uuLmFu59UgLDl
 imOjVrwXq3FHEW5xRBNb/SaO4DrnTJaj+KTvcbJyNPGiXuIYmtn1iEdrrYzD7VvT6ifw
 WXOjkCagu6LGxaTJDwILF/ECla5VFEP56ROK7H+izCtjipR0m9MHro9zYn5dmg7V4p/l
 CJplPpDaJ9XMIyDHKQ6uhN6Q1SjICLP4pDzfN2Pn/Sl9Ve6djKSOE739wIKIz0eM0EfE
 UMkylqQTZX0IDbpJp4dpn5GuX8+I0iS0v+0bpAujl4gUUioVvbxvqE19Ubb3Uu3rvkzu 5Q== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucanq32s0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Nov 2023 15:22:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqP095q1fq0ZduIbWIMHnGA/JM0A5O8JRaO7+TcD1ja8BTREfggOsUK/+0elKrXo7hsEh+dduA7x2cNKRdft45pu0tEZarscyhcpyt6znFIxEVHtFtQUM+M0n6YZaeRfm5pOsYcIfBSk4GYdeDPJOOdhsOX4gmwNkWUvlX2d9CFC44HSY0CM0gLfPMDkAb8o3xWsfJeJKEl5jmlupOn4gciBVTxzer/SYJxd9UVB8Oa3bathgENJ4OjjIiyNcz3SEGq6cdz8NMdscfAVsoMqNP3+Hu5twGnFKvvPG/OpzhW0HeU6SEEOpJR9RMBB+p13SKC+sg4TiCZdcPFf7bedhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8QTvnxMacUdRlzsMiO+UtcyvTaSuXSmBeBwxGWZPEg=;
 b=H+FRv7zuwFlEkrk2RCamATs/PY7bZnoPY4oOGeqKZumDxqVJZDYMyfLHcDnAeAxrhghY7htNuC/AN48vt5pllIbo9aofNHeH9GJuGV1JnQvfYD+8tngGQ71xSjtB3nV0z/sD0uvexxLijlQ/gUtQJ67r0fMV2dvNzWoudnJbqrWCz26gvS+dENtZrfcT2zIU58BwLPR89Img5CuUsHuDFuodbeLBOeIznTF7Vmkik0OQfsdoCVsmVfR7JISbiAr2NNFbesLM6t3fwvczrtd5qQ6CP+ST0oWWvTIN4o7xH4umPao/MJtFjrMmF6pYAcKphMN2kx3qqZZtmvOjD2bhMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by LV8PR02MB9973.namprd02.prod.outlook.com (2603:10b6:408:189::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 15:22:02 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c%6]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 15:22:02 +0000
From: Brian Cain <bcain@quicinc.com>
To: "alxndr@bu.edu" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "megele@bu.edu" <megele@bu.edu>, Elia Geretto
 <egeretto@qti.qualcomm.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: QEMU snapshotting
Thread-Topic: QEMU snapshotting
Thread-Index: AdoTXq1i6ENJciZyQVGYEWEGkL6ibw==
Date: Wed, 15 Nov 2023 15:22:02 +0000
Message-ID: <SN6PR02MB4205853A81107ACEDB0A3847B8B1A@SN6PR02MB4205.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|LV8PR02MB9973:EE_
x-ms-office365-filtering-correlation-id: 223a0189-7a51-44d9-7970-08dbe5ee9e53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Y59DKzqtbSSMWSwD7732dZywgLeIYmsO0krXzChMmIWQym2PXme3EyW41+edpsfMODDOvP4wwMLT7HX7oyqhgNrlaTwLPlJ2OYpb24oXadRLTzUpFzRoecT9Dl6+tgCBAF6LJbew9jxyOK6DGfRYmc3lRcvflG9JpWHtdgcQV0svta9hX/86oX9SVMdFkNk7N04tJYjZI3/elh0jxR4lHap9jb1Nf+FX/SocraaKmm9cHSYLS7SUnQ98COnRgK6Q1RswEFMtewES1zHcbrOgTCpCmXxYFbsTEgxtngU8AHeJqG8cSFXat+AHYRHIhmnf5biPLcva7fLT/kW5dFIXu3+Esbh9Uhon7WpGpOx96MvAXc9bwv4Htrnni5NjmTIc3WIpcA009zSyt3pH3JVrLDcqf4REApE/WDZPLc8kY74Oh61kS5pC/9OfvvEdjIXgAGKctqxAcn2rt6bCO5FclB0WizESevNA3TEOfsugqQMxLoDEXaVziQe2wETlisuYOYEPt98x0xeCFApcBMZQbplEI5waS+fKF6pzEfR8hhGh9NTYW8J9xQXbOYwrmYu+FUugElFdwvAucLEdbYDkw1DYCiD5FWvu17T9hqikZmfpFU7GQupqxlX2BaKeoCZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6506007)(7696005)(9686003)(26005)(478600001)(52536014)(5660300002)(8676002)(86362001)(8936002)(33656002)(41300700001)(2906002)(4326008)(4744005)(76116006)(38070700009)(110136005)(66446008)(66476007)(316002)(66946007)(66556008)(64756008)(7116003)(71200400001)(55016003)(38100700002)(3480700007)(83380400001)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dweiNNFSGtEfY2CZnaf6hNM91m2snk37GnzKUtMp4vPEnchtEaovOpo0rF+r?=
 =?us-ascii?Q?bexWD5lHyJPi3WowvUVpbEs7z71rmRMN9F7xUwChUMiS9vT4EQAsFK0mjBid?=
 =?us-ascii?Q?Q9RMoKXkVIJ79WExITo3P4wSd4yxzYUb6zBhlkYdsEhHtGAXPMuhw+xFnNv9?=
 =?us-ascii?Q?5MGBBsTt6GRhQ9f//cvgX3eS020ssNMWMZUJPsIMDp5eja8muR8uO9DSC+9g?=
 =?us-ascii?Q?eO3RJD95fN6XGsnhXg0Hu5BLLjPnwyjQYDVHJfK/2jieNAEGAMOKU1g9msuU?=
 =?us-ascii?Q?P4DiiM1VMM/+CmUsRzhO8NEvTWvcYOF3ayLXgQnvJO47nttE2+dT/t685NJA?=
 =?us-ascii?Q?Q8O9FZonV/VDCXQyRikZLp6cCtzxfITru6kZaXqsL4zkQzMV1wUMkyRbQ+1B?=
 =?us-ascii?Q?PNgroyJ6I6rEk2RPfmSN/Uveoyy9LD/O0P/aeCa7IfqQxGDUTTE53prVZguM?=
 =?us-ascii?Q?YMKEKYJxH1lEjm9mf1+EmEujD/A/4tyderutPA8oaX40fFAAvdo0wUjh8mON?=
 =?us-ascii?Q?jyve1C56/EkeFEdkhJJMqbj6QsJK4N59R+NKKu2c3jv/gtDXy71p+Ml/Jawc?=
 =?us-ascii?Q?KoMpOr680nUfNHJKllr7mnaeJfE2JXK5Yp0BX/d/ckflspohjpU2qY96TdCR?=
 =?us-ascii?Q?isX4IHH0TUwi6rQxt/Mq3t12RC0sQXPqpKTGImnoKvk6lFiiAZyoe8NRuApC?=
 =?us-ascii?Q?QXviWf5w4Q5wAM5O3VChAet0JAGJdNcW230JB7/Lnp8KccWpB0sXkZixQJJw?=
 =?us-ascii?Q?d5+EIdQQ7SLj0pqEMLOrcSNeoWHPN5KQPsi46HEL81DbL9dsrCx8mv9vYTFm?=
 =?us-ascii?Q?4/eFn1T73CrYjblOAYpoOdM/Iw4wezFbdKpTFtvHNzIe2nCzIe35SeVZu6d0?=
 =?us-ascii?Q?Dn2TVWAxHeVmkcK5sYURSX0PVOBxY/Q3PAT3vWtJkCDl112RW6RaQZKfh2WP?=
 =?us-ascii?Q?fsIg2MlICLnWPI+ZSOFDuRjpmm9h/QSwV5FJPgAFe/GTsMvzOGmbUcZ0Ij+6?=
 =?us-ascii?Q?8v4LohGn/mjCOtv9zBzewwlpM5ZiEL0IS96FXxmi3THK0cfH+JoUmU2K9Aki?=
 =?us-ascii?Q?pQ4K8tnqACTc/TUJDSXM9mqJVoPT5zs+xdL8iQoLtsTUOq4IbHgxr7UJfNH9?=
 =?us-ascii?Q?uXbOWf/67sJUrwUT+9d22hghRAWKb0XiH7gYNR1SqPRwjMJoqyhOFcYCu2rc?=
 =?us-ascii?Q?/rShSxnA+A4bwsKqUI9HzKfDkLs8RJFHrlK2GO+gtmbyRSba1rYfL8gKQ83l?=
 =?us-ascii?Q?j3jlioWtx9R9vonl3zEAikvfCfjgB3uz+XEVD7FAi9T4M66czqM+V4ROnky5?=
 =?us-ascii?Q?0997DTMQL5zMpT3tjKPuHdufmi73y3LyuDW4eagVBdlDmcamXQeAWDu/RBup?=
 =?us-ascii?Q?9zHjoFZsVrlOcMFaBxyWXQ6POVCAAaQub7ueEX9MmpDsPsrumtWnAjN3LBxu?=
 =?us-ascii?Q?KXVColiM4PlTIG9DeEALQTtk3N2Flf7gAO0hDLkrZPumPWsGfSPqLKDp90Pj?=
 =?us-ascii?Q?w/C0Yln4YkU1Xz4nP3uhJL6pbNO8b8ObNL076ghE58HZpenEoDcPpeqyGOpZ?=
 =?us-ascii?Q?/RiH07jvFO5Fo+vqlNg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SN6PR02MB4205853A81107ACEDB0A3847B8B1ASN6PR02MB4205namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X73MzqNZYq5tt5d9MOp+/QCyaNxMHCcqwjHnqdvu8Qksn29KtG83Jodq4GUDvK+M1brTKx8UUOG2SrDGA4nAl6u2oGvmobVyarmzmwPyZhVP5jfcO/+Mad7fEBGXR2ZU1l7ZVoDPtJ+9sjnp2UyFlx+mtO/fR77AbP50ejTD1sB8kXYVnnTnuE7FKyzyTOdqAuPjuTustizBPPK+7KQXdygkSDdSgSp9TWI2hcKTlQjv92W+Z+Q4jtS8wLDrYT6RYbPOIZWo4IVDV553YdL5x9xncSnyF5jH47c4FDIl9hbfPfb7cWmDHHbVQuvCMMDzmXGfT/GF3gfUMo3fZffhHChfgPMEZVop2DFmFoxi3POq48yzjqgnZfoWGSsMN7TNkY0ba6LTwDdwEMK1MRNLiYZf9MROoZxi5T/DdBtBQgDSrQILFl65wdgbA/QGUUowBq1DZNrQrXJ3DfGe3H+O+0dI3+fZ0inOaxCUrU4KcEBBhdnw6opUAuucu/LcAO09daIYIoroivNMQFutgM+Dn5YShkVbzKRONUzivEtZmXjrnyVQzYKX0SH8EG04DvvmQYwRvVoxJVBt+4YlF5AwDDwxw3JqKsfwhzzyKKGJYK1iCPtJd6CNCQ1yaRTGYyMkxcgAoZei2RL11nid7Or4+acxqHPgXKD7oE4KuLSpJS/lAr1TGiEoaoVvTuMYm6nUbnH+kcNsi0t82dhzqFi1/Y5lqDkqdBjEKq6jkIkSahiWPh5GImM7CnGpv3pTq4mYGgDgzUn14GaawwPItImmrlQkGEQoPMTjG/2CbNO/UcDaFAGisA5xRLMUIuSkx1El
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 223a0189-7a51-44d9-7970-08dbe5ee9e53
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 15:22:02.4027 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yG8lp8gOjigfBMixm1dM3dY8Tg3dM13ArYctczI3K3srgD1xP0938IeBLa1f42PcedU5qgmx0qeDJiCgu1PQtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB9973
X-Proofpoint-GUID: 7BL_dWoxg2fm3HFwmk1DnT6kJFgVxYai
X-Proofpoint-ORIG-GUID: 7BL_dWoxg2fm3HFwmk1DnT6kJFgVxYai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=385 malwarescore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150115
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--_000_SN6PR02MB4205853A81107ACEDB0A3847B8B1ASN6PR02MB4205namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Alexander, Bandan, Paolo, Stefan, Manuel,

Hi, I'm Brian and I maintain the Hexagon arch for QEMU.  Elia, a security r=
esearcher at Qualcomm is exploring ways to fuzz some hexagon OS kernel with=
 QEMU and in particular leveraging snapshotting, inspired by your research =
and more.  I'm not an expert on the details, but I'd like to make an introd=
uction and see if there's an opportunity for us to learn from one another. =
 Maybe we can have a call to kick things off?

-Brian

--_000_SN6PR02MB4205853A81107ACEDB0A3847B8B1ASN6PR02MB4205namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Alexander, Bandan, Paolo, Stefan, Manuel,<o:p></o:p>=
</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi, I&#8217;m Brian and I maintain the Hexagon arch =
for QEMU.&nbsp; Elia, a security researcher at Qualcomm is exploring ways t=
o fuzz some hexagon OS kernel with QEMU and in particular leveraging snapsh=
otting, inspired by your research and more.&nbsp;
 I&#8217;m not an expert on the details, but I&#8217;d like to make an intr=
oduction and see if there&#8217;s an opportunity for us to learn from one a=
nother.&nbsp; Maybe we can have a call to kick things off?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-Brian<o:p></o:p></p>
</div>
</body>
</html>

--_000_SN6PR02MB4205853A81107ACEDB0A3847B8B1ASN6PR02MB4205namp_--

