Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4A2798551
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 11:59:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeYG7-0007Ie-DX; Fri, 08 Sep 2023 05:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=60838829e=Niklas.Cassel@wdc.com>)
 id 1qeYG4-0006pG-KE
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 05:58:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=60838829e=Niklas.Cassel@wdc.com>)
 id 1qeYG1-0007Bu-Qi
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 05:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1694167113; x=1725703113;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=UIiKFdgnbk1HqhOx3kU0di7VDbr/2QkPMIeBzzBdg64=;
 b=T7pBznH5XZaztIN0TnqcLfROMupn5+gxXke/QaAYUspOPDmCJxfLBdd1
 MzwpSXA67sAHAcv78irua0HzZJ7bqPQ2TJXSFl6VgitDfHWEqNY62icGr
 LQRTCpOANgIDM02bEHKEVkMqShOdZWIAi04dijwrp5IG1m7BQ82ISf6Uo
 S49rVcyVFdSfb29V2N4L9vQEfC/5C43NXSk3We29EInR1Zu+ejgx9VIdC
 TjoKkEvZEQpFAQO8EblG000iH2GQbl3amgoQ0cxV5GlRUmS5QwC7/mlUk
 6VK7FaUloFWHx4qt1Q/68sOWnLMcDvWHTyJgXXJcBxSdlcgqiIbEEEHkn A==;
X-CSE-ConnectionGUID: 4ODbjDOJTMCHVOWQOx20Xw==
X-CSE-MsgGUID: zkIgYIdyQV2ymO+xzyMt8g==
X-IronPort-AV: E=Sophos;i="6.02,236,1688400000"; d="scan'208";a="355389315"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
 by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2023 17:58:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGqBRYcH7DTlH/A9Z151fao+I+Rw1JHs3+/BY8aTd0sn6kuFXba0I8mbCc72Pi2SfhaCCvJkf74lFZCM9UqyrPBuPDUu9PQAnuXVvHHp1zuKx+C0S1yzCQd7TGFBPKNLanUHWlkuzySUzSZEmbH1B3Eoi/k28Gn2Je05zDgPAazRbYKLqr9G6XX1cEtQV/aARNSth/IDM7Wyk5m3WlZDZbaXeHmmcenV+BWxiaAd9vsa04b5UbrRPmk2BqoIDGEpI73fAoZ52U0vrQR72ln01NNId3JKH8u4iczPWKB9OW4djQPvZUeQsrF9vQSyuZSyx2nI+J2UZ0SvsMgi/kGn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIiKFdgnbk1HqhOx3kU0di7VDbr/2QkPMIeBzzBdg64=;
 b=ivs/Pt87cr8I0cIEf7GHEEq1/c88kN293XCyQ+5wbUO7NZjkvh6TOM0UgYtaES8cwrDTVPc4q04/crMSp/dLu/4rNvSg8W5CyDv/GvOv1wMAcu7WfsUfCtYhreZYV4OZln1g6wFPkLW++JOYFnJuCdWeKxoYpW7a4d5yaLxFSIYQQAG8xaf6OtldT/kv/QUb0buCMLg8VoSqxWIemhpKEz+Cu8gTxfeP7x9/m2lEdNKxYk1vsNrvGldi0Cb1pm37GHIJWJhB4lMmkym9tdrLsjRq3NTHo7iItCiSHw4eQiAIzP1sySIZtZS3+6bT+4/ImThikjv+VUXqXowHtgPeQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIiKFdgnbk1HqhOx3kU0di7VDbr/2QkPMIeBzzBdg64=;
 b=m8UJ6j0c1wVMvjOVHQqEHnOiasOwPSbwqtOV0YcaNp+BYtUyPffZCI6z5StN3lopY/4dGsA0Ojj5QDXnqB/7ezkg9QV/W3wrv4pKrRYes0VKNkIdMX29GUTmMgnquv2hUQB+j97yl+YU5PJ/jusiJhwG17MEgBXsCHOQ5rYJV4Q=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CH2PR04MB6983.namprd04.prod.outlook.com (2603:10b6:610:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.11; Fri, 8 Sep
 2023 09:58:22 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6792.009; Fri, 8 Sep 2023
 09:58:22 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Gerd Hoffmann <kraxel@redhat.com>
CC: "seabios@seabios.org" <seabios@seabios.org>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [SeaBIOS] new release tag?
Thread-Topic: [SeaBIOS] new release tag?
Thread-Index: AQHZyR0hYFlAqDwrIkyXTxG1nJ15cg==
Date: Fri, 8 Sep 2023 09:58:22 +0000
Message-ID: <ZPrwOo6KVPk7N6yq@x1-carbon>
References: <ZNDMtAeAGJardllS@x1-carbon>
 <ifi2dswo3cuqquzqiys7jamlvefaoxmvobljqotrh63xzceld6@ndbqfrnp762a>
In-Reply-To: <ifi2dswo3cuqquzqiys7jamlvefaoxmvobljqotrh63xzceld6@ndbqfrnp762a>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CH2PR04MB6983:EE_
x-ms-office365-filtering-correlation-id: 954a97cb-04b1-47a2-0ef3-08dbb0522308
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +crm3gQbFngOej60OUTe9K48V/jO/OuvzEuU6A1OEvlbx+ApJq9oZyLCWb9zE/MoRDMlLCBgjgckqe2nmapXLt9lZ7aN8lhfQxWsREV5bzKjnn4nQL3mjfOgfURwVlEClyYTZhQR5jTXFohkGxJcnnXGM0RWwvecd4JPVBSHiUZ6VXuOjlXjJBVhcNg54BpBcA1fpXPl/vzaYBMVm6PgoTfffv+WmPH3SybpPB5RpEeon4V4uOHkL5Iyc2oD3jnCCwolZBbm206uk7Wb7UH0Z+JiP5QGEzQk7JQN5VIZdRiKSSl+z6xu6PN025l+nKCAT3ifEuanpXp9J4+llcCQkZO6dy5aN8LvrX/16Ised/Nes6d/8eDV9xSkXNTli8YsgkXG2xw4Pt/v3I0BLlALTQD4cZ5018/z0auGQ/uoZeH4UTu7vF3vUx8CBe3yl2dzKbk/abpAFCDf1SLyaZiR2+wwmBMWtHRUAaP2CQyeFOL2dG/VHcbDseiAgZkzVKtByPxlWGuhhw8QBb65YyoIPnngxGQmfZHODgQVQSk8wdYD6WdZm0JB1ZGqD2PJJl0DBIzFDBwQ9wH3sy/2nqNTmLjHFgUXzW45aUqH1gcERV2vfY2oXX5fGZ5L3zKNsZ96
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6272.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(346002)(366004)(376002)(39860400002)(136003)(396003)(186009)(1800799009)(451199024)(9686003)(71200400001)(6486002)(6506007)(6512007)(83380400001)(478600001)(26005)(41300700001)(2906002)(76116006)(33716001)(66556008)(6916009)(54906003)(66446008)(64756008)(316002)(66476007)(66946007)(4326008)(91956017)(5660300002)(8676002)(8936002)(86362001)(38100700002)(38070700005)(122000001)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A3LbvYrlUKCTINemT7kBWUccDT1OFYJsdsaTCYGf8hMw0Ffw6zHHhqDRb13g?=
 =?us-ascii?Q?Gwm3dxzjFc/GgB+O5Q6jwe5dt+mjkNAoanov8IvFNGpSQeN7l5TX6e6DmWLS?=
 =?us-ascii?Q?VPS7BuYIiv8jYMEVu5JqNseqvhZt/8gJEI6JQcuouNhXq/rCevTlNrC/D1yM?=
 =?us-ascii?Q?wbb63F2bfgH/oc3cUDB9IlK2hKWYyEP93a/YHRP0Nve/z7qEogUthm0ySxzp?=
 =?us-ascii?Q?L9GGeZfCO3bcujJ4NnsDQnTQxpIPZZ3dkD1xWtcZZUzH/a0a8Ms5BJhPnk3K?=
 =?us-ascii?Q?Qy0I/HWAxp8vtLh+0JG9Tngjf5ntGacKkfpsfGI8HJOcFz/DkMJP00REK4O+?=
 =?us-ascii?Q?/VSSiP0Gi8n+WaH5uEUtsGk2oN1/8Jsj+W0AAiY4Dowca3vALpEY0CKozBHK?=
 =?us-ascii?Q?4+CBxtyPUAgyz6pFT42mZJg2pOgxkK1FITM1RxHnnec3l5O8DuAX0iiNvmbV?=
 =?us-ascii?Q?tVf/pU4T0HsEdbSyPpAJkVVKnUNXmwHH5W8zdWxpHj/3ayGZUkDuezDs6QrF?=
 =?us-ascii?Q?s3IvgThF/Xjo/dNlinFk9ry1x2A2Kcuqo6yAgj4HEDkuokqNZtCi+QU7OLbd?=
 =?us-ascii?Q?tMqGriJvTTbREl20z4fO7OPVrabTfmMaKZ0Iz3GHJQOVsjjSYI/73bJbH44S?=
 =?us-ascii?Q?x+k9jR6hEiFZy/TawUscNF/sy/ygRsQ+v68TAu/BNntAeqb3ObbCAoC+jYWl?=
 =?us-ascii?Q?q9TN8nxlUGkFGt8PcajvgWDhsW8sEkmSB6GzqvUFmUCZDLjN8ruuQiQriWgv?=
 =?us-ascii?Q?xIo4VJqQwavAt1d8T2MtNWjHqGMYcsAzBNtBgdojljaL5Ni66QB5I08geSfQ?=
 =?us-ascii?Q?Q0J6uHPz3mQhRAST0vZ2MKMic6ht8pM7pt+IgZgBhB4nz6Ojqu75evvixjHJ?=
 =?us-ascii?Q?Bbc/Rn8qfxO1/ES7tBfaouNZXWGgqFhQzYBZ7wKjAUT1CaH+N6YTjc8aftPt?=
 =?us-ascii?Q?nNgCi9bVhhwZzXCa/pNv4Qa94Itx3N4iMWzVotj5LaumRc56sQXiB4yt2glL?=
 =?us-ascii?Q?qUGx2swv216JAGzPpzf5MttmNG2VS/svGX1RqHY8AA0tm+be+Iew/ssY55K/?=
 =?us-ascii?Q?wO20+eLA5PIsMGsFF5zwtJyKaWBhk3u2HNvbo6cFCZLAeLBjMPaynC5mBr3K?=
 =?us-ascii?Q?kLHMA0elQ963FbJAU+EzTtSBZ9WcsJDTcYPjGFGNrK+p7qyLGTaSL2bGy4fy?=
 =?us-ascii?Q?SLmtVE6+w6WDl7c3OZdC0enR9XGLQ+oCyHUO4btJUy/Sw4JxLyjuhY3UPpoq?=
 =?us-ascii?Q?evUh1bvc655LRrY+wTCsQgvJXAVyJjNX95FXRZu5ALBlLamajo07LTcrRIPZ?=
 =?us-ascii?Q?7kml+WPSF1tJ6ruuzELgYn1Vt6TAwfKLe9pjfj8AgY8j3kHE5jKmTTM7YYk8?=
 =?us-ascii?Q?HUcPlRn6UIk7PAnCYteaq2U+qf2icm0gOk2yxo6PB3eBXP9R4x92ceCpthjk?=
 =?us-ascii?Q?OV/r/dPhxuul9THJnzO0Tvzpiu2gkGhJO86u0mmRQpN1IJ8ir4aD3uawGA7E?=
 =?us-ascii?Q?P+KbVkdK68PDJF/gHMWo4tBMFRA71Wk2BdWOPM40nDknH+MEnHY9dkLVLIqu?=
 =?us-ascii?Q?lHd4McXa4sffv5LUNWPiMzDW+FgWkKp7F9XTzuGm6I24X2HsE8NiGZfiRvFZ?=
 =?us-ascii?Q?MQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E6AF683A7172146A60152397B5AC1AD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2RFSEUnnHTCG6Ry6/BLJn/4gsJAWW7qomhYw5Hf82xgJFSuftxiE9mNMgMybBwTEWSZkd8hGVplOVdBBTNOWZfjqo/rIK4EIlXmBAyt1DvQrYc5jHS65jYMMrvPspgWUMRY5oJkK2PNiJ6IR5K5aFa3gsu9b58HFISR+wsweeDEsmR0x5wg5A23hxGVlm7kIpezSm8HWN4jBzfqLKwLDnP9/qb+B9p3g+F924I5QFg56+xXDkko+MqQfhHlBDXKVyTe3nxzARCB0dQIYAFxfrbg6BzrGbmmvxb03u5U+5EVgcjs6lynjv72km5MgIwASvh8P5fjaYhpHssOljWqUOxjX2g9QaF6PuIjxGTLY4HyouoiT7r/G/J9NS4CvgGrzdp+ueK5LlKR9fYDwe5kOAFW2Ub0iMAKa1hSzv5AGFZFzkvgTOXPBQHT4Li9fKBbWGZigMaws7MQY5rzcqeJPf4mDnvM2GoWfD9MqBspkeTR/N37tluy5k2qRSjZIxWcipcvoV6GUfTeLyiFQWyQYQUC8sgHMoYjr0Qogtt9gVQFHmKVDR4ecCQzwPW1pOJBXVRYjaQaRDMC2+4Jr3c8WxnOiUWJ2HIhvh6GmGmZH4/98liD0XO62owOTQUhIaDKeviczfncn1CHPj33DQhcFRMgHjek66vWukup4DzYKqepCavlKcYDczUV84JZRulEFSW+aTc3mO8ZTgQNMLnR3DPbEl0/RwXQLWSyqhFDLL57xpDiR3eGyF7uUae/LgVmeSCwjHZnkMoRmTwjEOaPaAVSNpxAhvieedrlzywuvquhI56tIeVyvusHm9drcgTZeCMTGSCOe/c0rzqSSn2VZWIB5f010kgW2TlBhGo6o1mo=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954a97cb-04b1-47a2-0ef3-08dbb0522308
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 09:58:22.4495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2OZXPonlvCTpEhVtzuXxwNKucBF2pXFHhLE0LD0Z/KJZq5ie5AiB8Dl/xLfUnlCvZZe6na3s3111qYX4DUdDgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6983
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=60838829e=Niklas.Cassel@wdc.com; helo=esa1.hgst.iphmx.com
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

On Thu, Aug 24, 2023 at 10:56:05AM +0200, Gerd Hoffmann wrote:
> On Mon, Aug 07, 2023 at 10:51:33AM +0000, Niklas Cassel via SeaBIOS wrote=
:
> > Hello Seabios maintainers,
> >=20
> >=20
> > I was wondering, is there any chance of getting a new release tag
> > (e.g. rel-1.16.3) anytime soon?
> > Or is there any plan on when it will be tagged?
> >=20
> > I'm waiting to send out a (AHCI specific) QEMU patch, but I can't
> > do so until:
> > 1) there is a new Seabios tag
> > 2) QEMU has updated to the latest Seabios release tag
>=20
> I guess Mark (Cc'ed) is sitting in the same boat with the scsi
> driver fixes.
>=20
> We just missed qemu 8.1, so we don't have to rush things,
> but it probably makes sense to update seabios not too late
> in the 8.2 devel cycle due to qemu patches depending on the
> seabios fixes.
>=20
> Cc'ing qemu-devel: Are there any qemu changes pending or
> planned for 8.2 which need changes in seabios?


Hello Gerd,

The QEMU 8.2 devel cycle has started.

I do not want to stress you, but if we want to get additional fixes in,
that depend on the new seabios version, isn't it better to get the new
seabios version included sooner rather than later?


Kind regards,
Niklas=

