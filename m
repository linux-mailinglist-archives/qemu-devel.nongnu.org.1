Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCDA7A32A9
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:43:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd3u-0007TN-PA; Sat, 16 Sep 2023 17:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd3D-0005Ey-DS
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:42:04 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd3B-0000Wl-Hi
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:42:03 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1d643db2c98so1640346fac.0
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900520; x=1695505320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9frgVbpvR/cKhB4Eeaz6aEQy82XBehF08OdWl52rupE=;
 b=Yo3+1zJb4yxuZE9XIRgHbZuTIgu5F67ksKyYPS4JT8QZjMKSuI06v9vQjjKCXFbht1
 yiGOY8D9Ct4kaHOtK+1j6Qr0x4zLbzkRMjqQd0TdqCLL1ktoFOgpqTPbt5QzxaOhe8ni
 g3unY/McDRCAZ+tlGgTmVJ3NQ3UdXTddbEP4JLTowZYGNCxwC8SK6ttmYCnXtx2W8+nd
 zZLctXIsd27I8jw7EdxL8zurSfVa+gM7FOlvZh2Dg4c2IwuqnI64lkENlw3O/ATDaYr4
 H0rZPFr1nVfcrBpdE6R+RBgpjpEvEDDuD6e2zMZqgytnHOLUrWdEhkoDz3Y9JfNBa68/
 A37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900520; x=1695505320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9frgVbpvR/cKhB4Eeaz6aEQy82XBehF08OdWl52rupE=;
 b=A00EiEfXHQJ4L5T5UXlaX8ZEiEVT3hewd8Srh3U45uUFJvfBpxoszj8F1tmI5SKZhy
 7pLWstBqPQOpInMc+4ESuyY1rFB98fN4WDPsvZ8RRJO+Cxkw+ZjTJxTfSPNJ6egX1ZzU
 BxU8yO4y/+/Xla7G+d+z63H2tBU4/YdzR7r6IH+ZEkQpcllwF7XPDFr75e1XtB5i8XxY
 8PufjsBT9TckEpbHqjZB/j777zK4fqpoMVs6OO58QYxQiao8SZN3mSMkHvDHQw21ormg
 pmWst9m8Oul5Cv2iajHdq84dOm8UkmKaYtzaYhzu59JrDa+6/h7JHzrr9Wa+wIiDLLm3
 n48A==
X-Gm-Message-State: AOJu0YwnA6NmS9WHmf3t+Pw0//nA3Kak+/s07Q+OyXlhEgmLFCLEoJlv
 nknArHomCX7CHclKn20EoMdcTGZDa2B0w6lJkkc=
X-Google-Smtp-Source: AGHT+IHJ4nSrLQNu9jUVJlvLbnLxH+GklS/R7rjqp3RhIPkf6woyNEbUVBvgzU/eEDwxJMQWmtevXQ==
X-Received: by 2002:a05:6870:95aa:b0:1ba:d044:8a4 with SMTP id
 k42-20020a05687095aa00b001bad04408a4mr6774135oao.18.1694900519795; 
 Sat, 16 Sep 2023 14:41:59 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 37/39] accel: Declare AccelClass::[un]realize_cpu() handlers
Date: Sat, 16 Sep 2023 14:41:21 -0700
Message-Id: <20230916214123.525796-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Currently accel_cpu_realize() only performs target-specific
realization. Introduce the [un]realize_cpu fields in the
base AccelClass to be able to perform target-agnostic
[un]realization of vCPUs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230915190009.68404-4-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/accel.h |  2 ++
 accel/accel-target.c | 21 +++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 7b02cb40e5..0b6031bd82 100644
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
diff --git a/accel/accel-target.c b/accel/accel-target.c
index cc3a45e663..6d427f2b9d 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
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
2.34.1


