Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7437F6654
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:36:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EY8-0007ji-8A; Thu, 23 Nov 2023 13:35:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EXt-0007Zs-9r
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:35:26 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EXr-0002Vj-9a
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:35:25 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c887d1fb8fso14858311fa.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700764521; x=1701369321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uROfwQyK/fR3xRoZfbjH/zMx60LfqgoyHKl0bdS07As=;
 b=KPZKuh5AqAvsKqBTD/xf9PVzRBU+sHGk6H2NH7Hf0R/rQQbcGOQehnvtMNzerhFpEb
 txXsLTs0MWnqWT3qN8yfz62jglKlK/1N4HkSKah2zOSnVrFXHAJw+nXyzi5bp3o25DM8
 k/7CNCX7PqeoYjg99gJP3Qe7yFCOAGh8QsxxsPYCRYs9x1+U4NfGyXjlcj/6U5TK84jc
 Qa/oUbEzh9Pllh1V9E0NhHsemKTHnVZCzfHAsyoZ/Wil+qyiwB0OP16THy1Y0cOZ1zhN
 RLsInJ1JG4OzybCS5IY0USWWLNGkwc1+4xeSjjaSXqil+cbGLa+KxwBfFWqTfX595bPy
 qdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700764521; x=1701369321;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uROfwQyK/fR3xRoZfbjH/zMx60LfqgoyHKl0bdS07As=;
 b=LmP9RSij7tzk8ydAwCXkydmIT7/CV2pt3AUT3pXWSNmBgLqQ+ig77VBQ8QwmV1Qiy6
 vriZW4qRfJC/nvpIxijThxqjpbQVUITykPT8oV0280VKOWhtHXnHon14An7RlDyptTxn
 YYKFwol62TCIsVep9ufvhUQFe37l3Jl1HTqiLKGYCsdFphn3gujTTlO0NHVc0H8of4LP
 hGCtsyXmrQQzCvrJJiRzb9NNufm5wwMFLyd+fKscuAx0z5Fm4awedo1bMXgW8YDp2ysF
 3FZFh/hO6A12fwiUGIA78C7Vb1H9KhRALIZko0GYk5RUYc7U4EPI9PPxJT30V3bnw5u8
 YPrA==
X-Gm-Message-State: AOJu0Ywad1WX0zevuluqLl2hxrQK19SQAkjsvCy+PtBWzPnpP/3X/HLw
 FWgAEhBN4mGXsKzebHWdOilK5AxmzX4Z+i2kJ0w=
X-Google-Smtp-Source: AGHT+IFzB25AWCf2QBTuEtFSvO8CfDj+XT4u9/Sa8d5qUcbTy/ivbEYxfMXhnkTWfil4h0gnaJ1/9w==
X-Received: by 2002:a2e:7017:0:b0:2c8:56f5:9082 with SMTP id
 l23-20020a2e7017000000b002c856f59082mr123850ljc.50.1700764521179; 
 Thu, 23 Nov 2023 10:35:21 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a05600c35c700b0040b30be6244sm2807528wmq.24.2023.11.23.10.35.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 10:35:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 00/16] target/arm/kvm: Unify kvm_arm_FOO() API
Date: Thu, 23 Nov 2023 19:35:01 +0100
Message-ID: <20231123183518.64569-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

Half of the API takes CPUState, the other ARMCPU...

$ git grep -F 'CPUState *' target/arm/kvm_arm.h | wc -l
      16
$ git grep -F 'ARMCPU *' target/arm/kvm_arm.h | wc -l
      14

Since this is ARM specific, have it always take ARMCPU, and
call the generic KVM API casting with the CPU() macro.

Based-on: <20231123044219.896776-1-richard.henderson@linaro.org>
  "target/arm: kvm cleanups"
  https://lore.kernel.org/qemu-devel/20231123044219.896776-1-richard.henderson@linaro.org/

Philippe Mathieu-Daudé (16):
  hw/intc/arm_gicv3: Include missing 'qemu/error-report.h' header
  target/arm/kvm: Remove unused includes
  target/arm/kvm: Have kvm_arm_add_vcpu_properties take a ARMCPU
    argument
  target/arm/kvm: Have kvm_arm_sve_set_vls take a ARMCPU argument
  target/arm/kvm: Have kvm_arm_sve_get_vls take a ARMCPU argument
  target/arm/kvm: Have kvm_arm_set_device_attr take a ARMCPU argument
  target/arm/kvm: Have kvm_arm_pvtime_init take a ARMCPU argument
  target/arm/kvm: Have kvm_arm_pmu_init take a ARMCPU argument
  target/arm/kvm: Have kvm_arm_pmu_set_irq take a ARMCPU argument
  target/arm/kvm: Have kvm_arm_vcpu_init take a ARMCPU argument
  target/arm/kvm: Have kvm_arm_vcpu_finalize take a ARMCPU argument
  target/arm/kvm: Have kvm_arm_[get|put]_virtual_time take ARMCPU
    argument
  target/arm/kvm: Have kvm_arm_verify_ext_dabt_pending take a ARMCPU arg
  target/arm/kvm: Have kvm_arm_handle_dabt_nisv take a ARMCPU argument
  target/arm/kvm: Have kvm_arm_handle_debug take a ARMCPU argument
  target/arm/kvm: Have kvm_arm_hw_debug_active take a ARMCPU argument

 target/arm/kvm_arm.h        |  26 ++++-----
 hw/arm/virt.c               |   9 +--
 hw/intc/arm_gicv3_its_kvm.c |   1 +
 target/arm/cpu.c            |   2 +-
 target/arm/cpu64.c          |   2 +-
 target/arm/kvm.c            | 111 +++++++++++++++++-------------------
 6 files changed, 73 insertions(+), 78 deletions(-)

-- 
2.41.0


