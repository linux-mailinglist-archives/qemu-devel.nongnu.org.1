Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FB373A5A2
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:09:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCMsL-0003QG-IB; Thu, 22 Jun 2023 12:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCMsA-00034R-JU
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:09:27 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCMs6-0007xE-70
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:09:25 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f900cd3f96so63531265e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 09:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687450160; x=1690042160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IGm3E04zIWsYk05zgucyUicl5+3W8OYlCuN37xDTmqU=;
 b=oSZmsX3T/bloo+326SGPd5ZsHm46v9IjsSm+mX6+GHNqWc46SWntkTlBPS90redCNR
 ZUMjqxtJd3cZHvi9zSxHB4xdh1n7b8jsItx4rFl+mHiH+OgAFoaK+J/yb1D8i8vh1g6X
 Wh9p6+BtcM6BS/8tmV15GdIAi11Ly82V4oPU2YaNVUAxQtA0pzh18AGcDLF12Jbmstq5
 FC0EyBMowodStWUPlID3y0Fm2oMAF3cehAD/OcX6fjRY42O0eaZ1AhKvLl08mXhP6Qb/
 KU5JoMrq5Jkcz4ttchABNISgzL5QJIvTO362BtWKxVuE531Y/t0qEaegExQ9L9kbFuzp
 Gf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687450160; x=1690042160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IGm3E04zIWsYk05zgucyUicl5+3W8OYlCuN37xDTmqU=;
 b=kcuN1sdtPl7K8M4jxr7hQ1SmKRazoIFgjdWvQlkaY1vXlgAE6s7iFHVkw8DOldTzx5
 P5PjxqwXiB+GqTbH6I96KmmkbgXpX4MZhLVGUerloDOwUCJ0jWvrJB3J8SnOBPboa1NQ
 z7tRE5O5+F6O0rHj4X+BDEPlfeDhT5AZ8RhSFIDR0SBVPorPuXj14NehezjG/WnAyBOT
 rBwozIYpaVVO7mepGnrVXVTLjlpmpsTUm4guXEBbAI8GvPuY6KGELn158w23YiBY5DjU
 GvY2BdPrp02E9iYjJxED9K5UvX6fBaNuccl4EzuKQIWounkYgWfFBU++Q8b3CPh/p/ub
 RMPQ==
X-Gm-Message-State: AC+VfDzMIeTWm1RXGG6o9DibgRvKRgQetbqJB9kVZPRTudIwSw1/rhRO
 1uK9jb19i81VA4ce2XFmnBrXaK5CTOZtLPoKtP9Guw==
X-Google-Smtp-Source: ACHHUZ74qZrgBDYUQFFsXIVlBQ+o5CwN3jxcBXCwUZJbgQTonuPJrTO0oSESuEoeaErY25ll4f9Zaw==
X-Received: by 2002:a05:600c:2650:b0:3f8:1f52:f3a9 with SMTP id
 16-20020a05600c265000b003f81f52f3a9mr13773747wmy.23.1687450160763; 
 Thu, 22 Jun 2023 09:09:20 -0700 (PDT)
Received: from localhost.localdomain (230.red-88-28-3.dynamicip.rima-tde.net.
 [88.28.3.230]) by smtp.gmail.com with ESMTPSA id
 x16-20020a05600c21d000b003f90b58df65sm13346472wmj.29.2023.06.22.09.09.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jun 2023 09:09:20 -0700 (PDT)
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
Subject: [PATCH v2 05/16] accel: Destroy HAX vCPU threads once done
Date: Thu, 22 Jun 2023 18:08:12 +0200
Message-Id: <20230622160823.71851-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230622160823.71851-1-philmd@linaro.org>
References: <20230622160823.71851-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

When the vCPU thread finished its processing, destroy
it and signal its destruction to generic vCPU management
layer.

Add a sanity check for the vCPU accelerator context.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/hax/hax-accel-ops.c | 3 +++
 target/i386/hax/hax-all.c       | 1 +
 2 files changed, 4 insertions(+)

diff --git a/target/i386/hax/hax-accel-ops.c b/target/i386/hax/hax-accel-ops.c
index 18114fe34d..0157a628a3 100644
--- a/target/i386/hax/hax-accel-ops.c
+++ b/target/i386/hax/hax-accel-ops.c
@@ -53,6 +53,8 @@ static void *hax_cpu_thread_fn(void *arg)
 
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
+    hax_vcpu_destroy(cpu);
+    cpu_thread_signal_destroyed(cpu);
     rcu_unregister_thread();
     return NULL;
 }
@@ -69,6 +71,7 @@ static void hax_start_vcpu_thread(CPUState *cpu)
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, hax_cpu_thread_fn,
                        cpu, QEMU_THREAD_JOINABLE);
+    assert(cpu->hax_vcpu);
 #ifdef _WIN32
     cpu->hThread = qemu_thread_get_handle(cpu->thread);
 #endif
diff --git a/target/i386/hax/hax-all.c b/target/i386/hax/hax-all.c
index a2321a1eff..38a4323a3c 100644
--- a/target/i386/hax/hax-all.c
+++ b/target/i386/hax/hax-all.c
@@ -209,6 +209,7 @@ int hax_vcpu_destroy(CPUState *cpu)
     CloseHandle(cpu->hThread);
 #endif
     g_free(vcpu);
+    cpu->hax_vcpu = NULL;
     return 0;
 }
 
-- 
2.38.1


