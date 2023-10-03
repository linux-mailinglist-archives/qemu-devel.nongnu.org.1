Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3DC7B6953
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:47:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnenC-0003YU-Lj; Tue, 03 Oct 2023 08:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1qnen7-0003XC-4k; Tue, 03 Oct 2023 08:46:22 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1qnen4-0003MO-Bz; Tue, 03 Oct 2023 08:46:20 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 393A3Rho015590; Tue, 3 Oct 2023 05:46:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:mime-version; s=proofpoint20171006; bh=u3GM6JRUTO1
 qLkHyiE/0PbaXNP2y+devvSOJXLUsLEo=; b=Rk4Ov3mWlEWAcAS4ZEkA9SEIIY0
 09pePMvqoonGqvDhd93L2ie0MaIWtU515u8b6xSpDzMRlgMcEK51qFKWQdci6+JP
 WVgUk08tGz0UfpJAxb6Y4+Y6GD5GRJv6xjmsmSp+td66eu9ZQdkSkPSTnyIB4xsz
 ct2EeLliJfL16zQR7BzCsNGaA+G6GzYpmOo+ELREm15QdMy7EjyafGJsL7+iC+dl
 pmodizYMfWe+ZvUu5J8WPgh81FZwpo/60eGarGyrq9gw/qRQbSmC1yIMbu8k7Yj3
 +AiLy0oe5hpywYQX98TR21UcSozOgl7XSQVpCvZ5F6mt6AxFpbPqZ+GtfhA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3teh76wvr2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 05:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAblPzfIdmj2bObgEEF7H9RRvFrdjD9zfesB2rqBy2B5Pdr1kr5xS+k3FcmoZbuU3IIuW7lkenMhu7IC6K3QVAedgS92+IY8w5Ph65ngm8ZCrADWLyuIJvsl1UGvdLcyyzGXxRnkLvnZbz22IoARzm33V9WIzX2fMJXhI3ABy5KsZg90wn6tfFf3cPSlovwtbf+l4kJks8XpjYwrJXm3VNDfdKOgl3zivG4xbEisz9jffe0IhHqWVn8d2t9b0TJY2/iVqny53YGYXRGvIz2sz/hGsmll9faXrfVxJik2ODu/wjEeZKY4lj6PKmVfY198oQXm+zg0BLaoDdzAdBQJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3GM6JRUTO1qLkHyiE/0PbaXNP2y+devvSOJXLUsLEo=;
 b=R601R3Gzjm/BvvtHuDjOfkGS+wbf4qfYnYVWtHod6orCuqCPoai/E8ePL7x1/IFG7KMX7CrEdJk+Y00327q5hLfiG2ppRBiwuW2o/01ktfAjdvTx/MzwEafK55ALFuDfU75FngEdjCORb0rNhou23smzAM/rL0AEpAZlJbSRuAqynJeXdxjSxr+Got+AeN3LE6UrtkJRhs3McPgZPJ0AKGaNR1x+Qc6ldLs/r/y9scX/9lBSXSxPSA4xRa0sOkUD/mU0ou85k6IfJ5hFM2gLu+BJjAkosa0O8q6zOHAScLYTJCVHvaRKagmkKD79KUT5oAxbqscE6yEZImP8QNrNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3GM6JRUTO1qLkHyiE/0PbaXNP2y+devvSOJXLUsLEo=;
 b=R1DIfCSXnt2njTzeheyUIq22JmdrJF2/pSn+aqkuG5CTxEzlIFUbG8hAJuT4q3L7ZcYayT+FssxkUyTFGHBsQtDful+vDTiEd+BeUXb+9kRUObbWPuL97phc4s5mKNJUvYRQ2QLaxOsRHOZUJoyWbrEqsyvxi78UmaqGc6nZYx4o5DeauXs1Ucdm+/GZjIOyj6F1xQ05uSuk3DoQagvoEFdUSSH5im73D1KuXhVJ4yN/BvRUdtU6MnzKbqwDWYL68r2HA8QelrdxTH/CIm5/wCwUJYahCoQarxfRQdCAPRuiF93osWuZn7pJIMHyTfZQmtKpMVXGzEcg2Edav49RDw==
Received: from DM8PR02MB8121.namprd02.prod.outlook.com (2603:10b6:8:1a::12) by
 BY5PR02MB6486.namprd02.prod.outlook.com (2603:10b6:a03:1d6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.27; Tue, 3 Oct 2023 12:46:10 +0000
Received: from DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::b986:4843:ab24:54cd]) by DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::b986:4843:ab24:54cd%7]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 12:46:10 +0000
From: Simon Rowe <simon.rowe@nutanix.com>
To: John Snow <jsnow@redhat.com>
CC: Fiona Ebner <f.ebner@proxmox.com>, Niklas Cassel <niklas.cassel@wdc.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [PATCH 1/1] hw/ide/core: terminate in-flight DMA on IDE bus reset
Thread-Topic: [PATCH 1/1] hw/ide/core: terminate in-flight DMA on IDE bus reset
Thread-Index: AQHZ7KWy58usN3As2U6v1H3wKmYsk7Ar+paAgAC9g4CAAH6xgIAC7D6AgAYgulSAAOsWgIAA4eY4
Date: Tue, 3 Oct 2023 12:46:10 +0000
Message-ID: <DM8PR02MB812179DB35E1F35904EF5D1693C4A@DM8PR02MB8121.namprd02.prod.outlook.com>
References: <20230921160712.99521-1-simon.rowe@nutanix.com>
 <20230921160712.99521-2-simon.rowe@nutanix.com>
 <CAFn=p-YL_hmnrFY9hhuMgMkV4hL3dojMMWUdG9=DBGYuxi_TUw@mail.gmail.com>
 <7658d927-1d05-8f2d-9739-d1db692bee72@proxmox.com>
 <CAFn=p-YkEJajV_YuOsK4KPL6T1erEhdkameN-XEEXrwY+XZZ6g@mail.gmail.com>
 <4a1a5f8a-6797-104b-4a91-b5fa24607fb4@proxmox.com>
 <DM8PR02MB81217871CAB18CCBB04938F893C5A@DM8PR02MB8121.namprd02.prod.outlook.com>
 <CAFn=p-a7UsM=dmJjmLpKmd1WYgNnfxQR1AsOQtCR64uZwVYZeA@mail.gmail.com>
In-Reply-To: <CAFn=p-a7UsM=dmJjmLpKmd1WYgNnfxQR1AsOQtCR64uZwVYZeA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8121:EE_|BY5PR02MB6486:EE_
x-ms-office365-filtering-correlation-id: 7e3f2212-531f-4c73-e4d0-08dbc40eb893
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JMrI6tXDUa6OVba7Hav/tPKRwxOoRfDhlqIPkL0Ph1oy2uqXMG/9rV4C5P0yA4TdaTJAeiAdMCB2Z1JnnfE+hzCx47uLcKCahYEYFm3OfQ6kCzTfkGD1eKCzyRQSSoGxooiWNtoU8wVBSeCbiQMMrENyLDE3ao2aPE2yweyjWRa96nsbWN+0aQz6VOs/Zja7RX5pz9W136LPUmx8VkWy29w92mwJw1v0nG7gDaEuyff2s+sQca6yTvWPrO7/0zdkOBPwthxvNAQyypP3EsQAun9ASh0rRmlvsV3Ovoe7JffyzNfwkp8fwLlJmHr9QcbCftqTwC2xTtx+GbIjQMLIZ4owryx8zAiyrPeLSxYTh+JLxICMVC6E7injcCHmdENACVkBXEEsUKzVZxQOwk5R9npQhHcYckqmZ8gIsci9arN3AVAb4h5E5wFfF9Tj/8bdetnpwLKOV4iUofJwxA1fv1RWAT2vGHPoo1Sd5C3atdBO0qER/dm/FbG56xqmF+zHY1zhKYNIxjyntcJXxRL7FCN+Ds1FU4jJNajjDNV+PUCI7OJqY2fFjNIF2l8/uTYp9TSFWtYs5uCZSpHx5pyj0v5gqmZIDAJkiUffpEv4/d16l3jDFS3OeVa1fGFBJoV6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR02MB8121.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39850400004)(366004)(136003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(86362001)(33656002)(9686003)(71200400001)(38100700002)(38070700005)(6506007)(7696005)(478600001)(122000001)(66556008)(66446008)(64756008)(54906003)(316002)(66946007)(66476007)(6916009)(76116006)(41300700001)(107886003)(26005)(8936002)(8676002)(4326008)(52536014)(44832011)(5660300002)(83380400001)(55016003)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?hIN4MrOSlUCOPYaZlTRe1bYw7NsABiXCWkzBPZrFQtpoW3fr6B5cXhj0?=
 =?Windows-1252?Q?6yOEmBBVYVcgTPwSDx09S+znPu0Jw/QqSIrVhO2mka8TZ7cSEJqGuuGC?=
 =?Windows-1252?Q?8HKYRYGcXz9sKdvMCGzf73UlkYP8XQJB6Sl1qmKXRASsjg2dKgFWE3U/?=
 =?Windows-1252?Q?KEt6CInSrpv3XmFnLzkSwXNfA+0RnMsMW+jYZQMXbaLfpi5Nx2Rcs2I5?=
 =?Windows-1252?Q?leyEcz2QppleImPsDo6vWdbIH52Y/M0KwxcfpP6ZhE0zpbvYf3cHqBI0?=
 =?Windows-1252?Q?ZajCingWXvlUD32z3DWJoAcjaPNzBAo1EUNBXh9RpmyMi9sp0p/IfpOl?=
 =?Windows-1252?Q?RihSFi1UV1EW6FQX53BwQwwBe9DoDmKj5yhVtGBoudB2HvSbCj5qGJwO?=
 =?Windows-1252?Q?mV2rI5kKL2/23f+zT7czreMJ9qFro/RSQ5KGhSfX2NZZSAxKl7G5yt6j?=
 =?Windows-1252?Q?QznhMxdy8kESXJETEGD+Pa30EUWV9YucprhBJsWozK7Y9Q1cv7X9cNiD?=
 =?Windows-1252?Q?0UrvgLusZ3Chy7O8epFlZIup9PAKtgk8h2UuZd2Z3JDMY8mT3djuq4GT?=
 =?Windows-1252?Q?XJIrrjNuQms+C44dpKpW2m7ojWbVLSqzszvho0yzYzFtmbeGEDJ6wJWs?=
 =?Windows-1252?Q?zqvmpz4gJ1fCdki3j7qBgOGqZcRuZab3J9AdKbny/TCHwDS1qK+6Q9Af?=
 =?Windows-1252?Q?UiCyZhFpRVsHqKA+8Uf/Y70KOIUbQlxrEJKBZhQoUrAdqm1qVANdrDAQ?=
 =?Windows-1252?Q?wr2LvFtZxI2A8BVZ1ocWhbJVFFyrLcHktHC0pSVIGT5DKQF9L+SUozGb?=
 =?Windows-1252?Q?bZbWf3NSDa2L4ZJk0s02mAwUoFT/n413fe218KqomSd412d+rxVRyyre?=
 =?Windows-1252?Q?9RVdMvF8tpdYwtPSGT9d5wc4OEkvRxxI9EETOgc7KNhUUCX7T3EYjfNw?=
 =?Windows-1252?Q?uIPVYxryF2/Sv+t6+uxm5w+mynjuqs6D/R+czC6SOzYJSKE4614V5nxf?=
 =?Windows-1252?Q?fs0okfZOikYrtie0IsHI0faK9uU951LKBY9JLVT5uirtU5H9PiENOxTQ?=
 =?Windows-1252?Q?+2SM6Eh4vw+XpIpI/2wqqllEHRdBexcaaQXkFhXtG1kOGYieQnOHMvc0?=
 =?Windows-1252?Q?pDpZhn6qHhtfPaTmKuE708vFNsBoMC6uaTwK4a9CoRqWb5nnBTxIliZ0?=
 =?Windows-1252?Q?Q8Gos9WkHtec5MFCPpa9My7AGiVsvQaXqoy1+PUzh9kzKprZ5ZolLuNS?=
 =?Windows-1252?Q?CkEZsFzgInKp13VIPy73hI5+5XKghrnYnsAir/X/NPZKQtb0QJENgT+0?=
 =?Windows-1252?Q?eHkebACDJ4sEkI9ml4RmYrGMKU+PSFCCCbMyP8uHHp9OKY3s/jh3cLuE?=
 =?Windows-1252?Q?NHZqbfATNGq2RSU2XWJg6GCEzAJvMq3bQovOT1gA61VRUhVz8l+b3f70?=
 =?Windows-1252?Q?mPUvpDw52cvwMVT+QLbdoS5FtcbbWir4Zdsa//XP3S9B59C+fMprlOj1?=
 =?Windows-1252?Q?stFe+cCmPYcUjzjDZKvTWNuAFw9s9YKVz23xk4Uq5uuqURfzmKMMUCD6?=
 =?Windows-1252?Q?fWzgVHqgXlNTsj1Or/OHRiqfp68X/KPF0RioxMab122msdXtFcaGGpkM?=
 =?Windows-1252?Q?+p4wMbx4fBUN98f3ZeTMR7/icK1wa9x4PAVemgg9W9oQVS8YAlErdk9+?=
 =?Windows-1252?Q?7wysLp+k6VnpbqLQdiMiZAWlclUwtK8DJ8aAnmuXRBaztpocSREENQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR02MB812179DB35E1F35904EF5D1693C4ADM8PR02MB8121namp_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8121.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3f2212-531f-4c73-e4d0-08dbc40eb893
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 12:46:10.8340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQNQwjlRZYdFbmLxbYhP7A9zuVUerxo29off+w45kvDLpZArBFAQYouihLckuRoVLrFqKJG9Mki2xeZX5cWiyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6486
X-Proofpoint-ORIG-GUID: kmEKwWHYR4ssvjftQf4oHxU9ZtAqlECR
X-Proofpoint-GUID: kmEKwWHYR4ssvjftQf4oHxU9ZtAqlECR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_08,2023-10-02_01,2023-05-22_02
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

--_000_DM8PR02MB812179DB35E1F35904EF5D1693C4ADM8PR02MB8121namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

On Monday, 2 October 2023 John Snow <jsnow@redhat.com> wrote:

> Which reset pathway are you testing that causes the problem?

The test centres on a VM-initiated bus reset because a DMA write has stalle=
d (I deliberately discard the iSCSI response).

> I'm not fully clear on why checking for DRQ is legitimate here.

It was the best condition I could find, there=92s probably something better=
. DRQ_STAT seems to be set by ide_sector_start_dma() and cleared when the t=
ransfer ends.

It would be far simpler if s->nsector was trustworthy, but it=92s massaged =
by ide_set_signature() immediately after being zeroed.

> Does this new condition fire before or after the registers have been rese=
t as part
> of the reset ...?

After, the flow is as follows:
- DMA transfer started
- Guest triggers AHCI reset
- ahci_reset_port() calls ide_bus_reset() calls ide_reset()
- ide_reset() clears state including LBA48 support etc
- ide_bus_reset() attempts to cancel pending async DMA operation
- bdrv_aio_cancel() sends async cancel request then polls for response
- Completion of DMA request arrives
- ide_dma_cb() calculates sector number by calling ide_get_sector()
- Because of the controller state after reset sector number is 0
- Next part of transfer is done

> I trust you there's a problem, but I don't know the specifics of it
> just yet to understand your proposed fix. (I have a nagging fear that
> it might trigger in more circumstances than we want it to, but I need
> more info to audit that.)

Hopefully the above clarifies things. I=92ve done my best to make the fix v=
ery targeted but this is a complex interaction in subsystems I have little =
knowledge of.

> I'm also concerned about -- depending on WHEN this conditional will
> fire -- the effects of processing the end-of-transfer block on a newly
> reset (or about-to-be reset) device.

I understand, do you think there=92s a better approach?

Regards
Simon

--_000_DM8PR02MB812179DB35E1F35904EF5D1693C4ADM8PR02MB8121namp_
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
@font-face
	{font-family:"Helvetica Neue";
	panose-1:2 0 5 3 0 0 0 2 0 4;}
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
</span><span style=3D"font-size:12.0pt;color:black">Monday, 2 October 2023 =
John Snow &lt;jsnow@redhat.com&gt; wrote:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; Which reset pa=
thway are you testing that causes the problem?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">The test centres on=
 a VM-initiated bus reset because a DMA write has stalled (I deliberately d=
iscard the iSCSI response).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; I'm not fully =
clear on why checking for DRQ is legitimate here.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">It was the best con=
dition I could find, there=92s probably something better. DRQ_STAT seems to=
 be set by ide_sector_start_dma() and cleared when the transfer ends.<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">It would be far sim=
pler if s-&gt;nsector was trustworthy, but it=92s massaged by ide_set_signa=
ture() immediately after being zeroed.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; Does this new =
condition fire before or after the registers have been reset as part<br>
&gt; of the reset ...?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">After, the flow is as follows:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">- DMA transfer started<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">- Guest triggers AHCI reset<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">- ahci_reset_port() calls ide_bus_reset() calls ide_reset()<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">- ide_reset() clears state including LBA48 support etc<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">- ide_bus_reset() attempts to cancel pending async DMA operation<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">- bdrv_aio_cancel() sends async cancel request then polls for respo=
nse<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">- Completion of DMA request arrives<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">- ide_dma_cb() calculates sector number by calling ide_get_sector()=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">- Because of the controller state after reset sector number is 0<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">- Next part of transfer is done<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; I trust you th=
ere's a problem, but I don't know the specifics of it<br>
&gt; just yet to understand your proposed fix. (I have a nagging fear that<=
br>
&gt; it might trigger in more circumstances than we want it to, but I need<=
br>
&gt; more info to audit that.)</span><span style=3D"font-size:11.0pt;mso-fa=
reast-language:EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">Hopefully the above clarifies things. I=92ve done my best to make t=
he fix very targeted but this is a complex interaction in subsystems I have=
 little knowledge of.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; I'm also conce=
rned about -- depending on WHEN this conditional will<br>
&gt; fire -- the effects of processing the end-of-transfer block on a newly=
<br>
&gt; reset (or about-to-be reset) device.</span><span style=3D"font-size:11=
.0pt;mso-fareast-language:EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">I understand, do you think there=92s a better approach?<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">Regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">Simon<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_DM8PR02MB812179DB35E1F35904EF5D1693C4ADM8PR02MB8121namp_--

