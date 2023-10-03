Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B5D7B640E
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:29:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnakt-0005P2-Ev; Tue, 03 Oct 2023 04:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnakq-0005Nc-6i
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:27:44 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnakg-0007yN-Q9
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:27:40 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50325ce89e9so784955e87.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696321652; x=1696926452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cvFSizht0QLR7BE5OEcX79gZpgM6xlScGli2YAzjrJs=;
 b=VSRX8MNu48odErvx6zUCzlzyekh8zayZEhauj7mUNwryddeQwHRobN1ooAlg+t9aHF
 Qt7VBwrtTX+jr7g6FzQVcQ9JP6Zbfb8KamXnh0gzuD6c7zGt7qHLA7h8hmHPamH806G6
 u0IcYXE0S4v9SrHXnc7NR06375bZBX/R19xMkaGN/smmF+ZWvMK8m/kpngXEh8BwY9Yd
 XqfB+r67tOJLWjtn49EcfFJ/+Ns1AzrBEeoEIuO97hx6DUgGJ15MHqGkJbR1hipI1SxF
 Jg23iBAuNo/gZKy6kW/Vyw0U4mN1NzMFbRkFOwBGGMDUSQ9V29ip19BFScufOVKguZeq
 JQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321652; x=1696926452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cvFSizht0QLR7BE5OEcX79gZpgM6xlScGli2YAzjrJs=;
 b=xSiaV0bxLMKxKUeeYIZsP0Ydxe8umzE8Ei6LFIsusbYyEXLzQlu6v5mfjARZhG5knb
 EjFS7fJFfq5adXIzbmJ+j5l4q4S+QmEH9UrT8mT2byOsrOXLXoHIAseLW31/5P/Uc5+X
 vdIRRN5KOGTioyllTJ1KGpKtZ2VtzMgsCBKoaUMm4ftZZkZuPI4+qRL2qGwk/8Fb3+39
 hXWkx4s3aeTSuIkSlb5AmEcf31XD26+/ckV01BOZAYCxzzJaVuabP7VvYWUGDU7kIafH
 ttpegJRq9AFUs3Ry9iOSvW7RboGE0pzRZ3ETiqQTko4+49ZmxeSZbdswtR6GOZTEZsPg
 9MjQ==
X-Gm-Message-State: AOJu0YyBtEB5cDZgS9mPRzx9fw9VxL9lmOs2ROt6QcCj8YbwCebgCcyb
 dqo5MYA0riN91J/8PcASZxJheY2hM3a6goGyOu3e3A==
X-Google-Smtp-Source: AGHT+IFvtrUXc1X6JWRX7/alshk/gJA00dOArQggtLzzY14KPGT7P/JsyD7DeiZBXVF9J7ANXHWFHg==
X-Received: by 2002:a05:6512:1248:b0:502:b1b9:88c5 with SMTP id
 fb8-20020a056512124800b00502b1b988c5mr12371665lfb.26.1696321652065; 
 Tue, 03 Oct 2023 01:27:32 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-246.abo.bbox.fr. [176.131.222.246])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a05600c040c00b003fc06169ab3sm8881284wmb.20.2023.10.03.01.27.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Oct 2023 01:27:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/5] hw/intc/apic: QOM cleanup
Date: Tue,  3 Oct 2023 10:27:23 +0200
Message-ID: <20231003082728.83496-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

Since v1:
- Dropped change in x86_cpu_realizefn (rth)
- Simplify kvm_apic_realize() error propagation

Minor cleanup extracted from a bigger series
touching x86_cpu_realizefn().

Philippe Mathieu-Daudé (5):
  hw/intc/apic: Use ERRP_GUARD() in apic_common_realize()
  hw/i386/apic: Defer error check from apic_get_class to
    kvm_apic_realize
  hw/i386/apic: Simplify apic_get_class()
  hw/intc/apic: Rename x86_cpu_apic_create() -> x86_cpu_apic_new()
  hw/intc/apic: Pass CPU using QOM link property

 include/hw/i386/apic_internal.h |  2 +-
 target/i386/cpu-internal.h      |  2 +-
 hw/i386/amd_iommu.c             |  2 +-
 hw/i386/intel_iommu.c           |  4 ++--
 hw/i386/kvm/apic.c              |  5 +++++
 hw/intc/apic_common.c           |  8 +++++++-
 target/i386/cpu-sysemu.c        | 23 +++++++----------------
 target/i386/cpu.c               |  5 +----
 8 files changed, 25 insertions(+), 26 deletions(-)

-- 
2.41.0


