Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A07A7F3572
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 19:00:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5V28-0001Y5-Dk; Tue, 21 Nov 2023 12:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r5V22-0001Vu-2i; Tue, 21 Nov 2023 12:59:30 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r5V1y-0004pD-HA; Tue, 21 Nov 2023 12:59:29 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3FC1735381;
 Tue, 21 Nov 2023 20:59:20 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8589D36BA7;
 Tue, 21 Nov 2023 20:59:12 +0300 (MSK)
Received: (nullmailer pid 3420670 invoked by uid 1000);
 Tue, 21 Nov 2023 17:59:12 -0000
Subject: [ANNOUNCE] QEMU 7.2.7 Stable released
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
From: Michael Tokarev <mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfar-Encoding: 8bit
Date: Tue, 21 Nov 2023 20:59:12 +0300
Message-Id: <1700589552.502824.3420669.nullmailer@tls.msk.ru>
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

The QEMU v7.2.7 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

v7.2.7 is now tagged in the official qemu.git repository, and the
stable-7.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-7.2?ref_type=heads

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-7.2-hash master-hash Author Name: Commmit-Subject):

14f0c7e3be Michael Tokarev:
 Update version for 7.2.7 release
a536d6a486 f8cfdd2038 Bastian Koppelmann:
 target/tricore: Rename tricore_feature
38312c2c3b 4d96307c5b Marc-André Lureau:
 tracetool: avoid invalid escape in Python string
15764a7635 ebc14107f1 Ilya Leoshkevich:
 tests/tcg/s390x: Test LAALG with negative cc_src
154760b6db bea402482a Ilya Leoshkevich:
 target/s390x: Fix LAALG not updating cc_src
8e8cae1de8 cc610857bb Fiona Ebner:
 tests/qtest: ahci-test: add test exposing reset issue with pending callback
471a9310fd 7d7512019f Fiona Ebner:
 hw/ide: reset: cancel async DMA operation before resetting state
18460b3781 18f86aecd6 Philippe Mathieu-Daudé:
 target/mips: Fix TX79 LQ/SQ opcodes
9bc1741af1 04591b3ddd Philippe Mathieu-Daudé:
 target/mips: Fix MSA BZ/BNZ opcodes displacement
2c1c0cdc25 47fd6ab1e3 Dongwon Kim:
 ui/gtk-egl: apply scale factor when calculating window's dimension
ad8457e85e 565f85a9c2 Marc-André Lureau:
 ui/gtk: force realization of drawing area
091798aaf0 08730ee0cc BALATON Zoltan:
 ati-vga: Implement fallback for pixman routines
0d7c40a1e2 cc8fb0c3ae Vladimir Sementsov-Ogievskiy:
 block/nvme: nvme_process_completion() fix bound for cid
26bb3ab8ff 4c09abeae8 Peter Maydell:
 target/arm: Correctly propagate stage 1 BTI guarded bit in a two-stage walk
e19b7b8165 fcc0b0418f Peter Maydell:
 target/arm: Fix handling of SW and NSW bits for stage 2 walks
6861482dea 21a4ab8318 Peter Maydell:
 target/arm: Don't allow stage 2 page table walks to downgrade to NS
d9da3f8dbd 0d3de77a07 Fabiano Rosas:
 target/arm: Don't access TCG code when debugging with KVM
3e273f4c16 6003159ce1 Daniel P. Berrangé:
 Revert "linux-user: fix compat with glibc >= 2.36 sys/mount.h"
cc64f9ac3d 9f0246539a Daniel P. Berrangé:
 Revert "linux-user: add more compat ioctl definitions"
e4a44eb819 827171c318 Andrey Drobyshev:
 qemu-iotests: 024: add rebasing test case for overlay_size > backing_size
1e67bd7c21 8b097fd6b0 Andrey Drobyshev:
 qemu-img: rebase: stop when reaching EOF of old backing file
6367e823ca 580731dcc8 Akihiko Odaki:
 tests/tcg: Add -fno-stack-protector
30811710fb 7a06a8fec9 Akihiko Odaki:
 tests/migration: Add -fno-stack-protector
d241c15f75 6f83dc6716 Glenn Miles:
 misc/led: LED state is set opposite of what is expected
cec02bc037 ae5f70baf5 Lu Gao:
 hw/sd/sdhci: Block Size Register bits [14:12] is lost
ef93ba0d7b a1e6a5c462 Helge Deller:
 lasips2: LASI PS/2 devices are not user-createable
cb79e6a451 3b894b699c Mikulas Patocka:
 linux-user/sh4: Fix crashes on signal delivery
ea3c95a6b0 6fad9b4bb9 Mikulas Patocka:
 linux-user/mips: fix abort on integer overflow
f5358bc18b caea03279e Fabiano Rosas:
 migration: Fix analyze-migration read operation signedness
06c9bf032f 85fc35afa9 Yuval Shaia:
 hw/pvrdma: Protect against buggy or malicious guest driver
0c049eafd5 cffa995490 Alvin Chang:
 disas/riscv: Fix the typo of inverted order of pmpaddr13 and pmpaddr14
c19fd37eb3 00e3b29d06 Volker Rümelin:
 hw/audio/es1370: reset current sample counter
77d36ba300 86dec715a7 Peter Xu:
 migration/qmp: Fix crash on setting tls-authz with null
85c27e5b37 0114c45130 Akihiko Odaki:
 amd_iommu: Fix APIC address check
24d5b71884 33bc4fa78b Richard Henderson:
 linux-user/hppa: Fix struct target_sigcontext layout
5f2b5606e2 4f7689f081 Thomas Huth:
 chardev/char-pty: Avoid losing bytes when the other side just (re-)connected
e12abe5a7d e0288a7784 Laszlo Ersek:
 hw/display/ramfb: plug slight guest-triggerable leak on mode setting
755cf29ead abd41884c5 Paolo Bonzini:
 target/i386: fix memory operand size for CVTPS2PD
796468c24a a48b26978a Paolo Bonzini:
 target/i386: generalize operand size "ph" for use in CVTPS2PD
327d65ea97 8bf171c2d1 Ricky Zhou:
 target/i386: Fix exception classes for MOVNTPS/MOVNTPD.
72ef83b12f cab529b0dc Ricky Zhou:
 target/i386: Fix exception classes for SSE/AVX instructions.
cebd957e7b afa94dabc5 Ricky Zhou:
 target/i386: Fix and add some comments next to SSE/AVX instructions.
91fa137979 9e65829699 Paolo Bonzini:
 tests/tcg/i386: correct mask for VPERM2F128/VPERM2I128
c9a2d122bf 3d304620ec Paolo Bonzini:
 target/i386: fix operand size of unary SSE operations
8da0da8799 be2b619a17 Mark Cave-Ayland:
 scsi-disk: ensure that FORMAT UNIT commands are terminated
fa2f090d62 77668e4b9b Mark Cave-Ayland:
 esp: restrict non-DMA transfer length to that of available data
9b7feb87d0 b86dc5cb0b Mark Cave-Ayland:
 esp: use correct type for esp_dma_enable() in sysbus_esp_gpio_demux()
ae0b40d9d9 35ed01ba54 Fabiano Rosas:
 optionrom: Remove build-id section
97037995c1 477b301000 Paolo Bonzini:
 ui/vnc: fix handling of VNC_FEATURE_XVP
0732512dbb 0cb9c5880e Paolo Bonzini:
 ui/vnc: fix debug output for invalid audio message
66aa4b1b4b 7cfcc79b0a Thomas Huth:
 hw/scsi/scsi-disk: Disallow block sizes smaller than 512 [CVE-2023-42467]
e6fdfb8433 0e5903436d Nicholas Piggin:
 accel/tcg: mttcg remove false-negative halted assertion
c8d2fc2177 903dbefc2b Peter Maydell:
 target/arm: Don't skip MTE checks for LDRT/STRT at EL0
79f113448a 7b165fa164 Li Zhijian:
 hw/cxl: Fix CFMW config memory leak
19bbe3a6e9 5b1270ef14 Mikulas Patocka:
 linux-user/hppa: lock both words of function descriptor
96783cfe1e 2529497cb6 Mikulas Patocka:
 linux-user/hppa: clear the PSW 'N' bit when delivering signals
270bf7977f febb71d543 Nicholas Piggin:
 hw/ppc: Always store the decrementer value
e916d29608 17dd1354c1 Nicholas Piggin:
 target/ppc: Decrementer fix BookE semantics
8cfe6d241b c8fbc6b9f2 Nicholas Piggin:
 target/ppc: Sign-extend large decrementer to 64-bits
5eadeeec0d 8e0a5ac878 Nicholas Piggin:
 hw/ppc: Avoid decrementer rounding errors
b9a0f1194a eab0888418 Nicholas Piggin:
 hw/ppc: Round up the decrementer interval when converting to ns
ba8cc5693f 47de6c4c28 Nicholas Piggin:
 host-utils: Add muldiv64_round_up

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEe3O61ovnosKJMUsicBtPaxppPlkFAmVc7wMACgkQcBtPaxpp
Plk7uwf9FVBPgL0i7DIaIUe3cACYfR8+nt2JaS1n4BY5uR7uRBGH06eQtL/Ysoaf
6wY1FQb/muV+5yak4Ta8LRfgIgWNZWDzk2ufcUckpBCpe8fHfnez0BCFpOoDfqTP
O5fcI8GkDh80vUbqsi5xXwf6oQJgzgqu3ZZeW7iIldaK/nPMBkacDQi1u57n05r3
PMimYkA1aEI6JXYfzyYLC+ooIcH0c8mUQlr5LzSgG8J1N6jvw2ZedsgfDF8MoOii
YWNJG+0v6nyetonPbgW8lc1Xp1sjin/Gmm7U9ah9dGMvduIgKvnzTAS64qutyjr8
MPg30RlFb0cbmFBPlk136am3ktp99A==
=qYRe
-----END PGP SIGNATURE-----

