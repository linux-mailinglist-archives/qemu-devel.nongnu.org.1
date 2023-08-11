Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B10E779719
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 20:26:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUWpn-0002UV-Eh; Fri, 11 Aug 2023 14:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qUWpl-0002UJ-Cu; Fri, 11 Aug 2023 14:26:01 -0400
Received: from mail-dm6nam12on20631.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::631]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qUWph-00044a-3d; Fri, 11 Aug 2023 14:26:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCF3SNlmuwIqUjpS+IfWrR7wvrfZLh3XVErg91uP2gAY3S/rxoeDXHStsWIgmf50Orn6tBhdVvDKcHCC8tfFiWc0bjmMlM8gVFqANAoxMwAQXwvXLCp/4uUMEGHDRVqYRqNLPPsD/OnENs2x1ar+5huOLVMkSJIsP4GbVlSDRppjvizrpr9LZASLefwPLcPamCCSpE4KakPdDZR4ugGWRQzp7BXC00sb0JAOzy2N/Vq5E6gYENg4nzXBMR25JJrSElaSYOrZHxYAcBiNR1FlpK1lFV16rmeknFLHUfZlP7yUC/dwr8trKTJapkSNtyRyobE92LDdo72wEBKl2Au/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8VOD5uhz/nt/fmPMjtFAFNAX0ujkruR65bAqbwX9rM=;
 b=ZTKqGl/lU7HM4aSXLKGAa/yWvvvvnjboV3PbydG40+IxeHadsmDfHylVODg91WROQxOVguS+EqG31/rgGA4/ZSQm59GgUQx4UXdQhT6ViX86LIS9PN1KV0LlAu93unHWxg5RQgnLsy+D619Rz2lvCW63Qa+Afne19AAdyr6qjwpU5ZuJEb4LN92mq9kSac46/4fXV59rpnp1/T8mwZCXiGM4MiZSBupLzoaEBI23JUJBKnO+j/G6K9Gl/ykr/BC5AdgUmYuCP/Ag4u8tpl4hqteyMhWVccvWqNGXbpvahrJyOUwDgF6AIC2/banHPQywmsKMzfNcoOmeQyVS7bWqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8VOD5uhz/nt/fmPMjtFAFNAX0ujkruR65bAqbwX9rM=;
 b=ZnYcC9HBuHiq6IRU/uUKkpJgE28gUuM1ylnQjcG5HvSOa0EfhxSQPWFGEarmYtpwGwqATEzGqN1K1Hkc8V5vI9YGnZm+qlO/PIqdo8BzTAlJ6rSVrNUY3GPnN8NGiVz5XoEDeTZllKFvLn60/KAm+uD+IRNzEqPRocFSY+SxqIo=
Received: from CY5PR15CA0157.namprd15.prod.outlook.com (2603:10b6:930:67::29)
 by PH7PR12MB8426.namprd12.prod.outlook.com (2603:10b6:510:241::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Fri, 11 Aug
 2023 18:25:51 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:67:cafe::b9) by CY5PR15CA0157.outlook.office365.com
 (2603:10b6:930:67::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 18:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 18:25:51 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 13:25:50 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 8.0.4 Stable released
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-stable@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>
Date: Fri, 11 Aug 2023 13:23:55 -0500
Message-ID: <169177823531.1335958.427454820384322595@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|PH7PR12MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: e08158d6-1ad2-4ac8-1d5f-08db9a98644c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NOQiZxqFIV/zPCroWzZ6cM3SZM7V6FHccdAG5HidE73y2OWAjgxejYWWCG8qWzqcxHkPbLCZzraizFd2cgiTbRHQhx+YLMZ1ljkXRwyS0R3jlbbe0ZwL8J6fTweKADP5t2JJWVChkxzHDBA+4YjYI7/SC37ZonQ3y90qKEJIeUNDKerhBJfVe58/Faj2F06u/Olw5hCbMCGYvnOjlAFiSfLjUR53d2IWL+CC/RAQ7stHtqiZYWgW7dlfgu0rlbnvFBLpmYBzskVww1xz9JkOEyK49uWwIuXSDY7DVItLSID3KUkbiqUMWN0V647liFI+9/m7kGaT9d26PoXHU6fxleEphtoR8/rgz9eHfrE5G+tv4yBuq2JliW0YIzvAUt8OtAXb9kIYQJE8V/UWOdLmwCbaGbrPo5UE/RzBYbBcLCqLFwqG/tNKrUVePcxk0LMwsNWukSfFp32WAboIMBPjtSt41GNwwzmiMET5k5c8KDqGsxYmOBP2Vw0iX3a0CjAUA298NRiE1SKDYZ1jAR9OpS2mKyJloqNDTi7fMmmTfeDbGANP4nCsF6qyBUt827ibohWs1tocMLMV/6q/YD2gn6F5evrvLPUst1ti2gNfgab3/JqBZ8T+fqyFveDLZeXeI5MaX0oVjsAyoFXceLayrfJclvgnkKGiqtvnzloTxgeh20NDFHYcJTJEbMCOkm8Q//V32SyrN1XLXxdnzacNvSTJSTF4Xijn7r+L5D/qFwNw6Vv8Wnp4pYPFidNaswUeAeo+Zs0gLTH31FlPQxJJGQ+zXmVJs50uHxULaisvAOU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(1800799006)(451199021)(82310400008)(186006)(46966006)(36840700001)(40470700004)(8676002)(8936002)(40480700001)(26005)(40460700003)(44832011)(70586007)(70206006)(478600001)(356005)(6916009)(36756003)(4326008)(81166007)(5660300002)(54906003)(966005)(82740400003)(41300700001)(2616005)(86362001)(316002)(83380400001)(47076005)(16526019)(36860700001)(426003)(336012)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 18:25:51.0379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e08158d6-1ad2-4ac8-1d5f-08db9a98644c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8426
Received-SPF: softfail client-ip=2a01:111:f400:fe59::631;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

Hi everyone,

The QEMU v8.0.4 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

v8.0.4 is now tagged in the official qemu.git repository, and the
stable-8.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-8.0?ref_type=3Dheads

This update contains general fixes for various architectures/subsystems,
including the following CVE fixes:

    virtio-crypto (CVE-2023-3180)
    QIOChannel (CVE-2023-3354)
    VNC (CVE-2023-3255)

Thank you to everyone involved!

CHANGELOG:

83a9cdbd65: Update version for 8.0.4 release (Michael Tokarev)
7cb0210fcc: target/i386: Check CR0.TS before enter_mmx (Matt Borgerson)
979cdfbbfd: target/ppc: Fix VRMA page size for ISA v3.0 (Nicholas Piggin)
b96bb74e3a: target/ppc: Fix pending HDEC when entering PM state (Nicholas P=
iggin)
bfe876cb30: target/ppc: Implement ASDR register for ISA v3.0 for HPT (Nicho=
las Piggin)
1d711f97a5: vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mq()=
 (Hawkins Jiawei)
f43e4e2594: vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mac(=
) (Hawkins Jiawei)
ade1bed2b7: vdpa: Fix possible use-after-free for VirtQueueElement (Hawkins=
 Jiawei)
e85ab8f753: vfio/pci: Disable INTx in vfio_realize error path (Zhenzhong Du=
an)
48be003029: include/hw/i386/x86-iommu: Fix struct X86IOMMU_MSIMessage for b=
ig endian hosts (Thomas Huth)
dab9a65dfa: hw/i386/x86-iommu: Fix endianness issue in x86_iommu_irq_to_msi=
_message() (Thomas Huth)
e0711f74b2: hw/i386/intel_iommu: Fix index calculation in vtd_interrupt_rem=
ap_msi() (Thomas Huth)
4f558fd185: hw/i386/intel_iommu: Fix struct VTDInvDescIEC on big endian hos=
ts (Thomas Huth)
b3c94ecf3c: hw/i386/intel_iommu: Fix endianness problems related to VTD_IR_=
TableEntry (Thomas Huth)
bc5740e178: hw/i386/intel_iommu: Fix trivial endianness problems (Thomas Hu=
th)
715e8123ed: pci: do not respond config requests after PCI device eject (Yur=
i Benditovich)
868b90e44a: target/hppa: Move iaoq registers and thus reduce generated code=
 size (Helge Deller)
60c42b8623: cryptodev: Handle unexpected request to avoid crash (zhenwei pi)
49f1e02bac: virtio-crypto: verify src&dst buffer length for sym request (zh=
enwei pi)
fd902c54e5: vhost: fix the fd leak (Li Feng)
18963f458f: hw/virtio-iommu: Fix potential OOB access in virtio_iommu_handl=
e_command() (Eric Auger)
71e05c42cc: target/m68k: Fix semihost lseek offset computation (Peter Mayde=
ll)
3d81ba8da4: target/nios2: Fix semihost lseek offset computation (Keith Pack=
ard)
adef4fe350: target/nios2: Pass semihosting arg to exit (Keith Packard)
f8592e9431: hw/xen: fix off-by-one in xen_evtchn_set_gsi() (David Woodhouse)
5300472ec0: io: remove io watch if TLS channel is closed during handshake (=
Daniel P. Berrang=C3=A9)
ca93a302a0: xen-block: Avoid leaks on new error path (Anthony PERARD)
157529eee6: thread-pool: signal "request_cond" while locked (Anthony PERARD)
5a87bcee89: linux-user/armeb: Fix __kernel_cmpxchg() for armeb (Helge Delle=
r)
f8e673df7e: target/ppc: Disable goto_tb with architectural singlestep (Rich=
ard Henderson)
357b42486c: util/interval-tree: Use qatomic_set_mb in rb_link_node (Richard=
 Henderson)
b2ec463649: util/interval-tree: Use qatomic_read for left/right while searc=
hing (Richard Henderson)
2eee26f579: target/arm: Avoid writing to constant TCGv in trans_CSEL() (Pet=
er Maydell)
2bff614256: target/arm: Special case M-profile in debug_helper.c code (Pete=
r Maydell)
220869aae1: hw/arm/smmu: Handle big-endian hosts correctly (Peter Maydell)
123b4291f9: virtio-net: pass Device-TLB enable/disable events to vhost (Vik=
tor Prutyanov)
8eed78e2bf: vhost: register and change IOMMU flag depending on Device-TLB s=
tate (Viktor Prutyanov)
5f3fe5657d: virtio-pci: add handling of PCI ATS and Device-TLB enable/disab=
le (Viktor Prutyanov)
0827053612: target/loongarch: Fix the CSRRD CPUID instruction on big endian=
 hosts (Thomas Huth)
c8b714f047: target/s390x: Fix assertion failure in VFMIN/VFMAX with type 13=
 (Ilya Leoshkevich)
c5498fdda0: target/s390x: Make MC raise specification exception when class =
>=3D 16 (Ilya Leoshkevich)
76507abbe1: target/s390x: Fix ICM with M3=3D0 (Ilya Leoshkevich)
e5e8a86064: target/s390x: Fix CONVERT TO LOGICAL/FIXED with out-of-range in=
puts (Ilya Leoshkevich)
6bd56e0f82: target/s390x: Fix CLM with M3=3D0 (Ilya Leoshkevich)
bdbf5e1016: target/s390x: Make CKSM raise an exception if R2 is odd (Ilya L=
eoshkevich)
6f7c39a912: tcg/{i386, s390x}: Add earlyclobber to the op_add2's first outp=
ut (Ilya Leoshkevich)
59a728a031: tcg/ppc: Fix race in goto_tb implementation (Jordan Niethe)
5a61789df8: qemu-nbd: regression with arguments passing into nbd_client_thr=
ead() (Denis V. Lunev)
bdfecfbc1d: qemu-nbd: fix regression with qemu-nbd --fork run over ssh (Den=
is V. Lunev)
feb0814b3b: qemu-nbd: pass structure into nbd_client_thread instead of plai=
n char* (Denis V. Lunev)
f90a8b9357: linux-user: Fix signed math overflow in brk() syscall (Helge De=
ller)
c4a4731408: linux-user: Prohibit brk() to to shrink below initial heap addr=
ess (Helge Deller)
0102c92a1c: linux-user: Fix qemu brk() to not zero bytes on current page (H=
elge Deller)
5de88d6e10: hw/nvme: fix endianness issue for shadow doorbells (Klaus Jense=
n)
0167759c9a: linux-user: Make sure initial brk(0) is page-aligned (Andreas S=
chwab)
35720b3d90: ui/vnc-clipboard: fix infinite loop in inflate_buffer (CVE-2023=
-3255) (Mauro Matteo Cascella)
d1063b6551: linux-user/arm: Do not allocate a commpage at all for M-profile=
 CPUs (Philippe Mathieu-Daud=C3=A9)
fa72d8bcf4: tcg: Fix info_in_idx increment in layout_arg_by_ref (Richard He=
nderson)
7b336dcd06: linux-user/syscall: Implement execve without execveat (Pierrick=
 Bouvier)
c280ac3b60: hw/ide/piix: properly initialize the BMIBA register (Olaf Herin=
g)
520d5fb4cb: target/mips: enable GINVx support for I6400 and I6500 (Marcin N=
owakowski)
b2b1b99da9: target/s390x: Fix LRA when DAT is off (Ilya Leoshkevich)
523f529d40: target/s390x: Fix LRA overwriting the top 32 bits on DAT error =
(Ilya Leoshkevich)
eefa524832: target/s390x: Fix MVCRL with a large value in R0 (Ilya Leoshkev=
ich)
aa308958e6: target/s390x: Fix MDEB and MDEBR (Ilya Leoshkevich)
70ba7cbf50: target/s390x: Fix EPSW CC reporting (Ilya Leoshkevich)
f48e3ec581: vfio: Fix null pointer dereference bug in vfio_bars_finalize() =
(Avihai Horon)
43462f7706: linux-user: Fix accept4(SOCK_NONBLOCK) syscall (Helge Deller)
741df485e8: linux-user: Fix fcntl() and fcntl64() to return O_LARGEFILE for=
 32-bit targets (Helge Deller)
73d6ac24c8: hw/ppc: Fix clock update drift (Nicholas Piggin)
720db12b8b: qemu_cleanup: begin drained section after vm_shutdown() (Fiona =
Ebner)
bcb1e0522e: virtio-net: correctly report maximum tx_queue_size value (Laure=
nt Vivier)

