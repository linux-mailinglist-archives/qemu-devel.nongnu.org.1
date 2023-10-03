Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 986FB7B690B
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:32:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qneZ0-0001XY-UL; Tue, 03 Oct 2023 08:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qneYU-0000h0-3E
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:31:21 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qneYP-0007lH-Vw
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:31:13 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3231dff4343so514021f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 05:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696336261; x=1696941061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ng85okrWO1D5JYqF8LxeoCeovtEEGpWasH+P/ldXs4E=;
 b=pjMIQHUi6MWmJfqbfaU11suCBlsFABo58l+uaKqrU1/nLN1jcYlccD9PXEJ1xBbqBN
 1oQyl6SqatLMeSbhgRPClrOlWqTRKJz40fm0FKkETf+o4m3SDsJJxCtAs2n94fNj5Drp
 lr6tedmoRgSGbBVNh64rQaQbDg7YUMN0VMYC9QUwo1H5SlT0kd7iRwwNdb4M1FRyCe/0
 JnmpifPR63NEIoXASi5MncqeYL6Ji2/2Iy/y0Or0Rf7O6WioDuN5qyLM6F44fgKkcbQC
 i8SBwI/GGUVKz29JznOpcPRyZ85hHVx9wlk5gHru5kUC+1HgViPKXI1IBOUYhKHRxCos
 ZIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696336261; x=1696941061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ng85okrWO1D5JYqF8LxeoCeovtEEGpWasH+P/ldXs4E=;
 b=S+Gbtb+YhLkNjLXFTv/FEIFq1vBjQCPOWD7bAtSlRKaFxTlFEe7Mjdk7IRiePDU232
 w44ksfCNeQUkGVzrQROyZt1rJM0plSpdsHlehXZafHhwmm36/YUsy2MLaJjKHlzyzMxc
 UAl/JQnVxjK3k+iwhOXvCUbiMxuP0hWe1aQ5Q+o5tH9Oymn6lUs5FGSVRDrpXMOcRALJ
 c7mQ7cU5KnmCzqi0IgJUqS0aqGdJMNt+xxeiZiLoq+kAeMIQI2AJOgCJ6e/TP3THQvVT
 kCUk+PVHZdLA7XagpKkPd7hHhoFx+ixftJMoCRuOZ+StTyJ2VuSW3HzZe5lx8ZfTvUyB
 EfDQ==
X-Gm-Message-State: AOJu0YxL+5JloEnYEZHZx5WAGjwZ4SO6ExnK93i7nKKoXTxS6N0rPva5
 RW/sg3M7XaxU6+6mzxLafZ1O6cAfsJpf3wwqXzFmFg==
X-Google-Smtp-Source: AGHT+IFSCFREFPhFrsIUBRMw43PEOKH8JJmdGJKi759Gs6/x70jH8Kzl+IQNSQVo5P0jTRrSQFmORg==
X-Received: by 2002:adf:e806:0:b0:31f:fa48:2056 with SMTP id
 o6-20020adfe806000000b0031ffa482056mr1881057wrm.27.1696336261304; 
 Tue, 03 Oct 2023 05:31:01 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-246.abo.bbox.fr. [176.131.222.246])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a5d6806000000b003196b1bb528sm1483694wru.64.2023.10.03.05.30.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Oct 2023 05:31:00 -0700 (PDT)
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
Subject: [PATCH v2 5/7] accel: Declare AccelClass::cpu_common_[un]realize()
 handlers
Date: Tue,  3 Oct 2023 14:30:23 +0200
Message-ID: <20231003123026.99229-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003123026.99229-1-philmd@linaro.org>
References: <20231003123026.99229-1-philmd@linaro.org>
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
realization. Introduce the cpu_common_[un]realize fields in
the base AccelClass to be able to perform target-agnostic
[un]realization of vCPUs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/accel.h |  2 ++
 accel/accel-common.c | 21 +++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 446153b145..972a849a2b 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -43,6 +43,8 @@ typedef struct AccelClass {
     bool (*has_memory)(MachineState *ms, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
 #endif
+    bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
+    void (*cpu_common_unrealize)(CPUState *cpu);
 
     /* gdbstub related hooks */
     int (*gdbstub_supported_sstep_flags)(void);
diff --git a/accel/accel-common.c b/accel/accel-common.c
index e9548eac29..11d74b4ad7 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -122,15 +122,32 @@ void accel_cpu_instance_init(CPUState *cpu)
 bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
 
-    if (cc->accel_cpu && cc->accel_cpu->cpu_target_realize) {
-        return cc->accel_cpu->cpu_target_realize(cpu, errp);
+    /* target specific realization */
+    if (cc->accel_cpu && cc->accel_cpu->cpu_target_realize
+        && !cc->accel_cpu->cpu_target_realize(cpu, errp)) {
+        return false;
     }
+
+    /* generic realization */
+    if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
+        return false;
+    }
+
     return true;
 }
 
 void accel_cpu_common_unrealize(CPUState *cpu)
 {
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+
+    /* generic unrealization */
+    if (acc->cpu_common_unrealize) {
+        acc->cpu_common_unrealize(cpu);
+    }
 }
 
 int accel_supported_gdbstub_sstep_flags(void)
-- 
2.41.0


