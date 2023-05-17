Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC48F70627A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:13:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzCH1-000698-Gd; Wed, 17 May 2023 04:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pzCGt-00060Z-NA; Wed, 17 May 2023 04:12:31 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pzCGn-0003O1-6E; Wed, 17 May 2023 04:12:31 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f475366514so3067885e9.2; 
 Wed, 17 May 2023 01:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684311143; x=1686903143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=erP4CMZ3vKzTZs3RtOtcV+NBfbOirUzqRMc5Dx/ruy8=;
 b=YyD2deSJCrPOpWB+mePixeJypSKZRSTLJ7YhfZjEbnYTd3VVeUAgzMWyH9YudP0qCL
 LhG6r1jBOpGv2XPF13xt7bHUbbO5UKON9tsWquqsvTa1cs0loIOoRJngDy2mxXrh3tPI
 caJxnNl2fpUKnHKHWkDE/3PYN3ATL288AGPDpT6albTc1cojcpJ/Owzh3WpzfKrELNEm
 w0DF2Wo4sjnnk1s8wLE3Q10cIyPmskNm7mgP8j1kjN52bzDl3bbyzGoiE0b/jz6xX60e
 UMWTtG+uPVCd9PM4v4SbWUZasDga3lB3FYFOZgd768ytT9JC/MDCChhQftNmmvlNvINY
 aA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684311143; x=1686903143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=erP4CMZ3vKzTZs3RtOtcV+NBfbOirUzqRMc5Dx/ruy8=;
 b=OMcvLOqRr/2H2J50sUtl7rDkC6nhR+tdDJwReyYLAh+P0noNFTnLYPP+BZvKYARH4C
 CNS95L/k5fFxaIVJs3XmeqhXiQ9x1NqUxAyyxqYE+aGdCjaNvQUbJdmgtT/hE+yNoQk+
 xhzUym6cEG18TB11225mL4S5hiOOOjvKiSyESwMT6KjfSPNX+TfZURXpLfVfbrlErgHX
 3yewXwZ8yWJ8PnftLt25je2MdXMxNwd4P5wfkFWJdVRBp8xygvOGrC23eV6PlTWzLSAC
 UL9UhmhD2FlruV8qwRUFUoXkEbP71s4u4TaqFz5uJuRueG8mQhSsfO+UuMkI25VZs/iy
 vmIQ==
X-Gm-Message-State: AC+VfDxQfyt9Xgfgt0rAmqGd8wG75e5+mjo9k9ql+MNeW3Q6RGX1f5+Q
 0yahZddXDIF54V3xfZ/nj2aQFlbQMDE=
X-Google-Smtp-Source: ACHHUZ4aRwGJReYAzXa5s72lUagP7El8Z8CkxgAIRHPnZN/X65to23HsNlmeHYSOAW48QwSAJRX7cQ==
X-Received: by 2002:a1c:7517:0:b0:3f4:2610:5cbb with SMTP id
 o23-20020a1c7517000000b003f426105cbbmr21910773wmc.2.1684311142852; 
 Wed, 17 May 2023 01:12:22 -0700 (PDT)
Received: from i.. ([41.236.82.205]) by smtp.gmail.com with ESMTPSA id
 o24-20020a1c7518000000b003f42158288dsm1414942wmc.20.2023.05.17.01.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 01:12:22 -0700 (PDT)
From: Mohamed ElSayed <m.elsayed4420@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Mohamed ElSayed <m.elsayed4420@gmail.com>
Subject: [PATCH 7/8] tiva c board documentation
Date: Wed, 17 May 2023 11:12:03 +0300
Message-Id: <20230517081204.30333-8-m.elsayed4420@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517081204.30333-1-m.elsayed4420@gmail.com>
References: <20230517081204.30333-1-m.elsayed4420@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=m.elsayed4420@gmail.com; helo=mail-wm1-x332.google.com
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

Signed-off-by: Mohamed ElSayed <m.elsayed4420@gmail.com>
---
 docs/system/arm/tivac.rst | 47 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 docs/system/arm/tivac.rst

diff --git a/docs/system/arm/tivac.rst b/docs/system/arm/tivac.rst
new file mode 100644
index 0000000000..8e78726c01
--- /dev/null
+++ b/docs/system/arm/tivac.rst
@@ -0,0 +1,47 @@
+Texas Instruments EK-TM4C123GXL Evaluation Board, ``Tiva C``
+========================================================================================
+
+The `Tiva C`_ board is an evaluation platform for ARM Cortex-M4-based microcontrollers.
+Its based on the `TM4C123GH6PM`_ microcontroller by Texas Instruments.
+
+.. _Tiva C: https://www.ti.com/tool/EK-TM4C123GXL
+.. _TM4C123GH6PM: https://www.ti.com/product/TM4C123GH6PM
+
+Supported modules
+-----------------
+
+ * ARM Cortex-M4
+ * General Purpose Input/Output (GPIO)
+ * General Purpose Timers (GPTM)
+ * Serial Ports (USART)
+ * System Control (SYSCTL)
+ * Watchdog Timers (WDT)
+
+Missing modules
+---------------
+
+ * Dynamic Memory Access (uDMA)
+ * Analog to Digital Converter (ADC)
+ * Synchronous Serial Interface (SSI)
+ * Inter-Integrated Circuit Interface (I2C)
+ * Controller Area Network (CAN)
+ * USB Controller
+ * Analog Comparators
+ * Pulse Width Modulator (PWM)
+ * Quadrature Encoder Interface (QEI)
+
+Boot options
+------------
+
+The Tiva C machines could be started using the ``-kernel`` option to load a binary file.
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M tivac -kernel binary.elf -s -S
+
+The ``-s -S`` switches are for debugging, in another terminal window you can do:
+
+.. code-block:: bash
+
+   $ arm-none-eabi-gdb binary.elf
+   (gdb) target remote :1234
-- 
2.34.1


