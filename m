Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0A670C4F5
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 20:07:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q19vu-0005cE-PN; Mon, 22 May 2023 14:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1q19vs-0005bu-QO
 for qemu-devel@nongnu.org; Mon, 22 May 2023 14:06:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1q19vq-0000l0-Nh
 for qemu-devel@nongnu.org; Mon, 22 May 2023 14:06:56 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34MFWAES030931
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 18:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=ilX3gKzbvmpV2prXdEe8pXc44C/MO9jM6kLdvhxZ6zg=;
 b=hlHqRNLWZes8ZpAjS1F1NP+T+hUbyq9OQ5mhh0P3n/VPIcyZZzBrc9GOm2TbYNY4zags
 h1LdAOua2P1Nr7AYXLZ/VVXpXmUtRArXOUhAK2GI7N1TLcWk0XoYb9z/CZVD8p6Smj63
 wWoZlaqpLdAiF7GVGRKLqb0P9dh8+rO6MORWdGeUdgyfGSvHmCvsynlAd3NbtKYIUkr1
 UXCps1ptWGFEsV4P+iupvxTzy8iKt7VlxUn2EtrcOvRf+2wHmWaXSjhxsrU5ISr8l5Js
 xE6yhvoVaCxWcok2dULbzw+PVle6NL4QDxgG639hJYVBBw15Q1GDsGLhFfQZ1NbZVYGL /g== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qr4wh19pf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 18:06:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYTWe+/wQxwy8sO5nxzD2s71ZcP00g4IsZHYY+H+3GXcVN2pvMyoTRDT7zLLnce3Vu7sg9csDcNHyOYtal4otjY4L9I+3eA2oHsTS2hh/tmydVVnYov2etVIo0PNUTt5Aian2KrTvgnFORLfjedZhHFIageilwhugeuINIQ+inCOSQLbMb1j5NiPkwHXdAK0K6fInm9aAyVAnTTClQQr4eeUhJr99O7egmyX8VSu9vFmub2mLYCtNUl73afGNKLjQZb8wlaXl7f2G2rPhAoT8XXkhacjT3OqIBjSiwFkByvR8eRGAZ6/uMc8XkmdSceXvrxuMuN+dUtRWDRiWItCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilX3gKzbvmpV2prXdEe8pXc44C/MO9jM6kLdvhxZ6zg=;
 b=n8gpGgH+NjKnpu0wBkJPwgmlli0mMLO95SADxUbqekvMadaJhTR7hTn+V0jXReVcDKIVVJ91x2wVYqwGmN6zpho8G4mpFGuIQPNCZOO33H6sAiDOWuznjAbaBGydD8ex+mMT5qQ6XIRbUcWMWCH1xsS8HWHO1w8XAgtqz7cHk87bdJ+R0lPuj+xHRhOqmpmSYnimYrDEiA+8lbxQmhlapIw5tp+bYfY0h6SAB7+Wuj+zXz7EP4Vzdu46pPMbpccW0Q++5ICBKaYD8D7y1pB+sfLpR1BTN0Mk4b6y9hFXAqcfSr+mnZZcTX+aj7hSnLuR5AzDeFpFsYAMGeJnZaBv+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by CY8PR02MB9226.namprd02.prod.outlook.com (2603:10b6:930:9d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 18:06:48 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::d992:f4f7:1e0f:a51c]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::d992:f4f7:1e0f:a51c%4]) with mapi id 15.20.6411.025; Mon, 22 May 2023
 18:06:48 +0000
From: Brian Cain <bcain@quicinc.com>
To: "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Taylor Simpson <tsimpson@quicinc.com>
Subject: RE: [PATCH v2] Hexagon (target/hexagon) Fix assignment to tmp
 registers
Thread-Topic: [PATCH v2] Hexagon (target/hexagon) Fix assignment to tmp
 registers
Thread-Index: AQHZjNV8F1PZvJc/MEeGpF+PRlZOx69mlpzg
Date: Mon, 22 May 2023 18:06:48 +0000
Message-ID: <SN6PR02MB4205184F96987701468F3FB0B8439@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20230522174708.464197-1-quic_mliebel@quicinc.com>
In-Reply-To: <20230522174708.464197-1-quic_mliebel@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|CY8PR02MB9226:EE_
x-ms-office365-filtering-correlation-id: 63b3ed5e-d6c0-4010-c2e0-08db5aef4f94
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LAE86DqF4oUD6R7i6n52j9K/eoTPF9nL1OKfbq0+EZa4w8/Ty4elA+RfejPQZnAPjqZwMd8zyaSGMlshR2/LzbeZNovenREs3qmWfHhyKg5Hl6kBr0yIAzH0hExRlR1zg4v0VmxvEBTBSeNP5ur4zKqRgxYX/5Ti8ZuAMKof84fdKEZHbY1t5Fpa/eSUddEnGVTGTKdh+ZAqcJWeI3cIViNpOSB4VPwQOIH3QlrCb4itvsfJaxRHnN6mvCMDLEO+3g9pnnVt2LYJpt6xT8RsCFgLY9kZ35B9ttPRKn7i7VmL4fP1dtJHYdgNDaE+BDBjU9Hs3yzHJjR1lI/anJP7/E9XRQrEwKzpponfkNmCGlXDOICNkhL3ISkbQKmnsgxUr+799CKB7T/CaaEWWXdJiXp1aCOmNgB+Mz/buflZL4c8p2Krha57fOkAr/0mDFO/Sm05rQSCiNKaN5YhST4lwsT0ewY9E6dZCCESUfRSAsDH+8oieBw8tGRXOfvXvYdz6NS03D31A09vCGtI4Xh1172lve5/oQt4MRLpbTH+23fnlN9QUT03UPd26ZMyKd9XiniULg528AxL3rnkReQkGa10APB/tdmKINLT3musoH9kv/FjTsoR76A/mBoBKjjm7Ki5EiJoSWFjhAcpn+5Y6Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199021)(8936002)(8676002)(5660300002)(52536014)(53546011)(186003)(83380400001)(6506007)(9686003)(26005)(107886003)(86362001)(122000001)(38100700002)(38070700005)(41300700001)(7696005)(71200400001)(33656002)(55016003)(76116006)(66556008)(66476007)(66446008)(66946007)(64756008)(316002)(4326008)(478600001)(110136005)(2906002)(2004002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FAICK0UmrolNrlBsqJekIY0eRfJCfD7/X6RW/FSjn/whvcQ7JCTVTGW8v1zM?=
 =?us-ascii?Q?LsE7gajK6OltAuFkfBm9VacLqy9E9uIyS/xiRk5NJYejN8MJdzd840beSq/p?=
 =?us-ascii?Q?agtgKRk8u1VPzS4oJ7KOupPMtGfF323w2QI5oVZ8F2uzIZjHUh0Y1HM32jwF?=
 =?us-ascii?Q?hroFrt9V77vd7QSJYPrNEmspXFWZryj1mmjxBpl4MWkidEUnwgzXauL3QUkF?=
 =?us-ascii?Q?zjAIy9P3QL3fZAMNLSC9vhOuBRwmj/rDPNDF8XQuK6VBlm1XS/XxjKx+Bzg6?=
 =?us-ascii?Q?VP5vzDNvqlT9+0sZjT/HxUxTP7SW6NDOnQBkKZkL7dty0ogPVN70s2JEexEC?=
 =?us-ascii?Q?S1KIe2XrvVRmCo2qQJV2vDWvi0iI0o/XANAJN5uglYZK6qbThfcwS5Nkhotl?=
 =?us-ascii?Q?2Ek1hH5QG6b1CHhZxhBzLnWIUvj8SEcQdOFTG4+2LJpOFPeh6GuBZuf3liTX?=
 =?us-ascii?Q?g8YJVWnJf3zcZTU/Ay+iwSfeideuuhwNbpJCdE5ipgEzEf3cOsgqmmcJuUmA?=
 =?us-ascii?Q?jLQOq37oYETR4VWMy2iSV88a1Wk1LhV40Ojkv+IDT3HYv1LpTUDAkdcjKeNp?=
 =?us-ascii?Q?jMmckOefoUtbrTKbYOJWN1zoRHRPv0/vJzj6wc8IpBp6Va6IOf0BsVrUM5Tu?=
 =?us-ascii?Q?I0kOvpp+3LauvrcfERi4+Eu+/qq4KI/1Up1V/dcOXl7ZSX4qZPUdwr+eKe1Q?=
 =?us-ascii?Q?qtaN1VijaBRhzM1LBOwY1lXPWCvOEYkLt+qYEWQPSqltI1LF4UftbLWTeQwb?=
 =?us-ascii?Q?Pyuk1zTYFgZOkKBQjm7urEzziSBunXiDp21mdIEWZx0xYeBM+6iR4y43mlXw?=
 =?us-ascii?Q?DOBd2NvB3rsYUmjMswp0Mwn8SRTgRuvRwHdnhFIrEwOjX26Sc7vmBOyJWgSS?=
 =?us-ascii?Q?PvLMLvKAYsgmpBu+aVk/sCvZ7Pn4BPVHGD9lQOmlnNk1yujmhjN58IbRKcV8?=
 =?us-ascii?Q?CRAgimOcbyg+SKPn4zH7zrYpOvoS4DHBpEc/OB7tLYbDw/qF6qnEexWIln+T?=
 =?us-ascii?Q?vo2kcjVeooFYrN6RtcCAkAOWYGfUfXDpdJIZEZyMya32VrNzPVmF9gn1gFK7?=
 =?us-ascii?Q?UHJ+P3QAr+9uUaw7ynJMQwS9chXq/oqSrP8TO3kg9zY7nI2nAkGUSuxnF8wT?=
 =?us-ascii?Q?fgF2DzPjPtzUvE9C/SSkFs+lsVzmtgLeW3C5miqXHMjIg9C1nkioqQdMNg03?=
 =?us-ascii?Q?eW2JvFw78TqPfA8o3tJXImUg6nrgeDwxIX8UP1U16vdDmxNzpOlpAartQ6+l?=
 =?us-ascii?Q?IYp6Rg6scAsNELFeXD506XKYobzE21BIuh+z9z4iw9oVQaJhCtinKAv+eY/j?=
 =?us-ascii?Q?TVWHwvYZdvq7+Ns0E3pdbcQrpnXmsLGAaVb30ltJGlVXbvqk5gBG/KOeutCq?=
 =?us-ascii?Q?vlGaSUwi3Fsg7Q0dEglw0aC7btlgSF48QgytQ7FcecZlGS6qhhq9DQ7PBj2f?=
 =?us-ascii?Q?qqF+NtcJCscO0ZSLXuC+qwJciL/TUPjOhIlo4v2FlNlvC3SSbIvYIGPFi/Ro?=
 =?us-ascii?Q?cV8LyBIpmJjc60kOX+qKrAqEzYhw3sAr0N7DJttuKJOpSSLA4VR4uLzGAW4O?=
 =?us-ascii?Q?qhtyWpOSGSlhCIMbOQ3AuZfYFCyre2JE0xhVRLl9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cEYHCof+ROGbczl2Sc9izAA8g6t1JXbEBic2ksMJRTuneOrllqdqfJhJCEFM2Ehdz2HnRR1bMW1lTZDKgfD5k4IEMsWWa4qwRKC2gXmPEKsSeMqgYsattj4X1ibK4gv0R6BlasfrM4lPk40/j9VIOrDdTqvJ7qaqE7VtUo0wvXb1PDyIV8TueIxug3t6ji/AuVKPy9J5OnxEQUfgs8myu+6Y9PqNdZoZE+k6ZTrJzHq4QcIjIbndRgIdb319oeRxNQw9Mr1bvZvKAe4Hq1ZA072ZsxzDsjG102JgPQSXd8suMPENCog7rRecJU+4WFT27zHUfMiNvKgLuJeowXTXly+u53s5YdLTL6pZmas+Cxp5rjgC6JP62pDZu90FGTXwDgcEeIZsMhoqCwHhY6Pl2N1WgkknNY3tM2Mvuesi4k965HiDDvdNVuq50aO9x9erwokyP+ZIODRIm3JvPw2AMitonHnJtLOlig5x1db6pftJI2DiaaVhqmznyewPIru6z06YTOS0/8M+JabBD14OPNt98KLK6b8K6Qv20FEsYzjgXWSS3o3SlWhLTw0zLxNXFtsVBZW+dAmiAw+Re7tGQTm3LI68ncYh4jgz0yCe7UpLr7qDftFaZ9mWVRFYkSi7jbuM1wRd3aZohLfOxi053ujcAC4Cm1R172hjXkNsHPcxCyOUmKqBTnf3UQtuQLr0aCRgVJ5xyPbw1pj5RtyRjNOKE3zdhcO3LUORb0LSZlhqr6m1XBpG9ft/yN2JoboQSOyrli9ks4PXfkrnPfs7kA==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b3ed5e-d6c0-4010-c2e0-08db5aef4f94
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 18:06:48.1391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 415F1AewwNfDThrGppr3cfUb9QIAEBLwCr4mH+OJ2ulrtsCa3A3Vkm4aeC37HU+7lSiPao8WoCzslFzRCC7eDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9226
X-Proofpoint-ORIG-GUID: MVC6_VFm77rKwyPwxLScZdraHtg8gR3Y
X-Proofpoint-GUID: MVC6_VFm77rKwyPwxLScZdraHtg8gR3Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_12,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=913 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220153
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
> Sent: Monday, May 22, 2023 12:47 PM
> To: qemu-devel@nongnu.org
> Cc: Taylor Simpson <tsimpson@quicinc.com>; Brian Cain <bcain@quicinc.com>=
;
> Marco Liebel (QUIC) <quic_mliebel@quicinc.com>
> Subject: [PATCH v2] Hexagon (target/hexagon) Fix assignment to tmp regist=
ers
>=20
> The order in which instructions are generated by gen_insn() influences
> assignment to tmp registers. During generation, tmp instructions (e.g.
> generate_V6_vassign_tmp) use vreg_src_off() to determine what kind of
> register to use as source. If some instruction (e.g.
> generate_V6_vmpyowh_64_acc) uses a tmp register but is generated prior
> to the corresponding tmp instruction, the vregs_updated_tmp bit map
> isn't updated in time.
>=20
> Exmple:
>     { v14.tmp =3D v16; v25 =3D v14 } This works properly because
>     generate_V6_vassign_tmp is generated before generate_V6_vassign
>     and the bit map is updated.
>=20
>     { v15:14.tmp =3D vcombine(v21, v16); v25:24 +=3D vmpyo(v18.w,v14.h) }
>     This does not work properly because vmpyo is generated before
>     vcombine and therefore the bit map does not yet know that there's
>     a tmp register.
>=20
> The parentheses in the decoding function were in the wrong place.
> Moving them to the correct location makes shuffling of .tmp vector
> registers work as expected.
>=20
> Signed-off-by: Marco Liebel <quic_mliebel@quicinc.com>
> ---
>  target/hexagon/mmvec/decode_ext_mmvec.c |  8 +++----
>  tests/tcg/hexagon/hvx_misc.c            | 31 +++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/hexagon/mmvec/decode_ext_mmvec.c
> b/target/hexagon/mmvec/decode_ext_mmvec.c
> index 061a65ab88..174eb3b78b 100644
> --- a/target/hexagon/mmvec/decode_ext_mmvec.c
> +++ b/target/hexagon/mmvec/decode_ext_mmvec.c
> @@ -1,5 +1,5 @@
>  /*
> - *  Copyright(c) 2019-2021 Qualcomm Innovation Center, Inc. All Rights
> Reserved.
> + *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights
> Reserved.
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License as published by
> @@ -148,9 +148,9 @@ decode_shuffle_for_execution_vops(Packet *pkt)
>      int i;
>      for (i =3D 0; i < pkt->num_insns; i++) {
>          uint16_t opcode =3D pkt->insn[i].opcode;
> -        if (GET_ATTRIB(opcode, A_LOAD) &&
> -            (GET_ATTRIB(opcode, A_CVI_NEW) ||
> -             GET_ATTRIB(opcode, A_CVI_TMP))) {
> +        if ((GET_ATTRIB(opcode, A_LOAD) &&
> +             GET_ATTRIB(opcode, A_CVI_NEW)) ||
> +            GET_ATTRIB(opcode, A_CVI_TMP)) {
>              /*
>               * Find prior consuming vector instructions
>               * Move to end of packet
> diff --git a/tests/tcg/hexagon/hvx_misc.c b/tests/tcg/hexagon/hvx_misc.c
> index 09dec8d7a1..b45170acd1 100644
> --- a/tests/tcg/hexagon/hvx_misc.c
> +++ b/tests/tcg/hexagon/hvx_misc.c
> @@ -60,6 +60,36 @@ static void test_load_tmp(void)
>      check_output_w(__LINE__, BUFSIZE);
>  }
>=20
> +static void test_load_tmp2(void)
> +{
> +    void *pout0 =3D &output[0];
> +    void *pout1 =3D &output[1];
> +
> +    asm volatile(
> +        "r0 =3D #0x03030303\n\t"
> +        "v16 =3D vsplat(r0)\n\t"
> +        "r0 =3D #0x04040404\n\t"
> +        "v18 =3D vsplat(r0)\n\t"
> +        "r0 =3D #0x05050505\n\t"
> +        "v21 =3D vsplat(r0)\n\t"
> +        "{\n\t"
> +        "   v25:24 +=3D vmpyo(v18.w, v14.h)\n\t"
> +        "   v15:14.tmp =3D vcombine(v21, v16)\n\t"
> +        "}\n\t"
> +        "vmem(%0 + #0) =3D v24\n\t"
> +        "vmem(%1 + #0) =3D v25\n\t"
> +        : : "r"(pout0), "r"(pout1)
> +        : "r0", "v16", "v18", "v21", "v24", "v25", "memory"
> +    );
> +
> +    for (int i =3D 0; i < MAX_VEC_SIZE_BYTES / 4; ++i) {
> +        expect[0].w[i] =3D 0x180c0000;
> +        expect[1].w[i] =3D 0x000c1818;
> +    }
> +
> +    check_output_w(__LINE__, 2);
> +}
> +
>  static void test_load_cur(void)
>  {
>      void *p0 =3D buffer0;
> @@ -435,6 +465,7 @@ int main()
>      init_buffers();
>=20
>      test_load_tmp();
> +    test_load_tmp2();
>      test_load_cur();
>      test_load_aligned();
>      test_load_unaligned();
> --
> 2.25.1


Reviewed-by: Brian Cain <bcain@quicinc.com>

