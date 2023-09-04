Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F61791753
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:44:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8vV-0000y1-Ol; Mon, 04 Sep 2023 08:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8vU-0000xp-DA
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:43:32 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8vR-0004c7-Vp
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:43:32 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9a5be3166a2so195076866b.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693831408; x=1694436208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KgdDAI5WJeQpNJ7fVmtYD+dCjS5FrBlY0naTS3cJ2cY=;
 b=JCPwwlN4qyay4pLYCrkAbK8XrsuIMW+DyqrPMbZhZAAkCQFEyeCfQ2D3ev1qbAqxcA
 IF3uP1NtfbmUc4ZJALz878sSqmYdsx1x4Ite8PuvvHPbpnLFTFhJiC14/L+QtaX/ehUm
 N1JuRTTkAIP03jLlB8ZhCDOr8XUE93XRa/iIoVCR+2SOEs0wpn/6lHyJvxFpeYnennP0
 nZ8N1G89g/QMW+ENDo5Se8PaXht3tgMAsWHQQg8rWFT5CSnIVHgus4q9xkBvWeJ8lFf9
 tJUISWcf/W/2FoqG+B2T6Ft7wh1rODoTXcwGH3YcyNgBf/dJS8Gu5uhptvpYfU45FT+a
 GaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693831408; x=1694436208;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KgdDAI5WJeQpNJ7fVmtYD+dCjS5FrBlY0naTS3cJ2cY=;
 b=T+JMLp1PYv+WJK3/y/fEko7R9rej4+woKsw46tcRvz9glSApkr5lqqHtq4wIP95Ulu
 fe/pwnw+WwkO0HEoEF1xS9xZPAQHz5PKStDZ29i+JqIHov596UiP5fCEXmEWGgrZ6+i5
 8P0K7jIwzs3MnzgECiF7MT3uYl/YiJjarozqwT/8KpE+tyEM3fLHFyvhphyzAsESyh1D
 t77uwBf2CWaSmFMJKI+ejcVafUMhYT6J04wXEtLeMTvGqNb6NENt/2ECbhl/WLt+h7SL
 fNGqeOlWM4Fi3OtzViMnh5daaOGiv7P40iTLoK6r+C2r3QMWYuCn4s6xM0Z8reeuM+mW
 ZayQ==
X-Gm-Message-State: AOJu0YwRXtx91NbsgJnNAN21Khp7GJtixo7DwI72PMjfMu0ca7OiUIAb
 ZQa3QMmw3u9oFYFqgauEPCQzsTQv9w5LXtHQX+Q=
X-Google-Smtp-Source: AGHT+IFhdp2S6dmdQU4L+6xLxXs/ra3AOIWeAuonsSZVIyQsXIqOo0I4pZ2Cuh3QLrH5FtcNOMpNIw==
X-Received: by 2002:a17:906:2d1:b0:99e:5d8:a6f9 with SMTP id
 17-20020a17090602d100b0099e05d8a6f9mr6609163ejk.66.1693831407692; 
 Mon, 04 Sep 2023 05:43:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 um16-20020a170906cf9000b00992d70f8078sm6099214ejb.106.2023.09.04.05.43.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 05:43:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/13] target/i386: Cleanups around KVM declarations
Date: Mon,  4 Sep 2023 14:43:11 +0200
Message-ID: <20230904124325.79040-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Mostly trivial cleanups.

We want to have QEMU core code accel-agnostic.
(In particular, removing the KVM specific fields
from CPUState).

This serie contains the x86 specific patches
before starting with the generic KVM code.

FWIW, I couldn't test the 'HVF only' configuration
since I don't have access to such host.

Regards,

Phil.

Philippe Mathieu-Daudé (13):
  hw/i386/pc: Include missing 'sysemu/tcg.h' header
  hw/i386/pc: Include missing 'cpu.h' header
  hw/i386/fw_cfg: Include missing 'cpu.h' header
  target/i386/helper: Restrict KVM declarations to system emulation
  target/i386/cpu-sysemu: Inline kvm_apic_in_kernel()
  target/i386: Remove unused KVM stubs
  target/i386: Allow elision of kvm_enable_x2apic()
  target/i386: Allow elision of kvm_hv_vpindex_settable()
  target/i386: Restrict declarations specific to CONFIG_KVM
  sysemu/kvm: Restrict kvm_arch_get_supported_cpuid/msr() to x86 targets
  sysemu/kvm: Restrict kvm_get_apic_state() to x86 targets
  sysemu/kvm: Restrict kvm_has_pit_state2() to x86 targets
  sysemu/kvm: Restrict kvm_pc_setup_irq_routing() to x86 targets

 include/sysemu/kvm.h        | 10 --------
 target/i386/kvm/kvm_i386.h  | 36 ++++++++++++++++----------
 hw/i386/fw_cfg.c            |  1 +
 hw/i386/intel_iommu.c       |  2 +-
 hw/i386/kvm/i8254.c         |  1 +
 hw/i386/kvm/ioapic.c        |  1 +
 hw/i386/pc_piix.c           |  1 +
 hw/i386/pc_q35.c            |  2 ++
 hw/i386/x86.c               |  4 +--
 target/i386/cpu-sysemu.c    |  4 +--
 target/i386/helper.c        |  2 +-
 target/i386/kvm/kvm-stub.c  | 51 -------------------------------------
 target/i386/kvm/kvm.c       |  4 +--
 target/i386/kvm/meson.build |  2 --
 14 files changed, 37 insertions(+), 84 deletions(-)
 delete mode 100644 target/i386/kvm/kvm-stub.c

-- 
2.41.0


