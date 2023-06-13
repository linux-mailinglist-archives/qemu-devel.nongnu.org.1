Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1AD72E1F6
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:47:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90V2-0005jd-Eg; Tue, 13 Jun 2023 05:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90V0-0005j5-52
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:38 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90Uq-0005el-2e
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:37 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51492ae66a4so7515895a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649164; x=1689241164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KTisvpy141VHl6Jl8IdlijmeVIKSJjM3R7YZNyvUfc8=;
 b=psp5IXJgfMdSJYnwqTBwlddCd7bqiI6xXCMYQwJUbZYy5d7h9ZUZBRjlyuNpMl2CyN
 E7Se8ZKfCthsEnV+OhT56ogVP69iE9HNea2ZfRctV6yRpetCsmV5NaT2j/LlUVBiwGzP
 vmvJQx9JqalNNAoT/afiF7iGIpOL2j/hewHY6QG+P3Ira/7sze3F+kltL54Q4xdlobII
 Il8IPfOxXTNgxsabQNrMRAj4EU7twYFqN9tymNsRjLYiikrPgR9butz5nc9eR0BCy7gQ
 IuSLteAufcBPcJyzYybreR+lOS616uOWm+9GOuCUQVMbXvsOxtXcvXhblRmMyX9jT8jq
 fUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649164; x=1689241164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KTisvpy141VHl6Jl8IdlijmeVIKSJjM3R7YZNyvUfc8=;
 b=NklZ8/4ySSpA8H3AKbS3lOzxkP3ea+CULe+rx3TlSAvTqDeW4nj5k20j7T4RG2xNND
 QWQ3/gudZEQvZ3SZXmEYQ8BMSuhQrMscx+LNnNaT7E0MRFZEAeRMIp6B8HF3FxyWqQ1S
 eE+oWfTskiWFI2cKcYpuuHKEtqyUZ5Pm1ndv7O+C9O4eJfwksBOYyjFpqIO8gfVdjnIF
 8IHJRBos8mRU5QmGCkS5ai/Dk95BHK/b4gpnDW9HYL8gk59mpI571JislY2QKKE0ayHY
 D7j2mGhXy3ajIJaf17G4K/VeDo0Xsl0gTi2av9x6zw588R9dkdj7Ex75+p5XoZuloAiO
 e8vA==
X-Gm-Message-State: AC+VfDy+rdaTPKwdqd8lbDmpY1MkDo+KoUP6N1EkHuqvYLUo2T1CbirV
 JI9PXeZ1HNbmNg78IJIdwIwoVHS8tDley2cfQM8GTg==
X-Google-Smtp-Source: ACHHUZ6hpEVEogvD+bdBlqsYRMAaz3ayvQKG8O3mL8chYqUb1kFvBjIGduNoArSoyj1DVrMbhEwuqQ==
X-Received: by 2002:aa7:ca4b:0:b0:518:797c:6bee with SMTP id
 j11-20020aa7ca4b000000b00518797c6beemr624427edt.5.1686649163810; 
 Tue, 13 Jun 2023 02:39:23 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 z20-20020a1709064e1400b009745eddf997sm6334993eju.198.2023.06.13.02.39.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 02:39:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/17] hw/char/parallel: Export struct ParallelState
Date: Tue, 13 Jun 2023 11:38:18 +0200
Message-Id: <20230613093822.63750-14-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613093822.63750-1-philmd@linaro.org>
References: <20230613093822.63750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Exporting ParallelState is a precondition for exporing TYPE_ISA_PARALLEL to be
performed in the next patch.

Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230612081238.1742-2-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/char/parallel.h | 21 +++++++++++++++++++++
 hw/char/parallel.c         | 20 --------------------
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
index 29d2876d00..9f76edca81 100644
--- a/include/hw/char/parallel.h
+++ b/include/hw/char/parallel.h
@@ -1,9 +1,30 @@
 #ifndef HW_PARALLEL_H
 #define HW_PARALLEL_H
 
+#include "exec/ioport.h"
+#include "exec/memory.h"
 #include "hw/isa/isa.h"
+#include "hw/irq.h"
+#include "chardev/char-fe.h"
 #include "chardev/char.h"
 
+typedef struct ParallelState {
+    MemoryRegion iomem;
+    uint8_t dataw;
+    uint8_t datar;
+    uint8_t status;
+    uint8_t control;
+    qemu_irq irq;
+    int irq_pending;
+    CharBackend chr;
+    int hw_driver;
+    int epp_timeout;
+    uint32_t last_read_offset; /* For debugging */
+    /* Memory-mapped interface */
+    int it_shift;
+    PortioList portio_list;
+} ParallelState;
+
 #define TYPE_ISA_PARALLEL "isa-parallel"
 
 void parallel_hds_isa_init(ISABus *bus, int n);
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 3d32589bb3..e75fc5019d 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -27,10 +27,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "chardev/char-parallel.h"
-#include "chardev/char-fe.h"
 #include "hw/acpi/acpi_aml_interface.h"
-#include "hw/irq.h"
-#include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
@@ -76,23 +73,6 @@
 
 #define PARA_CTR_SIGNAL (PARA_CTR_SELECT|PARA_CTR_INIT|PARA_CTR_AUTOLF|PARA_CTR_STROBE)
 
-typedef struct ParallelState {
-    MemoryRegion iomem;
-    uint8_t dataw;
-    uint8_t datar;
-    uint8_t status;
-    uint8_t control;
-    qemu_irq irq;
-    int irq_pending;
-    CharBackend chr;
-    int hw_driver;
-    int epp_timeout;
-    uint32_t last_read_offset; /* For debugging */
-    /* Memory-mapped interface */
-    int it_shift;
-    PortioList portio_list;
-} ParallelState;
-
 OBJECT_DECLARE_SIMPLE_TYPE(ISAParallelState, ISA_PARALLEL)
 
 struct ISAParallelState {
-- 
2.38.1


