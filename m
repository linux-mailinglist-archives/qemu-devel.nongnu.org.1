Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D48C981FAC5
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 20:28:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIw2b-00009N-E7; Thu, 28 Dec 2023 14:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rIw2S-00008Y-5B; Thu, 28 Dec 2023 14:27:29 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rIw2Q-0004he-0m; Thu, 28 Dec 2023 14:27:27 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3D82C3F850;
 Thu, 28 Dec 2023 22:27:43 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B550555B81;
 Thu, 28 Dec 2023 22:27:11 +0300 (MSK)
Received: (nullmailer pid 270810 invoked by uid 1000);
 Thu, 28 Dec 2023 19:27:11 -0000
Subject: [ANNOUNCE] QEMU 7.2.8 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Date: Thu, 28 Dec 2023 22:27:11 +0300
Message-Id: <1703791631.656191.270809.nullmailer@tls.msk.ru>
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

The QEMU v7.2.8 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-7.2.8.tar.xz
  https://download.qemu.org/qemu-7.2.8.tar.xz.sig (signature)

v7.2.8 is now tagged in the official qemu.git repository, and the
stable-7.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-7.2?ref_type=heads

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-7.2-hash master-hash Author Name: Commmit-Subject):

71090deb4c Michael Tokarev:
 Update version for 7.2.8 release
fe0c88919c 6980c31dec Jean-Philippe Brucker:
 target/arm/helper: Propagate MDCR_EL2.HPMN into PMCR_EL0.N
775bb790b9 2b8fe81b3c Patrick Venture:
 system/memory: use ldn_he_p/stn_he_p
4131b1f176 f7767ca301 Peter Maydell:
 target/arm: Disable SME if SVE is disabled
aada709c26 ebfbf39467 Fiona Ebner:
 ui/vnc-clipboard: fix inflate_buffer
591618f27b 53a939f1bf Volker Rümelin:
 ui/gtk-egl: move function calls back to regular code path
7b15f81d63 6f189a08c1 Antonio Caggiano:
 ui/gtk-egl: Check EGLSurface before doing scanout
62b7c90152 2d37fe9e5e Robert Hoo:
 msix: unset PCIDevice::msix_vector_poll_notifier in rollback
95743c7a39 20bc50137f Philippe Mathieu-Daudé:
 hw/acpi/erst: Do not ignore Error* in realize handler
ab0c94f1d7 714a1415d7 Akihiko Odaki:
 pcie_sriov: Remove g_new assertion
a7a2570f22 74e8593e7e Volker Rümelin:
 hw/audio/hda-codec: fix multiplication overflow
a386866a8d dc96009afd Thomas Huth:
 hw/mips/malta: Fix the malta machine on big endian hosts
adfe37a19a 9fb7b350ba Fam Zheng:
 vmdk: Don't corrupt desc file in vmdk_write_cid
313f191150 837053a7f4 Philippe Mathieu-Daudé:
 hw/virtio: Add VirtioPCIDeviceTypeInfo::instance_finalize field
06239e69e8 4f10c66077 Philippe Mathieu-Daudé:
 hw/nvram/xlnx-efuse-ctrl: Free XlnxVersalEFuseCtrl[] "pg0-lock" array
b1c78530ae 49b3e28b7b Philippe Mathieu-Daudé:
 hw/nvram/xlnx-efuse: Free XlnxEFuse::ro_bits[] array on finalize()
10e169de73 896dd6ff7b Philippe Mathieu-Daudé:
 hw/misc/mps2-scc: Free MPS2SCC::oscclk[] array on finalize()
ac1749e444 c9a4aa06df Philippe Mathieu-Daudé:
 hw/virtio: Free VirtIOIOMMUPCI::vdev.reserved_regions[] on finalize()
ac179ffe7e 11a3c4a286 Peter Maydell:
 target/arm: Set IL bit for pauth, SVE access, BTI trap syndromes
d9a0224b2a f0a663b4ce Philippe Mathieu-Daudé:
 tests/avocado: Replace assertRegexpMatches() for Python 3.12 compatibility
dff579171c 861f724d03 Thomas Huth:
 tests/avocado: Replace assertEquals() for Python 3.12 compatibility
e79947a57f 82d70a84c8 Richard Henderson:
 linux-user: Fix loaddr computation for some elf files
3c0463a650 9050f976e4 Akihiko Odaki:
 net: Update MemReentrancyGuard for NIC
fdebed6dcd 7d0fefdf81 Akihiko Odaki:
 net: Provide MemReentrancyGuard * to qemu_new_nic()
b9fd6d9521 eabb921250 Niklas Cassel:
 hw/ide/ahci: fix legacy software reset
-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEe3O61ovnosKJMUsicBtPaxppPlkFAmWF3wsACgkQcBtPaxpp
PlkONAgAxdeIVksq1wG/BrKJOfydg2GDMFl9HGj5uO0XO7GawMSO08HThLqqULPu
vvOOXZGc9iYe/wogjzriOmdwwkj9raTx8H4V4q/c+8ArgOPkO/dFEMYek38AZ2TK
Fdz0wpK7T6D/acA1+zmvEwGhlQmFyk5yHuanZCFHuNqm4YT0yNLmN4848BuFlkYM
YW5xgdJD6ak9zjoTEELxL56gHnW7bSx9nGHP+W9umXrXser7LVhjkiMr29d19pUX
I1G5NZ1M/BsMgwaUZXLf+lLdufgoLUFJZ2mdHdxCnrlSBGEq3gJj/EQcqjY+sbmi
I1jlM5qMzd+Ztur72uQzyqyuPkqoYQ==
=ZaYx
-----END PGP SIGNATURE-----

