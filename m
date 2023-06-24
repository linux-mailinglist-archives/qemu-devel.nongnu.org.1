Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF64173CC22
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 19:42:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD7GQ-0005c1-A5; Sat, 24 Jun 2023 13:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD7GM-0005bg-9v
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 13:41:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD7GJ-00063i-H2
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 13:41:29 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fa70ec8d17so26238385e9.1
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 10:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687628485; x=1690220485;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9DD8JyzZ0D9c0TVJWROVlnDQP9z+YeCBvlalUwzeBRo=;
 b=S8HxrYQ2qhgw56X9JXNpzNmjfiViWtcbiWCpgQccPHZivixZ7QAzwnG0azVoU7xVwb
 akuxl0mdCTpThLPPNG44q2zM7WFBYRf++FIjeb7OZaKYcNCoxQVVFO06aKvqykPLZlYZ
 ZvpNiq98b5G8YgGvHvAodfNZ2LcJFFazSZG27b+pSB9bw6v7bdgijzZhhCtwRpACo7M0
 slPhBm89C1gJKR7y1ERfGhGue/oWbU0iTwXu9x0IUylVr99MqavVrVlJRD4xj8CSGUvm
 6za9HdL9/cV4dMDN2/DHhAKDF5i4CxvXeVSa4T7v0NhA1XGwrIFxIoVXTwJ+ThKpvofI
 84Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687628485; x=1690220485;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9DD8JyzZ0D9c0TVJWROVlnDQP9z+YeCBvlalUwzeBRo=;
 b=NfWKlwEMNa6J6FAo0O/eXozVYt9t/etgyQ6YR/I1AZmF71AaUqfrYuFBIIvk7IgoEa
 pOd67xvP63dOY2OlmQ+RYQ93C3CbxFDHaZfQLsV2S7kO1uOKuOLZEU25zR59XExmakVJ
 dqDcefVum/ZmK4t+2sYHSg/EHhdVGE8yPx18EVTQ4n1GRWlTICXyVLdbATqrQ2H+IIRD
 DZOT+aP0Qk0CRw7lUbQNw510forNq0uElAVz/o+nx8gbv9HApAdbkK40y1C3/AkvIQaA
 YuZL5pQRZSlXd7+zXPORf+y30iGFGGcQsnuVaIAAvHbelPcOyRedMOp5eVumS2KGAI9J
 z94A==
X-Gm-Message-State: AC+VfDx4K1LORUyA69atF0CNIsj6f8P/QMlQjX4LQTaaL7dfid8jDaru
 0KLmXp068DDSpz4zLhzEMjr6D2w1pE2FdkYARyY=
X-Google-Smtp-Source: ACHHUZ4RU70EsAbLLa974X6kTmgNQb8jnG4vK1SD4DHwEek3Lg8HiGz7TW7mHUT/jA40wDP62z4cEA==
X-Received: by 2002:a05:600c:2942:b0:3f7:e7a2:25f6 with SMTP id
 n2-20020a05600c294200b003f7e7a225f6mr21913470wmd.17.1687628485030; 
 Sat, 24 Jun 2023 10:41:25 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.150])
 by smtp.gmail.com with ESMTPSA id
 p23-20020a1c7417000000b003f9b0f640b1sm2711760wmc.22.2023.06.24.10.41.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 24 Jun 2023 10:41:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, xen-devel@lists.xenproject.org,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Reinoud Zandijk <reinoud@netbsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 00/16] accel: Share CPUState accel context
 (HAX/NVMM/WHPX/HVF)
Date: Sat, 24 Jun 2023 19:41:05 +0200
Message-Id: <20230624174121.11508-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This series is part of the single binary effort.

All accelerator will share their per-vCPU context in
an opaque 'accel' pointer within the CPUState.

First handle HAX/NVMM/WHPX/HVF. KVM and TCG will follow
as two different (bigger) follow-up series.

Except HVF/intel, all has been (cross-)build tested.

I plan to send the PR myself.

Since v2:
- Addressed rth's review comments
- Added rth's R-b tag

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
  accel: Rename 'cpu_state' -> 'cs'
  accel: Rename HVF 'struct hvf_vcpu_state' -> AccelCPUState

 MAINTAINERS                       |   4 +-
 include/hw/core/cpu.h             |  10 +-
 include/qemu/typedefs.h           |   1 +
 include/sysemu/hax.h              |   2 +
 include/sysemu/hvf_int.h          |   2 +-
 include/sysemu/kvm.h              |   2 +
 include/sysemu/nvmm.h             |   2 +
 include/sysemu/tcg.h              |   2 +
 include/sysemu/whpx.h             |   2 +
 include/sysemu/xen.h              |   2 +
 target/i386/hax/hax-i386.h        |  12 +-
 target/i386/hvf/vmx.h             |  22 +-
 target/i386/hvf/x86hvf.h          |  18 +-
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
 target/i386/hvf/x86hvf.c          | 372 +++++++++++++++---------------
 target/i386/nvmm/nvmm-all.c       |  42 ++--
 target/i386/whpx/whpx-accel-ops.c |   3 -
 target/i386/whpx/whpx-all.c       |  45 ++--
 .mailmap                          |   3 +-
 32 files changed, 469 insertions(+), 485 deletions(-)

-- 
2.38.1


