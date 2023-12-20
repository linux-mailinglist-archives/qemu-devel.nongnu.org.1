Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 661A281A586
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:43:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzeb-0007gr-8P; Wed, 20 Dec 2023 11:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rFzeZ-0007gY-Gb
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:42:39 -0500
Received: from mail-dm6nam10on2062e.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::62e]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rFzeV-00054V-GW
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:42:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAKkCgA22rUzEfKxO8EwFPm8rCM76EHskqvZ4+KelaTq5RtgVBjio5FQpfg+LXFajeCaPNpZdxX+sswZAL602U40tHGD9mifLkET/IqOALxEtvvyrEtGCAajQGac9euUJFaMjRXXwIwksr8t4ay/zxcGdzU1E7E1lI3nEwDQr8+bHHoJrGPXVY1v/KeysXJ4Ttir5Vm/2D2GDREvFV2ihU8LZ5A+DIb2r87qi92It2rEl6UuCmG5rUKUzQRLk2056I5BkHxy7a22hE6RN1jTW48BR9G3UCVE55zA9akKaV4TbI8Y1PpZmNgk9TuWcb+m7dYklSrUbEq0UNLep+DUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4PqxCpoI/j3P57tY3scw9JlPJ60WKo4g+Om2hNXwbc=;
 b=cEyBmr32Y7JPMscHyleKRn8DTT7ORdf2QX0aOa7to3wYaYu/PfJKo+IyBkWugPAT0TvRmkrLTZoZgKgT73NQmS9xH5CiMtqeule6P40CUeeqEMO2PXfBzoiQmH52S+PKkiH9cEMeOXXTUwWDLR+PrqCsypl5+9tpddl+EOoQ4ecer57EFuYZuSnRoTOBUGMq3DiYVrjjusqvV0qDrw5fRCXYnSNFp1Ww2AUaH8XMK4KIuNxJUE9UqOiGNofPxouqrNlebfOdDu7Rn1Da85EY13dad1Q5oshk8hwePlCQMVqNSc3iZ7eBecrA7wJ4KYi+UEA/z1usuyY+7lGSQZTQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4PqxCpoI/j3P57tY3scw9JlPJ60WKo4g+Om2hNXwbc=;
 b=PHL2KiE+2vg3INycVoh7jMFiUB4A9aD/QRTn35u+123/lOv1SMBCPRi/3iIcVK1tNDonU0KFobEFf6g4eqLji3pGJWFpTwYiMcgvlDmo68DsHKoILIYxBicJdETCr8Cp9qLrjLrozOY58hJInS0lXEiR68gwg9+LhB0kdc3mPHc=
Received: from SN6PR2101CA0024.namprd21.prod.outlook.com
 (2603:10b6:805:106::34) by MW3PR12MB4361.namprd12.prod.outlook.com
 (2603:10b6:303:5a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 16:42:29 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::60) by SN6PR2101CA0024.outlook.office365.com
 (2603:10b6:805:106::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 16:42:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 16:42:28 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:42:28 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJSP0QX8GHtwRta9KP2NakMQ68-pCutO0KQNjpfhgMo9NWEE-Q@mail.gmail.com>
References: <20231220160237.843113-1-stefanha@redhat.com>
 <170308870249.47564.2031507210923112269@amd.com>
 <CAJSP0QX8GHtwRta9KP2NakMQ68-pCutO0KQNjpfhgMo9NWEE-Q@mail.gmail.com>
Subject: Re: [qemu-web PATCH] Add QEMU 8.2.0 release announcement
From: Michael Roth <michael.roth@amd.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>, <qemu-devel@nongnu.org>, Thomas
 Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 20 Dec 2023 10:42:09 -0600
Message-ID: <170309052968.49987.7836300821674007014@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|MW3PR12MB4361:EE_
X-MS-Office365-Filtering-Correlation-Id: adb85774-f217-4e38-6ee9-08dc017aa789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JSM6cjl28rDeAJ60DKmZZZVnjkhtotj0qtAL8vhclcZwxzBOleU4CiEwG28u9HMNq5hxasxqCH2qMe5yeMEA+TMuB3+ALJMH6zNF8GFV5Tzj0j6PWKlZ0QSBH/0N0GkPhbtGm74g/ChBt6CTDO3EZgCfZtAD75uNHEejnoNSshK2NITMSxam0B5yAyYAZhL0t0RlEAswRg9c2tHWY1ouiCNNbCh1o59MY8DLVJudkn1vTvbjI7OUXctWeGMygSqfzfSJBoV50biPbyE68a1fr0WYbDlriNw3/0PURhIU/3IjbSLEsRv4GvFW9gedrwH0DJ+Ee6I151nnd+a6MYgA52gVN0iZez9Sv8+FNpSnbNu7Qzfhdw/Uj5noC0W5vx8ruqD1GE28/En/cx9A7DbqkDV9YJIR2Hh28ByS6xwSx6Md9ZmtSjJQ2bInGsfomU9N3aGw8MhS2xZ+osK7kyozaPPXNzxpmnKNxkuLEEhfwT4sR5DperVAb0c/UftIOmtrI80SD9scZjISCk0qEy3cGe10M9lZFn4QQZOZj9xZQuT+E2XQuBioiUtOYrbYxfgo2ZBjWO+ajZ+9HmUCNH+tg07IkY26gKpP2RmcWeRPbUqHTfdFj6hWZS4SGFKzroy4R04nZfidrUhXYPUMSjzAa9hXD0EA3NfMlFEnTWBVWC5Vh+WHn34CuWFyLOBjWRMk5+rrJ5DMaRKcFRAiVml1E54ghsv8AFNahgv2haf4vtMNuaN5lXCnczsBFm1LjRBL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(40470700004)(46966006)(36840700001)(2616005)(316002)(26005)(47076005)(83380400001)(426003)(336012)(16526019)(4001150100001)(5660300002)(41300700001)(36860700001)(82740400003)(4326008)(54906003)(44832011)(8936002)(8676002)(2906002)(478600001)(6666004)(70586007)(70206006)(6916009)(81166007)(356005)(36756003)(86362001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:42:28.7738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adb85774-f217-4e38-6ee9-08dc017aa789
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4361
Received-SPF: softfail client-ip=2a01:111:f400:7e88::62e;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Quoting Stefan Hajnoczi (2023-12-20 10:32:53)
> On Wed, 20 Dec 2023 at 11:18, Michael Roth <michael.roth@amd.com> wrote:
> >
> > Quoting Stefan Hajnoczi (2023-12-20 10:02:37)
> > > Cc: Michael Roth <michael.roth@amd.com>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  _posts/2023-12-20-qemu-8-2-0.md | 29 +++++++++++++++++++++++++++++
> > >  1 file changed, 29 insertions(+)
> > >  create mode 100644 _posts/2023-12-20-qemu-8-2-0.md
> > >
> > > diff --git a/_posts/2023-12-20-qemu-8-2-0.md b/_posts/2023-12-20-qemu=
-8-2-0.md
> > > new file mode 100644
> > > index 0000000..c7cdd8b
> > > --- /dev/null
> > > +++ b/_posts/2023-12-20-qemu-8-2-0.md
> > > @@ -0,0 +1,29 @@
> > > +---
> > > +layout: post
> > > +title:  "QEMU version 8.3.0 released"
> >
> > 8.2? :)
>=20
> Oops! Please touch it up when merging.
>=20
> > > +date:   2023-12-20 10:00:00 -0600
> > > +categories: [releases, 'qemu 8.2']
> > > +---
> > > +We'd like to announce the availability of the QEMU 8.2.0 release. Th=
is release contains 3200+ commits from 231 authors.
> > > +
> > > +You can grab the tarball from our [download page](https://www.qemu.o=
rg/download/#source). The full list of changes are available [in the change=
log](https://wiki.qemu.org/ChangeLog/8.2).
> > > +
> > > +Highlights include:
> > > +
> > > + * Arm: New CPU types cortex-a710 and neoverse-n2
> > > + * RISC-V: KVM AIA Support, Virtual IRQs and IRQ filtering support, =
and vector cryptographic instruction set support
> > > + * 68k: The Macintosh Quadra 800 (q800) emulation now can boot MacOS=
 7.1-8.1, A/UX 3.0.1, NetBSD 9.3, and Linux
> > > + * HPPA: New HP C3700 machine emulation and 64-bit PA-RISC 2.0 CPU e=
mulation
> > > + * LoongArch: New CPU type la132 (LoongArch32)
> > > + * Tricore: New CPU type TC37x (ISA v1.6.2)
> > > + * New virtio-sound device emulation
> > > + * New virtio-gpu rutabaga device emulation used by Android emulator
> > > + * New hv-balloon for dynamic memory protocol device for Hyper-V gue=
sts
> > > + * New Universal Flash Storage device emulation
> > > + * New Xen PV console and network device emulation
> > > + * Network Block Device (NBD) 64-bit offsets for improved performance
> > > + * dump-guest-memory now supports the standard kdump format
> > > + * and lots more...
> > > +
> > > +Thank you to everybody who contributed to this release, whether that=
 was by writing code, reporting bugs, improving documentation, testing, or =
providing the project with CI resources. We couldn't do these without you!
> >
> > Thanks for writing this up. I ran out of time yesterday and am working
> > on the announcement email now. I'll plan to merge your summary into the
> > email and then push the resulting highlights to qemu-web if that sounds
> > okay to you.
>=20
> Yes, that would be great. Thanks!

Done. Thanks, and happy holidays!

-Mike

>=20
> Stefan

