Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B973E73A597
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:09:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCMrM-0002FF-4Z; Thu, 22 Jun 2023 12:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCMrK-0002Eu-33
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:08:34 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCMrI-0007dI-Go
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:08:33 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f8fe9dc27aso59317625e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 09:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687450110; x=1690042110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/A79JoyFfC6huza+xbUxwLYTIgxFxi3HGGy1xW4nwf8=;
 b=yogdQdljLj0VC7TAdW5mlkO4xehQvvssX0cA2nch6oDaBprLzWiFgwagXbPBEJUPzI
 8OIBQRK96iDOUORSsMWxYq09FsUAl57K3U6Spr+laGQYD3up4utpggKFA6QLgT1pnzzE
 g09YvBAEWhT3Ne6uAEZ20ASjG6NJFVrE6dhCKSAE9ftFgL2VQh2k27lBfh/eH1PALh0Z
 TigFNL8HOV955rvc2CCDmdPvrqvFji3F59lOahxFByvvXG/hhrUnXerexENOEtvdDaP7
 6ovmIZ3Podq1bNUKQAn5JcJ6oFpTB2lBDcFo1YeGaK5hyp/SsBuz0JGuRcUMA00y2fZf
 V4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687450110; x=1690042110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/A79JoyFfC6huza+xbUxwLYTIgxFxi3HGGy1xW4nwf8=;
 b=VQc+h8jrXsUPIeaevM0FQPGktJiflsgzJirrBEgY/LBkYj6yOQOwrcXhie4PnxuH3F
 +SHCRjkLWjxIvFhs8nmuYYSvZJAl4aSoHBc2IWX2e3BTKNJIIxd6JyGPKgpnZM21yG4m
 pbiGBC4IrIp/4LJumJytyZ+Ob4StXCcFb6BJK2cTquEmCFjMmUDSmV8gnVY8KiXCREQD
 JS3qUNPysyaTG3fSYvJOSlqbAaEAcq2dkXDs0VMd/uRr7wMSCusWd65NX0X19yuxPvgg
 dAdctQ9RXFL5BqjdwGga6HfCwJKM8tH82qACU5BDAbCZqQWB6PQ5l17WBRK1JOXY5Pz+
 VkXA==
X-Gm-Message-State: AC+VfDyVus28kPgfsle9Wt82pfulOCNHRYo9ToKXezbAqm+jbPUMfsAI
 rrDkyWW1RowWOLJ5tlU4bHpdPGn1vIkuRkVH6MRWQA==
X-Google-Smtp-Source: ACHHUZ5K2Rg4dqx8epN1plFR54zJdcZBY/04rfPHyMaRt+7mvQIveLbQzgFDlKqnployGGPzU7dMVw==
X-Received: by 2002:a05:600c:22d2:b0:3f9:b297:1804 with SMTP id
 18-20020a05600c22d200b003f9b2971804mr8567893wmg.17.1687450110516; 
 Thu, 22 Jun 2023 09:08:30 -0700 (PDT)
Received: from localhost.localdomain (230.red-88-28-3.dynamicip.rima-tde.net.
 [88.28.3.230]) by smtp.gmail.com with ESMTPSA id
 k9-20020a7bc409000000b003f9b24cf881sm10466573wmi.16.2023.06.22.09.08.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jun 2023 09:08:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Durrant <paul@xen.org>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Eduardo Habkost <eduardo@habkost.net>,
 Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 00/16] accel: Share CPUState accel context
 (HAX/NVMM/WHPX/HVF)
Date: Thu, 22 Jun 2023 18:08:07 +0200
Message-Id: <20230622160823.71851-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

This series is part of the single binary effort.

All accelerator will share their per-vCPU context in
an opaque 'accel' pointer within the CPUState.

First handle HAX/NVMM/WHPX/HVF. KVM and TCG will follow
as two different (bigger) follow-up series.

Since v1:
- Addressed rth's review comments
- Added rth's R-b tag
- Converted HVF intel (untested)
- Rebased

Philippe Mathieu-Daudé (16):
  MAINTAINERS: Update Roman Bolshakov email address
  accel: Document generic accelerator headers
  accel: Remove unused hThread variable on TCG/WHPX
  accel: Fix a leak on Windows HAX
  accel: Destroy HAX vCPU threads once done
  accel: Rename 'hax_vcpu' as 'accel' in CPUState
  accel: Rename HAX 'struct hax_vcpu_state' -> AccelCPUState
  accel: Move HAX hThread to accelerator context
  accel: Remove NVMM unreachable error path
  accel: Rename NVMM 'struct qemu_vcpu' -> AccelCPUState
  accel: Inline NVMM get_qemu_vcpu()
  accel: Remove WHPX unreachable error path
  accel: Rename WHPX 'struct whpx_vcpu' -> AccelCPUState
  accel: Inline WHPX get_whpx_vcpu()
  accel: Rename 'cpu_state' -> 'cpu'
  accel: Rename HVF 'struct hvf_vcpu_state' -> AccelCPUState

 MAINTAINERS                       |   4 +-
 include/hw/core/cpu.h             |  10 +-
 include/sysemu/hax.h              |   2 +
 include/sysemu/hvf_int.h          |   2 +-
 include/sysemu/kvm.h              |   2 +
 include/sysemu/nvmm.h             |   2 +
 include/sysemu/tcg.h              |   2 +
 include/sysemu/whpx.h             |   2 +
 include/sysemu/xen.h              |   2 +
 target/i386/hax/hax-i386.h        |  14 +-
 target/i386/hvf/vmx.h             |  22 +-
 target/i386/hvf/x86hvf.h          |  12 +-
 accel/hvf/hvf-accel-ops.c         |  18 +-
 accel/tcg/tcg-accel-ops-mttcg.c   |   4 -
 accel/tcg/tcg-accel-ops-rr.c      |   3 -
 target/arm/hvf/hvf.c              | 108 ++++-----
 target/i386/hax/hax-accel-ops.c   |   5 +-
 target/i386/hax/hax-all.c         |  26 ++-
 target/i386/hax/hax-posix.c       |   4 +-
 target/i386/hax/hax-windows.c     |   6 +-
 target/i386/hvf/hvf.c             | 104 ++++-----
 target/i386/hvf/x86.c             |  28 +--
 target/i386/hvf/x86_descr.c       |  26 +--
 target/i386/hvf/x86_emu.c         |  62 ++---
 target/i386/hvf/x86_mmu.c         |   4 +-
 target/i386/hvf/x86_task.c        |  10 +-
 target/i386/hvf/x86hvf.c          | 364 +++++++++++++++---------------
 target/i386/nvmm/nvmm-all.c       |  42 ++--
 target/i386/whpx/whpx-accel-ops.c |   3 -
 target/i386/whpx/whpx-all.c       |  45 ++--
 .mailmap                          |   3 +-
 31 files changed, 462 insertions(+), 479 deletions(-)

-- 
2.38.1


