Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E18E97B7007
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:38:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjF6-0008Su-1o; Tue, 03 Oct 2023 13:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEe-0008FS-DG
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:07 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEa-0007Rn-UY
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:02 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-57bc2c2f13dso669465eaf.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354260; x=1696959060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gUAwLRvxIzeEWVzqxsRkBR/uxMwVWvXQ9DoS+Fr60wM=;
 b=e21IVnMg0okc4PSxMzV/oQikpKtwsCaw6sFGtgfRmIKXzJI6XQVeg07WYf6rTjdJGS
 kiM3s4V+2lHymiq0H5ftVojbWwAx2TzZLsdkT4VW0yBu6jAhvAliZGCwIqMNGrzdeO/z
 hV5TxmpG+MO94uU+J1VNCWwRwNFPit1rTDBYcM1fzxH/E+2QYs+b8NqHmztgc3gr1oJT
 2hZ+hzSbDLtjEc4Yj6NDu1nAEV+gk6Ljsap5KyyJZnNE0kYOLYMnZHQ8jzzKhUUCQGbJ
 Mohh4QsXfFBT+ZteBuKjCxQyBorXRH3FRpzZTANwsgDfWRz15Njz+ZZP7PSmeyEz+xqK
 KIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354260; x=1696959060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gUAwLRvxIzeEWVzqxsRkBR/uxMwVWvXQ9DoS+Fr60wM=;
 b=lUlTx8dOVXn4za51cI9UAfEngr3qcN/NlJSYsLER/qCeMe+oWHfLun6hX8uCdwp6Qm
 ioYrmJkm5/p6r3Vbzs/o/0dF4YoJXcSmz3G0mQnhNIDGzCPFu0N32Uyzfh9TbP9gvQ2Z
 tx2P+lmhkVdPJRLyKs75x2vTPCetDcWhNCCCdVIkSDLqv8MYr8cC0BlmZYUQU+fF6iMF
 Vfl6XxyVYCFt8PT3R/JLUHE7FDC78Uc10/Ns4mjWNTZVOpG0xpRuZzrLkgU4IIXgZ/4z
 LKDRxAgoWAQCbdXVqrTSAtMBHaG/Gj4OW8iQuPo6i9zTei/YT5RQ6QXnLA08ZXRTOJNS
 LqNg==
X-Gm-Message-State: AOJu0YwYncHTaq6wC+2ELlTHsBUwRIQPyo94nmys+dBnblZWe6cJgZR9
 MOqKfv5pm0mQYrP31146RQbPOIKBSntqY7ATx/Q=
X-Google-Smtp-Source: AGHT+IEmB3dlfvQSVc0UgbKcsWB7ZD/Hgw1h56dbTmzljBckA+21aalZWE02ODf7VKPQSdFg1u+mcw==
X-Received: by 2002:a05:6358:419c:b0:141:ca1:cc62 with SMTP id
 w28-20020a056358419c00b001410ca1cc62mr99572rwc.27.1696354259720; 
 Tue, 03 Oct 2023 10:30:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:30:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/47] accel: Declare AccelClass::cpu_common_[un]realize()
 handlers
Date: Tue,  3 Oct 2023 10:30:10 -0700
Message-Id: <20231003173052.1601813-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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
realization. Introduce the cpu_common_[un]realize fields in
the base AccelClass to be able to perform target-agnostic
[un]realization of vCPUs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231003123026.99229-6-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.34.1


