Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D0275936A
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 12:49:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM4jG-0004le-5r; Wed, 19 Jul 2023 06:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=55753da1c=Niklas.Cassel@wdc.com>)
 id 1qM4jC-0004lP-Qe; Wed, 19 Jul 2023 06:48:18 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=55753da1c=Niklas.Cassel@wdc.com>)
 id 1qM4j6-0000Tf-RT; Wed, 19 Jul 2023 06:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1689763692; x=1721299692;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=HIajBPRntSDVMU4Y9jC9f7c30/6RYnQLVGwsSlJxgJQ=;
 b=gZ/ReBkqcOkwGupO3BhZ06ll1n54V3ZlgphjkogUXxmfn0fcH1L6Bxjt
 939k6hbn5juJlDkDDxFu+3mC4NLV4+cuU95BA6uhVo7+24BfhdZX3gQsO
 TNIwU/FPQbdp8x8qfkVdtc9ltH6yhLj2WrthAYMJXG3kYd6rrSWK5W/d4
 bQwE+yvNKSiEFCuy5vya9G9WEz35XPyRnsLnULSGZUUgbDM97ZWXa6P3Y
 q2bTCO11L0I3mzmBlqL4nuv1uD/xOUCzJetxe7OpqWWocUrGNVU0ECqti
 2WI4fmRCnnkoqz4fGuWsm+xfLP3xw9dVEOmrSimbCjDJbgE5egK6eteT2 g==;
X-IronPort-AV: E=Sophos;i="6.01,216,1684771200"; d="scan'208";a="238859822"
Received: from mail-dm6nam04lp2049.outbound.protection.outlook.com (HELO
 NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.49])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2023 18:47:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIe5YAQJr4tYQVjBt0u7hcCM1Czn6Nj9WegSXcVTk1Pyq4MOxa7g5o3liox2/9FWHidnsSgWrridu2/IlBzHR9rv54/4ikQtwCJARv31DB2h4M6odeO3sfN5JoijMbY64J1V3CqQk8roHd1Fm2ALIM2GBoMlgCOaPaR8ZH14H70earYbulM+asaNWuAN293wnLSn3Gkr6lpwMBdiahw6IRRdcGYOZevooXV+/i/D7fLYyvDbkT2aPy4pNmJ5j5Q8eZTITUDRJBOs+jw1zUPJD7pI3m78dGLhukvY6Ru/M/psyPOJcSjEq/4FswHudRYBEFPvRC9g8AwXGeZsfSz3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNl96zz1EAmuaDMUrsNV+O12PROpwKPPE8VLs8NYtYc=;
 b=d6f2zQRLV8Iom8LiPRJuvtPDDwAfwYQxJlngXK39Lg/6IVpYbBVjWnWO1s91Y8EkE/nfKoczJOW2HYTRWkc5PtYfyKXmkFwvdKG/mLd6SL/MZnJvKXe6+DVscZASLBkbtbCYzMysNA7Z03iHaJ2erGtlr82eagk47hACrPQ9lFdxhcRvGzPXtHu7Ydv7ierndJAqhHTY7BOfXrlFnxh+cCAuPyWaRxFg1ezALDSG+D6OeVlK+wV+Wqh7GtBCiJuntMPCzf0AtHtvfQdGM7znXFv/kga/g0msM3s0erD8hi8E/2IO2aSnah7tQJBReAoPJPo3xPyTg9u6zdYAV+DVHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNl96zz1EAmuaDMUrsNV+O12PROpwKPPE8VLs8NYtYc=;
 b=vF2YW3q2B57gTUfgdOTvbFMfh25mu1J21ByckSCkYc7SHDol+fibGOtSEumNJnjj2YcOa40uN6yMc95BbCXHmwANiJmxgr5TZ3gwi+Blmj08yghUbf7WgM8UNR8oRkbDDsrB07ktZxwZYO7K7JwANiv00p+0bqPW2kPXmTDb/i0=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BL3PR04MB7978.namprd04.prod.outlook.com (2603:10b6:208:341::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 10:47:52 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d093:80b3:59e5:c8a9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d093:80b3:59e5:c8a9%6]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 10:47:52 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
CC: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 0/8] misc AHCI cleanups
Thread-Topic: [PATCH v3 0/8] misc AHCI cleanups
Thread-Index: AQHZmtwyWx1FN3NYV0CC4hKYUmTqRa/BJzEA
Date: Wed, 19 Jul 2023 10:47:52 +0000
Message-ID: <ZLe/VG5d6TEdp/MT@x1-carbon>
References: <20230609140844.202795-1-nks@flawful.org>
In-Reply-To: <20230609140844.202795-1-nks@flawful.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BL3PR04MB7978:EE_
x-ms-office365-filtering-correlation-id: 47e94e92-b16e-4445-8861-08db88459a1c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Osg+TSry1TRoGJd6L37/OrKXCwGYu6HzjqtFkuNmT/uhot3yoCk17+aZcUhPBqGOzuwvSfhUcMG8jvXosUQxk0Ervbfuyl3ZSGHaCTbaWAE7GK+wFZEwzlmH5qH/HAfRS2ur5PIaVzIoiK/8Fn7WEa4YvGFePTjDNjrDtUSlKM1MrjUfPeQdSqTfOLFOhtheE/mmMXXP7XYRu89pUKan1HeBo1bKetL2EeOM/kJQY+fPIDuS3K8Y8okg7WdQaWTigJPKcpIJ2+LE/lvtGpdwsPSsEhmu/wreHs/zqlZTx9Pm093mV8TvuZA8IgL9xJrcehIGtlL03FEVQy3DFceP6JZ91dmAHI+EW9zNx8Ds+exYnEUKn0GX7nZc7bV1aJHhgU/gN/WrUgaB452+uUpLwPSPNXzGMjG+Vmakl6472tWoZT0xnk1xAA093GOYOdQvFmp2fM3FXL9ZsHVN5+ktpQuPO2WdIVgJP0eiIrAM2N6LeUdk+Fi9eQcUDDEfekOJLno9FNWSnAgQdzoiikkTXSwfi1x6URW0CMGvSqKf5zIVNCD6QVL0lOIwpyobzsQNC0ZwKz61QDMiti6HOYnZ11B0bvb98D78FkYuNpYwJfSuhzQdUzGgFR3el70VEpz4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6272.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199021)(41300700001)(54906003)(8936002)(8676002)(5660300002)(6916009)(4326008)(316002)(6486002)(6512007)(33716001)(38100700002)(9686003)(66556008)(66946007)(66476007)(66446008)(76116006)(64756008)(91956017)(83380400001)(71200400001)(2906002)(86362001)(478600001)(38070700005)(82960400001)(122000001)(6506007)(26005)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bTlRnPRW8sISb/VeDrVrDJHlpyTGIOfxT8AF7Cl8C190/OJPDLTbizo1GL?=
 =?iso-8859-1?Q?VclUR+ehNuKBNUk7GtU48q5z1VMOCxojXy+5B3JijUi/uPW0dOOo7ZWxWk?=
 =?iso-8859-1?Q?26RkLAKET5nGtk8iu2gZBEgoWoaK7ccwAlTDYWVi11l2Pnom9KCHQCRbSG?=
 =?iso-8859-1?Q?nnna7ynUcklGwUF5rv7i+obwlQUqNHQhEXu9GuySRBP/NfTyM6+cSSyn2y?=
 =?iso-8859-1?Q?ViMRSc7g3npsgzqac766sOpL/7Oen+6yFkizW3tkhAxdEh4S0vLv33vQdN?=
 =?iso-8859-1?Q?pZ+BunuLEzncXd7PoyYB0+b2lO9OUDgh8Qhy4fGQXvb553w3EahO5m/3t8?=
 =?iso-8859-1?Q?l/OMa9iUCK4bnVa9nY8g7a2oMp30qkKsMnALA3iIxrPdR8lku8Yv6tDpop?=
 =?iso-8859-1?Q?qMGL2XX7i77rm9lVjKfKbr48lRm2jesNHXychn5nDbKofiOoFp7whrCJRg?=
 =?iso-8859-1?Q?MGuJfi9Qm/nr0fDlb1hxBx7mVySrAka9fEESRJlkpUNF2GB9sStH1bU6ZT?=
 =?iso-8859-1?Q?PsBCfL7sR4egicZNuea5pIzhkUqmMVsJ4mm+eAvHDo0z4S3LVUxtytDw7B?=
 =?iso-8859-1?Q?oghWEqnkQ2qfgROF52XvX33zI5GnNEoJ2CzAhFaRqLcmzqnlbMkaCKS5bV?=
 =?iso-8859-1?Q?FbDae6vFwpFMVePQCmWT5e6F7BR30TyE1FkJggjfdR1q+qknKJDOWIjRZH?=
 =?iso-8859-1?Q?aDye+pdhWcFVgiiiM7hmfXxz3vGVp1yfS6K96J3VNzrHCl3y+HboBaXCaI?=
 =?iso-8859-1?Q?uW49lMytTNg8KLJ9Aj63cyBPv46sf5feXbn/JhZKPWkC4ONSEWIIj8K0cp?=
 =?iso-8859-1?Q?jQbg8LfNrcJSyjh2yrVTR728vtJh/ceNS8y7bNT8baol9JHxcXMw3Stkg1?=
 =?iso-8859-1?Q?jR1kNMQoH4q1vi+S+Th/lynZjj9XnALseKNPlHFF5ZKF6uuiNfNpJ4noxc?=
 =?iso-8859-1?Q?hrKxORpJWt4aZIDMA0/W0aFqWy51uK7s2/+UEeffPu9mb1ZzGMEBW7MBG4?=
 =?iso-8859-1?Q?z6PQ23nejgir+OOvPNWbCSN+khrGBM22dr4L+JJ/o8tCbfBl829fLC36Hh?=
 =?iso-8859-1?Q?LH7XDgGA9wkYcVfanYbXcSwWCR91cI167P3I6WxmdP2vZVHXp0I4AhuUhS?=
 =?iso-8859-1?Q?BkPkw+XABm6FJ3hI4TXHfN38TQv4eha9Ip9s2fbMjjTupVCzc70HFy3sMZ?=
 =?iso-8859-1?Q?mdhccCeG3SicTk8QM0ymSbBxxh1LzxHaQ0EV5HWJzpuv/UmLw82CiNtWMn?=
 =?iso-8859-1?Q?fCs0P22RrbbG+/r4GAPdB+2idh+mdZNsoR2IYHBnGayQflKv/JH84j1/zp?=
 =?iso-8859-1?Q?D3dpZx0P//J/riwqzipxnH9GtsgEXFvPNYPEmXT8hT2+gZJOwVt2jlHwT+?=
 =?iso-8859-1?Q?RKRG+ZuvWAHhqzUt+Rba6FPi3JEg6kDasgyhVHvDO/leznJ5ZVhuurY1wW?=
 =?iso-8859-1?Q?nWdVKz6GWB0xA+DTER3UY1Nd08tJq1bUdOlffXrCe4HKuUri6rlGdsg+dA?=
 =?iso-8859-1?Q?z/Wa0+s0litCwzWCCgL3JkZ/56RHWPJ9TcUtMrOSj6PB1/SNMm5+HhPrd5?=
 =?iso-8859-1?Q?egO7hgPqq+5jEXuacjtuUfF5uVJ/UGz6KscnsEsaZoG6rLIEhDZAbkzAfQ?=
 =?iso-8859-1?Q?XTUAJSrL9FFc5jKN0JbOWtX42VUbTJ/GjoJwon7iCJAi8qF7g5PVphcA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <19AA0B04297071418BEEC998EA76ACE6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wY8YWczUD66Dy2WTvvtM29A5OE425ht6nbsIlr50rynQzj9mjyisnK1thzYjiyF8KQoJoxVlCuOSenF0OoTArFfrQt0bGMZpRD72JrD/oSRjDr23tdKX8/3Ulj/VC+vDJaOWRUbgH84k40YP+7dmzBUT2U6J2NpFDI0nFKFWxuZ0jzKC73MxR82YI1reVL/PS+8y5ilbJoaCacQcaTsny9i7aKSJ9qL2hmwGwYfW/Cvc43A0w+2IbTuoBNMmRPLvkTFmmfFIbNI2XCQN2Q/XPCWpewLjZjngolxQfZ4gWUO7Q2bI7U42KIUorH+U6prDyHxqeGNqCDCFFv7oRpQhWeRTRLiXG4+EY+UNf+q/kbHElDCYW6Hu15/Lj0CVGGEQYX1SCYAyllHLyrPhh2bWXblk+01InBww09sGew+36qs2eoOcG6anJDiOiPMZgj/1VINvW473w5SvNR8prRU9eQ9kP6PtOSU0ajuC6aOtyE+rONlraWYSbhN9i9C5MY0jxbNQNcATi0JDFHMDeD3BjoqA24YcVKMKmU/9D67+MYYM3kbrW/p3rkWysHkhxtfhSkkNkDqggfttOnH9ghn7txMY+LcqDDhkqqiLfeVg5OhZufICU5WOVPVAoHffd6P9z5nem1fFVHp/zE1tqtbEEQqCp8ycd5pn6CDWVvGgVrbenzVN5pSdjgJsMdo6ojgWdPaNMMBDIwwTgahWVNrOg4RtA0Dx59fdGqpvOaNxcY2GaTDA2D/0oFx+bWkrM7raTk6kIpiy4ph0XtAI1hVBzPf+zlNyF/jveoBpnkJ+hgN/C53uVq29PGPS+wd4gzbIYnBycnHRBC8HZDk+xA9n6tXeMKi5CLaqNNSzN/ba/XQ=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e94e92-b16e-4445-8861-08db88459a1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 10:47:52.2447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lRu7si7gtnNbzciEiTFXlcenWiq5TiKPxxg/CoAENz+886DjU5lOFNHWAh1CXh3BywOwr18tNgHbao8lL3idqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7978
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=55753da1c=Niklas.Cassel@wdc.com; helo=esa6.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Jun 09, 2023 at 04:08:36PM +0200, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> Hello John,
>=20
> Here comes some misc AHCI cleanups.
>=20
> Most are related to error handling.
>=20
> Please review.
>=20
> Changes since v2:
> -Squashed in the test commits that were sent out as a separate series int=
o
>  the patch "hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set=
",
>  and reordered some of the patches, such that each and every commit passe=
s
>  the ahci test suite as a separate unit. This way it will be possible to
>  perform a git bisect without seeing any failures in the ahci test suite.
>=20
>=20
> Kind regards,
> Niklas
>=20
> Niklas Cassel (8):
>   hw/ide/ahci: remove stray backslash
>   hw/ide/core: set ERR_STAT in unsupported command completion
>   hw/ide/ahci: write D2H FIS when processing NCQ command
>   hw/ide/ahci: simplify and document PxCI handling
>   hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is cleared
>   hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set
>   hw/ide/ahci: fix ahci_write_fis_sdb()
>   hw/ide/ahci: fix broken SError handling
>=20
>  hw/ide/ahci.c             | 112 +++++++++++++++++++++++++++-----------
>  hw/ide/core.c             |   2 +-
>  tests/qtest/libqos/ahci.c | 106 +++++++++++++++++++++++++++---------
>  tests/qtest/libqos/ahci.h |   8 +--
>  4 files changed, 164 insertions(+), 64 deletions(-)
>=20
> --=20
> 2.40.1
>=20
>=20

Hello Philippe,

Considering that you picked up my patch,
"hw/ide/ahci: remove stray backslash" (patch 1/8 in this series),
and since John seems to have gone silent for 40+ days,
could you please consider taking this series through your misc tree?

The series still applies, you just need to skip patch 1/8
(which has already landed in qemu master).


Kind regards,
Niklas=

