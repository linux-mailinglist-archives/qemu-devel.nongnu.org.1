Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7A574DE78
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 21:47:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIwqi-0007sq-D3; Mon, 10 Jul 2023 15:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qIwqh-0007rc-0t; Mon, 10 Jul 2023 15:47:07 -0400
Received: from mail-bn8nam12on2062e.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::62e]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qIwqe-0005Jv-Qp; Mon, 10 Jul 2023 15:47:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGKZEBBv9u38cFrL1LjaDeMgfarPVyA8Dmpmh6iyVq+fFWGCKIUbPq2jEt4l4F4thf95Ezo9yTRtWgn7ilo6ctHgdWaWPs4VYJlV4+nhs7yU53+Gz4gX0h/h18KJ0GrEVcHvtr1j4/LURltPY44HVnOtAdelf0PGNqdryasZmsgnqNVxPKWWr9a4xNWVMhUf6vW3PJDi6fbI5N3pV2wemUK9Iy8BVXlR1wX8dXn86wivuA978NiH+v/hGMY0lt2sc0qh0zfUa4bFNjAlB45Btm0ixQYHU+wFtEiUWdUe9sXmqxpguBhXFkoGt7NH7+XSJeEXLYSdGFe4fUAuSoo8zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZ+nFpG0+Tk9YUXDXXomCXSjvMRkw0ahMsxLfmtbbks=;
 b=Kl6T1Eyr0fTHFC17tyhk03/6/QVjFibPfCmmos1Y2Y6/jipfqEtAMYVvw5sIWHqZ4CEExCj6OsHcSApCCbr/tiyAlz01Qs+VtMg/RnHLagQh2FmUD3gi+KegVnHl1FBu29TnVIiOuqgkMN+efEI9fhFEfWn7A0TXqxFgJx27bpQf8HtgAz6I+E1PdH1DySuQ8HPwPPFKQSMUGoEMoDhrKcDaWvQYlLhbSUJPVlzVR8nLKoxRzv3NTFqzHHiv3OKLcW6NRhiRP4ADItlQbbhKf4DmNhcuuuMIZIRXvfpIfReITHCN5ZvyX3YoRL9JNUpyj6mW0+jpsbRbBPqefJ0z4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZ+nFpG0+Tk9YUXDXXomCXSjvMRkw0ahMsxLfmtbbks=;
 b=GTW4W7vgpbJbjkngX2liaa0X/xKZTNAyGX9SFxdcOlooVXjHs4rqWArHssGtlrgvMq3thl70AUS5WHo4DKvQ5wZa9APm45sYCnnpv9Pb/8EvCilArCmnmvyP3ZdSbEpbU7rtR4kIdsUxPItM4WdGfFQjzTpfVzfjShEegy8BEf0=
Received: from MW4PR04CA0194.namprd04.prod.outlook.com (2603:10b6:303:86::19)
 by PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 19:47:00 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::39) by MW4PR04CA0194.outlook.office365.com
 (2603:10b6:303:86::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 19:47:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Mon, 10 Jul 2023 19:47:00 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 14:46:53 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 8.0.3 Stable released
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-stable@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 10 Jul 2023 14:43:36 -0500
Message-ID: <168901821646.1032094.17816644875017747165@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT034:EE_|PH7PR12MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ff0139-f1f3-4d0a-c580-08db817e6d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: asYJansNYGSSTSsc9qpeGF4Ti7SE+TRaj00FmsXYpKH/zxlHOSoz7RPoYxmee8a2ZCR28duPY1r87dv5wO0UMUCF3s/vcUbM1uQ/z+dk5WYLXtzAzwfYjElTw+zxbgwPStQHXwpriw0EWsPRljlJJM0pHfmnlLCQG1qrf8TJkEKqAjfaL0SioErTesw+SRJw7xYi/dbB8+ZV+nYuJaKJP0dihVXiGYFnyohBJr7MghlCzUl0aM+t8LkDoXaeGhlsdAw2FMH+eJ17chJTxy/wWfii7jKY2YlLo15rEbPC2HGeou2z8knFQ7W4tur6RR2G4Yvr3HsQbhdD60XSBMpKos9uH2vpscFDkgvyOK9Dhfk0fcr9FxDigIEt7bD96EZ924BvQQqpashnpmR3qHujTpKpzZPvnW3I85RQ/0QSnYteoINjNnaqdspPYsPoFuhJRPsC0O1CLDaPxqBeauIziEfIVJq25fkm+/tzo1YlK6/uFf6WThkXAkApSNpPbkKsEWkljDiiqW1wshAEHDpvTQDg6U1ew1YwUUmfWTwbAAzukhLTpNYoaYoojiSHodc3FIaZJyFwTmsepBSFInM4+lLp7v4rPikQWuFZsf3ODauTfWXPtTIHvnc/pPb1797vNKMlngoO5gbnX1kADOMb7aPzGXN00Q2+eXUowv2c2FMg7s9pwRSg5Fx/HvwWSmiRjEU6cwokCGUEOpg38O57vgrk2SM8poKfUK9vXWuXxZJeFAlVg1EyJN4aCkp3Lmon
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(6666004)(40460700003)(966005)(4326008)(70586007)(70206006)(6916009)(82310400005)(82740400003)(81166007)(2616005)(356005)(186003)(86362001)(16526019)(26005)(36860700001)(47076005)(83380400001)(426003)(66574015)(336012)(36756003)(478600001)(54906003)(41300700001)(44832011)(5660300002)(8936002)(8676002)(40480700001)(316002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 19:47:00.4054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ff0139-f1f3-4d0a-c580-08db817e6d79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::62e;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

Hi everyone,

I am pleased to announce that the QEMU v8.0.3 stable release is now
available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

v8.0.3 is now tagged in the official qemu.git repository, and the
stable-8.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-8.0?ref_type=3Dheads

This update contains general fixes for various architectures/subsystems,
including the following CVE fixes:

    9pfs (CVE-2023-2861)
    vhost-vdpa (CVE-2023-3301)

Thank you to everyone involved!

CHANGELOG:

a342ce9dfe: Update version for 8.0.3 release (Michael Tokarev)
fb64b62378: target/arm: Fix SME full tile indexing (Richard Henderson)
d2402a83a7: accel/tcg: Assert one page in tb_invalidate_phys_page_range__lo=
cked (Mark Cave-Ayland)
78e8c9c1a1: accel/tcg: Fix start page passed to tb_invalidate_phys_page_ran=
ge__locked (Mark Cave-Ayland)
477ab906d1: ui/gtk: set the area of the scanout texture correctly (Dongwon =
Kim)
df1e45c9df: linux-user: Avoid mmap of the last byte of the reserved_va (Ric=
hard Henderson)
383fb8c05c: vfio/pci: Call vfio_prepare_kvm_msi_virq_batch() in MSI retry p=
ath (Shameer Kolothum)
58b3e4ff5f: vfio/pci: Fix a segfault in vfio_realize (Zhenzhong Duan)
55ee115e7a: target/ppc: Fix decrementer time underflow and infinite timer l=
oop (Nicholas Piggin)
ce6331222d: vhost: fix vhost_dev_enable_notifiers() error case (Laurent Viv=
ier)
246b0cf1ac: vdpa: mask _F_CTRL_GUEST_OFFLOADS for vhost vdpa devices (Eugen=
io P=C3=A9rez)
5e8838524a: icount: don't adjust virtual time backwards after warp (Nichola=
s Piggin)
a76c5126ec: Revert "hw/sparc64/niagara: Use blk_name() instead of open-codi=
ng it" (Markus Armbruster)
8c792a532e: virtio-gpu: Make non-gl display updates work again when blob=3D=
true (Vivek Kasireddy)
dc4c852d4d: ui: return NULL when getting cursor without a console (Marc-And=
r=C3=A9 Lureau)
aab37b2002: vhost-vdpa: do not cleanup the vdpa/vhost-net structures if pee=
r nic is present (Ani Sinha)
d33534a4c7: vdpa: fix not using CVQ buffer in case of error (Eugenio P=C3=
=A9rez)
46fe2deaef: vhost: release virtqueue objects in error path (Prasad Pandit)
c10525874c: vhost: release memory_listener object in error path (Prasad Pan=
dit)
b62e5d8ac1: target/hppa: Update to SeaBIOS-hppa version 8 (Helge Deller)
06f32b3dcf: target/hppa: New SeaBIOS-hppa version 7 (Helge Deller)
29c753001b: target/hppa: Provide qemu version via fw_cfg to firmware (Helge=
 Deller)
8fa1462292: target/hppa: Fix OS reboot issues (Helge Deller)
deb40cf67a: pc-bios/keymaps: Use the official xkb name for Arabic layout, n=
ot the legacy synonym (Peter Maydell)
cf7950282d: host-utils: Avoid using __builtin_subcll on buggy versions of A=
pple Clang (Peter Maydell)
72a23f2991: target/tricore: Add CHECK_REG_PAIR() for insn accessing 64 bit =
regs (Bastian Koppelmann)
b9e1415e16: target/tricore: Fix out-of-bounds index in imask instruction (S=
iqi Chen)
4553eee156: hw/timer/nrf51_timer: Don't lose time when timer is queried in =
tight loop (Peter Maydell)
22d71f9eb3: hw/intc/allwinner-a10-pic: Handle IRQ levels other than 0 or 1 =
(Peter Maydell)
f38ca28c66: target/arm: Return correct result for LDG when ATA=3D0 (Peter M=
aydell)
2bdaf89162: target/arm: Fix return value from LDSMIN/LDSMAX 8/16 bit atomic=
s (Peter Maydell)
fb8b14025b: aspeed/hace: Initialize g_autofree pointer (C=C3=A9dric Le Goat=
er)
4a83e27b21: hw/riscv: qemu crash when NUMA nodes exceed available CPUs (Yin=
 Wang)
e7d265340e: target/ppc: Fix PMU hflags calculation (Nicholas Piggin)
1de8291e29: target/ppc: Fix nested-hv HEAI delivery (Nicholas Piggin)
3c6346625b: target/ppc: Fix lqarx to set cpu_reserve (Nicholas Piggin)
d09e35feb5: vnc: move assert in vnc_worker_thread_loop (Anastasia Belova)
967e42986f: hw/remote: Fix vfu_cfg trace offset format (Mattias Nissler)
b9d2887be4: 9pfs: prevent opening special files (CVE-2023-2861) (Christian =
Schoenebeck)
828af6b31f: qga: Fix suspend on Linux guests without systemd (Mark Somervil=
le)
fe88635449: docs: fix multi-process QEMU documentation (Jagannathan Raman)
6a69a58b1c: hw/xen: Fix broken check for invalid state in xs_be_open() (Dav=
id Woodhouse)
1797de7f82: hw/xen: Fix memory leak in libxenstore_open() for Xen (David Wo=
odhouse)
903c71251b: hw/mips/malta: Fix the malta machine on big endian hosts (Thoma=
s Huth)
454d4e4380: s390x/tcg: Fix CPU address returned by STIDP (Ilya Leoshkevich)
5cd229064a: tests/tcg/s390x: Test MXDB and MXDBR (Ilya Leoshkevich)
1b4417178e: target/s390x: Fix MXDB and MXDBR (Ilya Leoshkevich)
373cc0f3b5: tests/tcg/s390x: Test single-stepping SVC (Ilya Leoshkevich)
9b7c1e431e: linux-user/s390x: Fix single-stepping SVC (Ilya Leoshkevich)
0a3a9ae1f2: tests/tcg/s390x: Test LOCFHR (Ilya Leoshkevich)
0d4bced374: target/s390x: Fix LOCFHR taking the wrong half of R2 (Ilya Leos=
hkevich)
8776c6cf6a: tests/tcg/s390x: Test LCBB (Ilya Leoshkevich)
76d4eb3a5e: target/s390x: Fix LCBB overwriting the top 32 bits (Ilya Leoshk=
evich)
6a9f9e6499: tests/tcg/s390x: Test EXECUTE of relative branches (Ilya Leoshk=
evich)
f81a5d6863: target/arm: Explicitly select short-format FSR for M-profile (P=
eter Maydell)
505f0c68c9: hw/arm/xlnx-zynqmp: fix unsigned error when checking the RPUs n=
umber (Cl=C3=A9ment Chigot)
cdda1ce158: hw/dma/xilinx_axidma: Check DMASR.HALTED to prevent infinite lo=
op. (Tommy Wu)
bc8e883065: ui/sdl2: disable SDL_HINT_GRAB_KEYBOARD on Windows (Volker R=C3=
=BCmelin)
e0968d21e2: ui/sdl2: Grab Alt+F4 also under Windows (Bernhard Beschow)
772a83c6db: ui/sdl2: Grab Alt+Tab also in fullscreen mode (Bernhard Beschow)
9e36edcf03: ui/dbus: fix compilation when GBM && !OPENGL (Marc-Andr=C3=A9 L=
ureau)
e0baf24b4a: ui/sdl2: fix surface_gl_update_texture: Assertion 'gls' failed =
(Marc-Andr=C3=A9 Lureau)
eef92fac91: ui/gtk-egl: fix scaling for cursor position in scanout mode (Er=
ico Nunes)
7fd387715b: ui/gtk: use widget size for cursor motion event (Erico Nunes)
76b7002ec7: ui/gtk: fix passing y0_top parameter to scanout (Erico Nunes)
880f7d12be: hw/ppc/prep: Fix wiring of PIC -> CPU interrupt (Bernhard Besch=
ow)
864ce70c1c: target/ppc: Fix fallback to MFSS for MFFS* instructions on pre =
3.0 ISAs (Richard Purdie)
25b846c85e: scripts/device-crash-test: Add a parameter to run with TCG only=
 (Thomas Huth)
eca6ebee52: gitlab-ci: Avoid to re-run "configure" in the device-crash-test=
 jobs (Thomas Huth)

