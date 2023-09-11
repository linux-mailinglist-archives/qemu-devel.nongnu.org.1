Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0353179A84E
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 15:35:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfh3o-0004UF-54; Mon, 11 Sep 2023 09:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=611004260=Niklas.Cassel@wdc.com>)
 id 1qfh3m-0004U2-Fh; Mon, 11 Sep 2023 09:34:38 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=611004260=Niklas.Cassel@wdc.com>)
 id 1qfh3k-0006lC-0f; Mon, 11 Sep 2023 09:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1694439275; x=1725975275;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QFD386qRUV8jcl9opeWYQ5ifOiWRdyCgqog4rggupfQ=;
 b=ChDicjGOTCQKPi1Eeo1V4p/J2tDJoroX8iaeJnWquSFkshyhjiAzpMZ9
 t3X/k49r44/cm7fKcWqcNqO7sMyKH32BNStC+BHkxnKAxiNxVi8Z0JAnS
 dpni/GNq4xqM8iHUG9vIHUTGvBUOkh37g9MHGtLQ/eTm+iV4HPNtKdIkV
 6v0Bgmfg905HE6E8/LO/P7p5T54vTn+b8a8m8m247MtCnsjIZfurORkWu
 fFS3d43MbhLUBVMeaz4ax3rW3Ad6FhzrQcDmK6JZth4hEnerEx7MKwYPB
 vZzNQoxdJXToV5GGoyiKOqIKdF2DtQYu8wBa5UahwX/M6aPyqhd8ymRaa w==;
X-CSE-ConnectionGUID: KWWA2SYMQ3WMfSnRykF1ZA==
X-CSE-MsgGUID: 9fk8FPVUS4KzftvF8qVD8A==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; d="scan'208";a="241840563"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 21:34:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nU/KQhghUQcjX2fuO0XdLD80nsJq51tni9ofIzlqLAZ3QRXX7xnIHasEDHonKw5GjsZJn3GtKOv63H1vUdaR1EinVAK2mJzWDLoUZzuZzuNx8QRr1YyVkuHC2hyqRrSE252cS9tnar6CnQWceu/gxpxd7j1lmwB8kqLTm5vtgXl/UqNAB9LDXtmMjwbNRw0bqeESJUpFZRfR/zr8Wu+MRhMmUC/UlrgEMjcgF361P1aQH+8dTN1lKeAm2LgrxqhYsSBMdSXbf6F0Q2aRWbJqfSNrErdTQwJbpduyqhp/BKub97gy4G6KzjJBXCwtpZ27UptZ/yiJPjAbjDZXwO+u1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqUP+nqUQS1KihWEuYhN1NAa9brYjxURsCaygQowu7o=;
 b=P18bg2nUwy+09bexVvkeFo60JG5EseR7VpsL6UMjlc1Xr0TxzpKP7VCrMO0uDg8be83CisyrtfZBf9WngPeZAhNtAyHJ6hLeJviUtIHdEmsPNeMA0fPTwUASWDXbCOeI6e7eyQ8Q6NWskrAsz4pkBaBjkGPyOv6xYpKSCVoFPnIGMmQsnoWdy/x53y3RpTl/tQ3mJFbRp+2Un2sGqXqJKjzgGQNY2ixkT2qRjZ2c6XVt2klShJ3Ovo7UIV6nSedE8r7QJ5wdngBNK8YejeQJcB3PNK4mEkI3VoKuklfK7T6t8CD2/WlABT3NDZMH8ysdbtVyOkzdoSRG/9gGizeHfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqUP+nqUQS1KihWEuYhN1NAa9brYjxURsCaygQowu7o=;
 b=IxkFthPq90JKd+1FjexvSfv7qsWAMxg2w+vBNM0MAh6L/blWcAoamN7Y9fidAEq5LaOAGpNZdOnUM9aLP+8gW2QC+AognKrZPwt+tTa1Xjwg9z2wmvEDaqp8hbRwiKvEom3YmJF3lAriBxFXOSBypsZK+2jTm/vpt1NsTTdjVJ4=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SN7PR04MB8462.namprd04.prod.outlook.com (2603:10b6:806:32e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.16; Mon, 11 Sep
 2023 13:34:18 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6792.009; Mon, 11 Sep 2023
 13:34:18 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Michael Tokarev <mjt@tls.msk.ru>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-stable@nongnu.org"
 <qemu-stable@nongnu.org>, John Snow <jsnow@redhat.com>
Subject: Re: [Stable-7.2.6 29/37] hw/ide/ahci: PxCI should not get cleared
 when ERR_STAT is set
Thread-Topic: [Stable-7.2.6 29/37] hw/ide/ahci: PxCI should not get cleared
 when ERR_STAT is set
Thread-Index: AQHZ4x5RmLlHMFnNQEOKzefV+t4nUbAUj3sAgAETmQA=
Date: Mon, 11 Sep 2023 13:34:17 +0000
Message-ID: <ZP8XWKGjRzdOv+zO@x1-carbon>
References: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
 <20230909130511.354171-29-mjt@tls.msk.ru>
 <64504e99-6668-bcf1-6f97-d7f3f41636d0@tls.msk.ru>
In-Reply-To: <64504e99-6668-bcf1-6f97-d7f3f41636d0@tls.msk.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SN7PR04MB8462:EE_
x-ms-office365-filtering-correlation-id: ac98007f-2d71-46a9-c113-08dbb2cbcc61
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l9PU5emDFdjNz8XWjHZ2XROaKA5Jp9aDa+qRYdisaJxcPRvfXh7KIW1SJImVBN66Qbj4lJScj3a3tp2TMhcCE3va75GUT/aFDzRfWNRMZM9D5ttamJfqjf6AkarFdMgj7ijAB6qA85L42/xbIlt1RC3vbBSWiCG8pvu2L6Dz7sPv+DqxDtU7ZRDvI8HAYjkn5Is6uFvXq8MEGf4P2FAvCTRvyk8mB711l5zs7TjXGdyLQTtfbocfDSMpSI1UiMZiJc4eYlW7Hp4BIqloksGX8koqRaj6ow+wXez+C5a2EmRxZb4g/2YWBHnjL2Dw15P2sYWnktwyeZbveOsUcPqfQVafLAlal8SulRDJ3EuAFLSn96HrL3kSLXoZbB71XU7ACjEh8V6phu/0mlE8ZXHgf0qD1iw//PROIDyBfs3Z6R1AOnr4j7dcTIFZ9SR/YueKdTDBzm857wKVvgU54QvJlCnaRR37I7gSAMn7n4LhmGZzmDHiye21BxjBm4ygFQhs70gixO08oUiS1AeARSk2Uw6/TEWCG9g2afMCNuI/Sdybx6eKIXjNTfW6treDJ0Z+0LcDpjfL/e0FTz0UeJyOst8zCP/7AON3kStIyAkG4mqfjutzq+xmRrVAks+tlKdXGTiOP0uZspsZtDn1uv9rNQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6272.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(39860400002)(396003)(376002)(366004)(346002)(136003)(186009)(1800799009)(451199024)(122000001)(71200400001)(6486002)(6506007)(41300700001)(82960400001)(86362001)(38070700005)(38100700002)(2906002)(6512007)(9686003)(83380400001)(478600001)(91956017)(316002)(76116006)(8936002)(8676002)(4326008)(5660300002)(26005)(33716001)(6916009)(66946007)(66556008)(66476007)(64756008)(54906003)(66446008)(67856001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lRO99EFDyMEYJjqemf6eF1IaVWw+CuSQQWrB16/XU55qqHjHQT3y/cOdx+Oa?=
 =?us-ascii?Q?ifY5ijSKilZ+zm3aNEkYHHpbaRDWxIVSIy0UlDBAmxFkqq8f7l12xwtLCDKE?=
 =?us-ascii?Q?j/+GQVq+NbiiEJpEgSsekWmvAjb1lwMpMWR2VHUcji8ntOWgNPP9wxcVSiQ9?=
 =?us-ascii?Q?X/ckg+vtRNaNj8Z0/gLB6ADFFdHd8lh1pcDxRnUYjmeENIReWRha0xHqeInE?=
 =?us-ascii?Q?hd4OH4+6OnG4PhE7Rwq4TGjrabzMiLc/uXWrCMwzhnxD+EGzaSMkn8ZYEi7D?=
 =?us-ascii?Q?FTIUNlHlFs/WD75l4n6N+aMAlYIWqlbdrVTjDHqSIqhWva9amfwFBZWYXb1D?=
 =?us-ascii?Q?AeM2/L85p1f/+oABzkQgaep0SX96bOJVaoZvjQ1n7/RaS5FxxyAq/FtxlaVd?=
 =?us-ascii?Q?QqQ7kkfrZdzc2mVsVg/P1YX9uP9KRJ3iMHkWcCG7A7zA6EcgEzlQvxvQ9Osq?=
 =?us-ascii?Q?fDzVOGIFxzW7/h1fPce8nB8mtq2fWdLFi33kmxTTScdhL3LnM6YCKYhwDgqK?=
 =?us-ascii?Q?pYIf3yzCe+1aw2GmFrQXfa01Z+6Rpp8hx/brwtSpyGrESmbQ56qbUSIYBJ/r?=
 =?us-ascii?Q?mZakxlAca065swB4Z0Su8OIJ7LxDNiAtuuvniBWFKO/Rkt+4C9NDCelh3lLc?=
 =?us-ascii?Q?LgEk202Dburwv9UDvJw3oKPloB44O0jVNpvI8yk4sHS7aK5YxdsvYv92xIJm?=
 =?us-ascii?Q?IhfYQFghXBWumRiQO9CRqINHQfwMd415aj9AbrlYswYyfbeNT2KJRbnYxtPP?=
 =?us-ascii?Q?1cv57ny0Yc/hzLnYZN4hCnfOh2dLuOr1QBN/mMca0X7Y7A9mwxwobDaEFrah?=
 =?us-ascii?Q?1xoLamyxshdP0NG8UVj4ILiZhFFIXvkbl4HoXJ7tTIcZ7aMDdg28dLM+ylgF?=
 =?us-ascii?Q?fMmz6h4G3eOJAd73XVR3ZKhuDc60OAxxmCERVLJ5DUaYsg2TlvgRHXeFqEbP?=
 =?us-ascii?Q?Xd61d2Rsye2ddwZhYC5KlzgY7PpJOQ40tIqSFxdPLKmWEJGQhEDVZqo8LQfk?=
 =?us-ascii?Q?fjTf/f/5Vixhi6eP3WltAyGD+cVQej3vVAxtSsPaC6fOkoXx7tAS+QdNGwQX?=
 =?us-ascii?Q?Ot84hM3tnSnoxQ1f51Mc0vv+Cco8xNNerBge12wUDBd3CMYewDcvTTuNSUIW?=
 =?us-ascii?Q?jaYkmJuKdQF1z9ZMc/wgpsGfiYI7ezqeb8i4emm056GFyIiRxEFNFs6OVCwT?=
 =?us-ascii?Q?Rl/ih8qxg3WEIjOWtPjyGmtEyO0CE9uXAe4m7oYZGfsyGoCivIh+6u/EfcIU?=
 =?us-ascii?Q?moX0YNu14J/HP6+Qc6WslC8xHHg64KjX4oLtQAVaud5Va+bgntkA+2vvssFj?=
 =?us-ascii?Q?Sxtl4h/Bex9H/xsju1CzFMYC15XomJbY6XMx+dYS29rjNEnl6JKj5jjgnLSr?=
 =?us-ascii?Q?vt4v/BebpNM8lrpQdCYfm8uUpCJ4ti4NmAO9CFWCbSmu6NKndNBYCcmHpnyX?=
 =?us-ascii?Q?VtIIXdAtHBlf3zyCmffJ46TsLCtS3hwK+25y/++oyRhkxfL9NWtwMrsri4rS?=
 =?us-ascii?Q?K8E94a/N5ozLvjERnLjD7kI46cDNZ0mJxQSby/0ZX94tnl2HFz/bVpt72Sl4?=
 =?us-ascii?Q?gTXLehINGBr/bh53nMakm4COEr/p15XPlTBASZfCoj44WByzUqlKTFNmnifG?=
 =?us-ascii?Q?KQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <67375A43509CA943B5F44E44ABBA35B3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1wrSZ0Cs0BOk1hH/tvKPnemTjEtuB+Ps6RY3FOlpkCu1+n4o5BIMkCi4pa+9vrBhQeRD6nqQpIXVzZ8fxEjdKp6t7dEa9mpmq7iNoJ0Lx6MX04U2lXwfWua1f1zFPtFGHxd1j8rCFecDPtMLuZG6A2NEYFXJ1pii5Qp842m7b6kXjx3yAKtUVui64/0jN84K3MH6yTOzly6/GffgzFOtqJRfu04uKJY+gSRvp6MJJzXqTMdJFUQSRay6YtlR8C5shkMFT64cIuEC5+iyZdxGNFlXzhlEYtSJEOJ6JGN8KmYtCRhqjgUI+fNw6U9jZy5n2Hx5rzVfUb7HSYrP8zzDJhbLFCR/TrK19xKulIVWBh6MBJ0X0Qz4NhNu5WbB/QXdsR/MGZOO7NsqdZbXorTpZFcAEXx4nWE62iej9eg6QPPb5IbqWk/DzWZVmRufnJhXjfKOifOQ9VF9b4N4DNdMulNRmi2juHWhmU0xbptnABGV8yDzHKEwY+AWpDO1do99yWg3BgdXka3MxUwrY1/R5gPglq2xAgDEOW4jIVwYh5I8N/KUCFNyBU2cRT0ddxmIK0xatNFbfqJUXeG2cKnqb7d3XIN9PyUL1aBa1+a5O01xkopw2n7B7pTT9XgtY82kNvzE5rBl72uxm4wLVn0mJkjBFQqO3Dvzp7vayeUnIYFeoO9ez8ifUaTaw6SIBTyPQV2mS5m6xByLbEYYknBTA0Q6OkH9enqPLEHbF0O6QxDWYX6sYvycvlahfd68Lz2QrqfSCr0hS5i7eMYvGu33rK8GduhGOzxGR7UPOmcDmDb21NTCnFJpMc1gLs+XVrGldNsfQ/GeybNBf6z3WlGa2A==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac98007f-2d71-46a9-c113-08dbb2cbcc61
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 13:34:17.9840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wb+Xspjnz0glBQtDPnk1UK+dlM7HLdWDN43f31943a6RfHLaE0D2hMkYJ48jwbd5jjvHQFBVjlOrbokH74BttQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8462
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=611004260=Niklas.Cassel@wdc.com; helo=esa4.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

On Mon, Sep 11, 2023 at 12:07:52AM +0300, Michael Tokarev wrote:
> 09.09.2023 16:04, Michael Tokarev wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> >=20
> > For NCQ, PxCI is cleared on command queued successfully.
> > For non-NCQ, PxCI is cleared on command completed successfully.
> > Successfully means ERR_STAT, BUSY and DRQ are all cleared.
> >=20
> > A command that has ERR_STAT set, does not get to clear PxCI.
> > See AHCI 1.3.1, section 5.3.8, states RegFIS:Entry and RegFIS:ClearCI,
> > and 5.3.16.5 ERR:FatalTaskfile.
> >=20
> > In the case of non-NCQ commands, not clearing PxCI is needed in order
> > for host software to be able to see which command slot that failed.
> >=20
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > Message-id: 20230609140844.202795-7-nks@flawful.org
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > (cherry picked from commit 1a16ce64fda11bdf50f0c4ab5d9fdde72c1383a2)
> > Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> > Mjt: fix context in hw/ide/ahci.c for f63192b0544af5 (qemu_bh_new_guard=
ed)
>=20
> This one's interesting.  I looked at f63192b0544af5 and remember there's
> this series to prevent dma/mmio reentrancy issues.  And gave it a try
> on top of this 7.2 series (I already had the reentrancy fixes backported
> to 7.2 in a separate branch, now added 3 more fixes in that area).  And
> with these reentrancy fixes there's no need to context fixing here, it
> applies cleanly right into the spot.  So I re-applied this change from
> the original commit, unedited.

Nice!

Not needing to modify patches when backporting will reducing the chance
that we will need to spend time on conflicts (because of modifications)
in the future.


Kind regards,
Niklas

