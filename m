Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 548627C576A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:51:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaXe-0008FM-NS; Wed, 11 Oct 2023 10:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=641023383=Niklas.Cassel@wdc.com>)
 id 1qqaXb-0008Eb-AV; Wed, 11 Oct 2023 10:50:27 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=641023383=Niklas.Cassel@wdc.com>)
 id 1qqaXZ-0000M1-IP; Wed, 11 Oct 2023 10:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1697035825; x=1728571825;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=MzuRjSEEuyspiaqPMnxPuPOB7f2VndH7p9sA9ISEmXk=;
 b=bxVYM+ZBxFEPmUkmUCwRiwiy051XbM6T2/FTfIPokyMf52TJA5oADxhJ
 TWdPbKOQFTF6gUnAbbfB7ER36cmReDi1u86KBTchc0/abrvKr8OmNtpqZ
 O4cyqI485AI9UAFVvxhwmesMYPi25srnL360PJelpJFj7cGX7HvAKx6pE
 5yTnlhVLx7ZbiReEmmx3KHFgxK1S7CuvXlNoQ1+3vsJDwjI3Ym1Fl+11y
 6SW/PP40c/ZctHh6DT/ufxiGwPumeVusGZyiYa52RYv5+vMXVeYwu64rD
 Vlk8JGPShJEpfwcpL+eDKuqeb8pTNM97hyBIuNcj+Q6rcJzFVKXJYek4S Q==;
X-CSE-ConnectionGUID: hxshbHg1TSGjzLuj50i/cQ==
X-CSE-MsgGUID: fx7r93OQQpqdElP0mOzcYA==
X-IronPort-AV: E=Sophos;i="6.03,216,1694707200"; d="scan'208";a="250753305"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
 by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2023 22:50:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7jDZPbCUwRoqLtbB62nacAQRo4auUdv1SkDTL76JijY59UAInpYvYzqRs+fwilbuk6/Va0uu9lD9siTCwjIBfSfoOpiRt+71eIsKEJ9M1UBtS5vPIGy2V4518+Pnq1qP0avZbWxmZVeumM2WcDMLLhH0bBF+AJABXlHWMsSqoIoufeXmgoduJ/YZRXye5jlfzjWakbG2uA0Ho6I4vGofa51Nt8FCXEfIJi/DNJF12gNl9QR/SNZh5px8vtIZvRWc2n0Wk8Qo02Z4NAMLUCxhR0gzxqAZ7Crd/5KlhPOntCoGjnibRlq0XN13AzJFS5leDdCHyyxM8QAne0/fQxE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzuRjSEEuyspiaqPMnxPuPOB7f2VndH7p9sA9ISEmXk=;
 b=oLmExuc9PFqKZ6rJiRDmfo3aj2HBpihj0hRZTj1ZaW1HEGDvabsuYDMM4YgnHzVS/tM8vBbKNdEZxaLYVNLi5TL+r2pp+wzua9jRxACl5d/AMKr7iIsnRBAIMDY3EUKedQwxhHdw/Efc4zE4wqejWv6s77yNgaUdkDyasIPk93jUdBGvfA6B+wM9OjhBV3qpNkMQlbeWxyvyN3VmK1zqPLclqdyvAUF+/cc7MJGq80CWCHyQVOtv8Y/aVk7Ep7x4evJaOZMqxY6TGC0I8hpbkY63wih99fF9nMA0bvXbfdSfIdIVM58KpZZHEM6GBPUfgeFzxgjCnSI/V3PTBeu2FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzuRjSEEuyspiaqPMnxPuPOB7f2VndH7p9sA9ISEmXk=;
 b=OdEed3qPlYRV8Mcopo1xuKkxVP7r5qmoRTl1H9DS6/wxP8hIupzB9hCl7+S9OWk0ucoIn0zggRSWAdGAMlVqAyjx2a67HjweK+ssYxitnhMQAWdG63FvYAZYuLLQ6XBO83zTxKiAXbFM4CXJIX17pMHtqoKNbr/48bv/KIyttQQ=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by PH0PR04MB7430.namprd04.prod.outlook.com (2603:10b6:510:18::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.17; Wed, 11 Oct
 2023 14:50:15 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 14:50:15 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Niklas Cassel <nks@flawful.org>, John Snow <jsnow@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] hw/ide/ahci: trigger either error IRQ or regular IRQ, not
 both
Thread-Topic: [PATCH] hw/ide/ahci: trigger either error IRQ or regular IRQ,
 not both
Thread-Index: AQHZ/ES1Aq9Z3JBTVEG59D0n5Ie8WrBEqlUAgAABnQA=
Date: Wed, 11 Oct 2023 14:50:15 +0000
Message-ID: <ZSa2JlimI70BZ2is@x1-carbon>
References: <20231011131220.1992064-1-nks@flawful.org>
 <60feb7df-67b2-49f3-be79-6c8de8cd057a@tls.msk.ru>
In-Reply-To: <60feb7df-67b2-49f3-be79-6c8de8cd057a@tls.msk.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|PH0PR04MB7430:EE_
x-ms-office365-filtering-correlation-id: ecba923d-6262-416b-1f10-08dbca69612e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CMlT+R/Hoyu7p7PDaAiAL6owCJS1KiXZ4IV+k+Pj9qql1hyKqQ0POAKqP1ar36gx+Kc1C0ZB9Rw0jtTC25rF9rtFgRq+cvJRoWkP4AxlJPcwJTrEMTm1mJvZgD7+8h3KSdmPwhTgWLwdHBnpUtYy8JuhrU+Ip6PkmVkI5HQvXp8VJkMLbPr4IrBK6NcN7zzhXr7Am2/Tbz7iChZeVCI3B9hiUqLQ754aogznnqGqBtRifXG8K9/Tc9J/Pp5RDPmXuAHnL9FBj/syP3PAeycaov+XxYFTgV/wcW8Y/c/l2xuKesVt+FRfiDgUckZG1bJctnQ+Hj4ypTjmUtHQYPqYdOr07uTPqhb4D57QnTBqxpuQSyKDxlhG4TRPXAF0QaXyiXXP4o2yGDr3QNeZKq7S0XunH/78tmzCq2th4/tqwovI56sMsKLcpuwk6batVP29FSRse4+WFWIvIQOQtKVshMEZCMqu96NQlH9SgZ7uW0oV73Lsrn+RL+sf8ezu5ciaPWOwWRPzkVcIBthAn59nWRN2JbJ7iIf0sGJUS+DkWOdSGujS0ekJbTeuPsSMoB89VSNxYatiS8cO8D8a395fKRnFICNSXwstgzv9nLa1MLdUARnjfMzqHTcz2wPN8bGK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6272.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(346002)(396003)(376002)(39860400002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(6506007)(478600001)(83380400001)(26005)(122000001)(9686003)(6512007)(38070700005)(86362001)(33716001)(2906002)(41300700001)(5660300002)(6486002)(8676002)(4326008)(8936002)(64756008)(71200400001)(6916009)(316002)(76116006)(66946007)(91956017)(66476007)(66556008)(54906003)(66446008)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KDvu/lpTeOY+xT/M2PAxXZrJc21ySmlN9k7NxucBS9svts3e6/F0JWaunriD?=
 =?us-ascii?Q?PVNaKx0unmJCBWBy396I/T15y/zIogOI9yV6hAH+y0746pIrlvISS6Z00DZn?=
 =?us-ascii?Q?Z9HbEsIZb5Md1o969Goewgt7Cj6HLwN8/q812aVyPPuXkOUsPu3q27baknRY?=
 =?us-ascii?Q?/QGbRCOm3f6olwQsHlYH9blwshr4ZSDGA+tNxbvfWOneSC1mYobGjEiUXOnV?=
 =?us-ascii?Q?avyNc7D2BGRrnzvgljiB7/9uVi7/FznxEVbesdjUWoLmcGCd9odgVCwGw4Vk?=
 =?us-ascii?Q?K4+SzBuPqJNzxt0G6VcAf2IKDLP9azQTd4jpXnglAybgkjT29JXBobSdgQMY?=
 =?us-ascii?Q?gi/+YQwHGttgc5VttUB+/0UoTX48nhHgj40wB3gkV8Qfs64Li6cYI9b68dUP?=
 =?us-ascii?Q?lYCZcSiUTSGeeN3MM09djbxOJ34Di4TOt4/wqirTj4BxokIIxfi/WV9WEkrd?=
 =?us-ascii?Q?tMz65SAhpVE51scb2We034lUlyhwDTx3Wp2l2WOcFiXYLrS6uCpA7awm0zol?=
 =?us-ascii?Q?tV2QEPv2+kDVUs4I9j4U+CnY5Feyk6fduHdl9/Y0pN3a4CVZ8kgtEWF08c4F?=
 =?us-ascii?Q?EmLc4kz54SZ2Ysi4YoOK++1NoJcirA22lraeyAtUHoTD1sevHic/+ARE4Znd?=
 =?us-ascii?Q?ZUL3Iu3CAzC/ZTxWJoQIDKXTDt9iTWZnCZqz2uSuW0UZ4kpow2pmNiFw8Ofg?=
 =?us-ascii?Q?2Fiyo/UF4SDp8j0lwQ7NdskmkiAj/y6SOyK2NS41rFIT7w97GETE5AsdBjBB?=
 =?us-ascii?Q?dKBV2fAyZ1ld/8iVr9fMeJCaH2zVMlf8lX8ccEmKVPCjdJcRjgVRDddQ7EQl?=
 =?us-ascii?Q?COtSgbIZFqnwG92L/9bQlnoHlxlS7T7Z7k2BRaBB6RqWeFK+D/7SqDF1UFV+?=
 =?us-ascii?Q?MNT2r8rSNt+NIceY7KyAz4LI0gyrA4Ysh960n6nAKQpj02JOQ/8blHpRDYZD?=
 =?us-ascii?Q?5PkgitZN7/BuU6r0dOn6Srjg4OIaVNvVXzRgA678W10W4FaYTremacderSt9?=
 =?us-ascii?Q?F4/OI7/dLJBLyl5FBAet7fdoQls7HaW4Sud+0oI62QAvbDhPAHNCI9picQLY?=
 =?us-ascii?Q?KQib+qIYRy/rkjbvVzhiv1WKvtCql2hfRDSGjDXVahEVDC/RP8LtCS6K1vIT?=
 =?us-ascii?Q?x4Z4fhfRaEgTZqMA3QhdySDgM6LVX//FuE20P8Pz9jMrFLalOjVQ6s00w4WA?=
 =?us-ascii?Q?zBG3dDsSeqri0ip+sk7xSLlPC+JzegJwbfLa6Kh8wnL51udBiYC474MELEaY?=
 =?us-ascii?Q?fvrXtmXxaEboZpQHt/GjCKlv4EEZRqOBKIfxtQg75+NEfgHauuH70bjojOcF?=
 =?us-ascii?Q?ehhGHQAKVa8WLrSIrTynK5n9eudLK7Q7r/cO/ADyhEhQ0BXPMj7pCcVCJuS6?=
 =?us-ascii?Q?aNuLEBmdjeGnfCS0xWrJho0itwEOG0avY9Md2Gt95bdZVPyfxq2fzQ+FWfle?=
 =?us-ascii?Q?EHysLxKtWhUO+qNfo0n1hVX+nps6toziwpdnKiqfvQc/kEpL1781VfzOvfzr?=
 =?us-ascii?Q?8qw/VP7U1moGDZMThdA+AQb4phCXUKA+bKaVFx3eZWwMsIlOpnhooDjYGrcC?=
 =?us-ascii?Q?t7Oel0CMb+ljtFSDNLQN5GMSjlPi7k2mFoz2LfwJvw5rg9xKHRgYIS7aXqDx?=
 =?us-ascii?Q?Fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <881B3358C92E2C47823CE2CF05304CCE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jQmv7XpCQd3XvHp4kaLXFlqQFHAz9UkgnM7HZEyBuDqxjLJuo+ZvGW9InBQB5WOt2GyfFnltfunFdZY3ZHc6iYwHWnJXoExCRiZ7IiFxOYQu7yu5Tg5aikMiSKZdVKIiwc3lQKAs5bpfyrj6RYtLKemoykK+wOUUJw3b8Vkqfej9+7hyQKWupr6fc7CGshWEocBmrXnfrBWcBsAM+8bcTSFXHgpL9JAP4xpqBY+1CBokpgvadGn1Y/ESWbS7FBo0aihdCHwZ3mumTXOBCe1ZGM1CQBXzgu84mmEXj67laRCcA5T6rsVYg1NeAvPoVZ6+RxfAd2izFaveOc52Ry6GqJv+KrQc02v4rsqKg6ZyT5koSkWij+4iSlERbqf9tz24rnR8NBMMG0O4tbgnvKHpGEFll6LCrGWty6Nf0iggJ7/7HzAEL3iGh08sskQtVT4ocHRe4fWyTmGrVpGuEWLyZoPo1GOSPPcTsJSqr8LFlPWLnQCBjjoBj8k1x+PbhgicqHS3d/SBsX4QR+ukXOvtW77Vt+Rn2OAq6gEPTUrSorughiUA1lf+0iWryHOHbaQ58ooe6+1rIDNaiVmNKQ1PI+mgSgUu+bexB+Zsf+16hBAwZIWX+BVvgq0Wsy6x1WWgCmq04L2CBG1+AN3uPoBB3iHdJKMA/xBJkuLUoTTwtnBn24af2mj+xQItRadIRiBYApUX62wHCR3t/qa9+yWH6KqS6FtcLpqNCyqs265f29WhbjV648mwcjxNwz+79SWqchPgbQjb0ur/v5ge9ALNutHFeQi3U4sEXMogGRVGqURuMeHhP0ddBVHyKHkjEmqbHk17ntQK6xxrbH0OroVwPhoCMZBPlYXCsTWXXPK1flSS66xSX8omL92GggBrB12f3JAAQHhFC7B3budfIROAXQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecba923d-6262-416b-1f10-08dbca69612e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 14:50:15.3611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q1S2LiHepK4b1E6coHIJ4TP/mvFVBoKxpPzz4a2ByeNnYfU0Je0fSLd+Nz8gQ5TNhL1XNLtw1Keo0lwS/SNDlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7430
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=641023383=Niklas.Cassel@wdc.com; helo=esa3.hgst.iphmx.com
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

On Wed, Oct 11, 2023 at 05:44:28PM +0300, Michael Tokarev wrote:
> 11.10.2023 16:12, Niklas Cassel wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> >=20
> > According to AHCI 1.3.1, 5.3.8.1 RegFIS:Entry, if ERR_STAT is set,
> > we jump to state ERR:FatalTaskfile, which will raise a TFES IRQ
> > unconditionally, regardless if the I bit is set in the FIS or not.
> >=20
> > Thus, we should never raise a normal IRQ after having sent an error
> > IRQ.
> >=20
> > NOTE: for QEMU platforms that use SeaBIOS, this patch depends on QEMU
> > commit 784155cdcb02 ("seabios: update submodule to git snapshot"), and
> > QEMU commit 14f5a7bae4cb ("seabios: update binaries to git snapshot").
>=20
> Am I right that without commit 1281e340a "ahci: handle TFES irq correctly=
"
> in seabios (which is included in this 784155cd update above), seabios
> will hang at boot for 32s when qemu is booted with ahci drives?
>=20
> I mean, is it the only implication of not updating seabios after
> this patch?

That is correct.

If you don't have the seabios patch, the seabios ATAPI command will timeout
after 30 seconds, after which QEMU will boot and behave like normal.


Kind regards,
Niklas=

