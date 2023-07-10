Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD0774DE76
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 21:47:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIwqJ-0007eQ-TN; Mon, 10 Jul 2023 15:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qIwqH-0007eD-9y; Mon, 10 Jul 2023 15:46:41 -0400
Received: from mail-mw2nam12on20619.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::619]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qIwqF-0005Hn-7z; Mon, 10 Jul 2023 15:46:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mA++bfgwq8E8jGEZ6iBgIeZUIxSds8646AOOxCdOoYWjuZDG0LIOsC1EWMngNOOD5n+0RkzsFJFOM5cE/bsIyJS6YtwKua2dSflo4a7BTimoh3CEA8Ouf84FznRBZHjyQvg1kg/RBzv9I9z7eDcgmRtpt2JhdAeg555Bm8VR5lv1vLv09nN3KhdU8r0GQWspmTfomtfcenm0yWito6cSkoxx7q0ZNg6l3yvKszZ7h/2GAr77iximbkS4NsjfTnuZmoRAQbCQ7+obzAwTtgyHJl2JfTk+lyL3y1SV5P5Cjm6IUiFkHaIoQL4+2kMpxH6n2OEpvL35s2lZwuSPdX3yWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4oAllBcFojiXgvjQbgC+P3klg9CFpPHRaDCOFnc1ns=;
 b=H9ePmxSqlzMMQHr/sQfFw6HMixe1hDueqg+8eGjFN2/Io/cplDTLZnJI/Olc0glk8rAirzfBWywAFTV/NLbU3ff73KhdAHVxxJD4zCzcootbXwH/DXwmz1oq+QMhgyO1lWheL70SZOIciO9upT8sypJHvCL9PM0lv34Q+j34UlECQCyFWxDLrpSRP58QUaIghe9P+Dn2YSsEAOxm6cXYLsBVt0/0d87IuDquANofqcU9Sv3/EQWWniNijFp3eCe3HX5Ban7HYUvsUW052vCjySTNh95hZtHns4RAnX+pOnuKx+rukfqXL9P8uHStYRulsC2i1QOJAP0/9wNlFJ8CEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4oAllBcFojiXgvjQbgC+P3klg9CFpPHRaDCOFnc1ns=;
 b=oNU0zri1C1JuaCLUvzIuhlIrdNbp6/FAz7PL3OOqcar1NWyyBDdTj627hWsX2J7ALxKjQ405asOyO0WVBk4l9xQkJZVH/weMTF4iuClvN/TJTogISQ9jcEWLiLdmrS3wxPo5835quBvTyUxkK0+xylFEBSSFnDk/IubuPjV3poM=
Received: from SJ0PR13CA0125.namprd13.prod.outlook.com (2603:10b6:a03:2c6::10)
 by SA3PR12MB9180.namprd12.prod.outlook.com (2603:10b6:806:39b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 19:46:33 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c6:cafe::d6) by SJ0PR13CA0125.outlook.office365.com
 (2603:10b6:a03:2c6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.18 via Frontend
 Transport; Mon, 10 Jul 2023 19:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Mon, 10 Jul 2023 19:46:32 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 14:46:31 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 7.2.4 Stable released
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-stable@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 10 Jul 2023 14:40:51 -0500
Message-ID: <168901805135.1031679.12220399865315172887@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|SA3PR12MB9180:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f403152-cea4-4611-939c-08db817e5cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dFJ70VUcyDibFy/vcmRDk+u+g6FwkjVPJFJDdH7kN9IxQ0En4rViOgVnlZQFgVF3dPT2hpdIJinTG3fGlqfX1I6jRLIBs5UIqN7opp071Mp46mUnpxyM0WK7ex9c4AcB4zUM/LOgtvdIEUxyJpOgx9lf43Ow2DaXb3EIoeRTbksIJZUQ9tYIiSFE7NdPYicAWlVtf8JXYob2jNqKaUGdFvnrXtfMI4mG55bhIWVEF5tF7EFHvhCiCxkzBFU+ckx4ZVlKpeV0UQOIySLf+XecjBE6RRLTUzhG8CsWwTlu/0S4sBz+I8meFCNXlVz2kL6bpctVPtj360gv2NyJ1ZgEpLyZz/vI6gYSdEArJkPf8erCHwM3kMkHnt9IIyptDjLAReNTqDNz6ig0mbxlSOPtgor/5/uV9XJouJHyhly5hMZEUvy6X36EkONHaCzUPjXvI8xlSU3qAePOYfZpFJ8Jdfj0NL82hVtJDma1HJhAsB3k1UZay0CsqnlAAVJsuY/gc/GRGfNuEgeBiOTvkRM9HR0L96/w8vv8aUFKoy+OljQt7vb5fr26CIWNTOK+gRXm6IpcDj1zXbOX+LRE3P/9Q99WMTcr8moAWxMubVI73TyAiIFNdbetdtLFb3IGbM9GCWr+0W4+J5zo/JXqlbi65kDAY6gp0OwtQ7YzFKA65EyonEOS0o/jBAgfuK0MORn8sk9VbKR1qZk+3SgomtdHqCdtQR7SNk3GTwK8Be+REdRFQX2cYL93v4jWDFI1XtEN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(186003)(26005)(16526019)(2616005)(966005)(36860700001)(336012)(66574015)(83380400001)(47076005)(426003)(41300700001)(4326008)(6916009)(316002)(2906002)(5660300002)(8676002)(44832011)(8936002)(478600001)(6666004)(54906003)(70586007)(70206006)(40480700001)(36756003)(356005)(81166007)(82740400003)(86362001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 19:46:32.5447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f403152-cea4-4611-939c-08db817e5cde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9180
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::619;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

I am pleased to announce that the QEMU v7.2.4 stable release is now
available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

v7.2.4 is now tagged in the official qemu.git repository, and the
stable-7.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-7.2?ref_type=3Dheads

This update contains general fixes for various architectures/subsystems,
including the following CVE fixes:

    9pfs (CVE-2023-2861)
    vhost-vdpa (CVE-2023-3301)

Please see the changelog for additional details and update accordingly.

Thank you to everyone involved!

CHANGELOG:

681858ea14: Update version for 7.2.4 release (Michael Tokarev)
5cc60b67d3: ui/gtk: set the area of the scanout texture correctly (Dongwon =
Kim)
3b1b9aa4d5: vfio/pci: Call vfio_prepare_kvm_msi_virq_batch() in MSI retry p=
ath (Shameer Kolothum)
c7b6b705ef: vfio/pci: Fix a segfault in vfio_realize (Zhenzhong Duan)
4d8459c365: target/ppc: Fix decrementer time underflow and infinite timer l=
oop (Nicholas Piggin)
78c4994e94: vdpa: mask _F_CTRL_GUEST_OFFLOADS for vhost vdpa devices (Eugen=
io P=C3=A9rez)
f8e3b3290c: icount: don't adjust virtual time backwards after warp (Nichola=
s Piggin)
44acbc7736: virtio-gpu: Make non-gl display updates work again when blob=3D=
true (Vivek Kasireddy)
3d12598b74: vhost-vdpa: do not cleanup the vdpa/vhost-net structures if pee=
r nic is present (Ani Sinha)
bc1a3a1774: vdpa: fix not using CVQ buffer in case of error (Eugenio P=C3=
=A9rez)
f3b7f02c3b: vhost: release memory_listener object in error path (Prasad Pan=
dit)
b3a003c890: target/hppa: Update to SeaBIOS-hppa version 8 (Helge Deller)
7b7474947f: target/hppa: New SeaBIOS-hppa version 7 (Helge Deller)
51c48a919d: target/hppa: Provide qemu version via fw_cfg to firmware (Helge=
 Deller)
6331b12d60: target/hppa: Fix OS reboot issues (Helge Deller)
601f084ef7: pc-bios/keymaps: Use the official xkb name for Arabic layout, n=
ot the legacy synonym (Peter Maydell)
29191ea6a5: host-utils: Avoid using __builtin_subcll on buggy versions of A=
pple Clang (Peter Maydell)
04de6cb002: hw/timer/nrf51_timer: Don't lose time when timer is queried in =
tight loop (Peter Maydell)
09dd3f2cae: hw/intc/allwinner-a10-pic: Handle IRQ levels other than 0 or 1 =
(Peter Maydell)
d0040c60f7: target/arm: Return correct result for LDG when ATA=3D0 (Peter M=
aydell)
1bc596d079: target/arm: Fix return value from LDSMIN/LDSMAX 8/16 bit atomic=
s (Peter Maydell)
23315ad0b8: aspeed/hace: Initialize g_autofree pointer (C=C3=A9dric Le Goat=
er)
4fc28bf08a: hw/riscv: qemu crash when NUMA nodes exceed available CPUs (Yin=
 Wang)
6e979dba56: target/ppc: Fix PMU hflags calculation (Nicholas Piggin)
8e57e02ff8: target/ppc: Fix nested-hv HEAI delivery (Nicholas Piggin)
d31e0a3843: target/ppc: Fix lqarx to set cpu_reserve (Nicholas Piggin)
9b55660e4a: vnc: move assert in vnc_worker_thread_loop (Anastasia Belova)
8eb73afedc: hw/remote: Fix vfu_cfg trace offset format (Mattias Nissler)
10fad73a2b: 9pfs: prevent opening special files (CVE-2023-2861) (Christian =
Schoenebeck)
07e7102b8e: qga: Fix suspend on Linux guests without systemd (Mark Somervil=
le)
8e84a20705: docs: fix multi-process QEMU documentation (Jagannathan Raman)
03727054dc: s390x/tcg: Fix CPU address returned by STIDP (Ilya Leoshkevich)
c06ca3aa33: tests/tcg/s390x: Test single-stepping SVC (Ilya Leoshkevich)
5502e5ca33: linux-user/s390x: Fix single-stepping SVC (Ilya Leoshkevich)
82fc148344: tests/tcg/s390x: Test LOCFHR (Ilya Leoshkevich)
cc271aa410: target/s390x: Fix LOCFHR taking the wrong half of R2 (Ilya Leos=
hkevich)
242efaca9e: tests/tcg/s390x: Test LCBB (Ilya Leoshkevich)
347714a28c: target/s390x: Fix LCBB overwriting the top 32 bits (Ilya Leoshk=
evich)
7cba3a05b5: target/arm: Explicitly select short-format FSR for M-profile (P=
eter Maydell)
f82dcd73e8: hw/arm/xlnx-zynqmp: fix unsigned error when checking the RPUs n=
umber (Cl=C3=A9ment Chigot)
fee86f6c5b: hw/dma/xilinx_axidma: Check DMASR.HALTED to prevent infinite lo=
op. (Tommy Wu)
22048b1bff: ui/sdl2: disable SDL_HINT_GRAB_KEYBOARD on Windows (Volker R=C3=
=BCmelin)
70237e2159: ui/sdl2: Grab Alt+F4 also under Windows (Bernhard Beschow)
6520bf66f4: ui/sdl2: Grab Alt+Tab also in fullscreen mode (Bernhard Beschow)
d4d91ae902: ui/sdl2: fix surface_gl_update_texture: Assertion 'gls' failed =
(Marc-Andr=C3=A9 Lureau)
b15e44adeb: ui/gtk-egl: fix scaling for cursor position in scanout mode (Er=
ico Nunes)
95c9059e66: ui/gtk: use widget size for cursor motion event (Erico Nunes)
b201fb8c5a: ui/gtk: fix passing y0_top parameter to scanout (Erico Nunes)
834fc12721: hw/ppc/prep: Fix wiring of PIC -> CPU interrupt (Bernhard Besch=
ow)
369e2c4e2d: scripts/device-crash-test: Add a parameter to run with TCG only=
 (Thomas Huth)
509c444bac: gitlab-ci: Avoid to re-run "configure" in the device-crash-test=
 jobs (Thomas Huth)

