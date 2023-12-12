Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFBD80EC4D
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:43:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD1zo-0002Sn-36; Tue, 12 Dec 2023 07:36:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1za-0001jr-2t
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:36:07 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1zN-00085f-Cc
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:36:05 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-54c5ed26cf6so7251848a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 04:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702384552; x=1702989352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LKqz8+rrRr+9OnCGqaF5kY8vCRVBvOcgtedefIMaXhg=;
 b=IonMcDD8GhQ6pJqSAkb/nEnrvUBJk63z5LQINYdN9qYVneL975pvvNghLKHq9sg8dO
 xXEPizksj2nIzx4PIsV5tRBZRdyaVbKhcLZJr9LvL4G9mZNLOiJ+3v7o84drEoZ79Ge0
 qtC0Jh1Gu6apUJGQ1lhs5jD26VedMcKljERswgoR7qMlAK+7rF7OtX9h19iFLG2gFmp5
 2Fms/VigDuY05qMge/8GNnYsYBkoSq0bxiFUinBsg6eqZ5GTXwJMEpHlienN1+krOAu+
 lQv/szPA/cC6IzqG25Rs9LwIXMYpo7mpz2aBYcYOQKatAfTLX/c1AeFnPiBjMelfF4AG
 t/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702384552; x=1702989352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LKqz8+rrRr+9OnCGqaF5kY8vCRVBvOcgtedefIMaXhg=;
 b=w8jo83vPsCcQT/svnkkq2XeWqjdpttqGvBfTmTYq64+riUaJpCUQ4QSiKamylvCp+8
 5kmtXCZ8BP28QGF3mhpzeX8U/4XANmRdonPAogDk8WBIfbwiA35JCmCHzcKjoZb3GF3A
 ZdYIMB5BB5NRNTwF77rwDMeWwuhlUZ7OxZqb34DyNwBn98mUzhhcVETEbSPlmzwT9RFU
 nwfDptXhsYi46GBkGaUzrRaQtQFIGCG09zWGh4rEIhnkeJFqV4aH89xA4aqN+tdhoaHR
 QNohJMAN1GXP7SbtHxDnCjojL3pR+pKZLw19bkM/zKq4LpmiPt04duhj5jh7esbES4Q/
 hPhg==
X-Gm-Message-State: AOJu0Yy74f6U4Ddfcnf8oOjmOOkKwurw2M+ZkbghDyGv7/ZREd6T1iRw
 hOUJ8H18LlllKOP8zqUUpvz9ryNApZsxS5iqHP9lRA==
X-Google-Smtp-Source: AGHT+IGdDBxwOjO3s57fwqNR4JkxK+RE/jCphEdV6BIZvfrVWSyPEmapbhmFWj4HyfkEWxLwnIJvJQ==
X-Received: by 2002:a50:9515:0:b0:54c:6386:a1a3 with SMTP id
 u21-20020a509515000000b0054c6386a1a3mr3554851eda.15.1702384551619; 
 Tue, 12 Dec 2023 04:35:51 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a50cc48000000b0054c9df4317dsm4657860edi.7.2023.12.12.04.35.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 04:35:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Claudio Fontana <cfontana@suse.de>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, Brian Cain <bcain@quicinc.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v2 15/23] exec: Declare target_words_bigendian() in
 'exec/tswap.h'
Date: Tue, 12 Dec 2023 13:33:51 +0100
Message-ID: <20231212123401.37493-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212123401.37493-1-philmd@linaro.org>
References: <20231212123401.37493-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

We usually check target endianess before swapping values,
so target_words_bigendian() declaration makes sense in
"exec/tswap.h" with the target swapping helpers.

Remove "hw/core/cpu.h" when it was only included to get
the target_words_bigendian() declaration.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/tswap.h     | 12 +++++++++++-
 include/hw/core/cpu.h    | 11 -----------
 cpu-target.c             |  1 +
 disas/disas.c            |  1 +
 hw/audio/virtio-snd.c    |  2 +-
 hw/core/cpu-sysemu.c     |  2 +-
 hw/core/generic-loader.c |  2 +-
 hw/display/vga.c         |  2 +-
 hw/virtio/virtio.c       |  1 +
 9 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 68944a880b..77954bbc2b 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -8,9 +8,19 @@
 #ifndef TSWAP_H
 #define TSWAP_H
 
-#include "hw/core/cpu.h"
 #include "qemu/bswap.h"
 
+/**
+ * target_words_bigendian:
+ * Returns true if the (default) endianness of the target is big endian,
+ * false otherwise. Note that in target-specific code, you can use
+ * TARGET_BIG_ENDIAN directly instead. On the other hand, common
+ * code should normally never need to know about the endianness of the
+ * target, so please do *not* use this function unless you know very well
+ * what you are doing!
+ */
+bool target_words_bigendian(void);
+
 /*
  * If we're in target-specific code, we can hard-code the swapping
  * condition, otherwise we have to do (slower) run-time checks.
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 3208b938f7..d6b077da71 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1153,17 +1153,6 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
 void cpu_exec_reset_hold(CPUState *cpu);
 
-/**
- * target_words_bigendian:
- * Returns true if the (default) endianness of the target is big endian,
- * false otherwise. Note that in target-specific code, you can use
- * TARGET_BIG_ENDIAN directly instead. On the other hand, common
- * code should normally never need to know about the endianness of the
- * target, so please do *not* use this function unless you know very well
- * what you are doing!
- */
-bool target_words_bigendian(void);
-
 const char *target_name(void);
 
 void page_size_init(void);
diff --git a/cpu-target.c b/cpu-target.c
index 997ca2e846..4c1e19ca81 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -33,6 +33,7 @@
 #endif
 #include "sysemu/cpus.h"
 #include "sysemu/tcg.h"
+#include "exec/tswap.h"
 #include "exec/replay-core.h"
 #include "exec/cpu-common.h"
 #include "exec/exec-all.h"
diff --git a/disas/disas.c b/disas/disas.c
index 0d2d06c2ec..89a1e7d767 100644
--- a/disas/disas.c
+++ b/disas/disas.c
@@ -6,6 +6,7 @@
 #include "disas/disas.h"
 #include "disas/capstone.h"
 #include "hw/core/cpu.h"
+#include "exec/tswap.h"
 #include "exec/memory.h"
 
 /* Filled in by elfload.c.  Simplistic, but will do for now. */
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 137fa77a01..a80f23aa71 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -20,11 +20,11 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "include/qemu/lockable.h"
+#include "exec/tswap.h"
 #include "sysemu/runstate.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "hw/audio/virtio-snd.h"
-#include "hw/core/cpu.h"
 
 #define VIRTIO_SOUND_VM_VERSION 1
 #define VIRTIO_SOUND_JACK_DEFAULT 0
diff --git a/hw/core/cpu-sysemu.c b/hw/core/cpu-sysemu.c
index d0d6a910f9..2a9a2a4eb5 100644
--- a/hw/core/cpu-sysemu.c
+++ b/hw/core/cpu-sysemu.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/core/cpu.h"
+#include "exec/tswap.h"
 #include "hw/core/sysemu-cpu-ops.h"
 
 bool cpu_paging_enabled(const CPUState *cpu)
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index d4b5c501d8..ea8628b892 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -31,7 +31,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/core/cpu.h"
+#include "exec/tswap.h"
 #include "sysemu/dma.h"
 #include "sysemu/reset.h"
 #include "hw/boards.h"
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 37557c3442..d11a30a785 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -26,7 +26,7 @@
 #include "qemu/units.h"
 #include "sysemu/reset.h"
 #include "qapi/error.h"
-#include "hw/core/cpu.h"
+#include "exec/tswap.h"
 #include "hw/display/vga.h"
 #include "hw/i386/x86.h"
 #include "hw/pci/pci.h"
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 3a160f86ed..28dc1f4c15 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -20,6 +20,7 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
+#include "exec/tswap.h"
 #include "qom/object_interfaces.h"
 #include "hw/core/cpu.h"
 #include "hw/virtio/virtio.h"
-- 
2.41.0


