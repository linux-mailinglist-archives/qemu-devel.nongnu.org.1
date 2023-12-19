Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7587E819068
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:14:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfWl-0001kI-Oj; Tue, 19 Dec 2023 14:13:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWj-0001jj-IP
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:13 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWg-0001lE-Hr
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:13 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-336417c565eso4660940f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013188; x=1703617988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=N2mKSpAmgkv+I1RECmDVN9Rzk+j/BHgPdom45PWseYc=;
 b=U8CJ1eGOWbbT4Y5Hn2+9Tvp0FyQaO4u0tUHQar+MBrL304fLWv6i7aaL8B71kICvCP
 staSh3wUR4zh02WJ/efM/wPRyLz1ok9sXcB7v0rlIreLY81epAW2lgxmM8elOEEM6yqL
 ICgVz/fMqYHNcWvMDDTfBekLZ1U1e7Qi2F1ZTH1AaJ+69niYd5rt33iJUreC7Dw2BMXi
 6cPHgx/KLqQP2d8/mPMcQZgUcbxYFlwVOWypxkYMWWrXy/8MnxWcpEiaentKrM0KorGA
 fYPGR8DbxLx9O+YqDeIMkYDDLwgCbxEqgUh3c256zM0FVYahlC1ITZ1bYnhEpXqsbHnk
 se7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013188; x=1703617988;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N2mKSpAmgkv+I1RECmDVN9Rzk+j/BHgPdom45PWseYc=;
 b=VPBEbYBGzWdyJ4JzQnG3ETv7Y3yfeKrchDE6bQYS+JQopkXSQXqpINjxvD+qq9XqbM
 POVpi/C6A3udXdebN69ri/MuwwVNsYm4D1XgAzi5DQ70a2EWiYzGfl2D0f1DbfsLxoVH
 q1VzO61AhWonouuf6iznUZfz6fVbI8HBMjttm09OWCoRq6qHtwfKdPX5gv+ij57CY1W9
 MA2htMSQtHG/v/D5ZAemStxyh3g6/jMcqAX6TMqigJ39yz5IKjwCWdfUGq9aQ1Qcu0XB
 EeqNDC2g9/+iQP8hp0w+vaORa4+g3w9i8xXVgb96ejzYzm/oFIK9LUuN8lvh1qA9Z/8m
 CmPQ==
X-Gm-Message-State: AOJu0YwTuaCMpV5Knna376oSEqgeYwjksmwfchPvo4JQfTW/skedCmMJ
 eNw7JcVNOglS59VI2Wr3Kk6m2KujTRFiDgOxhyw=
X-Google-Smtp-Source: AGHT+IHpMOQZrB4hBFMh5YH6Ao8IPhIlhec4s6jcDLuslicBOb8Zeq6H+6fo64mXz3DNxzkP7/EBLA==
X-Received: by 2002:a5d:6392:0:b0:336:66ef:a82b with SMTP id
 p18-20020a5d6392000000b0033666efa82bmr1698836wru.104.1703013188506; 
 Tue, 19 Dec 2023 11:13:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/43] target-arm queue
Date: Tue, 19 Dec 2023 19:12:24 +0000
Message-Id: <20231219191307.2895919-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Hi; here's the first target-arm pullreq for the 9.0 cycle.
The bulk of this is some cleanup/refactoring in the Arm
KVM code.

thanks
-- PMM

The following changes since commit bd00730ec0f621706d0179768436f82c39048499:

  Open 9.0 development tree (2023-12-19 09:46:22 -0500)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20231219

for you to fetch changes up to 6f9c3aaa34e937d8deaab44671e7562e4027436b:

  fsl-imx: add simple RTC emulation for i.MX6 and i.MX7 boards (2023-12-19 18:03:32 +0000)

----------------------------------------------------------------
target-arm queue:
 * arm/kvm: drop the split between "common KVM support" and
   "64-bit KVM support", since 32-bit Arm KVM no longer exists
 * arm/kvm: clean up APIs to be consistent about CPU arguments
 * Don't implement *32_EL2 registers when EL1 is AArch64 only
 * Restrict DC CVAP & DC CVADP instructions to TCG accel
 * Restrict TCG specific helpers
 * Propagate MDCR_EL2.HPMN into PMCR_EL0.N
 * Include missing 'exec/exec-all.h' header
 * fsl-imx: add simple RTC emulation for i.MX6 and i.MX7 boards

----------------------------------------------------------------
Chao Du (1):
      target/arm: kvm64: remove a redundant KVM_CAP_SET_GUEST_DEBUG probe

Jean-Philippe Brucker (1):
      target/arm/helper: Propagate MDCR_EL2.HPMN into PMCR_EL0.N

Nikita Ostrenkov (1):
      fsl-imx: add simple RTC emulation for i.MX6 and i.MX7 boards

Peter Maydell (1):
      target/arm: Don't implement *32_EL2 registers when EL1 is AArch64 only

Philippe Mathieu-Daudé (19):
      hw/intc/arm_gicv3: Include missing 'qemu/error-report.h' header
      target/arm/kvm: Remove unused includes
      target/arm/kvm: Have kvm_arm_add_vcpu_properties take a ARMCPU argument
      target/arm/kvm: Have kvm_arm_sve_set_vls take a ARMCPU argument
      target/arm/kvm: Have kvm_arm_sve_get_vls take a ARMCPU argument
      target/arm/kvm: Have kvm_arm_set_device_attr take a ARMCPU argument
      target/arm/kvm: Have kvm_arm_pvtime_init take a ARMCPU argument
      target/arm/kvm: Have kvm_arm_pmu_init take a ARMCPU argument
      target/arm/kvm: Have kvm_arm_pmu_set_irq take a ARMCPU argument
      target/arm/kvm: Have kvm_arm_vcpu_init take a ARMCPU argument
      target/arm/kvm: Have kvm_arm_vcpu_finalize take a ARMCPU argument
      target/arm/kvm: Have kvm_arm_[get|put]_virtual_time take ARMCPU argument
      target/arm/kvm: Have kvm_arm_verify_ext_dabt_pending take a ARMCPU arg
      target/arm/kvm: Have kvm_arm_handle_dabt_nisv take a ARMCPU argument
      target/arm/kvm: Have kvm_arm_handle_debug take a ARMCPU argument
      target/arm/kvm: Have kvm_arm_hw_debug_active take a ARMCPU argument
      target/arm: Restrict TCG specific helpers
      target/arm: Restrict DC CVAP & DC CVADP instructions to TCG accel
      target/arm/tcg: Including missing 'exec/exec-all.h' header

Richard Henderson (20):
      accel/kvm: Make kvm_has_guest_debug static
      target/arm/kvm: Merge kvm_arm_init_debug into kvm_arch_init
      target/arm/kvm: Move kvm_arm_verify_ext_dabt_pending and unexport
      target/arm/kvm: Move kvm_arm_copy_hw_debug_data and unexport
      target/arm/kvm: Move kvm_arm_hw_debug_active and unexport
      target/arm/kvm: Move kvm_arm_handle_debug and unexport
      target/arm/kvm: Unexport kvm_arm_{get, put}_virtual_time
      target/arm/kvm: Inline kvm_arm_steal_time_supported
      target/arm/kvm: Move kvm_arm_get_host_cpu_features and unexport
      target/arm/kvm: Use a switch for kvm_arm_cpreg_level
      target/arm/kvm: Move kvm_arm_cpreg_level and unexport
      target/arm/kvm: Move kvm_arm_reg_syncs_via_cpreg_list and unexport
      target/arm/kvm: Merge kvm64.c into kvm.c
      target/arm/kvm: Unexport kvm_arm_vcpu_init
      target/arm/kvm: Unexport kvm_arm_vcpu_finalize
      target/arm/kvm: Unexport kvm_arm_init_cpreg_list
      target/arm/kvm: Init cap_has_inject_serror_esr in kvm_arch_init
      target/arm/kvm: Unexport kvm_{get,put}_vcpu_events
      target/arm/kvm: Unexport and tidy kvm_arm_sync_mpstate_to_{kvm, qemu}
      target/arm/kvm: Unexport kvm_arm_vm_state_change

 include/hw/misc/imx7_snvs.h    |    7 +-
 target/arm/kvm_arm.h           |  231 +------
 accel/kvm/kvm-all.c            |    2 +-
 hw/arm/virt.c                  |    9 +-
 hw/intc/arm_gicv3_its_kvm.c    |    1 +
 hw/misc/imx7_snvs.c            |   93 ++-
 target/arm/cpu.c               |    2 +-
 target/arm/cpu64.c             |    2 +-
 target/arm/debug_helper.c      |   23 +-
 target/arm/helper.c            |  117 ++--
 target/arm/kvm.c               | 1409 ++++++++++++++++++++++++++++++++++++++--
 target/arm/kvm64.c             | 1290 ------------------------------------
 target/arm/tcg/op_helper.c     |   55 ++
 target/arm/tcg/translate-a64.c |    1 +
 hw/misc/trace-events           |    4 +-
 target/arm/meson.build         |    2 +-
 16 files changed, 1592 insertions(+), 1656 deletions(-)
 delete mode 100644 target/arm/kvm64.c

