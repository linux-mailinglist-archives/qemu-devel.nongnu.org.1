Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 428227C9BA9
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 23:00:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs8Cx-0004yv-Pj; Sun, 15 Oct 2023 16:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qs8Cv-0004yY-07
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 16:59:29 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qs8Cs-0007RH-1a
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 16:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Otqi177aBzAz/WETu9J7lnoly/4wLb1Qx5MbDSzOWgY=; b=Sj4AaJNLRKre3d9AECntGZvKhu
 gsIqk1HzIW++0QghUtg3J9xHHytnmvl+r+KZyIi18FKU0OA/yaY8oQHb936puHqEiMi2o+b8b4o41
 PGDZHHQhLtsWFHsjS6cW04oNaswXVeAVmHVXdQUPx9gQh9JJuM0He2cwuQqiR6dFndcA=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH 0/6] TriCore Semihosting
Date: Sun, 15 Oct 2023 22:59:07 +0200
Message-ID: <20231015205913.264782-1-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.10.15.204517, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.10.8.602001
X-Sophos-SenderHistory: ip=79.202.213.239, fs=1596194, da=185012623, mc=71,
 sc=0, hc=71, sp=0, fso=1596194, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::16;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=doohan.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

this patch series implements semihosting as done in the golden Infineon
simulator 'TSIM'. 'TSIM' supports different semihosting variants, specific to
various toolchain vendors. Only the GNU toolchain with Newlib [1] is freely
available, thus I only implemented semihosting for GNU. This port of Newlib is
also available in the 'debian-tricore-cross.docker' image.

To build and run a binary with semihosting, one only has to link against libos, i.e.

tricore-gcc test.c -los -o test.elf
qemu-system-tricore -M tricore_testboard -semihosting -nographic -kernel test.elf

Cheers,
Bastian

[1] https://github.com/bkoppelmann/package_940/tree/main/newlib/libgloss/tricore

Bastian Koppelmann (6):
  target/tricore: Add semihosting stub
  target/tricore: Add read and write semihosting calls
  target/tricore: Add lseek semihosting call
  target/tricore: Add close semihosting call
  target/tricore: Add open and creat semihosting calls
  target/tricore: Enable semihosting

 configs/devices/tricore-softmmu/default.mak |   1 +
 docs/about/emulation.rst                    |   3 +
 qemu-options.hx                             |   3 +-
 target/tricore/helper.h                     |   1 +
 target/tricore/meson.build                  |   1 +
 target/tricore/translate.c                  |  13 +-
 target/tricore/tricore-semi.c               | 380 ++++++++++++++++++++
 7 files changed, 399 insertions(+), 3 deletions(-)
 create mode 100644 target/tricore/tricore-semi.c

-- 
2.42.0


