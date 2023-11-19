Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ACE7F08D9
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 21:32:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4oSA-0005zU-88; Sun, 19 Nov 2023 15:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r4oS8-0005zG-CX; Sun, 19 Nov 2023 15:31:36 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r4oS6-0006Rp-Q5; Sun, 19 Nov 2023 15:31:36 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6c32a20d5dbso3223159b3a.1; 
 Sun, 19 Nov 2023 12:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700425889; x=1701030689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P2z+01K5D4CNKE8bOorZ6eUGdv1QPS1SlbSND7ABtuw=;
 b=H5I9dOc9HfAs5i6vxtbS3FyIwb9WhvnONA+vR9bvJtlt2v5sQWayNLApJXzx7EYmmR
 5SDzokWm5Ldnq+8iH0QLHGCCEPU9uP9WttfReZ9hN7yirEhZXfYGbu4UdDB+61hWQ9CS
 LP0wKWuXEpwzibPx99dutHcukM1ekOGzZc1vV7I8d1lkqpt8I2U6W/+NcnUqNnuHh4vZ
 Zu2F/uJlMjJDwVFD5jxSGYYHuqXiOoV+QilRtwkA2eSfg/j9Hghz/K8cUIXPGgYuNEy9
 v4ID9maoytZ35zT6NNOlkvbxpxXGPxjckZ1I7uLVtF/wZYzJ3U6J/9ql59nX9h/Td91B
 KpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700425889; x=1701030689;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P2z+01K5D4CNKE8bOorZ6eUGdv1QPS1SlbSND7ABtuw=;
 b=oYiI0RpP/kW1by1UXqg71Saz+I6lhn5C8EgoctI7aztDuWpJp3r6uz98z0d1FvnsMn
 hj955B5C4ORijQJAzhUjAtFjl0iISsw0HEsFnzPOYXoJeddcSEg6hlS3fGxQ+9Hg3i8d
 acAohJtCIdexraCNYediRZA1leor/Hp+Gfp89uoOXkKWUsvxvd59QRiwg7e7wsqdjAHU
 32zL0tLHEoTqOM9P42XJqz1r/ZzGnhi/pus24ueqkDuKZUxLjJ37pyTGySRXwHyrcGHY
 e30oMTdDD7ZilhRYFQ4qW1VrK8n3a0C2DbOM5XvvfUDYVXWuDwfT8qIsKhVZoZEYrKpC
 Gutg==
X-Gm-Message-State: AOJu0YyeIPXwY9PyW1tRDD8/GDM/59kXQMBl+5xtmVzmZQ4v3+8GjZ32
 U0ZscJFCwpkuHsNczRYalE0lrDCcpaav2w==
X-Google-Smtp-Source: AGHT+IHRfZ3pjj9f4kX5f8EJzWv6HP1QJ5dHb78wUyC4+8jMcO27Kt1ZgLyDoz4Bp9+x0hywzRzelA==
X-Received: by 2002:a05:6a00:2410:b0:6bd:7cbd:15a2 with SMTP id
 z16-20020a056a00241000b006bd7cbd15a2mr4047612pfh.26.1700425889345; 
 Sun, 19 Nov 2023 12:31:29 -0800 (PST)
Received: from dhoffman-NUC13RNGi9.hsd1.or.comcast.net
 ([2601:1c0:577f:e480:4205:be47:7a48:528a])
 by smtp.gmail.com with ESMTPSA id
 fn19-20020a056a002fd300b006c5da6411b9sm4707428pfb.101.2023.11.19.12.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 12:31:29 -0800 (PST)
From: Daniel Hoffman <dhoff749@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Daniel Hoffman <dhoff749@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v3] hw/i386: fix short-circuit logic with non-optimizing builds
Date: Sun, 19 Nov 2023 12:31:16 -0800
Message-Id: <20231119203116.3027230-1-dhoff749@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=dhoff749@gmail.com; helo=mail-pf1-x436.google.com
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
used to remove references to undefined symbols at the compile stage.
Some build configurations with some compilers don't attempt to
simplify this logic down in some cases (the pattern appears to be
that the literal false must be the first term) and this was causing
some builds to emit references to undefined symbols.

An example of such a configuration is clang 16.0.6 with the following
configure: ./configure --enable-debug --without-default-features
--target-list=x86_64-softmmu --enable-tcg-interpreter

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


