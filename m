Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58391719EFF
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 16:02:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4isA-0005f9-7C; Thu, 01 Jun 2023 10:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1q4is6-0005WS-QL; Thu, 01 Jun 2023 10:01:46 -0400
Received: from mail-dm6nam10on2062e.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::62e]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1q4irz-0003Dm-U5; Thu, 01 Jun 2023 10:01:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrLB6IdIU+lh5tHGZDcZTrY693xSwU9kA/Wd1OeY3X4R+s6vTgiJSWztGXTiQHMM3LMoCQXa9ZAcKdHBY+K8CKH8XPVFwsWWqEemivJRYNxWPFcr9gjMj//8IFtMDGazgoigBUtxL8U33tjGsrvv4/AMEcuA9mG8RbTzkzD8Zs0YDACyIP2hnmxlyoeD/kBOf05Vsd7QPScW6azU9Ucsnra1tbmY+375S/g9vN/A9bqAJ9FVIO9IvKLCW7j19VEnr5GFjLVbc1g0XAXcZw9yF3N+REgFw7fK+7oZX9oXP4yLwtjHO+tnxGEBd/Cgij0x/IPrurhiMGyVKmEBktC7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qzLiHMDzTcLPwysHv90cXebfAd69T1nwgcYo8VuOEI=;
 b=Sep3fw2uUA+PUWm5JE9+Tr8jmSOyU9xkI0c88PkCqA06arn2rkOWjfK4hWTMSKVf5kou/VhOWB6iEDpKdHe3ASEtsFjMEauFCYop+nk/MwEfzbLOqeOWrJI5DpL0oQCrnih8CFs7rc8w/IhkSK6hDkM6DPElzpORECVOK2w4iYkgXFvPFXk+Tj617e5ezkG69QNVZODF7mtB0zq/cuTVaQtD+8TZKOUumUCiSeoDZfGWmH1bAeYpGMrQo4L1W+8m9bbiE+T93QpkCAeFiwutVryy+9HqsmfwHtMIA7w9/YrdwMFJR6ERvPnlcyOSo/B/X7wEslB0G9gwdGFLjd1OKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qzLiHMDzTcLPwysHv90cXebfAd69T1nwgcYo8VuOEI=;
 b=XkO/GKsrVsM1OwR5ZIl3zop7ZNwA4wL0NNgiUx09m9zX2fmb07aoR/Xyrn2Py8MUDLafL+sy7SOfb5u3adAKYcOyZxvwjELGAEHMTzDNcYkqVnBuhmt89rgtYkjrtqu/+fiD2iqBP7/aPoQ+t/cfrN5PNud8//FjWR5Z9/uJylw=
Received: from BN9PR03CA0640.namprd03.prod.outlook.com (2603:10b6:408:13b::15)
 by DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 14:01:30 +0000
Received: from BL02EPF000145BB.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::fa) by BN9PR03CA0640.outlook.office365.com
 (2603:10b6:408:13b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 14:01:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145BB.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.18 via Frontend Transport; Thu, 1 Jun 2023 14:01:23 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 09:01:11 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 7.2.3 Stable released
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-stable@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>
Date: Thu, 1 Jun 2023 08:51:49 -0500
Message-ID: <168562750947.873204.943819566790884080@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|DM4PR12MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: c00f77a2-621b-45ed-38d1-08db62a8b0d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jpRzk/E8L8Qr7mWlsjre8S5GAjtXXKMFIBUns7Yz8Hdv7wXqHjrjXZfQHpcqPWDgLGzsqHb4EGww96KfPKx7wrsE70t6W2SsK7OpybWyDeTgmriF6NX6Nv4wqBugxe5mG2h9B19N+cqaLCb0WtIGxngkM3UX6rANKhKgQ1+qDlULURmPzHGSIjVy+L+Yp/jL9ga38qNA6TtOqXufYhmxR+mKOGy5/Ii9U7x7Ph7J5D3rxxc17+wGXb20dDAbHEUzST31gFYbPYVdGr9rz0WaApuQ1R+S+YFBEeZjHXfARAAGM4BCfmhxBNpWF8bUkhxS7bCG9hjLmYc02hvHCeo8sXzyw1lZ3BMigkj6PEo6Chxs6T1Yp9p6Q4KJ+YlpgUfL5/GGrLR4VeQDqB+xi3+C49LeEYb5RI9SwGsVirOxBh7hIYK9rXs1R+Se2N103Sp6Uy6qAr7bIJ23j0YAOvcbFnHIOQq2Qxzz/9gwA0+Bo8Yuyco72OXkWzOZfSZwuLj/K+RcpNSP7olOofahGctA+qW3LGtWG7FqD2MAaI1pwlyUryTlAqoPHpjgjvk+MZmTEgWvPnDvHLP8ODSexHf/BUk35Ccp/6KWo2ENxnEfky/9KhYHcsOB4Yc0cD+4ykxGOmBfzaGAepeH3pfciDCFwI5h4JvlOfsiowox/9KjFNonrOFGBbG/H4pv5yA54AHlLoufP7uxlt5V3U/kfNBlL6aPuigeySQ8qnZMs0hskiQweUOZBt68CqGazGKhCYYmkdEEJ/tS5KVHiFta0VaNKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(186003)(5660300002)(40460700003)(6666004)(16526019)(41300700001)(82310400005)(36756003)(8676002)(8936002)(40480700001)(966005)(6916009)(26005)(83380400001)(426003)(54906003)(336012)(36860700001)(81166007)(356005)(70206006)(2906002)(70586007)(47076005)(478600001)(66574015)(4326008)(82740400003)(2616005)(44832011)(86362001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:01:23.4029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c00f77a2-621b-45ed-38d1-08db62a8b0d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254
Received-SPF: softfail client-ip=2a01:111:f400:7e88::62e;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

I am pleased to announce that the QEMU v7.2.3 stable release is now
available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

v7.2.3 is now tagged in the official qemu.git repository, and the
stable-7.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-7.2?ref_type=3Dheads

This update contains general fixes for various architectures/subsystems,
including the following CVE fixes:

    LSI (CVE-2023-0330)

Please see the changelog for additional details and update accordingly.

Thank you to everyone involved!

CHANGELOG:

a8f7a3504d: Update version for 7.2.3 release (Michael Tokarev)
9d52aaa92b: machine: do not crash if default RAM backend name has been stol=
en (Igor Mammedov)
9fe6e8139d: hw/scsi/lsi53c895a: Fix reentrancy issues in the LSI controller=
 (CVE-2023-0330) (Thomas Huth)
49d5fc4cfc: usb/ohci: Set pad to 0 after frame update (Paolo Bonzini)
12f0e61758: util/vfio-helpers: Use g_file_read_link() (Akihiko Odaki)
859759ee39: rtl8139: fix large_send_mss divide-by-zero (Stefan Hajnoczi)
b121ebe143: e1000e: Fix tx/rx counters (timothee.cocault@gmail.com)
f9f42e708f: e1000: Count CRC in Tx statistics (Akihiko Odaki)
926a8380f2: virtio-crypto: fix NULL pointer dereference in virtio_crypto_fr=
ee_request (Mauro Matteo Cascella)
dd63d3a5b8: virtio-net: not enable vq reset feature unconditionally (Eugeni=
o P=C3=A9rez)
6f4dc62715: vhost: fix possible wrap in SVQ descriptor ring (Hawkins Jiawei)
48b60eb6c9: target/i386: fix avx2 instructions vzeroall and vpermdq (Xinyu =
Li)
eee0666a50: target/i386: fix operand size for VCOMI/VUCOMI instructions (Pa=
olo Bonzini)
61f6b12cf3: scsi-generic: fix buffer overflow on block limits inquiry (Paol=
o Bonzini)
d68a13c672: target/arm: Fix vd =3D=3D vm overlap in sve_ldff1_z (Richard He=
nderson)
7405624def: migration: Attempt disk reactivation in more failure scenarios =
(Eric Blake)
b514d5a898: migration: Minor control flow simplification (Eric Blake)
08fd84005f: migration: Handle block device inactivation failures better (Er=
ic Blake)
89bf901afb: linux-user: fix getgroups/setgroups allocations (Michael Tokare=
v)
95cb7a7255: linux-user: Fix mips fp64 executables loading (Daniil Kovalev)
e7f1150829: tests/docker: bump the xtensa base to debian:11-slim (Alex Benn=
=C3=A9e)
273147b942: target/ppc: Fix helper_pminsn() prototype (C=C3=A9dric Le Goate=
r)
0c6e9547ae: Revert "vhost-user: Introduce nested event loop in vhost_user_r=
ead()" (Greg Kurz)
7620c12422: Revert "vhost-user: Monitor slave channel in vhost_user_read()"=
 (Greg Kurz)
6bebd3f818: xen/pt: reserve PCI slot 2 for Intel igd-passthru (Chuck Zmudzi=
nski)
de6596aa9d: 9pfs/xen: Fix segfault on shutdown (Jason Andryuk)
00acdd8a9f: s390x/tcg: Fix LDER instruction format (Ilya Leoshkevich)
6b71859686: target/s390x: Fix EXECUTE of relative branches (Ilya Leoshkevic=
h)
b7b814cd87: block/monitor: Fix crash when executing HMP commit (Wang Liang)
2a0afe1bde: virtio: fix reachable assertion due to stale value of cached re=
gion size (Carlos L=C3=B3pez)
a641521e50: hw/virtio/vhost-user: avoid using unitialized errp (Albert Este=
ve)
afc11df42a: tcg: ppc64: Fix mask generation for vextractdm (Shivaprasad G B=
hat)
c94d55f63e: async: Suppress GCC13 false positive in aio_bh_poll() (C=C3=A9d=
ric Le Goater)
379a05f384: ui: Fix pixel colour channel order for PNG screenshots (Peter M=
aydell)
0e262ee8e9: accel/tcg: Fix atomic_mmu_lookup for reads (Richard Henderson)
666e6bbf85: target/riscv: Fix itrigger when icount is used (LIU Zhiwei)
89640e03ec: block: Fix use after free in blockdev_mark_auto_del() (Kevin Wo=
lf)
e3074f666f: meson: leave unnecessary modules out of the build (Paolo Bonzin=
i)
9b300a100c: softfloat: Fix the incorrect computation in float32_exp2 (Shiva=
prasad G Bhat)
ec979ff52c: hw/net/allwinner-sun8i-emac: Correctly byteswap descriptor fiel=
ds (Peter Maydell)
4b02ac725a: hw/sd/allwinner-sdhost: Correctly byteswap descriptor fields (P=
eter Maydell)
e4e79c8e00: target/arm: Define and use new load_cpu_field_low32() (Peter Ma=
ydell)
5eb742fce5: hw/intc/allwinner-a10-pic: Don't use set_bit()/clear_bit() (Pet=
er Maydell)
d46d403616: hw/arm/raspi: Use arm_write_bootloader() to write boot code (Pe=
ter Maydell)
5ebe440c2b: hw/arm/aspeed: Use arm_write_bootloader() to write the bootload=
er (C=C3=A9dric Le Goater)
8e9c265f14: hw/arm/boot: Make write_bootloader() public as arm_write_bootlo=
ader() (C=C3=A9dric Le Goater)
e96dc26e89: hw/net/msf2-emac: Don't modify descriptor in-place in emac_stor=
e_desc() (Peter Maydell)
32900bff70: target/arm: Initialize debug capabilities only once (Akihiko Od=
aki)
0a65c4588c: docs/about/deprecated.rst: Add "since 7.1" tag to dtb-kaslr-see=
d deprecation (Peter Maydell)
4e35bd88a5: qemu-options: finesse the recommendations around -blockdev (Ale=
x Benn=C3=A9e)
e557055653: acpi: pcihp: allow repeating hot-unplug requests (Igor Mammedov)
84d5232d9d: target/i386: Change wrong XFRM value in SGX CPUID leaf (Yang Zh=
ong)
bfc532703f: vnc: avoid underflow when accessing user-provided address (Paol=
o Bonzini)

