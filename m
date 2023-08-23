Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91702784F3E
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 05:26:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYeUz-0007jT-Fi; Tue, 22 Aug 2023 23:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qYeUv-0007j7-Jz
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 23:25:33 -0400
Received: from mail-mw2nam10on2047.outbound.protection.outlook.com
 ([40.107.94.47] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qYeUs-0006Zk-SA
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 23:25:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvVQnmf0G404ZeqVuQbkYoPP45N03ZcaWsAXLi4MjvbN1zm0opLKTQpPEpZjWEU82J77xy4boSaHPKzgwxwSgO2luY3mhpO0bnSSQ+PbnTqmkYEAElV9nNWk8Suuudo1kpKx4l2zAjX9HLc3/yDaqI0X/EwkqFXFKSM+IEvLXidJIg/RubudP1A0M6EKlEOqgbyErbOYUADVyQb0OeYD1N9EiPCjpZPxABo2KoRZaaONtCx0f+zjGAp1FgsCQUoBZvTRux7HDO6XnOHBBWsIILnYYN0MY7lErRV3gKmhXB9C1XKml7RNtMUOZ1VCIzUY3ZVi84IRNlDKSXjbwY5OhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCqiUmBPenTpgY9tsW476KC8mk7QvSzNYVG46UOxTNM=;
 b=VU9C/cKnf/jm7qQVrU1WqEfNE00N99ocMlAGvxwq/lBR/so4f/rIUdv4L3lhWZy++t+/bp5fbJVetljKUUEtx26+7rC16OGnO43xhZFALw/MyoveYIJxcWjCR4VPsN+Puo0aY/sXvG/JDwGzTDe0xo3hsakKzshbtMSmZu2w4qf8xA7UYEGYEMMiL/2nfx/ZeiNQFWrgWQ8DmIsZhzgSz1yUVB40+D9bnxE5OdJTncQeVgs9vgio4sX7KVV7NlSQ2UGGZLLBj1pZfw1YgQ6X8vLl4Sv6bawB2QT5cmKsN0jZcNdvOtTwLtLvfhm3iL5fXF0QOZRvUYF4X8zmGS26gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCqiUmBPenTpgY9tsW476KC8mk7QvSzNYVG46UOxTNM=;
 b=oNganvyuk2XdG/U/tbnQbIWnIRWws6SQzO2G+jv9RKmEYGakKXm6/oFJ337mKYyUXpR5WjeBVn9zfN5Rj7sBAKG8gcBlfH0men6TC4LhXOaVbts+V52KZV/0k7awh3lZG+wwIJh28f1x3fg5upyzt/QkOODG+VCfhO5mhADriKc=
Received: from BYAPR11CA0047.namprd11.prod.outlook.com (2603:10b6:a03:80::24)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 03:20:24 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:80:cafe::e2) by BYAPR11CA0047.outlook.office365.com
 (2603:10b6:a03:80::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Wed, 23 Aug 2023 03:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 03:20:23 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 22 Aug
 2023 22:20:22 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 8.1.0 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 22 Aug 2023 22:20:06 -0500
Message-ID: <169276080629.2012937.11174907503008398998@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b05afc-d672-471d-ca19-08dba387e369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ONs9pwrAxsea0MnHxuw8cTqUImS9siNVCh9eRAZpW3zZkyZq3X4ZV6uTqZqfMdQpIxjdpY6qTZMX7I0cNh3RoUvGwehfseMlJcnPVkKpvbDWNhxlpNZhe6+DRXMchVglJeJxuDw5Taw1YFO+0kd5F9AdK9VQ+tiN2Ho9zR0G+M5X9tM7gm1M7kVOsxtNXepuLe7Av7Lq99aVCgevirFJORJQJ/1lc6QgGu3nh/cNfjt0Md0AUIXXBSmejWhDFklyZ8OabafQ3AGnGTVQGu3S6uyYkrN8F9rgJDW4yCbeJvOppGOJvNJHkFN11pVXJ80PVAGx7bmbFW65S2smcKWUU86JUsVDlpTbcn0pCpNQ7MAnJeFvEhlwxjE+ATiWJEmfACYySEbanSuWgEpy5QqmdDPvtfhD9vHgYo7QNogkd6oBTWZMqSAW4vdMv57l3d2pGJCZlhunqBk/PRu7vceCxa7qdh1Sbwc14OiWNZQxMBJ6XTRejq38F74v2aF1lZf056dG+p9RMVHeScER02HFbs70wfXy7PwH7sYb0erwILgsrOIBDiq62TWLnFxMsR+VQcAUZ2KX6sTws74rZESkSPZ2F6LlmsPehxp8D+pAwTCSPRwwomc9iZ3jTeHYK/sLOmvwUr3XKXnkiiTB8pbgZC0a4gb2Aa7hxDiNplxR5EKJ/j/VdZSQJaPmhJ33R23zMJ0r2QnxfkOQ5bt5r/ww2El9nrFFDuA+CHnMCfNzc3yMaeyIKIBNu4gdl1WHsH7WLbCTQTxgd+ZKJcFjgR9oqmzG3HsU61Zc9CPRHatCEMI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(1800799009)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(86362001)(40460700003)(36756003)(40480700001)(44832011)(26005)(5660300002)(2616005)(16526019)(336012)(426003)(4326008)(8936002)(8676002)(47076005)(2906002)(83380400001)(478600001)(966005)(70206006)(70586007)(316002)(6916009)(41300700001)(6666004)(356005)(82740400003)(81166007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 03:20:23.2924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b05afc-d672-471d-ca19-08dba387e369
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301
Received-SPF: softfail client-ip=40.107.94.47;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of
the QEMU 8.1.0 release. This release contains 2900+ commits from 250
authors.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

The full list of changes are available at:

  https://wiki.qemu.org/ChangeLog/8.1

Highlights include:

 * VFIO: improved live migration support, no longer an experimental feature
 * GTK GUI now supports multi-touch events
 * ARM, PowerPC, and RISC-V can now use AES acceleration on host processor
 * PCIe: new QMP commands to inject CXL General Media events, DRAM events a=
nd
   Memory Module events

 * ARM: KVM VMs on a host which supports MTE (the Memory Tagging Extension)
   can now use MTE in the guest
 * ARM: emulation support for bpim2u (Banana Pi BPI-M2 Ultra) board and
   neoverse-v1 (Cortex Neoverse-V1) CPU
 * ARM: new architectural feature support for: FEAT_PAN3 (SCTLR_ELx.EPAN),
   FEAT_LSE2 (Large System Extensions v2), and experimental support for
   FEAT_RME (Realm Management Extensions)
 * Hexagon: new instruction support for v68/v73 scalar, and v68/v69 HVX
 * Hexagon: gdbstub support for HVX
 * MIPS: emulation support for Ingenic XBurstR1/XBurstR2 CPUs, and MXU
   instructions
 * PowerPC: TCG SMT support, allowing pseries and powernv to run with up to=
 8
   threads per core
 * PowerPC: emulation support for Power9 DD2.2 CPU model, and perf sampling
   support for POWER CPUs
 * RISC-V: ISA extension support for BF16/Zfa, and disassembly support
   for Zcm*/Z*inx/XVentanaCondOps/Xthead
 * RISC-V: CPU emulation support for Veyron V1
 * RISC-V: numerous KVM/emulation fixes and enhancements=20
 * s390: instruction emulation fixes for LDER, LCBB, LOCFHR, MXDB, MXDBR,
   EPSW, MDEB, MDEBR, MVCRL, LRA, CKSM, CLM, ICM, MC, STIDP, EXECUTE, and
   CLGEBR(A)
 * SPARC: updated target/sparc to use tcg_gen_lookup_and_goto_ptr() for
   improved performance
 * Tricore: emulation support for TC37x CPU that supports ISA v1.6.2
   instructions
 * Tricore: instruction emulation of POPCNT.W, LHA, CRC32L.W, CRC32.B,
   SHUFFLE, SYSCALL, and DISABLE
 * x86: CPU model support for GraniteRapids

 * and lots more...

Thank you to everyone involved!

