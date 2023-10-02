Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C3F7B4EB3
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 11:10:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEvA-00014J-SK; Mon, 02 Oct 2023 05:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1qnEv7-000137-Uu; Mon, 02 Oct 2023 05:08:53 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1qnEv5-0005hW-LK; Mon, 02 Oct 2023 05:08:53 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 391NHXZV002374; Mon, 2 Oct 2023 02:08:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:mime-version; s=proofpoint20171006; bh=Dkgg2E9H/yf
 LXljWrXH/4yCXKuek9ZfoUHoAXghpjhc=; b=fV45zz/OMfaqPlStoGgHdtMNMFT
 wx4oMNzpTvi9DHkKApAOHu6S4wVI23DKIG+XmxboetQ+iqUmQLfFD9o1JZwGxz+q
 ebGRDxCAOTstpvymb1mJrDxB/qgz+ASycbfGSA2BjP4PEOZgGD4GSEtJdPbE0GwH
 PfRPJbzE8Jz+0caY/0fGjX/b+jq9U7Dnw1Obs6yiRGz2nEg5kq8Q/iTQlAmXJZRr
 tWY9efRzoiqSvVmh0USQ89nX95od9sxAq/S/uXITn5qcoraxQNmoVzwAUxViqO0x
 JQONYW/tw4W8I5+NR05X+7So+X/TbP3qS4zx1lE6z3sbkDjy1t6WoBTopcQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tehsfb0ny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Oct 2023 02:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObWoLAFQZeZcSicYBsLGcqWHJc6ppIVhXPheS0cbXNAAj99JrQBaa6xVK0aTe1gZDqBosEozhdB2iLloX4eTANV2sdu28DG7gO9TdnqaFduLNWw4Q1WvpRRRbjJgD34NDvFIsB2TGWexk9twrYpKaRB0Zr2dVrREQ87MxG+SF8MFI6OHpyAhUiZZmTEBXvBxUW0mfyj/uYwVQlPBOEzoMlSUTmk9EK/2zjJSmMsLqLlZCReo83U3tV6t22DhEnZSD6UXz0BLE6PZIlabFRabJLl9oX8/TabE7P+k+oYIzWjVNDOYbpCSYjyLAbghbcm36jmtC2JTMAZPVoeiC7nawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dkgg2E9H/yfLXljWrXH/4yCXKuek9ZfoUHoAXghpjhc=;
 b=Y1b3jEpPtg8NXCaxjauZV2YHemh0d8/XST7p4BNhEOOHDp+Ur1Seh5t4OTWiM6GYBJhqLIFSdhWK9zCiA1LZqkVl5at5KHr/kgbrXKIHpTLWNEhIZRjOQ6KcsHAXLhqQ3+oIO6MI0trWkrcloWcYIrCATIDr2d6yctY+1aNlcgd9Lg1s5Eis78DPPdpQCvC1xBsFvaBQ2PunTrHU61tf9Ft0tef9ee9LulfOkdrGLLB+vtCUqM+ttz/gal1fZ4Rrv2NwC0TxCuNC5OALKorTQR/wKJPbVgESlOti1LWRJrDFo7pu0zX8OWX9eDfHjNGBbCuc3aqkpmfPGZNjrKVmbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dkgg2E9H/yfLXljWrXH/4yCXKuek9ZfoUHoAXghpjhc=;
 b=mGZIxi7KPRVcZBH0zCMyjwMJTlntgDYPHSYgMPwhwkhA2MjVIJxim7tA+2+U2br/cQL3POgCRYolA4PJYHpMVZhyB5F0hDhYRt1X/U3qkBHWi74DGIcENPHA37+hPy0hrDXWD4zxvCHzuRy5DfYoIOkVvmTOi5uPdXAz7KbqU20IPkE2fw3g8UUNTwLaU6I/2zgAIHbyJW91sRoNW+o+sbO3+rIXOZVuXjDDj40dWbogidYBkMtJQYo0cmE42f8f3ou46BxWBuwmVFbyzyO9TklxkqH6ZxDzN1B7QgF2RrF+AZiNhWYCJq3fiak31RKUDrjQbEDIY1sjPKznCMk4OA==
Received: from DM8PR02MB8121.namprd02.prod.outlook.com (2603:10b6:8:1a::12) by
 DM6PR02MB6988.namprd02.prod.outlook.com (2603:10b6:5:22c::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.30; Mon, 2 Oct 2023 09:08:45 +0000
Received: from DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::b986:4843:ab24:54cd]) by DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::b986:4843:ab24:54cd%7]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 09:08:45 +0000
From: Simon Rowe <simon.rowe@nutanix.com>
To: Fiona Ebner <f.ebner@proxmox.com>, John Snow <jsnow@redhat.com>
CC: Niklas Cassel <niklas.cassel@wdc.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Qemu-block <qemu-block@nongnu.org>, Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [PATCH 1/1] hw/ide/core: terminate in-flight DMA on IDE bus reset
Thread-Topic: [PATCH 1/1] hw/ide/core: terminate in-flight DMA on IDE bus reset
Thread-Index: AQHZ7KWy58usN3As2U6v1H3wKmYsk7Ar+paAgAC9g4CAAH6xgIAC7D6AgAYgulQ=
Date: Mon, 2 Oct 2023 09:08:44 +0000
Message-ID: <DM8PR02MB81217871CAB18CCBB04938F893C5A@DM8PR02MB8121.namprd02.prod.outlook.com>
References: <20230921160712.99521-1-simon.rowe@nutanix.com>
 <20230921160712.99521-2-simon.rowe@nutanix.com>
 <CAFn=p-YL_hmnrFY9hhuMgMkV4hL3dojMMWUdG9=DBGYuxi_TUw@mail.gmail.com>
 <7658d927-1d05-8f2d-9739-d1db692bee72@proxmox.com>
 <CAFn=p-YkEJajV_YuOsK4KPL6T1erEhdkameN-XEEXrwY+XZZ6g@mail.gmail.com>
 <4a1a5f8a-6797-104b-4a91-b5fa24607fb4@proxmox.com>
In-Reply-To: <4a1a5f8a-6797-104b-4a91-b5fa24607fb4@proxmox.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8121:EE_|DM6PR02MB6988:EE_
x-ms-office365-filtering-correlation-id: 72b32320-5ea6-4206-a298-08dbc3272e3e
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 23UoDNha9rIxIy5+LzAk3/cBnAXznHQI3l5wcCq70yyc5eP7eS8Dqw4WkD4L7GS/FKgfZcdFCuHzjEHWR+XqUx/hvYbjIk1Q3eYUMisvZW6yoUiq7tAcQtDXZ2bQl1KCxJN3Hi3laNRQb3Ksd5Kcq6gDwHUYj/Pl7edLjtwxFb0q/MDIGl7LgDdl2ucH+LlVuc0LQfxVE10YUodpFgfevonAFyCaXu1r3UGDE7VUZ3/5jNObd1OYDv/JdsqnG8Ww5drvP9Ev2CntIjM7tiGeeAW7sEzzDK2RS4VL1w/LsZeAcqkpYSGbsb1jMsaLOQpvwWmyN0yHLxFaiMUAHqvTQbhtTb1c4BuuIN57xMt1MVTqzrQul7byveTx0FByr4K2SsMtm8FPJjE7o1QIaofnVT2pHWUYzb5YPlFA7kl29sJEK944kmT/VYZDAabp7HpUTm7RMcRTBZvPGpPQXDi+VuBA+sfsnzVWTF1OsihfS1KzHNE3/e2HrprVnxjiLRlijTs0z1vMX0Q/KlwnmvGS7Xn3FDba1+JzoigkRLlV2NuFirif27vRCegjemtt257/ftLIohrwAlPQj6TJ2iAf1uGgBm4l+JNuG1c6YnwUCXsSN7KmPoKrzfGQlhCj1r7T
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR02MB8121.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(376002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(7696005)(6506007)(9686003)(2906002)(83380400001)(33656002)(122000001)(86362001)(38070700005)(38100700002)(55016003)(26005)(107886003)(54906003)(52536014)(4326008)(8676002)(8936002)(44832011)(478600001)(5660300002)(316002)(66556008)(66476007)(76116006)(41300700001)(66946007)(110136005)(66446008)(64756008)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vMR9pbQ6BehS+4sE91xbPaoJUrBfvlO8+sj9Hl6AmmyyAecfDZ6BcEDxvkWW?=
 =?us-ascii?Q?2vjshqrxG7RzPfVnywkwsuCPHqZcKXaenD0R+U/VHqJAAmPpLyLCuZSAjBSS?=
 =?us-ascii?Q?Z+320DAbS8MrMKYhpxgEE3n+K9FzockXYECeLQacFE0fUUV2MWqlyw5BYEnG?=
 =?us-ascii?Q?M9HCVCS++/EOrtEg1AG8zUvOyHzzF7xCePa2uWeRIdkqD9LUmYQfKxROgP+m?=
 =?us-ascii?Q?Pm+CbhIStAqeJEmj+GZWB9bWbmJazLh1FwHReikgmcTJ5tlI9e4Uxm5pCHck?=
 =?us-ascii?Q?96Up29wWdn+Oyi0h6ercT+JXuPG60G9oqVWLwx6jpj1RxzTx8H6710gevdib?=
 =?us-ascii?Q?cpvlbn70llkgWpAUrS7VfU5s4hmfVQVA7Ffl7y/yIgYfTTRrJcx5brYBfPnQ?=
 =?us-ascii?Q?xNQEDYxfPtl2FZCj25jSAMUN+O5Wvd6sHmlCVZ18aRfCX9n1mN4pkEkSBb84?=
 =?us-ascii?Q?n+E0ktGX2rDdOkaKz5K+IDy4Zb4TIXHqYfbRewm/fl+h8OsfRTZ06KQgTEaS?=
 =?us-ascii?Q?kTHjxU9MmYpNNqmC2yKTXUTWfXmzvqHsExNQkpBaqYGwoPrB2kPUOwA1qXXv?=
 =?us-ascii?Q?LZO5dxUQz4rsojNSoFhUuW1J2b6JGbSpufUlgIwQm0YCqrrTQ5kx2ygD1JmE?=
 =?us-ascii?Q?+OkZCHsltAK47e411cJnj0vE5YmdQkXYNNWwpw8brQCmTfhK5CQ4+nl5Nrq+?=
 =?us-ascii?Q?yVSoPHFnoPaHe9N497BphYfbGrWUj8aj9oYyCaYpKr3BGlQS+x1m9eEE5SiT?=
 =?us-ascii?Q?RfgWssTyUfMjaUnKgXwZ33T/iCk4SC0sR8HK6+ovpJNhELDDQJ/FaxhIjAH+?=
 =?us-ascii?Q?LWncYO1YhEkV7d5JILlrQ+foR1DKp2w7KUHK15o8arFyCpmGY02r4pz8Ryez?=
 =?us-ascii?Q?1J1yaWEtabe0WUUVSw/MZaFVfnzIaU4ySnMEXiatfczdFCUXmHH0SJEv0P8T?=
 =?us-ascii?Q?PrLe1y13WHG9AmBeQR9w5DwPPzljYlnl1wE2+bZpW77lVmXueJEknHYQNVyM?=
 =?us-ascii?Q?bshjT6v/wYZ8D0SMiRiHmiGT15EsxSkdp5LPkpWoaJjIUkT61+OZE0Ivdc18?=
 =?us-ascii?Q?cEAQfEdPpS3lzsGCYbcPTBn1K+t2gLErMYxvbMm0ztwKetJ8WXnj5IYGJKFN?=
 =?us-ascii?Q?fF+B7cuG3QABRqV7YdLQxQgLfPbLavamDpU9+UlgjEbFyZ7Y8YBxALaWWeML?=
 =?us-ascii?Q?TL6c016RVQUQMUc/RchBqtX8+MH4c7TelZz2DzmbGHKhCNS+lmh7Z60CcaU2?=
 =?us-ascii?Q?hJpMmuJVLW7Il7f0MIW/1F08Bw59NGUUVSIKh5k7cuXnes7OIRR5uTohST70?=
 =?us-ascii?Q?tMKCMAHD3R295g575BLqOC56rDGIvry0T+dueXa2BG3g+8LpEemzFmHqisQp?=
 =?us-ascii?Q?DjPKpUNGCTXxI5w+2TlmWq65Hhri6ZS+pHLx1MYjjtFSawliJ/ORFVj3xEwq?=
 =?us-ascii?Q?uLn+B3JaaMICPiOSMGul9n+P63V1QxqKhdf18mxJwRlJVLQqOgumi/waj7oM?=
 =?us-ascii?Q?bvkWE4alPipggVUP6Bbj/Ol+sd4W6Xcdc+6P3HPScE3w4hsB5weocmDD4Z6B?=
 =?us-ascii?Q?g4f/NqCyXEOkwXa8hXei8KX5BpfY1GE3NFvuZjHJNLd5TafUScCWKctxrlrb?=
 =?us-ascii?Q?SA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR02MB81217871CAB18CCBB04938F893C5ADM8PR02MB8121namp_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8121.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b32320-5ea6-4206-a298-08dbc3272e3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 09:08:44.9544 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WlFSrziEnALnU1HsGm58fLpAMkLw80ywBlcALs2G6RKdg5Bom3Am7KCSiw4KvRbxI4Y9sqKTs9/0qAEpQd+7vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6988
X-Proofpoint-GUID: dJfpE__zsA7D4sVaXb8GZy5mwfFs7ZGe
X-Proofpoint-ORIG-GUID: dJfpE__zsA7D4sVaXb8GZy5mwfFs7ZGe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_03,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=simon.rowe@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--_000_DM8PR02MB81217871CAB18CCBB04938F893C5ADM8PR02MB8121namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Thursday, 28 September 2023 Fiona Ebner <f.ebner@proxmox.com> wrote:

> AFAICT, yes, because the DMA callback is invoked before resetting the
> state now. But not 100% sure if it can't be triggered in some other way,
> maybe Simon knows more? I don't have a reproducer for the CVE either,
> but the second patch after the one linked above adds a qtest for the
> reset scenario.

I initially tested an identical change and, yes, it did seem to address the=
 issue. I preferred my final solution because it felt wrong for the DMA to =
continue after the point the VM is expecting the controller to be reset. I =
felt it was best to leave the ordering as is (because there are multiple ot=
her controllers that use ide_bus_reset()) and terminate the DMA transaction=
 using state that indicates a reset is being performed.

I have a test setup that I use to reproduce this (that was mentioned in the=
 original CVE disclosure). My patch ran for 24+ hours successfully. I can t=
est any other proposed fix.

Regards
Simon

--_000_DM8PR02MB81217871CAB18CCBB04938F893C5ADM8PR02MB8121namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
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
</span><span style=3D"font-size:12.0pt;color:black">Thursday, 28 September =
2023 Fiona Ebner &lt;f.ebner@proxmox.com&gt;</span><span style=3D"font-size=
:12.0pt"> wrote:</span><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; AFAICT, yes, b=
ecause the DMA callback is invoked before resetting the<br>
&gt; state now. But not 100% sure if it can't be triggered in some other wa=
y,<br>
&gt; maybe Simon knows more? I don't have a reproducer for the CVE either,<=
br>
&gt; but the second patch after the one linked above adds a qtest for the<b=
r>
&gt; reset scenario.</span><span style=3D"font-size:11.0pt;mso-fareast-lang=
uage:EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">I initially tested an identical change and, yes, it did seem to add=
ress the issue. I preferred my final solution because it felt wrong for the=
 DMA to continue after the point the
 VM is expecting the controller to be reset. I felt it was best to leave th=
e ordering as is (because there are multiple other controllers that use ide=
_bus_reset()) and terminate the DMA transaction using state that indicates =
a reset is being performed.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">I have a test setup that I use to reproduce this (that was mentione=
d in the original CVE disclosure). My patch ran for 24+ hours successfully.=
 I can test any other proposed fix.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">Regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">Simon<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_DM8PR02MB81217871CAB18CCBB04938F893C5ADM8PR02MB8121namp_--

