Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D24577DB7DC
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 11:22:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxPOn-0001fI-Ca; Mon, 30 Oct 2023 06:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxPOj-0001av-IQ
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:21:29 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxPOi-0005mU-3G
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:21:29 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32dc918d454so2703804f8f.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 03:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698661285; x=1699266085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hDgxtJ8LJSLlaGRBFbu1Bz7Ni+XiHBQ0/w5hNTKB96Y=;
 b=nIh7wQ5l85tsRYgvA3FA+SQJZUZ/6vXlCQR1MhYammWncgiqcrHXhFAsULbkPGF5cm
 eqLUCgQ4WLunmV3B4HUop39aSmzRT0H8Hfqtv4bb2qcPz7wgmAOMIXzvqYP22Zq6smwn
 Fg3DIBPlz8B2nhh3GimBUCtwxSefRBGpBD8yoRyZGZ1mRHTzWKBg5tvfm6hy3nuRkqb9
 bwBlC+uaXy6205webWYooCq4BpcxfmxETGtj3NEnqh1/FihCKZfTYSW5IBrsd+muMJGN
 47Ts2JF2xWYy7/SHV3hBAch/QPKoLOSgrV64bNpDPDu42yNqjmnRIIJUobrpfmw78M5L
 4CNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698661285; x=1699266085;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hDgxtJ8LJSLlaGRBFbu1Bz7Ni+XiHBQ0/w5hNTKB96Y=;
 b=I/3YJq6Jl40TJN2gznRkYKyZ5dqLM2cjhMCYGnlVnyrDFfxXH3ydTleGYXdFc3bmrq
 G5lLuCih5X0HyZzqtoP/qyCKtfFGEf9soBuZXywVYXnxMCa5hII+ANyyNivd4fdhqiIT
 ihhN3nruOc0kJk+y1bjPAzfYq2rCJWrXoHKD7MgmbHp2ftMJI+0DBxpLwxpVbqgNc2Sk
 vyXvufPLz1Yl8UaUvCS/1rmp/7SokrCOPxfJNJZdWLecY2M2JWdNPeAR4NbVSpFpHUh9
 FOqvdrWVJLzVSg1KxjHpoAHEZ7GHZo0G7YI8ugXEFBvpyM0iuuDqNY0SBPANpI/QIEmt
 1h7w==
X-Gm-Message-State: AOJu0Yzu9IKpN6zcORBVFh/lkfHuL4pZu1gXFtPem/UKLopXMjW8TEVR
 1NmLF34mVDwS6U/nPm9vuvhNZgVV/c6Exj7Ev2Y=
X-Google-Smtp-Source: AGHT+IEArZgvyDxARKVvdtrPvxplGOfNm3zp51dQptRG5973ZEp4cSvTCm658WnIZa1GNTquSLMsqA==
X-Received: by 2002:a05:6000:4b:b0:32d:570b:c0a4 with SMTP id
 k11-20020a056000004b00b0032d570bc0a4mr6642862wrx.27.1698661285320; 
 Mon, 30 Oct 2023 03:21:25 -0700 (PDT)
Received: from m1x-phil.lan ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 bq22-20020a5d5a16000000b0032f7865a4c7sm5960703wrb.21.2023.10.30.03.21.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Oct 2023 03:21:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/i386: Only allow injecting MCE on x86 CPUs
Date: Mon, 30 Oct 2023 11:21:22 +0100
Message-ID: <20231030102122.67105-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

When using heterogeneous machines, we can try to inject a MCE on
a non-x86 CPU. Filter the CPU is injectable, otherwise display a
hint.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/monitor.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 6512846327..7ef540eda7 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -579,7 +579,6 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
 
 void hmp_mce(Monitor *mon, const QDict *qdict)
 {
-    X86CPU *cpu;
     CPUState *cs;
     int cpu_index = qdict_get_int(qdict, "cpu_index");
     int bank = qdict_get_int(qdict, "bank");
@@ -593,11 +592,17 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
         flags |= MCE_INJECT_BROADCAST;
     }
     cs = qemu_get_cpu(cpu_index);
-    if (cs != NULL) {
-        cpu = X86_CPU(cs);
-        cpu_x86_inject_mce(mon, cpu, bank, status, mcg_status, addr, misc,
-                           flags);
+    if (cs == NULL) {
+        monitor_printf(mon, "CPU #%d not found\n", cpu_index);
+        return;
     }
+    if (!object_dynamic_cast(OBJECT(cs), TYPE_X86_CPU)) {
+        monitor_printf(mon, "Can only inject MCE on x86 CPU (CPU #%d is %s)\n",
+                            cpu_index, object_get_typename(OBJECT(cs)));
+        return;
+    }
+    cpu_x86_inject_mce(mon, X86_CPU(cs), bank, status, mcg_status, addr, misc,
+                       flags);
 }
 
 static target_long monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
-- 
2.41.0


