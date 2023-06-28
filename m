Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0D07415B7
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:54:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXUc-0006Ef-Pz; Wed, 28 Jun 2023 11:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXUZ-0006DP-24
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:54:03 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXUV-00085Q-0m
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:54:01 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-312824aa384so5370287f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967635; x=1690559635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1p01mwNI4PbnXBYS34TfQsFRd8XkOd+v72EGXhsO46o=;
 b=icj/Uvz/U4FB1FMi9RSNPvamzpE83Tt76AV1YPWuw1O9Wo5KCeOOQ6Z4prMKjh/eQr
 hb7CIT64tHKAqZ26Pw9Eg2r2YDNwfFd97xwV2nrnH+BueS6w3F5RwGonRdyzoHLhn2Tl
 R9YUwLch4AtmAkL7jd9oejhor8igrapwzpZ3di2Kkt7zXltmc61Zn7456DnUFsnjf9rM
 ztBlcEF2HwaQ2dot6aEKR84QrzoYxboH6cZsVyoBQZZkP3G08XaOYm6gHSpZP2O1mjJ7
 1TmApcNX6JuxPi5XEmt94JFk2Q7mtVc6N57e0GL+ffvBrexBjWYOtuEYcIlcMbrSwm4+
 DoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967635; x=1690559635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1p01mwNI4PbnXBYS34TfQsFRd8XkOd+v72EGXhsO46o=;
 b=QAwQc3ZmvdXXph7s7dWYOUjfKsRTOTCDOvf5kIt26z1CE1qXb6j2lm5hRqAMe8DpId
 A7ahE91iKfMkxRcUVIiW3OMhcOWsByKhC9ZgHtLIXiPRmdO0PkVE9klNqzHsKEh4Z781
 CDCMy79gA8hwmkJNGkuKQbuzytat39dfFTu2mCZ32hUZk+3+G9/B8GWnP+al+sadD7CS
 JJqhbSuBid2fzOLLlnBKyoz2QBufYmnmHQH9lirtpKsTFk2RDg13tUfLVXIQ+Hyg9Hn+
 s19gPVtCrVhCVkxUU4u5DXzgn6/dqFz6JLWMll8y0YfoRLxVAqsT3cQZHanbTflKYYFm
 1yOg==
X-Gm-Message-State: AC+VfDyIeyhd6JOtiRADslbZaAQvj1SZWs3nKLBBGc5bNHRovjTW/cee
 9Zz79NKyrjIObpFJ2+kN9X+RzIB8trUKn6/z964=
X-Google-Smtp-Source: ACHHUZ4atB4yZN9q2Z6rBeGf7TGF9gZoKHisQSAPIjWf0/6pF7MiwXLMErdqOfWMFIaBIoN6Lp2dqQ==
X-Received: by 2002:adf:f243:0:b0:313:f1ec:f429 with SMTP id
 b3-20020adff243000000b00313f1ecf429mr6754227wrp.46.1687967635648; 
 Wed, 28 Jun 2023 08:53:55 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a5d5549000000b00307acec258esm13782917wrw.3.2023.06.28.08.53.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:53:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/30] accel: Destroy HAX vCPU threads once done
Date: Wed, 28 Jun 2023 17:52:50 +0200
Message-Id: <20230628155313.71594-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

When the vCPU thread finished its processing, destroy
it and signal its destruction to generic vCPU management
layer.

Add a sanity check for the vCPU accelerator context.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230624174121.11508-6-philmd@linaro.org>
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


