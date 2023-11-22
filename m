Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D907F4F95
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 19:32:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5s0K-00049N-KX; Wed, 22 Nov 2023 13:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s07-000494-F2
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:07 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5rzx-0004YC-Lg
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:30:57 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3316d09c645so21674f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 10:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700677851; x=1701282651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7Rm3lhCAuFgUPCtL+Xe9ZOLLkN1sAT39F40LXUTGNo4=;
 b=yRjzGXJgQrPpAwx3tcXdfVt5Dm3pBPxKZTMsPn4vhlYlLQ1MrgUGA/G+ZtJ4j3AlGP
 YNg6Om+f5yvibc/Mnpcw6tBdhO1ccmLRHoVAXu5ZqHkSijnF3Zkeh7I4KfdEDmZWW55N
 NPz2+P3S8xwP07yOUsRTqzSba4FQ4Jv1eGour8xRasSMNCSlGn3a5aj06C8CJHi8Aqo+
 b/xa/M71dQYsqjrFSWNjiPfxZrBH8op6gN541vSCsNt3aNZDWRqPVfRmWdEf1NJjEmGw
 6vGyC1Bv3Frk5F1w8EXG5NBTT6kjj/hWgMFWZooQsrAQYrPeNGGX+zdDucL8VJhtPqmE
 quEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700677851; x=1701282651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Rm3lhCAuFgUPCtL+Xe9ZOLLkN1sAT39F40LXUTGNo4=;
 b=Py9FHaqnmpw11iXxmH2BETRzLgEAVB+ODmwnAWi4uJ5FOonKyh9GEuqqzZC09tdFx+
 CL2DHTnb7ofgBdIXE18oUgXJEC+tbkaEcrb3tBYscsYDZoOc9btG2RQ6Mv3d/LN3I0aQ
 sDBOME8GqepQKAxLMJvl+JW0JiJnr1AfVJyZWR5oiXugim7bxe7VZ3FhjucIB9WIMdop
 fFs4ZrUj20PcFwSCHXDt12Kbnu5aQvcWL+/Hvkb+uPauEdvjsdFClCqR0DfQwg/Mw7SX
 /JOI8CXGF23P1QS8+2/p6dbjYgYhDAq5LlLMdDreHmOteDU5cochrGawGCu5H8GUj+EL
 RhhQ==
X-Gm-Message-State: AOJu0YxuF7si06N138D31eFFmVOVjcxUDMGWgMESwFSmDG7W99z8shL/
 Rvf6b8h1ll7lpqFX9R70sa9Lb8YTmtd7lwEDkug=
X-Google-Smtp-Source: AGHT+IH+tL0hU8gQDSVNB5v+pU6ETjVTOoKxW+cgstXcmqk4L76ZnmaXyVW8119Q66gSwqjlItDtQg==
X-Received: by 2002:a5d:510c:0:b0:32f:a48f:3658 with SMTP id
 s12-20020a5d510c000000b0032fa48f3658mr1676083wrt.69.1700677850865; 
 Wed, 22 Nov 2023 10:30:50 -0800 (PST)
Received: from m1x-phil.lan (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 f5-20020a5d64c5000000b00332ce0d7300sm41010wri.92.2023.11.22.10.30.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Nov 2023 10:30:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH-for-9.0 00/11] hw/arm: Step toward building qemu-system-{arm,
 aarch64} altogether
Date: Wed, 22 Nov 2023 19:30:36 +0100
Message-ID: <20231122183048.17150-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Hi,

This series is a step toward having a single qemu-system-aarch64
binary for both ARM and Aarch64 variants.

First we add the TypeInfo::can_register() handler to QOM, to be
able to decide at runtime if a type can be registered. We'll
later use the target_aarch64_available() method to restrict some
QOM types to the aarch64 build.

Then few cleanups allow us to build the Raspi machines and its
components as target-agnostic. To do that, instead of embedding
a CPUState in its SoC container, we use a pointer to it. Since
the type is forward-declared by "cpu-qom.h", we can use that in
our hw/ headers. Then the correct CPU is instanciated by calling
object_new() instead of object_initialize_child().

Finally objects are moved to meson system_ss[] source set to be
built once.

Does that look reasonable to keep merging TARGET_ARM/AARCH64?

Thanks,

Phil.

Philippe Mathieu-Daudé (11):
  qom: Introduce the TypeInfo::can_register() handler
  target/arm: Add target_aarch64_available() helper
  target/arm: Declare ARM_CPU_TYPE_NAME/SUFFIX in 'cpu-qom.h'
  target/arm: Move ARM_CPU_IRQ/FIQ definitions to 'cpu-qom.h'
  target/arm: Move GTIMER definitions to 'cpu-defs.h'
  hw/arm/bcm2836: Simplify use of 'reset-cbar' property
  hw/arm/bcm2836: Simplify access to 'start-powered-off' property
  hw/arm/bcm2836: Use ARM_CPU 'mp-affinity' property
  hw/arm/bcm2836: Allocate ARM CPU state with object_new()
  hw/arm/raspi: Build bcm2836.o and raspi.o objects once
  hw/intc/meson: Simplify how arm_gicv3_kvm.o objects are built

 include/hw/arm/bcm2836.h    |  4 ++--
 include/qom/object.h        |  4 ++++
 target/arm/cpu-defs.h       | 19 ++++++++++++++++
 target/arm/cpu-qom.h        | 11 ++++++++++
 target/arm/cpu.h            | 16 +-------------
 hw/arm/bcm2836.c            | 43 ++++++++++++++++---------------------
 hw/arm/raspi.c              |  8 +++----
 hw/intc/arm_gicv3_its_kvm.c |  1 +
 hw/intc/arm_gicv3_kvm.c     |  1 +
 qom/object.c                |  3 +++
 target/arm/cpu.c            |  9 ++++++++
 hw/arm/meson.build          |  6 ++++--
 hw/intc/meson.build         |  6 ++++--
 13 files changed, 80 insertions(+), 51 deletions(-)
 create mode 100644 target/arm/cpu-defs.h

-- 
2.41.0


