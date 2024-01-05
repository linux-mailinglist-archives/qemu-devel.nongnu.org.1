Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0E882570F
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:49:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmPN-0003j0-Ct; Fri, 05 Jan 2024 10:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmOa-0001iO-P6
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:46:06 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmOU-0003mg-Tu
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:46:01 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3367632ce7bso1226428f8f.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469549; x=1705074349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3jkeu47vffO/ERd6kLypsT3czQKlKT7aS4JG6Pky2DY=;
 b=h9EycmOGdrNO5rvwWd01oYWHv05fzv3TQOZuWVJE4irUf8D6knzOusi9vZM65kRooH
 BEm9jur62/mXsreihLsy0Ttwdqcp6z8LIde3lXEc6xdDoz/dJhY32YF4Yx1slTjbfU/y
 XD3f1tVWwy3d+lsa3TQD0TtFURSS4fvcSiW6s6TvHWtpQfgghuaCSAoCYOmBNKht3aDc
 HbttmLSi7tlKkplwsxdxnnhu8F/YZ8CS08Tea+Pwx49ZGs9oHyd0WCxZVjeKYSuGPluZ
 eZS8RDARtOWdy8jD9QopSseYJuZWLC0lSd3ghyYrIZM1d0AYuvJTLPHdmMbO6/Sj246l
 NDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469549; x=1705074349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3jkeu47vffO/ERd6kLypsT3czQKlKT7aS4JG6Pky2DY=;
 b=mnWQtfd3l/bvBpKqBVhyLknSEAZPiqCju0tgYiqSuI12Xk5QMNE0TMRQARSgZEMZw+
 oAWH+LXKsmVieIFog6Dj/rh+hTYQ8sI+JhBvIwT/vSf7vTjRQAPBqMqHPp8UF6CklAj5
 wfxKID5wiasSXfhl/QMRYhmeuQxeEi/Lraaenxwt+SbFlqXbFafpRjRM1MACiWBpWYi9
 RvrLJ9CFOB1Os/MBXyjTHOy1xJ9XN5+XspbeJTLoNG8dJIfNKI/2FlwTOnobb5b+Vh5/
 uXOk/70PykpNsAyc+lztUomkBYWZNh9Ck38Apm3b40hO5ZrwH7n4MoQD3ve9KqQC9JnQ
 bGlg==
X-Gm-Message-State: AOJu0Yy5m2FNcFjoy/RwZn9vaRL9cLL7I6ALsYH7Noz78XH3Lk4rwU5s
 vWZ3mbs5a88I3tCrkLta8Hl9KpsNcW5FUTC+Sqok4rs1z1A=
X-Google-Smtp-Source: AGHT+IEYAvOKmZbGFZqgZ8JX8GTX59rCOn9IIqs3TPU4/SxaUYqyvkZImfDIkP70g1JHlRCNwNu+ow==
X-Received: by 2002:a5d:5227:0:b0:337:5588:801f with SMTP id
 i7-20020a5d5227000000b003375588801fmr1201012wra.57.1704469549409; 
 Fri, 05 Jan 2024 07:45:49 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 d7-20020adfe2c7000000b00336d24b4847sm1592885wrj.114.2024.01.05.07.45.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:45:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 23/71] hw/core: Add machine_class_default_cpu_type()
Date: Fri,  5 Jan 2024 16:42:16 +0100
Message-ID: <20240105154307.21385-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Add a helper to return a machine default CPU type.

If this machine is restricted to a single CPU type,
use it as default, obviously.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231116163726.28952-1-philmd@linaro.org>
---
 include/hw/boards.h | 6 ++++++
 hw/core/machine.c   | 8 ++++++++
 system/vl.c         | 2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 8af165f4dc..bcfde8a84d 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -24,6 +24,12 @@ OBJECT_DECLARE_TYPE(MachineState, MachineClass, MACHINE)
 
 extern MachineState *current_machine;
 
+/**
+ * machine_class_default_cpu_type: Return the machine default CPU type.
+ * @mc: Machine class
+ */
+const char *machine_class_default_cpu_type(MachineClass *mc);
+
 void machine_add_audiodev_property(MachineClass *mc);
 void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp);
 bool machine_usb(MachineState *machine);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2699bcba53..0198b54b39 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1390,6 +1390,14 @@ out:
     return r;
 }
 
+const char *machine_class_default_cpu_type(MachineClass *mc)
+{
+    if (mc->valid_cpu_types && !mc->valid_cpu_types[1]) {
+        /* Only a single CPU type allowed: use it as default. */
+        return mc->valid_cpu_types[0];
+    }
+    return mc->default_cpu_type;
+}
 
 void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp)
 {
diff --git a/system/vl.c b/system/vl.c
index 6b87bfa32c..fbdf8bd55a 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3737,7 +3737,7 @@ void qemu_init(int argc, char **argv)
     migration_object_init();
 
     /* parse features once if machine provides default cpu_type */
-    current_machine->cpu_type = machine_class->default_cpu_type;
+    current_machine->cpu_type = machine_class_default_cpu_type(machine_class);
     if (cpu_option) {
         current_machine->cpu_type = parse_cpu_option(cpu_option);
     }
-- 
2.41.0


