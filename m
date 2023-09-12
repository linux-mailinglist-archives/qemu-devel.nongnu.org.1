Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB6379DC02
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgC4b-0002ZS-UY; Tue, 12 Sep 2023 18:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4Z-0002Uo-OB
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:31 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4W-00018T-IZ
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:31 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c09673b006so42995275ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694558487; x=1695163287;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0ux6zXnF8QbZYj0sOR52aBDTFuqL60bkneT20E5OaM=;
 b=Zcqi3TVsPwqKUD3MRT81zC5q0rPWrrq4Q9V/5f033HgYcECyKzB9BPOEn2ctZmulNm
 xwLBJwJE24yM78U94sRciNPty80ucup94vYKE/bwVnXdvqM02twwjfO5i8hDuybpWeTn
 f5B6E9cjGdCjJSRFOxmy3/ulHs8MVBxEQjqEHi4xEbpO0Vqy3ziWqrlwP6lb9wtjssQ7
 hea+CMt5sMm861F+jBng9zEfdIX1krgTPCEMqJshtT0OPM5SGwYGjHX5fD2gimyp7REG
 s3qiDEFb24rB7IJYzPARH3nMl6QSpr1rNIU3ohCp2UxUfzjd3Wcwsnauf1d8qsU6xUAb
 vHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694558487; x=1695163287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0ux6zXnF8QbZYj0sOR52aBDTFuqL60bkneT20E5OaM=;
 b=tRqQ80GD0aZMHY4Ha9xGqIl3tPMB7bzV7cJP84lOOWXmJCgCv/1GK7YkaC4UHiud1u
 vhOWePwiY2y1YClTSt+LmNIzavLDPwuluFId/YI9vl3AYfIxsp7WBaTxXX4r24jAu++W
 lFYcmFxXAJOfFF2WakU+mkKa6OldnPqKjVs6oOt76wpFImQGrC0k7M6jEZANSui0q1IA
 S4B0GnQyJSZk5m9pQ8QU5vmEMaU4htuvJxEtJIh6DvzF8l1id4c0zZP99PhcU2QQ7F8/
 QTJUmgiEHSvmAHi++Cy5TzQKFDElYZzUPYWyklsxQ5p1g2SYNpplahmLDVhl+Jw98h+z
 ssSw==
X-Gm-Message-State: AOJu0YzSptFCQrkH2tCtFPa0vC9Lnb4OftDGgJ7f8OXfrQnHxI1/E9Pm
 66XFKxTs5sM+Zj/EXjoZTgvIdA==
X-Google-Smtp-Source: AGHT+IF1JHr2yhceeRbbHBmXUjE1ZbMqi5N8MdlStT9aWvV7Aot386QLD+UHRoYKWUfWWubhMd/t5w==
X-Received: by 2002:a17:903:22c9:b0:1c0:9d6f:9d28 with SMTP id
 y9-20020a17090322c900b001c09d6f9d28mr1356064plg.11.1694558487322; 
 Tue, 12 Sep 2023 15:41:27 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a170902d34d00b001bbbc655ca1sm8996977plk.219.2023.09.12.15.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:41:27 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH v3 06/12] target/arm: Move the reference to arm-core.xml
Date: Wed, 13 Sep 2023 07:40:55 +0900
Message-ID: <20230912224107.29669-7-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912224107.29669-1-akihiko.odaki@daynix.com>
References: <20230912224107.29669-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Some subclasses overwrite gdb_core_xml_file member but others don't.
Always initialize the member in the subclasses for consistency.

This especially helps for AArch64; in a following change, the file
specified by gdb_core_xml_file is always looked up even if it's going to
be overwritten later. Looking up arm-core.xml results in an error as
it will not be embedded in the AArch64 build.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 0bb0585441..6ff6ff2d55 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2389,7 +2389,6 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->sysemu_ops = &arm_sysemu_ops;
 #endif
     cc->gdb_num_core_regs = 26;
-    cc->gdb_core_xml_file = "arm-core.xml";
     cc->gdb_arch_name = arm_gdb_arch_name;
     cc->gdb_get_dynamic_xml = arm_gdb_get_dynamic_xml;
     cc->gdb_stop_before_watchpoint = true;
@@ -2411,8 +2410,10 @@ static void arm_cpu_instance_init(Object *obj)
 static void cpu_register_class_init(ObjectClass *oc, void *data)
 {
     ARMCPUClass *acc = ARM_CPU_CLASS(oc);
+    CPUClass *cc = CPU_CLASS(acc);
 
     acc->info = data;
+    cc->gdb_core_xml_file = "arm-core.xml";
 }
 
 void arm_cpu_register(const ARMCPUInfo *info)
-- 
2.42.0


