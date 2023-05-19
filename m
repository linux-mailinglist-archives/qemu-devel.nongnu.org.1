Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BBB709D8A
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 19:07:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q03Xd-0002DT-FR; Fri, 19 May 2023 13:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q03XM-0002Ay-8P
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:05:05 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q03XG-0005UU-JT
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:05:03 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3063891d61aso3336173f8f.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 10:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684515897; x=1687107897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4Fc4cXBL03Lk5/gUamd723FCI9OSGD0ICedLkUTlC8=;
 b=VoUv1nLC184dLCFpeVOU/3BGEqI2CEotvOCQcmUYFihVkWGFJCKJaYZYUx9i0roFTf
 rVoRRMuFj/nqHPNwpKD7b5CuIgC0Z8qaHwTg+4zVv+jQ7mFjLrMUfd1CWHcxRkMGAsYr
 P8u2lsUmEWbPKlEf1CZayJduKSCTPf27RwQM61/0Z3340vNRAH+ckYatuqBA9lhHUD1k
 n0P2IzoXhphlA/QTIgsbedCNx6ioryaEDTBDezVVuQCj5iCynTHuGbP9nDRc+edz2nNz
 K21oUyvCGpwr5jRjDh0JAbZxHlJe0jo0RmJWAA0jU3TyFhTEJ1XjvqvG+PCy7W3mMeID
 SjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684515897; x=1687107897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y4Fc4cXBL03Lk5/gUamd723FCI9OSGD0ICedLkUTlC8=;
 b=lhg6Xjb5e5PziRQ0fnmGcszcBGckt+5ogz4n9EYxSjf4Zew1YT7MKCRpK2HfVcv04D
 5ev9VUhPaV1E6FR/3S34x+ma0/mZ0W9O9gUFHna0NSo17heF5nZq43Q3S/6mZc7t2sMW
 aCZBUx/5nGK+1D6sDEVi3XRwOAoN32WcdEK9d3mqxORuYfMrB5wiX2QFEwQJsYPXqY79
 Y5UecYxBSDvQcs2IEbaPaM9wD/RgqxkRWY8bwSgACsyTzrZZA9zuK8013M56Jc2J4Vqy
 IqnE88N56QZeOE7BeA9T5LDxU6ejqsbRJK3TYlyCz2YZCS8MQXCAV9b1ShJNr9qOssC+
 NThA==
X-Gm-Message-State: AC+VfDwuHp8uIiUi9Kpm8B52B+SDm1MO/v7vwsHq9oV/onmhqdoiud34
 1ZtxZ/Flr/ni3rA91dCI6Uvskg==
X-Google-Smtp-Source: ACHHUZ7EeK4jwhITIzB5jIITj9Ez4i/5hFOqUHFlzttnGaWFalUmmg2u0ot2O6BpZoV8p+MdfFTWmw==
X-Received: by 2002:adf:e689:0:b0:309:38af:d300 with SMTP id
 r9-20020adfe689000000b0030938afd300mr2008452wrm.33.1684515897196; 
 Fri, 19 May 2023 10:04:57 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q18-20020a5d61d2000000b003079c402762sm5839752wrv.19.2023.05.19.10.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 10:04:55 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 45B7F1FFBF;
 Fri, 19 May 2023 18:04:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marco Liebel <mliebel@qti.qualcomm.com>,
 Mark Burton <mburton@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [RFC PATCH 4/8] sysemu: add set_virtual_time to accel ops
Date: Fri, 19 May 2023 18:04:50 +0100
Message-Id: <20230519170454.2353945-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519170454.2353945-1-alex.bennee@linaro.org>
References: <20230519170454.2353945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

We are about to remove direct calls to individual accelerators for
this information and will need a central point for plugins to hook
into time changes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/sysemu/accel-ops.h                     | 18 +++++++++++++++++-
 include/sysemu/cpu-timers.h                    |  3 ++-
 softmmu/cpus.c                                 | 11 +++++++++++
 ...et-virtual-clock.c => cpus-virtual-clock.c} |  5 +++++
 stubs/meson.build                              |  2 +-
 5 files changed, 36 insertions(+), 3 deletions(-)
 rename stubs/{cpus-get-virtual-clock.c => cpus-virtual-clock.c} (68%)

diff --git a/include/sysemu/accel-ops.h b/include/sysemu/accel-ops.h
index 3c1fab4b1e..224e85a649 100644
--- a/include/sysemu/accel-ops.h
+++ b/include/sysemu/accel-ops.h
@@ -20,7 +20,12 @@
 typedef struct AccelOpsClass AccelOpsClass;
 DECLARE_CLASS_CHECKERS(AccelOpsClass, ACCEL_OPS, TYPE_ACCEL_OPS)
 
-/* cpus.c operations interface */
+/**
+ * struct AccelOpsClass - accelerator interfaces
+ *
+ * This structure is used to abstract accelerator differences from the
+ * core CPU code. Not all have to be implemented.
+ */
 struct AccelOpsClass {
     /*< private >*/
     ObjectClass parent_class;
@@ -43,7 +48,18 @@ struct AccelOpsClass {
 
     void (*handle_interrupt)(CPUState *cpu, int mask);
 
+    /**
+     * @get_virtual_clock: fetch virtual clock
+     * @set_virtual_clock: set virtual clock
+     *
+     * These allow the timer subsystem to defer to the accelerator to
+     * fetch time. The set function is needed if the accelerator wants
+     * to track the changes to time as the timer is warped through
+     * various timer events.
+     */
     int64_t (*get_virtual_clock)(void);
+    void (*set_virtual_clock)(int64_t time);
+
     int64_t (*get_elapsed_ticks)(void);
 
     /* gdbstub hooks */
diff --git a/include/sysemu/cpu-timers.h b/include/sysemu/cpu-timers.h
index 2e786fe7fb..c3f4c262f8 100644
--- a/include/sysemu/cpu-timers.h
+++ b/include/sysemu/cpu-timers.h
@@ -84,8 +84,9 @@ int64_t cpu_get_clock(void);
 
 void qemu_timer_notify_cb(void *opaque, QEMUClockType type);
 
-/* get the VIRTUAL clock and VM elapsed ticks via the cpus accel interface */
+/* get/set the VIRTUAL clock and VM elapsed ticks via the cpus accel interface */
 int64_t cpus_get_virtual_clock(void);
+void cpus_set_virtual_clock(int64_t new_time);
 int64_t cpus_get_elapsed_ticks(void);
 
 #endif /* SYSEMU_CPU_TIMERS_H */
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index 9cbc8172b5..1e4f09553a 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -221,6 +221,17 @@ int64_t cpus_get_virtual_clock(void)
     return cpu_get_clock();
 }
 
+/*
+ * Signal the new virtual time to the accelerator. This is only needed
+ * by accelerators that need to track the changes as we warp time.
+ */
+void cpus_set_virtual_clock(int64_t new_time)
+{
+    if (cpus_accel && cpus_accel->set_virtual_clock) {
+        cpus_accel->set_virtual_clock(new_time);
+    }
+}
+
 /*
  * return the time elapsed in VM between vm_start and vm_stop.  Unless
  * icount is active, cpus_get_elapsed_ticks() uses units of the host CPU cycle
diff --git a/stubs/cpus-get-virtual-clock.c b/stubs/cpus-virtual-clock.c
similarity index 68%
rename from stubs/cpus-get-virtual-clock.c
rename to stubs/cpus-virtual-clock.c
index fd447d53f3..af7c1a1d40 100644
--- a/stubs/cpus-get-virtual-clock.c
+++ b/stubs/cpus-virtual-clock.c
@@ -6,3 +6,8 @@ int64_t cpus_get_virtual_clock(void)
 {
     return cpu_get_clock();
 }
+
+void cpus_set_virtual_clock(int64_t new_time)
+{
+    /* do nothing */
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index 8412cad15f..c32c66a5c7 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -5,7 +5,7 @@ stub_ss.add(files('blockdev-close-all-bdrv-states.c'))
 stub_ss.add(files('change-state-handler.c'))
 stub_ss.add(files('cmos.c'))
 stub_ss.add(files('cpu-get-clock.c'))
-stub_ss.add(files('cpus-get-virtual-clock.c'))
+stub_ss.add(files('cpus-virtual-clock.c'))
 stub_ss.add(files('qemu-timer-notify-cb.c'))
 stub_ss.add(files('icount.c'))
 stub_ss.add(files('dump.c'))
-- 
2.39.2


