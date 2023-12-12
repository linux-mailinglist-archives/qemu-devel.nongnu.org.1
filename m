Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F56580EA7F
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 12:38:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD14a-0000NZ-DE; Tue, 12 Dec 2023 06:37:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD14Y-0000NI-NX
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:37:10 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD14X-0006xj-6n
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:37:10 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-551437d5344so2330573a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 03:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702381027; x=1702985827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWiIaEjJAQ5+it/KnfBC9+5RmIMqGqAwUm0O20jJXPQ=;
 b=D5aOZ5jMkZiSdivGk3Ctpvfq+hLfnqh1zUz4EGctBo1glij3JdaMObOo5isweEhmaa
 friO948e36jgF6tG10zmUsXEeaUP71xnTALP8e/NHObJrAK129G2O3viel5GqpNCljoq
 0KC4PAfiWjpXV2pgqB0YvtqsFwUfKFdsEuyUDI4KbZnOmuLedJFx111lLTaJn4r2pfwE
 VKphMXLeHaHE27BKoHiS5KPcP/VIVczszqvl5ILJXsqKdito3cOy6ZEhOf/xvAtzFLMi
 XRVbUjmJLOoIvGGDhbvK6aE5XrvjIXlj9FbM8NEzNVMZnrtNdF2kpWICMGsiC2YVK0Py
 CS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702381027; x=1702985827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWiIaEjJAQ5+it/KnfBC9+5RmIMqGqAwUm0O20jJXPQ=;
 b=H7FFvCnj9+2o9v6G76kdDIiBMHKm4p210IHUF2mbvV0xwJR4ic1Isurk8K3YOhDR9n
 Mu15afdAnFSsicVItipfa0EMk6FAzMxtQttD8oSdwXilzukzx5Xcd0aJbbVYcuuAnB4h
 4CqVfVE1f7AwxH1Q6jA3YmHWIyY1oT50s0NVwf3/vu8qBgeDlKVuNhZ+0OkeL0TFFrdV
 cOwXTUun2V3xFz4ZGaSg3QLWBn1GoiTe9pZbaJ6MQ+6W18JEthUTeOtvULsIYx3fPjo2
 pC5m2ElMioGHfpexwKyFU1qI9IMVmicKmcJgntDA18tl+9EmNt8JfstR82JF822BvJUH
 yF3A==
X-Gm-Message-State: AOJu0YybDD5gyXGZyxzS9TwaVpjIwY5GaAuMo4XTKrNZos8oZvUjJMG9
 fppQ0BkRb3m9Zw0OwdlO1m3ahcRWhF02ddLc1487hA==
X-Google-Smtp-Source: AGHT+IEBlbl8IX7v1RxKCUoYgDHmgThw5XIkV0asWHn7syGLHvnLfzCVGpO20eliMv4XwDnZCH5DOQ==
X-Received: by 2002:a17:906:d8db:b0:a19:a1ba:8cc2 with SMTP id
 re27-20020a170906d8db00b00a19a1ba8cc2mr1912234ejb.96.1702381027587; 
 Tue, 12 Dec 2023 03:37:07 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 tl1-20020a170907c30100b00a1c8d243cf7sm6097107ejc.2.2023.12.12.03.37.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 03:37:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Song Gao <gaosong@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/4] target: Restrict 'sysemu/reset.h' to system emulation
Date: Tue, 12 Dec 2023 12:36:40 +0100
Message-ID: <20231212113640.30287-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212113640.30287-1-philmd@linaro.org>
References: <20231212113640.30287-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

vCPU "reset" is only possible with system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 target/i386/cpu.c      | 2 +-
 target/loongarch/cpu.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index dfb96217ad..17b6962d43 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -24,7 +24,6 @@
 #include "qemu/hw-version.h"
 #include "cpu.h"
 #include "tcg/helper-tcg.h"
-#include "sysemu/reset.h"
 #include "sysemu/hvf.h"
 #include "hvf/hvf-i386.h"
 #include "kvm/kvm_i386.h"
@@ -37,6 +36,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/i386/topology.h"
 #ifndef CONFIG_USER_ONLY
+#include "sysemu/reset.h"
 #include "qapi/qapi-commands-machine-target.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index fc075952e6..b26187dfde 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -17,7 +17,9 @@
 #include "internals.h"
 #include "fpu/softfloat-helpers.h"
 #include "cpu-csr.h"
+#ifndef CONFIG_USER_ONLY
 #include "sysemu/reset.h"
+#endif
 #include "tcg/tcg.h"
 #include "vec.h"
 
-- 
2.41.0


