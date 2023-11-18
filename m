Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8A97F01EE
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 19:27:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4Q1T-0007su-HP; Sat, 18 Nov 2023 13:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r4Q1R-0007sb-DQ; Sat, 18 Nov 2023 13:26:25 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r4Q1P-0005T8-TQ; Sat, 18 Nov 2023 13:26:25 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5bd85b1939aso1917446a12.2; 
 Sat, 18 Nov 2023 10:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700331981; x=1700936781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yp6QoVwJvjvNngNM4cZnjf0zeYba0gsZwUeMxVOgmHw=;
 b=GcNEieGpj9uO4hbYcjzygwILWH1apo71aclQPOXzLlMsIDuLCJ6JJK8JyFapr/7MHg
 Vt2YX+CUhydQfWt6fCHmf1TGDU7CJeHu9VM+i92dOQvO+0JH1urdns9QaDZG12YaYm1o
 G8OhbCyFwU/d4GaTUz5FKlPmo6SsDbGn0Bj57XXcK8hLG8o8toTkVTGNPit8o8owSPZb
 E250uN6ZNoC4Il3SadTEPyZUAXaj+BmfSYJI/x2Dm3Pfm0ac2pB8X4UnnAcbg35hCIUQ
 XBZMOxX+jf6uBJ02AXDanXpyJ07HM7gdb7C/BcdpZk7rjr09ivev4ZZv2SIkoTt5v7cL
 Mjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700331981; x=1700936781;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yp6QoVwJvjvNngNM4cZnjf0zeYba0gsZwUeMxVOgmHw=;
 b=g4pWO2I7A68R32bCJq/eXIHC8va47yHHrdPXCoEGEhjQ/DGQ0KcDlV8oeZhi+o6N6R
 ouDGeID+x7DWjQ2OcV2SG5QqC9hFfYLC5ccNz5xzGw31EwiyF2y55eqbAkfi5QXHdn49
 U550mjI9lWxw1grofVFL6lNyZ5G+fIXWu1AaUZklFX5PwjMG6o+9/XPYa2s4RW5IMLxh
 xlXzoo71H1k85L9fpuLvvINkCO8ZCcODceK36S2h/J4cfYYu40+jeCYz7ArDh6ZSLtxB
 gBXIGbklRVhmPF+vPnFhlD7XrsSPbR14v5J1h21lHmrAnHlREyOOXjjrKr61OggOMivf
 3iPQ==
X-Gm-Message-State: AOJu0Yzm8Skdy6GmG/dF+cZGJhlqKF/+iZo/4hSWTXzq662gKqq/HDFZ
 yyDQ34qoZBtfVNi5VSwd7THSj2B1hkY8kw==
X-Google-Smtp-Source: AGHT+IHgJ0H4mFlsQWSO6ediiYDFLAJERiIy9xWatUjUDy/uq5zsOOo6MdfL280dsnkC5y91PVMHpQ==
X-Received: by 2002:a17:90b:1e07:b0:280:767:d3eb with SMTP id
 pg7-20020a17090b1e0700b002800767d3ebmr2603158pjb.30.1700331981205; 
 Sat, 18 Nov 2023 10:26:21 -0800 (PST)
Received: from dhoffman-NUC13RNGi9.hsd1.or.comcast.net
 ([2601:1c0:577f:e480:7761:abec:4d36:7df4])
 by smtp.gmail.com with ESMTPSA id
 27-20020a17090a001b00b00268b439a0cbsm3507932pja.23.2023.11.18.10.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 10:26:20 -0800 (PST)
From: Daniel Hoffman <dhoff749@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Daniel Hoffman <dhoff749@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH] hw/i386: fix short-circuit logic with non-optimizing builds
Date: Sat, 18 Nov 2023 10:25:31 -0800
Message-Id: <20231118182531.2619772-1-dhoff749@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=dhoff749@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

`kvm_enabled()` is compiled down to `0` and short-circuit logic is
used to remmove references to undefined symbols at the compile stage.
Some build configurations with some compilers don't attempt to
simplify this logic down in some cases (the pattern appears to be
that the literal false must be the first term) and this was causing
some builds to emit references to undefined symbols.

Signed-off-by: Daniel Hoffman <dhoff749@gmail.com>
---
 hw/i386/x86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index b3d054889bb..d339c8f3ef8 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -132,7 +132,7 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
      * Can we support APIC ID 255 or higher?  With KVM, that requires
      * both in-kernel lapic and X2APIC userspace API.
      */
-    if (x86ms->apic_id_limit > 255 && kvm_enabled() &&
+    if (kvm_enabled() && x86ms->apic_id_limit > 255 &&
         (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {
         error_report("current -smp configuration requires kernel "
                      "irqchip and X2APIC API support.");
@@ -418,8 +418,8 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
     }
     cpu->thread_id = topo_ids.smt_id;
 
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
-        kvm_enabled() && !kvm_hv_vpindex_settable()) {
+    if (kvm_enabled() && hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
+        !kvm_hv_vpindex_settable()) {
         error_setg(errp, "kernel doesn't allow setting HyperV VP_INDEX");
         return;
     }
-- 
2.40.1


