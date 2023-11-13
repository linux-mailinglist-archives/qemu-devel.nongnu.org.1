Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3319B7E9FE3
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 16:23:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Yl3-0001kR-EJ; Mon, 13 Nov 2023 10:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2Yl1-0001jo-4s
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:21:47 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2Yky-0003FQ-6O
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:21:46 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso672058666b.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 07:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699888902; x=1700493702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YAZk+3Dse8rl86kxKUGHVuPZUfUpHgJaPljFBSi46HI=;
 b=RdBB9d80NsuplF3O4FRWUwGG37hhXYwnJ2wTtvcb/AJLDFEBRrg7YfqPYEdhKvuZ5r
 B95yaG52h1fyubvsgr3l/K4Zi+HHMbNRWZzESBZCG9Ers6v9ZqoB1IDdsFPho9LYNmy5
 6dLjVM3bbxidw3jXXWkzGKLDmNVQSAfRm9rTb0p7vyWgRi5YOnYXfj4+XecdzlBcSBUC
 a2ORPQioWWbv+ACwdhxC7Mz62ZJkj12lW7A1ZOe89c5aJAMPTx4Csmyb9FLpc6/UGksw
 qM+ISRqoB9cQRf6TElVqJjWYW6Bw3YNeTKexMfyTn5puktA/l6gq2ewNf4vs0qm/VPYc
 2Ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699888902; x=1700493702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YAZk+3Dse8rl86kxKUGHVuPZUfUpHgJaPljFBSi46HI=;
 b=wBFT0b3pnUhsMWlfOmZMGHNqhpfTCVMuI4eGOzQQbjhrSo02zfzY0t9nPeXpPAeoQ1
 +qEN/SP6sD3SthYgnjonUg3EuQO55rtLPgK+lM1KKiaSDl7hi/1fiambw/ZUwCFB+z87
 TOjp7v+ypuJYH4Ol4x0hHO0w4tHANeF9sm+uy/AwnhfzgW2drewtPvseufhr/NPrHctW
 CkVYZ1SNxYle69hRUK6ML609Dsk3EpBOrz+GcP9+Gk8HmhmWeL8GO9gipagdIRJBLqwZ
 KCFuF8NWbSBtrNCldumF66qT83niPBPRW8SdBh2Dp8mmWBCy4dlacNr4y1BeextFSyts
 IsUg==
X-Gm-Message-State: AOJu0Yw0zj6Cn79GfMCTzrYojYVfBYBOPtjzl8GUmAHc23L4jsFuBCG3
 aRoJNlkWLxCQDCPdpHqqRK83iA==
X-Google-Smtp-Source: AGHT+IGj6dXGN5MguahUCcbomoo2q2R5bpml51YnyeqNpSNRHHGNbaVXW8b4IH/nqJe1/joi6MIM1w==
X-Received: by 2002:a17:906:84c:b0:9ae:6da8:1819 with SMTP id
 f12-20020a170906084c00b009ae6da81819mr4194118ejd.48.1699888902783; 
 Mon, 13 Nov 2023 07:21:42 -0800 (PST)
Received: from m1x-phil.lan ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 d17-20020a17090648d100b009e6cedc8bf5sm4165051ejt.29.2023.11.13.07.21.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 07:21:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH-for-9.0 04/10] hw/xen: Factor xen_arch_align_ioreq_data() out
 of handle_ioreq()
Date: Mon, 13 Nov 2023 16:21:07 +0100
Message-ID: <20231113152114.47916-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113152114.47916-1-philmd@linaro.org>
References: <20231113152114.47916-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

Per commit f17068c1c7 ("xen-hvm: reorganize xen-hvm and move common
function to xen-hvm-common"), handle_ioreq() is expected to be
target-agnostic. However it uses 'target_ulong', which is a target
specific definition.

In order to compile this file once for all targets, factor the
target-specific code out of handle_ioreq() as a per-target handler
called xen_arch_align_ioreq_data().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Should we have a 'unsigned qemu_target_long_bits();' helper
such qemu_target_page_foo() API and target_words_bigendian()?
---
 include/hw/xen/xen-hvm-common.h | 1 +
 hw/arm/xen_arm.c                | 8 ++++++++
 hw/i386/xen/xen-hvm.c           | 8 ++++++++
 hw/xen/xen-hvm-common.c         | 5 +----
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
index 27e938d268..734bfa3183 100644
--- a/include/hw/xen/xen-hvm-common.h
+++ b/include/hw/xen/xen-hvm-common.h
@@ -97,6 +97,7 @@ void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
 
 void cpu_ioreq_pio(ioreq_t *req);
 
+void xen_arch_align_ioreq_data(ioreq_t *req);
 void xen_arch_handle_ioreq(XenIOState *state, ioreq_t *req);
 void xen_arch_set_memory(XenIOState *state,
                          MemoryRegionSection *section,
diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 6a1d7719e9..c646fd70d0 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -128,6 +128,14 @@ static void xen_init_ram(MachineState *machine)
     }
 }
 
+void xen_arch_align_ioreq_data(ioreq_t *req)
+{
+    if (!req->data_is_ptr && (req->dir == IOREQ_WRITE)
+            && (req->size < sizeof(target_ulong))) {
+        req->data &= ((target_ulong) 1 << (8 * req->size)) - 1;
+    }
+}
+
 void xen_arch_handle_ioreq(XenIOState *state, ioreq_t *req)
 {
     hw_error("Invalid ioreq type 0x%x\n", req->type);
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index f8a195270a..aff5c5b81d 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -699,6 +699,14 @@ void xen_arch_set_memory(XenIOState *state, MemoryRegionSection *section,
     }
 }
 
+void xen_arch_align_ioreq_data(ioreq_t *req)
+{
+    if (!req->data_is_ptr && (req->dir == IOREQ_WRITE)
+            && (req->size < sizeof(target_ulong))) {
+        req->data &= ((target_ulong) 1 << (8 * req->size)) - 1;
+    }
+}
+
 void xen_arch_handle_ioreq(XenIOState *state, ioreq_t *req)
 {
     switch (req->type) {
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index c028c1b541..03f9417e7e 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -426,10 +426,7 @@ static void handle_ioreq(XenIOState *state, ioreq_t *req)
     trace_handle_ioreq(req, req->type, req->dir, req->df, req->data_is_ptr,
                        req->addr, req->data, req->count, req->size);
 
-    if (!req->data_is_ptr && (req->dir == IOREQ_WRITE) &&
-            (req->size < sizeof (target_ulong))) {
-        req->data &= ((target_ulong) 1 << (8 * req->size)) - 1;
-    }
+    xen_arch_align_ioreq_data(req);
 
     if (req->dir == IOREQ_WRITE)
         trace_handle_ioreq_write(req, req->type, req->df, req->data_is_ptr,
-- 
2.41.0


