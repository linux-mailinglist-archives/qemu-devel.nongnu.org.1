Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC3978F254
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 20:14:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbmAV-0003yA-TQ; Thu, 31 Aug 2023 14:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=260703f6f9=lesikigor@meta.com>)
 id 1qbmAT-0003y2-Ef
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 14:13:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=260703f6f9=lesikigor@meta.com>)
 id 1qbmAK-0003aZ-Hn
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 14:13:21 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37VBhIKV023276
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 11:13:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com;
 h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=00skvvGcPUyAMY2jt40xwblukZ+/YluagUmNV2gy/dI=;
 b=Vh7d8yzU8DZUQ71JBvmD14O0HvgEyQGZ3oWCCilpNEmnDoxKWEV145n1e+DvnP1NjYBM
 unw7Lr/cXLUr2lmgW+p8yfaCBCxP2Y1aYG7D5IgGt4DN+7HcsVj9PokZ2gAwCc775HDO
 y5MIJaXz+HyukJLwM9AjrBqB+7dP43KDPEYr2fwqpcz0EXUIcC+ii5fcrQ+OlZ/z5SUP
 UPs1e7aZOf2eTwuX0MPIZzHfAC7nk2nvEDC60O0iCRm3pOxuKECjWsxDZnONwDHJv5TB
 mi3XEsu6Qqo03oXr1Awpah125w4UauVWZSoc2Vc7NzFhYg5VveHQhKrw1HUy7WEsv8pp Tg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3stnej59sf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 11:13:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gK4tC39WSAUmzLMBcajXK4htbFfFfGyypk0DZN5DPFMP0BIHwopz97ik8z69dhJFNAmwrKRkhcfvqtJ8/5JjfJ+xTj+q0RD32xzXgSWDdBtPuVo2aS+nUEWj+oVILmkDj7jM/Zul7/KFv3rA7Q9ziVF6aHlcuMCHcybrZ76Bv9iugX5n/JXt9j/yyXCDEEBf8FeugJPm8POdvypLycB1PA33LFOw72BkDsMaxtwM8kpFbbNSeIa+ST+a0PqXz4GUcOLoyjpUa8cJDeuuaOVCMOdGzjAiMvdcCVDUvmdMN54ujSpfMlUwR6LjsK4XOApOEKjFDJmF7q7AcWT6sYC1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00skvvGcPUyAMY2jt40xwblukZ+/YluagUmNV2gy/dI=;
 b=P5RgpR8hwwhVsk4J2NFkpBoZjVU0Z3oh/+wT10CpxS1VajCCCaZHfMzb7v0fAj9VcZuaXlWY+/eb5vUY4DtwJ0qvjS689v0dvQEWu1a4Sgbbs37qewKq7Q35NCt6wBklSyqmaBQjS6BRI8b0NLSFtkKOglNglLbiUyq8nZPn8Th52rmylqsjcR4gBPDtFKxqLhBlRTq6YB1Gf6MS2i43S6NzmqaNR0pEkczSJ5X5g7Rt6cp/MrMboqHKbJ8AlzWCpycYyuFamSVSnAEdHzai2Sgyp7aNq8ynhcJZL1rs6VLq0s3Xlufn2yfe3E0PiYq4hhY+BRDVssKjT47XF7/InA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN7PR15MB6086.namprd15.prod.outlook.com (2603:10b6:806:2ea::20)
 by MW3PR15MB3993.namprd15.prod.outlook.com (2603:10b6:303:4e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 18:13:06 +0000
Received: from SN7PR15MB6086.namprd15.prod.outlook.com
 ([fe80::6221:ea7c:469b:ab63]) by SN7PR15MB6086.namprd15.prod.outlook.com
 ([fe80::6221:ea7c:469b:ab63%4]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 18:13:06 +0000
From: Igor Lesik <lesikigor@meta.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: MTTCG vCPU time
Thread-Topic: MTTCG vCPU time
Thread-Index: AdncNh0OJjh6MDYBQHWGXA5ZMV5KHg==
Date: Thu, 31 Aug 2023 18:13:06 +0000
Message-ID: <SN7PR15MB6086AB6A17CB812E70F9255BC3E5A@SN7PR15MB6086.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB6086:EE_|MW3PR15MB3993:EE_
x-ms-office365-filtering-correlation-id: b651c518-ed8a-4a4f-e6db-08dbaa4dec8c
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yCotcEso3NNQSxsdvrOzKgDwabvDSrxFeIiCL8eIJ/OFuXgr/oB95jiIGjgheIb9zYUOtYNut7NTYhXR09yHuIu1xHZ2spz77Pv9odaJf7OrZf4mUFCGcsSMrNebFTtwQqw2v+rHdlpjxp8VHQeMH6j95AqY4DayJvN9rgiFGkhzGVUNsnApBD7YQfZE0wNbV4bWyr+RuJ7ObhumuTlGYrG/lt7Y5PIw4aLkZUwDZ1OGrwLFmq1bnhrG5mXEGOJPDfeF9GqQCuWLe27aAX2vAwEGim5WjJFMZbo86ztNLN9rVToyuFvMTGiZNaNk60TahAmayulNFgEgKSzPnSP0Ty07+XMgGIxiOkdwQJ0oPh6vxmwWM5rtGGfiObmBbsaVBcYJPqGgH28QsWvLbnlyis1GNbIh0SMIO9pkWARued591vybjQAAu/1C1YJgs6JuUyPSy0tIMshwNubPEtmVDsNJhrSahSpirwqiTRgUiM/ivkHSvgPYJSULg4faQxvqdbwaZ/RZxLtAcHiZeWbJRyt9cHoaOaVJkNu3b4YiWIhvOcYIQ5Ps+VW39k7qxz7HeGkXGJZhYM37d5/f7PJ4FTywWYf94Dc+7UQPjhCbExyjgINiXFzTqJ/jA7LPwnSf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR15MB6086.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(7696005)(9686003)(6506007)(71200400001)(33656002)(55016003)(122000001)(38070700005)(38100700002)(86362001)(3480700007)(2906002)(4744005)(478600001)(76116006)(7116003)(52536014)(8676002)(66946007)(8936002)(66446008)(5660300002)(66556008)(41300700001)(64756008)(6916009)(66476007)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YL/e0TRvCiDHQypKhK1+h1V6PfvXU3HPKlD3noTNnUWcQJ6n32Pmimxi3I3p?=
 =?us-ascii?Q?CQq8JOBz9TbTMV69V98fNRHuQCuO8QTcBLZk22T8YyM7D2ChJMP8wLyKRxHx?=
 =?us-ascii?Q?fzhDFdy3EdoxhaT+UemfiOMYWdd9DAcn56ZJq+s0PrbXJdhaf9IR5T78DLP5?=
 =?us-ascii?Q?zijj0Op9COCrQYWmxnVVBs8B+W5pBZgdGkqVUqvo/SvPA6lZFpnSV+uf1crb?=
 =?us-ascii?Q?YmTdCljPMp74Ia3Jcgv1AU8EGQj1//DFYhwWqKNtRRIu7QFxclhKwIOvqhJ8?=
 =?us-ascii?Q?XrSzEUEFFHjllNPxtWP53BO2HSKlGXuiKsipUgNXi3r9SRl9DlmB9Rq2VRlG?=
 =?us-ascii?Q?BOPgT8uCVTBRo8HukQq+kg9N4eL6tH3a54gNKxDFcBo+4yCKR7bgMfPG1oHn?=
 =?us-ascii?Q?/N06+7ywDpjYOBPElRgY5Hpt6kuUzTKjJFp6zi6nldj6Tphwt1QHVTS9uSG4?=
 =?us-ascii?Q?SvOxksKlAj05Bh5UwTNTSACKcTL1SyvIWBpcFAvn5PwEgsUSdbUDiaSUcf8x?=
 =?us-ascii?Q?QKYNqENRAoZ8D5AcwwMT4Fhdp6ZfvxHUysRl5aVB2IMzv6lwKrUyI8wqx8Sb?=
 =?us-ascii?Q?UDB2V+Nv+M9w7SZg/nP+Xx1OOFH4hMHZJYpmIeLF1MTNDjznOh82ADruetst?=
 =?us-ascii?Q?1tS4Ku1cnxd9XfMgSjMNvFoeoiPVvaeDdYWBUbhzeLnLxAYQkfyuqA4t0Ivp?=
 =?us-ascii?Q?Ae/JJyuXtaFrZy1ttw6XKWhwaOUZ/+7M1gPz9ixgseW9LdscN0uN7kiyB1gT?=
 =?us-ascii?Q?k05Tgfsf+cLpzmgd08nRX2tfTW/EjO+IUR3eF4PiYJBlEOnhwImv8vOapnHo?=
 =?us-ascii?Q?GW/vUhOsAY75sJuIyHBWCZoMNqtnbLP3TjnhQcdkB7w+CSY3UBqrmS1XyqdB?=
 =?us-ascii?Q?0ZMax4VMH3kVM8qdf0jsnmYUFbDf86MRbTB7HOMBVAku6xw221cEtB3sTFX3?=
 =?us-ascii?Q?9BV8pGUQCxFYNIJp2eHz/Ehdhb5M0L9pm5fuXCgh3NJP7N4Kq2CIJrmKmGLq?=
 =?us-ascii?Q?fLkreYfCTc+5LrZpkWrD7zu7x3tacS31jmcDvyYW7pdg0enxAtfEZJmQP2+z?=
 =?us-ascii?Q?QqG/ciODZVe/BEzBOCMjDolreXPIy1+FmqJOmokc2UdcElLfQNAVm7pjSAnT?=
 =?us-ascii?Q?tM8/+B6IbA65Gut1nez/LprvUKOQ4CgHBXOHFLZizG2y/ok2dgzRsaTeOC/l?=
 =?us-ascii?Q?mCfHzp1UzcuQdf8IsNZecbMEQzFFLQ00MIS56xuXEhiwqumSoSKYjE+evHqs?=
 =?us-ascii?Q?oZpvpWRzju56pfIDC+XkjDBgsCOaZLkxD8HbliaSBEjpEf1+IVtzDoKAEL2Q?=
 =?us-ascii?Q?XhrdlSPFtY4lqCePlIKqg/PyjBWAiTTWGIM3ijVjI04PUJDjJPcM6+o5jJVr?=
 =?us-ascii?Q?x+5+ivFmCi61q9EzL+GviUdcBwlEZB34vz5cHROsQJshb8PneCGYGU6nvXHp?=
 =?us-ascii?Q?VOY9iiN33knWLlmhkx/QGHBAouVf5zfDjVIf9SE3Guiwe01c+Lsvy3qz3kbW?=
 =?us-ascii?Q?xi956Li7EVLTRUHCHhKzL0RAq7ujTjZ69A5jWQ1kyDW5p70n/218HnDJSrvV?=
 =?us-ascii?Q?5GvzJU9FNn34c/KcrKC7NZ+74ZFDaDGYhz8kJELa5CBfPeTfKJ8Y6f8/oC1J?=
 =?us-ascii?Q?xQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB6086.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b651c518-ed8a-4a4f-e6db-08dbaa4dec8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 18:13:06.0502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K2VcNMwilbUc12FwhDswgxsXdm41Qw+ysRQoxAnNM9KYnwCzbJ7RHzM3msAsudv0qMxGE8VZR/0Vf1Y7NPDhbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3993
X-Proofpoint-ORIG-GUID: OZd20FwM82tcCImo3XsdBopPTtXRA_4H
X-Proofpoint-GUID: OZd20FwM82tcCImo3XsdBopPTtXRA_4H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_15,2023-08-31_01,2023-05-22_02
Received-SPF: pass client-ip=67.231.145.42;
 envelope-from=prvs=260703f6f9=lesikigor@meta.com;
 helo=mx0a-00082601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi.

I am looking for some advice. I model custom HW with 100+ CPUs.
The CPUs are working on different parts of one big workload and sometimes h=
ave common SW synchronizations points,
however, in between those synch points vCPUs seem to run with very differen=
t pace depending on how underlying OS
schedules the threads (which presents some problems for the analysis).

Thus, my questions:

1. Is there a straightforward way to obtain vCPU "active" time? That is a t=
ime when vCPU thread was scheduled by underlying OS to run,
when it was executing instructions or waiting for something.
In other words, something that would reflect vCPU "time" better than number=
 of executed instructions.

2. Bonus. Assuming I know vCPU "active" time, are there any ways to control=
 pace of vCPUs to at least some extent?
I do not need it to be precise, I just want to avoid situations when one vC=
PU ran near zero time, and another vCPU already executed millions of instru=
ctions.

Thank you in advance.
-Igor

