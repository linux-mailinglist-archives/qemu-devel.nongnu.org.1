Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2509A7D7F58
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 11:10:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvwMW-0004QY-OT; Thu, 26 Oct 2023 05:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=6566d02c1=Niklas.Cassel@wdc.com>)
 id 1qvwMU-0004QF-QV; Thu, 26 Oct 2023 05:09:06 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=6566d02c1=Niklas.Cassel@wdc.com>)
 id 1qvwMS-0002SC-R7; Thu, 26 Oct 2023 05:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1698311344; x=1729847344;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=LBeLX3PyTvyfJuDiM3+sCnri/aXkU4GrCjnIIRVzMms=;
 b=KXqZk0Htrf73LDm556isAwGBAF1J7Myaq5X0RjAus9FKf+89eRNJyXsL
 1YuGzFyZgeY8AiYtH7W+4hUAV+hsu1p9DewVigJJBBFnCozPCPI1uV9Sr
 9HfSD4zqZCIQhJBA711mvblWXXcKKh/6BudE1pudtG2TBbfyXUV+Fdtpa
 zafDTWf3/m2CQy6K3DqVphnkN2fR/fcA2GD8gY7kneMHtn51YMvMACg8N
 4AFM+IAx4y7DqdIbkj8LeIdAlGqMRqozpJhROOArhXZv9vND5ICFY/MnG
 vu4vJgs/IPoApVExXfpl0Qk3eMBEpGDccRqPQnMcaOdQc6mZI9Hyh1Ayf w==;
X-CSE-ConnectionGUID: Ejvx9rO9RBWGHHK1l6oafw==
X-CSE-MsgGUID: Z20dcvliQESICSPaUYj4vA==
X-IronPort-AV: E=Sophos;i="6.03,253,1694707200"; 
   d="scan'208";a="670592"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2023 17:08:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mef7chwy38EYJ+PBrTx4GIHFSgwFPDzBEdbytT+Gfd5oNlKGzJxhLlAv3mb+dLBA9OeBQwwww2yMpJl+u0gF187LUlOQ8jj3aGHC0zriwWK8xfk+ap1VDod5K9wOzQD06DgJ+SSsFEV6ZQZjjsPxhOXnzTx2tK+ul2g3JRVCAaggxycRFb46H7NkJQ0DIu+71PDe0bpzEs8v7/Hqnb2gn8QYEezHNQl+FVaY6ew0Kz2nr1WBoxMedpF4mRMqVL4Z0DiNfxTXzt1FvjbDlUoAXQU4gI0cJGkufysEZ1XMTV/hvpflA5U25J823FmIc/XzFkMyqqn1sMmEybW0sOemXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDRQZnQywnhSorbhK/PRy+3eXpMR/zHaInQFPNjAUkk=;
 b=CX5W7UrXheTUzAeCEM6Yid58sAM/itBFZkcj7TU0rOCVkOis2AVMKzprGoAJVJx4S9tNqUKv7Aou8nejJ5T6UmLkoAd6PXpu3x3HC3vD5SseFA9pN9Tb63sIyRv4dIi56waHbgJK05hHWsqdzn9BEGqGh41nwhid64wcYCqOM5YOV7ckro3JLnJU/pGBTdKSpHi3cTmeunbLL743Tnm+HXOb50hTpGy48sN2d6Gs13OKqGlpoh8HEgMUO4Ywa3L+jW35h5QXQj0FbAhpqH5QxLUqFPkp24gvhV2YHkVjV9rc7yWu6A1XY/vnmJo7fYkvWmXeesPxSrOGXPLiYwtnag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDRQZnQywnhSorbhK/PRy+3eXpMR/zHaInQFPNjAUkk=;
 b=txRqsYsdYz/rpkH5qK6iENJIcwtcNJL7KwzHpJbZVlZrkTzlSFAgPn3ackRLa2GdtcY75txmYF/gLvEpVRczpOBf8tEJeo/3qg8p+0BDV2ohX2hP2LzV6rs3012QDeaT/KHEAICVa6YNPgRCFSs43+gZmPSA2s86tERfJ7lX/EI=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB6584.namprd04.prod.outlook.com (2603:10b6:a03:1de::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 09:08:51 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6%4]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 09:08:51 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Niklas Cassel <nks@flawful.org>
CC: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Damien Le Moal <dlemoal@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH] hw/ide/ahci: trigger either error IRQ or regular IRQ, not
 both
Thread-Topic: [PATCH] hw/ide/ahci: trigger either error IRQ or regular IRQ,
 not both
Thread-Index: AQHZ/ES1Aq9Z3JBTVEG59D0n5Ie8WrBb34cA
Date: Thu, 26 Oct 2023 09:08:51 +0000
Message-ID: <ZTosollIoo0h8NY7@x1-carbon>
References: <20231011131220.1992064-1-nks@flawful.org>
In-Reply-To: <20231011131220.1992064-1-nks@flawful.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB6584:EE_
x-ms-office365-filtering-correlation-id: 98124c70-5dda-4983-8c9a-08dbd6032be3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bK3EljVtGgzHAK6caDwQ50uwQvlX9N679IFWunNw+fnZJ6tdSRC+bIRZ29bCjS7uqAsakYzdC5wDZFqcCUhViDT8VMVuMgdgr2IquOHBCtJLEGgCBsNN3OqEAhPdCeQ55x8WIJf2AUAglLYLOcEPQDqHydfAM1wX/Mrd+b9t02wS4sT4LaoStPw/IjET0Bev3bUAQRcsDltp/5EFgN7cfqbSHYhhP9oJaSXbVFTIj/EMYeb5Y8Sz7YtAonKiIB5UD57XxQXvPFTo4l51jql5LPnj4gG33ZaO4LmILqTjCyh5V78cxVk4iZnFgI4dHjd0c/lB6mRCHMJmK9TeGdLuhRbr+6xt4+u/DE27ITHivM14IcsbrGEtOm0z8qpWfTXoJ6afqZQPO0H9YouiAc/re4t0Ew6d8j/x9MtMLK0WJugBpXjhONVEdfdSVBuGnO8zu3oIXYSa9IVfpW2XPU0i/9aBqYaY7kibBfNxkrpOT/ZPu5EzFaQNNeEQNYLdSHRYCVVRNTRZsRRdQe01wff/9lrxcfc2kPmD80jW+itMZV29pTbDhYyAOpR1a29bXgNXnJ8NFdD9EBOR+2cAzte88C7SdDn0TzoyO/FI2r7XEeXgY4DR8y1Ds6rjvGFOvlwM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6272.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(4326008)(8676002)(8936002)(71200400001)(6512007)(9686003)(6506007)(6486002)(86362001)(91956017)(478600001)(26005)(83380400001)(33716001)(38100700002)(82960400001)(122000001)(38070700009)(316002)(6916009)(66556008)(66476007)(66946007)(66446008)(76116006)(54906003)(64756008)(5660300002)(2906002)(41300700001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B4AcWvEf3aNKqlptAPHjK5Sw26OQsEkTK4ylYj0kFfSId9V7DWjPC9oV62b/?=
 =?us-ascii?Q?dgZEJfyLp/C78BygT+NOQPqICYAfvgjzP7/VkiuEDj5aOEemjlOxN6swXte2?=
 =?us-ascii?Q?yt6GakG8U0AMVqaNw97WNdKl//As90kz4yDNd6RM2s/pwfpbRkgkjqDgnIJn?=
 =?us-ascii?Q?CWOnmIZqebO60/C35N4n+eBwfAEF/GB9Kq/D1AGyajoa99yZgJ0pqYKVGTtN?=
 =?us-ascii?Q?3fJHjLGPO6BEUf54J95LRuN8ADCJWIEDuUD7IjNSSZT5KluILr1p8TrDsIDA?=
 =?us-ascii?Q?xTeSOy45iHcXWXhPBL2bi9DJ16gEfJ8NwnoOrYWp7VWi7QaKOpNSF2Dben2v?=
 =?us-ascii?Q?vynfzUulowzMOyOeiTwdxrd9RUJiX5+o+LFGIZIc6fKJvX+t4aSAJPMkv6FH?=
 =?us-ascii?Q?Fgc2gkl+7fHI6vDg8KZNh73lgGGi43lFSc9cLEWISyj1MWcEfXld5+km+sL2?=
 =?us-ascii?Q?aePSb/4M1wi/E2pX5r8AYsrDkIuNjgNg/4MNcPD+K81aq9KZY8Gw23xaCvcP?=
 =?us-ascii?Q?idXU18d6lUNtE8u1psDguV7LkfRj5wxk47aGdpMzRNdHx6wxJxSOeY401Hyu?=
 =?us-ascii?Q?W69sSn4DCDjnWBOa70wuzrBAzp0JkZpUYC0Na0wHBD64cVLeMPorChMqrU9i?=
 =?us-ascii?Q?2RVrBtdLG/atl9efsAvzXSZyocGWltEnb3XPuW3WY9meuOz2678nefvOa/24?=
 =?us-ascii?Q?4TDCp45dtwInS9tRcF03xZpT7YrPvw9FX3A3gv2SmjKnufyU1jLMtmGWNl5m?=
 =?us-ascii?Q?E1oMxjwi1emN1duOegUf/UntsZCh85IxNjOLqRCVu+vUNB0rWl+mkVPwzqhu?=
 =?us-ascii?Q?w0ftPbGTTCQdbdn2yS3/3S9WBvCcbIX9lRr8HgbQgQV7dTIPeNMoYKzc0j2r?=
 =?us-ascii?Q?4P7Jm0PykgfaVBYqDyun51lAfCUOaXLpm4iYCd6rpZO0b8TCyB+jduRksHJn?=
 =?us-ascii?Q?szMDzSrw+rrL5aTbzWlIJQg8Ha4Fn7FsP/EUBwscI6Stbpg/+FpR2I/rqmBW?=
 =?us-ascii?Q?nVkklDvZ7feRKnh1JBpPiK1GmRz2HE30nXuMdWG8Tuy6YZG2T5nh1jiloFCF?=
 =?us-ascii?Q?nx/sFMJpAmRInRlaWC5KjAWpitLq3UzvW0gjRdpAYLiS2FM/IwkbJyw2YmOy?=
 =?us-ascii?Q?VhHi21mF9e0KIp0SGjmTW2suQfEGdWkz4ttJDfIZqJ3UdWRx9OOFHJPLzKx+?=
 =?us-ascii?Q?usItWMO7P0D2TWCE0LhiHK7iODGHrC6KvCMQ6utr/dQDWqrFHqko7YcErqRu?=
 =?us-ascii?Q?4xwzgTLORUX5YXnZbeEcs9ZjCYTv0ctDFRtOmEzT8ZIgQk0IQIxlwlmW8slU?=
 =?us-ascii?Q?yUEg6Rfovy9D5orfL8JrkMz+TTwax1Ri0T1NQrpnvbvEyUFC2uyzI03J+r9L?=
 =?us-ascii?Q?B67PRxw7QRgtW5RXjdomi+dweMvk1Ywf/KlywKLdhQUMxd/I+ygiZjDvIRBo?=
 =?us-ascii?Q?dPcDA5558AHQDO9KRsnqRLCfqbxvWDhdat7jYVuB2qh9vfPHCNt3PMkBHXnC?=
 =?us-ascii?Q?78/KxBYbQME5bexe0kceFbYGwCipVMDzuJNB5DzNDHjlOw1FtJDpAyMJSbXI?=
 =?us-ascii?Q?705rXnOqc0XWIJCpIgHQThYn1j6qOIWbf+cwhAuYCVDFobcE0PnSov7AOLjy?=
 =?us-ascii?Q?Yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A6E7564D56AED949A07DC68859996278@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WMkr75mpFEEDGhfUFGrWorm/4cHAIAq/EIVF8bmsU32Xm2CDRSm/bPOGLLNBIvqUpj08PO9z+PDvwcNs0S+p6QpvpWfatce2F72JoNtexu74PfjVLlhE5d4+HviETHCwE3aFkOnrq0t9Cfp5gAITA7SkJELBpYabyys9i52YLbmJy8Nz+Y+TnG6l0eDuIDLj3jOVSR1YqxtY33LraqVM77zf5ngHktBGvfe2PzVmjyB3PNfIq8au7Viuw+2VDZpqpJp49nO9D60b2vPig5OZSD0EVMNzHk9UTC5MzagfcIy12VXjScnOcquXkp8q58/jIWdBcf52O7F/p/HMakthpf5RTOaRRXxyY8Lvmp9CfC6LkaLA/TyilElnhDNaV6zb2ZVrBiTV3paFRWxwo3SU+enaqYuJYtmVGMwlRxRgrGdLQEvnFHQpTBaV9rYjMTW3azfNOIE+mkdN5pL5nMXHDyq4G8CSw8zmEaSmDRo+ha6wvbST2U3OmWcC89om0C1cLMa9rbDWDirZ6NzaRTLDdRqKuU/MecbnUqOWtGThOGmMBXN/tMArQO8Qwj+HA+SPYRSti/9D+G3cM0HUCjptq8d/hhoZVCr/Px58Dkw3AKE+pWfYpbo4UJ4GUo0J4s9M+MttqK1A8rETWEU+i6blwfTJOvs3DVrEdmvzAja+c41GJ1+rGDWi4cvHeybJCJQy8e3SVs5Ih7g68zPWkesGlDt5U8330BvBARLFWyGuClf2tBKXJ+fY+oSyE03oNCAcvyjMMb1TUnqmvbW0A3/tTJbKLQejBVo9/gcHq4vFDCgyslDLrKyVbqc9jAQTxTfb+jHpPXqt4CPGUq9unkYkiIWclgwBCWwA5o1l5P/klWl1hgIVsxIrL/fRxyUEl9E7a9CDEzl4rxCI9xCabs0oEQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98124c70-5dda-4983-8c9a-08dbd6032be3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 09:08:51.2440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgPKgLq9vQwQJmufbtU4JucehAuRQETZDIneqioJdvY+DYWg7ZPDZ8aiMyh/FhwgHRkqZBEUrP5uEED/LYI0Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6584
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=6566d02c1=Niklas.Cassel@wdc.com; helo=esa6.hgst.iphmx.com
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

On Wed, Oct 11, 2023 at 03:12:20PM +0200, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> According to AHCI 1.3.1, 5.3.8.1 RegFIS:Entry, if ERR_STAT is set,
> we jump to state ERR:FatalTaskfile, which will raise a TFES IRQ
> unconditionally, regardless if the I bit is set in the FIS or not.
>=20
> Thus, we should never raise a normal IRQ after having sent an error
> IRQ.
>=20
> NOTE: for QEMU platforms that use SeaBIOS, this patch depends on QEMU
> commit 784155cdcb02 ("seabios: update submodule to git snapshot"), and
> QEMU commit 14f5a7bae4cb ("seabios: update binaries to git snapshot").
>=20
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  hw/ide/ahci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index fcc5476e9e..7676e2d871 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -897,11 +897,10 @@ static bool ahci_write_fis_d2h(AHCIDevice *ad, bool=
 d2h_fis_i)
>      pr->tfdata =3D (ad->port.ifs[0].error << 8) |
>          ad->port.ifs[0].status;
> =20
> +    /* TFES IRQ is always raised if ERR_STAT is set, regardless of I bit=
. */
>      if (d2h_fis[2] & ERR_STAT) {
>          ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_TFES);
> -    }
> -
> -    if (d2h_fis_i) {
> +    } else if (d2h_fis_i) {
>          ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_DHRS);
>      }
> =20
> --=20
> 2.41.0
>=20

Gentle ping :)


Kind regards,
Niklas=

