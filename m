Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7254370FBE1
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 18:44:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1rZv-0004q6-Gc; Wed, 24 May 2023 12:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1q1rZt-0004lr-DQ
 for qemu-devel@nongnu.org; Wed, 24 May 2023 12:43:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1q1rZr-0004SO-7s
 for qemu-devel@nongnu.org; Wed, 24 May 2023 12:43:08 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34OEnLM3015518
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 16:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=l5LfjGcm7FNagTLYvy1SHW4SV6SvFwxVFO6Y8GefpXI=;
 b=CeGGCCm+VElbZNvMkpHjPEWmRyPb6cmuW0/kuEIpDB/WAtW3jTtrE5TkqCf4Zh2HDAV0
 wedzyK0CZ8xrQSreIw9R+rQ4N3pkrjy4+HMNVjh7Nt7nWIXJnU5mleIZHsx17+S2wcTU
 EgBSpx/7F0DuYOZfcU7llVh630QoWL6cMBCY5CIPI0YJs66/wUqfSEKVFoXK0/5mG5Se
 j4BGxPfPd3V9z8bqqnsATObiDNYgOuyM98d7rZbeKlyCIB4HWoNm0nvn7ecqF0VtCbLP
 MiFl6n6qLVFPNFqXX4nqAbK/shqQK9zjl5lhoHM0gGN+h/m/sCUqB5nJYc34Q8Kunb6/ Ww== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsf8814w7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 16:43:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DstTpW+FNjXhdoqlk4ExhkDb3H1elrfv18aAA/8BKHU5KjkcrnSl3eaKKuPWKgjR7vb8VbC9Q7+MvN7TnmRvQIh8cl1A+vj5Mds/eH9wiNlJ87Rb6W0mwDinOXPiKhZmcJ9BnlRSEnn5NRkFJFcKxrFz6OSXt6ZzN/xC4X+Iq64tPigirHYno0TchXKM1YTmZ6oaZwZbAIjAS7Wdf8XNWlgeL/2ymdYHB6XVYuuBouM8F81IVTUGMVfNJVYQjZdn4Nulz+Dh7bKjrs4L8Ei82sFFROsz2mwG86+iNXcoB8+sFR0qwIp5UI8OnyljAMhqA4iQoZ9PDPz8mBby8oSo0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5LfjGcm7FNagTLYvy1SHW4SV6SvFwxVFO6Y8GefpXI=;
 b=kKLqc2KtxtwAMlg00d+weBR4G1vxlRsQ/pgjFoFq0VJMERt8IyprlWeToA0RzxGDdB3RlHhhqNhQ6T1/rjH3tiEG0eC3QzCK0MRYFudJoU9Q/jY07YX1Q9yKpNfDvdJB+N4bEAm/GiQn2sELR6WNcjke0z9ncZrZJ7VtY/asIYKns8S/JGXHm7wrRcLFa/WGRI8AkxABbJLSUXE5wt5B3WZc9nfQVKKUdccJIpQR6zPmYSam0A0Edyzy6C2xXTUHNXvBV5Uk9cH3skWmGQk4jZVN+uI/bEmaZHCO2OYXpYVEy+pKJo5VXJBgpQ9FC7TnqkLrH2MQ0bfbgz7x/OReIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN4PR0201MB8808.namprd02.prod.outlook.com
 (2603:10b6:806:203::12) by CH3PR02MB9068.namprd02.prod.outlook.com
 (2603:10b6:610:148::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 16:43:01 +0000
Received: from SN4PR0201MB8808.namprd02.prod.outlook.com
 ([fe80::eb63:d1c0:28de:72f5]) by SN4PR0201MB8808.namprd02.prod.outlook.com
 ([fe80::eb63:d1c0:28de:72f5%6]) with mapi id 15.20.6411.027; Wed, 24 May 2023
 16:43:01 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Brian Cain <bcain@quicinc.com>, "Marco Liebel (QUIC)"
 <quic_mliebel@quicinc.com>
Subject: RE: [PATCH v2 2/2] Hexagon: fix outdated `hex_new_*` comments
Thread-Topic: [PATCH v2 2/2] Hexagon: fix outdated `hex_new_*` comments
Thread-Index: AQHZjk3ihUjgwSCgX0GMtNhSC/W5Ja9pmlYQ
Date: Wed, 24 May 2023 16:43:01 +0000
Message-ID: <SN4PR0201MB880820D6539FD18EA1EEBBF7DE419@SN4PR0201MB8808.namprd02.prod.outlook.com>
References: <cover.1684939078.git.quic_mathbern@quicinc.com>
 <8e1689e28dd7b1318369b55127cf47b82ab75921.1684939078.git.quic_mathbern@quicinc.com>
In-Reply-To: <8e1689e28dd7b1318369b55127cf47b82ab75921.1684939078.git.quic_mathbern@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR0201MB8808:EE_|CH3PR02MB9068:EE_
x-ms-office365-filtering-correlation-id: 1871b544-14fc-4ace-9c08-08db5c75f049
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xzBcsKWg7+OQdoJUNQ3T1+9xA6+pH7PdZDuGZDoNoNOF2hmZxFkolErK6rGuLLcmCuPIzi7IXcl3RkeviNx2WcpdVQ3S3BWo9JDmzF3IrcQSEZ4QLCXCbs7ums35pEqd1J5I6fQQjSioUJMZD1p/yKFqDrpVRymBJ0S7qInENXo8Iw9LOTHLZIpIq+xg/4L/KOoovXBabCwuPVsIVNCiZJkIs4AqWH/CjzvwIHSRzz6cOu3cP7gW7YVqmmKoOwn9Z4lm/nGKLj2gecDpR0ymFbbs7wlx232QRINFWikk9UTGucB3adhZnKxye5NgHwbXCRGSPx6zCr11rCVVrxWXQF25Mv+m20RCeLWrkDjgTAlYCdtEUPmqFreDDpsMNUi2+Rvw7Zs8ogr5FW3O3sj/NEc45z1lJdm42aKoZxvr0j1X2a4YBIoBGwIvVkoKqoWHagQIX6Ke/5BViIGJaUEbzXJorYABdOx+aRjAqBA5D1RXcNza7uNH/2KlPkk37NzfOpgkkmahonvq3iUftPtsUIDHclzcMj7CMmaVWyReFmR4ttPMlNlpGFo79rfBD5RQXMNo6pGCAP0susfm/r50bgMoF9tZCpgFdNrkzPeKg+Uu6xSoe/Je9chglzW0ot6q7lzZGGVd+2RRUt4FHwVXFw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0201MB8808.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(71200400001)(66556008)(64756008)(54906003)(110136005)(66476007)(66946007)(66446008)(55016003)(6506007)(26005)(107886003)(76116006)(316002)(4326008)(7696005)(41300700001)(478600001)(8676002)(52536014)(5660300002)(8936002)(9686003)(86362001)(83380400001)(2906002)(38070700005)(122000001)(38100700002)(186003)(4744005)(33656002)(53546011)(81973001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wfX3sjPYOT7DzgUiQrLS+gmpvvnaD8RvEZrZF8EfPVsZ+I0mPXHnE+Zo3/rm?=
 =?us-ascii?Q?l/CD3U9G0z+klNjhzfa4JDAh5k6H9/aSerbRoZ8JDDvSgEE0Z6dREAHSuSb7?=
 =?us-ascii?Q?qbFITuPqPvMVcsP98XJQ82OblnfW7D7MvL8sboKSZA1AbqsPt1fkJLXyAI8j?=
 =?us-ascii?Q?95zjFKAcsp/MtncO6UsAEa5gR875P60oSolUVNQ5PG0wnHif3AGJC34Iha5Y?=
 =?us-ascii?Q?f7ptLRuYf7Ed3gfafBnTjW2k4CEcVBuMD0lsJ/SJC4igvTzoH8V2qPpmQNeF?=
 =?us-ascii?Q?tdiWgNinpaR5Ej3OEyLMIcLlNNAnzuW6DYTxrGY7zNyY9UPz58tL+xpI/wf5?=
 =?us-ascii?Q?nNuQOvzqDtEx9tLxZ1/S88D+OZBGonqRXOa/FULeVcVkiwSVRMRbivdh5+CZ?=
 =?us-ascii?Q?0uYJItyMtgf8Vt0GBkOaCYhSxENFvUvD/UMU8kO3ZPJUGZurMe20BwIWomcS?=
 =?us-ascii?Q?Yq1046LyhCj57Z9n9+eirqt/fnUOtbAI54fSpc7ucax+nKAgwhmgC579kRbk?=
 =?us-ascii?Q?Xbl1ROACnUUNnd37cDiVd59Zrj0YabPAtJ5KcogqD/lEmelSR/19Sy3yUARb?=
 =?us-ascii?Q?j7buB+YC2SJqdqOSw+vBWKhBvuIwshNYDTikVcre8mH2/7n/KMFifctsx762?=
 =?us-ascii?Q?KA6krt2d5CGXIft3i0l/DCzqFheJXOT8Dm8mgQZijT0evC61ilqWioxpfRd0?=
 =?us-ascii?Q?0jULF3Iqyv0NvKOf9Dt1ioHmsti356mKTN0Pujduuz3W3WvgcDZlP9BrQV74?=
 =?us-ascii?Q?vzoI42OrG73JDPXwe7ucZbfMVOFJQP+3zGYt2wySm4mr8Sp8HnD5lwbcUdlp?=
 =?us-ascii?Q?NIxlbbUcJ8tn0YWhtavO3ijqSzYXdMf2ZTWtUr7fbwBkTqkqXhs8tMJaqGCU?=
 =?us-ascii?Q?uk76vBZ+HL0ywKUBjKBN5WxE4qTqhEvlk9u0/o8RHA9Zk2hJPVokkiGjKLrG?=
 =?us-ascii?Q?JtTEVinhnSIOgp5NjjFtY9Y2vGaYjjpgguRRc506vPG/VcCUfPXsbAjX5Cx+?=
 =?us-ascii?Q?iTeg4+AZgwXpbWQu8E1EXidMXI8Jc93IT1lxDEY8hB4aV/zM713z28wflAGR?=
 =?us-ascii?Q?4Wyz2zTg7862H+cdv4jE4mJtoAx8+rxXPrkYu5VAxCJv1jLlZhf5xcUxomDf?=
 =?us-ascii?Q?OL97DgVZDWoK5/HEvfEy5w3iuO6MQitdrkQgZw5K3Ccz3LmDzFI0COf3cAWx?=
 =?us-ascii?Q?Jgjm6YczRhcScUAiYpXy8JCN4Uuz6h8Az7sAbfNfMgK5gs5idt4B8xMZTWKX?=
 =?us-ascii?Q?ydTkH55a8rR/MHJIEl7BT0sCZkZ2nHAMAoWyb2GuOHPicgY30RoAFvzhROF2?=
 =?us-ascii?Q?RPbPvA6xNYRVdWQrus1XuaP9bPeScx6EeKMn+Vdow936Pckb4M2A3FpNVHNz?=
 =?us-ascii?Q?lzT2Av1Vrr+ijgx+/VQokgy64cDHV9MEpUsk0clV8LpCWhC7wJXzy5YYRjn+?=
 =?us-ascii?Q?8Y697+1H2YLJuQ/0A/XMXCA9CHDhjZ+U+xZeZGmbWvA5z9QtgcdYtUfdKqGw?=
 =?us-ascii?Q?x2/evaEUwYcfNzE2XBOwXjtLF48uQ5CHXKwpgNCr6UJaRcobPWooEOTNpu8z?=
 =?us-ascii?Q?rhlEDGr2F11GS9VOkX1TiDgjiZ14m+SicOriIIeG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FrJSh5KrXb2KYR2IdAuSsoqVTniCfiF5pp0cZqyNqJ89sWeJrQUu1S1Tio9+77CT1wEdL3Je4R5XluqwZWYnFNRGndSEaCHA8+oeTypnkeOT26XZB/fzYBX8aFkW5/5GCyr+oMB+S1wfQ1jrVgHAiow+b0jbR9giCupKJPTT133uaKaRg/eiRZkuiNYZW1dkYj0CPqZQtt9F8ZRRkHzq6nabERu7zPIeDpsdGReakGo+4mHc2RsH8ZcRsowvzl+RONgKl+G23CGB9IlzsMnfRL433nnAqlNAtjRBP4Tr7L0TqOzlKHni7znOcU0f9NjgTEp4cYsxPmuc4esQqvAGeGgR1JkiaJlR1OPPhjzfquSKD0fRg9u/XVcMfvwsLzlaxiT7Lw/CtwFIWZ63+bHiZjeupbMbEJJYA88vkA1pl6aQ629E4G2rfw8Nh/NOZdfeLx3tbl1SQaMCA6yvy6/7lz0ZkdV6t1CIVdO5/4W1ik0sUYMIm8Vd1YCvpwx60ORdU6FU5QAAlKBZ7pkYN+0667IkGiKSioG3Vu6bKYb3oVtWhiivzb8WrFtGm2KE0KafO7NCmt6/r2RxWgfST9qxZP86MC05iRBu4gmigXQfiN4d/fo65dHNQUFZAeyFBFd6zwODMjnFMz7A+hRIYz6dIdnSKnPBz92oF4OISPYuiAv0jI4pKqrt2GyNL/eUlJii8Ui2QCRdh57QTA9f76RBot844mIe6b8jUs3WSFHynLLZx1qieLFf5hWd12ufHkUTewVaYsiNr0PsxHQEbx6xVg==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0201MB8808.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1871b544-14fc-4ace-9c08-08db5c75f049
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 16:43:01.4854 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2NeRn2ueVKftIQ0BeHOK6vaBdnKBuaI7jdHgmXy8Dq2XWWJZJpici3cd9VPc02Jm4IBOPA9utnBjf7kqjccWlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9068
X-Proofpoint-ORIG-GUID: dr0vHe4yOSDoc_l7aHT2jL2Ta9mrYO1x
X-Proofpoint-GUID: dr0vHe4yOSDoc_l7aHT2jL2Ta9mrYO1x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_11,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=622 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240138
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
> Sent: Wednesday, May 24, 2023 9:42 AM
> To: qemu-devel@nongnu.org
> Cc: Taylor Simpson <tsimpson@quicinc.com>; Brian Cain
> <bcain@quicinc.com>; Marco Liebel (QUIC) <quic_mliebel@quicinc.com>
> Subject: [PATCH v2 2/2] Hexagon: fix outdated `hex_new_*` comments
>=20
> Some code comments refer to hex_new_value and hex_new_pred_value,
> which have been transferred to DisasContext and, in the case of
> hex_new_value, should now be accessed through get_result_gpr().
>=20
> In order to fix this outdated comments and also avoid having to tweak the=
m
> whenever we make a variable name change in the future, let's replace them
> with pseudocode.
>=20
> Suggested-by: Taylor Simpson <tsimpson@quicinc.com>
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
>  target/hexagon/genptr.c    | 26 ++++++++++++--------------
>  target/hexagon/translate.c |  2 +-
>  2 files changed, 13 insertions(+), 15 deletions(-)

Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>

Queued to hex.next

