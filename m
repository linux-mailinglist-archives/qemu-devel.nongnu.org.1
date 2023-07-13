Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A49751C05
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 10:45:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJrw6-0006Lm-BZ; Thu, 13 Jul 2023 04:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1qJrvw-0006LG-RV
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 04:44:21 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1qJrvp-0006x0-4K
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 04:44:18 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6687446eaccso480607b3a.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 01:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1689237851; x=1691829851;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5K2i1+A0inp6dLZW4IpBQ9GMwT8L5nzRPcMlItBo+Rk=;
 b=F6xc4NsjpSTDQWysuhVweGjZqvxlJZzQus/8noCSg2+LdZnkBjwTk4fX1S4UXCDfU7
 3fVNb08iXEnIeQvoSjvH44+oZHzVLp1kyZ3afCxK13P3HgxFXdVloY7gUyG3rrwKnP0f
 BdS7Y1M1KdDQXHdk7IX3s8g5HpuEj/OvRBRvEm4anqOFjlz2HzVxY9L7SuX4uAoGyW1b
 YB/P0rWyn1NEd+6Vyul3ShsaQMSX6exR+woQ+g63GnHiiNFt7L03geDq2Ev654HrDyq1
 K2RnS5YUJW4sSHzcXMaPiFnPoMRba5xk2tURgcUDsn0nJ0c2RtOJXmpdwMQHibAC4p9M
 XJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689237851; x=1691829851;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5K2i1+A0inp6dLZW4IpBQ9GMwT8L5nzRPcMlItBo+Rk=;
 b=Y4GNiSZpLyqP8JX2SRVrGkuOps7keKgaJHr8BwQyg6fiGBB9G7Zup9yi0twUAQ6B8t
 zfYetCp0+tczAkeoZjWGWwyzggFXpF1u22SQjHcBhu1FmLBaXjFs/k6LgDoAf+uzhf9d
 BItVhawfC3ms2iWZ5M0MRX+ZLl8jLnp2msFal5loBUdh4qlOI09DipymKwTX9s7zP511
 GJ86mfD9sWv+yHsVjZqvyK3meFjG8ggmgfvgoXDIppDCE/4yJRV91c1efzivBnvYv623
 6lDuXDo6xmK0ec+0z3vvTYgPWDi2WzT/vIWDwKfQrskhDitvllf7wyAxtleN+Qhemhpx
 qtrA==
X-Gm-Message-State: ABy/qLZBMJ4VvBZqAp4YOgaUeWIIVx3hDPml0dCDFb7OBhPHa6A7owYV
 R/CeC/rtgQKCtREKokgBeP16Emnr9Idhwx5YKTncmDOJqEKJBbNziyhyqOlLfs71j4P4CBNJB2p
 sDvRtLbkn6uYUEI53L01Qnr56Ew72nINdyTlaygWO5iQ/7rRtYU78llH0KyqLs8NT7J4zY81CJh
 Ya0UQF
X-Google-Smtp-Source: APBJJlEUh3r2gNo1cPaWv4JiM2nrOM4hhVHM5XIYQw98jsOn0ZUGs06XKdA9aoHSHdELjhSCr4wVhg==
X-Received: by 2002:a05:6a21:999c:b0:f3:33fb:a62b with SMTP id
 ve28-20020a056a21999c00b000f333fba62bmr1000277pzb.9.1689237851241; 
 Thu, 13 Jul 2023 01:44:11 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 c10-20020a63724a000000b0055386b1415dsm4989198pgn.51.2023.07.13.01.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 01:44:10 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: rkanwal@rivosinc.com, anup@brainfault.org, dbarboza@ventanamicro.com,
 ajones@ventanamicro.com, atishp@atishpatra.org, vincent.chen@sifive.com,
 greentime.hu@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH v5 0/5] Add RISC-V KVM AIA Support
Date: Thu, 13 Jul 2023 08:43:52 +0000
Message-Id: <20230713084405.24545-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
 hw/riscv/virt.c          | 381 ++++++++++++++++++++++-----------------
 include/hw/riscv/virt.h  |   1 +
 target/riscv/kvm.c       | 170 ++++++++++++++++-
 target/riscv/kvm_riscv.h |   6 +
 6 files changed, 452 insertions(+), 187 deletions(-)

-- 
2.17.1


