Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B54837FCB7E
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 01:37:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r88Yj-0008M7-Ai; Tue, 28 Nov 2023 19:36:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1r88Yh-0008L6-FN
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 19:36:07 -0500
Received: from mail-dm6nam10on2051.outbound.protection.outlook.com
 ([40.107.93.51] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1r88Yb-0001XQ-Q6
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 19:36:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNwTqQwaIYjcRssVjQTkTBLuEfwgIAe4OPVDfD9yHo9kDmCmCGWVfAGObZKBW4uKLc3A6p3ztk1bVqhz+EocN7ZbHc3XHaX1VYf2xR3M0mjwXyvXn86xoV/IeNmLHnwJO+dXUXJZZd7gViEMF97GXhIvbB0a3vhhRSBQFsYabYJ7BulDkAnlTHVT7Ivp3+6pYITUAVMO5fefJXJHs3dnY+x5TPc0nzjl0dGDvB3i41VX5ZUF92VMy6y9UbgvGZkZPlwaRKSkNTf3ERAwhsvQ6L82/UpcTg3q/TMVt4Om8nN7f57rb/pWcvuDOvh+foH8kFtpYaeM8JYcrgukrmJmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwLtYvjlizrQ8vy1E3hYp9bcYxD3sTpktoBJ/0x2zSQ=;
 b=mw1jDGvC3JOz3WjeGVYwjnyQ6D1UVy5UMUwCc/mnLI1OIN/1fN6SlmV9Z8bgnbkHwqOK+eESyv0iaBhjAc7OYKRDvcER28SutBE00Uk1y8CRD6yAYhVqsmLqeyT5bkWwu/rVD8sG5TcHYsmnrNKpVGuT2wTy25dPvohZJvmUd450nLFvZv6hCB9TnWaYMuWhbP+yOOoJKGphjzqw5mnREjuXbO5t2FZC50ORrpS4plvvAy9e/jlWW8ZTo51Ca6aNCTMUb96juHBs0JRYna9lKNHXVmjH2Rp3fdT1HcDrm3CSPoaRsVafRcb7rWPbHbUDxGKuhV6peu6OKE2R2McOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwLtYvjlizrQ8vy1E3hYp9bcYxD3sTpktoBJ/0x2zSQ=;
 b=CmrFh9VgOfWSfXlpA2hLOkSfk+FrnTrB9zwo6kqiYzxvvHVL5dK6pOWH9vCXqn9tylo1B8hOJ8EKBE6kE7YeK4Ghrbr+FVsTttCoN2i7RvP3Ntm0nzyQICgSWc6CFmETl5sso4hb1YeTHNDccOJUwLr3sOYYH8r2f8LIpzwb20w=
Received: from DS7PR05CA0083.namprd05.prod.outlook.com (2603:10b6:8:57::29) by
 PH7PR12MB5711.namprd12.prod.outlook.com (2603:10b6:510:1e2::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.27; Wed, 29 Nov 2023 00:30:54 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::99) by DS7PR05CA0083.outlook.office365.com
 (2603:10b6:8:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 00:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 00:30:54 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 28 Nov
 2023 18:30:53 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 8.2.0-rc2 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <stefanha@redhat.com>
Date: Tue, 28 Nov 2023 18:30:38 -0600
Message-ID: <170121783801.751264.4259803758204195675@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|PH7PR12MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a6e4c1b-65ba-4c33-9974-08dbf0727282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wl54DdQuSEFEmFRsc+/QCF9QnGntmz29D4P1Fig5nEsNmphMYfSD7yTnmt1wAbfg5yZ7qJ3NLAnwH2JNjtRuuFMOzoQUGYaBZpugruh/dwU4Y8KnbiZ1BDaZUdzOnL7rDiSCZeVoVwKWHKGfodqlcLZ85Xz6KBC9nI3e7BV1NPkJWJwHwAAVhHdvwBEMyaq7Q9MX8OfojJt/RB8t2fF3T6auooclDmVvGSVR2Wti8YohyXO8Hv9s7Aq7JVOLZ0rDUkxcVDn0ZQl+GhicYskHC9b5FUaJNkt2JFiNPDK5s71DFCnxiJuoA3syJg9XFk+QILhlXwqLNdgeHa3lPXYHsHtNfkXLjDf3Bb+kB6gBbPItaV6pjqlMtQteopTd6jkJVzu3ouQ/OwA6g+I4JikJOrOUU/LTzZO+HkAbHnZhFaUxwayJj4u2UCcamrLBD6g5siEzx4Xu8eV7mduLPMSil+wc3V5vzrUgw3ouRAu3yeybZKyf1FLCXM/9eJt7S5maJURPMMe/iP2qQ+06L4QVzbXZ5BH8Ow5NNzLTMSOmYMDuL/7JD0ywc2zgtUrqVfDayRUtbaed14SpQ1x6yNRsG6ikxsu5D+zVBj++Pk71ecojhZIMomqn0nU7LMUIT59Kk36tCU22VkyXejh61tMOKn+hyI8QRMlyiIANwkn2juvYZrPxTgagpZrfDTITenLLDrTC4K2rDQFgTU+d/Opk0UzrS4dHOqopu5UBpedFAfHl6ptALmPa0kHtGZ4365f1WLR42AWl52KQPgLj5uA79XNxo41DIR2nGjp0A3AmMNmmetjLdH/mmydy72+VQyL0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230273577357003)(230922051799003)(230173577357003)(64100799003)(82310400011)(1800799012)(186009)(451199024)(40470700004)(36840700001)(46966006)(966005)(6666004)(478600001)(2616005)(16526019)(47076005)(5660300002)(83380400001)(426003)(336012)(2906002)(70586007)(40460700003)(8936002)(316002)(8676002)(70206006)(4326008)(6916009)(44832011)(82740400003)(36756003)(81166007)(36860700001)(86362001)(356005)(66574015)(41300700001)(40480700001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 00:30:54.0375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6e4c1b-65ba-4c33-9974-08dbf0727282
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5711
Received-SPF: softfail client-ip=40.107.93.51;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
third release candidate for the QEMU 8.2 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-8.2.0-rc2.tar.xz
  http://download.qemu.org/qemu-8.2.0-rc2.tar.xz.sig

You can help improve the quality of the QEMU 8.2 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/10

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/8.2

Please add entries to the ChangeLog for the 8.2 release below:

  http://wiki.qemu.org/ChangeLog/8.2

Thank you to everyone involved!

Changes since rc1:

abf635ddfe: Update version for v8.2.0-rc2 release (Stefan Hajnoczi)
6e081324fa: ide/via: Fix BAR4 value in legacy mode (BALATON Zoltan)
411132c979: export/vhost-user-blk: Fix consecutive drains (Kevin Wolf)
9fb7b350ba: vmdk: Don't corrupt desc file in vmdk_write_cid (Fam Zheng)
3b7094fe83: iotests: fix default machine type detection (Andrey Drobyshev)
0180a74463: docs/s390: Fix wrong command example in s390-cpu-topology.rst (=
Zhao Liu)
235948bf53: hw/avr/atmega: Fix wrong initial value of stack pointer (Gihun =
Nam)
0ed083a1bc: hw/audio/via-ac97: Route interrupts using via_isa_set_irq() (BA=
LATON Zoltan)
01f13ee245: hw/isa/vt82c686: Route PIRQ inputs using via_isa_set_irq() (BAL=
ATON Zoltan)
032a443be6: hw/usb/vt82c686-uhci-pci: Use ISA instead of PCI interrupts (BA=
LATON Zoltan)
7e01bd80c1: hw/isa/vt82c686: Bring back via_isa_set_irq() (BALATON Zoltan)
57c3150acc: target/hexagon/idef-parser/prepare: use env to invoke bash (Sam=
uel Tardieu)
ea7ec158c1: string-output-visitor: Support lists for non-integer types (Kev=
in Wolf)
50571883f6: qdev: Fix crash in array property getter (Kevin Wolf)
eb0ce1346e: seabios: update binaries to 1.16.3 release (Gerd Hoffmann)
3161f9f40e: seabios: update submodule to 1.16.3 release (Gerd Hoffmann)
1ee80592bf: hw/dma/xlnx_csu_dma: don't throw guest errors when stopping the=
 SRC DMA (Frederic Konrad)
a9bc470ec2: hw/misc, hw/ssi: Fix some URLs for AMD / Xilinx models (Frederi=
c Konrad)
90bb6d6764: hw/ssi/xilinx_spips: fix an out of bound access (Frederic Konra=
d)
6e782ffd55: hw/input/stellaris_gamepad: Free StellarisGamepad::keycodes[] a=
rray (Philippe Mathieu-Daud=C3=A9)
4f10c66077: hw/nvram/xlnx-efuse-ctrl: Free XlnxVersalEFuseCtrl[] "pg0-lock"=
 array (Philippe Mathieu-Daud=C3=A9)
49b3e28b7b: hw/nvram/xlnx-efuse: Free XlnxEFuse::ro_bits[] array on finaliz=
e() (Philippe Mathieu-Daud=C3=A9)
896dd6ff7b: hw/misc/mps2-scc: Free MPS2SCC::oscclk[] array on finalize() (P=
hilippe Mathieu-Daud=C3=A9)
c9a4aa06df: hw/virtio: Free VirtIOIOMMUPCI::vdev.reserved_regions[] on fina=
lize() (Philippe Mathieu-Daud=C3=A9)
837053a7f4: hw/virtio: Add VirtioPCIDeviceTypeInfo::instance_finalize field=
 (Philippe Mathieu-Daud=C3=A9)
8729856c19: hw/net/can/xlnx-zynqmp: Avoid underflow while popping RX FIFO (=
Philippe Mathieu-Daud=C3=A9)
75d0e6b5c6: hw/net/can/xlnx-zynqmp: Avoid underflow while popping TX FIFOs =
(Philippe Mathieu-Daud=C3=A9)
8d37a1425b: target/arm: Handle overflow in calculation of next timer tick (=
Peter Maydell)
11a3c4a286: target/arm: Set IL bit for pauth, SVE access, BTI trap syndrome=
s (Peter Maydell)
7e5b19793d: build-sys: fix meson project version usage (Marc-Andr=C3=A9 Lur=
eau)
81a541e9f0: scripts: adjust url to Coverity tools (Paolo Bonzini)
9abbb37535: configure: Make only once with pseudo-"in source tree" builds (=
Akihiko Odaki)
cd9113633f: system: Use &error_abort in memory_region_init_ram_[device_]ptr=
() (Philippe Mathieu-Daud=C3=A9)
2037a73997: disas/cris: Pass buffer size to format_dec() to avoid overflow =
warning (Philippe Mathieu-Daud=C3=A9)
e4b9d1999c: audio: Free consumed default audio devices (Akihiko Odaki)
541069e653: .gitlab-ci.d/cirrus: Add manual testing of macOS 14 (Sonoma) (P=
hilippe Mathieu-Daud=C3=A9)
1a1e889f35: buildsys: Bump known good meson version to v1.2.3 (Philippe Mat=
hieu-Daud=C3=A9)
6dc8a88785: docs: document what configure does with virtual environments (P=
aolo Bonzini)
913e47cb6b: tests: respect --enable/--disable-download for Avocado (Paolo B=
onzini)
adff55b520: coverity: physmem: use simple assertions instead of modelling (=
Vladimir Sementsov-Ogievskiy)
6ef164188d: tests/tcg: finesse the registers check for "hidden" regs (Alex =
Benn=C3=A9e)
c2118e9e1a: configure: don't try a "native" cross for linux-user (Alex Benn=
=C3=A9e)
8848c52967: tests/tcg: enable semiconsole test for Arm (Alex Benn=C3=A9e)
56611e17d2: tests/tcg: enable arm softmmu tests (Alex Benn=C3=A9e)
e8368b1c95: testing: move arm system tests into their own folder (Alex Benn=
=C3=A9e)
575aac007c: hw/core: skip loading debug on all failures (Alex Benn=C3=A9e)
84dd7d88c9: docs/system: clarify limits of using gdbstub in system emulatio=
n (Alex Benn=C3=A9e)
ef073ebd32: docs/emulation: expand warning about semihosting (Alex Benn=C3=
=A9e)
1be75e24e8: tests/tcg: fixup Aarch64 semiconsole test (Alex Benn=C3=A9e)
9997771bc1: target/nios2: Deprecate the Nios II architecture (Philippe Math=
ieu-Daud=C3=A9)
4789f9d3a1: plugins: fix win plugin tests on cross compile (Greg Manning)
8e721c3277: tests/docker: merge debian-native with debian-amd64 (Alex Benn=
=C3=A9e)
7528ef7321: .gitlab-ci.d/cirrus: Upgrade macOS to 13 (Ventura) (Philippe Ma=
thieu-Daud=C3=A9)
aa5730b07e: tests/docker: replace fedora-i386 with debian-i686 (Daniel P. B=
errang=C3=A9)
6bca4d7d1f: target/riscv/cpu_helper.c: Fix mxr bit behavior (Ivan Klokov)
82d53adfbb: target/riscv/cpu_helper.c: Invalid exception on MMU translation=
 stage (Ivan Klokov)
a7472560ca: riscv: Fix SiFive E CLINT clock frequency (Rom=C3=A1n C=C3=A1rd=
enas)
9bbf03275e: target/riscv: don't verify ISA compatibility for zicntr and zih=
pm (Cl=C3=A9ment Chigot)
7a87ba8956: hw/riscv/virt.c: do create_fdt() earlier, add finalize_fdt() (D=
aniel Henrique Barboza)
301c65f49f: linux-user/riscv: Add Zicboz block size to hwprobe (Palmer Dabb=
elt)
69c224816e: target/hppa: Update SeaBIOS-hppa to version 13 (Helge Deller)

