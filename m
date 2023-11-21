Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 483A67F3575
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 19:01:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5V3H-0002w3-21; Tue, 21 Nov 2023 13:00:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r5V3D-0002vP-VM; Tue, 21 Nov 2023 13:00:43 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r5V3B-0005CP-Le; Tue, 21 Nov 2023 13:00:43 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EEF4835386;
 Tue, 21 Nov 2023 21:00:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 493AC36BA8;
 Tue, 21 Nov 2023 21:00:39 +0300 (MSK)
Received: (nullmailer pid 3420729 invoked by uid 1000);
 Tue, 21 Nov 2023 18:00:39 -0000
Subject: [ANNOUNCE] QEMU 8.1.3 Stable released
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
From: Michael Tokarev <mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfar-Encoding: 8bit
Date: Tue, 21 Nov 2023 21:00:39 +0300
Message-Id: <1700589639.257680.3420728.nullmailer@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, CTE_8BIT_MISMATCH=0.001,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi everyone,

The QEMU v8.1.3 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

v8.1.3 is now tagged in the official qemu.git repository, and the
stable-8.1 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-8.1?ref_type=heads

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-8.1-hash master-hash Author Name: Commmit-Subject):

179cc58e00 Michael Tokarev:
 Update version for 8.1.3 release
d19b4a4215 52c773ce89 Marc-André Lureau:
 hw/mips: LOONGSON3V depends on UNIMP device
b88b9585d8 fc58891d04 Peter Maydell:
 target/arm: HVC at EL3 should go to EL3, not EL2
25f55508fc 8011b508cf Matthew Rosato:
 s390x/pci: only limit DMA aperture if vfio DMA limit reported
150ebd076e 608bdebb60 Daniel Henrique Barboza:
 target/riscv/kvm: support KVM_GET_REG_LIST
221c0e1426 082e9e4a58 Daniel Henrique Barboza:
 target/riscv/kvm: improve 'init_multiext_cfg' error msg
100feda604 4d96307c5b Marc-André Lureau:
 tracetool: avoid invalid escape in Python string
097c347136 ebc14107f1 Ilya Leoshkevich:
 tests/tcg/s390x: Test LAALG with negative cc_src
a16eec9fb2 bea402482a Ilya Leoshkevich:
 target/s390x: Fix LAALG not updating cc_src
255422dc75 43fecbe7a5 Ilya Leoshkevich:
 tests/tcg/s390x: Test CLC with inaccessible second operand
88b778e4c2 aba2ec341c Ilya Leoshkevich:
 target/s390x: Fix CLC corrupting cc_src
07c2a9c0fa cc610857bb Fiona Ebner:
 tests/qtest: ahci-test: add test exposing reset issue with pending callback
60f7b60429 7d7512019f Fiona Ebner:
 hw/ide: reset: cancel async DMA operation before resetting state
f15258b196 18f86aecd6 Philippe Mathieu-Daudé:
 target/mips: Fix TX79 LQ/SQ opcodes
f68a36b7c4 04591b3ddd Philippe Mathieu-Daudé:
 target/mips: Fix MSA BZ/BNZ opcodes displacement
801b7e4390 47fd6ab1e3 Dongwon Kim:
 ui/gtk-egl: apply scale factor when calculating window's dimension
30d90aebcd 565f85a9c2 Marc-André Lureau:
 ui/gtk: force realization of drawing area
e301a77abb 08730ee0cc BALATON Zoltan:
 ati-vga: Implement fallback for pixman routines
bcc9879c1c ad4feaca61 Naohiro Aota:
 file-posix: fix over-writing of returning zone_append offset
a753815aa8 10b9e0802a Sam Li:
 block/file-posix: fix update_zones_wp() caller
cc9f53b3ec b2b109041e Jean-Louis Dupond:
 qcow2: keep reference on zeroize with discard-no-unref enabled
fe8eb3187c 5722fc4712 Peter Maydell:
 target/arm: Fix A64 LDRA immediate decode
1f560fa276 cc8fb0c3ae Vladimir Sementsov-Ogievskiy:
 block/nvme: nvme_process_completion() fix bound for cid
a89c8b96a8 9c549ab689 Marc-André Lureau:
 virtio-gpu: block migration of VMs with blob=true
287303495c a1c1082908 David Woodhouse:
 hw/xen: use correct default protocol for xen-block on x86
30a4cc2723 debc995e88 David Woodhouse:
 hw/xen: take iothread mutex in xen_evtchn_reset_op()
b644416ec6 4a5780f520 David Woodhouse:
 hw/xen: fix XenStore watch delivery to guest
0f2dd05b9f 3de75ed352 David Woodhouse:
 hw/xen: don't clear map_track[] in xen_gnttab_reset()
5450203719 18e83f28bf David Woodhouse:
 hw/xen: select kernel mode for per-vCPU event channel upcall vector
91d789a891 e7dbb62ff1 David Woodhouse:
 i386/xen: fix per-vCPU upcall vector for Xen emulation
3321ec125f e969f992c6 David Woodhouse:
 i386/xen: Don't advertise XENFEAT_supervisor_mode_kernel
5f0083a95d 4ef9d97b1a Cédric Le Goater:
 util/uuid: Remove UUID_FMT_LEN
47c408b80e f8d6f3b16c Cédric Le Goater:
 vfio/pci: Fix buffer overrun when writing the VF token
6ede082daf 721da0396c Cédric Le Goater:
 util/uuid: Add UUID_STR_LEN definition
155856d890 4c09abeae8 Peter Maydell:
 target/arm: Correctly propagate stage 1 BTI guarded bit in a two-stage walk
baf28675da b11293c212 Richard Henderson:
 target/arm: Fix SVE STR increment
b7867c8262 827171c318 Andrey Drobyshev:
 qemu-iotests: 024: add rebasing test case for overlay_size > backing_size
bd8d9c618a 8b097fd6b0 Andrey Drobyshev:
 qemu-img: rebase: stop when reaching EOF of old backing file
de18cbdaf2 580731dcc8 Akihiko Odaki:
 tests/tcg: Add -fno-stack-protector
3a2d501916 fed8245015 Kevin Wolf:
 block: Fix locking in media change monitor commands
b938418f0d 6f83dc6716 Glenn Miles:
 misc/led: LED state is set opposite of what is expected
143352cd7d 307521d6e2 Peter Maydell:
 target/arm: Fix syndrome for FGT traps on ERET
fd4ce7455f 930f1865cc Richard Henderson:
 target/sparc: Clear may_lookup for npc == DYNAMIC_PC
28facf1598 4ab9a7429b Peter Maydell:
 hw/rdma/vmw/pvrdma_cmd: Use correct struct in query_port()
fdeedb886a ae5f70baf5 Lu Gao:
 hw/sd/sdhci: Block Size Register bits [14:12] is lost
31c6d1d654 d01448c79d Michal Orzel:
 target/arm: Fix CNTPCT_EL0 trapping from EL0 when HCR_EL2.E2H is 0
59ee12a961 a1e6a5c462 Helge Deller:
 lasips2: LASI PS/2 devices are not user-createable
1e4c468ec7 3b894b699c Mikulas Patocka:
 linux-user/sh4: Fix crashes on signal delivery
814f91d679 6fad9b4bb9 Mikulas Patocka:
 linux-user/mips: fix abort on integer overflow
e73f57b1b5 e6e66b0328 Richard Henderson:
 linux-user: Fixes for zero_bss
71452f87c9 e6d8e5e6e3 Paolo Bonzini:
 tracetool: avoid invalid escape in Python string
791cbfeec2 86a8989d45 Paolo Bonzini:
 tests/vm: avoid invalid escape in Python string
6dbb538a71 1b5f3f65cc Paolo Bonzini:
 tests/avocado: avoid invalid escape in Python string
7a04747125 e41c40d101 Paolo Bonzini:
 target/hexagon: avoid invalid escape in Python string
23b0010786 e4b6532cc0 Paolo Bonzini:
 docs/sphinx: avoid invalid escape in Python string
adbbddf90b a5e3cb3b90 Paolo Bonzini:
 tests/docker: avoid invalid escape in Python string
663aca79f9 acf873873a John Snow:
 python/qmp: remove Server.wait_closed() call for Python 3.12
95b3854bf7 d4f34485ca Juan Quintela:
 migration: Non multifd migration don't care about multifd flushes
9285589334 caea03279e Fabiano Rosas:
 migration: Fix analyze-migration read operation signedness

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEe3O61ovnosKJMUsicBtPaxppPlkFAmVc8C0ACgkQcBtPaxpp
PlkkIAf+PLZzUHBTyw/BJjXfeXbduB8kzRAbUPABW9+svCvhkLAm4U9iYjEANuyC
0NiYoiOoaVo3QqaNwBePmpRKgbnGhC29TDkYGFch83Bb1z7Rb2mgAOL6SCAIAcQ3
KGOhe9fBbfphWNIEtLFJcj7UfLSroNMoVO3hCjtQvXf/3RKaroqJz3/GA5XoajOE
GMRpsDbB0vBc+ByZJxpasKzFCVhqY4j5zK2KkIBfVNx0hCuB88YHskckzRIMJPy9
q7kuTwzpT4sXgUZvlxRThb0kLDWA9+xunGnN1vL8NNCLk7LnnzDEqWwwwM0FDAm7
LkuVXizcG1JMTOedHDS/4zNuZNWbqg==
=amuY
-----END PGP SIGNATURE-----

