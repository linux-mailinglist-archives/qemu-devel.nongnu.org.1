Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7017642D3
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 02:04:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOoEd-0007s8-OH; Wed, 26 Jul 2023 19:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qOoEa-0007rg-AR
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 19:48:00 -0400
Received: from mail-bn8nam04on20613.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::613]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qOoEY-0005Js-6D
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 19:48:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7wUDhWDVRhkbl5ojazDAah7QnqvWJ88Q8SPzG6LQ4/jdFRODGYJ5SywjzMV9eyefDUB6NUoVbjeeNTdUKXoYa9O7uJg4cpw/hC0XRRUbLPMHlqQpZaAkIjYIJ15IJ/3sSfSsg0QqeX0Ndw/tDeQfDFuzX4wi3oO1lknBQg0As8IT3Pd/qNpBABOFTCEPJzvF6aQ2zuRjV7D5CgWH4JwLPFKivRwguOBWyNmRIf6LTqkYXTr0dR2Yc7SGuwUM5aEP2Un9MSIvm1v1HhLiuzAXuGqvVHwwmzrQOpt9l/PVaXTCHHGXaaoHnfmrW5AitoTEJSKv8iAS3juCOPGSJRLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q99qcfrCTq1/bqD1iBbrWgprhdLI1b5PDuCSxS0vAmg=;
 b=Z//K/+o5uU0YQG487vcbBcW3Few3l038r3xdAgYksS99Fr6Wo2kWASer0aUhZVlz75t+o/NHT0X3qehU/gvrjOak/rpDqDEi/n9n2Q8nh+2IF4XJJVF0s+a3Lqoxf/vwknErCspHHpa6RBwhu4ZIulogwp34mx9Opvpu5T3amnSECCXWIRMg0utSCyouK2f6VNtHUOHMyKXBAIJNQ8sb1Ty7z2yD5XoIsJT52G7AR2iFsA9oIyVgZdjva48YTC9EnxHLf5h3FMpVjK2E6bAwzRIe/Yz3+nHieuasXznssI29ZV1bA5t4IxoBF1hA2R0n5OSQZ9a//f7hLEK2UtvHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q99qcfrCTq1/bqD1iBbrWgprhdLI1b5PDuCSxS0vAmg=;
 b=hKgx9FRuldDe9aGvgQpCZGMP9gHaof0DDb+aCp1vJoyDQkK/3LA0tp5T8rC3VGXZ7OA4fLh7yYOwtN5OU1t19ZOlGM5s982Wjroe6hhywG/a0fYn5NP4Q+xD8Vh2RQawfcc7DFVDr2BnCm4e8p0Ohnkt4eN6U1TRQM7l7UcmeHs=
Received: from BN0PR08CA0012.namprd08.prod.outlook.com (2603:10b6:408:142::34)
 by SA1PR12MB8119.namprd12.prod.outlook.com (2603:10b6:806:337::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Wed, 26 Jul
 2023 23:47:53 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::eb) by BN0PR08CA0012.outlook.office365.com
 (2603:10b6:408:142::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 23:47:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 23:47:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 18:47:53 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZMDk7V9qfzab94Hg@redhat.com>
References: <efc23b6f-861f-43eb-a4b4-900f45e77ef6@tls.msk.ru>
 <93e9c611-9453-e1d2-5b18-547c76f70c6c@tls.msk.ru>
 <fc51603b-c89a-c3d5-f59c-c191847c6c1d@tls.msk.ru>
 <ZMDeSBP7tkYowKV6@redhat.com>
 <0b562fb1-5fc0-38d8-f0d0-65f52f726bc5@tls.msk.ru>
 <ZMDk7V9qfzab94Hg@redhat.com>
Subject: Re: how to build qemu 8.1 - keycodemapdb?
From: Michael Roth <michael.roth@amd.com>
CC: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>
To: "Daniel P.Berrangé" <berrange@redhat.com>, Michael Tokarev
	<mjt@tls.msk.ru>
Date: Wed, 26 Jul 2023 18:47:34 -0500
Message-ID: <169041525456.401018.1634648138421228296@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|SA1PR12MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: 65eeb780-21d9-4cff-1582-08db8e32baae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BnKntJIh251HAmb+TfRbZaypO0Tfhona+SD0BS42SwrRXvZi9oPuI6nCj54fjpM1Ul+Yy2UAhHb5FiSESzGJnryt5IvJHmOiV+5Cw8pcn8HdyGlh1a9hzyPKUM6MxcqY0ZgYMbBKoI8bRX6gOqbKN02yp2hXcp8duxMP6XgBxCqLMlRhI1z6MZ96SyIfitFOksioB4QrgPTyuvL+N1TYhjeWyp51ZpiAdJwfjU4hkC0nK9cwXXprohdVqa1J0mZy+qb63fJbIwsX+Mwi0/ZSeVzPvGgjRarLW7uFJW3Tf9SFrYxZedkxeA4fVeRShCHAQ1pYrr7jAy3HEwSgk45ngLPxpqFTL4PFV+/JfLwp/zPgvbfvZ/n4OrGlkRKfee9OzCjjOzwsINg9aC1wLTRglyxUyHxVRsku3GFTQ5JA+XW8vMtWmaJrMxpww+UXOJrYVI0f+sVIFxFM2hSWJjYwqyTxZfww8ci9Hu/iUxNcnv+8rHvgUqKJnS5rk0wFebrukeGX8UY/sBvi42sIMpJQ5qt9CvkYp+LPH2lHF2I+WPQiCM27YSKF5GEIPNuZQkLGN4zF2RVMabXsLPMOq7uL3SuZ52WmNsAAXP+vgHo227u/OW53HhcxmuXiZOfrQpXy5BdHlcY2ZPz8upit3ipLLInpubBPKUzNJ8kNhiBBFnX2TUEtqvGQtcy5Squ2y0VwgS4qxlaRuPFleltgX0oqtD01iJyDMWXTYlBNBH/WexcElLwq61XP2WOkIQqZ0QMa
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(70586007)(70206006)(336012)(6666004)(26005)(4326008)(316002)(186003)(40480700001)(16526019)(41300700001)(966005)(5660300002)(54906003)(110136005)(44832011)(8676002)(8936002)(19627235002)(478600001)(2616005)(47076005)(426003)(356005)(2906002)(40460700003)(36860700001)(83380400001)(81166007)(82740400003)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 23:47:53.4068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65eeb780-21d9-4cff-1582-08db8e32baae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8119
Received-SPF: softfail client-ip=2a01:111:f400:7e8d::613;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Quoting Daniel P. Berrang=C3=A9 (2023-07-26 04:18:37)
> On Wed, Jul 26, 2023 at 12:05:41PM +0300, Michael Tokarev wrote:
> > 26.07.2023 11:50, Daniel P. Berrang=C3=A9 wrote:
> > ..
> > > > make-release.sh apparently does the right thing. But the published
> > > > tarball does not include the 3 required sub-projects anyway.
> > > >=20
> > > > Is it about how the release is made?  What is used to make the
> > > > actual release tarball, is it not make-release.sh?
> > >=20
> > > make-release is what I expect to be used for making release
> > > tarballs.
> >=20
> > When I run ./scripts/make-release 8.1.0-rc1 , the resulting tarball
> > includes the necessary submodules in subprojects/.
> >=20
> > It is more: it includes 2 copies of berkeley-softfloat & berkeley-testf=
loat,
> > one in subprojects/ and one in roms/edk2/ArmPkg/Library/ArmSoftFloatLib=
/ .
> >=20
> > But the tarballs published on qemu.org does not include these.
> >=20
> > So I conclude the tarballs were not created using make-release.sh.
>=20
> I filed an issue for this and marked it as a release blocker.
>=20
>   https://gitlab.com/qemu-project/qemu/-/issues/1791
>=20
> rc0 was broken in the same way too.

Sorry for the breakage. I've updated the issue with the resolution and
re-uploaded fixed QEMU 8.1.0-rc1 tarballs to qemu.org.

I also hit a secondary issue where the new meson-wrapped subprojects now
require meson >=3D 0.55 when generating tarballs (since make-release doesn't
make use of the newer one provided locally by QEMU). Upgrading from Ubuntu
20.04 to 22.04 fixed this for me.

Hopefully things are good now.

-Mike

>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

