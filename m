Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97824AD1576
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Jun 2025 01:09:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOP7t-0005sy-87; Sun, 08 Jun 2025 19:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOP7q-0005s0-Uk
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 19:08:26 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOP7p-0004bX-CS
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 19:08:26 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-235e1d4cba0so28170835ad.2
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 16:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749424103; x=1750028903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=anxdGYAh9P5pxX9FDRYYldaUksaveAPv91lOuOStVyA=;
 b=lfv8jt2b0bbW1XfOmxF1dEwrQJB0pNxgH0yQD3ONJ1vPPOMs66Y+g3BQPcCtG1RYyU
 7Ofm81Jfo6xLIT6doTdvTvBQnFlf4d5AdYVKy9miswFd3rCiTbRZuZrkbVLleMd7yuGG
 JEACAqF5a131mNq7iclDT+je+uguTOJ2/UL6DQgoth4y7MANrEASHvuLJfuvCqDYjuEW
 gcDtr6sUDulHnprQGKivRZqAysvwx6zP5yVfsesUQqG+Bv0UPrYxiiuuEZgYO7enJpfe
 hWBeAzhROhcdu7VC9SgG/sjRYP7LrMDJ2GIOiBmKb+0aHH/+27soazGMXRS+3kfaJhvP
 1ClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749424103; x=1750028903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=anxdGYAh9P5pxX9FDRYYldaUksaveAPv91lOuOStVyA=;
 b=RP0i81fZeVgUT7u1nAJMJE/t+p1IP6BDYiIbG7Q7ixJe+EkJapj9/DIIXZ2/+GuBv2
 KoKFr9WH9eN/evHMNcZg9HKkXCRelooH5H+jbCbpFmtE9YwNC09wHP871IIZduB2L7pP
 WkJh9YuoOGacvGuecTo0NrjzHe60Oh1Tm9iZxU6ySCjBVam68Am+qDpKSL3BJTZ0/1Ve
 1NRoBvlOz09XLPwBSG0BpKqfizzap36vr2k3LIlWw7xYl3UKGXv7gMqbHVg4GSUennGE
 67SbghX6u0BaPswVTq2uWhC3Hgse0HEtOkkFex8az+Eq2T7AP11cLkBJsTIQ4A2vJtNw
 hBBw==
X-Gm-Message-State: AOJu0Yxh46S6KMXcJ1qBZfq4jRzpYYLDFwzPmMiVxYSxrzgPA8jqFep1
 Mg4pzBX///60PGKgLD6Z2cW4cUAEfSRNjZmGn4cFeMUTccoRMFVSsS5AeXKww+whA3c=
X-Gm-Gg: ASbGnctgWMwFvVAx/13W2N//ywI+fkxyEzWwvm4K6L61awVPDhSQhLwBmuQ1co5rHHr
 whA7i+/B/ZNwrBwcS1HV0KBUSlpzkW8BRKeCsc9Zy2fP6ZoUrCra0Qjxb1CeJCyqc7ZfEACDjwF
 Los9/rQYD1jaJfsMPE1WzQsKroufQTnFihX0Y7c1cBZFgGs/xMrP55jPJFXRq0280IKF5rWASUp
 sLYtwP8F+1F5WPvu2PcJwpS0GrT8MeeQIw1peKrISwE+eMPNC3CaZo6WeJj/KJNTBsA7dfo2kM0
 Bb9l0lNK7zQZx2YhjsKKHzx6VZj4PZ9acIiWI2FxbVzdEo6sHeA=
X-Google-Smtp-Source: AGHT+IHx6nJILv6tkd8VgxQRQwToqd6DPiPSn2nRx+wSLDD/NUTAv7ioMcxHCQ298hJWo8KhNH73YA==
X-Received: by 2002:a17:902:e890:b0:235:e71e:a37b with SMTP id
 d9443c01a7336-23601d973ccmr161064635ad.34.1749424103491; 
 Sun, 08 Jun 2025 16:08:23 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603504f09sm43421325ad.223.2025.06.08.16.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 16:08:23 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH v9 4/9] plugins: Add memory virtual address write API
Date: Sun,  8 Jun 2025 16:08:14 -0700
Message-ID: <20250608230819.3382527-5-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608230819.3382527-1-rowanbhart@gmail.com>
References: <20250608230819.3382527-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: novafacing <rowanbhart@gmail.com>

This patch adds functions to the plugins API to allow reading and
writing memory via virtual addresses. These functions only permit doing
so on the current CPU, because there is no way to ensure consistency if
plugins are allowed to read or write to other CPUs that aren't currently
in the context of the plugin.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 21 +++++++++++++++++++++
 plugins/api.c              | 18 ++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 120fb626a6..8ae7758b95 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -948,6 +948,27 @@ QEMU_PLUGIN_API
 bool qemu_plugin_read_memory_vaddr(uint64_t addr,
                                    GByteArray *data, size_t len);
 
+/**
+ * qemu_plugin_write_memory_vaddr() - write to memory using a virtual address
+ *
+ * @addr: A virtual address to write to
+ * @data: A byte array containing the data to write
+ *
+ * The contents of @data will be written to memory starting at the virtual
+ * address @addr.
+ *
+ * This function does not guarantee consistency of writes, nor does it ensure
+ * that pending writes are flushed either before or after the write takes place,
+ * so callers should take care to only call this function in vCPU context (i.e.
+ * in callbacks) and avoid depending on the existence of data written using this
+ * function which may be overwritten afterward.
+ *
+ * Returns true on success and false on failure.
+ */
+QEMU_PLUGIN_API
+bool qemu_plugin_write_memory_vaddr(uint64_t addr,
+                                   GByteArray *data);
+
 /**
  * qemu_plugin_scoreboard_new() - alloc a new scoreboard
  *
diff --git a/plugins/api.c b/plugins/api.c
index 3f04399c26..1f64a9ea64 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -476,6 +476,24 @@ bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
     return true;
 }
 
+bool qemu_plugin_write_memory_vaddr(uint64_t addr, GByteArray *data)
+{
+    g_assert(current_cpu);
+
+    if (data->len == 0) {
+        return false;
+    }
+
+    int result = cpu_memory_rw_debug(current_cpu, addr, data->data,
+                                     data->len, true);
+
+    if (result < 0) {
+        return false;
+    }
+
+    return true;
+}
+
 struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)
 {
     return plugin_scoreboard_new(element_size);
-- 
2.49.0


