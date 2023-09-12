Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E16EF79C76E
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 09:01:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxM4-0000UK-HE; Tue, 12 Sep 2023 02:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxM1-0000QT-HB
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:58:33 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxLy-0007UW-SQ
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:58:33 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-26d49cf1811so3515425a91.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 23:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694501910; x=1695106710;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0ux6zXnF8QbZYj0sOR52aBDTFuqL60bkneT20E5OaM=;
 b=p6XN0WYp9vAh5uCE07mlBWyW0Gx5HFG3LD0fvxsT6ZqzYdur2WnBtYWnHSwx5OC7xm
 qqzXGwJcn1FL1dRjBN26YofU+G1kJvCklOpZcJ10spz+zfocg44RzCjYNIodzEuFFyNd
 6yBMyD7ixS+tNQDLi9flyxHcnNbEJCYp4439BtFFtkgiHv85/jBdK5U1EWf3pi1zXuZ5
 +f+iI8XzNZFFXCsaTKd9tNK5t0svLENz1ffxl3snvgqaZuUqEN+ODkJ96r3oUzA10K5R
 cWz6JVEaqz35v5hNiU3pYU0LOY3ltpGz7QBFPA+RYYGg8cW25eWbPk3DSBX1iiWp1eGC
 w8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694501910; x=1695106710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0ux6zXnF8QbZYj0sOR52aBDTFuqL60bkneT20E5OaM=;
 b=pw2gYS3b7eVAX2x16jkByN9gyEpCi7UeEZ4WSTtFoDkePz1vp/hopp1fAkYs2AdvH1
 LkcDmi0aWPSImHTv0nhG5djO6iIjmtlAmAISufubHV6JjjnM14ckcZoA6Ak6T0527cD8
 3gMCYH/g1Kj2u+uFjuCr1cQB1Lz8UMK2IvIV6M0yPAFqk0QEVrh34NKkNdSWcvsus6gp
 kYede8eBKxE/nNezKiIY4mh7UI3YONQc7t3QYYeYxnIrXBerBpdczA4MOSCCqFlxoJCA
 gPHwYJdK9u74Mu9CtK7uuE4kbVTF3Yw3U0fqLSPeAHXnuLVIQia7anAnjRZwg90Fu2Ac
 rL3A==
X-Gm-Message-State: AOJu0YwayRExKpWL6XugwQjzdwGeT1cO65S0KjyVyyinVnHnEcgckhgx
 TtdZYllL/6RYIfvcd3oFchKd0Q==
X-Google-Smtp-Source: AGHT+IE9BmXdH2WuD83XTg3yQOLtHh+/54bugNv/vjSDhlSJPZa/LsXSxhUA9w90AtnU/ar34m6nNA==
X-Received: by 2002:a17:90b:150:b0:273:d42e:50f5 with SMTP id
 em16-20020a17090b015000b00273d42e50f5mr9743278pjb.46.1694501909795; 
 Mon, 11 Sep 2023 23:58:29 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a17090a2ac800b002696aeb72e5sm9315058pjg.2.2023.09.11.23.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:58:29 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH v2 05/11] target/arm: Move the reference to arm-core.xml
Date: Tue, 12 Sep 2023 15:58:00 +0900
Message-ID: <20230912065811.27796-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912065811.27796-1-akihiko.odaki@daynix.com>
References: <20230912065811.27796-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1033.google.com
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


