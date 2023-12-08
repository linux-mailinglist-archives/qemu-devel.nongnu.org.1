Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5E4809FC2
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 10:46:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBXQo-0003GP-51; Fri, 08 Dec 2023 04:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rBXQm-0003Fl-M0
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:46:00 -0500
Received: from mail-dm6nam04on2052.outbound.protection.outlook.com
 ([40.107.102.52] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rBXQj-0004fF-Sr
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:46:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGLyUWCkuGh6ph2RWw67niDtU0s3Hxc6VBPqXWg/BUIx/GhiDT1ghDMoewdRUEIuD8QpsZomBmPZRyPa1Z6YhXbPoOQ/CJeYnwkJDdFd4ZBDZuTjj8T0X4ipC/k5EjG7X1vnDQx1XX/5W3OKnsM3wTNYeXxA+4VQXss9Y5AuvEIKXp2eJ8hobKUGzP1ODRPp7KYePq/isL74oGTDJvfvDCsXtf4ufbEBCuc0w72nLV8KwVDyVOYXR86xrlV4MMqXUz6B1jATD6rchTBo3dwuWJwkHCy+Zi2aSugo/mSxM+UcNvF+E87NKeqgS9Chl62zEtw6V9JLA43pxkcJNCcGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Al8rBbsBkp0c7jVj2DFFZVZiTulGPD8TwfMQRQyJJQw=;
 b=IPtVY/m3w/2CEIYkzjg2Ip8+1dSTpwEH1lAN76/EcXo29iPhsIvpt38v8FHia5FfrZITwjdxwgX0G7LTXelSBimUvaVBvJmO+D12sbsLphcEJdjZFbztzV/ebKuScqLmLvgVUti9zt0racgU4nYhuGeu2/XedzoZw9R7KFrWG/srpH1YZxPX4wrlc3Ko7ErMIs3q7TfXI8b7DsYc50T5i39eE0xAONEGwQ3j3n+ZvW3hro0PPB+5y8RbxK6HGj+9olt4683a4yClweVcFqbQCHm0cRNVNWmnJEprVKDQLvBYsI6h+2H4acqCqsrF6wQPSmJaULkjQIGom8p0abteoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Al8rBbsBkp0c7jVj2DFFZVZiTulGPD8TwfMQRQyJJQw=;
 b=STLCT9/X3q4J3cMmkUPwrGar66igkDMkVS85LHC1MIK3YJcjBg5HiwDo08W83w4jHsZaNKt9jU22DIdl1kcwsdrnspujB/SxnF/iwkWUa6bnN3hb/JCX47x7vmZD8VBEWKi3cJdC4kiuwJy8UA7gWEn+lxmEzeFJwELsBRlhdR0=
Received: from MWH0EPF00056D04.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:c) by PH8PR12MB7133.namprd12.prod.outlook.com
 (2603:10b6:510:22e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 09:40:51 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2a01:111:f403:f807::1) by MWH0EPF00056D04.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.4 via Frontend
 Transport; Fri, 8 Dec 2023 09:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.2 via Frontend Transport; Fri, 8 Dec 2023 09:40:50 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 8 Dec
 2023 03:40:49 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 8.2.0-rc3 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <stefanha@redhat.com>
Date: Fri, 8 Dec 2023 03:40:25 -0600
Message-ID: <170202842591.1293793.12677199556934080728@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 8710b38d-9d88-45e9-dcfb-08dbf7d1c3db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M5dnPQfHPwLFbk6jwuIXUv1BxKVAnkYK8L2/avdIjwJNdfdyze6Xn/I2G2o75VuUo7SLeEIMMXrV8WYG7PVUuzADXgjv3XvGJASSrvT/WEbxfJwe9GqOMQuD9HiVtT3EJ9O7hyulGXIgGLp77tcdrAaofl35yhPUFjodXYr2RgpbmUJl0WMHlK9+sQCoW8CJsKJrX+0RCDkqoF1CnTaFDC2NIPBVL/Pr/+2OuJAy1p43oh25hZNywJwj+KHO+oGhcizExNbgBF37bv5vrS3TtCvmERbX60hM3bKmTTsBx2HeAfz3CBNjG4ilW4/1gqIiMPjAFCSolJU5lKHkWCcnrbsGfZJpf/6/aZXaxGHpuJIdKwvVY4goDtDXKOts8PFoBORgryRRwaUkKOurO6jP/uIyz02GpVfV4aYztl6GCCJFKAr/8wxmJ1FFb9DCeLkZCFi9eAiEH9g+6l4VA4hos136sL2dVgkNuAvrJ6eWPlmXtgdVLfF3Wh+XYTR0pcc/AMZFk21S1rO6rcMBV++d9GuYwzvU5ZrQgJTDhR+oBh/wPVsKy1t6MMkwqyD6P/aOTtbZkCunU7vdt8bBodxowzOK5AIim3EAMCpWdKFOsOnkTXtC35AQ1YhasrXQQioG4lALjUEUa05fqUV4fjp/pmYwb1McNZBBpwpNTZ68/DGGpdsTBLxW5lF/7o9g994kWjE5KsvN6Sm+4Y8sd6QQ/gtaDq31922wWrpWyGWd0+trwZ2OmXwdDW7BUZoYW98Q3W2qtmlOf53AQEipDeMwNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(82740400003)(26005)(16526019)(336012)(426003)(6666004)(2616005)(66574015)(83380400001)(5660300002)(4326008)(41300700001)(47076005)(36860700001)(44832011)(8936002)(19627235002)(8676002)(966005)(478600001)(2906002)(70206006)(6916009)(316002)(70586007)(81166007)(86362001)(356005)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 09:40:50.7686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8710b38d-9d88-45e9-dcfb-08dbf7d1c3db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
Received-SPF: softfail client-ip=40.107.102.52;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
fourth release candidate for the QEMU 8.2 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-8.2.0-rc3.tar.xz
  http://download.qemu.org/qemu-8.2.0-rc3.tar.xz.sig

You can help improve the quality of the QEMU 8.2 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/10

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/8.2

Please add entries to the ChangeLog for the 8.2 release below:

  http://wiki.qemu.org/ChangeLog/8.2

Thank you to everyone involved!

Changes since rc2:

9c74490bff: Update version for v8.2.0-rc3 release (Stefan Hajnoczi)
5746f70d68: i386/sev: Avoid SEV-ES crash due to missing MSR_EFER_LMA bit (M=
ichael Roth)
80a37b039e: hw/ufs: avoid generating the same ID string for different LU de=
vices (Akinobu Mita)
2e8ed6a970: tests/avocado: mark ReplayKernelNormal.test_mips64el_malta as f=
laky (Alex Benn=C3=A9e)
d369ad5558: tests/avocado: Update yamon-bin-02.22.zip URL (Philippe Mathieu=
-Daud=C3=A9)
560b8e1d70: target/riscv/kvm: fix shadowing in kvm_riscv_(get|put)_regs_csr=
 (Daniel Henrique Barboza)
2b8fe81b3c: system/memory: use ldn_he_p/stn_he_p (Patrick Venture)
4d98618b8a: tests/qtest: check the return value (Zhu Jun)
5533936127: sh4: Coding style: Remove tabs (Yihuan Pan)
5689d4bda6: tests/qemu-iotests/149: Use more inclusive language in this tes=
t (Thomas Huth)
f7767ca301: target/arm: Disable SME if SVE is disabled (Peter Maydell)
1664d74c50: tests/avocado: Update yamon-bin-02.22.zip URL (Philippe Mathieu=
-Daud=C3=A9)
551ef0fa05: hw/audio/virtio-sound: mark the device as unmigratable (Volker =
R=C3=BCmelin)
ebfbf39467: ui/vnc-clipboard: fix inflate_buffer (Fiona Ebner)
53a939f1bf: ui/gtk-egl: move function calls back to regular code path (Volk=
er R=C3=BCmelin)
95e1019a4a: vhost-user-scsi: free the inflight area when reset (Li Feng)
298d4f892e: vhost-user: fix the reconnect error (Li Feng)
2d37fe9e5e: msix: unset PCIDevice::msix_vector_poll_notifier in rollback (R=
obert Hoo)
c8559fcb15: virtio-iommu: Remove useless !sdev check in virtio_iommu_probe(=
) (Eric Auger)
c04cfb4596: hw/i386: fix short-circuit logic with non-optimizing builds (Da=
niel Hoffman)
20bc50137f: hw/acpi/erst: Do not ignore Error* in realize handler (Philippe=
 Mathieu-Daud=C3=A9)
714a1415d7: pcie_sriov: Remove g_new assertion (Akihiko Odaki)
f785618184: virtio-sound: add realize() error cleanup path (Manos Pitsidian=
akis)
691d3d8bbd: virtio-snd: check AUD_register_card return value (Manos Pitsidi=
anakis)
e60bdfb78e: hw/audio/hda-codec: reenable the audio mixer (Volker R=C3=BCmel=
in)
74e8593e7e: hw/audio/hda-codec: fix multiplication overflow (Volker R=C3=BC=
melin)
c44f4263b2: hw/audio/virtio-snd-pci: fix the PCI class code (Volker R=C3=BC=
melin)
de35244e99: tests/acpi/bios-tables-test: do not write new blobs unless ther=
e are changes (Ani Sinha)
5d25fcb702: gitlab: add optional job to run flaky avocado tests (Alex Benn=
=C3=A9e)
aeb5f8f248: gitlab: build the correct microblaze target (Alex Benn=C3=A9e)
970c6fc250: tests/avocado: tag sbsa tests as tcg only (Alex Benn=C3=A9e)
bc1d54ee51: migration: Plug memory leak with migration URIs (Het Gala)
9b45cc9931: docs/devel: rationalise unstable gitlab tests under FLAKY_TESTS=
 (Alex Benn=C3=A9e)
5dcf6334ae: gdbstub: use a better signal when we halt for IO reasons (Alex =
Benn=C3=A9e)
cadfc72939: netdev: set timeout depending on loadavg (Michael S. Tsirkin)
dc864d3a37: osdep: add getloadavg (Michael S. Tsirkin)
e25acd6191: ppc/amigaone: Allow running AmigaOS without firmware image (BAL=
ATON Zoltan)
c1dc0a1deb: pseries: Update SLOF firmware image (Alexey Kardashevskiy)
41581265aa: migration: free 'saddr' since be no longer used (Zongmin Zhou)
0a08c7947b: migration/multifd: Stop setting p->ioc before connecting (Fabia=
no Rosas)

