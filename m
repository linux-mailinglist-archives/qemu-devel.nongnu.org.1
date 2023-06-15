Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 119E1731216
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 10:25:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9iHN-0002ih-0r; Thu, 15 Jun 2023 04:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1q9iHK-0002iS-9L; Thu, 15 Jun 2023 04:24:26 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1q9iHI-0006eK-6h; Thu, 15 Jun 2023 04:24:26 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35F52722019805; Thu, 15 Jun 2023 01:24:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=proofpoint20171006;
 bh=w01ESmJBLx5L+w98rlcb5YsZAKQZI5lqMkrtZBd9p0w=;
 b=JgCcnhrKr8tIJxZR61GTDHq5UbTAdLC3fwigzAf/kwzJWrPF3sTai9XLc+rFET2FVX/M
 CclXhX7rFYYKFvD3engpJMJOdw0uPHUFSYeTOsnjJkRKcWV06fHrEK1P7eahusWrywJy
 X4N7ipXQIktvvr2xXdZnIBP+QP9e+1nAv5EuseDdlB2MVAjixZ72jRUdc0K/1WIHDY9M
 BiobvyW2VZrHC50aj59t5wnNeLnN6casfd3H9GgQG2kN+oD103+m/Z6vZNXFOcNRceXz
 5LWlAHbK1zMJxaadQ+Sb2VCEmth9ta2ejMhZKor0G7d4Lyyo6nqZZilfGSgVLLV4oMlj 8w== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3r7kk694k7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Jun 2023 01:24:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vjg8HVMKzNQ2EaIi259Z6Y394tWBCn+ibmAqws+AhWDTIzS5KTlwDL1krfCZlrgzwX6Gc17TKILtIIZXBfwArWe/xVTR600e0BG7odgOHA2h0rqYrmwrHwXkAKfiWDxy9H6KBQPFswOaKXJidEbxqBZQUii214OrWzVsYpFbwogRhyoFbzo9CAIDlgiu4A7VJio8W0VLzURJ2G/ogLm+OiAmuex04aMTqDlTtendEYnVs1b15kZtoenMVvMPytnJefLDbkt2bNN20+k/TADufCLMhlWyj8Lq2oTmflaJyKrxqb+LW7gvYmGAWwYIQQtLrkZN5y3jB2TnGKcv5ZVS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w01ESmJBLx5L+w98rlcb5YsZAKQZI5lqMkrtZBd9p0w=;
 b=moOiSmaIrvFEyoAt8zl+Z/IrOUY4YHBj11acpsvAtRJVlA6Gm8/7R65KYzg38/ySQTg1oVFoHCXFC0Pdvo/gL5sztG3DPJxmP6K/VBAYxha2ZSv7FQQ6VdSscYuvFCDStuTSnIGwThuiir0jV5TAfRTiP9sp7rZAI9zXg7p2CtEjL2X9xjv0NZiSXI8ae1pRdpXquBzz3RiMlbQlnQVv+Mt4bQMaFGSWV1+a+F7ihIEhEP9kThKi80Dy593EzP5v8o5Uiwi5EdIWIFxKpbhIAr/7p5BSk3km98UxyZVLzvznmF12PqrtBrqdrELU/yZiWu5dmO6yulB4pd5YN/lTMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w01ESmJBLx5L+w98rlcb5YsZAKQZI5lqMkrtZBd9p0w=;
 b=fyHp5XwD7qAlO6hcvJMALor4IIeUSRVD+NgUgZC5HZ39vy4uMvOFyil3EffZ/adAwmjLh2JKaJbgNy5Ya5YEILBJ4FMj8uD2uqTEdYQAAO5vh4PAynZ6tYX2esjamcbGMvwBk5hB5+uuzk4HG0U5NPBqCEjv/wGqrJIp7oIJGoTSMrlJM2Ab/t1qtMlT7LYWqDmkRsA0812bH3CB5o1cCneILV2L95lamkS+VF9UD7sm59lpjNNVd6Asmr+PF4OP/K96q3wMlrLGIlmcBqB0MMDz5G4UO7NbY2Ytzuo5RREbDyFCY1i4AlhDxF7Z1js87k1jNASVRnQG/qTk3m0jvw==
Received: from DM8PR02MB8121.namprd02.prod.outlook.com (2603:10b6:8:1a::12) by
 IA0PR02MB9488.namprd02.prod.outlook.com (2603:10b6:208:409::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Thu, 15 Jun
 2023 08:24:17 +0000
Received: from DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::3779:7477:d7ba:97ff]) by DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::3779:7477:d7ba:97ff%4]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 08:24:17 +0000
From: Simon Rowe <simon.rowe@nutanix.com>
To: Fiona Ebner <f.ebner@proxmox.com>, QEMU Developers <qemu-devel@nongnu.org>
CC: "open list:Network Block Dev..." <qemu-block@nongnu.org>, Thomas Lamprecht
 <t.lamprecht@proxmox.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Subject: Re: Lost partition tables on ide-hd + ahci drive
Thread-Topic: Lost partition tables on ide-hd + ahci drive
Thread-Index: AQHZns+NLlreHgpDE0eDi7XHUt+a+a+LcZaAgAAUMzI=
Date: Thu, 15 Jun 2023 08:24:17 +0000
Message-ID: <DM8PR02MB81215209B4EEBC6BCC4060D1935BA@DM8PR02MB8121.namprd02.prod.outlook.com>
References: <ad7e1294-f19f-5bea-e891-f6adbe323cd5@proxmox.com>
 <e53fba5a-dca0-6ccb-00ad-d9123b8fad95@mose.org.uk>
 <a5200692-85a7-caad-8af7-1ff29e6bbf19@proxmox.com>
In-Reply-To: <a5200692-85a7-caad-8af7-1ff29e6bbf19@proxmox.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8121:EE_|IA0PR02MB9488:EE_
x-ms-office365-filtering-correlation-id: 671053ce-489c-4797-4fcf-08db6d79e90e
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rNg86kaUSlRkpIhflOKKUV2ngmNoG0YTyhSr/yqPNbi4Sk6HDRrkZaeONXT2omeAmrxb3Zcl3X7uyaMtn7XoBv1hUNsNgKGcJfo+4eeqEA3DgNDekCL+XTZrxnvuXZTAIGc7XlQouHh/r2/RCZDbCT1KKJTt+EE+Nwo/i6p8VXrFPfXjRauWxlakQ8Wz8EQDquIR6yAjaNfL2QMkdLLU9HzCBduBhwMRJxfxCWxyjOeWqE2e9lclPRHIMNURdzI+OLerjFCX0hEZMPjJL+XjuyfZRx8VvHVx84u+RZVPebXR/+TU2STR2ez99r/0Dmcy8Zse1n3OSGp24Mk3bys4V9mwkyyjKJg2M3E/w2RV01Hbhw3i2E7mtUjWPRecttnzoXN7jAPXvbhPXaYCHZwWS5lI5YfWeNQarxM26iQa1sL/OLjfER0xVI/KXjc0K8Foo6W24MuktKeeL8nHW8aWFjocLu59RP7i1Zumka7kHmmIy6foX1riYIwGnWGThDydNhy7cnmh+7yQIm/xzGWWrJhMktLRRiUBP5i3psNQP3DZxy32DXODyL8N0aLpU11gv130+q1t7O5nCA/932uIGkyJD4p9IbJt6h9qEqoZZdWWYUP//QJfcWCWiTPqjiY0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR02MB8121.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199021)(66476007)(76116006)(91956017)(64756008)(66946007)(478600001)(110136005)(66556008)(54906003)(8936002)(8676002)(5660300002)(4326008)(66446008)(71200400001)(52536014)(41300700001)(7696005)(316002)(38100700002)(122000001)(6506007)(26005)(44832011)(83380400001)(186003)(86362001)(38070700005)(4744005)(9686003)(33656002)(2906002)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?/4B6fWkPiiLCXEvVHgJC5j/Vw2IV2Yu+L+D3spxHAeWnHsxfr/J/3Lgr?=
 =?Windows-1252?Q?ZZrIufGmdwNpcGiPZD9MHnwHyvmRH4YN4gvHx5ot0cjcr6QkF6LkPfkE?=
 =?Windows-1252?Q?gxewUWdWKtjEnYbiW496eGkrs2NBDd8Pgo5L22LoX0PEGVHmDAjLY51E?=
 =?Windows-1252?Q?PZA0BmtHvp+0WddkmoZx1iol84+wOs8WdcBrICTfzWwIwSMJaGn5UbU3?=
 =?Windows-1252?Q?F3LR+xUaGtS8VkGw9WAsY4Pj+XL9a8G7Z1dKtpRrOt76qmYtFtES1McZ?=
 =?Windows-1252?Q?MxgUvkOUSeEqZO3AWXGXKj8atQGR75RTm6dlErr7xMts9mwVMcFUNTod?=
 =?Windows-1252?Q?XasNfLBVMMN4mSuitp0XwBMQ3pk+1s7XRDYwIxr4qY5NyoxsM6f9Tq84?=
 =?Windows-1252?Q?u2N1Rp6IXGEWGYnNWQNPfluQehxD4pog3iqbaLfJpK8PXLbRq7JvbwcR?=
 =?Windows-1252?Q?HC2z8A41A43ctYDnaSH8zlnQ1uhPz0xy4e167MzwOTPQDsxQQmDcAxSA?=
 =?Windows-1252?Q?PGVmoUQxtyqjnY0HQJ9Ee2Nmb/eobYQGXlxmr6swdV/q35C9IHbMP0aV?=
 =?Windows-1252?Q?E0W4hc691DuB0Re0iH/q1jwB+BAcK3T7JAUBH9sXZuZ0ogc5DDs1D/LZ?=
 =?Windows-1252?Q?gfmhBYAzu1AzEly0eRRzPtCXrfPXrHn/AoZ70rO3vESfIjGyb70OYSsl?=
 =?Windows-1252?Q?EnpQsZITIazanj4dMexVv94H3kTBa3ScoRz1AqJiSYYaaIpXhiEiUU/I?=
 =?Windows-1252?Q?L2IafT4CNDaPlDGumbgkPtz2EzR73fSITiz1Vs5+WAg4Roy1MQj0EKTf?=
 =?Windows-1252?Q?PIjkXN5B7s0tEJsdPFUsxQtS8DICxu8Y6JTlCvMUjUHhFn2ZoAS/MmFa?=
 =?Windows-1252?Q?x9z1qeKuYIAHGqrLC8F2b8dHg6d8LAERsms42WYML+iH1jLmf3okbpgO?=
 =?Windows-1252?Q?nbPV4Euhjeope3VHNTADclnbV8+JC009iN5HlEMzzdzOD08NZoN6LBu8?=
 =?Windows-1252?Q?unEMRWW1S2sjS8+BLGgIA3W/avbq0g7jVDIMcX2qnXKUufMZr+N2apoP?=
 =?Windows-1252?Q?l+MCITs4gBuhCIvRnaAymErynziJz6f0UMNuBYK/JvfhaQQZdOzfpTZU?=
 =?Windows-1252?Q?KyKHJ4E+SO6Qkomk0+EclZDiBbFWZxsXufj+HI8MzsE4yTvkHyoQdOWp?=
 =?Windows-1252?Q?f46w7BJtBb2V0SOOY8XLVvm699EnRTVP1KZOsM+rFLxBiWufU61R+aUX?=
 =?Windows-1252?Q?gOUQ0GwqlyFyIkZU5JfACwBIygLEs/l86JL775aBInq7BZoIDszKX/aW?=
 =?Windows-1252?Q?knJXNlkNgkpSvdnvZKrhUtwUoVbAdnwyNVdTiLRkfmmw/OfaQpJzVd+q?=
 =?Windows-1252?Q?fNad2z1gSHtnu1VhkGQ+G7CqPrd3xzG+JZb2mt4Wl5hSo0bE76VfK0Ff?=
 =?Windows-1252?Q?9aZNwSTAQN5YqXixvK1dhTCR1S9lt4wcRk7WBLmhFeqdoXa06HL2OOvx?=
 =?Windows-1252?Q?rszuqLF3urUwF7VyAniCIirL+vX4jLFTKvE2autamCpP1JdRqIns0Fvx?=
 =?Windows-1252?Q?iy3Ny/QTUIbZK7NZKrWgJ+MH+xEAYGN5EOXFjOS+ltRfr/coDMTBX8vr?=
 =?Windows-1252?Q?npTOLmqNEDe2YNv/sM4hVXFR5+gfDDWfseU7zV+8PkyxHZcnlhfMbSIN?=
 =?Windows-1252?Q?fPuOd9msgkJfO7XPBZMmifKPVAK+Zc0hBgDmmowACTNTck1Qn/rj/w?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR02MB81215209B4EEBC6BCC4060D1935BADM8PR02MB8121namp_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8121.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671053ce-489c-4797-4fcf-08db6d79e90e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 08:24:17.1185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKIPiFT56Ql/6F3c4ZmtbIIaoLrCLveJp3MKZ8Y5MUxy4rGbg3fCGWK2jbYwLOAyUAdNLlLwVIipHOwyF0TxWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9488
X-Proofpoint-GUID: Rw5b0OAl67lhWfzaR0Zpi6fSiuwUpkE0
X-Proofpoint-ORIG-GUID: Rw5b0OAl67lhWfzaR0Zpi6fSiuwUpkE0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_05,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=simon.rowe@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--_000_DM8PR02MB81215209B4EEBC6BCC4060D1935BADM8PR02MB8121namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

On Thursday, 15 June 2023 Fiona Ebner wrote:

> which version/build of QEMU are you using? Can you correlate the issue
> with any block job or was the drive in use by the guest only?

I believe this has been seen on a range of releases so that includes QEMU 4=
.2 and 2.12. We do have custom patches but nothing in the SATA/AHCI code.

I=92m not familiar with the storage backend but in the RCA for one of the i=
ncidents the engineer identified an explicit write that hit the MBR. This s=
eems to suggest QEMU is mistakenly translating a normal guest write to sect=
or 0, probably following an earlier write failure.

Regards
Simon


--_000_DM8PR02MB81215209B4EEBC6BCC4060D1935BADM8PR02MB8121namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
	{margin:0cm;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-GB" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">On
</span><span style=3D"font-size:12.0pt;color:black">Thursday, 15 June 2023 =
Fiona Ebner wrote:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; which version/=
build of QEMU are you using? Can you correlate the issue<br>
&gt; with any block job or was the drive in use by the guest only?<br>
<br>
</span><span style=3D"font-size:11.0pt;mso-fareast-language:EN-US"><o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">I believe this has been seen on a range of releases so that include=
s QEMU 4.2 and 2.12. We do have custom patches but nothing in the SATA/AHCI=
 code.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">I=92m not familiar with the storage backend but in the RCA for one =
of the incidents the engineer identified an explicit write that hit the MBR=
. This seems to suggest QEMU is mistakenly
 translating a normal guest write to sector 0, probably following an earlie=
r write failure.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">Regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">Simon<o:p></o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM8PR02MB81215209B4EEBC6BCC4060D1935BADM8PR02MB8121namp_--

