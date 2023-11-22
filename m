Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8E67F3BBD
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 03:26:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5cv0-0007gg-UQ; Tue, 21 Nov 2023 21:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1r5cuz-0007gX-3P
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 21:24:45 -0500
Received: from mail-co1nam11on2061.outbound.protection.outlook.com
 ([40.107.220.61] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1r5cus-00059s-6E
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 21:24:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyU+ggs3AAJmRItF95Ug2eOwew04MMMPjalNa7CJObJOf6QEbJBsZityMHMQ/ubYdISdT2X6n23kiTX5Nj6WR7GXVH6Qh7IrI4gXUI5oRAWBnfLBenewd5QKKx2lVLXdJC5DzSPMPXiIJRSF/dG29DwWIGoFDkeLMz8tSGDt1RRgWsz8dhYn8kmK4USp7UFj7nPjl4H9CUmi3842ytPy5zp+P9u9LOGLE+tmUvG80/nVAsy4Wj/yOMUWdC3KlP9p8RSi8ksiB/lQmzrsJcgwJ56j5kVR0UyVCz2d9S6CDua366mPDMnUhTOIk4X+1fVg9KX+XiHsz81jZ9+k+WXDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6XWl7qCw7nmJsWSp7n5hQCn763sUxBxr5kobDhLJvw=;
 b=jkLWRWW8r7CEvMww0yb7JNyMQ4Y8qw2jpVrv+m92n0YfB5tMfKri/sViwBxOXnaJ+/H188MdMXSvn4sS0MumaLANCX1fsnz7ofC39C7QqsMRuU4Mlq3u92aygKCPslTIgzmhmJEiFsR07qeM/+ee2ynYvbuVMqDU9C0WZvmQPRRZ0LHEUrupzO2tVz3GGPefgnnY/DdfW6H7c9B2zsMfRiwgMSys/UBOsxuIT1pPOgO+EznSdpk9+EpydEneYDpDtmH+VDS/UCpf4vtfL7CB6U/BpNPsgBb5AC6qUjR3j+r2Tbbb0opEEqd3leO/NgrwrJQQvmdmyaTKNi6CqeJnJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6XWl7qCw7nmJsWSp7n5hQCn763sUxBxr5kobDhLJvw=;
 b=gXYJPLQaguF41xqNDV9xTDYYKkgcFEkVYDot+/bVyBklX9KzAPtn3Ybt7CnoRcU2ffAnfCLaWgRQ67Xdz2vy/25sfNUOM+pceqlDC84aB3RSw6GA3hoLlEd/7aGYE1cGQ4anvwWOLCNCJmCb7WP4KAy2aq6NW/q1DuD3WPNoJQg=
Received: from CH0PR13CA0023.namprd13.prod.outlook.com (2603:10b6:610:b1::28)
 by PH7PR12MB5999.namprd12.prod.outlook.com (2603:10b6:510:1db::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 02:19:31 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::fe) by CH0PR13CA0023.outlook.office365.com
 (2603:10b6:610:b1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 02:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 02:19:30 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 20:19:29 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 8.2.0-rc1 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <stefanha@redhat.com>
Date: Tue, 21 Nov 2023 20:17:49 -0600
Message-ID: <170061946945.364361.3610652838230138666@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|PH7PR12MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: eae045e6-361d-489f-1663-08dbeb0175b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mgQlszjKGcSQMe1/wmRrcH1ng05ETMq8TUwXGbChvELfGHhF8Wgmq72nTlmX6Dmmj4b1iQbxlLqxWQxI0bCCILPF2oPMdQhQevd2ZRH9EfP9uakwbPdX7pMMWxcErdkrztYUtMHPxYw22+CpplnQNMVxpP8DYyRxJqy5L6MUAWqYFTvGb9SROZmzKUa5gMDaQ800tlLfQa/OKNsL9knLB2SheCJ/EDFWvEBMkMvxKBwp0UVnH3hLFYNWpc6j+cNGY7kUqMJ/Keln9XK/qbMRhZ2ZIwdFrVzNvvD7ceLnswzXs3Nssx0yfzctlKKNwCX9wd0wk5Kk3f+7hBIwhGnvyrcO5SptC/tdBuTC+04ZQ7cPOaxyIjF6YabeanfVIRRWPqGwEIJ3E8tYdlYeh4JcqRcewjfnSBgWsZkA+9cY1ShsIaLZav36attuMvNn7Qbo3J6cW0sKf/X0luJ9l/c7zVlLOvbBkcxid4KhHD29cGA+xdmt0Z1wpvb1WM1yUcPbquFxZhrnf8IyS/JWUfLThzLBCIFlzB/IZD+BuMAoCpBfE18Gd1vJYJvFJ4IyFWFz/MqDN0yEsukTY541rQEH3o4b8fEddAWG5eimaah9vtvntZ/ECdbTzTubxJ5hxT5c5EkYvf85O0v+feB0X/7UpQGnd8pj/HkS55pJmfJZFo3jNaxPunMNIKt1kADANz+Fl604w6nFL7DSUO58QWcBv4a0PHRCo4o8PmquSA3DLUZR3gHs4bHhruOadlkzXCixaBai8MKWmZ1r7SM9HlnCzMWoIX4scOnXKbwPrvyhNQ7ILf1C2zBwlgdP0ygzn6nR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(1800799012)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(2616005)(356005)(82740400003)(40480700001)(36756003)(40460700003)(966005)(70206006)(316002)(6916009)(70586007)(86362001)(81166007)(6666004)(2906002)(26005)(16526019)(83380400001)(66574015)(426003)(336012)(5660300002)(41300700001)(44832011)(478600001)(36860700001)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 02:19:30.4325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eae045e6-361d-489f-1663-08dbeb0175b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5999
Received-SPF: softfail client-ip=40.107.220.61;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
second release candidate for the QEMU 8.2 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-8.2.0-rc1.tar.xz
  http://download.qemu.org/qemu-8.2.0-rc1.tar.xz.sig

You can help improve the quality of the QEMU 8.2 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/10

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/8.2

Please add entries to the ChangeLog for the 8.2 release below:

  http://wiki.qemu.org/ChangeLog/8.2

Thank you to everyone involved!

Changes since rc0:

8fa379170c: Update version for v8.2.0-rc1 release (Stefan Hajnoczi)
ea6a33e776: Revert "tests/avocado: Enable reverse_debugging.py tests in git=
lab CI" (Thomas Huth)
82d70a84c8: linux-user: Fix loaddr computation for some elf files (Richard =
Henderson)
debb491166: hw/ide/via: implement legacy/native mode switching (Mark Cave-A=
yland)
7a9d672b81: ide/via: don't attempt to set default BAR addresses (Mark Cave-=
Ayland)
fd6a543d19: ide/pci: introduce pci_ide_update_mode() function (Mark Cave-Ay=
land)
7552488444: ide/ioport: move ide_portio_list[] and ide_portio_list2[] defin=
itions to IDE core (Mark Cave-Ayland)
8f37120383: iotests: Test two stream jobs in a single iothread (Kevin Wolf)
1dbc7d3442: stream: Fix AioContext locking during bdrv_graph_wrlock() (Kevi=
n Wolf)
6bc0bcc89f: block: Fix deadlocks in bdrv_graph_wrunlock() (Kevin Wolf)
bb092d6d8f: block: Fix bdrv_graph_wrlock() call in blk_remove_bs() (Kevin W=
olf)
eabb921250: hw/ide/ahci: fix legacy software reset (Niklas Cassel)
6f7997e004: hw/xen: clean up xen_block_find_free_vdev() to avoid Coverity f=
alse positive (David Woodhouse)
87bfffdf75: vl: disable default serial when xen-console is enabled (David W=
oodhouse)
e0c58720bf: ui/pixman-minimal.h: fix empty allocation (Manos Pitsidianakis)
ff2a5bed5f: vl: add missing display_remote++ (Marc-Andr=C3=A9 Lureau)
0e8823072e: ui/console: fix default VC when there are no display (Marc-Andr=
=C3=A9 Lureau)
b7f1bb38b0: ui: use "vc" chardev for dbus, gtk & spice-app (Marc-Andr=C3=A9=
 Lureau)
69562648f9: vl: revert behaviour for -display none (Marc-Andr=C3=A9 Lureau)
84f85eb95f: net: do not delete nics in net_cleanup() (David Woodhouse)
9050f976e4: net: Update MemReentrancyGuard for NIC (Akihiko Odaki)
7d0fefdf81: net: Provide MemReentrancyGuard * to qemu_new_nic() (Akihiko Od=
aki)
b664466d8f: ppc/pnv: Fix PNV I2C invalid status after reset (Glenn Miles)
47dfdd238d: ppc/pnv: PNV I2C engines assigned incorrect XSCOM addresses (Gl=
enn Miles)
d18b065286: target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and VSX_CVT_FP_TO_INT=
2 macros (John Platts)
8bc5ae046d: ppc/pnv: Fix potential overflow in I2C model (C=C3=A9dric Le Go=
ater)
85d57a37be: tcg/loongarch64: Fix tcg_out_mov() Aborted (Song Gao)
0cbb56c236: hw/arm/fsl-imx: Do not ignore Error argument (Philippe Mathieu-=
Daud=C3=A9)
d652866007: hw/arm/stm32f100: Report error when incorrect CPU is used (Phil=
ippe Mathieu-Daud=C3=A9)
ff6cda35f1: hw/arm/stm32f205: Report error when incorrect CPU is used (Phil=
ippe Mathieu-Daud=C3=A9)
e1b72c55b1: hw/arm/stm32f405: Report error when incorrect CPU is used (Phil=
ippe Mathieu-Daud=C3=A9)
790a4428f2: hw/core/machine: Constify MachineClass::valid_cpu_types[] (Gavi=
n Shan)
3efd849573: target/arm: Fix SME FMOPA (16-bit), BFMOPA (Richard Henderson)
70726a15bc: hw/intc/arm_gicv3: ICC_PMR_EL1 high bits should be RAZ (Ben Doo=
ks)
e867a1242e: target/arm: enable FEAT_RNG on Neoverse-N2 (Marcin Juszkiewicz)
1b173d0606: linux-user: xtensa: fix signal delivery in FDPIC (Max Filippov)
2f926bfd5b: disas/hppa: Show hexcode of instruction along with disassembly =
(Helge Deller)
a01491a238: target/hppa: Fix 64-bit SHRPD instruction (Helge Deller)
298d8b1220: target/i386/cpu: Improve error message for property "vendor" (M=
arkus Armbruster)
eeef44b3a5: balloon: Fix a misleading error message (Markus Armbruster)
0a4a1512e0: net: Fix a misleading error message (Markus Armbruster)
517b0220ef: ui/qmp-cmds: Improve two error messages (Markus Armbruster)
b665165938: qga: Improve guest-exec-status error message (Markus Armbruster)
7200fb211e: hmp: Improve sync-profile error message (Markus Armbruster)
db8227a68a: spapr/pci: Correct "does not support hotplugging error messages=
 (Markus Armbruster)
c4d74ab24a: tests/avocado: Enable reverse_debugging.py tests in gitlab CI (=
Nicholas Piggin)
cd43f00524: tests/avocado: reverse_debugging drain console to prevent hang =
(Nicholas Piggin)
572960cb23: tests/avocado/mem-addr-space-check: Replace assertEquals() for =
Python 3.12 (Thomas Huth)
3365f3d99a: tests/avocado/replay_kernel: Mark the test_x86_64_pc as flaky (=
Thomas Huth)
9d72dd100c: tests/avocado: Make fetch_asset() unconditionally require a cry=
pto hash (Philippe Mathieu-Daud=C3=A9)
cfe52e91c4: tests/avocado/multiprocess: Add asset hashes to silence warning=
s (Thomas Huth)
9cdafe3b47: tests/avocado/intel_iommu: Add asset hashes to avoid warnings (=
Thomas Huth)
ffab603bd5: tests/avocado/virtio-gpu: Fix test_vhost_user_vga_virgl for edi=
d support (Thomas Huth)
f0a663b4ce: tests/avocado: Replace assertRegexpMatches() for Python 3.12 co=
mpatibility (Philippe Mathieu-Daud=C3=A9)
861f724d03: tests/avocado: Replace assertEquals() for Python 3.12 compatibi=
lity (Thomas Huth)
f779357882: util/range.c: spelling fix: inbetween (Michael Tokarev)
f0dbe427ec: util/filemonitor-inotify.c: spelling fix: kenel (Michael Tokare=
v)
4b3e4d2b43: tests/qtest/ufs-test.c: spelling fix: tranfer (Michael Tokarev)
8053feaae0: tests/qtest/migration-test.c: spelling fix: bandwith (Michael T=
okarev)
3a4e56015b: target/riscv/cpu.h: spelling fix: separatly (Michael Tokarev)
801faee4dd: include/hw/virtio/vhost.h: spelling fix: sate (Michael Tokarev)
c437eb1d5a: include/hw/hyperv/dynmem-proto.h: spelling fix: nunber, atleast=
 (Michael Tokarev)
a4dbf3fecb: include/block/ufs.h: spelling fix: setted (Michael Tokarev)
315ebbd760: hw/net/cadence_gem.c: spelling fixes: Octects (Michael Tokarev)
d1c2fbc9c1: hw/mem/memory-device.c: spelling fix: ontaining (Michael Tokare=
v)
1a9c9a6f8a: contrib/vhost-user-gpu/virgl.c: spelling fix: mesage (Michael T=
okarev)
e3fc69343c: migration/rdma.c: spelling fix: asume (Michael Tokarev)
385b3280ce: target/hppa: spelling fixes: Indicies, Truely (Michael Tokarev)
51464c5612: target/arm/tcg: spelling fixes: alse, addreses (Michael Tokarev)
eb12e92905: docs/system/arm/emulation.rst: spelling fix: Enhacements (Micha=
el Tokarev)
2a620ed52d: docs/devel/migration.rst: spelling fixes: doen't, diferent, res=
ponsability, recomend (Michael Tokarev)
6477366f6c: docs/about/deprecated.rst: spelling fix: becase (Michael Tokare=
v)
ac2786f0b0: gdbstub: spelling fix: respectivelly (Michael Tokarev)
487152fa1f: hw/cxl: spelling fixes: limitaions, potentialy, intialized (Mic=
hael Tokarev)
2cf91b9ae6: linux-user: spelling fixes: othe, necesary (Michael Tokarev)
9bfba08a1f: bsd-user: spelling fixes: necesary, agrument, undocummented (Mi=
chael Tokarev)
4061c3346e: qapi/migration.json: spelling: transfering (Michael Tokarev)
aaf851a20c: hw/audio/virtio-snd.c: spelling: initalize (Michael Tokarev)
7ca24cd1c9: qapi/pragma.json: Improve the comment about the lists of QAPI r=
ule exceptions (Thomas Huth)
1349af898c: tests/data/qobject/qdict.txt: Avoid non-inclusive words (Thomas=
 Huth)
80a59bc5e5: MAINTAINERS: Add tests/decode/ to the "Overall TCG CPUs" sectio=
n (Thomas Huth)
294c63be7d: hw/watchdog/wdt_aspeed: Remove unused 'hw/misc/aspeed_scu.h' he=
ader (Philippe Mathieu-Daud=C3=A9)
0dfae4f948: target/sparc: Fix RETURN (Richard Henderson)
e2faabee78: accel/tcg: Forward probe size on to notdirty_write (Jessica Cla=
rke)
cf9b5790db: accel/tcg: Remove CF_LAST_IO (Richard Henderson)

