Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BB3765564
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 15:55:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP0xI-00073P-K5; Thu, 27 Jul 2023 09:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1qP0x3-00072X-C4; Thu, 27 Jul 2023 09:22:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1qP0wx-0002E6-Es; Thu, 27 Jul 2023 09:22:43 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36QNd9Pu030939; Thu, 27 Jul 2023 06:22:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:mime-version; s=proofpoint20171006; bh=THCVqngQS7f
 CxWmVNitAdH/ZVKRK0ReCCHVBfBnnirw=; b=YOxBDha2k2quwW5w0sYlBTNQtHf
 CD8IKyVRVpsVme5dLG8hoFOq95vpECyz5Oyvqae95l4G+7obmILwd8k0ns1XNGch
 +6crVdpch36HwE8AtlfrNLwtsHfQLVYqkQ/+YK1oHwMk7ojBVR7zrwWqF/U9qBBE
 MvaeUW7Y7qfi7hSIUyrnFQmsPxj/sQQE0WwfGVjA4UfDNV0pcugews9z6pTTvE/j
 FmtMds42i35VAF2ipU9enlJ+3MpyYymgOkgdlVDAo1pk8/+nn+z0R7zNX7yMdFXA
 Wook8JA3IxAjh9pSxZpkCz1QXF3zStAa0GIhn+0M3Lu+qhOAzXOCQilm7sw==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0ber2g5s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 06:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDHDXi50kh6Ipdxb+wxyxVEcIhmQMe77tH1lu6vfJUT9bH7es7/fds67/H3j98aRuE9IhtZYYBJ3zlOyj5WbAJtZ4JeQoeNeRoVHlKX+V+oLXWSofiu77u+oDDdD/lNkc56Vk+dT6wq3Qfx++WN7CKQa/rYAAY1u8FEdq2/T/2JCOeoOx70qQN10uVRNMVh7mYNDeDUjLV0HRtWJNBDfuPwhc5ZJ8RhvRtXFgljMz0Ctg6QmnGiapvnSeujjLz1JNcSTwByAcW7E1OnWap3H3HGJry8w3AWQhMZbLb0KzHLVwWH6YWUpivSkhnw9b6h0bakOCRAgva0/2/MrIfzyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THCVqngQS7fCxWmVNitAdH/ZVKRK0ReCCHVBfBnnirw=;
 b=EUjoGvRi3AM2LY9Lwh0cPFaxBr5tM5vO184NaesHbwLXiQSYfZbxQQ/28ClXWnzarTk4ek8g7uSwq6P+RP7pVm0qJiCPC9Xmw6NPzECNKKTYUTx+H20YIVnnzKJLGkCjny5tW8VaCeeQxaXmLDnNaCOp6jG6Yq91/+rft7ZgL2FnCNKvcrq/BY49RuAFjra0wkthDc0sYSXi2UiEoVIx0RcF76SLY3K+KhZ1qQ0KqXJRKamIWOC+jQ3cr1hJZlFpKPDiKzmXM+wf6ro0/8HIJin/tGQBu8Zksgq/8bhn2E+8AfkcZhnJLlYZclgf1k3Cw8vYEtccPGETOCmiiXFv5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THCVqngQS7fCxWmVNitAdH/ZVKRK0ReCCHVBfBnnirw=;
 b=XaAa18eaKXTmS7Iz3PBy5ZgM6Gde1YHmN5TLfLAbros5KEfiwV3/xwj2svomiufco27gSQNqUA4LRtzDKXuxmnvFdyM+E9D7+8nWTRaYi2BTrOuh12/q8W0Hkf+AxH/TM7WPu/ZmbrDMaBuTC3Z/LtaSJ2Dgf633d3QGsxDt/uSzGJQbuXhrkASWtZzaPf6s0oSLhSny1l0IcXVbMdx5g4SbG3bC7FZGLPkx3GamX8CAu3Zwg4wtA2aNzHfEOt902Pjb1zNnLP5TCxHTRUVdWbqpIlMZwMDzO3urMRhItNn5cix/Q3cHfIPRC/wyJoTLYf9kPzfbqjDq2/pyOZJoEg==
Received: from DM8PR02MB8121.namprd02.prod.outlook.com (2603:10b6:8:1a::12) by
 PH0PR02MB8844.namprd02.prod.outlook.com (2603:10b6:510:f7::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Thu, 27 Jul 2023 13:22:30 +0000
Received: from DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::b8c4:3976:2e10:5a9c]) by DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::b8c4:3976:2e10:5a9c%5]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 13:22:30 +0000
From: Simon Rowe <simon.rowe@nutanix.com>
To: Fiona Ebner <f.ebner@proxmox.com>, QEMU Developers <qemu-devel@nongnu.org>
CC: "open list:Network Block Dev..." <qemu-block@nongnu.org>, Thomas Lamprecht
 <t.lamprecht@proxmox.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Subject: Re: Lost partition tables on ide-hd + ahci drive
Thread-Topic: Lost partition tables on ide-hd + ahci drive
Thread-Index: AQHZns+NLlreHgpDE0eDi7XHUt+a+a/N2Ust
Date: Thu, 27 Jul 2023 13:22:30 +0000
Message-ID: <DM8PR02MB8121A6F475953847F84E6C109301A@DM8PR02MB8121.namprd02.prod.outlook.com>
References: <ad7e1294-f19f-5bea-e891-f6adbe323cd5@proxmox.com>
 <e53fba5a-dca0-6ccb-00ad-d9123b8fad95@mose.org.uk>
In-Reply-To: <e53fba5a-dca0-6ccb-00ad-d9123b8fad95@mose.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8121:EE_|PH0PR02MB8844:EE_
x-ms-office365-filtering-correlation-id: 32e62b17-d1e0-433e-c6ea-08db8ea4877f
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XlBWzKb2QdY4u9ZAe5NzDtiYQFWw9W6GroQzsUS2k2P1iKqQfj7uo2e5YmtUt8SUUsUvGNvMDIZ33nqeBWc94Ch+jum4AXMCG4RfxfKaS3AXDPpcFR0shQHtmwxPxGK6/wgewcz6qbj4LoVa8gfsABMS7X7m9UFXslrQLdG1Il8HeDhNT6sBQJZb08paTfu1WuYVZKvjKoeel2Fwz73N62xtQjyTUIfDzqR+fHHUm0KGsu8U2sToVA3AJgjjrEc995EDUgEqviw/W45qcX4HDljmOq0dEOTthHwOiP8CDFQB2ksOsdbGZXeNAlLSVBf9uqBSHNelLRgHq1iNMfMwkDMceir1Qvt7klBN5CUN5G45flhe9Z8o0wa+UEIHAhA8sUHNukVhe9vfhdDmGKZi9DvYFXAhvU0m7IiOergNF4bHVQyEv0dCvHh6v+4+j2jT0kqZ3h386m/Vg8+ILALPVgPFAEKmN5fI4J7/pgsb7RobEZ5lwnYlmQeZoOQQBOjxHOy0BuE19o46zIeF041oKBcv7aE46r4iTjUYNHnoPzQIZWwAJhjZ/mYZek2dNWuY0dVJS7dJaC5je6hzhFudwilyfqtk/CsyPUtRm3MM5lwqyFux6yiJViSe2vveOv7D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR02MB8121.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199021)(186003)(66556008)(66446008)(64756008)(66476007)(66946007)(55016003)(76116006)(4326008)(9686003)(6506007)(83380400001)(26005)(33656002)(478600001)(71200400001)(7696005)(110136005)(54906003)(44832011)(38070700005)(2906002)(122000001)(8936002)(8676002)(5660300002)(38100700002)(86362001)(52536014)(316002)(41300700001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?stHAm/33e/VGREUoFVRKgDisiWVSGIOLShoiK1Y02vlR2aORS+NQXDUQ?=
 =?Windows-1252?Q?wKDfNY7B1dXPnDkFMf55jnEJnvX9Nfpr7wdaMWASF/NVwqH/1/IeGspR?=
 =?Windows-1252?Q?1CnwjXoycH6WszLAENFbVDmyg7NGy6mPTtL6SNTGlLguFe7httIdhFf9?=
 =?Windows-1252?Q?/DFN20pOQPAaOt9OA/ZqNjgz1rM4+hjvs1kb+VqIPDKes839HK4hA/dG?=
 =?Windows-1252?Q?hJ5H73pzjAEotmlAVZPOozM8ckTszQOItsnxi/JOiDuzl5Ze4WHKPJ8/?=
 =?Windows-1252?Q?ljGdZ7xRMVPs5+0PQEuFHTJ7icX04xM7TNAxB+heX3EJWVYGEPXO/Hoa?=
 =?Windows-1252?Q?PFnFuoE0o004gJzc58GDHFw4L9sOQJPVyFKrPUgJA+jXlosw8F4CGjps?=
 =?Windows-1252?Q?5xCXGd8kNSzfFreNaJzSroT92PpNN2LTOAm5Sg6VDYNvIhX1KHLb9em9?=
 =?Windows-1252?Q?rUhjIETyXJ6klLVzhXU/7Unr3VBZhG0/pYtyRdDxM7cktIMnTwUESonb?=
 =?Windows-1252?Q?kn8X2vSeu/aEXHzw48Xt3TdaZdJzbrhy036xSZfz4Hzn2ZpkMcg67vrS?=
 =?Windows-1252?Q?JP8crsUv73y0+MiYPN/KDrzzxDaM+ziR2p2gFY0yRYwJNzoM1mv10CAR?=
 =?Windows-1252?Q?dz4vuqfhUtepZe/Y4AuNRayfszPM6DyGdQ5YTq5+IG4tTj/IZhh2+Zvk?=
 =?Windows-1252?Q?7L6KFssi9IwQEeFnMmRHPoOk3ZYMnftTRURGPx9ULsMSi+OZsC9h4ZUX?=
 =?Windows-1252?Q?sjbvrF5GQItopSHGMJthui8GlMKsYX9KhVkTqUIXaPX0m70Xfgch4/e2?=
 =?Windows-1252?Q?0xP6XY9ki9LcvMVH6Ua1j4OdQXosP3oeNwk2W7rhoU4PCPm/+ipuYm6T?=
 =?Windows-1252?Q?BLBABbrrCYjtCEKqQAuNdO+vsjPNO78I3UDeC/AMQPa7Q72OIREjcndF?=
 =?Windows-1252?Q?/CpiNfttYgVmiaRK8plTznGGELCcPMm57AbkNf4SwkC/DlAkqyXYid4U?=
 =?Windows-1252?Q?IDpQLlmXxtzhp67oCJx2PdcLfQ7Kes85SlpwW4R3CoB+9OpjSzjhL2BO?=
 =?Windows-1252?Q?5WN4yaGCm7J18Fs586FTnMiUJERI3qMuP+3+fOIauFUO/qB6MpXUPw+/?=
 =?Windows-1252?Q?uyc8PSQ8iYNnyGiTXzTdk80kTvI4NWXc0DYM89g0LNFrk+oqwzk6dsDZ?=
 =?Windows-1252?Q?dR4+jnaO95MfT1oRdLqnT+az8grVQ3vC6ftb41iOieb39b2Dp4FVo81Z?=
 =?Windows-1252?Q?vgGBwlvCsoQkiVxlH/vlOIxwBLDDof+QxvVw3EcBifDKUJSfqxGQe0Iq?=
 =?Windows-1252?Q?dOOCCzLZEM3K2IFydLu+LPQMBxe5vQRkhbgsAiL6bKg2ajjLjW18YE0q?=
 =?Windows-1252?Q?X5DYjrEwSh6zn5gkhDqkj3HPbRztS9e7qnZTsNtJhdZvhb9DPcXHN30N?=
 =?Windows-1252?Q?s44eqOqDl0kMFf2dOuLucC7NYCEeLW13vf3M/VJO2PhiR2apj4958ekd?=
 =?Windows-1252?Q?HxRQdguC6Y5IKML9vUfUkRuk0mYpnp/WNXPiXvnxD1lmo0k0OtRw2Usv?=
 =?Windows-1252?Q?Nl6yeVijd6NeXf/rmMfsBDjMQq5RlYCbPCfgAQj+Et2+snF0qAfWuWah?=
 =?Windows-1252?Q?f/DT+PPf4Sdr5p+PoEVH+NhTmlcyyuetz7dJ+Y0u3/dSxsPHjfpNsCvF?=
 =?Windows-1252?Q?pX+hWEboMB1QKn0KoXve/IqJ6CVX1coFaSSJJHTw4KX2/CTZHDjZTQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR02MB8121A6F475953847F84E6C109301ADM8PR02MB8121namp_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8121.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e62b17-d1e0-433e-c6ea-08db8ea4877f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 13:22:30.1779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TBSV3dDYnVMFVLV6JKuBdBgxSKQsAJV4sqZVgjvnqGVZakAiOJfIihC9dDvr0AfpsOiDhwRFH7eOMZy4ae+wDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8844
X-Proofpoint-GUID: M4ZuSx4i0p6_vXpya1opSVfYOplNv0ND
X-Proofpoint-ORIG-GUID: M4ZuSx4i0p6_vXpya1opSVfYOplNv0ND
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
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

--_000_DM8PR02MB8121A6F475953847F84E6C109301ADM8PR02MB8121namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

On Wednesday, 14 June 2023 Simon Rowe wrote:

> We've also seen a handful of similar reports. Again, just the MBR sector
> overwritten by what looks to be guest data (e.g. log messages). The
> common thread with our incidents is again a SATA disk under the AHCI
> controller, we have a network backend (iSCSI) which has experienced a
> failure.
>
> I've tried to repro this with blkdebug and simulated write errors,
> without success.

I=92ve finally has some success in reproducing this issue. I have a test en=
vironment set up as follows:
* QEMU 4.2
* guest booting from CD with a small SATA disk
* guest test harness partitions the disk then continually writes data to th=
e partition while checking the integrity of the MBR
* filter script that interposes between QEMU and the iSCSI backend, this dr=
ops writes and then resets the connection after a period of time

From tracing in the filter script I can see unsolicited writes to LBA 0 onc=
e the SATA controller is reset

Data in: iSCSI op 01 SCSI op 28 LBA 0 NOP count 5 wait for read False
Data in: iSCSI op 01 SCSI op 28 LBA 0 NOP count 6 wait for read False
Data in: iSCSI op 01 SCSI op 2a LBA 0 NOP count 0 wait for read True
Data in: iSCSI op 01 SCSI op 28 LBA 0 NOP count 0 wait for read False

I have a stack trace at the time that the write occurs
#0  iscsi_co_writev (bs=3D0x564322ecc220, sector_num=3D<optimized out>,
    nb_sectors=3D1, iov=3D0x7fc20c045860, flags=3D<optimized out>)
    at block/iscsi.c:641
#1  0x00005643220e780b in bdrv_driver_pwritev (bs=3Dbs@entry=3D0x564322ecc2=
20,
    offset=3Doffset@entry=3D0, bytes=3Dbytes@entry=3D512,
    qiov=3Dqiov@entry=3D0x7fc20c045860, qiov_offset=3Dqiov_offset@entry=3D0=
,
    flags=3Dflags@entry=3D0) at block/io.c:1216
#2  0x00005643220e9985 in bdrv_aligned_pwritev (
    child=3Dchild@entry=3D0x564322ecb050, req=3Dreq@entry=3D0x7fc2aa90bb00,=
 offset=3D0,
    bytes=3D512, align=3Dalign@entry=3D512, qiov=3D0x7fc20c045860, qiov_off=
set=3D0,
    flags=3Dflags@entry=3D0) at block/io.c:1980
#3  0x00005643220ea25b in bdrv_co_pwritev_part (child=3D0x564322ecb050,
    offset=3Doffset@entry=3D0, bytes=3Dbytes@entry=3D512,
    qiov=3Dqiov@entry=3D0x7fc20c045860, qiov_offset=3Dqiov_offset@entry=3D0=
, flags=3D0)
    at block/io.c:2137
#4  0x00005643220ea55b in bdrv_co_pwritev (child=3D<optimized out>,
    offset=3Doffset@entry=3D0, bytes=3Dbytes@entry=3D512,
    qiov=3Dqiov@entry=3D0x7fc20c045860, flags=3D<optimized out>) at block/i=
o.c:2087
#5  0x00005643220aa64d in raw_co_pwritev (bs=3D0x564322ec4a00, offset=3D0,
    bytes=3D512, qiov=3D0x7fc20c045860, flags=3D<optimized out>)
    at block/raw-format.c:258
#6  0x00005643220e7702 in bdrv_driver_pwritev (bs=3Dbs@entry=3D0x564322ec4a=
00,
    offset=3Doffset@entry=3D0, bytes=3Dbytes@entry=3D512,
    qiov=3Dqiov@entry=3D0x7fc20c045860, qiov_offset=3Dqiov_offset@entry=3D0=
,
    flags=3Dflags@entry=3D0) at block/io.c:1183
#7  0x00005643220e9985 in bdrv_aligned_pwritev (
    child=3Dchild@entry=3D0x564322ed28c0, req=3Dreq@entry=3D0x7fc2aa90be70,=
 offset=3D0,
    bytes=3D512, align=3Dalign@entry=3D1, qiov=3D0x7fc20c045860, qiov_offse=
t=3D0,
    flags=3Dflags@entry=3D0) at block/io.c:1980
#8  0x00005643220ea25b in bdrv_co_pwritev_part (child=3D0x564322ed28c0,
    offset=3Doffset@entry=3D0, bytes=3Dbytes@entry=3D512,
    qiov=3Dqiov@entry=3D0x7fc20c045860, qiov_offset=3Dqiov_offset@entry=3D0=
, flags=3D0)
    at block/io.c:2137
#9  0x00005643220d63b4 in blk_do_pwritev_part (blk=3D0x564322ec4570, offset=
=3D0,
    bytes=3D512, qiov=3D0x7fc20c045860, qiov_offset=3Dqiov_offset@entry=3D0=
,
    flags=3D<optimized out>) at block/block-backend.c:1231
#10 0x00005643220d650d in blk_aio_write_entry (opaque=3D0x7fc20c045520)
    at block/block-backend.c:1439
#11 0x000056432218706a in coroutine_trampoline (i0=3D<optimized out>,
    i1=3D<optimized out>) at util/coroutine-ucontext.c:115
#12 0x00007fc2afa20190 in ?? () from /lib64/libc.so.6
#13 0x00007fc2b3e01aa0 in ?? ()
#14 0x0000000000000000 in ?? ()
I=92m not familiar with the storage code of QEMU, any suggestions about how=
 to proceed debugging this?
Regards
Simon

--_000_DM8PR02MB8121A6F475953847F84E6C109301ADM8PR02MB8121namp_
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
	{font-family:"Andale Mono";
	panose-1:2 11 5 9 0 0 0 0 0 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.s1
	{mso-style-name:s1;}
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
</span><span style=3D"font-size:12.0pt;color:black">Wednesday, 14 June 2023=
 Simon Rowe wrote:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; We've also see=
n a handful of similar reports. Again, just the MBR sector
<br>
&gt; overwritten by what looks to be guest data (e.g. log messages). The <b=
r>
&gt; common thread with our incidents is again a SATA disk under the AHCI <=
br>
&gt; controller, we have a network backend (iSCSI) which has experienced a =
<br>
&gt; failure.<br>
&gt;<br>
&gt; I've tried to repro this with blkdebug and simulated write errors, <br=
>
&gt; without success.<br>
<br>
</span><span style=3D"font-size:12.0pt;color:black"><o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:12.0pt">I=92ve finally has some success in reproducing this issue. I ha=
ve a test environment set up as follows:<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">* QEMU 4.2<br>
* guest booting from CD with a small SATA disk<br>
* guest test harness partitions the disk then continually writes data to th=
e partition while checking the integrity of the MBR<br>
* filter script that interposes between QEMU and the iSCSI backend, this dr=
ops writes and then resets the connection after a period of time<br>
<br>
</span><span class=3D"s1"><span style=3D"font-family:&quot;Andale Mono&quot=
;;color:#2FFF12"><o:p></o:p></span></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">From tracing in the filter script I can see unsolicited writes to L=
BA 0 once the SATA controller is reset<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">Data in: iSCSI op 01 SCSI op 28 LBA 0 NOP count 5 wait for read Fal=
se<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">Data in: iSCSI op 01 SCSI op 28 LBA 0 NOP count 6 wait for read Fal=
se<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">Data in: iSCSI op 01 SCSI op 2a LBA 0 NOP count 0 wait for read Tru=
e<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">Data in: iSCSI op 01 SCSI op 28 LBA 0 NOP count 0 wait for read Fal=
se<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">I have a stack trace at the time that the write occurs<o:p></o:=
p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">#0&nbsp; iscsi_co_writev (bs=3D0x564322ecc220, sector_num=3D&lt=
;optimized out&gt;,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; nb_sectors=3D1, iov=3D0x7fc20c045860, flags=3D&lt=
;optimized out&gt;)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; at block/iscsi.c:641<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">#1&nbsp; 0x00005643220e780b in bdrv_driver_pwritev (bs=3Dbs@ent=
ry=3D0x564322ecc220,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; offset=3Doffset@entry=3D0, bytes=3Dbytes@entry=3D=
512,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; qiov=3Dqiov@entry=3D0x7fc20c045860, qiov_offset=
=3Dqiov_offset@entry=3D0,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; flags=3Dflags@entry=3D0) at block/io.c:1216<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">#2&nbsp; 0x00005643220e9985 in bdrv_aligned_pwritev (<o:p></o:p=
></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; child=3Dchild@entry=3D0x564322ecb050, req=3Dreq@e=
ntry=3D0x7fc2aa90bb00, offset=3D0,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; bytes=3D512, align=3Dalign@entry=3D512, qiov=3D0x=
7fc20c045860, qiov_offset=3D0,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; flags=3Dflags@entry=3D0) at block/io.c:1980<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">#3&nbsp; 0x00005643220ea25b in bdrv_co_pwritev_part (child=3D0x=
564322ecb050,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; offset=3Doffset@entry=3D0, bytes=3Dbytes@entry=3D=
512,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; qiov=3Dqiov@entry=3D0x7fc20c045860, qiov_offset=
=3Dqiov_offset@entry=3D0, flags=3D0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; at block/io.c:2137<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">#4&nbsp; 0x00005643220ea55b in bdrv_co_pwritev (child=3D&lt;opt=
imized out&gt;,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; offset=3Doffset@entry=3D0, bytes=3Dbytes@entry=3D=
512,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; qiov=3Dqiov@entry=3D0x7fc20c045860, flags=3D&lt;o=
ptimized out&gt;) at block/io.c:2087<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">#5&nbsp; 0x00005643220aa64d in raw_co_pwritev (bs=3D0x564322ec4=
a00, offset=3D0,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; bytes=3D512, qiov=3D0x7fc20c045860, flags=3D&lt;o=
ptimized out&gt;)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; at block/raw-format.c:258<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">#6&nbsp; 0x00005643220e7702 in bdrv_driver_pwritev (bs=3Dbs@ent=
ry=3D0x564322ec4a00,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; offset=3Doffset@entry=3D0, bytes=3Dbytes@entry=3D=
512,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; qiov=3Dqiov@entry=3D0x7fc20c045860, qiov_offset=
=3Dqiov_offset@entry=3D0,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; flags=3Dflags@entry=3D0) at block/io.c:1183<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">#7&nbsp; 0x00005643220e9985 in bdrv_aligned_pwritev (<o:p></o:p=
></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; child=3Dchild@entry=3D0x564322ed28c0, req=3Dreq@e=
ntry=3D0x7fc2aa90be70, offset=3D0,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; bytes=3D512, align=3Dalign@entry=3D1, qiov=3D0x7f=
c20c045860, qiov_offset=3D0,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; flags=3Dflags@entry=3D0) at block/io.c:1980<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">#8&nbsp; 0x00005643220ea25b in bdrv_co_pwritev_part (child=3D0x=
564322ed28c0,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; offset=3Doffset@entry=3D0, bytes=3Dbytes@entry=3D=
512,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; qiov=3Dqiov@entry=3D0x7fc20c045860, qiov_offset=
=3Dqiov_offset@entry=3D0, flags=3D0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; at block/io.c:2137<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">#9&nbsp; 0x00005643220d63b4 in blk_do_pwritev_part (blk=3D0x564=
322ec4570, offset=3D0,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; bytes=3D512, qiov=3D0x7fc20c045860, qiov_offset=
=3Dqiov_offset@entry=3D0,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; flags=3D&lt;optimized out&gt;) at block/block-bac=
kend.c:1231<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">#10 0x00005643220d650d in blk_aio_write_entry (opaque=3D0x7fc20=
c045520)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; at block/block-backend.c:1439<o:p></o:p></span></=
p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">#11 0x000056432218706a in coroutine_trampoline (i0=3D&lt;optimi=
zed out&gt;,&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp; &nbsp; i1=3D&lt;optimized out&gt;) at util/coroutine-uco=
ntext.c:115<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">#12 0x00007fc2afa20190 in ?? () from /lib64/libc.so.6<o:p></o:p=
></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">#13 0x00007fc2b3e01aa0 in ?? ()<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">#14 0x0000000000000000 in ?? ()<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">I=92m not familiar with the storage code of QEMU, any suggestio=
ns about how to proceed debugging this?<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Regards<br>
Simon<o:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_DM8PR02MB8121A6F475953847F84E6C109301ADM8PR02MB8121namp_--

