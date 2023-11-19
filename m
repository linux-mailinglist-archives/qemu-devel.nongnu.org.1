Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB8E7F08AF
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 20:55:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4nra-00064R-1J; Sun, 19 Nov 2023 14:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r4nrY-00063u-64; Sun, 19 Nov 2023 14:53:48 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r4nrT-0006eY-7w; Sun, 19 Nov 2023 14:53:47 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso3860986b3a.3; 
 Sun, 19 Nov 2023 11:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700423621; x=1701028421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yF/YSICfnS5SJ5tgupAl5YZLHrs4+ZuZENJUujXwq+U=;
 b=SFjm6+KCehU9TaaA0wzjrhwN3hTbuq1GEC49CjAMBQGa0/OwvNx6P1Gz5+YQkZ3BqG
 GtFRYfB2poT8Vro5GmzYvjWFC3tN4PBGYQs899qzfVU1uLr9oN4vTdXt9gS906ODAvYW
 gVgCJOtBFvtB1Q7KqZvTe+sHLLTGxis1yJn8QojSHmISTWbYszvQbM9JKSDCAR0Eikm+
 oHTrZaJeciYaC+zHnKKaKpGrabxmF/PSc0sdVxoLTu/5QV7peQlmuwvw3V6RWF+wHVVM
 wECYdzxaP4p1OSB32uhYLMjK0AUrGWMUjIhnYSE/ri5YUzVwp2OfA3dTdZhTk+hml0Fe
 B6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700423621; x=1701028421;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yF/YSICfnS5SJ5tgupAl5YZLHrs4+ZuZENJUujXwq+U=;
 b=sQF/XYoo2LVxKx9VCl4l94bB6f+d6AlLhtcTGcebLZ1MwcvFlL9lafmHdCdQGwmSLJ
 U5qJd6eT19g9GIcb85ffEvDFywyjhng4I75eM70qJsY/pmiBJ+DnEAnbAFT2ca5gHVE1
 HmzCB/6ZM4t5sjfObFrMcnQYw6t2XvP9vTXXG+AZwONwCU2mhVEsB18jZLyVF05eIf9K
 r6zG2tbh1fMQteXeSTpi3YOn4zTAF/PDpY8P1M06Czjce3kDn+6BrxVVijflD29zKz0v
 RnUhPFdeyinFabNLCg2igW5ehjVSvdDPLYxykslssEfktlz6yZa9kFyINiJ6TLQh33gX
 XqsQ==
X-Gm-Message-State: AOJu0YwygQXIUzxpsHmGds8Dsb9A712nz9p5euGtUwx11uGIz3MvqX2t
 VXUTiXctOd0p2WG9s7UWMuIiORPfOlB9Ag==
X-Google-Smtp-Source: AGHT+IHKy72t+aLjdps1oRuFcsZoUjIJVEP3rO1qnhqhIs606fu/nSX/ajg+e6is6dSbquTLhNhxJA==
X-Received: by 2002:a05:6a20:a127:b0:187:b16f:e779 with SMTP id
 q39-20020a056a20a12700b00187b16fe779mr7637289pzk.5.1700423620643; 
 Sun, 19 Nov 2023 11:53:40 -0800 (PST)
Received: from dhoffman-NUC13RNGi9.hsd1.or.comcast.net
 ([2601:1c0:577f:e480:4205:be47:7a48:528a])
 by smtp.gmail.com with ESMTPSA id
 k12-20020a63d10c000000b005b18c53d73csm4761841pgg.16.2023.11.19.11.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 11:53:40 -0800 (PST)
From: Daniel Hoffman <dhoff749@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Daniel Hoffman <dhoff749@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2] hw/i386: fix short-circuit logic with non-optimizing builds
Date: Sun, 19 Nov 2023 11:53:01 -0800
Message-Id: <20231119195301.2997391-1-dhoff749@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dhoff749@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

`kvm_enabled()` is compiled down to `0` and short-circuit logic is
used to remmove references to undefined symbols at the compile stage.
Some build configurations with some compilers don't attempt to
simplify this logic down in some cases (the pattern appears to be
that the literal false must be the first term) and this was causing
some builds to emit references to undefined symbols.

Signed-off-by: Daniel Hoffman <dhoff749@gmail.com>
---
 hw/i386/x86.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index b3d054889bb..2b6291ad8d5 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -131,8 +131,12 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
     /*
      * Can we support APIC ID 255 or higher?  With KVM, that requires
      * both in-kernel lapic and X2APIC userspace API.
+     *
+     * kvm_enabled() must go first to ensure that kvm_* references are
+     * not emitted for the linker to consume (kvm_enabled() is
+     * a literal `0` in configurations where kvm_* aren't defined)
      */
-    if (x86ms->apic_id_limit > 255 && kvm_enabled() &&
+    if (kvm_enabled() && x86ms->apic_id_limit > 255 &&
         (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {
         error_report("current -smp configuration requires kernel "
                      "irqchip and X2APIC API support.");
@@ -418,8 +422,13 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
     }
     cpu->thread_id = topo_ids.smt_id;
 
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
-        kvm_enabled() && !kvm_hv_vpindex_settable()) {
+    /*
+    * kvm_enabled() must go first to ensure that kvm_* references are
+    * not emitted for the linker to consume (kvm_enabled() is
+    * a literal `0` in configurations where kvm_* aren't defined)
+    */
+    if (kvm_enabled() && hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
+        !kvm_hv_vpindex_settable()) {
         error_setg(errp, "kernel doesn't allow setting HyperV VP_INDEX");
         return;
     }
-- 
2.40.1


