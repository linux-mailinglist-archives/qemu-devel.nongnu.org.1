Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2427D144B
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 18:42:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtsVd-0003U7-ES; Fri, 20 Oct 2023 12:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtsVa-0003Mb-TH
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:37:58 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtsVX-0002XI-3H
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:37:58 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53e2308198eso1558831a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697819869; x=1698424669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q4kg06JcXQgpZkYD+aAuvNPHOfoXMdKM9u+t0AGSCsc=;
 b=y7TDR7gocgMIl43p3qs3dE9Hi/fpBdYlyg1vuedF75sXYg0bImBkPCLvD65FmDVYQZ
 t0U1VUeOlQYzyXh3tdsUfFSaRYnQrMoKzysSOLHfRsa9+0kLJQQECZ9TYARW0jBCerOk
 yaLMyf1420PsqnIgz5yMVMhyLzzCxCVflxkkfJIlMoxFqvYAI63N+obNSsKFVajxRL6R
 +7KvU/wF7cjU8Cd95j5p2IZU/XbHyr0sYnbasAnf8BTwd0VAqbMu2sQ97I8wDT4HJGzj
 9M5JiHYv57eBmMd6qLh+rCv7rdKlGRdfMbtekuRWuodMsDC8kzCw/Hrxw4rrRxNIWkj4
 XjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697819869; x=1698424669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q4kg06JcXQgpZkYD+aAuvNPHOfoXMdKM9u+t0AGSCsc=;
 b=ukV0haGO9G6Lehz4kpS7bofn+U6i10cqxvBFERzKTt2L0Kqr2qFArnALcq1ZBguS5S
 F6NTKpW4vCDJWDz7+JX1a5jvvHJabpY2I6PMH24DU/EmdAgZbVXLWyQ1eKint4w3SU50
 sFox7B+L+dVc5SoOoEeZ7w6/vEMVBQ472DhD4MmLSm5tER6pd6ikLEUO0GHGAdwUHivS
 iAQDte1Oac31hiENW5KSBB5MxzDuHURo5fyXOAX4N/g/uaNvGDR4hIjPMptX1IhIaMxl
 PdmwJ9ZrTf/MQuzqbX9sNPE5gjiBTmahuYkrLj4FNhzweg2Q2FQwrEjdMBCqxDV5KjT7
 NJIw==
X-Gm-Message-State: AOJu0YwMOC80zC79kdKdDX5pTEk0XJkxyCSsuoJPtgozxymtMFrVdyuj
 +sZFuQjAHYGQVIc9ZsF63uo8+iEC/xoBaoo7YIE=
X-Google-Smtp-Source: AGHT+IEdrkG9FwSyY/AKa9oPX4+3ml15l30g0cytwWkx3WA2O/VxxtOxCvAUt/yP8dWulgtn962GBQ==
X-Received: by 2002:a50:d542:0:b0:53f:a4f7:7bfb with SMTP id
 f2-20020a50d542000000b0053fa4f77bfbmr1828115edj.17.1697819869764; 
 Fri, 20 Oct 2023 09:37:49 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 c21-20020a50d655000000b00537963f692esm1813284edj.0.2023.10.20.09.37.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 09:37:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/19] cpus: Filter for target specific CPU (ppc)
Date: Fri, 20 Oct 2023 18:36:30 +0200
Message-ID: <20231020163643.86105-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020163643.86105-1-philmd@linaro.org>
References: <20231020163643.86105-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Enforce qemu_get_cpu() to return PPC CPUs in PPC specific files.

Mechanical change using the following coccinelle script:

  @@ expression index; @@
  -   qemu_get_cpu(index, NULL)
  +   qemu_get_cpu(index, TYPE_POWERPC_CPU)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/e500.c         | 2 +-
 hw/ppc/ppce500_spin.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 380bbe1fe6..c4bf3fef32 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -495,7 +495,7 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
         char *cpu_name;
         uint64_t cpu_release_addr = pmc->spin_base + (i * 0x20);
 
-        cpu = qemu_get_cpu(i, NULL);
+        cpu = qemu_get_cpu(i, TYPE_POWERPC_CPU);
         if (cpu == NULL) {
             continue;
         }
diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index 3b113fbbdb..142bd45f18 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -125,7 +125,7 @@ static void spin_write(void *opaque, hwaddr addr, uint64_t value,
     SpinInfo *curspin = &s->spin[env_idx];
     uint8_t *curspin_p = (uint8_t*)curspin;
 
-    cpu = qemu_get_cpu(env_idx, NULL);
+    cpu = qemu_get_cpu(env_idx, TYPE_POWERPC_CPU);
     if (cpu == NULL) {
         /* Unknown CPU */
         return;
-- 
2.41.0


