Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F69377E672
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 18:33:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWJRY-0006ZJ-0t; Wed, 16 Aug 2023 12:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1592476a3a=lesikigor@meta.com>)
 id 1qWJRQ-0006Lr-V9
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 12:32:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1592476a3a=lesikigor@meta.com>)
 id 1qWJRM-0006el-ST
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 12:32:15 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37GGLQdD006040
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 09:32:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com;
 h=from : to : subject :
 date : message-id : content-type : mime-version; s=s2048-2021-q4;
 bh=Pq0R7CPzD12M8RQD/zlDoc6LSiJ/rOtP9CzaOwAtZBM=;
 b=PB0mJawLPb3gg3gsSFhWq5uia1C9Z2r5CmC6Iq8T0fGG9S+AqSHrJZ2qal28xAnFa0Nm
 TfgoeUa9sa/cOjR/TGpophxPx/1UkWN6Kr609NGBZfj61Mk3ccfY5Do+a+YisA+yDPoa
 Cplfe+vmq44caU8lk6wcveXHJ8wvYlApeovrrKVrOOG/nFoyvMBuoqBsqGMZs6g9UrX3
 Vigz2vtgUyGJJ1tcJ9cFi88Vx7opl7mMABhgOtmogkIInwdLmJ3/7D4ECRtNzIrAxu5F
 aO6YPN2y6qwRDK4P0m87R3lAhIUtSnrrLeJmsOzdEi62KDE3eedfOQ86HWsBFnuwx4an Ew== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3sgrkqm2d9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 09:32:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fW06PNTgE5vfjbaFl82a/YZv0856eJIUCYZRLDDy0exk23/yrJxGdFD08kAz0sWBK+F1ARv8gXIuAwkdrZvP/lVEBHRCHSghhLz8NFzkNrQdxQNi0DLunQrr0KQ95xOgrh3+WW0JgRXo1jUfYE+uvtigkKbfLNHqSA1DW8fgAhtt6NhJVPFKYZwCyaEjbTsDkOIsZH6Cmy5HYgpjVVTRajs1AbCNP3LMM93kkhs42QRm6/I54hn5WBi2HNPQdIhCCCY8uJbtSIal+onOX6Y0NDHrJ74SY2MT8NG7hhaFbkH3YVJ7/kNDzh/Vvx3XZhZil5FxW9cVq8iwkVP8e2KsKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pq0R7CPzD12M8RQD/zlDoc6LSiJ/rOtP9CzaOwAtZBM=;
 b=VNQf2qReYYCc2L+uRRfxuKbqt1ZkXRSftPPqqVEJSpiYBziKbjf8evGIVqqenNFRLbRnyVgaNT6iTkMe3KyUboMgo893uZH7ajCDPh0BSQGZynosSRXEXzzqL69ve0NL4A8uO+DJslosgoZP6Ny5qV8jRD32umwmBk976DGD/aKIxbzQqLYgn7IC/oYkMBAEe2BlhpFlCpKvMr8BBQQ0mh3MIrG8fQi9hVXiNgMpr/GQAYFBeQZbtbQMWok4+QKYRfdezp+FBqi2IHp9XB99Rufv8Znc/iMU0uKdlykUWRogfGmfbbfwuMsMIOLmOnd/wAzEpJE99zpW1pEyWZUU1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN7PR15MB6086.namprd15.prod.outlook.com (2603:10b6:806:2ea::20)
 by BLAPR15MB4019.namprd15.prod.outlook.com (2603:10b6:208:274::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 16:31:58 +0000
Received: from SN7PR15MB6086.namprd15.prod.outlook.com
 ([fe80::939f:246:ceed:c9a]) by SN7PR15MB6086.namprd15.prod.outlook.com
 ([fe80::939f:246:ceed:c9a%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 16:31:58 +0000
From: Igor Lesik <lesikigor@meta.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: How to synchronize CPUs on MMIO read?
Thread-Topic: How to synchronize CPUs on MMIO read?
Thread-Index: AdnQXsnj84C5jNrrSiuSAbjYdBVvgA==
Date: Wed, 16 Aug 2023 16:31:58 +0000
Message-ID: <SN7PR15MB6086D1B0ECEE5ADBD07F8847C315A@SN7PR15MB6086.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB6086:EE_|BLAPR15MB4019:EE_
x-ms-office365-filtering-correlation-id: 9ae5d3fb-d75a-47c5-7484-08db9e764fa7
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yoMwTyoHpNJ0sduStOvRDMIiSMM0KJR741yLgHihhVHUonhPBD6QyTFNm5WRbw4J00hEPcNLoiSiCiG89/eQl2HeITRNRFXPH+wqnOZghU+wNLt1LpsJgWfPl0CsARedM2BWZe7yUYk58AK3BVMVkTpQuoC4xsahVGi//mf9F1Qsa1hkDgd77q0wfVgbzhxQIpxbqX6LrleNeCqevNNgVr1wKo57cvaCly/5+HY+qEIemEDul6jxfKpMgknsIqxOhKBVke0OKhiGznaxitaVzM5uC9eiR0kAe10b18QTAmiwIZXEQgSlG+44ILFzo8Oo8wVLL9bRLTe8Xav1Qld8r9a10zh041UZ1zKT0cVTV745ITVwKAqpQHqGDyYJh73epfbSWL6rbohUzyItpzvQMf+qBr11kbJtZQi7edj5Z/9N0DQekFcZ21Ff3Clv2BS1hSRZEwjHe7P37TOrQ34hn/AjaqyUu6VfENqHHg7yBIFtbGRtHJsnYZqeLeQccF66YFZ1SS2rddlVcslxUzQZTN5jwSXbmIdYihERZrYBUunUa3LpTCxRN2bTSKof5ieoJ+UxHFn17SSUCT5bS1Yfo5fu/mpP9M0IbS5c7xlAjQaDSB6rsKWN33VWhaIYTtGU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR15MB6086.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199024)(186009)(1800799009)(33656002)(55016003)(316002)(6916009)(66446008)(66476007)(66556008)(64756008)(76116006)(5660300002)(66946007)(2906002)(6506007)(7696005)(4744005)(9686003)(71200400001)(478600001)(122000001)(38100700002)(38070700005)(86362001)(8936002)(8676002)(41300700001)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6TjO+f4l9DrJzKD/2jbYzV/iEYgtOYnvcAuMTEwYv2yhvaT5qEiWm8wVGw0d?=
 =?us-ascii?Q?8vg+bWg5P9rkl2HWphJRbg6gOpH+JTJUaIQM30XXLq58U2AAA4iZDwBgTxJo?=
 =?us-ascii?Q?jjWYP/8nd3qjjYw5yJyKNYLQElfvsJLnDsvjmlJQZRt5AjapwukFyuJw9/Uh?=
 =?us-ascii?Q?/wdWtf87cUJkrcp9MOwaYBuNsF0GuX2LY+GFYiXNeyRy9F2a3GlMjhk5GpaT?=
 =?us-ascii?Q?p56DpFkHLpfOEIU5NZxEwI8ItQJiIHlJEcFNHzU6ePkHGrVayK9EmRWtC3p9?=
 =?us-ascii?Q?4nXLHK6uCVw0w6p9k26XmUxDYTBtZ2Tr75cRSaBS3kO8rtDZgLoF50FiUzBX?=
 =?us-ascii?Q?zl0F+PnNc92JqlzgRrfcrPd9h4QoYrZ2pCqfntag37SDEKbW53WRaUc3JH4e?=
 =?us-ascii?Q?vcDzZnMIJ8bIPia56nGsyB9YYOxtMQ54I7t1aouJ8HmfqSa1emBfGx9w1pKl?=
 =?us-ascii?Q?pA44NOxQP/wwsk9SxYg/d1xaE45TYxM1f09trPGEFry+lTAKTyumTVNTbpd1?=
 =?us-ascii?Q?zEhYJLlqZzxUB4gqdqb8jw26b0AMH0YTGA2BrJIXuza7ye0pXz2L4mWFeAzL?=
 =?us-ascii?Q?jJL+N9cwfWxestl5BULQTwGjbDBpPTYQPfNHHkRFWFojtCIs+eWrD4OvYOK7?=
 =?us-ascii?Q?qujCqMfzGUeLrggdPzkmPF8gMqOu8TYhtrG3t1Z56g1kaBdTiNiBf3uhYOPq?=
 =?us-ascii?Q?Knl071aMbJuAunkl0wn4+6GX3cNDhZmrR/hloujIgLGvtZcUY1UuZ53OsIPK?=
 =?us-ascii?Q?c39tdn9wOmdjb+tfh4IXf2MNbbGjBHlBPlHY+KfGtosKECarClZsHH3A8TCV?=
 =?us-ascii?Q?0GX769k1Mr3VDrUMb94t0zTw6ea+yhxK5fj5PNvQfk2fuwukK+jliQgZLKtt?=
 =?us-ascii?Q?cSYScVV7x7sNB1NSISedJPm9cBXYubhQnayKvw2JLp7q2y9vqYW7gjnslXKh?=
 =?us-ascii?Q?hJ1T9fYgwWLHOAVersA2/B2ujz4eDNOmCOCuhvj5JethV6TI2x2SV0qTNLrW?=
 =?us-ascii?Q?Wcf+U012N1cG+9nrp3rwQijHKycGgNR6QVrQ3IsR0hwscptxP9p4oSW3ehQY?=
 =?us-ascii?Q?rrBh+RDTMiCYBuqJ5xp7Xub5W74a3d0uO4oO/FZxEVNxjnYf/J/OkTrab1a9?=
 =?us-ascii?Q?D/O4zUhp9ioxxEaO9lcAPsr2NQlzVdV+a3JoFixLoafSu8Y7Ac5lcznTccok?=
 =?us-ascii?Q?rXvGato2AQLCgyEI5S4qkhrS0ePGs9ur1mRwXzDTdsglN4LFREizAizrLrAp?=
 =?us-ascii?Q?oYH7ffYHZP/bYbsuLtEtRwa08dD6OQh/kk9/oHOay/6gQuxyKs1veQbnkWE4?=
 =?us-ascii?Q?LWcCU8y2RQj9Lm7DCuCtccx0fZp7EnR1sISeSEGQ64k588fW8sR7UIeQu+g7?=
 =?us-ascii?Q?Xn5JomrhtekSaLDjXZhAdjDFpGf2jF6L563+uykfX+ot2YprX+Ub4r2R0B1Y?=
 =?us-ascii?Q?VKfvVNXBLUk0u53qG75kem4i1vTfAcB3PBOLm6OIcJNrGh2h7Y7DTNRM4hJp?=
 =?us-ascii?Q?q3oFTwzeETdBj4dtzRDBu1MJpFZ2S9L2g4ztyiH2sdkpuftx84GSVRld7kuQ?=
 =?us-ascii?Q?sZJ2pBpMB7wqp3vIko6AIdXiIs/cOQ8jdi/l8OEib8Z21T9Tu7UFOQ4HLVDH?=
 =?us-ascii?Q?wa/WajysN3eBva55mhCsgxo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SN7PR15MB6086D1B0ECEE5ADBD07F8847C315ASN7PR15MB6086namp_"
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB6086.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae5d3fb-d75a-47c5-7484-08db9e764fa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 16:31:58.2424 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mDO/Xo9s+ucWaXI3iOhPwg0zr5nGJA3P4sRIr5e7Maaox5MqG4vECBbDefhRGmlaM33iRYB6j1cg8or5KQixLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB4019
X-Proofpoint-GUID: 9jGPg9z0p782zxObbye8B7gpg57Iiln6
X-Proofpoint-ORIG-GUID: 9jGPg9z0p782zxObbye8B7gpg57Iiln6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_16,2023-08-15_02,2023-05-22_02
Received-SPF: pass client-ip=67.231.145.42;
 envelope-from=prvs=1592476a3a=lesikigor@meta.com;
 helo=mx0a-00082601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_SN7PR15MB6086D1B0ECEE5ADBD07F8847C315ASN7PR15MB6086namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi.
I need to model some custom HW that synchronizes CPUs when they read MMIO r=
egister N: MMIO read does not return until another CPU writes to MMIO regis=
ter M. I modeled this behavior with a) on MMIO read of N, save CPU into a l=
ist of waiting CPUs and put it asleep with cpu_interrupt(current_cpu, CPU_I=
NTERRUPT_HALT) and b) on MMIO write to M, wake all waiting CPUs with cpu->h=
alted =3D 0; qemu_cpu_kick(cpu). It seems to work fine. However, this HW ha=
s a twist: MMIO read of N returns a value that was written by MMIO write to=
 M. Can anyone please advise how this could be done?

Thanks!
Igor

--_000_SN7PR15MB6086D1B0ECEE5ADBD07F8847C315ASN7PR15MB6086namp_
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
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"MsoNormal">Hi.<o:p></o:p></p>
<p class=3D"MsoNormal">I need to model some custom HW that synchronizes CPU=
s when they read MMIO register N: MMIO read does not return until another C=
PU writes to MMIO register M. I modeled this behavior with a) on MMIO read =
of N, save CPU into a list of waiting
 CPUs and put it asleep with cpu_interrupt(current_cpu, CPU_INTERRUPT_HALT)=
 and b) on MMIO write to M, wake all waiting CPUs with cpu-&gt;halted =3D 0=
; qemu_cpu_kick(cpu). It seems to work fine. However, this HW has a twist: =
MMIO read of N returns a value that was
 written by MMIO write to M. Can anyone please advise how this could be don=
e?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks!<o:p></o:p></p>
<p class=3D"MsoNormal">Igor<o:p></o:p></p>
</div>
</body>
</html>

--_000_SN7PR15MB6086D1B0ECEE5ADBD07F8847C315ASN7PR15MB6086namp_--

