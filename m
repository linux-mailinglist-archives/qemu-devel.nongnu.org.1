Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6C080EC43
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:42:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD1yI-0007nO-H2; Tue, 12 Dec 2023 07:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1yC-0007kh-EM
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:34:40 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1yA-0006hX-5X
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:34:40 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a1c7d8f89a5so745661666b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 04:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702384476; x=1702989276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXgjVQ2n+XwsEUqQbXGRL1Mo/9FL6x1+dKtNElcWrbs=;
 b=sq8oLII3BUx/3EyfdmEGiRo7Tp7Qoa+MJmQxms2YsAGGiWFNrhptV09YeD8RaXWtAJ
 04nVzlTCdrui8z0CYVRwwUI36eeOZzKSSztbuSC1diKDr1cfe79uBWj20HIPNP5vIFbt
 8QfTJd5/LS6DEJYtV4ALoKnziWPcLx0IWHOzw5HzIFPvbRNaAUc68Lp7JWTBZaSZdWkL
 t4KYudS50dJnB3IEZlGfHNOgb6KARbOASYdPRRpO5qmkF/V0eviBuR8CyTDIAWZRsLWG
 FpstQ0g8d6cNxKksjOXbqY8Yx2HXI4VMawPn/RD8jbnsfovcSmEgxDJmzFqhJCcUDwHZ
 KNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702384476; x=1702989276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MXgjVQ2n+XwsEUqQbXGRL1Mo/9FL6x1+dKtNElcWrbs=;
 b=QRQOiDSEV4E1EgQNhynS8ipsI88/35Db1/Y0niFCM3wpEmshM2ZOu+WH6RzRBgnmtM
 8JblJ0p3TyET07UCkjX2Yz1qx9lRdiMVwDjtLouNdvVbR1dbtfwPHuL+swBclkLPXq8y
 4vCWeam4iwyPGzd85fOD1F+Ug+H/flBa6BKOPz6NZf33qRg36iwEuzvyVLbAx+OHgr2E
 bjacpxx2Vn0XZXTAGpFIQFLo+K0aNhIB6lwvvoFxlMXwuVENrT8nWZeiRWBy97cX5k7S
 zI7CNQOiUv7uAPJnNKoDosRWu0c3w+0A6bUlhAFDdvc6KfKiTUsQpkyh4Q1XcwdYfnlk
 3a7A==
X-Gm-Message-State: AOJu0Yy2T7mNFEgqNNTB4t0dYn8kgXoQSqWOsOXRAgrvUxPfPXUBcLWw
 IkHZuBvAZzUa0mxvAHsapmTxEjguHGGmZrXIWihBlA==
X-Google-Smtp-Source: AGHT+IGJIpETCZ65W8iTAUZEGfLAHHOlaBeQwlHzrT8mSCbAuf4WHyQKmmp/N7JttIU8DAxSRgFdIQ==
X-Received: by 2002:a17:907:d25:b0:a1f:6b64:6a52 with SMTP id
 gn37-20020a1709070d2500b00a1f6b646a52mr3881128ejc.43.1702384476170; 
 Tue, 12 Dec 2023 04:34:36 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a170906530700b00a1b32663d7csm6210926ejo.102.2023.12.12.04.34.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 04:34:35 -0800 (PST)
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
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH v2 04/23] accel: Include missing 'exec/cpu_ldst.h' header
Date: Tue, 12 Dec 2023 13:33:40 +0100
Message-ID: <20231212123401.37493-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212123401.37493-1-philmd@linaro.org>
References: <20231212123401.37493-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Theses files call cpu_ldl_code() which is declared
in "exec/cpu_ldst.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c        | 1 +
 target/hexagon/translate.c    | 1 +
 target/microblaze/cpu.c       | 1 +
 target/microblaze/translate.c | 1 +
 target/nios2/translate.c      | 1 +
 5 files changed, 5 insertions(+)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 38c34009a5..5b019a0852 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -12,6 +12,7 @@
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
 #include "exec/translator.h"
+#include "exec/cpu_ldst.h"
 #include "exec/plugin-gen.h"
 #include "tcg/tcg-op-common.h"
 #include "internal-target.h"
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 666c061180..744dc4fc3f 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -23,6 +23,7 @@
 #include "exec/helper-gen.h"
 #include "exec/helper-proto.h"
 #include "exec/translation-block.h"
+#include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "internal.h"
 #include "attribs.h"
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index bbb3335cad..91d7cd9061 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -28,6 +28,7 @@
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 #include "exec/gdbstub.h"
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 49bfb4a0ea..1c9a364c2b 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index e806623594..a74eb6909f 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -25,6 +25,7 @@
 #include "cpu.h"
 #include "tcg/tcg-op.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 #include "disas/disas.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-- 
2.41.0


