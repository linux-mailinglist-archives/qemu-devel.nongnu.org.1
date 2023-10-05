Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A347B9C9F
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 12:50:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoLvZ-0002z7-JU; Thu, 05 Oct 2023 06:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1qoLvX-0002yT-1w; Thu, 05 Oct 2023 06:49:55 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1qoLvU-0002zd-Ny; Thu, 05 Oct 2023 06:49:54 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3950x2C7018356; Thu, 5 Oct 2023 03:49:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:mime-version; s=proofpoint20171006; bh=UmvnHkj5nLF
 ackzRtdyf9zE6TDsSg4LMaIs2qk2aoig=; b=QtH1JXqFW+U2daMchrTKA1wMty6
 JwSR4zsgeYaYt/AgQcTneDKsDbdgz5cX1CHTVBROund00wcTcdPPCsTnMVbvik2o
 tmFNXgijY5pMrDf4VN8NzxxITIQ1uQcwkYQsd0J+5Qt0K9VoNtByclJgKorbbgxW
 l7fghiqZXW2hjxMC0mS62oSlUujaiDij9b4fSGcTsA9sehT44BDDv4XAoxlZyiop
 8BGao5Yw+tR5/ve0Adu26aLVXIcVxsMtzcK8NneIJ8ri1PbjvpOOuGGR9Lfu+DYk
 zMky8i1CD3PUr98X7BOE7YOgVxfUCfKvI/YuALAIRRuUcQkuq7kIX2i3T5Q==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tek0cu5yu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 03:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4b7REtmZDAHOziDs1tzdfMtgWpH8loCDfy27uJSf8uGFTVGrIthNLwnJ9BxhcVuVfD/lt/MbeO8hBw8QXhi+mF68IcxPaKtKpwjglz5cDn2a7yvohlZnOfHkxnCAq0PW5lsNLceU3KnRhBiVRcgtn0pffgrwOA2g7OsZZEovHIV63BxGANGBcUasBt6QnAtc/q8tY2Pv/0V38gLkB5tieypxjZTBNzFIDOXK0TvPhshGTPFfVQjWRl+XiOetlnjtUvNdSY/hTgug/+XIzqIadClQmEwN9Ekk2eOsEPlrTB43J9UwabGMLDSPFdIFKeyx3NqJxHKV3nRXFniGumCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmvnHkj5nLFackzRtdyf9zE6TDsSg4LMaIs2qk2aoig=;
 b=HeEfrHbpTRLUYgHCqcw31Lnz7tpSc69Ax26hzChIWxcEZfSvtunDHxB/2N1NYfvVxdfQbIFSqncK7SZvijS4EtDZRP2milxaBpryEL+WsZvXsndx2eRJsdY06L6ELTeDL1bzIezfFY7FJmAshgakLgG8Sg8MDMNsQ86pp42OQY6zKoRSxnR99E2mlu1a+CNwEJWF2B3xHrNz8AyZCbj5nlHdWSzPnHcgln4HjQ7GGaolkgwjHUIevITrAuSbP/6Uiu54mgeafJGMgXoPLsecRHxp7l/cbt/CjDnWV/EAXVBq4NJpjQ7nIRg3Lhr/o6viJEU69A7ZNy5TnIf166PzdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmvnHkj5nLFackzRtdyf9zE6TDsSg4LMaIs2qk2aoig=;
 b=ZM5NZ/o5SmDzizkPsqTw1IdxqN50JZeUNjjM0Xjn5fPml+zsINAQPCnVUc+4v6jf4FACWq4/Eo0mRKCPDC1XvQn8+v4siAAY400vW7iNRx0yNY8tcCnWLzi29zmSiBLd/2LbNUhritFYcEowgpBW7XXD/LIyDuZlTtyzA11DHkxlVY9Mgocxqh+zv+H5swCYeVWMKwDftLw9Efwak0W35YadhIMAnlw61TNi0g9KrPfK9wkutAqsN12F03UZY0QQRZd27W4Zm/y/zfxKo3wI5om4pFDGwxQeYzJnEPew2FQqBBDZ+bY59+bEknejb3tH1qGood04uok5MxJgg7CoFA==
Received: from DM8PR02MB8121.namprd02.prod.outlook.com (2603:10b6:8:1a::12) by
 DM6PR02MB6843.namprd02.prod.outlook.com (2603:10b6:5:21e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Thu, 5 Oct 2023 10:49:44 +0000
Received: from DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::b986:4843:ab24:54cd]) by DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::b986:4843:ab24:54cd%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 10:49:44 +0000
From: Simon Rowe <simon.rowe@nutanix.com>
To: Fiona Ebner <f.ebner@proxmox.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jsnow@redhat.com" <jsnow@redhat.com>, "thuth@redhat.com"
 <thuth@redhat.com>, "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "srowe@mose.org.uk"
 <srowe@mose.org.uk>, "mike.maslenkin@gmail.com" <mike.maslenkin@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "t.lamprecht@proxmox.com"
 <t.lamprecht@proxmox.com>,
 "a.lauterer@proxmox.com" <a.lauterer@proxmox.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "kwolf@redhat.com"
 <kwolf@redhat.com>
Subject: Re: [PATCH v2 1/2] hw/ide: reset: cancel async DMA operation before
 resetting state
Thread-Topic: [PATCH v2 1/2] hw/ide: reset: cancel async DMA operation before
 resetting state
Thread-Index: AQHZ4MOj+7qWyCkiLk+9tPq0cKYkYrA7MTLZ
Date: Thu, 5 Oct 2023 10:49:44 +0000
Message-ID: <DM8PR02MB8121F2AFF6FB7A5A054252AF93CAA@DM8PR02MB8121.namprd02.prod.outlook.com>
References: <20230906130922.142845-1-f.ebner@proxmox.com>
In-Reply-To: <20230906130922.142845-1-f.ebner@proxmox.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8121:EE_|DM6PR02MB6843:EE_
x-ms-office365-filtering-correlation-id: 783d8e9f-6a4c-4e9f-38e9-08dbc590c927
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vLh0UEzGVA0LY0rNSulKObulf8esqOEkyKpI8xUOh256n7PkVZ+uUhBdg90ioGlWpHLaHFwuAVdwMXjCt5BW2W14vQ0z542oGNwO0V2jhUqPeSut6oJlSU2JxVHTm37R8X4xrlzCVSNp5OxdJFiaWs4fCAk5weO41blZY00H0UU23UcJ4hSI7Ri7x+rnJMbT2wW02F1vPEahJvqvnzp6U8CAuWGN5IIM03lzFiUq2jYwtOR1sXyuWC2StG4HrDJEqLR+RXBe+G4LOBAl5ji3GHNqSPhlf3knZ43uH8lhQ2W3jk0XV+ROzA4FnTMMS0uux+/Y/It35GEWC+fddqN5NQd0Wc4H+5x+qn2kVIRn7nrqDqC2oeJ+yYzFnx1R4lv+MNhv/ZvWAtlAGJ1L9zj81wSBpAKOClkIkZWaYaQ2aIG+0x91psPiCn+6GwyaDLZrICbYwapGcFZ53vrj9tEuxoux0+WBCgPtlx7HbFOaKaLYKKmuVe9G4pq96ioV3Sha3PTMRQRSJiRI3W2hdDHJ2sbbzfQ0TgIVatg12CFkC/ngvAOAr1zxIcV4ZtdDy7GhV4M5ZBKYOFksq6biFQEN2Km2xLDPrdvLfFkSKsy3UpdC9Nr+vgg33mWYnf3G/HkQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR02MB8121.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(41300700001)(110136005)(7696005)(6506007)(316002)(66446008)(76116006)(66946007)(66556008)(66476007)(9686003)(64756008)(54906003)(44832011)(8676002)(4326008)(71200400001)(26005)(5660300002)(8936002)(478600001)(52536014)(7416002)(4744005)(2906002)(122000001)(38070700005)(55016003)(38100700002)(86362001)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f/ZwuPVn1fb8YRCZRdLzOHuBJiZMfDD/2g9jNevu4EzjW4Qk6WMQbFm+glPH?=
 =?us-ascii?Q?S+lxTKrvyuiKhsXzd5tVFSqubjW+wLqyZoTw0jMWLQiBjGuq+D7X6G3aVXjC?=
 =?us-ascii?Q?HsxNMVZqlzcWo25LapEQLVrURYKw0Rc6xxSrpRHjeYhUl465heuOIp0p2hnt?=
 =?us-ascii?Q?g1InmH2vO890fP86vs/Cnfq5Km/YOMOyfVeCDQUeR9R26zWk6QxutfflLADv?=
 =?us-ascii?Q?Ey/LCX1Fry3kuma3Y9zYWy7/mVq8A/3N8+P5lmyEUORH+zj4kM25LkDqzCcf?=
 =?us-ascii?Q?LA4DE1cLqnOgxbiJx0L2/wpD6uxJ3nLbK9T3Vg9QRT2miEgvimIxatwCBhsB?=
 =?us-ascii?Q?0zG+U7hAh7Vzl9zW2QLyRVOlhYh7A3tLczXlrPJJAwtY+8jc0wIp0ZjFZR+1?=
 =?us-ascii?Q?KBSgBeeuWeqzTbdpuxA3COLdOTX8vV67IRgoamHb76nMYgFrR3sLrODUyL0p?=
 =?us-ascii?Q?XGXxqEfpAQrjIUVS6GCRblNoPNd436C/izKZjjRE9+IYXAMRT3oXld3X1Gbj?=
 =?us-ascii?Q?4bATbIOCj77kGr4Lw+thUdeJ7E49CYB6Ji9be+SExdR6+MS95QTVa1bxGgJ6?=
 =?us-ascii?Q?dBDE7QP5hA4/nMv9ztDfo2wKzzFG5vtX8n/2SzSrJlHXhw1z165ZdF2BFbSY?=
 =?us-ascii?Q?+a8RRA8ZdQGadvN19rKVXrt5FCO/K43qrazjmSeBpI7YdR2lqxmgfzT63mFT?=
 =?us-ascii?Q?O43RaBh2mmFcDpfgmXMgd0oUCsrUXLlZOvZFYjQIZxZRAC/0utFtd0j8+Bsn?=
 =?us-ascii?Q?qPz/wi/Dz2fwVDPBRfOnhjiy5S6uQOWxc/alrH59AixsGiF1Kh4Tha5iyYNB?=
 =?us-ascii?Q?2hyctKdfmSC8OIVH/IniNn2SZjDVIGFRh0SRcIsyGFJJl+gt+N0q1WLFi5Gu?=
 =?us-ascii?Q?RCPUQmF1pHKUCOLHBKFF3GC1kqaFaXphXSN3jkpe4xtF3n4EIZT+Gzckjycs?=
 =?us-ascii?Q?EaYUG5BYH/1F9DNwv8LiPfN1FXVb+CDZmUyn+Ac7Q67/qw+Wo9724yYOFmbj?=
 =?us-ascii?Q?8cGnv7FA7El307lFzxCDxyftPFzMLR7r1jARqKo3tRaRHm1+pN92CswWLnvH?=
 =?us-ascii?Q?GWTcJLu3nH5fn5IwqRYgjkA9fhCxazDGOH6BxrZXMxYd2TJee+D4AclBVPYZ?=
 =?us-ascii?Q?U56vbe+2ZnQtsjWo6zTnNLcLY5ymUAnrDgbY4xH8DGxdbYw8Vs+y5e9DiiDy?=
 =?us-ascii?Q?S5MwObvlYzsl7vfutcjaOhwX8F2BX2GuGh3p3AYwbe3gEtFUjS0Duxln3/cB?=
 =?us-ascii?Q?foUvGEGf3CAhd/9YP/2GywXaZRoH++qIrarZ0zGhrIBZl807YKjaBvEl1zhZ?=
 =?us-ascii?Q?6gbTDysLZ7JBGNd6u2eg9LMfNH6pE9ysbrUcPROMQRKG9eujo9n5RBmAnq27?=
 =?us-ascii?Q?CCEjWdQjAYAhlICAsj/1GOMODqkXh2xugLL9jiChp2Iuhn1S+2mkGENwFDKx?=
 =?us-ascii?Q?XvjlqYaIwf6zmNYSD7rHlXEhvzELPn2i3vnJOPBQKkSEAH0UrOnhZqvq8jrk?=
 =?us-ascii?Q?Yq+3ZNUCbf0p6IloKixzr7qezIl91Rp0g5E1WNkkRz/YeF6GhSr0pKscmDif?=
 =?us-ascii?Q?YfFLTGM792M0H2tDZqHr5KpvxPZqPkvte+OhiSHMDJi1QAJszSaiLCxHywnv?=
 =?us-ascii?Q?9Q=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR02MB8121F2AFF6FB7A5A054252AF93CAADM8PR02MB8121namp_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8121.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783d8e9f-6a4c-4e9f-38e9-08dbc590c927
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 10:49:44.3568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: enZ/H7LlnGNkOYSRZ8uAnzq2uaY0jZ+InNIYVyexl5ET/BbVjaHqYSjKKGel2m2dCuP/2dszTGJ/1aLyfwMmGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6843
X-Proofpoint-ORIG-GUID: YhnC8zvsX-nPlJb8i9X6VUspX8G5XDuP
X-Proofpoint-GUID: YhnC8zvsX-nPlJb8i9X6VUspX8G5XDuP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_08,2023-10-05_01,2023-05-22_02
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

--_000_DM8PR02MB8121F2AFF6FB7A5A054252AF93CAADM8PR02MB8121namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Wednesday, 6 September 2023 Fiona Ebner <f.ebner@proxmox.com> wrote:

> If there is a pending DMA operation during ide_bus_reset(), the fact
> that the IDEState is already reset before the operation is canceled
> can be problematic. In particular, ide_dma_cb() might be called and
> then use the reset IDEState which contains the signature after the
> reset. When used to construct the IO operation this leads to
> ide_get_sector() returning 0 and nsector being 1. This is particularly
> bad, because a write command will thus destroy the first sector which
> often contains a partition table or similar.

Tested-by: simon.rowe@nutanix.com


--_000_DM8PR02MB8121F2AFF6FB7A5A054252AF93CAADM8PR02MB8121namp_
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
<body lang=3D"EN-GB" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">On
</span><span style=3D"font-size:12.0pt;color:black">Wednesday, 6 September =
2023 Fiona Ebner &lt;f.ebner@proxmox.com&gt; wrote:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; If there is a =
pending DMA operation during ide_bus_reset(), the fact<br>
&gt; that the IDEState is already reset before the operation is canceled<br=
>
&gt; can be problematic. In particular, ide_dma_cb() might be called and<br=
>
&gt; then use the reset IDEState which contains the signature after the<br>
&gt; reset. When used to construct the IO operation this leads to<br>
&gt; ide_get_sector() returning 0 and nsector being 1. This is particularly=
<br>
&gt; bad, because a write command will thus destroy the first sector which<=
br>
&gt; often contains a partition table or similar.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Tested-by: simon.ro=
we@nutanix.com</span><span style=3D"font-size:11.0pt;mso-fareast-language:E=
N-US"><o:p></o:p></span></p>
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

--_000_DM8PR02MB8121F2AFF6FB7A5A054252AF93CAADM8PR02MB8121namp_--

