Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5964473A5A0
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:09:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCMs3-0002qb-Tq; Thu, 22 Jun 2023 12:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCMrz-0002np-63
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:09:15 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCMrm-0007hE-1H
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:09:04 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-311183ef595so7380230f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687450140; x=1690042140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iG1kgLZ5QV1q9fprOekDS1vi4YDLS9XqOgasp153yeA=;
 b=pioUrZaFPhU8I3k58jH5e1qB2rLoMjDOpycpjg9MKCT8jB0VWYDPIf8BgBkiqcuhFF
 TGcG4z4waQLxR0t85sX3LfEm1fBfri5nyTc7hT7LFVuMZJ8cJ7iLzkMzgCCxgXAXjRp1
 5FcEvpmzbqIFAxYcu+grqZd6fl2U26lypXHSgtzz883z04khvbCBjPhnZpOIijZm7hIY
 73T6xIrKJfYThnwqe3k9n+UZwuUIp87JUU4oxyTveu1UWR2+M0IfsVqIofaSE6fL7s6R
 TsZ+4CItCUkFmVs4drtOmtuFIt03b22ea/hckXR+fp4F3k6OU3hz418EDxIcz7+/pZ4m
 IaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687450140; x=1690042140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iG1kgLZ5QV1q9fprOekDS1vi4YDLS9XqOgasp153yeA=;
 b=Yo5Tk+w6uj8lNBFmrh8TaRHWwr5C+6gZhJ0raN0644CqhRIKSStSBGzwGUOVsetVlH
 Zmu0SrGQN2dgKULMvgd81nUhB5bh9YMxGxNlKg1XFknugoJYyiNM6FG5CXTxBmAWwaBW
 zDbUX812Jp6u7kTPZHnJz2WNPdPFeM9TFz1O0hpweW8+8FwKNk03LlwUmRcC1xsmUSHE
 W8Ryvz75FhJl85DfeP0FSHLRvbJqcNQJFkXkfef7DArtDaknbmBuFBrd/U/np98At2FA
 si6uju+/vQxm6tee0aP88s76gdDPuYwL/G0lvKLxfoqULalheo7J2AcEuBU/dz60KQ8D
 ekfQ==
X-Gm-Message-State: AC+VfDwVZGLAuUn5X5x3RkbJ5WhETP7/gFXPPGzyuYTii3oYyupdQgF6
 cBCFer4vEccZy+enGl+VZkUjKmjomPKj1dHL1ftsTg==
X-Google-Smtp-Source: ACHHUZ5hS1cl385w0yy33SqHwzVfoviqPj7U7KGbU74d6nSn/Ie9wcppThLz//Iv2Nhpzhzuwuby+Q==
X-Received: by 2002:adf:e610:0:b0:311:1679:6b5c with SMTP id
 p16-20020adfe610000000b0031116796b5cmr2213196wrm.63.1687450140515; 
 Thu, 22 Jun 2023 09:09:00 -0700 (PDT)
Received: from localhost.localdomain (230.red-88-28-3.dynamicip.rima-tde.net.
 [88.28.3.230]) by smtp.gmail.com with ESMTPSA id
 n11-20020a5d4c4b000000b003113ccbf388sm7480042wrt.13.2023.06.22.09.08.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jun 2023 09:09:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Durrant <paul@xen.org>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Eduardo Habkost <eduardo@habkost.net>,
 Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 03/16] accel: Remove unused hThread variable on TCG/WHPX
Date: Thu, 22 Jun 2023 18:08:10 +0200
Message-Id: <20230622160823.71851-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230622160823.71851-1-philmd@linaro.org>
References: <20230622160823.71851-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On Windows hosts, cpu->hThread is assigned but never accessed:
remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops-mttcg.c   | 4 ----
 accel/tcg/tcg-accel-ops-rr.c      | 3 ---
 target/i386/whpx/whpx-accel-ops.c | 3 ---
 3 files changed, 10 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index b320ff0037..b276262007 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -152,8 +152,4 @@ void mttcg_start_vcpu_thread(CPUState *cpu)
 
     qemu_thread_create(cpu->thread, thread_name, mttcg_cpu_thread_fn,
                        cpu, QEMU_THREAD_JOINABLE);
-
-#ifdef _WIN32
-    cpu->hThread = qemu_thread_get_handle(cpu->thread);
-#endif
 }
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 23e4d0f452..2d523289a8 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -329,9 +329,6 @@ void rr_start_vcpu_thread(CPUState *cpu)
 
         single_tcg_halt_cond = cpu->halt_cond;
         single_tcg_cpu_thread = cpu->thread;
-#ifdef _WIN32
-        cpu->hThread = qemu_thread_get_handle(cpu->thread);
-#endif
     } else {
         /* we share the thread */
         cpu->thread = single_tcg_cpu_thread;
diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index e8dc4b3a47..67cad86720 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -71,9 +71,6 @@ static void whpx_start_vcpu_thread(CPUState *cpu)
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, whpx_cpu_thread_fn,
                        cpu, QEMU_THREAD_JOINABLE);
-#ifdef _WIN32
-    cpu->hThread = qemu_thread_get_handle(cpu->thread);
-#endif
 }
 
 static void whpx_kick_vcpu_thread(CPUState *cpu)
-- 
2.38.1


