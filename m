Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BF779E3C5
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 11:31:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgMCS-0000xF-QG; Wed, 13 Sep 2023 05:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgMCQ-0000vm-P5
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:30:18 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgMCN-000298-46
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:30:17 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40037db2fe7so70553355e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 02:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694597413; x=1695202213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4qxkgGgN7faOXKmv92A0D3/Cys8KYdliP7Nf1fMSPZI=;
 b=Y+LgBKVJXhos+1tCs+rqTLVmP7MY+O/Kl6nlc6hRECX2muAAE5nT4w3UpknQClmX2+
 brVqdbx1PIDVbtAomIslZ4ZGoCtEfKfiseuga0EkWbNjW4/i97SaU8qkv6tG6pUj7q99
 BVJ8Q6wT3xC29YSTGkMP9cuAZbjuyvJxgxnCprVbb+KqDb/xZUfe94g5StVcxPZEqApT
 NwK4J37EeMBmnA9yZXZyiLE+x8DCALIjAsT+wAAg39bqXXWSlR+JO55FccwicuSwP41A
 W7uUWqj8c6NQ5eOsmWXrp1LXFhkOl+A2ljHfmwtjMYuUJjbWyB/nhULEEmNlHAFdaeI5
 Xuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694597413; x=1695202213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4qxkgGgN7faOXKmv92A0D3/Cys8KYdliP7Nf1fMSPZI=;
 b=KNts2wX1Njt2HFPF/yrntxkactd2Xp/yqXXHiFmlTQEdGnSipNNV3VOIgVhOygKiXI
 pMbdW3GQPbxaMLy24/bMqOtEwRJwf7ynJVhjfakMZGtRPz7deaHD6oBduKAfZFRWCK8Y
 kEBHfqbzzxuJvoms0OskASASGR74gOXd26S8pjj/S75mtYcSsvgWQ4d5JkYivmCv1cyC
 Sj40RwdLqANt1VE6YGwRdxXaNEw4sAtLxYkRTuWgSR2ROTLiFYBczdXaBwmyTlVN8XzE
 mlg7GdY883Ahz49bF7nVvKv2VTYEC3P6pLloaTGxKlWVW9gmTX3WWiAv3y6M9QjQuRh7
 q0Ww==
X-Gm-Message-State: AOJu0YxCw1QPvD9DgoL4g2Q6waf2FiGKILnwQ4C3qk/iCHzf9op2MY+Q
 7AgFcAxWidaswd8T6tnu2QWPQfc2M3QEiGMParM=
X-Google-Smtp-Source: AGHT+IFdvAnXbnEFzecAcazXAeZzxQQvSu94Se4MZ8q+TyFfDDe+tqUEFZwkuPCkYwiCViDvQH4sIw==
X-Received: by 2002:a05:600c:2804:b0:401:c1e2:f754 with SMTP id
 m4-20020a05600c280400b00401c1e2f754mr1572952wmb.21.1694597412975; 
 Wed, 13 Sep 2023 02:30:12 -0700 (PDT)
Received: from m1x-phil.lan (176-131-211-241.abo.bbox.fr. [176.131.211.241])
 by smtp.gmail.com with ESMTPSA id
 n12-20020a05600c294c00b003ff3b964a9asm1480345wmd.39.2023.09.13.02.30.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Sep 2023 02:30:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 0/6] target/i386: Restrict system-specific features from
 user emulation
Date: Wed, 13 Sep 2023 11:30:02 +0200
Message-ID: <20230913093009.83520-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Since v4:
- Addressed Paolo's suggestions (clearly better)

Too many system-specific code (and in particular KVM related)
is pulled in user-only build. This led to adding unjustified
stubs as kludge to unagressive linker non-optimizations.

This series restrict x86 system-specific features to sysemu,
so we don't require any stub, and remove all x86 KVM declarations
from user emulation code (to trigger compile failure instead of
link one).

Philippe Mathieu-Daudé (6):
  target/i386: Check kvm_hyperv_expand_features() return value
  target/i386: Drop accel_uses_host_cpuid before
    x86_cpu_get_supported_cpuid
  target/i386: Call accel-agnostic x86_cpu_get_supported_cpuid()
  target/i386: Move x86_cpu_get_migratable_flags() around
  RFC target/i386: Restrict system-specific code from user emulation
  target/i386: Prohibit target specific KVM prototypes on user emulation

 target/i386/kvm/kvm_i386.h |   4 ++
 target/i386/cpu.c          | 134 +++++++++++++++++++++++--------------
 2 files changed, 88 insertions(+), 50 deletions(-)

-- 
2.41.0


