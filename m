Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B31875354C
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:46:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKEPq-0006O7-5B; Fri, 14 Jul 2023 04:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1qKEPn-0006NJ-PL
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:44:39 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1qKEPk-0004IV-P8
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:44:39 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-666eb03457cso1131404b3a.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 01:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1689324275; x=1691916275;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q88xQMEarFA50i9y115IcEsr+rPQt2zyEt4rhzUFosg=;
 b=C9+w7YqMTR78iPOcdYRAkD0QatjjnC83ZSYoRLOZomdBx1JCrxi5MrPGcU5b1eE+YE
 Baa/wB/gU/Gegwr+9OWTL+3gEXFw1xU3g9rsXBR9iShVjQUSA4Krp7BZGODW5cE9czeW
 yQq63q3n8SLWwGIyKnxrndZYwuGPPN4LjZlfL7KlZHn/3bqAGZj6mooOyw8wDmx1K3kw
 uKB0lJDPx8WP/LkEdgC3fPZGQbBQQ/X5OqRio/DfKBfPPAY1vBDI1ULTVXsqoYotI9yt
 BTBC6a87fcTFQ9fbm815yf1HY5bXHR4Wdd9bwygYc9KrRblo0mM7CM9ldBDKaRIayZoH
 tOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689324275; x=1691916275;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q88xQMEarFA50i9y115IcEsr+rPQt2zyEt4rhzUFosg=;
 b=Fwp31k9wZmjKUHu10hUZ8j9TS8SMvcVEdWCtbrkfipa2WwaHTu/qnHWoF1ovj6uUn8
 1Z0ZytWN1BY9ZhaatdutnrCCi3MEA2NDoyAIRUjv9Iqnno80elk9cFPW9nUqlzmm5YWp
 CjD/W9L85rs6zql6NeH6xn4mgVi3LWN+kXKIVNxRUUeF3jVvJ4/ewrcsihdr7aYLlVRU
 riSnHDnNZ1P+O4TRHo+0kbOpUb0zM9HY5OEeq9gcvGG9nR8lRGC+a770rEzODxYZFEXI
 PUZRKBgvylMjjbjbulaLaM0SpqBVBktYfiicrUxjokWsrQsGpg2bCzKhMVkytjrpwC5H
 9THg==
X-Gm-Message-State: ABy/qLaI4dvQBB+vK1qggbcq8ci6PEdBVJTGTIxD2yXcAJvx/IQF0P5r
 mogX8N8vjftttC57Ki/qoIliRrLKH/m54096k+9xj6YosctbQGN4MFQLH5OW6IQ4YouHqsr3zPe
 hzMuyOWB401XX+VmKIJjdkRaFGtUhSb1sUotAissmuUwb6ZhfoIVq+c5TKwEmkz397Hv8dzGDtW
 aKES+M
X-Google-Smtp-Source: APBJJlFrmLQAb9wmumC0iAi4EdVU2/gKY4Cs2ViAimjBia4SOVrUMmaBQxWnFIIC1hYGO4khxPd2NQ==
X-Received: by 2002:a05:6a20:100c:b0:12d:208c:acaa with SMTP id
 gs12-20020a056a20100c00b0012d208cacaamr2826888pzc.26.1689324274409; 
 Fri, 14 Jul 2023 01:44:34 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 c19-20020aa781d3000000b006829b28b393sm6616305pfn.199.2023.07.14.01.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 01:44:34 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: rkanwal@rivosinc.com, anup@brainfault.org, dbarboza@ventanamicro.com,
 ajones@ventanamicro.com, atishp@atishpatra.org, vincent.chen@sifive.com,
 greentime.hu@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH v6 0/5] Add RISC-V KVM AIA Support
Date: Fri, 14 Jul 2023 08:44:22 +0000
Message-Id: <20230714084429.22349-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This series adds support for KVM AIA in RISC-V architecture.

In order to test these patches, we require Linux with KVM AIA support which can
be found in the riscv_kvm_aia_hwaccel_v1 branch at
https://github.com/avpatel/linux.git

---
v6:
- fix alignment
- add hart index to the error message of ISMIC address setting in PATCH3

v5:
- remove the linux-header update patch since the riscv-to-apply.next QEMU has
synced up to Linux 6.5-rc1 headers.
- create the APLIC and IMSIC FDT helper functions in PATCH1
- add the irqfd support in PATCH3
- fix the comments and refine the code

v4:
- update the linux header by the scripts/update-linux-headers.sh in PATCH1
- remove the checking for "aplic_m" before creating S-mode APLIC device in PATCH2
- add more setting when we initialize the KVM AIA chip in PATCH4
- fix msi message delivery and the APLIC devices emulation in PATCH5
- fix the AIA devices mapping with NUMA enabled in PATCH6
- add "kvm-aia" parameter to sepecify the KVM AIA mode in PATCH6

v3:
- fix typo
- tag the linux-header patch as placeholder

v2:
- rebase to riscv-to-apply.next
- update the linux header by the scripts/update-linux-headers.sh

Yong-Xuan Wang (5):
  target/riscv: support the AIA device emulation with KVM enabled
  target/riscv: check the in-kernel irqchip support
  target/riscv: Create an KVM AIA irqchip
  target/riscv: update APLIC and IMSIC to support KVM AIA
  target/riscv: select KVM AIA in riscv virt machine

 hw/intc/riscv_aplic.c    |  56 ++++--
 hw/intc/riscv_imsic.c    |  25 ++-
 hw/riscv/virt.c          | 410 ++++++++++++++++++++++-----------------
 include/hw/riscv/virt.h  |   1 +
 target/riscv/kvm.c       | 170 +++++++++++++++-
 target/riscv/kvm_riscv.h |   6 +
 6 files changed, 469 insertions(+), 199 deletions(-)

-- 
2.17.1


