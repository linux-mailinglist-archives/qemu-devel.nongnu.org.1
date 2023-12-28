Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E181081FAC6
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 20:34:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIw87-0001J6-2a; Thu, 28 Dec 2023 14:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rIw7v-0001Dq-Dq; Thu, 28 Dec 2023 14:33:08 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rIw7s-0005RE-Dp; Thu, 28 Dec 2023 14:33:07 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EA27D3F860;
 Thu, 28 Dec 2023 22:33:32 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6B06555B92;
 Thu, 28 Dec 2023 22:33:01 +0300 (MSK)
Received: (nullmailer pid 271101 invoked by uid 1000);
 Thu, 28 Dec 2023 19:33:01 -0000
Subject: [ANNOUNCE] QEMU 8.1.4 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Date: Thu, 28 Dec 2023 22:33:01 +0300
Message-Id: <1703791981.373038.271100.nullmailer@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The QEMU v8.1.4 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-8.1.4.tar.xz
  https://download.qemu.org/qemu-8.1.4.tar.xz.sig (signature)

v8.1.4 is now tagged in the official qemu.git repository, and the
stable-8.1 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-8.1?ref_type=heads

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-8.1-hash master-hash Author Name: Commmit-Subject):

c95e38d33b Michael Tokarev:
 Update version for 8.1.4 release
c06aef082f 6980c31dec Jean-Philippe Brucker:
 target/arm/helper: Propagate MDCR_EL2.HPMN into PMCR_EL0.N
5b2fd6cf37 b5e0d5d22f Richard Henderson:
 target/i386: Fix 32-bit wrapping of pc/eip computation
b831182728 755ae3811f Kevin Wolf:
 block: Fix AioContext locking in qmp_block_resize()
fab36df7bd 2b8fe81b3c Patrick Venture:
 system/memory: use ldn_he_p/stn_he_p
25d0ca4fb0 f7767ca301 Peter Maydell:
 target/arm: Disable SME if SVE is disabled
4b2648356f ebfbf39467 Fiona Ebner:
 ui/vnc-clipboard: fix inflate_buffer
5133410f8b 53a939f1bf Volker Rümelin:
 ui/gtk-egl: move function calls back to regular code path
5a92f023d9 6f189a08c1 Antonio Caggiano:
 ui/gtk-egl: Check EGLSurface before doing scanout
701afca639 2d37fe9e5e Robert Hoo:
 msix: unset PCIDevice::msix_vector_poll_notifier in rollback
5c9f464531 20bc50137f Philippe Mathieu-Daudé:
 hw/acpi/erst: Do not ignore Error* in realize handler
ed7e167699 714a1415d7 Akihiko Odaki:
 pcie_sriov: Remove g_new assertion
59de6e246f 74e8593e7e Volker Rümelin:
 hw/audio/hda-codec: fix multiplication overflow
66f14b70fe 235948bf53 Gihun Nam:
 hw/avr/atmega: Fix wrong initial value of stack pointer
fbca2cbbef 837053a7f4 Philippe Mathieu-Daudé:
 hw/virtio: Add VirtioPCIDeviceTypeInfo::instance_finalize field
f5584a7d8d 4f10c66077 Philippe Mathieu-Daudé:
 hw/nvram/xlnx-efuse-ctrl: Free XlnxVersalEFuseCtrl[] "pg0-lock" array
a3e46300c5 49b3e28b7b Philippe Mathieu-Daudé:
 hw/nvram/xlnx-efuse: Free XlnxEFuse::ro_bits[] array on finalize()
48e0dfb837 896dd6ff7b Philippe Mathieu-Daudé:
 hw/misc/mps2-scc: Free MPS2SCC::oscclk[] array on finalize()
502f15db55 c9a4aa06df Philippe Mathieu-Daudé:
 hw/virtio: Free VirtIOIOMMUPCI::vdev.reserved_regions[] on finalize()
49727560c7 8d37a1425b Peter Maydell:
 target/arm: Handle overflow in calculation of next timer tick
169c593f78 11a3c4a286 Peter Maydell:
 target/arm: Set IL bit for pauth, SVE access, BTI trap syndromes
5cf2cf1f9f 9fb7b350ba Fam Zheng:
 vmdk: Don't corrupt desc file in vmdk_write_cid
6f51114b0e 6bca4d7d1f Ivan Klokov:
 target/riscv/cpu_helper.c: Fix mxr bit behavior
87ff608c6f 82d53adfbb Ivan Klokov:
 target/riscv/cpu_helper.c: Invalid exception on MMU translation stage
837148a31a a7472560ca Román Cárdenas:
 riscv: Fix SiFive E CLINT clock frequency
9ac76067ab 7a87ba8956 Daniel Henrique Barboza:
 hw/riscv/virt.c: do create_fdt() earlier, add finalize_fdt()
8d0b8fead4 301c65f49f Palmer Dabbelt:
 linux-user/riscv: Add Zicboz block size to hwprobe
8328d79621 f0a663b4ce Philippe Mathieu-Daudé:
 tests/avocado: Replace assertRegexpMatches() for Python 3.12 compatibility
5e7f6afe98 861f724d03 Thomas Huth:
 tests/avocado: Replace assertEquals() for Python 3.12 compatibility
983a4a828c 82d70a84c8 Richard Henderson:
 linux-user: Fix loaddr computation for some elf files
88e79a2dfd 9050f976e4 Akihiko Odaki:
 net: Update MemReentrancyGuard for NIC
cc5124d979 7d0fefdf81 Akihiko Odaki:
 net: Provide MemReentrancyGuard * to qemu_new_nic()
c6c0a1888f eabb921250 Niklas Cassel:
 hw/ide/ahci: fix legacy software reset
db8e86cc40 3efd849573 Richard Henderson:
 target/arm: Fix SME FMOPA (16-bit), BFMOPA
-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEe3O61ovnosKJMUsicBtPaxppPlkFAmWF3zYACgkQcBtPaxpp
PlkD/QgAoQBR2CHuvxOwQFfVBy76HjE7Z6BPI0SKRONu81m2PIHl6cqUXsQtnUoR
Hh4q0j+e5G2nFnTjdv31p1tDzqGsu0aHb7Psf/dJbrPs6JzhTjNvM1LMUMWG7IO+
LGivh+FrY+wZnGwmKhAkYpIjMg9lz+DHWHzpnCNR7U7XBHQw5nml/LN6FOZJH9oP
amYuhCsJ3mWJr/9kwtZcgUBahrXH0EV8EhFprgi1/SEGO1KqRmTVliRaBft/WDu2
qpJvEWzoa3yKeuhbTWSjqqOKYaiqEs0rjUyVtcKQVl1M/dWSR02BHwoUHBPZbG/F
P8He/Mn8KoOiWv4Jn/q6rOFkouJlvw==
=9bJU
-----END PGP SIGNATURE-----

