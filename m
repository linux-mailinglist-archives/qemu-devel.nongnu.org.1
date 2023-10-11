Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA82C7C503D
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:34:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWXM-0001dG-0v; Wed, 11 Oct 2023 06:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWXA-0001MY-0s
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:45 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX5-0005GC-VA
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:43 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4054f790190so65569015e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697020418; x=1697625218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tXzt6XTvV2zpelaBYxfVQmisWGRyjvu/qrEXej/hrKQ=;
 b=zbVG5kHGdfSek5yoWVOYYwRrrWl9fMYexV9XCZrpRSXSZEpmjms14VqwlX8KRUCKMz
 BLZ7uHA9468GPEUpv2tAfwKk/nDgINEKY750O7uaz5y7KbBq211ZlpiyYKbXV5YENcuP
 mv5axBxAFg0rLqIbeE5Vrqe1CLdeEf9B5PhAzBaK8BrcSfAS8+RsxbLo4k5xJ/uORhwG
 TDOPIaxID0tfmhVnwWxkLWehCTeDAZnz49IURSB7vUi+84w4c64gRiunKfkiEaRCpw5U
 Fm+Zi7GO8dAw8pdhp7aswhmfPh4LFducAGzKR9toKlja6iwl5IuMhvDwHHHiMrAP1zUQ
 1Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697020418; x=1697625218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tXzt6XTvV2zpelaBYxfVQmisWGRyjvu/qrEXej/hrKQ=;
 b=R4Kl9AxE/8Lr7J0Dms1HRaGvS2AFzH6ozemB/aM+v642/AMO96/3uIR9Ys9aSShVgA
 m2oCkRac/pO0m+69LVzO3tPFUh1W1niuv4XaKC/nnMYPFQ9o4IE+wewA8oG4HphlWzLY
 IWkNEzZEemA0OUyiwOK0cReysPY7zTA+H1DXrlTpJOxunUuVHaOx3wsM9aBL/fZ454QO
 n50h8hB3dcHj4uqSuzpvwwlQIzzNlVW8ns8OQ4HC+CzA19bsoauICfwfs4Gqux2EWxGG
 URQbQoxVkBcp9ZBXJZafPIL8aNfNNAOromfVhPUtmOEj4LJCnT/2mFY3q0Wcsfkwxtn5
 h+Qw==
X-Gm-Message-State: AOJu0Yyx1GXpAkYGfYSpN/zgqvyh0BI6Uh8X2hZa1R9WpbTxI+wXNBBm
 Sd+AvexE6lfksuycILHUPNgWag==
X-Google-Smtp-Source: AGHT+IGZXo5PcBJpEYNVekjkJsyYaRe/aQ2hywZk2b6aI2Zjxwo2FCn/eLTyrFVsXEBAogpjd9Ms/w==
X-Received: by 2002:a05:600c:2211:b0:402:fec4:fddc with SMTP id
 z17-20020a05600c221100b00402fec4fddcmr18291721wml.17.1697020418034; 
 Wed, 11 Oct 2023 03:33:38 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a05600c290200b004063d8b43e7sm18722043wmd.48.2023.10.11.03.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:33:35 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8B65A1FFC5;
 Wed, 11 Oct 2023 11:33:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 13/25] target/arm: Move the reference to arm-core.xml
Date: Wed, 11 Oct 2023 11:33:17 +0100
Message-Id: <20231011103329.670525-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Some subclasses overwrite gdb_core_xml_file member but others don't.
Always initialize the member in the subclasses for consistency.

This especially helps for AArch64; in a following change, the file
specified by gdb_core_xml_file is always looked up even if it's going to
be overwritten later. Looking up arm-core.xml results in an error as
it will not be embedded in the AArch64 build.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230912224107.29669-7-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009164104.369749-14-alex.bennee@linaro.org>

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 831295d7cd..b65e8cfea3 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2392,7 +2392,6 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->sysemu_ops = &arm_sysemu_ops;
 #endif
     cc->gdb_num_core_regs = 26;
-    cc->gdb_core_xml_file = "arm-core.xml";
     cc->gdb_arch_name = arm_gdb_arch_name;
     cc->gdb_get_dynamic_xml = arm_gdb_get_dynamic_xml;
     cc->gdb_stop_before_watchpoint = true;
@@ -2414,8 +2413,10 @@ static void arm_cpu_instance_init(Object *obj)
 static void cpu_register_class_init(ObjectClass *oc, void *data)
 {
     ARMCPUClass *acc = ARM_CPU_CLASS(oc);
+    CPUClass *cc = CPU_CLASS(acc);
 
     acc->info = data;
+    cc->gdb_core_xml_file = "arm-core.xml";
 }
 
 void arm_cpu_register(const ARMCPUInfo *info)
-- 
2.39.2


