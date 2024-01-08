Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CADBF827AAA
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 23:34:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMyCL-00005U-0X; Mon, 08 Jan 2024 17:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rMyCG-0008PO-WE
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 17:34:18 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rMyCE-0007PL-Nh
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 17:34:16 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 408IhM5U012766; Mon, 8 Jan 2024 22:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:content-type:mime-version; s=
 qcppdkim1; bh=o+KYIekdC+ujVgm4mcQrHawFma8LjipgNgSYnGWTO1I=; b=l5
 j1pw6KJEicZT+KK2bbikZ3F/DDJUfovaHeN//EBXh4LE6gurFLkCMvHPmuvifcqX
 s9H67r+ICnv1wKrV6B626cFhopknu7xYj1er1vn8qaODHdMSmKRF6wLY675GQ8ZO
 B39gGrQUrHo9HWxmpdp1VXtf8IwrQvCOX/hEIzCLW5xSYp2xg6gATylTe9Yljh3v
 KYhaVW/aJO9avsMjvdhsmbn5BC/3BWq8NwCQafDiaZQ+F/+0ID4qV2Sb6pSdpjzZ
 pfleu5O+sAEUvRATkUwQzr7WfkKte3JVvHNQoi6neThxp6daXh9dEvD8FtYUfnhu
 sWbDQQEFGnL+WQ+WYpCw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vghmbs7qw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jan 2024 22:34:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ha3OxjtYFmtfXYmuq1uzAt9jYCtdiiDb0LMlfAj50OlIfoc9gV3U85Abk6EZEhoGAjZQ+8TMK3sfQ/GT+WKR/LOiGE0d5V3x+hEbQkL3Qiui5/A5CB3YTsSvIc2jq/iZEfpO5McnZswREgDqsZLYXG5yUVzSK2SAf2UhodY72BTHpvks9pyDWjNUpu4NoY5Fn2FLpOOtBZGn8nTsuDNy1rZ+06G5DXixWBI8dilyhSFzrYEpkisI6Yqa0LJwwcZ23I8oH5YnZ0T6G1oPTEfU+U8527ixyUx3hZ1/FfnOC6ajfG0+Nd0wMM3ytvugYol6006+HWmFMYSJcQpR5n5ucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+KYIekdC+ujVgm4mcQrHawFma8LjipgNgSYnGWTO1I=;
 b=UnVFcQw7Bxn8kuOlGosp0u36/Q9JcQxi/NI2n+7LQCEnolIf2lGX/3rUALcj5xCuE5H8gIyH4ola6/A5McDnCVuL02/zcxi0Tixxgouq5mleusKADAV8owao9MN5g8DMQlXv15i4oTMJh5Tvy8d1KZYYOYdXdnySuXF/2A7sg2fH0YEulbkaAnWz23JiZ3tKJ8fR2c4hPu29NRPlWJZWMhRJGwEGeKezk5dyPhXu522zyMn63XEXAuOF1MLLO7YEhH7zVyEMwUo4pRm1ozXV9CmGFC6OqbYcTuuy+VZJfsHUN9hlgih9J00XzetdBmPEdf9oH76NBN+JQxGxQY3Ihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by CH0PR02MB7868.namprd02.prod.outlook.com (2603:10b6:610:111::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 22:34:08 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::dfab:83e2:41:20c8]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::dfab:83e2:41:20c8%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 22:34:07 +0000
From: Brian Cain <bcain@quicinc.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
CC: Sid Manning <sidneym@quicinc.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "Matheus Bernardino (QUIC)"
 <quic_mathbern@quicinc.com>
Subject: testing without the translation cache
Thread-Topic: testing without the translation cache
Thread-Index: AdpCgMLzbHROSbU7SdmIS6udWLPRag==
Date: Mon, 8 Jan 2024 22:34:07 +0000
Message-ID: <SN6PR02MB420583215DEF63E921BBB758B86B2@SN6PR02MB4205.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|CH0PR02MB7868:EE_
x-ms-office365-filtering-correlation-id: 44f5919c-8204-4ee3-9626-08dc1099ed6c
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U4OVcgrkYfwbCn6FKDgrqkjYau4xJiNBc1WNf/AxuM+djNL+khNMugxeqjr0fOmhBtya0XfrNa+/aqv1RgUD+aiexrZTx2s8jEoqzDVLOtvOB0WPEhPtvqy6j2diOOZzv36nVGKUPAjHzCGq+naeO1KopQ6ehzUEP7nDB8DKIv//8trfPXYDybqPxheJxHL04iR2gPy1XS9VtvxxQiStPiQoCc8C8iBeSQa6hJUBRHLTTztrbYyr0Ov98sgeyO1TKECVvMmnIyeCe/ZWGqxG74+ITynqeAJFGXy3QTBPiNyrCR3E6OTbhpRE4sWbp8sZBnzw3h1N+GAh5RlDT/z61J+4hIKTXoLWsYyj3BuL9EF2/bO2NCQOPT+T0HTJwbd27iTjyiOiV3TrKNV/9i8R97A0G8LVAtP/pw8/il1YVYXydy8zIQ4e4pm3UdI11ild3dazxJPpaUPbWd237evVaZbJyS6uymwhD4Hl4LdFWTp0BxobvXSeSZqR5Y4sB2dj2npctU0bHndQtvovZ+j/nrL2EWKTjv8Rg2mz3WjgARMHX65ch0VJhAvJtRxRHkbsnTzF+XiWD7kUxCezWfiCEOIY7Xxkm01Yksd2Dwb0f9nDMIXoiJRDND2/YsBcZ+ld
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(4744005)(41300700001)(7696005)(55016003)(2906002)(6916009)(5660300002)(38070700009)(122000001)(54906003)(9686003)(33656002)(86362001)(6506007)(316002)(8676002)(52536014)(8936002)(4326008)(66946007)(66556008)(66476007)(76116006)(66446008)(64756008)(83380400001)(71200400001)(26005)(478600001)(107886003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qLIi3pc5AvTaIbDKhR1RGjMfcDFhpA7ugCsL6xEMG5Mrys3P4W1MakeXT4?=
 =?iso-8859-1?Q?s2KYHkdwdvPJGtVl8uFGeuHzQDnCJt2bq6+ZKiq6dh/fbA0PCys2l8hlr0?=
 =?iso-8859-1?Q?4Ft6y+/XBnsAGS4ETypFs1xsqEZ/NaxplY3KU9mmsyT0Jmn2OagLwKYz7s?=
 =?iso-8859-1?Q?KfTGQMvRbonEPywU/bmZcCNDbtVExguqbEe08GfYymySVu8/wbZmHL6Mrn?=
 =?iso-8859-1?Q?nDVurq19O2lBk/RbYvdlw075Pu18uESLmb924qLX1L7V37OO9qtYkrBuPN?=
 =?iso-8859-1?Q?RyQTpp0rwFTUXmWJ4wdv1bFABNScYoQT5qOeGh0PU95taQl+gXyZoLsGGE?=
 =?iso-8859-1?Q?1RADAtWWO3VhL5vZ255fIxmPJpKXverliEKDm/0zxwk/n8XzNM3QlWAhqg?=
 =?iso-8859-1?Q?AceWBHKgLzayc3mU0Rb9j1/99PhQjlpUDmd00xv8P2PkjF1n5kAyC4WMwx?=
 =?iso-8859-1?Q?eimL7fGbXB7hCVs2cf2EcyNx84ciLg/z3lV3dZx/5e18N+ZidQvd6aqehy?=
 =?iso-8859-1?Q?ltGbjqKN49Fp9ljPw3v+mywHyRpJbbiSgxXqxRG817K55pjQ3EQ4Q01DYT?=
 =?iso-8859-1?Q?2D1GJTnGmFi4nBHp4Wrfm7GAeQ9yadbe/KZ/DqlcNAog031V+K2MfBXIdr?=
 =?iso-8859-1?Q?3vhWKxCgP8ClfG3j6+Cz5pO+IpSxi/xXWyBiF4XwtzX5JfdaMYZbKWY3IG?=
 =?iso-8859-1?Q?LG5OdIuYEHNCU8iLUpfykmIpCXYRPqkmJAtp3ivYdRRavOAlm3dcaoe3jR?=
 =?iso-8859-1?Q?fUlEyt8rKeMkifuFw0FRbQEK5n38GyG0sH9zLYiUvwiQPklSXrBM1Bbycj?=
 =?iso-8859-1?Q?iA2RZFKEQ4bPKpw3cf0CTb6CboEk5rLefPXhtTPuM7P55OkyqZIAQRVs05?=
 =?iso-8859-1?Q?I+R62bri8gjd5mU/x650dacIm5cTwLAO3fYX5X81JBWMCQIi9gPyp46O2P?=
 =?iso-8859-1?Q?OddgW8FhAhRrd03TP/dEQXsofHw/+lXQxcNQop2QVlrWkbPPqKUP5wWFbv?=
 =?iso-8859-1?Q?UD4zHWBfRAlNZed2DI3LCRKqLQQPoAlveSZ3n4S+RihSKpmRuJ3VBgL7LJ?=
 =?iso-8859-1?Q?3CWvKT81W92wo7z2c2iHilK7Ht/wylKer42RQDRrdCv8rWkrV62aNqOw41?=
 =?iso-8859-1?Q?vlPeQaip6iHN0D0nS9v5uQLulTpwvchoI2awR2ywa1JdedKPh2ng4n6zBW?=
 =?iso-8859-1?Q?ISFSOGqWWfcrKvcU14FC9lNnQaA1jsJBQYpsCp7WX99Y7wlujWFC624bEt?=
 =?iso-8859-1?Q?2jD1DjJqb02wgf6ms/fEZGVMS4fiSrcJzlq0ZIoDDl4KmxnFsBgSYSkRfw?=
 =?iso-8859-1?Q?K88/ZBrh6vmyzXksUGM9BRmJV8hz6l/Bqs8Gjj/l/cJS7ne1bJvjvDM/Hg?=
 =?iso-8859-1?Q?nMSAha0G0GVBvm+/Z3a0iKrULHr12g0zLsQkuO6sariNXxtRtwdBJT4OBF?=
 =?iso-8859-1?Q?W/jWRlQRwSBKV44bbuD+f/hr3KrrRWQyVhXxePv9ApGXp3WAJzk1U2n+CA?=
 =?iso-8859-1?Q?HaXpEvN+qF/RktpgMkBpjMMBnySuIVhy2K+6yxF+Ga1K/3HuNVElg7/Bt2?=
 =?iso-8859-1?Q?pEPtmSGTp942ZkuYhI6ZX0Snxb6triZMkz8wtpIm34J2480xmxdzUUZAMc?=
 =?iso-8859-1?Q?Unc8UBaf1KgN8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SN6PR02MB420583215DEF63E921BBB758B86B2SN6PR02MB4205namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9oBWDidW/Y3GqGd2lx+DY7x+aMByZxuukwApzNJPVgcBVTX5lspBCuc5GNkz2d3EeAQXhzaiBp2Q3ZXAnMdhFrAJd2L6Yh8Qdik3WYjG/4yBe7fs7/aYino2UW7a1mOyAqPsLf9hSFKFIBnGjqWoU5Oo+9Q0v3gWqU1i6Att1ZR7BfXwju6BLOmc4QcLKvDUy7z1I+h2YTvR4jeMwqaASAdH0Uy+zSqJ4AS4wqjGCOnSLPxGpDvpM0ZmnjH8M5/CV/VHXl6GUxawlN0tY/Oeel/jl/249ksFrr/yrDIQvJYv5s8Q3M3Hg6yE2N8eOWjVlqj0VGbTjZrNNvwoLjrKyd6/19lS2KsI394jLljxXqLK1HW+a3Wzq78+3L8JTwLQzGw/drX5gZDrhkTLIfIbZJLiBVNYFWmXXs4AEInSOfmEvK+jd9Vkdu5YDOIb/jVE8FxAeH9TJ6oag1foL9IOAEW9LeVVPm5g18gYyPzUZydxibsBZL56fTD1p9fUXuUcN5kUnjbsPrmzjqgh2wlNQm0sO3HXcBvSaKUnk6MAG1Jd3S2ib7Y0WAi1hfDJiQ09jaZ1lhMGx0ZBIPIFPeVx+EaBHqs9HTIKGCa1DsMcYbq44CLvqqKD2f9zo7g9EGqf
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f5919c-8204-4ee3-9626-08dc1099ed6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 22:34:07.8934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rcAU6RFpa0267NQ6dNshUmKRti5VxA5ps/oMRVkP3A8jRwsu5K79Z8xbuYXrEbfBWicFvqTTqQ8T/qo7JfSS7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7868
X-Proofpoint-ORIG-GUID: kMgyg7sgLvXcG3pznd2JHWfOSokVktdb
X-Proofpoint-GUID: kMgyg7sgLvXcG3pznd2JHWfOSokVktdb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=743 mlxscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1031 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080184
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

--_000_SN6PR02MB420583215DEF63E921BBB758B86B2SN6PR02MB4205namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Alex,

A very long time ago QEMU supported disabling the translation cache via "-t=
ranslation no-cache".  That option was deliberately removed.  We are lookin=
g into a hexagon-specific failure when there's a TB lookup miss from a cpu_=
loop_exit_restore().    I'd like to test our fix for this failure and was w=
ondering if there's any mechanism to disable the cache.  There's a "-accel =
tcg,tb-size=3D0" - but this won't accomplish what I'm looking to do - will =
it?  If not, is there another way to disable the cache?

-Brian

--_000_SN6PR02MB420583215DEF63E921BBB758B86B2SN6PR02MB4205namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
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
<p class=3D"MsoNormal">Alex,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">A very long time ago QEMU supported disabling the tr=
anslation cache via &#8220;-translation no-cache&#8221;.&nbsp; That option =
was deliberately removed.&nbsp; We are looking into a hexagon-specific fail=
ure when there&#8217;s a TB lookup miss from a cpu_loop_exit_restore().&nbs=
p;
 &nbsp;&nbsp;I&#8217;d like to test our fix for this failure and was wonder=
ing if there&#8217;s any mechanism to disable the cache.&nbsp; There&#8217;=
s a &#8220;-accel tcg,tb-size=3D0&#8221; &#8211; but this won&#8217;t accom=
plish what I&#8217;m looking to do &#8211; will it?&nbsp; If not, is there =
another way to disable the cache?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-Brian<o:p></o:p></p>
</div>
</body>
</html>

--_000_SN6PR02MB420583215DEF63E921BBB758B86B2SN6PR02MB4205namp_--

