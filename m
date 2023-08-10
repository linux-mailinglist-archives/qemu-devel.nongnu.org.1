Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 293E37783E8
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 01:02:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUEfT-0007Lt-2v; Thu, 10 Aug 2023 19:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qUEfJ-0007Jo-3F
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 19:02:01 -0400
Received: from mail-dm6nam11on20628.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::628]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qUEfE-0001bO-T4
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 19:02:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNbHx8j0OzAsJaFhXrQW28k0x1QHdNqYBgxG6RioqjFR7ojirD70eKp2TfWzBJYkTqXouum2RZolzInp8vmZzBELJJaJ9HrJusWSWtctKcwVgg9gdbl9zZLJ6yd7FEjzcooySw/QL6VpYjSIwsTsX1ax5BM+MuZVmFelz+GxgF/ShX2B5AHeNTAD6L9/SZyhn7LZvqZuHryCAuMA485H1cxaLqCOfGCQcJRNkb/zaNqi1k2SvI9T6FZMC3yS9gpFt06k5Ii3Pn0YEcVGI9LSkbblplkgYDD/41XaRFwf+mGgQ9fQVhPQ3B9VsENSiArp+OX4J1qIAo+q7sTtthaH+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+eXOaNkUCDsnl52nCT7Kc2GDzy7sLJVEGQXKX7faEQ=;
 b=dO/hdIRPLZdkJKtDGjO6XtTR7y1c0oY9y3DkweExgT+p5/8l3RDsZZ//D6fm7YG2YirJIhUi+EFkZg7zfIdx4PVEGD83sPGN6uliQeua/wA3u5hPAn3nv13DkdYSnuJriGieFDVisy5W/tXjySPv3mLIFYvCdaQs25GEcxNutQnpxmaARYqIMNH/fanW5sYQGVbSiVXPUwhE486N14Wy/LUlcC02v76XSL7IH4dJvCkDgzQ3bmfE1ZPJnzr8E+Rvihf6gANZJtNHHHDijO1ttIJWF4b8LptHbpklYvExdhzhlsV45c+peJS2nfM79LEfhgoNq7klttcHlGr1H4DImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+eXOaNkUCDsnl52nCT7Kc2GDzy7sLJVEGQXKX7faEQ=;
 b=CPy9gTPLgHuUPcnxYgx6Oqk4rLGwePGjuqC7wc2hsITlTD5fViTYxJYnf7amSzTcWM7/9Tsfhd/rDf983xCKnIMTF4DvvUwTdRqdSmQTNSuKZnBQNDnPl2mSBcaG8oR2IflQlw5Z/zVCOMHJAB1qfHbxALVRHXyai00xOIpwgy0=
Received: from SN6PR16CA0048.namprd16.prod.outlook.com (2603:10b6:805:ca::25)
 by PH7PR12MB8179.namprd12.prod.outlook.com (2603:10b6:510:2b8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Thu, 10 Aug
 2023 23:01:50 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:805:ca:cafe::98) by SN6PR16CA0048.outlook.office365.com
 (2603:10b6:805:ca::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 23:01:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Thu, 10 Aug 2023 23:01:49 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 18:01:49 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 8.1.0-rc3 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 Aug 2023 18:01:33 -0500
Message-ID: <169170849360.1284588.17345479867838912547@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|PH7PR12MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: cf0b03c7-3a12-4217-6d72-08db99f5c7bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/SvOwZv9SsSAY0bpY//S/0PJbu1oTZ9YD69brY/FUG4n6PUfOP4Zu/J1sDKpJWo/N4K0v+tZJ2y4IEcciYOpWigLcfAUieaE6gSr8dfkMcYW2CblDkAkAMs2vcGrV+o+ZTXLwDXpuhZ++KosvU0mn0f2iWQKc7qWHZdPpv5SEtzb6ZbuXviTEELdr8pl4+UkruvbdQXtX6nk61ho3uUsmkexfQLAvLHVaF2Aif8FCTtppuyCfLb4Jp8E/uGg36jlnbfCSEfd88GSS+jF78zHPxCqjysO+g+maqieJYg7/RANxU8JyNHYiMXXbRmbBd1RuK1ob3tLU1jqnnb9Emqus8LLzFEeaAFPV186e731XozGs/+Es2fM//+qDPC0gqEPlqWpghP2pTRAew/psYVr7deSgXAlLpiZ7/zSyM2LJ6nFkWU29V/UB7sfhLcAyN0Vq8sP60vvHl9FDD/7eHqxKeY6ROMEQh6TaCMOLyCw72WVR/Joyr3H2Me3ellfiB1EBRpQfQUp1KMp1JiBzIlOG2XDivHlBF8IrhC/K+GCTCQsWjZ7knD1XVH/uAhw8LDRUJInSnlo5mjpgjvxjDF9zHmxHTfj16X1/jZOFWy61Bgr5qBDVwiePGriwf9fJK6gIdGDosPde3qdywaROLi82v6CsPbgJSX7eWO9TfSsAvlMlLlkucE2vGBrDSn8cVZeldp7vkt1cNEJak3bbIvC6rsACQgMOEJCQJoXHSzrl72A59HG+Gd3flwwcFpRu6y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(186006)(82310400008)(451199021)(1800799006)(40470700004)(36840700001)(46966006)(2616005)(26005)(36756003)(966005)(6666004)(478600001)(16526019)(81166007)(82740400003)(336012)(70206006)(356005)(70586007)(6916009)(316002)(41300700001)(66574015)(426003)(8936002)(5660300002)(8676002)(44832011)(40460700003)(4326008)(36860700001)(2906002)(83380400001)(86362001)(40480700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 23:01:49.9484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0b03c7-3a12-4217-6d72-08db99f5c7bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8179
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::628;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
fourth release candidate for the QEMU 8.1 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-8.1.0-rc3.tar.xz
  http://download.qemu.org/qemu-8.1.0-rc3.tar.xz.sig

You can help improve the quality of the QEMU 8.1 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/8#tab-issues

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/8.1

Please add entries to the ChangeLog for the 8.1 release below:

  http://wiki.qemu.org/ChangeLog/8.1

Thank you to everyone involved!

Changes since rc2:

3944e93af0: Update version for v8.1.0-rc3 release (Richard Henderson)
f1b0f894c8: gdbstub: don't complain about preemptive ACK chars (Alex Benn=
=C3=A9e)
3869eb7eee: gdbstub: more fixes for client Ctrl-C handling (Alex Benn=C3=A9=
e)
dad1036f43: tests/tcg: ensure system-mode gdb tests start stopped (Alex Ben=
n=C3=A9e)
6a2c23ddeb: accel/tcg: Avoid reading too much in load_atom_{2,4} (Richard H=
enderson)
b8002058c4: linux-user: Fix openat() emulation to correctly detect accesses=
 to /proc (Helge Deller)
47d1e98231: util/interval-tree: Check root for null in interval_tree_iter_f=
irst (Helge Deller)
1b65895ddd: tests/tcg: Disable filename test for info proc mappings (Richar=
d Henderson)
a05cee93f4: linux-user: Use ARRAY_SIZE with bitmask_transtbl (Richard Hende=
rson)
9ab8d07149: linux-user: Split out do_mmap (Richard Henderson)
3439ba9c5d: hw/nvme: fix null pointer access in ruh update (Klaus Jensen)
6c8f8456cb: hw/nvme: fix null pointer access in directive receive (Klaus Je=
nsen)
c42e77a90d: qemu/osdep: Remove fallback for MAP_FIXED_NOREPLACE (Richard He=
nderson)
dd55885516: linux-user: Rewrite non-fixed probe_guest_base (Richard Henders=
on)
06f38c6688: linux-user: Rewrite fixed probe_guest_base (Richard Henderson)
0c441aeb39: linux-user: Consolidate guest bounds check in probe_guest_base =
(Richard Henderson)
435c042fdc: linux-user: Remove duplicate CPU_LOG_PAGE from probe_guest_base=
 (Richard Henderson)
3ce3dd8ca9: util/selfmap: Rewrite using qemu/interval-tree.h (Richard Hende=
rson)
5f4e5b3409: linux-user: Use zero_bss for PT_LOAD with no file contents too =
(Richard Henderson)
2d385be615: linux-user: Do not adjust zero_bss for host page size (Richard =
Henderson)
e3d97d5c5d: linux-user: Do not adjust image mapping for host page size (Ric=
hard Henderson)
1f356e8c01: linux-user: Adjust initial brk when interpreter is close to exe=
cutable (Helge Deller)
1ea06ded0d: linux-user: Use elf_et_dyn_base for ET_DYN with interpreter (Ri=
chard Henderson)
ad25051bae: linux-user: Use MAP_FIXED_NOREPLACE for initial image mmap (Ric=
hard Henderson)
da2b71fab6: linux-user: Define ELF_ET_DYN_BASE in $guest/target_mman.h (Ric=
hard Henderson)
2d708164e0: linux-user: Define TASK_UNMAPPED_BASE in $guest/target_mman.h (=
Richard Henderson)
c8fb5cf97d: linux-user: Adjust task_unmapped_base for reserved_va (Richard =
Henderson)
971fac2731: configure: unify case statements for CPU canonicalization (Paol=
o Bonzini)
50a0012227: linux-user: cleanup unused linux-user/include/host directories =
(Paolo Bonzini)
f140823c56: configure: fix detection for x32 linux-user (Paolo Bonzini)
ec5a138ce6: docs: update hw/nvme documentation for protection information (=
Ankit Kumar)
dbdb13f931: hw/nvme: fix CRC64 for guard tag (Ankit Kumar)
58ea90f803: ui/gtk: set scanout mode in gd_egl/gd_gl_area_scanout_texture (=
Dongwon Kim)
fdd649538e: hw/i386/vmmouse:add relative packet flag for button status (Zon=
gmin Zhou)
8a64609eea: dump: kdump-zlib data pages not dumped with pvtime/aarch64 (Don=
gli Zhang)
a41e2d97f9: virtio-gpu: reset gfx resources in main thread (Marc-Andr=C3=A9=
 Lureau)
957d77863e: virtio-gpu: free BHs, by implementing unrealize (Marc-Andr=C3=
=A9 Lureau)
81cd34a359: chardev: report the handshake error (Marc-Andr=C3=A9 Lureau)
6ee960823d: Fixed incorrect LLONG alignment for openrisc and cris (Luca Bon=
issi)
beb1a91781: stubs/colo.c: spelling (Michael Tokarev)
8ada214a90: hw/i2c: Fix bitbang_i2c_data trace event (BALATON Zoltan)
6a33f2e920: hw/nvme: fix compliance issue wrt. iosqes/iocqes (Klaus Jensen)
ecb1b7b082: hw/nvme: fix oob memory read in fdp events log (Klaus Jensen)
3c4a8a8fda: bsd-user: Remove last_brk (Richard Henderson)
62cbf08150: linux-user: Remove last_brk (Richard Henderson)
0662a626a7: linux-user: Properly set image_info.brk in flatload (Richard He=
nderson)
2aea137a42: linux-user: Do not align brk with host page size (Akihiko Odaki)
cb9d5d1fda: linux-user: Do nothing if too small brk is specified (Akihiko O=
daki)
e69e032d1a: linux-user: Use MAP_FIXED_NOREPLACE for do_brk() (Akihiko Odaki)
c6cc059eca: linux-user: Do not call get_errno() in do_brk() (Akihiko Odaki)
ddcdd8c48f: linux-user: Fix MAP_FIXED_NOREPLACE on old kernels (Akihiko Oda=
ki)
c3dd50da0f: linux-user: Unset MAP_FIXED_NOREPLACE for host (Akihiko Odaki)
4333f0924c: linux-user/elfload: Set V in ELF_HWCAP for RISC-V (Nathan Egge)
89e5b7935e: configure: Fix linux-user host detection for riscv64 (Richard H=
enderson)
6c78de6eb6: gdbstub: use 0 ("any process") on packets with no PID (Matheus =
Tavares Bernardino)
c30d0b861c: accel/tcg: Call save_iotlb_data from io_readx as well (Mikhail =
Tyutin)
f7eaf9d702: accel/tcg: Do not issue misaligned i/o (Richard Henderson)
190aba803f: accel/tcg: Issue wider aligned i/o in do_{ld,st}_mmio_* (Richar=
d Henderson)
1966855e56: accel/tcg: Adjust parameters and locking with do_{ld,st}_mmio_*=
 (Richard Henderson)
0e2a3ec368: target/ppc: Fix VRMA page size for ISA v3.0 (Nicholas Piggin)
9915dac484: target/ppc: Fix pending HDEC when entering PM state (Nicholas P=
iggin)
9201af0969: target/ppc: Implement ASDR register for ISA v3.0 for HPT (Nicho=
las Piggin)
6b6d4c1a01: ppc/pegasos2: Fix reg property of 64 bit BARs in device tree (B=
ALATON Zoltan)
889dd6c525: ppc/pegasos2: Fix naming of device tree nodes (BALATON Zoltan)
aa1133475e: ppc/pegasos2: Fix reg property of ROM BARs (BALATON Zoltan)
19ac7b29f8: ppc/pegasos2: Fix reset state of USB functions (BALATON Zoltan)
d9ab1f1f4d: ci: install meson in CirrusCI KVM build environment (Paolo Bonz=
ini)
b2ea6450d8: target/i386: Check CR0.TS before enter_mmx (Matt Borgerson)
f8c0fd9804: target/hppa: Move iaoq registers and thus reduce generated code=
 size (Helge Deller)
15b11a1da6: cryptodev: Handle unexpected request to avoid crash (zhenwei pi)
9d38a84347: virtio-crypto: verify src&dst buffer length for sym request (zh=
enwei pi)
e1e56c07d1: include/hw/i386/x86-iommu: Fix struct X86IOMMU_MSIMessage for b=
ig endian hosts (Thomas Huth)
37cf5cecb0: hw/i386/x86-iommu: Fix endianness issue in x86_iommu_irq_to_msi=
_message() (Thomas Huth)
fcd8027423: hw/i386/intel_iommu: Fix index calculation in vtd_interrupt_rem=
ap_msi() (Thomas Huth)
4572b22cf9: hw/i386/intel_iommu: Fix struct VTDInvDescIEC on big endian hos=
ts (Thomas Huth)
642ba89672: hw/i386/intel_iommu: Fix endianness problems related to VTD_IR_=
TableEntry (Thomas Huth)
cc2a08480e: hw/i386/intel_iommu: Fix trivial endianness problems (Thomas Hu=
th)
18f2971ce4: vhost: fix the fd leak (Li Feng)
348e354417: pci: do not respond config requests after PCI device eject (Yur=
i Benditovich)
c92f4fcafa: virtio: Fix packed virtqueue used_idx mask (Hanna Czenczek)
92f0422137: hw/virtio: qmp: add RING_RESET to 'info virtio-status' (David E=
dmondson)
e3c79cf3ef: tests: acpi: update expected blobs (Igor Mammedov)
5ce869f788: acpi: x86: remove _ADR on host bridges (Igor Mammedov)
d3dc64f34d: tests: acpi: whitelist expected blobs (Igor Mammedov)
6e510855a9: tests: acpi: x86: update expected blobs (Igor Mammedov)
44d975ef34: x86: acpi: workaround Windows not handling name references in P=
ackage properly (Igor Mammedov)
45d9d318c8: tests: acpi: x86: whitelist expected blobs (Igor Mammedov)
63a3520e29: hw/virtio: Add a protection against duplicate vu_scmi_stop call=
s (Milan Zamazal)
1084feddc6: virtio-iommu: Standardize granule extraction and formatting (Er=
ic Auger)
503d86dd66: hw/pci-bridge/cxl_upstream.c: Use g_new0() in build_cdat_table(=
) (Peter Maydell)
cf2f89edf3: hw/virtio-iommu: Fix potential OOB access in virtio_iommu_handl=
e_command() (Eric Auger)
9b06d0d076: block/blkio: add more comments on the fd passing handling (Stef=
ano Garzarella)
0b054b4c82: block/blkio: close the fd when blkio_connect() fails (Stefano G=
arzarella)
f54ba56dad: gitlab: disable FF_SCRIPT_SECTIONS on msys jobs (Daniel P. Berr=
ang=C3=A9)
63f5365cd4: gitlab: disable optimization and debug symbols in msys build (D=
aniel P. Berrang=C3=A9)
ff136d2a99: configure: support passthrough of -Dxxx args to meson (Daniel P=
. Berrang=C3=A9)
ef4fe31f33: gitlab: always populate cache for windows msys jobs (Daniel P. =
Berrang=C3=A9)
5ef56e3b18: gitlab: drop $CI_PROJECT_DIR from cache path (Daniel P. Berrang=
=C3=A9)
46aedd34b4: gitlab: always use updated msys installer (Daniel P. Berrang=C3=
=A9)
b64052cdad: gitlab: print timestamps during windows msys jobs (Daniel P. Be=
rrang=C3=A9)
11961d08fc: gitlab: remove duplication between msys jobs (Daniel P. Berrang=
=C3=A9)
c5b5288c3d: util/oslib-win32: Fix compiling with Clang from MSYS2 (Thomas H=
uth)
765fdc1e83: target/openrisc: Set EPCR to next PC on FPE exceptions (Staffor=
d Horne)

