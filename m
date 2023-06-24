Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6AF73CC2A
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 19:42:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD7Gw-0005mF-B2; Sat, 24 Jun 2023 13:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD7Gt-0005lP-IP
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 13:42:03 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD7Gs-0006El-2B
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 13:42:03 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fa71db4208so17842945e9.0
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 10:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687628520; x=1690220520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iCloP/Ux3IV8UJ0ZKXn7/ebp5dcIIh/2RC3mzeqRGMo=;
 b=B5Q6wTHDnyh2KH0MiJh6f7PRNtQ407iOhYbCWpAuAn2/F07ZIUhbhg5RZhnZx5aixo
 krIptOmRDGX4i+JQ48AmPyA0UMgIN9bZPYWdqQc0zCDEP4Do4gFa4VBPEK3TV2G/qjyK
 TxY+6y3B+iWbYRlATMU2lY1+o9i90v/HVZQYbeyLm6UdtSQEpYHVUcZ5fxK5VJ1NnEYs
 iy0BtiVzJy2t5b9awonbad36/jZG14S8MSTnthMeJln51zyNicO+yZr+ObXx88p69pnr
 S1aw9y9Wlm9wze65oBQ50fPz5m5iQqX+190XTv09khKKIIEk79oKUf1Nr2TcLzDhZUZR
 Grzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687628520; x=1690220520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iCloP/Ux3IV8UJ0ZKXn7/ebp5dcIIh/2RC3mzeqRGMo=;
 b=TgFNrP4zihGL18uxeVdtw7JHu1DiyLgYmkMAGxY/DcCpBPvs0PxpT1UuHU1dHhgyEU
 sCvZW1zy1Si9ryPQViCBMISdhcEaRyGq+ZS48M8qVvqTedk9T+0nIkG490FKAlQRG6Nk
 ucpPvminF5pyJgwKpDtqqEHv5HkMfEa5exvSaHTDIHNgHGgRWxf1m4roKRFEKaKEaFE7
 ljsPxe/UoMzm3QcAbtnKjGrBRuCxj6yf8HaGQRsCPWintUe7eZEuuunGnmfwQZIFDg3O
 uw64fkJDBafdKCT1sgb/1skLZ42GBJlUyXn4cifGYvKWKh5st8vDXG7GZO9C1swoI/11
 YLmA==
X-Gm-Message-State: AC+VfDzPDkOzOx/Kdwxg/92NT05JJwF2rc4p+ZZVn3DI+pHF1jui20/7
 /ktr7OG3OwiBqmjNTksZJZknG2W3Mrf8mPW1E/g=
X-Google-Smtp-Source: ACHHUZ5/SpC0ZbioPxnpVkbdcutfj7CfDUgxK3ql/H+wAujoV6T+DY7QM+cKCk/JAModrZsCdUekWQ==
X-Received: by 2002:a5d:5242:0:b0:313:deda:c444 with SMTP id
 k2-20020a5d5242000000b00313dedac444mr1551101wrc.24.1687628520556; 
 Sat, 24 Jun 2023 10:42:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.150])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a5d6ad2000000b00313e90d1d0dsm650617wrw.112.2023.06.24.10.41.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 24 Jun 2023 10:42:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, xen-devel@lists.xenproject.org,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Reinoud Zandijk <reinoud@netbsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 05/16] accel: Destroy HAX vCPU threads once done
Date: Sat, 24 Jun 2023 19:41:10 +0200
Message-Id: <20230624174121.11508-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230624174121.11508-1-philmd@linaro.org>
References: <20230624174121.11508-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


