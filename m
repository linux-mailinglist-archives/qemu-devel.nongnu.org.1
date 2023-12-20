Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC87781A51D
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:30:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzR1-0004Vi-C3; Wed, 20 Dec 2023 11:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rFzQy-0004Km-Vn
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:28:37 -0500
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rFzQw-0005BR-1P
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:28:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnK08CuWmnn3UnTmQXbPkpPqSme3KyST2u5Ydu/07LE0Upu70Jfee6HYHttnGmQKFlo1DehQUBcOW630OpB+Oiu938m67VG7eiVNpO+gq48cN5DHytBE2irVa+hxUey/DE/NumnNAunUKoZWwrZaJRHRPYr1MymJHJzG4eTXjf+1sKXJUpwSyZmVKGm+UCr56FeBT5O1SEFHwG0KBI1AwF4QYgCRTAxo4FBRYdaeDvkdkZLDnb2gWjGEiG38KG8/ubUZ7yEchZcvKLTzEB5ltCZFfsU6qRfaiwlW9Vu5D17y0e/EzJtOm2ADifhMT68IFXna620Fl6/SIAuMY43N5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Apg5JLVzQ3OS3boX+9pEsRmgrC3kmqNXhFRIaWwu0Rc=;
 b=kjwTfWfQXv2HJv8+J5gJOKDE46A0jZSGOVXxqtS+oKUnnRe7HIeYcjHIItBWA5vNJi4fFMnky+e9SR2/JuJC2Shu/nUaWt1Q8HWSfk2ygrmofpjJ9HDlVfYazSLTYpgAHIQWedBuCxweXuFdAJKt7kWOAqPS8EibBbCY6LXno2yKVB2OJ3iV8u92AOgjCWucKDHba3d/+X4vznbC2QOpVxH0ypCggF4guhuTndmLZHR8Mh7FyCKLfIHbRpgJpwXXmN63S44T5swV+hvpT83WuQ5aqLiXpPhAKrb2mPFF/c6FyORs/JDVX2IG1YUaoPy20SjLWoUSDIo28yke0yZwKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Apg5JLVzQ3OS3boX+9pEsRmgrC3kmqNXhFRIaWwu0Rc=;
 b=rROqA65sE1nHLZKlCP3ZizjfX+XnUr8+UttSO+snZjbz7kqdOVvv7onK11GwtZv/cyOgnHdIp4ZCpGs4/oqbXKELRCs95xHWzzLU0RZrFDESXLdHF7nYT2XdkeXw4YOIG4c1u+aWKokDmVe/STT6FC/VxpArwvO5rON2kt2M8XU=
Received: from MW4PR04CA0381.namprd04.prod.outlook.com (2603:10b6:303:81::26)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19; Wed, 20 Dec
 2023 16:28:26 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:81:cafe::2b) by MW4PR04CA0381.outlook.office365.com
 (2603:10b6:303:81::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 16:28:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.18 via Frontend Transport; Wed, 20 Dec 2023 16:28:25 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:28:18 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 8.2.0 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 20 Dec 2023 10:28:04 -0600
Message-ID: <170308968490.45831.9473692593401759350@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|BY5PR12MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: b20008cc-2be3-417f-4254-08dc0178b111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsgsQecRNY4slR2S9JywYrwOByQe6KXi53EvseARCfuN9hhdvEWnbjiaHbxbD1uVLTUaxXL/wuZ9mRQWlhqzPMwHgO6LJIrOGyQao84mx5YXvFslpDuLiYsy78+5Lw4y7dKjWyGrqQm8mOYxpQ6T/H/r1aOw3BHDQa1XPaY412LVSub9ENVvSEDN6OApLIB55+3olPsDNAtIT7yQPq2lTeTZDvS/yJ7yHt8O5PwfwA1TiT1C+8mSlkDh5Qr9TimjLehPo1pFXoLbAnrFkb9SKyOiBlKTB/04o/4rUYOURN2phnDI/UklOESS6VWrstk5sV0sN46VUdshWjaTyHApmtYdIBne9jBEJwDdWvWYko6c14UxiwmY6LHx2ACxXGnzoBuB+QeCtK1br4UocutDruXjZ80vIK7NwZC45FOaHnTdemmy4vrblARTqD5LhIlljpWoj2MpOK+KMkzjP24/AYNrFirW2TdT3OZ46accc68al5DWKyeJ42xjP51RLkgV3+ikHmk2bfrLcUuGpsRboCwca/+Rtm+A1krwRrxToJYOrDJOzapg5QhZYjT/fvjU2/IbRHvlUZELp8LYsMIwI7xhgDpRZYR2lQlaRfDVwIv0wNb0zMN7aSMRqlgo9FcC96tmIBxmWYP572kq0qZG76LznuZteO8Um1Sm+kCvQA8YAkmVMi+C+dAsYCd8zgNelskUaYqJDlaAu9GWNaXUZA/7EiQyIWhYou1q2ai8r/RgxZOlWb8ot2fWHTxsgFqK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(478600001)(6666004)(8676002)(8936002)(966005)(4326008)(356005)(26005)(16526019)(2616005)(70586007)(6916009)(316002)(70206006)(426003)(83380400001)(336012)(36756003)(86362001)(41300700001)(81166007)(82740400003)(44832011)(36860700001)(2906002)(47076005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:28:25.6763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b20008cc-2be3-417f-4254-08dc0178b111
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
Received-SPF: softfail client-ip=2a01:111:f400:7eae::601;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
the QEMU 8.2.0 release. This release contains 3200+ commits from 238
authors.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

The full list of changes are available at:

  https://wiki.qemu.org/ChangeLog/8.2

Highlights include:

 * New virtio-sound device emulation
 * New virtio-gpu rutabaga device emulation used by Android emulator
 * New hv-balloon for dynamic memory protocol device for Hyper-V guests
 * New Universal Flash Storage device emulation
 * Network Block Device (NBD) 64-bit offsets for improved performance
 * dump-guest-memory now supports the standard kdump format

 * ARM: Xilinx Versal board now models the CFU/CFI, and the TRNG device
 * ARM: CPU emulation support for cortex-a710 and neoverse-n2
 * ARM: architectural feature support for PACQARMA3, EPAC, Pauth2, FPAC,
   FPACCOMBINE, TIDCP1, MOPS, HBC, and HPMN0
 * HPPA: CPU emulation support for 64-bit PA-RISC 2.0
 * HPPA: machine emulation support for C3700, including Astro memory
   controller and four Elroy PCI bridges
 * LoongArch: ISA support for LASX extension and PRELDX instruction
 * LoongArch: CPU emulation support for la132
 * RISC-V: ISA/extension support for AIA virtualization support via KVM,=20
   and vector cryptographic instructions
 * RISC-V: Numerous extension/instruction cleanups, fixes, and reworks
 * s390x: support for vfio-ap passthrough of crypto adapter for protected
   virtualization guests
 * Tricore: support for TC37x CPU which implements ISA v1.6.2
 * Tricore: support for CRCN, FTOU, FTOHP, and HPTOF instructions
 * x86: Zen support for PV console and network devices

 * and lots more...

Thank you to everyone involved!

