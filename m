Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A257A26CE
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 21:01:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhE3a-0005rO-3E; Fri, 15 Sep 2023 15:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhE3R-0005nC-Kk
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 15:00:37 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhE3N-0007a6-To
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 15:00:36 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9a645e54806so302825666b.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 12:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694804432; x=1695409232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDSY0XDObgkxUL7brWiUxnx3rvK0ibvXtjHunMwb0Ko=;
 b=TB8etVMhsM+4J4V2UVXxXPjrrXg4yXqt2v28ZznHuJ4DfAxUknz09wn7xBVbSn9Lv8
 WtgdM3ggP1CYorgtkH+uhqACmZjf4oAYg6U+25ZA62gEmUOdyHdQJd5Qoi061m3Bw09C
 3Ce9ISdU5sPdgjhiTpi6ZDAH1pLbmdQv6aEiKTOOkCWxyJx+a74sSh1Yw2b5a+nwl1wU
 sDSnUOlEulL9TavjUGZgETffQXPLxfxOr+drl1yGjQmz3PoUrD8AjybkOCmEF5U5NLsb
 m7QyFwNqEELCc/+skgLfQ/hrEdzWSuYOhLDfh4KBamA5RgC/1aXCqeCNWNIXYPUtSBPF
 c4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694804432; x=1695409232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDSY0XDObgkxUL7brWiUxnx3rvK0ibvXtjHunMwb0Ko=;
 b=OMJlpA9dAfaMAhh5X+kzd7H/ZnGUX+k2S1OwZuUZ/clAWVF0TIXe+A2iM2UhQxPpHw
 3M3SPOqwGTz26Itynd/3XYPbl19jL/0pEDhX0Vf409AiLuzsMgw1VAxEegIRcsohHDRC
 XnzIB1qVnLmnKFCwhPCv0PcM6kGUCxAlb5/DZ69ETA88ulcKXZq/IAxm6qJ7vyjaNO8R
 9mL3Kwthx4ytjqzmEUY6ocmJma9DbojPyxANnBV7Z59HPhFepehdA3RhK13cfDJQC8sG
 4u3AEmUQpuE1ElgZRXO6k5/KfC2kuJ1G86Mm5Zb6J8twYJtAjJje9FeDbfg6a7bJZFyF
 P/2Q==
X-Gm-Message-State: AOJu0Yy4u7QdV8LpMBnM64reggdUmxlSURxp8kY5TpomejQpNf88DY7v
 X4od96BxPQS3nzPC8AZpNmq3e1y2QOtpNU2NrA8=
X-Google-Smtp-Source: AGHT+IGEP/lvi8q3j5fpuCxcqNS187PK1L6ySZKuoqbnVy4D7JQSt+RyvvPIVtxvhOTk4XTqtPcS7g==
X-Received: by 2002:a17:906:76cc:b0:9a1:ddb9:654f with SMTP id
 q12-20020a17090676cc00b009a1ddb9654fmr1957052ejn.55.1694804432309; 
 Fri, 15 Sep 2023 12:00:32 -0700 (PDT)
Received: from m1x-phil.lan (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr.
 [176.171.209.234]) by smtp.gmail.com with ESMTPSA id
 lg13-20020a170906f88d00b009828e26e519sm2750934ejb.122.2023.09.15.12.00.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Sep 2023 12:00:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Marcelo Tosatti <mtosatti@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 3/5] accel: Declare AccelClass::[un]realize_cpu() handlers
Date: Fri, 15 Sep 2023 21:00:06 +0200
Message-ID: <20230915190009.68404-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915190009.68404-1-philmd@linaro.org>
References: <20230915190009.68404-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

Currently accel_cpu_realize() only performs target-specific
realization. Introduce the [un]realize_cpu fields in the
base AccelClass to be able to perform target-agnostic
[un]realization of vCPUs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/accel.h |  2 ++
 accel/accel-common.c | 21 +++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 23254c6c9c..7bd9907d2a 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -43,6 +43,8 @@ typedef struct AccelClass {
     bool (*has_memory)(MachineState *ms, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
 #endif
+    bool (*realize_cpu)(CPUState *cpu, Error **errp);
+    void (*unrealize_cpu)(CPUState *cpu);
 
     /* gdbstub related hooks */
     int (*gdbstub_supported_sstep_flags)(void);
diff --git a/accel/accel-common.c b/accel/accel-common.c
index cc3a45e663..6d427f2b9d 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -122,15 +122,32 @@ void accel_cpu_instance_init(CPUState *cpu)
 bool accel_cpu_realize(CPUState *cpu, Error **errp)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
 
-    if (cc->accel_cpu && cc->accel_cpu->cpu_realizefn) {
-        return cc->accel_cpu->cpu_realizefn(cpu, errp);
+    /* target specific realization */
+    if (cc->accel_cpu && cc->accel_cpu->cpu_realizefn
+        && !cc->accel_cpu->cpu_realizefn(cpu, errp)) {
+        return false;
     }
+
+    /* generic realization */
+    if (acc->realize_cpu && !acc->realize_cpu(cpu, errp)) {
+        return false;
+    }
+
     return true;
 }
 
 void accel_cpu_unrealize(CPUState *cpu)
 {
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+
+    /* generic unrealization */
+    if (acc->unrealize_cpu) {
+        acc->unrealize_cpu(cpu);
+    }
 }
 
 int accel_supported_gdbstub_sstep_flags(void)
-- 
2.41.0


