Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A7577971E
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 20:32:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUWud-0005qL-63; Fri, 11 Aug 2023 14:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qUWuM-0005fK-P8; Fri, 11 Aug 2023 14:30:47 -0400
Received: from mail-bn8nam12on2051.outbound.protection.outlook.com
 ([40.107.237.51] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qUWuG-0004w0-UH; Fri, 11 Aug 2023 14:30:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnW2YYUT20SFPR/8IHin4oMfPcxg5N8eXnl0ciLCEB33jFB9v/uVYh2KjdcIzpjWyaxe1XfboO70tj9nS6HEOSWHpcbSt5nEfdKcJDSKVbdomsGur5D6n0CpEtMfiLZ8wVfERq2SETAxW0HXLF1mJaPdfrWt4TbdZzx5/ZdJ3pAq7WdE8sNFXCP7ppMTUKUivmEp2OIqzY4Jcl9a2ubsF+jDRzcMioSW8GQMFkd7yfkjCDDY60XMeGKIzk37almKdLI96TEmq+IiV2kMnLWMyQrCr7bjNJGNovzlMKwWOlJkJTdKvYM/y2cjB7HN3OowG2S/i3KCJUZ6YJcS8JstXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02L0eMcZmKBl0e5ESV6pQXbHO8v12kfhpnwcwsBrrgk=;
 b=oZ1yd/XM87fG72SK+sMfAj12mpBBACfO+ObxNZ5GEMyANTFADnLx3ceECzDONaXsjG1o0kPrkyWDbMgZThhlQBH2UlGHS2NhxAKU8CpDV0WsquE8g66UmFftM5NvMuYdX9aiQlUWI3gKT2DuKZiaIOIRmjRU/kVJkyM8Mk4Brd9YzsMNKUTJhEHmyY8ewDvgKkF0eq6YwmzDeNYZy2ABiv5GybjlbAPIlvt0KzXlwA87fYPlQeamdmBATzShIe/EmyyIydjSwNh15K0DcV1dwuzmlmpVQE5DfLhKM+MNxUYzRtZbWLfb8nRsJ1N4WM1znrSwPKxcdz9VenGj3NXnlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02L0eMcZmKBl0e5ESV6pQXbHO8v12kfhpnwcwsBrrgk=;
 b=g6/ng5HzwqbpyUXXQXTHuPp36egkBUaLuxF9QiujxbbzK+h7E8JlsIwHpAvHOXcxUMitgY6IZOOZiUBzYdsz6bGBX9DnbSqdUH2VMlBO7PU/79V1IO9BmKylP3O8eXMH5qgg0sxEfmq66Py+66eHcTi1drgP8P71FHZR/u/jsuI=
Received: from DS7PR03CA0196.namprd03.prod.outlook.com (2603:10b6:5:3b6::21)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 18:25:32 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::3f) by DS7PR03CA0196.outlook.office365.com
 (2603:10b6:5:3b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 18:25:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 18:25:31 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 13:25:28 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 7.2.5 Stable released
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-stable@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>
Date: Fri, 11 Aug 2023 13:19:32 -0500
Message-ID: <169177797222.1335611.13892941580262325189@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: ddae9d56-ffd0-4d6a-d880-08db9a9858d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5kPV1d0ZxydM2j8V09AOQm/OihZjBaCy7J4F0K85HZmrpQLF2QirL+q1rrkso/qRB+aTqDHxxrmAJE05WlNj09merU9RTDH29ZmzjM2AqzBF5HH6WqjbUsUZ+44wNQJGGr5N3ca8TAuH1WSG2t8A28SqLIBerTWy0tso4Od7QRSZ+CETyWZVZ56IGYyHAe0KD8zWa9Y2qz3IIZbexe4ZN0Yd/3RBYl7HrO190s8Hf95lBmgMMh0GA05mPwYy+GFxf+MTTseA09t1nGyr9cc0C1/mj/NlQlawaS1kdc03NCjIEziLkDoZxCke9YjBcaHsGc6/ZVtQYsvH4CNO3nLxGkZEa2nBsdnJ7sPI0i1T7FtA1TEJrpD/I1EVBVZgwc9Gy1Z8wgzCh0x3Nq2V5SEisCwMCmL6VVeCX9gN5WwtoR55j66TcNKmUAL/YJysVF0kukNc6FHiYAM8EKwCn1sjBLcXPR4WHjsKRDv3DuPnSt95P3HVtc91Hg+9oROjemXayHMy3xDGIQs+97YJwA4KweUtMuQu6+OcqbmZqLhEqYMf77dkxsJmzFfnJR1uwZS+xcQuZhIJEjevkIUxL1NK3ppvp0skFSUydAVA1/tDD8dXACIQ/NkFb4qdIgRWQ06l0f9BlViWuMsDpv0nzECMD5yeSQNyA1fBIjSv1huzxv5VIdtBtOYof1duHelDoJPAfyODEcNEfNYt0ZrgF3a/co3SGWUNEjfgYHWlH+F8pv2Uw4zoiHQy1JV5Lml4pJx6h3lkm/GmIRgrY6i48iKOwbpSUYdOizdUIPDVOdvNwUQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(186006)(451199021)(82310400008)(1800799006)(36840700001)(40470700004)(46966006)(966005)(40460700003)(36756003)(356005)(86362001)(40480700001)(81166007)(82740400003)(36860700001)(26005)(16526019)(47076005)(83380400001)(336012)(2616005)(478600001)(426003)(54906003)(6666004)(4326008)(6916009)(316002)(41300700001)(70206006)(8676002)(8936002)(44832011)(70586007)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 18:25:31.7036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddae9d56-ffd0-4d6a-d880-08db9a9858d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
Received-SPF: softfail client-ip=40.107.237.51;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The QEMU v7.2.5 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

v7.2.5 is now tagged in the official qemu.git repository, and the
stable-7.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-7.2?ref_type=3Dheads

This update contains general fixes for various architectures/subsystems,
including the following CVE fixes:

    virtio-crypto (CVE-2023-3180)
    QIOChannel (CVE-2023-3354)
    qemu-guest-agent w32 (CVE-2023-0664)
    VNC (CVE-2023-3255)

Please see the changelog for additional details and update accordingly.

Thank you to everyone involved!

CHANGELOG:

9abcf9776d: Update version for 7.2.5 release (Michael Tokarev)
5e4beb092d: target/i386: Check CR0.TS before enter_mmx (Matt Borgerson)
5a8fdead85: target/ppc: Fix VRMA page size for ISA v3.0 (Nicholas Piggin)
4afce84629: target/ppc: Fix pending HDEC when entering PM state (Nicholas P=
iggin)
74619c052d: target/ppc: Implement ASDR register for ISA v3.0 for HPT (Nicho=
las Piggin)
1306708795: vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mq()=
 (Hawkins Jiawei)
5e67da9668: vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mac(=
) (Hawkins Jiawei)
4e9a35dfa7: vdpa: Fix possible use-after-free for VirtQueueElement (Hawkins=
 Jiawei)
988eeb5930: vfio/pci: Disable INTx in vfio_realize error path (Zhenzhong Du=
an)
da6d0af41d: include/hw/i386/x86-iommu: Fix struct X86IOMMU_MSIMessage for b=
ig endian hosts (Thomas Huth)
b58abc4a2b: hw/i386/x86-iommu: Fix endianness issue in x86_iommu_irq_to_msi=
_message() (Thomas Huth)
fd02247083: hw/i386/intel_iommu: Fix index calculation in vtd_interrupt_rem=
ap_msi() (Thomas Huth)
31e7ef997e: hw/i386/intel_iommu: Fix struct VTDInvDescIEC on big endian hos=
ts (Thomas Huth)
bbe3627f44: hw/i386/intel_iommu: Fix endianness problems related to VTD_IR_=
TableEntry (Thomas Huth)
cf2be5881f: hw/i386/intel_iommu: Fix trivial endianness problems (Thomas Hu=
th)
1451a86f6d: pci: do not respond config requests after PCI device eject (Yur=
i Benditovich)
c9e7442882: target/hppa: Move iaoq registers and thus reduce generated code=
 size (Helge Deller)
35a60ba42c: virtio-crypto: verify src&dst buffer length for sym request (zh=
enwei pi)
c315f73841: hw/virtio-iommu: Fix potential OOB access in virtio_iommu_handl=
e_command() (Eric Auger)
5bbd092495: target/m68k: Fix semihost lseek offset computation (Peter Mayde=
ll)
93b4033433: target/nios2: Fix semihost lseek offset computation (Keith Pack=
ard)
4d92f848f1: target/nios2: Pass semihosting arg to exit (Keith Packard)
5c6b1b20da: io: remove io watch if TLS channel is closed during handshake (=
Daniel P. Berrang=C3=A9)
f120e4742c: xen-block: Avoid leaks on new error path (Anthony PERARD)
e4aae3f819: thread-pool: signal "request_cond" while locked (Anthony PERARD)
b629412e9d: qga/win32: Use rundll for VSS installation (Konstantin Kostiuk)
daa3277175: linux-user/armeb: Fix __kernel_cmpxchg() for armeb (Helge Delle=
r)
d53d3f07dc: target/ppc: Disable goto_tb with architectural singlestep (Rich=
ard Henderson)
26a49f9f62: target/arm: Avoid writing to constant TCGv in trans_CSEL() (Pet=
er Maydell)
8cce5d060a: hw/arm/smmu: Handle big-endian hosts correctly (Peter Maydell)
ec934266fd: virtio-net: pass Device-TLB enable/disable events to vhost (Vik=
tor Prutyanov)
9a541b2143: vhost: register and change IOMMU flag depending on Device-TLB s=
tate (Viktor Prutyanov)
61693479d8: virtio-pci: add handling of PCI ATS and Device-TLB enable/disab=
le (Viktor Prutyanov)
0c8e6ac989: target/loongarch: Fix the CSRRD CPUID instruction on big endian=
 hosts (Thomas Huth)
c1bdd3cdc4: target/s390x: Fix assertion failure in VFMIN/VFMAX with type 13=
 (Ilya Leoshkevich)
cdd6b6a764: target/s390x: Make MC raise specification exception when class =
>=3D 16 (Ilya Leoshkevich)
0ef0b83104: target/s390x: Fix ICM with M3=3D0 (Ilya Leoshkevich)
7cf3358451: target/s390x: Fix CONVERT TO LOGICAL/FIXED with out-of-range in=
puts (Ilya Leoshkevich)
34009bfd68: target/s390x: Fix CLM with M3=3D0 (Ilya Leoshkevich)
772caa5f23: target/s390x: Make CKSM raise an exception if R2 is odd (Ilya L=
eoshkevich)
3b80317c91: qemu-nbd: regression with arguments passing into nbd_client_thr=
ead() (Denis V. Lunev)
742612345a: qemu-nbd: fix regression with qemu-nbd --fork run over ssh (Den=
is V. Lunev)
6e216d21b5: qemu-nbd: pass structure into nbd_client_thread instead of plai=
n char* (Denis V. Lunev)
8f8a8f20f4: ui/vnc-clipboard: fix infinite loop in inflate_buffer (CVE-2023=
-3255) (Mauro Matteo Cascella)
2b6a75b78e: hw/ide/piix: properly initialize the BMIBA register (Olaf Herin=
g)

