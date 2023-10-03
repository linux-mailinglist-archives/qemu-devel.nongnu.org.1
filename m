Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9FB7B6904
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:31:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qneYG-0000B6-FR; Tue, 03 Oct 2023 08:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qneYD-00007q-50
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:30:57 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qneY5-0007ho-Ao
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:30:56 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3214cdb4b27so873986f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 05:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696336242; x=1696941042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJP8U3eqs5eoWVLjFoE8nfmBFTz8cZ5KMaYYsencWoY=;
 b=CWV4Ss0P1hJC+NgTiVEmYtnq26bfbjh7Y+XlLGdmJhDnaC+Zvx5qm1Gg1fR81FM+F7
 O92vDbMfP3vHcy33sPsPzj2gFfIxS83UFHxH/WD3Ns7zn1mPL8r7F0uh7rPgm3i5ltCt
 b3lqrB03/0KZ0PjU0IXuuUWFVWJv+rUJKfIcod9x/qA7TjJzdqfNavJi4G9WV+VkQo9r
 1pzX240eGmu9vRwNmFzI0TMGIu2DqLmkoGge/h8ipSOdnbcE8foL8HFdKP8F1XP7Ls5Y
 A1Z0jWCk3fTESq8nu67yh/qJTojcQ3aZt6wtStl+tpXQewZRfDOVL6DehwKatvitmWEq
 Yqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696336242; x=1696941042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kJP8U3eqs5eoWVLjFoE8nfmBFTz8cZ5KMaYYsencWoY=;
 b=LZND7dFX+AkdcXbsICd1rS29fF2luxA97Qx0y7d4AUUXnLJvtphuvmWhsgP2x1i24u
 6iFTHXmUO4Bmz96Pk5aCplG+Nngyr+C699KKc3QO94KZKGg5tXJ5KZvN02p9UWgBj2sP
 jXt+WukiKiqisTbN/Oo1fgoRi0TeNks01fVf/SofDv2SvG4HUA2TGBBLU1WF6KSbrWrq
 shQl132WOKN5W76ANjV9CPGDcngPH7qvcjFkh9Yjxe3oieYDmQPz+g5u3faieUFc3Rx7
 kaI1B+0vPC6o8BtSIpCNRkJrxhICHMuu7srYXvZNA0484Wkor1rsuOckMRCpagSGw2Zy
 KX0g==
X-Gm-Message-State: AOJu0YxLv3dOw8UIgo7hoj7SQM0O6YHDlSvKW9f/HzbMmT2CXy9slqlw
 34I8b+SrHOoBMA4esuvdCNiOxHos/YBEP7dLxC/4Og==
X-Google-Smtp-Source: AGHT+IGUR2wNUuIBOoLxXPGLs96PG6WE7nSADBCjWoauQJ7ZMRjhIbxyisKYzFjcYkRhDb1hGd57iQ==
X-Received: by 2002:a5d:4a05:0:b0:317:7af4:5294 with SMTP id
 m5-20020a5d4a05000000b003177af45294mr12996108wrq.44.1696336241902; 
 Tue, 03 Oct 2023 05:30:41 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-246.abo.bbox.fr. [176.131.222.246])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a05600c0acf00b003fe29f6b61bsm1193158wmr.46.2023.10.03.05.30.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Oct 2023 05:30:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 2/7] accel: Rename AccelCPUClass::cpu_realizefn() ->
 cpu_target_realize()
Date: Tue,  3 Oct 2023 14:30:20 +0200
Message-ID: <20231003123026.99229-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003123026.99229-1-philmd@linaro.org>
References: <20231003123026.99229-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The AccelCPUClass::cpu_realizefn handler is meant for target
specific code, rename it using '_target_' to emphasis it.

Suggested-by: Claudio Fontana <cfontana@suse.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/accel-cpu.h | 2 +-
 accel/accel-common.c        | 4 ++--
 target/i386/hvf/hvf-cpu.c   | 2 +-
 target/i386/kvm/kvm-cpu.c   | 2 +-
 target/i386/tcg/tcg-cpu.c   | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/core/accel-cpu.h b/include/hw/core/accel-cpu.h
index 5dbfd79955..24dad45ab9 100644
--- a/include/hw/core/accel-cpu.h
+++ b/include/hw/core/accel-cpu.h
@@ -32,7 +32,7 @@ typedef struct AccelCPUClass {
 
     void (*cpu_class_init)(CPUClass *cc);
     void (*cpu_instance_init)(CPUState *cpu);
-    bool (*cpu_realizefn)(CPUState *cpu, Error **errp);
+    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
 } AccelCPUClass;
 
 #endif /* ACCEL_CPU_H */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index b953855e8b..2e30b9d8f0 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -123,8 +123,8 @@ bool accel_cpu_realize(CPUState *cpu, Error **errp)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
-    if (cc->accel_cpu && cc->accel_cpu->cpu_realizefn) {
-        return cc->accel_cpu->cpu_realizefn(cpu, errp);
+    if (cc->accel_cpu && cc->accel_cpu->cpu_target_realize) {
+        return cc->accel_cpu->cpu_target_realize(cpu, errp);
     }
     return true;
 }
diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
index 333db59898..bb0da3947a 100644
--- a/target/i386/hvf/hvf-cpu.c
+++ b/target/i386/hvf/hvf-cpu.c
@@ -77,7 +77,7 @@ static void hvf_cpu_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
-    acc->cpu_realizefn = host_cpu_realizefn;
+    acc->cpu_target_realize = host_cpu_realizefn;
     acc->cpu_instance_init = hvf_cpu_instance_init;
 }
 
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 4474689f81..9a5e105e4e 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -190,7 +190,7 @@ static void kvm_cpu_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
-    acc->cpu_realizefn = kvm_cpu_realizefn;
+    acc->cpu_target_realize = kvm_cpu_realizefn;
     acc->cpu_instance_init = kvm_cpu_instance_init;
 }
 static const TypeInfo kvm_cpu_accel_type_info = {
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index b942c306d6..5c3a508ddc 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -163,7 +163,7 @@ static void tcg_cpu_accel_class_init(ObjectClass *oc, void *data)
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
 #ifndef CONFIG_USER_ONLY
-    acc->cpu_realizefn = tcg_cpu_realizefn;
+    acc->cpu_target_realize = tcg_cpu_realizefn;
 #endif /* CONFIG_USER_ONLY */
 
     acc->cpu_class_init = tcg_cpu_class_init;
-- 
2.41.0


