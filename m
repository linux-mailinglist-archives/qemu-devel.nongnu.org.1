Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 255A676D983
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 23:29:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRJNy-00083g-TE; Wed, 02 Aug 2023 17:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qRJNw-00082L-52
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:28:00 -0400
Received: from mail-dm3nam02on2044.outbound.protection.outlook.com
 ([40.107.95.44] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qRJNt-0002WU-Ad
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:27:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0jfDkSAoeH4GZd0FQqCOxNzMvsNEdX4f3v0OhFDAgQmctwDblYAhsGjbcbP1ANesiVvK5N3j5LNLGIyRIiNY5F96R2buKrIZ+tIkzSeNsbcz8Zj2aARkTbl+L7CcczISB2WCjTqwaGtAG31sFt7Q7QE2fx4dHc8raLB2HQrtBohRlKYC3Clx4lu2Fpwip0xODADF2HVxouD4jKL3he3kQ6TMALy2mqAjQ7m+Phdt+KPqHwi5JuYSDkUsgSgqmFST28iA03MmiqBqoy4wzG6nye4HmwIz7zf5z8WLexiM4PxFFNuqk+ntPiRTszl/kzIZTdYEsEAPONYao34QojsVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+KivzvRGzxHHPJAHgCR4Ve2qBRCZu1RboYwuoi/Y2c=;
 b=UIkedEBWMbWVpRnkqF7j8zXtJDOIcRQzvvT2VCvKm8B9THAsIT7uN3Eb+5u1FDaR1wLRe3ErCKmOPj7LtuEE5TxPUsPehEAZcTk/CASPP0k+yeS5lGLeYTQuEiiVdbaI0LDv9fgRbtIaVl2azeynjL7lXa+Vg3FQUwGg+W61lX0doq1ZH+GGT+InMH8silZXGM7WZzxztFEYlrRR47BKW2n6CfKCkl8vAeCGQy6ejXMBgdVs259gC9uNjpi+FH6vyLXtakvAOpKnivm6M/t+8lcXUI5ZCQEvAEk6DYxgAhlLKY/IXMvTfREojw4edVw29wIoN8PGaoT07SWsvN0UPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+KivzvRGzxHHPJAHgCR4Ve2qBRCZu1RboYwuoi/Y2c=;
 b=U5uochL2IaT063aihP3grbdm9+3v8AMEuo1oT/PQVb+kvLUBd/QdCgYVfbWhhs+xjQ3xSVHBpybYz7mC+wOp0tUkZMWOwLjSVu4/ZTrU9dJx7e1R6t/CAz+7S/goYLEjQuJ4nNNIqzvc7E4dHIBaeITGMqMZWP4ExLtfkcrNDnY=
Received: from BYAPR08CA0039.namprd08.prod.outlook.com (2603:10b6:a03:117::16)
 by BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Wed, 2 Aug
 2023 21:22:50 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::6) by BYAPR08CA0039.outlook.office365.com
 (2603:10b6:a03:117::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 21:22:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 21:22:49 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 16:22:48 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 8.1.0-rc2 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 2 Aug 2023 16:22:28 -0500
Message-ID: <169101134892.809769.3371440466915677666@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|BN9PR12MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b29e22-7f40-4a48-20be-08db939e9f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adVWrIUqk8j7oLt1m5GIU68SR4bM4vLYJ8HtJ30UP9LT0LNd6XdXNySL4UjgWs7AUZkbBaUOwYKrLdGYvFoc0wEDlV6Ss38D8mfS/8BnywMTXy3mJIUKZBE+Bmkkh0+6s+7Y+gXCU0cMBr+eyA2o9WXd9I3tFzh0/FluoGH7fKV/oFy0Xk9DCyCl+RQiXq1T60KqBkiGod3ywjL+OeaX4R5QSWdYT+Vj6P6zNuRc3ZCEt6L7D8eFswSGxRkmVVSfDoMJe39G5uUlUeq82u0qGuCUcSV/4nef3P01/45C+g9ZnRVjPnyuiGJ7HuG9eT5f5tKXxNK/9VxIQoew0fBt1zsUqsrerakdyJqqLNLWAsJ4mwYhPOIb7RVPw5IngzuyNffvtr+LLAzOCKIB1ZYvuerfWqS1nU47P2xmTYZpniCb0g2KO9H+z3uqVxU7Dlvyl8Ut/8wlljX5M6CRz1XCYLiFWKpJVfsjQbQ+vYHsMOPp9sG3rA0VvX7VdGp6srDsvO/gDcvi5Jv7xdpBBQ5UbFIJ1zaIK2aPwBrxHB+cW2GLHWNftQZG4BOz+ncHVeGQFBgwPCCoBOcFflxW3Es1Cjb76xzzeK38Jsmtvlan2KEmN/Je11OKDX/8+l2c+GgZY9Ct89/ykbrLQowMyfAoSECOLyBipFb5l+aoQ/r030GDCQw8sQQtF3cu2G46qwv2HKwAbpAwgce5NsfTLFB8JTnYoa4ecl7sAZ6t55oGqt2KbYJ3D+POSyFX/Aa14QuB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(40460700003)(16526019)(426003)(2616005)(336012)(83380400001)(26005)(186003)(47076005)(36860700001)(316002)(70206006)(70586007)(2906002)(4326008)(6916009)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6666004)(966005)(478600001)(40480700001)(356005)(81166007)(86362001)(36756003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 21:22:49.2265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b29e22-7f40-4a48-20be-08db939e9f88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226
Received-SPF: softfail client-ip=40.107.95.44;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
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
third release candidate for the QEMU 8.1 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-8.1.0-rc2.tar.xz
  http://download.qemu.org/qemu-8.1.0-rc2.tar.xz.sig

You can help improve the quality of the QEMU 8.1 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/8#tab-issues

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/8.1

Please add entries to the ChangeLog for the 8.1 release below:

  http://wiki.qemu.org/ChangeLog/8.1

Thank you to everyone involved!

Changes since rc1:

9ba37026fc: Update version for v8.1.0-rc2 release (Richard Henderson)
2b3edd9518: MAINTAINERS: Add section "Migration dirty limit and dirty page =
rate" (Hyman Huang(=E9=BB=84=E5=8B=87))
ef96537732: qapi: Craft the dirty-limit capability comment (Hyman Huang(=E9=
=BB=84=E5=8B=87))
8abc81150f: qapi: Reformat the dirty-limit migration doc comments (Hyman Hu=
ang(=E9=BB=84=E5=8B=87))
8caaae7319: target/m68k: Fix semihost lseek offset computation (Peter Mayde=
ll)
71e2dd6aa1: target/nios2: Fix semihost lseek offset computation (Keith Pack=
ard)
c11d5bdae7: target/nios2: Pass semihosting arg to exit (Keith Packard)
7a06a8fec9: tests/migration: Add -fno-stack-protector (Akihiko Odaki)
313e162951: misc: Fix some typos in documentation and comments (Stefan Weil)
7b4a3f8145: ui/dbus: fix clang compilation issue (Marc-Andr=C3=A9 Lureau)
866b24e4c3: ui/dbus: fix win32 compilation when !opengl (Marc-Andre Lureau)
75a87af9b2: hw/xen: prevent guest from binding loopback event channel to it=
self (David Woodhouse)
19c417ec87: i386/xen: consistent locking around Xen singleshot timers (Davi=
d Woodhouse)
cf885b1957: hw/xen: fix off-by-one in xen_evtchn_set_gsi() (David Woodhouse)
10be627d2b: io: remove io watch if TLS channel is closed during handshake (=
Daniel P. Berrang=C3=A9)
856ca10f9c: xen-platform: do full PCI reset during unplug of IDE devices (O=
laf Hering)
bcb40db010: xen: Don't pass MemoryListener around by value (Peter Maydell)
f4f71363fc: thread-pool: signal "request_cond" while locked (Anthony PERARD)
aa36243514: xen-block: Avoid leaks on new error path (Anthony PERARD)
ace33a0e5a: hw/xen: Clarify (lack of) error handling in transaction_commit(=
) (David Woodhouse)
8b94ec53f3: target/s390x: Move trans_exc_code update to do_program_interrup=
t (Richard Henderson)
38dd78c41e: linux-user/armeb: Fix __kernel_cmpxchg() for armeb (Helge Delle=
r)
2e718e6657: target/ppc: Disable goto_tb with architectural singlestep (Rich=
ard Henderson)
0f2f3247d4: bsd-user: Specify host page alignment if none specified (Warner=
 Losh)
28b61d49ac: bsd-user: Allocate guest virtual address space (Richard Henders=
on)
ad17868eb1: accel/tcg: Clear tcg_ctx->gen_tb on buffer overflow (Richard He=
nderson)
79e29851bf: util/interval-tree: Use qatomic_read/set for rb_parent_color (R=
ichard Henderson)
d37a259fa4: util/interval-tree: Introduce pc_parent (Richard Henderson)
4c8baa02d3: util/interval-tree: Use qatomic_set_mb in rb_link_node (Richard=
 Henderson)
055b86e0f0: util/interval-tree: Use qatomic_read for left/right while searc=
hing (Richard Henderson)
108e8180c6: gdbstub: Fix client Ctrl-C handling (Nicholas Piggin)
fe6bda58e0: kvm: Fix crash due to access uninitialized kvm_state (Gavin Sha=
n)
71054f72f1: target/arm/tcg: Don't build AArch64 decodetree files for qemu-s=
ystem-arm (Peter Maydell)
2b0d656ab6: target/arm: Avoid writing to constant TCGv in trans_CSEL() (Pet=
er Maydell)
548b8edc6d: elf2dmp: Don't abandon when Prcb is set to 0 (Akihiko Odaki)
638511e992: target/arm: Fix MemOp for STGP (Richard Henderson)
c1e244b655: hw/nvme: use stl/ldl pci dma api (Klaus Jensen)
1c38fe69e2: block/blkio: use blkio_set_int("fd") to check fd support (Stefa=
no Garzarella)
723bea27b1: block/blkio: fall back on using `path` when `fd` setting fails =
(Stefano Garzarella)
809c319f8a: block/blkio: retry blkio_connect() if it fails using `fd` (Stef=
ano Garzarella)
69785d66ae: block/blkio: move blkio_connect() in the drivers functions (Ste=
fano Garzarella)
ef256751e9: block: Fix pad_request's request restriction (Hanna Czenczek)
29a242e165: block/file-posix: fix g_file_get_contents return path (Sam Li)
e5b815b0de: qemu-nbd: regression with arguments passing into nbd_client_thr=
ead() (Denis V. Lunev)
a5942c177b: block/blkio: do not use open flags in qemu_open() (Stefano Garz=
arella)
9e272073e1: qapi: Reformat recent doc comments to conform to current conven=
tions (Markus Armbruster)
e27a9d628d: qapi/trace: Tidy up trace-event-get-state, -set-state documenta=
tion (Markus Armbruster)
a9c72efd6d: qapi/qdev: Tidy up device_add documentation (Markus Armbruster)
e893b9e3b3: qapi/block: Tidy up block-latency-histogram-set documentation (=
Markus Armbruster)
dad3c9565d: qapi/block-core: Tidy up BlockLatencyHistogramInfo documentatio=
n (Markus Armbruster)
697c4c86ab: migration/rdma: Split qemu_fopen_rdma() into input/output funct=
ions (Juan Quintela)
ac6f48e15d: qemu-file: Make qemu_file_get_error_obj() static (Juan Quintela)
8c5ee0bfb8: qemu-file: Simplify qemu_file_shutdown() (Juan Quintela)
9ccf83f486: qemu_file: Make qemu_file_is_writable() static (Juan Quintela)
cf786549ce: migration: Change qemu_file_transferred to noflush (Juan Quinte=
la)
fc95c63b60: qemu-file: Rename qemu_file_transferred_ fast -> noflush (Juan =
Quintela)
06c48d6b37: qtest/migration-tests.c: use "-incoming defer" for postcopy tes=
ts (Wei Wang)
82137e6c8c: migration: enforce multifd and postcopy preempt to be set befor=
e incoming (Wei Wang)
908927db28: migration: Update error description whenever migration fails (T=
ejus GK)
f014880ab9: docs/migration: Update postcopy bits (Peter Xu)
7b24d32634: migration: skipped field is really obsolete. (Juan Quintela)
bc28a6111d: migration-test: machine_opts is really arch specific (Juan Quin=
tela)
832c732c5d: migration-test: Create arch_opts (Juan Quintela)
42e52a8a77: migration-test: Make machine_opts regular with other options (J=
uan Quintela)
e3131dc76a: migration-test: Be consistent for ppc (Juan Quintela)
15699cf542: migration: Extend query-migrate to provide dirty page limit inf=
o (Hyman Huang(=E9=BB=84=E5=8B=87))
acac51ba24: migration: Implement dirty-limit convergence algo (Hyman Huang(=
=E9=BB=84=E5=8B=87))
310ad5625e: migration: Put the detection logic before auto-converge checkin=
g (Hyman Huang(=E9=BB=84=E5=8B=87))
bb9993c672: migration: Refactor auto-converge capability logic (Hyman Huang=
(=E9=BB=84=E5=8B=87))
dc62395557: migration: Introduce dirty-limit capability (Hyman Huang(=E9=BB=
=84=E5=8B=87))
09f9ec9913: qapi/migration: Introduce vcpu-dirty-limit parameters (Hyman Hu=
ang(=E9=BB=84=E5=8B=87))
4d80785719: qapi/migration: Introduce x-vcpu-dirty-limit-period parameter (=
Hyman Huang(=E9=BB=84=E5=8B=87))
140e5a7632: softmmu/dirtylimit: Add parameter check for hmp "set_vcpu_dirty=
_limit" (Hyman Huang(=E9=BB=84=E5=8B=87))
01ec0f3a92: migration/multifd: Protect accesses to migration_threads (Fabia=
no Rosas)
788fa68041: migration/multifd: Rename threadinfo.c functions (Fabiano Rosas)
9359c45988: block/blkio: enable the completion eventfd (Stefano Garzarella)
0e6b20b965: hw/usb/canokey: change license to GPLv2+ (Hongren (Zenithal) Zh=
eng)
55a01cab83: crypto: Always initialize splitkeylen (Akihiko Odaki)

