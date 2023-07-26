Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7090762894
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 04:09:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOTwP-0006zg-8y; Tue, 25 Jul 2023 22:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qOTwH-0006vR-J4
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 22:07:49 -0400
Received: from mail-mw2nam10on2079.outbound.protection.outlook.com
 ([40.107.94.79] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qOTwE-00044i-Ed
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 22:07:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIxzHBPs0j5SjRuEnbU3ruqaCkATgwVu0JUShpOhg4zUADhvp7uEYcBSye7K4r7ybDqH2CRDdJvsQTWHWmW6W1OK3u9vYxDgnSGH4wHTHoZEgsVQcE4N0E9MNUFxbvVY0DC6hMxjymC2LGAEqWFNeuje5GTvHnFlJwbDUg2FYtKCoJ9+WmiL08IjGpMm1f1yUzEvZOkg70O51BuyRToO6S377vvL7MJumX7mFmP3+iRumIZmKlB6RayVuS1LMEVo/etdqOb62WX5m4wWXUGQ+3NditA4qxjYx0lxqHcLS3irXpffzfcXYxtO5t2jwKor/C50UknTZQnfgiuJ9T2AFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8AWUAJrtjB68EqImnYDDbkLijGL6eXwM7ZCRcvmUDk=;
 b=RfaUcCp2mmbzA9BA+0zmWOUDDYXoWolJa/TSyQjEHFA1AJrKtK3N6i7SxVSsQUzRn8tNXa2aaB9IdR7wWSJ+EM9QxqovbHzOnvriDncbya+ZVV4GoKa8AoHPoCElipIti7b9F8FTF6ZLPrHxooQAXfeYM0xxxiI6QXk1dNoLq5Vb4dhITzFplHI9HIfHh7AYMcTNJSojwvNElIl90Azp56vJJ34mWgtbG+K5f/PSVKbLMUFam3CgUly9R3Ajtb79LZ8+/bQS+0EHJo7zilcYr7KtJFxswg1drQx4BsE26K04qsMJsonMJXoAaFI5yDY1bLM2/CW3TVvAGx55t3eTTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8AWUAJrtjB68EqImnYDDbkLijGL6eXwM7ZCRcvmUDk=;
 b=hC86L91zprFZlQysWQ+UVj6Kci+9rzZUOjCJUD+h7Hh7oIsV42+Gf1oL6bEmDcSfy1YOCySXOZAJJJvJHatoosI15JM0Xl57GjbOA5Dd9EJfaTgh86C5CXXwqePVkN6cR0YMLMb7WC2okB+Bklvkin4MBLQl7bYpivoja+QvgNY=
Received: from SJ0PR13CA0209.namprd13.prod.outlook.com (2603:10b6:a03:2c3::34)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 02:02:33 +0000
Received: from DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c3:cafe::d6) by SJ0PR13CA0209.outlook.office365.com
 (2603:10b6:a03:2c3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25 via Frontend
 Transport; Wed, 26 Jul 2023 02:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT083.mail.protection.outlook.com (10.13.173.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 02:02:32 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 21:02:32 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 8.1.0-rc1 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>
Date: Tue, 25 Jul 2023 21:01:23 -0500
Message-ID: <169033688378.327176.9271619768832276311@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT083:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: e559b645-fd63-45bd-ee36-08db8d7c5ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GIr0iKQv8Z9ME1+Z9AEBxPhpoKS9VQ2TW0YGUUtIszjQDy2+p80IW/L6rGEXDZZuBQZxnrYOf3xl1u9et+gmp/H1lznAeG3Cg5a/EDOEfqNbnypuCEKCuJdAPx9jC7nAgylpH6ejJzhb187mHaYExU1Yb4bvL/s+WTXbwn6tcNyHqrFKgrekpWEajxEEksVYrB2U1zT0t7a/6P9gkNlO+QozszSko0oQI/WoArrvwm4tBijHjKPgRVg3ZBOgIdG31lqstdfTH1FlhcWP0itv0UHmyYapZJM/ScHG/Ud3udeLoTnOdw6EXQRWs3UNhYKLyR0JLFAyAUaQCJXiaDUYjvple9r+u+fgk1HHTh5R13Lfd8HzeBjAYKbaL2lHquPHT5S/AUH9HxC6twfk2xxZ3QS3WCwlFO3pZ0Q0R+iFR/tXnNCUD3rsPDa535nd4z5fg3aGdOlnn0Kdo9GclBSvo5Hgok4OgC8OwxLd2GzdrqTZQWNUAwtIaquaa056uZpW9FmgX4us9nvRp8bdTjXuSdc4hOIMTuaRz+PanyaRuyUVQJJF3vwsBNTZp1Wg/uAmqaTGpkudVzKlT/CxxiXQPshfR8GHjKa+n73nCFOCIZyzLg9+uNBQ8lSsjtqqU6jE7CVoWKsIptkagHumiNObndnO9X/HxiWv8KR2uFvCA9maI5g3qo9bz7Yu/wrESPNL4oJ7lcsga2CZ6U6RQibuVmyaei/u/wc2SpHnjjZPo+x/M5OBnFqeQ0RNzklq6p2N
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(36756003)(86362001)(81166007)(356005)(40460700003)(2906002)(478600001)(82740400003)(40480700001)(36860700001)(83380400001)(2616005)(26005)(186003)(426003)(336012)(47076005)(16526019)(44832011)(41300700001)(8676002)(5660300002)(6666004)(966005)(8936002)(316002)(6916009)(4326008)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 02:02:32.8017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e559b645-fd63-45bd-ee36-08db8d7c5ffa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805
Received-SPF: softfail client-ip=40.107.94.79;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
second release candidate for the QEMU 8.1 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-8.1.0-rc1.tar.xz
  http://download.qemu.org/qemu-8.1.0-rc1.tar.xz.sig

You can help improve the quality of the QEMU 8.1 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/8#tab-issues

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/8.1

Please add entries to the ChangeLog for the 8.1 release below:

  http://wiki.qemu.org/ChangeLog/8.1

Thank you to everyone involved!

Changes since rc0:

6cb2011fed: Update version for v8.1.0-rc1 release (Peter Maydell)
ff62c21016: qapi: Correct "eg." to "e.g." in documentation (Markus Armbrust=
er)
67d045a0ef: hw/pci: add comment to explain checking for available function =
0 in pci hotplug (Ani Sinha)
8c0e8ed327: target/tricore: Rename tricore_feature (Bastian Koppelmann)
28cbbdd28e: hw/9pfs: spelling fixes (Michael Tokarev)
8b81968c1c: other architectures: spelling fixes (Michael Tokarev)
673d821541: arm: spelling fixes (Michael Tokarev)
cced0d6539: s390x: spelling fixes (Michael Tokarev)
d8b71d96b3: migration: spelling fixes (Michael Tokarev)
f8cfdd2038: target/tricore: Rename tricore_feature (Bastian Koppelmann)
ca4d5d862d: target/sparc: Handle FPRS correctly on big-endian hosts (Peter =
Maydell)
0fe4cac5dd: target/mips: Avoid shift by negative number in page_table_walk_=
refill() (Peter Maydell)
60a38a3a57: target/mips: Pass directory/leaf shift values to walk_directory=
() (Philippe Mathieu-Daud=C3=A9)
fb51df0c8e: target/mips/mxu: Avoid overrun in gen_mxu_q8adde() (Philippe Ma=
thieu-Daud=C3=A9)
e37fdc7381: target/mips/mxu: Avoid overrun in gen_mxu_S32SLT() (Philippe Ma=
thieu-Daud=C3=A9)
d4eda549d2: target/mips/mxu: Replace magic array size by its definition (Ph=
ilippe Mathieu-Daud=C3=A9)
02388b5925: hw/char/escc: Implement loopback mode (Thomas Huth)
5fc1a68660: hw/mips: Improve the default USB settings in the loongson3-virt=
 machine (Thomas Huth)
3b83079015: hw/sd/sdhci: Do not force sdhci_mmio_*_ops onto all SD controll=
ers (Bernhard Beschow)
78cc90346e: tests/decode: Suppress "error: " string for expected-failure te=
sts (Peter Maydell)
9b579543d7: For curses display, recognize a few more control keys (Sean Est=
abrooks)
5d78893f39: target/arm: Special case M-profile in debug_helper.c code (Pete=
r Maydell)
f9540bb1b2: scripts/git-submodule.sh: Don't rely on non-POSIX 'read' behavi=
our (Peter Maydell)
c6445544d4: hw/arm/smmu: Handle big-endian hosts correctly (Peter Maydell)
bd39b7b5f3: tests/avocado/machine_s390_ccw_virtio: Skip the flaky virtio-gp=
u test by default (Thomas Huth)
c34ad45992: target/loongarch: Fix the CSRRD CPUID instruction on big endian=
 hosts (Thomas Huth)
71a00a5bae: tests/avocado/migration: Remove the malfunctioning s390x tests =
(Thomas Huth)
241ab36c0a: tests/tcg/s390x: Test VCKSM (Ilya Leoshkevich)
e11e2fc6fb: tests/tcg/s390x: Test STPQ (Ilya Leoshkevich)
eacfe7cbbd: tests/tcg/s390x: Test MC (Ilya Leoshkevich)
f383b2f770: tests/tcg/s390x: Test ICM (Ilya Leoshkevich)
285a672d29: tests/tcg/s390x: Test CLM (Ilya Leoshkevich)
372886d2ae: tests/tcg/s390x: Test CLGEBR and CGEBRA (Ilya Leoshkevich)
f6044c994a: tests/tcg/s390x: Test CKSM (Ilya Leoshkevich)
ff537b0370: target/s390x: Fix assertion failure in VFMIN/VFMAX with type 13=
 (Ilya Leoshkevich)
9c028c057a: target/s390x: Make MC raise specification exception when class =
>=3D 16 (Ilya Leoshkevich)
a2025557ed: target/s390x: Fix ICM with M3=3D0 (Ilya Leoshkevich)
53684e344a: target/s390x: Fix CONVERT TO LOGICAL/FIXED with out-of-range in=
puts (Ilya Leoshkevich)
4b6e4c0b82: target/s390x: Fix CLM with M3=3D0 (Ilya Leoshkevich)
761b0aa938: target/s390x: Make CKSM raise an exception if R2 is odd (Ilya L=
eoshkevich)
32b120394c: accel/tcg: Fix type of 'last' for pageflags_{find,next} (Luca B=
onissi)
8c605cf1d4: accel/tcg: Zero-pad vaddr in tlb_debug output (Anton Johansson)
22d2e5351a: tcg/{i386, s390x}: Add earlyclobber to the op_add2's first outp=
ut (Ilya Leoshkevich)
2c8412d469: accel/tcg: Take mmap_lock in load_atomic*_or_exit (Richard Hend=
erson)
f1ce0b8028: accel/tcg: Fix sense of read-only probes in ldst_atomicity (Ric=
hard Henderson)
990ef9182b: include/exec: Add WITH_MMAP_LOCK_GUARD (Richard Henderson)
736a1588c1: tcg/ppc: Fix race in goto_tb implementation (Jordan Niethe)
dcaaf2bf9b: roms/opensbi: Upgrade from v1.3 to v1.3.1 (Bin Meng)
4ea3fa99be: Revert "linux-user: Fix qemu-arm to run static armhf binaries" =
(Michael Tokarev)
bfe04d0a7d: nbd: Use enum for various negotiation modes (Eric Blake)
70fa99f445: nbd/client: Add safety check on chunk payload length (Eric Blak=
e)
8cb98a725e: nbd/client: Simplify cookie vs. index computation (Eric Blake)
22efd81104: nbd: s/handle/cookie/ to match NBD spec (Eric Blake)
66d4f4fe2f: nbd/server: Refactor to pass full request around (Eric Blake)
a7c8ed36bf: nbd/server: Prepare for alternate-size headers (Eric Blake)
8d2931dc85: nbd: Consistent typedef usage in header (Eric Blake)
f47b6eab83: nbd/client: Use smarter assert (Eric Blake)
414c0cf0e8: qemu-nbd: make verbose bool and local variable in main() (Denis=
 V. Lunev)
173776f74d: qemu-nbd: handle dup2() error when qemu-nbd finished setup proc=
ess (Denis V. Lunev)
e0892ced05: qemu-nbd: properly report error on error in dup2() after qemu_d=
aemon() (Denis V. Lunev)
1dc8215118: qemu-nbd: properly report error if qemu_daemon() is failed (Den=
is V. Lunev)
5c56dd27a2: qemu-nbd: fix regression with qemu-nbd --fork run over ssh (Den=
is V. Lunev)
03b6762144: qemu-nbd: pass structure into nbd_client_thread instead of plai=
n char* (Denis V. Lunev)
518f32221a: linux-user: Fix qemu-arm to run static armhf binaries (Helge De=
ller)
d971040c2d: linux-user: Fix strace output for old_mmap (Helge Deller)
eac78a4b0b: linux-user: Fix signed math overflow in brk() syscall (Helge De=
ller)
dfe49864af: linux-user: Prohibit brk() to to shrink below initial heap addr=
ess (Helge Deller)
15ad98536a: linux-user: Fix qemu brk() to not zero bytes on current page (H=
elge Deller)
fd658a7b8c: migration.json: Don't use space before colon (Juan Quintela)
5034e3d4e8: qapi: better docs for calc-dirty-rate and friends (Andrei Gudko=
v)

