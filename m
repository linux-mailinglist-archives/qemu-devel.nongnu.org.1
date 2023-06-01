Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5734A719F12
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 16:07:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4iwu-0001e9-MC; Thu, 01 Jun 2023 10:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1q4iwt-0001dw-1k; Thu, 01 Jun 2023 10:06:43 -0400
Received: from mail-bn8nam04on2043.outbound.protection.outlook.com
 ([40.107.100.43] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1q4iwq-0004Kc-Ek; Thu, 01 Jun 2023 10:06:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgLnXOeyoRQQGHPfzSV09ZCi1GaXExldd5E/l8/gcXqL6dpJVzyANUtugEjsx/Jk9UmSQLE/kI8JtJxlUByFp7h7Hqn4/zSjEiL6bJK5gZyvcWFQTw1tauid2c9QVEscFXXBHL3XBZyfq4zN1lGXLFkCO87aC67Qf3QXpxD7P8+hlhUleZ4/tatO/ng+eaX6wzF9A8AJpVfxghfU3G7a6AXLc/+T6BhS/uiKHlNe3Q0KyHb21qN8JiqFn4pTSf1bT5bnE1pU6FD3WKEgmj+RdYi7yo0jp+grfc38ZlUyCe7daFy02XgcYt1tPhyfc0YZjk3L1Pp+X6vWNUZKYUHKjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJkc51CF1WLGoWvWOtKTozbeyW5viss9PAZGIiQ/s6I=;
 b=g4ju5Ru4esjQleX+Gku9l6Q6kPZxQON2bt5wYSFlaSAyVIra2vE9rmfnB3dshhoYf4M3YBSOeCvKyszHilSjqt1RMrS4Jv1vUN/ni9UYus9xb450p+g4ezAc4iMx/kry0fh67NMJMxfrdhFImm+MtYfHRezdf01E+R9RT0valpP6Km+hbMrs8S/NOk483asBmr+srWqZNZVvV+G/B3HzyX3RYHRiLfVi0RkG9QIqqfqPEJx7lKzo/3CPApCwW6WcETSv0YrKu215AURPq+DL3WONRbnH5oRvxT4wQwZ3WhSFgCyxORYKlmxx/2aQ8yOq8LRJExpFk35ubi5hJiRzSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJkc51CF1WLGoWvWOtKTozbeyW5viss9PAZGIiQ/s6I=;
 b=TBBx3Dm27lrRa6xBQkSkmpj20O8Qu11HNX8jc/ghh+BVNxCdEGjgoebbICpkGd9nDIOC7P5mlQFg1/W4EOyDswLvHBv2beshTZX9fwRRz1fFkbD8M+jE+vgMiKaa4a33WVimUqH9WxCY3rQFlV6G59vUeHwCzgNL/v8TzwakbM4=
Received: from BN8PR15CA0012.namprd15.prod.outlook.com (2603:10b6:408:c0::25)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 14:01:33 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:408:c0:cafe::56) by BN8PR15CA0012.outlook.office365.com
 (2603:10b6:408:c0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 14:01:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.18 via Frontend Transport; Thu, 1 Jun 2023 14:01:32 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 09:01:32 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 8.0.2 Stable released
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-stable@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>
Date: Thu, 1 Jun 2023 09:00:49 -0500
Message-ID: <168562804977.874067.7769557556718570128@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8fd42d-b71c-4e61-8e7f-08db62a8b4dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PoE0YbYkNGobQxmxTxsqFJ48dSIG6vSB5X/whQ2Fr8lmPHfzt5D9QxXCHo/0ncdAV5kEMSLp2EcYCUhBx3UeOkEwZ8SWayqwY9xNXyXCUl7hKpuZ8cT1J4mWy1T+TFbbI69W+v5dK0/sF93hLtkYUAIE56TUJBV4tR9bkvLe8RVIFmoIIeqqLIF08y/TvEakFohIgHs3xItNv59Phk5C3uvl/pyrlvmAga7YFIgqFAck/md7iFIA+bFedaeB3jzZCXEuI24OcQ8I/auxOeHo23CZXV7J18nJxyosULR5UsKotEvxO1VDYYcaoDZh8zXpaarB4l1OqhsMZm3/xnzcVPUFCpS8w2Q6rmZ1UXVq9/MTayxn7wZ9kwt2mx8n54ZEPpyCdgqWR0I7Em4ETZL1SRnttiX+8AkLV/yWzLolK1/Vlgreb8qEVxqJM/d/f9nwCcS4k2OBqMpB2tdXq/BR7NTf0om684+JBFh1hFdU3lKbt86z3T2NkDDJ3aQ32KH0pq0LHS73Hb52NUaxeYSanA2E6v5DykiPxI+w+LIXyt8VhEWT41RdurZYpajfjSOk7X8kVYVgHjAl9d4OrFg4ov3HdBJqaWAH7hJMF9COxS33MQjPUmd4/8Ec3h9R9RU/ytdw8qc22CMuRx2e9JoxXh1Aw47F9cegiS0eYW298dUQWO4aBw6WJQAvLuWhjxgGnrhPCXF3srco+eNIzI8QMYIxGNqRcVkzKWuygXqQTGrI9hWyMhfmJUSpDWhb+14ROhfSWDKvWrQJTTevEWIAPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(66574015)(47076005)(2616005)(40480700001)(26005)(186003)(36756003)(16526019)(426003)(336012)(83380400001)(36860700001)(6666004)(40460700003)(966005)(41300700001)(6916009)(4326008)(81166007)(356005)(70206006)(70586007)(82740400003)(316002)(82310400005)(44832011)(86362001)(2906002)(5660300002)(8676002)(8936002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:01:32.7441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8fd42d-b71c-4e61-8e7f-08db62a8b4dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496
Received-SPF: softfail client-ip=40.107.100.43;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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

Hi everyone,

I am pleased to announce that the QEMU v8.0.2 stable release is now
available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

v8.0.2 is now tagged in the official qemu.git repository, and the
stable-8.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-8.0?ref_type=3Dheads

This update contains general fixes for various architectures/subsystems,
including the following CVE fixes:

    LSI (CVE-2023-0330)

Please see the changelog for additional details and update accordingly.
Note that v8.0.1 is also included in the changelog for this release due
to a regression being noticed prior to the v8.0.1 release.

Thank you to everyone involved!

CHANGELOG:

f7f686b61c: Update version for 8.0.2 release (Michael Tokarev)
bea933e430: block/export: Fix null pointer dereference in error path (Kevin=
 Wolf)
dabb4183d1: Update version for 8.0.1 release (Michael Tokarev)
ff692a15bb: virtio: qmp: fix memory leak (Paolo Bonzini)
134253a4fe: machine: do not crash if default RAM backend name has been stol=
en (Igor Mammedov)
e49884a909: hw/scsi/lsi53c895a: Fix reentrancy issues in the LSI controller=
 (CVE-2023-0330) (Thomas Huth)
9d622451fd: usb/ohci: Set pad to 0 after frame update (Paolo Bonzini)
668aeea0ec: util/vfio-helpers: Use g_file_read_link() (Akihiko Odaki)
fae9449998: rtl8139: fix large_send_mss divide-by-zero (Stefan Hajnoczi)
02bd13ae3a: igb: Always copy ethernet header (Akihiko Odaki)
c84bcff3d3: e1000e: Always copy ethernet header (Akihiko Odaki)
5c4f2f1b60: net/net_rx_pkt: Use iovec for net_rx_pkt_set_protocols() (Akihi=
ko Odaki)
ba3c7bf178: igb: Clear IMS bits when committing ICR access (Akihiko Odaki)
6e260100d0: igb: Do not require CTRL.VME for tx VLAN tagging (Akihiko Odaki)
9ff3fe63fc: igb: Fix Rx packet type encoding (Akihiko Odaki)
0f7ca2bf2c: e1000x: Fix BPRC and MPRC (Akihiko Odaki)
eb134d1d58: e1000e: Fix tx/rx counters (timothee.cocault@gmail.com)
a7002f15c8: nbd/server: Fix drained_poll to wake coroutine in right AioCont=
ext (Kevin Wolf)
d001f222e3: graph-lock: Disable locking for now (Kevin Wolf)
84d839e499: block: compile out assert_bdrv_graph_readable() by default (Ste=
fan Hajnoczi)
a0b89ba845: tested: add test for nested aio_poll() in poll handlers (Stefan=
 Hajnoczi)
a91defe16b: aio-posix: do not nest poll handlers (Stefan Hajnoczi)
81d13aa5e0: virtio-crypto: fix NULL pointer dereference in virtio_crypto_fr=
ee_request (Mauro Matteo Cascella)
302ac06ab9: virtio-net: not enable vq reset feature unconditionally (Eugeni=
o P=C3=A9rez)
adc49750d2: hw/pci: Disable PCI_ERR_UNCOR_MASK register for machine type < =
8.0 (Leonardo Bras)
a9144eed6c: vhost: fix possible wrap in SVQ descriptor ring (Hawkins Jiawei)
0de5117819: target/i386: fix avx2 instructions vzeroall and vpermdq (Xinyu =
Li)
db8051ad59: target/i386: fix operand size for VCOMI/VUCOMI instructions (Pa=
olo Bonzini)
1e029102e6: scsi-generic: fix buffer overflow on block limits inquiry (Paol=
o Bonzini)
c283a4bc76: target/arm: Fix vd =3D=3D vm overlap in sve_ldff1_z (Richard He=
nderson)
c0ad2a9191: migration: Attempt disk reactivation in more failure scenarios =
(Eric Blake)
d2a811dd7d: migration: Minor control flow simplification (Eric Blake)
cb898262a4: migration: Handle block device inactivation failures better (Er=
ic Blake)
45a67df841: linux-user: fix getgroups/setgroups allocations (Michael Tokare=
v)
69a6ea7c4b: linux-user: Fix mips fp64 executables loading (Daniil Kovalev)
0b1b5a4204: tests/docker: bump the xtensa base to debian:11-slim (Alex Benn=
=C3=A9e)
eb82a80f51: docs/about/emulation: fix typo (Lizhi Yang)
8ad637881f: util/async-teardown: wire up query-command-line-options (Claudi=
o Imbrenda)
21b54a683d: s390x/pv: Fix spurious warning with asynchronous teardown (Clau=
dio Imbrenda)
36cd9bc8e2: tcg/i386: Set P_REXW in tcg_out_addi_ptr (Richard Henderson)
117f33c9a7: 9pfs/xen: Fix segfault on shutdown (Jason Andryuk)
e347aa89dd: s390x/tcg: Fix LDER instruction format (Ilya Leoshkevich)
b858c53ef6: target/s390x: Fix EXECUTE of relative branches (Ilya Leoshkevic=
h)
7ceebe3f90: tcg: ppc64: Fix mask generation for vextractdm (Shivaprasad G B=
hat)
950882af67: async: Suppress GCC13 false positive in aio_bh_poll() (C=C3=A9d=
ric Le Goater)
e09f912550: target/arm: Correct AArch64.S2MinTxSZ 32-bit EL1 input size che=
ck (Peter Maydell)
80a2c1b5fe: ui: Fix pixel colour channel order for PNG screenshots (Peter M=
aydell)
3148fe1ac8: target/arm: Fix handling of SW and NSW bits for stage 2 walks (=
Peter Maydell)
4b59b5bd14: accel/tcg: Fix atomic_mmu_lookup for reads (Richard Henderson)
488ad8b302: hw/pci-bridge: pci_expander_bridge fix type in pxb_cxl_dev_rese=
t() (Jonathan Cameron)
f91d0db71e: target/riscv: Restore the predicate() NULL check behavior (Bin =
Meng)
f5301431e8: target/riscv: Fix itrigger when icount is used (LIU Zhiwei)
3b02d0db4a: block: Don't call no_coroutine_fns in qmp_block_resize() (Kevin=
 Wolf)
e0deae4f49: block: bdrv/blk_co_unref() for calls in coroutine context (Kevi=
n Wolf)
38a598aee3: block: Consistently call bdrv_activate() outside coroutine (Kev=
in Wolf)
2197a94cb4: block: Fix use after free in blockdev_mark_auto_del() (Kevin Wo=
lf)
8322e5300f: meson: leave unnecessary modules out of the build (Paolo Bonzin=
i)
4dc5df865c: softfloat: Fix the incorrect computation in float32_exp2 (Shiva=
prasad G Bhat)
a458252c16: block/export: call blk_set_dev_ops(blk, NULL, NULL) (Stefan Haj=
noczi)
f6227dd60d: hw/net/allwinner-sun8i-emac: Correctly byteswap descriptor fiel=
ds (Peter Maydell)
2daa9e4d7e: hw/sd/allwinner-sdhost: Correctly byteswap descriptor fields (P=
eter Maydell)
6944823a6f: target/arm: Define and use new load_cpu_field_low32() (Peter Ma=
ydell)
af08c70ef5: hw/intc/allwinner-a10-pic: Don't use set_bit()/clear_bit() (Pet=
er Maydell)
975f12aa52: hw/arm/raspi: Use arm_write_bootloader() to write boot code (Pe=
ter Maydell)
5477a21350: hw/arm/aspeed: Use arm_write_bootloader() to write the bootload=
er (C=C3=A9dric Le Goater)
168f193c5b: hw/arm/boot: Make write_bootloader() public as arm_write_bootlo=
ader() (C=C3=A9dric Le Goater)
61ef050639: hw/net/msf2-emac: Don't modify descriptor in-place in emac_stor=
e_desc() (Peter Maydell)
f0c5a78029: target/arm: Initialize debug capabilities only once (Akihiko Od=
aki)
9448a0fa11: docs/about/deprecated.rst: Add "since 7.1" tag to dtb-kaslr-see=
d deprecation (Peter Maydell)
8c3cf36260: qemu-options: finesse the recommendations around -blockdev (Ale=
x Benn=C3=A9e)
f528cfc3fa: block/monitor: Fix crash when executing HMP commit (Wang Liang)
bb47b5bc2e: acpi: pcihp: allow repeating hot-unplug requests (Igor Mammedov)
134a1a3320: hw/timer/imx_epit: fix limit check (Axel Heider)
ac7f07ebc8: hw/timer/imx_epit: don't shadow variable (Axel Heider)
3ed99d232c: target/i386: Change wrong XFRM value in SGX CPUID leaf (Yang Zh=
ong)
6f7b9f7b6f: vnc: avoid underflow when accessing user-provided address (Paol=
o Bonzini)

